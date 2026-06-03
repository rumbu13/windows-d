module codegen.generator;

import std.algorithm.iteration : filter, map, splitter, uniq;
import std.algorithm.searching : any, canFind, commonPrefix, count, endsWith, find, startsWith;
import std.algorithm.sorting : sort;
import std.array : array, join, replace, split;
import std.container.rbtree : RedBlackTree;
import std.conv : to;
import std.exception : enforce;
import std.file : copy, mkdirRecurse;
import std.format : format;
import std.path : buildPath, dirName, dirSeparator;
import std.range : padLeft, chain;
import std.stdio;
import std.string : indexOf, lastIndexOf, strip;
import std.typecons : nullable, Nullable;
import std.uni : toLower;

import climetadata.mdcollection.attributeprops;
import climetadata.mdcollection.database;
import climetadata.mdcollection.entity;
import climetadata.mdcollection.entitytypes;
import climetadata.mdcollection.sigtnature;
import climetadata.utils.memcast;
import codegen.attributes.common;
import codegen.attributes.constant;
import codegen.attributes.flexiblearray;
import codegen.attributes.guid;
import codegen.attributes.native_encoding;
import codegen.attributes.native_bitfield;

// deb
import climetadata.mdcollection.compositeindex;

enum maxLineWidth = 120;
enum minSetTreshold = 0.4;
enum maxFieldAlignment = 20;
enum maxReturnTypeAlignment = 8;

public struct Generator
{
    @disable this();

    this(const Database *db,
        ref const string[] ignoredNamespaces,
        ref const string[string] configNamespace,
        string cfgCoreFileName,
        ref const string[string] safeWords,
        ref const bool[string] skipInterfaces,
        ref const bool[string] skipMethods,
        string outDirectory)
    {
        this.db = db;
        this.ignoredNamespaces = ignoredNamespaces.dup;
        this.configNamespace = configNamespace.dup;
        this.cfgCoreFileName = cfgCoreFileName;
        this.safeWords = safeWords.dup;
        this.skipInterfaces = skipInterfaces.dup;
        this.skipMethods = skipMethods.dup;
        this.outDirectory = outDirectory;
    }

    void generate()
    {
        auto namespaces = getNamespaces(db, ignoredNamespaces);

        writeln("Building dependency graph...");

        foreach(nestedClassRecord; db.nestedClassCollection.items())
        {
            auto child = nestedClassRecord.getNestedClass();
            auto parent = nestedClassRecord.getEnclosingClass();
            if (auto aa = parent in nestedMap)
            {
                (*aa)[child] = true;
            }
            else
            {
                auto aa = [child : true];
                nestedMap[parent] = aa;
            }
        }
        nestedMap.rehash();

        bool[string] nestedNamespaces;
        foreach(namespace; namespaces)
        {
            string[] nsParts = namespace.split(".");
            if (nsParts.length < 2)
            {
                continue;
            }
            foreach(n; 1 .. nsParts.length)
            {
                auto parentNamespace = nsParts[0 .. n];
                nestedNamespaces[parentNamespace.join(".")] = true;
            }
        }

        foreach(namespace; namespaces)
        {
            auto rb = new RedBlackTree!string();
            dependencies[namespace] = rb;

            foreach(type; getTypeDefs(db, namespace))
            {
                buildDependencies(type, namespace, rb);
            }
        }
        writeln("Building dependency graph done.");

        auto corePath = buildPath(outDirectory, "windows", "core.d");
        mkdirRecurse(dirName(corePath));
        copy(cfgCoreFileName, corePath);

        foreach(namespace; namespaces)
        {
            //if (!namespace.startsWith("Windows.Win32.System.Kernel")) continue;
            //if (namespace != "Windows.Win32.System.Diagnostics.Debug") continue;
            //if (namespace != "Windows.Win32.Foundation") continue;
            // if (namespace != "Windows.Win32.Media.Audio.DirectMusic") continue;

            string path = makePath(outDirectory, namespace, configNamespace, safeWords, nestedNamespaces) ~ ".d";
            string modName = makeModuleName(namespace, configNamespace, safeWords, nestedNamespaces);
            mkdirRecurse(dirName(path));

            auto f = std.stdio.File(path, "w");
            f.writeln("// Written in the D programming language.");
            f.writeln();
            f.writefln("module %s;", modName);
            f.writeln;
            writefln("Processing %s", namespace);
            f.writeln("public import windows.core;");

            writeImports(f, namespace, nestedNamespaces);
            dumpEnums(f, namespace, false /*docsDirectory.length > 0*/);
            dumpApisConstants(f, namespace, safeWords);
            dumpDelegates(f, namespace, false /*docsDirectory.length > 0*/);
            dumpStructs(f, namespace, false /*docsDirectory.length > 0*/);
            dumpApis(f, namespace, false /*docsDirectory.length > 0*/);
            dumpInterfaces(f, namespace, false /*docsDirectory.length > 0*/);
         }
    }

    private void buildDependencies(const TypeDefEntity type, string namespace, StringSet rb)
    {
        foreach(field; type.getFieldList())
        {
            auto dep = fullnameof(field.getSignature().typeSig.type);
            if (dep.fullName.length && dep.fullName[0] != '.' && dep.namespace != namespace)
            {
                rb.insert(dep.fullName);
            }
        }

        if (type in nestedMap)
        {
            foreach(nstruct; nestedMap[type].byKey)
            {
                buildDependencies(nstruct, namespace, rb);
            }
        }

        foreach(meth; type.getMethodList())
        {
            auto sig = meth.getSignature();

            auto dep = fullnameof(sig.retSig.typeSig.type);
            if (dep.fullName.length && dep.fullName[0] != '.' && dep.namespace != namespace)
            {
                rb.insert(dep.fullName);
            }

            foreach(par; sig.params)
            {
                dep = fullnameof(par.typeSig.type);
                if (dep.fullName.length && dep.fullName[0] != '.' && dep.namespace != namespace)
                {
                    rb.insert(dep.fullName);
                }
            }
        }

        foreach (interf; type.getInterfaces())
        {
            FullTypeName dep = fullnameof(interf.getInterface());

            if (namespace == "Windows.Win32.DirectShow" && dep.fullName == "Windows.Win32.Mmc.IComponent")
            {
                dep = FullTypeName("IComponent", "Windows.Win32.DirectShow", "Windows.Win32.DirectShow.IComponent");
            }
            else if (namespace == "Windows.Win32.Controls" && dep.fullName == "Windows.Win32.Mmc.IImageList")
            {
                dep = FullTypeName("IImageList", "Windows.Win32.Controls", "Windows.Win32.Controls.IImageList");
            }
            else if (namespace == "Windows.Win32.Mmc" && dep.fullName == "Windows.Win32.DirectShow.IComponent")
            {
                dep = FullTypeName("IComponent", "Windows.Win32.Mmc", "Windows.Win32.Mmc.IComponent");
            }

            if (dep.fullName.length && dep.fullName[0] != '.' && dep.namespace != namespace)
            {
                rb.insert(dep.fullName);   
            }
        }

        if (type.isValueType())
        {
            foreach(attr; type.getAttributes())
            {
                if (attr.name() == "RAIIFreeAttribute")
                {
                    auto fixed = attr.value().fixed[0];
                    auto element = fixed.value.get!ElementSig;
                    auto str = element.value.get!string;
                    foreach(t; db.typeDefCollection.items())
                    {
                        if (t.getTypeName() == "Apis")
                        {
                            foreach(m; t.getMethodList())
                            {
                                if (m.getName() == str)
                                {
                                    auto dep = t.getTypeNamespace() ~ '.' ~ m.getName();
                                    if (!dep.startsWith(namespace ~ '.'))
                                    {
                                        rb.insert(dep);
                                    }
                                    return;
                                }
                            }
                        }
                    }
                }
            }
        }

    }

