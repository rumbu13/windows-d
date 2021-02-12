module windows.snmp;

public import windows.systemservices;
public import windows.windowsandmessaging;

extern(Windows):

struct AsnOctetString
{
    ubyte* stream;
    uint length;
    BOOL dynamic;
}

struct AsnObjectIdentifier
{
    uint idLength;
    uint* ids;
}

struct AsnAny
{
    ubyte asnType;
    _asnValue_e__Union asnValue;
}

struct SnmpVarBind
{
    AsnObjectIdentifier name;
    AsnAny value;
}

struct SnmpVarBindList
{
    SnmpVarBind* list;
    uint len;
}

alias PFNSNMPEXTENSIONINIT = extern(Windows) BOOL function(uint dwUpTimeReference, HANDLE* phSubagentTrapEvent, AsnObjectIdentifier* pFirstSupportedRegion);
alias PFNSNMPEXTENSIONINITEX = extern(Windows) BOOL function(AsnObjectIdentifier* pNextSupportedRegion);
alias PFNSNMPEXTENSIONMONITOR = extern(Windows) BOOL function(void* pAgentMgmtData);
alias PFNSNMPEXTENSIONQUERY = extern(Windows) BOOL function(ubyte bPduType, SnmpVarBindList* pVarBindList, int* pErrorStatus, int* pErrorIndex);
alias PFNSNMPEXTENSIONQUERYEX = extern(Windows) BOOL function(uint nRequestType, uint nTransactionId, SnmpVarBindList* pVarBindList, AsnOctetString* pContextInfo, int* pErrorStatus, int* pErrorIndex);
alias PFNSNMPEXTENSIONTRAP = extern(Windows) BOOL function(AsnObjectIdentifier* pEnterpriseOid, int* pGenericTrapId, int* pSpecificTrapId, uint* pTimeStamp, SnmpVarBindList* pVarBindList);
alias PFNSNMPEXTENSIONCLOSE = extern(Windows) void function();
struct smiOCTETS
{
    uint len;
    ubyte* ptr;
}

struct smiOID
{
    uint len;
    uint* ptr;
}

struct smiCNTR64
{
    uint hipart;
    uint lopart;
}

struct smiVALUE
{
    uint syntax;
    _value_e__Union value;
}

struct smiVENDORINFO
{
    byte vendorName;
    byte vendorContact;
    byte vendorVersionId;
    byte vendorVersionDate;
    uint vendorEnterprise;
}

alias SNMPAPI_CALLBACK = extern(Windows) uint function(int hSession, HWND hWnd, uint wMsg, WPARAM wParam, LPARAM lParam, void* lpClientData);
alias PFNSNMPSTARTUPEX = extern(Windows) uint function(uint* param0, uint* param1, uint* param2, uint* param3, uint* param4);
alias PFNSNMPCLEANUPEX = extern(Windows) uint function();
@DllImport("snmpapi.dll")
int SnmpUtilOidCpy(AsnObjectIdentifier* pOidDst, AsnObjectIdentifier* pOidSrc);

@DllImport("snmpapi.dll")
int SnmpUtilOidAppend(AsnObjectIdentifier* pOidDst, AsnObjectIdentifier* pOidSrc);

@DllImport("snmpapi.dll")
int SnmpUtilOidNCmp(AsnObjectIdentifier* pOid1, AsnObjectIdentifier* pOid2, uint nSubIds);

@DllImport("snmpapi.dll")
int SnmpUtilOidCmp(AsnObjectIdentifier* pOid1, AsnObjectIdentifier* pOid2);

@DllImport("snmpapi.dll")
void SnmpUtilOidFree(AsnObjectIdentifier* pOid);

@DllImport("snmpapi.dll")
int SnmpUtilOctetsCmp(AsnOctetString* pOctets1, AsnOctetString* pOctets2);

@DllImport("snmpapi.dll")
int SnmpUtilOctetsNCmp(AsnOctetString* pOctets1, AsnOctetString* pOctets2, uint nChars);

@DllImport("snmpapi.dll")
int SnmpUtilOctetsCpy(AsnOctetString* pOctetsDst, AsnOctetString* pOctetsSrc);

@DllImport("snmpapi.dll")
void SnmpUtilOctetsFree(AsnOctetString* pOctets);

@DllImport("snmpapi.dll")
int SnmpUtilAsnAnyCpy(AsnAny* pAnyDst, AsnAny* pAnySrc);

@DllImport("snmpapi.dll")
void SnmpUtilAsnAnyFree(AsnAny* pAny);

@DllImport("snmpapi.dll")
int SnmpUtilVarBindCpy(SnmpVarBind* pVbDst, SnmpVarBind* pVbSrc);

