module windows.qualityofservice;

public import windows.core;
public import windows.nativewifi : NETWORK_ADDRESS_LIST;
public import windows.systemservices : BOOL, HANDLE, OVERLAPPED;
public import windows.winsock : SOCKADDR, WSABUF, in_addr;

extern(Windows):


// Enums


enum : int
{
    IS_WKP_HOP_CNT      = 0x00000004,
    IS_WKP_PATH_BW      = 0x00000006,
    IS_WKP_MIN_LATENCY  = 0x00000008,
    IS_WKP_COMPOSED_MTU = 0x0000000a,
    IS_WKP_TB_TSPEC     = 0x0000007f,
    IS_WKP_Q_TSPEC      = 0x00000080,
}
alias int_serv_wkp = int;

enum : int
{
    QOSTrafficTypeBestEffort      = 0x00000000,
    QOSTrafficTypeBackground      = 0x00000001,
    QOSTrafficTypeExcellentEffort = 0x00000002,
    QOSTrafficTypeAudioVideo      = 0x00000003,
    QOSTrafficTypeVoice           = 0x00000004,
    QOSTrafficTypeControl         = 0x00000005,
}
alias QOS_TRAFFIC_TYPE = int;

enum : int
{
    QOSSetTrafficType       = 0x00000000,
    QOSSetOutgoingRate      = 0x00000001,
    QOSSetOutgoingDSCPValue = 0x00000002,
}
alias QOS_SET_FLOW = int;

enum : int
{
    QOSFlowRateNotApplicable         = 0x00000000,
    QOSFlowRateContentChange         = 0x00000001,
    QOSFlowRateCongestion            = 0x00000002,
    QOSFlowRateHigherContentEncoding = 0x00000003,
    QOSFlowRateUserCaused            = 0x00000004,
}
alias QOS_FLOWRATE_REASON = int;

enum : int
{
    QOSShapeOnly                = 0x00000000,
    QOSShapeAndMark             = 0x00000001,
    QOSUseNonConformantMarkings = 0x00000002,
}
alias QOS_SHAPING = int;

enum : int
{
    QOSQueryFlowFundamentals = 0x00000000,
    QOSQueryPacketPriority   = 0x00000001,
    QOSQueryOutgoingRate     = 0x00000002,
}
alias QOS_QUERY_FLOW = int;

enum : int
{
    QOSNotifyCongested   = 0x00000000,
    QOSNotifyUncongested = 0x00000001,
    QOSNotifyAvailable   = 0x00000002,
}
alias QOS_NOTIFY_FLOW = int;

// Constants


enum int IS_GUAR_RSPEC = 0x00000082;

enum : int
{
    GUAR_ADSPARM_D    = 0x00000084,
    GUAR_ADSPARM_Ctot = 0x00000085,
    GUAR_ADSPARM_Dtot = 0x00000086,
    GUAR_ADSPARM_Csum = 0x00000087,
    GUAR_ADSPARM_Dsum = 0x00000088,
}

// Callbacks

alias PALLOCMEM = void* function(uint Size);
alias PFREEMEM = void function(void* pv);
alias CBADMITRESULT = uint* function(LPM_HANDLE__* LpmHandle, RHANDLE__* RequestHandle, uint ulPcmActionFlags, 
                                     int LpmError, int PolicyDecisionsCount, policy_decision* pPolicyDecisions);
alias CBGETRSVPOBJECTS = uint* function(LPM_HANDLE__* LpmHandle, RHANDLE__* RequestHandle, int LpmError, 
                                        int RsvpObjectsCount, RsvpObjHdr** ppRsvpObjects);
alias TCI_NOTIFY_HANDLER = void function(HANDLE ClRegCtx, HANDLE ClIfcCtx, uint Event, HANDLE SubCode, 
                                         uint BufSize, char* Buffer);
alias TCI_ADD_FLOW_COMPLETE_HANDLER = void function(HANDLE ClFlowCtx, uint Status);
alias TCI_MOD_FLOW_COMPLETE_HANDLER = void function(HANDLE ClFlowCtx, uint Status);
alias TCI_DEL_FLOW_COMPLETE_HANDLER = void function(HANDLE ClFlowCtx, uint Status);

// Structs


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
    uint           ShapeDiscardMode;
}

