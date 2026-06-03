module climetadata.mdtable.row;

import std.exception : enforce;

import climetadata.mdtable.value;
import climetadata.mdtable.table : Table;
import climetadata.mdtable.type;

public struct Row(MDTableType md)
{
    @disable this();

    // Attention: rowID is 1-based
    public this(const(Table!md*) table, uint rowID)
    {
        assert(table != null, "Row(): table is null");

        this.table = table;
        this.rowID = rowID;
    }

    static if (md == MDTableType.module_)
    {
        mixin moduleGetters!();
    } 
    else static if (md == MDTableType.typeRef)
    {
        mixin typeRefGetters!();
    }
    else static if (md == MDTableType.typeDef)
    {
        mixin typeDefGetters!();
    }
    else static if (md == MDTableType.field)
    {
        mixin fieldGetters!();
    }
    else static if (md == MDTableType.methodDef)
    {
        mixin methodDefGetters!();
    }
    else static if (md == MDTableType.param)
    {
        mixin paramGetters!();
    }
    else static if (md == MDTableType.interfaceImpl)
    {
        mixin interfaceImplGetters!();
    }
    else static if (md == MDTableType.memberRef)
    {
        mixin memberRefGetters!();
    }
    else static if (md == MDTableType.constant)
    {
        mixin constantGetters!();
    }
    else static if (md == MDTableType.customAttribute)
    {
        mixin customAttributeGetters!();
    }
    else static if (md == MDTableType.fieldMarshal)
    {
        mixin fieldMarshalGetters!();
    }
    else static if (md == MDTableType.declSecurity)
    {
        mixin declSecurityGetters!();
    }
    else static if (md == MDTableType.classLayout)
    {
        mixin classLayoutGetters!();
    }
    else static if (md == MDTableType.fieldLayout)
    {
        mixin fieldLayoutGetters!();
    }
    else static if (md == MDTableType.standAloneSig)
    {
        mixin standAloneSigGetters!();
    }
    else static if (md == MDTableType.eventMap)
    {
        mixin eventMapGetters!();
    }
    else static if (md == MDTableType.event)
    {
        mixin eventGetters!();
    }
    else static if (md == MDTableType.propertyMap)
    {
        mixin propertyMapGetters!();
    }
    else static if (md == MDTableType.property)
    {
        mixin propertyGetters!();
    }
    else static if (md == MDTableType.methodSemantics)
    {
        mixin methodSemanticsGetters!();
    }
    else static if (md == MDTableType.methodImpl)
    {
        mixin methodImplGetters!();
    }
    else static if (md == MDTableType.moduleRef)
    {
        mixin moduleRefGetters!();
    }
    else static if (md == MDTableType.typeSpec)
    {
        mixin typeSpecGetters!();
    }
    else static if (md == MDTableType.implMap)
    {
        mixin implMapGetters!();
    }
    else static if (md == MDTableType.fieldRVA)
    {
        mixin fieldRVAGetters!();
    }
    else static if (md == MDTableType.assembly)
    {
        mixin assemblyGetters!();
    }
    else static if (md == MDTableType.assemblyProcessor)
    {
        mixin assemblyProcessorGetters!();
    }
    else static if (md == MDTableType.assemblyOS)
    {
        mixin assemblyOSGetters!();
    }
    else static if (md == MDTableType.assemblyRef)
    {
        mixin assemblyRefGetters!();
    }
    else static if (md == MDTableType.assemblyRefProcessor)
    {
        mixin assemblyRefProcessorGetters!();
    }
    else static if (md == MDTableType.assemblyRefOS)
    {
        mixin assemblyRefOSGetters!();
    }
    else static if (md == MDTableType.file)
    {
        mixin fileGetters!();
    }
    else static if (md == MDTableType.exportedType)
    {
        mixin exportedTypeGetters!();
    }
    else static if (md == MDTableType.manifestResource)
    {
        mixin manifestResourceGetters!();
    }
    else static if (md == MDTableType.nestedClass)
    {
        mixin nestedClassGetters!();
    }
    else static if (md == MDTableType.genericParam)
    {
        mixin genericParamGetters!();
    }
    else static if (md == MDTableType.methodSpec)
    {
        mixin methodSpecGetters!();
    }
    else static if (md == MDTableType.genericParamConstraint)
    {
        mixin genericParamConstraintGetters!();
    }
    else
    {
    }

