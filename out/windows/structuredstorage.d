// Written in the D programming language.

module windows.structuredstorage;

public import windows.core;
public import windows.automation : BSTR, IDispatch, SAFEARRAY;
public import windows.com : DVTARGETDEVICE, HRESULT, IBindStatusCallback, IUnknown,
                            OLESTREAM, STGMEDIUM;
public import windows.shell : SERIALIZEDPROPERTYVALUE;
public import windows.systemservices : BOOL, BSTRBLOB, CLIPDATA, CY, DECIMAL,
                                       LARGE_INTEGER, PSTR, PWSTR, ULARGE_INTEGER;
public import windows.winsock : BLOB;
public import windows.windowsandmessaging : HWND;
public import windows.windowsprogramming : FILETIME;

extern(Windows) @nogc nothrow:


// Enums


///The <b>STGC</b> enumeration constants specify the conditions for performing the commit operation in the
///IStorage::Commit and IStream::Commit methods.
alias STGC = int;
enum : int
{
    ///You can specify this condition with <b>STGC_CONSOLIDATE</b>, or some combination of the other three flags in this
    ///list of elements. Use this value to increase the readability of code.
    STGC_DEFAULT                            = 0x00000000,
    ///The commit operation can overwrite existing data to reduce overall space requirements. This value is not
    ///recommended for typical usage because it is not as robust as the default value. In this case, it is possible for
    ///the commit operation to fail after the old data is overwritten, but before the new data is completely committed.
    ///Then, neither the old version nor the new version of the storage object will be intact. You can use this value in
    ///the following cases: <ul> <li>The user is willing to risk losing the data.</li> <li>The low-memory save sequence
    ///will be used to safely save the storage object to a smaller file.</li> <li>A previous commit returned
    ///<b>STG_E_MEDIUMFULL</b>, but overwriting the existing data would provide enough space to commit changes to the
    ///storage object.</li> </ul> Be aware that the commit operation verifies that adequate space exists before any
    ///overwriting occurs. Thus, even with this value specified, if the commit operation fails due to space
    ///requirements, the old data is safe. It is possible, however, for data loss to occur with the
    ///<b>STGC_OVERWRITE</b> value specified if the commit operation fails for any reason other than lack of disk space.
    STGC_OVERWRITE                          = 0x00000001,
    ///Prevents multiple users of a storage object from overwriting each other's changes. The commit operation occurs
    ///only if there have been no changes to the saved storage object because the user most recently opened it. Thus,
    ///the saved version of the storage object is the same version that the user has been editing. If other users have
    ///changed the storage object, the commit operation fails and returns the STG_E_NOTCURRENT value. To override this
    ///behavior, call the IStorage::Commit or IStream::Commit method again using the <b>STGC_DEFAULT</b> value.
    STGC_ONLYIFCURRENT                      = 0x00000002,
    ///Commits the changes to a write-behind disk cache, but does not save the cache to the disk. In a write-behind disk
    ///cache, the operation that writes to disk actually writes to a disk cache, thus increasing performance. The cache
    ///is eventually written to the disk, but usually not until after the write operation has already returned. The
    ///performance increase comes at the expense of an increased risk of losing data if a problem occurs before the
    ///cache is saved and the data in the cache is lost. If you do not specify this value, then committing changes to
    ///root-level storage objects is robust even if a disk cache is used. The two-phase commit process ensures that data
    ///is stored on the disk and not just to the disk cache.
    STGC_DANGEROUSLYCOMMITMERELYTODISKCACHE = 0x00000004,
    ///Windows 2000 and Windows XP: Indicates that a storage should be consolidated after it is committed, resulting in
    ///a smaller file on disk. This flag is valid only on the outermost storage object that has been opened in
    ///transacted mode. It is not valid for streams. The <b>STGC_CONSOLIDATE</b> flag can be combined with any other
    ///STGC flags.
    STGC_CONSOLIDATE                        = 0x00000008,
}

///The <b>STGMOVE</b> enumeration values indicate whether a storage element is to be moved or copied. They are used in
///the IStorage::MoveElementTo method.
alias STGMOVE = int;
enum : int
{
    ///Indicates that the method should move the data from the source to the destination.
    STGMOVE_MOVE        = 0x00000000,
    ///Indicates that the method should copy the data from the source to the destination. A copy is the same as a move
    ///except that the source element is not removed after copying the element to the destination. Copying an element on
    ///top of itself is undefined.
    STGMOVE_COPY        = 0x00000001,
    ///Not implemented.
    STGMOVE_SHALLOWCOPY = 0x00000002,
}

///The <b>STATFLAG</b> enumeration values indicate whether the method should try to return a name in the <b>pwcsName</b>
///member of the STATSTG structure. The values are used in the ILockBytes::Stat, IStorage::Stat, and IStream::Stat
///methods to save memory when the <b>pwcsName</b> member is not required.
alias STATFLAG = int;
enum : int
{
    ///Requests that the statistics include the <b>pwcsName</b> member of the STATSTG structure.
    STATFLAG_DEFAULT = 0x00000000,
    ///Requests that the statistics not include the <b>pwcsName</b> member of the STATSTG structure. If the name is
    ///omitted, there is no need for the ILockBytes::Stat, IStorage::Stat, and IStream::Stat methods methods to allocate
    ///and free memory for the string value of the name, therefore the method reduces time and resources used in an
    ///allocation and free operation.
    STATFLAG_NONAME  = 0x00000001,
    ///Not implemented.
    STATFLAG_NOOPEN  = 0x00000002,
}

alias PIDMSI_STATUS_VALUE = int;
enum : int
{
    PIDMSI_STATUS_NORMAL     = 0x00000000,
    PIDMSI_STATUS_NEW        = 0x00000001,
    PIDMSI_STATUS_PRELIM     = 0x00000002,
    PIDMSI_STATUS_DRAFT      = 0x00000003,
    PIDMSI_STATUS_INPROGRESS = 0x00000004,
    PIDMSI_STATUS_EDIT       = 0x00000005,
    PIDMSI_STATUS_REVIEW     = 0x00000006,
    PIDMSI_STATUS_PROOF      = 0x00000007,
    PIDMSI_STATUS_FINAL      = 0x00000008,
    PIDMSI_STATUS_OTHER      = 0x00007fff,
}

alias JET_RELOP = int;
enum : int
{
    JET_relopEquals               = 0x00000000,
    JET_relopPrefixEquals         = 0x00000001,
    JET_relopNotEquals            = 0x00000002,
    JET_relopLessThanOrEqual      = 0x00000003,
    JET_relopLessThan             = 0x00000004,
    JET_relopGreaterThanOrEqual   = 0x00000005,
    JET_relopGreaterThan          = 0x00000006,
    JET_relopBitmaskEqualsZero    = 0x00000007,
    JET_relopBitmaskNotEqualsZero = 0x00000008,
}

alias JET_ERRCAT = int;
enum : int
{
    JET_errcatUnknown       = 0x00000000,
    JET_errcatError         = 0x00000001,
    JET_errcatOperation     = 0x00000002,
    JET_errcatFatal         = 0x00000003,
    JET_errcatIO            = 0x00000004,
    JET_errcatResource      = 0x00000005,
    JET_errcatMemory        = 0x00000006,
    JET_errcatQuota         = 0x00000007,
    JET_errcatDisk          = 0x00000008,
    JET_errcatData          = 0x00000009,
    JET_errcatCorruption    = 0x0000000a,
    JET_errcatInconsistent  = 0x0000000b,
    JET_errcatFragmentation = 0x0000000c,
    JET_errcatApi           = 0x0000000d,
    JET_errcatUsage         = 0x0000000e,
    JET_errcatState         = 0x0000000f,
    JET_errcatObsolete      = 0x00000010,
    JET_errcatMax           = 0x00000011,
}

alias JET_INDEXCHECKING = int;
enum : int
{
    JET_IndexCheckingOff              = 0x00000000,
    JET_IndexCheckingOn               = 0x00000001,
    JET_IndexCheckingDeferToOpenTable = 0x00000002,
    JET_IndexCheckingMax              = 0x00000003,
}

///The <b>STGTY</b> enumeration values are used in the <b>type</b> member of the STATSTG structure to indicate the type
///of the storage element. A storage element is a storage object, a stream object, or a byte-array object (LOCKBYTES).
alias STGTY = int;
enum : int
{
    ///Indicates that the storage element is a storage object.
    STGTY_STORAGE   = 0x00000001,
    ///Indicates that the storage element is a stream object.
    STGTY_STREAM    = 0x00000002,
    ///Indicates that the storage element is a byte-array object.
    STGTY_LOCKBYTES = 0x00000003,
    ///Indicates that the storage element is a property storage object.
    STGTY_PROPERTY  = 0x00000004,
}

///The <b>STREAM_SEEK</b> enumeration values specify the origin from which to calculate the new seek-pointer location.
///They are used for the <i>dworigin</i> parameter in the IStream::Seek method. The new seek position is calculated
///using this value and the <i>dlibMove</i> parameter.
alias STREAM_SEEK = uint;
enum : uint
{
    ///The new seek pointer is an offset relative to the beginning of the stream. In this case, the <i>dlibMove</i>
    ///parameter is the new seek position relative to the beginning of the stream.
    STREAM_SEEK_SET = 0x00000000,
    ///The new seek pointer is an offset relative to the current seek pointer location. In this case, the
    ///<i>dlibMove</i> parameter is the signed displacement from the current seek position.
    STREAM_SEEK_CUR = 0x00000001,
    ///The new seek pointer is an offset relative to the end of the stream. In this case, the <i>dlibMove</i> parameter
    ///is the new seek position relative to the end of the stream.
    STREAM_SEEK_END = 0x00000002,
}

///The <b>LOCKTYPE</b> enumeration values indicate the type of locking requested for the specified range of bytes. The
///values are used in the ILockBytes::LockRegion and IStream::LockRegion methods.
alias LOCKTYPE = int;
enum : int
{
    ///If this lock is granted, the specified range of bytes can be opened and read any number of times, but writing to
    ///the locked range is prohibited except for the owner that was granted this lock.
    LOCK_WRITE     = 0x00000001,
    ///If this lock is granted, writing to the specified range of bytes is prohibited except by the owner that was
    ///granted this lock.
    LOCK_EXCLUSIVE = 0x00000002,
    LOCK_ONLYONCE  = 0x00000004,
}

// Callbacks

alias JET_PFNSTATUS = int function(uint sesid, uint snp, uint snt, void* pv);
alias JET_CALLBACK = int function(uint sesid, uint dbid, uint tableid, uint cbtyp, void* pvArg1, void* pvArg2, 
                                  void* pvContext, uint ulUnused);
alias JET_PFNDURABLECOMMITCALLBACK = int function(uint instance, JET_COMMIT_ID* pCommitIdSeen, uint grbit);
alias JET_PFNREALLOC = void* function(void* pvContext, void* pv, uint cb);

// Structs


struct VERSIONEDSTREAM
{
    GUID    guidVersion;
    IStream pStream;
}

struct CAC
{
    uint  cElems;
    byte* pElems;
}

struct CAUB
{
    uint   cElems;
    ubyte* pElems;
}

struct CAI
{
    uint   cElems;
    short* pElems;
}

struct CAUI
{
    uint    cElems;
    ushort* pElems;
}

struct CAL
{
    uint cElems;
    int* pElems;
}

struct CAUL
{
    uint  cElems;
    uint* pElems;
}

struct CAFLT
{
    uint   cElems;
    float* pElems;
}

struct CADBL
{
    uint    cElems;
    double* pElems;
}

struct CACY
{
    uint cElems;
    CY*  pElems;
}

struct CADATE
{
    uint    cElems;
    double* pElems;
}

struct CABSTR
{
    uint  cElems;
    BSTR* pElems;
}

struct CABSTRBLOB
{
    uint      cElems;
    BSTRBLOB* pElems;
}

struct CABOOL
{
    uint   cElems;
    short* pElems;
}

struct CASCODE
{
    uint cElems;
    int* pElems;
}

struct CAPROPVARIANT
{
    uint         cElems;
    PROPVARIANT* pElems;
}

struct CAH
{
    uint           cElems;
    LARGE_INTEGER* pElems;
}

struct CAUH
{
    uint            cElems;
    ULARGE_INTEGER* pElems;
}

struct CALPSTR
{
    uint  cElems;
    PSTR* pElems;
}

struct CALPWSTR
{
    uint   cElems;
    PWSTR* pElems;
}

struct CAFILETIME
{
    uint      cElems;
    FILETIME* pElems;
}

struct CACLIPDATA
{
    uint      cElems;
    CLIPDATA* pElems;
}

struct CACLSID
{
    uint  cElems;
    GUID* pElems;
}

///The <b>PROPVARIANT</b> structure is used in the ReadMultiple and WriteMultiple methods of IPropertyStorage to define
///the type tag and the value of a property in a property set. The <b>PROPVARIANT</b> structure is also used by the
///GetValue and SetValue methods of IPropertyStore, which replaces IPropertySetStorage as the primary way to program
///item properties in Windows Vista. For more information, see Property Handlers. There are five members. The first
///member, the value-type tag, and the last member, the value of the property, are significant. The middle three members
///are reserved for future use. <div class="alert"><b>Note</b> The <b>bool</b> member in previous definitions of this
///structure has been renamed to <b>boolVal</b>, because some compilers now recognize <b>bool</b> as a
///keyword.</div><div> </div><div class="alert"><b>Note</b> The <b>PROPVARIANT</b> structure, defined below, includes
///types that can be serialized in the version 1 property set serialization format. The version 1 format supports all
///types allowed in the version 0 format plus some additional types. The added types include "Version 1" in the comment
///field below. Use these types only if a version 1 property set is intended. For more information, see Property Set
///Serialization.</div><div> </div>The <b>PROPVARIANT</b> structure is defined as follows:
struct PROPVARIANT
{
union
    {
struct
        {
            ushort vt;
            ushort wReserved1;
            ushort wReserved2;
            ushort wReserved3;
union
            {
                byte             cVal;
                ubyte            bVal;
                short            iVal;
                ushort           uiVal;
                int              lVal;
                uint             ulVal;
                int              intVal;
                uint             uintVal;
                LARGE_INTEGER    hVal;
                ULARGE_INTEGER   uhVal;
                float            fltVal;
                double           dblVal;
                short            boolVal;
                short            __OBSOLETE__VARIANT_BOOL;
                int              scode;
                CY               cyVal;
                double           date;
                FILETIME         filetime;
                GUID*            puuid;
                CLIPDATA*        pclipdata;
                BSTR             bstrVal;
                BSTRBLOB         bstrblobVal;
                BLOB             blob;
                PSTR             pszVal;
                PWSTR            pwszVal;
                IUnknown         punkVal;
                IDispatch        pdispVal;
                IStream          pStream;
                IStorage         pStorage;
                VERSIONEDSTREAM* pVersionedStream;
                SAFEARRAY*       parray;
                CAC              cac;
                CAUB             caub;
                CAI              cai;
                CAUI             caui;
                CAL              cal;
                CAUL             caul;
                CAH              cah;
                CAUH             cauh;
                CAFLT            caflt;
                CADBL            cadbl;
                CABOOL           cabool;
                CASCODE          cascode;
                CACY             cacy;
                CADATE           cadate;
                CAFILETIME       cafiletime;
                CACLSID          cauuid;
                CACLIPDATA       caclipdata;
                CABSTR           cabstr;
                CABSTRBLOB       cabstrblob;
                CALPSTR          calpstr;
                CALPWSTR         calpwstr;
                CAPROPVARIANT    capropvar;
                byte*            pcVal;
                ubyte*           pbVal;
                short*           piVal;
                ushort*          puiVal;
                int*             plVal;
                uint*            pulVal;
                int*             pintVal;
                uint*            puintVal;
                float*           pfltVal;
                double*          pdblVal;
                short*           pboolVal;
                DECIMAL*         pdecVal;
                int*             pscode;
                CY*              pcyVal;
                double*          pdate;
                BSTR*            pbstrVal;
                IUnknown*        ppunkVal;
                IDispatch*       ppdispVal;
                SAFEARRAY**      pparray;
                PROPVARIANT*     pvarVal;
            }
        }
        DECIMAL decVal;
    }
}

///The <b>PROPSPEC</b> structure is used by many of the methods of IPropertyStorage to specify a property either by its
///property identifier (ID) or the associated string name.
struct PROPSPEC
{
    ///Indicates the union member used. This member can be one of the following values. <table> <tr> <th>Name</th>
    ///<th>Meaning</th> </tr> <tr> <td width="40%"><a id="PRSPEC_LPWSTR"></a><a id="prspec_lpwstr"></a><dl>
    ///<dt><b>PRSPEC_LPWSTR</b></dt> <dt>Value: 0</dt> </dl> </td> <td width="60%"> The <b>lpwstr</b> member is used and
    ///set to a string name. </td> </tr> <tr> <td width="40%"><a id="PRSPEC_PROPID"></a><a id="prspec_propid"></a><dl>
    ///<dt><b>PRSPEC_PROPID</b></dt> <dt>Value: 1</dt> </dl> </td> <td width="60%"> The <b>propid</b> member is used and
    ///set to a property ID value. </td> </tr> </table>
    uint ulKind;
union
    {
        uint  propid;
        PWSTR lpwstr;
    }
}

///The <b>STATPROPSTG</b> structure contains data about a single property in a property set. This data is the property
///ID and type tag, and the optional string name that may be associated with the property. IPropertyStorage::Enum
///supplies a pointer to the IEnumSTATPROPSTG interface on an enumerator object that can be used to enumerate the
///<b>STATPROPSTG</b> structures for the properties in the current property set. <b>STATPROPSTG</b> is defined as:
struct STATPROPSTG
{
    ///A wide-character null-terminated Unicode string that contains the optional string name associated with the
    ///property. May be <b>NULL</b>. This member must be freed using CoTaskMemFree.
    PWSTR  lpwstrName;
    ///A 32-bit identifier that uniquely identifies the property within the property set. All properties within property
    ///sets must have unique property identifiers.
    uint   propid;
    ///The property type.
    ushort vt;
}

///The <b>STATPROPSETSTG</b> structure contains information about a property set. To get this information, call
///IPropertyStorage::Stat, which fills in a buffer containing the information describing the current property set. To
///enumerate the <b>STATPROPSETSTG</b> structures for the property sets in the current property-set storage, call
///IPropertySetStorage::Enum to get a pointer to an enumerator. You can then call the enumeration methods of the
///IEnumSTATPROPSETSTG interface on the enumerator. The structure is defined as follows:
struct STATPROPSETSTG
{
    ///FMTID of the current property set, specified when the property set was initially created.
    GUID     fmtid;
    ///<b>CLSID</b> associated with this property set, specified when the property set was initially created and
    ///possibly modified thereafter with IPropertyStorage::SetClass. If not set, the value will be <b>CLSID_NULL</b>.
    GUID     clsid;
    ///Flag values of the property set, as specified in IPropertySetStorage::Create.
    uint     grfFlags;
    ///Time in Universal Coordinated Time (UTC) when the property set was last modified.
    FILETIME mtime;
    ///Time in UTC when this property set was created.
    FILETIME ctime;
    ///Time in UTC when this property set was last accessed.
    FILETIME atime;
    uint     dwOSVersion;
}

///The <b>STGOPTIONS</b> structure specifies features of the storage object, such as sector size, in the
///StgCreateStorageEx and StgOpenStorageEx functions.
struct STGOPTIONS
{
    ///Specifies the version of the <b>STGOPTIONS</b> structure. It is set to <b>STGOPTIONS_VERSION</b>. <div
    ///class="alert"><b>Note</b> When <b>usVersion</b> is set to 1, the <b>ulSectorSize</b> member can be set. This is
    ///useful when creating a large-sector documentation file. However, when <b>usVersion</b> is set to 1, the
    ///<b>pwcsTemplateFile</b> member cannot be used.</div> <div> </div> <b>In Windows 2000 and later:
    ///</b><b>STGOPTIONS_VERSION</b> can be set to 1 for version 1. <b>In Windows XP and later:
    ///</b><b>STGOPTIONS_VERSION</b> can be set to 2 for version 2. <b>For operating systems prior to Windows 2000:
    ///</b><b>STGOPTIONS_VERSION</b> will be set to 0 for version 0.
    ushort       usVersion;
    ///Reserved for future use; must be zero.
    ushort       reserved;
    ///Specifies the sector size of the storage object. The default is 512 bytes.
    uint         ulSectorSize;
    ///Specifies the name of a file whose Encrypted File System (EFS) metadata will be transferred to a newly created
    ///Structured Storage file. This member is valid only when <b>STGFMT_DOCFILE</b> is used with StgCreateStorageEx.
    ///<b>In Windows XP and later: </b>The <b>pwcsTemplateFile</b> member is only valid if version 2 or later is
    ///specified in the <b>usVersion</b> member.
    const(PWSTR) pwcsTemplateFile;
}

struct PMemoryAllocator
{
}

struct JET_INDEXID
{
    uint      cbStruct;
    ubyte[12] rgbIndexId;
}

struct JET_RSTMAP_A
{
    byte* szDatabaseName;
    byte* szNewDatabaseName;
}

struct JET_RSTMAP_W
{
    PWSTR szDatabaseName;
    PWSTR szNewDatabaseName;
}

struct tagCONVERT_A
{
    byte* szOldDll;
union
    {
        uint fFlags;
struct
        {
            uint _bitfield105;
        }
    }
}

struct tagCONVERT_W
{
    PWSTR szOldDll;
union
    {
        uint fFlags;
struct
        {
            uint _bitfield106;
        }
    }
}

struct JET_SNPROG
{
    uint cbStruct;
    uint cunitDone;
    uint cunitTotal;
}

struct JET_DBINFOUPGRADE
{
    uint cbStruct;
    uint cbFilesizeLow;
    uint cbFilesizeHigh;
    uint cbFreeSpaceRequiredLow;
    uint cbFreeSpaceRequiredHigh;
    uint csecToUpgrade;
union
    {
        uint ulFlags;
struct
        {
            uint _bitfield107;
        }
    }
}

struct JET_OBJECTINFO
{
align (4):
    uint   cbStruct;
    uint   objtyp;
    double dtCreate;
    double dtUpdate;
    uint   grbit;
    uint   flags;
    uint   cRecord;
    uint   cPage;
}

struct JET_OBJECTLIST
{
    uint cbStruct;
    uint tableid;
    uint cRecord;
    uint columnidcontainername;
    uint columnidobjectname;
    uint columnidobjtyp;
    uint columniddtCreate;
    uint columniddtUpdate;
    uint columnidgrbit;
    uint columnidflags;
    uint columnidcRecord;
    uint columnidcPage;
}

struct JET_COLUMNLIST
{
    uint cbStruct;
    uint tableid;
    uint cRecord;
    uint columnidPresentationOrder;
    uint columnidcolumnname;
    uint columnidcolumnid;
    uint columnidcoltyp;
    uint columnidCountry;
    uint columnidLangid;
    uint columnidCp;
    uint columnidCollate;
    uint columnidcbMax;
    uint columnidgrbit;
    uint columnidDefault;
    uint columnidBaseTableName;
    uint columnidBaseColumnName;
    uint columnidDefinitionName;
}

struct JET_COLUMNDEF
{
    uint   cbStruct;
    uint   columnid;
    uint   coltyp;
    ushort wCountry;
    ushort langid;
    ushort cp;
    ushort wCollate;
    uint   cbMax;
    uint   grbit;
}

struct JET_COLUMNBASE_A
{
    uint      cbStruct;
    uint      columnid;
    uint      coltyp;
    ushort    wCountry;
    ushort    langid;
    ushort    cp;
    ushort    wFiller;
    uint      cbMax;
    uint      grbit;
    byte[256] szBaseTableName;
    byte[256] szBaseColumnName;
}

struct JET_COLUMNBASE_W
{
    uint        cbStruct;
    uint        columnid;
    uint        coltyp;
    ushort      wCountry;
    ushort      langid;
    ushort      cp;
    ushort      wFiller;
    uint        cbMax;
    uint        grbit;
    ushort[256] szBaseTableName;
    ushort[256] szBaseColumnName;
}