struct QOS_SHAPING_RATE
{
    QOS_OBJECT_HDR ObjectHdr;
    uint           ShapingRate;
}

struct RsvpObjHdr
{
    ushort obj_length;
    ubyte  obj_class;
    ubyte  obj_ctype;
}

struct Session_IPv4
{
    in_addr sess_destaddr;
    ubyte   sess_protid;
    ubyte   sess_flags;
    ushort  sess_destport;
}

struct RSVP_SESSION
{
    RsvpObjHdr sess_header;
    union sess_u
    {
        Session_IPv4 sess_ipv4;
    }
}

struct Rsvp_Hop_IPv4
{
    in_addr hop_ipaddr;
    uint    hop_LIH;
}

struct RSVP_HOP
{
    RsvpObjHdr hop_header;
    union hop_u
    {
        Rsvp_Hop_IPv4 hop_ipv4;
    }
}

struct RESV_STYLE
{
    RsvpObjHdr style_header;
    uint       style_word;
}

struct Filter_Spec_IPv4
{
    in_addr filt_ipaddr;
    ushort  filt_unused;
    ushort  filt_port;
}

struct Filter_Spec_IPv4GPI
{
    in_addr filt_ipaddr;
    uint    filt_gpi;
}

struct FILTER_SPEC
{
    RsvpObjHdr filt_header;
    union filt_u
    {
        Filter_Spec_IPv4    filt_ipv4;
        Filter_Spec_IPv4GPI filt_ipv4gpi;
    }
}

struct Scope_list_ipv4
{
    in_addr[1] scopl_ipaddr;
}

struct RSVP_SCOPE
{
    RsvpObjHdr scopl_header;
    union scope_u
    {
        Scope_list_ipv4 scopl_ipv4;
    }
}

struct Error_Spec_IPv4
{
    in_addr errs_errnode;
    ubyte   errs_flags;
    ubyte   errs_code;
    ushort  errs_value;
}

struct ERROR_SPEC
{
    RsvpObjHdr errs_header;
    union errs_u
    {
        Error_Spec_IPv4 errs_ipv4;
    }
}

struct POLICY_DATA
{
    RsvpObjHdr PolicyObjHdr;
    ushort     usPeOffset;
    ushort     usReserved;
}

struct POLICY_ELEMENT
{
    ushort   usPeLength;
    ushort   usPeType;
    ubyte[4] ucPeData;
}

struct IntServMainHdr
{
    ubyte  ismh_version;
    ubyte  ismh_unused;
    ushort ismh_len32b;
}

struct IntServServiceHdr
{
    ubyte  issh_service;
    ubyte  issh_flags;
    ushort issh_len32b;
}

struct IntServParmHdr
{
    ubyte  isph_parm_num;
    ubyte  isph_flags;
    ushort isph_len32b;
}

struct GenTspecParms
{
    float TB_Tspec_r;
    float TB_Tspec_b;
    float TB_Tspec_p;
    uint  TB_Tspec_m;
    uint  TB_Tspec_M;
}

struct GenTspec
{
    IntServServiceHdr gen_Tspec_serv_hdr;
    IntServParmHdr    gen_Tspec_parm_hdr;
    GenTspecParms     gen_Tspec_parms;
}

struct QualTspecParms
{
    uint TB_Tspec_M;
}

struct QualTspec
{
    IntServServiceHdr qual_Tspec_serv_hdr;
    IntServParmHdr    qual_Tspec_parm_hdr;
    QualTspecParms    qual_Tspec_parms;
}

struct QualAppFlowSpec
{
    IntServServiceHdr Q_spec_serv_hdr;
    IntServParmHdr    Q_spec_parm_hdr;
    QualTspecParms    Q_spec_parms;
}

struct IntServTspecBody
{
    IntServMainHdr st_mh;
    union tspec_u
    {
        GenTspec  gen_stspec;
        QualTspec qual_stspec;
    }
}

struct SENDER_TSPEC
{
    RsvpObjHdr       stspec_header;
    IntServTspecBody stspec_body;
}

struct CtrlLoadFlowspec
{
    IntServServiceHdr CL_spec_serv_hdr;
    IntServParmHdr    CL_spec_parm_hdr;
    GenTspecParms     CL_spec_parms;
}

struct GuarRspec
{
    float Guar_R;
    uint  Guar_S;
}