    // Row ID is 1-based
    pragma(inline, true)
    public uint getRowID() const 
    {
        return rowID;
    }

    pragma(inline, true)
    public bool isNull() const
    {
        return rowID == 0 || rowID > table.rowCount;
    }

    pragma(inline, true)
    public const(Table!md*) getTable() const 
    {
        return table;
    }

    @safe pure nothrow
    public bool opEquals()(auto ref const Row!md other) const
    {
        return this.rowID == other.rowID;
    }

    @safe pure nothrow
    public int opCmp(ref const Row!md other) const
    {
        if (this.rowID > other.rowID)
            return 1;
        if (this.rowID < other.rowID)
            return -1;
        return 0;
    }

    @safe pure nothrow
    public size_t toHash() const
    {
        return rowID;
    }

private:
    const(Table!md*) table;
    const uint rowID; // Row ID is 1-based
}

private mixin template moduleGetters()
{
    //mixin DeclColumn!(MDTableType.module_, 0, ushort, ValueKind.Unused, "Unused");
    mixin DeclColumn!(MDTableType.module_, 1, uint, ValueKind.String, "Name");
    mixin DeclColumn!(MDTableType.module_, 2, uint, ValueKind.Guid, "Mvid");
    mixin DeclColumn!(MDTableType.module_, 3, uint, ValueKind.Guid, "EncId");
    mixin DeclColumn!(MDTableType.module_, 4, uint, ValueKind.Guid, "EncBaseId");
}

private mixin template typeRefGetters()
{
    mixin DeclColumn!(MDTableType.typeRef, 0, uint, ValueKind.CodedIndex, "ResolutionScope");
    mixin DeclColumn!(MDTableType.typeRef, 1, uint, ValueKind.String, "TypeName");
    mixin DeclColumn!(MDTableType.typeRef, 2, uint, ValueKind.String, "TypeNamespace");
}

private mixin template typeDefGetters()
{
    mixin DeclColumn!(MDTableType.typeDef, 0, uint, ValueKind.Integral, "Flags");
    mixin DeclColumn!(MDTableType.typeDef, 1, uint, ValueKind.String, "TypeName");
    mixin DeclColumn!(MDTableType.typeDef, 2, uint, ValueKind.String, "TypeNamespace");
    mixin DeclColumn!(MDTableType.typeDef, 3, uint, ValueKind.CodedIndex, "Extends");
    mixin DeclColumn!(MDTableType.typeDef, 4, uint, ValueKind.Index, "FieldList");
    mixin DeclColumn!(MDTableType.typeDef, 5, uint, ValueKind.Index, "MethodList");
}

private mixin template fieldGetters()
{
    mixin DeclColumn!(MDTableType.field, 0, ushort, ValueKind.Integral, "Flags");
    mixin DeclColumn!(MDTableType.field, 1, uint, ValueKind.String, "Name");
    mixin DeclColumn!(MDTableType.field, 2, uint, ValueKind.Blob, "Signature");
}

private mixin template methodDefGetters()
{
    mixin DeclColumn!(MDTableType.methodDef, 0, uint, ValueKind.Integral, "RVA");
    mixin DeclColumn!(MDTableType.methodDef, 1, ushort, ValueKind.Integral, "ImplFlags");
    mixin DeclColumn!(MDTableType.methodDef, 2, ushort, ValueKind.Integral, "Flags");
    mixin DeclColumn!(MDTableType.methodDef, 3, uint, ValueKind.String, "Name");
    mixin DeclColumn!(MDTableType.methodDef, 4, uint, ValueKind.Blob, "Signature");
    mixin DeclColumn!(MDTableType.methodDef, 5, uint, ValueKind.Index, "ParamList");
}

