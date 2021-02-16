module windows.snmp;

public import windows.core;
public import windows.systemservices : BOOL, HANDLE, ULARGE_INTEGER;
public import windows.windowsandmessaging : HWND, LPARAM, WPARAM;

extern(Windows):


// Callbacks

alias PFNSNMPEXTENSIONINIT = BOOL function(uint dwUpTimeReference, HANDLE* phSubagentTrapEvent, 
                                           AsnObjectIdentifier* pFirstSupportedRegion);
alias PFNSNMPEXTENSIONINITEX = BOOL function(AsnObjectIdentifier* pNextSupportedRegion);
alias PFNSNMPEXTENSIONMONITOR = BOOL function(void* pAgentMgmtData);
alias PFNSNMPEXTENSIONQUERY = BOOL function(ubyte bPduType, SnmpVarBindList* pVarBindList, int* pErrorStatus, 
                                            int* pErrorIndex);
alias PFNSNMPEXTENSIONQUERYEX = BOOL function(uint nRequestType, uint nTransactionId, 
                                              SnmpVarBindList* pVarBindList, AsnOctetString* pContextInfo, 
                                              int* pErrorStatus, int* pErrorIndex);
alias PFNSNMPEXTENSIONTRAP = BOOL function(AsnObjectIdentifier* pEnterpriseOid, int* pGenericTrapId, 
                                           int* pSpecificTrapId, uint* pTimeStamp, SnmpVarBindList* pVarBindList);
alias PFNSNMPEXTENSIONCLOSE = void function();
alias SNMPAPI_CALLBACK = uint function(ptrdiff_t hSession, HWND hWnd, uint wMsg, WPARAM wParam, LPARAM lParam, 
                                       void* lpClientData);
alias PFNSNMPSTARTUPEX = uint function(uint* param0, uint* param1, uint* param2, uint* param3, uint* param4);
alias PFNSNMPCLEANUPEX = uint function();

// Structs


struct AsnOctetString
{
    ubyte* stream;
    uint   length;
    BOOL   dynamic;
}

struct AsnObjectIdentifier
{
    uint  idLength;
    uint* ids;
}

struct AsnAny
{
    ubyte asnType;
    union asnValue
    {
    align (4):
        int                 number;
        uint                unsigned32;
        ULARGE_INTEGER      counter64;
        AsnOctetString      string;
        AsnOctetString      bits;
        AsnObjectIdentifier object;
        AsnOctetString      sequence;
        AsnOctetString      address;
        uint                counter;
        uint                gauge;
        uint                ticks;
        AsnOctetString      arbitrary;
    }
}

struct SnmpVarBind
{
    AsnObjectIdentifier name;
    AsnAny              value;
}

struct SnmpVarBindList
{
    SnmpVarBind* list;
    uint         len;
}

struct smiOCTETS
{
    uint   len;
    ubyte* ptr;
}

struct smiOID
{
    uint  len;
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
    union value
    {
        int       sNumber;
        uint      uNumber;
        smiCNTR64 hNumber;
        smiOCTETS string;
        smiOID    oid;
        ubyte     empty;
    }
}

struct smiVENDORINFO
{
    byte[64] vendorName;
    byte[64] vendorContact;
    byte[32] vendorVersionId;
    byte[32] vendorVersionDate;
    uint     vendorEnterprise;
}

// Functions

@DllImport("snmpapi")
int SnmpUtilOidCpy(AsnObjectIdentifier* pOidDst, AsnObjectIdentifier* pOidSrc);

@DllImport("snmpapi")
int SnmpUtilOidAppend(AsnObjectIdentifier* pOidDst, AsnObjectIdentifier* pOidSrc);

@DllImport("snmpapi")
int SnmpUtilOidNCmp(AsnObjectIdentifier* pOid1, AsnObjectIdentifier* pOid2, uint nSubIds);

@DllImport("snmpapi")
int SnmpUtilOidCmp(AsnObjectIdentifier* pOid1, AsnObjectIdentifier* pOid2);

@DllImport("snmpapi")
void SnmpUtilOidFree(AsnObjectIdentifier* pOid);

@DllImport("snmpapi")
int SnmpUtilOctetsCmp(AsnOctetString* pOctets1, AsnOctetString* pOctets2);

@DllImport("snmpapi")
int SnmpUtilOctetsNCmp(AsnOctetString* pOctets1, AsnOctetString* pOctets2, uint nChars);

@DllImport("snmpapi")
int SnmpUtilOctetsCpy(AsnOctetString* pOctetsDst, AsnOctetString* pOctetsSrc);

@DllImport("snmpapi")
void SnmpUtilOctetsFree(AsnOctetString* pOctets);

@DllImport("snmpapi")
int SnmpUtilAsnAnyCpy(AsnAny* pAnyDst, AsnAny* pAnySrc);

@DllImport("snmpapi")
void SnmpUtilAsnAnyFree(AsnAny* pAny);

@DllImport("snmpapi")
int SnmpUtilVarBindCpy(SnmpVarBind* pVbDst, SnmpVarBind* pVbSrc);