struct JET_INDEXLIST
{
    uint cbStruct;
    uint tableid;
    uint cRecord;
    uint columnidindexname;
    uint columnidgrbitIndex;
    uint columnidcKey;
    uint columnidcEntry;
    uint columnidcPage;
    uint columnidcColumn;
    uint columnidiColumn;
    uint columnidcolumnid;
    uint columnidcoltyp;
    uint columnidCountry;
    uint columnidLangid;
    uint columnidCp;
    uint columnidCollate;
    uint columnidgrbitColumn;
    uint columnidcolumnname;
    uint columnidLCMapFlags;
}

struct tag_JET_COLUMNCREATE_A
{
    uint  cbStruct;
    byte* szColumnName;
    uint  coltyp;
    uint  cbMax;
    uint  grbit;
    void* pvDefault;
    uint  cbDefault;
    uint  cp;
    uint  columnid;
    int   err;
}

struct tag_JET_COLUMNCREATE_W
{
    uint  cbStruct;
    PWSTR szColumnName;
    uint  coltyp;
    uint  cbMax;
    uint  grbit;
    void* pvDefault;
    uint  cbDefault;
    uint  cp;
    uint  columnid;
    int   err;
}

struct tag_JET_USERDEFINEDDEFAULT_A
{
    byte*  szCallback;
    ubyte* pbUserData;
    uint   cbUserData;
    byte*  szDependantColumns;
}

struct tag_JET_USERDEFINEDDEFAULT_W
{
    PWSTR  szCallback;
    ubyte* pbUserData;
    uint   cbUserData;
    PWSTR  szDependantColumns;
}

struct JET_CONDITIONALCOLUMN_A
{
    uint  cbStruct;
    byte* szColumnName;
    uint  grbit;
}

struct JET_CONDITIONALCOLUMN_W
{
    uint  cbStruct;
    PWSTR szColumnName;
    uint  grbit;
}

struct JET_UNICODEINDEX
{
    uint lcid;
    uint dwMapFlags;
}

struct JET_UNICODEINDEX2
{
    PWSTR szLocaleName;
    uint  dwMapFlags;
}

struct JET_TUPLELIMITS
{
    uint chLengthMin;
    uint chLengthMax;
    uint chToIndexMax;
    uint cchIncrement;
    uint ichStart;
}

struct JET_SPACEHINTS
{
    uint cbStruct;
    uint ulInitialDensity;
    uint cbInitial;
    uint grbit;
    uint ulMaintDensity;
    uint ulGrowth;
    uint cbMinExtent;
    uint cbMaxExtent;
}

struct JET_INDEXCREATE_A
{
    uint  cbStruct;
    byte* szIndexName;
    byte* szKey;
    uint  cbKey;
    uint  grbit;
    uint  ulDensity;
union
    {
        uint              lcid;
        JET_UNICODEINDEX* pidxunicode;
    }
union
    {
        uint             cbVarSegMac;
        JET_TUPLELIMITS* ptuplelimits;
    }
    JET_CONDITIONALCOLUMN_A* rgconditionalcolumn;
    uint  cConditionalColumn;
    int   err;
    uint  cbKeyMost;
}

struct JET_INDEXCREATE_W
{
    uint  cbStruct;
    PWSTR szIndexName;
    PWSTR szKey;
    uint  cbKey;
    uint  grbit;
    uint  ulDensity;
union
    {
        uint              lcid;
        JET_UNICODEINDEX* pidxunicode;
    }
union
    {
        uint             cbVarSegMac;
        JET_TUPLELIMITS* ptuplelimits;
    }
    JET_CONDITIONALCOLUMN_W* rgconditionalcolumn;
    uint  cConditionalColumn;
    int   err;
    uint  cbKeyMost;
}

struct JET_INDEXCREATE2_A
{
    uint            cbStruct;
    byte*           szIndexName;
    byte*           szKey;
    uint            cbKey;
    uint            grbit;
    uint            ulDensity;
union
    {
        uint              lcid;
        JET_UNICODEINDEX* pidxunicode;
    }
union
    {
        uint             cbVarSegMac;
        JET_TUPLELIMITS* ptuplelimits;
    }
    JET_CONDITIONALCOLUMN_A* rgconditionalcolumn;
    uint            cConditionalColumn;
    int             err;
    uint            cbKeyMost;
    JET_SPACEHINTS* pSpacehints;
}

struct JET_INDEXCREATE2_W
{
    uint            cbStruct;
    PWSTR           szIndexName;
    PWSTR           szKey;
    uint            cbKey;
    uint            grbit;
    uint            ulDensity;
union
    {
        uint              lcid;
        JET_UNICODEINDEX* pidxunicode;
    }
union
    {
        uint             cbVarSegMac;
        JET_TUPLELIMITS* ptuplelimits;
    }
    JET_CONDITIONALCOLUMN_W* rgconditionalcolumn;
    uint            cConditionalColumn;
    int             err;
    uint            cbKeyMost;
    JET_SPACEHINTS* pSpacehints;
}

struct JET_INDEXCREATE3_A
{
    uint               cbStruct;
    byte*              szIndexName;
    byte*              szKey;
    uint               cbKey;
    uint               grbit;
    uint               ulDensity;
    JET_UNICODEINDEX2* pidxunicode;
union
    {
        uint             cbVarSegMac;
        JET_TUPLELIMITS* ptuplelimits;
    }
    JET_CONDITIONALCOLUMN_A* rgconditionalcolumn;
    uint               cConditionalColumn;
    int                err;
    uint               cbKeyMost;
    JET_SPACEHINTS*    pSpacehints;
}

struct JET_INDEXCREATE3_W
{
    uint               cbStruct;
    PWSTR              szIndexName;
    PWSTR              szKey;
    uint               cbKey;
    uint               grbit;
    uint               ulDensity;
    JET_UNICODEINDEX2* pidxunicode;
union
    {
        uint             cbVarSegMac;
        JET_TUPLELIMITS* ptuplelimits;
    }
    JET_CONDITIONALCOLUMN_W* rgconditionalcolumn;
    uint               cConditionalColumn;
    int                err;
    uint               cbKeyMost;
    JET_SPACEHINTS*    pSpacehints;
}

struct JET_TABLECREATE_A
{
    uint               cbStruct;
    byte*              szTableName;
    byte*              szTemplateTableName;
    uint               ulPages;
    uint               ulDensity;
    tag_JET_COLUMNCREATE_A* rgcolumncreate;
    uint               cColumns;
    JET_INDEXCREATE_A* rgindexcreate;
    uint               cIndexes;
    uint               grbit;
    uint               tableid;
    uint               cCreated;
}

struct JET_TABLECREATE_W
{
    uint               cbStruct;
    PWSTR              szTableName;
    PWSTR              szTemplateTableName;
    uint               ulPages;
    uint               ulDensity;
    tag_JET_COLUMNCREATE_W* rgcolumncreate;
    uint               cColumns;
    JET_INDEXCREATE_W* rgindexcreate;
    uint               cIndexes;
    uint               grbit;
    uint               tableid;
    uint               cCreated;
}

struct JET_TABLECREATE2_A
{
    uint               cbStruct;
    byte*              szTableName;
    byte*              szTemplateTableName;
    uint               ulPages;
    uint               ulDensity;
    tag_JET_COLUMNCREATE_A* rgcolumncreate;
    uint               cColumns;
    JET_INDEXCREATE_A* rgindexcreate;
    uint               cIndexes;
    byte*              szCallback;
    uint               cbtyp;
    uint               grbit;
    uint               tableid;
    uint               cCreated;
}

struct JET_TABLECREATE2_W
{
    uint               cbStruct;
    PWSTR              szTableName;
    PWSTR              szTemplateTableName;
    uint               ulPages;
    uint               ulDensity;
    tag_JET_COLUMNCREATE_W* rgcolumncreate;
    uint               cColumns;
    JET_INDEXCREATE_W* rgindexcreate;
    uint               cIndexes;
    PWSTR              szCallback;
    uint               cbtyp;
    uint               grbit;
    uint               tableid;
    uint               cCreated;
}

struct JET_TABLECREATE3_A
{
    uint                cbStruct;
    byte*               szTableName;
    byte*               szTemplateTableName;
    uint                ulPages;
    uint                ulDensity;
    tag_JET_COLUMNCREATE_A* rgcolumncreate;
    uint                cColumns;
    JET_INDEXCREATE2_A* rgindexcreate;
    uint                cIndexes;
    byte*               szCallback;
    uint                cbtyp;
    uint                grbit;
    JET_SPACEHINTS*     pSeqSpacehints;
    JET_SPACEHINTS*     pLVSpacehints;
    uint                cbSeparateLV;
    uint                tableid;
    uint                cCreated;
}

struct JET_TABLECREATE3_W
{
    uint                cbStruct;
    PWSTR               szTableName;
    PWSTR               szTemplateTableName;
    uint                ulPages;
    uint                ulDensity;
    tag_JET_COLUMNCREATE_W* rgcolumncreate;
    uint                cColumns;
    JET_INDEXCREATE2_W* rgindexcreate;
    uint                cIndexes;
    PWSTR               szCallback;
    uint                cbtyp;
    uint                grbit;
    JET_SPACEHINTS*     pSeqSpacehints;
    JET_SPACEHINTS*     pLVSpacehints;
    uint                cbSeparateLV;
    uint                tableid;
    uint                cCreated;
}

struct JET_TABLECREATE4_A
{
    uint                cbStruct;
    byte*               szTableName;
    byte*               szTemplateTableName;
    uint                ulPages;
    uint                ulDensity;
    tag_JET_COLUMNCREATE_A* rgcolumncreate;
    uint                cColumns;
    JET_INDEXCREATE3_A* rgindexcreate;
    uint                cIndexes;
    byte*               szCallback;
    uint                cbtyp;
    uint                grbit;
    JET_SPACEHINTS*     pSeqSpacehints;
    JET_SPACEHINTS*     pLVSpacehints;
    uint                cbSeparateLV;
    uint                tableid;
    uint                cCreated;
}

struct JET_TABLECREATE4_W
{
    uint                cbStruct;
    PWSTR               szTableName;
    PWSTR               szTemplateTableName;
    uint                ulPages;
    uint                ulDensity;
    tag_JET_COLUMNCREATE_W* rgcolumncreate;
    uint                cColumns;
    JET_INDEXCREATE3_W* rgindexcreate;
    uint                cIndexes;
    PWSTR               szCallback;
    uint                cbtyp;
    uint                grbit;
    JET_SPACEHINTS*     pSeqSpacehints;
    JET_SPACEHINTS*     pLVSpacehints;
    uint                cbSeparateLV;
    uint                tableid;
    uint                cCreated;
}

struct JET_OPENTEMPORARYTABLE
{
    uint              cbStruct;
    const(JET_COLUMNDEF)* prgcolumndef;
    uint              ccolumn;
    JET_UNICODEINDEX* pidxunicode;
    uint              grbit;
    uint*             prgcolumnid;
    uint              cbKeyMost;
    uint              cbVarSegMac;
    uint              tableid;
}

struct JET_OPENTEMPORARYTABLE2
{
    uint               cbStruct;
    const(JET_COLUMNDEF)* prgcolumndef;
    uint               ccolumn;
    JET_UNICODEINDEX2* pidxunicode;
    uint               grbit;
    uint*              prgcolumnid;
    uint               cbKeyMost;
    uint               cbVarSegMac;
    uint               tableid;
}

struct JET_RETINFO
{
    uint cbStruct;
    uint ibLongValue;
    uint itagSequence;
    uint columnidNextTagged;
}

struct JET_SETINFO
{
    uint cbStruct;
    uint ibLongValue;
    uint itagSequence;
}

struct JET_RECPOS
{
    uint cbStruct;
    uint centriesLT;
    uint centriesInRange;
    uint centriesTotal;
}

struct JET_RECORDLIST
{
    uint cbStruct;
    uint tableid;
    uint cRecord;
    uint columnidBookmark;
}

struct JET_INDEXRANGE
{
    uint cbStruct;
    uint tableid;
    uint grbit;
}

struct JET_INDEX_COLUMN
{
    uint      columnid;
    JET_RELOP relop;
    void*     pv;
    uint      cb;
    uint      grbit;
}

struct JET_INDEX_RANGE
{
    JET_INDEX_COLUMN* rgStartColumns;
    uint              cStartColumns;
    JET_INDEX_COLUMN* rgEndColumns;
    uint              cEndColumns;
}

struct JET_LOGTIME
{
    byte bSeconds;
    byte bMinutes;
    byte bHours;
    byte bDay;
    byte bMonth;
    byte bYear;
union
    {
        byte bFiller1;
struct
        {
            ubyte _bitfield108;
        }
    }
union
    {
        byte bFiller2;
struct
        {
            ubyte _bitfield109;
        }
    }
}

struct JET_BKLOGTIME
{
    byte bSeconds;
    byte bMinutes;
    byte bHours;
    byte bDay;
    byte bMonth;
    byte bYear;
union
    {
        byte bFiller1;
struct
        {
            ubyte _bitfield110;
        }
    }
union
    {
        byte bFiller2;
struct
        {
            ubyte _bitfield111;
        }
    }
}

struct JET_LGPOS
{
align (1):
    ushort ib;
    ushort isec;
    int    lGeneration;
}

struct JET_SIGNATURE
{
align (1):
    uint        ulRandom;
    JET_LOGTIME logtimeCreate;
    byte[16]    szComputerName;
}

struct JET_BKINFO
{
align (1):
    JET_LGPOS lgposMark;
union
    {
        JET_LOGTIME   logtimeMark;
        JET_BKLOGTIME bklogtimeMark;
    }
    uint      genLow;
    uint      genHigh;
}

struct JET_DBINFOMISC
{
    uint          ulVersion;
    uint          ulUpdate;
    JET_SIGNATURE signDb;
    uint          dbstate;
    JET_LGPOS     lgposConsistent;
    JET_LOGTIME   logtimeConsistent;
    JET_LOGTIME   logtimeAttach;
    JET_LGPOS     lgposAttach;
    JET_LOGTIME   logtimeDetach;
    JET_LGPOS     lgposDetach;
    JET_SIGNATURE signLog;
    JET_BKINFO    bkinfoFullPrev;
    JET_BKINFO    bkinfoIncPrev;
    JET_BKINFO    bkinfoFullCur;
    uint          fShadowingDisabled;
    uint          fUpgradeDb;
    uint          dwMajorVersion;
    uint          dwMinorVersion;
    uint          dwBuildNumber;
    int           lSPNumber;
    uint          cbPageSize;
}

struct JET_DBINFOMISC2
{
    uint          ulVersion;
    uint          ulUpdate;
    JET_SIGNATURE signDb;
    uint          dbstate;
    JET_LGPOS     lgposConsistent;
    JET_LOGTIME   logtimeConsistent;
    JET_LOGTIME   logtimeAttach;
    JET_LGPOS     lgposAttach;
    JET_LOGTIME   logtimeDetach;
    JET_LGPOS     lgposDetach;
    JET_SIGNATURE signLog;
    JET_BKINFO    bkinfoFullPrev;
    JET_BKINFO    bkinfoIncPrev;
    JET_BKINFO    bkinfoFullCur;
    uint          fShadowingDisabled;
    uint          fUpgradeDb;
    uint          dwMajorVersion;
    uint          dwMinorVersion;
    uint          dwBuildNumber;
    int           lSPNumber;
    uint          cbPageSize;
    uint          genMinRequired;
    uint          genMaxRequired;
    JET_LOGTIME   logtimeGenMaxCreate;
    uint          ulRepairCount;
    JET_LOGTIME   logtimeRepair;
    uint          ulRepairCountOld;
    uint          ulECCFixSuccess;
    JET_LOGTIME   logtimeECCFixSuccess;
    uint          ulECCFixSuccessOld;
    uint          ulECCFixFail;
    JET_LOGTIME   logtimeECCFixFail;
    uint          ulECCFixFailOld;
    uint          ulBadChecksum;
    JET_LOGTIME   logtimeBadChecksum;
    uint          ulBadChecksumOld;
}

struct JET_DBINFOMISC3
{
    uint          ulVersion;
    uint          ulUpdate;
    JET_SIGNATURE signDb;
    uint          dbstate;
    JET_LGPOS     lgposConsistent;
    JET_LOGTIME   logtimeConsistent;
    JET_LOGTIME   logtimeAttach;
    JET_LGPOS     lgposAttach;
    JET_LOGTIME   logtimeDetach;
    JET_LGPOS     lgposDetach;
    JET_SIGNATURE signLog;
    JET_BKINFO    bkinfoFullPrev;
    JET_BKINFO    bkinfoIncPrev;
    JET_BKINFO    bkinfoFullCur;
    uint          fShadowingDisabled;
    uint          fUpgradeDb;
    uint          dwMajorVersion;
    uint          dwMinorVersion;
    uint          dwBuildNumber;
    int           lSPNumber;
    uint          cbPageSize;
    uint          genMinRequired;
    uint          genMaxRequired;
    JET_LOGTIME   logtimeGenMaxCreate;
    uint          ulRepairCount;
    JET_LOGTIME   logtimeRepair;
    uint          ulRepairCountOld;
    uint          ulECCFixSuccess;
    JET_LOGTIME   logtimeECCFixSuccess;
    uint          ulECCFixSuccessOld;
    uint          ulECCFixFail;
    JET_LOGTIME   logtimeECCFixFail;
    uint          ulECCFixFailOld;
    uint          ulBadChecksum;
    JET_LOGTIME   logtimeBadChecksum;
    uint          ulBadChecksumOld;
    uint          genCommitted;
}

struct JET_DBINFOMISC4
{
    uint          ulVersion;
    uint          ulUpdate;
    JET_SIGNATURE signDb;
    uint          dbstate;
    JET_LGPOS     lgposConsistent;
    JET_LOGTIME   logtimeConsistent;
    JET_LOGTIME   logtimeAttach;
    JET_LGPOS     lgposAttach;
    JET_LOGTIME   logtimeDetach;
    JET_LGPOS     lgposDetach;
    JET_SIGNATURE signLog;
    JET_BKINFO    bkinfoFullPrev;
    JET_BKINFO    bkinfoIncPrev;
    JET_BKINFO    bkinfoFullCur;
    uint          fShadowingDisabled;
    uint          fUpgradeDb;
    uint          dwMajorVersion;
    uint          dwMinorVersion;
    uint          dwBuildNumber;
    int           lSPNumber;
    uint          cbPageSize;
    uint          genMinRequired;
    uint          genMaxRequired;
    JET_LOGTIME   logtimeGenMaxCreate;
    uint          ulRepairCount;
    JET_LOGTIME   logtimeRepair;
    uint          ulRepairCountOld;
    uint          ulECCFixSuccess;
    JET_LOGTIME   logtimeECCFixSuccess;
    uint          ulECCFixSuccessOld;
    uint          ulECCFixFail;
    JET_LOGTIME   logtimeECCFixFail;
    uint          ulECCFixFailOld;
    uint          ulBadChecksum;
    JET_LOGTIME   logtimeBadChecksum;
    uint          ulBadChecksumOld;
    uint          genCommitted;
    JET_BKINFO    bkinfoCopyPrev;
    JET_BKINFO    bkinfoDiffPrev;
}

struct JET_THREADSTATS
{
    uint cbStruct;
    uint cPageReferenced;
    uint cPageRead;
    uint cPagePreread;
    uint cPageDirtied;
    uint cPageRedirtied;
    uint cLogRecord;
    uint cbLogRecord;
}

struct JET_THREADSTATS2
{
align (4):
    uint  cbStruct;
    uint  cPageReferenced;
    uint  cPageRead;
    uint  cPagePreread;
    uint  cPageDirtied;
    uint  cPageRedirtied;
    uint  cLogRecord;
    uint  cbLogRecord;
    ulong cusecPageCacheMiss;
    uint  cPageCacheMiss;
}

struct JET_RSTINFO_A
{
    uint          cbStruct;
    JET_RSTMAP_A* rgrstmap;
    int           crstmap;
    JET_LGPOS     lgposStop;
    JET_LOGTIME   logtimeStop;
    JET_PFNSTATUS pfnStatus;
}

struct JET_RSTINFO_W
{
    uint          cbStruct;
    JET_RSTMAP_W* rgrstmap;
    int           crstmap;
    JET_LGPOS     lgposStop;
    JET_LOGTIME   logtimeStop;
    JET_PFNSTATUS pfnStatus;
}

struct JET_ERRINFOBASIC_W
{
    uint       cbStruct;
    int        errValue;
    JET_ERRCAT errcatMostSpecific;
    ubyte[8]   rgCategoricalHierarchy;
    uint       lSourceLine;
    ushort[64] rgszSourceFile;
}

struct JET_COMMIT_ID
{
align (4):
    JET_SIGNATURE signLog;
    int           reserved;
    long          commitId;
}

struct JET_OPERATIONCONTEXT
{
    uint  ulUserID;
    ubyte nOperationID;
    ubyte nOperationType;
    ubyte nClientType;
    ubyte fFlags;
}

struct JET_SETCOLUMN
{
    uint         columnid;
    const(void)* pvData;
    uint         cbData;
    uint         grbit;
    uint         ibLongValue;
    uint         itagSequence;
    int          err;
}

struct JET_SETSYSPARAM_A
{
    uint         paramid;
    uint         lParam;
    const(byte)* sz;
    int          err;
}

struct JET_SETSYSPARAM_W
{
    uint         paramid;
    uint         lParam;
    const(PWSTR) sz;
    int          err;
}

struct JET_RETRIEVECOLUMN
{
    uint  columnid;
    void* pvData;
    uint  cbData;
    uint  cbActual;
    uint  grbit;
    uint  ibLongValue;
    uint  itagSequence;
    uint  columnidNextTagged;
    int   err;
}

struct JET_ENUMCOLUMNID
{
    uint  columnid;
    uint  ctagSequence;
    uint* rgtagSequence;
}

struct JET_ENUMCOLUMNVALUE
{
    uint  itagSequence;
    int   err;
    uint  cbData;
    void* pvData;
}

struct JET_ENUMCOLUMN
{
    uint columnid;
    int  err;
union
    {
struct
        {
            uint                 cEnumColumnValue;
            JET_ENUMCOLUMNVALUE* rgEnumColumnValue;
        }
struct
        {
            uint  cbData;
            void* pvData;
        }
    }
}

struct JET_RECSIZE
{
align (4):
    ulong cbData;
    ulong cbLongValueData;
    ulong cbOverhead;
    ulong cbLongValueOverhead;
    ulong cNonTaggedColumns;
    ulong cTaggedColumns;
    ulong cLongValues;
    ulong cMultiValues;
}

struct JET_RECSIZE2
{
align (4):
    ulong cbData;
    ulong cbLongValueData;
    ulong cbOverhead;
    ulong cbLongValueOverhead;
    ulong cNonTaggedColumns;
    ulong cTaggedColumns;
    ulong cLongValues;
    ulong cMultiValues;
    ulong cCompressedColumns;
    ulong cbDataCompressed;
    ulong cbLongValueDataCompressed;
}

struct JET_LOGINFO_A
{
    uint    cbSize;
    uint    ulGenLow;
    uint    ulGenHigh;
    byte[4] szBaseName;
}

struct JET_LOGINFO_W
{
    uint      cbSize;
    uint      ulGenLow;
    uint      ulGenHigh;
    ushort[4] szBaseName;
}

struct JET_INSTANCE_INFO_A
{
    uint   hInstanceId;
    byte*  szInstanceName;
    uint   cDatabases;
    byte** szDatabaseFileName;
    byte** szDatabaseDisplayName;
    byte** szDatabaseSLVFileName_Obsolete;
}

struct JET_INSTANCE_INFO_W
{
    uint     hInstanceId;
    PWSTR    szInstanceName;
    uint     cDatabases;
    ushort** szDatabaseFileName;
    ushort** szDatabaseDisplayName;
    ushort** szDatabaseSLVFileName_Obsolete;
}

