// Written in the D programming language.

module windows.windowssystemassessmenttool;

public import windows.core;
public import windows.automation : BSTR, IDispatch, VARIANT;
public import windows.com : HRESULT, IUnknown;
public import windows.gdi : HBITMAP;
public import windows.systemservices : PWSTR;
public import windows.windowsaccessibility : IAccessible;
public import windows.windowsandmessaging : HWND;
public import windows.windowsprogramming : IXMLDOMNodeList;

extern(Windows) @nogc nothrow:


// Enums


alias __MIDL___MIDL_itf_winsatcominterfacei_0000_0000_0001 = int;
enum : int
{
    WINSAT_OEM_DATA_VALID                = 0x00000000,
    WINSAT_OEM_DATA_NON_SYS_CONFIG_MATCH = 0x00000001,
    WINSAT_OEM_DATA_INVALID              = 0x00000002,
    WINSAT_OEM_NO_DATA_SUPPLIED          = 0x00000003,
}

///<p class="CCE_Message">[WINSAT_ASSESSMENT_STATE may be altered or unavailable for releases after Windows 8.1.]
///Defines the possible states of an assessment.
alias WINSAT_ASSESSMENT_STATE = int;
enum : int
{
    ///The minimum enumeration value for this enumeration.
    WINSAT_ASSESSMENT_STATE_MIN                      = 0x00000000,
    ///The state of the assessment is unknown.
    WINSAT_ASSESSMENT_STATE_UNKNOWN                  = 0x00000000,
    ///The assessment data is valid for the current computer configuration.
    WINSAT_ASSESSMENT_STATE_VALID                    = 0x00000001,
    ///The assessment data does not match the current computer configuration. The hardware on the computer has changed
    ///since the last time a formal assessment was run.
    WINSAT_ASSESSMENT_STATE_INCOHERENT_WITH_HARDWARE = 0x00000002,
    ///The assessment data is not available because a formal WinSAT assessment has not been run on this computer.
    WINSAT_ASSESSMENT_STATE_NOT_AVAILABLE            = 0x00000003,
    ///The assessment data is not valid.
    WINSAT_ASSESSMENT_STATE_INVALID                  = 0x00000004,
    ///The maximum enumeration value for this enumeration.
    WINSAT_ASSESSMENT_STATE_MAX                      = 0x00000004,
}

///<p class="CCE_Message">[WINSAT_ASSESSMENT_TYPE may be altered or unavailable for releases after Windows 8.1.] Defines
///the possible subcomponents of an assessment.
alias WINSAT_ASSESSMENT_TYPE = int;
enum : int
{
    ///Assess the memory of the computer.
    WINSAT_ASSESSMENT_MEMORY   = 0x00000000,
    ///Assess the processors on the computer.
    WINSAT_ASSESSMENT_CPU      = 0x00000001,
    ///Assess the primary hard disk on the computer.
    WINSAT_ASSESSMENT_DISK     = 0x00000002,
    ///After Windows 8.1, WinSAT no longer assesses the three-dimensional graphics (gaming) capabilities of the computer
    ///and the graphics driver's ability to render objects and execute shaders using this assessment. For compatibility,
    ///WinSAT reports sentinel values for the metrics and scores, however these are not calculated in real time.
    WINSAT_ASSESSMENT_D3D      = 0x00000003,
    ///Assess the video card abilities required for Desktop Window Manager (DWM) composition.
    WINSAT_ASSESSMENT_GRAPHICS = 0x00000004,
}

///<p class="CCE_Message">[WINSAT_BITMAP_SIZE may be altered or unavailable for releases after Windows 8.1.] Defines the
///size of the bitmap to use to represent the WinSAT score.
alias WINSAT_BITMAP_SIZE = int;
enum : int
{
    ///Use a 32 x 24 bitmap (size is in pixels).
    WINSAT_BITMAP_SIZE_SMALL  = 0x00000000,
    ///Use an 80 x 80 bitmap (size is in pixels).
    WINSAT_BITMAP_SIZE_NORMAL = 0x00000001,
}

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

