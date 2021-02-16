module windows.automation;

public import windows.core;
public import windows.com : BYTE_SIZEDARR, FLAGGED_WORD_BLOB, HRESULT, HYPER_SIZEDARR, IEnumUnknown, IUnknown,
                            LONG_SIZEDARR, SHORT_SIZEDARR, STGMEDIUM;
public import windows.systemservices : BOOL, CY, DECIMAL, IServiceProvider;
public import windows.windowsandmessaging : HWND;
public import windows.windowsprogramming : SYSTEMTIME;

extern(Windows):


// Enums


enum : int
{
    SF_ERROR    = 0x0000000a,
    SF_I1       = 0x00000010,
    SF_I2       = 0x00000002,
    SF_I4       = 0x00000003,
    SF_I8       = 0x00000014,
    SF_BSTR     = 0x00000008,
    SF_UNKNOWN  = 0x0000000d,
    SF_DISPATCH = 0x00000009,
    SF_VARIANT  = 0x0000000c,
    SF_RECORD   = 0x00000024,
    SF_HAVEIID  = 0x0000800d,
}
alias SF_TYPE = int;

enum : int
{
    TKIND_ENUM      = 0x00000000,
    TKIND_RECORD    = 0x00000001,
    TKIND_MODULE    = 0x00000002,
    TKIND_INTERFACE = 0x00000003,
    TKIND_DISPATCH  = 0x00000004,
    TKIND_COCLASS   = 0x00000005,
    TKIND_ALIAS     = 0x00000006,
    TKIND_UNION     = 0x00000007,
    TKIND_MAX       = 0x00000008,
}
alias TYPEKIND = int;

enum : int
{
    CC_FASTCALL   = 0x00000000,
    CC_CDECL      = 0x00000001,
    CC_MSCPASCAL  = 0x00000002,
    CC_PASCAL     = 0x00000002,
    CC_MACPASCAL  = 0x00000003,
    CC_STDCALL    = 0x00000004,
    CC_FPFASTCALL = 0x00000005,
    CC_SYSCALL    = 0x00000006,
    CC_MPWCDECL   = 0x00000007,
    CC_MPWPASCAL  = 0x00000008,
    CC_MAX        = 0x00000009,
}
alias CALLCONV = int;

enum : int
{
    FUNC_VIRTUAL     = 0x00000000,
    FUNC_PUREVIRTUAL = 0x00000001,
    FUNC_NONVIRTUAL  = 0x00000002,
    FUNC_STATIC      = 0x00000003,
    FUNC_DISPATCH    = 0x00000004,
}
alias FUNCKIND = int;

enum : int
{
    INVOKE_FUNC           = 0x00000001,
    INVOKE_PROPERTYGET    = 0x00000002,
    INVOKE_PROPERTYPUT    = 0x00000004,
    INVOKE_PROPERTYPUTREF = 0x00000008,
}
alias INVOKEKIND = int;

enum : int
{
    VAR_PERINSTANCE = 0x00000000,
    VAR_STATIC      = 0x00000001,
    VAR_CONST       = 0x00000002,
    VAR_DISPATCH    = 0x00000003,
}
alias VARKIND = int;

enum : int
{
    TYPEFLAG_FAPPOBJECT     = 0x00000001,
    TYPEFLAG_FCANCREATE     = 0x00000002,
    TYPEFLAG_FLICENSED      = 0x00000004,
    TYPEFLAG_FPREDECLID     = 0x00000008,
    TYPEFLAG_FHIDDEN        = 0x00000010,
    TYPEFLAG_FCONTROL       = 0x00000020,
    TYPEFLAG_FDUAL          = 0x00000040,
    TYPEFLAG_FNONEXTENSIBLE = 0x00000080,
    TYPEFLAG_FOLEAUTOMATION = 0x00000100,
    TYPEFLAG_FRESTRICTED    = 0x00000200,
    TYPEFLAG_FAGGREGATABLE  = 0x00000400,
    TYPEFLAG_FREPLACEABLE   = 0x00000800,
    TYPEFLAG_FDISPATCHABLE  = 0x00001000,
    TYPEFLAG_FREVERSEBIND   = 0x00002000,
    TYPEFLAG_FPROXY         = 0x00004000,
}
alias TYPEFLAGS = int;

enum : int
{
    FUNCFLAG_FRESTRICTED       = 0x00000001,
    FUNCFLAG_FSOURCE           = 0x00000002,
    FUNCFLAG_FBINDABLE         = 0x00000004,
    FUNCFLAG_FREQUESTEDIT      = 0x00000008,
    FUNCFLAG_FDISPLAYBIND      = 0x00000010,
    FUNCFLAG_FDEFAULTBIND      = 0x00000020,
    FUNCFLAG_FHIDDEN           = 0x00000040,
    FUNCFLAG_FUSESGETLASTERROR = 0x00000080,
    FUNCFLAG_FDEFAULTCOLLELEM  = 0x00000100,
    FUNCFLAG_FUIDEFAULT        = 0x00000200,
    FUNCFLAG_FNONBROWSABLE     = 0x00000400,
    FUNCFLAG_FREPLACEABLE      = 0x00000800,
    FUNCFLAG_FIMMEDIATEBIND    = 0x00001000,
}
alias FUNCFLAGS = int;

enum : int
{
    VARFLAG_FREADONLY        = 0x00000001,
    VARFLAG_FSOURCE          = 0x00000002,
    VARFLAG_FBINDABLE        = 0x00000004,
    VARFLAG_FREQUESTEDIT     = 0x00000008,
    VARFLAG_FDISPLAYBIND     = 0x00000010,
    VARFLAG_FDEFAULTBIND     = 0x00000020,
    VARFLAG_FHIDDEN          = 0x00000040,
    VARFLAG_FRESTRICTED      = 0x00000080,
    VARFLAG_FDEFAULTCOLLELEM = 0x00000100,
    VARFLAG_FUIDEFAULT       = 0x00000200,
    VARFLAG_FNONBROWSABLE    = 0x00000400,
    VARFLAG_FREPLACEABLE     = 0x00000800,
    VARFLAG_FIMMEDIATEBIND   = 0x00001000,
}
alias VARFLAGS = int;

enum : int
{
    DESCKIND_NONE           = 0x00000000,
    DESCKIND_FUNCDESC       = 0x00000001,
    DESCKIND_VARDESC        = 0x00000002,
    DESCKIND_TYPECOMP       = 0x00000003,
    DESCKIND_IMPLICITAPPOBJ = 0x00000004,
    DESCKIND_MAX            = 0x00000005,
}
alias DESCKIND = int;

enum : int
{
    SYS_WIN16 = 0x00000000,
    SYS_WIN32 = 0x00000001,
    SYS_MAC   = 0x00000002,
    SYS_WIN64 = 0x00000003,
}
alias SYSKIND = int;

enum : int
{
    LIBFLAG_FRESTRICTED   = 0x00000001,
    LIBFLAG_FCONTROL      = 0x00000002,
    LIBFLAG_FHIDDEN       = 0x00000004,
    LIBFLAG_FHASDISKIMAGE = 0x00000008,
}
alias LIBFLAGS = int;

enum : int
{
    CHANGEKIND_ADDMEMBER        = 0x00000000,
    CHANGEKIND_DELETEMEMBER     = 0x00000001,
    CHANGEKIND_SETNAMES         = 0x00000002,
    CHANGEKIND_SETDOCUMENTATION = 0x00000003,
    CHANGEKIND_GENERAL          = 0x00000004,
    CHANGEKIND_INVALIDATE       = 0x00000005,
    CHANGEKIND_CHANGEFAILED     = 0x00000006,
    CHANGEKIND_MAX              = 0x00000007,
}
alias CHANGEKIND = int;

enum : int
{
    REGKIND_DEFAULT  = 0x00000000,
    REGKIND_REGISTER = 0x00000001,
    REGKIND_NONE     = 0x00000002,
}
alias REGKIND = int;

enum : int
{
    VT_EMPTY            = 0x00000000,
    VT_NULL             = 0x00000001,
    VT_I2               = 0x00000002,
    VT_I4               = 0x00000003,
    VT_R4               = 0x00000004,
    VT_R8               = 0x00000005,
    VT_CY               = 0x00000006,
    VT_DATE             = 0x00000007,
    VT_BSTR             = 0x00000008,
    VT_DISPATCH         = 0x00000009,
    VT_ERROR            = 0x0000000a,
    VT_BOOL             = 0x0000000b,
    VT_VARIANT          = 0x0000000c,
    VT_UNKNOWN          = 0x0000000d,
    VT_DECIMAL          = 0x0000000e,
    VT_I1               = 0x00000010,
    VT_UI1              = 0x00000011,
    VT_UI2              = 0x00000012,
    VT_UI4              = 0x00000013,
    VT_I8               = 0x00000014,
    VT_UI8              = 0x00000015,
    VT_INT              = 0x00000016,
    VT_UINT             = 0x00000017,
    VT_VOID             = 0x00000018,
    VT_HRESULT          = 0x00000019,
    VT_PTR              = 0x0000001a,
    VT_SAFEARRAY        = 0x0000001b,
    VT_CARRAY           = 0x0000001c,
    VT_USERDEFINED      = 0x0000001d,
    VT_LPSTR            = 0x0000001e,
    VT_LPWSTR           = 0x0000001f,
    VT_RECORD           = 0x00000024,
    VT_INT_PTR          = 0x00000025,
    VT_UINT_PTR         = 0x00000026,
    VT_FILETIME         = 0x00000040,
    VT_BLOB             = 0x00000041,
    VT_STREAM           = 0x00000042,
    VT_STORAGE          = 0x00000043,
    VT_STREAMED_OBJECT  = 0x00000044,
    VT_STORED_OBJECT    = 0x00000045,
    VT_BLOB_OBJECT      = 0x00000046,
    VT_CF               = 0x00000047,
    VT_CLSID            = 0x00000048,
    VT_VERSIONED_STREAM = 0x00000049,
    VT_BSTR_BLOB        = 0x00000fff,
    VT_VECTOR           = 0x00001000,
    VT_ARRAY            = 0x00002000,
    VT_BYREF            = 0x00004000,
    VT_RESERVED         = 0x00008000,
    VT_ILLEGAL          = 0x0000ffff,
    VT_ILLEGALMASKED    = 0x00000fff,
    VT_TYPEMASK         = 0x00000fff,
}
alias VARENUM = int;

// Structs


struct SAFEARRAYBOUND
{
    uint cElements;
    int  lLbound;
}

struct _wireSAFEARR_BSTR
{
    uint                Size;
    FLAGGED_WORD_BLOB** aBstr;
}

struct _wireSAFEARR_UNKNOWN
{
    uint      Size;
    IUnknown* apUnknown;
}

struct _wireSAFEARR_DISPATCH
{
    uint       Size;
    IDispatch* apDispatch;
}

struct _wireSAFEARR_VARIANT
{
    uint           Size;
    _wireVARIANT** aVariant;
}

struct _wireSAFEARR_BRECORD
{
    uint           Size;
    _wireBRECORD** aRecord;
}

struct _wireSAFEARR_HAVEIID
{
    uint      Size;
    IUnknown* apUnknown;
    GUID      iid;
}

struct _wireSAFEARRAY_UNION
{
    uint sfType;
    union u
    {
        _wireSAFEARR_BSTR    BstrStr;
        _wireSAFEARR_UNKNOWN UnknownStr;
        _wireSAFEARR_DISPATCH DispatchStr;
        _wireSAFEARR_VARIANT VariantStr;
        _wireSAFEARR_BRECORD RecordStr;
        _wireSAFEARR_HAVEIID HaveIidStr;
        BYTE_SIZEDARR        ByteStr;
        SHORT_SIZEDARR       WordStr;
        LONG_SIZEDARR        LongStr;
        HYPER_SIZEDARR       HyperStr;
    }
}

struct _wireSAFEARRAY
{
    ushort               cDims;
    ushort               fFeatures;
    uint                 cbElements;
    uint                 cLocks;
    _wireSAFEARRAY_UNION uArrayStructs;
    SAFEARRAYBOUND[1]    rgsabound;
}

