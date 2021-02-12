module metadata;

public import std.typecons : Nullable;
public import std.variant: Algebraic;
public import std.uuid : UUID;


import std.exception: enforce;
import std.format: format;
import std.algorithm: startsWith, endsWith;
import std.traits: getUDAs;



public struct Metadata
{
    @disable this();
    public this(string path)
    {
        fileMap = FileMap(path);
        enforce(fileMap.size() > ImageDosHeader.sizeof, "File is too small to be a PE format file");

        auto m = fileMap.memory();

        auto dos = asRef!ImageDosHeader(m);

        enforce(dos.e_signature == 0x5a4d, format("Invalid PE signature (0x%04X)", dos.e_signature));
        enforce(fileMap.size > dos.e_lfanew + ImageNTHeaders32.sizeof, "Invalid file size");

        auto pe = asRef!ImageNTHeaders32(m, dos.e_lfanew);
        enforce(pe.fileHeader.numberOfSections > 0 && pe.fileHeader.numberOfSections <= 100, 
                format("Invalid number of sections (%d)", pe.fileHeader.numberOfSections));

        const(ImageSectionHeader)[]sections;
        uint comVA;
        if (pe.optionalHeader.magic == 0x10b)
        {
            comVA = pe.optionalHeader.dataDirectory[14].virtualAddress;
            sections = asArray!(ImageSectionHeader)(m, dos.e_lfanew + ImageNTHeaders32.sizeof);
        }
        else
        {   
            auto pe2 = asRef!ImageNTHeaders32Plus(m, dos.e_lfanew);
            comVA = pe2.optionalHeader.dataDirectory[14].virtualAddress;
            sections = asArray!(ImageSectionHeader)(m, dos.e_lfanew + ImageNTHeaders32Plus.sizeof);
        }

        sections.length = pe.fileHeader.numberOfSections;

        ImageSectionHeader section;
        enforce(sectionFromRVA(sections, comVA, section), "CLI header is missing");

        auto offset = offsetFromRVA(section, comVA);
        auto cli = asRef!ImageCor20Header(m, offset);
        enforce(cli.cb == ImageCor20Header.sizeof, 
                format("Invalid CLI header size (%d bytes)", cli.cb));

        enforce(sectionFromRVA(sections, cli.metaData.virtualAddress, section), "CLI metadata is missing");

        offset = offsetFromRVA(section, cli.metaData.virtualAddress);
        enforce(asVal!uint(m, offset) == 0x424a5342u, 
                format("Invalid CLI metadata signature (0x%08X)", asVal!uint(m, offset)));

        auto vlen = asVal!uint(m, offset + 12);
        auto streamCount = asVal!ushort(m, offset + vlen + 18);
        auto view = m[offset + vlen + 20 .. $];

        for (size_t i; i < streamCount; ++i)
        {
            auto stream = asRef!StreamRange(view);
            auto name = asString(view, 8);

            if (name == "#Strings")            
                strings = m[offset + stream.offset .. offset + stream.offset + stream.size];
            else if (name == "#Blob")            
                blobs = m[offset + stream.offset .. offset + stream.offset + stream.size];
            else if (name == "#GUID")            
                guids = m[offset + stream.offset .. offset + stream.offset + stream.size];
            else if (name == "#~")            
                tables = m[offset + stream.offset .. offset + stream.offset + stream.size];
            else  
                enforce(name == "#US", "Unknown metadata stream (%s)", name);

            uint padding = 4 - name.length % 4;
            if (!padding)
                padding = 4;
            view = view[name.length + 8 + padding .. $];
        }        

        auto bits = asVal!ubyte(tables, 6);
        ubyte stringIndexSize = (bits & 0x01) == 0x01 ? 4 : 2;
        ubyte guidIndexSize = (bits & 0x02) == 0x02 ? 4 : 2;  
        ubyte blobIndexSize = (bits & 0x04) == 0x04 ? 4 : 2;

        ulong validBits = asVal!ulong(tables, 8);

        view = tables[24 .. $];

        uint[MD.unknown] rowCounts;

        for (ubyte i; i < 64; ++i)
        {
            if ((validBits & 1UL) ==  1UL)
            {
                auto md = getMDfromIndex(i);
                enforce(md != MD.unknown, format("Unknown metadata table (0x%02x)", i));
                rowCounts[md] = asVal!uint(view);
                view = view[4 .. $];                
            }
            validBits >>= 1;
        }

        auto typeDefOrRefIndexSize 
            = compositeIndexSize(rowCounts[MD.typeDef], rowCounts[MD.typeRef], rowCounts[MD.typeSpec]);
        auto hasConstantIndexSize 
            = compositeIndexSize(rowCounts[MD.field], rowCounts[MD.param], rowCounts[MD.property]);
        auto hasCustomAttributeIndexSize 
            = compositeIndexSize(rowCounts[MD.methodDef], rowCounts[MD.field], rowCounts[MD.typeRef], 
                                 rowCounts[MD.typeDef], rowCounts[MD.param], rowCounts[MD.interfaceImpl], 
                                 rowCounts[MD.memberRef], rowCounts[MD.module_], rowCounts[MD.property], 
                                 rowCounts[MD.event], rowCounts[MD.standAloneSig], rowCounts[MD.moduleRef], 
                                 rowCounts[MD.typeSpec], rowCounts[MD.assembly], rowCounts[MD.assemblyRef], 
                                 rowCounts[MD.file], rowCounts[MD.exportedType], rowCounts[MD.manifestResource],
                                 rowCounts[MD.genericParam], rowCounts[MD.genericParamConstraint], 
                                 rowCounts[MD.methodSpec]);
        auto hasFieldMarshalIndexSize 
            = compositeIndexSize(rowCounts[MD.field], rowCounts[MD.param]);
        auto hasDeclSecurityIndexSize 
            = compositeIndexSize(rowCounts[MD.typeDef], rowCounts[MD.methodDef], rowCounts[MD.assembly]);
        auto memberRefParentIndexSize 
            = compositeIndexSize(rowCounts[MD.typeDef], rowCounts[MD.typeRef], rowCounts[MD.moduleRef], 
                                 rowCounts[MD.methodDef], rowCounts[MD.typeSpec]);
        auto hasSemanticsIndexSize 
            = compositeIndexSize(rowCounts[MD.event], rowCounts[MD.property]);
        auto methodDefOrRefIndexSize 
            = compositeIndexSize(rowCounts[MD.methodDef], rowCounts[MD.memberRef]);
        auto memberForwardedIndexSize 
            = compositeIndexSize(rowCounts[MD.field], rowCounts[MD.methodDef]);
        auto implementationIndexSize 
            = compositeIndexSize(rowCounts[MD.file], rowCounts[MD.assemblyRef], rowCounts[MD.exportedType]);
        auto customAttributeTypeIndexSize 
            = compositeIndexSize(rowCounts[MD.methodDef], rowCounts[MD.memberRef], 0, 0, 0);
        auto resolutionScopeIndexSize 
            = compositeIndexSize(rowCounts[MD.module_], rowCounts[MD.moduleRef], 
                                 rowCounts[MD.assemblyRef],  rowCounts[MD.typeRef]);
        auto typeOrMethodDefIndexSize 
            = compositeIndexSize(rowCounts[MD.typeDef], rowCounts[MD.methodDef]);

        //typeRefTable = Table!(MD.module_)();

        moduleTable 
            = Table!(MD.module_)(&this, rowCounts[MD.module_], view, 2, stringIndexSize,
                                 guidIndexSize, guidIndexSize, guidIndexSize);
        typeRefTable 
            = Table!(MD.typeRef)(&this, rowCounts[MD.typeRef], view, 
                                 resolutionScopeIndexSize, stringIndexSize, stringIndexSize);
        typeDefTable 
            = Table!(MD.typeDef)(&this, rowCounts[MD.typeDef], view, 4, 
                                 stringIndexSize, stringIndexSize, typeDefOrRefIndexSize, 
                                 indexSize(rowCounts[MD.field]), indexSize(rowCounts[MD.methodDef]));
        fieldTable 
            = Table!(MD.field)(&this, rowCounts[MD.field], view, 2, stringIndexSize, blobIndexSize);
        methodDefTable 
            = Table!(MD.methodDef)(&this, rowCounts[MD.methodDef], view, 4, 2, 2, 
                                   stringIndexSize, blobIndexSize, indexSize(rowCounts[MD.param]));
        paramTable 
            = Table!(MD.param)(&this, rowCounts[MD.param], view, 2, 2, stringIndexSize);
        interfaceImplTable 
            = Table!(MD.interfaceImpl)(&this, rowCounts[MD.interfaceImpl], view, 
                                       indexSize(rowCounts[MD.typeDef]), typeDefOrRefIndexSize);
        memberRefTable 
            = Table!(MD.memberRef)(&this, rowCounts[MD.memberRef], view,
                                   memberRefParentIndexSize, stringIndexSize, blobIndexSize);
        constantTable 
            = Table!(MD.constant)(&this, rowCounts[MD.constant], view, 2, hasConstantIndexSize, blobIndexSize);    
        customAttributeTable 
            = Table!(MD.customAttribute)(&this, rowCounts[MD.customAttribute], view, 
                                         hasCustomAttributeIndexSize, customAttributeTypeIndexSize, blobIndexSize);
        fieldMarshalTable 
            = Table!(MD.fieldMarshal)(&this, rowCounts[MD.fieldMarshal], view, 
                                          hasFieldMarshalIndexSize, blobIndexSize);
        declSecurityTable 
            = Table!(MD.declSecurity)(&this, rowCounts[MD.declSecurity], view, 2,
                                      hasDeclSecurityIndexSize, blobIndexSize);
        classLayoutTable 
            = Table!(MD.classLayout)(&this, rowCounts[MD.classLayout], view, 2, 4, indexSize(rowCounts[MD.typeDef]));
        fieldLayoutTable 
            = Table!(MD.fieldLayout)(&this, rowCounts[MD.fieldLayout], view, 4, indexSize(rowCounts[MD.field]));
        standAloneSigTable 
            = Table!(MD.standAloneSig)(&this, rowCounts[MD.standAloneSig], view, blobIndexSize);
        eventMapTable 
            = Table!(MD.eventMap)(&this, rowCounts[MD.eventMap], view, 
                                  indexSize(rowCounts[MD.typeDef]), indexSize(rowCounts[MD.event]));
        eventTable 
            = Table!(MD.event)(&this, rowCounts[MD.event], view, 2, stringIndexSize, typeDefOrRefIndexSize);
        propertyMapTable 
            = Table!(MD.propertyMap)(&this, rowCounts[MD.propertyMap], view,
                                     indexSize(rowCounts[MD.typeDef]), indexSize(rowCounts[MD.property]));
        propertyTable 
            = Table!(MD.property)(&this, rowCounts[MD.property], view, 2, stringIndexSize, blobIndexSize);
        methodSemanticsTable 
            = Table!(MD.methodSemantics)(&this, rowCounts[MD.methodSemantics], view, 2,
                                         indexSize(rowCounts[MD.methodDef]), hasSemanticsIndexSize);
        methodImplTable 
            = Table!(MD.methodImpl)(&this, rowCounts[MD.methodImpl], view, 
                                   indexSize(rowCounts[MD.typeDef]), methodDefOrRefIndexSize, methodDefOrRefIndexSize);
        moduleRefTable 
            = Table!(MD.moduleRef)(&this, rowCounts[MD.moduleRef], view, stringIndexSize);
        typeSpecTable 
            = Table!(MD.typeSpec)(&this, rowCounts[MD.typeSpec], view, blobIndexSize);
        implMapTable 
            = Table!(MD.implMap)(&this, rowCounts[MD.implMap], view, 2,
                                 memberForwardedIndexSize, stringIndexSize, indexSize(rowCounts[MD.moduleRef]));
        fieldRVATable 
            = Table!(MD.fieldRVA)(&this, rowCounts[MD.fieldRVA], view, 4, indexSize(rowCounts[MD.field]));
        assemblyTable 
            = Table!(MD.assembly)(&this, rowCounts[MD.assembly], view, 4, 8, 4, 
                                  blobIndexSize, stringIndexSize, stringIndexSize);
        assemblyProcessorTable 
            = Table!(MD.assemblyProcessor)(&this, rowCounts[MD.assemblyProcessor], view, 4);
        assemblyOSTable 
            = Table!(MD.assemblyOS)(&this, rowCounts[MD.assemblyOS], view, 4, 4, 4);
        assemblyRefTable 
            = Table!(MD.assemblyRef)(&this, rowCounts[MD.assemblyRef], view, 8, 4, 
                                     blobIndexSize, stringIndexSize, stringIndexSize, blobIndexSize);
        assemblyRefProcessorTable 
            = Table!(MD.assemblyRefProcessor)(&this, rowCounts[MD.assemblyRefProcessor], view, 4,
                                              indexSize(rowCounts[MD.assemblyRef]));
        assemblyRefOSTable 
            = Table!(MD.assemblyRefOS)(&this, rowCounts[MD.assemblyRefOS], view, 4, 4, 4, 
                                       indexSize(rowCounts[MD.assemblyRef]));
        fileTable 
            = Table!(MD.file)(&this, rowCounts[MD.file], view, 4,  stringIndexSize, blobIndexSize);        
        exportedTypeTable 
            = Table!(MD.exportedType)(&this, rowCounts[MD.exportedType], view, 4, 4, stringIndexSize,
                                      stringIndexSize, implementationIndexSize);
        manifestResourceTable 
            = Table!(MD.manifestResource)(&this, rowCounts[MD.manifestResource], view, 4, 4, 
                                          stringIndexSize, implementationIndexSize);
        nestedClassTable 
            = Table!(MD.nestedClass)(&this, rowCounts[MD.nestedClass], view, 
                                     indexSize(rowCounts[MD.typeDef]), indexSize(rowCounts[MD.typeDef]));
        genericParamTable 
            = Table!(MD.genericParam)(&this, rowCounts[MD.genericParam], view, 2, 2,
                                          typeOrMethodDefIndexSize, stringIndexSize);
        methodSpecTable 
            = Table!(MD.methodSpec)(&this, rowCounts[MD.methodSpec], view, methodDefOrRefIndexSize, blobIndexSize);
        genericParamConstraintTable 
            = Table!(MD.genericParamConstraint)(&this, rowCounts[MD.genericParamConstraint], view, 
                                                    indexSize(rowCounts[MD.genericParam]), typeDefOrRefIndexSize);   
        

    }


