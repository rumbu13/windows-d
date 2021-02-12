module windows.qualityofservice;

public import system;
public import windows.nativewifi;
public import windows.systemservices;
public import windows.winsock;

extern(Windows):

struct FLOWSPEC
{
    uint TokenRate;
    uint TokenBucketSize;
    uint PeakBandwidth;
    uint Latency;
    uint DelayVariation;
    uint ServiceType;
    uint MaxSduSize;
    uint MinimumPolicedSize;
}

struct QOS_OBJECT_HDR
{
    uint ObjectType;
    uint ObjectLength;
}

struct QOS_SD_MODE
{
    QOS_OBJECT_HDR ObjectHdr;
    uint ShapeDiscardMode;
}

struct QOS_SHAPING_RATE
{
    QOS_OBJECT_HDR ObjectHdr;
    uint ShapingRate;
}

struct RsvpObjHdr
{
    ushort obj_length;
    ubyte obj_class;
    ubyte obj_ctype;
}

struct Session_IPv4
{
    in_addr sess_destaddr;
    ubyte sess_protid;
    ubyte sess_flags;
    ushort sess_destport;
}

struct RSVP_SESSION
{
    RsvpObjHdr sess_header;
    _sess_u_e__Union sess_u;
}

struct Rsvp_Hop_IPv4
{
    in_addr hop_ipaddr;
    uint hop_LIH;
}

struct RSVP_HOP
{
    RsvpObjHdr hop_header;
    _hop_u_e__Union hop_u;
}

struct RESV_STYLE
{
    RsvpObjHdr style_header;
    uint style_word;
}

struct Filter_Spec_IPv4
{
    in_addr filt_ipaddr;
    ushort filt_unused;
    ushort filt_port;
}

struct Filter_Spec_IPv4GPI
{
    in_addr filt_ipaddr;
    uint filt_gpi;
}

struct FILTER_SPEC
{
    RsvpObjHdr filt_header;
    _filt_u_e__Union filt_u;
}

struct Scope_list_ipv4
{
    in_addr scopl_ipaddr;
}

struct RSVP_SCOPE
{
    RsvpObjHdr scopl_header;
    _scope_u_e__Union scope_u;
}

struct Error_Spec_IPv4
{
    in_addr errs_errnode;
    ubyte errs_flags;
    ubyte errs_code;
    ushort errs_value;
}

struct ERROR_SPEC
{
    RsvpObjHdr errs_header;
    _errs_u_e__Union errs_u;
}

struct POLICY_DATA
{
    RsvpObjHdr PolicyObjHdr;
    ushort usPeOffset;
    ushort usReserved;
}

struct POLICY_ELEMENT
{
    ushort usPeLength;
    ushort usPeType;
    ubyte ucPeData;
}

enum int_serv_wkp
{
    IS_WKP_HOP_CNT = 4,
    IS_WKP_PATH_BW = 6,
    IS_WKP_MIN_LATENCY = 8,
    IS_WKP_COMPOSED_MTU = 10,
    IS_WKP_TB_TSPEC = 127,
    IS_WKP_Q_TSPEC = 128,
}

struct IntServMainHdr
{
    ubyte ismh_version;
    ubyte ismh_unused;
    ushort ismh_len32b;
}

struct IntServServiceHdr
{
    ubyte issh_service;
    ubyte issh_flags;
    ushort issh_len32b;
}

struct IntServParmHdr
{
    ubyte isph_parm_num;
    ubyte isph_flags;
    ushort isph_len32b;
}

struct GenTspecParms
{
    float TB_Tspec_r;
    float TB_Tspec_b;
    float TB_Tspec_p;
    uint TB_Tspec_m;
    uint TB_Tspec_M;
}

struct GenTspec
{
    IntServServiceHdr gen_Tspec_serv_hdr;
    IntServParmHdr gen_Tspec_parm_hdr;
    GenTspecParms gen_Tspec_parms;
}

struct QualTspecParms
{
    uint TB_Tspec_M;
}

struct QualTspec
{
    IntServServiceHdr qual_Tspec_serv_hdr;
    IntServParmHdr qual_Tspec_parm_hdr;
    QualTspecParms qual_Tspec_parms;
}

