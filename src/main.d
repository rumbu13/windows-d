module dwin32;

import metadata;

import std.stdio;

import std.algorithm;
import std.path;
import std.array;
import std.uni;
import std.string;
import std.container;
import std.file;
import std.range : padLeft, chain;
import std.conv;
import std.path: buildPath;
import std.getopt;
import std.math;
import std.regex;



enum maxLineWidth = 120;
enum maxReturnTypeAlignment = 8;
enum maxFieldAlignment = 20;
enum minSetTreshold = 0.4;

string makePath(string outDir, string namespace, string[string] config)
{
    string result;
    foreach(name; namespace.splitter('.'))
    {
        auto part = config.get(name.toLower, name.toLower);
        if (part.length)
        {
            if (result.length)
                result ~= dirSeparator;
            result ~= part;
        }
    }
    return buildPath(outDir, result);
}

string makeModuleName(string namespace, string[string] config)
{
    string result;
    foreach(name; namespace.splitter('.'))
    {
        auto part = config.get(name.toLower, name.toLower);
        if (part.length)
        {
            if (result.length)
                result ~= '.';
            result ~= part;
        }
    }
    return result;
}





auto getNamespaces(const ref Metadata db, string[] ignored)
{
    auto defSet = db.typeDefTable.items.map!(a => a.namespace).array.sort.uniq;
    auto refSet = db.typeRefTable.items.map!(a => a.namespace).array.sort.uniq;
    return chain(defSet, refSet).filter!(a => a.length > 0 && !ignored.canFind(a)).array.sort.uniq;
}

auto getTypeDefs(const ref Metadata db, string namespace)
{
    return db.typeDefTable.items.filter!(a => a.namespace == namespace);
}

auto getInterfaces(const ref Metadata db, string namespace)
{
    return getTypeDefs(db, namespace).filter!(a => a.isInterface);
}

auto getDelegates(const ref Metadata db, string namespace)
{
    return getTypeDefs(db, namespace).filter!(a => a.isDelegate);
}

auto getEmptyInterfaces(const ref Metadata db, string namespace)
{
    return getTypeDefs(db, namespace).filter!(a => a.isValueType 
                                              && !a.fields.any!(b => true) 
                                              && a.attributes.any!(c => c.name == "GuidAttribute"));
}

auto getEnums(const ref Metadata db, string namespace)
{
    return getTypeDefs(db, namespace).filter!(a => a.isEnum);
}

auto getApisClasses(const ref Metadata db, string namespace)
{
    return getTypeDefs(db, namespace).filter!(a => a.name == "Apis");
}

auto getStructs(const ref Metadata db, string namespace)
{
    return getTypeDefs(db, namespace).filter!(a => a.isValueType 
                                              && !a.attributes.any!(c => c.name == "GuidAttribute"));
}

string nameof(T)(T value)
{
    if (auto td = value.peek!TypeDef)
       return td.name;
    else if (auto td = value.peek!TypeRef)
        return td.name;
    return null;
}

string namespaceof(T)(T value)
{
    if (auto td = value.peek!TypeDef)
        return td.namespace;
    else if (auto td = value.peek!TypeRef)
        return td.namespace;
    return null;
}

string fullnameof(T)(T value)
{
    if (auto td = value.peek!TypeDef)
        return td.namespace ~ "." ~ td.name;
    else if (auto td = value.peek!TypeRef)
        return td.namespace ~ "." ~ td.name;
    return null;
}

string getns(string name)
{
    auto c = lastIndexOf(name, '.');
    return c > 0 ? name[0 .. c] : null;
}

string getname(string name)
{
    auto c = lastIndexOf(name, '.');
    return c > 0 ? name[c + 1 .. $] : name;
}


void dumpGUIDAttr(std.stdio.File f, CustomAttributeSig sig)
{
    auto fixed = sig.fixed[0];
    auto element = fixed.value.get!ElementSig;
    auto str = element.value.get!string;
    f.writefln("@GUID(\"%s\")", str);
}

void dumpSectionHeader(std.stdio.File f, string name)
{
    f.writeln;
    f.write("// ");
    f.writeln(name);
    f.writeln;
}