///<p class="CCE_Message">[IProvideWinSATAssessmentInfo may be altered or unavailable for releases after Windows 8.1.]
///Gets summary information for a subcomponent of the assessment, for example, its score. To get this interface, call
///the IProvideWinSATResultsInfo::GetAssessmentInfo method.
@GUID("0CD1C380-52D3-4678-AC6F-E929E480BE9E")
interface IProvideWinSATAssessmentInfo : IDispatch
{
    ///<p class="CCE_Message">[IProvideWinSATAssessmentInfo::Score may be altered or unavailable for releases after
    ///Windows 8.1.] Retrieves the score for the subcomponent. This property is read-only.
    HRESULT get_Score(float* score);
    ///<p class="CCE_Message">[IProvideWinSATAssessmentInfo::Title may be altered or unavailable for releases after
    ///Windows 8.1.] Retrieves the title of the subcomponent. This property is read-only.
    HRESULT get_Title(BSTR* title);
    ///<p class="CCE_Message">[IProvideWinSATAssessmentInfo::Description may be altered or unavailable for releases
    ///after Windows 8.1.] Retrieves the description of the subcomponent. This property is read-only.
    HRESULT get_Description(BSTR* description);
}

///<p class="CCE_Message">[IProvideWinSATResultsInfo may be altered or unavailable for releases after Windows 8.1.] Gets
///information about the results of an assessment, for example, the base score and the date that the assessment was run.
///To get this interface, call the IQueryRecentWinSATAssessment::get_Info method.
@GUID("F8334D5D-568E-4075-875F-9DF341506640")
interface IProvideWinSATResultsInfo : IDispatch
{
    ///<p class="CCE_Message">[IProvideWinSATResultsInfo::GetAssessmentInfo may be altered or unavailable for releases
    ///after Windows 8.1.] Retrieves summary information for a subcomponent of the assessment.
    ///Params:
    ///    assessment = A subcomponent of the assessment whose summary information you want to retrieve. For possible values, see the
    ///                 WINSAT_ASSESSMENT_TYPE enumeration.
    ///    ppinfo = An IProvideWinSATAssessmentInfo interface that you use to get the score for the subcomponent.
    ///Returns:
    ///    Returns S_OK if successful.
    ///    
    HRESULT GetAssessmentInfo(WINSAT_ASSESSMENT_TYPE assessment, IProvideWinSATAssessmentInfo* ppinfo);
    ///<p class="CCE_Message">[IProvideWinSATResultsInfo::AssessmentState may be altered or unavailable for releases
    ///after Windows 8.1.] Retrieves the state of the assessment. This property is read-only.
    HRESULT get_AssessmentState(WINSAT_ASSESSMENT_STATE* state);
    ///<p class="CCE_Message">[IProvideWinSATResultsInfo::AssessmentDateTime may be altered or unavailable for releases
    ///after Windows 8.1.] Retrieves the date and time that the assessment was run. This property is read-only.
    HRESULT get_AssessmentDateTime(VARIANT* fileTime);
    ///<p class="CCE_Message">[IProvideWinSATResultsInfo::SystemRating may be altered or unavailable for releases after
    ///Windows 8.1.] Retrieves the base score for the computer. This property is read-only.
    HRESULT get_SystemRating(float* level);
    ///<p class="CCE_Message">[IProvideWinSATResultsInfo::RatingStateDesc may be altered or unavailable for releases
    ///after Windows 8.1.] Retrieves a string that you can use in a UI to indicate whether the assessment is valid. This
    ///property is read-only.
    HRESULT get_RatingStateDesc(BSTR* description);
}

///<p class="CCE_Message">[IQueryRecentWinSATAssessment may be altered or unavailable for releases after Windows 8.1.]
///Retrieves details about the results of the most recent formal WinSAT assessment. To retrieve this interface, call the
///CoCreateInstance function. Use __uuidof(CQueryWinSAT) as the class identifier and
///__uuidof(IQueryRecentWinSATAssessment) as the interface identifier.
@GUID("F8AD5D1F-3B47-4BDC-9375-7C6B1DA4ECA7")
interface IQueryRecentWinSATAssessment : IDispatch
{
    ///<p class="CCE_Message">[IQueryRecentWinSATAssessment::XML may be altered or unavailable for releases after
    ///Windows 8.1.] Retrieves data from the XML assessment document by using the specified XPath. The query is run
    ///against the most recent formal assessment in the WinSAT data store. This property is read-only.
    HRESULT get_XML(BSTR xPath, BSTR namespaces, IXMLDOMNodeList* ppDomNodeList);
    ///<p class="CCE_Message">[IQueryRecentWinSATAssessment::Info may be altered or unavailable for releases after
    ///Windows 8.1.] Retrieves an interface that provides information about the results of the most recent formal
    ///assessment, for example, the base score and the date that the assessment was run. This property is read-only.
    HRESULT get_Info(IProvideWinSATResultsInfo* ppWinSATAssessmentInfo);
}

