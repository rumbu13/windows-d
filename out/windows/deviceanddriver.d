module windows.deviceanddriver;

public import system;
public import windows.applicationinstallationandservicing;
public import windows.controls;
public import windows.displaydevices;
public import windows.gdi;
public import windows.systemservices;
public import windows.windowsandmessaging;
public import windows.windowsprogramming;

extern(Windows):

struct SP_ALTPLATFORM_INFO_V3
{
    uint cbSize;
    uint Platform;
    uint MajorVersion;
    uint MinorVersion;
    ushort ProcessorArchitecture;
    _Anonymous_e__Union Anonymous;
    uint FirstValidatedMajorVersion;
    uint FirstValidatedMinorVersion;
    ubyte ProductType;
    ushort SuiteMask;
    uint BuildNumber;
}

struct SP_DEVINFO_DATA
{
    uint cbSize;
    Guid ClassGuid;
    uint DevInst;
    uint Reserved;
}

struct SP_DEVICE_INTERFACE_DATA
{
    uint cbSize;
    Guid InterfaceClassGuid;
    uint Flags;
    uint Reserved;
}

struct SP_DEVICE_INTERFACE_DETAIL_DATA_A
{
    uint cbSize;
    byte DevicePath;
}

struct SP_DEVICE_INTERFACE_DETAIL_DATA_W
{
    uint cbSize;
    ushort DevicePath;
}

struct SP_DEVINFO_LIST_DETAIL_DATA_A
{
    uint cbSize;
    Guid ClassGuid;
    HANDLE RemoteMachineHandle;
    byte RemoteMachineName;
}

struct SP_DEVINFO_LIST_DETAIL_DATA_W
{
    uint cbSize;
    Guid ClassGuid;
    HANDLE RemoteMachineHandle;
    ushort RemoteMachineName;
}

struct SP_DEVINSTALL_PARAMS_A
{
    uint cbSize;
    uint Flags;
    uint FlagsEx;
    HWND hwndParent;
    PSP_FILE_CALLBACK_A InstallMsgHandler;
    void* InstallMsgHandlerContext;
    void* FileQueue;
    uint ClassInstallReserved;
    uint Reserved;
    byte DriverPath;
}

struct SP_DEVINSTALL_PARAMS_W
{
    uint cbSize;
    uint Flags;
    uint FlagsEx;
    HWND hwndParent;
    PSP_FILE_CALLBACK_A InstallMsgHandler;
    void* InstallMsgHandlerContext;
    void* FileQueue;
    uint ClassInstallReserved;
    uint Reserved;
    ushort DriverPath;
}

struct SP_CLASSINSTALL_HEADER
{
    uint cbSize;
    uint InstallFunction;
}

struct SP_ENABLECLASS_PARAMS
{
    SP_CLASSINSTALL_HEADER ClassInstallHeader;
    Guid ClassGuid;
    uint EnableMessage;
}

struct SP_PROPCHANGE_PARAMS
{
    SP_CLASSINSTALL_HEADER ClassInstallHeader;
    uint StateChange;
    uint Scope;
    uint HwProfile;
}

struct SP_REMOVEDEVICE_PARAMS
{
    SP_CLASSINSTALL_HEADER ClassInstallHeader;
    uint Scope;
    uint HwProfile;
}

struct SP_UNREMOVEDEVICE_PARAMS
{
    SP_CLASSINSTALL_HEADER ClassInstallHeader;
    uint Scope;
    uint HwProfile;
}

struct SP_SELECTDEVICE_PARAMS_A
{
    SP_CLASSINSTALL_HEADER ClassInstallHeader;
    byte Title;
    byte Instructions;
    byte ListLabel;
    byte SubTitle;
    ubyte Reserved;
}

struct SP_SELECTDEVICE_PARAMS_W
{
    SP_CLASSINSTALL_HEADER ClassInstallHeader;
    ushort Title;
    ushort Instructions;
    ushort ListLabel;
    ushort SubTitle;
}

alias PDETECT_PROGRESS_NOTIFY = extern(Windows) BOOL function(void* ProgressNotifyParam, uint DetectComplete);
struct SP_DETECTDEVICE_PARAMS
{
    SP_CLASSINSTALL_HEADER ClassInstallHeader;
    PDETECT_PROGRESS_NOTIFY DetectProgressNotify;
    void* ProgressNotifyParam;
}

struct SP_INSTALLWIZARD_DATA
{
    SP_CLASSINSTALL_HEADER ClassInstallHeader;
    uint Flags;
    int DynamicPages;
    uint NumDynamicPages;
    uint DynamicPageFlags;
    uint PrivateFlags;
    LPARAM PrivateData;
    HWND hwndWizardDlg;
}

struct SP_NEWDEVICEWIZARD_DATA
{
    SP_CLASSINSTALL_HEADER ClassInstallHeader;
    uint Flags;
    int DynamicPages;
    uint NumDynamicPages;
    HWND hwndWizardDlg;
}

struct SP_TROUBLESHOOTER_PARAMS_A
{
    SP_CLASSINSTALL_HEADER ClassInstallHeader;
    byte ChmFile;
    byte HtmlTroubleShooter;
}

struct SP_TROUBLESHOOTER_PARAMS_W
{
    SP_CLASSINSTALL_HEADER ClassInstallHeader;
    ushort ChmFile;
    ushort HtmlTroubleShooter;
}

struct SP_POWERMESSAGEWAKE_PARAMS_A
{
    SP_CLASSINSTALL_HEADER ClassInstallHeader;
    byte PowerMessageWake;
}

struct SP_POWERMESSAGEWAKE_PARAMS_W
{
    SP_CLASSINSTALL_HEADER ClassInstallHeader;
    ushort PowerMessageWake;
}

struct SP_DRVINFO_DATA_V2_A
{
    uint cbSize;
    uint DriverType;
    uint Reserved;
    byte Description;
    byte MfgName;
    byte ProviderName;
    FILETIME DriverDate;
    ulong DriverVersion;
}

struct SP_DRVINFO_DATA_V2_W
{
    uint cbSize;
    uint DriverType;
    uint Reserved;
    ushort Description;
    ushort MfgName;
    ushort ProviderName;
    FILETIME DriverDate;
    ulong DriverVersion;
}

struct SP_DRVINFO_DATA_V1_A
{
    uint cbSize;
    uint DriverType;
    uint Reserved;
    byte Description;
    byte MfgName;
    byte ProviderName;
}

struct SP_DRVINFO_DATA_V1_W
{
    uint cbSize;
    uint DriverType;
    uint Reserved;
    ushort Description;
    ushort MfgName;
    ushort ProviderName;
}

struct SP_DRVINFO_DETAIL_DATA_A
{
    uint cbSize;
    FILETIME InfDate;
    uint CompatIDsOffset;
    uint CompatIDsLength;
    uint Reserved;
    byte SectionName;
    byte InfFileName;
    byte DrvDescription;
    byte HardwareID;
}

struct SP_DRVINFO_DETAIL_DATA_W
{
    uint cbSize;
    FILETIME InfDate;
    uint CompatIDsOffset;
    uint CompatIDsLength;
    uint Reserved;
    ushort SectionName;
    ushort InfFileName;
    ushort DrvDescription;
    ushort HardwareID;
}

struct SP_DRVINSTALL_PARAMS
{
    uint cbSize;
    uint Rank;
    uint Flags;
    uint PrivateData;
    uint Reserved;
}

alias PSP_DETSIG_CMPPROC = extern(Windows) uint function(void* DeviceInfoSet, SP_DEVINFO_DATA* NewDeviceData, SP_DEVINFO_DATA* ExistingDeviceData, void* CompareContext);
struct COINSTALLER_CONTEXT_DATA
{
    BOOL PostProcessing;
    uint InstallResult;
    void* PrivateData;
}

struct SP_CLASSIMAGELIST_DATA
{
    uint cbSize;
    HIMAGELIST ImageList;
    uint Reserved;
}

struct SP_PROPSHEETPAGE_REQUEST
{
    uint cbSize;
    uint PageRequested;
    void* DeviceInfoSet;
    SP_DEVINFO_DATA* DeviceInfoData;
}

struct SP_BACKUP_QUEUE_PARAMS_V2_A
{
    uint cbSize;
    byte FullInfPath;
    int FilenameOffset;
    byte ReinstallInstance;
}

struct SP_BACKUP_QUEUE_PARAMS_V2_W
{
    uint cbSize;
    ushort FullInfPath;
    int FilenameOffset;
    ushort ReinstallInstance;
}

struct SP_BACKUP_QUEUE_PARAMS_V1_A
{
    uint cbSize;
    byte FullInfPath;
    int FilenameOffset;
}

struct SP_BACKUP_QUEUE_PARAMS_V1_W
{
    uint cbSize;
    ushort FullInfPath;
    int FilenameOffset;
}

enum SetupFileLogInfo
{
    SetupFileLogSourceFilename = 0,
    SetupFileLogChecksum = 1,
    SetupFileLogDiskTagfile = 2,
    SetupFileLogDiskDescription = 3,
    SetupFileLogOtherInfo = 4,
    SetupFileLogMax = 5,
}

enum PNP_VETO_TYPE
{
    PNP_VetoTypeUnknown = 0,
    PNP_VetoLegacyDevice = 1,
    PNP_VetoPendingClose = 2,
    PNP_VetoWindowsApp = 3,
    PNP_VetoWindowsService = 4,
    PNP_VetoOutstandingOpen = 5,
    PNP_VetoDevice = 6,
    PNP_VetoDriver = 7,
    PNP_VetoIllegalDeviceRequest = 8,
    PNP_VetoInsufficientPower = 9,
    PNP_VetoNonDisableable = 10,
    PNP_VetoLegacyDriver = 11,
    PNP_VetoInsufficientRights = 12,
    PNP_VetoAlreadyRemoved = 13,
}

struct CONFLICT_DETAILS_A
{
    uint CD_ulSize;
    uint CD_ulMask;
    uint CD_dnDevInst;
    uint CD_rdResDes;
    uint CD_ulFlags;
    byte CD_szDescription;
}

struct CONFLICT_DETAILS_W
{
    uint CD_ulSize;
    uint CD_ulMask;
    uint CD_dnDevInst;
    uint CD_rdResDes;
    uint CD_ulFlags;
    ushort CD_szDescription;
}

struct MEM_RANGE
{
    ulong MR_Align;
    uint MR_nBytes;
    ulong MR_Min;
    ulong MR_Max;
    uint MR_Flags;
    uint MR_Reserved;
}

struct MEM_DES
{
    uint MD_Count;
    uint MD_Type;
    ulong MD_Alloc_Base;
    ulong MD_Alloc_End;
    uint MD_Flags;
    uint MD_Reserved;
}

struct MEM_RESOURCE
{
    MEM_DES MEM_Header;
    MEM_RANGE MEM_Data;
}

struct Mem_Large_Range_s
{
    ulong MLR_Align;
    ulong MLR_nBytes;
    ulong MLR_Min;
    ulong MLR_Max;
    uint MLR_Flags;
    uint MLR_Reserved;
}

struct Mem_Large_Des_s
{
    uint MLD_Count;
    uint MLD_Type;
    ulong MLD_Alloc_Base;
    ulong MLD_Alloc_End;
    uint MLD_Flags;
    uint MLD_Reserved;
}

struct Mem_Large_Resource_s
{
    Mem_Large_Des_s MEM_LARGE_Header;
    Mem_Large_Range_s MEM_LARGE_Data;
}

struct IO_RANGE
{
    ulong IOR_Align;
    uint IOR_nPorts;
    ulong IOR_Min;
    ulong IOR_Max;
    uint IOR_RangeFlags;
    ulong IOR_Alias;
}

struct IO_DES
{
    uint IOD_Count;
    uint IOD_Type;
    ulong IOD_Alloc_Base;
    ulong IOD_Alloc_End;
    uint IOD_DesFlags;
}

struct IO_RESOURCE
{
    IO_DES IO_Header;
    IO_RANGE IO_Data;
}

struct DMA_RANGE
{
    uint DR_Min;
    uint DR_Max;
    uint DR_Flags;
}

struct DMA_DES
{
    uint DD_Count;
    uint DD_Type;
    uint DD_Flags;
    uint DD_Alloc_Chan;
}

struct DMA_RESOURCE
{
    DMA_DES DMA_Header;
    DMA_RANGE DMA_Data;
}

struct IRQ_RANGE
{
    uint IRQR_Min;
    uint IRQR_Max;
    uint IRQR_Flags;
}

struct IRQ_DES_32
{
    uint IRQD_Count;
    uint IRQD_Type;
    uint IRQD_Flags;
    uint IRQD_Alloc_Num;
    uint IRQD_Affinity;
}

struct IRQ_DES_64
{
    uint IRQD_Count;
    uint IRQD_Type;
    uint IRQD_Flags;
    uint IRQD_Alloc_Num;
    ulong IRQD_Affinity;
}

struct IRQ_RESOURCE_32
{
    IRQ_DES_32 IRQ_Header;
    IRQ_RANGE IRQ_Data;
}