    private const(ubyte)[] strings;
    private const(ubyte)[] blobs;
    private const(ubyte)[] guids;
    private const(ubyte)[] tables;
    private FileMap fileMap;

    public Table!(MD.module_)                moduleTable;
    public Table!(MD.typeRef)                typeRefTable;
    public Table!(MD.typeDef)                typeDefTable;
    public Table!(MD.field)                  fieldTable;
    public Table!(MD.methodDef)              methodDefTable;
    public Table!(MD.param)                  paramTable;
    public Table!(MD.interfaceImpl)          interfaceImplTable;
    public Table!(MD.memberRef)              memberRefTable;
    public Table!(MD.constant)               constantTable;
    public Table!(MD.customAttribute)        customAttributeTable;
    public Table!(MD.fieldMarshal)           fieldMarshalTable;
    public Table!(MD.declSecurity)           declSecurityTable;
    public Table!(MD.classLayout)            classLayoutTable;
    public Table!(MD.fieldLayout)            fieldLayoutTable;
    public Table!(MD.standAloneSig)          standAloneSigTable;
    public Table!(MD.eventMap)               eventMapTable;
    public Table!(MD.event)                  eventTable;
    public Table!(MD.propertyMap)            propertyMapTable;
    public Table!(MD.property)               propertyTable;
    public Table!(MD.methodSemantics)        methodSemanticsTable;
    public Table!(MD.methodImpl)             methodImplTable;
    public Table!(MD.moduleRef)              moduleRefTable;
    public Table!(MD.typeSpec)               typeSpecTable;
    public Table!(MD.implMap)                implMapTable;
    public Table!(MD.fieldRVA)               fieldRVATable;
    public Table!(MD.assembly)               assemblyTable;
    public Table!(MD.assemblyProcessor)      assemblyProcessorTable;
    public Table!(MD.assemblyOS)             assemblyOSTable;
    public Table!(MD.assemblyRef)            assemblyRefTable;
    public Table!(MD.assemblyRefProcessor)   assemblyRefProcessorTable;
    public Table!(MD.assemblyRefOS)          assemblyRefOSTable;
    public Table!(MD.file)                   fileTable;
    public Table!(MD.exportedType)           exportedTypeTable;
    public Table!(MD.manifestResource)       manifestResourceTable;
    public Table!(MD.nestedClass)            nestedClassTable;
    public Table!(MD.genericParam)           genericParamTable;
    public Table!(MD.methodSpec)             methodSpecTable;
    public Table!(MD.genericParamConstraint) genericParamConstraintTable;


    private template getTable(MD md)
    {
        static if (md == MD.module_) alias getTable =                      moduleTable;
        else static if (md == MD.typeRef) alias getTable =                 typeRefTable;
        else static if (md == MD.typeDef) alias getTable =                 typeDefTable;
        else static if (md == MD.field) alias getTable =                   fieldTable;
        else static if (md == MD.methodDef) alias getTable =               methodDefTable;
        else static if (md == MD.param) alias getTable =                   paramTable;
        else static if (md == MD.interfaceImpl) alias getTable =           interfaceImplTable;
        else static if (md == MD.memberRef) alias getTable =               memberRefTable;
        else static if (md == MD.constant) alias getTable =                constantTable;
        else static if (md == MD.customAttribute) alias getTable =         customAttributeTable;
        else static if (md == MD.fieldMarshal) alias getTable =            fieldMarshalTable;
        else static if (md == MD.declSecurity) alias getTable =            declSecurityTable;
        else static if (md == MD.classLayout) alias getTable =             classLayoutTable;
        else static if (md == MD.fieldLayout) alias getTable =             fieldLayoutTable;
        else static if (md == MD.standAloneSig) alias getTable =           standAloneSigTable;
        else static if (md == MD.eventMap) alias getTable =                eventMapTable;
        else static if (md == MD.event) alias getTable =                   eventTable;
        else static if (md == MD.propertyMap) alias getTable =             propertyMapTable;
        else static if (md == MD.property) alias getTable =                propertyTable;
        else static if (md == MD.methodSemantics) alias getTable =         methodSemanticsTable;
        else static if (md == MD.methodImpl) alias getTable =              methodImplTable;
        else static if (md == MD.moduleRef) alias getTable =               moduleRefTable;
        else static if (md == MD.typeSpec) alias getTable =                typeSpecTable;
        else static if (md == MD.implMap) alias getTable =                 implMapTable;
        else static if (md == MD.fieldRVA) alias getTable =                fieldRVATable;
        else static if (md == MD.assembly) alias getTable =                assemblyTable;
        else static if (md == MD.assemblyProcessor) alias getTable =       assemblyProcessorTable;
        else static if (md == MD.assemblyOS) alias getTable =              assemblyOSTable;
        else static if (md == MD.assemblyRef) alias getTable =             assemblyRefTable;
        else static if (md == MD.assemblyRefProcessor) alias getTable =    assemblyRefProcessorTable;
        else static if (md == MD.assemblyRefOS) alias getTable =           assemblyRefOSTable;
        else static if (md == MD.file) alias getTable =                    fileTable;
        else static if (md == MD.exportedType) alias getTable =            exportedTypeTable;
        else static if (md == MD.manifestResource) alias getTable =        manifestResourceTable;
        else static if (md == MD.nestedClass) alias getTable =             nestedClassTable;
        else static if (md == MD.genericParam) alias getTable =            genericParamTable;
        else static if (md == MD.methodSpec) alias getTable =              methodSpecTable;
        else static if (md == MD.genericParamConstraint) alias getTable =  genericParamConstraintTable;
        else static assert(false, "Unsupported table");
    }

    private string getString(uint offset) const
    {
        return asString(strings, offset);
    }

    private const(ubyte)[] getBlob(uint offset) const
    {
        auto blob = blobs[offset .. $];
        auto size = readCompressed(blob);
        return blob[0 .. size];
    }

    private UUID getGUID(uint index) const
    {        
        if (!index)
            return UUID.init;
        --index;
        return asRef!UUID(guids[index * UUID.sizeof .. index * UUID.sizeof + UUID.sizeof]);
    }

    private auto getRange(MD md)(uint sourceIndex, ubyte targetColumn) const
    {
        return RangeEnumerator!md(&this, sourceIndex, targetColumn);
    }

    private auto getRange(MD md, T)(CompositeIndex!T sourceIndex, ubyte targetColumn) const
    {
        return CompositeRangeEnumerator!(md, T)(&this, sourceIndex, targetColumn);
    }

    private auto findFirstRequired(MD md)(uint sourceIndex, ubyte targetColumn) const
    {
        auto r = findFirst!md(sourceIndex, targetColumn);
        enforce(!r.isNull, format("Missing %s reference (%d)", md.stringof, sourceIndex));
        return r.get;
    }

    private auto findFirstRequired(MD md, T)(CompositeIndex!T sourceIndex, ubyte targetColumn) const
    {
        auto r = findFirst!(md, T)(sourceIndex, targetColumn);
        enforce(!r.isNull, format("Missing %s reference (%d)", md.stringof, sourceIndex.index));
        return r.get;
    }

    private auto findFirst(MD md)(uint sourceIndex, ubyte targetColumn) const
    {
        alias NullableResult = Nullable!(Row!md);
        uint targetRow;
        while (targetRow < getTable!md.rowCount)
        {
            if (getTable!md.getValue!uint(targetRow, targetColumn) == sourceIndex)
                return NullableResult(getTable!md[targetRow + 1]);
            ++targetRow;
        }
        return NullableResult.init;
    }

    private auto findFirst(MD md, T)(CompositeIndex!T sourceIndex, ubyte targetColumn) const
    {
        alias NullableResult = Nullable!(Row!md);
        uint targetRow;
        while (targetRow < getTable!md.rowCount)
        {
            if (getTable!md.getCompositeIndex!T(targetRow, targetColumn).codedIndex == sourceIndex.codedIndex)
                return NullableResult(getTable!md[targetRow + 1]);
            ++targetRow;
        }
        return NullableResult.init;
    }

    private auto getList(MD md)(uint startIndex, uint nextIndex) const
    {
        assert(startIndex);
        return ListEnumerator!md(&this, startIndex, nextIndex);
    }

    public Nullable!TypeDef findByName(string typeName) const
    {
        foreach(r; typeDefTable.items)
        {
            auto name = r.name;
            auto namespace = r.namespace;
            if (typeName.length == name.length + namespace.length + 1 && typeName.startsWith(r.namespace) && typeName.endsWith(r.name))
                return Nullable!TypeDef(r);
        }
        return (Nullable!TypeDef).init;
     }
    
}

public struct Table(MD md)
{
    private const(Metadata)* db;
    private uint rowSize;
    private uint rowCount;
    private Column[6] columns;
    private const(ubyte)[] data;

    @disable this();
    private this(const(Metadata)* db, uint rowCount, ref const(ubyte)[] data, ubyte a, ubyte b = 0, ubyte c = 0, ubyte d = 0, ubyte e = 0, ubyte f = 0)
    {
        assert(a);
        assert(a <= 8);
        assert(b <= 8);
        assert(c <= 8);
        assert(d <= 8);
        assert(e <= 8);
        assert(f <= 8);

        this.db = db;
        this.rowSize = a + b + c + d + e + f;
        this.rowCount = rowCount;

        columns[0] = Column(0, a);
        if (b) columns[1] = Column(a, b);
        if (c) columns[2] = Column(cast(ubyte)(a + b), c);
        if (d) columns[3] = Column(cast(ubyte)(a + b + c), d);
        if (e) columns[4] = Column(cast(ubyte)(a + b + c + d), e);
        if (f) columns[5] = Column(cast(ubyte)(a + b + c + d + e), f);

        this.data = data[0 .. rowCount * rowSize];
        data = data[rowCount * rowSize .. $];
    }

    public Row!md opIndex(uint index) const
    {
        return Row!md(&this, index);
    }

    private T getValue(T = uint)(uint row, uint column) const
    {
        enforce(row < rowCount, format("Invalid row (%d of %d)", row, rowCount));
        auto sz = columns[column].size;
        assert(sz == 1 || sz == 2 || sz == 4 || sz == 8);
        assert(sz <= T.sizeof);
        auto ptr = data.ptr + row * rowSize + columns[column].offset;
        switch (sz)
        {
            case 1:
                return cast(T)(*ptr);
            case 2:
                return cast(T)(*cast(const(ushort)*)ptr);
            case 4:
                return cast(T)(*cast(const(uint)*)ptr);
            default:
                return cast(T)(*cast(const(ulong)*)ptr);
        }
    }

    private CompositeIndex!T getCompositeIndex(T)(uint row, uint column) const
    {
        return CompositeIndex!T(getValue!uint(row, column));
    }

    private string getString(uint row, uint column) const
    {
        return db.getString(getValue!uint(row, column));
    }

    private const(ubyte)[] getBlob(uint row, uint column) const
    {
        return db.getBlob(getValue!uint(row, column));
    }

    private UUID getGUID(int row, uint column) const
    {
        return db.getGUID(getValue!uint(row, column));
    }    

    private auto getList(MD target)(uint row, uint column) const
    {

        uint startIndex = getValue!uint(row, column);
        uint nextIndex;
        if (row < rowCount - 1)
            nextIndex = getValue!uint(row + 1, column);
        else
            nextIndex = 0;
        return db.getList!target(startIndex, nextIndex);
    }

    public auto items() const
    {
        return TableEnumerator!md(&this);
    }

}

public struct Row(MD md)
{
    private const(Table!md)* table;

    private uint index;

    @disable this();
    private this(const(Table!md)* table, uint index)
    {
        this.table = table;
        this.index = index;
    }

    private T getValue(T)(uint column) const
    {
        return table.getValue!T(index - 1, column);
    }

    private CompositeIndex!T getCompositeIndex(T)(uint column) const
    {
        auto ci =  table.getCompositeIndex!T(index - 1, column);
        return table.getCompositeIndex!T(index - 1, column);
    }

    private string getString(uint column) const
    {
        return table.getString(index - 1, column);
    }

    private UUID getGUID(uint column) const
    {
        return table.getGUID(index - 1, column);
    }

    private const(ubyte)[] getBlob(uint column) const
    {
        return table.getBlob(index - 1, column);
    }

    private auto getList(MD target)(uint column) const
    {
        return table.getList!target(index - 1, column);
    }

    private auto getRange(MD target)(ubyte targetColumn) const
    {
        return table.db.getRange!target(index, targetColumn);
    }

    private auto getRange(MD target, T)(ubyte targetColumn, T enumVal) const
    {
        return table.db.getRange!(target, T)(CompositeIndex!T(index, enumVal), targetColumn);
    }

    private auto findFirst(MD target)(ubyte targetColumn) const
    {
        return table.db.findFirst!target(index, targetColumn);
    }

    private auto findFirst(MD target, T)(ubyte targetColumn, T enumVal) const
    {
        return table.db.findFirst!(target, T)(CompositeIndex!T(index, enumVal), targetColumn);
    }

    private auto findFirstRequired(MD target)(ubyte targetColumn) const
    {
        return table.db.findFirstRequired!target(index, targetColumn);
    }

    private auto findFirstRequired(MD target, T)(ubyte targetColumn, T enumVal) const
    {
        return table.db.findFirstRequired!(target, T)(CompositeIndex!T(index, enumVal), targetColumn);
    }

    private auto findParent(MD target)(ubyte parentColumn) const
    {
        auto parentTable = table.db.getTable!target;
        uint parentRow = 0;
        uint parentVal = parentTable.getValue!uint(parentRow, parentColumn);
        while (parentVal < index && parentRow < parentTable.rowCount)
        {
            ++parentRow;
            parentVal = parentTable.getValue!uint(parentRow, parentColumn);
        }        
        enforce(parentRow < parentTable.rowCount, 
                format("Missing parent (%s) reference to child (%s - %d)", target.stringof, md.stringof, index));      
        //parentVal >= index
        if (parentVal == index)
            return parentTable[parentRow + 1];
        else
        {
            //parentVal > index
            enforce(parentRow > 0,
                    format("Missing parent (%s) reference to child (%s - %d)", target.stringof, md.stringof, index));
            return parentTable[parentRow];
        }
    }

