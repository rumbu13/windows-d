// Written in the D programming language.

module windows.dataexchange;

public import windows.core;
public import windows.gdi : HMETAFILE;
public import windows.security : SECURITY_QUALITY_OF_SERVICE;
public import windows.systemservices : BOOL, HANDLE, PSTR, PWSTR;
public import windows.windowsandmessaging : HWND, LPARAM, WPARAM;

extern(Windows) @nogc nothrow:


// Callbacks

alias FNCALLBACK = ptrdiff_t function(uint wType, uint wFmt, ptrdiff_t hConv, ptrdiff_t hsz1, ptrdiff_t hsz2, 
                                      ptrdiff_t hData, size_t dwData1, size_t dwData2);
///An application-defined callback function used with the Dynamic Data Exchange Management Library (DDEML) functions. It
///processes Dynamic Data Exchange (DDE) transactions. The <b>PFNCALLBACK</b> type defines a pointer to this callback
///function. <i>DdeCallback</i> is a placeholder for the application-defined function name.
///Params:
///    wType = Type: <b>UINT</b> The type of the current transaction. This parameter consists of a combination of transaction
///            class flags and transaction type flags. The following table describes each of the transaction classes and
///            provides a list of the transaction types in each class. For information about a specific transaction type, see
///            the individual description of that type in **Remarks**.
///    wFmt = Type: <b>UINT</b> The format in which data is sent or received.
///    hConv = Type: <b>HCONV</b> A handle to the conversation associated with the current transaction.
///    hsz1 = Type: <b>HSZ</b> A handle to a string. The meaning of this parameter depends on the type of the current
///           transaction. For the meaning of this parameter, see the description of the transaction type in **Remarks**.
///    hsz2 = Type: <b>HSZ</b> A handle to a string. The meaning of this parameter depends on the type of the current
///           transaction. For the meaning of this parameter, see the description of the transaction type in **Remarks**.
///    hData = Type: <b>HDDEDATA</b> A handle to DDE data. The meaning of this parameter depends on the type of the current
///            transaction. For the meaning of this parameter, see the description of the transaction type in **Remarks**.
///    dwData1 = Type: <b>ULONG_PTR</b> Transaction-specific data. For the meaning of this parameter, see the description of the
///              transaction type in **Remarks**.
///    dwData2 = Type: <b>ULONG_PTR</b> Transaction-specific data. For the meaning of this parameter, see the description of the
///              transaction type in **Remarks**.
///Returns:
///    Type: <b>HDDEDATA</b> The return value depends on the transaction class. For more information about the return
///    values, see descriptions of the individual transaction types.
///    
alias PFNCALLBACK = ptrdiff_t function(uint wType, uint wFmt, ptrdiff_t hConv, ptrdiff_t hsz1, ptrdiff_t hsz2, 
                                       ptrdiff_t hData, size_t dwData1, size_t dwData2);

// Structs


///Contains data to be passed to another application by the WM_COPYDATA message.
struct COPYDATASTRUCT
{
    ///Type: <b>ULONG_PTR</b> The type of the data to be passed to the receiving application. The receiving application
    ///defines the valid types.
    size_t dwData;
    ///Type: <b>DWORD</b> The size, in bytes, of the data pointed to by the <b>lpData</b> member.
    uint   cbData;
    ///Type: <b>PVOID</b> The data to be passed to the receiving application. This member can be <b>NULL</b>.
    void*  lpData;
}

///Defines the metafile picture format used for exchanging metafile data through the clipboard.
struct METAFILEPICT
{
    ///Type: <b>LONG</b> The mapping mode in which the picture is drawn.
    int       mm;
    ///Type: <b>LONG</b> The size of the metafile picture for all modes except the <b>MM_ISOTROPIC</b> and
    ///<b>MM_ANISOTROPIC</b> modes. (For more information about these modes, see the <b>yExt</b> member.) The x-extent
    ///specifies the width of the rectangle within which the picture is drawn. The coordinates are in units that
    ///correspond to the mapping mode.
    int       xExt;
    ///Type: <b>LONG</b> The size of the metafile picture for all modes except the <b>MM_ISOTROPIC</b> and
    ///<b>MM_ANISOTROPIC</b> modes. The y-extent specifies the height of the rectangle within which the picture is
    ///drawn. The coordinates are in units that correspond to the mapping mode. For <b>MM_ISOTROPIC</b> and
    ///<b>MM_ANISOTROPIC</b> modes, which can be scaled, the <b>xExt</b> and <b>yExt</b> members contain an optional
    ///suggested size in <b>MM_HIMETRIC</b> units. For <b>MM_ANISOTROPIC</b> pictures, <b>xExt</b> and <b>yExt</b> can
    ///be zero when no suggested size is supplied. For <b>MM_ISOTROPIC</b> pictures, an aspect ratio must be supplied
    ///even when no suggested size is given. (If a suggested size is given, the aspect ratio is implied by the size.) To
    ///give an aspect ratio without implying a suggested size, set <b>xExt</b> and <b>yExt</b> to negative values whose
    ///ratio is the appropriate aspect ratio. The magnitude of the negative <b>xExt</b> and <b>yExt</b> values is
    ///ignored; only the ratio is used.
    int       yExt;
    ///Type: <b>HMETAFILE</b> A handle to a memory metafile.
    HMETAFILE hMF;
}

///Contains status flags that a DDE application passes to its partner as part of the WM_DDE_ACK message. The flags
///provide details about the application's response to the messages WM_DDE_DATA, WM_DDE_POKE, WM_DDE_EXECUTE,
///WM_DDE_ADVISE, WM_DDE_UNADVISE, and WM_DDE_REQUEST.
struct DDEACK
{
    ushort _bitfield3;
}

///Contains flags that specify how a DDE server application should send data to a client application during an advise
///loop. A client passes a handle to a <b>DDEADVISE</b> structure to a server as part of a WM_DDE_ADVISE message.
struct DDEADVISE
{
    ushort _bitfield4;
    ///Type: <b>short</b> The client application's preferred data format. The format must be a standard or registered
    ///clipboard format. The following standard clipboard formats can be used:
    short  cfFormat;
}

///Contains the data, and information about the data, sent as part of a WM_DDE_DATA message.
struct DDEDATA
{
    ushort   _bitfield5;
    ///Type: <b>short</b> The format of the data. The format should be a standard or registered clipboard format. The
    ///following standard clipboard formats can be used:
    short    cfFormat;
    ///Type: <b>BYTE[1]</b> Contains the data. The length and type of data depend on the <b>cfFormat</b> member.
    ubyte[1] Value;
}

///Contains the data, and information about the data, sent as part of a WM_DDE_POKE message.
struct DDEPOKE
{
    ushort   _bitfield6;
    ///Type: <b>short</b> The format of the data. The format should be a standard or registered clipboard format. The
    ///following standard clipboard formats can be used:
    short    cfFormat;
    ///Type: <b>BYTE[1]</b> Contains the data. The length and type of data depend on the value of the <b>cfFormat</b>
    ///member.
    ubyte[1] Value;
}

struct DDELN
{
    ushort _bitfield7;
    short  cfFormat;
}

struct DDEUP
{
    ushort   _bitfield8;
    short    cfFormat;
    ubyte[1] rgb;
}

struct HCONVLIST__
{
    int unused;
}

struct HCONV__
{
    int unused;
}

struct HSZ__
{
    int unused;
}

struct HDDEDATA__
{
    int unused;
}

///Contains a DDE service name and topic name. A DDE server application can use this structure during an
///XTYP_WILDCONNECT transaction to enumerate the service-topic pairs that it supports.
struct HSZPAIR
{
    ///Type: <b>HSZ</b> A handle to the service name.
    ptrdiff_t hszSvc;
    ///Type: <b>HSZ</b> A handle to the topic name.
    ptrdiff_t hszTopic;
}

///Contains information supplied by a Dynamic Data Exchange (DDE) client application. The information is useful for
///specialized or cross-language DDE conversations.
struct CONVCONTEXT
{
    ///Type: <b>UINT</b> The structure's size, in bytes.
    uint cb;
    ///Type: <b>UINT</b> The conversation context flags. Currently, no flags are defined for this member.
    uint wFlags;
    ///Type: <b>UINT</b> The country/region code identifier for topic-name and item-name strings.
    uint wCountryID;
    ///Type: <b>int</b> The code page for topic-name and item-name strings. Non-multilingual clients should set this
    ///member to <b>CP_WINANSI</b>. Unicode clients should set this value to <b>CP_WINUNICODE</b>.
    int  iCodePage;
    ///Type: <b>DWORD</b> The language identifier for topic-name and item-name strings.
    uint dwLangID;
    ///Type: <b>DWORD</b> A private (application-defined) security code.
    uint dwSecurity;
    ///Type: <b>SECURITY_QUALITY_OF_SERVICE</b> The quality of service a DDE client wants from the system during a given
    ///conversation. The quality of service level specified lasts for the duration of the conversation. It cannot be
    ///changed once the conversation is started.
    SECURITY_QUALITY_OF_SERVICE qos;
}

///Contains information about a Dynamic Data Exchange (DDE) conversation.
struct CONVINFO
{
    ///Type: <b>DWORD</b> The structure's size, in bytes.
    uint        cb;
    ///Type: <b>DWORD_PTR</b> Application-defined data.
    size_t      hUser;
    ///Type: <b>HCONV</b> A handle to the partner application in the DDE conversation. This member is zero if the
    ///partner has not registered itself (using the DdeInitialize function) to make DDEML function calls. An application
    ///should not pass this member to any DDEML function except DdeQueryConvInfo.
    ptrdiff_t   hConvPartner;
    ///Type: <b>HSZ</b> A handle to the service name of the partner application.
    ptrdiff_t   hszSvcPartner;
    ///Type: <b>HSZ</b> A handle to the service name of the server application that was requested for connection.
    ptrdiff_t   hszServiceReq;
    ///Type: <b>HSZ</b> A handle to the name of the requested topic.
    ptrdiff_t   hszTopic;
    ///Type: <b>HSZ</b> A handle to the name of the requested item. This member is transaction specific.
    ptrdiff_t   hszItem;
    ///Type: <b>UINT</b> The format of the data being exchanged. This member is transaction specific.
    uint        wFmt;
    ///Type: <b>UINT</b> The type of the current transaction. This member is transaction specific; it can be one of the
    ///following values. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
    ///id="XTYP_ADVDATA"></a><a id="xtyp_advdata"></a><dl> <dt><b>XTYP_ADVDATA</b></dt> <dt>0x4010</dt> </dl> </td> <td
    ///width="60%"> Informs a client that advise data from a server has arrived. </td> </tr> <tr> <td width="40%"><a
    ///id="XTYP_ADVREQ"></a><a id="xtyp_advreq"></a><dl> <dt><b>XTYP_ADVREQ</b></dt> <dt>0x2022</dt> </dl> </td> <td
    ///width="60%"> Requests a server to send updated data to the client during an advise loop. This transaction results
    ///when the server calls DdePostAdvise. </td> </tr> <tr> <td width="40%"><a id="XTYP_ADVSTART"></a><a
    ///id="xtyp_advstart"></a><dl> <dt><b>XTYP_ADVSTART</b></dt> <dt>0x1030</dt> </dl> </td> <td width="60%"> Requests a
    ///server to begin an advise loop with a client. </td> </tr> <tr> <td width="40%"><a id="XTYP_ADVSTOP"></a><a
    ///id="xtyp_advstop"></a><dl> <dt><b>XTYP_ADVSTOP</b></dt> <dt>0x8040</dt> </dl> </td> <td width="60%"> Notifies a
    ///server that an advise loop is stopping. </td> </tr> <tr> <td width="40%"><a id="XTYP_CONNECT"></a><a
    ///id="xtyp_connect"></a><dl> <dt><b>XTYP_CONNECT</b></dt> <dt>0x1062</dt> </dl> </td> <td width="60%"> Requests a
    ///server to establish a conversation with a client. </td> </tr> <tr> <td width="40%"><a
    ///id="XTYP_CONNECT_CONFIRM"></a><a id="xtyp_connect_confirm"></a><dl> <dt><b>XTYP_CONNECT_CONFIRM</b></dt>
    ///<dt>0x8072</dt> </dl> </td> <td width="60%"> Notifies a server that a conversation with a client has been
    ///established. </td> </tr> <tr> <td width="40%"><a id="XTYP_DISCONNECT"></a><a id="xtyp_disconnect"></a><dl>
    ///<dt><b>XTYP_DISCONNECT</b></dt> <dt>0x80C2</dt> </dl> </td> <td width="60%"> Notifies a server that a
    ///conversation has terminated. </td> </tr> <tr> <td width="40%"><a id="XTYP_EXECUTE"></a><a
    ///id="xtyp_execute"></a><dl> <dt><b>XTYP_EXECUTE</b></dt> <dt>0x4050</dt> </dl> </td> <td width="60%"> Requests a
    ///server to execute a command sent by a client. </td> </tr> <tr> <td width="40%"><a id="XTYP_MONITOR"></a><a
    ///id="xtyp_monitor"></a><dl> <dt><b>XTYP_MONITOR</b></dt> <dt>0x80F2</dt> </dl> </td> <td width="60%"> Notifies an
    ///application registered as <b>APPCMD_MONITOR</b> that DDE data is being transmitted. </td> </tr> <tr> <td
    ///width="40%"><a id="XTYP_POKE"></a><a id="xtyp_poke"></a><dl> <dt><b>XTYP_POKE</b></dt> <dt>0x4090</dt> </dl>
    ///</td> <td width="60%"> Requests a server to accept unsolicited data from a client. </td> </tr> <tr> <td
    ///width="40%"><a id="XTYP_REGISTER"></a><a id="xtyp_register"></a><dl> <dt><b>XTYP_REGISTER</b></dt>
    ///<dt>0x80A2</dt> </dl> </td> <td width="60%"> Notifies other DDEML applications that a server has registered a
    ///service name. </td> </tr> <tr> <td width="40%"><a id="XTYP_REQUEST"></a><a id="xtyp_request"></a><dl>
    ///<dt><b>XTYP_REQUEST</b></dt> <dt>0x20B0</dt> </dl> </td> <td width="60%"> Requests a server to send data to a
    ///client. </td> </tr> <tr> <td width="40%"><a id="XTYP_UNREGISTER"></a><a id="xtyp_unregister"></a><dl>
    ///<dt><b>XTYP_UNREGISTER</b></dt> <dt>0x80D2</dt> </dl> </td> <td width="60%"> Notifies other DDEML applications
    ///that a server has unregistered a service name. </td> </tr> <tr> <td width="40%"><a id="XTYP_WILDCONNECT"></a><a
    ///id="xtyp_wildconnect"></a><dl> <dt><b>XTYP_WILDCONNECT</b></dt> <dt>0x20E2</dt> </dl> </td> <td width="60%">
    ///Requests a server to establish multiple conversations with the same client. </td> </tr> <tr> <td width="40%"><a
    ///id="XTYP_XACT_COMPLETE"></a><a id="xtyp_xact_complete"></a><dl> <dt><b>XTYP_XACT_COMPLETE</b></dt>
    ///<dt>0x8080</dt> </dl> </td> <td width="60%"> Notifies a client that an asynchronous data transaction has been
    ///completed. </td> </tr> </table>
    uint        wType;
    ///Type: <b>UINT</b> The status of the current conversation. This member can be one or more of the following values.
    ///<table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="ST_ADVISE"></a><a
    ///id="st_advise"></a><dl> <dt><b>ST_ADVISE</b></dt> <dt>0x0002</dt> </dl> </td> <td width="60%"> One or more links
    ///are in progress. </td> </tr> <tr> <td width="40%"><a id="ST_BLOCKED"></a><a id="st_blocked"></a><dl>
    ///<dt><b>ST_BLOCKED</b></dt> <dt>0x0008</dt> </dl> </td> <td width="60%"> The conversation is blocked. </td> </tr>
    ///<tr> <td width="40%"><a id="ST_BLOCKNEXT"></a><a id="st_blocknext"></a><dl> <dt><b>ST_BLOCKNEXT</b></dt>
    ///<dt>0x0080</dt> </dl> </td> <td width="60%"> The conversation will block after calling the next callback. </td>
    ///</tr> <tr> <td width="40%"><a id="ST_CLIENT"></a><a id="st_client"></a><dl> <dt><b>ST_CLIENT</b></dt>
    ///<dt>0x0010</dt> </dl> </td> <td width="60%"> The con0x0010versation handle passed to the DdeQueryConvInfo
    ///function is a client-side handle. If the handle is zero, the conversation handle passed to the
    ///<b>DdeQueryConvInfo</b> function is a server-side handle. </td> </tr> <tr> <td width="40%"><a
    ///id="ST_CONNECTED"></a><a id="st_connected"></a><dl> <dt><b>ST_CONNECTED</b></dt> <dt>0x0001</dt> </dl> </td> <td
    ///width="60%"> The conversation is connected. </td> </tr> <tr> <td width="40%"><a id="ST_INLIST"></a><a
    ///id="st_inlist"></a><dl> <dt><b>ST_INLIST</b></dt> <dt>0x0040</dt> </dl> </td> <td width="60%"> The conversation
    ///is a member of a conversation list. </td> </tr> <tr> <td width="40%"><a id="ST_ISLOCAL"></a><a
    ///id="st_islocal"></a><dl> <dt><b>ST_ISLOCAL</b></dt> <dt>0x0004</dt> </dl> </td> <td width="60%"> Both sides of
    ///the conversation are using the DDEML. </td> </tr> <tr> <td width="40%"><a id="ST_ISSELF"></a><a
    ///id="st_isself"></a><dl> <dt><b>ST_ISSELF</b></dt> <dt>0x0100</dt> </dl> </td> <td width="60%"> Both sides of the
    ///conversation are using the same instance of the DDEML. </td> </tr> <tr> <td width="40%"><a
    ///id="ST_TERMINATED"></a><a id="st_terminated"></a><dl> <dt><b>ST_TERMINATED</b></dt> <dt>0x0020</dt> </dl> </td>
    ///<td width="60%"> The conversation has been terminated by the partner. </td> </tr> </table>
    uint        wStatus;
    ///Type: <b>UINT</b> The conversation state. This member can be one of the following values. <table> <tr>
    ///<th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="XST_ADVACKRCVD"></a><a
    ///id="xst_advackrcvd"></a><dl> <dt><b>XST_ADVACKRCVD</b></dt> <dt>13</dt> </dl> </td> <td width="60%"> The advise
    ///transaction has just been completed. </td> </tr> <tr> <td width="40%"><a id="XST_ADVDATAACKRCVD"></a><a
    ///id="xst_advdataackrcvd"></a><dl> <dt><b>XST_ADVDATAACKRCVD</b></dt> <dt>16</dt> </dl> </td> <td width="60%"> The
    ///advise data transaction has just been completed. </td> </tr> <tr> <td width="40%"><a id="XST_ADVDATASENT"></a><a
    ///id="xst_advdatasent"></a><dl> <dt><b>XST_ADVDATASENT</b></dt> <dt>15</dt> </dl> </td> <td width="60%"> Advise
    ///data has been sent and is awaiting an acknowledgement. </td> </tr> <tr> <td width="40%"><a
    ///id="XST_ADVSENT"></a><a id="xst_advsent"></a><dl> <dt><b>XST_ADVSENT</b></dt> <dt>11</dt> </dl> </td> <td
    ///width="60%"> An advise transaction is awaiting an acknowledgement. </td> </tr> <tr> <td width="40%"><a
    ///id="XST_CONNECTED"></a><a id="xst_connected"></a><dl> <dt><b>XST_CONNECTED</b></dt> <dt>2</dt> </dl> </td> <td
    ///width="60%"> The conversation has no active transactions. </td> </tr> <tr> <td width="40%"><a
    ///id="XST_DATARCVD"></a><a id="xst_datarcvd"></a><dl> <dt><b>XST_DATARCVD</b></dt> <dt>6</dt> </dl> </td> <td
    ///width="60%"> The requested data has just been received. </td> </tr> <tr> <td width="40%"><a
    ///id="XST_EXECACKRCVD"></a><a id="xst_execackrcvd"></a><dl> <dt><b>XST_EXECACKRCVD</b></dt> <dt>10</dt> </dl> </td>
    ///<td width="60%"> An execute transaction has just been completed. </td> </tr> <tr> <td width="40%"><a
    ///id="XST_EXECSENT"></a><a id="xst_execsent"></a><dl> <dt><b>XST_EXECSENT</b></dt> <dt>9</dt> </dl> </td> <td
    ///width="60%"> An execute transaction is awaiting an acknowledgement. </td> </tr> <tr> <td width="40%"><a
    ///id="XST_INCOMPLETE"></a><a id="xst_incomplete"></a><dl> <dt><b>XST_INCOMPLETE</b></dt> <dt>1</dt> </dl> </td> <td
    ///width="60%"> The last transaction failed. </td> </tr> <tr> <td width="40%"><a id="XST_INIT1"></a><a
    ///id="xst_init1"></a><dl> <dt><b>XST_INIT1</b></dt> <dt>3</dt> </dl> </td> <td width="60%"> Mid-initiate state 1.
    ///</td> </tr> <tr> <td width="40%"><a id="XST_INIT2"></a><a id="xst_init2"></a><dl> <dt><b>XST_INIT2</b></dt>
    ///<dt>4</dt> </dl> </td> <td width="60%"> Mid-initiate state 2. </td> </tr> <tr> <td width="40%"><a
    ///id="XST_NULL"></a><a id="xst_null"></a><dl> <dt><b>XST_NULL</b></dt> <dt>0</dt> </dl> </td> <td width="60%">
    ///Pre-initiate state. </td> </tr> <tr> <td width="40%"><a id="XST_POKEACKRCVD"></a><a id="xst_pokeackrcvd"></a><dl>
    ///<dt><b>XST_POKEACKRCVD</b></dt> <dt>8</dt> </dl> </td> <td width="60%"> A poke transaction has just been
    ///completed. </td> </tr> <tr> <td width="40%"><a id="XST_POKESENT"></a><a id="xst_pokesent"></a><dl>
    ///<dt><b>XST_POKESENT</b></dt> <dt>7</dt> </dl> </td> <td width="60%"> A poke transaction is awaiting an
    ///acknowledgement. </td> </tr> <tr> <td width="40%"><a id="XST_REQSENT"></a><a id="xst_reqsent"></a><dl>
    ///<dt><b>XST_REQSENT</b></dt> <dt>5</dt> </dl> </td> <td width="60%"> A request transaction is awaiting an
    ///acknowledgement. </td> </tr> <tr> <td width="40%"><a id="XST_UNADVACKRCVD"></a><a id="xst_unadvackrcvd"></a><dl>
    ///<dt><b>XST_UNADVACKRCVD</b></dt> <dt>14</dt> </dl> </td> <td width="60%"> An unadvise transaction has just been
    ///completed. </td> </tr> <tr> <td width="40%"><a id="XST_UNADVSENT"></a><a id="xst_unadvsent"></a><dl>
    ///<dt><b>XST_UNADVSENT</b></dt> <dt>12</dt> </dl> </td> <td width="60%"> An unadvise transaction is awaiting an
    ///acknowledgement. </td> </tr> </table>
    uint        wConvst;
    ///Type: <b>UINT</b> The error value associated with the last transaction.
    uint        wLastError;
    ///Type: <b>HCONVLIST</b> A handle to the conversation list if the handle to the current conversation is in a
    ///conversation list. This member is <b>NULL</b> if the conversation is not in a conversation list.
    ptrdiff_t   hConvList;
    ///Type: <b>CONVCONTEXT</b> The conversation context.
    CONVCONTEXT ConvCtxt;
    ///Type: <b>HWND</b> A handle to the window of the calling application involved in the conversation.
    HWND        hwnd;
    ///Type: <b>HWND</b> A handle to the window of the partner application involved in the current conversation.
    HWND        hwndPartner;
}