    private void writeImports(scope ref File f, string namespace,
        scope ref const bool[string] nestedNamespaces)
    {
        auto imports = dependencies[namespace].array.filter!(a => !ignoredNamespaces.canFind(getNamespace(a))).array.sort;

        string lastNamespace;
        bool atLeastOne;
        ptrdiff_t w, v;
        foreach(i; imports)
        {
            auto n = getNamespace(i);
            auto importName = getName(i);

            // Guid implemented as GUID at windows.core
            if (n == "System" && importName == "Guid")
            {
                continue;
            }

            atLeastOne = true;

            if (n != lastNamespace)
            {
                if (lastNamespace.length)
                {
                    f.writeln(";");
                }
                auto moduleName = makeModuleName(n, configNamespace, safeWords, nestedNamespaces);
                f.writef("public import %s : %s", moduleName, importName);
                lastNamespace = n;
                w = 17 + moduleName.length + importName.length;
                v = w - importName.length;
            }
            else
            {
                if (importName.length + w > maxLineWidth - 3)
                {
                    f.writeln(",");                    
                    f.write("".padLeft(' ', v));
                    w = v;
                }
                else
                {
                    f.write(", ");
                }
                f.write(importName);
                w += importName.length + 2;
                w += importName.length + 2;
            }
        }
        if (atLeastOne)
        {
            f.writeln(";");
        }
        f.writeln;
        f.writeln("extern(Windows) @nogc nothrow:");
        f.writeln;
    }

    private void dumpEnums(scope ref std.stdio.File f, string namespace, bool docs = false)
    {
        auto enums = getEnums(db, namespace);
        if (enums.empty())
        {
            return;
        }

        bool[string] structNames;
        foreach(struc; getStructs(db, namespace))
        {
            structNames[struc.getTypeName()] = true;
        }

        dumpSectionHeader(f, "Enums");
        foreach(e; enums)
        {
            dumpEnum(f, e, structNames, docs);
        }
    }

    private void dumpEnum(scope ref std.stdio.File f, const ref TypeDefEntity e, scope ref const bool[string] structNames, bool docs = false)
    {
        f.writeln;

        auto enumAttrs = CommonAttributes(e.getAttributes());
        foreach(ca; enumAttrs.getUnhandledAttributes())
        {
            if (ca.name() == "FlagsAttribute")
            {
                //can't find any use
            }
            else
            {
                f.writefln("//ENUM ATTR: %s : %s", ca.name(), ca.value);
            }
        }

        f.dumpDocAttr(enumAttrs, 0);

        bool hasMembers = e.getFieldList().any!(f => !f.getFlags().hasRuntimeSpecialName);
        bool trueEnum = hasMembers && seemsLikeTrueEnum(e.getTypeName());
        size_t maxLen;
        foreach(fx; e.getFieldList())
        {
            if (fx.getName().length > maxLen)
            {
                maxLen = fx.getName().length;
            }
        }

        auto typeText = getEnumTypeText(e);

        // MDMatcher* doc = docs ? findDoc(e.name) : null;
        // f.writeln;
        // if (doc)
        //     dumpDocumentation(f, doc.description, 0);

        if (!trueEnum)
        {
            f.writefln("alias %s = %s;", e.getTypeName(), typeText);
            if (hasMembers)
            {
                f.writefln("enum : %s", typeText);
            }
        }
        else
        {
            f.writefln("enum %s : %s", e.getTypeName(), typeText);  
        }
        
        if (hasMembers)
        {
            f.writeln("{");
            foreach(fx; e.getFieldList())
            {
                auto name = fx.getName();
                if (!trueEnum && name in structNames)
                {
                    name ~= "_";
                }
                name = safeWords.get(name, name);

                if (!fx.getFlags().hasRuntimeSpecialName)
                {
                    // if (doc)
                    // {
                    //     auto fdoc = doc.fields.find!(a => a.name == name);
                    //     if (!fdoc.empty)
                    //         dumpDocumentation(f, fdoc.front.description, 1);
                    // }
                    f.write("".padLeft(' ', 4));
                    f.write(name);

                    if (fx.getFlags().isLiteral)
                    {
                        if (name.length < maxLen)
                            f.write("".padLeft(' ', maxLen - name.length));
                        auto ct = fx.getConstant();
                        if (!ct.isNull)
                        {
                            f.writef(" = ");
                            if (!trueEnum && typeText == "byte") f.write("cast(byte) ");
                            if (!trueEnum && typeText == "ubyte") f.write("cast(ubyte) ");
                            dumpConstant(f, ct.get.value, true);
                        }
                    }
                    f.writeln(",");
                }
            }   
            f.writeln("}");
        }
    }

    private void dumpConstant(scope ref std.stdio.File f, ConstantEntity.ConstantValue v, bool addCast)
    {
        import std.math.algebraic : abs;
        import std.math.traits : signbit, isInfinity, isNaN;

        if (auto s = v.peek!wstring)
        {
            auto escaped = (*s).replace("\\", "\\\\");
            escaped = escaped.replace("\"", "\\\"");
            escaped = escaped.replace("\0", "\\0");
            f.writef("\"%s\"", escaped);
        }
        else if (auto n = v.peek!(typeof(null)))
            f.write("null");
        else if (auto i = v.peek!int)
            f.writef("0x%08x", *i);
        else if (auto i = v.peek!uint)
            f.writef("0x%08xU", *i);
        else if (auto i = v.peek!short)
        {
            if (addCast) f.write("cast(short) ");
            f.writef("0x%04x", *i);
        }
        else if (auto i = v.peek!ushort)
        {
            if (addCast) f.write("cast(ushort) ");
            f.writef("0x%04x", *i);
        }
        else if (auto i = v.peek!byte)
            f.writef("0x%02x", *i);
        else if (auto i = v.peek!ubyte)
            f.writef("0x%02x", *i);
        else if (auto i = v.peek!long)
            f.writef("0x%016xL", *i);
        else if (auto i = v.peek!ulong)
            f.writef("0x%016xUL", *i);
        else if (auto i = v.peek!float)
        {
            if (signbit(*i))
                f.write("-");
            if (isNaN(*i))
                f.write("float.nan");
            else if (isInfinity(*i))
                f.write("float.infinity");
            else
                f.writef("%a", abs(*i));
        }
        else if (auto i = v.peek!double)
        {
            if (signbit(*i))
                f.write("-");
            if (isNaN(*i))
                f.write("double.nan");
            else if (isInfinity(*i))
                f.write("double.infinity");
            else
                f.writef("%a", abs(*i));
        }
        else
        {
            f.write(v);
        }
    }

