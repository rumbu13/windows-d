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




void writeType(std.stdio.File f, const ref TypeSig sig, bool isConst = false, int nativeReplacement = 0)
{
    
    if (nativeReplacement)
    {
        switch(nativeReplacement)
        {
            case 20 : f.write("const(char)*"); return;
            case 21 : f.write("const(wchar)*"); return;
            case 42 : f.write("char*"); return;
            default : f.writef("/*UNKNOWN NATIVE - %s*/", nativeReplacement);
        }
    }

    if (isConst)
        f.write("const(");

    if (auto elType = sig.type.peek!ElementType)
    {
        switch(*elType)
        {
            case ElementType.boolean:
                f.write("bool"); break;
            case ElementType.char_:
                f.write("wchar"); break;
            case ElementType.i1:
                f.write("byte"); break;
            case ElementType.u1:
                f.write("ubyte"); break;         
            case ElementType.i2:
                f.write("short"); break;
            case ElementType.u2:
                f.write("ushort"); break;         
            case ElementType.i4:
                f.write("int"); break;
            case ElementType.u4:
                f.write("uint"); break;         
            case ElementType.i8:
                f.write("long"); break;
            case ElementType.u8:
                f.write("ulong"); break;    
            case ElementType.r4:
                f.write("float"); break;    
            case ElementType.r8:
                f.write("double"); break;    
            case ElementType.string:
                f.write("wstring"); break; 
            case ElementType.object:
                f.write("object"); break; 
            case ElementType.void_:
                f.write("void"); break; 
            case ElementType.i:
                f.write("int"); break; 
            case ElementType.u:
                f.write("uint"); break; 
            default:
                f.writef("// unknown element type for "); break;
        }
    }
    else if (auto elType = sig.type.peek!TypeRef)
        f.write(elType.name); 
    else if (auto elType = sig.type.peek!TypeDef)
        f.write(elType.name); 
    else
        f.writef("/* unknown type */");

    if (isConst)
        f.write(")");

    for (int i = 0; i < sig.ptrCount; ++i)
        f.write("*");
}

void writeField(std.stdio.File f, Field field, int level)
{
    
    f.write("".padLeft(' ', level * 4));
    bool isConst;
    
    int nativeReplacement;
    foreach(ca; field.attributes)
    {
        if (ca.name == "ConstAttribute")
            isConst = true;
        else if (ca.name == "NativeTypeInfoAttribute")
        {
            auto fixed = ca.value.fixed[0];
            auto element = fixed.value.get!ElementSig;
            nativeReplacement = element.value.get!int;
        }
        else
        {
            f.writefln("//FIELD ATTR: %s : %s", ca.name, ca.value);
            f.write("".padLeft(' ', level * 4));
        }
    }
        
    auto attr = field.fieldAttributes;
    if (attr.isLiteral)
        f.write("enum ");
    auto sig = field.signature.typeSig;    
    writeType(f, sig, isConst, nativeReplacement);
    f.write(" ");
    f.write(field.name);
    if (attr.isLiteral)
    {
        auto ct = field.constant;
        if (!ct.isNull)
        {
            f.write(" = ");
            f.write(ct.get.value);
        }
    }
    f.writeln(";");
    
}

void writeEnumMember(std.stdio.File f, Field field, int level)
{
    f.write("".padLeft(' ', level * 4));
    foreach(ca; field.attributes)
        f.writefln("//FIELD ATTR: %s : %s", ca.name, ca.value);
    f.writef("%s", field.name);
    auto attr = field.fieldAttributes;
    if (attr.isLiteral)
    {
        auto ct = field.constant;
        if (!ct.isNull)
        {
            f.writef(" = %s", ct.get.value);
        }
    }
    f.writeln(",");
    
}

void writeEnum(std.stdio.File f, TypeDef type)
{
    foreach(ca; type.attributes)
        f.writefln("//ENUM ATTR: %s : %s", ca.name, ca.value);
    f.writefln("enum %s", type.name);
    f.writefln("{");
    foreach (fld; type.fields)
        if (!fld.fieldAttributes.hasRuntimeSpecialName)
            writeEnumMember(f, fld, 1);
    f.writefln("}");
    f.writefln("");
}

void writeGUIDAttr(std.stdio.File f, CustomAttributeSig sig, string name, string prefix)
{
    auto fixed = sig.fixed[0];
    auto element = fixed.value.get!ElementSig;
    auto str = element.value.get!string;
    auto textGuid = format("0x%s, 0x%s, 0x%s, [0x%s, 0x%s, 0x%s, 0x%s, 0x%s, 0x%s, 0x%s, 0x%s]", str[0 .. 8], str[9 .. 13], str[14 .. 18], 
                           str[19 .. 21], str[21 .. 23], str[24 .. 26], str[26 .. 28], str[28 .. 30], str[30 .. 32], str[32 .. 34],
                           str[34 .. 36]);

    if (prefix.length)
        f.writefln("const GUID %s_%s = {%s};", prefix, name, textGuid);
    f.writefln("@GUID(%s);", textGuid);
}