    static if (md == MD.module_)
    {
        public string name()
        {
            return getString(1);
        }

        public UUID mvId()
        {
            return getGUID(2);
        }

        public UUID encId()
        {
            return getGUID(3);
        }

        public UUID encBaseId()
        {
            return getGUID(4);
        }

        public auto attributes()
        {
            return getRange!(MD.customAttribute, HasCustomAttribute)(0, HasCustomAttribute.module_);
        }
    }
    else static if (md == MD.typeRef)
    {
        public string name() const
        {
            return getString(1);
        }

        public string namespace() const
        {
            return getString(2);
        }

        public auto resolutionScope() const
        {
            return compositeValue(table.db, getCompositeIndex!ResolutionScope(0));
        }

        public auto attributes() const
        {
            return getRange!(MD.customAttribute, HasCustomAttribute)(0, HasCustomAttribute.typeRef);
        }
    }
    else static if (md == MD.typeDef)
    {
        public const(TypeAttributes) typeAttributes() const
        {
            return TypeAttributes(getValue!uint(0));
        }

        public string name() const
        {
            return getString(1);
        }

        public string namespace() const
        {
            return getString(2);
        }

        public auto extends() const
        {        
            alias V = Nullable!TypeDefOrRefValue;
            auto r = compositeValue(table.db, getCompositeIndex!TypeDefOrRef(3));
            if (auto td = r.peek!TypeDef)
                return (*td).index > 0 ? V(r) : V.init;
            return V(r);
        }

        public auto fields() const
        {
            return getList!(MD.field)(4);
        }

        public auto methods() const
        {
            auto g = getValue!uint(5);
            return getList!(MD.methodDef)(5);
        }

        public auto attributes() const
        {
            return getRange!(MD.customAttribute, HasCustomAttribute)(0, HasCustomAttribute.typeDef);
        }

        public auto interfaces() const
        {
            return getRange!(MD.interfaceImpl)(0);
        }

        public auto genericParameters() const
        {
            return getRange!(MD.genericParam, TypeOrMethodDef)(2, TypeOrMethodDef.typeDef);
        }

        public auto methodImplementations() const
        {
            return getRange!(MD.methodImpl)(0);
        }

        public auto enclosing() const
        {          
            auto row = findFirst!(MD.nestedClass)(0);
            if (!row.isNull)            
                return Row!md(table, row.get.getValue!uint(1));                      
            return this;
        }

        public bool isEnum() const
        {
            auto row = extends();
            if (row.isNull)
                return false;
            if (row.get.peek!TypeRef)
            {
                auto td = row.get.get!TypeRef;
                return td.name == "Enum" && td.namespace == "System";
            }
            else if (row.get.peek!TypeDef)
            {
                auto td = row.get.get!TypeDef;
                return td.name == "Enum" && td.namespace == "System";
            }
            return false;            
        }

        public bool isDelegate() const
        {
            auto row = extends();
            if (row.isNull)
                return false;
            if (row.get.peek!TypeRef)
            {
                auto td = row.get.get!TypeRef;
                return td.name == "MulticastDelegate" && td.namespace == "System";
            }
            else if (row.get.peek!TypeDef)
            {
                auto td = row.get.get!TypeDef;
                return td.name == "MulticastDelegate" && td.namespace == "System";
            }
            return false;            
        }

        public bool isValueType() const
        {
            auto row = extends();
            if (row.isNull)
                return false;
            if (row.get.peek!TypeRef)
            {
                auto td = row.get.get!TypeRef;
                return td.name == "ValueType" && td.namespace == "System";
            }
            else if (row.get.peek!TypeDef)
            {
                auto td = row.get.get!TypeDef;
                return td.name == "ValueType" && td.namespace == "System";
            }
            return false;            
        }

        public bool isInterface() const
        {
            return typeAttributes.semantics == TypeSemantics.interface_;
        }

        public ElementType underlyingEnumType() const
        {
            ElementType result;
            foreach(field; fields)
            {
                if (!field.fieldAttributes.isLiteral && !field.fieldAttributes.isStatic)
                {
                    result = field.signature.typeSig.type.get!ElementType;
                    break;
                }
            }

            enforce(result >= ElementType.boolean && result <= ElementType.u8, "Invalid enum underlying type");
            return result;
        }

        public auto properties()
        {
            auto propMap = findFirst!(MD.propertyMap)(0);
            if (!propMap.isNull)
                return propMap.get.properties;
            else 
                return ListEnumerator!(MD.property)(table.db, 2, 1);
        }

        public auto events()
        {
            auto eventMap = findFirst!(MD.eventMap)(0);
            if (!eventMap.isNull)
                return eventMap.get.events;
            else 
                return ListEnumerator!(MD.event)(table.db, 2, 1);
        }

        public bool isNested()
        {
            return !findFirst!(MD.nestedClass)(0).isNull;
        }
    }
    else static if (md == MD.field)
    {

        public FieldAttributes fieldAttributes() const
        {
            return FieldAttributes(getValue!ushort(0));
        }

        public string name() const
        {
            return getString(1);
        }

        public const(FieldSig) signature() const
        {
            auto view = getBlob(2);
            return FieldSig(table.db, view);
        }

        public auto attributes() const
        {
            return getRange!(MD.customAttribute, HasCustomAttribute)(0, HasCustomAttribute.field);
        }

        public auto parent() const
        {
            return findParent!(MD.typeDef)(4);
        }

        public auto constant() const
        {
            return findFirst!(MD.constant)(1, HasConstant.field);            
        }

        public auto marshal() const
        {
            return findFirst!(MD.fieldMarshal)(0, HasFieldMarshal.field);            
        }
    }
    else static if (md == MD.methodDef)
    {
        public uint RVA()
        {
            return getValue!uint(0);
        }

        public const(MethodAttributes) methodAttributes() const
        {
            return MethodAttributes(getValue!ushort(1), getValue!ushort(2));
        }

        public string name() const
        {
            return getString(3);
        }

        public MethodDefSig signature() const
        {
            auto data = getBlob(4);
            return MethodDefSig(table.db, data);
        }

        public auto parameters() const
        {
            return getList!(MD.param)(5);
        }

        public auto genericParameters() const
        {
            return getRange!(MD.genericParam, TypeOrMethodDef)(2, TypeOrMethodDef.methodDef);
        }

        public auto parent() const
        {
            return findParent!(MD.typeDef)(5);
        }

        public auto implementation()
        {
            return findFirst!(MD.implMap)(1, MemberForwarded.methodDef);
        }

        public auto attributes() const
        {
            return getRange!(MD.customAttribute, HasCustomAttribute)(0, HasCustomAttribute.methodDef);
        }
    }
    else static if (md == MD.param)
    {
        public const(ParamAttributes) paramAttributes() const
        {
            return ParamAttributes(getValue!ushort(0));
        }

        public uint rank() const
        {
            return getValue!uint(1);
        }

        public string name() const
        {
            return getString(2);
        }

        public auto constant() const
        {
            return findFirst!(MD.constant)(1, HasConstant.param);            
        }

        public auto marshal() const
        {
            return findFirst!(MD.fieldMarshal)(0, HasFieldMarshal.param);            
        }

        public auto attributes() const
        {
            return getRange!(MD.customAttribute, HasCustomAttribute)(0, HasCustomAttribute.param);
        }
    }
    else static if (md == MD.interfaceImpl)
    {
        public auto type() const
        {
            return table.db.typeDefTable[getValue!uint(0)];
        }

        public auto implementation() const
        {
            auto idx = getCompositeIndex!TypeDefOrRef(1);
            return compositeValue(table.db, idx);
        }

        public auto attributes() const
        {
            return getRange!(MD.customAttribute, HasCustomAttribute)(0, HasCustomAttribute.param);
        }
    }
    else static if (md == MD.memberRef)
    {
        public auto reference() const
        {
            auto idx = getCompositeIndex!MemberRefParent(0);
            return compositeValue(table.db, idx);
        }

        public string name() const
        {
            return getString(1);
        }

        public MethodDefSig signature() const
        {
            auto data = getBlob(2);
            return MethodDefSig(table.db, data);
        }

        public auto attributes()
        {
            return getRange!(MD.customAttribute, HasCustomAttribute)(0, HasCustomAttribute.memberRef);
        }

    }
    else static if (md == MD.constant)
    {
        alias ConstantValue = Algebraic!(bool, byte, ubyte, short, ushort, int, uint, long, ulong, wchar, float, double, wstring, typeof(null));

        public ConstantType type() const
        {
            return getValue!ConstantType(0);
        }

        public auto parent() const
        {
            auto idx = getCompositeIndex!HasConstant(1);
            return compositeValue(table.db, idx);
        }

        public auto value() const
        {
            auto t = type();
            if (t == ConstantType.class_)
                return ConstantValue(null);
            else
            {
                auto data = getBlob(2);
                if (t == ConstantType.string)
                    return ConstantValue(asArray!(immutable(wchar))(data));
                switch(t)
                {
                    case ConstantType.boolean:
                        return ConstantValue(asVal!bool(data));
                    case ConstantType.char_:
                        return ConstantValue(asVal!wchar(data));
                    case ConstantType.int8:
                        return ConstantValue(asVal!byte(data));
                    case ConstantType.uint8:
                        return ConstantValue(asVal!ubyte(data));
                    case ConstantType.int16:
                        return ConstantValue(asVal!short(data));
                    case ConstantType.uint16:
                        return ConstantValue(asVal!ushort(data));
                    case ConstantType.int32:
                        return ConstantValue(asVal!int(data));
                    case ConstantType.uint32:
                        return ConstantValue(asVal!uint(data));
                    case ConstantType.int64:
                        return ConstantValue(asVal!long(data));
                    case ConstantType.uint64:
                        return ConstantValue(asVal!ulong(data));
                    case ConstantType.float32:
                        return ConstantValue(asVal!float(data));
                    case ConstantType.float64:
                        return ConstantValue(asVal!double(data));
                    default:
                        assert(0);
                }
            }
        }      

    }
    else static if (md == MD.customAttribute)
    {
        public auto parent() const
        {
            auto idx = getCompositeIndex!HasCustomAttribute(0);
            return compositeValue(table.db, idx);
        }

        public auto constructor() const
        {
            auto idx = getCompositeIndex!CustomAttributeType(1);
            return compositeValue(table.db, idx);
        }

        public auto type() const
        {
            auto ctor = constructor;
            if (ctor.peek!MethodDef)
            {
                auto meth = ctor.get!MethodDef;
                return TypeDefOrRefValue(meth.parent);
            }
            else
            {
                auto mr = ctor.get!MemberRef;
                auto parent = mr.reference;
                if (parent.peek!TypeDef)
                    return TypeDefOrRefValue(parent.get!TypeDef);
                else
                    return TypeDefOrRefValue(parent.get!TypeRef);
            }
        }

        public auto name() const
        {
            auto t = type();
            if (auto td = t.peek!TypeDef)
                return td.name;
            else
                return t.get!TypeRef.name;
        }

        public auto value() const
        {
            auto view = getBlob(2);
            auto ctor = constructor();
            if (auto mdef = ctor.peek!MethodDef)
                return CustomAttributeSig(table.db, view, mdef.signature);
            else
                return CustomAttributeSig(table.db, view, ctor.get!MemberRef.signature);
        }
    }
    else static if (md == MD.fieldMarshal)
    {
        public auto parent() const
        {
            auto idx = getCompositeIndex!HasFieldMarshal(0);
            return compositeValue(table.db, idx);
        }

        public const(FieldMarshalSig) signature() const
        {
            auto data = getBlob(1);
            return FieldMarshalSig(data);
        }

    }
    else static if (md == MD.declSecurity)
    {

        public SecurityAction action() const
        {
            return getValue!SecurityAction(0);
        }

        public auto parent() const
        {
            auto idx = getCompositeIndex!HasDeclSecurity(1);
            return compositeValue(table.db, idx);
        }

        public const(PermissionSig) permissions() const
        {
            auto data = getBlob(2);
            return PermissionSig(table.db, data);
        }
    }
    else static if (md == MD.classLayout)
    {
        public ushort packingSize() const
        {
            return getValue!ushort(0);
        }

        public uint classSize() const
        {
            return getValue!uint(1);
        }

        public auto parent() const
        {
            return table.db.typeDefTable[getValue!uint(2)];
        }
    }
    else static if (md == MD.fieldLayout)
    {
        public uint offset() const
        {
            return getValue!uint(0);
        }

        public auto parent() const
        {
            return table.db.fieldTable[getValue!uint(1)];
        }
    }
    else static if (md == MD.standAloneSig)
    {
        public const(MethodDefSig) signature() const
        {
            auto data = getBlob(0);
            return MethodDefSig(table.db, data);
        }

        public auto attributes() const
        {
            return getRange!(MD.customAttribute, HasCustomAttribute)(0, HasCustomAttribute.standAloneSig);
        }
    }
    else static if (md == MD.eventMap) 
    {
        public auto parent() const
        {
            return table.db.typeDefTable[getValue!uint(0)];
        }

        public auto events() const
        {
            return getList!(MD.event)(1);
        }

    }
    else static if (md == MD.event)
    {
        public const(EventAttributes) eventAttributes() const
        {
            return EventAttributes(getValue!ushort(0));
        }

        public string name() const
        {
            return getString(1);
        }

        public auto eventType() const
        {
            auto idx = getCompositeIndex!TypeDefOrRef(2);
            return compositeValue(table.db, idx);
        }

        public auto attributes() const
        {
            return getRange!(MD.customAttribute, HasCustomAttribute)(0, HasCustomAttribute.event);
        }

        public auto parent() const
        {
            return findParent!(MD.eventMap)(1).parent();
        }

        public auto semantics() const
        {
            return getRange!(MD.methodSemantics, HasSemantics)(2, HasSemantics.event);
        }
    }
    else static if (md == MD.propertyMap)
    {
        public auto parent() const
        {
            return table.db.typeDefTable[getValue!uint(0)];
        }

        public auto properties() const
        {
            return getList!(MD.property)(1);
        }
    }
    else static if (md == MD.property)
    {
        public const(PropertyAttributes) propertyAttributes() const
        {
            return PropertyAttributes(getValue!ushort(0));
        }

        public string name() const
        {
            return getString(1);
        }

        public auto attributes() const
        {
            return getRange!(MD.customAttribute, HasCustomAttribute)(0, HasCustomAttribute.property);
        }

        public auto parent() const
        {
            return findParent!(MD.propertyMap)(1).parent();
        }

        public auto semantics() const
        {
            return getRange!(MD.methodSemantics, HasSemantics)(2, HasSemantics.property);
        }

        public auto constant() const
        {
            return findFirst!(MD.constant)(1, HasConstant.property);            
        }

        public const(PropertySig) signature() const
        {
            auto view = getBlob(2);
            return PropertySig(table.db, view);
        }
    }
    else static if (md == MD.methodSemantics)
    {
        public const(SemanticsAttributes) semantics()
        {
            return SemanticsAttributes(getValue!ushort(0));
        }

        public auto method()
        {
            return table.db.methodDefTable[getValue!uint(1)];
        }

        public auto association()
        {
            return compositeValue(table.db, getCompositeIndex!HasSemantics(2));
        }
    }
    else static if (md == MD.methodImpl)
    {
        public auto parent()
        {
            return table.db.methodDefTable[getValue!uint(0)];
        }

        public auto methodBody()
        {
            return compositeValue(table.db, getCompositeIndex!MethodDefOrRef(1));
        }

        public auto methodDeclaration()
        {
            return compositeValue(table.db, getCompositeIndex!MethodDefOrRef(2));
        }
    }
    else static if (md == MD.moduleRef)
    {
        public string name()
        {
            return getString(0);
        }   

        public auto attributes()
        {
            return getRange!(MD.customAttribute, HasCustomAttribute)(0, HasCustomAttribute.moduleRef);
        }
    }
    else static if (md == MD.typeSpec)
    {
        public const(TypeSpecSig) signature()
        {
            auto data = getBlob(0);
            return TypeSpecSig(table.db, data);
        }

        public auto attributes()
        {
            return getRange!(MD.customAttribute, HasCustomAttribute)(0, HasCustomAttribute.moduleRef);
        }
    }
    else static if (md == MD.implMap)
    {
        public PInvokeAttributes implAttributes()
        {
            return PInvokeAttributes(getValue!ushort(0));
        }

        public auto memberForwarded()
        {
            auto idx = getCompositeIndex!MemberForwarded(1);
            return compositeValue(table.db, idx);
        }

        public string name()
        {
            return getString(2);
        }

        public auto importScope()
        {
            return table.db.moduleRefTable[getValue!uint(3)];
        }

    }
    else static if (md == MD.fieldRVA)
    {
        public uint rva()
        {
            return getValue!uint(0);
        }

        public auto parent()
        {
            return table.db.fieldTable[getValue!uint(1)];
        }
    }
    else static if (md == MD.assembly)
    {
        public AssemblyHashAlgorithm algorithm()
        {
            return getValue!AssemblyHashAlgorithm(0);
        }

        public AssemblyVersion ver()
        {
            auto v = getValue!ulong(1);
            return *cast(AssemblyVersion*)(&v);
        }

        public AssemblyAttributes assemblyAttributes()
        {
            return AssemblyAttributes(getValue!uint(2));
        }

        public const(ubyte)[] publicKey()
        {
            return getBlob(3);
        }

        public string name()
        {
            return getString(4);
        }

        public string culture()
        {
            return getString(5);
        }

        public auto attributes()
        {
            return getRange!(MD.customAttribute, HasCustomAttribute)(0, HasCustomAttribute.assembly);
        }

    }
    else static if (md == MD.assemblyProcessor)
    {
        public AssemblyArch processor()
        {
            return getValue!AssemblyArch(0);
        }
    }
    else static if (md == MD.assemblyOS)
    {
        public uint osPlatform()
        {
            return getValue!uint(0);
        }

        public uint osMajorVersion()
        {
            return getValue!uint(1);
        }

        public uint osMinorVersion()
        {
            return getValue!uint(2);
        }
    }
    else static if (md == MD.assemblyRef)
    {
        public AssemblyVersion ver()
        {
            auto v = getValue!ulong(0);
            return *cast(AssemblyVersion*)(&v);
        }

        public AssemblyAttributes assemblyAttributes()
        {
            return AssemblyAttributes(getValue!uint(1));
        }

        public const(ubyte)[] publicKeyOrToken()
        {
            return getBlob(2);
        }

        public string name()
        {
            return getString(3);
        }

        public string culture()
        {
            return getString(4);
        }

        public auto attributes()
        {
            return getRange!(MD.customAttribute, HasCustomAttribute)(0, HasCustomAttribute.assemblyRef);
        }

    }
    else static if (md == MD.assemblyRefProcessor)
    {
        public AssemblyArch processor()
        {
            return getValue!AssemblyArch(0);
        }

        public auto assembly()
        {
            return table.db.assemblyRefTable[getValue!uint(1)];
        }
    }
    else static if (md == MD.assemblyRefOS)
    {
        public uint osPlatform()
        {
            return getValue!uint(0);
        }

        public uint osMajorVersion()
        {
            return getValue!uint(1);
        }

        public uint osMinorVersion()
        {
            return getValue!uint(2);
        }

        public auto assembly()
        {
            return table.db.assemblyRefTable[getValue!uint(3)];
        }
    }
    else static if (md == MD.file)
    {
        public bool hasMetadata()
        {
            return getValue!uint(0) != 0;
        }

        public string name()
        {
            return getString(1);
        }

        public const(ubyte)[] hash()
        {
            return getBlob(2);
        }

        public auto attributes()
        {
            return getRange!(MD.customAttribute, HasCustomAttribute)(0, HasCustomAttribute.file);
        }
    }
    else static if (md == MD.exportedType)
    {
        public TypeAttributes typeAttributes()
        {
            return TypeAttributes(getValue!uint(0));
        }

        public Nullable!TypeDef hint()
        {
            auto hintIndex = getValue!uint(1);
            if (table.db.typeDefTable.rowCount <= hintIndex)
            {
                auto td = table.db.typeDefTable[hintIndex];
                if (td.name == name && td.namespace == td.namespace)
                    return Nullable!TypeDef(td);
            }
            return (Nullable!TypeDef).init;
        }

        public string name()
        {
            return getString(2);
        }

        public string namespace()
        {
            return getString(3);
        }

        public auto implementation()
        {
            auto idx = getCompositeIndex!Implementation(4);
            return compositeValue(table.db, idx);
        }

        public auto attributes()
        {
            return getRange!(MD.customAttribute, HasCustomAttribute)(0, HasCustomAttribute.exportedType);
        }

    }
    else static if (md == MD.manifestResource)
    {        
        public uint offset()
        {
            return getValue!uint(0);
        }

        public ManifestVisibility visibility()
        {
            return getValue!ManifestVisibility(1);
        }

        public string name()
        {
            return getString(2);
        }

        public auto implementation()
        {
            auto idx = getCompositeIndex!Implementation(3);
            if (idx.codedIndex == 0)
                return Nullable!(ImplementationValue).init;
            return Nullable!(ImplementationValue)(compositeValue(table.db, idx));
        }

        public auto attributes()
        {
            return getRange!(MD.customAttribute, HasCustomAttribute)(0, HasCustomAttribute.manifestResource);
        }
    }
    else static if (md == MD.nestedClass)
    {        
        public auto nested()
        {
            return table.db.typeDefTable[getValue!uint(0)];
        }

        public auto enclosing()
        {
            return table.db.typeDefTable[getValue!uint(1)];
        }


    }
    else static if (md == MD.genericParam)
    {        
        public ushort rank()
        {
            return getValue!ushort(0);
        }

        public GenericAttributes genericAttributes()
        {
            return GenericAttributes(getValue!ushort(1));
        }

        public auto owner()
        {
            auto idx = getCompositeIndex!TypeOrMethodDef(2);
            return compositeValue(table.db, idx);
        }

        public string name()
        {
            return getString(3);
        }

        public auto attributes()
        {
            return getRange!(MD.customAttribute, HasCustomAttribute)(0, HasCustomAttribute.genericParam);
        }

    }
    else static if (md == MD.genericParamConstraint)
    {        
        public auto owner()
        {
            return table.db.genericParamTable[getValue!uint(0)];
        }

        public auto constraint()
        {
            auto idx = getCompositeIndex!TypeDefOrRef(1);
            return compositeValue(table.db, idx);
        }

        public auto attributes()
        {
            return getRange!(MD.customAttribute, HasCustomAttribute)(0, HasCustomAttribute.genericParamConstraint);
        }

    }
    else static assert ("Row!(" ~ md.stringof  ~ ") not implemented");
}