struct QualAppFlowSpec
{
    IntServServiceHdr Q_spec_serv_hdr;
    IntServParmHdr Q_spec_parm_hdr;
    QualTspecParms Q_spec_parms;
}

struct IntServTspecBody
{
    IntServMainHdr st_mh;
    _tspec_u_e__Union tspec_u;
}

struct SENDER_TSPEC
{
    RsvpObjHdr stspec_header;
    IntServTspecBody stspec_body;
}

struct CtrlLoadFlowspec
{
    IntServServiceHdr CL_spec_serv_hdr;
    IntServParmHdr CL_spec_parm_hdr;
    GenTspecParms CL_spec_parms;
}

struct GuarRspec
{
    float Guar_R;
    uint Guar_S;
}

struct GuarFlowSpec
{
    IntServServiceHdr Guar_serv_hdr;
    IntServParmHdr Guar_Tspec_hdr;
    GenTspecParms Guar_Tspec_parms;
    IntServParmHdr Guar_Rspec_hdr;
    GuarRspec Guar_Rspec;
}

struct IntServFlowSpec
{
    IntServMainHdr spec_mh;
    _spec_u_e__Union spec_u;
}

struct IS_FLOWSPEC
{
    RsvpObjHdr flow_header;
    IntServFlowSpec flow_body;
}

struct flow_desc
{
    _u1_e__Union u1;
    _u2_e__Union u2;
}

struct Gads_parms_t
{
    IntServServiceHdr Gads_serv_hdr;
    IntServParmHdr Gads_Ctot_hdr;
    uint Gads_Ctot;
    IntServParmHdr Gads_Dtot_hdr;
    uint Gads_Dtot;
    IntServParmHdr Gads_Csum_hdr;
    uint Gads_Csum;
    IntServParmHdr Gads_Dsum_hdr;
    uint Gads_Dsum;
}

struct GenAdspecParams
{
    IntServServiceHdr gen_parm_hdr;
    IntServParmHdr gen_parm_hopcnt_hdr;
    uint gen_parm_hopcnt;
    IntServParmHdr gen_parm_pathbw_hdr;
    float gen_parm_path_bw;
    IntServParmHdr gen_parm_minlat_hdr;
    uint gen_parm_min_latency;
    IntServParmHdr gen_parm_compmtu_hdr;
    uint gen_parm_composed_MTU;
}

struct IS_ADSPEC_BODY
{
    IntServMainHdr adspec_mh;
    GenAdspecParams adspec_genparms;
}

struct ADSPEC
{
    RsvpObjHdr adspec_header;
    IS_ADSPEC_BODY adspec_body;
}

struct ID_ERROR_OBJECT
{
    ushort usIdErrLength;
    ubyte ucAType;
    ubyte ucSubType;
    ushort usReserved;
    ushort usIdErrorValue;
    ubyte ucIdErrData;
}

struct LPM_HANDLE__
{
    int unused;
}

struct RHANDLE__
{
    int unused;
}

struct RSVP_MSG_OBJS
{
    int RsvpMsgType;
    RSVP_SESSION* pRsvpSession;
    RSVP_HOP* pRsvpFromHop;
    RSVP_HOP* pRsvpToHop;
    RESV_STYLE* pResvStyle;
    RSVP_SCOPE* pRsvpScope;
    int FlowDescCount;
    flow_desc* pFlowDescs;
    int PdObjectCount;
    POLICY_DATA** ppPdObjects;
    ERROR_SPEC* pErrorSpec;
    ADSPEC* pAdspec;
}

alias PALLOCMEM = extern(Windows) void* function(uint Size);
alias PFREEMEM = extern(Windows) void function(void* pv);
struct policy_decision
{
    uint lpvResult;
    ushort wPolicyErrCode;
    ushort wPolicyErrValue;
}