void writeStruct(std.stdio.File f, TypeDef type)
{

    bool isStronglyTyped;
    foreach(ca; type.attributes)
    {
        if (ca.name == "GuidAttribute")
        {
            writeGUIDAttr(f, ca.value, type.name, "CLSID");        
            f.writefln("struct %s;", type.name);
            f.writeln;
            return;
        }
        else if (ca.name == "NativeTypedefAttribute")
        {
            isStronglyTyped = true;
        }
        else if (ca.name == "RAIIFreeAttribute")
        {
            //just ignore
        }
        else
            f.writefln("//STRUCT ATTR: %s : %s", ca.name, ca.value);
    }

    if (isStronglyTyped)
    {
        auto fld = type.fields.front;
        auto sig = fld.signature.typeSig;
        f.writef("alias %s = ", type.name);
        writeType(f, sig, fld.attributes.any!(a => a.name == "ConstAttribute"));
        f.writeln(";");
        return;
    }
  
    f.writefln("struct %s", type.name);
    f.writefln("{");
    foreach (fld; type.fields)
        writeField(f, fld, 1);
    f.writeln("}");
    f.writeln;
}

void writeDelegate(std.stdio.File f, TypeDef type)
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
            f.writef("alias %s = ", type.name);

            if (conv.length)
                f.writef("extern(%s) ", conv);

            auto sig = meth.signature;
            if (sig.retSig.isByRef)
                f.write("ref");
            if (sig.retSig.isVoid)
                f.write("void");
            else
                writeType(f, sig.retSig.typeSig);

            f.writef(" function(");

            Param[int] paramNames;
            foreach(p; meth.parameters)
                paramNames[p.rank] = p;

            int idx = 1;

            bool atLeastOne;
            foreach(param; sig.params)
            {
                if (atLeastOne)
                    f.write(", ");
                writeParam(f, param, paramNames[idx++]);
                atLeastOne = true;
            }

            f.writeln(");");
            return;
        }
    }

    f.writefln("//missing delegate %s", type.name);
}

void writeParam(std.stdio.File f, const ref ParamSig sig, const ref Param param)
{
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
            f.writef("/*PARAM ATTR: %s : %s*/", ca.name, ca.value);
    }
    if (sig.isByRef)
        f.write("ref ");
    auto attr = param.paramAttributes;
    //if (attr.isIn)
    //    f.write("in ");
    //if (attr.isOut)
    //    f.write("/* out */ ");
    //if (attr.isOptional)
    //    f.write("/* optional */ ");
    writeType(f, sig.typeSig, isConst, nativeReplacement);
    f.writef(" %s", param.name);
    
}

void writeMethod(std.stdio.File f, MethodDef meth, int level)
{
    f.write("".padLeft(' ', level * 4));
    foreach(ca; meth.attributes)
    {
          f.writefln("//METH ATTR: %s : %s", ca.name, ca.value);
    }

    auto impl = meth.implementation;
    if (!impl.isNull)
    {
        auto dllName = impl.get.importScope.name;
        f.writefln("@DllImport(\"%s.dll\")", dllName);
    }
    
    auto sig = meth.signature;
    if (sig.retSig.isByRef)
        f.write("ref");
    if (sig.retSig.isVoid)
        f.write("void");
    else
        writeType(f, sig.retSig.typeSig);

    f.writef(" %s(", meth.name);

    Param[int] paramNames;
    foreach(p; meth.parameters)
        paramNames[p.rank] = p;
    
    int idx = 1;

    bool atLeastOne;
    foreach(param; sig.params)
    {
        if (atLeastOne)
            f.write(", ");
        writeParam(f, param, paramNames[idx++]);
        atLeastOne = true;
    }

    f.writeln(");");
    if (!level) 
        f.writeln;
}

void writeClass(std.stdio.File f, TypeDef type)
{
    if (type.name == "Apis")
    {
        foreach(meth; type.methods)
        {            
            writeMethod(f, meth, 0);
        }
    }
    else
        f.writefln("//missing class %s", type.name);
}