struct SAFEARRAY
{
    ushort            cDims;
    ushort            fFeatures;
    uint              cbElements;
    uint              cLocks;
    void*             pvData;
    SAFEARRAYBOUND[1] rgsabound;
}

struct VARIANT
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
                long        llVal;
                int         lVal;
                ubyte       bVal;
                short       iVal;
                float       fltVal;
                double      dblVal;
                short       boolVal;
                short       __OBSOLETE__VARIANT_BOOL;
                int         scode;
                CY          cyVal;
                double      date;
                BSTR        bstrVal;
                IUnknown    punkVal;
                IDispatch   pdispVal;
                SAFEARRAY*  parray;
                ubyte*      pbVal;
                short*      piVal;
                int*        plVal;
                long*       pllVal;
                float*      pfltVal;
                double*     pdblVal;
                short*      pboolVal;
                short*      __OBSOLETE__VARIANT_PBOOL;
                int*        pscode;
                CY*         pcyVal;
                double*     pdate;
                BSTR*       pbstrVal;
                IUnknown*   ppunkVal;
                IDispatch*  ppdispVal;
                SAFEARRAY** pparray;
                VARIANT*    pvarVal;
                void*       byref;
                byte        cVal;
                ushort      uiVal;
                uint        ulVal;
                ulong       ullVal;
                int         intVal;
                uint        uintVal;
                DECIMAL*    pdecVal;
                byte*       pcVal;
                ushort*     puiVal;
                uint*       pulVal;
                ulong*      pullVal;
                int*        pintVal;
                uint*       puintVal;
                struct
                {
                    void*       pvRecord;
                    IRecordInfo pRecInfo;
                }
            }
        }
        DECIMAL decVal;
    }
}

struct _wireBRECORD
{
    uint        fFlags;
    uint        clSize;
    IRecordInfo pRecInfo;
    ubyte*      pRecord;
}

struct _wireVARIANT
{
    uint   clSize;
    uint   rpcReserved;
    ushort vt;
    ushort wReserved1;
    ushort wReserved2;
    ushort wReserved3;
    union
    {
        long                llVal;
        int                 lVal;
        ubyte               bVal;
        short               iVal;
        float               fltVal;
        double              dblVal;
        short               boolVal;
        int                 scode;
        CY                  cyVal;
        double              date;
        FLAGGED_WORD_BLOB*  bstrVal;
        IUnknown            punkVal;
        IDispatch           pdispVal;
        _wireSAFEARRAY**    parray;
        _wireBRECORD*       brecVal;
        ubyte*              pbVal;
        short*              piVal;
        int*                plVal;
        long*               pllVal;
        float*              pfltVal;
        double*             pdblVal;
        short*              pboolVal;
        int*                pscode;
        CY*                 pcyVal;
        double*             pdate;
        FLAGGED_WORD_BLOB** pbstrVal;
        IUnknown*           ppunkVal;
        IDispatch*          ppdispVal;
        _wireSAFEARRAY***   pparray;
        _wireVARIANT**      pvarVal;
        byte                cVal;
        ushort              uiVal;
        uint                ulVal;
        ulong               ullVal;
        int                 intVal;
        uint                uintVal;
        DECIMAL             decVal;
        DECIMAL*            pdecVal;
        byte*               pcVal;
        ushort*             puiVal;
        uint*               pulVal;
        ulong*              pullVal;
        int*                pintVal;
        uint*               puintVal;
    }
}

struct TYPEDESC
{
    union
    {
        TYPEDESC*  lptdesc;
        ARRAYDESC* lpadesc;
        uint       hreftype;
    }
    ushort vt;
}

struct ARRAYDESC
{
    TYPEDESC          tdescElem;
    ushort            cDims;
    SAFEARRAYBOUND[1] rgbounds;
}

struct PARAMDESCEX
{
    uint    cBytes;
    VARIANT varDefaultValue;
}

struct PARAMDESC
{
    PARAMDESCEX* pparamdescex;
    ushort       wParamFlags;
}

struct IDLDESC
{
    size_t dwReserved;
    ushort wIDLFlags;
}

struct ELEMDESC
{
    TYPEDESC tdesc;
    union
    {
        IDLDESC   idldesc;
        PARAMDESC paramdesc;
    }
}

struct TYPEATTR
{
    GUID     guid;
    uint     lcid;
    uint     dwReserved;
    int      memidConstructor;
    int      memidDestructor;
    ushort*  lpstrSchema;
    uint     cbSizeInstance;
    TYPEKIND typekind;
    ushort   cFuncs;
    ushort   cVars;
    ushort   cImplTypes;
    ushort   cbSizeVft;
    ushort   cbAlignment;
    ushort   wTypeFlags;
    ushort   wMajorVerNum;
    ushort   wMinorVerNum;
    TYPEDESC tdescAlias;
    IDLDESC  idldescType;
}

struct DISPPARAMS
{
    VARIANT* rgvarg;
    int*     rgdispidNamedArgs;
    uint     cArgs;
    uint     cNamedArgs;
}

struct EXCEPINFO
{
    ushort            wCode;
    ushort            wReserved;
    BSTR              bstrSource;
    BSTR              bstrDescription;
    BSTR              bstrHelpFile;
    uint              dwHelpContext;
    void*             pvReserved;
    HRESULT********** pfnDeferredFillIn;
    int               scode;
}

struct FUNCDESC
{
    int        memid;
    int*       lprgscode;
    ELEMDESC*  lprgelemdescParam;
    FUNCKIND   funckind;
    INVOKEKIND invkind;
    CALLCONV   callconv;
    short      cParams;
    short      cParamsOpt;
    short      oVft;
    short      cScodes;
    ELEMDESC   elemdescFunc;
    ushort     wFuncFlags;
}

struct VARDESC
{
    int      memid;
    ushort*  lpstrSchema;
    union
    {
        uint     oInst;
        VARIANT* lpvarValue;
    }
    ELEMDESC elemdescVar;
    ushort   wVarFlags;
    VARKIND  varkind;
}

struct CLEANLOCALSTORAGE
{
    IUnknown pInterface;
    void*    pStorage;
    uint     flags;
}

struct CUSTDATAITEM
{
    GUID    guid;
    VARIANT varValue;
}

struct CUSTDATA
{
    uint          cCustData;
    CUSTDATAITEM* prgCustData;
}

union BINDPTR
{
    FUNCDESC* lpfuncdesc;
    VARDESC*  lpvardesc;
    ITypeComp lptcomp;
}

struct TLIBATTR
{
    GUID    guid;
    uint    lcid;
    SYSKIND syskind;
    ushort  wMajorVerNum;
    ushort  wMinorVerNum;
    ushort  wLibFlags;
}

struct NUMPARSE
{
    int  cDig;
    uint dwInFlags;
    uint dwOutFlags;
    int  cchUsed;
    int  nBaseShift;
    int  nPwr10;
}

struct UDATE
{
    SYSTEMTIME st;
    ushort     wDayOfYear;
}

struct PARAMDATA
{
    ushort* szName;
    ushort  vt;
}

struct METHODDATA
{
    ushort*    szName;
    PARAMDATA* ppdata;
    int        dispid;
    uint       iMeth;
    CALLCONV   cc;
    uint       cArgs;
    ushort     wFlags;
    ushort     vtReturn;
}

struct INTERFACEDATA
{
    METHODDATA* pmethdata;
    uint        cMembers;
}

struct WIA_RAW_HEADER
{
    uint     Tag;
    uint     Version;
    uint     HeaderSize;
    uint     XRes;
    uint     YRes;
    uint     XExtent;
    uint     YExtent;
    uint     BytesPerLine;
    uint     BitsPerPixel;
    uint     ChannelsPerPixel;
    uint     DataType;
    ubyte[8] BitsPerChannel;
    uint     Compression;
    uint     PhotometricInterp;
    uint     LineOrder;
    uint     RawDataOffset;
    uint     RawDataSize;
    uint     PaletteOffset;
    uint     PaletteSize;
}

struct WIA_BARCODE_INFO
{
    uint      Size;
    uint      Type;
    uint      Page;
    uint      Confidence;
    uint      XOffset;
    uint      YOffset;
    uint      Rotation;
    uint      Length;
    ushort[1] Text;
}

struct WIA_BARCODES
{
    uint                Tag;
    uint                Version;
    uint                Size;
    uint                Count;
    WIA_BARCODE_INFO[1] Barcodes;
}

struct WIA_PATCH_CODE_INFO
{
    uint Type;
}

struct WIA_PATCH_CODES
{
    uint Tag;
    uint Version;
    uint Size;
    uint Count;
    WIA_PATCH_CODE_INFO[1] PatchCodes;
}

struct WIA_MICR_INFO
{
    uint      Size;
    uint      Page;
    uint      Length;
    ushort[1] Text;
}

struct WIA_MICR
{
    uint             Tag;
    uint             Version;
    uint             Size;
    ushort           Placeholder;
    ushort           Reserved;
    uint             Count;
    WIA_MICR_INFO[1] Micr;
}

alias BSTR = ptrdiff_t;

// Functions

@DllImport("OLEAUT32")
uint BSTR_UserSize(uint* param0, uint param1, BSTR* param2);

@DllImport("OLEAUT32")
ubyte* BSTR_UserMarshal(uint* param0, ubyte* param1, BSTR* param2);

@DllImport("OLEAUT32")
ubyte* BSTR_UserUnmarshal(uint* param0, char* param1, BSTR* param2);

@DllImport("OLEAUT32")
void BSTR_UserFree(uint* param0, BSTR* param1);

@DllImport("OLEAUT32")
uint LPSAFEARRAY_UserSize(uint* param0, uint param1, SAFEARRAY** param2);

@DllImport("OLEAUT32")
ubyte* LPSAFEARRAY_UserMarshal(uint* param0, ubyte* param1, SAFEARRAY** param2);

@DllImport("OLEAUT32")
ubyte* LPSAFEARRAY_UserUnmarshal(uint* param0, char* param1, SAFEARRAY** param2);

@DllImport("OLEAUT32")
void LPSAFEARRAY_UserFree(uint* param0, SAFEARRAY** param1);

@DllImport("OLEAUT32")
uint BSTR_UserSize64(uint* param0, uint param1, BSTR* param2);

@DllImport("OLEAUT32")
ubyte* BSTR_UserMarshal64(uint* param0, ubyte* param1, BSTR* param2);

@DllImport("OLEAUT32")
ubyte* BSTR_UserUnmarshal64(uint* param0, char* param1, BSTR* param2);

@DllImport("OLEAUT32")
void BSTR_UserFree64(uint* param0, BSTR* param1);

@DllImport("OLEAUT32")
uint LPSAFEARRAY_UserSize64(uint* param0, uint param1, SAFEARRAY** param2);

@DllImport("OLEAUT32")
ubyte* LPSAFEARRAY_UserMarshal64(uint* param0, ubyte* param1, SAFEARRAY** param2);

@DllImport("OLEAUT32")
ubyte* LPSAFEARRAY_UserUnmarshal64(uint* param0, char* param1, SAFEARRAY** param2);

@DllImport("OLEAUT32")
void LPSAFEARRAY_UserFree64(uint* param0, SAFEARRAY** param1);

@DllImport("OLEAUT32")
uint VARIANT_UserSize(uint* param0, uint param1, VARIANT* param2);

@DllImport("OLEAUT32")
ubyte* VARIANT_UserMarshal(uint* param0, ubyte* param1, VARIANT* param2);

@DllImport("OLEAUT32")
ubyte* VARIANT_UserUnmarshal(uint* param0, char* param1, VARIANT* param2);

@DllImport("OLEAUT32")
void VARIANT_UserFree(uint* param0, VARIANT* param1);

@DllImport("OLEAUT32")
uint VARIANT_UserSize64(uint* param0, uint param1, VARIANT* param2);

