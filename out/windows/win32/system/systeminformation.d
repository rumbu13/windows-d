// Written in the D programming language.

module windows.win32.system.systeminformation;

public import windows.core;
public import windows.win32.foundation : BOOL, BOOLEAN, CHAR, FILETIME, HANDLE,
                                         HRESULT, PSTR, PWSTR, SYSTEMTIME;

extern(Windows) @nogc nothrow:


// Enums


alias VER_FLAGS = uint;
enum : uint
{
    VER_MINORVERSION     = 0x00000001U,
    VER_MAJORVERSION     = 0x00000002U,
    VER_BUILDNUMBER      = 0x00000004U,
    VER_PLATFORMID       = 0x00000008U,
    VER_SERVICEPACKMINOR = 0x00000010U,
    VER_SERVICEPACKMAJOR = 0x00000020U,
    VER_SUITENAME        = 0x00000040U,
    VER_PRODUCT_TYPE     = 0x00000080U,
}

alias IMAGE_FILE_MACHINE = ushort;
enum : ushort
{
    IMAGE_FILE_MACHINE_AXP64       = cast(ushort) 0x0284,
    IMAGE_FILE_MACHINE_I386        = cast(ushort) 0x014c,
    IMAGE_FILE_MACHINE_IA64        = cast(ushort) 0x0200,
    IMAGE_FILE_MACHINE_AMD64       = cast(ushort) 0x8664,
    IMAGE_FILE_MACHINE_UNKNOWN     = cast(ushort) 0x0000,
    IMAGE_FILE_MACHINE_TARGET_HOST = cast(ushort) 0x0001,
    IMAGE_FILE_MACHINE_R3000       = cast(ushort) 0x0162,
    IMAGE_FILE_MACHINE_R4000       = cast(ushort) 0x0166,
    IMAGE_FILE_MACHINE_R10000      = cast(ushort) 0x0168,
    IMAGE_FILE_MACHINE_WCEMIPSV2   = cast(ushort) 0x0169,
    IMAGE_FILE_MACHINE_ALPHA       = cast(ushort) 0x0184,
    IMAGE_FILE_MACHINE_SH3         = cast(ushort) 0x01a2,
    IMAGE_FILE_MACHINE_SH3DSP      = cast(ushort) 0x01a3,
    IMAGE_FILE_MACHINE_SH3E        = cast(ushort) 0x01a4,
    IMAGE_FILE_MACHINE_SH4         = cast(ushort) 0x01a6,
    IMAGE_FILE_MACHINE_SH5         = cast(ushort) 0x01a8,
    IMAGE_FILE_MACHINE_ARM         = cast(ushort) 0x01c0,
    IMAGE_FILE_MACHINE_THUMB       = cast(ushort) 0x01c2,
    IMAGE_FILE_MACHINE_ARMNT       = cast(ushort) 0x01c4,
    IMAGE_FILE_MACHINE_AM33        = cast(ushort) 0x01d3,
    IMAGE_FILE_MACHINE_POWERPC     = cast(ushort) 0x01f0,
    IMAGE_FILE_MACHINE_POWERPCFP   = cast(ushort) 0x01f1,
    IMAGE_FILE_MACHINE_MIPS16      = cast(ushort) 0x0266,
    IMAGE_FILE_MACHINE_ALPHA64     = cast(ushort) 0x0284,
    IMAGE_FILE_MACHINE_MIPSFPU     = cast(ushort) 0x0366,
    IMAGE_FILE_MACHINE_MIPSFPU16   = cast(ushort) 0x0466,
    IMAGE_FILE_MACHINE_TRICORE     = cast(ushort) 0x0520,
    IMAGE_FILE_MACHINE_CEF         = cast(ushort) 0x0cef,
    IMAGE_FILE_MACHINE_EBC         = cast(ushort) 0x0ebc,
    IMAGE_FILE_MACHINE_M32R        = cast(ushort) 0x9041,
    IMAGE_FILE_MACHINE_ARM64       = cast(ushort) 0xaa64,
    IMAGE_FILE_MACHINE_CEE         = cast(ushort) 0xc0ee,
}

alias PROCESSOR_ARCHITECTURE = ushort;
enum : ushort
{
    PROCESSOR_ARCHITECTURE_INTEL          = cast(ushort) 0x0000,
    PROCESSOR_ARCHITECTURE_MIPS           = cast(ushort) 0x0001,
    PROCESSOR_ARCHITECTURE_ALPHA          = cast(ushort) 0x0002,
    PROCESSOR_ARCHITECTURE_PPC            = cast(ushort) 0x0003,
    PROCESSOR_ARCHITECTURE_SHX            = cast(ushort) 0x0004,
    PROCESSOR_ARCHITECTURE_ARM            = cast(ushort) 0x0005,
    PROCESSOR_ARCHITECTURE_IA64           = cast(ushort) 0x0006,
    PROCESSOR_ARCHITECTURE_ALPHA64        = cast(ushort) 0x0007,
    PROCESSOR_ARCHITECTURE_MSIL           = cast(ushort) 0x0008,
    PROCESSOR_ARCHITECTURE_AMD64          = cast(ushort) 0x0009,
    PROCESSOR_ARCHITECTURE_IA32_ON_WIN64  = cast(ushort) 0x000a,
    PROCESSOR_ARCHITECTURE_NEUTRAL        = cast(ushort) 0x000b,
    PROCESSOR_ARCHITECTURE_ARM64          = cast(ushort) 0x000c,
    PROCESSOR_ARCHITECTURE_ARM32_ON_WIN64 = cast(ushort) 0x000d,
    PROCESSOR_ARCHITECTURE_IA32_ON_ARM64  = cast(ushort) 0x000e,
    PROCESSOR_ARCHITECTURE_UNKNOWN        = cast(ushort) 0xffff,
}

alias FIRMWARE_TABLE_PROVIDER = uint;
enum : uint
{
    ACPI    = 0x41435049U,
    FIRM    = 0x4649524dU,
    RSMB    = 0x52534d42U,
}

alias USER_CET_ENVIRONMENT = uint;
enum : uint
{
    USER_CET_ENVIRONMENT_WIN32_PROCESS     = 0x00000000U,
    USER_CET_ENVIRONMENT_SGX2_ENCLAVE      = 0x00000002U,
    USER_CET_ENVIRONMENT_VBS_ENCLAVE       = 0x00000010U,
    USER_CET_ENVIRONMENT_VBS_BASIC_ENCLAVE = 0x00000011U,
}