///<p class="CCE_Message">[IProvideWinSATVisuals may be altered or unavailable for releases after Windows 8.1.]
///Retrieves elements that can be used in a user interface to graphically represent the WinSAT assessment. To retrieve
///this interface, call the CoCreateInstance function. Use __uuidof(CProvideWinSATVisuals) as the class identifier and
///__uuidof(IProvideWinSATVisuals) as the interface identifier.
@GUID("A9F4ADE0-871A-42A3-B813-3078D25162C9")
interface IProvideWinSATVisuals : IUnknown
{
    ///<p class="CCE_Message">[IProvideWinSATVisuals::get_Bitmap may be altered or unavailable for releases after
    ///Windows 8.1.] Retrieves a bitmap for the WinSAT base score.
    ///Params:
    ///    bitmapSize = Determines the size of the bitmap that this method returns. For possible values, see the WINSAT_BITMAP_SIZE
    ///                 enumeration.
    ///    state = The state of the assessment. To get this value, call the IProvideWinSATResultsInfo::get_AssessmentState
    ///            method.
    ///    rating = The base score for the computer. To get this value, call the IProvideWinSATResultsInfo::get_SystemRating
    ///             method.
    ///    pBitmap = The handle to the bitmap. To free the handle when finished, call the DeleteObject function.
    ///Returns:
    ///    This method can return one of these values. The following table lists some of the HRESULT values that this
    ///    method returns. <table> <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Successfully retrieved the bitmap. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>WINSAT_ERROR_FAILEDTOLOADRESOURCE</b></dt> <dt>0x80040016</dt> </dl> </td> <td
    ///    width="60%"> The <i>rating</i> value is not valid. Valid values are 1.0 through 9.9. </td> </tr> </table>
    ///    
    HRESULT get_Bitmap(WINSAT_BITMAP_SIZE bitmapSize, WINSAT_ASSESSMENT_STATE state, float rating, 
                       HBITMAP* pBitmap);
}

///<p class="CCE_Message">[IQueryAllWinSATAssessments may be altered or unavailable for releases after Windows 8.1.]
///Retrieves details about all formal WinSAT assessments. To retrieve this interface, call the CoCreateInstance
///function. Use __uuidof(CQueryAllWinSAT) as the class identifier and __uuidof(IQueryAllWinSATAssessments) as the
///interface identifier.
@GUID("0B89ED1D-6398-4FEA-87FC-567D8D19176F")
interface IQueryAllWinSATAssessments : IDispatch
{
    ///<p class="CCE_Message">[IQueryAllWinSATAssessments::AllXML may be altered or unavailable for releases after
    ///Windows 8.1.] Retrieves data from the formal XML assessment documents using the specified XPath. The query is run
    ///against all formal assessments in the WinSAT data store. This property is read-only.
    HRESULT get_AllXML(BSTR xPath, BSTR namespaces, IXMLDOMNodeList* ppDomNodeList);
}