struct IRQ_RESOURCE_64
{
    IRQ_DES_64 IRQ_Header;
    IRQ_RANGE IRQ_Data;
}

struct DevPrivate_Range_s
{
    uint PR_Data1;
    uint PR_Data2;
    uint PR_Data3;
}

struct DevPrivate_Des_s
{
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
    DevPrivate_Range_s PRV_Data;
}

struct CS_DES
{
    uint CSD_SignatureLength;
    uint CSD_LegacyDataOffset;
    uint CSD_LegacyDataSize;
    uint CSD_Flags;
    Guid CSD_ClassGuid;
    ubyte CSD_Signature;
}

struct CS_RESOURCE
{
    CS_DES CS_Header;
}

struct PCCARD_DES
{
    uint PCD_Count;
    uint PCD_Type;
    uint PCD_Flags;
    ubyte PCD_ConfigIndex;
    ubyte PCD_Reserved;
    uint PCD_MemoryCardBase1;
    uint PCD_MemoryCardBase2;
    uint PCD_MemoryCardBase;
    ushort PCD_MemoryFlags;
    ubyte PCD_IoFlags;
}

struct PCCARD_RESOURCE
{
    PCCARD_DES PcCard_Header;
}

struct MFCARD_DES
{
    uint PMF_Count;
    uint PMF_Type;
    uint PMF_Flags;
    ubyte PMF_ConfigOptions;
    ubyte PMF_IoResourceIndex;
    ubyte PMF_Reserved;
    uint PMF_ConfigRegisterBase;
}

struct MFCARD_RESOURCE
{
    MFCARD_DES MfCard_Header;
}

struct BUSNUMBER_RANGE
{
    uint BUSR_Min;
    uint BUSR_Max;
    uint BUSR_nBusNumbers;
    uint BUSR_Flags;
}

struct BUSNUMBER_DES
{
    uint BUSD_Count;
    uint BUSD_Type;
    uint BUSD_Flags;
    uint BUSD_Alloc_Base;
    uint BUSD_Alloc_End;
}

struct BUSNUMBER_RESOURCE
{
    BUSNUMBER_DES BusNumber_Header;
    BUSNUMBER_RANGE BusNumber_Data;
}

struct Connection_Des_s
{
    uint COND_Type;
    uint COND_Flags;
    ubyte COND_Class;
    ubyte COND_ClassType;
    ubyte COND_Reserved1;
    ubyte COND_Reserved2;
    LARGE_INTEGER COND_Id;
}

struct Connection_Resource_s
{
    Connection_Des_s Connection_Header;
}

struct HWProfileInfo_sA
{
    uint HWPI_ulHWProfile;
    byte HWPI_szFriendlyName;
    uint HWPI_dwFlags;
}

struct HWProfileInfo_sW
{
    uint HWPI_ulHWProfile;
    ushort HWPI_szFriendlyName;
    uint HWPI_dwFlags;
}

struct HCMNOTIFICATION__
{
    int unused;
}

enum CM_NOTIFY_FILTER_TYPE
{
    CM_NOTIFY_FILTER_TYPE_DEVICEINTERFACE = 0,
    CM_NOTIFY_FILTER_TYPE_DEVICEHANDLE = 1,
    CM_NOTIFY_FILTER_TYPE_DEVICEINSTANCE = 2,
    CM_NOTIFY_FILTER_TYPE_MAX = 3,
}

struct CM_NOTIFY_FILTER
{
    uint cbSize;
    uint Flags;
    CM_NOTIFY_FILTER_TYPE FilterType;
    uint Reserved;
    _u_e__Union u;
}

enum CM_NOTIFY_ACTION
{
    CM_NOTIFY_ACTION_DEVICEINTERFACEARRIVAL = 0,
    CM_NOTIFY_ACTION_DEVICEINTERFACEREMOVAL = 1,
    CM_NOTIFY_ACTION_DEVICEQUERYREMOVE = 2,
    CM_NOTIFY_ACTION_DEVICEQUERYREMOVEFAILED = 3,
    CM_NOTIFY_ACTION_DEVICEREMOVEPENDING = 4,
    CM_NOTIFY_ACTION_DEVICEREMOVECOMPLETE = 5,
    CM_NOTIFY_ACTION_DEVICECUSTOMEVENT = 6,
    CM_NOTIFY_ACTION_DEVICEINSTANCEENUMERATED = 7,
    CM_NOTIFY_ACTION_DEVICEINSTANCESTARTED = 8,
    CM_NOTIFY_ACTION_DEVICEINSTANCEREMOVED = 9,
    CM_NOTIFY_ACTION_MAX = 10,
}

struct CM_NOTIFY_EVENT_DATA
{
    CM_NOTIFY_FILTER_TYPE FilterType;
    uint Reserved;
    _u_e__Union u;
}

alias PCM_NOTIFY_CALLBACK = extern(Windows) uint function(HCMNOTIFICATION__* hNotify, void* Context, CM_NOTIFY_ACTION Action, char* EventData, uint EventDataSize);
@DllImport("SETUPAPI.dll")
BOOL SetupGetInfDriverStoreLocationA(const(char)* FileName, SP_ALTPLATFORM_INFO_V2* AlternatePlatformInfo, const(char)* LocaleName, const(char)* ReturnBuffer, uint ReturnBufferSize, uint* RequiredSize);

@DllImport("SETUPAPI.dll")
BOOL SetupGetInfDriverStoreLocationW(const(wchar)* FileName, SP_ALTPLATFORM_INFO_V2* AlternatePlatformInfo, const(wchar)* LocaleName, const(wchar)* ReturnBuffer, uint ReturnBufferSize, uint* RequiredSize);

@DllImport("SETUPAPI.dll")
BOOL SetupGetInfPublishedNameA(const(char)* DriverStoreLocation, const(char)* ReturnBuffer, uint ReturnBufferSize, uint* RequiredSize);

@DllImport("SETUPAPI.dll")
BOOL SetupGetInfPublishedNameW(const(wchar)* DriverStoreLocation, const(wchar)* ReturnBuffer, uint ReturnBufferSize, uint* RequiredSize);

@DllImport("SETUPAPI.dll")
ulong SetupGetThreadLogToken();

@DllImport("SETUPAPI.dll")
void SetupSetThreadLogToken(ulong LogToken);

@DllImport("SETUPAPI.dll")
void SetupWriteTextLog(ulong LogToken, uint Category, uint Flags, const(char)* MessageStr);

@DllImport("SETUPAPI.dll")
void SetupWriteTextLogError(ulong LogToken, uint Category, uint LogFlags, uint Error, const(char)* MessageStr);

@DllImport("SETUPAPI.dll")
void SetupWriteTextLogInfLine(ulong LogToken, uint Flags, void* InfHandle, INFCONTEXT* Context);

@DllImport("SETUPAPI.dll")
BOOL SetupGetBackupInformationA(void* QueueHandle, SP_BACKUP_QUEUE_PARAMS_V2_A* BackupParams);

@DllImport("SETUPAPI.dll")
BOOL SetupGetBackupInformationW(void* QueueHandle, SP_BACKUP_QUEUE_PARAMS_V2_W* BackupParams);

@DllImport("SETUPAPI.dll")
BOOL SetupPrepareQueueForRestoreA(void* QueueHandle, const(char)* BackupPath, uint RestoreFlags);

@DllImport("SETUPAPI.dll")
BOOL SetupPrepareQueueForRestoreW(void* QueueHandle, const(wchar)* BackupPath, uint RestoreFlags);

@DllImport("SETUPAPI.dll")
BOOL SetupSetNonInteractiveMode(BOOL NonInteractiveFlag);

@DllImport("SETUPAPI.dll")
BOOL SetupGetNonInteractiveMode();

@DllImport("SETUPAPI.dll")
void* SetupDiCreateDeviceInfoList(const(Guid)* ClassGuid, HWND hwndParent);

@DllImport("SETUPAPI.dll")
void* SetupDiCreateDeviceInfoListExA(const(Guid)* ClassGuid, HWND hwndParent, const(char)* MachineName, void* Reserved);

@DllImport("SETUPAPI.dll")
void* SetupDiCreateDeviceInfoListExW(const(Guid)* ClassGuid, HWND hwndParent, const(wchar)* MachineName, void* Reserved);

@DllImport("SETUPAPI.dll")
BOOL SetupDiGetDeviceInfoListClass(void* DeviceInfoSet, Guid* ClassGuid);

@DllImport("SETUPAPI.dll")
BOOL SetupDiGetDeviceInfoListDetailA(void* DeviceInfoSet, SP_DEVINFO_LIST_DETAIL_DATA_A* DeviceInfoSetDetailData);

@DllImport("SETUPAPI.dll")
BOOL SetupDiGetDeviceInfoListDetailW(void* DeviceInfoSet, SP_DEVINFO_LIST_DETAIL_DATA_W* DeviceInfoSetDetailData);

@DllImport("SETUPAPI.dll")
BOOL SetupDiCreateDeviceInfoA(void* DeviceInfoSet, const(char)* DeviceName, const(Guid)* ClassGuid, const(char)* DeviceDescription, HWND hwndParent, uint CreationFlags, SP_DEVINFO_DATA* DeviceInfoData);

@DllImport("SETUPAPI.dll")
BOOL SetupDiCreateDeviceInfoW(void* DeviceInfoSet, const(wchar)* DeviceName, const(Guid)* ClassGuid, const(wchar)* DeviceDescription, HWND hwndParent, uint CreationFlags, SP_DEVINFO_DATA* DeviceInfoData);

@DllImport("SETUPAPI.dll")
BOOL SetupDiOpenDeviceInfoA(void* DeviceInfoSet, const(char)* DeviceInstanceId, HWND hwndParent, uint OpenFlags, SP_DEVINFO_DATA* DeviceInfoData);

@DllImport("SETUPAPI.dll")
BOOL SetupDiOpenDeviceInfoW(void* DeviceInfoSet, const(wchar)* DeviceInstanceId, HWND hwndParent, uint OpenFlags, SP_DEVINFO_DATA* DeviceInfoData);

@DllImport("SETUPAPI.dll")
BOOL SetupDiGetDeviceInstanceIdA(void* DeviceInfoSet, SP_DEVINFO_DATA* DeviceInfoData, const(char)* DeviceInstanceId, uint DeviceInstanceIdSize, uint* RequiredSize);

@DllImport("SETUPAPI.dll")
BOOL SetupDiGetDeviceInstanceIdW(void* DeviceInfoSet, SP_DEVINFO_DATA* DeviceInfoData, const(wchar)* DeviceInstanceId, uint DeviceInstanceIdSize, uint* RequiredSize);

@DllImport("SETUPAPI.dll")
BOOL SetupDiDeleteDeviceInfo(void* DeviceInfoSet, SP_DEVINFO_DATA* DeviceInfoData);

@DllImport("SETUPAPI.dll")
BOOL SetupDiEnumDeviceInfo(void* DeviceInfoSet, uint MemberIndex, SP_DEVINFO_DATA* DeviceInfoData);

@DllImport("SETUPAPI.dll")
BOOL SetupDiDestroyDeviceInfoList(void* DeviceInfoSet);

@DllImport("SETUPAPI.dll")
BOOL SetupDiEnumDeviceInterfaces(void* DeviceInfoSet, SP_DEVINFO_DATA* DeviceInfoData, const(Guid)* InterfaceClassGuid, uint MemberIndex, SP_DEVICE_INTERFACE_DATA* DeviceInterfaceData);

@DllImport("SETUPAPI.dll")
BOOL SetupDiCreateDeviceInterfaceA(void* DeviceInfoSet, SP_DEVINFO_DATA* DeviceInfoData, const(Guid)* InterfaceClassGuid, const(char)* ReferenceString, uint CreationFlags, SP_DEVICE_INTERFACE_DATA* DeviceInterfaceData);

@DllImport("SETUPAPI.dll")
BOOL SetupDiCreateDeviceInterfaceW(void* DeviceInfoSet, SP_DEVINFO_DATA* DeviceInfoData, const(Guid)* InterfaceClassGuid, const(wchar)* ReferenceString, uint CreationFlags, SP_DEVICE_INTERFACE_DATA* DeviceInterfaceData);

@DllImport("SETUPAPI.dll")
BOOL SetupDiOpenDeviceInterfaceA(void* DeviceInfoSet, const(char)* DevicePath, uint OpenFlags, SP_DEVICE_INTERFACE_DATA* DeviceInterfaceData);

@DllImport("SETUPAPI.dll")
BOOL SetupDiOpenDeviceInterfaceW(void* DeviceInfoSet, const(wchar)* DevicePath, uint OpenFlags, SP_DEVICE_INTERFACE_DATA* DeviceInterfaceData);

@DllImport("SETUPAPI.dll")
BOOL SetupDiGetDeviceInterfaceAlias(void* DeviceInfoSet, SP_DEVICE_INTERFACE_DATA* DeviceInterfaceData, const(Guid)* AliasInterfaceClassGuid, SP_DEVICE_INTERFACE_DATA* AliasDeviceInterfaceData);