    private void dumpApisConstants(scope ref std.stdio.File f, string namespace, scope ref const string[string] safeWords)
    {
        bool wasOne;
        auto apis = getApisClasses(db, namespace);

        if (apis.empty() || apis.front().getFieldList().empty())
        {
            return;
        }

        bool[string] structNames;
        foreach(struc; getStructs(db, namespace))
        {
            structNames[struc.getTypeName()] = true;
        }

        dumpSectionHeader(f, "Constants");
        FieldEntity[] flds;
        string lastTypeText;
        string lastField;
        bool mustReturn;

        foreach(fld; apis.front().getFieldList())
        {
            auto typeText = getTypeText(fld.getSignature().typeSig, safeWords);
            auto fieldName = fld.getName();

            if (!flds.length)
            {
                lastField = fld.getName();
                lastTypeText = typeText;
                flds ~= fld;
                continue;
            }

            if ((typeText == lastTypeText && lastField.length > 0 && commonPrefix(lastField, fieldName).length / cast(double)(lastField.length) > minSetTreshold))
            {
                lastField = fld.getName();
                lastTypeText = typeText;
                flds ~= fld;
                continue;
            }

            dumpConstFieldCollection(f, flds, wasOne, structNames);
            wasOne = flds.length == 1;

            lastField = fld.getName();
            lastTypeText = typeText;
            flds = [fld];
        }

        if (flds.length)
        {
            dumpConstFieldCollection(f, flds, wasOne, structNames);
        }
    }

    private void dumpConstFieldCollection(scope ref std.stdio.File f, scope ref const FieldEntity[] flds, bool wasOne, scope ref const bool[string] structNames)
    {
        // flds have the same type (see dumpApisConstants())
        auto sig = flds[0].getSignature().typeSig;
        bool isStruct = sig.type.peek!TypeRefEntity || sig.type.peek!TypeDefEntity;
        bool isGuidConst = flds[0].getCustomAttributes().canFind!(a => a.name() == "GuidAttribute");
        auto typeText = isGuidConst ? "GUID" : getFieldTypeText(flds[0], safeWords);
        if (isGuidConst)
        {
            isStruct = true;
        }
        auto isPropKey = typeText == "PROPERTYKEY" || typeText == "DEVPROPKEY";
        auto isSidIdAuth = typeText == "SID_IDENTIFIER_AUTHORITY";
        KnownConstantType constKnownType = KnownConstantType.UNKNOWN;
        if (isPropKey)
        {
            constKnownType = KnownConstantType.PROPERTYKEY;
        }
        if (isSidIdAuth)
        {
            constKnownType = KnownConstantType.SID_IDENTIFIER_AUTHORITY;
        }
        auto needPVoidCast = typeText == "HANDLE" || typeText == "HKEY" || typeText == "BCRYPT_ALG_HANDLE" 
            || typeText == "CONDITION_VARIABLE" || typeText == "SRWLOCK" || typeText == "INIT_ONCE" 
            || typeText == "DPI_AWARENESS_CONTEXT" || typeText == "HBITMAP" || typeText == "HWND";
        auto isPSTR = typeText == "PSTR";
        auto isPWSTR = typeText == "PWSTR";

        if (flds.length == 1)
        {
            if (!wasOne)
                f.writeln;

            auto fx = flds[0];
            auto fieldAttrs = CommonAttributes(fx.getCustomAttributes());
            auto guidAttribute = GuidAttribute(fieldAttrs.getUnhandledAttributes());
            auto constAttribute = ConstantAttribute(guidAttribute.getUnhandledAttributes(), constKnownType);
            auto nativeEncodingAttribute = NativeEncodingAttribute(constAttribute.getUnhandledAttributes());
            foreach(ca; nativeEncodingAttribute.getUnhandledAttributes())
            {
                f.writefln("//CONST ATTR: %s : %s", ca.name(), ca.value());
            }
            f.dumpDocAttr(fieldAttrs).dumpNativeEncodingAttr(nativeEncodingAttribute).dumpObsoleteAttr(fieldAttrs, 0);

            f.write("enum ");
            f.write(typeText);   
            f.write(" ");

            // Check conflict with struct names
            auto constName = fx.getName();
            if (constName in structNames)
            {
                constName ~= "_";
            }
            constName = safeWords.get(constName, constName);

            f.write(constName);
            f.write(" = ");
            if (isStruct)
            {
                f.write(typeText);
                f.write("(");
            }
            if (fx.getFlags().isLiteral())
            {
                assert(!fx.getConstant().isNull, "isLiteral() field must has not null Constant");
                if (needPVoidCast)
                    f.write("cast(void*) ");
                else if (isPSTR)
                    f.write("cast(ubyte*) ");
                else if (isPWSTR)
                    f.write("cast(wchar*) ");

                dumpConstant(f, fx.getConstant().get.value, isStruct && !(needPVoidCast || isPSTR || isPWSTR));
            }
            else
            {
                if (!guidAttribute.getGuid().isNull)
                {
                    f.writef("\"%s\"", guidAttribute.getGuid().get);
                }
                else if (constAttribute.getConstantValue().length != 0)
                {
                    if (needPVoidCast)
                        f.write("cast(void*) ");
                    f.write(constAttribute.getConstantValue());
                }
                else
                {
                    throw new Exception("Can't get initializer for struct constant");
                }
            }

            if (isStruct)
                f.write(")");
            f.writeln(";");
        }
        else
        {
            size_t maxLen;
            foreach(fx; flds)
            {
                if (fx.getName().length > maxLen)
                    maxLen = fx.getName().length;
            }

            f.writeln;
            f.write("enum : ");       
            f.writeln(typeText);
            f.writeln("{");
            foreach(fx; flds)
            {
                auto fieldAttrs = CommonAttributes(fx.getCustomAttributes());
                auto guidAttribute = GuidAttribute(fieldAttrs.getUnhandledAttributes());
                auto constAttribute = ConstantAttribute(guidAttribute.getUnhandledAttributes(),
                    isPropKey ? KnownConstantType.PROPERTYKEY : KnownConstantType.SID_IDENTIFIER_AUTHORITY);
                auto nativeEncodingAttribute = NativeEncodingAttribute(constAttribute.getUnhandledAttributes());
                foreach(ca; nativeEncodingAttribute.getUnhandledAttributes())
                {
                    f.write("".padLeft(' ', 4));
                    f.writefln("//CONST ATTR: %s : %s", ca.name(), ca.value());
                }
                f.dumpDocAttr(fieldAttrs, 1).dumpNativeEncodingAttr(nativeEncodingAttribute, 1).dumpObsoleteAttr(fieldAttrs, 1);

                f.write("".padLeft(' ', 4));
                auto constName = fx.getName();
                if (constName in structNames)
                {
                    constName ~= "_";
                }
                auto name = safeWords.get(constName, constName);

                f.write(name);
                if (name.length < maxLen)
                    f.write("".padLeft(' ', maxLen - name.length));
                f.write(" = ");
                if (isStruct)
                {
                    f.write(typeText);
                    f.write("(");                
                }

                if (fx.getFlags().isLiteral())
                {
                    assert(!fx.getConstant().isNull, "isLiteral() field must has not null Constant");
                    if (needPVoidCast)
                        f.write("cast(void*) ");
                    else if (isPSTR)
                        f.write("cast(ubyte*) ");
                    else if (isPWSTR)
                        f.write("cast(wchar*) ");

                    dumpConstant(f, fx.getConstant().get.value, isStruct && !(needPVoidCast || isPSTR || isPWSTR));
                }
                else
                {
                    if (!guidAttribute.getGuid().isNull)
                    {
                        f.writef("\"%s\"", guidAttribute.getGuid().get);
                    }
                    else if (constAttribute.getConstantValue().length != 0)
                    {
                        if (needPVoidCast)
                            f.write("cast(void*) ");
                        f.write(constAttribute.getConstantValue());
                    }
                    else
                    {
                        throw new Exception("Can't get initializer for struct constant");
                    }
                }
                if (isStruct)
                {
                    f.write(")");
                }
                f.writeln(",");
            }
            f.writeln("}");
        }
    }

