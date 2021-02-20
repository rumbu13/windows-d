// Written in the D programming language.

module windows.mapi;

public import windows.core;
public import windows.systemservices : PSTR, PWSTR;

extern(Windows) @nogc nothrow:


// Callbacks

///<p class="CCE_Message">[The use of this function is discouraged. It may be altered or unavailable in subsequent
///versions of Windows.] The <b>MAPILogon</b> function begins a Simple MAPI session, loading the default message store
///and address book providers.
///Params:
///    ulUIParam = Parent window handle or zero, indicating that if a dialog box is displayed, it is application modal. If the
///                <i>ulUIParam</i> parameter contains a parent window handle, it is of type HWND (cast to a ULONG_PTR). If no
///                dialog box is displayed during the call, <i> ulUIParam</i> is ignored.
///    lpszProfileName = Pointer to a <b>null</b>-terminated profile name string, limited to 256 characters or less. This is the profile
///                      to use when logging on. If the <i>lpszProfileName</i> parameter is <b>NULL</b> or points to an empty string, and
///                      the <i>flFlags</i> parameter is set to MAPI_LOGON_UI, <b>MAPILogon</b> displays a logon dialog box with an empty
///                      name field.
///    lpszPassword = Pointer to a <b>null</b>-terminated credential string, limited to 256 characters or less. If the messaging system
///                   does not require password credentials, or if it requires that the user enter them, the <i>lpszPassword</i>
///                   parameter should be <b>NULL</b> or point to an empty string. When the user must enter credentials, the
///                   <i>flFlags</i> parameter must be set to MAPI_LOGON_UI to allow a logon dialog box to be displayed.
///    flFlags = Bitmask of option flags. The following flags can be set. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr>
///              <td width="40%"><a id="MAPI_FORCE_DOWNLOAD_"></a><a id="mapi_force_download_"></a><dl> <dt><b>MAPI_FORCE_DOWNLOAD
///              </b></dt> </dl> </td> <td width="60%"> An attempt should be made to download all of the user's messages before
///              returning. If the MAPI_FORCE_DOWNLOAD flag is not set, messages can be downloaded in the background after the
///              function call returns. </td> </tr> <tr> <td width="40%"><a id="MAPI_NEW_SESSION_"></a><a
///              id="mapi_new_session_"></a><dl> <dt><b>MAPI_NEW_SESSION </b></dt> </dl> </td> <td width="60%"> An attempt should
///              be made to create a new session rather than acquire the environment's shared session. If the MAPI_NEW_SESSION
///              flag is not set, <b>MAPILogon</b> uses an existing shared session. </td> </tr> <tr> <td width="40%"><a
///              id="MAPI_LOGON_UI_"></a><a id="mapi_logon_ui_"></a><dl> <dt><b>MAPI_LOGON_UI </b></dt> </dl> </td> <td
///              width="60%"> A logon dialog box should be displayed to prompt the user for logon information. If the user needs
///              to provide a password and profile name to enable a successful logon, MAPI_LOGON_UI must be set. </td> </tr> <tr>
///              <td width="40%"><a id="MAPI_PASSWORD_UI_"></a><a id="mapi_password_ui_"></a><dl> <dt><b>MAPI_PASSWORD_UI
///              </b></dt> </dl> </td> <td width="60%"> <b>MAPILogon</b> should only prompt for a password and not allow the user
///              to change the profile name. Either MAPI_PASSWORD_UI or MAPI_LOGON_UI should not be set, since the intent is to
///              select between two different dialog boxes for logon. </td> </tr> </table>
///    ulReserved = Reserved; must be zero.
///    lplhSession = Simple MAPI session handle.
///Returns:
///    This function returns one of the following values. <table> <tr> <th>Return code</th> <th>Description</th> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>MAPI_E_FAILURE </b></dt> </dl> </td> <td width="60%"> One or more unspecified
///    errors occurred during logon. No session handle was returned. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>MAPI_E_INSUFFICIENT_MEMORY </b></dt> </dl> </td> <td width="60%"> There was insufficient memory to
///    proceed. No session handle was returned. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>MAPI_E_LOGIN_FAILURE
///    </b></dt> </dl> </td> <td width="60%"> There was no default logon, and the user failed to log on successfully
///    when the logon dialog box was displayed. No session handle was returned. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>MAPI_E_TOO_MANY_SESSIONS </b></dt> </dl> </td> <td width="60%"> The user had too many sessions open
///    simultaneously. No session handle was returned. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>MAPI_E_USER_ABORT
///    </b></dt> </dl> </td> <td width="60%"> The user canceled the logon dialog box. No session handle was returned.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>SUCCESS_SUCCESS </b></dt> </dl> </td> <td width="60%"> The call
///    succeeded and a Simple MAPI session was established. </td> </tr> </table>
///    
alias MAPILOGON = uint function(size_t ulUIParam, PSTR lpszProfileName, PSTR lpszPassword, uint flFlags, 
                                uint ulReserved, size_t* lplhSession);
///<p class="CCE_Message">[The use of this function is discouraged. It may be altered or unavailable in subsequent
///versions of Windows.] The <b>MAPILogoff</b> function ends a session with the messaging system.
///Params:
///    lhSession = Handle for the Simple MAPI session to be terminated. Session handles are returned by the MAPILogon function and
///                invalidated by <b>MAPILogoff</b>. The value of the <i>lhSession</i> parameter must represent a valid session; it
///                cannot be zero.
///    ulUIParam = Parent window handle or zero, indicating that if a dialog box is displayed, it is application modal. If the
///                <i>ulUIParam</i> parameter contains a parent window handle, it is of type HWND (cast to a ULONG_PTR). If no
///                dialog box is displayed during the call, <i>ulUIParam</i> is ignored.
///    flFlags = Reserved; must be zero.
///    ulReserved = Reserved; must be zero.
///Returns:
///    This function returns one of the following values. <table> <tr> <th>Return code</th> <th>Description</th> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>MAPI_E_FAILURE </b></dt> </dl> </td> <td width="60%"> The <i>flFlags</i>
///    parameter is invalid or one or more unspecified errors occurred. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>MAPI_E_INSUFFICIENT_MEMORY </b></dt> </dl> </td> <td width="60%"> There was insufficient memory to
///    proceed. The session was not terminated. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>MAPI_E_INVALID_SESSION
///    </b></dt> </dl> </td> <td width="60%"> An invalid session handle was used for the <i>lhSession</i> parameter. The
///    session was not terminated. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>SUCCESS_SUCCESS </b></dt> </dl> </td>
///    <td width="60%"> The call succeeded and the session was terminated. </td> </tr> </table>
///    
alias MAPILOGOFF = uint function(size_t lhSession, size_t ulUIParam, uint flFlags, uint ulReserved);
///<p class="CCE_Message">[<b>MAPISendMail</b> is available for use in the operating systems specified in the
///Requirements section. It may be altered or unavailable in subsequent versions. Instead, use MAPISendMailW. ] Sends an
///ANSI message. <b>On Windows 8 and later: </b>Call MAPISendMailW to send a message. <b>On Windows 7 and earlier:
///</b>Use MAPISendMailHelper to send a message.
///Params:
///    lhSession = Type: <b>LHANDLE</b> For more information, see the MAPISendMailW function.
///    ulUIParam = Type: <b>ULONG_PTR</b> For more information, see the MAPISendMailW function.
///    lpMessage = Type: <b>lpMapiMessage</b> For more information, see the MAPISendMailW function.
///    flFlags = Type: <b>FLAGS</b> For more information, see the MAPISendMailW function.
///    ulReserved = Type: <b>ULONG</b> For more information, see the MAPISendMailW function.
///Returns:
///    Type: <b>ULONG</b> For more information, see the MAPISendMailW function.
///    
alias MAPISENDMAIL = uint function(size_t lhSession, size_t ulUIParam, MapiMessage* lpMessage, uint flFlags, 
                                   uint ulReserved);
