// Written in the D programming language.

module windows.win32.system.tpmbaseservices;

public import windows.core;
public import windows.win32.foundation : BOOL, HRESULT, PWSTR;

extern(Windows) @nogc nothrow:


// Enums


alias TBS_COMMAND_PRIORITY = uint;
enum : uint
{
    TBS_COMMAND_PRIORITY_LOW    = 0x00000064U,
    TBS_COMMAND_PRIORITY_NORMAL = 0x000000c8U,
    TBS_COMMAND_PRIORITY_SYSTEM = 0x00000190U,
    TBS_COMMAND_PRIORITY_HIGH   = 0x0000012cU,
    TBS_COMMAND_PRIORITY_MAX    = 0x80000000U,
}

alias TBS_COMMAND_LOCALITY = uint;
enum : uint
{
    TBS_COMMAND_LOCALITY_ZERO  = 0x00000000U,
    TBS_COMMAND_LOCALITY_ONE   = 0x00000001U,
    TBS_COMMAND_LOCALITY_TWO   = 0x00000002U,
    TBS_COMMAND_LOCALITY_THREE = 0x00000003U,
    TBS_COMMAND_LOCALITY_FOUR  = 0x00000004U,
}

// Constants


enum uint TBS_CONTEXT_VERSION_ONE = 0x00000001U;
enum uint TBS_SUCCESS = 0x00000000U;

enum : uint
{
    TBS_OWNERAUTH_TYPE_FULL           = 0x00000001U,
    TBS_OWNERAUTH_TYPE_ADMIN          = 0x00000002U,
    TBS_OWNERAUTH_TYPE_USER           = 0x00000003U,
    TBS_OWNERAUTH_TYPE_ENDORSEMENT    = 0x00000004U,
    TBS_OWNERAUTH_TYPE_ENDORSEMENT_20 = 0x0000000cU,
    TBS_OWNERAUTH_TYPE_STORAGE_20     = 0x0000000dU,
}

enum uint TBS_CONTEXT_VERSION_TWO = 0x00000002U;

enum : uint
{
    TPM_WNF_INFO_CLEAR_SUCCESSFUL     = 0x00000001U,
    TPM_WNF_INFO_OWNERSHIP_SUCCESSFUL = 0x00000002U,
}

enum uint TPM_WNF_INFO_NO_REBOOT_REQUIRED = 0x00000001U;

enum : uint
{
    TPM_VERSION_UNKNOWN = 0x00000000U,
    TPM_VERSION_12      = 0x00000001U,
    TPM_VERSION_20      = 0x00000002U,
}

enum : uint
{
    TPM_IFTYPE_UNKNOWN   = 0x00000000U,
    TPM_IFTYPE_1         = 0x00000001U,
    TPM_IFTYPE_TRUSTZONE = 0x00000002U,
    TPM_IFTYPE_HW        = 0x00000003U,
    TPM_IFTYPE_EMULATOR  = 0x00000004U,
    TPM_IFTYPE_SPB       = 0x00000005U,
}

enum : uint
{
    TBS_TCGLOG_SRTM_CURRENT = 0x00000000U,
    TBS_TCGLOG_DRTM_CURRENT = 0x00000001U,
    TBS_TCGLOG_SRTM_BOOT    = 0x00000002U,
    TBS_TCGLOG_SRTM_RESUME  = 0x00000003U,
    TBS_TCGLOG_DRTM_BOOT    = 0x00000004U,
    TBS_TCGLOG_DRTM_RESUME  = 0x00000005U,
}

// Structs


// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tbs/ns-tbs-tbs_context_params
struct TBS_CONTEXT_PARAMS
{
    uint version_;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tbs/ns-tbs-tbs_context_params2
struct TBS_CONTEXT_PARAMS2
{
    uint version_;
    union
    {
        struct
        {
            // Native bit field: requestRaw: [0], includeTpm12: [1], includeTpm20: [2]
            uint _bitfield0;
        }
        uint asUINT32;
    }
}

struct TPM_WNF_PROVISIONING
{
    uint      status;
    ubyte[28] message;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tbs/ns-tbs-tpm_device_info
struct TPM_DEVICE_INFO
{
    uint structVersion;
    uint tpmVersion;
    uint tpmInterfaceType;
    uint tpmImpRevision;
}

// Functions

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("tbs.dll")
uint Tbsi_Context_Create(TBS_CONTEXT_PARAMS* pContextParams, void** phContext);

@DllImport("tbs.dll")
uint Tbsi_Tpm_Vendor_Maintenance_Mode(TBS_CONTEXT_PARAMS* pContextParams, void** phContext);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("tbs.dll")
uint Tbsip_Context_Close(void* hContext);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("tbs.dll")
uint Tbsip_Submit_Command(void* hContext, TBS_COMMAND_LOCALITY Locality, TBS_COMMAND_PRIORITY Priority, 
                          /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/ubyte* pabCommand, 
                          uint cbCommand, 
                          /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(6)))])*/ubyte* pabResult, 
                          uint* pcbResult);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("tbs.dll")
uint Tbsip_Cancel_Commands(void* hContext);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("tbs.dll")
uint Tbsi_Physical_Presence_Command(void* hContext, 
                                    /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/ubyte* pabInput, 
                                    uint cbInput, 
                                    /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/ubyte* pabOutput, 
                                    uint* pcbOutput);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("tbs.dll")
uint Tbsi_Get_TCG_Log(void* hContext, 
                      /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/ubyte* pOutputBuf, 
                      uint* pOutputBufLen);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("tbs.dll")
uint Tbsi_GetDeviceInfo(uint Size, 
                        /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(0)))])*/void* Info);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("tbs.dll")
uint Tbsi_Get_OwnerAuth(void* hContext, uint ownerauthType, 
                        /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/ubyte* pOutputBuf, 
                        uint* pOutputBufLen);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("tbs.dll")
uint Tbsi_Revoke_Attestation();

@DllImport("tbs.dll")
HRESULT GetDeviceID(/*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/ubyte* pbWindowsAIK, 
                    uint cbWindowsAIK, uint* pcbResult, BOOL* pfProtectedByTPM);

@DllImport("tbs.dll")
HRESULT GetDeviceIDString(PWSTR pszWindowsAIK, uint cchWindowsAIK, uint* pcchResult, BOOL* pfProtectedByTPM);

@DllImport("tbs.dll")
uint Tbsi_Create_Windows_Key(uint keyHandle);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.17134))], [])
@DllImport("tbs.dll")
uint Tbsi_Get_TCG_Log_Ex(uint logType, 
                         /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/ubyte* pbOutput, 
                         uint* pcbOutput);

@DllImport("tbs.dll")
BOOL Tbsi_Is_Tpm_Present();