public enum MD
{
    module_,
    typeRef,
    typeDef,
    field,
    methodDef,
    param,
    interfaceImpl, 
    memberRef,
    constant,
    customAttribute,
    fieldMarshal,
    declSecurity,
    classLayout,
    fieldLayout,
    standAloneSig,
    eventMap,
    event,
    propertyMap,
    property,
    methodSemantics,
    methodImpl, 
    moduleRef,
    typeSpec,
    implMap,
    fieldRVA,
    assembly,
    assemblyProcessor,
    assemblyOS,
    assemblyRef,
    assemblyRefProcessor,
    assemblyRefOS,
    file,
    exportedType,
    manifestResource,
    nestedClass,
    genericParam,
    methodSpec,
    genericParamConstraint, 
    unknown,
}


private struct TableEnumerator(MD md)
{

    const(Table!md)* table;
    uint index;

    @disable this();

    this(const(Table!md)* table)
    {
        this.table = table;
        static if (md == MD.typeDef)
            index = 2;
        else 
            index = 1;
    }

    pragma(inline, true)
    bool empty()
    {
        return index > table.rowCount;
    }

    pragma(inline, true)
    void popFront()
    {
        ++index;
    }

    pragma(inline, true)
    auto front()
    {
        return Row!md(table, index);        
    }
}

private struct RangeEnumerator(MD md)
{
    const(Metadata)* db;
    uint sourceIndex;
    uint targetRow;
    uint targetColumn;    


    @disable this();

    this(const(Metadata)* db, uint sourceIndex, uint targetColumn)
    {
        this.db = db;
        this.sourceIndex = sourceIndex;
        this. targetColumn = targetColumn;
        targetRow = 0;
        while (targetRow < db.getTable!md.rowCount)
        {
            auto targetIndex = db.getTable!md.getValue!uint(targetRow, targetColumn);
            if (targetIndex == sourceIndex)
                break;
            ++targetRow;
        }
    }

    pragma(inline, true)
        bool empty() const
        {        
            return targetRow >= db.getTable!md.rowCount 
                || db.getTable!md.getValue!uint(targetRow, targetColumn) != sourceIndex;
        }

    pragma(inline, true)
        void popFront()
        {
            ++targetRow;       
        }

    pragma(inline, true)
        auto front()
        {
            return db.getTable!md[targetRow + 1];        
        }
}

private struct CompositeRangeEnumerator(MD md, T)
{
    const(Metadata)* db;
    CompositeIndex!T sourceIndex;
    uint targetRow;
    uint targetColumn;    


    @disable this();

    this(const(Metadata)* db, CompositeIndex!T sourceIndex, uint targetColumn)
    {
        this.db = db;
        this.sourceIndex = sourceIndex;
        this.targetColumn = targetColumn;
        targetRow = 0;
        while (targetRow < db.getTable!md.rowCount)
        {
            auto targetIndex = db.getTable!md.getCompositeIndex!T(targetRow, targetColumn);
            if (targetIndex.codedIndex == sourceIndex.codedIndex)
                break;
            ++targetRow;
        }
    }

    pragma(inline, true)
        bool empty() const
        {
            return targetRow >= db.getTable!md.rowCount 
                || db.getTable!md.getCompositeIndex!T(targetRow, targetColumn).codedIndex != sourceIndex.codedIndex;
        }

    pragma(inline, true)
        void popFront()
        {
            ++targetRow;       
        }

    pragma(inline, true)
        auto front()
        {
            return db.getTable!md[targetRow + 1];        
        }
}

private struct ListEnumerator(MD md)
{
    uint nextIndex;
    uint currentIndex;
    const(Metadata)* db;

    @disable this();
    this(const(Metadata)* db, uint startIndex, uint nextIndex)
    {
        this.db = db;        
        if (nextIndex == 0)
            nextIndex = db.getTable!md.rowCount + 1;
        this.nextIndex = nextIndex;
        currentIndex = startIndex;
    }

    pragma(inline, true);
    bool empty()
    {
        return currentIndex >= nextIndex;
    }

    pragma(inline, true);
    void popFront()
    {
        ++currentIndex;
    }

    pragma(inline, true);
    auto front()
    {
        return db.getTable!md[currentIndex];
    }


}

private struct Column
{
    ubyte offset;
    ubyte size;
}




public alias Module = Row!(MD.module_);
public alias TypeRef = Row!(MD.typeRef);
public alias TypeDef = Row!(MD.typeDef);
public alias Field = Row!(MD.field);
public alias MethodDef = Row!(MD.methodDef);
public alias Param = Row!(MD.param);
public alias InterfaceImpl = Row!(MD.interfaceImpl);
public alias MemberRef = Row!(MD.memberRef);
public alias Constant = Row!(MD.constant);
public alias CustomAttribute = Row!(MD.customAttribute);
public alias FieldMarshal = Row!(MD.fieldMarshal);
public alias DeclSecurity = Row!(MD.declSecurity);
public alias ClassLayout = Row!(MD.classLayout);
public alias FieldLayout = Row!(MD.fieldLayout);
public alias StandAloneSig = Row!(MD.standAloneSig);
public alias EventMap = Row!(MD.eventMap);
public alias Event = Row!(MD.event);
public alias PropertyMap = Row!(MD.propertyMap);
public alias Property = Row!(MD.property);
public alias MethodSemantics = Row!(MD.methodSemantics);
public alias MethodImpl = Row!(MD.methodImpl);
public alias ModuleRef = Row!(MD.moduleRef);
public alias TypeSpec = Row!(MD.typeSpec);
public alias ImplMap = Row!(MD.implMap);
public alias FieldRVA = Row!(MD.fieldRVA);
public alias Assembly = Row!(MD.assembly);
public alias AssemblyProcessor = Row!(MD.assemblyProcessor);
public alias AssemblyOS = Row!(MD.assemblyOS);
public alias AssemblyRef = Row!(MD.assemblyRef);
public alias AssemblyRefProcessor = Row!(MD.assemblyRefProcessor);
public alias AssemblyRefOS = Row!(MD.assemblyRefOS);
public alias File = Row!(MD.file);
public alias ExportedType = Row!(MD.exportedType);
public alias ManifestResource = Row!(MD.manifestResource);
public alias NestedClass = Row!(MD.nestedClass);
public alias GenericParam = Row!(MD.genericParam);
public alias MethodSpec = Row!(MD.methodSpec);
public alias GenericParamConstraint = Row!(MD.genericParamConstraint);

