// Written in the D programming language.

module windows.operationrecorder;

public import windows.core;
public import windows.systemservices : BOOL;

extern(Windows) @nogc nothrow:


// Structs


///This structure is used by the OperationStart function.
struct OPERATION_START_PARAMETERS
{
    ///This parameter should be initialized to the <b>OPERATION_API_VERSION</b> value defined in the Windows SDK.
    ///<table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="OPERATION_API_VERSION"></a><a
    ///id="operation_api_version"></a><dl> <dt><b>OPERATION_API_VERSION</b></dt> <dt>1</dt> </dl> </td> <td width="60%">
    ///This API was introduced in Windows 8 and Windows Server 2012 as version 1. </td> </tr> </table>
    uint Version;
    ///Each operation has an OPERATION_ID namespace that is unique for each process. If two applications both use the
    ///same <b>OPERATION_ID</b> value to identify two operations, the system maintains separate contexts for each
    ///operation.
    uint OperationId;
    ///The value of this parameter can include any combination of the following values. <table> <tr> <th>Value</th>
    ///<th>Meaning</th> </tr> <tr> <td width="40%"><a id="OPERATION_START_TRACE_CURRENT_THREAD"></a><a
    ///id="operation_start_trace_current_thread"></a><dl> <dt><b>OPERATION_START_TRACE_CURRENT_THREAD</b></dt>
    ///<dt>1</dt> </dl> </td> <td width="60%"> Specifies that the system should only track the activities of the calling
    ///thread in a multi-threaded application. Specify this flag when the operation is performed on a single thread to
    ///isolate its activity from other threads in the process. </td> </tr> </table>
    uint Flags;
}

///This structure is used by the OperationEnd function.
struct OPERATION_END_PARAMETERS
{
    ///This parameter should be initialized to the <b>OPERATION_API_VERSION</b> defined in the Windows SDK. <table> <tr>
    ///<th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="OPERATION_API_VERSION"></a><a
    ///id="operation_api_version"></a><dl> <dt><b>OPERATION_API_VERSION</b></dt> <dt>1</dt> </dl> </td> <td width="60%">
    ///This API was introduced in Windows 8 and Windows Server 2012 as version 1. </td> </tr> </table>
    uint Version;
    ///Each operation has an OPERATION_ID namespace that is unique for each process. If two applications both use the
    ///same <b>OPERATION_ID</b> value to identify two operations, the system maintains separate contexts for each
    ///operation.
    uint OperationId;
    ///The value of this parameter can include any combination of the following values. <table> <tr> <th>Value</th>
    ///<th>Meaning</th> </tr> <tr> <td width="40%"><a id="OPERATION_END_DISCARD"></a><a
    ///id="operation_end_discard"></a><dl> <dt><b>OPERATION_END_DISCARD</b></dt> <dt>1</dt> </dl> </td> <td width="60%">
    ///Specifies that the system should discard the information it has been tracking for this operation. Specify this
    ///flag when the operation either fails or does not follow the expected sequence of steps. </td> </tr> </table>
    uint Flags;
}

// Functions

///Notifies the system that the application is about to start an operation. If an application calls
///<b>OperationStart</b> with a valid OPERATION_ID value, the system records the specified operation’s file access
///patterns until OperationEnd is called for the same operation ID. This record is stored in a <i>filename.pf</i>
///prefetch file. Every call to <b>OperationStart</b> must be followed by a call to <b>OperationEnd</b>, otherwise the
///operation's record is discarded after 10 seconds. If an application calls <b>OperationStart</b> for an operation ID
///for which a prefetch file exists, the system loads the operation's files into memory prior to running the operation.
///The recording process remains the same and the system updates the appropriate <i>filename.pf</i> prefetch file.
///Params:
///    OperationStartParams = An _OPERATION_START_PARAMETERS structure that specifies <b>VERSION</b>, <b>OPERATION_ID</b> and <b>FLAGS</b>.
///Returns:
///    <b>TRUE</b> for all valid parameters and <b>FALSE</b> otherwise. To get extended error information, call
///    <b>GetLastError</b>.
///    
@DllImport("ADVAPI32")
BOOL OperationStart(OPERATION_START_PARAMETERS* OperationStartParams);

///Notifies the system that the application is about to end an operation Every call to OperationStart must be followed
///by a call to <b>OperationEnd</b>, otherwise the operation's record of file access patterns is discarded after 10
///seconds.
///Params:
///    OperationEndParams = An _OPERATION_END_PARAMETERS structure that specifies <b>VERSION</b>, <b>OPERATION_ID</b> and <b>FLAGS</b>.
///Returns:
///    <b>TRUE</b> for all valid parameters and <b>FALSE</b> otherwise. To get extended error information, call
///    <b>GetLastError</b>.
///    
@DllImport("ADVAPI32")
BOOL OperationEnd(OPERATION_END_PARAMETERS* OperationEndParams);