///<p class="CCE_Message">[IWinSATInitiateEvents may be altered or unavailable for releases after Windows 8.1.]
///Implement this interface to receive notifications when an assessment is complete or making progress.
@GUID("262A1918-BA0D-41D5-92C2-FAB4633EE74F")
interface IWinSATInitiateEvents : IUnknown
{
    ///<p class="CCE_Message">[IWinSATInitiateEvents::WinSATComplete may be altered or unavailable for releases after
    ///Windows 8.1.] Receives notification when an assessment succeeds, fails, or is canceled.
    ///Params:
    ///    hresult = The return value of the assessment. The following are the possible return values of the assessment. <table>
    ///              <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
    ///              id="WINSAT_STATUS_COMPLETED_SUCCESS"></a><a id="winsat_status_completed_success"></a><dl>
    ///              <dt><b>WINSAT_STATUS_COMPLETED_SUCCESS</b></dt> <dt>0x40033</dt> </dl> </td> <td width="60%"> The assessment
    ///              completed successfully. </td> </tr> <tr> <td width="40%"><a id="WINSAT_ERROR_ASSESSMENT_INTERFERENCE"></a><a
    ///              id="winsat_error_assessment_interference"></a><dl> <dt><b>WINSAT_ERROR_ASSESSMENT_INTERFERENCE</b></dt>
    ///              <dt>0x80040034</dt> </dl> </td> <td width="60%"> The assessment could not complete due to system activity.
    ///              </td> </tr> <tr> <td width="40%"><a id="WINSAT_ERROR_COMPLETED_ERROR"></a><a
    ///              id="winsat_error_completed_error"></a><dl> <dt><b>WINSAT_ERROR_COMPLETED_ERROR</b></dt> <dt>0x80040035</dt>
    ///              </dl> </td> <td width="60%"> The assessment could not complete due to an internal or system error. </td>
    ///              </tr> <tr> <td width="40%"><a id="WINSAT_ERROR_WINSAT_CANCELED"></a><a
    ///              id="winsat_error_winsat_canceled"></a><dl> <dt><b>WINSAT_ERROR_WINSAT_CANCELED</b></dt> <dt>0x80040036</dt>
    ///              </dl> </td> <td width="60%"> The assessment was canceled. </td> </tr> <tr> <td width="40%"><a
    ///              id="WINSAT_ERROR_COMMAND_LINE_INVALID"></a><a id="winsat_error_command_line_invalid"></a><dl>
    ///              <dt><b>WINSAT_ERROR_COMMAND_LINE_INVALID</b></dt> <dt>0x80040037</dt> </dl> </td> <td width="60%"> The
    ///              command line passed to WinSAT was not valid. </td> </tr> <tr> <td width="40%"><a
    ///              id="WINSAT_ERROR_ACCESS_DENIED"></a><a id="winsat_error_access_denied"></a><dl>
    ///              <dt><b>WINSAT_ERROR_ACCESS_DENIED</b></dt> <dt>0x80040038</dt> </dl> </td> <td width="60%"> The user does not
    ///              have sufficient privileges to run WinSAT. </td> </tr> <tr> <td width="40%"><a
    ///              id="WINSAT_ERROR_WINSAT_ALREADY_RUNNING"></a><a id="winsat_error_winsat_already_running"></a><dl>
    ///              <dt><b>WINSAT_ERROR_WINSAT_ALREADY_RUNNING</b></dt> <dt>0x80040039</dt> </dl> </td> <td width="60%"> Another
    ///              copy of WinSAT.exe is already running; only one instance of WinSAT.exe can run on the computer at one time.
    ///              </td> </tr> </table>
    ///    strDescription = The description of the completion status. This string is valid during the life of this callback. Copy the
    ///                     string if you need it after the callback returns.
    ///Returns:
    ///    This method should return S_OK; the value is ignored.
    ///    
    HRESULT WinSATComplete(HRESULT hresult, const(PWSTR) strDescription);
    ///<p class="CCE_Message">[IWinSATInitiateEvents::WinSATUpdate may be altered or unavailable for releases after
    ///Windows 8.1.] Receives notification when an assessment is making progress.
    ///Params:
    ///    uCurrentTick = The current progress tick of the assessment.
    ///    uTickTotal = The total number of progress ticks for the assessment.
    ///    strCurrentState = A string that contains the current state of the assessment. This string is valid during the life of this
    ///                      callback. Copy the string if you need it after the callback returns.
    ///Returns:
    ///    This method should return S_OK; the value is ignored.
    ///    
    HRESULT WinSATUpdate(uint uCurrentTick, uint uTickTotal, const(PWSTR) strCurrentState);
}