@DllImport("snmpapi")
void SnmpUtilVarBindFree(SnmpVarBind* pVb);

@DllImport("snmpapi")
int SnmpUtilVarBindListCpy(SnmpVarBindList* pVblDst, SnmpVarBindList* pVblSrc);

@DllImport("snmpapi")
void SnmpUtilVarBindListFree(SnmpVarBindList* pVbl);

@DllImport("snmpapi")
void SnmpUtilMemFree(void* pMem);

@DllImport("snmpapi")
void* SnmpUtilMemAlloc(uint nBytes);

@DllImport("snmpapi")
void* SnmpUtilMemReAlloc(void* pMem, uint nBytes);

@DllImport("snmpapi")
byte* SnmpUtilOidToA(AsnObjectIdentifier* Oid);

@DllImport("snmpapi")
byte* SnmpUtilIdsToA(uint* Ids, uint IdLength);

@DllImport("snmpapi")
void SnmpUtilPrintOid(AsnObjectIdentifier* Oid);

@DllImport("snmpapi")
void SnmpUtilPrintAsnAny(AsnAny* pAny);

@DllImport("snmpapi")
uint SnmpSvcGetUptime();

@DllImport("snmpapi")
void SnmpSvcSetLogLevel(int nLogLevel);

@DllImport("snmpapi")
void SnmpSvcSetLogType(int nLogType);

@DllImport("snmpapi")
void SnmpUtilDbgPrint(int nLogLevel, const(char)* szFormat);

@DllImport("mgmtapi")
void* SnmpMgrOpen(const(char)* lpAgentAddress, const(char)* lpAgentCommunity, int nTimeOut, int nRetries);

@DllImport("mgmtapi")
BOOL SnmpMgrCtl(void* session, uint dwCtlCode, void* lpvInBuffer, uint cbInBuffer, void* lpvOUTBuffer, 
                uint cbOUTBuffer, uint* lpcbBytesReturned);

@DllImport("mgmtapi")
BOOL SnmpMgrClose(void* session);

@DllImport("mgmtapi")
int SnmpMgrRequest(void* session, ubyte requestType, SnmpVarBindList* variableBindings, int* errorStatus, 
                   int* errorIndex);

@DllImport("mgmtapi")
BOOL SnmpMgrStrToOid(const(char)* string, AsnObjectIdentifier* oid);

@DllImport("mgmtapi")
BOOL SnmpMgrOidToStr(AsnObjectIdentifier* oid, byte** string);

@DllImport("mgmtapi")
BOOL SnmpMgrTrapListen(HANDLE* phTrapAvailable);

@DllImport("mgmtapi")
BOOL SnmpMgrGetTrap(AsnObjectIdentifier* enterprise, AsnOctetString* IPAddress, int* genericTrap, 
                    int* specificTrap, uint* timeStamp, SnmpVarBindList* variableBindings);

@DllImport("mgmtapi")
BOOL SnmpMgrGetTrapEx(AsnObjectIdentifier* enterprise, AsnOctetString* agentAddress, AsnOctetString* sourceAddress, 
                      int* genericTrap, int* specificTrap, AsnOctetString* community, uint* timeStamp, 
                      SnmpVarBindList* variableBindings);

@DllImport("wsnmp32")
uint SnmpGetTranslateMode(uint* nTranslateMode);

@DllImport("wsnmp32")
uint SnmpSetTranslateMode(uint nTranslateMode);

@DllImport("wsnmp32")
uint SnmpGetRetransmitMode(uint* nRetransmitMode);

@DllImport("wsnmp32")
uint SnmpSetRetransmitMode(uint nRetransmitMode);

@DllImport("wsnmp32")
uint SnmpGetTimeout(ptrdiff_t hEntity, uint* nPolicyTimeout, uint* nActualTimeout);

@DllImport("wsnmp32")
uint SnmpSetTimeout(ptrdiff_t hEntity, uint nPolicyTimeout);

@DllImport("wsnmp32")
uint SnmpGetRetry(ptrdiff_t hEntity, uint* nPolicyRetry, uint* nActualRetry);

@DllImport("wsnmp32")
uint SnmpSetRetry(ptrdiff_t hEntity, uint nPolicyRetry);

@DllImport("wsnmp32")
uint SnmpGetVendorInfo(smiVENDORINFO* vendorInfo);

@DllImport("wsnmp32")
uint SnmpStartup(uint* nMajorVersion, uint* nMinorVersion, uint* nLevel, uint* nTranslateMode, 
                 uint* nRetransmitMode);

@DllImport("wsnmp32")
uint SnmpCleanup();

@DllImport("wsnmp32")
ptrdiff_t SnmpOpen(HWND hWnd, uint wMsg);

@DllImport("wsnmp32")
uint SnmpClose(ptrdiff_t session);

@DllImport("wsnmp32")
uint SnmpSendMsg(ptrdiff_t session, ptrdiff_t srcEntity, ptrdiff_t dstEntity, ptrdiff_t context, ptrdiff_t PDU);