public alias ResolutionScopeValue = Algebraic!(Module, ModuleRef, AssemblyRef, TypeRef);
public alias TypeDefOrRefValue = Algebraic!(TypeDef, TypeRef, TypeSpec);
public alias MemberRefParentValue = Algebraic!(TypeDef, TypeRef, TypeSpec, ModuleRef, MethodDef);
public alias HasConstantValue = Algebraic!(Param, Field, Property);
public alias HasCustomAttributeValue = Algebraic!(MethodDef, Field, TypeRef, TypeDef, Param, InterfaceImpl, MemberRef,
                                                  Module, DeclSecurity, Property, Event, StandAloneSig, ModuleRef, 
                                                  TypeSpec, Assembly, AssemblyRef, File, ExportedType, ManifestResource, 
                                                  GenericParam, GenericParamConstraint, MethodSpec);
public alias MethodDefOrRefValue = Algebraic!(MethodDef, MemberRef);
public alias HasFieldMarshalValue = Algebraic!(Field, Param);
public alias HasDeclSecurityValue = Algebraic!(TypeDef, MethodDef, Assembly);
public alias HasSemanticsValue = Algebraic!(Property, Event);
public alias MemberForwardedValue = Algebraic!(Field, MethodDef);
public alias ImplementationValue = Algebraic!(File, AssemblyRef, ExportedType);
public alias TypeOrMethodDefValue = Algebraic!(TypeDef, MethodDef);
public alias CustomAttributeTypeValue = Algebraic!(MethodDef, MemberRef);


public struct TypeAttributes
{
    @disable this();
    private this(uint bits)
    {
        _bits = bits;
    }

    public TypeVisibility visibility() const
    {
        return cast(TypeVisibility)(_bits & 0x7);
    }

    public TypeLayout layout() const
    {
        return cast(TypeLayout)(_bits & 0x18);
    }

    public TypeSemantics semantics() const
    {
        return cast(TypeSemantics)(_bits & 0x60);
    }

    public bool isAbstract() const
    {
        return (_bits & 0x80) == 0x80;
    }

    public bool isSealed() const
    {
        return (_bits & 0x100) == 0x100;
    }

    public bool hasSpecialName() const
    {
        return (_bits & 0x400) == 0x400;
    }

    public bool isImport() const
    {
        return (_bits & 0x1000) == 0x1000;
    }

    public bool isSerializable() const
    {
        return (_bits & 0x2000) == 0x2000;
    }

    public StringFormat format() const
    {
        return cast(StringFormat)(_bits & 0x30000);
    }

    public bool beforeFieldInit() const
    {
        return (_bits & 0x100000) == 0x100000;
    }

    public bool hasRuntimeSpecialName() const
    {
        return (_bits & 0x800) == 0x800;
    }

    public bool hasSecurity() const
    {
        return (_bits & 0x40000) == 0x40000;
    }

    public bool isTypeForwarder() const
    {
        return (_bits & 0x200000) == 0x200000;
    }

    public bool isWindowsRuntime() const
    {
        return (_bits & 0x4000) == 0x4000;
    }

private:
    private uint _bits;
}

public struct FieldAttributes
{
    @disable this();
    private this(ushort bits)
    {
        _bits = bits;
    }

    public MemberAccess access() const
    {
        return cast(MemberAccess)(_bits & 0x7);
    }

    public bool isStatic() const
    {
        return (_bits & 0x10) == 0x10;
    }

    public bool isInitOnly() const
    {
        return (_bits & 0x20) == 0x20;
    }

    public bool isLiteral() const
    {
        return (_bits & 0x40) == 0x40;
    }

    public bool dontSerialize() const
    {
        return (_bits & 0x80) == 0x80;
    }

    public bool hasSpecialName() const
    {
        return (_bits & 0x200) == 0x200;
    }

    public bool pInvokeImplemented() const
    {
        return (_bits & 0x2000) == 0x2000;
    }

    public bool hasRuntimeSpecialName() const
    {
        return (_bits & 0x400) == 0x400;
    }

    public bool hasFieldMarshal() const
    {
        return (_bits & 0x1000) == 0x1000;
    }

    public bool hasDefault() const
    {
        return (_bits & 0x8000) == 0x8000;
    }

    public bool hasFieldRVA() const
    {
        return (_bits & 0x100) == 0x100;
    }


private:
    ushort _bits;
}

public struct MethodAttributes
{
    @disable this();
    private this(ushort impl, ushort attr)
    {
        _impl = impl;
        _attr = attr;
    }

    public CodeType codeType() const
    {
        return cast(CodeType)(_impl & 0x03);
    }

    public bool isManaged() const
    {
        return (_impl & 0x04) != 0x04;
    }

    public bool isForwardReference() const
    {
        return (_impl & 0x10) == 0x10;
    }

    public bool preserveSignature() const
    {
        return (_impl & 0x80) == 0x80;
    }

    public bool isInternalCall() const
    {
        return (_impl & 0x1000) == 0x1000;
    }

    public bool isSynchronized() const
    {
        return (_impl & 0x20) == 0x20;
    }

    public bool dontInline() const
    {
        return (_impl & 0x8) == 0x8;
    }

    public MemberAccess access() const
    {
        return cast(MemberAccess)(_attr & 0x7);
    } 

    public bool isStatic() const
    {
        return (_attr & 0x10) == 0x10;
    }

    public bool isFinal() const
    {
        return (_attr & 0x20) == 0x20;
    }

    public bool isVirtual() const
    {
        return (_attr & 0x40) == 0x40;
    }

    public bool hideBySig() const
    {
        return (_attr & 0x80) == 0x80;
    }

    public bool reuseSlot() const
    {
        return (_attr & 0x100) != 0x100;
    }

    public bool overrideAccess() const
    {
        return (_attr & 0x200) == 0x200;
    }

    public bool isAbstract() const
    {
        return (_attr & 0x400) == 0x400;
    }

    public bool hasSpecialName() const
    {
        return (_attr & 0x800) == 0x800;
    }

    public bool pInvoke() const
    {
        return (_attr & 0x2000) == 0x2000;
    }

    public bool hasRuntimeSpecialName() const
    {
        return (_attr & 0x1000) == 0x1000;
    }

    public bool hasSecurity() const
    {
        return (_attr & 0x4000) == 0x4000;
    }

    public bool requiresSecurity() const
    {
        return (_attr & 0x8000) == 0x8000;
    }
    private ushort _impl;
    private ushort _attr;
}

public struct ParamAttributes
{
    @disable this();
    private this(ushort bits)
    {
        _bits = bits;
    }

    public MemberAccess access() const
    {
        return cast(MemberAccess)(_bits & 0x7);
    }

    public bool isIn() const
    {
        return (_bits & 0x01) == 0x01;
    }

    public bool isOut() const
    {
        return (_bits & 0x02) == 0x02;
    }

    public bool isOptional() const
    {
        return (_bits & 0x10) == 0x10;
    }

    public bool hasDefault() const
    {
        return (_bits & 0x1000) == 0x1000;
    }

    public bool hasFieldMarshal() const
    {
        return (_bits & 0x2000) == 0x2000;
    }
private:
    ushort _bits;
}

public struct EventAttributes
{
    @disable this();
    private this(ushort bits)
    {
        _bits = bits;
    }

    public bool hasSpecialName() const
    {
        return (_bits & 0x0200) == 0x0200;
    }

    public bool hasRuntimeSpecialName() const
    {
        return (_bits & 0x0400) == 0x0400;
    }

private:
    ushort _bits;
}

public struct PropertyAttributes
{
    @disable this();
    private this(ushort bits)
    {
        _bits = bits;
    }

    public bool hasSpecialName() const
    {
        return (_bits & 0x0200) == 0x0200;
    }

    public bool hasRuntimeSpecialName() const
    {
        return (_bits & 0x0400) == 0x0400;
    }

    public bool hasDefault() const
    {
        return (_bits & 0x1000) == 0x1000;
    }

private:
    ushort _bits;
}

public struct SemanticsAttributes
{
    @disable this();
    private this(ushort bits)
    {
        _bits = bits;
    }

    public bool isSetter() const
    {
        return (_bits & 0x0001) == 0x0001;
    }

    public bool isGetter() const
    {
        return (_bits & 0x0002) == 0x0002;
    }

    public bool isOther() const
    {
        return (_bits & 0x0004) == 0x0004;
    }

    public bool isAddOn() const
    {
        return (_bits & 0x0008) == 0x0008;
    }

    public bool isRemoveOn() const
    {
        return (_bits & 0x0010) == 0x0010;
    }

    public bool isFire() const
    {
        return (_bits & 0x0020) == 0x0020;
    }

private:
    ushort _bits;
}

public struct PInvokeAttributes
{
    @disable this();
    private this(ushort bits)
    {
        _bits = bits;
    }

    public PInvokeStringFormat stringFormat() const
    {
        return cast(PInvokeStringFormat)(_bits & 0x6);
    }

    public BestFit bestFit() const
    {
        return cast(BestFit)(_bits & 0x30);
    }

    public ThrowOnInvalidChar throwOnInvalidChar() const
    {
        return cast(ThrowOnInvalidChar)(_bits & 0x3000);
    }

    public CallConv callConvention() const
    {
        return cast(CallConv)(_bits & 0x0700);
    }

    public bool dontMangle() const
    {
        return (_bits & 0x0001) == 0x0001;
    }

    public bool supportsLastError() const
    {
        return (_bits & 0x0040) == 0x0040;
    }
private:
    ushort _bits;
}

public struct AssemblyAttributes
{
    @disable this();
    private this(uint bits)
    {
        _bits = bits;
    }

    public AssemblyArch architecture() const
    {
        return cast(AssemblyArch)(_bits & 0x70);
    }

    public bool hasPublicKey() const
    {
        return (_bits & 0x0001) == 0x0001;
    }

    public bool disableTracking() const
    {
        return (_bits & 0x8000) == 0x8000;
    }

    public bool disapleOptimization() const
    {
        return (_bits & 0x4000) == 0x4000;
    }

    public bool isRetargetable() const
    {
        return (_bits & 0x100) == 0x100;
    }

    public bool windowsRuntime() const
    {
        return (_bits & 0x200) == 0x200;
    }

private:
    uint _bits;
}

public struct GenericAttributes
{
    @disable this();
    private this(ushort bits)
    {
        _bits = bits;
    }

    public Variance variance() const
    {
        return cast(Variance)(_bits & 0x03);
    }

    public Constraint constraint() const
    {
        return cast(Constraint)(_bits & 0x1c);
    }    

private:
    ushort _bits;
}

private auto compositeValue(T)(const(Metadata)* db, CompositeIndex!T c)
{


    static if (is(T == ResolutionScope))
    {
        final switch (c.type)
        {
            case ResolutionScope.module_:
                return ResolutionScopeValue(db.moduleTable[c.index]);
            case ResolutionScope.moduleRef:
                return ResolutionScopeValue(db.moduleRefTable[c.index]);
            case ResolutionScope.assemblyRef:
                return ResolutionScopeValue(db.assemblyRefTable[c.index]);
            case ResolutionScope.typeRef:
                return ResolutionScopeValue(db.typeRefTable[c.index]);
        }
    }
    else static if (is(T == MethodDefOrRef))
    {
        final switch (c.type)
        {
            case MethodDefOrRef.methodDef:
                return MethodDefOrRefValue(db.methodDefTable[c.index]);
            case MethodDefOrRef.memberRef:
                return MethodDefOrRefValue(db.memberRefTable[c.index]);
        }
    }
    else static if (is(T == CustomAttributeType))
    {
        final switch (c.type)
        {
            case CustomAttributeType.methodDef:
                return CustomAttributeTypeValue(db.methodDefTable[c.index]);
            case CustomAttributeType.memberRef:
                return CustomAttributeTypeValue(db.memberRefTable[c.index]);
        }
    }
    else static if (is(T == HasSemantics))
    {
        final switch (c.type)
        {
            case HasSemantics.event:
                return HasSemanticsValue(db.eventTable[c.index]);
            case HasSemantics.property:
                return HasSemanticsValue(db.propertyTable[c.index]);
        }
    }
    else static if (is(T == TypeOrMethodDef))
    {
        final switch (c.type)
        {
            case TypeOrMethodDef.typeDef:
                return TypeOrMethodDefValue(db.typeDefTable[c.index]);
            case TypeOrMethodDef.methodDef:
                return TypeOrMethodDefValue(db.methodDefTable[c.index]);
        }
    }
    else static if (is(T == MemberForwarded))
    {
        final switch (c.type)
        {
            case MemberForwarded.methodDef:
                return MemberForwardedValue(db.methodDefTable[c.index]);
            case MemberForwarded.field:
                return MemberForwardedValue(db.fieldTable[c.index]);
        }
    }
    else static if (is(T == HasFieldMarshal))
    {
        final switch (c.type)
        {
            case HasFieldMarshal.param:
                return HasFieldMarshalValue(db.paramTable[c.index]);
            case HasFieldMarshal.field:
                return HasFieldMarshalValue(db.fieldTable[c.index]);
        }
    }
    else static if (is(T == TypeDefOrRef))
    {
        final switch (c.type)
        {
            case TypeDefOrRef.typeDef:
                return TypeDefOrRefValue(db.typeDefTable[c.index]);
            case TypeDefOrRef.typeRef:
                return TypeDefOrRefValue(db.typeRefTable[c.index]);
            case TypeDefOrRef.typeSpec:
                return TypeDefOrRefValue(db.typeSpecTable[c.index]);
        }
    }
    else static if (is(T == HasDeclSecurity))
    {
        final switch (c.type)
        {
            case HasDeclSecurity.typeDef:
                return HasDeclSecurityValue(db.typeDefTable[c.index]);
            case HasDeclSecurity.methodDef:
                return HasDeclSecurityValue(db.methodDefTable[c.index]);
            case HasDeclSecurity.assembly:
                return HasDeclSecurityValue(db.assemblyTable[c.index]);
        }
    }
    else static if (is(T == MemberRefParent))
    {
        final switch (c.type)
        {
            case MemberRefParent.typeDef:
                return MemberRefParentValue(db.typeDefTable[c.index]);
            case MemberRefParent.typeRef:
                return MemberRefParentValue(db.typeRefTable[c.index]);
            case MemberRefParent.typeSpec:
                return MemberRefParentValue(db.typeSpecTable[c.index]);
            case MemberRefParent.moduleRef:
                return MemberRefParentValue(db.moduleRefTable[c.index]);
            case MemberRefParent.methodDef:
                return MemberRefParentValue(db.methodDefTable[c.index]);
        }
    }
    else static if (is(T == HasConstant))
    {
        final switch (c.type)
        {
            case HasConstant.param:
                return HasConstantValue(db.paramTable[c.index]);
            case HasConstant.field:
                return HasConstantValue(db.fieldTable[c.index]);
            case HasConstant.property:
                return HasConstantValue(db.propertyTable[c.index]);
        }
    }
    else static if (is(T == Implementation))
    {
        final switch (c.type)
        {
            case Implementation.file:
                return ImplementationValue(db.fileTable[c.index]);
            case Implementation.assemblyRef:
                return ImplementationValue(db.assemblyRefTable[c.index]);
            case Implementation.exportedType:
                return ImplementationValue(db.exportedTypeTable[c.index]);
        }
    }
    else static if(is(T == HasCustomAttribute))
    {
        final switch(c.type)
        {
            case HasCustomAttribute.methodDef:
                return HasCustomAttributeValue(db.methodDefTable[c.index]);
            case HasCustomAttribute.field:
                return HasCustomAttributeValue(db.fieldTable[c.index]);
            case HasCustomAttribute.typeRef:
                return HasCustomAttributeValue(db.typeRefTable[c.index]);
            case HasCustomAttribute.typeDef:
                return HasCustomAttributeValue(db.typeDefTable[c.index]);
            case HasCustomAttribute.param:
                return HasCustomAttributeValue(db.paramTable[c.index]);
            case HasCustomAttribute.interfaceImpl:
                return HasCustomAttributeValue(db.interfaceImplTable[c.index]);
            case HasCustomAttribute.memberRef:
                return HasCustomAttributeValue(db.memberRefTable[c.index]);
            case HasCustomAttribute.module_:
                return HasCustomAttributeValue(db.moduleTable[c.index]);
            case HasCustomAttribute.permission:
                return HasCustomAttributeValue(db.declSecurityTable[c.index]);
            case HasCustomAttribute.property:
                return HasCustomAttributeValue(db.propertyTable[c.index]);
            case HasCustomAttribute.event:
                return HasCustomAttributeValue(db.eventTable[c.index]);
            case HasCustomAttribute.standAloneSig:
                return HasCustomAttributeValue(db.standAloneSigTable[c.index]);
            case HasCustomAttribute.moduleRef:
                return HasCustomAttributeValue(db.moduleRefTable[c.index]);
            case HasCustomAttribute.typeSpec:
                return HasCustomAttributeValue(db.typeSpecTable[c.index]);
            case HasCustomAttribute.assembly:
                return HasCustomAttributeValue(db.assemblyTable[c.index]);
            case HasCustomAttribute.assemblyRef:
                return HasCustomAttributeValue(db.assemblyRefTable[c.index]);
            case HasCustomAttribute.file:
                return HasCustomAttributeValue(db.fileTable[c.index]);
            case HasCustomAttribute.exportedType:
                return HasCustomAttributeValue(db.exportedTypeTable[c.index]);
            case HasCustomAttribute.manifestResource:
                return HasCustomAttributeValue(db.manifestResourceTable[c.index]);
            case HasCustomAttribute.genericParam:
                return HasCustomAttributeValue(db.genericParamTable[c.index]);
            case HasCustomAttribute.genericParamConstraint:
                return HasCustomAttributeValue(db.genericParamConstraintTable[c.index]);
            case HasCustomAttribute.methodSpec:
                return HasCustomAttributeValue(db.methodSpecTable[c.index]);
        }
    }

}