///Sends a Unicode message. This function replaces the ANSI function MAPISendMail. <b>On Windows 7 and earlier:
///</b>Install the Microsoft Windows Software Development Kit (SDK) for Windows 8 and use MAPISendMailHelper to send a
///message. All information applies to both <b>MAPISendMailW</b> and MAPISendMail unless otherwise specified.
///Params:
///    lhSession = Type: <b>LHANDLE</b> Handle to a Simple MAPI session or zero. If the value of the <i>lhSession</i> parameter is
///                zero, MAPI logs on the user and creates a session that exists only for the duration of the call. This temporary
///                session can be an existing shared session or a new one. If necessary, the logon dialog box is displayed.
///    ulUIParam = Type: <b>ULONG_PTR</b> Parent window handle or zero. If the <i>ulUIParam</i> parameter contains the parent window
///                handle, the handle is type HWND (cast to a <b>ULONG_PTR</b>). If no dialog box is displayed during the call,
///                <i>ulUIParam</i> is ignored.
///    lpMessage = Type: <b><b>lpMapiMessageW</b></b> Pointer to a <b>MAPISendMailW</b> structure containing the message to be sent.
///                <div class="alert"><b>Note</b> For the MAPISendMail function, this parameter points to a MapiMessage
///                structure.</div> <div> </div> When you call the function, please note the following information about message
///                structure members:<table> <tr> <th>Member</th> <th>Notes</th> </tr> <tr> <td><b>lpFiles</b></td> <td> Set this
///                member to <b>NULL</b> when the message does not have file attachments. </td> </tr> <tr>
///                <td><b>lpszMessageType</b></td> <td> Used by applications that do not handle interpersonal messages. If your
///                application handles interpersonal messages, set the <b>lpszMessageType</b> member to <b>NULL</b> or set it to
///                point to an empty string. </td> </tr> <tr> <td><b>lpszSubject</b></td> <td> A value of <b>NULL</b> means that
///                there is no text for the subject of the message. </td> </tr> <tr> <td><b>lpszNoteText</b></td> <td> A value of
///                <b>NULL</b> means that there is no text in the body of the message. </td> </tr> <tr> <td><b>lpRecips</b></td>
///                <td> A value of <b>NULL</b> means that there are no recipients. Additionally, when this member is <b>NULL</b>,
///                the <b>nRecipCount</b> member must be zero. </td> </tr> <tr> <td><b>nRecipCount</b></td> <td> A value of zero
///                means that there are no recipients. Additionally, when this member is zero, the <b>lpRecips</b> member must be
///                <b>NULL</b>. </td> </tr> </table> <div class="alert"><b>Tip</b> When you call the function and there are no
///                recipients, you must set either the <b>MAPI_DIALOG</b> flag or the <b>MAPI_DIALOG_MODELESS</b> flag to prompt the
///                user for recipient information.</div> <div> </div> If either <b>MAPI_DIALOG</b> or <b>MAPI_DIALOG_MODELESS</b> is
///                not set, the <b>nRecipCount</b> and <b>lpRecips</b> members of the structure must be valid for successful message
///                delivery. Client applications can set the <b>flFlags</b> member to <b>MAPI_RECEIPT_REQUESTED</b> to request a
///                read report. For more details about how the function handles recipient information, see Handling Recipient
///                Information in <i>Remarks</i>.
///    flFlags = Type: <b>FLAGS</b> Bitmask of option flags. The following flags can be set. <table> <tr> <th>Value</th>
///              <th>Meaning</th> </tr> <tr> <td width="40%"><a id="MAPI_DIALOG"></a><a id="mapi_dialog"></a><dl>
///              <dt><b>MAPI_DIALOG</b></dt> <dt>0x00000008</dt> </dl> </td> <td width="60%"> A application modal dialog box
///              should be displayed to prompt the user for recipients and other sending options. If neither <b>MAPI_DIALOG</b>
///              nor <b>MAPI_DIALOG_MODELESS</b> is set, at least one recipient must be specified. </td> </tr> <tr> <td
///              width="40%"><a id="MAPI_DIALOG_MODELESS"></a><a id="mapi_dialog_modeless"></a><dl>
///              <dt><b>MAPI_DIALOG_MODELESS</b></dt> <dt>0x00000004 | MAPI_DIALOG</dt> </dl> </td> <td width="60%"> <b>Available
///              on Windows with next version of Office: </b><p class="note">A modeless dialog box should be displayed to prompt
///              the user for recipients and other sending options. <p class="note">If <b>MAPI_DIALOG_MODELESS</b> is set, the
///              <i>lhSession</i> parameter should be set to zero. Otherwise, if this flag is set and <i>lhSession</i> is not
///              zero, Outlook will raise an exception. <p class="note">Additionally, if <b>MAPI_DIALOG_MODELESS</b> is set, the
///              system ignores the <b>MAPI_NEW_SESSION</b> flag. <p class="note">If neither <b>MAPI_DIALOG</b> nor
///              <b>MAPI_DIALOG_MODELESS</b> is set, at least one recipient must be specified. <div class="alert"><b>Tip</b> To
///              use this flag on Windows 7 or earlier you must have both Windows SDK for Windows 8 and next version of Office
///              installed, and you must call MAPISendMailHelper instead of <b>MAPISendMailW</b>.</div> <div> </div> </td> </tr>
///              <tr> <td width="40%"><a id="MAPI_LOGON_UI"></a><a id="mapi_logon_ui"></a><dl> <dt><b>MAPI_LOGON_UI</b></dt>
///              <dt>0x00000001</dt> </dl> </td> <td width="60%"> A dialog box should be displayed to prompt the user to log on if
///              required. If the <b>MAPI_LOGON_UI</b> flag is not set, the client application does not display a logon dialog box
///              and returns an error value if the user is not logged on. If the <i>lpszMessageID</i> parameter is empty, the
///              <b>MAPI_LOGON_UI</b> flag is ignored. </td> </tr> <tr> <td width="40%"><a id="MAPI_NEW_SESSION"></a><a
///              id="mapi_new_session"></a><dl> <dt><b>MAPI_NEW_SESSION</b></dt> <dt>0x00000002</dt> </dl> </td> <td width="60%">
///              An attempt is made to create a new session rather than acquire the environment's shared session. If the
///              <b>MAPI_NEW_SESSION</b> flag is not set, the function uses an existing, shared session. If you set the
///              <b>MAPI_NEW_SESSION</b> flag (preventing the use of a shared session) and the profile requires a password, you
///              must also set the <b>MAPI_LOGON_UI</b> flag or the function will fail. Your client application can avoid this
///              failure by using the default profile without a password or by using an explicit profile without a password. </td>
///              </tr> <tr> <td width="40%"><a id="MAPI_FORCE_UNICODE"></a><a id="mapi_force_unicode"></a><dl>
///              <dt><b>MAPI_FORCE_UNICODE</b></dt> <dt>0x00040000</dt> </dl> </td> <td width="60%"> Do not convert the message to
///              ANSI if the provider does not support Unicode. <div class="alert"><b>Note</b> This flag is available for
///              <b>MAPISendMailW</b> only.</div> <div> </div> </td> </tr> </table>
///    ulReserved = Type: <b>ULONG</b> Reserved; must be zero.
///Returns:
///    Type: <b>ULONG</b> This function returns one of the following values. <table> <tr> <th>Return code/value</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>MAPI_E_AMBIGUOUS_RECIPIENT </b></dt> <dt>21</dt>
///    </dl> </td> <td width="60%"> A recipient matched more than one of the recipient descriptor structures and
///    MAPI_DIALOG was not set. No message was sent. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>MAPI_E_ATTACHMENT_NOT_FOUND </b></dt> <dt>11</dt> </dl> </td> <td width="60%"> The specified attachment
///    was not found. No message was sent. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>MAPI_E_ATTACHMENT_OPEN_FAILURE
///    </b></dt> <dt>12</dt> </dl> </td> <td width="60%"> The specified attachment could not be opened. No message was
///    sent. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>MAPI_E_ATTACHMENT_TOO_LARGE </b></dt> <dt>28</dt> </dl> </td>
///    <td width="60%"> The specified attachment was too large. No message was sent. </td> </tr> <tr> <td width="40%">
///    <dl> <dt><b>MAPI_E_BAD_RECIPTYPE </b></dt> <dt>15</dt> </dl> </td> <td width="60%"> The type of a recipient was
///    not MAPI_TO, MAPI_CC, or MAPI_BCC. No message was sent. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>MAPI_E_FAILURE </b></dt> <dt>2</dt> </dl> </td> <td width="60%"> One or more unspecified errors occurred.
///    No message was sent. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>MAPI_E_INSUFFICIENT_MEMORY </b></dt>
///    <dt>5</dt> </dl> </td> <td width="60%"> There was insufficient memory to proceed. No message was sent. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>MAPI_E_INVALID_RECIPS </b></dt> <dt>25</dt> </dl> </td> <td width="60%">
///    One or more recipients were invalid or did not resolve to any address. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>MAPI_E_LOGIN_FAILURE </b></dt> <dt>3</dt> </dl> </td> <td width="60%"> There was no default logon, and the
///    user failed to log on successfully when the logon dialog box was displayed. No message was sent. </td> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>MAPI_E_TEXT_TOO_LARGE </b></dt> <dt>18</dt> </dl> </td> <td width="60%"> The text in
///    the message was too large. No message was sent. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>MAPI_E_TOO_MANY_FILES </b></dt> <dt>9</dt> </dl> </td> <td width="60%"> There were too many file
///    attachments. No message was sent. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>MAPI_E_TOO_MANY_RECIPIENTS
///    </b></dt> <dt>10</dt> </dl> </td> <td width="60%"> There were too many recipients. No message was sent. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>MAPI_E_UNICODE_NOT_SUPPORTED </b></dt> <dt>27</dt> </dl> </td> <td
///    width="60%"> The <b>MAPI_FORCE_UNICODE</b> flag is specified and Unicode is not supported. <div
///    class="alert"><b>Note</b> This value can be returned by MAPISendMailW only.</div> <div> </div> </td> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>MAPI_E_UNKNOWN_RECIPIENT </b></dt> <dt>14</dt> </dl> </td> <td width="60%"> A
///    recipient did not appear in the address list. No message was sent. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>MAPI_E_USER_ABORT </b></dt> <dt>1</dt> </dl> </td> <td width="60%"> The user canceled one of the dialog
///    boxes. No message was sent. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>SUCCESS_SUCCESS </b></dt> <dt>0</dt>
///    </dl> </td> <td width="60%"> The call succeeded and the message was sent. </td> </tr> </table>
///    
alias MAPISENDMAILW = uint function(size_t lhSession, size_t ulUIParam, MapiMessageW* lpMessage, uint flFlags, 
                                    uint ulReserved);
