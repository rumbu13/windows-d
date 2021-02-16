module windows.structuredstorage;

public import windows.core;
public import windows.automation : BSTR, IDispatch, SAFEARRAY;
public import windows.com : DVTARGETDEVICE, HRESULT, IBindStatusCallback, IUnknown, OLESTREAM, STGMEDIUM;
public import windows.shell : SERIALIZEDPROPERTYVALUE;
public import windows.systemservices : BOOL, BSTRBLOB, CLIPDATA, CY, DECIMAL, LARGE_INTEGER, ULARGE_INTEGER;
public import windows.winsock : BLOB;
public import windows.windowsandmessaging : HWND;
public import windows.windowsprogramming : FILETIME;

extern(Windows):


// Enums


enum : int
{
    STGTY_STORAGE   = 0x00000001,
    STGTY_STREAM    = 0x00000002,
    STGTY_LOCKBYTES = 0x00000003,
    STGTY_PROPERTY  = 0x00000004,
}
alias STGTY = int;

enum : int
{
    STREAM_SEEK_SET = 0x00000000,
    STREAM_SEEK_CUR = 0x00000001,
    STREAM_SEEK_END = 0x00000002,
}
alias STREAM_SEEK = int;

enum : int
{
    LOCK_WRITE     = 0x00000001,
    LOCK_EXCLUSIVE = 0x00000002,
    LOCK_ONLYONCE  = 0x00000004,
}
alias LOCKTYPE = int;

enum : int
{
    STGC_DEFAULT                            = 0x00000000,
    STGC_OVERWRITE                          = 0x00000001,
    STGC_ONLYIFCURRENT                      = 0x00000002,
    STGC_DANGEROUSLYCOMMITMERELYTODISKCACHE = 0x00000004,
    STGC_CONSOLIDATE                        = 0x00000008,
}
alias STGC = int;

enum : int
{
    STGMOVE_MOVE        = 0x00000000,
    STGMOVE_COPY        = 0x00000001,
    STGMOVE_SHALLOWCOPY = 0x00000002,
}
alias STGMOVE = int;

enum : int
{
    STATFLAG_DEFAULT = 0x00000000,
    STATFLAG_NONAME  = 0x00000001,
    STATFLAG_NOOPEN  = 0x00000002,
}
alias STATFLAG = int;

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
alias PIDMSI_STATUS_VALUE = int;

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
alias JET_RELOP = int;

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
alias JET_ERRCAT = int;

enum : int
{
    JET_IndexCheckingOff              = 0x00000000,
    JET_IndexCheckingOn               = 0x00000001,
    JET_IndexCheckingDeferToOpenTable = 0x00000002,
    JET_IndexCheckingMax              = 0x00000003,
}
alias JET_INDEXCHECKING = int;

// Callbacks

alias JET_PFNSTATUS = int function(uint sesid, uint snp, uint snt, void* pv);
alias JET_CALLBACK = int function(uint sesid, uint dbid, uint tableid, uint cbtyp, void* pvArg1, void* pvArg2, 
                                  void* pvContext, uint ulUnused);
alias JET_PFNDURABLECOMMITCALLBACK = int function(uint instance, JET_COMMIT_ID* pCommitIdSeen, uint grbit);
alias JET_PFNREALLOC = void* function(void* pvContext, void* pv, uint cb);

// Structs


struct STATSTG
{
    ushort*        pwcsName;
    uint           type;
    ULARGE_INTEGER cbSize;
    FILETIME       mtime;
    FILETIME       ctime;
    FILETIME       atime;
    uint           grfMode;
    uint           grfLocksSupported;
    GUID           clsid;
    uint           grfStateBits;
    uint           reserved;
}

struct RemSNB
{
    uint      ulCntStr;
    uint      ulCntChar;
    ushort[1] rgString;
}

struct StorageLayout
{
    uint          LayoutType;
    ushort*       pwcsElementName;
    LARGE_INTEGER cOffset;
    LARGE_INTEGER cBytes;
}

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
    uint   cElems;
    byte** pElems;
}