private mixin template paramGetters()
{
    mixin DeclColumn!(MDTableType.param, 0, ushort, ValueKind.Integral, "Flags");
    mixin DeclColumn!(MDTableType.param, 1, ushort, ValueKind.Integral, "Sequence");
    mixin DeclColumn!(MDTableType.param, 2, uint, ValueKind.String, "Name");
}

private mixin template interfaceImplGetters()
{
    mixin DeclColumn!(MDTableType.interfaceImpl, 0, uint, ValueKind.Index, "Class");
    mixin DeclColumn!(MDTableType.interfaceImpl, 1, uint, ValueKind.CodedIndex, "Interface");
}

private mixin template memberRefGetters()
{
    mixin DeclColumn!(MDTableType.memberRef, 0, uint, ValueKind.CodedIndex, "Class");
    mixin DeclColumn!(MDTableType.memberRef, 1, uint, ValueKind.String, "Name");
    mixin DeclColumn!(MDTableType.memberRef, 2, uint, ValueKind.Blob, "Signature");
}

private mixin template constantGetters()
{
    mixin DeclColumn!(MDTableType.constant, 0, ushort, ValueKind.Integral, "Type");
    mixin DeclColumn!(MDTableType.constant, 1, uint, ValueKind.CodedIndex, "Parent");
    mixin DeclColumn!(MDTableType.constant, 2, uint, ValueKind.Blob, "Value");
}

private mixin template customAttributeGetters()
{
    mixin DeclColumn!(MDTableType.customAttribute, 0, uint, ValueKind.CodedIndex, "Parent");
    mixin DeclColumn!(MDTableType.customAttribute, 1, uint, ValueKind.CodedIndex, "Type");
    mixin DeclColumn!(MDTableType.customAttribute, 2, uint, ValueKind.Blob, "Value");
}

private mixin template fieldMarshalGetters()
{
    mixin DeclColumn!(MDTableType.fieldMarshal, 0, uint, ValueKind.CodedIndex, "Parent");
    mixin DeclColumn!(MDTableType.fieldMarshal, 1, uint, ValueKind.Blob, "NativeType");
}

private mixin template declSecurityGetters()
{
    mixin DeclColumn!(MDTableType.declSecurity, 0, ushort, ValueKind.Integral, "Action");
    mixin DeclColumn!(MDTableType.declSecurity, 1, uint, ValueKind.CodedIndex, "Parent");
    mixin DeclColumn!(MDTableType.declSecurity, 2, uint, ValueKind.Blob, "PermissionSet");
}

private mixin template classLayoutGetters()
{
    mixin DeclColumn!(MDTableType.classLayout, 0, ushort, ValueKind.Integral, "PackingSize");
    mixin DeclColumn!(MDTableType.classLayout, 1, uint, ValueKind.Integral, "ClassSize");
    mixin DeclColumn!(MDTableType.classLayout, 2, uint, ValueKind.Index, "Parent");
}

private mixin template fieldLayoutGetters()
{
    mixin DeclColumn!(MDTableType.fieldLayout, 0, uint, ValueKind.Integral, "Offset");
    mixin DeclColumn!(MDTableType.fieldLayout, 1, uint, ValueKind.Index, "Field");
}

private mixin template standAloneSigGetters()
{
    mixin DeclColumn!(MDTableType.standAloneSig, 0, uint, ValueKind.Blob, "Signature");
}

private mixin template eventMapGetters()
{
    mixin DeclColumn!(MDTableType.eventMap, 0, uint, ValueKind.Index, "Parent");
    mixin DeclColumn!(MDTableType.eventMap, 1, uint, ValueKind.Index, "EventList");
}