///Contains information about a Dynamic Data Exchange (DDE) message, and provides read access to the data referenced by
///the message. This structure is intended to be used by a Dynamic Data Exchange Management Library (DDEML) monitoring
///application.
struct DDEML_MSG_HOOK_DATA
{
    ///Type: <b>UINT_PTR</b> The unpacked low-order word of the <i>lParam</i> parameter associated with the DDE message.
    size_t  uiLo;
    ///Type: <b>UINT_PTR</b> The unpacked high-order word of the <i>lParam</i> parameter associated with the DDE
    ///message.
    size_t  uiHi;
    ///Type: <b>DWORD</b> The amount of data being passed with the message, in bytes. This value can be greater than 32.
    uint    cbData;
    ///Type: <b>DWORD[8]</b> The first 32 bytes of data being passed with the message (<code>8 * sizeof(DWORD)</code>).
    uint[8] Data;
}

///Contains information about a Dynamic Data Exchange (DDE) message. A DDE monitoring application can use this structure
///to obtain information about a DDE message that was sent or posted.
struct MONMSGSTRUCT
{
    ///Type: <b>UINT</b> The structure's size, in bytes.
    uint                cb;
    ///Type: <b>HWND</b> A handle to the window that receives the DDE message.
    HWND                hwndTo;
    ///Type: <b>DWORD</b> The Windows time at which the message was sent or posted. Windows time is the number of
    ///milliseconds that have elapsed since the system was booted.
    uint                dwTime;
    ///Type: <b>HANDLE</b> A handle to the task (application instance) containing the window that receives the DDE
    ///message.
    HANDLE              hTask;
    ///Type: <b>UINT</b> The identifier of the DDE message.
    uint                wMsg;
    ///Type: <b>WPARAM</b> The <b>wParam</b> parameter of the DDE message.
    WPARAM              wParam;
    ///Type: <b>LPARAM</b> The <b>lParam</b> parameter of the DDE message.
    LPARAM              lParam;
    ///Type: <b>DDEML_MSG_HOOK_DATA</b> Additional information about the DDE message.
    DDEML_MSG_HOOK_DATA dmhd;
}

///Contains information about the current Dynamic Data Exchange (DDE) transaction. A DDE debugging application can use
///this structure when monitoring transactions that the system passes to the DDE callback functions of other
///applications.
struct MONCBSTRUCT
{
    ///Type: <b>UINT</b> The structure's size, in bytes.
    uint        cb;
    ///Type: <b>DWORD</b> The Windows time at which the transaction occurred. Windows time is the number of milliseconds
    ///that have elapsed since the system was booted.
    uint        dwTime;
    ///Type: <b>HANDLE</b> A handle to the task (application instance) containing the DDE callback function that
    ///received the transaction.
    HANDLE      hTask;
    ///Type: <b>DWORD</b> The value returned by the DDE callback function that processed the transaction.
    uint        dwRet;
    ///Type: <b>UINT</b> The transaction type.
    uint        wType;
    ///Type: <b>UINT</b> The format of the data exchanged (if any) during the transaction.
    uint        wFmt;
    ///Type: <b>HCONV</b> A handle to the conversation in which the transaction took place.
    ptrdiff_t   hConv;
    ///Type: <b>HSZ</b> A handle to a string.
    ptrdiff_t   hsz1;
    ///Type: <b>HSZ</b> A handle to a string.
    ptrdiff_t   hsz2;
    ///Type: <b>HDDEDATA</b> A handle to the data exchanged (if any) during the transaction.
    ptrdiff_t   hData;
    ///Type: <b>ULONG_PTR</b> Additional data.
    size_t      dwData1;
    ///Type: <b>ULONG_PTR</b> Additional data.
    size_t      dwData2;
    ///Type: <b>CONVCONTEXT</b> The language information used to share data in different languages.
    CONVCONTEXT cc;
    ///Type: <b>DWORD</b> The amount, in bytes, of data being passed with the transaction. This value can be more than
    ///32 bytes.
    uint        cbData;
    ///Type: <b>DWORD[8]</b> Contains the first 32 bytes of data being passed with the transaction (<code>8 *
    ///sizeof(DWORD)</code>).
    uint[8]     Data;
}

///Contains information about a Dynamic Data Exchange (DDE) string handle. A DDE monitoring application can use this
///structure when monitoring the activity of the string manager component of the DDE Management Library.
struct MONHSZSTRUCTA
{
    ///Type: <b>UINT</b> The structure's size, in bytes.
    uint      cb;
    ///Type: <b>BOOL</b> The action being performed on the string identified by the <b>hsz</b> member. <table> <tr>
    ///<th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="MH_CLEANUP"></a><a id="mh_cleanup"></a><dl>
    ///<dt><b>MH_CLEANUP</b></dt> <dt>4</dt> </dl> </td> <td width="60%"> An application is freeing its DDE resources,
    ///causing the system to delete string handles the application had created. (The application called the
    ///DdeUninitialize function.) </td> </tr> <tr> <td width="40%"><a id="MH_CREATE"></a><a id="mh_create"></a><dl>
    ///<dt><b>MH_CREATE</b></dt> <dt>1</dt> </dl> </td> <td width="60%"> An application is creating a string handle.
    ///(The application called the DdeCreateStringHandle function.) </td> </tr> <tr> <td width="40%"><a
    ///id="MH_DELETE"></a><a id="mh_delete"></a><dl> <dt><b>MH_DELETE</b></dt> <dt>3</dt> </dl> </td> <td width="60%">
    ///An application is deleting a string handle. (The application called the DdeFreeStringHandle function.) </td>
    ///</tr> <tr> <td width="40%"><a id="MH_KEEP"></a><a id="mh_keep"></a><dl> <dt><b>MH_KEEP</b></dt> <dt>2</dt> </dl>
    ///</td> <td width="60%"> An application is increasing the usage count of a string handle. (The application called
    ///the DdeKeepStringHandle function.) </td> </tr> </table>
    BOOL      fsAction;
    ///Type: <b>DWORD</b> The Windows time at which the action specified by the <b>fsAction</b> member takes place.
    ///Windows time is the number of milliseconds that have elapsed since the system was booted.
    uint      dwTime;
    ///Type: <b>HSZ</b> A handle to the string. Because string handles are local to the process, this member is a global
    ///atom.
    ptrdiff_t hsz;
    ///Type: <b>HANDLE</b> A handle to the task (application instance) performing the action on the string handle.
    HANDLE    hTask;
    ///Type: <b>TCHAR[1]</b> Pointer to the string identified by the <b>hsz</b> member.
    byte[1]   str;
}

///Contains information about a Dynamic Data Exchange (DDE) string handle. A DDE monitoring application can use this
///structure when monitoring the activity of the string manager component of the DDE Management Library.
struct MONHSZSTRUCTW
{
    ///Type: <b>UINT</b> The structure's size, in bytes.
    uint      cb;
    ///Type: <b>BOOL</b> The action being performed on the string identified by the <b>hsz</b> member. <table> <tr>
    ///<th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="MH_CLEANUP"></a><a id="mh_cleanup"></a><dl>
    ///<dt><b>MH_CLEANUP</b></dt> <dt>4</dt> </dl> </td> <td width="60%"> An application is freeing its DDE resources,
    ///causing the system to delete string handles the application had created. (The application called the
    ///DdeUninitialize function.) </td> </tr> <tr> <td width="40%"><a id="MH_CREATE"></a><a id="mh_create"></a><dl>
    ///<dt><b>MH_CREATE</b></dt> <dt>1</dt> </dl> </td> <td width="60%"> An application is creating a string handle.
    ///(The application called the DdeCreateStringHandle function.) </td> </tr> <tr> <td width="40%"><a
    ///id="MH_DELETE"></a><a id="mh_delete"></a><dl> <dt><b>MH_DELETE</b></dt> <dt>3</dt> </dl> </td> <td width="60%">
    ///An application is deleting a string handle. (The application called the DdeFreeStringHandle function.) </td>
    ///</tr> <tr> <td width="40%"><a id="MH_KEEP"></a><a id="mh_keep"></a><dl> <dt><b>MH_KEEP</b></dt> <dt>2</dt> </dl>
    ///</td> <td width="60%"> An application is increasing the usage count of a string handle. (The application called
    ///the DdeKeepStringHandle function.) </td> </tr> </table>
    BOOL      fsAction;
    ///Type: <b>DWORD</b> The Windows time at which the action specified by the <b>fsAction</b> member takes place.
    ///Windows time is the number of milliseconds that have elapsed since the system was booted.
    uint      dwTime;
    ///Type: <b>HSZ</b> A handle to the string. Because string handles are local to the process, this member is a global
    ///atom.
    ptrdiff_t hsz;
    ///Type: <b>HANDLE</b> A handle to the task (application instance) performing the action on the string handle.
    HANDLE    hTask;
    ///Type: <b>TCHAR[1]</b> Pointer to the string identified by the <b>hsz</b> member.
    ushort[1] str;
}