struct CALPWSTR
{
    uint     cElems;
    ushort** pElems;
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
                const(char)*     pszVal;
                const(wchar)*    pwszVal;
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

struct PROPSPEC
{
    uint ulKind;
    union
    {
        uint    propid;
        ushort* lpwstr;
    }
}

struct STATPROPSTG
{
    ushort* lpwstrName;
    uint    propid;
    ushort  vt;
}

struct STATPROPSETSTG
{
    GUID     fmtid;
    GUID     clsid;
    uint     grfFlags;
    FILETIME mtime;
    FILETIME ctime;
    FILETIME atime;
    uint     dwOSVersion;
}

struct STGOPTIONS
{
    ushort        usVersion;
    ushort        reserved;
    uint          ulSectorSize;
    const(wchar)* pwcsTemplateFile;
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
    ushort* szDatabaseName;
    ushort* szNewDatabaseName;
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
    ushort* szOldDll;
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
    uint    cbStruct;
    ushort* szColumnName;
    uint    coltyp;
    uint    cbMax;
    uint    grbit;
    void*   pvDefault;
    uint    cbDefault;
    uint    cp;
    uint    columnid;
    int     err;
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
    ushort* szCallback;
    ubyte*  pbUserData;
    uint    cbUserData;
    ushort* szDependantColumns;
}

struct JET_CONDITIONALCOLUMN_A
{
    uint  cbStruct;
    byte* szColumnName;
    uint  grbit;
}

struct JET_CONDITIONALCOLUMN_W
{
    uint    cbStruct;
    ushort* szColumnName;
    uint    grbit;
}

struct JET_UNICODEINDEX
{
    uint lcid;
    uint dwMapFlags;
}

struct JET_UNICODEINDEX2
{
    ushort* szLocaleName;
    uint    dwMapFlags;
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
    uint    cbStruct;
    ushort* szIndexName;
    ushort* szKey;
    uint    cbKey;
    uint    grbit;
    uint    ulDensity;
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
    uint    cConditionalColumn;
    int     err;
    uint    cbKeyMost;
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
    ushort*         szIndexName;
    ushort*         szKey;
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
    ushort*            szIndexName;
    ushort*            szKey;
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
    ushort*            szTableName;
    ushort*            szTemplateTableName;
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
    ushort*            szTableName;
    ushort*            szTemplateTableName;
    uint               ulPages;
    uint               ulDensity;
    tag_JET_COLUMNCREATE_W* rgcolumncreate;
    uint               cColumns;
    JET_INDEXCREATE_W* rgindexcreate;
    uint               cIndexes;
    ushort*            szCallback;
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
    ushort*             szTableName;
    ushort*             szTemplateTableName;
    uint                ulPages;
    uint                ulDensity;
    tag_JET_COLUMNCREATE_W* rgcolumncreate;
    uint                cColumns;
    JET_INDEXCREATE2_W* rgindexcreate;
    uint                cIndexes;
    ushort*             szCallback;
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
    ushort*             szTableName;
    ushort*             szTemplateTableName;
    uint                ulPages;
    uint                ulDensity;
    tag_JET_COLUMNCREATE_W* rgcolumncreate;
    uint                cColumns;
    JET_INDEXCREATE3_W* rgindexcreate;
    uint                cIndexes;
    ushort*             szCallback;
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
    uint          paramid;
    uint          lParam;
    const(wchar)* sz;
    int           err;
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
    ushort*  szInstanceName;
    uint     cDatabases;
    ushort** szDatabaseFileName;
    ushort** szDatabaseDisplayName;
    ushort** szDatabaseSLVFileName_Obsolete;
}

// Functions

@DllImport("OLE32")
HRESULT CreateStreamOnHGlobal(ptrdiff_t hGlobal, BOOL fDeleteOnRelease, IStream* ppstm);

@DllImport("OLE32")
HRESULT GetHGlobalFromStream(IStream pstm, ptrdiff_t* phglobal);

@DllImport("OLE32")
HRESULT PropVariantCopy(PROPVARIANT* pvarDest, const(PROPVARIANT)* pvarSrc);

@DllImport("OLE32")
HRESULT PropVariantClear(PROPVARIANT* pvar);

@DllImport("OLE32")
HRESULT FreePropVariantArray(uint cVariants, char* rgvars);

@DllImport("OLE32")
HRESULT WriteFmtUserTypeStg(IStorage pstg, ushort cf, ushort* lpszUserType);

@DllImport("OLE32")
HRESULT ReadFmtUserTypeStg(IStorage pstg, ushort* pcf, ushort** lplpszUserType);

@DllImport("ole32")
HRESULT OleConvertOLESTREAMToIStorage(OLESTREAM* lpolestream, IStorage pstg, const(DVTARGETDEVICE)* ptd);

@DllImport("ole32")
HRESULT OleConvertIStorageToOLESTREAM(IStorage pstg, OLESTREAM* lpolestream);

@DllImport("OLE32")
HRESULT SetConvertStg(IStorage pStg, BOOL fConvert);

@DllImport("ole32")
HRESULT OleConvertIStorageToOLESTREAMEx(IStorage pstg, ushort cfFormat, int lWidth, int lHeight, uint dwSize, 
                                        STGMEDIUM* pmedium, OLESTREAM* polestm);

@DllImport("ole32")
HRESULT OleConvertOLESTREAMToIStorageEx(OLESTREAM* polestm, IStorage pstg, ushort* pcfFormat, int* plwWidth, 
                                        int* plHeight, uint* pdwSize, STGMEDIUM* pmedium);

@DllImport("PROPSYS")
HRESULT StgSerializePropVariant(const(PROPVARIANT)* ppropvar, SERIALIZEDPROPERTYVALUE** ppProp, uint* pcb);

@DllImport("PROPSYS")
HRESULT StgDeserializePropVariant(const(SERIALIZEDPROPERTYVALUE)* pprop, uint cbMax, PROPVARIANT* ppropvar);

@DllImport("OLE32")
HRESULT StgCreateDocfile(const(wchar)* pwcsName, uint grfMode, uint reserved, IStorage* ppstgOpen);

@DllImport("OLE32")
HRESULT StgCreateDocfileOnILockBytes(ILockBytes plkbyt, uint grfMode, uint reserved, IStorage* ppstgOpen);

@DllImport("OLE32")
HRESULT StgOpenStorage(const(wchar)* pwcsName, IStorage pstgPriority, uint grfMode, ushort** snbExclude, 
                       uint reserved, IStorage* ppstgOpen);

@DllImport("OLE32")
HRESULT StgOpenStorageOnILockBytes(ILockBytes plkbyt, IStorage pstgPriority, uint grfMode, ushort** snbExclude, 
                                   uint reserved, IStorage* ppstgOpen);

@DllImport("OLE32")
HRESULT StgIsStorageFile(const(wchar)* pwcsName);

@DllImport("OLE32")
HRESULT StgIsStorageILockBytes(ILockBytes plkbyt);

@DllImport("OLE32")
HRESULT StgSetTimes(const(wchar)* lpszName, const(FILETIME)* pctime, const(FILETIME)* patime, 
                    const(FILETIME)* pmtime);

@DllImport("OLE32")
HRESULT StgCreateStorageEx(const(wchar)* pwcsName, uint grfMode, uint stgfmt, uint grfAttrs, 
                           STGOPTIONS* pStgOptions, void* pSecurityDescriptor, const(GUID)* riid, 
                           void** ppObjectOpen);

@DllImport("OLE32")
HRESULT StgOpenStorageEx(const(wchar)* pwcsName, uint grfMode, uint stgfmt, uint grfAttrs, STGOPTIONS* pStgOptions, 
                         void* pSecurityDescriptor, const(GUID)* riid, void** ppObjectOpen);

@DllImport("OLE32")
HRESULT StgCreatePropStg(IUnknown pUnk, const(GUID)* fmtid, const(GUID)* pclsid, uint grfFlags, uint dwReserved, 
                         IPropertyStorage* ppPropStg);

@DllImport("OLE32")
HRESULT StgOpenPropStg(IUnknown pUnk, const(GUID)* fmtid, uint grfFlags, uint dwReserved, 
                       IPropertyStorage* ppPropStg);

@DllImport("OLE32")
HRESULT StgCreatePropSetStg(IStorage pStorage, uint dwReserved, IPropertySetStorage* ppPropSetStg);

@DllImport("OLE32")
HRESULT FmtIdToPropStgName(const(GUID)* pfmtid, char* oszName);

@DllImport("OLE32")
HRESULT PropStgNameToFmtId(const(ushort)* oszName, GUID* pfmtid);

@DllImport("OLE32")
HRESULT ReadClassStg(IStorage pStg, GUID* pclsid);

@DllImport("OLE32")
HRESULT WriteClassStg(IStorage pStg, const(GUID)* rclsid);

@DllImport("OLE32")
HRESULT ReadClassStm(IStream pStm, GUID* pclsid);

@DllImport("OLE32")
HRESULT WriteClassStm(IStream pStm, const(GUID)* rclsid);

@DllImport("OLE32")
HRESULT GetHGlobalFromILockBytes(ILockBytes plkbyt, ptrdiff_t* phglobal);

@DllImport("OLE32")
HRESULT CreateILockBytesOnHGlobal(ptrdiff_t hGlobal, BOOL fDeleteOnRelease, ILockBytes* pplkbyt);

@DllImport("OLE32")
HRESULT GetConvertStg(IStorage pStg);

@DllImport("ole32")
uint CoBuildVersion();

@DllImport("ole32")
HRESULT DcomChannelSetHResult(void* pvReserved, uint* pulReserved, HRESULT appsHR);

@DllImport("ole32")
HRESULT StgOpenAsyncDocfileOnIFillLockBytes(IFillLockBytes pflb, uint grfMode, uint asyncFlags, 
                                            IStorage* ppstgOpen);

@DllImport("ole32")
HRESULT StgGetIFillLockBytesOnILockBytes(ILockBytes pilb, IFillLockBytes* ppflb);

@DllImport("ole32")
HRESULT StgGetIFillLockBytesOnFile(const(ushort)* pwcsName, IFillLockBytes* ppflb);

@DllImport("dflayout")
HRESULT StgOpenLayoutDocfile(const(ushort)* pwcsDfName, uint grfMode, uint reserved, IStorage* ppstgOpen);

@DllImport("ole32")
SERIALIZEDPROPERTYVALUE* StgConvertVariantToProperty(const(PROPVARIANT)* pvar, ushort CodePage, char* pprop, 
                                                     uint* pcb, uint pid, ubyte fReserved, uint* pcIndirect);

@DllImport("ole32")
ubyte StgConvertPropertyToVariant(const(SERIALIZEDPROPERTYVALUE)* pprop, ushort CodePage, PROPVARIANT* pvar, 
                                  PMemoryAllocator* pma);

@DllImport("ole32")
HRESULT CreateStdProgressIndicator(HWND hwndParent, ushort* pszTitle, IBindStatusCallback pIbscCaller, 
                                   IBindStatusCallback* ppIbsc);

@DllImport("ole32")
uint StgPropertyLengthAsVariant(char* pProp, uint cbProp, ushort CodePage, ubyte bReserved);

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
int JetGetInstanceMiscInfo(uint instance, char* pvResult, uint cbMax, uint InfoLevel);

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
int JetGetSystemParameterA(uint instance, uint sesid, uint paramid, uint* plParam, char* szParam, uint cbMax);

@DllImport("ESENT")
int JetGetSystemParameterW(uint instance, uint sesid, uint paramid, uint* plParam, char* szParam, uint cbMax);

@DllImport("ESENT")
int JetEnableMultiInstanceA(char* psetsysparam, uint csetsysparam, uint* pcsetsucceed);

@DllImport("ESENT")
int JetEnableMultiInstanceW(char* psetsysparam, uint csetsysparam, uint* pcsetsucceed);

@DllImport("ESENT")
int JetGetThreadStats(char* pvResult, uint cbMax);

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
                      char* pvResult, uint cbMax, uint InfoLevel);

