// Written in the D programming language.

module windows.systemrestore;

public import windows.core;
public import windows.systemservices : BOOL;
public import windows.windowsprogramming : FILETIME;

extern(Windows) @nogc nothrow:


// Structs


///Contains information used by the SRSetRestorePoint function.
struct RESTOREPOINTINFOA
{
align (1):
    ///The type of event. This member can be one of the following values. <table> <tr> <th>Event type</th>
    ///<th>Meaning</th> </tr> <tr> <td width="40%"><a id="BEGIN_NESTED_SYSTEM_CHANGE"></a><a
    ///id="begin_nested_system_change"></a><dl> <dt><b>BEGIN_NESTED_SYSTEM_CHANGE</b></dt> <dt>102</dt> </dl> </td> <td
    ///width="60%"> A system change has begun. A subsequent nested call does not create a new restore point. Subsequent
    ///calls must use END_NESTED_SYSTEM_CHANGE, not END_SYSTEM_CHANGE. </td> </tr> <tr> <td width="40%"><a
    ///id="BEGIN_SYSTEM_CHANGE"></a><a id="begin_system_change"></a><dl> <dt><b>BEGIN_SYSTEM_CHANGE</b></dt>
    ///<dt>100</dt> </dl> </td> <td width="60%"> A system change has begun. </td> </tr> <tr> <td width="40%"><a
    ///id="END_NESTED_SYSTEM_CHANGE"></a><a id="end_nested_system_change"></a><dl>
    ///<dt><b>END_NESTED_SYSTEM_CHANGE</b></dt> <dt>103</dt> </dl> </td> <td width="60%"> A system change has ended.
    ///</td> </tr> <tr> <td width="40%"><a id="END_SYSTEM_CHANGE"></a><a id="end_system_change"></a><dl>
    ///<dt><b>END_SYSTEM_CHANGE</b></dt> <dt>101</dt> </dl> </td> <td width="60%"> A system change has ended. </td>
    ///</tr> </table>
    uint     dwEventType;
    ///The type of restore point. This member can be one of the following values. <table> <tr> <th>Restore point
    ///type</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="APPLICATION_INSTALL"></a><a
    ///id="application_install"></a><dl> <dt><b>APPLICATION_INSTALL</b></dt> <dt>0</dt> </dl> </td> <td width="60%"> An
    ///application has been installed. </td> </tr> <tr> <td width="40%"><a id="APPLICATION_UNINSTALL"></a><a
    ///id="application_uninstall"></a><dl> <dt><b>APPLICATION_UNINSTALL</b></dt> <dt>1</dt> </dl> </td> <td width="60%">
    ///An application has been uninstalled. </td> </tr> <tr> <td width="40%"><a id="DEVICE_DRIVER_INSTALL"></a><a
    ///id="device_driver_install"></a><dl> <dt><b>DEVICE_DRIVER_INSTALL</b></dt> <dt>10</dt> </dl> </td> <td
    ///width="60%"> A device driver has been installed. </td> </tr> <tr> <td width="40%"><a id="MODIFY_SETTINGS"></a><a
    ///id="modify_settings"></a><dl> <dt><b>MODIFY_SETTINGS</b></dt> <dt>12</dt> </dl> </td> <td width="60%"> An
    ///application has had features added or removed. </td> </tr> <tr> <td width="40%"><a
    ///id="CANCELLED_OPERATION"></a><a id="cancelled_operation"></a><dl> <dt><b>CANCELLED_OPERATION</b></dt> <dt>13</dt>
    ///</dl> </td> <td width="60%"> An application needs to delete the restore point it created. For example, an
    ///application would use this flag when a user cancels an installation. </td> </tr> </table>
    uint     dwRestorePtType;
    ///The sequence number of the restore point. To end a system change, set this to the sequence number returned by the
    ///previous call to SRSetRestorePoint.
    long     llSequenceNumber;
    ///The description to be displayed so the user can easily identify a restore point. The maximum length of an ANSI
    ///string is MAX_DESC. The maximum length of a Unicode string is MAX_DESC_W. For more information, see Restore Point
    ///Description Text.
    byte[64] szDescription;
}