@DllImport("SETUPAPI.dll")
BOOL SetupDiDeleteDeviceInterfaceData(void* DeviceInfoSet, SP_DEVICE_INTERFACE_DATA* DeviceInterfaceData);

@DllImport("SETUPAPI.dll")
BOOL SetupDiRemoveDeviceInterface(void* DeviceInfoSet, SP_DEVICE_INTERFACE_DATA* DeviceInterfaceData);

@DllImport("SETUPAPI.dll")
BOOL SetupDiGetDeviceInterfaceDetailA(void* DeviceInfoSet, SP_DEVICE_INTERFACE_DATA* DeviceInterfaceData, char* DeviceInterfaceDetailData, uint DeviceInterfaceDetailDataSize, uint* RequiredSize, SP_DEVINFO_DATA* DeviceInfoData);

@DllImport("SETUPAPI.dll")
BOOL SetupDiGetDeviceInterfaceDetailW(void* DeviceInfoSet, SP_DEVICE_INTERFACE_DATA* DeviceInterfaceData, char* DeviceInterfaceDetailData, uint DeviceInterfaceDetailDataSize, uint* RequiredSize, SP_DEVINFO_DATA* DeviceInfoData);

@DllImport("SETUPAPI.dll")
BOOL SetupDiInstallDeviceInterfaces(void* DeviceInfoSet, SP_DEVINFO_DATA* DeviceInfoData);

@DllImport("SETUPAPI.dll")
BOOL SetupDiSetDeviceInterfaceDefault(void* DeviceInfoSet, SP_DEVICE_INTERFACE_DATA* DeviceInterfaceData, uint Flags, void* Reserved);

@DllImport("SETUPAPI.dll")
BOOL SetupDiRegisterDeviceInfo(void* DeviceInfoSet, SP_DEVINFO_DATA* DeviceInfoData, uint Flags, PSP_DETSIG_CMPPROC CompareProc, void* CompareContext, SP_DEVINFO_DATA* DupDeviceInfoData);

@DllImport("SETUPAPI.dll")
BOOL SetupDiBuildDriverInfoList(void* DeviceInfoSet, SP_DEVINFO_DATA* DeviceInfoData, uint DriverType);

@DllImport("SETUPAPI.dll")
BOOL SetupDiCancelDriverInfoSearch(void* DeviceInfoSet);

@DllImport("SETUPAPI.dll")
BOOL SetupDiEnumDriverInfoA(void* DeviceInfoSet, SP_DEVINFO_DATA* DeviceInfoData, uint DriverType, uint MemberIndex, SP_DRVINFO_DATA_V2_A* DriverInfoData);

@DllImport("SETUPAPI.dll")
BOOL SetupDiEnumDriverInfoW(void* DeviceInfoSet, SP_DEVINFO_DATA* DeviceInfoData, uint DriverType, uint MemberIndex, SP_DRVINFO_DATA_V2_W* DriverInfoData);

@DllImport("SETUPAPI.dll")
BOOL SetupDiGetSelectedDriverA(void* DeviceInfoSet, SP_DEVINFO_DATA* DeviceInfoData, SP_DRVINFO_DATA_V2_A* DriverInfoData);

@DllImport("SETUPAPI.dll")
BOOL SetupDiGetSelectedDriverW(void* DeviceInfoSet, SP_DEVINFO_DATA* DeviceInfoData, SP_DRVINFO_DATA_V2_W* DriverInfoData);

@DllImport("SETUPAPI.dll")
BOOL SetupDiSetSelectedDriverA(void* DeviceInfoSet, SP_DEVINFO_DATA* DeviceInfoData, SP_DRVINFO_DATA_V2_A* DriverInfoData);

@DllImport("SETUPAPI.dll")
BOOL SetupDiSetSelectedDriverW(void* DeviceInfoSet, SP_DEVINFO_DATA* DeviceInfoData, SP_DRVINFO_DATA_V2_W* DriverInfoData);

@DllImport("SETUPAPI.dll")
BOOL SetupDiGetDriverInfoDetailA(void* DeviceInfoSet, SP_DEVINFO_DATA* DeviceInfoData, SP_DRVINFO_DATA_V2_A* DriverInfoData, char* DriverInfoDetailData, uint DriverInfoDetailDataSize, uint* RequiredSize);

@DllImport("SETUPAPI.dll")
BOOL SetupDiGetDriverInfoDetailW(void* DeviceInfoSet, SP_DEVINFO_DATA* DeviceInfoData, SP_DRVINFO_DATA_V2_W* DriverInfoData, char* DriverInfoDetailData, uint DriverInfoDetailDataSize, uint* RequiredSize);

@DllImport("SETUPAPI.dll")
BOOL SetupDiDestroyDriverInfoList(void* DeviceInfoSet, SP_DEVINFO_DATA* DeviceInfoData, uint DriverType);

@DllImport("SETUPAPI.dll")
void* SetupDiGetClassDevsW(const(Guid)* ClassGuid, const(wchar)* Enumerator, HWND hwndParent, uint Flags);

@DllImport("SETUPAPI.dll")
void* SetupDiGetClassDevsExA(const(Guid)* ClassGuid, const(char)* Enumerator, HWND hwndParent, uint Flags, void* DeviceInfoSet, const(char)* MachineName, void* Reserved);

@DllImport("SETUPAPI.dll")
void* SetupDiGetClassDevsExW(const(Guid)* ClassGuid, const(wchar)* Enumerator, HWND hwndParent, uint Flags, void* DeviceInfoSet, const(wchar)* MachineName, void* Reserved);

@DllImport("SETUPAPI.dll")
BOOL SetupDiGetINFClassA(const(char)* InfName, Guid* ClassGuid, const(char)* ClassName, uint ClassNameSize, uint* RequiredSize);

@DllImport("SETUPAPI.dll")
BOOL SetupDiGetINFClassW(const(wchar)* InfName, Guid* ClassGuid, const(wchar)* ClassName, uint ClassNameSize, uint* RequiredSize);

@DllImport("SETUPAPI.dll")
BOOL SetupDiBuildClassInfoList(uint Flags, char* ClassGuidList, uint ClassGuidListSize, uint* RequiredSize);

@DllImport("SETUPAPI.dll")
BOOL SetupDiBuildClassInfoListExA(uint Flags, char* ClassGuidList, uint ClassGuidListSize, uint* RequiredSize, const(char)* MachineName, void* Reserved);

@DllImport("SETUPAPI.dll")
BOOL SetupDiBuildClassInfoListExW(uint Flags, char* ClassGuidList, uint ClassGuidListSize, uint* RequiredSize, const(wchar)* MachineName, void* Reserved);

@DllImport("SETUPAPI.dll")
BOOL SetupDiGetClassDescriptionA(const(Guid)* ClassGuid, const(char)* ClassDescription, uint ClassDescriptionSize, uint* RequiredSize);

@DllImport("SETUPAPI.dll")
BOOL SetupDiGetClassDescriptionW(const(Guid)* ClassGuid, const(wchar)* ClassDescription, uint ClassDescriptionSize, uint* RequiredSize);

@DllImport("SETUPAPI.dll")
BOOL SetupDiGetClassDescriptionExA(const(Guid)* ClassGuid, const(char)* ClassDescription, uint ClassDescriptionSize, uint* RequiredSize, const(char)* MachineName, void* Reserved);

@DllImport("SETUPAPI.dll")
BOOL SetupDiGetClassDescriptionExW(const(Guid)* ClassGuid, const(wchar)* ClassDescription, uint ClassDescriptionSize, uint* RequiredSize, const(wchar)* MachineName, void* Reserved);

@DllImport("SETUPAPI.dll")
BOOL SetupDiCallClassInstaller(uint InstallFunction, void* DeviceInfoSet, SP_DEVINFO_DATA* DeviceInfoData);

@DllImport("SETUPAPI.dll")
BOOL SetupDiSelectDevice(void* DeviceInfoSet, SP_DEVINFO_DATA* DeviceInfoData);

@DllImport("SETUPAPI.dll")
BOOL SetupDiSelectBestCompatDrv(void* DeviceInfoSet, SP_DEVINFO_DATA* DeviceInfoData);

@DllImport("SETUPAPI.dll")
BOOL SetupDiInstallDevice(void* DeviceInfoSet, SP_DEVINFO_DATA* DeviceInfoData);

@DllImport("SETUPAPI.dll")
BOOL SetupDiInstallDriverFiles(void* DeviceInfoSet, SP_DEVINFO_DATA* DeviceInfoData);

@DllImport("SETUPAPI.dll")
BOOL SetupDiRegisterCoDeviceInstallers(void* DeviceInfoSet, SP_DEVINFO_DATA* DeviceInfoData);

@DllImport("SETUPAPI.dll")
BOOL SetupDiRemoveDevice(void* DeviceInfoSet, SP_DEVINFO_DATA* DeviceInfoData);

@DllImport("SETUPAPI.dll")
BOOL SetupDiUnremoveDevice(void* DeviceInfoSet, SP_DEVINFO_DATA* DeviceInfoData);

@DllImport("SETUPAPI.dll")
BOOL SetupDiRestartDevices(void* DeviceInfoSet, SP_DEVINFO_DATA* DeviceInfoData);

@DllImport("SETUPAPI.dll")
BOOL SetupDiChangeState(void* DeviceInfoSet, SP_DEVINFO_DATA* DeviceInfoData);

@DllImport("SETUPAPI.dll")
BOOL SetupDiInstallClassA(HWND hwndParent, const(char)* InfFileName, uint Flags, void* FileQueue);

@DllImport("SETUPAPI.dll")
BOOL SetupDiInstallClassW(HWND hwndParent, const(wchar)* InfFileName, uint Flags, void* FileQueue);

@DllImport("SETUPAPI.dll")
BOOL SetupDiInstallClassExA(HWND hwndParent, const(char)* InfFileName, uint Flags, void* FileQueue, const(Guid)* InterfaceClassGuid, void* Reserved1, void* Reserved2);

@DllImport("SETUPAPI.dll")
BOOL SetupDiInstallClassExW(HWND hwndParent, const(wchar)* InfFileName, uint Flags, void* FileQueue, const(Guid)* InterfaceClassGuid, void* Reserved1, void* Reserved2);

@DllImport("SETUPAPI.dll")
HKEY SetupDiOpenClassRegKey(const(Guid)* ClassGuid, uint samDesired);

@DllImport("SETUPAPI.dll")
HKEY SetupDiOpenClassRegKeyExA(const(Guid)* ClassGuid, uint samDesired, uint Flags, const(char)* MachineName, void* Reserved);

@DllImport("SETUPAPI.dll")
HKEY SetupDiOpenClassRegKeyExW(const(Guid)* ClassGuid, uint samDesired, uint Flags, const(wchar)* MachineName, void* Reserved);

@DllImport("SETUPAPI.dll")
HKEY SetupDiCreateDeviceInterfaceRegKeyA(void* DeviceInfoSet, SP_DEVICE_INTERFACE_DATA* DeviceInterfaceData, uint Reserved, uint samDesired, void* InfHandle, const(char)* InfSectionName);

@DllImport("SETUPAPI.dll")
HKEY SetupDiCreateDeviceInterfaceRegKeyW(void* DeviceInfoSet, SP_DEVICE_INTERFACE_DATA* DeviceInterfaceData, uint Reserved, uint samDesired, void* InfHandle, const(wchar)* InfSectionName);

@DllImport("SETUPAPI.dll")
HKEY SetupDiOpenDeviceInterfaceRegKey(void* DeviceInfoSet, SP_DEVICE_INTERFACE_DATA* DeviceInterfaceData, uint Reserved, uint samDesired);

@DllImport("SETUPAPI.dll")
BOOL SetupDiDeleteDeviceInterfaceRegKey(void* DeviceInfoSet, SP_DEVICE_INTERFACE_DATA* DeviceInterfaceData, uint Reserved);

@DllImport("SETUPAPI.dll")
HKEY SetupDiCreateDevRegKeyA(void* DeviceInfoSet, SP_DEVINFO_DATA* DeviceInfoData, uint Scope, uint HwProfile, uint KeyType, void* InfHandle, const(char)* InfSectionName);

@DllImport("SETUPAPI.dll")
HKEY SetupDiCreateDevRegKeyW(void* DeviceInfoSet, SP_DEVINFO_DATA* DeviceInfoData, uint Scope, uint HwProfile, uint KeyType, void* InfHandle, const(wchar)* InfSectionName);

@DllImport("SETUPAPI.dll")
HKEY SetupDiOpenDevRegKey(void* DeviceInfoSet, SP_DEVINFO_DATA* DeviceInfoData, uint Scope, uint HwProfile, uint KeyType, uint samDesired);

@DllImport("SETUPAPI.dll")
BOOL SetupDiDeleteDevRegKey(void* DeviceInfoSet, SP_DEVINFO_DATA* DeviceInfoData, uint Scope, uint HwProfile, uint KeyType);

