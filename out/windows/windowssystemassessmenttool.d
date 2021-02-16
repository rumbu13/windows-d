module windows.windowssystemassessmenttool;

public import windows.core;
public import windows.automation : BSTR, IDispatch, VARIANT;
public import windows.com : HRESULT, IUnknown;
public import windows.gdi : HBITMAP;
public import windows.windowsaccessibility : IAccessible;
public import windows.windowsandmessaging : HWND;
public import windows.windowsprogramming : IXMLDOMNodeList;

extern(Windows):


// Enums


enum : int
{
    WINSAT_OEM_DATA_VALID                = 0x00000000,
    WINSAT_OEM_DATA_NON_SYS_CONFIG_MATCH = 0x00000001,
    WINSAT_OEM_DATA_INVALID              = 0x00000002,
    WINSAT_OEM_NO_DATA_SUPPLIED          = 0x00000003,
}
alias __MIDL___MIDL_itf_winsatcominterfacei_0000_0000_0001 = int;

enum : int
{
    WINSAT_ASSESSMENT_STATE_MIN                      = 0x00000000,
    WINSAT_ASSESSMENT_STATE_UNKNOWN                  = 0x00000000,
    WINSAT_ASSESSMENT_STATE_VALID                    = 0x00000001,
    WINSAT_ASSESSMENT_STATE_INCOHERENT_WITH_HARDWARE = 0x00000002,
    WINSAT_ASSESSMENT_STATE_NOT_AVAILABLE            = 0x00000003,
    WINSAT_ASSESSMENT_STATE_INVALID                  = 0x00000004,
    WINSAT_ASSESSMENT_STATE_MAX                      = 0x00000004,
}
alias WINSAT_ASSESSMENT_STATE = int;

enum : int
{
    WINSAT_ASSESSMENT_MEMORY   = 0x00000000,
    WINSAT_ASSESSMENT_CPU      = 0x00000001,
    WINSAT_ASSESSMENT_DISK     = 0x00000002,
    WINSAT_ASSESSMENT_D3D      = 0x00000003,
    WINSAT_ASSESSMENT_GRAPHICS = 0x00000004,
}
alias WINSAT_ASSESSMENT_TYPE = int;

enum : int
{
    WINSAT_BITMAP_SIZE_SMALL  = 0x00000000,
    WINSAT_BITMAP_SIZE_NORMAL = 0x00000001,
}
alias WINSAT_BITMAP_SIZE = int;

// Interfaces

@GUID("489331DC-F5E0-4528-9FDA-45331BF4A571")
struct CInitiateWinSAT;

@GUID("F3BDFAD3-F276-49E9-9B17-C474F48F0764")
struct CQueryWinSAT;

@GUID("05DF8D13-C355-47F4-A11E-851B338CEFB8")
struct CQueryAllWinSAT;

@GUID("9F377D7E-E551-44F8-9F94-9DB392B03B7B")
struct CProvideWinSATVisuals;

@GUID("6E18F9C6-A3EB-495A-89B7-956482E19F7A")
struct CAccessiblityWinSAT;

@GUID("C47A41B7-B729-424F-9AF9-5CB3934F2DFA")
struct CQueryOEMWinSATCustomization;

@GUID("0CD1C380-52D3-4678-AC6F-E929E480BE9E")
interface IProvideWinSATAssessmentInfo : IDispatch
{
    HRESULT get_Score(float* score);
    HRESULT get_Title(BSTR* title);
    HRESULT get_Description(BSTR* description);
}

@GUID("F8334D5D-568E-4075-875F-9DF341506640")
interface IProvideWinSATResultsInfo : IDispatch
{
    HRESULT GetAssessmentInfo(WINSAT_ASSESSMENT_TYPE assessment, IProvideWinSATAssessmentInfo* ppinfo);
    HRESULT get_AssessmentState(WINSAT_ASSESSMENT_STATE* state);
    HRESULT get_AssessmentDateTime(VARIANT* fileTime);
    HRESULT get_SystemRating(float* level);
    HRESULT get_RatingStateDesc(BSTR* description);
}

