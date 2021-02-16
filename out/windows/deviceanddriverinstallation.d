module windows.deviceanddriverinstallation;

public import windows.core;
public import windows.applicationinstallationandservicing : INFCONTEXT, PSP_FILE_CALLBACK_A, SP_ALTPLATFORM_INFO_V2;
public import windows.controls : HIMAGELIST, HPROPSHEETPAGE, PROPSHEETHEADERA_V2, PROPSHEETHEADERW_V2;
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

enum : int
{
    PNP_VetoTypeUnknown          = 0x00000000,
    PNP_VetoLegacyDevice         = 0x00000001,
    PNP_VetoPendingClose         = 0x00000002,
    PNP_VetoWindowsApp           = 0x00000003,
    PNP_VetoWindowsService       = 0x00000004,
    PNP_VetoOutstandingOpen      = 0x00000005,
    PNP_VetoDevice               = 0x00000006,
    PNP_VetoDriver               = 0x00000007,
    PNP_VetoIllegalDeviceRequest = 0x00000008,
    PNP_VetoInsufficientPower    = 0x00000009,
    PNP_VetoNonDisableable       = 0x0000000a,
    PNP_VetoLegacyDriver         = 0x0000000b,
    PNP_VetoInsufficientRights   = 0x0000000c,
    PNP_VetoAlreadyRemoved       = 0x0000000d,
}
alias PNP_VETO_TYPE = int;

enum : int
{
    CM_NOTIFY_FILTER_TYPE_DEVICEINTERFACE = 0x00000000,
    CM_NOTIFY_FILTER_TYPE_DEVICEHANDLE    = 0x00000001,
    CM_NOTIFY_FILTER_TYPE_DEVICEINSTANCE  = 0x00000002,
    CM_NOTIFY_FILTER_TYPE_MAX             = 0x00000003,
}
alias CM_NOTIFY_FILTER_TYPE = int;

enum : int
{
    CM_NOTIFY_ACTION_DEVICEINTERFACEARRIVAL   = 0x00000000,
    CM_NOTIFY_ACTION_DEVICEINTERFACEREMOVAL   = 0x00000001,
    CM_NOTIFY_ACTION_DEVICEQUERYREMOVE        = 0x00000002,
    CM_NOTIFY_ACTION_DEVICEQUERYREMOVEFAILED  = 0x00000003,
    CM_NOTIFY_ACTION_DEVICEREMOVEPENDING      = 0x00000004,
    CM_NOTIFY_ACTION_DEVICEREMOVECOMPLETE     = 0x00000005,
    CM_NOTIFY_ACTION_DEVICECUSTOMEVENT        = 0x00000006,
    CM_NOTIFY_ACTION_DEVICEINSTANCEENUMERATED = 0x00000007,
    CM_NOTIFY_ACTION_DEVICEINSTANCESTARTED    = 0x00000008,
    CM_NOTIFY_ACTION_DEVICEINSTANCEREMOVED    = 0x00000009,
    CM_NOTIFY_ACTION_MAX                      = 0x0000000a,
}
alias CM_NOTIFY_ACTION = int;

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

struct SP_DEVINFO_DATA
{
align (1):
    uint   cbSize;
    GUID   ClassGuid;
    uint   DevInst;
    size_t Reserved;
}

struct SP_DEVICE_INTERFACE_DATA
{
align (1):
    uint   cbSize;
    GUID   InterfaceClassGuid;
    uint   Flags;
    size_t Reserved;
}

struct SP_DEVICE_INTERFACE_DETAIL_DATA_A
{
align (1):
    uint    cbSize;
    byte[1] DevicePath;
}

struct SP_DEVICE_INTERFACE_DETAIL_DATA_W
{
align (1):
    uint      cbSize;
    ushort[1] DevicePath;
}

struct SP_DEVINFO_LIST_DETAIL_DATA_A
{
align (1):
    uint      cbSize;
    GUID      ClassGuid;
    HANDLE    RemoteMachineHandle;
    byte[263] RemoteMachineName;
}

struct SP_DEVINFO_LIST_DETAIL_DATA_W
{
align (1):
    uint        cbSize;
    GUID        ClassGuid;
    HANDLE      RemoteMachineHandle;
    ushort[263] RemoteMachineName;
}

struct SP_DEVINSTALL_PARAMS_A
{
align (1):
    uint                cbSize;
    uint                Flags;
    uint                FlagsEx;
    HWND                hwndParent;
    PSP_FILE_CALLBACK_A InstallMsgHandler;
    void*               InstallMsgHandlerContext;
    void*               FileQueue;
    size_t              ClassInstallReserved;
    uint                Reserved;
    byte[260]           DriverPath;
}

struct SP_DEVINSTALL_PARAMS_W
{
align (1):
    uint                cbSize;
    uint                Flags;
    uint                FlagsEx;
    HWND                hwndParent;
    PSP_FILE_CALLBACK_A InstallMsgHandler;
    void*               InstallMsgHandlerContext;
    void*               FileQueue;
    size_t              ClassInstallReserved;
    uint                Reserved;
    ushort[260]         DriverPath;
}

struct SP_CLASSINSTALL_HEADER
{
align (1):
    uint cbSize;
    uint InstallFunction;
}

struct SP_ENABLECLASS_PARAMS
{
align (1):
    SP_CLASSINSTALL_HEADER ClassInstallHeader;
    GUID ClassGuid;
    uint EnableMessage;
}

struct SP_PROPCHANGE_PARAMS
{
align (1):
    SP_CLASSINSTALL_HEADER ClassInstallHeader;
    uint StateChange;
    uint Scope;
    uint HwProfile;
}

struct SP_REMOVEDEVICE_PARAMS
{
align (1):
    SP_CLASSINSTALL_HEADER ClassInstallHeader;
    uint Scope;
    uint HwProfile;
}

struct SP_UNREMOVEDEVICE_PARAMS
{
align (1):
    SP_CLASSINSTALL_HEADER ClassInstallHeader;
    uint Scope;
    uint HwProfile;
}

struct SP_SELECTDEVICE_PARAMS_A
{
    SP_CLASSINSTALL_HEADER ClassInstallHeader;
    byte[60]  Title;
    byte[256] Instructions;
    byte[30]  ListLabel;
    byte[256] SubTitle;
    ubyte[2]  Reserved;
}

struct SP_SELECTDEVICE_PARAMS_W
{
align (1):
    SP_CLASSINSTALL_HEADER ClassInstallHeader;
    ushort[60]  Title;
    ushort[256] Instructions;
    ushort[30]  ListLabel;
    ushort[256] SubTitle;
}