@DllImport("ESENT")
int JetGetObjectInfoW(uint sesid, uint dbid, uint objtyp, ushort* szContainerName, ushort* szObjectName, 
                      char* pvResult, uint cbMax, uint InfoLevel);

@DllImport("ESENT")
int JetGetTableInfoA(uint sesid, uint tableid, char* pvResult, uint cbMax, uint InfoLevel);

@DllImport("ESENT")
int JetGetTableInfoW(uint sesid, uint tableid, char* pvResult, uint cbMax, uint InfoLevel);

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
int JetGetTableColumnInfoA(uint sesid, uint tableid, byte* szColumnName, char* pvResult, uint cbMax, 
                           uint InfoLevel);

@DllImport("ESENT")
int JetGetTableColumnInfoW(uint sesid, uint tableid, ushort* szColumnName, char* pvResult, uint cbMax, 
                           uint InfoLevel);

@DllImport("ESENT")
int JetGetColumnInfoA(uint sesid, uint dbid, byte* szTableName, byte* pColumnNameOrId, char* pvResult, uint cbMax, 
                      uint InfoLevel);

@DllImport("ESENT")
int JetGetColumnInfoW(uint sesid, uint dbid, ushort* szTableName, ushort* pwColumnNameOrId, char* pvResult, 
                      uint cbMax, uint InfoLevel);