///Contains information about the current Dynamic Data Exchange (DDE) error. A DDE monitoring application can use this
///structure to monitor errors returned by DDE Management Library functions.
struct MONERRSTRUCT
{
    ///Type: <b>UINT</b> The structure's size, in bytes.
    uint   cb;
    ///Type: <b>UINT</b> The current error.
    uint   wLastError;
    ///Type: <b>DWORD</b> The Windows time at which the error occurred. Windows time is the number of milliseconds that
    ///have elapsed since the system was booted.
    uint   dwTime;
    ///Type: <b>HANDLE</b> A handle to the task (application instance) that called the DDE function that caused the
    ///error.
    HANDLE hTask;
}

///Contains information about a Dynamic Data Exchange (DDE) advise loop. A DDE monitoring application can use this
///structure to obtain information about an advise loop that has started or ended.
struct MONLINKSTRUCT
{
    ///Type: <b>UINT</b> The structure's size, in bytes.
    uint      cb;
    ///Type: <b>DWORD</b> The Windows time at which the advise loop was started or ended. Windows time is the number of
    ///milliseconds that have elapsed since the system was booted.
    uint      dwTime;
    ///Type: <b>HANDLE</b> A handle to a task (application instance) that is a partner in the advise loop.
    HANDLE    hTask;
    ///Type: <b>BOOL</b> Indicates whether an advise loop was successfully established. A value of <b>TRUE</b> indicates
    ///an advise loop was established; <b>FALSE</b> indicates it was not.
    BOOL      fEstablished;
    ///Type: <b>BOOL</b> Indicates whether the XTYPF_NODATA flag is set for the advise loop. A value of <b>TRUE</b>
    ///indicates the flag is set; <b>FALSE</b> indicates it is not.
    BOOL      fNoData;
    ///Type: <b>HSZ</b> A handle to the service name of the server in the advise loop.
    ptrdiff_t hszSvc;
    ///Type: <b>HSZ</b> A handle to the topic name on which the advise loop is established.
    ptrdiff_t hszTopic;
    ///Type: <b>HSZ</b> A handle to the item name that is the subject of the advise loop.
    ptrdiff_t hszItem;
    ///Type: <b>UINT</b> The format of the data exchanged (if any) during the advise loop.
    uint      wFmt;
    ///Type: <b>BOOL</b> Indicates whether the link notification came from the server. A value of <b>TRUE</b> indicates
    ///the notification came from the server; <b>FALSE</b> indicates otherwise.
    BOOL      fServer;
    ///Type: <b>HCONV</b> A handle to the server conversation.
    ptrdiff_t hConvServer;
    ///Type: <b>HCONV</b> A handle to the client conversation.
    ptrdiff_t hConvClient;
}

///Contains information about a Dynamic Data Exchange (DDE) conversation. A DDE monitoring application can use this
///structure to obtain information about a conversation that has been established or has terminated.
struct MONCONVSTRUCT
{
    ///Type: <b>UINT</b> The structure's size, in bytes.
    uint      cb;
    ///Type: <b>BOOL</b> Indicates whether the conversation is currently established. A value of <b>TRUE</b> indicates
    ///the conversation is established; <b>FALSE</b> indicates it is not.
    BOOL      fConnect;
    ///Type: <b>DWORD</b> The Windows time at which the conversation was established or terminated. Windows time is the
    ///number of milliseconds that have elapsed since the system was booted.
    uint      dwTime;
    ///Type: <b>HANDLE</b> A handle to a task (application instance) that is a partner in the conversation.
    HANDLE    hTask;
    ///Type: <b>HSZ</b> A handle to the service name on which the conversation is established.
    ptrdiff_t hszSvc;
    ///Type: <b>HSZ</b> A handle to the topic name on which the conversation is established.
    ptrdiff_t hszTopic;
    ///Type: <b>HCONV</b> A handle to the client conversation.
    ptrdiff_t hConvClient;
    ///Type: <b>HCONV</b> A handle to the server conversation.
    ptrdiff_t hConvServer;
}

// Functions

///Opens the clipboard for examination and prevents other applications from modifying the clipboard content.
///Params:
///    hWndNewOwner = Type: <b>HWND</b> A handle to the window to be associated with the open clipboard. If this parameter is
///                   <b>NULL</b>, the open clipboard is associated with the current task.
///Returns:
///    Type: <b>BOOL</b> If the function succeeds, the return value is nonzero. If the function fails, the return value
///    is zero. To get extended error information, call GetLastError.
///    
@DllImport("USER32")
BOOL OpenClipboard(HWND hWndNewOwner);

///Closes the clipboard.
///Returns:
///    Type: <b>BOOL</b> If the function succeeds, the return value is nonzero. If the function fails, the return value
///    is zero. To get extended error information, call GetLastError.
///    
@DllImport("USER32")
BOOL CloseClipboard();

///Retrieves the clipboard sequence number for the current window station.
///Returns:
///    Type: <b>DWORD</b> The return value is the clipboard sequence number. If you do not have
///    <b>WINSTA_ACCESSCLIPBOARD</b> access to the window station, the function returns zero.
///    
@DllImport("USER32")
uint GetClipboardSequenceNumber();

///Retrieves the window handle of the current owner of the clipboard.
///Returns:
///    Type: <b>HWND</b> If the function succeeds, the return value is the handle to the window that owns the clipboard.
///    If the clipboard is not owned, the return value is <b>NULL</b>. To get extended error information, call
///    GetLastError.
///    
@DllImport("USER32")
HWND GetClipboardOwner();

///Adds the specified window to the chain of clipboard viewers. Clipboard viewer windows receive a WM_DRAWCLIPBOARD
///message whenever the content of the clipboard changes. This function is used for backward compatibility with earlier
///versions of Windows.
///Params:
///    hWndNewViewer = Type: <b>HWND</b> A handle to the window to be added to the clipboard chain.
///Returns:
///    Type: <b>HWND</b> If the function succeeds, the return value identifies the next window in the clipboard viewer
///    chain. If an error occurs or there are no other windows in the clipboard viewer chain, the return value is NULL.
///    To get extended error information, call GetLastError.
///    
@DllImport("USER32")
HWND SetClipboardViewer(HWND hWndNewViewer);

///Retrieves the handle to the first window in the clipboard viewer chain.
///Returns:
///    Type: <b>HWND</b> If the function succeeds, the return value is the handle to the first window in the clipboard
///    viewer chain. If there is no clipboard viewer, the return value is <b>NULL</b>. To get extended error
///    information, call GetLastError.
///    
@DllImport("USER32")
HWND GetClipboardViewer();

///Removes a specified window from the chain of clipboard viewers.
///Params:
///    hWndRemove = Type: <b>HWND</b> A handle to the window to be removed from the chain. The handle must have been passed to the
///                 SetClipboardViewer function.
///    hWndNewNext = Type: <b>HWND</b> A handle to the window that follows the <i>hWndRemove</i> window in the clipboard viewer chain.
///                  (This is the handle returned by SetClipboardViewer, unless the sequence was changed in response to a
///                  WM_CHANGECBCHAIN message.)
///Returns:
///    Type: <b>BOOL</b> The return value indicates the result of passing the WM_CHANGECBCHAIN message to the windows in
///    the clipboard viewer chain. Because a window in the chain typically returns <b>FALSE</b> when it processes
///    <b>WM_CHANGECBCHAIN</b>, the return value from <b>ChangeClipboardChain</b> is typically <b>FALSE</b>. If there is
///    only one window in the chain, the return value is typically <b>TRUE</b>.
///    
@DllImport("USER32")
BOOL ChangeClipboardChain(HWND hWndRemove, HWND hWndNewNext);

///Places data on the clipboard in a specified clipboard format. The window must be the current clipboard owner, and the
///application must have called the [**OpenClipboard**](nf-winuser-openclipboard.md) function. (When responding to the
///[WM_RENDERFORMAT](/windows/win32/dataxchg/wm-renderformat) message, the clipboard owner must not call
///**OpenClipboard** before calling **SetClipboardData**.)
///Params:
///    uFormat = Type: <b>UINT</b> The clipboard format. This parameter can be a registered format or any of the standard
///              clipboard formats. For more information, see Standard Clipboard Formats and Registered Clipboard Formats.
///    hMem = Type: <b>HANDLE</b> A handle to the data in the specified format. This parameter can be <b>NULL</b>, indicating
///           that the window provides data in the specified clipboard format (renders the format) upon request; this is known
///           as [delayed rendering](/windows/win32/dataxchg/clipboard-operations
///Returns:
///    Type: <b>HANDLE</b> If the function succeeds, the return value is the handle to the data. If the function fails,
///    the return value is <b>NULL</b>. To get extended error information, call GetLastError.
///    
@DllImport("USER32")
HANDLE SetClipboardData(uint uFormat, HANDLE hMem);

///Retrieves data from the clipboard in a specified format. The clipboard must have been opened previously.
///Params:
///    uFormat = Type: <b>UINT</b> A clipboard format. For a description of the standard clipboard formats, see Standard Clipboard
///              Formats.
///Returns:
///    Type: <b>HANDLE</b> If the function succeeds, the return value is the handle to a clipboard object in the
///    specified format. If the function fails, the return value is <b>NULL</b>. To get extended error information, call
///    GetLastError.
///    
@DllImport("USER32")
HANDLE GetClipboardData(uint uFormat);

///Registers a new clipboard format. This format can then be used as a valid clipboard format.
///Params:
///    lpszFormat = Type: <b>LPCTSTR</b> The name of the new format.
///Returns:
///    Type: <b>UINT</b> If the function succeeds, the return value identifies the registered clipboard format. If the
///    function fails, the return value is zero. To get extended error information, call GetLastError.
///    
@DllImport("USER32")
uint RegisterClipboardFormatA(const(PSTR) lpszFormat);

///Registers a new clipboard format. This format can then be used as a valid clipboard format.
///Params:
///    lpszFormat = Type: <b>LPCTSTR</b> The name of the new format.
///Returns:
///    Type: <b>UINT</b> If the function succeeds, the return value identifies the registered clipboard format. If the
///    function fails, the return value is zero. To get extended error information, call GetLastError.
///    
@DllImport("USER32")
uint RegisterClipboardFormatW(const(PWSTR) lpszFormat);

///Retrieves the number of different data formats currently on the clipboard.
///Returns:
///    Type: <b>int</b> If the function succeeds, the return value is the number of different data formats currently on
///    the clipboard. If the function fails, the return value is zero. To get extended error information, call
///    GetLastError.
///    
@DllImport("USER32")
int CountClipboardFormats();

///Enumerates the data formats currently available on the clipboard. Clipboard data formats are stored in an ordered
///list. To perform an enumeration of clipboard data formats, you make a series of calls to the
///<b>EnumClipboardFormats</b> function. For each call, the <i>format</i> parameter specifies an available clipboard
///format, and the function returns the next available clipboard format.
///Params:
///    format = Type: <b>UINT</b> A clipboard format that is known to be available. To start an enumeration of clipboard formats,
///             set <i>format</i> to zero. When <i>format</i> is zero, the function retrieves the first available clipboard
///             format. For subsequent calls during an enumeration, set <i>format</i> to the result of the previous
///             <b>EnumClipboardFormats</b> call.
///Returns:
///    Type: <b>UINT</b> If the function succeeds, the return value is the clipboard format that follows the specified
///    format, namely the next available clipboard format. If the function fails, the return value is zero. To get
///    extended error information, call GetLastError. If the clipboard is not open, the function fails. If there are no
///    more clipboard formats to enumerate, the return value is zero. In this case, the GetLastError function returns
///    the value <b>ERROR_SUCCESS</b>. This lets you distinguish between function failure and the end of enumeration.
///    
@DllImport("USER32")
uint EnumClipboardFormats(uint format);

///Retrieves from the clipboard the name of the specified registered format. The function copies the name to the
///specified buffer.
///Params:
///    format = Type: <b>UINT</b> The type of format to be retrieved. This parameter must not specify any of the predefined
///             clipboard formats.
///    lpszFormatName = Type: <b>LPTSTR</b> The buffer that is to receive the format name.
///    cchMaxCount = Type: <b>int</b> The maximum length, in characters, of the string to be copied to the buffer. If the name exceeds
///                  this limit, it is truncated.
///Returns:
///    Type: <b>int</b> If the function succeeds, the return value is the length, in characters, of the string copied to
///    the buffer. If the function fails, the return value is zero, indicating that the requested format does not exist
///    or is predefined. To get extended error information, call GetLastError.
///    
@DllImport("USER32")
int GetClipboardFormatNameA(uint format, PSTR lpszFormatName, int cchMaxCount);

///Retrieves from the clipboard the name of the specified registered format. The function copies the name to the
///specified buffer.
///Params:
///    format = Type: <b>UINT</b> The type of format to be retrieved. This parameter must not specify any of the predefined
///             clipboard formats.
///    lpszFormatName = Type: <b>LPTSTR</b> The buffer that is to receive the format name.
///    cchMaxCount = Type: <b>int</b> The maximum length, in characters, of the string to be copied to the buffer. If the name exceeds
///                  this limit, it is truncated.
///Returns:
///    Type: <b>int</b> If the function succeeds, the return value is the length, in characters, of the string copied to
///    the buffer. If the function fails, the return value is zero, indicating that the requested format does not exist
///    or is predefined. To get extended error information, call GetLastError.
///    
@DllImport("USER32")
int GetClipboardFormatNameW(uint format, PWSTR lpszFormatName, int cchMaxCount);

///Empties the clipboard and frees handles to data in the clipboard. The function then assigns ownership of the
///clipboard to the window that currently has the clipboard open.
///Returns:
///    Type: <b>BOOL</b> If the function succeeds, the return value is nonzero. If the function fails, the return value
///    is zero. To get extended error information, call GetLastError.
///    
@DllImport("USER32")
BOOL EmptyClipboard();

///Determines whether the clipboard contains data in the specified format.
///Params:
///    format = Type: <b>UINT</b> A standard or registered clipboard format. For a description of the standard clipboard formats,
///             see Standard Clipboard Formats .
///Returns:
///    Type: <b>BOOL</b> If the clipboard format is available, the return value is nonzero. If the clipboard format is
///    not available, the return value is zero. To get extended error information, call GetLastError.
///    
@DllImport("USER32")
BOOL IsClipboardFormatAvailable(uint format);

///Retrieves the first available clipboard format in the specified list.
///Params:
///    paFormatPriorityList = Type: <b>UINT*</b> The clipboard formats, in priority order. For a description of the standard clipboard formats,
///                           see Standard Clipboard Formats .
///    cFormats = Type: <b>int</b> The number of entries in the <i>paFormatPriorityList</i> array. This value must not be greater
///               than the number of entries in the list.
///Returns:
///    Type: <b>int</b> If the function succeeds, the return value is the first clipboard format in the list for which
///    data is available. If the clipboard is empty, the return value is NULL. If the clipboard contains data, but not
///    in any of the specified formats, the return value is –1. To get extended error information, call GetLastError.
///    
@DllImport("USER32")
int GetPriorityClipboardFormat(uint* paFormatPriorityList, int cFormats);

///Retrieves the handle to the window that currently has the clipboard open.
///Returns:
///    Type: <b>HWND</b> If the function succeeds, the return value is the handle to the window that has the clipboard
///    open. If no window has the clipboard open, the return value is <b>NULL</b>. To get extended error information,
///    call GetLastError.
///    
@DllImport("USER32")
HWND GetOpenClipboardWindow();

///Places the given window in the system-maintained clipboard format listener list.
///Params:
///    hwnd = Type: <b>HWND</b> A handle to the window to be placed in the clipboard format listener list.
///Returns:
///    Type: <b>BOOL</b> Returns <b>TRUE</b> if successful, <b>FALSE</b> otherwise. Call GetLastError for additional
///    details.
///    
@DllImport("USER32")
BOOL AddClipboardFormatListener(HWND hwnd);

///Removes the given window from the system-maintained clipboard format listener list.
///Params:
///    hwnd = Type: <b>HWND</b> A handle to the window to remove from the clipboard format listener list.
///Returns:
///    Type: <b>BOOL</b> Returns <b>TRUE</b> if successful, <b>FALSE</b> otherwise. Call GetLastError for additional
///    details.
///    
@DllImport("USER32")
BOOL RemoveClipboardFormatListener(HWND hwnd);

///Retrieves the currently supported clipboard formats.
///Params:
///    lpuiFormats = Type: <b>PUINT</b> An array of clipboard formats. For a description of the standard clipboard formats, see
///                  Standard Clipboard Formats.
///    cFormats = Type: <b>UINT</b> The number of entries in the array pointed to by <i>lpuiFormats</i>.
///    pcFormatsOut = Type: <b>PUINT</b> The actual number of clipboard formats in the array pointed to by <i>lpuiFormats</i>.
@DllImport("USER32")
BOOL GetUpdatedClipboardFormats(uint* lpuiFormats, uint cFormats, uint* pcFormatsOut);