    private void dumpStructs(scope ref std.stdio.File f, string namespace, bool docs = false)
    {
        auto structs = getStructs(db, namespace);
        if (!structs.empty())
        {
            dumpSectionHeader(f, "Structs");
            foreach(s; structs)
            {
                int uniqFieldCounter = 0;
                auto structAttrs = CommonAttributes(s.getAttributes());
                auto arch = structAttrs.getSupportedArchitecture();
                structArch[s.getTypeNamespace() ~ "." ~ s.getTypeName()] = arch;

                if (arch == SupportedArchitecture.None)
                {
                    f.write(format("// Type %s attributed with SupportedArchitecture.None\n", s.getTypeName()));
                    continue;
                }
                else if (arch != SupportedArchitecture.All)
                {
                    auto versions = getSupportedArchitectureVersions(arch);
                    foreach(ver; versions)
                    {
                        f.write(format("\nversion(%s)\n{\n", ver));
                        dumpStruct(f, s, structAttrs, uniqFieldCounter, 1, null, docs);
                        f.write("}\n");
                    }
                }
                else
                {
                    dumpStruct(f, s, structAttrs, uniqFieldCounter, 0, null, docs);
                }
            }
        }
    }

    private void dumpStruct(scope ref std.stdio.File f,
        scope ref const TypeDefEntity struc,
        scope ref const CommonAttributes structAttrs,
        ref int uniqFieldCounter,
        int level = 0,
        string nameOverride = "",
        bool docs = false)
    {
        if (!level)
            f.writeln;

        // MDMatcher* doc = level == 0 && docs ? findDoc(struc.name) : null;
        // if (doc)
        //     dumpDocumentation(f, doc.description, 0);

        auto guidAttr = GuidAttribute(structAttrs.getUnhandledAttributes());

        foreach(ca; guidAttr.getUnhandledAttributes())
        {
            if (ca.name() == "NativeTypedefAttribute")
            {
                // skip
            }
            else if (ca.name() == "RAIIFreeAttribute")
            {
                f.write("".padLeft(' ', level * 4));
                auto fixed = ca.value.fixed[0];
                auto element = fixed.value.get!ElementSig;
                auto str = element.value.get!string;
                f.writefln("@RAIIFree!%s", str);
            }
            else
            {
                f.write("".padLeft(' ', level * 4));
                f.writefln("//STRUCT ATTR: %s : %s", ca.name(), ca.value());
            }
        }

        f.dumpDocAttr(structAttrs, level).dumpObsoleteAttr(structAttrs, level).dumpGuidAttr(guidAttr, level);

        string[string] types;

        size_t maxNameLen;
        size_t maxTypeLen;
        auto nestedClasses = struc in nestedMap;

        // =================== Process types
        foreach(fx; struc.getFieldList())
        {
            auto fieldName = safeWords.get(fx.getName(), fx.getName());
            auto fieldType = fx.getSignature().typeSig.type;
            
            if (nestedClasses)
            {
                auto td = resolveType(fieldType, nullable(struc));
                if (!td.isNull)
                {
                    if (td.get in *nestedClasses)
                    {
                        continue;
                    }
                }
            }

            if (fieldName.length > maxNameLen && fieldName.length <= maxFieldAlignment)
                maxNameLen = fieldName.length;
            auto type = getFieldTypeText(fx, safeWords, true);
            if (type.length > maxTypeLen && type.length <= maxFieldAlignment)
                maxTypeLen = type.length;
            types[fieldName] = type;
        }

        bool isExplicit = struc.getFlags().layout == TypeLayout.explicitLayout;
        bool isAnonymous = struc.getTypeName().startsWith("_Anonymous");

        f.write("".padLeft(' ', level * 4));
        f.write(isExplicit ? "union" : "struct");

        if (!isAnonymous)
        {
            f.write(" ");
            if (nameOverride.length > 0)
                f.write(nameOverride);
            else
                f.write(safeWords.get(struc.getTypeName(), struc.getTypeName()));
        }
        f.writeln;

        f.write("".padLeft(' ', level * 4));
        f.writeln("{");

        auto lay = struc.getLayout();
        if (!lay.isNull)
        {
            f.write("".padLeft(' ', level * 4));
            f.writefln("align (%d):", lay.get.getPackingSize());
        }


        // =================== Dump fields
        foreach(fx; struc.getFieldList())
        {
            string fieldName = safeWords.get(fx.getName(), fx.getName());
            auto fieldAttrs = CommonAttributes(fx.getCustomAttributes());
            auto flexibleArrayAttr = FlexibleArrayAttribute(fieldAttrs.getUnhandledAttributes());
            auto nativeBitFieldAttribute = NativeBitfieldAttribute(flexibleArrayAttr.getUnhandledAttributes());
            // foreach(ca; nativeBitFieldAttribute.getUnhandledAttributes())
            // {
            //     f.write("".padLeft(' ', (level + 1) * 4));
            //     f.writefln("//FIELD ATTR: %s : %s", ca.name(), ca.value());
            // }

            if (nestedClasses)
            {
                auto td = resolveType(fx.getSignature().typeSig.type, nullable(struc));
                if (!td.isNull)
                {
                    if (td.get in *nestedClasses)
                    {
                        auto typeAttrs = CommonAttributes(td.get.getAttributes());
                        dumpStruct(f, td.get, typeAttrs, uniqFieldCounter, level + 1, fieldName, false);
                        continue;
                    }
                }
            }

            auto type = types[fieldName];
            if (fieldName == "_bitfield")
            {
                fieldName = getUnique(fieldName, uniqFieldCounter);
            }
            else if (fieldName == type || (type.startsWith(fieldName) && type.length > fieldName.length && (type[fieldName.length] == '[' || type[fieldName.length] == '*'))) // Fix for WLOOP[1] WLOOP;
            {
                fieldName ~= "_";
            }

            // if (doc)
            // {
            //     auto fdoc = doc.fields.find!(a => a.name == fx.name);
            //     if (!fdoc.empty)
            //         dumpDocumentation(f, fdoc.front.description, level + 1);
            // }

            f.dumpDocAttr(fieldAttrs, level + 1).dumpNativeBitfieldAttr(nativeBitFieldAttribute, level + 1);

            f.write("".padLeft(' ', (level + 1) * 4));
            f.write(type);
            if (type.length < maxTypeLen)
                f.write("".padLeft(' ' , maxTypeLen - type.length));
            f.write (' ');
            f.write(fieldName);
            auto ct = fx.getConstant();
            if (!ct.isNull)
            {
                if (fieldName.length < maxNameLen)
                    f.write("".padLeft(' ' , maxNameLen - fieldName.length));
                f.writef(" = ");
                dumpConstant(f, ct.get.value, true);
            }
            if (flexibleArrayAttr.getFlexibleArray())
            {
                f.writeln("; // Flexible array");
            }
            else
            {
                f.writeln(";");
            }
        }
        f.write("".padLeft(' ', level * 4));
        f.writeln("}");
    }