///The <b>STATSTG</b> structure contains statistical data about an open storage, stream, or byte-array object. This
///structure is used in the IEnumSTATSTG, ILockBytes, IStorage, and IStream interfaces.
struct STATSTG
{
    ///A pointer to a <b>NULL</b>-terminated Unicode string that contains the name. Space for this string is allocated
    ///by the method called and freed by the caller (for more information, see CoTaskMemFree). To not return this
    ///member, specify the STATFLAG_NONAME value when you call a method that returns a <b>STATSTG</b> structure, except
    ///for calls to IEnumSTATSTG::Next, which provides no way to specify this value.
    PWSTR          pwcsName;
    ///Indicates the type of storage object. This is one of the values from the STGTY enumeration.
    uint           type;
    ///Specifies the size, in bytes, of the stream or byte array.
    ULARGE_INTEGER cbSize;
    ///Indicates the last modification time for this storage, stream, or byte array.
    FILETIME       mtime;
    ///Indicates the creation time for this storage, stream, or byte array.
    FILETIME       ctime;
    ///Indicates the last access time for this storage, stream, or byte array.
    FILETIME       atime;
    ///Indicates the access mode specified when the object was opened. This member is only valid in calls to <b>Stat</b>
    ///methods.
    uint           grfMode;
    ///Indicates the types of region locking supported by the stream or byte array. For more information about the
    ///values available, see the LOCKTYPE enumeration. This member is not used for storage objects.
    uint           grfLocksSupported;
    ///Indicates the class identifier for the storage object; set to CLSID_NULL for new storage objects. This member is
    ///not used for streams or byte arrays.
    GUID           clsid;
    ///Indicates the current state bits of the storage object; that is, the value most recently set by the
    ///IStorage::SetStateBits method. This member is not valid for streams or byte arrays.
    uint           grfStateBits;
    ///Reserved for future use.
    uint           reserved;
}

///The <b>RemSNB</b> structure is used for marshaling the SNB data type. Defined in the IStorage interface (Storag.idl).
struct RemSNB
{
    ///Number of strings in the <b>rgString</b> buffer.
    uint      ulCntStr;
    ///Size in bytes of the <b>rgString</b> buffer.
    uint      ulCntChar;
    ///Pointer to an array of bytes containing the stream name strings from the <b>SNB</b> structure.
    ushort[1] rgString;
}

///The <b>StorageLayout</b> structure describes a single block of data, including its name, location, and length. To
///optimize a compound file, an application or layout tool passes an array of <b>StorageLayout</b> structures in a call
///to ILayoutStorage::LayoutScript.
struct StorageLayout
{
    ///The type of element to be written. Values are taken from the STGTY enumeration. <b>STGTY_STREAM</b> means read
    ///the block of data named by <b>pwcsElementName</b>. <b>STGTY_STORAGE</b> means open the storage specified in
    ///<b>pwcsElementName</b>. <b>STGTY_REPEAT</b> is used in multimedia applications to interface audio, video, text,
    ///and other elements. An opening <b>STGTY_REPEAT</b> value means that the elements that follow are to be repeated a
    ///specified number of times. The closing <b>STGTY_REPEAT</b> value marks the end of those elements that are to be
    ///repeated. Nested <b>STGTY_REPEAT</b> value pairs are permitted.
    uint          LayoutType;
    ///The null-terminated Unicode string name of the storage or stream. If the element is a substorage or embedded
    ///object, the fully qualified storage path must be specified; for example,
    ///"RootStorageName\SubStorageName\Substream".
    PWSTR         pwcsElementName;
    ///Where the value of the <b>LayoutType</b> member is <b>STGTY_STREAM</b>, this flag specifies the beginning offset
    ///into the steam named in the <b>pwscElementName</b> member. Where <b>LayoutType</b> is <b>STGTY_STORAGE</b>, this
    ///flag should be set to zero. Where <b>LayoutType</b> is <b>STGTY_REPEAT</b>, this flag should be set to zero.
    LARGE_INTEGER cOffset;
    ///Length, in bytes, of the data block named in <b>pwcsElementName</b>. Where <b>LayoutType</b> is
    ///<b>STGTY_STREAM</b>, <b>cBytes</b> specifies the number of bytes to read at <b>cOffset</b> from the stream named
    ///in <b>pwcsElementName</b>. Where <b>LayoutType</b> is <b>STGTY_STORAGE</b>, this flag is ignored. Where
    ///<b>LayoutType</b> is <b>STGTY_REPEAT</b>, a positive <b>cBytes</b> specifies the beginning of a repeat block.
    ///<b>STGTY_REPEAT</b> with zero <b>cBytes</b> marks the end of a repeat block. A beginning block value of
    ///<b>STG_TOEND</b> specifies that elements in a following block are to be repeated after each stream has been
    ///completely read.
    LARGE_INTEGER cBytes;
}

// Functions

///The <b>StgCreateDocfile</b> function creates a new compound file storage object using the COM-provided compound file
///implementation for the IStorage interface. <div class="alert"><b>Note</b> Applications should use the new function,
///StgCreateStorageEx, instead of <b>StgCreateDocfile</b>, to take advantage of enhanced Structured Storage features.
///This function, <b>StgCreateDocfile</b>, still exists for compatibility with Windows 2000.</div><div> </div>
///Params:
///    pwcsName = A pointer to a null-terminated Unicode string name for the compound file being created. It is passed
///               uninterpreted to the file system. This can be a relative name or <b>NULL</b>. If <b>NULL</b>, a temporary
///               compound file is allocated with a unique name.
///    grfMode = Specifies the access mode to use when opening the new storage object. For more information, see STGM Constants.
///              If the caller specifies transacted mode together with STGM_CREATE or STGM_CONVERT, the overwrite or conversion
///              takes place when the commit operation is called for the root storage. If IStorage::Commit is not called for the
///              root storage object, previous contents of the file will be restored. STGM_CREATE and STGM_CONVERT cannot be
///              combined with the STGM_NOSNAPSHOT flag, because a snapshot copy is required when a file is overwritten or
///              converted in the transacted mode.
///    reserved = Reserved for future use; must be zero.
///    ppstgOpen = A pointer to the location of the IStorage pointer to the new storage object.
///Returns:
///    <b>StgCreateDocfile</b> can also return any file system errors or system errors wrapped in an <b>HRESULT</b>. For
///    more information, see Error Handling Strategies and Handling Unknown Errors.
///    
@DllImport("OLE32")
HRESULT StgCreateDocfile(const(PWSTR) pwcsName, uint grfMode, uint reserved, IStorage* ppstgOpen);

///The <b>StgCreateDocfileOnILockBytes</b> function creates and opens a new compound file storage object on top of a
///byte-array object provided by the caller. The storage object supports the COM-provided, compound-file implementation
///for the IStorage interface.
///Params:
///    plkbyt = A pointer to the ILockBytes interface on the underlying byte-array object on which to create a compound file.
///    grfMode = Specifies the access mode to use when opening the new compound file. For more information, see STGM Constants and
///              the Remarks section below.
///    reserved = Reserved for future use; must be zero.
///    ppstgOpen = A pointer to the location of the IStorage pointer on the new storage object.
///Returns:
///    The <b>StgCreateDocfileOnILockBytes</b> function can also return any file system errors, or system errors wrapped
///    in an <b>HRESULT</b>, or ILockBytes interface error return values. For more information, see Error Handling
///    Strategies and Handling Unknown Errors.
///    
@DllImport("OLE32")
HRESULT StgCreateDocfileOnILockBytes(ILockBytes plkbyt, uint grfMode, uint reserved, IStorage* ppstgOpen);

///The <b>StgOpenStorage</b> function opens an existing root storage object in the file system. Use this function to
///open compound files. Do not use it to open directories, files, or summary catalogs. Nested storage objects can only
///be opened using their parent IStorage::OpenStorage method. <div class="alert"><b>Note</b> Applications should use the
///new function, StgOpenStorageEx, instead of <b>StgOpenStorage</b>, to take advantage of the enhanced and Windows
///Structured Storage features. This function, <b>StgOpenStorage</b>, still exists for compatibility with applications
///running on Windows 2000.</div><div> </div>
///Params:
///    pwcsName = A pointer to the path of the <b>null</b>-terminated Unicode string file that contains the storage object to open.
///               This parameter is ignored if the <i>pstgPriority</i> parameter is not <b>NULL</b>.
///    pstgPriority = A pointer to the IStorage interface that should be <b>NULL</b>. If not <b>NULL</b>, this parameter is used as
///                   described below in the Remarks section. After <b>StgOpenStorage</b> returns, the storage object specified in
///                   <i>pStgPriority</i> may have been released and should no longer be used.
///    grfMode = Specifies the access mode to use to open the storage object.
///    snbExclude = If not <b>NULL</b>, pointer to a block of elements in the storage to be excluded as the storage object is opened.
///                 The exclusion occurs regardless of whether a snapshot copy happens on the open. Can be <b>NULL</b>.
///    reserved = Indicates reserved for future use; must be zero.
///    ppstgOpen = A pointer to a IStorage* pointer variable that receives the interface pointer to the opened storage.
///Returns:
///    The <b>StgOpenStorage</b> function can also return any file system errors or system errors wrapped in an
///    <b>HRESULT</b>. For more information, see Error Handling Strategies and Handling Unknown Errors.
///    
@DllImport("OLE32")
HRESULT StgOpenStorage(const(PWSTR) pwcsName, IStorage pstgPriority, uint grfMode, ushort** snbExclude, 
                       uint reserved, IStorage* ppstgOpen);

///The <b>StgOpenStorageOnILockBytes</b> function opens an existing storage object that does not reside in a disk file,
///but instead has an underlying byte array provided by the caller.
///Params:
///    plkbyt = ILockBytes pointer to the underlying byte array object that contains the storage object to be opened.
///    pstgPriority = A pointer to the IStorage interface that should be <b>NULL</b>. If not <b>NULL</b>, this parameter is used as
///                   described below in the Remarks section. After <b>StgOpenStorageOnILockBytes</b> returns, the storage object
///                   specified in <i>pStgPriority</i> may have been released and should no longer be used.
///    grfMode = Specifies the access mode to use to open the storage object. For more information, see STGM Constants and the
///              Remarks section below.
///    snbExclude = Can be <b>NULL</b>. If not <b>NULL</b>, this parameter points to a block of elements in this storage that are to
///                 be excluded as the storage object is opened. This exclusion occurs independently of whether a snapshot copy
///                 happens on the open.
///    reserved = Indicates reserved for future use; must be zero.
///    ppstgOpen = Points to the location of an IStorage pointer to the opened storage on successful return.
///Returns:
///    The <b>StgOpenStorageOnILockBytes</b> function can also return any file system errors, or system errors wrapped
///    in an <b>HRESULT</b>, or ILockBytes interface error return values. See Error Handling Strategies and Handling
///    Unknown Errors.
///    
@DllImport("OLE32")
HRESULT StgOpenStorageOnILockBytes(ILockBytes plkbyt, IStorage pstgPriority, uint grfMode, ushort** snbExclude, 
                                   uint reserved, IStorage* ppstgOpen);

///The <b>StgIsStorageFile</b> function indicates whether a particular disk file contains a storage object.
///Params:
///    pwcsName = Pointer to the null-terminated Unicode string name of the disk file to be examined. The <i>pwcsName</i> parameter
///               is passed uninterpreted to the underlying file system.
///Returns:
///    <b>StgIsStorageFile</b> function can also return any file system errors or system errors wrapped in an
///    <b>HRESULT</b>. See Error Handling Strategies and Handling Unknown Errors
///    
@DllImport("OLE32")
HRESULT StgIsStorageFile(const(PWSTR) pwcsName);

///The <b>StgIsStorageILockBytes</b> function indicates whether the specified byte array contains a storage object.
///Params:
///    plkbyt = ILockBytes pointer to the byte array to be examined.
///Returns:
///    This function can also return any file system errors, or system errors wrapped in an <b>HRESULT</b>, or
///    ILockBytes interface error return values. See Error Handling Strategies and Handling Unknown Errors
///    
@DllImport("OLE32")
HRESULT StgIsStorageILockBytes(ILockBytes plkbyt);

///The <b>StgSetTimes</b> function sets the creation, access, and modification times of the indicated file, if supported
///by the underlying file system.
///Params:
///    lpszName = Pointer to the name of the file to be changed.
///    pctime = Pointer to the new value for the creation time.
///    patime = Pointer to the new value for the access time.
///    pmtime = Pointer to the new value for the modification time.
///Returns:
///    The <b>StgSetTimes</b> function can also return any file system errors or system errors wrapped in an
///    <b>HRESULT</b>. See Error Handling Strategies and Handling Unknown Errors.
///    
@DllImport("OLE32")
HRESULT StgSetTimes(const(PWSTR) lpszName, const(FILETIME)* pctime, const(FILETIME)* patime, 
                    const(FILETIME)* pmtime);

///The <b>StgCreateStorageEx</b> function creates a new storage object using a provided implementation for the IStorage
///or IPropertySetStorage interfaces. To open an existing file, use the StgOpenStorageEx function instead. Applications
///written for Windows 2000, Windows Server 2003 and Windows XP must use <b>StgCreateStorageEx</b> rather than
///StgCreateDocfile to take advantage of the enhanced Windows 2000 and Windows XP Structured Storage features.
///Params:
///    pwcsName = A pointer to the path of the file to create. It is passed uninterpreted to the file system. This can be a
///               relative name or <b>NULL</b>. If <b>NULL</b>, a temporary file is allocated with a unique name. If
///               non-<b>NULL</b>, the string size must not exceed MAX_PATH characters. <b>Windows 2000: </b>Unlike the CreateFile
///               function, you cannot exceed the MAX_PATH limit by using the "\\?\" prefix.
///    grfMode = A value that specifies the access mode to use when opening the new storage object. For more information, see STGM
///              Constants. If the caller specifies transacted mode together with STGM_CREATE or STGM_CONVERT, the overwrite or
///              conversion takes place when the commit operation is called for the root storage. If IStorage::Commit is not
///              called for the root storage object, previous contents of the file will be restored. STGM_CREATE and STGM_CONVERT
///              cannot be combined with the STGM_NOSNAPSHOT flag, because a snapshot copy is required when a file is overwritten
///              or converted in the transacted mode.
///    stgfmt = A value that specifies the storage file format. For more information, see the STGFMT enumeration.
///    grfAttrs = A value that depends on the value of the <i>stgfmt</i> parameter. <table> <tr> <th>Parameter Values</th>
///               <th>Meaning</th> </tr> <tr> <td width="40%"><a id="STGFMT_DOCFILE"></a><a id="stgfmt_docfile"></a><dl>
///               <dt><b>STGFMT_DOCFILE</b></dt> </dl> </td> <td width="60%"> 0, or FILE_FLAG_NO_BUFFERING. For more information,
///               see CreateFile. If the sector size of the file, specified in <i>pStgOptions</i>, is not an integer multiple of
///               the underlying disk's physical sector size, this operation will fail. </td> </tr> <tr> <td width="40%"><a
///               id="All_other_values_of_stgfmt"></a><a id="all_other_values_of_stgfmt"></a><a
///               id="ALL_OTHER_VALUES_OF_STGFMT"></a><dl> <dt><b>All other values of <i>stgfmt</i></b></dt> </dl> </td> <td
///               width="60%"> Must be 0. </td> </tr> </table>
///    pStgOptions = The <i>pStgOptions</i> parameter is valid only if the <i>stgfmt</i> parameter is set to STGFMT_DOCFILE. If the
///                  <i>stgfmt</i> parameter is set to STGFMT_DOCFILE, <i>pStgOptions</i> points to the STGOPTIONS structure, which
///                  specifies features of the storage object, such as the sector size. This parameter may be <b>NULL</b>, which
///                  creates a storage object with a default sector size of 512 bytes. If non-<b>NULL</b>, the <b>ulSectorSize</b>
///                  member must be set to either 512 or 4096. If set to 4096, STGM_SIMPLE may not be specified in the <i>grfMode</i>
///                  parameter. The <b>usVersion</b> member must be set before calling <b>StgCreateStorageEx</b>. For more
///                  information, see <b>STGOPTIONS</b>.
///    pSecurityDescriptor = Enables the ACLs to be set when the file is created. If not <b>NULL</b>, needs to be a pointer to the
///                          SECURITY_ATTRIBUTES structure. See CreateFile for information on how to set ACLs on files. <b>Windows Server
///                          2003, Windows 2000 Server, Windows XP and Windows 2000 Professional: </b>Value must be <b>NULL</b>.
///    riid = A value that specifies the interface identifier (IID) of the interface pointer to return. This IID may be for the
///           IStorage interface or the IPropertySetStorage interface.
///    ppObjectOpen = A pointer to an interface pointer variable that receives a pointer for an interface on the new storage object;
///                   contains <b>NULL</b> if operation failed.
///Returns:
///    This function can also return any file system errors or system errors wrapped in an <b>HRESULT</b>. For more
///    information, see Error Handling Strategies and Handling Unknown Errors.
///    
@DllImport("OLE32")
HRESULT StgCreateStorageEx(const(PWSTR) pwcsName, uint grfMode, uint stgfmt, uint grfAttrs, 
                           STGOPTIONS* pStgOptions, void* pSecurityDescriptor, const(GUID)* riid, 
                           void** ppObjectOpen);

///The <b>StgOpenStorageEx</b> function opens an existing root storage object in the file system. Use this function to
///open Compound Files and regular files. To create a new file, use the StgCreateStorageEx function. <div
///class="alert"><b>Note</b> To use enhancements, all Windows 2000, Windows XP, and Windows Server 2003 applications
///should call <b>StgOpenStorageEx</b>, instead of StgOpenStorage. The <b>StgOpenStorage</b> function is used for
///compatibility with Windows 2000 and earlier applications.</div><div> </div>
///Params:
///    pwcsName = A pointer to the path of the null-terminated Unicode string file that contains the storage object. This string
///               size cannot exceed <b>MAX_PATH</b> characters. <b>Windows Server 2003 and Windows XP/2000: </b>Unlike the
///               CreateFile function, the <b>MAX_PATH</b> limit cannot be exceeded by using the "\\?\" prefix.
///    grfMode = A value that specifies the access mode to open the new storage object. For more information, see STGM Constants.
///              If the caller specifies transacted mode together with <b>STGM_CREATE</b> or <b>STGM_CONVERT</b>, the overwrite or
///              conversion occurs when the commit operation is called for the root storage. If IStorage::Commit is not called for
///              the root storage object, previous contents of the file will be restored. <b>STGM_CREATE</b> and
///              <b>STGM_CONVERT</b> cannot be combined with the <b>STGM_NOSNAPSHOT</b> flag, because a snapshot copy is required
///              when a file is overwritten or converted in transacted mode. If the storage object is opened in direct mode
///              (<b>STGM_DIRECT</b>) with access to either <b>STGM_WRITE</b> or <b>STGM_READWRITE</b>, the sharing mode must be
///              <b>STGM_SHARE_EXCLUSIVE</b> unless the <b>STGM_DIRECT_SWMR</b> mode is specified. For more information, see the
///              Remarks section. If the storage object is opened in direct mode with access to <b>STGM_READ</b>, the sharing mode
///              must be either <b>STGM_SHARE_EXCLUSIVE</b> or <b>STGM_SHARE_DENY_WRITE</b>, unless <b>STGM_PRIORITY</b> or
///              <b>STGM_DIRECT_SWMR</b> is specified. For more information, see the Remarks section. The mode in which a file is
///              opened can affect implementation performance. For more information, see Compound File Implementation Limits.
///    stgfmt = A value that specifies the storage file format. For more information, see the STGFMT enumeration.
///    grfAttrs = A value that depends upon the value of the <i>stgfmt</i> parameter. <b>STGFMT_DOCFILE</b> must be zero (0) or
///               <b>FILE_FLAG_NO_BUFFERING</b>. For more information about this value, see CreateFile. If the sector size of the
///               file, specified in <i>pStgOptions</i>, is not an integer multiple of the physical sector size of the underlying
///               disk, then this operation will fail. All other values of <i>stgfmt</i> must be zero.
///    pStgOptions = A pointer to an STGOPTIONS structure that contains data about the storage object opened. The <i>pStgOptions</i>
///                  parameter is valid only if the <i>stgfmt</i> parameter is set to <b>STGFMT_DOCFILE</b>. The <b>usVersion</b>
///                  member must be set before calling <b>StgOpenStorageEx</b>. For more information, see the <b>STGOPTIONS</b>
///                  structure.
///    pSecurityDescriptor = Reserved; must be zero.
///    riid = A value that specifies the GUID of the interface pointer to return. Can also be the header-specified value for
///           <b>IID_IStorage</b> to obtain the IStorage interface or for <b>IID_IPropertySetStorage</b> to obtain the
///           IPropertySetStorage interface.
///    ppObjectOpen = The address of an interface pointer variable that receives a pointer for an interface on the storage object
///                   opened; contains <b>NULL</b> if operation failed.
///Returns:
///    This function can also return any file system errors or system errors wrapped in an <b>HRESULT</b>. For more
///    information, see Error Handling Strategies and Handling Unknown Errors.
///    
@DllImport("OLE32")
HRESULT StgOpenStorageEx(const(PWSTR) pwcsName, uint grfMode, uint stgfmt, uint grfAttrs, STGOPTIONS* pStgOptions, 
                         void* pSecurityDescriptor, const(GUID)* riid, void** ppObjectOpen);

///The <b>StgCreatePropStg</b> function creates and opens a property set in a specified storage or stream object. The
///property set supplies the system-provided, stand-alone implementation of the IPropertyStorage interface.
///Params:
///    pUnk = A pointer to the <b>IUnknown</b> interface on the storage or stream object that stores the new property set.
///    fmtid = The FMTID of the property set to be created.
///    pclsid = A Pointer to the initial CLSID for this property set. May be <b>NULL</b>, in which case <i>pclsid</i> is set to
///             all zeroes.
///    grfFlags = The values from PROPSETFLAG Constants that determine how the property set is created and opened.
///    dwReserved = Reserved; must be zero.
///    ppPropStg = The address of an IPropertyStorage* pointer variable that receives the interface pointer to the new property set.
///Returns:
///    This function supports the standard return values E_INVALIDARG and E_UNEXPECTED, in addition to the following:
///    
@DllImport("OLE32")
HRESULT StgCreatePropStg(IUnknown pUnk, const(GUID)* fmtid, const(GUID)* pclsid, uint grfFlags, uint dwReserved, 
                         IPropertyStorage* ppPropStg);

///The <b>StgOpenPropStg</b> function opens a specified property set in a specified storage or stream object. The
///property set supplies the system-provided, stand-alone implementation of the IPropertyStorage interface.
///Params:
///    pUnk = The interface pointer for <b>IUnknown</b> interface on the storage or stream object that contains the requested
///           property set object.
///    fmtid = The FMTID of the property set to be opened.
///    grfFlags = The values from PROPSETFLAG Constants.
///    dwReserved = Reserved for future use; must be zero.
///    ppPropStg = A pointer to an IPropertyStorage* pointer variable that receives the interface pointer to the requested property
///                set.
///Returns:
///    This function supports the standard return values E_INVALIDARG and E_UNEXPECTED, in addition to the following:
///    
@DllImport("OLE32")
HRESULT StgOpenPropStg(IUnknown pUnk, const(GUID)* fmtid, uint grfFlags, uint dwReserved, 
                       IPropertyStorage* ppPropStg);

///The <b>StgCreatePropSetStg</b> function creates a property set storage object from a specified storage object. The
///property set storage object supplies the system-provided, stand-alone implementation of the IPropertySetStorage
///interface.
///Params:
///    pStorage = A pointer to the storage object that contains or will contain one or more property sets.
///    dwReserved = Reserved for future use; must be zero.
///    ppPropSetStg = A pointer to IPropertySetStorage* pointer variable that receives the interface pointer to the property-set
///                   storage object.
///Returns:
///    This function supports the standard return value <b>E_INVALIDARG</b> as well as the following:
///    
@DllImport("OLE32")
HRESULT StgCreatePropSetStg(IStorage pStorage, uint dwReserved, IPropertySetStorage* ppPropSetStg);