///<p class="CCE_Message">[IInitiateWinSATAssessment may be altered or unavailable for releases after Windows 8.1.]
///Initiates an assessment. To retrieve this interface, call the CoCreateInstance function. Use
///__uuidof(CInitiateWinSAT) as the class identifier and __uuidof(IInitiateWinSATAssessment) as the interface
///identifier.
@GUID("D983FC50-F5BF-49D5-B5ED-CCCB18AA7FC1")
interface IInitiateWinSATAssessment : IUnknown
{
    ///<p class="CCE_Message">[IInitiateWinSATAssessment::InitiateAssessment may be altered or unavailable for releases
    ///after Windows 8.1.] Initiates an ad hoc assessment.
    ///Params:
    ///    cmdLine = Command-line arguments to pass to WinSAT. The command line cannot be empty. For command line usage, see
    ///              WinSAT Command Reference on Microsoft TechNet.
    ///    pCallbacks = An IWinSATInitiateEvents interface that you implement to receive notification when the assessment finishes or
    ///                 makes progress. Can be <b>NULL</b> if you do not want to receive notifications.
    ///    callerHwnd = The window handle of your client. The handle is used to center the WinSAT dialog boxes. If <b>NULL</b>, the
    ///                 dialog boxes are centered on the desktop.
    ///Returns:
    ///    This method can return one of these values. This following table lists some of the HRESULT values that this
    ///    method returns. <table> <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> WinSAT successfully started. To determine if the assessment
    ///    ran successfully, implement the IWinSATInitiateEvents::WinSATComplete method and check the value of the
    ///    <i>hresult</i> parameter. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>WINSAT_ERROR_COMMAND_LINE_EMPTY</b></dt> <dt>0x80040009</dt> </dl> </td> <td width="60%"> The command
    ///    line cannot be empty; you must provide command-line arguments. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>WINSAT_ERROR_COMMAND_LINE_TOO_LONG</b></dt> <dt>0x8004000A</dt> </dl> </td> <td width="60%"> The
    ///    command line is too long. The maximum length is 30,720 bytes. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>WINSAT_ERROR_WINSAT_DOES_NOT_EXIST</b></dt> <dt>0x80040011</dt> </dl> </td> <td width="60%"> Could not
    ///    find the WinSAT program where expected. </td> </tr> </table>
    ///    
    HRESULT InitiateAssessment(const(PWSTR) cmdLine, IWinSATInitiateEvents pCallbacks, HWND callerHwnd);
    ///<p class="CCE_Message">[IInitiateWinSATAssessment::InitiateFormalAssessment may be altered or unavailable for
    ///releases after Windows 8.1.] Initiates a formal assessment.
    ///Params:
    ///    pCallbacks = An IWinSATInitiateEvents interface that you implement to receive notification when the assessment finishes or
    ///                 makes progress. Can be <b>NULL</b> if you do not want to receive notifications.
    ///    callerHwnd = The window handle of your client. The handle is used to center the WinSAT dialog boxes. If <b>NULL</b>, the
    ///                 dialog boxes are centered on the desktop.
    ///Returns:
    ///    This method can return one of these values. This following table lists some of the HRESULT values that this
    ///    method returns. <table> <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> WinSAT successfully started. To determine if the assessment
    ///    ran successfully, implement the IWinSATInitiateEvents::WinSATComplete method and check the value of the
    ///    <i>hresult</i> parameter. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>WINSAT_ERROR_WINSAT_DOES_NOT_EXIST</b></dt> <dt>0x80040011</dt> </dl> </td> <td width="60%"> Could not
    ///    find the WinSAT program where expected. </td> </tr> </table>
    ///    
    HRESULT InitiateFormalAssessment(IWinSATInitiateEvents pCallbacks, HWND callerHwnd);
    ///<p class="CCE_Message">[IInitiateWinSATAssessment::CancelAssessment may be altered or unavailable for releases
    ///after Windows 8.1.] Cancels a currently running assessment.
    ///Returns:
    ///    Returns S_OK if successful; otherwise, the method returns the following error code or a Win32 error code
    ///    returned as an HRESULT. <table> <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>WINSAT_ERROR_WINSAT_NOT_RUNNING</b></dt> <dt>0x80040006</dt> </dl> </td> <td
    ///    width="60%"> There is no running assessment to cancel. </td> </tr> </table>
    ///    
    HRESULT CancelAssessment();
}

@GUID("30E6018A-94A8-4FF8-A69A-71B67413F07B")
interface IAccessibleWinSAT : IAccessible
{
    HRESULT SetAccessiblityData(const(PWSTR) wsName, const(PWSTR) wsValue, const(PWSTR) wsDesc);
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
