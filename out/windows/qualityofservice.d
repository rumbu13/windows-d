// Written in the D programming language.

module windows.qualityofservice;

public import windows.core;
public import windows.nativewifi : NETWORK_ADDRESS_LIST;
public import windows.systemservices : BOOL, HANDLE, OVERLAPPED;
public import windows.winsock : SOCKADDR, WSABUF, in_addr;

extern(Windows):


// Enums


alias int_serv_wkp = int;
enum : int
{
    IS_WKP_HOP_CNT      = 0x00000004,
    IS_WKP_PATH_BW      = 0x00000006,
    IS_WKP_MIN_LATENCY  = 0x00000008,
    IS_WKP_COMPOSED_MTU = 0x0000000a,
    IS_WKP_TB_TSPEC     = 0x0000007f,
    IS_WKP_Q_TSPEC      = 0x00000080,
}

///The <b>QOS_TRAFFIC_TYPE</b> enumeration defines the various traffic types. Each flow has a single traffic type. This
///allows the QOS subsystem to apply user-specified policies to each type.
alias QOS_TRAFFIC_TYPE = int;
enum : int
{
    ///Flow traffic has the same network priority as regular traffic not associated with QOS. This traffic type is the
    ///same as not specifying priority, and as a result, the DSCP mark and 802.1p tag are not added to sent traffic.
    QOSTrafficTypeBestEffort      = 0x00000000,
    ///Flow traffic has a network priority lower than that of <b>QOSTrafficTypeBestEffort</b>. This traffic type could
    ///be used for traffic of an application doing data backup. Sent traffic will contain a DSCP mark with a value of
    ///0x08 and an 802.1p tag with a value of 2.
    QOSTrafficTypeBackground      = 0x00000001,
    ///Flow traffic has a network priority higher than <b>QOSTrafficTypeBestEffort</b>, yet lower than
    ///<b>QOSTrafficTypeAudioVideo</b>. This traffic type should be used for data traffic that is more important than
    ///normal end-user scenarios, such as email. Sent traffic will contain a DSCP mark with value of 0x28 and 802.1p tag
    ///with a value of 5.
    QOSTrafficTypeExcellentEffort = 0x00000002,
    ///Flow traffic has a network priority higher than <b>QOSTrafficTypeExcellentEffort</b>, yet lower than
    ///<b>QOSTrafficTypeVoice</b>. This traffic type should be used for A/V streaming scenarios such as MPEG2 streaming.
    ///Sent traffic will contain a DSCP mark with a value of 0x28 and an 802.1p tag with a value of 5.
    QOSTrafficTypeAudioVideo      = 0x00000003,
    ///Flow traffic has a network priority higher than <b>QOSTrafficTypeAudioVideo</b>, yet lower than
    ///<b>QOSTrafficTypeControl</b>. This traffic type should be used for realtime voice streams such as VOIP. Sent
    ///traffic will contain a DSCP mark with a value of 0x38 and an 802.1p tag with a value of 7.
    QOSTrafficTypeVoice           = 0x00000004,
    ///Flow traffic has the highest network priority. This traffic type should only be used for the most critical of
    ///data. For example, it may be used for data carrying user inputs. Sent traffic will contain a DSCP mark with a
    ///value of 0x38 and an 802.1p tag with a value of 7.
    QOSTrafficTypeControl         = 0x00000005,
}

///The <b>QOS_SET_FLOW</b> enumeration indicates what is being changed about a flow.
alias QOS_SET_FLOW = int;
enum : int
{
    ///Indicates that the traffic type of the flow will change.
    QOSSetTrafficType       = 0x00000000,
    ///Indicates that the flow rate will change.
    QOSSetOutgoingRate      = 0x00000001,
    ///Windows 7, Windows Server 2008 R2, and later: Indicates that the outgoing DSCP value will change. <div
    ///class="alert"><b>Note</b> This setting requires the calling application be a member of the Administrators or the
    ///Network Configuration Operators group.</div> <div> </div>
    QOSSetOutgoingDSCPValue = 0x00000002,
}

///The <b>QOS_FLOWRATE_REASON</b> enumeration indicates the reason for a change in a flow's bandwidth.
alias QOS_FLOWRATE_REASON = int;
enum : int
{
    ///Indicates that there has not been a change in the flow.
    QOSFlowRateNotApplicable         = 0x00000000,
    ///Indicates that the content of a flow has changed.
    QOSFlowRateContentChange         = 0x00000001,
    ///Indicates that the flow has changed due to congestion.
    QOSFlowRateCongestion            = 0x00000002,
    QOSFlowRateHigherContentEncoding = 0x00000003,
    ///Indicates that the user has caused the flow to change.
    QOSFlowRateUserCaused            = 0x00000004,
}

///The <b>QOS_SHAPING</b> enumeration defines the shaping behavior of a flow.
alias QOS_SHAPING = int;
enum : int
{
    ///Indicates that the Windows packet scheduler (Pacer) will be used to enforce the requested flow rate. Data packets
    ///that exceed the rate are delayed until appropriate in order to maintain the specified flow rate. If the network
    ///supports prioritization, packets will always receive conformant priority values when QOSShapeFlow is specified.
    QOSShapeOnly                = 0x00000000,
    ///Indicates that the Windows Scheduler will be used to enforce the requested flow rate. Data packets exceeding the
    ///rate are delayed accordingly. Packets receive conformant priority values.
    QOSShapeAndMark             = 0x00000001,
    ///Indicates that the flow rate requested will not be enforced. Data packets that would exceed the flow rate will
    ///receive a priority that indicates they are non-conformant. This may lead to lost and reordered packets.
    QOSUseNonConformantMarkings = 0x00000002,
}

///The <b>QOS_QUERY_FLOW</b> enumeration indicates the type of information a QOSQueryFlow function will request.
alias QOS_QUERY_FLOW = int;
enum : int
{
    ///Indicates an information request for the flow fundamentals. This information includes bottleneck bandwidth,
    ///available bandwidth, and the average Round Trip Time (RTT)
    QOSQueryFlowFundamentals = 0x00000000,
    ///Indicates a request for information detailing the QoS priority being added to flow packets.
    QOSQueryPacketPriority   = 0x00000001,
    ///Indicates a request for the flow rate specified during the creation of an agreement with the QoS subsystem via
    ///the QOSSetFlow function.
    QOSQueryOutgoingRate     = 0x00000002,
}

///The <b>QOS_NOTIFY_FLOW</b> enumeration specifies the circumstances that must be present for the QOSNotifyFlow
///function to send a notification.
alias QOS_NOTIFY_FLOW = int;
enum : int
{
    ///Notifications will be sent when congestion is detected. If the flow is currently congested, a notification may be
    ///sent immediately.
    QOSNotifyCongested   = 0x00000000,
    ///Notifications will be sent when the flow is not congested. If the flow is currently uncongested, a notification
    ///may be sent immediately.
    QOSNotifyUncongested = 0x00000001,
    ///Notifications will be sent when the flow's available capacity is sufficient to allow upgrading it's bandwidth to
    ///a specified capacity.
    QOSNotifyAvailable   = 0x00000002,
}

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

///The <i>PALLOCMEM</i> function is a memory allocation function provided by the PCM, used for allocating memory when
///returning policy information to the PCM. The <i>PALLOCMEM</i> function is supplied as a parameter of the
///LPM_Initialize function, and allows the SBM to experiment with different memory-management schemes without requiring
///recompilation of LPMs.
///Params:
///    Size = Size of the memory buffer required by the LPM.
///    szFileName = 
///    nLine = 
///Returns:
///    Returns a pointer to the requested memory allocation.
///    
alias PALLOCMEM = void* function(uint Size);
///The <i>PFREEMEM</i> function is a memory-freeing function provided by the PCM. <i>PFREEMEM</i> frees memory buffers
///that were allocated using PALLOCMEM. The <i>PFREEMEM</i> function is supplied as a parameter of the LPM_Initialize
///function. The combination of <i>PALLOCMEM</i> and <i>PFREEMEM</i> allows the SBM to experiment with different
///memory-management schemes without requiring recompilation of LPMs.
///Params:
///    pv = Pointer to the memory buffer to free.
///    szFileName = 
///    nLine = 
alias PFREEMEM = void function(void* pv);
///The <i>cbAdmitResult</i> function is used by LPMs to return results for the LPM_AdmitRsvpMsg request. LPMs should
///only use this function if they have returned LPM_RESULT_DEFER to the <i>LPM_AdmitRsvpMsg</i> function call. The PCM
///will only accept results from this function within the result time limit established by each LPM through the
///<i>ResultTimeLimit</i> parameter of the LPM_Initialize function.
///Params:
///    LpmHandle = Unique handle for the LPM, as supplied in LPM_Initialize. The PCM will ignore any result that is not accompanied
///                by a valid LPM handle.
///    RequestHandle = Unique handle that distinguishes this request from all other requests. LPMs must pass this handle to the PCM when
///                    returning results asynchronously for an individual request by calling <i>cbAdmitResult</i>. The
///                    <i>RequestHandle</i> parameter becomes invalid once results are returned, requiring each request to get its own
///                    unique <i>RequestHandle</i> from the PCM.
///    ulPcmActionFlags = Policy Control Module action flags.
///    LpmError = LPM error code. Must be one of the following: <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td
///               width="40%"><a id="INV_LPM_HANDLE"></a><a id="inv_lpm_handle"></a><dl> <dt><b>INV_LPM_HANDLE</b></dt> </dl> </td>
///               <td width="60%"> The supplied LPM handle is invalid. </td> </tr> <tr> <td width="40%"><a id="LPM_TIME_OUT"></a><a
///               id="lpm_time_out"></a><dl> <dt><b>LPM_TIME_OUT</b></dt> </dl> </td> <td width="60%"> The LPM has returned results
///               after the time limit. </td> </tr> <tr> <td width="40%"><a id="INV_REQ_HANDLE"></a><a id="inv_req_handle"></a><dl>
///               <dt><b>INV_REQ_HANDLE</b></dt> </dl> </td> <td width="60%"> The supplied request handle is invalid. </td> </tr>
///               <tr> <td width="40%"><a id="DUP_RESULTS"></a><a id="dup_results"></a><dl> <dt><b>DUP_RESULTS</b></dt> </dl> </td>
///               <td width="60%"> The LPM has already returned results for this request. </td> </tr> <tr> <td width="40%"><a
///               id="INV_RESULTS"></a><a id="inv_results"></a><dl> <dt><b>INV_RESULTS</b></dt> </dl> </td> <td width="60%"> The
///               results supplied are invalid. </td> </tr> </table>
///    PolicyDecisionsCount = The number of policy decisions provided in <b>pPolicyDecisions</b>.
///    pPolicyDecisions = Policy decisions, in the form of one or more <b>POLICY_DECISION</b> structures.
///Returns:
///    This callback function does not return a value.
///    
alias CBADMITRESULT = uint* function(LPM_HANDLE__* LpmHandle, RHANDLE__* RequestHandle, uint ulPcmActionFlags, 
                                     int LpmError, int PolicyDecisionsCount, policy_decision* pPolicyDecisions);
///The <i>cbGetRsvpObjects</i> function is a callback function for LPMs to asynchronously return results for
///LPM_GetRsvpObjects requests. LPMs call the <i>cbGetRsvpObjects</i> function to asynchronously return policy data
///objects to the PCM for an <i>LPM_GetRsvpObjects</i> request. An LPM should only use the <i>cbGetRsvpObjects</i>
///function if it returned LPM_RESULTS_DEFER to the PCM's <i>LPM_GetRsvpObjects</i> request.
///Params:
///    LpmHandle = Unique handle for the LPM, as supplied in LPM_Initialize. The PCM will ignore any result that is not accompanied
///                by a valid handle.
///    RequestHandle = Unique handle that distinguishes this request from all other requests, provided from the corresponding
///                    LPM_GetRsvpObjects request.
///    LpmError = Error value, used by the PCM to determine whether the policy data objects returned with this function should be
///               used. Any value other than LPM_OK will result in the PCM ignoring the contents of *<i>RsvpObjects</i>. Note that
///               if an LPM is returning an error, it should free buffers allocated during the LPM_GetRsvpObjects request
///               processing; these buffers should have been allocated using the <b>MemoryAllocator</b> function, supplied within
///               the LPM_Initialize function as its <i>FreeMemory</i> parameter. If no policy data objects are being returned,
///               <i>LpmError</i> must be set to LPM_OK, <i>RsvpObjectsCount</i> must be set to zero, and *<i>RsvpObjects</i> must
///               be set to null. The LPM can force the SBM to stop sending out the RSVP message by setting the value of
///               <i>LpmError</i> to LPV_DROP_MSG.
///    RsvpObjectsCount = Number of policy data objects being returned. If no policy data objects are being returned, the <i>LpmError</i>
///                       parameter must be set to LPM_OK, the <i>RsvpObjectsCount</i> parameter must be set to zero, and the
///                       *<i>RsvpObjects</i> parameter must be set to null.
///    ppRsvpObjects = Array of pointers to policy data object. The buffer containing the policy data objects should be allocated using
///                    the <b>MemoryAllocator</b> function supplied within the LPM_Initialize function. The Subnet Bandwidth Manager
///                    (SBM) will free the policy data objects when they are no longer needed. If no policy data objects are being
///                    returned, <i>LpmError</i> must be set to LPM_OK, <i>RsvpObjectsCount</i> must be set to zero, and
///                    *<i>RsvpObjects</i> must be set to null.
///Returns:
///    Return values are defined by the application providing the callback.
///    
alias CBGETRSVPOBJECTS = uint* function(LPM_HANDLE__* LpmHandle, RHANDLE__* RequestHandle, int LpmError, 
                                        int RsvpObjectsCount, RsvpObjHdr** ppRsvpObjects);
///The <i>ClNotifyHandler</i> function is used by traffic control to notify the client of various traffic
///control–specific events, including the deletion of flows, changes in filter parameters, or the closing of an
///interface. The <i>ClNotifyHandler</i> callback function should be exposed by all clients using traffic control
///services.
///Params:
///    ClRegCtx = Client registration context, provided to traffic control by the client with the client's call to the
///               TcRegisterClient function.
///    ClIfcCtx = Client interface context, provided to traffic control by the client with the client's call to the TcOpenInterface
///               function. Note that during a TC_NOTIFY_IFC_UP event, <i>ClIfcCtx</i> is not available and will be set to
///               <b>NULL</b>.
///    Event = Describes the notification event. See the Remarks section for a list of notification events.
///    SubCode = Handle used to further qualify a notification event. See Note below for 64-bit for Windows programming issues.
///    BufSize = Size of the buffer included with the notification event, in bytes.
///    Buffer = Buffer containing the detailed event information associated with <i>Event</i> and <i>SubCode</i>.
alias TCI_NOTIFY_HANDLER = void function(HANDLE ClRegCtx, HANDLE ClIfcCtx, uint Event, HANDLE SubCode, 
                                         uint BufSize, char* Buffer);
///The <b>ClAddFlowComplete</b> function is used by traffic control to notify the client of the completion of its
///previous call to the TcAddFlow function. The <b>ClAddFlowComplete</b> callback function is optional. If this function
///is not specified, TcAddFlow will block until it completes.
///Params:
///    ClFlowCtx = Client provided–flow context handle. This can be the container used to hold an arbitrary client-defined context
///                for this instance of the client. This value will be the same as the value provided by the client during its
///                corresponding call to TcAddFlow.
///    Status = Completion status for the TcAddFlow request. This value may be any of the return values possible for the
///             <b>TcAddFlow</b> function, with the exception of ERROR_SIGNAL_PENDING. <div class="alert"><b>Note</b> Use of the
///             <b>ClAddFlowComplete</b> function requires administrative privilege.</div> <div> </div>
alias TCI_ADD_FLOW_COMPLETE_HANDLER = void function(HANDLE ClFlowCtx, uint Status);
///The <b>ClModifyFlowComplete</b> function is used by traffic control to notify the client of the completion of its
///previous call to the TcModifyFlow function. The <b>ClModifyFlowComplete</b> callback function is optional. If this
///function is not specified, TcModifyFlow will block until it completes.
///Params:
///    ClFlowCtx = Client provided–flow context handle. This can be the container used to hold an arbitrary client-defined context
///                for this instance of the client. This value will be the same as the value provided by the client during its
///                corresponding call to TcModifyFlow.
///    Status = Completion status for the TcModifyFlow request. This value may be any of the return values possible for the
///             <b>TcModifyFlow</b> function, with the exception of ERROR_SIGNAL_PENDING. <div class="alert"><b>Note</b> Use of
///             the <b>ClModifyFlowComplete</b> function requires administrative privilege.</div> <div> </div>
alias TCI_MOD_FLOW_COMPLETE_HANDLER = void function(HANDLE ClFlowCtx, uint Status);
///The <b>ClDeleteFlowComplete</b> function is used by traffic control to notify the client of the completion of its
///previous call to the TcDeleteFlow function. The <b>ClDeleteFlowComplete</b> callback function is optional. If this
///function is not specified, TcDeleteFlow will block until it completes.
///Params:
///    ClFlowCtx = Client provided–flow context handle. This can be the container used to hold an arbitrary client-defined context
///                for this instance of the client. This value will be the same as the value provided by the client during its
///                corresponding call to TcDeleteFlow.
///    Status = Completion status for the TcDeleteFlow request. This value may be any of the return values possible for the
///             <b>TcDeleteFlow</b> function, with the exception of ERROR_SIGNAL_PENDING. <div class="alert"><b>Note</b> Use of
///             the <b>ClDeleteFlowComplete</b> function requires administrative privilege.</div> <div> </div>
alias TCI_DEL_FLOW_COMPLETE_HANDLER = void function(HANDLE ClFlowCtx, uint Status);