private mixin template eventGetters()
{
    mixin DeclColumn!(MDTableType.event, 0, ushort, ValueKind.Integral, "EventFlags");
    mixin DeclColumn!(MDTableType.event, 1, uint, ValueKind.String, "Name");
    mixin DeclColumn!(MDTableType.event, 2, uint, ValueKind.CodedIndex, "EventType");
}

private mixin template propertyMapGetters()
{
    mixin DeclColumn!(MDTableType.propertyMap, 0, uint, ValueKind.Index, "Parent");
    mixin DeclColumn!(MDTableType.propertyMap, 1, uint, ValueKind.Index, "PropertyList");
}

private mixin template propertyGetters()
{
    mixin DeclColumn!(MDTableType.property, 0, ushort, ValueKind.Integral, "Flags");
    mixin DeclColumn!(MDTableType.property, 1, uint, ValueKind.String, "Name");
    mixin DeclColumn!(MDTableType.property, 2, uint, ValueKind.Blob, "Type");
}

private mixin template methodSemanticsGetters()
{
    mixin DeclColumn!(MDTableType.methodSemantics, 0, ushort, ValueKind.Integral, "Semantics");
    mixin DeclColumn!(MDTableType.methodSemantics, 1, uint, ValueKind.Index, "Method");
    mixin DeclColumn!(MDTableType.methodSemantics, 2, uint, ValueKind.CodedIndex, "Association");
}

private mixin template methodImplGetters()
{
    mixin DeclColumn!(MDTableType.methodImpl, 0, uint, ValueKind.Index, "Class");
    mixin DeclColumn!(MDTableType.methodImpl, 1, uint, ValueKind.CodedIndex, "MethodBody");
    mixin DeclColumn!(MDTableType.methodImpl, 2, uint, ValueKind.CodedIndex, "MethodDeclaration");
}

private mixin template moduleRefGetters()
{
    mixin DeclColumn!(MDTableType.moduleRef, 0, uint, ValueKind.String, "Name");
}

private mixin template typeSpecGetters()
{
    mixin DeclColumn!(MDTableType.typeSpec, 0, uint, ValueKind.Blob, "Signature");
}

private mixin template implMapGetters()
{
    mixin DeclColumn!(MDTableType.implMap, 0, ushort, ValueKind.Integral, "MappingFlags");
    mixin DeclColumn!(MDTableType.implMap, 1, uint, ValueKind.CodedIndex, "MemberForwarded");
    mixin DeclColumn!(MDTableType.implMap, 2, uint, ValueKind.String, "ImportName");
    mixin DeclColumn!(MDTableType.implMap, 3, uint, ValueKind.Index, "ImportScope");
}

private mixin template fieldRVAGetters()
{
    mixin DeclColumn!(MDTableType.fieldRVA, 0, uint, ValueKind.Integral, "RVA");
    mixin DeclColumn!(MDTableType.fieldRVA, 1, uint, ValueKind.Index, "Field");
}

private mixin template assemblyGetters()
{
    mixin DeclColumn!(MDTableType.assembly, 0, uint, ValueKind.Integral, "HashAlgId");
    mixin DeclColumn!(MDTableType.assembly, 1, ulong, ValueKind.Integral, "Version");
    mixin DeclColumn!(MDTableType.assembly, 2, uint, ValueKind.Integral, "Flags");
    mixin DeclColumn!(MDTableType.assembly, 3, uint, ValueKind.Blob, "PublicKey");
    mixin DeclColumn!(MDTableType.assembly, 4, uint, ValueKind.String, "Name");
    mixin DeclColumn!(MDTableType.assembly, 5, uint, ValueKind.String, "Culture");
}

private mixin template assemblyProcessorGetters()
{
    mixin DeclColumn!(MDTableType.assemblyProcessor, 0, uint, ValueKind.Integral, "Processor");
}

private mixin template assemblyOSGetters()
{
    mixin DeclColumn!(MDTableType.assemblyOS, 0, uint, ValueKind.Integral, "OSPlatformID");
    mixin DeclColumn!(MDTableType.assemblyOS, 1, uint, ValueKind.Integral, "OSMajorVersion");
    mixin DeclColumn!(MDTableType.assemblyOS, 2, uint, ValueKind.Integral, "OSMinorVersion");
}