///<p class="CCE_Message">[The use of this function is discouraged. It may be altered or unavailable in subsequent
///versions of Windows.] The <b>MAPISendDocuments</b> function sends a standard message with one or more attached files
///and a cover note. The cover note is a dialog box that allows the user to enter a list of recipients and an optional
///message. <b>MAPISendDocuments</b> differs from the MAPISendMail function in that it allows less flexibility in
///message generation.
///Params:
///    ulUIParam = Parent window handle or zero, indicating that if a dialog box is displayed, it is application modal. If the
///                <i>ulUIParam</i> parameter contains a parent window handle, it is of type HWND (cast to a ULONG_PTR). If no
///                dialog box is displayed during the call, <i>ulUIParam</i> is ignored.
///    lpszDelimChar = Pointer to a character that the caller uses to delimit the names pointed to by the <i>lpszFullPaths</i> and
///                    <i>lpszFileNames</i> parameters. The caller should select a character for the delimiter that is not used in
///                    operating system filenames.
///    lpszFilePaths = Pointer to a string containing a list of full paths (including drive letters) to attachment files. This list is
///                    formed by concatenating correctly formed file paths separated by the character specified in the
///                    <i>lpszDelimChar</i> parameter and followed by a <b>null</b> terminator. An example of a valid list is:
///                    C:\TMP\TEMP1.DOC;C:\TMP\TEMP2.DOC The files specified in this parameter are added to the message as file
///                    attachments. If this parameter is <b>NULL</b> or contains an empty string, the Send Note dialog box is displayed
///                    with no attached files.
///    lpszFileNames = Pointer to a <b>null</b>-terminated list of the original filenames as they should appear in the message. When
///                    multiple names are specified, the list is formed by concatenating the filenames separated by the character
///                    specified in the <i>lpszDelimChar</i> parameter and followed by a <b>null</b> terminator. An example is:
///                    TEMP3.DOC;TEMP4.DOC If there is no value for the <i>lpszFileNames</i> parameter or if it is empty,
///                    <b>MAPISendDocuments</b> sets the filenames set to the filename values indicated by the <i>lpszFullPaths</i>
///                    parameter.
///    ulReserved = Reserved; must be zero.
///Returns:
///    This function returns one of the following values. <table> <tr> <th>Return code</th> <th>Description</th> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>MAPI_E_ATTACHMENT_OPEN_FAILURE </b></dt> </dl> </td> <td width="60%"> One or
///    more files in the <i>lpszFilePaths</i> parameter could not be located. No message was sent. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>MAPI_E_ATTACHMENT_WRITE_FAILURE </b></dt> </dl> </td> <td width="60%"> An attachment
///    could not be written to a temporary file. Check directory permissions. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>MAPI_E_FAILURE </b></dt> </dl> </td> <td width="60%"> One or more unspecified errors occurred while
///    sending the message. It is not known if the message was sent. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>MAPI_E_INSUFFICIENT_MEMORY </b></dt> </dl> </td> <td width="60%"> There was insufficient memory to
///    proceed. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>MAPI_E_LOGIN_FAILURE </b></dt> </dl> </td> <td
///    width="60%"> There was no default logon, and the user failed to log on successfully when the logon dialog box was
///    displayed. No message was sent. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>MAPI_E_USER_ABORT </b></dt> </dl>
///    </td> <td width="60%"> The user canceled one of the dialog boxes. No message was sent. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>SUCCESS_SUCCESS </b></dt> </dl> </td> <td width="60%"> The call succeeded and the
///    message was sent. </td> </tr> </table>
///    
alias MAPISENDDOCUMENTS = uint function(size_t ulUIParam, PSTR lpszDelimChar, PSTR lpszFilePaths, 
                                        PSTR lpszFileNames, uint ulReserved);
///<p class="CCE_Message">[The use of this function is discouraged. It may be altered or unavailable in subsequent
///versions of Windows.] The <b>MAPIFindNext</b> function retrieves the next (or first) message identifier of a
///specified type of incoming message.
///Params:
///    lhSession = Session handle that represents a Simple MAPI session. The value of the <i>lhSession</i> parameter must represent
///                a valid session; it cannot be zero.
///    ulUIParam = Parent window handle or zero, indicating that if a dialog box is displayed, it is application modal. If the
///                <i>ulUIParam</i> parameter contains a parent window handle, it is of type HWND (cast to a ULONG_PTR). If no
///                dialog box is displayed during the call, <i>ulUIParam</i> is ignored.
///    lpszMessageType = Pointer to a string identifying the message class to search. To find an interpersonal message (IPM), specify
///                      <b>NULL</b> in the <i>lpszMessageType</i> parameter or have it point to an empty string. Messaging systems whose
///                      only supported message class is IPM can ignore this parameter.
///    lpszSeedMessageID = Pointer to a string containing the message identifier seed for the request. If the <i>lpszSeedMessageID</i>
///                        parameter is <b>NULL</b> or points to an empty string, <b>MAPIFindNext</b> retrieves the first message that
///                        matches the type specified in the <i>lpszMessageType</i> parameter.
///    flFlags = Bitmask of option flags. The following flags can be set. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr>
///              <td width="40%"><a id="MAPI_GUARANTEE_FIFO_"></a><a id="mapi_guarantee_fifo_"></a><dl> <dt><b>MAPI_GUARANTEE_FIFO
///              </b></dt> </dl> </td> <td width="60%"> The message identifiers returned should be in the order of time received.
///              <b>MAPIFindNext</b> calls can take longer if this flag is set. Some implementations cannot honor this request and
///              return the MAPI_E_NO_SUPPORT value. </td> </tr> <tr> <td width="40%"><a id="MAPI_LONG_MSGID_"></a><a
///              id="mapi_long_msgid_"></a><dl> <dt><b>MAPI_LONG_MSGID </b></dt> </dl> </td> <td width="60%"> The returned message
///              identifier can be as long as 512 characters. If this flag is set, the <i>lpszMessageID</i> parameter must be
///              large enough to accommodate 512 characters. Older versions of MAPI supported smaller message identifiers (64
///              bytes) and did not include this flag. <b>MAPIFindNext</b> will succeed without this flag set as long as
///              <i>lpszMessageID</i> is large enough to hold the message identifier. If <i>lpszMessageID</i> cannot hold the
///              message identifier, <b>MAPIFindNext</b> will fail. </td> </tr> <tr> <td width="40%"><a
///              id="MAPI_UNREAD_ONLY_"></a><a id="mapi_unread_only_"></a><dl> <dt><b>MAPI_UNREAD_ONLY </b></dt> </dl> </td> <td
///              width="60%"> Only unread messages of the specified type should be enumerated. If this flag is not set,
///              <b>MAPIFindNext</b> can return any message of the specified type. </td> </tr> </table>
///    ulReserved = Reserved; must be zero.
///    lpszMessageID = Pointer to the returned message identifier. The caller is responsible for allocating the memory. To ensure
///                    compatibility, allocate 512 characters and set MAPI_LONG_MSGID in the <i>flFlags</i> parameter. A smaller buffer
///                    is sufficient only if the returned message identifier is always 64 characters or less.
///Returns:
///    This function returns one of the following values. <table> <tr> <th>Return code</th> <th>Description</th> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>MAPI_E_FAILURE </b></dt> </dl> </td> <td width="60%"> One or more unspecified
///    errors occurred while matching the message type. The call failed before message type matching could take place.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>MAPI_E_INSUFFICIENT_MEMORY </b></dt> </dl> </td> <td width="60%">
///    There was insufficient memory to proceed. No message was found. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>MAPI_E_INVALID_MESSAGE </b></dt> </dl> </td> <td width="60%"> An invalid message identifier was passed in
///    the <i>lpszSeedMessageID</i> parameter. No message was found. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>MAPI_E_INVALID_SESSION </b></dt> </dl> </td> <td width="60%"> An invalid session handle was passed in the
///    <i>lhSession</i> parameter. No message was found. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>MAPI_E_NO_MESSAGES </b></dt> </dl> </td> <td width="60%"> A matching message could not be found. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>SUCCESS_SUCCESS </b></dt> </dl> </td> <td width="60%"> The call succeeded
///    and the message identifier was returned. </td> </tr> </table>
///    
alias MAPIFINDNEXT = uint function(size_t lhSession, size_t ulUIParam, PSTR lpszMessageType, 
                                   PSTR lpszSeedMessageID, uint flFlags, uint ulReserved, PSTR lpszMessageID);
