module windows.tpmbaseservices;

public import windows.com;

extern(Windows):

struct TBS_CONTEXT_PARAMS
{
    uint version;
}

struct TBS_CONTEXT_PARAMS2
{
    uint version;
    _Anonymous_e__Union Anonymous;
}

struct tdTPM_WNF_PROVISIONING
{
    uint status;
    ubyte message;
}

struct TPM_DEVICE_INFO
{
    uint structVersion;
    uint tpmVersion;
    uint tpmInterfaceType;
    uint tpmImpRevision;
}

@DllImport("tbs.dll")
uint Tbsi_Context_Create(TBS_CONTEXT_PARAMS* pContextParams, void** phContext);

@DllImport("tbs.dll")
uint Tbsip_Context_Close(void* hContext);

@DllImport("tbs.dll")
uint Tbsip_Submit_Command(void* hContext, uint Locality, uint Priority, char* pabCommand, uint cbCommand, char* pabResult, uint* pcbResult);

@DllImport("tbs.dll")
uint Tbsip_Cancel_Commands(void* hContext);

@DllImport("tbs.dll")
uint Tbsi_Physical_Presence_Command(void* hContext, char* pabInput, uint cbInput, char* pabOutput, uint* pcbOutput);

@DllImport("tbs.dll")
uint Tbsi_Get_TCG_Log(void* hContext, char* pOutputBuf, uint* pOutputBufLen);

@DllImport("tbs.dll")
uint Tbsi_GetDeviceInfo(uint Size, char* Info);

@DllImport("tbs.dll")
uint Tbsi_Get_OwnerAuth(void* hContext, uint ownerauthType, char* pOutputBuf, uint* pOutputBufLen);

@DllImport("tbs.dll")
uint Tbsi_Revoke_Attestation();

@DllImport("DSOUND.dll")
HRESULT GetDeviceID(char* pbWindowsAIK, uint cbWindowsAIK, uint* pcbResult, int* pfProtectedByTPM);

@DllImport("tbs.dll")
HRESULT GetDeviceIDString(const(wchar)* pszWindowsAIK, uint cchWindowsAIK, uint* pcchResult, int* pfProtectedByTPM);

@DllImport("tbs.dll")
uint Tbsi_Create_Windows_Key(uint keyHandle);

@DllImport("tbs.dll")
uint Tbsi_Get_TCG_Log_Ex(uint logType, char* pbOutput, uint* pcbOutput);

