module windows.tpmbaseservices;

public import windows.core;
public import windows.com : HRESULT;

extern(Windows):


// Structs


struct TBS_CONTEXT_PARAMS
{
    uint version_;
}

struct TBS_CONTEXT_PARAMS2
{
    uint version_;
    union
    {
        struct
        {
            uint _bitfield174;
        }
        uint asUINT32;
    }
}

struct tdTPM_WNF_PROVISIONING
{
    uint      status;
    ubyte[28] message;
}

struct TPM_DEVICE_INFO
{
    uint structVersion;
    uint tpmVersion;
    uint tpmInterfaceType;
    uint tpmImpRevision;
}

// Functions

@DllImport("tbs")
uint Tbsi_Context_Create(TBS_CONTEXT_PARAMS* pContextParams, void** phContext);

@DllImport("tbs")
uint Tbsip_Context_Close(void* hContext);

@DllImport("tbs")
uint Tbsip_Submit_Command(void* hContext, uint Locality, uint Priority, char* pabCommand, uint cbCommand, 
                          char* pabResult, uint* pcbResult);

@DllImport("tbs")
uint Tbsip_Cancel_Commands(void* hContext);

@DllImport("tbs")
uint Tbsi_Physical_Presence_Command(void* hContext, char* pabInput, uint cbInput, char* pabOutput, uint* pcbOutput);

@DllImport("tbs")
uint Tbsi_Get_TCG_Log(void* hContext, char* pOutputBuf, uint* pOutputBufLen);

@DllImport("tbs")
uint Tbsi_GetDeviceInfo(uint Size, char* Info);

@DllImport("tbs")
uint Tbsi_Get_OwnerAuth(void* hContext, uint ownerauthType, char* pOutputBuf, uint* pOutputBufLen);

@DllImport("tbs")
uint Tbsi_Revoke_Attestation();

@DllImport("DSOUND")
HRESULT GetDeviceID(char* pbWindowsAIK, uint cbWindowsAIK, uint* pcbResult, int* pfProtectedByTPM);

@DllImport("tbs")
HRESULT GetDeviceIDString(const(wchar)* pszWindowsAIK, uint cchWindowsAIK, uint* pcchResult, int* pfProtectedByTPM);

@DllImport("tbs")
uint Tbsi_Create_Windows_Key(uint keyHandle);

@DllImport("tbs")
uint Tbsi_Get_TCG_Log_Ex(uint logType, char* pbOutput, uint* pcbOutput);