    private void dumpDelegates(scope ref std.stdio.File f, string namespace, bool docs = false)
    {
        auto delegates = getDelegates(db, namespace);
        if (!delegates.empty())
        {
            dumpSectionHeader(f, "Callbacks");
            foreach(d; delegates)
            {
                auto attrs = CommonAttributes(d.getAttributes());
                auto arch = attrs.getSupportedArchitecture();
                if (arch == SupportedArchitecture.None)
                {
                    f.write(format("// Delegate %s attributed with SupportedArchitecture.None\n", d.getTypeName()));
                    continue;
                }
                else if (arch != SupportedArchitecture.All)
                {
                    auto versions = getSupportedArchitectureVersions(arch);
                    foreach(ver; versions)
                    {
                        f.write(format("\nversion(%s)\n{\n", ver));
                        dumpDelegate(f, d, attrs, 1, docs);
                        f.write("}\n");
                    }
                }
                else
                {
                    dumpDelegate(f, d, attrs, 0, docs);
                }                    
            }                
        }
    }

    private void dumpDelegate(scope ref std.stdio.File f,
        scope ref const TypeDefEntity type,
        scope ref const CommonAttributes delegateAttrs,
        int level,
        bool docs = false)
    {
        string conv;

        foreach(ca; delegateAttrs.getUnhandledAttributes())
        {
            if (ca.name() == "UnmanagedFunctionPointerAttribute")
            {
                auto fixed = ca.value().fixed[0];
                auto element = fixed.value.get!ElementSig;
                auto v = element.value.get!int;
                if (v == 1 || v == 3)
                    conv = "Windows";
                else if (v == 2)
                    conv = "C";
                else
                    conv = format("Unknown[%s]", v);
            }
            else
            {
                f.write("".padLeft(' ', level * 4));
                f.writefln("//DELEGATE ATTR: %s : %s", ca.name(), ca.value());
            }
        }

        foreach(meth; type.getMethodList())
        {        
            if (meth.getName() == "Invoke")
            {
                // auto doc = docs ? findDoc(type.name) : null;
                // if (doc)
                // {
                //     dumpDocumentation(f, doc.description, 0);
                //     dumpDocumentationParams(f, *doc, 0);
                //     dumpDocumentationReturn(f, doc.returns, 0);
                // }

                f.dumpDocAttr(delegateAttrs, level).dumpObsoleteAttr(delegateAttrs, level);

                auto name = safeWords.get(type.getTypeName(), type.getTypeName());
                size_t w, v;
                f.write("".padLeft(' ', level * 4));
                f.write("alias ");
                f.write(name);
                f.write(" = ");
                w = name.length + 9;
                auto sig = meth.getSignature();
                if (sig.retSig.isByRef)
                {
                    f.write("ref ");
                    w += 4;
                }

                if (sig.retSig.isVoid)
                {
                    f.write("void");
                    w += 4;
                }
                else
                {
                    auto retTypeName = getTypeText(sig.retSig.typeSig, safeWords);
                    f.write(retTypeName);
                    w += retTypeName.length;
                }

                f.write(" function(");
                w += 10;
                v = w;

                ParamEntity[int] paramNames;
                foreach(p; meth.getParamList())
                {
                    ParamEntity pe = p;
                    int key = pe.getSequence();
                    paramNames.require(key, pe);
                }

                int idx = 1;

                bool atLeastOne;
                foreach(param; sig.params)
                {
                    if (atLeastOne)
                        f.write(", ");
                    w += 2;
                    auto paramText = getParamText(param, paramNames[idx++], safeWords);
                    if (!atLeastOne || w + paramText.length < maxLineWidth - 3)
                    {
                        f.write(paramText);
                        w += paramText.length;
                    }
                    else
                    {
                        f.writeln;
                        f.write("".padLeft(' ', v));
                        f.write(paramText);
                        w = v + paramText.length;
                    }
                    atLeastOne = true;
                }

                f.writeln(");");
                return;
            }       
        }
    }

    private void dumpApis(scope ref std.stdio.File f, string namespace, bool docs = false)
    {
        auto apis = getApisClasses(db, namespace);
        if (!apis.empty() && !apis.front().getMethodList().empty())
        {
            dumpSectionHeader(f, "Functions");
            foreach(meth; apis.front().getMethodList())
            {
                if (meth.getName() in skipMethods)
                    continue;

                auto attrs = CommonAttributes(meth.getAttributes());
                auto arch = attrs.getSupportedArchitecture();
                if (arch == SupportedArchitecture.None)
                {
                    f.write(format("// Method %s attributed with SupportedArchitecture.None\n", meth.getName()));
                    continue;
                }
                else if (arch != SupportedArchitecture.All)
                {
                    auto versions = getSupportedArchitectureVersions(arch);
                    foreach(ver; versions)
                    {
                        f.write(format("\nversion(%s)\n{\n", ver));
                        dumpMethod(f, meth, attrs, 1, 0, docs);
                        f.write("}\n");
                    }
                }
                else
                {
                    dumpMethod(f, meth, attrs, 0, 0, docs);
                }                    
            }
        }
    }