@DllImport("SETUPAPI.dll")
BOOL SetupDiGetHwProfileList(char* HwProfileList, uint HwProfileListSize, uint* RequiredSize, uint* CurrentlyActiveIndex);

@DllImport("SETUPAPI.dll")
BOOL SetupDiGetHwProfileListExA(char* HwProfileList, uint HwProfileListSize, uint* RequiredSize, uint* CurrentlyActiveIndex, const(char)* MachineName, void* Reserved);

@DllImport("SETUPAPI.dll")
BOOL SetupDiGetHwProfileListExW(char* HwProfileList, uint HwProfileListSize, uint* RequiredSize, uint* CurrentlyActiveIndex, const(wchar)* MachineName, void* Reserved);

@DllImport("SETUPAPI.dll")
BOOL SetupDiGetDevicePropertyKeys(void* DeviceInfoSet, SP_DEVINFO_DATA* DeviceInfoData, char* PropertyKeyArray, uint PropertyKeyCount, uint* RequiredPropertyKeyCount, uint Flags);

@DllImport("SETUPAPI.dll")
BOOL SetupDiGetDevicePropertyW(void* DeviceInfoSet, SP_DEVINFO_DATA* DeviceInfoData, const(DEVPROPKEY)* PropertyKey, uint* PropertyType, char* PropertyBuffer, uint PropertyBufferSize, uint* RequiredSize, uint Flags);

@DllImport("SETUPAPI.dll")
BOOL SetupDiSetDevicePropertyW(void* DeviceInfoSet, SP_DEVINFO_DATA* DeviceInfoData, const(DEVPROPKEY)* PropertyKey, uint PropertyType, char* PropertyBuffer, uint PropertyBufferSize, uint Flags);

@DllImport("SETUPAPI.dll")
BOOL SetupDiGetDeviceInterfacePropertyKeys(void* DeviceInfoSet, SP_DEVICE_INTERFACE_DATA* DeviceInterfaceData, char* PropertyKeyArray, uint PropertyKeyCount, uint* RequiredPropertyKeyCount, uint Flags);

@DllImport("SETUPAPI.dll")
BOOL SetupDiGetDeviceInterfacePropertyW(void* DeviceInfoSet, SP_DEVICE_INTERFACE_DATA* DeviceInterfaceData, const(DEVPROPKEY)* PropertyKey, uint* PropertyType, char* PropertyBuffer, uint PropertyBufferSize, uint* RequiredSize, uint Flags);

@DllImport("SETUPAPI.dll")
BOOL SetupDiSetDeviceInterfacePropertyW(void* DeviceInfoSet, SP_DEVICE_INTERFACE_DATA* DeviceInterfaceData, const(DEVPROPKEY)* PropertyKey, uint PropertyType, char* PropertyBuffer, uint PropertyBufferSize, uint Flags);

@DllImport("SETUPAPI.dll")
BOOL SetupDiGetClassPropertyKeys(const(Guid)* ClassGuid, char* PropertyKeyArray, uint PropertyKeyCount, uint* RequiredPropertyKeyCount, uint Flags);

@DllImport("SETUPAPI.dll")
BOOL SetupDiGetClassPropertyKeysExW(const(Guid)* ClassGuid, char* PropertyKeyArray, uint PropertyKeyCount, uint* RequiredPropertyKeyCount, uint Flags, const(wchar)* MachineName, void* Reserved);

@DllImport("SETUPAPI.dll")
BOOL SetupDiGetClassPropertyW(const(Guid)* ClassGuid, const(DEVPROPKEY)* PropertyKey, uint* PropertyType, char* PropertyBuffer, uint PropertyBufferSize, uint* RequiredSize, uint Flags);

@DllImport("SETUPAPI.dll")
BOOL SetupDiGetClassPropertyExW(const(Guid)* ClassGuid, const(DEVPROPKEY)* PropertyKey, uint* PropertyType, char* PropertyBuffer, uint PropertyBufferSize, uint* RequiredSize, uint Flags, const(wchar)* MachineName, void* Reserved);

@DllImport("SETUPAPI.dll")
BOOL SetupDiSetClassPropertyW(const(Guid)* ClassGuid, const(DEVPROPKEY)* PropertyKey, uint PropertyType, char* PropertyBuffer, uint PropertyBufferSize, uint Flags);

@DllImport("SETUPAPI.dll")
BOOL SetupDiSetClassPropertyExW(const(Guid)* ClassGuid, const(DEVPROPKEY)* PropertyKey, uint PropertyType, char* PropertyBuffer, uint PropertyBufferSize, uint Flags, const(wchar)* MachineName, void* Reserved);

@DllImport("SETUPAPI.dll")
BOOL SetupDiGetDeviceRegistryPropertyA(void* DeviceInfoSet, SP_DEVINFO_DATA* DeviceInfoData, uint Property, uint* PropertyRegDataType, char* PropertyBuffer, uint PropertyBufferSize, uint* RequiredSize);

@DllImport("SETUPAPI.dll")
BOOL SetupDiGetDeviceRegistryPropertyW(void* DeviceInfoSet, SP_DEVINFO_DATA* DeviceInfoData, uint Property, uint* PropertyRegDataType, char* PropertyBuffer, uint PropertyBufferSize, uint* RequiredSize);

@DllImport("SETUPAPI.dll")
BOOL SetupDiGetClassRegistryPropertyA(const(Guid)* ClassGuid, uint Property, uint* PropertyRegDataType, char* PropertyBuffer, uint PropertyBufferSize, uint* RequiredSize, const(char)* MachineName, void* Reserved);

@DllImport("SETUPAPI.dll")
BOOL SetupDiGetClassRegistryPropertyW(const(Guid)* ClassGuid, uint Property, uint* PropertyRegDataType, char* PropertyBuffer, uint PropertyBufferSize, uint* RequiredSize, const(wchar)* MachineName, void* Reserved);

@DllImport("SETUPAPI.dll")
BOOL SetupDiSetDeviceRegistryPropertyA(void* DeviceInfoSet, SP_DEVINFO_DATA* DeviceInfoData, uint Property, char* PropertyBuffer, uint PropertyBufferSize);

@DllImport("SETUPAPI.dll")
BOOL SetupDiSetDeviceRegistryPropertyW(void* DeviceInfoSet, SP_DEVINFO_DATA* DeviceInfoData, uint Property, char* PropertyBuffer, uint PropertyBufferSize);

@DllImport("SETUPAPI.dll")
BOOL SetupDiSetClassRegistryPropertyA(const(Guid)* ClassGuid, uint Property, char* PropertyBuffer, uint PropertyBufferSize, const(char)* MachineName, void* Reserved);

@DllImport("SETUPAPI.dll")
BOOL SetupDiSetClassRegistryPropertyW(const(Guid)* ClassGuid, uint Property, char* PropertyBuffer, uint PropertyBufferSize, const(wchar)* MachineName, void* Reserved);

@DllImport("SETUPAPI.dll")
BOOL SetupDiGetDeviceInstallParamsA(void* DeviceInfoSet, SP_DEVINFO_DATA* DeviceInfoData, SP_DEVINSTALL_PARAMS_A* DeviceInstallParams);

@DllImport("SETUPAPI.dll")
BOOL SetupDiGetDeviceInstallParamsW(void* DeviceInfoSet, SP_DEVINFO_DATA* DeviceInfoData, SP_DEVINSTALL_PARAMS_W* DeviceInstallParams);

@DllImport("SETUPAPI.dll")
BOOL SetupDiGetClassInstallParamsA(void* DeviceInfoSet, SP_DEVINFO_DATA* DeviceInfoData, char* ClassInstallParams, uint ClassInstallParamsSize, uint* RequiredSize);

@DllImport("SETUPAPI.dll")
BOOL SetupDiGetClassInstallParamsW(void* DeviceInfoSet, SP_DEVINFO_DATA* DeviceInfoData, char* ClassInstallParams, uint ClassInstallParamsSize, uint* RequiredSize);

@DllImport("SETUPAPI.dll")
BOOL SetupDiSetDeviceInstallParamsA(void* DeviceInfoSet, SP_DEVINFO_DATA* DeviceInfoData, SP_DEVINSTALL_PARAMS_A* DeviceInstallParams);

@DllImport("SETUPAPI.dll")
BOOL SetupDiSetDeviceInstallParamsW(void* DeviceInfoSet, SP_DEVINFO_DATA* DeviceInfoData, SP_DEVINSTALL_PARAMS_W* DeviceInstallParams);

@DllImport("SETUPAPI.dll")
BOOL SetupDiSetClassInstallParamsA(void* DeviceInfoSet, SP_DEVINFO_DATA* DeviceInfoData, char* ClassInstallParams, uint ClassInstallParamsSize);

@DllImport("SETUPAPI.dll")
BOOL SetupDiSetClassInstallParamsW(void* DeviceInfoSet, SP_DEVINFO_DATA* DeviceInfoData, char* ClassInstallParams, uint ClassInstallParamsSize);

@DllImport("SETUPAPI.dll")
BOOL SetupDiGetDriverInstallParamsA(void* DeviceInfoSet, SP_DEVINFO_DATA* DeviceInfoData, SP_DRVINFO_DATA_V2_A* DriverInfoData, SP_DRVINSTALL_PARAMS* DriverInstallParams);

@DllImport("SETUPAPI.dll")
BOOL SetupDiGetDriverInstallParamsW(void* DeviceInfoSet, SP_DEVINFO_DATA* DeviceInfoData, SP_DRVINFO_DATA_V2_W* DriverInfoData, SP_DRVINSTALL_PARAMS* DriverInstallParams);

@DllImport("SETUPAPI.dll")
BOOL SetupDiSetDriverInstallParamsA(void* DeviceInfoSet, SP_DEVINFO_DATA* DeviceInfoData, SP_DRVINFO_DATA_V2_A* DriverInfoData, SP_DRVINSTALL_PARAMS* DriverInstallParams);

@DllImport("SETUPAPI.dll")
BOOL SetupDiSetDriverInstallParamsW(void* DeviceInfoSet, SP_DEVINFO_DATA* DeviceInfoData, SP_DRVINFO_DATA_V2_W* DriverInfoData, SP_DRVINSTALL_PARAMS* DriverInstallParams);

@DllImport("SETUPAPI.dll")
BOOL SetupDiLoadClassIcon(const(Guid)* ClassGuid, HICON* LargeIcon, int* MiniIconIndex);

@DllImport("SETUPAPI.dll")
BOOL SetupDiLoadDeviceIcon(void* DeviceInfoSet, SP_DEVINFO_DATA* DeviceInfoData, uint cxIcon, uint cyIcon, uint Flags, HICON* hIcon);

@DllImport("SETUPAPI.dll")
int SetupDiDrawMiniIcon(HDC hdc, RECT rc, int MiniIconIndex, uint Flags);

@DllImport("SETUPAPI.dll")
BOOL SetupDiGetClassBitmapIndex(const(Guid)* ClassGuid, int* MiniIconIndex);

@DllImport("SETUPAPI.dll")
BOOL SetupDiGetClassImageList(SP_CLASSIMAGELIST_DATA* ClassImageListData);

@DllImport("SETUPAPI.dll")
BOOL SetupDiGetClassImageListExA(SP_CLASSIMAGELIST_DATA* ClassImageListData, const(char)* MachineName, void* Reserved);

@DllImport("SETUPAPI.dll")
BOOL SetupDiGetClassImageListExW(SP_CLASSIMAGELIST_DATA* ClassImageListData, const(wchar)* MachineName, void* Reserved);

@DllImport("SETUPAPI.dll")
BOOL SetupDiGetClassImageIndex(SP_CLASSIMAGELIST_DATA* ClassImageListData, const(Guid)* ClassGuid, int* ImageIndex);

@DllImport("SETUPAPI.dll")
BOOL SetupDiDestroyClassImageList(SP_CLASSIMAGELIST_DATA* ClassImageListData);

@DllImport("SETUPAPI.dll")
BOOL SetupDiGetClassDevPropertySheetsA(void* DeviceInfoSet, SP_DEVINFO_DATA* DeviceInfoData, PROPSHEETHEADERA_V2* PropertySheetHeader, uint PropertySheetHeaderPageListSize, uint* RequiredSize, uint PropertySheetType);

@DllImport("SETUPAPI.dll")
BOOL SetupDiGetClassDevPropertySheetsW(void* DeviceInfoSet, SP_DEVINFO_DATA* DeviceInfoData, PROPSHEETHEADERW_V2* PropertySheetHeader, uint PropertySheetHeaderPageListSize, uint* RequiredSize, uint PropertySheetType);

@DllImport("SETUPAPI.dll")
BOOL SetupDiAskForOEMDisk(void* DeviceInfoSet, SP_DEVINFO_DATA* DeviceInfoData);

@DllImport("SETUPAPI.dll")
BOOL SetupDiSelectOEMDrv(HWND hwndParent, void* DeviceInfoSet, SP_DEVINFO_DATA* DeviceInfoData);

@DllImport("SETUPAPI.dll")
BOOL SetupDiClassNameFromGuidA(const(Guid)* ClassGuid, const(char)* ClassName, uint ClassNameSize, uint* RequiredSize);

