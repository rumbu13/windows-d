// Written in the D programming language.

module windows.automation;

public import windows.core;
public import windows.com : BYTE_SIZEDARR, FLAGGED_WORD_BLOB, HRESULT, HYPER_SIZEDARR,
                            IEnumUnknown, IUnknown, LONG_SIZEDARR,
                            SHORT_SIZEDARR, STGMEDIUM;
public import windows.systemservices : BOOL, CY, DECIMAL, IServiceProvider;
public import windows.windowsandmessaging : HWND;
public import windows.windowsprogramming : SYSTEMTIME;

extern(Windows):


// Enums


alias SF_TYPE = int;
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

///Specifies a type.
alias TYPEKIND = int;
enum : int
{
    ///A set of enumerators.
    TKIND_ENUM      = 0x00000000,
    ///A structure with no methods.
    TKIND_RECORD    = 0x00000001,
    ///A module that can only have static functions and data (for example, a DLL).
    TKIND_MODULE    = 0x00000002,
    ///A type that has virtual and pure functions.
    TKIND_INTERFACE = 0x00000003,
    ///A set of methods and properties that are accessible through IDispatch::Invoke. By default, dual interfaces return
    ///TKIND_DISPATCH.
    TKIND_DISPATCH  = 0x00000004,
    ///A set of implemented component object interfaces.
    TKIND_COCLASS   = 0x00000005,
    ///A type that is an alias for another type.
    TKIND_ALIAS     = 0x00000006,
    ///A union, all of whose members have an offset of zero.
    TKIND_UNION     = 0x00000007,
    TKIND_MAX       = 0x00000008,
}

///Identifies the calling convention used by a member function described in the METHODDATA structure.
alias CALLCONV = int;
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

///Specifies the function type.
alias FUNCKIND = int;
enum : int
{
    ///The function is accessed the same as PUREVIRTUAL, except the function has an implementation.
    FUNC_VIRTUAL     = 0x00000000,
    ///The function is accessed through the virtual function table (VTBL), and takes an implicit this pointer.
    FUNC_PUREVIRTUAL = 0x00000001,
    ///The function is accessed by static address and takes an implicit this pointer.
    FUNC_NONVIRTUAL  = 0x00000002,
    ///The function is accessed by static address and does not take an implicit this pointer.
    FUNC_STATIC      = 0x00000003,
    FUNC_DISPATCH    = 0x00000004,
}

///Specifies the way a function is invoked.
alias INVOKEKIND = int;
enum : int
{
    ///The member is called using a normal function invocation syntax.
    INVOKE_FUNC           = 0x00000001,
    ///The function is invoked using a normal property-access syntax.
    INVOKE_PROPERTYGET    = 0x00000002,
    ///The function is invoked using a property value assignment syntax. Syntactically, a typical programming language
    ///might represent changing a property in the same way as assignment. For example: object.property : = value.
    INVOKE_PROPERTYPUT    = 0x00000004,
    ///The function is invoked using a property reference assignment syntax.
    INVOKE_PROPERTYPUTREF = 0x00000008,
}

///Specifies the variable type.
alias VARKIND = int;
enum : int
{
    ///The variable is a field or member of the type. It exists at a fixed offset within each instance of the type.
    VAR_PERINSTANCE = 0x00000000,
    ///There is only one instance of the variable.
    VAR_STATIC      = 0x00000001,
    ///The VARDESC describes a symbolic constant. There is no memory associated with it.
    VAR_CONST       = 0x00000002,
    VAR_DISPATCH    = 0x00000003,
}

///The type flags.
alias TYPEFLAGS = int;
enum : int
{
    ///A type description that describes an Application object.
    TYPEFLAG_FAPPOBJECT     = 0x00000001,
    ///Instances of the type can be created by ITypeInfo::CreateInstance.
    TYPEFLAG_FCANCREATE     = 0x00000002,
    ///The type is licensed.
    TYPEFLAG_FLICENSED      = 0x00000004,
    ///The type is predefined. The client application should automatically create a single instance of the object that
    ///has this attribute. The name of the variable that points to the object is the same as the class name of the
    ///object.
    TYPEFLAG_FPREDECLID     = 0x00000008,
    ///The type should not be displayed to browsers.
    TYPEFLAG_FHIDDEN        = 0x00000010,
    ///The type is a control from which other types will be derived, and should not be displayed to users.
    TYPEFLAG_FCONTROL       = 0x00000020,
    ///The interface supplies both IDispatch and VTBL binding.
    TYPEFLAG_FDUAL          = 0x00000040,
    ///The interface cannot add members at run time.
    TYPEFLAG_FNONEXTENSIBLE = 0x00000080,
    ///The types used in the interface are fully compatible with Automation, including VTBL binding support. Setting
    ///dual on an interface sets this flag in addition to TYPEFLAG_FDUAL. Not allowed on dispinterfaces.
    TYPEFLAG_FOLEAUTOMATION = 0x00000100,
    ///Should not be accessible from macro languages. This flag is intended for system-level types or types that type
    ///browsers should not display.
    TYPEFLAG_FRESTRICTED    = 0x00000200,
    ///The class supports aggregation.
    TYPEFLAG_FAGGREGATABLE  = 0x00000400,
    ///The type is replaceable.
    TYPEFLAG_FREPLACEABLE   = 0x00000800,
    ///Indicates that the interface derives from IDispatch, either directly or indirectly. This flag is computed. There
    ///is no Object Description Language for the flag.
    TYPEFLAG_FDISPATCHABLE  = 0x00001000,
    ///The type has reverse binding.
    TYPEFLAG_FREVERSEBIND   = 0x00002000,
    ///Interfaces can be marked with this flag to indicate that they will be using a proxy/stub dynamic link library.
    ///This flag specifies that the typelib proxy should not be unregistered when the typelib is unregistered.
    TYPEFLAG_FPROXY         = 0x00004000,
}

///Specifies function flags.
alias FUNCFLAGS = int;
enum : int
{
    ///The function should not be accessible from macro languages. This flag is intended for system-level functions or
    ///functions that type browsers should not display.
    FUNCFLAG_FRESTRICTED       = 0x00000001,
    ///The function returns an object that is a source of events.
    FUNCFLAG_FSOURCE           = 0x00000002,
    ///The function that supports data binding.
    FUNCFLAG_FBINDABLE         = 0x00000004,
    ///When set, any call to a method that sets the property results first in a call to
    ///<b>IPropertyNotifySink::OnRequestEdit</b>. The implementation of <b>OnRequestEdit</b> determines if the call is
    ///allowed to set the property.
    FUNCFLAG_FREQUESTEDIT      = 0x00000008,
    ///The function that is displayed to the user as bindable. FUNC_FBINDABLE must also be set.
    FUNCFLAG_FDISPLAYBIND      = 0x00000010,
    ///The function that best represents the object. Only one function in a type information can have this attribute.
    FUNCFLAG_FDEFAULTBIND      = 0x00000020,
    ///The function should not be displayed to the user, although it exists and is bindable.
    FUNCFLAG_FHIDDEN           = 0x00000040,
    ///The function supports <b>GetLastError</b>. If an error occurs during the function, the caller can call
    ///<b>GetLastError</b> to retrieve the error code.
    FUNCFLAG_FUSESGETLASTERROR = 0x00000080,
    ///Permits an optimization in which the compiler looks for a member named xyz on the type of abc. If such a member
    ///is found and is flagged as an accessor function for an element of the default collection, then a call is
    ///generated to that member function. Permitted on members in dispinterfaces and interfaces; not permitted on
    ///modules. For more information, refer to defaultcollelem in Type Libraries and the Object Description Language.
    FUNCFLAG_FDEFAULTCOLLELEM  = 0x00000100,
    ///The type information member is the default member for display in the user interface.
    FUNCFLAG_FUIDEFAULT        = 0x00000200,
    ///The property appears in an object browser, but not in a properties browser.
    FUNCFLAG_FNONBROWSABLE     = 0x00000400,
    ///Tags the interface as having default behaviors.
    FUNCFLAG_FREPLACEABLE      = 0x00000800,
    ///Mapped as individual bindable properties.
    FUNCFLAG_FIMMEDIATEBIND    = 0x00001000,
}

///Specifies variable flags.
alias VARFLAGS = int;
enum : int
{
    ///Assignment to the variable should not be allowed.
    VARFLAG_FREADONLY        = 0x00000001,
    ///The variable returns an object that is a source of events.
    VARFLAG_FSOURCE          = 0x00000002,
    ///The variable supports data binding.
    VARFLAG_FBINDABLE        = 0x00000004,
    ///When set, any attempt to directly change the property results in a call to
    ///<b>IPropertyNotifySink::OnRequestEdit</b>. The implementation of <b>OnRequestEdit</b> determines if the change is
    ///accepted.
    VARFLAG_FREQUESTEDIT     = 0x00000008,
    ///The variable is displayed to the user as bindable. VARFLAG_FBINDABLE must also be set.
    VARFLAG_FDISPLAYBIND     = 0x00000010,
    ///The variable is the single property that best represents the object. Only one variable in type information can
    ///have this attribute.
    VARFLAG_FDEFAULTBIND     = 0x00000020,
    ///The variable should not be displayed to the user in a browser, although it exists and is bindable.
    VARFLAG_FHIDDEN          = 0x00000040,
    ///The variable should not be accessible from macro languages. This flag is intended for system-level variables or
    ///variables that you do not want type browsers to display.
    VARFLAG_FRESTRICTED      = 0x00000080,
    ///Permits an optimization in which the compiler looks for a member named "xyz" on the type of abc. If such a member
    ///is found and is flagged as an accessor function for an element of the default collection, then a call is
    ///generated to that member function. Permitted on members in dispinterfaces and interfaces; not permitted on
    ///modules.
    VARFLAG_FDEFAULTCOLLELEM = 0x00000100,
    ///The variable is the default display in the user interface.
    VARFLAG_FUIDEFAULT       = 0x00000200,
    ///The variable appears in an object browser, but not in a properties browser.
    VARFLAG_FNONBROWSABLE    = 0x00000400,
    ///Tags the interface as having default behaviors.
    VARFLAG_FREPLACEABLE     = 0x00000800,
    VARFLAG_FIMMEDIATEBIND   = 0x00001000,
}

///Identifies the type description being bound to.
alias DESCKIND = int;
enum : int
{
    ///No match was found.
    DESCKIND_NONE           = 0x00000000,
    ///A FUNCDESC was returned.
    DESCKIND_FUNCDESC       = 0x00000001,
    ///A VARDESC was returned.
    DESCKIND_VARDESC        = 0x00000002,
    ///A TYPECOMP was returned.
    DESCKIND_TYPECOMP       = 0x00000003,
    ///An IMPLICITAPPOBJ was returned.
    DESCKIND_IMPLICITAPPOBJ = 0x00000004,
    DESCKIND_MAX            = 0x00000005,
}

///Identifies the target operating system platform.
alias SYSKIND = int;
enum : int
{
    ///The target operating system for the type library is 16-bit Windows. By default, data members are packed.
    SYS_WIN16 = 0x00000000,
    ///The target operating system for the type library is 32-bit Windows. By default, data members are naturally
    ///aligned (for example, 2-byte integers are aligned on even-byte boundaries; 4-byte integers are aligned on
    ///quad-word boundaries, and so on).
    SYS_WIN32 = 0x00000001,
    ///The target operating system for the type library is Apple Macintosh. By default, all data members are aligned on
    ///even-byte boundaries.
    SYS_MAC   = 0x00000002,
    SYS_WIN64 = 0x00000003,
}

///Defines flags that apply to type libraries.
alias LIBFLAGS = int;
enum : int
{
    ///The type library is restricted, and should not be displayed to users.
    LIBFLAG_FRESTRICTED   = 0x00000001,
    ///The type library describes controls, and should not be displayed in type browsers intended for nonvisual objects.
    LIBFLAG_FCONTROL      = 0x00000002,
    ///The type library should not be displayed to users, although its use is not restricted. Should be used by
    ///controls. Hosts should create a new type library that wraps the control with extended properties.
    LIBFLAG_FHIDDEN       = 0x00000004,
    LIBFLAG_FHASDISKIMAGE = 0x00000008,
}

alias CHANGEKIND = int;
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

///Controls how a type library is registered.
alias REGKIND = int;
enum : int
{
    ///Use default register behavior.
    REGKIND_DEFAULT  = 0x00000000,
    ///Register this type library.
    REGKIND_REGISTER = 0x00000001,
    REGKIND_NONE     = 0x00000002,
}

///Specifies the variant types.
alias VARENUM = int;
enum : int
{
    ///Not specified.
    VT_EMPTY            = 0x00000000,
    ///Null.
    VT_NULL             = 0x00000001,
    ///A 2-byte integer.
    VT_I2               = 0x00000002,
    ///A 4-byte integer.
    VT_I4               = 0x00000003,
    ///A 4-byte real.
    VT_R4               = 0x00000004,
    ///An 8-byte real.
    VT_R8               = 0x00000005,
    ///Currency.
    VT_CY               = 0x00000006,
    ///A date.
    VT_DATE             = 0x00000007,
    ///A string.
    VT_BSTR             = 0x00000008,
    ///An IDispatch pointer.
    VT_DISPATCH         = 0x00000009,
    ///An SCODE value.
    VT_ERROR            = 0x0000000a,
    ///A Boolean value. True is -1 and false is 0.
    VT_BOOL             = 0x0000000b,
    ///A variant pointer.
    VT_VARIANT          = 0x0000000c,
    ///An IUnknown pointer.
    VT_UNKNOWN          = 0x0000000d,
    ///A 16-byte fixed-pointer value.
    VT_DECIMAL          = 0x0000000e,
    ///A character.
    VT_I1               = 0x00000010,
    ///An unsigned character.
    VT_UI1              = 0x00000011,
    ///An unsigned short.
    VT_UI2              = 0x00000012,
    ///An unsigned long.
    VT_UI4              = 0x00000013,
    ///A 64-bit integer.
    VT_I8               = 0x00000014,
    ///A 64-bit unsigned integer.
    VT_UI8              = 0x00000015,
    ///An integer.
    VT_INT              = 0x00000016,
    ///An unsigned integer.
    VT_UINT             = 0x00000017,
    ///A C-style void.
    VT_VOID             = 0x00000018,
    ///An HRESULT value.
    VT_HRESULT          = 0x00000019,
    ///A pointer type.
    VT_PTR              = 0x0000001a,
    ///A safe array. Use VT_ARRAY in VARIANT.
    VT_SAFEARRAY        = 0x0000001b,
    ///A C-style array.
    VT_CARRAY           = 0x0000001c,
    ///A user-defined type.
    VT_USERDEFINED      = 0x0000001d,
    ///A null-terminated string.
    VT_LPSTR            = 0x0000001e,
    ///A wide null-terminated string.
    VT_LPWSTR           = 0x0000001f,
    ///A user-defined type.
    VT_RECORD           = 0x00000024,
    ///A signed machine register size width.
    VT_INT_PTR          = 0x00000025,
    ///An unsigned machine register size width.
    VT_UINT_PTR         = 0x00000026,
    ///A FILETIME value.
    VT_FILETIME         = 0x00000040,
    ///Length-prefixed bytes.
    VT_BLOB             = 0x00000041,
    ///The name of the stream follows.
    VT_STREAM           = 0x00000042,
    ///The name of the storage follows.
    VT_STORAGE          = 0x00000043,
    ///The stream contains an object.
    VT_STREAMED_OBJECT  = 0x00000044,
    ///The storage contains an object.
    VT_STORED_OBJECT    = 0x00000045,
    ///The blob contains an object.
    VT_BLOB_OBJECT      = 0x00000046,
    ///A clipboard format.
    VT_CF               = 0x00000047,
    ///A class ID.
    VT_CLSID            = 0x00000048,
    ///A stream with a GUID version.
    VT_VERSIONED_STREAM = 0x00000049,
    ///Reserved.
    VT_BSTR_BLOB        = 0x00000fff,
    ///A simple counted array.
    VT_VECTOR           = 0x00001000,
    ///A SAFEARRAY pointer.
    VT_ARRAY            = 0x00002000,
    ///A void pointer for local use.
    VT_BYREF            = 0x00004000,
    VT_RESERVED         = 0x00008000,
    VT_ILLEGAL          = 0x0000ffff,
    VT_ILLEGALMASKED    = 0x00000fff,
    VT_TYPEMASK         = 0x00000fff,
}

// Structs