    private void dumpMethod(scope ref std.stdio.File f, 
        scope ref const MethodDefEntity meth, 
        scope ref const CommonAttributes methAttrs,
        int level, 
        size_t maxReturnTypeLength,
        bool docs = false,
        string prefix = null)
    {
        size_t w, v;

        foreach(ca; methAttrs.getUnhandledAttributes())
        {
            f.writefln("//METH ATTR: %s : %s", ca.name(), ca.value());
        }

        // auto doc = docs ? findDoc(prefix.length ? prefix ~ '.' ~ meth.name: meth.name) : null;

        // if (doc)
        // {
        //     dumpDocumentation(f, doc.description, level);
        //     dumpDocumentationParams(f, *doc, level);     
        //     dumpDocumentationReturn(f, doc.returns, level);
        // }
        f.dumpDocAttr(methAttrs, level).dumpObsoleteAttr(methAttrs, level);

        f.write("".padLeft(' ', level * 4));
        w = level * 4;

        auto impl = meth.getImplementation();
        if (!impl.isNull)
        {
            auto dllName = impl.get.getImportScope().getName();        
            f.writefln("@DllImport(\"%s\")", dllName);
        }

        auto sig = meth.getSignature();
        if (sig.retSig.isByRef)
        {
            f.write("ref ");
            w += 4;
        }

        if (sig.retSig.isVoid)
        {
            f.write("void");
            w += 4;
        }
        else
        {
            auto retTypeName = getTypeText(sig.retSig.typeSig, safeWords);
            f.write(retTypeName);
            w += retTypeName.length;
        }

        auto typeLen = w - level * 4;
        if (typeLen < maxReturnTypeLength)
        {
            f.write(" ".padLeft(' ', maxReturnTypeLength - typeLen));
            w += maxReturnTypeLength - typeLen;
        }

        auto methodName = meth.getName();
        f.write(" ");
        f.write(methodName);    
        f.write("(");
        w += methodName.length + 2;
        v = w;

        ParamEntity[int] paramNames;
        foreach(p; meth.getParamList())
        {
            ParamEntity pe = p;
            int key = pe.getSequence();
            paramNames.require(key, pe);
        }

        int idx = 1;

        bool atLeastOne;
        foreach(param; sig.params)
        {
            if (atLeastOne)
                f.write(", ");
            w += 2;
            auto paramText = getParamText(param, paramNames[idx++], safeWords);
            if (!atLeastOne || w + paramText.length < maxLineWidth - 3)
            {
                f.write(paramText);
                w += paramText.length;
            }
            else
            {
                f.writeln;
                f.write("".padLeft(' ', v));
                f.write(paramText);
                w = v + paramText.length;
            }
            atLeastOne = true;
        }

        f.writeln(");");
        if (!level)
            f.writeln;
    }

    private void dumpInterfaces(scope ref std.stdio.File f, string namespace, bool docs = false)
    {
        size_t maxLength, maxStructLength;
        RedBlackTree!string interfaceSet = new RedBlackTree!string;
        RedBlackTree!string structSet = new RedBlackTree!string;

        bool anyInterface = !getInterfaces(db, namespace).empty || !getEmptyInterfaces(db, namespace).empty;

        if (anyInterface)
            dumpSectionHeader(f, "Interfaces");

        foreach(intf; getEmptyInterfaces(db, namespace))
        {
            // auto doc = docs ? findDoc(intf.name) : null;
            // if (doc)
            //     dumpDocumentation(f, doc.description, 0);
            auto intfAttrs = CommonAttributes(intf.getAttributes());
            auto guidAttribute = GuidAttribute(intfAttrs.getUnhandledAttributes());
            foreach(ca; guidAttribute.getUnhandledAttributes())
            {
                f.writefln("//INTERFACEF ATTR: %s : %s", ca.name(), ca.value());
            }

            f.dumpDocAttr(intfAttrs, 0).dumpObsoleteAttr(intfAttrs, 0).dumpGuidAttr(guidAttribute);

            auto intfName = intf.getTypeName();
            
            f.writefln("struct %s;", intfName);
            f.writeln;
            structSet.insert(intfName);
            if (intfName.length > maxStructLength)
                maxStructLength = intfName.length;
        }

        foreach(intf; getInterfaces(db, namespace))
        {
            if (intf.getTypeName() in skipInterfaces)
                continue;
            bool hasGuid;

            // auto doc = docs ? findDoc(intf.name) : null;
            // if (doc)
            //     dumpDocumentation(f, doc.description, 0);

            auto intfAttrs = CommonAttributes(intf.getAttributes());
            auto guidAttribute = GuidAttribute(intfAttrs.getUnhandledAttributes());
            foreach(ca; guidAttribute.getUnhandledAttributes())
            {
                f.writefln("//INTERFACEF ATTR: %s : %s", ca.name(), ca.value());
            }

            f.dumpDocAttr(intfAttrs, 0).dumpObsoleteAttr(intfAttrs, 0).dumpGuidAttr(guidAttribute);

            if (!guidAttribute.getGuid().isNull)
            {
                hasGuid = true;
            }

            auto name = intf.getTypeName();
            if (hasGuid)
            {
                interfaceSet.insert(name);
                if (name.length > maxLength)
                    maxLength = name.length;
            }

            f.writef("interface %s", name);
            bool atLeastOne;

            foreach (interf; intf.getInterfaces())
            {
                auto implName = nameof(interf.getInterface());
                f.write(atLeastOne ? ", ": " : ");
                f.write(implName);
                atLeastOne = true;
            }

            f.writeln;
            f.writefln("{");

            size_t maxReturnTypeLength;
            foreach(meth; intf.getMethodList())
            {
                auto retSig = meth.getSignature().retSig;
                auto len = retSig.isVoid ? 4 : getTypeText(retSig.typeSig, safeWords).length;
                if (len > maxReturnTypeLength && len <= maxReturnTypeAlignment)
                    maxReturnTypeLength = len;
            }

            foreach(meth; intf.getMethodList())
            {
                auto attrs = CommonAttributes(meth.getAttributes());
                dumpMethod(f, meth, attrs, 1, maxReturnTypeLength, docs, intf.getTypeName());
            }

            f.writeln("}");
            f.writeln;
        }

        if (!interfaceSet.empty || !structSet.empty)
            dumpSectionHeader(f, "GUIDs");

        foreach(intf;structSet)
        {
            f.writef("const GUID CLSID_%s", intf);
            f.write("".padLeft(' ', maxStructLength - intf.length + 1));
            f.writefln("= GUIDOF!%s;", intf);
        }

        f.writeln;

        foreach(intf;interfaceSet)
        {
            f.writef("const GUID IID_%s", intf);
            f.write("".padLeft(' ', maxLength - intf.length + 1));
            f.writefln("= GUIDOF!%s;", intf);
        }
    }

    private void dumpSectionHeader(scope ref std.stdio.File f, string name) const
    {
        f.writeln;
        f.write("// ");
        f.writeln(name);
        f.writeln;
    }

    private StringSet[string] dependencies;
    private TypeSet[const(TypeDefEntity)] nestedMap;

    private const Database *db;
    private const string[] ignoredNamespaces;
    private const string[string] configNamespace;
    private const string cfgCoreFileName;
    private const string[string] safeWords;
    private const string outDirectory;
    private const bool[string] skipInterfaces;
    private const bool[string] skipMethods;
    private SupportedArchitecture[string] structArch;
}