struct SP_DETECTDEVICE_PARAMS
{
align (1):
    SP_CLASSINSTALL_HEADER ClassInstallHeader;
    PDETECT_PROGRESS_NOTIFY DetectProgressNotify;
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

struct SP_NEWDEVICEWIZARD_DATA
{
align (1):
    SP_CLASSINSTALL_HEADER ClassInstallHeader;
    uint          Flags;
    ptrdiff_t[20] DynamicPages;
    uint          NumDynamicPages;
    HWND          hwndWizardDlg;
}

struct SP_TROUBLESHOOTER_PARAMS_A
{
    SP_CLASSINSTALL_HEADER ClassInstallHeader;
    byte[260] ChmFile;
    byte[260] HtmlTroubleShooter;
}

struct SP_TROUBLESHOOTER_PARAMS_W
{
align (1):
    SP_CLASSINSTALL_HEADER ClassInstallHeader;
    ushort[260] ChmFile;
    ushort[260] HtmlTroubleShooter;
}

struct SP_POWERMESSAGEWAKE_PARAMS_A
{
    SP_CLASSINSTALL_HEADER ClassInstallHeader;
    byte[512] PowerMessageWake;
}

struct SP_POWERMESSAGEWAKE_PARAMS_W
{
align (1):
    SP_CLASSINSTALL_HEADER ClassInstallHeader;
    ushort[512] PowerMessageWake;
}

struct SP_DRVINFO_DATA_V2_A
{
align (1):
    uint      cbSize;
    uint      DriverType;
    size_t    Reserved;
    byte[256] Description;
    byte[256] MfgName;
    byte[256] ProviderName;
    FILETIME  DriverDate;
    ulong     DriverVersion;
}

struct SP_DRVINFO_DATA_V2_W
{
align (1):
    uint        cbSize;
    uint        DriverType;
    size_t      Reserved;
    ushort[256] Description;
    ushort[256] MfgName;
    ushort[256] ProviderName;
    FILETIME    DriverDate;
    ulong       DriverVersion;
}

struct SP_DRVINFO_DATA_V1_A
{
align (1):
    uint      cbSize;
    uint      DriverType;
    size_t    Reserved;
    byte[256] Description;
    byte[256] MfgName;
    byte[256] ProviderName;
}

struct SP_DRVINFO_DATA_V1_W
{
align (1):
    uint        cbSize;
    uint        DriverType;
    size_t      Reserved;
    ushort[256] Description;
    ushort[256] MfgName;
    ushort[256] ProviderName;
}

struct SP_DRVINFO_DETAIL_DATA_A
{
align (1):
    uint      cbSize;
    FILETIME  InfDate;
    uint      CompatIDsOffset;
    uint      CompatIDsLength;
    size_t    Reserved;
    byte[256] SectionName;
    byte[260] InfFileName;
    byte[256] DrvDescription;
    byte[1]   HardwareID;
}

struct SP_DRVINFO_DETAIL_DATA_W
{
align (1):
    uint        cbSize;
    FILETIME    InfDate;
    uint        CompatIDsOffset;
    uint        CompatIDsLength;
    size_t      Reserved;
    ushort[256] SectionName;
    ushort[260] InfFileName;
    ushort[256] DrvDescription;
    ushort[1]   HardwareID;
}

struct SP_DRVINSTALL_PARAMS
{
align (1):
    uint   cbSize;
    uint   Rank;
    uint   Flags;
    size_t PrivateData;
    uint   Reserved;
}

struct COINSTALLER_CONTEXT_DATA
{
align (1):
    BOOL  PostProcessing;
    uint  InstallResult;
    void* PrivateData;
}

struct SP_CLASSIMAGELIST_DATA
{
align (1):
    uint       cbSize;
    HIMAGELIST ImageList;
    size_t     Reserved;
}

struct SP_PROPSHEETPAGE_REQUEST
{
align (1):
    uint             cbSize;
    uint             PageRequested;
    void*            DeviceInfoSet;
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

struct CONFLICT_DETAILS_A
{
    uint      CD_ulSize;
    uint      CD_ulMask;
    uint      CD_dnDevInst;
    size_t    CD_rdResDes;
    uint      CD_ulFlags;
    byte[260] CD_szDescription;
}

struct CONFLICT_DETAILS_W
{
    uint        CD_ulSize;
    uint        CD_ulMask;
    uint        CD_dnDevInst;
    size_t      CD_rdResDes;
    uint        CD_ulFlags;
    ushort[260] CD_szDescription;
}

struct MEM_RANGE
{
align (1):
    ulong MR_Align;
    uint  MR_nBytes;
    ulong MR_Min;
    ulong MR_Max;
    uint  MR_Flags;
    uint  MR_Reserved;
}

struct MEM_DES
{
align (1):
    uint  MD_Count;
    uint  MD_Type;
    ulong MD_Alloc_Base;
    ulong MD_Alloc_End;
    uint  MD_Flags;
    uint  MD_Reserved;
}

struct MEM_RESOURCE
{
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

struct IO_RANGE
{
align (1):
    ulong IOR_Align;
    uint  IOR_nPorts;
    ulong IOR_Min;
    ulong IOR_Max;
    uint  IOR_RangeFlags;
    ulong IOR_Alias;
}

struct IO_DES
{
align (1):
    uint  IOD_Count;
    uint  IOD_Type;
    ulong IOD_Alloc_Base;
    ulong IOD_Alloc_End;
    uint  IOD_DesFlags;
}

struct IO_RESOURCE
{
    IO_DES      IO_Header;
    IO_RANGE[1] IO_Data;
}

struct DMA_RANGE
{
align (1):
    uint DR_Min;
    uint DR_Max;
    uint DR_Flags;
}

struct DMA_DES
{
align (1):
    uint DD_Count;
    uint DD_Type;
    uint DD_Flags;
    uint DD_Alloc_Chan;
}

struct DMA_RESOURCE
{
    DMA_DES      DMA_Header;
    DMA_RANGE[1] DMA_Data;
}

struct IRQ_RANGE
{
align (1):
    uint IRQR_Min;
    uint IRQR_Max;
    uint IRQR_Flags;
}

struct IRQ_DES_32
{
align (1):
    uint IRQD_Count;
    uint IRQD_Type;
    uint IRQD_Flags;
    uint IRQD_Alloc_Num;
    uint IRQD_Affinity;
}

struct IRQ_DES_64
{
align (1):
    uint  IRQD_Count;
    uint  IRQD_Type;
    uint  IRQD_Flags;
    uint  IRQD_Alloc_Num;
    ulong IRQD_Affinity;
}

struct IRQ_RESOURCE_32
{
    IRQ_DES_32   IRQ_Header;
    IRQ_RANGE[1] IRQ_Data;
}

struct IRQ_RESOURCE_64
{
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

struct CS_DES
{
align (1):
    uint     CSD_SignatureLength;
    uint     CSD_LegacyDataOffset;
    uint     CSD_LegacyDataSize;
    uint     CSD_Flags;
    GUID     CSD_ClassGuid;
    ubyte[1] CSD_Signature;
}

struct CS_RESOURCE
{
    CS_DES CS_Header;
}

struct PCCARD_DES
{
align (1):
    uint      PCD_Count;
    uint      PCD_Type;
    uint      PCD_Flags;
    ubyte     PCD_ConfigIndex;
    ubyte[3]  PCD_Reserved;
    uint      PCD_MemoryCardBase1;
    uint      PCD_MemoryCardBase2;
    uint[2]   PCD_MemoryCardBase;
    ushort[2] PCD_MemoryFlags;
    ubyte[2]  PCD_IoFlags;
}

struct PCCARD_RESOURCE
{
    PCCARD_DES PcCard_Header;
}

struct MFCARD_DES
{
align (1):
    uint     PMF_Count;
    uint     PMF_Type;
    uint     PMF_Flags;
    ubyte    PMF_ConfigOptions;
    ubyte    PMF_IoResourceIndex;
    ubyte[2] PMF_Reserved;
    uint     PMF_ConfigRegisterBase;
}

struct MFCARD_RESOURCE
{
    MFCARD_DES MfCard_Header;
}

struct BUSNUMBER_RANGE
{
align (1):
    uint BUSR_Min;
    uint BUSR_Max;
    uint BUSR_nBusNumbers;
    uint BUSR_Flags;
}

struct BUSNUMBER_DES
{
align (1):
    uint BUSD_Count;
    uint BUSD_Type;
    uint BUSD_Flags;
    uint BUSD_Alloc_Base;
    uint BUSD_Alloc_End;
}

struct BUSNUMBER_RESOURCE
{
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

struct CM_NOTIFY_FILTER
{
    uint cbSize;
    uint Flags;
    CM_NOTIFY_FILTER_TYPE FilterType;
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

struct CM_NOTIFY_EVENT_DATA
{
    CM_NOTIFY_FILTER_TYPE FilterType;
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

@DllImport("SETUPAPI")
BOOL SetupGetInfDriverStoreLocationA(const(char)* FileName, SP_ALTPLATFORM_INFO_V2* AlternatePlatformInfo, 
                                     const(char)* LocaleName, const(char)* ReturnBuffer, uint ReturnBufferSize, 
                                     uint* RequiredSize);

@DllImport("SETUPAPI")
BOOL SetupGetInfDriverStoreLocationW(const(wchar)* FileName, SP_ALTPLATFORM_INFO_V2* AlternatePlatformInfo, 
                                     const(wchar)* LocaleName, const(wchar)* ReturnBuffer, uint ReturnBufferSize, 
                                     uint* RequiredSize);

@DllImport("SETUPAPI")
BOOL SetupGetInfPublishedNameA(const(char)* DriverStoreLocation, const(char)* ReturnBuffer, uint ReturnBufferSize, 
                               uint* RequiredSize);

@DllImport("SETUPAPI")
BOOL SetupGetInfPublishedNameW(const(wchar)* DriverStoreLocation, const(wchar)* ReturnBuffer, 
                               uint ReturnBufferSize, uint* RequiredSize);

@DllImport("SETUPAPI")
ulong SetupGetThreadLogToken();

@DllImport("SETUPAPI")
void SetupSetThreadLogToken(ulong LogToken);

@DllImport("SETUPAPI")
void SetupWriteTextLog(ulong LogToken, uint Category, uint Flags, const(char)* MessageStr);

@DllImport("SETUPAPI")
void SetupWriteTextLogError(ulong LogToken, uint Category, uint LogFlags, uint Error, const(char)* MessageStr);

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

@DllImport("SETUPAPI")
BOOL SetupSetNonInteractiveMode(BOOL NonInteractiveFlag);

@DllImport("SETUPAPI")
BOOL SetupGetNonInteractiveMode();

@DllImport("SETUPAPI")
void* SetupDiCreateDeviceInfoList(const(GUID)* ClassGuid, HWND hwndParent);

@DllImport("SETUPAPI")
void* SetupDiCreateDeviceInfoListExA(const(GUID)* ClassGuid, HWND hwndParent, const(char)* MachineName, 
                                     void* Reserved);

@DllImport("SETUPAPI")
void* SetupDiCreateDeviceInfoListExW(const(GUID)* ClassGuid, HWND hwndParent, const(wchar)* MachineName, 
                                     void* Reserved);

@DllImport("SETUPAPI")
BOOL SetupDiGetDeviceInfoListClass(void* DeviceInfoSet, GUID* ClassGuid);

@DllImport("SETUPAPI")
BOOL SetupDiGetDeviceInfoListDetailA(void* DeviceInfoSet, SP_DEVINFO_LIST_DETAIL_DATA_A* DeviceInfoSetDetailData);

@DllImport("SETUPAPI")
BOOL SetupDiGetDeviceInfoListDetailW(void* DeviceInfoSet, SP_DEVINFO_LIST_DETAIL_DATA_W* DeviceInfoSetDetailData);

@DllImport("SETUPAPI")
BOOL SetupDiCreateDeviceInfoA(void* DeviceInfoSet, const(char)* DeviceName, const(GUID)* ClassGuid, 
                              const(char)* DeviceDescription, HWND hwndParent, uint CreationFlags, 
                              SP_DEVINFO_DATA* DeviceInfoData);

@DllImport("SETUPAPI")
BOOL SetupDiCreateDeviceInfoW(void* DeviceInfoSet, const(wchar)* DeviceName, const(GUID)* ClassGuid, 
                              const(wchar)* DeviceDescription, HWND hwndParent, uint CreationFlags, 
                              SP_DEVINFO_DATA* DeviceInfoData);

@DllImport("SETUPAPI")
BOOL SetupDiOpenDeviceInfoA(void* DeviceInfoSet, const(char)* DeviceInstanceId, HWND hwndParent, uint OpenFlags, 
                            SP_DEVINFO_DATA* DeviceInfoData);

@DllImport("SETUPAPI")
BOOL SetupDiOpenDeviceInfoW(void* DeviceInfoSet, const(wchar)* DeviceInstanceId, HWND hwndParent, uint OpenFlags, 
                            SP_DEVINFO_DATA* DeviceInfoData);

@DllImport("SETUPAPI")
BOOL SetupDiGetDeviceInstanceIdA(void* DeviceInfoSet, SP_DEVINFO_DATA* DeviceInfoData, 
                                 const(char)* DeviceInstanceId, uint DeviceInstanceIdSize, uint* RequiredSize);

@DllImport("SETUPAPI")
BOOL SetupDiGetDeviceInstanceIdW(void* DeviceInfoSet, SP_DEVINFO_DATA* DeviceInfoData, 
                                 const(wchar)* DeviceInstanceId, uint DeviceInstanceIdSize, uint* RequiredSize);

@DllImport("SETUPAPI")
BOOL SetupDiDeleteDeviceInfo(void* DeviceInfoSet, SP_DEVINFO_DATA* DeviceInfoData);

@DllImport("SETUPAPI")
BOOL SetupDiEnumDeviceInfo(void* DeviceInfoSet, uint MemberIndex, SP_DEVINFO_DATA* DeviceInfoData);

@DllImport("SETUPAPI")
BOOL SetupDiDestroyDeviceInfoList(void* DeviceInfoSet);

@DllImport("SETUPAPI")
BOOL SetupDiEnumDeviceInterfaces(void* DeviceInfoSet, SP_DEVINFO_DATA* DeviceInfoData, 
                                 const(GUID)* InterfaceClassGuid, uint MemberIndex, 
                                 SP_DEVICE_INTERFACE_DATA* DeviceInterfaceData);

@DllImport("SETUPAPI")
BOOL SetupDiCreateDeviceInterfaceA(void* DeviceInfoSet, SP_DEVINFO_DATA* DeviceInfoData, 
                                   const(GUID)* InterfaceClassGuid, const(char)* ReferenceString, uint CreationFlags, 
                                   SP_DEVICE_INTERFACE_DATA* DeviceInterfaceData);

@DllImport("SETUPAPI")
BOOL SetupDiCreateDeviceInterfaceW(void* DeviceInfoSet, SP_DEVINFO_DATA* DeviceInfoData, 
                                   const(GUID)* InterfaceClassGuid, const(wchar)* ReferenceString, 
                                   uint CreationFlags, SP_DEVICE_INTERFACE_DATA* DeviceInterfaceData);

@DllImport("SETUPAPI")
BOOL SetupDiOpenDeviceInterfaceA(void* DeviceInfoSet, const(char)* DevicePath, uint OpenFlags, 
                                 SP_DEVICE_INTERFACE_DATA* DeviceInterfaceData);

@DllImport("SETUPAPI")
BOOL SetupDiOpenDeviceInterfaceW(void* DeviceInfoSet, const(wchar)* DevicePath, uint OpenFlags, 
                                 SP_DEVICE_INTERFACE_DATA* DeviceInterfaceData);

@DllImport("SETUPAPI")
BOOL SetupDiGetDeviceInterfaceAlias(void* DeviceInfoSet, SP_DEVICE_INTERFACE_DATA* DeviceInterfaceData, 
                                    const(GUID)* AliasInterfaceClassGuid, 
                                    SP_DEVICE_INTERFACE_DATA* AliasDeviceInterfaceData);

@DllImport("SETUPAPI")
BOOL SetupDiDeleteDeviceInterfaceData(void* DeviceInfoSet, SP_DEVICE_INTERFACE_DATA* DeviceInterfaceData);

@DllImport("SETUPAPI")
BOOL SetupDiRemoveDeviceInterface(void* DeviceInfoSet, SP_DEVICE_INTERFACE_DATA* DeviceInterfaceData);

@DllImport("SETUPAPI")
BOOL SetupDiGetDeviceInterfaceDetailA(void* DeviceInfoSet, SP_DEVICE_INTERFACE_DATA* DeviceInterfaceData, 
                                      char* DeviceInterfaceDetailData, uint DeviceInterfaceDetailDataSize, 
                                      uint* RequiredSize, SP_DEVINFO_DATA* DeviceInfoData);

@DllImport("SETUPAPI")
BOOL SetupDiGetDeviceInterfaceDetailW(void* DeviceInfoSet, SP_DEVICE_INTERFACE_DATA* DeviceInterfaceData, 
                                      char* DeviceInterfaceDetailData, uint DeviceInterfaceDetailDataSize, 
                                      uint* RequiredSize, SP_DEVINFO_DATA* DeviceInfoData);

@DllImport("SETUPAPI")
BOOL SetupDiInstallDeviceInterfaces(void* DeviceInfoSet, SP_DEVINFO_DATA* DeviceInfoData);

@DllImport("SETUPAPI")
BOOL SetupDiSetDeviceInterfaceDefault(void* DeviceInfoSet, SP_DEVICE_INTERFACE_DATA* DeviceInterfaceData, 
                                      uint Flags, void* Reserved);

@DllImport("SETUPAPI")
BOOL SetupDiRegisterDeviceInfo(void* DeviceInfoSet, SP_DEVINFO_DATA* DeviceInfoData, uint Flags, 
                               PSP_DETSIG_CMPPROC CompareProc, void* CompareContext, 
                               SP_DEVINFO_DATA* DupDeviceInfoData);

@DllImport("SETUPAPI")
BOOL SetupDiBuildDriverInfoList(void* DeviceInfoSet, SP_DEVINFO_DATA* DeviceInfoData, uint DriverType);

@DllImport("SETUPAPI")
BOOL SetupDiCancelDriverInfoSearch(void* DeviceInfoSet);

@DllImport("SETUPAPI")
BOOL SetupDiEnumDriverInfoA(void* DeviceInfoSet, SP_DEVINFO_DATA* DeviceInfoData, uint DriverType, 
                            uint MemberIndex, SP_DRVINFO_DATA_V2_A* DriverInfoData);

@DllImport("SETUPAPI")
BOOL SetupDiEnumDriverInfoW(void* DeviceInfoSet, SP_DEVINFO_DATA* DeviceInfoData, uint DriverType, 
                            uint MemberIndex, SP_DRVINFO_DATA_V2_W* DriverInfoData);

@DllImport("SETUPAPI")
BOOL SetupDiGetSelectedDriverA(void* DeviceInfoSet, SP_DEVINFO_DATA* DeviceInfoData, 
                               SP_DRVINFO_DATA_V2_A* DriverInfoData);

@DllImport("SETUPAPI")
BOOL SetupDiGetSelectedDriverW(void* DeviceInfoSet, SP_DEVINFO_DATA* DeviceInfoData, 
                               SP_DRVINFO_DATA_V2_W* DriverInfoData);

@DllImport("SETUPAPI")
BOOL SetupDiSetSelectedDriverA(void* DeviceInfoSet, SP_DEVINFO_DATA* DeviceInfoData, 
                               SP_DRVINFO_DATA_V2_A* DriverInfoData);

@DllImport("SETUPAPI")
BOOL SetupDiSetSelectedDriverW(void* DeviceInfoSet, SP_DEVINFO_DATA* DeviceInfoData, 
                               SP_DRVINFO_DATA_V2_W* DriverInfoData);

@DllImport("SETUPAPI")
BOOL SetupDiGetDriverInfoDetailA(void* DeviceInfoSet, SP_DEVINFO_DATA* DeviceInfoData, 
                                 SP_DRVINFO_DATA_V2_A* DriverInfoData, char* DriverInfoDetailData, 
                                 uint DriverInfoDetailDataSize, uint* RequiredSize);

@DllImport("SETUPAPI")
BOOL SetupDiGetDriverInfoDetailW(void* DeviceInfoSet, SP_DEVINFO_DATA* DeviceInfoData, 
                                 SP_DRVINFO_DATA_V2_W* DriverInfoData, char* DriverInfoDetailData, 
                                 uint DriverInfoDetailDataSize, uint* RequiredSize);

@DllImport("SETUPAPI")
BOOL SetupDiDestroyDriverInfoList(void* DeviceInfoSet, SP_DEVINFO_DATA* DeviceInfoData, uint DriverType);

@DllImport("SETUPAPI")
void* SetupDiGetClassDevsW(const(GUID)* ClassGuid, const(wchar)* Enumerator, HWND hwndParent, uint Flags);

@DllImport("SETUPAPI")
void* SetupDiGetClassDevsExA(const(GUID)* ClassGuid, const(char)* Enumerator, HWND hwndParent, uint Flags, 
                             void* DeviceInfoSet, const(char)* MachineName, void* Reserved);

@DllImport("SETUPAPI")
void* SetupDiGetClassDevsExW(const(GUID)* ClassGuid, const(wchar)* Enumerator, HWND hwndParent, uint Flags, 
                             void* DeviceInfoSet, const(wchar)* MachineName, void* Reserved);

@DllImport("SETUPAPI")
BOOL SetupDiGetINFClassA(const(char)* InfName, GUID* ClassGuid, const(char)* ClassName, uint ClassNameSize, 
                         uint* RequiredSize);

@DllImport("SETUPAPI")
BOOL SetupDiGetINFClassW(const(wchar)* InfName, GUID* ClassGuid, const(wchar)* ClassName, uint ClassNameSize, 
                         uint* RequiredSize);

@DllImport("SETUPAPI")
BOOL SetupDiBuildClassInfoList(uint Flags, char* ClassGuidList, uint ClassGuidListSize, uint* RequiredSize);

@DllImport("SETUPAPI")
BOOL SetupDiBuildClassInfoListExA(uint Flags, char* ClassGuidList, uint ClassGuidListSize, uint* RequiredSize, 
                                  const(char)* MachineName, void* Reserved);

@DllImport("SETUPAPI")
BOOL SetupDiBuildClassInfoListExW(uint Flags, char* ClassGuidList, uint ClassGuidListSize, uint* RequiredSize, 
                                  const(wchar)* MachineName, void* Reserved);

@DllImport("SETUPAPI")
BOOL SetupDiGetClassDescriptionA(const(GUID)* ClassGuid, const(char)* ClassDescription, uint ClassDescriptionSize, 
                                 uint* RequiredSize);

@DllImport("SETUPAPI")
BOOL SetupDiGetClassDescriptionW(const(GUID)* ClassGuid, const(wchar)* ClassDescription, uint ClassDescriptionSize, 
                                 uint* RequiredSize);

@DllImport("SETUPAPI")
BOOL SetupDiGetClassDescriptionExA(const(GUID)* ClassGuid, const(char)* ClassDescription, 
                                   uint ClassDescriptionSize, uint* RequiredSize, const(char)* MachineName, 
                                   void* Reserved);

@DllImport("SETUPAPI")
BOOL SetupDiGetClassDescriptionExW(const(GUID)* ClassGuid, const(wchar)* ClassDescription, 
                                   uint ClassDescriptionSize, uint* RequiredSize, const(wchar)* MachineName, 
                                   void* Reserved);

@DllImport("SETUPAPI")
BOOL SetupDiCallClassInstaller(uint InstallFunction, void* DeviceInfoSet, SP_DEVINFO_DATA* DeviceInfoData);

@DllImport("SETUPAPI")
BOOL SetupDiSelectDevice(void* DeviceInfoSet, SP_DEVINFO_DATA* DeviceInfoData);

@DllImport("SETUPAPI")
BOOL SetupDiSelectBestCompatDrv(void* DeviceInfoSet, SP_DEVINFO_DATA* DeviceInfoData);

@DllImport("SETUPAPI")
BOOL SetupDiInstallDevice(void* DeviceInfoSet, SP_DEVINFO_DATA* DeviceInfoData);

@DllImport("SETUPAPI")
BOOL SetupDiInstallDriverFiles(void* DeviceInfoSet, SP_DEVINFO_DATA* DeviceInfoData);

@DllImport("SETUPAPI")
BOOL SetupDiRegisterCoDeviceInstallers(void* DeviceInfoSet, SP_DEVINFO_DATA* DeviceInfoData);

@DllImport("SETUPAPI")
BOOL SetupDiRemoveDevice(void* DeviceInfoSet, SP_DEVINFO_DATA* DeviceInfoData);

@DllImport("SETUPAPI")
BOOL SetupDiUnremoveDevice(void* DeviceInfoSet, SP_DEVINFO_DATA* DeviceInfoData);

@DllImport("SETUPAPI")
BOOL SetupDiRestartDevices(void* DeviceInfoSet, SP_DEVINFO_DATA* DeviceInfoData);

@DllImport("SETUPAPI")
BOOL SetupDiChangeState(void* DeviceInfoSet, SP_DEVINFO_DATA* DeviceInfoData);

@DllImport("SETUPAPI")
BOOL SetupDiInstallClassA(HWND hwndParent, const(char)* InfFileName, uint Flags, void* FileQueue);

@DllImport("SETUPAPI")
BOOL SetupDiInstallClassW(HWND hwndParent, const(wchar)* InfFileName, uint Flags, void* FileQueue);

@DllImport("SETUPAPI")
BOOL SetupDiInstallClassExA(HWND hwndParent, const(char)* InfFileName, uint Flags, void* FileQueue, 
                            const(GUID)* InterfaceClassGuid, void* Reserved1, void* Reserved2);

@DllImport("SETUPAPI")
BOOL SetupDiInstallClassExW(HWND hwndParent, const(wchar)* InfFileName, uint Flags, void* FileQueue, 
                            const(GUID)* InterfaceClassGuid, void* Reserved1, void* Reserved2);

@DllImport("SETUPAPI")
HKEY SetupDiOpenClassRegKey(const(GUID)* ClassGuid, uint samDesired);

@DllImport("SETUPAPI")
HKEY SetupDiOpenClassRegKeyExA(const(GUID)* ClassGuid, uint samDesired, uint Flags, const(char)* MachineName, 
                               void* Reserved);

@DllImport("SETUPAPI")
HKEY SetupDiOpenClassRegKeyExW(const(GUID)* ClassGuid, uint samDesired, uint Flags, const(wchar)* MachineName, 
                               void* Reserved);

@DllImport("SETUPAPI")
HKEY SetupDiCreateDeviceInterfaceRegKeyA(void* DeviceInfoSet, SP_DEVICE_INTERFACE_DATA* DeviceInterfaceData, 
                                         uint Reserved, uint samDesired, void* InfHandle, 
                                         const(char)* InfSectionName);

@DllImport("SETUPAPI")
HKEY SetupDiCreateDeviceInterfaceRegKeyW(void* DeviceInfoSet, SP_DEVICE_INTERFACE_DATA* DeviceInterfaceData, 
                                         uint Reserved, uint samDesired, void* InfHandle, 
                                         const(wchar)* InfSectionName);

@DllImport("SETUPAPI")
HKEY SetupDiOpenDeviceInterfaceRegKey(void* DeviceInfoSet, SP_DEVICE_INTERFACE_DATA* DeviceInterfaceData, 
                                      uint Reserved, uint samDesired);

@DllImport("SETUPAPI")
BOOL SetupDiDeleteDeviceInterfaceRegKey(void* DeviceInfoSet, SP_DEVICE_INTERFACE_DATA* DeviceInterfaceData, 
                                        uint Reserved);

@DllImport("SETUPAPI")
HKEY SetupDiCreateDevRegKeyA(void* DeviceInfoSet, SP_DEVINFO_DATA* DeviceInfoData, uint Scope, uint HwProfile, 
                             uint KeyType, void* InfHandle, const(char)* InfSectionName);

@DllImport("SETUPAPI")
HKEY SetupDiCreateDevRegKeyW(void* DeviceInfoSet, SP_DEVINFO_DATA* DeviceInfoData, uint Scope, uint HwProfile, 
                             uint KeyType, void* InfHandle, const(wchar)* InfSectionName);

@DllImport("SETUPAPI")
HKEY SetupDiOpenDevRegKey(void* DeviceInfoSet, SP_DEVINFO_DATA* DeviceInfoData, uint Scope, uint HwProfile, 
                          uint KeyType, uint samDesired);

@DllImport("SETUPAPI")
BOOL SetupDiDeleteDevRegKey(void* DeviceInfoSet, SP_DEVINFO_DATA* DeviceInfoData, uint Scope, uint HwProfile, 
                            uint KeyType);

@DllImport("SETUPAPI")
BOOL SetupDiGetHwProfileList(char* HwProfileList, uint HwProfileListSize, uint* RequiredSize, 
                             uint* CurrentlyActiveIndex);

@DllImport("SETUPAPI")
BOOL SetupDiGetHwProfileListExA(char* HwProfileList, uint HwProfileListSize, uint* RequiredSize, 
                                uint* CurrentlyActiveIndex, const(char)* MachineName, void* Reserved);

@DllImport("SETUPAPI")
BOOL SetupDiGetHwProfileListExW(char* HwProfileList, uint HwProfileListSize, uint* RequiredSize, 
                                uint* CurrentlyActiveIndex, const(wchar)* MachineName, void* Reserved);

@DllImport("SETUPAPI")
BOOL SetupDiGetDevicePropertyKeys(void* DeviceInfoSet, SP_DEVINFO_DATA* DeviceInfoData, char* PropertyKeyArray, 
                                  uint PropertyKeyCount, uint* RequiredPropertyKeyCount, uint Flags);

@DllImport("SETUPAPI")
BOOL SetupDiGetDevicePropertyW(void* DeviceInfoSet, SP_DEVINFO_DATA* DeviceInfoData, 
                               const(DEVPROPKEY)* PropertyKey, uint* PropertyType, char* PropertyBuffer, 
                               uint PropertyBufferSize, uint* RequiredSize, uint Flags);

@DllImport("SETUPAPI")
BOOL SetupDiSetDevicePropertyW(void* DeviceInfoSet, SP_DEVINFO_DATA* DeviceInfoData, 
                               const(DEVPROPKEY)* PropertyKey, uint PropertyType, char* PropertyBuffer, 
                               uint PropertyBufferSize, uint Flags);

@DllImport("SETUPAPI")
BOOL SetupDiGetDeviceInterfacePropertyKeys(void* DeviceInfoSet, SP_DEVICE_INTERFACE_DATA* DeviceInterfaceData, 
                                           char* PropertyKeyArray, uint PropertyKeyCount, 
                                           uint* RequiredPropertyKeyCount, uint Flags);

@DllImport("SETUPAPI")
BOOL SetupDiGetDeviceInterfacePropertyW(void* DeviceInfoSet, SP_DEVICE_INTERFACE_DATA* DeviceInterfaceData, 
                                        const(DEVPROPKEY)* PropertyKey, uint* PropertyType, char* PropertyBuffer, 
                                        uint PropertyBufferSize, uint* RequiredSize, uint Flags);

@DllImport("SETUPAPI")
BOOL SetupDiSetDeviceInterfacePropertyW(void* DeviceInfoSet, SP_DEVICE_INTERFACE_DATA* DeviceInterfaceData, 
                                        const(DEVPROPKEY)* PropertyKey, uint PropertyType, char* PropertyBuffer, 
                                        uint PropertyBufferSize, uint Flags);

@DllImport("SETUPAPI")
BOOL SetupDiGetClassPropertyKeys(const(GUID)* ClassGuid, char* PropertyKeyArray, uint PropertyKeyCount, 
                                 uint* RequiredPropertyKeyCount, uint Flags);

@DllImport("SETUPAPI")
BOOL SetupDiGetClassPropertyKeysExW(const(GUID)* ClassGuid, char* PropertyKeyArray, uint PropertyKeyCount, 
                                    uint* RequiredPropertyKeyCount, uint Flags, const(wchar)* MachineName, 
                                    void* Reserved);

@DllImport("SETUPAPI")
BOOL SetupDiGetClassPropertyW(const(GUID)* ClassGuid, const(DEVPROPKEY)* PropertyKey, uint* PropertyType, 
                              char* PropertyBuffer, uint PropertyBufferSize, uint* RequiredSize, uint Flags);

@DllImport("SETUPAPI")
BOOL SetupDiGetClassPropertyExW(const(GUID)* ClassGuid, const(DEVPROPKEY)* PropertyKey, uint* PropertyType, 
                                char* PropertyBuffer, uint PropertyBufferSize, uint* RequiredSize, uint Flags, 
                                const(wchar)* MachineName, void* Reserved);

@DllImport("SETUPAPI")
BOOL SetupDiSetClassPropertyW(const(GUID)* ClassGuid, const(DEVPROPKEY)* PropertyKey, uint PropertyType, 
                              char* PropertyBuffer, uint PropertyBufferSize, uint Flags);

@DllImport("SETUPAPI")
BOOL SetupDiSetClassPropertyExW(const(GUID)* ClassGuid, const(DEVPROPKEY)* PropertyKey, uint PropertyType, 
                                char* PropertyBuffer, uint PropertyBufferSize, uint Flags, const(wchar)* MachineName, 
                                void* Reserved);

@DllImport("SETUPAPI")
BOOL SetupDiGetDeviceRegistryPropertyA(void* DeviceInfoSet, SP_DEVINFO_DATA* DeviceInfoData, uint Property, 
                                       uint* PropertyRegDataType, char* PropertyBuffer, uint PropertyBufferSize, 
                                       uint* RequiredSize);

@DllImport("SETUPAPI")
BOOL SetupDiGetDeviceRegistryPropertyW(void* DeviceInfoSet, SP_DEVINFO_DATA* DeviceInfoData, uint Property, 
                                       uint* PropertyRegDataType, char* PropertyBuffer, uint PropertyBufferSize, 
                                       uint* RequiredSize);

@DllImport("SETUPAPI")
BOOL SetupDiGetClassRegistryPropertyA(const(GUID)* ClassGuid, uint Property, uint* PropertyRegDataType, 
                                      char* PropertyBuffer, uint PropertyBufferSize, uint* RequiredSize, 
                                      const(char)* MachineName, void* Reserved);

@DllImport("SETUPAPI")
BOOL SetupDiGetClassRegistryPropertyW(const(GUID)* ClassGuid, uint Property, uint* PropertyRegDataType, 
                                      char* PropertyBuffer, uint PropertyBufferSize, uint* RequiredSize, 
                                      const(wchar)* MachineName, void* Reserved);

@DllImport("SETUPAPI")
BOOL SetupDiSetDeviceRegistryPropertyA(void* DeviceInfoSet, SP_DEVINFO_DATA* DeviceInfoData, uint Property, 
                                       char* PropertyBuffer, uint PropertyBufferSize);

@DllImport("SETUPAPI")
BOOL SetupDiSetDeviceRegistryPropertyW(void* DeviceInfoSet, SP_DEVINFO_DATA* DeviceInfoData, uint Property, 
                                       char* PropertyBuffer, uint PropertyBufferSize);

@DllImport("SETUPAPI")
BOOL SetupDiSetClassRegistryPropertyA(const(GUID)* ClassGuid, uint Property, char* PropertyBuffer, 
                                      uint PropertyBufferSize, const(char)* MachineName, void* Reserved);

@DllImport("SETUPAPI")
BOOL SetupDiSetClassRegistryPropertyW(const(GUID)* ClassGuid, uint Property, char* PropertyBuffer, 
                                      uint PropertyBufferSize, const(wchar)* MachineName, void* Reserved);

@DllImport("SETUPAPI")
BOOL SetupDiGetDeviceInstallParamsA(void* DeviceInfoSet, SP_DEVINFO_DATA* DeviceInfoData, 
                                    SP_DEVINSTALL_PARAMS_A* DeviceInstallParams);

@DllImport("SETUPAPI")
BOOL SetupDiGetDeviceInstallParamsW(void* DeviceInfoSet, SP_DEVINFO_DATA* DeviceInfoData, 
                                    SP_DEVINSTALL_PARAMS_W* DeviceInstallParams);

@DllImport("SETUPAPI")
BOOL SetupDiGetClassInstallParamsA(void* DeviceInfoSet, SP_DEVINFO_DATA* DeviceInfoData, char* ClassInstallParams, 
                                   uint ClassInstallParamsSize, uint* RequiredSize);

@DllImport("SETUPAPI")
BOOL SetupDiGetClassInstallParamsW(void* DeviceInfoSet, SP_DEVINFO_DATA* DeviceInfoData, char* ClassInstallParams, 
                                   uint ClassInstallParamsSize, uint* RequiredSize);

@DllImport("SETUPAPI")
BOOL SetupDiSetDeviceInstallParamsA(void* DeviceInfoSet, SP_DEVINFO_DATA* DeviceInfoData, 
                                    SP_DEVINSTALL_PARAMS_A* DeviceInstallParams);

@DllImport("SETUPAPI")
BOOL SetupDiSetDeviceInstallParamsW(void* DeviceInfoSet, SP_DEVINFO_DATA* DeviceInfoData, 
                                    SP_DEVINSTALL_PARAMS_W* DeviceInstallParams);

@DllImport("SETUPAPI")
BOOL SetupDiSetClassInstallParamsA(void* DeviceInfoSet, SP_DEVINFO_DATA* DeviceInfoData, char* ClassInstallParams, 
                                   uint ClassInstallParamsSize);

@DllImport("SETUPAPI")
BOOL SetupDiSetClassInstallParamsW(void* DeviceInfoSet, SP_DEVINFO_DATA* DeviceInfoData, char* ClassInstallParams, 
                                   uint ClassInstallParamsSize);

@DllImport("SETUPAPI")
BOOL SetupDiGetDriverInstallParamsA(void* DeviceInfoSet, SP_DEVINFO_DATA* DeviceInfoData, 
                                    SP_DRVINFO_DATA_V2_A* DriverInfoData, SP_DRVINSTALL_PARAMS* DriverInstallParams);

@DllImport("SETUPAPI")
BOOL SetupDiGetDriverInstallParamsW(void* DeviceInfoSet, SP_DEVINFO_DATA* DeviceInfoData, 
                                    SP_DRVINFO_DATA_V2_W* DriverInfoData, SP_DRVINSTALL_PARAMS* DriverInstallParams);

@DllImport("SETUPAPI")
BOOL SetupDiSetDriverInstallParamsA(void* DeviceInfoSet, SP_DEVINFO_DATA* DeviceInfoData, 
                                    SP_DRVINFO_DATA_V2_A* DriverInfoData, SP_DRVINSTALL_PARAMS* DriverInstallParams);

@DllImport("SETUPAPI")
BOOL SetupDiSetDriverInstallParamsW(void* DeviceInfoSet, SP_DEVINFO_DATA* DeviceInfoData, 
                                    SP_DRVINFO_DATA_V2_W* DriverInfoData, SP_DRVINSTALL_PARAMS* DriverInstallParams);

@DllImport("SETUPAPI")
BOOL SetupDiLoadClassIcon(const(GUID)* ClassGuid, HICON* LargeIcon, int* MiniIconIndex);

@DllImport("SETUPAPI")
BOOL SetupDiLoadDeviceIcon(void* DeviceInfoSet, SP_DEVINFO_DATA* DeviceInfoData, uint cxIcon, uint cyIcon, 
                           uint Flags, HICON* hIcon);

@DllImport("SETUPAPI")
int SetupDiDrawMiniIcon(HDC hdc, RECT rc, int MiniIconIndex, uint Flags);

@DllImport("SETUPAPI")
BOOL SetupDiGetClassBitmapIndex(const(GUID)* ClassGuid, int* MiniIconIndex);

@DllImport("SETUPAPI")
BOOL SetupDiGetClassImageList(SP_CLASSIMAGELIST_DATA* ClassImageListData);

@DllImport("SETUPAPI")
BOOL SetupDiGetClassImageListExA(SP_CLASSIMAGELIST_DATA* ClassImageListData, const(char)* MachineName, 
                                 void* Reserved);

@DllImport("SETUPAPI")
BOOL SetupDiGetClassImageListExW(SP_CLASSIMAGELIST_DATA* ClassImageListData, const(wchar)* MachineName, 
                                 void* Reserved);

@DllImport("SETUPAPI")
BOOL SetupDiGetClassImageIndex(SP_CLASSIMAGELIST_DATA* ClassImageListData, const(GUID)* ClassGuid, int* ImageIndex);

@DllImport("SETUPAPI")
BOOL SetupDiDestroyClassImageList(SP_CLASSIMAGELIST_DATA* ClassImageListData);

@DllImport("SETUPAPI")
BOOL SetupDiGetClassDevPropertySheetsA(void* DeviceInfoSet, SP_DEVINFO_DATA* DeviceInfoData, 
                                       PROPSHEETHEADERA_V2* PropertySheetHeader, 
                                       uint PropertySheetHeaderPageListSize, uint* RequiredSize, 
                                       uint PropertySheetType);

@DllImport("SETUPAPI")
BOOL SetupDiGetClassDevPropertySheetsW(void* DeviceInfoSet, SP_DEVINFO_DATA* DeviceInfoData, 
                                       PROPSHEETHEADERW_V2* PropertySheetHeader, 
                                       uint PropertySheetHeaderPageListSize, uint* RequiredSize, 
                                       uint PropertySheetType);

@DllImport("SETUPAPI")
BOOL SetupDiAskForOEMDisk(void* DeviceInfoSet, SP_DEVINFO_DATA* DeviceInfoData);

@DllImport("SETUPAPI")
BOOL SetupDiSelectOEMDrv(HWND hwndParent, void* DeviceInfoSet, SP_DEVINFO_DATA* DeviceInfoData);

@DllImport("SETUPAPI")
BOOL SetupDiClassNameFromGuidA(const(GUID)* ClassGuid, const(char)* ClassName, uint ClassNameSize, 
                               uint* RequiredSize);

@DllImport("SETUPAPI")
BOOL SetupDiClassNameFromGuidW(const(GUID)* ClassGuid, const(wchar)* ClassName, uint ClassNameSize, 
                               uint* RequiredSize);

@DllImport("SETUPAPI")
BOOL SetupDiClassNameFromGuidExA(const(GUID)* ClassGuid, const(char)* ClassName, uint ClassNameSize, 
                                 uint* RequiredSize, const(char)* MachineName, void* Reserved);

@DllImport("SETUPAPI")
BOOL SetupDiClassNameFromGuidExW(const(GUID)* ClassGuid, const(wchar)* ClassName, uint ClassNameSize, 
                                 uint* RequiredSize, const(wchar)* MachineName, void* Reserved);

@DllImport("SETUPAPI")
BOOL SetupDiClassGuidsFromNameA(const(char)* ClassName, char* ClassGuidList, uint ClassGuidListSize, 
                                uint* RequiredSize);

@DllImport("SETUPAPI")
BOOL SetupDiClassGuidsFromNameW(const(wchar)* ClassName, char* ClassGuidList, uint ClassGuidListSize, 
                                uint* RequiredSize);

@DllImport("SETUPAPI")
BOOL SetupDiClassGuidsFromNameExA(const(char)* ClassName, char* ClassGuidList, uint ClassGuidListSize, 
                                  uint* RequiredSize, const(char)* MachineName, void* Reserved);

@DllImport("SETUPAPI")
BOOL SetupDiClassGuidsFromNameExW(const(wchar)* ClassName, char* ClassGuidList, uint ClassGuidListSize, 
                                  uint* RequiredSize, const(wchar)* MachineName, void* Reserved);

@DllImport("SETUPAPI")
BOOL SetupDiGetHwProfileFriendlyNameA(uint HwProfile, const(char)* FriendlyName, uint FriendlyNameSize, 
                                      uint* RequiredSize);

@DllImport("SETUPAPI")
BOOL SetupDiGetHwProfileFriendlyNameW(uint HwProfile, const(wchar)* FriendlyName, uint FriendlyNameSize, 
                                      uint* RequiredSize);

@DllImport("SETUPAPI")
BOOL SetupDiGetHwProfileFriendlyNameExA(uint HwProfile, const(char)* FriendlyName, uint FriendlyNameSize, 
                                        uint* RequiredSize, const(char)* MachineName, void* Reserved);

@DllImport("SETUPAPI")
BOOL SetupDiGetHwProfileFriendlyNameExW(uint HwProfile, const(wchar)* FriendlyName, uint FriendlyNameSize, 
                                        uint* RequiredSize, const(wchar)* MachineName, void* Reserved);

@DllImport("SETUPAPI")
HPROPSHEETPAGE SetupDiGetWizardPage(void* DeviceInfoSet, SP_DEVINFO_DATA* DeviceInfoData, 
                                    SP_INSTALLWIZARD_DATA* InstallWizardData, uint PageType, uint Flags);

@DllImport("SETUPAPI")
BOOL SetupDiGetSelectedDevice(void* DeviceInfoSet, SP_DEVINFO_DATA* DeviceInfoData);

@DllImport("SETUPAPI")
BOOL SetupDiSetSelectedDevice(void* DeviceInfoSet, SP_DEVINFO_DATA* DeviceInfoData);

@DllImport("SETUPAPI")
BOOL SetupDiGetActualModelsSectionA(INFCONTEXT* Context, SP_ALTPLATFORM_INFO_V2* AlternatePlatformInfo, 
                                    const(char)* InfSectionWithExt, uint InfSectionWithExtSize, uint* RequiredSize, 
                                    void* Reserved);

@DllImport("SETUPAPI")
BOOL SetupDiGetActualModelsSectionW(INFCONTEXT* Context, SP_ALTPLATFORM_INFO_V2* AlternatePlatformInfo, 
                                    const(wchar)* InfSectionWithExt, uint InfSectionWithExtSize, uint* RequiredSize, 
                                    void* Reserved);

@DllImport("SETUPAPI")
BOOL SetupDiGetActualSectionToInstallA(void* InfHandle, const(char)* InfSectionName, 
                                       const(char)* InfSectionWithExt, uint InfSectionWithExtSize, 
                                       uint* RequiredSize, byte** Extension);

@DllImport("SETUPAPI")
BOOL SetupDiGetActualSectionToInstallW(void* InfHandle, const(wchar)* InfSectionName, 
                                       const(wchar)* InfSectionWithExt, uint InfSectionWithExtSize, 
                                       uint* RequiredSize, ushort** Extension);

@DllImport("SETUPAPI")
BOOL SetupDiGetActualSectionToInstallExA(void* InfHandle, const(char)* InfSectionName, 
                                         SP_ALTPLATFORM_INFO_V2* AlternatePlatformInfo, 
                                         const(char)* InfSectionWithExt, uint InfSectionWithExtSize, 
                                         uint* RequiredSize, byte** Extension, void* Reserved);

@DllImport("SETUPAPI")
BOOL SetupDiGetActualSectionToInstallExW(void* InfHandle, const(wchar)* InfSectionName, 
                                         SP_ALTPLATFORM_INFO_V2* AlternatePlatformInfo, 
                                         const(wchar)* InfSectionWithExt, uint InfSectionWithExtSize, 
                                         uint* RequiredSize, ushort** Extension, void* Reserved);

@DllImport("SETUPAPI")
BOOL SetupDiGetCustomDevicePropertyA(void* DeviceInfoSet, SP_DEVINFO_DATA* DeviceInfoData, 
                                     const(char)* CustomPropertyName, uint Flags, uint* PropertyRegDataType, 
                                     char* PropertyBuffer, uint PropertyBufferSize, uint* RequiredSize);

@DllImport("SETUPAPI")
BOOL SetupDiGetCustomDevicePropertyW(void* DeviceInfoSet, SP_DEVINFO_DATA* DeviceInfoData, 
                                     const(wchar)* CustomPropertyName, uint Flags, uint* PropertyRegDataType, 
                                     char* PropertyBuffer, uint PropertyBufferSize, uint* RequiredSize);

@DllImport("SETUPAPI")
uint CM_Add_Empty_Log_Conf(size_t* plcLogConf, uint dnDevInst, uint Priority, uint ulFlags);

@DllImport("SETUPAPI")
uint CM_Add_Empty_Log_Conf_Ex(size_t* plcLogConf, uint dnDevInst, uint Priority, uint ulFlags, ptrdiff_t hMachine);

@DllImport("SETUPAPI")
uint CM_Add_IDA(uint dnDevInst, const(char)* pszID, uint ulFlags);

@DllImport("SETUPAPI")
uint CM_Add_IDW(uint dnDevInst, const(wchar)* pszID, uint ulFlags);

@DllImport("SETUPAPI")
uint CM_Add_ID_ExA(uint dnDevInst, const(char)* pszID, uint ulFlags, ptrdiff_t hMachine);

@DllImport("SETUPAPI")
uint CM_Add_ID_ExW(uint dnDevInst, const(wchar)* pszID, uint ulFlags, ptrdiff_t hMachine);

@DllImport("SETUPAPI")
uint CM_Add_Range(ulong ullStartValue, ulong ullEndValue, size_t rlh, uint ulFlags);

@DllImport("SETUPAPI")
uint CM_Add_Res_Des(size_t* prdResDes, size_t lcLogConf, uint ResourceID, char* ResourceData, uint ResourceLen, 
                    uint ulFlags);

@DllImport("SETUPAPI")
uint CM_Add_Res_Des_Ex(size_t* prdResDes, size_t lcLogConf, uint ResourceID, char* ResourceData, uint ResourceLen, 
                       uint ulFlags, ptrdiff_t hMachine);

@DllImport("SETUPAPI")
uint CM_Connect_MachineA(const(char)* UNCServerName, ptrdiff_t* phMachine);

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

@DllImport("SETUPAPI")
uint CM_Delete_Class_Key(GUID* ClassGuid, uint ulFlags);

@DllImport("SETUPAPI")
uint CM_Delete_Class_Key_Ex(GUID* ClassGuid, uint ulFlags, ptrdiff_t hMachine);

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

@DllImport("SETUPAPI")
uint CM_Disable_DevNode(uint dnDevInst, uint ulFlags);

@DllImport("SETUPAPI")
uint CM_Disable_DevNode_Ex(uint dnDevInst, uint ulFlags, ptrdiff_t hMachine);

@DllImport("SETUPAPI")
uint CM_Disconnect_Machine(ptrdiff_t hMachine);

@DllImport("SETUPAPI")
uint CM_Dup_Range_List(size_t rlhOld, size_t rlhNew, uint ulFlags);

@DllImport("SETUPAPI")
uint CM_Enable_DevNode(uint dnDevInst, uint ulFlags);

@DllImport("SETUPAPI")
uint CM_Enable_DevNode_Ex(uint dnDevInst, uint ulFlags, ptrdiff_t hMachine);

@DllImport("SETUPAPI")
uint CM_Enumerate_Classes(uint ulClassIndex, GUID* ClassGuid, uint ulFlags);

@DllImport("SETUPAPI")
uint CM_Enumerate_Classes_Ex(uint ulClassIndex, GUID* ClassGuid, uint ulFlags, ptrdiff_t hMachine);

@DllImport("SETUPAPI")
uint CM_Enumerate_EnumeratorsA(uint ulEnumIndex, const(char)* Buffer, uint* pulLength, uint ulFlags);

@DllImport("SETUPAPI")
uint CM_Enumerate_EnumeratorsW(uint ulEnumIndex, const(wchar)* Buffer, uint* pulLength, uint ulFlags);

@DllImport("SETUPAPI")
uint CM_Enumerate_Enumerators_ExA(uint ulEnumIndex, const(char)* Buffer, uint* pulLength, uint ulFlags, 
                                  ptrdiff_t hMachine);

@DllImport("SETUPAPI")
uint CM_Enumerate_Enumerators_ExW(uint ulEnumIndex, const(wchar)* Buffer, uint* pulLength, uint ulFlags, 
                                  ptrdiff_t hMachine);

@DllImport("SETUPAPI")
uint CM_Find_Range(ulong* pullStart, ulong ullStart, uint ulLength, ulong ullAlignment, ulong ullEnd, size_t rlh, 
                   uint ulFlags);

@DllImport("SETUPAPI")
uint CM_First_Range(size_t rlh, ulong* pullStart, ulong* pullEnd, size_t* preElement, uint ulFlags);

@DllImport("SETUPAPI")
uint CM_Free_Log_Conf(size_t lcLogConfToBeFreed, uint ulFlags);

@DllImport("SETUPAPI")
uint CM_Free_Log_Conf_Ex(size_t lcLogConfToBeFreed, uint ulFlags, ptrdiff_t hMachine);

@DllImport("SETUPAPI")
uint CM_Free_Log_Conf_Handle(size_t lcLogConf);

@DllImport("SETUPAPI")
uint CM_Free_Range_List(size_t rlh, uint ulFlags);

@DllImport("SETUPAPI")
uint CM_Free_Res_Des(size_t* prdResDes, size_t rdResDes, uint ulFlags);

@DllImport("SETUPAPI")
uint CM_Free_Res_Des_Ex(size_t* prdResDes, size_t rdResDes, uint ulFlags, ptrdiff_t hMachine);

@DllImport("SETUPAPI")
uint CM_Free_Res_Des_Handle(size_t rdResDes);

@DllImport("SETUPAPI")
uint CM_Get_Child(uint* pdnDevInst, uint dnDevInst, uint ulFlags);

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

@DllImport("SETUPAPI")
uint CM_Get_Depth(uint* pulDepth, uint dnDevInst, uint ulFlags);

@DllImport("SETUPAPI")
uint CM_Get_Depth_Ex(uint* pulDepth, uint dnDevInst, uint ulFlags, ptrdiff_t hMachine);

@DllImport("SETUPAPI")
uint CM_Get_Device_IDA(uint dnDevInst, const(char)* Buffer, uint BufferLen, uint ulFlags);

@DllImport("SETUPAPI")
uint CM_Get_Device_IDW(uint dnDevInst, const(wchar)* Buffer, uint BufferLen, uint ulFlags);

@DllImport("SETUPAPI")
uint CM_Get_Device_ID_ExA(uint dnDevInst, const(char)* Buffer, uint BufferLen, uint ulFlags, ptrdiff_t hMachine);

@DllImport("SETUPAPI")
uint CM_Get_Device_ID_ExW(uint dnDevInst, const(wchar)* Buffer, uint BufferLen, uint ulFlags, ptrdiff_t hMachine);

@DllImport("SETUPAPI")
uint CM_Get_Device_ID_ListA(const(char)* pszFilter, const(char)* Buffer, uint BufferLen, uint ulFlags);

@DllImport("SETUPAPI")
uint CM_Get_Device_ID_ListW(const(wchar)* pszFilter, const(wchar)* Buffer, uint BufferLen, uint ulFlags);

@DllImport("SETUPAPI")
uint CM_Get_Device_ID_List_ExA(const(char)* pszFilter, const(char)* Buffer, uint BufferLen, uint ulFlags, 
                               ptrdiff_t hMachine);

@DllImport("SETUPAPI")
uint CM_Get_Device_ID_List_ExW(const(wchar)* pszFilter, const(wchar)* Buffer, uint BufferLen, uint ulFlags, 
                               ptrdiff_t hMachine);

@DllImport("SETUPAPI")
uint CM_Get_Device_ID_List_SizeA(uint* pulLen, const(char)* pszFilter, uint ulFlags);

@DllImport("SETUPAPI")
uint CM_Get_Device_ID_List_SizeW(uint* pulLen, const(wchar)* pszFilter, uint ulFlags);

@DllImport("SETUPAPI")
uint CM_Get_Device_ID_List_Size_ExA(uint* pulLen, const(char)* pszFilter, uint ulFlags, ptrdiff_t hMachine);

@DllImport("SETUPAPI")
uint CM_Get_Device_ID_List_Size_ExW(uint* pulLen, const(wchar)* pszFilter, uint ulFlags, ptrdiff_t hMachine);

@DllImport("SETUPAPI")
uint CM_Get_Device_ID_Size(uint* pulLen, uint dnDevInst, uint ulFlags);

@DllImport("SETUPAPI")
uint CM_Get_Device_ID_Size_Ex(uint* pulLen, uint dnDevInst, uint ulFlags, ptrdiff_t hMachine);

@DllImport("api-ms-win-devices-config-l1-1-1")
uint CM_Get_DevNode_PropertyW(uint dnDevInst, const(DEVPROPKEY)* PropertyKey, uint* PropertyType, 
                              char* PropertyBuffer, uint* PropertyBufferSize, uint ulFlags);

@DllImport("CFGMGR32")
uint CM_Get_DevNode_Property_ExW(uint dnDevInst, const(DEVPROPKEY)* PropertyKey, uint* PropertyType, 
                                 char* PropertyBuffer, uint* PropertyBufferSize, uint ulFlags, ptrdiff_t hMachine);

@DllImport("api-ms-win-devices-config-l1-1-1")
uint CM_Get_DevNode_Property_Keys(uint dnDevInst, char* PropertyKeyArray, uint* PropertyKeyCount, uint ulFlags);

@DllImport("CFGMGR32")
uint CM_Get_DevNode_Property_Keys_Ex(uint dnDevInst, char* PropertyKeyArray, uint* PropertyKeyCount, uint ulFlags, 
                                     ptrdiff_t hMachine);

@DllImport("SETUPAPI")
uint CM_Get_DevNode_Registry_PropertyA(uint dnDevInst, uint ulProperty, uint* pulRegDataType, char* Buffer, 
                                       uint* pulLength, uint ulFlags);

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

@DllImport("SETUPAPI")
uint CM_Get_DevNode_Status(uint* pulStatus, uint* pulProblemNumber, uint dnDevInst, uint ulFlags);

@DllImport("SETUPAPI")
uint CM_Get_DevNode_Status_Ex(uint* pulStatus, uint* pulProblemNumber, uint dnDevInst, uint ulFlags, 
                              ptrdiff_t hMachine);

@DllImport("SETUPAPI")
uint CM_Get_First_Log_Conf(size_t* plcLogConf, uint dnDevInst, uint ulFlags);

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

@DllImport("SETUPAPI")
uint CM_Get_HW_Prof_FlagsA(byte* pDeviceID, uint ulHardwareProfile, uint* pulValue, uint ulFlags);

@DllImport("SETUPAPI")
uint CM_Get_HW_Prof_FlagsW(ushort* pDeviceID, uint ulHardwareProfile, uint* pulValue, uint ulFlags);

@DllImport("SETUPAPI")
uint CM_Get_HW_Prof_Flags_ExA(byte* pDeviceID, uint ulHardwareProfile, uint* pulValue, uint ulFlags, 
                              ptrdiff_t hMachine);

@DllImport("SETUPAPI")
uint CM_Get_HW_Prof_Flags_ExW(ushort* pDeviceID, uint ulHardwareProfile, uint* pulValue, uint ulFlags, 
                              ptrdiff_t hMachine);

@DllImport("SETUPAPI")
uint CM_Get_Device_Interface_AliasA(const(char)* pszDeviceInterface, GUID* AliasInterfaceGuid, 
                                    const(char)* pszAliasDeviceInterface, uint* pulLength, uint ulFlags);

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

@DllImport("SETUPAPI")
uint CM_Get_Device_Interface_ListA(GUID* InterfaceClassGuid, byte* pDeviceID, const(char)* Buffer, uint BufferLen, 
                                   uint ulFlags);

@DllImport("SETUPAPI")
uint CM_Get_Device_Interface_ListW(GUID* InterfaceClassGuid, ushort* pDeviceID, const(wchar)* Buffer, 
                                   uint BufferLen, uint ulFlags);

@DllImport("SETUPAPI")
uint CM_Get_Device_Interface_List_ExA(GUID* InterfaceClassGuid, byte* pDeviceID, const(char)* Buffer, 
                                      uint BufferLen, uint ulFlags, ptrdiff_t hMachine);

@DllImport("SETUPAPI")
uint CM_Get_Device_Interface_List_ExW(GUID* InterfaceClassGuid, ushort* pDeviceID, const(wchar)* Buffer, 
                                      uint BufferLen, uint ulFlags, ptrdiff_t hMachine);

@DllImport("SETUPAPI")
uint CM_Get_Device_Interface_List_SizeA(uint* pulLen, GUID* InterfaceClassGuid, byte* pDeviceID, uint ulFlags);

@DllImport("SETUPAPI")
uint CM_Get_Device_Interface_List_SizeW(uint* pulLen, GUID* InterfaceClassGuid, ushort* pDeviceID, uint ulFlags);

@DllImport("SETUPAPI")
uint CM_Get_Device_Interface_List_Size_ExA(uint* pulLen, GUID* InterfaceClassGuid, byte* pDeviceID, uint ulFlags, 
                                           ptrdiff_t hMachine);

@DllImport("SETUPAPI")
uint CM_Get_Device_Interface_List_Size_ExW(uint* pulLen, GUID* InterfaceClassGuid, ushort* pDeviceID, uint ulFlags, 
                                           ptrdiff_t hMachine);

@DllImport("api-ms-win-devices-config-l1-1-1")
uint CM_Get_Device_Interface_PropertyW(const(wchar)* pszDeviceInterface, const(DEVPROPKEY)* PropertyKey, 
                                       uint* PropertyType, char* PropertyBuffer, uint* PropertyBufferSize, 
                                       uint ulFlags);

@DllImport("CFGMGR32")
uint CM_Get_Device_Interface_Property_ExW(const(wchar)* pszDeviceInterface, const(DEVPROPKEY)* PropertyKey, 
                                          uint* PropertyType, char* PropertyBuffer, uint* PropertyBufferSize, 
                                          uint ulFlags, ptrdiff_t hMachine);

@DllImport("api-ms-win-devices-config-l1-1-1")
uint CM_Get_Device_Interface_Property_KeysW(const(wchar)* pszDeviceInterface, char* PropertyKeyArray, 
                                            uint* PropertyKeyCount, uint ulFlags);

@DllImport("CFGMGR32")
uint CM_Get_Device_Interface_Property_Keys_ExW(const(wchar)* pszDeviceInterface, char* PropertyKeyArray, 
                                               uint* PropertyKeyCount, uint ulFlags, ptrdiff_t hMachine);

@DllImport("SETUPAPI")
uint CM_Get_Log_Conf_Priority(size_t lcLogConf, uint* pPriority, uint ulFlags);

@DllImport("SETUPAPI")
uint CM_Get_Log_Conf_Priority_Ex(size_t lcLogConf, uint* pPriority, uint ulFlags, ptrdiff_t hMachine);

@DllImport("SETUPAPI")
uint CM_Get_Next_Log_Conf(size_t* plcLogConf, size_t lcLogConf, uint ulFlags);

@DllImport("SETUPAPI")
uint CM_Get_Next_Log_Conf_Ex(size_t* plcLogConf, size_t lcLogConf, uint ulFlags, ptrdiff_t hMachine);

@DllImport("SETUPAPI")
uint CM_Get_Parent(uint* pdnDevInst, uint dnDevInst, uint ulFlags);

@DllImport("SETUPAPI")
uint CM_Get_Parent_Ex(uint* pdnDevInst, uint dnDevInst, uint ulFlags, ptrdiff_t hMachine);

@DllImport("SETUPAPI")
uint CM_Get_Res_Des_Data(size_t rdResDes, char* Buffer, uint BufferLen, uint ulFlags);

@DllImport("SETUPAPI")
uint CM_Get_Res_Des_Data_Ex(size_t rdResDes, char* Buffer, uint BufferLen, uint ulFlags, ptrdiff_t hMachine);

@DllImport("SETUPAPI")
uint CM_Get_Res_Des_Data_Size(uint* pulSize, size_t rdResDes, uint ulFlags);

@DllImport("SETUPAPI")
uint CM_Get_Res_Des_Data_Size_Ex(uint* pulSize, size_t rdResDes, uint ulFlags, ptrdiff_t hMachine);

@DllImport("SETUPAPI")
uint CM_Get_Sibling(uint* pdnDevInst, uint dnDevInst, uint ulFlags);

@DllImport("SETUPAPI")
uint CM_Get_Sibling_Ex(uint* pdnDevInst, uint dnDevInst, uint ulFlags, ptrdiff_t hMachine);

@DllImport("SETUPAPI")
ushort CM_Get_Version();

@DllImport("SETUPAPI")
ushort CM_Get_Version_Ex(ptrdiff_t hMachine);

@DllImport("SETUPAPI")
BOOL CM_Is_Version_Available(ushort wVersion);

@DllImport("SETUPAPI")
BOOL CM_Is_Version_Available_Ex(ushort wVersion, ptrdiff_t hMachine);

@DllImport("SETUPAPI")
uint CM_Intersect_Range_List(size_t rlhOld1, size_t rlhOld2, size_t rlhNew, uint ulFlags);

@DllImport("SETUPAPI")
uint CM_Invert_Range_List(size_t rlhOld, size_t rlhNew, ulong ullMaxValue, uint ulFlags);

@DllImport("SETUPAPI")
uint CM_Locate_DevNodeA(uint* pdnDevInst, byte* pDeviceID, uint ulFlags);

@DllImport("SETUPAPI")
uint CM_Locate_DevNodeW(uint* pdnDevInst, ushort* pDeviceID, uint ulFlags);

@DllImport("SETUPAPI")
uint CM_Locate_DevNode_ExA(uint* pdnDevInst, byte* pDeviceID, uint ulFlags, ptrdiff_t hMachine);

@DllImport("SETUPAPI")
uint CM_Locate_DevNode_ExW(uint* pdnDevInst, ushort* pDeviceID, uint ulFlags, ptrdiff_t hMachine);

@DllImport("SETUPAPI")
uint CM_Merge_Range_List(size_t rlhOld1, size_t rlhOld2, size_t rlhNew, uint ulFlags);

@DllImport("SETUPAPI")
uint CM_Modify_Res_Des(size_t* prdResDes, size_t rdResDes, uint ResourceID, char* ResourceData, uint ResourceLen, 
                       uint ulFlags);

@DllImport("SETUPAPI")
uint CM_Modify_Res_Des_Ex(size_t* prdResDes, size_t rdResDes, uint ResourceID, char* ResourceData, 
                          uint ResourceLen, uint ulFlags, ptrdiff_t hMachine);

@DllImport("SETUPAPI")
uint CM_Move_DevNode(uint dnFromDevInst, uint dnToDevInst, uint ulFlags);

@DllImport("SETUPAPI")
uint CM_Move_DevNode_Ex(uint dnFromDevInst, uint dnToDevInst, uint ulFlags, ptrdiff_t hMachine);

@DllImport("SETUPAPI")
uint CM_Next_Range(size_t* preElement, ulong* pullStart, ulong* pullEnd, uint ulFlags);

@DllImport("SETUPAPI")
uint CM_Get_Next_Res_Des(size_t* prdResDes, size_t rdResDes, uint ForResource, uint* pResourceID, uint ulFlags);

@DllImport("SETUPAPI")
uint CM_Get_Next_Res_Des_Ex(size_t* prdResDes, size_t rdResDes, uint ForResource, uint* pResourceID, uint ulFlags, 
                            ptrdiff_t hMachine);

@DllImport("SETUPAPI")
uint CM_Open_Class_KeyA(GUID* ClassGuid, const(char)* pszClassName, uint samDesired, uint Disposition, 
                        HKEY* phkClass, uint ulFlags);

@DllImport("SETUPAPI")
uint CM_Open_Class_KeyW(GUID* ClassGuid, const(wchar)* pszClassName, uint samDesired, uint Disposition, 
                        HKEY* phkClass, uint ulFlags);

@DllImport("SETUPAPI")
uint CM_Open_Class_Key_ExA(GUID* ClassGuid, const(char)* pszClassName, uint samDesired, uint Disposition, 
                           HKEY* phkClass, uint ulFlags, ptrdiff_t hMachine);

@DllImport("SETUPAPI")
uint CM_Open_Class_Key_ExW(GUID* ClassGuid, const(wchar)* pszClassName, uint samDesired, uint Disposition, 
                           HKEY* phkClass, uint ulFlags, ptrdiff_t hMachine);

@DllImport("SETUPAPI")
uint CM_Open_DevNode_Key(uint dnDevNode, uint samDesired, uint ulHardwareProfile, uint Disposition, 
                         HKEY* phkDevice, uint ulFlags);

@DllImport("SETUPAPI")
uint CM_Open_DevNode_Key_Ex(uint dnDevNode, uint samDesired, uint ulHardwareProfile, uint Disposition, 
                            HKEY* phkDevice, uint ulFlags, ptrdiff_t hMachine);

@DllImport("SETUPAPI")
uint CM_Open_Device_Interface_KeyA(const(char)* pszDeviceInterface, uint samDesired, uint Disposition, 
                                   HKEY* phkDeviceInterface, uint ulFlags);

@DllImport("SETUPAPI")
uint CM_Open_Device_Interface_KeyW(const(wchar)* pszDeviceInterface, uint samDesired, uint Disposition, 
                                   HKEY* phkDeviceInterface, uint ulFlags);

@DllImport("SETUPAPI")
uint CM_Open_Device_Interface_Key_ExA(const(char)* pszDeviceInterface, uint samDesired, uint Disposition, 
                                      HKEY* phkDeviceInterface, uint ulFlags, ptrdiff_t hMachine);

@DllImport("SETUPAPI")
uint CM_Open_Device_Interface_Key_ExW(const(wchar)* pszDeviceInterface, uint samDesired, uint Disposition, 
                                      HKEY* phkDeviceInterface, uint ulFlags, ptrdiff_t hMachine);

@DllImport("SETUPAPI")
uint CM_Delete_Device_Interface_KeyA(const(char)* pszDeviceInterface, uint ulFlags);

@DllImport("SETUPAPI")
uint CM_Delete_Device_Interface_KeyW(const(wchar)* pszDeviceInterface, uint ulFlags);

@DllImport("SETUPAPI")
uint CM_Delete_Device_Interface_Key_ExA(const(char)* pszDeviceInterface, uint ulFlags, ptrdiff_t hMachine);

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

@DllImport("SETUPAPI")
uint CM_Query_And_Remove_SubTreeW(uint dnAncestor, PNP_VETO_TYPE* pVetoType, const(wchar)* pszVetoName, 
                                  uint ulNameLength, uint ulFlags);

@DllImport("SETUPAPI")
uint CM_Query_And_Remove_SubTree_ExA(uint dnAncestor, PNP_VETO_TYPE* pVetoType, const(char)* pszVetoName, 
                                     uint ulNameLength, uint ulFlags, ptrdiff_t hMachine);

@DllImport("SETUPAPI")
uint CM_Query_And_Remove_SubTree_ExW(uint dnAncestor, PNP_VETO_TYPE* pVetoType, const(wchar)* pszVetoName, 
                                     uint ulNameLength, uint ulFlags, ptrdiff_t hMachine);

@DllImport("SETUPAPI")
uint CM_Request_Device_EjectA(uint dnDevInst, PNP_VETO_TYPE* pVetoType, const(char)* pszVetoName, 
                              uint ulNameLength, uint ulFlags);

@DllImport("SETUPAPI")
uint CM_Request_Device_Eject_ExA(uint dnDevInst, PNP_VETO_TYPE* pVetoType, const(char)* pszVetoName, 
                                 uint ulNameLength, uint ulFlags, ptrdiff_t hMachine);

@DllImport("SETUPAPI")
uint CM_Request_Device_EjectW(uint dnDevInst, PNP_VETO_TYPE* pVetoType, const(wchar)* pszVetoName, 
                              uint ulNameLength, uint ulFlags);

@DllImport("SETUPAPI")
uint CM_Request_Device_Eject_ExW(uint dnDevInst, PNP_VETO_TYPE* pVetoType, const(wchar)* pszVetoName, 
                                 uint ulNameLength, uint ulFlags, ptrdiff_t hMachine);

@DllImport("SETUPAPI")
uint CM_Reenumerate_DevNode(uint dnDevInst, uint ulFlags);

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

@DllImport("SETUPAPI")
uint CM_Set_DevNode_Problem_Ex(uint dnDevInst, uint ulProblem, uint ulFlags, ptrdiff_t hMachine);

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

@DllImport("api-ms-win-devices-config-l1-1-1")
uint CM_Set_DevNode_PropertyW(uint dnDevInst, const(DEVPROPKEY)* PropertyKey, uint PropertyType, 
                              char* PropertyBuffer, uint PropertyBufferSize, uint ulFlags);

@DllImport("CFGMGR32")
uint CM_Set_DevNode_Property_ExW(uint dnDevInst, const(DEVPROPKEY)* PropertyKey, uint PropertyType, 
                                 char* PropertyBuffer, uint PropertyBufferSize, uint ulFlags, ptrdiff_t hMachine);

@DllImport("SETUPAPI")
uint CM_Set_DevNode_Registry_PropertyA(uint dnDevInst, uint ulProperty, char* Buffer, uint ulLength, uint ulFlags);

@DllImport("SETUPAPI")
uint CM_Set_DevNode_Registry_PropertyW(uint dnDevInst, uint ulProperty, char* Buffer, uint ulLength, uint ulFlags);

@DllImport("SETUPAPI")
uint CM_Set_DevNode_Registry_Property_ExA(uint dnDevInst, uint ulProperty, char* Buffer, uint ulLength, 
                                          uint ulFlags, ptrdiff_t hMachine);

@DllImport("SETUPAPI")
uint CM_Set_DevNode_Registry_Property_ExW(uint dnDevInst, uint ulProperty, char* Buffer, uint ulLength, 
                                          uint ulFlags, ptrdiff_t hMachine);

@DllImport("api-ms-win-devices-config-l1-1-1")
uint CM_Set_Device_Interface_PropertyW(const(wchar)* pszDeviceInterface, const(DEVPROPKEY)* PropertyKey, 
                                       uint PropertyType, char* PropertyBuffer, uint PropertyBufferSize, 
                                       uint ulFlags);

@DllImport("CFGMGR32")
uint CM_Set_Device_Interface_Property_ExW(const(wchar)* pszDeviceInterface, const(DEVPROPKEY)* PropertyKey, 
                                          uint PropertyType, char* PropertyBuffer, uint PropertyBufferSize, 
                                          uint ulFlags, ptrdiff_t hMachine);

@DllImport("SETUPAPI")
uint CM_Is_Dock_Station_Present(int* pbPresent);

@DllImport("SETUPAPI")
uint CM_Is_Dock_Station_Present_Ex(int* pbPresent, ptrdiff_t hMachine);

@DllImport("SETUPAPI")
uint CM_Request_Eject_PC();

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

@DllImport("SETUPAPI")
uint CM_Setup_DevNode(uint dnDevInst, uint ulFlags);

@DllImport("SETUPAPI")
uint CM_Setup_DevNode_Ex(uint dnDevInst, uint ulFlags, ptrdiff_t hMachine);

@DllImport("SETUPAPI")
uint CM_Test_Range_Available(ulong ullStartValue, ulong ullEndValue, size_t rlh, uint ulFlags);

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

@DllImport("SETUPAPI")
uint CM_Query_Resource_Conflict_List(size_t* pclConflictList, uint dnDevInst, uint ResourceID, char* ResourceData, 
                                     uint ResourceLen, uint ulFlags, ptrdiff_t hMachine);

@DllImport("SETUPAPI")
uint CM_Free_Resource_Conflict_Handle(size_t clConflictList);

@DllImport("SETUPAPI")
uint CM_Get_Resource_Conflict_Count(size_t clConflictList, uint* pulCount);

@DllImport("SETUPAPI")
uint CM_Get_Resource_Conflict_DetailsA(size_t clConflictList, uint ulIndex, CONFLICT_DETAILS_A* pConflictDetails);

@DllImport("SETUPAPI")
uint CM_Get_Resource_Conflict_DetailsW(size_t clConflictList, uint ulIndex, CONFLICT_DETAILS_W* pConflictDetails);

@DllImport("api-ms-win-devices-config-l1-1-1")
uint CM_Get_Class_PropertyW(GUID* ClassGUID, const(DEVPROPKEY)* PropertyKey, uint* PropertyType, 
                            char* PropertyBuffer, uint* PropertyBufferSize, uint ulFlags);

@DllImport("CFGMGR32")
uint CM_Get_Class_Property_ExW(GUID* ClassGUID, const(DEVPROPKEY)* PropertyKey, uint* PropertyType, 
                               char* PropertyBuffer, uint* PropertyBufferSize, uint ulFlags, ptrdiff_t hMachine);

@DllImport("api-ms-win-devices-config-l1-1-1")
uint CM_Get_Class_Property_Keys(GUID* ClassGUID, char* PropertyKeyArray, uint* PropertyKeyCount, uint ulFlags);

@DllImport("CFGMGR32")
uint CM_Get_Class_Property_Keys_Ex(GUID* ClassGUID, char* PropertyKeyArray, uint* PropertyKeyCount, uint ulFlags, 
                                   ptrdiff_t hMachine);

@DllImport("api-ms-win-devices-config-l1-1-1")
uint CM_Set_Class_PropertyW(GUID* ClassGUID, const(DEVPROPKEY)* PropertyKey, uint PropertyType, 
                            char* PropertyBuffer, uint PropertyBufferSize, uint ulFlags);

@DllImport("CFGMGR32")
uint CM_Set_Class_Property_ExW(GUID* ClassGUID, const(DEVPROPKEY)* PropertyKey, uint PropertyType, 
                               char* PropertyBuffer, uint PropertyBufferSize, uint ulFlags, ptrdiff_t hMachine);

@DllImport("SETUPAPI")
uint CM_Get_Class_Registry_PropertyA(GUID* ClassGuid, uint ulProperty, uint* pulRegDataType, char* Buffer, 
                                     uint* pulLength, uint ulFlags, ptrdiff_t hMachine);

@DllImport("SETUPAPI")
uint CM_Get_Class_Registry_PropertyW(GUID* ClassGuid, uint ulProperty, uint* pulRegDataType, char* Buffer, 
                                     uint* pulLength, uint ulFlags, ptrdiff_t hMachine);

@DllImport("SETUPAPI")
uint CM_Set_Class_Registry_PropertyA(GUID* ClassGuid, uint ulProperty, char* Buffer, uint ulLength, uint ulFlags, 
                                     ptrdiff_t hMachine);

@DllImport("SETUPAPI")
uint CM_Set_Class_Registry_PropertyW(GUID* ClassGuid, uint ulProperty, char* Buffer, uint ulLength, uint ulFlags, 
                                     ptrdiff_t hMachine);

@DllImport("SETUPAPI")
uint CMP_WaitNoPendingInstallEvents(uint dwTimeout);

@DllImport("api-ms-win-devices-config-l1-1-1")
uint CM_Register_Notification(CM_NOTIFY_FILTER* pFilter, void* pContext, PCM_NOTIFY_CALLBACK pCallback, 
                              HCMNOTIFICATION__** pNotifyContext);

@DllImport("api-ms-win-devices-config-l1-1-1")
uint CM_Unregister_Notification(HCMNOTIFICATION__* NotifyContext);

@DllImport("api-ms-win-devices-config-l1-1-1")
uint CM_MapCrToWin32Err(uint CmReturnCode, uint DefaultErr);

@DllImport("newdev")
BOOL UpdateDriverForPlugAndPlayDevicesA(HWND hwndParent, const(char)* HardwareId, const(char)* FullInfPath, 
                                        uint InstallFlags, int* bRebootRequired);

@DllImport("newdev")
BOOL UpdateDriverForPlugAndPlayDevicesW(HWND hwndParent, const(wchar)* HardwareId, const(wchar)* FullInfPath, 
                                        uint InstallFlags, int* bRebootRequired);

@DllImport("newdev")
BOOL DiInstallDevice(HWND hwndParent, void* DeviceInfoSet, SP_DEVINFO_DATA* DeviceInfoData, 
                     SP_DRVINFO_DATA_V2_A* DriverInfoData, uint Flags, int* NeedReboot);

@DllImport("newdev")
BOOL DiInstallDriverW(HWND hwndParent, const(wchar)* InfPath, uint Flags, int* NeedReboot);

@DllImport("newdev")
BOOL DiInstallDriverA(HWND hwndParent, const(char)* InfPath, uint Flags, int* NeedReboot);

@DllImport("newdev")
BOOL DiUninstallDevice(HWND hwndParent, void* DeviceInfoSet, SP_DEVINFO_DATA* DeviceInfoData, uint Flags, 
                       int* NeedReboot);

@DllImport("newdev")
BOOL DiUninstallDriverW(HWND hwndParent, const(wchar)* InfPath, uint Flags, int* NeedReboot);

@DllImport("newdev")
BOOL DiUninstallDriverA(HWND hwndParent, const(char)* InfPath, uint Flags, int* NeedReboot);

@DllImport("newdev")
BOOL DiShowUpdateDevice(HWND hwndParent, void* DeviceInfoSet, SP_DEVINFO_DATA* DeviceInfoData, uint Flags, 
                        int* NeedReboot);

@DllImport("newdev")
BOOL DiRollbackDriver(void* DeviceInfoSet, SP_DEVINFO_DATA* DeviceInfoData, HWND hwndParent, uint Flags, 
                      int* NeedReboot);

@DllImport("newdev")
BOOL DiShowUpdateDriver(HWND hwndParent, const(wchar)* FilePath, uint Flags, int* NeedReboot);