// Structs


///The <b>FLOWSPEC</b> structure provides quality of service parameters to the RSVP SP. This allows QOS-aware
///applications to invoke, modify, or remove QOS settings for a given flow. Some members of <b>FLOWSPEC</b> can be set
///to default values. See Remarks for more information.
struct FLOWSPEC
{
    ///Specifies the permitted rate at which data can be transmitted over the life of the flow. The <b>TokenRate</b>
    ///member is similar to other token bucket models seen in such WAN technologies as Frame Relay, in which the token
    ///is analogous to a credit. If such tokens are not used immediately, they accrue to allow data transmission up to a
    ///certain periodic limit (<b>PeakBandwidth</b>, in the case of Windows 2000 quality of service). Accrual of credits
    ///is limited, however, to a specified amount (<b>TokenBucketSize</b>). Limiting total credits (tokens) avoids
    ///situations where, for example, flows that are inactive for some time flood the available bandwidth with their
    ///large amount of accrued tokens. Because flows may accrue transmission credits over time (at their
    ///<b>TokenRate</b> value) only up to the maximum of their <b>TokenBucketSize</b>, and because they are limited in
    ///burst transmissions to their <b>PeakBandwidth</b>, traffic control and network-device resource integrity are
    ///maintained. Traffic control is maintained because flows cannot send too much data at once, and network-device
    ///resource integrity is maintained because such devices are spared high traffic bursts. With this model,
    ///applications can transmit data only when sufficient credits are available. If sufficient credits are not
    ///available, the application must either wait or discard the traffic (based on the value of QOS_SD_MODE).
    ///Therefore, it is important that applications base their <b>TokenRate</b> requests on reasonable expectations for
    ///transmission requirements. For example, in video applications, <b>TokenRate</b> is typically set to the average
    ///bit rate from peak to peak. If <b>TokenRate</b> is set to QOS_NOT_SPECIFIED on the receiver only, the maximum
    ///transmission unit (MTU) is used for <b>TokenRate</b>, and limits on the transmission rate (the token bucket
    ///model) will not be put into effect. Thus, <b>TokenRate</b> is expressed in bytes per second. The <b>TokenRate</b>
    ///member cannot be set to zero. Nor can it be set as a default (that is, set to QOS_NOT_SPECIFIED) in a sending
    ///<b>FLOWSPEC</b>.
    uint TokenRate;
    ///The maximum amount of credits a given direction of a flow can accrue, regardless of time, in bytes. In video
    ///applications, <b>TokenBucketSize</b> will likely be the largest average frame size. In constant rate
    ///applications, <b>TokenBucketSize</b> should be set to allow for small variations.
    uint TokenBucketSize;
    ///The upper limit on time-based transmission permission for a given flow, in bytes per second. The
    ///<b>PeakBandwidth</b> member restricts flows that may have accrued a significant amount of transmission credits,
    ///or tokens from overburdening network resources with one-time or cyclical data bursts, by enforcing a per-second
    ///data transmission ceiling. Some intermediate systems can take advantage of this information, resulting in more
    ///efficient resource allocation.
    uint PeakBandwidth;
    ///Maximum acceptable delay between transmission of a bit by the sender and its receipt by one or more intended
    ///receivers, in microseconds. The precise interpretation of this number depends on the level of guarantee specified
    ///in the QOS request.
    uint Latency;
    ///Difference between the maximum and minimum possible delay a packet will experience, in microseconds. Applications
    ///use <b>DelayVariation</b> to determine the amount of buffer space needed at the receiving end of the flow. This
    ///buffer space information can be used to restore the original data transmission pattern.
    uint DelayVariation;
    ///Specifies the level of service to negotiate for the flow. The <b>ServiceType</b> member can be one of the
    ///following defined service types. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
    ///id="SERVICETYPE_NOTRAFFIC"></a><a id="servicetype_notraffic"></a><dl> <dt><b>SERVICETYPE_NOTRAFFIC</b></dt> </dl>
    ///</td> <td width="60%"> Indicates that no traffic will be transmitted in the specified direction. On
    ///duplex-capable media, this value signals underlying software to set up unidirectional connections only. This
    ///service type is not valid for the TC API. </td> </tr> <tr> <td width="40%"><a id="SERVICETYPE_BESTEFFORT"></a><a
    ///id="servicetype_besteffort"></a><dl> <dt><b>SERVICETYPE_BESTEFFORT</b></dt> </dl> </td> <td width="60%"> Results
    ///in no action taken by the RSVP SP. Traffic control does create a BESTEFFORT flow, however, and traffic on the
    ///flow will be handled by traffic control similarly to other BESTEFFORT traffic. </td> </tr> <tr> <td
    ///width="40%"><a id="SERVICETYPE_CONTROLLEDLOAD"></a><a id="servicetype_controlledload"></a><dl>
    ///<dt><b>SERVICETYPE_CONTROLLEDLOAD</b></dt> </dl> </td> <td width="60%"> Provides an end-to-end QOS that closely
    ///approximates transmission quality provided by best-effort service, as expected under unloaded conditions from the
    ///associated network components along the data path. Applications that use SERVICETYPE_CONTROLLEDLOAD may therefore
    ///assume the following: <ul> <li>The network will deliver a very high percentage of transmitted packets to its
    ///intended receivers. In other words, packet loss will closely approximate the basic packet error rate of the
    ///transmission medium.</li> <li>Transmission delay for a very high percentage of the delivered packets will not
    ///greatly exceed the minimum transit delay experienced by any successfully delivered packet.</li> </ul> </td> </tr>
    ///<tr> <td width="40%"><a id="SERVICETYPE_GUARANTEED"></a><a id="servicetype_guaranteed"></a><dl>
    ///<dt><b>SERVICETYPE_GUARANTEED</b></dt> </dl> </td> <td width="60%"> Guarantees that datagrams will arrive within
    ///the guaranteed delivery time and will not be discarded due to queue overflows, provided the flow's traffic stays
    ///within its specified traffic parameters. This service is intended for applications that need a firm guarantee
    ///that a datagram will arrive no later than a certain time after it was transmitted by its source. </td> </tr> <tr>
    ///<td width="40%"><a id="SERVICETYPE_QUALITATIVE"></a><a id="servicetype_qualitative"></a><dl>
    ///<dt><b>SERVICETYPE_QUALITATIVE</b></dt> </dl> </td> <td width="60%"> Indicates that the application requires
    ///better than BESTEFFORT transmission, but cannot quantify its transmission requirements. Applications that use
    ///SERVICETYPE_QUALITATIVE can supply an application identifier policy object. The application identification policy
    ///object enables policy servers on the network to identify the application, and accordingly, assign an appropriate
    ///quality of service to the request. For more information on application identification, consult the IETF Internet
    ///Draft draft-ietf-rap-rsvp-appid-00.txt, or the Microsoft white paper on Application Identification. Traffic
    ///control treats flows of this type with the same priority as BESTEFFORT traffic on the local computer. However,
    ///application programmers can get boosted priority for such flows by modifying the Layer 2 settings on the
    ///associated flow using the QOS_TRAFFIC_CLASS QOS object. </td> </tr> <tr> <td width="40%"><a
    ///id="SERVICETYPE_NETWORK_UNAVAILBLE"></a><a id="servicetype_network_unavailble"></a><dl>
    ///<dt><b>SERVICETYPE_NETWORK_UNAVAILBLE</b></dt> </dl> </td> <td width="60%"> Used to notify network changes. </td>
    ///</tr> <tr> <td width="40%"><a id="SERVICETYPE_NETWORK_CONTROL"></a><a id="servicetype_network_control"></a><dl>
    ///<dt><b>SERVICETYPE_NETWORK_CONTROL</b></dt> </dl> </td> <td width="60%"> Used only for transmission of control
    ///packets (such as RSVP signaling messages). This <b>ServiceType</b> has the highest priority. </td> </tr> <tr> <td
    ///width="40%"><a id="SERVICETYPE_GENERAL_INFORMATION"></a><a id="servicetype_general_information"></a><dl>
    ///<dt><b>SERVICETYPE_GENERAL_INFORMATION</b></dt> </dl> </td> <td width="60%"> Specifies that all service types are
    ///supported for a flow. Can be used on sender side only. </td> </tr> <tr> <td width="40%"><a
    ///id="SERVICETYPE_NOCHANGE"></a><a id="servicetype_nochange"></a><dl> <dt><b>SERVICETYPE_NOCHANGE</b></dt> </dl>
    ///</td> <td width="60%"> Indicates that the quality of service in the transmission using this <b>ServiceType</b>
    ///value is not changed. SERVICETYPE_NOCHANGE can be used when requesting a change in the quality of service for one
    ///direction only, or when requesting a change only within the ProviderSpecific parameters of a QOS specification,
    ///and not in the <b>SendingFlowspec</b> or <b>ReceivingFlowspec</b>. </td> </tr> <tr> <td width="40%"><a
    ///id="SERVICETYPE_NONCONFORMING"></a><a id="servicetype_nonconforming"></a><dl>
    ///<dt><b>SERVICETYPE_NONCONFORMING</b></dt> </dl> </td> <td width="60%"> Used to indicate nonconforming traffic.
    ///</td> </tr> <tr> <td width="40%"><a id="SERVICE_NO_TRAFFIC_CONTROL"></a><a
    ///id="service_no_traffic_control"></a><dl> <dt><b>SERVICE_NO_TRAFFIC_CONTROL</b></dt> </dl> </td> <td width="60%">
    ///Indicates that traffic control should not be invoked in the specified direction. </td> </tr> <tr> <td
    ///width="40%"><a id="SERVICE_NO_QOS_SIGNALING"></a><a id="service_no_qos_signaling"></a><dl>
    ///<dt><b>SERVICE_NO_QOS_SIGNALING</b></dt> </dl> </td> <td width="60%"> Suppresses RSVP signaling in the specified
    ///direction. </td> </tr> </table> The following list identifies the relative priority of <b>ServiceType</b>
    ///settings: SERVICETYPE_NETWORK_CONTROL SERVICETYPE_GUARANTEED SERVICETYPE_CONTROLLED_LOAD SERVICETYPE_BESTEFFORT
    ///SERVICETYPE_QUALITATIVE Non-conforming traffic For a simple example, if a given network device were
    ///resource-bounded and had to choose among transmitting a packet from one of the above <b>ServiceType</b> settings,
    ///it would first send a packet of SERVICETYPE_NETWORKCONTROL, and if there were no packets of that
    ///<b>ServiceType</b> requiring transmission it would send a packet of <b>ServiceType</b> SERVICETYPE_GUARANTEED,
    ///and so on.
    uint ServiceType;
    ///Specifies the maximum packet size permitted or used in the traffic flow, in bytes.
    uint MaxSduSize;
    ///Specifies the minimum packet size for which the requested quality of service will be provided, in bytes. Packets
    ///smaller than this size are treated by traffic control as <b>MinimumPolicedSize</b>. When using the
    ///<b>FLOWSPEC</b> structure in association with RSVP, the value of <b>MinimumPolicedSize</b> cannot be zero;
    ///however, if you are using the <b>FLOWSPEC</b> structure specifically with the TC API, you can set
    ///<b>MinimumPolicedSize</b> to zero.
    uint MinimumPolicedSize;
}

///The QOS object <b>QOS_OBJECT_HDR</b> is attached to each QOS object. It specifies the object type and its length.
struct QOS_OBJECT_HDR
{
    ///Specifies the type of object to which <b>QOS_OBJECT_HDR</b> is attached. The following values are valid for
    ///<b>QOS_OBJECT_HDR</b>: <a id="QOS_OBJECT_DESTADDR"></a> <a id="qos_object_destaddr"></a>
    uint ObjectType;
    ///Specifies the length of the attached object, inclusive of QOS_OBJECT_HDR.
    uint ObjectLength;
}

///The QOS object <b>QOS_SD_MODE</b> defines the behavior of the traffic control-packet shaper component.
struct QOS_SD_MODE
{
    ///The QOS object QOS_OBJECT_HDR. The object type for this QOS object should be <b>QOS_SD_MODE</b>.
    QOS_OBJECT_HDR ObjectHdr;
    ///Specifies the requested behavior of the packet shaper. Note that there are elements of packet handling within
    ///these predefined behaviors that depend on the flow settings specified within FLOWSPEC. <table> <tr>
    ///<th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="TC_NONCONF_BORROW"></a><a
    ///id="tc_nonconf_borrow"></a><dl> <dt><b>TC_NONCONF_BORROW</b></dt> </dl> </td> <td width="60%"> This mode is
    ///currently only available to the TC API. It is not available to users of the QOS API. Instructs the packet shaper
    ///to borrow remaining available resources after all higher priority flows have been serviced. If the
    ///<b>TokenRate</b> member of FLOWSPEC is specified for this flow, packets that exceed the value of <b>TokenRate</b>
    ///will have their priority demoted to less than SERVICETYPE_BESTEFFORT, as defined in the <b>ServiceType</b> member
    ///of the <b>FLOWSPEC</b> structure. </td> </tr> <tr> <td width="40%"><a id="TC_NONCONF_SHAPE"></a><a
    ///id="tc_nonconf_shape"></a><dl> <dt><b>TC_NONCONF_SHAPE</b></dt> </dl> </td> <td width="60%"> Instructs the packet
    ///shaper to retain packets until network resources are available to the flow in sufficient quantity to make such
    ///packets conforming. (For example, a 100K packet will be retained in the packet shaper until 100K worth of credit
    ///is accrued for the flow, allowing the packet to be transmitted as conforming). Note that TokenRate must be
    ///specified if using TC_NONCONF_SHAPE. </td> </tr> <tr> <td width="40%"><a id="TC_NONCONF_DISCARD"></a><a
    ///id="tc_nonconf_discard"></a><dl> <dt><b>TC_NONCONF_DISCARD</b></dt> </dl> </td> <td width="60%"> Instructs the
    ///packet shaper to discard all nonconforming packets. TC_NONCONF_DISCARD should be used with care. </td> </tr>
    ///</table>
    uint           ShapeDiscardMode;
}

///The QOS object <b>QOS_SHAPING_RATE</b> specifies the uniform traffic shaping rate be applied to a given flow.
struct QOS_SHAPING_RATE
{
    ///The QOS object QOS_OBJECT_HDR. The object type for this QOS object should be <b>QOS_SHAPING_RATE</b>.
    QOS_OBJECT_HDR ObjectHdr;
    ///Unsigned 32-bit integer that specifies the uniform traffic shaping rate in bytes per second.
    uint           ShapingRate;
}

///The <b>RsvpObjHdr</b> structure provides an object header for an RSVP message.
struct RsvpObjHdr
{
    ///Object length, in bytes.
    ushort obj_length;
    ///Object class. Must be one of the following:
    ubyte  obj_class;
    ///Object C-Type. Must be one of the following:
    ubyte  obj_ctype;
}

///The <b>Session_IPv4</b> structure stores information about an IPv4 RSVP SESSION object.
struct Session_IPv4
{
    ///Destination IP address for the session.
    in_addr sess_destaddr;
    ///Protocol ID for the session.
    ubyte   sess_protid;
    ///Session flags.
    ubyte   sess_flags;
    ///Destination IP address for the session.
    ushort  sess_destport;
}

///The <b>RSVP_SESSION</b> structure stores information about an RSVP SESSION message.
struct RSVP_SESSION
{
    ///RSVP Object Header, in the form of an RsvpObjHdr structure.
    RsvpObjHdr sess_header;
    union sess_u
    {
        Session_IPv4 sess_ipv4;
    }
}

///The <b>Rsvp_Hop_IPv4</b> structure stores information about an RSVP-enabled IPv4 hop.
struct Rsvp_Hop_IPv4
{
    ///The next or previous hop IP address, in the form of an in_addr structure.
    in_addr hop_ipaddr;
    ///Logical Interface Handle.
    uint    hop_LIH;
}

///The <b>RSVP_HOP</b> structure contains information about an RSVP-enabled hop.
struct RSVP_HOP
{
    ///RSVP hop header, in the form of an RsvpObjHdr structure
    RsvpObjHdr hop_header;
    union hop_u
    {
        Rsvp_Hop_IPv4 hop_ipv4;
    }
}

///The <b>RESV_STYLE</b> structure contains information about RSVP RESV style.
struct RESV_STYLE
{
    ///RSVP object header, in the form of an RsvpObjHdr structure.
    RsvpObjHdr style_header;
    ///RSVP RESV style. Must be one of the following values: <a id="STYLE_FF"></a> <a id="style_ff"></a>
    uint       style_word;
}

///The <b>Filter_Spec_IPv4</b> structure contains information about an IPv4 FILTERSPEC.
struct Filter_Spec_IPv4
{
    ///IP address of the source address, in the form of an in_addr structure.
    in_addr filt_ipaddr;
    ///Reserved. Do not use.
    ushort  filt_unused;
    ///TCP port for the source.
    ushort  filt_port;
}

///The <b>Filter_Spec_IPv4GPI</b> structure contains generalized port ID information about an IPv4 FILTERSPEC.
struct Filter_Spec_IPv4GPI
{
    ///IP address of the source address, in the form of an in_addr structure.
    in_addr filt_ipaddr;
    ///Generalized Port Identifier.
    uint    filt_gpi;
}