///The <b>FmtIdToPropStgName</b> function converts a property set format identifier (FMTID) to its storage or stream
///name.
///Params:
///    pfmtid = A pointer to the FMTID of the property set.
///    oszName = A pointer to a null-terminated string that receives the storage or stream name of the property set identified by
///              <i>pfmtid</i>. The array allocated for this string must be at least CCH_MAX_PROPSTG_NAME (32) characters in
///              length.
///Returns:
///    This function supports the standard return value E_INVALIDARG as well as the following:
///    
@DllImport("OLE32")
HRESULT FmtIdToPropStgName(const(GUID)* pfmtid, PWSTR oszName);

///The <b>PropStgNameToFmtId</b> function converts a property set storage or stream name to its format identifier.
///Params:
///    oszName = A pointer to a null-terminated Unicode string that contains the stream name of a simple property set or the
///              storage name of a nonsimple property set.
///    pfmtid = A pointer to a FMTID variable that receives the format identifier of the property set specified by
///             <i>oszName</i>.
///Returns:
///    This function supports the standard return value E_INVALIDARG as well as the following:
///    
@DllImport("OLE32")
HRESULT PropStgNameToFmtId(const(PWSTR) oszName, GUID* pfmtid);

///The <b>ReadClassStg</b> function reads the CLSID previously written to a storage object with the WriteClassStg
///function.
///Params:
///    pStg = Pointer to the IStorage interface on the storage object containing the CLSID to be retrieved.
///    pclsid = Pointer to where the CLSID is written. May return CLSID_NULL.
///Returns:
///    This function supports the standard return value E_OUTOFMEMORY, in addition to the following: This function also
///    returns any of the error values returned by the IStorage::Stat method.
///    
@DllImport("OLE32")
HRESULT ReadClassStg(IStorage pStg, GUID* pclsid);

///The <b>WriteClassStg</b> function stores the specified class identifier (CLSID) in a storage object.
///Params:
///    pStg = IStorage pointer to the storage object that gets a new CLSID.
///    rclsid = Pointer to the CLSID to be stored with the object.
///Returns:
///    This function returns HRESULT.
///    
@DllImport("OLE32")
HRESULT WriteClassStg(IStorage pStg, const(GUID)* rclsid);

///The <b>ReadClassStm</b> function reads the CLSID previously written to a stream object with the WriteClassStm
///function.
///Params:
///    pStm = A pointer to the IStream interface on the stream object that contains the CLSID to be read. This CLSID must have
///           been previously written to the stream object using WriteClassStm.
///    pclsid = A pointer to where the CLSID is to be written.
///Returns:
///    This function also returns any of the error values returned by the ISequentialStream::Read method.
///    
@DllImport("OLE32")
HRESULT ReadClassStm(IStream pStm, GUID* pclsid);

///The <b>WriteClassStm</b> function stores the specified CLSID in the stream.
///Params:
///    pStm = IStream pointer to the stream into which the CLSID is to be written.
///    rclsid = Specifies the CLSID to write to the stream.
///Returns:
///    This function returns HRESULT.
///    
@DllImport("OLE32")
HRESULT WriteClassStm(IStream pStm, const(GUID)* rclsid);

///The <b>GetHGlobalFromILockBytes</b> function retrieves a global memory handle to a byte array object created using
///the CreateILockBytesOnHGlobal function.
///Params:
///    plkbyt = Pointer to the ILockBytes interface on the byte-array object previously created by a call to the
///             CreateILockBytesOnHGlobal function.
///    phglobal = Pointer to the current memory handle used by the specified byte-array object.
///Returns:
///    This function returns HRESULT.
///    
@DllImport("OLE32")
HRESULT GetHGlobalFromILockBytes(ILockBytes plkbyt, ptrdiff_t* phglobal);

///The <b>CreateILockBytesOnHGlobal</b> function creates a byte array object that uses an HGLOBAL memory handle to store
///the bytes intended for in-memory storage of a compound file. This object is the OLE-provided implementation of the
///ILockBytes interface. The returned byte array object supports both reading and writing, but does not support region
///locking . The object calls the GlobalReAlloc function to grow the memory block as required.
///Params:
///    hGlobal = A memory handle allocated by the GlobalAlloc function, or if <b>NULL</b> a new handle is to be allocated instead.
///              The handle must be allocated as moveable and nondiscardable.
///    fDeleteOnRelease = A flag that specifies whether the underlying handle for this byte array object should be automatically freed when
///                       the object is released. If set to <b>FALSE</b>, the caller must free the <i>hGlobal</i> after the final release.
///                       If set to <b>TRUE</b>, the final release will automatically free the <i>hGlobal</i> parameter.
///    pplkbyt = The address of ILockBytes pointer variable that receives the interface pointer to the new byte array object.
///Returns:
///    This function supports the standard return values <b>E_INVALIDARG</b> and <b>E_OUTOFMEMORY</b>, as well as the
///    following:
///    
@DllImport("OLE32")
HRESULT CreateILockBytesOnHGlobal(ptrdiff_t hGlobal, BOOL fDeleteOnRelease, ILockBytes* pplkbyt);

///The <b>GetConvertStg</b> function returns the current value of the convert bit for the specified storage object.
///Params:
///    pStg = IStorage pointer to the storage object from which the convert bit is to be retrieved.
///Returns:
///    IStorage::OpenStream, IStorage::OpenStorage, and ISequentialStream::Read storage and stream access errors.
///    
@DllImport("OLE32")
HRESULT GetConvertStg(IStorage pStg);

@DllImport("ole32")
uint CoBuildVersion();

@DllImport("ole32")
HRESULT DcomChannelSetHResult(void* pvReserved, uint* pulReserved, HRESULT appsHR);

///<p class="CCE_Message">[The <b>StgOpenAsyncDocfileOnIFillLockBytes</b> function is obsolete. The following
///information is provided to support versions of Windows prior to Windows 2000.] The
///<b>StgOpenAsyncDocfileOnIFillLockBytes</b>opens an existing root asynchronous storage object on a byte-array wrapper
///object provided by the caller.
///Params:
///    pflb = A IFillLockBytes pointer to the byte-array wrapper object that contains the storage object to be opened.
///    grfMode = A value that specifies the access mode to use to open the storage object. The most common access mode, taken from
///              STGM Constants, is STGM_READ.
///    asyncFlags = A value that indicates whether a connection point on a storage is inherited by its substorages and streams.
///                 ASYNC_MODE_COMPATIBILITY indicates that the connection point is inherited; ASYNC_MODE_DEFAULT indicates that the
///                 connection point is not inherited.
///    ppstgOpen = A pointer to IStorage* pointer variable that receives the interface pointer to the root asynchronous storage
///                object.
///Returns:
///    This function supports the standard return values E_OUTOFMEMORY, E_UNEXPECTED, E_INVALIDARG, and E_FAIL, as well
///    as the following:
///    
@DllImport("ole32")
HRESULT StgOpenAsyncDocfileOnIFillLockBytes(IFillLockBytes pflb, uint grfMode, uint asyncFlags, 
                                            IStorage* ppstgOpen);

///<p class="CCE_Message">[The <b>StgGetIFillLockBytesOnILockBytes</b> function is obsolete and the following
///information is provided for versions of Windows prior to Windows 2000.] Creates a new wrapper object on a byte array
///object provided by the caller.
///Params:
///    pilb = Pointer to an existing byte array object.
///    ppflb = Pointer to IFillLockBytes pointer variable that receives the interface pointer to the new byte array wrapper
///            object.
///Returns:
///    This function supports the standard return values E_UNEXPECTED and E_FAIL, as well as the following:
///    
@DllImport("ole32")
HRESULT StgGetIFillLockBytesOnILockBytes(ILockBytes pilb, IFillLockBytes* ppflb);

///<p class="CCE_Message">[The <b>StgGetIFillLockBytesOnFile</b> function is obsolete. The following information is
///provided to support versions of Windows prior to Windows 2000.] The <b>StgGetIFillLockBytesOnFile</b> function opens
///a wrapper object on a temporary file.
///Params:
///    pwcsName = A pointer to the null-terminated unicode string name of the file for which a wrapper object is created.
///    ppflb = A pointer to IFillLockBytes* pointer variable that receives the interface pointer to the new byte array wrapper
///            object.
///Returns:
///    This function supports the standard return values E_OUTOFMEMORY, E_UNEXPECTED, E_INVALIDARG, and E_FAIL, in
///    addition to the following: The <b>StgGetIFillLockBytesOnFile</b> function can also return any file system errors.
///    
@DllImport("ole32")
HRESULT StgGetIFillLockBytesOnFile(const(PWSTR) pwcsName, IFillLockBytes* ppflb);

///Not supported. The <b>StgOpenLayoutDocfile</b> function opens a compound file on an ILockBytes implementation that is
///capable of monitoring sector data. To call <b>StgOpenLayoutDocfile</b>, both DfLayout.dll and DfLayout.lib are
///required. <div class="alert"><b>Note</b> Do not use this function. Use the IStorage::CopyTo method instead.
///<b>CopyTo</b> can be used to layout a docfile, thus improving performance in most scenarios.</div> <div> </div>
///Params:
///    pwcsDfName = A pointer to the null-terminated Unicode string name of the compound file to be opened.
///    grfMode = Access mode to use when opening the newly created storage object. Values are taken from the STGM Constants. Be
///              aware that priority mode and exclusions are not supported. The most common access mode is likely to be
///              STGM_DIRECT | STGM_READ | STGM_SHARE_EXCLUSIVE.
///    reserved = Reserved for future use.
///    ppstgOpen = A pointer to IStorage pointer variable that receives the interface pointer to the root object of the newly
///                created root storage object.
///Returns:
///    This function supports the standard return values E_OUTOFMEMORY, E_UNEXPECTED, E_INVALIDARG, and E_FAIL, in
///    addition to the following: The <b>StgOpenLayoutDocfile</b> function can also return any of the error values
///    returned by the StgOpenStorageOnILockBytes function.
///    
@DllImport("dflayout")
HRESULT StgOpenLayoutDocfile(const(PWSTR) pwcsDfName, uint grfMode, uint reserved, IStorage* ppstgOpen);

///The <b>StgConvertVariantToProperty</b> function converts a <b>PROPVARIANT</b> data type to a
///<b>SERIALIZEDPROPERTYVALUE</b> data type.
///Params:
///    pvar = A pointer to <b>PROPVARIANT</b>.
///    CodePage = A property set codepage.
///    pprop = Optional. A pointer to <b>SERIALIZEDPROPERTYVALUE</b>.
///    pcb = A pointer to the remaining stream length, updated to the actual property size on return.
///    pid = The propid (used if indirect).
///    fReserved = Reserver. The value must be <b>FALSE</b>.
///    pcIndirect = Optional. A pointer to the indirect property count.
///Returns:
///    Returns a pointer to <b>SERIALIZEDPROPERTYVALUE</b>.
///    
@DllImport("ole32")
SERIALIZEDPROPERTYVALUE* StgConvertVariantToProperty(const(PROPVARIANT)* pvar, ushort CodePage, 
                                                     SERIALIZEDPROPERTYVALUE* pprop, uint* pcb, uint pid, 
                                                     ubyte fReserved, uint* pcIndirect);

///The <b>StgConvertPropertyToVariant</b> function converts a <b>SERIALIZEDPROPERTYVALUE</b> data type to a
///<b>PROPVARIANT</b> data type.
///Params:
///    pprop = A pointer to <b>SERIALIZEDPROPERTYVALUE</b>.
///    CodePage = A property set codepage.
///    pvar = A pointer to <b>PROPVARIANT</b>.
///    pma = A pointer to a class that implements the IMemoryAllocator abstract class.
///Returns:
///    Returns <b>TRUE</b> is the property converted was an indirect type (<b>VT_STREAM</b> or
///    <b>VT_STREAMED_OBJECT</b>); otherwise <b>FALSE</b>.
///    
@DllImport("ole32")
ubyte StgConvertPropertyToVariant(const(SERIALIZEDPROPERTYVALUE)* pprop, ushort CodePage, PROPVARIANT* pvar, 
                                  PMemoryAllocator* pma);

@DllImport("ole32")
HRESULT CreateStdProgressIndicator(HWND hwndParent, const(PWSTR) pszTitle, IBindStatusCallback pIbscCaller, 
                                   IBindStatusCallback* ppIbsc);

///The <b>StgPropertyLengthAsVariant</b> function examines a <b>SERIALIZEDPROPERTYVALUE</b> and returns the amount of
///memory that this property would occupy as a <b>PROPVARIANT</b>.
///Params:
///    pProp = A pointer to a <b>SERIALIZEDPROPERTYVALUE</b>.
///    cbProp = The size of the <i>pProp</i> buffer in bytes.
///    CodePage = A property set code page.
///    bReserved = Reserved. Must be 0.
///Returns:
///    Returns the amount of memory the property would occupy as a <b>PROPVARIANT</b>.
///    
@DllImport("ole32")
uint StgPropertyLengthAsVariant(const(SERIALIZEDPROPERTYVALUE)* pProp, uint cbProp, ushort CodePage, 
                                ubyte bReserved);

@DllImport("ESENT")
int JetInit(uint* pinstance);

@DllImport("ESENT")
int JetInit2(uint* pinstance, uint grbit);

@DllImport("ESENT")
int JetInit3A(uint* pinstance, JET_RSTINFO_A* prstInfo, uint grbit);

@DllImport("ESENT")
int JetInit3W(uint* pinstance, JET_RSTINFO_W* prstInfo, uint grbit);

@DllImport("ESENT")
int JetCreateInstanceA(uint* pinstance, byte* szInstanceName);

@DllImport("ESENT")
int JetCreateInstanceW(uint* pinstance, ushort* szInstanceName);

@DllImport("ESENT")
int JetCreateInstance2A(uint* pinstance, byte* szInstanceName, byte* szDisplayName, uint grbit);

@DllImport("ESENT")
int JetCreateInstance2W(uint* pinstance, ushort* szInstanceName, ushort* szDisplayName, uint grbit);

@DllImport("ESENT")
int JetGetInstanceMiscInfo(uint instance, void* pvResult, uint cbMax, uint InfoLevel);

@DllImport("ESENT")
int JetTerm(uint instance);

@DllImport("ESENT")
int JetTerm2(uint instance, uint grbit);

@DllImport("ESENT")
int JetStopService();

@DllImport("ESENT")
int JetStopServiceInstance(uint instance);

@DllImport("ESENT")
int JetStopServiceInstance2(uint instance, const(uint) grbit);

@DllImport("ESENT")
int JetStopBackup();

@DllImport("ESENT")
int JetStopBackupInstance(uint instance);

@DllImport("ESENT")
int JetSetSystemParameterA(uint* pinstance, uint sesid, uint paramid, uint lParam, byte* szParam);

@DllImport("ESENT")
int JetSetSystemParameterW(uint* pinstance, uint sesid, uint paramid, uint lParam, ushort* szParam);

@DllImport("ESENT")
int JetGetSystemParameterA(uint instance, uint sesid, uint paramid, uint* plParam, byte* szParam, uint cbMax);

@DllImport("ESENT")
int JetGetSystemParameterW(uint instance, uint sesid, uint paramid, uint* plParam, ushort* szParam, uint cbMax);

@DllImport("ESENT")
int JetEnableMultiInstanceA(JET_SETSYSPARAM_A* psetsysparam, uint csetsysparam, uint* pcsetsucceed);

@DllImport("ESENT")
int JetEnableMultiInstanceW(JET_SETSYSPARAM_W* psetsysparam, uint csetsysparam, uint* pcsetsucceed);

@DllImport("ESENT")
int JetGetThreadStats(void* pvResult, uint cbMax);

@DllImport("ESENT")
int JetBeginSessionA(uint instance, uint* psesid, byte* szUserName, byte* szPassword);

@DllImport("ESENT")
int JetBeginSessionW(uint instance, uint* psesid, ushort* szUserName, ushort* szPassword);

@DllImport("ESENT")
int JetDupSession(uint sesid, uint* psesid);

@DllImport("ESENT")
int JetEndSession(uint sesid, uint grbit);

@DllImport("ESENT")
int JetGetVersion(uint sesid, uint* pwVersion);

@DllImport("ESENT")
int JetIdle(uint sesid, uint grbit);

@DllImport("ESENT")
int JetCreateDatabaseA(uint sesid, byte* szFilename, byte* szConnect, uint* pdbid, uint grbit);

@DllImport("ESENT")
int JetCreateDatabaseW(uint sesid, ushort* szFilename, ushort* szConnect, uint* pdbid, uint grbit);

@DllImport("ESENT")
int JetCreateDatabase2A(uint sesid, byte* szFilename, const(uint) cpgDatabaseSizeMax, uint* pdbid, uint grbit);

@DllImport("ESENT")
int JetCreateDatabase2W(uint sesid, ushort* szFilename, const(uint) cpgDatabaseSizeMax, uint* pdbid, uint grbit);

@DllImport("ESENT")
int JetAttachDatabaseA(uint sesid, byte* szFilename, uint grbit);

@DllImport("ESENT")
int JetAttachDatabaseW(uint sesid, ushort* szFilename, uint grbit);

@DllImport("ESENT")
int JetAttachDatabase2A(uint sesid, byte* szFilename, const(uint) cpgDatabaseSizeMax, uint grbit);

@DllImport("ESENT")
int JetAttachDatabase2W(uint sesid, ushort* szFilename, const(uint) cpgDatabaseSizeMax, uint grbit);

@DllImport("ESENT")
int JetDetachDatabaseA(uint sesid, byte* szFilename);

@DllImport("ESENT")
int JetDetachDatabaseW(uint sesid, ushort* szFilename);

@DllImport("ESENT")
int JetDetachDatabase2A(uint sesid, byte* szFilename, uint grbit);

@DllImport("ESENT")
int JetDetachDatabase2W(uint sesid, ushort* szFilename, uint grbit);

@DllImport("ESENT")
int JetGetObjectInfoA(uint sesid, uint dbid, uint objtyp, byte* szContainerName, byte* szObjectName, 
                      void* pvResult, uint cbMax, uint InfoLevel);

@DllImport("ESENT")
int JetGetObjectInfoW(uint sesid, uint dbid, uint objtyp, ushort* szContainerName, ushort* szObjectName, 
                      void* pvResult, uint cbMax, uint InfoLevel);

@DllImport("ESENT")
int JetGetTableInfoA(uint sesid, uint tableid, void* pvResult, uint cbMax, uint InfoLevel);

@DllImport("ESENT")
int JetGetTableInfoW(uint sesid, uint tableid, void* pvResult, uint cbMax, uint InfoLevel);

@DllImport("ESENT")
int JetCreateTableA(uint sesid, uint dbid, byte* szTableName, uint lPages, uint lDensity, uint* ptableid);

@DllImport("ESENT")
int JetCreateTableW(uint sesid, uint dbid, ushort* szTableName, uint lPages, uint lDensity, uint* ptableid);

@DllImport("ESENT")
int JetCreateTableColumnIndexA(uint sesid, uint dbid, JET_TABLECREATE_A* ptablecreate);

@DllImport("ESENT")
int JetCreateTableColumnIndexW(uint sesid, uint dbid, JET_TABLECREATE_W* ptablecreate);

@DllImport("ESENT")
int JetCreateTableColumnIndex2A(uint sesid, uint dbid, JET_TABLECREATE2_A* ptablecreate);

@DllImport("ESENT")
int JetCreateTableColumnIndex2W(uint sesid, uint dbid, JET_TABLECREATE2_W* ptablecreate);

@DllImport("ESENT")
int JetCreateTableColumnIndex3A(uint sesid, uint dbid, JET_TABLECREATE3_A* ptablecreate);

@DllImport("ESENT")
int JetCreateTableColumnIndex3W(uint sesid, uint dbid, JET_TABLECREATE3_W* ptablecreate);

@DllImport("ESENT")
int JetCreateTableColumnIndex4A(uint sesid, uint dbid, JET_TABLECREATE4_A* ptablecreate);

@DllImport("ESENT")
int JetCreateTableColumnIndex4W(uint sesid, uint dbid, JET_TABLECREATE4_W* ptablecreate);

@DllImport("ESENT")
int JetDeleteTableA(uint sesid, uint dbid, byte* szTableName);

@DllImport("ESENT")
int JetDeleteTableW(uint sesid, uint dbid, ushort* szTableName);

@DllImport("ESENT")
int JetRenameTableA(uint sesid, uint dbid, byte* szName, byte* szNameNew);

@DllImport("ESENT")
int JetRenameTableW(uint sesid, uint dbid, ushort* szName, ushort* szNameNew);

@DllImport("ESENT")
int JetGetTableColumnInfoA(uint sesid, uint tableid, byte* szColumnName, void* pvResult, uint cbMax, 
                           uint InfoLevel);

@DllImport("ESENT")
int JetGetTableColumnInfoW(uint sesid, uint tableid, ushort* szColumnName, void* pvResult, uint cbMax, 
                           uint InfoLevel);

@DllImport("ESENT")
int JetGetColumnInfoA(uint sesid, uint dbid, byte* szTableName, byte* pColumnNameOrId, void* pvResult, uint cbMax, 
                      uint InfoLevel);

@DllImport("ESENT")
int JetGetColumnInfoW(uint sesid, uint dbid, ushort* szTableName, ushort* pwColumnNameOrId, void* pvResult, 
                      uint cbMax, uint InfoLevel);

@DllImport("ESENT")
int JetAddColumnA(uint sesid, uint tableid, byte* szColumnName, const(JET_COLUMNDEF)* pcolumndef, 
                  const(void)* pvDefault, uint cbDefault, uint* pcolumnid);

@DllImport("ESENT")
int JetAddColumnW(uint sesid, uint tableid, ushort* szColumnName, const(JET_COLUMNDEF)* pcolumndef, 
                  const(void)* pvDefault, uint cbDefault, uint* pcolumnid);

@DllImport("ESENT")
int JetDeleteColumnA(uint sesid, uint tableid, byte* szColumnName);

@DllImport("ESENT")
int JetDeleteColumnW(uint sesid, uint tableid, ushort* szColumnName);

@DllImport("ESENT")
int JetDeleteColumn2A(uint sesid, uint tableid, byte* szColumnName, const(uint) grbit);

@DllImport("ESENT")
int JetDeleteColumn2W(uint sesid, uint tableid, ushort* szColumnName, const(uint) grbit);

@DllImport("ESENT")
int JetRenameColumnA(uint sesid, uint tableid, byte* szName, byte* szNameNew, uint grbit);

@DllImport("ESENT")
int JetRenameColumnW(uint sesid, uint tableid, ushort* szName, ushort* szNameNew, uint grbit);

@DllImport("ESENT")
int JetSetColumnDefaultValueA(uint sesid, uint dbid, byte* szTableName, byte* szColumnName, const(void)* pvData, 
                              const(uint) cbData, const(uint) grbit);

@DllImport("ESENT")
int JetSetColumnDefaultValueW(uint sesid, uint dbid, ushort* szTableName, ushort* szColumnName, 
                              const(void)* pvData, const(uint) cbData, const(uint) grbit);

@DllImport("ESENT")
int JetGetTableIndexInfoA(uint sesid, uint tableid, byte* szIndexName, void* pvResult, uint cbResult, 
                          uint InfoLevel);

@DllImport("ESENT")
int JetGetTableIndexInfoW(uint sesid, uint tableid, ushort* szIndexName, void* pvResult, uint cbResult, 
                          uint InfoLevel);

@DllImport("ESENT")
int JetGetIndexInfoA(uint sesid, uint dbid, byte* szTableName, byte* szIndexName, void* pvResult, uint cbResult, 
                     uint InfoLevel);

@DllImport("ESENT")
int JetGetIndexInfoW(uint sesid, uint dbid, ushort* szTableName, ushort* szIndexName, void* pvResult, 
                     uint cbResult, uint InfoLevel);

@DllImport("ESENT")
int JetCreateIndexA(uint sesid, uint tableid, byte* szIndexName, uint grbit, const(byte)* szKey, uint cbKey, 
                    uint lDensity);

@DllImport("ESENT")
int JetCreateIndexW(uint sesid, uint tableid, ushort* szIndexName, uint grbit, const(PWSTR) szKey, uint cbKey, 
                    uint lDensity);