@DllImport("ESENT")
int JetAddColumnA(uint sesid, uint tableid, byte* szColumnName, const(JET_COLUMNDEF)* pcolumndef, char* pvDefault, 
                  uint cbDefault, uint* pcolumnid);

@DllImport("ESENT")
int JetAddColumnW(uint sesid, uint tableid, ushort* szColumnName, const(JET_COLUMNDEF)* pcolumndef, 
                  char* pvDefault, uint cbDefault, uint* pcolumnid);

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
int JetSetColumnDefaultValueA(uint sesid, uint dbid, byte* szTableName, byte* szColumnName, char* pvData, 
                              const(uint) cbData, const(uint) grbit);

@DllImport("ESENT")
int JetSetColumnDefaultValueW(uint sesid, uint dbid, ushort* szTableName, ushort* szColumnName, char* pvData, 
                              const(uint) cbData, const(uint) grbit);

@DllImport("ESENT")
int JetGetTableIndexInfoA(uint sesid, uint tableid, byte* szIndexName, char* pvResult, uint cbResult, 
                          uint InfoLevel);

@DllImport("ESENT")
int JetGetTableIndexInfoW(uint sesid, uint tableid, ushort* szIndexName, char* pvResult, uint cbResult, 
                          uint InfoLevel);

@DllImport("ESENT")
int JetGetIndexInfoA(uint sesid, uint dbid, byte* szTableName, byte* szIndexName, char* pvResult, uint cbResult, 
                     uint InfoLevel);

@DllImport("ESENT")
int JetGetIndexInfoW(uint sesid, uint dbid, ushort* szTableName, ushort* szIndexName, char* pvResult, 
                     uint cbResult, uint InfoLevel);

@DllImport("ESENT")
int JetCreateIndexA(uint sesid, uint tableid, byte* szIndexName, uint grbit, char* szKey, uint cbKey, 
                    uint lDensity);

@DllImport("ESENT")
int JetCreateIndexW(uint sesid, uint tableid, ushort* szIndexName, uint grbit, const(wchar)* szKey, uint cbKey, 
                    uint lDensity);

@DllImport("ESENT")
int JetCreateIndex2A(uint sesid, uint tableid, char* pindexcreate, uint cIndexCreate);

@DllImport("ESENT")
int JetCreateIndex2W(uint sesid, uint tableid, char* pindexcreate, uint cIndexCreate);