struct GuarFlowSpec
{
    IntServServiceHdr Guar_serv_hdr;
    IntServParmHdr    Guar_Tspec_hdr;
    GenTspecParms     Guar_Tspec_parms;
    IntServParmHdr    Guar_Rspec_hdr;
    GuarRspec         Guar_Rspec;
}

struct IntServFlowSpec
{
    IntServMainHdr spec_mh;
    union spec_u
    {
        CtrlLoadFlowspec CL_spec;
        GuarFlowSpec     G_spec;
        QualAppFlowSpec  Q_spec;
    }
}

struct IS_FLOWSPEC
{
    RsvpObjHdr      flow_header;
    IntServFlowSpec flow_body;
}

struct flow_desc
{
    union u1
    {
        SENDER_TSPEC* stspec;
        IS_FLOWSPEC*  isflow;
    }
    union u2
    {
        FILTER_SPEC* stemp;
        FILTER_SPEC* fspec;
    }
}

struct Gads_parms_t
{
    IntServServiceHdr Gads_serv_hdr;
    IntServParmHdr    Gads_Ctot_hdr;
    uint              Gads_Ctot;
    IntServParmHdr    Gads_Dtot_hdr;
    uint              Gads_Dtot;
    IntServParmHdr    Gads_Csum_hdr;
    uint              Gads_Csum;
    IntServParmHdr    Gads_Dsum_hdr;
    uint              Gads_Dsum;
}

struct GenAdspecParams
{
    IntServServiceHdr gen_parm_hdr;
    IntServParmHdr    gen_parm_hopcnt_hdr;
    uint              gen_parm_hopcnt;
    IntServParmHdr    gen_parm_pathbw_hdr;
    float             gen_parm_path_bw;
    IntServParmHdr    gen_parm_minlat_hdr;
    uint              gen_parm_min_latency;
    IntServParmHdr    gen_parm_compmtu_hdr;
    uint              gen_parm_composed_MTU;
}

struct IS_ADSPEC_BODY
{
    IntServMainHdr  adspec_mh;
    GenAdspecParams adspec_genparms;
}

struct ADSPEC
{
    RsvpObjHdr     adspec_header;
    IS_ADSPEC_BODY adspec_body;
}

struct ID_ERROR_OBJECT
{
    ushort   usIdErrLength;
    ubyte    ucAType;
    ubyte    ucSubType;
    ushort   usReserved;
    ushort   usIdErrorValue;
    ubyte[4] ucIdErrData;
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
    int           RsvpMsgType;
    RSVP_SESSION* pRsvpSession;
    RSVP_HOP*     pRsvpFromHop;
    RSVP_HOP*     pRsvpToHop;
    RESV_STYLE*   pResvStyle;
    RSVP_SCOPE*   pRsvpScope;
    int           FlowDescCount;
    flow_desc*    pFlowDescs;
    int           PdObjectCount;
    POLICY_DATA** ppPdObjects;
    ERROR_SPEC*   pErrorSpec;
    ADSPEC*       pAdspec;
}

struct policy_decision
{
    uint   lpvResult;
    ushort wPolicyErrCode;
    ushort wPolicyErrValue;
}

struct LPM_INIT_INFO
{
    uint             PcmVersionNumber;
    uint             ResultTimeLimit;
    int              ConfiguredLpmCount;
    PALLOCMEM        AllocMemory;
    PFREEMEM         FreeMemory;
    CBADMITRESULT    PcmAdmitResultCallback;
    CBGETRSVPOBJECTS GetRsvpObjectsCallback;
}

struct lpmiptable
{
    uint    ulIfIndex;
    uint    MediaType;
    in_addr IfIpAddr;
    in_addr IfNetMask;
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
    BOOL  BottleneckBandwidthSet;
    ulong BottleneckBandwidth;
    BOOL  AvailableBandwidthSet;
    ulong AvailableBandwidth;
    BOOL  RTTSet;
    uint  RTT;
}

struct QOS_FLOWRATE_OUTGOING
{
    ulong               Bandwidth;
    QOS_SHAPING         ShapingBehavior;
    QOS_FLOWRATE_REASON Reason;
}

struct QOS_VERSION
{
    ushort MajorVersion;
    ushort MinorVersion;
}

struct QOS_FRIENDLY_NAME
{
    QOS_OBJECT_HDR ObjectHdr;
    ushort[256]    FriendlyName;
}