@DllImport("ESENT")
int JetCreateIndex2A(uint sesid, uint tableid, JET_INDEXCREATE_A* pindexcreate, uint cIndexCreate);

@DllImport("ESENT")
int JetCreateIndex2W(uint sesid, uint tableid, JET_INDEXCREATE_W* pindexcreate, uint cIndexCreate);

@DllImport("ESENT")
int JetCreateIndex3A(uint sesid, uint tableid, JET_INDEXCREATE2_A* pindexcreate, uint cIndexCreate);

@DllImport("ESENT")
int JetCreateIndex3W(uint sesid, uint tableid, JET_INDEXCREATE2_W* pindexcreate, uint cIndexCreate);

@DllImport("ESENT")
int JetCreateIndex4A(uint sesid, uint tableid, JET_INDEXCREATE3_A* pindexcreate, uint cIndexCreate);

@DllImport("ESENT")
int JetCreateIndex4W(uint sesid, uint tableid, JET_INDEXCREATE3_W* pindexcreate, uint cIndexCreate);

@DllImport("ESENT")
int JetDeleteIndexA(uint sesid, uint tableid, byte* szIndexName);

@DllImport("ESENT")
int JetDeleteIndexW(uint sesid, uint tableid, ushort* szIndexName);

@DllImport("ESENT")
int JetBeginTransaction(uint sesid);

@DllImport("ESENT")
int JetBeginTransaction2(uint sesid, uint grbit);

@DllImport("ESENT")
int JetBeginTransaction3(uint sesid, long trxid, uint grbit);

@DllImport("ESENT")
int JetCommitTransaction(uint sesid, uint grbit);

@DllImport("ESENT")
int JetCommitTransaction2(uint sesid, uint grbit, uint cmsecDurableCommit, JET_COMMIT_ID* pCommitId);

@DllImport("ESENT")
int JetRollback(uint sesid, uint grbit);

@DllImport("ESENT")
int JetGetDatabaseInfoA(uint sesid, uint dbid, void* pvResult, uint cbMax, uint InfoLevel);

@DllImport("ESENT")
int JetGetDatabaseInfoW(uint sesid, uint dbid, void* pvResult, uint cbMax, uint InfoLevel);

@DllImport("ESENT")
int JetGetDatabaseFileInfoA(byte* szDatabaseName, void* pvResult, uint cbMax, uint InfoLevel);

@DllImport("ESENT")
int JetGetDatabaseFileInfoW(ushort* szDatabaseName, void* pvResult, uint cbMax, uint InfoLevel);

@DllImport("ESENT")
int JetOpenDatabaseA(uint sesid, byte* szFilename, byte* szConnect, uint* pdbid, uint grbit);

@DllImport("ESENT")
int JetOpenDatabaseW(uint sesid, ushort* szFilename, ushort* szConnect, uint* pdbid, uint grbit);

@DllImport("ESENT")
int JetCloseDatabase(uint sesid, uint dbid, uint grbit);

@DllImport("ESENT")
int JetOpenTableA(uint sesid, uint dbid, byte* szTableName, const(void)* pvParameters, uint cbParameters, 
                  uint grbit, uint* ptableid);

@DllImport("ESENT")
int JetOpenTableW(uint sesid, uint dbid, ushort* szTableName, const(void)* pvParameters, uint cbParameters, 
                  uint grbit, uint* ptableid);

@DllImport("ESENT")
int JetSetTableSequential(uint sesid, uint tableid, uint grbit);

@DllImport("ESENT")
int JetResetTableSequential(uint sesid, uint tableid, uint grbit);

@DllImport("ESENT")
int JetCloseTable(uint sesid, uint tableid);

@DllImport("ESENT")
int JetDelete(uint sesid, uint tableid);

@DllImport("ESENT")
int JetUpdate(uint sesid, uint tableid, void* pvBookmark, uint cbBookmark, uint* pcbActual);

@DllImport("ESENT")
int JetUpdate2(uint sesid, uint tableid, void* pvBookmark, uint cbBookmark, uint* pcbActual, const(uint) grbit);

@DllImport("ESENT")
int JetEscrowUpdate(uint sesid, uint tableid, uint columnid, void* pv, uint cbMax, void* pvOld, uint cbOldMax, 
                    uint* pcbOldActual, uint grbit);

@DllImport("ESENT")
int JetRetrieveColumn(uint sesid, uint tableid, uint columnid, void* pvData, uint cbData, uint* pcbActual, 
                      uint grbit, JET_RETINFO* pretinfo);

@DllImport("ESENT")
int JetRetrieveColumns(uint sesid, uint tableid, JET_RETRIEVECOLUMN* pretrievecolumn, uint cretrievecolumn);

@DllImport("ESENT")
int JetEnumerateColumns(uint sesid, uint tableid, uint cEnumColumnId, JET_ENUMCOLUMNID* rgEnumColumnId, 
                        uint* pcEnumColumn, JET_ENUMCOLUMN** prgEnumColumn, JET_PFNREALLOC pfnRealloc, 
                        void* pvReallocContext, uint cbDataMost, uint grbit);

@DllImport("ESENT")
int JetGetRecordSize(uint sesid, uint tableid, JET_RECSIZE* precsize, const(uint) grbit);

@DllImport("ESENT")
int JetGetRecordSize2(uint sesid, uint tableid, JET_RECSIZE2* precsize, const(uint) grbit);

@DllImport("ESENT")
int JetSetColumn(uint sesid, uint tableid, uint columnid, const(void)* pvData, uint cbData, uint grbit, 
                 JET_SETINFO* psetinfo);

@DllImport("ESENT")
int JetSetColumns(uint sesid, uint tableid, JET_SETCOLUMN* psetcolumn, uint csetcolumn);

@DllImport("ESENT")
int JetPrepareUpdate(uint sesid, uint tableid, uint prep);

@DllImport("ESENT")
int JetGetRecordPosition(uint sesid, uint tableid, JET_RECPOS* precpos, uint cbRecpos);

@DllImport("ESENT")
int JetGotoPosition(uint sesid, uint tableid, JET_RECPOS* precpos);

@DllImport("ESENT")
int JetGetCursorInfo(uint sesid, uint tableid, void* pvResult, uint cbMax, uint InfoLevel);

@DllImport("ESENT")
int JetDupCursor(uint sesid, uint tableid, uint* ptableid, uint grbit);

@DllImport("ESENT")
int JetGetCurrentIndexA(uint sesid, uint tableid, byte* szIndexName, uint cbIndexName);

@DllImport("ESENT")
int JetGetCurrentIndexW(uint sesid, uint tableid, ushort* szIndexName, uint cbIndexName);

@DllImport("ESENT")
int JetSetCurrentIndexA(uint sesid, uint tableid, byte* szIndexName);

@DllImport("ESENT")
int JetSetCurrentIndexW(uint sesid, uint tableid, ushort* szIndexName);

@DllImport("ESENT")
int JetSetCurrentIndex2A(uint sesid, uint tableid, byte* szIndexName, uint grbit);

@DllImport("ESENT")
int JetSetCurrentIndex2W(uint sesid, uint tableid, ushort* szIndexName, uint grbit);

@DllImport("ESENT")
int JetSetCurrentIndex3A(uint sesid, uint tableid, byte* szIndexName, uint grbit, uint itagSequence);

@DllImport("ESENT")
int JetSetCurrentIndex3W(uint sesid, uint tableid, ushort* szIndexName, uint grbit, uint itagSequence);

@DllImport("ESENT")
int JetSetCurrentIndex4A(uint sesid, uint tableid, byte* szIndexName, JET_INDEXID* pindexid, uint grbit, 
                         uint itagSequence);

@DllImport("ESENT")
int JetSetCurrentIndex4W(uint sesid, uint tableid, ushort* szIndexName, JET_INDEXID* pindexid, uint grbit, 
                         uint itagSequence);

@DllImport("ESENT")
int JetMove(uint sesid, uint tableid, int cRow, uint grbit);

@DllImport("ESENT")
int JetSetCursorFilter(uint sesid, uint tableid, JET_INDEX_COLUMN* rgColumnFilters, uint cColumnFilters, 
                       uint grbit);

@DllImport("ESENT")
int JetGetLock(uint sesid, uint tableid, uint grbit);

@DllImport("ESENT")
int JetMakeKey(uint sesid, uint tableid, const(void)* pvData, uint cbData, uint grbit);

@DllImport("ESENT")
int JetSeek(uint sesid, uint tableid, uint grbit);

@DllImport("ESENT")
int JetPrereadKeys(uint sesid, uint tableid, const(void)** rgpvKeys, const(uint)* rgcbKeys, int ckeys, 
                   int* pckeysPreread, uint grbit);

@DllImport("ESENT")
int JetPrereadIndexRanges(uint sesid, uint tableid, const(JET_INDEX_RANGE)* rgIndexRanges, 
                          const(uint) cIndexRanges, uint* pcRangesPreread, const(uint)* rgcolumnidPreread, 
                          const(uint) ccolumnidPreread, uint grbit);

@DllImport("ESENT")
int JetGetBookmark(uint sesid, uint tableid, void* pvBookmark, uint cbMax, uint* pcbActual);

@DllImport("ESENT")
int JetGetSecondaryIndexBookmark(uint sesid, uint tableid, void* pvSecondaryKey, uint cbSecondaryKeyMax, 
                                 uint* pcbSecondaryKeyActual, void* pvPrimaryBookmark, uint cbPrimaryBookmarkMax, 
                                 uint* pcbPrimaryBookmarkActual, const(uint) grbit);

@DllImport("ESENT")
int JetCompactA(uint sesid, byte* szDatabaseSrc, byte* szDatabaseDest, JET_PFNSTATUS pfnStatus, 
                tagCONVERT_A* pconvert, uint grbit);

@DllImport("ESENT")
int JetCompactW(uint sesid, ushort* szDatabaseSrc, ushort* szDatabaseDest, JET_PFNSTATUS pfnStatus, 
                tagCONVERT_W* pconvert, uint grbit);

@DllImport("ESENT")
int JetDefragmentA(uint sesid, uint dbid, byte* szTableName, uint* pcPasses, uint* pcSeconds, uint grbit);

@DllImport("ESENT")
int JetDefragmentW(uint sesid, uint dbid, ushort* szTableName, uint* pcPasses, uint* pcSeconds, uint grbit);

@DllImport("ESENT")
int JetDefragment2A(uint sesid, uint dbid, byte* szTableName, uint* pcPasses, uint* pcSeconds, 
                    JET_CALLBACK callback, uint grbit);

@DllImport("ESENT")
int JetDefragment2W(uint sesid, uint dbid, ushort* szTableName, uint* pcPasses, uint* pcSeconds, 
                    JET_CALLBACK callback, uint grbit);

@DllImport("ESENT")
int JetDefragment3A(uint sesid, byte* szDatabaseName, byte* szTableName, uint* pcPasses, uint* pcSeconds, 
                    JET_CALLBACK callback, void* pvContext, uint grbit);

@DllImport("ESENT")
int JetDefragment3W(uint sesid, ushort* szDatabaseName, ushort* szTableName, uint* pcPasses, uint* pcSeconds, 
                    JET_CALLBACK callback, void* pvContext, uint grbit);

@DllImport("ESENT")
int JetSetDatabaseSizeA(uint sesid, byte* szDatabaseName, uint cpg, uint* pcpgReal);

@DllImport("ESENT")
int JetSetDatabaseSizeW(uint sesid, ushort* szDatabaseName, uint cpg, uint* pcpgReal);

@DllImport("ESENT")
int JetGrowDatabase(uint sesid, uint dbid, uint cpg, uint* pcpgReal);

@DllImport("ESENT")
int JetResizeDatabase(uint sesid, uint dbid, uint cpgTarget, uint* pcpgActual, const(uint) grbit);

@DllImport("ESENT")
int JetSetSessionContext(uint sesid, uint ulContext);

@DllImport("ESENT")
int JetResetSessionContext(uint sesid);

@DllImport("ESENT")
int JetGotoBookmark(uint sesid, uint tableid, void* pvBookmark, uint cbBookmark);

@DllImport("ESENT")
int JetGotoSecondaryIndexBookmark(uint sesid, uint tableid, void* pvSecondaryKey, uint cbSecondaryKey, 
                                  void* pvPrimaryBookmark, uint cbPrimaryBookmark, const(uint) grbit);

@DllImport("ESENT")
int JetIntersectIndexes(uint sesid, JET_INDEXRANGE* rgindexrange, uint cindexrange, JET_RECORDLIST* precordlist, 
                        uint grbit);

@DllImport("ESENT")
int JetComputeStats(uint sesid, uint tableid);

@DllImport("ESENT")
int JetOpenTempTable(uint sesid, const(JET_COLUMNDEF)* prgcolumndef, uint ccolumn, uint grbit, uint* ptableid, 
                     uint* prgcolumnid);

@DllImport("ESENT")
int JetOpenTempTable2(uint sesid, const(JET_COLUMNDEF)* prgcolumndef, uint ccolumn, uint lcid, uint grbit, 
                      uint* ptableid, uint* prgcolumnid);

@DllImport("ESENT")
int JetOpenTempTable3(uint sesid, const(JET_COLUMNDEF)* prgcolumndef, uint ccolumn, JET_UNICODEINDEX* pidxunicode, 
                      uint grbit, uint* ptableid, uint* prgcolumnid);

@DllImport("ESENT")
int JetOpenTemporaryTable(uint sesid, JET_OPENTEMPORARYTABLE* popentemporarytable);

@DllImport("ESENT")
int JetOpenTemporaryTable2(uint sesid, JET_OPENTEMPORARYTABLE2* popentemporarytable);

@DllImport("ESENT")
int JetBackupA(byte* szBackupPath, uint grbit, JET_PFNSTATUS pfnStatus);

@DllImport("ESENT")
int JetBackupW(ushort* szBackupPath, uint grbit, JET_PFNSTATUS pfnStatus);

@DllImport("ESENT")
int JetBackupInstanceA(uint instance, byte* szBackupPath, uint grbit, JET_PFNSTATUS pfnStatus);

@DllImport("ESENT")
int JetBackupInstanceW(uint instance, ushort* szBackupPath, uint grbit, JET_PFNSTATUS pfnStatus);

@DllImport("ESENT")
int JetRestoreA(byte* szSource, JET_PFNSTATUS pfn);

@DllImport("ESENT")
int JetRestoreW(ushort* szSource, JET_PFNSTATUS pfn);

@DllImport("ESENT")
int JetRestore2A(byte* sz, byte* szDest, JET_PFNSTATUS pfn);

@DllImport("ESENT")
int JetRestore2W(ushort* sz, ushort* szDest, JET_PFNSTATUS pfn);

@DllImport("ESENT")
int JetRestoreInstanceA(uint instance, byte* sz, byte* szDest, JET_PFNSTATUS pfn);

@DllImport("ESENT")
int JetRestoreInstanceW(uint instance, ushort* sz, ushort* szDest, JET_PFNSTATUS pfn);

@DllImport("ESENT")
int JetSetIndexRange(uint sesid, uint tableidSrc, uint grbit);

@DllImport("ESENT")
int JetIndexRecordCount(uint sesid, uint tableid, uint* pcrec, uint crecMax);

@DllImport("ESENT")
int JetRetrieveKey(uint sesid, uint tableid, void* pvKey, uint cbMax, uint* pcbActual, uint grbit);

@DllImport("ESENT")
int JetBeginExternalBackup(uint grbit);

@DllImport("ESENT")
int JetBeginExternalBackupInstance(uint instance, uint grbit);

@DllImport("ESENT")
int JetGetAttachInfoA(byte* szzDatabases, uint cbMax, uint* pcbActual);

@DllImport("ESENT")
int JetGetAttachInfoW(ushort* wszzDatabases, uint cbMax, uint* pcbActual);

@DllImport("ESENT")
int JetGetAttachInfoInstanceA(uint instance, byte* szzDatabases, uint cbMax, uint* pcbActual);

@DllImport("ESENT")
int JetGetAttachInfoInstanceW(uint instance, ushort* szzDatabases, uint cbMax, uint* pcbActual);

@DllImport("ESENT")
int JetOpenFileA(byte* szFileName, uint* phfFile, uint* pulFileSizeLow, uint* pulFileSizeHigh);

@DllImport("ESENT")
int JetOpenFileW(ushort* szFileName, uint* phfFile, uint* pulFileSizeLow, uint* pulFileSizeHigh);

@DllImport("ESENT")
int JetOpenFileInstanceA(uint instance, byte* szFileName, uint* phfFile, uint* pulFileSizeLow, 
                         uint* pulFileSizeHigh);

@DllImport("ESENT")
int JetOpenFileInstanceW(uint instance, ushort* szFileName, uint* phfFile, uint* pulFileSizeLow, 
                         uint* pulFileSizeHigh);

@DllImport("ESENT")
int JetReadFile(uint hfFile, void* pv, uint cb, uint* pcbActual);

@DllImport("ESENT")
int JetReadFileInstance(uint instance, uint hfFile, void* pv, uint cb, uint* pcbActual);

@DllImport("ESENT")
int JetCloseFile(uint hfFile);

@DllImport("ESENT")
int JetCloseFileInstance(uint instance, uint hfFile);

@DllImport("ESENT")
int JetGetLogInfoA(byte* szzLogs, uint cbMax, uint* pcbActual);

@DllImport("ESENT")
int JetGetLogInfoW(ushort* szzLogs, uint cbMax, uint* pcbActual);

@DllImport("ESENT")
int JetGetLogInfoInstanceA(uint instance, byte* szzLogs, uint cbMax, uint* pcbActual);

@DllImport("ESENT")
int JetGetLogInfoInstanceW(uint instance, ushort* wszzLogs, uint cbMax, uint* pcbActual);

@DllImport("ESENT")
int JetGetLogInfoInstance2A(uint instance, byte* szzLogs, uint cbMax, uint* pcbActual, JET_LOGINFO_A* pLogInfo);

@DllImport("ESENT")
int JetGetLogInfoInstance2W(uint instance, ushort* wszzLogs, uint cbMax, uint* pcbActual, JET_LOGINFO_W* pLogInfo);

@DllImport("ESENT")
int JetGetTruncateLogInfoInstanceA(uint instance, byte* szzLogs, uint cbMax, uint* pcbActual);

@DllImport("ESENT")
int JetGetTruncateLogInfoInstanceW(uint instance, ushort* wszzLogs, uint cbMax, uint* pcbActual);

@DllImport("ESENT")
int JetTruncateLog();

@DllImport("ESENT")
int JetTruncateLogInstance(uint instance);

@DllImport("ESENT")
int JetEndExternalBackup();

@DllImport("ESENT")
int JetEndExternalBackupInstance(uint instance);

@DllImport("ESENT")
int JetEndExternalBackupInstance2(uint instance, uint grbit);

@DllImport("ESENT")
int JetExternalRestoreA(byte* szCheckpointFilePath, byte* szLogPath, JET_RSTMAP_A* rgrstmap, int crstfilemap, 
                        byte* szBackupLogPath, int genLow, int genHigh, JET_PFNSTATUS pfn);

@DllImport("ESENT")
int JetExternalRestoreW(ushort* szCheckpointFilePath, ushort* szLogPath, JET_RSTMAP_W* rgrstmap, int crstfilemap, 
                        ushort* szBackupLogPath, int genLow, int genHigh, JET_PFNSTATUS pfn);

@DllImport("ESENT")
int JetExternalRestore2A(byte* szCheckpointFilePath, byte* szLogPath, JET_RSTMAP_A* rgrstmap, int crstfilemap, 
                         byte* szBackupLogPath, JET_LOGINFO_A* pLogInfo, byte* szTargetInstanceName, 
                         byte* szTargetInstanceLogPath, byte* szTargetInstanceCheckpointPath, JET_PFNSTATUS pfn);

@DllImport("ESENT")
int JetExternalRestore2W(ushort* szCheckpointFilePath, ushort* szLogPath, JET_RSTMAP_W* rgrstmap, int crstfilemap, 
                         ushort* szBackupLogPath, JET_LOGINFO_W* pLogInfo, ushort* szTargetInstanceName, 
                         ushort* szTargetInstanceLogPath, ushort* szTargetInstanceCheckpointPath, JET_PFNSTATUS pfn);

@DllImport("ESENT")
int JetRegisterCallback(uint sesid, uint tableid, uint cbtyp, JET_CALLBACK pCallback, void* pvContext, 
                        uint* phCallbackId);

@DllImport("ESENT")
int JetUnregisterCallback(uint sesid, uint tableid, uint cbtyp, uint hCallbackId);

@DllImport("ESENT")
int JetGetInstanceInfoA(uint* pcInstanceInfo, JET_INSTANCE_INFO_A** paInstanceInfo);

@DllImport("ESENT")
int JetGetInstanceInfoW(uint* pcInstanceInfo, JET_INSTANCE_INFO_W** paInstanceInfo);

@DllImport("ESENT")
int JetFreeBuffer(byte* pbBuf);

@DllImport("ESENT")
int JetSetLS(uint sesid, uint tableid, uint ls, uint grbit);

@DllImport("ESENT")
int JetGetLS(uint sesid, uint tableid, uint* pls, uint grbit);

@DllImport("ESENT")
int JetOSSnapshotPrepare(uint* psnapId, const(uint) grbit);

@DllImport("ESENT")
int JetOSSnapshotPrepareInstance(uint snapId, uint instance, const(uint) grbit);

@DllImport("ESENT")
int JetOSSnapshotFreezeA(const(uint) snapId, uint* pcInstanceInfo, JET_INSTANCE_INFO_A** paInstanceInfo, 
                         const(uint) grbit);

@DllImport("ESENT")
int JetOSSnapshotFreezeW(const(uint) snapId, uint* pcInstanceInfo, JET_INSTANCE_INFO_W** paInstanceInfo, 
                         const(uint) grbit);

@DllImport("ESENT")
int JetOSSnapshotThaw(const(uint) snapId, const(uint) grbit);

@DllImport("ESENT")
int JetOSSnapshotAbort(const(uint) snapId, const(uint) grbit);

@DllImport("ESENT")
int JetOSSnapshotTruncateLog(const(uint) snapId, const(uint) grbit);

@DllImport("ESENT")
int JetOSSnapshotTruncateLogInstance(const(uint) snapId, uint instance, const(uint) grbit);

@DllImport("ESENT")
int JetOSSnapshotGetFreezeInfoA(const(uint) snapId, uint* pcInstanceInfo, JET_INSTANCE_INFO_A** paInstanceInfo, 
                                const(uint) grbit);

@DllImport("ESENT")
int JetOSSnapshotGetFreezeInfoW(const(uint) snapId, uint* pcInstanceInfo, JET_INSTANCE_INFO_W** paInstanceInfo, 
                                const(uint) grbit);

@DllImport("ESENT")
int JetOSSnapshotEnd(const(uint) snapId, const(uint) grbit);

@DllImport("ESENT")
int JetConfigureProcessForCrashDump(const(uint) grbit);

@DllImport("ESENT")
int JetGetErrorInfoW(void* pvContext, void* pvResult, uint cbMax, uint InfoLevel, uint grbit);

@DllImport("ESENT")
int JetSetSessionParameter(uint sesid, uint sesparamid, void* pvParam, uint cbParam);

@DllImport("ESENT")
int JetGetSessionParameter(uint sesid, uint sesparamid, void* pvParam, uint cbParamMax, uint* pcbParamActual);