@DllImport("ESENT")
int JetCreateIndex3A(uint sesid, uint tableid, char* pindexcreate, uint cIndexCreate);

@DllImport("ESENT")
int JetCreateIndex3W(uint sesid, uint tableid, char* pindexcreate, uint cIndexCreate);

@DllImport("ESENT")
int JetCreateIndex4A(uint sesid, uint tableid, char* pindexcreate, uint cIndexCreate);

@DllImport("ESENT")
int JetCreateIndex4W(uint sesid, uint tableid, char* pindexcreate, uint cIndexCreate);

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
int JetGetDatabaseInfoA(uint sesid, uint dbid, char* pvResult, uint cbMax, uint InfoLevel);

@DllImport("ESENT")
int JetGetDatabaseInfoW(uint sesid, uint dbid, char* pvResult, uint cbMax, uint InfoLevel);

@DllImport("ESENT")
int JetGetDatabaseFileInfoA(byte* szDatabaseName, char* pvResult, uint cbMax, uint InfoLevel);

@DllImport("ESENT")
int JetGetDatabaseFileInfoW(ushort* szDatabaseName, char* pvResult, uint cbMax, uint InfoLevel);

@DllImport("ESENT")
int JetOpenDatabaseA(uint sesid, byte* szFilename, byte* szConnect, uint* pdbid, uint grbit);

@DllImport("ESENT")
int JetOpenDatabaseW(uint sesid, ushort* szFilename, ushort* szConnect, uint* pdbid, uint grbit);

@DllImport("ESENT")
int JetCloseDatabase(uint sesid, uint dbid, uint grbit);

@DllImport("ESENT")
int JetOpenTableA(uint sesid, uint dbid, byte* szTableName, char* pvParameters, uint cbParameters, uint grbit, 
                  uint* ptableid);

@DllImport("ESENT")
int JetOpenTableW(uint sesid, uint dbid, ushort* szTableName, char* pvParameters, uint cbParameters, uint grbit, 
                  uint* ptableid);

@DllImport("ESENT")
int JetSetTableSequential(uint sesid, uint tableid, uint grbit);

@DllImport("ESENT")
int JetResetTableSequential(uint sesid, uint tableid, uint grbit);

@DllImport("ESENT")
int JetCloseTable(uint sesid, uint tableid);

@DllImport("ESENT")
int JetDelete(uint sesid, uint tableid);

@DllImport("ESENT")
int JetUpdate(uint sesid, uint tableid, char* pvBookmark, uint cbBookmark, uint* pcbActual);

@DllImport("ESENT")
int JetUpdate2(uint sesid, uint tableid, char* pvBookmark, uint cbBookmark, uint* pcbActual, const(uint) grbit);

@DllImport("ESENT")
int JetEscrowUpdate(uint sesid, uint tableid, uint columnid, char* pv, uint cbMax, char* pvOld, uint cbOldMax, 
                    uint* pcbOldActual, uint grbit);

@DllImport("ESENT")
int JetRetrieveColumn(uint sesid, uint tableid, uint columnid, char* pvData, uint cbData, uint* pcbActual, 
                      uint grbit, JET_RETINFO* pretinfo);

@DllImport("ESENT")
int JetRetrieveColumns(uint sesid, uint tableid, char* pretrievecolumn, uint cretrievecolumn);

@DllImport("ESENT")
int JetEnumerateColumns(uint sesid, uint tableid, uint cEnumColumnId, char* rgEnumColumnId, uint* pcEnumColumn, 
                        JET_ENUMCOLUMN** prgEnumColumn, JET_PFNREALLOC pfnRealloc, void* pvReallocContext, 
                        uint cbDataMost, uint grbit);

@DllImport("ESENT")
int JetGetRecordSize(uint sesid, uint tableid, JET_RECSIZE* precsize, const(uint) grbit);

@DllImport("ESENT")
int JetGetRecordSize2(uint sesid, uint tableid, JET_RECSIZE2* precsize, const(uint) grbit);

@DllImport("ESENT")
int JetSetColumn(uint sesid, uint tableid, uint columnid, char* pvData, uint cbData, uint grbit, 
                 JET_SETINFO* psetinfo);

@DllImport("ESENT")
int JetSetColumns(uint sesid, uint tableid, char* psetcolumn, uint csetcolumn);

@DllImport("ESENT")
int JetPrepareUpdate(uint sesid, uint tableid, uint prep);

@DllImport("ESENT")
int JetGetRecordPosition(uint sesid, uint tableid, char* precpos, uint cbRecpos);

@DllImport("ESENT")
int JetGotoPosition(uint sesid, uint tableid, JET_RECPOS* precpos);

@DllImport("ESENT")
int JetGetCursorInfo(uint sesid, uint tableid, char* pvResult, uint cbMax, uint InfoLevel);

@DllImport("ESENT")
int JetDupCursor(uint sesid, uint tableid, uint* ptableid, uint grbit);