alias CBADMITRESULT = extern(Windows) uint* function(LPM_HANDLE__* LpmHandle, RHANDLE__* RequestHandle, uint ulPcmActionFlags, int LpmError, int PolicyDecisionsCount, policy_decision* pPolicyDecisions);
alias CBGETRSVPOBJECTS = extern(Windows) uint* function(LPM_HANDLE__* LpmHandle, RHANDLE__* RequestHandle, int LpmError, int RsvpObjectsCount, RsvpObjHdr** ppRsvpObjects);
struct LPM_INIT_INFO
{
    uint PcmVersionNumber;
    uint ResultTimeLimit;
    int ConfiguredLpmCount;
    PALLOCMEM AllocMemory;
    PFREEMEM FreeMemory;
    CBADMITRESULT PcmAdmitResultCallback;
    CBGETRSVPOBJECTS GetRsvpObjectsCallback;
}

struct lpmiptable
{
    uint ulIfIndex;
    uint MediaType;
    in_addr IfIpAddr;
    in_addr IfNetMask;
}

enum QOS_TRAFFIC_TYPE
{
    QOSTrafficTypeBestEffort = 0,
    QOSTrafficTypeBackground = 1,
    QOSTrafficTypeExcellentEffort = 2,
    QOSTrafficTypeAudioVideo = 3,
    QOSTrafficTypeVoice = 4,
    QOSTrafficTypeControl = 5,
}

enum QOS_SET_FLOW
{
    QOSSetTrafficType = 0,
    QOSSetOutgoingRate = 1,
    QOSSetOutgoingDSCPValue = 2,
}

struct QOS_PACKET_PRIORITY
{
    uint ConformantDSCPValue;
    uint NonConformantDSCPValue;
    uint ConformantL2Value;
    uint NonConformantL2Value;
}

struct QOS_FLOW_FUNDAMENTALS
{
    BOOL BottleneckBandwidthSet;
    ulong BottleneckBandwidth;
    BOOL AvailableBandwidthSet;
    ulong AvailableBandwidth;
    BOOL RTTSet;
    uint RTT;
}

enum QOS_FLOWRATE_REASON
{
    QOSFlowRateNotApplicable = 0,
    QOSFlowRateContentChange = 1,
    QOSFlowRateCongestion = 2,
    QOSFlowRateHigherContentEncoding = 3,
    QOSFlowRateUserCaused = 4,
}

enum QOS_SHAPING
{
    QOSShapeOnly = 0,
    QOSShapeAndMark = 1,
    QOSUseNonConformantMarkings = 2,
}

struct QOS_FLOWRATE_OUTGOING
{
    ulong Bandwidth;
    QOS_SHAPING ShapingBehavior;
    QOS_FLOWRATE_REASON Reason;
}

enum QOS_QUERY_FLOW
{
    QOSQueryFlowFundamentals = 0,
    QOSQueryPacketPriority = 1,
    QOSQueryOutgoingRate = 2,
}

enum QOS_NOTIFY_FLOW
{
    QOSNotifyCongested = 0,
    QOSNotifyUncongested = 1,
    QOSNotifyAvailable = 2,
}

struct QOS_VERSION
{
    ushort MajorVersion;
    ushort MinorVersion;
}

struct QOS_FRIENDLY_NAME
{
    QOS_OBJECT_HDR ObjectHdr;
    ushort FriendlyName;
}

struct QOS_TRAFFIC_CLASS
{
    QOS_OBJECT_HDR ObjectHdr;
    uint TrafficClass;
}

struct QOS_DS_CLASS
{
    QOS_OBJECT_HDR ObjectHdr;
    uint DSField;
}

struct QOS_DIFFSERV
{
    QOS_OBJECT_HDR ObjectHdr;
    uint DSFieldCount;
    ubyte DiffservRule;
}

struct QOS_DIFFSERV_RULE
{
    ubyte InboundDSField;
    ubyte ConformingOutboundDSField;
    ubyte NonConformingOutboundDSField;
    ubyte ConformingUserPriority;
    ubyte NonConformingUserPriority;
}

struct QOS_TCP_TRAFFIC
{
    QOS_OBJECT_HDR ObjectHdr;
}