enum MemberAccess : ushort
{
    CompilerControlled  = 0x0000,
    Private             = 0x0001,
    FamAndAssem         = 0x0002,      
    Assembly            = 0x0003,         
    Family              = 0x0004,            
    FamOrAssem          = 0x0005,         
    Public              = 0x0006,
}

enum TypeVisibility
{
    NotPublic           = 0x00000000,
    Public              = 0x00000001,
    NestedPublic        = 0x00000002,
    NestedPrivate       = 0x00000003,
    NestedFamily        = 0x00000004,
    NestedAssembly      = 0x00000005,
    NestedFamANDAssem   = 0x00000006,
    NestedFamORAssem    = 0x00000007,
}


enum ManifestVisibility: uint
{
    none        = 0x0000,
    public_     = 0x0001,
    private_    = 0x0002,
}

enum TypeLayout 
{
    AutoLayout          = 0x00000000,
    SequentialLayout    = 0x00000008,
    ExplicitLayout      = 0x00000010,
}

enum TypeSemantics
{
    class_      = 0x00000000,
    interface_  = 0x00000020,
}

enum StringFormat
{
    AnsiClass           = 0x00000000,
    UnicodeClass        = 0x00010000,
    AutoClass           = 0x00020000,
    CustomFormatClass   = 0x00030000,
    CustomFormatMask    = 0x00C00000,
}

enum PInvokeStringFormat : ushort
{
    notSpecified    = 0x0000,
    ansi            = 0x0002,
    unicode         = 0x0004,
    auto_           = 0x0006,
}


enum BestFit : ushort
{
    useAssembly    = 0x0000,
    enabled        = 0x0010,
    disabled       = 0x0020,
}

enum ThrowOnInvalidChar : ushort
{
    useAssembly    = 0x0000,
    enabled        = 0x1000,
    disabled       = 0x2000,
}

enum CallConv : ushort
{
    winapi    = 0x0100,
    cdecl     = 0x0200,
    stdcall   = 0x0300,
    thiscall  = 0x0400,
    fastcall  = 0x0500,
}


enum CodeType : ushort
{
    IL      = 0x0000,      
    Native  = 0x0001,  
    OPTIL   = 0x0002,   
    Runtime = 0x0003, 
}

enum Managed : ushort
{
    Unmanaged   = 0x0004,
    Managed     = 0x0000,
}

enum TableLayout : ushort
{
    ReuseSlot   = 0x0000, 
    NewSlot     = 0x0100, 
}

enum GenericParamVariance : ushort
{
    None            = 0x0000,
    Covariant       = 0x0001,
    ContraVariant   = 0x0002,
}

enum GenericParamSpecialConstraint : ushort
{
    ReferenceTypeConstraint         = 0x0004,
    NotNullableValueTypeConstraint  = 0x0008,
    DefaultConstructorConstraint    = 0x0010,
}

enum ConstantType : ushort
{
    boolean = 0x02,
    char_   = 0x03,
    int8    = 0x04,
    uint8   = 0x05,
    int16   = 0x06,
    uint16  = 0x07,
    int32   = 0x08,
    uint32  = 0x09,
    int64   = 0x0a,
    uint64  = 0x0b,
    float32 = 0x0c,
    float64 = 0x0d,
    string  = 0x0e,
    class_   = 0x12
}






enum AssemblyHashAlgorithm
{
    None            = 0x0000,
    Reserved_MD5    = 0x8003,
    SHA1            = 0x8004,
}


enum AssemblyArch : uint
{
    none    = 0x0000,
    msil    = 0x0010,
    x86     = 0x0020,
    ia64    = 0x0030,
    amd64   = 0x0040,
}

enum SecurityAction : ushort
{
    demand              = 0x0002,
    assert_             = 0x0003,
    deny                = 0x0004,
    permitOnly          = 0x0005,
    linkDemand          = 0x0006,
    inheritanceDemand   = 0x0007,
    requestMinimum      = 0x0008,
    requestOptional     = 0x0009,
    requestRefuse       = 0x0010,
}

struct AssemblyVersion
{    
    ushort majorVersion;
    ushort minorVersion;
    ushort buildNumber;
    ushort revisionNumber;
};

enum Variance : ushort
{
    nonVariant      = 0x0000,
    coVariant       = 0x0001,
    contraVariant   = 0x0002,
}

enum Constraint : ushort
{
    special             = 0x0000,
    reference           = 0x0004,
    notNullable         = 0x0008,
    defaultConstructor  = 0x0010
}

struct CustomModSig
{
    @disable this();
    private this(ref const(ubyte)[] data)
    {
        elementType = readCompressed!ElementType(data);
        assert(elementType == ElementType.cModOpt || elementType == ElementType.cModReqd);
        typeIndex = CompositeIndex!TypeDefOrRef(readCompressed!uint(data));        
    }

    ElementType elementType;
    CompositeIndex!TypeDefOrRef typeIndex;
}

CustomModSig[] readCustomMods(ref const(ubyte)[] data)
{
    CustomModSig[] mods;
    auto et = peekCompressed!ElementType(data);
    while (et == ElementType.cModOpt || et == ElementType.cModReqd)
    {
        mods ~= CustomModSig(data);
        et = peekCompressed!ElementType(data);
    }
    return mods;
}

struct GenericTypeIndex { uint index; }
struct GenericMethodTypeIndex { uint index; }

struct TypeSig
{    
    alias TypeValue = Algebraic!(ElementType, TypeDef, TypeRef, TypeSpec, GenericTypeInstSig, GenericTypeIndex, GenericMethodTypeIndex);
    private this(const(Metadata)* db, ref const(ubyte)[] data)
    {
        isSZArray = readCompressedCond!ElementType(data, ElementType.szArray);
        isArray = readCompressedCond!ElementType(data, ElementType.array);
        while (readCompressedCond!ElementType(data, ElementType.ptr))
            ++ptrCount;
        customMods = readCustomMods(data);
        elementType = peekCompressed!ElementType(data);
        type = readTypeValue(db, data);
        if (isArray)
        {
            arrayRank = readCompressed(data);
            arraySizes.length = readCompressed(data);
            for (size_t i = 0; i < arraySizes.length; ++i)
                arraySizes[i] = readCompressed(data);
        }
    }

    bool isSZArray;
    bool isArray;
    int ptrCount;
    ElementType elementType;
    TypeValue type;
    uint arrayRank;
    uint[] arraySizes;
    CustomModSig[] customMods;

    private TypeValue readTypeValue(const(Metadata*) db, ref const(ubyte)[] data)
    {        
        auto t = readCompressed!ElementType(data);
        switch (t)
        {
            case ElementType.boolean:
            case ElementType.char_:
            case ElementType.i1:
            case ElementType.u1:
            case ElementType.i2:
            case ElementType.u2:
            case ElementType.i4:
            case ElementType.u4:
            case ElementType.i8:
            case ElementType.u8:
            case ElementType.r4:
            case ElementType.r8:
            case ElementType.string:
            case ElementType.object:
            case ElementType.u:
            case ElementType.i:
            case ElementType.void_:
                return TypeValue(t);
            case ElementType.class_:
            case ElementType.valueType:
                auto ci = CompositeIndex!TypeDefOrRef(readCompressed(data));
                if (ci.type == TypeDefOrRef.typeDef)
                    return TypeValue(db.typeDefTable[ci.index]);
                else if (ci.type == TypeDefOrRef.typeRef)
                    return TypeValue(db.typeRefTable[ci.index]);
                else
                    return TypeValue(db.typeSpecTable[ci.index]);
            case ElementType.var:
                return TypeValue(GenericTypeIndex(readCompressed(data)));
            case ElementType.mVar:
                return TypeValue(GenericMethodTypeIndex(readCompressed(data)));                
            case ElementType.genericInst:
                return TypeValue(GenericTypeInstSig(db, data));
            default:
                throw new Exception("Invalid element type");
        }
        assert(0);
    }
}

struct GenericTypeInstSig
{
    private this(const(Metadata*) db, ref const(ubyte)[] data)
    {
        value = readCompressed!ElementType(data);
        enforce(value == ElementType.class_ || value == ElementType.valueType, "Invalid generic type instantation");
        typeIndex = CompositeIndex!TypeDefOrRef(readCompressed!uint(data));
        genericArgs.length = readCompressed(data);
        enforce(genericArgs.length <= data.length, "Invalid generic argument count");
        for (size_t i = 0; i < genericArgs.length; ++i)
            genericArgs[i] = TypeSig(db, data);
    }

    ElementType value;
    CompositeIndex!TypeDefOrRef typeIndex;
    TypeSig[] genericArgs;    
}

struct ParamSig
{
    private this(const(Metadata*) db, ref const(ubyte)[] data)
    {     
        customMods = readCustomMods(data);
        isByRef = readCompressedCond(data, ElementType.byRef);
        typeSig = TypeSig(db, data);
    }

    CustomModSig[] customMods;
    bool isByRef;
    TypeSig typeSig;
}

struct RetTypeSig
{
    private this(const(Metadata*) db, ref const(ubyte)[] data)
    {
        customMods = readCustomMods(data);
        isByRef = readCompressedCond(data, ElementType.byRef);
        isVoid = readCompressedCond(data, ElementType.void_);
        if (!isVoid)        
            typeSig = TypeSig(db, data);        
    }

    CustomModSig[] customMods;
    bool isByRef;
    bool isVoid;
    TypeSig typeSig;
}

struct MethodDefSig
{
    private this(const(Metadata*) db, ref const(ubyte)[] data)
    {
        callingConvention = readCompressed!CallingConvention(data);
        if (callingConvention == CallingConvention.generic)
            genericParamCount = readCompressed(data);
        params.length = readCompressed(data);
        retSig = RetTypeSig(db, data);
        enforce(params.length <= data.length, "Invalid number of parameters");
        for (size_t i = 0; i < params.length; ++i)
            params[i] = ParamSig(db, data);
    }

    CallingConvention callingConvention;
    uint genericParamCount;
    RetTypeSig retSig;
    ParamSig[] params;
}

struct FieldSig
{
    private this(const(Metadata)* db, ref const(ubyte)[] data)
    {
        callingConvention = read!CallingConvention(data);
        enforce((callingConvention & CallingConvention.field) == CallingConvention.field, "Invalid field signature");
        customMods = readCustomMods(data);
        typeSig = TypeSig(db, data);
    }

    CallingConvention callingConvention;
    CustomModSig[] customMods;
    TypeSig typeSig;
}

struct PropertySig
{
    private this(const(Metadata*) db, ref const(ubyte)[] data)
    {
        callingConvention = read!CallingConvention(data);
        enforce(callingConvention == CallingConvention.property, "Invalid calling convention for property");
        params.length = readCompressed!uint(data);
        customMods = readCustomMods(data);
        typeSig = TypeSig(db, data);
        enforce(params.length <= data.length, "Invalid parameter count for property");
        for (size_t i = 0; i < params.length; ++i)
            params[i] = ParamSig(db, data);
    }