///<p class="CCE_Message">[The use of this function is discouraged. It may be altered or unavailable in subsequent
///versions of Windows.] The <b>MAPIReadMail</b> function retrieves a message for reading.
///Params:
///    lhSession = Handle to a Simple MAPI session. The value of the <i>lhSession</i> parameter must represent a valid session; it
///                cannot be zero.
///    ulUIParam = Parent window handle or zero, indicating that if a dialog box is displayed, it is application modal. If the
///                <i>ulUIParam</i> parameter contains a parent window handle, it is of type HWND (cast to a ULONG_PTR). If no
///                dialog box is displayed during the call, <i> ulUIParam</i> is ignored.
///    lpszMessageID = Pointer to a message identifier string for the message to be read. The string is allocated by the caller.
///    flFlags = Bitmask of option flags. The following flags can be set. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr>
///              <td width="40%"><a id="MAPI_BODY_AS_FILE_"></a><a id="mapi_body_as_file_"></a><dl> <dt><b>MAPI_BODY_AS_FILE
///              </b></dt> </dl> </td> <td width="60%"> <b>MAPIReadMail</b> should write the message text to a temporary file and
///              add it as the first attachment in the attachment list. </td> </tr> <tr> <td width="40%"><a
///              id="MAPI_ENVELOPE_ONLY_"></a><a id="mapi_envelope_only_"></a><dl> <dt><b>MAPI_ENVELOPE_ONLY </b></dt> </dl> </td>
///              <td width="60%"> <b>MAPIReadMail</b> should read the message header only. File attachments are not copied to
///              temporary files, and neither temporary file names nor message text is written. Setting this flag enhances
///              performance. </td> </tr> <tr> <td width="40%"><a id="MAPI_PEEK_"></a><a id="mapi_peek_"></a><dl> <dt><b>MAPI_PEEK
///              </b></dt> </dl> </td> <td width="60%"> <b>MAPIReadMail</b> does not mark the message as read. Marking a message
///              as read affects its appearance in the user interface and generates a read receipt. If the messaging system does
///              not support this flag, <b>MAPIReadMail</b> always marks the message as read. If <b>MAPIReadMail</b> encounters an
///              error, it leaves the message unread. </td> </tr> <tr> <td width="40%"><a id="MAPI_SUPPRESS_ATTACH_"></a><a
///              id="mapi_suppress_attach_"></a><dl> <dt><b>MAPI_SUPPRESS_ATTACH </b></dt> </dl> </td> <td width="60%">
///              <b>MAPIReadMail</b> should not copy file attachments but should write message text into the MapiMessage
///              structure. <b>MAPIReadMail</b> ignores this flag if the calling application has set the MAPI_ENVELOPE_ONLY flag.
///              Setting the MAPI_SUPPRESS_ATTACH flag enhances performance. </td> </tr> </table>
///    ulReserved = Reserved; must be zero.
///     = Pointer to the location where the message is written. Messages are written to a MapiMessage structure which can
///       be freed with a single call to the MAPIFreeBuffer function. When MAPI_ENVELOPE_ONLY and MAPI_SUPPRESS_ATTACH are
///       not set, attachments are written to temporary files pointed to by the <b>lpFiles</b> member of the MapiMessage
///       structure. It is the caller's responsibility to delete these files when they are no longer needed.
///Returns:
///    This function returns one of the following values. <table> <tr> <th>Return code</th> <th>Description</th> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>MAPI_E_ATTACHMENT_WRITE_FAILURE </b></dt> </dl> </td> <td width="60%"> An
///    attachment could not be written to a temporary file. Check directory permissions. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>MAPI_E_DISK_FULL </b></dt> </dl> </td> <td width="60%"> An attachment could not be
///    written to a temporary file because there was not enough space on the disk. </td> </tr> <tr> <td width="40%">
///    <dl> <dt><b>MAPI_E_FAILURE </b></dt> </dl> </td> <td width="60%"> One or more unspecified errors occurred while
///    reading the message. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>MAPI_E_INSUFFICIENT_MEMORY </b></dt> </dl>
///    </td> <td width="60%"> There was insufficient memory to read the message. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>MAPI_E_INVALID_MESSAGE </b></dt> </dl> </td> <td width="60%"> An invalid message identifier was passed in
///    the <i>lpszMessageID</i> parameter. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>MAPI_E_INVALID_SESSION
///    </b></dt> </dl> </td> <td width="60%"> An invalid session handle was passed in the <i>lhSession</i> parameter. No
///    message was retrieved. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>MAPI_E_TOO_MANY_FILES </b></dt> </dl> </td>
///    <td width="60%"> There were too many file attachments in the message. The message could not be read. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>MAPI_E_TOO_MANY_RECIPIENTS </b></dt> </dl> </td> <td width="60%"> There were
///    too many recipients of the message. The message could not be read. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>SUCCESS_SUCCESS </b></dt> </dl> </td> <td width="60%"> The call succeeded and the message was read. </td>
///    </tr> </table>
///    
alias MAPIREADMAIL = uint function(size_t lhSession, size_t ulUIParam, PSTR lpszMessageID, uint flFlags, 
                                   uint ulReserved, MapiMessage** lppMessage);
///<p class="CCE_Message">[The use of this function is discouraged. It may be altered or unavailable in subsequent
///versions of Windows.] The <b>MAPISaveMail</b> function saves a message into the message store.
///Params:
///    lhSession = Handle for a Simple MAPI session or zero. The value of the <i>lhSession</i> parameter must not be zero if the
///                <i>lpszMessageID</i> parameter contains a valid message identifier. However, if <i>lpszMessageID</i> does not
///                contain a valid message identifier, and the value of <i>lhSession</i> is zero, MAPI logs on the user and creates
///                a session that exists only for the duration of the call. This temporary session can be an existing shared session
///                or a new one. If necessary, the logon dialog box is displayed.
///    ulUIParam = Parent window handle or zero, indicating that if a dialog box is displayed, it is application modal. If the
///                <i>ulUIParam</i> parameter contains a parent window handle, it is of type <b>HWND</b> (cast to a
///                <b>ULONG_PTR</b>). If no dialog box is displayed during the call, <i>ulUIParam</i> is ignored.
///    lpMessage = Input parameter pointing to a MapiMessage structure containing the contents of the message to be saved. The
///                <b>lpOriginator</b> member is ignored. Applications can either ignore the <b>flFlags</b> member, or if the
///                message has never been saved, can set the MAPI_SENT and MAPI_UNREAD flags.
///    flFlags = Bitmask of option flags. The following flags can be set. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr>
///              <td width="40%"><a id="MAPI_LOGON_UI_"></a><a id="mapi_logon_ui_"></a><dl> <dt><b>MAPI_LOGON_UI </b></dt> </dl>
///              </td> <td width="60%"> A dialog box should be displayed to prompt the user to logon if required. When the
///              MAPI_LOGON_UI flag is not set, the client application does not display a logon dialog box and returns an error
///              value if the user is not logged on. <b>MAPISaveMail</b> ignores this flag if the <i>lpszMessageID</i> parameter
///              is empty. </td> </tr> <tr> <td width="40%"><a id="MAPI_LONG_MSGID_"></a><a id="mapi_long_msgid_"></a><dl>
///              <dt><b>MAPI_LONG_MSGID </b></dt> </dl> </td> <td width="60%"> The returned message identifier is expected to be
///              512 characters. If this flag is set, the <i>lpszMessageID</i> parameter must be large enough to accommodate 512
///              characters. </td> </tr> <tr> <td width="40%"><a id="MAPI_NEW_SESSION_"></a><a id="mapi_new_session_"></a><dl>
///              <dt><b>MAPI_NEW_SESSION </b></dt> </dl> </td> <td width="60%"> An attempt should be made to create a new session
///              rather than acquire the environment's shared session. If the MAPI_NEW_SESSION flag is not set,
///              <b>MAPISaveMail</b> uses an existing shared session. </td> </tr> </table>
///    ulReserved = Reserved; must be zero.
///    lpszMessageID = Pointer to either the message identifier to be replaced by the save operation or an empty string, indicating that
///                    a new message is to be created. The string must be allocated by the caller and must be able to hold at least 512
///                    characters if the <i>flFlags</i> parameter is set to MAPI_LONG_MSGID. If the <i>flFlags</i> parameter is not set
///                    to MAPI_LONG_MSGID, the message identifier string can hold 64 characters.
///Returns:
///    This function returns one of the following values. <table> <tr> <th>Return code</th> <th>Description</th> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>MAPI_E_ATTACHMENT_NOT_FOUND </b></dt> </dl> </td> <td width="60%"> An
///    attachment could not be located at the specified path. Either the drive letter was invalid, the path was not
///    found on that drive, or the file was not found in that path. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>MAPI_E_BAD_RECIPTYPE </b></dt> </dl> </td> <td width="60%"> The recipient type in the <i>lpMessage</i> was
///    invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>MAPI_E_FAILURE </b></dt> </dl> </td> <td width="60%"> One
///    or more unspecified errors occurred while saving the message. No message was saved. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>MAPI_E_INSUFFICIENT_MEMORY </b></dt> </dl> </td> <td width="60%"> There was insufficient
///    memory to save the message. No message was saved. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>MAPI_E_INVALID_MESSAGE </b></dt> </dl> </td> <td width="60%"> An invalid message identifier was passed in
///    the <i>lpszMessageID</i> parameter; no message was saved. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>MAPI_E_INVALID_RECIPS </b></dt> </dl> </td> <td width="60%"> One or more recipients of the message were
///    invalid or could not be identified. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>MAPI_E_INVALID_SESSION
///    </b></dt> </dl> </td> <td width="60%"> An invalid session handle was passed in the <i>lhSession</i> parameter. No
///    message was saved. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>MAPI_E_LOGIN_FAILURE </b></dt> </dl> </td> <td
///    width="60%"> There was no default logon, and the user failed to log on successfully when the logon dialog box was
///    displayed. No message was saved. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>MAPI_E_NOT_SUPPORTED </b></dt>
///    </dl> </td> <td width="60%"> The operation was not supported by the underlying messaging system. </td> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>MAPI_E_USER_ABORT </b></dt> </dl> </td> <td width="60%"> The user canceled one of
///    the dialog boxes. No message was saved. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>SUCCESS_SUCCESS </b></dt>
///    </dl> </td> <td width="60%"> The call succeeded and the message was saved. </td> </tr> </table>
///    
alias MAPISAVEMAIL = uint function(size_t lhSession, size_t ulUIParam, MapiMessage* lpMessage, uint flFlags, 
                                   uint ulReserved, PSTR lpszMessageID);