alias OS_PRODUCT_TYPE = uint;
enum : uint
{
    PRODUCT_UNDEFINED                               = 0x00000000U,
    PRODUCT_ULTIMATE                                = 0x00000001U,
    PRODUCT_HOME_BASIC                              = 0x00000002U,
    PRODUCT_HOME_PREMIUM                            = 0x00000003U,
    PRODUCT_ENTERPRISE                              = 0x00000004U,
    PRODUCT_HOME_BASIC_N                            = 0x00000005U,
    PRODUCT_BUSINESS                                = 0x00000006U,
    PRODUCT_STANDARD_SERVER                         = 0x00000007U,
    PRODUCT_DATACENTER_SERVER                       = 0x00000008U,
    PRODUCT_SMALLBUSINESS_SERVER                    = 0x00000009U,
    PRODUCT_ENTERPRISE_SERVER                       = 0x0000000aU,
    PRODUCT_STARTER                                 = 0x0000000bU,
    PRODUCT_DATACENTER_SERVER_CORE                  = 0x0000000cU,
    PRODUCT_STANDARD_SERVER_CORE                    = 0x0000000dU,
    PRODUCT_ENTERPRISE_SERVER_CORE                  = 0x0000000eU,
    PRODUCT_ENTERPRISE_SERVER_IA64                  = 0x0000000fU,
    PRODUCT_BUSINESS_N                              = 0x00000010U,
    PRODUCT_WEB_SERVER                              = 0x00000011U,
    PRODUCT_CLUSTER_SERVER                          = 0x00000012U,
    PRODUCT_HOME_SERVER                             = 0x00000013U,
    PRODUCT_STORAGE_EXPRESS_SERVER                  = 0x00000014U,
    PRODUCT_STORAGE_STANDARD_SERVER                 = 0x00000015U,
    PRODUCT_STORAGE_WORKGROUP_SERVER                = 0x00000016U,
    PRODUCT_STORAGE_ENTERPRISE_SERVER               = 0x00000017U,
    PRODUCT_SERVER_FOR_SMALLBUSINESS                = 0x00000018U,
    PRODUCT_SMALLBUSINESS_SERVER_PREMIUM            = 0x00000019U,
    PRODUCT_HOME_PREMIUM_N                          = 0x0000001aU,
    PRODUCT_ENTERPRISE_N                            = 0x0000001bU,
    PRODUCT_ULTIMATE_N                              = 0x0000001cU,
    PRODUCT_WEB_SERVER_CORE                         = 0x0000001dU,
    PRODUCT_MEDIUMBUSINESS_SERVER_MANAGEMENT        = 0x0000001eU,
    PRODUCT_MEDIUMBUSINESS_SERVER_SECURITY          = 0x0000001fU,
    PRODUCT_MEDIUMBUSINESS_SERVER_MESSAGING         = 0x00000020U,
    PRODUCT_SERVER_FOUNDATION                       = 0x00000021U,
    PRODUCT_HOME_PREMIUM_SERVER                     = 0x00000022U,
    PRODUCT_SERVER_FOR_SMALLBUSINESS_V              = 0x00000023U,
    PRODUCT_STANDARD_SERVER_V                       = 0x00000024U,
    PRODUCT_DATACENTER_SERVER_V                     = 0x00000025U,
    PRODUCT_ENTERPRISE_SERVER_V                     = 0x00000026U,
    PRODUCT_DATACENTER_SERVER_CORE_V                = 0x00000027U,
    PRODUCT_STANDARD_SERVER_CORE_V                  = 0x00000028U,
    PRODUCT_ENTERPRISE_SERVER_CORE_V                = 0x00000029U,
    PRODUCT_HYPERV                                  = 0x0000002aU,
    PRODUCT_STORAGE_EXPRESS_SERVER_CORE             = 0x0000002bU,
    PRODUCT_STORAGE_STANDARD_SERVER_CORE            = 0x0000002cU,
    PRODUCT_STORAGE_WORKGROUP_SERVER_CORE           = 0x0000002dU,
    PRODUCT_STORAGE_ENTERPRISE_SERVER_CORE          = 0x0000002eU,
    PRODUCT_STARTER_N                               = 0x0000002fU,
    PRODUCT_PROFESSIONAL                            = 0x00000030U,
    PRODUCT_PROFESSIONAL_N                          = 0x00000031U,
    PRODUCT_SB_SOLUTION_SERVER                      = 0x00000032U,
    PRODUCT_SERVER_FOR_SB_SOLUTIONS                 = 0x00000033U,
    PRODUCT_STANDARD_SERVER_SOLUTIONS               = 0x00000034U,
    PRODUCT_STANDARD_SERVER_SOLUTIONS_CORE          = 0x00000035U,
    PRODUCT_SB_SOLUTION_SERVER_EM                   = 0x00000036U,
    PRODUCT_SERVER_FOR_SB_SOLUTIONS_EM              = 0x00000037U,
    PRODUCT_SOLUTION_EMBEDDEDSERVER                 = 0x00000038U,
    PRODUCT_SOLUTION_EMBEDDEDSERVER_CORE            = 0x00000039U,
    PRODUCT_PROFESSIONAL_EMBEDDED                   = 0x0000003aU,
    PRODUCT_ESSENTIALBUSINESS_SERVER_MGMT           = 0x0000003bU,
    PRODUCT_ESSENTIALBUSINESS_SERVER_ADDL           = 0x0000003cU,
    PRODUCT_ESSENTIALBUSINESS_SERVER_MGMTSVC        = 0x0000003dU,
    PRODUCT_ESSENTIALBUSINESS_SERVER_ADDLSVC        = 0x0000003eU,
    PRODUCT_SMALLBUSINESS_SERVER_PREMIUM_CORE       = 0x0000003fU,
    PRODUCT_CLUSTER_SERVER_V                        = 0x00000040U,
    PRODUCT_EMBEDDED                                = 0x00000041U,
    PRODUCT_STARTER_E                               = 0x00000042U,
    PRODUCT_HOME_BASIC_E                            = 0x00000043U,
    PRODUCT_HOME_PREMIUM_E                          = 0x00000044U,
    PRODUCT_PROFESSIONAL_E                          = 0x00000045U,
    PRODUCT_ENTERPRISE_E                            = 0x00000046U,
    PRODUCT_ULTIMATE_E                              = 0x00000047U,
    PRODUCT_ENTERPRISE_EVALUATION                   = 0x00000048U,
    PRODUCT_MULTIPOINT_STANDARD_SERVER              = 0x0000004cU,
    PRODUCT_MULTIPOINT_PREMIUM_SERVER               = 0x0000004dU,
    PRODUCT_STANDARD_EVALUATION_SERVER              = 0x0000004fU,
    PRODUCT_DATACENTER_EVALUATION_SERVER            = 0x00000050U,
    PRODUCT_ENTERPRISE_N_EVALUATION                 = 0x00000054U,
    PRODUCT_EMBEDDED_AUTOMOTIVE                     = 0x00000055U,
    PRODUCT_EMBEDDED_INDUSTRY_A                     = 0x00000056U,
    PRODUCT_THINPC                                  = 0x00000057U,
    PRODUCT_EMBEDDED_A                              = 0x00000058U,
    PRODUCT_EMBEDDED_INDUSTRY                       = 0x00000059U,
    PRODUCT_EMBEDDED_E                              = 0x0000005aU,
    PRODUCT_EMBEDDED_INDUSTRY_E                     = 0x0000005bU,
    PRODUCT_EMBEDDED_INDUSTRY_A_E                   = 0x0000005cU,
    PRODUCT_STORAGE_WORKGROUP_EVALUATION_SERVER     = 0x0000005fU,
    PRODUCT_STORAGE_STANDARD_EVALUATION_SERVER      = 0x00000060U,
    PRODUCT_CORE_ARM                                = 0x00000061U,
    PRODUCT_CORE_N                                  = 0x00000062U,
    PRODUCT_CORE_COUNTRYSPECIFIC                    = 0x00000063U,
    PRODUCT_CORE_SINGLELANGUAGE                     = 0x00000064U,
    PRODUCT_CORE                                    = 0x00000065U,
    PRODUCT_PROFESSIONAL_WMC                        = 0x00000067U,
    PRODUCT_EMBEDDED_INDUSTRY_EVAL                  = 0x00000069U,
    PRODUCT_EMBEDDED_INDUSTRY_E_EVAL                = 0x0000006aU,
    PRODUCT_EMBEDDED_EVAL                           = 0x0000006bU,
    PRODUCT_EMBEDDED_E_EVAL                         = 0x0000006cU,
    PRODUCT_NANO_SERVER                             = 0x0000006dU,
    PRODUCT_CLOUD_STORAGE_SERVER                    = 0x0000006eU,
    PRODUCT_CORE_CONNECTED                          = 0x0000006fU,
    PRODUCT_PROFESSIONAL_STUDENT                    = 0x00000070U,
    PRODUCT_CORE_CONNECTED_N                        = 0x00000071U,
    PRODUCT_PROFESSIONAL_STUDENT_N                  = 0x00000072U,
    PRODUCT_CORE_CONNECTED_SINGLELANGUAGE           = 0x00000073U,
    PRODUCT_CORE_CONNECTED_COUNTRYSPECIFIC          = 0x00000074U,
    PRODUCT_CONNECTED_CAR                           = 0x00000075U,
    PRODUCT_INDUSTRY_HANDHELD                       = 0x00000076U,
    PRODUCT_PPI_PRO                                 = 0x00000077U,
    PRODUCT_ARM64_SERVER                            = 0x00000078U,
    PRODUCT_EDUCATION                               = 0x00000079U,
    PRODUCT_EDUCATION_N                             = 0x0000007aU,
    PRODUCT_IOTUAP                                  = 0x0000007bU,
    PRODUCT_CLOUD_HOST_INFRASTRUCTURE_SERVER        = 0x0000007cU,
    PRODUCT_ENTERPRISE_S                            = 0x0000007dU,
    PRODUCT_ENTERPRISE_S_N                          = 0x0000007eU,
    PRODUCT_PROFESSIONAL_S                          = 0x0000007fU,
    PRODUCT_PROFESSIONAL_S_N                        = 0x00000080U,
    PRODUCT_ENTERPRISE_S_EVALUATION                 = 0x00000081U,
    PRODUCT_ENTERPRISE_S_N_EVALUATION               = 0x00000082U,
    PRODUCT_HOLOGRAPHIC                             = 0x00000087U,
    PRODUCT_HOLOGRAPHIC_BUSINESS                    = 0x00000088U,
    PRODUCT_PRO_SINGLE_LANGUAGE                     = 0x0000008aU,
    PRODUCT_PRO_CHINA                               = 0x0000008bU,
    PRODUCT_ENTERPRISE_SUBSCRIPTION                 = 0x0000008cU,
    PRODUCT_ENTERPRISE_SUBSCRIPTION_N               = 0x0000008dU,
    PRODUCT_DATACENTER_NANO_SERVER                  = 0x0000008fU,
    PRODUCT_STANDARD_NANO_SERVER                    = 0x00000090U,
    PRODUCT_DATACENTER_A_SERVER_CORE                = 0x00000091U,
    PRODUCT_STANDARD_A_SERVER_CORE                  = 0x00000092U,
    PRODUCT_DATACENTER_WS_SERVER_CORE               = 0x00000093U,
    PRODUCT_STANDARD_WS_SERVER_CORE                 = 0x00000094U,
    PRODUCT_UTILITY_VM                              = 0x00000095U,
    PRODUCT_DATACENTER_EVALUATION_SERVER_CORE       = 0x0000009fU,
    PRODUCT_STANDARD_EVALUATION_SERVER_CORE         = 0x000000a0U,
    PRODUCT_PRO_WORKSTATION                         = 0x000000a1U,
    PRODUCT_PRO_WORKSTATION_N                       = 0x000000a2U,
    PRODUCT_PRO_FOR_EDUCATION                       = 0x000000a4U,
    PRODUCT_PRO_FOR_EDUCATION_N                     = 0x000000a5U,
    PRODUCT_AZURE_SERVER_CORE                       = 0x000000a8U,
    PRODUCT_AZURE_NANO_SERVER                       = 0x000000a9U,
    PRODUCT_ENTERPRISEG                             = 0x000000abU,
    PRODUCT_ENTERPRISEGN                            = 0x000000acU,
    PRODUCT_SERVERRDSH                              = 0x000000afU,
    PRODUCT_CLOUD                                   = 0x000000b2U,
    PRODUCT_CLOUDN                                  = 0x000000b3U,
    PRODUCT_HUBOS                                   = 0x000000b4U,
    PRODUCT_ONECOREUPDATEOS                         = 0x000000b6U,
    PRODUCT_CLOUDE                                  = 0x000000b7U,
    PRODUCT_IOTOS                                   = 0x000000b9U,
    PRODUCT_CLOUDEN                                 = 0x000000baU,
    PRODUCT_IOTEDGEOS                               = 0x000000bbU,
    PRODUCT_IOTENTERPRISE                           = 0x000000bcU,
    PRODUCT_LITE                                    = 0x000000bdU,
    PRODUCT_IOTENTERPRISES                          = 0x000000bfU,
    PRODUCT_XBOX_SYSTEMOS                           = 0x000000c0U,
    PRODUCT_XBOX_GAMEOS                             = 0x000000c2U,
    PRODUCT_XBOX_ERAOS                              = 0x000000c3U,
    PRODUCT_XBOX_DURANGOHOSTOS                      = 0x000000c4U,
    PRODUCT_XBOX_SCARLETTHOSTOS                     = 0x000000c5U,
    PRODUCT_XBOX_KEYSTONE                           = 0x000000c6U,
    PRODUCT_AZURE_SERVER_CLOUDHOST                  = 0x000000c7U,
    PRODUCT_AZURE_SERVER_CLOUDMOS                   = 0x000000c8U,
    PRODUCT_CLOUDEDITIONN                           = 0x000000caU,
    PRODUCT_CLOUDEDITION                            = 0x000000cbU,
    PRODUCT_VALIDATION                              = 0x000000ccU,
    PRODUCT_IOTENTERPRISESK                         = 0x000000cdU,
    PRODUCT_IOTENTERPRISEK                          = 0x000000ceU,
    PRODUCT_IOTENTERPRISESEVAL                      = 0x000000cfU,
    PRODUCT_AZURE_SERVER_AGENTBRIDGE                = 0x000000d0U,
    PRODUCT_AZURE_SERVER_NANOHOST                   = 0x000000d1U,
    PRODUCT_WNC                                     = 0x000000d2U,
    PRODUCT_AZURESTACKHCI_SERVER_CORE               = 0x00000196U,
    PRODUCT_DATACENTER_SERVER_AZURE_EDITION         = 0x00000197U,
    PRODUCT_DATACENTER_SERVER_CORE_AZURE_EDITION    = 0x00000198U,
    PRODUCT_DATACENTER_WS_SERVER_CORE_AZURE_EDITION = 0x00000199U,
    PRODUCT_UNLICENSED                              = 0xabcdabcdU,
}