@DllImport("ESENT")
int JetGetCurrentIndexA(uint sesid, uint tableid, char* szIndexName, uint cbIndexName);

@DllImport("ESENT")
int JetGetCurrentIndexW(uint sesid, uint tableid, char* szIndexName, uint cbIndexName);

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
int JetSetCursorFilter(uint sesid, uint tableid, char* rgColumnFilters, uint cColumnFilters, uint grbit);

@DllImport("ESENT")
int JetGetLock(uint sesid, uint tableid, uint grbit);

@DllImport("ESENT")
int JetMakeKey(uint sesid, uint tableid, char* pvData, uint cbData, uint grbit);

@DllImport("ESENT")
int JetSeek(uint sesid, uint tableid, uint grbit);

@DllImport("ESENT")
int JetPrereadKeys(uint sesid, uint tableid, char* rgpvKeys, char* rgcbKeys, int ckeys, int* pckeysPreread, 
                   uint grbit);

@DllImport("ESENT")
int JetPrereadIndexRanges(uint sesid, uint tableid, char* rgIndexRanges, const(uint) cIndexRanges, 
                          uint* pcRangesPreread, char* rgcolumnidPreread, const(uint) ccolumnidPreread, uint grbit);

@DllImport("ESENT")
int JetGetBookmark(uint sesid, uint tableid, char* pvBookmark, uint cbMax, uint* pcbActual);