alias StringSet = RedBlackTree!string;
alias TypeSet = bool[const(TypeDefEntity)];

auto getNamespaces(const Database* db, ref const string[] ignored)
{
    auto defSet = db.typeDefCollection.items().map!(a => a.getTypeNamespace()).array.sort.uniq;
    auto refSet = db.typeRefCollection.items().map!(a => a.getTypeNamespace()).array.sort.uniq;

    return chain(defSet, refSet).filter!(a => a.length > 0 && !ignored.canFind(a)).array.sort.uniq;
}

private struct FullTypeName
{
    string name;
    string namespace;
    string fullName;
}

private FullTypeName fullnameof(T)(T value)
{
    if (auto td = value.peek!TypeDefEntity)
        return FullTypeName(td.getTypeName(), td.getTypeNamespace(), td.getTypeNamespace() ~ "." ~ td.getTypeName());
    else if (auto tr = value.peek!TypeRefEntity)
        return FullTypeName(tr.getTypeName(), tr.getTypeNamespace(), tr.getTypeNamespace() ~ "." ~ tr.getTypeName());
    return FullTypeName();
}

string makePath(string outDir, string namespace,
    scope ref const string[string] config,
    scope ref const string[string] safeWords,
    scope ref const bool[string] nestedNamespaces)
{
    bool needMove = false;
    if (namespace in nestedNamespaces)
    {
        needMove = true;
    }

    string result;
    string lastPart = "";
    foreach(name; namespace.splitter('.'))
    {
        auto part = config.get(name.toLower, name.toLower);
        if (part.length)
        {
            lastPart = part;
            if (result.length)
                result ~= dirSeparator;

            auto partSafe = safeWords.get(part, part);
            result ~= partSafe;
        }
    }

    if (needMove)
    {
        if (result.length)
            result ~= dirSeparator;
        result ~= "package";
    }

    return buildPath(outDir, result);
}

string makeModuleName(string namespace, ref const string[string] config,
    scope ref const string[string] safeWords,
    scope ref const bool[string] nestedNamespaces)
{
    bool needMove = false;
    // if (namespace in nestedNamespaces)
    // {
    //     needMove = true;
    // }

    string result;
    string lastPart = "";
    foreach(name; namespace.splitter('.'))
    {
        auto part = config.get(name.toLower, name.toLower);
        if (part.length)
        {
            lastPart = part;
            if (result.length)
                result ~= '.';

            auto partSafe = safeWords.get(part, part);
            result ~= partSafe;
        }
    }

    if (needMove)
    {
        assert(lastPart.length != 0);
        auto lastPartSafe = safeWords.get(lastPart, lastPart);
        if (result.length)
            result ~= '.';
        result ~= lastPartSafe;
    }

    return result;
}

string getNamespace(string name)
{
    auto c = lastIndexOf(name, '.');
    return c > 0 ? name[0 .. c] : null;
}

string getName(string name)
{
    auto c = lastIndexOf(name, '.');
    return c > 0 ? name[c + 1 .. $] : name;
}

auto getTypeDefs(const Database* db, string namespace)
{
    return db.typeDefCollection.items().filter!(a => a.getTypeNamespace() == namespace);
}

auto getEnums(const Database* db, string namespace)
{
    return getTypeDefs(db, namespace).filter!(a => a.isEnum);
}

auto getStructs(const Database* db, string namespace)
{
    return getTypeDefs(db, namespace).filter!(a => a.isValueType() && !a.getAttributes().any!(c => c.name == "GuidAttribute"));
}

auto getDelegates(const Database* db, string namespace)
{
    return getTypeDefs(db, namespace).filter!(a => a.isDelegate());
}

auto getApisClasses(const Database* db, string namespace)
{
    return getTypeDefs(db, namespace).filter!(a => a.getTypeName() == "Apis");
}

auto getInterfaces(const Database* db, string namespace)
{
    return getTypeDefs(db, namespace).filter!(a => a.isInterface());
}

auto getEmptyInterfaces(const Database* db, string namespace)
{
    return getTypeDefs(db, namespace).filter!(a => a.isValueType()
                                              && !a.getFieldList().any!(b => true)
                                              && a.getAttributes().any!(c => c.name() == "GuidAttribute"));
}

bool seemsLikeTrueEnum(string e)
{
    auto mjlen = e.count!(a => a >= 'A' && a <= 'Z');
    auto mnlen = e.count!(a => a >= 'a' && a <= 'z'); 
    return mjlen > 0 
        && e[$ - 1] >= 'a' && e[$ - 1] <= 'z'
        && e[0] >= 'A' && e[0] <= 'Z'
        && mjlen < mnlen 
        && e.count!(a => a == '_') == 0;
}

string getEnumTypeText(scope ref const TypeDefEntity e)
{
    auto type = e.underlyingEnumType;
    switch(type)
    {
        case ElementType.boolean:
            return "bool";
        case ElementType.char_:
            return "wchar";
        case ElementType.i1:
            return "byte";
        case ElementType.u1:
            return "ubyte";         
        case ElementType.i2:
            return "short";
        case ElementType.u2:
            return "ushort";         
        case ElementType.i4:
            return "int";
        case ElementType.u4:
            return "uint";         
        case ElementType.i8:
            return "long";
        case ElementType.u8:
            return "ulong";    
        case ElementType.r4:
            return "float";    
        case ElementType.r8:
            return "double";    
        default:
            assert(0);
    }
}

string getTypeText(const ref TypeSig sig, scope ref const string[string] safeWords, bool isConst = false, int nativeReplacement = 0)
{
    string s;
    if (nativeReplacement)
    {
        switch(nativeReplacement)
        {
            case 20 : return "const(char)*";
            case 21 : return "const(wchar)*"; 
            case 42 : return "char*";
            default : s = format("/*UNKNOWN NATIVE - %s*/", nativeReplacement);
        }
    }
    
    if (isConst)
    {
        s ~= "const(";
    }

    if (auto elType = sig.type.peek!ElementType)
    {
        switch(*elType)
        {
            case ElementType.boolean:
                s ~= "bool"; break;
            case ElementType.char_:
                s ~= "wchar"; break;
            case ElementType.i1:
                s ~= "byte"; break;
            case ElementType.u1:
                s ~= "ubyte"; break;         
            case ElementType.i2:
                s ~= "short"; break;
            case ElementType.u2:
                s ~= "ushort"; break;         
            case ElementType.i4:
                s ~= "int"; break;
            case ElementType.u4:
                s ~= "uint"; break;         
            case ElementType.i8:
                s ~= "long"; break;
            case ElementType.u8:
                s ~= "ulong"; break;    
            case ElementType.r4:
                s ~= "float"; break;    
            case ElementType.r8:
                s ~= "double"; break;    
            case ElementType.string:
                s ~= "const(wchar)*"; break; 
            case ElementType.object:
                s ~= "object"; break; 
            case ElementType.void_:
                s ~= "void"; break; 
            case ElementType.i:
                s ~= "ptrdiff_t"; break; 
            case ElementType.u:
                s ~= "size_t"; break; 
            default:
                s ~= "// unknown element type for "; break;
        }
    }
    else if (auto elType = sig.type.peek!TypeRefEntity)  
    {
        auto t = safeWords.get(elType.getTypeName(), elType.getTypeName()); 
        s ~= t == "Guid" ? "GUID" : t;
    }
    else if (auto elType = sig.type.peek!TypeDefEntity)
    {
        auto t = safeWords.get(elType.getTypeName(), elType.getTypeName()); 
        s ~= t == "Guid" ? "GUID" : t;
    }
    else
        s ~= "/* unknown type */";

    if (isConst)
        s ~= ")";

    if (sig.isArray)
    {
        for(size_t i = 0; i < sig.arraySizes.length; ++i)
            s ~= format("[%d]", sig.arraySizes[i]);
    }
    
    for (int i = 0; i < sig.ptrCount; ++i)
        s ~= '*';

    return s;
}