@DllImport("OLEAUT32")
ubyte* VARIANT_UserMarshal64(uint* param0, ubyte* param1, VARIANT* param2);

@DllImport("OLEAUT32")
ubyte* VARIANT_UserUnmarshal64(uint* param0, char* param1, VARIANT* param2);

@DllImport("OLEAUT32")
void VARIANT_UserFree64(uint* param0, VARIANT* param1);

@DllImport("OLE32")
uint HWND_UserSize(uint* param0, uint param1, HWND* param2);

@DllImport("OLE32")
ubyte* HWND_UserMarshal(uint* param0, ubyte* param1, HWND* param2);

@DllImport("OLE32")
ubyte* HWND_UserUnmarshal(uint* param0, char* param1, HWND* param2);

@DllImport("OLE32")
void HWND_UserFree(uint* param0, HWND* param1);

@DllImport("OLE32")
uint HWND_UserSize64(uint* param0, uint param1, HWND* param2);

@DllImport("OLE32")
ubyte* HWND_UserMarshal64(uint* param0, ubyte* param1, HWND* param2);

@DllImport("OLE32")
ubyte* HWND_UserUnmarshal64(uint* param0, char* param1, HWND* param2);

@DllImport("OLE32")
void HWND_UserFree64(uint* param0, HWND* param1);

@DllImport("OLE32")
uint STGMEDIUM_UserSize(uint* param0, uint param1, STGMEDIUM* param2);

@DllImport("OLE32")
ubyte* STGMEDIUM_UserMarshal(uint* param0, ubyte* param1, STGMEDIUM* param2);

@DllImport("OLE32")
ubyte* STGMEDIUM_UserUnmarshal(uint* param0, char* param1, STGMEDIUM* param2);

@DllImport("OLE32")
void STGMEDIUM_UserFree(uint* param0, STGMEDIUM* param1);

@DllImport("OLE32")
uint STGMEDIUM_UserSize64(uint* param0, uint param1, STGMEDIUM* param2);

@DllImport("OLE32")
ubyte* STGMEDIUM_UserMarshal64(uint* param0, ubyte* param1, STGMEDIUM* param2);

@DllImport("OLE32")
ubyte* STGMEDIUM_UserUnmarshal64(uint* param0, char* param1, STGMEDIUM* param2);

@DllImport("OLE32")
void STGMEDIUM_UserFree64(uint* param0, STGMEDIUM* param1);

@DllImport("OLEAUT32")
HRESULT OleLoadPictureFile(VARIANT varFileName, IDispatch* lplpdispPicture);

@DllImport("OLEAUT32")
HRESULT OleLoadPictureFileEx(VARIANT varFileName, uint xSizeDesired, uint ySizeDesired, uint dwFlags, 
                             IDispatch* lplpdispPicture);

@DllImport("OLEAUT32")
HRESULT OleSavePictureFile(IDispatch lpdispPicture, BSTR bstrFileName);

@DllImport("OLEAUT32")
BSTR SysAllocString(const(ushort)* psz);

@DllImport("OLEAUT32")
int SysReAllocString(char* pbstr, const(ushort)* psz);

@DllImport("OLEAUT32")
BSTR SysAllocStringLen(char* strIn, uint ui);

@DllImport("OLEAUT32")
int SysReAllocStringLen(char* pbstr, const(ushort)* psz, uint len);

@DllImport("OLEAUT32")
HRESULT SysAddRefString(BSTR bstrString);

@DllImport("OLEAUT32")
void SysReleaseString(BSTR bstrString);

@DllImport("OLEAUT32")
void SysFreeString(BSTR bstrString);

@DllImport("OLEAUT32")
uint SysStringLen(BSTR pbstr);

@DllImport("OLEAUT32")
uint SysStringByteLen(BSTR bstr);

@DllImport("OLEAUT32")
BSTR SysAllocStringByteLen(const(char)* psz, uint len);

@DllImport("OLEAUT32")
int DosDateTimeToVariantTime(ushort wDosDate, ushort wDosTime, double* pvtime);

@DllImport("OLEAUT32")
int VariantTimeToDosDateTime(double vtime, ushort* pwDosDate, ushort* pwDosTime);

@DllImport("OLEAUT32")
int SystemTimeToVariantTime(SYSTEMTIME* lpSystemTime, double* pvtime);

@DllImport("OLEAUT32")
int VariantTimeToSystemTime(double vtime, SYSTEMTIME* lpSystemTime);

@DllImport("OLEAUT32")
HRESULT SafeArrayAllocDescriptor(uint cDims, SAFEARRAY** ppsaOut);

@DllImport("OLEAUT32")
HRESULT SafeArrayAllocDescriptorEx(ushort vt, uint cDims, SAFEARRAY** ppsaOut);

@DllImport("OLEAUT32")
HRESULT SafeArrayAllocData(SAFEARRAY* psa);

@DllImport("OLEAUT32")
SAFEARRAY* SafeArrayCreate(ushort vt, uint cDims, SAFEARRAYBOUND* rgsabound);

@DllImport("OLEAUT32")
SAFEARRAY* SafeArrayCreateEx(ushort vt, uint cDims, SAFEARRAYBOUND* rgsabound, void* pvExtra);

@DllImport("OLEAUT32")
HRESULT SafeArrayCopyData(SAFEARRAY* psaSource, SAFEARRAY* psaTarget);

@DllImport("OLEAUT32")
void SafeArrayReleaseDescriptor(SAFEARRAY* psa);

@DllImport("OLEAUT32")
HRESULT SafeArrayDestroyDescriptor(SAFEARRAY* psa);

@DllImport("OLEAUT32")
void SafeArrayReleaseData(void* pData);

@DllImport("OLEAUT32")
HRESULT SafeArrayDestroyData(SAFEARRAY* psa);

@DllImport("OLEAUT32")
HRESULT SafeArrayAddRef(SAFEARRAY* psa, void** ppDataToRelease);

@DllImport("OLEAUT32")
HRESULT SafeArrayDestroy(SAFEARRAY* psa);

@DllImport("OLEAUT32")
HRESULT SafeArrayRedim(SAFEARRAY* psa, SAFEARRAYBOUND* psaboundNew);

@DllImport("OLEAUT32")
uint SafeArrayGetDim(SAFEARRAY* psa);

@DllImport("OLEAUT32")
uint SafeArrayGetElemsize(SAFEARRAY* psa);

@DllImport("OLEAUT32")
HRESULT SafeArrayGetUBound(SAFEARRAY* psa, uint nDim, int* plUbound);

@DllImport("OLEAUT32")
HRESULT SafeArrayGetLBound(SAFEARRAY* psa, uint nDim, int* plLbound);

@DllImport("OLEAUT32")
HRESULT SafeArrayLock(SAFEARRAY* psa);

@DllImport("OLEAUT32")
HRESULT SafeArrayUnlock(SAFEARRAY* psa);

@DllImport("OLEAUT32")
HRESULT SafeArrayAccessData(SAFEARRAY* psa, void** ppvData);

@DllImport("OLEAUT32")
HRESULT SafeArrayUnaccessData(SAFEARRAY* psa);

@DllImport("OLEAUT32")
HRESULT SafeArrayGetElement(SAFEARRAY* psa, char* rgIndices, void* pv);

@DllImport("OLEAUT32")
HRESULT SafeArrayPutElement(SAFEARRAY* psa, char* rgIndices, void* pv);

@DllImport("OLEAUT32")
HRESULT SafeArrayCopy(SAFEARRAY* psa, SAFEARRAY** ppsaOut);

@DllImport("OLEAUT32")
HRESULT SafeArrayPtrOfIndex(SAFEARRAY* psa, char* rgIndices, void** ppvData);

@DllImport("OLEAUT32")
HRESULT SafeArraySetRecordInfo(SAFEARRAY* psa, IRecordInfo prinfo);

@DllImport("OLEAUT32")
HRESULT SafeArrayGetRecordInfo(SAFEARRAY* psa, IRecordInfo* prinfo);

@DllImport("OLEAUT32")
HRESULT SafeArraySetIID(SAFEARRAY* psa, const(GUID)* guid);

@DllImport("OLEAUT32")
HRESULT SafeArrayGetIID(SAFEARRAY* psa, GUID* pguid);

@DllImport("OLEAUT32")
HRESULT SafeArrayGetVartype(SAFEARRAY* psa, ushort* pvt);

@DllImport("OLEAUT32")
SAFEARRAY* SafeArrayCreateVector(ushort vt, int lLbound, uint cElements);

@DllImport("OLEAUT32")
SAFEARRAY* SafeArrayCreateVectorEx(ushort vt, int lLbound, uint cElements, void* pvExtra);

@DllImport("OLEAUT32")
void VariantInit(VARIANT* pvarg);

@DllImport("OLEAUT32")
HRESULT VariantClear(VARIANT* pvarg);

@DllImport("OLEAUT32")
HRESULT VariantCopy(VARIANT* pvargDest, const(VARIANT)* pvargSrc);

@DllImport("OLEAUT32")
HRESULT VariantCopyInd(VARIANT* pvarDest, const(VARIANT)* pvargSrc);

@DllImport("OLEAUT32")
HRESULT VariantChangeType(VARIANT* pvargDest, const(VARIANT)* pvarSrc, ushort wFlags, ushort vt);

@DllImport("OLEAUT32")
HRESULT VariantChangeTypeEx(VARIANT* pvargDest, const(VARIANT)* pvarSrc, uint lcid, ushort wFlags, ushort vt);

@DllImport("OLEAUT32")
HRESULT VectorFromBstr(BSTR bstr, SAFEARRAY** ppsa);

@DllImport("OLEAUT32")
HRESULT BstrFromVector(SAFEARRAY* psa, BSTR* pbstr);

@DllImport("OLEAUT32")
HRESULT VarUI1FromI2(short sIn, ubyte* pbOut);

@DllImport("OLEAUT32")
HRESULT VarUI1FromI4(int lIn, ubyte* pbOut);

@DllImport("OLEAUT32")
HRESULT VarUI1FromI8(long i64In, ubyte* pbOut);

@DllImport("OLEAUT32")
HRESULT VarUI1FromR4(float fltIn, ubyte* pbOut);

@DllImport("OLEAUT32")
HRESULT VarUI1FromR8(double dblIn, ubyte* pbOut);

@DllImport("OLEAUT32")
HRESULT VarUI1FromCy(CY cyIn, ubyte* pbOut);

@DllImport("OLEAUT32")
HRESULT VarUI1FromDate(double dateIn, ubyte* pbOut);

@DllImport("OLEAUT32")
HRESULT VarUI1FromStr(ushort* strIn, uint lcid, uint dwFlags, ubyte* pbOut);

@DllImport("OLEAUT32")
HRESULT VarUI1FromDisp(IDispatch pdispIn, uint lcid, ubyte* pbOut);

@DllImport("OLEAUT32")
HRESULT VarUI1FromBool(short boolIn, ubyte* pbOut);

@DllImport("OLEAUT32")
HRESULT VarUI1FromI1(byte cIn, ubyte* pbOut);

@DllImport("OLEAUT32")
HRESULT VarUI1FromUI2(ushort uiIn, ubyte* pbOut);

@DllImport("OLEAUT32")
HRESULT VarUI1FromUI4(uint ulIn, ubyte* pbOut);

@DllImport("OLEAUT32")
HRESULT VarUI1FromUI8(ulong ui64In, ubyte* pbOut);

@DllImport("OLEAUT32")
HRESULT VarUI1FromDec(const(DECIMAL)* pdecIn, ubyte* pbOut);

@DllImport("OLEAUT32")
HRESULT VarI2FromUI1(ubyte bIn, short* psOut);

@DllImport("OLEAUT32")
HRESULT VarI2FromI4(int lIn, short* psOut);

@DllImport("OLEAUT32")
HRESULT VarI2FromI8(long i64In, short* psOut);

@DllImport("OLEAUT32")
HRESULT VarI2FromR4(float fltIn, short* psOut);

@DllImport("OLEAUT32")
HRESULT VarI2FromR8(double dblIn, short* psOut);