///<p class="CCE_Message">[The use of this function is discouraged. It may be altered or unavailable in subsequent
///versions of Windows.] The <b>MAPIDeleteMail</b> function deletes a message.
///Params:
///    lhSession = Session handle that represents a valid Simple MAPI session. The value of the <i>lhSession</i> parameter must
///                represent a valid session; it cannot be zero.
///    ulUIParam = Parent window handle or zero, indicating that if a dialog box is displayed, it is application modal. If the
///                <i>ulUIParam</i> parameter contains a parent window handle, it is of type HWND (cast to a ULONG_PTR). If no
///                dialog box is displayed during the call, <i> ulUIParam</i> is ignored.
///    lpszMessageID = The identifier for the message to be deleted. This identifier is messaging system-specific and will be invalid
///                    when <b>MAPIDeleteMail</b> successfully returns.
///    flFlags = Reserved; must be zero.
///    ulReserved = Reserved; must be zero.
///Returns:
///    This function returns one of the following values. <table> <tr> <th>Return code</th> <th>Description</th> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>MAPI_E_FAILURE </b></dt> </dl> </td> <td width="60%"> One or more unspecified
///    errors occurred while deleting the message. No message was deleted. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>MAPI_E_INSUFFICIENT_MEMORY </b></dt> </dl> </td> <td width="60%"> There was insufficient memory to
///    proceed. No message was deleted. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>MAPI_E_INVALID_MESSAGE </b></dt>
///    </dl> </td> <td width="60%"> An invalid message identifier was passed in the <i>lpszMessageID</i> parameter. No
///    message was deleted. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>MAPI_E_INVALID_SESSION </b></dt> </dl> </td>
///    <td width="60%"> An invalid session handle was passed in the <i>lhSession</i> parameter. No message was deleted.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>SUCCESS_SUCCESS </b></dt> </dl> </td> <td width="60%"> The call
///    succeeded and the message was deleted. </td> </tr> </table>
///    
alias MAPIDELETEMAIL = uint function(size_t lhSession, size_t ulUIParam, PSTR lpszMessageID, uint flFlags, 
                                     uint ulReserved);
///<p class="CCE_Message">[The use of this function is discouraged. It may be altered or unavailable in subsequent
///versions of Windows.] The <b>MAPIAddress</b> function creates or modifies a set of address list entries.
///Params:
///    lhSession = Session handle that represents a Simple MAPI session or zero. If the value of the <i>lhSession</i> parameter is
///                zero, MAPI logs on the user and creates a session that exists only for the duration of the call. This temporary
///                session can be an existing shared session or a new one. If necessary, a logon dialog box is displayed.
///    ulUIParam = Parent window handle or zero, indicating that if a dialog box is displayed, it is application modal. If the
///                <i>ulUIParam</i> parameter contains a parent window handle, it is of type HWND (cast to a ULONG_PTR). If no
///                dialog box is displayed during the call, <i> ulUIParam</i> is ignored.
///    lpszCaption = Pointer to the caption for the address list dialog box, <b>NULL</b>, or an empty string. When the
///                  <i>lpszCaption</i> parameter is <b>NULL</b> or points to an empty string, <b>MAPIAddress</b> uses the default
///                  caption "Address Book."
///    nEditFields = The number of edit controls that should be present in the address list. The values 0 through 4 are valid. If the
///                  value of the <i>nEditFields</i> parameter is 4, each recipient class supported by the underlying messaging system
///                  has an edit control. If the value of <i>nEditFields</i> is zero, only address list browsing is possible. Values
///                  of 1, 2, or 3 control the number of edit controls present. However, if the number of recipient classes in the
///                  array pointed to by the <i>lpRecips</i> parameter is greater than the value of <i>nEditFields</i>, the number of
///                  classes in <i>lpRecips</i> is used to indicate the number of edit controls instead of the value of
///                  <i>nEditFields</i>. If the value of <i>nEditFields</i> is 1 and more than one kind of entry exists in
///                  <i>lpRecips</i>, then the <i>lpszLabels</i> parameter is ignored. Entries selected for the different controls are
///                  differentiated by the <b>ulRecipClass</b> member in the returned recipient structure.
///    lpszLabels = Pointer to a string to be used as an edit control label in the address-list dialog box. When the
///                 <i>nEditFields</i> parameter is set to any value other than 1, the <i>lpszLabels</i> parameter is ignored and
///                 should be <b>NULL</b> or point to an empty string. Also, if the caller requires the default control label "To,"
///                 <i>lpszLabels</i> should be <b>NULL</b> or point to an empty string.
///    nRecips = The number of entries in the array indicated by the <i>lpRecips</i> parameter. If the value of the <i>nRecips</i>
///              parameter is zero, <i>lpRecips</i> is ignored.
///    lpRecips = Pointer to an array of MapiRecipDesc structures defining the initial recipient entries to be used to populate the
///               address-list dialog box. The entries do not need to be grouped by recipient class; they are differentiated by the
///               values of the <b>ulRecipClass</b> members of the <b>MapiRecipDesc</b> structures in the array. If the number of
///               different recipient classes is greater than the value indicated by the <i>nEditFields</i> parameter, the
///               <i>nEditFields</i> and <i>lpszLabels</i> parameters are ignored.
///    flFlags = Bitmask of option flags. The following flags can be set. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr>
///              <td width="40%"><a id="MAPI_LOGON_UI_"></a><a id="mapi_logon_ui_"></a><dl> <dt><b>MAPI_LOGON_UI </b></dt> </dl>
///              </td> <td width="60%"> A dialog box should be displayed to prompt the user to log on if required. When the
///              MAPI_LOGON_UI flag is not set, the client application does not display a logon dialog box and returns an error
///              value if the user is not logged on. </td> </tr> <tr> <td width="40%"><a id="MAPI_NEW_SESSION_"></a><a
///              id="mapi_new_session_"></a><dl> <dt><b>MAPI_NEW_SESSION </b></dt> </dl> </td> <td width="60%"> An attempt should
///              be made to create a new session rather than acquire the environment's shared session. If the MAPI_NEW_SESSION
///              flag is not set, <b>MAPIAddress</b> uses an existing shared session. </td> </tr> </table>
///    ulReserved = Reserved; must be zero.
///    lpnNewRecips = Pointer to the number of entries in the <i>lppNewRecips</i> recipient output array. If the value of the
///                   <i>lpnNewRecips</i> parameter is zero, the <i>lppNewRecips</i> parameter is ignored.
///     = Pointer to an array of MapiRecipDesc structures containing the final list of recipients. This array is allocated
///       by <b>MAPIAddress</b>, cannot be <b>NULL</b>, and must be freed using MAPIFreeBuffer, even if there are no new
///       recipients. Recipients are grouped by recipient class in the following order: MAPI_TO, MAPI_CC, MAPI_BCC.
///Returns:
///    This function returns one of the following values. <table> <tr> <th>Return code</th> <th>Description</th> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>MAPI_E_FAILURE </b></dt> </dl> </td> <td width="60%"> One or more unspecified
///    errors occurred while addressing the message. No list of recipient entries was returned. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>MAPI_E_INSUFFICIENT_MEMORY </b></dt> </dl> </td> <td width="60%"> There was insufficient
///    memory to proceed. No list of recipient entries was returned. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>MAPI_E_INVALID_EDITFIELDS </b></dt> </dl> </td> <td width="60%"> The value of the <i>nEditFields</i>
///    parameter was outside the range of 0 through 4. No list of recipient entries was returned. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>MAPI_E_INVALID_RECIPS </b></dt> </dl> </td> <td width="60%"> One or more of the
///    recipients in the address list was not valid. No list of recipient entries was returned. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>MAPI_E_INVALID_SESSION </b></dt> </dl> </td> <td width="60%"> An invalid session handle
///    was used for the <i>lhSession</i> parameter. No list of recipient entries was returned. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>MAPI_E_LOGIN_FAILURE </b></dt> </dl> </td> <td width="60%"> There was no default logon,
///    and the user failed to log on successfully when the logon dialog box was displayed. No list of recipient entries
///    was returned. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>MAPI_E_NOT_SUPPORTED </b></dt> </dl> </td> <td
///    width="60%"> The operation was not supported by the underlying messaging system. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>MAPI_E_USER_ABORT </b></dt> </dl> </td> <td width="60%"> The user canceled one of the
///    dialog boxes. No list of recipient entries was returned. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>SUCCESS_SUCCESS </b></dt> </dl> </td> <td width="60%"> The call succeeded and a list of recipient entries
///    was returned. </td> </tr> </table>
///    
alias MAPIADDRESS = uint function(size_t lhSession, size_t ulUIParam, PSTR lpszCaption, uint nEditFields, 
                                  PSTR lpszLabels, uint nRecips, MapiRecipDesc* lpRecips, uint flFlags, 
                                  uint ulReserved, uint* lpnNewRecips, MapiRecipDesc** lppNewRecips);