@DllImport("wsnmp32")
uint SnmpRecvMsg(ptrdiff_t session, ptrdiff_t* srcEntity, ptrdiff_t* dstEntity, ptrdiff_t* context, ptrdiff_t* PDU);

@DllImport("wsnmp32")
uint SnmpRegister(ptrdiff_t session, ptrdiff_t srcEntity, ptrdiff_t dstEntity, ptrdiff_t context, 
                  smiOID* notification, uint state);

@DllImport("wsnmp32")
ptrdiff_t SnmpCreateSession(HWND hWnd, uint wMsg, SNMPAPI_CALLBACK fCallBack, void* lpClientData);

@DllImport("wsnmp32")
uint SnmpListen(ptrdiff_t hEntity, uint lStatus);

@DllImport("wsnmp32")
uint SnmpListenEx(ptrdiff_t hEntity, uint lStatus, uint nUseEntityAddr);

@DllImport("wsnmp32")
uint SnmpCancelMsg(ptrdiff_t session, int reqId);

@DllImport("wsnmp32")
uint SnmpStartupEx(uint* nMajorVersion, uint* nMinorVersion, uint* nLevel, uint* nTranslateMode, 
                   uint* nRetransmitMode);

@DllImport("wsnmp32")
uint SnmpCleanupEx();

@DllImport("wsnmp32")
ptrdiff_t SnmpStrToEntity(ptrdiff_t session, const(char)* string);

@DllImport("wsnmp32")
uint SnmpEntityToStr(ptrdiff_t entity, uint size, const(char)* string);

@DllImport("wsnmp32")
uint SnmpFreeEntity(ptrdiff_t entity);

@DllImport("wsnmp32")
ptrdiff_t SnmpStrToContext(ptrdiff_t session, smiOCTETS* string);

@DllImport("wsnmp32")
uint SnmpContextToStr(ptrdiff_t context, smiOCTETS* string);

@DllImport("wsnmp32")
uint SnmpFreeContext(ptrdiff_t context);

@DllImport("wsnmp32")
uint SnmpSetPort(ptrdiff_t hEntity, uint nPort);

@DllImport("wsnmp32")
ptrdiff_t SnmpCreatePdu(ptrdiff_t session, int PDU_type, int request_id, int error_status, int error_index, 
                        ptrdiff_t varbindlist);

@DllImport("wsnmp32")
uint SnmpGetPduData(ptrdiff_t PDU, int* PDU_type, int* request_id, int* error_status, int* error_index, 
                    ptrdiff_t* varbindlist);

@DllImport("wsnmp32")
uint SnmpSetPduData(ptrdiff_t PDU, const(int)* PDU_type, const(int)* request_id, const(int)* non_repeaters, 
                    const(int)* max_repetitions, const(ptrdiff_t)* varbindlist);

@DllImport("wsnmp32")
ptrdiff_t SnmpDuplicatePdu(ptrdiff_t session, ptrdiff_t PDU);

@DllImport("wsnmp32")
uint SnmpFreePdu(ptrdiff_t PDU);

@DllImport("wsnmp32")
ptrdiff_t SnmpCreateVbl(ptrdiff_t session, smiOID* name, smiVALUE* value);

@DllImport("wsnmp32")
ptrdiff_t SnmpDuplicateVbl(ptrdiff_t session, ptrdiff_t vbl);

@DllImport("wsnmp32")
uint SnmpFreeVbl(ptrdiff_t vbl);

@DllImport("wsnmp32")
uint SnmpCountVbl(ptrdiff_t vbl);

@DllImport("wsnmp32")
uint SnmpGetVb(ptrdiff_t vbl, uint index, smiOID* name, smiVALUE* value);

@DllImport("wsnmp32")
uint SnmpSetVb(ptrdiff_t vbl, uint index, smiOID* name, smiVALUE* value);

@DllImport("wsnmp32")
uint SnmpDeleteVb(ptrdiff_t vbl, uint index);

@DllImport("wsnmp32")
uint SnmpGetLastError(ptrdiff_t session);

@DllImport("wsnmp32")
uint SnmpStrToOid(const(char)* string, smiOID* dstOID);

@DllImport("wsnmp32")
uint SnmpOidToStr(smiOID* srcOID, uint size, const(char)* string);

@DllImport("wsnmp32")
uint SnmpOidCopy(smiOID* srcOID, smiOID* dstOID);

@DllImport("wsnmp32")
uint SnmpOidCompare(smiOID* xOID, smiOID* yOID, uint maxlen, int* result);

@DllImport("wsnmp32")
uint SnmpEncodeMsg(ptrdiff_t session, ptrdiff_t srcEntity, ptrdiff_t dstEntity, ptrdiff_t context, ptrdiff_t pdu, 
                   smiOCTETS* msgBufDesc);

@DllImport("wsnmp32")
uint SnmpDecodeMsg(ptrdiff_t session, ptrdiff_t* srcEntity, ptrdiff_t* dstEntity, ptrdiff_t* context, 
                   ptrdiff_t* pdu, smiOCTETS* msgBufDesc);

@DllImport("wsnmp32")
uint SnmpFreeDescriptor(uint syntax, smiOCTETS* descriptor);