///Decrements the reference count of a global string atom. If the atom's reference count reaches zero,
///<b>GlobalDeleteAtom</b> removes the string associated with the atom from the global atom table.
///Params:
///    nAtom = Type: <b>ATOM</b> The atom and character string to be deleted.
///Returns:
///    Type: <b>ATOM</b> The function always returns (<b>ATOM</b>) 0. To determine whether the function has failed, call
///    SetLastError with <b>ERROR_SUCCESS</b> before calling <b>GlobalDeleteAtom</b>, then call GetLastError. If the
///    last error code is still <b>ERROR_SUCCESS</b>, <b>GlobalDeleteAtom</b> has succeeded.
///    
@DllImport("KERNEL32")
ushort GlobalDeleteAtom(ushort nAtom);

///Initializes the local atom table and sets the number of hash buckets to the specified size.
///Params:
///    nSize = Type: <b>DWORD</b> The number of hash buckets to use for the atom table. If this parameter is zero, the default
///            number of hash buckets are created. To achieve better performance, specify a prime number in <i>nSize</i>.
///Returns:
///    Type: <b>BOOL</b> If the function succeeds, the return value is nonzero. If the function fails, the return value
///    is zero.
///    
@DllImport("KERNEL32")
BOOL InitAtomTable(uint nSize);

///Decrements the reference count of a local string atom. If the atom's reference count is reduced to zero,
///<b>DeleteAtom</b> removes the string associated with the atom from the local atom table.
///Params:
///    nAtom = Type: <b>ATOM</b> The atom to be deleted.
///Returns:
///    Type: <b>ATOM</b> If the function succeeds, the return value is zero. If the function fails, the return value is
///    the <i>nAtom</i> parameter. To get extended error information, call GetLastError.
///    
@DllImport("KERNEL32")
ushort DeleteAtom(ushort nAtom);

///Adds a character string to the global atom table and returns a unique value (an atom) identifying the string.
///Params:
///    lpString = Type: <b>LPCTSTR</b> The null-terminated string to be added. The string can have a maximum size of 255 bytes.
///               Strings that differ only in case are considered identical. The case of the first string of this name added to the
///               table is preserved and returned by the GlobalGetAtomName function. Alternatively, you can use an integer atom
///               that has been converted using the MAKEINTATOM macro. See the Remarks for more information.
///Returns:
///    Type: <b>ATOM</b> If the function succeeds, the return value is the newly created atom. If the function fails,
///    the return value is zero. To get extended error information, call GetLastError.
///    
@DllImport("KERNEL32")
ushort GlobalAddAtomA(const(PSTR) lpString);

///Adds a character string to the global atom table and returns a unique value (an atom) identifying the string.
///Params:
///    lpString = Type: <b>LPCTSTR</b> The null-terminated string to be added. The string can have a maximum size of 255 bytes.
///               Strings that differ only in case are considered identical. The case of the first string of this name added to the
///               table is preserved and returned by the GlobalGetAtomName function. Alternatively, you can use an integer atom
///               that has been converted using the MAKEINTATOM macro. See the Remarks for more information.
///Returns:
///    Type: <b>ATOM</b> If the function succeeds, the return value is the newly created atom. If the function fails,
///    the return value is zero. To get extended error information, call GetLastError.
///    
@DllImport("KERNEL32")
ushort GlobalAddAtomW(const(PWSTR) lpString);

///Adds a character string to the global atom table and returns a unique value (an atom) identifying the string.
///Params:
///    lpString = The null-terminated string to be added. The string can have a maximum size of 255 bytes. Strings that differ only
///               in case are considered identical. The case of the first string of this name added to the table is preserved and
///               returned by the GlobalGetAtomName function. Alternatively, you can use an integer atom that has been converted
///               using the MAKEINTATOM macro. See the Remarks for more information.
///    Flags = 
///Returns:
///    If the function succeeds, the return value is the newly created atom. If the function fails, the return value is
///    zero. To get extended error information, call GetLastError.
///    
@DllImport("KERNEL32")
ushort GlobalAddAtomExA(const(PSTR) lpString, uint Flags);

///Adds a character string to the global atom table and returns a unique value (an atom) identifying the string.
///Params:
///    lpString = The null-terminated string to be added. The string can have a maximum size of 255 bytes. Strings that differ only
///               in case are considered identical. The case of the first string of this name added to the table is preserved and
///               returned by the GlobalGetAtomName function. Alternatively, you can use an integer atom that has been converted
///               using the MAKEINTATOM macro. See the Remarks for more information.
///    Flags = 
///Returns:
///    If the function succeeds, the return value is the newly created atom. If the function fails, the return value is
///    zero. To get extended error information, call GetLastError.
///    
@DllImport("KERNEL32")
ushort GlobalAddAtomExW(const(PWSTR) lpString, uint Flags);

///Searches the global atom table for the specified character string and retrieves the global atom associated with that
///string.
///Params:
///    lpString = Type: <b>LPCTSTR</b> The null-terminated character string for which to search. Alternatively, you can use an
///               integer atom that has been converted using the MAKEINTATOM macro. See the Remarks for more information.
///Returns:
///    Type: <b>ATOM</b> If the function succeeds, the return value is the global atom associated with the given string.
///    If the function fails, the return value is zero. To get extended error information, call GetLastError.
///    
@DllImport("KERNEL32")
ushort GlobalFindAtomA(const(PSTR) lpString);

///Searches the global atom table for the specified character string and retrieves the global atom associated with that
///string.
///Params:
///    lpString = Type: <b>LPCTSTR</b> The null-terminated character string for which to search. Alternatively, you can use an
///               integer atom that has been converted using the MAKEINTATOM macro. See the Remarks for more information.
///Returns:
///    Type: <b>ATOM</b> If the function succeeds, the return value is the global atom associated with the given string.
///    If the function fails, the return value is zero. To get extended error information, call GetLastError.
///    
@DllImport("KERNEL32")
ushort GlobalFindAtomW(const(PWSTR) lpString);

///Retrieves a copy of the character string associated with the specified global atom.
///Params:
///    nAtom = Type: <b>ATOM</b> The global atom associated with the character string to be retrieved.
///    lpBuffer = Type: <b>LPTSTR</b> The buffer for the character string.
///    nSize = Type: <b>int</b> The size, in characters, of the buffer.
///Returns:
///    Type: <b>UINT</b> If the function succeeds, the return value is the length of the string copied to the buffer, in
///    characters, not including the terminating null character. If the function fails, the return value is zero. To get
///    extended error information, call GetLastError.
///    
@DllImport("KERNEL32")
uint GlobalGetAtomNameA(ushort nAtom, PSTR lpBuffer, int nSize);

///Retrieves a copy of the character string associated with the specified global atom.
///Params:
///    nAtom = Type: <b>ATOM</b> The global atom associated with the character string to be retrieved.
///    lpBuffer = Type: <b>LPTSTR</b> The buffer for the character string.
///    nSize = Type: <b>int</b> The size, in characters, of the buffer.
///Returns:
///    Type: <b>UINT</b> If the function succeeds, the return value is the length of the string copied to the buffer, in
///    characters, not including the terminating null character. If the function fails, the return value is zero. To get
///    extended error information, call GetLastError.
///    
@DllImport("KERNEL32")
uint GlobalGetAtomNameW(ushort nAtom, PWSTR lpBuffer, int nSize);

///Adds a character string to the local atom table and returns a unique value (an atom) identifying the string.
///Params:
///    lpString = Type: <b>LPCTSTR</b> The null-terminated string to be added. The string can have a maximum size of 255 bytes.
///               Strings differing only in case are considered identical. The case of the first string added is preserved and
///               returned by the GetAtomName function. Alternatively, you can use an integer atom that has been converted using
///               the MAKEINTATOM macro. See the Remarks for more information.
///Returns:
///    Type: <b>ATOM</b> If the function succeeds, the return value is the newly created atom. If the function fails,
///    the return value is zero. To get extended error information, call GetLastError.
///    
@DllImport("KERNEL32")
ushort AddAtomA(const(PSTR) lpString);

///Adds a character string to the local atom table and returns a unique value (an atom) identifying the string.
///Params:
///    lpString = Type: <b>LPCTSTR</b> The null-terminated string to be added. The string can have a maximum size of 255 bytes.
///               Strings differing only in case are considered identical. The case of the first string added is preserved and
///               returned by the GetAtomName function. Alternatively, you can use an integer atom that has been converted using
///               the MAKEINTATOM macro. See the Remarks for more information.
///Returns:
///    Type: <b>ATOM</b> If the function succeeds, the return value is the newly created atom. If the function fails,
///    the return value is zero. To get extended error information, call GetLastError.
///    
@DllImport("KERNEL32")
ushort AddAtomW(const(PWSTR) lpString);

///Searches the local atom table for the specified character string and retrieves the atom associated with that string.
///Params:
///    lpString = Type: <b>LPCTSTR</b> The character string for which to search. Alternatively, you can use an integer atom that
///               has been converted using the MAKEINTATOM macro. See Remarks for more information.
///Returns:
///    Type: <b>ATOM</b> If the function succeeds, the return value is the atom associated with the given string. If the
///    function fails, the return value is zero. To get extended error information, call GetLastError.
///    
@DllImport("KERNEL32")
ushort FindAtomA(const(PSTR) lpString);

///Searches the local atom table for the specified character string and retrieves the atom associated with that string.
///Params:
///    lpString = Type: <b>LPCTSTR</b> The character string for which to search. Alternatively, you can use an integer atom that
///               has been converted using the MAKEINTATOM macro. See Remarks for more information.
///Returns:
///    Type: <b>ATOM</b> If the function succeeds, the return value is the atom associated with the given string. If the
///    function fails, the return value is zero. To get extended error information, call GetLastError.
///    
@DllImport("KERNEL32")
ushort FindAtomW(const(PWSTR) lpString);

///Retrieves a copy of the character string associated with the specified local atom.
///Params:
///    nAtom = Type: <b>ATOM</b> The local atom that identifies the character string to be retrieved.
///    lpBuffer = Type: <b>LPTSTR</b> The character string.
///    nSize = Type: <b>int</b> The size, in characters, of the buffer.
///Returns:
///    Type: <b>UINT</b> If the function succeeds, the return value is the length of the string copied to the buffer, in
///    characters, not including the terminating null character. If the function fails, the return value is zero. To get
///    extended error information, call GetLastError.
///    
@DllImport("KERNEL32")
uint GetAtomNameA(ushort nAtom, PSTR lpBuffer, int nSize);

///Retrieves a copy of the character string associated with the specified local atom.
///Params:
///    nAtom = Type: <b>ATOM</b> The local atom that identifies the character string to be retrieved.
///    lpBuffer = Type: <b>LPTSTR</b> The character string.
///    nSize = Type: <b>int</b> The size, in characters, of the buffer.
///Returns:
///    Type: <b>UINT</b> If the function succeeds, the return value is the length of the string copied to the buffer, in
///    characters, not including the terminating null character. If the function fails, the return value is zero. To get
///    extended error information, call GetLastError.
///    
@DllImport("KERNEL32")
uint GetAtomNameW(ushort nAtom, PWSTR lpBuffer, int nSize);

///Specifies the quality of service (QOS) a raw Dynamic Data Exchange (DDE) application desires for future DDE
///conversations it initiates. The specified QOS applies to any conversations started while those settings are in place.
///A DDE conversation's quality of service lasts for the duration of the conversation; calls to the
///<b>DdeSetQualityOfService</b> function during a conversation do not affect that conversation's QOS.
///Params:
///    hwndClient = Type: <b>HWND</b> A handle to the DDE client window that specifies the source of WM_DDE_INITIATE messages a
///                 client will send to start DDE conversations.
///    pqosNew = Type: <b>const SECURITY_QUALITY_OF_SERVICE*</b> A pointer to a SECURITY_QUALITY_OF_SERVICE structure for the
///              desired quality of service values.
///    pqosPrev = Type: <b>PSECURITY_QUALITY_OF_SERVICE</b> A pointer to a SECURITY_QUALITY_OF_SERVICE structure that receives the
///               previous quality of service values associated with the window identified by <i>hwndClient</i>. This parameter is
///               optional. If an application has no interest in <i>hwndClient</i>'s previous QOS values, it should set
///               <i>pqosPrev</i> to <b>NULL</b>.
///Returns:
///    Type: <b>BOOL</b> If the function succeeds, the return value is nonzero. If the function fails, the return value
///    is zero. To get extended error information, call GetLastError.
///    
@DllImport("USER32")
BOOL DdeSetQualityOfService(HWND hwndClient, const(SECURITY_QUALITY_OF_SERVICE)* pqosNew, 
                            SECURITY_QUALITY_OF_SERVICE* pqosPrev);

///Enables a Dynamic Data Exchange (DDE) server application to impersonate a DDE client application's security context.
///This protects secure server data from unauthorized DDE clients.
///Params:
///    hWndClient = Type: <b>HWND</b> A handle to the DDE client window to be impersonated. The client window must have established a
///                 DDE conversation with the server window identified by the <i>hWndServer</i> parameter.
///    hWndServer = Type: <b>HWND</b> A handle to the DDE server window. An application must create the server window before calling
///                 this function.
///Returns:
///    Type: <b>BOOL</b> If the function succeeds, the return value is nonzero. If the function fails, the return value
///    is zero. To get extended error information, call GetLastError.
///    
@DllImport("USER32")
BOOL ImpersonateDdeClientWindow(HWND hWndClient, HWND hWndServer);

///Packs a Dynamic Data Exchange (DDE) <i>lParam</i> value into an internal structure used for sharing DDE data between
///processes.
///Params:
///    msg = Type: <b>UINT</b> The DDE message to be posted.
///    uiLo = Type: <b>UINT_PTR</b> A value that corresponds to the 16-bit Windows low-order word of an <i>lParam</i> parameter
///           for the DDE message being posted.
///    uiHi = Type: <b>UINT_PTR</b> A value that corresponds to the 16-bit Windows high-order word of an <i>lParam</i>
///           parameter for the DDE message being posted.
///Returns:
///    Type: <b>LPARAM</b> The return value is the <i>lParam</i> value.
///    
@DllImport("USER32")
LPARAM PackDDElParam(uint msg, size_t uiLo, size_t uiHi);

///Unpacks a Dynamic Data Exchange (DDE)<i>lParam</i> value received from a posted DDE message.
///Params:
///    msg = Type: <b>UINT</b> The posted DDE message.
///    lParam = Type: <b>LPARAM</b> The <i>lParam</i> parameter of the posted DDE message that was received. The application must
///             free the memory object specified by the <i>lParam</i> parameter by calling the FreeDDElParam function.
///    puiLo = Type: <b>PUINT_PTR</b> A pointer to a variable that receives the low-order word of <i>lParam</i>.
///    puiHi = Type: <b>PUINT_PTR</b> A pointer to a variable that receives the high-order word of <i>lParam</i>.
///Returns:
///    Type: <b>BOOL</b> If the function succeeds, the return value is nonzero. If the function fails, the return value
///    is zero.
///    
@DllImport("USER32")
BOOL UnpackDDElParam(uint msg, LPARAM lParam, uint* puiLo, uint* puiHi);

///Frees the memory specified by the <i>lParam</i> parameter of a posted Dynamic Data Exchange (DDE) message. An
///application receiving a posted DDE message should call this function after it has used the UnpackDDElParam function
///to unpack the <i>lParam</i> value.
///Params:
///    msg = Type: <b>UINT</b> The posted DDE message.
///    lParam = Type: <b>LPARAM</b> The <i>lParam</i> parameter of the posted DDE message.
///Returns:
///    Type: <b>BOOL</b> If the function succeeds, the return value is nonzero. If the function fails, the return value
///    is zero.
///    
@DllImport("USER32")
BOOL FreeDDElParam(uint msg, LPARAM lParam);

///Enables an application to reuse a packed Dynamic Data Exchange (DDE) <i>lParam</i> parameter, rather than allocating
///a new packed <i>lParam</i>. Using this function reduces reallocations for applications that pass packed DDE messages.
///Params:
///    lParam = Type: <b>LPARAM</b> The <i>lParam</i> parameter of the posted DDE message being reused.
///    msgIn = Type: <b>UINT</b> The identifier of the received DDE message.
///    msgOut = Type: <b>UINT</b> The identifier of the DDE message to be posted. The DDE message will reuse the packed
///             <i>lParam</i> parameter.
///    uiLo = Type: <b>UINT_PTR</b> The value to be packed into the low-order word of the reused <i>lParam</i> parameter.
///    uiHi = Type: <b>UINT_PTR</b> The value to be packed into the high-order word of the reused <i>lParam</i> parameter.
///Returns:
///    Type: <b>LPARAM</b> The return value is the new <i>lParam</i> value.
///    
@DllImport("USER32")
LPARAM ReuseDDElParam(LPARAM lParam, uint msgIn, uint msgOut, size_t uiLo, size_t uiHi);