///Contains information used by the SRSetRestorePoint function.
struct RESTOREPOINTINFOW
{
align (1):
    ///The type of event. This member can be one of the following values. <table> <tr> <th>Event type</th>
    ///<th>Meaning</th> </tr> <tr> <td width="40%"><a id="BEGIN_NESTED_SYSTEM_CHANGE"></a><a
    ///id="begin_nested_system_change"></a><dl> <dt><b>BEGIN_NESTED_SYSTEM_CHANGE</b></dt> <dt>102</dt> </dl> </td> <td
    ///width="60%"> A system change has begun. A subsequent nested call does not create a new restore point. Subsequent
    ///calls must use END_NESTED_SYSTEM_CHANGE, not END_SYSTEM_CHANGE. </td> </tr> <tr> <td width="40%"><a
    ///id="BEGIN_SYSTEM_CHANGE"></a><a id="begin_system_change"></a><dl> <dt><b>BEGIN_SYSTEM_CHANGE</b></dt>
    ///<dt>100</dt> </dl> </td> <td width="60%"> A system change has begun. </td> </tr> <tr> <td width="40%"><a
    ///id="END_NESTED_SYSTEM_CHANGE"></a><a id="end_nested_system_change"></a><dl>
    ///<dt><b>END_NESTED_SYSTEM_CHANGE</b></dt> <dt>103</dt> </dl> </td> <td width="60%"> A system change has ended.
    ///</td> </tr> <tr> <td width="40%"><a id="END_SYSTEM_CHANGE"></a><a id="end_system_change"></a><dl>
    ///<dt><b>END_SYSTEM_CHANGE</b></dt> <dt>101</dt> </dl> </td> <td width="60%"> A system change has ended. </td>
    ///</tr> </table>
    uint        dwEventType;
    ///The type of restore point. This member can be one of the following values. <table> <tr> <th>Restore point
    ///type</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="APPLICATION_INSTALL"></a><a
    ///id="application_install"></a><dl> <dt><b>APPLICATION_INSTALL</b></dt> <dt>0</dt> </dl> </td> <td width="60%"> An
    ///application has been installed. </td> </tr> <tr> <td width="40%"><a id="APPLICATION_UNINSTALL"></a><a
    ///id="application_uninstall"></a><dl> <dt><b>APPLICATION_UNINSTALL</b></dt> <dt>1</dt> </dl> </td> <td width="60%">
    ///An application has been uninstalled. </td> </tr> <tr> <td width="40%"><a id="DEVICE_DRIVER_INSTALL"></a><a
    ///id="device_driver_install"></a><dl> <dt><b>DEVICE_DRIVER_INSTALL</b></dt> <dt>10</dt> </dl> </td> <td
    ///width="60%"> A device driver has been installed. </td> </tr> <tr> <td width="40%"><a id="MODIFY_SETTINGS"></a><a
    ///id="modify_settings"></a><dl> <dt><b>MODIFY_SETTINGS</b></dt> <dt>12</dt> </dl> </td> <td width="60%"> An
    ///application has had features added or removed. </td> </tr> <tr> <td width="40%"><a
    ///id="CANCELLED_OPERATION"></a><a id="cancelled_operation"></a><dl> <dt><b>CANCELLED_OPERATION</b></dt> <dt>13</dt>
    ///</dl> </td> <td width="60%"> An application needs to delete the restore point it created. For example, an
    ///application would use this flag when a user cancels an installation. </td> </tr> </table>
    uint        dwRestorePtType;
    ///The sequence number of the restore point. To end a system change, set this to the sequence number returned by the
    ///previous call to SRSetRestorePoint.
    long        llSequenceNumber;
    ///The description to be displayed so the user can easily identify a restore point. The maximum length of an ANSI
    ///string is MAX_DESC. The maximum length of a Unicode string is MAX_DESC_W. For more information, see Restore Point
    ///Description Text.
    ushort[256] szDescription;
}

struct _RESTOREPTINFOEX
{
align (1):
    FILETIME    ftCreation;
    uint        dwEventType;
    uint        dwRestorePtType;
    uint        dwRPNum;
    ushort[256] szDescription;
}

///Contains status information used by the SRSetRestorePoint function.
struct STATEMGRSTATUS
{
align (1):
    ///The status code. For a list of values, see the Remarks section.
    uint nStatus;
    ///The sequence number of the restore point.
    long llSequenceNumber;
}

// Functions

///Specifies the beginning and the ending of a set of changes so that System Restore can create a restore point. For a
///scriptable equivalent, see CreateRestorePoint.
///Params:
///    pRestorePtSpec = A pointer to a RESTOREPOINTINFO structure that specifies the restore point.
///    pSMgrStatus = A pointer to a STATEMGRSTATUS structure that receives the status information.
///Returns:
///    If the function succeeds, the return value is <b>TRUE</b>. The <b>llSequenceNumber</b> member of
///    <i>pSMgrStatus</i> receives the sequence number of the restore point. If the function fails, the return value is
///    <b>FALSE</b>. The <b>nStatus</b> member of <i>pSMgrStatus</i> receives error information.
///    
@DllImport("sfc")
BOOL SRSetRestorePointA(RESTOREPOINTINFOA* pRestorePtSpec, STATEMGRSTATUS* pSMgrStatus);

///Specifies the beginning and the ending of a set of changes so that System Restore can create a restore point. For a
///scriptable equivalent, see CreateRestorePoint.
///Params:
///    pRestorePtSpec = A pointer to a RESTOREPOINTINFO structure that specifies the restore point.
///    pSMgrStatus = A pointer to a STATEMGRSTATUS structure that receives the status information.
///Returns:
///    If the function succeeds, the return value is <b>TRUE</b>. The <b>llSequenceNumber</b> member of
///    <i>pSMgrStatus</i> receives the sequence number of the restore point. If the function fails, the return value is
///    <b>FALSE</b>. The <b>nStatus</b> member of <i>pSMgrStatus</i> receives error information.
///    
@DllImport("sfc")
BOOL SRSetRestorePointW(RESTOREPOINTINFOW* pRestorePtSpec, STATEMGRSTATUS* pSMgrStatus);