@DllImport("OLEAUT32")
HRESULT VarI2FromCy(CY cyIn, short* psOut);

@DllImport("OLEAUT32")
HRESULT VarI2FromDate(double dateIn, short* psOut);

@DllImport("OLEAUT32")
HRESULT VarI2FromStr(ushort* strIn, uint lcid, uint dwFlags, short* psOut);

@DllImport("OLEAUT32")
HRESULT VarI2FromDisp(IDispatch pdispIn, uint lcid, short* psOut);

@DllImport("OLEAUT32")
HRESULT VarI2FromBool(short boolIn, short* psOut);

@DllImport("OLEAUT32")
HRESULT VarI2FromI1(byte cIn, short* psOut);

@DllImport("OLEAUT32")
HRESULT VarI2FromUI2(ushort uiIn, short* psOut);

@DllImport("OLEAUT32")
HRESULT VarI2FromUI4(uint ulIn, short* psOut);

@DllImport("OLEAUT32")
HRESULT VarI2FromUI8(ulong ui64In, short* psOut);

@DllImport("OLEAUT32")
HRESULT VarI2FromDec(const(DECIMAL)* pdecIn, short* psOut);

@DllImport("OLEAUT32")
HRESULT VarI4FromUI1(ubyte bIn, int* plOut);

@DllImport("OLEAUT32")
HRESULT VarI4FromI2(short sIn, int* plOut);

@DllImport("OLEAUT32")
HRESULT VarI4FromI8(long i64In, int* plOut);

@DllImport("OLEAUT32")
HRESULT VarI4FromR4(float fltIn, int* plOut);

@DllImport("OLEAUT32")
HRESULT VarI4FromR8(double dblIn, int* plOut);

@DllImport("OLEAUT32")
HRESULT VarI4FromCy(CY cyIn, int* plOut);

@DllImport("OLEAUT32")
HRESULT VarI4FromDate(double dateIn, int* plOut);

@DllImport("OLEAUT32")
HRESULT VarI4FromStr(ushort* strIn, uint lcid, uint dwFlags, int* plOut);

@DllImport("OLEAUT32")
HRESULT VarI4FromDisp(IDispatch pdispIn, uint lcid, int* plOut);

@DllImport("OLEAUT32")
HRESULT VarI4FromBool(short boolIn, int* plOut);

@DllImport("OLEAUT32")
HRESULT VarI4FromI1(byte cIn, int* plOut);

@DllImport("OLEAUT32")
HRESULT VarI4FromUI2(ushort uiIn, int* plOut);

@DllImport("OLEAUT32")
HRESULT VarI4FromUI4(uint ulIn, int* plOut);

@DllImport("OLEAUT32")
HRESULT VarI4FromUI8(ulong ui64In, int* plOut);

@DllImport("OLEAUT32")
HRESULT VarI4FromDec(const(DECIMAL)* pdecIn, int* plOut);

@DllImport("OLEAUT32")
HRESULT VarI8FromUI1(ubyte bIn, long* pi64Out);

@DllImport("OLEAUT32")
HRESULT VarI8FromI2(short sIn, long* pi64Out);

@DllImport("OLEAUT32")
HRESULT VarI8FromR4(float fltIn, long* pi64Out);

@DllImport("OLEAUT32")
HRESULT VarI8FromR8(double dblIn, long* pi64Out);

@DllImport("OLEAUT32")
HRESULT VarI8FromCy(CY cyIn, long* pi64Out);

@DllImport("OLEAUT32")
HRESULT VarI8FromDate(double dateIn, long* pi64Out);

@DllImport("OLEAUT32")
HRESULT VarI8FromStr(ushort* strIn, uint lcid, uint dwFlags, long* pi64Out);

@DllImport("OLEAUT32")
HRESULT VarI8FromDisp(IDispatch pdispIn, uint lcid, long* pi64Out);

@DllImport("OLEAUT32")
HRESULT VarI8FromBool(short boolIn, long* pi64Out);

@DllImport("OLEAUT32")
HRESULT VarI8FromI1(byte cIn, long* pi64Out);

@DllImport("OLEAUT32")
HRESULT VarI8FromUI2(ushort uiIn, long* pi64Out);

@DllImport("OLEAUT32")
HRESULT VarI8FromUI4(uint ulIn, long* pi64Out);

@DllImport("OLEAUT32")
HRESULT VarI8FromUI8(ulong ui64In, long* pi64Out);

@DllImport("OLEAUT32")
HRESULT VarI8FromDec(const(DECIMAL)* pdecIn, long* pi64Out);

@DllImport("OLEAUT32")
HRESULT VarR4FromUI1(ubyte bIn, float* pfltOut);

@DllImport("OLEAUT32")
HRESULT VarR4FromI2(short sIn, float* pfltOut);

@DllImport("OLEAUT32")
HRESULT VarR4FromI4(int lIn, float* pfltOut);

@DllImport("OLEAUT32")
HRESULT VarR4FromI8(long i64In, float* pfltOut);

@DllImport("OLEAUT32")
HRESULT VarR4FromR8(double dblIn, float* pfltOut);

@DllImport("OLEAUT32")
HRESULT VarR4FromCy(CY cyIn, float* pfltOut);

@DllImport("OLEAUT32")
HRESULT VarR4FromDate(double dateIn, float* pfltOut);

@DllImport("OLEAUT32")
HRESULT VarR4FromStr(ushort* strIn, uint lcid, uint dwFlags, float* pfltOut);

@DllImport("OLEAUT32")
HRESULT VarR4FromDisp(IDispatch pdispIn, uint lcid, float* pfltOut);

@DllImport("OLEAUT32")
HRESULT VarR4FromBool(short boolIn, float* pfltOut);

@DllImport("OLEAUT32")
HRESULT VarR4FromI1(byte cIn, float* pfltOut);

@DllImport("OLEAUT32")
HRESULT VarR4FromUI2(ushort uiIn, float* pfltOut);

@DllImport("OLEAUT32")
HRESULT VarR4FromUI4(uint ulIn, float* pfltOut);

@DllImport("OLEAUT32")
HRESULT VarR4FromUI8(ulong ui64In, float* pfltOut);

@DllImport("OLEAUT32")
HRESULT VarR4FromDec(const(DECIMAL)* pdecIn, float* pfltOut);

@DllImport("OLEAUT32")
HRESULT VarR8FromUI1(ubyte bIn, double* pdblOut);

@DllImport("OLEAUT32")
HRESULT VarR8FromI2(short sIn, double* pdblOut);

@DllImport("OLEAUT32")
HRESULT VarR8FromI4(int lIn, double* pdblOut);

@DllImport("OLEAUT32")
HRESULT VarR8FromI8(long i64In, double* pdblOut);

@DllImport("OLEAUT32")
HRESULT VarR8FromR4(float fltIn, double* pdblOut);

@DllImport("OLEAUT32")
HRESULT VarR8FromCy(CY cyIn, double* pdblOut);

@DllImport("OLEAUT32")
HRESULT VarR8FromDate(double dateIn, double* pdblOut);

@DllImport("OLEAUT32")
HRESULT VarR8FromStr(ushort* strIn, uint lcid, uint dwFlags, double* pdblOut);

@DllImport("OLEAUT32")
HRESULT VarR8FromDisp(IDispatch pdispIn, uint lcid, double* pdblOut);

@DllImport("OLEAUT32")
HRESULT VarR8FromBool(short boolIn, double* pdblOut);

@DllImport("OLEAUT32")
HRESULT VarR8FromI1(byte cIn, double* pdblOut);

@DllImport("OLEAUT32")
HRESULT VarR8FromUI2(ushort uiIn, double* pdblOut);

@DllImport("OLEAUT32")
HRESULT VarR8FromUI4(uint ulIn, double* pdblOut);

@DllImport("OLEAUT32")
HRESULT VarR8FromUI8(ulong ui64In, double* pdblOut);

@DllImport("OLEAUT32")
HRESULT VarR8FromDec(const(DECIMAL)* pdecIn, double* pdblOut);

@DllImport("OLEAUT32")
HRESULT VarDateFromUI1(ubyte bIn, double* pdateOut);

@DllImport("OLEAUT32")
HRESULT VarDateFromI2(short sIn, double* pdateOut);

@DllImport("OLEAUT32")
HRESULT VarDateFromI4(int lIn, double* pdateOut);

@DllImport("OLEAUT32")
HRESULT VarDateFromI8(long i64In, double* pdateOut);

@DllImport("OLEAUT32")
HRESULT VarDateFromR4(float fltIn, double* pdateOut);

@DllImport("OLEAUT32")
HRESULT VarDateFromR8(double dblIn, double* pdateOut);

@DllImport("OLEAUT32")
HRESULT VarDateFromCy(CY cyIn, double* pdateOut);

@DllImport("OLEAUT32")
HRESULT VarDateFromStr(ushort* strIn, uint lcid, uint dwFlags, double* pdateOut);

@DllImport("OLEAUT32")
HRESULT VarDateFromDisp(IDispatch pdispIn, uint lcid, double* pdateOut);

@DllImport("OLEAUT32")
HRESULT VarDateFromBool(short boolIn, double* pdateOut);

@DllImport("OLEAUT32")
HRESULT VarDateFromI1(byte cIn, double* pdateOut);

@DllImport("OLEAUT32")
HRESULT VarDateFromUI2(ushort uiIn, double* pdateOut);

@DllImport("OLEAUT32")
HRESULT VarDateFromUI4(uint ulIn, double* pdateOut);

@DllImport("OLEAUT32")
HRESULT VarDateFromUI8(ulong ui64In, double* pdateOut);

@DllImport("OLEAUT32")
HRESULT VarDateFromDec(const(DECIMAL)* pdecIn, double* pdateOut);

@DllImport("OLEAUT32")
HRESULT VarCyFromUI1(ubyte bIn, CY* pcyOut);

@DllImport("OLEAUT32")
HRESULT VarCyFromI2(short sIn, CY* pcyOut);

@DllImport("OLEAUT32")
HRESULT VarCyFromI4(int lIn, CY* pcyOut);

@DllImport("OLEAUT32")
HRESULT VarCyFromI8(long i64In, CY* pcyOut);

@DllImport("OLEAUT32")
HRESULT VarCyFromR4(float fltIn, CY* pcyOut);

@DllImport("OLEAUT32")
HRESULT VarCyFromR8(double dblIn, CY* pcyOut);

@DllImport("OLEAUT32")
HRESULT VarCyFromDate(double dateIn, CY* pcyOut);

@DllImport("OLEAUT32")
HRESULT VarCyFromStr(ushort* strIn, uint lcid, uint dwFlags, CY* pcyOut);

@DllImport("OLEAUT32")
HRESULT VarCyFromDisp(IDispatch pdispIn, uint lcid, CY* pcyOut);

@DllImport("OLEAUT32")
HRESULT VarCyFromBool(short boolIn, CY* pcyOut);

@DllImport("OLEAUT32")
HRESULT VarCyFromI1(byte cIn, CY* pcyOut);

@DllImport("OLEAUT32")
HRESULT VarCyFromUI2(ushort uiIn, CY* pcyOut);

@DllImport("OLEAUT32")
HRESULT VarCyFromUI4(uint ulIn, CY* pcyOut);

@DllImport("OLEAUT32")
HRESULT VarCyFromUI8(ulong ui64In, CY* pcyOut);

@DllImport("OLEAUT32")
HRESULT VarCyFromDec(const(DECIMAL)* pdecIn, CY* pcyOut);

@DllImport("OLEAUT32")
HRESULT VarBstrFromUI1(ubyte bVal, uint lcid, uint dwFlags, BSTR* pbstrOut);

@DllImport("OLEAUT32")
HRESULT VarBstrFromI2(short iVal, uint lcid, uint dwFlags, BSTR* pbstrOut);

@DllImport("OLEAUT32")
HRESULT VarBstrFromI4(int lIn, uint lcid, uint dwFlags, BSTR* pbstrOut);