///Registers an application with the Dynamic Data Exchange Management Library (DDEML). An application must call this
///function before calling any other Dynamic Data Exchange Management Library (DDEML) function.
///Params:
///    pidInst = Type: <b>LPDWORD</b> The application instance identifier. At initialization, this parameter should point to 0. If
///              the function succeeds, this parameter points to the instance identifier for the application. This value should be
///              passed as the <i>idInst</i> parameter in all other DDEML functions that require it. If an application uses
///              multiple instances of the DDEML dynamic-link library (DLL), the application should provide a different callback
///              function for each instance. If <i>pidInst</i> points to a nonzero value, reinitialization of the DDEML is
///              implied. In this case, <i>pidInst</i> must point to a valid application-instance identifier.
///    pfnCallback = Type: <b>PFNCALLBACK</b> A pointer to the application-defined DDE callback function. This function processes DDE
///                  transactions sent by the system. For more information, see the DdeCallback callback function.
///    afCmd = Type: <b>DWORD</b> A set of <b>APPCMD_</b>, <b>CBF_</b>, and <b>MF_</b> flags. The <b>APPCMD_</b> flags provide
///            special instructions to <b>DdeInitialize</b>. The <b>CBF_</b> flags specify filters that prevent specific types
///            of transactions from reaching the callback function. The <b>MF_</b> flags specify the types of DDE activity that
///            a DDE monitoring application monitors. Using these flags enhances the performance of a DDE application by
///            eliminating unnecessary calls to the callback function. This parameter can be one or more of the following
///            values. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="APPCLASS_MONITOR"></a><a
///            id="appclass_monitor"></a><dl> <dt><b>APPCLASS_MONITOR</b></dt> <dt>0x00000001L</dt> </dl> </td> <td width="60%">
///            Makes it possible for the application to monitor DDE activity in the system. This flag is for use by DDE
///            monitoring applications. The application specifies the types of DDE activity to monitor by combining one or more
///            monitor flags with the <b>APPCLASS_MONITOR</b> flag. For details, see the following Remarks section. </td> </tr>
///            <tr> <td width="40%"><a id="APPCLASS_STANDARD"></a><a id="appclass_standard"></a><dl>
///            <dt><b>APPCLASS_STANDARD</b></dt> <dt>0x00000000L</dt> </dl> </td> <td width="60%"> Registers the application as
///            a standard (nonmonitoring) DDEML application. </td> </tr> <tr> <td width="40%"><a id="APPCMD_CLIENTONLY"></a><a
///            id="appcmd_clientonly"></a><dl> <dt><b>APPCMD_CLIENTONLY</b></dt> <dt>0x00000010L</dt> </dl> </td> <td
///            width="60%"> Prevents the application from becoming a server in a DDE conversation. The application can only be a
///            client. This flag reduces consumption of resources by the DDEML. It includes the functionality of the
///            <b>CBF_FAIL_ALLSVRXACTIONS</b> flag. </td> </tr> <tr> <td width="40%"><a id="APPCMD_FILTERINITS"></a><a
///            id="appcmd_filterinits"></a><dl> <dt><b>APPCMD_FILTERINITS</b></dt> <dt>0x00000020L</dt> </dl> </td> <td
///            width="60%"> Prevents the DDEML from sending XTYP_CONNECT and XTYP_WILDCONNECT transactions to the application
///            until the application has created its string handles and registered its service names or has turned off filtering
///            by a subsequent call to the DdeNameService or <b>DdeInitialize</b> function. This flag is always in effect when
///            an application calls <b>DdeInitialize</b> for the first time, regardless of whether the application specifies the
///            flag. On subsequent calls to <b>DdeInitialize</b>, not specifying this flag turns off the application's
///            service-name filters, but specifying it turns on the application's service name filters. </td> </tr> <tr> <td
///            width="40%"><a id="CBF_FAIL_ALLSVRXACTIONS"></a><a id="cbf_fail_allsvrxactions"></a><dl>
///            <dt><b>CBF_FAIL_ALLSVRXACTIONS</b></dt> <dt>0x0003f000</dt> </dl> </td> <td width="60%"> Prevents the callback
///            function from receiving server transactions. The system returns <b>DDE_FNOTPROCESSED</b> to each client that
///            sends a transaction to this application. This flag is equivalent to combining all CBF_FAIL_ flags. </td> </tr>
///            <tr> <td width="40%"><a id="CBF_FAIL_ADVISES"></a><a id="cbf_fail_advises"></a><dl>
///            <dt><b>CBF_FAIL_ADVISES</b></dt> <dt>0x00004000</dt> </dl> </td> <td width="60%"> Prevents the callback function
///            from receiving XTYP_ADVSTART and XTYP_ADVSTOP transactions. The system returns <b>DDE_FNOTPROCESSED</b> to each
///            client that sends an <b>XTYP_ADVSTART</b> or <b>XTYP_ADVSTOP</b> transaction to the server. </td> </tr> <tr> <td
///            width="40%"><a id="CBF_FAIL_CONNECTIONS"></a><a id="cbf_fail_connections"></a><dl>
///            <dt><b>CBF_FAIL_CONNECTIONS</b></dt> <dt>0x00002000</dt> </dl> </td> <td width="60%"> Prevents the callback
///            function from receiving XTYP_CONNECT and XTYP_WILDCONNECT transactions. </td> </tr> <tr> <td width="40%"><a
///            id="CBF_FAIL_EXECUTES"></a><a id="cbf_fail_executes"></a><dl> <dt><b>CBF_FAIL_EXECUTES</b></dt>
///            <dt>0x00008000</dt> </dl> </td> <td width="60%"> Prevents the callback function from receiving XTYP_EXECUTE
///            transactions. The system returns <b>DDE_FNOTPROCESSED</b> to a client that sends an <b>XTYP_EXECUTE</b>
///            transaction to the server. </td> </tr> <tr> <td width="40%"><a id="CBF_FAIL_POKES"></a><a
///            id="cbf_fail_pokes"></a><dl> <dt><b>CBF_FAIL_POKES</b></dt> <dt>0x00010000</dt> </dl> </td> <td width="60%">
///            Prevents the callback function from receiving XTYP_POKE transactions. The system returns <b>DDE_FNOTPROCESSED</b>
///            to a client that sends an <b>XTYP_POKE</b> transaction to the server. </td> </tr> <tr> <td width="40%"><a
///            id="CBF_FAIL_REQUESTS"></a><a id="cbf_fail_requests"></a><dl> <dt><b>CBF_FAIL_REQUESTS</b></dt>
///            <dt>0x00020000</dt> </dl> </td> <td width="60%"> Prevents the callback function from receiving XTYP_REQUEST
///            transactions. The system returns <b>DDE_FNOTPROCESSED</b> to a client that sends an <b>XTYP_REQUEST</b>
///            transaction to the server. </td> </tr> <tr> <td width="40%"><a id="CBF_FAIL_SELFCONNECTIONS"></a><a
///            id="cbf_fail_selfconnections"></a><dl> <dt><b>CBF_FAIL_SELFCONNECTIONS</b></dt> <dt>0x00001000</dt> </dl> </td>
///            <td width="60%"> Prevents the callback function from receiving XTYP_CONNECT transactions from the application's
///            own instance. This flag prevents an application from establishing a DDE conversation with its own instance. An
///            application should use this flag if it needs to communicate with other instances of itself but not with itself.
///            </td> </tr> <tr> <td width="40%"><a id="CBF_SKIP_ALLNOTIFICATIONS"></a><a id="cbf_skip_allnotifications"></a><dl>
///            <dt><b>CBF_SKIP_ALLNOTIFICATIONS</b></dt> <dt>0x003c0000</dt> </dl> </td> <td width="60%"> Prevents the callback
///            function from receiving any notifications. This flag is equivalent to combining all CBF_SKIP_ flags. </td> </tr>
///            <tr> <td width="40%"><a id="CBF_SKIP_CONNECT_CONFIRMS"></a><a id="cbf_skip_connect_confirms"></a><dl>
///            <dt><b>CBF_SKIP_CONNECT_CONFIRMS</b></dt> <dt>0x00040000</dt> </dl> </td> <td width="60%"> Prevents the callback
///            function from receiving XTYP_CONNECT_CONFIRM notifications. </td> </tr> <tr> <td width="40%"><a
///            id="CBF_SKIP_DISCONNECTS"></a><a id="cbf_skip_disconnects"></a><dl> <dt><b>CBF_SKIP_DISCONNECTS</b></dt>
///            <dt>0x00200000</dt> </dl> </td> <td width="60%"> Prevents the callback function from receiving XTYP_DISCONNECT
///            notifications. </td> </tr> <tr> <td width="40%"><a id="CBF_SKIP_REGISTRATIONS"></a><a
///            id="cbf_skip_registrations"></a><dl> <dt><b>CBF_SKIP_REGISTRATIONS</b></dt> <dt>0x00080000</dt> </dl> </td> <td
///            width="60%"> Prevents the callback function from receiving XTYP_REGISTER notifications. </td> </tr> <tr> <td
///            width="40%"><a id="CBF_SKIP_UNREGISTRATIONS"></a><a id="cbf_skip_unregistrations"></a><dl>
///            <dt><b>CBF_SKIP_UNREGISTRATIONS</b></dt> <dt>0x00100000</dt> </dl> </td> <td width="60%"> Prevents the callback
///            function from receiving XTYP_UNREGISTER notifications. </td> </tr> <tr> <td width="40%"><a
///            id="MF_CALLBACKS"></a><a id="mf_callbacks"></a><dl> <dt><b>MF_CALLBACKS</b></dt> <dt>0x08000000</dt> </dl> </td>
///            <td width="60%"> Notifies the callback function whenever a transaction is sent to any DDE callback function in
///            the system. </td> </tr> <tr> <td width="40%"><a id="MF_CONV"></a><a id="mf_conv"></a><dl> <dt><b>MF_CONV</b></dt>
///            <dt>0x40000000</dt> </dl> </td> <td width="60%"> Notifies the callback function whenever a conversation is
///            established or terminated. </td> </tr> <tr> <td width="40%"><a id="MF_ERRORS"></a><a id="mf_errors"></a><dl>
///            <dt><b>MF_ERRORS</b></dt> <dt>0x10000000</dt> </dl> </td> <td width="60%"> Notifies the callback function
///            whenever a DDE error occurs. </td> </tr> <tr> <td width="40%"><a id="MF_HSZ_INFO"></a><a
///            id="mf_hsz_info"></a><dl> <dt><b>MF_HSZ_INFO</b></dt> <dt>0x01000000</dt> </dl> </td> <td width="60%"> Notifies
///            the callback function whenever a DDE application creates, frees, or increments the usage count of a string handle
///            or whenever a string handle is freed as a result of a call to the DdeUninitialize function. </td> </tr> <tr> <td
///            width="40%"><a id="MF_LINKS"></a><a id="mf_links"></a><dl> <dt><b>MF_LINKS</b></dt> <dt>0x20000000</dt> </dl>
///            </td> <td width="60%"> Notifies the callback function whenever an advise loop is started or ended. </td> </tr>
///            <tr> <td width="40%"><a id="MF_POSTMSGS"></a><a id="mf_postmsgs"></a><dl> <dt><b>MF_POSTMSGS</b></dt>
///            <dt>0x04000000</dt> </dl> </td> <td width="60%"> Notifies the callback function whenever the system or an
///            application posts a DDE message. </td> </tr> <tr> <td width="40%"><a id="MF_SENDMSGS"></a><a
///            id="mf_sendmsgs"></a><dl> <dt><b>MF_SENDMSGS</b></dt> <dt>0x02000000</dt> </dl> </td> <td width="60%"> Notifies
///            the callback function whenever the system or an application sends a DDE message. </td> </tr> </table>
///    ulRes = Type: <b>DWORD</b> Reserved; must be set to zero.
///Returns:
///    Type: <b>UINT</b> If the function succeeds, the return value is <b>DMLERR_NO_ERROR</b>. If the function fails,
///    the return value is one of the following values:
///    
@DllImport("USER32")
uint DdeInitializeA(uint* pidInst, PFNCALLBACK pfnCallback, uint afCmd, uint ulRes);