void writeInterface(std.stdio.File f, TypeDef type)
{
    foreach(ca; type.attributes)
    {
        if (ca.name == "GuidAttribute")
        {
             writeGUIDAttr(f, ca.value, type.name, "IID");          
        }
        else
            f.writefln("//INTF ATTR: %s : %s", ca.name, ca.value);
    }
    f.writef("interface %s", type.name);
        
    bool atLeastOne;    
    foreach (interf; type.interfaces)
    {
        auto impl = interf.implementation;
        if (auto td = impl.peek!TypeDef)
        {
            f.write(atLeastOne ? ", ": " : ");
            f.write(td.name);
            atLeastOne = true;
        }
        else if (auto td = impl.peek!TypeRef)
        {
            f.write(atLeastOne ? ", ": " : ");
            f.write(td.name);
            atLeastOne = true;
        }
    }
    f.writeln;
    f.writefln("{");
    foreach(meth; type.methods)
    {            
        writeMethod(f, meth, 1);
    }
    f.writeln("}");
    f.writeln;
}

void writeType(std.stdio.File f, TypeDef type)
{
    if (type.isInterface)
        writeInterface(f, type);
    else if (type.isEnum)
        writeEnum(f, type);
    else if (type.isValueType)
        writeStruct(f, type);
    else if (type.isDelegate)
        writeDelegate(f, type);
    else
        writeClass(f, type);
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

int main(string[] args)
{
    string[string] configNamespace;
    alias StringSet = RedBlackTree!string;
    StringSet[string] deps;

    string mdFileName;
    string outDirectory;
    string cfgIgnoreFileName;
    string cfgReplaceFileName;


    GetoptResult info;

    enum usage = 
        "Usage: \n" ~
        "  wind --metadata <filename>\n" ~
        "  wind --metadata <filename> --output <dir> --ignore <filename> --replace <filename>";

    try
    {
        info = getopt(args,
            config.required, "metadata|m",  "winmd file to process",                &mdFileName, 
                             "output|o",    "output directory (defaults to 'out')", &outDirectory,
                             "ignore|i",    "namespaces to ignore",                 &cfgIgnoreFileName,
                             "replace|r",   "namespaces to replace",                &cfgReplaceFileName,
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

    



    auto metadata = Metadata(mdFileName);
    auto namespaces = getNamespaces(metadata, cfgIgnoredNamespaces);

    writefln("Building dependency graph...");
    foreach(namespace; namespaces)
    {
        auto rb = new RedBlackTree!string();
        deps[namespace] = rb;
       
        foreach(type; getTypeDefs(metadata, namespace))
        {
            foreach(field; type.fields)
            {
                string ns;
                auto sig = field.signature.typeSig;
                if (auto elType = sig.type.peek!TypeRef)
                    ns = elType.namespace;
                else if (auto elType = sig.type.peek!TypeDef)
                    ns = elType.namespace;
                if (ns.length && ns != namespace)
                {
                   rb.insert(ns);
                }
            }

            foreach(meth; type.methods)
            {   
                string ns;
                auto sig = meth.signature;
                auto rsig = sig.retSig.typeSig;
                if (auto elType = rsig.type.peek!TypeRef)
                    ns = elType.namespace;
                else if (auto elType = rsig.type.peek!TypeDef)
                    ns = elType.namespace;
                if (ns.length && ns != namespace)
                    rb.insert(ns);

                foreach(par; sig.params)
                {                    
                    ns.length = 0;
                    if (auto elType = par.typeSig.type.peek!TypeRef)
                        ns = elType.namespace;
                    else if (auto elType = par.typeSig.type.peek!TypeDef)
                        ns = elType.namespace;
                    if (ns.length && ns != namespace)
                        rb.insert(ns);

                }
            }

            foreach (interf; type.interfaces)
            {
                string ns;
                auto impl = interf.implementation;
                if (auto td = impl.peek!TypeDef)
                    ns = td.namespace;
                else if (auto td = impl.peek!TypeRef)
                    ns = td.namespace;
                if (ns.length && ns != namespace)
                    rb.insert(ns);
            }
        }
    }



    foreach(namespace; namespaces)
    {
        string path = makePath(outDirectory, namespace, configNamespace) ~ ".d";
        string modName = makeModuleName(namespace, configNamespace);
        mkdirRecurse(dirName(path));        
        auto f = std.stdio.File(path, "w");
        f.writefln("module %s;", modName);
        f.writeln;
        writefln("Processing %s", namespace);
        foreach(ns; deps[namespace])
            f.writefln("public import %s;", makeModuleName(ns, configNamespace));
        f.writeln;
        f.writeln("extern(Windows):");
        f.writeln;

        foreach(type; metadata.getTypeDefs(namespace))        
            writeType(f, type);        
    }



    writeln;

    writeln("Press any key to continue.");
    

    getchar();

    return 0;
}