@DllImport("SETUPAPI.dll")
BOOL SetupDiClassNameFromGuidW(const(Guid)* ClassGuid, const(wchar)* ClassName, uint ClassNameSize, uint* RequiredSize);

@DllImport("SETUPAPI.dll")
BOOL SetupDiClassNameFromGuidExA(const(Guid)* ClassGuid, const(char)* ClassName, uint ClassNameSize, uint* RequiredSize, const(char)* MachineName, void* Reserved);

@DllImport("SETUPAPI.dll")
BOOL SetupDiClassNameFromGuidExW(const(Guid)* ClassGuid, const(wchar)* ClassName, uint ClassNameSize, uint* RequiredSize, const(wchar)* MachineName, void* Reserved);

@DllImport("SETUPAPI.dll")
BOOL SetupDiClassGuidsFromNameA(const(char)* ClassName, char* ClassGuidList, uint ClassGuidListSize, uint* RequiredSize);

@DllImport("SETUPAPI.dll")
BOOL SetupDiClassGuidsFromNameW(const(wchar)* ClassName, char* ClassGuidList, uint ClassGuidListSize, uint* RequiredSize);

@DllImport("SETUPAPI.dll")
BOOL SetupDiClassGuidsFromNameExA(const(char)* ClassName, char* ClassGuidList, uint ClassGuidListSize, uint* RequiredSize, const(char)* MachineName, void* Reserved);

@DllImport("SETUPAPI.dll")
BOOL SetupDiClassGuidsFromNameExW(const(wchar)* ClassName, char* ClassGuidList, uint ClassGuidListSize, uint* RequiredSize, const(wchar)* MachineName, void* Reserved);

@DllImport("SETUPAPI.dll")
BOOL SetupDiGetHwProfileFriendlyNameA(uint HwProfile, const(char)* FriendlyName, uint FriendlyNameSize, uint* RequiredSize);

@DllImport("SETUPAPI.dll")
BOOL SetupDiGetHwProfileFriendlyNameW(uint HwProfile, const(wchar)* FriendlyName, uint FriendlyNameSize, uint* RequiredSize);

@DllImport("SETUPAPI.dll")
BOOL SetupDiGetHwProfileFriendlyNameExA(uint HwProfile, const(char)* FriendlyName, uint FriendlyNameSize, uint* RequiredSize, const(char)* MachineName, void* Reserved);

@DllImport("SETUPAPI.dll")
BOOL SetupDiGetHwProfileFriendlyNameExW(uint HwProfile, const(wchar)* FriendlyName, uint FriendlyNameSize, uint* RequiredSize, const(wchar)* MachineName, void* Reserved);

@DllImport("SETUPAPI.dll")
HPROPSHEETPAGE SetupDiGetWizardPage(void* DeviceInfoSet, SP_DEVINFO_DATA* DeviceInfoData, SP_INSTALLWIZARD_DATA* InstallWizardData, uint PageType, uint Flags);

@DllImport("SETUPAPI.dll")
BOOL SetupDiGetSelectedDevice(void* DeviceInfoSet, SP_DEVINFO_DATA* DeviceInfoData);

@DllImport("SETUPAPI.dll")
BOOL SetupDiSetSelectedDevice(void* DeviceInfoSet, SP_DEVINFO_DATA* DeviceInfoData);

@DllImport("SETUPAPI.dll")
BOOL SetupDiGetActualModelsSectionA(INFCONTEXT* Context, SP_ALTPLATFORM_INFO_V2* AlternatePlatformInfo, const(char)* InfSectionWithExt, uint InfSectionWithExtSize, uint* RequiredSize, void* Reserved);

@DllImport("SETUPAPI.dll")
BOOL SetupDiGetActualModelsSectionW(INFCONTEXT* Context, SP_ALTPLATFORM_INFO_V2* AlternatePlatformInfo, const(wchar)* InfSectionWithExt, uint InfSectionWithExtSize, uint* RequiredSize, void* Reserved);

@DllImport("SETUPAPI.dll")
BOOL SetupDiGetActualSectionToInstallA(void* InfHandle, const(char)* InfSectionName, const(char)* InfSectionWithExt, uint InfSectionWithExtSize, uint* RequiredSize, byte** Extension);

@DllImport("SETUPAPI.dll")
BOOL SetupDiGetActualSectionToInstallW(void* InfHandle, const(wchar)* InfSectionName, const(wchar)* InfSectionWithExt, uint InfSectionWithExtSize, uint* RequiredSize, ushort** Extension);

@DllImport("SETUPAPI.dll")
BOOL SetupDiGetActualSectionToInstallExA(void* InfHandle, const(char)* InfSectionName, SP_ALTPLATFORM_INFO_V2* AlternatePlatformInfo, const(char)* InfSectionWithExt, uint InfSectionWithExtSize, uint* RequiredSize, byte** Extension, void* Reserved);

@DllImport("SETUPAPI.dll")
BOOL SetupDiGetActualSectionToInstallExW(void* InfHandle, const(wchar)* InfSectionName, SP_ALTPLATFORM_INFO_V2* AlternatePlatformInfo, const(wchar)* InfSectionWithExt, uint InfSectionWithExtSize, uint* RequiredSize, ushort** Extension, void* Reserved);

@DllImport("SETUPAPI.dll")
BOOL SetupDiGetCustomDevicePropertyA(void* DeviceInfoSet, SP_DEVINFO_DATA* DeviceInfoData, const(char)* CustomPropertyName, uint Flags, uint* PropertyRegDataType, char* PropertyBuffer, uint PropertyBufferSize, uint* RequiredSize);

@DllImport("SETUPAPI.dll")
BOOL SetupDiGetCustomDevicePropertyW(void* DeviceInfoSet, SP_DEVINFO_DATA* DeviceInfoData, const(wchar)* CustomPropertyName, uint Flags, uint* PropertyRegDataType, char* PropertyBuffer, uint PropertyBufferSize, uint* RequiredSize);

@DllImport("SETUPAPI.dll")
uint CM_Add_Empty_Log_Conf(uint* plcLogConf, uint dnDevInst, uint Priority, uint ulFlags);

@DllImport("SETUPAPI.dll")
uint CM_Add_Empty_Log_Conf_Ex(uint* plcLogConf, uint dnDevInst, uint Priority, uint ulFlags, int hMachine);

@DllImport("SETUPAPI.dll")
uint CM_Add_IDA(uint dnDevInst, const(char)* pszID, uint ulFlags);

@DllImport("SETUPAPI.dll")
uint CM_Add_IDW(uint dnDevInst, const(wchar)* pszID, uint ulFlags);

@DllImport("SETUPAPI.dll")
uint CM_Add_ID_ExA(uint dnDevInst, const(char)* pszID, uint ulFlags, int hMachine);

@DllImport("SETUPAPI.dll")
uint CM_Add_ID_ExW(uint dnDevInst, const(wchar)* pszID, uint ulFlags, int hMachine);

@DllImport("SETUPAPI.dll")
uint CM_Add_Range(ulong ullStartValue, ulong ullEndValue, uint rlh, uint ulFlags);

@DllImport("SETUPAPI.dll")
uint CM_Add_Res_Des(uint* prdResDes, uint lcLogConf, uint ResourceID, char* ResourceData, uint ResourceLen, uint ulFlags);

@DllImport("SETUPAPI.dll")
uint CM_Add_Res_Des_Ex(uint* prdResDes, uint lcLogConf, uint ResourceID, char* ResourceData, uint ResourceLen, uint ulFlags, int hMachine);

@DllImport("SETUPAPI.dll")
uint CM_Connect_MachineA(const(char)* UNCServerName, int* phMachine);

@DllImport("SETUPAPI.dll")
uint CM_Connect_MachineW(const(wchar)* UNCServerName, int* phMachine);

@DllImport("SETUPAPI.dll")
uint CM_Create_DevNodeA(uint* pdnDevInst, byte* pDeviceID, uint dnParent, uint ulFlags);

@DllImport("SETUPAPI.dll")
uint CM_Create_DevNodeW(uint* pdnDevInst, ushort* pDeviceID, uint dnParent, uint ulFlags);

@DllImport("SETUPAPI.dll")
uint CM_Create_DevNode_ExA(uint* pdnDevInst, byte* pDeviceID, uint dnParent, uint ulFlags, int hMachine);

@DllImport("SETUPAPI.dll")
uint CM_Create_DevNode_ExW(uint* pdnDevInst, ushort* pDeviceID, uint dnParent, uint ulFlags, int hMachine);

@DllImport("SETUPAPI.dll")
uint CM_Create_Range_List(uint* prlh, uint ulFlags);

@DllImport("SETUPAPI.dll")
uint CM_Delete_Class_Key(Guid* ClassGuid, uint ulFlags);

@DllImport("SETUPAPI.dll")
uint CM_Delete_Class_Key_Ex(Guid* ClassGuid, uint ulFlags, int hMachine);

@DllImport("SETUPAPI.dll")
uint CM_Delete_DevNode_Key(uint dnDevNode, uint ulHardwareProfile, uint ulFlags);

@DllImport("SETUPAPI.dll")
uint CM_Delete_DevNode_Key_Ex(uint dnDevNode, uint ulHardwareProfile, uint ulFlags, int hMachine);

@DllImport("SETUPAPI.dll")
uint CM_Delete_Range(ulong ullStartValue, ulong ullEndValue, uint rlh, uint ulFlags);

@DllImport("SETUPAPI.dll")
uint CM_Detect_Resource_Conflict(uint dnDevInst, uint ResourceID, char* ResourceData, uint ResourceLen, int* pbConflictDetected, uint ulFlags);

@DllImport("SETUPAPI.dll")
uint CM_Detect_Resource_Conflict_Ex(uint dnDevInst, uint ResourceID, char* ResourceData, uint ResourceLen, int* pbConflictDetected, uint ulFlags, int hMachine);

@DllImport("SETUPAPI.dll")
uint CM_Disable_DevNode(uint dnDevInst, uint ulFlags);

@DllImport("SETUPAPI.dll")
uint CM_Disable_DevNode_Ex(uint dnDevInst, uint ulFlags, int hMachine);

@DllImport("SETUPAPI.dll")
uint CM_Disconnect_Machine(int hMachine);

@DllImport("SETUPAPI.dll")
uint CM_Dup_Range_List(uint rlhOld, uint rlhNew, uint ulFlags);

@DllImport("SETUPAPI.dll")
uint CM_Enable_DevNode(uint dnDevInst, uint ulFlags);

@DllImport("SETUPAPI.dll")
uint CM_Enable_DevNode_Ex(uint dnDevInst, uint ulFlags, int hMachine);

@DllImport("SETUPAPI.dll")
uint CM_Enumerate_Classes(uint ulClassIndex, Guid* ClassGuid, uint ulFlags);

@DllImport("SETUPAPI.dll")
uint CM_Enumerate_Classes_Ex(uint ulClassIndex, Guid* ClassGuid, uint ulFlags, int hMachine);

@DllImport("SETUPAPI.dll")
uint CM_Enumerate_EnumeratorsA(uint ulEnumIndex, const(char)* Buffer, uint* pulLength, uint ulFlags);

@DllImport("SETUPAPI.dll")
uint CM_Enumerate_EnumeratorsW(uint ulEnumIndex, const(wchar)* Buffer, uint* pulLength, uint ulFlags);

@DllImport("SETUPAPI.dll")
uint CM_Enumerate_Enumerators_ExA(uint ulEnumIndex, const(char)* Buffer, uint* pulLength, uint ulFlags, int hMachine);

@DllImport("SETUPAPI.dll")
uint CM_Enumerate_Enumerators_ExW(uint ulEnumIndex, const(wchar)* Buffer, uint* pulLength, uint ulFlags, int hMachine);

@DllImport("SETUPAPI.dll")
uint CM_Find_Range(ulong* pullStart, ulong ullStart, uint ulLength, ulong ullAlignment, ulong ullEnd, uint rlh, uint ulFlags);

@DllImport("SETUPAPI.dll")
uint CM_First_Range(uint rlh, ulong* pullStart, ulong* pullEnd, uint* preElement, uint ulFlags);

@DllImport("SETUPAPI.dll")
uint CM_Free_Log_Conf(uint lcLogConfToBeFreed, uint ulFlags);

@DllImport("SETUPAPI.dll")
uint CM_Free_Log_Conf_Ex(uint lcLogConfToBeFreed, uint ulFlags, int hMachine);

@DllImport("SETUPAPI.dll")
uint CM_Free_Log_Conf_Handle(uint lcLogConf);

@DllImport("SETUPAPI.dll")
uint CM_Free_Range_List(uint rlh, uint ulFlags);

@DllImport("SETUPAPI.dll")
uint CM_Free_Res_Des(uint* prdResDes, uint rdResDes, uint ulFlags);

@DllImport("SETUPAPI.dll")
uint CM_Free_Res_Des_Ex(uint* prdResDes, uint rdResDes, uint ulFlags, int hMachine);