    CallingConvention callingConvention;
    CustomModSig[] customMods;
    TypeSig typeSig;
    ParamSig[] params;
}

struct TypeSpecSig
{
    private this(const(Metadata*) db, ref const(ubyte)[] data)
    {
        isSZArray = readCompressedCond!ElementType(data, ElementType.szArray);
        isArray = readCompressedCond!ElementType(data, ElementType.array);
        while (readCompressedCond!ElementType(data, ElementType.ptr))
            ++ptrCount;
        customMods = readCustomMods(data);
        elementType = readCompressed!ElementType(data);
        if (elementType == ElementType.fnPtr)
            methodSig = MethodDefSig(db, data);
        else if (elementType == ElementType.genericInst) 
            genSig = GenericTypeInstSig(db, data);
        else 
            throw new Exception("Unsupported TypeSpec signature");
        if (isArray)
        {
            arrayRank = readCompressed(data);
            arraySizes.length = readCompressed(data);
            for (size_t i = 0; i < arraySizes.length; ++i)
                arraySizes[i] = readCompressed(data);
        }
    }

    bool isSZArray;
    bool isArray;
    int ptrCount;
    uint arrayRank;
    uint[] arraySizes;
    ElementType elementType;
    CustomModSig[] customMods;
    GenericTypeInstSig genSig;
    MethodDefSig methodSig;
}

struct SystemType 
{
    string name;
}

struct EnumDefinition
{
    alias Value = Algebraic!(bool, wchar, ubyte, byte, ushort, short, uint, int, ulong, long);
    TypeDef type;
    Value value;
}

struct ElementSig
{
    alias Value = Algebraic!(bool, wchar, ubyte, byte, ushort, short, uint, int, ulong, long, float, double, string, SystemType, EnumDefinition);

    private this(SystemType type)
    {
        value = Value(type);
    }

    private this(ElementType e, ref const(ubyte)[] data)
    {
        value = readPrimitiveValue(e, data);
    }

    private this(const ref TypeDef type, ref const(ubyte)[] data)
    {
        enforce(type.isEnum, "Only System.Enum types are supported");
        value = EnumDefinition(type, readEnumValue(type.underlyingEnumType, data));
    }

    private this(const(Metadata)* db, ref const TypeSig.TypeValue paramType, ref const(ubyte)[] data)
    {
        if (auto p = paramType.peek!ElementType())
            value = readPrimitiveValue(*p, data);
        else if (auto ti = paramType.peek!TypeRef)    
        {
            if (ti.name == "Type" && ti.namespace == "System")
                value = SystemType(readString(data));
            else if(ti.name == "UnmanagedType" && ti.namespace == "System.Runtime.InteropServices")
                value = read!int(data);
            else if(ti.name == "CallingConvention" && ti.namespace == "System.Runtime.InteropServices")
                value = read!int(data);
            else
                throw new Exception(
                                    format("Type references (%s.%s) do not provide enough information to read enum values",
                                           ti.namespace, ti.name));
        }
        else if (auto ti = paramType.peek!TypeDef)
        {
            if (ti.name == "Type" && ti.namespace == "System")
                value = SystemType(readString(data));
            else if (ti.isEnum)                
                value = EnumDefinition(*ti, readEnumValue(ti.underlyingEnumType, data));
            else
                throw new Exception("Unsupported attribute type");
        }
        else
            throw new Exception("Type specs do not provide enough information to read enum values");
    }


    private Value readPrimitiveValue(ElementType e, ref const(ubyte)[] data)
    {
        switch (e)
        {
            case ElementType.boolean:
                return Value(read!bool(data));
            case ElementType.char_:
                return Value(read!wchar(data));
            case ElementType.i1:
                return Value(read!byte(data));
            case ElementType.u1:
                return Value(read!ubyte(data));
            case ElementType.i2:
                return Value(read!short(data));
            case ElementType.u2:
                return Value(read!ushort(data));
            case ElementType.i4:
                return Value(read!int(data));
            case ElementType.u4:
                return Value(read!uint(data));
            case ElementType.i8:
                return Value(read!long(data));
            case ElementType.u8:
                return Value(read!ulong(data));
            case ElementType.r4:
                return Value(read!float(data));
            case ElementType.r8:
                return Value(read!double(data));
            case ElementType.string:
                return Value(readString(data));
            default:
                throw new Exception("Expecting primitive value");
        }
        assert(0);
    }

    private EnumDefinition.Value readEnumValue(ElementType e, ref const(ubyte)[] data)
    {
        switch (e)
        {
            case ElementType.boolean:
                return EnumDefinition.Value(read!bool(data));
            case ElementType.char_:
                return EnumDefinition.Value(read!wchar(data));
            case ElementType.i1:
                return EnumDefinition.Value(read!byte(data));
            case ElementType.u1:
                return EnumDefinition.Value(read!ubyte(data));
            case ElementType.i2:
                return EnumDefinition.Value(read!short(data));
            case ElementType.u2:
                return EnumDefinition.Value(read!ushort(data));
            case ElementType.i4:
                return EnumDefinition.Value(read!int(data));
            case ElementType.u4:
                return EnumDefinition.Value(read!uint(data));
            case ElementType.i8:
                return EnumDefinition.Value(read!long(data));
            case ElementType.u8:
                return EnumDefinition.Value(read!ulong(data));        
            default:
                throw new Exception("Non primitive types are not supported");
        }
    }
    Value value;
}

struct FixedArgSig
{
    alias Value = Algebraic!(ElementSig, ElementSig[]);

    private this(const(Metadata)* db, const ref TypeSig typeSig, ref const(ubyte)[] data)
    {
        if (typeSig.isSZArray)
        {
            ElementSig[] elements;
            auto count = read!uint(data);
            if (count != uint.max)
            {
                enforce(count <= data.length, "Invalid blob size for array");
                elements.length = count;
                for(uint i = 0; i < count; ++i)
                    elements[i] = ElementSig(db, typeSig.type, data);                
            }
            value = elements;
        }
        else
            value = ElementSig(db, typeSig.type, data);        
    }

    private this(ElementType type, bool isArray, ref const(ubyte)[] data)
    {

        if (isArray)
        {
            ElementSig[] elements;
            auto count = read!uint(data);
            if (count != uint.max)
            {
                enforce(count <= data.length, "Invalid blob size for array");
                elements.length = count;
                for(uint i = 0; i < count; ++i)
                    elements[i] = ElementSig(type, data);                
            }
            value = elements;
        }
        else
            value = ElementSig(type, data);        
    }

    private this(SystemType type)
    {
        value = ElementSig(type);
    }

    private this(const ref TypeDef type, ref const(ubyte)[] data)
    {
        value = ElementSig(type, data);
    }

    Value value;
}

struct NamedArgSig
{
    private this(const(Metadata)* db, ref const(ubyte)[] data)
    {
        auto e = read!ElementType(data);
        enforce(e == ElementType.field || e == ElementType.property, 
                "Only fields or properties can be passed as named arguments");
        e = read!ElementType(data);
        switch(e)
        {
            case ElementType.type:
                name = readString(data);
                value = FixedArgSig(SystemType(readString(data)));
                break;
            case ElementType.enum_:
                auto type = readString(data);
                name = readString(data);  
                auto def = db.findByName(type);
                if (def.isNull && type == "System.Runtime.InteropServices.UnmanagedType")
                    value = FixedArgSig(ElementType.i4, false, data);
                else
                {
                    enforce(!def.isNull, format("Unknown enum type (%s) for named parameter %s", type, name));
                    enforce(def.get.isEnum, "Only enum type can be used as named parameters");
                    value = FixedArgSig(def.get, data);
                }
                break;
            default:
                bool isArray = e == ElementType.szArray;
                if (isArray)                
                    e = read!ElementType(data);
                enforce (e >= ElementType.boolean && e <= ElementType.string, "Invalid data type for named parameter");
                name = readString(data);
                value = FixedArgSig(e, isArray, data);
                break;
        }
    }

    string name;
    FixedArgSig value;
}

struct CustomAttributeSig
{
    private this(const(Metadata)* db, ref const(ubyte)[] data, MethodDefSig ctor)
    {     
        enforce(asVal!ushort(data) == 0x0001, "Invalid prolog for custom attribute");
        data = data[2 .. $];    
        fixed.length = ctor.params.length;
        for(size_t i = 0; i < fixed.length; ++i)
            fixed[i] = FixedArgSig(db, ctor.params[i].typeSig, data);
        named.length = read!ushort(data);
        for(size_t i = 0; i < named.length; ++i)
            named[i] = NamedArgSig(db, data);
    }    

    FixedArgSig[] fixed;
    NamedArgSig[] named;
}

struct FieldMarshalSig
{
    private this(ref const(ubyte)[] data)
    {     
        isArray = readCompressedCond!NativeType(data, NativeType.array);
        elementType = readCompressed!NativeType(data);
        if (data.length)
            paramNum = readCompressed!uint(data);
        if (data.length)
            arrayRank = readCompressed!uint(data);
    }

    bool isArray;
    uint paramNum;
    uint arrayRank;
    NativeType elementType;
    GenericTypeInstSig genSig;
    MethodDefSig methodSig;
}

struct PermissionSig
{
    private this(const(Metadata)* db, ref const(ubyte)[] data)
    {     
        enforce(read!char(data) == '.', "Invalid permission signature");
        permissions.length = readCompressed!uint(data);
        for (size_t i = 0; i < permissions.length; ++i)
            permissions[i] = PermissionSetSig(db, data);
    }

    PermissionSetSig[] permissions;
}

struct PermissionSetSig
{
    private this(const(Metadata)* db, ref const(ubyte)[] data)
    {           
        name = readString(data);
        arguments.length = read!ushort(data);
        for(size_t i = 0; i < arguments.length; ++i)
            arguments[i] = NamedArgSig(db, data);
    }    

    string name;
    NamedArgSig[] arguments;
}



enum ElementType : ubyte
{
    end             = 0x00, 
    void_           = 0x01,
    boolean         = 0x02,
    char_           = 0x03,
    i1              = 0x04,
    u1              = 0x05,
    i2              = 0x06,
    u2              = 0x07,
    i4              = 0x08,
    u4              = 0x09,
    i8              = 0x0a,
    u8              = 0x0b,
    r4              = 0x0c,
    r8              = 0x0d,
    string          = 0x0e,
    ptr             = 0x0f, 
    byRef           = 0x10, 
    valueType       = 0x11, 
    class_          = 0x12, 
    var             = 0x13, 
    array           = 0x14,
    genericInst     = 0x15,
    typedByRef      = 0x16,
    i               = 0x18, 
    u               = 0x19, 
    fnPtr           = 0x1b, 
    object          = 0x1c, 
    szArray         = 0x1d,
    mVar            = 0x1e, 
    cModReqd        = 0x1f, 
    cModOpt         = 0x20, 
    internal        = 0x21,
    modifier        = 0x40, 
    sentinel        = 0x41, 
    pinned          = 0x45,
    type            = 0x50, 
    taggedObject    = 0x51, 
    field           = 0x53, 
    property        = 0x54, 
    enum_           = 0x55, 
}

enum CallingConvention : ubyte
{
    default_         = 0x00,
    varArg          = 0x05,
    field           = 0x06,
    localSig        = 0x07,
    property        = 0x08,
    genericInst     = 0x10,
    mask            = 0x0f,
    hasThis         = 0x20,
    explicitThis    = 0x40,
    generic         = 0x10,
}

enum NativeType : ubyte
{
    boolean         = 0x02,
    i1              = 0x03,
    u1              = 0x04,
    i2              = 0x05,
    u2              = 0x06,
    i4              = 0x07,
    u4              = 0x08,
    i8              = 0x09,
    u8              = 0x0a,
    r4              = 0x0b,
    r8              = 0x0c,
    lpstr           = 0x14,
    lpwstr          = 0x15,
    i               = 0x1f,
    u               = 0x20,
    func            = 0x26,
    array           = 0x2a,
    max_            = 0xff,             
}

enum UnmanagedType
{
    bool_ = 2,
    i1 = 3,
    u1 = 4,
    i2 = 5,
    u2 = 6,
    I4 = 7,
    u4 = 8,
    i8 = 9,
    u8 = 10,
    r4 = 11,
    r8 = 12,
    currency = 15,
    bStr = 19,
    lpStr = 20, 
    lpwStr = 21, 
    lptStr = 22,
    byValTStr = 23,
    iUnknown = 25, 
    iDispatch = 26, 
    struct_ = 27,
    interface_ = 28,
    safeArray = 29, 
    byValArray = 30,
    sysInt = 31,
    sysUInt = 32,
    vbByRefStr = 34,
    ansiBStr = 35,
    tBStr = 36, 
    variantBool = 37, 
    functionPtr = 38, 
    asAny = 40, 
    lpArray = 42, 
    lpStruct = 43, 
    customMarshaler = 44, 
    error = 45,
    iInspectable = 46, 
    hString = 47,
    lpUTF8Str = 48, 
}


private bool sectionFromRVA(const(ImageSectionHeader)[] sections, uint rva, ref ImageSectionHeader section)
{
    for (size_t i; i < sections.length; ++i)
    {
        if (sections[i].virtualAddress <= rva && sections[i].virtualAddress + sections[i].virtualSize > rva)
        {
            section = sections[i];
            return true;
        }
    }
    return false;    
}

private uint offsetFromRVA(ref const ImageSectionHeader section, uint rva)
{
    return rva - section.virtualAddress + section.pointerToRawData;
}

private struct StreamRange
{
    uint offset;
    uint size;
};

private MD getMDfromIndex(ubyte index)
{
    switch (index)
    {
        case 0x00: return MD.module_;
        case 0x01: return MD.typeRef;
        case 0x02: return MD.typeDef;
        case 0x04: return MD.field;
        case 0x06: return MD.methodDef;
        case 0x08: return MD.param;
        case 0x09: return MD.interfaceImpl;
        case 0x0a: return MD.memberRef;
        case 0x0b: return MD.constant;
        case 0x0c: return MD.customAttribute;
        case 0x0d: return MD.fieldMarshal;
        case 0x0e: return MD.declSecurity;
        case 0x0f: return MD.classLayout;
        case 0x10: return MD.fieldLayout;
        case 0x11: return MD.standAloneSig;
        case 0x12: return MD.eventMap;
        case 0x14: return MD.event;
        case 0x15: return MD.propertyMap;
        case 0x17: return MD.property;
        case 0x18: return MD.methodSemantics;
        case 0x19: return MD.methodImpl;
        case 0x1a: return MD.moduleRef;
        case 0x1b: return MD.typeSpec;
        case 0x1c: return MD.implMap;
        case 0x1d: return MD.fieldRVA;
        case 0x20: return MD.assembly;
        case 0x21: return MD.assemblyProcessor;
        case 0x22: return MD.assemblyOS;
        case 0x23: return MD.assemblyRef;
        case 0x24: return MD.assemblyRefProcessor;
        case 0x25: return MD.assemblyRefOS;
        case 0x26: return MD.file;
        case 0x27: return MD.exportedType;
        case 0x28: return MD.manifestResource;
        case 0x29: return MD.nestedClass;
        case 0x2a: return MD.genericParam;
        case 0x2b: return MD.methodSpec;
        case 0x2c: return MD.genericParamConstraint;
        default: return MD.unknown;
    }
}