///Registers an application with the Dynamic Data Exchange Management Library (DDEML). An application must call this
///function before calling any other Dynamic Data Exchange Management Library (DDEML) function.
///Params:
///    pidInst = Type: <b>LPDWORD</b> The application instance identifier. At initialization, this parameter should point to 0. If
///              the function succeeds, this parameter points to the instance identifier for the application. This value should be
///              passed as the <i>idInst</i> parameter in all other DDEML functions that require it. If an application uses
///              multiple instances of the DDEML dynamic-link library (DLL), the application should provide a different callback
///              function for each instance. If <i>pidInst</i> points to a nonzero value, reinitialization of the DDEML is
///              implied. In this case, <i>pidInst</i> must point to a valid application-instance identifier.
///    pfnCallback = Type: <b>PFNCALLBACK</b> A pointer to the application-defined DDE callback function. This function processes DDE
///                  transactions sent by the system. For more information, see the DdeCallback callback function.
///    afCmd = Type: <b>DWORD</b> A set of <b>APPCMD_</b>, <b>CBF_</b>, and <b>MF_</b> flags. The <b>APPCMD_</b> flags provide
///            special instructions to <b>DdeInitialize</b>. The <b>CBF_</b> flags specify filters that prevent specific types
///            of transactions from reaching the callback function. The <b>MF_</b> flags specify the types of DDE activity that
///            a DDE monitoring application monitors. Using these flags enhances the performance of a DDE application by
///            eliminating unnecessary calls to the callback function. This parameter can be one or more of the following
///            values. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="APPCLASS_MONITOR"></a><a
///            id="appclass_monitor"></a><dl> <dt><b>APPCLASS_MONITOR</b></dt> <dt>0x00000001L</dt> </dl> </td> <td width="60%">
///            Makes it possible for the application to monitor DDE activity in the system. This flag is for use by DDE
///            monitoring applications. The application specifies the types of DDE activity to monitor by combining one or more
///            monitor flags with the <b>APPCLASS_MONITOR</b> flag. For details, see the following Remarks section. </td> </tr>
///            <tr> <td width="40%"><a id="APPCLASS_STANDARD"></a><a id="appclass_standard"></a><dl>
///            <dt><b>APPCLASS_STANDARD</b></dt> <dt>0x00000000L</dt> </dl> </td> <td width="60%"> Registers the application as
///            a standard (nonmonitoring) DDEML application. </td> </tr> <tr> <td width="40%"><a id="APPCMD_CLIENTONLY"></a><a
///            id="appcmd_clientonly"></a><dl> <dt><b>APPCMD_CLIENTONLY</b></dt> <dt>0x00000010L</dt> </dl> </td> <td
///            width="60%"> Prevents the application from becoming a server in a DDE conversation. The application can only be a
///            client. This flag reduces consumption of resources by the DDEML. It includes the functionality of the
///            <b>CBF_FAIL_ALLSVRXACTIONS</b> flag. </td> </tr> <tr> <td width="40%"><a id="APPCMD_FILTERINITS"></a><a
///            id="appcmd_filterinits"></a><dl> <dt><b>APPCMD_FILTERINITS</b></dt> <dt>0x00000020L</dt> </dl> </td> <td
///            width="60%"> Prevents the DDEML from sending XTYP_CONNECT and XTYP_WILDCONNECT transactions to the application
///            until the application has created its string handles and registered its service names or has turned off filtering
///            by a subsequent call to the DdeNameService or <b>DdeInitialize</b> function. This flag is always in effect when
///            an application calls <b>DdeInitialize</b> for the first time, regardless of whether the application specifies the
///            flag. On subsequent calls to <b>DdeInitialize</b>, not specifying this flag turns off the application's
///            service-name filters, but specifying it turns on the application's service name filters. </td> </tr> <tr> <td
///            width="40%"><a id="CBF_FAIL_ALLSVRXACTIONS"></a><a id="cbf_fail_allsvrxactions"></a><dl>
///            <dt><b>CBF_FAIL_ALLSVRXACTIONS</b></dt> <dt>0x0003f000</dt> </dl> </td> <td width="60%"> Prevents the callback
///            function from receiving server transactions. The system returns <b>DDE_FNOTPROCESSED</b> to each client that
///            sends a transaction to this application. This flag is equivalent to combining all CBF_FAIL_ flags. </td> </tr>
///            <tr> <td width="40%"><a id="CBF_FAIL_ADVISES"></a><a id="cbf_fail_advises"></a><dl>
///            <dt><b>CBF_FAIL_ADVISES</b></dt> <dt>0x00004000</dt> </dl> </td> <td width="60%"> Prevents the callback function
///            from receiving XTYP_ADVSTART and XTYP_ADVSTOP transactions. The system returns <b>DDE_FNOTPROCESSED</b> to each
///            client that sends an <b>XTYP_ADVSTART</b> or <b>XTYP_ADVSTOP</b> transaction to the server. </td> </tr> <tr> <td
///            width="40%"><a id="CBF_FAIL_CONNECTIONS"></a><a id="cbf_fail_connections"></a><dl>
///            <dt><b>CBF_FAIL_CONNECTIONS</b></dt> <dt>0x00002000</dt> </dl> </td> <td width="60%"> Prevents the callback
///            function from receiving XTYP_CONNECT and XTYP_WILDCONNECT transactions. </td> </tr> <tr> <td width="40%"><a
///            id="CBF_FAIL_EXECUTES"></a><a id="cbf_fail_executes"></a><dl> <dt><b>CBF_FAIL_EXECUTES</b></dt>
///            <dt>0x00008000</dt> </dl> </td> <td width="60%"> Prevents the callback function from receiving XTYP_EXECUTE
///            transactions. The system returns <b>DDE_FNOTPROCESSED</b> to a client that sends an <b>XTYP_EXECUTE</b>
///            transaction to the server. </td> </tr> <tr> <td width="40%"><a id="CBF_FAIL_POKES"></a><a
///            id="cbf_fail_pokes"></a><dl> <dt><b>CBF_FAIL_POKES</b></dt> <dt>0x00010000</dt> </dl> </td> <td width="60%">
///            Prevents the callback function from receiving XTYP_POKE transactions. The system returns <b>DDE_FNOTPROCESSED</b>
///            to a client that sends an <b>XTYP_POKE</b> transaction to the server. </td> </tr> <tr> <td width="40%"><a
///            id="CBF_FAIL_REQUESTS"></a><a id="cbf_fail_requests"></a><dl> <dt><b>CBF_FAIL_REQUESTS</b></dt>
///            <dt>0x00020000</dt> </dl> </td> <td width="60%"> Prevents the callback function from receiving XTYP_REQUEST
///            transactions. The system returns <b>DDE_FNOTPROCESSED</b> to a client that sends an <b>XTYP_REQUEST</b>
///            transaction to the server. </td> </tr> <tr> <td width="40%"><a id="CBF_FAIL_SELFCONNECTIONS"></a><a
///            id="cbf_fail_selfconnections"></a><dl> <dt><b>CBF_FAIL_SELFCONNECTIONS</b></dt> <dt>0x00001000</dt> </dl> </td>
///            <td width="60%"> Prevents the callback function from receiving XTYP_CONNECT transactions from the application's
///            own instance. This flag prevents an application from establishing a DDE conversation with its own instance. An
///            application should use this flag if it needs to communicate with other instances of itself but not with itself.
///            </td> </tr> <tr> <td width="40%"><a id="CBF_SKIP_ALLNOTIFICATIONS"></a><a id="cbf_skip_allnotifications"></a><dl>
///            <dt><b>CBF_SKIP_ALLNOTIFICATIONS</b></dt> <dt>0x003c0000</dt> </dl> </td> <td width="60%"> Prevents the callback
///            function from receiving any notifications. This flag is equivalent to combining all CBF_SKIP_ flags. </td> </tr>
///            <tr> <td width="40%"><a id="CBF_SKIP_CONNECT_CONFIRMS"></a><a id="cbf_skip_connect_confirms"></a><dl>
///            <dt><b>CBF_SKIP_CONNECT_CONFIRMS</b></dt> <dt>0x00040000</dt> </dl> </td> <td width="60%"> Prevents the callback
///            function from receiving XTYP_CONNECT_CONFIRM notifications. </td> </tr> <tr> <td width="40%"><a
///            id="CBF_SKIP_DISCONNECTS"></a><a id="cbf_skip_disconnects"></a><dl> <dt><b>CBF_SKIP_DISCONNECTS</b></dt>
///            <dt>0x00200000</dt> </dl> </td> <td width="60%"> Prevents the callback function from receiving XTYP_DISCONNECT
///            notifications. </td> </tr> <tr> <td width="40%"><a id="CBF_SKIP_REGISTRATIONS"></a><a
///            id="cbf_skip_registrations"></a><dl> <dt><b>CBF_SKIP_REGISTRATIONS</b></dt> <dt>0x00080000</dt> </dl> </td> <td
///            width="60%"> Prevents the callback function from receiving XTYP_REGISTER notifications. </td> </tr> <tr> <td
///            width="40%"><a id="CBF_SKIP_UNREGISTRATIONS"></a><a id="cbf_skip_unregistrations"></a><dl>
///            <dt><b>CBF_SKIP_UNREGISTRATIONS</b></dt> <dt>0x00100000</dt> </dl> </td> <td width="60%"> Prevents the callback
///            function from receiving XTYP_UNREGISTER notifications. </td> </tr> <tr> <td width="40%"><a
///            id="MF_CALLBACKS"></a><a id="mf_callbacks"></a><dl> <dt><b>MF_CALLBACKS</b></dt> <dt>0x08000000</dt> </dl> </td>
///            <td width="60%"> Notifies the callback function whenever a transaction is sent to any DDE callback function in
///            the system. </td> </tr> <tr> <td width="40%"><a id="MF_CONV"></a><a id="mf_conv"></a><dl> <dt><b>MF_CONV</b></dt>
///            <dt>0x40000000</dt> </dl> </td> <td width="60%"> Notifies the callback function whenever a conversation is
///            established or terminated. </td> </tr> <tr> <td width="40%"><a id="MF_ERRORS"></a><a id="mf_errors"></a><dl>
///            <dt><b>MF_ERRORS</b></dt> <dt>0x10000000</dt> </dl> </td> <td width="60%"> Notifies the callback function
///            whenever a DDE error occurs. </td> </tr> <tr> <td width="40%"><a id="MF_HSZ_INFO"></a><a
///            id="mf_hsz_info"></a><dl> <dt><b>MF_HSZ_INFO</b></dt> <dt>0x01000000</dt> </dl> </td> <td width="60%"> Notifies
///            the callback function whenever a DDE application creates, frees, or increments the usage count of a string handle
///            or whenever a string handle is freed as a result of a call to the DdeUninitialize function. </td> </tr> <tr> <td
///            width="40%"><a id="MF_LINKS"></a><a id="mf_links"></a><dl> <dt><b>MF_LINKS</b></dt> <dt>0x20000000</dt> </dl>
///            </td> <td width="60%"> Notifies the callback function whenever an advise loop is started or ended. </td> </tr>
///            <tr> <td width="40%"><a id="MF_POSTMSGS"></a><a id="mf_postmsgs"></a><dl> <dt><b>MF_POSTMSGS</b></dt>
///            <dt>0x04000000</dt> </dl> </td> <td width="60%"> Notifies the callback function whenever the system or an
///            application posts a DDE message. </td> </tr> <tr> <td width="40%"><a id="MF_SENDMSGS"></a><a
///            id="mf_sendmsgs"></a><dl> <dt><b>MF_SENDMSGS</b></dt> <dt>0x02000000</dt> </dl> </td> <td width="60%"> Notifies
///            the callback function whenever the system or an application sends a DDE message. </td> </tr> </table>
///    ulRes = Type: <b>DWORD</b> Reserved; must be set to zero.
///Returns:
///    Type: <b>UINT</b> If the function succeeds, the return value is <b>DMLERR_NO_ERROR</b>. If the function fails,
///    the return value is one of the following values:
///    
@DllImport("USER32")
uint DdeInitializeW(uint* pidInst, PFNCALLBACK pfnCallback, uint afCmd, uint ulRes);

///Frees all Dynamic Data Exchange Management Library (DDEML) resources associated with the calling application.
///Params:
///    idInst = Type: <b>DWORD</b> The application instance identifier obtained by a previous call to the DdeInitialize function.
///Returns:
///    Type: <b>BOOL</b> If the function succeeds, the return value is nonzero. If the function fails, the return value
///    is zero.
///    
@DllImport("USER32")
BOOL DdeUninitialize(uint idInst);

///Establishes a conversation with all server applications that support the specified service name and topic name pair.
///An application can also use this function to obtain a list of conversation handles by passing the function an
///existing conversation handle. The Dynamic Data Exchange Management Library removes the handles of any terminated
///conversations from the conversation list. The resulting conversation list contains the handles of all currently
///established conversations that support the specified service name and topic name.
///Params:
///    idInst = Type: <b>DWORD</b> The application instance identifier obtained by a previous call to the DdeInitialize function.
///    hszService = Type: <b>HSZ</b> A handle to the string that specifies the service name of the server application with which a
///                 conversation is to be established. If this parameter is 0L, the system attempts to establish conversations with
///                 all available servers that support the specified topic name.
///    hszTopic = Type: <b>HSZ</b> A handle to the string that specifies the name of the topic on which a conversation is to be
///               established. This handle must have been created by a previous call to the DdeCreateStringHandle function. If this
///               parameter is 0L, the system will attempt to establish conversations on all topics supported by the selected
///               server (or servers).
///    hConvList = Type: <b>HCONVLIST</b> A handle to the conversation list to be enumerated. This parameter should be 0L if a new
///                conversation list is to be established.
///    pCC = Type: <b>PCONVCONTEXT</b> A pointer to the CONVCONTEXT structure that contains conversation-context information.
///          If this parameter is <b>NULL</b>, the server receives the default <b>CONVCONTEXT</b> structure during the
///          XTYP_CONNECT or XTYP_WILDCONNECT transaction.
///Returns:
///    Type: <b>HCONVLIST</b> If the function succeeds, the return value is the handle to a new conversation list. If
///    the function fails, the return value is 0L. The handle to the old conversation list is no longer valid. The
///    DdeGetLastError function can be used to get the error code, which can be one of the following values:
///    
@DllImport("USER32")
ptrdiff_t DdeConnectList(uint idInst, ptrdiff_t hszService, ptrdiff_t hszTopic, ptrdiff_t hConvList, 
                         CONVCONTEXT* pCC);

///Retrieves the next conversation handle in the specified conversation list.
///Params:
///    hConvList = Type: <b>HCONVLIST</b> A handle to the conversation list. This handle must have been created by a previous call
///                to the DdeConnectList function.
///    hConvPrev = Type: <b>HCONV</b> A handle to the conversation handle previously returned by this function. If this parameter is
///                0L, the function returns the first conversation handle in the list.
///Returns:
///    Type: <b>HCONV</b> If the list contains any more conversation handles, the return value is the next conversation
///    handle in the list; otherwise, it is 0L.
///    
@DllImport("USER32")
ptrdiff_t DdeQueryNextServer(ptrdiff_t hConvList, ptrdiff_t hConvPrev);

///Destroys the specified conversation list and terminates all conversations associated with the list.
///Params:
///    hConvList = Type: <b>HCONVLIST</b> A handle to the conversation list. This handle must have been created by a previous call
///                to the DdeConnectList function.
///Returns:
///    Type: <b>BOOL</b> If the function succeeds, the return value is nonzero. If the function fails, the return value
///    is zero. The DdeGetLastError function can be used to get the error code, which can be one of the following
///    values:
///    
@DllImport("USER32")
BOOL DdeDisconnectList(ptrdiff_t hConvList);

///Establishes a conversation with a server application that supports the specified service name and topic name pair. If
///more than one such server exists, the system selects only one.
///Params:
///    idInst = Type: <b>DWORD</b> The application instance identifier obtained by a previous call to the DdeInitialize function.
///    hszService = Type: <b>HSZ</b> A handle to the string that specifies the service name of the server application with which a
///                 conversation is to be established. This handle must have been created by a previous call to the
///                 DdeCreateStringHandle function. If this parameter is 0L, a conversation is established with any available server.
///    hszTopic = Type: <b>HSZ</b> A handle to the string that specifies the name of the topic on which a conversation is to be
///               established. This handle must have been created by a previous call to DdeCreateStringHandle. If this parameter is
///               0L, a conversation on any topic supported by the selected server is established.
///    pCC = Type: <b>PCONVCONTEXT</b> A pointer to the CONVCONTEXT structure that contains conversation context information.
///          If this parameter is <b>NULL</b>, the server receives the default <b>CONVCONTEXT</b> structure during the
///          XTYP_CONNECT or XTYP_WILDCONNECT transaction.
///Returns:
///    Type: <b>HCONV</b> If the function succeeds, the return value is the handle to the established conversation. If
///    the function fails, the return value is 0L. The DdeGetLastError function can be used to get the error code, which
///    can be one of the following values:
///    
@DllImport("USER32")
ptrdiff_t DdeConnect(uint idInst, ptrdiff_t hszService, ptrdiff_t hszTopic, CONVCONTEXT* pCC);

///Terminates a conversation started by either the DdeConnect or DdeConnectList function and invalidates the specified
///conversation handle.
///Params:
///    hConv = Type: <b>HCONV</b> A handle to the active conversation to be terminated.
///Returns:
///    Type: <b>BOOL</b> If the function succeeds, the return value is nonzero. If the function fails, the return value
///    is zero. The DdeGetLastError function can be used to get the error code, which can be one of the following
///    values:
///    
@DllImport("USER32")
BOOL DdeDisconnect(ptrdiff_t hConv);

///Enables a client Dynamic Data Exchange Management Library (DDEML) application to attempt to reestablish a
///conversation with a service that has terminated a conversation with the client. When the conversation is
///reestablished, the Dynamic Data Exchange Management Library (DDEML) attempts to reestablish any preexisting advise
///loops.
///Params:
///    hConv = Type: <b>HCONV</b> A handle to the conversation to be reestablished. A client must have obtained the conversation
///            handle by a previous call to the DdeConnect function or from an XTYP_DISCONNECT transaction.
///Returns:
///    Type: <b>HCONV</b> If the function succeeds, the return value is the handle to the reestablished conversation. If
///    the function fails, the return value is 0L. The DdeGetLastError function can be used to get the error code, which
///    can be one of the following values:
///    
@DllImport("USER32")
ptrdiff_t DdeReconnect(ptrdiff_t hConv);

///Retrieves information about a Dynamic Data Exchange (DDE) transaction and about the conversation in which the
///transaction takes place.
///Params:
///    hConv = Type: <b>HCONV</b> A handle to the conversation.
///    idTransaction = Type: <b>DWORD</b> The transaction. For asynchronous transactions, this parameter should be a transaction
///                    identifier returned by the DdeClientTransaction function. For synchronous transactions, this parameter should be
///                    QID_SYNC.
///    pConvInfo = Type: <b>PCONVINFO</b> A pointer to the CONVINFO structure that receives information about the transaction and
///                conversation. The <i>cb</i> member of the <b>CONVINFO</b> structure must specify the length of the buffer
///                allocated for the structure.
///Returns:
///    Type: <b>UINT</b> If the function succeeds, the return value is the number of bytes copied into the CONVINFO
///    structure. If the function fails, the return value is <b>FALSE</b>. The DdeGetLastError function can be used to
///    get the error code, which can be one of the following values:
///    
@DllImport("USER32")
uint DdeQueryConvInfo(ptrdiff_t hConv, uint idTransaction, CONVINFO* pConvInfo);

///Associates an application-defined value with a conversation handle or a transaction identifier. This is useful for
///simplifying the processing of asynchronous transactions. An application can use the DdeQueryConvInfo function to
///retrieve this value.
///Params:
///    hConv = Type: <b>HCONV</b> A handle to the conversation.
///    id = Type: <b>DWORD</b> The transaction identifier to associate with the value specified by the <i>hUser</i>
///         parameter. An application should set this parameter to QID_SYNC to associate <i>hUser</i> with the conversation
///         identified by the <i>hConv</i> parameter.
///    hUser = Type: <b>DWORD_PTR</b> The value to be associated with the conversation handle.
///Returns:
///    Type: <b>BOOL</b> If the function succeeds, the return value is nonzero. If the function fails, the return value
///    is zero. The DdeGetLastError function can be used to get the error code, which can be one of the following
///    values:
///    
@DllImport("USER32")
BOOL DdeSetUserHandle(ptrdiff_t hConv, uint id, size_t hUser);