@DllImport("ESENT")
int JetGetSecondaryIndexBookmark(uint sesid, uint tableid, char* pvSecondaryKey, uint cbSecondaryKeyMax, 
                                 uint* pcbSecondaryKeyActual, char* pvPrimaryBookmark, uint cbPrimaryBookmarkMax, 
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
int JetGotoBookmark(uint sesid, uint tableid, char* pvBookmark, uint cbBookmark);

@DllImport("ESENT")
int JetGotoSecondaryIndexBookmark(uint sesid, uint tableid, char* pvSecondaryKey, uint cbSecondaryKey, 
                                  char* pvPrimaryBookmark, uint cbPrimaryBookmark, const(uint) grbit);

@DllImport("ESENT")
int JetIntersectIndexes(uint sesid, char* rgindexrange, uint cindexrange, JET_RECORDLIST* precordlist, uint grbit);

@DllImport("ESENT")
int JetComputeStats(uint sesid, uint tableid);

@DllImport("ESENT")
int JetOpenTempTable(uint sesid, char* prgcolumndef, uint ccolumn, uint grbit, uint* ptableid, char* prgcolumnid);

@DllImport("ESENT")
int JetOpenTempTable2(uint sesid, char* prgcolumndef, uint ccolumn, uint lcid, uint grbit, uint* ptableid, 
                      char* prgcolumnid);

@DllImport("ESENT")
int JetOpenTempTable3(uint sesid, char* prgcolumndef, uint ccolumn, JET_UNICODEINDEX* pidxunicode, uint grbit, 
                      uint* ptableid, char* prgcolumnid);

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
int JetRetrieveKey(uint sesid, uint tableid, char* pvKey, uint cbMax, uint* pcbActual, uint grbit);

@DllImport("ESENT")
int JetBeginExternalBackup(uint grbit);

@DllImport("ESENT")
int JetBeginExternalBackupInstance(uint instance, uint grbit);

@DllImport("ESENT")
int JetGetAttachInfoA(char* szzDatabases, uint cbMax, uint* pcbActual);

@DllImport("ESENT")
int JetGetAttachInfoW(char* wszzDatabases, uint cbMax, uint* pcbActual);

@DllImport("ESENT")
int JetGetAttachInfoInstanceA(uint instance, char* szzDatabases, uint cbMax, uint* pcbActual);

@DllImport("ESENT")
int JetGetAttachInfoInstanceW(uint instance, char* szzDatabases, uint cbMax, uint* pcbActual);

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
int JetReadFile(uint hfFile, char* pv, uint cb, uint* pcbActual);

@DllImport("ESENT")
int JetReadFileInstance(uint instance, uint hfFile, char* pv, uint cb, uint* pcbActual);

@DllImport("ESENT")
int JetCloseFile(uint hfFile);

@DllImport("ESENT")
int JetCloseFileInstance(uint instance, uint hfFile);

@DllImport("ESENT")
int JetGetLogInfoA(char* szzLogs, uint cbMax, uint* pcbActual);

@DllImport("ESENT")
int JetGetLogInfoW(char* szzLogs, uint cbMax, uint* pcbActual);

@DllImport("ESENT")
int JetGetLogInfoInstanceA(uint instance, char* szzLogs, uint cbMax, uint* pcbActual);

@DllImport("ESENT")
int JetGetLogInfoInstanceW(uint instance, char* wszzLogs, uint cbMax, uint* pcbActual);

@DllImport("ESENT")
int JetGetLogInfoInstance2A(uint instance, char* szzLogs, uint cbMax, uint* pcbActual, JET_LOGINFO_A* pLogInfo);

@DllImport("ESENT")
int JetGetLogInfoInstance2W(uint instance, char* wszzLogs, uint cbMax, uint* pcbActual, JET_LOGINFO_W* pLogInfo);

@DllImport("ESENT")
int JetGetTruncateLogInfoInstanceA(uint instance, char* szzLogs, uint cbMax, uint* pcbActual);

@DllImport("ESENT")
int JetGetTruncateLogInfoInstanceW(uint instance, char* wszzLogs, uint cbMax, uint* pcbActual);

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
int JetExternalRestoreA(byte* szCheckpointFilePath, byte* szLogPath, char* rgrstmap, int crstfilemap, 
                        byte* szBackupLogPath, int genLow, int genHigh, JET_PFNSTATUS pfn);

@DllImport("ESENT")
int JetExternalRestoreW(ushort* szCheckpointFilePath, ushort* szLogPath, char* rgrstmap, int crstfilemap, 
                        ushort* szBackupLogPath, int genLow, int genHigh, JET_PFNSTATUS pfn);

@DllImport("ESENT")
int JetExternalRestore2A(byte* szCheckpointFilePath, byte* szLogPath, char* rgrstmap, int crstfilemap, 
                         byte* szBackupLogPath, JET_LOGINFO_A* pLogInfo, byte* szTargetInstanceName, 
                         byte* szTargetInstanceLogPath, byte* szTargetInstanceCheckpointPath, JET_PFNSTATUS pfn);

@DllImport("ESENT")
int JetExternalRestore2W(ushort* szCheckpointFilePath, ushort* szLogPath, char* rgrstmap, int crstfilemap, 
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
int JetGetErrorInfoW(void* pvContext, char* pvResult, uint cbMax, uint InfoLevel, uint grbit);

@DllImport("ESENT")
int JetSetSessionParameter(uint sesid, uint sesparamid, char* pvParam, uint cbParam);

@DllImport("ESENT")
int JetGetSessionParameter(uint sesid, uint sesparamid, char* pvParam, uint cbParamMax, uint* pcbParamActual);


// Interfaces

@GUID("0C733A30-2A1C-11CE-ADE5-00AA0044773D")
interface ISequentialStream : IUnknown
{
    HRESULT Read(char* pv, uint cb, uint* pcbRead);
    HRESULT Write(char* pv, uint cb, uint* pcbWritten);
}

@GUID("0000000C-0000-0000-C000-000000000046")
interface IStream : ISequentialStream
{
    HRESULT Seek(LARGE_INTEGER dlibMove, uint dwOrigin, ULARGE_INTEGER* plibNewPosition);
    HRESULT SetSize(ULARGE_INTEGER libNewSize);
    HRESULT CopyTo(IStream pstm, ULARGE_INTEGER cb, ULARGE_INTEGER* pcbRead, ULARGE_INTEGER* pcbWritten);
    HRESULT Commit(uint grfCommitFlags);
    HRESULT Revert();
    HRESULT LockRegion(ULARGE_INTEGER libOffset, ULARGE_INTEGER cb, uint dwLockType);
    HRESULT UnlockRegion(ULARGE_INTEGER libOffset, ULARGE_INTEGER cb, uint dwLockType);
    HRESULT Stat(STATSTG* pstatstg, uint grfStatFlag);
    HRESULT Clone(IStream* ppstm);
}

@GUID("0000000D-0000-0000-C000-000000000046")
interface IEnumSTATSTG : IUnknown
{
    HRESULT Next(uint celt, char* rgelt, uint* pceltFetched);
    HRESULT Skip(uint celt);
    HRESULT Reset();
    HRESULT Clone(IEnumSTATSTG* ppenum);
}

@GUID("0000000B-0000-0000-C000-000000000046")
interface IStorage : IUnknown
{
    HRESULT CreateStream(const(ushort)* pwcsName, uint grfMode, uint reserved1, uint reserved2, IStream* ppstm);
    HRESULT OpenStream(const(ushort)* pwcsName, void* reserved1, uint grfMode, uint reserved2, IStream* ppstm);
    HRESULT CreateStorage(const(ushort)* pwcsName, uint grfMode, uint reserved1, uint reserved2, IStorage* ppstg);
    HRESULT OpenStorage(const(ushort)* pwcsName, IStorage pstgPriority, uint grfMode, ushort** snbExclude, 
                        uint reserved, IStorage* ppstg);
    HRESULT CopyTo(uint ciidExclude, char* rgiidExclude, ushort** snbExclude, IStorage pstgDest);
    HRESULT MoveElementTo(const(ushort)* pwcsName, IStorage pstgDest, const(ushort)* pwcsNewName, uint grfFlags);
    HRESULT Commit(uint grfCommitFlags);
    HRESULT Revert();
    HRESULT EnumElements(uint reserved1, void* reserved2, uint reserved3, IEnumSTATSTG* ppenum);
    HRESULT DestroyElement(const(ushort)* pwcsName);
    HRESULT RenameElement(const(ushort)* pwcsOldName, const(ushort)* pwcsNewName);
    HRESULT SetElementTimes(const(ushort)* pwcsName, const(FILETIME)* pctime, const(FILETIME)* patime, 
                            const(FILETIME)* pmtime);
    HRESULT SetClass(const(GUID)* clsid);
    HRESULT SetStateBits(uint grfStateBits, uint grfMask);
    HRESULT Stat(STATSTG* pstatstg, uint grfStatFlag);
}

@GUID("0000000A-0000-0000-C000-000000000046")
interface ILockBytes : IUnknown
{
    HRESULT ReadAt(ULARGE_INTEGER ulOffset, char* pv, uint cb, uint* pcbRead);
    HRESULT WriteAt(ULARGE_INTEGER ulOffset, char* pv, uint cb, uint* pcbWritten);
    HRESULT Flush();
    HRESULT SetSize(ULARGE_INTEGER cb);
    HRESULT LockRegion(ULARGE_INTEGER libOffset, ULARGE_INTEGER cb, uint dwLockType);
    HRESULT UnlockRegion(ULARGE_INTEGER libOffset, ULARGE_INTEGER cb, uint dwLockType);
    HRESULT Stat(STATSTG* pstatstg, uint grfStatFlag);
}

@GUID("00000012-0000-0000-C000-000000000046")
interface IRootStorage : IUnknown
{
    HRESULT SwitchToFile(ushort* pszFile);
}

@GUID("99CAF010-415E-11CF-8814-00AA00B569F5")
interface IFillLockBytes : IUnknown
{
    HRESULT FillAppend(char* pv, uint cb, uint* pcbWritten);
    HRESULT FillAt(ULARGE_INTEGER ulOffset, char* pv, uint cb, uint* pcbWritten);
    HRESULT SetFillSize(ULARGE_INTEGER ulSize);
    HRESULT Terminate(BOOL bCanceled);
}

@GUID("0E6D4D90-6738-11CF-9608-00AA00680DB4")
interface ILayoutStorage : IUnknown
{
    HRESULT LayoutScript(char* pStorageLayout, uint nEntries, uint glfInterleavedFlag);
    HRESULT BeginMonitor();
    HRESULT EndMonitor();
    HRESULT ReLayoutDocfile(ushort* pwcsNewDfName);
    HRESULT ReLayoutDocfileOnILockBytes(ILockBytes pILockBytes);
}

@GUID("0E6D4D92-6738-11CF-9608-00AA00680DB4")
interface IDirectWriterLock : IUnknown
{
    HRESULT WaitForWriteAccess(uint dwTimeout);
    HRESULT ReleaseWriteAccess();
    HRESULT HaveWriteAccess();
}

@GUID("00000138-0000-0000-C000-000000000046")
interface IPropertyStorage : IUnknown
{
    HRESULT ReadMultiple(uint cpspec, char* rgpspec, char* rgpropvar);
    HRESULT WriteMultiple(uint cpspec, char* rgpspec, char* rgpropvar, uint propidNameFirst);
    HRESULT DeleteMultiple(uint cpspec, char* rgpspec);
    HRESULT ReadPropertyNames(uint cpropid, char* rgpropid, char* rglpwstrName);
    HRESULT WritePropertyNames(uint cpropid, char* rgpropid, char* rglpwstrName);
    HRESULT DeletePropertyNames(uint cpropid, char* rgpropid);
    HRESULT Commit(uint grfCommitFlags);
    HRESULT Revert();
    HRESULT Enum(IEnumSTATPROPSTG* ppenum);
    HRESULT SetTimes(const(FILETIME)* pctime, const(FILETIME)* patime, const(FILETIME)* pmtime);
    HRESULT SetClass(const(GUID)* clsid);
    HRESULT Stat(STATPROPSETSTG* pstatpsstg);
}

@GUID("0000013A-0000-0000-C000-000000000046")
interface IPropertySetStorage : IUnknown
{
    HRESULT Create(const(GUID)* rfmtid, const(GUID)* pclsid, uint grfFlags, uint grfMode, 
                   IPropertyStorage* ppprstg);
    HRESULT Open(const(GUID)* rfmtid, uint grfMode, IPropertyStorage* ppprstg);
    HRESULT Delete(const(GUID)* rfmtid);
    HRESULT Enum(IEnumSTATPROPSETSTG* ppenum);
}

@GUID("00000139-0000-0000-C000-000000000046")
interface IEnumSTATPROPSTG : IUnknown
{
    HRESULT Next(uint celt, char* rgelt, uint* pceltFetched);
    HRESULT Skip(uint celt);
    HRESULT Reset();
    HRESULT Clone(IEnumSTATPROPSTG* ppenum);
}

@GUID("0000013B-0000-0000-C000-000000000046")
interface IEnumSTATPROPSETSTG : IUnknown
{
    HRESULT Next(uint celt, char* rgelt, uint* pceltFetched);
    HRESULT Skip(uint celt);
    HRESULT Reset();
    HRESULT Clone(IEnumSTATPROPSETSTG* ppenum);
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