///<p class="CCE_Message">[The use of this function is discouraged. It may be altered or unavailable in subsequent
///versions of Windows.] The <b>MAPIDetails</b> function displays a dialog box containing the details of a selected
///address list entry.
///Params:
///    lhSession = Session handle that represents a Simple MAPI session or zero. If the value of the <i>lhSession</i> parameter is
///                zero, MAPI logs on the user and creates a session that exists only for the duration of the call. This temporary
///                session can be an existing shared session or a new one. If additional information is required from the user to
///                successfully complete the logon, a dialog box is displayed.
///    ulUIParam = Parent window handle or zero, indicating that if a dialog box is displayed, it is application modal. If the
///                <i>ulUIParam</i> parameter contains a parent window handle, it is of type HWND (cast to a ULONG_PTR). If no
///                dialog box is displayed during the call, <i> ulUIParam</i> is ignored.
///    lpRecip = Pointer to the recipient for which details are to be displayed. <b>MAPIDetails</b> ignores all members of this
///              MapiRecipDesc structure except the <b>ulEIDSize</b> and <b>lpEntryID</b> members. If the value of
///              <b>ulEIDSize</b> is nonzero, <b>MAPIDetails</b> resolves the recipient entry. If the value of <b>ulEIDSize</b> is
///              zero, <b>MAPIDetails</b> returns the MAPI_E_AMBIGUOUS_RECIP value.
///    flFlags = Bitmask of option flags. The following flags can be set. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr>
///              <td width="40%"><a id="MAPI_AB_NOMODIFY_"></a><a id="mapi_ab_nomodify_"></a><dl> <dt><b>MAPI_AB_NOMODIFY
///              </b></dt> </dl> </td> <td width="60%"> The caller is requesting that the dialog box be read-only, prohibiting
///              changes. <b>MAPIDetails</b> might or might not honor the request. </td> </tr> <tr> <td width="40%"><a
///              id="MAPI_LOGON_UI_"></a><a id="mapi_logon_ui_"></a><dl> <dt><b>MAPI_LOGON_UI </b></dt> </dl> </td> <td
///              width="60%"> A dialog box should be displayed to prompt the user to log on if required. When the MAPI_LOGON_UI
///              flag is not set, the client application does not display a logon dialog box and returns an error value if the
///              user is not logged on. </td> </tr> <tr> <td width="40%"><a id="MAPI_NEW_SESSION_"></a><a
///              id="mapi_new_session_"></a><dl> <dt><b>MAPI_NEW_SESSION </b></dt> </dl> </td> <td width="60%"> An attempt should
///              be made to create a new session rather than acquire the environment's shared session. If the MAPI_NEW_SESSION
///              flag is not set, <b>MAPIDetails</b> uses an existing shared session. </td> </tr> </table>
///    ulReserved = Reserved; must be zero.
///Returns:
///    This function returns one of the following values. <table> <tr> <th>Return code</th> <th>Description</th> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>MAPI_E_AMBIGUOUS_RECIPIENT </b></dt> </dl> </td> <td width="60%"> The dialog
///    box could not be displayed because the <b>ulEIDSize</b> member of the structure pointed to by the <i>lpRecips</i>
///    parameter was zero. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>MAPI_E_FAILURE </b></dt> </dl> </td> <td
///    width="60%"> One or more unspecified errors occurred. No dialog box was displayed. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>MAPI_E_INSUFFICIENT_MEMORY </b></dt> </dl> </td> <td width="60%"> There was insufficient
///    memory to proceed. No dialog box was displayed. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>MAPI_E_INVALID_RECIPS </b></dt> </dl> </td> <td width="60%"> The recipient specified in the <i>lpRecip</i>
///    parameter was unknown or the recipient had an invalid <b>ulEIDSize</b> value. No dialog box was displayed. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>MAPI_E_LOGIN_FAILURE </b></dt> </dl> </td> <td width="60%"> There was no
///    default logon, and the user failed to log on successfully when the logon dialog box was displayed. No dialog box
///    was displayed. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>MAPI_E_NOT_SUPPORTED </b></dt> </dl> </td> <td
///    width="60%"> The operation was not supported by the underlying messaging system. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>MAPI_E_USER_ABORT </b></dt> </dl> </td> <td width="60%"> The user canceled either the
///    logon dialog box or the details dialog box. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>SUCCESS_SUCCESS
///    </b></dt> </dl> </td> <td width="60%"> The call succeeded and the details dialog box was displayed. </td> </tr>
///    </table>
///    
alias MAPIDETAILS = uint function(size_t lhSession, size_t ulUIParam, MapiRecipDesc* lpRecip, uint flFlags, 
                                  uint ulReserved);
///<p class="CCE_Message">[The use of this function is discouraged. It may be altered or unavailable in subsequent
///versions of Windows.] The <b>MAPIResolveName</b> function transforms a message recipient's name as entered by a user
///to an unambiguous address list entry.
///Params:
///    lhSession = Handle that represents a Simple MAPI session or zero. If the value of the <i>lhSession</i> parameter is zero,
///                MAPI logs on the user and creates a session that exists only for the duration of the call. This temporary session
///                can be an existing shared session or a new one. If necessary, the logon dialog box is displayed.
///    ulUIParam = Parent window handle or zero, indicating that if a dialog box is displayed, it is application modal. If the
///                <i>ulUIParam</i> parameter contains a parent window handle, it is of type <b>HWND</b> (cast to a
///                <b>ULONG_PTR</b>). If no dialog box is displayed during the call, <i> ulUIParam</i> is ignored.
///    lpszName = Pointer to the name to be resolved.
///    flFlags = Bitmask of option flags. The following flags can be set. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr>
///              <td width="40%"><a id="MAPI_AB_NOMODIFY_"></a><a id="mapi_ab_nomodify_"></a><dl> <dt><b>MAPI_AB_NOMODIFY
///              </b></dt> </dl> </td> <td width="60%"> The caller is requesting that the dialog box be read-only, prohibiting
///              changes. <b>MAPIResolveName</b> ignores this flag if MAPI_DIALOG is not set. </td> </tr> <tr> <td width="40%"><a
///              id="MAPI_DIALOG_"></a><a id="mapi_dialog_"></a><dl> <dt><b>MAPI_DIALOG </b></dt> </dl> </td> <td width="60%"> A
///              dialog box should be displayed for name resolution. If this flag is not set and the name cannot be resolved,
///              <b>MAPIResolveName</b> returns the MAPI_E_AMBIGUOUS_RECIPIENT value. </td> </tr> <tr> <td width="40%"><a
///              id="MAPI_LOGON_UI_"></a><a id="mapi_logon_ui_"></a><dl> <dt><b>MAPI_LOGON_UI </b></dt> </dl> </td> <td
///              width="60%"> A dialog box should be displayed to prompt the user to log on if required. When the MAPI_LOGON_UI
///              flag is not set, the client application does not display a logon dialog box and returns an error value if the
///              user is not logged on. </td> </tr> <tr> <td width="40%"><a id="MAPI_NEW_SESSION_"></a><a
///              id="mapi_new_session_"></a><dl> <dt><b>MAPI_NEW_SESSION </b></dt> </dl> </td> <td width="60%"> An attempt should
///              be made to create a new session rather than acquire the environment's shared session. If the MAPI_NEW_SESSION
///              flag is not set, <b>MAPIResolveName</b> uses an existing shared session. </td> </tr> </table>
///    ulReserved = Reserved; must be zero.
///     = Pointer to a recipient structure if the resolution results in a single match. The recipient structure contains
///       the resolved name and related information. Memory for this structure must be freed using the MAPIFreeBuffer
///       function.
///Returns:
///    This function returns one of the following values. <table> <tr> <th>Return code</th> <th>Description</th> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>MAPI_E_AMBIGUOUS_RECIPIENT </b></dt> </dl> </td> <td width="60%"> The recipient
///    requested has not been or could not be resolved to a unique address list entry. </td> </tr> <tr> <td width="40%">
///    <dl> <dt><b>MAPI_E_UNKNOWN_RECIPIENT </b></dt> </dl> </td> <td width="60%"> The recipient could not be resolved
///    to any address. The recipient might not exist or might be unknown. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>MAPI_E_FAILURE </b></dt> </dl> </td> <td width="60%"> One or more unspecified errors occurred. The name
///    was not resolved. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>MAPI_E_INSUFFICIENT_MEMORY </b></dt> </dl> </td>
///    <td width="60%"> There was insufficient memory to proceed. The name was not resolved. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>MAPI_E_LOGIN_FAILURE </b></dt> </dl> </td> <td width="60%"> There was no default logon,
///    and the user failed to log on successfully when the logon dialog box was displayed. The name was not resolved.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>MAPI_E_NOT_SUPPORTED </b></dt> </dl> </td> <td width="60%"> The
///    operation was not supported by the underlying messaging system. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>MAPI_E_USER_ABORT </b></dt> </dl> </td> <td width="60%"> The user canceled one of the dialog boxes. The
///    name was not resolved. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>SUCCESS_SUCCESS </b></dt> </dl> </td> <td
///    width="60%"> The call succeeded and the name was resolved. </td> </tr> </table>
///    
alias MAPIRESOLVENAME = uint function(size_t lhSession, size_t ulUIParam, PSTR lpszName, uint flFlags, 
                                      uint ulReserved, MapiRecipDesc** lppRecip);