@DllImport("SETUPAPI.dll")
uint CM_Free_Res_Des_Handle(uint rdResDes);

@DllImport("SETUPAPI.dll")
uint CM_Get_Child(uint* pdnDevInst, uint dnDevInst, uint ulFlags);

@DllImport("SETUPAPI.dll")
uint CM_Get_Child_Ex(uint* pdnDevInst, uint dnDevInst, uint ulFlags, int hMachine);

@DllImport("SETUPAPI.dll")
uint CM_Get_Class_NameA(Guid* ClassGuid, const(char)* Buffer, uint* pulLength, uint ulFlags);

@DllImport("SETUPAPI.dll")
uint CM_Get_Class_NameW(Guid* ClassGuid, const(wchar)* Buffer, uint* pulLength, uint ulFlags);

@DllImport("SETUPAPI.dll")
uint CM_Get_Class_Name_ExA(Guid* ClassGuid, const(char)* Buffer, uint* pulLength, uint ulFlags, int hMachine);

@DllImport("SETUPAPI.dll")
uint CM_Get_Class_Name_ExW(Guid* ClassGuid, const(wchar)* Buffer, uint* pulLength, uint ulFlags, int hMachine);

@DllImport("SETUPAPI.dll")
uint CM_Get_Class_Key_NameA(Guid* ClassGuid, const(char)* pszKeyName, uint* pulLength, uint ulFlags);

@DllImport("SETUPAPI.dll")
uint CM_Get_Class_Key_NameW(Guid* ClassGuid, const(wchar)* pszKeyName, uint* pulLength, uint ulFlags);

@DllImport("SETUPAPI.dll")
uint CM_Get_Class_Key_Name_ExA(Guid* ClassGuid, const(char)* pszKeyName, uint* pulLength, uint ulFlags, int hMachine);

@DllImport("SETUPAPI.dll")
uint CM_Get_Class_Key_Name_ExW(Guid* ClassGuid, const(wchar)* pszKeyName, uint* pulLength, uint ulFlags, int hMachine);

@DllImport("SETUPAPI.dll")
uint CM_Get_Depth(uint* pulDepth, uint dnDevInst, uint ulFlags);

@DllImport("SETUPAPI.dll")
uint CM_Get_Depth_Ex(uint* pulDepth, uint dnDevInst, uint ulFlags, int hMachine);

@DllImport("SETUPAPI.dll")
uint CM_Get_Device_IDA(uint dnDevInst, const(char)* Buffer, uint BufferLen, uint ulFlags);

@DllImport("SETUPAPI.dll")
uint CM_Get_Device_IDW(uint dnDevInst, const(wchar)* Buffer, uint BufferLen, uint ulFlags);

@DllImport("SETUPAPI.dll")
uint CM_Get_Device_ID_ExA(uint dnDevInst, const(char)* Buffer, uint BufferLen, uint ulFlags, int hMachine);

@DllImport("SETUPAPI.dll")
uint CM_Get_Device_ID_ExW(uint dnDevInst, const(wchar)* Buffer, uint BufferLen, uint ulFlags, int hMachine);

@DllImport("SETUPAPI.dll")
uint CM_Get_Device_ID_ListA(const(char)* pszFilter, const(char)* Buffer, uint BufferLen, uint ulFlags);

@DllImport("SETUPAPI.dll")
uint CM_Get_Device_ID_ListW(const(wchar)* pszFilter, const(wchar)* Buffer, uint BufferLen, uint ulFlags);

@DllImport("SETUPAPI.dll")
uint CM_Get_Device_ID_List_ExA(const(char)* pszFilter, const(char)* Buffer, uint BufferLen, uint ulFlags, int hMachine);

@DllImport("SETUPAPI.dll")
uint CM_Get_Device_ID_List_ExW(const(wchar)* pszFilter, const(wchar)* Buffer, uint BufferLen, uint ulFlags, int hMachine);

@DllImport("SETUPAPI.dll")
uint CM_Get_Device_ID_List_SizeA(uint* pulLen, const(char)* pszFilter, uint ulFlags);

@DllImport("SETUPAPI.dll")
uint CM_Get_Device_ID_List_SizeW(uint* pulLen, const(wchar)* pszFilter, uint ulFlags);

@DllImport("SETUPAPI.dll")
uint CM_Get_Device_ID_List_Size_ExA(uint* pulLen, const(char)* pszFilter, uint ulFlags, int hMachine);

@DllImport("SETUPAPI.dll")
uint CM_Get_Device_ID_List_Size_ExW(uint* pulLen, const(wchar)* pszFilter, uint ulFlags, int hMachine);

@DllImport("SETUPAPI.dll")
uint CM_Get_Device_ID_Size(uint* pulLen, uint dnDevInst, uint ulFlags);

@DllImport("SETUPAPI.dll")
uint CM_Get_Device_ID_Size_Ex(uint* pulLen, uint dnDevInst, uint ulFlags, int hMachine);

@DllImport("api-ms-win-devices-config-l1-1-1.dll")
uint CM_Get_DevNode_PropertyW(uint dnDevInst, const(DEVPROPKEY)* PropertyKey, uint* PropertyType, char* PropertyBuffer, uint* PropertyBufferSize, uint ulFlags);

@DllImport("CFGMGR32.dll")
uint CM_Get_DevNode_Property_ExW(uint dnDevInst, const(DEVPROPKEY)* PropertyKey, uint* PropertyType, char* PropertyBuffer, uint* PropertyBufferSize, uint ulFlags, int hMachine);

@DllImport("api-ms-win-devices-config-l1-1-1.dll")
uint CM_Get_DevNode_Property_Keys(uint dnDevInst, char* PropertyKeyArray, uint* PropertyKeyCount, uint ulFlags);

@DllImport("CFGMGR32.dll")
uint CM_Get_DevNode_Property_Keys_Ex(uint dnDevInst, char* PropertyKeyArray, uint* PropertyKeyCount, uint ulFlags, int hMachine);

@DllImport("SETUPAPI.dll")
uint CM_Get_DevNode_Registry_PropertyA(uint dnDevInst, uint ulProperty, uint* pulRegDataType, char* Buffer, uint* pulLength, uint ulFlags);

@DllImport("SETUPAPI.dll")
uint CM_Get_DevNode_Registry_PropertyW(uint dnDevInst, uint ulProperty, uint* pulRegDataType, char* Buffer, uint* pulLength, uint ulFlags);

@DllImport("SETUPAPI.dll")
uint CM_Get_DevNode_Registry_Property_ExA(uint dnDevInst, uint ulProperty, uint* pulRegDataType, char* Buffer, uint* pulLength, uint ulFlags, int hMachine);

@DllImport("SETUPAPI.dll")
uint CM_Get_DevNode_Registry_Property_ExW(uint dnDevInst, uint ulProperty, uint* pulRegDataType, char* Buffer, uint* pulLength, uint ulFlags, int hMachine);

@DllImport("SETUPAPI.dll")
uint CM_Get_DevNode_Custom_PropertyA(uint dnDevInst, const(char)* pszCustomPropertyName, uint* pulRegDataType, char* Buffer, uint* pulLength, uint ulFlags);

@DllImport("SETUPAPI.dll")
uint CM_Get_DevNode_Custom_PropertyW(uint dnDevInst, const(wchar)* pszCustomPropertyName, uint* pulRegDataType, char* Buffer, uint* pulLength, uint ulFlags);

@DllImport("SETUPAPI.dll")
uint CM_Get_DevNode_Custom_Property_ExA(uint dnDevInst, const(char)* pszCustomPropertyName, uint* pulRegDataType, char* Buffer, uint* pulLength, uint ulFlags, int hMachine);

@DllImport("SETUPAPI.dll")
uint CM_Get_DevNode_Custom_Property_ExW(uint dnDevInst, const(wchar)* pszCustomPropertyName, uint* pulRegDataType, char* Buffer, uint* pulLength, uint ulFlags, int hMachine);

@DllImport("SETUPAPI.dll")
uint CM_Get_DevNode_Status(uint* pulStatus, uint* pulProblemNumber, uint dnDevInst, uint ulFlags);

@DllImport("SETUPAPI.dll")
uint CM_Get_DevNode_Status_Ex(uint* pulStatus, uint* pulProblemNumber, uint dnDevInst, uint ulFlags, int hMachine);

@DllImport("SETUPAPI.dll")
uint CM_Get_First_Log_Conf(uint* plcLogConf, uint dnDevInst, uint ulFlags);

@DllImport("SETUPAPI.dll")
uint CM_Get_First_Log_Conf_Ex(uint* plcLogConf, uint dnDevInst, uint ulFlags, int hMachine);

@DllImport("SETUPAPI.dll")
uint CM_Get_Global_State(uint* pulState, uint ulFlags);

@DllImport("SETUPAPI.dll")
uint CM_Get_Global_State_Ex(uint* pulState, uint ulFlags, int hMachine);

@DllImport("SETUPAPI.dll")
uint CM_Get_Hardware_Profile_InfoA(uint ulIndex, HWProfileInfo_sA* pHWProfileInfo, uint ulFlags);

@DllImport("SETUPAPI.dll")
uint CM_Get_Hardware_Profile_Info_ExA(uint ulIndex, HWProfileInfo_sA* pHWProfileInfo, uint ulFlags, int hMachine);

@DllImport("SETUPAPI.dll")
uint CM_Get_Hardware_Profile_InfoW(uint ulIndex, HWProfileInfo_sW* pHWProfileInfo, uint ulFlags);

@DllImport("SETUPAPI.dll")
uint CM_Get_Hardware_Profile_Info_ExW(uint ulIndex, HWProfileInfo_sW* pHWProfileInfo, uint ulFlags, int hMachine);

@DllImport("SETUPAPI.dll")
uint CM_Get_HW_Prof_FlagsA(byte* pDeviceID, uint ulHardwareProfile, uint* pulValue, uint ulFlags);

@DllImport("SETUPAPI.dll")
uint CM_Get_HW_Prof_FlagsW(ushort* pDeviceID, uint ulHardwareProfile, uint* pulValue, uint ulFlags);

@DllImport("SETUPAPI.dll")
uint CM_Get_HW_Prof_Flags_ExA(byte* pDeviceID, uint ulHardwareProfile, uint* pulValue, uint ulFlags, int hMachine);

@DllImport("SETUPAPI.dll")
uint CM_Get_HW_Prof_Flags_ExW(ushort* pDeviceID, uint ulHardwareProfile, uint* pulValue, uint ulFlags, int hMachine);

@DllImport("SETUPAPI.dll")
uint CM_Get_Device_Interface_AliasA(const(char)* pszDeviceInterface, Guid* AliasInterfaceGuid, const(char)* pszAliasDeviceInterface, uint* pulLength, uint ulFlags);

@DllImport("SETUPAPI.dll")
uint CM_Get_Device_Interface_AliasW(const(wchar)* pszDeviceInterface, Guid* AliasInterfaceGuid, const(wchar)* pszAliasDeviceInterface, uint* pulLength, uint ulFlags);

@DllImport("SETUPAPI.dll")
uint CM_Get_Device_Interface_Alias_ExA(const(char)* pszDeviceInterface, Guid* AliasInterfaceGuid, const(char)* pszAliasDeviceInterface, uint* pulLength, uint ulFlags, int hMachine);

@DllImport("SETUPAPI.dll")
uint CM_Get_Device_Interface_Alias_ExW(const(wchar)* pszDeviceInterface, Guid* AliasInterfaceGuid, const(wchar)* pszAliasDeviceInterface, uint* pulLength, uint ulFlags, int hMachine);

@DllImport("SETUPAPI.dll")
uint CM_Get_Device_Interface_ListA(Guid* InterfaceClassGuid, byte* pDeviceID, const(char)* Buffer, uint BufferLen, uint ulFlags);

@DllImport("SETUPAPI.dll")
uint CM_Get_Device_Interface_ListW(Guid* InterfaceClassGuid, ushort* pDeviceID, const(wchar)* Buffer, uint BufferLen, uint ulFlags);

@DllImport("SETUPAPI.dll")
uint CM_Get_Device_Interface_List_ExA(Guid* InterfaceClassGuid, byte* pDeviceID, const(char)* Buffer, uint BufferLen, uint ulFlags, int hMachine);

@DllImport("SETUPAPI.dll")
uint CM_Get_Device_Interface_List_ExW(Guid* InterfaceClassGuid, ushort* pDeviceID, const(wchar)* Buffer, uint BufferLen, uint ulFlags, int hMachine);

@DllImport("SETUPAPI.dll")
uint CM_Get_Device_Interface_List_SizeA(uint* pulLen, Guid* InterfaceClassGuid, byte* pDeviceID, uint ulFlags);

@DllImport("SETUPAPI.dll")
uint CM_Get_Device_Interface_List_SizeW(uint* pulLen, Guid* InterfaceClassGuid, ushort* pDeviceID, uint ulFlags);