private ubyte bitsNeeded(R...)(R rowCounts)
{
    static if (R.length == 1)
    {
        auto rc = rowCounts[0];
        if (!rc)
            return 0;
        ubyte r = 1;
        --rc;
        while (rc >>= 1)
            ++r;
        return r;
    }
    else 
    {
        auto t1 = bitsNeeded(rowCounts[0]);
        auto t2 = bitsNeeded(rowCounts[1 .. $]);
        return t1 > t2 ? t1 : t2;
    }
}

private ubyte compositeIndexSize(R...)(R rowCounts)
{
    return (bitsNeeded(rowCounts) + bitsNeeded(R.length) <= 16) ? 2 : 4;
}


private ubyte indexSize(uint rowCount)
{
    return rowCount <= 0xffff ? 2 : 4;
}


private T peekCompressed(T = uint)(const(ubyte)[] data)
{
    if ((data[0] & 0x80) == 0x00)
        return cast(T)(data[0]);
    else if ((data[0] & 0xc0) == 0x80)
        return cast(T)(((data[0] & 0x3f) << 8) | data[1]);
    else if ((data[0] & 0xe0) == 0xc0)
    {
        return cast(T) (((data[0] & 0x3f) << 24) 
                        | (data[1] << 16)
                        | (data[2] << 8)
                        | (data[3]));
    }
    enforce(false, "Invalid compressed encoding");
    assert(0);
}

private T readCompressed(T = uint)(ref const(ubyte)[] data)
{
    static assert(T.sizeof <= uint.sizeof);

    uint r;
    size_t len;

    if ((data[0] & 0x80) == 0x00)
    {
        len = 1;
        r = data[0];
    }
    else if ((data[0] & 0xc0) == 0x80)
    {
        len = 2;
        r = ((data[0] & 0x3f) << 8) | data[1];
    }
    else if ((data[0] & 0xe0) == 0xc0)
    {
        len = 4;
        r = ((data[0] & 0x3f) << 24) 
            | (data[1] << 16)
            | (data[2] << 8)
            | (data[3]);
    }

    enforce(len, "Invalid compressed encoding");

    data = data[len .. $];
    return cast(T)r;
}

private bool readCompressedCond(T)(ref const(ubyte)[] data, T condVal)
{
    if (peekCompressed!T(data) == condVal)
    {
        readCompressed!T(data);
        return true;
    }
    return false;
}

private T read(T)(ref const(ubyte)[] data)
{
    auto value = asVal!T(data);
    data = data[T.sizeof .. $];
    return value;
}

private string readString(ref const(ubyte)[] data)
{
    auto len = readCompressed(data);    
    string r = (cast(immutable(char)*)(data.ptr))[0 .. len];
    data = data[len .. $];
    return r;
}

private string asString(const(ubyte)[] mem, size_t offset = 0)
{
    size_t zero = 0;
    auto p = mem.ptr + offset;
    while (p[zero])
        ++zero;
    return (cast(immutable(char)*)(p))[0 .. zero];
}

private const(T)[] asArray(T)(const(ubyte)[] mem, size_t offset = 0)
{
    return (cast(const(T)*)(mem.ptr + offset))[0 .. mem.length / T.sizeof];
}

private ref const(T) asRef(T)(const(ubyte)[] mem, size_t offset = 0)
{
    return *cast(const(T)*)mem.ptr[offset .. offset + T.sizeof];
}

private T asVal(T)(const(ubyte)[] mem, size_t offset = 0)
{
    return *cast(T*)mem.ptr[offset .. offset + T.sizeof];
}


version(Windows)
{
    private import core.sys.windows.winbase;
    private import core.sys.windows.winnt;
    private import std.utf;
}
else version(Posix)
{
    private import core.sys.posix.fcntl;
    private import core.sys.posix.sys.mman;
    private import core.sys.posix.sys.stat;
    private import core.sys.posix.unistd;
}

import std.exception;
private import std.format;

struct FileMap
{
private:
    version(Windows)
    {
        HANDLE fileHandle = INVALID_HANDLE_VALUE;
        HANDLE mapHandle = INVALID_HANDLE_VALUE;
    } 
    else version(Posix)
    {
        int fileDescriptor = -1;
    }

    const(ubyte)* m_memory;
    size_t m_size;

public:   
    this(string fileName)
    {
        version(Windows)
        {
            wstring wFileName = toUTF16(fileName);      
            fileHandle = CreateFileW(wFileName.ptr, GENERIC_READ, FILE_SHARE_READ, null, OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, null);
            enforce(fileHandle != INVALID_HANDLE_VALUE, format("Cannot open file '%s'", fileName));
            LARGE_INTEGER sz;
            GetFileSizeEx(fileHandle, &sz);
            m_size = cast(size_t)(sz.QuadPart);
            if (m_size > 0)
            {
                mapHandle = CreateFileMappingW(fileHandle, null, PAGE_READONLY, 0, 0, null);
                enforce(mapHandle != INVALID_HANDLE_VALUE, format("Cannot map file '%s' into memory", fileName));
                m_memory = cast(ubyte*)MapViewOfFileEx(mapHandle, FILE_MAP_READ, 0, 0, 0, null);
                enforce(m_memory, "Cannot read file ''%s'");
            }
        }
        else version(Posix)
        {
            fileDescriptor = .open(fileName.ptr, O_RDONLY, 0);
            enforce(fileHandle != -1, format("Cannot open file '%s'", fileName));
            stat_t stat;
            enforce(fstat(fd, &stat) >= 0, format("Cannot obtain file size for '%s'", fileName));
            m_size = cast(size_t)(stat.st_size);
            if (m_size > 0)
            {
                m_memory = mmap(null, size, PROT_READ, MAP_PRIVATE | MAP_POPULATE, fileDescriptor, 0);
                enforce(m_memory != MAP_FAILED, "Cannot read file ''%s'");
            }
        }
    }

    ~this()
    {
        version(Windows)
        {
            if (m_memory)
            {
                UnmapViewOfFile(m_memory);
                m_memory = null;
            }
            if (mapHandle != INVALID_HANDLE_VALUE)
            {
                CloseHandle(mapHandle);
                mapHandle = INVALID_HANDLE_VALUE;
            }
            if (fileHandle != INVALID_HANDLE_VALUE)
            {
                CloseHandle(fileHandle);
                fileHandle = INVALID_HANDLE_VALUE;
            }
        } 
        else version(Posix)
        {
            if (m_memory)
                munmap(memory, size);
            if (fileDescriptor != -1)
                .close(fileDescriptor);
        }
    }

    const(ubyte)[] memory() const
    {
        return m_memory[0 .. m_size];
    }

    size_t size() const
    {
        return cast(size_t)m_size;
    }
}


private struct CompositeIndex(T)
{
    private uint codedIndex;

    this(uint codedIndex)
    {
        this.codedIndex = codedIndex;
    }

    this(uint decodedIndex, T value)
    {        
        this.codedIndex = (decodedIndex << indexBits!T) | value;
    }

    uint index()
    {
        return codedIndex >> indexBits!T;
    }

    T type()
    {
        return cast(T)(codedIndex & ((1 << indexBits!T) - 1));
    }
}

private template indexBits(T)
{
    enum indexBits = getUDAs!(T, Bits)[0].value;
}

private struct Bits
{
    int value;
}

@Bits(2)
enum TypeDefOrRef
{
    typeDef,
    typeRef,
    typeSpec,
}

@Bits(2)
enum HasConstant
{
    field,
    param,
    property,
}

@Bits(5)
enum HasCustomAttribute
{
    methodDef,
    field,
    typeRef,
    typeDef,
    param,
    interfaceImpl,
    memberRef,
    module_,
    permission,
    property,
    event,
    standAloneSig,
    moduleRef,
    typeSpec,
    assembly,
    assemblyRef,
    file,
    exportedType,
    manifestResource,
    genericParam,
    genericParamConstraint,
    methodSpec,
}

@Bits(1)
enum HasFieldMarshal
{
    field,
    param,
}

@Bits(2)
enum  HasDeclSecurity
{
    typeDef,
    methodDef,
    assembly,
}

@Bits(3)
enum MemberRefParent
{
    typeDef,
    typeRef,
    moduleRef,
    methodDef,
    typeSpec,
}

@Bits(1)
enum HasSemantics
{
    event,
    property,
}

@Bits(1)
enum MethodDefOrRef
{
    methodDef,
    memberRef,
}

@Bits(1)
enum MemberForwarded
{
    field,
    methodDef,
}

@Bits(2)
enum Implementation 
{
    file,
    assemblyRef,
    exportedType,
}

@Bits(3)
enum CustomAttributeType
{
    methodDef = 2,
    memberRef,
}

@Bits(2)
enum ResolutionScope 
{
    module_,
    moduleRef,
    assemblyRef,
    typeRef,
}


@Bits(1)
enum TypeOrMethodDef
{
    typeDef,
    methodDef,
}


struct ImageDosHeader
{
    ushort      e_signature;
    ushort      e_cblp;
    ushort      e_cp;
    ushort      e_crlc;
    ushort      e_cparhdr;
    ushort      e_minalloc;
    ushort      e_maxalloc;
    ushort      e_ss;
    ushort      e_sp;
    ushort      e_csum;
    ushort      e_ip;
    ushort      e_cs;
    ushort      e_lfarlc;
    ushort      e_ovno;
    ushort[4]   e_res;
    ushort      e_oemid;
    ushort      e_oeminfo;
    ushort[10]  e_res2;
    int         e_lfanew;
}

struct ImageFileHeader
{
    ushort  machine;
    ushort  numberOfSections;
    uint    timeDateStamp;
    uint    pointerToSymbolTable;
    uint    numberOfSymbols;
    ushort  sizeOfOptionalHeader;
    ushort  characteristics;
}

struct ImageDataDirectory
{
    uint virtualAddress;
    uint size;
}

struct ImageOptionalHeader32
{
    ushort                  magic;
    ubyte                   majorLinkerVersion;
    ubyte                   minorLinkerVersion;
    uint                    sizeOfCode;
    uint                    sizeOfInitializedData;
    uint                    sizeOfUninitializedData;
    uint                    addressOfEntryPoint;
    uint                    baseOfCode;
    uint                    baseOfData;
    uint                    imageBase;
    uint                    sectionAlignment;
    uint                    fileAlignment;
    ushort                  majorOperatingSystemVersion;
    ushort                  minorOperatingSystemVersion;
    ushort                  majorImageVersion;
    ushort                  minorImageVersion;
    ushort                  majorSubsystemVersion;
    ushort                  minorSubsystemVersion;
    uint                    win32VersionValue;
    uint                    sizeOfImage;
    uint                    sizeOfHeaders;
    uint                    checkSum;
    ushort                  subsystem;
    ushort                  dllCharacteristics;
    uint                    sizeOfStackReserve;
    uint                    sizeOfStackCommit;
    uint                    sizeOfHeapReserve;
    uint                    sizeOfHeapCommit;
    uint                    loaderFlags;
    uint                    numberOfRvaAndSizes;
    ImageDataDirectory[16]  dataDirectory;
}

struct ImageNTHeaders32
{
    uint                    signature;
    ImageFileHeader         fileHeader;
    ImageOptionalHeader32   optionalHeader;
}

struct ImageOptionalHeader32Plus
{
    ushort                  magic;
    ubyte                   majorLinkerVersion;
    ubyte                   minorLinkerVersion;
    uint                    sizeOfCode;
    uint                    sizeOfInitializedData;
    uint                    sizeOfUninitializedData;
    uint                    addressOfEntryPoint;
    uint                    baseOfCode;
    ulong                   imageBase;
    uint                    sectionAlignment;
    uint                    fileAlignment;
    ushort                  majorOperatingSystemVersion;
    ushort                  minorOperatingSystemVersion;
    ushort                  majorImageVersion;
    ushort                  minorImageVersion;
    ushort                  majorSubsystemVersion;
    ushort                  minorSubsystemVersion;
    uint                    win32VersionValue;
    uint                    sizeOfImage;
    uint                    sizeOfHeaders;
    uint                    checkSum;
    ushort                  subsystem;
    ushort                  dllCharacteristics;
    ulong                   sizeOfStackReserve;
    ulong                   sizeOfStackCommit;
    ulong                   sizeOfHeapReserve;
    ulong                   sizeOfHeapCommit;
    uint                    loaderFlags;
    uint                    numberOfRvaAndSizes;
    ImageDataDirectory[16]  dataDirectory;
}

struct ImageNTHeaders32Plus
{
    uint                        signature;
    ImageFileHeader             fileHeader;
    ImageOptionalHeader32Plus   optionalHeader;
}

struct ImageSectionHeader 
{
    ubyte[8]    name;
    union
    {
        uint    physicalAddress;
        uint    virtualSize;
    }
    uint        virtualAddress;
    uint        sizeOfRawData;
    uint        pointerToRawData;
    uint        pointerToRelocations;
    uint        pointerToLinenumbers;
    ushort      numberOfRelocations;
    ushort      numberOfLinenumbers;
    uint        characteristics;
}

struct ImageCor20Header
{
    uint                cb;
    ushort              majorRuntimeVersion;
    ushort              minorRuntimeVersion;
    ImageDataDirectory  metaData;
    uint                flags;
    union
    {
        uint            entryPointToken;
        uint            entryPointRVA;
    }
    ImageDataDirectory  resources;
    ImageDataDirectory  strongNameSignature;
    ImageDataDirectory  codeManagerTable;
    ImageDataDirectory  vTableFixups;
    ImageDataDirectory  exportAddressTableJumps;
    ImageDataDirectory  managedNativeHeader;
}