///Represents the bounds of one dimension of the array.
struct SAFEARRAYBOUND
{
    ///The number of elements in the dimension.
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

///Represents a safe array.
struct SAFEARRAY
{
    ///The number of dimensions.
    ushort            cDims;
    ///Flags. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="FADF_AUTO"></a><a
    ///id="fadf_auto"></a><dl> <dt><b>FADF_AUTO</b></dt> <dt>0x0001</dt> </dl> </td> <td width="60%"> An array that is
    ///allocated on the stack. </td> </tr> <tr> <td width="40%"><a id="FADF_STATIC"></a><a id="fadf_static"></a><dl>
    ///<dt><b>FADF_STATIC</b></dt> <dt>0x0002</dt> </dl> </td> <td width="60%"> An array that is statically allocated.
    ///</td> </tr> <tr> <td width="40%"><a id="FADF_EMBEDDED"></a><a id="fadf_embedded"></a><dl>
    ///<dt><b>FADF_EMBEDDED</b></dt> <dt>0x0004</dt> </dl> </td> <td width="60%"> An array that is embedded in a
    ///structure. </td> </tr> <tr> <td width="40%"><a id="FADF_FIXEDSIZE"></a><a id="fadf_fixedsize"></a><dl>
    ///<dt><b>FADF_FIXEDSIZE</b></dt> <dt>0x0010</dt> </dl> </td> <td width="60%"> An array that may not be resized or
    ///reallocated. </td> </tr> <tr> <td width="40%"><a id="FADF_RECORD"></a><a id="fadf_record"></a><dl>
    ///<dt><b>FADF_RECORD</b></dt> <dt>0x0020</dt> </dl> </td> <td width="60%"> An array that contains records. When
    ///set, there will be a pointer to the IRecordInfo interface at negative offset 4 in the array descriptor. </td>
    ///</tr> <tr> <td width="40%"><a id="FADF_HAVEIID"></a><a id="fadf_haveiid"></a><dl> <dt><b>FADF_HAVEIID</b></dt>
    ///<dt>0x0040</dt> </dl> </td> <td width="60%"> An array that has an IID identifying interface. When set, there will
    ///be a GUID at negative offset 16 in the safe array descriptor. Flag is set only when FADF_DISPATCH or FADF_UNKNOWN
    ///is also set. </td> </tr> <tr> <td width="40%"><a id="FADF_HAVEVARTYPE"></a><a id="fadf_havevartype"></a><dl>
    ///<dt><b>FADF_HAVEVARTYPE</b></dt> <dt>0x0080</dt> </dl> </td> <td width="60%"> An array that has a variant type.
    ///The variant type can be retrieved with SafeArrayGetVartype. </td> </tr> <tr> <td width="40%"><a
    ///id="FADF_BSTR"></a><a id="fadf_bstr"></a><dl> <dt><b>FADF_BSTR</b></dt> <dt>0x0100</dt> </dl> </td> <td
    ///width="60%"> An array of BSTRs. </td> </tr> <tr> <td width="40%"><a id="FADF_UNKNOWN"></a><a
    ///id="fadf_unknown"></a><dl> <dt><b>FADF_UNKNOWN</b></dt> <dt>0x0200</dt> </dl> </td> <td width="60%"> An array of
    ///IUnknown*. </td> </tr> <tr> <td width="40%"><a id="FADF_DISPATCH"></a><a id="fadf_dispatch"></a><dl>
    ///<dt><b>FADF_DISPATCH</b></dt> <dt>0x0400</dt> </dl> </td> <td width="60%"> An array of IDispatch*. </td> </tr>
    ///<tr> <td width="40%"><a id="FADF_VARIANT"></a><a id="fadf_variant"></a><dl> <dt><b>FADF_VARIANT</b></dt>
    ///<dt>0x0800</dt> </dl> </td> <td width="60%"> An array of VARIANTs. </td> </tr> <tr> <td width="40%"><a
    ///id="FADF_RESERVED"></a><a id="fadf_reserved"></a><dl> <dt><b>FADF_RESERVED</b></dt> <dt>0xF008</dt> </dl> </td>
    ///<td width="60%"> Bits reserved for future use. </td> </tr> </table>
    ushort            fFeatures;
    ///The size of an array element.
    uint              cbElements;
    ///The number of times the array has been locked without a corresponding unlock.
    uint              cLocks;
    ///The data.
    void*             pvData;
    ///One bound for each dimension.
    SAFEARRAYBOUND[1] rgsabound;
}

///<b>VARIANTARG</b> describes arguments passed within DISPPARAMS, and <b>VARIANT</b> to specify variant data that
///cannot be passed by reference. When a variant refers to another variant by using the VT_VARIANT | VT_BYREF vartype,
///the variant being referred to cannot also be of type VT_VARIANT | VT_BYREF. VARIANTs can be passed by value, even if
///VARIANTARGs cannot.
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

///Describes the type of a variable, the return type of a function, or the type of a function parameter.
struct TYPEDESC
{
    union
    {
        TYPEDESC*  lptdesc;
        ARRAYDESC* lpadesc;
        uint       hreftype;
    }
    ///The variant type.
    ushort vt;
}

///Describes an array, its element type, and its dimension.
struct ARRAYDESC
{
    ///The element type.
    TYPEDESC          tdescElem;
    ///The dimension count.
    ushort            cDims;
    ///A variable-length array containing one element for each dimension.
    SAFEARRAYBOUND[1] rgbounds;
}

///Contains information about the default value of a parameter.
struct PARAMDESCEX
{
    ///The size of the structure.
    uint    cBytes;
    VARIANT varDefaultValue;
}

///Contains information needed for transferring a structure element, parameter, or function return value between
///processes.
struct PARAMDESC
{
    ///The default value for the parameter, if PARAMFLAG_FHASDEFAULT is specified in <b>wParamFlags</b>.
    PARAMDESCEX* pparamdescex;
    ushort       wParamFlags;
}

struct IDLDESC
{
    size_t dwReserved;
    ushort wIDLFlags;
}

///Contains the type description and process-transfer information for a variable, a function, or a function parameter.
struct ELEMDESC
{
    ///The type of the element.
    TYPEDESC tdesc;
    union
    {
        IDLDESC   idldesc;
        PARAMDESC paramdesc;
    }
}

///Contains attributes of a type.
struct TYPEATTR
{
    ///The GUID of the type information.
    GUID     guid;
    ///The locale of member names and documentation strings.
    uint     lcid;
    ///Reserved.
    uint     dwReserved;
    ///The constructor ID, or MEMBERID_NIL if none.
    int      memidConstructor;
    ///The destructor ID, or MEMBERID_NIL if none.
    int      memidDestructor;
    ///Reserved.
    ushort*  lpstrSchema;
    ///The size of an instance of this type.
    uint     cbSizeInstance;
    ///The kind of type.
    TYPEKIND typekind;
    ///The number of functions.
    ushort   cFuncs;
    ///The number of variables or data members.
    ushort   cVars;
    ///The number of implemented interfaces.
    ushort   cImplTypes;
    ///The size of this type's VTBL.
    ushort   cbSizeVft;
    ///The byte alignment for an instance of this type. A value of 0 indicates alignment on the 64K boundary; 1
    ///indicates no special alignment. For other values, <i>n</i> indicates aligned on byte <i>n</i>.
    ushort   cbAlignment;
    ///The type flags. See TYPEFLAGS.
    ushort   wTypeFlags;
    ///The major version number.
    ushort   wMajorVerNum;
    ///The minor version number.
    ushort   wMinorVerNum;
    ///If <b>typekind</b> is TKIND_ALIAS, specifies the type for which this type is an alias.
    TYPEDESC tdescAlias;
    IDLDESC  idldescType;
}

///Contains the arguments passed to a method or property.
struct DISPPARAMS
{
    ///An array of arguments.
    VARIANT* rgvarg;
    ///The dispatch IDs of the named arguments.
    int*     rgdispidNamedArgs;
    ///The number of arguments.
    uint     cArgs;
    uint     cNamedArgs;
}

///Describes an exception that occurred during IDispatch::Invoke.
struct EXCEPINFO
{
    ///The error code. Error codes should be greater than 1000. Either this field or the scode field must be filled in;
    ///the other must be set to 0.
    ushort            wCode;
    ///Reserved. Should be 0.
    ushort            wReserved;
    ///The name of the exception source. Typically, this is an application name. This field should be filled in by the
    ///implementor of IDispatch.
    BSTR              bstrSource;
    ///The exception description to display. If no description is available, use null.
    BSTR              bstrDescription;
    ///The fully qualified help file path. If no Help is available, use null.
    BSTR              bstrHelpFile;
    ///The help context ID.
    uint              dwHelpContext;
    ///Reserved. Must be null.
    void*             pvReserved;
    ///Provides deferred fill-in. If deferred fill-in is not desired, this field should be set to null.
    HRESULT********** pfnDeferredFillIn;
    ///A return value that describes the error. Either this field or wCode (but not both) must be filled in; the other
    ///must be set to 0. (16-bit Windows versions only.)
    int               scode;
}

///Describes a function.
struct FUNCDESC
{
    ///The function member ID.
    int        memid;
    ///The status code.
    int*       lprgscode;
    ///Description of the element.
    ELEMDESC*  lprgelemdescParam;
    ///Indicates the type of function (virtual, static, or dispatch-only).
    FUNCKIND   funckind;
    ///The invocation type. Indicates whether this is a property function, and if so, which type.
    INVOKEKIND invkind;
    ///The calling convention.
    CALLCONV   callconv;
    ///The total number of parameters.
    short      cParams;
    ///The number of optional parameters.
    short      cParamsOpt;
    ///For FUNC_VIRTUAL, specifies the offset in the VTBL.
    short      oVft;
    ///The number of possible return values.
    short      cScodes;
    ///The function return type.
    ELEMDESC   elemdescFunc;
    ///The function flags. See FUNCFLAGS.
    ushort     wFuncFlags;
}

///Describes a variable, constant, or data member.
struct VARDESC
{
    ///The member ID.
    int      memid;
    ///Reserved.
    ushort*  lpstrSchema;
    union
    {
        uint     oInst;
        VARIANT* lpvarValue;
    }
    ///The variable type.
    ELEMDESC elemdescVar;
    ///The variable flags. See VARFLAGS.
    ushort   wVarFlags;
    VARKIND  varkind;
}

struct CLEANLOCALSTORAGE
{
    IUnknown pInterface;
    void*    pStorage;
    uint     flags;
}

///Represents a custom data item.
struct CUSTDATAITEM
{
    ///The unique identifier of the data item.
    GUID    guid;
    VARIANT varValue;
}

///Represents custom data.
struct CUSTDATA
{
    ///The number of custom data items in the <b>prgCustData</b> array.
    uint          cCustData;
    CUSTDATAITEM* prgCustData;
}

///Describes a pointer.
union BINDPTR
{
    ///Pointer to a function.
    FUNCDESC* lpfuncdesc;
    ///Pointer to a variable, constant, or data member.
    VARDESC*  lpvardesc;
    ITypeComp lptcomp;
}

///Contains information about a type library. Information from this structure is used to identify the type library and
///to provide national language support for member names.
struct TLIBATTR
{
    ///The globally unique identifier.
    GUID    guid;
    ///The locale identifier.
    uint    lcid;
    ///The target hardware platform.
    SYSKIND syskind;
    ///The major version number.
    ushort  wMajorVerNum;
    ///The minor version number.
    ushort  wMinorVerNum;
    ushort  wLibFlags;
}

///Specifies numeric parsing information.
struct NUMPARSE
{
    ///On input, the size of the array. On output, the number of items written to the rgbDig array.
    int  cDig;
    ///Input flags.
    uint dwInFlags;
    ///Output flags. Includes all the values for <b>dwInFlags</b>, plus the following values.
    uint dwOutFlags;
    ///Receives the number of characters (from the beginning of the string) that were successfully parsed.
    int  cchUsed;
    ///The number of bits per digit (3 or 4 for octal and hexadecimal numbers, and zero for decimal).
    int  nBaseShift;
    ///The decimal point position.
    int  nPwr10;
}

struct UDATE
{
    SYSTEMTIME st;
    ushort     wDayOfYear;
}

///Describes a parameter accepted by a method or property.
struct PARAMDATA
{
    ///The parameter name. Names should follow standard conventions for programming language access; that is, no
    ///embedded spaces or control characters, and 32 or fewer characters. The name should be localized because each type
    ///description provides names for a particular locale.
    ushort* szName;
    ushort  vt;
}

///Describes a method or property.
struct METHODDATA
{
    ///The method name.
    ushort*    szName;
    ///An array of method parameters.
    PARAMDATA* ppdata;
    ///The ID of the method, as used in IDispatch.
    int        dispid;
    ///The index of the method in the VTBL of the interface, starting with 0.
    uint       iMeth;
    ///The calling convention. The CDECL and Pascal calling conventions are supported by the dispatch interface creation
    ///functions, such as CreateStdDispatch.
    CALLCONV   cc;
    ///The number of arguments.
    uint       cArgs;
    ///Invoke flags. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
    ///id="DISPATCH_METHOD"></a><a id="dispatch_method"></a><dl> <dt><b>DISPATCH_METHOD</b></dt> </dl> </td> <td
    ///width="60%"> The member is invoked as a method. If a property has the same name, both this and the
    ///DISPATCH_PROPERTYGET flag can be set. </td> </tr> <tr> <td width="40%"><a id="DISPATCH_PROPERTYGET"></a><a
    ///id="dispatch_propertyget"></a><dl> <dt><b>DISPATCH_PROPERTYGET</b></dt> </dl> </td> <td width="60%"> The member
    ///is retrieved as a property or data member. </td> </tr> <tr> <td width="40%"><a id="DISPATCH_PROPERTYPUT"></a><a
    ///id="dispatch_propertyput"></a><dl> <dt><b>DISPATCH_PROPERTYPUT</b></dt> </dl> </td> <td width="60%"> The member
    ///is set as a property or data member. </td> </tr> <tr> <td width="40%"><a id="DISPATCH_PROPERTYPUTREF"></a><a
    ///id="dispatch_propertyputref"></a><dl> <dt><b>DISPATCH_PROPERTYPUTREF</b></dt> </dl> </td> <td width="60%"> The
    ///member is changed by a reference assignment, rather than a value assignment. This flag is valid only when the
    ///property accepts a reference to an object. </td> </tr> </table>
    ushort     wFlags;
    ushort     vtReturn;
}

///Describes the object's properties and methods.
struct INTERFACEDATA
{
    ///An array of METHODDATA structures.
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

///Calculates the wire size of the BSTR object, and gets its handle and data.
///Params:
///    arg1 = The data used by RPC.
///    arg2 = The current buffer offset where the object will be marshaled. The method has to account for any padding needed
///           for the BSTR object to be properly aligned when it will be marshaled to the buffer.
///    arg3 = The object.
@DllImport("OLEAUT32")
uint BSTR_UserSize(uint* param0, uint param1, BSTR* param2);

///Marshals a BSTR object into the RPC buffer.
///Params:
///    arg1 = The data used by RPC.
///    arg2 = The current buffer. This pointer may or may not be aligned on entry.
///    arg3 = The object.
@DllImport("OLEAUT32")
ubyte* BSTR_UserMarshal(uint* param0, ubyte* param1, BSTR* param2);

///Unmarshals a BSTR object from the RPC buffer.
///Params:
///    arg1 = The data used by RPC.
///    arg2 = The current buffer. This pointer may or may not be aligned on entry.
///    arg3 = The object.
@DllImport("OLEAUT32")
ubyte* BSTR_UserUnmarshal(uint* param0, char* param1, BSTR* param2);

///Frees resources on the server side when called by RPC stub files.
///Params:
///    arg1 = The data used by RPC.
@DllImport("OLEAUT32")
void BSTR_UserFree(uint* param0, BSTR* param1);

///Calculates the wire size of the SAFEARRAY object, and gets its handle and data.
///Params:
///    arg1 = The data used by RPC.
///    arg2 = Sets the buffer offset so that the SAFEARRAY object is properly aligned when it is marshaled to the buffer.
///    arg3 = The safe array that contains the data to marshal.
@DllImport("OLEAUT32")
uint LPSAFEARRAY_UserSize(uint* param0, uint param1, SAFEARRAY** param2);

///Marshals data from the specified SAFEARRAY object to the user's RPC buffer on the client or server side.
///Params:
///    arg1 = The data used by RPC.
///    arg2 = The current buffer. This pointer may or may not be aligned on entry. The function aligns the buffer pointer,
///           marshals the data, and returns the new buffer position, which is the address of the first byte after the
///           marshaled object.
///    arg3 = The safe array that contains the data to marshal.
@DllImport("OLEAUT32")
ubyte* LPSAFEARRAY_UserMarshal(uint* param0, ubyte* param1, SAFEARRAY** param2);

///Unmarshals a SAFEARRAY object from the RPC buffer.
///Params:
///    arg1 = The data used by RPC.
///    arg2 = The current buffer. This pointer may or may not be aligned on entry. The function aligns the buffer pointer,
///           marshals the data, and returns the new buffer position, which is the address of the first byte after the
///           marshaled object.
///    arg3 = Receives the safe array that contains the data.
@DllImport("OLEAUT32")
ubyte* LPSAFEARRAY_UserUnmarshal(uint* param0, char* param1, SAFEARRAY** param2);

///Frees resources on the server side when called by RPC stub files.
///Params:
///    arg1 = The data used by RPC.
@DllImport("OLEAUT32")
void LPSAFEARRAY_UserFree(uint* param0, SAFEARRAY** param1);

///Calculates the wire size of the BSTR object, and gets its handle and data.
///Params:
///    arg1 = The data used by RPC.
///    arg2 = The current buffer offset where the object will be marshaled. The method has to account for any padding needed
///           for the BSTR object to be properly aligned when it will be marshaled to the buffer.
///    arg3 = The object.
@DllImport("OLEAUT32")
uint BSTR_UserSize64(uint* param0, uint param1, BSTR* param2);

///Marshals a BSTR object into the RPC buffer.
///Params:
///    arg1 = The data used by RPC.
///    arg2 = The current buffer. This pointer may or may not be aligned on entry.
///    arg3 = The object.
@DllImport("OLEAUT32")
ubyte* BSTR_UserMarshal64(uint* param0, ubyte* param1, BSTR* param2);

///Unmarshals a BSTR object from the RPC buffer.
///Params:
///    arg1 = The data used by RPC.
///    arg2 = The current buffer. This pointer may or may not be aligned on entry.
///    arg3 = The object.
@DllImport("OLEAUT32")
ubyte* BSTR_UserUnmarshal64(uint* param0, char* param1, BSTR* param2);

///Frees resources on the server side when called by RPC stub files.
///Params:
///    arg1 = The data used by RPC.
@DllImport("OLEAUT32")
void BSTR_UserFree64(uint* param0, BSTR* param1);

///Calculates the wire size of the SAFEARRAY object, and gets its handle and data.
///Params:
///    arg1 = The data used by RPC.
///    arg2 = Sets the buffer offset so that the SAFEARRAY object is properly aligned when it is marshaled to the buffer.
///    arg3 = The safe array that contains the data to marshal.
@DllImport("OLEAUT32")
uint LPSAFEARRAY_UserSize64(uint* param0, uint param1, SAFEARRAY** param2);

///Marshals data from the specified SAFEARRAY object to the user's RPC buffer on the client or server side.
///Params:
///    arg1 = The data used by RPC.
///    arg2 = The current buffer. This pointer may or may not be aligned on entry. The function aligns the buffer pointer,
///           marshals the data, and returns the new buffer position, which is the address of the first byte after the
///           marshaled object.
///    arg3 = The safe array that contains the data to marshal.
@DllImport("OLEAUT32")
ubyte* LPSAFEARRAY_UserMarshal64(uint* param0, ubyte* param1, SAFEARRAY** param2);

///Unmarshals a SAFEARRAY object from the RPC buffer.
///Params:
///    arg1 = The data used by RPC.
///    arg2 = The current buffer. This pointer may or may not be aligned on entry. The function aligns the buffer pointer,
///           marshals the data, and returns the new buffer position, which is the address of the first byte after the
///           marshaled object.
///    arg3 = Receives the safe array that contains the data.
@DllImport("OLEAUT32")
ubyte* LPSAFEARRAY_UserUnmarshal64(uint* param0, char* param1, SAFEARRAY** param2);

///Frees resources on the server side when called by RPC stub files.
///Params:
///    arg1 = The data used by RPC.
@DllImport("OLEAUT32")
void LPSAFEARRAY_UserFree64(uint* param0, SAFEARRAY** param1);

///Calculates the wire size of the VARIANT object, and gets its handle and data.
///Params:
///    arg1 = The data used by RPC.
///    arg2 = The current buffer offset where the object will be marshaled. The method has to account for any padding needed
///           for the object to be properly aligned when it will be marshaled to the buffer.
///    arg3 = The object.
@DllImport("OLEAUT32")
uint VARIANT_UserSize(uint* param0, uint param1, VARIANT* param2);

///Marshals a VARIANT object into the RPC buffer.
///Params:
///    arg1 = The data used by RPC.
///    arg2 = The current buffer. This pointer may or may not be aligned on entry.
///    arg3 = The object.
@DllImport("OLEAUT32")
ubyte* VARIANT_UserMarshal(uint* param0, ubyte* param1, VARIANT* param2);

///Unmarshals a VARIANT object from the RPC buffer.
///Params:
///    arg1 = The data used by RPC.
///    arg2 = The current buffer. This pointer may or may not be aligned on entry.
///    arg3 = The object.
@DllImport("OLEAUT32")
ubyte* VARIANT_UserUnmarshal(uint* param0, char* param1, VARIANT* param2);

///Frees resources on the server side when called by RPC stub files.
///Params:
///    arg1 = The data used by RPC.
@DllImport("OLEAUT32")
void VARIANT_UserFree(uint* param0, VARIANT* param1);

///Calculates the wire size of the VARIANT object, and gets its handle and data.
///Params:
///    arg1 = The data used by RPC.
///    arg2 = The current buffer offset where the object will be marshaled. The method has to account for any padding needed
///           for the object to be properly aligned when it will be marshaled to the buffer.
///    arg3 = The object.
@DllImport("OLEAUT32")
uint VARIANT_UserSize64(uint* param0, uint param1, VARIANT* param2);

///Marshals a VARIANT object into the RPC buffer.
///Params:
///    arg1 = The data used by RPC.
///    arg2 = The current buffer. This pointer may or may not be aligned on entry.
///    arg3 = The object.
@DllImport("OLEAUT32")
ubyte* VARIANT_UserMarshal64(uint* param0, ubyte* param1, VARIANT* param2);

///Unmarshals a VARIANT object from the RPC buffer.
///Params:
///    arg1 = The data used by RPC.
///    arg2 = The current buffer. This pointer may or may not be aligned on entry.
///    arg3 = The object.
@DllImport("OLEAUT32")
ubyte* VARIANT_UserUnmarshal64(uint* param0, char* param1, VARIANT* param2);

///Frees resources on the server side when called by RPC stub files.
///Params:
///    arg1 = The data used by RPC.
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

///Creates an <b>IPictureDisp</b> object from a picture file on disk.
///Params:
///    varFileName = The path and name of the picture file to load.
///    lplpdispPicture = The location that receives a pointer to the <b>IPictureDisp</b> object.
///Returns:
///    This method returns standard COM error codes in addition to the following values. <table> <tr> <th>Return
///    code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%">
///    The method completed successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>CTL_E_INVALIDPICTURE</b></dt>
///    </dl> </td> <td width="60%"> Invalid picture file. </td> </tr> </table>
///    
@DllImport("OLEAUT32")
HRESULT OleLoadPictureFile(VARIANT varFileName, IDispatch* lplpdispPicture);

///Loads a picture from a file.
///Params:
///    varFileName = The path and name of the picture file to load.
///    xSizeDesired = The desired length for the picture to be displayed.
///    ySizeDesired = The desired height for the picture to be displayed.
///    dwFlags = The desired color depth for the icon or cursor. Together with the desired size it is used to select the best
///              matching image. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
///              id="LP_MONOCHROME_"></a><a id="lp_monochrome_"></a><dl> <dt><b>LP_MONOCHROME </b></dt> </dl> </td> <td
///              width="60%"> Creates a monochrome picture to display on a monitor. </td> </tr> <tr> <td width="40%"><a
///              id="LP_VGACOLOR_"></a><a id="lp_vgacolor_"></a><dl> <dt><b>LP_VGACOLOR </b></dt> </dl> </td> <td width="60%">
///              Creates a 16-color picture to display on a monitor. </td> </tr> <tr> <td width="40%"><a id="LP_COLOR_"></a><a
///              id="lp_color_"></a><dl> <dt><b>LP_COLOR </b></dt> </dl> </td> <td width="60%"> Creates a 256-color picture to
///              display on a monitor. </td> </tr> <tr> <td width="40%"><a id="LP_DEFAULT_"></a><a id="lp_default_"></a><dl>
///              <dt><b>LP_DEFAULT </b></dt> </dl> </td> <td width="60%"> Selects the best color depth to use for the current
///              display. </td> </tr> </table>
///    lplpdispPicture = The location that receives a pointer to the picture.
///Returns:
///    This method returns standard COM error codes in addition to the following values. <table> <tr> <th>Return
///    code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%">
///    The method completed successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>DISP_E_PARAMNOTFOUND</b></dt>
///    </dl> </td> <td width="60%"> <i>varFileName</i> is not valid. </td> </tr> </table>
///    
@DllImport("OLEAUT32")
HRESULT OleLoadPictureFileEx(VARIANT varFileName, uint xSizeDesired, uint ySizeDesired, uint dwFlags, 
                             IDispatch* lplpdispPicture);

///Saves a picture to a file.
///Params:
///    lpdispPicture = Points to the <b>IPictureDisp</b> picture object.
///    bstrFileName = The name of the file to save the picture to.
@DllImport("OLEAUT32")
HRESULT OleSavePictureFile(IDispatch lpdispPicture, BSTR bstrFileName);

///Allocates a new string and copies the passed string into it.
///Params:
///    psz = The string to copy.
///Returns:
///    If successful, returns the string. If <i>psz</i> is a zero-length string, returns a zero-length <b>BSTR</b>. If
///    <i>psz</i> is NULL or insufficient memory exists, returns NULL.
///    
@DllImport("OLEAUT32")
BSTR SysAllocString(const(ushort)* psz);

///Reallocates a previously allocated string to be the size of a second string and copies the second string into the
///reallocated memory.
///Params:
///    pbstr = The previously allocated string.
///    psz = The string to copy.
///Returns:
///    <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>TRUE</b></dt>
///    </dl> </td> <td width="60%"> The string is reallocated successfully. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>FALSE</b></dt> </dl> </td> <td width="60%"> Insufficient memory exists. </td> </tr> </table>
///    
@DllImport("OLEAUT32")
int SysReAllocString(char* pbstr, const(ushort)* psz);

///Allocates a new string, copies the specified number of characters from the passed string, and appends a
///null-terminating character.
///Params:
///    strIn = The input string.
///    ui = The number of characters to copy. A null character is placed afterwards, allocating a total of <i>ui</i> plus one
///         characters.
///Returns:
///    A copy of the string, or <b>NULL</b> if there is insufficient memory to complete the operation.
///    
@DllImport("OLEAUT32")
BSTR SysAllocStringLen(char* strIn, uint ui);

///Creates a new BSTR containing a specified number of characters from an old BSTR, and frees the old BSTR.
///Params:
///    pbstr = The previously allocated string.
///    psz = The string from which to copy <i>len</i> characters, or NULL to keep the string uninitialized.
///    len = The number of characters to copy. A null character is placed afterward, allocating a total of <i>len</i> plus one
///          characters.
///Returns:
///    <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>TRUE</b></dt>
///    </dl> </td> <td width="60%"> The string is reallocated successfully. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>FALSE</b></dt> </dl> </td> <td width="60%"> Insufficient memory exists. </td> </tr> </table>
///    
@DllImport("OLEAUT32")
int SysReAllocStringLen(char* pbstr, const(ushort)* psz, uint len);

///<div class="alert"><b>Note</b> You should only call <b>SysAddRefString</b> if you are implementing a scripting engine
///that needs to guard against running potentially malicious scripts.</div><div> </div>Increases the pinning reference
///count for the specified string by one.
///Params:
///    bstrString = The string for which the pinning reference count should increase. While that count remains greater than 0, the
///                 memory for the string is prevented from being freed by calls to the SysFreeString function.
///Returns:
///    If this function succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
///    
@DllImport("OLEAUT32")
HRESULT SysAddRefString(BSTR bstrString);

///<div class="alert"><b>Note</b> You should only call <b>SysReleaseString</b> if you are implementing a scripting
///engine that needs to guard against running potentially malicious scripts.</div><div> </div>Decreases the pinning
///reference count for the specified string by one. When that count reaches 0, the memory for that string is no longer
///prevented from being freed.
///Params:
///    bstrString = The string for which the pinning reference count should decrease.
@DllImport("OLEAUT32")
void SysReleaseString(BSTR bstrString);

///Deallocates a string allocated previously by SysAllocString, SysAllocStringByteLen, SysReAllocString,
///SysAllocStringLen, or SysReAllocStringLen.
@DllImport("OLEAUT32")
void SysFreeString(BSTR bstrString);

///Returns the length of a BSTR.
///Params:
///    pbstr = A previously allocated string.
///Returns:
///    The number of characters in <i>bstr</i>, not including the terminating null character. If <i>bstr</i> is null the
///    return value is zero.
///    
@DllImport("OLEAUT32")
uint SysStringLen(BSTR pbstr);

///Returns the length (in bytes) of a BSTR.
///Params:
///    bstr = A previously allocated string.
///Returns:
///    The number of bytes in <i>bstr</i>, not including the terminating null character. If <i>bstr</i> is null the
///    return value is zero.
///    
@DllImport("OLEAUT32")
uint SysStringByteLen(BSTR bstr);

///Takes an ANSI string as input, and returns a BSTR that contains an ANSI string. Does not perform any ANSI-to-Unicode
///translation.
///Params:
///    psz = The string to copy, or NULL to keep the string uninitialized.
///    len = The number of bytes to copy. A null character is placed afterwards, allocating a total of <i>len</i> plus the
///          size of <b>OLECHAR</b> bytes.
///Returns:
///    A copy of the string, or NULL if there is insufficient memory to complete the operation.
///    
@DllImport("OLEAUT32")
BSTR SysAllocStringByteLen(const(char)* psz, uint len);

///Converts the MS-DOS representation of time to the date and time representation stored in a variant.
///Params:
///    wDosDate = The MS-DOS date to convert. The valid range of MS-DOS dates is January 1, 1980, to December 31, 2099, inclusive.
///    wDosTime = The MS-DOS time to convert.
///    pvtime = The converted time.
///Returns:
///    The function returns TRUE on success and FALSE otherwise.
///    
@DllImport("OLEAUT32")
int DosDateTimeToVariantTime(ushort wDosDate, ushort wDosTime, double* pvtime);

///Converts the variant representation of a date and time to MS-DOS date and time values.
///Params:
///    vtime = The variant time to convert.
///    pwDosDate = Receives the converted MS-DOS date.
///    pwDosTime = Receives the converted MS-DOS time
///Returns:
///    The function returns TRUE on success and FALSE otherwise.
///    
@DllImport("OLEAUT32")
int VariantTimeToDosDateTime(double vtime, ushort* pwDosDate, ushort* pwDosTime);

///Converts a system time to a variant representation.
///Params:
///    lpSystemTime = The system time.
///    pvtime = The variant time.
///Returns:
///    The function returns TRUE on success and FALSE otherwise.
///    
@DllImport("OLEAUT32")
int SystemTimeToVariantTime(SYSTEMTIME* lpSystemTime, double* pvtime);

///Converts the variant representation of time to system time values.
///Params:
///    vtime = The variant time to convert.
///    lpSystemTime = Receives the system time.
///Returns:
///    The function returns TRUE on success and FALSE otherwise.
///    
@DllImport("OLEAUT32")
int VariantTimeToSystemTime(double vtime, SYSTEMTIME* lpSystemTime);

///Allocates memory for a safe array descriptor.
///Params:
///    cDims = The number of dimensions of the array.
///    ppsaOut = The safe array descriptor.
///Returns:
///    This function can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The argument <i>psa</i> was not
///    valid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_UNEXPECTED</b></dt> </dl> </td> <td width="60%"> The array
///    could not be locked. </td> </tr> </table>
///    
@DllImport("OLEAUT32")
HRESULT SafeArrayAllocDescriptor(uint cDims, SAFEARRAY** ppsaOut);

///Creates a safe array descriptor for an array of any valid variant type, including VT_RECORD, without allocating the
///array data.
///Params:
///    vt = The variant type.
///    cDims = The number of dimensions in the array.
///    ppsaOut = The safe array descriptor.
///Returns:
///    This function can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The argument <i>psa</i> was not
///    valid. </td> </tr> </table>
///    
@DllImport("OLEAUT32")
HRESULT SafeArrayAllocDescriptorEx(ushort vt, uint cDims, SAFEARRAY** ppsaOut);

///Allocates memory for a safe array, based on a descriptor created with SafeArrayAllocDescriptor.
///Params:
///    psa = A safe array descriptor created by SafeArrayAllocDescriptor.
@DllImport("OLEAUT32")
HRESULT SafeArrayAllocData(SAFEARRAY* psa);

///Creates a new array descriptor, allocates and initializes the data for the array, and returns a pointer to the new
///array descriptor.
///Params:
///    vt = The base type of the array (the VARTYPE of each element of the array). The VARTYPE is restricted to a subset of
///         the variant types. Neither the VT_ARRAY nor the VT_BYREF flag can be set. VT_EMPTY and VT_NULL are not valid base
///         types for the array. All other types are legal.
///    cDims = The number of dimensions in the array. The number cannot be changed after the array is created.
///    rgsabound = A vector of bounds (one for each dimension) to allocate for the array.
@DllImport("OLEAUT32")
SAFEARRAY* SafeArrayCreate(ushort vt, uint cDims, SAFEARRAYBOUND* rgsabound);

///Creates and returns a safe array descriptor from the specified VARTYPE, number of dimensions and bounds.
///Params:
///    vt = The base type or the VARTYPE of each element of the array. The FADF_RECORD flag can be set for a variant type
///         VT_RECORD, The FADF_HAVEIID flag can be set for VT_DISPATCH or VT_UNKNOWN, and FADF_HAVEVARTYPE can be set for
///         all other VARTYPEs.
///    cDims = The number of dimensions in the array.
///    rgsabound = A vector of bounds (one for each dimension) to allocate for the array.
///    pvExtra = the type information of the user-defined type, if you are creating a safe array of user-defined types. If the vt
///              parameter is VT_RECORD, then <i>pvExtra</i> will be a pointer to an IRecordInfo describing the record. If the
///              <i>vt</i> parameter is VT_DISPATCH or VT_UNKNOWN, then <i>pvExtra</i> will contain a pointer to a GUID
///              representing the type of interface being passed to the array.
///Returns:
///    A safe array descriptor, or null if the array could not be created.
///    
@DllImport("OLEAUT32")
SAFEARRAY* SafeArrayCreateEx(ushort vt, uint cDims, SAFEARRAYBOUND* rgsabound, void* pvExtra);

///Copies the source array to the specified target array after releasing any resources in the target array. This is
///similar to SafeArrayCopy, except that the target array has to be set up by the caller. The target is not allocated or
///reallocated.
///Params:
///    psaSource = The safe array to copy.
///    psaTarget = The target safe array.
@DllImport("OLEAUT32")
HRESULT SafeArrayCopyData(SAFEARRAY* psaSource, SAFEARRAY* psaTarget);

///<div class="alert"><b>Note</b> You should only call <b>SafeArrayReleaseDescriptor</b> if you are implementing a
///scripting engine that needs to guard against running potentially malicious scripts.</div><div> </div>Decreases the
///pinning reference count for the descriptor of the specified safe array by one. When that count reaches 0, the memory
///for that descriptor is no longer prevented from being freed.
///Params:
///    psa = The safe array for which the pinning reference count of the descriptor should decrease.
@DllImport("OLEAUT32")
void SafeArrayReleaseDescriptor(SAFEARRAY* psa);

///Destroys the descriptor of the specified safe array.
///Params:
///    psa = A safe array descriptor.
///Returns:
///    This function can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The argument <i>psa</i> was not
///    valid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>DISP_E_ARRAYISLOCKED</b></dt> </dl> </td> <td width="60%">
///    The array is locked. </td> </tr> </table>
///    
@DllImport("OLEAUT32")
HRESULT SafeArrayDestroyDescriptor(SAFEARRAY* psa);

///<div class="alert"><b>Note</b> You should only call <b>SafeArrayReleaseData</b> if you are implementing a scripting
///engine that needs to guard against running potentially malicious scripts.</div><div> </div>Decreases the pinning
///reference count for the specified safe array data by one. When that count reaches 0, the memory for that data is no
///longer prevented from being freed.
///Params:
///    pData = The safe array data for which the pinning reference count should decrease.
@DllImport("OLEAUT32")
void SafeArrayReleaseData(void* pData);

///Destroys all the data in the specified safe array.
///Params:
///    psa = A safe array descriptor.
///Returns:
///    This function can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The argument <i>psa</i> was not
///    valid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>DISP_E_ARRAYISLOCKED</b></dt> </dl> </td> <td width="60%">
///    The array is locked. </td> </tr> </table>
///    
@DllImport("OLEAUT32")
HRESULT SafeArrayDestroyData(SAFEARRAY* psa);

///<div class="alert"><b>Note</b> You should only call <b>SafeArrayAddRef</b> if you are implementing a scripting engine
///that needs to guard against running potentially malicious scripts.</div><div> </div>Increases the pinning reference
///count of the descriptor for the specified safe array by one, and may increase the pinning reference count of the data
///for the specified safe array by one if that data was dynamically allocated, as determined by the descriptor of the
///safe array.
///Params:
///    psa = The safe array for which the pinning reference count of the descriptor should increase. While that count remains
///          greater than 0, the memory for the descriptor is prevented from being freed by calls to the SafeArrayDestroy or
///          SafeArrayDestroyDescriptor functions.
///    ppDataToRelease = Returns the safe array data for which a pinning reference was added, if <b>SafeArrayAddRef</b> also added a
///                      pinning reference for the safe array data. This parameter is NULL if <b>SafeArrayAddRef</b> did not add a pinning
///                      reference for the safe array data. <b>SafeArrayAddRef</b> does not add a pinning reference for the safe array
///                      data if that safe array data was not dynamically allocated.
///Returns:
///    If this function succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
///    
@DllImport("OLEAUT32")
HRESULT SafeArrayAddRef(SAFEARRAY* psa, void** ppDataToRelease);

///Destroys an existing array descriptor and all of the data in the array. If objects are stored in the array,
///<b>Release</b> is called on each object in the array.
///Params:
///    psa = An array descriptor created by SafeArrayCreate.
///Returns:
///    This function can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The argument <i>psa</i> is not valid.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>DISP_E_ARRAYISLOCKED</b></dt> </dl> </td> <td width="60%"> The
///    array is locked. </td> </tr> </table>
///    
@DllImport("OLEAUT32")
HRESULT SafeArrayDestroy(SAFEARRAY* psa);

///Changes the right-most (least significant) bound of the specified safe array.
///Params:
///    psa = A safe array descriptor.
///    psaboundNew = A new safe array bound structure that contains the new array boundary. You can change only the least significant
///                  dimension of an array.
///Returns:
///    This function can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The argument <i>psa</i> is not valid.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>DISP_E_ARRAYISLOCKED</b></dt> </dl> </td> <td width="60%"> The
///    array is locked. </td> </tr> </table>
///    
@DllImport("OLEAUT32")
HRESULT SafeArrayRedim(SAFEARRAY* psa, SAFEARRAYBOUND* psaboundNew);

///Gets the number of dimensions in the array.
///Params:
///    psa = An array descriptor created by SafeArrayCreate.
@DllImport("OLEAUT32")
uint SafeArrayGetDim(SAFEARRAY* psa);

///Gets the size of an element.
///Params:
///    psa = An array descriptor created by SafeArrayCreate.
@DllImport("OLEAUT32")
uint SafeArrayGetElemsize(SAFEARRAY* psa);

///Gets the upper bound for any dimension of the specified safe array.
///Params:
///    psa = An array descriptor created by SafeArrayCreate.
///    nDim = The array dimension for which to get the upper bound.
///    plUbound = The upper bound.
@DllImport("OLEAUT32")
HRESULT SafeArrayGetUBound(SAFEARRAY* psa, uint nDim, int* plUbound);

///Gets the lower bound for any dimension of the specified safe array.
///Params:
///    psa = An array descriptor created by SafeArrayCreate.
///    nDim = The array dimension for which to get the lower bound.
///    plLbound = The lower bound.
@DllImport("OLEAUT32")
HRESULT SafeArrayGetLBound(SAFEARRAY* psa, uint nDim, int* plLbound);

///Increments the lock count of an array, and places a pointer to the array data in pvData of the array descriptor.
///Params:
///    psa = An array descriptor created by SafeArrayCreate.
///Returns:
///    This function can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The argument <i>psa</i> is not valid.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_UNEXPECTED</b></dt> </dl> </td> <td width="60%"> The array could
///    not be locked. </td> </tr> </table>
///    
@DllImport("OLEAUT32")
HRESULT SafeArrayLock(SAFEARRAY* psa);

///Decrements the lock count of an array so it can be freed or resized.
///Params:
///    psa = An array descriptor created by SafeArrayCreate.
///Returns:
///    This function can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The argument <i>psa</i> is not valid.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_UNEXPECTED</b></dt> </dl> </td> <td width="60%"> The array could
///    not be unlocked. </td> </tr> </table>
///    
@DllImport("OLEAUT32")
HRESULT SafeArrayUnlock(SAFEARRAY* psa);

///Increments the lock count of an array, and retrieves a pointer to the array data.
///Params:
///    psa = An array descriptor created by SafeArrayCreate.
///    ppvData = The array data.
///Returns:
///    This function can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The argument <i>psa</i> is not valid.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_UNEXPECTED</b></dt> </dl> </td> <td width="60%"> The array could
///    not be locked. </td> </tr> </table>
///    
@DllImport("OLEAUT32")
HRESULT SafeArrayAccessData(SAFEARRAY* psa, void** ppvData);

///Decrements the lock count of an array, and invalidates the pointer retrieved by SafeArrayAccessData.
///Params:
///    psa = An array descriptor created by SafeArrayCreate.
@DllImport("OLEAUT32")
HRESULT SafeArrayUnaccessData(SAFEARRAY* psa);

///Retrieves a single element of the array.
///Params:
///    psa = An array descriptor created by SafeArrayCreate.
///    rgIndices = A vector of indexes for each dimension of the array. The right-most (least significant) dimension is
///                rgIndices[0]. The left-most dimension is stored at <code>rgIndices[psa-&gt;cDims – 1]</code>.
///    pv = The element of the array.
///Returns:
///    This function can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>DISP_E_BADINDEX</b></dt> </dl> </td> <td width="60%"> The specified index is not valid.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One of the
///    arguments is not valid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td
///    width="60%"> Memory could not be allocated for the element. </td> </tr> </table>
///    
@DllImport("OLEAUT32")
HRESULT SafeArrayGetElement(SAFEARRAY* psa, char* rgIndices, void* pv);

///Stores the data element at the specified location in the array.
///Params:
///    psa = An array descriptor created by SafeArrayCreate.
///    rgIndices = A vector of indexes for each dimension of the array. The right-most (least significant) dimension is
///                rgIndices[0]. The left-most dimension is stored at <code>rgIndices[psa-&gt;cDims – 1]</code>.
///    pv = The data to assign to the array. The variant types VT_DISPATCH, VT_UNKNOWN, and VT_BSTR are pointers, and do not
///         require another level of indirection.
///Returns:
///    This function can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>DISP_E_BADINDEX</b></dt> </dl> </td> <td width="60%"> The specified index is not valid.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One of the
///    arguments is not valid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td
///    width="60%"> Memory could not be allocated for the element. </td> </tr> </table>
///    
@DllImport("OLEAUT32")
HRESULT SafeArrayPutElement(SAFEARRAY* psa, char* rgIndices, void* pv);

///Creates a copy of an existing safe array.
///Params:
///    psa = A safe array descriptor created by SafeArrayCreate.
///    ppsaOut = The safe array descriptor.
///Returns:
///    This function can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The argument <i>psa</i> was not
///    valid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%">
///    Insufficient memory to complete the operation. </td> </tr> </table>
///    
@DllImport("OLEAUT32")
HRESULT SafeArrayCopy(SAFEARRAY* psa, SAFEARRAY** ppsaOut);

///Gets a pointer to an array element.
///Params:
///    psa = An array descriptor created by SafeArrayCreate.
///    rgIndices = An array of index values that identify an element of the array. All indexes for the element must be specified.
///    ppvData = The array element.
///Returns:
///    This function can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>DISP_E_BADINDEX</b></dt> </dl> </td> <td width="60%"> The specified index is not valid.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One of the
///    arguments is not valid. </td> </tr> </table>
///    
@DllImport("OLEAUT32")
HRESULT SafeArrayPtrOfIndex(SAFEARRAY* psa, char* rgIndices, void** ppvData);

///Sets the record info in the specified safe array.
///Params:
///    psa = The array descriptor.
///    prinfo = The record info.
///Returns:
///    This function can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The argument <i>psa</i> is null or
///    the array descriptor does not have the FADF_RECORD flag set. </td> </tr> </table>
///    
@DllImport("OLEAUT32")
HRESULT SafeArraySetRecordInfo(SAFEARRAY* psa, IRecordInfo prinfo);

///Retrieves the IRecordInfo interface of the UDT contained in the specified safe array.
///Params:
///    psa = An array descriptor created by SafeArrayCreate.
///    prinfo = The IRecordInfo interface.
@DllImport("OLEAUT32")
HRESULT SafeArrayGetRecordInfo(SAFEARRAY* psa, IRecordInfo* prinfo);

///Sets the GUID of the interface for the specified safe array.
///Params:
///    psa = The safe array descriptor.
///    guid = The IID.
@DllImport("OLEAUT32")
HRESULT SafeArraySetIID(SAFEARRAY* psa, const(GUID)* guid);

///Gets the GUID of the interface contained within the specified safe array.
///Params:
///    psa = An array descriptor created by SafeArrayCreate.
///    pguid = The GUID of the interface.
@DllImport("OLEAUT32")
HRESULT SafeArrayGetIID(SAFEARRAY* psa, GUID* pguid);

///Gets the VARTYPE stored in the specified safe array.
///Params:
///    psa = An array descriptor created by SafeArrayCreate.
///    pvt = The VARTYPE.
///Returns:
///    This function can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One of the arguments is not valid.
///    </td> </tr> </table>
///    
@DllImport("OLEAUT32")
HRESULT SafeArrayGetVartype(SAFEARRAY* psa, ushort* pvt);

///Creates a one-dimensional array. A safe array created with <b>SafeArrayCreateVector</b> is a fixed size, so the
///constant FADF_FIXEDSIZE is always set.
///Params:
///    vt = The base type of the array (the VARTYPE of each element of the array). The VARTYPE is restricted to a subset of
///         the variant types. Neither the VT_ARRAY nor the VT_BYREF flag can be set. VT_EMPTY and VT_NULL are not valid base
///         types for the array. All other types are legal.
///    lLbound = The lower bound for the array. This parameter can be negative.
///    cElements = The number of elements in the array.
///Returns:
///    A safe array descriptor, or null if the array could not be created.
///    
@DllImport("OLEAUT32")
SAFEARRAY* SafeArrayCreateVector(ushort vt, int lLbound, uint cElements);

///Creates and returns a one-dimensional safe array of the specified VARTYPE and bounds.
///Params:
///    vt = The base type of the array (the VARTYPE of each element of the array). The FADF_RECORD flag can be set for
///         VT_RECORD. The FADF_HAVEIID can be set for VT_DISPATCH or VT_UNKNOWN and FADF_HAVEVARTYPE can be set for all
///         other types.
///    lLbound = The lower bound for the array. This parameter can be negative.
///    cElements = The number of elements in the array.
///    pvExtra = The type information of the user-defined type, if you are creating a safe array of user-defined types. If the vt
///              parameter is VT_RECORD, then <i>pvExtra</i> will be a pointer to an IRecordInfo describing the record. If the
///              <i>vt</i> parameter is VT_DISPATCH or VT_UNKNOWN, then <i>pvExtra</i> will contain a pointer to a GUID
///              representing the type of interface being passed to the array.
@DllImport("OLEAUT32")
SAFEARRAY* SafeArrayCreateVectorEx(ushort vt, int lLbound, uint cElements, void* pvExtra);

///Initializes a variant.
///Params:
///    pvarg = The variant to initialize.
@DllImport("OLEAUT32")
void VariantInit(VARIANT* pvarg);

///Clears a variant.
///Params:
///    pvarg = The variant to clear.
///Returns:
///    This function can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>DISP_E_ARRAYISLOCKED</b></dt> </dl> </td> <td width="60%"> The variant contains an array
///    that is locked. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>DISP_E_BADVARTYPE</b></dt> </dl> </td> <td
///    width="60%"> The variant type is not a valid type of variant. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>E_INVALIDARG </b></dt> </dl> </td> <td width="60%"> One of the arguments is not valid. </td> </tr>
///    </table>
///    
@DllImport("OLEAUT32")
HRESULT VariantClear(VARIANT* pvarg);

///Frees the destination variant and makes a copy of the source variant.
///Params:
///    pvargDest = The destination variant.
///    pvargSrc = The source variant.
///Returns:
///    This function can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>DISP_E_ARRAYISLOCKED</b></dt> </dl> </td> <td width="60%"> The variant contains an array
///    that is locked. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>DISP_E_BADVARTYPE</b></dt> </dl> </td> <td
///    width="60%"> The variant type is not a valid type of variant. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>E_INVALIDARG </b></dt> </dl> </td> <td width="60%"> One of the arguments is not valid. </td> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY </b></dt> </dl> </td> <td width="60%"> Insufficient memory to complete
///    the operation. </td> </tr> </table>
///    
@DllImport("OLEAUT32")
HRESULT VariantCopy(VARIANT* pvargDest, const(VARIANT)* pvargSrc);

///Frees the destination variant and makes a copy of the source variant, performing the necessary indirection if the
///source is specified to be VT_BYREF.
///Params:
///    pvarDest = The destination variant.
///    pvargSrc = The source variant.
///Returns:
///    This function can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>DISP_E_ARRAYISLOCKED</b></dt> </dl> </td> <td width="60%"> The variant contains an array
///    that is locked. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>DISP_E_BADVARTYPE</b></dt> </dl> </td> <td
///    width="60%"> The variant type is not a valid type of variant. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>E_INVALIDARG </b></dt> </dl> </td> <td width="60%"> One of the arguments is not valid. </td> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY </b></dt> </dl> </td> <td width="60%"> Insufficient memory to complete
///    the operation. </td> </tr> </table>
///    
@DllImport("OLEAUT32")
HRESULT VariantCopyInd(VARIANT* pvarDest, const(VARIANT)* pvargSrc);

///> [!IMPORTANT] > This API is affected by the problem described in Microsoft Support topic [VarI8FromCy produces
///incorrect value when CY value is very large](https://support.microsoft.com/help/2282810). Converts a variant from one
///type to another.
///Params:
///    pvargDest = The destination variant. If this is the same as <i>pvarSrc</i>, the variant will be converted in place.
///    pvarSrc = The variant to convert.
///    wFlags = Flags. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="VARIANT_NOVALUEPROP"></a><a
///             id="variant_novalueprop"></a><dl> <dt><b>VARIANT_NOVALUEPROP</b></dt> </dl> </td> <td width="60%"> Prevents the
///             function from attempting to coerce an object to a fundamental type by getting the Value property. Applications
///             should set this flag only if necessary, because it makes their behavior inconsistent with other applications.
///             </td> </tr> <tr> <td width="40%"><a id="VARIANT_ALPHABOOL"></a><a id="variant_alphabool"></a><dl>
///             <dt><b>VARIANT_ALPHABOOL</b></dt> </dl> </td> <td width="60%"> Converts a VT_BOOL value to a string containing
///             either "True" or "False". </td> </tr> <tr> <td width="40%"><a id="VARIANT_NOUSEROVERRIDE"></a><a
///             id="variant_nouseroverride"></a><dl> <dt><b>VARIANT_NOUSEROVERRIDE</b></dt> </dl> </td> <td width="60%"> For
///             conversions to or from VT_BSTR, passes LOCALE_NOUSEROVERRIDE to the core coercion routines. </td> </tr> <tr> <td
///             width="40%"><a id="VARIANT_LOCALBOOL"></a><a id="variant_localbool"></a><dl> <dt><b>VARIANT_LOCALBOOL</b></dt>
///             </dl> </td> <td width="60%"> For conversions from VT_BOOL to VT_BSTR and back, uses the language specified by the
///             locale in use on the local computer. </td> </tr> </table>
///    vt = The type to convert to. If the return code is S_OK, the <b>vt</b> field of the *<i>pvargDest</i> is guaranteed to
///         be equal to this value.
///Returns:
///    This function can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>DISP_E_BADVARTYPE</b></dt> </dl> </td> <td width="60%"> The variant type is not a valid
///    type of variant. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>DISP_E_OVERFLOW</b></dt> </dl> </td> <td
///    width="60%"> The data pointed to by <i>pvarSrc</i> does not fit in the destination type. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>DISP_E_TYPEMISMATCH</b></dt> </dl> </td> <td width="60%"> The argument could not be
///    coerced to the specified type. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG </b></dt> </dl> </td>
///    <td width="60%"> One of the arguments is not valid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY
///    </b></dt> </dl> </td> <td width="60%"> Insufficient memory to complete the operation. </td> </tr> </table>
///    
@DllImport("OLEAUT32")
HRESULT VariantChangeType(VARIANT* pvargDest, const(VARIANT)* pvarSrc, ushort wFlags, ushort vt);

///> [!IMPORTANT] > This API is affected by the problem described in Microsoft Support topic [VarI8FromCy produces
///incorrect value when CY value is very large](https://support.microsoft.com/help/2282810). Converts a variant from one
///type to another, using an LCID.
///Params:
///    pvargDest = The destination variant. If this is the same as <i>pvarSrc</i>, the variant will be converted in place.
///    pvarSrc = The variant to convert.
///    lcid = The locale identifier. The LCID is useful when the type of the source or destination VARIANTARG is VT_BSTR,
///           VT_DISPATCH, or VT_DATE.
///    wFlags = Flags. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="VARIANT_NOVALUEPROP"></a><a
///             id="variant_novalueprop"></a><dl> <dt><b>VARIANT_NOVALUEPROP</b></dt> </dl> </td> <td width="60%"> Prevents the
///             function from attempting to coerce an object to a fundamental type by getting the Value property. Applications
///             should set this flag only if necessary, because it makes their behavior inconsistent with other applications.
///             </td> </tr> <tr> <td width="40%"><a id="VARIANT_ALPHABOOL"></a><a id="variant_alphabool"></a><dl>
///             <dt><b>VARIANT_ALPHABOOL</b></dt> </dl> </td> <td width="60%"> Converts a VT_BOOL value to a string containing
///             either "True" or "False". </td> </tr> <tr> <td width="40%"><a id="VARIANT_NOUSEROVERRIDE"></a><a
///             id="variant_nouseroverride"></a><dl> <dt><b>VARIANT_NOUSEROVERRIDE</b></dt> </dl> </td> <td width="60%"> For
///             conversions to or from VT_BSTR, passes LOCALE_NOUSEROVERRIDE to the core coercion routines. </td> </tr> <tr> <td
///             width="40%"><a id="VARIANT_LOCALBOOL"></a><a id="variant_localbool"></a><dl> <dt><b>VARIANT_LOCALBOOL</b></dt>
///             </dl> </td> <td width="60%"> For conversions from VT_BOOL to VT_BSTR and back, uses the language specified by the
///             locale in use on the local computer. </td> </tr> </table>
///    vt = The type to convert to. If the return code is S_OK, the <b>vt</b> field of the *<i>pvargDest</i> is guaranteed to
///         be equal to this value.
///Returns:
///    This function can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>DISP_E_BADVARTYPE</b></dt> </dl> </td> <td width="60%"> The variant type is not a valid
///    type of variant. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>DISP_E_OVERFLOW</b></dt> </dl> </td> <td
///    width="60%"> The data pointed to by <i>pvarSrc</i> does not fit in the destination type. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>DISP_E_TYPEMISMATCH</b></dt> </dl> </td> <td width="60%"> The argument could not be
///    coerced to the specified type. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG </b></dt> </dl> </td>
///    <td width="60%"> One of the arguments is not valid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY
///    </b></dt> </dl> </td> <td width="60%"> Insufficient memory to complete the operation. </td> </tr> </table>
///    
@DllImport("OLEAUT32")
HRESULT VariantChangeTypeEx(VARIANT* pvargDest, const(VARIANT)* pvarSrc, uint lcid, ushort wFlags, ushort vt);

///Returns a vector, assigning each character in the BSTR to an element of the vector.
///Params:
///    bstr = The BSTR to be converted to a vector.
///    ppsa = A one-dimensional safearray containing the characters in the BSTR.
@DllImport("OLEAUT32")
HRESULT VectorFromBstr(BSTR bstr, SAFEARRAY** ppsa);

///Returns a BSTR, assigning each element of the vector to a character in the BSTR.
///Params:
///    psa = The vector to be converted to a BSTR.
///    pbstr = A BSTR, each character of which is assigned to an element from the vector.
@DllImport("OLEAUT32")
HRESULT BstrFromVector(SAFEARRAY* psa, BSTR* pbstr);

///Converts a short value to an unsigned char value.
///Params:
///    sIn = The value to convert.
///    pbOut = The resulting value.
@DllImport("OLEAUT32")
HRESULT VarUI1FromI2(short sIn, ubyte* pbOut);

///Converts a long value to an unsigned char value.
///Params:
///    lIn = The value to convert.
///    pbOut = The resulting value.
@DllImport("OLEAUT32")
HRESULT VarUI1FromI4(int lIn, ubyte* pbOut);

///Converts an 8-byte integer value to a byte value.
///Params:
///    i64In = The value to convert.
///    pbOut = The resulting value.
@DllImport("OLEAUT32")
HRESULT VarUI1FromI8(long i64In, ubyte* pbOut);

///Converts a float value to an unsigned char value.
///Params:
///    fltIn = The value to convert.
///    pbOut = The resulting value.
@DllImport("OLEAUT32")
HRESULT VarUI1FromR4(float fltIn, ubyte* pbOut);

///Converts a double value to an unsigned char value.
///Params:
///    dblIn = The value to convert.
///    pbOut = The resulting value.
@DllImport("OLEAUT32")
HRESULT VarUI1FromR8(double dblIn, ubyte* pbOut);

///Converts a currency value to an unsigned char value.
///Params:
///    cyIn = The value to convert.
///    pbOut = The resulting value.
@DllImport("OLEAUT32")
HRESULT VarUI1FromCy(CY cyIn, ubyte* pbOut);

///Converts a date value to an unsigned char value.
///Params:
///    dateIn = The value to convert.
///    pbOut = The resulting value.
@DllImport("OLEAUT32")
HRESULT VarUI1FromDate(double dateIn, ubyte* pbOut);

///Converts an OLECHAR string to an unsigned char string.
///Params:
///    strIn = The value to convert.
///    lcid = The locale identifier.
///    dwFlags = One or more of the following flags. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
///              id="LOCALE_NOUSEROVERRIDE"></a><a id="locale_nouseroverride"></a><dl> <dt><b>LOCALE_NOUSEROVERRIDE</b></dt> </dl>
///              </td> <td width="60%"> Uses the system default locale settings, rather than custom locale settings. </td> </tr>
///              </table>
///    pbOut = The resulting value.
@DllImport("OLEAUT32")
HRESULT VarUI1FromStr(ushort* strIn, uint lcid, uint dwFlags, ubyte* pbOut);

///Converts the default property of an IDispatch instance to an unsigned char value.
///Params:
///    pdispIn = The value to convert.
///    lcid = The locale identifier.
///    pbOut = The resulting value.
@DllImport("OLEAUT32")
HRESULT VarUI1FromDisp(IDispatch pdispIn, uint lcid, ubyte* pbOut);

///Converts a Boolean value to an unsigned char value.
///Params:
///    boolIn = The value to convert.
///    pbOut = The resulting value.
@DllImport("OLEAUT32")
HRESULT VarUI1FromBool(short boolIn, ubyte* pbOut);

///Converts a char value to an unsigned char value.
///Params:
///    cIn = The value to convert.
///    pbOut = The resulting value.
@DllImport("OLEAUT32")
HRESULT VarUI1FromI1(byte cIn, ubyte* pbOut);

///Converts an unsigned short value to an unsigned char value.
///Params:
///    uiIn = The value to convert.
///    pbOut = The resulting value.
@DllImport("OLEAUT32")
HRESULT VarUI1FromUI2(ushort uiIn, ubyte* pbOut);

///Converts an unsigned long value to an unsigned char value.
///Params:
///    ulIn = The value to convert.
///    pbOut = The resulting value.
@DllImport("OLEAUT32")
HRESULT VarUI1FromUI4(uint ulIn, ubyte* pbOut);

///Converts an 8-byte unsigned integer value to a byte value.
///Params:
///    ui64In = The value to convert.
///    pbOut = The resulting value.
@DllImport("OLEAUT32")
HRESULT VarUI1FromUI8(ulong ui64In, ubyte* pbOut);

///Converts a decimal value to an unsigned char value.
///Params:
///    pdecIn = The value to convert.
///    pbOut = The resulting value.
@DllImport("OLEAUT32")
HRESULT VarUI1FromDec(const(DECIMAL)* pdecIn, ubyte* pbOut);

///Converts an unsigned char value to a short value.
///Params:
///    bIn = The value to convert.
///    psOut = The resulting value.
@DllImport("OLEAUT32")
HRESULT VarI2FromUI1(ubyte bIn, short* psOut);

///Converts a long value to a short value.
///Params:
///    lIn = The value to convert.
///    psOut = The resulting value.
@DllImport("OLEAUT32")
HRESULT VarI2FromI4(int lIn, short* psOut);

///Converts an 8-byte integer value to a short value.
///Params:
///    i64In = The value to convert.
///    psOut = The resulting value.
@DllImport("OLEAUT32")
HRESULT VarI2FromI8(long i64In, short* psOut);

///Converts a float value to a short value.
///Params:
///    fltIn = The value to convert.
///    psOut = The resulting value.
@DllImport("OLEAUT32")
HRESULT VarI2FromR4(float fltIn, short* psOut);

///Converts a double value to a short value.
///Params:
///    dblIn = The value to convert.
///    psOut = The resulting value.
@DllImport("OLEAUT32")
HRESULT VarI2FromR8(double dblIn, short* psOut);

///Converts a currency value to a short value.
///Params:
///    cyIn = The value to convert.
///    psOut = The resulting value.
@DllImport("OLEAUT32")
HRESULT VarI2FromCy(CY cyIn, short* psOut);

///Converts a date value to a short value.
///Params:
///    dateIn = The value to convert.
///    psOut = The resulting value.
@DllImport("OLEAUT32")
HRESULT VarI2FromDate(double dateIn, short* psOut);

///Converts an OLECHAR string to a short value.
///Params:
///    strIn = The value to convert.
///    lcid = The locale identifier.
///    dwFlags = One or more of the following flags. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
///              id="LOCALE_NOUSEROVERRIDE"></a><a id="locale_nouseroverride"></a><dl> <dt><b>LOCALE_NOUSEROVERRIDE</b></dt> </dl>
///              </td> <td width="60%"> Uses the system default locale settings, rather than custom locale settings. </td> </tr>
///              <tr> <td width="40%"><a id="VAR_TIMEVALUEONLY"></a><a id="var_timevalueonly"></a><dl>
///              <dt><b>VAR_TIMEVALUEONLY</b></dt> </dl> </td> <td width="60%"> Omits the date portion of a VT_DATE and returns
///              only the time. Applies to conversions to or from dates. </td> </tr> <tr> <td width="40%"><a
///              id="VAR_DATEVALUEONLY"></a><a id="var_datevalueonly"></a><dl> <dt><b>VAR_DATEVALUEONLY</b></dt> </dl> </td> <td
///              width="60%"> Omits the time portion of a VT_DATE and returns only the date. Applies to conversions to or from
///              dates. </td> </tr> </table>
///    psOut = The resulting value.
@DllImport("OLEAUT32")
HRESULT VarI2FromStr(ushort* strIn, uint lcid, uint dwFlags, short* psOut);

///Converts the default property of an IDispatch instance to a short value.
///Params:
///    pdispIn = The value to convert.
///    lcid = The locale identifier.
///    psOut = The resulting value.
@DllImport("OLEAUT32")
HRESULT VarI2FromDisp(IDispatch pdispIn, uint lcid, short* psOut);

///Converts a Boolean value to a short value.
///Params:
///    boolIn = The value to convert.
///    psOut = The resulting value.
@DllImport("OLEAUT32")
HRESULT VarI2FromBool(short boolIn, short* psOut);

///Converts a char value to a short value.
///Params:
///    cIn = The value to convert.
///    psOut = The resulting value.
@DllImport("OLEAUT32")
HRESULT VarI2FromI1(byte cIn, short* psOut);

///Converts an unsigned short value to a short value.
///Params:
///    uiIn = The value to convert.
///    psOut = The resulting value.
@DllImport("OLEAUT32")
HRESULT VarI2FromUI2(ushort uiIn, short* psOut);

///Converts an unsigned long value to a short value.
///Params:
///    ulIn = The value to convert.
///    psOut = The resulting value.
@DllImport("OLEAUT32")
HRESULT VarI2FromUI4(uint ulIn, short* psOut);

///Converts an 8-byte unsigned integer value to a short value.
///Params:
///    ui64In = The value to convert.
///    psOut = The resulting value.
@DllImport("OLEAUT32")
HRESULT VarI2FromUI8(ulong ui64In, short* psOut);

///Converts a decimal value to a short value.
///Params:
///    pdecIn = The value to convert.
///    psOut = The resulting value.
@DllImport("OLEAUT32")
HRESULT VarI2FromDec(const(DECIMAL)* pdecIn, short* psOut);

///Converts an unsigned char value to a long value.
///Params:
///    bIn = The value to convert.
///    plOut = The resulting value.
@DllImport("OLEAUT32")
HRESULT VarI4FromUI1(ubyte bIn, int* plOut);

///Converts a short value to a long value.
///Params:
///    sIn = The value to convert.
///    plOut = The resulting value.
@DllImport("OLEAUT32")
HRESULT VarI4FromI2(short sIn, int* plOut);

///Converts an 8-byte integer value to a long value.
///Params:
///    i64In = The value to convert.
///    plOut = The resulting value.
@DllImport("OLEAUT32")
HRESULT VarI4FromI8(long i64In, int* plOut);

///Converts a float value to a long value.
///Params:
///    fltIn = The value to convert.
///    plOut = The resulting value.
@DllImport("OLEAUT32")
HRESULT VarI4FromR4(float fltIn, int* plOut);

///Converts a double value to a long value.
///Params:
///    dblIn = The value to convert.
///    plOut = The resulting value.
@DllImport("OLEAUT32")
HRESULT VarI4FromR8(double dblIn, int* plOut);

///Converts a currency value to a long value.
///Params:
///    cyIn = The value to convert.
///    plOut = The resulting value.
@DllImport("OLEAUT32")
HRESULT VarI4FromCy(CY cyIn, int* plOut);

///Converts a date value to a long value.
///Params:
///    dateIn = The value to convert.
///    plOut = The resulting value.
@DllImport("OLEAUT32")
HRESULT VarI4FromDate(double dateIn, int* plOut);

///Converts an OLECHAR string to a long value.
///Params:
///    strIn = The value to convert.
///    lcid = The locale identifier.
///    dwFlags = One or more of the following flags. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
///              id="LOCALE_NOUSEROVERRIDE"></a><a id="locale_nouseroverride"></a><dl> <dt><b>LOCALE_NOUSEROVERRIDE</b></dt> </dl>
///              </td> <td width="60%"> Uses the system default locale settings, rather than custom locale settings. </td> </tr>
///              <tr> <td width="40%"><a id="VAR_TIMEVALUEONLY"></a><a id="var_timevalueonly"></a><dl>
///              <dt><b>VAR_TIMEVALUEONLY</b></dt> </dl> </td> <td width="60%"> Omits the date portion of a VT_DATE and returns
///              only the time. Applies to conversions to or from dates. </td> </tr> <tr> <td width="40%"><a
///              id="VAR_DATEVALUEONLY"></a><a id="var_datevalueonly"></a><dl> <dt><b>VAR_DATEVALUEONLY</b></dt> </dl> </td> <td
///              width="60%"> Omits the time portion of a VT_DATE and returns only the date. Applies to conversions to or from
///              dates. </td> </tr> </table>
///    plOut = The resulting value.
@DllImport("OLEAUT32")
HRESULT VarI4FromStr(ushort* strIn, uint lcid, uint dwFlags, int* plOut);

///Converts the default property of an IDispatch instance to a long value.
///Params:
///    pdispIn = The value to convert.
///    lcid = The locale identifier.
///    plOut = The resulting value.
@DllImport("OLEAUT32")
HRESULT VarI4FromDisp(IDispatch pdispIn, uint lcid, int* plOut);

///Converts a Boolean value to a long value.
///Params:
///    boolIn = The value to convert.
///    plOut = The resulting value.
@DllImport("OLEAUT32")
HRESULT VarI4FromBool(short boolIn, int* plOut);

///Converts a char value to a long value.
///Params:
///    cIn = The value to convert.
///    plOut = The resulting value.
@DllImport("OLEAUT32")
HRESULT VarI4FromI1(byte cIn, int* plOut);

///Converts an unsigned short value to a long value.
///Params:
///    uiIn = The value to convert.
///    plOut = The resulting value.
@DllImport("OLEAUT32")
HRESULT VarI4FromUI2(ushort uiIn, int* plOut);

///Converts an unsigned long value to a long value.
///Params:
///    ulIn = The value to convert.
///    plOut = The resulting value.
@DllImport("OLEAUT32")
HRESULT VarI4FromUI4(uint ulIn, int* plOut);

///Converts an 8-byte unsigned integer value to a long.
///Params:
///    ui64In = The value to convert.
///    plOut = The resulting value.
@DllImport("OLEAUT32")
HRESULT VarI4FromUI8(ulong ui64In, int* plOut);

///Converts a decimal value to a long value.
///Params:
///    pdecIn = The value to convert.
///    plOut = The resulting value.
@DllImport("OLEAUT32")
HRESULT VarI4FromDec(const(DECIMAL)* pdecIn, int* plOut);

///Converts an unsigned byte value to an 8-byte integer value.
///Params:
///    bIn = The value to convert.
///    pi64Out = The resulting value.
@DllImport("OLEAUT32")
HRESULT VarI8FromUI1(ubyte bIn, long* pi64Out);

///Converts a short value to an 8-byte integer value.
///Params:
///    sIn = The value to convert.
///    pi64Out = The resulting value.
@DllImport("OLEAUT32")
HRESULT VarI8FromI2(short sIn, long* pi64Out);

///Converts a float value to an 8-byte integer value.
///Params:
///    fltIn = The value to convert.
///    pi64Out = The resulting value.
@DllImport("OLEAUT32")
HRESULT VarI8FromR4(float fltIn, long* pi64Out);

///Converts a double value to an 8-byte integer value.
///Params:
///    dblIn = The value to convert.
///    pi64Out = The resulting value.
@DllImport("OLEAUT32")
HRESULT VarI8FromR8(double dblIn, long* pi64Out);

///> [!IMPORTANT] > This API is affected by the problem described in Microsoft Support topic [VarI8FromCy produces
///incorrect value when CY value is very large](https://support.microsoft.com/help/2282810). Converts a currency value
///to an 8-byte integer value.
///Params:
///    cyIn = The value to convert.
///    pi64Out = The resulting value.
@DllImport("OLEAUT32")
HRESULT VarI8FromCy(CY cyIn, long* pi64Out);

///Converts a date value to an 8-byte integer value.
///Params:
///    dateIn = The value to convert.
///    pi64Out = The resulting value.
@DllImport("OLEAUT32")
HRESULT VarI8FromDate(double dateIn, long* pi64Out);

///Converts an OLECHAR string to an 8-byte integer value.
///Params:
///    strIn = The value to convert.
///    lcid = The locale identifier.
///    dwFlags = One or more of the following flags. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
///              id="LOCALE_NOUSEROVERRIDE"></a><a id="locale_nouseroverride"></a><dl> <dt><b>LOCALE_NOUSEROVERRIDE</b></dt> </dl>
///              </td> <td width="60%"> Uses the system default locale settings, rather than custom locale settings. </td> </tr>
///              </table>
///    pi64Out = The resulting value.
@DllImport("OLEAUT32")
HRESULT VarI8FromStr(ushort* strIn, uint lcid, uint dwFlags, long* pi64Out);

///Converts the default property of an IDispatch instance to an 8-byte integer value.
///Params:
///    pdispIn = The value to convert.
///    lcid = The locale identifier.
///    pi64Out = The resulting value.
@DllImport("OLEAUT32")
HRESULT VarI8FromDisp(IDispatch pdispIn, uint lcid, long* pi64Out);

///Converts a Boolean value to an 8-byte integer value.
///Params:
///    boolIn = The value to convert.
///    pi64Out = The resulting value.
@DllImport("OLEAUT32")
HRESULT VarI8FromBool(short boolIn, long* pi64Out);

///Converts a char value to an 8-byte integer value.
///Params:
///    cIn = The value to convert.
///    pi64Out = The resulting value.
@DllImport("OLEAUT32")
HRESULT VarI8FromI1(byte cIn, long* pi64Out);

///Converts an unsigned short value to an 8-byte integer value.
///Params:
///    uiIn = The value to convert.
///    pi64Out = The resulting value.
@DllImport("OLEAUT32")
HRESULT VarI8FromUI2(ushort uiIn, long* pi64Out);

///Converts an unsigned long value to an 8-byte integer value.
///Params:
///    ulIn = The value to convert.
///    pi64Out = The resulting value.
@DllImport("OLEAUT32")
HRESULT VarI8FromUI4(uint ulIn, long* pi64Out);

///Converts an unsigned 8-byte integer value to an 8-byte integer value.
///Params:
///    ui64In = The value to convert.
///    pi64Out = The resulting value.
@DllImport("OLEAUT32")
HRESULT VarI8FromUI8(ulong ui64In, long* pi64Out);

///Converts a decimal value to an 8-byte integer value.
///Params:
///    pdecIn = The value to convert.
///    pi64Out = The resulting value.
@DllImport("OLEAUT32")
HRESULT VarI8FromDec(const(DECIMAL)* pdecIn, long* pi64Out);

///Converts an unsigned char value to a float value.
///Params:
///    bIn = The value to convert.
///    pfltOut = The resulting value.
@DllImport("OLEAUT32")
HRESULT VarR4FromUI1(ubyte bIn, float* pfltOut);

///Converts a short value to a float value.
///Params:
///    sIn = The value to convert.
///    pfltOut = The resulting value.
@DllImport("OLEAUT32")
HRESULT VarR4FromI2(short sIn, float* pfltOut);

///Converts a long value to a float value.
///Params:
///    lIn = The value to convert.
///    pfltOut = The resulting value.
@DllImport("OLEAUT32")
HRESULT VarR4FromI4(int lIn, float* pfltOut);

///Converts an 8-byte integer value to a float value.
///Params:
///    i64In = The value to convert.
///    pfltOut = The resulting value.
@DllImport("OLEAUT32")
HRESULT VarR4FromI8(long i64In, float* pfltOut);

///Converts a double value to a float value.
///Params:
///    dblIn = The value to convert.
///    pfltOut = The resulting value.
@DllImport("OLEAUT32")
HRESULT VarR4FromR8(double dblIn, float* pfltOut);

///Converts a currency value to a float value.
///Params:
///    cyIn = The value to convert.
///    pfltOut = The resulting value.
@DllImport("OLEAUT32")
HRESULT VarR4FromCy(CY cyIn, float* pfltOut);

///Converts a date value to a float value.
///Params:
///    dateIn = The value to convert.
///    pfltOut = The resulting value.
@DllImport("OLEAUT32")
HRESULT VarR4FromDate(double dateIn, float* pfltOut);

///Converts an OLECHAR string to a float value.
///Params:
///    strIn = The value to convert.
///    lcid = The locale identifier.
///    dwFlags = One or more of the following flags. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
///              id="LOCALE_NOUSEROVERRIDE"></a><a id="locale_nouseroverride"></a><dl> <dt><b>LOCALE_NOUSEROVERRIDE</b></dt> </dl>
///              </td> <td width="60%"> Uses the system default locale settings, rather than custom locale settings. </td> </tr>
///              <tr> <td width="40%"><a id="VAR_TIMEVALUEONLY"></a><a id="var_timevalueonly"></a><dl>
///              <dt><b>VAR_TIMEVALUEONLY</b></dt> </dl> </td> <td width="60%"> Omits the date portion of a VT_DATE and returns
///              only the time. Applies to conversions to or from dates. </td> </tr> <tr> <td width="40%"><a
///              id="VAR_DATEVALUEONLY"></a><a id="var_datevalueonly"></a><dl> <dt><b>VAR_DATEVALUEONLY</b></dt> </dl> </td> <td
///              width="60%"> Omits the time portion of a VT_DATE and returns only the date. Applies to conversions to or from
///              dates. </td> </tr> </table>
///    pfltOut = The resulting value.
@DllImport("OLEAUT32")
HRESULT VarR4FromStr(ushort* strIn, uint lcid, uint dwFlags, float* pfltOut);

///Converts the default property of an IDispatch instance to a float value.
///Params:
///    pdispIn = The value to convert.
///    lcid = The locale identifier.
///    pfltOut = The resulting value.
@DllImport("OLEAUT32")
HRESULT VarR4FromDisp(IDispatch pdispIn, uint lcid, float* pfltOut);

///Converts a Boolean value to a float value.
///Params:
///    boolIn = The value to convert.
///    pfltOut = The resulting value.
@DllImport("OLEAUT32")
HRESULT VarR4FromBool(short boolIn, float* pfltOut);

///Converts a char value to a float value.
///Params:
///    cIn = The value to convert.
///    pfltOut = The resulting value.
@DllImport("OLEAUT32")
HRESULT VarR4FromI1(byte cIn, float* pfltOut);

///Converts an unsigned short value to a float value.
///Params:
///    uiIn = The value to convert.
///    pfltOut = The resulting value.
@DllImport("OLEAUT32")
HRESULT VarR4FromUI2(ushort uiIn, float* pfltOut);

///Converts an unsigned long value to a float value.
///Params:
///    ulIn = The value to convert.
///    pfltOut = The resulting value.
@DllImport("OLEAUT32")
HRESULT VarR4FromUI4(uint ulIn, float* pfltOut);

///Converts an unsigned 8-byte integer value to a float value.
///Params:
///    ui64In = The value to convert.
///    pfltOut = The resulting value.
@DllImport("OLEAUT32")
HRESULT VarR4FromUI8(ulong ui64In, float* pfltOut);

///Converts a decimal value to a float value.
///Params:
///    pdecIn = The value to convert.
///    pfltOut = The resulting value.
@DllImport("OLEAUT32")
HRESULT VarR4FromDec(const(DECIMAL)* pdecIn, float* pfltOut);

///Converts an unsigned char value to a double value.
///Params:
///    bIn = The value to convert.
///    pdblOut = The resulting value.
@DllImport("OLEAUT32")
HRESULT VarR8FromUI1(ubyte bIn, double* pdblOut);

///Converts a short value to a double value.
///Params:
///    sIn = The value to convert.
///    pdblOut = The resulting value.
@DllImport("OLEAUT32")
HRESULT VarR8FromI2(short sIn, double* pdblOut);

///Converts a long value to a double value.
///Params:
///    lIn = The value to convert.
///    pdblOut = The resulting value.
@DllImport("OLEAUT32")
HRESULT VarR8FromI4(int lIn, double* pdblOut);

///Converts an 8-byte integer value to a double value.
///Params:
///    i64In = The value to convert.
///    pdblOut = The resulting value.
@DllImport("OLEAUT32")
HRESULT VarR8FromI8(long i64In, double* pdblOut);

///Converts a float value to a double value.
///Params:
///    fltIn = The value to convert.
///    pdblOut = The resulting value.
@DllImport("OLEAUT32")
HRESULT VarR8FromR4(float fltIn, double* pdblOut);

///Converts a currency value to a double value.
///Params:
///    cyIn = The value to convert.
///    pdblOut = The resulting value.
@DllImport("OLEAUT32")
HRESULT VarR8FromCy(CY cyIn, double* pdblOut);

///Converts a date value to a double value.
///Params:
///    dateIn = The value to convert.
///    pdblOut = The resulting value.
@DllImport("OLEAUT32")
HRESULT VarR8FromDate(double dateIn, double* pdblOut);

///Converts an OLECHAR string to a double value.
///Params:
///    strIn = The value to convert.
///    lcid = The locale identifier.
///    dwFlags = One or more of the following flags. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
///              id="LOCALE_NOUSEROVERRIDE"></a><a id="locale_nouseroverride"></a><dl> <dt><b>LOCALE_NOUSEROVERRIDE</b></dt> </dl>
///              </td> <td width="60%"> Uses the system default locale settings, rather than custom locale settings. </td> </tr>
///              <tr> <td width="40%"><a id="VAR_TIMEVALUEONLY"></a><a id="var_timevalueonly"></a><dl>
///              <dt><b>VAR_TIMEVALUEONLY</b></dt> </dl> </td> <td width="60%"> Omits the date portion of a VT_DATE and returns
///              only the time. Applies to conversions to or from dates. </td> </tr> <tr> <td width="40%"><a
///              id="VAR_DATEVALUEONLY"></a><a id="var_datevalueonly"></a><dl> <dt><b>VAR_DATEVALUEONLY</b></dt> </dl> </td> <td
///              width="60%"> Omits the time portion of a VT_DATE and returns only the date. Applies to conversions to or from
///              dates. </td> </tr> </table>
///    pdblOut = The resulting value.
@DllImport("OLEAUT32")
HRESULT VarR8FromStr(ushort* strIn, uint lcid, uint dwFlags, double* pdblOut);

///Converts the default property of an IDispatch instance to a double value.
///Params:
///    pdispIn = The value to convert.
///    lcid = The locale identifier.
///    pdblOut = The resulting value.
@DllImport("OLEAUT32")
HRESULT VarR8FromDisp(IDispatch pdispIn, uint lcid, double* pdblOut);

///Converts a Boolean value to a double value.
///Params:
///    boolIn = The value to convert.
///    pdblOut = The resulting value.
@DllImport("OLEAUT32")
HRESULT VarR8FromBool(short boolIn, double* pdblOut);

///Converts a char value to a double value.
///Params:
///    cIn = The value to convert.
///    pdblOut = The resulting value.
@DllImport("OLEAUT32")
HRESULT VarR8FromI1(byte cIn, double* pdblOut);

///Converts an unsigned short value to a double value.
///Params:
///    uiIn = The value to convert.
///    pdblOut = The resulting value.
@DllImport("OLEAUT32")
HRESULT VarR8FromUI2(ushort uiIn, double* pdblOut);

///Converts an unsigned long value to a double value.
///Params:
///    ulIn = The value to convert.
///    pdblOut = The resulting value.
@DllImport("OLEAUT32")
HRESULT VarR8FromUI4(uint ulIn, double* pdblOut);

///Converts an 8-byte unsigned integer value to a double value.
///Params:
///    ui64In = The value to convert.
///    pdblOut = The resulting value.
@DllImport("OLEAUT32")
HRESULT VarR8FromUI8(ulong ui64In, double* pdblOut);

///Converts a decimal value to a double value.
///Params:
///    pdecIn = The value to convert.
///    pdblOut = The resulting value.
@DllImport("OLEAUT32")
HRESULT VarR8FromDec(const(DECIMAL)* pdecIn, double* pdblOut);

///Converts an unsigned char value to a date value.
///Params:
///    bIn = The value to convert.
///    pdateOut = The resulting value.
@DllImport("OLEAUT32")
HRESULT VarDateFromUI1(ubyte bIn, double* pdateOut);

///Converts a short value to a date value.
///Params:
///    sIn = The value to convert.
///    pdateOut = The resulting value.
@DllImport("OLEAUT32")
HRESULT VarDateFromI2(short sIn, double* pdateOut);

///Converts a long value to a date value.
///Params:
///    lIn = The value to convert.
///    pdateOut = The resulting value.
@DllImport("OLEAUT32")
HRESULT VarDateFromI4(int lIn, double* pdateOut);

///Converts an 8-byte unsigned integer value to a date value.
///Params:
///    i64In = The value to convert.
///    pdateOut = The resulting value.
@DllImport("OLEAUT32")
HRESULT VarDateFromI8(long i64In, double* pdateOut);

///Converts a float value to a date value.
///Params:
///    fltIn = The value to convert.
///    pdateOut = The resulting value.
@DllImport("OLEAUT32")
HRESULT VarDateFromR4(float fltIn, double* pdateOut);

///Converts a double value to a date value.
///Params:
///    dblIn = The value to convert.
///    pdateOut = The resulting value.
@DllImport("OLEAUT32")
HRESULT VarDateFromR8(double dblIn, double* pdateOut);

///Converts a currency value to a date value.
///Params:
///    cyIn = The value to convert.
///    pdateOut = The resulting value.
@DllImport("OLEAUT32")
HRESULT VarDateFromCy(CY cyIn, double* pdateOut);

///Converts an OLECHAR string to a date value.
///Params:
///    strIn = The value to convert.
///    lcid = The locale identifier.
///    dwFlags = One or more of the following flags. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
///              id="LOCALE_NOUSEROVERRIDE"></a><a id="locale_nouseroverride"></a><dl> <dt><b>LOCALE_NOUSEROVERRIDE</b></dt> </dl>
///              </td> <td width="60%"> Uses the system default locale settings, rather than custom locale settings. </td> </tr>
///              <tr> <td width="40%"><a id="VAR_CALENDAR_HIJRI"></a><a id="var_calendar_hijri"></a><dl>
///              <dt><b>VAR_CALENDAR_HIJRI</b></dt> </dl> </td> <td width="60%"> If set then the Hijri calendar is used. Otherwise
///              the calendar set in the control panel is used. </td> </tr> <tr> <td width="40%"><a id="VAR_TIMEVALUEONLY"></a><a
///              id="var_timevalueonly"></a><dl> <dt><b>VAR_TIMEVALUEONLY</b></dt> </dl> </td> <td width="60%"> Omits the date
///              portion of a VT_DATE and returns only the time. Applies to conversions to or from dates. </td> </tr> <tr> <td
///              width="40%"><a id="VAR_DATEVALUEONLY"></a><a id="var_datevalueonly"></a><dl> <dt><b>VAR_DATEVALUEONLY</b></dt>
///              </dl> </td> <td width="60%"> Omits the time portion of a VT_DATE and returns only the date. Applies to
///              conversions to or from dates. </td> </tr> </table>
///    pdateOut = The resulting value.
@DllImport("OLEAUT32")
HRESULT VarDateFromStr(ushort* strIn, uint lcid, uint dwFlags, double* pdateOut);

///Converts the default property of an IDispatch instance to a date value.
///Params:
///    pdispIn = The value to convert.
///    lcid = The locale identifier.
///    pdateOut = The resulting value.
@DllImport("OLEAUT32")
HRESULT VarDateFromDisp(IDispatch pdispIn, uint lcid, double* pdateOut);

///Converts a Boolean value to a date value.
///Params:
///    boolIn = The value to convert.
///    pdateOut = The resulting value.
@DllImport("OLEAUT32")
HRESULT VarDateFromBool(short boolIn, double* pdateOut);

///Converts a char value to a date value.
///Params:
///    cIn = The value to convert.
///    pdateOut = The resulting value.
@DllImport("OLEAUT32")
HRESULT VarDateFromI1(byte cIn, double* pdateOut);

///Converts an unsigned short value to a date value.
///Params:
///    uiIn = The value to convert.
///    pdateOut = The resulting value.
@DllImport("OLEAUT32")
HRESULT VarDateFromUI2(ushort uiIn, double* pdateOut);

///Converts an unsigned long value to a date value.
///Params:
///    ulIn = The value to convert.
///    pdateOut = The resulting value.
@DllImport("OLEAUT32")
HRESULT VarDateFromUI4(uint ulIn, double* pdateOut);

///Converts an 8-byte unsigned value to a date value.
///Params:
///    ui64In = The value to convert.
///    pdateOut = The resulting value.
@DllImport("OLEAUT32")
HRESULT VarDateFromUI8(ulong ui64In, double* pdateOut);

///Converts a decimal value to a date value.
///Params:
///    pdecIn = The value to convert.
///    pdateOut = The resulting value.
@DllImport("OLEAUT32")
HRESULT VarDateFromDec(const(DECIMAL)* pdecIn, double* pdateOut);

///Converts an unsigned char value to a currency value.
///Params:
///    bIn = The value to convert.
///    pcyOut = The resulting value.
@DllImport("OLEAUT32")
HRESULT VarCyFromUI1(ubyte bIn, CY* pcyOut);

///Converts a short value to a currency value.
///Params:
///    sIn = The value to convert.
///    pcyOut = The resulting value.
@DllImport("OLEAUT32")
HRESULT VarCyFromI2(short sIn, CY* pcyOut);

///Converts a long value to a currency value.
///Params:
///    lIn = The value to convert.
///    pcyOut = The resulting value.
@DllImport("OLEAUT32")
HRESULT VarCyFromI4(int lIn, CY* pcyOut);

///Converts an 8-byte integer value to a currency value.
///Params:
///    i64In = The value to convert.
///    pcyOut = The resulting value.
@DllImport("OLEAUT32")
HRESULT VarCyFromI8(long i64In, CY* pcyOut);

///Converts a float value to a currency value.
///Params:
///    fltIn = The value to convert.
///    pcyOut = The resulting value.
@DllImport("OLEAUT32")
HRESULT VarCyFromR4(float fltIn, CY* pcyOut);

///Converts a double value to a currency value.
///Params:
///    dblIn = The value to convert.
///    pcyOut = The resulting value.
@DllImport("OLEAUT32")
HRESULT VarCyFromR8(double dblIn, CY* pcyOut);

///Converts a date value to a currency value.
///Params:
///    dateIn = The value to convert.
///    pcyOut = The resulting value.
@DllImport("OLEAUT32")
HRESULT VarCyFromDate(double dateIn, CY* pcyOut);

///Converts an OLECHAR string to a currency value.
///Params:
///    strIn = The value to convert.
///    lcid = The locale identifier.
///    dwFlags = One of more of the following flags. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
///              id="LOCALE_NOUSEROVERRIDE"></a><a id="locale_nouseroverride"></a><dl> <dt><b>LOCALE_NOUSEROVERRIDE</b></dt> </dl>
///              </td> <td width="60%"> Uses the system default locale settings, rather than custom locale settings. </td> </tr>
///              <tr> <td width="40%"><a id="VAR_TIMEVALUEONLY"></a><a id="var_timevalueonly"></a><dl>
///              <dt><b>VAR_TIMEVALUEONLY</b></dt> </dl> </td> <td width="60%"> Omits the date portion of a VT_DATE and returns
///              only the time. Applies to conversions to or from dates. </td> </tr> <tr> <td width="40%"><a
///              id="VAR_DATEVALUEONLY"></a><a id="var_datevalueonly"></a><dl> <dt><b>VAR_DATEVALUEONLY</b></dt> </dl> </td> <td
///              width="60%"> Omits the time portion of a VT_DATE and returns only the date. Applies to conversions to or from
///              dates. </td> </tr> </table>
///    pcyOut = The resulting value.
@DllImport("OLEAUT32")
HRESULT VarCyFromStr(ushort* strIn, uint lcid, uint dwFlags, CY* pcyOut);

///Converts the default property of an IDispatch instance to a currency value.
///Params:
///    pdispIn = The value to convert.
///    lcid = The locale identifier.
///    pcyOut = The resulting value.
@DllImport("OLEAUT32")
HRESULT VarCyFromDisp(IDispatch pdispIn, uint lcid, CY* pcyOut);

///Converts a Boolean value to a currency value.
///Params:
///    boolIn = The value to convert.
///    pcyOut = The resulting value.
@DllImport("OLEAUT32")
HRESULT VarCyFromBool(short boolIn, CY* pcyOut);

///Converts a char value to a currency value.
///Params:
///    cIn = The value to convert.
///    pcyOut = The resulting value.
@DllImport("OLEAUT32")
HRESULT VarCyFromI1(byte cIn, CY* pcyOut);

///Converts an unsigned short value to a currency value.
///Params:
///    uiIn = The value to convert.
///    pcyOut = The resulting value.
@DllImport("OLEAUT32")
HRESULT VarCyFromUI2(ushort uiIn, CY* pcyOut);

///Converts an unsigned long value to a currency value.
///Params:
///    ulIn = The value to convert.
///    pcyOut = The resulting value.
@DllImport("OLEAUT32")
HRESULT VarCyFromUI4(uint ulIn, CY* pcyOut);

///Converts an 8-byte unsigned integer value to a currency value.
///Params:
///    ui64In = The value to convert.
///    pcyOut = The resulting value.
@DllImport("OLEAUT32")
HRESULT VarCyFromUI8(ulong ui64In, CY* pcyOut);

///Converts a decimal value to a currency value.
///Params:
///    pdecIn = The value to convert.
///    pcyOut = The resulting value.
@DllImport("OLEAUT32")
HRESULT VarCyFromDec(const(DECIMAL)* pdecIn, CY* pcyOut);

///Converts an unsigned char value to a BSTR value.
///Params:
///    bVal = The value to convert.
///    lcid = The locale identifier.
///    dwFlags = One or more of the following flags. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
///              id="LOCALE_NOUSEROVERRIDE"></a><a id="locale_nouseroverride"></a><dl> <dt><b>LOCALE_NOUSEROVERRIDE</b></dt> </dl>
///              </td> <td width="60%"> Uses the system default locale settings, rather than custom locale settings. </td> </tr>
///              </table>
///    pbstrOut = The resulting value.
@DllImport("OLEAUT32")
HRESULT VarBstrFromUI1(ubyte bVal, uint lcid, uint dwFlags, BSTR* pbstrOut);

///Converts a short value to a BSTR value.
///Params:
///    iVal = The value to convert.
///    lcid = The locale identifier.
///    dwFlags = Reserved. Set to zero.
///    pbstrOut = The resulting value.
@DllImport("OLEAUT32")
HRESULT VarBstrFromI2(short iVal, uint lcid, uint dwFlags, BSTR* pbstrOut);

///Converts a long value to a BSTR value.
///Params:
///    lIn = The value to convert.
///    lcid = The locale identifier.
///    dwFlags = Reserved. Set to zero.
///    pbstrOut = The resulting value.
@DllImport("OLEAUT32")
HRESULT VarBstrFromI4(int lIn, uint lcid, uint dwFlags, BSTR* pbstrOut);

///Converts an 8-byte unsigned integer value to a BSTR value.
///Params:
///    i64In = The value to convert.
///    lcid = The locale identifier.
///    dwFlags = Reserved. Set to zero.
///    pbstrOut = The resulting value.
@DllImport("OLEAUT32")
HRESULT VarBstrFromI8(long i64In, uint lcid, uint dwFlags, BSTR* pbstrOut);

///Converts a float value to a BSTR value.
///Params:
///    fltIn = The value to convert.
///    lcid = The locale identifier.
///    dwFlags = One or more of the following flags. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
///              id="LOCALE_NOUSEROVERRIDE"></a><a id="locale_nouseroverride"></a><dl> <dt><b>LOCALE_NOUSEROVERRIDE</b></dt> </dl>
///              </td> <td width="60%"> Uses the system default locale settings, rather than custom locale settings. </td> </tr>
///              </table>
///    pbstrOut = The resulting value.
@DllImport("OLEAUT32")
HRESULT VarBstrFromR4(float fltIn, uint lcid, uint dwFlags, BSTR* pbstrOut);

///Converts a double value to a BSTR value.
///Params:
///    dblIn = The value to convert.
///    lcid = The locale identifier.
///    dwFlags = One or more of the following flags. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
///              id="LOCALE_NOUSEROVERRIDE"></a><a id="locale_nouseroverride"></a><dl> <dt><b>LOCALE_NOUSEROVERRIDE</b></dt> </dl>
///              </td> <td width="60%"> Uses the system default locale settings, rather than custom locale settings. </td> </tr>
///              </table>
///    pbstrOut = The resulting value.
@DllImport("OLEAUT32")
HRESULT VarBstrFromR8(double dblIn, uint lcid, uint dwFlags, BSTR* pbstrOut);

///Converts a currency value to a BSTR value.
///Params:
///    cyIn = The value to convert.
///    lcid = The locale identifier.
///    dwFlags = One or more of the following flags. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
///              id="LOCALE_NOUSEROVERRIDE"></a><a id="locale_nouseroverride"></a><dl> <dt><b>LOCALE_NOUSEROVERRIDE</b></dt> </dl>
///              </td> <td width="60%"> Uses the system default locale settings, rather than custom locale settings. </td> </tr>
///              <tr> <td width="40%"><a id="LOCALE_USE_NLS"></a><a id="locale_use_nls"></a><dl> <dt><b>LOCALE_USE_NLS</b></dt>
///              </dl> </td> <td width="60%"> Uses NLS functions for currency conversions. </td> </tr> </table>
///    pbstrOut = The resulting value.
@DllImport("OLEAUT32")
HRESULT VarBstrFromCy(CY cyIn, uint lcid, uint dwFlags, BSTR* pbstrOut);

///Converts a date value to a BSTR value.
///Params:
///    dateIn = The value to convert.
///    lcid = The locale identifier.
///    dwFlags = One or more of the following flags. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
///              id="LOCALE_NOUSEROVERRIDE"></a><a id="locale_nouseroverride"></a><dl> <dt><b>LOCALE_NOUSEROVERRIDE</b></dt> </dl>
///              </td> <td width="60%"> Uses the system default locale settings, rather than custom locale settings. </td> </tr>
///              <tr> <td width="40%"><a id="VAR_CALENDAR_HIJRI"></a><a id="var_calendar_hijri"></a><dl>
///              <dt><b>VAR_CALENDAR_HIJRI</b></dt> </dl> </td> <td width="60%"> If set then the Hijri calendar is used. Otherwise
///              the calendar set in the control panel is used. </td> </tr> <tr> <td width="40%"><a id="VAR_CALENDAR_THAI"></a><a
///              id="var_calendar_thai"></a><dl> <dt><b>VAR_CALENDAR_THAI</b></dt> </dl> </td> <td width="60%"> If set then the
///              Buddhist year is used. </td> </tr> <tr> <td width="40%"><a id="VAR_CALENDAR_GREGORIAN"></a><a
///              id="var_calendar_gregorian"></a><dl> <dt><b>VAR_CALENDAR_GREGORIAN</b></dt> </dl> </td> <td width="60%"> If set
///              the Gregorian year is used. </td> </tr> <tr> <td width="40%"><a id="VAR_FOURDIGITYEARS"></a><a
///              id="var_fourdigityears"></a><dl> <dt><b>VAR_FOURDIGITYEARS</b></dt> </dl> </td> <td width="60%"> Use 4-digit
///              years instead of 2-digit years. </td> </tr> <tr> <td width="40%"><a id="VAR_TIMEVALUEONLY"></a><a
///              id="var_timevalueonly"></a><dl> <dt><b>VAR_TIMEVALUEONLY</b></dt> </dl> </td> <td width="60%"> Omits the date
///              portion of a VT_DATE and returns only the time. Applies to conversions to or from dates. </td> </tr> <tr> <td
///              width="40%"><a id="VAR_DATEVALUEONLY"></a><a id="var_datevalueonly"></a><dl> <dt><b>VAR_DATEVALUEONLY</b></dt>
///              </dl> </td> <td width="60%"> Omits the time portion of a VT_DATE and returns only the date. Applies to
///              conversions to or from dates. </td> </tr> </table>
///    pbstrOut = The resulting value.
@DllImport("OLEAUT32")
HRESULT VarBstrFromDate(double dateIn, uint lcid, uint dwFlags, BSTR* pbstrOut);

///Converts the default property of an IDispatch instance to a BSTR value.
///Params:
///    pdispIn = The value to convert.
///    lcid = The locale identifier.
///    dwFlags = Reserved. Set to zero.
///    pbstrOut = The resulting value.
@DllImport("OLEAUT32")
HRESULT VarBstrFromDisp(IDispatch pdispIn, uint lcid, uint dwFlags, BSTR* pbstrOut);

///Converts a Boolean value to a BSTR value.
///Params:
///    boolIn = The value to convert.
///    lcid = The locale identifier.
///    dwFlags = One or more of the following flags. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
///              id="LOCALE_NOUSEROVERRIDE"></a><a id="locale_nouseroverride"></a><dl> <dt><b>LOCALE_NOUSEROVERRIDE</b></dt> </dl>
///              </td> <td width="60%"> Uses the system default locale settings, rather than custom locale settings. </td> </tr>
///              <tr> <td width="40%"><a id="VAR_LOCALBOOL"></a><a id="var_localbool"></a><dl> <dt><b>VAR_LOCALBOOL</b></dt> </dl>
///              </td> <td width="60%"> Uses localized Boolean names. </td> </tr> </table>
///    pbstrOut = The resulting value.
@DllImport("OLEAUT32")
HRESULT VarBstrFromBool(short boolIn, uint lcid, uint dwFlags, BSTR* pbstrOut);

///Converts a char value to a BSTR value.
///Params:
///    cIn = The value to convert.
///    lcid = The locale identifier.
///    dwFlags = Reserved. Set to zero.
///    pbstrOut = The resulting value.
@DllImport("OLEAUT32")
HRESULT VarBstrFromI1(byte cIn, uint lcid, uint dwFlags, BSTR* pbstrOut);

///Converts an unsigned short value to a BSTR value.
///Params:
///    uiIn = The value to convert.
///    lcid = The locale identifier.
///    dwFlags = One or more of the following flags. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
///              id="LOCALE_NOUSEROVERRIDE"></a><a id="locale_nouseroverride"></a><dl> <dt><b>LOCALE_NOUSEROVERRIDE</b></dt> </dl>
///              </td> <td width="60%"> Uses the system default locale settings, rather than custom locale settings. </td> </tr>
///              </table>
///    pbstrOut = The resulting value.
@DllImport("OLEAUT32")
HRESULT VarBstrFromUI2(ushort uiIn, uint lcid, uint dwFlags, BSTR* pbstrOut);

///Converts an unsigned long value to a BSTR value.
///Params:
///    ulIn = The value to convert.
///    lcid = The locale identifier.
///    dwFlags = Reserved. Set to zero.
///    pbstrOut = The resulting value.
@DllImport("OLEAUT32")
HRESULT VarBstrFromUI4(uint ulIn, uint lcid, uint dwFlags, BSTR* pbstrOut);

///Converts an 8-byte unsigned integer value to a BSTR value.
///Params:
///    ui64In = The value to convert.
///    lcid = The locale identifier.
///    dwFlags = Reserved. Set to zero.
///    pbstrOut = The resulting value.
@DllImport("OLEAUT32")
HRESULT VarBstrFromUI8(ulong ui64In, uint lcid, uint dwFlags, BSTR* pbstrOut);

///Converts a decimal value to a BSTR value.
///Params:
///    pdecIn = The value to convert.
///    lcid = The locale identifier.
///    dwFlags = One or more of the following flags. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
///              id="LOCALE_NOUSEROVERRIDE"></a><a id="locale_nouseroverride"></a><dl> <dt><b>LOCALE_NOUSEROVERRIDE</b></dt> </dl>
///              </td> <td width="60%"> Uses the system default locale settings, rather than custom locale settings. </td> </tr>
///              <tr> <td width="40%"><a id="VAR_TIMEVALUEONLY"></a><a id="var_timevalueonly"></a><dl>
///              <dt><b>VAR_TIMEVALUEONLY</b></dt> </dl> </td> <td width="60%"> Omits the date portion of a VT_DATE and returns
///              only the time. Applies to conversions to or from dates. Not used for VariantChangeType and VariantChangeTypeEx.
///              </td> </tr> <tr> <td width="40%"><a id="VAR_DATEVALUEONLY"></a><a id="var_datevalueonly"></a><dl>
///              <dt><b>VAR_DATEVALUEONLY</b></dt> </dl> </td> <td width="60%"> Omits the time portion of a VT_DATE and returns
///              only the date. Applies to conversions to or from dates. Not used for VariantChangeType and VariantChangeTypeEx.
///              </td> </tr> </table>
///    pbstrOut = The resulting value.
@DllImport("OLEAUT32")
HRESULT VarBstrFromDec(const(DECIMAL)* pdecIn, uint lcid, uint dwFlags, BSTR* pbstrOut);

///Converts an unsigned char value to a Boolean value.
///Params:
///    bIn = The value to convert.
///    pboolOut = The resulting value.
@DllImport("OLEAUT32")
HRESULT VarBoolFromUI1(ubyte bIn, short* pboolOut);

///Converts a short value to a Boolean value.
///Params:
///    sIn = The value to convert.
///    pboolOut = The resulting value.
@DllImport("OLEAUT32")
HRESULT VarBoolFromI2(short sIn, short* pboolOut);

///Converts a long value to a Boolean value.
///Params:
///    lIn = The value to convert.
///    pboolOut = The resulting value.
@DllImport("OLEAUT32")
HRESULT VarBoolFromI4(int lIn, short* pboolOut);

///Converts an 8-byte integer value to a Boolean value.
///Params:
///    i64In = The value to convert.
///    pboolOut = The resulting value.
@DllImport("OLEAUT32")
HRESULT VarBoolFromI8(long i64In, short* pboolOut);

///Converts a float value to a Boolean value.
///Params:
///    fltIn = The value to convert.
///    pboolOut = The resulting value.
@DllImport("OLEAUT32")
HRESULT VarBoolFromR4(float fltIn, short* pboolOut);

///Converts a double value to a Boolean value.
///Params:
///    dblIn = The value to convert.
///    pboolOut = The resulting value.
@DllImport("OLEAUT32")
HRESULT VarBoolFromR8(double dblIn, short* pboolOut);

///Converts a date value to a Boolean value.
///Params:
///    dateIn = The value to convert.
///    pboolOut = The resulting value.
@DllImport("OLEAUT32")
HRESULT VarBoolFromDate(double dateIn, short* pboolOut);

///Converts a currency value to a Boolean value.
///Params:
///    cyIn = The value to convert.
///    pboolOut = The resulting value.
@DllImport("OLEAUT32")
HRESULT VarBoolFromCy(CY cyIn, short* pboolOut);

///Converts an OLECHAR string to a Boolean value.
///Params:
///    strIn = The value to convert.
///    lcid = The locale identifier.
///    dwFlags = One or more of the following flags. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
///              id="LOCALE_NOUSEROVERRIDE"></a><a id="locale_nouseroverride"></a><dl> <dt><b>LOCALE_NOUSEROVERRIDE</b></dt> </dl>
///              </td> <td width="60%"> Uses the system default locale settings, rather than custom locale settings. </td> </tr>
///              <tr> <td width="40%"><a id="VAR_LOCALBOOL"></a><a id="var_localbool"></a><dl> <dt><b>VAR_LOCALBOOL</b></dt> </dl>
///              </td> <td width="60%"> Uses localized Boolean names. </td> </tr> </table>
///    pboolOut = The resulting value.
@DllImport("OLEAUT32")
HRESULT VarBoolFromStr(ushort* strIn, uint lcid, uint dwFlags, short* pboolOut);

///Converts the default property of an IDispatch instance to a Boolean value.
///Params:
///    pdispIn = The value to convert.
///    lcid = The locale identifier.
///    pboolOut = The resulting value.
@DllImport("OLEAUT32")
HRESULT VarBoolFromDisp(IDispatch pdispIn, uint lcid, short* pboolOut);

///Converts a char value to a Boolean value.
///Params:
///    cIn = The value to convert.
///    pboolOut = The resulting value.
@DllImport("OLEAUT32")
HRESULT VarBoolFromI1(byte cIn, short* pboolOut);

///Converts an unsigned short value to a Boolean value.
///Params:
///    uiIn = The value to convert.
///    pboolOut = The resulting value.
@DllImport("OLEAUT32")
HRESULT VarBoolFromUI2(ushort uiIn, short* pboolOut);

///Converts an unsigned long value to a Boolean value.
///Params:
///    ulIn = The value to convert.
///    pboolOut = The resulting value.
@DllImport("OLEAUT32")
HRESULT VarBoolFromUI4(uint ulIn, short* pboolOut);

///Converts an 8-byte unsigned integer value to a Boolean value.
///Params:
///    i64In = The value to convert.
///    pboolOut = The resulting value.
@DllImport("OLEAUT32")
HRESULT VarBoolFromUI8(ulong i64In, short* pboolOut);

///Converts a decimal value to a Boolean value.
///Params:
///    pdecIn = The value to convert.
///    pboolOut = The resulting value.
@DllImport("OLEAUT32")
HRESULT VarBoolFromDec(const(DECIMAL)* pdecIn, short* pboolOut);

///Converts an unsigned char value to a char value.
///Params:
///    bIn = The value to convert.
///    pcOut = The resulting value.
@DllImport("OLEAUT32")
HRESULT VarI1FromUI1(ubyte bIn, byte* pcOut);

///Converts a short value to a char value.
///Params:
///    uiIn = The value to convert.
///    pcOut = The resulting value.
@DllImport("OLEAUT32")
HRESULT VarI1FromI2(short uiIn, byte* pcOut);

///Converts a long value to a char value.
///Params:
///    lIn = The value to convert.
///    pcOut = The resulting value.
@DllImport("OLEAUT32")
HRESULT VarI1FromI4(int lIn, byte* pcOut);

///Converts an 8-byte integer value to a char value.
///Params:
///    i64In = The value to convert.
///    pcOut = The resulting value.
@DllImport("OLEAUT32")
HRESULT VarI1FromI8(long i64In, byte* pcOut);

///Converts a float value to a char value.
///Params:
///    fltIn = The value to convert.
///    pcOut = The resulting value.
@DllImport("OLEAUT32")
HRESULT VarI1FromR4(float fltIn, byte* pcOut);

///Converts a double value to a char value.
///Params:
///    dblIn = The value to convert.
///    pcOut = The resulting value.
@DllImport("OLEAUT32")
HRESULT VarI1FromR8(double dblIn, byte* pcOut);

///Converts a date value to a char value.
///Params:
///    dateIn = The value to convert.
///    pcOut = The resulting value.
@DllImport("OLEAUT32")
HRESULT VarI1FromDate(double dateIn, byte* pcOut);

///Converts a currency value to a char value.
///Params:
///    cyIn = The value to convert.
///    pcOut = The resulting value.
@DllImport("OLEAUT32")
HRESULT VarI1FromCy(CY cyIn, byte* pcOut);

///Converts an OLECHAR string to a char value.
///Params:
///    strIn = The value to convert.
///    lcid = The locale identifier.
///    dwFlags = One or more of the following flags. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
///              id="LOCALE_NOUSEROVERRIDE"></a><a id="locale_nouseroverride"></a><dl> <dt><b>LOCALE_NOUSEROVERRIDE</b></dt> </dl>
///              </td> <td width="60%"> Uses the system default locale settings, rather than custom locale settings. </td> </tr>
///              </table>
///    pcOut = The resulting value.
@DllImport("OLEAUT32")
HRESULT VarI1FromStr(ushort* strIn, uint lcid, uint dwFlags, byte* pcOut);

///Converts the default property of an IDispatch instance to a char value.
///Params:
///    pdispIn = The value to convert.
///    lcid = The locale identifier.
///    pcOut = The resulting value.
@DllImport("OLEAUT32")
HRESULT VarI1FromDisp(IDispatch pdispIn, uint lcid, byte* pcOut);

///Converts a Boolean value to a char value.
///Params:
///    boolIn = The value to convert.
///    pcOut = The resulting value.
@DllImport("OLEAUT32")
HRESULT VarI1FromBool(short boolIn, byte* pcOut);

///Converts an unsigned short value to a char value.
///Params:
///    uiIn = The value to convert.
///    pcOut = The resulting value.
@DllImport("OLEAUT32")
HRESULT VarI1FromUI2(ushort uiIn, byte* pcOut);

///Converts an unsigned long value to a char value.
///Params:
///    ulIn = The value to convert.
///    pcOut = The resulting value.
@DllImport("OLEAUT32")
HRESULT VarI1FromUI4(uint ulIn, byte* pcOut);

///Converts an 8-byte unsigned integer value to a char value.
///Params:
///    i64In = The value to convert.
///    pcOut = The resulting value.
@DllImport("OLEAUT32")
HRESULT VarI1FromUI8(ulong i64In, byte* pcOut);

///Converts a decimal value to a char value.
///Params:
///    pdecIn = The value to convert.
///    pcOut = The resulting value.
@DllImport("OLEAUT32")
HRESULT VarI1FromDec(const(DECIMAL)* pdecIn, byte* pcOut);

///Converts an unsigned char value to an unsigned short value.
///Params:
///    bIn = The value to convert.
///    puiOut = The resulting value.
@DllImport("OLEAUT32")
HRESULT VarUI2FromUI1(ubyte bIn, ushort* puiOut);

///Converts a short value to an unsigned short value.
///Params:
///    uiIn = The value to convert.
///    puiOut = The resulting value.
@DllImport("OLEAUT32")
HRESULT VarUI2FromI2(short uiIn, ushort* puiOut);

///Converts a long value to an unsigned short value.
///Params:
///    lIn = The value to convert.
///    puiOut = The resulting value.
@DllImport("OLEAUT32")
HRESULT VarUI2FromI4(int lIn, ushort* puiOut);

///Converts an 8-byte integer value to an unsigned short value.
///Params:
///    i64In = The value to convert.
///    puiOut = The resulting value.
@DllImport("OLEAUT32")
HRESULT VarUI2FromI8(long i64In, ushort* puiOut);

///Converts a float value to an unsigned short value.
///Params:
///    fltIn = The value to convert.
///    puiOut = The resulting value.
@DllImport("OLEAUT32")
HRESULT VarUI2FromR4(float fltIn, ushort* puiOut);

///Converts a double value to an unsigned short value.
///Params:
///    dblIn = The value to convert.
///    puiOut = The resulting value.
@DllImport("OLEAUT32")
HRESULT VarUI2FromR8(double dblIn, ushort* puiOut);

///Converts a date value to an unsigned short value.
///Params:
///    dateIn = The value to convert.
///    puiOut = The resulting value.
@DllImport("OLEAUT32")
HRESULT VarUI2FromDate(double dateIn, ushort* puiOut);

///Converts a currency value to an unsigned short value.
///Params:
///    cyIn = The value to convert.
///    puiOut = The resulting value.
@DllImport("OLEAUT32")
HRESULT VarUI2FromCy(CY cyIn, ushort* puiOut);

///Converts an OLECHAR string to an unsigned short value.
///Params:
///    strIn = The value to convert.
///    lcid = The locale identifier.
///    dwFlags = One or more of the following flags. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
///              id="LOCALE_NOUSEROVERRIDE"></a><a id="locale_nouseroverride"></a><dl> <dt><b>LOCALE_NOUSEROVERRIDE</b></dt> </dl>
///              </td> <td width="60%"> Uses the system default locale settings, rather than custom locale settings. </td> </tr>
///              <tr> <td width="40%"><a id="VAR_TIMEVALUEONLY"></a><a id="var_timevalueonly"></a><dl>
///              <dt><b>VAR_TIMEVALUEONLY</b></dt> </dl> </td> <td width="60%"> Omits the date portion of a VT_DATE and returns
///              only the time. Applies to conversions to or from dates. </td> </tr> <tr> <td width="40%"><a
///              id="VAR_DATEVALUEONLY"></a><a id="var_datevalueonly"></a><dl> <dt><b>VAR_DATEVALUEONLY</b></dt> </dl> </td> <td
///              width="60%"> Omits the time portion of a VT_DATE and returns only the date. Applies to conversions to or from
///              dates. </td> </tr> </table>
///    puiOut = The resulting value.
@DllImport("OLEAUT32")
HRESULT VarUI2FromStr(ushort* strIn, uint lcid, uint dwFlags, ushort* puiOut);

///Converts the default property of an IDispatch instance to an unsigned short value.
///Params:
///    pdispIn = The value to convert.
///    lcid = The locale identifier.
///    puiOut = The resulting value.
@DllImport("OLEAUT32")
HRESULT VarUI2FromDisp(IDispatch pdispIn, uint lcid, ushort* puiOut);

///Converts a Boolean value to an unsigned short value.
///Params:
///    boolIn = The value to convert.
///    puiOut = The resulting value.
@DllImport("OLEAUT32")
HRESULT VarUI2FromBool(short boolIn, ushort* puiOut);

///Converts a char value to an unsigned short value.
///Params:
///    cIn = The value to convert.
///    puiOut = The resulting value.
@DllImport("OLEAUT32")
HRESULT VarUI2FromI1(byte cIn, ushort* puiOut);

///Converts an unsigned long value to an unsigned short value.
///Params:
///    ulIn = The value to convert.
///    puiOut = The resulting value.
@DllImport("OLEAUT32")
HRESULT VarUI2FromUI4(uint ulIn, ushort* puiOut);

///Converts an 8-byte unsigned integer value to an unsigned short value.
///Params:
///    i64In = The value to convert.
///    puiOut = The resulting value.
@DllImport("OLEAUT32")
HRESULT VarUI2FromUI8(ulong i64In, ushort* puiOut);

///Converts a decimal value to an unsigned short value.
///Params:
///    pdecIn = The value to convert.
///    puiOut = The resulting value.
@DllImport("OLEAUT32")
HRESULT VarUI2FromDec(const(DECIMAL)* pdecIn, ushort* puiOut);

///Converts an unsigned char value to an unsigned long value.
///Params:
///    bIn = The value to convert.
///    pulOut = The resulting value.
@DllImport("OLEAUT32")
HRESULT VarUI4FromUI1(ubyte bIn, uint* pulOut);

///Converts a short value to an unsigned long value.
///Params:
///    uiIn = The value to convert.
///    pulOut = The resulting value.
@DllImport("OLEAUT32")
HRESULT VarUI4FromI2(short uiIn, uint* pulOut);

///Converts a long value to an unsigned long value.
///Params:
///    lIn = The value to convert.
///    pulOut = The resulting value.
@DllImport("OLEAUT32")
HRESULT VarUI4FromI4(int lIn, uint* pulOut);

///Converts an 8-byte integer value to an unsigned long value.
///Params:
///    i64In = The value to convert.
///    plOut = The resulting value.
@DllImport("OLEAUT32")
HRESULT VarUI4FromI8(long i64In, uint* plOut);

///Converts a float value to an unsigned long value.
///Params:
///    fltIn = The value to convert.
///    pulOut = The resulting value.
@DllImport("OLEAUT32")
HRESULT VarUI4FromR4(float fltIn, uint* pulOut);

///Converts a double value to an unsigned long value.
///Params:
///    dblIn = The value to convert.
///    pulOut = The resulting value.
@DllImport("OLEAUT32")
HRESULT VarUI4FromR8(double dblIn, uint* pulOut);

///Converts a date value to an unsigned long value.
///Params:
///    dateIn = The value to convert.
///    pulOut = The resulting value.
@DllImport("OLEAUT32")
HRESULT VarUI4FromDate(double dateIn, uint* pulOut);

///Converts a currency value to an unsigned long value.
///Params:
///    cyIn = The value to convert.
///    pulOut = The resulting value.
@DllImport("OLEAUT32")
HRESULT VarUI4FromCy(CY cyIn, uint* pulOut);

///Converts an OLECHAR string to an unsigned long value.
///Params:
///    strIn = The value to convert.
///    lcid = The locale identifier.
///    dwFlags = One or more of the following flags. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
///              id="LOCALE_NOUSEROVERRIDE"></a><a id="locale_nouseroverride"></a><dl> <dt><b>LOCALE_NOUSEROVERRIDE</b></dt> </dl>
///              </td> <td width="60%"> Uses the system default locale settings, rather than custom locale settings. </td> </tr>
///              <tr> <td width="40%"><a id="VAR_TIMEVALUEONLY"></a><a id="var_timevalueonly"></a><dl>
///              <dt><b>VAR_TIMEVALUEONLY</b></dt> </dl> </td> <td width="60%"> Omits the date portion of a VT_DATE and returns
///              only the time. Applies to conversions to or from dates. </td> </tr> <tr> <td width="40%"><a
///              id="VAR_DATEVALUEONLY"></a><a id="var_datevalueonly"></a><dl> <dt><b>VAR_DATEVALUEONLY</b></dt> </dl> </td> <td
///              width="60%"> Omits the time portion of a VT_DATE and returns only the date. Applies to conversions to or from
///              dates. </td> </tr> </table>
///    pulOut = The resulting value.
@DllImport("OLEAUT32")
HRESULT VarUI4FromStr(ushort* strIn, uint lcid, uint dwFlags, uint* pulOut);

///Converts the default property of an IDispatch instance to an unsigned long value.
///Params:
///    pdispIn = The value to convert.
///    lcid = The locale identifier.
///    pulOut = The resulting value.
@DllImport("OLEAUT32")
HRESULT VarUI4FromDisp(IDispatch pdispIn, uint lcid, uint* pulOut);

///Converts a Boolean value to an unsigned long value.
///Params:
///    boolIn = The value to convert.
///    pulOut = The resulting value.
@DllImport("OLEAUT32")
HRESULT VarUI4FromBool(short boolIn, uint* pulOut);

///Converts a char value to an unsigned long value.
///Params:
///    cIn = The value to convert.
///    pulOut = The resulting value.
@DllImport("OLEAUT32")
HRESULT VarUI4FromI1(byte cIn, uint* pulOut);

///Converts an unsigned short value to an unsigned long value.
///Params:
///    uiIn = The value to convert.
///    pulOut = The resulting value.
@DllImport("OLEAUT32")
HRESULT VarUI4FromUI2(ushort uiIn, uint* pulOut);

///Converts an 8-byte unsigned integer value to an unsigned long value.
///Params:
///    ui64In = The value to convert.
///    plOut = The resulting value.
@DllImport("OLEAUT32")
HRESULT VarUI4FromUI8(ulong ui64In, uint* plOut);

///Converts a decimal value to an unsigned long value.
///Params:
///    pdecIn = The value to convert.
///    pulOut = The resulting value.
@DllImport("OLEAUT32")
HRESULT VarUI4FromDec(const(DECIMAL)* pdecIn, uint* pulOut);

///Converts a byte value to an 8-byte unsigned integer value.
///Params:
///    bIn = The value to convert.
///    pi64Out = The resulting value.
@DllImport("OLEAUT32")
HRESULT VarUI8FromUI1(ubyte bIn, ulong* pi64Out);

///Converts a short value to an 8-byte unsigned integer value.
///Params:
///    sIn = The value to convert.
///    pi64Out = The resulting value.
@DllImport("OLEAUT32")
HRESULT VarUI8FromI2(short sIn, ulong* pi64Out);

///Converts an 8-byte integer value to an 8-byte unsigned integer value.
///Params:
///    ui64In = The value to convert.
///    pi64Out = The resulting value.
@DllImport("OLEAUT32")
HRESULT VarUI8FromI8(long ui64In, ulong* pi64Out);

///Converts a float value to an 8-byte unsigned integer value.
///Params:
///    fltIn = The value to convert.
///    pi64Out = The resulting value.
@DllImport("OLEAUT32")
HRESULT VarUI8FromR4(float fltIn, ulong* pi64Out);

///Converts a double value to an 8-byte unsigned integer value.
///Params:
///    dblIn = The value to convert.
///    pi64Out = The resulting value.
@DllImport("OLEAUT32")
HRESULT VarUI8FromR8(double dblIn, ulong* pi64Out);

///Converts a currency value to an 8-byte unsigned integer value.
///Params:
///    cyIn = The value to convert.
///    pi64Out = The resulting value.
@DllImport("OLEAUT32")
HRESULT VarUI8FromCy(CY cyIn, ulong* pi64Out);

///Converts a date value to an 8-byte unsigned integer value.
///Params:
///    dateIn = The value to convert.
///    pi64Out = The resulting value.
@DllImport("OLEAUT32")
HRESULT VarUI8FromDate(double dateIn, ulong* pi64Out);

///Converts an OLECHAR string to an 8-byte unsigned integer value.
///Params:
///    strIn = The value to convert.
///    lcid = The locale identifier.
///    dwFlags = One or more of the following flags. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
///              id="LOCALE_NOUSEROVERRIDE"></a><a id="locale_nouseroverride"></a><dl> <dt><b>LOCALE_NOUSEROVERRIDE</b></dt> </dl>
///              </td> <td width="60%"> Uses the system default locale settings, rather than custom locale settings. </td> </tr>
///              </table>
///    pi64Out = The resulting value.
@DllImport("OLEAUT32")
HRESULT VarUI8FromStr(ushort* strIn, uint lcid, uint dwFlags, ulong* pi64Out);

///Converts the default property of an IDispatch instance to an 8-byte unsigned integer value.
///Params:
///    pdispIn = The value to convert.
///    lcid = The locale identifier.
///    pi64Out = The resulting value.
@DllImport("OLEAUT32")
HRESULT VarUI8FromDisp(IDispatch pdispIn, uint lcid, ulong* pi64Out);

///Converts a VARIANT_BOOL value to an 8-byte unsigned integer value.
///Params:
///    boolIn = The value to convert.
///    pi64Out = The resulting value.
@DllImport("OLEAUT32")
HRESULT VarUI8FromBool(short boolIn, ulong* pi64Out);

///Converts a char value to an 8-byte unsigned integer value.
///Params:
///    cIn = The value to convert.
///    pi64Out = The resulting value.
@DllImport("OLEAUT32")
HRESULT VarUI8FromI1(byte cIn, ulong* pi64Out);

///Converts an unsigned short value to an 8-byte unsigned integer value.
///Params:
///    uiIn = The value to convert.
///    pi64Out = The resulting value.
@DllImport("OLEAUT32")
HRESULT VarUI8FromUI2(ushort uiIn, ulong* pi64Out);

///Converts an unsigned long value to an 8-byte unsigned integer value.
///Params:
///    ulIn = The value to convert.
///    pi64Out = The resulting value.
@DllImport("OLEAUT32")
HRESULT VarUI8FromUI4(uint ulIn, ulong* pi64Out);

///Converts a decimal value to an 8-byte unsigned integer value.
///Params:
///    pdecIn = The value to convert.
///    pi64Out = The resulting value.
@DllImport("OLEAUT32")
HRESULT VarUI8FromDec(const(DECIMAL)* pdecIn, ulong* pi64Out);

///Converts an unsigned char value to a decimal value.
///Params:
///    bIn = The value to convert.
///    pdecOut = The resulting value.
@DllImport("OLEAUT32")
HRESULT VarDecFromUI1(ubyte bIn, DECIMAL* pdecOut);

///Converts a short value to a decimal value.
///Params:
///    uiIn = The value to convert.
///    pdecOut = The resulting value.
@DllImport("OLEAUT32")
HRESULT VarDecFromI2(short uiIn, DECIMAL* pdecOut);

///Converts a long value to a decimal value.
///Params:
///    lIn = The value to convert.
///    pdecOut = The resulting value.
@DllImport("OLEAUT32")
HRESULT VarDecFromI4(int lIn, DECIMAL* pdecOut);

///Converts an 8-byte integer value to a decimal value.
///Params:
///    i64In = The value to convert.
///    pdecOut = The resulting value.
@DllImport("OLEAUT32")
HRESULT VarDecFromI8(long i64In, DECIMAL* pdecOut);

///Converts a float value to a decimal value.
///Params:
///    fltIn = The value to convert.
///    pdecOut = The resulting value.
@DllImport("OLEAUT32")
HRESULT VarDecFromR4(float fltIn, DECIMAL* pdecOut);

///Converts a double value to a decimal value.
///Params:
///    dblIn = The value to convert.
///    pdecOut = The resulting value.
@DllImport("OLEAUT32")
HRESULT VarDecFromR8(double dblIn, DECIMAL* pdecOut);

///Converts a date value to a decimal value.
///Params:
///    dateIn = The value to convert.
///    pdecOut = The resulting value.
@DllImport("OLEAUT32")
HRESULT VarDecFromDate(double dateIn, DECIMAL* pdecOut);

///Converts a currency value to a decimal value.
///Params:
///    cyIn = The value to convert.
///    pdecOut = The resulting value.
@DllImport("OLEAUT32")
HRESULT VarDecFromCy(CY cyIn, DECIMAL* pdecOut);

///Converts an OLECHAR string to a decimal value.
///Params:
///    strIn = The value to convert.
///    lcid = The locale identifier.
///    dwFlags = One or more of the following flags. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
///              id="LOCALE_NOUSEROVERRIDE"></a><a id="locale_nouseroverride"></a><dl> <dt><b>LOCALE_NOUSEROVERRIDE</b></dt> </dl>
///              </td> <td width="60%"> Uses the system default locale settings, rather than custom locale settings. </td> </tr>
///              <tr> <td width="40%"><a id="VAR_TIMEVALUEONLY"></a><a id="var_timevalueonly"></a><dl>
///              <dt><b>VAR_TIMEVALUEONLY</b></dt> </dl> </td> <td width="60%"> Omits the date portion of a VT_DATE and returns
///              only the time. Applies to conversions to or from dates. </td> </tr> <tr> <td width="40%"><a
///              id="VAR_DATEVALUEONLY"></a><a id="var_datevalueonly"></a><dl> <dt><b>VAR_DATEVALUEONLY</b></dt> </dl> </td> <td
///              width="60%"> Omits the time portion of a VT_DATE and returns only the date. Applies to conversions to or from
///              dates. </td> </tr> </table>
///    pdecOut = The resulting value.
@DllImport("OLEAUT32")
HRESULT VarDecFromStr(ushort* strIn, uint lcid, uint dwFlags, DECIMAL* pdecOut);

///Converts the default property of an IDispatch instance to a decimal value.
///Params:
///    pdispIn = The value to convert.
///    lcid = The locale identifier.
///    pdecOut = The resulting value.
@DllImport("OLEAUT32")
HRESULT VarDecFromDisp(IDispatch pdispIn, uint lcid, DECIMAL* pdecOut);

///Converts a Boolean value to a decimal value.
///Params:
///    boolIn = The value to convert.
///    pdecOut = The resulting value.
@DllImport("OLEAUT32")
HRESULT VarDecFromBool(short boolIn, DECIMAL* pdecOut);

///Converts a char value to a decimal value.
///Params:
///    cIn = The value to convert.
///    pdecOut = The resulting value.
@DllImport("OLEAUT32")
HRESULT VarDecFromI1(byte cIn, DECIMAL* pdecOut);

///Converts an unsigned short value to a decimal value.
///Params:
///    uiIn = The value to convert.
///    pdecOut = The resulting value.
@DllImport("OLEAUT32")
HRESULT VarDecFromUI2(ushort uiIn, DECIMAL* pdecOut);

///Converts an unsigned long value to a decimal value.
///Params:
///    ulIn = The value to convert.
///    pdecOut = The resulting value.
@DllImport("OLEAUT32")
HRESULT VarDecFromUI4(uint ulIn, DECIMAL* pdecOut);

///Converts an 8-byte unsigned integer value to a decimal value.
///Params:
///    ui64In = The value to convert.
///    pdecOut = The resulting value.
@DllImport("OLEAUT32")
HRESULT VarDecFromUI8(ulong ui64In, DECIMAL* pdecOut);

///Parses a string, and creates a type-independent description of the number it represents.
///Params:
///    strIn = The input string to convert.
///    lcid = The locale identifier.
///    dwFlags = Enables the caller to control parsing, therefore defining the acceptable syntax of a number. If this field is set
///              to zero, the input string must contain nothing but decimal digits. Setting each defined flag bit enables parsing
///              of that syntactic feature. Standard Automation parsing (for example, as used by VarI2FromStr) has all flags set
///              (NUMPRS_STD).
///    pnumprs = The parsed results.
///    rgbDig = The values for the digits in the range 0–7, 0–9, or 0–15, depending on whether the number is octal,
///             decimal, or hexadecimal. All leading zeros have been stripped off. For decimal numbers, trailing zeros are also
///             stripped off, unless the number is zero, in which case a single zero digit will be present.
@DllImport("OLEAUT32")
HRESULT VarParseNumFromStr(ushort* strIn, uint lcid, uint dwFlags, NUMPARSE* pnumprs, char* rgbDig);

///Converts parsed results to a variant.
///Params:
///    pnumprs = The parsed results. The <b>cDig</b> member of this argument specifies the number of digits present in
///              <i>rgbDig</i>.
///    rgbDig = The values of the digits. The <b>cDig</b> field of <i>pnumprs</i> contains the number of digits.
///    dwVtBits = One bit set for each type that is acceptable as a return value (in many cases, just one bit). <a
///               id="VTBIT_I1"></a> <a id="vtbit_i1"></a>
///    pvar = The variant result.
///Returns:
///    This function can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Out of memory. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>DISP_E_OVERFLOW</b></dt> </dl> </td> <td width="60%"> The number is too large to be
///    represented in an allowed type. There is no error if precision is lost in the conversion. </td> </tr> </table>
///    
@DllImport("OLEAUT32")
HRESULT VarNumFromParseNum(NUMPARSE* pnumprs, char* rgbDig, uint dwVtBits, VARIANT* pvar);

///Returns the sum of two variants.
///Params:
///    pvarLeft = The first variant.
///    pvarRight = The second variant.
///    pvarResult = The result variant.
///Returns:
///    If this function succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
///    
@DllImport("OLEAUT32")
HRESULT VarAdd(VARIANT* pvarLeft, VARIANT* pvarRight, VARIANT* pvarResult);

///Performs a bitwise And operation between two variants of any integral type.
///Params:
///    pvarLeft = The first variant.
///    pvarRight = The second variant.
///    pvarResult = The result variant.
///Returns:
///    If this function succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
///    
@DllImport("OLEAUT32")
HRESULT VarAnd(VARIANT* pvarLeft, VARIANT* pvarRight, VARIANT* pvarResult);

///Concatenates two variants and returns the result.
///Params:
///    pvarLeft = The first variant.
///    pvarRight = The second variant.
///    pvarResult = The result variant.
///Returns:
///    If this function succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
///    
@DllImport("OLEAUT32")
HRESULT VarCat(VARIANT* pvarLeft, VARIANT* pvarRight, VARIANT* pvarResult);

///Returns the result from dividing two variants.
///Params:
///    pvarLeft = The first variant.
///    pvarRight = The second variant.
///    pvarResult = The result variant.
///Returns:
///    If this function succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
///    
@DllImport("OLEAUT32")
HRESULT VarDiv(VARIANT* pvarLeft, VARIANT* pvarRight, VARIANT* pvarResult);

///Performs a bitwise equivalence on two variants.
///Params:
///    pvarLeft = The first variant.
///    pvarRight = The second variant.
///    pvarResult = The result variant.
///Returns:
///    If this function succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
///    
@DllImport("OLEAUT32")
HRESULT VarEqv(VARIANT* pvarLeft, VARIANT* pvarRight, VARIANT* pvarResult);

///Converts two variants of any type to integers then returns the result from dividing them.
///Params:
///    pvarLeft = The first variant.
///    pvarRight = The second variant.
///    pvarResult = The result variant.
///Returns:
///    If this function succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
///    
@DllImport("OLEAUT32")
HRESULT VarIdiv(VARIANT* pvarLeft, VARIANT* pvarRight, VARIANT* pvarResult);

///Performs a bitwise implication on two variants.
///Params:
///    pvarLeft = The first variant.
///    pvarRight = The second variant.
///    pvarResult = The result variant.
///Returns:
///    If this function succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
///    
@DllImport("OLEAUT32")
HRESULT VarImp(VARIANT* pvarLeft, VARIANT* pvarRight, VARIANT* pvarResult);

///Divides two variants and returns only the remainder.
///Params:
///    pvarLeft = The first variant.
///    pvarRight = The second variant.
///    pvarResult = The result variant.
@DllImport("OLEAUT32")
HRESULT VarMod(VARIANT* pvarLeft, VARIANT* pvarRight, VARIANT* pvarResult);

///Returns the result from multiplying two variants.
///Params:
///    pvarLeft = The first variant.
///    pvarRight = The second variant.
///    pvarResult = The result variant.
///Returns:
///    If this function succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
///    
@DllImport("OLEAUT32")
HRESULT VarMul(VARIANT* pvarLeft, VARIANT* pvarRight, VARIANT* pvarResult);

///Performs a logical disjunction on two variants.
///Params:
///    pvarLeft = The first variant.
///    pvarRight = The second variant.
///    pvarResult = The result variant.
///Returns:
///    If this function succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
///    
@DllImport("OLEAUT32")
HRESULT VarOr(VARIANT* pvarLeft, VARIANT* pvarRight, VARIANT* pvarResult);

///Returns the result of performing the power function with two variants.
///Params:
///    pvarLeft = The first variant.
///    pvarRight = The second variant.
///    pvarResult = The result variant.
///Returns:
///    If this function succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
///    
@DllImport("OLEAUT32")
HRESULT VarPow(VARIANT* pvarLeft, VARIANT* pvarRight, VARIANT* pvarResult);

///Subtracts two variants.
///Params:
///    pvarLeft = The first variant.
///    pvarRight = The second variant.
///    pvarResult = The result variant.
///Returns:
///    If this function succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
///    
@DllImport("OLEAUT32")
HRESULT VarSub(VARIANT* pvarLeft, VARIANT* pvarRight, VARIANT* pvarResult);

///Performs a logical exclusion on two variants.
///Params:
///    pvarLeft = The first variant.
///    pvarRight = The second variant.
///    pvarResult = The result variant.
///Returns:
///    If this function succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
///    
@DllImport("OLEAUT32")
HRESULT VarXor(VARIANT* pvarLeft, VARIANT* pvarRight, VARIANT* pvarResult);

///Returns the absolute value of a variant.
///Params:
///    pvarIn = The variant.
///    pvarResult = The result variant.
@DllImport("OLEAUT32")
HRESULT VarAbs(VARIANT* pvarIn, VARIANT* pvarResult);

///Returns the integer portion of a variant.
///Params:
///    pvarIn = The variant.
///    pvarResult = The result variant.
///Returns:
///    If this function succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
///    
@DllImport("OLEAUT32")
HRESULT VarFix(VARIANT* pvarIn, VARIANT* pvarResult);

///Returns the integer portion of a variant.
///Params:
///    pvarIn = The variant.
///    pvarResult = The result variant.
///Returns:
///    If this function succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
///    
@DllImport("OLEAUT32")
HRESULT VarInt(VARIANT* pvarIn, VARIANT* pvarResult);

///Performs logical negation on a variant.
///Params:
///    pvarIn = The variant.
///    pvarResult = The result variant.
@DllImport("OLEAUT32")
HRESULT VarNeg(VARIANT* pvarIn, VARIANT* pvarResult);

///Performs the bitwise not negation operation on a variant.
///Params:
///    pvarIn = The variant.
///    pvarResult = The result variant.
///Returns:
///    If this function succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
///    
@DllImport("OLEAUT32")
HRESULT VarNot(VARIANT* pvarIn, VARIANT* pvarResult);

///Rounds a variant to the specified number of decimal places.
///Params:
///    pvarIn = The variant.
///    cDecimals = The number of decimal places.
///    pvarResult = The result variant.
@DllImport("OLEAUT32")
HRESULT VarRound(VARIANT* pvarIn, int cDecimals, VARIANT* pvarResult);

///Compares two variants.
///Params:
///    pvarLeft = The first variant.
///    pvarRight = The second variant.
///    lcid = The locale identifier.
///    dwFlags = The compare results option. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
///              id="NORM_IGNORECASE"></a><a id="norm_ignorecase"></a><dl> <dt><b>NORM_IGNORECASE</b></dt> <dt>0x00000001</dt>
///              </dl> </td> <td width="60%"> Ignore case. </td> </tr> <tr> <td width="40%"><a id="NORM_IGNORENONSPACE"></a><a
///              id="norm_ignorenonspace"></a><dl> <dt><b>NORM_IGNORENONSPACE</b></dt> <dt>0x00000002</dt> </dl> </td> <td
///              width="60%"> Ignore nonspace characters. </td> </tr> <tr> <td width="40%"><a id="NORM_IGNORESYMBOLS"></a><a
///              id="norm_ignoresymbols"></a><dl> <dt><b>NORM_IGNORESYMBOLS</b></dt> <dt>0x00000004</dt> </dl> </td> <td
///              width="60%"> Ignore symbols. </td> </tr> <tr> <td width="40%"><a id="NORM_IGNOREWIDTH"></a><a
///              id="norm_ignorewidth"></a><dl> <dt><b>NORM_IGNOREWIDTH</b></dt> <dt>0x00000008</dt> </dl> </td> <td width="60%">
///              Ignore string width. </td> </tr> <tr> <td width="40%"><a id="NORM_IGNOREKANATYPE"></a><a
///              id="norm_ignorekanatype"></a><dl> <dt><b>NORM_IGNOREKANATYPE</b></dt> <dt>0x00000040</dt> </dl> </td> <td
///              width="60%"> Ignore Kana type. </td> </tr> <tr> <td width="40%"><a id="NORM_IGNOREKASHIDA"></a><a
///              id="norm_ignorekashida"></a><dl> <dt><b>NORM_IGNOREKASHIDA</b></dt> <dt>0x00040000</dt> </dl> </td> <td
///              width="60%"> Ignore Arabic kashida characters. </td> </tr> </table>
///Returns:
///    This function can return one of these values. <table> <tr> <th>Return code/value</th> <th>Description</th> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>VARCMP_LT</b></dt> <dt>0</dt> </dl> </td> <td width="60%"> <i>pvarLeft</i> is
///    less than <i>pvarRight</i>. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>VARCMP_EQ</b></dt> <dt>1</dt> </dl>
///    </td> <td width="60%"> The parameters are equal. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>VARCMP_GT</b></dt>
///    <dt>2</dt> </dl> </td> <td width="60%"> <i>pvarLeft</i> is greater than <i>pvarRight</i>. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>VARCMP_NULL</b></dt> <dt>3</dt> </dl> </td> <td width="60%"> Either expression is NULL.
///    </td> </tr> </table>
///    
@DllImport("OLEAUT32")
HRESULT VarCmp(VARIANT* pvarLeft, VARIANT* pvarRight, uint lcid, uint dwFlags);

///Adds two variants of type decimal.
///Params:
///    pdecLeft = The first variant.
///    pdecRight = The second variant.
///    pdecResult = The resulting variant.
@DllImport("OLEAUT32")
HRESULT VarDecAdd(DECIMAL* pdecLeft, DECIMAL* pdecRight, DECIMAL* pdecResult);

///Divides two variants of type decimal.
///Params:
///    pdecLeft = The first decimal variant.
///    pdecRight = The second decimal variant.
///    pdecResult = The resulting decimal variant.
@DllImport("OLEAUT32")
HRESULT VarDecDiv(DECIMAL* pdecLeft, DECIMAL* pdecRight, DECIMAL* pdecResult);

///Multiplies two variants of type decimal.
///Params:
///    pdecLeft = The first variant.
///    pdecRight = The second variant.
///    pdecResult = The resulting variant.
@DllImport("OLEAUT32")
HRESULT VarDecMul(DECIMAL* pdecLeft, DECIMAL* pdecRight, DECIMAL* pdecResult);

///Subtracts two variants of type decimal.
///Params:
///    pdecLeft = The first variant.
///    pdecRight = The second variant.
///    pdecResult = The resulting variant.
@DllImport("OLEAUT32")
HRESULT VarDecSub(DECIMAL* pdecLeft, DECIMAL* pdecRight, DECIMAL* pdecResult);

///Retrieves the absolute value of a variant of type decimal.
///Params:
///    pdecIn = The first variant.
///    pdecResult = The second variant.
@DllImport("OLEAUT32")
HRESULT VarDecAbs(DECIMAL* pdecIn, DECIMAL* pdecResult);

///Retrieves the integer portion of a variant of type decimal.
///Params:
///    pdecIn = The decimal variant.
///    pdecResult = The resulting variant. If the variant is negative, then the first negative integer greater than or equal to the
///                 variant is returned.
@DllImport("OLEAUT32")
HRESULT VarDecFix(DECIMAL* pdecIn, DECIMAL* pdecResult);

///Retrieves the integer portion of a variant of type decimal.
///Params:
///    pdecIn = The decimal variant.
///    pdecResult = The resulting variant. If the variant is negative, then the first negative integer less than or equal to the
///                 variant is returned.
@DllImport("OLEAUT32")
HRESULT VarDecInt(DECIMAL* pdecIn, DECIMAL* pdecResult);

///Performs logical negation on a variant of type decimal.
///Params:
///    pdecIn = The variant to negate.
///    pdecResult = The resulting variant.
@DllImport("OLEAUT32")
HRESULT VarDecNeg(DECIMAL* pdecIn, DECIMAL* pdecResult);

///Rounds a variant of type decimal to the specified number of decimal places.
///Params:
///    pdecIn = The variant to round.
///    cDecimals = The number of decimal places.
///    pdecResult = The resulting variant.
@DllImport("OLEAUT32")
HRESULT VarDecRound(DECIMAL* pdecIn, int cDecimals, DECIMAL* pdecResult);

///Compares two variants of type decimal.
///Params:
///    pdecLeft = The first variant.
///    pdecRight = The second variant.
@DllImport("OLEAUT32")
HRESULT VarDecCmp(DECIMAL* pdecLeft, DECIMAL* pdecRight);

///Compares a variant of type decimal with the a value of type double.
///Params:
///    pdecLeft = The first variant.
///    dblRight = The second variant.
@DllImport("OLEAUT32")
HRESULT VarDecCmpR8(DECIMAL* pdecLeft, double dblRight);

///Adds two variants of type currency.
///Params:
///    cyLeft = The first variant.
///    cyRight = The second variant.
///    pcyResult = The resulting variant.
@DllImport("OLEAUT32")
HRESULT VarCyAdd(CY cyLeft, CY cyRight, CY* pcyResult);

///Multiplies two variants of type currency.
///Params:
///    cyLeft = The first variant
///    cyRight = The second variant.
///    pcyResult = The resulting variant.
///Returns:
///    If this function succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
///    
@DllImport("OLEAUT32")
HRESULT VarCyMul(CY cyLeft, CY cyRight, CY* pcyResult);

///Multiplies a currency value by a 32-bit integer.
///Params:
///    cyLeft = The first variant.
///    lRight = The second variant.
///    pcyResult = The resulting variant.
@DllImport("OLEAUT32")
HRESULT VarCyMulI4(CY cyLeft, int lRight, CY* pcyResult);

///Multiplies a currency value by a 64-bit integer.
///Params:
///    cyLeft = The first variant.
///    lRight = The second variant.
///    pcyResult = The resulting variant.
@DllImport("OLEAUT32")
HRESULT VarCyMulI8(CY cyLeft, long lRight, CY* pcyResult);

///Subtracts two variants of type currency.
///Params:
///    cyLeft = The first variant.
///    cyRight = The second variant.
///    pcyResult = The resulting variant.
@DllImport("OLEAUT32")
HRESULT VarCySub(CY cyLeft, CY cyRight, CY* pcyResult);

///Retrieves the absolute value of a variant of type currency.
///Params:
///    cyIn = The currency variant.
///    pcyResult = The resulting variant.
@DllImport("OLEAUT32")
HRESULT VarCyAbs(CY cyIn, CY* pcyResult);

///Retrieves the integer portion of a variant of type currency.
///Params:
///    cyIn = The currency variant.
///    pcyResult = The resulting variant. If the variant is negative, then the first negative integer greater than or equal to the
///                variant is returned.
@DllImport("OLEAUT32")
HRESULT VarCyFix(CY cyIn, CY* pcyResult);

///Retrieves the integer portion of a variant of type currency.
///Params:
///    cyIn = The currency variant.
///    pcyResult = The resulting variant. If the variant is negative then the first negative integer less than or equal to the
///                variant is returned.
@DllImport("OLEAUT32")
HRESULT VarCyInt(CY cyIn, CY* pcyResult);

///Performs a logical negation on a variant of type currency.
///Params:
///    cyIn = The variant to negate.
///    pcyResult = The resulting variant.
@DllImport("OLEAUT32")
HRESULT VarCyNeg(CY cyIn, CY* pcyResult);

///Rounds a variant of type currency to the specified number of decimal places.
///Params:
///    cyIn = The variant to round.
///    cDecimals = The number of currency decimals.
///    pcyResult = The resulting variant.
@DllImport("OLEAUT32")
HRESULT VarCyRound(CY cyIn, int cDecimals, CY* pcyResult);

///Compares two variants of type currency.
///Params:
///    cyLeft = The first variant.
///    cyRight = The second variant.
@DllImport("OLEAUT32")
HRESULT VarCyCmp(CY cyLeft, CY cyRight);

///Compares a variant of type currency with a value of type double.
///Params:
///    cyLeft = The first variant.
///    dblRight = The second variant.
@DllImport("OLEAUT32")
HRESULT VarCyCmpR8(CY cyLeft, double dblRight);

///Concatenates two variants of type BSTR and returns the resulting BSTR.
///Params:
///    bstrLeft = The first variant.
///    bstrRight = The second variant.
///    pbstrResult = The result.
@DllImport("OLEAUT32")
HRESULT VarBstrCat(BSTR bstrLeft, BSTR bstrRight, ushort** pbstrResult);

///Compares two variants of type BSTR.
///Params:
///    bstrLeft = The first variant.
///    bstrRight = The second variant.
///    lcid = The locale identifier of the program to determine whether UNICODE or ANSI strings are being used.
///    dwFlags = The following are compare results flags. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td
///              width="40%"><a id="NORM_IGNORECASE"></a><a id="norm_ignorecase"></a><dl> <dt><b>NORM_IGNORECASE</b></dt>
///              <dt>0x00000001</dt> </dl> </td> <td width="60%"> Ignore case. </td> </tr> <tr> <td width="40%"><a
///              id="NORM_IGNORENONSPACE"></a><a id="norm_ignorenonspace"></a><dl> <dt><b>NORM_IGNORENONSPACE</b></dt>
///              <dt>0x00000002</dt> </dl> </td> <td width="60%"> Ignore nonspace characters. </td> </tr> <tr> <td width="40%"><a
///              id="NORM_IGNORESYMBOLS"></a><a id="norm_ignoresymbols"></a><dl> <dt><b>NORM_IGNORESYMBOLS</b></dt>
///              <dt>0x00000004</dt> </dl> </td> <td width="60%"> Ignore symbols. </td> </tr> <tr> <td width="40%"><a
///              id="NORM_IGNOREWIDTH"></a><a id="norm_ignorewidth"></a><dl> <dt><b>NORM_IGNOREWIDTH</b></dt> <dt>0x00000008</dt>
///              </dl> </td> <td width="60%"> Ignore string width. </td> </tr> <tr> <td width="40%"><a
///              id="NORM_IGNOREKANATYPE"></a><a id="norm_ignorekanatype"></a><dl> <dt><b>NORM_IGNOREKANATYPE</b></dt>
///              <dt>0x00000040</dt> </dl> </td> <td width="60%"> Ignore Kana type. </td> </tr> <tr> <td width="40%"><a
///              id="NORM_IGNOREKASHIDA"></a><a id="norm_ignorekashida"></a><dl> <dt><b>NORM_IGNOREKASHIDA</b></dt>
///              <dt>0x00040000</dt> </dl> </td> <td width="60%"> Ignore Arabic kashida characters. </td> </tr> </table>
///Returns:
///    This function can return one of these values. <table> <tr> <th>Return code/value</th> <th>Description</th> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>VARCMP_LT</b></dt> <dt>0</dt> </dl> </td> <td width="60%"> <i>bstrLeft</i> is
///    less than <i>bstrRight</i>. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>VARCMP_EQ</b></dt> <dt>1</dt> </dl>
///    </td> <td width="60%"> The parameters are equal. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>VARCMP_GT</b></dt>
///    <dt>2</dt> </dl> </td> <td width="60%"> <i>bstrLeft</i> is greater than <i>bstrRight</i>. </td> </tr> </table>
///    
@DllImport("OLEAUT32")
HRESULT VarBstrCmp(BSTR bstrLeft, BSTR bstrRight, uint lcid, uint dwFlags);

///Performs the power function for variants of type double.
///Params:
///    dblLeft = The first variant.
///    dblRight = The second variant.
///    pdblResult = The result.
@DllImport("OLEAUT32")
HRESULT VarR8Pow(double dblLeft, double dblRight, double* pdblResult);

///Compares two variants of types float and double.
///Params:
///    fltLeft = The first variant.
///    dblRight = The second variant.
@DllImport("OLEAUT32")
HRESULT VarR4CmpR8(float fltLeft, double dblRight);

///Rounds a variant of type double to the specified number of decimal places.
///Params:
///    dblIn = The variant.
///    cDecimals = The number of decimal places.
///    pdblResult = The result.
@DllImport("OLEAUT32")
HRESULT VarR8Round(double dblIn, int cDecimals, double* pdblResult);

///Converts a time and date converted from MS-DOS format to variant format.
///Params:
///    pudateIn = The unpacked date.
///    dwFlags = VAR_VALIDDATE if the date is valid.
///    pdateOut = The packed date.
///Returns:
///    This function can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One of the arguments is not valid.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Insufficient
///    memory to complete the operation. </td> </tr> </table>
///    
@DllImport("OLEAUT32")
HRESULT VarDateFromUdate(UDATE* pudateIn, uint dwFlags, double* pdateOut);

///Converts a time and date converted from MS-DOS format to variant format.
///Params:
///    pudateIn = The unpacked date.
///    lcid = The locale identifier.
///    dwFlags = VAR_VALIDDATE if the date is valid.
///    pdateOut = The packed date.
///Returns:
///    This function can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One of the arguments is not valid.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Insufficient
///    memory to complete the operation. </td> </tr> </table>
///    
@DllImport("OLEAUT32")
HRESULT VarDateFromUdateEx(UDATE* pudateIn, uint lcid, uint dwFlags, double* pdateOut);

///Converts a time and date converted from variant format to MS-DOS format.
///Params:
///    dateIn = The packed date.
///    dwFlags = Set for alternative calendars such as Hijri, Polish and Russian.
///    pudateOut = The unpacked date.
///Returns:
///    This function can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One of the arguments is not valid.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Insufficient
///    memory to complete the operation. </td> </tr> </table>
///    
@DllImport("OLEAUT32")
HRESULT VarUdateFromDate(double dateIn, uint dwFlags, UDATE* pudateOut);

///Retrieves the secondary (alternate) month names.
///Params:
///    lcid = The locale identifier to be used in retrieving the alternate month names.
///    prgp = An array of pointers to strings containing the alternate month names.
///Returns:
///    The function returns TRUE on success and FALSE otherwise.
///    
@DllImport("OLEAUT32")
HRESULT GetAltMonthNames(uint lcid, ushort*** prgp);

///Formats a variant into string form by parsing a format string.
///Params:
///    pvarIn = The variant.
///    pstrFormat = The format string. For example "mm-dd-yy".
///    iFirstDay = First day of the week. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt>0</dt>
///                </dl> </td> <td width="60%"> The system default </td> </tr> <tr> <td width="40%"> <dl> <dt>1</dt> </dl> </td> <td
///                width="60%"> Monday </td> </tr> <tr> <td width="40%"> <dl> <dt>2</dt> </dl> </td> <td width="60%"> Tuesday </td>
///                </tr> <tr> <td width="40%"> <dl> <dt>3</dt> </dl> </td> <td width="60%"> Wednesday </td> </tr> <tr> <td
///                width="40%"> <dl> <dt>4</dt> </dl> </td> <td width="60%"> Thursday </td> </tr> <tr> <td width="40%"> <dl>
///                <dt>5</dt> </dl> </td> <td width="60%"> Friday </td> </tr> <tr> <td width="40%"> <dl> <dt>6</dt> </dl> </td> <td
///                width="60%"> Saturday </td> </tr> <tr> <td width="40%"> <dl> <dt>7</dt> </dl> </td> <td width="60%"> Sunday </td>
///                </tr> </table>
///    iFirstWeek = First week of the year. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt>0</dt>
///                 </dl> </td> <td width="60%"> The system default. </td> </tr> <tr> <td width="40%"> <dl> <dt>1</dt> </dl> </td>
///                 <td width="60%"> The first week contains January 1st. </td> </tr> <tr> <td width="40%"> <dl> <dt>2</dt> </dl>
///                 </td> <td width="60%"> The larger half (four days) of the first week is in the current year. </td> </tr> <tr> <td
///                 width="40%"> <dl> <dt>3</dt> </dl> </td> <td width="60%"> The first week has seven days. </td> </tr> </table>
///    dwFlags = Flags that control the formatting process. The only flags that can be set are VAR_CALENDAR_HIJRI or
///              VAR_FORMAT_NOSUBSTITUTE.
///    pbstrOut = The formatted string that represents the variant.
///Returns:
///    This function can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One or more of the arguments is not
///    valid. </td> </tr> </table>
///    
@DllImport("OLEAUT32")
HRESULT VarFormat(VARIANT* pvarIn, ushort* pstrFormat, int iFirstDay, int iFirstWeek, uint dwFlags, BSTR* pbstrOut);

///Formats a variant containing named date and time information into a string.
///Params:
///    pvarIn = The variant containing the value to format.
///    iNamedFormat = The named date formats are as follows. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%">
///                   <dl> <dt>0</dt> </dl> </td> <td width="60%"> General date </td> </tr> <tr> <td width="40%"> <dl> <dt>1</dt> </dl>
///                   </td> <td width="60%"> Long date </td> </tr> <tr> <td width="40%"> <dl> <dt>2</dt> </dl> </td> <td width="60%">
///                   Short date </td> </tr> <tr> <td width="40%"> <dl> <dt>3</dt> </dl> </td> <td width="60%"> Long time </td> </tr>
///                   <tr> <td width="40%"> <dl> <dt>4</dt> </dl> </td> <td width="60%"> Short time </td> </tr> </table>
///    dwFlags = VAR_CALENDAR_HIJRI is the only flag that can be set.
///    pbstrOut = Receives the formatted string that represents the variant.
///Returns:
///    This function can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One or more of the arguments is not
///    valid. </td> </tr> </table>
///    
@DllImport("OLEAUT32")
HRESULT VarFormatDateTime(VARIANT* pvarIn, int iNamedFormat, uint dwFlags, BSTR* pbstrOut);

///Formats a variant containing numbers into a string form.
///Params:
///    pvarIn = The variant containing the value to format.
///    iNumDig = The number of digits to pad to after the decimal point. Specify -1 to use the system default value.
///    iIncLead = Specifies whether to include the leading digit on numbers. <table> <tr> <th>Value</th> <th>Meaning</th> </tr>
///               <tr> <td width="40%"> <dl> <dt>-2</dt> </dl> </td> <td width="60%"> Use the system default. </td> </tr> <tr> <td
///               width="40%"> <dl> <dt>-1</dt> </dl> </td> <td width="60%"> Include the leading digit. </td> </tr> <tr> <td
///               width="40%"> <dl> <dt>0</dt> </dl> </td> <td width="60%"> Do not include the leading digit. </td> </tr> </table>
///    iUseParens = Specifies whether negative numbers should use parentheses. <table> <tr> <th>Value</th> <th>Meaning</th> </tr>
///                 <tr> <td width="40%"> <dl> <dt>-2</dt> </dl> </td> <td width="60%"> Use the system default. </td> </tr> <tr> <td
///                 width="40%"> <dl> <dt>-1</dt> </dl> </td> <td width="60%"> Use parentheses. </td> </tr> <tr> <td width="40%">
///                 <dl> <dt>0</dt> </dl> </td> <td width="60%"> Do not use parentheses. </td> </tr> </table>
///    iGroup = Specifies whether thousands should be grouped. For example 10,000 versus 10000. <div class="alert"><b>Note</b>
///             Regular numbers and currencies have separate system defaults for all the above options.</div> <div> </div>
///             <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt>-2</dt> </dl> </td> <td
///             width="60%"> Use the system default. </td> </tr> <tr> <td width="40%"> <dl> <dt>-1</dt> </dl> </td> <td
///             width="60%"> Group thousands. </td> </tr> <tr> <td width="40%"> <dl> <dt>0</dt> </dl> </td> <td width="60%"> Do
///             not group thousands. </td> </tr> </table>
///    dwFlags = VAR_CALENDAR_HIJRI is the only flag that can be set.
///    pbstrOut = Points to the formatted string that represents the variant.
///Returns:
///    This function can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One or more of the arguments is not
///    valid. </td> </tr> </table>
///    
@DllImport("OLEAUT32")
HRESULT VarFormatNumber(VARIANT* pvarIn, int iNumDig, int iIncLead, int iUseParens, int iGroup, uint dwFlags, 
                        BSTR* pbstrOut);

///Formats a variant containing percentages into a string form.
///Params:
///    pvarIn = The variant containing the value to format.
///    iNumDig = The number of digits to pad to after the decimal point. Specify -1 to use the system default value.
///    iIncLead = Specifies whether to include the leading digit on numbers. <table> <tr> <th>Value</th> <th>Meaning</th> </tr>
///               <tr> <td width="40%"> <dl> <dt>-2</dt> </dl> </td> <td width="60%"> Use the system default. </td> </tr> <tr> <td
///               width="40%"> <dl> <dt>-1</dt> </dl> </td> <td width="60%"> Include the leading digit. </td> </tr> <tr> <td
///               width="40%"> <dl> <dt>0</dt> </dl> </td> <td width="60%"> Do not include the leading digit. </td> </tr> </table>
///    iUseParens = Specifies whether negative numbers should use parentheses. <table> <tr> <th>Value</th> <th>Meaning</th> </tr>
///                 <tr> <td width="40%"> <dl> <dt>-2</dt> </dl> </td> <td width="60%"> Use the system default. </td> </tr> <tr> <td
///                 width="40%"> <dl> <dt>-1</dt> </dl> </td> <td width="60%"> Use parentheses. </td> </tr> <tr> <td width="40%">
///                 <dl> <dt>0</dt> </dl> </td> <td width="60%"> Do not use parentheses. </td> </tr> </table>
///    iGroup = Specifies whether thousands should be grouped. For example 10,000 versus 10000. <div class="alert"><b>Note</b>
///             Regular numbers and currencies have separate system defaults for all the above options.</div> <div> </div>
///             <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt>-2</dt> </dl> </td> <td
///             width="60%"> Use the system default. </td> </tr> <tr> <td width="40%"> <dl> <dt>-1</dt> </dl> </td> <td
///             width="60%"> Group thousands. </td> </tr> <tr> <td width="40%"> <dl> <dt>0</dt> </dl> </td> <td width="60%"> Do
///             not group thousands. </td> </tr> </table>
///    dwFlags = VAR_CALENDAR_HIJRI is the only flag that can be set.
///    pbstrOut = Receives the formatted string that represents the variant.
///Returns:
///    This function can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One or more of the arguments is not
///    valid. </td> </tr> </table>
///    
@DllImport("OLEAUT32")
HRESULT VarFormatPercent(VARIANT* pvarIn, int iNumDig, int iIncLead, int iUseParens, int iGroup, uint dwFlags, 
                         BSTR* pbstrOut);

///Formats a variant containing currency values into a string form.
///Params:
///    pvarIn = The variant.
///    iNumDig = The number of digits to pad to after the decimal point. Specify -1 to use the system default value.
///    iIncLead = Specifies whether to include the leading digit on numbers. <table> <tr> <th>Value</th> <th>Meaning</th> </tr>
///               <tr> <td width="40%"> <dl> <dt>-2</dt> </dl> </td> <td width="60%"> Use the system default. </td> </tr> <tr> <td
///               width="40%"> <dl> <dt>-1</dt> </dl> </td> <td width="60%"> Include the leading digit. </td> </tr> <tr> <td
///               width="40%"> <dl> <dt>0</dt> </dl> </td> <td width="60%"> Do not include the leading digit. </td> </tr> </table>
///    iUseParens = Specifies whether negative numbers should use parentheses. <table> <tr> <th>Value</th> <th>Meaning</th> </tr>
///                 <tr> <td width="40%"> <dl> <dt>-2</dt> </dl> </td> <td width="60%"> Use the system default. </td> </tr> <tr> <td
///                 width="40%"> <dl> <dt>-1</dt> </dl> </td> <td width="60%"> Use parentheses. </td> </tr> <tr> <td width="40%">
///                 <dl> <dt>0</dt> </dl> </td> <td width="60%"> Do not use parentheses. </td> </tr> </table>
///    iGroup = Specifies whether thousands should be grouped. For example 10,000 versus 10000. <div class="alert"><b>Note</b>
///             Regular numbers and currencies have separate system defaults for all the above options.</div> <div> </div>
///             <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt>-2</dt> </dl> </td> <td
///             width="60%"> Use the system default. </td> </tr> <tr> <td width="40%"> <dl> <dt>-1</dt> </dl> </td> <td
///             width="60%"> Group thousands. </td> </tr> <tr> <td width="40%"> <dl> <dt>0</dt> </dl> </td> <td width="60%"> Do
///             not group thousands. </td> </tr> </table>
///    dwFlags = VAR_CALENDAR_HIJRI is the only flag that can be set.
///    pbstrOut = The formatted string that represents the variant.
///Returns:
///    This function can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One or more of the arguments is not
///    valid. </td> </tr> </table>
///    
@DllImport("OLEAUT32")
HRESULT VarFormatCurrency(VARIANT* pvarIn, int iNumDig, int iIncLead, int iUseParens, int iGroup, uint dwFlags, 
                          BSTR* pbstrOut);

///Returns a string containing the localized name of the weekday.
///Params:
///    iWeekday = The day of the week. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt>0</dt>
///               </dl> </td> <td width="60%"> The system default </td> </tr> <tr> <td width="40%"> <dl> <dt>1</dt> </dl> </td> <td
///               width="60%"> Monday </td> </tr> <tr> <td width="40%"> <dl> <dt>2</dt> </dl> </td> <td width="60%"> Tuesday </td>
///               </tr> <tr> <td width="40%"> <dl> <dt>3</dt> </dl> </td> <td width="60%"> Wednesday </td> </tr> <tr> <td
///               width="40%"> <dl> <dt>4</dt> </dl> </td> <td width="60%"> Thursday </td> </tr> <tr> <td width="40%"> <dl>
///               <dt>5</dt> </dl> </td> <td width="60%"> Friday </td> </tr> <tr> <td width="40%"> <dl> <dt>6</dt> </dl> </td> <td
///               width="60%"> Saturday </td> </tr> <tr> <td width="40%"> <dl> <dt>7</dt> </dl> </td> <td width="60%"> Sunday </td>
///               </tr> </table>
///    fAbbrev = If zero then the full (non-abbreviated) weekday name is used. If non-zero, then the abbreviation for the weekday
///              name is used.
///    iFirstDay = First day of the week. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt>0</dt>
///                </dl> </td> <td width="60%"> The system default </td> </tr> <tr> <td width="40%"> <dl> <dt>1</dt> </dl> </td> <td
///                width="60%"> Monday </td> </tr> <tr> <td width="40%"> <dl> <dt>2</dt> </dl> </td> <td width="60%"> Tuesday </td>
///                </tr> <tr> <td width="40%"> <dl> <dt>3</dt> </dl> </td> <td width="60%"> Wednesday </td> </tr> <tr> <td
///                width="40%"> <dl> <dt>4</dt> </dl> </td> <td width="60%"> Thursday </td> </tr> <tr> <td width="40%"> <dl>
///                <dt>5</dt> </dl> </td> <td width="60%"> Friday </td> </tr> <tr> <td width="40%"> <dl> <dt>6</dt> </dl> </td> <td
///                width="60%"> Saturday </td> </tr> <tr> <td width="40%"> <dl> <dt>7</dt> </dl> </td> <td width="60%"> Sunday </td>
///                </tr> </table>
///    dwFlags = VAR_CALENDAR_HIJRI is the only flag that can be set.
///    pbstrOut = Receives the formatted string that represents the variant.
@DllImport("OLEAUT32")
HRESULT VarWeekdayName(int iWeekday, int fAbbrev, int iFirstDay, uint dwFlags, BSTR* pbstrOut);

///Returns a string containing the localized month name.
///Params:
///    iMonth = Represents the month, as a number from 1 to 12.
///    fAbbrev = If zero then the full (non-abbreviated) month name is used. If non-zero, then the abbreviation for the month name
///              is used.
///    dwFlags = VAR_CALENDAR_HIJRI is the only flag that can be set.
///    pbstrOut = Receives the formatted string that represents the variant.
@DllImport("OLEAUT32")
HRESULT VarMonthName(int iMonth, int fAbbrev, uint dwFlags, BSTR* pbstrOut);

///Takes a tokenized format string and applies it to a variant to produce a formatted output string.
///Params:
///    pvarIn = The variant containing the value to format.
///    pstrFormat = The original format string.
///    pbTokCur = The tokenized format string from VarTokenizeFormatString.
///    dwFlags = The only flags that can be set are VAR_CALENDAR_HIJRI or VAR_FORMAT_NOSUBSTITUTE.
///    pbstrOut = The formatted output string.
///    lcid = The locale to use for the formatted output string.
///Returns:
///    This function can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Out of memory. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One or more of the arguments is not
///    valid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>DISP_E_TYPEMISMATCH</b></dt> </dl> </td> <td width="60%">
///    The argument could not be coerced to the specified type. </td> </tr> </table>
///    
@DllImport("OLEAUT32")
HRESULT VarFormatFromTokens(VARIANT* pvarIn, ushort* pstrFormat, char* pbTokCur, uint dwFlags, BSTR* pbstrOut, 
                            uint lcid);

///Parses the actual format string into a series of tokens which can be used to format variants using
///VarFormatFromTokens.
///Params:
///    pstrFormat = The format string. For example "mm-dd-yy".
///    rgbTok = The destination token buffer.
///    cbTok = The size of the destination token buffer.
///    iFirstDay = First day of the week. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt>0</dt>
///                </dl> </td> <td width="60%"> The system default </td> </tr> <tr> <td width="40%"> <dl> <dt>1</dt> </dl> </td> <td
///                width="60%"> Monday </td> </tr> <tr> <td width="40%"> <dl> <dt>2</dt> </dl> </td> <td width="60%"> Tuesday </td>
///                </tr> <tr> <td width="40%"> <dl> <dt>3</dt> </dl> </td> <td width="60%"> Wednesday </td> </tr> <tr> <td
///                width="40%"> <dl> <dt>4</dt> </dl> </td> <td width="60%"> Thursday </td> </tr> <tr> <td width="40%"> <dl>
///                <dt>5</dt> </dl> </td> <td width="60%"> Friday </td> </tr> <tr> <td width="40%"> <dl> <dt>6</dt> </dl> </td> <td
///                width="60%"> Saturday </td> </tr> <tr> <td width="40%"> <dl> <dt>7</dt> </dl> </td> <td width="60%"> Sunday </td>
///                </tr> </table>
///    iFirstWeek = First week of the year. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt>0</dt>
///                 </dl> </td> <td width="60%"> The system default. </td> </tr> <tr> <td width="40%"> <dl> <dt>1</dt> </dl> </td>
///                 <td width="60%"> The first week contains January 1st. </td> </tr> <tr> <td width="40%"> <dl> <dt>2</dt> </dl>
///                 </td> <td width="60%"> The larger half (four days) of the first week is in the current year. </td> </tr> <tr> <td
///                 width="40%"> <dl> <dt>3</dt> </dl> </td> <td width="60%"> The first week has seven days. </td> </tr> </table>
///    lcid = The locale to interpret format string in.
///    pcbActual = Points to the integer which is set to the first generated token. This parameter can be NULL.
///Returns:
///    This function can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One or more of the arguments is not
///    valid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>DISP_E_BUFFERTOOSMALL </b></dt> </dl> </td> <td width="60%">
///    The destination token buffer is too small. </td> </tr> </table>
///    
@DllImport("OLEAUT32")
HRESULT VarTokenizeFormatString(ushort* pstrFormat, char* rgbTok, int cbTok, int iFirstDay, int iFirstWeek, 
                                uint lcid, int* pcbActual);

///Computes a hash value for the specified name.
///Params:
///    syskind = The SYSKIND of the target operating system.
///    lcid = The LCID for the string.
///    szName = The string whose hash value is to be computed.
@DllImport("OLEAUT32")
uint LHashValOfNameSysA(SYSKIND syskind, uint lcid, const(char)* szName);

///Computes a hash value for a name.
///Params:
///    syskind = The SYSKIND of the target operating system.
///    lcid = The LCID for the string.
///    szName = The string whose hash value is to be computed.
@DllImport("OLEAUT32")
uint LHashValOfNameSys(SYSKIND syskind, uint lcid, const(ushort)* szName);

///Loads and registers a type library.
///Params:
///    szFile = The name of the file from which the method should attempt to load a type library.
///    pptlib = The loaded type library.
///Returns:
///    This function can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>S_OK </b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>E_INVALIDARG </b></dt> </dl> </td> <td width="60%"> One or more of the arguments is not
///    valid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY </b></dt> </dl> </td> <td width="60%">
///    Insufficient memory to complete the operation. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>TYPE_E_IOERROR
///    </b></dt> </dl> </td> <td width="60%"> The function could not write to the file. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>TYPE_E_INVALIDSTATE </b></dt> </dl> </td> <td width="60%"> The type library could not be
///    opened. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>TYPE_E_INVDATAREAD </b></dt> </dl> </td> <td width="60%">
///    The function could not read from the file. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>TYPE_E_UNSUPFORMAT
///    </b></dt> </dl> </td> <td width="60%"> The type library has an older format. </td> </tr> <tr> <td width="40%">
///    <dl> <dt><b>TYPE_E_UNKNOWNLCID </b></dt> </dl> </td> <td width="60%"> The LCID could not be found in the
///    OLE-supported DLLs. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>TYPE_E_CANTLOADLIBRARY</b></dt> </dl> </td> <td
///    width="60%"> The type library or DLL could not be loaded. </td> </tr> </table>
///    
@DllImport("OLEAUT32")
HRESULT LoadTypeLib(ushort* szFile, ITypeLib* pptlib);

///Loads a type library and (optionally) registers it in the system registry.
///Params:
///    szFile = The type library file.
///    regkind = Identifies the kind of registration to perform for the type library based on the following flags: DEFAULT,
///              REGISTER and NONE. REGKIND_DEFAULT simply calls LoadTypeLib and registration occurs based on the LoadTypeLib
///              registration rules. REGKIND_NONE calls <b>LoadTypeLib</b> without the registration process enabled.
///              REGKIND_REGISTER calls <b>LoadTypeLib</b> followed by RegisterTypeLib, which registers the type library. To
///              unregister the type library, use UnRegisterTypeLib.
///    pptlib = The type library.
///Returns:
///    This function can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>S_OK </b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>E_INVALIDARG </b></dt> </dl> </td> <td width="60%"> One or more of the arguments is not
///    valid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY </b></dt> </dl> </td> <td width="60%">
///    Insufficient memory to complete the operation. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>TYPE_E_IOERROR
///    </b></dt> </dl> </td> <td width="60%"> The function could not write to the file. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>TYPE_E_REGISTRYACCESS </b></dt> </dl> </td> <td width="60%"> The system registration
///    database could not be opened. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>TYPE_E_INVALIDSTATE </b></dt> </dl>
///    </td> <td width="60%"> The type library could not be opened. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>TYPE_E_CANTLOADLIBRARY</b></dt> </dl> </td> <td width="60%"> The type library or DLL could not be loaded.
///    </td> </tr> </table>
///    
@DllImport("OLEAUT32")
HRESULT LoadTypeLibEx(ushort* szFile, REGKIND regkind, ITypeLib* pptlib);

///Uses registry information to load a type library.
///Params:
///    rguid = The GUID of the library.
///    wVerMajor = The major version of the library.
///    wVerMinor = The minor version of the library.
///    lcid = The national language code of the library.
///    pptlib = The loaded type library.
///Returns:
///    This function can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>S_OK </b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>E_INVALIDARG </b></dt> </dl> </td> <td width="60%"> One or more of the arguments is not
///    valid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY </b></dt> </dl> </td> <td width="60%">
///    Insufficient memory to complete the operation. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>TYPE_E_IOERROR
///    </b></dt> </dl> </td> <td width="60%"> The function could not write to the file. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>TYPE_E_INVALIDSTATE </b></dt> </dl> </td> <td width="60%"> The type library could not be
///    opened. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>TYPE_E_INVDATAREAD </b></dt> </dl> </td> <td width="60%">
///    The function could not read from the file. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>TYPE_E_UNSUPFORMAT
///    </b></dt> </dl> </td> <td width="60%"> The type library has an older format. </td> </tr> <tr> <td width="40%">
///    <dl> <dt><b>TYPE_E_UNKNOWNLCID </b></dt> </dl> </td> <td width="60%"> The LCID could not be found in the
///    OLE-supported DLLs. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>TYPE_E_CANTLOADLIBRARY</b></dt> </dl> </td> <td
///    width="60%"> The type library or DLL could not be loaded. </td> </tr> </table>
///    
@DllImport("OLEAUT32")
HRESULT LoadRegTypeLib(const(GUID)* rguid, ushort wVerMajor, ushort wVerMinor, uint lcid, ITypeLib* pptlib);

///Retrieves the path of a registered type library.
///Params:
///    guid = The GUID of the library.
///    wMaj = The major version number of the library.
///    wMin = The minor version number of the library.
///    lcid = The national language code for the library.
///    lpbstrPathName = The type library name.
///Returns:
///    If this function succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
///    
@DllImport("OLEAUT32")
HRESULT QueryPathOfRegTypeLib(const(GUID)* guid, ushort wMaj, ushort wMin, uint lcid, ushort** lpbstrPathName);

///Adds information about a type library to the system registry.
///Params:
///    ptlib = The type library.
///    szFullPath = The fully qualified path specification for the type library.
///    szHelpDir = The directory in which the Help file for the library being registered can be found. This parameter can be null.
///Returns:
///    This function can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>S_OK </b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>E_INVALIDARG </b></dt> </dl> </td> <td width="60%"> One or more of the arguments is not
///    valid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY </b></dt> </dl> </td> <td width="60%">
///    Insufficient memory to complete the operation. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>TYPE_E_IOERROR
///    </b></dt> </dl> </td> <td width="60%"> The function could not write to the file. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>TYPE_E_REGISTRYACCESS </b></dt> </dl> </td> <td width="60%"> The system registration
///    database could not be opened. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>TYPE_E_INVALIDSTATE </b></dt> </dl>
///    </td> <td width="60%"> The type library could not be opened. </td> </tr> </table>
///    
@DllImport("OLEAUT32")
HRESULT RegisterTypeLib(ITypeLib ptlib, ushort* szFullPath, ushort* szHelpDir);

///Removes type library information from the system registry. Use this API to allow applications to properly uninstall
///themselves.
///Params:
///    libID = The GUID of the type library.
///    wVerMajor = The major version of the type library.
///    wVerMinor = The minor version of the type library.
///    lcid = The locale identifier.
///    syskind = The target operating system.
///Returns:
///    This function can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>S_OK </b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>E_INVALIDARG </b></dt> </dl> </td> <td width="60%"> One or more of the arguments is not
///    valid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY </b></dt> </dl> </td> <td width="60%">
///    Insufficient memory to complete the operation. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>TYPE_E_IOERROR
///    </b></dt> </dl> </td> <td width="60%"> The function could not write to the file. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>TYPE_E_REGISTRYACCESS </b></dt> </dl> </td> <td width="60%"> The system registration
///    database could not be opened. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>TYPE_E_INVALIDSTATE </b></dt> </dl>
///    </td> <td width="60%"> The type library could not be opened. </td> </tr> </table>
///    
@DllImport("OLEAUT32")
HRESULT UnRegisterTypeLib(const(GUID)* libID, ushort wVerMajor, ushort wVerMinor, uint lcid, SYSKIND syskind);

///Registers a type library for use by the calling user.
///Params:
///    ptlib = The type library.
///    szFullPath = The fully qualified path specification for the type library.
///    szHelpDir = The directory in which the Help file for the library being registered can be found. This parameter can be null.
///Returns:
///    This function can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>S_OK </b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>E_INVALIDARG </b></dt> </dl> </td> <td width="60%"> One or more of the arguments is not
///    valid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY </b></dt> </dl> </td> <td width="60%">
///    Insufficient memory to complete the operation. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>TYPE_E_IOERROR
///    </b></dt> </dl> </td> <td width="60%"> The function could not write to the file. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>TYPE_E_REGISTRYACCESS </b></dt> </dl> </td> <td width="60%"> The system registration
///    database could not be opened. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>TYPE_E_INVALIDSTATE </b></dt> </dl>
///    </td> <td width="60%"> The type library could not be opened. </td> </tr> </table>
///    
@DllImport("OLEAUT32")
HRESULT RegisterTypeLibForUser(ITypeLib ptlib, ushort* szFullPath, ushort* szHelpDir);

///Removes type library information that was registered by using RegisterTypeLibForUser.
///Params:
///    libID = The GUID of the library.
///    wMajorVerNum = The major version of the type library.
///    wMinorVerNum = The minor version of the type library.
///    lcid = The locale identifier.
///    syskind = The target operating system.
///Returns:
///    This function can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>S_OK </b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>E_INVALIDARG </b></dt> </dl> </td> <td width="60%"> One or more of the arguments is not
///    valid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY </b></dt> </dl> </td> <td width="60%">
///    Insufficient memory to complete the operation. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>TYPE_E_IOERROR
///    </b></dt> </dl> </td> <td width="60%"> The function could not write to the file. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>TYPE_E_REGISTRYACCESS </b></dt> </dl> </td> <td width="60%"> The system registration
///    database could not be opened. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>TYPE_E_INVALIDSTATE </b></dt> </dl>
///    </td> <td width="60%"> The type library could not be opened. </td> </tr> </table>
///    
@DllImport("OLEAUT32")
HRESULT UnRegisterTypeLibForUser(const(GUID)* libID, ushort wMajorVerNum, ushort wMinorVerNum, uint lcid, 
                                 SYSKIND syskind);

///Provides access to a new object instance that supports the ICreateTypeLib interface.
///Params:
///    syskind = The target operating system for which to create a type library.
///    szFile = The name of the file to create.
///    ppctlib = The ICreateTypeLib interface.
///Returns:
///    <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK </b></dt>
///    </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG </b></dt> </dl>
///    </td> <td width="60%"> One or more of the arguments is not valid. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>E_OUTOFMEMORY </b></dt> </dl> </td> <td width="60%"> Insufficient memory to complete the operation. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>STG_E_INSUFFICIENTMEMORY </b></dt> </dl> </td> <td width="60%">
///    Insufficient memory to complete the operation. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>TYPE_E_IOERROR</b></dt> </dl> </td> <td width="60%"> The function could not create the file. </td> </tr>
///    </table> This method can also return the FACILITY_STORAGE errors.
///    
@DllImport("OLEAUT32")
HRESULT CreateTypeLib(SYSKIND syskind, ushort* szFile, ICreateTypeLib* ppctlib);

///Creates a type library in the current file format. The file and in-memory format for the current version of
///Automation makes use of memory-mapped files. The CreateTypeLib function is still available for creating a type
///library in the older format.
///Params:
///    syskind = The target operating system for which to create a type library.
///    szFile = The name of the file to create.
///    ppctlib = The ICreateTypeLib2 interface.
@DllImport("OLEAUT32")
HRESULT CreateTypeLib2(SYSKIND syskind, ushort* szFile, ICreateTypeLib2* ppctlib);

///Retrieves a parameter from the DISPPARAMS structure, checking both named parameters and positional parameters, and
///coerces the parameter to the specified type.
///Params:
///    pdispparams = The parameters passed to Invoke.
///    position = The position of the parameter in the parameter list. <b>DispGetParam</b> starts at the end of the array, so if
///               position is 0, the last parameter in the array is returned.
///    vtTarg = The type the argument should be coerced to.
///    pvarResult = the variant to pass the parameter into.
///    puArgErr = On return, the index of the argument that caused a DISP_E_TYPEMISMATCH error. This pointer is returned to Invoke
///               to indicate the position of the argument in DISPPARAMS that caused the error.
///Returns:
///    This function can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>DISP_E_BADVARTYPE</b></dt> </dl> </td> <td width="60%"> The variant type <i>vtTarg</i>
///    is not supported. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>DISP_E_OVERFLOW</b></dt> </dl> </td> <td
///    width="60%"> The retrieved parameter could not be coerced to the specified type. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>DISP_E_PARAMNOTFOUND</b></dt> </dl> </td> <td width="60%"> The parameter indicated by
///    <i>position</i> could not be found. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>DISP_E_TYPEMISMATCH</b></dt>
///    </dl> </td> <td width="60%"> The argument could not be coerced to the specified type. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>E_INVALIDARG </b></dt> </dl> </td> <td width="60%"> One of the parameters is not valid.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY </b></dt> </dl> </td> <td width="60%"> Insufficient
///    memory to complete the operation. </td> </tr> </table>
///    
@DllImport("OLEAUT32")
HRESULT DispGetParam(DISPPARAMS* pdispparams, uint position, ushort vtTarg, VARIANT* pvarResult, uint* puArgErr);

///Low-level helper for Invoke that provides machine independence for customized <b>Invoke</b>.
///Params:
///    ptinfo = The type information for an interface. This type information is specific to one interface and language code, so
///             it is not necessary to pass an interface identifier (IID) or LCID to this function.
///    rgszNames = An array of name strings that can be the same array passed to DispInvoke in the DISPPARAMS structure. If
///                <i>cNames</i> is greater than 1, the first name is interpreted as a method name, and subsequent names are
///                interpreted as parameters to that method.
///    cNames = The number of elements in <i>rgszNames</i>.
///    rgdispid = An array of DISPIDs to be filled in by this function. The first ID corresponds to the method name. Subsequent IDs
///               are interpreted as parameters to the method.
@DllImport("OLEAUT32")
HRESULT DispGetIDsOfNames(ITypeInfo ptinfo, char* rgszNames, uint cNames, char* rgdispid);

///Automatically calls member functions on an interface, given the type information for the interface. You can describe
///an interface with type information and implement Invoke for the interface using this single call.
///Params:
///    _this = An implementation of the IDispatch interface described by <i>ptinfo</i>.
///    ptinfo = The type information that describes the interface.
///    dispidMember = The member to be invoked. Use GetIDsOfNames or the object's documentation to obtain the DISPID.
///    wFlags = Flags describing the context of the Invoke call. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td
///             width="40%"><a id="DISPATCH_METHOD"></a><a id="dispatch_method"></a><dl> <dt><b>DISPATCH_METHOD</b></dt> </dl>
///             </td> <td width="60%"> The member is invoked as a method. If a property has the same name, both this and the
///             DISPATCH_PROPERTYGET flag can be set. </td> </tr> <tr> <td width="40%"><a id="DISPATCH_PROPERTYGET"></a><a
///             id="dispatch_propertyget"></a><dl> <dt><b>DISPATCH_PROPERTYGET</b></dt> </dl> </td> <td width="60%"> The member
///             is retrieved as a property or data member. </td> </tr> <tr> <td width="40%"><a id="DISPATCH_PROPERTYPUT"></a><a
///             id="dispatch_propertyput"></a><dl> <dt><b>DISPATCH_PROPERTYPUT</b></dt> </dl> </td> <td width="60%"> The member
///             is changed as a property or data member. </td> </tr> <tr> <td width="40%"><a id="DISPATCH_PROPERTYPUTREF"></a><a
///             id="dispatch_propertyputref"></a><dl> <dt><b>DISPATCH_PROPERTYPUTREF</b></dt> </dl> </td> <td width="60%"> The
///             member is changed by a reference assignment, rather than a value assignment. This flag is valid only when the
///             property accepts a reference to an object. </td> </tr> </table>
///    pparams = Pointer to a structure containing an array of arguments, an array of argument DISPIDs for named arguments, and
///              counts for number of elements in the arrays.
///    pvarResult = Pointer to where the result is to be stored, or Null if the caller expects no result. This argument is ignored if
///                 DISPATCH_PROPERTYPUT or DISPATCH_PROPERTYPUTREF is specified.
///    pexcepinfo = Pointer to a structure containing exception information. This structure should be filled in if DISP_E_EXCEPTION
///                 is returned.
///    puArgErr = The index within rgvarg of the first argument that has an error. Arguments are stored in pdispparams-&gt;rgvarg
///               in reverse order, so the first argument is the one with the highest index in the array. This parameter is
///               returned only when the resulting return value is DISP_E_TYPEMISMATCH or DISP_E_PARAMNOTFOUND.
///Returns:
///    <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt>
///    </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>DISP_E_BADPARAMCOUNT</b></dt>
///    </dl> </td> <td width="60%"> The number of elements provided to DISPPARAMS is different from the number of
///    arguments accepted by the method or property. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>DISP_E_BADVARTYPE</b></dt> </dl> </td> <td width="60%"> One of the arguments in DISPPARAMS is not a valid
///    variant type. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>DISP_E_EXCEPTION</b></dt> </dl> </td> <td
///    width="60%"> The application needs to raise an exception. In this case, the structure passed in <i>pexcepinfo</i>
///    should be filled in. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>DISP_E_MEMBERNOTFOUND</b></dt> </dl> </td> <td
///    width="60%"> The requested member does not exist. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>DISP_E_NONAMEDARGS</b></dt> </dl> </td> <td width="60%"> This implementation of IDispatch does not support
///    named arguments. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>DISP_E_OVERFLOW</b></dt> </dl> </td> <td
///    width="60%"> One of the arguments in DISPPARAMS could not be coerced to the specified type. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>DISP_E_PARAMNOTFOUND</b></dt> </dl> </td> <td width="60%"> One of the parameter IDs does
///    not correspond to a parameter on the method. In this case, <i>puArgErr</i> is set to the first argument that
///    contains the error. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>DISP_E_PARAMNOTOPTIONAL</b></dt> </dl> </td>
///    <td width="60%"> A required parameter was omitted. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>DISP_E_TYPEMISMATCH</b></dt> </dl> </td> <td width="60%"> One or more of the arguments could not be
///    coerced. The index of the first parameter with the incorrect type within rgvarg is returned in <i>puArgErr</i>.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG </b></dt> </dl> </td> <td width="60%"> One of the
///    parameters is not valid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY </b></dt> </dl> </td> <td
///    width="60%"> Insufficient memory to complete the operation. </td> </tr> </table> Any of the
///    <b>ITypeInfo::Invoke</b> errors can also be returned.
///    
@DllImport("OLEAUT32")
HRESULT DispInvoke(void* _this, ITypeInfo ptinfo, int dispidMember, ushort wFlags, DISPPARAMS* pparams, 
                   VARIANT* pvarResult, EXCEPINFO* pexcepinfo, uint* puArgErr);

///Creates simplified type information for use in an implementation of IDispatch.
///Params:
///    pidata = The interface description that this type information describes.
///    lcid = The locale identifier for the names used in the type information.
///    pptinfo = On return, pointer to a type information implementation for use in DispGetIDsOfNames and DispInvoke.
///Returns:
///    This function can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>S_OK </b></dt> </dl> </td> <td width="60%"> The interface is supported. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG </b></dt> </dl> </td> <td width="60%"> Either the interface
///    description or the LCID is not valid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY </b></dt> </dl>
///    </td> <td width="60%"> Insufficient memory to complete the operation. </td> </tr> </table>
///    
@DllImport("OLEAUT32")
HRESULT CreateDispTypeInfo(INTERFACEDATA* pidata, uint lcid, ITypeInfo* pptinfo);

///Creates a standard implementation of the IDispatch interface through a single function call. This simplifies exposing
///objects through Automation.
///Params:
///    punkOuter = The object's <b>IUnknown</b> implementation.
///    pvThis = The object to expose.
///    ptinfo = The type information that describes the exposed object.
///    ppunkStdDisp = The private unknown for the object that implements the IDispatch interface QueryInterface call. This pointer is
///                   null if the function fails.
///Returns:
///    This function can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>S_OK </b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>E_INVALIDARG </b></dt> </dl> </td> <td width="60%"> One of the first three arguments is
///    not valid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY </b></dt> </dl> </td> <td width="60%">
///    There was insufficient memory to complete the operation. </td> </tr> </table>
///    
@DllImport("OLEAUT32")
HRESULT CreateStdDispatch(IUnknown punkOuter, void* pvThis, ITypeInfo ptinfo, IUnknown* ppunkStdDisp);

///Low-level helper for Invoke that provides machine independence for customized <b>Invoke</b>.
///Params:
///    pvInstance = An instance of the interface described by this type description.
///    oVft = For FUNC_VIRTUAL functions, specifies the offset in the VTBL.
///    cc = The calling convention. One of the CALLCONV values, such as CC_STDCALL.
///    vtReturn = The variant type of the function return value. Use VT_EMPTY to represent void.
///    cActuals = The number of function parameters.
///    prgvt = An array of variant types of the function parameters.
///    prgpvarg = The function parameters.
///    pvargResult = The function result.
@DllImport("OLEAUT32")
HRESULT DispCallFunc(void* pvInstance, size_t oVft, CALLCONV cc, ushort vtReturn, uint cActuals, char* prgvt, 
                     char* prgpvarg, VARIANT* pvargResult);

///Registers an object as the active object for its class.
///Params:
///    punk = The active object.
///    rclsid = The CLSID of the active object.
///    dwFlags = Flags controlling registration of the object. Possible values are ACTIVEOBJECT_STRONG and ACTIVEOBJECT_WEAK.
///    pdwRegister = Receives a handle. This handle must be passed to RevokeActiveObject to end the object's active status.
///Returns:
///    If this function succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
///    
@DllImport("OLEAUT32")
HRESULT RegisterActiveObject(IUnknown punk, const(GUID)* rclsid, uint dwFlags, uint* pdwRegister);

///Ends an object's status as active.
///Params:
///    dwRegister = A handle previously returned by RegisterActiveObject.
///    pvReserved = Reserved for future use. Must be null.
@DllImport("OLEAUT32")
HRESULT RevokeActiveObject(uint dwRegister, void* pvReserved);

///Retrieves a pointer to a running object that has been registered with OLE.
///Params:
///    rclsid = The class identifier (CLSID) of the active object from the OLE registration database.
///    pvReserved = Reserved for future use. Must be null.
///    ppunk = The requested active object.
@DllImport("OLEAUT32")
HRESULT GetActiveObject(const(GUID)* rclsid, void* pvReserved, IUnknown* ppunk);

///Sets the error information object for the current logical thread of execution.
///Params:
///    dwReserved = Reserved for future use. Must be zero.
///    perrinfo = An error object.
///Returns:
///    If this function succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
///    
@DllImport("OLEAUT32")
HRESULT SetErrorInfo(uint dwReserved, IErrorInfo perrinfo);

///Obtains the error information pointer set by the previous call to SetErrorInfo in the current logical thread.
///Params:
///    dwReserved = Reserved for future use. Must be zero.
///    pperrinfo = An error object.
///Returns:
///    This function can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>S_FALSE</b></dt> </dl> </td> <td width="60%"> There was no error object to return. </td>
///    </tr> </table>
///    
@DllImport("OLEAUT32")
HRESULT GetErrorInfo(uint dwReserved, IErrorInfo* pperrinfo);

///Creates an instance of a generic error object.
///Params:
///    pperrinfo = A system-implemented generic error object.
///Returns:
///    This function can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>E_OUTOFMEMORY </b></dt> </dl> </td> <td width="60%"> Could not create the error object.
///    </td> </tr> </table>
///    
@DllImport("OLEAUT32")
HRESULT CreateErrorInfo(ICreateErrorInfo* pperrinfo);

///Returns a pointer to the IRecordInfo interface of the UDT by passing its type information. The given ITypeInfo
///interface is used to create a RecordInfo object.
///Params:
///    pTypeInfo = The type information of a record.
///    ppRecInfo = The IRecordInfo interface.
///Returns:
///    This function can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>E_OUTOFMEMORY </b></dt> </dl> </td> <td width="60%"> Out of memory. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>E_INVALIDARG </b></dt> </dl> </td> <td width="60%"> One or more of the arguments is not
///    valid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>TYPE_E_UNSUPFORMAT </b></dt> </dl> </td> <td width="60%">
///    The type is not an interface. </td> </tr> </table>
///    
@DllImport("OLEAUT32")
HRESULT GetRecordInfoFromTypeInfo(ITypeInfo pTypeInfo, IRecordInfo* ppRecInfo);

///Returns a pointer to the IRecordInfo interface for a UDT by passing the GUID of the type information without having
///to load the type library.
///Params:
///    rGuidTypeLib = The GUID of the type library containing the UDT.
///    uVerMajor = The major version number of the type library of the UDT.
///    uVerMinor = The minor version number of the type library of the UDT.
///    lcid = The locale ID of the caller.
///    rGuidTypeInfo = The GUID of the typeinfo that describes the UDT.
///    ppRecInfo = The IRecordInfo interface.
///Returns:
///    This function can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>E_INVALIDARG </b></dt> </dl> </td> <td width="60%"> One or more of the arguments is not
///    valid. </td> </tr> </table>
///    
@DllImport("OLEAUT32")
HRESULT GetRecordInfoFromGuids(const(GUID)* rGuidTypeLib, uint uVerMajor, uint uVerMinor, uint lcid, 
                               const(GUID)* rGuidTypeInfo, IRecordInfo* ppRecInfo);

///Retrieves the build version of OLE Automation.
@DllImport("OLEAUT32")
uint OaBuildVersion();

///Releases memory used to hold the custom data item.
@DllImport("OLEAUT32")
void ClearCustData(CUSTDATA* pCustData);

///Enables the RegisterTypeLib function to override default registry mappings under Windows Vista Service Pack 1 (SP1),
///Windows Server 2008, and later operating system versions.
@DllImport("OLEAUT32")
void OaEnablePerUserTLibRegistration();


// Interfaces

@GUID("A1F4E726-8CF1-11D1-BF92-0060081ED811")
struct WiaDevMgr;

@GUID("A1E75357-881A-419E-83E2-BB16DB197C68")
struct WiaLog;

///Provides the tools for creating and administering the type information defined through the type description.
@GUID("00020405-0000-0000-C000-000000000046")
interface ICreateTypeInfo : IUnknown
{
    ///Sets the globally unique identifier (GUID) associated with the type description.
    ///Params:
    ///    guid = The globally unique ID to be associated with the type description.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK </b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_OUTOFMEMORY </b></dt> </dl> </td> <td width="60%"> Insufficient memory to complete
    ///    the operation. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_ACCESSDENIED</b></dt> </dl> </td> <td
    ///    width="60%"> Cannot write to the destination. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>STG_E_INSUFFICIENTMEMORY </b></dt> </dl> </td> <td width="60%"> Insufficient memory to complete the
    ///    operation. </td> </tr> </table>
    ///    
    HRESULT SetGuid(const(GUID)* guid);
    ///Sets type flags of the type description being created.
    ///Params:
    ///    uTypeFlags = The settings for the type flags. For details, see TYPEFLAGS.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK </b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_INVALIDARG </b></dt> </dl> </td> <td width="60%"> One or more of the arguments is
    ///    not valid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY </b></dt> </dl> </td> <td width="60%">
    ///    Insufficient memory to complete the operation. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_ACCESSDENIED</b></dt> </dl> </td> <td width="60%"> Cannot write to the destination. </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>STG_E_INSUFFICIENTMEMORY </b></dt> </dl> </td> <td width="60%"> Insufficient
    ///    memory to complete the operation. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>TYPE_E_WRONGTYPEKIND</b></dt>
    ///    </dl> </td> <td width="60%"> Type mismatch. </td> </tr> </table>
    ///    
    HRESULT SetTypeFlags(uint uTypeFlags);
    ///Sets the documentation string displayed by type browsers.
    ///Params:
    ///    pStrDoc = A brief description of the type description.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK </b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_OUTOFMEMORY </b></dt> </dl> </td> <td width="60%"> Insufficient memory to complete
    ///    the operation. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_ACCESSDENIED</b></dt> </dl> </td> <td
    ///    width="60%"> Cannot write to the destination. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>STG_E_INSUFFICIENTMEMORY </b></dt> </dl> </td> <td width="60%"> Insufficient memory to complete the
    ///    operation. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>TYPE_E_INVALIDSTATE</b></dt> </dl> </td> <td
    ///    width="60%"> The state of the type library is not valid for this operation. </td> </tr> </table>
    ///    
    HRESULT SetDocString(ushort* pStrDoc);
    ///Sets the Help context ID of the type information.
    ///Params:
    ///    dwHelpContext = A handle to the Help context.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK </b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_INVALIDARG </b></dt> </dl> </td> <td width="60%"> One or more of the arguments is
    ///    not valid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY </b></dt> </dl> </td> <td width="60%">
    ///    Insufficient memory to complete the operation. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_ACCESSDENIED</b></dt> </dl> </td> <td width="60%"> Cannot write to the destination. </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>STG_E_INSUFFICIENTMEMORY </b></dt> </dl> </td> <td width="60%"> Insufficient
    ///    memory to complete the operation. </td> </tr> </table>
    ///    
    HRESULT SetHelpContext(uint dwHelpContext);
    ///Sets the major and minor version number of the type information.
    ///Params:
    ///    wMajorVerNum = The major version number.
    ///    wMinorVerNum = The minor version number.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK </b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_ACCESSDENIED</b></dt> </dl> </td> <td width="60%"> Cannot write to the
    ///    destination. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>TYPE_E_INVALIDSTATE</b></dt> </dl> </td> <td
    ///    width="60%"> The state of the type library is not valid for this operation. </td> </tr> </table>
    ///    
    HRESULT SetVersion(ushort wMajorVerNum, ushort wMinorVerNum);
    ///Adds a type description to those referenced by the type description being created.
    ///Params:
    ///    pTInfo = The type description to be referenced.
    ///    phRefType = The handle that this type description associates with the referenced type information.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK </b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_INVALIDARG </b></dt> </dl> </td> <td width="60%"> One or more of the arguments is
    ///    not valid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY </b></dt> </dl> </td> <td width="60%">
    ///    Insufficient memory to complete the operation. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_ACCESSDENIED</b></dt> </dl> </td> <td width="60%"> Cannot write to the destination. </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>STG_E_INSUFFICIENTMEMORY </b></dt> </dl> </td> <td width="60%"> Insufficient
    ///    memory to complete the operation. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>TYPE_E_WRONGTYPEKIND</b></dt>
    ///    </dl> </td> <td width="60%"> Type mismatch. </td> </tr> </table>
    ///    
    HRESULT AddRefTypeInfo(ITypeInfo pTInfo, uint* phRefType);
    ///Adds a function description to the type description.
    ///Params:
    ///    index = The index of the new FUNCDESC in the type information.
    ///    pFuncDesc = A FUNCDESC structure that describes the function. The <b>bstrIDLInfo</b> field in the FUNCDESC should be
    ///                null.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK </b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_INVALIDARG </b></dt> </dl> </td> <td width="60%"> One or more of the arguments is
    ///    not valid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY </b></dt> </dl> </td> <td width="60%">
    ///    Insufficient memory to complete the operation. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_ACCESSDENIED</b></dt> </dl> </td> <td width="60%"> Cannot write to the destination. </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>STG_E_INSUFFICIENTMEMORY </b></dt> </dl> </td> <td width="60%"> Insufficient
    ///    memory to complete the operation. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>TYPE_E_WRONGTYPEKIND</b></dt>
    ///    </dl> </td> <td width="60%"> Type mismatch. </td> </tr> </table>
    ///    
    HRESULT AddFuncDesc(uint index, FUNCDESC* pFuncDesc);
    ///Specifies an inherited interface, or an interface implemented by a component object class (coclass).
    ///Params:
    ///    index = The index of the implementation class to be added. Specifies the order of the type relative to the other
    ///            type.
    ///    hRefType = A handle to the referenced type description obtained from the AddRefType description.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK </b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_INVALIDARG </b></dt> </dl> </td> <td width="60%"> One or more of the arguments is
    ///    not valid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY </b></dt> </dl> </td> <td width="60%">
    ///    Insufficient memory to complete the operation. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_ACCESSDENIED</b></dt> </dl> </td> <td width="60%"> Cannot write to the destination. </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>STG_E_INSUFFICIENTMEMORY </b></dt> </dl> </td> <td width="60%"> Insufficient
    ///    memory to complete the operation. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>TYPE_E_WRONGTYPEKIND</b></dt>
    ///    </dl> </td> <td width="60%"> Type mismatch. </td> </tr> </table>
    ///    
    HRESULT AddImplType(uint index, uint hRefType);
    ///Sets the attributes for an implemented or inherited interface of a type.
    ///Params:
    ///    index = The index of the interface for which to set type flags.
    ///    implTypeFlags = IMPLTYPE flags to be set.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK </b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_INVALIDARG </b></dt> </dl> </td> <td width="60%"> One or more of the arguments is
    ///    not valid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY </b></dt> </dl> </td> <td width="60%">
    ///    Insufficient memory to complete the operation. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_ACCESSDENIED</b></dt> </dl> </td> <td width="60%"> Cannot write to the destination. </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>STG_E_INSUFFICIENTMEMORY </b></dt> </dl> </td> <td width="60%"> Insufficient
    ///    memory to complete the operation. </td> </tr> </table>
    ///    
    HRESULT SetImplTypeFlags(uint index, int implTypeFlags);
    ///Specifies the data alignment for an item of TYPEKIND=TKIND_RECORD.
    ///Params:
    ///    cbAlignment = Alignment method for the type. A value of 0 indicates alignment on the 64K boundary; 1 indicates no special
    ///                  alignment. For other values, n indicates alignment on byte <i>n</i>.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK </b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_OUTOFMEMORY </b></dt> </dl> </td> <td width="60%"> Insufficient memory to complete
    ///    the operation. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_ACCESSDENIED</b></dt> </dl> </td> <td
    ///    width="60%"> Cannot write to the destination. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>STG_E_INSUFFICIENTMEMORY </b></dt> </dl> </td> <td width="60%"> Insufficient memory to complete the
    ///    operation. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>TYPE_E_INVALIDSTATE</b></dt> </dl> </td> <td
    ///    width="60%"> The state of the type library is not valid for this operation. </td> </tr> </table>
    ///    
    HRESULT SetAlignment(ushort cbAlignment);
    HRESULT SetSchema(ushort* pStrSchema);
    ///Adds a variable or data member description to the type description.
    ///Params:
    ///    index = The index of the variable or data member to be added to the type description.
    ///    pVarDesc = A pointer to the variable or data member description to be added.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK </b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_INVALIDARG </b></dt> </dl> </td> <td width="60%"> One or more of the arguments is
    ///    not valid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY </b></dt> </dl> </td> <td width="60%">
    ///    Insufficient memory to complete the operation. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_ACCESSDENIED</b></dt> </dl> </td> <td width="60%"> Cannot write to the destination. </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>STG_E_INSUFFICIENTMEMORY </b></dt> </dl> </td> <td width="60%"> Insufficient
    ///    memory to complete the operation. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>TYPE_E_WRONGTYPEKIND</b></dt>
    ///    </dl> </td> <td width="60%"> Type mismatch. </td> </tr> </table>
    ///    
    HRESULT AddVarDesc(uint index, VARDESC* pVarDesc);
    ///Sets the name of a function and the names of its parameters to the specified names.
    ///Params:
    ///    index = The index of the function whose function name and parameter names are to be set.
    ///    rgszNames = An array of pointers to names. The first element is the function name. Subsequent elements are names of
    ///                parameters.
    ///    cNames = The number of elements in the <i>rgszNames</i> array.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK </b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_INVALIDARG </b></dt> </dl> </td> <td width="60%"> One or more of the arguments is
    ///    not valid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY </b></dt> </dl> </td> <td width="60%">
    ///    Insufficient memory to complete the operation. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_ACCESSDENIED</b></dt> </dl> </td> <td width="60%"> Cannot write to the destination. </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>STG_E_INSUFFICIENTMEMORY </b></dt> </dl> </td> <td width="60%"> Insufficient
    ///    memory to complete the operation. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>TYPE_E_ELEMENTNOTFOUND</b></dt> </dl> </td> <td width="60%"> The element cannot be found. </td> </tr>
    ///    </table>
    ///    
    HRESULT SetFuncAndParamNames(uint index, char* rgszNames, uint cNames);
    ///Sets the name of a variable.
    ///Params:
    ///    index = The index of the variable.
    ///    szName = The name.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK </b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_OUTOFMEMORY </b></dt> </dl> </td> <td width="60%"> Insufficient memory to complete
    ///    the operation. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_ACCESSDENIED</b></dt> </dl> </td> <td
    ///    width="60%"> Cannot write to the destination. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>STG_E_INSUFFICIENTMEMORY </b></dt> </dl> </td> <td width="60%"> Insufficient memory to complete the
    ///    operation. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>TYPE_E_ELEMENTNOTFOUND</b></dt> </dl> </td> <td
    ///    width="60%"> The element cannot be found. </td> </tr> </table>
    ///    
    HRESULT SetVarName(uint index, ushort* szName);
    ///Sets the type description for which this type description is an alias, if TYPEKIND=TKIND_ALIAS.
    ///Params:
    ///    pTDescAlias = The type description.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK </b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_INVALIDARG </b></dt> </dl> </td> <td width="60%"> One or more of the arguments is
    ///    not valid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY </b></dt> </dl> </td> <td width="60%">
    ///    Insufficient memory to complete the operation. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_ACCESSDENIED</b></dt> </dl> </td> <td width="60%"> Cannot write to the destination. </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>STG_E_INSUFFICIENTMEMORY </b></dt> </dl> </td> <td width="60%"> Insufficient
    ///    memory to complete the operation. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>TYPE_E_WRONGTYPEKIND</b></dt>
    ///    </dl> </td> <td width="60%"> Type mismatch. </td> </tr> </table>
    ///    
    HRESULT SetTypeDescAlias(TYPEDESC* pTDescAlias);
    ///Associates a DLL entry point with the function that has the specified index.
    ///Params:
    ///    index = The index of the function.
    ///    szDllName = The name of the DLL that contains the entry point.
    ///    szProcName = The name of the entry point or an ordinal (if the high word is zero).
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK </b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_INVALIDARG </b></dt> </dl> </td> <td width="60%"> One or more of the arguments is
    ///    not valid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY </b></dt> </dl> </td> <td width="60%">
    ///    Insufficient memory to complete the operation. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>STG_E_INSUFFICIENTMEMORY </b></dt> </dl> </td> <td width="60%"> Insufficient memory to complete the
    ///    operation. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>TYPE_E_ELEMENTNOTFOUND</b></dt> </dl> </td> <td
    ///    width="60%"> The element cannot be found. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>TYPE_E_WRONGTYPEKIND</b></dt> </dl> </td> <td width="60%"> Type mismatch. </td> </tr> </table>
    ///    
    HRESULT DefineFuncAsDllEntry(uint index, ushort* szDllName, ushort* szProcName);
    ///Sets the documentation string for the function with the specified index.
    ///Params:
    ///    index = The index of the function.
    ///    szDocString = The documentation string.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK </b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_INVALIDARG </b></dt> </dl> </td> <td width="60%"> One or more of the arguments is
    ///    not valid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY </b></dt> </dl> </td> <td width="60%">
    ///    Insufficient memory to complete the operation. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_ACCESSDENIED</b></dt> </dl> </td> <td width="60%"> Cannot write to the destination. </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>STG_E_INSUFFICIENTMEMORY </b></dt> </dl> </td> <td width="60%"> Insufficient
    ///    memory to complete the operation. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>TYPE_E_ELEMENTNOTFOUND</b></dt> </dl> </td> <td width="60%"> The element cannot be found. </td> </tr>
    ///    </table>
    ///    
    HRESULT SetFuncDocString(uint index, ushort* szDocString);
    ///Sets the documentation string for the variable with the specified index.
    ///Params:
    ///    index = The index of the variable.
    ///    szDocString = The documentation string.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK </b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_OUTOFMEMORY </b></dt> </dl> </td> <td width="60%"> Insufficient memory to complete
    ///    the operation. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_ACCESSDENIED</b></dt> </dl> </td> <td
    ///    width="60%"> Cannot write to the destination. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>STG_E_INSUFFICIENTMEMORY </b></dt> </dl> </td> <td width="60%"> Insufficient memory to complete the
    ///    operation. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>TYPE_E_ELEMENTNOTFOUND</b></dt> </dl> </td> <td
    ///    width="60%"> The element cannot be found. </td> </tr> </table>
    ///    
    HRESULT SetVarDocString(uint index, ushort* szDocString);
    ///Sets the Help context ID for the function with the specified index.
    ///Params:
    ///    index = The index of the function.
    ///    dwHelpContext = The Help context ID for the Help topic.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK </b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_INVALIDARG </b></dt> </dl> </td> <td width="60%"> One or more of the arguments is
    ///    not valid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY </b></dt> </dl> </td> <td width="60%">
    ///    Insufficient memory to complete the operation. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_ACCESSDENIED</b></dt> </dl> </td> <td width="60%"> Cannot write to the destination. </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>STG_E_INSUFFICIENTMEMORY </b></dt> </dl> </td> <td width="60%"> Insufficient
    ///    memory to complete the operation. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>TYPE_E_ELEMENTNOTFOUND</b></dt> </dl> </td> <td width="60%"> The element cannot be found. </td> </tr>
    ///    </table>
    ///    
    HRESULT SetFuncHelpContext(uint index, uint dwHelpContext);
    ///Sets the Help context ID for the variable with the specified index.
    ///Params:
    ///    index = The index of the variable.
    ///    dwHelpContext = The handle to the Help context ID for the Help topic on the variable.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK </b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_OUTOFMEMORY </b></dt> </dl> </td> <td width="60%"> Insufficient memory to complete
    ///    the operation. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_ACCESSDENIED</b></dt> </dl> </td> <td
    ///    width="60%"> Cannot write to the destination. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>STG_E_INSUFFICIENTMEMORY </b></dt> </dl> </td> <td width="60%"> Insufficient memory to complete the
    ///    operation. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>TYPE_E_ELEMENTNOTFOUND</b></dt> </dl> </td> <td
    ///    width="60%"> The element cannot be found. </td> </tr> </table>
    ///    
    HRESULT SetVarHelpContext(uint index, uint dwHelpContext);
    ///Sets the marshaling opcode string associated with the type description or the function.
    ///Params:
    ///    index = The index of the member for which to set the opcode string. If index is –1, sets the opcode string for the
    ///            type description.
    ///    bstrMops = The marshaling opcode string.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK </b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_INVALIDARG </b></dt> </dl> </td> <td width="60%"> One or more of the arguments is
    ///    not valid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY </b></dt> </dl> </td> <td width="60%">
    ///    Insufficient memory to complete the operation. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_ACCESSDENIED</b></dt> </dl> </td> <td width="60%"> Cannot write to the destination. </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>STG_E_INSUFFICIENTMEMORY </b></dt> </dl> </td> <td width="60%"> Insufficient
    ///    memory to complete the operation. </td> </tr> </table>
    ///    
    HRESULT SetMops(uint index, BSTR bstrMops);
    HRESULT SetTypeIdldesc(IDLDESC* pIdlDesc);
    ///Assigns VTBL offsets for virtual functions and instance offsets for per-instance data members, and creates the
    ///two type descriptions for dual interfaces.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK </b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_OUTOFMEMORY </b></dt> </dl> </td> <td width="60%"> Insufficient memory to complete
    ///    the operation. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_ACCESSDENIED</b></dt> </dl> </td> <td
    ///    width="60%"> Cannot write to the destination. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>STG_E_INSUFFICIENTMEMORY </b></dt> </dl> </td> <td width="60%"> Insufficient memory to complete the
    ///    operation. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>TYPE_E_UNDEFINEDTYPE</b></dt> </dl> </td> <td
    ///    width="60%"> Bound to unrecognized type. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>TYPE_E_INVALIDSTATE</b></dt> </dl> </td> <td width="60%"> The state of the type library is not valid
    ///    for this operation. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>TYPE_E_WRONGTYPEKIND</b></dt> </dl> </td>
    ///    <td width="60%"> Type mismatch. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>TYPE_E_ELEMENTNOTFOUND</b></dt>
    ///    </dl> </td> <td width="60%"> The element cannot be found. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>TYPE_E_AMBIGUOUSNAME</b></dt> </dl> </td> <td width="60%"> More than one item exists with this name.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>TYPE_E_SIZETOOBIG</b></dt> </dl> </td> <td width="60%"> The
    ///    type information is too long. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>TYPE_E_TYPEMISMATCH</b></dt>
    ///    </dl> </td> <td width="60%"> Type mismatch. </td> </tr> </table>
    ///    
    HRESULT LayOut();
}

///Provides the tools for creating and administering the type information defined through the type description. Derives
///from ICreateTypeInfo, and adds methods for deleting items that have been added through ICreateTypeInfo. The
///ICreateTypeInfo::LayOut method provides a way for the creator of the type information to check for any errors. A call
///to QueryInterface can be made to the ICreateTypeInfo instance at any time for its ITypeInfo interface. Calling any of
///the methods in the ITypeInfointerface that require layout information lays out the type information automatically.
@GUID("0002040E-0000-0000-C000-000000000046")
interface ICreateTypeInfo2 : ICreateTypeInfo
{
    ///Deletes a function description specified by the index number.
    ///Params:
    ///    index = The index of the function whose description is to be deleted. The index should be in the range of 0 to 1 less
    ///            than the number of functions in this type.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK </b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_INVALIDARG </b></dt> </dl> </td> <td width="60%"> One or more of the arguments is
    ///    not valid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY </b></dt> </dl> </td> <td width="60%">
    ///    Insufficient memory to complete the operation. </td> </tr> </table>
    ///    
    HRESULT DeleteFuncDesc(uint index);
    ///Deletes the specified function description (FUNCDESC).
    ///Params:
    ///    memid = The member identifier of the FUNCDESC to delete.
    ///    invKind = The type of the invocation.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK </b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_INVALIDARG </b></dt> </dl> </td> <td width="60%"> One or more of the arguments is
    ///    not valid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY </b></dt> </dl> </td> <td width="60%">
    ///    Insufficient memory to complete the operation. </td> </tr> </table>
    ///    
    HRESULT DeleteFuncDescByMemId(int memid, INVOKEKIND invKind);
    ///Deletes the specified VARDESC structure.
    ///Params:
    ///    index = The index number of the VARDESC structure.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK </b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_INVALIDARG </b></dt> </dl> </td> <td width="60%"> One or more of the arguments is
    ///    not valid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY </b></dt> </dl> </td> <td width="60%">
    ///    Insufficient memory to complete the operation. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>TYPE_E_IOERROR</b></dt> </dl> </td> <td width="60%"> The function cannot read from the file. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>TYPE_E_INVDATAREAD</b></dt> </dl> </td> <td width="60%"> The function
    ///    cannot read from the file. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>TYPE_E_UNSUPFORMAT</b></dt> </dl>
    ///    </td> <td width="60%"> The type library has an old format. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>TYPE_E_INVALIDSTATE</b></dt> </dl> </td> <td width="60%"> The type library cannot be opened. </td>
    ///    </tr> </table>
    ///    
    HRESULT DeleteVarDesc(uint index);
    ///Deletes the specified VARDESC structure.
    ///Params:
    ///    memid = The member identifier of the VARDESC to be deleted.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK </b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_INVALIDARG </b></dt> </dl> </td> <td width="60%"> One or more of the arguments is
    ///    not valid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY </b></dt> </dl> </td> <td width="60%">
    ///    Insufficient memory to complete the operation. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>TYPE_E_IOERROR</b></dt> </dl> </td> <td width="60%"> The function cannot read from the file. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>TYPE_E_INVDATAREAD</b></dt> </dl> </td> <td width="60%"> The function
    ///    cannot read from the file. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>TYPE_E_UNSUPFORMAT</b></dt> </dl>
    ///    </td> <td width="60%"> The type library has an old format. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>TYPE_E_INVALIDSTATE</b></dt> </dl> </td> <td width="60%"> The type library cannot be opened. </td>
    ///    </tr> </table>
    ///    
    HRESULT DeleteVarDescByMemId(int memid);
    ///Deletes the IMPLTYPE flags for the indexed interface.
    ///Params:
    ///    index = The index of the interface for which to delete the type flags.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK </b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_INVALIDARG </b></dt> </dl> </td> <td width="60%"> One or more of the arguments is
    ///    not valid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY </b></dt> </dl> </td> <td width="60%">
    ///    Insufficient memory to complete the operation. </td> </tr> </table>
    ///    
    HRESULT DeleteImplType(uint index);
    ///Sets a value for custom data.
    ///Params:
    ///    guid = The unique identifier that can be used to identify the data.
    ///    pVarVal = The data to store (any variant except an object).
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK </b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_INVALIDARG </b></dt> </dl> </td> <td width="60%"> One or more of the arguments is
    ///    not valid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY </b></dt> </dl> </td> <td width="60%">
    ///    Insufficient memory to complete the operation. </td> </tr> </table>
    ///    
    HRESULT SetCustData(const(GUID)* guid, VARIANT* pVarVal);
    ///Sets a value for custom data for the specified function.
    ///Params:
    ///    index = The index of the function for which to set the custom data.
    ///    guid = The unique identifier used to identify the data.
    ///    pVarVal = The data to store (any variant except an object).
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK </b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_INVALIDARG </b></dt> </dl> </td> <td width="60%"> One or more of the arguments is
    ///    not valid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY </b></dt> </dl> </td> <td width="60%">
    ///    Insufficient memory to complete the operation. </td> </tr> </table>
    ///    
    HRESULT SetFuncCustData(uint index, const(GUID)* guid, VARIANT* pVarVal);
    ///Sets a value for the custom data for the specified parameter.
    ///Params:
    ///    indexFunc = The index of the function for which to set the custom data.
    ///    indexParam = The index of the parameter of the function for which to set the custom data.
    ///    guid = The globally unique identifier (GUID) used to identify the data.
    ///    pVarVal = The data to store (any variant except an object).
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK </b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_INVALIDARG </b></dt> </dl> </td> <td width="60%"> One or more of the arguments is
    ///    not valid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY </b></dt> </dl> </td> <td width="60%">
    ///    Insufficient memory to complete the operation. </td> </tr> </table>
    ///    
    HRESULT SetParamCustData(uint indexFunc, uint indexParam, const(GUID)* guid, VARIANT* pVarVal);
    ///Sets a value for custom data for the specified variable.
    ///Params:
    ///    index = The index of the variable for which to set the custom data.
    ///    guid = The globally unique ID (GUID) used to identify the data.
    ///    pVarVal = The data to store (any variant except an object).
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK </b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_INVALIDARG </b></dt> </dl> </td> <td width="60%"> One or more of the arguments is
    ///    not valid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY </b></dt> </dl> </td> <td width="60%">
    ///    Insufficient memory to complete the operation. </td> </tr> </table>
    ///    
    HRESULT SetVarCustData(uint index, const(GUID)* guid, VARIANT* pVarVal);
    ///Sets a value for custom data for the specified implementation type.
    ///Params:
    ///    index = The index of the variable for which to set the custom data.
    ///    guid = The unique identifier used to identify the data.
    ///    pVarVal = The data to store (any variant except an object).
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK </b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_INVALIDARG </b></dt> </dl> </td> <td width="60%"> One or more of the arguments is
    ///    not valid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY </b></dt> </dl> </td> <td width="60%">
    ///    Insufficient memory to complete the operation. </td> </tr> </table>
    ///    
    HRESULT SetImplTypeCustData(uint index, const(GUID)* guid, VARIANT* pVarVal);
    ///Sets the context number for the specified Help string.
    ///Params:
    ///    dwHelpStringContext = The Help string context number.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK </b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_INVALIDARG </b></dt> </dl> </td> <td width="60%"> One or more of the arguments is
    ///    not valid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY </b></dt> </dl> </td> <td width="60%">
    ///    Insufficient memory to complete the operation. </td> </tr> </table>
    ///    
    HRESULT SetHelpStringContext(uint dwHelpStringContext);
    ///Sets a Help context value for a specified function.
    ///Params:
    ///    index = The index of the function for which to set the help string context.
    ///    dwHelpStringContext = The Help string context for a localized string.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK </b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_INVALIDARG </b></dt> </dl> </td> <td width="60%"> One or more of the arguments is
    ///    not valid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY </b></dt> </dl> </td> <td width="60%">
    ///    Insufficient memory to complete the operation. </td> </tr> </table>
    ///    
    HRESULT SetFuncHelpStringContext(uint index, uint dwHelpStringContext);
    ///Sets a Help context value for a specified variable.
    ///Params:
    ///    index = The index of the variable.
    ///    dwHelpStringContext = The Help string context for a localized string.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK </b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_INVALIDARG </b></dt> </dl> </td> <td width="60%"> One or more of the arguments is
    ///    not valid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY </b></dt> </dl> </td> <td width="60%">
    ///    Insufficient memory to complete the operation. </td> </tr> </table>
    ///    
    HRESULT SetVarHelpStringContext(uint index, uint dwHelpStringContext);
    HRESULT Invalidate();
    ///Sets the name of the typeinfo.
    ///Params:
    ///    szName = The name to be assigned.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK </b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_INVALIDARG </b></dt> </dl> </td> <td width="60%"> One or more of the arguments is
    ///    not valid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY </b></dt> </dl> </td> <td width="60%">
    ///    Insufficient memory to complete the operation. </td> </tr> </table>
    ///    
    HRESULT SetName(ushort* szName);
}

///Provides the methods for creating and managing the component or file that contains type information. Type libraries
///are created from type descriptions using the MIDL compiler. These type libraries are accessed through the ITypeLib
///interface.
@GUID("00020406-0000-0000-C000-000000000046")
interface ICreateTypeLib : IUnknown
{
    ///Creates a new type description instance within the type library.
    ///Params:
    ///    szName = The name of the new type.
    ///    tkind = TYPEKIND of the type description to be created.
    ///    ppCTInfo = The type description.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One or more of the arguments is
    ///    not valid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%">
    ///    Insufficient memory to complete the operation. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>STG_E_INSUFFICIENTMEMORY</b></dt> </dl> </td> <td width="60%"> Insufficient memory to complete the
    ///    operation. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>TYPE_E_INVALIDSTATE</b></dt> </dl> </td> <td
    ///    width="60%"> The state of the type library is not valid for this operation. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>TYPE_E_NAMECONFLICT</b></dt> </dl> </td> <td width="60%"> The provided name is not unique. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>TYPE_E_WRONGTYPEKIND</b></dt> </dl> </td> <td width="60%"> Type
    ///    mismatch. </td> </tr> </table>
    ///    
    HRESULT CreateTypeInfo(ushort* szName, TYPEKIND tkind, ICreateTypeInfo* ppCTInfo);
    ///Sets the name of the type library.
    ///Params:
    ///    szName = The name to be assigned to the library.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One or more of the arguments is
    ///    not valid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%">
    ///    Insufficient memory to complete the operation. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>STG_E_INSUFFICIENTMEMORY</b></dt> </dl> </td> <td width="60%"> Insufficient memory to complete the
    ///    operation. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>TYPE_E_INVALIDSTATE</b></dt> </dl> </td> <td
    ///    width="60%"> The state of the type library is not valid for this operation. </td> </tr> </table>
    ///    
    HRESULT SetName(ushort* szName);
    ///Sets the major and minor version numbers of the type library.
    ///Params:
    ///    wMajorVerNum = The major version number for the library.
    ///    wMinorVerNum = The minor version number for the library.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>TYPE_E_INVALIDSTATE</b></dt> </dl> </td> <td width="60%"> The state of the type
    ///    library is not valid for this operation. </td> </tr> </table>
    ///    
    HRESULT SetVersion(ushort wMajorVerNum, ushort wMinorVerNum);
    ///Sets the universal unique identifier (UUID) associated with the type library (Also known as the globally unique
    ///identifier (GUID)).
    ///Params:
    ///    guid = The globally unique identifier to be assigned to the library.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One or more of the arguments is
    ///    not valid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%">
    ///    Insufficient memory to complete the operation. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>STG_E_INSUFFICIENTMEMORY</b></dt> </dl> </td> <td width="60%"> Insufficient memory to complete the
    ///    operation. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>TYPE_E_INVALIDSTATE</b></dt> </dl> </td> <td
    ///    width="60%"> The state of the type library is not valid for this operation. </td> </tr> </table>
    ///    
    HRESULT SetGuid(const(GUID)* guid);
    ///Sets the documentation string associated with the library.
    ///Params:
    ///    szDoc = A brief description of the type library.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One or more of the arguments is
    ///    not valid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%">
    ///    Insufficient memory to complete the operation. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>STG_E_INSUFFICIENTMEMORY</b></dt> </dl> </td> <td width="60%"> Insufficient memory to complete the
    ///    operation. </td> </tr> </table>
    ///    
    HRESULT SetDocString(ushort* szDoc);
    ///Sets the name of the Help file.
    ///Params:
    ///    szHelpFileName = The name of the Help file for the library.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One or more of the arguments is
    ///    not valid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%">
    ///    Insufficient memory to complete the operation. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>STG_E_INSUFFICIENTMEMORY</b></dt> </dl> </td> <td width="60%"> Insufficient memory to complete the
    ///    operation. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>TYPE_E_INVALIDSTATE</b></dt> </dl> </td> <td
    ///    width="60%"> The state of the type library is not valid for this operation. </td> </tr> </table>
    ///    
    HRESULT SetHelpFileName(ushort* szHelpFileName);
    ///Sets the Help context ID for retrieving general Help information for the type library.
    ///Params:
    ///    dwHelpContext = The Help context ID.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One or more of the arguments is
    ///    not valid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%">
    ///    Insufficient memory to complete the operation. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>STG_E_INSUFFICIENTMEMORY</b></dt> </dl> </td> <td width="60%"> Insufficient memory to complete the
    ///    operation. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>TYPE_E_INVALIDSTATE</b></dt> </dl> </td> <td
    ///    width="60%"> The state of the type library is not valid for this operation. </td> </tr> </table>
    ///    
    HRESULT SetHelpContext(uint dwHelpContext);
    ///Sets the binary Microsoft national language ID associated with the library.
    ///Params:
    ///    lcid = The locale ID for the type library.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One or more of the arguments is
    ///    not valid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%">
    ///    Insufficient memory to complete the operation. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>STG_E_INSUFFICIENTMEMORY</b></dt> </dl> </td> <td width="60%"> Insufficient memory to complete the
    ///    operation. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>TYPE_E_INVALIDSTATE</b></dt> </dl> </td> <td
    ///    width="60%"> The state of the type library is not valid for this operation. </td> </tr> </table>
    ///    
    HRESULT SetLcid(uint lcid);
    ///Sets library flags.
    ///Params:
    ///    uLibFlags = The flags to set.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One or more of the arguments is
    ///    not valid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%">
    ///    Insufficient memory to complete the operation. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>STG_E_INSUFFICIENTMEMORY</b></dt> </dl> </td> <td width="60%"> Insufficient memory to complete the
    ///    operation. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>TYPE_E_INVALIDSTATE</b></dt> </dl> </td> <td
    ///    width="60%"> The state of the type library is not valid for this operation. </td> </tr> </table>
    ///    
    HRESULT SetLibFlags(uint uLibFlags);
    ///Saves the ICreateTypeLib instance following the layout of type information.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One or more of the arguments is
    ///    not valid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%">
    ///    Insufficient memory to complete the operation. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>STG_E_INSUFFICIENTMEMORY</b></dt> </dl> </td> <td width="60%"> Insufficient memory to complete the
    ///    operation. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>TYPE_E_IOERROR</b></dt> </dl> </td> <td width="60%">
    ///    The function cannot write to the file. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>TYPE_E_INVALIDSTATE</b></dt> </dl> </td> <td width="60%"> The state of the type library is not valid
    ///    for this operation. </td> </tr> </table>
    ///    
    HRESULT SaveAllChanges();
}

///Provides the methods for creating and managing the component or file that contains type information. Derives from
///ICreateTypeLib. The ICreateTypeInfo instance returned from <b>ICreateTypeLib</b> can be accessed through a
///<b>QueryInterface</b> call to ICreateTypeInfo2.
@GUID("0002040F-0000-0000-C000-000000000046")
interface ICreateTypeLib2 : ICreateTypeLib
{
    ///Deletes a specified type information from the type library.
    ///Params:
    ///    szName = The name of the type information to remove.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One or more of the arguments is
    ///    not valid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%">
    ///    Insufficient memory to complete the operation. </td> </tr> </table>
    ///    
    HRESULT DeleteTypeInfo(ushort* szName);
    ///Sets a value to custom data.
    ///Params:
    ///    guid = The unique identifier for the data.
    ///    pVarVal = The data to store (any variant except an object).
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One or more of the arguments is
    ///    not valid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%">
    ///    Insufficient memory to complete the operation. </td> </tr> </table>
    ///    
    HRESULT SetCustData(const(GUID)* guid, VARIANT* pVarVal);
    ///Sets the Help string context number.
    ///Params:
    ///    dwHelpStringContext = The Help string context number.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One or more of the arguments is
    ///    not valid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%">
    ///    Insufficient memory to complete the operation. </td> </tr> </table>
    ///    
    HRESULT SetHelpStringContext(uint dwHelpStringContext);
    ///Sets the DLL name to be used for Help string lookup (for localization purposes).
    ///Params:
    ///    szFileName = The DLL file name.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One or more of the arguments is
    ///    not valid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%">
    ///    Insufficient memory to complete the operation. </td> </tr> </table>
    ///    
    HRESULT SetHelpStringDll(ushort* szFileName);
}

///Exposes objects, methods and properties to programming tools and other applications that support Automation. COM
///components implement the <b>IDispatch</b> interface to enable access by Automation clients, such as Visual Basic.
@GUID("00020400-0000-0000-C000-000000000046")
interface IDispatch : IUnknown
{
    ///Retrieves the number of type information interfaces that an object provides (either 0 or 1).
    ///Params:
    ///    pctinfo = The number of type information interfaces provided by the object. If the object provides type information,
    ///              this number is 1; otherwise the number is 0.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_NOTIMPL </b></dt> </dl> </td> <td width="60%"> Failure. </td> </tr> </table>
    ///    
    HRESULT GetTypeInfoCount(uint* pctinfo);
    ///Retrieves the type information for an object, which can then be used to get the type information for an
    ///interface.
    ///Params:
    ///    iTInfo = The type information to return. Pass 0 to retrieve type information for the IDispatch implementation.
    ///    lcid = The locale identifier for the type information. An object may be able to return different type information
    ///           for different languages. This is important for classes that support localized member names. For classes that
    ///           do not support localized member names, this parameter can be ignored.
    ///    ppTInfo = The requested type information object.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>DISP_E_BADINDEX </b></dt> </dl> </td> <td width="60%"> The <i>iTInfo</i> parameter
    ///    was not 0. </td> </tr> </table>
    ///    
    HRESULT GetTypeInfo(uint iTInfo, uint lcid, ITypeInfo* ppTInfo);
    ///Maps a single member and an optional set of argument names to a corresponding set of integer DISPIDs, which can
    ///be used on subsequent calls to Invoke. The dispatch function DispGetIDsOfNames provides a standard implementation
    ///of <b>GetIDsOfNames</b>.
    ///Params:
    ///    riid = Reserved for future use. Must be IID_NULL.
    ///    rgszNames = The array of names to be mapped.
    ///    cNames = The count of the names to be mapped.
    ///    lcid = The locale context in which to interpret the names.
    ///    rgDispId = Caller-allocated array, each element of which contains an identifier (ID) corresponding to one of the names
    ///               passed in the rgszNames array. The first element represents the member name. The subsequent elements
    ///               represent each of the member's parameters.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Out of memory. </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>DISP_E_UNKNOWNNAME</b></dt> </dl> </td> <td width="60%"> One or more of the
    ///    specified names were not known. The returned array of DISPIDs contains DISPID_UNKNOWN for each entry that
    ///    corresponds to an unknown name. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>DISP_E_UNKNOWNLCID</b></dt>
    ///    </dl> </td> <td width="60%"> The locale identifier (LCID) was not recognized. </td> </tr> </table>
    ///    
    HRESULT GetIDsOfNames(const(GUID)* riid, char* rgszNames, uint cNames, uint lcid, char* rgDispId);
    ///Provides access to properties and methods exposed by an object. The dispatch function DispInvoke provides a
    ///standard implementation of <b>Invoke</b>.
    ///Params:
    ///    dispIdMember = Identifies the member. Use GetIDsOfNames or the object's documentation to obtain the dispatch identifier.
    ///    riid = Reserved for future use. Must be IID_NULL.
    ///    lcid = The locale context in which to interpret arguments. The <i>lcid</i> is used by the GetIDsOfNames function,
    ///           and is also passed to <b>Invoke</b> to allow the object to interpret its arguments specific to a locale.
    ///           Applications that do not support multiple national languages can ignore this parameter. For more information,
    ///           refer to Supporting Multiple National Languages and Exposing ActiveX Objects.
    ///    wFlags = Flags describing the context of the <b>Invoke</b> call. <table> <tr> <th>Value</th> <th>Meaning</th> </tr>
    ///             <tr> <td width="40%"><a id="DISPATCH_METHOD"></a><a id="dispatch_method"></a><dl>
    ///             <dt><b>DISPATCH_METHOD</b></dt> </dl> </td> <td width="60%"> The member is invoked as a method. If a property
    ///             has the same name, both this and the DISPATCH_PROPERTYGET flag can be set. </td> </tr> <tr> <td
    ///             width="40%"><a id="DISPATCH_PROPERTYGET"></a><a id="dispatch_propertyget"></a><dl>
    ///             <dt><b>DISPATCH_PROPERTYGET</b></dt> </dl> </td> <td width="60%"> The member is retrieved as a property or
    ///             data member. </td> </tr> <tr> <td width="40%"><a id="DISPATCH_PROPERTYPUT"></a><a
    ///             id="dispatch_propertyput"></a><dl> <dt><b>DISPATCH_PROPERTYPUT</b></dt> </dl> </td> <td width="60%"> The
    ///             member is changed as a property or data member. </td> </tr> <tr> <td width="40%"><a
    ///             id="DISPATCH_PROPERTYPUTREF"></a><a id="dispatch_propertyputref"></a><dl>
    ///             <dt><b>DISPATCH_PROPERTYPUTREF</b></dt> </dl> </td> <td width="60%"> The member is changed by a reference
    ///             assignment, rather than a value assignment. This flag is valid only when the property accepts a reference to
    ///             an object. </td> </tr> </table>
    ///    pDispParams = Pointer to a DISPPARAMS structure containing an array of arguments, an array of argument DISPIDs for named
    ///                  arguments, and counts for the number of elements in the arrays.
    ///    pVarResult = Pointer to the location where the result is to be stored, or NULL if the caller expects no result. This
    ///                 argument is ignored if DISPATCH_PROPERTYPUT or DISPATCH_PROPERTYPUTREF is specified.
    ///    pExcepInfo = Pointer to a structure that contains exception information. This structure should be filled in if
    ///                 DISP_E_EXCEPTION is returned. Can be NULL.
    ///    puArgErr = The index within rgvarg of the first argument that has an error. Arguments are stored in
    ///               pDispParams-&gt;rgvarg in reverse order, so the first argument is the one with the highest index in the
    ///               array. This parameter is returned only when the resulting return value is DISP_E_TYPEMISMATCH or
    ///               DISP_E_PARAMNOTFOUND. This argument can be set to null. For details, see Returning Errors.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>DISP_E_BADPARAMCOUNT</b></dt> </dl> </td> <td width="60%"> The number of elements
    ///    provided to DISPPARAMS is different from the number of arguments accepted by the method or property. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>DISP_E_BADVARTYPE</b></dt> </dl> </td> <td width="60%"> One of the
    ///    arguments in DISPPARAMS is not a valid variant type. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>DISP_E_EXCEPTION</b></dt> </dl> </td> <td width="60%"> The application needs to raise an exception. In
    ///    this case, the structure passed in <i>pexcepinfo</i> should be filled in. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>DISP_E_MEMBERNOTFOUND</b></dt> </dl> </td> <td width="60%"> The requested member does not exist.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>DISP_E_NONAMEDARGS</b></dt> </dl> </td> <td width="60%"> This
    ///    implementation of IDispatch does not support named arguments. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>DISP_E_OVERFLOW</b></dt> </dl> </td> <td width="60%"> One of the arguments in DISPPARAMS could not be
    ///    coerced to the specified type. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>DISP_E_PARAMNOTFOUND</b></dt>
    ///    </dl> </td> <td width="60%"> One of the parameter IDs does not correspond to a parameter on the method. In
    ///    this case, <i>puArgErr</i> is set to the first argument that contains the error. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>DISP_E_TYPEMISMATCH</b></dt> </dl> </td> <td width="60%"> One or more of the
    ///    arguments could not be coerced. The index of the first parameter with the incorrect type within rgvarg is
    ///    returned in <i>puArgErr</i>. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>DISP_E_UNKNOWNINTERFACE </b></dt>
    ///    </dl> </td> <td width="60%"> The interface identifier passed in riid is not IID_NULL. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>DISP_E_UNKNOWNLCID </b></dt> </dl> </td> <td width="60%"> The member being invoked
    ///    interprets string arguments according to the LCID, and the LCID is not recognized. If the LCID is not needed
    ///    to interpret arguments, this error should not be returned </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>DISP_E_PARAMNOTOPTIONAL</b></dt> </dl> </td> <td width="60%"> A required parameter was omitted. </td>
    ///    </tr> </table>
    ///    
    HRESULT Invoke(int dispIdMember, const(GUID)* riid, uint lcid, ushort wFlags, DISPPARAMS* pDispParams, 
                   VARIANT* pVarResult, EXCEPINFO* pExcepInfo, uint* puArgErr);
}

///Provides a method for enumerating a collection of variants, including heterogeneous collections of objects and
///intrinsic types. Callers of this interface do not need to know the specific type (or types) of the elements in the
///collection.
@GUID("00020404-0000-0000-C000-000000000046")
interface IEnumVARIANT : IUnknown
{
    ///Retrieves the specified items in the enumeration sequence.
    ///Params:
    ///    celt = The number of elements to be retrieved
    ///    rgVar = An array of at least size <i>celt</i> in which the elements are to be returned.
    ///    pCeltFetched = The number of elements returned in <i>rgVar</i>, or NULL.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The number of elements returned is
    ///    <i>celt</i>. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>S_FALSE</b></dt> </dl> </td> <td width="60%"> The
    ///    number of elements returned is less than <i>celt</i>. </td> </tr> </table>
    ///    
    HRESULT Next(uint celt, VARIANT* rgVar, uint* pCeltFetched);
    ///Attempts to skip over the next celt elements in the enumeration sequence.
    ///Params:
    ///    celt = The number of elements to skip.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The specified number of elements was
    ///    skipped. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>S_FALSE</b></dt> </dl> </td> <td width="60%"> The end
    ///    of the sequence was reached before skipping the requested number of elements. </td> </tr> </table>
    ///    
    HRESULT Skip(uint celt);
    ///Resets the enumeration sequence to the beginning.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_FALSE</b></dt> </dl> </td> <td width="60%"> Failure. </td> </tr> </table>
    ///    
    HRESULT Reset();
    ///Creates a copy of the current state of enumeration.
    ///Params:
    ///    ppEnum = The clone enumerator.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_OUTOFMEMORY </b></dt> </dl> </td> <td width="60%"> Insufficient memory to complete
    ///    the operation. </td> </tr> </table>
    ///    
    HRESULT Clone(IEnumVARIANT* ppEnum);
}

///The <b>ITypeComp</b> interface provides a fast way to access information that compilers need when binding to and
///instantiating structures and interfaces. Binding is the process of mapping names to types and type members.
@GUID("00020403-0000-0000-C000-000000000046")
interface ITypeComp : IUnknown
{
    ///Maps a name to a member of a type, or binds global variables and functions contained in a type library.
    ///Params:
    ///    szName = The name to be bound.
    ///    lHashVal = The hash value for the name computed by LHashValOfNameSys.
    ///    wFlags = One or more of the flags defined in the INVOKEKIND enumeration. Specifies whether the name was referenced as
    ///             a method or a property. When binding to a variable, specify the flag INVOKE_PROPERTYGET. Specify zero to bind
    ///             to any type of member.
    ///    ppTInfo = If a FUNCDESC or VARDESC was returned, then <i>ppTInfo</i> points to a pointer to the type description that
    ///              contains the item to which it is bound.
    ///    pDescKind = Indicates whether the name bound to is a VARDESC, FUNCDESC, or TYPECOMP. If there was no match,
    ///                DESCKIND_NONE.
    ///    pBindPtr = The bound-to VARDESC, FUNCDESC, or ITypeComp interface.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK </b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_INVALIDARG </b></dt> </dl> </td> <td width="60%"> One or more of the arguments is
    ///    not valid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY </b></dt> </dl> </td> <td width="60%">
    ///    Insufficient memory to complete the operation. </td> </tr> </table>
    ///    
    HRESULT Bind(ushort* szName, uint lHashVal, ushort wFlags, ITypeInfo* ppTInfo, DESCKIND* pDescKind, 
                 BINDPTR* pBindPtr);
    ///Binds to the type descriptions contained within a type library.
    ///Params:
    ///    szName = The name to be bound.
    ///    lHashVal = The hash value for the name computed by LHashValOfName.
    ///    ppTInfo = An ITypeInfo of the type to which the name was bound.
    ///    ppTComp = Passes a valid pointer, such as the address of an ITypeComp variable.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK </b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_INVALIDARG </b></dt> </dl> </td> <td width="60%"> One or more of the arguments is
    ///    not valid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY </b></dt> </dl> </td> <td width="60%">
    ///    Insufficient memory to complete the operation. </td> </tr> </table>
    ///    
    HRESULT BindType(ushort* szName, uint lHashVal, ITypeInfo* ppTInfo, ITypeComp* ppTComp);
}

///This section describes <b>ITypeInfo</b>, an interface typically used for reading information about objects. For
///example, an object browser tool can use <b>ITypeInfo</b> to extract information about the characteristics and
///capabilities of objects from type libraries.
@GUID("00020401-0000-0000-C000-000000000046")
interface ITypeInfo : IUnknown
{
    ///Retrieves a TYPEATTR structure that contains the attributes of the type description.
    ///Params:
    ///    ppTypeAttr = The attributes of this type description.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK </b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_INVALIDARG </b></dt> </dl> </td> <td width="60%"> One or more of the arguments is
    ///    not valid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY </b></dt> </dl> </td> <td width="60%">
    ///    Insufficient memory to complete the operation. </td> </tr> </table>
    ///    
    HRESULT GetTypeAttr(TYPEATTR** ppTypeAttr);
    ///Retrieves the ITypeComp interface for the type description, which enables a client compiler to bind to the type
    ///description's members.
    ///Params:
    ///    ppTComp = The ITypeComp of the containing type library.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK </b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_INVALIDARG </b></dt> </dl> </td> <td width="60%"> One or more of the arguments is
    ///    not valid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY </b></dt> </dl> </td> <td width="60%">
    ///    Insufficient memory to complete the operation. </td> </tr> </table>
    ///    
    HRESULT GetTypeComp(ITypeComp* ppTComp);
    ///Retrieves the FUNCDESC structure that contains information about a specified function.
    ///Params:
    ///    index = The index of the function whose description is to be returned. The <i>index</i> should be in the range of 0
    ///            to 1 less than the number of functions in this type.
    ///    ppFuncDesc = A FUNCDESC structure that describes the specified function.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK </b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_INVALIDARG </b></dt> </dl> </td> <td width="60%"> One or more of the arguments is
    ///    not valid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY </b></dt> </dl> </td> <td width="60%">
    ///    Insufficient memory to complete the operation. </td> </tr> </table>
    ///    
    HRESULT GetFuncDesc(uint index, FUNCDESC** ppFuncDesc);
    ///Retrieves a VARDESC structure that describes the specified variable.
    ///Params:
    ///    index = The index of the variable whose description is to be returned. The index should be in the range of 0 to 1
    ///            less than the number of variables in this type.
    ///    ppVarDesc = A VARDESC that describes the specified variable.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK </b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_INVALIDARG </b></dt> </dl> </td> <td width="60%"> One or more of the arguments is
    ///    not valid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY </b></dt> </dl> </td> <td width="60%">
    ///    Insufficient memory to complete the operation. </td> </tr> </table>
    ///    
    HRESULT GetVarDesc(uint index, VARDESC** ppVarDesc);
    ///Retrieves the variable with the specified member ID or the name of the property or method and the parameters that
    ///correspond to the specified function ID.
    ///Params:
    ///    memid = The ID of the member whose name (or names) is to be returned.
    ///    rgBstrNames = The caller-allocated array. On return, each of the elements contains the name (or names) associated with the
    ///                  member.
    ///    cMaxNames = The length of the passed-in <i>rgBstrNames</i> array.
    ///    pcNames = The number of names in the <i>rgBstrNames</i> array.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK </b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_INVALIDARG </b></dt> </dl> </td> <td width="60%"> One or more of the arguments is
    ///    not valid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY </b></dt> </dl> </td> <td width="60%">
    ///    Insufficient memory to complete the operation. </td> </tr> </table>
    ///    
    HRESULT GetNames(int memid, char* rgBstrNames, uint cMaxNames, uint* pcNames);
    ///If a type description describes a COM class, it retrieves the type description of the implemented interface
    ///types. For an interface, <b>GetRefTypeOfImplType</b> returns the type information for inherited interfaces, if
    ///any exist.
    ///Params:
    ///    index = The index of the implemented type whose handle is returned. The valid range is 0 to the <b>cImplTypes</b>
    ///            field in the TYPEATTR structure.
    ///    pRefType = A handle for the implemented interface (if any). This handle can be passed to ITypeInfo::GetRefTypeInfo to
    ///               get the type description.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK </b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_INVALIDARG </b></dt> </dl> </td> <td width="60%"> One or more of the arguments is
    ///    not valid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>TYPE_E_ELEMENTNOTFOUND </b></dt> </dl> </td> <td
    ///    width="60%"> Passed index is outside the range 0 to 1 less than the number of function descriptions. </td>
    ///    </tr> </table>
    ///    
    HRESULT GetRefTypeOfImplType(uint index, uint* pRefType);
    ///Retrieves the IMPLTYPEFLAGS enumeration for one implemented interface or base interface in a type description.
    ///Params:
    ///    index = The index of the implemented interface or base interface for which to get the flags.
    ///    pImplTypeFlags = The IMPLTYPEFLAGS enumeration value.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK </b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_INVALIDARG </b></dt> </dl> </td> <td width="60%"> One or more of the arguments is
    ///    not valid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY </b></dt> </dl> </td> <td width="60%">
    ///    Insufficient memory to complete the operation. </td> </tr> </table>
    ///    
    HRESULT GetImplTypeFlags(uint index, int* pImplTypeFlags);
    ///Maps between member names and member IDs, and parameter names and parameter IDs.
    ///Params:
    ///    rgszNames = An array of names to be mapped.
    ///    cNames = The count of the names to be mapped.
    ///    pMemId = Caller-allocated array in which name mappings are placed.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK </b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_INVALIDARG </b></dt> </dl> </td> <td width="60%"> One or more of the arguments is
    ///    not valid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY </b></dt> </dl> </td> <td width="60%">
    ///    Insufficient memory to complete the operation. </td> </tr> </table>
    ///    
    HRESULT GetIDsOfNames(char* rgszNames, uint cNames, int* pMemId);
    ///Invokes a method, or accesses a property of an object, that implements the interface described by the type
    ///description.
    ///Params:
    ///    pvInstance = An instance of the interface described by this type description.
    ///    memid = The interface member.
    ///    wFlags = Flags describing the context of the invoke call. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td
    ///             width="40%"><a id="DISPATCH_METHOD"></a><a id="dispatch_method"></a><dl> <dt><b>DISPATCH_METHOD</b></dt>
    ///             </dl> </td> <td width="60%"> The member is accessed as a method. If there is ambiguity, both this and the
    ///             DISPATCH_PROPERTYGET flag can be set. </td> </tr> <tr> <td width="40%"><a id="DISPATCH_PROPERTYGET"></a><a
    ///             id="dispatch_propertyget"></a><dl> <dt><b>DISPATCH_PROPERTYGET</b></dt> </dl> </td> <td width="60%"> The
    ///             member is retrieved as a property or data member. </td> </tr> <tr> <td width="40%"><a
    ///             id="DISPATCH_PROPERTYPUT"></a><a id="dispatch_propertyput"></a><dl> <dt><b>DISPATCH_PROPERTYPUT</b></dt>
    ///             </dl> </td> <td width="60%"> The member is changed as a property or data member. </td> </tr> <tr> <td
    ///             width="40%"><a id="DISPATCH_PROPERTYPUTREF"></a><a id="dispatch_propertyputref"></a><dl>
    ///             <dt><b>DISPATCH_PROPERTYPUTREF</b></dt> </dl> </td> <td width="60%"> The member is changed by using a
    ///             reference assignment, rather than a value assignment. This flag is valid only when the property accepts a
    ///             reference to an object. </td> </tr> </table>
    ///    pDispParams = An array of arguments, an array of DISPIDs for named arguments, and counts of the number of elements in each
    ///                  array.
    ///    pVarResult = The result. Should be null if the caller does not expect any result. If <i>wFlags</i> specifies
    ///                 DISPATCH_PROPERTYPUT or DISPATCH_PROPERTYPUTREF, <i>pVarResultis</i> is ignored.
    ///    pExcepInfo = An exception information structure, which is filled in only if DISP_E_EXCEPTION is returned. If
    ///                 <i>pExcepInfo</i> is null on input, only an HRESULT error will be returned.
    ///    puArgErr = If Invoke returns DISP_E_TYPEMISMATCH, <i>puArgErr</i> indicates the index (within <i>rgvarg</i>) of the
    ///               argument with incorrect type. If more than one argument returns an error, <i>puArgErr</i> indicates only the
    ///               first argument with an error. Arguments in pDispParams-&gt;rgvarg appear in reverse order, so the first
    ///               argument is the one having the highest index in the array. This parameter cannot be null.
    ///Returns:
    ///    <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK </b></dt>
    ///    </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG </b></dt>
    ///    </dl> </td> <td width="60%"> One or more of the arguments is not valid. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>DISP_E_EXCEPTION </b></dt> </dl> </td> <td width="60%"> The member being invoked has returned an
    ///    error HRESULT. If the member implements IErrorInfo, details are available in the error object. Otherwise, the
    ///    <i>pExcepInfo</i> parameter contains details. </td> </tr> </table> Any of the IDispatch::Invoke errors may
    ///    also be returned.
    ///    
    HRESULT Invoke(void* pvInstance, int memid, ushort wFlags, DISPPARAMS* pDispParams, VARIANT* pVarResult, 
                   EXCEPINFO* pExcepInfo, uint* puArgErr);
    ///Retrieves the documentation string, the complete Help file name and path, and the context ID for the Help topic
    ///for a specified type description.
    ///Params:
    ///    memid = The ID of the member whose documentation is to be returned.
    ///    pBstrName = The name of the specified item. If the caller does not need the item name, <i>pBstrName</i> can be null.
    ///    pBstrDocString = The documentation string for the specified item. If the caller does not need the documentation string,
    ///                     <i>pBstrDocString</i> can be null.
    ///    pdwHelpContext = The Help localization context. If the caller does not need the Help context, it can be null.
    ///    pBstrHelpFile = The fully qualified name of the file containing the DLL used for Help file. If the caller does not need the
    ///                    file name, it can be null.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK </b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_INVALIDARG </b></dt> </dl> </td> <td width="60%"> One or more of the arguments is
    ///    not valid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY </b></dt> </dl> </td> <td width="60%">
    ///    Insufficient memory to complete the operation. </td> </tr> </table>
    ///    
    HRESULT GetDocumentation(int memid, BSTR* pBstrName, BSTR* pBstrDocString, uint* pdwHelpContext, 
                             BSTR* pBstrHelpFile);
    ///Retrieves a description or specification of an entry point for a function in a DLL.
    ///Params:
    ///    memid = The ID of the member function whose DLL entry description is to be returned.
    ///    invKind = The kind of member identified by <i>memid</i>. This is important for properties, because one <i>memid</i> can
    ///              identify up to three separate functions.
    ///    pBstrDllName = If not null, the function sets <i>pBstrDllName</i> to the name of the DLL.
    ///    pBstrName = If not null, the function sets <i>pBstrName</i> to the name of the entry point. If the entry point is
    ///                specified by an ordinal, this argument is null.
    ///    pwOrdinal = If not null, and if the function is defined by an ordinal, the function sets <i>pwOrdinal</i> to the ordinal.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK </b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_INVALIDARG </b></dt> </dl> </td> <td width="60%"> One or more of the arguments is
    ///    not valid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY </b></dt> </dl> </td> <td width="60%">
    ///    Insufficient memory to complete the operation. </td> </tr> </table>
    ///    
    HRESULT GetDllEntry(int memid, INVOKEKIND invKind, BSTR* pBstrDllName, BSTR* pBstrName, ushort* pwOrdinal);
    ///If a type description references other type descriptions, it retrieves the referenced type descriptions.
    ///Params:
    ///    hRefType = A handle to the referenced type description to return.
    ///    ppTInfo = The referenced type description.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK </b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_INVALIDARG </b></dt> </dl> </td> <td width="60%"> One or more of the arguments is
    ///    not valid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY </b></dt> </dl> </td> <td width="60%">
    ///    Insufficient memory to complete the operation. </td> </tr> </table>
    ///    
    HRESULT GetRefTypeInfo(uint hRefType, ITypeInfo* ppTInfo);
    ///Retrieves the addresses of static functions or variables, such as those defined in a DLL.
    ///Params:
    ///    memid = The member ID of the static member whose address is to be retrieved. The member ID is defined by the DISPID.
    ///    invKind = Indicates whether the member is a property, and if so, what kind.
    ///    ppv = The static member.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK </b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_INVALIDARG </b></dt> </dl> </td> <td width="60%"> One or more of the arguments is
    ///    not valid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY </b></dt> </dl> </td> <td width="60%">
    ///    Insufficient memory to complete the operation. </td> </tr> </table>
    ///    
    HRESULT AddressOfMember(int memid, INVOKEKIND invKind, void** ppv);
    ///Creates a new instance of a type that describes a component object class (coclass).
    ///Params:
    ///    pUnkOuter = The controlling <b>IUnknown</b>. If Null, then a stand-alone instance is created. If valid, then an aggregate
    ///                object is created.
    ///    riid = An ID for the interface that the caller will use to communicate with the resulting object.
    ///    ppvObj = An instance of the created object.
    ///Returns:
    ///    <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK </b></dt>
    ///    </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG </b></dt>
    ///    </dl> </td> <td width="60%"> One or more of the arguments is not valid. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_OUTOFMEMORY </b></dt> </dl> </td> <td width="60%"> Insufficient memory to complete the
    ///    operation. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_NOINTERFACE</b></dt> </dl> </td> <td width="60%">
    ///    OLE could not find an implementation of one or more required interfaces. </td> </tr> </table> Additional
    ///    errors may be returned from GetActiveObject or <b>CoCreateInstance</b>.
    ///    
    HRESULT CreateInstance(IUnknown pUnkOuter, const(GUID)* riid, void** ppvObj);
    ///Retrieves marshaling information.
    ///Params:
    ///    memid = The member ID that indicates which marshaling information is needed.
    ///    pBstrMops = The opcode string used in marshaling the fields of the structure described by the referenced type
    ///                description, or null if there is no information to return.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK </b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_INVALIDARG </b></dt> </dl> </td> <td width="60%"> One or more of the arguments is
    ///    not valid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY </b></dt> </dl> </td> <td width="60%">
    ///    Insufficient memory to complete the operation. </td> </tr> </table>
    ///    
    HRESULT GetMops(int memid, BSTR* pBstrMops);
    ///Retrieves the containing type library and the index of the type description within that type library.
    ///Params:
    ///    ppTLib = The containing type library.
    ///    pIndex = The index of the type description within the containing type library.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK </b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_INVALIDARG </b></dt> </dl> </td> <td width="60%"> One or more of the arguments is
    ///    not valid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY </b></dt> </dl> </td> <td width="60%">
    ///    Insufficient memory to complete the operation. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_NOINTERFACE</b></dt> </dl> </td> <td width="60%"> OLE could not find an implementation of one or
    ///    more required interfaces. </td> </tr> </table>
    ///    
    HRESULT GetContainingTypeLib(ITypeLib* ppTLib, uint* pIndex);
    ///Releases a TYPEATTR previously returned by ITypeInfo::GetTypeAttr.
    ///Params:
    ///    pTypeAttr = The TYPEATTR to be freed.
    void    ReleaseTypeAttr(TYPEATTR* pTypeAttr);
    ///Releases a FUNCDESC previously returned by ITypeInfo::GetFuncDesc.
    ///Params:
    ///    pFuncDesc = The FUNCDESC to be freed.
    void    ReleaseFuncDesc(FUNCDESC* pFuncDesc);
    ///Releases a VARDESC previously returned by ITypeInfo::GetVarDesc.
    ///Params:
    ///    pVarDesc = The VARDESC to be freed.
    void    ReleaseVarDesc(VARDESC* pVarDesc);
}

///Used for reading information about objects. Can be cast to an ITypeInfo instead of using the calls
///<b>QueryInterface</b> and <b>Release</b> to allow quick opens and allocs. This only works for in-process cases.
@GUID("00020412-0000-0000-C000-000000000046")
interface ITypeInfo2 : ITypeInfo
{
    ///Returns the TYPEKIND enumeration quickly, without doing any allocations.
    ///Params:
    ///    pTypeKind = A TYPEKIND value.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK </b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_INVALIDARG </b></dt> </dl> </td> <td width="60%"> One or more of the arguments is
    ///    not valid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY </b></dt> </dl> </td> <td width="60%">
    ///    Insufficient memory to complete the operation. </td> </tr> </table>
    ///    
    HRESULT GetTypeKind(TYPEKIND* pTypeKind);
    ///Returns the type flags without any allocations. This returns a flag that expands the type flags without growing
    ///the TYPEATTR (type attribute).
    ///Params:
    ///    pTypeFlags = A TYPEFLAG value.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK </b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_INVALIDARG </b></dt> </dl> </td> <td width="60%"> One or more of the arguments is
    ///    not valid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY </b></dt> </dl> </td> <td width="60%">
    ///    Insufficient memory to complete the operation. </td> </tr> </table>
    ///    
    HRESULT GetTypeFlags(uint* pTypeFlags);
    ///Binds to a specific member based on a known DISPID, where the member name is not known (for example, when binding
    ///to a default member).
    ///Params:
    ///    memid = The member identifier.
    ///    invKind = The invoke kind.
    ///    pFuncIndex = An index into the function.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK </b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_INVALIDARG </b></dt> </dl> </td> <td width="60%"> One or more of the arguments is
    ///    not valid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY </b></dt> </dl> </td> <td width="60%">
    ///    Insufficient memory to complete the operation. </td> </tr> </table>
    ///    
    HRESULT GetFuncIndexOfMemId(int memid, INVOKEKIND invKind, uint* pFuncIndex);
    ///Binds to a specific member based on a known DISPID, where the member name is not known (for example, when binding
    ///to a default member).
    ///Params:
    ///    memid = The member identifier.
    ///    pVarIndex = The index.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK </b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_INVALIDARG </b></dt> </dl> </td> <td width="60%"> One or more of the arguments is
    ///    not valid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY </b></dt> </dl> </td> <td width="60%">
    ///    Insufficient memory to complete the operation. </td> </tr> </table>
    ///    
    HRESULT GetVarIndexOfMemId(int memid, uint* pVarIndex);
    ///Gets the custom data.
    ///Params:
    ///    guid = The GUID used to identify the data.
    ///    pVarVal = The custom data.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK </b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_INVALIDARG </b></dt> </dl> </td> <td width="60%"> One or more of the arguments is
    ///    not valid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY </b></dt> </dl> </td> <td width="60%">
    ///    Insufficient memory to complete the operation. </td> </tr> </table>
    ///    
    HRESULT GetCustData(const(GUID)* guid, VARIANT* pVarVal);
    ///Gets the custom data from the specified function.
    ///Params:
    ///    index = The index of the function for which to get the custom data.
    ///    guid = The GUID used to identify the data.
    ///    pVarVal = The custom data.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK </b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_INVALIDARG </b></dt> </dl> </td> <td width="60%"> One or more of the arguments is
    ///    not valid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY </b></dt> </dl> </td> <td width="60%">
    ///    Insufficient memory to complete the operation. </td> </tr> </table>
    ///    
    HRESULT GetFuncCustData(uint index, const(GUID)* guid, VARIANT* pVarVal);
    ///Gets the custom data of the specified parameter.
    ///Params:
    ///    indexFunc = The index of the function for which to get the custom data.
    ///    indexParam = The index of the parameter of this function for which to get the custom data.
    ///    guid = The GUID used to identify the data.
    ///    pVarVal = The retrieved data.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK </b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_INVALIDARG </b></dt> </dl> </td> <td width="60%"> One or more of the arguments is
    ///    not valid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY </b></dt> </dl> </td> <td width="60%">
    ///    Insufficient memory to complete the operation. </td> </tr> </table>
    ///    
    HRESULT GetParamCustData(uint indexFunc, uint indexParam, const(GUID)* guid, VARIANT* pVarVal);
    ///Gets the custom data of the specified variable.
    ///Params:
    ///    index = The index of the variable for which to get the custom data.
    ///    guid = The GUID used to identify the data.
    ///    pVarVal = The retrieved data.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK </b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_INVALIDARG </b></dt> </dl> </td> <td width="60%"> One or more of the arguments is
    ///    not valid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY </b></dt> </dl> </td> <td width="60%">
    ///    Insufficient memory to complete the operation. </td> </tr> </table>
    ///    
    HRESULT GetVarCustData(uint index, const(GUID)* guid, VARIANT* pVarVal);
    ///Gets the custom data of the implementation type.
    ///Params:
    ///    index = The index of the implementation type for the custom data.
    ///    guid = The GUID used to identify the data.
    ///    pVarVal = The retrieved data.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK </b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_INVALIDARG </b></dt> </dl> </td> <td width="60%"> One or more of the arguments is
    ///    not valid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY </b></dt> </dl> </td> <td width="60%">
    ///    Insufficient memory to complete the operation. </td> </tr> </table>
    ///    
    HRESULT GetImplTypeCustData(uint index, const(GUID)* guid, VARIANT* pVarVal);
    ///Retrieves the documentation string, the complete Help file name and path, the localization context to use, and
    ///the context ID for the library Help topic in the Help file.
    ///Params:
    ///    memid = The member identifier for the type description.
    ///    lcid = The locale identifier.
    ///    pbstrHelpString = The name of the specified item. If the caller does not need the item name, then <i>pbstrHelpString</i> can be
    ///                      null.
    ///    pdwHelpStringContext = The Help localization context. If the caller does not need the Help context, it can be null.
    ///    pbstrHelpStringDll = The fully qualified name of the file containing the DLL used for Help file. If the caller does not need the
    ///                         file name, it can be null.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK </b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_INVALIDARG </b></dt> </dl> </td> <td width="60%"> One or more of the arguments is
    ///    not valid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY </b></dt> </dl> </td> <td width="60%">
    ///    Insufficient memory to complete the operation. </td> </tr> </table>
    ///    
    HRESULT GetDocumentation2(int memid, uint lcid, BSTR* pbstrHelpString, uint* pdwHelpStringContext, 
                              BSTR* pbstrHelpStringDll);
    ///Gets all custom data items for the library.
    ///Params:
    ///    pCustData = The custom data items.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK </b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_INVALIDARG </b></dt> </dl> </td> <td width="60%"> One or more of the arguments is
    ///    not valid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY </b></dt> </dl> </td> <td width="60%">
    ///    Insufficient memory to complete the operation. </td> </tr> </table>
    ///    
    HRESULT GetAllCustData(CUSTDATA* pCustData);
    ///Gets all custom data from the specified function.
    ///Params:
    ///    index = The index of the function for which to get the custom data.
    ///    pCustData = The custom data items.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK </b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_INVALIDARG </b></dt> </dl> </td> <td width="60%"> One or more of the arguments is
    ///    not valid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY </b></dt> </dl> </td> <td width="60%">
    ///    Insufficient memory to complete the operation. </td> </tr> </table>
    ///    
    HRESULT GetAllFuncCustData(uint index, CUSTDATA* pCustData);
    ///Gets all of the custom data for the specified function parameter.
    ///Params:
    ///    indexFunc = The index of the function for which to get the custom data.
    ///    indexParam = The index of the parameter of this function for which to get the custom data.
    ///    pCustData = The custom data items.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK </b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_INVALIDARG </b></dt> </dl> </td> <td width="60%"> One or more of the arguments is
    ///    not valid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY </b></dt> </dl> </td> <td width="60%">
    ///    Insufficient memory to complete the operation. </td> </tr> </table>
    ///    
    HRESULT GetAllParamCustData(uint indexFunc, uint indexParam, CUSTDATA* pCustData);
    ///Gets the variable for the custom data.
    ///Params:
    ///    index = The index of the variable for which to get the custom data.
    ///    pCustData = The custom data items.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK </b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_INVALIDARG </b></dt> </dl> </td> <td width="60%"> One or more of the arguments is
    ///    not valid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY </b></dt> </dl> </td> <td width="60%">
    ///    Insufficient memory to complete the operation. </td> </tr> </table>
    ///    
    HRESULT GetAllVarCustData(uint index, CUSTDATA* pCustData);
    ///Gets all custom data for the specified implementation type.
    ///Params:
    ///    index = The index of the implementation type for the custom data.
    ///    pCustData = The custom data items.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK </b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_INVALIDARG </b></dt> </dl> </td> <td width="60%"> One or more of the arguments is
    ///    not valid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY </b></dt> </dl> </td> <td width="60%">
    ///    Insufficient memory to complete the operation. </td> </tr> </table>
    ///    
    HRESULT GetAllImplTypeCustData(uint index, CUSTDATA* pCustData);
}

///Represents a type library, the data that describes a set of objects. A type library can be a stand-alone binary file
///(.TLB), a resource in a dynamic link library or executable file (.DLL, .OLB, or .EXE).
@GUID("00020402-0000-0000-C000-000000000046")
interface ITypeLib : IUnknown
{
    ///Provides the number of type descriptions that are in a type library.
    ///Returns:
    ///    The number of type descriptions in the type library.
    ///    
    uint    GetTypeInfoCount();
    ///Retrieves the specified type description in the library.
    ///Params:
    ///    index = The index of the interface to be returned.
    ///    ppTInfo = If successful, returns a pointer to the pointer to the ITypeInfo interface.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK </b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>TYPE_E_ELEMENTNOTFOUND</b></dt> </dl> </td> <td width="60%"> The <i>index</i>
    ///    parameter is outside the range of to GetTypeInfoCount - 1. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_INVALIDARG </b></dt> </dl> </td> <td width="60%"> One or more of the arguments is not valid. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY </b></dt> </dl> </td> <td width="60%"> Insufficient
    ///    memory to complete the operation. </td> </tr> </table>
    ///    
    HRESULT GetTypeInfo(uint index, ITypeInfo* ppTInfo);
    ///Retrieves the type of a type description.
    ///Params:
    ///    index = The index of the type description within the type library.
    ///    pTKind = The TYPEKIND enumeration value for the type description.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK </b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>TYPE_E_ELEMENTNOTFOUND</b></dt> </dl> </td> <td width="60%"> The <i>index</i>
    ///    parameter is outside the range of to GetTypeInfoCount - 1. </td> </tr> </table>
    ///    
    HRESULT GetTypeInfoType(uint index, TYPEKIND* pTKind);
    ///Retrieves the type description that corresponds to the specified GUID.
    ///Params:
    ///    guid = The GUID of the type description.
    ///    ppTinfo = The ITypeInfo interface.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK </b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>TYPE_E_ELEMENTNOTFOUND</b></dt> </dl> </td> <td width="60%"> No type description was
    ///    found in the library with the specified GUID. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG
    ///    </b></dt> </dl> </td> <td width="60%"> One or more of the arguments is not valid. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_OUTOFMEMORY </b></dt> </dl> </td> <td width="60%"> Insufficient memory to complete
    ///    the operation. </td> </tr> </table>
    ///    
    HRESULT GetTypeInfoOfGuid(const(GUID)* guid, ITypeInfo* ppTinfo);
    ///Retrieves the structure that contains the library's attributes.
    ///Params:
    ///    ppTLibAttr = The library's attributes.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK </b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_INVALIDARG </b></dt> </dl> </td> <td width="60%"> One or more of the arguments is
    ///    not valid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY </b></dt> </dl> </td> <td width="60%">
    ///    Insufficient memory to complete the operation. </td> </tr> </table>
    ///    
    HRESULT GetLibAttr(TLIBATTR** ppTLibAttr);
    ///Enables a client compiler to bind to the types, variables, constants, and global functions for a library.
    ///Params:
    ///    ppTComp = The ITypeComp instance for this ITypeLib. A client compiler uses the methods in the <b>ITypeComp</b>
    ///              interface to bind to types in <b>ITypeLib</b>, as well as to the global functions, variables, and constants
    ///              defined in <b>ITypeLib</b>
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK </b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_INVALIDARG </b></dt> </dl> </td> <td width="60%"> One or more of the arguments is
    ///    not valid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY </b></dt> </dl> </td> <td width="60%">
    ///    Insufficient memory to complete the operation. </td> </tr> </table>
    ///    
    HRESULT GetTypeComp(ITypeComp* ppTComp);
    ///Retrieves the documentation string for the library, the complete Help file name and path, and the context
    ///identifier for the library Help topic in the Help file.
    ///Params:
    ///    index = The index of the type description whose documentation is to be returned. If <i>index</i> is -1, then the
    ///            documentation for the library itself is returned.
    ///    pBstrName = The name of the specified item. If the caller does not need the item name, then <i>pBstrName</i> can be null.
    ///    pBstrDocString = The documentation string for the specified item. If the caller does not need the documentation string, then
    ///                     <i>pBstrDocString</i> can be null..
    ///    pdwHelpContext = The Help context identifier (ID) associated with the specified item. If the caller does not need the Help
    ///                     context ID, then <i>pdwHelpContext</i> can be null.
    ///    pBstrHelpFile = The fully qualified name of the Help file. If the caller does not need the Help file name, then
    ///                    <i>pBstrHelpFile</i> can be null.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK </b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_INVALIDARG </b></dt> </dl> </td> <td width="60%"> One or more of the arguments is
    ///    not valid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>STG_E_INSUFFICIENTMEMORY </b></dt> </dl> </td> <td
    ///    width="60%"> Insufficient memory to complete the operation. </td> </tr> </table>
    ///    
    HRESULT GetDocumentation(int index, BSTR* pBstrName, BSTR* pBstrDocString, uint* pdwHelpContext, 
                             BSTR* pBstrHelpFile);
    ///Indicates whether a passed-in string contains the name of a type or member described in the library.
    ///Params:
    ///    szNameBuf = The string to test. If this method is successful, <i>szNameBuf</i> is modified to match the case
    ///                (capitalization) found in the type library.
    ///    lHashVal = The hash value of <i>szNameBuf</i>.
    ///    pfName = True if <i>szNameBuf</i> was found in the type library; otherwise false.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK </b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_INVALIDARG </b></dt> </dl> </td> <td width="60%"> One or more of the arguments is
    ///    not valid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY </b></dt> </dl> </td> <td width="60%">
    ///    Insufficient memory to complete the operation. </td> </tr> </table>
    ///    
    HRESULT IsName(ushort* szNameBuf, uint lHashVal, int* pfName);
    ///Finds occurrences of a type description in a type library. This may be used to quickly verify that a name exists
    ///in a type library.
    ///Params:
    ///    szNameBuf = The name to search for.
    ///    lHashVal = A hash value to speed up the search, computed by the LHashValOfNameSys function. If <i>lHashVal</i> = 0, a
    ///               value is computed.
    ///    ppTInfo = An array of pointers to the type descriptions that contain the name specified in <i>szNameBuf</i>. This
    ///              parameter cannot be null.
    ///    rgMemId = An array of the found items; <i>rgMemId</i>[<i>i</i>] is the MEMBERID that indexes into the type description
    ///              specified by <i>ppTInfo</i>[<i>i</i>]. This parameter cannot be null.
    ///    pcFound = On entry, indicates how many instances to look for. For example, *<i>pcFound</i> = 1 can be called to find
    ///              the first occurrence. The search stops when one is found. On exit, indicates the number of instances that
    ///              were found. If the in and out values of *<i>pcFound</i> are identical, there may be more type descriptions
    ///              that contain the name.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK </b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_INVALIDARG </b></dt> </dl> </td> <td width="60%"> One or more of the arguments is
    ///    not valid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY </b></dt> </dl> </td> <td width="60%">
    ///    Insufficient memory to complete the operation. </td> </tr> </table>
    ///    
    HRESULT FindName(ushort* szNameBuf, uint lHashVal, ITypeInfo* ppTInfo, int* rgMemId, ushort* pcFound);
    ///Releases the TLIBATTR originally obtained from GetLibAttr.
    ///Params:
    ///    pTLibAttr = The TLIBATTR to be freed.
    void    ReleaseTLibAttr(TLIBATTR* pTLibAttr);
}

///Represents a type library, the data that describes a set of objects. The <b>ITypeLib2</b> interface inherits from the
///ITypeLib interface. This allows <b>ITypeLib</b> to cast to an <b>ITypeLib2</b> in performance-sensitive cases, rather
///than perform extra QueryInterface and Release calls.
@GUID("00020411-0000-0000-C000-000000000046")
interface ITypeLib2 : ITypeLib
{
    ///Gets the custom data.
    ///Params:
    ///    guid = The GUID used to identify the data.
    ///    pVarVal = The retrieved data.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK </b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_INVALIDARG </b></dt> </dl> </td> <td width="60%"> One or more of the arguments is
    ///    not valid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY </b></dt> </dl> </td> <td width="60%">
    ///    Insufficient memory to complete the operation. </td> </tr> </table>
    ///    
    HRESULT GetCustData(const(GUID)* guid, VARIANT* pVarVal);
    ///Returns statistics about a type library that are required for efficient sizing of hash tables.
    ///Params:
    ///    pcUniqueNames = A count of unique names. If the caller does not need this information, set to NULL.
    ///    pcchUniqueNames = A change in the count of unique names.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK </b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_INVALIDARG </b></dt> </dl> </td> <td width="60%"> One or more of the arguments is
    ///    not valid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY </b></dt> </dl> </td> <td width="60%">
    ///    Insufficient memory to complete the operation. </td> </tr> </table>
    ///    
    HRESULT GetLibStatistics(uint* pcUniqueNames, uint* pcchUniqueNames);
    ///Retrieves the library's documentation string, the complete Help file name and path, the localization context to
    ///use, and the context ID for the library Help topic in the Help file.
    ///Params:
    ///    index = The index of the type description whose documentation is to be returned. If <i>index</i> is -1, then the
    ///            documentation for the library is returned.
    ///    lcid = The locale identifier.
    ///    pbstrHelpString = The name of the specified item. If the caller does not need the item name, then <i>pbstrHelpString</i> can be
    ///                      null
    ///    pdwHelpStringContext = The Help localization context. If the caller does not need the Help context, then it can be null.
    ///    pbstrHelpStringDll = The fully qualified name of the file containing the DLL used for Help file. If the caller does not need the
    ///                         file name, then it can be null.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK </b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_INVALIDARG </b></dt> </dl> </td> <td width="60%"> One or more of the arguments is
    ///    not valid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>STG_E_INSUFFICIENTMEMORY </b></dt> </dl> </td> <td
    ///    width="60%"> Insufficient memory to complete the operation. </td> </tr> </table>
    ///    
    HRESULT GetDocumentation2(int index, uint lcid, BSTR* pbstrHelpString, uint* pdwHelpStringContext, 
                              BSTR* pbstrHelpStringDll);
    ///Gets all custom data items for the library.
    ///Params:
    ///    pCustData = The custom data items.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK </b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_INVALIDARG </b></dt> </dl> </td> <td width="60%"> One or more of the arguments is
    ///    not valid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY </b></dt> </dl> </td> <td width="60%">
    ///    Insufficient memory to complete the operation. </td> </tr> </table>
    ///    
    HRESULT GetAllCustData(CUSTDATA* pCustData);
}

///Enables clients to subscribe to type change notifications on objects that implement the ITypeInfo, ITypeInfo2,
///ICreateTypeInfo, and ICreateTypeInfo2 interfaces. When ITypeChangeEvents is implemented on an object, it acts as an
///incoming interface that enables the object to receive calls from external clients and engage in bidirectional
///communication with those clients. For more information, see Events in COM and Connectable Objects.
@GUID("00020410-0000-0000-C000-000000000046")
interface ITypeChangeEvents : IUnknown
{
    ///Raised when a request has been made to change a type. The change can be disallowed.
    ///Params:
    ///    changeKind = The type of change. <a id="CHANGEKIND_ADDMEMBER"></a> <a id="changekind_addmember"></a>
    ///    pTInfoBefore = An object that implements the ITypeInfo, ITypeInfo2, ICreateTypeInfo, or ICreateTypeInfo2 interface and that
    ///                   contains the type information before the change was made. The client subscribes to this object to receive
    ///                   notifications about any changes.
    ///    pStrName = The name of the change. This value may be null.
    ///    pfCancel = False to disallow the change; otherwise, true.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One or more of the arguments is
    ///    not valid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%">
    ///    Insufficient memory to complete the operation. </td> </tr> </table>
    ///    
    HRESULT RequestTypeChange(CHANGEKIND changeKind, ITypeInfo pTInfoBefore, ushort* pStrName, int* pfCancel);
    ///Raised after a type has been changed.
    ///Params:
    ///    changeKind = The type of change. <a id="CHANGEKIND_ADDMEMBER"></a> <a id="changekind_addmember"></a>
    ///    pTInfoAfter = An object that implements the ITypeInfo, ITypeInfo2, ICreateTypeInfo, or ICreateTypeInfo2 interface and that
    ///                  contains the type information before the change was made. The client subscribes to this object to receive
    ///                  notifications about any changes.
    ///    pStrName = The name of the change. This value may be null.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One or more of the arguments is
    ///    not valid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%">
    ///    Insufficient memory to complete the operation. </td> </tr> </table>
    ///    
    HRESULT AfterTypeChange(CHANGEKIND changeKind, ITypeInfo pTInfoAfter, ushort* pStrName);
}

///Provides detailed contextual error information.
@GUID("1CF2B120-547D-101B-8E65-08002B2BD119")
interface IErrorInfo : IUnknown
{
    ///Returns the globally unique identifier (GUID) of the interface that defined the error.
    ///Params:
    ///    pGUID = A pointer to a GUID, or GUID_NULL, if the error was defined by the operating system.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetGUID(GUID* pGUID);
    ///Returns the language-dependent programmatic ID (ProgID) for the class or application that raised the error.
    ///Params:
    ///    pBstrSource = A ProgID, in the form <i>progname</i>.<i>objectname</i>.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetSource(BSTR* pBstrSource);
    ///Returns a textual description of the error.
    ///Params:
    ///    pBstrDescription = A brief description of the error.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetDescription(BSTR* pBstrDescription);
    ///Returns the path of the Help file that describes the error.
    ///Params:
    ///    pBstrHelpFile = The fully qualified path of the Help file.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetHelpFile(BSTR* pBstrHelpFile);
    ///Returns the Help context identifier (ID) for the error.
    ///Params:
    ///    pdwHelpContext = The Help context ID for the error.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetHelpContext(uint* pdwHelpContext);
}

///Returns error information.
@GUID("22F03340-547D-101B-8E65-08002B2BD119")
interface ICreateErrorInfo : IUnknown
{
    ///Sets the globally unique identifier (GUID) of the interface that defined the error.
    ///Params:
    ///    rguid = The GUID of the interface that defined the error, or GUID_NULL if the error was defined by the operating
    ///            system.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Insufficient memory to complete
    ///    the operation. </td> </tr> </table>
    ///    
    HRESULT SetGUID(const(GUID)* rguid);
    ///Sets the language-dependent programmatic identifier (ProgID) for the class or application that raised the error.
    ///Params:
    ///    szSource = A ProgID in the form <i>progname</i>.<i>objectname</i>.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Insufficient memory to complete
    ///    the operation. </td> </tr> </table>
    ///    
    HRESULT SetSource(ushort* szSource);
    ///Sets the textual description of the error.
    ///Params:
    ///    szDescription = A brief description of the error.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Insufficient memory to complete
    ///    the operation. </td> </tr> </table>
    ///    
    HRESULT SetDescription(ushort* szDescription);
    ///Sets the path of the Help file that describes the error.
    ///Params:
    ///    szHelpFile = The fully qualified path of the Help file that describes the error.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Insufficient memory to complete
    ///    the operation. </td> </tr> </table>
    ///    
    HRESULT SetHelpFile(ushort* szHelpFile);
    ///Sets the Help context identifier (ID) for the error.
    ///Params:
    ///    dwHelpContext = The Help context ID for the error.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Insufficient memory to complete
    ///    the operation. </td> </tr> </table>
    ///    
    HRESULT SetHelpContext(uint dwHelpContext);
}

///Ensures that error information can be propagated up the call chain correctly. Automation objects that use the error
///handling interfaces must implement <b>ISupportErrorInfo</b>.
@GUID("DF0B3D60-548F-101B-8E65-08002B2BD119")
interface ISupportErrorInfo : IUnknown
{
    ///Indicates whether an interface supports the IErrorInfo interface.
    ///Params:
    ///    riid = An interface identifier (IID).
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The interface supports IErrorInfo.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>S_FALSE</b></dt> </dl> </td> <td width="60%"> The interface
    ///    does not support IErrorInfo. </td> </tr> </table>
    ///    
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

///Describes the structure of a particular UDT. You can use <b>IRecordInfo</b> any time you need to access the
///description of UDTs contained in type libraries. <b>IRecordInfo</b> can be reused as needed; there can be many
///instances of the UDT for a single <b>IRecordInfo</b> pointer.
@GUID("0000002F-0000-0000-C000-000000000046")
interface IRecordInfo : IUnknown
{
    ///Initializes a new instance of a record.
    ///Params:
    ///    pvNew = An instance of a record.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_INVALIDARG </b></dt> </dl> </td> <td width="60%"> One or more of the arguments is
    ///    not valid. </td> </tr> </table>
    ///    
    HRESULT RecordInit(void* pvNew);
    ///Releases object references and other values of a record without deallocating the record.
    ///Params:
    ///    pvExisting = The record to be cleared.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_INVALIDARG </b></dt> </dl> </td> <td width="60%"> One or more of the arguments is
    ///    not valid. </td> </tr> </table>
    ///    
    HRESULT RecordClear(void* pvExisting);
    ///Copies an existing record into the passed in buffer.
    ///Params:
    ///    pvExisting = The current record instance.
    ///    pvNew = The destination where the record will be copied.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_INVALIDARG </b></dt> </dl> </td> <td width="60%"> One or more of the arguments is
    ///    not valid. </td> </tr> </table>
    ///    
    HRESULT RecordCopy(void* pvExisting, void* pvNew);
    ///Gets the GUID of the record type.
    ///Params:
    ///    pguid = The class GUID of the TypeInfo that describes the UDT.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>TYPE_E_INVALIDSTATE</b></dt> </dl> </td> <td width="60%"> The state of the type
    ///    library is not valid for this operation. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG </b></dt>
    ///    </dl> </td> <td width="60%"> One or more of the arguments is not valid. </td> </tr> </table>
    ///    
    HRESULT GetGuid(GUID* pguid);
    ///Gets the name of the record type. This is useful if you want to print out the type of the record, because each
    ///UDT has it's own IRecordInfo.
    ///Params:
    ///    pbstrName = The name.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_OUT_OFMEMORY</b></dt> </dl> </td> <td width="60%"> Out of memory. </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>E_INVALIDARG </b></dt> </dl> </td> <td width="60%"> One or more of the arguments
    ///    is not valid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>TYPE_E_INVALIDSTATE</b></dt> </dl> </td> <td
    ///    width="60%"> The state of the type library is not valid for this operation. </td> </tr> </table>
    ///    
    HRESULT GetName(BSTR* pbstrName);
    ///Gets the number of bytes of memory necessary to hold the record instance. This allows you to allocate memory for
    ///a record instance rather than calling RecordCreate.
    ///Params:
    ///    pcbSize = The size of a record instance, in bytes.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_INVALIDARG </b></dt> </dl> </td> <td width="60%"> One or more of the arguments is
    ///    not valid. </td> </tr> </table>
    ///    
    HRESULT GetSize(uint* pcbSize);
    ///Retrieves the type information that describes a UDT or safearray of UDTs.
    ///Params:
    ///    ppTypeInfo = The information type of the record.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_INVALIDARG </b></dt> </dl> </td> <td width="60%"> One or more of the arguments is
    ///    not valid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>TYPE_E_INVALIDSTATE</b></dt> </dl> </td> <td
    ///    width="60%"> The state of the type library is not valid for this operation. </td> </tr> </table>
    ///    
    HRESULT GetTypeInfo(ITypeInfo* ppTypeInfo);
    ///Returns a pointer to the VARIANT containing the value of a given field name.
    ///Params:
    ///    pvData = The instance of a record.
    ///    szFieldName = The field name.
    ///    pvarField = The VARIANT that you want to hold the value of the field name, <i>szFieldName</i>. On return, places a copy
    ///                of the field's value in the variant.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_INVALIDARG </b></dt> </dl> </td> <td width="60%"> One or more of the arguments is
    ///    not valid. </td> </tr> </table>
    ///    
    HRESULT GetField(void* pvData, ushort* szFieldName, VARIANT* pvarField);
    ///Returns a pointer to the value of a given field name without copying the value and allocating resources.
    ///Params:
    ///    pvData = The instance of a record.
    ///    szFieldName = The name of the field.
    ///    pvarField = The VARIANT that will contain the UDT upon return.
    ///    ppvDataCArray = Receives the value of the field upon return.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_INVALIDARG </b></dt> </dl> </td> <td width="60%"> One or more of the arguments is
    ///    not valid. </td> </tr> </table>
    ///    
    HRESULT GetFieldNoCopy(void* pvData, ushort* szFieldName, VARIANT* pvarField, void** ppvDataCArray);
    ///Puts a variant into a field.
    ///Params:
    ///    wFlags = The only legal values for the wFlags parameter is INVOKE_PROPERTYPUT or INVOKE_PROPERTYPUTREF. If
    ///             INVOKE_PROPERTYPUTREF is passed in then <b>PutField</b> just assigns the value of the variant that is passed
    ///             in to the field using normal coercion rules. If INVOKE_PROPERTYPUT is passed in then specific rules apply. If
    ///             the field is declared as a class that derives from IDispatch and the field's value is NULL then an error will
    ///             be returned. If the field's value is not NULL then the variant will be passed to the default property
    ///             supported by the object referenced by the field. If the field is not declared as a class derived from
    ///             <b>IDispatch</b> then an error will be returned. If the field is declared as a variant of type VT_Dispatch
    ///             then the default value of the object is assigned to the field. Otherwise, the variant's value is assigned to
    ///             the field.
    ///    pvData = The pointer to an instance of the record.
    ///    szFieldName = The name of the field of the record.
    ///    pvarField = The pointer to the variant.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_INVALIDARG </b></dt> </dl> </td> <td width="60%"> One or more of the arguments is
    ///    not valid. </td> </tr> </table>
    ///    
    HRESULT PutField(uint wFlags, void* pvData, ushort* szFieldName, VARIANT* pvarField);
    ///Passes ownership of the data to the assigned field by placing the actual data into the
    ///field.<b>PutFieldNoCopy</b> is useful for saving resources because it allows you to place your data directly into
    ///a record field. <b>PutFieldNoCopy</b> differs from PutField because it does not copy the data referenced by the
    ///variant.
    ///Params:
    ///    wFlags = The only legal values for the wFlags parameter is INVOKE_PROPERTYPUT or INVOKE_PROPERTYPUTREF.
    ///    pvData = An instance of the record described by IRecordInfo.
    ///    szFieldName = The name of the field of the record.
    ///    pvarField = The variant to be put into the field.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_INVALIDARG </b></dt> </dl> </td> <td width="60%"> One or more of the arguments is
    ///    not valid. </td> </tr> </table>
    ///    
    HRESULT PutFieldNoCopy(uint wFlags, void* pvData, ushort* szFieldName, VARIANT* pvarField);
    ///Gets the names of the fields of the record.
    ///Params:
    ///    pcNames = The number of names to return.
    ///    rgBstrNames = The name of the array of type BSTR. If the <i>rgBstrNames</i> parameter is NULL, then <i>pcNames</i> is
    ///                  returned with the number of field names. It the <i>rgBstrNames</i> parameter is not NULL, then the string
    ///                  names contained in <i>rgBstrNames</i> are returned. If the number of names in <i>pcNames</i> and
    ///                  <i>rgBstrNames</i> are not equal then the lesser number of the two is the number of returned field names. The
    ///                  caller needs to free the BSTRs inside the array returned in <i>rgBstrNames</i>.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_OUT_OFMEMORY</b></dt> </dl> </td> <td width="60%"> Out of memory. </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>E_INVALIDARG </b></dt> </dl> </td> <td width="60%"> One or more of the arguments
    ///    is not valid. </td> </tr> </table>
    ///    
    HRESULT GetFieldNames(uint* pcNames, char* rgBstrNames);
    ///Determines whether the record that is passed in matches that of the current record information.
    ///Params:
    ///    pRecordInfo = The information of the record.
    ///Returns:
    ///    <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>TRUE</b></dt>
    ///    </dl> </td> <td width="60%"> The record that is passed in matches the current record information. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>FALSE</b></dt> </dl> </td> <td width="60%"> The record that is passed in
    ///    does not match the current record information. </td> </tr> </table>
    ///    
    BOOL    IsMatchingType(IRecordInfo pRecordInfo);
    ///Allocates memory for a new record, initializes the instance and returns a pointer to the record.
    ///Returns:
    ///    This method returns a pointer to the created record.
    ///    
    void*   RecordCreate();
    ///Creates a copy of an instance of a record to the specified location.
    ///Params:
    ///    pvSource = An instance of the record to be copied.
    ///    ppvDest = The new record with data copied from <i>pvSource</i>.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_OUT_OFMEMORY</b></dt> </dl> </td> <td width="60%"> Out of memory. </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>E_INVALIDARG </b></dt> </dl> </td> <td width="60%"> One or more of the arguments
    ///    is not valid. </td> </tr> </table>
    ///    
    HRESULT RecordCreateCopy(void* pvSource, void** ppvDest);
    ///Releases the resources and deallocates the memory of the record.
    ///Params:
    ///    pvRecord = An instance of the record to be destroyed.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_INVALIDARG </b></dt> </dl> </td> <td width="60%"> One or more of the arguments is
    ///    not valid. </td> </tr> </table>
    ///    
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