alias DEVICEFAMILYINFOENUM = uint;
enum : uint
{
    DEVICEFAMILYINFOENUM_UAP                   = 0x00000000U,
    DEVICEFAMILYINFOENUM_WINDOWS_8X            = 0x00000001U,
    DEVICEFAMILYINFOENUM_WINDOWS_PHONE_8X      = 0x00000002U,
    DEVICEFAMILYINFOENUM_DESKTOP               = 0x00000003U,
    DEVICEFAMILYINFOENUM_MOBILE                = 0x00000004U,
    DEVICEFAMILYINFOENUM_XBOX                  = 0x00000005U,
    DEVICEFAMILYINFOENUM_TEAM                  = 0x00000006U,
    DEVICEFAMILYINFOENUM_IOT                   = 0x00000007U,
    DEVICEFAMILYINFOENUM_IOT_HEADLESS          = 0x00000008U,
    DEVICEFAMILYINFOENUM_SERVER                = 0x00000009U,
    DEVICEFAMILYINFOENUM_HOLOGRAPHIC           = 0x0000000aU,
    DEVICEFAMILYINFOENUM_XBOXSRA               = 0x0000000bU,
    DEVICEFAMILYINFOENUM_XBOXERA               = 0x0000000cU,
    DEVICEFAMILYINFOENUM_SERVER_NANO           = 0x0000000dU,
    DEVICEFAMILYINFOENUM_8828080               = 0x0000000eU,
    DEVICEFAMILYINFOENUM_7067329               = 0x0000000fU,
    DEVICEFAMILYINFOENUM_WINDOWS_CORE          = 0x00000010U,
    DEVICEFAMILYINFOENUM_WINDOWS_CORE_HEADLESS = 0x00000011U,
    DEVICEFAMILYINFOENUM_MAX                   = 0x00000011U,
}