///The <b>CreateStreamOnHGlobal</b>function creates a stream object that uses an HGLOBAL memory handle to store the
///stream contents. This object is the OLE-provided implementation of the IStream interface. The returned stream object
///supports both reading and writing, is not transacted, and does not support region locking. The object calls the
///GlobalReAlloc function to grow the memory block as required. <div class="alert"><b>Tip</b> Consider using the
///SHCreateMemStream function, which produces better performance, or for Windows Store apps, consider using
///InMemoryRandomAccessStream.</div> <div> </div>
///Params:
///    hGlobal = A memory handle allocated by the GlobalAlloc function, or if <b>NULL</b> a new handle is to be allocated instead.
///              The handle must be allocated as moveable and nondiscardable.
///    fDeleteOnRelease = A value that indicates whether the underlying handle for this stream object should be automatically freed when
///                       the stream object is released. If set to <b>FALSE</b>, the caller must free the <i>hGlobal</i> after the final
///                       release. If set to <b>TRUE</b>, the final release will automatically free the underlying handle. See the Remarks
///                       for further discussion of the case where <i>fDeleteOnRelease</i> is <b>FALSE</b>.
///    ppstm = The address of IStream* pointer variable that receives the interface pointer to the new stream object. Its value
///            cannot be <b>NULL</b>.
///Returns:
///    This function supports the standard return values E_INVALIDARG and E_OUTOFMEMORY, as well as the following.
///    
@DllImport("OLE32")
HRESULT CreateStreamOnHGlobal(ptrdiff_t hGlobal, BOOL fDeleteOnRelease, IStream* ppstm);

///The <b>GetHGlobalFromStream</b> function retrieves the global memory handle to a stream that was created through a
///call to the CreateStreamOnHGlobal function.
///Params:
///    pstm = IStream pointer to the stream object previously created by a call to the CreateStreamOnHGlobal function.
///    phglobal = Pointer to the current memory handle used by the specified stream object.
///Returns:
///    This function returns HRESULT.
///    
@DllImport("OLE32")
HRESULT GetHGlobalFromStream(IStream pstm, ptrdiff_t* phglobal);

///Creates a copy of a PROPVARIANT structure.
///Params:
///    pvarDest = Type: <b>PROPVARIANT*</b> Pointer to the destination PROPVARIANT structure that receives the copy.
///    pvarSrc = Type: <b>const PROPVARIANT*</b> Pointer to the source PROPVARIANT structure.
@DllImport("OLE32")
HRESULT PropVariantCopy(PROPVARIANT* pvarDest, const(PROPVARIANT)* pvarSrc);

///Clears a PROPVARIANT structure.
///Params:
///    pvar = Type: <b>PROPVARIANT*</b> Pointer to the PROPVARIANT structure to clear. When this function successfully returns,
///           the <b>PROPVARIANT</b> is zeroed and the type is set to VT_EMPTY.
@DllImport("OLE32")
HRESULT PropVariantClear(PROPVARIANT* pvar);

///Frees the memory and references used by an array of PROPVARIANT structures.
///Params:
///    cVariants = Type: <b>ULONG</b> The number of elements in the array specified by <i>rgvars</i>.
///    rgvars = Type: <b>PROPVARIANT*</b> Array of PROPVARIANT structures to free. When this function successfully returns, the
///             <b>PROPVARIANT</b> structures in the array are zeroed and their type is set to VT_EMPTY.
///Returns:
///    Type: <b>HRESULT</b> If this function succeeds, it returns <b
///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
///    
@DllImport("OLE32")
HRESULT FreePropVariantArray(uint cVariants, PROPVARIANT* rgvars);

///The <b>WriteFmtUserTypeStg</b> function writes a clipboard format and user type to the storage object.
///Params:
///    pstg = IStorage pointer to the storage object where the information is to be written.
///    cf = Specifies the clipboard format that describes the structure of the native area of the storage object. The format
///         tag includes the policy for the names of streams and substorages within this storage object and the rules for
///         interpreting data within those streams.
///    lpszUserType = Pointer to a null-terminated Unicode string that specifies the object's current user type. The user type value,
///                   itself, cannot be <b>NULL</b>. This is the type returned by the IOleObject::GetUserType method. If this function
///                   is transported to a remote machine where the object class does not exist, this persistently stored user type can
///                   be shown to the user in dialog boxes.
///Returns:
///    This function returns HRESULT.
///    
@DllImport("OLE32")
HRESULT WriteFmtUserTypeStg(IStorage pstg, ushort cf, PWSTR lpszUserType);

///The <b>ReadFmtUserTypeStg</b> function returns the clipboard format and user type previously saved with the
///WriteFmtUserTypeStg function.
///Params:
///    pstg = Pointer to the IStorage interface on the storage object from which the information is to be read.
///    pcf = Pointer to where the clipboard format is to be written on return. It can be <b>NULL</b>, indicating the format is
///          of no interest to the caller.
///    lplpszUserType = Address of <b>LPWSTR</b> pointer variable that receives a pointer to the null-terminated Unicode user-type
///                     string. The caller can specify <b>NULL</b> for this parameter, which indicates that the user type is of no
///                     interest. This function allocates memory for the string. The caller is responsible for freeing the memory with
///                     CoTaskMemFree.
///Returns:
///    This function supports the standard return values E_FAIL, E_INVALIDARG, and E_OUTOFMEMORY, in addition to the
///    following: This function also returns any of the error values returned by the ISequentialStream::Read method.
///    
@DllImport("OLE32")
HRESULT ReadFmtUserTypeStg(IStorage pstg, ushort* pcf, PWSTR* lplpszUserType);

///The <b>OleConvertOLESTREAMToIStorage</b> function converts the specified object from the OLE 1 storage model to an
///OLE 2 structured storage object without specifying presentation data. <div class="alert"><b>Note</b> This is one of
///several compatibility functions.</div><div> </div>
///Params:
///    lpolestream = A pointer to a stream that contains the persistent representation of the object in the OLE 1 storage format.
///    pstg = A pointer to the IStorage interface on the OLE 2 structured storage object.
///    ptd = A pointer to the DVTARGETDEVICE structure that specifies the target device for which the OLE 1 object is
///          rendered.
///Returns:
///    This function supports the standard return value <b>E_INVALIDARG</b>, in addition to the following:
///    
@DllImport("ole32")
HRESULT OleConvertOLESTREAMToIStorage(OLESTREAM* lpolestream, IStorage pstg, const(DVTARGETDEVICE)* ptd);

///The <b>OleConvertIStorageToOLESTREAM</b> function converts the specified storage object from OLE 2 structured storage
///to the OLE 1 storage object model but does not include the presentation data. This is one of several compatibility
///functions.
///Params:
///    pstg = Pointer to the IStorage interface on the storage object to be converted to an OLE 1 storage.
///    lpolestream = Pointer to an OLE 1 stream structure where the persistent representation of the object is saved using the OLE 1
///                  storage model.
///Returns:
///    This function supports the standard return value E_INVALIDARG, in addition to the following:
///    
@DllImport("ole32")
HRESULT OleConvertIStorageToOLESTREAM(IStorage pstg, OLESTREAM* lpolestream);

///The <b>SetConvertStg</b> function sets the convert bit in a storage object to indicate that the object is to be
///converted to a new class when it is opened. The setting can be retrieved with a call to the GetConvertStg function.
///Params:
///    pStg = IStorage pointer to the storage object in which to set the conversion bit.
///    fConvert = If <b>TRUE</b>, sets the conversion bit for the object to indicate the object is to be converted when opened. If
///               <b>FALSE</b>, clears the conversion bit.
///Returns:
///    See the IStorage::CreateStream, IStorage::OpenStream, ISequentialStream::Read, and ISequentialStream::Write
///    methods for possible storage and stream access errors.
///    
@DllImport("OLE32")
HRESULT SetConvertStg(IStorage pStg, BOOL fConvert);

///The <b>OleConvertIStorageToOLESTREAMEx</b> function converts the specified storage object from OLE 2 structured
///storage to the OLE 1 storage object model, including the presentation data. This is one of several functions included
///in Structured Storage to ensure compatibility between OLE1 and OLE2.
///Params:
///    pstg = Pointer to the IStorage interface on the storage object to be converted to an OLE 1 storage.
///    cfFormat = Format of the presentation data. May be <b>NULL</b>, in which case the <i>lWidth</i>, <i>lHeight</i>,
///               <i>dwSize</i>, and <i>pmedium</i> parameters are ignored.
///    lWidth = Width of the object presentation data in HIMETRIC units.
///    lHeight = Height of the object presentation data in HIMETRIC units.
///    dwSize = Size of the data, in bytes, to be converted.
///    pmedium = Pointer to the STGMEDIUM structure for the serialized data to be converted.
///    polestm = Pointer to a stream where the persistent representation of the object is saved using the OLE 1 storage model.
///Returns:
///    This function supports the standard return value E_INVALIDARG, in addition to the following:
///    
@DllImport("ole32")
HRESULT OleConvertIStorageToOLESTREAMEx(IStorage pstg, ushort cfFormat, int lWidth, int lHeight, uint dwSize, 
                                        STGMEDIUM* pmedium, OLESTREAM* polestm);

///The <b>OleConvertOLESTREAMToIStorageEx</b> function converts the specified object from the OLE 1 storage model to an
///OLE 2 structured storage object including presentation data. This is one of several compatibility functions.
///Params:
///    polestm = Pointer to the stream that contains the persistent representation of the object in the OLE 1 storage format.
///    pstg = Pointer to the OLE 2 structured storage object.
///    pcfFormat = Pointer to where the format of the presentation data is returned. May be <b>NULL</b>, indicating the absence of
///                presentation data.
///    plwWidth = Pointer to where the width value (in HIMETRIC) of the presentation data is returned.
///    plHeight = Pointer to where the height value (in HIMETRIC) of the presentation data is returned.
///    pdwSize = Pointer to where the size in bytes of the converted data is returned.
///    pmedium = Pointer to where the STGMEDIUM structure for the converted serialized data is returned.
///Returns:
///    This function returns HRESULT.
///    
@DllImport("ole32")
HRESULT OleConvertOLESTREAMToIStorageEx(OLESTREAM* polestm, IStorage pstg, ushort* pcfFormat, int* plwWidth, 
                                        int* plHeight, uint* pdwSize, STGMEDIUM* pmedium);

///The <b>StgSerializePropVariant</b> function converts a <b>PROPVARIANT</b> data type to a
///<b>SERIALIZEDPROPERTYVALUE</b> data type.
///Params:
///    ppropvar = A pointer to <b>PROPVARIANT</b>.
///    ppProp = A pointer to the newly allocated <b>SERIALIZEDPROPERTYVALUE</b>.
///    pcb = A pointer to the size of the newly allocated <b>SERIALIZEDPROPERTYVALUE</b>.
///Returns:
///    This function can return one of these values.
///    
@DllImport("PROPSYS")
HRESULT StgSerializePropVariant(const(PROPVARIANT)* ppropvar, SERIALIZEDPROPERTYVALUE** ppProp, uint* pcb);

///The <b>StgDeserializePropVariant</b> function converts a SERIALIZEDPROPERTYVALUE data type to a PROPVARIANT data
///type.
///Params:
///    pprop = A pointer to the <b>SERIALIZEDPROPERTYVALUE</b> buffer.
///    cbMax = The size of the <i>pprop</i> buffer in bytes.
///    ppropvar = A pointer to a <b>PROPVARIANT</b>.
///Returns:
///    This function can return one of these values.
///    
@DllImport("PROPSYS")
HRESULT StgDeserializePropVariant(const(SERIALIZEDPROPERTYVALUE)* pprop, uint cbMax, PROPVARIANT* ppropvar);


// Interfaces

///The <b>IPropertyStorage</b> interface manages the persistent properties of a single property set. Persistent
///properties consist of information that can be stored persistently in a property set, such as the summary information
///associated with a file. This contrasts with run-time properties associated with Controls and Automation, which can be
///used to affect system behavior. Use the methods of the IPropertySetStorage interface to create or open a persistent
///property set. An instance of the <b>IPropertySetStorage</b> interface can manage zero or more <b>IPropertyStorage</b>
///instances. Each property within a property set is identified by a property identifier (ID), a four-byte <b>ULONG</b>
///value unique to that set. You can also assign a string name to a property through the <b>IPropertyStorage</b>
///interface. Property IDs differ from the dispatch IDs used in Automation <b>dispid</b> property name tags. One
///difference is that the general-purpose use of property ID values zero and one is prohibited in
///<b>IPropertyStorage</b>, while no such restriction exists in <b>IDispatch</b>. In addition, while there is
///significant overlap among the data types for property values that may be used in <b>IPropertyStorage</b> and
///<b>IDispatch</b>, the property sets are not identical. Persistent property data types used in <b>IPropertyStorage</b>
///methods are defined in the PROPVARIANT structure. The <b>IPropertyStorage</b> interface can be used to access both
///simple and nonsimple property sets. Nonsimple property sets can hold several complex property types that cannot be
///held in a simple property set. For more information see Storage and Stream Objects for a Property Set.
@GUID("00000138-0000-0000-C000-000000000046")
interface IPropertyStorage : IUnknown
{
    ///The <b>ReadMultiple</b> method reads specified properties from the current property set.
    ///Params:
    ///    cpspec = The numeric count of properties to be specified in the <i>rgpspec</i> array. The value of this parameter can
    ///             be set to zero; however, that defeats the purpose of the method as no properties are thereby read, regardless
    ///             of the values set in <i>rgpspec</i>.
    ///    rgpspec = An array of PROPSPEC structures specifies which properties are read. Properties can be specified either by a
    ///              property ID or by an optional string name. It is not necessary to specify properties in any particular order
    ///              in the array. The array can contain duplicate properties, resulting in duplicate property values on return
    ///              for simple properties. Nonsimple properties should return access denied on an attempt to open them a second
    ///              time. The array can contain a mixture of property IDs and string IDs.
    ///    rgpropvar = Caller-allocated array of a PROPVARIANT structure that, on return, contains the values of the properties
    ///                specified by the corresponding elements in the <i>rgpspec</i> array. The array must be at least large enough
    ///                to hold values of the <i>cpspec</i> parameter of the <b>PROPVARIANT</b> structure. The <i>cpspec</i>
    ///                parameter specifies the number of properties set in the array. The caller is not required to initialize these
    ///                <b>PROPVARIANT</b> structure values in any specific order. However, the implementation must fill all members
    ///                correctly on return. If there is no other appropriate value, the implementation must set the <b>vt</b> member
    ///                of each <b>PROPVARIANT</b> structure to <b>VT_EMPTY</b>.
    ///Returns:
    ///    This method supports the standard return value <b>E_UNEXPECTED</b>, as well as the following: This function
    ///    can also return any file system errors or Win32 errors wrapped in an <b>HRESULT</b> data type. For more
    ///    information, see Error Handling Strategies. For more information, see Property Storage Considerations.
    ///    
    HRESULT ReadMultiple(uint cpspec, const(PROPSPEC)* rgpspec, PROPVARIANT* rgpropvar);
    ///The <b>WriteMultiple</b> method writes a specified group of properties to the current property set. If a property
    ///with a specified name or property identifier already exists, it is replaced, even when the old and new types for
    ///the property value are different. If a property of a given name or property ID does not exist, it is created.
    ///Params:
    ///    cpspec = The number of properties set. The value of this parameter can be set to zero; however, this defeats the
    ///             purpose of the method as no properties are then written.
    ///    rgpspec = An array of the property IDs (PROPSPEC) to which properties are set. These need not be in any particular
    ///              order, and may contain duplicates, however the last specified property ID is the one that takes effect. A
    ///              mixture of property IDs and string names is permitted.
    ///    rgpropvar = An array (of size <i>cpspec</i>) of PROPVARIANT structures that contain the property values to be written.
    ///                The array must be the size specified by <i>cpspec</i>.
    ///    propidNameFirst = The minimum value for the property IDs that the method must assign if the <i>rgpspec</i> parameter specifies
    ///                      string-named properties for which no property IDs currently exist. If all string-named properties specified
    ///                      already exist in this set, and thus already have property IDs, this value is ignored. When not ignored, this
    ///                      value must be greater than, or equal to, two and less than 0x80000000. Property IDs 0 and 1 and greater than
    ///                      0x80000000 are reserved for special use.
    ///Returns:
    ///    This method supports the standard return value E_UNEXPECTED, in addition to the following: This function can
    ///    also return any file system errors or Win32 errors wrapped in an <b>HRESULT</b> data type. For more
    ///    information, see Error Handling Strategies.
    ///    
    HRESULT WriteMultiple(uint cpspec, const(PROPSPEC)* rgpspec, const(PROPVARIANT)* rgpropvar, 
                          uint propidNameFirst);
    ///The <b>DeleteMultiple</b> method deletes as many of the indicated properties as exist in this property set.
    ///Params:
    ///    cpspec = The numerical count of properties to be deleted. The value of this parameter can legally be set to zero,
    ///             however that defeats the purpose of the method as no properties are thereby deleted, regardless of the value
    ///             set in <i>rgpspec</i>.
    ///    rgpspec = Properties to be deleted. A mixture of property identifiers and string-named properties is permitted. There
    ///              may be duplicates, and there is no requirement that properties be specified in any order.
    ///Returns:
    ///    This method supports the standard return value E_UNEXPECTED, in addition to the following:
    ///    
    HRESULT DeleteMultiple(uint cpspec, const(PROPSPEC)* rgpspec);
    ///The <b>ReadPropertyNames</b> method retrieves any existing string names for the specified property IDs.
    ///Params:
    ///    cpropid = The number of elements on input of the array <i>rgpropid</i>. The value of this parameter can be set to zero,
    ///              however that defeats the purpose of this method as no property names are thereby read.
    ///    rgpropid = An array of property IDs for which names are to be retrieved.
    ///    rglpwstrName = A caller-allocated array of size <i>cpropid</i> of <b>LPWSTR</b> members. On return, the implementation fills
    ///                   in this array. A given entry contains either the corresponding string name of a property ID or it can be
    ///                   empty if the property ID has no string names. Each <b>LPWSTR</b> member of the array should be freed using
    ///                   the CoTaskMemFree function.
    ///Returns:
    ///    This method supports the standard return value E_UNEXPECTED, in addition to the following:
    ///    
    HRESULT ReadPropertyNames(uint cpropid, const(uint)* rgpropid, PWSTR** rglpwstrName);
    ///The <b>WritePropertyNames</b> method assigns string IPropertyStoragenames to a specified array of property IDs in
    ///the current property set.
    ///Params:
    ///    cpropid = The size on input of the array <i>rgpropid</i>. Can be zero. However, making it zero causes this method to
    ///              become non-operational.
    ///    rgpropid = An array of the property IDs for which names are to be set.
    ///    rglpwstrName = An array of new names to be assigned to the corresponding property IDs in the <i>rgpropid</i> array. These
    ///                   names may not exceed 255 characters (not including the <b>NULL</b> terminator).
    ///Returns:
    ///    This method supports the standard return value <b>E_UNEXPECTED</b>, in addition to the following:
    ///    
    HRESULT WritePropertyNames(uint cpropid, const(uint)* rgpropid, const(PWSTR)** rglpwstrName);
    ///The <b>DeletePropertyNames</b> method deletes specified string names from the current property set.
    ///Params:
    ///    cpropid = The size on input of the array <i>rgpropid</i>. If 0, no property names are deleted.
    ///    rgpropid = Property identifiers for which string names are to be deleted.
    ///Returns:
    ///    This method supports the standard return value E_UNEXPECTED, in addition to the following:
    ///    
    HRESULT DeletePropertyNames(uint cpropid, const(uint)* rgpropid);
    ///The <b>IPropertyStorage::Commit</b> method saves changes made to a property storage object to the parent storage
    ///object.
    ///Params:
    ///    grfCommitFlags = The flags that specify the conditions under which the commit is to be performed. For more information about
    ///                     specific flags and their meanings, see the Remarks section.
    ///Returns:
    ///    This method supports the standard return value E_UNEXPECTED, as well as the following:
    ///    
    HRESULT Commit(uint grfCommitFlags);
    ///The <b>Revert</b> method discards all changes to the named property set since it was last opened or discards
    ///changes that were last committed to the property set. This method has no effect on a direct-mode property set.
    ///Returns:
    ///    This method supports the standard return value E_UNEXPECTED, in addition to the following:
    ///    
    HRESULT Revert();
    ///The <b>Enum</b> method creates an enumerator object designed to enumerate data of type STATPROPSTG, which
    ///contains information on the current property set. On return, this method supplies a pointer to the
    ///IEnumSTATPROPSTG pointer on this object.
    ///Params:
    ///    ppenum = Pointer to IEnumSTATPROPSTG pointer variable that receives the interface pointer to the new enumerator
    ///             object.
    ///Returns:
    ///    This method supports the standard return value E_UNEXPECTED, in addition to the following:
    ///    
    HRESULT Enum(IEnumSTATPROPSTG* ppenum);
    ///The <b>SetTimes</b> method sets the modification, access, and creation times of this property set, if supported
    ///by the implementation. Not all implementations support all these time values.
    ///Params:
    ///    pctime = Pointer to the new creation time for the property set. May be <b>NULL</b>, indicating that this time is not
    ///             to be modified by this call.
    ///    patime = Pointer to the new access time for the property set. May be <b>NULL</b>, indicating that this time is not to
    ///             be modified by this call.
    ///    pmtime = Pointer to the new modification time for the property set. May be <b>NULL</b>, indicating that this time is
    ///             not to be modified by this call.
    ///Returns:
    ///    This method supports the standard return value E_UNEXPECTED, in addition to the following:
    ///    
    HRESULT SetTimes(const(FILETIME)* pctime, const(FILETIME)* patime, const(FILETIME)* pmtime);
    ///The <b>SetClass</b> method assigns a new CLSID to the current property storage object, and persistently stores
    ///the CLSID with the object.
    ///Params:
    ///    clsid = New CLSID to be associated with the property set.
    ///Returns:
    ///    This method supports the standard return value E_UNEXPECTED, in addition to the following:
    ///    
    HRESULT SetClass(const(GUID)* clsid);
    ///The <b>Stat</b> method retrieves information about the current open property set.
    ///Params:
    ///    pstatpsstg = Pointer to a STATPROPSETSTG structure, which contains statistics about the current open property set.
    ///Returns:
    ///    This method supports the standard return value E_UNEXPECTED, in addition to the following:
    ///    
    HRESULT Stat(STATPROPSETSTG* pstatpsstg);
}

///The <b>IPropertySetStorage</b> interface creates, opens, deletes, and enumerates property set storages that support
///instances of the IPropertyStorage interface. The <b>IPropertyStorage</b> interface manages a single property set in a
///property storage subobject; and the <b>IPropertySetStorage</b> interface manages the storage of groups of such
///property sets. Any file system entity can support <b>IPropertySetStorage</b> that is currently implemented in the COM
///compound file object. The <b>IPropertySetStorage</b> and IPropertyStorage interfaces provide a uniform way to create
///and manage property sets, whether or not these sets reside in a storage object that supports IStorage. When called
///through an object supporting <b>IStorage</b> (such as structured and compound files) or IStream, the property sets
///created conform to the COM property set format, described in detail in Structured Storage Serialized Property Set
///Format. Similarly, properties written using <b>IStorage</b> to the COM property set format are visible through
///<b>IPropertySetStorage</b> and <b>IPropertyStorage</b>. <b>IPropertySetStorage</b> methods identify property sets
///through a globally unique identifier (GUID) called a format identifier (FMTID). The FMTID for a property set
///identifies the property identifiers in the property set, their meaning, and any constraints on the values. The FMTID
///of a property set should also provide the means to manipulate that property set. Only one instance of a given FMTID
///may exist at a time within a single property storage.
@GUID("0000013A-0000-0000-C000-000000000046")
interface IPropertySetStorage : IUnknown
{
    ///The <b>Create</b> method creates and opens a new property set in the property set storage object.
    ///Params:
    ///    rfmtid = The FMTID of the property set to be created. For information about FMTIDs that are well-known and predefined
    ///             in the Platform SDK, see Predefined Property Set Format Identifiers.
    ///    pclsid = A pointer to the initial class identifier CLSID for this property set. May be <b>NULL</b>, in which case it
    ///             is set to all zeroes. The CLSID is the CLSID of a class that displays and/or provides programmatic access to
    ///             the property values. If there is no such class, it is recommended that the FMTID be used.
    ///    grfFlags = The values from PROPSETFLAG Constants.
    ///    grfMode = An access mode in which the newly created property set is to be opened, taken from certain values of
    ///              STGM_Constants, as described in the following Remarks section.
    ///    ppprstg = A pointer to the output variable that receives the IPropertyStorage interface pointer.
    ///Returns:
    ///    This method supports the standard return value E_UNEXPECTED, as well as the following:
    ///    
    HRESULT Create(const(GUID)* rfmtid, const(GUID)* pclsid, uint grfFlags, uint grfMode, 
                   IPropertyStorage* ppprstg);
    ///The <b>Open</b> method opens a property set contained in the property set storage object.
    ///Params:
    ///    rfmtid = The format identifier (FMTID) of the property set to be opened. For more information about well-known and
    ///             predefined FMTIDs in the Platform SDK, see Predefined Property Set Format Identifiers.
    ///    grfMode = The access mode in which the newly created property set is to be opened. These flags are taken from STGM
    ///              Constants. Flags that may be used and their meanings in the context of this method are described in the
    ///              following Remarks section.
    ///    ppprstg = A pointer to the IPropertyStorage pointer variable that receives the interface pointer to the requested
    ///              property storage subobject.
    ///Returns:
    ///    This method supports the standard return value E_UNEXPECTED, in addition to the following:
    ///    
    HRESULT Open(const(GUID)* rfmtid, uint grfMode, IPropertyStorage* ppprstg);
    ///The <b>Delete</b> method deletes one of the property sets contained in the property set storage object.
    ///Params:
    ///    rfmtid = FMTID of the property set to be deleted.
    ///Returns:
    ///    This method supports the standard return value E_UNEXPECTED, in addition to the following:
    ///    
    HRESULT Delete(const(GUID)* rfmtid);
    ///The <b>Enum</b> method creates an enumerator object which contains information on the property sets stored in
    ///this property set storage. On return, this method supplies a pointer to the IEnumSTATPROPSETSTG pointer on the
    ///enumerator object.
    ///Params:
    ///    ppenum = Pointer to IEnumSTATPROPSETSTG pointer variable that receives the interface pointer to the newly created
    ///             enumerator object.
    ///Returns:
    ///    This method can return one of these values.
    ///    
    HRESULT Enum(IEnumSTATPROPSETSTG* ppenum);
}