alias TCI_NOTIFY_HANDLER = extern(Windows) void function(HANDLE ClRegCtx, HANDLE ClIfcCtx, uint Event, HANDLE SubCode, uint BufSize, char* Buffer);
alias TCI_ADD_FLOW_COMPLETE_HANDLER = extern(Windows) void function(HANDLE ClFlowCtx, uint Status);
alias TCI_MOD_FLOW_COMPLETE_HANDLER = extern(Windows) void function(HANDLE ClFlowCtx, uint Status);
alias TCI_DEL_FLOW_COMPLETE_HANDLER = extern(Windows) void function(HANDLE ClFlowCtx, uint Status);
struct TCI_CLIENT_FUNC_LIST
{
    TCI_NOTIFY_HANDLER ClNotifyHandler;
    TCI_ADD_FLOW_COMPLETE_HANDLER ClAddFlowCompleteHandler;
    TCI_MOD_FLOW_COMPLETE_HANDLER ClModifyFlowCompleteHandler;
    TCI_DEL_FLOW_COMPLETE_HANDLER ClDeleteFlowCompleteHandler;
}

struct ADDRESS_LIST_DESCRIPTOR
{
    uint MediaType;
    NETWORK_ADDRESS_LIST AddressList;
}

struct TC_IFC_DESCRIPTOR
{
    uint Length;
    const(wchar)* pInterfaceName;
    const(wchar)* pInterfaceID;
    ADDRESS_LIST_DESCRIPTOR AddressListDesc;
}

struct TC_SUPPORTED_INFO_BUFFER
{
    ushort InstanceIDLength;
    ushort InstanceID;
    ulong InterfaceLuid;
    ADDRESS_LIST_DESCRIPTOR AddrListDesc;
}

struct TC_GEN_FILTER
{
    ushort AddressType;
    uint PatternSize;
    void* Pattern;
    void* Mask;
}

struct TC_GEN_FLOW
{
    FLOWSPEC SendingFlowspec;
    FLOWSPEC ReceivingFlowspec;
    uint TcObjectsLength;
    QOS_OBJECT_HDR TcObjects;
}

struct IP_PATTERN
{
    uint Reserved1;
    uint Reserved2;
    uint SrcAddr;
    uint DstAddr;
    _S_un_e__Union S_un;
    ubyte ProtocolId;
    ubyte Reserved3;
}

struct IPX_PATTERN
{
    _Src_e__Struct Src;
    _Src_e__Struct Dest;
}

struct ENUMERATION_BUFFER
{
    uint Length;
    uint OwnerProcessId;
    ushort FlowNameLength;
    ushort FlowName;
    TC_GEN_FLOW* pFlow;
    uint NumberOfFilters;
    TC_GEN_FILTER GenericFilter;
}

@DllImport("qwave.dll")
BOOL QOSCreateHandle(QOS_VERSION* Version, int* QOSHandle);

@DllImport("qwave.dll")
BOOL QOSCloseHandle(HANDLE QOSHandle);

@DllImport("qwave.dll")
BOOL QOSStartTrackingClient(HANDLE QOSHandle, SOCKADDR* DestAddr, uint Flags);

@DllImport("qwave.dll")
BOOL QOSStopTrackingClient(HANDLE QOSHandle, SOCKADDR* DestAddr, uint Flags);

@DllImport("qwave.dll")
BOOL QOSEnumerateFlows(HANDLE QOSHandle, uint* Size, char* Buffer);

@DllImport("qwave.dll")
BOOL QOSAddSocketToFlow(HANDLE QOSHandle, uint Socket, SOCKADDR* DestAddr, QOS_TRAFFIC_TYPE TrafficType, uint Flags, uint* FlowId);

@DllImport("qwave.dll")
BOOL QOSRemoveSocketFromFlow(HANDLE QOSHandle, uint Socket, uint FlowId, uint Flags);

@DllImport("qwave.dll")
BOOL QOSSetFlow(HANDLE QOSHandle, uint FlowId, QOS_SET_FLOW Operation, uint Size, char* Buffer, uint Flags, OVERLAPPED* Overlapped);

@DllImport("qwave.dll")
BOOL QOSQueryFlow(HANDLE QOSHandle, uint FlowId, QOS_QUERY_FLOW Operation, uint* Size, char* Buffer, uint Flags, OVERLAPPED* Overlapped);