///Abandons the specified asynchronous transaction and releases all resources associated with the transaction.
///Params:
///    idInst = Type: <b>DWORD</b> The application instance identifier obtained by a previous call to the DdeInitialize function.
///    hConv = Type: <b>HCONV</b> A handle to the conversation in which the transaction was initiated. If this parameter is 0L,
///            all transactions are abandoned (that is, the <i>idTransaction</i> parameter is ignored).
///    idTransaction = Type: <b>DWORD</b> The identifier of the transaction to be abandoned. If this parameter is 0L, all active
///                    transactions in the specified conversation are abandoned.
///Returns:
///    Type: <b>BOOL</b> If the function succeeds, the return value is nonzero. If the function fails, the return value
///    is zero. The DdeGetLastError function can be used to get the error code, which can be one of the following
///    values:
///    
@DllImport("USER32")
BOOL DdeAbandonTransaction(uint idInst, ptrdiff_t hConv, uint idTransaction);

///Causes the system to send an XTYP_ADVREQ transaction to the calling (server) application's Dynamic Data Exchange
///(DDE) callback function for each client with an active advise loop on the specified topic and item. A server
///application should call this function whenever the data associated with the topic name or item name pair changes.
///Params:
///    idInst = Type: <b>DWORD</b> The application instance identifier obtained by a previous call to the DdeInitialize function.
///    hszTopic = Type: <b>HSZ</b> A handle to a string that specifies the topic name. To send notifications for all topics with
///               active advise loops, an application can set this parameter to 0L.
///    hszItem = Type: <b>HSZ</b> A handle to a string that specifies the item name. To send notifications for all items with
///              active advise loops, an application can set this parameter to 0L.
///Returns:
///    Type: <b>BOOL</b> If the function succeeds, the return value is nonzero. If the function fails, the return value
///    is zero. The DdeGetLastError function can be used to get the error code, which can be one of the following
///    values:
///    
@DllImport("USER32")
BOOL DdePostAdvise(uint idInst, ptrdiff_t hszTopic, ptrdiff_t hszItem);

///Enables or disables transactions for a specific conversation or for all conversations currently established by the
///calling application.
///Params:
///    idInst = Type: <b>DWORD</b> The application-instance identifier obtained by a previous call to the DdeInitialize function.
///    hConv = Type: <b>HCONV</b> A handle to the conversation to enable or disable. If this parameter is <b>NULL</b>, the
///            function affects all conversations.
///    wCmd = Type: <b>UINT</b> The function code. This parameter can be one of the following values. <table> <tr>
///           <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="EC_ENABLEALL"></a><a id="ec_enableall"></a><dl>
///           <dt><b>EC_ENABLEALL</b></dt> <dt>0</dt> </dl> </td> <td width="60%"> Enables all transactions for the specified
///           conversation. </td> </tr> <tr> <td width="40%"><a id="EC_ENABLEONE"></a><a id="ec_enableone"></a><dl>
///           <dt><b>EC_ENABLEONE</b></dt> <dt>0x0080</dt> </dl> </td> <td width="60%"> Enables one transaction for the
///           specified conversation. </td> </tr> <tr> <td width="40%"><a id="EC_DISABLE"></a><a id="ec_disable"></a><dl>
///           <dt><b>EC_DISABLE</b></dt> <dt>0x0008</dt> </dl> </td> <td width="60%"> Disables all blockable transactions for
///           the specified conversation. A server application can disable the following transactions: <ul> <li> XTYP_ADVSTART
///           </li> <li> XTYP_ADVSTOP </li> <li> XTYP_EXECUTE </li> <li> XTYP_POKE </li> <li> XTYP_REQUEST </li> </ul> A client
///           application can disable the following transactions: <ul> <li> XTYP_ADVDATA </li> <li> XTYP_XACT_COMPLETE </li>
///           </ul> </td> </tr> <tr> <td width="40%"><a id="EC_QUERYWAITING"></a><a id="ec_querywaiting"></a><dl>
///           <dt><b>EC_QUERYWAITING</b></dt> <dt>2</dt> </dl> </td> <td width="60%"> Determines whether any transactions are
///           in the queue for the specified conversation. </td> </tr> </table>
///Returns:
///    Type: <b>BOOL</b> If the function succeeds, the return value is nonzero. If the function fails, the return value
///    is zero. If the <i>wCmd</i> parameter is <b>EC_QUERYWAITING</b>, and the application transaction queue contains
///    one or more unprocessed transactions that are not being processed, the return value is <b>TRUE</b>; otherwise, it
///    is <b>FALSE</b>. The DdeGetLastError function can be used to get the error code, which can be one of the
///    following values:
///    
@DllImport("USER32")
BOOL DdeEnableCallback(uint idInst, ptrdiff_t hConv, uint wCmd);

///Impersonates a Dynamic Data Exchange (DDE) client application in a DDE client conversation.
///Params:
///    hConv = Type: <b>HCONV</b> A handle to the DDE client conversation to be impersonated.
///Returns:
///    Type: <b>BOOL</b> If the function succeeds, the return value is nonzero. If the function fails, the return value
///    is zero. To get extended error information, call GetLastError.
///    
@DllImport("USER32")
BOOL DdeImpersonateClient(ptrdiff_t hConv);

///Registers or unregisters the service names a Dynamic Data Exchange (DDE) server supports. This function causes the
///system to send XTYP_REGISTER or XTYP_UNREGISTER transactions to other running Dynamic Data Exchange Management
///Library (DDEML) client applications.
///Params:
///    idInst = Type: <b>DWORD</b> The application instance identifier obtained by a previous call to the DdeInitialize function.
///    hsz1 = Type: <b>HSZ</b> A handle to the string that specifies the service name the server is registering or
///           unregistering. An application that is unregistering all of its service names should set this parameter to 0L.
///    hsz2 = Type: <b>HSZ</b> Reserved; should be set to 0L.
///    afCmd = Type: <b>UINT</b> The service name options. This parameter can be one of the following values. <table> <tr>
///            <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="DNS_REGISTER"></a><a id="dns_register"></a><dl>
///            <dt><b>DNS_REGISTER</b></dt> <dt>0x0001</dt> </dl> </td> <td width="60%"> Registers the error code service name.
///            </td> </tr> <tr> <td width="40%"><a id="DNS_UNREGISTER"></a><a id="dns_unregister"></a><dl>
///            <dt><b>DNS_UNREGISTER</b></dt> <dt>0x0002</dt> </dl> </td> <td width="60%"> Unregisters the error code service
///            name. If the <i>hsz1</i> parameter is 0L, all service names registered by the server will be unregistered. </td>
///            </tr> <tr> <td width="40%"><a id="DNS_FILTERON"></a><a id="dns_filteron"></a><dl> <dt><b>DNS_FILTERON</b></dt>
///            <dt>0x0004</dt> </dl> </td> <td width="60%"> Turns on service name initiation filtering. The filter prevents a
///            server from receiving XTYP_CONNECT transactions for service names it has not registered. This is the default
///            setting for this filter. If a server application does not register any service names, the application cannot
///            receive XTYP_WILDCONNECT transactions. </td> </tr> <tr> <td width="40%"><a id="DNS_FILTEROFF"></a><a
///            id="dns_filteroff"></a><dl> <dt><b>DNS_FILTEROFF</b></dt> <dt>0x0008</dt> </dl> </td> <td width="60%"> Turns off
///            service name initiation filtering. If this flag is specified, the server receives an XTYP_CONNECT transaction
///            whenever another DDE application calls the DdeConnect function, regardless of the service name. </td> </tr>
///            </table>
///Returns:
///    Type: <b>HDDEDATA</b> If the function succeeds, it returns a nonzero value. That value is not a true
///    <b>HDDEDATA</b> value, merely a Boolean indicator of success. The function is typed <b>HDDEDATA</b> to allow for
///    possible future expansion of the function and a more sophisticated return value. If the function fails, the
///    return value is 0L. The DdeGetLastError function can be used to get the error code, which can be one of the
///    following values:
///    
@DllImport("USER32")
ptrdiff_t DdeNameService(uint idInst, ptrdiff_t hsz1, ptrdiff_t hsz2, uint afCmd);

///Begins a data transaction between a client and a server. Only a Dynamic Data Exchange (DDE) client application can
///call this function, and the application can use it only after establishing a conversation with the server.
///Params:
///    pData = Type: <b>LPBYTE</b> The beginning of the data the client must pass to the server. Optionally, an application can
///            specify the data handle (<b>HDDEDATA</b>) to pass to the server and in that case the <i>cbData</i> parameter
///            should be set to -1. This parameter is required only if the <i>wType</i> parameter is XTYP_EXECUTE or XTYP_POKE.
///            Otherwise, this parameter should be <b>NULL</b>. For the optional usage of this parameter, XTYP_POKE transactions
///            where <i>pData</i> is a data handle, the handle must have been created by a previous call to the
///            DdeCreateDataHandle function, employing the same data format specified in the <i>wFmt</i> parameter.
///    cbData = Type: <b>DWORD</b> The length, in bytes, of the data pointed to by the <i>pData</i> parameter, including the
///             terminating <b>NULL</b>, if the data is a string. A value of -1 indicates that <i>pData</i> is a data handle that
///             identifies the data being sent.
///    hConv = Type: <b>HCONV</b> A handle to the conversation in which the transaction is to take place.
///    hszItem = Type: <b>HSZ</b> A handle to the data item for which data is being exchanged during the transaction. This handle
///              must have been created by a previous call to the DdeCreateStringHandle function. This parameter is ignored (and
///              should be set to 0L) if the <i>wType</i> parameter is XTYP_EXECUTE.
///    wFmt = Type: <b>UINT</b> The standard clipboard format in which the data item is being submitted or requested. If the
///           transaction specified by the <i>wType</i> parameter does not pass data or is XTYP_EXECUTE, this parameter should
///           be zero. If the transaction specified by the <i>wType</i> parameter references non-execute DDE data ( XTYP_POKE,
///           XTYP_ADVSTART, XTYP_ADVSTOP, XTYP_REQUEST), the <i>wFmt</i> value must be either a valid predefined (CF_) DDE
///           format or a valid registered clipboard format.
///    wType = Type: <b>UINT</b> The transaction type. This parameter can be one of the following values. <table> <tr>
///            <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="XTYP_ADVSTART"></a><a
///            id="xtyp_advstart"></a><dl> <dt><b>XTYP_ADVSTART</b></dt> <dt>0x1030</dt> </dl> </td> <td width="60%"> Begins an
///            advise loop. Any number of distinct advise loops can exist within a conversation. An application can alter the
///            advise loop type by combining the XTYP_ADVSTART transaction type with one or more of the following flags: <ul>
///            <li><b>XTYPF_NODATA</b>. Instructs the server to notify the client of any data changes without actually sending
///            the data. This flag gives the client the option of ignoring the notification or requesting the changed data from
///            the server.</li> <li><b>XTYPF_ACKREQ</b>. Instructs the server to wait until the client acknowledges that it
///            received the previous data item before sending the next data item. This flag prevents a fast server from sending
///            data faster than the client can process it.</li> </ul> </td> </tr> <tr> <td width="40%"><a
///            id="XTYP_ADVSTOP"></a><a id="xtyp_advstop"></a><dl> <dt><b>XTYP_ADVSTOP</b></dt> <dt>0x8040</dt> </dl> </td> <td
///            width="60%"> Ends an advise loop. </td> </tr> <tr> <td width="40%"><a id="XTYP_EXECUTE"></a><a
///            id="xtyp_execute"></a><dl> <dt><b>XTYP_EXECUTE</b></dt> <dt>0x4050</dt> </dl> </td> <td width="60%"> Begins an
///            execute transaction. </td> </tr> <tr> <td width="40%"><a id="XTYP_POKE"></a><a id="xtyp_poke"></a><dl>
///            <dt><b>XTYP_POKE</b></dt> <dt>0x4090</dt> </dl> </td> <td width="60%"> Begins a poke transaction. </td> </tr>
///            <tr> <td width="40%"><a id="XTYP_REQUEST"></a><a id="xtyp_request"></a><dl> <dt><b>XTYP_REQUEST</b></dt>
///            <dt>0x20B0</dt> </dl> </td> <td width="60%"> Begins a request transaction. </td> </tr> </table>
///    dwTimeout = Type: <b>DWORD</b> The maximum amount of time, in milliseconds, that the client will wait for a response from the
///                server application in a synchronous transaction. This parameter should be <b>TIMEOUT_ASYNC</b> for asynchronous
///                transactions.
///    pdwResult = Type: <b>LPDWORD</b> A pointer to a variable that receives the result of the transaction. An application that
///                does not check the result can use <b>NULL</b> for this value. For synchronous transactions, the low-order word of
///                this variable contains any applicable DDE_ flags resulting from the transaction. This provides support for
///                applications dependent on <b>DDE_APPSTATUS</b> bits. It is, however, recommended that applications no longer use
///                these bits because they may not be supported in future versions of the Dynamic Data Exchange Management Library
///                (DDEML). For asynchronous transactions, this variable is filled with a unique transaction identifier for use with
///                the DdeAbandonTransaction function and the XTYP_XACT_COMPLETE transaction.
///Returns:
///    Type: <b>HDDEDATA</b> If the function succeeds, the return value is a data handle that identifies the data for
///    successful synchronous transactions in which the client expects data from the server. The return value is nonzero
///    for successful asynchronous transactions and for synchronous transactions in which the client does not expect
///    data. The return value is zero for all unsuccessful transactions. The DdeGetLastError function can be used to get
///    the error code, which can be one of the following values:
///    
@DllImport("USER32")
ptrdiff_t DdeClientTransaction(ubyte* pData, uint cbData, ptrdiff_t hConv, ptrdiff_t hszItem, uint wFmt, 
                               uint wType, uint dwTimeout, uint* pdwResult);

///Creates a Dynamic Data Exchange (DDE) object and fills the object with data from the specified buffer. A DDE
///application uses this function during transactions that involve passing data to the partner application.
///Params:
///    idInst = Type: <b>DWORD</b> The application instance identifier obtained by a previous call to the DdeInitialize function.
///    pSrc = Type: <b>LPBYTE</b> The data to be copied to the DDE object. If this parameter is <b>NULL</b>, no data is copied
///           to the object.
///    cb = Type: <b>DWORD</b> The amount of memory, in bytes, to copy from the buffer pointed to by <i>pSrc</i>. (include
///         the terminating NULL, if the data is a string). If this parameter is zero, the <i>pSrc</i> parameter is ignored.
///    cbOff = Type: <b>DWORD</b> An offset, in bytes, from the beginning of the buffer pointed to by the <i>pSrc</i> parameter.
///            The data beginning at this offset is copied from the buffer to the DDE object.
///    hszItem = Type: <b>HSZ</b> A handle to the string that specifies the data item corresponding to the DDE object. This handle
///              must have been created by a previous call to the DdeCreateStringHandle function. If the data handle is to be used
///              in an XTYP_EXECUTE transaction, this parameter must be 0L.
///    wFmt = Type: <b>UINT</b> The standard clipboard format of the data.
///    afCmd = Type: <b>UINT</b> The creation flags. This parameter can be <b>HDATA_APPOWNED</b>, which specifies that the
///            server application calling the <b>DdeCreateDataHandle</b> function owns the data handle this function creates.
///            This flag enables the application to share the data handle with other DDEML applications rather than creating a
///            separate handle to pass to each application. If this flag is specified, the application must eventually free the
///            shared memory object associated with the handle by using the DdeFreeDataHandle function. If this flag is not
///            specified, the handle becomes invalid in the application that created the handle after the data handle is
///            returned by the application's DDE callback function or is used as a parameter in another DDEML function.
///Returns:
///    Type: <b>HDDEDATA</b> If the function succeeds, the return value is a data handle. If the function fails, the
///    return value is 0L. The DdeGetLastError function can be used to get the error code, which can be one of the
///    following values:
///    
@DllImport("USER32")
ptrdiff_t DdeCreateDataHandle(uint idInst, ubyte* pSrc, uint cb, uint cbOff, ptrdiff_t hszItem, uint wFmt, 
                              uint afCmd);