@DllImport("snmpapi.dll")
void SnmpUtilVarBindFree(SnmpVarBind* pVb);

@DllImport("snmpapi.dll")
int SnmpUtilVarBindListCpy(SnmpVarBindList* pVblDst, SnmpVarBindList* pVblSrc);

@DllImport("snmpapi.dll")
void SnmpUtilVarBindListFree(SnmpVarBindList* pVbl);

@DllImport("snmpapi.dll")
void SnmpUtilMemFree(void* pMem);

@DllImport("snmpapi.dll")
void* SnmpUtilMemAlloc(uint nBytes);

@DllImport("snmpapi.dll")
void* SnmpUtilMemReAlloc(void* pMem, uint nBytes);

@DllImport("snmpapi.dll")
byte* SnmpUtilOidToA(AsnObjectIdentifier* Oid);

@DllImport("snmpapi.dll")
byte* SnmpUtilIdsToA(uint* Ids, uint IdLength);

@DllImport("snmpapi.dll")
void SnmpUtilPrintOid(AsnObjectIdentifier* Oid);

@DllImport("snmpapi.dll")
void SnmpUtilPrintAsnAny(AsnAny* pAny);

@DllImport("snmpapi.dll")
uint SnmpSvcGetUptime();

@DllImport("snmpapi.dll")
void SnmpSvcSetLogLevel(int nLogLevel);

@DllImport("snmpapi.dll")
void SnmpSvcSetLogType(int nLogType);

@DllImport("snmpapi.dll")
void SnmpUtilDbgPrint(int nLogLevel, const(char)* szFormat);

@DllImport("mgmtapi.dll")
void* SnmpMgrOpen(const(char)* lpAgentAddress, const(char)* lpAgentCommunity, int nTimeOut, int nRetries);

@DllImport("mgmtapi.dll")
BOOL SnmpMgrCtl(void* session, uint dwCtlCode, void* lpvInBuffer, uint cbInBuffer, void* lpvOUTBuffer, uint cbOUTBuffer, uint* lpcbBytesReturned);

@DllImport("mgmtapi.dll")
BOOL SnmpMgrClose(void* session);

@DllImport("mgmtapi.dll")
int SnmpMgrRequest(void* session, ubyte requestType, SnmpVarBindList* variableBindings, int* errorStatus, int* errorIndex);

@DllImport("mgmtapi.dll")
BOOL SnmpMgrStrToOid(const(char)* string, AsnObjectIdentifier* oid);

@DllImport("mgmtapi.dll")
BOOL SnmpMgrOidToStr(AsnObjectIdentifier* oid, byte** string);

@DllImport("mgmtapi.dll")
BOOL SnmpMgrTrapListen(HANDLE* phTrapAvailable);

@DllImport("mgmtapi.dll")
BOOL SnmpMgrGetTrap(AsnObjectIdentifier* enterprise, AsnOctetString* IPAddress, int* genericTrap, int* specificTrap, uint* timeStamp, SnmpVarBindList* variableBindings);

@DllImport("mgmtapi.dll")
BOOL SnmpMgrGetTrapEx(AsnObjectIdentifier* enterprise, AsnOctetString* agentAddress, AsnOctetString* sourceAddress, int* genericTrap, int* specificTrap, AsnOctetString* community, uint* timeStamp, SnmpVarBindList* variableBindings);

@DllImport("wsnmp32.dll")
uint SnmpGetTranslateMode(uint* nTranslateMode);

@DllImport("wsnmp32.dll")
uint SnmpSetTranslateMode(uint nTranslateMode);

@DllImport("wsnmp32.dll")
uint SnmpGetRetransmitMode(uint* nRetransmitMode);

@DllImport("wsnmp32.dll")
uint SnmpSetRetransmitMode(uint nRetransmitMode);

@DllImport("wsnmp32.dll")
uint SnmpGetTimeout(int hEntity, uint* nPolicyTimeout, uint* nActualTimeout);

@DllImport("wsnmp32.dll")
uint SnmpSetTimeout(int hEntity, uint nPolicyTimeout);

@DllImport("wsnmp32.dll")
uint SnmpGetRetry(int hEntity, uint* nPolicyRetry, uint* nActualRetry);

@DllImport("wsnmp32.dll")
uint SnmpSetRetry(int hEntity, uint nPolicyRetry);

@DllImport("wsnmp32.dll")
uint SnmpGetVendorInfo(smiVENDORINFO* vendorInfo);

@DllImport("wsnmp32.dll")
uint SnmpStartup(uint* nMajorVersion, uint* nMinorVersion, uint* nLevel, uint* nTranslateMode, uint* nRetransmitMode);

@DllImport("wsnmp32.dll")
uint SnmpCleanup();