string getFieldTypeText(scope ref const FieldEntity field, scope ref const string[string] safeWords, bool checkConst = false)
{
    string s;
    int nativeReplacement;
    bool isConst;
    foreach(ca; field.getCustomAttributes())
    {
        if (ca.name() == "ConstAttribute")
        {
            isConst = checkConst;
        }
        else if (ca.name() == "NativeTypeInfoAttribute")
        {
            auto fixed = ca.value().fixed[0];
            auto element = fixed.value().get!ElementSig;
            nativeReplacement = element.value().get!int;
        }
    }
    s ~= getTypeText(field.getSignature().typeSig, safeWords, isConst, nativeReplacement);
    return s;
}

private Nullable!TypeDefEntity resolveType(scope ref const TypeSig.TypeValue v, Nullable!(const TypeDefEntity) enclosing)
{
    if (auto r = v.peek!TypeDefEntity)
        return Nullable!TypeDefEntity(*r);
    else if (auto r = v.peek!TypeRefEntity)
        return r.resolve(enclosing);
    else
        return (Nullable!TypeDefEntity).init;
}

string getUnique(string s, scope ref int counter)
{
    return s ~ to!string(counter++);
}

string getParamText(scope ref const ParamSig sig, scope ref const ParamEntity param, scope ref const string[string] safeWords)
{
    string s;
    bool isConst;
    int nativeReplacement;
    foreach(ca; param.getCustomAttributes())
    {
        if (ca.name == "ConstAttribute")
            isConst = true;
        else if (ca.name() == "NativeTypeInfoAttribute")
        {
            auto fixed = ca.value().fixed[0];
            auto element = fixed.value.get!ElementSig;
            nativeReplacement = element.value.get!int;
        }
        else if (ca.name() == "ComOutPtrAttribute")
        {
            //can't find any use
        }
        else if (ca.name() == "NativeArrayInfoAttribute")
        {
            //cant't find any use
        }
        else if (ca.name() == "NotNullTerminated")
        {
            //cant't find any use
        }
        else if (ca.name() == "RetValAttribute")
        {
            //cant't find any use
        }
        else if (ca.name() == "NullNullTerminatedAttribute")
        {
            //cant't find any use
        }
        else
            s = format("/*PARAM ATTR: %s : %s*/", ca.name(), ca.value());
    }
    if (sig.isByRef)
         s = "ref ";

    auto attr = param.getFlags();
    //if (attr.isIn)
    //    f.write("in ");
    //if (attr.isOut)
    //    f.write("/* out */ ");
    //if (attr.isOptional)
    //    f.write("/* optional */ ");
    s ~= getTypeText(sig.typeSig, safeWords, isConst, nativeReplacement);
    s ~= " " ~ safeWords.get(param.getName(), param.getName());
    return s;
}

string nameof(T)(T value)
{
    if (auto td = value.peek!TypeDefEntity)
       return td.getTypeName();
    else if (auto td = value.peek!TypeRefEntity)
        return td.getTypeName();
    return null;
}

string[] getSupportedArchitectureVersions(SupportedArchitecture arch)
{
    string[] result;
    if (arch & SupportedArchitecture.X86)
    {
        result ~= "X86";
    }
    if (arch & SupportedArchitecture.X64)
    {
        result ~= "X86_64";
    }
    if (arch & SupportedArchitecture.Arm64)
    {
        result ~= "AArch64";
    }

    return result;
}

private ref std.stdio.File dumpDocAttr(return scope ref std.stdio.File f, scope ref const CommonAttributes ca, const int level = 0)
{
    if (ca.getDocumentation().length != 0)
    {
        if (level != 0)
        {
            f.write("".padLeft(' ', level * 4));
        }
        f.writefln("// Microsoft documentation: %s", ca.getDocumentation());
    }

    return f;
}

private ref std.stdio.File dumpNativeEncodingAttr(return scope ref std.stdio.File f, scope ref const NativeEncodingAttribute ca, const int level = 0)
{
    if (ca.getNativeEncoding().length != 0) 
    {
        if (level != 0)
        {
            f.write("".padLeft(' ', level * 4));
        }        
        f.writefln("// Native encoding: %s", ca.getNativeEncoding());
    }

    return f;
}

private ref std.stdio.File dumpNativeBitfieldAttr(return scope ref std.stdio.File f, scope ref const NativeBitfieldAttribute ca, const int level = 0)
{
    auto records = ca.getBitRecords();
    if (records.length == 0)
    {
        return f;
    }

    if (level != 0)
    {
        f.write("".padLeft(' ', level * 4));
    }        
    f.write("// Native bit field: ");

    auto isFirst = true;
    foreach(r; records)
    {
        if (!isFirst)
        {
            f.write(", ");
        }
        if (r.length == 1)
        {
            f.writef("%s: [%d]", r.name, r.offset);
        }
        else
        {
            f.writef("%s: [%d-%d]", r.name, r.offset, r.offset + r.length - 1);
        }
        isFirst = false;
    }

    f.writeln();
    return f;
}

private ref std.stdio.File dumpObsoleteAttr(return scope ref std.stdio.File f, scope ref const CommonAttributes ca, const int level = 0)
{
    if (!ca.getObsolete().isNull)
    {
        if (level != 0)
        {
            f.write("".padLeft(' ', level * 4));
        }
        auto msg = ca.getObsolete().get;
        if (msg.length == 0)
        {
            msg = "marked as obsolete";
        }

        f.writefln("deprecated(\"%s\") ", msg);
    }

    return f;
}

private ref std.stdio.File dumpGuidAttr(return scope ref std.stdio.File f, scope ref const GuidAttribute ca, const int level = 0)
{
    if (!ca.getGuid().isNull)
    {
        if (level != 0)
        {
            f.write("".padLeft(' ', level * 4));
        }
        f.writefln("@GUID(\"%s\")", ca.getGuid().get);
    }

    return f;
}