@DllImport("qwave.dll")
BOOL QOSNotifyFlow(HANDLE QOSHandle, uint FlowId, QOS_NOTIFY_FLOW Operation, uint* Size, char* Buffer, uint Flags, OVERLAPPED* Overlapped);

@DllImport("qwave.dll")
BOOL QOSCancel(HANDLE QOSHandle, OVERLAPPED* Overlapped);

@DllImport("TRAFFIC.dll")
uint TcRegisterClient(uint TciVersion, HANDLE ClRegCtx, TCI_CLIENT_FUNC_LIST* ClientHandlerList, int* pClientHandle);

@DllImport("TRAFFIC.dll")
uint TcEnumerateInterfaces(HANDLE ClientHandle, uint* pBufferSize, TC_IFC_DESCRIPTOR* InterfaceBuffer);

@DllImport("TRAFFIC.dll")
uint TcOpenInterfaceA(const(char)* pInterfaceName, HANDLE ClientHandle, HANDLE ClIfcCtx, int* pIfcHandle);

@DllImport("TRAFFIC.dll")
uint TcOpenInterfaceW(const(wchar)* pInterfaceName, HANDLE ClientHandle, HANDLE ClIfcCtx, int* pIfcHandle);

@DllImport("TRAFFIC.dll")
uint TcCloseInterface(HANDLE IfcHandle);

@DllImport("TRAFFIC.dll")
uint TcQueryInterface(HANDLE IfcHandle, Guid* pGuidParam, ubyte NotifyChange, uint* pBufferSize, char* Buffer);

@DllImport("TRAFFIC.dll")
uint TcSetInterface(HANDLE IfcHandle, Guid* pGuidParam, uint BufferSize, char* Buffer);

@DllImport("TRAFFIC.dll")
uint TcQueryFlowA(const(char)* pFlowName, Guid* pGuidParam, uint* pBufferSize, char* Buffer);

@DllImport("TRAFFIC.dll")
uint TcQueryFlowW(const(wchar)* pFlowName, Guid* pGuidParam, uint* pBufferSize, char* Buffer);

@DllImport("TRAFFIC.dll")
uint TcSetFlowA(const(char)* pFlowName, Guid* pGuidParam, uint BufferSize, char* Buffer);

@DllImport("TRAFFIC.dll")
uint TcSetFlowW(const(wchar)* pFlowName, Guid* pGuidParam, uint BufferSize, char* Buffer);

@DllImport("TRAFFIC.dll")
uint TcAddFlow(HANDLE IfcHandle, HANDLE ClFlowCtx, uint Flags, TC_GEN_FLOW* pGenericFlow, int* pFlowHandle);

@DllImport("TRAFFIC.dll")
uint TcGetFlowNameA(HANDLE FlowHandle, uint StrSize, const(char)* pFlowName);

@DllImport("TRAFFIC.dll")
uint TcGetFlowNameW(HANDLE FlowHandle, uint StrSize, const(wchar)* pFlowName);

@DllImport("TRAFFIC.dll")
uint TcModifyFlow(HANDLE FlowHandle, TC_GEN_FLOW* pGenericFlow);

@DllImport("TRAFFIC.dll")
uint TcAddFilter(HANDLE FlowHandle, TC_GEN_FILTER* pGenericFilter, int* pFilterHandle);

@DllImport("TRAFFIC.dll")
uint TcDeregisterClient(HANDLE ClientHandle);

@DllImport("TRAFFIC.dll")
uint TcDeleteFlow(HANDLE FlowHandle);

@DllImport("TRAFFIC.dll")
uint TcDeleteFilter(HANDLE FilterHandle);

@DllImport("TRAFFIC.dll")
uint TcEnumerateFlows(HANDLE IfcHandle, int* pEnumHandle, uint* pFlowCount, uint* pBufSize, ENUMERATION_BUFFER* Buffer);

struct QOS
{
    FLOWSPEC SendingFlowspec;
    FLOWSPEC ReceivingFlowspec;
    WSABUF ProviderSpecific;
}