@DllImport("wsnmp32.dll")
int SnmpOpen(HWND hWnd, uint wMsg);

@DllImport("wsnmp32.dll")
uint SnmpClose(int session);

@DllImport("wsnmp32.dll")
uint SnmpSendMsg(int session, int srcEntity, int dstEntity, int context, int PDU);

@DllImport("wsnmp32.dll")
uint SnmpRecvMsg(int session, int* srcEntity, int* dstEntity, int* context, int* PDU);

@DllImport("wsnmp32.dll")
uint SnmpRegister(int session, int srcEntity, int dstEntity, int context, smiOID* notification, uint state);

@DllImport("wsnmp32.dll")
int SnmpCreateSession(HWND hWnd, uint wMsg, SNMPAPI_CALLBACK fCallBack, void* lpClientData);

@DllImport("wsnmp32.dll")
uint SnmpListen(int hEntity, uint lStatus);

@DllImport("wsnmp32.dll")
uint SnmpListenEx(int hEntity, uint lStatus, uint nUseEntityAddr);

@DllImport("wsnmp32.dll")
uint SnmpCancelMsg(int session, int reqId);

@DllImport("wsnmp32.dll")
uint SnmpStartupEx(uint* nMajorVersion, uint* nMinorVersion, uint* nLevel, uint* nTranslateMode, uint* nRetransmitMode);

@DllImport("wsnmp32.dll")
uint SnmpCleanupEx();

@DllImport("wsnmp32.dll")
int SnmpStrToEntity(int session, const(char)* string);

@DllImport("wsnmp32.dll")
uint SnmpEntityToStr(int entity, uint size, const(char)* string);

@DllImport("wsnmp32.dll")
uint SnmpFreeEntity(int entity);

@DllImport("wsnmp32.dll")
int SnmpStrToContext(int session, smiOCTETS* string);

@DllImport("wsnmp32.dll")
uint SnmpContextToStr(int context, smiOCTETS* string);

@DllImport("wsnmp32.dll")
uint SnmpFreeContext(int context);

@DllImport("wsnmp32.dll")
uint SnmpSetPort(int hEntity, uint nPort);

@DllImport("wsnmp32.dll")
int SnmpCreatePdu(int session, int PDU_type, int request_id, int error_status, int error_index, int varbindlist);

@DllImport("wsnmp32.dll")
uint SnmpGetPduData(int PDU, int* PDU_type, int* request_id, int* error_status, int* error_index, int* varbindlist);

@DllImport("wsnmp32.dll")
uint SnmpSetPduData(int PDU, const(int)* PDU_type, const(int)* request_id, const(int)* non_repeaters, const(int)* max_repetitions, const(int)* varbindlist);

@DllImport("wsnmp32.dll")
int SnmpDuplicatePdu(int session, int PDU);

@DllImport("wsnmp32.dll")
uint SnmpFreePdu(int PDU);

@DllImport("wsnmp32.dll")
int SnmpCreateVbl(int session, smiOID* name, smiVALUE* value);

@DllImport("wsnmp32.dll")
int SnmpDuplicateVbl(int session, int vbl);

@DllImport("wsnmp32.dll")
uint SnmpFreeVbl(int vbl);

@DllImport("wsnmp32.dll")
uint SnmpCountVbl(int vbl);

@DllImport("wsnmp32.dll")
uint SnmpGetVb(int vbl, uint index, smiOID* name, smiVALUE* value);

@DllImport("wsnmp32.dll")
uint SnmpSetVb(int vbl, uint index, smiOID* name, smiVALUE* value);

@DllImport("wsnmp32.dll")
uint SnmpDeleteVb(int vbl, uint index);

@DllImport("wsnmp32.dll")
uint SnmpGetLastError(int session);

@DllImport("wsnmp32.dll")
uint SnmpStrToOid(const(char)* string, smiOID* dstOID);

@DllImport("wsnmp32.dll")
uint SnmpOidToStr(smiOID* srcOID, uint size, const(char)* string);

@DllImport("wsnmp32.dll")
uint SnmpOidCopy(smiOID* srcOID, smiOID* dstOID);

@DllImport("wsnmp32.dll")
uint SnmpOidCompare(smiOID* xOID, smiOID* yOID, uint maxlen, int* result);

@DllImport("wsnmp32.dll")
uint SnmpEncodeMsg(int session, int srcEntity, int dstEntity, int context, int pdu, smiOCTETS* msgBufDesc);

@DllImport("wsnmp32.dll")
uint SnmpDecodeMsg(int session, int* srcEntity, int* dstEntity, int* context, int* pdu, smiOCTETS* msgBufDesc);

@DllImport("wsnmp32.dll")
uint SnmpFreeDescriptor(uint syntax, smiOCTETS* descriptor);