@DllImport("SETUPAPI.dll")
uint CM_Get_Device_Interface_List_Size_ExA(uint* pulLen, Guid* InterfaceClassGuid, byte* pDeviceID, uint ulFlags, int hMachine);

@DllImport("SETUPAPI.dll")
uint CM_Get_Device_Interface_List_Size_ExW(uint* pulLen, Guid* InterfaceClassGuid, ushort* pDeviceID, uint ulFlags, int hMachine);

@DllImport("api-ms-win-devices-config-l1-1-1.dll")
uint CM_Get_Device_Interface_PropertyW(const(wchar)* pszDeviceInterface, const(DEVPROPKEY)* PropertyKey, uint* PropertyType, char* PropertyBuffer, uint* PropertyBufferSize, uint ulFlags);

@DllImport("CFGMGR32.dll")
uint CM_Get_Device_Interface_Property_ExW(const(wchar)* pszDeviceInterface, const(DEVPROPKEY)* PropertyKey, uint* PropertyType, char* PropertyBuffer, uint* PropertyBufferSize, uint ulFlags, int hMachine);

@DllImport("api-ms-win-devices-config-l1-1-1.dll")
uint CM_Get_Device_Interface_Property_KeysW(const(wchar)* pszDeviceInterface, char* PropertyKeyArray, uint* PropertyKeyCount, uint ulFlags);

@DllImport("CFGMGR32.dll")
uint CM_Get_Device_Interface_Property_Keys_ExW(const(wchar)* pszDeviceInterface, char* PropertyKeyArray, uint* PropertyKeyCount, uint ulFlags, int hMachine);

@DllImport("SETUPAPI.dll")
uint CM_Get_Log_Conf_Priority(uint lcLogConf, uint* pPriority, uint ulFlags);

@DllImport("SETUPAPI.dll")
uint CM_Get_Log_Conf_Priority_Ex(uint lcLogConf, uint* pPriority, uint ulFlags, int hMachine);

@DllImport("SETUPAPI.dll")
uint CM_Get_Next_Log_Conf(uint* plcLogConf, uint lcLogConf, uint ulFlags);

@DllImport("SETUPAPI.dll")
uint CM_Get_Next_Log_Conf_Ex(uint* plcLogConf, uint lcLogConf, uint ulFlags, int hMachine);

@DllImport("SETUPAPI.dll")
uint CM_Get_Parent(uint* pdnDevInst, uint dnDevInst, uint ulFlags);

@DllImport("SETUPAPI.dll")
uint CM_Get_Parent_Ex(uint* pdnDevInst, uint dnDevInst, uint ulFlags, int hMachine);

@DllImport("SETUPAPI.dll")
uint CM_Get_Res_Des_Data(uint rdResDes, char* Buffer, uint BufferLen, uint ulFlags);

@DllImport("SETUPAPI.dll")
uint CM_Get_Res_Des_Data_Ex(uint rdResDes, char* Buffer, uint BufferLen, uint ulFlags, int hMachine);

@DllImport("SETUPAPI.dll")
uint CM_Get_Res_Des_Data_Size(uint* pulSize, uint rdResDes, uint ulFlags);

@DllImport("SETUPAPI.dll")
uint CM_Get_Res_Des_Data_Size_Ex(uint* pulSize, uint rdResDes, uint ulFlags, int hMachine);

@DllImport("SETUPAPI.dll")
uint CM_Get_Sibling(uint* pdnDevInst, uint dnDevInst, uint ulFlags);

@DllImport("SETUPAPI.dll")
uint CM_Get_Sibling_Ex(uint* pdnDevInst, uint dnDevInst, uint ulFlags, int hMachine);

@DllImport("SETUPAPI.dll")
ushort CM_Get_Version();

@DllImport("SETUPAPI.dll")
ushort CM_Get_Version_Ex(int hMachine);

@DllImport("SETUPAPI.dll")
BOOL CM_Is_Version_Available(ushort wVersion);

@DllImport("SETUPAPI.dll")
BOOL CM_Is_Version_Available_Ex(ushort wVersion, int hMachine);

@DllImport("SETUPAPI.dll")
uint CM_Intersect_Range_List(uint rlhOld1, uint rlhOld2, uint rlhNew, uint ulFlags);

@DllImport("SETUPAPI.dll")
uint CM_Invert_Range_List(uint rlhOld, uint rlhNew, ulong ullMaxValue, uint ulFlags);

@DllImport("SETUPAPI.dll")
uint CM_Locate_DevNodeA(uint* pdnDevInst, byte* pDeviceID, uint ulFlags);

@DllImport("SETUPAPI.dll")
uint CM_Locate_DevNodeW(uint* pdnDevInst, ushort* pDeviceID, uint ulFlags);

@DllImport("SETUPAPI.dll")
uint CM_Locate_DevNode_ExA(uint* pdnDevInst, byte* pDeviceID, uint ulFlags, int hMachine);

@DllImport("SETUPAPI.dll")
uint CM_Locate_DevNode_ExW(uint* pdnDevInst, ushort* pDeviceID, uint ulFlags, int hMachine);

@DllImport("SETUPAPI.dll")
uint CM_Merge_Range_List(uint rlhOld1, uint rlhOld2, uint rlhNew, uint ulFlags);

@DllImport("SETUPAPI.dll")
uint CM_Modify_Res_Des(uint* prdResDes, uint rdResDes, uint ResourceID, char* ResourceData, uint ResourceLen, uint ulFlags);

@DllImport("SETUPAPI.dll")
uint CM_Modify_Res_Des_Ex(uint* prdResDes, uint rdResDes, uint ResourceID, char* ResourceData, uint ResourceLen, uint ulFlags, int hMachine);

@DllImport("SETUPAPI.dll")
uint CM_Move_DevNode(uint dnFromDevInst, uint dnToDevInst, uint ulFlags);

@DllImport("SETUPAPI.dll")
uint CM_Move_DevNode_Ex(uint dnFromDevInst, uint dnToDevInst, uint ulFlags, int hMachine);

@DllImport("SETUPAPI.dll")
uint CM_Next_Range(uint* preElement, ulong* pullStart, ulong* pullEnd, uint ulFlags);

@DllImport("SETUPAPI.dll")
uint CM_Get_Next_Res_Des(uint* prdResDes, uint rdResDes, uint ForResource, uint* pResourceID, uint ulFlags);

@DllImport("SETUPAPI.dll")
uint CM_Get_Next_Res_Des_Ex(uint* prdResDes, uint rdResDes, uint ForResource, uint* pResourceID, uint ulFlags, int hMachine);

@DllImport("SETUPAPI.dll")
uint CM_Open_Class_KeyA(Guid* ClassGuid, const(char)* pszClassName, uint samDesired, uint Disposition, HKEY* phkClass, uint ulFlags);

@DllImport("SETUPAPI.dll")
uint CM_Open_Class_KeyW(Guid* ClassGuid, const(wchar)* pszClassName, uint samDesired, uint Disposition, HKEY* phkClass, uint ulFlags);

@DllImport("SETUPAPI.dll")
uint CM_Open_Class_Key_ExA(Guid* ClassGuid, const(char)* pszClassName, uint samDesired, uint Disposition, HKEY* phkClass, uint ulFlags, int hMachine);

@DllImport("SETUPAPI.dll")
uint CM_Open_Class_Key_ExW(Guid* ClassGuid, const(wchar)* pszClassName, uint samDesired, uint Disposition, HKEY* phkClass, uint ulFlags, int hMachine);

@DllImport("SETUPAPI.dll")
uint CM_Open_DevNode_Key(uint dnDevNode, uint samDesired, uint ulHardwareProfile, uint Disposition, HKEY* phkDevice, uint ulFlags);

@DllImport("SETUPAPI.dll")
uint CM_Open_DevNode_Key_Ex(uint dnDevNode, uint samDesired, uint ulHardwareProfile, uint Disposition, HKEY* phkDevice, uint ulFlags, int hMachine);

@DllImport("SETUPAPI.dll")
uint CM_Open_Device_Interface_KeyA(const(char)* pszDeviceInterface, uint samDesired, uint Disposition, HKEY* phkDeviceInterface, uint ulFlags);

@DllImport("SETUPAPI.dll")
uint CM_Open_Device_Interface_KeyW(const(wchar)* pszDeviceInterface, uint samDesired, uint Disposition, HKEY* phkDeviceInterface, uint ulFlags);

@DllImport("SETUPAPI.dll")
uint CM_Open_Device_Interface_Key_ExA(const(char)* pszDeviceInterface, uint samDesired, uint Disposition, HKEY* phkDeviceInterface, uint ulFlags, int hMachine);

@DllImport("SETUPAPI.dll")
uint CM_Open_Device_Interface_Key_ExW(const(wchar)* pszDeviceInterface, uint samDesired, uint Disposition, HKEY* phkDeviceInterface, uint ulFlags, int hMachine);

@DllImport("SETUPAPI.dll")
uint CM_Delete_Device_Interface_KeyA(const(char)* pszDeviceInterface, uint ulFlags);

@DllImport("SETUPAPI.dll")
uint CM_Delete_Device_Interface_KeyW(const(wchar)* pszDeviceInterface, uint ulFlags);

@DllImport("SETUPAPI.dll")
uint CM_Delete_Device_Interface_Key_ExA(const(char)* pszDeviceInterface, uint ulFlags, int hMachine);

@DllImport("SETUPAPI.dll")
uint CM_Delete_Device_Interface_Key_ExW(const(wchar)* pszDeviceInterface, uint ulFlags, int hMachine);

@DllImport("SETUPAPI.dll")
uint CM_Query_Arbitrator_Free_Data(char* pData, uint DataLen, uint dnDevInst, uint ResourceID, uint ulFlags);

@DllImport("SETUPAPI.dll")
uint CM_Query_Arbitrator_Free_Data_Ex(char* pData, uint DataLen, uint dnDevInst, uint ResourceID, uint ulFlags, int hMachine);

@DllImport("SETUPAPI.dll")
uint CM_Query_Arbitrator_Free_Size(uint* pulSize, uint dnDevInst, uint ResourceID, uint ulFlags);

@DllImport("SETUPAPI.dll")
uint CM_Query_Arbitrator_Free_Size_Ex(uint* pulSize, uint dnDevInst, uint ResourceID, uint ulFlags, int hMachine);

@DllImport("SETUPAPI.dll")
uint CM_Query_Remove_SubTree(uint dnAncestor, uint ulFlags);

@DllImport("SETUPAPI.dll")
uint CM_Query_Remove_SubTree_Ex(uint dnAncestor, uint ulFlags, int hMachine);

@DllImport("SETUPAPI.dll")
uint CM_Query_And_Remove_SubTreeA(uint dnAncestor, PNP_VETO_TYPE* pVetoType, const(char)* pszVetoName, uint ulNameLength, uint ulFlags);

@DllImport("SETUPAPI.dll")
uint CM_Query_And_Remove_SubTreeW(uint dnAncestor, PNP_VETO_TYPE* pVetoType, const(wchar)* pszVetoName, uint ulNameLength, uint ulFlags);

@DllImport("SETUPAPI.dll")
uint CM_Query_And_Remove_SubTree_ExA(uint dnAncestor, PNP_VETO_TYPE* pVetoType, const(char)* pszVetoName, uint ulNameLength, uint ulFlags, int hMachine);

@DllImport("SETUPAPI.dll")
uint CM_Query_And_Remove_SubTree_ExW(uint dnAncestor, PNP_VETO_TYPE* pVetoType, const(wchar)* pszVetoName, uint ulNameLength, uint ulFlags, int hMachine);

@DllImport("SETUPAPI.dll")
uint CM_Request_Device_EjectA(uint dnDevInst, PNP_VETO_TYPE* pVetoType, const(char)* pszVetoName, uint ulNameLength, uint ulFlags);

@DllImport("SETUPAPI.dll")
uint CM_Request_Device_Eject_ExA(uint dnDevInst, PNP_VETO_TYPE* pVetoType, const(char)* pszVetoName, uint ulNameLength, uint ulFlags, int hMachine);

@DllImport("SETUPAPI.dll")
uint CM_Request_Device_EjectW(uint dnDevInst, PNP_VETO_TYPE* pVetoType, const(wchar)* pszVetoName, uint ulNameLength, uint ulFlags);

@DllImport("SETUPAPI.dll")
uint CM_Request_Device_Eject_ExW(uint dnDevInst, PNP_VETO_TYPE* pVetoType, const(wchar)* pszVetoName, uint ulNameLength, uint ulFlags, int hMachine);

@DllImport("SETUPAPI.dll")
uint CM_Reenumerate_DevNode(uint dnDevInst, uint ulFlags);

@DllImport("SETUPAPI.dll")
uint CM_Reenumerate_DevNode_Ex(uint dnDevInst, uint ulFlags, int hMachine);

@DllImport("SETUPAPI.dll")
uint CM_Register_Device_InterfaceA(uint dnDevInst, Guid* InterfaceClassGuid, const(char)* pszReference, const(char)* pszDeviceInterface, uint* pulLength, uint ulFlags);