private mixin template assemblyRefGetters()
{
    mixin DeclColumn!(MDTableType.assemblyRef, 0, ulong, ValueKind.Integral, "Version");
    mixin DeclColumn!(MDTableType.assemblyRef, 1, uint, ValueKind.Integral, "Flags");
    mixin DeclColumn!(MDTableType.assemblyRef, 2, uint, ValueKind.Blob, "PublicKeyOrToken");
    mixin DeclColumn!(MDTableType.assemblyRef, 3, uint, ValueKind.String, "Name");
    mixin DeclColumn!(MDTableType.assemblyRef, 4, uint, ValueKind.String, "Culture");
    mixin DeclColumn!(MDTableType.assemblyRef, 5, uint, ValueKind.Blob, "HashValue");
}

private mixin template assemblyRefProcessorGetters()
{
    mixin DeclColumn!(MDTableType.assemblyRefProcessor, 0, uint, ValueKind.Integral, "Processor");
    mixin DeclColumn!(MDTableType.assemblyRefProcessor, 1, uint, ValueKind.Index, "AssemblyRef");
}

private mixin template assemblyRefOSGetters()
{
    mixin DeclColumn!(MDTableType.assemblyRefOS, 0, uint, ValueKind.Integral, "OSPlatformId");
    mixin DeclColumn!(MDTableType.assemblyRefOS, 1, uint, ValueKind.Integral, "OSMajorVersion");
    mixin DeclColumn!(MDTableType.assemblyRefOS, 2, uint, ValueKind.Integral, "OSMinorVersion");
    mixin DeclColumn!(MDTableType.assemblyRefOS, 3, uint, ValueKind.Index, "AssemblyRef");
}

private mixin template fileGetters()
{
    mixin DeclColumn!(MDTableType.file, 0, uint, ValueKind.Integral, "Flags");
    mixin DeclColumn!(MDTableType.file, 1, uint, ValueKind.String, "Name");
    mixin DeclColumn!(MDTableType.file, 2, uint, ValueKind.Blob, "HashValue");
}

private mixin template exportedTypeGetters()
{
    mixin DeclColumn!(MDTableType.exportedType, 0, uint, ValueKind.Integral, "Flags");
    mixin DeclColumn!(MDTableType.exportedType, 1, uint, ValueKind.Integral, "TypeDefId");
    mixin DeclColumn!(MDTableType.exportedType, 2, uint, ValueKind.String, "TypeName");
    mixin DeclColumn!(MDTableType.exportedType, 3, uint, ValueKind.String, "TypeNamespace");
    mixin DeclColumn!(MDTableType.exportedType, 4, uint, ValueKind.CodedIndex, "Implementation");
}

private mixin template manifestResourceGetters()
{
    mixin DeclColumn!(MDTableType.manifestResource, 0, uint, ValueKind.Integral, "Offset");
    mixin DeclColumn!(MDTableType.manifestResource, 1, uint, ValueKind.Integral, "Flags");
    mixin DeclColumn!(MDTableType.manifestResource, 2, uint, ValueKind.String, "Name");
    mixin DeclColumn!(MDTableType.manifestResource, 3, uint, ValueKind.CodedIndex, "Implementation");
}

private mixin template nestedClassGetters()
{
    mixin DeclColumn!(MDTableType.nestedClass, 0, uint, ValueKind.Index, "NestedClass");
    mixin DeclColumn!(MDTableType.nestedClass, 1, uint, ValueKind.Index, "EnclosingClass");
}

private mixin template genericParamGetters()
{
    mixin DeclColumn!(MDTableType.genericParam, 0, ushort, ValueKind.Integral, "Number");
    mixin DeclColumn!(MDTableType.genericParam, 1, ushort, ValueKind.Integral, "Flags");
    mixin DeclColumn!(MDTableType.genericParam, 2, uint, ValueKind.CodedIndex, "Owner");
    mixin DeclColumn!(MDTableType.genericParam, 3, uint, ValueKind.String, "Name");
}