struct QOS_TRAFFIC_CLASS
{
    QOS_OBJECT_HDR ObjectHdr;
    uint           TrafficClass;
}

struct QOS_DS_CLASS
{
    QOS_OBJECT_HDR ObjectHdr;
    uint           DSField;
}

struct QOS_DIFFSERV
{
    QOS_OBJECT_HDR ObjectHdr;
    uint           DSFieldCount;
    ubyte[1]       DiffservRule;
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

struct TCI_CLIENT_FUNC_LIST
{
    TCI_NOTIFY_HANDLER ClNotifyHandler;
    TCI_ADD_FLOW_COMPLETE_HANDLER ClAddFlowCompleteHandler;
    TCI_MOD_FLOW_COMPLETE_HANDLER ClModifyFlowCompleteHandler;
    TCI_DEL_FLOW_COMPLETE_HANDLER ClDeleteFlowCompleteHandler;
}

struct ADDRESS_LIST_DESCRIPTOR
{
    uint                 MediaType;
    NETWORK_ADDRESS_LIST AddressList;
}

struct TC_IFC_DESCRIPTOR
{
    uint          Length;
    const(wchar)* pInterfaceName;
    const(wchar)* pInterfaceID;
    ADDRESS_LIST_DESCRIPTOR AddressListDesc;
}

struct TC_SUPPORTED_INFO_BUFFER
{
    ushort      InstanceIDLength;
    ushort[256] InstanceID;
    ulong       InterfaceLuid;
    ADDRESS_LIST_DESCRIPTOR AddrListDesc;
}

struct TC_GEN_FILTER
{
    ushort AddressType;
    uint   PatternSize;
    void*  Pattern;
    void*  Mask;
}

struct TC_GEN_FLOW
{
    FLOWSPEC          SendingFlowspec;
    FLOWSPEC          ReceivingFlowspec;
    uint              TcObjectsLength;
    QOS_OBJECT_HDR[1] TcObjects;
}

struct IP_PATTERN
{
    uint     Reserved1;
    uint     Reserved2;
    uint     SrcAddr;
    uint     DstAddr;
    union S_un
    {
        struct S_un_ports
        {
            ushort s_srcport;
            ushort s_dstport;
        }
        struct S_un_icmp
        {
            ubyte  s_type;
            ubyte  s_code;
            ushort filler;
        }
        uint S_Spi;
    }
    ubyte    ProtocolId;
    ubyte[3] Reserved3;
}

struct IPX_PATTERN
{
    struct Src
    {
        uint     NetworkAddress;
        ubyte[6] NodeAddress;
        ushort   Socket;
    }
    struct Dest
    {
        uint     NetworkAddress;
        ubyte[6] NodeAddress;
        ushort   Socket;
    }
}

struct ENUMERATION_BUFFER
{
    uint             Length;
    uint             OwnerProcessId;
    ushort           FlowNameLength;
    ushort[256]      FlowName;
    TC_GEN_FLOW*     pFlow;
    uint             NumberOfFilters;
    TC_GEN_FILTER[1] GenericFilter;
}

struct QOS
{
    FLOWSPEC SendingFlowspec;
    FLOWSPEC ReceivingFlowspec;
    WSABUF   ProviderSpecific;
}

// Functions

@DllImport("qwave")
BOOL QOSCreateHandle(QOS_VERSION* Version, ptrdiff_t* QOSHandle);

@DllImport("qwave")
BOOL QOSCloseHandle(HANDLE QOSHandle);

@DllImport("qwave")
BOOL QOSStartTrackingClient(HANDLE QOSHandle, SOCKADDR* DestAddr, uint Flags);

@DllImport("qwave")
BOOL QOSStopTrackingClient(HANDLE QOSHandle, SOCKADDR* DestAddr, uint Flags);

@DllImport("qwave")
BOOL QOSEnumerateFlows(HANDLE QOSHandle, uint* Size, char* Buffer);

@DllImport("qwave")
BOOL QOSAddSocketToFlow(HANDLE QOSHandle, size_t Socket, SOCKADDR* DestAddr, QOS_TRAFFIC_TYPE TrafficType, 
                        uint Flags, uint* FlowId);

@DllImport("qwave")
BOOL QOSRemoveSocketFromFlow(HANDLE QOSHandle, size_t Socket, uint FlowId, uint Flags);

@DllImport("qwave")
BOOL QOSSetFlow(HANDLE QOSHandle, uint FlowId, QOS_SET_FLOW Operation, uint Size, char* Buffer, uint Flags, 
                OVERLAPPED* Overlapped);

@DllImport("qwave")
BOOL QOSQueryFlow(HANDLE QOSHandle, uint FlowId, QOS_QUERY_FLOW Operation, uint* Size, char* Buffer, uint Flags, 
                  OVERLAPPED* Overlapped);

@DllImport("qwave")
BOOL QOSNotifyFlow(HANDLE QOSHandle, uint FlowId, QOS_NOTIFY_FLOW Operation, uint* Size, char* Buffer, uint Flags, 
                   OVERLAPPED* Overlapped);

@DllImport("qwave")
BOOL QOSCancel(HANDLE QOSHandle, OVERLAPPED* Overlapped);

@DllImport("TRAFFIC")
uint TcRegisterClient(uint TciVersion, HANDLE ClRegCtx, TCI_CLIENT_FUNC_LIST* ClientHandlerList, 
                      ptrdiff_t* pClientHandle);

@DllImport("TRAFFIC")
uint TcEnumerateInterfaces(HANDLE ClientHandle, uint* pBufferSize, TC_IFC_DESCRIPTOR* InterfaceBuffer);

@DllImport("TRAFFIC")
uint TcOpenInterfaceA(const(char)* pInterfaceName, HANDLE ClientHandle, HANDLE ClIfcCtx, ptrdiff_t* pIfcHandle);

@DllImport("TRAFFIC")
uint TcOpenInterfaceW(const(wchar)* pInterfaceName, HANDLE ClientHandle, HANDLE ClIfcCtx, ptrdiff_t* pIfcHandle);

@DllImport("TRAFFIC")
uint TcCloseInterface(HANDLE IfcHandle);

@DllImport("TRAFFIC")
uint TcQueryInterface(HANDLE IfcHandle, GUID* pGuidParam, ubyte NotifyChange, uint* pBufferSize, char* Buffer);

@DllImport("TRAFFIC")
uint TcSetInterface(HANDLE IfcHandle, GUID* pGuidParam, uint BufferSize, char* Buffer);

@DllImport("TRAFFIC")
uint TcQueryFlowA(const(char)* pFlowName, GUID* pGuidParam, uint* pBufferSize, char* Buffer);

@DllImport("TRAFFIC")
uint TcQueryFlowW(const(wchar)* pFlowName, GUID* pGuidParam, uint* pBufferSize, char* Buffer);

@DllImport("TRAFFIC")
uint TcSetFlowA(const(char)* pFlowName, GUID* pGuidParam, uint BufferSize, char* Buffer);

@DllImport("TRAFFIC")
uint TcSetFlowW(const(wchar)* pFlowName, GUID* pGuidParam, uint BufferSize, char* Buffer);

@DllImport("TRAFFIC")
uint TcAddFlow(HANDLE IfcHandle, HANDLE ClFlowCtx, uint Flags, TC_GEN_FLOW* pGenericFlow, ptrdiff_t* pFlowHandle);

@DllImport("TRAFFIC")
uint TcGetFlowNameA(HANDLE FlowHandle, uint StrSize, const(char)* pFlowName);

@DllImport("TRAFFIC")
uint TcGetFlowNameW(HANDLE FlowHandle, uint StrSize, const(wchar)* pFlowName);

@DllImport("TRAFFIC")
uint TcModifyFlow(HANDLE FlowHandle, TC_GEN_FLOW* pGenericFlow);

@DllImport("TRAFFIC")
uint TcAddFilter(HANDLE FlowHandle, TC_GEN_FILTER* pGenericFilter, ptrdiff_t* pFilterHandle);

@DllImport("TRAFFIC")
uint TcDeregisterClient(HANDLE ClientHandle);

@DllImport("TRAFFIC")
uint TcDeleteFlow(HANDLE FlowHandle);

@DllImport("TRAFFIC")
uint TcDeleteFilter(HANDLE FilterHandle);

@DllImport("TRAFFIC")
uint TcEnumerateFlows(HANDLE IfcHandle, ptrdiff_t* pEnumHandle, uint* pFlowCount, uint* pBufSize, 
                      ENUMERATION_BUFFER* Buffer);