@DllImport("SETUPAPI.dll")
uint CM_Register_Device_InterfaceW(uint dnDevInst, Guid* InterfaceClassGuid, const(wchar)* pszReference, const(wchar)* pszDeviceInterface, uint* pulLength, uint ulFlags);

@DllImport("SETUPAPI.dll")
uint CM_Register_Device_Interface_ExA(uint dnDevInst, Guid* InterfaceClassGuid, const(char)* pszReference, const(char)* pszDeviceInterface, uint* pulLength, uint ulFlags, int hMachine);

@DllImport("SETUPAPI.dll")
uint CM_Register_Device_Interface_ExW(uint dnDevInst, Guid* InterfaceClassGuid, const(wchar)* pszReference, const(wchar)* pszDeviceInterface, uint* pulLength, uint ulFlags, int hMachine);

@DllImport("SETUPAPI.dll")
uint CM_Set_DevNode_Problem_Ex(uint dnDevInst, uint ulProblem, uint ulFlags, int hMachine);

@DllImport("SETUPAPI.dll")
uint CM_Set_DevNode_Problem(uint dnDevInst, uint ulProblem, uint ulFlags);

@DllImport("SETUPAPI.dll")
uint CM_Unregister_Device_InterfaceA(const(char)* pszDeviceInterface, uint ulFlags);

@DllImport("SETUPAPI.dll")
uint CM_Unregister_Device_InterfaceW(const(wchar)* pszDeviceInterface, uint ulFlags);

@DllImport("SETUPAPI.dll")
uint CM_Unregister_Device_Interface_ExA(const(char)* pszDeviceInterface, uint ulFlags, int hMachine);

@DllImport("SETUPAPI.dll")
uint CM_Unregister_Device_Interface_ExW(const(wchar)* pszDeviceInterface, uint ulFlags, int hMachine);

@DllImport("SETUPAPI.dll")
uint CM_Register_Device_Driver(uint dnDevInst, uint ulFlags);

@DllImport("SETUPAPI.dll")
uint CM_Register_Device_Driver_Ex(uint dnDevInst, uint ulFlags, int hMachine);

@DllImport("SETUPAPI.dll")
uint CM_Remove_SubTree(uint dnAncestor, uint ulFlags);

@DllImport("SETUPAPI.dll")
uint CM_Remove_SubTree_Ex(uint dnAncestor, uint ulFlags, int hMachine);

@DllImport("api-ms-win-devices-config-l1-1-1.dll")
uint CM_Set_DevNode_PropertyW(uint dnDevInst, const(DEVPROPKEY)* PropertyKey, uint PropertyType, char* PropertyBuffer, uint PropertyBufferSize, uint ulFlags);

@DllImport("CFGMGR32.dll")
uint CM_Set_DevNode_Property_ExW(uint dnDevInst, const(DEVPROPKEY)* PropertyKey, uint PropertyType, char* PropertyBuffer, uint PropertyBufferSize, uint ulFlags, int hMachine);

@DllImport("SETUPAPI.dll")
uint CM_Set_DevNode_Registry_PropertyA(uint dnDevInst, uint ulProperty, char* Buffer, uint ulLength, uint ulFlags);

@DllImport("SETUPAPI.dll")
uint CM_Set_DevNode_Registry_PropertyW(uint dnDevInst, uint ulProperty, char* Buffer, uint ulLength, uint ulFlags);

@DllImport("SETUPAPI.dll")
uint CM_Set_DevNode_Registry_Property_ExA(uint dnDevInst, uint ulProperty, char* Buffer, uint ulLength, uint ulFlags, int hMachine);

@DllImport("SETUPAPI.dll")
uint CM_Set_DevNode_Registry_Property_ExW(uint dnDevInst, uint ulProperty, char* Buffer, uint ulLength, uint ulFlags, int hMachine);

@DllImport("api-ms-win-devices-config-l1-1-1.dll")
uint CM_Set_Device_Interface_PropertyW(const(wchar)* pszDeviceInterface, const(DEVPROPKEY)* PropertyKey, uint PropertyType, char* PropertyBuffer, uint PropertyBufferSize, uint ulFlags);

@DllImport("CFGMGR32.dll")
uint CM_Set_Device_Interface_Property_ExW(const(wchar)* pszDeviceInterface, const(DEVPROPKEY)* PropertyKey, uint PropertyType, char* PropertyBuffer, uint PropertyBufferSize, uint ulFlags, int hMachine);

@DllImport("SETUPAPI.dll")
uint CM_Is_Dock_Station_Present(int* pbPresent);

@DllImport("SETUPAPI.dll")
uint CM_Is_Dock_Station_Present_Ex(int* pbPresent, int hMachine);

@DllImport("SETUPAPI.dll")
uint CM_Request_Eject_PC();

@DllImport("SETUPAPI.dll")
uint CM_Request_Eject_PC_Ex(int hMachine);

@DllImport("SETUPAPI.dll")
uint CM_Set_HW_Prof_FlagsA(byte* pDeviceID, uint ulConfig, uint ulValue, uint ulFlags);

@DllImport("SETUPAPI.dll")
uint CM_Set_HW_Prof_FlagsW(ushort* pDeviceID, uint ulConfig, uint ulValue, uint ulFlags);

@DllImport("SETUPAPI.dll")
uint CM_Set_HW_Prof_Flags_ExA(byte* pDeviceID, uint ulConfig, uint ulValue, uint ulFlags, int hMachine);

@DllImport("SETUPAPI.dll")
uint CM_Set_HW_Prof_Flags_ExW(ushort* pDeviceID, uint ulConfig, uint ulValue, uint ulFlags, int hMachine);

@DllImport("SETUPAPI.dll")
uint CM_Setup_DevNode(uint dnDevInst, uint ulFlags);

@DllImport("SETUPAPI.dll")
uint CM_Setup_DevNode_Ex(uint dnDevInst, uint ulFlags, int hMachine);

@DllImport("SETUPAPI.dll")
uint CM_Test_Range_Available(ulong ullStartValue, ulong ullEndValue, uint rlh, uint ulFlags);

@DllImport("SETUPAPI.dll")
uint CM_Uninstall_DevNode(uint dnDevInst, uint ulFlags);

@DllImport("SETUPAPI.dll")
uint CM_Uninstall_DevNode_Ex(uint dnDevInst, uint ulFlags, int hMachine);

@DllImport("SETUPAPI.dll")
uint CM_Run_Detection(uint ulFlags);

@DllImport("SETUPAPI.dll")
uint CM_Run_Detection_Ex(uint ulFlags, int hMachine);

@DllImport("SETUPAPI.dll")
uint CM_Set_HW_Prof(uint ulHardwareProfile, uint ulFlags);

@DllImport("SETUPAPI.dll")
uint CM_Set_HW_Prof_Ex(uint ulHardwareProfile, uint ulFlags, int hMachine);

@DllImport("SETUPAPI.dll")
uint CM_Query_Resource_Conflict_List(uint* pclConflictList, uint dnDevInst, uint ResourceID, char* ResourceData, uint ResourceLen, uint ulFlags, int hMachine);

@DllImport("SETUPAPI.dll")
uint CM_Free_Resource_Conflict_Handle(uint clConflictList);

@DllImport("SETUPAPI.dll")
uint CM_Get_Resource_Conflict_Count(uint clConflictList, uint* pulCount);

@DllImport("SETUPAPI.dll")
uint CM_Get_Resource_Conflict_DetailsA(uint clConflictList, uint ulIndex, CONFLICT_DETAILS_A* pConflictDetails);

@DllImport("SETUPAPI.dll")
uint CM_Get_Resource_Conflict_DetailsW(uint clConflictList, uint ulIndex, CONFLICT_DETAILS_W* pConflictDetails);

@DllImport("api-ms-win-devices-config-l1-1-1.dll")
uint CM_Get_Class_PropertyW(Guid* ClassGUID, const(DEVPROPKEY)* PropertyKey, uint* PropertyType, char* PropertyBuffer, uint* PropertyBufferSize, uint ulFlags);

@DllImport("CFGMGR32.dll")
uint CM_Get_Class_Property_ExW(Guid* ClassGUID, const(DEVPROPKEY)* PropertyKey, uint* PropertyType, char* PropertyBuffer, uint* PropertyBufferSize, uint ulFlags, int hMachine);

@DllImport("api-ms-win-devices-config-l1-1-1.dll")
uint CM_Get_Class_Property_Keys(Guid* ClassGUID, char* PropertyKeyArray, uint* PropertyKeyCount, uint ulFlags);

@DllImport("CFGMGR32.dll")
uint CM_Get_Class_Property_Keys_Ex(Guid* ClassGUID, char* PropertyKeyArray, uint* PropertyKeyCount, uint ulFlags, int hMachine);

@DllImport("api-ms-win-devices-config-l1-1-1.dll")
uint CM_Set_Class_PropertyW(Guid* ClassGUID, const(DEVPROPKEY)* PropertyKey, uint PropertyType, char* PropertyBuffer, uint PropertyBufferSize, uint ulFlags);

@DllImport("CFGMGR32.dll")
uint CM_Set_Class_Property_ExW(Guid* ClassGUID, const(DEVPROPKEY)* PropertyKey, uint PropertyType, char* PropertyBuffer, uint PropertyBufferSize, uint ulFlags, int hMachine);

@DllImport("SETUPAPI.dll")
uint CM_Get_Class_Registry_PropertyA(Guid* ClassGuid, uint ulProperty, uint* pulRegDataType, char* Buffer, uint* pulLength, uint ulFlags, int hMachine);

@DllImport("SETUPAPI.dll")
uint CM_Get_Class_Registry_PropertyW(Guid* ClassGuid, uint ulProperty, uint* pulRegDataType, char* Buffer, uint* pulLength, uint ulFlags, int hMachine);

@DllImport("SETUPAPI.dll")
uint CM_Set_Class_Registry_PropertyA(Guid* ClassGuid, uint ulProperty, char* Buffer, uint ulLength, uint ulFlags, int hMachine);

@DllImport("SETUPAPI.dll")
uint CM_Set_Class_Registry_PropertyW(Guid* ClassGuid, uint ulProperty, char* Buffer, uint ulLength, uint ulFlags, int hMachine);

@DllImport("SETUPAPI.dll")
uint CMP_WaitNoPendingInstallEvents(uint dwTimeout);

@DllImport("api-ms-win-devices-config-l1-1-1.dll")
uint CM_Register_Notification(CM_NOTIFY_FILTER* pFilter, void* pContext, PCM_NOTIFY_CALLBACK pCallback, HCMNOTIFICATION__** pNotifyContext);

@DllImport("api-ms-win-devices-config-l1-1-1.dll")
uint CM_Unregister_Notification(HCMNOTIFICATION__* NotifyContext);

@DllImport("api-ms-win-devices-config-l1-1-1.dll")
uint CM_MapCrToWin32Err(uint CmReturnCode, uint DefaultErr);

@DllImport("newdev.dll")
BOOL UpdateDriverForPlugAndPlayDevicesA(HWND hwndParent, const(char)* HardwareId, const(char)* FullInfPath, uint InstallFlags, int* bRebootRequired);

@DllImport("newdev.dll")
BOOL UpdateDriverForPlugAndPlayDevicesW(HWND hwndParent, const(wchar)* HardwareId, const(wchar)* FullInfPath, uint InstallFlags, int* bRebootRequired);

@DllImport("newdev.dll")
BOOL DiInstallDevice(HWND hwndParent, void* DeviceInfoSet, SP_DEVINFO_DATA* DeviceInfoData, SP_DRVINFO_DATA_V2_A* DriverInfoData, uint Flags, int* NeedReboot);

@DllImport("newdev.dll")
BOOL DiInstallDriverW(HWND hwndParent, const(wchar)* InfPath, uint Flags, int* NeedReboot);

@DllImport("newdev.dll")
BOOL DiInstallDriverA(HWND hwndParent, const(char)* InfPath, uint Flags, int* NeedReboot);

@DllImport("newdev.dll")
BOOL DiUninstallDevice(HWND hwndParent, void* DeviceInfoSet, SP_DEVINFO_DATA* DeviceInfoData, uint Flags, int* NeedReboot);

@DllImport("newdev.dll")
BOOL DiUninstallDriverW(HWND hwndParent, const(wchar)* InfPath, uint Flags, int* NeedReboot);

@DllImport("newdev.dll")
BOOL DiUninstallDriverA(HWND hwndParent, const(char)* InfPath, uint Flags, int* NeedReboot);

@DllImport("newdev.dll")
BOOL DiShowUpdateDevice(HWND hwndParent, void* DeviceInfoSet, SP_DEVINFO_DATA* DeviceInfoData, uint Flags, int* NeedReboot);

@DllImport("newdev.dll")
BOOL DiRollbackDriver(void* DeviceInfoSet, SP_DEVINFO_DATA* DeviceInfoData, HWND hwndParent, uint Flags, int* NeedReboot);

@DllImport("newdev.dll")
BOOL DiShowUpdateDriver(HWND hwndParent, const(wchar)* FilePath, uint Flags, int* NeedReboot);