alias DEVICEFAMILYDEVICEFORM = uint;
enum : uint
{
    DEVICEFAMILYDEVICEFORM_UNKNOWN               = 0x00000000U,
    DEVICEFAMILYDEVICEFORM_PHONE                 = 0x00000001U,
    DEVICEFAMILYDEVICEFORM_TABLET                = 0x00000002U,
    DEVICEFAMILYDEVICEFORM_DESKTOP               = 0x00000003U,
    DEVICEFAMILYDEVICEFORM_NOTEBOOK              = 0x00000004U,
    DEVICEFAMILYDEVICEFORM_CONVERTIBLE           = 0x00000005U,
    DEVICEFAMILYDEVICEFORM_DETACHABLE            = 0x00000006U,
    DEVICEFAMILYDEVICEFORM_ALLINONE              = 0x00000007U,
    DEVICEFAMILYDEVICEFORM_STICKPC               = 0x00000008U,
    DEVICEFAMILYDEVICEFORM_PUCK                  = 0x00000009U,
    DEVICEFAMILYDEVICEFORM_LARGESCREEN           = 0x0000000aU,
    DEVICEFAMILYDEVICEFORM_HMD                   = 0x0000000bU,
    DEVICEFAMILYDEVICEFORM_INDUSTRY_HANDHELD     = 0x0000000cU,
    DEVICEFAMILYDEVICEFORM_INDUSTRY_TABLET       = 0x0000000dU,
    DEVICEFAMILYDEVICEFORM_BANKING               = 0x0000000eU,
    DEVICEFAMILYDEVICEFORM_BUILDING_AUTOMATION   = 0x0000000fU,
    DEVICEFAMILYDEVICEFORM_DIGITAL_SIGNAGE       = 0x00000010U,
    DEVICEFAMILYDEVICEFORM_GAMING                = 0x00000011U,
    DEVICEFAMILYDEVICEFORM_HOME_AUTOMATION       = 0x00000012U,
    DEVICEFAMILYDEVICEFORM_INDUSTRIAL_AUTOMATION = 0x00000013U,
    DEVICEFAMILYDEVICEFORM_KIOSK                 = 0x00000014U,
    DEVICEFAMILYDEVICEFORM_MAKER_BOARD           = 0x00000015U,
    DEVICEFAMILYDEVICEFORM_MEDICAL               = 0x00000016U,
    DEVICEFAMILYDEVICEFORM_NETWORKING            = 0x00000017U,
    DEVICEFAMILYDEVICEFORM_POINT_OF_SERVICE      = 0x00000018U,
    DEVICEFAMILYDEVICEFORM_PRINTING              = 0x00000019U,
    DEVICEFAMILYDEVICEFORM_THIN_CLIENT           = 0x0000001aU,
    DEVICEFAMILYDEVICEFORM_TOY                   = 0x0000001bU,
    DEVICEFAMILYDEVICEFORM_VENDING               = 0x0000001cU,
    DEVICEFAMILYDEVICEFORM_INDUSTRY_OTHER        = 0x0000001dU,
    DEVICEFAMILYDEVICEFORM_XBOX_ONE              = 0x0000001eU,
    DEVICEFAMILYDEVICEFORM_XBOX_ONE_S            = 0x0000001fU,
    DEVICEFAMILYDEVICEFORM_XBOX_ONE_X            = 0x00000020U,
    DEVICEFAMILYDEVICEFORM_XBOX_ONE_X_DEVKIT     = 0x00000021U,
    DEVICEFAMILYDEVICEFORM_XBOX_SERIES_X         = 0x00000022U,
    DEVICEFAMILYDEVICEFORM_XBOX_SERIES_X_DEVKIT  = 0x00000023U,
    DEVICEFAMILYDEVICEFORM_XBOX_SERIES_S         = 0x00000024U,
    DEVICEFAMILYDEVICEFORM_XBOX_RESERVED_01      = 0x00000025U,
    DEVICEFAMILYDEVICEFORM_XBOX_RESERVED_02      = 0x00000026U,
    DEVICEFAMILYDEVICEFORM_XBOX_RESERVED_03      = 0x00000027U,
    DEVICEFAMILYDEVICEFORM_XBOX_RESERVED_04      = 0x00000028U,
    DEVICEFAMILYDEVICEFORM_XBOX_RESERVED_05      = 0x00000029U,
    DEVICEFAMILYDEVICEFORM_XBOX_RESERVED_06      = 0x0000002aU,
    DEVICEFAMILYDEVICEFORM_XBOX_RESERVED_07      = 0x0000002bU,
    DEVICEFAMILYDEVICEFORM_XBOX_RESERVED_08      = 0x0000002cU,
    DEVICEFAMILYDEVICEFORM_XBOX_RESERVED_09      = 0x0000002dU,
    DEVICEFAMILYDEVICEFORM_GAMING_HANDHELD       = 0x0000002eU,
    DEVICEFAMILYDEVICEFORM_GAMING_CONSOLE        = 0x0000002fU,
    DEVICEFAMILYDEVICEFORM_MAX                   = 0x0000002fU,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sysinfoapi/ne-sysinfoapi-computer_name_format
alias COMPUTER_NAME_FORMAT = int;
enum : int
{
    ComputerNameNetBIOS                   = 0x00000000,
    ComputerNameDnsHostname               = 0x00000001,
    ComputerNameDnsDomain                 = 0x00000002,
    ComputerNameDnsFullyQualified         = 0x00000003,
    ComputerNamePhysicalNetBIOS           = 0x00000004,
    ComputerNamePhysicalDnsHostname       = 0x00000005,
    ComputerNamePhysicalDnsDomain         = 0x00000006,
    ComputerNamePhysicalDnsFullyQualified = 0x00000007,
    ComputerNameMax                       = 0x00000008,
}

alias DEVELOPER_DRIVE_ENABLEMENT_STATE = int;
enum : int
{
    DeveloperDriveEnablementStateError   = 0x00000000,
    DeveloperDriveEnabled                = 0x00000001,
    DeveloperDriveDisabledBySystemPolicy = 0x00000002,
    DeveloperDriveDisabledByGroupPolicy  = 0x00000003,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winnt/ne-winnt-firmware_type
alias FIRMWARE_TYPE = int;
enum : int
{
    FirmwareTypeUnknown = 0x00000000,
    FirmwareTypeBios    = 0x00000001,
    FirmwareTypeUefi    = 0x00000002,
    FirmwareTypeMax     = 0x00000003,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winnt/ne-winnt-logical_processor_relationship
alias LOGICAL_PROCESSOR_RELATIONSHIP = int;
enum : int
{
    RelationProcessorCore    = 0x00000000,
    RelationNumaNode         = 0x00000001,
    RelationCache            = 0x00000002,
    RelationProcessorPackage = 0x00000003,
    RelationGroup            = 0x00000004,
    RelationProcessorDie     = 0x00000005,
    RelationNumaNodeEx       = 0x00000006,
    RelationProcessorModule  = 0x00000007,
    RelationAll              = 0x0000ffff,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winnt/ne-winnt-processor_cache_type
alias PROCESSOR_CACHE_TYPE = int;
enum : int
{
    CacheUnified     = 0x00000000,
    CacheInstruction = 0x00000001,
    CacheData        = 0x00000002,
    CacheTrace       = 0x00000003,
    CacheUnknown     = 0x00000004,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/ProcThread/cpu-set-information-type
alias CPU_SET_INFORMATION_TYPE = int;
enum : int
{
    CpuSetInformation = 0x00000000,
}

alias OS_DEPLOYEMENT_STATE_VALUES = int;
enum : int
{
    OS_DEPLOYMENT_STANDARD = 0x00000001,
    OS_DEPLOYMENT_COMPACT  = 0x00000002,
}

alias RTL_SYSTEM_GLOBAL_DATA_ID = int;
enum : int
{
    GlobalDataIdUnknown                     = 0x00000000,
    GlobalDataIdRngSeedVersion              = 0x00000001,
    GlobalDataIdInterruptTime               = 0x00000002,
    GlobalDataIdTimeZoneBias                = 0x00000003,
    GlobalDataIdImageNumberLow              = 0x00000004,
    GlobalDataIdImageNumberHigh             = 0x00000005,
    GlobalDataIdTimeZoneId                  = 0x00000006,
    GlobalDataIdNtMajorVersion              = 0x00000007,
    GlobalDataIdNtMinorVersion              = 0x00000008,
    GlobalDataIdSystemExpirationDate        = 0x00000009,
    GlobalDataIdKdDebuggerEnabled           = 0x0000000a,
    GlobalDataIdCyclesPerYield              = 0x0000000b,
    GlobalDataIdSafeBootMode                = 0x0000000c,
    GlobalDataIdLastSystemRITEventTickCount = 0x0000000d,
    GlobalDataIdConsoleSharedDataFlags      = 0x0000000e,
    GlobalDataIdNtSystemRootDrive           = 0x0000000f,
    GlobalDataIdQpcBypassEnabled            = 0x00000010,
    GlobalDataIdQpcData                     = 0x00000011,
    GlobalDataIdQpcBias                     = 0x00000012,
}

alias DEP_SYSTEM_POLICY_TYPE = int;
enum : int
{
    DEPPolicyAlwaysOff  = 0x00000000,
    DEPPolicyAlwaysOn   = 0x00000001,
    DEPPolicyOptIn      = 0x00000002,
    DEPPolicyOptOut     = 0x00000003,
    DEPTotalPolicyCount = 0x00000004,
}

// Constants


enum : uint
{
    NTDDI_WIN2K        = 0x05000000U,
    NTDDI_WINXP        = 0x05010000U,
    NTDDI_WINXPSP2     = 0x05010200U,
    NTDDI_WS03SP1      = 0x05020100U,
    NTDDI_VISTA        = 0x06000000U,
    NTDDI_VISTASP1     = 0x06000100U,
    NTDDI_WIN7         = 0x06010000U,
    NTDDI_WIN8         = 0x06020000U,
    NTDDI_WINBLUE      = 0x06030000U,
    NTDDI_WINTHRESHOLD = 0x0a000000U,
}

enum : uint
{
    SYSTEM_CPU_SET_INFORMATION_PARKED                      = 0x00000001U,
    SYSTEM_CPU_SET_INFORMATION_ALLOCATED                   = 0x00000002U,
    SYSTEM_CPU_SET_INFORMATION_ALLOCATED_TO_TARGET_PROCESS = 0x00000004U,
    SYSTEM_CPU_SET_INFORMATION_REALTIME                    = 0x00000008U,
}

enum : uint
{
    _WIN32_WINNT_NT4          = 0x00000400U,
    _WIN32_WINNT_WIN2K        = 0x00000500U,
    _WIN32_WINNT_WINXP        = 0x00000501U,
    _WIN32_WINNT_WS03         = 0x00000502U,
    _WIN32_WINNT_WIN6         = 0x00000600U,
    _WIN32_WINNT_VISTA        = 0x00000600U,
    _WIN32_WINNT_WS08         = 0x00000600U,
    _WIN32_WINNT_LONGHORN     = 0x00000600U,
    _WIN32_WINNT_WIN7         = 0x00000601U,
    _WIN32_WINNT_WIN8         = 0x00000602U,
    _WIN32_WINNT_WINBLUE      = 0x00000603U,
    _WIN32_WINNT_WINTHRESHOLD = 0x00000a00U,
    _WIN32_WINNT_WIN10        = 0x00000a00U,
}

enum : uint
{
    _WIN32_IE_IE20         = 0x00000200U,
    _WIN32_IE_IE30         = 0x00000300U,
    _WIN32_IE_IE302        = 0x00000302U,
    _WIN32_IE_IE40         = 0x00000400U,
    _WIN32_IE_IE401        = 0x00000401U,
    _WIN32_IE_IE50         = 0x00000500U,
    _WIN32_IE_IE501        = 0x00000501U,
    _WIN32_IE_IE55         = 0x00000550U,
    _WIN32_IE_IE60         = 0x00000600U,
    _WIN32_IE_IE60SP1      = 0x00000601U,
    _WIN32_IE_IE60SP2      = 0x00000603U,
    _WIN32_IE_IE70         = 0x00000700U,
    _WIN32_IE_IE80         = 0x00000800U,
    _WIN32_IE_IE90         = 0x00000900U,
    _WIN32_IE_IE100        = 0x00000a00U,
    _WIN32_IE_IE110        = 0x00000a00U,
    _WIN32_IE_NT4          = 0x00000200U,
    _WIN32_IE_NT4SP1       = 0x00000200U,
    _WIN32_IE_NT4SP2       = 0x00000200U,
    _WIN32_IE_NT4SP3       = 0x00000302U,
    _WIN32_IE_NT4SP4       = 0x00000401U,
    _WIN32_IE_NT4SP5       = 0x00000401U,
    _WIN32_IE_NT4SP6       = 0x00000500U,
    _WIN32_IE_WIN98        = 0x00000401U,
    _WIN32_IE_WIN98SE      = 0x00000500U,
    _WIN32_IE_WINME        = 0x00000550U,
    _WIN32_IE_WIN2K        = 0x00000501U,
    _WIN32_IE_WIN2KSP1     = 0x00000501U,
    _WIN32_IE_WIN2KSP2     = 0x00000501U,
    _WIN32_IE_WIN2KSP3     = 0x00000501U,
    _WIN32_IE_WIN2KSP4     = 0x00000501U,
    _WIN32_IE_XP           = 0x00000600U,
    _WIN32_IE_XPSP1        = 0x00000601U,
    _WIN32_IE_XPSP2        = 0x00000603U,
    _WIN32_IE_WS03         = 0x00000602U,
    _WIN32_IE_WS03SP1      = 0x00000603U,
    _WIN32_IE_WIN6         = 0x00000700U,
    _WIN32_IE_LONGHORN     = 0x00000700U,
    _WIN32_IE_WIN7         = 0x00000800U,
    _WIN32_IE_WIN8         = 0x00000a00U,
    _WIN32_IE_WINBLUE      = 0x00000a00U,
    _WIN32_IE_WINTHRESHOLD = 0x00000a00U,
    _WIN32_IE_WIN10        = 0x00000a00U,
}

enum : uint
{
    NTDDI_WIN4       = 0x04000000U,
    NTDDI_WIN2KSP1   = 0x05000100U,
    NTDDI_WIN2KSP2   = 0x05000200U,
    NTDDI_WIN2KSP3   = 0x05000300U,
    NTDDI_WIN2KSP4   = 0x05000400U,
    NTDDI_WINXPSP1   = 0x05010100U,
    NTDDI_WINXPSP3   = 0x05010300U,
    NTDDI_WINXPSP4   = 0x05010400U,
    NTDDI_WS03       = 0x05020000U,
    NTDDI_WS03SP2    = 0x05020200U,
    NTDDI_WS03SP3    = 0x05020300U,
    NTDDI_WS03SP4    = 0x05020400U,
    NTDDI_WIN6       = 0x06000000U,
    NTDDI_WIN6SP1    = 0x06000100U,
    NTDDI_WIN6SP2    = 0x06000200U,
    NTDDI_WIN6SP3    = 0x06000300U,
    NTDDI_WIN6SP4    = 0x06000400U,
    NTDDI_VISTASP2   = 0x06000200U,
    NTDDI_VISTASP3   = 0x06000300U,
    NTDDI_VISTASP4   = 0x06000400U,
    NTDDI_LONGHORN   = 0x06000000U,
    NTDDI_WS08       = 0x06000100U,
    NTDDI_WS08SP2    = 0x06000200U,
    NTDDI_WS08SP3    = 0x06000300U,
    NTDDI_WS08SP4    = 0x06000400U,
    NTDDI_WIN10      = 0x0a000000U,
    NTDDI_WIN10_TH2  = 0x0a000001U,
    NTDDI_WIN10_RS1  = 0x0a000002U,
    NTDDI_WIN10_RS2  = 0x0a000003U,
    NTDDI_WIN10_RS3  = 0x0a000004U,
    NTDDI_WIN10_RS4  = 0x0a000005U,
    NTDDI_WIN10_RS5  = 0x0a000006U,
    NTDDI_WIN10_19H1 = 0x0a000007U,
    NTDDI_WIN10_VB   = 0x0a000008U,
    NTDDI_WIN10_MN   = 0x0a000009U,
    NTDDI_WIN10_FE   = 0x0a00000aU,
    NTDDI_WIN10_CO   = 0x0a00000bU,
    NTDDI_WIN10_NI   = 0x0a00000cU,
    NTDDI_WIN10_CU   = 0x0a00000dU,
    NTDDI_WIN11_ZN   = 0x0a00000eU,
    NTDDI_WIN11_GA   = 0x0a00000fU,
    NTDDI_WIN11_GE   = 0x0a000010U,
}

enum uint WDK_NTDDI_VERSION = 0x0a000010U;
enum uint OSVERSION_MASK = 0xffff0000U;
enum uint SPVERSION_MASK = 0x0000ff00U;
enum uint SUBVERSION_MASK = 0x000000ffU;
enum uint NTDDI_VERSION = 0x0a000010U;
enum uint SCEX2_ALT_NETBIOS_NAME = 0x00000001U;

// Callbacks

alias PGET_SYSTEM_WOW64_DIRECTORY_A = uint function(PSTR lpBuffer, uint uSize);
alias PGET_SYSTEM_WOW64_DIRECTORY_W = uint function(PWSTR lpBuffer, uint uSize);

// Structs


// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winnt/ns-winnt-group_affinity
struct GROUP_AFFINITY
{
    size_t    Mask;
    ushort    Group;
    ushort[3] Reserved;
}

struct GROUP_AFFINITY32
{
    uint      Mask;
    ushort    Group;
    ushort[3] Reserved;
}

struct GROUP_AFFINITY64
{
    ulong     Mask;
    ushort    Group;
    ushort[3] Reserved;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sysinfoapi/ns-sysinfoapi-system_info
struct SYSTEM_INFO
{
    union
    {
        uint dwOemId;
        struct
        {
            PROCESSOR_ARCHITECTURE wProcessorArchitecture;
            ushort wReserved;
        }
    }
    uint   dwPageSize;
    void*  lpMinimumApplicationAddress;
    void*  lpMaximumApplicationAddress;
    size_t dwActiveProcessorMask;
    uint   dwNumberOfProcessors;
    uint   dwProcessorType;
    uint   dwAllocationGranularity;
    ushort wProcessorLevel;
    ushort wProcessorRevision;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sysinfoapi/ns-sysinfoapi-memorystatusex
struct MEMORYSTATUSEX
{
    uint  dwLength;
    uint  dwMemoryLoad;
    ulong ullTotalPhys;
    ulong ullAvailPhys;
    ulong ullTotalPageFile;
    ulong ullAvailPageFile;
    ulong ullTotalVirtual;
    ulong ullAvailVirtual;
    ulong ullAvailExtendedVirtual;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winnt/ns-winnt-cache_descriptor
struct CACHE_DESCRIPTOR
{
    ubyte                Level;
    ubyte                Associativity;
    ushort               LineSize;
    uint                 Size;
    PROCESSOR_CACHE_TYPE Type;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winnt/ns-winnt-system_logical_processor_information
struct SYSTEM_LOGICAL_PROCESSOR_INFORMATION
{
    size_t ProcessorMask;
    LOGICAL_PROCESSOR_RELATIONSHIP Relationship;
    union
    {
        struct ProcessorCore
        {
            ubyte Flags;
        }
        struct NumaNode
        {
            uint NodeNumber;
        }
        CACHE_DESCRIPTOR Cache;
        ulong[2]         Reserved;
    }
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winnt/ns-winnt-processor_relationship
struct PROCESSOR_RELATIONSHIP
{
    ubyte             Flags;
    ubyte             EfficiencyClass;
    ubyte[20]         Reserved;
    ushort            GroupCount;
    GROUP_AFFINITY[1] GroupMask; // Flexible array
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winnt/ns-winnt-numa_node_relationship
struct NUMA_NODE_RELATIONSHIP
{
    uint      NodeNumber;
    ubyte[18] Reserved;
    ushort    GroupCount;
    union
    {
        GROUP_AFFINITY    GroupMask;
        GROUP_AFFINITY[1] GroupMasks; // Flexible array
    }
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winnt/ns-winnt-cache_relationship
struct CACHE_RELATIONSHIP
{
    ubyte                Level;
    ubyte                Associativity;
    ushort               LineSize;
    uint                 CacheSize;
    PROCESSOR_CACHE_TYPE Type;
    ubyte[18]            Reserved;
    ushort               GroupCount;
    union
    {
        GROUP_AFFINITY    GroupMask;
        GROUP_AFFINITY[1] GroupMasks; // Flexible array
    }
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winnt/ns-winnt-processor_group_info
struct PROCESSOR_GROUP_INFO
{
    ubyte     MaximumProcessorCount;
    ubyte     ActiveProcessorCount;
    ubyte[38] Reserved;
    size_t    ActiveProcessorMask;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winnt/ns-winnt-group_relationship
struct GROUP_RELATIONSHIP
{
    ushort    MaximumGroupCount;
    ushort    ActiveGroupCount;
    ubyte[20] Reserved;
    PROCESSOR_GROUP_INFO[1] GroupInfo; // Flexible array
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winnt/ns-winnt-system_logical_processor_information_ex
struct SYSTEM_LOGICAL_PROCESSOR_INFORMATION_EX
{
    LOGICAL_PROCESSOR_RELATIONSHIP Relationship;
    uint Size;
    union
    {
        PROCESSOR_RELATIONSHIP Processor;
        NUMA_NODE_RELATIONSHIP NumaNode;
        CACHE_RELATIONSHIP Cache;
        GROUP_RELATIONSHIP Group;
    }
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winnt/ns-winnt-system_cpu_set_information
struct SYSTEM_CPU_SET_INFORMATION
{
    uint Size;
    CPU_SET_INFORMATION_TYPE Type;
    union
    {
        struct CpuSet
        {
            uint   Id;
            ushort Group;
            ubyte  LogicalProcessorIndex;
            ubyte  CoreIndex;
            ubyte  LastLevelCacheIndex;
            ubyte  NumaNodeIndex;
            ubyte  EfficiencyClass;
            union
            {
                ubyte AllFlags;
                struct
                {
                    // Native bit field: Parked: [0], Allocated: [1], AllocatedToTargetProcess: [2], RealTime: [3], ReservedFlags: [4-7]
                    ubyte _bitfield0;
                }
            }
            union
            {
                uint  Reserved;
                ubyte SchedulingClass;
            }
            ulong  AllocationTag;
        }
    }
}

struct SYSTEM_POOL_ZEROING_INFORMATION
{
    BOOLEAN PoolZeroingSupportPresent;
}

struct SYSTEM_PROCESSOR_CYCLE_TIME_INFORMATION
{
    ulong CycleTime;
}

struct SYSTEM_SUPPORTED_PROCESSOR_ARCHITECTURES_INFORMATION
{
    // Native bit field: Machine: [0-15], KernelMode: [16], UserMode: [17], Native: [18], Process: [19], WoW64Container: [20], ReservedZero0: [21-31]
    uint _bitfield0;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winnt/ns-winnt-osversioninfoa
struct OSVERSIONINFOA
{
    uint      dwOSVersionInfoSize;
    uint      dwMajorVersion;
    uint      dwMinorVersion;
    uint      dwBuildNumber;
    uint      dwPlatformId;
    CHAR[128] szCSDVersion;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winnt/ns-winnt-osversioninfow
struct OSVERSIONINFOW
{
    uint       dwOSVersionInfoSize;
    uint       dwMajorVersion;
    uint       dwMinorVersion;
    uint       dwBuildNumber;
    uint       dwPlatformId;
    wchar[128] szCSDVersion;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winnt/ns-winnt-osversioninfoexa
struct OSVERSIONINFOEXA
{
    uint      dwOSVersionInfoSize;
    uint      dwMajorVersion;
    uint      dwMinorVersion;
    uint      dwBuildNumber;
    uint      dwPlatformId;
    CHAR[128] szCSDVersion;
    ushort    wServicePackMajor;
    ushort    wServicePackMinor;
    ushort    wSuiteMask;
    ubyte     wProductType;
    ubyte     wReserved;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winnt/ns-winnt-osversioninfoexw
struct OSVERSIONINFOEXW
{
    uint       dwOSVersionInfoSize;
    uint       dwMajorVersion;
    uint       dwMinorVersion;
    uint       dwBuildNumber;
    uint       dwPlatformId;
    wchar[128] szCSDVersion;
    ushort     wServicePackMajor;
    ushort     wServicePackMinor;
    ushort     wSuiteMask;
    ubyte      wProductType;
    ubyte      wReserved;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winbase/ns-winbase-memorystatus
struct MEMORYSTATUS
{
    uint   dwLength;
    uint   dwMemoryLoad;
    size_t dwTotalPhys;
    size_t dwAvailPhys;
    size_t dwTotalPageFile;
    size_t dwAvailPageFile;
    size_t dwTotalVirtual;
    size_t dwAvailVirtual;
}

// Functions

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
BOOL GlobalMemoryStatusEx(MEMORYSTATUSEX* lpBuffer);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("KERNEL32.dll")
void GetSystemInfo(SYSTEM_INFO* lpSystemInfo);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("KERNEL32.dll")
void GetSystemTime(SYSTEMTIME* lpSystemTime);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("KERNEL32.dll")
void GetSystemTimeAsFileTime(FILETIME* lpSystemTimeAsFileTime);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("KERNEL32.dll")
void GetLocalTime(SYSTEMTIME* lpSystemTime);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sysinfoapi/nf-sysinfoapi-isusercetavailableinenvironment
@DllImport("KERNEL32.dll")
BOOL IsUserCetAvailableInEnvironment(USER_CET_ENVIRONMENT UserCetEnvironment);

@DllImport("KERNEL32.dll")
BOOL GetSystemLeapSecondInformation(BOOL* Enabled, uint* Flags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("KERNEL32.dll")
uint GetVersion();

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("KERNEL32.dll")
BOOL SetLocalTime(const(SYSTEMTIME)* lpSystemTime);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("KERNEL32.dll")
uint GetTickCount();

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("KERNEL32.dll")
ulong GetTickCount64();

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("KERNEL32.dll")
BOOL GetSystemTimeAdjustment(uint* lpTimeAdjustment, uint* lpTimeIncrement, BOOL* lpTimeAdjustmentDisabled);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.10240))], [])
@DllImport("api-ms-win-core-sysinfo-l1-2-4.dll")
BOOL GetSystemTimeAdjustmentPrecise(ulong* lpTimeAdjustment, ulong* lpTimeIncrement, 
                                    BOOL* lpTimeAdjustmentDisabled);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("KERNEL32.dll")
uint GetSystemDirectoryA(PSTR lpBuffer, uint uSize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("KERNEL32.dll")
uint GetSystemDirectoryW(PWSTR lpBuffer, uint uSize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("KERNEL32.dll")
uint GetWindowsDirectoryA(PSTR lpBuffer, uint uSize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("KERNEL32.dll")
uint GetWindowsDirectoryW(PWSTR lpBuffer, uint uSize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("KERNEL32.dll")
uint GetSystemWindowsDirectoryA(PSTR lpBuffer, uint uSize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("KERNEL32.dll")
uint GetSystemWindowsDirectoryW(PWSTR lpBuffer, uint uSize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("KERNEL32.dll")
BOOL GetComputerNameExA(COMPUTER_NAME_FORMAT NameType, PSTR lpBuffer, uint* nSize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("KERNEL32.dll")
BOOL GetComputerNameExW(COMPUTER_NAME_FORMAT NameType, PWSTR lpBuffer, uint* nSize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("KERNEL32.dll")
BOOL SetComputerNameExW(COMPUTER_NAME_FORMAT NameType, const(PWSTR) lpBuffer);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("KERNEL32.dll")
BOOL SetSystemTime(const(SYSTEMTIME)* lpSystemTime);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("KERNEL32.dll")
BOOL GetVersionExA(OSVERSIONINFOA* lpVersionInformation);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("KERNEL32.dll")
BOOL GetVersionExW(OSVERSIONINFOW* lpVersionInformation);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("KERNEL32.dll")
BOOL GetLogicalProcessorInformation(/*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/SYSTEM_LOGICAL_PROCESSOR_INFORMATION* Buffer, 
                                    uint* ReturnedLength);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
@DllImport("KERNEL32.dll")
BOOL GetLogicalProcessorInformationEx(LOGICAL_PROCESSOR_RELATIONSHIP RelationshipType, 
                                      /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/SYSTEM_LOGICAL_PROCESSOR_INFORMATION_EX* Buffer, 
                                      uint* ReturnedLength);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
void GetNativeSystemInfo(SYSTEM_INFO* lpSystemInfo);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("KERNEL32.dll")
void GetSystemTimePreciseAsFileTime(FILETIME* lpSystemTimeAsFileTime);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("KERNEL32.dll")
BOOL GetProductInfo(uint dwOSMajorVersion, uint dwOSMinorVersion, uint dwSpMajorVersion, uint dwSpMinorVersion, 
                    OS_PRODUCT_TYPE* pdwReturnedProductType);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("KERNEL32.dll")
ulong VerSetConditionMask(ulong ConditionMask, VER_FLAGS TypeMask, ubyte Condition);

@DllImport("api-ms-win-core-sysinfo-l1-2-0.dll")
BOOL GetOsSafeBootMode(uint* Flags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("KERNEL32.dll")
uint EnumSystemFirmwareTables(FIRMWARE_TABLE_PROVIDER FirmwareTableProviderSignature, 
                              /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/ubyte* pFirmwareTableEnumBuffer, 
                              uint BufferSize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("KERNEL32.dll")
uint GetSystemFirmwareTable(FIRMWARE_TABLE_PROVIDER FirmwareTableProviderSignature, uint FirmwareTableID, 
                            /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/ubyte* pFirmwareTableBuffer, 
                            uint BufferSize);

@DllImport("KERNEL32.dll")
BOOL DnsHostnameToComputerNameExW(const(PWSTR) Hostname, PWSTR ComputerName, uint* nSize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("KERNEL32.dll")
BOOL GetPhysicallyInstalledSystemMemory(ulong* TotalMemoryInKilobytes);

@DllImport("KERNEL32.dll")
BOOL SetComputerNameEx2W(COMPUTER_NAME_FORMAT NameType, uint Flags, const(PWSTR) lpBuffer);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("KERNEL32.dll")
BOOL SetSystemTimeAdjustment(uint dwTimeAdjustment, BOOL bTimeAdjustmentDisabled);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.10240))], [])
@DllImport("api-ms-win-core-sysinfo-l1-2-4.dll")
BOOL SetSystemTimeAdjustmentPrecise(ulong dwTimeAdjustment, BOOL bTimeAdjustmentDisabled);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
@DllImport("KERNEL32.dll")
BOOL GetProcessorSystemCycleTime(ushort Group, 
                                 /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/SYSTEM_PROCESSOR_CYCLE_TIME_INFORMATION* Buffer, 
                                 uint* ReturnedLength);

@DllImport("api-ms-win-core-sysinfo-l1-2-3.dll")
BOOL GetOsManufacturingMode(BOOL* pbEnabled);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.10240))], [])
@DllImport("api-ms-win-core-sysinfo-l1-2-3.dll")
HRESULT GetIntegratedDisplaySize(double* sizeInInches);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("KERNEL32.dll")
BOOL SetComputerNameA(const(PSTR) lpComputerName);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("KERNEL32.dll")
BOOL SetComputerNameW(const(PWSTR) lpComputerName);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("KERNEL32.dll")
BOOL SetComputerNameExA(COMPUTER_NAME_FORMAT NameType, const(PSTR) lpBuffer);

@DllImport("api-ms-win-core-sysinfo-l1-2-6.dll")
DEVELOPER_DRIVE_ENABLEMENT_STATE GetDeveloperDriveEnablementState();

@DllImport("KERNEL32.dll")
BOOL GetRuntimeAttestationReport(ubyte* Nonce, ushort PackageVersion, ulong ReportTypesBitmap, 
                                 /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/void* ReportBuffer, 
                                 uint* ReportBufferSize);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/ProcThread/getsystemcpusetinformation
@DllImport("KERNEL32.dll")
BOOL GetSystemCpuSetInformation(/*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/SYSTEM_CPU_SET_INFORMATION* Information, 
                                uint BufferLength, uint* ReturnedLength, HANDLE Process, 
                                /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/uint Flags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
uint GetSystemWow64DirectoryA(PSTR lpBuffer, uint uSize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
uint GetSystemWow64DirectoryW(PWSTR lpBuffer, uint uSize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.10586))], [])
@DllImport("api-ms-win-core-wow64-l1-1-1.dll")
uint GetSystemWow64Directory2A(PSTR lpBuffer, uint uSize, IMAGE_FILE_MACHINE ImageFileMachineType);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.10586))], [])
@DllImport("api-ms-win-core-wow64-l1-1-1.dll")
uint GetSystemWow64Directory2W(PWSTR lpBuffer, uint uSize, IMAGE_FILE_MACHINE ImageFileMachineType);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.16299))], [])
@DllImport("KERNEL32.dll")
HRESULT IsWow64GuestMachineSupported(IMAGE_FILE_MACHINE WowGuestMachine, BOOL* MachineIsSupported);

@DllImport("ntdll.dll")
BOOLEAN RtlGetProductInfo(uint OSMajorVersion, uint OSMinorVersion, uint SpMajorVersion, uint SpMinorVersion, 
                          uint* ReturnedProductType);

@DllImport("ntdll.dll")
OS_DEPLOYEMENT_STATE_VALUES RtlOsDeploymentState(uint Flags);

@DllImport("ntdllk.dll")
uint RtlGetSystemGlobalData(RTL_SYSTEM_GLOBAL_DATA_ID DataId, void* Buffer, uint Size);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/DevNotes/rtlgetdevicefamilyinfoenum
@DllImport("ntdll.dll")
void RtlGetDeviceFamilyInfoEnum(ulong* pullUAPInfo, DEVICEFAMILYINFOENUM* pulDeviceFamily, 
                                DEVICEFAMILYDEVICEFORM* pulDeviceForm);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winnt/nf-winnt-rtlconvertdevicefamilyinfotostring
@DllImport("ntdll.dll")
uint RtlConvertDeviceFamilyInfoToString(uint* pulDeviceFamilyBufferSize, uint* pulDeviceFormBufferSize, 
                                        /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(0)))])*/PWSTR DeviceFamily, 
                                        /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/PWSTR DeviceForm);

@DllImport("ntdll.dll")
uint RtlSwitchedVVI(OSVERSIONINFOEXW* VersionInfo, uint TypeMask, ulong ConditionMask);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
void GlobalMemoryStatus(MEMORYSTATUS* lpBuffer);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("KERNEL32.dll")
DEP_SYSTEM_POLICY_TYPE GetSystemDEPPolicy();

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("KERNEL32.dll")
BOOL GetFirmwareType(FIRMWARE_TYPE* FirmwareType);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("KERNEL32.dll")
BOOL VerifyVersionInfoA(OSVERSIONINFOEXA* lpVersionInformation, VER_FLAGS dwTypeMask, ulong dwlConditionMask);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("KERNEL32.dll")
BOOL VerifyVersionInfoW(OSVERSIONINFOEXW* lpVersionInformation, VER_FLAGS dwTypeMask, ulong dwlConditionMask);