void dumpInterfaces(std.stdio.File f, const ref Metadata db, string namespace, bool docs = false)
{
    size_t maxLength, maxStructLength;
    RedBlackTree!string interfaceSet = new RedBlackTree!string;
    RedBlackTree!string structSet = new RedBlackTree!string;

    bool anyInterface = !getInterfaces(db, namespace).empty || !getEmptyInterfaces(db, namespace).empty;

    if (anyInterface)
        dumpSectionHeader(f, "Interfaces");

    

    foreach(intf; getEmptyInterfaces(db, namespace))
    {

        auto doc = docs ? findDoc(intf.name) : null;
        if (doc)
            dumpDocumentation(f, doc.description, 0);
        auto attr = intf.attributes.find!(a => a.name == "GuidAttribute").front;
        dumpGUIDAttr(f, attr.value); 
        auto intfName = intf.name;

        
        
        f.writefln("struct %s;", intfName);
        f.writeln;
        structSet.insert(intfName);
        if (intfName.length > maxStructLength)
            maxStructLength = intfName.length;
    }


    foreach(intf; getInterfaces(db, namespace))
    {
        if (intf.name in skipInterfaces)
            continue;
        bool hasGuid;

        auto doc = docs ? findDoc(intf.name) : null;
        if (doc)
            dumpDocumentation(f, doc.description, 0);

        foreach(ca; intf.attributes)
        {
            auto attrName = ca.name;
            if (attrName == "GuidAttribute")
            {
                dumpGUIDAttr(f, ca.value); 
                hasGuid = true;                
            }
            else
                f.writefln("//INTERFACEF ATTR: %s : %s", ca.name, ca.value);
        }


        auto name = intf.name;
        if (hasGuid)
        {
            interfaceSet.insert(name);
            if (name.length > maxLength)
                maxLength = name.length;
        }

        
        f.writef("interface %s", name);
        bool atLeastOne;    

        foreach (interf; intf.interfaces)
        {
            auto implName = nameof(interf.implementation);
            f.write(atLeastOne ? ", ": " : ");
            f.write(implName);
            atLeastOne = true;
        }

        f.writeln;
        f.writefln("{");

        size_t maxReturnTypeLength;
        foreach(meth; intf.methods)
        {
            auto retSig = meth.signature.retSig;
            auto len = retSig.isVoid ? 4 : getTypeText(retSig.typeSig).length;
            if (len > maxReturnTypeLength && len <= maxReturnTypeAlignment)
                maxReturnTypeLength = len;
        }

        foreach(meth; intf.methods)
            dumpMethod(f, meth, 1, maxReturnTypeLength, docs, intf.name);

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

void dumpApis(std.stdio.File f, const ref Metadata db, string namespace, bool docs = false)
{
    auto apis = getApisClasses(db, namespace);
    if (!apis.empty && !apis.front.methods.empty)
    {
        dumpSectionHeader(f, "Functions");
        foreach(meth; apis.front.methods)
        {
            if (meth.name in skipMethods)
                continue;
            dumpMethod(f, meth, 0, 0, docs);
        }
    }
}

string getEnumTypeText(const ref TypeDef e)
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

void dumpEnums(std.stdio.File f, const ref Metadata db, string namespace, bool docs = false)
{
    auto enums = getEnums(db, namespace);
    if (!enums.empty)
    {
        dumpSectionHeader(f, "Enums");
        foreach(e; enums)
            dumpEnum(f, e, docs);
    }
}

void dumpEnum(std.stdio.File f, const ref TypeDef e, bool docs = false)
{
    foreach(ca; e.attributes)
        f.writefln("//ENUM ATTR: %s : %s", ca.name, ca.value);
    
    bool trueEnum = seemsLikeTrueEnum(e.name);

    size_t maxLen;
    foreach(fx; e.fields)
    {
        if (fx.name.length > maxLen)
            maxLen = fx.name.length;
    }

    auto typeText = getEnumTypeText(e);

    if (e.fields.any!(a => !a.fieldAttributes.hasRuntimeSpecialName))
    {
        MDMatcher* doc = docs ? findDoc(e.name) : null;
        f.writeln;
        if (doc)
            dumpDocumentation(f, doc.description, 0);
        
        if (!trueEnum)
        {
            f.writefln("alias %s = %s;", e.name, typeText);
            f.writefln("enum : %s", typeText);
        }
        else
            f.writefln("enum %s : %s", e.name, typeText);            
        f.writeln("{");
        foreach(fx; e.fields)
        {            
            auto name = safeWords.get(fx.name, fx.name);
            if (!fx.fieldAttributes.hasRuntimeSpecialName)
            {
                if (doc)
                {
                    auto fdoc = doc.fields.find!(a => a.name == name);
                    if (!fdoc.empty)
                        dumpDocumentation(f, fdoc.front.description, 1);
                }
                f.write("".padLeft(' ', 4));
                f.write(name);

                if (fx.fieldAttributes.isLiteral)
                {
                    if (name.length < maxLen)
                        f.write("".padLeft(' ', maxLen - name.length));
                    auto ct = fx.constant;
                    if (!ct.isNull)
                    {
                        f.writef(" = ");
                        dumpConstant(f, ct.get.value);
                    }
                }
                f.writeln(",");
            }
        }   
        f.writeln("}");
    }
    
}

void dumpConstant(std.stdio.File f, Constant.ConstantValue v)
{
    if (auto s = v.peek!wstring)
        f.writef("\"%s\"", *s);
    else if (auto n = v.peek!(typeof(null)))
        f.write("null");
    else if (auto i = v.peek!int)
        f.writef("0x%08x", *i);
    else if (auto i = v.peek!uint)
        f.writef("0x%08x", *i);
    else if (auto i = v.peek!short)
        f.writef("0x%04x", *i);
    else if (auto i = v.peek!ushort)
        f.writef("0x%04x", *i);
    else if (auto i = v.peek!byte)
        f.writef("0x%02x", *i);
    else if (auto i = v.peek!ubyte)
        f.writef("0x%02x", *i);
    else if (auto i = v.peek!long)
        f.writef("0x%016x", *i);
    else if (auto i = v.peek!ulong)
        f.writef("0x%016x", *i);
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
        f.write(v);
        
}

void dumpApisConstants(std.stdio.File f, const ref Metadata db, string namespace)
{
    bool wasOne;
    auto apis = getApisClasses(db, namespace);
    if (!apis.empty && !apis.front.fields.empty)
    {        
        dumpSectionHeader(f, "Constants");
        Field[] flds;
        string lastTypeText;
        string lastField;
        bool mustReturn;
        foreach(fld; apis.front.fields)
        {
            auto typeText = getTypeText(fld.signature.typeSig);
            auto fieldName = fld.name;
            if (!flds.length || (typeText == lastTypeText && lastField.length > 0 
                                 && commonPrefix(lastField, fieldName).length / cast(double)(lastField.length) > minSetTreshold))
            {
                lastField = fld.name;
                lastTypeText = typeText;
                flds ~= fld;
            }
            else
            {              
                lastTypeText.length = 0;
                lastField.length = 0;     
                dumpFieldCollection(f, flds, wasOne);    
                wasOne = flds.length == 1;
                flds = [];
                
            }            
        }
        if (flds.length)
            dumpFieldCollection(f, flds, wasOne);


    }
}

void dumpFieldCollection(std.stdio.File f, Field[] flds, bool wasOne)
{
    if (flds.length == 1)
    {
        if (!wasOne)
            f.writeln;
        f.write("enum ");                
        f.write(getFieldTypeText(flds[0]));   
        f.write(" ");
        f.write(safeWords.get(flds[0].name, flds[0].name));
        f.write(" = ");
        dumpConstant(f, flds[0].constant.get.value);
        f.writeln(";");
    }
    else
    {        
        size_t maxLen;
        foreach(fx; flds)
        {
            if (fx.name.length > maxLen)
                maxLen = fx.name.length;
        }

        f.writeln;
        f.write("enum : ");                
        f.writeln (getFieldTypeText(flds[0]));                      
        f.writeln("{");
        foreach(fx; flds)
        {            
            f.write("".padLeft(' ', 4));
            foreach(ca; fx.attributes)
            {
                if (ca.name == "ObsoleteAttribute")
                {
                    auto fixed = ca.value.fixed[0];
                    auto element = fixed.value.get!ElementSig;
                    auto msg = element.value.get!string;
                    f.writefln("deprecated(\"%s\") ", msg);
                    f.write("".padLeft(' ', 4));
                    break;
                }
            }
            auto name = safeWords.get(fx.name, fx.name);
            f.write(name);
            if (name.length < maxLen)
                f.write("".padLeft(' ', maxLen - name.length));
            f.write(" = ");
            dumpConstant(f, fx.constant.get.value);
            f.writeln(",");
        }
        f.writeln("}");
    }
}

void dumpConstant(std.stdio.File f, Field fld, int level)
{    
    f.write("".padLeft(' ', level * 4));
    foreach(ca; fld.attributes)
        f.writefln("//CONSTANT ATTR: %s : %s", ca.name, ca.value);
    f.writef("enum %s", fld.name);    
    auto ct = fld.constant;
    f.writef(" = %s", ct.get.value);
    f.writeln;
}

void dumpMethod(std.stdio.File f, MethodDef meth, int level, size_t maxReturnTypeLength, bool docs = false, string prefix = null)
{
    size_t w, v;
    

    foreach(ca; meth.attributes)
    {
        f.writefln("//METH ATTR: %s : %s", ca.name, ca.value);
    }

    

   
    auto doc = docs ? findDoc(prefix.length ? prefix ~ '.' ~ meth.name: meth.name) : null;

    if (doc)
    {
        dumpDocumentation(f, doc.description, level);
        dumpDocumentationParams(f, *doc, level);     
        dumpDocumentationReturn(f, doc.returns, level);
    }


    f.write("".padLeft(' ', level * 4));
    w = level * 4;


    auto impl = meth.implementation;
    if (!impl.isNull)
    {
        auto dllName = impl.get.importScope.name;        
        f.writefln("@DllImport(\"%s\")", dllName);
    }


    auto sig = meth.signature;
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
        auto retTypeName = getTypeText(sig.retSig.typeSig);
        f.write(retTypeName);
        w += retTypeName.length;
    }

    auto typeLen = w - level * 4;
    if (typeLen < maxReturnTypeLength)
    {
        f.write(" ".padLeft(' ', maxReturnTypeLength - typeLen));
        w += maxReturnTypeLength - typeLen;
    }

    auto methodName = meth.name;
    f.write(" ");
    f.write(methodName);    
    f.write("(");
    w += methodName.length + 2;
    v = w;


    Param[int] paramNames;
    foreach(p; meth.parameters)
        paramNames[p.rank] = p;

    int idx = 1;

    bool atLeastOne;
    foreach(param; sig.params)
    {
        if (atLeastOne)
            f.write(", ");
        w += 2;
        auto paramText = getParamText(param, paramNames[idx++]);
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

void dumpStruct(std.stdio.File f, const ref TypeDef struc, int level = 0, string nameOverride = "", bool docs = false)
{
    if (!level)
        f.writeln;
    f.write("".padLeft(' ', level * 4));

    if (struc.name == "CQFORM")
    {
        auto s = "";
    }

    MDMatcher* doc = level == 0 && docs ? findDoc(struc.name) : null;
    if (doc)
        dumpDocumentation(f, doc.description, 0); 

    foreach(ca; struc.attributes)
    {
        if (ca.name == "NativeTypedefAttribute")
        {
            auto fld = struc.fields.front;
            f.writef("alias ");
            f.writef(struc.name);
            f.writef(" = ");
            string text = getFieldTypeText(fld);
            f.writef(text);
            f.writeln(";");
            return;
        }
        else if (ca.name == "RAIIFreeAttribute")
        {
            //just ignore
        }
        else
            f.writefln("//STRUCT ATTR: %s : %s", ca.name, ca.value);        
    }

    string[string] types;

    size_t maxNameLen;
    size_t maxTypeLen;
    int nativeType;
    auto nestedClasses = struc in nestedMap;

    foreach(fx; struc.fields)
    {
        auto name = safeWords.get(fx.name, fx.name);


        auto fieldType = fx.signature.typeSig.type;
        
        if (nestedClasses)
        {
            auto td = resolveType(fieldType);
            if (!td.isNull)
                if (td.get in *nestedClasses)
                    continue;                
        }
            
        if (name.length > maxNameLen && name.length <= maxFieldAlignment)
            maxNameLen = name.length;        
        auto type = getFieldTypeText(fx, true);
        if (type.length > maxTypeLen && type.length <= maxFieldAlignment)
            maxTypeLen = type.length;    
        types[name] = type;
    }

    bool isExplicit = struc.typeAttributes.layout == TypeLayout.explicitLayout;
    bool isAnonymous = struc.name.startsWith("_Anonymous");


    f.write(isExplicit ? "union" : "struct");
    
    if (!isAnonymous)
    {
        f.write(" ");
        if (nameOverride.length > 0)
            f.write(nameOverride);
        else
            f.write(safeWords.get(struc.name, struc.name));
    }
    f.writeln;

 
    f.write("".padLeft(' ', level * 4));
    f.writeln("{");

    auto lay = struc.layout;
    if (!lay.isNull)
    {
        f.write("".padLeft(' ', level * 4));
        f.writefln("align (%d):", lay.get.packingSize);
    }

    foreach(fx; struc.fields)
    {           
        if (nestedClasses)
        {
            auto td = resolveType(fx.signature.typeSig.type);
            if (!td.isNull)
            {                
                if (td.get in *nestedClasses)
                {
                    dumpStruct(f, td.get, level + 1, safeWords.get(fx.name, fx.name), false);
                    continue;                
                }
            }
        }    

        auto name = safeWords.get(fx.name, fx.name);        
        auto type = types[name];
        if (name == "_bitfield" || name == type)
            name = getUnique(name);

        if (doc)
        {
            auto fdoc = doc.fields.find!(a => a.name == fx.name);
            if (!fdoc.empty)            
                dumpDocumentation(f, fdoc.front.description, level + 1);            
        }
        
        f.write("".padLeft(' ', level * 4));
        f.write("".padLeft(' ' , 4));
        f.write(type);
        if (type.length < maxTypeLen)
            f.write("".padLeft(' ' , maxTypeLen - type.length));
        f.write (' ');
        f.write(name);
        auto ct = fx.constant;
        if (!ct.isNull)
        {
            if (name.length < maxNameLen)
                f.write("".padLeft(' ' , maxNameLen - name.length));
            f.writef(" = ");
            dumpConstant(f, ct.get.value);
        }
        f.writeln(";");
    }  
    f.write("".padLeft(' ', level * 4));
    f.writeln("}");
}

void dumpStructs(std.stdio.File f, const ref Metadata db, string namespace, bool docs = false)
{
    auto structs = getStructs(db, namespace);
    if (!structs.empty)
    {
        dumpSectionHeader(f, "Structs");
        foreach(s; structs)
            dumpStruct(f, s, 0, null, docs);
    }
}

void dumpDelegate(std.stdio.File f, TypeDef type, bool docs = false)
{

    string conv;
    foreach(ca; type.attributes)
    {
        if (ca.name == "UnmanagedFunctionPointerAttribute")
        {
            auto fixed = ca.value.fixed[0];
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
            f.writefln("//DELEGATE ATTR: %s : %s", ca.name, ca.value);
    }

    //MethodDef def;
    foreach(meth; type.methods)
    {        
        if (meth.name == "Invoke")
        {   
            auto doc = docs ? findDoc(type.name) : null;
            if (doc)
            {
                dumpDocumentation(f, doc.description, 0);
                dumpDocumentationParams(f, *doc, 0);
                dumpDocumentationReturn(f, doc.returns, 0);
            }
            auto name = safeWords.get(type.name, type.name);
            size_t w, v;
            f.write("alias ");
            f.write(name);
            f.write(" = ");
            w = name.length + 9;
            auto sig = meth.signature;
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
                auto retTypeName = getTypeText(sig.retSig.typeSig);
                f.write(retTypeName);
                w += retTypeName.length;
            }

            f.write(" function(");
            w += 10;
            v = w;

            Param[int] paramNames;
            foreach(p; meth.parameters)
                paramNames[p.rank] = p;

            int idx = 1;

            bool atLeastOne;
            foreach(param; sig.params)
            {
                if (atLeastOne)
                    f.write(", ");
                w += 2;
                auto paramText = getParamText(param, paramNames[idx++]);
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

void dumpDelegates(std.stdio.File f, const ref Metadata db, string namespace, bool docs = false)
{
    auto delegates = getDelegates(db, namespace);
    if (!delegates.empty)
    {
        dumpSectionHeader(f, "Callbacks");
        foreach(d; delegates)
            dumpDelegate(f, d, docs);
    }
}

void dumpDocumentation(std.stdio.File f, string doc, int level)
{    
    auto len = maxLineWidth - 3 - level * 4;    

    foreach(line; doc.wrap(len).splitter('\n'))
    {
        if (line.length)
        {
            f.write("".padLeft(' ', level * 4));
            f.write("///");
            f.writeln(line);        
        }
    }

}

void dumpDocumentationReturn(std.stdio.File f, string ret, int level)
{    
    auto len = maxLineWidth - 3 - level * 4;     

    if (ret.length)
    {
        f.write("".padLeft(' ', level * 4));
        f.write("///");
        f.writeln("Returns:");
        len -= 4;
    
        foreach(line; ret.wrap(len).splitter('\n'))
        {
            f.write("".padLeft(' ', level * 4));
            f.write("///");
            f.write("".padLeft(' ', 4));
            f.writeln(line);
        }
    }
}

void dumpDocumentationParams(std.stdio.File f, MDMatcher doc, int level)
{    
    auto len = maxLineWidth - 3 - level * 4; 
    if (!doc.params.empty)
    {
        dumpDocumentation(f, "Params:", level);
        len -= 4;
        foreach(p; doc.params)
        {
            f.write("".padLeft(' ', level * 4));
            f.write("///");
            f.write("".padLeft(' ', 4));
            f.write(p.name);
            f.write(" = ");            
            auto wrp = p.description.wrap(len).splitter('\n');
            if (!wrp.empty)
            {
                f.writeln(wrp.front);
                wrp.popFront();
                foreach(line; wrp)
                {
                    if (line.length)
                    {
                        f.write("".padLeft(' ', level * 4));
                        f.write("///");
                        f.write("".padLeft(' ', 4));
                        f.write("".padLeft(' ', p.name.length + 3));
                        f.writeln(line);
                    }
                }
            }         
        }
    }
    

}

string getTypeText(const ref TypeSig sig, bool isConst = false, int nativeReplacement = 0)
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
        s ~= "const(";

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
    else if (auto elType = sig.type.peek!TypeRef)  
    {
        auto t = safeWords.get(elType.name, elType.name); 
        s ~= t == "Guid" ? "GUID" : t;
    }
    else if (auto elType = sig.type.peek!TypeDef)
    {
        auto t = safeWords.get(elType.name, elType.name); 
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

string getFieldTypeText(const ref Field field, bool checkConst = false)
{
    string s;
    int nativeReplacement;
    bool isConst;
    foreach(ca; field.attributes)
    {
        if (ca.name == "ConstAttribute")
        {
            isConst = checkConst;
        }
        else if (ca.name == "NativeTypeInfoAttribute")
        {
            auto fixed = ca.value.fixed[0];
            auto element = fixed.value.get!ElementSig;
            nativeReplacement = element.value.get!int;
        }
        else if(ca.name == "ObsoleteAttribute")
        {
            //ignore now, use when writing field
        }
        else
            s = format("/*FIELD ATTR: %s : %s*/", ca.name, ca.value);
    }
    s ~= getTypeText(field.signature.typeSig, isConst, nativeReplacement);
    return s;
}

Nullable!TypeDef resolveType(TypeSig.TypeValue v)
{
    if (auto r = v.peek!TypeDef)
        return Nullable!TypeDef(*r);
    else if (auto r = v.peek!TypeRef)
        return r.resolve;
    else
        return (Nullable!TypeDef).init;
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

string getUnique(string s)
{
    static int i;
    return s ~ to!string(i++);
}

string getParamText(const ref ParamSig sig, const ref Param param)
{
    string s;
    bool isConst;
    int nativeReplacement;
    foreach(ca; param.attributes)
    {
        if (ca.name == "ConstAttribute")
            isConst = true;
        else if (ca.name == "NativeTypeInfoAttribute")
        {
            auto fixed = ca.value.fixed[0];
            auto element = fixed.value.get!ElementSig;
            nativeReplacement = element.value.get!int;
        }
        else if (ca.name == "ComOutPtrAttribute")
        {
            //just ignore
        }
        else
            s = format("/*PARAM ATTR: %s : %s*/", ca.name, ca.value);
    }
    if (sig.isByRef)
         s = "ref ";

    auto attr = param.paramAttributes;
    //if (attr.isIn)
    //    f.write("in ");
    //if (attr.isOut)
    //    f.write("/* out */ ");
    //if (attr.isOptional)
    //    f.write("/* optional */ ");
    s ~= getTypeText(sig.typeSig, isConst, nativeReplacement);
    s ~= " " ~ safeWords.get(param.name, param.name);
    return s;
}

alias StringSet = RedBlackTree!string;
alias TypeSet = bool[TypeDef];

StringSet[string] dependencies;
TypeSet[TypeDef] nestedMap;

string[string] safeWords;

bool[string] skipInterfaces;
bool[string] skipMethods;

void buildDependencies(TypeDef type, string namespace, StringSet rb)
{
    foreach(field; type.fields)
    {
        auto dep = fullnameof(field.signature.typeSig.type);
        if (dep.length && dep[0] != '.' && !dep.startsWith(namespace ~ '.'))                
            rb.insert(dep);                   
    }

    if (type in nestedMap)
    {
        foreach(nstruct; nestedMap[type].byKey)
        {
            buildDependencies(nstruct, namespace, rb);
        }
    }

    foreach(meth; type.methods)
    {   
        auto sig = meth.signature;              

        auto dep = fullnameof(sig.retSig.typeSig.type);
        if (dep.length && dep[0] != '.' && !dep.startsWith(namespace ~ '.'))                
            rb.insert(dep);   

        foreach(par; sig.params)
        {                    
            dep = fullnameof(par.typeSig.type);
            if (dep.length && dep[0] != '.' && !dep.startsWith(namespace ~ '.'))                
                rb.insert(dep);  
        }
    }

    foreach (interf; type.interfaces)
    {
        auto dep = fullnameof(interf.implementation);
        if (namespace == "Windows.Win32.DirectShow" && dep == "Windows.Win32.Mmc.IComponent")
            dep = "Windows.Win32.DirectShow.IComponent";
        if (namespace == "Windows.Win32.Controls" && dep == "Windows.Win32.Mmc.IImageList")
            dep = "Windows.Win32.Controls.IImageList";
        if (dep.length && dep[0] != '.' && !dep.startsWith(namespace))                
            rb.insert(dep);   
    }            
}





enum linkCleanup = ctRegex!(`<a .*?href="(.*?)">(.*?)<\/a>`, "g");
enum spaceCleanup = ctRegex!(r"(\r\n)+|\r+|\n+|\t+|\s\s+", "g");

string cleanText( string s)
{
    return replaceAll(replaceAll(s, linkCleanup, "$2"), spaceCleanup, " ");
}

struct MDMatcher
{
    private enum returnsPattern = ctRegex!(r"## -returns(.*?)(?=##)", "gs");
    private enum uidPattern = ctRegex!(r"UID: (.*)", "g");
    private enum descriptionPatternSmall = ctRegex!(r"description: (.*)", "g");
    private enum descriptionPatternBig = ctRegex!(r"## -description(.*?)(?=##)", "gs");
    private enum titlePattern = ctRegex!(r"title: (.*)", "g");
    private enum paramPattern = ctRegex!(r"### -param(.*?)(?=#)", "gs");
    private enum fieldPattern = ctRegex!(r"### -field(.*?)(?=#)", "gs");
    private enum keywordsPattern = ctRegex!(r"keywords: (.*)", "g");
    private string content;

    public this(string s)
    {
        content = s;
    }

    public bool isEnum()
    {
        return uid.startsWith("NE:");
    }

    public bool isFunction()
    {
        return uid.startsWith("NF:");
    }

    public bool isStruct()
    {
        return uid.startsWith("NS:");
    }

    public bool isInterface()
    {
        return uid.startsWith("NN:");
    }

    public bool isCallback()
    {
        return uid.startsWith("NC:");
    }

    public bool isClass()
    {
        return uid.startsWith("NL:");
    }

    public bool isIOCTL()
    {
        return uid.startsWith("NI:");
    }

    public string returns()
    {
        auto match = matchFirst(content, returnsPattern);
        return match.empty ? null : cleanText(match[0][12 .. $]); 
    }

    public string uid()
    {
        auto match = matchFirst(content, uidPattern);
        return match.empty ? null : match[0][5 .. $]; 
    }

    public string title()
    {
        auto match = matchFirst(content, titlePattern);
        return match.empty ? null : match[0][7 .. $]; 
    }

    public string keyFromUID()
    {
        auto s = uid;

        if (s.length > 3 && s[2] == ':')
            s = s[3 .. $];
        auto p = s.indexOf('.');
        if (p > 0)
            s = s[p + 1 .. $];
        
        while (s.startsWith('_'))        
            s = s[1 .. $];

        return s;
    }

    public string keyFromTitle()
    {
        auto s = title();
        auto q = s.indexOf(' ');
        s = s.replace("::", ".");
        return q > 0 ? s[0 .. q] : s;
    }


    public string description()
    {
        auto match = matchFirst(content, descriptionPatternBig);
        if (!match.empty) 
            return match.empty ? null : cleanText(match[0][16 .. $]);
        match = matchFirst(content, descriptionPatternSmall);
        return match.empty ? null : cleanText(match[0][13 .. $]);
    }

    public auto keywords()
    {

        return matchAll(content, keywordsPattern)
            .map!(a => a.hit.stripLeft("[").strip("]"))
            .fold!((a, b) => a ~ "," ~ b)("")
            .splitter(',')
            .map!(a => a.stripLeft("\" '").strip("\" '"))
            .filter!(a => a.length && !a.any!(b => b == ' ' || b == '\\' || b == '/' || b == ':'))
            .array
            .sort
            .uniq;
    }

    public bool match(string id)
    {
        return keywords.any!(a => a == id);
    }

    public auto params()
    {
        return matchAll(content, paramPattern)            
            .map!(a => MDParam(a.hit));    

    }

    public auto fields()
    {
        return matchAll(content, fieldPattern)
            .map!(a => MDField(a.hit));            
    }
}

struct MDParam
{

    private enum namePattern = ctRegex!(r"(?<=^### -param )([A-Za-z0-9_]*)", "g");
    private enum descriptionPattern = ctRegex!(r"(?<=\n).*", "gs");

    private string content;

    this(string s)
    {
        this.content = s;
    }

    public string name()
    {
        auto match = matchFirst(content, namePattern);
        return match.empty ? null : match[0];
    }

    public string description()
    {
        auto match = matchFirst(content, descriptionPattern);
        return match.empty ? null : cleanText(match[0]);
    }
}

struct MDField
{

    private enum namePattern = ctRegex!(r"(?<=^### -field )([A-Za-z0-9_]*)", "g");
    private enum descriptionPattern = ctRegex!(r"(?<=\n).*", "gs");
    private string content;

    this(string s)
    {
        this.content = s;
    }

    public string name()
    {
        auto match = matchFirst(content, namePattern);
        return match.empty ? null : match[0];
    }

    public string description()
    {
        auto match = matchFirst(content, descriptionPattern);
        return match.empty ? null : cleanText(match[0]);
    }
}

MDMatcher[string] docMatcher;

MDMatcher* findDoc(string name)
{
    auto matcher = name in docMatcher;
    //takes tooooooooooo long
    //if (matcher)
    //    return matcher;
    //foreach(m; docMatcher.byKeyValue)
    //{
    //    if(m.value.match(name))
    //        return m.key in docMatcher;
    //}
    return matcher;
}

int main(string[] args)
{
    string[string] configNamespace;
    
    

    
    TypeSet[TypeDef] attributeMap;

    string mdFileName;
    string outDirectory;
    string cfgIgnoreFileName;
    string cfgReplaceFileName;
    string cfgCoreFileName;
    string docsDirectory;


    GetoptResult info;

    enum usage = 
        "Usage: \n" ~
        "  wind --meta <filename> --core <filename>\n" ~
        "  wind --meta <filename> --core <filename> --out <dir> --ignore <filename> --replace <filename>";

    try
    {
        info = getopt(args,
            config.required, "meta|m",     "winmd file to process",                &mdFileName, 
                             "out|o",      "output directory (defaults to 'out')", &outDirectory,
                             "ignore|i",   "namespaces to ignore",                 &cfgIgnoreFileName,
                             "replace|r",  "namespaces to replace",                &cfgReplaceFileName,
                             "docs|d",     "generate documentation",               &docsDirectory,
            config.required, "core|c",     "core.d file to be copied",             &cfgCoreFileName,
        );
    }
    catch(GetOptException e)
    {
        writeln(e.msg);        
        writeln(usage);
        writeln("  wind -h for help");
        return -1;
    }
    
    if (info.helpWanted)
    {
        writeln(usage);
        defaultGetoptPrinter("Windows bindings generator for D",
                             info.options);
        
        return 0;
    }
  
    if (outDirectory.length == 0)
        outDirectory = "out";

    if (docsDirectory.length && !exists(docsDirectory))
    {
        writefln("Mising sdk docs (%s)", buildNormalizedPath(absolutePath(docsDirectory)));
        return -1;
    }
   
    if (!exists(cfgCoreFileName))
    {
        writefln("Mising core.d (%s)", buildNormalizedPath(absolutePath(cfgCoreFileName)));
        return -1;
    }
    
    if (cfgReplaceFileName.length)
    {
        auto cfgReplaceFile = std.stdio.File(cfgReplaceFileName);
    
        foreach(line; cfgReplaceFile.byLine(KeepTerminator.no))
        {
            auto items = line.strip('\r').strip('\n').split('=');
            configNamespace[items[0].toLower.idup] = items[1].toLower.idup;
        }
    }

    string[] cfgIgnoredNamespaces;

    if (cfgIgnoreFileName.length)
    {
        auto cfgIgnoreFile = std.stdio.File(cfgIgnoreFileName);
        cfgIgnoredNamespaces = cfgIgnoreFile.byLine(KeepTerminator.no).map!(a => a.strip('\r').strip('\n').idup).array;
    }

    safeWords = [
        "abstract" : "abstract_",
        "alias" : "alias_",
        "align" : "align_",
        "auto" : "auto_",
        "body" : "body_",
        "byte" : "byte_",
        "cast" : "cast_",
        "cdouble" : "cdouble_",
        "cent" : "cent_",
        "cfloat" : "cfloat_",
        "class" : "class_",
        "creal" : "creal_",
        "dchar" : "dchar_",
        "debug" : "debug_",
        "default" : "default_",
        "delegate" : "delegate_",
        "delete" : "delete_",
        "deprecated" : "deprecated_",
        "export" : "export_",
        "extern" : "extern_",
        "false" : "false_",
        "final" : "final_",
        "finally" : "finally_",
        "foreach" : "foreach_",
        "foreach_reverse" : "foreach_reverse_",
        "function" : "function_",
        "idouble" : "idouble_",
        "ifloat" : "ifloat_",
        "immutable" : "immutable_",
        "import" : "import_",
        "in" : "in_",
        "inout" : "inout_",
        "interface" : "interface_",
        "invariant" : "invariant_",
        "ireal" : "ireal_",
        "is" : "is_",
        "lazy" : "lazy_",
        "macro" : "macro_",
        "mixin" : "mixin_",
        "module" : "module_",
        "nothrow" : "nothrow_",
        "null" : "null_",
        "out" : "out_",
        "override" : "override_",
        "package" : "package_",
        "pragma" : "pragma_",
        "pure" : "pure_",
        "real" : "real_",
        "ref" : "ref_",
        "scope" : "scope_",
        "shared" : "shared_",
        "struct" : "struct_",
        "super" : "super_",
        "true" : "true_",
        "typeof" : "typeof_",
        "ubyte" : "ubyte_",
        "ucent" : "ucent_",
        "uint" : "uint_",
        "ulong" : "ulong_",
        "unittest" : "unittest_",
        "ushort" : "ushort_",
        "version" : "version_",
        "wchar" : "wchar_",
        "with" : "with_",
        "__FILE__" : "FILE",
        "__FILE_FULL_PATH__" : "FILE_FULL_PATH",
        "__MODULE__" : "MODULE",
        "__LINE__" : "LINE",
        "__FUNCTION__" : "FUNCTION",
        "__PRETTY_FUNCTION__" : "PRETTY_FUNCTION",
        "__gshared" : "gshared",
        "__traits" : "traits",
        "__vector" : "vector",
        "__parameters" : "parameters",
        "GUID" : "Guid",
    ];

    skipInterfaces = [
        "IGraphicsEffectD2D1Interop" : true,
        "ICompositorInterop" : true,
        "ICompositionCapabilitiesInteropFactory" : true,
        "ICompositorDesktopInterop" : true,
        "IDesktopWindowContentBridgeInterop" : true,
        "IUIAutomation6": true
    ];

    skipMethods = [
        "CreateDispatcherQueueController" : true,
    ];

    if (docsDirectory.length)
    {
        writeln("Parsing SDK documentation...");
        foreach(md; dirEntries(docsDirectory, "??-*-*.md", SpanMode.depth, false))
        {
            auto matcher = MDMatcher(readText(md.name));
            auto k1 = matcher.keyFromUID;
            auto k2 = matcher.keyFromTitle;
            docMatcher[k1] = matcher;
            if (k2 != k1)
                docMatcher[k2] = matcher;
        }
        docMatcher.rehash();
    }

    

    auto metadata = Metadata(mdFileName);
    auto namespaces = getNamespaces(metadata, cfgIgnoredNamespaces);



    writeln("Building dependency graph...");

    foreach(nestedRecord; metadata.nestedClassTable.items)
    {
        auto child = nestedRecord.nested;
        auto parent = nestedRecord.enclosing;
        if (auto aa = parent in nestedMap)
            (*aa)[child] = true;
        else
        {
            auto aa = [child : true];            
            nestedMap[parent] = aa;
        }
    }
    nestedMap.rehash();

    foreach(namespace; namespaces)
    {
        auto rb = new RedBlackTree!string();
        dependencies[namespace] = rb;

        foreach(type; getTypeDefs(metadata, namespace))
        {            
            buildDependencies(type, namespace, rb);
        }
    }

    


    
    
    if (exists(outDirectory) && isDir(outDirectory))
        rmdirRecurse(outDirectory);
    
    bool mustCopyCore = true;
    foreach(namespace; namespaces)
    {
        string path = makePath(outDirectory, namespace, configNamespace) ~ ".d";
        string modName = makeModuleName(namespace, configNamespace);        
        mkdirRecurse(dirName(path));        
        if (mustCopyCore)
        {
            copy(cfgCoreFileName, buildPath(dirName(path), "core.d"));
            mustCopyCore = false;
        }
        auto f = std.stdio.File(path, "w");
        f.writeln("// Written in the D programming language.");
        f.writeln();
        f.writefln("module %s;", modName);
        f.writeln;
        writefln("Processing %s", namespace);
        f.writeln("public import windows.core;");

        auto imports = dependencies[namespace].array.filter!(a => !cfgIgnoredNamespaces.canFind(getns(a))).array.sort;

        string lastNamespace;
        bool atLeastOne;
        ptrdiff_t w, v;
        foreach(i; imports)
        {
            atLeastOne = true;
            auto n = getns(i);
            if (n != lastNamespace)
            {
                if (lastNamespace.length)
                    f.writeln(";");
                auto moduleName = makeModuleName(n, configNamespace);
                auto importName = getname(i);
                f.writef("public import %s : %s", moduleName, importName);
                lastNamespace = n;
                w = 17 + moduleName.length + importName.length;
                v = w - importName.length;
            }
            else
            {
                auto importName = getname(i);
                if (importName.length + w > maxLineWidth - 3)
                {
                    f.writeln(",");                    
                    f.write("".padLeft(' ', v));
                    w = v;
                }
                else
                    f.write(", ");
                f.write(importName);
                w += importName.length + 2;
                w += importName.length + 2;
            }
        }
        if (atLeastOne)
            f.writeln(";");

        f.writeln;
        f.writeln("extern(Windows):");
        f.writeln;
                
        dumpEnums(f, metadata, namespace, docsDirectory.length > 0);    
        dumpApisConstants(f, metadata, namespace);
        dumpDelegates(f, metadata, namespace,docsDirectory.length > 0);
        dumpStructs(f, metadata, namespace,docsDirectory.length > 0);
        dumpApis(f, metadata, namespace,docsDirectory.length > 0);
        dumpInterfaces(f, metadata, namespace,docsDirectory.length > 0);
    }



    writeln;

    writeln("Press any key to continue.");
    

    getchar();

    return 0;
}