@DllImport("OLEAUT32")
HRESULT VarBstrFromI8(long i64In, uint lcid, uint dwFlags, BSTR* pbstrOut);

@DllImport("OLEAUT32")
HRESULT VarBstrFromR4(float fltIn, uint lcid, uint dwFlags, BSTR* pbstrOut);

@DllImport("OLEAUT32")
HRESULT VarBstrFromR8(double dblIn, uint lcid, uint dwFlags, BSTR* pbstrOut);

@DllImport("OLEAUT32")
HRESULT VarBstrFromCy(CY cyIn, uint lcid, uint dwFlags, BSTR* pbstrOut);

@DllImport("OLEAUT32")
HRESULT VarBstrFromDate(double dateIn, uint lcid, uint dwFlags, BSTR* pbstrOut);

@DllImport("OLEAUT32")
HRESULT VarBstrFromDisp(IDispatch pdispIn, uint lcid, uint dwFlags, BSTR* pbstrOut);

@DllImport("OLEAUT32")
HRESULT VarBstrFromBool(short boolIn, uint lcid, uint dwFlags, BSTR* pbstrOut);

@DllImport("OLEAUT32")
HRESULT VarBstrFromI1(byte cIn, uint lcid, uint dwFlags, BSTR* pbstrOut);

@DllImport("OLEAUT32")
HRESULT VarBstrFromUI2(ushort uiIn, uint lcid, uint dwFlags, BSTR* pbstrOut);

@DllImport("OLEAUT32")
HRESULT VarBstrFromUI4(uint ulIn, uint lcid, uint dwFlags, BSTR* pbstrOut);

@DllImport("OLEAUT32")
HRESULT VarBstrFromUI8(ulong ui64In, uint lcid, uint dwFlags, BSTR* pbstrOut);

@DllImport("OLEAUT32")
HRESULT VarBstrFromDec(const(DECIMAL)* pdecIn, uint lcid, uint dwFlags, BSTR* pbstrOut);

@DllImport("OLEAUT32")
HRESULT VarBoolFromUI1(ubyte bIn, short* pboolOut);

@DllImport("OLEAUT32")
HRESULT VarBoolFromI2(short sIn, short* pboolOut);

@DllImport("OLEAUT32")
HRESULT VarBoolFromI4(int lIn, short* pboolOut);

@DllImport("OLEAUT32")
HRESULT VarBoolFromI8(long i64In, short* pboolOut);

@DllImport("OLEAUT32")
HRESULT VarBoolFromR4(float fltIn, short* pboolOut);

@DllImport("OLEAUT32")
HRESULT VarBoolFromR8(double dblIn, short* pboolOut);

@DllImport("OLEAUT32")
HRESULT VarBoolFromDate(double dateIn, short* pboolOut);

@DllImport("OLEAUT32")
HRESULT VarBoolFromCy(CY cyIn, short* pboolOut);

@DllImport("OLEAUT32")
HRESULT VarBoolFromStr(ushort* strIn, uint lcid, uint dwFlags, short* pboolOut);

@DllImport("OLEAUT32")
HRESULT VarBoolFromDisp(IDispatch pdispIn, uint lcid, short* pboolOut);

@DllImport("OLEAUT32")
HRESULT VarBoolFromI1(byte cIn, short* pboolOut);

@DllImport("OLEAUT32")
HRESULT VarBoolFromUI2(ushort uiIn, short* pboolOut);

@DllImport("OLEAUT32")
HRESULT VarBoolFromUI4(uint ulIn, short* pboolOut);

@DllImport("OLEAUT32")
HRESULT VarBoolFromUI8(ulong i64In, short* pboolOut);

@DllImport("OLEAUT32")
HRESULT VarBoolFromDec(const(DECIMAL)* pdecIn, short* pboolOut);

@DllImport("OLEAUT32")
HRESULT VarI1FromUI1(ubyte bIn, byte* pcOut);

@DllImport("OLEAUT32")
HRESULT VarI1FromI2(short uiIn, byte* pcOut);

@DllImport("OLEAUT32")
HRESULT VarI1FromI4(int lIn, byte* pcOut);

@DllImport("OLEAUT32")
HRESULT VarI1FromI8(long i64In, byte* pcOut);

@DllImport("OLEAUT32")
HRESULT VarI1FromR4(float fltIn, byte* pcOut);

@DllImport("OLEAUT32")
HRESULT VarI1FromR8(double dblIn, byte* pcOut);

@DllImport("OLEAUT32")
HRESULT VarI1FromDate(double dateIn, byte* pcOut);

@DllImport("OLEAUT32")
HRESULT VarI1FromCy(CY cyIn, byte* pcOut);

@DllImport("OLEAUT32")
HRESULT VarI1FromStr(ushort* strIn, uint lcid, uint dwFlags, byte* pcOut);

@DllImport("OLEAUT32")
HRESULT VarI1FromDisp(IDispatch pdispIn, uint lcid, byte* pcOut);

@DllImport("OLEAUT32")
HRESULT VarI1FromBool(short boolIn, byte* pcOut);

@DllImport("OLEAUT32")
HRESULT VarI1FromUI2(ushort uiIn, byte* pcOut);

@DllImport("OLEAUT32")
HRESULT VarI1FromUI4(uint ulIn, byte* pcOut);

@DllImport("OLEAUT32")
HRESULT VarI1FromUI8(ulong i64In, byte* pcOut);

@DllImport("OLEAUT32")
HRESULT VarI1FromDec(const(DECIMAL)* pdecIn, byte* pcOut);

@DllImport("OLEAUT32")
HRESULT VarUI2FromUI1(ubyte bIn, ushort* puiOut);

@DllImport("OLEAUT32")
HRESULT VarUI2FromI2(short uiIn, ushort* puiOut);

@DllImport("OLEAUT32")
HRESULT VarUI2FromI4(int lIn, ushort* puiOut);

@DllImport("OLEAUT32")
HRESULT VarUI2FromI8(long i64In, ushort* puiOut);

@DllImport("OLEAUT32")
HRESULT VarUI2FromR4(float fltIn, ushort* puiOut);

@DllImport("OLEAUT32")
HRESULT VarUI2FromR8(double dblIn, ushort* puiOut);

@DllImport("OLEAUT32")
HRESULT VarUI2FromDate(double dateIn, ushort* puiOut);

@DllImport("OLEAUT32")
HRESULT VarUI2FromCy(CY cyIn, ushort* puiOut);

@DllImport("OLEAUT32")
HRESULT VarUI2FromStr(ushort* strIn, uint lcid, uint dwFlags, ushort* puiOut);

@DllImport("OLEAUT32")
HRESULT VarUI2FromDisp(IDispatch pdispIn, uint lcid, ushort* puiOut);

@DllImport("OLEAUT32")
HRESULT VarUI2FromBool(short boolIn, ushort* puiOut);

@DllImport("OLEAUT32")
HRESULT VarUI2FromI1(byte cIn, ushort* puiOut);

@DllImport("OLEAUT32")
HRESULT VarUI2FromUI4(uint ulIn, ushort* puiOut);

@DllImport("OLEAUT32")
HRESULT VarUI2FromUI8(ulong i64In, ushort* puiOut);

@DllImport("OLEAUT32")
HRESULT VarUI2FromDec(const(DECIMAL)* pdecIn, ushort* puiOut);

@DllImport("OLEAUT32")
HRESULT VarUI4FromUI1(ubyte bIn, uint* pulOut);

@DllImport("OLEAUT32")
HRESULT VarUI4FromI2(short uiIn, uint* pulOut);

@DllImport("OLEAUT32")
HRESULT VarUI4FromI4(int lIn, uint* pulOut);

@DllImport("OLEAUT32")
HRESULT VarUI4FromI8(long i64In, uint* plOut);

@DllImport("OLEAUT32")
HRESULT VarUI4FromR4(float fltIn, uint* pulOut);

@DllImport("OLEAUT32")
HRESULT VarUI4FromR8(double dblIn, uint* pulOut);

@DllImport("OLEAUT32")
HRESULT VarUI4FromDate(double dateIn, uint* pulOut);

@DllImport("OLEAUT32")
HRESULT VarUI4FromCy(CY cyIn, uint* pulOut);

@DllImport("OLEAUT32")
HRESULT VarUI4FromStr(ushort* strIn, uint lcid, uint dwFlags, uint* pulOut);

@DllImport("OLEAUT32")
HRESULT VarUI4FromDisp(IDispatch pdispIn, uint lcid, uint* pulOut);

@DllImport("OLEAUT32")
HRESULT VarUI4FromBool(short boolIn, uint* pulOut);

@DllImport("OLEAUT32")
HRESULT VarUI4FromI1(byte cIn, uint* pulOut);

@DllImport("OLEAUT32")
HRESULT VarUI4FromUI2(ushort uiIn, uint* pulOut);

@DllImport("OLEAUT32")
HRESULT VarUI4FromUI8(ulong ui64In, uint* plOut);

@DllImport("OLEAUT32")
HRESULT VarUI4FromDec(const(DECIMAL)* pdecIn, uint* pulOut);

@DllImport("OLEAUT32")
HRESULT VarUI8FromUI1(ubyte bIn, ulong* pi64Out);

@DllImport("OLEAUT32")
HRESULT VarUI8FromI2(short sIn, ulong* pi64Out);

@DllImport("OLEAUT32")
HRESULT VarUI8FromI8(long ui64In, ulong* pi64Out);

@DllImport("OLEAUT32")
HRESULT VarUI8FromR4(float fltIn, ulong* pi64Out);

@DllImport("OLEAUT32")
HRESULT VarUI8FromR8(double dblIn, ulong* pi64Out);

@DllImport("OLEAUT32")
HRESULT VarUI8FromCy(CY cyIn, ulong* pi64Out);

@DllImport("OLEAUT32")
HRESULT VarUI8FromDate(double dateIn, ulong* pi64Out);

@DllImport("OLEAUT32")
HRESULT VarUI8FromStr(ushort* strIn, uint lcid, uint dwFlags, ulong* pi64Out);

@DllImport("OLEAUT32")
HRESULT VarUI8FromDisp(IDispatch pdispIn, uint lcid, ulong* pi64Out);

@DllImport("OLEAUT32")
HRESULT VarUI8FromBool(short boolIn, ulong* pi64Out);

@DllImport("OLEAUT32")
HRESULT VarUI8FromI1(byte cIn, ulong* pi64Out);

@DllImport("OLEAUT32")
HRESULT VarUI8FromUI2(ushort uiIn, ulong* pi64Out);

@DllImport("OLEAUT32")
HRESULT VarUI8FromUI4(uint ulIn, ulong* pi64Out);

@DllImport("OLEAUT32")
HRESULT VarUI8FromDec(const(DECIMAL)* pdecIn, ulong* pi64Out);

@DllImport("OLEAUT32")
HRESULT VarDecFromUI1(ubyte bIn, DECIMAL* pdecOut);

@DllImport("OLEAUT32")
HRESULT VarDecFromI2(short uiIn, DECIMAL* pdecOut);

@DllImport("OLEAUT32")
HRESULT VarDecFromI4(int lIn, DECIMAL* pdecOut);

@DllImport("OLEAUT32")
HRESULT VarDecFromI8(long i64In, DECIMAL* pdecOut);

@DllImport("OLEAUT32")
HRESULT VarDecFromR4(float fltIn, DECIMAL* pdecOut);

@DllImport("OLEAUT32")
HRESULT VarDecFromR8(double dblIn, DECIMAL* pdecOut);

@DllImport("OLEAUT32")
HRESULT VarDecFromDate(double dateIn, DECIMAL* pdecOut);

@DllImport("OLEAUT32")
HRESULT VarDecFromCy(CY cyIn, DECIMAL* pdecOut);

@DllImport("OLEAUT32")
HRESULT VarDecFromStr(ushort* strIn, uint lcid, uint dwFlags, DECIMAL* pdecOut);

@DllImport("OLEAUT32")
HRESULT VarDecFromDisp(IDispatch pdispIn, uint lcid, DECIMAL* pdecOut);