private mixin template methodSpecGetters()
{
    mixin DeclColumn!(MDTableType.methodSpec, 0, uint, ValueKind.CodedIndex, "Method");
    mixin DeclColumn!(MDTableType.methodSpec, 1, uint, ValueKind.Blob, "Instantiation");
}

private mixin template genericParamConstraintGetters()
{
    mixin DeclColumn!(MDTableType.genericParamConstraint, 0, uint, ValueKind.Index, "Owner");
    mixin DeclColumn!(MDTableType.genericParamConstraint, 1, uint, ValueKind.CodedIndex, "Constraint");
}

// Declares member function (column value getter)
// ValueType!(T, K) get##Name() const { ... }
private mixin template DeclColumn(alias md, uint column, alias T, alias K, string Name)
{
    alias fieldSpec = FieldSpec!(T, K, Name);

    enum injectGetter = ()
    {
        immutable string valueType = "Value!(" ~ fieldSpec.Type.stringof ~ ", " ~ " " ~ fieldSpec.Kind.stringof ~ ")";
        immutable string valueTypeAlias = fieldSpec.Name ~ "ValueType";
        immutable tableType = "MDTableType." ~ md.stringof;
        immutable string extractorType = "ColumnValueExtractor!(" ~ valueType ~ ", " ~ tableType ~ ", " ~ column.stringof ~ ")";
        immutable string extractorTypeAlias = fieldSpec.Name ~ "ExtractorType";

        string decl = "";
        decl ~= "public alias " ~ valueTypeAlias ~ " = " ~ valueType ~ ";\n";
        decl ~= "public alias " ~ extractorTypeAlias ~ " = " ~ extractorType ~ ";\n";
        
        decl ~= "public " ~ valueTypeAlias ~ " get" ~ fieldSpec.Name ~ "() const\n";
        decl ~= "{ return " ~ extractorTypeAlias ~ "().getValue(table, rowID);" ~ " }\n";

        decl ~= "public enum " ~ fieldSpec.Name ~ "Column = column;\n";

        return decl;
    };

    mixin(injectGetter());
}

unittest
{
    import climetadata.mdtable.table : ColumnKindSize;

    const(ubyte)[] tablesView = [1, 0, 0, 0, 42, 0];
    auto testTable = Table!(MDTableType.unknown)(tablesView, 1,
        [
            ColumnKindSize(ValueKind.Integral, 4),
            ColumnKindSize(ValueKind.Integral, 2),
        ]);

    struct Test
    {
        Table!(MDTableType.unknown)* table;
        uint rowID = 1;
        
        mixin DeclColumn!(MDTableType.unknown, 0, uint, ValueKind.Integral, "Id");
        mixin DeclColumn!(MDTableType.unknown, 1, ushort, ValueKind.Integral, "Name");
    };

    const Test t = Test(&testTable);
    
    auto id = t.getId();
    auto name = t.getName();

    static assert(is(typeof(id) == Value!(uint, ValueKind.Integral)));
    static assert(is(typeof(name) == Value!(ushort, ValueKind.Integral)));

    assert(id == 1);
    assert(name == 42);
}

// VT must be Value!(T, K)
struct ColumnValueExtractor(alias VT, MDTableType md, uint column)
{
    public VT getValue(const(Table!md*) table, uint rowID) const
    {
        enforce(rowID != 0, "rowID can't be 0 (it is 1-based)");

        return table.getValue!(VT.Type, VT.Kind)(rowID - 1, column);
    }
};

unittest
{
    alias TestExtractor = ColumnValueExtractor!(Value!(uint, ValueKind.Integral), MDTableType.unknown, 0);
    TestExtractor e;
}

private template FieldSpec(T, ValueKind k, string s)
{
    alias Type = T;
    alias Kind = k;
    alias Name = s;
}
