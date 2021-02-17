// Written in the D programming language.

module windows.deviceanddriverinstallation;

public import windows.core;
public import windows.applicationinstallationandservicing : INFCONTEXT, PSP_FILE_CALLBACK_A,
                                                            SP_ALTPLATFORM_INFO_V2;
public import windows.controls : HIMAGELIST, HPROPSHEETPAGE, PROPSHEETHEADERA_V2,
                                 PROPSHEETHEADERW_V2;
public import windows.displaydevices : RECT;
public import windows.gdi : HDC, HICON;
public import windows.systemservices : BOOL, DEVPROPKEY, HANDLE, LARGE_INTEGER;
public import windows.windowsandmessaging : HWND, LPARAM;
public import windows.windowsprogramming : FILETIME, HKEY;

extern(Windows):


// Enums


enum SetupFileLogInfo : int
{
    SetupFileLogSourceFilename  = 0x00000000,
    SetupFileLogChecksum        = 0x00000001,
    SetupFileLogDiskTagfile     = 0x00000002,
    SetupFileLogDiskDescription = 0x00000003,
    SetupFileLogOtherInfo       = 0x00000004,
    SetupFileLogMax             = 0x00000005,
}

///If the PnP manager rejects a request to perform an operation, the PNP_VETO_TYPE enumeration is used to identify the
///reason for the rejection.
alias PNP_VETO_TYPE = int;
enum : int
{
    ///The specified operation was rejected for an unknown reason.
    PNP_VetoTypeUnknown          = 0x00000000,
    ///The device does not support the specified PnP operation.
    PNP_VetoLegacyDevice         = 0x00000001,
    ///The specified operation cannot be completed because of a pending close operation.
    PNP_VetoPendingClose         = 0x00000002,
    ///A Microsoft Win32 application vetoed the specified operation.
    PNP_VetoWindowsApp           = 0x00000003,
    ///A Win32 service vetoed the specified operation.
    PNP_VetoWindowsService       = 0x00000004,
    ///The requested operation was rejected because of outstanding open handles.
    PNP_VetoOutstandingOpen      = 0x00000005,
    ///The device supports the specified operation, but the device rejected the operation.
    PNP_VetoDevice               = 0x00000006,
    ///The driver supports the specified operation, but the driver rejected the operation.
    PNP_VetoDriver               = 0x00000007,
    ///The device does not support the specified operation.
    PNP_VetoIllegalDeviceRequest = 0x00000008,
    ///There is insufficient power to perform the requested operation.
    PNP_VetoInsufficientPower    = 0x00000009,
    ///The device cannot be disabled.
    PNP_VetoNonDisableable       = 0x0000000a,
    ///The driver does not support the specified PnP operation.
    PNP_VetoLegacyDriver         = 0x0000000b,
    ///The caller has insufficient privileges to complete the operation.
    PNP_VetoInsufficientRights   = 0x0000000c,
    PNP_VetoAlreadyRemoved       = 0x0000000d,
}

alias CM_NOTIFY_FILTER_TYPE = int;
enum : int
{
    CM_NOTIFY_FILTER_TYPE_DEVICEINTERFACE = 0x00000000,
    CM_NOTIFY_FILTER_TYPE_DEVICEHANDLE    = 0x00000001,
    CM_NOTIFY_FILTER_TYPE_DEVICEINSTANCE  = 0x00000002,
    CM_NOTIFY_FILTER_TYPE_MAX             = 0x00000003,
}

///This enumeration identifies Plug and Play device event types.
alias CM_NOTIFY_ACTION = int;
enum : int
{
    ///For this value, set the <b>FilterType</b> member of the CM_NOTIFY_FILTER structure to
    ///<b>CM_NOTIFY_FILTER_TYPE_DEVICEINTERFACE</b>. This action indicates that a device interface that meets your
    ///filter criteria has been enabled.
    CM_NOTIFY_ACTION_DEVICEINTERFACEARRIVAL   = 0x00000000,
    ///For this value, set the <b>FilterType</b> member of the CM_NOTIFY_FILTER structure to
    ///<b>CM_NOTIFY_FILTER_TYPE_DEVICEINTERFACE</b>. This action indicates that a device interface that meets your
    ///filter criteria has been disabled.
    CM_NOTIFY_ACTION_DEVICEINTERFACEREMOVAL   = 0x00000001,
    ///For this value, set the <b>FilterType</b> member of the CM_NOTIFY_FILTER structure to
    ///<b>CM_NOTIFY_FILTER_TYPE_DEVICEHANDLE</b>. This action indicates that the device is being query removed. In order
    ///to allow the query remove to succeed, call CloseHandle to close any handles you have open to the device. If you
    ///do not do this, your open handle prevents the query remove of this device from succeeding. See Registering for
    ///Notification of Device Interface Arrival and Device Removal for more information. To veto the query remove,
    ///return ERROR_CANCELLED. However, it is recommended that you do not veto the query remove and allow it to happen
    ///by closing any handles you have open to the device.
    CM_NOTIFY_ACTION_DEVICEQUERYREMOVE        = 0x00000002,
    ///For this value, set the <b>FilterType</b> member of the CM_NOTIFY_FILTER structure to
    ///<b>CM_NOTIFY_FILTER_TYPE_DEVICEHANDLE</b>. This action indicates that the query remove of a device was failed. If
    ///you closed the handle to this device during a previous notification of <b>CM_NOTIFY_ACTION_DEVICEQUERYREMOVE</b>,
    ///open a new handle to the device to continue sending I/O requests to it. See Registering for Notification of
    ///Device Interface Arrival and Device Removal for more information.
    CM_NOTIFY_ACTION_DEVICEQUERYREMOVEFAILED  = 0x00000003,
    ///For this value, set the <b>FilterType</b> member of the CM_NOTIFY_FILTER structure to
    ///<b>CM_NOTIFY_FILTER_TYPE_DEVICEHANDLE</b>. The device will be removed. If you still have an open handle to the
    ///device, call CloseHandle to close the device handle. See Registering for Notification of Device Interface Arrival
    ///and Device Removal for more information. The system may send a <b>CM_NOTIFY_ACTION_DEVICEREMOVEPENDING</b>
    ///notification without sending a corresponding <b>CM_NOTIFY_ACTION_DEVICEQUERYREMOVE</b> message. In such cases,
    ///the applications and drivers must recover from the loss of the device as best they can.
    CM_NOTIFY_ACTION_DEVICEREMOVEPENDING      = 0x00000004,
    ///For this value, set the <b>FilterType</b> member of the CM_NOTIFY_FILTER structure to
    ///<b>CM_NOTIFY_FILTER_TYPE_DEVICEHANDLE</b>. The device has been removed. If you still have an open handle to the
    ///device, call CloseHandle to close the device handle. See Registering for Notification of Device Interface Arrival
    ///and Device Removal for more information. The system may send a <b>CM_NOTIFY_ACTION_DEVICEREMOVECOMPLETE</b>
    ///notification without sending corresponding <b>CM_NOTIFY_ACTION_DEVICEQUERYREMOVE</b> or
    ///<b>CM_NOTIFY_ACTION_DEVICEREMOVEPENDING</b> messages. In such cases, the applications and drivers must recover
    ///from the loss of the device as best they can.
    CM_NOTIFY_ACTION_DEVICEREMOVECOMPLETE     = 0x00000005,
    ///For this value, set the <b>FilterType</b> member of the CM_NOTIFY_FILTER structure to
    ///<b>CM_NOTIFY_FILTER_TYPE_DEVICEHANDLE</b>. This action is sent when a driver-defined custom event has occurred.
    CM_NOTIFY_ACTION_DEVICECUSTOMEVENT        = 0x00000006,
    ///For this value, set the <b>FilterType</b> member of the CM_NOTIFY_FILTER structure to
    ///<b>CM_NOTIFY_FILTER_TYPE_DEVICEINSTANCE</b>. This action is sent when a new device instance that meets your
    ///filter criteria has been enumerated.
    CM_NOTIFY_ACTION_DEVICEINSTANCEENUMERATED = 0x00000007,
    ///For this value, set the <b>FilterType</b> member of the CM_NOTIFY_FILTER structure to
    ///<b>CM_NOTIFY_FILTER_TYPE_DEVICEINSTANCE</b>. This action is sent when a device instance that meets your filter
    ///criteria becomes started.
    CM_NOTIFY_ACTION_DEVICEINSTANCESTARTED    = 0x00000008,
    ///For this value, set the <b>FilterType</b> member of the CM_NOTIFY_FILTER structure to
    ///<b>CM_NOTIFY_FILTER_TYPE_DEVICEINSTANCE</b>. This action is sent when a device instance that meets your filter
    ///criteria is no longer present.
    CM_NOTIFY_ACTION_DEVICEINSTANCEREMOVED    = 0x00000009,
    ///Do not use.
    CM_NOTIFY_ACTION_MAX                      = 0x0000000a,
}

// Callbacks

alias PDETECT_PROGRESS_NOTIFY = BOOL function(void* ProgressNotifyParam, uint DetectComplete);
alias PSP_DETSIG_CMPPROC = uint function(void* DeviceInfoSet, SP_DEVINFO_DATA* NewDeviceData, 
                                         SP_DEVINFO_DATA* ExistingDeviceData, void* CompareContext);
alias PCM_NOTIFY_CALLBACK = uint function(HCMNOTIFICATION__* hNotify, void* Context, CM_NOTIFY_ACTION Action, 
                                          char* EventData, uint EventDataSize);

// Structs


struct SP_ALTPLATFORM_INFO_V3
{
align (1):
    uint   cbSize;
    uint   Platform;
    uint   MajorVersion;
    uint   MinorVersion;
    ushort ProcessorArchitecture;
    union
    {
    align (1):
        ushort Reserved;
        ushort Flags;
    }
    uint   FirstValidatedMajorVersion;
    uint   FirstValidatedMinorVersion;
    ubyte  ProductType;
    ushort SuiteMask;
    uint   BuildNumber;
}

///An SP_DEVINFO_DATA structure defines a device instance that is a member of a device information set.
struct SP_DEVINFO_DATA
{
align (1):
    ///The size, in bytes, of the SP_DEVINFO_DATA structure. For more information, see the following Remarks section.
    uint   cbSize;
    ///The GUID of the device's setup class.
    GUID   ClassGuid;
    ///An opaque handle to the device instance (also known as a handle to the devnode). Some functions, such as
    ///<b>SetupDi</b><i>Xxx</i> functions, take the whole SP_DEVINFO_DATA structure as input to identify a device in a
    ///device information set. Other functions, such as <b>CM</b>_<i>Xxx</i> functions like CM_Get_DevNode_Status, take
    ///this <b>DevInst</b> handle as input.
    uint   DevInst;
    ///Reserved. For internal use only.
    size_t Reserved;
}

///An SP_DEVICE_INTERFACE_DATA structure defines a device interface in a device information set.
struct SP_DEVICE_INTERFACE_DATA
{
align (1):
    ///The size, in bytes, of the SP_DEVICE_INTERFACE_DATA structure. For more information, see the Remarks section.
    uint   cbSize;
    ///The GUID for the class to which the device interface belongs.
    GUID   InterfaceClassGuid;
    ///Can be one or more of the following:
    uint   Flags;
    ///Reserved. Do not use.
    size_t Reserved;
}

///An SP_DEVICE_INTERFACE_DETAIL_DATA structure contains the path for a device interface.
struct SP_DEVICE_INTERFACE_DETAIL_DATA_A
{
align (1):
    ///The size, in bytes, of the SP_DEVICE_INTERFACE_DETAIL_DATA structure. For more information, see the following
    ///Remarks section.
    uint    cbSize;
    ///A NULL-terminated string that contains the device interface path. This path can be passed to Win32 functions such
    ///as CreateFile.
    byte[1] DevicePath;
}

///An SP_DEVICE_INTERFACE_DETAIL_DATA structure contains the path for a device interface.
struct SP_DEVICE_INTERFACE_DETAIL_DATA_W
{
align (1):
    ///The size, in bytes, of the SP_DEVICE_INTERFACE_DETAIL_DATA structure. For more information, see the following
    ///Remarks section.
    uint      cbSize;
    ///A NULL-terminated string that contains the device interface path. This path can be passed to Win32 functions such
    ///as CreateFile.
    ushort[1] DevicePath;
}

///An SP_DEVINFO_LIST_DETAIL_DATA structure contains information about a device information set, such as its associated
///setup class GUID (if it has an associated setup class).
struct SP_DEVINFO_LIST_DETAIL_DATA_A
{
align (1):
    ///The size, in bytes, of the SP_DEVINFO_LIST_DETAIL_DATA structure.
    uint      cbSize;
    ///The setup class GUID that is associated with the device information set or GUID_NULL if there is no associated
    ///setup class.
    GUID      ClassGuid;
    ///If the device information set is for a remote computer, this member is a configuration manager machine handle for
    ///the remote computer. If the device information set is for the local computer, this member is <b>NULL</b>. This is
    ///typically the parameter that components use to access the remote computer. The <b>RemoteMachineName</b> contains
    ///a string, in case the component requires the name of the remote computer.
    HANDLE    RemoteMachineHandle;
    ///A NULL-terminated string that contains the name of the remote computer. If the device information set is for the
    ///local computer, this member is an empty string.
    byte[263] RemoteMachineName;
}

///An SP_DEVINFO_LIST_DETAIL_DATA structure contains information about a device information set, such as its associated
///setup class GUID (if it has an associated setup class).
struct SP_DEVINFO_LIST_DETAIL_DATA_W
{
align (1):
    ///The size, in bytes, of the SP_DEVINFO_LIST_DETAIL_DATA structure.
    uint        cbSize;
    ///The setup class GUID that is associated with the device information set or GUID_NULL if there is no associated
    ///setup class.
    GUID        ClassGuid;
    ///If the device information set is for a remote computer, this member is a configuration manager machine handle for
    ///the remote computer. If the device information set is for the local computer, this member is <b>NULL</b>. This is
    ///typically the parameter that components use to access the remote computer. The <b>RemoteMachineName</b> contains
    ///a string, in case the component requires the name of the remote computer.
    HANDLE      RemoteMachineHandle;
    ///A NULL-terminated string that contains the name of the remote computer. If the device information set is for the
    ///local computer, this member is an empty string.
    ushort[263] RemoteMachineName;
}

///An SP_DEVINSTALL_PARAMS structure contains device installation parameters associated with a particular device
///information element or associated globally with a device information set.
struct SP_DEVINSTALL_PARAMS_A
{
align (1):
    ///The size, in bytes, of the SP_DEVINSTALL_PARAMS structure.
    uint                cbSize;
    ///Flags that control installation and user interface operations. Some flags can be set before sending the device
    ///installation request while other flags are set automatically during the processing of some requests. <b>Flags</b>
    ///can be a combination of the following values. The flag values are listed in groups: writable by device
    ///installation applications and installers, read-only (only set by the OS), reserved, and obsolete. The first group
    ///lists flags that are writable:
    uint                Flags;
    ///Additional flags that provide control over installation and user interface operations. Some flags can be set
    ///before calling the device installer functions while other flags are set automatically during the processing of
    ///some functions. <b>FlagsEx</b> can be a combination of the following values. The flag values are listed in
    ///groups: writable by device installation applications and installers, read-only (only set by the OS), reserved,
    ///and obsolete. The first group lists flags that are writable:
    uint                FlagsEx;
    ///Window handle that will own the user interface dialogs related to this device.
    HWND                hwndParent;
    ///Callback used to handle events during file copying. An installer can use a callback, for example, to perform
    ///special processing when committing a file queue.
    PSP_FILE_CALLBACK_A InstallMsgHandler;
    ///Private data that is used by the <b>InstallMsgHandler</b> callback.
    void*               InstallMsgHandlerContext;
    ///A handle to a caller-supplied file queue where file operations should be queued but not committed. If you
    ///associate a file queue with a device information set (SetupDiSetDeviceInstallParams), you must disassociate the
    ///queue from the device information set before you delete the device information set. If you fail to disassociate
    ///the file queue, Windows cannot decrement its reference count on the device information set and cannot free the
    ///memory. This queue is only used if the DI_NOVCP flag is set, indicating that file operations should be enqueued
    ///but not committed.
    void*               FileQueue;
    ///A pointer for class-installer data. Co-installers must not use this field.
    size_t              ClassInstallReserved;
    ///Reserved. For internal use only.
    uint                Reserved;
    ///This path is used by the SetupDiBuildDriverInfoList function.
    byte[260]           DriverPath;
}

///An SP_DEVINSTALL_PARAMS structure contains device installation parameters associated with a particular device
///information element or associated globally with a device information set.
struct SP_DEVINSTALL_PARAMS_W
{
align (1):
    ///The size, in bytes, of the SP_DEVINSTALL_PARAMS structure.
    uint                cbSize;
    ///Flags that control installation and user interface operations. Some flags can be set before sending the device
    ///installation request while other flags are set automatically during the processing of some requests. <b>Flags</b>
    ///can be a combination of the following values. The flag values are listed in groups: writable by device
    ///installation applications and installers, read-only (only set by the OS), reserved, and obsolete. The first group
    ///lists flags that are writable:
    uint                Flags;
    ///Additional flags that provide control over installation and user interface operations. Some flags can be set
    ///before calling the device installer functions while other flags are set automatically during the processing of
    ///some functions. <b>FlagsEx</b> can be a combination of the following values. The flag values are listed in
    ///groups: writable by device installation applications and installers, read-only (only set by the OS), reserved,
    ///and obsolete. The first group lists flags that are writable:
    uint                FlagsEx;
    ///Window handle that will own the user interface dialogs related to this device.
    HWND                hwndParent;
    ///Callback used to handle events during file copying. An installer can use a callback, for example, to perform
    ///special processing when committing a file queue.
    PSP_FILE_CALLBACK_A InstallMsgHandler;
    ///Private data that is used by the <b>InstallMsgHandler</b> callback.
    void*               InstallMsgHandlerContext;
    ///A handle to a caller-supplied file queue where file operations should be queued but not committed. If you
    ///associate a file queue with a device information set (SetupDiSetDeviceInstallParams), you must disassociate the
    ///queue from the device information set before you delete the device information set. If you fail to disassociate
    ///the file queue, Windows cannot decrement its reference count on the device information set and cannot free the
    ///memory. This queue is only used if the DI_NOVCP flag is set, indicating that file operations should be enqueued
    ///but not committed.
    void*               FileQueue;
    ///A pointer for class-installer data. Co-installers must not use this field.
    size_t              ClassInstallReserved;
    ///Reserved. For internal use only.
    uint                Reserved;
    ///This path is used by the SetupDiBuildDriverInfoList function.
    ushort[260]         DriverPath;
}

///An SP_CLASSINSTALL_HEADER is the first member of any class install parameters structure. It contains the device
///installation request code that defines the format of the rest of the install parameters structure.
struct SP_CLASSINSTALL_HEADER
{
align (1):
    ///The size, in bytes, of the SP_CLASSINSTALL_HEADER structure.
    uint cbSize;
    ///The device installation request (DIF code) for the class install parameters structure. DIF codes have the format
    ///DIF_<i>XXX</i> and are defined in <i>Setupapi.h</i>. See Device Installation Function Codes for a complete
    ///description of DIF codes.
    uint InstallFunction;
}

struct SP_ENABLECLASS_PARAMS
{
align (1):
    SP_CLASSINSTALL_HEADER ClassInstallHeader;
    GUID ClassGuid;
    uint EnableMessage;
}

///An SP_PROPCHANGE_PARAMS structure corresponds to a DIF_PROPERTYCHANGE installation request.
struct SP_PROPCHANGE_PARAMS
{
align (1):
    ///An install request header that contains the header size and the DIF code for the request. See
    ///SP_CLASSINSTALL_HEADER.
    SP_CLASSINSTALL_HEADER ClassInstallHeader;
    ///State change action. Can be one of the following values:
    uint StateChange;
    ///Flags that specify the scope of a device property change. Can be one of the following:
    uint Scope;
    ///Supplies the hardware profile ID for profile-specific changes. Zero specifies the current hardware profile.
    uint HwProfile;
}

///An SP_REMOVEDEVICE_PARAMS structure corresponds to the DIF_REMOVE installation request.
struct SP_REMOVEDEVICE_PARAMS
{
align (1):
    ///An install request header that contains the header size and the DIF code for the request. See
    ///SP_CLASSINSTALL_HEADER.
    SP_CLASSINSTALL_HEADER ClassInstallHeader;
    ///Flags that indicate the scope of the device removal. Can be one of the following values:
    uint Scope;
    ///The hardware profile ID for profile-specific changes. Zero specifies the current hardware profile.
    uint HwProfile;
}

///An SP_UNREMOVEDEVICE_PARAMS structure corresponds to a DIF_UNREMOVE installation request.
struct SP_UNREMOVEDEVICE_PARAMS
{
align (1):
    ///An install request header that contains the header size and the DIF code for the request. See
    ///SP_CLASSINSTALL_HEADER.
    SP_CLASSINSTALL_HEADER ClassInstallHeader;
    ///A flag that indicates the scope of the unremove operation. This flag must always be set to
    ///DI_UNREMOVEDEVICE_CONFIGSPECIFIC.
    uint Scope;
    ///The hardware profile ID for profile-specific changes. Zero specifies the current hardware profile.
    uint HwProfile;
}

///An SP_SELECTDEVICE_PARAMS structure corresponds to a DIF_SELECTDEVICE installation request.
struct SP_SELECTDEVICE_PARAMS_A
{
    ///An install request header that contains the header size and the DIF code for the request. See
    ///SP_CLASSINSTALL_HEADER.
    SP_CLASSINSTALL_HEADER ClassInstallHeader;
    ///Buffer that contains an installer-provided window title for driver-selection windows. Windows uses this title for
    ///the window title for the Select Device dialogs.
    byte[60]  Title;
    ///Buffer that contains an installer-provided select-device instructions.
    byte[256] Instructions;
    ///Buffer that contains an installer-provided label for the list of drivers from which the user can select.
    byte[30]  ListLabel;
    ///Buffer that contains an installer-provided subtitle used in select-device wizards. This string is not used in
    ///select dialogs.
    byte[256] SubTitle;
    ///Reserved. For internal use only.
    ubyte[2]  Reserved;
}

///An SP_SELECTDEVICE_PARAMS structure corresponds to a DIF_SELECTDEVICE installation request.
struct SP_SELECTDEVICE_PARAMS_W
{
align (1):
    ///An install request header that contains the header size and the DIF code for the request. See
    ///SP_CLASSINSTALL_HEADER.
    SP_CLASSINSTALL_HEADER ClassInstallHeader;
    ///Buffer that contains an installer-provided window title for driver-selection windows. Windows uses this title for
    ///the window title for the Select Device dialogs.
    ushort[60]  Title;
    ///Buffer that contains an installer-provided select-device instructions.
    ushort[256] Instructions;
    ///Buffer that contains an installer-provided label for the list of drivers from which the user can select.
    ushort[30]  ListLabel;
    ///Buffer that contains an installer-provided subtitle used in select-device wizards. This string is not used in
    ///select dialogs.
    ushort[256] SubTitle;
}

///An SP_DETECTDEVICE_PARAMS structure corresponds to a DIF_DETECT installation request.
struct SP_DETECTDEVICE_PARAMS
{
align (1):
    ///An install request header that contains the size of the header and the DIF code for the request. See
    ///SP_CLASSINSTALL_HEADER.
    SP_CLASSINSTALL_HEADER ClassInstallHeader;
    ///A callback routine that displays a progress bar for the device detection operation. The callback routine is
    ///supplied by the device installation component that sends the DIF_DETECT request. The callback has the following
    ///prototype: ``` typedef BOOL (CALLBACK* PDETECT_PROGRESS_NOTIFY)( IN PVOID ProgressNotifyParam, IN DWORD
    ///DetectComplete ); ``` <i>ProgressNotifyParam</i> is an opaque "handle" that identifies the detection operation.
    ///This value is supplied by the device installation component that sent the DIF_DETECT request.
    ///<i>DetectComplete</i> is a value between 0 and 100 that indicates the percent completion. The class installer
    ///increments this value at various stages of its detection activities, to notify the user of its progress.
    PDETECT_PROGRESS_NOTIFY DetectProgressNotify;
    ///The opaque <b>ProgressNotifyParam</b> "handle" that the class installer passes to the progress callback routine.
    void* ProgressNotifyParam;
}

struct SP_INSTALLWIZARD_DATA
{
align (1):
    SP_CLASSINSTALL_HEADER ClassInstallHeader;
    uint          Flags;
    ptrdiff_t[20] DynamicPages;
    uint          NumDynamicPages;
    uint          DynamicPageFlags;
    uint          PrivateFlags;
    LPARAM        PrivateData;
    HWND          hwndWizardDlg;
}

///An SP_NEWDEVICEWIZARD_DATA structure is used by installers to extend the operation of the hardware installation
///wizard by adding custom pages. It is used with DIF_NEWDEVICEWIZARD_<i>XXX</i> installation requests.
struct SP_NEWDEVICEWIZARD_DATA
{
align (1):
    ///An install request header that contains the header size and the DIF code for the request. See
    ///SP_CLASSINSTALL_HEADER.
    SP_CLASSINSTALL_HEADER ClassInstallHeader;
    ///Reserved. Must be zero.
    uint          Flags;
    ///An array of property sheet page handles. An installer can add the handles of custom wizard pages to this array.
    ptrdiff_t[20] DynamicPages;
    ///The number of pages that are added to the<b> DynamicPages</b> array. Because the array index is zero-based, this
    ///value is also the index to the next free entry in the array. For example, if there are 3 pages in the array,
    ///<b>DynamicPages[</b>3<b>]</b> is the next entry for an installer to use.
    uint          NumDynamicPages;
    ///The handle to the top-level window of the hardware installation wizard .
    HWND          hwndWizardDlg;
}

///An SP_TROUBLESHOOTER_PARAMS structure corresponds to a DIF_TROUBLESHOOTER installation request.
struct SP_TROUBLESHOOTER_PARAMS_A
{
    ///An install request header that contains the header size and the DIF code for the request. See
    ///SP_CLASSINSTALL_HEADER.
    SP_CLASSINSTALL_HEADER ClassInstallHeader;
    ///Optionally specifies a string buffer that contains the path of a CHM file. The CHM file contains HTML help topics
    ///with troubleshooting information. The path must be fully qualified if the file is not in default system help
    ///directory (%SystemRoot%\help).
    byte[260] ChmFile;
    ///Optionally specifies a string buffer that contains the path of a topic in the <b>ChmFile</b>. This parameter
    ///identifies the page of the <b>ChmFile</b> that Windows should display first.
    byte[260] HtmlTroubleShooter;
}

///An SP_TROUBLESHOOTER_PARAMS structure corresponds to a DIF_TROUBLESHOOTER installation request.
struct SP_TROUBLESHOOTER_PARAMS_W
{
align (1):
    ///An install request header that contains the header size and the DIF code for the request. See
    ///SP_CLASSINSTALL_HEADER.
    SP_CLASSINSTALL_HEADER ClassInstallHeader;
    ///Optionally specifies a string buffer that contains the path of a CHM file. The CHM file contains HTML help topics
    ///with troubleshooting information. The path must be fully qualified if the file is not in default system help
    ///directory (%SystemRoot%\help).
    ushort[260] ChmFile;
    ///Optionally specifies a string buffer that contains the path of a topic in the <b>ChmFile</b>. This parameter
    ///identifies the page of the <b>ChmFile</b> that Windows should display first.
    ushort[260] HtmlTroubleShooter;
}

///An SP_POWERMESSAGEWAKE_PARAMS structure corresponds to a DIF_POWERMESSAGEWAKE installation request.
struct SP_POWERMESSAGEWAKE_PARAMS_A
{
    ///An install request header that contains the header size and the DIF code for the request. See
    ///SP_CLASSINSTALL_HEADER.
    SP_CLASSINSTALL_HEADER ClassInstallHeader;
    ///Buffer that contains a string of custom text. Windows displays this text on the power management page of the
    ///device properties display in Device Manager.
    byte[512] PowerMessageWake;
}

///An SP_POWERMESSAGEWAKE_PARAMS structure corresponds to a DIF_POWERMESSAGEWAKE installation request.
struct SP_POWERMESSAGEWAKE_PARAMS_W
{
align (1):
    ///An install request header that contains the header size and the DIF code for the request. See
    ///SP_CLASSINSTALL_HEADER.
    SP_CLASSINSTALL_HEADER ClassInstallHeader;
    ///Buffer that contains a string of custom text. Windows displays this text on the power management page of the
    ///device properties display in Device Manager.
    ushort[512] PowerMessageWake;
}

///An SP_DRVINFO_DATA structure contains information about a driver. This structure is a member of a driver information
///list that can be associated with a particular device instance or globally with a device information set.
struct SP_DRVINFO_DATA_V2_A
{
align (1):
    ///The size, in bytes, of the SP_DRVINFO_DATA structure. For more information, see the Remarks section in this
    ///topic.
    uint      cbSize;
    ///The type of driver represented by this structure. Must be one of the following values:
    uint      DriverType;
    ///Reserved. For internal use only.
    size_t    Reserved;
    ///A NULL-terminated string that describes the device supported by this driver.
    byte[256] Description;
    ///A NULL-terminated string that contains the name of the manufacturer of the device supported by this driver.
    byte[256] MfgName;
    ///A NULL-terminated string giving the provider of this driver. This is typically the name of the organization that
    ///creates the driver or INF file. <b>ProviderName</b> can be an empty string.
    byte[256] ProviderName;
    ///Date of the driver. From the <b>DriverVer</b> entry in the INF file. See the INF DDInstall Section for more
    ///information about the <b>DriverVer</b> entry.
    FILETIME  DriverDate;
    ///Version of the driver. From the <b>DriverVer</b> entry in the INF file.
    ulong     DriverVersion;
}

///An SP_DRVINFO_DATA structure contains information about a driver. This structure is a member of a driver information
///list that can be associated with a particular device instance or globally with a device information set.
struct SP_DRVINFO_DATA_V2_W
{
align (1):
    ///The size, in bytes, of the SP_DRVINFO_DATA structure. For more information, see the Remarks section in this
    ///topic.
    uint        cbSize;
    ///The type of driver represented by this structure. Must be one of the following values:
    uint        DriverType;
    ///Reserved. For internal use only.
    size_t      Reserved;
    ///A NULL-terminated string that describes the device supported by this driver.
    ushort[256] Description;
    ///A NULL-terminated string that contains the name of the manufacturer of the device supported by this driver.
    ushort[256] MfgName;
    ///A NULL-terminated string giving the provider of this driver. This is typically the name of the organization that
    ///creates the driver or INF file. <b>ProviderName</b> can be an empty string.
    ushort[256] ProviderName;
    ///Date of the driver. From the <b>DriverVer</b> entry in the INF file. See the INF DDInstall Section for more
    ///information about the <b>DriverVer</b> entry.
    FILETIME    DriverDate;
    ///Version of the driver. From the <b>DriverVer</b> entry in the INF file.
    ulong       DriverVersion;
}

///An SP_DRVINFO_DATA structure contains information about a driver. This structure is a member of a driver information
///list that can be associated with a particular device instance or globally with a device information set.
struct SP_DRVINFO_DATA_V1_A
{
align (1):
    ///The size, in bytes, of the SP_DRVINFO_DATA structure. For more information, see the Remarks section in this
    ///topic.
    uint      cbSize;
    ///The type of driver represented by this structure. Must be one of the following values:
    uint      DriverType;
    ///Reserved. For internal use only.
    size_t    Reserved;
    ///A NULL-terminated string that describes the device supported by this driver.
    byte[256] Description;
    ///A NULL-terminated string that contains the name of the manufacturer of the device supported by this driver.
    byte[256] MfgName;
    ///A NULL-terminated string giving the provider of this driver. This is typically the name of the organization that
    ///creates the driver or INF file. <b>ProviderName</b> can be an empty string.
    byte[256] ProviderName;
}

///An SP_DRVINFO_DATA structure contains information about a driver. This structure is a member of a driver information
///list that can be associated with a particular device instance or globally with a device information set.
struct SP_DRVINFO_DATA_V1_W
{
align (1):
    ///The size, in bytes, of the SP_DRVINFO_DATA structure. For more information, see the Remarks section in this
    ///topic.
    uint        cbSize;
    ///The type of driver represented by this structure. Must be one of the following values:
    uint        DriverType;
    ///Reserved. For internal use only.
    size_t      Reserved;
    ///A NULL-terminated string that describes the device supported by this driver.
    ushort[256] Description;
    ///A NULL-terminated string that contains the name of the manufacturer of the device supported by this driver.
    ushort[256] MfgName;
    ///A NULL-terminated string giving the provider of this driver. This is typically the name of the organization that
    ///creates the driver or INF file. <b>ProviderName</b> can be an empty string.
    ushort[256] ProviderName;
}

///An SP_DRVINFO_DETAIL_DATA structure contains detailed information about a particular driver information structure.
struct SP_DRVINFO_DETAIL_DATA_A
{
align (1):
    ///The size, in bytes, of the SP_DRVINFO_DETAIL_DATA structure.
    uint      cbSize;
    ///Date of the INF file for this driver.
    FILETIME  InfDate;
    ///The offset, in characters, from the beginning of the <b>HardwareID</b> buffer where the CompatIDs list begins.
    ///This value can also be used to determine whether there is a hardware ID that precedes the CompatIDs list. If this
    ///value is greater than 1, the first string in the <b>HardwareID</b> buffer is the hardware ID. If this value is
    ///less than or equal to 1, there is no hardware ID.
    uint      CompatIDsOffset;
    ///The length, in characters, of the CompatIDs list starting at offset <b>CompatIDsOffset</b> from the beginning of
    ///the <b>HardwareID</b> buffer. If <b>CompatIDsLength</b> is nonzero, the CompatIDs list contains one or more
    ///NULL-terminated strings with an additional NULL character at the end of the list. If <b>CompatIDsLength</b> is
    ///zero, the CompatIDs list is empty. In that case, there is no additional NULL character at the end of the list.
    uint      CompatIDsLength;
    ///Reserved. For internal use only.
    size_t    Reserved;
    ///A NULL-terminated string that contains the name of the INF DDInstall section for this driver. This must be the
    ///basic <i>DDInstall</i> section name, such as <b>InstallSec</b>, without any OS/architecture-specific extensions.
    byte[256] SectionName;
    ///A NULL-terminated string that contains the full-qualified name of the INF file for this driver.
    byte[260] InfFileName;
    ///A NULL-terminated string that describes the driver.
    byte[256] DrvDescription;
    ///A buffer that contains a list of IDs (a single hardware ID followed by a list of compatible IDs). These IDs
    ///correspond to the hardware ID and compatible IDs in the INF Models section. Each ID in the list is a
    ///NULL-terminated string. If the hardware ID exists (that is, if <b>CompatIDsOffset</b> is greater than one), this
    ///single NULL-terminated string is found at the beginning of the buffer. If the CompatIDs list is not empty (that
    ///is, if <b>CompatIDsLength</b> is not zero), the CompatIDs list starts at offset <b>CompatIDsOffset</b> from the
    ///beginning of this buffer, and is terminated with an additional NULL character at the end of the list.
    byte[1]   HardwareID;
}

///An SP_DRVINFO_DETAIL_DATA structure contains detailed information about a particular driver information structure.
struct SP_DRVINFO_DETAIL_DATA_W
{
align (1):
    ///The size, in bytes, of the SP_DRVINFO_DETAIL_DATA structure.
    uint        cbSize;
    ///Date of the INF file for this driver.
    FILETIME    InfDate;
    ///The offset, in characters, from the beginning of the <b>HardwareID</b> buffer where the CompatIDs list begins.
    ///This value can also be used to determine whether there is a hardware ID that precedes the CompatIDs list. If this
    ///value is greater than 1, the first string in the <b>HardwareID</b> buffer is the hardware ID. If this value is
    ///less than or equal to 1, there is no hardware ID.
    uint        CompatIDsOffset;
    ///The length, in characters, of the CompatIDs list starting at offset <b>CompatIDsOffset</b> from the beginning of
    ///the <b>HardwareID</b> buffer. If <b>CompatIDsLength</b> is nonzero, the CompatIDs list contains one or more
    ///NULL-terminated strings with an additional NULL character at the end of the list. If <b>CompatIDsLength</b> is
    ///zero, the CompatIDs list is empty. In that case, there is no additional NULL character at the end of the list.
    uint        CompatIDsLength;
    ///Reserved. For internal use only.
    size_t      Reserved;
    ///A NULL-terminated string that contains the name of the INF DDInstall section for this driver. This must be the
    ///basic <i>DDInstall</i> section name, such as <b>InstallSec</b>, without any OS/architecture-specific extensions.
    ushort[256] SectionName;
    ///A NULL-terminated string that contains the full-qualified name of the INF file for this driver.
    ushort[260] InfFileName;
    ///A NULL-terminated string that describes the driver.
    ushort[256] DrvDescription;
    ///A buffer that contains a list of IDs (a single hardware ID followed by a list of compatible IDs). These IDs
    ///correspond to the hardware ID and compatible IDs in the INF Models section. Each ID in the list is a
    ///NULL-terminated string. If the hardware ID exists (that is, if <b>CompatIDsOffset</b> is greater than one), this
    ///single NULL-terminated string is found at the beginning of the buffer. If the CompatIDs list is not empty (that
    ///is, if <b>CompatIDsLength</b> is not zero), the CompatIDs list starts at offset <b>CompatIDsOffset</b> from the
    ///beginning of this buffer, and is terminated with an additional NULL character at the end of the list.
    ushort[1]   HardwareID;
}

///An SP_DRVINSTALL_PARAMS structure contains driver installation parameters associated with a particular driver
///information element.
struct SP_DRVINSTALL_PARAMS
{
align (1):
    ///The size, in bytes, of the SP_DRVINSTALL_PARAMS structure.
    uint   cbSize;
    ///The rank match of this driver. Ranges from 0 to <i>n</i>, where 0 is the most compatible.
    uint   Rank;
    ///Flags that control functions operating on this driver. Can be a combination of the following:
    uint   Flags;
    ///A field a class installer can use to store private data. Co-installers should not use this field.
    size_t PrivateData;
    ///Reserved. For internal use only.
    uint   Reserved;
}

struct COINSTALLER_CONTEXT_DATA
{
align (1):
    BOOL  PostProcessing;
    uint  InstallResult;
    void* PrivateData;
}

///An SP_CLASSIMAGELIST_DATA structure describes a class image list.
struct SP_CLASSIMAGELIST_DATA
{
align (1):
    ///The size, in bytes, of the SP_CLASSIMAGE_DATA structure.
    uint       cbSize;
    ///A handle to the class image list.
    HIMAGELIST ImageList;
    ///Reserved. For internal use only.
    size_t     Reserved;
}

///An SP_PROPSHEETPAGE_REQUEST structure can be passed as the first parameter (<i>lpv</i>) to the
///<b>ExtensionPropSheetPageProc</b> entry point in the SetupAPI DLL. <b>ExtensionPropSheetPageProc</b> is used to
///retrieve a handle to a specified property sheet page. For information about <b>ExtensionPropSheetPageProc</b> and
///related functions, see the Microsoft Windows SDK documentation.
struct SP_PROPSHEETPAGE_REQUEST
{
align (1):
    ///The size, in bytes, of the SP_PROPSHEETPAGE_REQUEST structure.
    uint             cbSize;
    ///The property sheet page to add to the property sheet. Can be one of the following values:
    uint             PageRequested;
    ///The handle for the device information set that contains the device being installed.
    void*            DeviceInfoSet;
    ///A pointer to an SP_DEVINFO_DATA structure for the device being installed.
    SP_DEVINFO_DATA* DeviceInfoData;
}

struct SP_BACKUP_QUEUE_PARAMS_V2_A
{
align (1):
    uint      cbSize;
    byte[260] FullInfPath;
    int       FilenameOffset;
    byte[260] ReinstallInstance;
}

struct SP_BACKUP_QUEUE_PARAMS_V2_W
{
align (1):
    uint        cbSize;
    ushort[260] FullInfPath;
    int         FilenameOffset;
    ushort[260] ReinstallInstance;
}

struct SP_BACKUP_QUEUE_PARAMS_V1_A
{
align (1):
    uint      cbSize;
    byte[260] FullInfPath;
    int       FilenameOffset;
}

struct SP_BACKUP_QUEUE_PARAMS_V1_W
{
align (1):
    uint        cbSize;
    ushort[260] FullInfPath;
    int         FilenameOffset;
}

///The CONFLICT_DETAILS structure is used as a parameter to the CM_Get_Resource_Conflict_Details function.
struct CONFLICT_DETAILS_A
{
    ///Size, in bytes, of the CONFLICT_DETAILS structure.
    uint      CD_ulSize;
    ///One or more bit flags supplied by the caller of <b>CM_Get_Resource_Conflict_Details</b>. The bit flags are
    ///described in the following table. <table> <tr> <th>Flag</th> <th>Description</th> </tr> <tr> <td>
    ///CM_CDMASK_DEVINST </td> <td> If set, <b>CM_Get_Resource_Conflict_Details</b> supplies a value for the
    ///<b>CD_dnDevInst</b> member. </td> </tr> <tr> <td> CM_CDMASK_RESDES </td> <td> <i>Not used.</i> </td> </tr> <tr>
    ///<td> CM_CDMASK_FLAGS </td> <td> If set, <b>CM_Get_Resource_Conflict_Details</b> supplies a value for the
    ///<b>CD_ulFlags</b> member. </td> </tr> <tr> <td> CM_CDMASK_DESCRIPTION </td> <td> If set,
    ///<b>CM_Get_Resource_Conflict_Details</b> supplies a value for the <b>CD_szDescription</b> member. </td> </tr>
    ///</table>
    uint      CD_ulMask;
    ///If CM_CDMASK_DEVINST is set in <b>CD_ulMask</b>, this member will receive a handle to a device instance that has
    ///conflicting resources. If a handle is not obtainable, the member receives -1.
    uint      CD_dnDevInst;
    ///<i>Not used.</i>
    size_t    CD_rdResDes;
    ///If CM_CDMASK_FLAGS is set in <b>CD_ulMask</b>, this member can receive bit flags listed in the following table.
    ///<table> <tr> <th>Flag</th> <th>Description</th> </tr> <tr> <td> CM_CDFLAGS_DRIVER </td> <td> If set, the string
    ///contained in the <b>CD_szDescription</b> member represents a driver name instead of a device name, and
    ///<b>CD_dnDevInst</b> is -1. </td> </tr> <tr> <td> CM_CDFLAGS_ROOT_OWNED </td> <td> If set, the conflicting
    ///resources are owned by the root device (that is, the HAL), and <b>CD_dnDevInst</b> is -1. </td> </tr> <tr> <td>
    ///CM_CDFLAGS_RESERVED </td> <td> If set, the owner of the conflicting resources cannot be determined, and
    ///<b>CD_dnDevInst</b> is -1. </td> </tr> </table>
    uint      CD_ulFlags;
    ///If CM_CDMASK_DESCRIPTION is set in <b>CD_ulMask</b>, this member will receive a NULL-terminated text string
    ///representing a description of the device that owns the resources. If CM_CDFLAGS_DRIVER is set in
    ///<b>CD_ulFlags</b>, this string represents a driver name. If CM_CDFLAGS_ROOT_OWNED or CM_CDFLAGS_RESERVED is set,
    ///the string value is <b>NULL</b>.
    byte[260] CD_szDescription;
}

///The CONFLICT_DETAILS structure is used as a parameter to the CM_Get_Resource_Conflict_Details function.
struct CONFLICT_DETAILS_W
{
    ///Size, in bytes, of the CONFLICT_DETAILS structure.
    uint        CD_ulSize;
    ///One or more bit flags supplied by the caller of <b>CM_Get_Resource_Conflict_Details</b>. The bit flags are
    ///described in the following table. <table> <tr> <th>Flag</th> <th>Description</th> </tr> <tr> <td>
    ///CM_CDMASK_DEVINST </td> <td> If set, <b>CM_Get_Resource_Conflict_Details</b> supplies a value for the
    ///<b>CD_dnDevInst</b> member. </td> </tr> <tr> <td> CM_CDMASK_RESDES </td> <td> <i>Not used.</i> </td> </tr> <tr>
    ///<td> CM_CDMASK_FLAGS </td> <td> If set, <b>CM_Get_Resource_Conflict_Details</b> supplies a value for the
    ///<b>CD_ulFlags</b> member. </td> </tr> <tr> <td> CM_CDMASK_DESCRIPTION </td> <td> If set,
    ///<b>CM_Get_Resource_Conflict_Details</b> supplies a value for the <b>CD_szDescription</b> member. </td> </tr>
    ///</table>
    uint        CD_ulMask;
    ///If CM_CDMASK_DEVINST is set in <b>CD_ulMask</b>, this member will receive a handle to a device instance that has
    ///conflicting resources. If a handle is not obtainable, the member receives -1.
    uint        CD_dnDevInst;
    ///<i>Not used.</i>
    size_t      CD_rdResDes;
    ///If CM_CDMASK_FLAGS is set in <b>CD_ulMask</b>, this member can receive bit flags listed in the following table.
    ///<table> <tr> <th>Flag</th> <th>Description</th> </tr> <tr> <td> CM_CDFLAGS_DRIVER </td> <td> If set, the string
    ///contained in the <b>CD_szDescription</b> member represents a driver name instead of a device name, and
    ///<b>CD_dnDevInst</b> is -1. </td> </tr> <tr> <td> CM_CDFLAGS_ROOT_OWNED </td> <td> If set, the conflicting
    ///resources are owned by the root device (that is, the HAL), and <b>CD_dnDevInst</b> is -1. </td> </tr> <tr> <td>
    ///CM_CDFLAGS_RESERVED </td> <td> If set, the owner of the conflicting resources cannot be determined, and
    ///<b>CD_dnDevInst</b> is -1. </td> </tr> </table>
    uint        CD_ulFlags;
    ///If CM_CDMASK_DESCRIPTION is set in <b>CD_ulMask</b>, this member will receive a NULL-terminated text string
    ///representing a description of the device that owns the resources. If CM_CDFLAGS_DRIVER is set in
    ///<b>CD_ulFlags</b>, this string represents a driver name. If CM_CDFLAGS_ROOT_OWNED or CM_CDFLAGS_RESERVED is set,
    ///the string value is <b>NULL</b>.
    ushort[260] CD_szDescription;
}

///The MEM_RANGE structure specifies a resource requirements list that describes memory usage for a device instance. For
///more information about resource requirements lists, see Hardware Resources.
struct MEM_RANGE
{
align (1):
    ///Mask used to specify the memory address boundary on which the first allocated memory address must be aligned.
    ulong MR_Align;
    ///The number of bytes of memory required by the device.
    uint  MR_nBytes;
    ///The lowest-numbered of a range of contiguous memory addresses that can be allocated to the device.
    ulong MR_Min;
    ///The highest-numbered of a range of contiguous memory addresses that can be allocated to the device.
    ulong MR_Max;
    ///One bit flag from [MEM_DES](/windows/desktop/api/cfgmgr32/ns-cfgmgr32-mem_des) structure.
    uint  MR_Flags;
    ///<i>For internal use only.</i>
    uint  MR_Reserved;
}

///The MEM_DES structure is used for specifying either a resource list or a resource requirements list that describes
///memory usage for a device instance. For more information about resource lists and resource requirements lists, see
///Hardware Resources.
struct MEM_DES
{
align (1):
    uint  MD_Count;
    ///Must be set to the constant value <b>MType_Range</b>.
    uint  MD_Type;
    ulong MD_Alloc_Base;
    ulong MD_Alloc_End;
    ///One bit flag from <i>each</i> of the flag sets described in the following table. <table> <tr> <th></th>
    ///<th>Flag</th> <th>Definition</th> </tr> <tr> <td colspan="2"> <i>Read-Only Flags</i> </td> <td></td> </tr> <tr>
    ///<td></td> <td> <b>fMD_ROM</b> </td> <td> The specified memory range is read-only. </td> </tr> <tr> <td></td> <td>
    ///<b>fMD_RAM</b> </td> <td> The specified memory range is not read-only. </td> </tr> <tr> <td></td> <td>
    ///<b>mMD_MemoryType</b> </td> <td> Bitmask for the bit within <b>MD_Flags</b> that specifies the read-only
    ///attribute. </td> </tr> <tr> <td colspan="2"> <i>Write-Only Flags</i> </td> <td></td> </tr> <tr> <td></td> <td>
    ///<b>fMD_ReadDisallowed</b> </td> <td> The specified memory range is write-only. </td> </tr> <tr> <td></td> <td>
    ///<b>fMD_ReadAllowed</b> </td> <td> The specified memory range is not write-only. </td> </tr> <tr> <td></td> <td>
    ///<b>mMD_Readable</b> </td> <td> Bitmask for the bit within <b>MD_Flags</b> that specifies the write-only
    ///attribute. </td> </tr> <tr> <td colspan="2"> <i>Address Size Flags</i> </td> <td></td> </tr> <tr> <td></td> <td>
    ///<b>fMD_24</b> </td> <td> 24-bit addressing (<i>not used</i>). </td> </tr> <tr> <td></td> <td> <b>fMD_32</b> </td>
    ///<td> 32-bit addressing. </td> </tr> <tr> <td></td> <td> <b>mMD_32_24</b> </td> <td> Bitmask for the bit within
    ///<b>MD_Flags</b> that specifies the address size. </td> </tr> <tr> <td colspan="2"> <i>Prefetch Flags</i> </td>
    ///<td></td> </tr> <tr> <td></td> <td> <b>fMD_PrefetchAllowed</b> </td> <td> The specified memory range can be
    ///prefetched. </td> </tr> <tr> <td></td> <td> <b>fMD_PrefetchDisallowed</b> </td> <td> The specified memory range
    ///cannot be prefetched. </td> </tr> <tr> <td></td> <td> <b>mMD_Prefetchable</b> </td> <td> Bitmask for the bit
    ///within <b>MD_Flags</b> that specifies the prefetch ability. </td> </tr> <tr> <td colspan="2"> <i>Caching
    ///Flags</i> </td> <td></td> </tr> <tr> <td></td> <td> <b>fMD_Cacheable</b> </td> <td> The specified memory range
    ///can be cached. </td> </tr> <tr> <td></td> <td> <b>fMD_NonCacheable</b> </td> <td> The specified memory range
    ///cannot be cached. </td> </tr> <tr> <td></td> <td> <b>mMD_Cacheable</b> </td> <td> Bitmask for the bit within
    ///<b>MD_Flags</b> that specifies the caching ability. </td> </tr> <tr> <td colspan="2"> <i>Combined-Write Caching
    ///Flags</i> </td> <td></td> </tr> <tr> <td></td> <td> <b>fMD_CombinedWriteAllowed</b> </td> <td> Combined-write
    ///caching is allowed. </td> </tr> <tr> <td></td> <td> <b>fMD_CombinedWriteDisallowed</b> </td> <td> Combined-write
    ///caching is not allowed. </td> </tr> <tr> <td></td> <td> <b>mMD_CombinedWrite</b> </td> <td> Bitmask for the bit
    ///within <b>MD_Flags</b> that specifies the combine-write caching ability. </td> </tr> </table>
    uint  MD_Flags;
    ///<i>For internal use only.</i>
    uint  MD_Reserved;
}

///The MEM_RESOURCE structure is used for specifying either a resource list or a resource requirements list that
///describes memory usage for a device instance. For more information about resource lists and resource requirements
///lists, see Hardware Resources.
struct MEM_RESOURCE
{
    ///A [MEM_DES](/windows/desktop/api/cfgmgr32/ns-cfgmgr32-mem_des) structure.
    MEM_DES      MEM_Header;
    MEM_RANGE[1] MEM_Data;
}

struct Mem_Large_Range_s
{
align (1):
    ulong MLR_Align;
    ulong MLR_nBytes;
    ulong MLR_Min;
    ulong MLR_Max;
    uint  MLR_Flags;
    uint  MLR_Reserved;
}

struct Mem_Large_Des_s
{
align (1):
    uint  MLD_Count;
    uint  MLD_Type;
    ulong MLD_Alloc_Base;
    ulong MLD_Alloc_End;
    uint  MLD_Flags;
    uint  MLD_Reserved;
}

struct Mem_Large_Resource_s
{
    Mem_Large_Des_s      MEM_LARGE_Header;
    Mem_Large_Range_s[1] MEM_LARGE_Data;
}

///The IO_RANGE structure specifies a resource requirements list that describes I/O port usage for a device instance.
///For more information about resource requirements lists, see Hardware Resources.
struct IO_RANGE
{
align (1):
    ///Mask used to specify the port address boundary on which the first allocated I/O port address must be aligned.
    ulong IOR_Align;
    ///The number of I/O port addresses required by the device.
    uint  IOR_nPorts;
    ///The lowest-numbered of a range of contiguous I/O port addresses that can be allocated to the device.
    ulong IOR_Min;
    ///The highest-numbered of a range of contiguous I/O port addresses that can be allocated to the device.
    ulong IOR_Max;
    ///One bit flag from [IO_DES](/windows/desktop/api/cfgmgr32/ns-cfgmgr32-io_des) structure. For more information, see
    ///the following <b>Remarks</b> section.
    uint  IOR_RangeFlags;
    ///One of the bit flags described in the following table. <table> <tr> <th>Flag</th> <th>Definition</th> </tr> <tr>
    ///<td> IO_ALIAS_10_BIT_DECODE </td> <td> The device decodes 10 bits of the port address. </td> </tr> <tr> <td>
    ///IO_ALIAS_12_BIT_DECODE </td> <td> The device decodes 12 bits of the port address. </td> </tr> <tr> <td>
    ///IO_ALIAS_16_BIT_DECODE </td> <td> The device decodes 16 bits of the port address. </td> </tr> <tr> <td>
    ///IO_ALIAS_POSITIVE_DECODE </td> <td> The device uses "positive decode" instead of "subtractive decode." </td>
    ///</tr> </table> For more information, see the following <b>Remarks</b> section.
    ulong IOR_Alias;
}

///The IO_DES structure is used for specifying either a resource list or a resource requirements list that describes I/O
///port usage for a device instance. For more information about resource lists and resource requirements lists, see
///Hardware Resources.
struct IO_DES
{
align (1):
    uint  IOD_Count;
    ///Must be set to the constant value <b>IOType_Range</b>.
    uint  IOD_Type;
    ulong IOD_Alloc_Base;
    ulong IOD_Alloc_End;
    ///One bit flag from <i>each</i> of the flag sets described in the following table. <table> <tr> <th></th>
    ///<th>Flag</th> <th>Definition</th> </tr> <tr> <td colspan="2"> <i>Port Type Flags</i> </td> <td></td> </tr> <tr>
    ///<td></td> <td> <b>fIOD_IO</b> </td> <td> The device is accessed in I/O address space. </td> </tr> <tr> <td></td>
    ///<td> <b>fIOD_Memory</b> </td> <td> The device is accessed in memory address space. </td> </tr> <tr> <td></td>
    ///<td> <b>fIOD_PortType</b> </td> <td> Bitmask for the bits within <b>IOD_DesFlags</b> that specify the port type
    ///value. </td> </tr> <tr> <td colspan="2"> <i>Decode Flags</i> </td> <td></td> </tr> <tr> <td></td> <td>
    ///<b>fIOD_10_BIT_DECODE</b> </td> <td> The device decodes 10 bits of the port address. </td> </tr> <tr> <td></td>
    ///<td> <b>fIOD_12_BIT_DECODE</b> </td> <td> The device decodes 12 bits of the port address. </td> </tr> <tr>
    ///<td></td> <td> <b>fIOD_16_BIT_DECODE</b> </td> <td> The device decodes 16 bits of the port address. </td> </tr>
    ///<tr> <td></td> <td> <b>fIOD_POSITIVE_DECODE</b> </td> <td> The device uses "positive decode" instead of
    ///"subtractive decode." </td> </tr> <tr> <td></td> <td> <b>fIOD_DECODE</b> </td> <td> Bitmask for the bits within
    ///<b>IOD_DesFlags</b> that specify the decode value. </td> </tr> </table>
    uint  IOD_DesFlags;
}

///The IO_RESOURCE structure is used for specifying either a resource list or a resource requirements list that
///describes I/O port usage for a device instance. For more information about resource lists and resource requirements
///lists, see Hardware Resources.
struct IO_RESOURCE
{
    ///An [IO_DES](/windows/desktop/api/cfgmgr32/ns-cfgmgr32-io_des) structure.
    IO_DES      IO_Header;
    IO_RANGE[1] IO_Data;
}

///The DMA_RANGE structure specifies a resource requirements list that describes DMA channel usage for a device
///instance. For more information about resource requirements lists, see Hardware Resources.
struct DMA_RANGE
{
align (1):
    ///The lowest-numbered DMA channel that can be allocated to the device.
    uint DR_Min;
    ///The highest-numbered DMA channel that can be allocated to the device.
    uint DR_Max;
    ///One bit flag from [DMA_DES](/windows/desktop/api/cfgmgr32/ns-cfgmgr32-dma_des) structure.
    uint DR_Flags;
}

///The DMA_DES structure is used for specifying either a resource list or a resource requirements list that describes
///direct memory access (DMA) channel usage for a device instance. For more information about resource lists and
///resource requirements lists, see Hardware Resources.
struct DMA_DES
{
align (1):
    uint DD_Count;
    ///Must be set to the constant value <b>DType_Range</b>.
    uint DD_Type;
    ///One bit flag from <i>each</i> of the flag sets described in the following table. <table> <tr> <th></th>
    ///<th>Flag</th> <th>Definition</th> </tr> <tr> <td colspan="2"> <i>Channel Width Flags</i> </td> <td></td> </tr>
    ///<tr> <td></td> <td> <b>fDD_BYTE</b> </td> <td> 8-bit DMA channel. </td> </tr> <tr> <td></td> <td> <b>fDD_WORD</b>
    ///</td> <td> 16-bit DMA channel. </td> </tr> <tr> <td></td> <td> <b>fDD_DWORD</b> </td> <td> 32-bit DMA channel.
    ///</td> </tr> <tr> <td></td> <td> <b>fDD_BYTE_AND_WORD</b> </td> <td> 8-bit and 16-bit DMA channel. </td> </tr>
    ///<tr> <td></td> <td> <b>mDD_Width</b> </td> <td> Bitmask for the bits within <b>DD_Flags</b> that specify the
    ///channel width value. </td> </tr> <tr> <td colspan="2"> <i>Bus Mastering Flags</i> </td> <td></td> </tr> <tr>
    ///<td></td> <td> <b>fDD_NoBusMaster</b> </td> <td> No bus mastering. </td> </tr> <tr> <td></td> <td>
    ///<b>fDD_BusMaster</b> </td> <td> Bus mastering. </td> </tr> <tr> <td></td> <td> <b>mDD_BusMaster</b> </td> <td>
    ///Bitmask for the bits within <b>DD_Flags</b> that specify the bus mastering value. </td> </tr> <tr> <td
    ///colspan="2"> <i>DMA Type Flags</i> </td> <td></td> </tr> <tr> <td></td> <td> <b>fDD_TypeStandard</b> </td> <td>
    ///Standard DMA. </td> </tr> <tr> <td></td> <td> <b>fDD_TypeA</b> </td> <td> Type A DMA. </td> </tr> <tr> <td></td>
    ///<td> <b>fDD_TypeB</b> </td> <td> Type B DMA. </td> </tr> <tr> <td></td> <td> <b>fDD_TypeF</b> </td> <td> Type F
    ///DMA. </td> </tr> <tr> <td></td> <td> <b>mDD_Type</b> </td> <td> Bitmask for the bits within <b>DD_Flags</b> that
    ///specify the DMA type value. </td> </tr> </table>
    uint DD_Flags;
    uint DD_Alloc_Chan;
}

///The DMA_RESOURCE structure is used for specifying either a resource list or a resource requirements list that
///describes DMA channel usage for a device instance. For more information about resource list and resource requirements
///lists, see Hardware Resources.
struct DMA_RESOURCE
{
    ///A [DMA_DES](/windows/desktop/api/cfgmgr32/ns-cfgmgr32-dma_des) structure.
    DMA_DES      DMA_Header;
    DMA_RANGE[1] DMA_Data;
}

///The IRQ_RANGE structure specifies a resource requirements list that describes IRQ line usage for a device instance.
///For more information about resource requirements lists, see Hardware Resources.
struct IRQ_RANGE
{
align (1):
    ///The lowest-numbered of a range of contiguous IRQ lines that can be allocated to the device.
    uint IRQR_Min;
    ///The highest-numbered of a range of contiguous IRQ lines that can be allocated to the device.
    uint IRQR_Max;
    ///One bit flag from [IRQ_DES](/windows/desktop/api/cfgmgr32/ns-cfgmgr32-irq_des_32) structure.
    uint IRQR_Flags;
}

///The IRQ_DES structure is used for specifying either a resource list or a resource requirements list that describes
///IRQ line usage for a device instance. For more information about resource lists and resource requirements lists, see
///Hardware Resources.
struct IRQ_DES_32
{
align (1):
    uint IRQD_Count;
    ///Must be set to the constant value <b>IRQType_Range</b>.
    uint IRQD_Type;
    ///One bit flag from <i>each</i> of the flag sets described in the following table. <table> <tr> <th></th>
    ///<th>Flag</th> <th>Definition</th> </tr> <tr> <td colspan="2"> <i>Sharing Flags</i> </td> <td></td> </tr> <tr>
    ///<td></td> <td> <b>fIRQD_Exclusive</b> </td> <td> The IRQ line cannot be shared. </td> </tr> <tr> <td></td> <td>
    ///<b>fIRQD_Share</b> </td> <td> The IRQ line can be shared. </td> </tr> <tr> <td></td> <td> <b>mIRQD_Share</b>
    ///</td> <td> Bitmask for the bits within <b>IRQD_Flags</b> that specify the sharing value. </td> </tr> <tr> <td
    ///colspan="2"> <i>Triggering Flags</i> </td> <td></td> </tr> <tr> <td></td> <td> <b>fIRQD_Level</b> </td> <td> The
    ///IRQ line is level-triggered. </td> </tr> <tr> <td></td> <td> <b>fIRQD_Edge</b> </td> <td> The IRQ line is
    ///edge-triggered. </td> </tr> <tr> <td></td> <td> <b>mIRQD_Edge_Level</b> </td> <td> Bitmask for the bits within
    ///<b>IRQD_Flags</b> that specify the triggering value. </td> </tr> </table>
    uint IRQD_Flags;
    uint IRQD_Alloc_Num;
    uint IRQD_Affinity;
}

///The IRQ_DES structure is used for specifying either a resource list or a resource requirements list that describes
///IRQ line usage for a device instance. For more information about resource lists and resource requirements lists, see
///Hardware Resources.
struct IRQ_DES_64
{
align (1):
    uint  IRQD_Count;
    ///Must be set to the constant value <b>IRQType_Range</b>.
    uint  IRQD_Type;
    ///One bit flag from <i>each</i> of the flag sets described in the following table. <table> <tr> <th></th>
    ///<th>Flag</th> <th>Definition</th> </tr> <tr> <td colspan="2"> <i>Sharing Flags</i> </td> <td></td> </tr> <tr>
    ///<td></td> <td> <b>fIRQD_Exclusive</b> </td> <td> The IRQ line cannot be shared. </td> </tr> <tr> <td></td> <td>
    ///<b>fIRQD_Share</b> </td> <td> The IRQ line can be shared. </td> </tr> <tr> <td></td> <td> <b>mIRQD_Share</b>
    ///</td> <td> Bitmask for the bits within <b>IRQD_Flags</b> that specify the sharing value. </td> </tr> <tr> <td
    ///colspan="2"> <i>Triggering Flags</i> </td> <td></td> </tr> <tr> <td></td> <td> <b>fIRQD_Level</b> </td> <td> The
    ///IRQ line is level-triggered. </td> </tr> <tr> <td></td> <td> <b>fIRQD_Edge</b> </td> <td> The IRQ line is
    ///edge-triggered. </td> </tr> <tr> <td></td> <td> <b>mIRQD_Edge_Level</b> </td> <td> Bitmask for the bits within
    ///<b>IRQD_Flags</b> that specify the triggering value. </td> </tr> </table>
    uint  IRQD_Flags;
    uint  IRQD_Alloc_Num;
    ulong IRQD_Affinity;
}

///The IRQ_RESOURCE structure is used for specifying either a resource list or a resource requirements list that
///describes IRQ line usage for a device instance. For more information about resource lists and resource requirements
///lists, see Hardware Resources.
struct IRQ_RESOURCE_32
{
    ///An [IRQ_DES](/windows/desktop/api/cfgmgr32/ns-cfgmgr32-irq_des_32) structure.
    IRQ_DES_32   IRQ_Header;
    IRQ_RANGE[1] IRQ_Data;
}

///The IRQ_RESOURCE structure is used for specifying either a resource list or a resource requirements list that
///describes IRQ line usage for a device instance. For more information about resource lists and resource requirements
///lists, see Hardware Resources.
struct IRQ_RESOURCE_64
{
    ///An [IRQ_DES](/windows/desktop/api/cfgmgr32/ns-cfgmgr32-irq_des_32) structure.
    IRQ_DES_64   IRQ_Header;
    IRQ_RANGE[1] IRQ_Data;
}

struct DevPrivate_Range_s
{
align (1):
    uint PR_Data1;
    uint PR_Data2;
    uint PR_Data3;
}

struct DevPrivate_Des_s
{
align (1):
    uint PD_Count;
    uint PD_Type;
    uint PD_Data1;
    uint PD_Data2;
    uint PD_Data3;
    uint PD_Flags;
}

struct DevPrivate_Resource_s
{
    DevPrivate_Des_s PRV_Header;
    DevPrivate_Range_s[1] PRV_Data;
}

///The CS_DES structure is used for specifying a resource list that describes device class-specific resource usage for a
///device instance. For more information about resource lists, see Hardware Resources.
struct CS_DES
{
align (1):
    ///The number of elements in the byte array specified by <b>CSD_Signature</b>.
    uint     CSD_SignatureLength;
    ///Offset, in bytes, from the beginning of the <b>CSD_Signature</b> array to the beginning of a block of data. For
    ///example, if the data block follows the signature array, and if the signature array length is 16 bytes, then the
    ///value for <b>CSD_LegacyDataOffset</b> should be 16.
    uint     CSD_LegacyDataOffset;
    ///Length, in bytes, of the data block whose offset is specified by <b>CSD_LegacyDataOffset</b>.
    uint     CSD_LegacyDataSize;
    ///<i>Not used.</i>
    uint     CSD_Flags;
    ///A globally unique identifier (GUID) identifying a device setup class. If both <b>CSD_SignatureLength</b> and
    ///<b>CSD_LegacyDataSize</b> are zero, the GUID is null.
    GUID     CSD_ClassGuid;
    ///A byte array containing a class-specific signature.
    ubyte[1] CSD_Signature;
}

///The CS_RESOURCE structure is used for specifying a resource list that describes device class-specific resource usage
///for a device instance. For more information about resource lists, see Hardware Resources.
struct CS_RESOURCE
{
    ///A [CS_DES](/windows/desktop/api/cfgmgr32/ns-cfgmgr32-cs_des) structure.
    CS_DES CS_Header;
}

///The PCCARD_DES structure is used for specifying either a resource list or a resource requirements list that describes
///resource usage by a PC Card instance. For more information about resource lists and resource requirements lists, see
///Hardware Resources.
struct PCCARD_DES
{
align (1):
    ///Must be 1.
    uint      PCD_Count;
    ///<i>Not used.</i>
    uint      PCD_Type;
    ///One bit flag from <i>each</i> of the flag sets described in the following table. <table> <tr> <th></th>
    ///<th>Flag</th> <th>Definition</th> </tr> <tr> <td colspan="2"> <i>I/O Addressing Flags</i> </td> <td></td> </tr>
    ///<tr> <td></td> <td> fPCD_IO_8 </td> <td> The device uses 8-bit I/O addressing. </td> </tr> <tr> <td></td> <td>
    ///fPCD_IO_16 </td> <td> The device uses 16-bit I/O addressing. </td> </tr> <tr> <td></td> <td> mPCD_IO_8_16 </td>
    ///<td> Bitmask for the bit within <b>PCD_Flags</b> that specifies 8-bit or 16-bit I/O addressing. </td> </tr> <tr>
    ///<td colspan="2"> <i>Memory Addressing Flags</i> </td> <td></td> </tr> <tr> <td></td> <td> fPCD_MEM_8 </td> <td>
    ///The device uses 8-bit memory addressing. </td> </tr> <tr> <td></td> <td> fPCD_MEM_16 </td> <td> The device uses
    ///16-bit memory addressing. </td> </tr> <tr> <td></td> <td> mPCD_MEM_8_16 </td> <td> Bitmask for the bit within
    ///<b>PCD_Flags</b> that specifies 8-bit or 16-bit memory addressing. </td> </tr> </table>
    uint      PCD_Flags;
    ///The 8-bit index value used to locate the device's configuration.
    ubyte     PCD_ConfigIndex;
    ///<i>Not used.</i>
    ubyte[3]  PCD_Reserved;
    ///<i>Optional</i>, card base address of the first memory window.
    uint      PCD_MemoryCardBase1;
    ///<i>Optional</i>, card base address of the second memory window.
    uint      PCD_MemoryCardBase2;
    ///This member is currently unused.
    uint[2]   PCD_MemoryCardBase;
    ///This member is currently unused.
    ushort[2] PCD_MemoryFlags;
    ///This member is currently unused.
    ubyte[2]  PCD_IoFlags;
}

///The PCCARD_RESOURCE structure is used for specifying either a resource list or a resource requirements list that
///describes resource usage by a PC Card instance. For more information about resource lists and resource requirements
///lists, see Hardware Resources.
struct PCCARD_RESOURCE
{
    ///A [PCCARD_DES](/windows/desktop/api/cfgmgr32/ns-cfgmgr32-pccard_des) structure.
    PCCARD_DES PcCard_Header;
}

///The MFCARD_DES structure is used for specifying either a resource list or a resource requirements list that describes
///resource usage by <i>one</i> of the hardware functions provided by an instance of a multifunction device. For more
///information about resource lists and resource requirements lists, see Hardware Resources.
struct MFCARD_DES
{
align (1):
    ///Must be 1.
    uint     PMF_Count;
    ///<i>Not used.</i>
    uint     PMF_Type;
    ///One bit flag is defined, as described in the following table. <table> <tr> <th>Flag</th> <th>Definition</th>
    ///</tr> <tr> <td> fPMF_AUDIO_ENABLE </td> <td> If set, audio is enabled. </td> </tr> </table>
    uint     PMF_Flags;
    ///Contents of the 8-bit PCMCIA Configuration Option Register.
    ubyte    PMF_ConfigOptions;
    ///Zero-based index indicating the [IO_RESOURCE](/windows/desktop/api/cfgmgr32/ns-cfgmgr32-io_resource) structure
    ///that describes the I/O resources for the hardware function being described by this MFCARD_DES structure.
    ubyte    PMF_IoResourceIndex;
    ///<i>Not used.</i>
    ubyte[2] PMF_Reserved;
    ///Offset from the beginning of the card's attribute memory space to the base configuration register address.
    uint     PMF_ConfigRegisterBase;
}

///The MFCARD_RESOURCE structure is used for specifying either a resource list or a resource requirements list that
///describes resource usage by <i>one</i> of the hardware functions provided by an instance of a multifunction device.
///For more information about resource lists and resource requirements lists, see Hardware Resources.
struct MFCARD_RESOURCE
{
    ///A [MFCARD_DES](/windows/desktop/api/cfgmgr32/ns-cfgmgr32-mfcard_des) structure.
    MFCARD_DES MfCard_Header;
}

///The BUSNUMBER_RANGE structure specifies a resource requirements list that describes bus number usage for a device
///instance. For more information about resource requirements lists, see Hardware Resources.
struct BUSNUMBER_RANGE
{
align (1):
    ///The lowest-numbered of a range of contiguous bus numbers that can be allocated to the device.
    uint BUSR_Min;
    ///The highest-numbered of a range of contiguous bus numbers that can be allocated to the device.
    uint BUSR_Max;
    ///The number of contiguous bus numbers required by the device.
    uint BUSR_nBusNumbers;
    ///<i>Not used.</i>
    uint BUSR_Flags;
}

///The BUSNUMBER_DES structure is used for specifying either a resource list or a resource requirements list that
///describes bus number usage for a device instance. For more information about resource lists and resource requirements
///lists, see Hardware Resources.
struct BUSNUMBER_DES
{
align (1):
    uint BUSD_Count;
    ///Must be set to the constant value <b>BusNumberType_Range</b>.
    uint BUSD_Type;
    ///<i>Not used.</i>
    uint BUSD_Flags;
    uint BUSD_Alloc_Base;
    uint BUSD_Alloc_End;
}

///The BUSNUMBER_RESOURCE structure specifies either a resource list or a resource requirements list that describes bus
///number usage for a device instance. For more information about resource lists and resource requirements lists, see
///Hardware Resources.
struct BUSNUMBER_RESOURCE
{
    ///A [BUSNUMBER_DES](/windows/desktop/api/cfgmgr32/ns-cfgmgr32-busnumber_des) structure.
    BUSNUMBER_DES      BusNumber_Header;
    BUSNUMBER_RANGE[1] BusNumber_Data;
}

struct Connection_Des_s
{
align (1):
    uint          COND_Type;
    uint          COND_Flags;
    ubyte         COND_Class;
    ubyte         COND_ClassType;
    ubyte         COND_Reserved1;
    ubyte         COND_Reserved2;
    LARGE_INTEGER COND_Id;
}

struct Connection_Resource_s
{
    Connection_Des_s Connection_Header;
}

struct HWProfileInfo_sA
{
align (1):
    uint     HWPI_ulHWProfile;
    byte[80] HWPI_szFriendlyName;
    uint     HWPI_dwFlags;
}

struct HWProfileInfo_sW
{
align (1):
    uint       HWPI_ulHWProfile;
    ushort[80] HWPI_szFriendlyName;
    uint       HWPI_dwFlags;
}

struct HCMNOTIFICATION__
{
    int unused;
}

///Device notification filter structure
struct CM_NOTIFY_FILTER
{
    ///The size of the structure.
    uint cbSize;
    ///A combination of zero or more of the following flags:
    uint Flags;
    ///Must be one of the following values:
    CM_NOTIFY_FILTER_TYPE FilterType;
    ///Set to 0.
    uint Reserved;
    union u
    {
        struct DeviceInterface
        {
            GUID ClassGuid;
        }
        struct DeviceHandle
        {
            HANDLE hTarget;
        }
        struct DeviceInstance
        {
            ushort[200] InstanceId;
        }
    }
}

///This is a device notification event data structure.
struct CM_NOTIFY_EVENT_DATA
{
    ///The <b>CM_NOTIFY_FILTER_TYPE</b> from the CM_NOTIFY_FILTER structure that was used in the registration that
    ///generated this notification event data.
    CM_NOTIFY_FILTER_TYPE FilterType;
    ///Reserved. Must be 0.
    uint Reserved;
    union u
    {
        struct DeviceInterface
        {
            GUID      ClassGuid;
            ushort[1] SymbolicLink;
        }
        struct DeviceHandle
        {
            GUID     EventGuid;
            int      NameOffset;
            uint     DataSize;
            ubyte[1] Data;
        }
        struct DeviceInstance
        {
            ushort[1] InstanceId;
        }
    }
}

// Functions

///The <b>SetupGetInfDriverStoreLocation</b> function retrieves the fully qualified file name (directory path and file
///name) of an INF file in the driver store that corresponds to a specified INF file in the system INF file directory or
///a specified INF file in the driver store.
///Params:
///    FileName = A pointer to a NULL-terminated string that contains the name, and optionally the full directory path, of an INF
///               file in the system INF file directory. Alternatively, this parameter is a pointer to a NULL-terminated string
///               that contains the fully qualified file name (directory path and file name) of an INF file in the driver store.
///               For more information about how to specify the INF file, see the following <b>Remarks</b> section.
///    AlternatePlatformInfo = Reserved for system use.
///    LocaleName = Reserved for system use.
///    ReturnBuffer = A pointer to a buffer in which the function returns a NULL-terminated string that contains the fully qualified
///                   file name of the specified INF file. This parameter can be set to <b>NULL</b>. The maximum supported path size is
///                   MAX_PATH. For information about how to determine the required size of the buffer, see the following
///                   <b>Remarks</b> section.
///    ReturnBufferSize = The size, in characters, of the buffer supplied by <i>ReturnBuffer</i>.
///    RequiredSize = A pointer to a DWORD-typed variable that receives the size, in characters, of the <i>ReturnBuffer</i> buffer.
///                   This parameter is optional and can be set to <b>NULL</b>.
///Returns:
///    If <b>SetupGetInfDriverStoreLocation</b> succeeds, the function returns <b>TRUE</b>; otherwise, the function
///    returns <b>FALSE</b>. To obtain extended error information, call GetLastError. If the size, in characters, of the
///    fully qualified file name of the requested INF file, including a null-terminator, is greater than
///    <i>ReturnBufferSize</i>, the function will fail, and a call to GetLastError will return
///    ERROR_INSUFFICIENT_BUFFER.
///    
@DllImport("SETUPAPI")
BOOL SetupGetInfDriverStoreLocationA(const(char)* FileName, SP_ALTPLATFORM_INFO_V2* AlternatePlatformInfo, 
                                     const(char)* LocaleName, const(char)* ReturnBuffer, uint ReturnBufferSize, 
                                     uint* RequiredSize);

///The <b>SetupGetInfDriverStoreLocation</b> function retrieves the fully qualified file name (directory path and file
///name) of an INF file in the driver store that corresponds to a specified INF file in the system INF file directory or
///a specified INF file in the driver store.
///Params:
///    FileName = A pointer to a NULL-terminated string that contains the name, and optionally the full directory path, of an INF
///               file in the system INF file directory. Alternatively, this parameter is a pointer to a NULL-terminated string
///               that contains the fully qualified file name (directory path and file name) of an INF file in the driver store.
///               For more information about how to specify the INF file, see the following <b>Remarks</b> section.
///    AlternatePlatformInfo = Reserved for system use.
///    LocaleName = Reserved for system use.
///    ReturnBuffer = A pointer to a buffer in which the function returns a NULL-terminated string that contains the fully qualified
///                   file name of the specified INF file. This parameter can be set to <b>NULL</b>. The maximum supported path size is
///                   MAX_PATH. For information about how to determine the required size of the buffer, see the following
///                   <b>Remarks</b> section.
///    ReturnBufferSize = The size, in characters, of the buffer supplied by <i>ReturnBuffer</i>.
///    RequiredSize = A pointer to a DWORD-typed variable that receives the size, in characters, of the <i>ReturnBuffer</i> buffer.
///                   This parameter is optional and can be set to <b>NULL</b>.
///Returns:
///    If <b>SetupGetInfDriverStoreLocation</b> succeeds, the function returns <b>TRUE</b>; otherwise, the function
///    returns <b>FALSE</b>. To obtain extended error information, call GetLastError. If the size, in characters, of the
///    fully qualified file name of the requested INF file, including a null-terminator, is greater than
///    <i>ReturnBufferSize</i>, the function will fail, and a call to GetLastError will return
///    ERROR_INSUFFICIENT_BUFFER.
///    
@DllImport("SETUPAPI")
BOOL SetupGetInfDriverStoreLocationW(const(wchar)* FileName, SP_ALTPLATFORM_INFO_V2* AlternatePlatformInfo, 
                                     const(wchar)* LocaleName, const(wchar)* ReturnBuffer, uint ReturnBufferSize, 
                                     uint* RequiredSize);

///The <b>SetupGetInfPublishedName</b> function retrieves the fully qualified file name (directory path and file name)
///of an INF file in the system INF file directory that corresponds to a specified INF file in the driver store or a
///specified INF file in the system INF file directory.
///Params:
///    DriverStoreLocation = A pointer to a NULL-terminated string that contains the fully qualified file name (directory path and file name)
///                          of an INF file in the driver store. Alternatively, this parameter is a pointer to a NULL-terminated string that
///                          contains the name, and optionally the full directory path, of an INF file in the system INF file directory. For
///                          more information about how to specify the INF file, see the following <b>Remarks</b> section.
///    ReturnBuffer = A pointer to the buffer in which <b>SetupGetInfPublishedName</b> returns a NULL-terminated string that contains
///                   the fully qualified file name of the specified INF file in the system INF directory. The maximum path size is
///                   MAX_PATH. This pointer can be set to <b>NULL</b>. For information about how to determine the required size of the
///                   return buffer, see the following <b>Remarks</b> section.
///    ReturnBufferSize = The size, in characters, of the buffer supplied by <i>ReturnBuffer</i>.
///    RequiredSize = A pointer to a DWORD-typed variable that receives the size, in characters, of the <i>ReturnBuffer</i> buffer.
///                   This parameter is optional and can be set to <b>NULL</b>.
///Returns:
///    If <b>SetupGetInfPublishedName</b> succeeds, the function returns <b>TRUE</b>; otherwise, the function returns
///    <b>FALSE</b>. To obtain extended error information, call GetLastError. If the size, in characters, of the fully
///    qualified file name of the requested INF file, including a null-terminator, is greater than
///    <i>ReturnBufferSize</i>, the function will fail, and a call to GetLastError will return
///    ERROR_INSUFFICIENT_BUFFER.
///    
@DllImport("SETUPAPI")
BOOL SetupGetInfPublishedNameA(const(char)* DriverStoreLocation, const(char)* ReturnBuffer, uint ReturnBufferSize, 
                               uint* RequiredSize);

///The <b>SetupGetInfPublishedName</b> function retrieves the fully qualified file name (directory path and file name)
///of an INF file in the system INF file directory that corresponds to a specified INF file in the driver store or a
///specified INF file in the system INF file directory.
///Params:
///    DriverStoreLocation = A pointer to a NULL-terminated string that contains the fully qualified file name (directory path and file name)
///                          of an INF file in the driver store. Alternatively, this parameter is a pointer to a NULL-terminated string that
///                          contains the name, and optionally the full directory path, of an INF file in the system INF file directory. For
///                          more information about how to specify the INF file, see the following <b>Remarks</b> section.
///    ReturnBuffer = A pointer to the buffer in which <b>SetupGetInfPublishedName</b> returns a NULL-terminated string that contains
///                   the fully qualified file name of the specified INF file in the system INF directory. The maximum path size is
///                   MAX_PATH. This pointer can be set to <b>NULL</b>. For information about how to determine the required size of the
///                   return buffer, see the following <b>Remarks</b> section.
///    ReturnBufferSize = The size, in characters, of the buffer supplied by <i>ReturnBuffer</i>.
///    RequiredSize = A pointer to a DWORD-typed variable that receives the size, in characters, of the <i>ReturnBuffer</i> buffer.
///                   This parameter is optional and can be set to <b>NULL</b>.
///Returns:
///    If <b>SetupGetInfPublishedName</b> succeeds, the function returns <b>TRUE</b>; otherwise, the function returns
///    <b>FALSE</b>. To obtain extended error information, call GetLastError. If the size, in characters, of the fully
///    qualified file name of the requested INF file, including a null-terminator, is greater than
///    <i>ReturnBufferSize</i>, the function will fail, and a call to GetLastError will return
///    ERROR_INSUFFICIENT_BUFFER.
///    
@DllImport("SETUPAPI")
BOOL SetupGetInfPublishedNameW(const(wchar)* DriverStoreLocation, const(wchar)* ReturnBuffer, 
                               uint ReturnBufferSize, uint* RequiredSize);

///The <b>SetupGetThreadLogToken</b> function retrieves the log token for the thread from which this function was
///called.
///Returns:
///    <b>SetupGetThreadLogToken</b> returns the log token for the thread from which the function was called. If a log
///    token is not set for the thread, <b>SetupGetThreadLogToken</b> returns the system-defined log token
///    LOGTOKEN_UNSPECIFIED.
///    
@DllImport("SETUPAPI")
ulong SetupGetThreadLogToken();

///The <b>SetupSetThreadLogToken</b> function sets the log context, as represented by a log token<u>,</u> for the thread
///from which this function was called. A subsequent call to SetupGetThreadLogToken made within the same thread
///retrieves the log token that was most recently set for the thread.
///Params:
///    LogToken = A log token that is either a system-defined log token or was returned by SetupGetThreadLogToken.
///Returns:
///    None
///    
@DllImport("SETUPAPI")
void SetupSetThreadLogToken(ulong LogToken);

///The <b>SetupWriteTextLog</b> function writes a log entry in a SetupAPI text log.
///Params:
///    LogToken = A log token that is either a system-defined log token or was returned by SetupGetThreadLogToken.
///    Category = A DWORD-typed value that indicates the event category for the log entry. The event categories that can be
///               specified for a log entry are the same as those that can be enabled for a text log. For a list of event
///               categories, see Enabling Event Categories for a SetupAPI Text Log.
///    Flags = A DWORD-typed value that is a bitwise OR of flag values, which specify the following: <ul> <li> The event level
///            for the log entry. The event levels that can be specified for a log entry are the same as those that can be
///            enabled for a text log. For a list of event level flags, see Setting the Event Level for a SetupAPI Text Log.
///            </li> <li> Whether to include a time stamp in the log entry. The time stamp flag value is TXTLOG_TIMESTAMP. </li>
///            <li> The change, if any, to the indentation depth of the section and the current log entry. For information about
///            how to use the indentation flags, see Writing Indented Log Entries. </li> </ul>
///    MessageStr = A pointer to a NULL-terminated constant string that contains a <b>printf</b>-compatible format string, which
///                 specifies the formatted message to include in the log entry. The comma-separated parameter list that follows
///                 <i>MessageStr</i> must match the format specifiers in the format string.
///    arg5 = A comma-separated parameter list that matches the format specifiers in the format string that is supplied by
///           <i>MessageStr</i>.
///Returns:
///    None
///    
@DllImport("SETUPAPI")
void SetupWriteTextLog(ulong LogToken, uint Category, uint Flags, const(char)* MessageStr);

///The <b>SetupWriteTextLogError</b> function writes information about a SetupAPI-specific error or a Win32 system error
///to a SetupAPI text log.
///Params:
///    LogToken = A log token that is either a system-defined log token or was returned by SetupGetThreadLogToken.
///    Category = A value of type DWORD that indicates the event category for the log entry. The event categories that can be
///               specified for a log entry are the same as those that can be enabled for a text log. For a list of event
///               categories, see Enabling Event Categories for a SetupAPI Text Log.
///    LogFlags = A value of type DWORD that is a bitwise OR of flag values, which specify the following: <ul> <li> The event level
///               for the log entry. The event levels that can be specified for a log entry are the same as those that can be
///               enabled for a text log. For a list of event level flags, see Setting the Event Level for a Text Log. </li> <li>
///               Whether to include a time stamp in the log entry. The time stamp flag value is TXTLOG_TIMESTAMP. </li> <li> The
///               change, if any, to the indentation depth of the section and the current log entry. For information about how to
///               use the indentation flags, see Writing Indented Log Entries. </li> </ul>
///    Error = A SetupAPI-specific error code or a Win32 error code. The SetupAPI-specific error codes are listed in
///            <i>Setupapi.h</i>. The Win32 error codes are listed in <i>Winerror.h</i>.
///    MessageStr = A pointer to a NULL-terminated constant string that contains a <b>printf</b>-compatible format string, which
///                 specifies the formatted message to include in the log entry.
///    arg6 = A comma-separated parameter list that matches the format specifiers in the format string that is supplied by
///           <i>MessageStr</i>.
///Returns:
///    None
///    
@DllImport("SETUPAPI")
void SetupWriteTextLogError(ulong LogToken, uint Category, uint LogFlags, uint Error, const(char)* MessageStr);

///The <b>SetupWriteTextLogInfLine</b> function writes a log entry in a SetupAPI text log that contains the text of a
///specified INF file line.
///Params:
///    LogToken = A log token that is either a system-defined log token or was returned by SetupGetThreadLogToken.
///    Flags = A value of type DWORD that is a bitwise OR of flag values, which specify the following: <ul> <li> The event level
///            for the log entry. The event levels that can be specified for a log entry are the same as those that can be
///            enabled for a text log. For a list of event level flags, see Setting the Event Level for a SetupAPI Text Log.
///            </li> <li> Whether to include a time stamp in the log entry. The time stamp flag value is TXTLOG_TIMESTAMP. </li>
///            <li> The change, if any, to the indentation depth of the section and the current log entry. For information about
///            how to use the indentation flags, see Writing Indented Log Entries. </li> </ul>
///    InfHandle = A handle to the INF file that includes the line of text to be written to the text log. A handle to an INF file is
///                obtained by calling <b>SetupOpenInfFile</b>, which is documented in the Platform SDK.
///    Context = A pointer to an INF file context that specifies the line of text to be written to the text log. An INF file
///              context for a line is obtained by calling the <b>SetupFind</b><i>Xxx</i><b>Line</b> functions. For information
///              about INF files and an INF file context, see the information that is provided in the Platform SDK about using INF
///              files, obtaining an INF file context, and the INFCONTEXT structure.
///Returns:
///    None
///    
@DllImport("SETUPAPI")
void SetupWriteTextLogInfLine(ulong LogToken, uint Flags, void* InfHandle, INFCONTEXT* Context);

@DllImport("SETUPAPI")
BOOL SetupGetBackupInformationA(void* QueueHandle, SP_BACKUP_QUEUE_PARAMS_V2_A* BackupParams);

@DllImport("SETUPAPI")
BOOL SetupGetBackupInformationW(void* QueueHandle, SP_BACKUP_QUEUE_PARAMS_V2_W* BackupParams);

@DllImport("SETUPAPI")
BOOL SetupPrepareQueueForRestoreA(void* QueueHandle, const(char)* BackupPath, uint RestoreFlags);

@DllImport("SETUPAPI")
BOOL SetupPrepareQueueForRestoreW(void* QueueHandle, const(wchar)* BackupPath, uint RestoreFlags);

///The <b>SetupSetNonInteractiveMode</b> function sets a non-interactive SetupAPI flag that determines whether SetupAPI
///can interact with a user in the caller's context.
///Params:
///    NonInteractiveFlag = The Boolean value of the non-interactive flag. If <i>NonInteractive</i> is set to <b>TRUE</b>, SetupAPI runs in a
///                         non-interactive user mode and if <i>NonInteractive</i> is set to <b>FALSE</b>, SetupAPI runs in an interactive
///                         user mode.
///Returns:
///    <b>SetupSetNonInteractiveMode</b> returns the previous setting of the non-interactive flag.
///    
@DllImport("SETUPAPI")
BOOL SetupSetNonInteractiveMode(BOOL NonInteractiveFlag);

///The <b>SetupGetNonInteractiveMode</b> function returns the value of a SetupAPI non-interactive flag that indicates
///whether the caller's process can interact with a user through user interface components, such as dialog boxes.
///Returns:
///    <b>SetupGetNonInteractiveMode</b> returns <b>TRUE</b> if the caller's process cannot display interactive user
///    interface elements, such as dialog boxes. Otherwise, the function returns <b>FALSE</b>, which indicates that the
///    process can display interactive user interface elements.
///    
@DllImport("SETUPAPI")
BOOL SetupGetNonInteractiveMode();

///The <b>SetupDiCreateDeviceInfoList</b> function creates an empty device information set and optionally associates the
///set with a device setup class and a top-level window.
///Params:
///    ClassGuid = A pointer to the <b>GUID</b> of the device setup class to associate with the newly created device information
///                set. If this parameter is specified, only devices of this class can be included in this device information set.
///                If this parameter is set to <b>NULL</b>, the device information set is not associated with a specific device
///                setup class.
///    hwndParent = A handle to the top-level window to use for any user interface that is related to non-device-specific actions
///                 (such as a select-device dialog box that uses the global class driver list). This handle is optional and can be
///                 <b>NULL</b>. If a specific top-level window is not required, set <i>hwndParent</i> to <b>NULL</b>.
///Returns:
///    The function returns a handle to an empty device information set if it is successful. Otherwise, it returns
///    <b>INVALID_HANDLE_VALUE</b>. To get extended error information, call GetLastError.
///    
@DllImport("SETUPAPI")
void* SetupDiCreateDeviceInfoList(const(GUID)* ClassGuid, HWND hwndParent);

///The <b>SetupDiCreateDeviceInfoList</b> function creates an empty device information set on a remote or a local
///computer and optionally associates the set with a device setup class .
///Params:
///    ClassGuid = A pointer to the GUID of the device setup class to associate with the newly created device information set. If
///                this parameter is specified, only devices of this class can be included in this device information set. If this
///                parameter is set to <b>NULL</b>, the device information set is not associated with a specific device setup class.
///    hwndParent = A handle to the top-level window to use for any user interface that is related to non-device-specific actions
///                 (such as a select-device dialog box that uses the global class driver list). This handle is optional and can be
///                 <b>NULL</b>. If a specific top-level window is not required, set <i>hwndParent</i> to <b>NULL</b>.
///    MachineName = A pointer to a NULL-terminated string that contains the name of a computer on a network. If a name is specified,
///                  only devices on that computer can be created and opened in this device information set. If this parameter is set
///                  to <b>NULL</b>, the device information set is for devices on the local computer.
///    Reserved = Must be <b>NULL</b>.
///Returns:
///    The function returns a handle to an empty device information set if it is successful. Otherwise, it returns
///    INVALID_HANDLE_VALUE. To get extended error information, call GetLastError.
///    
@DllImport("SETUPAPI")
void* SetupDiCreateDeviceInfoListExA(const(GUID)* ClassGuid, HWND hwndParent, const(char)* MachineName, 
                                     void* Reserved);

///The <b>SetupDiCreateDeviceInfoList</b> function creates an empty device information set on a remote or a local
///computer and optionally associates the set with a device setup class .
///Params:
///    ClassGuid = A pointer to the GUID of the device setup class to associate with the newly created device information set. If
///                this parameter is specified, only devices of this class can be included in this device information set. If this
///                parameter is set to <b>NULL</b>, the device information set is not associated with a specific device setup class.
///    hwndParent = A handle to the top-level window to use for any user interface that is related to non-device-specific actions
///                 (such as a select-device dialog box that uses the global class driver list). This handle is optional and can be
///                 <b>NULL</b>. If a specific top-level window is not required, set <i>hwndParent</i> to <b>NULL</b>.
///    MachineName = A pointer to a NULL-terminated string that contains the name of a computer on a network. If a name is specified,
///                  only devices on that computer can be created and opened in this device information set. If this parameter is set
///                  to <b>NULL</b>, the device information set is for devices on the local computer.
///    Reserved = Must be <b>NULL</b>.
///Returns:
///    The function returns a handle to an empty device information set if it is successful. Otherwise, it returns
///    INVALID_HANDLE_VALUE. To get extended error information, call GetLastError.
///    
@DllImport("SETUPAPI")
void* SetupDiCreateDeviceInfoListExW(const(GUID)* ClassGuid, HWND hwndParent, const(wchar)* MachineName, 
                                     void* Reserved);

///The <b>SetupDiGetDeviceInfoListClass</b> function retrieves the GUID for the device setup class associated with a
///device information set if the set has an associated class.
///Params:
///    DeviceInfoSet = A handle to the device information set to query.
///    ClassGuid = A pointer to variable of type GUID that receives the GUID for the associated class.
///Returns:
///    The function returns <b>TRUE</b> if it is successful. Otherwise, it returns <b>FALSE</b> and the logged error can
///    be retrieved with a call to GetLastError.
///    
@DllImport("SETUPAPI")
BOOL SetupDiGetDeviceInfoListClass(void* DeviceInfoSet, GUID* ClassGuid);

///The <b>SetupDiGetDeviceInfoListDetail</b> function retrieves information associated with a device information set
///including the class GUID, remote computer handle, and remote computer name.
///Params:
///    DeviceInfoSet = A handle to the device information set for which to retrieve information.
///    DeviceInfoSetDetailData = A pointer to a caller-initialized SP_DEVINFO_LIST_DETAIL_DATA structure that receives the device information set
///                              information. For more information about this structure, see the following <b>Remarks</b> section.
///Returns:
///    The function returns <b>TRUE</b> if it is successful. Otherwise, it returns <b>FALSE</b> and the logged error can
///    be retrieved by making a call to GetLastError.
///    
@DllImport("SETUPAPI")
BOOL SetupDiGetDeviceInfoListDetailA(void* DeviceInfoSet, SP_DEVINFO_LIST_DETAIL_DATA_A* DeviceInfoSetDetailData);

///The <b>SetupDiGetDeviceInfoListDetail</b> function retrieves information associated with a device information set
///including the class GUID, remote computer handle, and remote computer name.
///Params:
///    DeviceInfoSet = A handle to the device information set for which to retrieve information.
///    DeviceInfoSetDetailData = A pointer to a caller-initialized SP_DEVINFO_LIST_DETAIL_DATA structure that receives the device information set
///                              information. For more information about this structure, see the following <b>Remarks</b> section.
///Returns:
///    The function returns <b>TRUE</b> if it is successful. Otherwise, it returns <b>FALSE</b> and the logged error can
///    be retrieved by making a call to GetLastError.
///    
@DllImport("SETUPAPI")
BOOL SetupDiGetDeviceInfoListDetailW(void* DeviceInfoSet, SP_DEVINFO_LIST_DETAIL_DATA_W* DeviceInfoSetDetailData);

///The <b>SetupDiCreateDeviceInfo</b> function creates a new device information element and adds it as a new member to
///the specified device information set.
///Params:
///    DeviceInfoSet = A handle to the device information set for the local computer.
///    DeviceName = A pointer to a NULL-terminated string that supplies either a full device instance ID (for example,
///                 "Root\*PNP0500\0000") or a root-enumerated device ID without the enumerator prefix and instance identifier suffix
///                 (for example, "*PNP0500"). The root-enumerated device identifier can be used only if the DICD_GENERATE_ID flag is
///                 specified in the <i>CreationFlags</i> parameter.
///    ClassGuid = A pointer to the device setup class GUID for the device. If the device setup class of the device is not known,
///                set *<i>ClassGuid</i> to a GUID_NULL structure.
///    DeviceDescription = A pointer to a NULL-terminated string that supplies the text description of the device. This pointer is optional
///                        and can be <b>NULL</b>.
///    hwndParent = A handle to the top-level window to use for any user interface that is related to installing the device. This
///                 handle is optional and can be <b>NULL</b>.
///    CreationFlags = A variable of type DWORD that controls how the device information element is created. Can be a combination of the
///                    following values:
///    DeviceInfoData = A pointer to a SP_DEVINFO_DATA structure that receives the new device information element. This pointer is
///                     optional and can be <b>NULL</b>. If the structure is supplied, the caller must set the <b>cbSize</b> member of
///                     this structure to <b>sizeof(</b>SP_DEVINFO_DATA<b>)</b> before calling the function. For more information, see
///                     the following <b>Remarks</b> section.
///Returns:
///    The function returns <b>TRUE</b> if it is successful. Otherwise, it returns <b>FALSE</b> and the logged error can
///    be retrieved by making a call to GetLastError.
///    
@DllImport("SETUPAPI")
BOOL SetupDiCreateDeviceInfoA(void* DeviceInfoSet, const(char)* DeviceName, const(GUID)* ClassGuid, 
                              const(char)* DeviceDescription, HWND hwndParent, uint CreationFlags, 
                              SP_DEVINFO_DATA* DeviceInfoData);

///The <b>SetupDiCreateDeviceInfo</b> function creates a new device information element and adds it as a new member to
///the specified device information set.
///Params:
///    DeviceInfoSet = A handle to the device information set for the local computer.
///    DeviceName = A pointer to a NULL-terminated string that supplies either a full device instance ID (for example,
///                 "Root\*PNP0500\0000") or a root-enumerated device ID without the enumerator prefix and instance identifier suffix
///                 (for example, "*PNP0500"). The root-enumerated device identifier can be used only if the DICD_GENERATE_ID flag is
///                 specified in the <i>CreationFlags</i> parameter.
///    ClassGuid = A pointer to the device setup class GUID for the device. If the device setup class of the device is not known,
///                set *<i>ClassGuid</i> to a GUID_NULL structure.
///    DeviceDescription = A pointer to a NULL-terminated string that supplies the text description of the device. This pointer is optional
///                        and can be <b>NULL</b>.
///    hwndParent = A handle to the top-level window to use for any user interface that is related to installing the device. This
///                 handle is optional and can be <b>NULL</b>.
///    CreationFlags = A variable of type DWORD that controls how the device information element is created. Can be a combination of the
///                    following values:
///    DeviceInfoData = A pointer to a SP_DEVINFO_DATA structure that receives the new device information element. This pointer is
///                     optional and can be <b>NULL</b>. If the structure is supplied, the caller must set the <b>cbSize</b> member of
///                     this structure to <b>sizeof(</b>SP_DEVINFO_DATA<b>)</b> before calling the function. For more information, see
///                     the following <b>Remarks</b> section.
///Returns:
///    The function returns <b>TRUE</b> if it is successful. Otherwise, it returns <b>FALSE</b> and the logged error can
///    be retrieved by making a call to GetLastError.
///    
@DllImport("SETUPAPI")
BOOL SetupDiCreateDeviceInfoW(void* DeviceInfoSet, const(wchar)* DeviceName, const(GUID)* ClassGuid, 
                              const(wchar)* DeviceDescription, HWND hwndParent, uint CreationFlags, 
                              SP_DEVINFO_DATA* DeviceInfoData);

///The <b>SetupDiOpenDeviceInfo</b> function adds a device information element for a device instance to a device
///information set, if one does not already exist in the device information set, and retrieves information that
///identifies the device information element for the device instance in the device information set.
///Params:
///    DeviceInfoSet = A handle to the device information set to which <b>SetupDiOpenDeviceInfo</b> adds a device information element,
///                    if one does not already exist, for the device instance that is specified by <i>DeviceInstanceId</i>.
///    DeviceInstanceId = A pointer to a NULL-terminated string that supplies the device instance identifier of a device (for example,
///                       "Root\*PNP0500\0000"). If <i>DeviceInstanceId</i> is <b>NULL</b> or references a zero-length string,
///                       <b>SetupDiOpenDeviceInfo</b> adds a device information element to the supplied device information set, if one
///                       does not already exist, for the root device in the device tree.
///    hwndParent = The handle to the top-level window to use for any user interface related to installing the device.
///    OpenFlags = A variable of DWORD type that controls how the device information element is opened. The value of this parameter
///                can be one or more of the following:
///    DeviceInfoData = A pointer to a caller-supplied SP_DEVINFO_DATA structure that receives information about the device information
///                     element for the device instance that is specified by <i>DeviceInstanceId</i>. The caller must set <b>cbSize</b>
///                     to <b>sizeof(</b>SP_DEVINFO_DATA<b>)</b>. This parameter is optional and can be <b>NULL</b>.
///Returns:
///    <b>SetupDiOpenDeviceInfo</b> returns <b>TRUE</b> if it is successful. Otherwise, the function returns
///    <b>FALSE</b> and the logged error can be retrieved with a call to GetLastError.
///    
@DllImport("SETUPAPI")
BOOL SetupDiOpenDeviceInfoA(void* DeviceInfoSet, const(char)* DeviceInstanceId, HWND hwndParent, uint OpenFlags, 
                            SP_DEVINFO_DATA* DeviceInfoData);

///The <b>SetupDiOpenDeviceInfo</b> function adds a device information element for a device instance to a device
///information set, if one does not already exist in the device information set, and retrieves information that
///identifies the device information element for the device instance in the device information set.
///Params:
///    DeviceInfoSet = A handle to the device information set to which <b>SetupDiOpenDeviceInfo</b> adds a device information element,
///                    if one does not already exist, for the device instance that is specified by <i>DeviceInstanceId</i>.
///    DeviceInstanceId = A pointer to a NULL-terminated string that supplies the device instance identifier of a device (for example,
///                       "Root\*PNP0500\0000"). If <i>DeviceInstanceId</i> is <b>NULL</b> or references a zero-length string,
///                       <b>SetupDiOpenDeviceInfo</b> adds a device information element to the supplied device information set, if one
///                       does not already exist, for the root device in the device tree.
///    hwndParent = The handle to the top-level window to use for any user interface related to installing the device.
///    OpenFlags = A variable of DWORD type that controls how the device information element is opened. The value of this parameter
///                can be one or more of the following:
///    DeviceInfoData = A pointer to a caller-supplied SP_DEVINFO_DATA structure that receives information about the device information
///                     element for the device instance that is specified by <i>DeviceInstanceId</i>. The caller must set <b>cbSize</b>
///                     to <b>sizeof(</b>SP_DEVINFO_DATA<b>)</b>. This parameter is optional and can be <b>NULL</b>.
///Returns:
///    <b>SetupDiOpenDeviceInfo</b> returns <b>TRUE</b> if it is successful. Otherwise, the function returns
///    <b>FALSE</b> and the logged error can be retrieved with a call to GetLastError.
///    
@DllImport("SETUPAPI")
BOOL SetupDiOpenDeviceInfoW(void* DeviceInfoSet, const(wchar)* DeviceInstanceId, HWND hwndParent, uint OpenFlags, 
                            SP_DEVINFO_DATA* DeviceInfoData);

///The <b>SetupDiGetDeviceInstanceId</b> function retrieves the device instance ID that is associated with a device
///information element.
///Params:
///    DeviceInfoSet = A handle to the device information set that contains the device information element that represents the device
///                    for which to retrieve a device instance ID.
///    DeviceInfoData = A pointer to an SP_DEVINFO_DATA structure that specifies the device information element in <i>DeviceInfoSet</i>.
///    DeviceInstanceId = A pointer to the character buffer that will receive the NULL-terminated device instance ID for the specified
///                       device information element. For information about device instance IDs, see Device Identification Strings.
///    DeviceInstanceIdSize = The size, in characters, of the <i>DeviceInstanceId</i> buffer.
///    RequiredSize = A pointer to the variable that receives the number of characters required to store the device instance ID.
///Returns:
///    The function returns <b>TRUE</b> if it is successful. Otherwise, it returns <b>FALSE</b> and the logged error can
///    be retrieved by making a call to GetLastError.
///    
@DllImport("SETUPAPI")
BOOL SetupDiGetDeviceInstanceIdA(void* DeviceInfoSet, SP_DEVINFO_DATA* DeviceInfoData, 
                                 const(char)* DeviceInstanceId, uint DeviceInstanceIdSize, uint* RequiredSize);

///The <b>SetupDiGetDeviceInstanceId</b> function retrieves the device instance ID that is associated with a device
///information element.
///Params:
///    DeviceInfoSet = A handle to the device information set that contains the device information element that represents the device
///                    for which to retrieve a device instance ID.
///    DeviceInfoData = A pointer to an SP_DEVINFO_DATA structure that specifies the device information element in <i>DeviceInfoSet</i>.
///    DeviceInstanceId = A pointer to the character buffer that will receive the NULL-terminated device instance ID for the specified
///                       device information element. For information about device instance IDs, see Device Identification Strings.
///    DeviceInstanceIdSize = The size, in characters, of the <i>DeviceInstanceId</i> buffer.
///    RequiredSize = A pointer to the variable that receives the number of characters required to store the device instance ID.
///Returns:
///    The function returns <b>TRUE</b> if it is successful. Otherwise, it returns <b>FALSE</b> and the logged error can
///    be retrieved by making a call to GetLastError.
///    
@DllImport("SETUPAPI")
BOOL SetupDiGetDeviceInstanceIdW(void* DeviceInfoSet, SP_DEVINFO_DATA* DeviceInfoData, 
                                 const(wchar)* DeviceInstanceId, uint DeviceInstanceIdSize, uint* RequiredSize);

///The <b>SetupDiDeleteDeviceInfo</b> function deletes a device information element from a device information set. This
///function does not delete the actual device.
///Params:
///    DeviceInfoSet = A handle to the device information set that contains the device information element to delete.
///    DeviceInfoData = A pointer to an SP_DEVINFO_DATA structure that represents the device information element in <i>DeviceInfoSet
///                     </i>to delete.
///Returns:
///    The function returns <b>TRUE</b> if it is successful. Otherwise, it returns <b>FALSE</b> and the logged error can
///    be retrieved with a call to GetLastError.
///    
@DllImport("SETUPAPI")
BOOL SetupDiDeleteDeviceInfo(void* DeviceInfoSet, SP_DEVINFO_DATA* DeviceInfoData);

///The <b>SetupDiEnumDeviceInfo</b> function returns a SP_DEVINFO_DATA structure that specifies a device information
///element in a device information set.
///Params:
///    DeviceInfoSet = A handle to the device information set for which to return an SP_DEVINFO_DATA structure that represents a device
///                    information element.
///    MemberIndex = A zero-based index of the device information element to retrieve.
///    DeviceInfoData = A pointer to an SP_DEVINFO_DATA structure to receive information about an enumerated device information element.
///                     The caller must set <i>DeviceInfoData</i>.<b>cbSize</b> to <code>sizeof(SP_DEVINFO_DATA)</code>.
///Returns:
///    The function returns <b>TRUE</b> if it is successful. Otherwise, it returns <b>FALSE</b> and the logged error can
///    be retrieved with a call to GetLastError.
///    
@DllImport("SETUPAPI")
BOOL SetupDiEnumDeviceInfo(void* DeviceInfoSet, uint MemberIndex, SP_DEVINFO_DATA* DeviceInfoData);

///The <b>SetupDiDestroyDeviceInfoList</b> function deletes a device information set and frees all associated memory.
///Params:
///    DeviceInfoSet = A handle to the device information set to delete.
///Returns:
///    The function returns <b>TRUE</b> if it is successful. Otherwise, it returns <b>FALSE</b> and the logged error can
///    be retrieved with a call to GetLastError.
///    
@DllImport("SETUPAPI")
BOOL SetupDiDestroyDeviceInfoList(void* DeviceInfoSet);

///The <b>SetupDiEnumDeviceInterfaces</b> function enumerates the device interfaces that are contained in a device
///information set.
///Params:
///    DeviceInfoSet = A pointer to a device information set that contains the device interfaces for which to return information. This
///                    handle is typically returned by SetupDiGetClassDevs.
///    DeviceInfoData = A pointer to an SP_DEVINFO_DATA structure that specifies a device information element in <i>DeviceInfoSet</i>.
///                     This parameter is optional and can be <b>NULL</b>. If this parameter is specified,
///                     <b>SetupDiEnumDeviceInterfaces</b> constrains the enumeration to the interfaces that are supported by the
///                     specified device. If this parameter is <b>NULL</b>, repeated calls to <b>SetupDiEnumDeviceInterfaces</b> return
///                     information about the interfaces that are associated with all the device information elements in
///                     <i>DeviceInfoSet</i>. This pointer is typically returned by SetupDiEnumDeviceInfo.
///    InterfaceClassGuid = A pointer to a GUID that specifies the device interface class for the requested interface.
///    MemberIndex = A zero-based index into the list of interfaces in the device information set. The caller should call this
///                  function first with <i>MemberIndex</i> set to zero to obtain the first interface. Then, repeatedly increment
///                  <i>MemberIndex</i> and retrieve an interface until this function fails and GetLastError returns
///                  ERROR_NO_MORE_ITEMS. If <i>DeviceInfoData</i> specifies a particular device, the <i>MemberIndex</i> is relative
///                  to only the interfaces exposed by that device.
///    DeviceInterfaceData = A pointer to a caller-allocated buffer that contains, on successful return, a completed SP_DEVICE_INTERFACE_DATA
///                          structure that identifies an interface that meets the search parameters. The caller must set
///                          <i>DeviceInterfaceData</i>.<b>cbSize</b> to <b>sizeof</b>(SP_DEVICE_INTERFACE_DATA) before calling this function.
///Returns:
///    <b>SetupDiEnumDeviceInterfaces</b> returns <b>TRUE</b> if the function completed without error. If the function
///    completed with an error, <b>FALSE</b> is returned and the error code for the failure can be retrieved by calling
///    GetLastError.
///    
@DllImport("SETUPAPI")
BOOL SetupDiEnumDeviceInterfaces(void* DeviceInfoSet, SP_DEVINFO_DATA* DeviceInfoData, 
                                 const(GUID)* InterfaceClassGuid, uint MemberIndex, 
                                 SP_DEVICE_INTERFACE_DATA* DeviceInterfaceData);

///The <b>SetupDiCreateDeviceInterface</b> function registers a device interface on a local system or a remote system.
///Params:
///    DeviceInfoSet = A handle to a device information set. This set contains a device information element that represents the device
///                    for which to register an interface. This handle is typically returned by SetupDiGetClassDevs.
///    DeviceInfoData = A pointer to an SP_DEVINFO_DATA structure that specifies the device information element in <i>DeviceInfoSet</i>.
///    InterfaceClassGuid = A pointer to a class GUID that specifies the interface class for the new interface.
///    ReferenceString = A pointer to a NULL-terminated string that supplies a reference string. This pointer is optional and can be
///                      <b>NULL</b>. Reference strings are used only by a few bus drivers that use device interfaces as placeholders for
///                      software devices that are created on demand.
///    CreationFlags = Reserved. Must be zero.
///    DeviceInterfaceData = A pointer to a caller-initialized SP_DEVICE_INTERFACE_DATA structure to receive information about the new device
///                          interface. This pointer is optional and can be <b>NULL</b>. If the structure is supplied, the caller must set the
///                          <b>cbSize</b> member of this structure to <b>sizeof(</b>SP_DEVICE_INTERFACE_DATA<b>)</b> before calling this
///                          function. For more information, see the following <b>Remarks</b> section.
///Returns:
///    <b>SetupDiCreateDeviceInterface</b> returns <b>TRUE</b> if the function completed without error. If the function
///    completed with an error, it returns <b>FALSE</b> and the error code for the failure can be retrieved by calling
///    GetLastError.
///    
@DllImport("SETUPAPI")
BOOL SetupDiCreateDeviceInterfaceA(void* DeviceInfoSet, SP_DEVINFO_DATA* DeviceInfoData, 
                                   const(GUID)* InterfaceClassGuid, const(char)* ReferenceString, uint CreationFlags, 
                                   SP_DEVICE_INTERFACE_DATA* DeviceInterfaceData);

///The <b>SetupDiCreateDeviceInterface</b> function registers a device interface on a local system or a remote system.
///Params:
///    DeviceInfoSet = A handle to a device information set. This set contains a device information element that represents the device
///                    for which to register an interface. This handle is typically returned by SetupDiGetClassDevs.
///    DeviceInfoData = A pointer to an SP_DEVINFO_DATA structure that specifies the device information element in <i>DeviceInfoSet</i>.
///    InterfaceClassGuid = A pointer to a class GUID that specifies the interface class for the new interface.
///    ReferenceString = A pointer to a NULL-terminated string that supplies a reference string. This pointer is optional and can be
///                      <b>NULL</b>. Reference strings are used only by a few bus drivers that use device interfaces as placeholders for
///                      software devices that are created on demand.
///    CreationFlags = Reserved. Must be zero.
///    DeviceInterfaceData = A pointer to a caller-initialized SP_DEVICE_INTERFACE_DATA structure to receive information about the new device
///                          interface. This pointer is optional and can be <b>NULL</b>. If the structure is supplied, the caller must set the
///                          <b>cbSize</b> member of this structure to <b>sizeof(</b>SP_DEVICE_INTERFACE_DATA<b>)</b> before calling this
///                          function. For more information, see the following <b>Remarks</b> section.
///Returns:
///    <b>SetupDiCreateDeviceInterface</b> returns <b>TRUE</b> if the function completed without error. If the function
///    completed with an error, it returns <b>FALSE</b> and the error code for the failure can be retrieved by calling
///    GetLastError.
///    
@DllImport("SETUPAPI")
BOOL SetupDiCreateDeviceInterfaceW(void* DeviceInfoSet, SP_DEVINFO_DATA* DeviceInfoData, 
                                   const(GUID)* InterfaceClassGuid, const(wchar)* ReferenceString, 
                                   uint CreationFlags, SP_DEVICE_INTERFACE_DATA* DeviceInterfaceData);

///The <b>SetupDiOpenDeviceInterface</b> function retrieves information about a device interface and adds the interface
///to the specified device information set for a local system or a remote system.
///Params:
///    DeviceInfoSet = A pointer to a device information set that contains, or will contain, a device information element that
///                    represents the device that supports the interface to open.
///    DevicePath = A pointer to a NULL-terminated string that supplies the name of the device interface to be opened. This name is a
///                 Win32 device path that is typically received in a PnP notification structure or obtained by a previous call to
///                 SetupDiEnumDeviceInterfaces and its related functions.
///    OpenFlags = Flags that determine how the device interface element is to be opened. The only valid flag is as follows:
///    DeviceInterfaceData = A pointer to a caller-initialized SP_DEVICE_INTERFACE_DATA structure that receives the requested interface data.
///                          This pointer is optional and can be <b>NULL</b>. If a buffer is supplied, the caller must set the <b>cbSize</b>
///                          member of the structure to <b>sizeof(</b>SP_DEVICE_INTERFACE_DATA<b>)</b> before calling
///                          <b>SetupDiOpenDeviceInterface</b>. For more information, see the following <b>Remarks</b> section.
///Returns:
///    <b>SetupDiOpenDeviceInterface</b> returns <b>TRUE</b> if the function completed without error. If the function
///    completed with an error, it returns <b>FALSE</b> and the error code for the failure can be retrieved by calling
///    GetLastError.
///    
@DllImport("SETUPAPI")
BOOL SetupDiOpenDeviceInterfaceA(void* DeviceInfoSet, const(char)* DevicePath, uint OpenFlags, 
                                 SP_DEVICE_INTERFACE_DATA* DeviceInterfaceData);

///The <b>SetupDiOpenDeviceInterface</b> function retrieves information about a device interface and adds the interface
///to the specified device information set for a local system or a remote system.
///Params:
///    DeviceInfoSet = A pointer to a device information set that contains, or will contain, a device information element that
///                    represents the device that supports the interface to open.
///    DevicePath = A pointer to a NULL-terminated string that supplies the name of the device interface to be opened. This name is a
///                 Win32 device path that is typically received in a PnP notification structure or obtained by a previous call to
///                 SetupDiEnumDeviceInterfaces and its related functions.
///    OpenFlags = Flags that determine how the device interface element is to be opened. The only valid flag is as follows:
///    DeviceInterfaceData = A pointer to a caller-initialized SP_DEVICE_INTERFACE_DATA structure that receives the requested interface data.
///                          This pointer is optional and can be <b>NULL</b>. If a buffer is supplied, the caller must set the <b>cbSize</b>
///                          member of the structure to <b>sizeof(</b>SP_DEVICE_INTERFACE_DATA<b>)</b> before calling
///                          <b>SetupDiOpenDeviceInterface</b>. For more information, see the following <b>Remarks</b> section.
///Returns:
///    <b>SetupDiOpenDeviceInterface</b> returns <b>TRUE</b> if the function completed without error. If the function
///    completed with an error, it returns <b>FALSE</b> and the error code for the failure can be retrieved by calling
///    GetLastError.
///    
@DllImport("SETUPAPI")
BOOL SetupDiOpenDeviceInterfaceW(void* DeviceInfoSet, const(wchar)* DevicePath, uint OpenFlags, 
                                 SP_DEVICE_INTERFACE_DATA* DeviceInterfaceData);

///The <b>SetupDiGetDeviceInterfaceAlias</b> function returns an alias of a specified device interface.
///Params:
///    DeviceInfoSet = A pointer to the device information set that contains the device interface for which to retrieve an alias. This
///                    handle is typically returned by SetupDiGetClassDevs.
///    DeviceInterfaceData = A pointer to an SP_DEVICE_INTERFACE_DATA structure that specifies the device interface in <i>DeviceInfoSet</i>
///                          for which to retrieve an alias. This pointer is typically returned by SetupDiEnumDeviceInterfaces.
///    AliasInterfaceClassGuid = A pointer to a GUID that specifies the interface class of the alias to retrieve.
///    AliasDeviceInterfaceData = A pointer to a caller-allocated buffer that contains, on successful return, a completed SP_DEVICE_INTERFACE_DATA
///                               structure that identifies the requested alias. The caller must set <i>AliasDeviceInterfaceData</i><b>.cbSize</b>
///                               to <b>sizeof</b>(SP_DEVICE_INTERFACE_DATA) before calling this function.
///Returns:
///    <b>SetupDiGetDeviceInterfaceAlias</b> returns <b>TRUE</b> if the function completed without error. If the
///    function completed with an error, <b>FALSE</b> is returned and the error code for the failure can be retrieved by
///    calling GetLastError. Possible errors returned by GetLastError are listed in the following table. <table> <tr>
///    <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> Invalid <i>DeviceInfoSet</i> or invalid
///    <i>DeviceInterfaceData</i> parameter. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_NO_SUCH_INTERFACE_DEVICE</b></dt> </dl> </td> <td width="60%"> There is no alias of class
///    <i>AliasInterfaceClassGuid</i> for the specified device interface. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_USER_BUFFER</b></dt> </dl> </td> <td width="60%"> Invalid <i>AliasDeviceInterfaceData</i>
///    buffer. </td> </tr> </table>
///    
@DllImport("SETUPAPI")
BOOL SetupDiGetDeviceInterfaceAlias(void* DeviceInfoSet, SP_DEVICE_INTERFACE_DATA* DeviceInterfaceData, 
                                    const(GUID)* AliasInterfaceClassGuid, 
                                    SP_DEVICE_INTERFACE_DATA* AliasDeviceInterfaceData);

///The <b>SetupDiDeleteDeviceInterfaceData</b> function deletes a device interface from a device information set.
///Params:
///    DeviceInfoSet = A pointer to the device information set that contains the interface to delete. This handle is typically returned
///                    by SetupDiGetClassDevs.
///    DeviceInterfaceData = A pointer to an SP_DEVICE_INTERFACE_DATA structure that specifies the interface in <i>DeviceInfoSet</i> to
///                          delete. This structure is typically returned by SetupDiEnumDeviceInterfaces.
///Returns:
///    <b>SetupDiDeleteDeviceInterfaceData</b> returns <b>TRUE</b> if the function completed without error. If the
///    function completed with an error, it returns <b>FALSE</b> and the error code for the failure can be retrieved by
///    calling GetLastError.
///    
@DllImport("SETUPAPI")
BOOL SetupDiDeleteDeviceInterfaceData(void* DeviceInfoSet, SP_DEVICE_INTERFACE_DATA* DeviceInterfaceData);

///The <b>SetupDiRemoveDeviceInterface</b> function removes a registered device interface from the system.
///Params:
///    DeviceInfoSet = A pointer to the device information set that contains the device interface to remove. This handle is typically
///                    returned by <b>SetupDiGetClassDevs</b>.
///    DeviceInterfaceData = A pointer to an SP_DEVICE_INTERFACE_DATA structure that specifies the device interface in <i>DeviceInfoSet</i> to
///                          remove. This pointer is typically returned by SetupDiEnumDeviceInterfaces. After the interface is removed, this
///                          function sets the SPINT_REMOVED flag in <i>DeviceInterfaceData</i><b>.Flags</b>. It also clears the SPINT_ACTIVE
///                          flag, but be aware that this flag should have already been cleared before this function was called.
///Returns:
///    <b>SetupDiRemoveDeviceInterface</b> returns <b>TRUE</b> if the function completed without error. If the function
///    completed with an error, it returns <b>FALSE</b> and the error code for the failure can be retrieved by calling
///    GetLastError.
///    
@DllImport("SETUPAPI")
BOOL SetupDiRemoveDeviceInterface(void* DeviceInfoSet, SP_DEVICE_INTERFACE_DATA* DeviceInterfaceData);

///The <b>SetupDiGetDeviceInterfaceDetail</b> function returns details about a device interface.
///Params:
///    DeviceInfoSet = A pointer to the device information set that contains the interface for which to retrieve details. This handle is
///                    typically returned by SetupDiGetClassDevs.
///    DeviceInterfaceData = A pointer to an SP_DEVICE_INTERFACE_DATA structure that specifies the interface in <i>DeviceInfoSet</i> for which
///                          to retrieve details. A pointer of this type is typically returned by SetupDiEnumDeviceInterfaces.
///    DeviceInterfaceDetailData = A pointer to an SP_DEVICE_INTERFACE_DETAIL_DATA structure to receive information about the specified interface.
///                                This parameter is optional and can be <b>NULL</b>. This parameter must be <b>NULL</b> if
///                                <i>DeviceInterfaceDetailSize</i> is zero. If this parameter is specified, the caller must set
///                                <i>DeviceInterfaceDetailData</i><b>.cbSize</b> to <b>sizeof</b>(SP_DEVICE_INTERFACE_DETAIL_DATA) before calling
///                                this function. The <b>cbSize</b> member always contains the size of the fixed part of the data structure, not a
///                                size reflecting the variable-length string at the end.
///    DeviceInterfaceDetailDataSize = The size of the <i>DeviceInterfaceDetailData</i> buffer. The buffer must be at least
///                                    (<b>offsetof</b>(SP_DEVICE_INTERFACE_DETAIL_DATA, <b>DevicePath</b>) + <b>sizeof</b>(TCHAR)) bytes, to contain
///                                    the fixed part of the structure and a single <b>NULL</b> to terminate an empty MULTI_SZ string. This parameter
///                                    must be zero if <i>DeviceInterfaceDetailData</i> is <b>NULL</b>.
///    RequiredSize = A pointer to a variable of type DWORD that receives the required size of the <i>DeviceInterfaceDetailData</i>
///                   buffer. This size includes the size of the fixed part of the structure plus the number of bytes required for the
///                   variable-length device path string. This parameter is optional and can be <b>NULL</b>.
///    DeviceInfoData = A pointer to a buffer that receives information about the device that supports the requested interface. The
///                     caller must set <i>DeviceInfoData</i><b>.cbSize</b> to <b>sizeof</b>(SP_DEVINFO_DATA). This parameter is optional
///                     and can be <b>NULL</b>.
///Returns:
///    <b>SetupDiGetDeviceInterfaceDetail</b> returns <b>TRUE</b> if the function completed without error. If the
///    function completed with an error, <b>FALSE</b> is returned and the error code for the failure can be retrieved by
///    calling GetLastError.
///    
@DllImport("SETUPAPI")
BOOL SetupDiGetDeviceInterfaceDetailA(void* DeviceInfoSet, SP_DEVICE_INTERFACE_DATA* DeviceInterfaceData, 
                                      char* DeviceInterfaceDetailData, uint DeviceInterfaceDetailDataSize, 
                                      uint* RequiredSize, SP_DEVINFO_DATA* DeviceInfoData);

///The <b>SetupDiGetDeviceInterfaceDetail</b> function returns details about a device interface.
///Params:
///    DeviceInfoSet = A pointer to the device information set that contains the interface for which to retrieve details. This handle is
///                    typically returned by SetupDiGetClassDevs.
///    DeviceInterfaceData = A pointer to an SP_DEVICE_INTERFACE_DATA structure that specifies the interface in <i>DeviceInfoSet</i> for which
///                          to retrieve details. A pointer of this type is typically returned by SetupDiEnumDeviceInterfaces.
///    DeviceInterfaceDetailData = A pointer to an SP_DEVICE_INTERFACE_DETAIL_DATA structure to receive information about the specified interface.
///                                This parameter is optional and can be <b>NULL</b>. This parameter must be <b>NULL</b> if
///                                <i>DeviceInterfaceDetailSize</i> is zero. If this parameter is specified, the caller must set
///                                <i>DeviceInterfaceDetailData</i><b>.cbSize</b> to <b>sizeof</b>(SP_DEVICE_INTERFACE_DETAIL_DATA) before calling
///                                this function. The <b>cbSize</b> member always contains the size of the fixed part of the data structure, not a
///                                size reflecting the variable-length string at the end.
///    DeviceInterfaceDetailDataSize = The size of the <i>DeviceInterfaceDetailData</i> buffer. The buffer must be at least
///                                    (<b>offsetof</b>(SP_DEVICE_INTERFACE_DETAIL_DATA, <b>DevicePath</b>) + <b>sizeof</b>(TCHAR)) bytes, to contain
///                                    the fixed part of the structure and a single <b>NULL</b> to terminate an empty MULTI_SZ string. This parameter
///                                    must be zero if <i>DeviceInterfaceDetailData</i> is <b>NULL</b>.
///    RequiredSize = A pointer to a variable of type DWORD that receives the required size of the <i>DeviceInterfaceDetailData</i>
///                   buffer. This size includes the size of the fixed part of the structure plus the number of bytes required for the
///                   variable-length device path string. This parameter is optional and can be <b>NULL</b>.
///    DeviceInfoData = A pointer to a buffer that receives information about the device that supports the requested interface. The
///                     caller must set <i>DeviceInfoData</i><b>.cbSize</b> to <b>sizeof</b>(SP_DEVINFO_DATA). This parameter is optional
///                     and can be <b>NULL</b>.
///Returns:
///    <b>SetupDiGetDeviceInterfaceDetail</b> returns <b>TRUE</b> if the function completed without error. If the
///    function completed with an error, <b>FALSE</b> is returned and the error code for the failure can be retrieved by
///    calling GetLastError.
///    
@DllImport("SETUPAPI")
BOOL SetupDiGetDeviceInterfaceDetailW(void* DeviceInfoSet, SP_DEVICE_INTERFACE_DATA* DeviceInterfaceData, 
                                      char* DeviceInterfaceDetailData, uint DeviceInterfaceDetailDataSize, 
                                      uint* RequiredSize, SP_DEVINFO_DATA* DeviceInfoData);

///The <b>SetupDiInstallDeviceInterfaces</b> function is the default handler for the DIF_INSTALLINTERFACES installation
///request.
///Params:
///    DeviceInfoSet = A pointer to the device information set that contains a device information element that represents the device for
///                    which to install interfaces. The device information set must contain only elements for the local system.
///    DeviceInfoData = A pointer to an SP_DEVINFO_DATA structure that specifies the device information element in <i>DeviceInfoSet</i>.
///Returns:
///    <b>SetupDiInstallDeviceInterfaces</b> returns <b>TRUE</b> if the function completed without error. If the
///    function completed with an error, <b>FALSE</b> is returned and the error code for the failure can be retrieved by
///    calling GetLastError.
///    
@DllImport("SETUPAPI")
BOOL SetupDiInstallDeviceInterfaces(void* DeviceInfoSet, SP_DEVINFO_DATA* DeviceInfoData);

///The <b>SetupDiSetDeviceInterfaceDefault</b> function sets a device interface as the default interface for a device
///interface class.
///Params:
///    DeviceInfoSet = A handle to the device information set that contains the device interface to set as the default for a device
///                    interface class.
///    DeviceInterfaceData = A pointer to an SP_DEVICE_INTERFACE_DATA structure that specifies the device interface in <i>DeviceInfoSet</i>.
///    Flags = Not used, must be zero.
///    Reserved = Reserved for future use, must be <b>NULL</b>.
///Returns:
///    The function returns <b>TRUE</b> if it is successful. Otherwise, it returns <b>FALSE</b> and the logged error can
///    be retrieved with a call to GetLastError.
///    
@DllImport("SETUPAPI")
BOOL SetupDiSetDeviceInterfaceDefault(void* DeviceInfoSet, SP_DEVICE_INTERFACE_DATA* DeviceInterfaceData, 
                                      uint Flags, void* Reserved);

///The <b>SetupDiRegisterDeviceInfo</b> function is the default handler for the DIF_REGISTERDEVICE request.
///Params:
///    DeviceInfoSet = A handle to a device information set that contains a device information element that represents the device to
///                    register. The device information set must not contain any remote elements.
///    DeviceInfoData = A pointer to an SP_DEVINFO_DATA structure that specifies the device information element in <i>DeviceInfoSet</i>.
///                     This is an IN-OUT parameter because <i>DeviceInfoData.</i><b>DevInst</b> might be updated with a new handle value
///                     upon return.
///    Flags = A flag value that controls how the device is registered, which can be zero or the following value:
///    CompareProc = A pointer to a comparison callback function to use in duplicate detection. This parameter is optional and can be
///                  <b>NULL</b>. If this parameter is specified, the callback function is called for each device instance that is of
///                  the same class as the device instance that is being registered. The prototype of the callback function is as
///                  follows: ``` typedef DWORD (CALLBACK* PSP_DETSIG_CMPPROC) ( IN HDEVINFO DeviceInfoSet, IN PSP_DEVINFO_DATA
///                  NewDeviceData, IN PSP_DEVINFO_DATA ExistingDeviceData, IN PVOID CompareContextOPTIONAL ); ``` The compare
///                  function must return ERROR_DUPLICATE_FOUND if it finds that the two devices are duplicates. Otherwise, it should
///                  return NO_ERROR. If some other error is encountered, the callback function should return the appropriate ERROR_*
///                  code to indicate the failure. If <i>CompareProc</i> is not specified and duplication detection is requested, a
///                  default comparison behavior is used. The default is to compare the new device's detect signature with the detect
///                  signature of all other devices in the class. The detect signature is contained in the class-specific resource
///                  descriptor of the device's boot log configuration.
///    CompareContext = A pointer to a caller-supplied context buffer that is passed into the callback function. This parameter is
///                     ignored if <i>CompareProc</i> is not specified.
///    DupDeviceInfoData = A pointer to an SP_DEVINFO_DATA structure to receive information about a duplicate device instance, if any,
///                        discovered as a result of attempting to register this device. This parameter is optional and can be <b>NULL</b>.
///                        If this parameter is specified, the caller must set <i>DupDeviceInfoData.</i><b>cbSize</b> to
///                        <b>sizeof</b>(SP_DEVINFO_DATA). This will be filled in if the function returns <b>FALSE</b>, and GetLastError
///                        returns ERROR_DUPLICATE_FOUND. This device information element is added as a member of the specified
///                        <i>DeviceInfoSet</i>, if not already a member. If <i>DupDeviceInfoData</i> is not specified, the duplicate is not
///                        added to the device information set. If you call this function when handling a DIF_REGISTERDEVICE request, the
///                        <i>DupDeviceInfoData</i> parameter must be <b>NULL</b>.
///Returns:
///    The function returns <b>TRUE</b> if it is successful. Otherwise, it returns <b>FALSE</b> and the logged error can
///    be retrieved with a call to GetLastError.
///    
@DllImport("SETUPAPI")
BOOL SetupDiRegisterDeviceInfo(void* DeviceInfoSet, SP_DEVINFO_DATA* DeviceInfoData, uint Flags, 
                               PSP_DETSIG_CMPPROC CompareProc, void* CompareContext, 
                               SP_DEVINFO_DATA* DupDeviceInfoData);

///The <b>SetupDiBuildDriverInfoList</b> function builds a list of drivers that is associated with a specific device or
///with the global class driver list for a device information set.
///Params:
///    DeviceInfoSet = A handle to the device information set to contain the driver list, either globally for all device information
///                    elements or specifically for a single device information element. The device information set must not contain
///                    remote device information elements.
///    DeviceInfoData = A pointer to an SP_DEVINFO_DATA structure for the device information element in <i>DeviceInfoSet</i> that
///                     represents the device for which to build a driver list. This parameter is optional and can be <b>NULL</b>. If
///                     this parameter is specified, the list is associated with the specified device. If this parameter is <b>NULL</b>,
///                     the list is associated with the global class driver list for <i>DeviceInfoSet</i>. If the class of this device is
///                     updated because of building a compatible driver list, <i>DeviceInfoData.</i><b>ClassGuid</b> is updated upon
///                     return.
///    DriverType = The type of driver list to build. Must be one of the following values: <table> <tr> <th>Value</th>
///                 <th>Meaning</th> </tr> <tr> <td width="40%"><a id="SPDIT_CLASSDRIVER"></a><a id="spdit_classdriver"></a><dl>
///                 <dt><b>SPDIT_CLASSDRIVER</b></dt> </dl> </td> <td width="60%"> Build a list of class drivers. If
///                 <i>DeviceInfoData</i> is <b>NULL</b>, this driver list type must be specified. </td> </tr> <tr> <td
///                 width="40%"><a id="SPDIT_COMPATDRIVER"></a><a id="spdit_compatdriver"></a><dl> <dt><b>SPDIT_COMPATDRIVER</b></dt>
///                 </dl> </td> <td width="60%"> Build a list of compatible drivers. <i>DeviceInfoData</i> must not be <b>NULL</b> if
///                 this driver list type is specified. </td> </tr> </table>
///Returns:
///    The function returns <b>TRUE</b> if it is successful. Otherwise, it returns <b>FALSE</b> and the logged error can
///    be retrieved by making a call to GetLastError.
///    
@DllImport("SETUPAPI")
BOOL SetupDiBuildDriverInfoList(void* DeviceInfoSet, SP_DEVINFO_DATA* DeviceInfoData, uint DriverType);

///The <b>SetupDiCancelDriverInfoSearch</b> function cancels a driver list search that is currently in progress in a
///different thread.
///Params:
///    DeviceInfoSet = A handle to the device information set for which a driver list is being built.
///Returns:
///    If a driver list search is underway for the specified device information set when this function is called, the
///    search is terminated. <b>SetupDiCancelDriverInfoSearch</b> returns <b>TRUE</b> when the termination is confirmed.
///    Otherwise, it returns <b>FALSE</b> and a call to GetLastError returns ERROR_INVALID_HANDLE.
///    
@DllImport("SETUPAPI")
BOOL SetupDiCancelDriverInfoSearch(void* DeviceInfoSet);

///The <b>SetupDiEnumDriverInfo</b> function enumerates the members of a driver list.
///Params:
///    DeviceInfoSet = A handle to the device information set that contains the driver list to enumerate.
///    DeviceInfoData = A pointer to an SP_DEVINFO_DATA structure that specifies a device information element in <i>DeviceInfoSet</i>.
///                     This parameter is optional and can be <b>NULL</b>. If this parameter is specified, <b>SetupDiEnumDriverInfo</b>
///                     enumerates a driver list for the specified device. If this parameter is <b>NULL</b>, <b>SetupDiEnumDriverInfo</b>
///                     enumerates the global class driver list that is associated with <i>DeviceInfoSet</i> (this list is of type
///                     SPDIT_CLASSDRIVER).
///    DriverType = The type of driver list to enumerate, which must be one of the following values:
///    MemberIndex = The zero-based index of the driver information member to retrieve.
///    DriverInfoData = A pointer to a caller-initialized SP_DRVINFO_DATA structure that receives information about the enumerated
///                     driver. The caller must set <i>DriverInfoData.</i><b>cbSize</b> to <b>sizeof(</b>SP_DRVINFO_DATA<b>)</b> before
///                     calling <b>SetupDiEnumDriverInfo</b>. If the <b>cbSize</b> member is not properly set,
///                     <b>SetupDiEnumDriverInfo</b> will return <b>FALSE</b>.
///Returns:
///    The function returns <b>TRUE</b> if it is successful. Otherwise, it returns <b>FALSE</b> and the logged error can
///    be retrieved with a call to GetLastError.
///    
@DllImport("SETUPAPI")
BOOL SetupDiEnumDriverInfoA(void* DeviceInfoSet, SP_DEVINFO_DATA* DeviceInfoData, uint DriverType, 
                            uint MemberIndex, SP_DRVINFO_DATA_V2_A* DriverInfoData);

///The <b>SetupDiEnumDriverInfo</b> function enumerates the members of a driver list.
///Params:
///    DeviceInfoSet = A handle to the device information set that contains the driver list to enumerate.
///    DeviceInfoData = A pointer to an SP_DEVINFO_DATA structure that specifies a device information element in <i>DeviceInfoSet</i>.
///                     This parameter is optional and can be <b>NULL</b>. If this parameter is specified, <b>SetupDiEnumDriverInfo</b>
///                     enumerates a driver list for the specified device. If this parameter is <b>NULL</b>, <b>SetupDiEnumDriverInfo</b>
///                     enumerates the global class driver list that is associated with <i>DeviceInfoSet</i> (this list is of type
///                     SPDIT_CLASSDRIVER).
///    DriverType = The type of driver list to enumerate, which must be one of the following values:
///    MemberIndex = The zero-based index of the driver information member to retrieve.
///    DriverInfoData = A pointer to a caller-initialized SP_DRVINFO_DATA structure that receives information about the enumerated
///                     driver. The caller must set <i>DriverInfoData.</i><b>cbSize</b> to <b>sizeof(</b>SP_DRVINFO_DATA<b>)</b> before
///                     calling <b>SetupDiEnumDriverInfo</b>. If the <b>cbSize</b> member is not properly set,
///                     <b>SetupDiEnumDriverInfo</b> will return <b>FALSE</b>.
///Returns:
///    The function returns <b>TRUE</b> if it is successful. Otherwise, it returns <b>FALSE</b> and the logged error can
///    be retrieved with a call to GetLastError.
///    
@DllImport("SETUPAPI")
BOOL SetupDiEnumDriverInfoW(void* DeviceInfoSet, SP_DEVINFO_DATA* DeviceInfoData, uint DriverType, 
                            uint MemberIndex, SP_DRVINFO_DATA_V2_W* DriverInfoData);

///The <b>SetupDiGetSelectedDriver</b> function retrieves the selected driver for a device information set or a
///particular device information element.
///Params:
///    DeviceInfoSet = A handle to the device information set for which to retrieve a selected driver.
///    DeviceInfoData = A pointer to an SP_DEVINFO_DATA structure that specifies a device information element that represents the device
///                     in <i>DeviceInfoSet</i> for which to retrieve the selected driver. This parameter is optional and can be
///                     <b>NULL</b>. If this parameter is specified, <b>SetupDiGetSelectedDriver</b> retrieves the selected driver for
///                     the specified device. If this parameter is <b>NULL</b>, <b>SetupDiGetSelectedDriver</b> retrieves the selected
///                     class driver in the global class driver list that is associated with <i>DeviceInfoSet</i>.
///    DriverInfoData = A pointer to an SP_DRVINFO_DATA structure that receives information about the selected driver.
///Returns:
///    The function returns <b>TRUE</b> if it is successful. Otherwise, it returns <b>FALSE</b> and the logged error can
///    be retrieved with a call to GetLastError. If a driver has not been selected for the specified device instance,
///    the logged error is ERROR_NO_DRIVER_SELECTED.
///    
@DllImport("SETUPAPI")
BOOL SetupDiGetSelectedDriverA(void* DeviceInfoSet, SP_DEVINFO_DATA* DeviceInfoData, 
                               SP_DRVINFO_DATA_V2_A* DriverInfoData);

///The <b>SetupDiGetSelectedDriver</b> function retrieves the selected driver for a device information set or a
///particular device information element.
///Params:
///    DeviceInfoSet = A handle to the device information set for which to retrieve a selected driver.
///    DeviceInfoData = A pointer to an SP_DEVINFO_DATA structure that specifies a device information element that represents the device
///                     in <i>DeviceInfoSet</i> for which to retrieve the selected driver. This parameter is optional and can be
///                     <b>NULL</b>. If this parameter is specified, <b>SetupDiGetSelectedDriver</b> retrieves the selected driver for
///                     the specified device. If this parameter is <b>NULL</b>, <b>SetupDiGetSelectedDriver</b> retrieves the selected
///                     class driver in the global class driver list that is associated with <i>DeviceInfoSet</i>.
///    DriverInfoData = A pointer to an SP_DRVINFO_DATA structure that receives information about the selected driver.
///Returns:
///    The function returns <b>TRUE</b> if it is successful. Otherwise, it returns <b>FALSE</b> and the logged error can
///    be retrieved with a call to GetLastError. If a driver has not been selected for the specified device instance,
///    the logged error is ERROR_NO_DRIVER_SELECTED.
///    
@DllImport("SETUPAPI")
BOOL SetupDiGetSelectedDriverW(void* DeviceInfoSet, SP_DEVINFO_DATA* DeviceInfoData, 
                               SP_DRVINFO_DATA_V2_W* DriverInfoData);

///The <b>SetupDiSetSelectedDriver</b> function sets, or resets, the selected driver for a device information element or
///the selected class driver for a device information set.
///Params:
///    DeviceInfoSet = A handle to the device information set that contains the driver list from which to select a driver for a device
///                    information element or for the device information set.
///    DeviceInfoData = A pointer to an SP_DEVINFO_DATA structure that specifies the device information element in <i>DeviceInfoSet</i>.
///                     This parameter is optional and can be <b>NULL</b>. If this parameter is specified,
///                     <b>SetupDiSetSelectedDriver</b> sets, or resets, the selected driver for the specified device. If this parameter
///                     is <b>NULL</b>, <b>SetupDiSetSelectedDriver</b> sets, or resets, the selected class driver for
///                     <i>DeviceInfoSet</i>.
///    DriverInfoData = A pointer to an SP_DRVINFO_DATA structure that specifies the driver to be selected. This parameter is optional
///                     and can be <b>NULL</b>. If this parameter and <i>DeviceInfoData</i> are supplied, the specified driver must be a
///                     member of a driver list that is associated with <i>DeviceInfoData</i>. If this parameter is specified and
///                     <i>DeviceInfoData</i> is <b>NULL</b>, the driver must be a member of the global class driver list for
///                     <i>DeviceInfoSet</i>. If this parameter is <b>NULL</b>, the selected driver is reset for the device information
///                     element, if <i>DeviceInfoData</i> is specified, or the device information set, if <i>DeviceInfoData</i> is
///                     <b>NULL</b>. If the <i>DriverInfoData.</i><b>Reserved</b> is <b>NULL</b>, the caller is requesting a search for a
///                     driver node with the specified parameters (<b>DriverType</b>, <b>Description</b>, and <b>ProviderName</b>). If a
///                     match is found, that driver node is selected. The <b>Reserved</b> field is updated on output to reflect the
///                     actual driver node where the match was found. If a match is not found, the function fails and a call to
///                     GetLastError returns ERROR_INVALID_PARAMETER.
///Returns:
///    The function returns <b>TRUE</b> if it is successful. Otherwise, it returns <b>FALSE</b> and the logged error can
///    be retrieved with a call to GetLastError.
///    
@DllImport("SETUPAPI")
BOOL SetupDiSetSelectedDriverA(void* DeviceInfoSet, SP_DEVINFO_DATA* DeviceInfoData, 
                               SP_DRVINFO_DATA_V2_A* DriverInfoData);

///The <b>SetupDiSetSelectedDriver</b> function sets, or resets, the selected driver for a device information element or
///the selected class driver for a device information set.
///Params:
///    DeviceInfoSet = A handle to the device information set that contains the driver list from which to select a driver for a device
///                    information element or for the device information set.
///    DeviceInfoData = A pointer to an SP_DEVINFO_DATA structure that specifies the device information element in <i>DeviceInfoSet</i>.
///                     This parameter is optional and can be <b>NULL</b>. If this parameter is specified,
///                     <b>SetupDiSetSelectedDriver</b> sets, or resets, the selected driver for the specified device. If this parameter
///                     is <b>NULL</b>, <b>SetupDiSetSelectedDriver</b> sets, or resets, the selected class driver for
///                     <i>DeviceInfoSet</i>.
///    DriverInfoData = A pointer to an SP_DRVINFO_DATA structure that specifies the driver to be selected. This parameter is optional
///                     and can be <b>NULL</b>. If this parameter and <i>DeviceInfoData</i> are supplied, the specified driver must be a
///                     member of a driver list that is associated with <i>DeviceInfoData</i>. If this parameter is specified and
///                     <i>DeviceInfoData</i> is <b>NULL</b>, the driver must be a member of the global class driver list for
///                     <i>DeviceInfoSet</i>. If this parameter is <b>NULL</b>, the selected driver is reset for the device information
///                     element, if <i>DeviceInfoData</i> is specified, or the device information set, if <i>DeviceInfoData</i> is
///                     <b>NULL</b>. If the <i>DriverInfoData.</i><b>Reserved</b> is <b>NULL</b>, the caller is requesting a search for a
///                     driver node with the specified parameters (<b>DriverType</b>, <b>Description</b>, and <b>ProviderName</b>). If a
///                     match is found, that driver node is selected. The <b>Reserved</b> field is updated on output to reflect the
///                     actual driver node where the match was found. If a match is not found, the function fails and a call to
///                     GetLastError returns ERROR_INVALID_PARAMETER.
///Returns:
///    The function returns <b>TRUE</b> if it is successful. Otherwise, it returns <b>FALSE</b> and the logged error can
///    be retrieved with a call to GetLastError.
///    
@DllImport("SETUPAPI")
BOOL SetupDiSetSelectedDriverW(void* DeviceInfoSet, SP_DEVINFO_DATA* DeviceInfoData, 
                               SP_DRVINFO_DATA_V2_W* DriverInfoData);

///The <b>SetupDiGetDriverInfoDetail</b> function retrieves driver information detail for a device information set or a
///particular device information element in the device information set.
///Params:
///    DeviceInfoSet = A handle to a device information set that contains a driver information element for which to retrieve driver
///                    information.
///    DeviceInfoData = A pointer to an SP_DEVINFO_DATA structure that specifies a device information element that represents the device
///                     for which to retrieve driver information. This parameter is optional and can be <b>NULL</b>. If this parameter is
///                     specified, <b>SetupDiGetDriverInfoDetail</b> retrieves information about a driver in a driver list for the
///                     specified device. If this parameter is <b>NULL</b>, <b>SetupDiGetDriverInfoDetail</b> retrieves information about
///                     a driver that is a member of the global class driver list for <i>DeviceInfoSet</i>.
///    DriverInfoData = A pointer to an SP_DRVINFO_DATA structure that specifies the driver information element that represents the
///                     driver for which to retrieve details. If <i>DeviceInfoData</i> is specified, the driver must be a member of the
///                     driver list for the device that is specified by <i>DeviceInfoData</i>. Otherwise, the driver must be a member of
///                     the global class driver list for <i>DeviceInfoSet</i>.
///    DriverInfoDetailData = A pointer to an SP_DRVINFO_DETAIL_DATA structure that receives detailed information about the specified driver.
///                           If this parameter is not specified, <i>DriverInfoDetailDataSize</i> must be zero. If this parameter is specified,
///                           <i>DriverInfoDetailData.</i><b>cbSize</b> must be set to the value of
///                           <b>sizeof(</b>SP_DRVINFO_DETAIL_DATA<b>)</b> before it calls <b>SetupDiGetDriverInfoDetail</b>. <div
///                           class="alert"><b>Note</b> <i>DriverInfoDetailData.</i><b>cbSize</b> must not be set to the value of the
///                           <i>DriverInfoDetailDataSize </i>parameter<i>.</i></div> <div> </div>
///    DriverInfoDetailDataSize = The size, in bytes, of the <i>DriverInfoDetailData</i> buffer.
///    RequiredSize = A pointer to a variable that receives the number of bytes required to store the detailed driver information. This
///                   value includes both the size of the structure and the additional bytes required for the variable-length character
///                   buffer at the end that holds the hardware ID list and the compatible ID list. The lists are in REG_MULTI_SZ
///                   format. For information about hardware and compatible IDs, see Device Identification Strings.
///Returns:
///    The function returns <b>TRUE</b> if it is successful. Otherwise, it returns <b>FALSE</b> and the logged error can
///    be retrieved by making a call to GetLastError.
///    
@DllImport("SETUPAPI")
BOOL SetupDiGetDriverInfoDetailA(void* DeviceInfoSet, SP_DEVINFO_DATA* DeviceInfoData, 
                                 SP_DRVINFO_DATA_V2_A* DriverInfoData, char* DriverInfoDetailData, 
                                 uint DriverInfoDetailDataSize, uint* RequiredSize);

///The <b>SetupDiGetDriverInfoDetail</b> function retrieves driver information detail for a device information set or a
///particular device information element in the device information set.
///Params:
///    DeviceInfoSet = A handle to a device information set that contains a driver information element for which to retrieve driver
///                    information.
///    DeviceInfoData = A pointer to an SP_DEVINFO_DATA structure that specifies a device information element that represents the device
///                     for which to retrieve driver information. This parameter is optional and can be <b>NULL</b>. If this parameter is
///                     specified, <b>SetupDiGetDriverInfoDetail</b> retrieves information about a driver in a driver list for the
///                     specified device. If this parameter is <b>NULL</b>, <b>SetupDiGetDriverInfoDetail</b> retrieves information about
///                     a driver that is a member of the global class driver list for <i>DeviceInfoSet</i>.
///    DriverInfoData = A pointer to an SP_DRVINFO_DATA structure that specifies the driver information element that represents the
///                     driver for which to retrieve details. If <i>DeviceInfoData</i> is specified, the driver must be a member of the
///                     driver list for the device that is specified by <i>DeviceInfoData</i>. Otherwise, the driver must be a member of
///                     the global class driver list for <i>DeviceInfoSet</i>.
///    DriverInfoDetailData = A pointer to an SP_DRVINFO_DETAIL_DATA structure that receives detailed information about the specified driver.
///                           If this parameter is not specified, <i>DriverInfoDetailDataSize</i> must be zero. If this parameter is specified,
///                           <i>DriverInfoDetailData.</i><b>cbSize</b> must be set to the value of
///                           <b>sizeof(</b>SP_DRVINFO_DETAIL_DATA<b>)</b> before it calls <b>SetupDiGetDriverInfoDetail</b>. <div
///                           class="alert"><b>Note</b> <i>DriverInfoDetailData.</i><b>cbSize</b> must not be set to the value of the
///                           <i>DriverInfoDetailDataSize </i>parameter<i>.</i></div> <div> </div>
///    DriverInfoDetailDataSize = The size, in bytes, of the <i>DriverInfoDetailData</i> buffer.
///    RequiredSize = A pointer to a variable that receives the number of bytes required to store the detailed driver information. This
///                   value includes both the size of the structure and the additional bytes required for the variable-length character
///                   buffer at the end that holds the hardware ID list and the compatible ID list. The lists are in REG_MULTI_SZ
///                   format. For information about hardware and compatible IDs, see Device Identification Strings.
///Returns:
///    The function returns <b>TRUE</b> if it is successful. Otherwise, it returns <b>FALSE</b> and the logged error can
///    be retrieved by making a call to GetLastError.
///    
@DllImport("SETUPAPI")
BOOL SetupDiGetDriverInfoDetailW(void* DeviceInfoSet, SP_DEVINFO_DATA* DeviceInfoData, 
                                 SP_DRVINFO_DATA_V2_W* DriverInfoData, char* DriverInfoDetailData, 
                                 uint DriverInfoDetailDataSize, uint* RequiredSize);

///The <b>SetupDiDestroyDriverInfoList</b> function deletes a driver list.
///Params:
///    DeviceInfoSet = A handle to a device information set that contains the driver list to delete.
///    DeviceInfoData = A pointer to an SP_DEVINFO_DATA structure that specifies the device information element in <i>DeviceInfoSet</i>.
///                     This parameter is optional and can be set to <b>NULL</b>. If this parameter is specified,
///                     <b>SetupDiDestroyDriverInfoList</b> deletes the driver list for the specified device. If this parameter is
///                     <b>NULL</b>, <b>SetupDiDestroyDriverInfoList</b> deletes the global class driver list that is associated with
///                     <i>DeviceInfoSet</i>.
///    DriverType = The type of driver list to delete, which must be one of the following values:
///Returns:
///    The function returns <b>TRUE</b> if it is successful. Otherwise, it returns <b>FALSE</b> and the logged error can
///    be retrieved with a call to GetLastError.
///    
@DllImport("SETUPAPI")
BOOL SetupDiDestroyDriverInfoList(void* DeviceInfoSet, SP_DEVINFO_DATA* DeviceInfoData, uint DriverType);

///The <b>SetupDiGetClassDevs</b> function returns a handle to a device information set that contains requested device
///information elements for a local computer.
///Params:
///    ClassGuid = A pointer to the GUID for a device setup class or a device interface class. This pointer is optional and can be
///                <b>NULL</b>. For more information about how to set <i>ClassGuid</i>, see the following <b>Remarks</b> section.
///    Enumerator = A pointer to a NULL-terminated string that specifies: <ul> <li> An identifier (ID) of a Plug and Play (PnP)
///                 enumerator. This ID can either be the value's globally unique identifier (GUID) or symbolic name. For example,
///                 "PCI" can be used to specify the PCI PnP value. Other examples of symbolic names for PnP values include "USB,"
///                 "PCMCIA," and "SCSI". </li> <li> A PnP device instance ID. When specifying a PnP device instance ID,
///                 DIGCF_DEVICEINTERFACE must be set in the Flags parameter. </li> </ul> This pointer is optional and can be
///                 <b>NULL</b>. If an <i>enumeration</i> value is not used to select devices, set <i>Enumerator</i> to <b>NULL</b>
///                 For more information about how to set the <i>Enumerator</i> value, see the following <b>Remarks</b> section.
///    hwndParent = A handle to the top-level window to be used for a user interface that is associated with installing a device
///                 instance in the device information set. This handle is optional and can be <b>NULL</b>.
///    Flags = A variable of type DWORD that specifies control options that filter the device information elements that are
///            added to the device information set. This parameter can be a bitwise OR of zero or more of the following flags.
///            For more information about combining these flags, see the following <b>Remarks</b> section.
///Returns:
///    If the operation succeeds, <b>SetupDiGetClassDevs</b> returns a handle to a device information set that contains
///    all installed devices that matched the supplied parameters. If the operation fails, the function returns
///    INVALID_HANDLE_VALUE. To get extended error information, call GetLastError.
///    
@DllImport("SETUPAPI")
void* SetupDiGetClassDevsW(const(GUID)* ClassGuid, const(wchar)* Enumerator, HWND hwndParent, uint Flags);

///The <b>SetupDiGetClassDevsEx</b> function returns a handle to a device information set that contains requested device
///information elements for a local or a remote computer.
///Params:
///    ClassGuid = A pointer to the GUID for a device setup class or a device interface class. This pointer is optional and can be
///                <b>NULL</b>. If a GUID value is not used to select devices, set <i>ClassGuid</i> to <b>NULL</b>. For more
///                information about how to use <i>ClassGuid</i>, see the following <b>Remarks</b> section.
///    Enumerator = A pointer to a NULL-terminated string that specifies: <ul> <li> An identifier (ID) of a Plug and Play (PnP)
///                 enumerator. This ID can either be the enumerator's globally unique identifier (GUID) or symbolic name. For
///                 example, "PCI" can be used to specify the PCI PnP enumerator. Other examples of symbolic names for PnP
///                 enumerators include "USB", "PCMCIA", and "SCSI". </li> <li> A PnP device instance IDs. When specifying a PnP
///                 device instance ID, DIGCF_DEVICEINTERFACE must be set in the Flags parameter. </li> </ul> This pointer is
///                 optional and can be <b>NULL</b>. If an <i>Enumerator</i> value is not used to select devices, set
///                 <i>Enumerator</i> to <b>NULL</b> For more information about how to set the <i>Enumerator</i> value, see the
///                 following <b>Remarks</b> section.
///    hwndParent = A handle to the top-level window to be used for a user interface that is associated with installing a device
///                 instance in the device information set. This handle is optional and can be <b>NULL</b>.
///    Flags = A variable of type DWORD that specifies control options that filter the device information elements that are
///            added to the device information set. This parameter can be a bitwise OR of one or more of the following flags.
///            For more information about combining these control options, see the following <b>Remarks</b> section.
///    DeviceInfoSet = The handle to an existing device information set to which <b>SetupDiGetClassDevsEx</b> adds the requested device
///                    information elements. This parameter is optional and can be set to <b>NULL</b>. For more information about using
///                    this parameter, see the following <b>Remarks</b> section.
///    MachineName = A pointer to a constant string that contains the name of a remote computer on which the devices reside. A value
///                  of <b>NULL</b> for <i>MachineName</i> specifies that the device is installed on the local computer.
///    Reserved = Reserved for internal use. This parameter must be set to <b>NULL</b>.
///Returns:
///    If the operation succeeds, <b>SetupDiGetClassDevsEx</b> returns a handle to a device information set that
///    contains all installed devices that matched the supplied parameters. If the operation fails, the function returns
///    INVALID_HANDLE_VALUE. To get extended error information, call GetLastError.
///    
@DllImport("SETUPAPI")
void* SetupDiGetClassDevsExA(const(GUID)* ClassGuid, const(char)* Enumerator, HWND hwndParent, uint Flags, 
                             void* DeviceInfoSet, const(char)* MachineName, void* Reserved);

///The <b>SetupDiGetClassDevsEx</b> function returns a handle to a device information set that contains requested device
///information elements for a local or a remote computer.
///Params:
///    ClassGuid = A pointer to the GUID for a device setup class or a device interface class. This pointer is optional and can be
///                <b>NULL</b>. If a GUID value is not used to select devices, set <i>ClassGuid</i> to <b>NULL</b>. For more
///                information about how to use <i>ClassGuid</i>, see the following <b>Remarks</b> section.
///    Enumerator = A pointer to a NULL-terminated string that specifies: <ul> <li> An identifier (ID) of a Plug and Play (PnP)
///                 enumerator. This ID can either be the enumerator's globally unique identifier (GUID) or symbolic name. For
///                 example, "PCI" can be used to specify the PCI PnP enumerator. Other examples of symbolic names for PnP
///                 enumerators include "USB", "PCMCIA", and "SCSI". </li> <li> A PnP device instance IDs. When specifying a PnP
///                 device instance ID, DIGCF_DEVICEINTERFACE must be set in the Flags parameter. </li> </ul> This pointer is
///                 optional and can be <b>NULL</b>. If an <i>Enumerator</i> value is not used to select devices, set
///                 <i>Enumerator</i> to <b>NULL</b> For more information about how to set the <i>Enumerator</i> value, see the
///                 following <b>Remarks</b> section.
///    hwndParent = A handle to the top-level window to be used for a user interface that is associated with installing a device
///                 instance in the device information set. This handle is optional and can be <b>NULL</b>.
///    Flags = A variable of type DWORD that specifies control options that filter the device information elements that are
///            added to the device information set. This parameter can be a bitwise OR of one or more of the following flags.
///            For more information about combining these control options, see the following <b>Remarks</b> section.
///    DeviceInfoSet = The handle to an existing device information set to which <b>SetupDiGetClassDevsEx</b> adds the requested device
///                    information elements. This parameter is optional and can be set to <b>NULL</b>. For more information about using
///                    this parameter, see the following <b>Remarks</b> section.
///    MachineName = A pointer to a constant string that contains the name of a remote computer on which the devices reside. A value
///                  of <b>NULL</b> for <i>MachineName</i> specifies that the device is installed on the local computer.
///    Reserved = Reserved for internal use. This parameter must be set to <b>NULL</b>.
///Returns:
///    If the operation succeeds, <b>SetupDiGetClassDevsEx</b> returns a handle to a device information set that
///    contains all installed devices that matched the supplied parameters. If the operation fails, the function returns
///    INVALID_HANDLE_VALUE. To get extended error information, call GetLastError.
///    
@DllImport("SETUPAPI")
void* SetupDiGetClassDevsExW(const(GUID)* ClassGuid, const(wchar)* Enumerator, HWND hwndParent, uint Flags, 
                             void* DeviceInfoSet, const(wchar)* MachineName, void* Reserved);

///The <b>SetupDiGetINFClass</b> function returns the class of a specified device INF file.
///Params:
///    InfName = A pointer to a NULL-terminated string that supplies the name of a device INF file. This name can include a path.
///              However, if just the file name is specified, the file is searched for in each directory that is listed in the
///              <b>DevicePath</b> entry under the <b>HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion</b> subkey of the registry.
///              The maximum length in characters, including a NULL terminator, of a NULL-terminated INF file name is MAX_PATH.
///    ClassGuid = A pointer to a variable of type GUID that receives the class GUID for the specified INF file. If the INF file
///                does not specify a class name, the function returns a GUID_NULL structure. Call SetupDiClassGuidsFromName to
///                determine whether one or more classes with this name are already installed.
///    ClassName = A pointer to a buffer that receives a NULL-terminated string that contains the name of the class for the
///                specified INF file. If the INF file does not specify a class name but does specify a GUID, this buffer receives
///                the name that is retrieved by calling SetupDiClassNameFromGuid. However, if <b>SetupDiClassNameFromGuid</b>
///                cannot retrieve a class name (for example, the class is not installed), it returns an empty string.
///    ClassNameSize = The size, in characters, of the buffer that is pointed to by the <i>ClassName</i> parameter. The maximum length
///                    of a NULL-terminated class name, in characters, is MAX_CLASS_NAME_LEN.
///    RequiredSize = A pointer to a DWORD-typed variable that receives the number of characters that are required to store the class
///                   name, including a terminating <b>NULL</b>. This pointer is optional and can be <b>NULL</b>.
///Returns:
///    The function returns <b>TRUE</b> if it is successful. Otherwise, it returns <b>FALSE</b> and the logged error can
///    be retrieved with a call to GetLastError.
///    
@DllImport("SETUPAPI")
BOOL SetupDiGetINFClassA(const(char)* InfName, GUID* ClassGuid, const(char)* ClassName, uint ClassNameSize, 
                         uint* RequiredSize);

///The <b>SetupDiGetINFClass</b> function returns the class of a specified device INF file.
///Params:
///    InfName = A pointer to a NULL-terminated string that supplies the name of a device INF file. This name can include a path.
///              However, if just the file name is specified, the file is searched for in each directory that is listed in the
///              <b>DevicePath</b> entry under the <b>HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion</b> subkey of the registry.
///              The maximum length in characters, including a NULL terminator, of a NULL-terminated INF file name is MAX_PATH.
///    ClassGuid = A pointer to a variable of type GUID that receives the class GUID for the specified INF file. If the INF file
///                does not specify a class name, the function returns a GUID_NULL structure. Call SetupDiClassGuidsFromName to
///                determine whether one or more classes with this name are already installed.
///    ClassName = A pointer to a buffer that receives a NULL-terminated string that contains the name of the class for the
///                specified INF file. If the INF file does not specify a class name but does specify a GUID, this buffer receives
///                the name that is retrieved by calling SetupDiClassNameFromGuid. However, if <b>SetupDiClassNameFromGuid</b>
///                cannot retrieve a class name (for example, the class is not installed), it returns an empty string.
///    ClassNameSize = The size, in characters, of the buffer that is pointed to by the <i>ClassName</i> parameter. The maximum length
///                    of a NULL-terminated class name, in characters, is MAX_CLASS_NAME_LEN.
///    RequiredSize = A pointer to a DWORD-typed variable that receives the number of characters that are required to store the class
///                   name, including a terminating <b>NULL</b>. This pointer is optional and can be <b>NULL</b>.
///Returns:
///    The function returns <b>TRUE</b> if it is successful. Otherwise, it returns <b>FALSE</b> and the logged error can
///    be retrieved with a call to GetLastError.
///    
@DllImport("SETUPAPI")
BOOL SetupDiGetINFClassW(const(wchar)* InfName, GUID* ClassGuid, const(wchar)* ClassName, uint ClassNameSize, 
                         uint* RequiredSize);

///The <b>SetupDiBuildClassInfoList</b> function returns a list of setup class GUIDs that identify the classes that are
///installed on a local computer.
///Params:
///    Flags = Flags used to control exclusion of classes from the list. If no flags are specified, all setup classes are
///            included in the list. Can be a combination of the following values:
///    ClassGuidList = A pointer to a GUID-typed array that receives a list of setup class GUIDs. This pointer is optional and can be
///                    <b>NULL</b>.
///    ClassGuidListSize = The number of GUIDs in the array that is pointed to by the <i>ClassGuildList</i> parameter. If
///                        <i>ClassGuidList</i> is <b>NULL</b>, <i>ClassGuidSize</i> must be zero.
///    RequiredSize = A pointer to a DWORD-typed variable that receives the number of GUIDs that are returned (if the number is less
///                   than or equal to the size, in GUIDs, of the array that is pointed to by the <i>ClassGuidList</i> parameter). If
///                   this number is greater than the size of the <i>ClassGuidList</i> array, it indicates how large the
///                   <i>ClassGuidList</i> array must be in order to contain all the class GUIDs.
///Returns:
///    The function returns <b>TRUE</b> if it is successful. Otherwise, it returns <b>FALSE</b> and the logged error can
///    be retrieved by making a call to GetLastError.
///    
@DllImport("SETUPAPI")
BOOL SetupDiBuildClassInfoList(uint Flags, char* ClassGuidList, uint ClassGuidListSize, uint* RequiredSize);

///The <b>SetupDiBuildClassInfoListEx</b> function returns a list of setup class GUIDs that includes every class
///installed on the local system or a remote system.
///Params:
///    Flags = Flags used to control exclusion of classes from the list. If no flags are specified, all setup classes are
///            included in the list. Can be a combination of the following values:
///    ClassGuidList = A pointer to a buffer that receives a list of setup class GUIDs.
///    ClassGuidListSize = Supplies the number of GUIDs in the <i>ClassGuildList</i> array.
///    RequiredSize = A pointer to a variable that receives the number of GUIDs returned. If this number is greater than the size of
///                   the <i>ClassGuidList</i>, the number indicates how large the <i>ClassGuidList</i> array must be in order to
///                   contain the list.
///    MachineName = A pointer to a NULL-terminated string that contains the name of a remote computer from which to retrieve
///                  installed setup classes. This parameter is optional and can be <b>NULL</b>. If <i>MachineName</i> is <b>NULL</b>,
///                  this function builds a list of classes installed on the local computer.
///    Reserved = Must be <b>NULL</b>.
///Returns:
///    The function returns <b>TRUE</b> if it is successful. Otherwise, it returns <b>FALSE</b> and the logged error can
///    be retrieved by making a call to GetLastError.
///    
@DllImport("SETUPAPI")
BOOL SetupDiBuildClassInfoListExA(uint Flags, char* ClassGuidList, uint ClassGuidListSize, uint* RequiredSize, 
                                  const(char)* MachineName, void* Reserved);

///The <b>SetupDiBuildClassInfoListEx</b> function returns a list of setup class GUIDs that includes every class
///installed on the local system or a remote system.
///Params:
///    Flags = Flags used to control exclusion of classes from the list. If no flags are specified, all setup classes are
///            included in the list. Can be a combination of the following values:
///    ClassGuidList = A pointer to a buffer that receives a list of setup class GUIDs.
///    ClassGuidListSize = Supplies the number of GUIDs in the <i>ClassGuildList</i> array.
///    RequiredSize = A pointer to a variable that receives the number of GUIDs returned. If this number is greater than the size of
///                   the <i>ClassGuidList</i>, the number indicates how large the <i>ClassGuidList</i> array must be in order to
///                   contain the list.
///    MachineName = A pointer to a NULL-terminated string that contains the name of a remote computer from which to retrieve
///                  installed setup classes. This parameter is optional and can be <b>NULL</b>. If <i>MachineName</i> is <b>NULL</b>,
///                  this function builds a list of classes installed on the local computer.
///    Reserved = Must be <b>NULL</b>.
///Returns:
///    The function returns <b>TRUE</b> if it is successful. Otherwise, it returns <b>FALSE</b> and the logged error can
///    be retrieved by making a call to GetLastError.
///    
@DllImport("SETUPAPI")
BOOL SetupDiBuildClassInfoListExW(uint Flags, char* ClassGuidList, uint ClassGuidListSize, uint* RequiredSize, 
                                  const(wchar)* MachineName, void* Reserved);

///The <b>SetupDiGetClassDescription</b> function retrieves the class description associated with the specified setup
///class GUID.
///Params:
///    ClassGuid = The GUID of the setup class whose description is to be retrieved.
///    ClassDescription = A pointer to a character buffer that receives the class description.
///    ClassDescriptionSize = The size, in characters, of the <i>ClassDescription</i> buffer.
///    RequiredSize = A pointer to variable of type DWORD that receives the size, in characters, that is required to store the class
///                   description (including a NULL terminator). <i>RequiredSize</i> is always less than LINE_LEN. This parameter is
///                   optional and can be <b>NULL</b>.
///Returns:
///    The function returns <b>TRUE</b> if it is successful. Otherwise, it returns <b>FALSE</b> and the logged error can
///    be retrieved with a call to GetLastError.
///    
@DllImport("SETUPAPI")
BOOL SetupDiGetClassDescriptionA(const(GUID)* ClassGuid, const(char)* ClassDescription, uint ClassDescriptionSize, 
                                 uint* RequiredSize);

///The <b>SetupDiGetClassDescription</b> function retrieves the class description associated with the specified setup
///class GUID.
///Params:
///    ClassGuid = The GUID of the setup class whose description is to be retrieved.
///    ClassDescription = A pointer to a character buffer that receives the class description.
///    ClassDescriptionSize = The size, in characters, of the <i>ClassDescription</i> buffer.
///    RequiredSize = A pointer to variable of type DWORD that receives the size, in characters, that is required to store the class
///                   description (including a NULL terminator). <i>RequiredSize</i> is always less than LINE_LEN. This parameter is
///                   optional and can be <b>NULL</b>.
///Returns:
///    The function returns <b>TRUE</b> if it is successful. Otherwise, it returns <b>FALSE</b> and the logged error can
///    be retrieved with a call to GetLastError.
///    
@DllImport("SETUPAPI")
BOOL SetupDiGetClassDescriptionW(const(GUID)* ClassGuid, const(wchar)* ClassDescription, uint ClassDescriptionSize, 
                                 uint* RequiredSize);

///The <b>SetupDiGetClassDescriptionEx</b> function retrieves the description of a setup class installed on a local or
///remote computer.
///Params:
///    ClassGuid = A pointer to the GUID for the setup class whose description is to be retrieved.
///    ClassDescription = A pointer to a character buffer that receives the class description.
///    ClassDescriptionSize = The size, in characters, of the buffer that is pointed to by the <i>ClassDescription</i> parameter. The maximum
///                           length, in characters, of a NULL-terminated class description is LINE_LEN. For more information, see the
///                           following <b>Remarks</b> section.
///    RequiredSize = A pointer to a DWORD-typed variable that receives the size, in characters, that is required to store the
///                   requested NULL-terminated class description. This pointer is optional and can be <b>NULL</b>.
///    MachineName = A pointer to a NULL-terminated string that supplies the name of a remote computer on which the setup class
///                  resides. This pointer is optional and can be <b>NULL</b>. If the class is installed on a local computer, set the
///                  pointer to <b>NULL</b>.
///    Reserved = Reserved for system use. A caller of this function must set this parameter to <b>NULL</b>.
///Returns:
///    The function returns <b>TRUE</b> if it is successful. Otherwise, it returns <b>FALSE</b> and the logged error can
///    be retrieved with a call to GetLastError.
///    
@DllImport("SETUPAPI")
BOOL SetupDiGetClassDescriptionExA(const(GUID)* ClassGuid, const(char)* ClassDescription, 
                                   uint ClassDescriptionSize, uint* RequiredSize, const(char)* MachineName, 
                                   void* Reserved);

///The <b>SetupDiGetClassDescriptionEx</b> function retrieves the description of a setup class installed on a local or
///remote computer.
///Params:
///    ClassGuid = A pointer to the GUID for the setup class whose description is to be retrieved.
///    ClassDescription = A pointer to a character buffer that receives the class description.
///    ClassDescriptionSize = The size, in characters, of the buffer that is pointed to by the <i>ClassDescription</i> parameter. The maximum
///                           length, in characters, of a NULL-terminated class description is LINE_LEN. For more information, see the
///                           following <b>Remarks</b> section.
///    RequiredSize = A pointer to a DWORD-typed variable that receives the size, in characters, that is required to store the
///                   requested NULL-terminated class description. This pointer is optional and can be <b>NULL</b>.
///    MachineName = A pointer to a NULL-terminated string that supplies the name of a remote computer on which the setup class
///                  resides. This pointer is optional and can be <b>NULL</b>. If the class is installed on a local computer, set the
///                  pointer to <b>NULL</b>.
///    Reserved = Reserved for system use. A caller of this function must set this parameter to <b>NULL</b>.
///Returns:
///    The function returns <b>TRUE</b> if it is successful. Otherwise, it returns <b>FALSE</b> and the logged error can
///    be retrieved with a call to GetLastError.
///    
@DllImport("SETUPAPI")
BOOL SetupDiGetClassDescriptionExW(const(GUID)* ClassGuid, const(wchar)* ClassDescription, 
                                   uint ClassDescriptionSize, uint* RequiredSize, const(wchar)* MachineName, 
                                   void* Reserved);

///The <b>SetupDiCallClassInstaller</b> function calls the appropriate class installer, and any registered
///co-installers, with the specified installation request (DIF code).
///Params:
///    InstallFunction = The device installation request (DIF request) to pass to the co-installers and class installer. DIF codes have
///                      the format <b>DIF_<i>XXX</i></b> and are defined in Setupapi.h. See Device Installation Function Codes for more
///                      information. <div class="alert"><b>Note</b> For certain DIF requests, the caller must be a member of the
///                      Administrators group. For such DIF requests, this requirement is listed on the reference page for the associated
///                      default handler.</div> <div> </div>
///    DeviceInfoSet = A handle to a device information set for the local computer. This set contains a device installation element
///                    which represents the device for which to perform the specified installation function.
///    DeviceInfoData = A pointer to an SP_DEVINFO_DATA structure that specifies the device information element in the
///                     <i>DeviceInfoSet</i> that represents the device for which to perform the specified installation function. This
///                     parameter is optional and can be set to <b>NULL</b>. If this parameter is specified,
///                     <b>SetupDiCallClassInstaller</b> performs the specified function on the <i>DeviceInfoData</i> element. If
///                     <i>DeviceInfoData</i> is <b>NULL</b>, <b>SetupDiCallClassInstaller</b> calls the installers for the setup class
///                     that is associated with <i>DeviceInfoSet</i>.
///Returns:
///    The function returns <b>TRUE</b> if it is successful. Otherwise, it returns <b>FALSE</b> and the logged error can
///    be retrieved by making a call to GetLastError. When GetLastError returns <b>ERROR_IN_WOW64</b>, this means that
///    the calling application is a 32-bit application attempting to execute in a 64-bit environment, which is not
///    allowed.
///    
@DllImport("SETUPAPI")
BOOL SetupDiCallClassInstaller(uint InstallFunction, void* DeviceInfoSet, SP_DEVINFO_DATA* DeviceInfoData);

///The <b>SetupDiSelectDevice</b> function is the default handler for the DIF_SELECTDEVICE request.
///Params:
///    DeviceInfoSet = A handle to a device information set that contains a device information element that represents the device for
///                    which to select a driver.
///    DeviceInfoData = A pointer to an SP_DEVINFO_DATA structure that specifies the device information element. This parameter is
///                     optional and can be <b>NULL</b>. If this parameter is specified, <b>SetupDiSelectDevice</b> selects the driver
///                     for the specified device and sets <i>DeviceInfoData.</i><b>ClassGuid</b> to the GUID of the device setup class
///                     for the selected driver. If this parameter is <b>NULL</b>, <b>SetupDiSelectDevice</b> sets the selected driver in
///                     the global class driver list for <i>DeviceInfoSet</i>.
///Returns:
///    The function returns <b>TRUE</b> if it is successful. Otherwise, it returns <b>FALSE</b> and the logged error can
///    be retrieved by a call to GetLastError.
///    
@DllImport("SETUPAPI")
BOOL SetupDiSelectDevice(void* DeviceInfoSet, SP_DEVINFO_DATA* DeviceInfoData);

///The <b>SetupDiSelectBestCompatDrv</b> function is the default handler for the DIF_SELECTBESTCOMPATDRV installation
///request.
///Params:
///    DeviceInfoSet = A handle to a device information set that contains a device information element that represents the device for
///                    which to select the best compatible driver.
///    DeviceInfoData = A pointer to an SP_DEVINFO_DATA structure that specifies the device information element in <i>DeviceInfoSet</i>.
///                     <b>SetupDiSelectBestCompatDrv</b> selects the best driver for a device information element from the compatible
///                     driver list for the specified device.
///Returns:
///    If the operation succeeds, <b>SetupDiSelectBestCompatDrv</b> returns <b>TRUE</b>. Otherwise, the function returns
///    <b>FALSE</b> and the logged error can be retrieved by a call to GetLastError.
///    
@DllImport("SETUPAPI")
BOOL SetupDiSelectBestCompatDrv(void* DeviceInfoSet, SP_DEVINFO_DATA* DeviceInfoData);

///The <b>SetupDiInstallDevice</b> function is the default handler for the DIF_INSTALLDEVICE installation request.
///Params:
///    DeviceInfoSet = A handle to the device information set for the local system that contains a device information element that
///                    represents the device to install.
///    DeviceInfoData = A pointer to an SP_DEVINFO_DATA structure that specifies a device information element in <i>DeviceInfoSet</i>.
///                     This is an IN-OUT parameter because <i>DeviceInfoData.</i><b>DevInst</b> might be updated with a new handle value
///                     upon return.
///Returns:
///    The function returns <b>TRUE</b> if it is successful. Otherwise, it returns <b>FALSE</b> and the logged error can
///    be retrieved with a call to GetLastError.
///    
@DllImport("SETUPAPI")
BOOL SetupDiInstallDevice(void* DeviceInfoSet, SP_DEVINFO_DATA* DeviceInfoData);

///The <b>SetupDiInstallDriverFiles</b> function is the default handler for the DIF_INSTALLDEVICEFILES installation
///request.
///Params:
///    DeviceInfoSet = A handle to the device information set that contains the device information element that represents the device
///                    for which to install files. The device information set must not contain remote elements.
///    DeviceInfoData = A pointer to an SP_DEVINFO_DATA structure that specifies the device information element in <i>DeviceInfoSet</i>.
///Returns:
///    The function returns <b>TRUE</b> if it is successful. Otherwise, it returns <b>FALSE</b> and the logged error can
///    be retrieved with a call to GetLastError.
///    
@DllImport("SETUPAPI")
BOOL SetupDiInstallDriverFiles(void* DeviceInfoSet, SP_DEVINFO_DATA* DeviceInfoData);

///The <b>SetupDiRegisterCoDeviceInstallers</b> function is the default handler for DIF_REGISTER_COINSTALLERS.
///Params:
///    DeviceInfoSet = A handle to the device information set that contains a device information element that represents the device for
///                    which to register co-installers. The device information set must not contain any remote elements.
///    DeviceInfoData = A pointer to an SP_DEVINFO_DATA structure that specifies the device information element in <i>DeviceInfoSet</i>.
///Returns:
///    <b>SetupDiRegisterCoDeviceInstallers</b> returns <b>TRUE</b> if the function succeeds. If the function returns
///    <b>FALSE</b>, call GetLastError for extended error information.
///    
@DllImport("SETUPAPI")
BOOL SetupDiRegisterCoDeviceInstallers(void* DeviceInfoSet, SP_DEVINFO_DATA* DeviceInfoData);

///The <b>SetupDiRemoveDevice</b> function is the default handler for the DIF_REMOVE installation request.
///Params:
///    DeviceInfoSet = A handle to a device information set for the local system that contains a device information element that
///                    represents the device to remove.
///    DeviceInfoData = A pointer to an SP_DEVINFO_DATA structure that specifies the device information element in <i>DeviceInfoSet</i>.
///                     This is an IN-OUT parameter because <i>DeviceInfoSet</i>.<b>DevInst</b> might be updated with a new handle value
///                     upon return. If this is a global removal or the last hardware profile-specific removal, all traces of the device
///                     instance are deleted from the registry and the handle will be <b>NULL</b>.
///Returns:
///    The function returns <b>TRUE</b> if it is successful. Otherwise, it returns <b>FALSE</b> and the logged error can
///    be retrieved by a call to <b>GetLastError</b>.
///    
@DllImport("SETUPAPI")
BOOL SetupDiRemoveDevice(void* DeviceInfoSet, SP_DEVINFO_DATA* DeviceInfoData);

///The <b>SetupDiUnremoveDevice</b> function is the default handler for the DIF_UNREMOVE installation request.
///Params:
///    DeviceInfoSet = A handle to a device information set for the local system that contains a device information element that
///                    represents a device to restore and to restart.
///    DeviceInfoData = A pointer to an SP_DEVINFO_DATA structure that specifies the device information element in <i>DeviceInfoSet</i>.
///                     This is an IN-OUT parameter because <i>DeviceInfoData.</i><b>DevInst</b> might be updated with a new handle value
///                     on return.
///Returns:
///    The function returns <b>TRUE</b> if it is successful. Otherwise, it returns <b>FALSE</b> and the logged error can
///    be retrieved by a call to GetLastError.
///    
@DllImport("SETUPAPI")
BOOL SetupDiUnremoveDevice(void* DeviceInfoSet, SP_DEVINFO_DATA* DeviceInfoData);

///The <b>SetupDiRestartDevices</b> function restarts a specified device or, if necessary, restarts all devices that are
///operated by the same function and filter drivers that operate the specified device.
///Params:
///    DeviceInfoSet = A handle to a device information set that contains the device information element that represents the device to
///                    restart.
///    DeviceInfoData = A pointer to an SP_DEVINFO_DATA structure for the device information member that represents the device to
///                     restart. This parameter is also an output parameter because <b>SetupDiRestartDevices</b> updates the device
///                     installation parameters for this device information member and the status and problem code of the corresponding
///                     device instance. For more information about these updates, see the following <b>Remarks</b> section.
///Returns:
///    If the operation succeeds, <b>SetupDiRestartDevices</b> returns <b>TRUE</b>; otherwise, the function returns
///    <b>FALSE</b> and the logged error can be retrieved by a call to GetLastError.
///    
@DllImport("SETUPAPI")
BOOL SetupDiRestartDevices(void* DeviceInfoSet, SP_DEVINFO_DATA* DeviceInfoData);

///The <b>SetupDiChangeState</b> function is the default handler for the DIF_PROPERTYCHANGE installation request.
///Params:
///    DeviceInfoSet = A handle to a device information set for the local computer. This set contains a device information element that
///                    represents the device whose state is to be changed.
///    DeviceInfoData = A pointer to an SP_DEVINFO_DATA structure that specifies the device information element in <i>DeviceInfoSet</i>.
///                     This is an IN-OUT parameter because <i>DeviceInfoData.</i><b>DevInst</b> might be updated with a new handle value
///                     upon return.
///Returns:
///    The function returns <b>TRUE</b> if it is successful. Otherwise, it returns <b>FALSE</b> and the logged error can
///    be retrieved by making a call to GetLastError.
///    
@DllImport("SETUPAPI")
BOOL SetupDiChangeState(void* DeviceInfoSet, SP_DEVINFO_DATA* DeviceInfoData);

///The <b>SetupDiInstallClass</b> function installs the <b>ClassInstall32</b> section of the specified INF file.
///Params:
///    hwndParent = The handle to the parent window for any user interface that is used to install this class. This parameter is
///                 optional and can be <b>NULL</b>.
///    InfFileName = A pointer to a NULL-terminated string that contains the name of the INF file that contains an INF ClassInstall32
///                  section.
///    Flags = These flags control the installation process. Can be a combination of the following:
///    FileQueue = If the DI_NOVCP flag is set, this parameter supplies a handle to a file queue where file operations should be
///                queued but not committed.
///Returns:
///    The function returns <b>TRUE</b> if it is successful. Otherwise, it returns <b>FALSE</b> and the logged error can
///    be retrieved with a call to GetLastError.
///    
@DllImport("SETUPAPI")
BOOL SetupDiInstallClassA(HWND hwndParent, const(char)* InfFileName, uint Flags, void* FileQueue);

///The <b>SetupDiInstallClass</b> function installs the <b>ClassInstall32</b> section of the specified INF file.
///Params:
///    hwndParent = The handle to the parent window for any user interface that is used to install this class. This parameter is
///                 optional and can be <b>NULL</b>.
///    InfFileName = A pointer to a NULL-terminated string that contains the name of the INF file that contains an INF ClassInstall32
///                  section.
///    Flags = These flags control the installation process. Can be a combination of the following:
///    FileQueue = If the DI_NOVCP flag is set, this parameter supplies a handle to a file queue where file operations should be
///                queued but not committed.
///Returns:
///    The function returns <b>TRUE</b> if it is successful. Otherwise, it returns <b>FALSE</b> and the logged error can
///    be retrieved with a call to GetLastError.
///    
@DllImport("SETUPAPI")
BOOL SetupDiInstallClassW(HWND hwndParent, const(wchar)* InfFileName, uint Flags, void* FileQueue);

///The <b>SetupDiInstallClassEx</b> function installs a class installer or an interface class.
///Params:
///    hwndParent = The handle to the parent window for any user interface that is used to install this class. This parameter is
///                 optional and can be <b>NULL</b>.
///    InfFileName = A pointer to a NULL-terminated string that contains the name of an INF file. This parameter is optional and can
///                  be <b>NULL</b>. If this function is being used to install a class installer, the INF file contains an INF
///                  ClassInstall32 section and this parameter must not be <b>NULL</b>. If this function is being used to install an
///                  interface class, the INF file contains an INF InterfaceInstall32 section.
///    Flags = A value of type DWORD that controls the installation process. <i>Flags</i> can be zero or a bitwise OR of the
///            following values:
///    FileQueue = If the DI_NOVCP flag is set, this parameter supplies a handle to a file queue where file operations should be
///                queued but not committed.
///    InterfaceClassGuid = A pointer to a GUID that identifies the interface class to be installed. This parameter is optional and can be
///                         <b>NULL</b>. If this parameter is specified, this function is being used to install the interface class
///                         represented by the GUID. If this parameter is <b>NULL</b>, this function is being used to install a class
///                         installer.
///    Reserved1 = Reserved. Must be zero.
///    Reserved2 = Reserved. Must be zero.
///Returns:
///    <b>SetupDiInstallClassEx</b> returns <b>TRUE</b> if it is successful. Otherwise, it returns <b>FALSE</b> and the
///    logged error can be retrieved with a call to GetLastError.
///    
@DllImport("SETUPAPI")
BOOL SetupDiInstallClassExA(HWND hwndParent, const(char)* InfFileName, uint Flags, void* FileQueue, 
                            const(GUID)* InterfaceClassGuid, void* Reserved1, void* Reserved2);

///The <b>SetupDiInstallClassEx</b> function installs a class installer or an interface class.
///Params:
///    hwndParent = The handle to the parent window for any user interface that is used to install this class. This parameter is
///                 optional and can be <b>NULL</b>.
///    InfFileName = A pointer to a NULL-terminated string that contains the name of an INF file. This parameter is optional and can
///                  be <b>NULL</b>. If this function is being used to install a class installer, the INF file contains an INF
///                  ClassInstall32 section and this parameter must not be <b>NULL</b>. If this function is being used to install an
///                  interface class, the INF file contains an INF InterfaceInstall32 section.
///    Flags = A value of type DWORD that controls the installation process. <i>Flags</i> can be zero or a bitwise OR of the
///            following values:
///    FileQueue = If the DI_NOVCP flag is set, this parameter supplies a handle to a file queue where file operations should be
///                queued but not committed.
///    InterfaceClassGuid = A pointer to a GUID that identifies the interface class to be installed. This parameter is optional and can be
///                         <b>NULL</b>. If this parameter is specified, this function is being used to install the interface class
///                         represented by the GUID. If this parameter is <b>NULL</b>, this function is being used to install a class
///                         installer.
///    Reserved1 = Reserved. Must be zero.
///    Reserved2 = Reserved. Must be zero.
///Returns:
///    <b>SetupDiInstallClassEx</b> returns <b>TRUE</b> if it is successful. Otherwise, it returns <b>FALSE</b> and the
///    logged error can be retrieved with a call to GetLastError.
///    
@DllImport("SETUPAPI")
BOOL SetupDiInstallClassExW(HWND hwndParent, const(wchar)* InfFileName, uint Flags, void* FileQueue, 
                            const(GUID)* InterfaceClassGuid, void* Reserved1, void* Reserved2);

///The <b>SetupDiOpenClassRegKey</b> function opens the setup class registry key or a specific class's subkey.
///Params:
///    ClassGuid = A pointer to the GUID of the setup class whose key is to be opened. This parameter is optional and can be
///                <b>NULL</b>. If this parameter is <b>NULL</b>, the root of the setup class tree
///                (<b>HKLM\SYSTEM\CurrentControlSet\Control\Class</b>) is opened.
///    samDesired = The registry security access for the key to be opened. For information about registry security access values of
///                 type REGSAM, see the Microsoft Windows SDK documentation.
///Returns:
///    If the function is successful, it returns a handle to an opened registry key where information about this setup
///    class can be stored/retrieved. If the function fails, it returns INVALID_HANDLE_VALUE. To get extended error
///    information, call GetLastError.
///    
@DllImport("SETUPAPI")
HKEY SetupDiOpenClassRegKey(const(GUID)* ClassGuid, uint samDesired);

///The <b>SetupDiOpenClassRegKeyEx</b> function opens the device setup class registry key, the device interface class
///registry key, or a specific class's subkey. This function opens the specified key on the local computer or on a
///remote computer.
///Params:
///    ClassGuid = A pointer to the GUID of the class whose registry key is to be opened. This parameter is optional and can be
///                <b>NULL</b>. If this parameter is <b>NULL</b>, the root of the class tree
///                (<b>HKLM\SYSTEM\CurrentControlSet\Control\Class</b>) is opened.
///    samDesired = The registry security access for the key to be opened. For information about registry security access values of
///                 type REGSAM, see the Microsoft Windows SDK documentation.
///    Flags = The type of registry key to be opened, which is specified by one of the following:
///    MachineName = Optionally points to a string that contains the name of a remote computer on which to open the specified key.
///    Reserved = Reserved. Must be <b>NULL</b>.
///Returns:
///    <b>SetupDiOpenClassRegKeyEx</b> returns a handle to an opened registry key where information about this setup
///    class can be stored/retrieved. If the function fails, it returns INVALID_HANDLE_VALUE. To get extended error
///    information, call GetLastError.
///    
@DllImport("SETUPAPI")
HKEY SetupDiOpenClassRegKeyExA(const(GUID)* ClassGuid, uint samDesired, uint Flags, const(char)* MachineName, 
                               void* Reserved);

///The <b>SetupDiOpenClassRegKeyEx</b> function opens the device setup class registry key, the device interface class
///registry key, or a specific class's subkey. This function opens the specified key on the local computer or on a
///remote computer.
///Params:
///    ClassGuid = A pointer to the GUID of the class whose registry key is to be opened. This parameter is optional and can be
///                <b>NULL</b>. If this parameter is <b>NULL</b>, the root of the class tree
///                (<b>HKLM\SYSTEM\CurrentControlSet\Control\Class</b>) is opened.
///    samDesired = The registry security access for the key to be opened. For information about registry security access values of
///                 type REGSAM, see the Microsoft Windows SDK documentation.
///    Flags = The type of registry key to be opened, which is specified by one of the following:
///    MachineName = Optionally points to a string that contains the name of a remote computer on which to open the specified key.
///    Reserved = Reserved. Must be <b>NULL</b>.
///Returns:
///    <b>SetupDiOpenClassRegKeyEx</b> returns a handle to an opened registry key where information about this setup
///    class can be stored/retrieved. If the function fails, it returns INVALID_HANDLE_VALUE. To get extended error
///    information, call GetLastError.
///    
@DllImport("SETUPAPI")
HKEY SetupDiOpenClassRegKeyExW(const(GUID)* ClassGuid, uint samDesired, uint Flags, const(wchar)* MachineName, 
                               void* Reserved);

///The <b>SetupDiCreateDeviceInterfaceRegKey</b> function creates a registry key for storing information about a device
///interface and returns a handle to the key.
///Params:
///    DeviceInfoSet = A handle to a device information set that contains the interface for which to create a registry key. The device
///                    information set must not contain remote elements.
///    DeviceInterfaceData = A pointer to an SP_DEVICE_INTERFACE_DATA structure that specifies the device interface in <i>DeviceInfoSet</i>.
///                          This pointer is possibly returned by SetupDiCreateDeviceInterface.
///    Reserved = Reserved. Must be zero.
///    samDesired = The registry security access that the caller requests for the key that is being created. For information about
///                 registry security access values of type REGSAM, see the Microsoft Windows SDK documentation.
///    InfHandle = The handle to an open INF file that contains a <i>DDInstall</i> section to be executed for the newly-created key.
///                This parameter is optional and can be <b>NULL</b>. If this parameter is not <b>NULL</b>, <i>InfSectionName</i>
///                must be specified as well.
///    InfSectionName = A pointer to the name of an INF <i>DDInstall</i> section in the INF file that is specified by <i>InfHandle</i>.
///                     This section is executed for the newly created key. This parameter is optional and can be <b>NULL</b>. If this
///                     parameter is specified, <i>InfHandle</i> must be specified as well.
///Returns:
///    If <b>SetupDiCreateDeviceInterfaceRegKey</b> succeeds, the function returns a handle to the requested registry
///    key in which interface information can be stored and retrieved. If <b>SetupDiCreateDeviceInterfaceRegKey</b>
///    fails, the function returns INVALID_HANDLE_VALUE. Call GetLastError to get extended error information.
///    
@DllImport("SETUPAPI")
HKEY SetupDiCreateDeviceInterfaceRegKeyA(void* DeviceInfoSet, SP_DEVICE_INTERFACE_DATA* DeviceInterfaceData, 
                                         uint Reserved, uint samDesired, void* InfHandle, 
                                         const(char)* InfSectionName);

///The <b>SetupDiCreateDeviceInterfaceRegKey</b> function creates a registry key for storing information about a device
///interface and returns a handle to the key.
///Params:
///    DeviceInfoSet = A handle to a device information set that contains the interface for which to create a registry key. The device
///                    information set must not contain remote elements.
///    DeviceInterfaceData = A pointer to an SP_DEVICE_INTERFACE_DATA structure that specifies the device interface in <i>DeviceInfoSet</i>.
///                          This pointer is possibly returned by SetupDiCreateDeviceInterface.
///    Reserved = Reserved. Must be zero.
///    samDesired = The registry security access that the caller requests for the key that is being created. For information about
///                 registry security access values of type REGSAM, see the Microsoft Windows SDK documentation.
///    InfHandle = The handle to an open INF file that contains a <i>DDInstall</i> section to be executed for the newly-created key.
///                This parameter is optional and can be <b>NULL</b>. If this parameter is not <b>NULL</b>, <i>InfSectionName</i>
///                must be specified as well.
///    InfSectionName = A pointer to the name of an INF <i>DDInstall</i> section in the INF file that is specified by <i>InfHandle</i>.
///                     This section is executed for the newly created key. This parameter is optional and can be <b>NULL</b>. If this
///                     parameter is specified, <i>InfHandle</i> must be specified as well.
///Returns:
///    If <b>SetupDiCreateDeviceInterfaceRegKey</b> succeeds, the function returns a handle to the requested registry
///    key in which interface information can be stored and retrieved. If <b>SetupDiCreateDeviceInterfaceRegKey</b>
///    fails, the function returns INVALID_HANDLE_VALUE. Call GetLastError to get extended error information.
///    
@DllImport("SETUPAPI")
HKEY SetupDiCreateDeviceInterfaceRegKeyW(void* DeviceInfoSet, SP_DEVICE_INTERFACE_DATA* DeviceInterfaceData, 
                                         uint Reserved, uint samDesired, void* InfHandle, 
                                         const(wchar)* InfSectionName);

///The <b>SetupDiOpenDeviceInterfaceRegKey</b> function opens the registry subkey that is used by applications and
///drivers to store information that is specific to a device interface.
///Params:
///    DeviceInfoSet = A pointer to a device information set that contains the device interface for which to open a registry subkey.
///    DeviceInterfaceData = A pointer to an SP_DEVICE_INTERFACE_DATA structure that specifies the device interface. This pointer can be
///                          returned by SetupDiCreateDeviceInterface or SetupDiEnumDeviceInterfaces.
///    Reserved = Reserved. Must be zero.
///    samDesired = The requested registry security access to the registry subkey. For information about registry security access
///                 values of type REGSAM, see the Microsoft Windows SDK documentation.
///Returns:
///    <b>SetupDiOpenDeviceInterfaceRegKey</b> returns a handle to the opened registry key. If the function fails, it
///    returns INVALID_HANDLE_VALUE. To get extended error information, call GetLastError.
///    
@DllImport("SETUPAPI")
HKEY SetupDiOpenDeviceInterfaceRegKey(void* DeviceInfoSet, SP_DEVICE_INTERFACE_DATA* DeviceInterfaceData, 
                                      uint Reserved, uint samDesired);

///The <b>SetupDiDeleteDeviceInterfaceRegKey</b> function deletes the registry subkey that is used by applications and
///drivers to store interface-specific information.
///Params:
///    DeviceInfoSet = A pointer to a device information set that contains the interface for which to delete interface-specific
///                    information in the registry. The device information set must not contain remote elements.
///    DeviceInterfaceData = A pointer to an SP_DEVICE_INTERFACE_DATA structure that specifies the device interface in <i>DeviceInfoSet</i>.
///                          This pointer is possibly returned by SetupDiCreateDeviceInterface or SetupDiEnumDeviceInterfaces.
///    Reserved = Reserved. Must be zero.
///Returns:
///    <b>SetupDiDeleteDeviceInterfaceRegKey</b> returns <b>TRUE</b> if it is successful; otherwise, it returns
///    <b>FALSE</b> and the logged error can be retrieved with a call to GetLastError.
///    
@DllImport("SETUPAPI")
BOOL SetupDiDeleteDeviceInterfaceRegKey(void* DeviceInfoSet, SP_DEVICE_INTERFACE_DATA* DeviceInterfaceData, 
                                        uint Reserved);

///The <b>SetupDiCreateDevRegKey</b> function creates a registry key for device-specific configuration information and
///returns a handle to the key.
///Params:
///    DeviceInfoSet = A handle to a device information set that contains a device information element that represents the device for
///                    which to create a registry key.
///    DeviceInfoData = A pointer to an SP_DEVINFO_DATA structure that specifies the device information element in <i>DeviceInfoSet</i>.
///    Scope = The scope of the registry key to be created. The scope determines where the information is stored. The key
///            created can be global or hardware profile-specific. Can be one of the following values:
///    HwProfile = The hardware profile for which to create a key if <i>HwProfileFlags</i> is set to SPDICS_FLAG_CONFIGSPECIFIC. If
///                <i>HwProfile</i> is 0, the key for the current hardware profile is created. If <i>HwProfileFlags</i> is
///                SPDICS_FLAG_GLOBAL, <i>HwProfile</i> is ignored.
///    KeyType = The type of registry storage key to create. Can be one of the following values:
///    InfHandle = The handle to an open INF file that contains an INF DDInstall section to be executed for the newly created key.
///                This parameter is optional and can be <b>NULL</b>. If this parameter is specified, <i>InfSectionName</i> must be
///                specified as well.
///    InfSectionName = The name of an INF <i>DDInstall</i> section in the INF file specified by <i>InfHandle</i>. This section is
///                     executed for the newly created key. This parameter is optional and can be <b>NULL</b>. If this parameter is
///                     specified, <i>InfHandle</i> must be specified as well.
///Returns:
///    If <b>SetupDiCreateDevRegKey</b> succeeds, the function returns a handle to the specified registry key in which
///    device-specific configuration data can be stored and retrieved. If <b>SetupDiCreateDevRegKey</b> fails, the
///    function returns INVALID_HANDLE_VALUE. Call GetLastError to get extended error information.
///    
@DllImport("SETUPAPI")
HKEY SetupDiCreateDevRegKeyA(void* DeviceInfoSet, SP_DEVINFO_DATA* DeviceInfoData, uint Scope, uint HwProfile, 
                             uint KeyType, void* InfHandle, const(char)* InfSectionName);

///The <b>SetupDiCreateDevRegKey</b> function creates a registry key for device-specific configuration information and
///returns a handle to the key.
///Params:
///    DeviceInfoSet = A handle to a device information set that contains a device information element that represents the device for
///                    which to create a registry key.
///    DeviceInfoData = A pointer to an SP_DEVINFO_DATA structure that specifies the device information element in <i>DeviceInfoSet</i>.
///    Scope = The scope of the registry key to be created. The scope determines where the information is stored. The key
///            created can be global or hardware profile-specific. Can be one of the following values:
///    HwProfile = The hardware profile for which to create a key if <i>HwProfileFlags</i> is set to SPDICS_FLAG_CONFIGSPECIFIC. If
///                <i>HwProfile</i> is 0, the key for the current hardware profile is created. If <i>HwProfileFlags</i> is
///                SPDICS_FLAG_GLOBAL, <i>HwProfile</i> is ignored.
///    KeyType = The type of registry storage key to create. Can be one of the following values:
///    InfHandle = The handle to an open INF file that contains an INF DDInstall section to be executed for the newly created key.
///                This parameter is optional and can be <b>NULL</b>. If this parameter is specified, <i>InfSectionName</i> must be
///                specified as well.
///    InfSectionName = The name of an INF <i>DDInstall</i> section in the INF file specified by <i>InfHandle</i>. This section is
///                     executed for the newly created key. This parameter is optional and can be <b>NULL</b>. If this parameter is
///                     specified, <i>InfHandle</i> must be specified as well.
///Returns:
///    If <b>SetupDiCreateDevRegKey</b> succeeds, the function returns a handle to the specified registry key in which
///    device-specific configuration data can be stored and retrieved. If <b>SetupDiCreateDevRegKey</b> fails, the
///    function returns INVALID_HANDLE_VALUE. Call GetLastError to get extended error information.
///    
@DllImport("SETUPAPI")
HKEY SetupDiCreateDevRegKeyW(void* DeviceInfoSet, SP_DEVINFO_DATA* DeviceInfoData, uint Scope, uint HwProfile, 
                             uint KeyType, void* InfHandle, const(wchar)* InfSectionName);

///The <b>SetupDiOpenDevRegKey</b> function opens a registry key for device-specific configuration information.
///Params:
///    DeviceInfoSet = A handle to the device information set that contains a device information element that represents the device for
///                    which to open a registry key.
///    DeviceInfoData = A pointer to an SP_DEVINFO_DATA structure that specifies the device information element in <i>DeviceInfoSet</i>.
///    Scope = The scope of the registry key to open. The scope determines where the information is stored. The scope can be
///            global or specific to a hardware profile. The scope is specified by one of the following values:
///    HwProfile = A hardware profile value, which is set as follows: <ul> <li> If <i>Scope</i> is set to DICS_FLAG_CONFIGSPECIFIC,
///                <i>HwProfile</i> specifies the hardware profile of the key that is to be opened. </li> <li> If <i>HwProfile</i>
///                is 0, the key for the current hardware profile is opened. </li> <li> If <i>Scope</i> is DICS_FLAG_GLOBAL,
///                <i>HwProfile</i> is ignored. </li> </ul>
///    KeyType = The type of registry storage key to open, which can be one of the following values:
///    samDesired = The registry security access that is required for the requested key. For information about registry security
///                 access values of type REGSAM, see the Microsoft Windows SDK documentation.
///Returns:
///    If the function is successful, it returns a handle to an opened registry key where private configuration data
///    about this device instance can be stored/retrieved. If the function fails, it returns INVALID_HANDLE_VALUE. To
///    get extended error information, call GetLastError.
///    
@DllImport("SETUPAPI")
HKEY SetupDiOpenDevRegKey(void* DeviceInfoSet, SP_DEVINFO_DATA* DeviceInfoData, uint Scope, uint HwProfile, 
                          uint KeyType, uint samDesired);

///The <b>SetupDiDeleteDevRegKey</b> function deletes specified user-accessible registry keys that are associated with a
///device information element.
///Params:
///    DeviceInfoSet = A handle to the device information set that contains a device information element that represents the device for
///                    which to delete registry keys. The device information set must not contain remote elements.
///    DeviceInfoData = A pointer to an SP_DEVINFO_DATA structure that specifies the device information element in <i>DeviceInfoSet</i>.
///    Scope = The scope of the registry key to delete. The scope indicates where the information is located. The key can be
///            global or hardware profile-specific. Can be one of the following values:
///    HwProfile = If <i>Scope</i> is set to DICS_FLAG_CONFIGSPECIFIC, the <i>HwProfile</i> parameter specifies the hardware profile
///                for which to delete the registry key. If <i>HwProfile</i> is 0, the key for the current hardware profile is
///                deleted. If <i>HwProfile</i> is 0xFFFFFFFF, the registry key for all hardware profiles is deleted.
///    KeyType = The type of registry storage key to delete. Can be one of the following values:
///Returns:
///    The function returns <b>TRUE</b> if it is successful. Otherwise, it returns <b>FALSE</b> and the logged error can
///    be retrieved with a call to GetLastError.
///    
@DllImport("SETUPAPI")
BOOL SetupDiDeleteDevRegKey(void* DeviceInfoSet, SP_DEVINFO_DATA* DeviceInfoData, uint Scope, uint HwProfile, 
                            uint KeyType);

///The <b>SetupDiGetHwProfileList</b> function retrieves a list of all currently defined hardware profile IDs.
///Params:
///    HwProfileList = A pointer to an array to receive the list of currently defined hardware profile IDs.
///    HwProfileListSize = The number of DWORDs in the <i>HwProfileList</i> buffer.
///    RequiredSize = A pointer to a variable of type DWORD that receives the number of hardware profiles currently defined. If the
///                   number is larger than <i>HwProfileListSize</i>, the list is truncated to fit the array size. The value returned
///                   in <i>RequiredSize</i> indicates the array size required to store the entire list of hardware profiles. In this
///                   case, the function fails and a call to GetLastError returns ERROR_INSUFFICIENT_BUFFER.
///    CurrentlyActiveIndex = A pointer to a variable of type DWORD that receives the index of the currently active hardware profile in the
///                           retrieved hardware profile list. This parameter is optional and can be <b>NULL</b>.
///Returns:
///    The function returns <b>TRUE</b> if it is successful. Otherwise, it returns <b>FALSE</b> and the logged error can
///    be retrieved by making a call to GetLastError.
///    
@DllImport("SETUPAPI")
BOOL SetupDiGetHwProfileList(char* HwProfileList, uint HwProfileListSize, uint* RequiredSize, 
                             uint* CurrentlyActiveIndex);

///The <b>SetupDiGetHwProfileListEx</b> function retrieves a list of all currently defined hardware profile IDs on a
///local or remote computer.
///Params:
///    HwProfileList = A pointer to an array to receive the list of currently defined hardware profile IDs.
///    HwProfileListSize = The number of DWORDs in the <i>HwProfileList</i> buffer.
///    RequiredSize = A pointer to a variable of type DWORD that receives the number of hardware profiles that are currently defined.
///                   If the number is larger than <i>HwProfileListSize</i>, the list is truncated to fit the array size. The value
///                   returned in <i>RequiredSize</i> indicates the array size required to store the entire list of hardware profiles.
///    CurrentlyActiveIndex = A pointer to a variable that receives the index of the currently active hardware profile in the retrieved
///                           hardware profile list. This parameter is optional and can be <b>NULL</b>.
///    MachineName = A pointer to a NULL-terminated string that contains the name of a remote system for which to retrieve the list of
///                  hardware profile IDs. This parameter is optional and can be <b>NULL</b>. If this parameter is <b>NULL</b>, the
///                  list is retrieved for the local system.
///    Reserved = Must be <b>NULL</b>.
///Returns:
///    The function returns <b>TRUE</b> if it is successful. Otherwise, it returns <b>FALSE</b> and the logged error can
///    be retrieved by making a call to GetLastError. If the required size is larger than <i>HwProfileListSize</i>,
///    <b>SetupDiGetHwProfileListEx</b> returns <b>FALSE</b> and a call to GetLastError returns
///    ERROR_INSUFFICIENT_BUFFER.
///    
@DllImport("SETUPAPI")
BOOL SetupDiGetHwProfileListExA(char* HwProfileList, uint HwProfileListSize, uint* RequiredSize, 
                                uint* CurrentlyActiveIndex, const(char)* MachineName, void* Reserved);

///The <b>SetupDiGetHwProfileListEx</b> function retrieves a list of all currently defined hardware profile IDs on a
///local or remote computer.
///Params:
///    HwProfileList = A pointer to an array to receive the list of currently defined hardware profile IDs.
///    HwProfileListSize = The number of DWORDs in the <i>HwProfileList</i> buffer.
///    RequiredSize = A pointer to a variable of type DWORD that receives the number of hardware profiles that are currently defined.
///                   If the number is larger than <i>HwProfileListSize</i>, the list is truncated to fit the array size. The value
///                   returned in <i>RequiredSize</i> indicates the array size required to store the entire list of hardware profiles.
///    CurrentlyActiveIndex = A pointer to a variable that receives the index of the currently active hardware profile in the retrieved
///                           hardware profile list. This parameter is optional and can be <b>NULL</b>.
///    MachineName = A pointer to a NULL-terminated string that contains the name of a remote system for which to retrieve the list of
///                  hardware profile IDs. This parameter is optional and can be <b>NULL</b>. If this parameter is <b>NULL</b>, the
///                  list is retrieved for the local system.
///    Reserved = Must be <b>NULL</b>.
///Returns:
///    The function returns <b>TRUE</b> if it is successful. Otherwise, it returns <b>FALSE</b> and the logged error can
///    be retrieved by making a call to GetLastError. If the required size is larger than <i>HwProfileListSize</i>,
///    <b>SetupDiGetHwProfileListEx</b> returns <b>FALSE</b> and a call to GetLastError returns
///    ERROR_INSUFFICIENT_BUFFER.
///    
@DllImport("SETUPAPI")
BOOL SetupDiGetHwProfileListExW(char* HwProfileList, uint HwProfileListSize, uint* RequiredSize, 
                                uint* CurrentlyActiveIndex, const(wchar)* MachineName, void* Reserved);

///The <b>SetupDiGetDevicePropertyKeys</b> function retrieves an array of the device property keys that represent the
///device properties that are set for a device instance.
///Params:
///    DeviceInfoSet = A handle to a device information set. This device information set contains the device instance for which this
///                    function retrieves an array of device property keys. The property keys represent the device properties that are
///                    set for the device instance.
///    DeviceInfoData = A pointer to an SP_DEVINFO_DATA structure that represents the device instance for which to retrieve the requested
///                     array of device property keys.
///    PropertyKeyArray = A pointer to a buffer that receives an array of DEVPROPKEY-typed values, where each value is a device property
///                       key that represents a device property that is set for the device instance. The pointer is optional and can be
///                       <b>NULL</b>. For more information, see the <b>Remarks</b> section later in this topic.
///    PropertyKeyCount = The size, in DEVPROPKEY-typed values, of the <i>PropertyKeyArray </i>buffer<i>. </i>If <i>PropertyKeyArray</i> is
///                       set to <b>NULL</b>, <i>PropertyKeyCount</i> must be set to zero.
///    RequiredPropertyKeyCount = A pointer to a DWORD-typed variable that receives the number of requested device property keys. The pointer is
///                               optional and can be set to <b>NULL</b>.
///    Flags = This parameter must be set to zero.
///Returns:
///    <b>SetupDiGetDevicePropertyKeys</b> returns <b>TRUE</b> if it is successful. Otherwise, it returns <b>FALSE</b>,
///    and the logged error can be retrieved by calling GetLastError. The following table includes some of the more
///    common error codes that this function might log. <table> <tr> <th>Return code</th> <th>Description</th> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_FLAGS</b></dt> </dl> </td> <td width="60%"> The value of<i>
///    Flags</i> is not zero. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_HANDLE</b></dt> </dl> </td>
///    <td width="60%"> The device information set that is specified by <i>DevInfoSet</i> is not valid. </td> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> A supplied parameter
///    is not valid. One possibility is that the device information element is not valid. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_INVALID_DATA</b></dt> </dl> </td> <td width="60%"> An internal data value is not
///    valid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_USER_BUFFER</b></dt> </dl> </td> <td
///    width="60%"> A user buffer is not valid. One possibility is that <i>PropertyKeyArray</i> is <b>NULL</b> and
///    <i>PropertKeyCount</i> is not zero. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NO_SUCH_DEVINST</b></dt>
///    </dl> </td> <td width="60%"> The device instance that is specified by <i>DevInfoData</i> does not exist. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INSUFFICIENT_BUFFER</b></dt> </dl> </td> <td width="60%"> The
///    <i>PropertyKeyArray</i> buffer is too small to hold all the requested property keys. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_NOT_ENOUGH_MEMORY</b></dt> </dl> </td> <td width="60%"> There was not enough
///    system memory available to complete the operation. </td> </tr> </table>
///    
@DllImport("SETUPAPI")
BOOL SetupDiGetDevicePropertyKeys(void* DeviceInfoSet, SP_DEVINFO_DATA* DeviceInfoData, char* PropertyKeyArray, 
                                  uint PropertyKeyCount, uint* RequiredPropertyKeyCount, uint Flags);

///The <b>SetupDiGetDeviceProperty</b> function retrieves a device instance property.
///Params:
///    DeviceInfoSet = A handle to a device information set that contains a device instance for which to retrieve a device instance
///                    property.
///    DeviceInfoData = A pointer to the SP_DEVINFO_DATA structure that represents the device instance for which to retrieve a device
///                     instance property.
///    PropertyKey = A pointer to a DEVPROPKEY structure that represents the device property key of the requested device instance
///                  property.
///    PropertyType = A pointer to a DEVPROPTYPE-typed variable that receives the property-data-type identifier of the requested device
///                   instance property, where the property-data-type identifier is the bitwise OR between a base-data-type identifier
///                   and, if the base-data type is modified, a property-data-type modifier.
///    PropertyBuffer = A pointer to a buffer that receives the requested device instance property. <b>SetupDiGetDeviceProperty</b>
///                     retrieves the requested property only if the buffer is large enough to hold all the property value data. The
///                     pointer can be <b>NULL</b>. If the pointer is set to <b>NULL</b> and <i>RequiredSize</i> is supplied,
///                     <b>SetupDiGetDeviceProperty</b> returns the size of the property, in bytes, in *<i>RequiredSize</i>.
///    PropertyBufferSize = The size, in bytes, of the <i>PropertyBuffer</i> buffer. If <i>PropertyBuffer</i> is set to <b>NULL</b>,
///                         <i>PropertyBufferSize</i> must be set to zero.
///    RequiredSize = A pointer to a DWORD-typed variable that receives the size, in bytes, of either the device instance property if
///                   the property is retrieved or the required buffer size if the buffer is not large enough. This pointer can be set
///                   to <b>NULL</b>.
///    Flags = This parameter must be set to zero.
///Returns:
///    <b>SetupDiGetDeviceProperty</b> returns <b>TRUE</b> if it is successful. Otherwise, it returns <b>FALSE</b>, and
///    the logged error can be retrieved by calling GetLastError. The following table includes some of the more common
///    error codes that this function might log. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_INVALID_FLAGS</b></dt> </dl> </td> <td width="60%"> The value of<i> Flags</i> is
///    not zero. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_HANDLE</b></dt> </dl> </td> <td
///    width="60%"> The device information set that is specified by <i>DevInfoSet</i> is not valid. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> A supplied parameter is
///    not valid. One possibility is that the device information element is not valid. </td> </tr> <tr> <td width="40%">
///    <dl> <dt><b>ERROR_INVALID_REG_PROPERTY</b></dt> </dl> </td> <td width="60%"> The property key that is supplied by
///    <i>PropertyKey</i> is not valid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_DATA</b></dt> </dl>
///    </td> <td width="60%"> An unspecified internal data value was not valid. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_USER_BUFFER</b></dt> </dl> </td> <td width="60%"> A user buffer is not valid. One
///    possibility is that <i>PropertyBuffer</i> is <b>NULL</b> and <i>PropertBufferSize</i> is not zero. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>ERROR_NO_SUCH_DEVINST</b></dt> </dl> </td> <td width="60%"> The device instance
///    that is specified by <i>DevInfoData</i> does not exist. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INSUFFICIENT_BUFFER</b></dt> </dl> </td> <td width="60%"> The <i>PropertyBuffer</i> buffer is too
///    small to hold the requested property value, or an internal data buffer that was passed to a system call was too
///    small. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NOT_ENOUGH_MEMORY</b></dt> </dl> </td> <td
///    width="60%"> There was not enough system memory available to complete the operation. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_NOT_FOUND</b></dt> </dl> </td> <td width="60%"> The requested device property does
///    not exist. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td
///    width="60%"> The caller does not have Administrator privileges. </td> </tr> </table>
///    
@DllImport("SETUPAPI")
BOOL SetupDiGetDevicePropertyW(void* DeviceInfoSet, SP_DEVINFO_DATA* DeviceInfoData, 
                               const(DEVPROPKEY)* PropertyKey, uint* PropertyType, char* PropertyBuffer, 
                               uint PropertyBufferSize, uint* RequiredSize, uint Flags);

///The <b>SetupDiSetDeviceProperty</b> function sets a device instance property.
///Params:
///    DeviceInfoSet = A handle to a device information set. This device information set contains a device information element that
///                    represents the device instance for which to set a device instance property.
///    DeviceInfoData = A pointer to the SP_DEVINFO_DATA structure that identifies the device instance for which to set a device instance
///                     property.
///    PropertyKey = A pointer to a DEVPROPKEY structure that represents the device property key of the device instance property to
///                  set.
///    PropertyType = A DEVPROPTYPE-typed value that represents the property-data-type identifier for the device instance property. For
///                   more information, see the <b>Remarks</b> section later in this topic.
///    PropertyBuffer = A pointer to a buffer that contains the device instance property value. If the property is being deleted or set
///                     to a <b>NULL</b> value, this pointer must be <b>NULL</b>, and <i>PropertyBufferSize</i> must be set to zero.
///    PropertyBufferSize = The size, in bytes, of the <i>PropertyBuffer</i> buffer. If <i>PropertyBuffer </i>is <b>NULL</b>,
///                         <i>PropertyBufferSize</i> must be set to zero.
///    Flags = This parameter must be set to zero.
///Returns:
///    The function returns <b>TRUE</b> if it is successful. Otherwise, it returns <b>FALSE</b>, and the logged error
///    can be retrieved by calling GetLastError. The following table includes some of the more common error codes that
///    this function might log. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_FLAGS</b></dt> </dl> </td> <td width="60%"> The value of<i> Flags</i> is not zero. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_HANDLE</b></dt> </dl> </td> <td width="60%"> The device
///    information set that is specified by <i>DevInfoSet</i> is not valid. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> A supplied parameter is not valid. One
///    possibility is that the device information element is not valid. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_REG_PROPERTY</b></dt> </dl> </td> <td width="60%"> The property key that is supplied by
///    <i>PropertyKey</i> is not valid or the property is not writable. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_DATA</b></dt> </dl> </td> <td width="60%"> The property-data-type identifier that is
///    supplied by <i>PropertyType</i>, or the property value that is supplied by <i>PropertyBuffer,</i> is not valid.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_USER_BUFFER</b></dt> </dl> </td> <td width="60%"> A
///    user buffer is not valid. One possibility is that <i>PropertyBuffer</i> is <b>NULL</b>, and
///    <i>PropertyBufferSize</i> is not zero. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_NO_SUCH_DEVINST</b></dt> </dl> </td> <td width="60%"> The device instance that is specified by
///    <i>DevInfoData</i> does not exist. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INSUFFICIENT_BUFFER</b></dt> </dl> </td> <td width="60%"> An internal data buffer that was passed to
///    a system call was too small. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NOT_ENOUGH_MEMORY</b></dt> </dl>
///    </td> <td width="60%"> There was not enough system memory available to complete the operation. </td> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>ERROR_NOT_FOUND</b></dt> </dl> </td> <td width="60%"> An unspecified internal
///    element was not found. One possibility is that the property to be deleted does not exist. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> The caller does not have
///    Administrator privileges. </td> </tr> </table>
///    
@DllImport("SETUPAPI")
BOOL SetupDiSetDevicePropertyW(void* DeviceInfoSet, SP_DEVINFO_DATA* DeviceInfoData, 
                               const(DEVPROPKEY)* PropertyKey, uint PropertyType, char* PropertyBuffer, 
                               uint PropertyBufferSize, uint Flags);

///The <b>SetupDiGetDeviceInterfacePropertyKeys</b> function retrieves an array of device property keys that represent
///the device properties that are set for a device interface.
///Params:
///    DeviceInfoSet = A handle to a device information set. This device information set contains a device interface for which to
///                    retrieve an array of the device property keys that represent the device properties that are set for a device
///                    interface.
///    DeviceInterfaceData = A pointer to an SP_DEVICE_INTERFACE_DATA structure that represents the device interface for which to retrieve the
///                          requested array of device property keys.
///    PropertyKeyArray = A pointer to a buffer that receives an array of DEVPROPKEY-typed values, where each value is a device property
///                       key for a device property that is set for the device interface. The pointer is optional and can be <b>NULL</b>.
///                       For more information, see the <b>Remarks</b> section later in this topic.
///    PropertyKeyCount = The size, in DEVPROPKEY-typed elements, of the <i>PropertyKeyArray </i>buffer<i>. </i>If <i>PropertyKeyArray</i>
///                       is <b>NULL</b>, <i>PropertyKeyCount</i> must be set to zero.
///    RequiredPropertyKeyCount = A pointer to a DWORD-typed variable that receives the number of requested device property keys. The pointer is
///                               optional and can be set to <b>NULL</b>.
///    Flags = This parameter must be set to zero.
///Returns:
///    The function returns <b>TRUE</b> if it is successful. Otherwise, it returns <b>FALSE</b>, and the logged error
///    can be retrieved by calling GetLastError. The following table includes some of the more common error codes that
///    this function might log. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_FLAGS</b></dt> </dl> </td> <td width="60%"> The value of<i> Flags</i> is not zero. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_HANDLE</b></dt> </dl> </td> <td width="60%"> The device
///    information set that is specified by <i>DevInfoSet</i> is not valid. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_DATA</b></dt> </dl> </td> <td width="60%"> An internal data value is not valid. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> A parameter is
///    not valid. One possibility is that the device interface that is specified by <i>DevInterfaceData</i> is not
///    valid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_USER_BUFFER</b></dt> </dl> </td> <td
///    width="60%"> A user buffer is not valid. One possibility is that <i>PropertyKeyArray</i> is <b>NULL</b>, and
///    <i>PropertKeyCount</i> is not zero. . </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_NO_SUCH_DEVICE_INTERFACE</b></dt> </dl> </td> <td width="60%"> The device interface that is
///    specified by <i>DeviceInterfaceData</i> does not exist. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INSUFFICIENT_BUFFER</b></dt> </dl> </td> <td width="60%"> The <i>PropertyKeyArray</i> buffer is not
///    large enough to hold all the requested property keys. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_NOT_ENOUGH_MEMORY</b></dt> </dl> </td> <td width="60%"> There was not enough system memory available
///    to complete the operation. </td> </tr> </table>
///    
@DllImport("SETUPAPI")
BOOL SetupDiGetDeviceInterfacePropertyKeys(void* DeviceInfoSet, SP_DEVICE_INTERFACE_DATA* DeviceInterfaceData, 
                                           char* PropertyKeyArray, uint PropertyKeyCount, 
                                           uint* RequiredPropertyKeyCount, uint Flags);

///The <b>SetupDiGetDeviceInterfaceProperty</b> function retrieves a device property that is set for a device interface.
///Params:
///    DeviceInfoSet = A handle to a device information set that contains a device interface for which to retrieve a device interface
///                    property.
///    DeviceInterfaceData = A pointer to an SP_DEVICE_INTERFACE_DATA structure that represents the device interface for which to retrieve a
///                          device interface property.
///    PropertyKey = A pointer to a DEVPROPKEY structure that represents the device interface property key of the device interface
///                  property to retrieve.
///    PropertyType = A pointer to a DEVPROPTYPE-typed variable that receives the property-data-type identifier of the requested device
///                   interface property. The property-data-type identifier is a bitwise OR between a base-data-type identifier and, if
///                   the base-data type is modified, a property-data-type modifier.
///    PropertyBuffer = A pointer to a buffer that receives the requested device interface property.
///                     <b>SetupDiGetDeviceInterfaceProperty</b> retrieves the requested property only if the buffer is large enough to
///                     hold all the property value data. The pointer can be <b>NULL</b>. If the pointer is set to <b>NULL</b> and
///                     <i>RequiredSize</i> is supplied, <b>SetupDiGetDeviceInterfaceProperty</b> returns the size of the property, in
///                     bytes, in *<i>RequiredSize</i>.
///    PropertyBufferSize = The size, in bytes, of the <i>PropertyBuffer</i> buffer. If <i>PropertyBuffer</i> is set to <b>NULL</b>,
///                         <i>PropertyBufferSize</i> must be set to zero.
///    RequiredSize = A pointer to a DWORD-typed variable that receives the size, in bytes, of either the device interface property if
///                   the property is retrieved or the required buffer size, if the buffer is not large enough. This pointer can be set
///                   to <b>NULL</b>.
///    Flags = This parameter must be set to zero.
///Returns:
///    <b>SetupDiGetDeviceInterfaceProperty</b> returns <b>TRUE</b> if it is successful. Otherwise, it returns
///    <b>FALSE</b>, and the logged error can be retrieved by calling GetLastError. The following table includes some of
///    the more common error codes that this function might log. Other error codes can be set by the device installer
///    functions that are called by this API. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_INVALID_FLAGS</b></dt> </dl> </td> <td width="60%"> The value of<i> Flags</i> is
///    not zero. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_HANDLE</b></dt> </dl> </td> <td
///    width="60%"> The device information set that is specified by <i>DevInfoSet</i> is not valid. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> A supplied parameter is
///    not valid. One possibility is that the device interface that is specified by <i>DeviceInterfaceData</i> is not
///    valid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_REG_PROPERTY</b></dt> </dl> </td> <td
///    width="60%"> The property key that is supplied by <i>PropertyKey</i> is not valid. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_INVALID_DATA</b></dt> </dl> </td> <td width="60%"> An unspecified internal data
///    value was not valid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_USER_BUFFER</b></dt> </dl> </td>
///    <td width="60%"> A user buffer is not valid. One possibility is that <i>PropertyBuffer</i> is <b>NULL</b>, and
///    <i>PropertyBufferSize</i> is not zero. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_NO_SUCH_DEVICE_INTERFACE</b></dt> </dl> </td> <td width="60%"> The device interface that is
///    specified by <i>DeviceInterfaceData</i> does not exist. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INSUFFICIENT_BUFFER</b></dt> </dl> </td> <td width="60%"> The <i>PropertyBuffer</i> buffer is not
///    large enough to hold the property value, or an internal data buffer that was passed to a system call was too
///    small. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NOT_ENOUGH_MEMORY</b></dt> </dl> </td> <td
///    width="60%"> There was not enough system memory available to complete the operation. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_NOT_FOUND</b></dt> </dl> </td> <td width="60%"> The requested device property does
///    not exist. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td
///    width="60%"> The caller does not have Administrator privileges. </td> </tr> </table>
///    
@DllImport("SETUPAPI")
BOOL SetupDiGetDeviceInterfacePropertyW(void* DeviceInfoSet, SP_DEVICE_INTERFACE_DATA* DeviceInterfaceData, 
                                        const(DEVPROPKEY)* PropertyKey, uint* PropertyType, char* PropertyBuffer, 
                                        uint PropertyBufferSize, uint* RequiredSize, uint Flags);

///The <b>SetupDiSetDeviceInterfaceProperty</b> function sets a device property of a device interface.
///Params:
///    DeviceInfoSet = A handle to a device information set that contains the device interface for which to set a device interface
///                    property.
///    DeviceInterfaceData = A pointer to an SP_DEVICE_INTERFACE_DATA structure that represents the device interface for which to set a device
///                          interface property.
///    PropertyKey = A pointer to a DEVPROPKEY structure that represents the device property key of the device interface property to
///                  set.
///    PropertyType = A DEVPROPTYPE-typed value that represents the property-data-type identifier of the device interface property to
///                   set. For more information about the property-data-type identifier, see the <b>Remarks</b> section later in this
///                   topic.
///    PropertyBuffer = A pointer to a buffer that contains the device interface property value. If either the property or the interface
///                     value is being deleted, this pointer must be set to <b>NULL</b>, and <i>PropertyBufferSize</i> must be set to
///                     zero. For more information about property value data, see the <b>Remarks</b> section later in this topic.
///    PropertyBufferSize = The size, in bytes, of the <i>PropertyBuffer</i> buffer. The property buffer size must be consistent with the
///                         property-data-type identifier that is supplied by <i>PropertyType</i>. If <i>PropertyBuffer </i>is set to
///                         <b>NULL</b>, <i>PropertyBufferSize</i> must be set to zero.
///    Flags = Must be set to zero.
///Returns:
///    <b>SetupDiSetDeviceInterfaceProperty</b> returns <b>TRUE</b> if it is successful. Otherwise, this function
///    returns <b>FALSE</b>, and the logged error can be retrieved by calling GetLastError. The following table includes
///    some of the more common error codes that this function might log. <table> <tr> <th>Return code</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_FLAGS</b></dt> </dl> </td> <td
///    width="60%"> The value of<i> Flags</i> is not zero. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_HANDLE</b></dt> </dl> </td> <td width="60%"> The device information set that is specified by
///    <i>DevInfoSet</i> is not valid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt>
///    </dl> </td> <td width="60%"> A supplied parameter is not valid. One possibility is that the device interface
///    specified by <i>DeviceInterfaceData</i> is not valid. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_REG_PROPERTY</b></dt> </dl> </td> <td width="60%"> The property key that is supplied by
///    <i>PropertyKey</i> is not valid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_DATA</b></dt> </dl>
///    </td> <td width="60%"> An unspecified data value was not valid. This error could be logged if either the symbolic
///    link name of the device interface is not valid or the property-data-type identifier is not valid. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_USER_BUFFER</b></dt> </dl> </td> <td width="60%"> A user buffer
///    is not valid. One possibility is that <i>PropertyBuffer</i> is <b>NULL</b>, and <i>PropertBufferSize</i> is not
///    zero. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NO_SUCH_DEVICE_INTERFACE</b></dt> </dl> </td> <td
///    width="60%"> The device interface that is specified by <i>DeviceInterfaceData</i> does not exist. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>ERROR_INSUFFICIENT_BUFFER</b></dt> </dl> </td> <td width="60%"> An internal
///    data buffer that was passed to a system call was too small. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_NOT_ENOUGH_MEMORY</b></dt> </dl> </td> <td width="60%"> There was not enough system memory available
///    to complete the operation. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NOT_FOUND</b></dt> </dl> </td> <td
///    width="60%"> An unspecified internal element was not found. One possibility is that a property to be deleted does
///    not exist. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td
///    width="60%"> The caller does not have Administrator privileges. </td> </tr> </table>
///    
@DllImport("SETUPAPI")
BOOL SetupDiSetDeviceInterfacePropertyW(void* DeviceInfoSet, SP_DEVICE_INTERFACE_DATA* DeviceInterfaceData, 
                                        const(DEVPROPKEY)* PropertyKey, uint PropertyType, char* PropertyBuffer, 
                                        uint PropertyBufferSize, uint Flags);

///The <b>SetupDiGetClassPropertyKeys</b> function retrieves an array of the device property keys that represent the
///device properties that are set for a device setup class or a device interface class.
///Params:
///    ClassGuid = A pointer to a GUID that represents a device setup class or a device interface class.
///                <b>SetupDiGetClassPropertyKeys</b> retrieves an array of the device property keys that represent device
///                properties that are set for the specified class. For information about specifying the class type, see the
///                <i>Flags</i> parameter.
///    PropertyKeyArray = A pointer to a buffer that receives an array of DEVPROPKEY-typed values, where each value is a device property
///                       key that represents a device property that is set for the device class. The pointer is optional and can be
///                       <b>NULL</b>. For more information, see the <b>Remarks</b> section later in this topic.
///    PropertyKeyCount = The size, in DEVPROPKEY-typed values, of the <i>PropertyKeyArray</i> buffer. If <i>PropertyKeyArray</i> is set to
///                       <b>NULL</b>, <i>PropertyKeyCount</i> must be set to zero.
///    RequiredPropertyKeyCount = A pointer to a DWORD-typed variable that receives the number of requested property keys. The parameter is
///                               optional and can be set to <b>NULL</b>.
///    Flags = One of the following values, which specifies whether to retrieve property keys for a device setup class or for a
///            device interface class:
///Returns:
///    <b>SetupDiGetClassPropertyKeys</b> returns <b>TRUE</b> if it is successful. Otherwise, it returns <b>FALSE</b>,
///    and the logged error can be retrieved by calling GetLastError. The following table includes some of the more
///    common error codes that this function might log. <table> <tr> <th>Return code</th> <th>Description</th> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_FLAGS</b></dt> </dl> </td> <td width="60%"> The value of<i>
///    Flags</i> is not valid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_CLASS</b></dt> </dl> </td>
///    <td width="60%"> If the DICLASSPROP_INSTALLER flag is specified, this error code indicates that the device setup
///    class that is specified by <i>ClassGuid</i> does not exist. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_REFERENCE_STRING</b></dt> </dl> </td> <td width="60%"> The reference string for the device
///    interface that is specified by <i>ClassGuild</i> is not valid. This error can be returned if the
///    DICLASSPROP_INTERFACE flag is specified. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_DATA</b></dt> </dl> </td> <td width="60%"> An unspecified data value is not valid. One
///    possibility is that the <i>ClassGuid</i> value is not valid. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> An unspecified parameter is not valid. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_USER_BUFFER</b></dt> </dl> </td> <td width="60%"> A user
///    buffer is not valid. One possibility is that <i>PropertyKeyArray</i> is <b>NULL</b>, and <i>PropertKeyCount</i>
///    is not zero. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NO_SUCH_INTERFACE_CLASS</b></dt> </dl> </td> <td
///    width="60%"> If the DICLASSPROP_INTERFACE flag is specified, this error code indicates that the device interface
///    class that is specified by <i>ClassGuid</i> does not exist. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INSUFFICENT_BUFFER</b></dt> </dl> </td> <td width="60%"> The <i>PropertyKeyArray</i> buffer is not
///    large enough to hold all the property keys, or an internal data buffer that was passed to a system call was too
///    small. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NOT_ENOUGH_MEMORY</b></dt> </dl> </td> <td
///    width="60%"> There was not enough system memory available to complete the operation. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> The caller does not have
///    Administrator privileges. </td> </tr> </table>
///    
@DllImport("SETUPAPI")
BOOL SetupDiGetClassPropertyKeys(const(GUID)* ClassGuid, char* PropertyKeyArray, uint PropertyKeyCount, 
                                 uint* RequiredPropertyKeyCount, uint Flags);

///The <b>SetupDiGetClassPropertyKeysEx</b> function retrieves an array of the device property keys that represent the
///device properties that are set for a device setup class or a device interface class on a local or a remote computer.
///Params:
///    ClassGuid = A pointer to a GUID that represents a device setup class or a device interface class.
///                <b>SetupDiGetClassPropertyKeysEx</b> retrieves an array of the device property keys that represent device
///                properties that are set for the specified class. For information about specifying the class type, see the
///                <i>Flags</i> parameter.
///    PropertyKeyArray = A pointer to a buffer that receives an array of DEVPROPKEY-typed values, where each value is a device property
///                       key that represents a device property that is set for the device setup class. The pointer is optional and can be
///                       <b>NULL</b>. For more information, see the <b>Remarks</b> section later in this topic.
///    PropertyKeyCount = The size, in DEVPROPKEY-type values, of the <i>PropertyKeyArray</i> buffer. If <i>PropertyKeyArray</i> is set to
///                       <b>NULL</b>, <i>PropertyKeyCount</i> must be set to zero.
///    RequiredPropertyKeyCount = A pointer to a DWORD-typed variable that receives the number of requested property keys. The pointer is optional
///                               and can be set to <b>NULL</b>.
///    Flags = One of the following values, which specifies whether to retrieve class property keys for a device setup class or
///            for a device interface class.
///    MachineName = A pointer to a NULL-terminated string that contains the UNC name, including the "\\" prefix, of a computer. The
///                  pointer can be <b>NULL</b>. If the pointer is <b>NULL</b>, <b>SetupDiGetClassPropertyKeysEx</b> retrieves the
///                  requested information from the local computer.
///    Reserved = This parameter must be set to <b>NULL</b>.
///Returns:
///    <b>SetupDiGetClassPropertyKeysEx</b> returns <b>TRUE</b> if it is successful. Otherwise, it returns <b>FALSE</b>,
///    and the logged error can be retrieved by calling GetLastError. The following table includes some of the more
///    common error codes that this function might log. <table> <tr> <th>Return code</th> <th>Description</th> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_FLAGS</b></dt> </dl> </td> <td width="60%"> The value of<i>
///    Flags</i> is not valid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_CLASS</b></dt> </dl> </td>
///    <td width="60%"> If the DICLASSPROP_INSTALLER flag is specified, this error code indicates that the device setup
///    class that is specified by <i>ClassGuid</i> does not exist. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_REFERENCE_STRING</b></dt> </dl> </td> <td width="60%"> The reference string for the device
///    interface that is specified by <i>ClassGuild</i> is not valid. This error might be returned when the
///    DICLASSPROP_INTERFACE flag is specified. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_DATA</b></dt> </dl> </td> <td width="60%"> An unspecified data value is not valid. One
///    possibility is that the <i>ClassGuid</i> value is not valid. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> An unspecified parameter is not valid. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_USER_BUFFER</b></dt> </dl> </td> <td width="60%"> A user
///    buffer is not valid. One possibility is that <i>PropertyKeyArray</i> is <b>NULL</b>, and <i>PropertKeyCount</i>
///    is not zero. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_MACHINENAME</b></dt> </dl> </td> <td
///    width="60%"> The computer name that is specified by <i>MachineName</i> is not valid. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_NO_SUCH_INTERFACE_CLASS</b></dt> </dl> </td> <td width="60%"> If the
///    DICLASSPROP_INTERFACE flag is specified, this error code indicates that the device interface class that is
///    specified by <i>ClassGuid</i> does not exist. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INSUFFICENT_BUFFER</b></dt> </dl> </td> <td width="60%"> The <i>PropertyKeyArray</i> buffer is not
///    large enough to hold all the property keys, or an internal data buffer that was passed to a system call was too
///    small. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NOT_ENOUGH_MEMORY</b></dt> </dl> </td> <td
///    width="60%"> There was not enough system memory available to complete the operation. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> The caller does not have
///    Administrator privileges. </td> </tr> </table>
///    
@DllImport("SETUPAPI")
BOOL SetupDiGetClassPropertyKeysExW(const(GUID)* ClassGuid, char* PropertyKeyArray, uint PropertyKeyCount, 
                                    uint* RequiredPropertyKeyCount, uint Flags, const(wchar)* MachineName, 
                                    void* Reserved);

///The <b>SetupDiGetClassProperty</b> function retrieves a device property that is set for a device setup class or a
///device interface class.
///Params:
///    ClassGuid = A pointer to a GUID that identifies the device setup class or device interface class for which to retrieve a
///                device property that is set for the device class. For information about specifying the class type, see the
///                <i>Flags</i> parameter.
///    PropertyKey = A pointer to a DEVPROPKEY structure that represents the device property key of the requested device class
///                  property.
///    PropertyType = A pointer to a DEVPROPTYPE-typed variable that receives the property-data-type identifier of the requested device
///                   class property, where the property-data-type identifier is the bitwise OR between a base-data-type identifier
///                   and, if the base data type is modified, a property-data-type modifier.
///    PropertyBuffer = A pointer to a buffer that receives the requested device class property. <b>SetupDiGetClassProperty</b> retrieves
///                     the requested property value only if the buffer is large enough to hold all the property value data. The pointer
///                     can be <b>NULL</b>. If the pointer is set to <b>NULL</b> and <i>RequiredSize</i> is supplied,
///                     <b>SetupDiGetClassProperty</b> returns the size of the device class property, in bytes, in *<i>RequiredSize</i>.
///    PropertyBufferSize = The size, in bytes, of the <i>PropertyBuffer</i> buffer. If <i>PropertyBuffer</i> is set to <b>NULL</b>,
///                         <i>PropertyBufferSize</i> must be set to zero.
///    RequiredSize = A pointer to a DWORD-typed variable that receives either the size, in bytes, of the device class property if the
///                   device class property is retrieved or the required buffer size if the buffer is not large enough. This pointer
///                   can be set to <b>NULL</b>.
///    Flags = One of the following values, which specifies whether the class is a device setup class or a device interface
///            class.
///Returns:
///    <b>SetupDiGetClassProperty</b> returns <b>TRUE</b> if it is successful. Otherwise, it returns <b>FALSE</b>, and
///    the logged error can be retrieved by calling GetLastError. The following table includes some of the more common
///    error codes that this function might log. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_INVALID_FLAGS</b></dt> </dl> </td> <td width="60%"> The value of<i> Flags</i> is
///    not zero. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_CLASS</b></dt> </dl> </td> <td width="60%">
///    The device setup class that is specified by <i>ClassGuid</i> is not valid. This error can occur only if the
///    DICLASSPROP_INSTALLER flag is specified. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> An unspecified parameter is not valid. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_REG_PROPERTY</b></dt> </dl> </td> <td width="60%"> The
///    property key that is supplied by <i>PropertyKey</i> is not valid. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_REFERENCE_STRING</b></dt> </dl> </td> <td width="60%"> The device interface reference string
///    is not valid. This error can be returned if the DICLASSPROP_INTERFACE flag is specified. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_INVALID_DATA</b></dt> </dl> </td> <td width="60%"> An unspecified internal data
///    value was not valid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_USER_BUFFER</b></dt> </dl> </td>
///    <td width="60%"> A user buffer is not valid. One possibility is that <i>PropertyBuffer</i> is <b>NULL</b>, and
///    <i>PropertyBufferSize</i> is not zero. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_NO_SUCH_INTERFACE_CLASS</b></dt> </dl> </td> <td width="60%"> The device interface class that is
///    specified by <i>ClassGuid</i> does not exist. This error can occur only if the DICLASSPROP_INTERFACE flag is
///    specified. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INSUFFICIENT_BUFFER</b></dt> </dl> </td> <td
///    width="60%"> An internal data buffer that was passed to a system call was too small. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_NOT_ENOUGH_MEMORY</b></dt> </dl> </td> <td width="60%"> There was not enough
///    system memory available to complete the operation. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_NOT_FOUND</b></dt> </dl> </td> <td width="60%"> The requested device property does not exist. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> The caller does
///    not have Administrator privileges. </td> </tr> </table>
///    
@DllImport("SETUPAPI")
BOOL SetupDiGetClassPropertyW(const(GUID)* ClassGuid, const(DEVPROPKEY)* PropertyKey, uint* PropertyType, 
                              char* PropertyBuffer, uint PropertyBufferSize, uint* RequiredSize, uint Flags);

///The <b>SetupDiGetClassPropertyEx</b> function retrieves a class property for a device setup class or a device
///interface class on a local or remote computer.
///Params:
///    ClassGuid = A pointer to a GUID that identifies the device setup class or device interface class for which to retrieve a
///                device property for the device class. For information about specifying the class type, see the <i>Flags</i>
///                parameter.
///    PropertyKey = A pointer to a DEVPROPKEY structure that represents the device property key of the requested device class
///                  property.
///    PropertyType = A pointer to a DEVPROPTYPE-typed variable that receives the property-data-type identifier of the requested device
///                   class property, where the property-data-type identifier is the bitwise OR between a base-data-type identifier
///                   and, if the base data type is modified, a property-data-type modifier.
///    PropertyBuffer = A pointer to a buffer that receives the requested device class property. <b>SetupDiGetClassPropertyEx</b>
///                     retrieves the requested property value only if the buffer is large enough to hold all the property value data.
///                     The pointer can be <b>NULL</b>. If the pointer is set to <b>NULL</b> and <i>RequiredSize</i> is supplied,
///                     <b>SetupDiGetClassPropertyEx</b> returns the size of the device class property, in bytes, in
///                     *<i>RequiredSize</i>.
///    PropertyBufferSize = The size, in bytes, of the <i>PropertyBuffer</i> buffer. If <i>PropertyBuffer</i> is set to <b>NULL</b>,
///                         <i>PropertyBufferSize</i> must be set to zero.
///    RequiredSize = A pointer to a DWORD-typed variable that receives either the size, in bytes, of the device class property if the
///                   property is retrieved or the required buffer size if the buffer is not large enough. This pointer can be set to
///                   <b>NULL</b>.
///    Flags = One of the following values, which specifies whether the class is a device setup class or a device interface
///            class:
///    MachineName = A pointer to a NULL-terminated string that contains the UNC name, including the "\\" prefix, of a computer. The
///                  pointer can be set to <b>NULL</b>. If <i>MachineName</i> is <b>NULL</b>, <b>SetupDiGetClassPropertyEx</b>
///                  retrieves the requested device class property from the local computer.
///    Reserved = This parameter must be set to <b>NULL</b>.
///Returns:
///    <b>SetupDiGetClassPropertyEx</b> returns <b>TRUE</b> if it is successful. Otherwise, it returns <b>FALSE</b>, and
///    the logged error can be retrieved by calling GetLastError. The following table includes some of the more common
///    error codes that this function might log. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_INVALID_FLAGS</b></dt> </dl> </td> <td width="60%"> The value of<i> Flags</i> is
///    not zero. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_CLASS</b></dt> </dl> </td> <td width="60%">
///    The device setup class that is specified by <i>ClassGuid</i> is not valid. This error can occur only if the
///    DICLASSPROP_INSTALLER flag is specified. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> An unspecified parameter is not valid. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_REG_PROPERTY</b></dt> </dl> </td> <td width="60%"> The
///    property key that is supplied by <i>PropertyKey</i> is not valid. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_REFERENCE_STRING</b></dt> </dl> </td> <td width="60%"> The device interface reference string
///    is not valid. This error can be returned if the DICLASSPROP_INTERFACE flag is specified. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_INVALID_DATA</b></dt> </dl> </td> <td width="60%"> An unspecified internal data
///    value was not valid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_USER_BUFFER</b></dt> </dl> </td>
///    <td width="60%"> A user buffer is not valid. One possibility is that <i>PropertyBuffer</i> is <b>NULL</b>, and
///    <i>PropertyBufferSize</i> is not zero. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_MACHINENAME</b></dt> </dl> </td> <td width="60%"> The computer name that is specified by
///    <i>MachineName</i> is not valid. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_NO_SUCH_INTERFACE_CLASS</b></dt> </dl> </td> <td width="60%"> The device interface class that is
///    specified by <i>ClassGuid</i> does not exist. This error can occur only if the DICLASSPROP_INTERFACE flag is
///    specified. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INSUFFICIENT_BUFFER</b></dt> </dl> </td> <td
///    width="60%"> An internal data buffer that was passed to a system call was too small. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_NOT_ENOUGH_MEMORY</b></dt> </dl> </td> <td width="60%"> There was not enough
///    system memory available to complete the operation. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_NOT_FOUND</b></dt> </dl> </td> <td width="60%"> The requested device property does not exist. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> The caller does
///    not have Administrator privileges. </td> </tr> </table>
///    
@DllImport("SETUPAPI")
BOOL SetupDiGetClassPropertyExW(const(GUID)* ClassGuid, const(DEVPROPKEY)* PropertyKey, uint* PropertyType, 
                                char* PropertyBuffer, uint PropertyBufferSize, uint* RequiredSize, uint Flags, 
                                const(wchar)* MachineName, void* Reserved);

///The <b>SetupDiSetClassProperty</b> function sets a class property for a device setup class or a device interface
///class.
///Params:
///    ClassGuid = A pointer to a GUID that identifies the device setup class or device interface class for which to set a device
///                property. For information about how to specify the class type, see the <i>Flags</i> parameter.
///    PropertyKey = A pointer to a DEVPROPKEY structure that represents the device property key of the device class property to set.
///    PropertyType = A DEVPROPTYPE-typed value that represents the property-data-type identifier for the device class property. For
///                   more information about the property-data-type identifier, see the <b>Remarks</b> section later in this topic.
///    PropertyBuffer = A pointer to a buffer that contains the property value of the device class. If either the property or the data is
///                     being deleted, this pointer must be set to <b>NULL</b>, and <i>PropertyBufferSize</i> must be set to zero. For
///                     more information about property data, see the <b>Remarks</b> section later in this topic.
///    PropertyBufferSize = The size, in bytes, of the <i>PropertyBuffer</i> buffer. If <i>PropertyBuffer </i>is set to <b>NULL</b>,
///                         <i>PropertyBufferSize</i> must be set to zero.
///    Flags = One of the following values, which specifies whether the class is a device setup class or a device interface
///            class:
///Returns:
///    <b>SetupDiSetClassProperty</b> returns <b>TRUE</b> if it is successful. Otherwise, it returns <b>FALSE</b>, and
///    the logged error can be retrieved by calling GetLastError. The following table includes some of the more common
///    error codes that this function might log. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_INVALID_FLAGS</b></dt> </dl> </td> <td width="60%"> The value of<i> Flags</i> is
///    invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_CLASS</b></dt> </dl> </td> <td width="60%">
///    The device setup class that is specified by <i>ClassGuid</i> is not valid. This error can occur only if the
///    DICLASSPROP_INSTALLER flag is specified. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_REFERENCE_STRING</b></dt> </dl> </td> <td width="60%"> The device interface reference string
///    is not valid. This error can occur only if the DICLASSPROP_INTERFACE flag is specified. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_INVALID_REG_PROPERTY</b></dt> </dl> </td> <td width="60%"> The property key that
///    is supplied by <i>PropertyKey</i> is not valid. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_DATA</b></dt> </dl> </td> <td width="60%"> An unspecified internal data value was not valid.
///    This error could be logged if the <i>ClassGuid</i> value is not a valid GUID or the property value is not
///    consistent with the property type specified by <i>PropertyType.</i> </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_USER_BUFFER</b></dt> </dl> </td> <td width="60%"> A user buffer is not valid. One
///    possibility is that <i>PropertyBuffer</i> is <b>NULL</b>, and <i>PropertyBufferSize</i> is not zero. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>ERROR_NO_SUCH_INTERFACE_CLASS</b></dt> </dl> </td> <td width="60%"> The device
///    interface class that is specified by <i>ClassGuid</i> does not exist. This error can occur only if the
///    DICLASSPROP_INTERFACE flag is specified. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INSUFFICIENT_BUFFER</b></dt> </dl> </td> <td width="60%"> An internal data buffer that was passed to
///    a system call was too small. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NOT_ENOUGH_MEMORY</b></dt> </dl>
///    </td> <td width="60%"> There was not enough system memory available to complete the operation. </td> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>ERROR_NOT_FOUND</b></dt> </dl> </td> <td width="60%"> An unspecified item was not
///    found. One possibility is that the property to be deleted does not exist. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> The caller does not have Administrator
///    privileges. </td> </tr> </table>
///    
@DllImport("SETUPAPI")
BOOL SetupDiSetClassPropertyW(const(GUID)* ClassGuid, const(DEVPROPKEY)* PropertyKey, uint PropertyType, 
                              char* PropertyBuffer, uint PropertyBufferSize, uint Flags);

///The <b>SetupDiSetClassPropertyEx</b> function sets a device property for a device setup class or a device interface
///class on a local or remote computer.
///Params:
///    ClassGuid = A pointer to a GUID that identifies the device setup class or device interface class for which to set a device
///                property. For information about how to specify the class type, see the <i>Flags</i> parameter.
///    PropertyKey = A pointer to a DEVPROPKEY structure that represents the device property key of the device class property to set.
///    PropertyType = A DEVPROPTYPE-typed value that represents the property-data-type identifier for the class property. For more
///                   information about the property-data-type identifier, see the <b>Remarks</b> section later in this topic.
///    PropertyBuffer = A pointer to a buffer that contains the class property value. If either the property or the property value is
///                     being deleted, this pointer must be set to <b>NULL</b>, and <i>PropertyBufferSize</i> must be set to zero. For
///                     more information about property value requirements, see the <b>Remarks</b> section later in this topic.
///    PropertyBufferSize = The size, in bytes, of the <i>PropertyBuffer</i> buffer. The property buffer size must be consistent with the
///                         property-data-type identifier that is supplied by <i>PropertyType</i>. If <i>PropertyBuffer </i>is set to
///                         <b>NULL</b>, <i>PropertyBufferSize</i> must be set to zero.
///    Flags = One of the following values, which specifies whether the class is a device setup class or a device interface
///            class:
///    MachineName = A pointer to a NULL-terminated Unicode string that contains the UNC name, including the "\\" prefix, of a
///                  computer. This pointer can be set to <b>NULL</b>. If the pointer is <b>NULL</b>, <b>SetupDiSetClassPropertyEx</b>
///                  sets the class property for a class that is installed on the local computer.
///    Reserved = This parameter must be set to <b>NULL</b>.
///Returns:
///    <b>SetupDiSetClassPropertyEx</b> returns <b>TRUE</b> if it is successful. Otherwise, it returns <b>FALSE</b>, and
///    the logged error can be retrieved by calling GetLastError. The following table includes some of the more common
///    error codes that this function might log. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_INVALID_FLAGS</b></dt> </dl> </td> <td width="60%"> The value of<i> Flags</i> is
///    invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_CLASS</b></dt> </dl> </td> <td width="60%">
///    The device setup class that is specified by <i>ClassGuid</i> is not valid. This error can occur only if the
///    DICLASSPROP_INSTALLER flag is specified. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_REFERENCE_STRING</b></dt> </dl> </td> <td width="60%"> The device interface reference string
///    is not valid. This error can occur only if the DICLASSPROP_INTERFACE flag is specified. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_INVALID_REG_PROPERTY</b></dt> </dl> </td> <td width="60%"> The property key that
///    is supplied by <i>PropertyKey</i> is not valid. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_DATA</b></dt> </dl> </td> <td width="60%"> An unspecified internal data value was not valid.
///    This error could be logged if either the <i>ClassGuid</i> value is not a valid GUID or the property value does
///    not match the property type specified by <i>PropertyType</i>. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_USER_BUFFER</b></dt> </dl> </td> <td width="60%"> A user buffer is not valid. One
///    possibility is that <i>PropertyBuffer</i> is <b>NULL</b>, and <i>PropertyBufferSize</i> is not zero. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_MACHINENAME</b></dt> </dl> </td> <td width="60%"> The computer
///    name that is specified by <i>MachineName</i> is not valid. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_NO_SUCH_INTERFACE_CLASS</b></dt> </dl> </td> <td width="60%"> The device interface class that is
///    specified by <i>ClassGuid</i> does not exist. This error can occur only if the DICLASSPROP_INTERFACE flag is
///    specified. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INSUFFICIENT_BUFFER</b></dt> </dl> </td> <td
///    width="60%"> An internal data buffer that was passed to a system call was too small. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_NOT_ENOUGH_MEMORY</b></dt> </dl> </td> <td width="60%"> There was not enough
///    system memory available to complete the operation. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_NOT_FOUND</b></dt> </dl> </td> <td width="60%"> An unspecified item was not found. One possibility
///    is that the property to be deleted does not exist. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> The caller does not have Administrator
///    privileges. </td> </tr> </table>
///    
@DllImport("SETUPAPI")
BOOL SetupDiSetClassPropertyExW(const(GUID)* ClassGuid, const(DEVPROPKEY)* PropertyKey, uint PropertyType, 
                                char* PropertyBuffer, uint PropertyBufferSize, uint Flags, const(wchar)* MachineName, 
                                void* Reserved);

///The <b>SetupDiGetDeviceRegistryProperty</b> function retrieves a specified Plug and Play device property.
///Params:
///    DeviceInfoSet = A handle to a device information set that contains a device information element that represents the device for
///                    which to retrieve a Plug and Play property.
///    DeviceInfoData = A pointer to an SP_DEVINFO_DATA structure that specifies the device information element in <i>DeviceInfoSet</i>.
///    Property = One of the following values that specifies the property to be retrieved:
///    PropertyRegDataType = A pointer to a variable that receives the data type of the property that is being retrieved. This is one of the
///                          standard registry data types. This parameter is optional and can be <b>NULL</b>.
///    PropertyBuffer = A pointer to a buffer that receives the property that is being retrieved. If this parameter is set to
///                     <b>NULL</b>, and <i>PropertyBufferSize</i> is also set to zero, the function returns the required size for the
///                     buffer in <i>RequiredSize</i>.
///    PropertyBufferSize = The size, in bytes, of the <i>PropertyBuffer </i>buffer.
///    RequiredSize = A pointer to a variable of type DWORD that receives the required size, in bytes, of the <i>PropertyBuffer</i>
///                   buffer that is required to hold the data for the requested property. This parameter is optional and can be
///                   <b>NULL</b>.
///Returns:
///    <b>SetupDiGetDeviceRegistryProperty</b> returns <b>TRUE</b> if the call was successful. Otherwise, it returns
///    <b>FALSE</b> and the logged error can be retrieved by making a call to GetLastError.
///    <b>SetupDiGetDeviceRegistryProperty</b> returns the ERROR_INVALID_DATA error code if the requested property does
///    not exist for a device or if the property data is not valid.
///    
@DllImport("SETUPAPI")
BOOL SetupDiGetDeviceRegistryPropertyA(void* DeviceInfoSet, SP_DEVINFO_DATA* DeviceInfoData, uint Property, 
                                       uint* PropertyRegDataType, char* PropertyBuffer, uint PropertyBufferSize, 
                                       uint* RequiredSize);

///The <b>SetupDiGetDeviceRegistryProperty</b> function retrieves a specified Plug and Play device property.
///Params:
///    DeviceInfoSet = A handle to a device information set that contains a device information element that represents the device for
///                    which to retrieve a Plug and Play property.
///    DeviceInfoData = A pointer to an SP_DEVINFO_DATA structure that specifies the device information element in <i>DeviceInfoSet</i>.
///    Property = One of the following values that specifies the property to be retrieved:
///    PropertyRegDataType = A pointer to a variable that receives the data type of the property that is being retrieved. This is one of the
///                          standard registry data types. This parameter is optional and can be <b>NULL</b>.
///    PropertyBuffer = A pointer to a buffer that receives the property that is being retrieved. If this parameter is set to
///                     <b>NULL</b>, and <i>PropertyBufferSize</i> is also set to zero, the function returns the required size for the
///                     buffer in <i>RequiredSize</i>.
///    PropertyBufferSize = The size, in bytes, of the <i>PropertyBuffer </i>buffer.
///    RequiredSize = A pointer to a variable of type DWORD that receives the required size, in bytes, of the <i>PropertyBuffer</i>
///                   buffer that is required to hold the data for the requested property. This parameter is optional and can be
///                   <b>NULL</b>.
///Returns:
///    <b>SetupDiGetDeviceRegistryProperty</b> returns <b>TRUE</b> if the call was successful. Otherwise, it returns
///    <b>FALSE</b> and the logged error can be retrieved by making a call to GetLastError.
///    <b>SetupDiGetDeviceRegistryProperty</b> returns the ERROR_INVALID_DATA error code if the requested property does
///    not exist for a device or if the property data is not valid.
///    
@DllImport("SETUPAPI")
BOOL SetupDiGetDeviceRegistryPropertyW(void* DeviceInfoSet, SP_DEVINFO_DATA* DeviceInfoData, uint Property, 
                                       uint* PropertyRegDataType, char* PropertyBuffer, uint PropertyBufferSize, 
                                       uint* RequiredSize);

///The <b>SetupDiGetClassRegistryProperty</b> function retrieves a property for a specified device setup class from the
///registry.
///Params:
///    ClassGuid = A pointer to a GUID representing the device setup class for which a property is to be retrieved.
///    Property = A value that identifies the property to be retrieved. This must be one of the following values:
///    PropertyRegDataType = A pointer to a variable of type DWORD that receives the property data type as one of the REG_-prefixed registry
///                          data types. This parameter is optional and can be <b>NULL</b>. If this parameter is <b>NULL</b>,
///                          S<b>etupDiGetClassRegistryProperty</b> does not return the data type.
///    PropertyBuffer = A pointer to a buffer that receives the requested property.
///    PropertyBufferSize = The size, in bytes, of the <i>PropertyBuffer </i>buffer.
///    RequiredSize = A pointer to a variable of type DWORD that receives the required size, in bytes, of the <i>PropertyBuffer
///                   </i>buffer. If the <i>PropertyBuffer</i> buffer is too small, and <i>RequiredSize</i> is not <b>NULL</b>, the
///                   function sets <i>RequiredSize</i> to the minimum buffer size that is required to receive the requested property.
///    MachineName = A pointer to a NULL-terminated string that contains the name of a remote system from which to retrieve the
///                  specified device class property. This parameter is optional and can be <b>NULL</b>. If this parameter is
///                  <b>NULL</b>, the property is retrieved from the local system.
///    Reserved = Reserved, must be <b>NULL</b>.
///Returns:
///    The function returns <b>TRUE</b> if it is successful. Otherwise, it returns <b>FALSE</b> and the logged error can
///    be retrieved with a call to GetLastError.
///    
@DllImport("SETUPAPI")
BOOL SetupDiGetClassRegistryPropertyA(const(GUID)* ClassGuid, uint Property, uint* PropertyRegDataType, 
                                      char* PropertyBuffer, uint PropertyBufferSize, uint* RequiredSize, 
                                      const(char)* MachineName, void* Reserved);

///The <b>SetupDiGetClassRegistryProperty</b> function retrieves a property for a specified device setup class from the
///registry.
///Params:
///    ClassGuid = A pointer to a GUID representing the device setup class for which a property is to be retrieved.
///    Property = A value that identifies the property to be retrieved. This must be one of the following values:
///    PropertyRegDataType = A pointer to a variable of type DWORD that receives the property data type as one of the REG_-prefixed registry
///                          data types. This parameter is optional and can be <b>NULL</b>. If this parameter is <b>NULL</b>,
///                          S<b>etupDiGetClassRegistryProperty</b> does not return the data type.
///    PropertyBuffer = A pointer to a buffer that receives the requested property.
///    PropertyBufferSize = The size, in bytes, of the <i>PropertyBuffer </i>buffer.
///    RequiredSize = A pointer to a variable of type DWORD that receives the required size, in bytes, of the <i>PropertyBuffer
///                   </i>buffer. If the <i>PropertyBuffer</i> buffer is too small, and <i>RequiredSize</i> is not <b>NULL</b>, the
///                   function sets <i>RequiredSize</i> to the minimum buffer size that is required to receive the requested property.
///    MachineName = A pointer to a NULL-terminated string that contains the name of a remote system from which to retrieve the
///                  specified device class property. This parameter is optional and can be <b>NULL</b>. If this parameter is
///                  <b>NULL</b>, the property is retrieved from the local system.
///    Reserved = Reserved, must be <b>NULL</b>.
///Returns:
///    The function returns <b>TRUE</b> if it is successful. Otherwise, it returns <b>FALSE</b> and the logged error can
///    be retrieved with a call to GetLastError.
///    
@DllImport("SETUPAPI")
BOOL SetupDiGetClassRegistryPropertyW(const(GUID)* ClassGuid, uint Property, uint* PropertyRegDataType, 
                                      char* PropertyBuffer, uint PropertyBufferSize, uint* RequiredSize, 
                                      const(wchar)* MachineName, void* Reserved);

///The <b>SetupDiSetDeviceRegistryProperty</b> function sets a Plug and Play device property for a device.
///Params:
///    DeviceInfoSet = A handle to the device information set that contains a device information element that represents the device for
///                    which to set a Plug and Play device property.
///    DeviceInfoData = A pointer to an SP_DEVINFO_DATA structure that specifies the device information element in <i>DeviceInfoSet</i>.
///                     If the <b>ClassGuid</b> property is set, <i>DeviceInfoData.</i><b>ClassGuid</b> is set upon return to the new
///                     class for the device.
///    Property = One of the following values, which identifies the property to be set. For descriptions of these values, see
///               SetupDiGetDeviceRegistryProperty. * SPDRP_CONFIGFLAGS * SPDRP_EXCLUSIVE * SPDRP_FRIENDLYNAME *
///               SPDRP_LOCATION_INFORMATION * SPDRP_LOWERFILTERS * SPDRP_REMOVAL_POLICY_OVERRIDE * SPDRP_SECURITY *
///               SPDRP_SECURITY_SDS * SPDRP_UI_NUMBER_DESC_FORMAT * SPDRP_UPPERFILTERS > [!NOTE] > SPDRP_HARDWAREID or
///               SPDRP_COMPATIBLEIDS can only be used when *DeviceInfoData* represents a root-enumerated device. For other
///               devices, the bus driver reports hardware and compatible IDs when enumerating a child device after receiving
///               IRP_MN_QUERY_ID. The following values are reserved for use by the operating system and cannot be used in the
///               *Property* parameter: * SPDRP_ADDRESS * SPDRP_BUSNUMBER * SPDRP_BUSTYPEGUID * SPDRP_CHARACTERISTICS *
///               SPDRP_CAPABILITIES * SPDRP_CLASS * SPDRP_CLASSGUID * SPDRP_DEVICE_POWER_DATA * SPDRP_DEVICEDESC * SPDRP_DEVTYPE *
///               SPDRP_DRIVER * SPDRP_ENUMERATOR_NAME * SPDRP_INSTALL_STATE * SPDRP_LEGACYBUSTYPE * SPDRP_LOCATION_PATHS *
///               SPDRP_MFG * SPDRP_PHYSICAL_DEVICE_OBJECT_NAME * SPDRP_REMOVAL_POLICY * SPDRP_REMOVAL_POLICY_HW_DEFAULT *
///               SPDRP_SERVICE * SPDRP_UI_NUMBER
///    PropertyBuffer = A pointer to a buffer that contains the new data for the property. If the property is being cleared, then this
///                     pointer should be <b>NULL</b> and <i>PropertyBufferSize</i> must be zero.
///    PropertyBufferSize = The size, in bytes, of <i>PropertyBuffer</i>. If <i>PropertyBuffer</i> is <b>NULL</b>, then this field must be
///                         zero.
///Returns:
///    The function returns <b>TRUE</b> if it is successful. Otherwise, it returns <b>FALSE</b> and the logged error can
///    be retrieved with a call to GetLastError.
///    
@DllImport("SETUPAPI")
BOOL SetupDiSetDeviceRegistryPropertyA(void* DeviceInfoSet, SP_DEVINFO_DATA* DeviceInfoData, uint Property, 
                                       char* PropertyBuffer, uint PropertyBufferSize);

///The <b>SetupDiSetDeviceRegistryProperty</b> function sets a Plug and Play device property for a device.
///Params:
///    DeviceInfoSet = A handle to the device information set that contains a device information element that represents the device for
///                    which to set a Plug and Play device property.
///    DeviceInfoData = A pointer to an SP_DEVINFO_DATA structure that specifies the device information element in <i>DeviceInfoSet</i>.
///                     If the <b>ClassGuid</b> property is set, <i>DeviceInfoData.</i><b>ClassGuid</b> is set upon return to the new
///                     class for the device.
///    Property = One of the following values, which identifies the property to be set. For descriptions of these values, see
///               SetupDiGetDeviceRegistryProperty. * SPDRP_CONFIGFLAGS * SPDRP_EXCLUSIVE * SPDRP_FRIENDLYNAME *
///               SPDRP_LOCATION_INFORMATION * SPDRP_LOWERFILTERS * SPDRP_REMOVAL_POLICY_OVERRIDE * SPDRP_SECURITY *
///               SPDRP_SECURITY_SDS * SPDRP_UI_NUMBER_DESC_FORMAT * SPDRP_UPPERFILTERS > [!NOTE] > SPDRP_HARDWAREID or
///               SPDRP_COMPATIBLEIDS can only be used when *DeviceInfoData* represents a root-enumerated device. For other
///               devices, the bus driver reports hardware and compatible IDs when enumerating a child device after receiving
///               IRP_MN_QUERY_ID. The following values are reserved for use by the operating system and cannot be used in the
///               *Property* parameter: * SPDRP_ADDRESS * SPDRP_BUSNUMBER * SPDRP_BUSTYPEGUID * SPDRP_CHARACTERISTICS *
///               SPDRP_CAPABILITIES * SPDRP_CLASS * SPDRP_CLASSGUID * SPDRP_DEVICE_POWER_DATA * SPDRP_DEVICEDESC * SPDRP_DEVTYPE *
///               SPDRP_DRIVER * SPDRP_ENUMERATOR_NAME * SPDRP_INSTALL_STATE * SPDRP_LEGACYBUSTYPE * SPDRP_LOCATION_PATHS *
///               SPDRP_MFG * SPDRP_PHYSICAL_DEVICE_OBJECT_NAME * SPDRP_REMOVAL_POLICY * SPDRP_REMOVAL_POLICY_HW_DEFAULT *
///               SPDRP_SERVICE * SPDRP_UI_NUMBER
///    PropertyBuffer = A pointer to a buffer that contains the new data for the property. If the property is being cleared, then this
///                     pointer should be <b>NULL</b> and <i>PropertyBufferSize</i> must be zero.
///    PropertyBufferSize = The size, in bytes, of <i>PropertyBuffer</i>. If <i>PropertyBuffer</i> is <b>NULL</b>, then this field must be
///                         zero.
///Returns:
///    The function returns <b>TRUE</b> if it is successful. Otherwise, it returns <b>FALSE</b> and the logged error can
///    be retrieved with a call to GetLastError.
///    
@DllImport("SETUPAPI")
BOOL SetupDiSetDeviceRegistryPropertyW(void* DeviceInfoSet, SP_DEVINFO_DATA* DeviceInfoData, uint Property, 
                                       char* PropertyBuffer, uint PropertyBufferSize);

///The <b>SetupDiSetClassRegistryProperty</b> function sets a specified device class property in the registry.
///Params:
///    ClassGuid = A pointer to the GUID that identifies the device class for which a property is to be set.
///    Property = A value that identifies the property to be set, which must be one of the following:
///    PropertyBuffer = A pointer to a buffer that supplies the specified property. This parameter is optional and can be <b>NULL</b>.
///    PropertyBufferSize = The size, in bytes, of the <i>PropertyBuffer </i>buffer.
///    MachineName = A pointer to a NULL-terminated string that contains the name of a remote system on which to set the specified
///                  device class property. This parameter is optional and can be <b>NULL</b>. If this parameter is <b>NULL</b>, the
///                  property is set on the name of the local system.
///    Reserved = Reserved, must be <b>NULL</b>.
///Returns:
///    The function returns <b>TRUE</b> if it is successful. Otherwise, it returns <b>FALSE</b> and the logged error can
///    be retrieved with a call to GetLastError.
///    
@DllImport("SETUPAPI")
BOOL SetupDiSetClassRegistryPropertyA(const(GUID)* ClassGuid, uint Property, char* PropertyBuffer, 
                                      uint PropertyBufferSize, const(char)* MachineName, void* Reserved);

///The <b>SetupDiSetClassRegistryProperty</b> function sets a specified device class property in the registry.
///Params:
///    ClassGuid = A pointer to the GUID that identifies the device class for which a property is to be set.
///    Property = A value that identifies the property to be set, which must be one of the following:
///    PropertyBuffer = A pointer to a buffer that supplies the specified property. This parameter is optional and can be <b>NULL</b>.
///    PropertyBufferSize = The size, in bytes, of the <i>PropertyBuffer </i>buffer.
///    MachineName = A pointer to a NULL-terminated string that contains the name of a remote system on which to set the specified
///                  device class property. This parameter is optional and can be <b>NULL</b>. If this parameter is <b>NULL</b>, the
///                  property is set on the name of the local system.
///    Reserved = Reserved, must be <b>NULL</b>.
///Returns:
///    The function returns <b>TRUE</b> if it is successful. Otherwise, it returns <b>FALSE</b> and the logged error can
///    be retrieved with a call to GetLastError.
///    
@DllImport("SETUPAPI")
BOOL SetupDiSetClassRegistryPropertyW(const(GUID)* ClassGuid, uint Property, char* PropertyBuffer, 
                                      uint PropertyBufferSize, const(wchar)* MachineName, void* Reserved);

///The <b>SetupDiGetDeviceInstallParams</b> function retrieves device installation parameters for a device information
///set or a particular device information element.
///Params:
///    DeviceInfoSet = A handle to the device information set that contains the device installation parameters to retrieve.
///    DeviceInfoData = A pointer to an SP_DEVINFO_DATA structure that specifies the device information element in <i>DeviceInfoSet</i>.
///                     This parameter is optional and can be <b>NULL</b>. If this parameter is specified,
///                     <b>SetupDiGetDeviceInstallParams</b> retrieves the installation parameters for the specified device. If this
///                     parameter is <b>NULL</b>, the function retrieves the global device installation parameters that are associated
///                     with <i>DeviceInfoSet</i>.
///    DeviceInstallParams = A pointer to an SP_DEVINSTALL_PARAMS structure that receives the device install parameters.
///                          <i>DeviceInstallParams</i>.<b>cbSize</b> must be set to the size, in bytes, of the structure before calling this
///                          function.
///Returns:
///    The function returns <b>TRUE</b> if it is successful. Otherwise, it returns <b>FALSE</b> and the logged error can
///    be retrieved by making a call to GetLastError.
///    
@DllImport("SETUPAPI")
BOOL SetupDiGetDeviceInstallParamsA(void* DeviceInfoSet, SP_DEVINFO_DATA* DeviceInfoData, 
                                    SP_DEVINSTALL_PARAMS_A* DeviceInstallParams);

///The <b>SetupDiGetDeviceInstallParams</b> function retrieves device installation parameters for a device information
///set or a particular device information element.
///Params:
///    DeviceInfoSet = A handle to the device information set that contains the device installation parameters to retrieve.
///    DeviceInfoData = A pointer to an SP_DEVINFO_DATA structure that specifies the device information element in <i>DeviceInfoSet</i>.
///                     This parameter is optional and can be <b>NULL</b>. If this parameter is specified,
///                     <b>SetupDiGetDeviceInstallParams</b> retrieves the installation parameters for the specified device. If this
///                     parameter is <b>NULL</b>, the function retrieves the global device installation parameters that are associated
///                     with <i>DeviceInfoSet</i>.
///    DeviceInstallParams = A pointer to an SP_DEVINSTALL_PARAMS structure that receives the device install parameters.
///                          <i>DeviceInstallParams</i>.<b>cbSize</b> must be set to the size, in bytes, of the structure before calling this
///                          function.
///Returns:
///    The function returns <b>TRUE</b> if it is successful. Otherwise, it returns <b>FALSE</b> and the logged error can
///    be retrieved by making a call to GetLastError.
///    
@DllImport("SETUPAPI")
BOOL SetupDiGetDeviceInstallParamsW(void* DeviceInfoSet, SP_DEVINFO_DATA* DeviceInfoData, 
                                    SP_DEVINSTALL_PARAMS_W* DeviceInstallParams);

///The <b>SetupDiGetClassInstallParams</b> function retrieves class installation parameters for a device information set
///or a particular device information element.
///Params:
///    DeviceInfoSet = A handle to a device information set that contains the class install parameters to retrieve.
///    DeviceInfoData = A pointer to an SP_DEVINFO_DATA structure that specified a device information element in <i>DeviceInfoSet</i>.
///                     This parameter is optional and can be <b>NULL</b>. If this parameter is specified,
///                     <b>SetupDiGetClassInstallParams</b> retrieves the class installation parameters for the specified device. If this
///                     parameter is <b>NULL</b>, <b>SetupDiGetClassInstallParams</b> retrieves the class install parameters for the
///                     global class driver list that is associated with <i>DeviceInfoSet</i>.
///    ClassInstallParams = A pointer to a buffer that contains an SP_CLASSINSTALL_HEADER structure. This structure must have its
///                         <b>cbSize</b> member set to <b>sizeof(</b>SP_CLASSINSTALL_HEADER<b>)</b> on input or the buffer is considered to
///                         be invalid. On output, the <b>InstallFunction</b> member is filled with the device installation function code for
///                         the class installation parameters being retrieved. If the buffer is large enough, it also receives the class
///                         installation parameters structure specific to the function code. If <i>ClassInstallParams</i> is not specified,
///                         <i>ClassInstallParamsSize</i> must be 0.
///    ClassInstallParamsSize = The size, in bytes, of the <i>ClassInstallParams</i> buffer. If the buffer is supplied, it must be at least as
///                             large as <b>sizeof(</b>SP_CLASSINSTALL_HEADER<b>)</b>. If the buffer is not supplied,
///                             <i>ClassInstallParamsSize</i> must be 0<i>.</i>
///    RequiredSize = A pointer to a variable of type DWORD that receives the number of bytes required to store the class install
///                   parameters. This parameter is optional and can be <b>NULL</b>.
///Returns:
///    The function returns <b>TRUE</b> if it is successful. Otherwise, it returns <b>FALSE</b> and the logged error can
///    be retrieved with a call to GetLastError.
///    
@DllImport("SETUPAPI")
BOOL SetupDiGetClassInstallParamsA(void* DeviceInfoSet, SP_DEVINFO_DATA* DeviceInfoData, char* ClassInstallParams, 
                                   uint ClassInstallParamsSize, uint* RequiredSize);

///The <b>SetupDiGetClassInstallParams</b> function retrieves class installation parameters for a device information set
///or a particular device information element.
///Params:
///    DeviceInfoSet = A handle to a device information set that contains the class install parameters to retrieve.
///    DeviceInfoData = A pointer to an SP_DEVINFO_DATA structure that specified a device information element in <i>DeviceInfoSet</i>.
///                     This parameter is optional and can be <b>NULL</b>. If this parameter is specified,
///                     <b>SetupDiGetClassInstallParams</b> retrieves the class installation parameters for the specified device. If this
///                     parameter is <b>NULL</b>, <b>SetupDiGetClassInstallParams</b> retrieves the class install parameters for the
///                     global class driver list that is associated with <i>DeviceInfoSet</i>.
///    ClassInstallParams = A pointer to a buffer that contains an SP_CLASSINSTALL_HEADER structure. This structure must have its
///                         <b>cbSize</b> member set to <b>sizeof(</b>SP_CLASSINSTALL_HEADER<b>)</b> on input or the buffer is considered to
///                         be invalid. On output, the <b>InstallFunction</b> member is filled with the device installation function code for
///                         the class installation parameters being retrieved. If the buffer is large enough, it also receives the class
///                         installation parameters structure specific to the function code. If <i>ClassInstallParams</i> is not specified,
///                         <i>ClassInstallParamsSize</i> must be 0.
///    ClassInstallParamsSize = The size, in bytes, of the <i>ClassInstallParams</i> buffer. If the buffer is supplied, it must be at least as
///                             large as <b>sizeof(</b>SP_CLASSINSTALL_HEADER<b>)</b>. If the buffer is not supplied,
///                             <i>ClassInstallParamsSize</i> must be 0<i>.</i>
///    RequiredSize = A pointer to a variable of type DWORD that receives the number of bytes required to store the class install
///                   parameters. This parameter is optional and can be <b>NULL</b>.
///Returns:
///    The function returns <b>TRUE</b> if it is successful. Otherwise, it returns <b>FALSE</b> and the logged error can
///    be retrieved with a call to GetLastError.
///    
@DllImport("SETUPAPI")
BOOL SetupDiGetClassInstallParamsW(void* DeviceInfoSet, SP_DEVINFO_DATA* DeviceInfoData, char* ClassInstallParams, 
                                   uint ClassInstallParamsSize, uint* RequiredSize);

///The <b>SetupDiSetDeviceInstallParams</b> function sets device installation parameters for a device information set or
///a particular device information element.
///Params:
///    DeviceInfoSet = A handle to the device information set for which to set device installation parameters.
///    DeviceInfoData = A pointer to an SP_DEVINFO_DATA structure that specifies a device information element in <i>DeviceInfoSet</i>.
///                     This parameter is optional and can be set to <b>NULL</b>. If this parameter is specified,
///                     <b>SetupDiSetDeviceInstallParams</b> sets the installation parameters for the specified device. If this parameter
///                     is <b>NULL</b>, <b>SetupDiSetDeviceInstallParams</b> sets the installation parameters that are associated with
///                     the global class driver list for <i>DeviceInfoSet</i>.
///    DeviceInstallParams = A pointer to an SP_DEVINSTALL_PARAMS structure that contains the new values of the parameters. The
///                          <i>DeviceInstallParams.</i><b>cbSize</b> must be set to the size, in bytes, of the structure before this function
///                          is called.
///Returns:
///    The function returns <b>TRUE</b> if it is successful. Otherwise, it returns <b>FALSE</b> and the logged error can
///    be retrieved with a call to GetLastError.
///    
@DllImport("SETUPAPI")
BOOL SetupDiSetDeviceInstallParamsA(void* DeviceInfoSet, SP_DEVINFO_DATA* DeviceInfoData, 
                                    SP_DEVINSTALL_PARAMS_A* DeviceInstallParams);

///The <b>SetupDiSetDeviceInstallParams</b> function sets device installation parameters for a device information set or
///a particular device information element.
///Params:
///    DeviceInfoSet = A handle to the device information set for which to set device installation parameters.
///    DeviceInfoData = A pointer to an SP_DEVINFO_DATA structure that specifies a device information element in <i>DeviceInfoSet</i>.
///                     This parameter is optional and can be set to <b>NULL</b>. If this parameter is specified,
///                     <b>SetupDiSetDeviceInstallParams</b> sets the installation parameters for the specified device. If this parameter
///                     is <b>NULL</b>, <b>SetupDiSetDeviceInstallParams</b> sets the installation parameters that are associated with
///                     the global class driver list for <i>DeviceInfoSet</i>.
///    DeviceInstallParams = A pointer to an SP_DEVINSTALL_PARAMS structure that contains the new values of the parameters. The
///                          <i>DeviceInstallParams.</i><b>cbSize</b> must be set to the size, in bytes, of the structure before this function
///                          is called.
///Returns:
///    The function returns <b>TRUE</b> if it is successful. Otherwise, it returns <b>FALSE</b> and the logged error can
///    be retrieved with a call to GetLastError.
///    
@DllImport("SETUPAPI")
BOOL SetupDiSetDeviceInstallParamsW(void* DeviceInfoSet, SP_DEVINFO_DATA* DeviceInfoData, 
                                    SP_DEVINSTALL_PARAMS_W* DeviceInstallParams);

///The <b>SetupDiSetClassInstallParams</b> function sets or clears class install parameters for a device information set
///or a particular device information element.
///Params:
///    DeviceInfoSet = A handle to the device information set for which to set class install parameters.
///    DeviceInfoData = A pointer to an SP_DEVINFO_DATA structure that represents the device for which to set class install parameters.
///                     This parameter is optional and can be <b>NULL</b>. If this parameter is specified,
///                     <b>SetupDiSetClassInstallParams</b> sets the class installation parameters for the specified device. If this
///                     parameter is <b>NULL</b>, <b>SetupDiSetClassInstallParams</b> sets the class install parameters that are
///                     associated with <i>DeviceInfoSet</i>.
///    ClassInstallParams = A pointer to a buffer that contains the new class install parameters to use. The SP_CLASSINSTALL_HEADER structure
///                         at the beginning of this buffer must have its <b>cbSize</b> field set to
///                         <b>sizeof(</b>SP_CLASSINSTALL_HEADER<b>)</b> and the <b>InstallFunction</b> field must be set to the DI_FUNCTION
///                         code that reflects the type of parameters contained in the rest of the buffer. If <i>ClassInstallParams</i> is
///                         not specified, the current class install parameters, if any, are cleared for the specified device information set
///                         or element.
///    ClassInstallParamsSize = The size, in bytes, of the <i>ClassInstallParams</i> buffer. If the buffer is not supplied (that is, the class
///                             install parameters are being cleared), <i>ClassInstallParamsSize</i> must be 0<i>.</i>
///Returns:
///    The function returns <b>TRUE</b> if it is successful. Otherwise, it returns <b>FALSE</b> and the logged error can
///    be retrieved with a call to GetLastError.
///    
@DllImport("SETUPAPI")
BOOL SetupDiSetClassInstallParamsA(void* DeviceInfoSet, SP_DEVINFO_DATA* DeviceInfoData, char* ClassInstallParams, 
                                   uint ClassInstallParamsSize);

///The <b>SetupDiSetClassInstallParams</b> function sets or clears class install parameters for a device information set
///or a particular device information element.
///Params:
///    DeviceInfoSet = A handle to the device information set for which to set class install parameters.
///    DeviceInfoData = A pointer to an SP_DEVINFO_DATA structure that represents the device for which to set class install parameters.
///                     This parameter is optional and can be <b>NULL</b>. If this parameter is specified,
///                     <b>SetupDiSetClassInstallParams</b> sets the class installation parameters for the specified device. If this
///                     parameter is <b>NULL</b>, <b>SetupDiSetClassInstallParams</b> sets the class install parameters that are
///                     associated with <i>DeviceInfoSet</i>.
///    ClassInstallParams = A pointer to a buffer that contains the new class install parameters to use. The SP_CLASSINSTALL_HEADER structure
///                         at the beginning of this buffer must have its <b>cbSize</b> field set to
///                         <b>sizeof(</b>SP_CLASSINSTALL_HEADER<b>)</b> and the <b>InstallFunction</b> field must be set to the DI_FUNCTION
///                         code that reflects the type of parameters contained in the rest of the buffer. If <i>ClassInstallParams</i> is
///                         not specified, the current class install parameters, if any, are cleared for the specified device information set
///                         or element.
///    ClassInstallParamsSize = The size, in bytes, of the <i>ClassInstallParams</i> buffer. If the buffer is not supplied (that is, the class
///                             install parameters are being cleared), <i>ClassInstallParamsSize</i> must be 0<i>.</i>
///Returns:
///    The function returns <b>TRUE</b> if it is successful. Otherwise, it returns <b>FALSE</b> and the logged error can
///    be retrieved with a call to GetLastError.
///    
@DllImport("SETUPAPI")
BOOL SetupDiSetClassInstallParamsW(void* DeviceInfoSet, SP_DEVINFO_DATA* DeviceInfoData, char* ClassInstallParams, 
                                   uint ClassInstallParamsSize);

///The <b>SetupDiGetDriverInstallParams</b> function retrieves driver installation parameters for a device information
///set or a particular device information element.
///Params:
///    DeviceInfoSet = A handle to a device information set that contains a driver information element that represents the driver for
///                    which to retrieve installation parameters.
///    DeviceInfoData = A pointer to an SP_DEVINFO_DATA structure that contains a device information element that represents the device
///                     for which to retrieve installation parameters. This parameter is optional and can be <b>NULL</b>. If this
///                     parameter is specified, <b>SetupDiGetDriverInstallParams</b> retrieves information about a driver that is a
///                     member of a driver list for the specified device. If this parameter is <b>NULL</b>,
///                     <b>SetupDiGetDriverInstallParams</b> retrieves information about a driver that is a member of the global class
///                     driver list for <i>DeviceInfoSet</i>.
///    DriverInfoData = A pointer to an SP_DRVINFO_DATA structure that specifies the driver information element that represents the
///                     driver for which to retrieve installation parameters. If <i>DeviceInfoData</i> is supplied, the driver must be a
///                     member of the driver list for the device that is specified by <i>DeviceInfoData</i>. Otherwise, the driver must
///                     be a member of the global class driver list for <i>DeviceInfoSet</i>.
///    DriverInstallParams = A pointer to an SP_DRVINSTALL_PARAMS structure to receive the installation parameters for this driver.
///Returns:
///    The function returns <b>TRUE</b> if it is successful. Otherwise, it returns <b>FALSE</b> and the logged error can
///    be retrieved by a call to GetLastError.
///    
@DllImport("SETUPAPI")
BOOL SetupDiGetDriverInstallParamsA(void* DeviceInfoSet, SP_DEVINFO_DATA* DeviceInfoData, 
                                    SP_DRVINFO_DATA_V2_A* DriverInfoData, SP_DRVINSTALL_PARAMS* DriverInstallParams);

///The <b>SetupDiGetDriverInstallParams</b> function retrieves driver installation parameters for a device information
///set or a particular device information element.
///Params:
///    DeviceInfoSet = A handle to a device information set that contains a driver information element that represents the driver for
///                    which to retrieve installation parameters.
///    DeviceInfoData = A pointer to an SP_DEVINFO_DATA structure that contains a device information element that represents the device
///                     for which to retrieve installation parameters. This parameter is optional and can be <b>NULL</b>. If this
///                     parameter is specified, <b>SetupDiGetDriverInstallParams</b> retrieves information about a driver that is a
///                     member of a driver list for the specified device. If this parameter is <b>NULL</b>,
///                     <b>SetupDiGetDriverInstallParams</b> retrieves information about a driver that is a member of the global class
///                     driver list for <i>DeviceInfoSet</i>.
///    DriverInfoData = A pointer to an SP_DRVINFO_DATA structure that specifies the driver information element that represents the
///                     driver for which to retrieve installation parameters. If <i>DeviceInfoData</i> is supplied, the driver must be a
///                     member of the driver list for the device that is specified by <i>DeviceInfoData</i>. Otherwise, the driver must
///                     be a member of the global class driver list for <i>DeviceInfoSet</i>.
///    DriverInstallParams = A pointer to an SP_DRVINSTALL_PARAMS structure to receive the installation parameters for this driver.
///Returns:
///    The function returns <b>TRUE</b> if it is successful. Otherwise, it returns <b>FALSE</b> and the logged error can
///    be retrieved by a call to GetLastError.
///    
@DllImport("SETUPAPI")
BOOL SetupDiGetDriverInstallParamsW(void* DeviceInfoSet, SP_DEVINFO_DATA* DeviceInfoData, 
                                    SP_DRVINFO_DATA_V2_W* DriverInfoData, SP_DRVINSTALL_PARAMS* DriverInstallParams);

///The <b>SetupDiSetDriverInstallParams</b> function sets driver installation parameters for a driver information
///element.
///Params:
///    DeviceInfoSet = A handle to a device information set that contains a driver information element that represents the driver for
///                    which to set installation parameters.
///    DeviceInfoData = A pointer to an SP_DEVINFO_DATA structure that specifies a device information element in <i>DeviceInfoSet</i>.
///                     This parameter is optional and can be set to <b>NULL</b>. If this parameter is specified,
///                     <b>SetupDiSetDriverInstallParams</b> sets the driver installation parameters for the specified device. If this
///                     parameter is <b>NULL</b>, <b>SetupDiSetDriverInstallParams</b> sets driver installation parameters for
///                     <i>DeviceInfoSet</i>.
///    DriverInfoData = A pointer to an SP_DRVINFO_DATA structure that specifies the driver for which installation parameters are set. If
///                     <i>DeviceInfoData</i> is specified, this driver must be a member of a driver list that is associated with
///                     <i>DeviceInfoData</i>. If <i>DeviceInfoData</i> is <b>NULL</b>, this driver must be a member of the global class
///                     driver list for <i>DeviceInfoSet</i>.
///    DriverInstallParams = A pointer to an SP_DRVINSTALL_PARAMS structure that specifies the new driver install parameters.
///Returns:
///    The function returns <b>TRUE</b> if it is successful. Otherwise, it returns <b>FALSE</b> and the logged error can
///    be retrieved by a call to GetLastError.
///    
@DllImport("SETUPAPI")
BOOL SetupDiSetDriverInstallParamsA(void* DeviceInfoSet, SP_DEVINFO_DATA* DeviceInfoData, 
                                    SP_DRVINFO_DATA_V2_A* DriverInfoData, SP_DRVINSTALL_PARAMS* DriverInstallParams);

///The <b>SetupDiSetDriverInstallParams</b> function sets driver installation parameters for a driver information
///element.
///Params:
///    DeviceInfoSet = A handle to a device information set that contains a driver information element that represents the driver for
///                    which to set installation parameters.
///    DeviceInfoData = A pointer to an SP_DEVINFO_DATA structure that specifies a device information element in <i>DeviceInfoSet</i>.
///                     This parameter is optional and can be set to <b>NULL</b>. If this parameter is specified,
///                     <b>SetupDiSetDriverInstallParams</b> sets the driver installation parameters for the specified device. If this
///                     parameter is <b>NULL</b>, <b>SetupDiSetDriverInstallParams</b> sets driver installation parameters for
///                     <i>DeviceInfoSet</i>.
///    DriverInfoData = A pointer to an SP_DRVINFO_DATA structure that specifies the driver for which installation parameters are set. If
///                     <i>DeviceInfoData</i> is specified, this driver must be a member of a driver list that is associated with
///                     <i>DeviceInfoData</i>. If <i>DeviceInfoData</i> is <b>NULL</b>, this driver must be a member of the global class
///                     driver list for <i>DeviceInfoSet</i>.
///    DriverInstallParams = A pointer to an SP_DRVINSTALL_PARAMS structure that specifies the new driver install parameters.
///Returns:
///    The function returns <b>TRUE</b> if it is successful. Otherwise, it returns <b>FALSE</b> and the logged error can
///    be retrieved by a call to GetLastError.
///    
@DllImport("SETUPAPI")
BOOL SetupDiSetDriverInstallParamsW(void* DeviceInfoSet, SP_DEVINFO_DATA* DeviceInfoData, 
                                    SP_DRVINFO_DATA_V2_W* DriverInfoData, SP_DRVINSTALL_PARAMS* DriverInstallParams);

///The <b>SetupDiLoadClassIcon</b> function loads both the large and mini-icon for the specified class.
///Params:
///    ClassGuid = A pointer to the GUID of the class for which the icon(s) should be loaded.
///    LargeIcon = A pointer to an icon handle that receives the handle value for the loaded large icon for the specified class.
///                This pointer is optional and can be <b>NULL</b>. If the pointer is <b>NULL</b>, the large icon is not loaded.
///    MiniIconIndex = A pointer to an INT-typed variable that receives the index of the mini-icon for the specified class. The
///                    mini-icon is stored in the device installer's mini-icon cache. The pointer is optional and can be <b>NULL</b>.
///Returns:
///    The function returns <b>TRUE</b> if it is successful. Otherwise, it returns <b>FALSE</b> and the logged error can
///    be retrieved by a call to GetLastError.
///    
@DllImport("SETUPAPI")
BOOL SetupDiLoadClassIcon(const(GUID)* ClassGuid, HICON* LargeIcon, int* MiniIconIndex);

///The <b>SetupDiLoadDeviceIcon</b> function retrieves an icon for a specified device.
///Params:
///    DeviceInfoSet = A handle to the device information set that contains the device information element that represents the device
///                    for which to retrieve an icon.
///    DeviceInfoData = A pointer to an SP_DEVINFO_DATA structure that specifies the device information element in <i>DeviceInfoSet</i>.
///    cxIcon = The width, in pixels, of the icon to be retrieved. Use the system metric index SM_CXICON to specify a
///             default-sized icon or use the system metric index SM_CXSMICON to specify a small icon. The system metric indexes
///             are defined in <i>Winuser.h</i>, and their associated values can be retrieved by a call to the GetSystemMetrics
///             function. (The <b>GetSystemMetrics</b> function is documented in the Microsoft Windows SDK.)
///    cyIcon = The height, in pixels, of the icon to be retrieved. Use SM_CXICON to specify a default-sized icon or use
///             SM_CXSMICON to specify a small icon.
///    Flags = Not used. Must set to zero.
///    hIcon = A pointer to a handle to an icon that receives a handle to the icon that this function retrieves. After the
///            application that calls this function is finished using the icon, the application must call DestroyIcon to delete
///            the icon. (<b>DestroyIcon</b> is documented in the Microsoft Windows SDK.)
///Returns:
///    <b>SetupDiLoadDeviceIcon</b> returns <b>TRUE</b> if the function succeeds in retrieving the icon for the
///    specified device. Otherwise, the function returns <b>FALSE</b> and the logged error can be retrieved by a call to
///    GetLastError.
///    
@DllImport("SETUPAPI")
BOOL SetupDiLoadDeviceIcon(void* DeviceInfoSet, SP_DEVINFO_DATA* DeviceInfoData, uint cxIcon, uint cyIcon, 
                           uint Flags, HICON* hIcon);

///The <b>SetupDiDrawMiniIcon</b> function draws the specified mini-icon at the location requested.
///Params:
///    hdc = The handle to the device context in which the mini-icon will be drawn.
///    rc = The rectangle in the specified device context handle to draw the mini-icon in.
///    MiniIconIndex = The index of the mini-icon, as retrieved from SetupDiLoadClassIcon or SetupDiGetClassBitmapIndex. The following
///                    predefined indexes for devices can be used: <table> <tr> <th> Class</th> <th>Index</th> </tr> <tr> <td>
///                    Computer/System </td> <td> 0 </td> </tr> <tr> <td> Display/Monitor </td> <td> 2 </td> </tr> <tr> <td> Network
///                    Adapter </td> <td> 3 </td> </tr> <tr> <td> Mouse </td> <td> 5 </td> </tr> <tr> <td> Keyboard </td> <td> 6 </td>
///                    </tr> <tr> <td> Sound </td> <td> 8 </td> </tr> <tr> <td> FDC/HDC </td> <td> 9 </td> </tr> <tr> <td> Ports </td>
///                    <td> 10 </td> </tr> <tr> <td> Printer </td> <td> 14 </td> </tr> <tr> <td> Network Transport </td> <td> 15 </td>
///                    </tr> <tr> <td> Network Client </td> <td> 16 </td> </tr> <tr> <td> Network Service </td> <td> 17 </td> </tr> <tr>
///                    <td> Unknown </td> <td> 18 </td> </tr> </table>
///    Flags = These flags control the drawing operation. The LOWORD contains the actual flags defined as follows:
///Returns:
///    This function returns the offset from the left side of <i>rc</i> where the string should start. If the draw
///    operation fails, the function returns zero.
///    
@DllImport("SETUPAPI")
int SetupDiDrawMiniIcon(HDC hdc, RECT rc, int MiniIconIndex, uint Flags);

///The <b>SetupDiGetClassBitmapIndex</b> function retrieves the index of the mini-icon supplied for the specified class.
///Params:
///    ClassGuid = A pointer to the GUID of the device setup class for which to retrieve the mini-icon. This pointer is optional and
///                can be <b>NULL</b>.
///    MiniIconIndex = A pointer to a variable of type INT that receives the index of the mini-icon for the specified device setup
///                    class. If the <i>ClassGuid</i> parameter is <b>NULL</b> or if there is no mini-icon for the specified class,
///                    <b>SetupDiGetClassBitmapIndex</b> returns the index of the mini-icon for the Unknown device setup class.
///Returns:
///    If there is a min-icon for the specified device setup class, <b>SetupDiGetClassBitmapIndex</b> returns
///    <b>TRUE</b>. Otherwise, this function returns <b>FALSE</b> and the logged error can be retrieved with a call to
///    GetLastError. If the <i>ClassGuid</i> parameter is <b>NULL</b>, or if there is no mini-icon for the specified
///    class, the function returns <b>FALSE</b> and GetLastError returns ERROR_NO_DEVICE_ICON.
///    
@DllImport("SETUPAPI")
BOOL SetupDiGetClassBitmapIndex(const(GUID)* ClassGuid, int* MiniIconIndex);

///The <b>SetupDiGetClassImageList</b> function builds an image list that contains bitmaps for every installed class and
///returns the list in a data structure.
///Params:
///    ClassImageListData = A pointer to an SP_CLASSIMAGELIST_DATA structure to receive information regarding the class image list, including
///                         a handle to the image list. The <b>cbSize</b> field of this structure must be initialized with the size of the
///                         structure, in bytes, before calling this function or it will fail.
///Returns:
///    The function returns <b>TRUE</b> if it is successful. Otherwise, it returns <b>FALSE</b> and the logged error can
///    be retrieved by a call to GetLastError.
///    
@DllImport("SETUPAPI")
BOOL SetupDiGetClassImageList(SP_CLASSIMAGELIST_DATA* ClassImageListData);

///The <b>SetupDiGetClassImageListEx</b> function builds an image list of bitmaps for every class installed on a local
///or remote system.
///Params:
///    ClassImageListData = A pointer to an SP_CLASSIMAGELIST_DATA structure to receive information regarding the class image list, including
///                         a handle to the image list. The <b>cbSize</b> field of this structure must be initialized with the size of the
///                         structure, in bytes, before calling this function or it will fail.
///    MachineName = A pointer to NULL-terminated string that supplies the name of a remote system for whose classes
///                  <b>SetupDiGetClassImageListEx must build </b>the bitmap. This parameter is optional and can be <b>NULL</b>. If
///                  <i>MachineName</i> is <b>NULL</b>, <b>SetupDiGetClassImageListEx</b> builds the list for the local system.
///    Reserved = Must be <b>NULL</b>.
///Returns:
///    The function returns <b>TRUE</b> if it is successful. Otherwise, it returns <b>FALSE</b> and the logged error can
///    be retrieved by a call to GetLastError.
///    
@DllImport("SETUPAPI")
BOOL SetupDiGetClassImageListExA(SP_CLASSIMAGELIST_DATA* ClassImageListData, const(char)* MachineName, 
                                 void* Reserved);

///The <b>SetupDiGetClassImageListEx</b> function builds an image list of bitmaps for every class installed on a local
///or remote system.
///Params:
///    ClassImageListData = A pointer to an SP_CLASSIMAGELIST_DATA structure to receive information regarding the class image list, including
///                         a handle to the image list. The <b>cbSize</b> field of this structure must be initialized with the size of the
///                         structure, in bytes, before calling this function or it will fail.
///    MachineName = A pointer to NULL-terminated string that supplies the name of a remote system for whose classes
///                  <b>SetupDiGetClassImageListEx must build </b>the bitmap. This parameter is optional and can be <b>NULL</b>. If
///                  <i>MachineName</i> is <b>NULL</b>, <b>SetupDiGetClassImageListEx</b> builds the list for the local system.
///    Reserved = Must be <b>NULL</b>.
///Returns:
///    The function returns <b>TRUE</b> if it is successful. Otherwise, it returns <b>FALSE</b> and the logged error can
///    be retrieved by a call to GetLastError.
///    
@DllImport("SETUPAPI")
BOOL SetupDiGetClassImageListExW(SP_CLASSIMAGELIST_DATA* ClassImageListData, const(wchar)* MachineName, 
                                 void* Reserved);

///The <b>SetupDiGetClassImageIndex</b> function retrieves the index within the class image list of a specified class.
///Params:
///    ClassImageListData = A pointer to an SP_CLASSIMAGELIST_DATA structure that describes a class image list that includes the image for
///                         the device setup class that is specified by the <i>ClassGuid</i> parameter.
///    ClassGuid = A pointer to the GUID of the device setup class for which to retrieve the index of the class image in the
///                specified class image list.
///    ImageIndex = A pointer to an INT-typed variable that receives the index of the specified class image in the class image list.
///Returns:
///    The function returns <b>TRUE</b> if it is successful. Otherwise, it returns <b>FALSE</b> and the logged error can
///    be retrieved by a call to GetLastError.
///    
@DllImport("SETUPAPI")
BOOL SetupDiGetClassImageIndex(SP_CLASSIMAGELIST_DATA* ClassImageListData, const(GUID)* ClassGuid, int* ImageIndex);

///The <b>SetupDiDestroyClassImageList</b> function destroys a class image list that was built by a call to
///SetupDiGetClassImageList or SetupDiGetClassImageListEx.
///Params:
///    ClassImageListData = A pointer to an SP_CLASSIMAGELIST_DATA structure that contains the class image list to destroy.
///Returns:
///    The function returns <b>TRUE</b> if it is successful. Otherwise, it returns <b>FALSE</b> and the logged error can
///    be retrieved by a call to GetLastError.
///    
@DllImport("SETUPAPI")
BOOL SetupDiDestroyClassImageList(SP_CLASSIMAGELIST_DATA* ClassImageListData);

///The <b>SetupDiGetClassDevPropertySheets</b> function retrieves handles to the property sheets of a device information
///element or of the device setup class of a device information set.
///Params:
///    DeviceInfoSet = A handle to the device information set for which to return property sheet handles. If <i>DeviceInfoData</i> does
///                    not specify a device information element in the device information set, the device information set must have an
///                    associated device setup class.
///    DeviceInfoData = A pointer to an SP_DEVINFO_DATA structure that specifies a device information element in DeviceInfoSet. This
///                     parameter is optional and can be <b>NULL</b>. If this parameter is specified,
///                     <b>SetupDiGetClassDevPropertySheets</b> retrieves the property sheets handles that are associated with the
///                     specified device. If this parameter is <b>NULL</b>, <b>SetupDiGetClassDevPropertySheets</b> retrieves the
///                     property sheets handles that are associated with the device setup class specified in <i>DeviceInfoSet</i>.
///    PropertySheetHeader = A pointer to a PROPERTYSHEETHEADER structure. See the <b>Remarks</b> section for information about the
///                          caller-supplied array of property sheet handles that is associated with this structure. For more documentation on
///                          this structure and property sheets in general, see the Microsoft Windows SDK.
///    PropertySheetHeaderPageListSize = The maximum number of handles that the caller-supplied array of property sheet handles can hold.
///    RequiredSize = A pointer to a variable of type DWORD that receives the number of property sheets that are associated with the
///                   specified device information element or the device setup class of the specified device information set. The
///                   pointer is optional and can be <b>NULL</b>.
///    PropertySheetType = A flag that indicates one of the following types of property sheets. <table> <tr> <th>Property sheet type</th>
///                        <th>Meaning</th> </tr> <tr> <td> DIGCDP_FLAG_ADVANCED </td> <td> Advanced property sheets. </td> </tr> <tr> <td>
///                        DIGCDP_FLAG_BASIC </td> <td> Basic property sheets. Supported only in Microsoft Windows 95 and Windows 98. Do not
///                        use in Windows 2000 and later versions of Windows. </td> </tr> <tr> <td> DIGCDP_FLAG_REMOTE_ADVANCED </td> <td>
///                        Advanced property sheets on a remote computer. </td> </tr> </table>
///Returns:
///    The function returns <b>TRUE</b> if successful. Otherwise, the function returns <b>FALSE</b>. Call GetLastError
///    to obtain the error code.
///    
@DllImport("SETUPAPI")
BOOL SetupDiGetClassDevPropertySheetsA(void* DeviceInfoSet, SP_DEVINFO_DATA* DeviceInfoData, 
                                       PROPSHEETHEADERA_V2* PropertySheetHeader, 
                                       uint PropertySheetHeaderPageListSize, uint* RequiredSize, 
                                       uint PropertySheetType);

///The <b>SetupDiGetClassDevPropertySheets</b> function retrieves handles to the property sheets of a device information
///element or of the device setup class of a device information set.
///Params:
///    DeviceInfoSet = A handle to the device information set for which to return property sheet handles. If <i>DeviceInfoData</i> does
///                    not specify a device information element in the device information set, the device information set must have an
///                    associated device setup class.
///    DeviceInfoData = A pointer to an SP_DEVINFO_DATA structure that specifies a device information element in DeviceInfoSet. This
///                     parameter is optional and can be <b>NULL</b>. If this parameter is specified,
///                     <b>SetupDiGetClassDevPropertySheets</b> retrieves the property sheets handles that are associated with the
///                     specified device. If this parameter is <b>NULL</b>, <b>SetupDiGetClassDevPropertySheets</b> retrieves the
///                     property sheets handles that are associated with the device setup class specified in <i>DeviceInfoSet</i>.
///    PropertySheetHeader = A pointer to a PROPERTYSHEETHEADER structure. See the <b>Remarks</b> section for information about the
///                          caller-supplied array of property sheet handles that is associated with this structure. For more documentation on
///                          this structure and property sheets in general, see the Microsoft Windows SDK.
///    PropertySheetHeaderPageListSize = The maximum number of handles that the caller-supplied array of property sheet handles can hold.
///    RequiredSize = A pointer to a variable of type DWORD that receives the number of property sheets that are associated with the
///                   specified device information element or the device setup class of the specified device information set. The
///                   pointer is optional and can be <b>NULL</b>.
///    PropertySheetType = A flag that indicates one of the following types of property sheets. <table> <tr> <th>Property sheet type</th>
///                        <th>Meaning</th> </tr> <tr> <td> DIGCDP_FLAG_ADVANCED </td> <td> Advanced property sheets. </td> </tr> <tr> <td>
///                        DIGCDP_FLAG_BASIC </td> <td> Basic property sheets. Supported only in Microsoft Windows 95 and Windows 98. Do not
///                        use in Windows 2000 and later versions of Windows. </td> </tr> <tr> <td> DIGCDP_FLAG_REMOTE_ADVANCED </td> <td>
///                        Advanced property sheets on a remote computer. </td> </tr> </table>
///Returns:
///    The function returns <b>TRUE</b> if successful. Otherwise, the function returns <b>FALSE</b>. Call GetLastError
///    to obtain the error code.
///    
@DllImport("SETUPAPI")
BOOL SetupDiGetClassDevPropertySheetsW(void* DeviceInfoSet, SP_DEVINFO_DATA* DeviceInfoData, 
                                       PROPSHEETHEADERW_V2* PropertySheetHeader, 
                                       uint PropertySheetHeaderPageListSize, uint* RequiredSize, 
                                       uint PropertySheetType);

///The <b>SetupDiAskForOEMDisk</b> function displays a dialog that asks the user for the path of an OEM installation
///disk.
///Params:
///    DeviceInfoSet = A handle to a device information set for the local computer. This set contains a device information element that
///                    represents the device that is being installed.
///    DeviceInfoData = A pointer to an SP_DEVINFO_DATA structure that specifies the device information element in <i>DeviceInfoSet</i>.
///                     This parameter is optional and can be <b>NULL</b>. If this parameter is specified, <b>SetupDiAskForOEMDisk</b>
///                     associates the driver with the device that is being installed. If this parameter is <b>NULL</b>,
///                     <b>SetupDiAskForOEMDisk</b> associates the driver with the global class driver list for <i>DeviceInfoSet</i>.
///Returns:
///    The function returns <b>TRUE</b> if it is successful and the <b>DriverPath</b> field of the SP_DEVINSTALLPARAMS
///    structure is updated to reflect the new path. If the user cancels the dialog, the function returns <b>FALSE</b>
///    and a call to GetLastError returns ERROR_CANCELLED.
///    
@DllImport("SETUPAPI")
BOOL SetupDiAskForOEMDisk(void* DeviceInfoSet, SP_DEVINFO_DATA* DeviceInfoData);

///The <b>SetupDiSelectOEMDrv</b> function selects a driver for a device information set or a particular device
///information element that uses an OEM path supplied by the user.
///Params:
///    hwndParent = A window handle that will be the parent of any dialogs created during the processing of this function. This
///                 parameter can be used to override the <b>hwndParent</b> field in the installation parameters block of the
///                 specified device information set or element.
///    DeviceInfoSet = A handle to the device information set for which to select a driver.
///    DeviceInfoData = A pointer to an SP_DEVINFO_DATA structure that specifies a device information element in <i>DeviceInfoSet</i>.
///                     This parameter is optional and can be <b>NULL</b>. If this parameter is specified, <b>SetupDiSelectOEMDrv</b>
///                     associates the selected driver with the specified device. If this parameter is <b>NULL</b>,
///                     <b>SetupDiSelectOEMDrv</b> associates the selected driver with the global class driver list for
///                     <i>DeviceInfoSet</i>.
///Returns:
///    The function returns <b>TRUE</b> if it is successful. Otherwise, it returns <b>FALSE</b> and the logged error can
///    be retrieved by a call to GetLastError.
///    
@DllImport("SETUPAPI")
BOOL SetupDiSelectOEMDrv(HWND hwndParent, void* DeviceInfoSet, SP_DEVINFO_DATA* DeviceInfoData);

///The <b>SetupDiClassNameFromGuid</b> function retrieves the class name associated with a class GUID.
///Params:
///    ClassGuid = A pointer to the class GUID for the class name to retrieve.
///    ClassName = A pointer to a buffer that receives the NULL-terminated string that contains the name of the class that is
///                specified by the pointer in the <i>ClassGuid</i> parameter.
///    ClassNameSize = The size, in characters, of the buffer that is pointed to by the <i>ClassName</i> parameter. The maximum size, in
///                    characters, of a NULL-terminated class name is MAX_CLASS_NAME_LEN. For more information about the class name
///                    size, see the following <b>Remarks</b> section.
///    RequiredSize = A pointer to a variable that receives the number of characters that are required to store the requested
///                   NULL-terminated class name. This pointer is optional and can be <b>NULL</b>.
///Returns:
///    The function returns <b>TRUE</b> if it is successful. Otherwise, it returns <b>FALSE</b> and the logged error can
///    be retrieved with a call to GetLastError.
///    
@DllImport("SETUPAPI")
BOOL SetupDiClassNameFromGuidA(const(GUID)* ClassGuid, const(char)* ClassName, uint ClassNameSize, 
                               uint* RequiredSize);

///The <b>SetupDiClassNameFromGuid</b> function retrieves the class name associated with a class GUID.
///Params:
///    ClassGuid = A pointer to the class GUID for the class name to retrieve.
///    ClassName = A pointer to a buffer that receives the NULL-terminated string that contains the name of the class that is
///                specified by the pointer in the <i>ClassGuid</i> parameter.
///    ClassNameSize = The size, in characters, of the buffer that is pointed to by the <i>ClassName</i> parameter. The maximum size, in
///                    characters, of a NULL-terminated class name is MAX_CLASS_NAME_LEN. For more information about the class name
///                    size, see the following <b>Remarks</b> section.
///    RequiredSize = A pointer to a variable that receives the number of characters that are required to store the requested
///                   NULL-terminated class name. This pointer is optional and can be <b>NULL</b>.
///Returns:
///    The function returns <b>TRUE</b> if it is successful. Otherwise, it returns <b>FALSE</b> and the logged error can
///    be retrieved with a call to GetLastError.
///    
@DllImport("SETUPAPI")
BOOL SetupDiClassNameFromGuidW(const(GUID)* ClassGuid, const(wchar)* ClassName, uint ClassNameSize, 
                               uint* RequiredSize);

///The <b>SetupDiClassNameFromGuidEx</b> function retrieves the class name associated with a class GUID. The class can
///be installed on a local or remote computer.
///Params:
///    ClassGuid = The class GUID of the class name to retrieve.
///    ClassName = A pointer to a string buffer that receives the NULL-terminated name of the class for the specified GUID.
///    ClassNameSize = The size, in characters, of the <i>ClassName</i> buffer.
///    RequiredSize = The number of characters required to store the class name (including a terminating null). <i>RequiredSize</i> is
///                   always less than MAX_CLASS_NAME_LEN.
///    MachineName = A pointer to a NULL-terminated string that contains the name of a remote system on which the class is installed.
///                  This parameter is optional and can be <b>NULL</b>. If <i>MachineName</i> is <b>NULL</b>, the local system name is
///                  used.
///    Reserved = Must be <b>NULL</b>.
///Returns:
///    The function returns <b>TRUE</b> if it is successful. Otherwise, it returns <b>FALSE</b> and the logged error can
///    be retrieved with a call to GetLastError.
///    
@DllImport("SETUPAPI")
BOOL SetupDiClassNameFromGuidExA(const(GUID)* ClassGuid, const(char)* ClassName, uint ClassNameSize, 
                                 uint* RequiredSize, const(char)* MachineName, void* Reserved);

///The <b>SetupDiClassNameFromGuidEx</b> function retrieves the class name associated with a class GUID. The class can
///be installed on a local or remote computer.
///Params:
///    ClassGuid = The class GUID of the class name to retrieve.
///    ClassName = A pointer to a string buffer that receives the NULL-terminated name of the class for the specified GUID.
///    ClassNameSize = The size, in characters, of the <i>ClassName</i> buffer.
///    RequiredSize = The number of characters required to store the class name (including a terminating null). <i>RequiredSize</i> is
///                   always less than MAX_CLASS_NAME_LEN.
///    MachineName = A pointer to a NULL-terminated string that contains the name of a remote system on which the class is installed.
///                  This parameter is optional and can be <b>NULL</b>. If <i>MachineName</i> is <b>NULL</b>, the local system name is
///                  used.
///    Reserved = Must be <b>NULL</b>.
///Returns:
///    The function returns <b>TRUE</b> if it is successful. Otherwise, it returns <b>FALSE</b> and the logged error can
///    be retrieved with a call to GetLastError.
///    
@DllImport("SETUPAPI")
BOOL SetupDiClassNameFromGuidExW(const(GUID)* ClassGuid, const(wchar)* ClassName, uint ClassNameSize, 
                                 uint* RequiredSize, const(wchar)* MachineName, void* Reserved);

///The <b>SetupDiClassGuidsFromName</b> function retrieves the GUID(s) associated with the specified class name. This
///list is built based on the classes currently installed on the system.
///Params:
///    ClassName = The name of the class for which to retrieve the class GUID.
///    ClassGuidList = A pointer to an array to receive the list of GUIDs associated with the specified class name.
///    ClassGuidListSize = The number of GUIDs in the <i>ClassGuidList</i> array.
///    RequiredSize = Supplies a pointer to a variable that receives the number of GUIDs associated with the class name. If this number
///                   is greater than the size of the <i>ClassGuidList</i> buffer, the number indicates how large the array must be in
///                   order to store all the GUIDs.
///Returns:
///    The function returns <b>TRUE</b> if it is successful. Otherwise, it returns <b>FALSE</b> and the logged error can
///    be retrieved by making a call to GetLastError.
///    
@DllImport("SETUPAPI")
BOOL SetupDiClassGuidsFromNameA(const(char)* ClassName, char* ClassGuidList, uint ClassGuidListSize, 
                                uint* RequiredSize);

///The <b>SetupDiClassGuidsFromName</b> function retrieves the GUID(s) associated with the specified class name. This
///list is built based on the classes currently installed on the system.
///Params:
///    ClassName = The name of the class for which to retrieve the class GUID.
///    ClassGuidList = A pointer to an array to receive the list of GUIDs associated with the specified class name.
///    ClassGuidListSize = The number of GUIDs in the <i>ClassGuidList</i> array.
///    RequiredSize = Supplies a pointer to a variable that receives the number of GUIDs associated with the class name. If this number
///                   is greater than the size of the <i>ClassGuidList</i> buffer, the number indicates how large the array must be in
///                   order to store all the GUIDs.
///Returns:
///    The function returns <b>TRUE</b> if it is successful. Otherwise, it returns <b>FALSE</b> and the logged error can
///    be retrieved by making a call to GetLastError.
///    
@DllImport("SETUPAPI")
BOOL SetupDiClassGuidsFromNameW(const(wchar)* ClassName, char* ClassGuidList, uint ClassGuidListSize, 
                                uint* RequiredSize);

///The <b>SetupDiClassGuidsFromNameEx</b> function retrieves the GUIDs associated with the specified class name. This
///resulting list contains the classes currently installed on a local or remote computer.
///Params:
///    ClassName = The name of the class for which to retrieve the class GUIDs.
///    ClassGuidList = A pointer to an array to receive the list of GUIDs associated with the specified class name.
///    ClassGuidListSize = The number of GUIDs in the <i>ClassGuidList</i> array.
///    RequiredSize = A pointer to a variable that receives the number of GUIDs associated with the class name. If this number is
///                   greater than the size of the <i>ClassGuidList</i> buffer, the number indicates how large the array must be in
///                   order to store all the GUIDs.
///    MachineName = A pointer to a NULL-terminated string that contains the name of a remote system from which to retrieve the GUIDs.
///                  This parameter is optional and can be <b>NULL</b>. If <i>MachineName</i> is <b>NULL</b>, the local system name is
///                  used.
///    Reserved = Must be <b>NULL</b>.
///Returns:
///    The function returns <b>TRUE</b> if it is successful. Otherwise, it returns <b>FALSE</b> and the logged error can
///    be retrieved by making a call to GetLastError.
///    
@DllImport("SETUPAPI")
BOOL SetupDiClassGuidsFromNameExA(const(char)* ClassName, char* ClassGuidList, uint ClassGuidListSize, 
                                  uint* RequiredSize, const(char)* MachineName, void* Reserved);

///The <b>SetupDiClassGuidsFromNameEx</b> function retrieves the GUIDs associated with the specified class name. This
///resulting list contains the classes currently installed on a local or remote computer.
///Params:
///    ClassName = The name of the class for which to retrieve the class GUIDs.
///    ClassGuidList = A pointer to an array to receive the list of GUIDs associated with the specified class name.
///    ClassGuidListSize = The number of GUIDs in the <i>ClassGuidList</i> array.
///    RequiredSize = A pointer to a variable that receives the number of GUIDs associated with the class name. If this number is
///                   greater than the size of the <i>ClassGuidList</i> buffer, the number indicates how large the array must be in
///                   order to store all the GUIDs.
///    MachineName = A pointer to a NULL-terminated string that contains the name of a remote system from which to retrieve the GUIDs.
///                  This parameter is optional and can be <b>NULL</b>. If <i>MachineName</i> is <b>NULL</b>, the local system name is
///                  used.
///    Reserved = Must be <b>NULL</b>.
///Returns:
///    The function returns <b>TRUE</b> if it is successful. Otherwise, it returns <b>FALSE</b> and the logged error can
///    be retrieved by making a call to GetLastError.
///    
@DllImport("SETUPAPI")
BOOL SetupDiClassGuidsFromNameExW(const(wchar)* ClassName, char* ClassGuidList, uint ClassGuidListSize, 
                                  uint* RequiredSize, const(wchar)* MachineName, void* Reserved);

///The <b>SetupDiGetHwProfileFriendlyName</b> function retrieves the friendly name associated with a hardware profile
///ID.
///Params:
///    HwProfile = The hardware profile ID associated with the friendly name to retrieve. If this parameter is 0, the friendly name
///                for the current hardware profile is retrieved.
///    FriendlyName = A pointer to a string buffer to receive the friendly name.
///    FriendlyNameSize = The size, in characters, of the <i>FriendlyName</i> buffer.
///    RequiredSize = A pointer to a variable of type DWORD that receives the number of characters required to retrieve the friendly
///                   name (including a NULL terminator).
///Returns:
///    The function returns <b>TRUE</b> if it is successful. Otherwise, it returns <b>FALSE</b> and the logged error can
///    be retrieved by making a call to GetLastError.
///    
@DllImport("SETUPAPI")
BOOL SetupDiGetHwProfileFriendlyNameA(uint HwProfile, const(char)* FriendlyName, uint FriendlyNameSize, 
                                      uint* RequiredSize);

///The <b>SetupDiGetHwProfileFriendlyName</b> function retrieves the friendly name associated with a hardware profile
///ID.
///Params:
///    HwProfile = The hardware profile ID associated with the friendly name to retrieve. If this parameter is 0, the friendly name
///                for the current hardware profile is retrieved.
///    FriendlyName = A pointer to a string buffer to receive the friendly name.
///    FriendlyNameSize = The size, in characters, of the <i>FriendlyName</i> buffer.
///    RequiredSize = A pointer to a variable of type DWORD that receives the number of characters required to retrieve the friendly
///                   name (including a NULL terminator).
///Returns:
///    The function returns <b>TRUE</b> if it is successful. Otherwise, it returns <b>FALSE</b> and the logged error can
///    be retrieved by making a call to GetLastError.
///    
@DllImport("SETUPAPI")
BOOL SetupDiGetHwProfileFriendlyNameW(uint HwProfile, const(wchar)* FriendlyName, uint FriendlyNameSize, 
                                      uint* RequiredSize);

///The <b>SetupDiGetHwProfileFriendlyNameEx</b> function retrieves the friendly name associated with a hardware profile
///ID on a local or remote computer.
///Params:
///    HwProfile = Supplies the hardware profile ID associated with the friendly name to retrieve. If this parameter is 0, the
///                friendly name for the current hardware profile is retrieved.
///    FriendlyName = A pointer to a character buffer to receive the friendly name.
///    FriendlyNameSize = The size, in characters, of the <i>FriendlyName</i> buffer.
///    RequiredSize = A pointer to a variable to receive the number of characters required to store the friendly name (including a NULL
///                   terminator). This parameter is optional and can be <b>NULL</b>.
///    MachineName = A pointer to NULL-terminated string that contains the name of a remote computer on which the hardware profile ID
///                  resides. This parameter is optional and can be <b>NULL</b>. If <i>MachineName</i> is <b>NULL</b>, the hardware
///                  profile ID is on the local computer.
///    Reserved = Must be <b>NULL</b>.
///Returns:
///    The function returns <b>TRUE</b> if it is successful. Otherwise, it returns <b>FALSE</b> and the logged error can
///    be retrieved by making a call to GetLastError.
///    
@DllImport("SETUPAPI")
BOOL SetupDiGetHwProfileFriendlyNameExA(uint HwProfile, const(char)* FriendlyName, uint FriendlyNameSize, 
                                        uint* RequiredSize, const(char)* MachineName, void* Reserved);

///The <b>SetupDiGetHwProfileFriendlyNameEx</b> function retrieves the friendly name associated with a hardware profile
///ID on a local or remote computer.
///Params:
///    HwProfile = Supplies the hardware profile ID associated with the friendly name to retrieve. If this parameter is 0, the
///                friendly name for the current hardware profile is retrieved.
///    FriendlyName = A pointer to a character buffer to receive the friendly name.
///    FriendlyNameSize = The size, in characters, of the <i>FriendlyName</i> buffer.
///    RequiredSize = A pointer to a variable to receive the number of characters required to store the friendly name (including a NULL
///                   terminator). This parameter is optional and can be <b>NULL</b>.
///    MachineName = A pointer to NULL-terminated string that contains the name of a remote computer on which the hardware profile ID
///                  resides. This parameter is optional and can be <b>NULL</b>. If <i>MachineName</i> is <b>NULL</b>, the hardware
///                  profile ID is on the local computer.
///    Reserved = Must be <b>NULL</b>.
///Returns:
///    The function returns <b>TRUE</b> if it is successful. Otherwise, it returns <b>FALSE</b> and the logged error can
///    be retrieved by making a call to GetLastError.
///    
@DllImport("SETUPAPI")
BOOL SetupDiGetHwProfileFriendlyNameExW(uint HwProfile, const(wchar)* FriendlyName, uint FriendlyNameSize, 
                                        uint* RequiredSize, const(wchar)* MachineName, void* Reserved);

@DllImport("SETUPAPI")
HPROPSHEETPAGE SetupDiGetWizardPage(void* DeviceInfoSet, SP_DEVINFO_DATA* DeviceInfoData, 
                                    SP_INSTALLWIZARD_DATA* InstallWizardData, uint PageType, uint Flags);

///The <b>SetupDiGetSelectedDevice</b> function retrieves the selected device information element in a device
///information set.
///Params:
///    DeviceInfoSet = A handle to the device information set for which to retrieve the selected device information element.
///    DeviceInfoData = A pointer to an SP_DEVINFO_DATA structure that receives information about the selected device information element
///                     for <i>DeviceInfoSet</i>. The caller must set <i>DeviceInfoData.</i><b>cbSize</b> to
///                     <b>sizeof</b>(SP_DEVINFO_DATA). If a device is currently not selected, the function fails and a call to
///                     GetLastError returns ERROR_NO_DEVICE_SELECTED.
///Returns:
///    The function returns <b>TRUE</b> if it is successful. Otherwise, it returns <b>FALSE</b> and the logged error can
///    be retrieved with a call to GetLastError.
///    
@DllImport("SETUPAPI")
BOOL SetupDiGetSelectedDevice(void* DeviceInfoSet, SP_DEVINFO_DATA* DeviceInfoData);

///The <b>SetupDiSetSelectedDevice</b> function sets a device information element as the selected member of a device
///information set. This function is typically used by an installation wizard.
///Params:
///    DeviceInfoSet = A handle to the device information set that contains the device information element to set as the selected member
///                    of the device information set.
///    DeviceInfoData = A pointer to an SP_DEVINFO_DATA structure that specifies the device information element in <i>DeviceInfoSet</i>
///                     to set as the selected member of <i>DeviceInfoSet</i>.
///Returns:
///    The function returns <b>TRUE</b> if it is successful. Otherwise, it returns <b>FALSE</b> and the logged error can
///    be retrieved with a call to GetLastError.
///    
@DllImport("SETUPAPI")
BOOL SetupDiSetSelectedDevice(void* DeviceInfoSet, SP_DEVINFO_DATA* DeviceInfoData);

///The <b>SetupDiGetActualModelsSection</b> function retrieves the appropriate decorated INF Models section to use when
///installing a device from a device INF file.
///Params:
///    Context = A pointer to an INF file context that specifies a <i>manufacturer-identifier</i> entry in an INF Manufacturer
///              section of an INF file. The <i>manufacturer-identifier</i> entry specifies an INF <i>Models</i> section name and
///              optionally specifies <i>TargetOSVersion</i> decorations for the <i>Models</i> section name. For information about
///              INF files and an INF file context, see the Platform SDK topics on using INF files and the INFCONTEXT structure.
///    AlternatePlatformInfo = A pointer to an SP_ALTPLATFORM_INFO structure that supplies information about a Windows version and processor
///                            architecture. The <b>cbSize</b> member of this structure must be set to
///                            <b>sizeof(</b>SP_ALTPLATFORM_INFO_V2<b>)</b>. This parameter is optional and can be set to <b>NULL</b>.
///    InfSectionWithExt = A pointer to a buffer that receives a string that contains the decorated INF <i>Models</i> section name and a
///                        NULL terminator. If <i>AlternatePlatformInfo</i> is not supplied, the decorated INF <i>Models</i> section name
///                        applies to the current platform; otherwise the name applies to the specified alternative platform. This parameter
///                        is optional and can be set to <b>NULL</b>. If this parameter is <b>NULL</b>, the function returns <b>TRUE</b> and
///                        sets <i>RequiredSize</i> to the size, in characters, that is required to return the decorated <i>Models</i>
///                        section name and a terminating NULL character.
///    InfSectionWithExtSize = The size, in characters, of the <i>DecoratedModelsSection </i>buffer. If <i>DecoratedModelsSection</i> is
///                            <b>NULL</b>, this parameter must be set to zero.
///    RequiredSize = A pointer to a DWORD-type variable that receives the size, in characters, of the <i>DecoratedModelsSection</i>
///                   buffer that is required to retrieve the decorated <i>Models</i> section name and a terminating NULL character.
///                   This parameter is optional and can be set to <b>NULL</b>.
///    Reserved = Reserved for internal system use. This parameter must be set to <b>NULL</b>.
///Returns:
///    <b>SetupDiGetActualModelsSection</b> returns <b>TRUE</b> if the operation succeeds. Otherwise, the function
///    returns <b>FALSE</b> and the logged error can be retrieved with a call to GetLastError.
///    
@DllImport("SETUPAPI")
BOOL SetupDiGetActualModelsSectionA(INFCONTEXT* Context, SP_ALTPLATFORM_INFO_V2* AlternatePlatformInfo, 
                                    const(char)* InfSectionWithExt, uint InfSectionWithExtSize, uint* RequiredSize, 
                                    void* Reserved);

///The <b>SetupDiGetActualModelsSection</b> function retrieves the appropriate decorated INF Models section to use when
///installing a device from a device INF file.
///Params:
///    Context = A pointer to an INF file context that specifies a <i>manufacturer-identifier</i> entry in an INF Manufacturer
///              section of an INF file. The <i>manufacturer-identifier</i> entry specifies an INF <i>Models</i> section name and
///              optionally specifies <i>TargetOSVersion</i> decorations for the <i>Models</i> section name. For information about
///              INF files and an INF file context, see the Platform SDK topics on using INF files and the INFCONTEXT structure.
///    AlternatePlatformInfo = A pointer to an SP_ALTPLATFORM_INFO structure that supplies information about a Windows version and processor
///                            architecture. The <b>cbSize</b> member of this structure must be set to
///                            <b>sizeof(</b>SP_ALTPLATFORM_INFO_V2<b>)</b>. This parameter is optional and can be set to <b>NULL</b>.
///    InfSectionWithExt = A pointer to a buffer that receives a string that contains the decorated INF <i>Models</i> section name and a
///                        NULL terminator. If <i>AlternatePlatformInfo</i> is not supplied, the decorated INF <i>Models</i> section name
///                        applies to the current platform; otherwise the name applies to the specified alternative platform. This parameter
///                        is optional and can be set to <b>NULL</b>. If this parameter is <b>NULL</b>, the function returns <b>TRUE</b> and
///                        sets <i>RequiredSize</i> to the size, in characters, that is required to return the decorated <i>Models</i>
///                        section name and a terminating NULL character.
///    InfSectionWithExtSize = The size, in characters, of the <i>DecoratedModelsSection </i>buffer. If <i>DecoratedModelsSection</i> is
///                            <b>NULL</b>, this parameter must be set to zero.
///    RequiredSize = A pointer to a DWORD-type variable that receives the size, in characters, of the <i>DecoratedModelsSection</i>
///                   buffer that is required to retrieve the decorated <i>Models</i> section name and a terminating NULL character.
///                   This parameter is optional and can be set to <b>NULL</b>.
///    Reserved = Reserved for internal system use. This parameter must be set to <b>NULL</b>.
///Returns:
///    <b>SetupDiGetActualModelsSection</b> returns <b>TRUE</b> if the operation succeeds. Otherwise, the function
///    returns <b>FALSE</b> and the logged error can be retrieved with a call to GetLastError.
///    
@DllImport("SETUPAPI")
BOOL SetupDiGetActualModelsSectionW(INFCONTEXT* Context, SP_ALTPLATFORM_INFO_V2* AlternatePlatformInfo, 
                                    const(wchar)* InfSectionWithExt, uint InfSectionWithExtSize, uint* RequiredSize, 
                                    void* Reserved);

///The <b>SetupDiGetActualSectionToInstall</b> function retrieves the appropriate INF DDInstall section to use when
///installing a device from a device INF file on a local computer.
///Params:
///    InfHandle = The handle to the INF file that contains the <i>DDInstall</i> section.
///    InfSectionName = A pointer to the <i>DDInstall</i> section name (as specified in an INF Models section). The maximum length of the
///                     section name, in characters, is 254.
///    InfSectionWithExt = A pointer to a character buffer to receive the <i>DDInstall</i> section name, its platform extension, and a NULL
///                        terminator. This is the decorated section name that should be used for installation. If this parameter is
///                        <b>NULL</b>, <i>InfSectionWithExtSize</i> must be zero. If this parameter is <b>NULL</b>, the function returns
///                        <b>TRUE</b> and sets <i>RequiredSize</i> to the size, in characters, that is required to return the
///                        <i>DDInstall</i> section name, its platform extension, and a terminating NULL character.
///    InfSectionWithExtSize = The size, in characters, of the <i>InfSectionWithExt</i> buffer. If <i>InfSectionWithExt</i> is <b>NULL</b>, this
///                            parameter must be zero.
///    RequiredSize = A pointer to the variable that receives the size, in characters, that is required to return the <i>DDInstall</i>
///                   section name, the platform extension, and a terminating NULL character.
///    Extension = A pointer to a variable that receives a pointer to the '.' character that marks the start of the extension in the
///                <i>InfSectionWithExt</i> buffer. If the <i>InfSectionWithExt</i> buffer is not supplied or is too small, this
///                parameter is not set. Set this parameter to <b>NULL</b> if a pointer to the extension is not required.
///Returns:
///    If the function is successful, it returns <b>TRUE</b>. If the function fails, it returns <b>FALSE</b>. To get
///    extended error information, call GetLastError.
///    
@DllImport("SETUPAPI")
BOOL SetupDiGetActualSectionToInstallA(void* InfHandle, const(char)* InfSectionName, 
                                       const(char)* InfSectionWithExt, uint InfSectionWithExtSize, 
                                       uint* RequiredSize, byte** Extension);

///The <b>SetupDiGetActualSectionToInstall</b> function retrieves the appropriate INF DDInstall section to use when
///installing a device from a device INF file on a local computer.
///Params:
///    InfHandle = The handle to the INF file that contains the <i>DDInstall</i> section.
///    InfSectionName = A pointer to the <i>DDInstall</i> section name (as specified in an INF Models section). The maximum length of the
///                     section name, in characters, is 254.
///    InfSectionWithExt = A pointer to a character buffer to receive the <i>DDInstall</i> section name, its platform extension, and a NULL
///                        terminator. This is the decorated section name that should be used for installation. If this parameter is
///                        <b>NULL</b>, <i>InfSectionWithExtSize</i> must be zero. If this parameter is <b>NULL</b>, the function returns
///                        <b>TRUE</b> and sets <i>RequiredSize</i> to the size, in characters, that is required to return the
///                        <i>DDInstall</i> section name, its platform extension, and a terminating NULL character.
///    InfSectionWithExtSize = The size, in characters, of the <i>InfSectionWithExt</i> buffer. If <i>InfSectionWithExt</i> is <b>NULL</b>, this
///                            parameter must be zero.
///    RequiredSize = A pointer to the variable that receives the size, in characters, that is required to return the <i>DDInstall</i>
///                   section name, the platform extension, and a terminating NULL character.
///    Extension = A pointer to a variable that receives a pointer to the '.' character that marks the start of the extension in the
///                <i>InfSectionWithExt</i> buffer. If the <i>InfSectionWithExt</i> buffer is not supplied or is too small, this
///                parameter is not set. Set this parameter to <b>NULL</b> if a pointer to the extension is not required.
///Returns:
///    If the function is successful, it returns <b>TRUE</b>. If the function fails, it returns <b>FALSE</b>. To get
///    extended error information, call GetLastError.
///    
@DllImport("SETUPAPI")
BOOL SetupDiGetActualSectionToInstallW(void* InfHandle, const(wchar)* InfSectionName, 
                                       const(wchar)* InfSectionWithExt, uint InfSectionWithExtSize, 
                                       uint* RequiredSize, ushort** Extension);

///The <b>SetupDiGetActualSectionToInstallEx</b> function retrieves the name of the INF DDInstall section that installs
///a device for a specified operating system and processor architecture.
///Params:
///    InfHandle = A handle to the INF file that contains the <i>DDInstall</i> section.
///    InfSectionName = A pointer to the <i>DDInstall</i> section name (as specified in an INF Models section). The maximum length of the
///                     section name, in characters, is 254.
///    AlternatePlatformInfo = A pointer, if non-<b>NULL</b>, to an SP_ALTPLATFORM_INFO structure. This structure is used to specify an
///                            operating system and processor architecture that is different from that on the local computer. To return the
///                            <i>DDInstall </i>section name for the local computer, set this parameter to <b>NULL</b>. Otherwise, provide an
///                            SP_ALTPLATFORM structure and set its members as follows:
///    InfSectionWithExt = A pointer to a character buffer to receive the <i>DDInstall</i> section name, its platform extension, and a NULL
///                        terminator. This is the decorated section name that should be used for installation. If this parameter is
///                        <b>NULL</b>, the function returns <b>TRUE</b> and sets <i>RequiredSize</i> to the size, in characters, that is
///                        required to return the <i>DDInstall</i> section name, its platform extension, and a terminating NULL character.
///    InfSectionWithExtSize = The size, in characters, of the buffer that is pointed to by the <i>InfSectionWithExt</i> parameter. The maximum
///                            length of a NULL-terminated INF section name, in characters, is MAX_INF_SECTION_NAME_LENGTH.
///    RequiredSize = A pointer to the variable that receives the size, in characters, that is required to return the <i>DDInstall</i>
///                   section name, the platform extension, and a terminating NULL character.
///    Extension = A pointer to a variable that receives a pointer to the '.' character that marks the start of the extension in the
///                <i>InfSectionWithExt</i> buffer. If the <i>InfSectionWithExt</i> buffer is not supplied or is too small, this
///                parameter is not set. Set this parameter to <b>NULL</b> if a pointer to the extension is not required.
///    Reserved = Reserved for internal use only. Must be set to <b>NULL</b>.
///Returns:
///    If the function is successful, it returns <b>TRUE</b>. Otherwise, it returns <b>FALSE</b>. To get extended error
///    information, call GetLastError.
///    
@DllImport("SETUPAPI")
BOOL SetupDiGetActualSectionToInstallExA(void* InfHandle, const(char)* InfSectionName, 
                                         SP_ALTPLATFORM_INFO_V2* AlternatePlatformInfo, 
                                         const(char)* InfSectionWithExt, uint InfSectionWithExtSize, 
                                         uint* RequiredSize, byte** Extension, void* Reserved);

///The <b>SetupDiGetActualSectionToInstallEx</b> function retrieves the name of the INF DDInstall section that installs
///a device for a specified operating system and processor architecture.
///Params:
///    InfHandle = A handle to the INF file that contains the <i>DDInstall</i> section.
///    InfSectionName = A pointer to the <i>DDInstall</i> section name (as specified in an INF Models section). The maximum length of the
///                     section name, in characters, is 254.
///    AlternatePlatformInfo = A pointer, if non-<b>NULL</b>, to an SP_ALTPLATFORM_INFO structure. This structure is used to specify an
///                            operating system and processor architecture that is different from that on the local computer. To return the
///                            <i>DDInstall </i>section name for the local computer, set this parameter to <b>NULL</b>. Otherwise, provide an
///                            SP_ALTPLATFORM structure and set its members as follows:
///    InfSectionWithExt = A pointer to a character buffer to receive the <i>DDInstall</i> section name, its platform extension, and a NULL
///                        terminator. This is the decorated section name that should be used for installation. If this parameter is
///                        <b>NULL</b>, the function returns <b>TRUE</b> and sets <i>RequiredSize</i> to the size, in characters, that is
///                        required to return the <i>DDInstall</i> section name, its platform extension, and a terminating NULL character.
///    InfSectionWithExtSize = The size, in characters, of the buffer that is pointed to by the <i>InfSectionWithExt</i> parameter. The maximum
///                            length of a NULL-terminated INF section name, in characters, is MAX_INF_SECTION_NAME_LENGTH.
///    RequiredSize = A pointer to the variable that receives the size, in characters, that is required to return the <i>DDInstall</i>
///                   section name, the platform extension, and a terminating NULL character.
///    Extension = A pointer to a variable that receives a pointer to the '.' character that marks the start of the extension in the
///                <i>InfSectionWithExt</i> buffer. If the <i>InfSectionWithExt</i> buffer is not supplied or is too small, this
///                parameter is not set. Set this parameter to <b>NULL</b> if a pointer to the extension is not required.
///    Reserved = Reserved for internal use only. Must be set to <b>NULL</b>.
///Returns:
///    If the function is successful, it returns <b>TRUE</b>. Otherwise, it returns <b>FALSE</b>. To get extended error
///    information, call GetLastError.
///    
@DllImport("SETUPAPI")
BOOL SetupDiGetActualSectionToInstallExW(void* InfHandle, const(wchar)* InfSectionName, 
                                         SP_ALTPLATFORM_INFO_V2* AlternatePlatformInfo, 
                                         const(wchar)* InfSectionWithExt, uint InfSectionWithExtSize, 
                                         uint* RequiredSize, ushort** Extension, void* Reserved);

///The <b>SetupDiGetCustomDeviceProperty</b> function retrieves a specified custom device property from the registry.
///Params:
///    DeviceInfoSet = A handle to the device information set that contains a device information element that represents the device for
///                    which to retrieve a custom device property.
///    DeviceInfoData = A pointer to an SP_DEVINFO_DATA structure that specifies the device information element in <i>DeviceInfoSet</i>.
///    CustomPropertyName = A registry value name representing a custom property.
///    Flags = A flag value that indicates how the requested information should be returned. The flag can be zero or one of the
///            following:
///    PropertyRegDataType = A pointer to a variable of type DWORD that receives the data type of the retrieved property. The data type is
///                          specified as one of the REG_-prefixed constants that represents registry data types. This parameter is optional
///                          and can be <b>NULL</b>.
///    PropertyBuffer = A pointer to a buffer that receives requested property information.
///    PropertyBufferSize = The size, in bytes, of the <i>PropertyBuffer </i>buffer.
///    RequiredSize = A pointer to a variable of type DWORD that receives the buffer size, in bytes, that is required to receive the
///                   requested information. This parameter is optional and can be <b>NULL</b>. If this parameter is specified,
///                   <b>SetupDiGetCustomDeviceProperty</b> returns the required size, regardless of whether the <i>PropertyBuffer</i>
///                   buffer is large enough to receive the requested information.
///Returns:
///    If the operation succeeds, <b>SetupDiGetCustomDeviceProperty</b> returns <b>TRUE</b>. Otherwise, the function
///    returns <b>FALSE</b> and the logged error can be retrieved with a call to GetLastError. If the <i>PropertyBuffer
///    </i>buffer is not large enough to receive the requested information, <b>SetupDiGetCustomDeviceProperty</b>
///    returns <b>FALSE</b> and a subsequent call to GetLastError will return ERROR_INSUFFICIENT_BUFFER.
///    
@DllImport("SETUPAPI")
BOOL SetupDiGetCustomDevicePropertyA(void* DeviceInfoSet, SP_DEVINFO_DATA* DeviceInfoData, 
                                     const(char)* CustomPropertyName, uint Flags, uint* PropertyRegDataType, 
                                     char* PropertyBuffer, uint PropertyBufferSize, uint* RequiredSize);

///The <b>SetupDiGetCustomDeviceProperty</b> function retrieves a specified custom device property from the registry.
///Params:
///    DeviceInfoSet = A handle to the device information set that contains a device information element that represents the device for
///                    which to retrieve a custom device property.
///    DeviceInfoData = A pointer to an SP_DEVINFO_DATA structure that specifies the device information element in <i>DeviceInfoSet</i>.
///    CustomPropertyName = A registry value name representing a custom property.
///    Flags = A flag value that indicates how the requested information should be returned. The flag can be zero or one of the
///            following:
///    PropertyRegDataType = A pointer to a variable of type DWORD that receives the data type of the retrieved property. The data type is
///                          specified as one of the REG_-prefixed constants that represents registry data types. This parameter is optional
///                          and can be <b>NULL</b>.
///    PropertyBuffer = A pointer to a buffer that receives requested property information.
///    PropertyBufferSize = The size, in bytes, of the <i>PropertyBuffer </i>buffer.
///    RequiredSize = A pointer to a variable of type DWORD that receives the buffer size, in bytes, that is required to receive the
///                   requested information. This parameter is optional and can be <b>NULL</b>. If this parameter is specified,
///                   <b>SetupDiGetCustomDeviceProperty</b> returns the required size, regardless of whether the <i>PropertyBuffer</i>
///                   buffer is large enough to receive the requested information.
///Returns:
///    If the operation succeeds, <b>SetupDiGetCustomDeviceProperty</b> returns <b>TRUE</b>. Otherwise, the function
///    returns <b>FALSE</b> and the logged error can be retrieved with a call to GetLastError. If the <i>PropertyBuffer
///    </i>buffer is not large enough to receive the requested information, <b>SetupDiGetCustomDeviceProperty</b>
///    returns <b>FALSE</b> and a subsequent call to GetLastError will return ERROR_INSUFFICIENT_BUFFER.
///    
@DllImport("SETUPAPI")
BOOL SetupDiGetCustomDevicePropertyW(void* DeviceInfoSet, SP_DEVINFO_DATA* DeviceInfoData, 
                                     const(wchar)* CustomPropertyName, uint Flags, uint* PropertyRegDataType, 
                                     char* PropertyBuffer, uint PropertyBufferSize, uint* RequiredSize);

///The <b>CM_Add_Empty_Log_Conf</b> function creates an empty logical configuration, for a specified configuration type
///and a specified device instance, on the local machine.
///Params:
///    plcLogConf = Address of a location to receive the handle to an empty logical configuration.
///    dnDevInst = Caller-supplied device instance handle that is bound to the local machine.
///    Priority = Caller-supplied configuration priority value. This must be one of the constant values listed in the following
///               table. The constants are listed in order of priority, from highest to lowest. (For multiple configurations with
///               the same <i>ulFlags</i> value, the system will attempt to use the one with the highest priority first.) <table>
///               <tr> <th>Priority Constant</th> <th>Definition</th> </tr> <tr> <td> LCPRI_FORCECONFIG </td> <td> Result of a
///               forced configuration. </td> </tr> <tr> <td> LCPRI_BOOTCONFIG </td> <td> Result of a boot configuration. </td>
///               </tr> <tr> <td> LCPRI_DESIRED </td> <td> Preferred configuration (better performance). </td> </tr> <tr> <td>
///               LCPRI_NORMAL </td> <td> Workable configuration (acceptable performance). </td> </tr> <tr> <td>
///               LCPRI_LASTBESTCONFIG </td> <td> <i>For internal use only.</i> </td> </tr> <tr> <td> LCPRI_SUBOPTIMAL </td> <td>
///               Not a desirable configuration, but it will work. </td> </tr> <tr> <td> LCPRI_LASTSOFTCONFIG </td> <td> <i>For
///               internal use only.</i> </td> </tr> <tr> <td> LCPRI_RESTART </td> <td> The system must be restarted </td> </tr>
///               <tr> <td> LCPRI_REBOOT </td> <td> The system must be restarted (same as LCPRI_RESTART). </td> </tr> <tr> <td>
///               LCPRI_POWEROFF </td> <td> The system must be shut down and powered off. </td> </tr> <tr> <td> LCPRI_HARDRECONFIG
///               </td> <td> A jumper must be changed. </td> </tr> <tr> <td> LCPRI_HARDWIRED </td> <td> The configuration cannot be
///               changed. </td> </tr> <tr> <td> LCPRI_IMPOSSIBLE </td> <td> The configuration cannot exist. </td> </tr> <tr> <td>
///               LCPRI_DISABLED </td> <td> Disabled configuration. </td> </tr> </table>
///    ulFlags = Caller-supplied flags that specify the type of the logical configuration. One of the following flags must be
///              specified. <table> <tr> <th>Configuration Type Flags</th> <th>Definitions</th> </tr> <tr> <td> BASIC_LOG_CONF
///              </td> <td> Resource descriptors added to this configuration will describe a basic configuration. </td> </tr> <tr>
///              <td> FILTERED_LOG_CONF </td> <td> <i>Do not use.</i> (Only the PnP manager can create a filtered configuration.)
///              </td> </tr> <tr> <td> ALLOC_LOG_CONF </td> <td> <i>Do not use.</i> (Only the PnP manager can create an allocated
///              configuration.) </td> </tr> <tr> <td> BOOT_LOG_CONF </td> <td> Resource descriptors added to this configuration
///              will describe a boot configuration. </td> </tr> <tr> <td> FORCED_LOG_CONF </td> <td> Resource descriptors added
///              to this configuration will describe a forced configuration. </td> </tr> <tr> <td> OVERRIDE_LOG_CONF </td> <td>
///              Resource descriptors added to this configuration will describe an override configuration. </td> </tr> </table>
///              One of the following bit flags can be ORed with the configuration type flag. <table> <tr> <th>Priority Comparison
///              Flags</th> <th>Definitions</th> </tr> <tr> <td> PRIORITY_EQUAL_FIRST </td> <td> If multiple configurations of the
///              same type (<i>ulFlags</i>) have the same priority (<i>Priority</i>), this configuration is placed at the head of
///              the list. </td> </tr> <tr> <td> PRIORITY_EQUAL_LAST </td> <td> (Default) If multiple configurations of the same
///              type (<i>ulFlags</i>) have the same priority (<i>Priority</i>), this configuration is placed at the tail of the
///              list. </td> </tr> </table>
///Returns:
///    If the operation succeeds, the function returns CR_SUCCESS. Otherwise, it returns one of the CR_-prefixed error
///    codes defined in <i>Cfgmgr32.h</i>. <div class="alert"><b>Note</b> Starting with Windows 8,
///    <b>CM_Add_Empty_Log_Conf</b> returns CR_CALL_NOT_IMPLEMENTED when used in a Wow64 scenario. To request
///    information about the hardware resources on a local machine it is necessary implement an architecture-native
///    version of the application using the hardware resource APIs. For example: An AMD64 application for AMD64
///    systems.</div> <div> </div>
///    
@DllImport("SETUPAPI")
uint CM_Add_Empty_Log_Conf(size_t* plcLogConf, uint dnDevInst, uint Priority, uint ulFlags);

///<p class="CCE_Message">[Beginning with Windows 8 and Windows Server 2012, this function has been deprecated. Please
///use CM_Add_Empty_Log_Conf instead.] The <b>CM_Add_Empty_Log_Conf_Ex</b> function creates an empty logical
///configuration, for a specified configuration type and a specified device instance, on either the local or a remote
///machine.
///Params:
///    plcLogConf = Pointer to a location to receive the handle to an empty logical configuration.
///    dnDevInst = Caller-supplied device instance handle that is bound to the machine handle supplied by <i>hMachine</i>.
///    Priority = Caller-supplied configuration priority value. For a list of values, see the <i>Priority</i> description for
///               CM_Add_Empty_Log_Conf.
///    ulFlags = Caller-supplied flags that specify the type of the logical configuration. For a list of flags, see the
///              description <i>ulFlags</i> description for CM_Add_Empty_Log_Conf.
///    hMachine = Caller-supplied machine handle to which the caller-supplied device instance handle is bound. <div
///               class="alert"><b>Note</b> Using this function to access remote machines is not supported beginning with Windows 8
///               and Windows Server 2012, as this functionality has been removed.</div> <div> </div>
///Returns:
///    If the operation succeeds, the function returns CR_SUCCESS. Otherwise, it returns one of the CR_-prefixed error
///    codes defined in <i>Cfgmgr32.h</i>. <div class="alert"><b>Note</b> Starting with Windows 8,
///    <b>CM_Add_Empty_Log_Conf_Ex</b> returns CR_CALL_NOT_IMPLEMENTED when used in a Wow64 scenario. To request
///    information about the hardware resources on a local machine it is necessary implement an architecture-native
///    version of the application using the hardware resource APIs. For example: An AMD64 application for AMD64
///    systems.</div> <div> </div>
///    
@DllImport("SETUPAPI")
uint CM_Add_Empty_Log_Conf_Ex(size_t* plcLogConf, uint dnDevInst, uint Priority, uint ulFlags, ptrdiff_t hMachine);

@DllImport("SETUPAPI")
uint CM_Add_IDA(uint dnDevInst, const(char)* pszID, uint ulFlags);

///The <b>CM_Add_ID</b> function appends a specified device ID (if not already present) to a device instance's hardware
///ID list or compatible ID list.
///Params:
///    dnDevInst = Caller-supplied device instance handle that is bound to the local machine.
///    pszID = Caller-supplied pointer to a NULL-terminated device ID string.
///    ulFlags = Caller-supplied flag constant that specifies the list onto which the supplied device ID should be appended. The
///              following flag constants are valid. <table> <tr> <th>Flag Constant</th> <th>Definition</th> </tr> <tr> <td>
///              CM_ADD_ID_COMPATIBLE </td> <td> The specified device ID should be appended to the specific device instance's
///              compatible ID list. </td> </tr> <tr> <td> CM_ADD_ID_HARDWARE </td> <td> The specified device ID should be
///              appended to the specific device instance's hardware ID list. </td> </tr> </table>
///Returns:
///    If the operation succeeds, the function returns CR_SUCCESS. Otherwise, it returns one of the CR_-prefixed error
///    codes defined in <i>Cfgmgr32.h</i>.
///    
@DllImport("SETUPAPI")
uint CM_Add_IDW(uint dnDevInst, const(wchar)* pszID, uint ulFlags);

@DllImport("SETUPAPI")
uint CM_Add_ID_ExA(uint dnDevInst, const(char)* pszID, uint ulFlags, ptrdiff_t hMachine);

///<p class="CCE_Message">[Beginning with Windows 8 and Windows Server 2012, this function has been deprecated. Please
///use CM_Add_ID instead.] The <b>CM_Add_ID_Ex</b> function appends a device ID (if not already present) to a device
///instance's hardware ID list or compatible ID list, on either the local or a remote machine.
///Params:
///    dnDevInst = Caller-supplied device instance handle that is bound to the machine handle supplied by <i>hMachine</i> .
///    pszID = Caller-supplied pointer to a NULL-terminated device ID string.
///    ulFlags = Caller-supplied flag constant that specifies the list onto which the supplied device ID should be appended. The
///              following flag constants are valid. <table> <tr> <th>Flag Constant</th> <th>Definition</th> </tr> <tr> <td>
///              CM_ADD_ID_COMPATIBLE </td> <td> The specified device ID should be appended to the specific device instance's
///              compatible ID list. </td> </tr> <tr> <td> CM_ADD_ID_HARDWARE </td> <td> The specified device ID should be
///              appended to the specific device instance's hardware ID list. </td> </tr> </table>
///    hMachine = Caller-supplied machine handle to which the caller-supplied device instance handle is bound. <div
///               class="alert"><b>Note</b> Using this function to access remote machines is not supported beginning with Windows 8
///               and Windows Server 2012, as this functionality has been removed.</div> <div> </div>
///Returns:
///    If the operation succeeds, the function returns CR_SUCCESS. Otherwise, it returns one of the CR_-prefixed error
///    codes defined in <i>Cfgmgr32.h</i>.
///    
@DllImport("SETUPAPI")
uint CM_Add_ID_ExW(uint dnDevInst, const(wchar)* pszID, uint ulFlags, ptrdiff_t hMachine);

@DllImport("SETUPAPI")
uint CM_Add_Range(ulong ullStartValue, ulong ullEndValue, size_t rlh, uint ulFlags);

///The <b>CM_Add_Res_Des</b> function adds a resource descriptor to a logical configuration.
///Params:
///    prdResDes = Pointer to a location to receive a handle to the new resource descriptor.
///    lcLogConf = Caller-supplied handle to the logical configuration to which the resource descriptor should be added. This handle
///                must have been previously obtained by calling one of the following functions: CM_Add_Empty_Log_Conf
///                CM_Add_Empty_Log_Conf_Ex CM_Get_First_Log_Conf CM_Get_First_Log_Conf_Ex CM_Get_Next_Log_Conf
///                CM_Get_Next_Log_Conf_Ex
///    ResourceID = Caller-supplied resource type identifier, which identifies the type of structure supplied by <i>ResourceData</i>.
///                 This must be one of the <b>ResType_</b>-prefixed constants defined in <i>Cfgmgr32.h</i>.
///    ResourceData = Caller-supplied pointer to one of the resource structures listed in the following table. <table> <tr>
///                   <th><i>ResourceID </i>Parameter</th> <th>Resource Structure</th> </tr> <tr> <td> <b>ResType_BusNumber</b> </td>
///                   <td> [BUSNUMBER_RESOURCE](/windows/desktop/api/cfgmgr32/ns-cfgmgr32-busnumber_resource) </td> </tr> <tr> <td>
///                   <b>ResType_ClassSpecific</b> </td> <td> [CS_RESOURCE](/windows/desktop/api/cfgmgr32/ns-cfgmgr32-cs_resource)
///                   </td> </tr> <tr> <td> <b>ResType_DevicePrivate</b> </td> <td> DEVPRIVATE_RESOURCE </td> </tr> <tr> <td>
///                   <b>ResType_DMA</b> </td> <td> [DMA_RESOURCE](/windows/desktop/api/cfgmgr32/ns-cfgmgr32-dma_resource) </td> </tr>
///                   <tr> <td> <b>ResType_IO</b> </td> <td> [IO_RESOURCE](/windows/desktop/api/cfgmgr32/ns-cfgmgr32-io_resource) </td>
///                   </tr> <tr> <td> <b>ResType_IRQ</b> </td> <td>
///                   [IRQ_RESOURCE](/windows/desktop/api/cfgmgr32/ns-cfgmgr32-irq_resource_32) </td> </tr> <tr> <td>
///                   <b>ResType_Mem</b> </td> <td> [MEM_RESOURCE](/windows/desktop/api/cfgmgr32/ns-cfgmgr32-mem_resource) </td> </tr>
///                   <tr> <td> <b>ResType_MfCardConfig</b> </td> <td>
///                   [MFCARD_RESOURCE](/windows/desktop/api/cfgmgr32/ns-cfgmgr32-mfcard_resource) </td> </tr> <tr> <td>
///                   <b>ResType_PcCardConfig</b> </td> <td>
///                   [PCCARD_RESOURCE](/windows/desktop/api/cfgmgr32/ns-cfgmgr32-pccard_resource) </td> </tr> </table>
///    ResourceLen = Caller-supplied length of the structure pointed to by <i>ResourceData</i>.
///    ulFlags = Not used, must be zero.
///Returns:
///    If the operation succeeds, the function returns CR_SUCCESS. Otherwise, it returns one of the CR_-prefixed error
///    codes defined in <i>Cfgmgr32.h</i>. <div class="alert"><b>Note</b> Starting with Windows 8, <b>CM_Add_Res_Des</b>
///    returns CR_CALL_NOT_IMPLEMENTED when used in a Wow64 scenario. To request information about the hardware
///    resources on a local machine it is necessary implement an architecture-native version of the application using
///    the hardware resource APIs. For example: An AMD64 application for AMD64 systems.</div> <div> </div>
///    
@DllImport("SETUPAPI")
uint CM_Add_Res_Des(size_t* prdResDes, size_t lcLogConf, uint ResourceID, char* ResourceData, uint ResourceLen, 
                    uint ulFlags);

///<p class="CCE_Message">[Beginning with Windows 8 and Windows Server 2012, this function has been deprecated. Please
///use CM_Add_Res_Des instead.] The <b>CM_Add_Res_Des_Ex</b> function adds a resource descriptor to a logical
///configuration. The logical configuration can be on either the local or a remote machine.
///Params:
///    prdResDes = Pointer to a location to receive a handle to the new resource descriptor.
///    lcLogConf = Caller-supplied handle to the logical configuration to which the resource descriptor should be added. This handle
///                must have been previously obtained by calling one of the following functions: CM_Add_Empty_Log_Conf
///                CM_Add_Empty_Log_Conf_Ex CM_Get_First_Log_Conf CM_Get_First_Log_Conf_Ex CM_Get_Next_Log_Conf
///                CM_Get_Next_Log_Conf_Ex
///    ResourceID = Caller-supplied resource type identifier, which identifies the type of structure supplied by <i>ResourceData</i>.
///                 This must be one of the <b>ResType_</b>-prefixed constants defined in <i>Cfgmgr32.h</i>.
///    ResourceData = Caller-supplied pointer to one of the resource structures listed in the following table. <table> <tr>
///                   <th><i>ResourceID </i>Parameter</th> <th>Resource Structure</th> </tr> <tr> <td> <b>ResType_BusNumber</b> </td>
///                   <td> [BUSNUMBER_RESOURCE](/windows/desktop/api/cfgmgr32/ns-cfgmgr32-busnumber_resource) </td> </tr> <tr> <td>
///                   <b>ResType_ClassSpecific</b> </td> <td> [CS_RESOURCE](/windows/desktop/api/cfgmgr32/ns-cfgmgr32-cs_resource)
///                   </td> </tr> <tr> <td> <b>ResType_DevicePrivate</b> </td> <td> DEVPRIVATE_RESOURCE </td> </tr> <tr> <td>
///                   <b>ResType_DMA</b> </td> <td> [DMA_RESOURCE](/windows/desktop/api/cfgmgr32/ns-cfgmgr32-dma_resource) </td> </tr>
///                   <tr> <td> <b>ResType_IO</b> </td> <td> [IO_RESOURCE](/windows/desktop/api/cfgmgr32/ns-cfgmgr32-io_resource) </td>
///                   </tr> <tr> <td> <b>ResType_IRQ</b> </td> <td>
///                   [IRQ_RESOURCE](/windows/desktop/api/cfgmgr32/ns-cfgmgr32-irq_resource_32) </td> </tr> <tr> <td>
///                   <b>ResType_Mem</b> </td> <td> [MEM_RESOURCE](/windows/desktop/api/cfgmgr32/ns-cfgmgr32-mem_resource) </td> </tr>
///                   <tr> <td> <b>ResType_MfCardConfig</b> </td> <td>
///                   [MFCARD_RESOURCE](/windows/desktop/api/cfgmgr32/ns-cfgmgr32-mfcard_resource) </td> </tr> <tr> <td>
///                   <b>ResType_PcCardConfig</b> </td> <td>
///                   [PCCARD_RESOURCE](/windows/desktop/api/cfgmgr32/ns-cfgmgr32-pccard_resource) </td> </tr> </table>
///    ResourceLen = Caller-supplied length of the structure pointed to by <i>ResourceData</i>.
///    ulFlags = Not used, must be zero.
///    hMachine = Caller-supplied machine handle, obtained from a previous call to CM_Connect_Machine, or <b>NULL</b>. <div
///               class="alert"><b>Note</b> Using this function to access remote machines is not supported beginning with Windows 8
///               and Windows Server 2012, as this functionality has been removed.</div> <div> </div>
///Returns:
///    If the operation succeeds, the function returns CR_SUCCESS. Otherwise, it returns one of the CR_-prefixed error
///    codes defined in <i>Cfgmgr32.h</i>. <div class="alert"><b>Note</b> Starting with Windows 8,
///    <b>CM_Add_Res_Des_Ex</b> returns CR_CALL_NOT_IMPLEMENTED when used in a Wow64 scenario. To request information
///    about the hardware resources on a local machine it is necessary implement an architecture-native version of the
///    application using the hardware resource APIs. For example: An AMD64 application for AMD64 systems.</div> <div>
///    </div>
///    
@DllImport("SETUPAPI")
uint CM_Add_Res_Des_Ex(size_t* prdResDes, size_t lcLogConf, uint ResourceID, char* ResourceData, uint ResourceLen, 
                       uint ulFlags, ptrdiff_t hMachine);

@DllImport("SETUPAPI")
uint CM_Connect_MachineA(const(char)* UNCServerName, ptrdiff_t* phMachine);

///<p class="CCE_Message">[Beginning in Windows 8 and Windows Server 2012 functionality to access remote machines has
///been removed. You cannot access remote machines when running on these versions of Windows.] The
///<b>CM_Connect_Machine</b> function creates a connection to a remote machine.
///Params:
///    UNCServerName = Caller-supplied pointer to a text string representing the UNC name, including the <b>\\</b> prefix, of the system
///                    for which a connection will be made. If the pointer is <b>NULL</b>, the local system is used.
///    phMachine = Address of a location to receive a machine handle. <div class="alert"><b>Note</b> Using this function to access
///                remote machines is not supported beginning with Windows 8 and Windows Server 2012, as this functionality has been
///                removed.</div> <div> </div>
///Returns:
///    If the operation succeeds, the function returns CR_SUCCESS. Otherwise, it returns one of the CR_-prefixed error
///    codes defined in <i>Cfgmgr32.h</i>.
///    
@DllImport("SETUPAPI")
uint CM_Connect_MachineW(const(wchar)* UNCServerName, ptrdiff_t* phMachine);

@DllImport("SETUPAPI")
uint CM_Create_DevNodeA(uint* pdnDevInst, byte* pDeviceID, uint dnParent, uint ulFlags);

@DllImport("SETUPAPI")
uint CM_Create_DevNodeW(uint* pdnDevInst, ushort* pDeviceID, uint dnParent, uint ulFlags);

@DllImport("SETUPAPI")
uint CM_Create_DevNode_ExA(uint* pdnDevInst, byte* pDeviceID, uint dnParent, uint ulFlags, ptrdiff_t hMachine);

@DllImport("SETUPAPI")
uint CM_Create_DevNode_ExW(uint* pdnDevInst, ushort* pDeviceID, uint dnParent, uint ulFlags, ptrdiff_t hMachine);

@DllImport("SETUPAPI")
uint CM_Create_Range_List(size_t* prlh, uint ulFlags);

///The <b>CM_Delete_Class_Key</b> function removes the specified installed device class from the system.
///Params:
///    ClassGuid = Pointer to the GUID of the device class to remove.
///    ulFlags = Delete class key flags:
///Returns:
///    If the operation succeeds, the function returns CR_SUCCESS. Otherwise, it returns one of the CR_-prefixed error
///    codes defined in <i>Cfgmgr32.h</i>.
///    
@DllImport("SETUPAPI")
uint CM_Delete_Class_Key(GUID* ClassGuid, uint ulFlags);

@DllImport("SETUPAPI")
uint CM_Delete_Class_Key_Ex(GUID* ClassGuid, uint ulFlags, ptrdiff_t hMachine);

///The <b>CM_Delete_DevNode_Key</b> function deletes the specified user-accessible registry keys that are associated
///with a device.
///Params:
///    dnDevNode = Device instance handle that is bound to the local machine.
///    ulHardwareProfile = The hardware profile to delete if <i>ulFlags</i> includes CM_REGISTRY_CONFIG. If this value is zero, the key for
///                        the current hardware profile is deleted. If this value is 0xFFFFFFFF, the registry keys for all hardware profiles
///                        are deleted.
///    ulFlags = Delete device node key flags. Indicates the scope and type of registry storage key to delete. Can be a
///              combination of the following flags:
///Returns:
///    If the operation succeeds, the function returns CR_SUCCESS. Otherwise, it returns one of the CR_-prefixed error
///    codes defined in <i>Cfgmgr32.h</i>.
///    
@DllImport("SETUPAPI")
uint CM_Delete_DevNode_Key(uint dnDevNode, uint ulHardwareProfile, uint ulFlags);

@DllImport("SETUPAPI")
uint CM_Delete_DevNode_Key_Ex(uint dnDevNode, uint ulHardwareProfile, uint ulFlags, ptrdiff_t hMachine);

@DllImport("SETUPAPI")
uint CM_Delete_Range(ulong ullStartValue, ulong ullEndValue, size_t rlh, uint ulFlags);

@DllImport("SETUPAPI")
uint CM_Detect_Resource_Conflict(uint dnDevInst, uint ResourceID, char* ResourceData, uint ResourceLen, 
                                 int* pbConflictDetected, uint ulFlags);

@DllImport("SETUPAPI")
uint CM_Detect_Resource_Conflict_Ex(uint dnDevInst, uint ResourceID, char* ResourceData, uint ResourceLen, 
                                    int* pbConflictDetected, uint ulFlags, ptrdiff_t hMachine);

///The <b>CM_Disable_DevNode</b> function disables a device.
///Params:
///    dnDevInst = Device instance handle that is bound to the local machine.
///    ulFlags = Disable flags:
///Returns:
///    If the operation succeeds, the function returns CR_SUCCESS. Otherwise, it returns one of the CR_-prefixed error
///    codes defined in <i>Cfgmgr32.h</i>.
///    
@DllImport("SETUPAPI")
uint CM_Disable_DevNode(uint dnDevInst, uint ulFlags);

@DllImport("SETUPAPI")
uint CM_Disable_DevNode_Ex(uint dnDevInst, uint ulFlags, ptrdiff_t hMachine);

///<p class="CCE_Message">[Beginning in Windows 8 and Windows Server 2012 functionality to access remote machines has
///been removed. You cannot access remote machines when running on these versions of Windows.] The
///<b>CM_Disconnect_Machine</b> function removes a connection to a remote machine.
///Params:
///    hMachine = Caller-supplied machine handle, obtained from a previous call to CM_Connect_Machine. <div
///               class="alert"><b>Note</b> Using this function to access remote machines is not supported beginning with Windows 8
///               and Windows Server 2012, as this functionality has been removed.</div> <div> </div>
///Returns:
///    If the operation succeeds, the function returns CR_SUCCESS. Otherwise, it returns one of the CR_-prefixed error
///    codes defined in <i>Cfgmgr32.h</i>.
///    
@DllImport("SETUPAPI")
uint CM_Disconnect_Machine(ptrdiff_t hMachine);

@DllImport("SETUPAPI")
uint CM_Dup_Range_List(size_t rlhOld, size_t rlhNew, uint ulFlags);

///The <b>CM_Enable_DevNode</b> function enables a device.
///Params:
///    dnDevInst = Device instance handle that is bound to the local machine.
///    ulFlags = Reserved. Must be set to zero.
///Returns:
///    If the operation succeeds, the function returns CR_SUCCESS. Otherwise, it returns one of the CR_-prefixed error
///    codes defined in <i>Cfgmgr32.h</i>.
///    
@DllImport("SETUPAPI")
uint CM_Enable_DevNode(uint dnDevInst, uint ulFlags);

@DllImport("SETUPAPI")
uint CM_Enable_DevNode_Ex(uint dnDevInst, uint ulFlags, ptrdiff_t hMachine);

///The <b>CM_Enumerate_Classes</b> function, when called repeatedly, enumerates the local machine's installed device
///classes by supplying each class's GUID.
///Params:
///    ulClassIndex = Caller-supplied index into the machine's list of device classes. For more information, see the <b>Remarks</b>
///                   section.
///    ClassGuid = Caller-supplied address of a GUID structure (described in the Microsoft Windows SDK) to receive a device class's
///                GUID.
///    ulFlags = Beginning with Windows 8, callers can specify the following flags:
///Returns:
///    If the operation succeeds, the function returns CR_SUCCESS. Otherwise, it returns one of the CR_-prefixed error
///    codes defined in <i>Cfgmgr32.h</i>.
///    
@DllImport("SETUPAPI")
uint CM_Enumerate_Classes(uint ulClassIndex, GUID* ClassGuid, uint ulFlags);

///<p class="CCE_Message">[Beginning with Windows 8 and Windows Server 2012, this function has been deprecated. Please
///use CM_Enumerate_Classes instead.] The <b>CM_Enumerate_Classes_Ex</b> function, when called repeatedly, enumerates a
///local or a remote machine's installed device classes, by supplying each class's GUID.
///Params:
///    ulClassIndex = Caller-supplied index into the machine's list of device classes. For more information, see the following
///                   <b>Remarks</b> section.
///    ClassGuid = Caller-supplied address of a GUID structure (described in the Microsoft Windows SDK) to receive a device class's
///                GUID.
///    ulFlags = Beginning with Windows 8, callers can specify the following flags:
///    hMachine = Caller-supplied machine handle, obtained from a previous call to CM_Connect_Machine. <div
///               class="alert"><b>Note</b> Using this function to access remote machines is not supported beginning with Windows 8
///               and Windows Server 2012, as this functionality has been removed.</div> <div> </div>
///Returns:
///    If the operation succeeds, the function returns CR_SUCCESS. Otherwise, it returns one of the CR_-prefixed error
///    codes defined in <i>Cfgmgr32.h</i>.
///    
@DllImport("SETUPAPI")
uint CM_Enumerate_Classes_Ex(uint ulClassIndex, GUID* ClassGuid, uint ulFlags, ptrdiff_t hMachine);

@DllImport("SETUPAPI")
uint CM_Enumerate_EnumeratorsA(uint ulEnumIndex, const(char)* Buffer, uint* pulLength, uint ulFlags);

///The <b>CM_Enumerate_Enumerators</b> function enumerates the local machine's device enumerators by supplying each
///enumerator's name.
///Params:
///    ulEnumIndex = Caller-supplied index into the machine's list of device enumerators. For more information, see the following
///                  <b>Remarks</b> section.
///    Buffer = Address of a buffer to receive an enumerator name. This buffer should be MAX_DEVICE_ID_LEN-sized (or, set
///             <i>Buffer</i> to zero and obtain the actual name length in the location referenced by <i>puLength</i>).
///    pulLength = Caller-supplied address of a location to hold the buffer size. The caller supplies the length of the buffer
///                pointed to by <i>Buffer</i>. The function replaces this value with the actual size of the enumerator's name
///                string. If the caller-supplied buffer length is too small, the function supplies the required buffer size and
///                returns CR_BUFFER_SMALL.
///    ulFlags = Not used, must be zero.
///Returns:
///    If the operation succeeds, the function returns CR_SUCCESS. Otherwise, it returns one of the CR_-prefixed error
///    codes defined in <i>Cfgmgr32.h</i>.
///    
@DllImport("SETUPAPI")
uint CM_Enumerate_EnumeratorsW(uint ulEnumIndex, const(wchar)* Buffer, uint* pulLength, uint ulFlags);

@DllImport("SETUPAPI")
uint CM_Enumerate_Enumerators_ExA(uint ulEnumIndex, const(char)* Buffer, uint* pulLength, uint ulFlags, 
                                  ptrdiff_t hMachine);

///<p class="CCE_Message">[Beginning with Windows 8 and Windows Server 2012, this function has been deprecated. Please
///use CM_Enumerate_Enumerators instead.] The <b>CM_Enumerate_Enumerators_Ex</b> function enumerates a local or a remote
///machine's device enumerators, by supplying each enumerator's name.
///Params:
///    ulEnumIndex = Caller-supplied index into the machine's list of device enumerators. For more information, see the following
///                  <b>Remarks</b> section.
///    Buffer = Address of a buffer to receive an enumerator name. This buffer should be MAX_DEVICE_ID_LEN-sized (or, set
///             <i>Buffer</i> to zero and obtain the actual name length in the location referenced by <b>puLength</b>).
///    pulLength = Caller-supplied address of a location to hold the buffer size. The caller supplies the length of the buffer
///                pointed to by <i>Buffer</i>. The function replaces this value with the actual size of the enumerator's name
///                string. If the caller-supplied buffer length is too small, the function supplies the required buffer size and
///                returns CR_BUFFER_SMALL.
///    ulFlags = Not used, must be zero.
///    hMachine = Caller-supplied machine handle, obtained from a previous call to CM_Connect_Machine. <div
///               class="alert"><b>Note</b> Using this function to access remote machines is not supported beginning with Windows 8
///               and Windows Server 2012, as this functionality has been removed.</div> <div> </div>
///Returns:
///    If the operation succeeds, the function returns CR_SUCCESS. Otherwise, it returns one of the CR_-prefixed error
///    codes defined in <i>Cfgmgr32.h</i>.
///    
@DllImport("SETUPAPI")
uint CM_Enumerate_Enumerators_ExW(uint ulEnumIndex, const(wchar)* Buffer, uint* pulLength, uint ulFlags, 
                                  ptrdiff_t hMachine);

@DllImport("SETUPAPI")
uint CM_Find_Range(ulong* pullStart, ulong ullStart, uint ulLength, ulong ullAlignment, ulong ullEnd, size_t rlh, 
                   uint ulFlags);

@DllImport("SETUPAPI")
uint CM_First_Range(size_t rlh, ulong* pullStart, ulong* pullEnd, size_t* preElement, uint ulFlags);

///The <b>CM_Free_Log_Conf</b> function removes a logical configuration and all associated resource descriptors from the
///local machine.
///Params:
///    lcLogConfToBeFreed = Caller-supplied handle to a logical configuration. This handle must have been previously obtained by calling one
///                         of the following functions: CM_Add_Empty_Log_Conf CM_Add_Empty_Log_Conf_Ex CM_Get_First_Log_Conf
///                         CM_Get_First_Log_Conf_Ex CM_Get_Next_Log_Conf CM_Get_Next_Log_Conf_Ex
///    ulFlags = Not used, must be zero.
///Returns:
///    If the operation succeeds, the function returns CR_SUCCESS. Otherwise, it returns one of the CR_-prefixed error
///    codes defined in <i>Cfgmgr32.h</i>. <div class="alert"><b>Note</b> Starting with Windows 8,
///    <b>CM_Free_Log_Conf</b> returns CR_CALL_NOT_IMPLEMENTED when used in a Wow64 scenario. To request information
///    about the hardware resources on a local machine it is necessary implement an architecture-native version of the
///    application using the hardware resource APIs. For example: An AMD64 application for AMD64 systems.</div> <div>
///    </div>
///    
@DllImport("SETUPAPI")
uint CM_Free_Log_Conf(size_t lcLogConfToBeFreed, uint ulFlags);

///<p class="CCE_Message">[Beginning with Windows 8 and Windows Server 2012, this function has been deprecated. Please
///use CM_Free_Log_Conf instead.] The <b>CM_Free_Log_Conf_Ex</b> function removes a logical configuration and all
///associated resource descriptors from either a local or a remote machine.
///Params:
///    lcLogConfToBeFreed = Caller-supplied handle to a logical configuration. This handle must have been previously obtained by calling one
///                         of the following functions: CM_Add_Empty_Log_Conf CM_Add_Empty_Log_Conf_Ex CM_Get_First_Log_Conf
///                         CM_Get_First_Log_Conf_Ex CM_Get_Next_Log_Conf CM_Get_Next_Log_Conf_Ex
///    ulFlags = Not used, must be zero.
///    hMachine = Caller-supplied machine handle, obtained from a previous call to CM_Connect_Machine. <div
///               class="alert"><b>Note</b> Using this function to access remote machines is not supported beginning with Windows 8
///               and Windows Server 2012, as this functionality has been removed.</div> <div> </div>
///Returns:
///    If the operation succeeds, the function returns CR_SUCCESS. Otherwise, it returns one of the CR_-prefixed error
///    codes defined in <i>Cfgmgr32.h</i>. <div class="alert"><b>Note</b> Starting with Windows 8,
///    <b>CM_Free_Log_Conf_Ex</b> returns CR_CALL_NOT_IMPLEMENTED when used in a Wow64 scenario. To request information
///    about the hardware resources on a local machine it is necessary implement an architecture-native version of the
///    application using the hardware resource APIs. For example: An AMD64 application for AMD64 systems.</div> <div>
///    </div>
///    
@DllImport("SETUPAPI")
uint CM_Free_Log_Conf_Ex(size_t lcLogConfToBeFreed, uint ulFlags, ptrdiff_t hMachine);

///The <b>CM_Free_Log_Conf_Handle</b> function invalidates a logical configuration handle and frees its associated
///memory allocation.
///Params:
///    lcLogConf = Caller-supplied logical configuration handle. This handle must have been previously obtained by calling one of
///                the following functions: CM_Add_Empty_Log_Conf CM_Add_Empty_Log_Conf_Ex CM_Get_First_Log_Conf
///                CM_Get_First_Log_Conf_Ex CM_Get_Next_Log_Conf CM_Get_Next_Log_Conf_Ex
///Returns:
///    If the operation succeeds, the function returns CR_SUCCESS. Otherwise, it returns one of the CR_-prefixed error
///    codes defined in <i>Cfgmgr32.h</i>.
///    
@DllImport("SETUPAPI")
uint CM_Free_Log_Conf_Handle(size_t lcLogConf);

@DllImport("SETUPAPI")
uint CM_Free_Range_List(size_t rlh, uint ulFlags);

///The <b>CM_Free_Res_Des</b> function removes a resource descriptor from a logical configuration on the local machine.
///Params:
///    prdResDes = Caller-supplied location to receive a handle to the configuration's previous resource descriptor. This parameter
///                can be <b>NULL</b>. For more information, see the following <b>Remarks</b> section.
///    rdResDes = Caller-supplied handle to the resource descriptor to be removed. This handle must have been previously obtained
///               by calling one of the following functions: CM_Add_Res_Des CM_Add_Res_Des_Ex CM_Get_Next_Res_Des
///               CM_Get_Next_Res_Des_Ex CM_Modify_Res_Des CM_Modify_Res_Des_Ex
///    ulFlags = Not used, must be zero.
///Returns:
///    If the operation succeeds, the function returns CR_SUCCESS. Otherwise, it returns one of the CR_-prefixed error
///    codes defined in <i>Cfgmgr32.h</i>. <div class="alert"><b>Note</b> Starting with Windows 8,
///    <b>CM_Free_Res_Des</b> returns CR_CALL_NOT_IMPLEMENTED when used in a Wow64 scenario. To request information
///    about the hardware resources on a local machine it is necessary implement an architecture-native version of the
///    application using the hardware resource APIs. For example: An AMD64 application for AMD64 systems.</div> <div>
///    </div>
///    
@DllImport("SETUPAPI")
uint CM_Free_Res_Des(size_t* prdResDes, size_t rdResDes, uint ulFlags);

///<p class="CCE_Message">[Beginning with Windows 8 and Windows Server 2012, this function has been deprecated. Please
///use CM_Free_Res_Des instead.] The <b>CM_Free_Res_Des_Ex</b> function removes a resource descriptor from a logical
///configuration on either a local or a remote machine.
///Params:
///    prdResDes = Caller-supplied location to receive a handle to the configuration's previous resource descriptor. This parameter
///                can be <b>NULL</b>. For more information, see the following <b>Remarks</b> section.
///    rdResDes = Caller-supplied handle to the resource descriptor to be removed. This handle must have been previously obtained
///               by calling one of the following functions: CM_Add_Res_Des CM_Add_Res_Des_Ex CM_Get_Next_Res_Des
///               CM_Get_Next_Res_Des_Ex CM_Modify_Res_Des CM_Modify_Res_Des_Ex
///    ulFlags = Not used, must be zero.
///    hMachine = Caller-supplied machine handle, obtained from a previous call to CM_Connect_Machine. <div
///               class="alert"><b>Note</b> Using this function to access remote machines is not supported beginning with Windows 8
///               and Windows Server 2012, as this functionality has been removed.</div> <div> </div>
///Returns:
///    If the operation succeeds, the function returns CR_SUCCESS. Otherwise, it returns one of the CR_-prefixed error
///    codes defined in <i>Cfgmgr32.h</i>. <div class="alert"><b>Note</b> Starting with Windows 8,
///    <b>CM_Free_Res_Des_Ex</b> returns CR_CALL_NOT_IMPLEMENTED when used in a Wow64 scenario. To request information
///    about the hardware resources on a local machine it is necessary implement an architecture-native version of the
///    application using the hardware resource APIs. For example: An AMD64 application for AMD64 systems.</div> <div>
///    </div>
///    
@DllImport("SETUPAPI")
uint CM_Free_Res_Des_Ex(size_t* prdResDes, size_t rdResDes, uint ulFlags, ptrdiff_t hMachine);

///The <b>CM_Free_Res_Des_Handle</b> function invalidates a resource description handle and frees its associated memory
///allocation.
///Params:
///    rdResDes = Caller-supplied resource descriptor handle to be freed. This handle must have been previously obtained by calling
///               one of the following functions: CM_Add_Res_Des CM_Add_Res_Des_Ex CM_Get_Next_Res_Des CM_Get_Next_Res_Des_Ex
///               CM_Modify_Res_Des CM_Modify_Res_Des_Ex
///Returns:
///    If the operation succeeds, the function returns CR_SUCCESS. Otherwise, it returns one of the CR_-prefixed error
///    codes defined in <i>Cfgmgr32.h</i>.
///    
@DllImport("SETUPAPI")
uint CM_Free_Res_Des_Handle(size_t rdResDes);

///The <b>CM_Get_Child</b> function is used to retrieve a device instance handle to the first child node of a specified
///device node (devnode) in the local machine's device tree.
///Params:
///    pdnDevInst = Caller-supplied pointer to the device instance handle to the child node that this function retrieves. The
///                 retrieved handle is bound to the local machine. See the <b>Remarks</b> section.
///    dnDevInst = Caller-supplied device instance handle that is bound to the local machine.
///    ulFlags = Not used, must be zero.
///Returns:
///    If the operation succeeds, the function returns CR_SUCCESS. Otherwise, it returns one of the CR_-prefixed error
///    codes defined in <i>Cfgmgr32.h</i>.
///    
@DllImport("SETUPAPI")
uint CM_Get_Child(uint* pdnDevInst, uint dnDevInst, uint ulFlags);

///<p class="CCE_Message">[Beginning with Windows 8 and Windows Server 2012, this function has been deprecated. Please
///use CM_Get_Child instead.] The <b>CM_Get_Child_Ex</b> function is used to retrieve a device instance handle to the
///first child node of a specified device node (devnode) in a local or a remote machine's device tree.
///Params:
///    pdnDevInst = Caller-supplied pointer to the device instance handle to the child node that this function retrieves. The
///                 retrieved handle is bound to the machine handle supplied by <i>hMachine</i>. See the <b>Remarks</b> section.
///    dnDevInst = Caller-supplied device instance handle that is bound to the machine handle supplied by <i>hMachine</i>.
///    ulFlags = Not used, must be zero.
///    hMachine = Caller-supplied machine handle to which the caller-supplied device instance handle is bound. <div
///               class="alert"><b>Note</b> Using this function to access remote machines is not supported beginning with Windows 8
///               and Windows Server 2012, as this functionality has been removed.</div> <div> </div>
///Returns:
///    If the operation succeeds, the function returns CR_SUCCESS. Otherwise, it returns one of the CR_-prefixed error
///    codes defined in <i>Cfgmgr32.h</i>.
///    
@DllImport("SETUPAPI")
uint CM_Get_Child_Ex(uint* pdnDevInst, uint dnDevInst, uint ulFlags, ptrdiff_t hMachine);

@DllImport("SETUPAPI")
uint CM_Get_Class_NameA(GUID* ClassGuid, const(char)* Buffer, uint* pulLength, uint ulFlags);

@DllImport("SETUPAPI")
uint CM_Get_Class_NameW(GUID* ClassGuid, const(wchar)* Buffer, uint* pulLength, uint ulFlags);

@DllImport("SETUPAPI")
uint CM_Get_Class_Name_ExA(GUID* ClassGuid, const(char)* Buffer, uint* pulLength, uint ulFlags, ptrdiff_t hMachine);

@DllImport("SETUPAPI")
uint CM_Get_Class_Name_ExW(GUID* ClassGuid, const(wchar)* Buffer, uint* pulLength, uint ulFlags, 
                           ptrdiff_t hMachine);

@DllImport("SETUPAPI")
uint CM_Get_Class_Key_NameA(GUID* ClassGuid, const(char)* pszKeyName, uint* pulLength, uint ulFlags);

@DllImport("SETUPAPI")
uint CM_Get_Class_Key_NameW(GUID* ClassGuid, const(wchar)* pszKeyName, uint* pulLength, uint ulFlags);

@DllImport("SETUPAPI")
uint CM_Get_Class_Key_Name_ExA(GUID* ClassGuid, const(char)* pszKeyName, uint* pulLength, uint ulFlags, 
                               ptrdiff_t hMachine);

@DllImport("SETUPAPI")
uint CM_Get_Class_Key_Name_ExW(GUID* ClassGuid, const(wchar)* pszKeyName, uint* pulLength, uint ulFlags, 
                               ptrdiff_t hMachine);

///The <b>CM_Get_Depth</b> function is used to obtain the depth of a specified device node (devnode) within the local
///machine's device tree.
///Params:
///    pulDepth = Caller-supplied address of a location to receive a depth value, where zero represents the device tree's root
///               node, one represents the root node's children, and so on.
///    dnDevInst = Caller-supplied device instance handle that is bound to the local machine.
///    ulFlags = Not used, must be zero.
///Returns:
///    If the operation succeeds, the function returns CR_SUCCESS. Otherwise, it returns one of the CR_-prefixed error
///    codes defined in <i>Cfgmgr32.h</i>.
///    
@DllImport("SETUPAPI")
uint CM_Get_Depth(uint* pulDepth, uint dnDevInst, uint ulFlags);

///<p class="CCE_Message">[Beginning with Windows 8 and Windows Server 2012, this function has been deprecated. Please
///use CM_Get_Depth instead.] The <b>CM_Get_Depth_Ex</b> function is used to obtain the depth of a specified device node
///(devnode) within a local or a remote machine's device tree.
///Params:
///    pulDepth = Caller-supplied address of a location to receive a depth value, where zero represents the device tree's root
///               node, one represents the root node's children, and so on.
///    dnDevInst = Caller-supplied device instance handle that is bound to the machine handle supplied by <i>hMachine</i>.
///    ulFlags = Not used, must be zero.
///    hMachine = Caller-supplied machine handle to which the caller-supplied device instance handle is bound. <div
///               class="alert"><b>Note</b> Using this function to access remote machines is not supported beginning with Windows 8
///               and Windows Server 2012, as this functionality has been removed.</div> <div> </div>
///Returns:
///    If the operation succeeds, the function returns CR_SUCCESS. Otherwise, it returns one of the CR_-prefixed error
///    codes defined in <i>Cfgmgr32.h</i>.
///    
@DllImport("SETUPAPI")
uint CM_Get_Depth_Ex(uint* pulDepth, uint dnDevInst, uint ulFlags, ptrdiff_t hMachine);

@DllImport("SETUPAPI")
uint CM_Get_Device_IDA(uint dnDevInst, const(char)* Buffer, uint BufferLen, uint ulFlags);

///The <b>CM_Get_Device_ID</b> function retrieves the device instance ID for a specified device instance on the local
///machine.
///Params:
///    dnDevInst = Caller-supplied device instance handle that is bound to the local machine.
///    Buffer = Address of a buffer to receive a device instance ID string. The required buffer size can be obtained by calling
///             CM_Get_Device_ID_Size, then incrementing the received value to allow room for the string's terminating
///             <b>NULL</b>.
///    BufferLen = Caller-supplied length, in characters, of the buffer specified by <i>Buffer</i>.
///    ulFlags = Not used, must be zero.
///Returns:
///    If the operation succeeds, the function returns CR_SUCCESS. Otherwise, it returns one of the CR_-prefixed error
///    codes defined in <i>Cfgmgr32.h</i>.
///    
@DllImport("SETUPAPI")
uint CM_Get_Device_IDW(uint dnDevInst, const(wchar)* Buffer, uint BufferLen, uint ulFlags);

@DllImport("SETUPAPI")
uint CM_Get_Device_ID_ExA(uint dnDevInst, const(char)* Buffer, uint BufferLen, uint ulFlags, ptrdiff_t hMachine);

///<p class="CCE_Message">[Beginning with Windows 8 and Windows Server 2012, this function has been deprecated. Please
///use CM_Get_Device_ID instead.] The <b>CM_Get_Device_ID_Ex</b> function retrieves the device instance ID for a
///specified device instance on a local or a remote machine.
///Params:
///    dnDevInst = Caller-supplied device instance handle that is bound to the machine handle supplied by <i>hMachine</i>.
///    Buffer = Address of a buffer to receive a device instance ID string. The required buffer size can be obtained by calling
///             CM_Get_Device_ID_Size_Ex, then incrementing the received value to allow room for the string's terminating
///             <b>NULL</b>.
///    BufferLen = Caller-supplied length, in characters, of the buffer specified by <i>Buffer</i>.
///    ulFlags = Not used, must be zero.
///    hMachine = Caller-supplied machine handle to which the caller-supplied device instance handle is bound. <div
///               class="alert"><b>Note</b> Using this function to access remote machines is not supported beginning with Windows 8
///               and Windows Server 2012, as this functionality has been removed.</div> <div> </div>
///Returns:
///    If the operation succeeds, the function returns CR_SUCCESS. Otherwise, it returns one of the CR_-prefixed error
///    codes defined in <i>Cfgmgr32.h</i>.
///    
@DllImport("SETUPAPI")
uint CM_Get_Device_ID_ExW(uint dnDevInst, const(wchar)* Buffer, uint BufferLen, uint ulFlags, ptrdiff_t hMachine);

///The <b>CM_Get_Device_ID_List</b> function retrieves a list of device instance IDs for the local computer's device
///instances.
///Params:
///    pszFilter = Caller-supplied pointer to a character string that is either set to a subset of the computer's device instance
///                identifiers (IDs), or to <b>NULL</b>. See the following description of <i>ulFlags</i>.
///    Buffer = Address of a buffer to receive a set of NULL-terminated device instance identifier strings. The end of the set is
///             terminated by an extra <b>NULL</b>. The required buffer size should be obtained by calling
///             CM_Get_Device_ID_List_Size.
///    BufferLen = Caller-supplied length, in characters, of the buffer specified by <i>Buffer</i>.
///    ulFlags = One of the following caller-supplied bit flags that specifies search filters:
///Returns:
///    If the operation succeeds, the function returns CR_SUCCESS. Otherwise, it returns one of the CR_-prefixed error
///    codes defined in <i>Cfgmgr32.h</i>.
///    
@DllImport("SETUPAPI")
uint CM_Get_Device_ID_ListA(const(char)* pszFilter, const(char)* Buffer, uint BufferLen, uint ulFlags);

///The <b>CM_Get_Device_ID_List</b> function retrieves a list of device instance IDs for the local computer's device
///instances.
///Params:
///    pszFilter = Caller-supplied pointer to a character string that is either set to a subset of the computer's device instance
///                identifiers (IDs), or to <b>NULL</b>. See the following description of <i>ulFlags</i>.
///    Buffer = Address of a buffer to receive a set of NULL-terminated device instance identifier strings. The end of the set is
///             terminated by an extra <b>NULL</b>. The required buffer size should be obtained by calling
///             CM_Get_Device_ID_List_Size.
///    BufferLen = Caller-supplied length, in characters, of the buffer specified by <i>Buffer</i>.
///    ulFlags = One of the following caller-supplied bit flags that specifies search filters:
///Returns:
///    If the operation succeeds, the function returns CR_SUCCESS. Otherwise, it returns one of the CR_-prefixed error
///    codes defined in <i>Cfgmgr32.h</i>.
///    
@DllImport("SETUPAPI")
uint CM_Get_Device_ID_ListW(const(wchar)* pszFilter, const(wchar)* Buffer, uint BufferLen, uint ulFlags);

@DllImport("SETUPAPI")
uint CM_Get_Device_ID_List_ExA(const(char)* pszFilter, const(char)* Buffer, uint BufferLen, uint ulFlags, 
                               ptrdiff_t hMachine);

///<p class="CCE_Message">[Beginning with Windows 8 and Windows Server 2012, this function has been deprecated. Please
///use CM_Get_Device_ID_List instead.] The <b>CM_Get_Device_ID_List_Ex</b> function retrieves a list of device instance
///IDs for the device instances on a local or a remote machine.
///Params:
///    pszFilter = Caller-supplied pointer to a character string specifying a subset of the machine's device instance identifiers,
///                or <b>NULL</b>. See the following description of <i>ulFlags</i>.
///    Buffer = Address of a buffer to receive a set of NULL-terminated device instance identifier strings. The end of the set is
///             terminated by an extra <b>NULL</b>. The required buffer size should be obtained by calling
///             CM_Get_Device_ID_List_Size_Ex.
///    BufferLen = Caller-supplied length, in characters, of the buffer specified by <i>Buffer</i>.
///    ulFlags = One of the optional, caller-supplied bit flags that specify search filters. If no flags are specified, the
///              function supplies all instance identifiers for all device instances. For a list of bit flags, see the
///              <i>ulFlags</i> description for CM_Get_Device_ID_List.
///    hMachine = Caller-supplied machine handle, obtained from a previous call to CM_Connect_Machine. <div
///               class="alert"><b>Note</b> Using this function to access remote machines is not supported beginning with Windows 8
///               and Windows Server 2012, as this functionality has been removed.</div> <div> </div>
///Returns:
///    If the operation succeeds, the function returns CR_SUCCESS. Otherwise, it returns one of the CR_-prefixed error
///    codes defined in <i>Cfgmgr32.h</i>.
///    
@DllImport("SETUPAPI")
uint CM_Get_Device_ID_List_ExW(const(wchar)* pszFilter, const(wchar)* Buffer, uint BufferLen, uint ulFlags, 
                               ptrdiff_t hMachine);

///The <b>CM_Get_Device_ID_List_Size</b> function retrieves the buffer size required to hold a list of device instance
///IDs for the local machine's device instances.
///Params:
///    pulLen = Receives a value representing the required buffer size, in characters.
///    pszFilter = Caller-supplied pointer to a character string specifying a subset of the machine's device instance identifiers,
///                or <b>NULL</b>. See the following description of <i>ulFlags</i>.
///    ulFlags = One of the optional, caller-supplied bit flags that specify search filters. If no flags are specified, the
///              function supplies the buffer size required to hold all instance identifiers for all device instances. For a list
///              of bit flags, see the <i>ulFlags</i> description for CM_Get_Device_ID_List.
///Returns:
///    If the operation succeeds, the function returns CR_SUCCESS. Otherwise, it returns one of the CR_-prefixed error
///    codes defined in <i>Cfgmgr32.h</i>.
///    
@DllImport("SETUPAPI")
uint CM_Get_Device_ID_List_SizeA(uint* pulLen, const(char)* pszFilter, uint ulFlags);

///The <b>CM_Get_Device_ID_List_Size</b> function retrieves the buffer size required to hold a list of device instance
///IDs for the local machine's device instances.
///Params:
///    pulLen = Receives a value representing the required buffer size, in characters.
///    pszFilter = Caller-supplied pointer to a character string specifying a subset of the machine's device instance identifiers,
///                or <b>NULL</b>. See the following description of <i>ulFlags</i>.
///    ulFlags = One of the optional, caller-supplied bit flags that specify search filters. If no flags are specified, the
///              function supplies the buffer size required to hold all instance identifiers for all device instances. For a list
///              of bit flags, see the <i>ulFlags</i> description for CM_Get_Device_ID_List.
///Returns:
///    If the operation succeeds, the function returns CR_SUCCESS. Otherwise, it returns one of the CR_-prefixed error
///    codes defined in <i>Cfgmgr32.h</i>.
///    
@DllImport("SETUPAPI")
uint CM_Get_Device_ID_List_SizeW(uint* pulLen, const(wchar)* pszFilter, uint ulFlags);

@DllImport("SETUPAPI")
uint CM_Get_Device_ID_List_Size_ExA(uint* pulLen, const(char)* pszFilter, uint ulFlags, ptrdiff_t hMachine);

///<p class="CCE_Message">[Beginning with Windows 8 and Windows Server 2012, this function has been deprecated. Please
///use CM_Get_Device_ID_List_Size instead.] The <b>CM_Get_Device_ID_List_Size_Ex</b> function retrieves the buffer size
///required to hold a list of device instance IDs for a local or a remote machine's device instances.
///Params:
///    pulLen = Receives a value representing the required buffer size, in characters.
///    pszFilter = Caller-supplied pointer to a character string specifying a subset of the machine's device instance identifiers,
///                or <b>NULL</b>. See the following description of <i>ulFlags</i>.
///    ulFlags = One of the optional, caller-supplied bit flags that specify search filters. If no flags are specified, the
///              function supplies the buffer size required to hold all instance identifiers for all device instances. For a list
///              of bit flags, see the <i>ulFlags</i> description for CM_Get_Device_ID_List_Ex.
///    hMachine = Caller-supplied machine handle, obtained from a previous call to CM_Connect_Machine. <div
///               class="alert"><b>Note</b> Using this function to access remote machines is not supported beginning with Windows 8
///               and Windows Server 2012, as this functionality has been removed.</div> <div> </div>
///Returns:
///    If the operation succeeds, the function returns CR_SUCCESS. Otherwise, it returns one of the CR_-prefixed error
///    codes defined in <i>Cfgmgr32.h</i>.
///    
@DllImport("SETUPAPI")
uint CM_Get_Device_ID_List_Size_ExW(uint* pulLen, const(wchar)* pszFilter, uint ulFlags, ptrdiff_t hMachine);

///The <b>CM_Get_Device_ID_Size</b> function retrieves the buffer size required to hold a device instance ID for a
///device instance on the local machine.
///Params:
///    pulLen = Receives a value representing the required buffer size, in characters.
///    dnDevInst = Caller-supplied device instance handle that is bound to the local machine.
///    ulFlags = Not used, must be zero.
///Returns:
///    If the operation succeeds, the function returns CR_SUCCESS. Otherwise, it returns one of the CR_-prefixed error
///    codes defined in <i>Cfgmgr32.h</i>.
///    
@DllImport("SETUPAPI")
uint CM_Get_Device_ID_Size(uint* pulLen, uint dnDevInst, uint ulFlags);

///<p class="CCE_Message">[Beginning with Windows 8 and Windows Server 2012, this function has been deprecated. Please
///use CM_Get_Device_ID_Size instead.] The <b>CM_Get_Device_ID_Size_Ex</b> function retrieves the buffer size required
///to hold a device instance ID for a device instance on a local or a remote machine.
///Params:
///    pulLen = Receives a value representing the required buffer size, in characters.
///    dnDevInst = Caller-supplied device instance handle that is bound to the local machine.
///    ulFlags = Not used, must be zero.
///    hMachine = Caller-supplied machine handle to which the caller-supplied device instance handle is bound. <div
///               class="alert"><b>Note</b> Using this function to access remote machines is not supported beginning with Windows 8
///               and Windows Server 2012, as this functionality has been removed.</div> <div> </div>
///Returns:
///    If the operation succeeds, the function returns CR_SUCCESS. Otherwise, it returns one of the CR_-prefixed error
///    codes defined in <i>Cfgmgr32.h</i>.
///    
@DllImport("SETUPAPI")
uint CM_Get_Device_ID_Size_Ex(uint* pulLen, uint dnDevInst, uint ulFlags, ptrdiff_t hMachine);

///The <b>CM_Get_DevNode_Property</b> function retrieves a device instance property.
///Params:
///    dnDevInst = Device instance handle that is bound to the local machine.
///    PropertyKey = Pointer to a DEVPROPKEY structure that represents the device property key of the requested device instance
///                  property.
///    PropertyType = Pointer to a DEVPROPTYPE-typed variable that receives the property-data-type identifier of the requested device
///                   instance property, where the property-data-type identifier is the bitwise OR between a base-data-type identifier
///                   and, if the base-data type is modified, a property-data-type modifier.
///    PropertyBuffer = Pointer to a buffer that receives the requested device instance property. <b>CM_Get_DevNode_Property</b>
///                     retrieves the requested property only if the buffer is large enough to hold all the property value data. The
///                     pointer can be NULL.
///    PropertyBufferSize = The size, in bytes, of the <i>PropertyBuffer</i> buffer. If <i>PropertyBuffer</i> is set to NULL,
///                         <i>*PropertyBufferSize</i> must be set to zero. As output, if the buffer is not large enough to hold all the
///                         property value data, <b>CM_Get_DevNode_Property</b> returns the size of the data, in bytes, in
///                         <i>*PropertyBufferSize</i>.
///    ulFlags = Reserved. Must be set to zero.
///Returns:
///    If the operation succeeds, the function returns CR_SUCCESS. Otherwise, it returns one of the CR_-prefixed error
///    codes defined in <i>Cfgmgr32.h</i>.
///    
@DllImport("api-ms-win-devices-config-l1-1-1")
uint CM_Get_DevNode_PropertyW(uint dnDevInst, const(DEVPROPKEY)* PropertyKey, uint* PropertyType, 
                              char* PropertyBuffer, uint* PropertyBufferSize, uint ulFlags);

///<p class="CCE_Message">[Beginning with Windows 8 and Windows Server 2012, this function has been deprecated. Please
///use CM_Get_DevNode_Property instead.] The <b>CM_Get_DevNode_Property_ExW</b> function retrieves a device instance
///property.
///Params:
///    dnDevInst = Device instance handle that is bound to the local machine.
///    PropertyKey = Pointer to a DEVPROPKEY structure that represents the device property key of the requested device instance
///                  property.
///    PropertyType = Pointer to a DEVPROPTYPE-typed variable that receives the property-data-type identifier of the requested device
///                   instance property, where the property-data-type identifier is the bitwise OR between a base-data-type identifier
///                   and, if the base-data type is modified, a property-data-type modifier.
///    PropertyBuffer = Pointer to a buffer that receives the requested device instance property. <b>CM_Get_DevNode_Property_ExW</b>
///                     retrieves the requested property only if the buffer is large enough to hold all the property value data. The
///                     pointer can be NULL.
///    PropertyBufferSize = The size, in bytes, of the <i>PropertyBuffer</i> buffer. If <i>PropertyBuffer</i> is set to NULL,
///                         <i>*PropertyBufferSize</i> must be set to zero. As output, if the buffer is not large enough to hold all the
///                         property value data, <b>CM_Get_DevNode_Property_ExW</b> returns the size of the data, in bytes, in
///                         <i>*PropertyBufferSize</i>.
///    ulFlags = Reserved. Must be set to zero.
///    hMachine = Caller-supplied machine handle, obtained from a previous call to CM_Connect_Machine. <div
///               class="alert"><b>Note</b> Using this function to access remote machines is not supported beginning with Windows 8
///               and Windows Server 2012, as this functionality has been removed.</div> <div> </div>
///Returns:
///    If the operation succeeds, the function returns CR_SUCCESS. Otherwise, it returns one of the CR_-prefixed error
///    codes defined in <i>Cfgmgr32.h</i>.
///    
@DllImport("CFGMGR32")
uint CM_Get_DevNode_Property_ExW(uint dnDevInst, const(DEVPROPKEY)* PropertyKey, uint* PropertyType, 
                                 char* PropertyBuffer, uint* PropertyBufferSize, uint ulFlags, ptrdiff_t hMachine);

///The <b>CM_Get_DevNode_Property_Keys</b> function retrieves an array of the device property keys that represent the
///device properties that are set for a device instance.
///Params:
///    dnDevInst = Device instance handle that is bound to the local machine.
///    PropertyKeyArray = Pointer to a buffer that receives an array of DEVPROPKEY-typed values, where each value is a device property key
///                       that represents a device property that is set for the device instance. The pointer is optional and can be NULL.
///    PropertyKeyCount = The size, in DEVPROPKEY-typed units, of the <i>PropertyKeyArray</i> buffer. If <i>PropertyKeyArray</i> is set to
///                       NULL, <i>*PropertyKeyCount</i> must be set to zero. As output, If <i>PropertyKeyArray</i> is not large enough to
///                       hold all the property key data, <b>CM_Get_DevNode_Property_Keys</b> returns the count of the keys in
///                       <i>*PropertyKeyCount</i>.
///    ulFlags = Reserved. Must be set to zero.
///Returns:
///    If the operation succeeds, the function returns CR_SUCCESS. Otherwise, it returns one of the CR_-prefixed error
///    codes defined in <i>Cfgmgr32.h</i>.
///    
@DllImport("api-ms-win-devices-config-l1-1-1")
uint CM_Get_DevNode_Property_Keys(uint dnDevInst, char* PropertyKeyArray, uint* PropertyKeyCount, uint ulFlags);

///<p class="CCE_Message">[Beginning with Windows 8 and Windows Server 2012, this function has been deprecated. Please
///use CM_Get_DevNode_Property_Keys instead.] The <b>CM_Get_DevNode_Property_Keys_Ex</b> function retrieves an array of
///the device property keys that represent the device properties that are set for a device instance.
///Params:
///    dnDevInst = Device instance handle that is bound to the local machine.
///    PropertyKeyArray = Pointer to a buffer that receives an array of DEVPROPKEY-typed values, where each value is a device property key
///                       that represents a device property that is set for the device instance. The pointer is optional and can be NULL.
///    PropertyKeyCount = The size, in DEVPROPKEY-typed units, of the <i>PropertyKeyArray</i> buffer. If <i>PropertyKeyArray</i> is set to
///                       NULL, <i>*PropertyKeyCount</i> must be set to zero. As output, If <i>PropertyKeyArray</i> is not large enough to
///                       hold all the property key data, <b>CM_Get_DevNode_Property_Keys_Ex</b> returns the count of the keys in
///                       <i>*PropertyKeyCount</i>.
///    ulFlags = Reserved. Must be set to zero.
///    hMachine = Caller-supplied machine handle, obtained from a previous call to CM_Connect_Machine. <div
///               class="alert"><b>Note</b> Using this function to access remote machines is not supported beginning with Windows 8
///               and Windows Server 2012, as this functionality has been removed.</div> <div> </div>
///Returns:
///    If the operation succeeds, the function returns CR_SUCCESS. Otherwise, it returns one of the CR_-prefixed error
///    codes defined in <i>Cfgmgr32.h</i>.
///    
@DllImport("CFGMGR32")
uint CM_Get_DevNode_Property_Keys_Ex(uint dnDevInst, char* PropertyKeyArray, uint* PropertyKeyCount, uint ulFlags, 
                                     ptrdiff_t hMachine);

@DllImport("SETUPAPI")
uint CM_Get_DevNode_Registry_PropertyA(uint dnDevInst, uint ulProperty, uint* pulRegDataType, char* Buffer, 
                                       uint* pulLength, uint ulFlags);

///The <b>CM_Get_DevNode_Registry_Property</b> function retrieves a specified device property from the registry.
///Params:
///    dnDevInst = A caller-supplied device instance handle that is bound to the local machine.
///    ulProperty = A CM_DRP_-prefixed constant value that identifies the device property to be obtained from the registry. These
///                 constants are defined in <i>Cfgmgr32.h</i>.
///    pulRegDataType = Optional, can be <b>NULL</b>. A pointer to a location that receives the registry data type, specified as a
///                     REG_-prefixed constant defined in <i>Winnt.h</i>.
///    Buffer = Optional, can be <b>NULL</b>. A pointer to a caller-supplied buffer that receives the requested device property.
///             If this value is <b>NULL</b>, the function supplies only the length of the requested data in the address pointed
///             to by <i>pulLength</i>.
///    pulLength = A pointer to a ULONG variable into which the function stores the length, in bytes, of the requested device
///                property. If the <i>Buffer</i> parameter is set to <b>NULL</b>, the ULONG variable must be set to zero. If the
///                <i>Buffer</i> parameter is not set to <b>NULL</b>, the ULONG variable must be set to the length, in bytes, of the
///                caller-supplied buffer.
///    ulFlags = Not used, must be zero.
///Returns:
///    If the operation succeeds, the function returns CR_SUCCESS. Otherwise, it returns one of the CR_-prefixed error
///    codes that are defined in <i>Cfgmgr32.h</i>.
///    
@DllImport("SETUPAPI")
uint CM_Get_DevNode_Registry_PropertyW(uint dnDevInst, uint ulProperty, uint* pulRegDataType, char* Buffer, 
                                       uint* pulLength, uint ulFlags);

@DllImport("SETUPAPI")
uint CM_Get_DevNode_Registry_Property_ExA(uint dnDevInst, uint ulProperty, uint* pulRegDataType, char* Buffer, 
                                          uint* pulLength, uint ulFlags, ptrdiff_t hMachine);

@DllImport("SETUPAPI")
uint CM_Get_DevNode_Registry_Property_ExW(uint dnDevInst, uint ulProperty, uint* pulRegDataType, char* Buffer, 
                                          uint* pulLength, uint ulFlags, ptrdiff_t hMachine);

@DllImport("SETUPAPI")
uint CM_Get_DevNode_Custom_PropertyA(uint dnDevInst, const(char)* pszCustomPropertyName, uint* pulRegDataType, 
                                     char* Buffer, uint* pulLength, uint ulFlags);

@DllImport("SETUPAPI")
uint CM_Get_DevNode_Custom_PropertyW(uint dnDevInst, const(wchar)* pszCustomPropertyName, uint* pulRegDataType, 
                                     char* Buffer, uint* pulLength, uint ulFlags);

@DllImport("SETUPAPI")
uint CM_Get_DevNode_Custom_Property_ExA(uint dnDevInst, const(char)* pszCustomPropertyName, uint* pulRegDataType, 
                                        char* Buffer, uint* pulLength, uint ulFlags, ptrdiff_t hMachine);

@DllImport("SETUPAPI")
uint CM_Get_DevNode_Custom_Property_ExW(uint dnDevInst, const(wchar)* pszCustomPropertyName, uint* pulRegDataType, 
                                        char* Buffer, uint* pulLength, uint ulFlags, ptrdiff_t hMachine);

///The <b>CM_Get_DevNode_Status</b> function obtains the status of a device instance from its device node (devnode) in
///the local machine's device tree.
///Params:
///    pulStatus = Address of a location to receive status bit flags. The function can set any combination of the
///                <b>DN_-</b>prefixed bit flags defined in <i>Cfg.h</i>.
///    pulProblemNumber = Address of a location to receive one of the <b>CM_PROB_</b>-prefixed problem values defined in <i>Cfg.h</i>. Used
///                       only if DN_HAS_PROBLEM is set in <i>pulStatus</i>.
///    dnDevInst = Caller-supplied device instance handle that is bound to the local machine.
///    ulFlags = Not used, must be zero.
///Returns:
///    If the operation succeeds, the function returns CR_SUCCESS. Otherwise, it returns one of the CR_-prefixed error
///    codes defined in <i>Cfgmgr32.h</i>.
///    
@DllImport("SETUPAPI")
uint CM_Get_DevNode_Status(uint* pulStatus, uint* pulProblemNumber, uint dnDevInst, uint ulFlags);

///<p class="CCE_Message">[Beginning with Windows 8 and Windows Server 2012, this function has been deprecated. Please
///use CM_Get_DevNode_Status instead.] The <b>CM_Get_DevNode_Status_Ex</b> function obtains the status of a device
///instance from its device node (devnode) on a local or a remote machine's device tree.
///Params:
///    pulStatus = Address of a location to receive status bit flags. The function can set any combination of the DN_-prefixed bit
///                flags defined in <i>Cfg.h</i>.
///    pulProblemNumber = Address of a location to receive one of the CM_PROB_-prefixed problem values defined in <i>Cfg.h</i>. Used only
///                       if DN_HAS_PROBLEM is set in <i>pulStatus</i>.
///    dnDevInst = Caller-supplied device instance handle that is bound to the machine handle supplied by <i>hMachine</i>.
///    ulFlags = Not used, must be zero.
///    hMachine = Caller-supplied machine handle to which the caller-supplied device instance handle is bound. <div
///               class="alert"><b>Note</b> Using this function to access remote machines is not supported beginning with Windows 8
///               and Windows Server 2012, as this functionality has been removed.</div> <div> </div>
///Returns:
///    If the operation succeeds, the function returns CR_SUCCESS. Otherwise, it returns one of the CR_-prefixed error
///    codes defined in <i>Cfgmgr32.h</i>.
///    
@DllImport("SETUPAPI")
uint CM_Get_DevNode_Status_Ex(uint* pulStatus, uint* pulProblemNumber, uint dnDevInst, uint ulFlags, 
                              ptrdiff_t hMachine);

///The <b>CM_Get_First_Log_Conf</b> function obtains the first logical configuration, of a specified configuration type,
///associated with a specified device instance on the local machine.
///Params:
///    plcLogConf = Address of a location to receive the handle to a logical configuration, or <b>NULL</b>. See the following
///                 <b>Remarks</b> section.
///    dnDevInst = Caller-supplied device instance handle that is bound to the local machine.
///    ulFlags = Caller-supplied flag value indicating the type of logical configuration being requested. One of the flags in the
///              following table must be specified. <table> <tr> <th>Configuration Type Flags</th> <th>Definitions</th> </tr> <tr>
///              <td> BASIC_LOG_CONF </td> <td> The caller is requesting basic configuration information. </td> </tr> <tr> <td>
///              FILTERED_LOG_CONF </td> <td> The caller is requesting filtered configuration information. </td> </tr> <tr> <td>
///              ALLOC_LOG_CONF </td> <td> The caller is requesting allocated configuration information. </td> </tr> <tr> <td>
///              BOOT_LOG_CONF </td> <td> The caller is requesting boot configuration information. </td> </tr> <tr> <td>
///              FORCED_LOG_CONF </td> <td> The caller is requesting forced configuration information. </td> </tr> <tr> <td>
///              OVERRIDE_LOG_CONF </td> <td> The caller is requesting override configuration information. </td> </tr> </table>
///Returns:
///    If the operation succeeds, the function returns CR_SUCCESS. Otherwise, it returns one of the CR_-prefixed error
///    codes defined in <i>Cfgmgr32.h</i>. <div class="alert"><b>Note</b> Starting with Windows 8,
///    <b>CM_Get_First_Log_Conf</b> returns CR_CALL_NOT_IMPLEMENTED when used in a Wow64 scenario. To request
///    information about the hardware resources on a local machine it is necessary implement an architecture-native
///    version of the application using the hardware resource APIs. For example: An AMD64 application for AMD64
///    systems.</div> <div> </div>
///    
@DllImport("SETUPAPI")
uint CM_Get_First_Log_Conf(size_t* plcLogConf, uint dnDevInst, uint ulFlags);

///<p class="CCE_Message">[Beginning with Windows 8 and Windows Server 2012, this function has been deprecated. Please
///use CM_Get_First_Log_Conf instead.] The <b>CM_Get_First_Log_Conf_Ex</b> function obtains the first logical
///configuration associated with a specified device instance on a local or a remote machine.
///Params:
///    plcLogConf = Address of a location to receive the handle to a logical configuration, or <b>NULL</b>. See the <b>Remarks</b>
///                 section.
///    dnDevInst = Caller-supplied device instance handle that is bound to the machine handle supplied by <i>hMachine</i>.
///    ulFlags = Caller-supplied flag value indicating the type of logical configuration being requested. For a list of flags, see
///              the <i>ulFlags</i> description for CM_Get_First_Log_Conf.
///    hMachine = Caller-supplied machine handle to which the caller-supplied device instance handle is bound. <div
///               class="alert"><b>Note</b> Using this function to access remote machines is not supported beginning with Windows 8
///               and Windows Server 2012, as this functionality has been removed.</div> <div> </div>
///Returns:
///    If the operation succeeds, the function returns CR_SUCCESS. Otherwise, it returns one of the CR_-prefixed error
///    codes defined in <i>Cfgmgr32.h</i>. <div class="alert"><b>Note</b> Starting with Windows 8,
///    <b>CM_Get_First_Log_Conf_Ex</b> returns CR_CALL_NOT_IMPLEMENTED when used in a Wow64 scenario. To request
///    information about the hardware resources on a local machine it is necessary implement an architecture-native
///    version of the application using the hardware resource APIs. For example: An AMD64 application for AMD64
///    systems.</div> <div> </div>
///    
@DllImport("SETUPAPI")
uint CM_Get_First_Log_Conf_Ex(size_t* plcLogConf, uint dnDevInst, uint ulFlags, ptrdiff_t hMachine);

@DllImport("SETUPAPI")
uint CM_Get_Global_State(uint* pulState, uint ulFlags);

@DllImport("SETUPAPI")
uint CM_Get_Global_State_Ex(uint* pulState, uint ulFlags, ptrdiff_t hMachine);

@DllImport("SETUPAPI")
uint CM_Get_Hardware_Profile_InfoA(uint ulIndex, HWProfileInfo_sA* pHWProfileInfo, uint ulFlags);

@DllImport("SETUPAPI")
uint CM_Get_Hardware_Profile_Info_ExA(uint ulIndex, HWProfileInfo_sA* pHWProfileInfo, uint ulFlags, 
                                      ptrdiff_t hMachine);

@DllImport("SETUPAPI")
uint CM_Get_Hardware_Profile_InfoW(uint ulIndex, HWProfileInfo_sW* pHWProfileInfo, uint ulFlags);

@DllImport("SETUPAPI")
uint CM_Get_Hardware_Profile_Info_ExW(uint ulIndex, HWProfileInfo_sW* pHWProfileInfo, uint ulFlags, 
                                      ptrdiff_t hMachine);

///<p class="CCE_Message">[Beginning with Windows 8 and Windows Server 2012, this function has been deprecated and
///should not be used.] The <b>CM_Get_HW_Prof_Flags</b> function retrieves the hardware profile-specific configuration
///flags for a device instance on a local machine.
///Params:
///    pDeviceID = Pointer to a NULL-terminated string that contains the device instance ID of the device for which to retrieve
///                hardware profile-specific configuration flags.
///    ulHardwareProfile = A variable of ULONG type that specifies the identifier of the hardware profile for which to retrieve
///                        configuration flags. If this parameter is zero, this function retrieves the configuration flags for the current
///                        hardware profile.
///    pulValue = Pointer to a caller-supplied variable of ULONG type that receives zero or a bitwise OR of the following
///               configuration flags that are defined in <i>Regstr.h</i>:
///    ulFlags = Reserved for internal use. Must be set to zero.
///Returns:
///    If the operation succeeds, <b>CM_Get_HW_Prof_Flags</b> returns CR_SUCCESS. Otherwise, the function returns one of
///    the CR_<i>Xxx</i> error codes that are defined in <i>Cfgmgr32.h</i>.
///    
@DllImport("SETUPAPI")
uint CM_Get_HW_Prof_FlagsA(byte* pDeviceID, uint ulHardwareProfile, uint* pulValue, uint ulFlags);

///<p class="CCE_Message">[Beginning with Windows 8 and Windows Server 2012, this function has been deprecated and
///should not be used.] The <b>CM_Get_HW_Prof_Flags</b> function retrieves the hardware profile-specific configuration
///flags for a device instance on a local machine.
///Params:
///    pDeviceID = Pointer to a NULL-terminated string that contains the device instance ID of the device for which to retrieve
///                hardware profile-specific configuration flags.
///    ulHardwareProfile = A variable of ULONG type that specifies the identifier of the hardware profile for which to retrieve
///                        configuration flags. If this parameter is zero, this function retrieves the configuration flags for the current
///                        hardware profile.
///    pulValue = Pointer to a caller-supplied variable of ULONG type that receives zero or a bitwise OR of the following
///               configuration flags that are defined in <i>Regstr.h</i>:
///    ulFlags = Reserved for internal use. Must be set to zero.
///Returns:
///    If the operation succeeds, <b>CM_Get_HW_Prof_Flags</b> returns CR_SUCCESS. Otherwise, the function returns one of
///    the CR_<i>Xxx</i> error codes that are defined in <i>Cfgmgr32.h</i>.
///    
@DllImport("SETUPAPI")
uint CM_Get_HW_Prof_FlagsW(ushort* pDeviceID, uint ulHardwareProfile, uint* pulValue, uint ulFlags);

///<p class="CCE_Message">[This function has been deprecated and should not be used.] The <b>CM_Get_HW_Prof_Flags_Ex</b>
///function retrieves the hardware profile-specific configuration flags for a device instance on a remote machine or a
///local machine.
///Params:
///    pDeviceID = Pointer to a NULL-terminated string that contains the device instance ID of the device for which to retrieve
///                hardware profile-specific configuration flags.
///    ulHardwareProfile = A variable of ULONG type that specifies the identifier of the hardware profile for which to retrieve
///                        configuration flags. If this parameter is zero, this function retrieves the configuration flags for the current
///                        hardware profile.
///    pulValue = Pointer to a caller-supplied variable of ULONG type that receives zero or a bitwise OR of the following
///               configuration flags that are defined in <i>Regstr.h</i>:
///    ulFlags = Reserved for internal use. Must be set to zero.
///    hMachine = A machine handle that is returned by call to CM_Connect_Machine or <b>NULL</b>. If this parameter is set to
///               <b>NULL</b>, <b>CM_Get_HW_Prof_Flags_Ex</b> retrieves the configuration flags on the local machine. <div
///               class="alert"><b>Note</b> Using this function to access remote machines is not supported beginning with Windows 8
///               and Windows Server 2012, as this functionality has been removed.</div> <div> </div>
///Returns:
///    If the operation succeeds, <b>CM_Get_HW_Prof_Flags</b> returns CR_SUCCESS. Otherwise, the function returns one of
///    the CR_-prefixed error codes that are defined in <i>Cfgmgr32.h</i>.
///    
@DllImport("SETUPAPI")
uint CM_Get_HW_Prof_Flags_ExA(byte* pDeviceID, uint ulHardwareProfile, uint* pulValue, uint ulFlags, 
                              ptrdiff_t hMachine);

///<p class="CCE_Message">[This function has been deprecated and should not be used.] The <b>CM_Get_HW_Prof_Flags_Ex</b>
///function retrieves the hardware profile-specific configuration flags for a device instance on a remote machine or a
///local machine.
///Params:
///    pDeviceID = Pointer to a NULL-terminated string that contains the device instance ID of the device for which to retrieve
///                hardware profile-specific configuration flags.
///    ulHardwareProfile = A variable of ULONG type that specifies the identifier of the hardware profile for which to retrieve
///                        configuration flags. If this parameter is zero, this function retrieves the configuration flags for the current
///                        hardware profile.
///    pulValue = Pointer to a caller-supplied variable of ULONG type that receives zero or a bitwise OR of the following
///               configuration flags that are defined in <i>Regstr.h</i>:
///    ulFlags = Reserved for internal use. Must be set to zero.
///    hMachine = A machine handle that is returned by call to CM_Connect_Machine or <b>NULL</b>. If this parameter is set to
///               <b>NULL</b>, <b>CM_Get_HW_Prof_Flags_Ex</b> retrieves the configuration flags on the local machine. <div
///               class="alert"><b>Note</b> Using this function to access remote machines is not supported beginning with Windows 8
///               and Windows Server 2012, as this functionality has been removed.</div> <div> </div>
///Returns:
///    If the operation succeeds, <b>CM_Get_HW_Prof_Flags</b> returns CR_SUCCESS. Otherwise, the function returns one of
///    the CR_-prefixed error codes that are defined in <i>Cfgmgr32.h</i>.
///    
@DllImport("SETUPAPI")
uint CM_Get_HW_Prof_Flags_ExW(ushort* pDeviceID, uint ulHardwareProfile, uint* pulValue, uint ulFlags, 
                              ptrdiff_t hMachine);

@DllImport("SETUPAPI")
uint CM_Get_Device_Interface_AliasA(const(char)* pszDeviceInterface, GUID* AliasInterfaceGuid, 
                                    const(char)* pszAliasDeviceInterface, uint* pulLength, uint ulFlags);

///The <b>CM_Get_Device_Interface_Alias</b> function returns the alias of the specified device interface instance, if
///the alias exists.
///Params:
///    pszDeviceInterface = Pointer to the name of the device interface instance for which to retrieve an alias. The caller typically
///                         received this string from a call to CM_Get_Device_Interface_List, or in a PnP notification structure.
///    AliasInterfaceGuid = Pointer to a GUID specifying the interface class of the alias to retrieve.
///    pszAliasDeviceInterface = Specifies a pointer to a buffer, that upon successful return, points to a string containing the name of the
///                              alias. The caller must free this string when it is no longer needed. A buffer is required. Otherwise, the call
///                              will fail.
///    pulLength = Supplies the count of characters in <i>pszAliasDeviceInterface</i> and receives the number of characters required
///                to hold the alias device interface. On input, this parameter must be greater than 0.
///    ulFlags = Reserved. Do not use.
///Returns:
///    If the operation succeeds, the function returns CR_SUCCESS. Otherwise, it returns one of the CR_-prefixed error
///    codes defined in <i>Cfgmgr32.h</i>. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>CR_NO_SUCH_DEVICE_INTERFACE</b></dt> </dl> </td> <td width="60%"> Possibly indicates
///    that there is no alias of the specified interface class. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>CR_OUT_OF_MEMORY</b></dt> </dl> </td> <td width="60%"> There is not enough memory to complete the
///    operation. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>CR_BUFFER_SMALL</b></dt> </dl> </td> <td width="60%">
///    The buffer passed is too small. </td> </tr> </table>
///    
@DllImport("SETUPAPI")
uint CM_Get_Device_Interface_AliasW(const(wchar)* pszDeviceInterface, GUID* AliasInterfaceGuid, 
                                    const(wchar)* pszAliasDeviceInterface, uint* pulLength, uint ulFlags);

@DllImport("SETUPAPI")
uint CM_Get_Device_Interface_Alias_ExA(const(char)* pszDeviceInterface, GUID* AliasInterfaceGuid, 
                                       const(char)* pszAliasDeviceInterface, uint* pulLength, uint ulFlags, 
                                       ptrdiff_t hMachine);

@DllImport("SETUPAPI")
uint CM_Get_Device_Interface_Alias_ExW(const(wchar)* pszDeviceInterface, GUID* AliasInterfaceGuid, 
                                       const(wchar)* pszAliasDeviceInterface, uint* pulLength, uint ulFlags, 
                                       ptrdiff_t hMachine);

///The <b>CM_Get_Device_Interface_List</b> function retrieves a list of device interface instances that belong to a
///specified device interface class.
///Params:
///    InterfaceClassGuid = Supplies a GUID that identifies a device interface class.
///    pDeviceID = Caller-supplied pointer to a NULL-terminated string that represents a device instance ID. If specified, the
///                function retrieves device interfaces that are supported by the device for the specified class. If this value is
///                <b>NULL</b>, or if it points to a zero-length string, the function retrieves all interfaces that belong to the
///                specified class.
///    Buffer = Caller-supplied pointer to a buffer that receives multiple, NULL-terminated Unicode strings, each representing
///             the symbolic link name of an interface instance.
///    BufferLen = Caller-supplied value that specifies the length, in characters, of the buffer pointed to by <i>Buffer</i>. Call
///                CM_Get_Device_Interface_List_Size to determine the required buffer size.
///    ulFlags = Contains one of the following caller-supplied flags:
///Returns:
///    If the operation succeeds, the function returns CR_SUCCESS. Otherwise, it returns one of the error codes with the
///    CR_ prefix as defined in <i>Cfgmgr32.h</i>. The following table includes some of the more common error codes that
///    this function might return. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
///    <dl> <dt><b>CR_BUFFER_SMALL</b></dt> </dl> </td> <td width="60%"> The <i>Buffer</i> buffer is too small to hold
///    the requested list of device interfaces. </td> </tr> </table>
///    
@DllImport("SETUPAPI")
uint CM_Get_Device_Interface_ListA(GUID* InterfaceClassGuid, byte* pDeviceID, const(char)* Buffer, uint BufferLen, 
                                   uint ulFlags);

///The <b>CM_Get_Device_Interface_List</b> function retrieves a list of device interface instances that belong to a
///specified device interface class.
///Params:
///    InterfaceClassGuid = Supplies a GUID that identifies a device interface class.
///    pDeviceID = Caller-supplied pointer to a NULL-terminated string that represents a device instance ID. If specified, the
///                function retrieves device interfaces that are supported by the device for the specified class. If this value is
///                <b>NULL</b>, or if it points to a zero-length string, the function retrieves all interfaces that belong to the
///                specified class.
///    Buffer = Caller-supplied pointer to a buffer that receives multiple, NULL-terminated Unicode strings, each representing
///             the symbolic link name of an interface instance.
///    BufferLen = Caller-supplied value that specifies the length, in characters, of the buffer pointed to by <i>Buffer</i>. Call
///                CM_Get_Device_Interface_List_Size to determine the required buffer size.
///    ulFlags = Contains one of the following caller-supplied flags:
///Returns:
///    If the operation succeeds, the function returns CR_SUCCESS. Otherwise, it returns one of the error codes with the
///    CR_ prefix as defined in <i>Cfgmgr32.h</i>. The following table includes some of the more common error codes that
///    this function might return. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
///    <dl> <dt><b>CR_BUFFER_SMALL</b></dt> </dl> </td> <td width="60%"> The <i>Buffer</i> buffer is too small to hold
///    the requested list of device interfaces. </td> </tr> </table>
///    
@DllImport("SETUPAPI")
uint CM_Get_Device_Interface_ListW(GUID* InterfaceClassGuid, ushort* pDeviceID, const(wchar)* Buffer, 
                                   uint BufferLen, uint ulFlags);

@DllImport("SETUPAPI")
uint CM_Get_Device_Interface_List_ExA(GUID* InterfaceClassGuid, byte* pDeviceID, const(char)* Buffer, 
                                      uint BufferLen, uint ulFlags, ptrdiff_t hMachine);

@DllImport("SETUPAPI")
uint CM_Get_Device_Interface_List_ExW(GUID* InterfaceClassGuid, ushort* pDeviceID, const(wchar)* Buffer, 
                                      uint BufferLen, uint ulFlags, ptrdiff_t hMachine);

///The <b>CM_Get_Device_Interface_List_Size</b> function retrieves the buffer size that must be passed to the
///CM_Get_Device_Interface_List function.
///Params:
///    pulLen = Caller-supplied pointer to a location that receives the required length, in characters, of a buffer to hold the
///             multiple Unicode strings that will be returned by <b>CM_Get_Device_Interface_List</b>.
///    InterfaceClassGuid = Supplies a GUID that identifies a device interface class.
///    pDeviceID = Caller-supplied pointer to a NULL-terminated string that represents a device instance ID. If specified, the
///                function retrieves the length of symbolic link names for the device interfaces that are supported by the device,
///                for the specified class. If this value is <b>NULL</b>, or if it points to a zero-length string, the function
///                retrieves the length of symbolic link names for all interfaces that belong to the specified class.
///    ulFlags = Contains one of the following caller-supplied flags: <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td
///              width="40%"><a id="CM_GET_DEVICE_INTERFACE_LIST_ALL_DEVICES"></a><a
///              id="cm_get_device_interface_list_all_devices"></a><dl> <dt><b>CM_GET_DEVICE_INTERFACE_LIST_ALL_DEVICES</b></dt>
///              </dl> </td> <td width="60%"> The function provides the size of a list that contains device interfaces associated
///              with all devices that match the specified <b>GUID</b> and device instance ID, if any. </td> </tr> <tr> <td
///              width="40%"><a id="CM_GET_DEVICE_INTERFACE_LIST_PRESENT"></a><a
///              id="cm_get_device_interface_list_present"></a><dl> <dt><b>CM_GET_DEVICE_INTERFACE_LIST_PRESENT</b></dt> </dl>
///              </td> <td width="60%"> The function provides the size of a list containing device interfaces associated with
///              devices that are currently active, and which match the specified GUID and device instance ID, if any. </td> </tr>
///              </table>
///Returns:
///    If the operation succeeds, the function returns <b>CR_SUCCESS</b>. Otherwise, it returns one of the error codes
///    with the <b>CR_</b> prefix as defined in Cfgmgr32.h.
///    
@DllImport("SETUPAPI")
uint CM_Get_Device_Interface_List_SizeA(uint* pulLen, GUID* InterfaceClassGuid, byte* pDeviceID, uint ulFlags);

///The <b>CM_Get_Device_Interface_List_Size</b> function retrieves the buffer size that must be passed to the
///CM_Get_Device_Interface_List function.
///Params:
///    pulLen = Caller-supplied pointer to a location that receives the required length, in characters, of a buffer to hold the
///             multiple Unicode strings that will be returned by <b>CM_Get_Device_Interface_List</b>.
///    InterfaceClassGuid = Supplies a GUID that identifies a device interface class.
///    pDeviceID = Caller-supplied pointer to a NULL-terminated string that represents a device instance ID. If specified, the
///                function retrieves the length of symbolic link names for the device interfaces that are supported by the device,
///                for the specified class. If this value is <b>NULL</b>, or if it points to a zero-length string, the function
///                retrieves the length of symbolic link names for all interfaces that belong to the specified class.
///    ulFlags = Contains one of the following caller-supplied flags: <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td
///              width="40%"><a id="CM_GET_DEVICE_INTERFACE_LIST_ALL_DEVICES"></a><a
///              id="cm_get_device_interface_list_all_devices"></a><dl> <dt><b>CM_GET_DEVICE_INTERFACE_LIST_ALL_DEVICES</b></dt>
///              </dl> </td> <td width="60%"> The function provides the size of a list that contains device interfaces associated
///              with all devices that match the specified <b>GUID</b> and device instance ID, if any. </td> </tr> <tr> <td
///              width="40%"><a id="CM_GET_DEVICE_INTERFACE_LIST_PRESENT"></a><a
///              id="cm_get_device_interface_list_present"></a><dl> <dt><b>CM_GET_DEVICE_INTERFACE_LIST_PRESENT</b></dt> </dl>
///              </td> <td width="60%"> The function provides the size of a list containing device interfaces associated with
///              devices that are currently active, and which match the specified GUID and device instance ID, if any. </td> </tr>
///              </table>
///Returns:
///    If the operation succeeds, the function returns <b>CR_SUCCESS</b>. Otherwise, it returns one of the error codes
///    with the <b>CR_</b> prefix as defined in Cfgmgr32.h.
///    
@DllImport("SETUPAPI")
uint CM_Get_Device_Interface_List_SizeW(uint* pulLen, GUID* InterfaceClassGuid, ushort* pDeviceID, uint ulFlags);

@DllImport("SETUPAPI")
uint CM_Get_Device_Interface_List_Size_ExA(uint* pulLen, GUID* InterfaceClassGuid, byte* pDeviceID, uint ulFlags, 
                                           ptrdiff_t hMachine);

@DllImport("SETUPAPI")
uint CM_Get_Device_Interface_List_Size_ExW(uint* pulLen, GUID* InterfaceClassGuid, ushort* pDeviceID, uint ulFlags, 
                                           ptrdiff_t hMachine);

///The <b>CM_Get_Device_Interface_Property</b> function retrieves a device property that is set for a device interface.
///Params:
///    pszDeviceInterface = Pointer to a string that identifies the device interface instance to retrieve the property from.
///    PropertyKey = Pointer to a DEVPROPKEY structure that represents the device interface property key of the device interface
///                  property to retrieve.
///    PropertyType = Pointer to a DEVPROPTYPE-typed variable that receives the property-data-type identifier of the requested device
///                   interface property. The property-data-type identifier is a bitwise OR between a base-data-type identifier and, if
///                   the base-data type is modified, a property-data-type modifier.
///    PropertyBuffer = A pointer to a buffer that receives the requested device interface property.
///                     <b>CM_Get_Device_Interface_Property</b> retrieves the requested property only if the buffer is large enough to
///                     hold all the property value data. The pointer can be NULL.
///    PropertyBufferSize = The size, in bytes, of the <i>PropertyBuffer</i> buffer. If <i>PropertyBuffer</i> is set to NULL,
///                         <i>*PropertyBufferSize</i> must be set to zero. As output, if the buffer is not large enough to hold all the
///                         property value data, <b>CM_Get_Device_Interface_Property</b> returns the size of the data, in bytes, in
///                         <i>*PropertyBufferSize</i>.
///    ulFlags = Reserved. Must be set to zero.
///Returns:
///    If the operation succeeds, the function returns CR_SUCCESS. Otherwise, it returns one of the CR_-prefixed error
///    codes defined in <i>Cfgmgr32.h</i>.
///    
@DllImport("api-ms-win-devices-config-l1-1-1")
uint CM_Get_Device_Interface_PropertyW(const(wchar)* pszDeviceInterface, const(DEVPROPKEY)* PropertyKey, 
                                       uint* PropertyType, char* PropertyBuffer, uint* PropertyBufferSize, 
                                       uint ulFlags);

///<p class="CCE_Message">[Beginning with Windows 8 and Windows Server 2012, this function has been deprecated. Please
///use CM_Get_Device_Interface_Property instead.] The <b>CM_Get_Device_Interface_Property_ExW</b> function retrieves a
///device property that is set for a device interface.
///Params:
///    pszDeviceInterface = Pointer to a string that identifies the device interface instance to retrieve the property from.
///    PropertyKey = Pointer to a DEVPROPKEY structure that represents the device interface property key of the device interface
///                  property to retrieve.
///    PropertyType = Pointer to a DEVPROPTYPE-typed variable that receives the property-data-type identifier of the requested device
///                   interface property. The property-data-type identifier is a bitwise OR between a base-data-type identifier and, if
///                   the base-data type is modified, a property-data-type modifier.
///    PropertyBuffer = A pointer to a buffer that receives the requested device interface property.
///                     <b>CM_Get_Device_Interface_Property_ExW</b> retrieves the requested property only if the buffer is large enough
///                     to hold all the property value data. The pointer can be NULL.
///    PropertyBufferSize = The size, in bytes, of the <i>PropertyBuffer</i> buffer. If <i>PropertyBuffer</i> is set to NULL,
///                         <i>*PropertyBufferSize</i> must be set to zero. As output, if the buffer is not large enough to hold all the
///                         property value data, <b>CM_Get_Device_Interface_Property_ExW</b> returns the size of the data, in bytes, in
///                         <i>*PropertyBufferSize</i>.
///    ulFlags = Reserved. Must be set to zero.
///    hMachine = Caller-supplied machine handle, obtained from a previous call to CM_Connect_Machine. <div
///               class="alert"><b>Note</b> Using this function to access remote machines is not supported beginning with Windows 8
///               and Windows Server 2012, as this functionality has been removed.</div> <div> </div>
///Returns:
///    If the operation succeeds, the function returns CR_SUCCESS. Otherwise, it returns one of the CR_-prefixed error
///    codes defined in <i>Cfgmgr32.h</i>.
///    
@DllImport("CFGMGR32")
uint CM_Get_Device_Interface_Property_ExW(const(wchar)* pszDeviceInterface, const(DEVPROPKEY)* PropertyKey, 
                                          uint* PropertyType, char* PropertyBuffer, uint* PropertyBufferSize, 
                                          uint ulFlags, ptrdiff_t hMachine);

///The <b>CM_Get_Device_Interface_Property_Keys</b> function retrieves an array of device property keys that represent
///the device properties that are set for a device interface.
///Params:
///    pszDeviceInterface = Pointer to a string that identifies the device interface instance to retrieve the property keys from.
///    PropertyKeyArray = Pointer to a buffer that receives an array of DEVPROPKEY-typed values, where each value is a device property key
///                       that represents a device property that is set for the device interface. The pointer is optional and can be NULL
///    PropertyKeyCount = The size, in DEVPROPKEY-typed units, of the <i>PropertyKeyArray</i> buffer. If <i>PropertyKeyArray</i> is set to
///                       NULL, <i>*PropertyKeyCount</i> must be set to zero. As output, if <i>PropertyKeyArray</i> is not large enough to
///                       hold all the property key data, <b>CM_Get_Device_Interface_Property_Keys</b> returns the count of the keys, in
///                       <i>*PropertyKeyCount</i>.
///    ulFlags = Reserved. Must be set to zero.
///Returns:
///    If the operation succeeds, the function returns CR_SUCCESS. Otherwise, it returns one of the CR_-prefixed error
///    codes defined in <i>Cfgmgr32.h</i>.
///    
@DllImport("api-ms-win-devices-config-l1-1-1")
uint CM_Get_Device_Interface_Property_KeysW(const(wchar)* pszDeviceInterface, char* PropertyKeyArray, 
                                            uint* PropertyKeyCount, uint ulFlags);

///<p class="CCE_Message">[Beginning with Windows 8 and Windows Server 2012, this function has been deprecated. Please
///use CM_Get_Device_Interface_Property_Keys instead.] The <b>CM_Get_Device_Interface_Property_Keys_ExW</b> function
///retrieves an array of device property keys that represent the device properties that are set for a device interface.
///Params:
///    pszDeviceInterface = Pointer to a string that identifies the device interface instance to retrieve the property keys from.
///    PropertyKeyArray = Pointer to a buffer that receives an array of DEVPROPKEY-typed values, where each value is a device property key
///                       that represents a device property that is set for the device interface. The pointer is optional and can be NULL
///    PropertyKeyCount = The size, in DEVPROPKEY-typed units, of the <i>PropertyKeyArray</i> buffer. If <i>PropertyKeyArray</i> is set to
///                       NULL, <i>*PropertyKeyCount</i> must be set to zero. As output, if <i>PropertyKeyArray</i> is not large enough to
///                       hold all the property key data, <b>CM_Get_Device_Interface_Property_Keys_ExW</b> returns the count of the keys,
///                       in <i>*PropertyKeyCount</i>.
///    ulFlags = Reserved. Must be set to zero.
///    hMachine = Caller-supplied machine handle, obtained from a previous call to CM_Connect_Machine. <div
///               class="alert"><b>Note</b> Using this function to access remote machines is not supported beginning with Windows 8
///               and Windows Server 2012, as this functionality has been removed.</div> <div> </div>
///Returns:
///    If the operation succeeds, the function returns CR_SUCCESS. Otherwise, it returns one of the CR_-prefixed error
///    codes defined in <i>Cfgmgr32.h</i>.
///    
@DllImport("CFGMGR32")
uint CM_Get_Device_Interface_Property_Keys_ExW(const(wchar)* pszDeviceInterface, char* PropertyKeyArray, 
                                               uint* PropertyKeyCount, uint ulFlags, ptrdiff_t hMachine);

///The <b>CM_Get_Log_Conf_Priority</b> function obtains the configuration priority of a specified logical configuration
///on the local machine.
///Params:
///    lcLogConf = Caller-supplied handle to a logical configuration. This handle must have been previously obtained by calling one
///                of the following functions: CM_Add_Empty_Log_Conf CM_Add_Empty_Log_Conf_Ex CM_Get_First_Log_Conf
///                CM_Get_First_Log_Conf_Ex CM_Get_Next_Log_Conf CM_Get_Next_Log_Conf_Ex
///    pPriority = Caller-supplied address of a location to receive a configuration priority value. For a list of priority values,
///                see the description of <i>Priority</i> for CM_Add_Empty_Log_Conf.
///    ulFlags = Not used, must be zero.
///Returns:
///    If the operation succeeds, the function returns CR_SUCCESS. Otherwise, it returns one of the CR_-prefixed error
///    codes defined in <i>Cfgmgr32.h</i>. <div class="alert"><b>Note</b> Starting with Windows 8,
///    <b>CM_Get_Log_Conf_Priority</b> returns CR_CALL_NOT_IMPLEMENTED when used in a Wow64 scenario. To request
///    information about the hardware resources on a local machine it is necessary implement an architecture-native
///    version of the application using the hardware resource APIs. For example: An AMD64 application for AMD64
///    systems.</div> <div> </div>
///    
@DllImport("SETUPAPI")
uint CM_Get_Log_Conf_Priority(size_t lcLogConf, uint* pPriority, uint ulFlags);

///<p class="CCE_Message">[Beginning with Windows 8 and Windows Server 2012, this function has been deprecated. Please
///use CM_Get_Log_Conf_Priority instead.] The <b>CM_Get_Log_Conf_Priority_Ex</b> function obtains the configuration
///priority of a specified logical configuration on a local or a remote machine.
///Params:
///    lcLogConf = Caller-supplied handle to a logical configuration. This handle must have been previously obtained by calling one
///                of the following functions: CM_Add_Empty_Log_Conf CM_Add_Empty_Log_Conf_Ex CM_Get_First_Log_Conf
///                CM_Get_First_Log_Conf_Ex CM_Get_Next_Log_Conf CM_Get_Next_Log_Conf_Ex
///    pPriority = Caller-supplied address of a location to receive a configuration priority value. For a list of priority values,
///                see the description of <i>Priority</i> for CM_Add_Empty_Log_Conf_Ex.
///    ulFlags = Not used, must be zero.
///    hMachine = Caller-supplied machine handle, obtained from a previous call to CM_Connect_Machine. <div
///               class="alert"><b>Note</b> Using this function to access remote machines is not supported beginning with Windows 8
///               and Windows Server 2012, as this functionality has been removed.</div> <div> </div>
///Returns:
///    If the operation succeeds, the function returns CR_SUCCESS. Otherwise, it returns one of the CR_-prefixed error
///    codes defined in <i>Cfgmgr32.h</i>. <div class="alert"><b>Note</b> Starting with Windows 8,
///    <b>CM_Get_Log_Conf_Priority_Ex</b> returns CR_CALL_NOT_IMPLEMENTED when used in a Wow64 scenario. To request
///    information about the hardware resources on a local machine it is necessary implement an architecture-native
///    version of the application using the hardware resource APIs. For example: An AMD64 application for AMD64
///    systems.</div> <div> </div>
///    
@DllImport("SETUPAPI")
uint CM_Get_Log_Conf_Priority_Ex(size_t lcLogConf, uint* pPriority, uint ulFlags, ptrdiff_t hMachine);

///The <b>CM_Get_Next_Log_Conf</b> function obtains the next logical configuration associated with a specific device
///instance on the local machine.
///Params:
///    plcLogConf = Address of a location to receive the handle to a logical configuration, or <b>NULL</b>. (See the following
///                 <b>Remarks</b> section.
///    lcLogConf = Caller-supplied handle to a logical configuration. This handle must have been previously obtained by calling one
///                of the following functions: CM_Get_First_Log_Conf <b>CM_Get_Next_Log_Conf</b>
///    ulFlags = Not used, must be zero.
///Returns:
///    If the operation succeeds, the function returns CR_SUCCESS. Otherwise, it returns one of the CR_-prefixed error
///    codes defined in <i>Cfgmgr32.h</i>. <div class="alert"><b>Note</b> Starting with Windows 8,
///    <b>CM_Get_Next_Log_Conf</b> returns CR_CALL_NOT_IMPLEMENTED when used in a Wow64 scenario. To request information
///    about the hardware resources on a local machine it is necessary implement an architecture-native version of the
///    application using the hardware resource APIs. For example: An AMD64 application for AMD64 systems.</div> <div>
///    </div>
///    
@DllImport("SETUPAPI")
uint CM_Get_Next_Log_Conf(size_t* plcLogConf, size_t lcLogConf, uint ulFlags);

///<p class="CCE_Message">[Beginning with Windows 8 and Windows Server 2012, this function has been deprecated. Please
///use CM_Get_Next_Log_Conf instead.] The <b>CM_Get_Next_Log_Conf_Ex</b> function obtains the next logical configuration
///associated with a specific device instance on a local or a remote machine.
///Params:
///    plcLogConf = Address of a location to receive the handle to a logical configuration, or <b>NULL</b>. (See the following
///                 <b>Remarks</b> section.
///    lcLogConf = Caller-supplied handle to a logical configuration. This handle must have been previously obtained by calling one
///                of the following functions: CM_Get_First_Log_Conf_Ex <b>CM_Get_Next_Log_Conf_Ex</b>
///    ulFlags = Not used, must be zero.
///    hMachine = Caller-supplied machine handle, obtained from a previous call to CM_Connect_Machine. <div
///               class="alert"><b>Note</b> Using this function to access remote machines is not supported beginning with Windows 8
///               and Windows Server 2012, as this functionality has been removed.</div> <div> </div>
///Returns:
///    If the operation succeeds, the function returns CR_SUCCESS. Otherwise, it returns one of the CR_-prefixed error
///    codes defined in <i>Cfgmgr32.h</i>. <div class="alert"><b>Note</b> Starting with Windows 8,
///    <b>CM_Get_Next_Log_Conf_Ex</b> returns CR_CALL_NOT_IMPLEMENTED when used in a Wow64 scenario. To request
///    information about the hardware resources on a local machine it is necessary implement an architecture-native
///    version of the application using the hardware resource APIs. For example: An AMD64 application for AMD64
///    systems.</div> <div> </div>
///    
@DllImport("SETUPAPI")
uint CM_Get_Next_Log_Conf_Ex(size_t* plcLogConf, size_t lcLogConf, uint ulFlags, ptrdiff_t hMachine);

///The <b>CM_Get_Parent</b> function obtains a device instance handle to the parent node of a specified device node
///(devnode) in the local machine's device tree.
///Params:
///    pdnDevInst = Caller-supplied pointer to the device instance handle to the parent node that this function retrieves. The
///                 retrieved handle is bound to the local machine.
///    dnDevInst = Caller-supplied device instance handle that is bound to the local machine.
///    ulFlags = Not used, must be zero.
///Returns:
///    If the operation succeeds, the function returns CR_SUCCESS. Otherwise, it returns one of the CR_-prefixed error
///    codes defined in <i>Cfgmgr32.h</i>.
///    
@DllImport("SETUPAPI")
uint CM_Get_Parent(uint* pdnDevInst, uint dnDevInst, uint ulFlags);

///<p class="CCE_Message">[Beginning with Windows 8 and Windows Server 2012, this function has been deprecated. Please
///use CM_Get_Parent instead.] The <b>CM_Get_Parent_Ex</b> function obtains a device instance handle to the parent node
///of a specified device node (devnode) in a local or a remote machine's device tree.
///Params:
///    pdnDevInst = Caller-supplied pointer to the device instance handle to the parent node that this function retrieves. The
///                 retrieved handle is bound to the machine handle specified by <i>hMachine</i>.
///    dnDevInst = Caller-supplied device instance handle that is bound to the machine handle specified by <i>hMachine</i>.
///    ulFlags = Not used, must be zero.
///    hMachine = Caller-supplied machine handle to which the caller-supplied device instance handle is bound. <div
///               class="alert"><b>Note</b> Using this function to access remote machines is not supported beginning with Windows 8
///               and Windows Server 2012, as this functionality has been removed.</div> <div> </div>
///Returns:
///    If the operation succeeds, the function returns CR_SUCCESS. Otherwise, it returns one of the CR_-prefixed error
///    codes defined in <i>Cfgmgr32.h</i>.
///    
@DllImport("SETUPAPI")
uint CM_Get_Parent_Ex(uint* pdnDevInst, uint dnDevInst, uint ulFlags, ptrdiff_t hMachine);

///The <b>CM_Get_Res_Des_Data</b> function retrieves the information stored in a resource descriptor on the local
///machine.
///Params:
///    rdResDes = Caller-supplied handle to a resource descriptor, obtained by a previous call to CM_Get_Next_Res_Des.
///    Buffer = Address of a buffer to receive the contents of a resource descriptor. The required buffer size should be obtained
///             by calling CM_Get_Res_Des_Data_Size.
///    BufferLen = Caller-supplied length of the buffer specified by <i>Buffer</i>.
///    ulFlags = Not used, must be zero.
///Returns:
///    If the operation succeeds, the function returns CR_SUCCESS. Otherwise, it returns one of the CR_-prefixed error
///    codes defined in <i>Cfgmgr32.h</i>. <div class="alert"><b>Note</b> Starting with Windows 8,
///    <b>CM_Get_Res_Des_Data</b> returns CR_CALL_NOT_IMPLEMENTED when used in a Wow64 scenario. To request information
///    about the hardware resources on a local machine it is necessary implement an architecture-native version of the
///    application using the hardware resource APIs. For example: An AMD64 application for AMD64 systems.</div> <div>
///    </div>
///    
@DllImport("SETUPAPI")
uint CM_Get_Res_Des_Data(size_t rdResDes, char* Buffer, uint BufferLen, uint ulFlags);

///<p class="CCE_Message">[Beginning with Windows 8 and Windows Server 2012, this function has been deprecated. Please
///use CM_Get_Res_Des_Data instead.] The <b>CM_Get_Res_Des_Data_Ex</b> function retrieves the information stored in a
///resource descriptor on a local or a remote machine.
///Params:
///    rdResDes = Caller-supplied handle to a resource descriptor, obtained by a previous call to CM_Get_Next_Res_Des_Ex.
///    Buffer = Address of a buffer to receive the contents of a resource descriptor. The required buffer size should be obtained
///             by calling CM_Get_Res_Des_Data_Size_Ex.
///    BufferLen = Caller-supplied length of the buffer specified by <i>Buffer</i>.
///    ulFlags = Not used, must be zero.
///    hMachine = Caller-supplied machine handle, obtained from a previous call to CM_Connect_Machine. <div
///               class="alert"><b>Note</b> Using this function to access remote machines is not supported beginning with Windows 8
///               and Windows Server 2012, as this functionality has been removed.</div> <div> </div>
///Returns:
///    If the operation succeeds, the function returns CR_SUCCESS. Otherwise, it returns one of the CR_-prefixed error
///    codes defined in <i>Cfgmgr32.h</i>. <div class="alert"><b>Note</b> Starting with Windows 8,
///    <b>CM_Get_Res_Des_Data_Ex</b> returns CR_CALL_NOT_IMPLEMENTED when used in a Wow64 scenario. To request
///    information about the hardware resources on a local machine it is necessary implement an architecture-native
///    version of the application using the hardware resource APIs. For example: An AMD64 application for AMD64
///    systems.</div> <div> </div>
///    
@DllImport("SETUPAPI")
uint CM_Get_Res_Des_Data_Ex(size_t rdResDes, char* Buffer, uint BufferLen, uint ulFlags, ptrdiff_t hMachine);

///The <b>CM_Get_Res_Des_Data_Size</b> function obtains the buffer size required to hold the information contained in a
///specified resource descriptor on the local machine.
///Params:
///    pulSize = Caller-supplied address of a location to receive the required buffer size.
///    rdResDes = Caller-supplied handle to a resource descriptor, obtained by a previous call to CM_Get_Next_Res_Des.
///    ulFlags = Not used, must be zero.
///Returns:
///    If the operation succeeds, the function returns CR_SUCCESS. Otherwise, it returns one of the CR_-prefixed error
///    codes defined in <i>Cfgmgr32.h</i>. <div class="alert"><b>Note</b> Starting with Windows 8,
///    <b>CM_Get_Res_Des_Data_Size</b> returns CR_CALL_NOT_IMPLEMENTED when used in a Wow64 scenario. To request
///    information about the hardware resources on a local machine it is necessary implement an architecture-native
///    version of the application using the hardware resource APIs. For example: An AMD64 application for AMD64
///    systems.</div> <div> </div>
///    
@DllImport("SETUPAPI")
uint CM_Get_Res_Des_Data_Size(uint* pulSize, size_t rdResDes, uint ulFlags);

///<p class="CCE_Message">[Beginning with Windows 8 and Windows Server 2012, this function has been deprecated. Please
///use CM_Get_Res_Des_Data_Size instead.] The <b>CM_Get_Res_Des_Data_Size_Ex</b> function obtains the buffer size
///required to hold the information contained in a specified resource descriptor on a local or a remote machine.
///Params:
///    pulSize = Caller-supplied address of a location to receive the required buffer size.
///    rdResDes = Caller-supplied handle to a resource descriptor, obtained by a previous call to CM_Get_Next_Res_Des_Ex.
///    ulFlags = Not used, must be zero.
///    hMachine = Caller-supplied machine handle, obtained from a previous call to CM_Connect_Machine. <div
///               class="alert"><b>Note</b> Using this function to access remote machines is not supported beginning with Windows 8
///               and Windows Server 2012, as this functionality has been removed.</div> <div> </div>
///Returns:
///    If the operation succeeds, the function returns CR_SUCCESS. Otherwise, it returns one of the CR_-prefixed error
///    codes defined in <i>Cfgmgr32.h</i>. <div class="alert"><b>Note</b> Starting with Windows 8,
///    <b>CM_Get_Res_Des_Data_Size_Ex</b> returns CR_CALL_NOT_IMPLEMENTED when used in a Wow64 scenario. To request
///    information about the hardware resources on a local machine it is necessary implement an architecture-native
///    version of the application using the hardware resource APIs. For example: An AMD64 application for AMD64
///    systems.</div> <div> </div>
///    
@DllImport("SETUPAPI")
uint CM_Get_Res_Des_Data_Size_Ex(uint* pulSize, size_t rdResDes, uint ulFlags, ptrdiff_t hMachine);

///The <b>CM_Get_Sibling</b> function obtains a device instance handle to the next sibling node of a specified device
///node (devnode) in the local machine's device tree.
///Params:
///    pdnDevInst = Caller-supplied pointer to the device instance handle to the sibling node that this function retrieves. The
///                 retrieved handle is bound to the local machine.
///    dnDevInst = Caller-supplied device instance handle that is bound to the local machine.
///    ulFlags = Not used, must be zero.
///Returns:
///    If the operation succeeds, the function returns CR_SUCCESS. Otherwise, it returns one of the CR_-prefixed error
///    codes defined in <i>Cfgmgr32.h</i>.
///    
@DllImport("SETUPAPI")
uint CM_Get_Sibling(uint* pdnDevInst, uint dnDevInst, uint ulFlags);

///<p class="CCE_Message">[Beginning with Windows 8 and Windows Server 2012, this function has been deprecated. Please
///use CM_Get_Sibling instead.] The <b>CM_Get_Sibling_Ex</b> function obtains a device instance handle to the next
///sibling node of a specified device node, in a local or a remote machine's device tree.
///Params:
///    pdnDevInst = Caller-supplied pointer to the device instance handle to the sibling node that this function retrieves. The
///                 retrieved handle is bound to the machine handle specified by <i>hMachine</i>.
///    dnDevInst = Caller-supplied device instance handle that is bound to the machine handle specified by <i>hMachine</i>.
///    ulFlags = Not used, must be zero.
///    hMachine = Caller-supplied machine handle to which the caller-supplied device instance handle is bound. <div
///               class="alert"><b>Note</b> Using this function to access remote machines is not supported beginning with Windows 8
///               and Windows Server 2012, as this functionality has been removed.</div> <div> </div>
///Returns:
///    If the operation succeeds, the function returns CR_SUCCESS. Otherwise, it returns one of the CR_-prefixed error
///    codes defined in <i>Cfgmgr32.h</i>.
///    
@DllImport("SETUPAPI")
uint CM_Get_Sibling_Ex(uint* pdnDevInst, uint dnDevInst, uint ulFlags, ptrdiff_t hMachine);

///<p class="CCE_Message">[Beginning with Windows 8 and Windows Server 2012, this function has been deprecated and
///should not be used.] The <b>CM_Get_Version</b> function returns version 4.0 of the Plug and Play (PnP) Configuration
///Manager DLL (<i>Cfgmgr32.dll</i>) for a local machine.
///Returns:
///    If the function succeeds, it returns the major revision number in the high-order byte, and the minor revision
///    number in the low-order byte. Version 4.0 is returned as 0x0400. By default, version 4.0 is supported by
///    Microsoft Windows 2000 and later versions of Windows. If an internal error occurs, the function returns 0x0000.
///    Call GetLastError to obtain the error code for the failure.
///    
@DllImport("SETUPAPI")
ushort CM_Get_Version();

///<p class="CCE_Message">[Beginning with Windows 8 and Windows Server 2012, this function has been deprecated and
///should not be used.] The <b>CM_Get_Version_Ex</b> function returns version 4.0 of the Plug and Play (PnP)
///Configuration Manager DLL (<i>Cfgmgr32.dll</i>) for a local or a remote machine.
///Params:
///    hMachine = Supplies a machine handle that is returned by CM_Connect_Machine. <div class="alert"><b>Note</b> Using this
///               function to access remote machines is not supported beginning with Windows 8 and Windows Server 2012, as this
///               functionality has been removed.</div> <div> </div>
///Returns:
///    If the function succeeds, it returns the major revision number in the high-order byte and the minor revision
///    number in the low-order byte. Version 4.0 is returned as 0x0400. By default, version 4.0 is supported by
///    Microsoft Windows 2000 and later versions of Windows. If an internal error occurs, the function returns 0x0000.
///    Call GetLastError to obtain the error code for the failure.
///    
@DllImport("SETUPAPI")
ushort CM_Get_Version_Ex(ptrdiff_t hMachine);

///<p class="CCE_Message">[Beginning with Windows 8 and Windows Server 2012, this function has been deprecated and
///should not be used.] The <b>CM_Is_Version_Available</b> function indicates whether a specified version of the Plug
///and Play (PnP) Configuration Manager DLL (<i>Cfgmgr32.dll</i>) is supported by a local machine.
///Params:
///    wVersion = Identifies a version of the configuration manager. The supported version of the configuration manager corresponds
///               directly to the operating system version. The major version is specified by the high-order byte and the minor
///               version is specified by the low-order byte. For example, 0x0400 specifies version 4.0, which is supported by
///               default by Microsoft Windows 2000 and later versions of Windows. 0x0501 specifies version 5.1, which is supported
///               by Windows XP and later versions of Windows.
///Returns:
///    The function returns <b>TRUE</b> if the local machine supports the specified version of the configuration
///    manager. Otherwise, the function returns <b>FALSE</b>.
///    
@DllImport("SETUPAPI")
BOOL CM_Is_Version_Available(ushort wVersion);

///<p class="CCE_Message">[Beginning with Windows 8 and Windows Server 2012, this function has been deprecated and
///should not be used.] The <b>CM_Is_Version_Available_Ex</b> function indicates whether a specified version of the Plug
///and Play (PNP) Configuration Manager DLL (<i>Cfgmgr32.dll</i>) is supported by a local or a remote machine.
///Params:
///    wVersion = Identifies a version of the configuration manager. The supported version of the configuration manager corresponds
///               directly to the operating system version. The major version is specified by the high-order byte and the minor
///               version is specified by the low-order byte. For example, 0x0400 specifies version 4.0, which is supported by
///               default by Microsoft Windows NT 4.0 and later versions of Windows. Version 0x0501 specifies version 5.1, which is
///               supported by Windows XP and later versions of Windows.
///    hMachine = Supplies a machine handle that is returned by CM_Connect_Machine. <div class="alert"><b>Note</b> Using this
///               function to access remote machines is not supported beginning with Windows 8 and Windows Server 2012, as this
///               functionality has been removed.</div> <div> </div>
///Returns:
///    The function returns <b>TRUE</b> if the function can connect to the specified machine and if the machine supports
///    the specified version. Otherwise, the function returns <b>FALSE</b>.
///    
@DllImport("SETUPAPI")
BOOL CM_Is_Version_Available_Ex(ushort wVersion, ptrdiff_t hMachine);

@DllImport("SETUPAPI")
uint CM_Intersect_Range_List(size_t rlhOld1, size_t rlhOld2, size_t rlhNew, uint ulFlags);

@DllImport("SETUPAPI")
uint CM_Invert_Range_List(size_t rlhOld, size_t rlhNew, ulong ullMaxValue, uint ulFlags);

///The <b>CM_Locate_DevNode</b> function obtains a device instance handle to the device node that is associated with a
///specified device instance ID on the local machine.
///Params:
///    pdnDevInst = A pointer to a device instance handle that <b>CM_Locate_DevNode</b> retrieves. The retrieved handle is bound to
///                 the local machine.
///    pDeviceID = A pointer to a NULL-terminated string representing a device instance ID. If this value is <b>NULL</b>, or if it
///                points to a zero-length string, the function retrieves a device instance handle to the device at the root of the
///                device tree.
///    ulFlags = A variable of ULONG type that supplies one of the following flag values that apply if the caller supplies a
///              device instance identifier:
///Returns:
///    If the operation succeeds, <b>CM_Locate_DevNode</b> returns CR_SUCCESS. Otherwise, the function returns one of
///    the CR_<i>Xxx</i> error codes that are defined in <i>Cfgmgr32.h</i>.
///    
@DllImport("SETUPAPI")
uint CM_Locate_DevNodeA(uint* pdnDevInst, byte* pDeviceID, uint ulFlags);

///The <b>CM_Locate_DevNode</b> function obtains a device instance handle to the device node that is associated with a
///specified device instance ID on the local machine.
///Params:
///    pdnDevInst = A pointer to a device instance handle that <b>CM_Locate_DevNode</b> retrieves. The retrieved handle is bound to
///                 the local machine.
///    pDeviceID = A pointer to a NULL-terminated string representing a device instance ID. If this value is <b>NULL</b>, or if it
///                points to a zero-length string, the function retrieves a device instance handle to the device at the root of the
///                device tree.
///    ulFlags = A variable of ULONG type that supplies one of the following flag values that apply if the caller supplies a
///              device instance identifier:
///Returns:
///    If the operation succeeds, <b>CM_Locate_DevNode</b> returns CR_SUCCESS. Otherwise, the function returns one of
///    the CR_<i>Xxx</i> error codes that are defined in <i>Cfgmgr32.h</i>.
///    
@DllImport("SETUPAPI")
uint CM_Locate_DevNodeW(uint* pdnDevInst, ushort* pDeviceID, uint ulFlags);

@DllImport("SETUPAPI")
uint CM_Locate_DevNode_ExA(uint* pdnDevInst, byte* pDeviceID, uint ulFlags, ptrdiff_t hMachine);

///<p class="CCE_Message">[Beginning with Windows 8 and Windows Server 2012, this function has been deprecated. Please
///use CM_Locate_DevNode instead.] The <b>CM_Locate_DevNode_Ex</b> function obtains a device instance handle to the
///device node that is associated with a specified device instance ID, on a local machine or a remote machine.
///Params:
///    pdnDevInst = A pointer to the device instance handle that this function retrieves. The retrieved handle is bound to the
///                 machine handle specified by <i>hMachine</i>.
///    pDeviceID = A pointer to a NULL-terminated string representing a device instance ID. If this value is <b>NULL</b>, or if it
///                points to a zero-length string, the function supplies a device instance handle to the device at the root of the
///                device tree.
///    ulFlags = A variable of ULONG type that supplies one of the following flag values that apply if the caller supplies a
///              device instance identifier:
///    hMachine = A machine handle obtained from a call to CM_Connect_Machine, or a machine handle to which a device information
///               set is bound. The machine handle for a device information set is obtained from the <b>RemoteMachineHandle</b>
///               member of the SP_DEVINFO_LIST_DETAIL_DATA structure for the device information set. Call
///               SetupDiGetDeviceInfoListDetail to obtain an SP_DEVINFO_LIST_DETAIL_DATA structure. <div class="alert"><b>Note</b>
///               Using this function to access remote machines is not supported beginning with Windows 8 and Windows Server 2012,
///               as this functionality has been removed.</div> <div> </div>
///Returns:
///    If the operation succeeds, <b>CM_Locate_DevNode</b> returns CR_SUCCESS. Otherwise, the function returns one of
///    the CR_-prefixed error codes that are defined in <i>Cfgmgr32.h</i>.
///    
@DllImport("SETUPAPI")
uint CM_Locate_DevNode_ExW(uint* pdnDevInst, ushort* pDeviceID, uint ulFlags, ptrdiff_t hMachine);

@DllImport("SETUPAPI")
uint CM_Merge_Range_List(size_t rlhOld1, size_t rlhOld2, size_t rlhNew, uint ulFlags);

///The <b>CM_Modify_Res_Des</b> function modifies a specified resource descriptor on the local machine.
///Params:
///    prdResDes = Pointer to a location to receive a handle to the modified resource descriptor.
///    rdResDes = Caller-supplied handle to the resource descriptor to be modified. This handle must have been previously obtained
///               by calling one of the following functions: CM_Add_Res_Des CM_Add_Res_Des_Ex CM_Get_Next_Res_Des
///               CM_Get_Next_Res_Des_Ex <b>CM_Modify_Res_Des</b> CM_Modify_Res_Des_Ex
///    ResourceID = Caller-supplied resource type identifier. This must be one of the <b>ResType_</b>-prefixed constants defined in
///                 <i>Cfgmgr32.h</i>.
///    ResourceData = Caller-supplied pointer to a resource descriptor, which can be one of the structures listed under the
///                   CM_Add_Res_Des function's description of <i>ResourceData</i>.
///    ResourceLen = Caller-supplied length of the structure pointed to by <i>ResourceData</i>.
///    ulFlags = Not used, must be zero.
///Returns:
///    If the operation succeeds, the function returns CR_SUCCESS. Otherwise, it returns one of the CR_-prefixed error
///    codes defined in <i>Cfgmgr32.h</i>. <div class="alert"><b>Note</b> Starting with Windows 8,
///    <b>CM_Modify_Res_Des</b> returns CR_CALL_NOT_IMPLEMENTED when used in a Wow64 scenario. To request information
///    about the hardware resources on a local machine it is necessary implement an architecture-native version of the
///    application using the hardware resource APIs. For example: An AMD64 application for AMD64 systems.</div> <div>
///    </div>
///    
@DllImport("SETUPAPI")
uint CM_Modify_Res_Des(size_t* prdResDes, size_t rdResDes, uint ResourceID, char* ResourceData, uint ResourceLen, 
                       uint ulFlags);

///<p class="CCE_Message">[Beginning with Windows 8 and Windows Server 2012, this function has been deprecated. Please
///use CM_Modify_Res_Des instead.] The <b>CM_Modify_Res_Des_Ex</b> function modifies a specified resource descriptor on
///a local or a remote machine.
///Params:
///    prdResDes = Pointer to a location to receive a handle to the modified resource descriptor.
///    rdResDes = Caller-supplied handle to the resource descriptor to be modified. This handle must have been previously obtained
///               by calling one of the following functions: CM_Add_Res_Des CM_Add_Res_Des_Ex CM_Get_Next_Res_Des
///               CM_Get_Next_Res_Des_Ex CM_Modify_Res_Des <b>CM_Modify_Res_Des_Ex</b>
///    ResourceID = Caller-supplied resource type identifier. This must be one of the <b>ResType_</b>-prefixed constants defined in
///                 <i>Cfgmgr32.h</i>.
///    ResourceData = Caller-supplied pointer to a resource descriptor, which can be one of the structures listed under the
///                   CM_Add_Res_Des_Ex function's description of <i>ResourceData</i>.
///    ResourceLen = Caller-supplied length of the structure pointed to by <i>ResourceData</i>.
///    ulFlags = Not used, must be zero.
///    hMachine = Caller-supplied machine handle, obtained from a previous call to CM_Connect_Machine. <div
///               class="alert"><b>Note</b> Using this function to access remote machines is not supported beginning with Windows 8
///               and Windows Server 2012, as this functionality has been removed.</div> <div> </div>
///Returns:
///    If the operation succeeds, the function returns CR_SUCCESS. Otherwise, it returns one of the CR_-prefixed error
///    codes defined in <i>Cfgmgr32.h</i>. <div class="alert"><b>Note</b> Starting with Windows 8,
///    <b>CM_Modify_Res_Des_Ex</b> returns CR_CALL_NOT_IMPLEMENTED when used in a Wow64 scenario. To request information
///    about the hardware resources on a local machine it is necessary implement an architecture-native version of the
///    application using the hardware resource APIs. For example: An AMD64 application for AMD64 systems.</div> <div>
///    </div>
///    
@DllImport("SETUPAPI")
uint CM_Modify_Res_Des_Ex(size_t* prdResDes, size_t rdResDes, uint ResourceID, char* ResourceData, 
                          uint ResourceLen, uint ulFlags, ptrdiff_t hMachine);

@DllImport("SETUPAPI")
uint CM_Move_DevNode(uint dnFromDevInst, uint dnToDevInst, uint ulFlags);

@DllImport("SETUPAPI")
uint CM_Move_DevNode_Ex(uint dnFromDevInst, uint dnToDevInst, uint ulFlags, ptrdiff_t hMachine);

@DllImport("SETUPAPI")
uint CM_Next_Range(size_t* preElement, ulong* pullStart, ulong* pullEnd, uint ulFlags);

///The <b>CM_Get_Next_Res_Des</b> function obtains a handle to the next resource descriptor, of a specified resource
///type, for a logical configuration on the local machine.
///Params:
///    prdResDes = Pointer to a location to receive a resource descriptor handle.
///    rdResDes = Caller-supplied handle to either a resource descriptor or a logical configuration. For more information, see the
///               following <b>Remarks</b> section.
///    ForResource = Caller-supplied resource type identifier, indicating the type of resource descriptor being requested. This must
///                  be one of the <b>ResType_</b>-prefixed constants defined in <i>Cfgmgr32.h</i>.
///    pResourceID = Pointer to a location to receive a resource type identifier, if <i>ForResource</i> specifies <b>ResType_All</b>.
///                  For any other <i>ForResource</i> value, callers should set this to <b>NULL</b>.
///    ulFlags = Not used, must be zero.
///Returns:
///    If the operation succeeds, the function returns CR_SUCCESS. Otherwise, it returns one of the CR_-prefixed error
///    codes defined in <i>Cfgmgr32.h</i>. <div class="alert"><b>Note</b> Starting with Windows 8,
///    <b>CM_Get_Next_Res_Des</b> returns CR_CALL_NOT_IMPLEMENTED when used in a Wow64 scenario. To request information
///    about the hardware resources on a local machine it is necessary implement an architecture-native version of the
///    application using the hardware resource APIs. For example: An AMD64 application for AMD64 systems.</div> <div>
///    </div>
///    
@DllImport("SETUPAPI")
uint CM_Get_Next_Res_Des(size_t* prdResDes, size_t rdResDes, uint ForResource, uint* pResourceID, uint ulFlags);

///<p class="CCE_Message">[Beginning with Windows 8 and Windows Server 2012, this function has been deprecated. Please
///use CM_Get_Next_Res_Des instead.] The <b>CM_Get_Next_Res_Des_Ex</b> function obtains a handle to the next resource
///descriptor, of a specified resource type, for a logical configuration on a local or a remote machine.
///Params:
///    prdResDes = Pointer to a location to receive a resource descriptor handle.
///    rdResDes = Caller-supplied handle to either a resource descriptor or a logical configuration. For more information, see the
///               following <b>Remarks</b> section.
///    ForResource = Caller-supplied resource type identifier, indicating the type of resource descriptor being requested. This must
///                  be one of the ResType_-prefixed constants defined in <i>Cfgmgr32.h</i>.
///    pResourceID = Pointer to a location to receive a resource type identifier, if <i>ForResource</i> specifies <b>ResType_All</b>.
///                  For any other <i>ForResource</i> value, callers should set this to <b>NULL</b>.
///    ulFlags = Not used, must be zero.
///    hMachine = Caller-supplied machine handle, obtained from a previous call to CM_Connect_Machine. <div
///               class="alert"><b>Note</b> Using this function to access remote machines is not supported beginning with Windows 8
///               and Windows Server 2012, as this functionality has been removed.</div> <div> </div>
///Returns:
///    If the operation succeeds, the function returns CR_SUCCESS. Otherwise, it returns one of the CR_-prefixed error
///    codes defined in <i>Cfgmgr32.h</i>. <div class="alert"><b>Note</b> Starting with Windows 8,
///    <b>CM_Get_Next_Res_Des_Ex</b> returns CR_CALL_NOT_IMPLEMENTED when used in a Wow64 scenario. To request
///    information about the hardware resources on a local machine it is necessary implement an architecture-native
///    version of the application using the hardware resource APIs. For example: An AMD64 application for AMD64
///    systems.</div> <div> </div>
///    
@DllImport("SETUPAPI")
uint CM_Get_Next_Res_Des_Ex(size_t* prdResDes, size_t rdResDes, uint ForResource, uint* pResourceID, uint ulFlags, 
                            ptrdiff_t hMachine);

@DllImport("SETUPAPI")
uint CM_Open_Class_KeyA(GUID* ClassGuid, const(char)* pszClassName, uint samDesired, uint Disposition, 
                        HKEY* phkClass, uint ulFlags);

///The <b>CM_Open_Class_Key</b> function opens the device setup class registry key, the device interface class registry
///key, or a specific subkey of a class.
///Params:
///    ClassGuid = Pointer to the GUID of the class whose registry key is to be opened. This parameter is optional and can be NULL.
///                If this parameter is NULL, the root of the class tree is opened.
///    pszClassName = Reserved. Must be set to NULL.
///    samDesired = The registry security access for the key to be opened.
///    Disposition = Specifies how the registry key is to be opened. May be one of the following values:
///    phkClass = Pointer to an HKEY that will receive the opened key upon success.
///    ulFlags = Open class key flags:
///Returns:
///    If the operation succeeds, the function returns CR_SUCCESS. Otherwise, it returns one of the CR_-prefixed error
///    codes defined in <i>Cfgmgr32.h</i>.
///    
@DllImport("SETUPAPI")
uint CM_Open_Class_KeyW(GUID* ClassGuid, const(wchar)* pszClassName, uint samDesired, uint Disposition, 
                        HKEY* phkClass, uint ulFlags);

@DllImport("SETUPAPI")
uint CM_Open_Class_Key_ExA(GUID* ClassGuid, const(char)* pszClassName, uint samDesired, uint Disposition, 
                           HKEY* phkClass, uint ulFlags, ptrdiff_t hMachine);

@DllImport("SETUPAPI")
uint CM_Open_Class_Key_ExW(GUID* ClassGuid, const(wchar)* pszClassName, uint samDesired, uint Disposition, 
                           HKEY* phkClass, uint ulFlags, ptrdiff_t hMachine);

///The <b>CM_Open_DevNode_Key</b> function opens a registry key for device-specific configuration information.
///Params:
///    dnDevNode = Caller-supplied device instance handle that is bound to the local machine
///    samDesired = The registry security access that is required for the requested key.
///    ulHardwareProfile = The hardware profile to open if <i>ulFlags</i> includes CM_REGISTRY_CONFIG. If this value is zero, the key for
///                        the current hardware profile is opened.
///    Disposition = Specifies how the registry key is to be opened. May be one of the following values:
///    phkDevice = Pointer to an HKEY that will receive the opened key upon success.
///    ulFlags = Open device node key flags. Indicates the scope and type of registry storage key to open. Can be a combination of
///              the following flags:
///Returns:
///    If the operation succeeds, the function returns CR_SUCCESS. Otherwise, it returns one of the CR_-prefixed error
///    codes defined in <i>Cfgmgr32.h</i>.
///    
@DllImport("SETUPAPI")
uint CM_Open_DevNode_Key(uint dnDevNode, uint samDesired, uint ulHardwareProfile, uint Disposition, 
                         HKEY* phkDevice, uint ulFlags);

@DllImport("SETUPAPI")
uint CM_Open_DevNode_Key_Ex(uint dnDevNode, uint samDesired, uint ulHardwareProfile, uint Disposition, 
                            HKEY* phkDevice, uint ulFlags, ptrdiff_t hMachine);

///The <b>CM_Open_Device_Interface_Key</b> function opens the registry subkey that is used by applications and drivers
///to store information that is specific to a device interface.
///Params:
///    pszDeviceInterface = Pointer to a string that identifies the device interface instance to open the registry subkey for.
///    samDesired = The requested registry security access to the registry subkey.
///    Disposition = Specifies how the registry key is to be opened. May be one of the following values:
///    phkDeviceInterface = Pointer to an HKEY that will receive the opened key upon success.
///    ulFlags = Reserved. Must be set to zero.
///Returns:
///    If the operation succeeds, the function returns CR_SUCCESS. Otherwise, it returns one of the CR_-prefixed error
///    codes defined in <i>Cfgmgr32.h</i>.
///    
@DllImport("SETUPAPI")
uint CM_Open_Device_Interface_KeyA(const(char)* pszDeviceInterface, uint samDesired, uint Disposition, 
                                   HKEY* phkDeviceInterface, uint ulFlags);

///The <b>CM_Open_Device_Interface_Key</b> function opens the registry subkey that is used by applications and drivers
///to store information that is specific to a device interface.
///Params:
///    pszDeviceInterface = Pointer to a string that identifies the device interface instance to open the registry subkey for.
///    samDesired = The requested registry security access to the registry subkey.
///    Disposition = Specifies how the registry key is to be opened. May be one of the following values:
///    phkDeviceInterface = Pointer to an HKEY that will receive the opened key upon success.
///    ulFlags = Reserved. Must be set to zero.
///Returns:
///    If the operation succeeds, the function returns CR_SUCCESS. Otherwise, it returns one of the CR_-prefixed error
///    codes defined in <i>Cfgmgr32.h</i>.
///    
@DllImport("SETUPAPI")
uint CM_Open_Device_Interface_KeyW(const(wchar)* pszDeviceInterface, uint samDesired, uint Disposition, 
                                   HKEY* phkDeviceInterface, uint ulFlags);

///<p class="CCE_Message">[Beginning with Windows 8 and Windows Server 2012, this function has been deprecated. Please
///use CM_Open_Device_Interface_Key instead.] The <b>CM_Open_Device_Interface_Key_ExA</b> function opens the registry
///subkey that is used by applications and drivers to store information that is specific to a device interface.
///Params:
///    pszDeviceInterface = Pointer to a string that identifies the device interface instance to open the registry subkey for.
///    samDesired = The requested registry security access to the registry subkey.
///    Disposition = Specifies how the registry key is to be opened. May be one of the following values:
///    phkDeviceInterface = Pointer to an HKEY that will receive the opened key upon success.
///    ulFlags = Reserved. Must be set to zero.
///    hMachine = Caller-supplied machine handle, obtained from a previous call to CM_Connect_Machine. <div
///               class="alert"><b>Note</b> Using this function to access remote machines is not supported beginning with Windows 8
///               and Windows Server 2012, as this functionality has been removed.</div> <div> </div>
///Returns:
///    If the operation succeeds, the function returns CR_SUCCESS. Otherwise, it returns one of the CR_-prefixed error
///    codes defined in <i>Cfgmgr32.h</i>.
///    
@DllImport("SETUPAPI")
uint CM_Open_Device_Interface_Key_ExA(const(char)* pszDeviceInterface, uint samDesired, uint Disposition, 
                                      HKEY* phkDeviceInterface, uint ulFlags, ptrdiff_t hMachine);

///<p class="CCE_Message">[Beginning with Windows 8 and Windows Server 2012, this function has been deprecated. Please
///use CM_Open_Device_Interface_Key instead.] The <b>CM_Open_Device_Interface_Key_ExW</b> function opens the registry
///subkey that is used by applications and drivers to store information that is specific to a device interface.
///Params:
///    pszDeviceInterface = Pointer to a string that identifies the device interface instance to open the registry subkey for.
///    samDesired = The requested registry security access to the registry subkey.
///    Disposition = Specifies how the registry key is to be opened. May be one of the following values:
///    phkDeviceInterface = Pointer to an HKEY that will receive the opened key upon success.
///    ulFlags = Reserved. Must be set to zero.
///    hMachine = Caller-supplied machine handle, obtained from a previous call to CM_Connect_Machine. <div
///               class="alert"><b>Note</b> Using this function to access remote machines is not supported beginning with Windows 8
///               and Windows Server 2012, as this functionality has been removed.</div> <div> </div>
///Returns:
///    If the operation succeeds, the function returns CR_SUCCESS. Otherwise, it returns one of the CR_-prefixed error
///    codes defined in <i>Cfgmgr32.h</i>.
///    
@DllImport("SETUPAPI")
uint CM_Open_Device_Interface_Key_ExW(const(wchar)* pszDeviceInterface, uint samDesired, uint Disposition, 
                                      HKEY* phkDeviceInterface, uint ulFlags, ptrdiff_t hMachine);

@DllImport("SETUPAPI")
uint CM_Delete_Device_Interface_KeyA(const(char)* pszDeviceInterface, uint ulFlags);

///The <b>CM_Delete_Device_Interface_Key</b> function deletes the registry subkey that is used by applications and
///drivers to store interface-specific information.
///Params:
///    pszDeviceInterface = Pointer to a string that identifies the device interface instance of the registry subkey to delete.
///    ulFlags = Reserved. Must be set to zero.
///Returns:
///    If the operation succeeds, the function returns CR_SUCCESS. Otherwise, it returns one of the CR_-prefixed error
///    codes defined in <i>Cfgmgr32.h</i>.
///    
@DllImport("SETUPAPI")
uint CM_Delete_Device_Interface_KeyW(const(wchar)* pszDeviceInterface, uint ulFlags);

///<p class="CCE_Message">[Beginning with Windows 8 and Windows Server 2012, this function has been deprecated. Please
///use CM_Delete_Device_Interface_Key instead.] The <b>CM_Delete_Device_Interface_Key_ExA</b> function deletes the
///registry subkey that is used by applications and drivers to store interface-specific information.
///Params:
///    pszDeviceInterface = Pointer to a string that identifies the device interface instance of the registry subkey to delete.
///    ulFlags = Reserved. Must be set to zero.
///    hMachine = Caller-supplied machine handle, obtained from a previous call to CM_Connect_Machine. <div
///               class="alert"><b>Note</b> Using this function to access remote machines is not supported beginning with Windows 8
///               and Windows Server 2012, as this functionality has been removed.</div> <div> </div>
///Returns:
///    If the operation succeeds, the function returns CR_SUCCESS. Otherwise, it returns one of the CR_-prefixed error
///    codes defined in <i>Cfgmgr32.h</i>.
///    
@DllImport("SETUPAPI")
uint CM_Delete_Device_Interface_Key_ExA(const(char)* pszDeviceInterface, uint ulFlags, ptrdiff_t hMachine);

///<p class="CCE_Message">[Beginning with Windows 8 and Windows Server 2012, this function has been deprecated. Please
///use CM_Delete_Device_Interface_Key instead.] The <b>CM_Delete_Device_Interface_Key_ExW</b> function deletes the
///registry subkey that is used by applications and drivers to store interface-specific information.
///Params:
///    pszDeviceInterface = Pointer to a string that identifies the device interface instance of the registry subkey to delete.
///    ulFlags = Reserved. Must be set to zero.
///    hMachine = Caller-supplied machine handle, obtained from a previous call to CM_Connect_Machine. <div
///               class="alert"><b>Note</b> Using this function to access remote machines is not supported beginning with Windows 8
///               and Windows Server 2012, as this functionality has been removed.</div> <div> </div>
///Returns:
///    If the operation succeeds, the function returns CR_SUCCESS. Otherwise, it returns one of the CR_-prefixed error
///    codes defined in <i>Cfgmgr32.h</i>.
///    
@DllImport("SETUPAPI")
uint CM_Delete_Device_Interface_Key_ExW(const(wchar)* pszDeviceInterface, uint ulFlags, ptrdiff_t hMachine);

@DllImport("SETUPAPI")
uint CM_Query_Arbitrator_Free_Data(char* pData, uint DataLen, uint dnDevInst, uint ResourceID, uint ulFlags);

@DllImport("SETUPAPI")
uint CM_Query_Arbitrator_Free_Data_Ex(char* pData, uint DataLen, uint dnDevInst, uint ResourceID, uint ulFlags, 
                                      ptrdiff_t hMachine);

@DllImport("SETUPAPI")
uint CM_Query_Arbitrator_Free_Size(uint* pulSize, uint dnDevInst, uint ResourceID, uint ulFlags);

@DllImport("SETUPAPI")
uint CM_Query_Arbitrator_Free_Size_Ex(uint* pulSize, uint dnDevInst, uint ResourceID, uint ulFlags, 
                                      ptrdiff_t hMachine);

@DllImport("SETUPAPI")
uint CM_Query_Remove_SubTree(uint dnAncestor, uint ulFlags);

@DllImport("SETUPAPI")
uint CM_Query_Remove_SubTree_Ex(uint dnAncestor, uint ulFlags, ptrdiff_t hMachine);

@DllImport("SETUPAPI")
uint CM_Query_And_Remove_SubTreeA(uint dnAncestor, PNP_VETO_TYPE* pVetoType, const(char)* pszVetoName, 
                                  uint ulNameLength, uint ulFlags);

///The <b>CM_Query_And_Remove_SubTree</b> function checks whether a device instance and its children can be removed and,
///if so, it removes them.
///Params:
///    dnAncestor = Caller-supplied device instance handle to the device at the root of the subtree to be removed. This device
///                 instance handle is bound to the local machine.
///    pVetoType = (<i>Optional</i>) If the caller does not pass <b>NULL</b> and the removal request is vetoed (that is, the
///                function returns CR_REMOVE_VETOED), on return this points to a PNP_VETO_TYPE-typed value that indicates the
///                reason for the veto.
///    pszVetoName = (<i>Optional</i>) If the caller does not pass <b>NULL</b> and the removal request is vetoed (that is, the
///                  function returns CR_REMOVE_VETOED), on return this points to a text string that is associated with the veto type.
///                  The type of information this string provides is dependent on the value received by <i>pVetoType</i>. For
///                  information about these strings, see PNP_VETO_TYPE.
///    ulNameLength = Caller-supplied value representing the length (number of characters) of the string buffer supplied by
///                   <i>pszVetoName</i>. This should be set to MAX_PATH.
///    ulFlags = A bitwise OR of the caller-supplied flag constants that are described in the <b>Remarks</b> section.
///Returns:
///    If the operation succeeds, the function returns CR_SUCCESS. Otherwise, it returns one of the other CR_-prefixed
///    error codes defined in <i>Cfgmgr32.h</i>.
///    
@DllImport("SETUPAPI")
uint CM_Query_And_Remove_SubTreeW(uint dnAncestor, PNP_VETO_TYPE* pVetoType, const(wchar)* pszVetoName, 
                                  uint ulNameLength, uint ulFlags);

@DllImport("SETUPAPI")
uint CM_Query_And_Remove_SubTree_ExA(uint dnAncestor, PNP_VETO_TYPE* pVetoType, const(char)* pszVetoName, 
                                     uint ulNameLength, uint ulFlags, ptrdiff_t hMachine);

///<p class="CCE_Message">[Beginning with Windows 8 and Windows Server 2012, this function has been deprecated. Please
///use CM_Query_And_Remove_SubTree instead.] The <b>CM_Query_And_Remove_SubTree_Ex</b> function checks whether a device
///instance and its children can be removed and, if so, it removes them.
///Params:
///    dnAncestor = Caller-supplied device instance handle to the device at the root of the subtree to be removed. This device
///                 instance handle is bound to the machine handle supplied by <i>hMachine</i>.
///    pVetoType = (<i>Optional</i>) If the caller does not pass <b>NULL</b> and the removal request is vetoed (that is, the
///                function returns CR_REMOVE_VETOED), on return this points to a PNP_VETO_TYPE-typed value that indicates the
///                reason for the veto.
///    pszVetoName = (<i>Optional</i>) If the caller does not pass <b>NULL</b> and the removal request is vetoed (that is, the
///                  function returns CR_REMOVE_VETOED), on return this points to a text string that is associated with the veto type.
///                  The type of information this string provides is dependent on the value received by <i>pVetoType</i>. For
///                  information about these strings, see PNP_VETO_TYPE.
///    ulNameLength = (<i>Optional</i>.) Caller-supplied value representing the length (number of characters) of the string buffer
///                   supplied by <i>pszVetoName</i>. This should be set to MAX_PATH.
///    ulFlags = A bitwise OR of the caller-supplied flag constants that are described in the <b>Remarks</b> section.
///    hMachine = Caller-supplied machine handle to which the caller-supplied device instance handle is bound. <div
///               class="alert"><b>Note</b> Using this function to access remote machines is not supported beginning with Windows 8
///               and Windows Server 2012, as this functionality has been removed.</div> <div> </div>
///Returns:
///    If the operation succeeds, the function returns CR_SUCCESS. Otherwise, it returns one of the CR_-prefixed error
///    codes defined in <i>Cfgmgr32.h</i>.
///    
@DllImport("SETUPAPI")
uint CM_Query_And_Remove_SubTree_ExW(uint dnAncestor, PNP_VETO_TYPE* pVetoType, const(wchar)* pszVetoName, 
                                     uint ulNameLength, uint ulFlags, ptrdiff_t hMachine);

@DllImport("SETUPAPI")
uint CM_Request_Device_EjectA(uint dnDevInst, PNP_VETO_TYPE* pVetoType, const(char)* pszVetoName, 
                              uint ulNameLength, uint ulFlags);

@DllImport("SETUPAPI")
uint CM_Request_Device_Eject_ExA(uint dnDevInst, PNP_VETO_TYPE* pVetoType, const(char)* pszVetoName, 
                                 uint ulNameLength, uint ulFlags, ptrdiff_t hMachine);

///The <b>CM_Request_Device_Eject</b> function prepares a local device instance for safe removal, if the device is
///removable. If the device can be physically ejected, it will be.
///Params:
///    dnDevInst = Caller-supplied device instance handle that is bound to the local machine.
///    pVetoType = (<i>Optional</i>.) If not <b>NULL</b>, this points to a location that, if the removal request fails, receives a
///                PNP_VETO_TYPE-typed value indicating the reason for the failure.
///    pszVetoName = (<i>Optional</i>.) If not <b>NULL</b>, this is a caller-supplied pointer to a string buffer that receives a text
///                  string. The type of information this string provides is dependent on the value received by <i>pVetoType</i>. For
///                  information about these strings, see PNP_VETO_TYPE.
///    ulNameLength = (<i>Optional</i>.) Caller-supplied value representing the length of the string buffer supplied by
///                   <i>pszVetoName</i>. This should be set to MAX_PATH.
///    ulFlags = Not used.
///Returns:
///    If the operation succeeds, the function returns CR_SUCCESS. Otherwise, it returns one of the CR_-prefixed error
///    codes defined in <i>Cfgmgr32.h</i>.
///    
@DllImport("SETUPAPI")
uint CM_Request_Device_EjectW(uint dnDevInst, PNP_VETO_TYPE* pVetoType, const(wchar)* pszVetoName, 
                              uint ulNameLength, uint ulFlags);

///<p class="CCE_Message">[Beginning with Windows 8 and Windows Server 2012, this function has been deprecated. Please
///use CM_Request_Device_Eject instead.] The <b>CM_Request_Device_Eject_Ex</b> function prepares a local or a remote
///device instance for safe removal, if the device is removable. If the device can be physically ejected, it will be.
///Params:
///    dnDevInst = Caller-supplied device instance handle that is bound to the machine handle supplied by <i>hMachine</i>.
///    pVetoType = (<i>Optional</i>.) If not <b>NULL</b>, this points to a location that, if the removal request fails, receives a
///                PNP_VETO_TYPE-typed value indicating the reason for the failure.
///    pszVetoName = (<i>Optional</i>.) If not <b>NULL</b>, this is a caller-supplied pointer to a string buffer that receives a text
///                  string. The type of information this string provides is dependent on the value received by <i>pVetoType</i>. For
///                  information about these strings, see PNP_VETO_TYPE.
///    ulNameLength = (<i>Optional</i>.) Caller-supplied value representing the length of the string buffer supplied by
///                   <i>pszVetoName</i>. This should be set to MAX_PATH.
///    ulFlags = Not used.
///    hMachine = Caller-supplied machine handle to which the caller-supplied device instance handle is bound. <div
///               class="alert"><b>Note</b> Using this function to access remote machines is not supported beginning with Windows 8
///               and Windows Server 2012, as this functionality has been removed.</div> <div> </div>
///Returns:
///    If the operation succeeds, the function returns CR_SUCCESS. Otherwise, it returns one of the CR_-prefixed error
///    codes defined in <i>Cfgmgr32.h</i>.
///    
@DllImport("SETUPAPI")
uint CM_Request_Device_Eject_ExW(uint dnDevInst, PNP_VETO_TYPE* pVetoType, const(wchar)* pszVetoName, 
                                 uint ulNameLength, uint ulFlags, ptrdiff_t hMachine);

///The <b>CM_Reenumerate_DevNode</b> function enumerates the devices identified by a specified device node and all of
///its children.
///Params:
///    dnDevInst = Caller-supplied device instance handle that is bound to the local machine.
///    ulFlags = Caller-supplied flags that specify how reenumeration should occur. This parameter can be set to a combination of
///              the following flags, as noted:
///Returns:
///    If the operation succeeds, the function returns CR_SUCCESS. Otherwise, it returns one of the CR_-prefixed error
///    codes defined in <i>Cfgmgr32.h</i>.
///    
@DllImport("SETUPAPI")
uint CM_Reenumerate_DevNode(uint dnDevInst, uint ulFlags);

///<p class="CCE_Message">[Beginning with Windows 8 and Windows Server 2012, this function has been deprecated. Please
///use CM_Reenumerate_DevNode instead.] The <b>CM_Reenumerate_DevNode_Ex</b> function enumerates the devices identified
///by a specified device node and all of its children.
///Params:
///    dnDevInst = Caller-supplied device instance handle that is bound to the machine handle supplied by <i>hMachine</i>.
///    ulFlags = Caller-supplied flags that specify how reenumeration should occur. This parameter can be set to a combination of
///              the following flags, as noted:
///    hMachine = Caller-supplied machine handle to which the caller-supplied device instance handle is bound. <div
///               class="alert"><b>Note</b> Using this function to access remote machines is not supported beginning with Windows 8
///               and Windows Server 2012, as this functionality has been removed.</div> <div> </div>
///Returns:
///    If the operation succeeds, the function returns CR_SUCCESS. Otherwise, it returns one of the CR_-prefixed error
///    codes defined in <i>Cfgmgr32.h</i>.
///    
@DllImport("SETUPAPI")
uint CM_Reenumerate_DevNode_Ex(uint dnDevInst, uint ulFlags, ptrdiff_t hMachine);

@DllImport("SETUPAPI")
uint CM_Register_Device_InterfaceA(uint dnDevInst, GUID* InterfaceClassGuid, const(char)* pszReference, 
                                   const(char)* pszDeviceInterface, uint* pulLength, uint ulFlags);

@DllImport("SETUPAPI")
uint CM_Register_Device_InterfaceW(uint dnDevInst, GUID* InterfaceClassGuid, const(wchar)* pszReference, 
                                   const(wchar)* pszDeviceInterface, uint* pulLength, uint ulFlags);

@DllImport("SETUPAPI")
uint CM_Register_Device_Interface_ExA(uint dnDevInst, GUID* InterfaceClassGuid, const(char)* pszReference, 
                                      const(char)* pszDeviceInterface, uint* pulLength, uint ulFlags, 
                                      ptrdiff_t hMachine);

@DllImport("SETUPAPI")
uint CM_Register_Device_Interface_ExW(uint dnDevInst, GUID* InterfaceClassGuid, const(wchar)* pszReference, 
                                      const(wchar)* pszDeviceInterface, uint* pulLength, uint ulFlags, 
                                      ptrdiff_t hMachine);

///<p class="CCE_Message">[Beginning with Windows 8 and Windows Server 2012, this function has been deprecated. Please
///use CM_Set_DevNode_Problem instead.] The <b>CM_Set_DevNode_Problem_Ex</b> function sets a problem code for a device
///that is installed in a local or a remote machine.
///Params:
///    dnDevInst = Caller-supplied device instance handle that is bound to the machine handle supplied by <i>hMachine</i>.
///    ulProblem = Supplies a problem code, which is zero or one of the CM_PROB_Xxx flags that are described in Device Manager Error
///                Messages. A value of zero indicates that a problem code is not set for the device.
///    ulFlags = Must be set to zero.
///    hMachine = Caller-supplied machine handle to which the caller-supplied device instance handle is bound. <div
///               class="alert"><b>Note</b> Using this function to access remote machines is not supported beginning with Windows 8
///               and Windows Server 2012, as this functionality has been removed.</div> <div> </div>
///Returns:
///    If the operation succeeds, the function returns CR_SUCCESS. Otherwise, the function returns one of the
///    CR_-prefixed error codes that are defined in <i>Cfgmgr32.h</i>.
///    
@DllImport("SETUPAPI")
uint CM_Set_DevNode_Problem_Ex(uint dnDevInst, uint ulProblem, uint ulFlags, ptrdiff_t hMachine);

///The <b>CM_Set_DevNode_Problem</b> function sets a problem code for a device that is installed in a local machine.
///Params:
///    dnDevInst = Caller-supplied device instance handle that is bound to the local machine.
///    ulProblem = Supplies a problem code, which is zero or one of the CM_PROB_Xxx flags that are described in Device Manager Error
///                Messages. A value of zero indicates that a problem is not set for the device.
///    ulFlags = Must be set to zero.
///Returns:
///    If the operation succeeds, the function returns CR_SUCCESS. Otherwise, the function returns one of the
///    CR_-prefixed error codes that are defined in <i>Cfgmgr32.h</i>.
///    
@DllImport("SETUPAPI")
uint CM_Set_DevNode_Problem(uint dnDevInst, uint ulProblem, uint ulFlags);

@DllImport("SETUPAPI")
uint CM_Unregister_Device_InterfaceA(const(char)* pszDeviceInterface, uint ulFlags);

@DllImport("SETUPAPI")
uint CM_Unregister_Device_InterfaceW(const(wchar)* pszDeviceInterface, uint ulFlags);

@DllImport("SETUPAPI")
uint CM_Unregister_Device_Interface_ExA(const(char)* pszDeviceInterface, uint ulFlags, ptrdiff_t hMachine);

@DllImport("SETUPAPI")
uint CM_Unregister_Device_Interface_ExW(const(wchar)* pszDeviceInterface, uint ulFlags, ptrdiff_t hMachine);

@DllImport("SETUPAPI")
uint CM_Register_Device_Driver(uint dnDevInst, uint ulFlags);

@DllImport("SETUPAPI")
uint CM_Register_Device_Driver_Ex(uint dnDevInst, uint ulFlags, ptrdiff_t hMachine);

@DllImport("SETUPAPI")
uint CM_Remove_SubTree(uint dnAncestor, uint ulFlags);

@DllImport("SETUPAPI")
uint CM_Remove_SubTree_Ex(uint dnAncestor, uint ulFlags, ptrdiff_t hMachine);

///The <b>CM_Set_DevNode_Property</b> function sets a device instance property.
///Params:
///    dnDevInst = Device instance handle that is bound to the local machine.
///    PropertyKey = Pointer to a DEVPROPKEY structure that represents the property key of the device instance property to set.
///    PropertyType = A DEVPROPTYPE-typed value that represents the property-data-type identifier for the device instance property. To
///                   delete a property, this must be set to DEVPROP_TYPE_EMPTY.
///    PropertyBuffer = Pointer to a buffer that contains the property value of the device instance property. If either the property or
///                     the data is being deleted, this pointer must be set to NULL, and <i>PropertyBufferSize</i> must be set to zero.
///    PropertyBufferSize = The size, in bytes, of the <i>PropertyBuffer</i> buffer. If <i>PropertyBuffer</i> is set to NULL,
///                         <i>PropertyBufferSize</i> must be set to zero.
///    ulFlags = Reserved. Must be set to zero.
///Returns:
///    If the operation succeeds, the function returns CR_SUCCESS. Otherwise, it returns one of the CR_-prefixed error
///    codes defined in <i>Cfgmgr32.h</i>.
///    
@DllImport("api-ms-win-devices-config-l1-1-1")
uint CM_Set_DevNode_PropertyW(uint dnDevInst, const(DEVPROPKEY)* PropertyKey, uint PropertyType, 
                              char* PropertyBuffer, uint PropertyBufferSize, uint ulFlags);

///<p class="CCE_Message">[Beginning with Windows 8 and Windows Server 2012, this function has been deprecated. Please
///use CM_Set_DevNode_Property instead.] The <b>CM_Set_DevNode_Property_ExW</b> function sets a device instance
///property.
///Params:
///    dnDevInst = Device instance handle that is bound to the local machine.
///    PropertyKey = Pointer to a DEVPROPKEY structure that represents the property key of the device instance property to set.
///    PropertyType = A DEVPROPTYPE-typed value that represents the property-data-type identifier for the device instance property. To
///                   delete a property, this must be set to DEVPROP_TYPE_EMPTY.
///    PropertyBuffer = Pointer to a buffer that contains the property value of the device instance property. If either the property or
///                     the data is being deleted, this pointer must be set to NULL, and <i>PropertyBufferSize</i> must be set to zero.
///    PropertyBufferSize = The size, in bytes, of the <i>PropertyBuffer</i> buffer. If <i>PropertyBuffer</i> is set to NULL,
///                         <i>PropertyBufferSize</i> must be set to zero.
///    ulFlags = Reserved. Must be set to zero.
///    hMachine = Caller-supplied machine handle, obtained from a previous call to CM_Connect_Machine. <div
///               class="alert"><b>Note</b> Using this function to access remote machines is not supported beginning with Windows 8
///               and Windows Server 2012, as this functionality has been removed.</div> <div> </div>
///Returns:
///    If the operation succeeds, the function returns CR_SUCCESS. Otherwise, it returns one of the CR_-prefixed error
///    codes defined in <i>Cfgmgr32.h</i>.
///    
@DllImport("CFGMGR32")
uint CM_Set_DevNode_Property_ExW(uint dnDevInst, const(DEVPROPKEY)* PropertyKey, uint PropertyType, 
                                 char* PropertyBuffer, uint PropertyBufferSize, uint ulFlags, ptrdiff_t hMachine);

@DllImport("SETUPAPI")
uint CM_Set_DevNode_Registry_PropertyA(uint dnDevInst, uint ulProperty, char* Buffer, uint ulLength, uint ulFlags);

///The <b>CM_Set_DevNode_Registry_Property</b> function sets a specified device property in the registry.
///Params:
///    dnDevInst = A caller-supplied device instance handle that is bound to the local machine.
///    ulProperty = A CM_DRP_-prefixed constant value that identifies the device property to be set in the registry. These constants
///                 are defined in <i>Cfgmgr32.h</i>.
///    Buffer = A pointer to a caller-supplied buffer that supplies the requested device property, formatted appropriately for
///             the property's data type.
///    ulLength = The length, in bytes, of the supplied device property.
///    ulFlags = Not used, must be zero.
///Returns:
///    If the operation succeeds, the function returns CR_SUCCESS. Otherwise, it returns one of the CR_-prefixed error
///    codes that are defined in <i>Cfgmgr32.h</i>.
///    
@DllImport("SETUPAPI")
uint CM_Set_DevNode_Registry_PropertyW(uint dnDevInst, uint ulProperty, char* Buffer, uint ulLength, uint ulFlags);

@DllImport("SETUPAPI")
uint CM_Set_DevNode_Registry_Property_ExA(uint dnDevInst, uint ulProperty, char* Buffer, uint ulLength, 
                                          uint ulFlags, ptrdiff_t hMachine);

@DllImport("SETUPAPI")
uint CM_Set_DevNode_Registry_Property_ExW(uint dnDevInst, uint ulProperty, char* Buffer, uint ulLength, 
                                          uint ulFlags, ptrdiff_t hMachine);

///The <b>CM_Set_Device_Interface_Property</b> function sets a device property of a device interface.
///Params:
///    pszDeviceInterface = Pointer to a string that identifies the device interface instance for which to set a property for.
///    PropertyKey = Pointer to a DEVPROPKEY structure that represents the property key of the device interface property to set.
///    PropertyType = A DEVPROPTYPE-typed value that represents the property-data-type identifier for the device interface property. To
///                   delete a property, this must be set to DEVPROP_TYPE_EMPTY.
///    PropertyBuffer = Pointer to a buffer that contains the property value of the device interface property. If either the property or
///                     the data is being deleted, this pointer must be set to NULL, and <i>PropertyBufferSize</i> must be set to zero.
///    PropertyBufferSize = The size, in bytes, of the <i>PropertyBuffer</i> buffer. If <i>PropertyBuffer</i> is set to NULL,
///                         <i>PropertyBufferSize</i> must be set to zero.
///    ulFlags = Reserved. Must be set to zero.
///Returns:
///    If the operation succeeds, the function returns CR_SUCCESS. Otherwise, it returns one of the CR_-prefixed error
///    codes defined in <i>Cfgmgr32.h</i>.
///    
@DllImport("api-ms-win-devices-config-l1-1-1")
uint CM_Set_Device_Interface_PropertyW(const(wchar)* pszDeviceInterface, const(DEVPROPKEY)* PropertyKey, 
                                       uint PropertyType, char* PropertyBuffer, uint PropertyBufferSize, 
                                       uint ulFlags);

///<p class="CCE_Message">[Beginning with Windows 8 and Windows Server 2012, this function has been deprecated. Please
///use CM_Set_Device_Interface_Property instead.] The <b>CM_Set_Device_Interface_Property_ExW</b> function sets a device
///property of a device interface.
///Params:
///    pszDeviceInterface = Pointer to a string that identifies the device interface instance for which to set a property for.
///    PropertyKey = Pointer to a DEVPROPKEY structure that represents the property key of the device interface property to set.
///    PropertyType = A DEVPROPTYPE-typed value that represents the property-data-type identifier for the device interface property. To
///                   delete a property, this must be set to DEVPROP_TYPE_EMPTY.
///    PropertyBuffer = Pointer to a buffer that contains the property value of the device interface property. If either the property or
///                     the data is being deleted, this pointer must be set to NULL, and <i>PropertyBufferSize</i> must be set to zero.
///    PropertyBufferSize = The size, in bytes, of the <i>PropertyBuffer</i> buffer. If <i>PropertyBuffer</i> is set to NULL,
///                         <i>PropertyBufferSize</i> must be set to zero.
///    ulFlags = Reserved. Must be set to zero.
///    hMachine = Caller-supplied machine handle, obtained from a previous call to CM_Connect_Machine. <div
///               class="alert"><b>Note</b> Using this function to access remote machines is not supported beginning with Windows 8
///               and Windows Server 2012, as this functionality has been removed.</div> <div> </div>
///Returns:
///    If the operation succeeds, the function returns CR_SUCCESS. Otherwise, it returns one of the CR_-prefixed error
///    codes defined in <i>Cfgmgr32.h</i>.
///    
@DllImport("CFGMGR32")
uint CM_Set_Device_Interface_Property_ExW(const(wchar)* pszDeviceInterface, const(DEVPROPKEY)* PropertyKey, 
                                          uint PropertyType, char* PropertyBuffer, uint PropertyBufferSize, 
                                          uint ulFlags, ptrdiff_t hMachine);

///The <b>CM_Is_Dock_Station_Present</b> function identifies whether a docking station is present in a local machine.
///Params:
///    pbPresent = Pointer to a Boolean value that indicates whether a docking station is present in a local machine. The function
///                sets *<i>pbPresen</i>t to <b>TRUE</b> if a docking station is present. Otherwise, the function sets
///                *<i>pbPresen</i>t to <b>FALSE</b>.
///Returns:
///    If the operation succeeds, the function returns CR_SUCCESS. Otherwise, the function returns one of the
///    CR_-prefixed error codes that are defined in <i>Cfgmgr32.h</i>.
///    
@DllImport("SETUPAPI")
uint CM_Is_Dock_Station_Present(int* pbPresent);

///<p class="CCE_Message">[Beginning with Windows 8 and Windows Server 2012, this function has been deprecated. Please
///use CM_Is_Dock_Station_Present instead.] The <b>CM_Is_Dock_Station_Present_Ex</b> function identifies whether a
///docking station is present in a local or a remote machine.
///Params:
///    pbPresent = Pointer to a Boolean value that indicates whether a docking station is present in a local machine. The function
///                sets *pbPresent to <b>TRUE</b> if a docking station is present. The function sets *<i>pbPresent</i> to
///                <b>FALSE</b> if the function cannot connect to the specified machine or a docking station is not present.
///    hMachine = Supplies a machine handle that is returned by CM_Connect_Machine. <div class="alert"><b>Note</b> Using this
///               function to access remote machines is not supported beginning with Windows 8 and Windows Server 2012, as this
///               functionality has been removed.</div> <div> </div>
///Returns:
///    If the operation succeeds, the function returns CR_SUCCESS. Otherwise, the function returns one of the
///    CR_-prefixed error codes that are defined in <i>Cfgmgr32.h</i>.
///    
@DllImport("SETUPAPI")
uint CM_Is_Dock_Station_Present_Ex(int* pbPresent, ptrdiff_t hMachine);

///The <b>CM_Request_Eject_PC</b> function requests that a portable PC, which is inserted in a local docking station, be
///ejected.
///Returns:
///    If the operation succeeds, the function returns CR_SUCCESS. Otherwise, the function returns one of the
///    CR_-prefixed error codes that are defined in <i>Cfgmgr32.h</i>.
///    
@DllImport("SETUPAPI")
uint CM_Request_Eject_PC();

///<p class="CCE_Message">[Beginning with Windows 8 and Windows Server 2012, this function has been deprecated. Please
///use CM_Request_Eject_PC instead.] The <b>CM_Request_Eject_PC_Ex</b> function requests that a portable PC, which is
///inserted in a local or a remote docking station, be ejected.
///Params:
///    hMachine = Supplies a machine handle that is returned by CM_Connect_Machine. <div class="alert"><b>Note</b> Using this
///               function to access remote machines is not supported beginning with Windows 8 and Windows Server 2012, as this
///               functionality has been removed.</div> <div> </div>
///Returns:
///    If the operation succeeds, the function returns CR_SUCCESS. Otherwise, the function returns one of the
///    CR_-prefixed error codes that are defined in <i>Cfgmgr32.h</i>.
///    
@DllImport("SETUPAPI")
uint CM_Request_Eject_PC_Ex(ptrdiff_t hMachine);

@DllImport("SETUPAPI")
uint CM_Set_HW_Prof_FlagsA(byte* pDeviceID, uint ulConfig, uint ulValue, uint ulFlags);

@DllImport("SETUPAPI")
uint CM_Set_HW_Prof_FlagsW(ushort* pDeviceID, uint ulConfig, uint ulValue, uint ulFlags);

@DllImport("SETUPAPI")
uint CM_Set_HW_Prof_Flags_ExA(byte* pDeviceID, uint ulConfig, uint ulValue, uint ulFlags, ptrdiff_t hMachine);

@DllImport("SETUPAPI")
uint CM_Set_HW_Prof_Flags_ExW(ushort* pDeviceID, uint ulConfig, uint ulValue, uint ulFlags, ptrdiff_t hMachine);

///The <b>CM_Setup_DevNode</b> function restarts a device instance that is not running because there is a problem with
///the device configuration.
///Params:
///    dnDevInst = A device instance handle that is bound to the local system.
///    ulFlags = One of the following flag values:
///Returns:
///    If the operation succeeds, the function returns CR_SUCCESS. Otherwise it returns one of the error codes with
///    "CR_" prefix that are defined in <i>Cfgmgr32.h</i>.
///    
@DllImport("SETUPAPI")
uint CM_Setup_DevNode(uint dnDevInst, uint ulFlags);

@DllImport("SETUPAPI")
uint CM_Setup_DevNode_Ex(uint dnDevInst, uint ulFlags, ptrdiff_t hMachine);

@DllImport("SETUPAPI")
uint CM_Test_Range_Available(ulong ullStartValue, ulong ullEndValue, size_t rlh, uint ulFlags);

///The <b>CM_Uninstall_DevNode</b> function removes all persistent state associated with a device instance.
///Params:
///    dnDevInst = Device instance handle that is bound to the local machine.
///    ulFlags = Reserved. Must be set to zero.
///Returns:
///    If the operation succeeds, the function returns CR_SUCCESS. Otherwise, it returns one of the CR_-prefixed error
///    codes defined in <i>Cfgmgr32.h</i>.
///    
@DllImport("SETUPAPI")
uint CM_Uninstall_DevNode(uint dnDevInst, uint ulFlags);

@DllImport("SETUPAPI")
uint CM_Uninstall_DevNode_Ex(uint dnDevInst, uint ulFlags, ptrdiff_t hMachine);

@DllImport("SETUPAPI")
uint CM_Run_Detection(uint ulFlags);

@DllImport("SETUPAPI")
uint CM_Run_Detection_Ex(uint ulFlags, ptrdiff_t hMachine);

@DllImport("SETUPAPI")
uint CM_Set_HW_Prof(uint ulHardwareProfile, uint ulFlags);

@DllImport("SETUPAPI")
uint CM_Set_HW_Prof_Ex(uint ulHardwareProfile, uint ulFlags, ptrdiff_t hMachine);

///The <b>CM_Query_Resource_Conflict_List</b> function identifies device instances having resource requirements that
///conflict with a specified device instance's resource description.
///Params:
///    pclConflictList = Caller-supplied address of a location to receive a handle to a conflict list.
///    dnDevInst = Caller-supplied device instance handle that is bound to the machine handle supplied by <i>hMachine</i>.
///    ResourceID = Caller-supplied resource type identifier. This must be one of the <b>ResType_</b>-prefixed constants defined in
///                 <i>Cfgmgr32.h</i>.
///    ResourceData = Caller-supplied pointer to a resource descriptor, which can be one of the structures listed under the
///                   CM_Add_Res_Des function's description of <i>ResourceData</i>.
///    ResourceLen = Caller-supplied length of the structure pointed to by <i>ResourceData</i>.
///    ulFlags = Not used, must be zero.
///    hMachine = Caller-supplied machine handle to which the caller-supplied device instance handle is bound.
///Returns:
///    If the operation succeeds, the function returns CR_SUCCESS. Otherwise, it returns one of the CR_-prefixed error
///    codes defined in <i>Cfgmgr32.h</i>. <div class="alert"><b>Note</b> Starting with Windows 8,
///    <b>CM_Query_Resource_Conflict_List</b> returns CR_CALL_NOT_IMPLEMENTED when used in a Wow64 scenario. To request
///    information about the hardware resources on a local machine it is necessary implement an architecture-native
///    version of the application using the hardware resource APIs. For example: An AMD64 application for AMD64
///    systems.</div> <div> </div>
///    
@DllImport("SETUPAPI")
uint CM_Query_Resource_Conflict_List(size_t* pclConflictList, uint dnDevInst, uint ResourceID, char* ResourceData, 
                                     uint ResourceLen, uint ulFlags, ptrdiff_t hMachine);

///The <b>CM_Free_Resource_Conflict_Handle</b> function invalidates a handle to a resource conflict list, and frees the
///handle's associated memory allocation.
///Params:
///    clConflictList = Caller-supplied handle to be freed. This conflict list handle must have been previously obtained by calling
///                     CM_Query_Resource_Conflict_List.
///Returns:
///    If the operation succeeds, the function returns CR_SUCCESS. Otherwise, it returns one of the CR_-prefixed error
///    codes defined in <i>Cfgmgr32.h</i>.
///    
@DllImport("SETUPAPI")
uint CM_Free_Resource_Conflict_Handle(size_t clConflictList);

///The <b>CM_Get_Resource_Conflict_Count</b> function obtains the number of conflicts contained in a specified resource
///conflict list.
///Params:
///    clConflictList = Caller-supplied handle to a conflict list, obtained by a previous call to CM_Query_Resource_Conflict_List.
///    pulCount = Caller-supplied address of a location to receive the conflict count.
///Returns:
///    If the operation succeeds, the function returns CR_SUCCESS. Otherwise, it returns one of the CR_-prefixed error
///    codes defined in <i>Cfgmgr32.h</i>.
///    
@DllImport("SETUPAPI")
uint CM_Get_Resource_Conflict_Count(size_t clConflictList, uint* pulCount);

@DllImport("SETUPAPI")
uint CM_Get_Resource_Conflict_DetailsA(size_t clConflictList, uint ulIndex, CONFLICT_DETAILS_A* pConflictDetails);

///The <b>CM_Get_Resource_Conflict_Details</b> function obtains the details about one of the resource conflicts in a
///conflict list.
///Params:
///    clConflictList = Caller-supplied handle to a conflict list, obtained by a previous call to CM_Query_Resource_Conflict_List.
///    ulIndex = Caller-supplied value used as an index into the conflict list. This value can be from zero to one less than the
///              number returned by CM_Get_Resource_Conflict_Count.
///    pConflictDetails = Caller-supplied address of a CONFLICT_DETAILS structure to receive conflict details. The caller must supply
///                       values for the structure's <i>CD_ulSize</i> and <i>CD_ulMask</i> structures.
///Returns:
///    If the operation succeeds, the function returns CR_SUCCESS. Otherwise, it returns one of the CR_-prefixed error
///    codes defined in <i>Cfgmgr32.h</i>.
///    
@DllImport("SETUPAPI")
uint CM_Get_Resource_Conflict_DetailsW(size_t clConflictList, uint ulIndex, CONFLICT_DETAILS_W* pConflictDetails);

///The <b>CM_Get_Class_Property</b> function retrieves a device property that is set for a device interface class or
///device setup class.
///Params:
///    ClassGUID = Pointer to the GUID that identifies the device interface class or device setup class for which to retrieve a
///                device property that is set for the device class. For information about specifying the class type, see the
///                <i>ulFlags</i> parameter.
///    PropertyKey = Pointer to a DEVPROPKEY structure that represents the device property key of the requested device class property.
///    PropertyType = Pointer to a DEVPROPTYPE-typed variable that receives the property-data-type identifier of the requested device
///                   class property, where the property-data-type identifier is the bitwise OR between a base-data-type identifier
///                   and, if the base data type is modified, a property-data-type modifier.
///    PropertyBuffer = Pointer to a buffer that receives the requested device class property. <b>CM_Get_Class_Property</b> retrieves the
///                     requested property value only if the buffer is large enough to hold all the property value data. The pointer can
///                     be NULL.
///    PropertyBufferSize = The size, in bytes, of the <i>PropertyBuffer</i> buffer. If the <i>PropertyBuffer</i> parameter is set to NULL,
///                         <i>*PropertyBufferSize</i> must be set to zero. As output, if the buffer is not large enough to hold all the
///                         property value data, <b>CM_Get_Class_Property</b> returns the size of the data, in bytes, in
///                         <i>*PropertyBufferSize</i>.
///    ulFlags = Class property flags:
///Returns:
///    If the operation succeeds, the function returns CR_SUCCESS. Otherwise, it returns one of the CR_-prefixed error
///    codes defined in <i>Cfgmgr32.h</i>.
///    
@DllImport("api-ms-win-devices-config-l1-1-1")
uint CM_Get_Class_PropertyW(GUID* ClassGUID, const(DEVPROPKEY)* PropertyKey, uint* PropertyType, 
                            char* PropertyBuffer, uint* PropertyBufferSize, uint ulFlags);

///<p class="CCE_Message">[Beginning with Windows 8 and Windows Server 2012, this function has been deprecated. Please
///use CM_Get_Class_Property instead.] The <b>CM_Get_Class_Property_ExW</b> function retrieves a device property that is
///set for a device interface class or device setup class.
///Params:
///    ClassGUID = Pointer to the GUID that identifies the device interface class or device setup class for which to retrieve a
///                device property that is set for the device class. For information about specifying the class type, see the
///                <i>ulFlags</i> parameter.
///    PropertyKey = Pointer to a DEVPROPKEY structure that represents the device property key of the requested device class property.
///    PropertyType = Pointer to a DEVPROPTYPE-typed variable that receives the property-data-type identifier of the requested device
///                   class property, where the property-data-type identifier is the bitwise OR between a base-data-type identifier
///                   and, if the base data type is modified, a property-data-type modifier.
///    PropertyBuffer = Pointer to a buffer that receives the requested device class property. <b>CM_Get_Class_Property_ExW</b> retrieves
///                     the requested property value only if the buffer is large enough to hold all the property value data. The pointer
///                     can be NULL.
///    PropertyBufferSize = The size, in bytes, of the <i>PropertyBuffer</i> buffer. If the <i>PropertyBuffer</i> parameter is set to NULL,
///                         <i>*PropertyBufferSize</i> must be set to zero. As output, if the buffer is not large enough to hold all the
///                         property value data, <b>CM_Get_Class_Property_ExW</b> returns the size of the data, in bytes, in
///                         <i>*PropertyBufferSize</i>.
///    ulFlags = Class property flags:
///    hMachine = Caller-supplied machine handle, obtained from a previous call to CM_Connect_Machine. <div
///               class="alert"><b>Note</b> Using this function to access remote machines is not supported beginning with Windows 8
///               and Windows Server 2012, as this functionality has been removed.</div> <div> </div>
///Returns:
///    If the operation succeeds, the function returns CR_SUCCESS. Otherwise, it returns one of the CR_-prefixed error
///    codes defined in <i>Cfgmgr32.h</i>.
///    
@DllImport("CFGMGR32")
uint CM_Get_Class_Property_ExW(GUID* ClassGUID, const(DEVPROPKEY)* PropertyKey, uint* PropertyType, 
                               char* PropertyBuffer, uint* PropertyBufferSize, uint ulFlags, ptrdiff_t hMachine);

///The <b>CM_Get_Class_Property_Keys</b> function retrieves an array of the device property keys that represent the
///device properties that are set for a device interface class or device setup class.
///Params:
///    ClassGUID = Pointer to the GUID that identifies the device interface class or device setup class for which to retrieve the
///                property keys for. For information about specifying the class type, see the <i>ulFlags</i> parameter.
///    PropertyKeyArray = Pointer to a buffer that receives an array of DEVPROPKEY-typed values, where each value is a device property key
///                       that represents a device property that is set for the device class. The pointer is optional and can be NULL.
///    PropertyKeyCount = The size, in DEVPROPKEY-typed units, of the <i>PropertyKeyArray</i> buffer. If <i>PropertyKeyArray</i> is set to
///                       NULL, <i>*PropertyKeyCount</i> must be set to zero. As output, if <i>PropertyKeyArray</i> is not large enough to
///                       hold all the property key data, <b>CM_Get_Class_Property_Keys</b> returns the count of the keys, in
///                       <i>*PropertyKeyCount</i>.
///    ulFlags = Class property key flags:
///Returns:
///    If the operation succeeds, the function returns CR_SUCCESS. Otherwise, it returns one of the CR_-prefixed error
///    codes defined in <i>Cfgmgr32.h</i>.
///    
@DllImport("api-ms-win-devices-config-l1-1-1")
uint CM_Get_Class_Property_Keys(GUID* ClassGUID, char* PropertyKeyArray, uint* PropertyKeyCount, uint ulFlags);

///<p class="CCE_Message">[Beginning with Windows 8 and Windows Server 2012, this function has been deprecated. Please
///use CM_Get_Class_Property_Keys instead.] The <b>CM_Get_Class_Property_Keys_Ex</b> function retrieves an array of the
///device property keys that represent the device properties that are set for a device interface class or device setup
///class.
///Params:
///    ClassGUID = Pointer to the GUID that identifies the device interface class or device setup class for which to retrieve the
///                property keys for. For information about specifying the class type, see the <i>ulFlags</i> parameter.
///    PropertyKeyArray = Pointer to a buffer that receives an array of DEVPROPKEY-typed values, where each value is a device property key
///                       that represents a device property that is set for the device class. The pointer is optional and can be NULL.
///    PropertyKeyCount = The size, in DEVPROPKEY-typed units, of the <i>PropertyKeyArray</i> buffer. If <i>PropertyKeyArray</i> is set to
///                       NULL, <i>*PropertyKeyCount</i> must be set to zero. As output, if <i>PropertyKeyArray</i> is not large enough to
///                       hold all the property key data, <b>CM_Get_Class_Property_Keys_Ex</b> returns the count of the keys, in
///                       <i>*PropertyKeyCount</i>.
///    ulFlags = Class property key flags:
///    hMachine = Caller-supplied machine handle, obtained from a previous call to CM_Connect_Machine. <div
///               class="alert"><b>Note</b> Using this function to access remote machines is not supported beginning with Windows 8
///               and Windows Server 2012, as this functionality has been removed.</div> <div> </div>
///Returns:
///    If the operation succeeds, the function returns CR_SUCCESS. Otherwise, it returns one of the CR_-prefixed error
///    codes defined in <i>Cfgmgr32.h</i>.
///    
@DllImport("CFGMGR32")
uint CM_Get_Class_Property_Keys_Ex(GUID* ClassGUID, char* PropertyKeyArray, uint* PropertyKeyCount, uint ulFlags, 
                                   ptrdiff_t hMachine);

///The <b>CM_Set_Class_Property</b> function sets a class property for a device setup class or a device interface class.
///Params:
///    ClassGUID = Pointer to the GUID that identifies the device interface class or device setup class for which to set a device
///                property. For information about specifying the class type, see the <i>ulFlags</i> parameter.
///    PropertyKey = Pointer to a DEVPROPKEY structure that represents the property key of the device class property to set.
///    PropertyType = A DEVPROPTYPE-typed value that represents the property-data-type identifier for the device class property. To
///                   delete a property, set this to DEVPROP_TYPE_EMPTY.
///    PropertyBuffer = Pointer to a buffer that contains the property value of the device class property. If either the property or the
///                     data is to be deleted, this pointer must be set to NULL, and <i>PropertyBufferSize</i> must be set to zero.
///    PropertyBufferSize = The size, in bytes, of the <i>PropertyBuffer</i> buffer. If <i>PropertyBuffer</i> is set to NULL,
///                         <i>PropertyBufferSize</i> must be set to zero.
///    ulFlags = Class property flags:
///Returns:
///    If the operation succeeds, the function returns CR_SUCCESS. Otherwise, it returns one of the CR_-prefixed error
///    codes defined in <i>Cfgmgr32.h</i>.
///    
@DllImport("api-ms-win-devices-config-l1-1-1")
uint CM_Set_Class_PropertyW(GUID* ClassGUID, const(DEVPROPKEY)* PropertyKey, uint PropertyType, 
                            char* PropertyBuffer, uint PropertyBufferSize, uint ulFlags);

///<p class="CCE_Message">[Beginning with Windows 8 and Windows Server 2012, this function has been deprecated. Please
///use CM_Set_Class_Property instead.] The <b>CM_Set_Class_Property_ExW</b> function sets a class property for a device
///setup class or a device interface class.
///Params:
///    ClassGUID = Pointer to the GUID that identifies the device interface class or device setup class for which to set a device
///                property. For information about specifying the class type, see the <i>ulFlags</i> parameter.
///    PropertyKey = Pointer to a DEVPROPKEY structure that represents the property key of the device class property to set.
///    PropertyType = A DEVPROPTYPE-typed value that represents the property-data-type identifier for the device class property. To
///                   delete a property, set this to <b>DEVPROP_TYPE_EMPTY</b>.
///    PropertyBuffer = Pointer to a buffer that contains the property value of the device class property. If either the property or the
///                     data is to be deleted, this pointer must be set to NULL, and <i>PropertyBufferSize</i> must be set to zero.
///    PropertyBufferSize = The size, in bytes, of the <i>PropertyBuffer</i> buffer. If <i>PropertyBuffer</i> is set to NULL,
///                         <i>PropertyBufferSize</i> must be set to zero.
///    ulFlags = Class property flags:
///    hMachine = Caller-supplied machine handle, obtained from a previous call to CM_Connect_Machine. <div
///               class="alert"><b>Note</b> Using this function to access remote machines is not supported beginning with Windows 8
///               and Windows Server 2012, as this functionality has been removed.</div> <div> </div>
///Returns:
///    If the operation succeeds, the function returns CR_SUCCESS. Otherwise, it returns one of the CR_-prefixed error
///    codes defined in <i>Cfgmgr32.h</i>.
///    
@DllImport("CFGMGR32")
uint CM_Set_Class_Property_ExW(GUID* ClassGUID, const(DEVPROPKEY)* PropertyKey, uint PropertyType, 
                               char* PropertyBuffer, uint PropertyBufferSize, uint ulFlags, ptrdiff_t hMachine);

@DllImport("SETUPAPI")
uint CM_Get_Class_Registry_PropertyA(GUID* ClassGuid, uint ulProperty, uint* pulRegDataType, char* Buffer, 
                                     uint* pulLength, uint ulFlags, ptrdiff_t hMachine);

///The <b>CM_Get_Class_Registry_Property</b> function retrieves a device setup class property.
///Params:
///    ClassGuid = A pointer to the GUID that represents the device setup class for which to retrieve a property.
///    ulProperty = A value of type ULONG that identifies the property to be retrieved. This value must be one of the following
///                 CM_CRP_<i>Xxx</i> values that are defined in <i>Cfgmgr32.h</i>:
///    pulRegDataType = A pointer to a variable of type ULONG that receives the REG_<i>Xxx</i> constant that represents the data type of
///                     the requested property. The REG_<i>Xxx</i> constants are defined in <i>Winnt.h</i> and are described in the
///                     <b>Type</b> member of the KEY_VALUE_BASIC_INFORMATION structure. This parameter is optional and can be set to
///                     <b>NULL</b>.
///    Buffer = A pointer to a buffer that receives the requested property data. For more information about this parameter and
///             the buffer-size parameter <i>pulLength</i>, see the following <b>Remarks</b> section.
///    pulLength = A pointer to variable of type ULONG whose value, on input, is the size, in bytes, of the buffer that is supplied
///                by <i>Buffer</i>. On return, <b>CM_Get_Class_Registry_Property </b>sets this variable to the size, in bytes, of
///                the requested property.
///    ulFlags = Reserved for internal use only. Must be set to zero.
///    hMachine = A handle to a remote machine from which to retrieve the specified device class property. This parameter is
///               optional, and, if it is set to <b>NULL</b>, the property is retrieved from the local machine.
///Returns:
///    If the operation succeeds, <b>CM_Get_Class_Registry_Property </b>returns CR_SUCCESS. Otherwise, the function
///    returns one of the other CR_<i>Xxx</i> status codes that are defined in <i>Cfgmgr32.h</i>.
///    
@DllImport("SETUPAPI")
uint CM_Get_Class_Registry_PropertyW(GUID* ClassGuid, uint ulProperty, uint* pulRegDataType, char* Buffer, 
                                     uint* pulLength, uint ulFlags, ptrdiff_t hMachine);

@DllImport("SETUPAPI")
uint CM_Set_Class_Registry_PropertyA(GUID* ClassGuid, uint ulProperty, char* Buffer, uint ulLength, uint ulFlags, 
                                     ptrdiff_t hMachine);

///The <b>CM_Set_Class_Registry_Property</b> function sets or deletes a property of a device setup class.
///Params:
///    ClassGuid = A pointer to the GUID that represents the device setup class for which to set a property.
///    ulProperty = A value of type ULONG that identifies the property to set. This value must be one of the CM_CRP_<i>Xxx</i> values
///                 that are described for the <i>ulProperty</i> parameter of the CM_Get_Class_Registry_Property function.
///    Buffer = A pointer to a buffer that contains the property data. This parameter is optional and can be set to <b>NULL</b>.
///             For more information about setting this parameter and the corresponding <i>ulLength</i> parameter, see the
///             following <b>Remarks</b> section.
///    ulLength = A value of type ULONG that specifies the size, in bytes, of the property data.
///    ulFlags = Reserved for internal use only. Must be set to zero.
///    hMachine = A handle to a remote machine on which to set the specified device setup class property. This parameter is
///               optional. If set to <b>NULL</b>, the property is set on the local machine.
///Returns:
///    If the operation succeeds, <b>CM_Set_Class_Registry_Property </b>returns CR_SUCCESS. Otherwise, the function
///    returns one of the other CR_<i>Xxx</i> status codes that are defined in <i>Cfgmgr32.h</i>.
///    
@DllImport("SETUPAPI")
uint CM_Set_Class_Registry_PropertyW(GUID* ClassGuid, uint ulProperty, char* Buffer, uint ulLength, uint ulFlags, 
                                     ptrdiff_t hMachine);

@DllImport("SETUPAPI")
uint CMP_WaitNoPendingInstallEvents(uint dwTimeout);

///Use RegisterDeviceNotification instead of <b>CM_Register_Notification</b> if your code targets Windows 7 or earlier
///versions of Windows. Kernel mode callers should use IoRegisterPlugPlayNotification instead. The
///<b>CM_Register_Notification</b> function registers an application callback routine to be called when a PnP event of
///the specified type occurs.
///Params:
///    pFilter = Pointer to a CM_NOTIFY_FILTER structure.
///    pContext = Pointer to a caller-allocated buffer containing the context to be passed to the callback routine in
///               <i>pCallback</i>.
///    pCallback = Pointer to the routine to be called when the specified PnP event occurs. See the <b>Remarks</b> section for the
///                callback function's prototype. The callback routine’s <i>Action</i> parameter will be a value from the
///                CM_NOTIFY_ACTION enumeration. Upon receiving a notification, how the callback examines the notification will
///                depend on the <b>FilterType</b> member of the callback routine's <i>EventData</i> parameter:
///    pNotifyContext = Pointer to receive the HCMNOTIFICATION handle that corresponds to the registration call.
///Returns:
///    If the operation succeeds, the function returns CR_SUCCESS. Otherwise, it returns one of the CR_-prefixed error
///    codes defined in <i>Cfgmgr32.h</i>.
///    
@DllImport("api-ms-win-devices-config-l1-1-1")
uint CM_Register_Notification(CM_NOTIFY_FILTER* pFilter, void* pContext, PCM_NOTIFY_CALLBACK pCallback, 
                              HCMNOTIFICATION__** pNotifyContext);

///Use UnregisterDeviceNotification instead of <b>CM_Unregister_Notification</b> if your code targets Windows 7 or
///earlier versions of Windows. The <b>CM_Unregister_Notification</b> function closes the specified HCMNOTIFICATION
///handle.
///Params:
///    NotifyContext = The HCMNOTIFICATION handle returned by the CM_Register_Notification function.
///Returns:
///    If the operation succeeds, the function returns CR_SUCCESS. Otherwise, it returns one of the CR_-prefixed error
///    codes defined in <i>Cfgmgr32.h</i>.
///    
@DllImport("api-ms-win-devices-config-l1-1-1")
uint CM_Unregister_Notification(HCMNOTIFICATION__* NotifyContext);

///Converts a specified <b>CONFIGRET</b> code to its equivalent system error code.
///Params:
///    CmReturnCode = The <b>CONFIGRET</b> code to be converted. <b>CONFIGRET</b> error codes are defined in CfgMgr32.h.
///    DefaultErr = A default system error code to be returned when no system error code is mapped to the specified <b>CONFIGRET</b>
///                 code.
@DllImport("api-ms-win-devices-config-l1-1-1")
uint CM_MapCrToWin32Err(uint CmReturnCode, uint DefaultErr);

///Given an INF file and a hardware ID, the <b>UpdateDriverForPlugAndPlayDevices</b> function installs updated drivers
///for devices that match the hardware ID.
///Params:
///    hwndParent = A handle to the top-level window to use for any UI related to installing devices.
///    HardwareId = A pointer to a NULL-terminated string that supplies the hardware identifier to match existing devices on the
///                 computer. The maximum length of a NULL-terminated hardware identifier is MAX_DEVICE_ID_LEN. For more information
///                 about hardware identifiers, see Device Identification Strings.
///    FullInfPath = A pointer to a NULL-terminated string that supplies the full path file name of an INF file. The files should be
///                  on the distribution media or in a vendor-created directory, not in a system location such as
///                  <i>%SystemRoot%\inf</i>. <b>UpdateDriverForPlugAndPlayDevices</b> copies driver files to the appropriate system
///                  locations if the installation is successful.
///    InstallFlags = A caller-supplied value created by using OR to combine zero or more of the following bit flags:
///    bRebootRequired = A pointer to a BOOL-typed variable that indicates whether a restart is required and who should prompt for it.
///                      This pointer is optional and can be <b>NULL</b>. If the pointer is <b>NULL</b>,
///                      <b>UpdateDriverForPlugAndPlayDevices</b> prompts for a restart after installing drivers, if necessary. If the
///                      pointer is supplied, the function returns a BOOLEAN value that is <b>TRUE</b> if the system should be restarted.
///                      It is then the caller's responsibility to prompt for a restart. For more information, see the following
///                      <b>Remarks</b> section.
///Returns:
///    The function returns <b>TRUE</b> if a device was upgraded to the specified driver. Otherwise, it returns
///    <b>FALSE</b> and the logged error can be retrieved with a call to <b>GetLastError</b>. Possible error values
///    returned by <b>GetLastError</b> are included in the following table. <table> <tr> <th>Return code</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_FILE_NOT_FOUND</b></dt> </dl> </td> <td
///    width="60%"> The path that was specified for <i>FullInfPath</i> does not exist. </td> </tr> <tr> <td width="40%">
///    <dl> <dt><b>ERROR_IN_WOW64</b></dt> </dl> </td> <td width="60%"> The calling application is a 32-bit application
///    attempting to execute in a 64-bit environment, which is not allowed. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_FLAGS</b></dt> </dl> </td> <td width="60%"> The value specified for <i>InstallFlags</i> is
///    invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NO_SUCH_DEVINST</b></dt> </dl> </td> <td
///    width="60%"> The value specified for <i>HardwareId</i> does not match any device on the system. That is, the
///    device is not plugged in. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NO_MORE_ITEMS</b></dt> </dl> </td>
///    <td width="60%"> The function found a match for the <i>HardwareId</i> value, but the specified driver was not a
///    better match than the current driver and the caller did not specify the INSTALLFLAG_FORCE flag. </td> </tr>
///    </table>
///    
@DllImport("newdev")
BOOL UpdateDriverForPlugAndPlayDevicesA(HWND hwndParent, const(char)* HardwareId, const(char)* FullInfPath, 
                                        uint InstallFlags, int* bRebootRequired);

///Given an INF file and a hardware ID, the <b>UpdateDriverForPlugAndPlayDevices</b> function installs updated drivers
///for devices that match the hardware ID.
///Params:
///    hwndParent = A handle to the top-level window to use for any UI related to installing devices.
///    HardwareId = A pointer to a NULL-terminated string that supplies the hardware identifier to match existing devices on the
///                 computer. The maximum length of a NULL-terminated hardware identifier is MAX_DEVICE_ID_LEN. For more information
///                 about hardware identifiers, see Device Identification Strings.
///    FullInfPath = A pointer to a NULL-terminated string that supplies the full path file name of an INF file. The files should be
///                  on the distribution media or in a vendor-created directory, not in a system location such as
///                  <i>%SystemRoot%\inf</i>. <b>UpdateDriverForPlugAndPlayDevices</b> copies driver files to the appropriate system
///                  locations if the installation is successful.
///    InstallFlags = A caller-supplied value created by using OR to combine zero or more of the following bit flags:
///    bRebootRequired = A pointer to a BOOL-typed variable that indicates whether a restart is required and who should prompt for it.
///                      This pointer is optional and can be <b>NULL</b>. If the pointer is <b>NULL</b>,
///                      <b>UpdateDriverForPlugAndPlayDevices</b> prompts for a restart after installing drivers, if necessary. If the
///                      pointer is supplied, the function returns a BOOLEAN value that is <b>TRUE</b> if the system should be restarted.
///                      It is then the caller's responsibility to prompt for a restart. For more information, see the following
///                      <b>Remarks</b> section.
///Returns:
///    The function returns <b>TRUE</b> if a device was upgraded to the specified driver. Otherwise, it returns
///    <b>FALSE</b> and the logged error can be retrieved with a call to <b>GetLastError</b>. Possible error values
///    returned by <b>GetLastError</b> are included in the following table. <table> <tr> <th>Return code</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_FILE_NOT_FOUND</b></dt> </dl> </td> <td
///    width="60%"> The path that was specified for <i>FullInfPath</i> does not exist. </td> </tr> <tr> <td width="40%">
///    <dl> <dt><b>ERROR_IN_WOW64</b></dt> </dl> </td> <td width="60%"> The calling application is a 32-bit application
///    attempting to execute in a 64-bit environment, which is not allowed. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_FLAGS</b></dt> </dl> </td> <td width="60%"> The value specified for <i>InstallFlags</i> is
///    invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NO_SUCH_DEVINST</b></dt> </dl> </td> <td
///    width="60%"> The value specified for <i>HardwareId</i> does not match any device on the system. That is, the
///    device is not plugged in. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NO_MORE_ITEMS</b></dt> </dl> </td>
///    <td width="60%"> The function found a match for the <i>HardwareId</i> value, but the specified driver was not a
///    better match than the current driver and the caller did not specify the INSTALLFLAG_FORCE flag. </td> </tr>
///    </table>
///    
@DllImport("newdev")
BOOL UpdateDriverForPlugAndPlayDevicesW(HWND hwndParent, const(wchar)* HardwareId, const(wchar)* FullInfPath, 
                                        uint InstallFlags, int* bRebootRequired);

///The <b>DiInstallDevice</b> function installs a specified driver that is preinstalled in the driver store on a
///specified device that is present in the system.
///Params:
///    hwndParent = A handle to the top-level window that <b>DiInstallDevice</b> uses to display any user interface component that is
///                 associated with installing the device. This parameter is optional and can be set to <b>NULL</b>.
///    DeviceInfoSet = A handle to a device information set that contains a device information element that represents the specified
///                    device.
///    DeviceInfoData = A pointer to an SP_DEVINFO_DATA structure that represents the specified device in the specified device
///                     information set.
///    DriverInfoData = An pointer to an SP_DRVINFO_DATA structure that specifies the driver to install on the specified device. This
///                     parameter is optional and can be set to <b>NULL</b>. If this parameter is <b>NULL</b>, <b>DiInstallDevice</b>
///                     searches the drivers preinstalled in the driver store for the driver that is the best match to the specified
///                     device, and, if one is found, installs the driver on the specified device.
///    Flags = A value of type <b>DWORD</b> that specifies zero or the following flag:
///    NeedReboot = A pointer to a value of type <b>BOOL</b> that <b>DiInstallDevice</b> sets to indicate whether a system restart is
///                 required to complete the installation. This parameter is optional and can be set to <b>NULL</b>. If this
///                 parameter is supplied and a system restart is required to complete the installation, <b>DiInstallDevice</b> sets
///                 the value to <b>TRUE</b>. In this case, the caller is responsible for restarting the system. If this parameter is
///                 supplied and a system restart is not required, <b>DiInstallDevice</b> sets this parameter to <b>FALSE</b>. If
///                 this parameter is <b>NULL</b> and a system restart is required to complete the installation,
///                 <b>DiInstallDevice</b> displays a system restart dialog box.
///Returns:
///    <b>DiInstallDevice</b> returns <b>TRUE</b> if the function successfully installed the specified driver on the
///    specified device. Otherwise, <b>DiInstallDevice</b> returns <b>FALSE</b> and the logged error can be retrieved by
///    making a call to <b>GetLastError</b>. Some of the more common error values that <b>GetLastError</b> might return
///    are as follows: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> The caller does not have Administrator
///    privileges. By default, Windows Vista and Windows Server 2008 require that a calling process have Administrator
///    privileges to install a driver on a device. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_FLAGS</b></dt> </dl> </td> <td width="60%"> The value that is specified for <i>Flags</i> is
///    not zero or a bitwise OR of the valid flags. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_IN_WOW64</b></dt> </dl> </td> <td width="60%"> The calling application is a 32-bit application that
///    is attempting to execute in a 64-bit environment, which is not allowed. For more information, see Installing
///    Devices on 64-Bit Systems. </td> </tr> </table>
///    
@DllImport("newdev")
BOOL DiInstallDevice(HWND hwndParent, void* DeviceInfoSet, SP_DEVINFO_DATA* DeviceInfoData, 
                     SP_DRVINFO_DATA_V2_A* DriverInfoData, uint Flags, int* NeedReboot);

///The <b>DiInstallDriver</b> function preinstalls a driver in the driver store and then installs the driver on devices
///present in the system that the driver supports.
///Params:
///    hwndParent = A handle to the top-level window that <b>DiInstallDriver</b> uses to display any user interface component that is
///                 associated with installing the device. This parameter is optional and can be set to <b>NULL</b>.
///    InfPath = A pointer to a NULL-terminated string that supplies the fully qualified path of the INF file for the driver
///              package.
///    Flags = A value of type DWORD that specifies zero or DIIRFLAG_FORCE_INF. Typically, this flag should be set to zero. If
///            this flag is zero, <b>DiInstallDriver</b> only installs the specified driver on a device if the driver is a
///            better match for a device than the driver that is currently installed on a device. However, if this flag is set
///            to DIIRFLAG_FORCE_INF, <b>DiInstallDriver</b> installs the specified driver on a matching device whether the
///            driver is a better match for the device than the driver that is currently installed on the device. <div
///            class="alert"><b>Caution</b> Forcing the installation of the driver can result in replacing a more compatible or
///            newer driver with a less compatible or older driver. </div> <div> </div> For information about how Windows
///            selects a driver for a device, see How Windows Selects Drivers.
///    NeedReboot = A pointer to a value of type BOOL that <b>DiInstallDriver</b> sets to indicate whether a system is restart is
///                 required to complete the installation. This parameter is optional and can be <b>NULL</b>. If the parameter is
///                 supplied and a system restart is required to complete the installation, <b>DiInstallDriver</b> sets the value to
///                 <b>TRUE</b>. In this case, the caller must prompt the user to restart the system. If this parameter is supplied
///                 and a system restart is not required to complete the installation, <b>DiInstallDriver</b> sets the value to
///                 <b>FALSE</b>. If the parameter is <b>NULL</b> and a system restart is required to complete the installation,
///                 <b>DiInstallDriver</b> displays a system restart dialog box. For more information about this parameter, see the
///                 following <b>Remarks</b> section.
///Returns:
///    <b>DiInstallDriver</b> returns <b>TRUE</b> if the function successfully preinstalled the specified driver package
///    in the driver store. <b>DiInstallDriver</b> also returns <b>TRUE</b> if the function successfully installed the
///    driver on one or more devices in the system. If the driver package is not successfully installed in the driver
///    store, <b>DiInstallDriver</b> returns <b>FALSE</b> and the logged error can be retrieved by making call to
///    <b>GetLastError</b>. Some of the more common error values that <b>GetLastError</b> might return are as follows:
///    <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> The caller does not have Administrator
///    privileges. By default, Windows requires that the caller have Administrator privileges to preinstall a driver
///    package in the driver store. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_FILE_NOT_FOUND</b></dt> </dl>
///    </td> <td width="60%"> The path of the specified INF file does not exist. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_FLAGS</b></dt> </dl> </td> <td width="60%"> The value specified for <i>Flags</i> is not
///    equal to zero or DIIRFLAG_FORCE_INF. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_IN_WOW64</b></dt> </dl>
///    </td> <td width="60%"> The calling application is a 32-bit application that is attempting to execute in a 64-bit
///    environment, which is not allowed. For more information, see Installing Devices on 64-Bit Systems. </td> </tr>
///    </table>
///    
@DllImport("newdev")
BOOL DiInstallDriverW(HWND hwndParent, const(wchar)* InfPath, uint Flags, int* NeedReboot);

///The <b>DiInstallDriver</b> function preinstalls a driver in the driver store and then installs the driver on devices
///present in the system that the driver supports.
///Params:
///    hwndParent = A handle to the top-level window that <b>DiInstallDriver</b> uses to display any user interface component that is
///                 associated with installing the device. This parameter is optional and can be set to <b>NULL</b>.
///    InfPath = A pointer to a NULL-terminated string that supplies the fully qualified path of the INF file for the driver
///              package.
///    Flags = A value of type DWORD that specifies zero or DIIRFLAG_FORCE_INF. Typically, this flag should be set to zero. If
///            this flag is zero, <b>DiInstallDriver</b> only installs the specified driver on a device if the driver is a
///            better match for a device than the driver that is currently installed on a device. However, if this flag is set
///            to DIIRFLAG_FORCE_INF, <b>DiInstallDriver</b> installs the specified driver on a matching device whether the
///            driver is a better match for the device than the driver that is currently installed on the device. <div
///            class="alert"><b>Caution</b> Forcing the installation of the driver can result in replacing a more compatible or
///            newer driver with a less compatible or older driver. </div> <div> </div> For information about how Windows
///            selects a driver for a device, see How Windows Selects Drivers.
///    NeedReboot = A pointer to a value of type BOOL that <b>DiInstallDriver</b> sets to indicate whether a system is restart is
///                 required to complete the installation. This parameter is optional and can be <b>NULL</b>. If the parameter is
///                 supplied and a system restart is required to complete the installation, <b>DiInstallDriver</b> sets the value to
///                 <b>TRUE</b>. In this case, the caller must prompt the user to restart the system. If this parameter is supplied
///                 and a system restart is not required to complete the installation, <b>DiInstallDriver</b> sets the value to
///                 <b>FALSE</b>. If the parameter is <b>NULL</b> and a system restart is required to complete the installation,
///                 <b>DiInstallDriver</b> displays a system restart dialog box. For more information about this parameter, see the
///                 following <b>Remarks</b> section.
///Returns:
///    <b>DiInstallDriver</b> returns <b>TRUE</b> if the function successfully preinstalled the specified driver package
///    in the driver store. <b>DiInstallDriver</b> also returns <b>TRUE</b> if the function successfully installed the
///    driver on one or more devices in the system. If the driver package is not successfully installed in the driver
///    store, <b>DiInstallDriver</b> returns <b>FALSE</b> and the logged error can be retrieved by making call to
///    <b>GetLastError</b>. Some of the more common error values that <b>GetLastError</b> might return are as follows:
///    <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> The caller does not have Administrator
///    privileges. By default, Windows requires that the caller have Administrator privileges to preinstall a driver
///    package in the driver store. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_FILE_NOT_FOUND</b></dt> </dl>
///    </td> <td width="60%"> The path of the specified INF file does not exist. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_FLAGS</b></dt> </dl> </td> <td width="60%"> The value specified for <i>Flags</i> is not
///    equal to zero or DIIRFLAG_FORCE_INF. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_IN_WOW64</b></dt> </dl>
///    </td> <td width="60%"> The calling application is a 32-bit application that is attempting to execute in a 64-bit
///    environment, which is not allowed. For more information, see Installing Devices on 64-Bit Systems. </td> </tr>
///    </table>
///    
@DllImport("newdev")
BOOL DiInstallDriverA(HWND hwndParent, const(char)* InfPath, uint Flags, int* NeedReboot);

///The <b>DiUninstallDevice</b> function uninstalls a device and removes its device node (devnode) from the system. This
///differs from using SetupDiCallClassInstaller with the DIF_REMOVE code because it attempts to uninstall the device
///node in addition to child devnodes that are present at the time of the call. Prior to Windows 8 any child devices
///that are not present at the time of the call will not be uninstalled. However, beginning with Windows 8, any child
///devices that are not present at the time of the call will be uninstalled.
///Params:
///    hwndParent = A handle to the top-level window that is used to display any user interface component that is associated with the
///                 uninstallation request for the device. This parameter is optional and can be set to <b>NULL</b>.
///    DeviceInfoSet = A handle to the device information set that contains a device information element. This element represents the
///                    device to be uninstalled through this call.
///    DeviceInfoData = A pointer to an SP_DEVINFO_DATA structure that represents the specified device in the specified device
///                     information set for which the uninstallation request is performed.
///    Flags = A value of type DWORD that specifies device uninstallation flags. Starting with Windows 7, this parameter must be
///            set to zero.
///    NeedReboot = A pointer to a value of type BOOL that <b>DiUninstallDevice</b> sets to indicate whether a system restart is
///                 required to complete the device uninstallation request. This parameter is optional and can be set to <b>NULL</b>.
///                 If the parameter is given and a system restart is required, <b>DiUninstallDevice</b> sets the value to
///                 <b>TRUE</b>. In this case, the application must prompt the user to restart the system. If this parameter is
///                 supplied and a system restart is not required, <b>DiUninstallDevice</b> sets the value to <b>FALSE</b>. If this
///                 parameter is <b>NULL</b> and a system restart is required to complete the device uninstallation,
///                 <b>DiUninstallDevice</b> displays a system restart dialog box. For more information about this parameter, see the
///                 <b>Remarks</b> section.
///Returns:
///    <b>DiUninstallDevice</b> returns <b>TRUE</b> if the function successfully uninstalled the top-level device node
///    that represents the device. Otherwise, <b>DiUninstallDevice</b> returns <b>FALSE</b>, and the logged error can be
///    retrieved by making a call to GetLastError. The following list shows some of the more common error values that
///    <b>GetLastError</b> might return for this API: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> The caller does not have
///    Administrator privileges. By default, Windows requires that the caller have Administrator privileges to uninstall
///    devices. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_FLAGS</b></dt> </dl> </td> <td width="60%">
///    The value that is specified for the <i>Flags</i> parameter is not equal to zero. </td> </tr> </table> <div
///    class="alert"><b>Note</b> The return value does not indicate that the removal of all child devnodes has succeeded
///    or failed. Starting with Windows Vista, information about the status of the removal of child devnodes is
///    available in the <i>Setupapi.dev.log</i> file. For more information about this file, see SetupAPI Text
///    Logs.</div> <div> </div>
///    
@DllImport("newdev")
BOOL DiUninstallDevice(HWND hwndParent, void* DeviceInfoSet, SP_DEVINFO_DATA* DeviceInfoData, uint Flags, 
                       int* NeedReboot);

///The <b>DiUninstallDriver</b> function removes a driver from any devices it is installed on by installing those
///devices with another matching driver, if available, or the null driver if no other matching driver is available. Then
///the specified driver is removed from the driver store.
///Params:
///    hwndParent = A handle to the top-level window that <b>DiUninstallDriver</b> should use to display any user interface component
///                 that is associated with uninstalling the driver. This parameter is optional and can be set to <b>NULL</b>.
///    InfPath = A pointer to a NULL-terminated string that supplies the fully qualified path of the INF file for the driver
///              package.
///    Flags = A value of type DWORD that specifies zero or one or more of the following flags: DIURFLAG_NO_REMOVE_INF.
///            Typically, this flag should be set to zero. If this flag is zero, <b>DiUninstallDriver</b> only uninstalls the
///            specified driver from a device if the driver is a better match for a device than the driver that is currently
///            installed on a device. However, if this flag is set to DIURFLAG_NO_REMOVE_INF, <b>DiUninstallDriver</b> removes
///            the driver package from any devices it is installed on, but does not remove the drive package from the Driver
///            Store. <div class="alert"><b>Caution:</b> Forcing the uninstallation of the driver can result in replacing a more
///            compatible or newer driver with a less compatible or older driver. </div> <div> </div> For information about how
///            Windows selects a driver for a device, see How Windows Selects Drivers.
///    NeedReboot = A pointer to a value of type BOOL that <b>DiUninstallDriver</b> sets to indicate whether a system restart is
///                 required to complete the uninstallation. This parameter is optional and can be <b>NULL</b>. If the parameter is
///                 supplied and a system restart is required to complete the uninstallation, <b>DiUninstallDriver</b> sets the value
///                 to <b>TRUE</b>. In this case, the caller must prompt the user to restart the system. If this parameter is
///                 supplied and a system restart is not required to complete the uninstallation, <b>DiUninstallDriver</b> sets the
///                 value to <b>FALSE</b>. If the parameter is <b>NULL</b> and a system restart is required to complete the
///                 uninstallation, <b>DiUninstallDriver</b> displays a system restart dialog box. For more information about this
///                 parameter, see the following <b>Remarks</b> section.
///Returns:
///    <b>DiUninstallDriver</b> returns <b>TRUE</b> if the function successfully removes the driver package from any
///    devices it is installed on and is successfully removed from the driver store of the system. If the driver package
///    is not successfully uninstalled from the driver store, <b>DiUninstallDriver</b> returns <b>FALSE</b> and the
///    logged error can be retrieved by making a call to <b>GetLastError</b>. Some of the more common error values that
///    <b>GetLastError</b> might return are as follows: <table> <tr> <th>Return code</th> <th>Description</th> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> The caller does not
///    have Administrator privileges. By default, Windows requires that the caller have Administrator privileges to
///    uninstall a driver package from the driver store. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_FILE_NOT_FOUND</b></dt> </dl> </td> <td width="60%"> The path of the specified INF file does not
///    exist. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_FLAGS</b></dt> </dl> </td> <td width="60%">
///    The value specified for <i>Flags</i> is not equal to zero or DIURFLAG_NO_REMOVE_INF. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_IN_WOW64</b></dt> </dl> </td> <td width="60%"> The calling application is a 32-bit
///    application that is attempting to execute in a 64-bit environment, which is not allowed. For more information,
///    see Installing Devices on 64-Bit Systems. </td> </tr> </table>
///    
@DllImport("newdev")
BOOL DiUninstallDriverW(HWND hwndParent, const(wchar)* InfPath, uint Flags, int* NeedReboot);

@DllImport("newdev")
BOOL DiUninstallDriverA(HWND hwndParent, const(char)* InfPath, uint Flags, int* NeedReboot);

///The <b>DiShowUpdateDevice</b> function displays the Hardware Update wizard for a specified device.
///Params:
///    hwndParent = A handle to the top-level window that <b>DiShowUpdateDevice</b> uses to display any user interface components
///                 that are associated with updating the specified device. This parameter is optional and can be set to <b>NULL</b>.
///    DeviceInfoSet = A handle to the device information set that contains a device information element that represents the device for
///                    which to show the Hardware Update wizard.
///    DeviceInfoData = A pointer to an SP_DEVINFO_DATA structure that represents the device for which to show the Hardware Update
///                     wizard.
///    Flags = This parameter must be set to zero.
///    NeedReboot = A pointer to a value of type BOOL that <b>DiShowUpdateDevice</b> sets to indicate whether a system restart is
///                 required to complete the driver update. This parameter is optional and can be <b>NULL</b>. If the parameter is
///                 supplied and a system restart is required to complete the driver update, <b>DiShowUpdateDevice</b> sets the value
///                 to <b>TRUE</b>. In this case, the caller must prompt the user to restart the system. If this parameter is
///                 supplied and a system restart is not required to complete the installation, <b>DiShowUpdateDevice</b> sets the
///                 value to <b>FALSE</b>. If the parameter is <b>NULL</b> and a system restart is required to complete the driver
///                 update, <b>DiShowUpdateDevice</b> displays a system restart dialog box. For more information about this
///                 parameter, see the following <b>Remarks</b> section.
///Returns:
///    <b>DiShowUpdateDevice</b> returns <b>TRUE</b> if the Hardware Update wizard successfully updated the driver for
///    the specified device. Otherwise, <b>DiShowUpdateDevice</b> returns <b>FALSE</b> and the logged error can be
///    retrieved by making a call to GetLastError. Some of the more common error values that GetLastError might return
///    are as follows: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> The caller does not have Administrator
///    privileges. By default, Windows requires that the calling process have Administrator privileges to update a
///    driver package. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_CANCELLED</b></dt> </dl> </td> <td
///    width="60%"> The user canceled the Hardware Update wizard. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_IN_WOW64</b></dt> </dl> </td> <td width="60%"> The calling application is a 32-bit application that
///    is attempting to execute in a 64-bit environment, which is not allowed. For more information, see Installing
///    Devices on 64-Bit Systems. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_FLAGS</b></dt> </dl> </td>
///    <td width="60%"> The value specified for <i>Flags</i> is not equal to zero. </td> </tr> </table>
///    
@DllImport("newdev")
BOOL DiShowUpdateDevice(HWND hwndParent, void* DeviceInfoSet, SP_DEVINFO_DATA* DeviceInfoData, uint Flags, 
                        int* NeedReboot);

///The <b>DiRollbackDriver</b> function rolls back the driver that is installed on a specified device.
///Params:
///    DeviceInfoSet = A handle to the device information set that contains a device information element that represents the device for
///                    which driver rollback is performed.
///    DeviceInfoData = A pointer to an SP_DEVINFO_DATA structure that represents the specific device in the specified device information
///                     set for which driver rollback is performed.
///    hwndParent = A handle to the top-level window that <b>DiRollbackDriver</b> uses to display any user interface component that
///                 is associated with a driver rollback for the specified device. This parameter is optional and can be set to
///                 <b>NULL</b>.
///    Flags = A value of type DWORD that can be set to zero or ROLLBACK_FLAG_NO_UI. Typically, this flag should be set to zero,
///            in which case <b>DiRollbackDriver</b> does not suppress the default user interface components that are associated
///            with a driver rollback. However, if this flag is set to ROLLBACK_FLAG_NO_UI, <b>DiRollbackDriver</b> suppresses
///            the display of user interface components that are associated with a driver rollback.
///    NeedReboot = A pointer to a value of type BOOL that <b>DiRollbackDriver</b> sets to indicate whether a system restart is
///                 required to complete the rollback. This parameter is optional and can be <b>NULL</b>. If the parameter is
///                 supplied and a system restart is required to complete the rollback, <b>DiRollbackDriver</b> sets the value to
///                 <b>TRUE</b>. In this case, the caller must prompt the user to restart the system. If this parameter is supplied
///                 and a system restart is not required to complete the installation, <b>DiRollbackDriver</b> sets the value to
///                 <b>FALSE</b>. If the parameter is <b>NULL</b> and a system restart is required to complete the rollback,
///                 <b>DiRollbackDriver</b> displays a system restart dialog box. For more information about this parameter, see the
///                 following <b>Remarks</b> section.
///Returns:
///    <b>DiRollbackDriver</b> returns <b>TRUE</b> if the function successfully rolled back the driver for the device;
///    otherwise, <b>DiRollbackDriver</b> returns <b>FALSE</b> and the logged error can be retrieved by making a call to
///    <b>GetLastError</b>. Some of the more common error values that <b>GetLastError</b> might return are as follows:
///    <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> The caller does not have Administrator
///    privileges. By default, Windows requires that the caller have Administrator privileges to roll back a driver
///    package. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_IN_WOW64</b></dt> </dl> </td> <td width="60%"> The
///    calling application is a 32-bit application that is attempting to execute in a 64-bit environment, which is not
///    allowed. For more information, see Installing Devices on 64-Bit Systems. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_FLAGS</b></dt> </dl> </td> <td width="60%"> The value specified for <i>Flags</i> is not
///    equal to zero or ROLLBACK_FLAG_NO_UI. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NO_MORE_ITEMS</b></dt>
///    </dl> </td> <td width="60%"> A backup driver is not set for the device. </td> </tr> </table>
///    
@DllImport("newdev")
BOOL DiRollbackDriver(void* DeviceInfoSet, SP_DEVINFO_DATA* DeviceInfoData, HWND hwndParent, uint Flags, 
                      int* NeedReboot);

@DllImport("newdev")
BOOL DiShowUpdateDriver(HWND hwndParent, const(wchar)* FilePath, uint Flags, int* NeedReboot);