@DllImport("OLEAUT32")
HRESULT VarDecFromBool(short boolIn, DECIMAL* pdecOut);

@DllImport("OLEAUT32")
HRESULT VarDecFromI1(byte cIn, DECIMAL* pdecOut);

@DllImport("OLEAUT32")
HRESULT VarDecFromUI2(ushort uiIn, DECIMAL* pdecOut);

@DllImport("OLEAUT32")
HRESULT VarDecFromUI4(uint ulIn, DECIMAL* pdecOut);

@DllImport("OLEAUT32")
HRESULT VarDecFromUI8(ulong ui64In, DECIMAL* pdecOut);

@DllImport("OLEAUT32")
HRESULT VarParseNumFromStr(ushort* strIn, uint lcid, uint dwFlags, NUMPARSE* pnumprs, char* rgbDig);

@DllImport("OLEAUT32")
HRESULT VarNumFromParseNum(NUMPARSE* pnumprs, char* rgbDig, uint dwVtBits, VARIANT* pvar);

@DllImport("OLEAUT32")
HRESULT VarAdd(VARIANT* pvarLeft, VARIANT* pvarRight, VARIANT* pvarResult);

@DllImport("OLEAUT32")
HRESULT VarAnd(VARIANT* pvarLeft, VARIANT* pvarRight, VARIANT* pvarResult);

@DllImport("OLEAUT32")
HRESULT VarCat(VARIANT* pvarLeft, VARIANT* pvarRight, VARIANT* pvarResult);

@DllImport("OLEAUT32")
HRESULT VarDiv(VARIANT* pvarLeft, VARIANT* pvarRight, VARIANT* pvarResult);

@DllImport("OLEAUT32")
HRESULT VarEqv(VARIANT* pvarLeft, VARIANT* pvarRight, VARIANT* pvarResult);

@DllImport("OLEAUT32")
HRESULT VarIdiv(VARIANT* pvarLeft, VARIANT* pvarRight, VARIANT* pvarResult);

@DllImport("OLEAUT32")
HRESULT VarImp(VARIANT* pvarLeft, VARIANT* pvarRight, VARIANT* pvarResult);

@DllImport("OLEAUT32")
HRESULT VarMod(VARIANT* pvarLeft, VARIANT* pvarRight, VARIANT* pvarResult);

@DllImport("OLEAUT32")
HRESULT VarMul(VARIANT* pvarLeft, VARIANT* pvarRight, VARIANT* pvarResult);

@DllImport("OLEAUT32")
HRESULT VarOr(VARIANT* pvarLeft, VARIANT* pvarRight, VARIANT* pvarResult);

@DllImport("OLEAUT32")
HRESULT VarPow(VARIANT* pvarLeft, VARIANT* pvarRight, VARIANT* pvarResult);

@DllImport("OLEAUT32")
HRESULT VarSub(VARIANT* pvarLeft, VARIANT* pvarRight, VARIANT* pvarResult);

@DllImport("OLEAUT32")
HRESULT VarXor(VARIANT* pvarLeft, VARIANT* pvarRight, VARIANT* pvarResult);

@DllImport("OLEAUT32")
HRESULT VarAbs(VARIANT* pvarIn, VARIANT* pvarResult);

@DllImport("OLEAUT32")
HRESULT VarFix(VARIANT* pvarIn, VARIANT* pvarResult);

@DllImport("OLEAUT32")
HRESULT VarInt(VARIANT* pvarIn, VARIANT* pvarResult);

@DllImport("OLEAUT32")
HRESULT VarNeg(VARIANT* pvarIn, VARIANT* pvarResult);

@DllImport("OLEAUT32")
HRESULT VarNot(VARIANT* pvarIn, VARIANT* pvarResult);

@DllImport("OLEAUT32")
HRESULT VarRound(VARIANT* pvarIn, int cDecimals, VARIANT* pvarResult);

@DllImport("OLEAUT32")
HRESULT VarCmp(VARIANT* pvarLeft, VARIANT* pvarRight, uint lcid, uint dwFlags);

@DllImport("OLEAUT32")
HRESULT VarDecAdd(DECIMAL* pdecLeft, DECIMAL* pdecRight, DECIMAL* pdecResult);

@DllImport("OLEAUT32")
HRESULT VarDecDiv(DECIMAL* pdecLeft, DECIMAL* pdecRight, DECIMAL* pdecResult);

@DllImport("OLEAUT32")
HRESULT VarDecMul(DECIMAL* pdecLeft, DECIMAL* pdecRight, DECIMAL* pdecResult);

@DllImport("OLEAUT32")
HRESULT VarDecSub(DECIMAL* pdecLeft, DECIMAL* pdecRight, DECIMAL* pdecResult);

@DllImport("OLEAUT32")
HRESULT VarDecAbs(DECIMAL* pdecIn, DECIMAL* pdecResult);

@DllImport("OLEAUT32")
HRESULT VarDecFix(DECIMAL* pdecIn, DECIMAL* pdecResult);

@DllImport("OLEAUT32")
HRESULT VarDecInt(DECIMAL* pdecIn, DECIMAL* pdecResult);

@DllImport("OLEAUT32")
HRESULT VarDecNeg(DECIMAL* pdecIn, DECIMAL* pdecResult);

@DllImport("OLEAUT32")
HRESULT VarDecRound(DECIMAL* pdecIn, int cDecimals, DECIMAL* pdecResult);

@DllImport("OLEAUT32")
HRESULT VarDecCmp(DECIMAL* pdecLeft, DECIMAL* pdecRight);

@DllImport("OLEAUT32")
HRESULT VarDecCmpR8(DECIMAL* pdecLeft, double dblRight);

@DllImport("OLEAUT32")
HRESULT VarCyAdd(CY cyLeft, CY cyRight, CY* pcyResult);

@DllImport("OLEAUT32")
HRESULT VarCyMul(CY cyLeft, CY cyRight, CY* pcyResult);

@DllImport("OLEAUT32")
HRESULT VarCyMulI4(CY cyLeft, int lRight, CY* pcyResult);

@DllImport("OLEAUT32")
HRESULT VarCyMulI8(CY cyLeft, long lRight, CY* pcyResult);

@DllImport("OLEAUT32")
HRESULT VarCySub(CY cyLeft, CY cyRight, CY* pcyResult);

@DllImport("OLEAUT32")
HRESULT VarCyAbs(CY cyIn, CY* pcyResult);

@DllImport("OLEAUT32")
HRESULT VarCyFix(CY cyIn, CY* pcyResult);

@DllImport("OLEAUT32")
HRESULT VarCyInt(CY cyIn, CY* pcyResult);

@DllImport("OLEAUT32")
HRESULT VarCyNeg(CY cyIn, CY* pcyResult);

@DllImport("OLEAUT32")
HRESULT VarCyRound(CY cyIn, int cDecimals, CY* pcyResult);

@DllImport("OLEAUT32")
HRESULT VarCyCmp(CY cyLeft, CY cyRight);

@DllImport("OLEAUT32")
HRESULT VarCyCmpR8(CY cyLeft, double dblRight);

@DllImport("OLEAUT32")
HRESULT VarBstrCat(BSTR bstrLeft, BSTR bstrRight, ushort** pbstrResult);

@DllImport("OLEAUT32")
HRESULT VarBstrCmp(BSTR bstrLeft, BSTR bstrRight, uint lcid, uint dwFlags);

@DllImport("OLEAUT32")
HRESULT VarR8Pow(double dblLeft, double dblRight, double* pdblResult);

@DllImport("OLEAUT32")
HRESULT VarR4CmpR8(float fltLeft, double dblRight);

@DllImport("OLEAUT32")
HRESULT VarR8Round(double dblIn, int cDecimals, double* pdblResult);

@DllImport("OLEAUT32")
HRESULT VarDateFromUdate(UDATE* pudateIn, uint dwFlags, double* pdateOut);

@DllImport("OLEAUT32")
HRESULT VarDateFromUdateEx(UDATE* pudateIn, uint lcid, uint dwFlags, double* pdateOut);

@DllImport("OLEAUT32")
HRESULT VarUdateFromDate(double dateIn, uint dwFlags, UDATE* pudateOut);

@DllImport("OLEAUT32")
HRESULT GetAltMonthNames(uint lcid, ushort*** prgp);

@DllImport("OLEAUT32")
HRESULT VarFormat(VARIANT* pvarIn, ushort* pstrFormat, int iFirstDay, int iFirstWeek, uint dwFlags, BSTR* pbstrOut);

@DllImport("OLEAUT32")
HRESULT VarFormatDateTime(VARIANT* pvarIn, int iNamedFormat, uint dwFlags, BSTR* pbstrOut);

@DllImport("OLEAUT32")
HRESULT VarFormatNumber(VARIANT* pvarIn, int iNumDig, int iIncLead, int iUseParens, int iGroup, uint dwFlags, 
                        BSTR* pbstrOut);

@DllImport("OLEAUT32")
HRESULT VarFormatPercent(VARIANT* pvarIn, int iNumDig, int iIncLead, int iUseParens, int iGroup, uint dwFlags, 
                         BSTR* pbstrOut);

@DllImport("OLEAUT32")
HRESULT VarFormatCurrency(VARIANT* pvarIn, int iNumDig, int iIncLead, int iUseParens, int iGroup, uint dwFlags, 
                          BSTR* pbstrOut);

@DllImport("OLEAUT32")
HRESULT VarWeekdayName(int iWeekday, int fAbbrev, int iFirstDay, uint dwFlags, BSTR* pbstrOut);

@DllImport("OLEAUT32")
HRESULT VarMonthName(int iMonth, int fAbbrev, uint dwFlags, BSTR* pbstrOut);

@DllImport("OLEAUT32")
HRESULT VarFormatFromTokens(VARIANT* pvarIn, ushort* pstrFormat, char* pbTokCur, uint dwFlags, BSTR* pbstrOut, 
                            uint lcid);

@DllImport("OLEAUT32")
HRESULT VarTokenizeFormatString(ushort* pstrFormat, char* rgbTok, int cbTok, int iFirstDay, int iFirstWeek, 
                                uint lcid, int* pcbActual);

@DllImport("OLEAUT32")
uint LHashValOfNameSysA(SYSKIND syskind, uint lcid, const(char)* szName);

@DllImport("OLEAUT32")
uint LHashValOfNameSys(SYSKIND syskind, uint lcid, const(ushort)* szName);

@DllImport("OLEAUT32")
HRESULT LoadTypeLib(ushort* szFile, ITypeLib* pptlib);

@DllImport("OLEAUT32")
HRESULT LoadTypeLibEx(ushort* szFile, REGKIND regkind, ITypeLib* pptlib);

@DllImport("OLEAUT32")
HRESULT LoadRegTypeLib(const(GUID)* rguid, ushort wVerMajor, ushort wVerMinor, uint lcid, ITypeLib* pptlib);

@DllImport("OLEAUT32")
HRESULT QueryPathOfRegTypeLib(const(GUID)* guid, ushort wMaj, ushort wMin, uint lcid, ushort** lpbstrPathName);

@DllImport("OLEAUT32")
HRESULT RegisterTypeLib(ITypeLib ptlib, ushort* szFullPath, ushort* szHelpDir);

@DllImport("OLEAUT32")
HRESULT UnRegisterTypeLib(const(GUID)* libID, ushort wVerMajor, ushort wVerMinor, uint lcid, SYSKIND syskind);

@DllImport("OLEAUT32")
HRESULT RegisterTypeLibForUser(ITypeLib ptlib, ushort* szFullPath, ushort* szHelpDir);

@DllImport("OLEAUT32")
HRESULT UnRegisterTypeLibForUser(const(GUID)* libID, ushort wMajorVerNum, ushort wMinorVerNum, uint lcid, 
                                 SYSKIND syskind);

@DllImport("OLEAUT32")
HRESULT CreateTypeLib(SYSKIND syskind, ushort* szFile, ICreateTypeLib* ppctlib);