// Structs


///A <b>MapiFileDesc</b> structure contains information about a file containing a message attachment stored as a
///temporary file. That file can contain a static OLE object, an embedded OLE object, an embedded message, and other
///types of files. For Unicode support, use the MapiFileDescW structure.
struct MapiFileDesc
{
    ///Reserved; must be zero.
    uint  ulReserved;
    ///Bitmask of option flags. The following flags can be set. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr>
    ///<td width="40%"><a id="MAPI_OLE"></a><a id="mapi_ole"></a><dl> <dt><b>MAPI_OLE</b></dt> </dl> </td> <td
    ///width="60%"> The attachment is an OLE object. If MAPI_OLE_STATIC is also set, the attachment is a static OLE
    ///object. If MAPI_OLE_STATIC is not set, the attachment is an embedded OLE object. </td> </tr> <tr> <td
    ///width="40%"><a id="MAPI_OLE_STATIC"></a><a id="mapi_ole_static"></a><dl> <dt><b>MAPI_OLE_STATIC</b></dt> </dl>
    ///</td> <td width="60%"> The attachment is a static OLE object. </td> </tr> </table> If neither flag is set, the
    ///attachment is treated as a data file.
    uint  flFlags;
    ///An integer used to indicate where in the message text to render the attachment. Attachments replace the character
    ///found at a certain position in the message text. That is, attachments replace the character in the MapiMessage
    ///structure field <b>NoteText</b>[<b>nPosition</b>]. A value of -1 (0xFFFFFFFF) means the attachment position is
    ///not indicated; the client application will have to provide a way for the user to access the attachment.
    uint  nPosition;
    ///Pointer to the fully qualified path of the attached file. This path should include the disk drive letter and
    ///directory name.
    PSTR  lpszPathName;
    ///Pointer to the attachment filename seen by the recipient, which may differ from the filename in the
    ///<b>lpszPathName</b> member if temporary files are being used. If the <b>lpszFileName</b> member is empty or
    ///<b>NULL</b>, the filename from <b>lpszPathName</b> is used.
    PSTR  lpszFileName;
    ///Pointer to the attachment file type, which can be represented with a MapiFileTagExt structure. A value of
    ///<b>NULL</b> indicates an unknown file type or a file type determined by the operating system.
    void* lpFileType;
}

///A <b>MapiFileDescW</b> structure contains information about a file containing a message attachment stored as a
///temporary file. That file can contain a static OLE object, an embedded OLE object, an embedded message, and other
///types of files.
struct MapiFileDescW
{
    ///Type: <b>ULONG</b> Reserved; must be 0.
    uint  ulReserved;
    ///Type: <b>ULONG</b> Bitmask of attachment flags. The following flags can be set. <table> <tr> <th>Value</th>
    ///<th>Meaning</th> </tr> <tr> <td width="40%"><a id="MAPI_OLE"></a><a id="mapi_ole"></a><dl>
    ///<dt><b>MAPI_OLE</b></dt> <dt>0x00000001</dt> </dl> </td> <td width="60%"> The attachment is an OLE object. If
    ///<b>MAPI_OLE_STATIC</b> is also set, the attachment is a static OLE object. If <b>MAPI_OLE_STATIC</b> is not set,
    ///the attachment is an embedded OLE object. </td> </tr> <tr> <td width="40%"><a id="MAPI_OLE_STATIC"></a><a
    ///id="mapi_ole_static"></a><dl> <dt><b>MAPI_OLE_STATIC</b></dt> <dt>0x00000002</dt> </dl> </td> <td width="60%">
    ///The attachment is a static OLE object. </td> </tr> </table> If neither flag is set, the attachment is treated as
    ///a data file.
    uint  flFlags;
    ///Type: <b>ULONG</b> An integer used to indicate where the attachment is rendered in the message text. The message
    ///text is stored in the <b>NoteText</b> member of the MapiMessageW structure, and the integer is used as an index
    ///to identify a specific character in the message string, <b>NoteText</b>[<b>nPosition</b>], that is replaced by
    ///the attachment. A value of -1 (0xFFFFFFFF) means the attachment position is not indicated and the client
    ///application must provide a way for the user to access the attachment.
    uint  nPosition;
    ///Type: <b>PWSTR</b> Pointer to the fully qualified path of the attached file. This path should include the disk
    ///drive letter and directory name.
    PWSTR lpszPathName;
    ///Type: <b>PWSTR</b> Pointer to the filename of the attachment as seen by the recipient. The filename that is seen
    ///by the recipient may differ from the filename in the <b>lpszPathName</b> member if temporary files are being
    ///used. If the <b>lpszFileName</b> member is empty or <b>NULL</b>, the filename from <b>lpszPathName</b> is used.
    PWSTR lpszFileName;
    ///Type: <b>PVOID</b> Pointer to the attachment file type, which can be represented with a MapiFileTagExt structure.
    ///A value of <b>NULL</b> indicates an unknown file type or a file type determined by the operating system.
    void* lpFileType;
}

///A <b>MapiFileTagExt</b> structure specifies a message attachment's type at its creation and its current form of
///encoding so that it can be restored to its original type at its destination.
struct MapiFileTagExt
{
    ///Type: <b>ULONG</b> Reserved; must be zero.
    uint   ulReserved;
    ///Type: <b>ULONG</b> The size, in bytes, of the value defined by the <b>lpTag</b> member.
    uint   cbTag;
    ///Type: <b>LPBYTE</b> Pointer to an X.400 object identifier indicating the type of the attachment in its original
    ///form, for example "Microsoft Excel worksheet".
    ubyte* lpTag;
    ///Type: <b>ULONG</b> The size, in bytes, of the value defined by the <b>lpEncoding</b> member.
    uint   cbEncoding;
    ///Type: <b>LPBYTE</b> Pointer to an X.400 object identifier indicating the form in which the attachment is
    ///currently encoded, for example MacBinary, UUENCODE, or binary.
    ubyte* lpEncoding;
}

///A <b>MapiRecipDesc</b> structure contains information about a message sender or recipient. For Unicode support, use
///the MapiRecipDescW structure.
struct MapiRecipDesc
{
    ///Reserved; must be zero.
    uint  ulReserved;
    ///Contains a numeric value that indicates the type of recipient. Possible values are as follow. <table> <tr>
    ///<th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="MAPI_ORIG"></a><a id="mapi_orig"></a><dl>
    ///<dt><b>MAPI_ORIG</b></dt> <dt>0</dt> </dl> </td> <td width="60%"> Indicates the original sender of the message.
    ///</td> </tr> <tr> <td width="40%"><a id="MAPI_TO"></a><a id="mapi_to"></a><dl> <dt><b>MAPI_TO</b></dt> <dt>1</dt>
    ///</dl> </td> <td width="60%"> Indicates a primary message recipient. </td> </tr> <tr> <td width="40%"><a
    ///id="MAPI_CC"></a><a id="mapi_cc"></a><dl> <dt><b>MAPI_CC</b></dt> <dt>2</dt> </dl> </td> <td width="60%">
    ///Indicates a recipient of a message copy. </td> </tr> <tr> <td width="40%"><a id="MAPI_BCC"></a><a
    ///id="mapi_bcc"></a><dl> <dt><b>MAPI_BCC</b></dt> <dt>3</dt> </dl> </td> <td width="60%"> Indicates a recipient of
    ///a blind copy. </td> </tr> </table>
    uint  ulRecipClass;
    ///Pointer to the display name of the message recipient or sender.
    PSTR  lpszName;
    ///Optional pointer to the recipient or sender's address; this address is provider-specific message delivery data.
    ///Generally, the messaging system provides such addresses for inbound messages. For outbound messages, the
    ///<b>lpszAddress</b> member can point to an address entered by the user for a recipient not in an address book
    ///(that is, a custom recipient). The format of the address is <i>address type</i>:<i>email address</i>. Examples of
    ///valid addresses are FAX:206-555-1212 and SMTP:M@X.COM.
    PSTR  lpszAddress;
    ///The size, in bytes, of the entry identifier pointed to by the <b>lpEntryID</b> member.
    uint  ulEIDSize;
    ///Pointer to an opaque entry identifier used by a messaging system service provider to identify the message
    ///recipient. Entry identifiers have meaning only for the service provider; client applications will not be able to
    ///decipher them. The messaging system uses this member to return valid entry identifiers for all recipients or
    ///senders listed in the address book.
    void* lpEntryID;
}