///The <b>IEnumSTATPROPSTG</b> interface iterates through an array of STATPROPSTG structures. The <b>STATPROPSTG</b>
///structures contain statistical data about properties in a property set. <b>IEnumSTATPROPSTG</b> has the same methods
///as all enumerator interfaces: Next, Skip, Reset, and Clone. The implementation defines the order in which the
///properties in the set are enumerated. Properties that are present when the enumerator is created, and are not removed
///during the enumeration, will be enumerated only once. Properties added or deleted while the enumeration is in
///progress may or may not be enumerated, but will never be enumerated more than once. Reserved property identifiers,
///properties with a property ID of 0 (dictionary), 1 (code page indicator), or greater than or equal to 0x80000000 are
///not enumerated. Enumeration of a nonsimple property does not necessarily indicate that the property can be read
///successfully through a call to IPropertyStorage::ReadMultiple. This is because the performance overhead of checking
///existence of the indirect stream or storage is prohibitive during property enumeration.
@GUID("00000139-0000-0000-C000-000000000046")
interface IEnumSTATPROPSTG : IUnknown
{
    ///The <b>Next</b> method retrieves a specified number of STATPROPSTG structures, that follow subsequently in the
    ///enumeration sequence. If fewer than the requested number of STATPROPSTG structures exist in the enumeration
    ///sequence, it retrieves the remaining <b>STATPROPSTG</b> structures.
    ///Params:
    ///    celt = The number of STATPROPSTG structures requested.
    ///    rgelt = An array of STATPROPSTG structures returned.
    ///    pceltFetched = The number of STATPROPSTG structures retrieved in the <i>rgelt</i> parameter.
    HRESULT Next(uint celt, STATPROPSTG* rgelt, uint* pceltFetched);
    ///The <b>Skip</b> method skips the specified number of STATPROPSTG structures in the enumeration sequence.
    ///Params:
    ///    celt = The number of STATPROPSTG structures to skip.
    ///Returns:
    ///    This method supports the following return values:
    ///    
    HRESULT Skip(uint celt);
    ///The <b>Reset</b> method resets the enumeration sequence to the beginning of the STATPROPSTG structure array.
    HRESULT Reset();
    ///The <b>Clone</b> method creates an enumerator that contains the same enumeration state as the current STATPROPSTG
    ///structure enumerator. Using this method, a client can record a particular point in the enumeration sequence and
    ///then return to that point later. The new enumerator supports the same IEnumSTATPROPSTG interface.
    ///Params:
    ///    ppenum = A pointer to the variable that receives the IEnumSTATPROPSTG interface pointer. If the method is
    ///             unsuccessful, the value of the <i>ppenum</i> parameter is undefined.
    HRESULT Clone(IEnumSTATPROPSTG* ppenum);
}

///The <b>IEnumSTATPROPSETSTG</b> interface iterates through an array of STATPROPSETSTG structures. The
///<b>STATPROPSETSTG</b> structures contain statistical data about the property sets managed by the current
///IPropertySetStorage instance. <b>IEnumSTATPROPSETSTG</b> has the same methods as all enumerator interfaces: Next,
///Skip, Reset, and Clone. The implementation defines the order in which the property sets are enumerated. Property sets
///that are present when the enumerator is created, and are not removed during the enumeration, will be enumerated only
///once. Property sets added or deleted while the enumeration is in progress may or may not be enumerated, but, if
///enumerated, will not be enumerated more than once. For more information about how the COM compound document
///implementation of IEnumSTATPROPSETSTG::Next supplies members of the STATPROPSETSTG structure, see
///IEnumSTATPROPSETSTG--Compound File Implementation.
@GUID("0000013B-0000-0000-C000-000000000046")
interface IEnumSTATPROPSETSTG : IUnknown
{
    ///The <b>Next</b> method retrieves a specified number of STATPROPSETSTG structures that follow subsequently in the
    ///enumeration sequence. If fewer than the requested number of STATPROPSETSTG structures exist in the enumeration
    ///sequence, it retrieves the remaining <b>STATPROPSETSTG</b> structures.
    ///Params:
    ///    celt = The number of STATPROPSETSTG structures requested.
    ///    rgelt = An array of STATPROPSETSTG structures returned.
    ///    pceltFetched = The number of STATPROPSETSTG structures retrieved in the <i>rgelt</i> parameter.
    HRESULT Next(uint celt, STATPROPSETSTG* rgelt, uint* pceltFetched);
    ///The <b>Skip</b> method skips a specified number of STATPROPSETSTG structures in the enumeration sequence.
    ///Params:
    ///    celt = The number of STATPROPSETSTG structures to skip.
    ///Returns:
    ///    This method supports the following return values:
    ///    
    HRESULT Skip(uint celt);
    ///The <b>Reset</b> method resets the enumeration sequence to the beginning of the STATPROPSETSTG structure array.
    HRESULT Reset();
    ///The <b>Clone</b> method creates an enumerator that contains the same enumeration state as the current
    ///STATPROPSETSTG structure enumerator. Using this method, a client can record a particular point in the enumeration
    ///sequence and then return to that point later. The new enumerator supports the same IEnumSTATPROPSETSTG interface.
    ///Params:
    ///    ppenum = A pointer to the variable that receives the IEnumSTATPROPSETSTG interface pointer. If the method does not
    ///             succeed, the value of the <i>ppenum</i> parameter is undefined.
    HRESULT Clone(IEnumSTATPROPSETSTG* ppenum);
}

///The <b>ISequentialStream</b> interface supports simplified sequential access to stream objects. The IStream interface
///inherits its Read and Write methods from <b>ISequentialStream</b>.
@GUID("0C733A30-2A1C-11CE-ADE5-00AA0044773D")
interface ISequentialStream : IUnknown
{
    ///The <b>Read</b> method reads a specified number of bytes from the stream object into memory, starting at the
    ///current seek pointer.
    ///Params:
    ///    pv = A pointer to the buffer which the stream data is read into.
    ///    cb = The number of bytes of data to read from the stream object.
    ///    pcbRead = A pointer to a <b>ULONG</b> variable that receives the actual number of bytes read from the stream object.
    ///              <div class="alert"><b>Note</b> The number of bytes read may be zero.</div> <div> </div>
    ///Returns:
    ///    This method can return one of these values.
    ///    
    HRESULT Read(void* pv, uint cb, uint* pcbRead);
    ///The <b>Write</b> method writes a specified number of bytes into the stream object starting at the current seek
    ///pointer.
    ///Params:
    ///    pv = A pointer to the buffer that contains the data that is to be written to the stream. A valid pointer must be
    ///         provided for this parameter even when <i>cb</i> is zero.
    ///    cb = The number of bytes of data to attempt to write into the stream. This value can be zero.
    ///    pcbWritten = A pointer to a <b>ULONG</b> variable where this method writes the actual number of bytes written to the
    ///                 stream object. The caller can set this pointer to <b>NULL</b>, in which case this method does not provide the
    ///                 actual number of bytes written.
    ///Returns:
    ///    This method can return one of these values.
    ///    
    HRESULT Write(const(void)* pv, uint cb, uint* pcbWritten);
}

///The <b>IStream</b> interface lets you read and write data to stream objects. Stream objects contain the data in a
///structured storage object, where storages provide the structure. Simple data can be written directly to a stream but,
///most frequently, streams are elements nested within a storage object. They are similar to standard files. The
///<b>IStream</b> interface defines methods similar to the MS-DOS FAT file functions. For example, each stream object
///has its own access rights and a seek pointer. The main difference between a DOS file and a stream object is that in
///the latter case, streams are opened using an <b>IStream</b> interface pointer rather than a file handle. The methods
///in this interface present your object's data as a contiguous sequence of bytes that you can read or write. There are
///also methods for committing and reverting changes on streams that are open in transacted mode and methods for
///restricting access to a range of bytes in the stream. Streams can remain open for long periods of time without
///consuming file-system resources. The IUnknown::Release method is similar to a close function on a file. Once
///released, the stream object is no longer valid and cannot be used. Clients of asynchronous monikers can choose
///between a data-pull or data-push model for driving an asynchronous IMoniker::BindToStorage operation and for
///receiving asynchronous notifications. See URL Monikers for more information. The following table compares the
///behavior of asynchronous ISequentialStream::Read and IStream::Seek calls returned in
///IBindStatusCallback::OnDataAvailable in these two download models: <table> <tr> <th>IStream method call</th>
///<th>Behavior in data-pull model</th> <th>Behavior in data-push model</th> </tr> <tr> <td><b>Read</b> is called to
///read partial data (that is, not all the available data)</td> <td>Returns S_OK. The client must continue to read all
///available data before returning from IBindStatusCallback::OnDataAvailable or else the bind operation is blocked.
///(that is, read until S_FALSE or E_PENDING is returned)</td> <td>Returns S_OK. Even if the client returns from
///IBindStatusCallback::OnDataAvailable at this point the bind operation continues and
///<b>IBindStatusCallback::OnDataAvailable</b> will be called again repeatedly until the binding finishes.</td> </tr>
///<tr> <td><b>Read</b> is called to read all the available data</td> <td>Returns E_PENDING if the bind operation has
///not completed, and IBindStatusCallback::OnDataAvailable will be called again when more data is available.</td>
///<td>Same as data-pull model.</td> </tr> <tr> <td><b>Read</b> is called to read all the available data and the bind
///operation is over (end of file)</td> <td>Returns S_FALSE. There will be a subsequent call to
///IBindStatusCallback::OnDataAvailable with the <i>grfBSC</i> flag set to BSCF_LASTDATANOTIFICATION.</td> <td>Same as
///data-pull model.</td> </tr> <tr> <td><b>Seek</b> is called</td> <td><b>Seek</b> does not work in data-pull model</td>
///<td><b>Seek</b> does not work in data-push model.</td> </tr> </table> For general information on this topic, see
///Asynchronous Monikers and Data-Pull-Model versus Data Push-Model for more specific information. Also, see Managing
///Memory Allocation for details on COM's rules for managing memory.
@GUID("0000000C-0000-0000-C000-000000000046")
interface IStream : ISequentialStream
{
    ///The <b>Seek</b> method changes the seek pointer to a new location. The new location is relative to either the
    ///beginning of the stream, the end of the stream, or the current seek pointer.
    ///Params:
    ///    dlibMove = The displacement to be added to the location indicated by the <i>dwOrigin</i> parameter. If <i>dwOrigin</i>
    ///               is <b>STREAM_SEEK_SET</b>, this is interpreted as an unsigned value rather than a signed value.
    ///    dwOrigin = The origin for the displacement specified in <i>dlibMove</i>. The origin can be the beginning of the file
    ///               (<b>STREAM_SEEK_SET</b>), the current seek pointer (<b>STREAM_SEEK_CUR</b>), or the end of the file
    ///               (<b>STREAM_SEEK_END</b>). For more information about values, see the STREAM_SEEK enumeration.
    ///    plibNewPosition = A pointer to the location where this method writes the value of the new seek pointer from the beginning of
    ///                      the stream. You can set this pointer to <b>NULL</b>. In this case, this method does not provide the new seek
    ///                      pointer.
    ///Returns:
    ///    This method can return one of these values.
    ///    
    HRESULT Seek(LARGE_INTEGER dlibMove, STREAM_SEEK dwOrigin, ULARGE_INTEGER* plibNewPosition);
    ///The <b>SetSize</b> method changes the size of the stream object.
    ///Params:
    ///    libNewSize = Specifies the new size, in bytes, of the stream.
    ///Returns:
    ///    This method can return one of these values.
    ///    
    HRESULT SetSize(ULARGE_INTEGER libNewSize);
    ///The <b>CopyTo</b> method copies a specified number of bytes from the current seek pointer in the stream to the
    ///current seek pointer in another stream.
    ///Params:
    ///    pstm = A pointer to the destination stream. The stream pointed to by <i>pstm</i> can be a new stream or a clone of
    ///           the source stream.
    ///    cb = The number of bytes to copy from the source stream.
    ///    pcbRead = A pointer to the location where this method writes the actual number of bytes read from the source. You can
    ///              set this pointer to <b>NULL</b>. In this case, this method does not provide the actual number of bytes read.
    ///    pcbWritten = A pointer to the location where this method writes the actual number of bytes written to the destination. You
    ///                 can set this pointer to <b>NULL</b>. In this case, this method does not provide the actual number of bytes
    ///                 written.
    ///Returns:
    ///    This method can return one of these values.
    ///    
    HRESULT CopyTo(IStream pstm, ULARGE_INTEGER cb, ULARGE_INTEGER* pcbRead, ULARGE_INTEGER* pcbWritten);
    ///The <b>Commit</b> method ensures that any changes made to a stream object open in transacted mode are reflected
    ///in the parent storage. If the stream object is open in direct mode, <b>IStream::Commit</b> has no effect other
    ///than flushing all memory buffers to the next-level storage object. The COM compound file implementation of
    ///streams does not support opening streams in transacted mode.
    ///Params:
    ///    grfCommitFlags = Controls how the changes for the stream object are committed. See the STGC enumeration for a definition of
    ///                     these values.
    ///Returns:
    ///    This method can return one of these values.
    ///    
    HRESULT Commit(uint grfCommitFlags);
    ///The <b>Revert</b> method discards all changes that have been made to a transacted stream since the last
    ///IStream::Commit call. On streams open in direct mode and streams using the COM compound file implementation of
    ///<b>IStream::Revert</b>, this method has no effect.
    ///Returns:
    ///    This method can return one of these values.
    ///    
    HRESULT Revert();
    ///The <b>LockRegion</b> method restricts access to a specified range of bytes in the stream. Supporting this
    ///functionality is optional since some file systems do not provide it.
    ///Params:
    ///    libOffset = Integer that specifies the byte offset for the beginning of the range.
    ///    cb = Integer that specifies the length of the range, in bytes, to be restricted.
    ///    dwLockType = Specifies the restrictions being requested on accessing the range.
    ///Returns:
    ///    This method can return one of these values.
    ///    
    HRESULT LockRegion(ULARGE_INTEGER libOffset, ULARGE_INTEGER cb, uint dwLockType);
    ///The <b>UnlockRegion</b> method removes the access restriction on a range of bytes previously restricted with
    ///IStream::LockRegion.
    ///Params:
    ///    libOffset = Specifies the byte offset for the beginning of the range.
    ///    cb = Specifies, in bytes, the length of the range to be restricted.
    ///    dwLockType = Specifies the access restrictions previously placed on the range.
    ///Returns:
    ///    This method can return one of these values.
    ///    
    HRESULT UnlockRegion(ULARGE_INTEGER libOffset, ULARGE_INTEGER cb, uint dwLockType);
    ///The <b>Stat</b> method retrieves the STATSTG structure for this stream.
    ///Params:
    ///    pstatstg = Pointer to a STATSTG structure where this method places information about this stream object.
    ///    grfStatFlag = Specifies that this method does not return some of the members in the STATSTG structure, thus saving a memory
    ///                  allocation operation. Values are taken from the STATFLAG enumeration.
    ///Returns:
    ///    This method can return one of these values.
    ///    
    HRESULT Stat(STATSTG* pstatstg, uint grfStatFlag);
    ///The <b>Clone</b> method creates a new stream object with its own seek pointer that references the same bytes as
    ///the original stream.
    ///Params:
    ///    ppstm = When successful, pointer to the location of an IStream pointer to the new stream object. If an error occurs,
    ///            this parameter is <b>NULL</b>.
    ///Returns:
    ///    This method can return one of these values.
    ///    
    HRESULT Clone(IStream* ppstm);
}

///The <b>IEnumSTATSTG</b> interface enumerates an array of STATSTG structures. These structures contain statistical
///data about open storage, stream, or byte array objects. <b>IEnumSTATSTG</b> has the same methods as all enumerator
///interfaces: Next, Skip, Reset, and Clone.
@GUID("0000000D-0000-0000-C000-000000000046")
interface IEnumSTATSTG : IUnknown
{
    ///The <b>Next</b> method retrieves a specified number of STATSTG structures, that follow in the enumeration
    ///sequence. If there are fewer than the requested number of STATSTG structures that remain in the enumeration
    ///sequence, it retrieves the remaining <b>STATSTG</b> structures.
    ///Params:
    ///    celt = The number of STATSTG structures requested.
    ///    rgelt = An array of STATSTG structures returned.
    ///    pceltFetched = The number of STATSTG structures retrieved in the <i>rgelt</i> parameter.
    ///Returns:
    ///    This method supports the following return values: <table> <tr> <th>Return code</th> <th>Description</th>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The number of STATSTG
    ///    structures returned is equal to the number specified in the <i>celt</i> parameter. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_FALSE</b></dt> </dl> </td> <td width="60%"> The number of STATSTG structures
    ///    returned is less than the number specified in the <i>celt</i> parameter. </td> </tr> </table>
    ///    
    HRESULT Next(uint celt, STATSTG* rgelt, uint* pceltFetched);
    ///The <b>Skip</b> method skips a specified number of STATSTG structures in the enumeration sequence.
    ///Params:
    ///    celt = The number of STATSTG structures to skip.
    HRESULT Skip(uint celt);
    ///The <b>Reset</b> method resets the enumeration sequence to the beginning of the STATSTG structure array.
    ///Returns:
    ///    This method supports the S_OK return value. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The enumeration sequence was
    ///    successfully reset to the beginning of the enumeration. </td> </tr> </table>
    ///    
    HRESULT Reset();
    ///The <b>Clone</b> method creates a new enumerator that contains the same enumeration state as the current STATSTG
    ///structure enumerator. Using this method, a client can record a particular point in the enumeration sequence and
    ///then return to that point at a later time. The new enumerator supports the same IEnumSTATSTG interface.
    ///Params:
    ///    ppenum = A pointer to the variable that receives the IEnumSTATSTG interface pointer. If the method is unsuccessful,
    ///             the value of the <i>ppenum</i> parameter is undefined.
    HRESULT Clone(IEnumSTATSTG* ppenum);
}