@GUID("F8AD5D1F-3B47-4BDC-9375-7C6B1DA4ECA7")
interface IQueryRecentWinSATAssessment : IDispatch
{
    HRESULT get_XML(BSTR xPath, BSTR namespaces, IXMLDOMNodeList* ppDomNodeList);
    HRESULT get_Info(IProvideWinSATResultsInfo* ppWinSATAssessmentInfo);
}

@GUID("A9F4ADE0-871A-42A3-B813-3078D25162C9")
interface IProvideWinSATVisuals : IUnknown
{
    HRESULT get_Bitmap(WINSAT_BITMAP_SIZE bitmapSize, WINSAT_ASSESSMENT_STATE state, float rating, 
                       HBITMAP* pBitmap);
}

@GUID("0B89ED1D-6398-4FEA-87FC-567D8D19176F")
interface IQueryAllWinSATAssessments : IDispatch
{
    HRESULT get_AllXML(BSTR xPath, BSTR namespaces, IXMLDOMNodeList* ppDomNodeList);
}

@GUID("262A1918-BA0D-41D5-92C2-FAB4633EE74F")
interface IWinSATInitiateEvents : IUnknown
{
    HRESULT WinSATComplete(HRESULT hresult, const(wchar)* strDescription);
    HRESULT WinSATUpdate(uint uCurrentTick, uint uTickTotal, const(wchar)* strCurrentState);
}

@GUID("D983FC50-F5BF-49D5-B5ED-CCCB18AA7FC1")
interface IInitiateWinSATAssessment : IUnknown
{
    HRESULT InitiateAssessment(const(wchar)* cmdLine, IWinSATInitiateEvents pCallbacks, HWND callerHwnd);
    HRESULT InitiateFormalAssessment(IWinSATInitiateEvents pCallbacks, HWND callerHwnd);
    HRESULT CancelAssessment();
}

@GUID("30E6018A-94A8-4FF8-A69A-71B67413F07B")
interface IAccessibleWinSAT : IAccessible
{
    HRESULT SetAccessiblityData(const(wchar)* wsName, const(wchar)* wsValue, const(wchar)* wsDesc);
}

@GUID("BC9A6A9F-AD4E-420E-9953-B34671E9DF22")
interface IQueryOEMWinSATCustomization : IUnknown
{
    HRESULT GetOEMPrePopulationInfo(__MIDL___MIDL_itf_winsatcominterfacei_0000_0000_0001* state);
}


// GUIDs

const GUID CLSID_CAccessiblityWinSAT          = GUIDOF!CAccessiblityWinSAT;
const GUID CLSID_CInitiateWinSAT              = GUIDOF!CInitiateWinSAT;
const GUID CLSID_CProvideWinSATVisuals        = GUIDOF!CProvideWinSATVisuals;
const GUID CLSID_CQueryAllWinSAT              = GUIDOF!CQueryAllWinSAT;
const GUID CLSID_CQueryOEMWinSATCustomization = GUIDOF!CQueryOEMWinSATCustomization;
const GUID CLSID_CQueryWinSAT                 = GUIDOF!CQueryWinSAT;

const GUID IID_IAccessibleWinSAT            = GUIDOF!IAccessibleWinSAT;
const GUID IID_IInitiateWinSATAssessment    = GUIDOF!IInitiateWinSATAssessment;
const GUID IID_IProvideWinSATAssessmentInfo = GUIDOF!IProvideWinSATAssessmentInfo;
const GUID IID_IProvideWinSATResultsInfo    = GUIDOF!IProvideWinSATResultsInfo;
const GUID IID_IProvideWinSATVisuals        = GUIDOF!IProvideWinSATVisuals;
const GUID IID_IQueryAllWinSATAssessments   = GUIDOF!IQueryAllWinSATAssessments;
const GUID IID_IQueryOEMWinSATCustomization = GUIDOF!IQueryOEMWinSATCustomization;
const GUID IID_IQueryRecentWinSATAssessment = GUIDOF!IQueryRecentWinSATAssessment;
const GUID IID_IWinSATInitiateEvents        = GUIDOF!IWinSATInitiateEvents;