@DllImport("OLEAUT32")
HRESULT CreateTypeLib2(SYSKIND syskind, ushort* szFile, ICreateTypeLib2* ppctlib);

@DllImport("OLEAUT32")
HRESULT DispGetParam(DISPPARAMS* pdispparams, uint position, ushort vtTarg, VARIANT* pvarResult, uint* puArgErr);

@DllImport("OLEAUT32")
HRESULT DispGetIDsOfNames(ITypeInfo ptinfo, char* rgszNames, uint cNames, char* rgdispid);

@DllImport("OLEAUT32")
HRESULT DispInvoke(void* _this, ITypeInfo ptinfo, int dispidMember, ushort wFlags, DISPPARAMS* pparams, 
                   VARIANT* pvarResult, EXCEPINFO* pexcepinfo, uint* puArgErr);

@DllImport("OLEAUT32")
HRESULT CreateDispTypeInfo(INTERFACEDATA* pidata, uint lcid, ITypeInfo* pptinfo);

@DllImport("OLEAUT32")
HRESULT CreateStdDispatch(IUnknown punkOuter, void* pvThis, ITypeInfo ptinfo, IUnknown* ppunkStdDisp);

@DllImport("OLEAUT32")
HRESULT DispCallFunc(void* pvInstance, size_t oVft, CALLCONV cc, ushort vtReturn, uint cActuals, char* prgvt, 
                     char* prgpvarg, VARIANT* pvargResult);

@DllImport("OLEAUT32")
HRESULT RegisterActiveObject(IUnknown punk, const(GUID)* rclsid, uint dwFlags, uint* pdwRegister);

@DllImport("OLEAUT32")
HRESULT RevokeActiveObject(uint dwRegister, void* pvReserved);

@DllImport("OLEAUT32")
HRESULT GetActiveObject(const(GUID)* rclsid, void* pvReserved, IUnknown* ppunk);

@DllImport("OLEAUT32")
HRESULT SetErrorInfo(uint dwReserved, IErrorInfo perrinfo);

@DllImport("OLEAUT32")
HRESULT GetErrorInfo(uint dwReserved, IErrorInfo* pperrinfo);

@DllImport("OLEAUT32")
HRESULT CreateErrorInfo(ICreateErrorInfo* pperrinfo);

@DllImport("OLEAUT32")
HRESULT GetRecordInfoFromTypeInfo(ITypeInfo pTypeInfo, IRecordInfo* ppRecInfo);

@DllImport("OLEAUT32")
HRESULT GetRecordInfoFromGuids(const(GUID)* rGuidTypeLib, uint uVerMajor, uint uVerMinor, uint lcid, 
                               const(GUID)* rGuidTypeInfo, IRecordInfo* ppRecInfo);

@DllImport("OLEAUT32")
uint OaBuildVersion();

@DllImport("OLEAUT32")
void ClearCustData(CUSTDATA* pCustData);

@DllImport("OLEAUT32")
void OaEnablePerUserTLibRegistration();


// Interfaces

@GUID("A1F4E726-8CF1-11D1-BF92-0060081ED811")
struct WiaDevMgr;

@GUID("A1E75357-881A-419E-83E2-BB16DB197C68")
struct WiaLog;

@GUID("00020405-0000-0000-C000-000000000046")
interface ICreateTypeInfo : IUnknown
{
    HRESULT SetGuid(const(GUID)* guid);
    HRESULT SetTypeFlags(uint uTypeFlags);
    HRESULT SetDocString(ushort* pStrDoc);
    HRESULT SetHelpContext(uint dwHelpContext);
    HRESULT SetVersion(ushort wMajorVerNum, ushort wMinorVerNum);
    HRESULT AddRefTypeInfo(ITypeInfo pTInfo, uint* phRefType);
    HRESULT AddFuncDesc(uint index, FUNCDESC* pFuncDesc);
    HRESULT AddImplType(uint index, uint hRefType);
    HRESULT SetImplTypeFlags(uint index, int implTypeFlags);
    HRESULT SetAlignment(ushort cbAlignment);
    HRESULT SetSchema(ushort* pStrSchema);
    HRESULT AddVarDesc(uint index, VARDESC* pVarDesc);
    HRESULT SetFuncAndParamNames(uint index, char* rgszNames, uint cNames);
    HRESULT SetVarName(uint index, ushort* szName);
    HRESULT SetTypeDescAlias(TYPEDESC* pTDescAlias);
    HRESULT DefineFuncAsDllEntry(uint index, ushort* szDllName, ushort* szProcName);
    HRESULT SetFuncDocString(uint index, ushort* szDocString);
    HRESULT SetVarDocString(uint index, ushort* szDocString);
    HRESULT SetFuncHelpContext(uint index, uint dwHelpContext);
    HRESULT SetVarHelpContext(uint index, uint dwHelpContext);
    HRESULT SetMops(uint index, BSTR bstrMops);
    HRESULT SetTypeIdldesc(IDLDESC* pIdlDesc);
    HRESULT LayOut();
}

@GUID("0002040E-0000-0000-C000-000000000046")
interface ICreateTypeInfo2 : ICreateTypeInfo
{
    HRESULT DeleteFuncDesc(uint index);
    HRESULT DeleteFuncDescByMemId(int memid, INVOKEKIND invKind);
    HRESULT DeleteVarDesc(uint index);
    HRESULT DeleteVarDescByMemId(int memid);
    HRESULT DeleteImplType(uint index);
    HRESULT SetCustData(const(GUID)* guid, VARIANT* pVarVal);
    HRESULT SetFuncCustData(uint index, const(GUID)* guid, VARIANT* pVarVal);
    HRESULT SetParamCustData(uint indexFunc, uint indexParam, const(GUID)* guid, VARIANT* pVarVal);
    HRESULT SetVarCustData(uint index, const(GUID)* guid, VARIANT* pVarVal);
    HRESULT SetImplTypeCustData(uint index, const(GUID)* guid, VARIANT* pVarVal);
    HRESULT SetHelpStringContext(uint dwHelpStringContext);
    HRESULT SetFuncHelpStringContext(uint index, uint dwHelpStringContext);
    HRESULT SetVarHelpStringContext(uint index, uint dwHelpStringContext);
    HRESULT Invalidate();
    HRESULT SetName(ushort* szName);
}

@GUID("00020406-0000-0000-C000-000000000046")
interface ICreateTypeLib : IUnknown
{
    HRESULT CreateTypeInfo(ushort* szName, TYPEKIND tkind, ICreateTypeInfo* ppCTInfo);
    HRESULT SetName(ushort* szName);
    HRESULT SetVersion(ushort wMajorVerNum, ushort wMinorVerNum);
    HRESULT SetGuid(const(GUID)* guid);
    HRESULT SetDocString(ushort* szDoc);
    HRESULT SetHelpFileName(ushort* szHelpFileName);
    HRESULT SetHelpContext(uint dwHelpContext);
    HRESULT SetLcid(uint lcid);
    HRESULT SetLibFlags(uint uLibFlags);
    HRESULT SaveAllChanges();
}

@GUID("0002040F-0000-0000-C000-000000000046")
interface ICreateTypeLib2 : ICreateTypeLib
{
    HRESULT DeleteTypeInfo(ushort* szName);
    HRESULT SetCustData(const(GUID)* guid, VARIANT* pVarVal);
    HRESULT SetHelpStringContext(uint dwHelpStringContext);
    HRESULT SetHelpStringDll(ushort* szFileName);
}

@GUID("00020400-0000-0000-C000-000000000046")
interface IDispatch : IUnknown
{
    HRESULT GetTypeInfoCount(uint* pctinfo);
    HRESULT GetTypeInfo(uint iTInfo, uint lcid, ITypeInfo* ppTInfo);
    HRESULT GetIDsOfNames(const(GUID)* riid, char* rgszNames, uint cNames, uint lcid, char* rgDispId);
    HRESULT Invoke(int dispIdMember, const(GUID)* riid, uint lcid, ushort wFlags, DISPPARAMS* pDispParams, 
                   VARIANT* pVarResult, EXCEPINFO* pExcepInfo, uint* puArgErr);
}

@GUID("00020404-0000-0000-C000-000000000046")
interface IEnumVARIANT : IUnknown
{
    HRESULT Next(uint celt, VARIANT* rgVar, uint* pCeltFetched);
    HRESULT Skip(uint celt);
    HRESULT Reset();
    HRESULT Clone(IEnumVARIANT* ppEnum);
}

@GUID("00020403-0000-0000-C000-000000000046")
interface ITypeComp : IUnknown
{
    HRESULT Bind(ushort* szName, uint lHashVal, ushort wFlags, ITypeInfo* ppTInfo, DESCKIND* pDescKind, 
                 BINDPTR* pBindPtr);
    HRESULT BindType(ushort* szName, uint lHashVal, ITypeInfo* ppTInfo, ITypeComp* ppTComp);
}

@GUID("00020401-0000-0000-C000-000000000046")
interface ITypeInfo : IUnknown
{
    HRESULT GetTypeAttr(TYPEATTR** ppTypeAttr);
    HRESULT GetTypeComp(ITypeComp* ppTComp);
    HRESULT GetFuncDesc(uint index, FUNCDESC** ppFuncDesc);
    HRESULT GetVarDesc(uint index, VARDESC** ppVarDesc);
    HRESULT GetNames(int memid, char* rgBstrNames, uint cMaxNames, uint* pcNames);
    HRESULT GetRefTypeOfImplType(uint index, uint* pRefType);
    HRESULT GetImplTypeFlags(uint index, int* pImplTypeFlags);
    HRESULT GetIDsOfNames(char* rgszNames, uint cNames, int* pMemId);
    HRESULT Invoke(void* pvInstance, int memid, ushort wFlags, DISPPARAMS* pDispParams, VARIANT* pVarResult, 
                   EXCEPINFO* pExcepInfo, uint* puArgErr);
    HRESULT GetDocumentation(int memid, BSTR* pBstrName, BSTR* pBstrDocString, uint* pdwHelpContext, 
                             BSTR* pBstrHelpFile);
    HRESULT GetDllEntry(int memid, INVOKEKIND invKind, BSTR* pBstrDllName, BSTR* pBstrName, ushort* pwOrdinal);
    HRESULT GetRefTypeInfo(uint hRefType, ITypeInfo* ppTInfo);
    HRESULT AddressOfMember(int memid, INVOKEKIND invKind, void** ppv);
    HRESULT CreateInstance(IUnknown pUnkOuter, const(GUID)* riid, void** ppvObj);
    HRESULT GetMops(int memid, BSTR* pBstrMops);
    HRESULT GetContainingTypeLib(ITypeLib* ppTLib, uint* pIndex);
    void    ReleaseTypeAttr(TYPEATTR* pTypeAttr);
    void    ReleaseFuncDesc(FUNCDESC* pFuncDesc);
    void    ReleaseVarDesc(VARDESC* pVarDesc);
}

@GUID("00020412-0000-0000-C000-000000000046")
interface ITypeInfo2 : ITypeInfo
{
    HRESULT GetTypeKind(TYPEKIND* pTypeKind);
    HRESULT GetTypeFlags(uint* pTypeFlags);
    HRESULT GetFuncIndexOfMemId(int memid, INVOKEKIND invKind, uint* pFuncIndex);
    HRESULT GetVarIndexOfMemId(int memid, uint* pVarIndex);
    HRESULT GetCustData(const(GUID)* guid, VARIANT* pVarVal);
    HRESULT GetFuncCustData(uint index, const(GUID)* guid, VARIANT* pVarVal);
    HRESULT GetParamCustData(uint indexFunc, uint indexParam, const(GUID)* guid, VARIANT* pVarVal);
    HRESULT GetVarCustData(uint index, const(GUID)* guid, VARIANT* pVarVal);
    HRESULT GetImplTypeCustData(uint index, const(GUID)* guid, VARIANT* pVarVal);
    HRESULT GetDocumentation2(int memid, uint lcid, BSTR* pbstrHelpString, uint* pdwHelpStringContext, 
                              BSTR* pbstrHelpStringDll);
    HRESULT GetAllCustData(CUSTDATA* pCustData);
    HRESULT GetAllFuncCustData(uint index, CUSTDATA* pCustData);
    HRESULT GetAllParamCustData(uint indexFunc, uint indexParam, CUSTDATA* pCustData);
    HRESULT GetAllVarCustData(uint index, CUSTDATA* pCustData);
    HRESULT GetAllImplTypeCustData(uint index, CUSTDATA* pCustData);
}