///The <b>IStorage</b> interface supports the creation and management of structured storage objects. Structured storage
///allows hierarchical storage of information within a single file, and is often referred to as "a file system within a
///file". Elements of a structured storage object are storages and streams. Storages are analogous to directories, and
///streams are analogous to files. Within a structured storage there will be a primary storage object that may contain
///substorages, possibly nested, and streams. Storages provide the structure of the object, and streams contain the
///data, which is manipulated through the IStream interface. The <b>IStorage</b> interface provides methods for creating
///and managing the root storage object, child storage objects, and stream objects. These methods can create, open,
///enumerate, move, copy, rename, or delete the elements in the storage object. An application must release its
///<b>IStorage</b> pointers when it is done with the storage object to deallocate memory used. There are also methods
///for changing the date and time of an element. There are a number of different modes in which a storage object and its
///elements can be opened, determined by setting values from STGM Constants. One aspect of this is how changes are
///committed. You can set direct mode, in which changes to an object are immediately written to it, or transacted mode,
///in which changes are written to a buffer until explicitly committed. The <b>IStorage</b> interface provides methods
///for committing changes and reverting to the last-committed version. For example, a stream can be opened in read-only
///mode or read/write mode. For more information, see <b>STGM Constants</b>. Other methods provide access to information
///about a storage object and its elements through the STATSTG structure.
@GUID("0000000B-0000-0000-C000-000000000046")
interface IStorage : IUnknown
{
    ///The <b>CreateStream</b> method creates and opens a stream object with the specified name contained in this
    ///storage object. All elements within a storage objects, both streams and other storage objects, are kept in the
    ///same name space.
    ///Params:
    ///    pwcsName = A pointer to a wide character null-terminated Unicode string that contains the name of the newly created
    ///               stream. The name can be used later to open or reopen the stream. The name must not exceed 31 characters in
    ///               length, not including the string terminator. The 000 through 01f characters, serving as the first character
    ///               of the stream/storage name, are reserved for use by OLE. This is a compound file restriction, not a
    ///               structured storage restriction.
    ///    grfMode = Specifies the access mode to use when opening the newly created stream. For more information and descriptions
    ///              of the possible values, see STGM Constants.
    ///    reserved1 = Reserved for future use; must be zero.
    ///    reserved2 = Reserved for future use; must be zero.
    ///    ppstm = On return, pointer to the location of the new IStream interface pointer. This is only valid if the operation
    ///            is successful. When an error occurs, this parameter is set to <b>NULL</b>.
    ///Returns:
    ///    This method can return one of these values.
    ///    
    HRESULT CreateStream(const(PWSTR) pwcsName, uint grfMode, uint reserved1, uint reserved2, IStream* ppstm);
    ///The <b>OpenStream</b> method opens an existing stream object within this storage object in the specified access
    ///mode.
    ///Params:
    ///    pwcsName = A pointer to a wide character null-terminated Unicode string that contains the name of the stream to open.
    ///               The 000 through 01f characters, serving as the first character of the stream/storage name, are reserved for
    ///               use by OLE. This is a compound file restriction, not a structured storage restriction.
    ///    reserved1 = Reserved for future use; must be <b>NULL</b>.
    ///    grfMode = Specifies the access mode to be assigned to the open stream. For more information and descriptions of
    ///              possible values, see STGM Constants. Other modes you choose must at least specify STGM_SHARE_EXCLUSIVE when
    ///              calling this method in the compound file implementation.
    ///    reserved2 = Reserved for future use; must be zero.
    ///    ppstm = A pointer to IStream pointer variable that receives the interface pointer to the newly opened stream object.
    ///            If an error occurs, *<i>ppstm</i> must be set to <b>NULL</b>.
    ///Returns:
    ///    This method can return one of these values.
    ///    
    HRESULT OpenStream(const(PWSTR) pwcsName, void* reserved1, uint grfMode, uint reserved2, IStream* ppstm);
    ///The <b>CreateStorage</b> method creates and opens a new storage object nested within this storage object with the
    ///specified name in the specified access mode.
    ///Params:
    ///    pwcsName = A pointer to a wide character null-terminated Unicode string that contains the name of the newly created
    ///               storage object. The name can be used later to reopen the storage object. The name must not exceed 31
    ///               characters in length, not including the string terminator. The 000 through 01f characters, serving as the
    ///               first character of the stream/storage name, are reserved for use by OLE. This is a compound file restriction,
    ///               not a structured storage restriction.
    ///    grfMode = A value that specifies the access mode to use when opening the newly created storage object. For more
    ///              information and a description of possible values, see STGM Constants.
    ///    reserved1 = Reserved for future use; must be zero.
    ///    reserved2 = Reserved for future use; must be zero.
    ///    ppstg = A pointer, when successful, to the location of the IStorage pointer to the newly created storage object. This
    ///            parameter is set to <b>NULL</b> if an error occurs.
    ///Returns:
    ///    This method can return one of these values.
    ///    
    HRESULT CreateStorage(const(PWSTR) pwcsName, uint grfMode, uint reserved1, uint reserved2, IStorage* ppstg);
    ///The <b>OpenStorage</b> method opens an existing storage object with the specified name in the specified access
    ///mode.
    ///Params:
    ///    pwcsName = A pointer to a wide character null-terminated Unicode string that contains the name of the storage object to
    ///               open. The 000 through 01f characters, serving as the first character of the stream/storage name, are reserved
    ///               for use by OLE. This is a compound file restriction, not a structured storage restriction. It is ignored if
    ///               <i>pstgPriority</i> is non-<b>NULL</b>.
    ///    pstgPriority = Must be <b>NULL</b>. A non-<b>NULL</b> value will return STG_E_INVALIDPARAMETER.
    ///    grfMode = Specifies the access mode to use when opening the storage object. For descriptions of the possible values,
    ///              see STGM Constants. Other modes you choose must at least specify STGM_SHARE_EXCLUSIVE when calling this
    ///              method.
    ///    snbExclude = Must be <b>NULL</b>. A non-<b>NULL</b> value will return STG_E_INVALIDPARAMETER.
    ///    reserved = Reserved for future use; must be zero.
    ///    ppstg = When successful, pointer to the location of an IStorage pointer to the opened storage object. This parameter
    ///            is set to <b>NULL</b> if an error occurs.
    ///Returns:
    ///    This method can return one of these values.
    ///    
    HRESULT OpenStorage(const(PWSTR) pwcsName, IStorage pstgPriority, uint grfMode, ushort** snbExclude, 
                        uint reserved, IStorage* ppstg);
    ///The <b>CopyTo</b> method copies the entire contents of an open storage object to another storage object.
    ///Params:
    ///    ciidExclude = The number of elements in the array pointed to by <i>rgiidExclude</i>. If <i>rgiidExclude</i> is <b>NULL</b>,
    ///                  then <i>ciidExclude</i> is ignored.
    ///    rgiidExclude = An array of interface identifiers (IIDs) that either the caller knows about and does not want copied or that
    ///                   the storage object does not support, but whose state the caller will later explicitly copy. The array can
    ///                   include IStorage, indicating that only stream objects are to be copied, and IStream, indicating that only
    ///                   storage objects are to be copied. An array length of zero indicates that only the state exposed by the
    ///                   <b>IStorage</b> object is to be copied; all other interfaces on the object are to be ignored. Passing
    ///                   <b>NULL</b> indicates that all interfaces on the object are to be copied.
    ///    snbExclude = A string name block (refer to SNB) that specifies a block of storage or stream objects that are not to be
    ///                 copied to the destination. These elements are not created at the destination. If <b>IID_IStorage</b> is in
    ///                 the <i>rgiidExclude</i> array, this parameter is ignored. This parameter may be <b>NULL</b>.
    ///    pstgDest = A pointer to the open storage object into which this storage object is to be copied. The destination storage
    ///               object can be a different implementation of the IStorage interface from the source storage object. Thus,
    ///               <b>IStorage::CopyTo</b> can use only publicly available methods of the destination storage object. If
    ///               <i>pstgDest</i> is open in transacted mode, it can be reverted by calling its IStorage::Revert method.
    ///Returns:
    ///    This method can return one of these values.
    ///    
    HRESULT CopyTo(uint ciidExclude, const(GUID)* rgiidExclude, ushort** snbExclude, IStorage pstgDest);
    ///The <b>MoveElementTo</b> method copies or moves a substorage or stream from this storage object to another
    ///storage object.
    ///Params:
    ///    pwcsName = Pointer to a wide character null-terminated Unicode string that contains the name of the element in this
    ///               storage object to be moved or copied.
    ///    pstgDest = IStorage pointer to the destination storage object.
    ///    pwcsNewName = Pointer to a wide character null-terminated unicode string that contains the new name for the element in its
    ///                  new storage object.
    ///    grfFlags = Specifies whether the operation should be a move (STGMOVE_MOVE) or a copy (STGMOVE_COPY). See the STGMOVE
    ///               enumeration.
    ///Returns:
    ///    This method can return one of these values.
    ///    
    HRESULT MoveElementTo(const(PWSTR) pwcsName, IStorage pstgDest, const(PWSTR) pwcsNewName, uint grfFlags);
    ///The <b>Commit</b> method ensures that any changes made to a storage object open in transacted mode are reflected
    ///in the parent storage. For nonroot storage objects in direct mode, this method has no effect. For a root storage,
    ///it reflects the changes in the actual device; for example, a file on disk. For a root storage object opened in
    ///direct mode, always call the <b>IStorage::Commit</b> method prior to Release. <b>IStorage::Commit</b> flushes all
    ///memory buffers to the disk for a root storage in direct mode and will return an error code upon failure. Although
    ///<b>Release</b> also flushes memory buffers to disk, it has no capacity to return any error codes upon failure.
    ///Therefore, calling <b>Release</b> without first calling <b>Commit</b> causes indeterminate results.
    ///Params:
    ///    grfCommitFlags = Controls how the changes are committed to the storage object. See the STGC enumeration for a definition of
    ///                     these values.
    ///Returns:
    ///    This method can return one of these values.
    ///    
    HRESULT Commit(uint grfCommitFlags);
    ///The <b>Revert</b> method discards all changes that have been made to the storage object since the last commit
    ///operation.
    ///Returns:
    ///    This method can return one of these values.
    ///    
    HRESULT Revert();
    ///The <b>EnumElements</b> method retrieves a pointer to an enumerator object that can be used to enumerate the
    ///storage and stream objects contained within this storage object.
    ///Params:
    ///    reserved1 = Reserved for future use; must be zero.
    ///    reserved2 = Reserved for future use; must be <b>NULL</b>.
    ///    reserved3 = Reserved for future use; must be zero.
    ///    ppenum = Pointer to IEnumSTATSTG* pointer variable that receives the interface pointer to the new enumerator object.
    ///Returns:
    ///    This method can return one of these values.
    ///    
    HRESULT EnumElements(uint reserved1, void* reserved2, uint reserved3, IEnumSTATSTG* ppenum);
    ///The <b>DestroyElement</b> method removes the specified storage or stream from this storage object.
    ///Params:
    ///    pwcsName = A pointer to a wide character null-terminated Unicode string that contains the name of the storage or stream
    ///               to be removed.
    ///Returns:
    ///    This method can return one of these values.
    ///    
    HRESULT DestroyElement(const(PWSTR) pwcsName);
    ///The <b>RenameElement</b> method renames the specified substorage or stream in this storage object.
    ///Params:
    ///    pwcsOldName = Pointer to a wide character null-terminated Unicode string that contains the name of the substorage or stream
    ///                  to be changed. <div class="alert"><b>Note</b> The <i>pwcsName</i>, created in CreateStorage or CreateStream
    ///                  must not exceed 31 characters in length, not including the string terminator.</div> <div> </div>
    ///    pwcsNewName = Pointer to a wide character null-terminated unicode string that contains the new name for the specified
    ///                  substorage or stream. <div class="alert"><b>Note</b> The <i>pwcsName</i>, created in CreateStorage or
    ///                  CreateStream must not exceed 31 characters in length, not including the string terminator.</div> <div> </div>
    ///Returns:
    ///    This method can return one of these values.
    ///    
    HRESULT RenameElement(const(PWSTR) pwcsOldName, const(PWSTR) pwcsNewName);
    ///The <b>SetElementTimes</b> method sets the modification, access, and creation times of the specified storage
    ///element, if the underlying file system supports this method.
    ///Params:
    ///    pwcsName = The name of the storage object element whose times are to be modified. If <b>NULL</b>, the time is set on the
    ///               root storage rather than one of its elements.
    ///    pctime = Either the new creation time for the element or <b>NULL</b> if the creation time is not to be modified.
    ///    patime = Either the new access time for the element or <b>NULL</b> if the access time is not to be modified.
    ///    pmtime = Either the new modification time for the element or <b>NULL</b> if the modification time is not to be
    ///             modified.
    ///Returns:
    ///    This method can return one of these values.
    ///    
    HRESULT SetElementTimes(const(PWSTR) pwcsName, const(FILETIME)* pctime, const(FILETIME)* patime, 
                            const(FILETIME)* pmtime);
    ///The <b>SetClass</b> method assigns the specified class identifier (CLSID) to this storage object.
    ///Params:
    ///    clsid = The CLSID that is to be associated with the storage object.
    ///Returns:
    ///    This method can return one of these values.
    ///    
    HRESULT SetClass(const(GUID)* clsid);
    ///The <b>SetStateBits</b> method stores up to 32 bits of state information in this storage object. This method is
    ///reserved for future use.
    ///Params:
    ///    grfStateBits = Specifies the new values of the bits to set. No legal values are defined for these bits; they are all
    ///                   reserved for future use and must not be used by applications.
    ///    grfMask = A binary mask indicating which bits in <i>grfStateBits</i> are significant in this call.
    ///Returns:
    ///    This method can return one of these values.
    ///    
    HRESULT SetStateBits(uint grfStateBits, uint grfMask);
    ///The <b>Stat</b> method retrieves the STATSTG structure for this open storage object.
    ///Params:
    ///    pstatstg = On return, pointer to a STATSTG structure where this method places information about the open storage object.
    ///               This parameter is <b>NULL</b> if an error occurs.
    ///    grfStatFlag = Specifies that some of the members in the STATSTG structure are not returned, thus saving a memory allocation
    ///                  operation. Values are taken from the STATFLAG enumeration.
    ///Returns:
    ///    This method can return one of these values.
    ///    
    HRESULT Stat(STATSTG* pstatstg, uint grfStatFlag);
}

///The <b>ILockBytes</b> interface is implemented on a byte array object that is backed by some physical storage, such
///as a disk file, global memory, or a database. It is used by a COM compound file storage object to give its root
///storage access to the physical device, while isolating the root storage from the details of accessing the physical
///storage.
@GUID("0000000A-0000-0000-C000-000000000046")
interface ILockBytes : IUnknown
{
    ///The <b>ReadAt</b> method reads a specified number of bytes starting at a specified offset from the beginning of
    ///the byte array object.
    ///Params:
    ///    ulOffset = Specifies the starting point from the beginning of the byte array for reading data.
    ///    pv = Pointer to the buffer into which the byte array is read. The size of this buffer is contained in <i>cb</i>.
    ///    cb = Specifies the number of bytes of data to attempt to read from the byte array.
    ///    pcbRead = Pointer to a <b>ULONG</b> where this method writes the actual number of bytes read from the byte array. You
    ///              can set this pointer to <b>NULL</b> to indicate that you are not interested in this value. In this case, this
    ///              method does not provide the actual number of bytes that were read.
    ///Returns:
    ///    This method can return one of these values.
    ///    
    HRESULT ReadAt(ULARGE_INTEGER ulOffset, void* pv, uint cb, uint* pcbRead);
    ///The <b>WriteAt</b> method writes the specified number of bytes starting at a specified offset from the beginning
    ///of the byte array.
    ///Params:
    ///    ulOffset = Specifies the starting point from the beginning of the byte array for the data to be written.
    ///    pv = Pointer to the buffer containing the data to be written.
    ///    cb = Specifies the number of bytes of data to attempt to write into the byte array.
    ///    pcbWritten = Pointer to a location where this method specifies the actual number of bytes written to the byte array. You
    ///                 can set this pointer to <b>NULL</b> to indicate that you are not interested in this value. In this case, this
    ///                 method does not provide the actual number of bytes written.
    ///Returns:
    ///    This method can return one of these values.
    ///    
    HRESULT WriteAt(ULARGE_INTEGER ulOffset, const(void)* pv, uint cb, uint* pcbWritten);
    ///The <b>Flush</b> method ensures that any internal buffers maintained by the ILockBytes implementation are written
    ///out to the underlying physical storage.
    ///Returns:
    ///    This method can return one of these values.
    ///    
    HRESULT Flush();
    ///The <b>SetSize</b> method changes the size of the byte array.
    ///Params:
    ///    cb = Specifies the new size of the byte array as a number of bytes.
    ///Returns:
    ///    This method can return one of these values.
    ///    
    HRESULT SetSize(ULARGE_INTEGER cb);
    ///The <b>LockRegion</b> method restricts access to a specified range of bytes in the byte array.
    ///Params:
    ///    libOffset = Specifies the byte offset for the beginning of the range.
    ///    cb = Specifies, in bytes, the length of the range to be restricted.
    ///    dwLockType = Specifies the type of restrictions being requested on accessing the range. This parameter uses one of the
    ///                 values from the LOCKTYPE enumeration.
    ///Returns:
    ///    This method can return one of these values.
    ///    
    HRESULT LockRegion(ULARGE_INTEGER libOffset, ULARGE_INTEGER cb, uint dwLockType);
    ///The <b>UnlockRegion</b> method removes the access restriction on a previously locked range of bytes.
    ///Params:
    ///    libOffset = Specifies the byte offset for the beginning of the range.
    ///    cb = Specifies, in bytes, the length of the range that is restricted.
    ///    dwLockType = Specifies the type of access restrictions previously placed on the range. This parameter uses a value from
    ///                 the LOCKTYPE enumeration.
    ///Returns:
    ///    This method can return one of these values.
    ///    
    HRESULT UnlockRegion(ULARGE_INTEGER libOffset, ULARGE_INTEGER cb, uint dwLockType);
    ///The <b>Stat</b> method retrieves a STATSTG structure containing information for this byte array object.
    ///Params:
    ///    pstatstg = Pointer to a STATSTG structure in which this method places information about this byte array object. The
    ///               pointer is <b>NULL</b> if an error occurs.
    ///    grfStatFlag = Specifies whether this method should supply the <b>pwcsName</b> member of the STATSTG structure through
    ///                  values taken from the STATFLAG enumeration. If the STATFLAG_NONAME is specified, the <b>pwcsName</b> member
    ///                  of <b>STATSTG</b> is not supplied, thus saving a memory-allocation operation. The other possible value,
    ///                  STATFLAG_DEFAULT, indicates that all members of the <b>STATSTG</b> structure be supplied.
    ///Returns:
    ///    This method can return one of these values.
    ///    
    HRESULT Stat(STATSTG* pstatstg, uint grfStatFlag);
}

///The <b>IRootStorage</b> interface contains a single method that switches a storage object to a different underlying
///file and saves the storage object to that file. The save operation occurs even with low-memory conditions and
///uncommitted changes to the storage object. A subsequent call to IStorage::Commit is guaranteed to not consume
///additional memory.
@GUID("00000012-0000-0000-C000-000000000046")
interface IRootStorage : IUnknown
{
    ///The <b>SwitchToFile</b> method copies the current file associated with the storage object to a new file. The new
    ///file is then used for the storage object and any uncommitted changes.
    ///Params:
    ///    pszFile = A pointer to a null terminated string that specifies the file name for the new file. It cannot be the name of
    ///              an existing file. If <b>NULL</b>, this method creates a temporary file with a unique name, and you can call
    ///              IStorage::Stat to retrieve the name of the temporary file.
    ///Returns:
    ///    This method can return one of these values.
    ///    
    HRESULT SwitchToFile(PWSTR pszFile);
}

///The <b>IFillLockBytes</b> interface enables downloading code to write data asynchronously to a structured storage
///byte array. When the downloading code has new data available, it calls IFillLockBytes::FillAppend or
///IFillLockBytes::FillAt to write the data to the byte array. An application attempting to access this data, through
///calls to the ILockBytes interface, can do so even as the downloader continues to make calls to <b>IFillLockBytes</b>.
///If the application attempts to access data that has not already been downloaded through a call to
///<b>IFillLockBytes</b>, then <b>ILockBytes</b> returns a new error, E_PENDING.
@GUID("99CAF010-415E-11CF-8814-00AA00B569F5")
interface IFillLockBytes : IUnknown
{
    ///The <b>FillAppend</b> method writes a new block of bytes to the end of a byte array.
    ///Params:
    ///    pv = Pointer to the data to be appended to the end of an existing byte array. This operation does not create a
    ///         danger of a memory leak or a buffer overrun.
    ///    cb = Size of <i>pv</i> in bytes.
    ///    pcbWritten = Number of bytes that were successfully written.
    ///Returns:
    ///    This function supports the standard return values E_OUTOFMEMORY, E_UNEXPECTED, E_INVALIDARG, and E_FAIL.
    ///    
    HRESULT FillAppend(const(void)* pv, uint cb, uint* pcbWritten);
    ///The <b>FillAt</b> method writes a new block of data to a specified location in the byte array.
    ///Params:
    ///    ulOffset = The offset, expressed in number of bytes, from the first element of the byte array.
    ///    pv = Pointer to the data to be written at the location specified by <i>uIOffset</i>.
    ///    cb = Size of <i>pv</i> in bytes.
    ///    pcbWritten = Number of bytes that were successfully written.
    ///Returns:
    ///    This function supports the standard return values E_OUTOFMEMORY, E_UNEXPECTED, E_INVALIDARG, and E_FAIL in
    ///    addition to the following:
    ///    
    HRESULT FillAt(ULARGE_INTEGER ulOffset, const(void)* pv, uint cb, uint* pcbWritten);
    ///The <b>SetFillSize</b> method sets the expected size of the byte array.
    ///Params:
    ///    ulSize = Size in bytes of the byte array object that is to be filled in subsequent calls to
    ///             IFillLockBytes::FillAppend.
    ///Returns:
    ///    This function supports the standard return values E_OUTOFMEMORY, E_UNEXPECTED, E_INVALIDARG, and E_FAIL.
    ///    
    HRESULT SetFillSize(ULARGE_INTEGER ulSize);
    ///The <b>Terminate</b> method informs the byte array that the download has been terminated, either successfully or
    ///unsuccessfully.
    ///Params:
    ///    bCanceled = Download is complete. If <b>TRUE</b>, the download was terminated unsuccessfully. If <b>FALSE</b>, the
    ///                download terminated successfully.
    ///Returns:
    ///    This function supports the standard return values E_OUTOFMEMORY, E_UNEXPECTED, E_INVALIDARG, and E_FAIL.
    ///    
    HRESULT Terminate(BOOL bCanceled);
}

///The <b>ILayoutStorage</b> interface enables an application to optimize the layout of its compound files for efficient
///downloading across a slow link. The goal is to enable a browser or other application to download data in the order in
///which it will actually be required. To optimize a compound file, an application calls CopyTo to layout a docfile,
///thus improving performance in most scenarios.
@GUID("0E6D4D90-6738-11CF-9608-00AA00680DB4")
interface ILayoutStorage : IUnknown
{
    ///The <b>LayoutScript</b> method provides explicit directions for reordering the storages, streams, and controls in
    ///a compound file to match the order in which they are accessed during the download.
    ///Params:
    ///    pStorageLayout = Pointer to an array of StorageLayout structures.
    ///    nEntries = Number of entries in the array of StorageLayout structures.
    ///    glfInterleavedFlag = Reserved for future use.
    ///Returns:
    ///    This function supports the standard return values E_OUTOFMEMORY, E_UNEXPECTED, E_INVALIDARG, and E_FAIL, as
    ///    well as the following:
    ///    
    HRESULT LayoutScript(StorageLayout* pStorageLayout, uint nEntries, uint glfInterleavedFlag);
    ///The <b>BeginMonitor</b> method is used to begin monitoring when a loading operation is started. When the
    ///operation is complete, the application must call ILayoutStorage::EndMonitor.
    ///Returns:
    ///    This method supports the standard return values E_OUTOFMEMORY, E_UNEXPECTED, E_INVALIDARG, and E_FAIL, as
    ///    well as the following:
    ///    
    HRESULT BeginMonitor();
    ///The <b>EndMonitor</b> method ends monitoring of a compound file. Must be preceded by a call to
    ///ILayoutStorage::BeginMonitor.
    ///Returns:
    ///    This function supports the standard return values E_OUTOFMEMORY, E_UNEXPECTED, E_INVALIDARG, and E_FAIL, as
    ///    well as all return values for CloseHandle.
    ///    
    HRESULT EndMonitor();
    ///The <b>ReLayoutDocfile</b> method rewrites the compound file, using the layout script obtained through
    ///monitoring, or provided through explicit layout scripting, to create a new compound file.
    ///Params:
    ///    pwcsNewDfName = Pointer to the name of the compound file to be rewritten. This name must be a valid filename, distinct from
    ///                    the name of the original compound file. The original compound file will be optimized and written to the new
    ///                    <i>pwcsNewDfName</i>.
    HRESULT ReLayoutDocfile(PWSTR pwcsNewDfName);
    ///Not supported. The <b>ReLayoutDocfileOnILockBytes</b> method is not implemented. If called, it returns
    ///<b>STG_E_UNIMPLEMENTEDFUNCTION</b>.
    ///Params:
    ///    pILockBytes = A pointer to the ILockBytes interface on the underlying byte-array object where the compound file is to be
    ///                  rewritten.
    ///Returns:
    ///    This method returns the following value. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>STG_E_UNIMPLEMENTEDFUNCTION</b></dt> </dl> </td> <td width="60%"> This method is
    ///    not implemented. </td> </tr> </table>
    ///    
    HRESULT ReLayoutDocfileOnILockBytes(ILockBytes pILockBytes);
}

///The <b>IDirectWriterLock</b> interface enables a single writer to obtain exclusive write access to a root storage
///object opened in direct mode while allowing concurrent access by multiple readers. This single-writer,
///multiple-reader mode does not require the overhead of making a snapshot copy of the storage for the readers.
@GUID("0E6D4D92-6738-11CF-9608-00AA00680DB4")
interface IDirectWriterLock : IUnknown
{
    ///The <b>WaitForWriteAccess</b> method obtains exclusive write access to a storage object.
    ///Params:
    ///    dwTimeout = Specifies the time in milliseconds that this method blocks while waiting to obtain exclusive write access to
    ///                the storage object. If <i>dwTimeout</i> is zero, the method does not block waiting for exclusive access for
    ///                writing. The INFINITE time-out defined in the Platform SDK is allowed for <i>dwTimeout</i>.
    ///Returns:
    ///    This method can return one of these values.
    ///    
    HRESULT WaitForWriteAccess(uint dwTimeout);
    ///The <b>ReleaseWriteAccess</b> method releases the write lock previously obtained.
    ///Returns:
    ///    This method can return one of these values.
    ///    
    HRESULT ReleaseWriteAccess();
    ///The <b>HaveWriteAccess</b> method indicates whether the write lock has been taken.
    ///Returns:
    ///    This method can return one of these values.
    ///    
    HRESULT HaveWriteAccess();
}


// GUIDs


const GUID IID_IDirectWriterLock   = GUIDOF!IDirectWriterLock;
const GUID IID_IEnumSTATPROPSETSTG = GUIDOF!IEnumSTATPROPSETSTG;
const GUID IID_IEnumSTATPROPSTG    = GUIDOF!IEnumSTATPROPSTG;
const GUID IID_IEnumSTATSTG        = GUIDOF!IEnumSTATSTG;
const GUID IID_IFillLockBytes      = GUIDOF!IFillLockBytes;
const GUID IID_ILayoutStorage      = GUIDOF!ILayoutStorage;
const GUID IID_ILockBytes          = GUIDOF!ILockBytes;
const GUID IID_IPropertySetStorage = GUIDOF!IPropertySetStorage;
const GUID IID_IPropertyStorage    = GUIDOF!IPropertyStorage;
const GUID IID_IRootStorage        = GUIDOF!IRootStorage;
const GUID IID_ISequentialStream   = GUIDOF!ISequentialStream;
const GUID IID_IStorage            = GUIDOF!IStorage;
const GUID IID_IStream             = GUIDOF!IStream;