///The <b>FILTER_SPEC</b> structure stores information about an RSVP FILTERSPEC.
struct FILTER_SPEC
{
    ///RSVP Object Header for the FILTERSPEC, in the form of an RsvpObjHdr structure.
    RsvpObjHdr filt_header;
    union filt_u
    {
        Filter_Spec_IPv4    filt_ipv4;
        Filter_Spec_IPv4GPI filt_ipv4gpi;
    }
}

///The <b>Scope_list_ipv4</b> structure contains RSVP SCOPE object information.
struct Scope_list_ipv4
{
    ///Variable-length list of IP sender addresses, expressed as an array of IN_ADDR structures.
    in_addr[1] scopl_ipaddr;
}

///The <b>RSVP_SCOPE</b> structure provides RSVP scope information.
struct RSVP_SCOPE
{
    ///Scope header, in the form of an RsvpObjHdr structure.
    RsvpObjHdr scopl_header;
    union scope_u
    {
        Scope_list_ipv4 scopl_ipv4;
    }
}

///The <b>Error_Spec_IPv4</b> structure stores error code information for RSVP transmissions.
struct Error_Spec_IPv4
{
    ///IP address of the node responsible for the error, in the form of an in_addr structure.
    in_addr errs_errnode;
    ///Error flags. Must be one of the following: <ul> <li>ERROR_SPECF_InPlace</li> <li>ERROR_SPECF_NotGuilty</li> </ul>
    ubyte   errs_flags;
    ///Error code. Must be one of the following: <ul> <li>ERR_FORWARD_OK</li> <li>ERR_Usage_globl</li>
    ///<li>ERR_Usage_local</li> <li>ERR_Usage_serv</li> <li>ERR_global_mask</li> </ul>
    ubyte   errs_code;
    ///Error value.
    ushort  errs_value;
}

///The <b>ERROR_SPEC</b> structure contains RSVP error messages.
struct ERROR_SPEC
{
    ///Error header, in the form of an RsvpObjHdr structure.
    RsvpObjHdr errs_header;
    union errs_u
    {
        Error_Spec_IPv4 errs_ipv4;
    }
}

///The <b>POLICY_DATA</b> structure contains policy data for RSVP messages.
struct POLICY_DATA
{
    ///Policy object header, in the form of an RsvpObjHdr structure.
    RsvpObjHdr PolicyObjHdr;
    ///Offset to the beginning of Policy Elements from the beginning of Policy Data.
    ushort     usPeOffset;
    ///Reserved. Do not use.
    ushort     usReserved;
}

///The <b>POLICY_ELEMENT</b> structure contains an RSVP policy element.
struct POLICY_ELEMENT
{
    ///Length of the Policy Element, in bytes.
    ushort   usPeLength;
    ///Policy Element type.
    ushort   usPeType;
    ubyte[4] ucPeData;
}

///The <b>IntServMainHdr</b> structure is a header for Integrated Services RSVP objects.
struct IntServMainHdr
{
    ///Version of this header.
    ubyte  ismh_version;
    ///Reserved. Do not use.
    ubyte  ismh_unused;
    ///Number of 32-bit WORDs in the object, excluding this header object.
    ushort ismh_len32b;
}

///The <b>IntServServiceHdr</b> structure is a header for Integrated Services service objects.
struct IntServServiceHdr
{
    ///Service number of the attached object.
    ubyte  issh_service;
    ///Flags for the corresponding service object.
    ubyte  issh_flags;
    ///Number of 32-bit WORDs in the object, excluding this header object.
    ushort issh_len32b;
}

///The <b>IntServParmHdr</b> structure is a header for Integrated Services parameters.
struct IntServParmHdr
{
    ///Parameter number of the attached object.
    ubyte  isph_parm_num;
    ///Flags for the corresponding parameter object.
    ubyte  isph_flags;
    ///Number of 32-bit WORDs in the object, excluding this header object.
    ushort isph_len32b;
}

///The <b>GenTspecParms</b> structure stores generic Tspec parameters.
struct GenTspecParms
{
    ///Token bucket rate, in bytes per second.
    float TB_Tspec_r;
    ///Token bucket depth, in bytes.
    float TB_Tspec_b;
    ///Peak data rate, in bytes per second.
    float TB_Tspec_p;
    ///Minimum policed unit, in bytes.
    uint  TB_Tspec_m;
    ///Maximum packet size, in bytes.
    uint  TB_Tspec_M;
}

///The <b>GenTspec</b> structure stores generic Tspec information.
struct GenTspec
{
    ///General information and length information for the GenTspec object (this structure), expressed as an
    ///IntServServiceHdr structure.
    IntServServiceHdr gen_Tspec_serv_hdr;
    ///Parameter header, expressed as an IntServParmHdr structure.
    IntServParmHdr    gen_Tspec_parm_hdr;
    ///Tspec parameters, expressed as a GenTspecParms structure.
    GenTspecParms     gen_Tspec_parms;
}

///The <b>QualTspecParms</b> structure contains qualitative Tspec parameters.
struct QualTspecParms
{
    ///Maximum packet size, in bytes.
    uint TB_Tspec_M;
}

///The <b>QualTspec</b> structure contains qualitative Tspec information.
struct QualTspec
{
    ///General information and length information for the QualTspec object (this structure), expressed as an
    ///IntServServiceHdr structure.
    IntServServiceHdr qual_Tspec_serv_hdr;
    ///Parameter header, expressed as an IntServParmHdr structure.
    IntServParmHdr    qual_Tspec_parm_hdr;
    ///Tspec parameters, expressed as a QualTspecParms structure.
    QualTspecParms    qual_Tspec_parms;
}

///The <b>QualAppFlowSpec</b> structure contains FLOWSPEC information for a qualitative application.
struct QualAppFlowSpec
{
    ///General information and length information for the QualAppFlowSpec object (this structure), expressed as an
    ///IntServServiceHdr structure.
    IntServServiceHdr Q_spec_serv_hdr;
    ///Parameter header, expressed as an IntServParmHdr structure.
    IntServParmHdr    Q_spec_parm_hdr;
    ///QUALITATIVE Tspec parameters, expressed as a QualTspecParms structure.
    QualTspecParms    Q_spec_parms;
}

///The <b>IntServTspecBody</b> structure contains information for an RSVP Tspec.
struct IntServTspecBody
{
    ///Header for the corresponding Tspec object, expressed as IntServMainHdr structure.
    IntServMainHdr st_mh;
    union tspec_u
    {
        GenTspec  gen_stspec;
        QualTspec qual_stspec;
    }
}

///The <b>SENDER_TSPEC</b> structure contains information for an RSVP sender Tspec.
struct SENDER_TSPEC
{
    ///Object header, expressed as an RsvpObjHdr structure.
    RsvpObjHdr       stspec_header;
    ///Sender Tspec body information, expressed as an IntServTspecBody structure.
    IntServTspecBody stspec_body;
}

///The <b>CtrlLoadFlowspec</b> structure contains a Controlled Load FLOWSPEC.
struct CtrlLoadFlowspec
{
    ///General information and length information for the controlled load flowspec object (this structure), expressed as
    ///an IntServServiceHdr structure.
    IntServServiceHdr CL_spec_serv_hdr;
    ///Parameter header, expressed as an IntServParmHdr structure.
    IntServParmHdr    CL_spec_parm_hdr;
    ///Generic Tspec parameters, expressed as a GenTspecParms structure.
    GenTspecParms     CL_spec_parms;
}

///The <b>GuarRspec</b> structure contains guaranteed Rspec information.
struct GuarRspec
{
    ///Guaranteed rate, in bytes per second.
    float Guar_R;
    ///Slack term, in seconds.
    uint  Guar_S;
}

///The <b>GuarFlowSpec</b> structure contains guaranteed flowspec information.
struct GuarFlowSpec
{
    ///General information and length information for the guaranteed flowspec object (this structure), expressed as an
    ///IntServServiceHdr structure.
    IntServServiceHdr Guar_serv_hdr;
    ///Parameter header for the guaranteed Tspec, expressed as an IntServParmHdr structure.
    IntServParmHdr    Guar_Tspec_hdr;
    ///Generic Tspec parameters, expressed as a GenTspecParms structure.
    GenTspecParms     Guar_Tspec_parms;
    ///Parameter header for the guaranteed Rspec, expressed as an IntServParmHdr structure.
    IntServParmHdr    Guar_Rspec_hdr;
    ///Guaranteed rate, in bytes per second, expressed as a GuarRspec structure.
    GuarRspec         Guar_Rspec;
}

///The <b>IntServFlowSpec</b> structure contains information about Integrated Services flowspecs.
struct IntServFlowSpec
{
    ///General information and length information for the flowspec object (this structure), expressed as an
    ///IntServMainHdr structure.
    IntServMainHdr spec_mh;
    union spec_u
    {
        CtrlLoadFlowspec CL_spec;
        GuarFlowSpec     G_spec;
        QualAppFlowSpec  Q_spec;
    }
}

///The <b>IS_FLOWSPEC</b> structure stores an Integrated Services FLOWSPEC object.
struct IS_FLOWSPEC
{
    ///General information and length information for the Integrated Services flowspec object (this structure),
    ///expressed as an RsvpObjHdr structure.
    RsvpObjHdr      flow_header;
    ///FLOWSPEC object data, expressed as an IntServFlowSpec structure.
    IntServFlowSpec flow_body;
}

///The <b>FLOW_DESC</b> structure contains flow descriptor information for RSVP.
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

///The <b>Gads_parms_t</b> structure stores guaranteed service Adspec parameters.
struct Gads_parms_t
{
    ///General information and length information for the guaranteed service Adspec object (this structure), expressed
    ///as an IntServServiceHdr structure.
    IntServServiceHdr Gads_serv_hdr;
    ///Parameter header for the guaranteed service Adspec, expressed as an IntServParmHdr structure.
    IntServParmHdr    Gads_Ctot_hdr;
    ///Parameter associated with <b>Gads_Ctot_hdr</b>.
    uint              Gads_Ctot;
    ///Parameter header for the guaranteed service Adspec, expressed as an IntServParmHdr structure.
    IntServParmHdr    Gads_Dtot_hdr;
    ///Parameter associated with <b>Gads_Dtot_hdr</b>.
    uint              Gads_Dtot;
    ///Parameter header for the guaranteed service Adspec, expressed as an IntServParmHdr structure.
    IntServParmHdr    Gads_Csum_hdr;
    ///Parameter associated with <b>Gads_Csum</b>.
    uint              Gads_Csum;
    ///Parameter header for the guaranteed service Adspec, expressed as an IntServParmHdr structure.
    IntServParmHdr    Gads_Dsum_hdr;
    ///Parameter associated with <b>Gads_Dsum</b>.
    uint              Gads_Dsum;
}

///The <b>GenAdspecParams</b> structure contains general path characterization parameters.
struct GenAdspecParams
{
    ///General information and length information for the Adspec parameters object (this structure), expressed as an
    ///IntServServiceHdr structure.
    IntServServiceHdr gen_parm_hdr;
    ///Parameter header for hop count information associated with the Adspec object, expressed as an IntServParmHdr
    ///structure.
    IntServParmHdr    gen_parm_hopcnt_hdr;
    ///Hop count information parameter.
    uint              gen_parm_hopcnt;
    ///Parameter header for path bandwidth information associated with the Adspec object, expressed as an IntServParmHdr
    ///structure.
    IntServParmHdr    gen_parm_pathbw_hdr;
    ///Path bandwidth information parameter.
    float             gen_parm_path_bw;
    ///Parameter header for minimum latency information associated with the Adspec object, expressed as an
    ///IntServParmHdr structure.
    IntServParmHdr    gen_parm_minlat_hdr;
    ///Minimum latency information parameter.
    uint              gen_parm_min_latency;
    ///Parameter header for composed maximum transmission unit (MTU) information associated with the Adspec object,
    ///expressed as an IntServParmHdr structure.
    IntServParmHdr    gen_parm_compmtu_hdr;
    ///Composed MTU information parameter.
    uint              gen_parm_composed_MTU;
}

///The <b>IS_ADSPEC_BODY</b> structure contains Integrated Services Adspec information.
struct IS_ADSPEC_BODY
{
    ///Main header information and length, expressed as an IntServMainHdr structure.
    IntServMainHdr  adspec_mh;
    ///General Adspec parameter fragment, followed by variable-length fragments for some or all services.
    GenAdspecParams adspec_genparms;
}

///The <b>ADSPEC</b> structure contains Adspec message information for RSVP.
struct ADSPEC
{
    ///Adspec header, expressed as an RsvpObjHdr structure.
    RsvpObjHdr     adspec_header;
    ///Adspec message body.
    IS_ADSPEC_BODY adspec_body;
}