///A <b>MapiRecipDescW</b> structure contains information about a message sender or recipient.
struct MapiRecipDescW
{
    ///Reserved; must be zero.
    uint  ulReserved;
    ///Contains a numeric value that indicates the type of recipient. The following values are possible. <table> <tr>
    ///<th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="MAPI_ORIG"></a><a id="mapi_orig"></a><dl>
    ///<dt><b>MAPI_ORIG</b></dt> <dt>0</dt> </dl> </td> <td width="60%"> Indicates the original sender of the message.
    ///</td> </tr> <tr> <td width="40%"><a id="MAPI_TO"></a><a id="mapi_to"></a><dl> <dt><b>MAPI_TO</b></dt> <dt>1</dt>
    ///</dl> </td> <td width="60%"> Indicates a primary recipient of the message. </td> </tr> <tr> <td width="40%"><a
    ///id="MAPI_CC"></a><a id="mapi_cc"></a><dl> <dt><b>MAPI_CC</b></dt> <dt>2</dt> </dl> </td> <td width="60%">
    ///Indicates the recipient of a copy of the message. </td> </tr> <tr> <td width="40%"><a id="MAPI_BCC"></a><a
    ///id="mapi_bcc"></a><dl> <dt><b>MAPI_BCC</b></dt> <dt>3</dt> </dl> </td> <td width="60%"> Indicates the recipient
    ///of a blind copy of the message. </td> </tr> </table>
    uint  ulRecipClass;
    ///Pointer to the display name of the message recipient or sender.
    PWSTR lpszName;
    ///Optional pointer to the recipient or sender's address. This address contains provider-specific message delivery
    ///data. Generally, the messaging system provides such addresses for inbound messages. For outbound messages, the
    ///<b>lpszAddress</b> member can point to an address entered by the user for a recipient that is not in an address
    ///book (a custom recipient). The format of the address is <i>address type</i>:<i>email address</i>. Two examples of
    ///valid addresses are FAX:206-555-1212 and SMTP:M@X.COM.
    PWSTR lpszAddress;
    ///The size, in bytes, of the entry identifier pointed to by the <b>lpEntryID</b> member.
    uint  ulEIDSize;
    ///Pointer to an entry identifier that cannot be deciphered by client applications and that is used by a messaging
    ///system service provider to identify the message recipient. These entry identifiers have meaning only for the
    ///service provider. The messaging system uses this member to return valid entry identifiers for all recipients or
    ///senders listed in the address book.
    void* lpEntryID;
}

///A <b>MapiMessage</b> structure contains information about a message. For Unicode support, use the MapiMessageW
///structure.
struct MapiMessage
{
    ///Reserved; must be zero or <b>CP_UTF8</b>. If <b>CP_UTF8</b>, the following are UTF-8 instead of ANSI strings:
    ///<b>lpszSubject</b>, <b>lpszNoteText</b>, <b>lpszMessageType</b>, <b>lpszDateReceived</b>,
    ///<b>lpszConversationID</b>.
    uint           ulReserved;
    ///Pointer to the text string describing the message subject, typically limited to 256 characters or less. If this
    ///member is empty or <b>NULL</b>, the user has not entered subject text.
    PSTR           lpszSubject;
    ///Pointer to a string containing the message text. If this member is empty or <b>NULL</b>, there is no message
    ///text.
    PSTR           lpszNoteText;
    ///Pointer to a string indicating a non-IPM type of message. Client applications can select message types for their
    ///non-IPM messages. Clients that only support IPM messages can ignore the <b>lpszMessageType</b> member when
    ///reading messages and set it to empty or <b>NULL</b> when sending messages.
    PSTR           lpszMessageType;
    ///Pointer to a string indicating the date when the message was received. The format is YYYY/MM/DD HH:MM, using a
    ///24-hour clock.
    PSTR           lpszDateReceived;
    ///Pointer to a string identifying the conversation thread to which the message belongs. Some messaging systems can
    ///ignore and not return this member.
    PSTR           lpszConversationID;
    ///Bitmask of message status flags. The following flags can be set. <table> <tr> <th>Value</th> <th>Meaning</th>
    ///</tr> <tr> <td width="40%"><a id="MAPI_RECEIPT_REQUESTED"></a><a id="mapi_receipt_requested"></a><dl>
    ///<dt><b>MAPI_RECEIPT_REQUESTED</b></dt> </dl> </td> <td width="60%"> A receipt notification is requested. Client
    ///applications set this flag when sending a message. </td> </tr> <tr> <td width="40%"><a id="MAPI_SENT"></a><a
    ///id="mapi_sent"></a><dl> <dt><b>MAPI_SENT</b></dt> </dl> </td> <td width="60%"> The message has been sent. </td>
    ///</tr> <tr> <td width="40%"><a id="MAPI_UNREAD"></a><a id="mapi_unread"></a><dl> <dt><b>MAPI_UNREAD</b></dt> </dl>
    ///</td> <td width="60%"> The message has not been read. </td> </tr> </table>
    uint           flFlags;
    ///Pointer to a MapiRecipDesc structure containing information about the sender of the message.
    MapiRecipDesc* lpOriginator;
    ///The number of message recipient structures in the array pointed to by the <b>lpRecips</b> member. A value of zero
    ///indicates no recipients are included.
    uint           nRecipCount;
    ///Pointer to an array of MapiRecipDesc structures, each containing information about a message recipient.
    MapiRecipDesc* lpRecips;
    ///The number of structures describing file attachments in the array pointed to by the <b>lpFiles</b> member. A
    ///value of zero indicates no file attachments are included.
    uint           nFileCount;
    ///Pointer to an array of MapiFileDesc structures, each containing information about a file attachment.
    MapiFileDesc*  lpFiles;
}

///A <b>MapiMessageW</b> structure contains information about a message.
struct MapiMessageW
{
    ///Type: <b>ULONG</b> Reserved; must be zero.
    uint            ulReserved;
    ///Type: <b>PWSTR</b> Pointer to the text string describing the message subject, typically limited to 256 characters
    ///or less. If this member is empty or <b>NULL</b>, there is no subject text.
    PWSTR           lpszSubject;
    ///Type: <b>PWSTR</b> Pointer to a string containing the message text. If this member is empty or <b>NULL</b>, there
    ///is no message text.
    PWSTR           lpszNoteText;
    ///Type: <b>PWSTR</b> Pointer to a string that indicates the message type of when the message is not an IPM. If your
    ///Client supports Interpersonal Messages (IPMs) exclusively, set the <b>lpszMessageType</b> member to empty or
    ///<b>NULL</b> when sending messages and ignore the member when reading messages.
    PWSTR           lpszMessageType;
    ///Type: <b>PWSTR</b> Pointer to a string indicating the date when the message was received. The format is
    ///<i>YYYY</i>/<i>MM</i>/<i>DD</i><i>HH</i>:<i>MM</i>, using a 24-hour clock.
    PWSTR           lpszDateReceived;
    ///Type: <b>PWSTR</b> Pointer to a string identifying the conversation thread to which the message belongs. Some
    ///messaging systems ignore this member.
    PWSTR           lpszConversationID;
    ///Type: <b>FLAGS</b> Bitmask of message status flags. The following flags can be set. <table> <tr> <th>Value</th>
    ///<th>Meaning</th> </tr> <tr> <td width="40%"><a id="MAPI_RECEIPT_REQUESTED"></a><a
    ///id="mapi_receipt_requested"></a><dl> <dt><b>MAPI_RECEIPT_REQUESTED</b></dt> <dt>0x00000002</dt> </dl> </td> <td
    ///width="60%"> A receipt notification is requested. Client applications set this flag when sending a message. </td>
    ///</tr> <tr> <td width="40%"><a id="MAPI_SENT"></a><a id="mapi_sent"></a><dl> <dt><b>MAPI_SENT</b></dt>
    ///<dt>0x00000004</dt> </dl> </td> <td width="60%"> The message has been sent. </td> </tr> <tr> <td width="40%"><a
    ///id="MAPI_UNREAD"></a><a id="mapi_unread"></a><dl> <dt><b>MAPI_UNREAD</b></dt> <dt>0x00000001</dt> </dl> </td> <td
    ///width="60%"> The message has not been read. </td> </tr> </table>
    uint            flFlags;
    ///Type: <b>lpMapiRecipDescW</b> Pointer to a MapiRecipDescW structure containing information about the sender of
    ///the message.
    MapiRecipDescW* lpOriginator;
    ///Type: <b>ULONG</b> The number of MapiRecipDescW structures in the array pointed to by the <b>lpRecips</b> member.
    ///If this member is zero, there are no recipients.
    uint            nRecipCount;
    ///Type: <b>lpMapiRecipDescW</b> Pointer to an array of MapiRecipDescW structures. Each structure contains
    ///information about one recipient.
    MapiRecipDescW* lpRecips;
    ///Type: <b>ULONG</b> The number of MapiFileDescW structures in the array pointed to by the <b>lpFiles</b> member.
    ///If this member is zero, there are no file attachments.
    uint            nFileCount;
    ///Type: <b>lpMapiFileDescW</b> Pointer to an array of MapiFileDescW structures. Each structure contains information
    ///about one file attachment.
    MapiFileDescW*  lpFiles;
}

// Functions

///<p class="CCE_Message">[The use of this function is discouraged. It may be altered or unavailable in subsequent
///versions of Windows.] The <b>MAPIFreeBuffer</b> function frees memory allocated by the messaging system.
///Params:
///    pv = Pointer to memory allocated by the messaging system. This pointer is returned by the MAPIReadMail, MAPIAddress,
///         and MAPIResolveName functions.
///Returns:
///    This function returns one of the following values. <table> <tr> <th>Return code</th> <th>Description</th> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>MAPI_E_FAILURE </b></dt> </dl> </td> <td width="60%"> One or more unspecified
///    errors occurred. The memory could not be freed. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>SUCCESS_SUCCESS
///    </b></dt> </dl> </td> <td width="60%"> The call succeeded and the memory was freed. </td> </tr> </table>
///    
@DllImport("MAPI32")
uint MAPIFreeBuffer(void* pv);