@GUID("00020402-0000-0000-C000-000000000046")
interface ITypeLib : IUnknown
{
    uint    GetTypeInfoCount();
    HRESULT GetTypeInfo(uint index, ITypeInfo* ppTInfo);
    HRESULT GetTypeInfoType(uint index, TYPEKIND* pTKind);
    HRESULT GetTypeInfoOfGuid(const(GUID)* guid, ITypeInfo* ppTinfo);
    HRESULT GetLibAttr(TLIBATTR** ppTLibAttr);
    HRESULT GetTypeComp(ITypeComp* ppTComp);
    HRESULT GetDocumentation(int index, BSTR* pBstrName, BSTR* pBstrDocString, uint* pdwHelpContext, 
                             BSTR* pBstrHelpFile);
    HRESULT IsName(ushort* szNameBuf, uint lHashVal, int* pfName);
    HRESULT FindName(ushort* szNameBuf, uint lHashVal, ITypeInfo* ppTInfo, int* rgMemId, ushort* pcFound);
    void    ReleaseTLibAttr(TLIBATTR* pTLibAttr);
}

@GUID("00020411-0000-0000-C000-000000000046")
interface ITypeLib2 : ITypeLib
{
    HRESULT GetCustData(const(GUID)* guid, VARIANT* pVarVal);
    HRESULT GetLibStatistics(uint* pcUniqueNames, uint* pcchUniqueNames);
    HRESULT GetDocumentation2(int index, uint lcid, BSTR* pbstrHelpString, uint* pdwHelpStringContext, 
                              BSTR* pbstrHelpStringDll);
    HRESULT GetAllCustData(CUSTDATA* pCustData);
}

@GUID("00020410-0000-0000-C000-000000000046")
interface ITypeChangeEvents : IUnknown
{
    HRESULT RequestTypeChange(CHANGEKIND changeKind, ITypeInfo pTInfoBefore, ushort* pStrName, int* pfCancel);
    HRESULT AfterTypeChange(CHANGEKIND changeKind, ITypeInfo pTInfoAfter, ushort* pStrName);
}

@GUID("1CF2B120-547D-101B-8E65-08002B2BD119")
interface IErrorInfo : IUnknown
{
    HRESULT GetGUID(GUID* pGUID);
    HRESULT GetSource(BSTR* pBstrSource);
    HRESULT GetDescription(BSTR* pBstrDescription);
    HRESULT GetHelpFile(BSTR* pBstrHelpFile);
    HRESULT GetHelpContext(uint* pdwHelpContext);
}

@GUID("22F03340-547D-101B-8E65-08002B2BD119")
interface ICreateErrorInfo : IUnknown
{
    HRESULT SetGUID(const(GUID)* rguid);
    HRESULT SetSource(ushort* szSource);
    HRESULT SetDescription(ushort* szDescription);
    HRESULT SetHelpFile(ushort* szHelpFile);
    HRESULT SetHelpContext(uint dwHelpContext);
}

@GUID("DF0B3D60-548F-101B-8E65-08002B2BD119")
interface ISupportErrorInfo : IUnknown
{
    HRESULT InterfaceSupportsErrorInfo(const(GUID)* riid);
}

@GUID("0000002E-0000-0000-C000-000000000046")
interface ITypeFactory : IUnknown
{
    HRESULT CreateFromTypeInfo(ITypeInfo pTypeInfo, const(GUID)* riid, IUnknown* ppv);
}

@GUID("0000002D-0000-0000-C000-000000000046")
interface ITypeMarshal : IUnknown
{
    HRESULT Size(void* pvType, uint dwDestContext, void* pvDestContext, uint* pSize);
    HRESULT Marshal(void* pvType, uint dwDestContext, void* pvDestContext, uint cbBufferLength, char* pBuffer, 
                    uint* pcbWritten);
    HRESULT Unmarshal(void* pvType, uint dwFlags, uint cbBufferLength, char* pBuffer, uint* pcbRead);
    HRESULT Free(void* pvType);
}

@GUID("0000002F-0000-0000-C000-000000000046")
interface IRecordInfo : IUnknown
{
    HRESULT RecordInit(void* pvNew);
    HRESULT RecordClear(void* pvExisting);
    HRESULT RecordCopy(void* pvExisting, void* pvNew);
    HRESULT GetGuid(GUID* pguid);
    HRESULT GetName(BSTR* pbstrName);
    HRESULT GetSize(uint* pcbSize);
    HRESULT GetTypeInfo(ITypeInfo* ppTypeInfo);
    HRESULT GetField(void* pvData, ushort* szFieldName, VARIANT* pvarField);
    HRESULT GetFieldNoCopy(void* pvData, ushort* szFieldName, VARIANT* pvarField, void** ppvDataCArray);
    HRESULT PutField(uint wFlags, void* pvData, ushort* szFieldName, VARIANT* pvarField);
    HRESULT PutFieldNoCopy(uint wFlags, void* pvData, ushort* szFieldName, VARIANT* pvarField);
    HRESULT GetFieldNames(uint* pcNames, char* rgBstrNames);
    BOOL    IsMatchingType(IRecordInfo pRecordInfo);
    void*   RecordCreate();
    HRESULT RecordCreateCopy(void* pvSource, void** ppvDest);
    HRESULT RecordDestroy(void* pvRecord);
}

@GUID("3127CA40-446E-11CE-8135-00AA004BB851")
interface IErrorLog : IUnknown
{
    HRESULT AddError(ushort* pszPropName, EXCEPINFO* pExcepInfo);
}

@GUID("55272A00-42CB-11CE-8135-00AA004BB851")
interface IPropertyBag : IUnknown
{
    HRESULT Read(ushort* pszPropName, VARIANT* pVar, IErrorLog pErrorLog);
    HRESULT Write(ushort* pszPropName, VARIANT* pVar);
}

@GUID("ED6A8A2A-B160-4E77-8F73-AA7435CD5C27")
interface ITypeLibRegistrationReader : IUnknown
{
    HRESULT EnumTypeLibRegistrations(IEnumUnknown* ppEnumUnknown);
}

@GUID("76A3E735-02DF-4A12-98EB-043AD3600AF3")
interface ITypeLibRegistration : IUnknown
{
    HRESULT GetGuid(GUID* pGuid);
    HRESULT GetVersion(BSTR* pVersion);
    HRESULT GetLcid(uint* pLcid);
    HRESULT GetWin32Path(BSTR* pWin32Path);
    HRESULT GetWin64Path(BSTR* pWin64Path);
    HRESULT GetDisplayName(BSTR* pDisplayName);
    HRESULT GetFlags(uint* pFlags);
    HRESULT GetHelpDir(BSTR* pHelpDir);
}

@GUID("A6EF9860-C720-11D0-9337-00A0C90DCAA9")
interface IDispatchEx : IDispatch
{
    HRESULT GetDispID(BSTR bstrName, uint grfdex, int* pid);
    HRESULT InvokeEx(int id, uint lcid, ushort wFlags, DISPPARAMS* pdp, VARIANT* pvarRes, EXCEPINFO* pei, 
                     IServiceProvider pspCaller);
    HRESULT DeleteMemberByName(BSTR bstrName, uint grfdex);
    HRESULT DeleteMemberByDispID(int id);
    HRESULT GetMemberProperties(int id, uint grfdexFetch, uint* pgrfdex);
    HRESULT GetMemberName(int id, BSTR* pbstrName);
    HRESULT GetNextDispID(uint grfdex, int id, int* pid);
    HRESULT GetNameSpaceParent(IUnknown* ppunk);
}

@GUID("A6EF9861-C720-11D0-9337-00A0C90DCAA9")
interface IDispError : IUnknown
{
    HRESULT QueryErrorInfo(GUID guidErrorType, IDispError* ppde);
    HRESULT GetNext(IDispError* ppde);
    HRESULT GetHresult(int* phr);
    HRESULT GetSource(BSTR* pbstrSource);
    HRESULT GetHelpInfo(BSTR* pbstrFileName, uint* pdwContext);
    HRESULT GetDescription(BSTR* pbstrDescription);
}

@GUID("A6EF9862-C720-11D0-9337-00A0C90DCAA9")
interface IVariantChangeType : IUnknown
{
    HRESULT ChangeType(VARIANT* pvarDst, VARIANT* pvarSrc, uint lcid, ushort vtNew);
}

@GUID("CA04B7E6-0D21-11D1-8CC5-00C04FC2B085")
interface IObjectIdentity : IUnknown
{
    HRESULT IsEqualObject(IUnknown punk);
}

@GUID("C5598E60-B307-11D1-B27D-006008C3FBFB")
interface ICanHandleException : IUnknown
{
    HRESULT CanHandleException(EXCEPINFO* pExcepInfo, VARIANT* pvar);
}

@GUID("10E2414A-EC59-49D2-BC51-5ADD2C36FEBC")
interface IProvideRuntimeContext : IUnknown
{
    HRESULT GetCurrentSourceContext(size_t* pdwContext, short* pfExecutingGlobalCode);
}


// GUIDs

const GUID CLSID_WiaDevMgr = GUIDOF!WiaDevMgr;
const GUID CLSID_WiaLog    = GUIDOF!WiaLog;

const GUID IID_ICanHandleException        = GUIDOF!ICanHandleException;
const GUID IID_ICreateErrorInfo           = GUIDOF!ICreateErrorInfo;
const GUID IID_ICreateTypeInfo            = GUIDOF!ICreateTypeInfo;
const GUID IID_ICreateTypeInfo2           = GUIDOF!ICreateTypeInfo2;
const GUID IID_ICreateTypeLib             = GUIDOF!ICreateTypeLib;
const GUID IID_ICreateTypeLib2            = GUIDOF!ICreateTypeLib2;
const GUID IID_IDispError                 = GUIDOF!IDispError;
const GUID IID_IDispatch                  = GUIDOF!IDispatch;
const GUID IID_IDispatchEx                = GUIDOF!IDispatchEx;
const GUID IID_IEnumVARIANT               = GUIDOF!IEnumVARIANT;
const GUID IID_IErrorInfo                 = GUIDOF!IErrorInfo;
const GUID IID_IErrorLog                  = GUIDOF!IErrorLog;
const GUID IID_IObjectIdentity            = GUIDOF!IObjectIdentity;
const GUID IID_IPropertyBag               = GUIDOF!IPropertyBag;
const GUID IID_IProvideRuntimeContext     = GUIDOF!IProvideRuntimeContext;
const GUID IID_IRecordInfo                = GUIDOF!IRecordInfo;
const GUID IID_ISupportErrorInfo          = GUIDOF!ISupportErrorInfo;
const GUID IID_ITypeChangeEvents          = GUIDOF!ITypeChangeEvents;
const GUID IID_ITypeComp                  = GUIDOF!ITypeComp;
const GUID IID_ITypeFactory               = GUIDOF!ITypeFactory;
const GUID IID_ITypeInfo                  = GUIDOF!ITypeInfo;
const GUID IID_ITypeInfo2                 = GUIDOF!ITypeInfo2;
const GUID IID_ITypeLib                   = GUIDOF!ITypeLib;
const GUID IID_ITypeLib2                  = GUIDOF!ITypeLib2;
const GUID IID_ITypeLibRegistration       = GUIDOF!ITypeLibRegistration;
const GUID IID_ITypeLibRegistrationReader = GUIDOF!ITypeLibRegistrationReader;
const GUID IID_ITypeMarshal               = GUIDOF!ITypeMarshal;
const GUID IID_IVariantChangeType         = GUIDOF!IVariantChangeType;