///The <b>ID_ERROR_OBJECT</b> structure contains error message information for Identity Policy Elements for RSVP.
struct ID_ERROR_OBJECT
{
    ///Length of <b>udIdErrData</b>, in bytes.
    ushort   usIdErrLength;
    ///Type of Identity Policy Element error.
    ubyte    ucAType;
    ///Sub-type of the Identity Policy Element error.
    ubyte    ucSubType;
    ///Reserved. Do not use.
    ushort   usReserved;
    ///Value for the Identity Policy Element error.
    ushort   usIdErrorValue;
    ///Identity Policy Element error data.
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

///The <b>RSVP_MSG_OBJS</b> structure contains RSVP message objects.
struct RSVP_MSG_OBJS
{
    ///RSVP message type.
    int           RsvpMsgType;
    ///Pointer to an RSVP_SESSION object containing an RSVP session object.
    RSVP_SESSION* pRsvpSession;
    ///Pointer to an RSVP_HOP structure indicating the hop from which the message has come.
    RSVP_HOP*     pRsvpFromHop;
    ///Pointer to an RSVP_HOP structure indicating the hop to which the message shall be sent.
    RSVP_HOP*     pRsvpToHop;
    ///Reservation style, expressed as a RESV_STYLE structure.
    RESV_STYLE*   pResvStyle;
    ///Scope of the reservation message.
    RSVP_SCOPE*   pRsvpScope;
    ///Number of flow descriptors in the message.
    int           FlowDescCount;
    ///Pointer to the first FLOW_DESC structure in the message.
    flow_desc*    pFlowDescs;
    ///Number of policy data objects in the message.
    int           PdObjectCount;
    ///Pointer to the first POLICY_DATA structure in the message.
    POLICY_DATA** ppPdObjects;
    ///Pointer to an ERROR_SPEC structure containing an error message.
    ERROR_SPEC*   pErrorSpec;
    ///Pointer to an ADSPEC structure containing an Adspec message.
    ADSPEC*       pAdspec;
}

///The <b>POLICY_DECISION</b> structure contains RSVP policy decision information.
struct policy_decision
{
    ///Local policy value.
    uint   lpvResult;
    ///RSVP-defined error code.
    ushort wPolicyErrCode;
    ///RSVP-defined error value.
    ushort wPolicyErrValue;
}

///The <b>LPM_INIT_INFO</b> structure contains local policy module initialization information.
struct LPM_INIT_INFO
{
    ///Version of the policy control module
    uint             PcmVersionNumber;
    ///Time limit, in seconds, that the policy control module waits to receive results before timing out.
    uint             ResultTimeLimit;
    ///Number of configured local policy modules.
    int              ConfiguredLpmCount;
    ///Memory allocation function used to initialize memory for local policy modules, in the form of a PALLOCMEM
    ///function.
    PALLOCMEM        AllocMemory;
    ///Memory freeing function used to free memory allocated for the local policy module. See PFREEMEM for more
    ///information.
    PFREEMEM         FreeMemory;
    ///Callback function used to admit results. See cbAdmitResult for more information.
    CBADMITRESULT    PcmAdmitResultCallback;
    ///Callback function used to obtain RSVP objects. See cbGetRsvpObjects for more information.
    CBGETRSVPOBJECTS GetRsvpObjectsCallback;
}

///The <b>LPMIPTABLE</b> structure contains IP information, including the SNMP index, IP address, and subnet mask for
///each interface. The <b>LPMIPTABLE</b> structure is supplied as an argument for the Lpm_IpAddressTable function.
struct lpmiptable
{
    ///SNMP index for the interface.
    uint    ulIfIndex;
    ///Media type of the interface.
    uint    MediaType;
    ///IP address for the interface.
    in_addr IfIpAddr;
    ///IP subnet mask for the interface.
    in_addr IfNetMask;
}

///The <b>QOS_PACKET_PRIORITY</b> structure that indicates the priority of the flow traffic.
struct QOS_PACKET_PRIORITY
{
    ///Differential Services Code Point (DSCP) mark used for flow traffic that conforms to the specified flow rate.
    uint ConformantDSCPValue;
    ///DSCP marking used for flow traffic that exceeds the specified flow rate. Non-conformant DSCP values are only
    ///applicable only if QOS_SHAPING has a value of <b>QOSUseNonConformantMarkings</b>.
    uint NonConformantDSCPValue;
    ///Layer-2 (L2) tag used for flow traffic that conforms to the specified flow rate. L2 tags will not be added to
    ///packets if the end-to-end path between source and sink does not support them.
    uint ConformantL2Value;
    ///L2 tag used for flow traffic that exceeds the specified flow rate. Non-conformant L2 values are only applicable
    ///if QOS_SHAPING has a value of <b>QOSUseNonConformantMarkings</b>.
    uint NonConformantL2Value;
}

///The <b>QOS_FLOW_FUNDAMENTALS</b> structure contains basic information about a flow.
struct QOS_FLOW_FUNDAMENTALS
{
    ///This Boolean value is set to <b>TRUE</b> if the <b>BottleneckBandwidth</b> field contains a value.
    BOOL  BottleneckBandwidthSet;
    ///Indicates the maximum end-to-end link capacity between the source and sink device, in bits.
    ulong BottleneckBandwidth;
    ///Set to <b>TRUE</b> if the <b>AvailableBandwidth</b> field contains a value.
    BOOL  AvailableBandwidthSet;
    ///Indicates how much bandwidth is available for submitting traffic on the end-to-end network path between the
    ///source and sink device, in bits.
    ulong AvailableBandwidth;
    ///Set to <b>TRUE</b> if the <b>RTT</b> field contains a value.
    BOOL  RTTSet;
    ///Measures the round-trip time between the source and sink device, in microseconds.
    uint  RTT;
}

///The <b>QOS_FLOWRATE_OUTGOING</b> structure is used to set flow rate information in the QOSSetFlow function.
struct QOS_FLOWRATE_OUTGOING
{
    ///The rate at which data should be sent, in units of bits per second. <div class="alert"><b>Note</b> Traffic on the
    ///network is measured at the IP level, and not at the application level. The rate that is specified should account
    ///for the IP and protocol headers.</div> <div> </div>
    ulong               Bandwidth;
    ///A QOS_SHAPING constant that defines the shaping behavior of the flow.
    QOS_SHAPING         ShapingBehavior;
    ///A QOS_FLOWRATE_REASON constant that indicates the reason for a flow rate change.
    QOS_FLOWRATE_REASON Reason;
}

///The <b>QOS_VERSION</b> structure indicates the version of the QOS protocol.
struct QOS_VERSION
{
    ///Major version of the QOS protocol.
    ushort MajorVersion;
    ///Minor version of the QOS protocol.
    ushort MinorVersion;
}

///The <b>QOS_FRIENDLY_NAME</b> traffic control object associates a friendly name with flow.
struct QOS_FRIENDLY_NAME
{
    ///The QOS object QOS_OBJECT_HDR. The object type for this traffic control object should be
    ///<b>QOS_OBJECT_FRIENDLY_NAME</b>.
    QOS_OBJECT_HDR ObjectHdr;
    ///Name to be associated with the flow.
    ushort[256]    FriendlyName;
}

///The traffic control object <b>QOS_TRAFFIC_CLASS</b> is used to override the default UserPriority value ascribed to
///packets that classify the traffic of a given flow. By default, the UserPriority value of a flow is derived from the
///ServiceType (see: FLOWSPEC). Therefore, it is often necessary to override the default UserPriority because packets
///can be tagged in their Layer 2 headers (such as an 802.1p header) to specify their priority to Layer-2 devices. Using
///<b>QOS_TRAFFIC_CLASS</b> enables application developers to override the default UserPriority setting.
struct QOS_TRAFFIC_CLASS
{
    ///The QOS object QOS_OBJECT_HDR. The object type for this traffic control object should be
    ///<b>QOS_OBJECT_TRAFFIC_CLASS</b>.
    QOS_OBJECT_HDR ObjectHdr;
    ///User priority value of the flow. The valid range is zero through seven. The following settings are chosen (by
    ///default) when the <b>QOS_TRAFFIC_CLASS</b> traffic control object is not used. <div class="alert"><b>Note</b>
    ///This parameter specifies an 802.1 TrafficClass parameter which has been provided to the host by a layer 2 network
    ///in an 802.1 extended RSVP RESV message. If this object is obtained from the network, hosts will stamp the MAC
    ///headers of corresponding transmitted packets, with the value in the object. Otherwise, hosts can select a value
    ///based on the standard Intserv mapping of ServiceType to 802.1 TrafficClass.</div> <div> </div>
    uint           TrafficClass;
}

///The traffic control object <b>QOS_DS_CLASS</b> enables application developers to override the default Diffserv code
///point (DSCP) value for the IP packets associated with a given flow. By default, the DSCP value is derived from the
///flow's ServiceType.
struct QOS_DS_CLASS
{
    ///The QOS object QOS_OBJECT_HDR. The object type for this traffic control object should be
    ///<b>QOS_OBJECT_DS_CLASS</b>.
    QOS_OBJECT_HDR ObjectHdr;
    ///User priority value for the flow. The valid range is 0x00 through 0x3F. The following settings are chosen (by
    ///default) when the <b>QOS_DS_CLASS</b> traffic control object is not used. <table> <tr> <th>Value</th>
    ///<th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt>0</dt> </dl> </td> <td width="60%"> ServiceTypeBestEffort,
    ///ServiceTypeQualitative </td> </tr> <tr> <td width="40%"> <dl> <dt>0x18</dt> </dl> </td> <td width="60%">
    ///ServiceTypeControlledLoad </td> </tr> <tr> <td width="40%"> <dl> <dt>0x28</dt> </dl> </td> <td width="60%">
    ///ServiceTypeGuaranteed </td> </tr> <tr> <td width="40%"> <dl> <dt>0x30</dt> </dl> </td> <td width="60%">
    ///ServiceTypeNetworkControl </td> </tr> <tr> <td width="40%"> <dl> <dt>0x00</dt> </dl> </td> <td width="60%">
    ///Non-conformant traffic </td> </tr> </table>
    uint           DSField;
}

///The <b>QOS_DIFFSERV</b> traffic control object is used to specify filters for the packet scheduler when it operates
///in Differentiated Services Mode.
struct QOS_DIFFSERV
{
    ///The QOS object <b>QOS_OBJECT_HDR</b>. The object type for this traffic control object should be
    ///QOS_OBJECT_DIFFSERV.
    QOS_OBJECT_HDR ObjectHdr;
    ///Number of Diffserv Rules in this object.
    uint           DSFieldCount;
    ///Array of QOS_DIFFSERV_RULE structures.
    ubyte[1]       DiffservRule;
}

///The <b>QOS_DIFFSERV_RULE</b> structure is used in conjunction with the traffic control object QOS_DIFFSERV to provide
///Diffserv rules for a given flow.
struct QOS_DIFFSERV_RULE
{
    ///Diffserv code point (DSCP) on the inbound packet. <b>InboundDSField</b> must be unique for the interface,
    ///otherwise the flow addition will fail. Valid range is 0x00 - 0x3F.
    ubyte InboundDSField;
    ///Diffserv code point (DSCP) marked on all conforming packets on the flow. This member can be used to remark the
    ///packet before it is forwarded. Valid range is 0x00 - 0x3F.
    ubyte ConformingOutboundDSField;
    ///Diffserv code point (DSCP) marked on all nonconforming packets on the flow. This member can be used to remark the
    ///packet before it is forwarded. Valid range is 0x00 - 0x3F.
    ubyte NonConformingOutboundDSField;
    ///UserPriority value marked on all conforming packets on the flow. This member can be used to remark the packet
    ///before it is forwarded. Valid range is 0-7
    ubyte ConformingUserPriority;
    ///UserPriority value marked on all nonconforming packets on the flow. This member can be used to remark the packet
    ///before it is forwarded. Valid range is 0-7
    ubyte NonConformingUserPriority;
}

///The <b>QOS_TCP_TRAFFIC</b> structure is used to indicate that IP Precedence and UserPriority mappings for a given
///flow must be set to system defaults for TCP traffic.
struct QOS_TCP_TRAFFIC
{
    ///A QOS object header.
    QOS_OBJECT_HDR ObjectHdr;
}

///The <b>TCI_CLIENT_FUNC_LIST</b> structure is used by the traffic control interface to register and then access
///client-callback functions. Each member of <b>TCI_CLIENT_FUNC_LIST</b> is a pointer to the client provided–callback
///function.
struct TCI_CLIENT_FUNC_LIST
{
    ///Pointer to the client-callback function ClNotifyHandler.
    TCI_NOTIFY_HANDLER ClNotifyHandler;
    ///Pointer to the client-callback function ClAddFlowComplete.
    TCI_ADD_FLOW_COMPLETE_HANDLER ClAddFlowCompleteHandler;
    ///Pointer to the client-callback function ClModifyFlowComplete.
    TCI_MOD_FLOW_COMPLETE_HANDLER ClModifyFlowCompleteHandler;
    ///Pointer to the client-callback function ClDeleteFlowComplete.
    TCI_DEL_FLOW_COMPLETE_HANDLER ClDeleteFlowCompleteHandler;
}

///The <b>ADDRESS_LIST_DESCRIPTOR</b> structure provides network address descriptor information for a given interface.
///For point-to-point media such as WAN connections, the list is a pair of addresses, the first of which is always the
///local or source address, the second of which is the remote or destination address. Note that the members of
///<b>ADDRESS_LIST_DESCRIPTOR</b> are defined in Ntddndis.h.
struct ADDRESS_LIST_DESCRIPTOR
{
    ///Media type of the interface.
    uint                 MediaType;
    ///Pointer to the address list for the interface. The <b>NETWORK_ADDRESS_LIST</b> structure is defined in
    ///Ntddndis.h.
    NETWORK_ADDRESS_LIST AddressList;
}

///The <b>TC_IFC_DESCRIPTOR</b> structure is an interface identifier used to enumerate interfaces.
struct TC_IFC_DESCRIPTOR
{
    ///Number of bytes from the beginning of the <b>TC_IFC_DESCRIPTOR</b> to the next <b>TC_IFC_DESCRIPTOR</b>.
    uint          Length;
    ///Pointer to a zero-terminated Unicode string representing the name of the packet shaper interface. This name is
    ///used in subsequent TC API calls to reference the interface.
    const(wchar)* pInterfaceName;
    ///Pointer to a zero-terminated Unicode string naming the DeviceName of the interface.
    const(wchar)* pInterfaceID;
    ///Network address list descriptor.
    ADDRESS_LIST_DESCRIPTOR AddressListDesc;
}

struct TC_SUPPORTED_INFO_BUFFER
{
    ushort      InstanceIDLength;
    ushort[256] InstanceID;
    ulong       InterfaceLuid;
    ADDRESS_LIST_DESCRIPTOR AddrListDesc;
}

///The <b>TC_GEN_FILTER</b> structure creates a filter that matches a certain set of packet attributes or criteria,
///which can subsequently be used to associate packets that meet the attribute criteria with a particular flow. The
///<b>TC_GEN_FILTER</b> structure uses its <b>AddressType</b> member to indicate a specific filter type to apply to the
///filter.
struct TC_GEN_FILTER
{
    ///Defines the filter type to be applied with the filter, as defined in Ntddndis.h. With the designation of a
    ///specific filter in <b>AddressType</b>, the generic filter structure <b>TC_GEN_FILTER</b> provides a specific
    ///filter type.
    ushort AddressType;
    ///Size of the <b>Pattern</b> member, in bytes.
    uint   PatternSize;
    ///Indicates the specific format of the pattern to be applied to the filter, such as IP_PATTERN. The pattern
    ///specifies which bits of a given packet should be evaluated when determining whether a packet is included in the
    ///filter.
    void*  Pattern;
    ///A bitmask applied to the bits designated in the <b>Pattern</b> member. The application of the <b>Mask</b> member
    ///to the <b>Pattern</b> member determines which bits in the <b>Pattern</b> member are significant (should be
    ///applied to the filter criteria). Note that the <b>Mask</b> member must be of the same type as the <b>Pattern</b>
    ///member.
    void*  Mask;
}

///The <b>TC_GEN_FLOW</b> structure creates a generic flow for use with the traffic control interface. The flow is
///customized through the members of this structure.
struct TC_GEN_FLOW
{
    ///FLOWSPEC structure for the sending direction of the flow.
    FLOWSPEC          SendingFlowspec;
    ///FLOWSPEC structure for the receiving direction of the flow.
    FLOWSPEC          ReceivingFlowspec;
    ///Length of <b>TcObjects</b>, in bytes.
    uint              TcObjectsLength;
    ///Buffer that contains an array of traffic control objects specific to the given flow. The <b>TcObjects</b> member
    ///can contain objects from the list of currently supported objects. Definitions of these objects can be found in
    ///Qos.h and Traffic.h: QOS_DS_CLASS QOS_TRAFFIC_CLASS QOS_DIFFSERV QOS_SD_MODE QOS_SHAPING_RATE
    ///QOS_OBJECT_END_OF_LIST
    QOS_OBJECT_HDR[1] TcObjects;
}

///The <b>IP_PATTERN</b> structure applies a specific pattern or corresponding mask for the IP protocol. The
///<b>IP_PATTERN</b> structure designation is used by the traffic control interface in the application of packet
///filters.
struct IP_PATTERN
{
    ///Reserved for future use.
    uint     Reserved1;
    ///Reserved for future use.
    uint     Reserved2;
    ///Source address.
    uint     SrcAddr;
    ///Destination address.
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
    ///Protocol identifier.
    ubyte    ProtocolId;
    ///Reserved for future use.
    ubyte[3] Reserved3;
}

///The <b>IPX_PATTERN</b> structure applies a specific pattern or corresponding mask for the IPX protocol. The
///<b>IPX_PATTERN</b> structure designation is used by the traffic control interface in the application of packet
///filters.
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

///The <b>ENUMERATION_BUFFER</b> structure contains information specific to a given flow, including flow name, the
///number of filters associated with the flow, and an array of filters associated with the flow.
struct ENUMERATION_BUFFER
{
    ///Number of bytes from the beginning of the <b>ENUMERATION_BUFFER</b> to the next <b>ENUMERATION_BUFFER</b>.
    uint             Length;
    ///Identifies the owner of the process.
    uint             OwnerProcessId;
    ///Specifies the length of the <b>FlowName</b> member.
    ushort           FlowNameLength;
    ///Array of WCHAR characters, of length <b>MAX_STRING_LENGTH</b>, that specifies the flow name.
    ushort[256]      FlowName;
    ///Pointer to the corresponding TC_GEN_FLOW structure. This structure is placed immediately after the array of
    ///TC_GEN_FILTERS and is included in <b>Length</b>.
    TC_GEN_FLOW*     pFlow;
    ///Specifies the number of filters associated with the flow.
    uint             NumberOfFilters;
    ///Array of TC_GEN_FILTER structures. The number of elements in the array corresponds to the number of filters
    ///attached to the specified flow. Note that in order to enumerate through the array of <b>TC_GEN_FILTER</b>
    ///structures, you need to increment the pointer to the current <b>TC_GEN_FILTER</b> by using the following:
    ///sizeof(TC_GEN_FILTER) + 2 * [the pattern size of the current TC_GEN_FILTER structure].
    TC_GEN_FILTER[1] GenericFilter;
}

///The <b>QOS</b> structure provides the means by which QOS-enabled applications can specify quality of service
///parameters for sent and received traffic on a particular flow.
struct QOS
{
    ///Specifies QOS parameters for the sending direction of a particular flow. SendingFlowspec is sent in the form of a
    ///FLOWSPEC structure.
    FLOWSPEC SendingFlowspec;
    ///Specifies QOS parameters for the receiving direction of a particular flow. ReceivingFlowspec is sent in the form
    ///of a FLOWSPEC structure.
    FLOWSPEC ReceivingFlowspec;
    ///Pointer to a structure of type WSABUF that can provide additional provider-specific quality of service parameters
    ///to the RSVP SP for a given flow.
    WSABUF   ProviderSpecific;
}

// Functions

///This function initializes the QOS subsystem and the <i>QOSHandle</i> parameter. The <i>QOSHandle</i> parameter is
///used when calling other QOS functions. <b>QOSCreateHandle</b> must be called before any other functions.
///QOSCloseHandle closes handles created by this function.
///Params:
///    Version = Pointer to a QOS_VERSION structure that indicates the version of QOS being used. The <b>MajorVersion</b> member
///              must be set to 1, and the <b>MinorVersion</b> member must be set to 0.
///    QOSHandle = Pointer to a variable that receives a QOS handle. This handle is used when calling other QOS functions.
///Returns:
///    If the function succeeds, the return value is nonzero. If the function fails, the return value is 0. To get
///    extended error information, call <b>GetLastError</b>. Some possible error codes follow. <table> <tr> <th>Return
///    code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_GEN_FAILURE</b></dt> </dl> </td> <td
///    width="60%"> Internal logic error. Initialization failed. For example, if the host goes into sleep or standby
///    mode, all existing handles and flows are rendered invalid. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> The <i>QOSHandle</i> parameter is invalid.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NOT_ENOUGH_MEMORY</b></dt> </dl> </td> <td width="60%">
///    Indicates that a memory allocation failed. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_NO_SYSTEM_RESOURCES</b></dt> </dl> </td> <td width="60%"> There are insufficient resources to carry
///    out the operation. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_RESOURCE_DISABLED</b></dt> </dl> </td> <td
///    width="60%"> A resource required by the service is unavailable. This error may be returned if the user has not
///    enabled the firewall exception for the qWAVE service. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_SERVICE_DEPENDENCY_FAIL</b></dt> </dl> </td> <td width="60%"> One of the dependencies of this
///    service is unavailable. The qWAVE service could not be started. </td> </tr> </table>
///    
@DllImport("qwave")
BOOL QOSCreateHandle(QOS_VERSION* Version, ptrdiff_t* QOSHandle);

///The <b>QOSCloseHandle</b> function closes a handle returned by the QOSCreateHandle function.
///Params:
///    QOSHandle = Handle to the QOS subsystem returned by QOSCreateHandle.
///Returns:
///    If the function succeeds, the return value is nonzero. If the function fails, the return value is 0. To get
///    extended error information, call <b>GetLastError</b>. <table> <tr> <th>Return code</th> <th>Description</th>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> The
///    <i>QOSHandle</i> parameter is invalid. </td> </tr> </table>
///    
@DllImport("qwave")
BOOL QOSCloseHandle(HANDLE QOSHandle);

///The <b>QOSStartTrackingClient</b> function notifies the QOS subsystem of the existence of a new client. Calling this
///function increases the likelihood that the QOS subsystem will have gathered sufficient information on the network
///path to assist when calling QOSSetFlow to set the flow. <div class="alert"><b>Note</b> This call is not required to
///add a flow with the QOSAddSocketToFlow function although it is highly recommended. Not calling this function may
///require network experiments to be started during the QOSSetFlow call and can result in <b>QOSSetFlow</b> failing with
///<b>ERROR_NETWORK_BUSY</b> on initial use.</div> <div> </div>
///Params:
///    QOSHandle = Handle to the QOS subsystem returned by QOSCreateHandle.
///    DestAddr = A pointer to a sockaddr structure that contains the IP address of the client device. Clients are identified by
///               their IP address and address family. Any port number specified in the sockaddr structure will be ignored.
///    Flags = Reserved for future use. Must be set to 0.
///Returns:
///    If the function succeeds, the return value is nonzero. If the function fails, the return value is 0. To get
///    extended error information, call <b>GetLastError</b>. Some possible error codes follow. <table> <tr> <th>Return
///    code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_HANDLE</b></dt> </dl> </td>
///    <td width="60%"> The <i>QOSHandle</i> parameter is invalid. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> The <i>DestAddr</i> parameter is invalid.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NOT_ENOUGH_MEMORY</b></dt> </dl> </td> <td width="60%">
///    Indicates that a memory allocation failed. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_NO_SYSTEM_RESOURCES</b></dt> </dl> </td> <td width="60%"> There are insufficient resources to carry
///    out the operation. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_IO_DEVICE</b></dt> </dl> </td> <td
///    width="60%"> The request could not be performed because of an I/O device error. </td> </tr> <tr> <td width="40%">
///    <dl> <dt><b>ERROR_DEVICE_REINITIALIZATION_NEEDED</b></dt> </dl> </td> <td width="60%"> The indicated device
///    requires reinitialization due to hardware errors. The application should clean up and call QOSCreateHandle again.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NOT_SUPPORTED</b></dt> </dl> </td> <td width="60%"> The
///    request is not supported. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_ADAP_HDW_ERR</b></dt> </dl> </td>
///    <td width="60%"> A network adapter hardware error occurred. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_HOST_UNREACHABLE</b></dt> </dl> </td> <td width="60%"> The network location cannot be reached. </td>
///    </tr> </table>
///    
@DllImport("qwave")
BOOL QOSStartTrackingClient(HANDLE QOSHandle, SOCKADDR* DestAddr, uint Flags);

///The <b>QOSStopTrackingClient</b> function notifies the QoS subsystem to stop tracking a client that has previously
///used the QOSStartTrackingClient function. If a flow is currently in progress, this function will not affect it.
///Params:
///    QOSHandle = Handle to the QOS subsystem returned by QOSCreateHandle.
///    DestAddr = Pointer to a sockaddr structure that contains the IP address of the client device. Clients are identified by
///               their IP address and address family. A port number is not required and will be ignored.
///    Flags = Reserved for future use.
///Returns:
///    If the function succeeds, the return value is nonzero. If the function fails, the return value is 0. To get
///    extended error information, call <b>GetLastError</b>. Some possible error codes follow. <table> <tr> <th>Return
///    code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_HANDLE</b></dt> </dl> </td>
///    <td width="60%"> The <i>QOSHandle</i> parameter is invalid. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> The <i>DestAddr</i> parameter is invalid.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NOT_ENOUGH_MEMORY</b></dt> </dl> </td> <td width="60%">
///    Indicates that a memory allocation failed. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_NO_SYSTEM_RESOURCES</b></dt> </dl> </td> <td width="60%"> There are insufficient resources to carry
///    out the operation. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_IO_DEVICE</b></dt> </dl> </td> <td
///    width="60%"> The request could not be performed because of an I/O device error. </td> </tr> <tr> <td width="40%">
///    <dl> <dt><b>ERROR_DEVICE_REINITIALIZATION_NEEDER</b></dt> </dl> </td> <td width="60%"> The indicated device
///    requires reinitialization due to hardware errors. The application should clean up and call QOSCreateHandle again.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_ADAP_HDW_ERR</b></dt> </dl> </td> <td width="60%"> A network
///    adapter hardware error occurred. </td> </tr> </table>
///    
@DllImport("qwave")
BOOL QOSStopTrackingClient(HANDLE QOSHandle, SOCKADDR* DestAddr, uint Flags);

///The <b>QOSEnumerateFlows</b> function enumerates all existing flows.
///Params:
///    QOSHandle = Handle to the QOS subsystem returned by QOSCreateHandle.
///    Size = Indicates the size of the <i>Buffer</i> parameter, in bytes. On function return, if successful, this parameter
///           will specify the number of bytes copied into <i>Buffer</i>. If this call fails with
///           <b>ERROR_INSUFFICIENT_BUFFER</b>, this parameter will indicate the minimum required <i>Buffer</i> size in order
///           to successfully complete this operation.
///    Buffer = Pointer to an array of <b>QOS_FlowId</b> flow identifiers. A <b>QOS_FlowId</b> is an unsigned 32-bit integer.
///Returns:
///    If the function succeeds, the return value is nonzero. If the function fails, the return value is 0. To get
///    extended error information, call <b>GetLastError</b>. Some possible error codes follow. <table> <tr> <th>Return
///    code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_HANDLE</b></dt> </dl> </td>
///    <td width="60%"> The <i>QOSHandle</i> parameter is invalid. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INSUFFICIENT_BUFFER</b></dt> </dl> </td> <td width="60%"> Buffer is too small. On output,
///    <i>Size</i> will contain the minimum required buffer size. This function should then be called again with a
///    buffer of the indicated size. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt>
///    </dl> </td> <td width="60%"> The <i>DestAddr</i> parameter is invalid. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_NOT_ENOUGH_MEMORY</b></dt> </dl> </td> <td width="60%"> Indicates that a memory allocation failed.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NO_SYSTEM_RESOURCES</b></dt> </dl> </td> <td width="60%">
///    There are insufficient resources to carry out the operation. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_IO_DEVICE</b></dt> </dl> </td> <td width="60%"> The request could not be performed because of an I/O
///    device error. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_DEVICE_REINITIALIZATION_NEEDED</b></dt> </dl>
///    </td> <td width="60%"> The indicated device requires reinitialization due to hardware errors. The application
///    should clean up and call QOSCreateHandle again. </td> </tr> </table>
///    
@DllImport("qwave")
BOOL QOSEnumerateFlows(HANDLE QOSHandle, uint* Size, char* Buffer);

///The <b>QOSAddSocketToFlow</b> function adds a new flow for traffic.
///Params:
///    QOSHandle = Handle to the QOS subsystem returned by QOSCreateHandle.
///    Socket = Identifies the socket that the application will use to flow traffic.
///    DestAddr = Pointer to a sockaddr structure that contains the destination IP address to which the application will send
///               traffic. The sockaddr structure must specify a destination port. <div class="alert"><b>Note</b> <i>DestAddr</i>
///               is optional if the socket is already connected. If this parameter is specified, the remote IP address and port
///               must match those used in the socket's connect call.<p class="note">If the socket is not connected, this parameter
///               must be specified. If the socket is already connected, this parameter does not need to be specified. In this
///               case, if the parameter is still specified, the destination host and port must match what was specified during the
///               socket connect call. <p class="note">Since, under TCP, the socket connect call can be delayed,
///               <b>QOSAddSocketToFlow</b> can be called before a connection is established, passing in the remote system's IP
///               address and port number in the <i>DestAddr</i> parameter. </div> <div> </div>
///    TrafficType = A QOS_TRAFFIC_TYPE constant that specifies the type of traffic for which this flow will be used.
///    Flags = Optional flag values. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
///            id="QOS_NON_ADAPTIVE_FLOW"></a><a id="qos_non_adaptive_flow"></a><dl> <dt><b>QOS_NON_ADAPTIVE_FLOW</b></dt> </dl>
///            </td> <td width="60%"> If specified, the QoS subsystem will not gather data about the network path for this flow.
///            As a result, functions which rely on bandwidth estimation techniques will not be available. For example, this
///            would block QOSQueryFlow with an <i>Operation</i> value of <b>QOSQueryFlowFundamentals</b> and QOSNotifyFlow with
///            an <i>Operation</i> value of <b>QOSNotifyCongested</b>, <b>QOSNotifyUncongested</b>, and
///            <b>QOSNotifyAvailable</b>. </td> </tr> </table>
///    FlowId = Pointer to a buffer that receives a flow identifier. On input, this value must be 0. On output, the buffer
///             contains a flow identifier if the call succeeds. If a socket is being added to an existing flow, this parameter
///             will be the identifier of that flow. An application can make use of this parameter if multiple sockets used can
///             share the same QoS flow properties. The QoS subsystem, then does not have to incur the overhead of provisioning
///             new flows for subsequent sockets with the same properties. Note that only non-adaptive flows can have multiple
///             sockets attached to an existing flow. A <b>QOS_FLOWID</b> is an unsigned 32-bit integer.
///Returns:
///    If the function succeeds, the return value is nonzero. If the function fails, the return value is 0. To get
///    extended error information, call <b>GetLastError</b>. Some possible error codes follow. <table> <tr> <th>Return
///    code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_CONNECTION_REFUSED</b></dt> </dl>
///    </td> <td width="60%"> The remote system refused the network connection. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_HANDLE</b></dt> </dl> </td> <td width="60%"> The <i>QOSHandle</i> parameter is invalid.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> The
///    <i>FlowId</i> parameter is invalid. <div class="alert"><b>Note</b> This value is also returned if a IPv4/v6 mixed
///    address was supplied through the <i>DestAddr</i> parameter.</div> <div> </div> </td> </tr> <tr> <td width="40%">
///    <dl> <dt><b>ERROR_NOT_ENOUGH_MEMORY</b></dt> </dl> </td> <td width="60%"> A memory allocation failed. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>ERROR_NO_SYSTEM_RESOURCES</b></dt> </dl> </td> <td width="60%"> There are
///    insufficient resources to carry out the operation. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_IO_DEVICE</b></dt> </dl> </td> <td width="60%"> The request could not be performed because of an I/O
///    device error. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_DEVICE_REINITIALIZATION_NEEDED</b></dt> </dl>
///    </td> <td width="60%"> The indicated device requires reinitialization due to hardware errors. The application
///    should clean up and call QOSCreateHandle again. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_NOT_SUPPORTED</b></dt> </dl> </td> <td width="60%"> The request is not supported. </td> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>ERROR_ADAP_HDW_ERR</b></dt> </dl> </td> <td width="60%"> A network adapter hardware
///    error occurred. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_HOST_UNREACHABLE</b></dt> </dl> </td> <td
///    width="60%"> The network location cannot be reached. </td> </tr> </table>
///    
@DllImport("qwave")
BOOL QOSAddSocketToFlow(HANDLE QOSHandle, size_t Socket, SOCKADDR* DestAddr, QOS_TRAFFIC_TYPE TrafficType, 
                        uint Flags, uint* FlowId);

///The <b>QOSRemoveSocketFromFlow</b> function notifies the QOS subsystem that a previously added flow has been
///terminated by the application, and that the subsystem must update its internal information accordingly.
///Params:
///    QOSHandle = Handle to the QOS subsystem returned by QOSCreateHandle.
///    Socket = Socket to be removed from the flow. Only flows created with the <b>QOS_NON_ADAPTIVE_FLOW</b> flag may have
///             multiple sockets added to the same flow. By passing the <i>Socket</i> parameter in this call, each socket can be
///             removed individually. If the <i>Socket</i> parameter is not passed, the entire flow will be destroyed. If only
///             one socket was attached to the flow, passing this socket as a parameter to this function and passing <b>NULL</b>
///             as a socket are equivalent calls.
///    FlowId = A flow identifier. A <b>QOS_FLOWID</b> is an unsigned 32-bit integer.
///    Flags = Reserved for future use. This parameter must be set to 0.
///Returns:
///    If the function succeeds, the return value is nonzero. If the function fails, the return value is 0. To get
///    extended error information, call <b>GetLastError</b>. Some possible error codes follow. <table> <tr> <th>Return
///    code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_HANDLE</b></dt> </dl> </td>
///    <td width="60%"> The <i>QOSHandle</i> parameter is invalid. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_NOT_FOUND</b></dt> </dl> </td> <td width="60%"> The <i>FlowId</i> parameter is invalid. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>ERROR_NOT_ENOUGH_MEMORY</b></dt> </dl> </td> <td width="60%"> A memory
///    allocation failed. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NO_SYSTEM_RESOURCES</b></dt> </dl> </td>
///    <td width="60%"> There are insufficient system resources to carry out the operation. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_OPERATION_ABORTED</b></dt> </dl> </td> <td width="60%"> The request was blocked.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_IO_DEVICE</b></dt> </dl> </td> <td width="60%"> The request
///    could not be performed because of an I/O device error. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_DEVICE_REINITIALIZATION_NEEDED</b></dt> </dl> </td> <td width="60%"> The indicated device requires
///    reinitialization due to hardware errors. The application should clean up and call QOSCreateHandle again. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_HOST_UNREACHABLE</b></dt> </dl> </td> <td width="60%"> The network
///    location cannot be reached. </td> </tr> </table>
///    
@DllImport("qwave")
BOOL QOSRemoveSocketFromFlow(HANDLE QOSHandle, size_t Socket, uint FlowId, uint Flags);

///The <b>QOSSetFlow</b> function is called by an application to request the QOS subsystem to prioritize the
///application's packets and change the flow traffic. This function is also used to notify the QoS subsystem of a flow
///change: for example, if the flow rate is changed in order to account for network congestion, or if the QoS priority
///value requires adjustment for transferring or streaming different types of content over a single persistent socket
///connection.
///Params:
///    QOSHandle = Handle to the QOS subsystem returned by QOSCreateHandle.
///    FlowId = A flow identifier. A <b>QOS_FLOWID</b> is an unsigned 32-bit integer.
///    Operation = A QOS_SET_FLOW enumerated type that identifies what will be changed in the flow. This parameter specifies what
///                structure the <i>Buffer</i> will contain. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td
///                width="40%"><a id="QOSSetTrafficType"></a><a id="qossettraffictype"></a><a id="QOSSETTRAFFICTYPE"></a><dl>
///                <dt><b>QOSSetTrafficType</b></dt> <dt>0</dt> </dl> </td> <td width="60%"> The traffic type of the flow will be
///                changed. The <i>Buffer</i> will contain a pointer to a QOS_TRAFFIC_TYPE constant. </td> </tr> <tr> <td
///                width="40%"><a id="QOSSetOutgoingRate"></a><a id="qossetoutgoingrate"></a><a id="QOSSETOUTGOINGRATE"></a><dl>
///                <dt><b>QOSSetOutgoingRate</b></dt> <dt>1</dt> </dl> </td> <td width="60%"> The flow rate will be changed. The
///                <i>Buffer</i> will contain a pointer to a QOS_FLOWRATE_OUTGOING structure. </td> </tr> <tr> <td width="40%"><a
///                id="QOSSetOutgoingDSCPValue"></a><a id="qossetoutgoingdscpvalue"></a><a id="QOSSETOUTGOINGDSCPVALUE"></a><dl>
///                <dt><b>QOSSetOutgoingDSCPValue</b></dt> <dt>2</dt> </dl> </td> <td width="60%"> Windows 7, Windows Server 2008
///                R2, and later: The outgoing DSCP value will be changed. The <i>Buffer</i> will contain a pointer to a
///                <b>DWORD</b> value that defines the arbitrary DSCP value. <div class="alert"><b>Note</b> This setting requires
///                the calling application be a member of the Administrators or the Network Configuration Operators group.</div>
///                <div> </div> </td> </tr> </table>
///    Size = The size of the <i>Buffer</i> parameter, in bytes.
///    Buffer = Pointer to the structure specified by the value of the <i>Operation</i> parameter.
///    Flags = Reserved for future use. This parameter must be set to 0.
///    Overlapped = Pointer to an OVERLAPPED structure used for asynchronous output. This must be set to <b>NULL</b> if this function
///                 is not being called asynchronously.
///Returns:
///    If the function succeeds, the return value is nonzero. If the function fails, the return value is 0. To get
///    extended error information, call <b>GetLastError</b>. Some possible error codes follow. <table> <tr> <th>Return
///    code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_ACCESS_DISABLED_BY_POLICY</b></dt>
///    </dl> </td> <td width="60%"> The QoS subsystem is currently configured by policy to not allow this operation on
///    the network path between this host and the destination host. For example, the default policy prevents qWAVE
///    experiments from running to off-link destinations. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_IO_PENDING</b></dt> </dl> </td> <td width="60%"> The update flow request was successfully received.
///    Results will be returned during overlapped completion. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> The calling application does not have sufficient
///    privileges for the requested operation. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_HANDLE</b></dt> </dl> </td> <td width="60%"> The <i>QOSHandle</i> parameter is invalid.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> The
///    <i>FlowId</i> parameter is invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NETWORK_BUSY</b></dt>
///    </dl> </td> <td width="60%"> The requested flow properties were not available on this path. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_NOT_FOUND</b></dt> </dl> </td> <td width="60%"> The <i>FlowId</i> parameter
///    specified cannot be found. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NOT_ENOUGH_MEMORY</b></dt> </dl>
///    </td> <td width="60%"> A memory allocation failed. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_NOT_SUPPORTED</b></dt> </dl> </td> <td width="60%"> The operation being performed requires
///    information that the QoS subsystem does not have. Obtaining this information on this network is currently not
///    supported. For example, bandwidth estimations cannot be obtained on a network path where the destination host is
///    off-link. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NO_SYSTEM_RESOURCES</b></dt> </dl> </td> <td
///    width="60%"> There are insufficient resources to carry out the operation. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_IO_DEVICE</b></dt> </dl> </td> <td width="60%"> The request could not be performed because of an I/O
///    device error. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_DEVICE_REINITIALIZATION_NEEDED</b></dt> </dl>
///    </td> <td width="60%"> The indicated device requires reinitialization due to hardware errors. The application
///    should clean up and call QOSCreateHandle again. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_ADAP_HDW_ERR</b></dt> </dl> </td> <td width="60%"> A network adapter hardware error occurred. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_HOST_UNREACHABLE</b></dt> </dl> </td> <td width="60%"> The network
///    location cannot be reached. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_RETRY</b></dt> </dl> </td> <td
///    width="60%"> There is currently insufficient data about networking conditions to answer the query. This is
///    typically a transient state where qWAVE has erred on the side of caution as it awaits more data before
///    ascertaining the state of the network. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_UNEXP_NET_ERR</b></dt>
///    </dl> </td> <td width="60%"> The network connection with the remote host failed. </td> </tr> </table>
///    
@DllImport("qwave")
BOOL QOSSetFlow(HANDLE QOSHandle, uint FlowId, QOS_SET_FLOW Operation, uint Size, char* Buffer, uint Flags, 
                OVERLAPPED* Overlapped);

///The <b>QOSQueryFlow</b> function requests information about a specific flow added to the QoS subsystem. This function
///may be called asynchronously.
///Params:
///    QOSHandle = Handle to the QOS subsystem returned by QOSCreateHandle.
///    FlowId = Specifies a flow identifier. A <b>QOS_FLOWID</b> is an unsigned 32-bit integer.
///    Operation = Specifies which type of flow information is being queried. This parameter specifies what structure the
///                <i>Buffer</i> will contain. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
///                id="QOSQueryFlowFundamentals"></a><a id="qosqueryflowfundamentals"></a><a id="QOSQUERYFLOWFUNDAMENTALS"></a><dl>
///                <dt><b>QOSQueryFlowFundamentals</b></dt> </dl> </td> <td width="60%"> <i>Buffer</i> will contain a
///                QOS_FLOW_FUNDAMENTALS structure. </td> </tr> <tr> <td width="40%"><a id="QOSQueryPacketPriority"></a><a
///                id="qosquerypacketpriority"></a><a id="QOSQUERYPACKETPRIORITY"></a><dl> <dt><b>QOSQueryPacketPriority</b></dt>
///                </dl> </td> <td width="60%"> <i>Buffer</i> will contain a QOS_PACKET_PRIORITY structure. </td> </tr> <tr> <td
///                width="40%"><a id="QOSQueryOutgoingRate"></a><a id="qosqueryoutgoingrate"></a><a
///                id="QOSQUERYOUTGOINGRATE"></a><dl> <dt><b>QOSQueryOutgoingRate</b></dt> </dl> </td> <td width="60%">
///                <i>Buffer</i> will contain a <b>UINT64</b> value that indicates the flow rate specified when requesting the
///                contract, in bits per second. </td> </tr> </table>
///    Size = Indicates the size of the <i>Buffer</i> parameter, in bytes. On function return, if successful, this parameter
///           will specify the number of bytes copied into <i>Buffer</i>. If this call fails with
///           <b>ERROR_INSUFFICIENT_BUFFER</b>, this parameter will indicate the minimum required <i>Buffer</i> size in order
///           to successfully complete this operation.
///    Buffer = Pointer to the structure specified by the value of the <i>Operation</i> parameter.
///    Flags = Flags pertaining to the data being returned. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td
///            width="40%"><a id="QOS_QUERYFLOW_FRESH"></a><a id="qos_queryflow_fresh"></a><dl>
///            <dt><b>QOS_QUERYFLOW_FRESH</b></dt> </dl> </td> <td width="60%"> The QOS subsystem will only return fresh, not
///            cached, data. If fresh data is unavailable, it will try to obtain such data, at the expense of possibly taking
///            more time. If this is not possible, the call will fail with the error code <b>ERROR_RETRY</b>. This flag is only
///            applicable when the <i>Operation</i> parameter is set to <b>QOSQueryFlowFundamentals</b>. </td> </tr> </table>
///    Overlapped = Pointer to an OVERLAPPED structure used for asynchronous output. This must be set to <b>NULL</b> if this function
///                 is not being called asynchronously.
///Returns:
///    If the function succeeds, the return value is nonzero. If the function fails, the return value is 0. To get
///    extended error information, call <b>GetLastError</b>. Some possible error codes follow. <table> <tr> <th>Return
///    code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_ACCESS_DISABLED_BY_POLICY</b></dt>
///    </dl> </td> <td width="60%"> The QoS subsystem is currently configured by policy to not allow this operation on
///    the network path between this host and the destination host. For example, the default policy prevents qWAVE
///    experiments from running to off-link destinations. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_TIMEOUT</b></dt> </dl> </td> <td width="60%"> The request to the QOS subsystem timed out before
///    enough useful information could be gathered. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INSUFFICIENT_BUFFER</b></dt> </dl> </td> <td width="60%"> The buffer length as specified by the
///    <b>Size</b> parameter is not sufficient for the queried data. The <b>Size</b> parameter now contains the minimum
///    required size. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_HANDLE</b></dt> </dl> </td> <td
///    width="60%"> The <i>QOSHandle</i> parameter is invalid. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> The <i>FlowId</i> parameter or <i>Buffer</i>
///    size is insufficient. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NOT_FOUND</b></dt> </dl> </td> <td
///    width="60%"> Invalid <i>FlowId</i> specified. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_NOT_ENOUGH_MEMORY</b></dt> </dl> </td> <td width="60%"> Indicates that a memory allocation failed.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NOT_SUPPORTED</b></dt> </dl> </td> <td width="60%"> The
///    operation being performed requires information that the QoS subsystem does not have. Obtaining this information
///    on this network is currently not supported. For example, bandwidth estimations cannot be obtained on a network
///    path where the destination host is off-link. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_NO_SYSTEM_RESOURCES</b></dt> </dl> </td> <td width="60%"> There are insufficient resources to carry
///    out the operation. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_IO_DEVICE</b></dt> </dl> </td> <td
///    width="60%"> The request could not be performed because of an I/O device error. </td> </tr> <tr> <td width="40%">
///    <dl> <dt><b>ERROR_IO_PENDING</b></dt> </dl> </td> <td width="60%"> Indicates that the update flow request was
///    successfully initiated. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_DEVICE_REINITIALIZATION_NEEDED</b></dt> </dl> </td> <td width="60%"> The indicated device requires
///    reinitialization due to hardware errors. The application should clean up and call QOSCreateHandle again. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_ADAP_HDW_ERR</b></dt> </dl> </td> <td width="60%"> A network
///    adapter hardware error occurred. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_HOST_UNREACHABLE</b></dt>
///    </dl> </td> <td width="60%"> The network location cannot be reached. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_NO_DATA</b></dt> </dl> </td> <td width="60%"> The is no valid data to be returned. </td> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>ERROR_RETRY</b></dt> </dl> </td> <td width="60%"> There is currently insufficient
///    data about networking conditions to answer the query. This is typically a transient state where qWAVE has erred
///    on the side of caution as it awaits more data before ascertaining the state of the network. </td> </tr> </table>
///    
@DllImport("qwave")
BOOL QOSQueryFlow(HANDLE QOSHandle, uint FlowId, QOS_QUERY_FLOW Operation, uint* Size, char* Buffer, uint Flags, 
                  OVERLAPPED* Overlapped);

///The <b>QOSNotifyFlow</b> function registers the calling application to receive a notification about changes in
///network characteristics, such as congestion. Notifications may also be sent when a desired throughput is able to be
///achieved.
///Params:
///    QOSHandle = Handle to the QOS subsystem returned by QOSCreateHandle.
///    FlowId = Specifies the flow identifier from which the application wishes to receive notifications. A <b>QOS_FLOWID</b> is
///             an unsigned 32-bit integer.
///    Operation = A QOS_NOTIFY_FLOW value that indicates what the type of notification being requested.
///    Size = Indicates the size of the <i>Buffer</i> parameter, in bytes. On function return, if successful, this parameter
///           will specify the number of bytes copied into <i>Buffer</i>. If this call fails with
///           <b>ERROR_INSUFFICIENT_BUFFER</b>, this parameter will indicate the minimum required <i>Buffer</i> size in order
///           to successfully complete this operation.
///    Buffer = Pointer to a UINT64 that indicates the bandwidth at which point a notification will be sent. This parameter is
///             only used if the <i>Operation</i> parameter is set to <b>QOSNotifyAvailable</b>. For the
///             <b>QOSNotifyCongested</b> and <b>QOSNotifyUncongested</b> options, this parameter must be set to <b>NULL</b> on
///             input.
///    Flags = Reserved for future use. This parameter must be set to 0.
///    Overlapped = Pointer to an OVERLAPPED structure used for asynchronous output. This must be se to <b>NULL</b> if this function
///                 is not being called asynchronously.
///Returns:
///    If the function succeeds, a return value of nonzero is sent when the conditions set by the <i>Operation</i>
///    parameter are met. If the function fails, the return value is 0. To get extended error information, call
///    <b>GetLastError</b>. Some possible error codes follow. <table> <tr> <th>Return code</th> <th>Description</th>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_ACCESS_DISABLED_BY_POLICY</b></dt> </dl> </td> <td width="60%"> The
///    QoS subsystem is currently configured by policy to not allow this operation on the network path between this host
///    and the destination host. For example, the default policy prevents qWAVE experiments from running to off-link
///    destinations. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_IO_PENDING</b></dt> </dl> </td> <td
///    width="60%"> Indicates that notification request was successfully received. Results will be returned during
///    overlapped completion. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_HANDLE</b></dt> </dl> </td>
///    <td width="60%"> The <i>QOSHandle</i> parameter is invalid. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> The <i>FlowId</i> parameter is invalid.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NOT_ENOUGH_MEMORY</b></dt> </dl> </td> <td width="60%">
///    Indicates that a memory allocation failed. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NOT_FOUND</b></dt>
///    </dl> </td> <td width="60%"> Invalid <i>FlowId</i> specified. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_NOT_SUPPORTED</b></dt> </dl> </td> <td width="60%"> The operation being performed requires
///    information that the QoS subsystem does not have. Obtaining this information on this network is currently not
///    supported. For example, bandwidth estimations cannot be obtained on a network path where the destination host is
///    off-link. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NO_SYSTEM_RESOURCES</b></dt> </dl> </td> <td
///    width="60%"> There are insufficient resources to carry out the operation. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_IO_DEVICE</b></dt> </dl> </td> <td width="60%"> The request could not be performed because of an I/O
///    device error. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_DEVICE_REINITIALIZATION_NEEDED</b></dt> </dl>
///    </td> <td width="60%"> The indicated device requires reinitialization due to hardware errors. The application
///    should clean up and call QOSCreateHandle again. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_NOT_SUPPORTED</b></dt> </dl> </td> <td width="60%"> The QOS subsystem has determined that the
///    operation requested could not be completed on the network path specified. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_ADAP_HDW_ERR</b></dt> </dl> </td> <td width="60%"> A network adapter hardware error occurred. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_HOST_UNREACHABLE</b></dt> </dl> </td> <td width="60%"> The network
///    location cannot be reached. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_UNEXP_NET_ERR</b></dt> </dl>
///    </td> <td width="60%"> The network connection with the remote host failed. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_ALREADY_EXISTS</b></dt> </dl> </td> <td width="60%"> There is already a request for notifications of
///    the same type pending on this flow. </td> </tr> </table>
///    
@DllImport("qwave")
BOOL QOSNotifyFlow(HANDLE QOSHandle, uint FlowId, QOS_NOTIFY_FLOW Operation, uint* Size, char* Buffer, uint Flags, 
                   OVERLAPPED* Overlapped);

///The <b>QOSCancel</b> function cancels a pending overlapped operation, like QOSSetFlow.
///Params:
///    QOSHandle = Handle to the QOS subsystem returned by QOSCreateHandle.
///    Overlapped = Pointer to the OVERLAPPED structure used in the operation to be canceled.
///Returns:
///    If the function succeeds, the return value is nonzero. If the function fails, the return value is 0. To get
///    extended error information, call <b>GetLastError</b>. Some possible error codes follow. <table> <tr> <th>Return
///    code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_HANDLE</b></dt> </dl> </td>
///    <td width="60%"> The <i>QOSHandle</i> parameter is invalid. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> The <i>Overlapped</i> parameter is invalid.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NOT_ENOUGH_MEMORY</b></dt> </dl> </td> <td width="60%"> A
///    memory allocation failed. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NO_SYSTEM_RESOURCES</b></dt> </dl>
///    </td> <td width="60%"> There are insufficient resources to carry out the operation. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_IO_DEVICE</b></dt> </dl> </td> <td width="60%"> The request could not be performed
///    because of an I/O device error. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_DEVICE_REINITIALIZATION_NEEDED</b></dt> </dl> </td> <td width="60%"> The indicated device requires
///    reinitialization due to hardware errors. The application should clean up and call QOSCreateHandle again. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_ADAP_HDW_ERR</b></dt> </dl> </td> <td width="60%"> A network
///    adapter hardware error occurred. </td> </tr> </table>
///    
@DllImport("qwave")
BOOL QOSCancel(HANDLE QOSHandle, OVERLAPPED* Overlapped);

///The <b>TcRegisterClient</b> function is used to register a client with the traffic control interface (TCI). The
///<b>TcRegisterClient</b> function must be the first function call a client makes to the TCI. Client registration
///provides callback routines that allow the TCI to complete either client-initiated operations or asynchronous events.
///Upon successful registration, the caller of the <b>TcRegisterClient</b> function must be ready to have any of its TCI
///handlers called. See Entry Points Exposed by Clients of the Traffic Control Interface for more information.
///Params:
///    TciVersion = Traffic control version expected by the client, included to ensure compatibility between traffic control and the
///                 client. Clients can pass CURRENT_TCI_VERSION, defined in Traffic.h.
///    ClRegCtx = Client registration context. <i>ClRegCtx</i> is returned when the client's notification handler function is
///               called. This can be a container to hold an arbitrary client-defined context for this instance of the interface.
///    ClientHandlerList = Pointer to a list of client-supplied handlers. Client-supplied handlers are used for notification events and
///                        asynchronous completions. Each completion routine is optional, with the exception of the notification handler.
///                        Setting the notification handler to <b>NULL</b> will return an ERROR_INVALID_PARAMETER.
///    pClientHandle = Pointer to the buffer that traffic control uses to return a registration handle to the client.
///Returns:
///    <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>NO_ERROR</b></dt>
///    </dl> </td> <td width="60%"> The function executed without errors. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_NOT_ENOUGH_MEMORY</b></dt> </dl> </td> <td width="60%"> The system is out of memory. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> One of the
///    parameters is <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INCOMPATIBLE_TCI_VERSION</b></dt>
///    </dl> </td> <td width="60%"> The TCI version is wrong. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_OPEN_FAILED</b></dt> </dl> </td> <td width="60%"> Traffic control failed to open a system device.
///    The likely cause is insufficient privileges. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_TOO_MANY_CLIENTS</b></dt> </dl> </td> <td width="60%"> Traffic Control was unable to register with
///    the kernel component GPC. The likely cause is too many traffic control clients are currently connected.
///    <b>Windows 2000: </b>This value is not supported. </td> </tr> </table>
///    
@DllImport("TRAFFIC")
uint TcRegisterClient(uint TciVersion, HANDLE ClRegCtx, TCI_CLIENT_FUNC_LIST* ClientHandlerList, 
                      ptrdiff_t* pClientHandle);

///The <b>TcEnumerateInterfaces</b> function enumerates all traffic control–enabled network interfaces. Clients are
///notified of interface changes through the ClNotifyHandler function.
///Params:
///    ClientHandle = Handle used by traffic control to identify the client. Clients receive handles when registering with traffic
///                   control through the TcRegisterClient function.
///    pBufferSize = Pointer to a value indicating the size of the buffer. For input, this value is the size of the buffer, in bytes,
///                  allocated by the caller. For output, this value is the actual size of the buffer, in bytes, used or needed by
///                  traffic control. A value of zero on output indicates that no traffic control interfaces are available, indicating
///                  that the QOS Packet Scheduler is not installed.
///    InterfaceBuffer = Pointer to the buffer containing the returned list of interface descriptors.
///Returns:
///    Successful completion returns the device name of the interface. <table> <tr> <th>Return code</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>NO_ERROR</b></dt> </dl> </td> <td width="60%"> The
///    function executed without errors. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_HANDLE</b></dt>
///    </dl> </td> <td width="60%"> The client handle is invalid. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> One of the parameters is <b>NULL</b>. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INSUFFICIENT_BUFFER</b></dt> </dl> </td> <td width="60%"> The
///    buffer is too small to enumerate all interfaces. If this error is returned, the correct (required) size of the
///    buffer is passed back in <i>pBufferSize</i>. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_NOT_ENOUGH_MEMORY</b></dt> </dl> </td> <td width="60%"> The system is out of memory. </td> </tr>
///    </table>
///    
@DllImport("TRAFFIC")
uint TcEnumerateInterfaces(HANDLE ClientHandle, uint* pBufferSize, TC_IFC_DESCRIPTOR* InterfaceBuffer);

///The <b>TcOpenInterface</b> function opens an interface. The <b>TcOpenInterface</b> function identifies and opens an
///interface based on its text string, which is available from a call to TcEnumerateInterfaces. Once an interface is
///opened, the client must be prepared to receive notification regarding the open interface, through traffic control's
///use of the interface context.
///Params:
///    pInterfaceName = Pointer to the text string identifying the interface to be opened. This text string is part of the information
///                     returned in a previous call to TcEnumerateInterfaces.
///    ClientHandle = Handle used by traffic control to identify the client, obtained through the <i>pClientHandle</i> parameter of the
///                   client's call to TcRegisterClient.
///    ClIfcCtx = Client's interface–context handle for the opened interface. Used as a callback parameter by traffic control
///               when communicating with the client about the opened interface. This can be a container to hold an arbitrary
///               client-defined context for this instance of the interface.
///    pIfcHandle = Pointer to the buffer where traffic control can return an interface handle. The interface handle returned to
///                 <i>pIfcHandle</i> must be used by the client to identify the interface in subsequent calls to traffic control.
///Returns:
///    <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>NO_ERROR</b></dt>
///    </dl> </td> <td width="60%"> The function executed without errors. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> One of the parameters is <b>NULL</b>. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NOT_ENOUGH_MEMORY</b></dt> </dl> </td> <td width="60%"> The system
///    is out of memory. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NOT_FOUND</b></dt> </dl> </td> <td
///    width="60%"> Traffic control failed to find an interface with the name provided in <i>pInterfaceName</i>. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_HANDLE</b></dt> </dl> </td> <td width="60%"> The client
///    handle is invalid. </td> </tr> </table>
///    
@DllImport("TRAFFIC")
uint TcOpenInterfaceA(const(char)* pInterfaceName, HANDLE ClientHandle, HANDLE ClIfcCtx, ptrdiff_t* pIfcHandle);

///The <b>TcOpenInterface</b> function opens an interface. The <b>TcOpenInterface</b> function identifies and opens an
///interface based on its text string, which is available from a call to TcEnumerateInterfaces. Once an interface is
///opened, the client must be prepared to receive notification regarding the open interface, through traffic control's
///use of the interface context.
///Params:
///    pInterfaceName = Pointer to the text string identifying the interface to be opened. This text string is part of the information
///                     returned in a previous call to TcEnumerateInterfaces.
///    ClientHandle = Handle used by traffic control to identify the client, obtained through the <i>pClientHandle</i> parameter of the
///                   client's call to TcRegisterClient.
///    ClIfcCtx = Client's interface–context handle for the opened interface. Used as a callback parameter by traffic control
///               when communicating with the client about the opened interface. This can be a container to hold an arbitrary
///               client-defined context for this instance of the interface.
///    pIfcHandle = Pointer to the buffer where traffic control can return an interface handle. The interface handle returned to
///                 <i>pIfcHandle</i> must be used by the client to identify the interface in subsequent calls to traffic control.
///Returns:
///    <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>NO_ERROR</b></dt>
///    </dl> </td> <td width="60%"> The function executed without errors. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> One of the parameters is <b>NULL</b>. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NOT_ENOUGH_MEMORY</b></dt> </dl> </td> <td width="60%"> The system
///    is out of memory. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NOT_FOUND</b></dt> </dl> </td> <td
///    width="60%"> Traffic control failed to find an interface with the name provided in <i>pInterfaceName</i>. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_HANDLE</b></dt> </dl> </td> <td width="60%"> The client
///    handle is invalid. </td> </tr> </table>
///    
@DllImport("TRAFFIC")
uint TcOpenInterfaceW(const(wchar)* pInterfaceName, HANDLE ClientHandle, HANDLE ClIfcCtx, ptrdiff_t* pIfcHandle);

///The <b>TcCloseInterface</b> function closes an interface previously opened with a call to TcOpenInterface. All flows
///and filters on a particular interface should be closed before closing the interface with a call to
///<b>TcCloseInterface</b>.
///Params:
///    IfcHandle = Handle associated with the interface to be closed. This handle is obtained by a previous call to the
///                TcOpenInterface function.
///Returns:
///    <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>NO_ERROR</b></dt>
///    </dl> </td> <td width="60%"> The function executed without errors. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_HANDLE</b></dt> </dl> </td> <td width="60%"> The interface handle is invalid. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>ERROR_TC_SUPPORTED_OBJECTS_EXIST</b></dt> </dl> </td> <td width="60%"> Not all
///    flows have been deleted for this interface. </td> </tr> </table>
///    
@DllImport("TRAFFIC")
uint TcCloseInterface(HANDLE IfcHandle);

///The <b>TcQueryInterface</b> function queries traffic control for related per-interface parameters. A traffic control
///parameter is queried by providing its globally unique identifier (GUID). Setting the <i>NotifyChange</i> parameter to
///<b>TRUE</b> enables event notification on the specified GUID, after which notification events are sent to a client
///whenever the queried parameter changes. GUIDs for which clients can request notification are found in the GUID entry;
///the column titled "Notification" denotes which GUIDs are available for notification.
///Params:
///    IfcHandle = Handle associated with the interface to be queried. This handle is obtained by a previous call to the
///                TcOpenInterface function.
///    pGuidParam = Pointer to the globally unique identifier (GUID) that corresponds to the traffic control parameter being queried.
///    NotifyChange = Used to request notifications from traffic control for the parameter being queried. If <b>TRUE</b>, traffic
///                   control will notify the client, through the ClNotifyHandler function, upon changes to the parameter corresponding
///                   to the GUID provided in <i>pGuidParam</i>. Notifications are off by default.
///    pBufferSize = Indicates the size of the buffer, in bytes. For input, this value is the size of the buffer allocated by the
///                  caller. For output, this value is the actual size of the buffer, in bytes, used by traffic control.
///    Buffer = Pointer to a client-allocated buffer into which returned data will be written.
///Returns:
///    Note that, with regard to a requested notification state, only a return value of NO_ERROR will result in the
///    application of the requested notification state. If a return value other than NO_ERROR is returned from a call to
///    the <b>TcQueryInterface</b> function, the requested change in notification state will not be accepted. <table>
///    <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>NO_ERROR</b></dt> </dl>
///    </td> <td width="60%"> The function executed without errors. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_HANDLE</b></dt> </dl> </td> <td width="60%"> Invalid interface handle. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> Invalid or <b>NULL</b>
///    parameter. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INSUFFICIENT_BUFFER</b></dt> </dl> </td> <td
///    width="60%"> The buffer is too small to store the results. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_NOT_SUPPORTED</b></dt> </dl> </td> <td width="60%"> Querying for the GUID provided is not supported
///    on the provided interface. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_WMI_GUID_NOT_FOUND</b></dt> </dl>
///    </td> <td width="60%"> The device did not register for this GUID. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_WMI_INSTANCE_NOT_FOUND</b></dt> </dl> </td> <td width="60%"> The instance name was not found, likely
///    because the interface is in the process of being closed. </td> </tr> </table>
///    
@DllImport("TRAFFIC")
uint TcQueryInterface(HANDLE IfcHandle, GUID* pGuidParam, ubyte NotifyChange, uint* pBufferSize, char* Buffer);

///The <b>TcSetInterface</b> function sets individual parameters for a given interface.
///Params:
///    IfcHandle = Handle associated with the interface to be set. This handle is obtained by a previous call to the TcOpenInterface
///                function.
///    pGuidParam = Pointer to the globally unique identifier (GUID) that corresponds to the parameter to be set. A list of available
///                 GUIDs can be found in GUID.
///    BufferSize = Size of the client-provided buffer, in bytes.
///    Buffer = Pointer to a client-provided buffer. <i>Buffer</i> must contain the value to which the traffic control parameter
///             provided in <i>pGuidParam</i> should be set.
///Returns:
///    <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>NO_ERROR</b></dt>
///    </dl> </td> <td width="60%"> The function executed without errors. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_HANDLE</b></dt> </dl> </td> <td width="60%"> Invalid interface handle. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> Invalid parameter. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NOT_SUPPORTED</b></dt> </dl> </td> <td width="60%"> Setting the
///    GUID for the provided interface is not supported. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_WMI_INSTANCE_NOT_FOUND</b></dt> </dl> </td> <td width="60%"> The GUID is not available. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>ERROR_WMI_GUID_NOT_FOUND</b></dt> </dl> </td> <td width="60%"> The device did
///    not register for this GUID. </td> </tr> </table>
///    
@DllImport("TRAFFIC")
uint TcSetInterface(HANDLE IfcHandle, GUID* pGuidParam, uint BufferSize, char* Buffer);

///The <b>TcQueryFlow</b> function queries traffic control for the value of a specific flow parameter based on the name
///of the flow. The name of a flow can be retrieved from the TcEnumerateFlows function or from the TcGetFlowName
///function.
///Params:
///    pFlowName = Name of the flow being queried.
///    pGuidParam = Pointer to the globally unique identifier (GUID) that corresponds to the flow parameter of interest. A list of
///                 traffic control's GUIDs can be found in GUID.
///    pBufferSize = Pointer to the size of the client-provided buffer or the number of bytes used by traffic control. For input,
///                  points to the size of <i>Buffer</i>, in bytes. For output, points to the actual amount of buffer space written
///                  with returned flow-parameter data, in bytes.
///    Buffer = Pointer to the client-provided buffer in which the returned flow parameter is written.
///Returns:
///    <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>NO_ERROR</b></dt>
///    </dl> </td> <td width="60%"> The function executed without errors. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> A parameter is invalid. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_INSUFFICIENT_BUFFER</b></dt> </dl> </td> <td width="60%"> The provided buffer is
///    too small to hold the results. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NOT_SUPPORTED</b></dt> </dl>
///    </td> <td width="60%"> The requested GUID is not supported. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_WMI_GUID_NOT_FOUND</b></dt> </dl> </td> <td width="60%"> The device did not register for this GUID.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_WMI_INSTANCE_NOT_FOUND</b></dt> </dl> </td> <td width="60%">
///    The instance name was not found, likely because the flow or the interface is in the process of being closed.
///    </td> </tr> </table>
///    
@DllImport("TRAFFIC")
uint TcQueryFlowA(const(char)* pFlowName, GUID* pGuidParam, uint* pBufferSize, char* Buffer);

///The <b>TcQueryFlow</b> function queries traffic control for the value of a specific flow parameter based on the name
///of the flow. The name of a flow can be retrieved from the TcEnumerateFlows function or from the TcGetFlowName
///function.
///Params:
///    pFlowName = Name of the flow being queried.
///    pGuidParam = Pointer to the globally unique identifier (GUID) that corresponds to the flow parameter of interest. A list of
///                 traffic control's GUIDs can be found in GUID.
///    pBufferSize = Pointer to the size of the client-provided buffer or the number of bytes used by traffic control. For input,
///                  points to the size of <i>Buffer</i>, in bytes. For output, points to the actual amount of buffer space written
///                  with returned flow-parameter data, in bytes.
///    Buffer = Pointer to the client-provided buffer in which the returned flow parameter is written.
///Returns:
///    <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>NO_ERROR</b></dt>
///    </dl> </td> <td width="60%"> The function executed without errors. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> A parameter is invalid. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_INSUFFICIENT_BUFFER</b></dt> </dl> </td> <td width="60%"> The provided buffer is
///    too small to hold the results. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NOT_SUPPORTED</b></dt> </dl>
///    </td> <td width="60%"> The requested GUID is not supported. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_WMI_GUID_NOT_FOUND</b></dt> </dl> </td> <td width="60%"> The device did not register for this GUID.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_WMI_INSTANCE_NOT_FOUND</b></dt> </dl> </td> <td width="60%">
///    The instance name was not found, likely because the flow or the interface is in the process of being closed.
///    </td> </tr> </table>
///    
@DllImport("TRAFFIC")
uint TcQueryFlowW(const(wchar)* pFlowName, GUID* pGuidParam, uint* pBufferSize, char* Buffer);

///The <b>TcSetFlow</b> function sets individual parameters for a given flow.
///Params:
///    pFlowName = Name of the flow being set. The value for this parameter is obtained by a previous call to the TcEnumerateFlows
///                function or the TcGetFlowName function.
///    pGuidParam = Pointer to the globally unique identifier (GUID) that corresponds to the parameter to be set. A list of available
///                 GUIDs can be found in GUID.
///    BufferSize = Size of the client-provided buffer, in bytes.
///    Buffer = Pointer to a client-provided buffer. Buffer must contain the value to which the traffic control parameter
///             provided in <i>pGuidParam</i> should be set.
///Returns:
///    The <b>TcSetFlow</b> function has the following return values. <table> <tr> <th>Return code</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>NO_ERROR</b></dt> </dl> </td> <td width="60%"> The
///    function executed without errors. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NOT_READY</b></dt> </dl>
///    </td> <td width="60%"> The flow is currently being modified. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_NOT_ENOUGH_MEMORY</b></dt> </dl> </td> <td width="60%"> The buffer size was insufficient for the
///    GUID. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%">
///    Invalid parameter. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NOT_SUPPORTED</b></dt> </dl> </td> <td
///    width="60%"> Setting the GUID for the provided flow is not supported. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_WMI_INSTANCE_NOT_FOUND</b></dt> </dl> </td> <td width="60%"> The instance name was not found, likely
///    due to the flow or the interface being in the process of being closed. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_WMI_GUID_NOT_FOUND</b></dt> </dl> </td> <td width="60%"> The device did not register for this GUID.
///    </td> </tr> </table>
///    
@DllImport("TRAFFIC")
uint TcSetFlowA(const(char)* pFlowName, GUID* pGuidParam, uint BufferSize, char* Buffer);

///The <b>TcSetFlow</b> function sets individual parameters for a given flow.
///Params:
///    pFlowName = Name of the flow being set. The value for this parameter is obtained by a previous call to the TcEnumerateFlows
///                function or the TcGetFlowName function.
///    pGuidParam = Pointer to the globally unique identifier (GUID) that corresponds to the parameter to be set. A list of available
///                 GUIDs can be found in GUID.
///    BufferSize = Size of the client-provided buffer, in bytes.
///    Buffer = Pointer to a client-provided buffer. Buffer must contain the value to which the traffic control parameter
///             provided in <i>pGuidParam</i> should be set.
///Returns:
///    The <b>TcSetFlow</b> function has the following return values. <table> <tr> <th>Return code</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>NO_ERROR</b></dt> </dl> </td> <td width="60%"> The
///    function executed without errors. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NOT_READY</b></dt> </dl>
///    </td> <td width="60%"> The flow is currently being modified. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_NOT_ENOUGH_MEMORY</b></dt> </dl> </td> <td width="60%"> The buffer size was insufficient for the
///    GUID. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%">
///    Invalid parameter. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NOT_SUPPORTED</b></dt> </dl> </td> <td
///    width="60%"> Setting the GUID for the provided flow is not supported. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_WMI_INSTANCE_NOT_FOUND</b></dt> </dl> </td> <td width="60%"> The instance name was not found, likely
///    due to the flow or the interface being in the process of being closed. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_WMI_GUID_NOT_FOUND</b></dt> </dl> </td> <td width="60%"> The device did not register for this GUID.
///    </td> </tr> </table>
///    
@DllImport("TRAFFIC")
uint TcSetFlowW(const(wchar)* pFlowName, GUID* pGuidParam, uint BufferSize, char* Buffer);

///The <b>TcAddFlow</b> function adds a new flow on the specified interface. Note that the successful addition of a flow
///does not necessarily indicate a change in the way traffic is handled; traffic handling changes are effected by
///attaching a filter to the added flow, using the TcAddFilter function. Traffic control clients that have registered an
///<b>AddFlowComplete</b> handler (a mechanism for allowing traffic control to call the ClAddFlowComplete callback
///function in order to alert clients of completed flow additions) can expect a return value of ERROR_SIGNAL_PENDING.
///For more information, see Traffic Control Objects.
///Params:
///    IfcHandle = Handle associated with the interface on which the flow is to be added. This handle is obtained by a previous call
///                to the TcOpenInterface function.
///    ClFlowCtx = Client provided–flow context handle. Used subsequently by traffic control when referring to the added flow.
///    Flags = Reserved for future use. Must be set to zero.
///    pGenericFlow = Pointer to a description of the flow being installed.
///    pFlowHandle = Pointer to a location into which traffic control will return the flow handle. This flow handle should be used in
///                  subsequent calls to traffic control to refer to the installed flow.
///Returns:
///    There are many reasons why a request to add a flow might be rejected. Error codes returned by traffic control
///    from calls to <b>TcAddFlow</b> are provided to aid in determining the reason for rejection. <table> <tr>
///    <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>NO_ERROR</b></dt> </dl> </td>
///    <td width="60%"> The function executed without errors. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_SIGNAL_PENDING</b></dt> </dl> </td> <td width="60%"> The function is being executed asynchronously;
///    the client will be called back through the client-exposed ClAddFlowComplete function when the flow has been added
///    or when the process has been completed. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_HANDLE</b></dt> </dl> </td> <td width="60%"> The interface handle is invalid. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>ERROR_NOT_ENOUGH_MEMORY</b></dt> </dl> </td> <td width="60%"> The system is out
///    of memory. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td
///    width="60%"> A parameter is invalid. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_SERVICE_TYPE</b></dt> </dl> </td> <td width="60%"> An unspecified or bad <b>INTSERV</b>
///    service type has been provided. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_TOKEN_RATE</b></dt>
///    </dl> </td> <td width="60%"> An unspecified or bad TOKENRATE value has been provided. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_INVALID_PEAK_RATE</b></dt> </dl> </td> <td width="60%"> The PEAKBANDWIDTH value is
///    invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_SD_MODE</b></dt> </dl> </td> <td
///    width="60%"> The SHAPEDISCARDMODE is invalid. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_QOS_PRIORITY</b></dt> </dl> </td> <td width="60%"> The priority value is invalid. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_TRAFFIC_CLASS</b></dt> </dl> </td> <td width="60%"> The
///    traffic class value is invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NO_SYSTEM_RESOURCES</b></dt>
///    </dl> </td> <td width="60%"> There are not enough resources to accommodate the requested flow. </td> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>ERROR_TC_OBJECT_LENGTH_INVALID</b></dt> </dl> </td> <td width="60%"> Bad length
///    specified for the TC objects. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_DIFFSERV_FLOW</b></dt>
///    </dl> </td> <td width="60%"> Applies to Diffserv flows. Indicates that the QOS_DIFFSERV object was passed with an
///    invalid parameter. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_DS_MAPPING_EXISTS</b></dt> </dl> </td> <td
///    width="60%"> Applies to Diffserv flows. Indicates that the QOS_DIFFSERV_RULE specified in TC_GEN_FLOW already
///    applies to an existing flow on the interface. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_SHAPE_RATE</b></dt> </dl> </td> <td width="60%"> The QOS_SHAPING_RATE object was passed with
///    an invalid <b>ShapingRate</b> member. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_DS_CLASS</b></dt> </dl> </td> <td width="60%"> The QOS_DS_CLASS is invalid. </td> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>ERROR_NETWORK_UNREACHABLE</b></dt> </dl> </td> <td width="60%"> The network cable is
///    not plugged into the adapter. </td> </tr> </table>
///    
@DllImport("TRAFFIC")
uint TcAddFlow(HANDLE IfcHandle, HANDLE ClFlowCtx, uint Flags, TC_GEN_FLOW* pGenericFlow, ptrdiff_t* pFlowHandle);

///The <b>TcGetFlowName</b> function provides the name of a flow that has been created by the calling client. Flow
///properties and other characteristics of flows are provided based on the name of a flow. Flow names can also be
///retrieved by a call to the TcEnumerateFlows function.
///Params:
///    FlowHandle = Handle for the flow.
///    StrSize = Size of the string buffer provided in <i>pFlowName</i>.
///    pFlowName = Pointer to the output buffer holding the flow name.
///Returns:
///    <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>NO_ERROR</b></dt>
///    </dl> </td> <td width="60%"> The function executed without errors. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_HANDLE</b></dt> </dl> </td> <td width="60%"> The flow handle is invalid. </td> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> One of the parameters
///    is invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INSUFFICIENT_BUFFER</b></dt> </dl> </td> <td
///    width="60%"> The buffer is too small to contain the results. </td> </tr> </table>
///    
@DllImport("TRAFFIC")
uint TcGetFlowNameA(HANDLE FlowHandle, uint StrSize, const(char)* pFlowName);

///The <b>TcGetFlowName</b> function provides the name of a flow that has been created by the calling client. Flow
///properties and other characteristics of flows are provided based on the name of a flow. Flow names can also be
///retrieved by a call to the TcEnumerateFlows function.
///Params:
///    FlowHandle = Handle for the flow.
///    StrSize = Size of the string buffer provided in <i>pFlowName</i>.
///    pFlowName = Pointer to the output buffer holding the flow name.
///Returns:
///    <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>NO_ERROR</b></dt>
///    </dl> </td> <td width="60%"> The function executed without errors. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_HANDLE</b></dt> </dl> </td> <td width="60%"> The flow handle is invalid. </td> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> One of the parameters
///    is invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INSUFFICIENT_BUFFER</b></dt> </dl> </td> <td
///    width="60%"> The buffer is too small to contain the results. </td> </tr> </table>
///    
@DllImport("TRAFFIC")
uint TcGetFlowNameW(HANDLE FlowHandle, uint StrSize, const(wchar)* pFlowName);

///The <b>TcModifyFlow</b> function modifies an existing flow. When calling <b>TcModifyFlow</b>, new <i>Flowspec</i>
///parameters and any traffic control objects should be filled. Traffic control clients that have registered a
///ModifyFlowComplete handler (a mechanism for allowing traffic control to call the ClModifyFlowComplete callback
///function in order to alert clients of completed flow modifications) can expect a return value of
///ERROR_SIGNAL_PENDING.
///Params:
///    FlowHandle = Handle for the flow, as received from a previous call to the TcAddFlow function.
///    pGenericFlow = Pointer to a description of the flow modifications.
///Returns:
///    <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>NO_ERROR</b></dt>
///    </dl> </td> <td width="60%"> The function executed without errors. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_SIGNAL_PENDING</b></dt> </dl> </td> <td width="60%"> The function is being executed asynchronously;
///    the client will be called back through the client-exposed ClModifyFlowComplete function when the flow has been
///    added, or when the process has been completed. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_HANDLE</b></dt> </dl> </td> <td width="60%"> The interface handle is invalid. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>ERROR_NOT_ENOUGH_MEMORY</b></dt> </dl> </td> <td width="60%"> The system is out
///    of memory. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NOT_READY</b></dt> </dl> </td> <td width="60%">
///    Action performed on the flow by a previous function call to the TcAddFlow, TcModifyFlow, or TcDeleteFlow has not
///    yet completed. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td
///    width="60%"> A parameter is invalid. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_SERVICE_TYPE</b></dt> </dl> </td> <td width="60%"> An unspecified or bad intserv service
///    type has been provided. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_TOKEN_RATE</b></dt> </dl>
///    </td> <td width="60%"> An unspecified or bad <i>TokenRate</i> value has been provided. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_INVALID_PEAK_RATE</b></dt> </dl> </td> <td width="60%"> The <i>PeakBandwidth</i>
///    value is invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_SD_MODE</b></dt> </dl> </td> <td
///    width="60%"> The <i>ShapeDiscardMode</i> is invalid. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_QOS_PRIORITY</b></dt> </dl> </td> <td width="60%"> The priority value is invalid. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_TRAFFIC_CLASS</b></dt> </dl> </td> <td width="60%"> The
///    traffic class value is invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NO_SYSTEM_RESOURCES</b></dt>
///    </dl> </td> <td width="60%"> There are not enough resources to accommodate the requested flow. </td> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>ERROR_TC_OBJECT_LENGTH_INVALID</b></dt> </dl> </td> <td width="60%"> Bad length
///    specified for the TC objects. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_DIFFSERV_FLOW</b></dt>
///    </dl> </td> <td width="60%"> Applies to Diffserv flows. Indicates that the QOS_DIFFSERV object was passed with an
///    invalid parameter. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_DS_MAPPING_EXISTS</b></dt> </dl> </td> <td
///    width="60%"> Applies to Diffserv flows. Indicates that the QOS_DIFFSERV_RULE specified in TC_GEN_FLOW already
///    applies to an existing flow on the interface. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_SHAPE_RATE</b></dt> </dl> </td> <td width="60%"> The QOS_SHAPING_RATE was passed with an
///    invalid ShapeRate. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_DS_CLASS</b></dt> </dl> </td> <td
///    width="60%"> QOS_DS_CLASS is invalid. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_NETWORK_UNREACHABLE</b></dt> </dl> </td> <td width="60%"> The network cable is not plugged into the
///    adapter. </td> </tr> </table>
///    
@DllImport("TRAFFIC")
uint TcModifyFlow(HANDLE FlowHandle, TC_GEN_FLOW* pGenericFlow);

///The <b>TcAddFilter</b> function associates a new filter with an existing flow that allows packets matching the filter
///to be directed to the associated flow. Filters include a pattern and a mask. The pattern specifies particular
///parameter values, while the mask specifies which parameters and parameter subfields apply to a given filter. When a
///pattern/mask combination is applied to a set of packets, matching packets are directed to the flow to which the
///corresponding filter is associated. Traffic control returns a handle to the newly added filter, in the pFilterHandle
///parameter, by which clients can refer to the added filter. Pending flows, such as those processing a TcAddFlow or
///TcModifyFlow request for which a callback routine has not been completed, cannot have filters associated to them;
///only flows that have been completed and are stable can apply associated filters. The relationship between filters and
///flows is many to one. Multiple filters can be applied to a single flow; however, a filter can only apply to one flow.
///For example, flow A can have filters X, Y and Z applied to it, but as long as flow A is active, filters X, Y and Z
///cannot apply to any other flows.
///Params:
///    FlowHandle = Handle for the flow, as received from a previous call to the TcAddFlow function.
///    pGenericFilter = Pointer to a description of the filter to be installed.
///    pFilterHandle = Pointer to a buffer where traffic control returns the filter handle. This filter handle is used by the client in
///                    subsequent calls to refer to the added filter.
///Returns:
///    <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>NO_ERROR</b></dt>
///    </dl> </td> <td width="60%"> The function executed without errors. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_HANDLE</b></dt> </dl> </td> <td width="60%"> The flow handle is invalid. </td> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> A parameter is
///    invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_ADDRESS_TYPE</b></dt> </dl> </td> <td
///    width="60%"> An invalid address type has been provided. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_DUPLICATE_FILTER</b></dt> </dl> </td> <td width="60%"> An identical filter exists on a flow on this
///    interface. <div class="alert"><b>Note</b> In Windows Vista, this code will not be returned.</div> <div> </div>
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_FILTER_CONFLICT</b></dt> </dl> </td> <td width="60%"> A
///    conflicting filter exists on a flow on this interface. <div class="alert"><b>Note</b> In Windows Vista, this code
///    will not be returned.</div> <div> </div> </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_NOT_ENOUGH_MEMORY</b></dt> </dl> </td> <td width="60%"> The system is out of memory. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>ERROR_NOT READY</b></dt> </dl> </td> <td width="60%"> The flow is either being
///    installed, modified, or deleted, and is not in a state that accepts filters. </td> </tr> </table>
///    
@DllImport("TRAFFIC")
uint TcAddFilter(HANDLE FlowHandle, TC_GEN_FILTER* pGenericFilter, ptrdiff_t* pFilterHandle);

///The <b>TcDeregisterClient</b> function deregisters a client with the Traffic Control Interface (TCI). Before
///deregistering, a client must delete each installed flow and filter with the TcDeleteFlow and TcDeleteFilter
///functions, and close all open interfaces with the TcCloseInterface function, respectively.
///Params:
///    ClientHandle = Handle assigned to the client through the previous call to the TcRegisterClient function.
///Returns:
///    <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>NO_ERROR</b></dt>
///    </dl> </td> <td width="60%"> The function executed without errors. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_HANDLE</b></dt> </dl> </td> <td width="60%"> Invalid interface handle, or the handle was set
///    to <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_TC_SUPPORTED_OBJECTS_EXIST</b></dt> </dl>
///    </td> <td width="60%"> Interfaces are still open for this client. all interfaces must be closed to deregister a
///    client. </td> </tr> </table>
///    
@DllImport("TRAFFIC")
uint TcDeregisterClient(HANDLE ClientHandle);

///The <b>TcDeleteFlow</b> function deletes a flow that has been added with the TcAddFlow function. Clients should
///delete all filters associated with a flow before deleting it, otherwise, an error will be returned and the function
///will not delete the flow. Traffic control clients that have registered a <b>DeleteFlowComplete</b> handler (a
///mechanism for allowing traffic control to call the ClDeleteFlowComplete callback function to alert clients of
///completed flow deletions) can expect a return value of ERROR_SIGNAL_PENDING.
///Params:
///    FlowHandle = Handle for the flow, as received from a previous call to the TcAddFlow function.
///Returns:
///    <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>NO_ERROR</b></dt>
///    </dl> </td> <td width="60%"> The function executed without errors. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_SIGNAL_PENDING</b></dt> </dl> </td> <td width="60%"> The function is being executed asynchronously;
///    the client will be called back through the client-exposed ClDeleteFlowComplete function when the flow has been
///    added, or when the process has been completed. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_HANDLE</b></dt> </dl> </td> <td width="60%"> The flow handle is invalid or <b>NULL</b>.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NOT_READY</b></dt> </dl> </td> <td width="60%"> Action
///    performed on the flow by a previous function call to TcModifyFlow, TcDeleteFlow, or TcAddFlow has not yet
///    completed. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_TC_SUPPORTED_OBJECTS_EXIST</b></dt> </dl> </td>
///    <td width="60%"> At least one filter associated with this flow exists. </td> </tr> </table>
///    
@DllImport("TRAFFIC")
uint TcDeleteFlow(HANDLE FlowHandle);

///The <b>TcDeleteFilter</b> function deletes a filter previously added with the TcAddFilter function.
///Params:
///    FilterHandle = Handle to the filter to be deleted, as received in a previous call to the TcAddFilter function.
///Returns:
///    <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>NO_ERROR</b></dt>
///    </dl> </td> <td width="60%"> The function executed without errors. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_HANDLE</b></dt> </dl> </td> <td width="60%"> The filter handle is invalid. </td> </tr>
///    </table> <div class="alert"><b>Note</b> Use of the <b>TcDeleteFilter</b> function requires administrative
///    privilege.</div> <div> </div>
///    
@DllImport("TRAFFIC")
uint TcDeleteFilter(HANDLE FilterHandle);

///The <b>TcEnumerateFlows</b> function enumerates installed flows and their associated filters on an interface. The
///process of returning flow enumeration often consists of multiple calls to the <b>TcEnumerateFlows</b> function. The
///process of receiving flow information from <b>TcEnumerateFlows</b> can be compared to reading through a book in
///multiple sittings, where a certain number of pages are read at one time, a bookmark is placed where reading stops,
///reading is resumed at the bookmark, and continues until the book is finished. The <b>TcEnumerateFlows</b> function
///fills the <i>Buffer</i> parameter with as many flow enumerations as the buffer can hold, then returns a handle in the
///pEnumToken parameter that internally bookmarks where the enumeration stopped. Subsequent calls to
///<b>TcEnumerateFlows</b> must then pass the returned <i>pEnumToken</i> value to instruct traffic control where to
///resume flow enumeration information. When all flows have been enumerated, <i>pEnumToken</i> will be <b>NULL</b>.
///Params:
///    IfcHandle = Handle associated with the interface on which flows are to be enumerated. This handle is obtained by a previous
///                call to the TcOpenInterface function.
///    pEnumHandle = Pointer to the enumeration token, used internally by traffic control to maintain returned flow information state.
///                  For input of the initial call to <b>TcEnumerateFlows</b>, <i>pEnumToken</i> should be set to <b>NULL</b>. For
///                  input on subsequent calls, <i>pEnumToken</i> must be the value returned as the <i>pEnumToken</i> OUT parameter
///                  from the immediately preceding call to <b>TcEnumerateFlows</b>. For output, <i>pEnumToken</i> is the refreshed
///                  enumeration token that must be used in the following call to <b>TcEnumerateFlows</b>.
///    pFlowCount = Pointer to the number of requested or returned flows. For input, this parameter designates the number of
///                 requested flows or it can be set to <b>0xFFFF</b> to request all flows. For output, <i>pFlowCount</i> returns the
///                 number of flows actually returned in <i>Buffer</i>.
///    pBufSize = Pointer to the size of the client-provided buffer or the number of bytes used by traffic control. For input,
///               points to the size of <i>Buffer</i>, in bytes. For output, points to the actual amount of buffer space, in bytes,
///               written or needed with flow enumerations.
///    Buffer = Pointer to the buffer containing flow enumerations. See ENUMERATION_BUFFER for more information about flow
///             enumerations.
///Returns:
///    <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>NO_ERROR</b></dt>
///    </dl> </td> <td width="60%"> The function executed without errors. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_HANDLE</b></dt> </dl> </td> <td width="60%"> Invalid interface handle. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> One of the pointers is
///    <b>NULL</b>, or <i>pFlowCount</i> or <i>pBufSize</i> are set to zero. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INSUFFICIENT_BUFFER</b></dt> </dl> </td> <td width="60%"> The buffer is too small to store even a
///    single flow's information and attached filters. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_NOT_ENOUGH_MEMORY</b></dt> </dl> </td> <td width="60%"> The system is out of memory. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_DATA</b></dt> </dl> </td> <td width="60%"> The enumeration token
///    is no longer valid. </td> </tr> </table>
///    
@DllImport("TRAFFIC")
uint TcEnumerateFlows(HANDLE IfcHandle, ptrdiff_t* pEnumHandle, uint* pFlowCount, uint* pBufSize, 
                      ENUMERATION_BUFFER* Buffer);