///Adds data to the specified Dynamic Data Exchange (DDE) object. An application can add data starting at any offset
///from the beginning of the object. If new data overlaps data already in the object, the new data overwrites the old
///data in the bytes where the overlap occurs. The contents of locations in the object that have not been written to are
///undefined.
///Params:
///    hData = Type: <b>HDDEDATA</b> A handle to the DDE object that receives additional data.
///    pSrc = Type: <b>LPBYTE</b> The data to be added to the DDE object.
///    cb = Type: <b>DWORD</b> The length, in bytes, of the data to be added to the DDE object, including the terminating
///         <b>NULL</b>, if the data is a string.
///    cbOff = Type: <b>DWORD</b> An offset, in bytes, from the beginning of the DDE object. The additional data is copied to
///            the object beginning at this offset.
///Returns:
///    Type: <b>HDDEDATA</b> If the function succeeds, the return value is a new handle to the DDE object. The new
///    handle is used in all references to the object. If the function fails, the return value is zero. The
///    DdeGetLastError function can be used to get the error code, which can be one of the following values:
///    
@DllImport("USER32")
ptrdiff_t DdeAddData(ptrdiff_t hData, ubyte* pSrc, uint cb, uint cbOff);

///Copies data from the specified Dynamic Data Exchange (DDE) object to the specified local buffer.
///Params:
///    hData = Type: <b>HDDEDATA</b> A handle to the DDE object that contains the data to copy.
///    pDst = Type: <b>LPBYTE</b> A pointer to the buffer that receives the data. If this parameter is <b>NULL</b>, the
///           <b>DdeGetData</b> function returns the amount of data, in bytes, that would be copied to the buffer.
///    cbMax = Type: <b>DWORD</b> The maximum amount of data, in bytes, to copy to the buffer pointed to by the <i>pDst</i>
///            parameter. Typically, this parameter specifies the length of the buffer pointed to by <i>pDst</i>.
///    cbOff = Type: <b>DWORD</b> An offset within the DDE object. Data is copied from the object beginning at this offset.
///Returns:
///    Type: <b>DWORD</b> If the <i>pDst</i> parameter points to a buffer, the return value is the size, in bytes, of
///    the memory object associated with the data handle or the size specified in the <i>cbMax</i> parameter, whichever
///    is lower. If the <i>pDst</i> parameter is <b>NULL</b>, the return value is the size, in bytes, of the memory
///    object associated with the data handle. The DdeGetLastError function can be used to get the error code, which can
///    be one of the following values:
///    
@DllImport("USER32")
uint DdeGetData(ptrdiff_t hData, ubyte* pDst, uint cbMax, uint cbOff);

///Provides access to the data in the specified Dynamic Data Exchange (DDE) object. An application must call the
///DdeUnaccessData function when it has finished accessing the data in the object.
///Params:
///    hData = Type: <b>HDDEDATA</b> A handle to the DDE object to be accessed.
///    pcbDataSize = Type: <b>LPDWORD</b> A pointer to a variable that receives the size, in bytes, of the DDE object identified by
///                  the <i>hData</i> parameter. If this parameter is <b>NULL</b>, no size information is returned.
///Returns:
///    Type: <b>LPBYTE</b> If the function succeeds, the return value is a pointer to the first byte of data in the DDE
///    object. If the function fails, the return value is <b>NULL</b>. The DdeGetLastError function can be used to get
///    the error code, which can be one of the following values:
///    
@DllImport("USER32")
ubyte* DdeAccessData(ptrdiff_t hData, uint* pcbDataSize);

///Unaccesses a Dynamic Data Exchange (DDE) object. An application must call this function after it has finished
///accessing the object.
///Params:
///    hData = Type: <b>HDDEDATA</b> A handle to the DDE object.
///Returns:
///    Type: <b>BOOL</b> If the function succeeds, the return value is nonzero. If the function fails, the return value
///    is zero. The DdeGetLastError function can be used to get the error code, which can be one of the following
///    values:
///    
@DllImport("USER32")
BOOL DdeUnaccessData(ptrdiff_t hData);

///Frees a Dynamic Data Exchange (DDE) object and deletes the data handle associated with the object.
///Params:
///    hData = Type: <b>HDDEDATA</b> A handle to the DDE object to be freed. This handle must have been created by a previous
///            call to the DdeCreateDataHandle function or returned by the DdeClientTransaction function.
///Returns:
///    Type: <b>BOOL</b> If the function succeeds, the return value is nonzero. If the function fails, the return value
///    is zero. The DdeGetLastError function can be used to get the error code, which can be one of the following
///    values:
///    
@DllImport("USER32")
BOOL DdeFreeDataHandle(ptrdiff_t hData);

///Retrieves the most recent error code set by the failure of a Dynamic Data Exchange Management Library (DDEML)
///function and resets the error code to DMLERR_NO_ERROR.
///Params:
///    idInst = Type: <b>DWORD</b> The application instance identifier obtained by a previous call to the DdeInitialize function.
///Returns:
///    Type: <b>UINT</b> If the function succeeds, the return value is the last error code, which can be one of the
///    following values. <table> <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>DMLERR_ADVACKTIMEOUT</b></dt> <dt>0x4000</dt> </dl> </td> <td width="60%"> A request for a synchronous
///    advise transaction has timed out. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>DMLERR_BUSY</b></dt>
///    <dt>0x4001</dt> </dl> </td> <td width="60%"> The response to the transaction caused the <b>DDE_FBUSY</b> flag to
///    be set. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>DMLERR_DATAACKTIMEOUT</b></dt> <dt>0x4002</dt> </dl> </td>
///    <td width="60%"> A request for a synchronous data transaction has timed out. </td> </tr> <tr> <td width="40%">
///    <dl> <dt><b>DMLERR_DLL_NOT_INITIALIZED</b></dt> <dt>0x4003</dt> </dl> </td> <td width="60%"> A DDEML function was
///    called without first calling the DdeInitialize function, or an invalid instance identifier was passed to a DDEML
///    function. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>DMLERR_DLL_USAGE</b></dt> <dt>0x4004</dt> </dl> </td> <td
///    width="60%"> An application initialized as <b>APPCLASS_MONITOR</b> has attempted to perform a DDE transaction, or
///    an application initialized as <b>APPCMD_CLIENTONLY</b> has attempted to perform server transactions. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>DMLERR_EXECACKTIMEOUT</b></dt> <dt>0x4005</dt> </dl> </td> <td width="60%"> A
///    request for a synchronous execute transaction has timed out. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>DMLERR_INVALIDPARAMETER</b></dt> <dt>0x4006</dt> </dl> </td> <td width="60%"> A parameter failed to be
///    validated by the DDEML. Some of the possible causes follow: The application used a data handle initialized with a
///    different item name handle than was required by the transaction. The application used a data handle that was
///    initialized with a different clipboard data format than was required by the transaction. The application used a
///    client-side conversation handle with a server-side function or vice versa. The application used a freed data
///    handle or string handle. More than one instance of the application used the same object. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>DMLERR_LOW_MEMORY</b></dt> <dt>0x4007</dt> </dl> </td> <td width="60%"> A DDEML
///    application has created a prolonged race condition (in which the server application outruns the client), causing
///    large amounts of memory to be consumed. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>DMLERR_MEMORY_ERROR</b></dt> <dt>0x4008</dt> </dl> </td> <td width="60%"> A memory allocation has failed.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>DMLERR_NO_CONV_ESTABLISHED</b></dt> <dt>0x400a</dt> </dl> </td> <td
///    width="60%"> A client's attempt to establish a conversation has failed. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>DMLERR_NOTPROCESSED</b></dt> <dt>0x4009</dt> </dl> </td> <td width="60%"> A transaction has failed. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>DMLERR_POKEACKTIMEOUT</b></dt> <dt>0x400b</dt> </dl> </td> <td
///    width="60%"> A request for a synchronous poke transaction has timed out. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>DMLERR_POSTMSG_FAILED</b></dt> <dt>0x400c</dt> </dl> </td> <td width="60%"> An internal call to the
///    PostMessage function has failed. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>DMLERR_REENTRANCY</b></dt>
///    <dt>0x400d</dt> </dl> </td> <td width="60%"> An application instance with a synchronous transaction already in
///    progress attempted to initiate another synchronous transaction, or the DdeEnableCallback function was called from
///    within a DDEML callback function. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>DMLERR_SERVER_DIED</b></dt>
///    <dt>0x400e</dt> </dl> </td> <td width="60%"> A server-side transaction was attempted on a conversation terminated
///    by the client, or the server terminated before completing a transaction. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>DMLERR_SYS_ERROR</b></dt> <dt>0x400f</dt> </dl> </td> <td width="60%"> An internal error has occurred in
///    the DDEML. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>DMLERR_UNADVACKTIMEOUT</b></dt> <dt>0x4010</dt> </dl>
///    </td> <td width="60%"> A request to end an advise transaction has timed out. </td> </tr> <tr> <td width="40%">
///    <dl> <dt><b>DMLERR_UNFOUND_QUEUE_ID</b></dt> <dt>0x4011</dt> </dl> </td> <td width="60%"> An invalid transaction
///    identifier was passed to a DDEML function. Once the application has returned from an XTYP_XACT_COMPLETE callback,
///    the transaction identifier for that callback function is no longer valid. </td> </tr> </table>
///    
@DllImport("USER32")
uint DdeGetLastError(uint idInst);

///Creates a handle that identifies the specified string. A Dynamic Data Exchange (DDE) client or server application can
///pass the string handle as a parameter to other Dynamic Data Exchange Management Library (DDEML) functions.
///Params:
///    idInst = Type: <b>DWORD</b> The application instance identifier obtained by a previous call to the DdeInitialize function.
///    psz = Type: <b>LPTSTR</b> The null-terminated string for which a handle is to be created. This string can be up to 255
///          characters. The reason for this limit is that DDEML string management functions are implemented using atoms.
///    iCodePage = Type: <b>int</b> The code page to be used to render the string. This value should be either <b>CP_WINANSI</b>
///                (the default code page) or CP_WINUNICODE, depending on whether the ANSI or Unicode version of DdeInitialize was
///                called by the client application.
///Returns:
///    Type: <b>HSZ</b> If the function succeeds, the return value is a string handle. If the function fails, the return
///    value is 0L. The DdeGetLastError function can be used to get the error code, which can be one of the following
///    values:
///    
@DllImport("USER32")
ptrdiff_t DdeCreateStringHandleA(uint idInst, const(PSTR) psz, int iCodePage);

///Creates a handle that identifies the specified string. A Dynamic Data Exchange (DDE) client or server application can
///pass the string handle as a parameter to other Dynamic Data Exchange Management Library (DDEML) functions.
///Params:
///    idInst = Type: <b>DWORD</b> The application instance identifier obtained by a previous call to the DdeInitialize function.
///    psz = Type: <b>LPTSTR</b> The null-terminated string for which a handle is to be created. This string can be up to 255
///          characters. The reason for this limit is that DDEML string management functions are implemented using atoms.
///    iCodePage = Type: <b>int</b> The code page to be used to render the string. This value should be either <b>CP_WINANSI</b>
///                (the default code page) or CP_WINUNICODE, depending on whether the ANSI or Unicode version of DdeInitialize was
///                called by the client application.
///Returns:
///    Type: <b>HSZ</b> If the function succeeds, the return value is a string handle. If the function fails, the return
///    value is 0L. The DdeGetLastError function can be used to get the error code, which can be one of the following
///    values:
///    
@DllImport("USER32")
ptrdiff_t DdeCreateStringHandleW(uint idInst, const(PWSTR) psz, int iCodePage);

///Copies text associated with a string handle into a buffer.
///Params:
///    idInst = Type: <b>DWORD</b> The application instance identifier obtained by a previous call to the DdeInitialize function.
///    hsz = Type: <b>HSZ</b> A handle to the string to copy. This handle must have been created by a previous call to the
///          DdeCreateStringHandle function.
///    psz = Type: <b>LPTSTR</b> A pointer to a buffer that receives the string. To obtain the length of the string, this
///          parameter should be set to <b>NULL</b>.
///    cchMax = Type: <b>DWORD</b> The length, in characters, of the buffer pointed to by the <i>psz</i> parameter. For the ANSI
///             version of the function, this is the number of bytes; for the Unicode version, this is the number of characters.
///             If the string is longer than ( <i>cchMax</i>– 1), it will be truncated. If the <i>psz</i> parameter is set to
///             <b>NULL</b>, this parameter is ignored.
///    iCodePage = Type: <b>int</b> The code page used to render the string. This value should be either <b>CP_WINANSI</b> or
///                <b>CP_WINUNICODE</b>.
///Returns:
///    Type: <b>DWORD</b> If the <i>psz</i> parameter specified a valid pointer, the return value is the length, in
///    characters, of the returned text (not including the terminating null character). If the <i>psz</i> parameter
///    specified a <b>NULL</b> pointer, the return value is the length of the text associated with the <i>hsz</i>
///    parameter (not including the terminating null character). If an error occurs, the return value is 0L.
///    
@DllImport("USER32")
uint DdeQueryStringA(uint idInst, ptrdiff_t hsz, PSTR psz, uint cchMax, int iCodePage);

///Copies text associated with a string handle into a buffer.
///Params:
///    idInst = Type: <b>DWORD</b> The application instance identifier obtained by a previous call to the DdeInitialize function.
///    hsz = Type: <b>HSZ</b> A handle to the string to copy. This handle must have been created by a previous call to the
///          DdeCreateStringHandle function.
///    psz = Type: <b>LPTSTR</b> A pointer to a buffer that receives the string. To obtain the length of the string, this
///          parameter should be set to <b>NULL</b>.
///    cchMax = Type: <b>DWORD</b> The length, in characters, of the buffer pointed to by the <i>psz</i> parameter. For the ANSI
///             version of the function, this is the number of bytes; for the Unicode version, this is the number of characters.
///             If the string is longer than ( <i>cchMax</i>– 1), it will be truncated. If the <i>psz</i> parameter is set to
///             <b>NULL</b>, this parameter is ignored.
///    iCodePage = Type: <b>int</b> The code page used to render the string. This value should be either <b>CP_WINANSI</b> or
///                <b>CP_WINUNICODE</b>.
///Returns:
///    Type: <b>DWORD</b> If the <i>psz</i> parameter specified a valid pointer, the return value is the length, in
///    characters, of the returned text (not including the terminating null character). If the <i>psz</i> parameter
///    specified a <b>NULL</b> pointer, the return value is the length of the text associated with the <i>hsz</i>
///    parameter (not including the terminating null character). If an error occurs, the return value is 0L.
///    
@DllImport("USER32")
uint DdeQueryStringW(uint idInst, ptrdiff_t hsz, PWSTR psz, uint cchMax, int iCodePage);

///Frees a string handle in the calling application.
///Params:
///    idInst = Type: <b>DWORD</b> The application instance identifier obtained by a previous call to the DdeInitialize function.
///    hsz = Type: <b>HSZ</b> A handle to the string handle to be freed. This handle must have been created by a previous call
///          to the DdeCreateStringHandle function.
///Returns:
///    Type: <b>BOOL</b> If the function succeeds, the return value is nonzero. If the function fails, the return value
///    is zero.
///    
@DllImport("USER32")
BOOL DdeFreeStringHandle(uint idInst, ptrdiff_t hsz);

///Increments the usage count associated with the specified handle. This function enables an application to save a
///string handle passed to the application's Dynamic Data Exchange (DDE) callback function. Otherwise, a string handle
///passed to the callback function is deleted when the callback function returns. This function should also be used to
///keep a copy of a string handle referenced by the CONVINFO structure returned by the DdeQueryConvInfo function.
///Params:
///    idInst = Type: <b>DWORD</b> The application instance identifier obtained by a previous call to the DdeInitialize function.
///    hsz = Type: <b>HSZ</b> A handle to the string handle to be saved.
///Returns:
///    Type: <b>BOOL</b> If the function succeeds, the return value is nonzero. If the function fails, the return value
///    is zero.
///    
@DllImport("USER32")
BOOL DdeKeepStringHandle(uint idInst, ptrdiff_t hsz);

///Compares the values of two string handles. The value of a string handle is not related to the case of the associated
///string.
///Params:
///    hsz1 = Type: <b>HSZ</b> A handle to the first string.
///    hsz2 = Type: <b>HSZ</b> A handle to the second string.
///Returns:
///    Type: <b>int</b> The return value can be one of the following values. <table> <tr> <th>Return value</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt>-1</dt> </dl> </td> <td width="60%"> The value of
///    <i>hsz1</i> is either 0 or less than the value of <i>hsz2</i>. </td> </tr> <tr> <td width="40%"> <dl> <dt>0</dt>
///    </dl> </td> <td width="60%"> The values of <i>hsz1</i> and <i>hsz2</i> are equal (both can be 0). </td> </tr>
///    <tr> <td width="40%"> <dl> <dt>1</dt> </dl> </td> <td width="60%"> The value of <i>hsz2</i> is either 0 or less
///    than the value of <i>hsz1</i>. </td> </tr> </table>
///    
@DllImport("USER32")
int DdeCmpStringHandles(ptrdiff_t hsz1, ptrdiff_t hsz2);


