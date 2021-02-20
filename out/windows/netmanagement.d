// Written in the D programming language.

module windows.netmanagement;

public import windows.core;
public import windows.com : HRESULT;
public import windows.security : CERT_CONTEXT, SID_NAME_USE;
public import windows.systemservices : BOOL, PWSTR;
public import windows.windowsprogramming : FILETIME;

extern(Windows) @nogc nothrow:


// Enums


alias NET_VALIDATE_PASSWORD_TYPE = int;
enum : int
{
    NetValidateAuthentication = 0x00000001,
    NetValidatePasswordChange = 0x00000002,
    NetValidatePasswordReset  = 0x00000003,
}

alias NETSETUP_NAME_TYPE = int;
enum : int
{
    NetSetupUnknown           = 0x00000000,
    NetSetupMachine           = 0x00000001,
    NetSetupWorkgroup         = 0x00000002,
    NetSetupDomain            = 0x00000003,
    NetSetupNonExistentDomain = 0x00000004,
    NetSetupDnsMachine        = 0x00000005,
}

///Specifies the possible ways that a device can be joined to Microsoft Azure Active Directory.
alias DSREG_JOIN_TYPE = int;
enum : int
{
    ///The type of join is not known.
    DSREG_UNKNOWN_JOIN   = 0x00000000,
    ///The device is joined to Azure Active Directory (Azure AD).
    DSREG_DEVICE_JOIN    = 0x00000001,
    DSREG_WORKPLACE_JOIN = 0x00000002,
}

alias NET_COMPUTER_NAME_TYPE = int;
enum : int
{
    NetPrimaryComputerName    = 0x00000000,
    NetAlternateComputerNames = 0x00000001,
    NetAllComputerNames       = 0x00000002,
    NetComputerNameTypeMax    = 0x00000003,
}

alias NETSETUP_JOIN_STATUS = int;
enum : int
{
    NetSetupUnknownStatus = 0x00000000,
    NetSetupUnjoined      = 0x00000001,
    NetSetupWorkgroupName = 0x00000002,
    NetSetupDomainName    = 0x00000003,
}

alias TRANSPORT_TYPE = int;
enum : int
{
    UseTransportType_None = 0x00000000,
    UseTransportType_Wsk  = 0x00000001,
    UseTransportType_Quic = 0x00000002,
}

// Structs


///The <b>USER_INFO_0</b> structure contains a user account name.
struct USER_INFO_0
{
    ///Pointer to a Unicode string that specifies the name of the user account. For the NetUserSetInfo function, this
    ///member specifies the name of the user.
    PWSTR usri0_name;
}

///The <b>USER_INFO_1</b> structure contains information about a user account, including account name, password data,
///privilege level, and the path to the user's home directory.
struct USER_INFO_1
{
    ///Type: <b>LPWSTR</b> A pointer to a Unicode string that specifies the name of the user account. For the
    ///NetUserSetInfo function, this member is ignored. For more information, see the following Remarks section.
    PWSTR usri1_name;
    ///Type: <b>LPWSTR</b> A pointer to a Unicode string that specifies the password of the user indicated by the
    ///<b>usri1_name</b> member. The length cannot exceed PWLEN bytes. The NetUserEnum and NetUserGetInfo functions
    ///return a <b>NULL</b> pointer to maintain password security. By convention, the length of passwords is limited to
    ///LM20_PWLEN characters.
    PWSTR usri1_password;
    ///Type: <b>DWORD</b> The number of seconds that have elapsed since the <b>usri1_password</b> member was last
    ///changed. The NetUserAdd and NetUserSetInfo functions ignore this member.
    uint  usri1_password_age;
    ///Type: <b>DWORD</b> The level of privilege assigned to the <b>usri1_name</b> member. When you call the NetUserAdd
    ///function, this member must be USER_PRIV_USER. When you call the NetUserSetInfo function, this member must be the
    ///value returned by the <b>NetUserGetInfo</b> function or the <b>NetUserEnum</b> function. This member can be one
    ///of the following values. For more information about user and group account rights, see Privileges. <table> <tr>
    ///<th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="USER_PRIV_GUEST"></a><a
    ///id="user_priv_guest"></a><dl> <dt><b>USER_PRIV_GUEST</b></dt> </dl> </td> <td width="60%"> Guest </td> </tr> <tr>
    ///<td width="40%"><a id="USER_PRIV_USER"></a><a id="user_priv_user"></a><dl> <dt><b>USER_PRIV_USER</b></dt> </dl>
    ///</td> <td width="60%"> User </td> </tr> <tr> <td width="40%"><a id="USER_PRIV_ADMIN"></a><a
    ///id="user_priv_admin"></a><dl> <dt><b>USER_PRIV_ADMIN</b></dt> </dl> </td> <td width="60%"> Administrator </td>
    ///</tr> </table>
    uint  usri1_priv;
    ///Type: <b>LPWSTR</b> A pointer to a Unicode string specifying the path of the home directory for the user
    ///specified in the <b>usri1_name</b> member. The string can be <b>NULL</b>.
    PWSTR usri1_home_dir;
    ///Type: <b>LPWSTR</b> A pointer to a Unicode string that contains a comment to associate with the user account.
    ///This string can be a <b>NULL</b> string, or it can have any number of characters before the terminating null
    ///character.
    PWSTR usri1_comment;
    ///Type: <b>DWORD</b> This member can be one or more of the following values. Note that setting user account control
    ///flags may require certain privileges and control access rights. For more information, see the Remarks section of
    ///the NetUserSetInfo function. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
    ///id="UF_SCRIPT"></a><a id="uf_script"></a><dl> <dt><b>UF_SCRIPT</b></dt> </dl> </td> <td width="60%"> The logon
    ///script executed. This value must be set. </td> </tr> <tr> <td width="40%"><a id="UF_ACCOUNTDISABLE"></a><a
    ///id="uf_accountdisable"></a><dl> <dt><b>UF_ACCOUNTDISABLE</b></dt> </dl> </td> <td width="60%"> The user's account
    ///is disabled. </td> </tr> <tr> <td width="40%"><a id="UF_HOMEDIR_REQUIRED"></a><a
    ///id="uf_homedir_required"></a><dl> <dt><b>UF_HOMEDIR_REQUIRED</b></dt> </dl> </td> <td width="60%"> The home
    ///directory is required. This value is ignored. </td> </tr> <tr> <td width="40%"><a id="UF_PASSWD_NOTREQD"></a><a
    ///id="uf_passwd_notreqd"></a><dl> <dt><b>UF_PASSWD_NOTREQD</b></dt> </dl> </td> <td width="60%"> No password is
    ///required. </td> </tr> <tr> <td width="40%"><a id="UF_PASSWD_CANT_CHANGE"></a><a
    ///id="uf_passwd_cant_change"></a><dl> <dt><b>UF_PASSWD_CANT_CHANGE</b></dt> </dl> </td> <td width="60%"> The user
    ///cannot change the password. </td> </tr> <tr> <td width="40%"><a id="UF_LOCKOUT"></a><a id="uf_lockout"></a><dl>
    ///<dt><b>UF_LOCKOUT</b></dt> </dl> </td> <td width="60%"> The account is currently locked out. You can call the
    ///NetUserSetInfo function and clear this value to unlock a previously locked account. You cannot use this value to
    ///lock a previously unlocked account. </td> </tr> <tr> <td width="40%"><a id="UF_DONT_EXPIRE_PASSWD"></a><a
    ///id="uf_dont_expire_passwd"></a><dl> <dt><b>UF_DONT_EXPIRE_PASSWD</b></dt> </dl> </td> <td width="60%"> The
    ///password should never expire on the account. </td> </tr> <tr> <td width="40%"><a
    ///id="UF_ENCRYPTED_TEXT_PASSWORD_ALLOWED"></a><a id="uf_encrypted_text_password_allowed"></a><dl>
    ///<dt><b>UF_ENCRYPTED_TEXT_PASSWORD_ALLOWED</b></dt> </dl> </td> <td width="60%"> The user's password is stored
    ///under reversible encryption in the Active Directory. </td> </tr> <tr> <td width="40%"><a
    ///id="UF_NOT_DELEGATED"></a><a id="uf_not_delegated"></a><dl> <dt><b>UF_NOT_DELEGATED</b></dt> </dl> </td> <td
    ///width="60%"> Marks the account as "sensitive"; other users cannot act as delegates of this user account. </td>
    ///</tr> <tr> <td width="40%"><a id="UF_SMARTCARD_REQUIRED"></a><a id="uf_smartcard_required"></a><dl>
    ///<dt><b>UF_SMARTCARD_REQUIRED</b></dt> </dl> </td> <td width="60%"> Requires the user to log on to the user
    ///account with a smart card. </td> </tr> <tr> <td width="40%"><a id="UF_USE_DES_KEY_ONLY"></a><a
    ///id="uf_use_des_key_only"></a><dl> <dt><b>UF_USE_DES_KEY_ONLY</b></dt> </dl> </td> <td width="60%"> Restrict this
    ///principal to use only Data Encryption Standard (DES) encryption types for keys. </td> </tr> <tr> <td
    ///width="40%"><a id="UF_DONT_REQUIRE_PREAUTH"></a><a id="uf_dont_require_preauth"></a><dl>
    ///<dt><b>UF_DONT_REQUIRE_PREAUTH</b></dt> </dl> </td> <td width="60%"> This account does not require Kerberos
    ///preauthentication for logon. </td> </tr> <tr> <td width="40%"><a id="UF_TRUSTED_FOR_DELEGATION"></a><a
    ///id="uf_trusted_for_delegation"></a><dl> <dt><b>UF_TRUSTED_FOR_DELEGATION</b></dt> </dl> </td> <td width="60%">
    ///The account is enabled for delegation. This is a security-sensitive setting; accounts with this option enabled
    ///should be tightly controlled. This setting allows a service running under the account to assume a client's
    ///identity and authenticate as that user to other remote servers on the network. </td> </tr> <tr> <td
    ///width="40%"><a id="UF_PASSWORD_EXPIRED"></a><a id="uf_password_expired"></a><dl>
    ///<dt><b>UF_PASSWORD_EXPIRED</b></dt> </dl> </td> <td width="60%"> The user's password has expired. <b>Windows
    ///2000: </b>This value is not supported. </td> </tr> <tr> <td width="40%"><a
    ///id="UF_TRUSTED_TO_AUTHENTICATE_FOR_DELEGATION"></a><a id="uf_trusted_to_authenticate_for_delegation"></a><dl>
    ///<dt><b>UF_TRUSTED_TO_AUTHENTICATE_FOR_DELEGATION</b></dt> </dl> </td> <td width="60%"> The account is trusted to
    ///authenticate a user outside of the Kerberos security package and delegate that user through constrained
    ///delegation. This is a security-sensitive setting; accounts with this option enabled should be tightly controlled.
    ///This setting allows a service running under the account to assert a client's identity and authenticate as that
    ///user to specifically configured services on the network. <b>Windows 2000: </b>This value is not supported. </td>
    ///</tr> </table> The following values describe the account type. Only one value can be set. You cannot change the
    ///account type using the NetUserSetInfo function. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td
    ///width="40%"><a id="UF_NORMAL_ACCOUNT"></a><a id="uf_normal_account"></a><dl> <dt><b>UF_NORMAL_ACCOUNT</b></dt>
    ///</dl> </td> <td width="60%"> This is a default account type that represents a typical user. </td> </tr> <tr> <td
    ///width="40%"><a id="UF_TEMP_DUPLICATE_ACCOUNT"></a><a id="uf_temp_duplicate_account"></a><dl>
    ///<dt><b>UF_TEMP_DUPLICATE_ACCOUNT</b></dt> </dl> </td> <td width="60%"> This is an account for users whose primary
    ///account is in another domain. This account provides user access to this domain, but not to any domain that trusts
    ///this domain. The User Manager refers to this account type as a local user account. </td> </tr> <tr> <td
    ///width="40%"><a id="UF_WORKSTATION_TRUST_ACCOUNT"></a><a id="uf_workstation_trust_account"></a><dl>
    ///<dt><b>UF_WORKSTATION_TRUST_ACCOUNT</b></dt> </dl> </td> <td width="60%"> This is a computer account for a
    ///computer that is a member of this domain. </td> </tr> <tr> <td width="40%"><a id="UF_SERVER_TRUST_ACCOUNT"></a><a
    ///id="uf_server_trust_account"></a><dl> <dt><b>UF_SERVER_TRUST_ACCOUNT</b></dt> </dl> </td> <td width="60%"> This
    ///is a computer account for a backup domain controller that is a member of this domain. </td> </tr> <tr> <td
    ///width="40%"><a id="UF_INTERDOMAIN_TRUST_ACCOUNT"></a><a id="uf_interdomain_trust_account"></a><dl>
    ///<dt><b>UF_INTERDOMAIN_TRUST_ACCOUNT</b></dt> </dl> </td> <td width="60%"> This is a permit to trust account for a
    ///domain that trusts other domains. </td> </tr> </table>
    uint  usri1_flags;
    ///Type: <b>LPWSTR</b> A pointer to a Unicode string specifying the path for the user's logon script file. The
    ///script file can be a .CMD file, an .EXE file, or a .BAT file. The string can also be <b>NULL</b>.
    PWSTR usri1_script_path;
}

///The <b>USER_INFO_2</b> structure contains information about a user account, including the account name, password
///data, privilege level, the path to the user's home directory, and other user-related network statistics.
struct USER_INFO_2
{
    ///Type: <b>LPWSTR</b> A pointer to a Unicode string that specifies the name of the user account. Calls to the
    ///NetUserSetInfo function ignore this member. For more information, see the following Remarks section.
    PWSTR  usri2_name;
    ///Type: <b>LPWSTR</b> A pointer to a Unicode string that specifies the password for the user identified by the
    ///<b>usri2_name</b> member. The length cannot exceed PWLEN bytes. The NetUserEnum and NetUserGetInfo functions
    ///return a <b>NULL</b> pointer to maintain password security. By convention, the length of passwords is limited to
    ///LM20_PWLEN characters.
    PWSTR  usri2_password;
    ///Type: <b>DWORD</b> The number of seconds that have elapsed since the <b>usri2_password</b> member was last
    ///changed. The NetUserAdd and NetUserSetInfo functions ignore this member.
    uint   usri2_password_age;
    ///Type: <b>DWORD</b> The level of privilege assigned to the <b>usri2_name</b> member. For calls to the NetUserAdd
    ///function, this member must be USER_PRIV_USER. For the NetUserSetInfo function, this member must be the value
    ///returned by the <b>NetUserGetInfo</b> function or the <b>NetUserEnum</b> function. This member can be one of the
    ///following values. For more information about user and group account rights, see Privileges. <table> <tr>
    ///<th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="USER_PRIV_GUEST"></a><a
    ///id="user_priv_guest"></a><dl> <dt><b>USER_PRIV_GUEST</b></dt> </dl> </td> <td width="60%"> Guest </td> </tr> <tr>
    ///<td width="40%"><a id="USER_PRIV_USER"></a><a id="user_priv_user"></a><dl> <dt><b>USER_PRIV_USER</b></dt> </dl>
    ///</td> <td width="60%"> User </td> </tr> <tr> <td width="40%"><a id="USER_PRIV_ADMIN"></a><a
    ///id="user_priv_admin"></a><dl> <dt><b>USER_PRIV_ADMIN</b></dt> </dl> </td> <td width="60%"> Administrator </td>
    ///</tr> </table>
    uint   usri2_priv;
    ///Type: <b>LPWSTR</b> A pointer to a Unicode string specifying the path of the home directory for the user
    ///specified by the <b>usri2_name</b> member. The string can be <b>NULL</b>.
    PWSTR  usri2_home_dir;
    ///Type: <b>LPWSTR</b> A pointer to a Unicode string that contains a comment to associate with the user account. The
    ///string can be a <b>NULL</b> string, or it can have any number of characters before the terminating null
    ///character.
    PWSTR  usri2_comment;
    ///Type: <b>DWORD</b> This member can be one or more of the following values. Note that setting user account control
    ///flags may require certain privileges and control access rights. For more information, see the Remarks section of
    ///the NetUserSetInfo function. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
    ///id="UF_SCRIPT"></a><a id="uf_script"></a><dl> <dt><b>UF_SCRIPT</b></dt> </dl> </td> <td width="60%"> The logon
    ///script executed. This value must be set. </td> </tr> <tr> <td width="40%"><a id="UF_ACCOUNTDISABLE"></a><a
    ///id="uf_accountdisable"></a><dl> <dt><b>UF_ACCOUNTDISABLE</b></dt> </dl> </td> <td width="60%"> The user's account
    ///is disabled. </td> </tr> <tr> <td width="40%"><a id="UF_HOMEDIR_REQUIRED"></a><a
    ///id="uf_homedir_required"></a><dl> <dt><b>UF_HOMEDIR_REQUIRED</b></dt> </dl> </td> <td width="60%"> The home
    ///directory is required. This value is ignored. </td> </tr> <tr> <td width="40%"><a id="UF_PASSWD_NOTREQD"></a><a
    ///id="uf_passwd_notreqd"></a><dl> <dt><b>UF_PASSWD_NOTREQD</b></dt> </dl> </td> <td width="60%"> No password is
    ///required. </td> </tr> <tr> <td width="40%"><a id="UF_PASSWD_CANT_CHANGE"></a><a
    ///id="uf_passwd_cant_change"></a><dl> <dt><b>UF_PASSWD_CANT_CHANGE</b></dt> </dl> </td> <td width="60%"> The user
    ///cannot change the password. </td> </tr> <tr> <td width="40%"><a id="UF_LOCKOUT"></a><a id="uf_lockout"></a><dl>
    ///<dt><b>UF_LOCKOUT</b></dt> </dl> </td> <td width="60%"> The account is currently locked out. You can call the
    ///NetUserSetInfo function to clear this value and unlock a previously locked account. You cannot use this value to
    ///lock a previously unlocked account. </td> </tr> <tr> <td width="40%"><a id="UF_DONT_EXPIRE_PASSWD"></a><a
    ///id="uf_dont_expire_passwd"></a><dl> <dt><b>UF_DONT_EXPIRE_PASSWD</b></dt> </dl> </td> <td width="60%"> The
    ///password should never expire on the account. </td> </tr> <tr> <td width="40%"><a
    ///id="UF_ENCRYPTED_TEXT_PASSWORD_ALLOWED"></a><a id="uf_encrypted_text_password_allowed"></a><dl>
    ///<dt><b>UF_ENCRYPTED_TEXT_PASSWORD_ALLOWED</b></dt> </dl> </td> <td width="60%"> The user's password is stored
    ///under reversible encryption in the Active Directory. </td> </tr> <tr> <td width="40%"><a
    ///id="UF_NOT_DELEGATED"></a><a id="uf_not_delegated"></a><dl> <dt><b>UF_NOT_DELEGATED</b></dt> </dl> </td> <td
    ///width="60%"> Marks the account as "sensitive"; other users cannot act as delegates of this user account. </td>
    ///</tr> <tr> <td width="40%"><a id="UF_SMARTCARD_REQUIRED"></a><a id="uf_smartcard_required"></a><dl>
    ///<dt><b>UF_SMARTCARD_REQUIRED</b></dt> </dl> </td> <td width="60%"> Requires the user to log on to the user
    ///account with a smart card. </td> </tr> <tr> <td width="40%"><a id="UF_USE_DES_KEY_ONLY"></a><a
    ///id="uf_use_des_key_only"></a><dl> <dt><b>UF_USE_DES_KEY_ONLY</b></dt> </dl> </td> <td width="60%"> Restrict this
    ///principal to use only Data Encryption Standard (DES) encryption types for keys. </td> </tr> <tr> <td
    ///width="40%"><a id="UF_DONT_REQUIRE_PREAUTH"></a><a id="uf_dont_require_preauth"></a><dl>
    ///<dt><b>UF_DONT_REQUIRE_PREAUTH</b></dt> </dl> </td> <td width="60%"> This account does not require Kerberos
    ///preauthentication for logon. </td> </tr> <tr> <td width="40%"><a id="UF_TRUSTED_FOR_DELEGATION"></a><a
    ///id="uf_trusted_for_delegation"></a><dl> <dt><b>UF_TRUSTED_FOR_DELEGATION</b></dt> </dl> </td> <td width="60%">
    ///The account is enabled for delegation. This is a security-sensitive setting; accounts with this option enabled
    ///should be tightly controlled. This setting allows a service running under the account to assume a client's
    ///identity and authenticate as that user to other remote servers on the network. </td> </tr> <tr> <td
    ///width="40%"><a id="UF_PASSWORD_EXPIRED"></a><a id="uf_password_expired"></a><dl>
    ///<dt><b>UF_PASSWORD_EXPIRED</b></dt> </dl> </td> <td width="60%"> The user's password has expired. <b>Windows
    ///2000: </b>This value is not supported. </td> </tr> <tr> <td width="40%"><a
    ///id="UF_TRUSTED_TO_AUTHENTICATE_FOR_DELEGATION"></a><a id="uf_trusted_to_authenticate_for_delegation"></a><dl>
    ///<dt><b>UF_TRUSTED_TO_AUTHENTICATE_FOR_DELEGATION</b></dt> </dl> </td> <td width="60%"> The account is trusted to
    ///authenticate a user outside of the Kerberos security package and delegate that user through constrained
    ///delegation. This is a security-sensitive setting; accounts with this option enabled should be tightly controlled.
    ///This setting allows a service running under the account to assert a client's identity and authenticate as that
    ///user to specifically configured services on the network. <b>Windows XP/2000: </b>This value is not supported.
    ///</td> </tr> </table> The following values describe the account type. Only one value can be set. You cannot change
    ///the account type using the NetUserSetInfo function. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td
    ///width="40%"><a id="UF_NORMAL_ACCOUNT"></a><a id="uf_normal_account"></a><dl> <dt><b>UF_NORMAL_ACCOUNT</b></dt>
    ///</dl> </td> <td width="60%"> This is a default account type that represents a typical user. </td> </tr> <tr> <td
    ///width="40%"><a id="UF_TEMP_DUPLICATE_ACCOUNT"></a><a id="uf_temp_duplicate_account"></a><dl>
    ///<dt><b>UF_TEMP_DUPLICATE_ACCOUNT</b></dt> </dl> </td> <td width="60%"> This is an account for users whose primary
    ///account is in another domain. This account provides user access to this domain, but not to any domain that trusts
    ///this domain. The User Manager refers to this account type as a local user account. </td> </tr> <tr> <td
    ///width="40%"><a id="UF_WORKSTATION_TRUST_ACCOUNT"></a><a id="uf_workstation_trust_account"></a><dl>
    ///<dt><b>UF_WORKSTATION_TRUST_ACCOUNT</b></dt> </dl> </td> <td width="60%"> This is a computer account for a
    ///computer that is a member of this domain. </td> </tr> <tr> <td width="40%"><a id="UF_SERVER_TRUST_ACCOUNT"></a><a
    ///id="uf_server_trust_account"></a><dl> <dt><b>UF_SERVER_TRUST_ACCOUNT</b></dt> </dl> </td> <td width="60%"> This
    ///is a computer account for a backup domain controller that is a member of this domain. </td> </tr> <tr> <td
    ///width="40%"><a id="UF_INTERDOMAIN_TRUST_ACCOUNT"></a><a id="uf_interdomain_trust_account"></a><dl>
    ///<dt><b>UF_INTERDOMAIN_TRUST_ACCOUNT</b></dt> </dl> </td> <td width="60%"> This is a permit to trust account for a
    ///domain that trusts other domains. </td> </tr> </table>
    uint   usri2_flags;
    ///Type: <b>LPWSTR</b> A pointer to a Unicode string specifying the path for the user's logon script file. The
    ///script file can be a .CMD file, an .EXE file, or a .BAT file. The string can also be <b>NULL</b>.
    PWSTR  usri2_script_path;
    ///Type: <b>DWORD</b> The user's operator privileges. Calls to the <b>NetUserGetInfo</b> and <b>NetUserEnum</b>
    ///functions return a value based on the user's local group membership. If the user is a member of Print Operators,
    ///AF_OP_PRINT is set. If the user is a member of Server Operators, AF_OP_SERVER is set. If the user is a member of
    ///the Account Operators, AF_OP_ACCOUNTS is set. AF_OP_COMM is never set. For more information about user and group
    ///account rights, see Privileges. The following restrictions apply: <ul> <li>When you call the NetUserAdd function,
    ///this member must be zero.</li> <li>When you call the NetUserSetInfo function, this member must be the value
    ///returned from a call to NetUserGetInfo or to NetUserEnum.</li> </ul> This member can be one or more of the
    ///following values. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
    ///id="AF_OP_PRINT"></a><a id="af_op_print"></a><dl> <dt><b>AF_OP_PRINT</b></dt> </dl> </td> <td width="60%"> The
    ///print operator privilege is enabled. </td> </tr> <tr> <td width="40%"><a id="AF_OP_COMM"></a><a
    ///id="af_op_comm"></a><dl> <dt><b>AF_OP_COMM</b></dt> </dl> </td> <td width="60%"> The communications operator
    ///privilege is enabled. </td> </tr> <tr> <td width="40%"><a id="AF_OP_SERVER"></a><a id="af_op_server"></a><dl>
    ///<dt><b>AF_OP_SERVER</b></dt> </dl> </td> <td width="60%"> The server operator privilege is enabled. </td> </tr>
    ///<tr> <td width="40%"><a id="AF_OP_ACCOUNTS"></a><a id="af_op_accounts"></a><dl> <dt><b>AF_OP_ACCOUNTS</b></dt>
    ///</dl> </td> <td width="60%"> The accounts operator privilege is enabled. </td> </tr> </table>
    uint   usri2_auth_flags;
    ///Type: <b>LPWSTR</b> A pointer to a Unicode string that contains the full name of the user. This string can be a
    ///<b>NULL</b> string, or it can have any number of characters before the terminating null character.
    PWSTR  usri2_full_name;
    ///Type: <b>LPWSTR</b> A pointer to a Unicode string that contains a user comment. This string can be a <b>NULL</b>
    ///string, or it can have any number of characters before the terminating null character.
    PWSTR  usri2_usr_comment;
    ///Type: <b>LPWSTR</b> A pointer to a Unicode string that is reserved for use by applications. This string can be a
    ///<b>NULL</b> string, or it can have any number of characters before the terminating null character. Microsoft
    ///products use this member to store user configuration information. Do not modify this information.
    PWSTR  usri2_parms;
    ///Type: <b>LPWSTR</b> > [!IMPORTANT] > You should no longer use **usri2_workstations**. Instead, you can control
    ///sign-in access to workstations by configuring the User Rights Assignment settings (**Allow log on locally** and
    ///**Deny log on locally**, or **Allow log on through Remote Desktop Services** and **Deny log on through Remote
    ///Desktop Services**). A pointer to a Unicode string that contains the names of workstations from which the user
    ///can log on. As many as eight workstations can be specified; the names must be separated by commas. A <b>NULL</b>
    ///string indicates that there is no restriction. To disable logons from all workstations to this account, set the
    ///UF_ACCOUNTDISABLE value in the <b>usri2_flags</b> member.
    PWSTR  usri2_workstations;
    ///Type: <b>DWORD</b> The date and time when the last logon occurred. This value is stored as the number of seconds
    ///that have elapsed since 00:00:00, January 1, 1970, GMT. This member is ignored by the NetUserAdd and
    ///NetUserSetInfo functions. This member is maintained separately on each backup domain controller (BDC) in the
    ///domain. To obtain an accurate value, you must query each BDC in the domain. The last logon occurred at the time
    ///indicated by the largest retrieved value.
    uint   usri2_last_logon;
    ///Type: <b>DWORD</b> This member is currently not used. Indicates when the last logoff occurred. This value is
    ///stored as the number of seconds that have elapsed since 00:00:00, January 1, 1970, GMT. A value of zero indicates
    ///that the last logoff time is unknown. This member is maintained separately on each backup domain controller (BDC)
    ///in the domain. To obtain an accurate value, you must query each BDC in the domain. The last logoff occurred at
    ///the time indicated by the largest retrieved value.
    uint   usri2_last_logoff;
    ///Type: <b>DWORD</b> The date and time when the account expires. This value is stored as the number of seconds
    ///elapsed since 00:00:00, January 1, 1970, GMT. A value of TIMEQ_FOREVER indicates that the account never expires.
    uint   usri2_acct_expires;
    ///Type: <b>DWORD</b> The maximum amount of disk space the user can use. Specify USER_MAXSTORAGE_UNLIMITED to use
    ///all available disk space.
    uint   usri2_max_storage;
    ///Type: <b>DWORD</b> The number of equal-length time units into which the week is divided. This value is required
    ///to compute the length of the bit string in the <b>usri2_logon_hours</b> member. This value must be UNITS_PER_WEEK
    ///for LAN Manager 2.0. This element is ignored by the NetUserAdd and NetUserSetInfo functions. For service
    ///applications, the units must be one of the following values: SAM_DAYS_PER_WEEK, SAM_HOURS_PER_WEEK, or
    ///SAM_MINUTES_PER_WEEK.
    uint   usri2_units_per_week;
    ///Type: <b>PBYTE</b> A pointer to a 21-byte (168 bits) bit string that specifies the times during which the user
    ///can log on. Each bit represents a unique hour in the week, in Greenwich Mean Time (GMT). The first bit (bit 0,
    ///word 0) is Sunday, 0:00 to 0:59; the second bit (bit 1, word 0) is Sunday, 1:00 to 1:59; and so on. Note that bit
    ///0 in word 0 represents Sunday from 0:00 to 0:59 only if you are in the GMT time zone. In all other cases you must
    ///adjust the bits according to your time zone offset (for example, GMT minus 8 hours for Pacific Standard Time).
    ///Specify a <b>NULL</b> pointer in this member when calling the NetUserAdd function to indicate no time
    ///restriction. Specify a <b>NULL</b> pointer when calling the NetUserSetInfo function to indicate that no change is
    ///to be made to the times during which the user can log on.
    ubyte* usri2_logon_hours;
    ///Type: <b>DWORD</b> The number of times the user tried to log on to the account using an incorrect password. A
    ///value of – 1 indicates that the value is unknown. Calls to the NetUserAdd and NetUserSetInfo functions ignore
    ///this member. This member is replicated from the primary domain controller (PDC); it is also maintained on each
    ///backup domain controller (BDC) in the domain. To obtain an accurate value, you must query each BDC in the domain.
    ///The number of times the user tried to log on using an incorrect password is the largest value retrieved.
    uint   usri2_bad_pw_count;
    ///Type: <b>DWORD</b> The number of times the user logged on successfully to this account. A value of – 1
    ///indicates that the value is unknown. Calls to the <b>NetUserAdd</b> and <b>NetUserSetInfo</b> functions ignore
    ///this member. This member is maintained separately on each backup domain controller (BDC) in the domain. To obtain
    ///an accurate value, you must query each BDC in the domain. The number of times the user logged on successfully is
    ///the sum of the retrieved values.
    uint   usri2_num_logons;
    ///Type: <b>LPWSTR</b> A pointer to a Unicode string that contains the name of the server to which logon requests
    ///are sent. Server names should be preceded by two backslashes (\\). To indicate that the logon request can be
    ///handled by any logon server, specify an asterisk (\\*) for the server name. A <b>NULL</b> string indicates that
    ///requests should be sent to the domain controller. For Windows servers, NetUserGetInfo and NetUserEnum return \\*.
    ///The NetUserAdd and NetUserSetInfo functions ignore this member.
    PWSTR  usri2_logon_server;
    ///Type: <b>DWORD</b> The country/region code for the user's language of choice.
    uint   usri2_country_code;
    ///Type: <b>DWORD</b> The code page for the user's language of choice.
    uint   usri2_code_page;
}

///The <b>USER_INFO_3</b> structure contains information about a user account, including the account name, password
///data, privilege level, the path to the user's home directory, relative identifiers (RIDs), and other user-related
///network statistics.
struct USER_INFO_3
{
    ///Type: <b>LPWSTR</b> A pointer to a Unicode string that specifies the name of the user account. For the
    ///NetUserSetInfo function, this member is ignored. For more information, see the following Remarks section.
    PWSTR  usri3_name;
    ///Type: <b>LPWSTR</b> A pointer to a Unicode string that specifies the password for the user identified by the
    ///<b>usri3_name</b> member. The length cannot exceed PWLEN bytes. The NetUserEnum and NetUserGetInfo functions
    ///return a <b>NULL</b> pointer to maintain password security. By convention, the length of passwords is limited to
    ///LM20_PWLEN characters.
    PWSTR  usri3_password;
    ///Type: <b>DWORD</b> The number of seconds that have elapsed since the <b>usri3_password</b> member was last
    ///changed. The NetUserAdd and NetUserSetInfo functions ignore this member.
    uint   usri3_password_age;
    ///Type: <b>DWORD</b> The level of privilege assigned to the <b>usri3_name</b> member. The NetUserAdd and
    ///NetUserSetInfo functions ignore this member. This member can be one of the following values. For more information
    ///about user and group account rights, see Privileges. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td
    ///width="40%"><a id="USER_PRIV_GUEST"></a><a id="user_priv_guest"></a><dl> <dt><b>USER_PRIV_GUEST</b></dt> </dl>
    ///</td> <td width="60%"> Guest </td> </tr> <tr> <td width="40%"><a id="USER_PRIV_USER"></a><a
    ///id="user_priv_user"></a><dl> <dt><b>USER_PRIV_USER</b></dt> </dl> </td> <td width="60%"> User </td> </tr> <tr>
    ///<td width="40%"><a id="USER_PRIV_ADMIN"></a><a id="user_priv_admin"></a><dl> <dt><b>USER_PRIV_ADMIN</b></dt>
    ///</dl> </td> <td width="60%"> Administrator </td> </tr> </table>
    uint   usri3_priv;
    ///Type: <b>LPWSTR</b> A pointer to a Unicode string specifying the path of the home directory of the user specified
    ///by the <b>usri3_name</b> member. The string can be <b>NULL</b>.
    PWSTR  usri3_home_dir;
    ///Type: <b>LPWSTR</b> A pointer to a Unicode string that contains a comment to associate with the user account. The
    ///string can be a <b>NULL</b> string, or it can have any number of characters before the terminating null
    ///character.
    PWSTR  usri3_comment;
    ///Type: <b>DWORD</b> This member can be one or more of the following values. Note that setting user account control
    ///flags may require certain privileges and control access rights. For more information, see the Remarks section of
    ///the NetUserSetInfo function. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
    ///id="UF_SCRIPT"></a><a id="uf_script"></a><dl> <dt><b>UF_SCRIPT</b></dt> </dl> </td> <td width="60%"> The logon
    ///script executed. This value must be set. </td> </tr> <tr> <td width="40%"><a id="UF_ACCOUNTDISABLE"></a><a
    ///id="uf_accountdisable"></a><dl> <dt><b>UF_ACCOUNTDISABLE</b></dt> </dl> </td> <td width="60%"> The user's account
    ///is disabled. </td> </tr> <tr> <td width="40%"><a id="UF_HOMEDIR_REQUIRED"></a><a
    ///id="uf_homedir_required"></a><dl> <dt><b>UF_HOMEDIR_REQUIRED</b></dt> </dl> </td> <td width="60%"> The home
    ///directory is required. This value is ignored. </td> </tr> <tr> <td width="40%"><a id="UF_PASSWD_NOTREQD"></a><a
    ///id="uf_passwd_notreqd"></a><dl> <dt><b>UF_PASSWD_NOTREQD</b></dt> </dl> </td> <td width="60%"> No password is
    ///required. </td> </tr> <tr> <td width="40%"><a id="UF_PASSWD_CANT_CHANGE"></a><a
    ///id="uf_passwd_cant_change"></a><dl> <dt><b>UF_PASSWD_CANT_CHANGE</b></dt> </dl> </td> <td width="60%"> The user
    ///cannot change the password. </td> </tr> <tr> <td width="40%"><a id="UF_LOCKOUT"></a><a id="uf_lockout"></a><dl>
    ///<dt><b>UF_LOCKOUT</b></dt> </dl> </td> <td width="60%"> The account is currently locked out. You can call the
    ///NetUserSetInfo function to clear this value and unlock a previously locked account. You cannot use this value to
    ///lock a previously unlocked account. </td> </tr> <tr> <td width="40%"><a id="UF_DONT_EXPIRE_PASSWD"></a><a
    ///id="uf_dont_expire_passwd"></a><dl> <dt><b>UF_DONT_EXPIRE_PASSWD</b></dt> </dl> </td> <td width="60%"> The
    ///password should never expire on the account. </td> </tr> <tr> <td width="40%"><a
    ///id="UF_ENCRYPTED_TEXT_PASSWORD_ALLOWED"></a><a id="uf_encrypted_text_password_allowed"></a><dl>
    ///<dt><b>UF_ENCRYPTED_TEXT_PASSWORD_ALLOWED</b></dt> </dl> </td> <td width="60%"> The user's password is stored
    ///under reversible encryption in the Active Directory. </td> </tr> <tr> <td width="40%"><a
    ///id="UF_NOT_DELEGATED"></a><a id="uf_not_delegated"></a><dl> <dt><b>UF_NOT_DELEGATED</b></dt> </dl> </td> <td
    ///width="60%"> Marks the account as "sensitive"; other users cannot act as delegates of this user account. </td>
    ///</tr> <tr> <td width="40%"><a id="UF_SMARTCARD_REQUIRED"></a><a id="uf_smartcard_required"></a><dl>
    ///<dt><b>UF_SMARTCARD_REQUIRED</b></dt> </dl> </td> <td width="60%"> Requires the user to log on to the user
    ///account with a smart card. </td> </tr> <tr> <td width="40%"><a id="UF_USE_DES_KEY_ONLY"></a><a
    ///id="uf_use_des_key_only"></a><dl> <dt><b>UF_USE_DES_KEY_ONLY</b></dt> </dl> </td> <td width="60%"> Restrict this
    ///principal to use only Data Encryption Standard (DES) encryption types for keys. </td> </tr> <tr> <td
    ///width="40%"><a id="UF_DONT_REQUIRE_PREAUTH"></a><a id="uf_dont_require_preauth"></a><dl>
    ///<dt><b>UF_DONT_REQUIRE_PREAUTH</b></dt> </dl> </td> <td width="60%"> This account does not require Kerberos
    ///preauthentication for logon. </td> </tr> <tr> <td width="40%"><a id="UF_TRUSTED_FOR_DELEGATION"></a><a
    ///id="uf_trusted_for_delegation"></a><dl> <dt><b>UF_TRUSTED_FOR_DELEGATION</b></dt> </dl> </td> <td width="60%">
    ///The account is enabled for delegation. This is a security-sensitive setting; accounts with this option enabled
    ///should be tightly controlled. This setting allows a service running under the account to assume a client's
    ///identity and authenticate as that user to other remote servers on the network. </td> </tr> <tr> <td
    ///width="40%"><a id="UF_PASSWORD_EXPIRED"></a><a id="uf_password_expired"></a><dl>
    ///<dt><b>UF_PASSWORD_EXPIRED</b></dt> </dl> </td> <td width="60%"> The user's password has expired. <b>Windows
    ///2000: </b>This value is not supported. </td> </tr> <tr> <td width="40%"><a
    ///id="UF_TRUSTED_TO_AUTHENTICATE_FOR_DELEGATION"></a><a id="uf_trusted_to_authenticate_for_delegation"></a><dl>
    ///<dt><b>UF_TRUSTED_TO_AUTHENTICATE_FOR_DELEGATION</b></dt> </dl> </td> <td width="60%"> The account is trusted to
    ///authenticate a user outside of the Kerberos security package and delegate that user through constrained
    ///delegation. This is a security-sensitive setting; accounts with this option enabled should be tightly controlled.
    ///This setting allows a service running under the account to assert a client's identity and authenticate as that
    ///user to specifically configured services on the network. <b>Windows XP/2000: </b>This value is not supported.
    ///</td> </tr> </table> The following values describe the account type. Only one value can be set. You cannot change
    ///the account type using the NetUserSetInfo function. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td
    ///width="40%"><a id="UF_NORMAL_ACCOUNT"></a><a id="uf_normal_account"></a><dl> <dt><b>UF_NORMAL_ACCOUNT</b></dt>
    ///</dl> </td> <td width="60%"> This is a default account type that represents a typical user. </td> </tr> <tr> <td
    ///width="40%"><a id="UF_TEMP_DUPLICATE_ACCOUNT"></a><a id="uf_temp_duplicate_account"></a><dl>
    ///<dt><b>UF_TEMP_DUPLICATE_ACCOUNT</b></dt> </dl> </td> <td width="60%"> This is an account for users whose primary
    ///account is in another domain. This account provides user access to this domain, but not to any domain that trusts
    ///this domain. The User Manager refers to this account type as a local user account. </td> </tr> <tr> <td
    ///width="40%"><a id="UF_WORKSTATION_TRUST_ACCOUNT"></a><a id="uf_workstation_trust_account"></a><dl>
    ///<dt><b>UF_WORKSTATION_TRUST_ACCOUNT</b></dt> </dl> </td> <td width="60%"> This is a computer account for a
    ///computer that is a member of this domain. </td> </tr> <tr> <td width="40%"><a id="UF_SERVER_TRUST_ACCOUNT"></a><a
    ///id="uf_server_trust_account"></a><dl> <dt><b>UF_SERVER_TRUST_ACCOUNT</b></dt> </dl> </td> <td width="60%"> This
    ///is a computer account for a backup domain controller that is a member of this domain. </td> </tr> <tr> <td
    ///width="40%"><a id="UF_INTERDOMAIN_TRUST_ACCOUNT"></a><a id="uf_interdomain_trust_account"></a><dl>
    ///<dt><b>UF_INTERDOMAIN_TRUST_ACCOUNT</b></dt> </dl> </td> <td width="60%"> This is a permit to trust account for a
    ///domain that trusts other domains. </td> </tr> </table>
    uint   usri3_flags;
    ///Type: <b>LPWSTR</b> A pointer to a Unicode string specifying the path for the user's logon script file. The
    ///script file can be a .CMD file, an .EXE file, or a .BAT file. The string can also be <b>NULL</b>.
    PWSTR  usri3_script_path;
    ///Type: <b>DWORD</b> The user's operator privileges. For the NetUserGetInfo and NetUserEnum functions, the
    ///appropriate value is returned based on the local group membership. If the user is a member of Print Operators,
    ///AF_OP_PRINT is set. If the user is a member of Server Operators, AF_OP_SERVER is set. If the user is a member of
    ///the Account Operators, AF_OP_ACCOUNTS is set. AF_OP_COMM is never set. The NetUserAdd and NetUserSetInfo
    ///functions ignore this member. This member can be one or more of the following values. <table> <tr> <th>Value</th>
    ///<th>Meaning</th> </tr> <tr> <td width="40%"><a id="AF_OP_PRINT"></a><a id="af_op_print"></a><dl>
    ///<dt><b>AF_OP_PRINT</b></dt> </dl> </td> <td width="60%"> The print operator privilege is enabled. </td> </tr>
    ///<tr> <td width="40%"><a id="AF_OP_COMM"></a><a id="af_op_comm"></a><dl> <dt><b>AF_OP_COMM</b></dt> </dl> </td>
    ///<td width="60%"> The communications operator privilege is enabled. </td> </tr> <tr> <td width="40%"><a
    ///id="AF_OP_SERVER"></a><a id="af_op_server"></a><dl> <dt><b>AF_OP_SERVER</b></dt> </dl> </td> <td width="60%"> The
    ///server operator privilege is enabled. </td> </tr> <tr> <td width="40%"><a id="AF_OP_ACCOUNTS"></a><a
    ///id="af_op_accounts"></a><dl> <dt><b>AF_OP_ACCOUNTS</b></dt> </dl> </td> <td width="60%"> The accounts operator
    ///privilege is enabled. </td> </tr> </table>
    uint   usri3_auth_flags;
    ///Type: <b>LPWSTR</b> A pointer to a Unicode string that contains the full name of the user. This string can be a
    ///<b>NULL</b> string, or it can have any number of characters before the terminating null character.
    PWSTR  usri3_full_name;
    ///Type: <b>LPWSTR</b> A pointer to a Unicode string that contains a user comment. This string can be a <b>NULL</b>
    ///string, or it can have any number of characters before the terminating null character.
    PWSTR  usri3_usr_comment;
    ///Type: <b>LPWSTR</b> A pointer to a Unicode string that is reserved for use by applications. This string can be a
    ///<b>NULL</b> string, or it can have any number of characters before the terminating null character. Microsoft
    ///products use this member to store user configuration information. Do not modify this information.
    PWSTR  usri3_parms;
    ///Type: <b>LPWSTR</b> > [!IMPORTANT] > You should no longer use **usri3_workstations**. Instead, you can control
    ///sign-in access to workstations by configuring the User Rights Assignment settings (**Allow log on locally** and
    ///**Deny log on locally**, or **Allow log on through Remote Desktop Services** and **Deny log on through Remote
    ///Desktop Services**). A pointer to a Unicode string that contains the names of workstations from which the user
    ///can log on. As many as eight workstations can be specified; the names must be separated by commas. If you do not
    ///want to restrict the number of workstations, use a <b>NULL</b> string. To disable logons from all workstations to
    ///this account, set the UF_ACCOUNTDISABLE value in the <b>usri3_flags</b> member.
    PWSTR  usri3_workstations;
    ///Type: <b>DWORD</b> The date and time when the last logon occurred. This value is stored as the number of seconds
    ///that have elapsed since 00:00:00, January 1, 1970, GMT. This member is ignored by the NetUserAdd and
    ///NetUserSetInfo functions. This member is maintained separately on each backup domain controller (BDC) in the
    ///domain. To obtain an accurate value, you must query each BDC in the domain. The last logon occurred at the time
    ///indicated by the largest retrieved value.
    uint   usri3_last_logon;
    ///Type: <b>DWORD</b> This member is currently not used. The date and time when the last logoff occurred. This value
    ///is stored as the number of seconds that have elapsed since 00:00:00, January 1, 1970, GMT. A value of zero
    ///indicates that the last logoff time is unknown. This member is maintained separately on each backup domain
    ///controller (BDC) in the domain. To obtain an accurate value, you must query each BDC in the domain. The last
    ///logoff occurred at the time indicated by the largest retrieved value.
    uint   usri3_last_logoff;
    ///Type: <b>DWORD</b> The date and time when the account expires. This value is stored as the number of seconds
    ///elapsed since 00:00:00, January 1, 1970, GMT. A value of TIMEQ_FOREVER indicates that the account never expires.
    uint   usri3_acct_expires;
    ///Type: <b>DWORD</b> The maximum amount of disk space the user can use. Specify USER_MAXSTORAGE_UNLIMITED to use
    ///all available disk space.
    uint   usri3_max_storage;
    ///Type: <b>DWORD</b> The number of equal-length time units into which the week is divided. This value is required
    ///to compute the length of the bit string in the <b>usri3_logon_hours</b> member. This value must be UNITS_PER_WEEK
    ///for LAN Manager 2.0. This element is ignored by the NetUserAdd and NetUserSetInfo functions. For service
    ///applications, the units must be one of the following values: SAM_DAYS_PER_WEEK, SAM_HOURS_PER_WEEK, or
    ///SAM_MINUTES_PER_WEEK.
    uint   usri3_units_per_week;
    ///Type: <b>PBYTE</b> A pointer to a 21-byte (168 bits) bit string that specifies the times during which the user
    ///can log on. Each bit represents a unique hour in the week, in Greenwich Mean Time (GMT). The first bit (bit 0,
    ///word 0) is Sunday, 0:00 to 0:59; the second bit (bit 1, word 0) is Sunday, 1:00 to 1:59; and so on. Note that bit
    ///0 in word 0 represents Sunday from 0:00 to 0:59 only if you are in the GMT time zone. In all other cases you must
    ///adjust the bits according to your time zone offset (for example, GMT minus 8 hours for Pacific Standard Time).
    ///Specify a <b>NULL</b> pointer in this member when calling the NetUserAdd function to indicate no time
    ///restriction. Specify a <b>NULL</b> pointer when calling the NetUserSetInfo function to indicate that no change is
    ///to be made to the times during which the user can log on.
    ubyte* usri3_logon_hours;
    ///Type: <b>DWORD</b> The number of times the user tried to log on to the account using an incorrect password. A
    ///value of – 1 indicates that the value is unknown. Calls to the NetUserAdd and NetUserSetInfo functions ignore
    ///this member. This member is replicated from the primary domain controller (PDC); it is also maintained on each
    ///backup domain controller (BDC) in the domain. To obtain an accurate value, you must query each BDC in the domain.
    ///The number of times the user tried to log on using an incorrect password is the largest value retrieved.
    uint   usri3_bad_pw_count;
    ///Type: <b>DWORD</b> The number of times the user logged on successfully to this account. A value of – 1
    ///indicates that the value is unknown. Calls to the <b>NetUserAdd</b> and <b>NetUserSetInfo</b> functions ignore
    ///this member. This member is maintained separately on each backup domain controller (BDC) in the domain. To obtain
    ///an accurate value, you must query each BDC in the domain. The number of times the user logged on successfully is
    ///the sum of the retrieved values.
    uint   usri3_num_logons;
    ///Type: <b>LPWSTR</b> A pointer to a Unicode string that contains the name of the server to which logon requests
    ///are sent. Server names should be preceded by two backslashes (\\). To indicate that the logon request can be
    ///handled by any logon server, specify an asterisk (\\*) for the server name. A <b>NULL</b> string indicates that
    ///requests should be sent to the domain controller. For Windows servers, NetUserGetInfo and NetUserEnum return \\*.
    ///The NetUserAdd and NetUserSetInfo functions ignore this member.
    PWSTR  usri3_logon_server;
    ///Type: <b>DWORD</b> The country/region code for the user's language of choice.
    uint   usri3_country_code;
    ///Type: <b>DWORD</b> The code page for the user's language of choice.
    uint   usri3_code_page;
    ///Type: <b>DWORD</b> The relative ID (RID) of the user. The RID is determined by the Security Account Manager (SAM)
    ///when the user is created. It uniquely defines the user account to SAM within the domain. The NetUserAdd and
    ///NetUserSetInfo functions ignore this member. For more information about RIDs, see SID Components.
    uint   usri3_user_id;
    ///Type: <b>DWORD</b> The RID of the Primary Global Group for the user. When you call the <b>NetUserAdd</b>
    ///function, this member must be DOMAIN_GROUP_RID_USERS (defined in WinNT.h). When you call <b>NetUserSetInfo</b>,
    ///this member must be the RID of a global group in which the user is enrolled. For more information, see Well-Known
    ///SIDs.
    uint   usri3_primary_group_id;
    ///Type: <b>LPWSTR</b> A pointer to a Unicode string that specifies a path to the user's profile. This value can be
    ///a <b>NULL</b> string, a local absolute path, or a UNC path.
    PWSTR  usri3_profile;
    ///Type: <b>LPWSTR</b> A pointer to a Unicode string that specifies the drive letter assigned to the user's home
    ///directory for logon purposes.
    PWSTR  usri3_home_dir_drive;
    ///Type: <b>DWORD</b> The password expiration information. The NetUserGetInfo and NetUserEnum functions return zero
    ///if the password has not expired (and nonzero if it has). When you call NetUserAdd or NetUserSetInfo, specify a
    ///nonzero value in this member to inform users that they must change their password at the next logon. To turn off
    ///this message, call <b>NetUserSetInfo</b> and specify zero in this member. Note that you cannot specify zero to
    ///negate the expiration of a password that has already expired.
    uint   usri3_password_expired;
}

///The <b>USER_INFO_4</b> structure contains information about a user account, including the account name, password
///data, privilege level, the path to the user's home directory, security identifier (SID), and other user-related
///network statistics.
struct USER_INFO_4
{
    ///Type: <b>LPWSTR</b> A pointer to a Unicode string that specifies the name of the user account. For the
    ///NetUserSetInfo function, this member is ignored.
    PWSTR  usri4_name;
    ///Type: <b>LPWSTR</b> A pointer to a Unicode string that specifies the password for the user identified by the
    ///<b>usri4_name</b> member. The length cannot exceed PWLEN bytes. The NetUserGetInfo function returns a <b>NULL</b>
    ///pointer to maintain password security. By convention, the length of passwords is limited to LM20_PWLEN
    ///characters.
    PWSTR  usri4_password;
    ///Type: <b>DWORD</b> The number of seconds that have elapsed since the <b>usri4_password</b> member was last
    ///changed. The NetUserAdd and NetUserSetInfo functions ignore this member.
    uint   usri4_password_age;
    ///Type: <b>DWORD</b> The level of privilege assigned to the <b>usri4_name</b> member. The NetUserAdd and
    ///NetUserSetInfo functions ignore this member. This member can be one of the following values. For more information
    ///about user and group account rights, see Privileges. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td
    ///width="40%"><a id="USER_PRIV_GUEST"></a><a id="user_priv_guest"></a><dl> <dt><b>USER_PRIV_GUEST</b></dt> </dl>
    ///</td> <td width="60%"> Guest </td> </tr> <tr> <td width="40%"><a id="USER_PRIV_USER"></a><a
    ///id="user_priv_user"></a><dl> <dt><b>USER_PRIV_USER</b></dt> </dl> </td> <td width="60%"> User </td> </tr> <tr>
    ///<td width="40%"><a id="USER_PRIV_ADMIN"></a><a id="user_priv_admin"></a><dl> <dt><b>USER_PRIV_ADMIN</b></dt>
    ///</dl> </td> <td width="60%"> Administrator </td> </tr> </table>
    uint   usri4_priv;
    ///Type: <b>LPWSTR</b> A pointer to a Unicode string specifying the path of the home directory of the user specified
    ///by the <b>usri4_name</b> member. The string can be <b>NULL</b>.
    PWSTR  usri4_home_dir;
    ///Type: <b>LPWSTR</b> A pointer to a Unicode string that contains a comment to associate with the user account. The
    ///string can be a <b>NULL</b> string, or it can have any number of characters before the terminating null
    ///character.
    PWSTR  usri4_comment;
    ///Type: <b>DWORD</b> This member can be one or more of the following values. Note that setting user account control
    ///flags may require certain privileges and control access rights. For more information, see the Remarks section of
    ///the NetUserSetInfo function. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
    ///id="UF_SCRIPT"></a><a id="uf_script"></a><dl> <dt><b>UF_SCRIPT</b></dt> </dl> </td> <td width="60%"> The logon
    ///script executed. This value must be set. </td> </tr> <tr> <td width="40%"><a id="UF_ACCOUNTDISABLE"></a><a
    ///id="uf_accountdisable"></a><dl> <dt><b>UF_ACCOUNTDISABLE</b></dt> </dl> </td> <td width="60%"> The user's account
    ///is disabled. </td> </tr> <tr> <td width="40%"><a id="UF_HOMEDIR_REQUIRED"></a><a
    ///id="uf_homedir_required"></a><dl> <dt><b>UF_HOMEDIR_REQUIRED</b></dt> </dl> </td> <td width="60%"> The home
    ///directory is required. This value is ignored. </td> </tr> <tr> <td width="40%"><a id="UF_PASSWD_NOTREQD"></a><a
    ///id="uf_passwd_notreqd"></a><dl> <dt><b>UF_PASSWD_NOTREQD</b></dt> </dl> </td> <td width="60%"> No password is
    ///required. </td> </tr> <tr> <td width="40%"><a id="UF_PASSWD_CANT_CHANGE"></a><a
    ///id="uf_passwd_cant_change"></a><dl> <dt><b>UF_PASSWD_CANT_CHANGE</b></dt> </dl> </td> <td width="60%"> The user
    ///cannot change the password. </td> </tr> <tr> <td width="40%"><a id="UF_LOCKOUT"></a><a id="uf_lockout"></a><dl>
    ///<dt><b>UF_LOCKOUT</b></dt> </dl> </td> <td width="60%"> The account is currently locked out. You can call the
    ///NetUserSetInfo function to clear this value and unlock a previously locked account. You cannot use this value to
    ///lock a previously unlocked account. </td> </tr> <tr> <td width="40%"><a id="UF_DONT_EXPIRE_PASSWD"></a><a
    ///id="uf_dont_expire_passwd"></a><dl> <dt><b>UF_DONT_EXPIRE_PASSWD</b></dt> </dl> </td> <td width="60%"> The
    ///password should never expire on the account. </td> </tr> <tr> <td width="40%"><a
    ///id="UF_ENCRYPTED_TEXT_PASSWORD_ALLOWED"></a><a id="uf_encrypted_text_password_allowed"></a><dl>
    ///<dt><b>UF_ENCRYPTED_TEXT_PASSWORD_ALLOWED</b></dt> </dl> </td> <td width="60%"> The user's password is stored
    ///under reversible encryption in the Active Directory. </td> </tr> <tr> <td width="40%"><a
    ///id="UF_NOT_DELEGATED"></a><a id="uf_not_delegated"></a><dl> <dt><b>UF_NOT_DELEGATED</b></dt> </dl> </td> <td
    ///width="60%"> Marks the account as "sensitive"; other users cannot act as delegates of this user account. </td>
    ///</tr> <tr> <td width="40%"><a id="UF_SMARTCARD_REQUIRED"></a><a id="uf_smartcard_required"></a><dl>
    ///<dt><b>UF_SMARTCARD_REQUIRED</b></dt> </dl> </td> <td width="60%"> Requires the user to log on to the user
    ///account with a smart card. </td> </tr> <tr> <td width="40%"><a id="UF_USE_DES_KEY_ONLY"></a><a
    ///id="uf_use_des_key_only"></a><dl> <dt><b>UF_USE_DES_KEY_ONLY</b></dt> </dl> </td> <td width="60%"> Restrict this
    ///principal to use only Data Encryption Standard (DES) encryption types for keys. </td> </tr> <tr> <td
    ///width="40%"><a id="UF_DONT_REQUIRE_PREAUTH"></a><a id="uf_dont_require_preauth"></a><dl>
    ///<dt><b>UF_DONT_REQUIRE_PREAUTH</b></dt> </dl> </td> <td width="60%"> This account does not require Kerberos
    ///preauthentication for logon. </td> </tr> <tr> <td width="40%"><a id="UF_TRUSTED_FOR_DELEGATION"></a><a
    ///id="uf_trusted_for_delegation"></a><dl> <dt><b>UF_TRUSTED_FOR_DELEGATION</b></dt> </dl> </td> <td width="60%">
    ///The account is enabled for delegation. This is a security-sensitive setting; accounts with this option enabled
    ///should be tightly controlled. This setting allows a service running under the account to assume a client's
    ///identity and authenticate as that user to other remote servers on the network. </td> </tr> <tr> <td
    ///width="40%"><a id="UF_PASSWORD_EXPIRED"></a><a id="uf_password_expired"></a><dl>
    ///<dt><b>UF_PASSWORD_EXPIRED</b></dt> </dl> </td> <td width="60%"> The user's password has expired. <b>Windows
    ///2000: </b>This value is ignored. </td> </tr> <tr> <td width="40%"><a
    ///id="UF_TRUSTED_TO_AUTHENTICATE_FOR_DELEGATION"></a><a id="uf_trusted_to_authenticate_for_delegation"></a><dl>
    ///<dt><b>UF_TRUSTED_TO_AUTHENTICATE_FOR_DELEGATION</b></dt> </dl> </td> <td width="60%"> The account is trusted to
    ///authenticate a user outside of the Kerberos security package and delegate that user through constrained
    ///delegation. This is a security-sensitive setting; accounts with this option enabled should be tightly controlled.
    ///This setting allows a service running under the account to assert a client's identity and authenticate as that
    ///user to specifically configured services on the network. <b>Windows XP/2000: </b>This value is ignored. </td>
    ///</tr> </table> The following values describe the account type. Only one value can be set. You cannot change the
    ///account type using the NetUserSetInfo function. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td
    ///width="40%"><a id="UF_NORMAL_ACCOUNT"></a><a id="uf_normal_account"></a><dl> <dt><b>UF_NORMAL_ACCOUNT</b></dt>
    ///</dl> </td> <td width="60%"> This is a default account type that represents a typical user. </td> </tr> <tr> <td
    ///width="40%"><a id="UF_TEMP_DUPLICATE_ACCOUNT"></a><a id="uf_temp_duplicate_account"></a><dl>
    ///<dt><b>UF_TEMP_DUPLICATE_ACCOUNT</b></dt> </dl> </td> <td width="60%"> This is an account for users whose primary
    ///account is in another domain. This account provides user access to this domain, but not to any domain that trusts
    ///this domain. The User Manager refers to this account type as a local user account. </td> </tr> <tr> <td
    ///width="40%"><a id="UF_WORKSTATION_TRUST_ACCOUNT"></a><a id="uf_workstation_trust_account"></a><dl>
    ///<dt><b>UF_WORKSTATION_TRUST_ACCOUNT</b></dt> </dl> </td> <td width="60%"> This is a computer account for a
    ///computer that is a member of this domain. </td> </tr> <tr> <td width="40%"><a id="UF_SERVER_TRUST_ACCOUNT"></a><a
    ///id="uf_server_trust_account"></a><dl> <dt><b>UF_SERVER_TRUST_ACCOUNT</b></dt> </dl> </td> <td width="60%"> This
    ///is a computer account for a backup domain controller that is a member of this domain. </td> </tr> <tr> <td
    ///width="40%"><a id="UF_INTERDOMAIN_TRUST_ACCOUNT"></a><a id="uf_interdomain_trust_account"></a><dl>
    ///<dt><b>UF_INTERDOMAIN_TRUST_ACCOUNT</b></dt> </dl> </td> <td width="60%"> This is a permit to trust account for a
    ///domain that trusts other domains. </td> </tr> </table>
    uint   usri4_flags;
    ///Type: <b>LPWSTR</b> A pointer to a Unicode string specifying the path for the user's logon script file. The
    ///script file can be a .CMD file, an .EXE file, or a .BAT file. The string can also be <b>NULL</b>.
    PWSTR  usri4_script_path;
    ///Type: <b>DWORD</b> The user's operator privileges. For the NetUserGetInfo function, the appropriate value is
    ///returned based on the local group membership. If the user is a member of Print Operators, AF_OP_PRINT is set. If
    ///the user is a member of Server Operators, AF_OP_SERVER is set. If the user is a member of the Account Operators,
    ///AF_OP_ACCOUNTS is set. AF_OP_COMM is never set. The NetUserAdd and NetUserSetInfo functions ignore this member.
    ///This member can be one or more of the following values. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr>
    ///<td width="40%"><a id="AF_OP_PRINT"></a><a id="af_op_print"></a><dl> <dt><b>AF_OP_PRINT</b></dt> </dl> </td> <td
    ///width="60%"> The print operator privilege is enabled. </td> </tr> <tr> <td width="40%"><a id="AF_OP_COMM"></a><a
    ///id="af_op_comm"></a><dl> <dt><b>AF_OP_COMM</b></dt> </dl> </td> <td width="60%"> The communications operator
    ///privilege is enabled. </td> </tr> <tr> <td width="40%"><a id="AF_OP_SERVER"></a><a id="af_op_server"></a><dl>
    ///<dt><b>AF_OP_SERVER</b></dt> </dl> </td> <td width="60%"> The server operator privilege is enabled. </td> </tr>
    ///<tr> <td width="40%"><a id="AF_OP_ACCOUNTS"></a><a id="af_op_accounts"></a><dl> <dt><b>AF_OP_ACCOUNTS</b></dt>
    ///</dl> </td> <td width="60%"> The accounts operator privilege is enabled. </td> </tr> </table>
    uint   usri4_auth_flags;
    ///Type: <b>LPWSTR</b> A pointer to a Unicode string that contains the full name of the user. This string can be a
    ///<b>NULL</b> string, or it can have any number of characters before the terminating null character.
    PWSTR  usri4_full_name;
    ///Type: <b>LPWSTR</b> A pointer to a Unicode string that contains a user comment. This string can be a <b>NULL</b>
    ///string, or it can have any number of characters before the terminating null character.
    PWSTR  usri4_usr_comment;
    ///Type: <b>LPWSTR</b> A pointer to a Unicode string that is reserved for use by applications. This string can be a
    ///<b>NULL</b> string, or it can have any number of characters before the terminating null character. Microsoft
    ///products use this member to store user configuration information. Do not modify this information.
    PWSTR  usri4_parms;
    ///Type: <b>LPWSTR</b> > [!IMPORTANT] > You should no longer use **usri4_workstations**. Instead, you can control
    ///sign-in access to workstations by configuring the User Rights Assignment settings (**Allow log on locally** and
    ///**Deny log on locally**, or **Allow log on through Remote Desktop Services** and **Deny log on through Remote
    ///Desktop Services**). A pointer to a Unicode string that contains the names of workstations from which the user
    ///can log on. As many as eight workstations can be specified; the names must be separated by commas. If you do not
    ///want to restrict the number of workstations, use a <b>NULL</b> string. To disable logons from all workstations to
    ///this account, set the UF_ACCOUNTDISABLE value in the <b>usri4_flags</b> member.
    PWSTR  usri4_workstations;
    ///Type: <b>DWORD</b> The date and time when the last logon occurred. This value is stored as the number of seconds
    ///that have elapsed since 00:00:00, January 1, 1970, GMT. This member is ignored by the NetUserAdd and
    ///NetUserSetInfo functions. This member is maintained separately on each backup domain controller (BDC) in the
    ///domain. To obtain an accurate value, you must query each BDC in the domain. The last logon occurred at the time
    ///indicated by the largest retrieved value.
    uint   usri4_last_logon;
    ///Type: <b>DWORD</b> This member is currently not used. The date and time when the last logoff occurred. This value
    ///is stored as the number of seconds that have elapsed since 00:00:00, January 1, 1970, GMT. A value of zero
    ///indicates that the last logoff time is unknown. This member is maintained separately on each backup domain
    ///controller (BDC) in the domain. To obtain an accurate value, you must query each BDC in the domain. The last
    ///logoff occurred at the time indicated by the largest retrieved value.
    uint   usri4_last_logoff;
    ///Type: <b>DWORD</b> The date and time when the account expires. This value is stored as the number of seconds
    ///elapsed since 00:00:00, January 1, 1970, GMT. A value of TIMEQ_FOREVER indicates that the account never expires.
    uint   usri4_acct_expires;
    ///Type: <b>DWORD</b> The maximum amount of disk space the user can use. Specify USER_MAXSTORAGE_UNLIMITED to use
    ///all available disk space.
    uint   usri4_max_storage;
    ///Type: <b>DWORD</b> The number of equal-length time units into which the week is divided. This value is required
    ///to compute the length of the bit string in the <b>usri4_logon_hours</b> member. This value must be UNITS_PER_WEEK
    ///for LAN Manager 2.0. This element is ignored by the NetUserAdd and NetUserSetInfo functions. For service
    ///applications, the units must be one of the following values: SAM_DAYS_PER_WEEK, SAM_HOURS_PER_WEEK, or
    ///SAM_MINUTES_PER_WEEK.
    uint   usri4_units_per_week;
    ///Type: <b>PBYTE</b> A pointer to a 21-byte (168 bits) bit string that specifies the times during which the user
    ///can log on. Each bit represents a unique hour in the week, in Greenwich Mean Time (GMT). The first bit (bit 0,
    ///word 0) is Sunday, 0:00 to 0:59; the second bit (bit 1, word 0) is Sunday, 1:00 to 1:59; and so on. Note that bit
    ///0 in word 0 represents Sunday from 0:00 to 0:59 only if you are in the GMT time zone. In all other cases you must
    ///adjust the bits according to your time zone offset (for example, GMT minus 8 hours for Pacific Standard Time).
    ///Specify a <b>NULL</b> pointer in this member when calling the NetUserAdd function to indicate no time
    ///restriction. Specify a <b>NULL</b> pointer when calling the NetUserSetInfo function to indicate that no change is
    ///to be made to the times during which the user can log on.
    ubyte* usri4_logon_hours;
    ///Type: <b>DWORD</b> The number of times the user tried to log on to the account using an incorrect password. A
    ///value of – 1 indicates that the value is unknown. Calls to the NetUserAdd and NetUserSetInfo functions ignore
    ///this member. This member is replicated from the primary domain controller (PDC); it is also maintained on each
    ///backup domain controller (BDC) in the domain. To obtain an accurate value, you must query each BDC in the domain.
    ///The number of times the user tried to log on using an incorrect password is the largest value retrieved.
    uint   usri4_bad_pw_count;
    ///Type: <b>DWORD</b> The number of times the user logged on successfully to this account. A value of – 1
    ///indicates that the value is unknown. Calls to the <b>NetUserAdd</b> and <b>NetUserSetInfo</b> functions ignore
    ///this member. This member is maintained separately on each backup domain controller (BDC) in the domain. To obtain
    ///an accurate value, you must query each BDC in the domain. The number of times the user logged on successfully is
    ///the sum of the retrieved values.
    uint   usri4_num_logons;
    ///Type: <b>LPWSTR</b> A pointer to a Unicode string that contains the name of the server to which logon requests
    ///are sent. Server names should be preceded by two backslashes (\\). To indicate that the logon request can be
    ///handled by any logon server, specify an asterisk (\\*) for the server name. A <b>NULL</b> string indicates that
    ///requests should be sent to the domain controller. For Windows servers, the NetUserGetInfo function returns \\*.
    ///The NetUserAdd and NetUserSetInfo functions ignore this member.
    PWSTR  usri4_logon_server;
    ///Type: <b>DWORD</b> The country/region code for the user's language of choice.
    uint   usri4_country_code;
    ///Type: <b>DWORD</b> The code page for the user's language of choice.
    uint   usri4_code_page;
    ///Type: <b>PSID</b> A pointer to a SID structure that contains the security identifier (SID) that uniquely
    ///identifies the user. The NetUserAdd and NetUserSetInfo functions ignore this member.
    void*  usri4_user_sid;
    ///Type: <b>DWORD</b> The relative identifier (RID) of the Primary Global Group for the user. When you call the
    ///<b>NetUserAdd</b> function, this member must be DOMAIN_GROUP_RID_USERS (defined in WinNT.h). When you call
    ///<b>NetUserSetInfo</b>, this member must be the RID of a global group in which the user is enrolled. For more
    ///information, see Well-Known SIDs and SID Components.
    uint   usri4_primary_group_id;
    ///Type: <b>LPWSTR</b> A pointer to a Unicode string that specifies a path to the user's profile. This value can be
    ///a <b>NULL</b> string, a local absolute path, or a UNC path.
    PWSTR  usri4_profile;
    ///Type: <b>LPWSTR</b> A pointer to a Unicode string that specifies the drive letter assigned to the user's home
    ///directory for logon purposes.
    PWSTR  usri4_home_dir_drive;
    ///Type: <b>DWORD</b> The password expiration information. The NetUserGetInfo function return zero if the password
    ///has not expired (and nonzero if it has). When you call NetUserAdd or NetUserSetInfo, specify a nonzero value in
    ///this member to inform users that they must change their password at the next logon. To turn off this message,
    ///call <b>NetUserSetInfo</b> and specify zero in this member. Note that you cannot specify zero to negate the
    ///expiration of a password that has already expired.
    uint   usri4_password_expired;
}

///The <b>USER_INFO_10</b> structure contains information about a user account, including the account name, comments
///associated with the account, and the user's full name.
struct USER_INFO_10
{
    ///Pointer to a Unicode string that specifies the name of the user account. Calls to the NetUserSetInfo function
    ///ignore this member. For more information, see the following Remarks section.
    PWSTR usri10_name;
    ///Pointer to a Unicode string that contains a comment associated with the user account. The string can be a null
    ///string, or can have any number of characters before the terminating null character.
    PWSTR usri10_comment;
    ///Pointer to a Unicode string that contains a user comment. This string can be a null string, or it can have any
    ///number of characters before the terminating null character.
    PWSTR usri10_usr_comment;
    ///Pointer to a Unicode string that contains the full name of the user. This string can be a null string, or it can
    ///have any number of characters before the terminating null character.
    PWSTR usri10_full_name;
}

///The <b>USER_INFO_11</b> structure contains information about a user account, including the account name, privilege
///level, the path to the user's home directory, and other user-related network statistics.
struct USER_INFO_11
{
    ///Type: <b>LPWSTR</b> A pointer to a Unicode character that specifies the name of the user account. Calls to the
    ///NetUserSetInfo function ignore this member. For more information, see the following Remarks section.
    PWSTR  usri11_name;
    ///Type: <b>LPWSTR</b> A pointer to a Unicode string that contains a comment associated with the user account. This
    ///string can be a <b>NULL</b> string, or it can have any number of characters before the terminating null
    ///character.
    PWSTR  usri11_comment;
    ///Type: <b>LPWSTR</b> A pointer to a Unicode string that contains a user comment. This string can be a <b>NULL</b>
    ///string, or it can have any number of characters before the terminating null character.
    PWSTR  usri11_usr_comment;
    ///Type: <b>LPWSTR</b> A pointer to a Unicode string that contains the full name of the user. This string can be a
    ///<b>NULL</b> string, or it can have any number of characters before the terminating null character.
    PWSTR  usri11_full_name;
    ///Type: <b>DWORD</b> The level of privilege assigned to the <b>usri11_name</b> member. For calls to the NetUserAdd
    ///function, this member must be USER_PRIV_USER. For calls to NetUserSetInfo, this member must be the value returned
    ///from the NetUserGetInfo function or the NetUserEnum function. This member can be one of the following values. For
    ///more information about user and group account rights, see Privileges. <table> <tr> <th>Value</th>
    ///<th>Meaning</th> </tr> <tr> <td width="40%"><a id="USER_PRIV_GUEST"></a><a id="user_priv_guest"></a><dl>
    ///<dt><b>USER_PRIV_GUEST</b></dt> </dl> </td> <td width="60%"> Guest </td> </tr> <tr> <td width="40%"><a
    ///id="USER_PRIV_USER"></a><a id="user_priv_user"></a><dl> <dt><b>USER_PRIV_USER</b></dt> </dl> </td> <td
    ///width="60%"> User </td> </tr> <tr> <td width="40%"><a id="USER_PRIV_ADMIN"></a><a id="user_priv_admin"></a><dl>
    ///<dt><b>USER_PRIV_ADMIN</b></dt> </dl> </td> <td width="60%"> Administrator </td> </tr> </table>
    uint   usri11_priv;
    ///Type: <b>DWORD</b> A set of bit flags defining the user's operator privileges. Calls to the NetUserGetInfo
    ///function and the NetUserEnum function return a value based on the user's local group membership. If the user is a
    ///member of Print Operators, AF_OP_PRINT is set. If the user is a member of Server Operators, AF_OP_SERVER is set.
    ///If the user is a member of the Account Operators, AF_OP_ACCOUNTS is set. AF_OP_COMM is never set. The NetUserAdd
    ///and NetUserSetInfo functions ignore this member. The following restrictions apply: <ul> <li>When you call the
    ///NetUserAdd function, this member must be zero.</li> <li>When you call the NetUserSetInfo function, this member
    ///must be the value returned from a call to NetUserGetInfo or to NetUserEnum.</li> </ul> This member can be one or
    ///more of the following values. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
    ///id="AF_OP_PRINT"></a><a id="af_op_print"></a><dl> <dt><b>AF_OP_PRINT</b></dt> </dl> </td> <td width="60%"> The
    ///print operator privilege is enabled. </td> </tr> <tr> <td width="40%"><a id="AF_OP_COMM"></a><a
    ///id="af_op_comm"></a><dl> <dt><b>AF_OP_COMM</b></dt> </dl> </td> <td width="60%"> The communications operator
    ///privilege is enabled. </td> </tr> <tr> <td width="40%"><a id="AF_OP_SERVER"></a><a id="af_op_server"></a><dl>
    ///<dt><b>AF_OP_SERVER</b></dt> </dl> </td> <td width="60%"> The server operator privilege is enabled. </td> </tr>
    ///<tr> <td width="40%"><a id="AF_OP_ACCOUNTS"></a><a id="af_op_accounts"></a><dl> <dt><b>AF_OP_ACCOUNTS</b></dt>
    ///</dl> </td> <td width="60%"> The accounts operator privilege is enabled. </td> </tr> </table>
    uint   usri11_auth_flags;
    ///Type: <b>DWORD</b> The number of seconds that have elapsed since the <b>usri11_password</b> member was last
    ///changed. The NetUserAdd and NetUserSetInfo functions ignore this member.
    uint   usri11_password_age;
    ///Type: <b>LPWSTR</b> A pointer to a Unicode string specifying the path of the home directory for the user
    ///specified in the <b>usri11_name</b> member. The string can be <b>NULL</b>.
    PWSTR  usri11_home_dir;
    ///Type: <b>LPWSTR</b> A pointer to a Unicode string that is reserved for use by applications. This string can be a
    ///<b>NULL</b> string, or it can have any number of characters before the terminating null character. Microsoft
    ///products use this member to store user configuration information. Do not modify this information.
    PWSTR  usri11_parms;
    ///Type: <b>DWORD</b> The date and time when the last logon occurred. This value is stored as the number of seconds
    ///that have elapsed since 00:00:00, January 1, 1970, GMT. The NetUserAdd and NetUserSetInfo functions ignore this
    ///member. This member is maintained separately on each backup domain controller (BDC) in the domain. To obtain an
    ///accurate value, you must query each BDC in the domain. The last logon occurred at the time indicated by the
    ///largest retrieved value.
    uint   usri11_last_logon;
    ///Type: <b>DWORD</b> This member is currently not used. The date and time when the last logoff occurred. This value
    ///is stored as the number of seconds that have elapsed since 00:00:00, January 1, 1970, GMT. A value of zero
    ///indicates that the last logoff time is unknown. The <b>NetUserAdd</b> function and the <b>NetUserSetInfo</b>
    ///function ignore this member. This member is maintained separately on each backup domain controller (BDC) in the
    ///domain. To obtain an accurate value, you must query each BDC in the domain. The last logoff occurred at the time
    ///indicated by the largest retrieved value.
    uint   usri11_last_logoff;
    ///Type: <b>DWORD</b> The number of times the user tried to log on to this account using an incorrect password. A
    ///value of – 1 indicates that the value is unknown. The NetUserAdd and NetUserSetInfo functions ignore this
    ///member. This member is replicated from the primary domain controller (PDC); it is also maintained on each backup
    ///domain controller (BDC) in the domain. To obtain an accurate value, you must query each BDC in the domain. The
    ///number of times the user tried to log on using an incorrect password is the largest value retrieved.
    uint   usri11_bad_pw_count;
    ///Type: <b>DWORD</b> The number of times the user has logged on successfully to this account. A value of – 1
    ///indicates that the value is unknown. Calls to the <b>NetUserAdd</b> and <b>NetUserSetInfo</b> functions ignore
    ///this member. This member is maintained separately on each backup domain controller (BDC) in the domain. To obtain
    ///an accurate value, you must query each BDC in the domain. The number of times the user logged on successfully is
    ///the sum of the retrieved values.
    uint   usri11_num_logons;
    ///Type: <b>LPWSTR</b> A pointer to a Unicode string that contains the name of the server to which logon requests
    ///are sent. Server names should be preceded by two backslashes (\\). To indicate that the logon request can be
    ///handled by any logon server, specify an asterisk (\\*) for the server name. A <b>NULL</b> string indicates that
    ///requests should be sent to the domain controller. For Windows servers, NetUserGetInfo and NetUserEnum return \\*.
    ///The NetUserAdd and NetUserSetInfo functions ignore this member.
    PWSTR  usri11_logon_server;
    ///Type: <b>DWORD</b> The country/region code for the user's language of choice.
    uint   usri11_country_code;
    ///Type: <b>LPWSTR</b> A pointer to a Unicode string that contains the names of workstations from which the user can
    ///log on. As many as eight workstations can be specified; the names must be separated by commas. A <b>NULL</b>
    ///string indicates that there is no restriction. To disable logons from all workstations to this account, set the
    ///UF_ACCOUNTDISABLE value in the <b>usri11_flags</b> member.
    PWSTR  usri11_workstations;
    ///Type: <b>DWORD</b> The maximum amount of disk space the user can use. Specify USER_MAXSTORAGE_UNLIMITED to use
    ///all available disk space.
    uint   usri11_max_storage;
    ///Type: <b>DWORD</b> The number of equal-length time units into which the week is divided. This value is required
    ///to compute the length of the bit string in the <b>usri11_logon_hours</b> member. This member must be
    ///UNITS_PER_WEEK for LAN Manager 2.0. This element is ignored by the NetUserAdd and NetUserSetInfo functions. For
    ///service applications, the units must be one of the following values: SAM_DAYS_PER_WEEK, SAM_HOURS_PER_WEEK, or
    ///SAM_MINUTES_PER_WEEK.
    uint   usri11_units_per_week;
    ///Type: <b>PBYTE</b> A pointer to a 21-byte (168 bits) bit string that specifies the times during which the user
    ///can log on. Each bit represents a unique hour in the week, in Greenwich Mean Time (GMT). The first bit (bit 0,
    ///word 0) is Sunday, 0:00 to 0:59; the second bit (bit 1, word 0) is Sunday, 1:00 to 1:59; and so on. Note that bit
    ///0 in word 0 represents Sunday from 0:00 to 0:59 only if you are in the GMT time zone. In all other cases you must
    ///adjust the bits according to your time zone offset (for example, GMT minus 8 hours for Pacific Standard Time).
    ///Specify a <b>NULL</b> pointer in this member when calling the NetUserAdd function to indicate no time
    ///restriction. Specify a <b>NULL</b> pointer when calling the NetUserSetInfo function to indicate that no change is
    ///to be made to the times during which the user can log on.
    ubyte* usri11_logon_hours;
    ///Type: <b>DWORD</b> The code page for the user's language of choice.
    uint   usri11_code_page;
}

///The <b>USER_INFO_20</b> structure contains information about a user account, including the account name, the user's
///full name, a comment associated with the account, and the user's relative ID (RID). <div class="alert"><b>Note</b> <p
///class="note">The USER_INFO_23 structure supersedes the <b>USER_INFO_20</b> structure. It is recommended that
///applications use the <b>USER_INFO_23</b> structure instead of the <b>USER_INFO_20</b> structure. </div><div> </div>
struct USER_INFO_20
{
    ///Type: <b>LPWSTR</b> A pointer to a Unicode string that specifies the name of the user account. Calls to the
    ///NetUserSetInfo function ignore this member. For more information, see the following Remarks section.
    PWSTR usri20_name;
    ///Type: <b>LPWSTR</b> A pointer to a Unicode string that contains the full name of the user. This string can be a
    ///null string, or it can have any number of characters before the terminating null character.
    PWSTR usri20_full_name;
    ///Type: <b>LPWSTR</b> A pointer to a Unicode string that contains a comment associated with the user account. This
    ///string can be a null string, or it can have any number of characters before the terminating null character.
    PWSTR usri20_comment;
    ///Type: <b>DWORD</b> This member can be one or more of the following values. Note that setting user account control
    ///flags may require certain privileges and control access rights. For more information, see the Remarks section of
    ///the NetUserSetInfo function. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
    ///id="UF_SCRIPT"></a><a id="uf_script"></a><dl> <dt><b>UF_SCRIPT</b></dt> </dl> </td> <td width="60%"> The logon
    ///script executed. This value must be set. </td> </tr> <tr> <td width="40%"><a id="UF_ACCOUNTDISABLE"></a><a
    ///id="uf_accountdisable"></a><dl> <dt><b>UF_ACCOUNTDISABLE</b></dt> </dl> </td> <td width="60%"> The user's account
    ///is disabled. </td> </tr> <tr> <td width="40%"><a id="UF_HOMEDIR_REQUIRED"></a><a
    ///id="uf_homedir_required"></a><dl> <dt><b>UF_HOMEDIR_REQUIRED</b></dt> </dl> </td> <td width="60%"> The home
    ///directory is required. This value is ignored. </td> </tr> <tr> <td width="40%"><a id="UF_PASSWD_NOTREQD"></a><a
    ///id="uf_passwd_notreqd"></a><dl> <dt><b>UF_PASSWD_NOTREQD</b></dt> </dl> </td> <td width="60%"> No password is
    ///required. </td> </tr> <tr> <td width="40%"><a id="UF_PASSWD_CANT_CHANGE"></a><a
    ///id="uf_passwd_cant_change"></a><dl> <dt><b>UF_PASSWD_CANT_CHANGE</b></dt> </dl> </td> <td width="60%"> The user
    ///cannot change the password. </td> </tr> <tr> <td width="40%"><a id="UF_LOCKOUT"></a><a id="uf_lockout"></a><dl>
    ///<dt><b>UF_LOCKOUT</b></dt> </dl> </td> <td width="60%"> The account is currently locked out. You can call the
    ///NetUserSetInfo function to clear this value and unlock a previously locked account. You cannot use this value to
    ///lock a previously unlocked account. </td> </tr> <tr> <td width="40%"><a id="UF_DONT_EXPIRE_PASSWD"></a><a
    ///id="uf_dont_expire_passwd"></a><dl> <dt><b>UF_DONT_EXPIRE_PASSWD</b></dt> </dl> </td> <td width="60%"> The
    ///password should never expire on the account. </td> </tr> <tr> <td width="40%"><a
    ///id="UF_ENCRYPTED_TEXT_PASSWORD_ALLOWED"></a><a id="uf_encrypted_text_password_allowed"></a><dl>
    ///<dt><b>UF_ENCRYPTED_TEXT_PASSWORD_ALLOWED</b></dt> </dl> </td> <td width="60%"> The user's password is stored
    ///under reversible encryption in the Active Directory. </td> </tr> <tr> <td width="40%"><a
    ///id="UF_NOT_DELEGATED"></a><a id="uf_not_delegated"></a><dl> <dt><b>UF_NOT_DELEGATED</b></dt> </dl> </td> <td
    ///width="60%"> Marks the account as "sensitive"; other users cannot act as delegates of this user account. </td>
    ///</tr> <tr> <td width="40%"><a id="UF_SMARTCARD_REQUIRED"></a><a id="uf_smartcard_required"></a><dl>
    ///<dt><b>UF_SMARTCARD_REQUIRED</b></dt> </dl> </td> <td width="60%"> Requires the user to log on to the user
    ///account with a smart card. </td> </tr> <tr> <td width="40%"><a id="UF_USE_DES_KEY_ONLY"></a><a
    ///id="uf_use_des_key_only"></a><dl> <dt><b>UF_USE_DES_KEY_ONLY</b></dt> </dl> </td> <td width="60%"> Restrict this
    ///principal to use only Data Encryption Standard (DES) encryption types for keys. </td> </tr> <tr> <td
    ///width="40%"><a id="UF_DONT_REQUIRE_PREAUTH"></a><a id="uf_dont_require_preauth"></a><dl>
    ///<dt><b>UF_DONT_REQUIRE_PREAUTH</b></dt> </dl> </td> <td width="60%"> This account does not require Kerberos
    ///preauthentication for logon. </td> </tr> <tr> <td width="40%"><a id="UF_TRUSTED_FOR_DELEGATION"></a><a
    ///id="uf_trusted_for_delegation"></a><dl> <dt><b>UF_TRUSTED_FOR_DELEGATION</b></dt> </dl> </td> <td width="60%">
    ///The account is enabled for delegation. This is a security-sensitive setting; accounts with this option enabled
    ///should be tightly controlled. This setting allows a service running under the account to assume a client's
    ///identity and authenticate as that user to other remote servers on the network. </td> </tr> <tr> <td
    ///width="40%"><a id="UF_PASSWORD_EXPIRED"></a><a id="uf_password_expired"></a><dl>
    ///<dt><b>UF_PASSWORD_EXPIRED</b></dt> </dl> </td> <td width="60%"> The user's password has expired. <b>Windows
    ///2000: </b>This value is not supported. </td> </tr> <tr> <td width="40%"><a
    ///id="UF_TRUSTED_TO_AUTHENTICATE_FOR_DELEGATION"></a><a id="uf_trusted_to_authenticate_for_delegation"></a><dl>
    ///<dt><b>UF_TRUSTED_TO_AUTHENTICATE_FOR_DELEGATION</b></dt> </dl> </td> <td width="60%"> The account is trusted to
    ///authenticate a user outside of the Kerberos security package and delegate that user through constrained
    ///delegation. This is a security-sensitive setting; accounts with this option enabled should be tightly controlled.
    ///This setting allows a service running under the account to assert a client's identity and authenticate as that
    ///user to specifically configured services on the network. <b>Windows XP/2000: </b>This value is not supported.
    ///</td> </tr> </table> The following values describe the account type. Only one value can be set. You cannot change
    ///the account type using the NetUserSetInfo function. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td
    ///width="40%"><a id="UF_NORMAL_ACCOUNT"></a><a id="uf_normal_account"></a><dl> <dt><b>UF_NORMAL_ACCOUNT</b></dt>
    ///</dl> </td> <td width="60%"> This is a default account type that represents a typical user. </td> </tr> <tr> <td
    ///width="40%"><a id="UF_TEMP_DUPLICATE_ACCOUNT"></a><a id="uf_temp_duplicate_account"></a><dl>
    ///<dt><b>UF_TEMP_DUPLICATE_ACCOUNT</b></dt> </dl> </td> <td width="60%"> This is an account for users whose primary
    ///account is in another domain. This account provides user access to this domain, but not to any domain that trusts
    ///this domain. The User Manager refers to this account type as a local user account. </td> </tr> <tr> <td
    ///width="40%"><a id="UF_WORKSTATION_TRUST_ACCOUNT"></a><a id="uf_workstation_trust_account"></a><dl>
    ///<dt><b>UF_WORKSTATION_TRUST_ACCOUNT</b></dt> </dl> </td> <td width="60%"> This is a computer account for a
    ///computer that is a member of this domain. </td> </tr> <tr> <td width="40%"><a id="UF_SERVER_TRUST_ACCOUNT"></a><a
    ///id="uf_server_trust_account"></a><dl> <dt><b>UF_SERVER_TRUST_ACCOUNT</b></dt> </dl> </td> <td width="60%"> This
    ///is a computer account for a backup domain controller that is a member of this domain. </td> </tr> <tr> <td
    ///width="40%"><a id="UF_INTERDOMAIN_TRUST_ACCOUNT"></a><a id="uf_interdomain_trust_account"></a><dl>
    ///<dt><b>UF_INTERDOMAIN_TRUST_ACCOUNT</b></dt> </dl> </td> <td width="60%"> This is a permit to trust account for a
    ///domain that trusts other domains. </td> </tr> </table>
    uint  usri20_flags;
    ///Type: <b>DWORD</b> The user's relative identifier (RID). The RID is determined by the Security Account Manager
    ///(SAM) when the user is created. It uniquely defines this user account to SAM within the domain. The NetUserAdd
    ///and NetUserSetInfo functions ignore this member. For more information about RIDs, see SID Components.
    uint  usri20_user_id;
}

///The <b>USER_INFO_21</b> structure contains a one-way encrypted LAN Manager 2.<i>x</i>-compatible password.
struct USER_INFO_21
{
    ///Specifies a one-way encrypted LAN Manager 2.<i>x</i>-compatible password.
    ubyte[16] usri21_password;
}

///The <b>USER_INFO_22</b> structure contains information about a user account, including the account name, privilege
///level, the path to the user's home directory, a one-way encrypted LAN Manager 2.<i>x</i>-compatible password, and
///other user-related network statistics.
struct USER_INFO_22
{
    ///Type: <b>LPWSTR</b> A pointer to a Unicode string that specifies the name of the user account. Calls to the
    ///NetUserSetInfo function ignore this member. For more information, see the following Remarks section.
    PWSTR     usri22_name;
    ///Type: <b>BYTE[ENCRYPTED_PWLEN]</b> A one-way encrypted LAN Manager 2.<i>x</i>-compatible password.
    ubyte[16] usri22_password;
    ///Type: <b>DWORD</b> The number of seconds that have elapsed since the <b>usri22_password</b> member was last
    ///changed. The NetUserAdd and NetUserSetInfo functions ignore this member.
    uint      usri22_password_age;
    ///Type: <b>DWORD</b> The level of privilege assigned to the <b>usri22_name</b> member. Calls to the
    ///<b>NetUserAdd</b> function must specify USER_PRIV_USER. When you call the <b>NetUserSetInfo</b> function this
    ///member must be the value returned from the NetUserGetInfo or the NetUserEnum function. This member can be one of
    ///the following values. For more information about user and group account rights, see Privileges. <table> <tr>
    ///<th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="USER_PRIV_GUEST"></a><a
    ///id="user_priv_guest"></a><dl> <dt><b>USER_PRIV_GUEST</b></dt> </dl> </td> <td width="60%"> Guest </td> </tr> <tr>
    ///<td width="40%"><a id="USER_PRIV_USER"></a><a id="user_priv_user"></a><dl> <dt><b>USER_PRIV_USER</b></dt> </dl>
    ///</td> <td width="60%"> User </td> </tr> <tr> <td width="40%"><a id="USER_PRIV_ADMIN"></a><a
    ///id="user_priv_admin"></a><dl> <dt><b>USER_PRIV_ADMIN</b></dt> </dl> </td> <td width="60%"> Administrator </td>
    ///</tr> </table>
    uint      usri22_priv;
    ///Type: <b>LPWSTR</b> A pointer to a Unicode string specifying the path of the home directory for the user
    ///specified by the <b>usri22_name</b> member. The string can be null.
    PWSTR     usri22_home_dir;
    ///Type: <b>LPWSTR</b> A pointer to a Unicode string that contains a comment associated with the user account. This
    ///string can be a null string, or it can have any number of characters before the terminating null character.
    PWSTR     usri22_comment;
    ///Type: <b>DWORD</b> This member can be one or more of the following values. Note that setting user account control
    ///flags may require certain privileges and control access rights. For more information, see the Remarks section of
    ///the NetUserSetInfo function. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
    ///id="UF_SCRIPT"></a><a id="uf_script"></a><dl> <dt><b>UF_SCRIPT</b></dt> </dl> </td> <td width="60%"> The logon
    ///script executed. This value must be set. </td> </tr> <tr> <td width="40%"><a id="UF_ACCOUNTDISABLE"></a><a
    ///id="uf_accountdisable"></a><dl> <dt><b>UF_ACCOUNTDISABLE</b></dt> </dl> </td> <td width="60%"> The user's account
    ///is disabled. </td> </tr> <tr> <td width="40%"><a id="UF_HOMEDIR_REQUIRED"></a><a
    ///id="uf_homedir_required"></a><dl> <dt><b>UF_HOMEDIR_REQUIRED</b></dt> </dl> </td> <td width="60%"> The home
    ///directory is required. This value is ignored. </td> </tr> <tr> <td width="40%"><a id="UF_PASSWD_NOTREQD"></a><a
    ///id="uf_passwd_notreqd"></a><dl> <dt><b>UF_PASSWD_NOTREQD</b></dt> </dl> </td> <td width="60%"> No password is
    ///required. </td> </tr> <tr> <td width="40%"><a id="UF_PASSWD_CANT_CHANGE"></a><a
    ///id="uf_passwd_cant_change"></a><dl> <dt><b>UF_PASSWD_CANT_CHANGE</b></dt> </dl> </td> <td width="60%"> The user
    ///cannot change the password. </td> </tr> <tr> <td width="40%"><a id="UF_LOCKOUT"></a><a id="uf_lockout"></a><dl>
    ///<dt><b>UF_LOCKOUT</b></dt> </dl> </td> <td width="60%"> The account is currently locked out. You can call the
    ///NetUserSetInfo function to clear this value and unlock a previously locked account. You cannot use this value to
    ///lock a previously unlocked account. </td> </tr> <tr> <td width="40%"><a id="UF_DONT_EXPIRE_PASSWD"></a><a
    ///id="uf_dont_expire_passwd"></a><dl> <dt><b>UF_DONT_EXPIRE_PASSWD</b></dt> </dl> </td> <td width="60%"> The
    ///password should never expire on the account. </td> </tr> <tr> <td width="40%"><a
    ///id="UF_ENCRYPTED_TEXT_PASSWORD_ALLOWED"></a><a id="uf_encrypted_text_password_allowed"></a><dl>
    ///<dt><b>UF_ENCRYPTED_TEXT_PASSWORD_ALLOWED</b></dt> </dl> </td> <td width="60%"> The user's password is stored
    ///under reversible encryption in the Active Directory. </td> </tr> <tr> <td width="40%"><a
    ///id="UF_NOT_DELEGATED"></a><a id="uf_not_delegated"></a><dl> <dt><b>UF_NOT_DELEGATED</b></dt> </dl> </td> <td
    ///width="60%"> Marks the account as "sensitive"; other users cannot act as delegates of this user account. </td>
    ///</tr> <tr> <td width="40%"><a id="UF_SMARTCARD_REQUIRED"></a><a id="uf_smartcard_required"></a><dl>
    ///<dt><b>UF_SMARTCARD_REQUIRED</b></dt> </dl> </td> <td width="60%"> Requires the user to log on to the user
    ///account with a smart card. </td> </tr> <tr> <td width="40%"><a id="UF_USE_DES_KEY_ONLY"></a><a
    ///id="uf_use_des_key_only"></a><dl> <dt><b>UF_USE_DES_KEY_ONLY</b></dt> </dl> </td> <td width="60%"> Restrict this
    ///principal to use only Data Encryption Standard (DES) encryption types for keys. </td> </tr> <tr> <td
    ///width="40%"><a id="UF_DONT_REQUIRE_PREAUTH"></a><a id="uf_dont_require_preauth"></a><dl>
    ///<dt><b>UF_DONT_REQUIRE_PREAUTH</b></dt> </dl> </td> <td width="60%"> This account does not require Kerberos
    ///preauthentication for logon. </td> </tr> <tr> <td width="40%"><a id="UF_TRUSTED_FOR_DELEGATION"></a><a
    ///id="uf_trusted_for_delegation"></a><dl> <dt><b>UF_TRUSTED_FOR_DELEGATION</b></dt> </dl> </td> <td width="60%">
    ///The account is enabled for delegation. This is a security-sensitive setting; accounts with this option enabled
    ///should be tightly controlled. This setting allows a service running under the account to assume a client's
    ///identity and authenticate as that user to other remote servers on the network. </td> </tr> <tr> <td
    ///width="40%"><a id="UF_PASSWORD_EXPIRED"></a><a id="uf_password_expired"></a><dl>
    ///<dt><b>UF_PASSWORD_EXPIRED</b></dt> </dl> </td> <td width="60%"> The user's password has expired. <b>Windows
    ///2000: </b>This value is not supported. </td> </tr> <tr> <td width="40%"><a
    ///id="UF_TRUSTED_TO_AUTHENTICATE_FOR_DELEGATION"></a><a id="uf_trusted_to_authenticate_for_delegation"></a><dl>
    ///<dt><b>UF_TRUSTED_TO_AUTHENTICATE_FOR_DELEGATION</b></dt> </dl> </td> <td width="60%"> The account is trusted to
    ///authenticate a user outside of the Kerberos security package and delegate that user through constrained
    ///delegation. This is a security-sensitive setting; accounts with this option enabled should be tightly controlled.
    ///This setting allows a service running under the account to assert a client's identity and authenticate as that
    ///user to specifically configured services on the network. <b>Windows XP/2000: </b>This value is not supported.
    ///</td> </tr> </table> The following values describe the account type. Only one value can be set. You cannot change
    ///the account type using the NetUserSetInfo function. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td
    ///width="40%"><a id="UF_NORMAL_ACCOUNT"></a><a id="uf_normal_account"></a><dl> <dt><b>UF_NORMAL_ACCOUNT</b></dt>
    ///</dl> </td> <td width="60%"> This is a default account type that represents a typical user. </td> </tr> <tr> <td
    ///width="40%"><a id="UF_TEMP_DUPLICATE_ACCOUNT"></a><a id="uf_temp_duplicate_account"></a><dl>
    ///<dt><b>UF_TEMP_DUPLICATE_ACCOUNT</b></dt> </dl> </td> <td width="60%"> This is an account for users whose primary
    ///account is in another domain. This account provides user access to this domain, but not to any domain that trusts
    ///this domain. The User Manager refers to this account type as a local user account. </td> </tr> <tr> <td
    ///width="40%"><a id="UF_WORKSTATION_TRUST_ACCOUNT"></a><a id="uf_workstation_trust_account"></a><dl>
    ///<dt><b>UF_WORKSTATION_TRUST_ACCOUNT</b></dt> </dl> </td> <td width="60%"> This is a computer account for a
    ///computer that is a member of this domain. </td> </tr> <tr> <td width="40%"><a id="UF_SERVER_TRUST_ACCOUNT"></a><a
    ///id="uf_server_trust_account"></a><dl> <dt><b>UF_SERVER_TRUST_ACCOUNT</b></dt> </dl> </td> <td width="60%"> This
    ///is a computer account for a backup domain controller that is a member of this domain. </td> </tr> <tr> <td
    ///width="40%"><a id="UF_INTERDOMAIN_TRUST_ACCOUNT"></a><a id="uf_interdomain_trust_account"></a><dl>
    ///<dt><b>UF_INTERDOMAIN_TRUST_ACCOUNT</b></dt> </dl> </td> <td width="60%"> This is a permit to trust account for a
    ///domain that trusts other domains. </td> </tr> </table>
    uint      usri22_flags;
    ///Type: <b>LPWSTR</b> A pointer to a Unicode string specifying the path for the user's logon script file. The
    ///script file can be a .CMD file, an .EXE file, or a .BAT file. The string can also be null.
    PWSTR     usri22_script_path;
    ///Type: <b>DWORD</b> The user's operator privileges. Calls to the <b>NetUserGetInfo</b> function and the
    ///<b>NetUserEnum</b> function return a value based on the user's local group membership. If the user is a member of
    ///Print Operators, AF_OP_PRINT, is set. If the user is a member of Server Operators, AF_OP_SERVER, is set. If the
    ///user is a member of the Account Operators, AF_OP_ACCOUNTS, is set. AF_OP_COMM is never set. The following
    ///restrictions apply: <ul> <li>When you call the NetUserAdd function, this member must be zero.</li> <li>When you
    ///call the NetUserSetInfo function, this member must be the value returned from a call to NetUserGetInfo or to
    ///NetUserEnum.</li> </ul> This member can be one or more of the following values. <table> <tr> <th>Value</th>
    ///<th>Meaning</th> </tr> <tr> <td width="40%"><a id="AF_OP_PRINT"></a><a id="af_op_print"></a><dl>
    ///<dt><b>AF_OP_PRINT</b></dt> </dl> </td> <td width="60%"> The print operator privilege is enabled. </td> </tr>
    ///<tr> <td width="40%"><a id="AF_OP_COMM"></a><a id="af_op_comm"></a><dl> <dt><b>AF_OP_COMM</b></dt> </dl> </td>
    ///<td width="60%"> The communications operator privilege is enabled. </td> </tr> <tr> <td width="40%"><a
    ///id="AF_OP_SERVER"></a><a id="af_op_server"></a><dl> <dt><b>AF_OP_SERVER</b></dt> </dl> </td> <td width="60%"> The
    ///server operator privilege is enabled. </td> </tr> <tr> <td width="40%"><a id="AF_OP_ACCOUNTS"></a><a
    ///id="af_op_accounts"></a><dl> <dt><b>AF_OP_ACCOUNTS</b></dt> </dl> </td> <td width="60%"> The accounts operator
    ///privilege is enabled. </td> </tr> </table>
    uint      usri22_auth_flags;
    ///Type: <b>LPWSTR</b> A pointer to a Unicode string that contains the full name of the user. This string can be a
    ///null string, or it can have any number of characters before the terminating null character.
    PWSTR     usri22_full_name;
    ///Type: <b>LPWSTR</b> A pointer to a Unicode string that contains a user comment. This string can be a null string,
    ///or it can have any number of characters before the terminating null character.
    PWSTR     usri22_usr_comment;
    ///Type: <b>LPWSTR</b> A pointer to a Unicode string that is reserved for use by applications. This string can be a
    ///null string, or it can have any number of characters before the terminating null character. Microsoft products
    ///use this member to store user configuration information. Do not modify this information.
    PWSTR     usri22_parms;
    ///Type: <b>LPWSTR</b> > [!IMPORTANT] > You should no longer use **usri22_workstations**. Instead, you can control
    ///sign-in access to workstations by configuring the User Rights Assignment settings (**Allow log on locally** and
    ///**Deny log on locally**, or **Allow log on through Remote Desktop Services** and **Deny log on through Remote
    ///Desktop Services**). A pointer to a Unicode string that contains the names of workstations from which the user
    ///can log on. As many as eight workstations can be specified; the names must be separated by commas. A null string
    ///indicates that there is no restriction. To disable logons from all workstations to this account, set the
    ///UF_ACCOUNTDISABLE value in the <b>usri22_flags</b> member.
    PWSTR     usri22_workstations;
    ///Type: <b>DWORD</b> The date and time when the last logon occurred. This value is stored as the number of seconds
    ///that have elapsed since 00:00:00, January 1, 1970, GMT. Calls to the NetUserAdd and the NetUserSetInfo functions
    ///ignore this member. This member is maintained separately on each backup domain controller (BDC) in the domain. To
    ///obtain an accurate value, you must query each BDC in the domain. The last logon occurred at the time indicated by
    ///the largest retrieved value.
    uint      usri22_last_logon;
    ///Type: <b>DWORD</b> This member is currently not used. The date and time when the last logoff occurred. This value
    ///is stored as the number of seconds that have elapsed since 00:00:00, January 1, 1970, GMT. A value of zero means
    ///that the last logoff time is unknown. This element is ignored by calls to <b>NetUserAdd</b> and
    ///<b>NetUserSetInfo</b>. This member is maintained separately on each backup domain controller (BDC) in the domain.
    ///To obtain an accurate value, you must query each BDC in the domain. The last logoff occurred at the time
    ///indicated by the largest retrieved value.
    uint      usri22_last_logoff;
    ///Type: <b>DWORD</b> The date and time when the account expires. This value is stored as the number of seconds that
    ///have elapsed since 00:00:00, January 1, 1970, GMT. A value of TIMEQ_FOREVER indicates that the account never
    ///expires.
    uint      usri22_acct_expires;
    ///Type: <b>DWORD</b> The maximum amount of disk space the user can use. Specify USER_MAXSTORAGE_UNLIMITED to use
    ///all available disk space.
    uint      usri22_max_storage;
    ///Type: <b>DWORD</b> The number of equal-length time units into which the week is divided. This value is required
    ///to compute the length of the bit string in the <b>usri22_logon_hours</b> member. This value must be
    ///UNITS_PER_WEEK for LAN Manager 2.0. Calls to the NetUserAdd and NetUserSetInfo functions ignore this member. For
    ///service applications, the units must be one of the following: SAM_DAYS_PER_WEEK, SAM_HOURS_PER_WEEK, or
    ///SAM_MINUTES_PER_WEEK.
    uint      usri22_units_per_week;
    ///Type: <b>PBYTE</b> A pointer to a 21-byte (168 bits) bit string that specifies the times during which the user
    ///can log on. Each bit represents a unique hour in the week, in Greenwich Mean Time (GMT). The first bit (bit 0,
    ///word 0) is Sunday, 0:00 to 0:59; the second bit (bit 1, word 0) is Sunday, 1:00 to 1:59; and so on. Note that bit
    ///0 in word 0 represents Sunday from 0:00 to 0:59 only if you are in the GMT time zone. In all other cases you must
    ///adjust the bits according to your time zone offset (for example, GMT minus 8 hours for Pacific Standard Time).
    ///Specify a null pointer in this member when calling the NetUserAdd function to indicate no time restriction.
    ///Specify a null pointer when calling the NetUserSetInfo function to indicate that no change is to be made to the
    ///times during which the user can log on.
    ubyte*    usri22_logon_hours;
    ///Type: <b>DWORD</b> The number of times the user tried to log on to this account using an incorrect password. A
    ///value of – 1 indicates that the value is unknown. Calls to the NetUserAdd and NetUserSetInfo functions ignore
    ///this member. This member is replicated from the primary domain controller (PDC); it is also maintained on each
    ///backup domain controller (BDC) in the domain. To obtain an accurate value, you must query each BDC in the domain.
    ///The number of times the user tried to log on using an incorrect password is the largest value retrieved.
    uint      usri22_bad_pw_count;
    ///Type: <b>DWORD</b> The number of times the user logged on successfully to this account. A value of – 1
    ///indicates that the value is unknown. Calls to the <b>NetUserAdd</b> and <b>NetUserSetInfo</b> functions ignore
    ///this member. This member is maintained separately on each backup domain controller (BDC) in the domain. To obtain
    ///an accurate value, you must query each BDC in the domain. The number of times the user logged on successfully is
    ///the sum of the retrieved values.
    uint      usri22_num_logons;
    ///Type: <b>LPWSTR</b> A pointer to a Unicode string that contains the name of the server to which logon requests
    ///are sent. Server names should be preceded by two backslashes (\\). To indicate that the logon request can be
    ///handled by any logon server, specify an asterisk (\\*) for the server name. A null string indicates that requests
    ///should be sent to the domain controller. For Windows servers, the NetUserGetInfo and NetUserEnum functions return
    ///\\*. Calls to the NetUserAdd and NetUserSetInfo functions ignore this member.
    PWSTR     usri22_logon_server;
    ///Type: <b>DWORD</b> The country/region code for the user's language of choice. This value is ignored.
    uint      usri22_country_code;
    ///Type: <b>DWORD</b> The code page for the user's language of choice. This value is ignored.
    uint      usri22_code_page;
}

///The <b>USER_INFO_23</b> structure contains information about a user account, including the account name, the user's
///full name, a comment associated with the account, and the user's security identifier (SID). <div
///class="alert"><b>Note</b> <p class="note">The <b>USER_INFO_23</b> structure supersedes the USER_INFO_20 structure. It
///is recommended that applications use the <b>USER_INFO_23</b> structure instead of the <b>USER_INFO_20</b> structure.
///</div><div> </div>
struct USER_INFO_23
{
    ///Type: <b>LPWSTR</b> A pointer to a Unicode string that specifies the name of the user account. Calls to the
    ///NetUserSetInfo function ignore this member.
    PWSTR usri23_name;
    ///Type: <b>LPWSTR</b> A pointer to a Unicode string that contains the full name of the user. This string can be a
    ///null string, or it can have any number of characters before the terminating null character.
    PWSTR usri23_full_name;
    ///Type: <b>LPWSTR</b> A pointer to a Unicode string that contains a comment associated with the user account. This
    ///string can be a null string, or it can have any number of characters before the terminating null character.
    PWSTR usri23_comment;
    ///Type: <b>DWORD</b> This member can be one or more of the following values. Note that setting user account control
    ///flags may require certain privileges and control access rights. For more information, see the Remarks section of
    ///the NetUserSetInfo function. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
    ///id="UF_SCRIPT"></a><a id="uf_script"></a><dl> <dt><b>UF_SCRIPT</b></dt> </dl> </td> <td width="60%"> The logon
    ///script executed. This value must be set. </td> </tr> <tr> <td width="40%"><a id="UF_ACCOUNTDISABLE"></a><a
    ///id="uf_accountdisable"></a><dl> <dt><b>UF_ACCOUNTDISABLE</b></dt> </dl> </td> <td width="60%"> The user's account
    ///is disabled. </td> </tr> <tr> <td width="40%"><a id="UF_HOMEDIR_REQUIRED"></a><a
    ///id="uf_homedir_required"></a><dl> <dt><b>UF_HOMEDIR_REQUIRED</b></dt> </dl> </td> <td width="60%"> The home
    ///directory is required. This value is ignored. </td> </tr> <tr> <td width="40%"><a id="UF_PASSWD_NOTREQD"></a><a
    ///id="uf_passwd_notreqd"></a><dl> <dt><b>UF_PASSWD_NOTREQD</b></dt> </dl> </td> <td width="60%"> No password is
    ///required. </td> </tr> <tr> <td width="40%"><a id="UF_PASSWD_CANT_CHANGE"></a><a
    ///id="uf_passwd_cant_change"></a><dl> <dt><b>UF_PASSWD_CANT_CHANGE</b></dt> </dl> </td> <td width="60%"> The user
    ///cannot change the password. </td> </tr> <tr> <td width="40%"><a id="UF_LOCKOUT"></a><a id="uf_lockout"></a><dl>
    ///<dt><b>UF_LOCKOUT</b></dt> </dl> </td> <td width="60%"> The account is currently locked out. You can call the
    ///NetUserSetInfo function to clear this value and unlock a previously locked account. You cannot use this value to
    ///lock a previously unlocked account. </td> </tr> <tr> <td width="40%"><a id="UF_DONT_EXPIRE_PASSWD"></a><a
    ///id="uf_dont_expire_passwd"></a><dl> <dt><b>UF_DONT_EXPIRE_PASSWD</b></dt> </dl> </td> <td width="60%"> The
    ///password should never expire on the account. </td> </tr> <tr> <td width="40%"><a
    ///id="UF_ENCRYPTED_TEXT_PASSWORD_ALLOWED"></a><a id="uf_encrypted_text_password_allowed"></a><dl>
    ///<dt><b>UF_ENCRYPTED_TEXT_PASSWORD_ALLOWED</b></dt> </dl> </td> <td width="60%"> The user's password is stored
    ///under reversible encryption in the Active Directory. </td> </tr> <tr> <td width="40%"><a
    ///id="UF_NOT_DELEGATED"></a><a id="uf_not_delegated"></a><dl> <dt><b>UF_NOT_DELEGATED</b></dt> </dl> </td> <td
    ///width="60%"> Marks the account as "sensitive"; other users cannot act as delegates of this user account. </td>
    ///</tr> <tr> <td width="40%"><a id="UF_SMARTCARD_REQUIRED"></a><a id="uf_smartcard_required"></a><dl>
    ///<dt><b>UF_SMARTCARD_REQUIRED</b></dt> </dl> </td> <td width="60%"> Requires the user to log on to the user
    ///account with a smart card. </td> </tr> <tr> <td width="40%"><a id="UF_USE_DES_KEY_ONLY"></a><a
    ///id="uf_use_des_key_only"></a><dl> <dt><b>UF_USE_DES_KEY_ONLY</b></dt> </dl> </td> <td width="60%"> Restrict this
    ///principal to use only Data Encryption Standard (DES) encryption types for keys. </td> </tr> <tr> <td
    ///width="40%"><a id="UF_DONT_REQUIRE_PREAUTH"></a><a id="uf_dont_require_preauth"></a><dl>
    ///<dt><b>UF_DONT_REQUIRE_PREAUTH</b></dt> </dl> </td> <td width="60%"> This account does not require Kerberos
    ///preauthentication for logon. </td> </tr> <tr> <td width="40%"><a id="UF_TRUSTED_FOR_DELEGATION"></a><a
    ///id="uf_trusted_for_delegation"></a><dl> <dt><b>UF_TRUSTED_FOR_DELEGATION</b></dt> </dl> </td> <td width="60%">
    ///The account is enabled for delegation. This is a security-sensitive setting; accounts with this option enabled
    ///should be tightly controlled. This setting allows a service running under the account to assume a client's
    ///identity and authenticate as that user to other remote servers on the network. </td> </tr> <tr> <td
    ///width="40%"><a id="UF_PASSWORD_EXPIRED"></a><a id="uf_password_expired"></a><dl>
    ///<dt><b>UF_PASSWORD_EXPIRED</b></dt> </dl> </td> <td width="60%"> The user's password has expired. <b>Windows
    ///2000: </b>This value is not supported. </td> </tr> <tr> <td width="40%"><a
    ///id="UF_TRUSTED_TO_AUTHENTICATE_FOR_DELEGATION"></a><a id="uf_trusted_to_authenticate_for_delegation"></a><dl>
    ///<dt><b>UF_TRUSTED_TO_AUTHENTICATE_FOR_DELEGATION</b></dt> </dl> </td> <td width="60%"> The account is trusted to
    ///authenticate a user outside of the Kerberos security package and delegate that user through constrained
    ///delegation. This is a security-sensitive setting; accounts with this option enabled should be tightly controlled.
    ///This setting allows a service running under the account to assert a client's identity and authenticate as that
    ///user to specifically configured services on the network. <b>Windows XP/2000: </b>This value is not supported.
    ///</td> </tr> </table> The following values describe the account type. Only one value can be set. You cannot change
    ///the account type using the NetUserSetInfo function. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td
    ///width="40%"><a id="UF_NORMAL_ACCOUNT"></a><a id="uf_normal_account"></a><dl> <dt><b>UF_NORMAL_ACCOUNT</b></dt>
    ///</dl> </td> <td width="60%"> This is a default account type that represents a typical user. </td> </tr> <tr> <td
    ///width="40%"><a id="UF_TEMP_DUPLICATE_ACCOUNT"></a><a id="uf_temp_duplicate_account"></a><dl>
    ///<dt><b>UF_TEMP_DUPLICATE_ACCOUNT</b></dt> </dl> </td> <td width="60%"> This is an account for users whose primary
    ///account is in another domain. This account provides user access to this domain, but not to any domain that trusts
    ///this domain. The User Manager refers to this account type as a local user account. </td> </tr> <tr> <td
    ///width="40%"><a id="UF_WORKSTATION_TRUST_ACCOUNT"></a><a id="uf_workstation_trust_account"></a><dl>
    ///<dt><b>UF_WORKSTATION_TRUST_ACCOUNT</b></dt> </dl> </td> <td width="60%"> This is a computer account for a
    ///computer that is a member of this domain. </td> </tr> <tr> <td width="40%"><a id="UF_SERVER_TRUST_ACCOUNT"></a><a
    ///id="uf_server_trust_account"></a><dl> <dt><b>UF_SERVER_TRUST_ACCOUNT</b></dt> </dl> </td> <td width="60%"> This
    ///is a computer account for a backup domain controller that is a member of this domain. </td> </tr> <tr> <td
    ///width="40%"><a id="UF_INTERDOMAIN_TRUST_ACCOUNT"></a><a id="uf_interdomain_trust_account"></a><dl>
    ///<dt><b>UF_INTERDOMAIN_TRUST_ACCOUNT</b></dt> </dl> </td> <td width="60%"> This is a permit to trust account for a
    ///domain that trusts other domains. </td> </tr> </table>
    uint  usri23_flags;
    ///Type: <b>PSID</b> A pointer to a SID structure that contains the security identifier (SID) that uniquely
    ///identifies the user. The NetUserAdd and NetUserSetInfo functions ignore this member.
    void* usri23_user_sid;
}

///The <b>USER_INFO_24</b> structure contains user account information on an account which is connected to an Internet
///identity. This information includes the Internet provider name for the user, the user's Internet name, and the user's
///security identifier (SID).
struct USER_INFO_24
{
    ///A boolean value that indicates whether an account is connected to an Internet identity. This member is true if
    ///the account is connected to an Internet identity. The other members in this structure can be used. If this member
    ///is false, then the account is not connected to an Internet identity and other members in this structure should be
    ///ignored.
    BOOL  usri24_internet_identity;
    ///A set of flags. This member must be zero.
    uint  usri24_flags;
    ///A pointer to a Unicode string that specifies the Internet provider name.
    PWSTR usri24_internet_provider_name;
    ///A pointer to a Unicode string that specifies the user's Internet name.
    PWSTR usri24_internet_principal_name;
    ///The local account SID of the user.
    void* usri24_user_sid;
}

///The <b>USER_INFO_1003</b> structure contains a user password. This information level is valid only when you call the
///NetUserSetInfo function.
struct USER_INFO_1003
{
    ///Specifies a Unicode string that contains the password for the user account specified in the <i>username</i>
    ///parameter to the <b>NetUserSetInfo</b> function. The length cannot exceed PWLEN bytes.
    PWSTR usri1003_password;
}

///The <b>USER_INFO_1005</b> structure contains a privilege level to assign to a user network account. This information
///level is valid only when you call the NetUserSetInfo function.
struct USER_INFO_1005
{
    ///Specifies a <b>DWORD</b> value that indicates the level of privilege to assign for the user account specified in
    ///the <i>username</i> parameter to the <b>NetUserSetInfo</b> function. This member can be one of the following
    ///values. For more information about user and group account rights, see Privileges. <table> <tr> <th>Value</th>
    ///<th>Meaning</th> </tr> <tr> <td width="40%"><a id="USER_PRIV_GUEST"></a><a id="user_priv_guest"></a><dl>
    ///<dt><b>USER_PRIV_GUEST</b></dt> </dl> </td> <td width="60%"> Guest </td> </tr> <tr> <td width="40%"><a
    ///id="USER_PRIV_USER"></a><a id="user_priv_user"></a><dl> <dt><b>USER_PRIV_USER</b></dt> </dl> </td> <td
    ///width="60%"> User </td> </tr> <tr> <td width="40%"><a id="USER_PRIV_ADMIN"></a><a id="user_priv_admin"></a><dl>
    ///<dt><b>USER_PRIV_ADMIN</b></dt> </dl> </td> <td width="60%"> Administrator </td> </tr> </table>
    uint usri1005_priv;
}

///The <b>USER_INFO_1006</b> structure contains the user's home directory path. This information level is valid only
///when you call the NetUserSetInfo function.
struct USER_INFO_1006
{
    ///Pointer to a Unicode string specifying the path of the home directory for the user account specified in the
    ///<i>username</i> parameter to the <b>NetUserSetInfo</b> function. The string can be null.
    PWSTR usri1006_home_dir;
}

///The <b>USER_INFO_1007</b> structure contains a comment associated with a user network account. This information level
///is valid only when you call the NetUserSetInfo function.
struct USER_INFO_1007
{
    ///Pointer to a Unicode string that contains a comment to associate with the user account specified in the
    ///<i>username</i> parameter to the <b>NetUserSetInfo</b> function. This string can be a null string, or it can have
    ///any number of characters before the terminating null character.
    PWSTR usri1007_comment;
}

///The <b>USER_INFO_1008</b> structure contains a set of bit flags defining several user network account parameters.
///This information level is valid only when you call the NetUserSetInfo function.
struct USER_INFO_1008
{
    ///The features to associate with the user account specified in the <i>username</i> parameter to the
    ///<b>NetUserSetInfo</b> function. This member can be one or more of the following values. Note that setting user
    ///account control flags may require certain privileges and control access rights. For more information, see the
    ///Remarks section of the NetUserSetInfo function. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td
    ///width="40%"><a id="UF_SCRIPT"></a><a id="uf_script"></a><dl> <dt><b>UF_SCRIPT</b></dt> </dl> </td> <td
    ///width="60%"> The logon script executed. This value must be set. </td> </tr> <tr> <td width="40%"><a
    ///id="UF_ACCOUNTDISABLE"></a><a id="uf_accountdisable"></a><dl> <dt><b>UF_ACCOUNTDISABLE</b></dt> </dl> </td> <td
    ///width="60%"> The user's account is disabled. </td> </tr> <tr> <td width="40%"><a id="UF_HOMEDIR_REQUIRED"></a><a
    ///id="uf_homedir_required"></a><dl> <dt><b>UF_HOMEDIR_REQUIRED</b></dt> </dl> </td> <td width="60%"> The home
    ///directory is required. This value is ignored. </td> </tr> <tr> <td width="40%"><a id="UF_PASSWD_NOTREQD"></a><a
    ///id="uf_passwd_notreqd"></a><dl> <dt><b>UF_PASSWD_NOTREQD</b></dt> </dl> </td> <td width="60%"> No password is
    ///required. </td> </tr> <tr> <td width="40%"><a id="UF_PASSWD_CANT_CHANGE"></a><a
    ///id="uf_passwd_cant_change"></a><dl> <dt><b>UF_PASSWD_CANT_CHANGE</b></dt> </dl> </td> <td width="60%"> The user
    ///cannot change the password. </td> </tr> <tr> <td width="40%"><a id="UF_LOCKOUT"></a><a id="uf_lockout"></a><dl>
    ///<dt><b>UF_LOCKOUT</b></dt> </dl> </td> <td width="60%"> The account is currently locked out. You can call the
    ///NetUserSetInfo function to clear this value and unlock a previously locked account. You cannot use this value to
    ///lock a previously unlocked account. </td> </tr> <tr> <td width="40%"><a id="UF_DONT_EXPIRE_PASSWD"></a><a
    ///id="uf_dont_expire_passwd"></a><dl> <dt><b>UF_DONT_EXPIRE_PASSWD</b></dt> </dl> </td> <td width="60%"> The
    ///password should never expire on the account. </td> </tr> <tr> <td width="40%"><a
    ///id="UF_ENCRYPTED_TEXT_PASSWORD_ALLOWED"></a><a id="uf_encrypted_text_password_allowed"></a><dl>
    ///<dt><b>UF_ENCRYPTED_TEXT_PASSWORD_ALLOWED</b></dt> </dl> </td> <td width="60%"> The user's password is stored
    ///under reversible encryption in the Active Directory. </td> </tr> <tr> <td width="40%"><a
    ///id="UF_NOT_DELEGATED"></a><a id="uf_not_delegated"></a><dl> <dt><b>UF_NOT_DELEGATED</b></dt> </dl> </td> <td
    ///width="60%"> Marks the account as "sensitive"; other users cannot act as delegates of this user account. </td>
    ///</tr> <tr> <td width="40%"><a id="UF_SMARTCARD_REQUIRED"></a><a id="uf_smartcard_required"></a><dl>
    ///<dt><b>UF_SMARTCARD_REQUIRED</b></dt> </dl> </td> <td width="60%"> Requires the user to log on to the user
    ///account with a smart card. </td> </tr> <tr> <td width="40%"><a id="UF_USE_DES_KEY_ONLY"></a><a
    ///id="uf_use_des_key_only"></a><dl> <dt><b>UF_USE_DES_KEY_ONLY</b></dt> </dl> </td> <td width="60%"> Restrict this
    ///principal to use only Data Encryption Standard (DES) encryption types for keys. </td> </tr> <tr> <td
    ///width="40%"><a id="UF_DONT_REQUIRE_PREAUTH"></a><a id="uf_dont_require_preauth"></a><dl>
    ///<dt><b>UF_DONT_REQUIRE_PREAUTH</b></dt> </dl> </td> <td width="60%"> This account does not require Kerberos
    ///preauthentication for logon. </td> </tr> <tr> <td width="40%"><a id="UF_TRUSTED_FOR_DELEGATION"></a><a
    ///id="uf_trusted_for_delegation"></a><dl> <dt><b>UF_TRUSTED_FOR_DELEGATION</b></dt> </dl> </td> <td width="60%">
    ///The account is enabled for delegation. This is a security-sensitive setting; accounts with this option enabled
    ///should be tightly controlled. This setting allows a service running under the account to assume a client's
    ///identity and authenticate as that user to other remote servers on the network. </td> </tr> <tr> <td
    ///width="40%"><a id="UF_PASSWORD_EXPIRED"></a><a id="uf_password_expired"></a><dl>
    ///<dt><b>UF_PASSWORD_EXPIRED</b></dt> </dl> </td> <td width="60%"> The user's password has expired. <b>Windows
    ///2000: </b>This value is not supported. </td> </tr> <tr> <td width="40%"><a
    ///id="UF_TRUSTED_TO_AUTHENTICATE_FOR_DELEGATION"></a><a id="uf_trusted_to_authenticate_for_delegation"></a><dl>
    ///<dt><b>UF_TRUSTED_TO_AUTHENTICATE_FOR_DELEGATION</b></dt> </dl> </td> <td width="60%"> The account is trusted to
    ///authenticate a user outside of the Kerberos security package and delegate that user through constrained
    ///delegation. This is a security-sensitive setting; accounts with this option enabled should be tightly controlled.
    ///This setting allows a service running under the account to assert a client's identity and authenticate as that
    ///user to specifically configured services on the network. <b>Windows XP/2000: </b>This value is not supported.
    ///</td> </tr> </table> The following values describe the account type. Only one value can be set. You cannot change
    ///the account type using the NetUserSetInfo function. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td
    ///width="40%"><a id="UF_NORMAL_ACCOUNT"></a><a id="uf_normal_account"></a><dl> <dt><b>UF_NORMAL_ACCOUNT</b></dt>
    ///</dl> </td> <td width="60%"> This is a default account type that represents a typical user. </td> </tr> <tr> <td
    ///width="40%"><a id="UF_TEMP_DUPLICATE_ACCOUNT"></a><a id="uf_temp_duplicate_account"></a><dl>
    ///<dt><b>UF_TEMP_DUPLICATE_ACCOUNT</b></dt> </dl> </td> <td width="60%"> This is an account for users whose primary
    ///account is in another domain. This account provides user access to this domain, but not to any domain that trusts
    ///this domain. The User Manager refers to this account type as a local user account. </td> </tr> <tr> <td
    ///width="40%"><a id="UF_WORKSTATION_TRUST_ACCOUNT"></a><a id="uf_workstation_trust_account"></a><dl>
    ///<dt><b>UF_WORKSTATION_TRUST_ACCOUNT</b></dt> </dl> </td> <td width="60%"> This is a computer account for a
    ///computer that is a member of this domain. </td> </tr> <tr> <td width="40%"><a id="UF_SERVER_TRUST_ACCOUNT"></a><a
    ///id="uf_server_trust_account"></a><dl> <dt><b>UF_SERVER_TRUST_ACCOUNT</b></dt> </dl> </td> <td width="60%"> This
    ///is a computer account for a backup domain controller that is a member of this domain. </td> </tr> <tr> <td
    ///width="40%"><a id="UF_INTERDOMAIN_TRUST_ACCOUNT"></a><a id="uf_interdomain_trust_account"></a><dl>
    ///<dt><b>UF_INTERDOMAIN_TRUST_ACCOUNT</b></dt> </dl> </td> <td width="60%"> This is a permit to trust account for a
    ///domain that trusts other domains. </td> </tr> </table>
    uint usri1008_flags;
}

///The <b>USER_INFO_1009</b> structure contains the path for a user's logon script file. This information level is valid
///only when you call the NetUserSetInfo function.
struct USER_INFO_1009
{
    ///Pointer to a Unicode string specifying the path for the user's logon script file. The user is specified in the
    ///<i>username</i> parameter to the <b>NetUserSetInfo</b> function. The script file can be a .CMD file, an .EXE
    ///file, or a .BAT file. The string can also be null.
    PWSTR usri1009_script_path;
}

///The <b>USER_INFO_1010</b> structure contains a set of bit flags defining the operator privileges assigned to a user
///network account. This information level is valid only when you call the NetUserSetInfo function.
struct USER_INFO_1010
{
    ///Specifies a <b>DWORD</b> value that contains a set of bit flags that specify the user's operator privileges. The
    ///user is specified in the <i>username</i> parameter to the <b>NetUserSetInfo</b> function. This member can be one
    ///or more of the following values. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
    ///id="AF_OP_PRINT"></a><a id="af_op_print"></a><dl> <dt><b>AF_OP_PRINT</b></dt> </dl> </td> <td width="60%"> The
    ///print operator privilege is enabled. </td> </tr> <tr> <td width="40%"><a id="AF_OP_COMM"></a><a
    ///id="af_op_comm"></a><dl> <dt><b>AF_OP_COMM</b></dt> </dl> </td> <td width="60%"> The communications operator
    ///privilege is enabled. </td> </tr> <tr> <td width="40%"><a id="AF_OP_SERVER"></a><a id="af_op_server"></a><dl>
    ///<dt><b>AF_OP_SERVER</b></dt> </dl> </td> <td width="60%"> The server operator privilege is enabled. </td> </tr>
    ///<tr> <td width="40%"><a id="AF_OP_ACCOUNTS"></a><a id="af_op_accounts"></a><dl> <dt><b>AF_OP_ACCOUNTS</b></dt>
    ///</dl> </td> <td width="60%"> The accounts operator privilege is enabled. </td> </tr> </table>
    uint usri1010_auth_flags;
}

///The <b>USER_INFO_1011</b> structure contains the full name of a network user. This information level is valid only
///when you call the NetUserSetInfo function.
struct USER_INFO_1011
{
    ///Pointer to a Unicode string that contains the full name of the user. The user is specified in the <i>username</i>
    ///parameter to the <b>NetUserSetInfo</b> function. This string can be a null string, or it can have any number of
    ///characters before the terminating null character.
    PWSTR usri1011_full_name;
}

///The <b>USER_INFO_1012</b> structure contains a user comment. This information level is valid only when you call the
///NetUserSetInfo function.
struct USER_INFO_1012
{
    ///Pointer to a Unicode string that contains a user comment. The user is specified in the <i>username</i> parameter
    ///to the <b>NetUserSetInfo</b> function. This string can be a null string, or it can have any number of characters
    ///before the terminating null character.
    PWSTR usri1012_usr_comment;
}

///The <b>USER_INFO_1013</b> structure contains reserved information for network accounts. This information level is
///valid only when you call the NetUserSetInfo function.
struct USER_INFO_1013
{
    ///Pointer to a Unicode string that is reserved for use by applications. The string can be a null string, or it can
    ///have any number of characters before the terminating null character. Microsoft products use this member to store
    ///user configuration information. Do not modify this information. The system components that use this member are
    ///services for Macintosh, file and print services for NetWare, and the Remote Access Server (RAS).
    PWSTR usri1013_parms;
}

///The <b>USER_INFO_1014</b> structure contains the names of workstations from which the user can log on. This
///information level is valid only when you call the NetUserSetInfo function.
struct USER_INFO_1014
{
    ///> [!IMPORTANT] > You should no longer use **usri1014_workstations**. Instead, you can control sign-in access to
    ///workstations by configuring the User Rights Assignment settings (**Allow log on locally** and **Deny log on
    ///locally**, or **Allow log on through Remote Desktop Services** and **Deny log on through Remote Desktop
    ///Services**). Pointer to a Unicode string that contains the names of workstations from which the user can log on.
    ///The user is specified in the <i>username</i> parameter to the <b>NetUserSetInfo</b> function. As many as eight
    ///workstations can be specified; the names must be separated by commas. A null string indicates that there is no
    ///restriction.
    PWSTR usri1014_workstations;
}

///The <b>USER_INFO_1017</b> structure contains expiration information for network user accounts. This information level
///is valid only when you call the NetUserSetInfo function.
struct USER_INFO_1017
{
    ///Specifies a <b>DWORD</b> value that indicates when the user account expires. The user account is specified in the
    ///<i>username</i> parameter to the <b>NetUserSetInfo</b> function. The value is stored as the number of seconds
    ///that have elapsed since 00:00:00, January 1, 1970, GMT. Specify TIMEQ_FOREVER to indicate that the account never
    ///expires.
    uint usri1017_acct_expires;
}

///The <b>USER_INFO_1018</b> structure contains the maximum amount of disk space available to a network user account.
///This information level is valid only when you call the NetUserSetInfo function.
struct USER_INFO_1018
{
    ///Specifies a <b>DWORD</b> value that indicates the maximum amount of disk space the user can use. The user is
    ///specified in the <i>username</i> parameter to the <b>NetUserSetInfo</b> function. You must specify
    ///USER_MAXSTORAGE_UNLIMITED to indicate that there is no restriction on disk space.
    uint usri1018_max_storage;
}

///The <b>USER_INFO_1020</b> structure contains the times during which a user can log on to the network. This
///information level is valid only when you call the NetUserSetInfo function.
struct USER_INFO_1020
{
    ///Specifies a <b>DWORD</b> value that indicates the number of equal-length time units into which the week is
    ///divided. This value is required to compute the length of the bit string in the <b>usri1020_logon_hours</b>
    ///member. This value must be UNITS_PER_WEEK for LAN Manager 2.0. Calls to the NetUserAdd and NetUserSetInfo
    ///functions ignore this member. For service applications, the units must be one of the following values:
    ///SAM_DAYS_PER_WEEK, SAM_HOURS_PER_WEEK, or SAM_MINUTES_PER_WEEK.
    uint   usri1020_units_per_week;
    ///Pointer to a 21-byte (168 bits) bit string that specifies the times during which the user can log on. The user is
    ///specified in the <i>username</i> parameter to the <b>NetUserSetInfo</b> function. Each bit in the string
    ///represents a unique hour in the week, in Greenwich Mean Time (GMT). The first bit (bit 0, word 0) is Sunday, 0:00
    ///to 0:59; the second bit (bit 1, word 0) is Sunday, 1:00 to 1:59; and so on. Note that bit 0 in word 0 represents
    ///Sunday from 0:00 to 0:59 only if you are in the GMT time zone. In all other cases you must adjust the bits
    ///according to your time zone offset (for example, GMT minus 8 hours for Pacific Standard Time).
    ubyte* usri1020_logon_hours;
}

///The <b>USER_INFO_1023</b> structure contains the name of the server to which network logon requests should be sent.
///This information level is valid only when you call the NetUserSetInfo function.
struct USER_INFO_1023
{
    ///Pointer to a Unicode string that contains the name of the server to which logon requests for the user account
    ///should be sent. The user account is specified in the <i>username</i> parameter to the <b>NetUserSetInfo</b>
    ///function. Server names should be preceded by two backslashes (\\). To indicate that the logon request can be
    ///handled by any logon server, specify an asterisk (\\*) for the server name. A null string indicates that requests
    ///should be sent to the domain controller.
    PWSTR usri1023_logon_server;
}

///The <b>USER_INFO_1024</b> structure contains the country/region code for a network user's language of choice. This
///information level is valid only when you call the NetUserSetInfo function.
struct USER_INFO_1024
{
    ///Specifies a <b>DWORD</b> value that indicates the country/region code for the user's language of choice. The user
    ///is specified in the <i>username</i> parameter to the <b>NetUserSetInfo</b> function. This value is ignored.
    uint usri1024_country_code;
}

///The <b>USER_INFO_1025</b> structure contains the code page for a network user's language of choice. This information
///level is valid only when you call the NetUserSetInfo function.
struct USER_INFO_1025
{
    ///Specifies a <b>DWORD</b> value that indicates the code page for the user's language of choice. The user is
    ///specified in the <i>username</i> parameter to the <b>NetUserSetInfo</b> function. This value is ignored.
    uint usri1025_code_page;
}

///The <b>USER_INFO_1051</b> structure contains the relative ID (RID) associated with the user account. This information
///level is valid only when you call the NetUserSetInfo function.
struct USER_INFO_1051
{
    ///Specifies a <b>DWORD</b> value that contains the RID of the Primary Global Group for the user specified in the
    ///<i>username</i> parameter to the <b>NetUserSetInfo</b> function. This member must be the RID of a global group
    ///that represents the enrolled user. For more information about RIDs, see SID Components.
    uint usri1051_primary_group_id;
}

///The <b>USER_INFO_1052</b> structure contains the path to a network user's profile. This information level is valid
///only when you call the NetUserSetInfo function.
struct USER_INFO_1052
{
    ///Specifies a Unicode string that contains the path to the user's profile. The user is specified in the
    ///<i>username</i> parameter to the <b>NetUserSetInfo</b> function. This value can be a null string, a local
    ///absolute path, or a UNC path.
    PWSTR usri1052_profile;
}

///The <b>USER_INFO_1053</b> structure contains user information for network accounts. This information level is valid
///only when you call the NetUserSetInfo function.
struct USER_INFO_1053
{
    ///Specifies the drive letter to assign to the user's home directory for logon purposes. The user is specified in
    ///the <i>username</i> parameter to the <b>NetUserSetInfo</b> function.
    PWSTR usri1053_home_dir_drive;
}

///The <b>USER_MODALS_INFO_0</b> structure contains global password information for users and global groups in the
///security database, which is the security accounts manager (SAM) database or, in the case of domain controllers, the
///Active Directory.
struct USER_MODALS_INFO_0
{
    ///Specifies the minimum allowable password length. Valid values for this element are zero through LM20_PWLEN.
    uint usrmod0_min_passwd_len;
    ///Specifies, in seconds, the maximum allowable password age. A value of TIMEQ_FOREVER indicates that the password
    ///never expires. The minimum valid value for this element is ONE_DAY. The value specified must be greater than or
    ///equal to the value for the <b>usrmod0_min_passwd_age</b> member.
    uint usrmod0_max_passwd_age;
    ///Specifies the minimum number of seconds that can elapse between the time a password changes and when it can be
    ///changed again. A value of zero indicates that no delay is required between password updates. The value specified
    ///must be less than or equal to the value for the <b>usrmod0_max_passwd_age</b> member.
    uint usrmod0_min_passwd_age;
    ///Specifies, in seconds, the amount of time between the end of the valid logon time and the time when the user is
    ///forced to log off the network. A value of TIMEQ_FOREVER indicates that the user is never forced to log off. A
    ///value of zero indicates that the user will be forced to log off immediately when the valid logon time expires.
    uint usrmod0_force_logoff;
    ///Specifies the length of password history maintained. A new password cannot match any of the previous
    ///<b>usrmod0_password_hist_len</b> passwords. Valid values for this element are zero through DEF_MAX_PWHIST.
    uint usrmod0_password_hist_len;
}

///The <b>USER_MODALS_INFO_1</b> structure contains logon server and domain controller information.
struct USER_MODALS_INFO_1
{
    ///Specifies the role of the logon server. The following values are defined. <table> <tr> <th>Value</th>
    ///<th>Meaning</th> </tr> <tr> <td width="40%"><a id="UAS_ROLE_STANDALONE"></a><a id="uas_role_standalone"></a><dl>
    ///<dt><b>UAS_ROLE_STANDALONE</b></dt> </dl> </td> <td width="60%"> The logon server is a stand-alone server. </td>
    ///</tr> <tr> <td width="40%"><a id="UAS_ROLE_MEMBER"></a><a id="uas_role_member"></a><dl>
    ///<dt><b>UAS_ROLE_MEMBER</b></dt> </dl> </td> <td width="60%"> The logon server is a member. </td> </tr> <tr> <td
    ///width="40%"><a id="UAS_ROLE_BACKUP"></a><a id="uas_role_backup"></a><dl> <dt><b>UAS_ROLE_BACKUP</b></dt> </dl>
    ///</td> <td width="60%"> The logon server is a backup. </td> </tr> <tr> <td width="40%"><a
    ///id="UAS_ROLE_PRIMARY"></a><a id="uas_role_primary"></a><dl> <dt><b>UAS_ROLE_PRIMARY</b></dt> </dl> </td> <td
    ///width="60%"> The logon server is a domain controller. </td> </tr> </table> <div> </div> If the Netlogon service
    ///is not being used, the element should be set to UAS_ROLE_STANDALONE.
    uint  usrmod1_role;
    ///Pointer to a Unicode string that specifies the name of the domain controller that stores the primary copy of the
    ///database for the user account manager.
    PWSTR usrmod1_primary;
}

///The <b>USER_MODALS_INFO_2</b> structure contains the Security Account Manager (SAM) domain name and identifier.
struct USER_MODALS_INFO_2
{
    ///Specifies the name of the Security Account Manager (SAM) domain. For a domain controller, this is the name of the
    ///domain that the controller is a member of. For workstations, this is the name of the computer.
    PWSTR usrmod2_domain_name;
    ///Pointer to a SID structure that contains the security identifier (SID) of the domain named by the
    ///<b>usrmod2_domain_name</b> member.
    void* usrmod2_domain_id;
}

///The <b>USER_MODALS_INFO_3</b> structure contains lockout information for users and global groups in the security
///database, which is the security accounts manager (SAM) database or, in the case of domain controllers, the Active
///Directory.
struct USER_MODALS_INFO_3
{
    ///Specifies, in seconds, how long a locked account remains locked before it is automatically unlocked.
    uint usrmod3_lockout_duration;
    ///Specifies the maximum time, in seconds, that can elapse between any two failed logon attempts before lockout
    ///occurs.
    uint usrmod3_lockout_observation_window;
    ///Specifies the number of invalid password authentications that can occur before an account is marked "locked out."
    uint usrmod3_lockout_threshold;
}

///The <b>USER_MODALS_INFO_1001</b> structure contains the minimum length for passwords in the security database, which
///is the security accounts manager (SAM) database or, in the case of domain controllers, the Active Directory.
struct USER_MODALS_INFO_1001
{
    ///Specifies the minimum allowable password length. Valid values for this element are zero through PWLEN.
    uint usrmod1001_min_passwd_len;
}

///The <b>USER_MODALS_INFO_1002</b> structure contains the maximum duration for passwords in the security database,
///which is the security accounts manager (SAM) database or, in the case of domain controllers, the Active Directory.
struct USER_MODALS_INFO_1002
{
    ///Specifies, in seconds, the maximum allowable password age. A value of TIMEQ_FOREVER indicates that the password
    ///never expires. The minimum valid value for this element is ONE_DAY. The value specified must be greater than or
    ///equal to the value for the usrmod<i>X</i>_min_passwd_age member.
    uint usrmod1002_max_passwd_age;
}

///The <b>USER_MODALS_INFO_1003</b> structure contains the minimum duration for passwords in the security database,
///which is the security accounts manager (SAM) database or, in the case of domain controllers, the Active Directory.
struct USER_MODALS_INFO_1003
{
    ///Specifies the minimum number of seconds that can elapse between the time a password changes and when it can be
    ///changed again. A value of zero indicates that no delay is required between password updates. The value specified
    ///must be less than or equal to the value for the usrmod<i>X</i>_max_passwd_age member.
    uint usrmod1003_min_passwd_age;
}

///The <b>USER_MODALS_INFO_1004</b> structure contains forced logoff information for users and global groups in the
///security database, which is the security accounts manager (SAM) database or, in the case of domain controllers, the
///Active Directory.
struct USER_MODALS_INFO_1004
{
    ///Specifies, in seconds, the amount of time between the end of the valid logon time and the time when the user is
    ///forced to log off the network. A value of TIMEQ_FOREVER indicates that the user is never forced to log off. A
    ///value of zero indicates that the user will be forced to log off immediately when the valid logon time expires.
    uint usrmod1004_force_logoff;
}

///The <b>USER_MODALS_INFO_1005</b> structure contains password history information for users and global groups in the
///security database, which is the security accounts manager (SAM) database or, in the case of domain controllers, the
///Active Directory.
struct USER_MODALS_INFO_1005
{
    ///Specifies the length of password history that the system maintains. A new password cannot match any of the
    ///previous usrmod<i>X</i>_password_hist_len passwords. Valid values for this element are zero through
    ///DEF_MAX_PWHIST.
    uint usrmod1005_password_hist_len;
}

///The <b>USER_MODALS_INFO_1006</b> structure contains logon server information.
struct USER_MODALS_INFO_1006
{
    ///Specifies the role of the logon server. This member can be one of the following values. <table> <tr>
    ///<th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="UAS_ROLE_STANDALONE"></a><a
    ///id="uas_role_standalone"></a><dl> <dt><b>UAS_ROLE_STANDALONE</b></dt> </dl> </td> <td width="60%"> Logon server
    ///is a stand-alone. Use this value if no logon services are available. </td> </tr> <tr> <td width="40%"><a
    ///id="UAS_ROLE_MEMBER"></a><a id="uas_role_member"></a><dl> <dt><b>UAS_ROLE_MEMBER</b></dt> </dl> </td> <td
    ///width="60%"> Logon server is a member. </td> </tr> <tr> <td width="40%"><a id="UAS_ROLE_BACKUP"></a><a
    ///id="uas_role_backup"></a><dl> <dt><b>UAS_ROLE_BACKUP</b></dt> </dl> </td> <td width="60%"> Logon server is a
    ///backup. </td> </tr> <tr> <td width="40%"><a id="UAS_ROLE_PRIMARY"></a><a id="uas_role_primary"></a><dl>
    ///<dt><b>UAS_ROLE_PRIMARY</b></dt> </dl> </td> <td width="60%"> Logon server is a domain controller. </td> </tr>
    ///</table>
    uint usrmod1006_role;
}

///The <b>USER_MODALS_INFO_1007</b> structure contains domain controller information.
struct USER_MODALS_INFO_1007
{
    ///Pointer to a Unicode string that specifies the name of the domain controller that stores the primary copy of the
    ///database for the user account manager.
    PWSTR usrmod1007_primary;
}

///The <b>GROUP_INFO_0</b> structure contains the name of a global group in the security database, which is the security
///accounts manager (SAM) database or, in the case of domain controllers, the Active Directory.
struct GROUP_INFO_0
{
    ///Pointer to a null-terminated Unicode character string that specifies the name of the global group. For more
    ///information, see the following Remarks section. When you call the NetGroupSetInfo function this member specifies
    ///the new name of the global group.
    PWSTR grpi0_name;
}

///The <b>GROUP_INFO_1</b> structure contains a global group name and a comment to associate with the group.
struct GROUP_INFO_1
{
    ///Pointer to a null-terminated Unicode character string that specifies the name of the global group. For more
    ///information, see the following Remarks section. When you call the NetGroupSetInfo function this member is
    ///ignored.
    PWSTR grpi1_name;
    ///Pointer to a null-terminated Unicode character string that specifies a remark associated with the global group.
    ///This member can be a null string. The comment can contain MAXCOMMENTSZ characters.
    PWSTR grpi1_comment;
}

///The <b>GROUP_INFO_2</b> structure contains information about a global group, including name, identifier, and resource
///attributes. It is recommended that you use the GROUP_INFO_3 structure instead.
struct GROUP_INFO_2
{
    ///Pointer to a null-terminated Unicode character string that specifies the name of the global group. For more
    ///information, see the following Remarks section. When you call the NetGroupSetInfo function this member is
    ///ignored.
    PWSTR grpi2_name;
    ///Pointer to a null-terminated Unicode character string that contains a remark associated with the global group.
    ///This member can be a null string. The comment can contain MAXCOMMENTSZ characters.
    PWSTR grpi2_comment;
    ///The relative identifier (RID) of the global group. The NetUserAdd and NetUserSetInfo functions ignore this
    ///member. For more information about RIDs, see SID Components.
    uint  grpi2_group_id;
    ///These attributes are hard-coded to SE_GROUP_MANDATORY, SE_GROUP_ENABLED, and SE_GROUP_ENABLED_BY_DEFAULT. For
    ///more information, see TOKEN_GROUPS.
    uint  grpi2_attributes;
}

///The <b>GROUP_INFO_3</b> structure contains information about a global group, including name, security identifier
///(SID), and resource attributes.
struct GROUP_INFO_3
{
    ///Pointer to a null-terminated Unicode character string that specifies the name of the global group. When you call
    ///the NetGroupSetInfo function this member is ignored.
    PWSTR grpi3_name;
    ///Pointer to a null-terminated Unicode character string that contains a remark associated with the global group.
    ///This member can be a null string. The comment can contain MAXCOMMENTSZ characters.
    PWSTR grpi3_comment;
    ///Pointer to a SID structure that contains the security identifier (SID) that uniquely identifies the global group.
    ///The NetUserAdd and NetUserSetInfo functions ignore this member.
    void* grpi3_group_sid;
    ///These attributes are hard-coded to SE_GROUP_MANDATORY, SE_GROUP_ENABLED, and SE_GROUP_ENABLED_BY_DEFAULT. For
    ///more information, see TOKEN_GROUPS.
    uint  grpi3_attributes;
}

///The <b>GROUP_INFO_1002</b> structure contains a comment to associate with a global group.
struct GROUP_INFO_1002
{
    ///Pointer to a null-terminated Unicode character string that contains a remark to associate with the global group.
    ///This member can be a null string. The comment can contain MAXCOMMENTSZ characters.
    PWSTR grpi1002_comment;
}

///The <b>GROUP_INFO_1005</b> structure contains the resource attributes associated with a global group.
struct GROUP_INFO_1005
{
    ///These attributes are hard-coded to SE_GROUP_MANDATORY, SE_GROUP_ENABLED, and SE_GROUP_ENABLED_BY_DEFAULT. For
    ///more information, see TOKEN_GROUPS.
    uint grpi1005_attributes;
}

///The <b>GROUP_USERS_INFO_0</b> structure contains global group member information.
struct GROUP_USERS_INFO_0
{
    ///A pointer to a null-terminated Unicode character string that specifies a name. For more information, see the
    ///Remarks section.
    PWSTR grui0_name;
}

///The <b>GROUP_USERS_INFO_1</b> structure contains global group member information.
struct GROUP_USERS_INFO_1
{
    ///Type: <b>LPWSTR</b> A pointer to a null-terminated Unicode character string that specifies a name. For more
    ///information, see the Remarks section.
    PWSTR grui1_name;
    ///Type: <b>DWORD</b> A set of attributes for this entry. This member can be a combination of the security group
    ///attributes defined in the <i>Winnt.h</i> header file. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td
    ///width="40%"><a id="SE_GROUP_MANDATORY"></a><a id="se_group_mandatory"></a><dl> <dt><b>SE_GROUP_MANDATORY</b></dt>
    ///<dt>0x00000001</dt> </dl> </td> <td width="60%"> The group is mandatory. </td> </tr> <tr> <td width="40%"><a
    ///id="SE_GROUP_ENABLED_BY_DEFAULT"></a><a id="se_group_enabled_by_default"></a><dl>
    ///<dt><b>SE_GROUP_ENABLED_BY_DEFAULT</b></dt> <dt>0x00000002</dt> </dl> </td> <td width="60%"> The group is enabled
    ///for access checks by default. </td> </tr> <tr> <td width="40%"><a id="SE_GROUP_ENABLED"></a><a
    ///id="se_group_enabled"></a><dl> <dt><b>SE_GROUP_ENABLED</b></dt> <dt>0x00000004</dt> </dl> </td> <td width="60%">
    ///The group is enabled for access checks. </td> </tr> <tr> <td width="40%"><a id="SE_GROUP_OWNER"></a><a
    ///id="se_group_owner"></a><dl> <dt><b>SE_GROUP_OWNER</b></dt> <dt>0x00000008</dt> </dl> </td> <td width="60%"> The
    ///group identifies a group account for which the user of the token is the owner of the group. </td> </tr> <tr> <td
    ///width="40%"><a id="SE_GROUP_USE_FOR_DENY_ONLY"></a><a id="se_group_use_for_deny_only"></a><dl>
    ///<dt><b>SE_GROUP_USE_FOR_DENY_ONLY</b></dt> <dt>0x00000010</dt> </dl> </td> <td width="60%"> The group is used for
    ///deny only purposes. When this attribute is set, the SE_GROUP_ENABLED attribute must not be set. </td> </tr> <tr>
    ///<td width="40%"><a id="SE_GROUP_INTEGRITY"></a><a id="se_group_integrity"></a><dl>
    ///<dt><b>SE_GROUP_INTEGRITY</b></dt> <dt>0x00000020</dt> </dl> </td> <td width="60%"> The group is used for
    ///integrity. This attribute is available on Windows Vista and later. </td> </tr> <tr> <td width="40%"><a
    ///id="SE_GROUP_INTEGRITY_ENABLED"></a><a id="se_group_integrity_enabled"></a><dl>
    ///<dt><b>SE_GROUP_INTEGRITY_ENABLED</b></dt> <dt>0x00000040</dt> </dl> </td> <td width="60%"> The group is enabled
    ///for integrity level. This attribute is available on Windows Vista and later. </td> </tr> <tr> <td width="40%"><a
    ///id="SE_GROUP_LOGON_ID"></a><a id="se_group_logon_id"></a><dl> <dt><b>SE_GROUP_LOGON_ID</b></dt>
    ///<dt>0xC0000000</dt> </dl> </td> <td width="60%"> The group is used to identify a logon session associated with an
    ///access token. </td> </tr> <tr> <td width="40%"><a id="SE_GROUP_RESOURCE"></a><a id="se_group_resource"></a><dl>
    ///<dt><b>SE_GROUP_RESOURCE</b></dt> <dt>0x20000000</dt> </dl> </td> <td width="60%"> The group identifies a
    ///domain-local group. </td> </tr> </table>
    uint  grui1_attributes;
}

///The <b>LOCALGROUP_INFO_0</b> structure contains a local group name.
struct LOCALGROUP_INFO_0
{
    ///Pointer to a Unicode string that specifies a local group name. For more information, see the following Remarks
    ///section.
    PWSTR lgrpi0_name;
}

///The <b>LOCALGROUP_INFO_1</b> structure contains a local group name and a comment describing the local group.
struct LOCALGROUP_INFO_1
{
    ///Pointer to a Unicode string that specifies a local group name. For more information, see the following Remarks
    ///section. This member is ignored when you call the NetLocalGroupSetInfo function.
    PWSTR lgrpi1_name;
    ///Pointer to a Unicode string that contains a remark associated with the local group. This member can be a null
    ///string. The comment can have as many as MAXCOMMENTSZ characters.
    PWSTR lgrpi1_comment;
}

///The <b>LOCALGROUP_INFO_1002</b> structure contains a comment describing a local group.
struct LOCALGROUP_INFO_1002
{
    ///Pointer to a Unicode string that specifies a remark associated with the local group. This member can be a null
    ///string. The comment can have as many as MAXCOMMENTSZ characters.
    PWSTR lgrpi1002_comment;
}

///The <b>LOCALGROUP_MEMBERS_INFO_0</b> structure contains the security identifier (SID) associated with a local group
///member. The member can be a user account or a global group account.
struct LOCALGROUP_MEMBERS_INFO_0
{
    ///Pointer to a SID structure that contains the security identifier (SID) of the local group member.
    void* lgrmi0_sid;
}

///The <b>LOCALGROUP_MEMBERS_INFO_1</b> structure contains the security identifier (SID) and account information
///associated with the member of a local group.
struct LOCALGROUP_MEMBERS_INFO_1
{
    ///Type: <b>PSID</b> A pointer to a SID structure that contains the security identifier (SID) of an account that is
    ///a member of this local group member. The account can be a user account or a global group account.
    void*        lgrmi1_sid;
    ///Type: <b>SID_NAME_USE</b> The account type associated with the security identifier specified in the
    ///<b>lgrmi1_sid</b> member. The following values are valid. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr>
    ///<td width="40%"><a id="SidTypeUser"></a><a id="sidtypeuser"></a><a id="SIDTYPEUSER"></a><dl>
    ///<dt><b>SidTypeUser</b></dt> </dl> </td> <td width="60%"> The account is a user account. </td> </tr> <tr> <td
    ///width="40%"><a id="SidTypeGroup"></a><a id="sidtypegroup"></a><a id="SIDTYPEGROUP"></a><dl>
    ///<dt><b>SidTypeGroup</b></dt> </dl> </td> <td width="60%"> The account is a global group account. </td> </tr> <tr>
    ///<td width="40%"><a id="SidTypeWellKnownGroup"></a><a id="sidtypewellknowngroup"></a><a
    ///id="SIDTYPEWELLKNOWNGROUP"></a><dl> <dt><b>SidTypeWellKnownGroup</b></dt> </dl> </td> <td width="60%"> The
    ///account is a well-known group account (such as Everyone). For more information, see Well-Known SIDs. </td> </tr>
    ///<tr> <td width="40%"><a id="SidTypeDeletedAccount"></a><a id="sidtypedeletedaccount"></a><a
    ///id="SIDTYPEDELETEDACCOUNT"></a><dl> <dt><b>SidTypeDeletedAccount</b></dt> </dl> </td> <td width="60%"> The
    ///account has been deleted. </td> </tr> <tr> <td width="40%"><a id="SidTypeUnknown"></a><a
    ///id="sidtypeunknown"></a><a id="SIDTYPEUNKNOWN"></a><dl> <dt><b>SidTypeUnknown</b></dt> </dl> </td> <td
    ///width="60%"> The account type cannot be determined. </td> </tr> </table>
    SID_NAME_USE lgrmi1_sidusage;
    ///Type: <b>LPWSTR</b> A pointer to the account name of the local group member identified by the <b>lgrmi1_sid</b>
    ///member. The <b>lgrmi1_name</b> member does not include the domain name. For more information, see the following
    ///Remarks section.
    PWSTR        lgrmi1_name;
}

///The <b>LOCALGROUP_MEMBERS_INFO_2</b> structure contains the security identifier (SID) and account information
///associated with a local group member.
struct LOCALGROUP_MEMBERS_INFO_2
{
    ///Type: <b>PSID</b> A pointer to a SID structure that contains the security identifier (SID) of a local group
    ///member. The local group member can be a user account or a global group account.
    void*        lgrmi2_sid;
    ///Type: <b>SID_NAME_USE</b> The account type associated with the security identifier specified in the
    ///<b>lgrmi2_sid</b> member. The following values are valid. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr>
    ///<td width="40%"><a id="SidTypeUser"></a><a id="sidtypeuser"></a><a id="SIDTYPEUSER"></a><dl>
    ///<dt><b>SidTypeUser</b></dt> </dl> </td> <td width="60%"> The account is a user account. </td> </tr> <tr> <td
    ///width="40%"><a id="SidTypeGroup"></a><a id="sidtypegroup"></a><a id="SIDTYPEGROUP"></a><dl>
    ///<dt><b>SidTypeGroup</b></dt> </dl> </td> <td width="60%"> The account is a global group account. </td> </tr> <tr>
    ///<td width="40%"><a id="SidTypeWellKnownGroup"></a><a id="sidtypewellknowngroup"></a><a
    ///id="SIDTYPEWELLKNOWNGROUP"></a><dl> <dt><b>SidTypeWellKnownGroup</b></dt> </dl> </td> <td width="60%"> The
    ///account is a well-known group account (such as Everyone). For more information, see Well-Known SIDs. </td> </tr>
    ///<tr> <td width="40%"><a id="SidTypeDeletedAccount"></a><a id="sidtypedeletedaccount"></a><a
    ///id="SIDTYPEDELETEDACCOUNT"></a><dl> <dt><b>SidTypeDeletedAccount</b></dt> </dl> </td> <td width="60%"> The
    ///account has been deleted. </td> </tr> <tr> <td width="40%"><a id="SidTypeUnknown"></a><a
    ///id="sidtypeunknown"></a><a id="SIDTYPEUNKNOWN"></a><dl> <dt><b>SidTypeUnknown</b></dt> </dl> </td> <td
    ///width="60%"> The account type cannot be determined. </td> </tr> </table>
    SID_NAME_USE lgrmi2_sidusage;
    ///Type: <b>LPWSTR</b> A pointer to the account name of the local group member identified by <b>lgrmi2_sid</b>. The
    ///<b>lgrmi2_domainandname</b> member includes the domain name and has the form: <pre class="syntax"
    ///xml:space="preserve"><code>&lt;DomainName&gt;\&lt;AccountName&gt; </code></pre>
    PWSTR        lgrmi2_domainandname;
}

///The <b>LOCALGROUP_MEMBERS_INFO_3</b> structure contains the account name and domain name associated with a local
///group member.
struct LOCALGROUP_MEMBERS_INFO_3
{
    ///Pointer to a null-terminated Unicode string specifying the account name of the local group member prefixed by the
    ///domain name and the "\" separator character. For example: <pre class="syntax"
    ///xml:space="preserve"><code>&lt;DomainName&gt;\&lt;AccountName&gt; </code></pre>
    PWSTR lgrmi3_domainandname;
}

///The <b>LOCALGROUP_USERS_INFO_0</b> structure contains local group member information.
struct LOCALGROUP_USERS_INFO_0
{
    ///Pointer to a Unicode string specifying the name of a local group to which the user belongs.
    PWSTR lgrui0_name;
}

///The <b>NET_DISPLAY_USER</b> structure contains information that an account manager can access to determine
///information about user accounts.
struct NET_DISPLAY_USER
{
    ///Type: <b>LPWSTR</b> A pointer to a Unicode string that specifies the name of the user account.
    PWSTR usri1_name;
    ///Type: <b>LPWSTR</b> A pointer to a Unicode string that contains a comment associated with the user. This string
    ///can be a null string, or it can have any number of characters before the terminating null character
    ///(MAXCOMMENTSZ).
    PWSTR usri1_comment;
    ///Type: <b>DWORD</b> A set of user account flags. This member can be one or more of the following values. Note that
    ///setting user account control flags may require certain privileges and control access rights. For more
    ///information, see the Remarks section of the NetUserSetInfo function. <table> <tr> <th>Value</th> <th>Meaning</th>
    ///</tr> <tr> <td width="40%"><a id="UF_SCRIPT"></a><a id="uf_script"></a><dl> <dt><b>UF_SCRIPT</b></dt> </dl> </td>
    ///<td width="60%"> The logon script executed. This value must be set. </td> </tr> <tr> <td width="40%"><a
    ///id="UF_ACCOUNTDISABLE"></a><a id="uf_accountdisable"></a><dl> <dt><b>UF_ACCOUNTDISABLE</b></dt> </dl> </td> <td
    ///width="60%"> The user's account is disabled. </td> </tr> <tr> <td width="40%"><a id="UF_PASSWD_NOTREQD"></a><a
    ///id="uf_passwd_notreqd"></a><dl> <dt><b>UF_PASSWD_NOTREQD</b></dt> </dl> </td> <td width="60%"> No password is
    ///required. </td> </tr> <tr> <td width="40%"><a id="UF_PASSWD_CANT_CHANGE"></a><a
    ///id="uf_passwd_cant_change"></a><dl> <dt><b>UF_PASSWD_CANT_CHANGE</b></dt> </dl> </td> <td width="60%"> The user
    ///cannot change the password. </td> </tr> <tr> <td width="40%"><a id="UF_LOCKOUT"></a><a id="uf_lockout"></a><dl>
    ///<dt><b>UF_LOCKOUT</b></dt> </dl> </td> <td width="60%"> The account is currently locked out (blocked). For the
    ///NetUserSetInfo function, this value can be cleared to unlock a previously locked account. This value cannot be
    ///used to lock a previously unlocked account. </td> </tr> <tr> <td width="40%"><a id="UF_DONT_EXPIRE_PASSWD"></a><a
    ///id="uf_dont_expire_passwd"></a><dl> <dt><b>UF_DONT_EXPIRE_PASSWD</b></dt> </dl> </td> <td width="60%"> The
    ///password will never expire on the account. </td> </tr> <tr> <td width="40%"><a
    ///id="UF_TRUSTED_FOR_DELEGATION"></a><a id="uf_trusted_for_delegation"></a><dl>
    ///<dt><b>UF_TRUSTED_FOR_DELEGATION</b></dt> </dl> </td> <td width="60%"> The account is enabled for delegation.
    ///This is a security-sensitive setting; accounts with this option enabled should be tightly controlled. This
    ///setting allows a service running under the account to assume a client's identity and authenticate as that user to
    ///other remote servers on the network. </td> </tr> <tr> <td width="40%"><a
    ///id="UF_ENCRYPTED_TEXT_PASSWORD_ALLOWED"></a><a id="uf_encrypted_text_password_allowed"></a><dl>
    ///<dt><b>UF_ENCRYPTED_TEXT_PASSWORD_ALLOWED</b></dt> </dl> </td> <td width="60%"> The user's password is stored
    ///under reversible encryption in the Active Directory. </td> </tr> <tr> <td width="40%"><a
    ///id="UF_NOT_DELEGATED"></a><a id="uf_not_delegated"></a><dl> <dt><b>UF_NOT_DELEGATED</b></dt> </dl> </td> <td
    ///width="60%"> The account is marked as "sensitive"; other users cannot act as delegates of this user account.
    ///</td> </tr> <tr> <td width="40%"><a id="UF_SMARTCARD_REQUIRED"></a><a id="uf_smartcard_required"></a><dl>
    ///<dt><b>UF_SMARTCARD_REQUIRED</b></dt> </dl> </td> <td width="60%"> The user is required to log on to the user
    ///account with a smart card. </td> </tr> <tr> <td width="40%"><a id="UF_USE_DES_KEY_ONLY"></a><a
    ///id="uf_use_des_key_only"></a><dl> <dt><b>UF_USE_DES_KEY_ONLY</b></dt> </dl> </td> <td width="60%"> This principal
    ///is restricted to use only Data Encryption Standard (DES) encryption types for keys. </td> </tr> <tr> <td
    ///width="40%"><a id="UF_DONT_REQUIRE_PREAUTH"></a><a id="uf_dont_require_preauth"></a><dl>
    ///<dt><b>UF_DONT_REQUIRE_PREAUTH</b></dt> </dl> </td> <td width="60%"> This account does not require Kerberos
    ///preauthentication for logon. </td> </tr> <tr> <td width="40%"><a id="UF_PASSWORD_EXPIRED"></a><a
    ///id="uf_password_expired"></a><dl> <dt><b>UF_PASSWORD_EXPIRED</b></dt> </dl> </td> <td width="60%"> The user's
    ///password has expired. <b>Windows 2000: </b>This value is not supported. </td> </tr> <tr> <td width="40%"><a
    ///id="UF_TRUSTED_TO_AUTHENTICATE_FOR_DELEGATION"></a><a id="uf_trusted_to_authenticate_for_delegation"></a><dl>
    ///<dt><b>UF_TRUSTED_TO_AUTHENTICATE_FOR_DELEGATION</b></dt> </dl> </td> <td width="60%"> The account is trusted to
    ///authenticate a user outside of the Kerberos security package and delegate that user through constrained
    ///delegation. This is a security-sensitive setting; accounts with this option enabled should be tightly controlled.
    ///This setting allows a service running under the account to assert a client's identity and authenticate as that
    ///user to specifically configured services on the network. <b>Windows XP/2000: </b>This value is not supported.
    ///</td> </tr> </table> The following values describe the account type. Only one value can be set. You cannot change
    ///the account type using the NetUserSetInfo function. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td
    ///width="40%"><a id="UF_NORMAL_ACCOUNT"></a><a id="uf_normal_account"></a><dl> <dt><b>UF_NORMAL_ACCOUNT</b></dt>
    ///</dl> </td> <td width="60%"> This is a default account type that represents a typical user. </td> </tr> <tr> <td
    ///width="40%"><a id="UF_TEMP_DUPLICATE_ACCOUNT"></a><a id="uf_temp_duplicate_account"></a><dl>
    ///<dt><b>UF_TEMP_DUPLICATE_ACCOUNT</b></dt> </dl> </td> <td width="60%"> This is an account for users whose primary
    ///account is in another domain. This account provides user access to this domain, but not to any domain that trusts
    ///this domain. The User Manager refers to this account type as a local user account. </td> </tr> <tr> <td
    ///width="40%"><a id="UF_WORKSTATION_TRUST_ACCOUNT"></a><a id="uf_workstation_trust_account"></a><dl>
    ///<dt><b>UF_WORKSTATION_TRUST_ACCOUNT</b></dt> </dl> </td> <td width="60%"> This is a computer account for a
    ///workstation or a server that is a member of this domain. </td> </tr> <tr> <td width="40%"><a
    ///id="UF_SERVER_TRUST_ACCOUNT"></a><a id="uf_server_trust_account"></a><dl> <dt><b>UF_SERVER_TRUST_ACCOUNT</b></dt>
    ///</dl> </td> <td width="60%"> This is a computer account for a backup domain controller that is a member of this
    ///domain. </td> </tr> <tr> <td width="40%"><a id="UF_INTERDOMAIN_TRUST_ACCOUNT"></a><a
    ///id="uf_interdomain_trust_account"></a><dl> <dt><b>UF_INTERDOMAIN_TRUST_ACCOUNT</b></dt> </dl> </td> <td
    ///width="60%"> This is a permit to trust account for a domain that trusts other domains. </td> </tr> </table>
    uint  usri1_flags;
    ///Type: <b>LPWSTR</b> A pointer to a Unicode string that contains the full name of the user. This string can be a
    ///null string, or it can have any number of characters before the terminating null character.
    PWSTR usri1_full_name;
    ///Type: <b>DWORD</b> The relative identifier (RID) of the user. The relative identifier is determined by the
    ///accounts database when the user is created. It uniquely defines this user account to the account manager within
    ///the domain. For more information about relative identifiers, see SID Components.
    uint  usri1_user_id;
    ///Type: <b>DWORD</b> The index of the last entry returned by the NetQueryDisplayInformation function. Pass this
    ///value as the <i>Index</i> parameter to <b>NetQueryDisplayInformation</b> to return the next logical entry. Note
    ///that you should not use the value of this member for any purpose except to retrieve more data with additional
    ///calls to <b>NetQueryDisplayInformation</b>.
    uint  usri1_next_index;
}

///The <b>NET_DISPLAY_MACHINE</b> structure contains information that an account manager can access to determine
///information about computers and their attributes.
struct NET_DISPLAY_MACHINE
{
    ///Type: <b>LPWSTR</b> A pointer to a Unicode string that specifies the name of the computer to access.
    PWSTR usri2_name;
    ///Type: <b>LPWSTR</b> A pointer to a Unicode string that contains a comment associated with the computer. This
    ///string can be a null string, or it can have any number of characters before the terminating null character.
    PWSTR usri2_comment;
    ///Type: <b>DWORD</b> A set of flags that contains values that determine several features. This member can be one or
    ///more of the following values. Note that setting user account control flags may require certain privileges and
    ///control access rights. For more information, see the Remarks section of the NetUserSetInfo function. <table> <tr>
    ///<th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="UF_SCRIPT"></a><a id="uf_script"></a><dl>
    ///<dt><b>UF_SCRIPT</b></dt> </dl> </td> <td width="60%"> The logon script executed. This value must be set. </td>
    ///</tr> <tr> <td width="40%"><a id="UF_ACCOUNTDISABLE"></a><a id="uf_accountdisable"></a><dl>
    ///<dt><b>UF_ACCOUNTDISABLE</b></dt> </dl> </td> <td width="60%"> The user's account is disabled. </td> </tr> <tr>
    ///<td width="40%"><a id="UF_PASSWD_NOTREQD"></a><a id="uf_passwd_notreqd"></a><dl>
    ///<dt><b>UF_PASSWD_NOTREQD</b></dt> </dl> </td> <td width="60%"> No password is required. </td> </tr> <tr> <td
    ///width="40%"><a id="UF_PASSWD_CANT_CHANGE"></a><a id="uf_passwd_cant_change"></a><dl>
    ///<dt><b>UF_PASSWD_CANT_CHANGE</b></dt> </dl> </td> <td width="60%"> The user cannot change the password. </td>
    ///</tr> <tr> <td width="40%"><a id="UF_LOCKOUT"></a><a id="uf_lockout"></a><dl> <dt><b>UF_LOCKOUT</b></dt> </dl>
    ///</td> <td width="60%"> The account is currently locked out (blocked). For the NetUserSetInfo function, this value
    ///can be cleared to unlock a previously locked account. This value cannot be used to lock a previously unlocked
    ///account. </td> </tr> <tr> <td width="40%"><a id="UF_DONT_EXPIRE_PASSWD"></a><a
    ///id="uf_dont_expire_passwd"></a><dl> <dt><b>UF_DONT_EXPIRE_PASSWD</b></dt> </dl> </td> <td width="60%"> Represents
    ///the password, which will never expire on the account. </td> </tr> <tr> <td width="40%"><a
    ///id="UF_TRUSTED_FOR_DELEGATION"></a><a id="uf_trusted_for_delegation"></a><dl>
    ///<dt><b>UF_TRUSTED_FOR_DELEGATION</b></dt> </dl> </td> <td width="60%"> The account is enabled for delegation.
    ///This is a security-sensitive setting; accounts with this option enabled should be tightly controlled. This
    ///setting allows a service running under the account to assume a client's identity and authenticate as that user to
    ///other remote servers on the network. </td> </tr> <tr> <td width="40%"><a
    ///id="UF_ENCRYPTED_TEXT_PASSWORD_ALLOWED"></a><a id="uf_encrypted_text_password_allowed"></a><dl>
    ///<dt><b>UF_ENCRYPTED_TEXT_PASSWORD_ALLOWED</b></dt> </dl> </td> <td width="60%"> The user's password is stored
    ///under reversible encryption in the Active Directory. </td> </tr> <tr> <td width="40%"><a
    ///id="UF_NOT_DELEGATED"></a><a id="uf_not_delegated"></a><dl> <dt><b>UF_NOT_DELEGATED</b></dt> </dl> </td> <td
    ///width="60%"> Marks the account as "sensitive"; other users cannot act as delegates of this user account. </td>
    ///</tr> <tr> <td width="40%"><a id="UF_SMARTCARD_REQUIRED"></a><a id="uf_smartcard_required"></a><dl>
    ///<dt><b>UF_SMARTCARD_REQUIRED</b></dt> </dl> </td> <td width="60%"> Requires the user to log on to the user
    ///account with a smart card. </td> </tr> <tr> <td width="40%"><a id="UF_USE_DES_KEY_ONLY"></a><a
    ///id="uf_use_des_key_only"></a><dl> <dt><b>UF_USE_DES_KEY_ONLY</b></dt> </dl> </td> <td width="60%"> Restrict this
    ///principal to use only Data Encryption Standard (DES) encryption types for keys. </td> </tr> <tr> <td
    ///width="40%"><a id="UF_DONT_REQUIRE_PREAUTH"></a><a id="uf_dont_require_preauth"></a><dl>
    ///<dt><b>UF_DONT_REQUIRE_PREAUTH</b></dt> </dl> </td> <td width="60%"> This account does not require Kerberos
    ///preauthentication for logon. </td> </tr> <tr> <td width="40%"><a id="UF_PASSWORD_EXPIRED"></a><a
    ///id="uf_password_expired"></a><dl> <dt><b>UF_PASSWORD_EXPIRED</b></dt> </dl> </td> <td width="60%"> The user's
    ///password has expired. <b>Windows 2000: </b>This value is not supported. </td> </tr> <tr> <td width="40%"><a
    ///id="UF_TRUSTED_TO_AUTHENTICATE_FOR_DELEGATION"></a><a id="uf_trusted_to_authenticate_for_delegation"></a><dl>
    ///<dt><b>UF_TRUSTED_TO_AUTHENTICATE_FOR_DELEGATION</b></dt> </dl> </td> <td width="60%"> The account is trusted to
    ///authenticate a user outside of the Kerberos security package and delegate that user through constrained
    ///delegation. This is a security-sensitive setting; accounts with this option enabled should be tightly controlled.
    ///This setting allows a service running under the account to assert a client's identity and authenticate as that
    ///user to specifically configured services on the network. <b>Windows XP/2000: </b>This value is not supported.
    ///</td> </tr> </table> The following values describe the account type. Only one value can be set. You cannot change
    ///the account type using the NetUserSetInfo function. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td
    ///width="40%"><a id="UF_NORMAL_ACCOUNT"></a><a id="uf_normal_account"></a><dl> <dt><b>UF_NORMAL_ACCOUNT</b></dt>
    ///</dl> </td> <td width="60%"> A default account type that represents a typical user. </td> </tr> <tr> <td
    ///width="40%"><a id="UF_TEMP_DUPLICATE_ACCOUNT"></a><a id="uf_temp_duplicate_account"></a><dl>
    ///<dt><b>UF_TEMP_DUPLICATE_ACCOUNT</b></dt> </dl> </td> <td width="60%"> An account for users whose primary account
    ///is in another domain. This account provides user access to this domain, but not to any domain that trusts this
    ///domain. The User Manager refers to this account type as a local user account. </td> </tr> <tr> <td width="40%"><a
    ///id="UF_WORKSTATION_TRUST_ACCOUNT"></a><a id="uf_workstation_trust_account"></a><dl>
    ///<dt><b>UF_WORKSTATION_TRUST_ACCOUNT</b></dt> </dl> </td> <td width="60%"> A computer account for a workstation or
    ///a server that is a member of this domain. </td> </tr> <tr> <td width="40%"><a id="UF_SERVER_TRUST_ACCOUNT"></a><a
    ///id="uf_server_trust_account"></a><dl> <dt><b>UF_SERVER_TRUST_ACCOUNT</b></dt> </dl> </td> <td width="60%"> A
    ///computer account for a backup domain controller that is a member of this domain. </td> </tr> <tr> <td
    ///width="40%"><a id="UF_INTERDOMAIN_TRUST_ACCOUNT"></a><a id="uf_interdomain_trust_account"></a><dl>
    ///<dt><b>UF_INTERDOMAIN_TRUST_ACCOUNT</b></dt> </dl> </td> <td width="60%"> A permit to trust account for a domain
    ///that trusts other domains. </td> </tr> </table>
    uint  usri2_flags;
    ///Type: <b>DWORD</b> The relative identifier (RID) of the computer. The relative identifier is determined by the
    ///accounts database when the computer is defined. For more information about RIDS, see SID Components.
    uint  usri2_user_id;
    ///Type: <b>DWORD</b> The index of the last entry returned by the NetQueryDisplayInformation function. Pass this
    ///value as the <i>Index</i> parameter to <b>NetQueryDisplayInformation</b> to return the next logical entry. Note
    ///that you should not use the value of this member for any purpose except to retrieve more data with additional
    ///calls to <b>NetQueryDisplayInformation</b>.
    uint  usri2_next_index;
}

///The <b>NET_DISPLAY_GROUP</b> structure contains information that an account manager can access to determine
///information about group accounts.
struct NET_DISPLAY_GROUP
{
    ///Type: <b>LPWSTR</b> A pointer to a Unicode string that specifies the name of the group.
    PWSTR grpi3_name;
    ///Type: <b>LPWSTR</b> A pointer to a Unicode string that contains a comment associated with the group. This string
    ///can be a null string, or it can have any number of characters before the terminating null character.
    PWSTR grpi3_comment;
    ///Type: <b>DWORD</b> The relative identifier (RID) of the group. The relative identifier is determined by the
    ///accounts database when the group is created. It uniquely identifies the group to the account manager within the
    ///domain. The NetUserAdd and NetUserSetInfo functions ignore this member. For more information about RIDs, see SID
    ///Components.
    uint  grpi3_group_id;
    ///Type: <b>DWORD</b> These attributes are hard-coded to SE_GROUP_MANDATORY, SE_GROUP_ENABLED, and
    ///SE_GROUP_ENABLED_BY_DEFAULT. For more information, see TOKEN_GROUPS.
    uint  grpi3_attributes;
    ///Type: <b>DWORD</b> The index of the last entry returned by the NetQueryDisplayInformation function. Pass this
    ///value as the <i>Index</i> parameter to <b>NetQueryDisplayInformation</b> to return the next logical entry. Note
    ///that you should not use the value of this member for any purpose except to retrieve more data with additional
    ///calls to <b>NetQueryDisplayInformation</b>.
    uint  grpi3_next_index;
}

struct ACCESS_INFO_0
{
    PWSTR acc0_resource_name;
}

struct ACCESS_INFO_1
{
    PWSTR acc1_resource_name;
    uint  acc1_attr;
    uint  acc1_count;
}

struct ACCESS_INFO_1002
{
    uint acc1002_attr;
}

struct ACCESS_LIST
{
    PWSTR acl_ugname;
    uint  acl_access;
}

///The <b>NET_VALIDATE_PASSWORD_HASH</b> structure contains a password hash.
struct NET_VALIDATE_PASSWORD_HASH
{
    ///Specifies the length of this structure.
    uint   Length;
    ///Password hash.
    ubyte* Hash;
}

///The <b>NET_VALIDATE_PERSISTED_FIELDS</b> structure contains information about a user's password properties. Input to
///and output from the NetValidatePasswordPolicy function contain persistent password-related data. When the function
///outputs this structure, it identifies the persistent data that has changed in this call.
struct NET_VALIDATE_PERSISTED_FIELDS
{
    ///Type: <b>ULONG</b> A set of bit flags identifying the persistent password-related data that has changed. This
    ///member is valid only when this structure is output from the <b>NetValidatePasswordPolicy</b> function. This
    ///member is ignored when this structure is input to the function. For more information, see the following Remarks
    ///section. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
    ///id="NET_VALIDATE_PASSWORD_LAST_SET"></a><a id="net_validate_password_last_set"></a><dl>
    ///<dt><b>NET_VALIDATE_PASSWORD_LAST_SET</b></dt> </dl> </td> <td width="60%"> The <b>PasswordLastSet</b> member
    ///contains a new value. </td> </tr> <tr> <td width="40%"><a id="NET_VALIDATE_BAD_PASSWORD_TIME"></a><a
    ///id="net_validate_bad_password_time"></a><dl> <dt><b>NET_VALIDATE_BAD_PASSWORD_TIME</b></dt> </dl> </td> <td
    ///width="60%"> The <b>BadPasswordTime</b> member contains a new value. </td> </tr> <tr> <td width="40%"><a
    ///id="NET_VALIDATE_LOCKOUT_TIME"></a><a id="net_validate_lockout_time"></a><dl>
    ///<dt><b>NET_VALIDATE_LOCKOUT_TIME</b></dt> </dl> </td> <td width="60%"> The <b>LockoutTime</b> member contains a
    ///new value. </td> </tr> <tr> <td width="40%"><a id="NET_VALIDATE_BAD_PASSWORD_COUNT"></a><a
    ///id="net_validate_bad_password_count"></a><dl> <dt><b>NET_VALIDATE_BAD_PASSWORD_COUNT</b></dt> </dl> </td> <td
    ///width="60%"> The <b>BadPasswordCount</b> member contains a new value. </td> </tr> <tr> <td width="40%"><a
    ///id="NET_VALIDATE_PASSWORD_HISTORY_LENGTH"></a><a id="net_validate_password_history_length"></a><dl>
    ///<dt><b>NET_VALIDATE_PASSWORD_HISTORY_LENGTH</b></dt> </dl> </td> <td width="60%"> The
    ///<b>PasswordHistoryLength</b> member contains a new value. </td> </tr> <tr> <td width="40%"><a
    ///id="NET_VALIDATE_PASSWORD_HISTORY"></a><a id="net_validate_password_history"></a><dl>
    ///<dt><b>NET_VALIDATE_PASSWORD_HISTORY</b></dt> </dl> </td> <td width="60%"> The <b>PasswordHistory</b> member
    ///contains a new value. </td> </tr> </table>
    uint     PresentFields;
    ///Type: <b>FILETIME</b> The date and time (in GMT) when the password for the account was set or last changed.
    FILETIME PasswordLastSet;
    ///Type: <b>FILETIME</b> The date and time (in GMT) when the user tried to log on to the account using an incorrect
    ///password.
    FILETIME BadPasswordTime;
    ///Type: <b>FILETIME</b> The date and time (in GMT) when the account was last locked out. If the account has not
    ///been locked out, this member is zero. A lockout occurs when the number of bad password logins exceeds the number
    ///allowed.
    FILETIME LockoutTime;
    ///Type: <b>ULONG</b> The number of times the user tried to log on to the account using an incorrect password.
    uint     BadPasswordCount;
    ///Type: <b>ULONG</b> The number of previous passwords saved in the history list for the account. The user cannot
    ///reuse a password in the history list.
    uint     PasswordHistoryLength;
    ///Type: <b>PNET_VALIDATE_PASSWORD_HASH</b> A pointer to a NET_VALIDATE_PASSWORD_HASH structure that contains the
    ///password hashes in the history list.
    NET_VALIDATE_PASSWORD_HASH* PasswordHistory;
}

///The <b>NET_VALIDATE_OUTPUT_ARG</b> structure contains information about persistent password-related data that has
///changed since the user's last logon as well as the result of the function's password validation check.
struct NET_VALIDATE_OUTPUT_ARG
{
    ///A structure that contains changes to persistent information about the account being logged on. For more
    ///information, see the following Remarks section.
    NET_VALIDATE_PERSISTED_FIELDS ChangedPersistedFields;
    ///The result of the password validation check performed by the NetValidatePasswordPolicy function. The status
    ///depends on the value specified in the <i>ValidationType</i> parameter to that function. <b>Authentication.</b>
    ///When you call NetValidatePasswordPolicy and specify the <i>ValidationType</i> parameter as
    ///NetValidateAuthentication, this member can be one of the following values. <table> <tr> <th>Value</th>
    ///<th>Meaning</th> </tr> <tr> <td>NERR_AccountLockedOut</td> <td>Validation failed. The account is locked out.
    ///</td> </tr> <tr> <td>NERR_PasswordMustChange</td> <td>Validation failed. The password must change at the next
    ///logon. </td> </tr> <tr> <td>NERR_PasswordExpired</td> <td>Validation failed. The password has expired. </td>
    ///</tr> <tr> <td>NERR_BadPassword</td> <td>Validation failed. The password is invalid. </td> </tr> <tr>
    ///<td>NERR_Success</td> <td>The password passes the validation check.</td> </tr> </table> <b>Password change.</b>
    ///When you call NetValidatePasswordPolicy and specify the <i>ValidationType</i> parameter as
    ///NetValidatePasswordChange, this member can be one of the following values. <table> <tr> <th>Value</th>
    ///<th>Meaning</th> </tr> <tr> <td>NERR_AccountLockedOut</td> <td>Validation failed. The account is locked out.
    ///</td> </tr> <tr> <td>NERR_PasswordTooRecent</td> <td>Validation failed. The password for the user is too recent
    ///to change. </td> </tr> <tr> <td>NERR_BadPassword</td> <td>Validation failed. The password is invalid. </td> </tr>
    ///<tr> <td>NERR_PasswordHistConflict</td> <td>Validation failed. The password cannot be used at this time. </td>
    ///</tr> <tr> <td>NERR_PasswordTooShort</td> <td>Validation failed. The password does not meet policy requirements
    ///because it is too short. </td> </tr> <tr> <td>NERR_PasswordTooLong</td> <td>Validation failed. The password does
    ///not meet policy requirements because it is too long. </td> </tr> <tr> <td>NERR_PasswordNotComplexEnough</td>
    ///<td>Validation failed. The password does not meet policy requirements because it is not complex enough. </td>
    ///</tr> <tr> <td>NERR_PasswordFilterError</td> <td>Validation failed. The password does not meet the requirements
    ///of the password filter DLL. </td> </tr> <tr> <td>NERR_Success</td> <td>The password passes the validation
    ///check.</td> </tr> </table> <b>Password reset.</b> When you call <b>NetValidatePasswordPolicy</b> and specify the
    ///<i>ValidationType</i> parameter as NetValidatePasswordReset, this member can be one of the following values.
    ///<table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td>NERR_PasswordTooShort</td> <td>Validation failed. The
    ///password does not meet policy requirements because it is too short.</td> </tr> <tr> <td>NERR_PasswordTooLong</td>
    ///<td>Validation failed. The password does not meet policy requirements because it is too long.</td> </tr> <tr>
    ///<td>NERR_PasswordNotComplexEnough</td> <td>Validation failed. The password does not meet policy requirements
    ///because it is not complex enough. </td> </tr> <tr> <td>NERR_PasswordFilterError</td> <td>Validation failed. The
    ///password does not meet the requirements of the password filter DLL. </td> </tr> <tr> <td>NERR_Success</td>
    ///<td>The password passes the validation check.</td> </tr> </table>
    uint ValidationStatus;
}

///A client application passes the <b>NET_VALIDATE_AUTHENTICATION_INPUT_ARG</b> structure to the
///NetValidatePasswordPolicy function when the application requests an authentication validation.
struct NET_VALIDATE_AUTHENTICATION_INPUT_ARG
{
    ///Specifies a NET_VALIDATE_PERSISTED_FIELDS structure that contains persistent password-related information about
    ///the account being logged on.
    NET_VALIDATE_PERSISTED_FIELDS InputPersistedFields;
    ///BOOLEAN value that indicates the result of the client application's authentication of the password supplied by
    ///the user. If this parameter is <b>FALSE</b>, the password has not been authenticated.
    ubyte PasswordMatched;
}

///A client application passes the <b>NET_VALIDATE_PASSWORD_CHANGE_INPUT_ARG</b> structure to the
///NetValidatePasswordPolicy function when the application requests a password change validation.
struct NET_VALIDATE_PASSWORD_CHANGE_INPUT_ARG
{
    ///Specifies a NET_VALIDATE_PERSISTED_FIELDS structure that contains persistent password-related information about
    ///the account being logged on.
    NET_VALIDATE_PERSISTED_FIELDS InputPersistedFields;
    ///Pointer to a Unicode string specifying the new password, in plaintext format.
    PWSTR ClearPassword;
    ///Pointer to a Unicode string specifying the name of the user account.
    PWSTR UserAccountName;
    ///Specifies a NET_VALIDATE_PASSWORD_HASH structure that contains a hash of the new password.
    NET_VALIDATE_PASSWORD_HASH HashedPassword;
    ///BOOLEAN value that indicates the result of the application's attempt to validate the old password supplied by the
    ///user. If this parameter is <b>FALSE</b>, the password was not validated.
    ubyte PasswordMatch;
}

///A client application passes the <b>NET_VALIDATE_PASSWORD_RESET_INPUT_ARG</b> structure to the
///NetValidatePasswordPolicy function when the application requests a password reset validation.
struct NET_VALIDATE_PASSWORD_RESET_INPUT_ARG
{
    ///Specifies a NET_VALIDATE_PERSISTED_FIELDS structure that contains persistent password-related information about
    ///the account being logged on.
    NET_VALIDATE_PERSISTED_FIELDS InputPersistedFields;
    ///Pointer to a Unicode string specifying the new password, in plaintext format.
    PWSTR ClearPassword;
    ///Pointer to a Unicode string specifying the name of the user account.
    PWSTR UserAccountName;
    ///Specifies a NET_VALIDATE_PASSWORD_HASH structure that contains a hash of the new password.
    NET_VALIDATE_PASSWORD_HASH HashedPassword;
    ///BOOLEAN value that indicates whether the user must change his or her password at the next logon. If this
    ///parameter is <b>TRUE</b>, the user must change the password at the next logon.
    ubyte PasswordMustChangeAtNextLogon;
    ///BOOLEAN value that can reset the "lockout state" of the user account. If this member is <b>TRUE</b>, the account
    ///will no longer be locked out. Note that an application cannot directly lock out an account. An account can be
    ///locked out only as a result of exceeding the maximum number of invalid password authentications allowed for the
    ///account.
    ubyte ClearLockout;
}

///Contains information about a user account that is used to join a device to Microsoft Azure Active Directory.
struct DSREG_USER_INFO
{
    ///The email address of the user.
    PWSTR pszUserEmail;
    ///The identifier of the Microsoft Passport key that is provisioned for the user.
    PWSTR pszUserKeyId;
    PWSTR pszUserKeyName;
}

///Contains information about how a device is joined to Microsoft Azure Active Directory.
struct DSREG_JOIN_INFO
{
    ///An enumeration value that specifies the type of the join.
    DSREG_JOIN_TYPE  joinType;
    ///Representations of the certification for the join.
    CERT_CONTEXT*    pJoinCertificate;
    ///The identifier of the device.
    PWSTR            pszDeviceId;
    ///A string that represents Azure Active Directory (Azure AD).
    PWSTR            pszIdpDomain;
    ///The identifier of the joined Azure AD tenant.
    PWSTR            pszTenantId;
    ///The email address for the joined account.
    PWSTR            pszJoinUserEmail;
    ///The display name for the joined account.
    PWSTR            pszTenantDisplayName;
    ///The URL to use to enroll in the Mobile Device Management (MDM) service.
    PWSTR            pszMdmEnrollmentUrl;
    ///The URL that provides information about the terms of use for the MDM service.
    PWSTR            pszMdmTermsOfUseUrl;
    ///The URL that provides information about compliance for the MDM service.
    PWSTR            pszMdmComplianceUrl;
    ///The URL for synchronizing user settings.
    PWSTR            pszUserSettingSyncUrl;
    ///Information about the user account that was used to join a device to Azure AD.
    DSREG_USER_INFO* pUserInfo;
}

///The <b>NETSETUP_PROVISIONING_PARAMS</b> structure contains information that is used when creating a provisioning
///package using the NetCreateProvisionPackage function.
struct NETSETUP_PROVISIONING_PARAMS
{
    ///The version of Windows in the provisioning package. This parameter should use the following value defined in the
    ///<i>Lmjoin.h</i> header file. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
    ///id="NETSETUP_PROVISIONING_PARAMS_CURRENT_VERSION"></a><a
    ///id="netsetup_provisioning_params_current_version"></a><dl>
    ///<dt><b>NETSETUP_PROVISIONING_PARAMS_CURRENT_VERSION</b></dt> <dt>0x00000001</dt> </dl> </td> <td width="60%"> The
    ///version for this package is Windows Server 2012. </td> </tr> </table>
    uint         dwVersion;
    ///A pointer to a <b>NULL</b>-terminated character string that specifies the name of the domain where the computer
    ///account is created.
    const(PWSTR) lpDomain;
    ///A pointer to a <b>NULL</b>-terminated character string that specifies the short name of the machine from which
    ///the computer account attribute sAMAccountName is derived by appending a '$'. This parameter must contain a valid
    ///DNS or NetBIOS machine name.
    const(PWSTR) lpHostName;
    ///A optional pointer to a <b>NULL</b>-terminated character string that contains the RFC 1779 format name of the
    ///organizational unit (OU) where the computer account will be created. If you specify this parameter, the string
    ///must contain a full path, for example, OU=testOU,DC=domain,DC=Domain,DC=com. Otherwise, this parameter must be
    ///<b>NULL</b>. If this parameter is <b>NULL</b>, the well known computer object container will be used as published
    ///in the domain.
    const(PWSTR) lpMachineAccountOU;
    ///An optional pointer to a <b>NULL</b>-terminated character string that contains the name of the domain controller
    ///to target.
    const(PWSTR) lpDcName;
    ///A set of bit flags that define provisioning options. This parameter can be one or more of the following values
    ///defined in the <i>Lmjoin.h</i> header file. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td
    ///width="40%"><a id="NETSETUP_PROVISION_DOWNLEVEL_PRIV_SUPPORT"></a><a
    ///id="netsetup_provision_downlevel_priv_support"></a><dl> <dt><b>NETSETUP_PROVISION_DOWNLEVEL_PRIV_SUPPORT</b></dt>
    ///<dt>0x00000001</dt> </dl> </td> <td width="60%"> If the caller requires account creation by privilege, this
    ///option will cause a retry on failure using account creation functions enabling interoperability with domain
    ///controllers running on earlier versions of Windows. The <i>lpMachineAccountOU</i> is not supported when using
    ///downlevel privilege support. </td> </tr> <tr> <td width="40%"><a id="NETSETUP_PROVISION_REUSE_ACCOUNT"></a><a
    ///id="netsetup_provision_reuse_account"></a><dl> <dt><b>NETSETUP_PROVISION_REUSE_ACCOUNT</b></dt>
    ///<dt>0x00000002</dt> </dl> </td> <td width="60%"> If the named account already exists, an attempt will be made to
    ///reuse the existing account. This option requires sufficient credentials for this operation (Domain Administrator
    ///or the object owner). </td> </tr> <tr> <td width="40%"><a id="NETSETUP_PROVISION_USE_DEFAULT_PASSWORD"></a><a
    ///id="netsetup_provision_use_default_password"></a><dl> <dt><b>NETSETUP_PROVISION_USE_DEFAULT_PASSWORD</b></dt>
    ///<dt>0x00000004</dt> </dl> </td> <td width="60%"> Use the default machine account password which is the machine
    ///name in lowercase. This is largely to support the older unsecure join model where the pre-created account
    ///typically used this default password. </td> </tr> <tr> <td width="40%"><a
    ///id="NETSETUP_PROVISION_SKIP_ACCOUNT_SEARCH"></a><a id="netsetup_provision_skip_account_search"></a><dl>
    ///<dt><b>NETSETUP_PROVISION_SKIP_ACCOUNT_SEARCH</b></dt> <dt>0x00000008</dt> </dl> </td> <td width="60%"> Do not
    ///try to find the account on any domain controller in the domain. This option makes the operation faster, but
    ///should only be used when the caller is certain that an account by the same name hasn't recently been created.
    ///This option is only valid when the <i>lpDcName</i> parameter is specified. When the prerequisites are met, this
    ///option allows for must faster provisioning useful for scenarios such as batch processing. </td> </tr> <tr> <td
    ///width="40%"><a id="NETSETUP_PROVISION_ROOT_CA_CERTS"></a><a id="netsetup_provision_root_ca_certs"></a><dl>
    ///<dt><b>NETSETUP_PROVISION_ROOT_CA_CERTS</b></dt> <dt>0x00000010</dt> </dl> </td> <td width="60%"> This option
    ///retrieves all of the root Certificate Authority certificates on the local machine and adds them to the
    ///provisioning package. <div class="alert"><b>Note</b> This flag is only supported by the
    ///NetCreateProvisioningPackage function on Windows 8, Windows Server 2012, and later.</div> <div> </div> </td>
    ///</tr> </table>
    uint         dwProvisionOptions;
    ///A pointer to an array of <b>NULL</b>-terminated certificate template names.
    PWSTR*       aCertTemplateNames;
    ///When <b>aCertTemplateNames</b> is not <b>NULL</b>, this member provides an explicit count of the number of items
    ///in the array.
    uint         cCertTemplateNames;
    ///A pointer to an array of <b>NULL</b>-terminated machine policy names.
    PWSTR*       aMachinePolicyNames;
    ///When <b>aMachinePolicyNames</b> is not <b>NULL</b>, this member provides an explicit count of the number of items
    ///in the array.
    uint         cMachinePolicyNames;
    ///A pointer to an array of character strings. Each array element is a NULL-terminated character string which
    ///specifies the full or partial path to a file in the Registry Policy File format. For more information on the
    ///Registry Policy File Format , see Registry Policy File Format This path could be a UNC path on a remote server.
    PWSTR*       aMachinePolicyPaths;
    ///When <b>aMachinePolicyPaths</b> is not <b>NULL</b>, this member provides an explicit count of the number of items
    ///in the array.
    uint         cMachinePolicyPaths;
    ///TBD
    PWSTR        lpNetbiosName;
    ///TBD
    PWSTR        lpSiteName;
    ///TBD
    PWSTR        lpPrimaryDNSDomain;
}

///The <b>STD_ALERT</b> structure contains the time and date when a significant event occurred. The structure also
///contains an alert class and the name of the application that is raising the alert message. You must specify the
///<b>STD_ALERT</b> structure when you send an alert message using the NetAlertRaise function.
struct STD_ALERT
{
    ///Type: <b>DWORD</b> The time and date of the event. This value is stored as the number of seconds that have
    ///elapsed since 00:00:00, January 1, 1970, GMT.
    uint       alrt_timestamp;
    ///Type: <b>WCHAR[EVLEN + 1]</b> A Unicode string indicating the alert class (type of event). This parameter can be
    ///one of the following predefined values, or another alert class that you have defined for network applications.
    ///(The event name for an alert can be any text string.) <table> <tr> <th>Name</th> <th>Meaning</th> </tr> <tr> <td
    ///width="40%"><a id="ALERT_ADMIN_EVENT"></a><a id="alert_admin_event"></a><dl> <dt><b>ALERT_ADMIN_EVENT</b></dt>
    ///</dl> </td> <td width="60%"> An administrator's intervention is required. </td> </tr> <tr> <td width="40%"><a
    ///id="ALERT_ERRORLOG_EVENT"></a><a id="alert_errorlog_event"></a><dl> <dt><b>ALERT_ERRORLOG_EVENT</b></dt> </dl>
    ///</td> <td width="60%"> An entry was added to the error log. </td> </tr> <tr> <td width="40%"><a
    ///id="ALERT_MESSAGE_EVENT"></a><a id="alert_message_event"></a><dl> <dt><b>ALERT_MESSAGE_EVENT</b></dt> </dl> </td>
    ///<td width="60%"> A user or application received a broadcast message. </td> </tr> <tr> <td width="40%"><a
    ///id="ALERT_PRINT_EVENT"></a><a id="alert_print_event"></a><dl> <dt><b>ALERT_PRINT_EVENT</b></dt> </dl> </td> <td
    ///width="60%"> A print job completed or a print error occurred. </td> </tr> <tr> <td width="40%"><a
    ///id="ALERT_USER_EVENT"></a><a id="alert_user_event"></a><dl> <dt><b>ALERT_USER_EVENT</b></dt> </dl> </td> <td
    ///width="60%"> An application or resource was used. </td> </tr> </table>
    ushort[17] alrt_eventname;
    ///Type: <b>WCHAR[SNLEN + 1]</b> A Unicode string indicating the service application that is raising the alert
    ///message.
    ushort[81] alrt_servicename;
}

///The <b>ADMIN_OTHER_INFO</b> structure contains error message information. The NetAlertRaise and NetAlertRaiseEx
///functions use the <b>ADMIN_OTHER_INFO</b> structure to specify information when raising an administrator's
///interrupting message.
struct ADMIN_OTHER_INFO
{
    ///Specifies the error code for the new message written to the message log.
    uint alrtad_errcode;
    ///Specifies the number (0-9) of consecutive Unicode strings written to the message log.
    uint alrtad_numstrings;
}

///The <b>ERRLOG_OTHER_INFO</b> structure contains error log information. The NetAlertRaise and NetAlertRaiseEx
///functions use the <b>ERRLOG_OTHER_INFO</b> structure to specify information when adding a new entry to the error log.
struct ERRLOG_OTHER_INFO
{
    ///Specifies the error code that was written to the error log.
    uint alrter_errcode;
    ///Specifies the offset for the new entry in the error log.
    uint alrter_offset;
}

///The <b>PRINT_OTHER_INFO</b> structure contains information about a print job. The NetAlertRaise and NetAlertRaiseEx
///functions use the <b>PRINT_OTHER_INFO</b> structure to specify information when a job has finished printing, or when
///a printer needs intervention.
struct PRINT_OTHER_INFO
{
    ///Type: <b>DWORD</b> The identification number of the print job.
    uint alrtpr_jobid;
    ///Type: <b>DWORD</b> A bitmask describing the status of the print job. You can obtain the overall status of the job
    ///by checking PRJOB_QSTATUS (bits 0 and 1). Possible values for the print job status are listed in the
    ///<i>Lmalert.h</i> header file. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
    ///id="PRJOB_QS_QUEUED"></a><a id="prjob_qs_queued"></a><dl> <dt><b>PRJOB_QS_QUEUED</b></dt> <dt>0</dt> </dl> </td>
    ///<td width="60%"> The print job is in the queue waiting to be scheduled. </td> </tr> <tr> <td width="40%"><a
    ///id="PRJOB_QS_PAUSED"></a><a id="prjob_qs_paused"></a><dl> <dt><b>PRJOB_QS_PAUSED</b></dt> <dt>1</dt> </dl> </td>
    ///<td width="60%"> The print job is in the queue, but it has been paused. (When a job is paused, it cannot be
    ///scheduled.) </td> </tr> <tr> <td width="40%"><a id="PRJOB_QS_SPOOLING"></a><a id="prjob_qs_spooling"></a><dl>
    ///<dt><b>PRJOB_QS_SPOOLING</b></dt> <dt>2</dt> </dl> </td> <td width="60%"> The print job is in the process of
    ///being spooled. </td> </tr> <tr> <td width="40%"><a id="PRJOB_QS_PRINTING"></a><a id="prjob_qs_printing"></a><dl>
    ///<dt><b>PRJOB_QS_PRINTING</b></dt> <dt>3</dt> </dl> </td> <td width="60%"> The job is currently printing. </td>
    ///</tr> </table> If the print job is in the PRJOB_QS_PRINTING state, you can check bits 2 through 8 for the
    ///device's status (PRJOB_DEVSTATUS). Bit 15 is also meaningful. Possible values for the device's status are listed
    ///in the <i>Lmalert.h</i> header file. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
    ///id="PRJOB_COMPLETE"></a><a id="prjob_complete"></a><dl> <dt><b>PRJOB_COMPLETE</b></dt> <dt>0x4</dt> </dl> </td>
    ///<td width="60%"> The job has completed printing. </td> </tr> <tr> <td width="40%"><a id="PRJOB_INTERV"></a><a
    ///id="prjob_interv"></a><dl> <dt><b>PRJOB_INTERV</b></dt> <dt>0x8</dt> </dl> </td> <td width="60%"> The destination
    ///printer requires an operator's intervention. </td> </tr> <tr> <td width="40%"><a id="PRJOB_ERROR"></a><a
    ///id="prjob_error"></a><dl> <dt><b>PRJOB_ERROR</b></dt> <dt>0x10</dt> </dl> </td> <td width="60%"> There is an
    ///error at the destination printer. </td> </tr> <tr> <td width="40%"><a id="PRJOB_DESTOFFLINE"></a><a
    ///id="prjob_destoffline"></a><dl> <dt><b>PRJOB_DESTOFFLINE</b></dt> <dt>0x20</dt> </dl> </td> <td width="60%"> The
    ///destination printer is offline. </td> </tr> <tr> <td width="40%"><a id="PRJOB_DESTPAUSED"></a><a
    ///id="prjob_destpaused"></a><dl> <dt><b>PRJOB_DESTPAUSED</b></dt> <dt>0x40</dt> </dl> </td> <td width="60%"> The
    ///destination printer is paused. </td> </tr> <tr> <td width="40%"><a id="PRJOB_NOTIFY"></a><a
    ///id="prjob_notify"></a><dl> <dt><b>PRJOB_NOTIFY</b></dt> <dt>0x80</dt> </dl> </td> <td width="60%"> A printing
    ///alert should be raised. </td> </tr> <tr> <td width="40%"><a id="PRJOB_DESTNOPAPER"></a><a
    ///id="prjob_destnopaper"></a><dl> <dt><b>PRJOB_DESTNOPAPER</b></dt> <dt>0x100</dt> </dl> </td> <td width="60%"> The
    ///destination printer is out of paper. </td> </tr> <tr> <td width="40%"><a id="PRJOB_DELETED"></a><a
    ///id="prjob_deleted"></a><dl> <dt><b>PRJOB_DELETED</b></dt> <dt>0x8000</dt> </dl> </td> <td width="60%"> The
    ///printing job is being deleted. </td> </tr> </table>
    uint alrtpr_status;
    ///Type: <b>DWORD</b> The time at which the print job was submitted. This value is stored as the number of seconds
    ///that have elapsed since 00:00:00, January 1, 1970, GMT.
    uint alrtpr_submitted;
    ///Type: <b>DWORD</b> The size, in bytes, of the print job.
    uint alrtpr_size;
}

///The <b>USER_OTHER_INFO</b> structure contains user error code information. The NetAlertRaise and NetAlertRaiseEx
///functions use the <b>USER_OTHER_INFO</b> structure to specify information about an event or condition of interest to
///a user.
struct USER_OTHER_INFO
{
    ///Specifies the error code for the new message in the message log.
    uint alrtus_errcode;
    ///Specifies the number (0-9) of consecutive Unicode strings in the message log.
    uint alrtus_numstrings;
}

struct HLOG
{
    uint time;
    uint last_flags;
    uint offset;
    uint rec_offset;
}

struct AUDIT_ENTRY
{
    uint ae_len;
    uint ae_reserved;
    uint ae_time;
    uint ae_type;
    uint ae_data_offset;
    uint ae_data_size;
}

struct AE_SRVSTATUS
{
    uint ae_sv_status;
}

struct AE_SESSLOGON
{
    uint ae_so_compname;
    uint ae_so_username;
    uint ae_so_privilege;
}

struct AE_SESSLOGOFF
{
    uint ae_sf_compname;
    uint ae_sf_username;
    uint ae_sf_reason;
}

struct AE_SESSPWERR
{
    uint ae_sp_compname;
    uint ae_sp_username;
}

struct AE_CONNSTART
{
    uint ae_ct_compname;
    uint ae_ct_username;
    uint ae_ct_netname;
    uint ae_ct_connid;
}

struct AE_CONNSTOP
{
    uint ae_cp_compname;
    uint ae_cp_username;
    uint ae_cp_netname;
    uint ae_cp_connid;
    uint ae_cp_reason;
}

struct AE_CONNREJ
{
    uint ae_cr_compname;
    uint ae_cr_username;
    uint ae_cr_netname;
    uint ae_cr_reason;
}

struct AE_RESACCESS
{
    uint ae_ra_compname;
    uint ae_ra_username;
    uint ae_ra_resname;
    uint ae_ra_operation;
    uint ae_ra_returncode;
    uint ae_ra_restype;
    uint ae_ra_fileid;
}

struct AE_RESACCESSREJ
{
    uint ae_rr_compname;
    uint ae_rr_username;
    uint ae_rr_resname;
    uint ae_rr_operation;
}

struct AE_CLOSEFILE
{
    uint ae_cf_compname;
    uint ae_cf_username;
    uint ae_cf_resname;
    uint ae_cf_fileid;
    uint ae_cf_duration;
    uint ae_cf_reason;
}

struct AE_SERVICESTAT
{
    uint ae_ss_compname;
    uint ae_ss_username;
    uint ae_ss_svcname;
    uint ae_ss_status;
    uint ae_ss_code;
    uint ae_ss_text;
    uint ae_ss_returnval;
}

struct AE_ACLMOD
{
    uint ae_am_compname;
    uint ae_am_username;
    uint ae_am_resname;
    uint ae_am_action;
    uint ae_am_datalen;
}

struct AE_UASMOD
{
    uint ae_um_compname;
    uint ae_um_username;
    uint ae_um_resname;
    uint ae_um_rectype;
    uint ae_um_action;
    uint ae_um_datalen;
}

struct AE_NETLOGON
{
    uint ae_no_compname;
    uint ae_no_username;
    uint ae_no_privilege;
    uint ae_no_authflags;
}

struct AE_NETLOGOFF
{
    uint ae_nf_compname;
    uint ae_nf_username;
    uint ae_nf_reserved1;
    uint ae_nf_reserved2;
}

struct AE_ACCLIM
{
    uint ae_al_compname;
    uint ae_al_username;
    uint ae_al_resname;
    uint ae_al_limit;
}

struct AE_LOCKOUT
{
    uint ae_lk_compname;
    uint ae_lk_username;
    uint ae_lk_action;
    uint ae_lk_bad_pw_count;
}

struct AE_GENERIC
{
    uint ae_ge_msgfile;
    uint ae_ge_msgnum;
    uint ae_ge_params;
    uint ae_ge_param1;
    uint ae_ge_param2;
    uint ae_ge_param3;
    uint ae_ge_param4;
    uint ae_ge_param5;
    uint ae_ge_param6;
    uint ae_ge_param7;
    uint ae_ge_param8;
    uint ae_ge_param9;
}

struct CONFIG_INFO_0
{
    PWSTR cfgi0_key;
    PWSTR cfgi0_data;
}

struct ERROR_LOG
{
    uint   el_len;
    uint   el_reserved;
    uint   el_time;
    uint   el_error;
    PWSTR  el_name;
    PWSTR  el_text;
    ubyte* el_data;
    uint   el_data_size;
    uint   el_nstrings;
}

///The <b>MSG_INFO_0</b> structure specifies a message alias.
struct MSG_INFO_0
{
    ///Pointer to a Unicode string that specifies the alias to which the message is to be sent. The constant LEN
    ///specifies the maximum number of characters in the string.
    PWSTR msgi0_name;
}

///The <b>MSG_INFO_1</b> structure specifies a message alias. This structure exists only for compatibility. Message
///forwarding is not supported.
struct MSG_INFO_1
{
    ///Pointer to a Unicode string that specifies the alias to which the message is to be sent. The constant LEN
    ///specifies the maximum number of characters in the string.
    PWSTR msgi1_name;
    ///This member must be zero.
    uint  msgi1_forward_flag;
    ///This member must be <b>NULL</b>.
    PWSTR msgi1_forward;
}

///The <b>TIME_OF_DAY_INFO</b> structure contains information about the time of day from a remote server.
struct TIME_OF_DAY_INFO
{
    ///Type: <b>DWORD</b> The number of seconds since 00:00:00, January 1, 1970, GMT.
    uint tod_elapsedt;
    ///Type: <b>DWORD</b> The number of milliseconds from an arbitrary starting point (system reset). Typically, this
    ///member is read twice, once when the process begins and again at the end. To determine the elapsed time between
    ///the process's start and finish, you can subtract the first value from the second.
    uint tod_msecs;
    ///Type: <b>DWORD</b> The current hour. Valid values are 0 through 23.
    uint tod_hours;
    ///Type: <b>DWORD</b> The current minute. Valid values are 0 through 59.
    uint tod_mins;
    ///Type: <b>DWORD</b> The current second. Valid values are 0 through 59.
    uint tod_secs;
    ///Type: <b>DWORD</b> The current hundredth second (0.01 second). Valid values are 0 through 99.
    uint tod_hunds;
    ///Type: <b>LONG</b> The time zone of the server. This value is calculated, in minutes, from Greenwich Mean Time
    ///(GMT). For time zones west of Greenwich, the value is positive; for time zones east of Greenwich, the value is
    ///negative. A value of –1 indicates that the time zone is undefined.
    int  tod_timezone;
    ///Type: <b>DWORD</b> The time interval for each tick of the clock. Each integral integer represents one
    ///ten-thousandth second (0.0001 second).
    uint tod_tinterval;
    ///Type: <b>DWORD</b> The day of the month. Valid values are 1 through 31.
    uint tod_day;
    ///Type: <b>DWORD</b> The month of the year. Valid values are 1 through 12.
    uint tod_month;
    ///Type: <b>DWORD</b> The year.
    uint tod_year;
    ///Type: <b>DWORD</b> The day of the week. Valid values are 0 through 6, where 0 is Sunday, 1 is Monday, and so on.
    uint tod_weekday;
}

///The <b>AT_INFO</b> structure contains information about a job. The NetScheduleJobAdd function uses the structure to
///specify information when scheduling a job. The NetScheduleJobGetInfo function uses the structure to retrieve
///information about a job that has already been submitted.
struct AT_INFO
{
    ///Type: <b>DWORD_PTR</b> A pointer to a value that indicates the time of day at which the job is scheduled to run.
    ///The time is the local time at a computer on which the schedule service is running; it is measured from midnight,
    ///and is expressed in milliseconds.
    size_t JobTime;
    ///Type: <b>DWORD</b> A set of bit flags representing the days of the month. For each bit that is set, the scheduled
    ///job will run at the time specified by the <b>JobTime</b> member, on the corresponding day of the month. Bit 0
    ///corresponds to the first day of the month, and so on. The value of the bitmask is zero if the job was scheduled
    ///to run only once, at the first occurrence specified by the <b>JobTime</b> member.
    uint   DaysOfMonth;
    ///Type: <b>UCHAR</b> A set of bit flags representing the days of the week. For each bit that is set, the scheduled
    ///job will run at the time specified by the <b>JobTime</b> member, on the corresponding day of the week. Bit 0
    ///corresponds to Monday, and so on. The value of the bitmask is zero if the job was scheduled to run only once, at
    ///the first occurrence specified by the <b>JobTime</b> member.
    ubyte  DaysOfWeek;
    ///Type: <b>UCHAR</b> A set of bit flags describing job properties. When you submit a job using a call to the
    ///NetScheduleJobAdd function, you can specify one of the following values. <table> <tr> <th>Value</th>
    ///<th>Meaning</th> </tr> <tr> <td width="40%"><a id="JOB_RUN_PERIODICALLY"></a><a
    ///id="job_run_periodically"></a><dl> <dt><b>JOB_RUN_PERIODICALLY</b></dt> </dl> </td> <td width="60%"> If you set
    ///this flag, the job runs, and continues to run, on each day for which a corresponding bit is set in the
    ///<b>DaysOfMonth</b> member or the <b>DaysOfWeek</b> member. The job is not deleted after it executes. If this flag
    ///is clear, the job runs only once for each bit set in these members. The job is deleted after it executes once.
    ///</td> </tr> <tr> <td width="40%"><a id="JOB_ADD_CURRENT_DATE"></a><a id="job_add_current_date"></a><dl>
    ///<dt><b>JOB_ADD_CURRENT_DATE</b></dt> </dl> </td> <td width="60%"> If you set this flag, the job executes at the
    ///first occurrence of <b>JobTime</b> member at the computer where the job is queued. Setting this flag is
    ///equivalent to setting the bit for the current day in the <b>DaysOfMonth</b> member. </td> </tr> <tr> <td
    ///width="40%"><a id="JOB_NONINTERACTIVE"></a><a id="job_noninteractive"></a><dl> <dt><b>JOB_NONINTERACTIVE</b></dt>
    ///</dl> </td> <td width="60%"> If you set this flag, the job does not run interactively. If this flag is clear, the
    ///job runs interactively. </td> </tr> </table> When you call NetScheduleJobGetInfo to retrieve job information, the
    ///function can return one or more of the following values. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr>
    ///<td width="40%"><a id="JOB_RUN_PERIODICALLY"></a><a id="job_run_periodically"></a><dl>
    ///<dt><b>JOB_RUN_PERIODICALLY</b></dt> </dl> </td> <td width="60%"> This flag is equal to its original value, that
    ///is, the value when the job was submitted. </td> </tr> <tr> <td width="40%"><a id="JOB_EXEC_ERROR"></a><a
    ///id="job_exec_error"></a><dl> <dt><b>JOB_EXEC_ERROR</b></dt> </dl> </td> <td width="60%"> If this flag is set, it
    ///indicates that the schedule service failed to successfully execute the job the last time it was scheduled to run.
    ///</td> </tr> <tr> <td width="40%"><a id="JOB_RUNS_TODAY"></a><a id="job_runs_today"></a><dl>
    ///<dt><b>JOB_RUNS_TODAY</b></dt> </dl> </td> <td width="60%"> If this flag is set, it indicates that the job is
    ///scheduled to execute on the current day; the value of the <b>JobTime</b> member is greater than the current time
    ///of day at the computer where the job is queued. </td> </tr> <tr> <td width="40%"><a
    ///id="JOB_NONINTERACTIVE"></a><a id="job_noninteractive"></a><dl> <dt><b>JOB_NONINTERACTIVE</b></dt> </dl> </td>
    ///<td width="60%"> This flag bit is equal to its original value, that is, the value when the job was submitted.
    ///</td> </tr> </table>
    ubyte  Flags;
    ///Type: <b>LPWSTR</b> A pointer to a Unicode string that contains the name of the command, batch program, or binary
    ///file to execute.
    PWSTR  Command;
}

///The <b>AT_ENUM</b> structure contains information about a submitted job. The NetScheduleJobEnum function uses this
///structure to enumerate and return information about an entire queue of submitted jobs.
struct AT_ENUM
{
    ///Type: <b>DWORD</b> The job identifier of a submitted (queued) job.
    uint   JobId;
    ///Type: <b>DWORD_PTR</b> A pointer to the time of day at which the job is scheduled to run. The time is the local
    ///time at a computer on which the schedule service is running; it is measured from midnight, and is expressed in
    ///milliseconds.
    size_t JobTime;
    ///Type: <b>DWORD</b> A set of bit flags representing the days of the month. For each bit that is set, the scheduled
    ///job will run at the time specified by the <b>JobTime</b> member, on the corresponding day of the month. Bit 0
    ///corresponds to the first day of the month, and so on. The value of the bitmask is zero if the job was scheduled
    ///to run only once, at the first occurrence specified in the <b>JobTime</b> member
    uint   DaysOfMonth;
    ///Type: <b>UCHAR</b> A set of bit flags representing the days of the week. For each bit that is set, the scheduled
    ///job will run at the time specified by the <b>JobTime</b> member, on the corresponding day of the week. Bit 0
    ///corresponds to Monday, and so on. The value of the bitmask is zero if the job was scheduled to run only once, at
    ///the first occurrence specified in the <b>JobTime</b> member.
    ubyte  DaysOfWeek;
    ///Type: <b>UCHAR</b> A set of bit flags describing job properties. This member can be one or more of the following
    ///values. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
    ///id="JOB_RUN_PERIODICALLY"></a><a id="job_run_periodically"></a><dl> <dt><b>JOB_RUN_PERIODICALLY</b></dt> </dl>
    ///</td> <td width="60%"> This flag is equal to its original value, that is, the value when the job was submitted.
    ///</td> </tr> <tr> <td width="40%"><a id="JOB_EXEC_ERROR"></a><a id="job_exec_error"></a><dl>
    ///<dt><b>JOB_EXEC_ERROR</b></dt> </dl> </td> <td width="60%"> If this flag is set, it indicates that the schedule
    ///service failed to successfully execute the job the last time it was scheduled to run. </td> </tr> <tr> <td
    ///width="40%"><a id="JOB_RUNS_TODAY"></a><a id="job_runs_today"></a><dl> <dt><b>JOB_RUNS_TODAY</b></dt> </dl> </td>
    ///<td width="60%"> If this flag is set, it indicates that the job is scheduled to execute on the current day; the
    ///value of the <b>JobTime</b> member is greater than the current time of day at the computer where the job is
    ///queued. </td> </tr> <tr> <td width="40%"><a id="JOB_NONINTERACTIVE"></a><a id="job_noninteractive"></a><dl>
    ///<dt><b>JOB_NONINTERACTIVE</b></dt> </dl> </td> <td width="60%"> This flag is equal to its original value, that
    ///is, the value when the job was submitted. </td> </tr> </table>
    ubyte  Flags;
    ///Type: <b>LPWSTR</b> A pointer to a Unicode string that contains the name of the command, batch program, or binary
    ///file to execute.
    PWSTR  Command;
}

///The <b>SERVER_INFO_100</b> structure contains information about the specified server, including the name and
///platform.
struct SERVER_INFO_100
{
    ///Type: <b>DWORD</b> The information level to use for platform-specific information. Possible values for this
    ///member are listed in the <i>Lmcons.h</i> header file. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td
    ///width="40%"><a id="PLATFORM_ID_DOS"></a><a id="platform_id_dos"></a><dl> <dt><b>PLATFORM_ID_DOS</b></dt>
    ///<dt>300</dt> </dl> </td> <td width="60%"> The MS-DOS platform. </td> </tr> <tr> <td width="40%"><a
    ///id="PLATFORM_ID_OS2"></a><a id="platform_id_os2"></a><dl> <dt><b>PLATFORM_ID_OS2</b></dt> <dt>400</dt> </dl>
    ///</td> <td width="60%"> The OS/2 platform. </td> </tr> <tr> <td width="40%"><a id="PLATFORM_ID_NT"></a><a
    ///id="platform_id_nt"></a><dl> <dt><b>PLATFORM_ID_NT</b></dt> <dt>500</dt> </dl> </td> <td width="60%"> The Windows
    ///NT platform. </td> </tr> <tr> <td width="40%"><a id="PLATFORM_ID_OSF"></a><a id="platform_id_osf"></a><dl>
    ///<dt><b>PLATFORM_ID_OSF</b></dt> <dt>600</dt> </dl> </td> <td width="60%"> The OSF platform. </td> </tr> <tr> <td
    ///width="40%"><a id="PLATFORM_ID_VMS"></a><a id="platform_id_vms"></a><dl> <dt><b>PLATFORM_ID_VMS</b></dt>
    ///<dt>700</dt> </dl> </td> <td width="60%"> The VMS platform. </td> </tr> </table>
    uint  sv100_platform_id;
    ///Type: <b>LPWSTR</b> A pointer to a Unicode string that specifies the name of the server.
    PWSTR sv100_name;
}

///The <b>SERVER_INFO_101</b> structure contains information about the specified server, including name, platform, type
///of server, and associated software.
struct SERVER_INFO_101
{
    ///Type: <b>DWORD</b> The information level to use for platform-specific information. Possible values for this
    ///member are listed in the <i>Lmcons.h</i> header file. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td
    ///width="40%"><a id="PLATFORM_ID_DOS"></a><a id="platform_id_dos"></a><dl> <dt><b>PLATFORM_ID_DOS</b></dt>
    ///<dt>300</dt> </dl> </td> <td width="60%"> The MS-DOS platform. </td> </tr> <tr> <td width="40%"><a
    ///id="PLATFORM_ID_OS2"></a><a id="platform_id_os2"></a><dl> <dt><b>PLATFORM_ID_OS2</b></dt> <dt>400</dt> </dl>
    ///</td> <td width="60%"> The OS/2 platform. </td> </tr> <tr> <td width="40%"><a id="PLATFORM_ID_NT"></a><a
    ///id="platform_id_nt"></a><dl> <dt><b>PLATFORM_ID_NT</b></dt> <dt>500</dt> </dl> </td> <td width="60%"> The Windows
    ///NT platform. </td> </tr> <tr> <td width="40%"><a id="PLATFORM_ID_OSF"></a><a id="platform_id_osf"></a><dl>
    ///<dt><b>PLATFORM_ID_OSF</b></dt> <dt>600</dt> </dl> </td> <td width="60%"> The OSF platform. </td> </tr> <tr> <td
    ///width="40%"><a id="PLATFORM_ID_VMS"></a><a id="platform_id_vms"></a><dl> <dt><b>PLATFORM_ID_VMS</b></dt>
    ///<dt>700</dt> </dl> </td> <td width="60%"> The VMS platform. </td> </tr> </table>
    uint  sv101_platform_id;
    ///Type: <b>LPWSTR</b> A pointer to a Unicode string specifying the name of a server.
    PWSTR sv101_name;
    ///Type: <b>DWORD</b> The major version number and the server type. The major release version number of the
    ///operating system is specified in the least significant 4 bits. The server type is specified in the most
    ///significant 4 bits. The <b>MAJOR_VERSION_MASK</b> bitmask defined in the <i>Lmserver.h</i> header should be used
    ///by an application to obtain the major version number from this member.
    uint  sv101_version_major;
    ///Type: <b>DWORD</b> The minor release version number of the operating system.
    uint  sv101_version_minor;
    ///Type: <b>DWORD</b> The type of software the computer is running. Possible values for this member are listed in
    ///the <i>Lmserver.h</i> header file. This member can be a combination of some of the following values. <table> <tr>
    ///<th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="SV_TYPE_WORKSTATION"></a><a
    ///id="sv_type_workstation"></a><dl> <dt><b>SV_TYPE_WORKSTATION</b></dt> <dt>0x00000001</dt> </dl> </td> <td
    ///width="60%"> A workstation. </td> </tr> <tr> <td width="40%"><a id="SV_TYPE_SERVER"></a><a
    ///id="sv_type_server"></a><dl> <dt><b>SV_TYPE_SERVER</b></dt> <dt>0x00000002</dt> </dl> </td> <td width="60%"> A
    ///server. </td> </tr> <tr> <td width="40%"><a id="SV_TYPE_SQLSERVER"></a><a id="sv_type_sqlserver"></a><dl>
    ///<dt><b>SV_TYPE_SQLSERVER</b></dt> <dt>0x00000004</dt> </dl> </td> <td width="60%"> A server running with
    ///Microsoft SQL Server. </td> </tr> <tr> <td width="40%"><a id="SV_TYPE_DOMAIN_CTRL"></a><a
    ///id="sv_type_domain_ctrl"></a><dl> <dt><b>SV_TYPE_DOMAIN_CTRL</b></dt> <dt>0x00000008</dt> </dl> </td> <td
    ///width="60%"> A primary domain controller. </td> </tr> <tr> <td width="40%"><a id="SV_TYPE_DOMAIN_BAKCTRL"></a><a
    ///id="sv_type_domain_bakctrl"></a><dl> <dt><b>SV_TYPE_DOMAIN_BAKCTRL</b></dt> <dt>0x00000010</dt> </dl> </td> <td
    ///width="60%"> A backup domain controller. </td> </tr> <tr> <td width="40%"><a id="SV_TYPE_TIME_SOURCE"></a><a
    ///id="sv_type_time_source"></a><dl> <dt><b>SV_TYPE_TIME_SOURCE</b></dt> <dt>0x00000020</dt> </dl> </td> <td
    ///width="60%"> A server running the Timesource service. </td> </tr> <tr> <td width="40%"><a id="SV_TYPE_AFP"></a><a
    ///id="sv_type_afp"></a><dl> <dt><b>SV_TYPE_AFP</b></dt> <dt>0x00000040</dt> </dl> </td> <td width="60%"> A server
    ///running the Apple Filing Protocol (AFP) file service. </td> </tr> <tr> <td width="40%"><a
    ///id="SV_TYPE_NOVELL"></a><a id="sv_type_novell"></a><dl> <dt><b>SV_TYPE_NOVELL</b></dt> <dt>0x00000080</dt> </dl>
    ///</td> <td width="60%"> A Novell server. </td> </tr> <tr> <td width="40%"><a id="SV_TYPE_DOMAIN_MEMBER"></a><a
    ///id="sv_type_domain_member"></a><dl> <dt><b>SV_TYPE_DOMAIN_MEMBER</b></dt> <dt>0x00000100</dt> </dl> </td> <td
    ///width="60%"> A LAN Manager 2.x domain member. </td> </tr> <tr> <td width="40%"><a
    ///id="SV_TYPE_PRINTQ_SERVER"></a><a id="sv_type_printq_server"></a><dl> <dt><b>SV_TYPE_PRINTQ_SERVER</b></dt>
    ///<dt>0x00000200</dt> </dl> </td> <td width="60%"> A server that shares a print queue. </td> </tr> <tr> <td
    ///width="40%"><a id="SV_TYPE_DIALIN_SERVER"></a><a id="sv_type_dialin_server"></a><dl>
    ///<dt><b>SV_TYPE_DIALIN_SERVER</b></dt> <dt>0x00000400</dt> </dl> </td> <td width="60%"> A server that runs a
    ///dial-in service. </td> </tr> <tr> <td width="40%"><a id="SV_TYPE_XENIX_SERVER"></a><a
    ///id="sv_type_xenix_server"></a><dl> <dt><b>SV_TYPE_XENIX_SERVER</b></dt> <dt>0x00000800</dt> </dl> </td> <td
    ///width="60%"> A Xenix or Unix server. </td> </tr> <tr> <td width="40%"><a id="SV_TYPE_NT"></a><a
    ///id="sv_type_nt"></a><dl> <dt><b>SV_TYPE_NT</b></dt> <dt>0x00001000</dt> </dl> </td> <td width="60%"> A
    ///workstation or server. </td> </tr> <tr> <td width="40%"><a id="SV_TYPE_WFW"></a><a id="sv_type_wfw"></a><dl>
    ///<dt><b>SV_TYPE_WFW</b></dt> <dt>0x00002000</dt> </dl> </td> <td width="60%"> A computer that runs Windows for
    ///Workgroups. </td> </tr> <tr> <td width="40%"><a id="SV_TYPE_SERVER_MFPN"></a><a id="sv_type_server_mfpn"></a><dl>
    ///<dt><b>SV_TYPE_SERVER_MFPN</b></dt> <dt>0x00004000</dt> </dl> </td> <td width="60%"> A server that runs the
    ///Microsoft File and Print for NetWare service. </td> </tr> <tr> <td width="40%"><a id="SV_TYPE_SERVER_NT"></a><a
    ///id="sv_type_server_nt"></a><dl> <dt><b>SV_TYPE_SERVER_NT</b></dt> <dt>0x00008000</dt> </dl> </td> <td
    ///width="60%"> Any server that is not a domain controller. </td> </tr> <tr> <td width="40%"><a
    ///id="SV_TYPE_POTENTIAL_BROWSER"></a><a id="sv_type_potential_browser"></a><dl>
    ///<dt><b>SV_TYPE_POTENTIAL_BROWSER</b></dt> <dt>0x00010000</dt> </dl> </td> <td width="60%"> A computer that can
    ///run the browser service. </td> </tr> <tr> <td width="40%"><a id="SV_TYPE_BACKUP_BROWSER"></a><a
    ///id="sv_type_backup_browser"></a><dl> <dt><b>SV_TYPE_BACKUP_BROWSER</b></dt> <dt>0x00020000</dt> </dl> </td> <td
    ///width="60%"> A server running a browser service as backup. </td> </tr> <tr> <td width="40%"><a
    ///id="SV_TYPE_MASTER_BROWSER"></a><a id="sv_type_master_browser"></a><dl> <dt><b>SV_TYPE_MASTER_BROWSER</b></dt>
    ///<dt>0x00040000</dt> </dl> </td> <td width="60%"> A server running the master browser service. </td> </tr> <tr>
    ///<td width="40%"><a id="SV_TYPE_DOMAIN_MASTER"></a><a id="sv_type_domain_master"></a><dl>
    ///<dt><b>SV_TYPE_DOMAIN_MASTER</b></dt> <dt>0x00080000</dt> </dl> </td> <td width="60%"> A server running the
    ///domain master browser. </td> </tr> <tr> <td width="40%"><a id="SV_TYPE_SERVER_OSF"></a><a
    ///id="sv_type_server_osf"></a><dl> <dt><b>SV_TYPE_SERVER_OSF</b></dt> <dt>0x00100000</dt> </dl> </td> <td
    ///width="60%"> A computer that runs OSF. </td> </tr> <tr> <td width="40%"><a id="SV_TYPE_SERVER_VMS"></a><a
    ///id="sv_type_server_vms"></a><dl> <dt><b>SV_TYPE_SERVER_VMS</b></dt> <dt>0x00200000</dt> </dl> </td> <td
    ///width="60%"> A computer that runs VMS. </td> </tr> <tr> <td width="40%"><a id="SV_TYPE_WINDOWS"></a><a
    ///id="sv_type_windows"></a><dl> <dt><b>SV_TYPE_WINDOWS</b></dt> <dt>0x00400000</dt> </dl> </td> <td width="60%"> A
    ///computer that runs Windows. </td> </tr> <tr> <td width="40%"><a id="SV_TYPE_DFS"></a><a id="sv_type_dfs"></a><dl>
    ///<dt><b>SV_TYPE_DFS</b></dt> <dt>0x00800000</dt> </dl> </td> <td width="60%"> A server that is the root of a DFS
    ///tree. </td> </tr> <tr> <td width="40%"><a id="SV_TYPE_CLUSTER_NT"></a><a id="sv_type_cluster_nt"></a><dl>
    ///<dt><b>SV_TYPE_CLUSTER_NT</b></dt> <dt>0x01000000</dt> </dl> </td> <td width="60%"> A server cluster available in
    ///the domain. </td> </tr> <tr> <td width="40%"><a id="SV_TYPE_TERMINALSERVER"></a><a
    ///id="sv_type_terminalserver"></a><dl> <dt><b>SV_TYPE_TERMINALSERVER</b></dt> <dt>0x02000000</dt> </dl> </td> <td
    ///width="60%"> A server that runs the Terminal Server service. </td> </tr> <tr> <td width="40%"><a
    ///id="SV_TYPE_CLUSTER_VS_NT"></a><a id="sv_type_cluster_vs_nt"></a><dl> <dt><b>SV_TYPE_CLUSTER_VS_NT</b></dt>
    ///<dt>0x04000000</dt> </dl> </td> <td width="60%"> Cluster virtual servers available in the domain. <b>Windows
    ///2000: </b>This value is not supported. </td> </tr> <tr> <td width="40%"><a id="SV_TYPE_DCE"></a><a
    ///id="sv_type_dce"></a><dl> <dt><b>SV_TYPE_DCE</b></dt> <dt>0x10000000</dt> </dl> </td> <td width="60%"> A server
    ///that runs the DCE Directory and Security Services or equivalent. </td> </tr> <tr> <td width="40%"><a
    ///id="SV_TYPE_ALTERNATE_XPORT"></a><a id="sv_type_alternate_xport"></a><dl> <dt><b>SV_TYPE_ALTERNATE_XPORT</b></dt>
    ///<dt>0x20000000</dt> </dl> </td> <td width="60%"> A server that is returned by an alternate transport. </td> </tr>
    ///<tr> <td width="40%"><a id="SV_TYPE_LOCAL_LIST_ONLY"></a><a id="sv_type_local_list_only"></a><dl>
    ///<dt><b>SV_TYPE_LOCAL_LIST_ONLY</b></dt> <dt>0x40000000</dt> </dl> </td> <td width="60%"> A server that is
    ///maintained by the browser. </td> </tr> <tr> <td width="40%"><a id="SV_TYPE_DOMAIN_ENUM"></a><a
    ///id="sv_type_domain_enum"></a><dl> <dt><b>SV_TYPE_DOMAIN_ENUM</b></dt> <dt>0x80000000</dt> </dl> </td> <td
    ///width="60%"> A primary domain. </td> </tr> </table> The <b>SV_TYPE_ALL</b> constant is defined to 0xFFFFFFFF in
    ///the <i>Lmserver.h</i> header file. This constant can be used to check for all server types when used with the
    ///NetServerEnumfunction.
    uint  sv101_type;
    ///Type: <b>LPWSTR</b> A pointer to a Unicode string specifying a comment describing the server. The comment can be
    ///null.
    PWSTR sv101_comment;
}

///The <b>SERVER_INFO_102</b> structure contains information about the specified server, including name, platform, type
///of server, attributes, and associated software.
struct SERVER_INFO_102
{
    ///Type: <b>DWORD</b> The information level to use for platform-specific information. Possible values for this
    ///member are listed in the <i>Lmcons.h</i> header file. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td
    ///width="40%"><a id="PLATFORM_ID_DOS"></a><a id="platform_id_dos"></a><dl> <dt><b>PLATFORM_ID_DOS</b></dt>
    ///<dt>300</dt> </dl> </td> <td width="60%"> The MS-DOS platform. </td> </tr> <tr> <td width="40%"><a
    ///id="PLATFORM_ID_OS2"></a><a id="platform_id_os2"></a><dl> <dt><b>PLATFORM_ID_OS2</b></dt> <dt>400</dt> </dl>
    ///</td> <td width="60%"> The OS/2 platform. </td> </tr> <tr> <td width="40%"><a id="PLATFORM_ID_NT"></a><a
    ///id="platform_id_nt"></a><dl> <dt><b>PLATFORM_ID_NT</b></dt> <dt>500</dt> </dl> </td> <td width="60%"> The Windows
    ///NT platform. </td> </tr> <tr> <td width="40%"><a id="PLATFORM_ID_OSF"></a><a id="platform_id_osf"></a><dl>
    ///<dt><b>PLATFORM_ID_OSF</b></dt> <dt>600</dt> </dl> </td> <td width="60%"> The OSF platform. </td> </tr> <tr> <td
    ///width="40%"><a id="PLATFORM_ID_VMS"></a><a id="platform_id_vms"></a><dl> <dt><b>PLATFORM_ID_VMS</b></dt>
    ///<dt>700</dt> </dl> </td> <td width="60%"> The VMS platform. </td> </tr> </table>
    uint  sv102_platform_id;
    ///Type: <b>LPWSTR</b> A pointer to a Unicode string specifying the name of a server.
    PWSTR sv102_name;
    ///Type: <b>DWORD</b> The major version number and the server type. The major release version number of the
    ///operating system is specified in the least significant 4 bits. The server type is specified in the most
    ///significant 4 bits. The <b>MAJOR_VERSION_MASK</b> bitmask defined in the <i>Lmserver.h</i> header should be used
    ///by an application to obtain the major version number from this member.
    uint  sv102_version_major;
    ///Type: <b>DWORD</b> The minor release version number of the operating system.
    uint  sv102_version_minor;
    ///Type: <b>DWORD</b> The type of software the computer is running. Possible values for this member are listed in
    ///the <i>Lmserver.h</i> header file. This member can be a combination of some of the following values. <table> <tr>
    ///<th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="SV_TYPE_WORKSTATION"></a><a
    ///id="sv_type_workstation"></a><dl> <dt><b>SV_TYPE_WORKSTATION</b></dt> <dt>0x00000001</dt> </dl> </td> <td
    ///width="60%"> A workstation. </td> </tr> <tr> <td width="40%"><a id="SV_TYPE_SERVER"></a><a
    ///id="sv_type_server"></a><dl> <dt><b>SV_TYPE_SERVER</b></dt> <dt>0x00000002</dt> </dl> </td> <td width="60%"> A
    ///server. </td> </tr> <tr> <td width="40%"><a id="SV_TYPE_SQLSERVER"></a><a id="sv_type_sqlserver"></a><dl>
    ///<dt><b>SV_TYPE_SQLSERVER</b></dt> <dt>0x00000004</dt> </dl> </td> <td width="60%"> A server running with
    ///Microsoft SQL Server. </td> </tr> <tr> <td width="40%"><a id="SV_TYPE_DOMAIN_CTRL"></a><a
    ///id="sv_type_domain_ctrl"></a><dl> <dt><b>SV_TYPE_DOMAIN_CTRL</b></dt> <dt>0x00000008</dt> </dl> </td> <td
    ///width="60%"> A primary domain controller. </td> </tr> <tr> <td width="40%"><a id="SV_TYPE_DOMAIN_BAKCTRL"></a><a
    ///id="sv_type_domain_bakctrl"></a><dl> <dt><b>SV_TYPE_DOMAIN_BAKCTRL</b></dt> <dt>0x00000010</dt> </dl> </td> <td
    ///width="60%"> A backup domain controller. </td> </tr> <tr> <td width="40%"><a id="SV_TYPE_TIME_SOURCE"></a><a
    ///id="sv_type_time_source"></a><dl> <dt><b>SV_TYPE_TIME_SOURCE</b></dt> <dt>0x00000020</dt> </dl> </td> <td
    ///width="60%"> A server running the Timesource service. </td> </tr> <tr> <td width="40%"><a id="SV_TYPE_AFP"></a><a
    ///id="sv_type_afp"></a><dl> <dt><b>SV_TYPE_AFP</b></dt> <dt>0x00000040</dt> </dl> </td> <td width="60%"> A server
    ///running the Apple Filing Protocol (AFP) file service. </td> </tr> <tr> <td width="40%"><a
    ///id="SV_TYPE_NOVELL"></a><a id="sv_type_novell"></a><dl> <dt><b>SV_TYPE_NOVELL</b></dt> <dt>0x00000080</dt> </dl>
    ///</td> <td width="60%"> A Novell server. </td> </tr> <tr> <td width="40%"><a id="SV_TYPE_DOMAIN_MEMBER"></a><a
    ///id="sv_type_domain_member"></a><dl> <dt><b>SV_TYPE_DOMAIN_MEMBER</b></dt> <dt>0x00000100</dt> </dl> </td> <td
    ///width="60%"> A LAN Manager 2.x domain member. </td> </tr> <tr> <td width="40%"><a
    ///id="SV_TYPE_PRINTQ_SERVER"></a><a id="sv_type_printq_server"></a><dl> <dt><b>SV_TYPE_PRINTQ_SERVER</b></dt>
    ///<dt>0x00000200</dt> </dl> </td> <td width="60%"> A server that shares a print queue. </td> </tr> <tr> <td
    ///width="40%"><a id="SV_TYPE_DIALIN_SERVER"></a><a id="sv_type_dialin_server"></a><dl>
    ///<dt><b>SV_TYPE_DIALIN_SERVER</b></dt> <dt>0x00000400</dt> </dl> </td> <td width="60%"> A server that runs a
    ///dial-in service. </td> </tr> <tr> <td width="40%"><a id="SV_TYPE_XENIX_SERVER"></a><a
    ///id="sv_type_xenix_server"></a><dl> <dt><b>SV_TYPE_XENIX_SERVER</b></dt> <dt>0x00000800</dt> </dl> </td> <td
    ///width="60%"> A Xenix or Unix server. </td> </tr> <tr> <td width="40%"><a id="SV_TYPE_NT"></a><a
    ///id="sv_type_nt"></a><dl> <dt><b>SV_TYPE_NT</b></dt> <dt>0x00001000</dt> </dl> </td> <td width="60%"> A
    ///workstation or server. </td> </tr> <tr> <td width="40%"><a id="SV_TYPE_WFW"></a><a id="sv_type_wfw"></a><dl>
    ///<dt><b>SV_TYPE_WFW</b></dt> <dt>0x00002000</dt> </dl> </td> <td width="60%"> A computer that runs Windows for
    ///Workgroups. </td> </tr> <tr> <td width="40%"><a id="SV_TYPE_SERVER_MFPN"></a><a id="sv_type_server_mfpn"></a><dl>
    ///<dt><b>SV_TYPE_SERVER_MFPN</b></dt> <dt>0x00004000</dt> </dl> </td> <td width="60%"> A server that runs the
    ///Microsoft File and Print for NetWare service. </td> </tr> <tr> <td width="40%"><a id="SV_TYPE_SERVER_NT"></a><a
    ///id="sv_type_server_nt"></a><dl> <dt><b>SV_TYPE_SERVER_NT</b></dt> <dt>0x00008000</dt> </dl> </td> <td
    ///width="60%"> Any server that is not a domain controller. </td> </tr> <tr> <td width="40%"><a
    ///id="SV_TYPE_POTENTIAL_BROWSER"></a><a id="sv_type_potential_browser"></a><dl>
    ///<dt><b>SV_TYPE_POTENTIAL_BROWSER</b></dt> <dt>0x00010000</dt> </dl> </td> <td width="60%"> A computer that can
    ///run the browser service. </td> </tr> <tr> <td width="40%"><a id="SV_TYPE_BACKUP_BROWSER"></a><a
    ///id="sv_type_backup_browser"></a><dl> <dt><b>SV_TYPE_BACKUP_BROWSER</b></dt> <dt>0x00020000</dt> </dl> </td> <td
    ///width="60%"> A server running a browser service as backup. </td> </tr> <tr> <td width="40%"><a
    ///id="SV_TYPE_MASTER_BROWSER"></a><a id="sv_type_master_browser"></a><dl> <dt><b>SV_TYPE_MASTER_BROWSER</b></dt>
    ///<dt>0x00040000</dt> </dl> </td> <td width="60%"> A server running the master browser service. </td> </tr> <tr>
    ///<td width="40%"><a id="SV_TYPE_DOMAIN_MASTER"></a><a id="sv_type_domain_master"></a><dl>
    ///<dt><b>SV_TYPE_DOMAIN_MASTER</b></dt> <dt>0x00080000</dt> </dl> </td> <td width="60%"> A server running the
    ///domain master browser. </td> </tr> <tr> <td width="40%"><a id="SV_TYPE_SERVER_OSF"></a><a
    ///id="sv_type_server_osf"></a><dl> <dt><b>SV_TYPE_SERVER_OSF</b></dt> <dt>0x00100000</dt> </dl> </td> <td
    ///width="60%"> A computer that runs OSF. </td> </tr> <tr> <td width="40%"><a id="SV_TYPE_SERVER_VMS"></a><a
    ///id="sv_type_server_vms"></a><dl> <dt><b>SV_TYPE_SERVER_VMS</b></dt> <dt>0x00200000</dt> </dl> </td> <td
    ///width="60%"> A computer that runs VMS. </td> </tr> <tr> <td width="40%"><a id="SV_TYPE_WINDOWS"></a><a
    ///id="sv_type_windows"></a><dl> <dt><b>SV_TYPE_WINDOWS</b></dt> <dt>0x00400000</dt> </dl> </td> <td width="60%"> A
    ///computer that runs Windows. </td> </tr> <tr> <td width="40%"><a id="SV_TYPE_DFS"></a><a id="sv_type_dfs"></a><dl>
    ///<dt><b>SV_TYPE_DFS</b></dt> <dt>0x00800000</dt> </dl> </td> <td width="60%"> A server that is the root of a DFS
    ///tree. </td> </tr> <tr> <td width="40%"><a id="SV_TYPE_CLUSTER_NT"></a><a id="sv_type_cluster_nt"></a><dl>
    ///<dt><b>SV_TYPE_CLUSTER_NT</b></dt> <dt>0x01000000</dt> </dl> </td> <td width="60%"> A server cluster available in
    ///the domain. </td> </tr> <tr> <td width="40%"><a id="SV_TYPE_TERMINALSERVER"></a><a
    ///id="sv_type_terminalserver"></a><dl> <dt><b>SV_TYPE_TERMINALSERVER</b></dt> <dt>0x02000000</dt> </dl> </td> <td
    ///width="60%"> A server that runs the Terminal Server service. </td> </tr> <tr> <td width="40%"><a
    ///id="SV_TYPE_CLUSTER_VS_NT"></a><a id="sv_type_cluster_vs_nt"></a><dl> <dt><b>SV_TYPE_CLUSTER_VS_NT</b></dt>
    ///<dt>0x04000000</dt> </dl> </td> <td width="60%"> Cluster virtual servers available in the domain. <b>Windows
    ///2000: </b>This value is not supported. </td> </tr> <tr> <td width="40%"><a id="SV_TYPE_DCE"></a><a
    ///id="sv_type_dce"></a><dl> <dt><b>SV_TYPE_DCE</b></dt> <dt>0x10000000</dt> </dl> </td> <td width="60%"> A server
    ///that runs the DCE Directory and Security Services or equivalent. </td> </tr> <tr> <td width="40%"><a
    ///id="SV_TYPE_ALTERNATE_XPORT"></a><a id="sv_type_alternate_xport"></a><dl> <dt><b>SV_TYPE_ALTERNATE_XPORT</b></dt>
    ///<dt>0x20000000</dt> </dl> </td> <td width="60%"> A server that is returned by an alternate transport. </td> </tr>
    ///<tr> <td width="40%"><a id="SV_TYPE_LOCAL_LIST_ONLY"></a><a id="sv_type_local_list_only"></a><dl>
    ///<dt><b>SV_TYPE_LOCAL_LIST_ONLY</b></dt> <dt>0x40000000</dt> </dl> </td> <td width="60%"> A server that is
    ///maintained by the browser. </td> </tr> <tr> <td width="40%"><a id="SV_TYPE_DOMAIN_ENUM"></a><a
    ///id="sv_type_domain_enum"></a><dl> <dt><b>SV_TYPE_DOMAIN_ENUM</b></dt> <dt>0x80000000</dt> </dl> </td> <td
    ///width="60%"> A primary domain. </td> </tr> </table> The <b>SV_TYPE_ALL</b> constant is defined to 0xFFFFFFFF in
    ///the <i>Lmserver.h</i> header file. This constant can be used to check for all server types when used with the
    ///NetServerEnumfunction.
    uint  sv102_type;
    ///Type: <b>LPWSTR</b> A pointer to a Unicode string specifying a comment describing the server. The comment can be
    ///null.
    PWSTR sv102_comment;
    ///Type: <b>DWORD</b> The number of users who can attempt to log on to the system server. Note that it is the
    ///license server that determines how many of these users can actually log on.
    uint  sv102_users;
    ///Type: <b>LONG</b> The auto-disconnect time, in minutes. A session is disconnected if it is idle longer than the
    ///period of time specified by the <b>sv102_disc</b> member. If the value of <b>sv102_disc</b> is SV_NODISC,
    ///auto-disconnect is not enabled.
    int   sv102_disc;
    ///Type: <b>BOOL</b> A value that indicates whether the server is visible to other computers in the same network
    ///domain. This member can be one of the following values defined in the <i>Lmserver.h</i> header file. <table> <tr>
    ///<th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="SV_VISIBLE"></a><a id="sv_visible"></a><dl>
    ///<dt><b>SV_VISIBLE</b></dt> </dl> </td> <td width="60%"> The server is visible. </td> </tr> <tr> <td
    ///width="40%"><a id="SV_HIDDEN"></a><a id="sv_hidden"></a><dl> <dt><b>SV_HIDDEN</b></dt> </dl> </td> <td
    ///width="60%"> The server is not visible. </td> </tr> </table>
    BOOL  sv102_hidden;
    ///Type: <b>DWORD</b> The network announce rate, in seconds. This rate determines how often the server is announced
    ///to other computers on the network. For more information about how much the announce rate can vary from the period
    ///of time specified by this member, see SERVER_INFO_1018.
    uint  sv102_announce;
    ///Type: <b>DWORD</b> The delta value for the announce rate, in milliseconds. This value specifies how much the
    ///announce rate can vary from the period of time specified in the <b>sv102_announce</b> member. The delta value
    ///allows randomly varied announce rates. For example, if the <b>sv102_announce</b> member has the value 10 and the
    ///<b>sv102_anndelta</b> member has the value 1, the announce rate can vary from 9.999 seconds to 10.001 seconds.
    uint  sv102_anndelta;
    ///Type: <b>DWORD</b> The number of users per license. By default, this number is SV_USERS_PER_LICENSE.
    uint  sv102_licenses;
    ///Type: <b>LPWSTR</b> A pointer to a Unicode string specifying the path to user directories.
    PWSTR sv102_userpath;
}

struct SERVER_INFO_103
{
    uint  sv103_platform_id;
    PWSTR sv103_name;
    uint  sv103_version_major;
    uint  sv103_version_minor;
    uint  sv103_type;
    PWSTR sv103_comment;
    uint  sv103_users;
    int   sv103_disc;
    BOOL  sv103_hidden;
    uint  sv103_announce;
    uint  sv103_anndelta;
    uint  sv103_licenses;
    PWSTR sv103_userpath;
    uint  sv103_capabilities;
}

///The <b>SERVER_INFO_402</b> structure contains information about a specified server.
struct SERVER_INFO_402
{
    ///Type: <b>DWORD</b> The last time the user list was modified. The value is expressed as the number of seconds that
    ///have elapsed since 00:00:00, January 1, 1970, GMT, and applies to servers running with user-level security.
    uint  sv402_ulist_mtime;
    ///Type: <b>DWORD</b> The last time the group list was modified. The value is expressed as the number of seconds
    ///that have elapsed since 00:00:00, January 1, 1970, GMT, and applies to servers running with user-level security.
    uint  sv402_glist_mtime;
    ///Type: <b>DWORD</b> The last time the access control list was modified. The value is expressed as the number of
    ///seconds that have elapsed since 00:00:00, January 1, 1970, GMT, and applies to servers running with user-level
    ///security.
    uint  sv402_alist_mtime;
    ///Type: <b>LPWSTR</b> A pointer to a Unicode string that specifies the list of user names on the server. Spaces
    ///separate the names.
    PWSTR sv402_alerts;
    ///Type: <b>DWORD</b> The security type of the server. This member can be one of the following values. Note that
    ///Windows NT, Windows 2000, Windows XP, and Windows Server 2003 operating systems do not support share-level
    ///security. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="SV_SHARESECURITY"></a><a
    ///id="sv_sharesecurity"></a><dl> <dt><b>SV_SHARESECURITY</b></dt> </dl> </td> <td width="60%"> Share-level security
    ///</td> </tr> <tr> <td width="40%"><a id="SV_USERSECURITY"></a><a id="sv_usersecurity"></a><dl>
    ///<dt><b>SV_USERSECURITY</b></dt> </dl> </td> <td width="60%"> User-level security </td> </tr> </table>
    uint  sv402_security;
    ///Type: <b>DWORD</b> The number of administrators the server can accommodate at one time.
    uint  sv402_numadmin;
    ///Type: <b>DWORD</b> The order in which the network device drivers are served.
    uint  sv402_lanmask;
    ///Type: <b>LPWSTR</b> A pointer to a Unicode string that specifies the name of a reserved account for guest users
    ///on the server. The constant UNLEN specifies the maximum number of characters in the string.
    PWSTR sv402_guestacct;
    ///Type: <b>DWORD</b> The number of character-oriented devices that can be shared on the server.
    uint  sv402_chdevs;
    ///Type: <b>DWORD</b> The number of character-oriented device queues that can coexist on the server.
    uint  sv402_chdevq;
    ///Type: <b>DWORD</b> The number of character-oriented device jobs that can be pending at one time on the server.
    uint  sv402_chdevjobs;
    ///Type: <b>DWORD</b> The number of connections allowed on the server.
    uint  sv402_connections;
    ///Type: <b>DWORD</b> The number of share names the server can accommodate.
    uint  sv402_shares;
    ///Type: <b>DWORD</b> The number of files that can be open at once on the server.
    uint  sv402_openfiles;
    ///Type: <b>DWORD</b> The number of files that one session can open.
    uint  sv402_sessopens;
    ///Type: <b>DWORD</b> The maximum number of virtual circuits permitted per client.
    uint  sv402_sessvcs;
    ///Type: <b>DWORD</b> The number of simultaneous requests a client can make on a single virtual circuit.
    uint  sv402_sessreqs;
    ///Type: <b>DWORD</b> The number of search operations that can be carried out simultaneously.
    uint  sv402_opensearch;
    ///Type: <b>DWORD</b> The number of file locks that can be active at the same time.
    uint  sv402_activelocks;
    ///Type: <b>DWORD</b> The number of server buffers provided.
    uint  sv402_numreqbuf;
    ///Type: <b>DWORD</b> The size, in bytes, of each server buffer.
    uint  sv402_sizreqbuf;
    ///Type: <b>DWORD</b> The number of 64K server buffers provided.
    uint  sv402_numbigbuf;
    ///Type: <b>DWORD</b> The number of processes that can access the operating system at one time.
    uint  sv402_numfiletasks;
    ///Type: <b>DWORD</b> The interval, in seconds, for notifying an administrator of a network event.
    uint  sv402_alertsched;
    ///Type: <b>DWORD</b> The number of entries that can be written to the error log, in any one interval, before
    ///notifying an administrator. The interval is specified by the <b>sv402_alertsched</b> member.
    uint  sv402_erroralert;
    ///Type: <b>DWORD</b> The number of invalid logon attempts to allow a user before notifying an administrator.
    uint  sv402_logonalert;
    ///Type: <b>DWORD</b> The number of invalid file access attempts to allow before notifying an administrator.
    uint  sv402_accessalert;
    ///Type: <b>DWORD</b> The point at which the system sends a message notifying an administrator that free space on a
    ///disk is low. This value is expressed as the number of kilobytes of free disk space remaining on the disk.
    uint  sv402_diskalert;
    ///Type: <b>DWORD</b> The network I/O error ratio, in tenths of a percent, that is allowed before notifying an
    ///administrator.
    uint  sv402_netioalert;
    ///Type: <b>DWORD</b> The maximum size, in kilobytes, of the audit file. The audit file traces user activity.
    uint  sv402_maxauditsz;
    ///Type: <b>LPWSTR</b> A pointer to a Unicode string containing flags that control operations on a server.
    PWSTR sv402_srvheuristics;
}

///The <b>SERVER_INFO_403</b> structure contains information about a specified server.
struct SERVER_INFO_403
{
    ///Type: <b>DWORD</b> The last time the user list was modified. The value is expressed as the number of seconds that
    ///have elapsed since 00:00:00, January 1, 1970, GMT, and applies to servers running with user-level security.
    uint  sv403_ulist_mtime;
    ///Type: <b>DWORD</b> The last time the group list was modified. The value is expressed as the number of seconds
    ///that have elapsed since 00:00:00, January 1, 1970, GMT, and applies to servers running with user-level security.
    uint  sv403_glist_mtime;
    ///Type: <b>DWORD</b> The last time the access control list was modified. The value is expressed as the number of
    ///seconds that have elapsed since 00:00:00, January 1, 1970, GMT, and applies to servers running with user-level
    ///security.
    uint  sv403_alist_mtime;
    ///Type: <b>LMSTR</b> A pointer to a string that specifies the list of user names on the server. Spaces separate the
    ///names. This string is Unicode if <b>_WIN32_WINNT</b> or <b>FORCE_UNICODE</b> are defined.
    PWSTR sv403_alerts;
    ///Type: <b>DWORD</b> The security type of the server. This member can be one of the following values. Note that
    ///Windows NT, Windows 2000, Windows XP, and Windows Server 2003 operating systems do not support share-level
    ///security. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="SV_SHARESECURITY"></a><a
    ///id="sv_sharesecurity"></a><dl> <dt><b>SV_SHARESECURITY</b></dt> </dl> </td> <td width="60%"> Share-level security
    ///</td> </tr> <tr> <td width="40%"><a id="SV_USERSECURITY"></a><a id="sv_usersecurity"></a><dl>
    ///<dt><b>SV_USERSECURITY</b></dt> </dl> </td> <td width="60%"> User-level security </td> </tr> </table>
    uint  sv403_security;
    ///Type: <b>DWORD</b> The number of administrators the server can accommodate at one time.
    uint  sv403_numadmin;
    ///Type: <b>DWORD</b> The order in which the network device drivers are served.
    uint  sv403_lanmask;
    ///Type: <b>LPWSTR</b> A pointer to a Unicode string that specifies the name of a reserved account for guest users
    ///on the server. The UNLEN constant specifies the maximum number of characters in the string.
    PWSTR sv403_guestacct;
    ///Type: <b>DWORD</b> The number of character devices that can be shared on the server.
    uint  sv403_chdevs;
    ///Type: <b>DWORD</b> The number of character device queues that can coexist on the server.
    uint  sv403_chdevq;
    ///Type: <b>DWORD</b> The number of character device jobs that can be pending at one time on the server.
    uint  sv403_chdevjobs;
    ///Type: <b>DWORD</b> The number of connections allowed on the server.
    uint  sv403_connections;
    ///Type: <b>DWORD</b> The number of share names the server can accommodate.
    uint  sv403_shares;
    ///Type: <b>DWORD</b> The number of files that can be open at once on the server.
    uint  sv403_openfiles;
    ///Type: <b>DWORD</b> The number of files that one session can open.
    uint  sv403_sessopens;
    ///Type: <b>DWORD</b> The maximum number of virtual circuits permitted per client.
    uint  sv403_sessvcs;
    ///Type: <b>DWORD</b> The number of simultaneous requests a client can make on a single virtual circuit.
    uint  sv403_sessreqs;
    ///Type: <b>DWORD</b> The number of search operations that can be carried out simultaneously.
    uint  sv403_opensearch;
    ///Type: <b>DWORD</b> The number of file locks that can be active at the same time.
    uint  sv403_activelocks;
    ///Type: <b>DWORD</b> The number of server buffers that are provided.
    uint  sv403_numreqbuf;
    ///Type: <b>DWORD</b> The size, in bytes, of each server buffer.
    uint  sv403_sizreqbuf;
    ///Type: <b>DWORD</b> The number of 64K server buffers provided.
    uint  sv403_numbigbuf;
    ///Type: <b>DWORD</b> The number of processes that can access the operating system at the same time.
    uint  sv403_numfiletasks;
    ///Type: <b>DWORD</b> The alert interval, in seconds, for notifying an administrator of a network event.
    uint  sv403_alertsched;
    ///Type: <b>DWORD</b> The number of entries that can be written to the error log, in any one interval, before
    ///notifying an administrator. The interval is specified by the <b>sv403_alertsched</b> member.
    uint  sv403_erroralert;
    ///Type: <b>DWORD</b> The number of invalid attempts that a user tries to logon before notifying an administrator.
    uint  sv403_logonalert;
    ///Type: <b>DWORD</b> The number of invalid file access attempts to allow before notifying an administrator.
    uint  sv403_accessalert;
    ///Type: <b>DWORD</b> The amount of free disk space at which the system sends a message notifying an administrator
    ///that free space on a disk is low. This value is expressed as the number of kilobytes of free disk space remaining
    ///on the disk.
    uint  sv403_diskalert;
    ///Type: <b>DWORD</b> The network I/O error ratio, in tenths of a percent, that is allowed before notifying an
    ///administrator.
    uint  sv403_netioalert;
    ///Type: <b>DWORD</b> The maximum audit file size in kilobytes. The audit file traces user activity.
    uint  sv403_maxauditsz;
    ///Type: <b>LPWSTR</b> A pointer to a Unicode string that contains flags that are used to control operations on a
    ///server.
    PWSTR sv403_srvheuristics;
    ///Type: <b>DWORD</b> The audit event control mask.
    uint  sv403_auditedevents;
    ///Type: <b>DWORD</b> A value that controls the action of the server on the profile. The following values are
    ///predefined. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
    ///id="SW_AUTOPROF_LOAD_MASK"></a><a id="sw_autoprof_load_mask"></a><dl> <dt><b>SW_AUTOPROF_LOAD_MASK</b></dt> </dl>
    ///</td> <td width="60%"> The server loads the profile. </td> </tr> <tr> <td width="40%"><a
    ///id="SW_AUTOPROF_SAVE_MASK"></a><a id="sw_autoprof_save_mask"></a><dl> <dt><b>SW_AUTOPROF_SAVE_MASK</b></dt> </dl>
    ///</td> <td width="60%"> The server saves the profile. </td> </tr> </table>
    uint  sv403_autoprofile;
    ///Type: <b>LPWSTR</b> A pointer to a Unicode string that contains the path for the profile.
    PWSTR sv403_autopath;
}

///The <b>SERVER_INFO_502</b> structure is obsolete. The structure contains information about a specified server.
struct SERVER_INFO_502
{
    ///Type: <b>DWORD</b> The number of files that can be open in one session.
    uint sv502_sessopens;
    ///Type: <b>DWORD</b> T he maximum number of virtual circuits permitted per client.
    uint sv502_sessvcs;
    ///Type: <b>DWORD</b> The number of search operations that can be carried out simultaneously.
    uint sv502_opensearch;
    ///Type: <b>DWORD</b> The size, in bytes, of each server buffer.
    uint sv502_sizreqbuf;
    ///Type: <b>DWORD</b> The initial number of receive buffers, or work items, used by the server.
    uint sv502_initworkitems;
    ///Type: <b>DWORD</b> The maximum number of receive buffers, or work items, the server can allocate. If this limit
    ///is reached, the transport must initiate flow control at a significant performance cost.
    uint sv502_maxworkitems;
    ///Type: <b>DWORD</b> The number of special work items the server uses for raw mode I/O. A large value for this
    ///member can increase performance, but it requires more memory.
    uint sv502_rawworkitems;
    ///Type: <b>DWORD</b> The number of stack locations that the server allocated in I/O request packets (IRPs).
    uint sv502_irpstacksize;
    ///Type: <b>DWORD</b> The maximum raw mode buffer size, in bytes.
    uint sv502_maxrawbuflen;
    ///Type: <b>DWORD</b> The maximum number of users that can be logged on to the server using a single virtual
    ///circuit.
    uint sv502_sessusers;
    ///Type: <b>DWORD</b> The maximum number of tree connections that can be made on the server using a single virtual
    ///circuit.
    uint sv502_sessconns;
    ///Type: <b>DWORD</b> The maximum size, in bytes, of pageable memory that the server can allocate at any one time.
    uint sv502_maxpagedmemoryusage;
    ///Type: <b>DWORD</b> The maximum size, in bytes, of nonpaged memory that the server can allocate at any one time.
    uint sv502_maxnonpagedmemoryusage;
    ///Type: <b>BOOL</b> A value that indicates whether the server maps a request to a normal open request with
    ///shared-read access when the server receives a compatibility open request with read access. Mapping such requests
    ///allows several MS-DOS computers to open a single file for read access.
    BOOL sv502_enablesoftcompat;
    ///Type: <b>BOOL</b> A value that indicates whether the server should force a client to disconnect, even if the
    ///client has open files, once the client's logon time has expired.
    BOOL sv502_enableforcedlogoff;
    ///Type: <b>BOOL</b> A value that indicates whether the server is a reliable time source.
    BOOL sv502_timesource;
    ///Type: <b>BOOL</b> A value that indicates whether the server accepts function calls from previous-generation LAN
    ///Manager clients.
    BOOL sv502_acceptdownlevelapis;
    ///Type: <b>BOOL</b> A value that indicates whether the server is visible to LAN Manager 2.x clients.
    BOOL sv502_lmannounce;
}

///The <b>SERVER_INFO_503</b> structure is obsolete. The structure contains information about the specified server.
struct SERVER_INFO_503
{
    ///Type: <b>DWORD</b> The number of files that can be open in one session.
    uint  sv503_sessopens;
    ///Type: <b>DWORD</b> The maximum number of sessions or virtual circuits permitted per client.
    uint  sv503_sessvcs;
    ///Type: <b>DWORD</b> The number of search operations that can be carried out simultaneously.
    uint  sv503_opensearch;
    ///Type: <b>DWORD</b> The size, in bytes, of each server buffer.
    uint  sv503_sizreqbuf;
    ///Type: <b>DWORD</b> The initial number of receive buffers, or work items, used by the server.
    uint  sv503_initworkitems;
    ///Type: <b>DWORD</b> The maximum number of receive buffers, or work items, the server can allocate. If this limit
    ///is reached, the transport must initiate flow control at a significant performance cost.
    uint  sv503_maxworkitems;
    ///Type: <b>DWORD</b> The number of special work items the server uses for raw mode I/O. A larger value for this
    ///member can increase performance but it requires more memory.
    uint  sv503_rawworkitems;
    ///Type: <b>DWORD</b> The number of stack locations that the server allocated in I/O request packets (IRPs).
    uint  sv503_irpstacksize;
    ///Type: <b>DWORD</b> The maximum raw mode buffer size, in bytes.
    uint  sv503_maxrawbuflen;
    ///Type: <b>DWORD</b> The maximum number of users that can be logged on to the server using a single session or
    ///virtual circuit.
    uint  sv503_sessusers;
    ///Type: <b>DWORD</b> The maximum number of tree connections that can be made on the server using a single session
    ///or virtual circuit.
    uint  sv503_sessconns;
    ///Type: <b>DWORD</b> The maximum size, in bytes, of pageable memory that the server can allocate at any one time.
    uint  sv503_maxpagedmemoryusage;
    uint  sv503_maxnonpagedmemoryusage;
    ///Type: <b>BOOL</b> A value that indicates whether the server maps a request to a normal open request with
    ///shared-read access when the server receives a compatibility open request with read access. Mapping such requests
    ///allows several MS-DOS computers to open a single file for read access. This member is unused.
    BOOL  sv503_enablesoftcompat;
    ///Type: <b>BOOL</b> A value that indicates whether the server should force a client to disconnect, even if the
    ///client has open files, once the client's logon time has expired.
    BOOL  sv503_enableforcedlogoff;
    ///Type: <b>BOOL</b> A value that indicates whether the server is a reliable time source.
    BOOL  sv503_timesource;
    ///Type: <b>BOOL</b> A value that indicates whether the server accepts function calls from previous-generation LAN
    ///Manager clients.
    BOOL  sv503_acceptdownlevelapis;
    ///Type: <b>BOOL</b> A value that indicates whether the server is visible to LAN Manager 2.x clients.
    BOOL  sv503_lmannounce;
    ///Type: <b>LPWSTR</b> A pointer to a Unicode character string that specifies the name of the server's domain.
    PWSTR sv503_domain;
    ///Type: <b>DWORD</b> The maximum length, in bytes, of copy reads on the server. This member is unused.
    uint  sv503_maxcopyreadlen;
    ///Type: <b>DWORD</b> The maximum length, in bytes, of copy writes on the server. This member is unused.
    uint  sv503_maxcopywritelen;
    ///Type: <b>DWORD</b> The minimum length of time the server retains information about incomplete search operations.
    ///This member is unused.
    uint  sv503_minkeepsearch;
    ///Type: <b>DWORD</b> The maximum length of time, in seconds, the server retains information about incomplete search
    ///operations.
    uint  sv503_maxkeepsearch;
    ///Type: <b>DWORD</b> The minimum length of time, in seconds, the server retains information about complete search
    ///operations. This member is unused.
    uint  sv503_minkeepcomplsearch;
    ///Type: <b>DWORD</b> The maximum length of time, in seconds, the server retains information about complete search
    ///operations. This member is unused.
    uint  sv503_maxkeepcomplsearch;
    ///Type: <b>DWORD</b> The number of additional threads the server should use in addition to one worker thread per
    ///processor it already uses. This member is unused.
    uint  sv503_threadcountadd;
    ///Type: <b>DWORD</b> The number of threads set aside by the server to service requests that can block the thread
    ///for a significant amount of time. This member is unused.
    uint  sv503_numblockthreads;
    ///Type: <b>DWORD</b> The period of time, in seconds, that the scavenger remains idle before waking up to service
    ///requests.
    uint  sv503_scavtimeout;
    ///Type: <b>DWORD</b> The minimum number of free receive work items the server requires before it begins to allocate
    ///more.
    uint  sv503_minrcvqueue;
    ///Type: <b>DWORD</b> The minimum number of available receive work items that the server requires to begin
    ///processing a server message block.
    uint  sv503_minfreeworkitems;
    ///Type: <b>DWORD</b> The size, in bytes, of the shared memory region used to process server functions.
    uint  sv503_xactmemsize;
    ///Type: <b>DWORD</b> The priority of all server threads in relation to the base priority of the process.
    uint  sv503_threadpriority;
    ///Type: <b>DWORD</b> The maximum number of outstanding requests that any one client can send to the server. For
    ///example, 10 means you can have 10 unanswered requests at the server. When any single client has 10 requests
    ///queued within the server, the client must wait for a server response before sending another request.
    uint  sv503_maxmpxct;
    ///Type: <b>DWORD</b> The period of time, in seconds, to wait before timing out an opportunistic lock break request.
    uint  sv503_oplockbreakwait;
    ///Type: <b>DWORD</b> The period of time, in seconds, the server waits for a client to respond to an oplock break
    ///request from the server.
    uint  sv503_oplockbreakresponsewait;
    ///Type: <b>BOOL</b> A value that indicates whether the server allows clients to use opportunistic locks on files.
    ///Opportunistic locks are a significant performance enhancement, but have the potential to cause lost cached data
    ///on some networks, particularly wide-area networks.
    BOOL  sv503_enableoplocks;
    ///Type: <b>BOOL</b> A value that indicates how the server should behave if a client has an opportunistic lock
    ///(oplock) and does not respond to an oplock break. This member indicates whether the server will fail the second
    ///open (value of 0), or force close the open instance of a client that has an oplock (value equal to 1). This
    ///member is unused.
    BOOL  sv503_enableoplockforceclose;
    ///Type: <b>BOOL</b> A value that indicates whether several MS-DOS File Control Blocks (FCBs) are placed in a single
    ///location accessible to the server. If enabled, this can save resources on the server.
    BOOL  sv503_enablefcbopens;
    ///Type: <b>BOOL</b> A value that indicates whether the server processes raw Server Message Blocks (SMBs). If
    ///enabled, this allows more data to transfer per transaction and also improves performance. However, it is possible
    ///that processing raw SMBs can impede performance on certain networks. The server maintains the value of this
    ///member.
    BOOL  sv503_enableraw;
    ///Type: <b>BOOL</b> A value that indicates whether the server allows redirected server drives to be shared.
    BOOL  sv503_enablesharednetdrives;
    ///Type: <b>DWORD</b> The minimum number of free connection blocks maintained per endpoint. The server sets these
    ///aside to handle bursts of requests by clients to connect to the server.
    uint  sv503_minfreeconnections;
    ///Type: <b>DWORD</b> The maximum number of free connection blocks maintained per endpoint. The server sets these
    ///aside to handle bursts of requests by clients to connect to the server.
    uint  sv503_maxfreeconnections;
}

struct SERVER_INFO_599
{
    uint  sv599_sessopens;
    uint  sv599_sessvcs;
    uint  sv599_opensearch;
    uint  sv599_sizreqbuf;
    uint  sv599_initworkitems;
    uint  sv599_maxworkitems;
    uint  sv599_rawworkitems;
    uint  sv599_irpstacksize;
    uint  sv599_maxrawbuflen;
    uint  sv599_sessusers;
    uint  sv599_sessconns;
    uint  sv599_maxpagedmemoryusage;
    uint  sv599_maxnonpagedmemoryusage;
    BOOL  sv599_enablesoftcompat;
    BOOL  sv599_enableforcedlogoff;
    BOOL  sv599_timesource;
    BOOL  sv599_acceptdownlevelapis;
    BOOL  sv599_lmannounce;
    PWSTR sv599_domain;
    uint  sv599_maxcopyreadlen;
    uint  sv599_maxcopywritelen;
    uint  sv599_minkeepsearch;
    uint  sv599_maxkeepsearch;
    uint  sv599_minkeepcomplsearch;
    uint  sv599_maxkeepcomplsearch;
    uint  sv599_threadcountadd;
    uint  sv599_numblockthreads;
    uint  sv599_scavtimeout;
    uint  sv599_minrcvqueue;
    uint  sv599_minfreeworkitems;
    uint  sv599_xactmemsize;
    uint  sv599_threadpriority;
    uint  sv599_maxmpxct;
    uint  sv599_oplockbreakwait;
    uint  sv599_oplockbreakresponsewait;
    BOOL  sv599_enableoplocks;
    BOOL  sv599_enableoplockforceclose;
    BOOL  sv599_enablefcbopens;
    BOOL  sv599_enableraw;
    BOOL  sv599_enablesharednetdrives;
    uint  sv599_minfreeconnections;
    uint  sv599_maxfreeconnections;
    uint  sv599_initsesstable;
    uint  sv599_initconntable;
    uint  sv599_initfiletable;
    uint  sv599_initsearchtable;
    uint  sv599_alertschedule;
    uint  sv599_errorthreshold;
    uint  sv599_networkerrorthreshold;
    uint  sv599_diskspacethreshold;
    uint  sv599_reserved;
    uint  sv599_maxlinkdelay;
    uint  sv599_minlinkthroughput;
    uint  sv599_linkinfovalidtime;
    uint  sv599_scavqosinfoupdatetime;
    uint  sv599_maxworkitemidletime;
}

struct SERVER_INFO_598
{
    uint sv598_maxrawworkitems;
    uint sv598_maxthreadsperqueue;
    uint sv598_producttype;
    uint sv598_serversize;
    uint sv598_connectionlessautodisc;
    uint sv598_sharingviolationretries;
    uint sv598_sharingviolationdelay;
    uint sv598_maxglobalopensearch;
    uint sv598_removeduplicatesearches;
    uint sv598_lockviolationoffset;
    uint sv598_lockviolationdelay;
    uint sv598_mdlreadswitchover;
    uint sv598_cachedopenlimit;
    uint sv598_otherqueueaffinity;
    BOOL sv598_restrictnullsessaccess;
    BOOL sv598_enablewfw311directipx;
    uint sv598_queuesamplesecs;
    uint sv598_balancecount;
    uint sv598_preferredaffinity;
    uint sv598_maxfreerfcbs;
    uint sv598_maxfreemfcbs;
    uint sv598_maxfreelfcbs;
    uint sv598_maxfreepagedpoolchunks;
    uint sv598_minpagedpoolchunksize;
    uint sv598_maxpagedpoolchunksize;
    BOOL sv598_sendsfrompreferredprocessor;
    uint sv598_cacheddirectorylimit;
    uint sv598_maxcopylength;
    BOOL sv598_enablecompression;
    BOOL sv598_autosharewks;
    BOOL sv598_autoshareserver;
    BOOL sv598_enablesecuritysignature;
    BOOL sv598_requiresecuritysignature;
    uint sv598_minclientbuffersize;
    GUID sv598_serverguid;
    uint sv598_ConnectionNoSessionsTimeout;
    uint sv598_IdleThreadTimeOut;
    BOOL sv598_enableW9xsecuritysignature;
    BOOL sv598_enforcekerberosreauthentication;
    BOOL sv598_disabledos;
    uint sv598_lowdiskspaceminimum;
    BOOL sv598_disablestrictnamechecking;
    BOOL sv598_enableauthenticateusersharing;
}

///The <b>SERVER_INFO_1005</b> structure contains a comment that describes the specified server.
struct SERVER_INFO_1005
{
    ///Pointer to a string that contains a comment describing the server. The comment can be null. This string is
    ///Unicode if <b>_WIN32_WINNT</b> or <b>FORCE_UNICODE</b> are defined.
    PWSTR sv1005_comment;
}

///The <b>SERVER_INFO_1107</b> structure specifies the number of users that can simultaneously log on to the specified
///server.
struct SERVER_INFO_1107
{
    ///Specifies the number of users who can attempt to log on to the system server. Note that it is the license server
    ///that determines how many of these users can actually log on.
    uint sv1107_users;
}

///The <b>SERVER_INFO_1010</b> structure contains the auto-disconnect time associated with the specified server.
struct SERVER_INFO_1010
{
    ///Specifies the auto-disconnect time, in minutes. If a session is idle longer than the period of time specified by
    ///this member, the server disconnects the session. If the value of this member is SV_NODISC, auto-disconnect is not
    ///enabled.
    int sv1010_disc;
}

///The <b>SERVER_INFO_1016</b> structure contains information about whether the server is visible to other computers in
///the same network domain.
struct SERVER_INFO_1016
{
    ///Specifies whether the server is visible to other computers in the same network domain. This member can be one of
    ///the following values. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
    ///id="SV_VISIBLE"></a><a id="sv_visible"></a><dl> <dt><b>SV_VISIBLE</b></dt> </dl> </td> <td width="60%"> The
    ///server is visible. </td> </tr> <tr> <td width="40%"><a id="SV_HIDDEN"></a><a id="sv_hidden"></a><dl>
    ///<dt><b>SV_HIDDEN</b></dt> </dl> </td> <td width="60%"> The server is not visible. </td> </tr> </table>
    BOOL sv1016_hidden;
}

///The <b>SERVER_INFO_1017</b> structure contains the network announce rate associated with the specified server.
struct SERVER_INFO_1017
{
    ///Specifies the network announce rate, in seconds. This rate determines how often the server is announced to other
    ///computers on the network. For more information about how much the announce rate can vary from the period of time
    ///specified by this member, see SERVER_INFO_1018.
    uint sv1017_announce;
}

///The <b>SERVER_INFO_1018</b> structure contains information about how much the announce rate can vary for the
///specified server.
struct SERVER_INFO_1018
{
    ///Specifies the delta value for the announce rate, in milliseconds. This value specifies how much the announce rate
    ///can vary from the period of time specified in the sv<i>X</i>_announce member. The delta value allows randomly
    ///varied announce rates. For example, if the sv<i>X</i>_announce member has the value 10 and the
    ///sv<i>X</i>_anndelta member has the value 1, the announce rate can vary from 9.999 seconds to 10.001 seconds. For
    ///more information, see SERVER_INFO_102 and SERVER_INFO_1017.
    uint sv1018_anndelta;
}

///The <b>SERVER_INFO_1501</b> structure specifies the number of files that can be open in one session on the specified
///server.
struct SERVER_INFO_1501
{
    ///Specifies the number of files that one session can open.
    uint sv1501_sessopens;
}

///The <b>SERVER_INFO_1502</b> structure specifies the maximum number of virtual circuits per client for the specified
///server.
struct SERVER_INFO_1502
{
    ///Specifies the maximum number of virtual circuits permitted per client.
    uint sv1502_sessvcs;
}

///The <b>SERVER_INFO_1503</b> structure specifies the number of search operations that can be carried out
///simultaneously.
struct SERVER_INFO_1503
{
    ///Specifies the number of search operations that can be carried out simultaneously.
    uint sv1503_opensearch;
}

///The <b>SERVER_INFO_1506</b> structure contains information about the maximum number of work items the specified
///server can allocate.
struct SERVER_INFO_1506
{
    ///Specifies the maximum number of receive buffers, or work items, the server can allocate. If this limit is
    ///reached, the transport protocol must initiate flow control at a significant cost to performance.
    uint sv1506_maxworkitems;
}

///The <b>SERVER_INFO_1509</b> structure specifies the maximum raw mode buffer size.
struct SERVER_INFO_1509
{
    ///Specifies the maximum raw mode buffer size, in bytes.
    uint sv1509_maxrawbuflen;
}

///The <b>SERVER_INFO_1510</b> structure specifies the maximum number of users that can be logged on to the specified
///server using a single virtual circuit.
struct SERVER_INFO_1510
{
    ///Specifies the maximum number of users that can be logged on to a server using a single virtual circuit.
    uint sv1510_sessusers;
}

///The <b>SERVER_INFO_1511</b> structure specifies the maximum number of tree connections that users can make with a
///single virtual circuit.
struct SERVER_INFO_1511
{
    ///Specifies the maximum number of tree connections that users can make with a single virtual circuit.
    uint sv1511_sessconns;
}

///The <b>SERVER_INFO_1512</b> structure contains the maximum size of nonpaged memory that the specified server can
///allocate at a particular time.
struct SERVER_INFO_1512
{
    ///Specifies the maximum size of nonpaged memory that the server can allocate at any one time. Adjust this member if
    ///you want to administer memory quota control.
    uint sv1512_maxnonpagedmemoryusage;
}

///The <b>SERVER_INFO_1513</b> structure contains the maximum size of pageable memory that the specified server can
///allocate at a particular time.
struct SERVER_INFO_1513
{
    ///Specifies the maximum size of pageable memory that the server allocates at any particular time. Adjust this
    ///member if you want to administer memory quota control.
    uint sv1513_maxpagedmemoryusage;
}

struct SERVER_INFO_1514
{
    BOOL sv1514_enablesoftcompat;
}

///The <b>SERVER_INFO_1515</b> structure specifies whether the server should force a client to disconnect once the
///client's logon time has expired.
struct SERVER_INFO_1515
{
    ///Specifies whether the server should force a client to disconnect, even if the client has open files, once the
    ///client's logon time has expired.
    BOOL sv1515_enableforcedlogoff;
}

///The <b>SERVER_INFO_1516</b> structure specifies whether the server is a reliable time source.
struct SERVER_INFO_1516
{
    ///Specifies whether the server is a reliable time source.
    BOOL sv1516_timesource;
}

///The <b>SERVER_INFO_1518</b> structure specifies whether the server is visible to LAN Manager 2.<i>x</i> clients.
struct SERVER_INFO_1518
{
    ///Specifies whether the server is visible to LAN Manager 2.<i>x</i> clients.
    BOOL sv1518_lmannounce;
}

struct SERVER_INFO_1520
{
    uint sv1520_maxcopyreadlen;
}

struct SERVER_INFO_1521
{
    uint sv1521_maxcopywritelen;
}

struct SERVER_INFO_1522
{
    uint sv1522_minkeepsearch;
}

///The <b>SERVER_INFO_1523</b> structure specifies the length of time the server retains information about incomplete
///search operations.
struct SERVER_INFO_1523
{
    ///Specifies the length of time the server retains information about incomplete search operations.
    uint sv1523_maxkeepsearch;
}

struct SERVER_INFO_1524
{
    uint sv1524_minkeepcomplsearch;
}

struct SERVER_INFO_1525
{
    uint sv1525_maxkeepcomplsearch;
}

///The <b>SERVER_INFO_1528</b> structure specifies the period of time that the scavenger remains idle before waking up
///to service requests.
struct SERVER_INFO_1528
{
    ///Specifies the period of time, in seconds, that the scavenger remains idle before waking up to service requests. A
    ///smaller value for this member improves the response of the server to various events but costs CPU cycles.
    uint sv1528_scavtimeout;
}

///The <b>SERVER_INFO_1529</b> structure specifies the minimum number of free receive work items the server requires
///before it begins allocating more items.
struct SERVER_INFO_1529
{
    ///Specifies the minimum number of free receive work items the server requires before it begins allocating more. A
    ///larger value for this member helps ensure that there will always be work items available, but a value that is too
    ///large is inefficient.
    uint sv1529_minrcvqueue;
}

///The <b>SERVER_INFO_1530</b> structure specifies the minimum number of available receive work items the server
///requires to begin processing a server message block.
struct SERVER_INFO_1530
{
    ///Specifies the minimum number of available receive work items that the server requires to begin processing a
    ///server message block. A larger value for this member ensures that work items are available more frequently for
    ///nonblocking requests, but it also increases the likelihood that blocking requests will be rejected.
    uint sv1530_minfreeworkitems;
}

///The <b>SERVER_INFO_1533</b> structure specifies the maximum number of outstanding requests a client can send to the
///server.
struct SERVER_INFO_1533
{
    ///Specifies the maximum number of outstanding requests any one client can send to the server. For example, 10 means
    ///you can have 10 unanswered requests at the server. When any single client has 10 requests queued within the
    ///server, the client must wait for a server response before sending another request.
    uint sv1533_maxmpxct;
}

struct SERVER_INFO_1534
{
    uint sv1534_oplockbreakwait;
}

struct SERVER_INFO_1535
{
    uint sv1535_oplockbreakresponsewait;
}

///The <b>SERVER_INFO_1536</b> structure specifies whether the server allows clients to use opportunistic locks
///(oplocks) on files.
struct SERVER_INFO_1536
{
    ///Specifies whether the server allows clients to use oplocks on files. Opportunistic locks are a significant
    ///performance enhancement, but have the potential to cause lost cached data on some networks, particularly
    ///wide-area networks.
    BOOL sv1536_enableoplocks;
}

struct SERVER_INFO_1537
{
    BOOL sv1537_enableoplockforceclose;
}

///The <b>SERVER_INFO_1538</b> structure specifies whether several MS-DOS File Control Blocks (FCBs) are placed in a
///single location.
struct SERVER_INFO_1538
{
    ///Specifies whether several MS-DOS File Control Blocks (FCBs) are placed in a single location accessible to the
    ///server.
    BOOL sv1538_enablefcbopens;
}

///The <b>SERVER_INFO_1539</b> structure specifies whether the server processes raw Server Message Blocks (SMBs).
struct SERVER_INFO_1539
{
    ///Specifies whether the server processes raw SMBs. If enabled, this member allows more data to be transferred per
    ///transaction and improves performance. However, it is possible that processing raw SMBs can impede performance on
    ///certain networks. The server maintains the value of this member.
    BOOL sv1539_enableraw;
}

///The <b>SERVER_INFO_1540</b> structure specifies whether the server allows redirected server drives to be shared.
struct SERVER_INFO_1540
{
    ///Specifies whether the server allows redirected server drives to be shared.
    BOOL sv1540_enablesharednetdrives;
}

///The <b>SERVER_INFO_1541</b> structure specifies the minimum number of free connection blocks the server sets aside to
///handle bursts of requests by clients to connect to the server.
struct SERVER_INFO_1541
{
    ///Specifies the minimum number of free connection blocks maintained per endpoint. The server sets these aside to
    ///handle bursts of requests by clients to connect to the server.
    BOOL sv1541_minfreeconnections;
}

///The <b>SERVER_INFO_1542</b> structure specifies the maximum number of free connection blocks the server sets aside to
///handle bursts of requests by clients to connect to the server.
struct SERVER_INFO_1542
{
    ///Specifies the maximum number of free connection blocks maintained per endpoint. The server sets these aside to
    ///handle bursts of requests by clients to connect to the server.
    BOOL sv1542_maxfreeconnections;
}

struct SERVER_INFO_1543
{
    uint sv1543_initsesstable;
}

///The <b>SERVER_INFO_1544</b> structure specifies the initial number of tree connections to be allocated in the
///connection table.
struct SERVER_INFO_1544
{
    ///Specifies the initial number of tree connections to be allocated in the connection table. The server
    ///automatically increases the table as necessary, so setting the member to a higher value is an optimization.
    uint sv1544_initconntable;
}

struct SERVER_INFO_1545
{
    uint sv1545_initfiletable;
}

struct SERVER_INFO_1546
{
    uint sv1546_initsearchtable;
}

struct SERVER_INFO_1547
{
    uint sv1547_alertschedule;
}

struct SERVER_INFO_1548
{
    uint sv1548_errorthreshold;
}

struct SERVER_INFO_1549
{
    uint sv1549_networkerrorthreshold;
}

///The <b>SERVER_INFO_1550</b> structure specifies the percentage of free disk space remaining before an alert message
///is sent.
struct SERVER_INFO_1550
{
    ///Specifies the percentage of free disk space remaining before an alert message is sent.
    uint sv1550_diskspacethreshold;
}

///The <b>SERVER_INFO_1552</b> structure specifies the maximum time allowed for a link delay.
struct SERVER_INFO_1552
{
    ///Specifies the maximum time allowed for a link delay, in seconds. If delays exceed this number, the server
    ///disables raw I/O for this connection.
    uint sv1552_maxlinkdelay;
}

struct SERVER_INFO_1553
{
    uint sv1553_minlinkthroughput;
}

struct SERVER_INFO_1554
{
    uint sv1554_linkinfovalidtime;
}

struct SERVER_INFO_1555
{
    uint sv1555_scavqosinfoupdatetime;
}

struct SERVER_INFO_1556
{
    uint sv1556_maxworkitemidletime;
}

struct SERVER_INFO_1557
{
    uint sv1557_maxrawworkitems;
}

struct SERVER_INFO_1560
{
    uint sv1560_producttype;
}

struct SERVER_INFO_1561
{
    uint sv1561_serversize;
}

struct SERVER_INFO_1562
{
    uint sv1562_connectionlessautodisc;
}

struct SERVER_INFO_1563
{
    uint sv1563_sharingviolationretries;
}

struct SERVER_INFO_1564
{
    uint sv1564_sharingviolationdelay;
}

struct SERVER_INFO_1565
{
    uint sv1565_maxglobalopensearch;
}

struct SERVER_INFO_1566
{
    BOOL sv1566_removeduplicatesearches;
}

struct SERVER_INFO_1567
{
    uint sv1567_lockviolationretries;
}

struct SERVER_INFO_1568
{
    uint sv1568_lockviolationoffset;
}

struct SERVER_INFO_1569
{
    uint sv1569_lockviolationdelay;
}

struct SERVER_INFO_1570
{
    uint sv1570_mdlreadswitchover;
}

struct SERVER_INFO_1571
{
    uint sv1571_cachedopenlimit;
}

struct SERVER_INFO_1572
{
    uint sv1572_criticalthreads;
}

struct SERVER_INFO_1573
{
    uint sv1573_restrictnullsessaccess;
}

struct SERVER_INFO_1574
{
    uint sv1574_enablewfw311directipx;
}

struct SERVER_INFO_1575
{
    uint sv1575_otherqueueaffinity;
}

struct SERVER_INFO_1576
{
    uint sv1576_queuesamplesecs;
}

struct SERVER_INFO_1577
{
    uint sv1577_balancecount;
}

struct SERVER_INFO_1578
{
    uint sv1578_preferredaffinity;
}

struct SERVER_INFO_1579
{
    uint sv1579_maxfreerfcbs;
}

struct SERVER_INFO_1580
{
    uint sv1580_maxfreemfcbs;
}

struct SERVER_INFO_1581
{
    uint sv1581_maxfreemlcbs;
}

struct SERVER_INFO_1582
{
    uint sv1582_maxfreepagedpoolchunks;
}

struct SERVER_INFO_1583
{
    uint sv1583_minpagedpoolchunksize;
}

struct SERVER_INFO_1584
{
    uint sv1584_maxpagedpoolchunksize;
}

struct SERVER_INFO_1585
{
    BOOL sv1585_sendsfrompreferredprocessor;
}

struct SERVER_INFO_1586
{
    uint sv1586_maxthreadsperqueue;
}

struct SERVER_INFO_1587
{
    uint sv1587_cacheddirectorylimit;
}

struct SERVER_INFO_1588
{
    uint sv1588_maxcopylength;
}

struct SERVER_INFO_1590
{
    uint sv1590_enablecompression;
}

struct SERVER_INFO_1591
{
    uint sv1591_autosharewks;
}

struct SERVER_INFO_1592
{
    uint sv1592_autosharewks;
}

struct SERVER_INFO_1593
{
    uint sv1593_enablesecuritysignature;
}

struct SERVER_INFO_1594
{
    uint sv1594_requiresecuritysignature;
}

struct SERVER_INFO_1595
{
    uint sv1595_minclientbuffersize;
}

struct SERVER_INFO_1596
{
    uint sv1596_ConnectionNoSessionsTimeout;
}

struct SERVER_INFO_1597
{
    uint sv1597_IdleThreadTimeOut;
}

struct SERVER_INFO_1598
{
    uint sv1598_enableW9xsecuritysignature;
}

struct SERVER_INFO_1599
{
    ubyte sv1598_enforcekerberosreauthentication;
}

struct SERVER_INFO_1600
{
    ubyte sv1598_disabledos;
}

struct SERVER_INFO_1601
{
    uint sv1598_lowdiskspaceminimum;
}

struct SERVER_INFO_1602
{
    BOOL sv_1598_disablestrictnamechecking;
}

///The <b>SERVER_TRANSPORT_INFO_0</b> structure contains information about the specified transport protocol, including
///name, address, and location on the network.
struct SERVER_TRANSPORT_INFO_0
{
    ///Type: <b>DWORD</b> The number of clients connected to the server that are using the transport protocol specified
    ///by the <b>svti0_transportname</b> member.
    uint   svti0_numberofvcs;
    ///Type: <b>LMSTR</b> A pointer to a NULL-terminated character string that contains the name of a transport device;
    ///for example, <pre class="syntax"
    ///xml:space="preserve"><code>\Device\NetBT_Tcpip_{2C9725F4-151A-11D3-AEEC-C3B211BD350B} </code></pre> This string
    ///is Unicode if <b>_WIN32_WINNT</b> or <b>FORCE_UNICODE</b> are defined.
    PWSTR  svti0_transportname;
    ///Type: <b>LPBYTE</b> A pointer to a variable that contains the address the server is using on the transport device
    ///specified by the <b>svti0_transportname</b> member. This member is usually the NetBIOS name that the server is
    ///using. In these instances, the name must be 16 characters long, and the last character must be a blank character
    ///(0x20).
    ubyte* svti0_transportaddress;
    ///Type: <b>DWORD</b> The length, in bytes, of the <b>svti0_transportaddress</b> member. For NetBIOS names, the
    ///value of this member is 16 (decimal).
    uint   svti0_transportaddresslength;
    ///Type: <b>LMSTR</b> A pointer to a NULL-terminated character string that contains the address the network adapter
    ///is using. The string is transport-specific. You can retrieve this value only with a call to the
    ///NetServerTransportEnum function. You cannot set this value with a call to the NetServerTransportAdd function or
    ///the NetServerTransportAddEx function.) This string is Unicode if <b>_WIN32_WINNT</b> or <b>FORCE_UNICODE</b> are
    ///defined.
    PWSTR  svti0_networkaddress;
}

///The <b>SERVER_TRANSPORT_INFO_1</b> structure contains information about the specified transport protocol, including
///name and address. This information level is valid only for the NetServerTransportAddEx function.
struct SERVER_TRANSPORT_INFO_1
{
    ///Type: <b>DWORD</b> The number of clients connected to the server that are using the transport protocol specified
    ///by the <b>svti1_transportname</b> member.
    uint   svti1_numberofvcs;
    ///Type: <b>LMSTR</b> A pointer to a null-terminated character string that contains the name of a transport device;
    ///for example, <pre class="syntax"
    ///xml:space="preserve"><code>\Device\NetBT_Tcpip_{2C9725F4-151A-11D3-AEEC-C3B211BD350B} </code></pre> This string
    ///is Unicode if <b>_WIN32_WINNT</b> or <b>FORCE_UNICODE</b> are defined.
    PWSTR  svti1_transportname;
    ///Type: <b>LPBYTE</b> A pointer to a variable that contains the address the server is using on the transport device
    ///specified by the <b>svti1_transportname</b> member. This member is usually the NetBIOS name that the server is
    ///using. In these instances, the name must be 16 characters long, and the last character must be a blank character
    ///(0x20).
    ubyte* svti1_transportaddress;
    ///Type: <b>DWORD</b> The length, in bytes, of the <b>svti1_transportaddress</b> member. For NetBIOS names, the
    ///value of this member is 16 (decimal).
    uint   svti1_transportaddresslength;
    ///Type: <b>LMSTR</b> A pointer to a NULL-terminated character string that contains the address the network adapter
    ///is using. The string is transport-specific. You can retrieve this value only with a call to the
    ///NetServerTransportEnum function. You cannot set this value with a call to the NetServerTransportAdd function or
    ///the NetServerTransportAddEx function.) This string is Unicode if <b>_WIN32_WINNT</b> or <b>FORCE_UNICODE</b> are
    ///defined.
    PWSTR  svti1_networkaddress;
    ///Type: <b>LMSTR</b> A pointer to a NULL-terminated character string that contains the name of the domain to which
    ///the server should announce its presence. (When you call NetServerTransportEnum, this member is the name of the
    ///domain to which the server is announcing its presence.) This string is Unicode if <b>_WIN32_WINNT</b> or
    ///<b>FORCE_UNICODE</b> are defined.
    PWSTR  svti1_domain;
}

///The <b>SERVER_TRANSPORT_INFO_2</b> structure contains information about the specified transport protocol, including
///the transport name and address. This information level is valid only for the NetServerTransportAddEx function.
struct SERVER_TRANSPORT_INFO_2
{
    ///Type: <b>DWORD</b> The number of clients connected to the server that are using the transport protocol specified
    ///by the <b>svti2_transportname</b> member.
    uint   svti2_numberofvcs;
    ///Type: <b>LMSTR</b> A pointer to a NULL-terminated character string that contains the name of a transport device;
    ///for example, <pre class="syntax"
    ///xml:space="preserve"><code>\Device\NetBT_Tcpip_{2C9725F4-151A-11D3-AEEC-C3B211BD350B} </code></pre> This string
    ///is Unicode if <b>_WIN32_WINNT</b> or <b>FORCE_UNICODE</b> are defined.
    PWSTR  svti2_transportname;
    ///Type: <b>LPBYTE</b> A pointer to a variable that contains the address the server is using on the transport device
    ///specified by the <b>svti2_transportname</b> member. This member is usually the NetBIOS name that the server is
    ///using. In these instances, the name must be 16 characters long, and the last character must be a blank character
    ///(0x20).
    ubyte* svti2_transportaddress;
    ///Type: <b>DWORD</b> The length, in bytes, of the <b>svti2_transportaddress</b> member. For NetBIOS names, the
    ///value of this member is 16 (decimal).
    uint   svti2_transportaddresslength;
    ///Type: <b>LMSTR</b> A pointer to a NULL-terminated character string that contains the address the network adapter
    ///is using. The string is transport-specific. You can retrieve this value only with a call to the
    ///NetServerTransportEnum function. You cannot set this value with a call to the NetServerTransportAdd function or
    ///the NetServerTransportAddEx function.) This string is Unicode if <b>_WIN32_WINNT</b> or <b>FORCE_UNICODE</b> are
    ///defined.
    PWSTR  svti2_networkaddress;
    ///Type: <b>LMSTR</b> A pointer to a NULL-terminated character string that contains the name of the domain to which
    ///the server should announce its presence. (When you call NetServerTransportEnum, this member is the name of the
    ///domain to which the server is announcing its presence.) This string is Unicode if <b>_WIN32_WINNT</b> or
    ///<b>FORCE_UNICODE</b> are defined.
    PWSTR  svti2_domain;
    ///Type: <b>ULONG</b> This member can be a combination of the following bit values defined in the <i>Lmserver.h</i>
    ///header file. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
    ///id="SVTI2_REMAP_PIPE_NAMES"></a><a id="svti2_remap_pipe_names"></a><dl> <dt><b>SVTI2_REMAP_PIPE_NAMES</b></dt>
    ///</dl> </td> <td width="60%"> If this value is set for an endpoint, client requests arriving over the transport to
    ///open a named pipe are rerouted (remapped) to the following local pipe name: <b>$$\ServerName\PipeName</b> For
    ///more information on the use of this value, see the Remarks section. </td> </tr> <tr> <td width="40%"><a
    ///id="SVTI2_SCOPED_NAME"></a><a id="svti2_scoped_name"></a><dl> <dt><b>SVTI2_SCOPED_NAME</b></dt> </dl> </td> <td
    ///width="60%"> If this value is set for an endpoint and there is an attempt to create a second transport with the
    ///same network address but a different transport name and conflicting settings for the SCOPED flag, this transport
    ///creation will fail. Thus, every registered transport for a given network address must have the same scoped
    ///setting. For more information on the use of this value, see the Remarks section. This value is defined on Windows
    ///Server 2008 and Windows Vista with SP1. </td> </tr> </table>
    uint   svti2_flags;
}

///The <b>SERVER_TRANSPORT_INFO_3</b> structure contains information about the specified transport protocol, including
///name, address and password (credentials). This information level is valid only for the NetServerTransportAddEx
///function.
struct SERVER_TRANSPORT_INFO_3
{
    ///Type: <b>DWORD</b> The number of clients connected to the server that are using the transport protocol specified
    ///by the <b>svti3_transportname</b> member.
    uint       svti3_numberofvcs;
    ///Type: <b>LMSTR</b> A pointer to a NULL-terminated character string that contains the name of a transport device;
    ///for example, <pre class="syntax"
    ///xml:space="preserve"><code>\Device\NetBT_Tcpip_{2C9725F4-151A-11D3-AEEC-C3B211BD350B} </code></pre> This string
    ///is Unicode if <b>_WIN32_WINNT</b> or <b>FORCE_UNICODE</b> are defined.
    PWSTR      svti3_transportname;
    ///Type: <b>LPBYTE</b> A pointer to a variable that contains the address the server is using on the transport device
    ///specified by the <b>svti3_transportname</b> member. This member is usually the NetBIOS name that the server is
    ///using. In these instances, the name must be 16 characters long, and the last character must be a blank character
    ///(0x20).
    ubyte*     svti3_transportaddress;
    ///Type: <b>DWORD</b> The length, in bytes, of the <b>svti3_transportaddress</b> member. For NetBIOS names, the
    ///value of this member is 16 (decimal).
    uint       svti3_transportaddresslength;
    ///Type: <b>LMSTR</b> A pointer to a NULL-terminated character string that contains the address the network adapter
    ///is using. The string is transport-specific. You can retrieve this value only with a call to the
    ///NetServerTransportEnum function. You cannot set this value with a call to the NetServerTransportAdd function or
    ///the NetServerTransportAddEx function.) This string is Unicode if <b>_WIN32_WINNT</b> or <b>FORCE_UNICODE</b> are
    ///defined.
    PWSTR      svti3_networkaddress;
    ///Type: <b>LMSTR</b> A pointer to a NULL-terminated character string that contains the name of the domain to which
    ///the server should announce its presence. (When you call NetServerTransportEnum, this member is the name of the
    ///domain to which the server is announcing its presence.) This string is Unicode if <b>_WIN32_WINNT</b> or
    ///<b>FORCE_UNICODE</b> are defined.
    PWSTR      svti3_domain;
    ///Type: <b>ULONG</b> This member can be a combination of the following bit values defined in the <i>Lmserver.h</i>
    ///header file. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
    ///id="SVTI2_REMAP_PIPE_NAMES"></a><a id="svti2_remap_pipe_names"></a><dl> <dt><b>SVTI2_REMAP_PIPE_NAMES</b></dt>
    ///</dl> </td> <td width="60%"> If this value is set for an endpoint, client requests arriving over the transport to
    ///open a named pipe are rerouted (remapped) to the following local pipe name: <b>$$\ServerName\PipeName</b> For
    ///more information on the use of this value, see the Remarks section. </td> </tr> <tr> <td width="40%"><a
    ///id="SVTI2_SCOPED_NAME"></a><a id="svti2_scoped_name"></a><dl> <dt><b>SVTI2_SCOPED_NAME</b></dt> </dl> </td> <td
    ///width="60%"> If this value is set for an endpoint and there is an attempt to create a second transport with the
    ///same network address but a different transport name and conflicting settings for the SCOPED flag, this transport
    ///creation will fail. Thus, every registered transport for a given network address must have the same scoped
    ///setting. For more information on the use of this value, see the Remarks section. This value is defined on Windows
    ///Server 2008 and Windows Vista with SP1. </td> </tr> </table>
    uint       svti3_flags;
    ///Type: <b>DWORD</b> The number of valid bytes in the <b>svti3_password</b> member.
    uint       svti3_passwordlength;
    ///Type: <b>BYTE[256]</b> The credentials to use for the new transport address. If the <b>svti3_passwordlength</b>
    ///member is zero, the credentials for the server are used.
    ubyte[256] svti3_password;
}

struct SERVICE_INFO_0
{
    PWSTR svci0_name;
}

struct SERVICE_INFO_1
{
    PWSTR svci1_name;
    uint  svci1_status;
    uint  svci1_code;
    uint  svci1_pid;
}

struct SERVICE_INFO_2
{
    PWSTR svci2_name;
    uint  svci2_status;
    uint  svci2_code;
    uint  svci2_pid;
    PWSTR svci2_text;
    uint  svci2_specific_error;
    PWSTR svci2_display_name;
}

///The <b>USE_INFO_0</b> structure contains the name of a shared resource and the local device redirected to it.
struct USE_INFO_0
{
    ///Pointer to a Unicode string that specifies the local device name (for example, drive E or LPT1) being redirected
    ///to the shared resource. The constant DEVLEN specifies the maximum number of characters in the string.
    PWSTR ui0_local;
    ///Pointer to a Unicode string that specifies the share name of the remote resource being accessed. The string is in
    ///the form: <pre class="syntax" xml:space="preserve"><code>\\servername\sharename </code></pre>
    PWSTR ui0_remote;
}

///The <b>USE_INFO_1</b> structure contains information about the connection between a local device and a shared
///resource. The information includes connection status and connection type.
struct USE_INFO_1
{
    ///Type: <b>LMSTR</b> A pointer to a string that contains the local device name (for example, drive E or LPT1) being
    ///redirected to the shared resource. The constant DEVLEN specifies the maximum number of characters in the string.
    ///This member can be <b>NULL</b>. For more information, see the following Remarks section. This string is Unicode
    ///if <b>_WIN32_WINNT</b> or <b>FORCE_UNICODE</b> are defined.
    PWSTR ui1_local;
    ///Type: <b>LMSTR</b> A pointer to a string that contains the share name of the remote resource being accessed. The
    ///string is in the form: <pre class="syntax" xml:space="preserve"><code>\\servername\sharename </code></pre> This
    ///string is Unicode if <b>_WIN32_WINNT</b> or <b>FORCE_UNICODE</b> are defined.
    PWSTR ui1_remote;
    ///Type: <b>LMSTR</b> A pointer to a string that contains the password needed to establish a session between a
    ///specific workstation and a server. This string is Unicode if <b>_WIN32_WINNT</b> or <b>FORCE_UNICODE</b> are
    ///defined.
    PWSTR ui1_password;
    ///Type: <b>DWORD</b> The status of the connection. This element is not used by the NetUseAdd function. The
    ///following values are defined. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
    ///id="USE_OK"></a><a id="use_ok"></a><dl> <dt><b>USE_OK</b></dt> </dl> </td> <td width="60%"> The connection is
    ///valid. </td> </tr> <tr> <td width="40%"><a id="USE_PAUSED"></a><a id="use_paused"></a><dl>
    ///<dt><b>USE_PAUSED</b></dt> </dl> </td> <td width="60%"> Paused by local workstation. </td> </tr> <tr> <td
    ///width="40%"><a id="USE_SESSLOST"></a><a id="use_sesslost"></a><dl> <dt><b>USE_SESSLOST</b></dt> </dl> </td> <td
    ///width="60%"> Disconnected. </td> </tr> <tr> <td width="40%"><a id="USE_DISCONN"></a><a id="use_disconn"></a><dl>
    ///<dt><b>USE_DISCONN</b></dt> </dl> </td> <td width="60%"> An error occurred. </td> </tr> <tr> <td width="40%"><a
    ///id="USE_NETERR"></a><a id="use_neterr"></a><dl> <dt><b>USE_NETERR</b></dt> </dl> </td> <td width="60%"> A network
    ///error occurred. </td> </tr> <tr> <td width="40%"><a id="USE_CONN"></a><a id="use_conn"></a><dl>
    ///<dt><b>USE_CONN</b></dt> </dl> </td> <td width="60%"> The connection is being made. </td> </tr> <tr> <td
    ///width="40%"><a id="USE_RECONN"></a><a id="use_reconn"></a><dl> <dt><b>USE_RECONN</b></dt> </dl> </td> <td
    ///width="60%"> Reconnecting. </td> </tr> </table>
    uint  ui1_status;
    ///Type: <b>DWORD</b> The type of remote resource being accessed. This member can be one of the following values.
    ///<table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="USE_WILDCARD"></a><a
    ///id="use_wildcard"></a><dl> <dt><b>USE_WILDCARD</b></dt> </dl> </td> <td width="60%"> Matches the type of the
    ///server's shared resources. Wildcards can be used only with the NetUseAdd function, and only when the
    ///<b>ui1_local</b> member is <b>NULL</b>. For more information, see the following Remarks section. </td> </tr> <tr>
    ///<td width="40%"><a id="USE_DISKDEV"></a><a id="use_diskdev"></a><dl> <dt><b>USE_DISKDEV</b></dt> </dl> </td> <td
    ///width="60%"> Disk device. </td> </tr> <tr> <td width="40%"><a id="USE_SPOOLDEV"></a><a id="use_spooldev"></a><dl>
    ///<dt><b>USE_SPOOLDEV</b></dt> </dl> </td> <td width="60%"> Spooled printer. </td> </tr> <tr> <td width="40%"><a
    ///id="USE_IPC"></a><a id="use_ipc"></a><dl> <dt><b>USE_IPC</b></dt> </dl> </td> <td width="60%"> Interprocess
    ///communication (IPC). </td> </tr> </table>
    uint  ui1_asg_type;
    ///Type: <b>DWORD</b> The number of files, directories, and other processes that are open on the remote resource.
    ///This element is not used by the NetUseAdd function.
    uint  ui1_refcount;
    ///Type: <b>DWORD</b> The number of explicit connections (redirection with a local device name) or implicit UNC
    ///connections (redirection without a local device name) that are established with the resource.
    uint  ui1_usecount;
}

///The <b>USE_INFO_2</b> structure contains information about a connection between a local computer and a shared
///resource, including connection type, connection status, user name, and domain name.
struct USE_INFO_2
{
    ///Type: <b>LMSTR</b> A pointer to a string that contains the local device name (for example, drive E or LPT1) being
    ///redirected to the shared resource. The constant DEVLEN specifies the maximum number of characters in the string.
    ///This member can be <b>NULL</b>. For more information, see the following Remarks section. This string is Unicode
    ///if <b>_WIN32_WINNT</b> or <b>FORCE_UNICODE</b> are defined.
    PWSTR ui2_local;
    ///Type: <b>LMSTR</b> A pointer to a string that contains the share name of the remote resource. The string is in
    ///the form <pre class="syntax" xml:space="preserve"><code>\\servername\sharename </code></pre> This string is
    ///Unicode if <b>_WIN32_WINNT</b> or <b>FORCE_UNICODE</b> are defined.
    PWSTR ui2_remote;
    ///Type: <b>LMSTR</b> A pointer to a string that contains the password needed to establish a session with a specific
    ///workstation. This string is Unicode if <b>_WIN32_WINNT</b> or <b>FORCE_UNICODE</b> are defined.
    PWSTR ui2_password;
    ///Type: <b>DWORD</b> The status of the connection. This element is not used by the NetUseAdd function. The
    ///following values are defined. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
    ///id="USE_OK"></a><a id="use_ok"></a><dl> <dt><b>USE_OK</b></dt> </dl> </td> <td width="60%"> The connection is
    ///successful. </td> </tr> <tr> <td width="40%"><a id="USE_PAUSED"></a><a id="use_paused"></a><dl>
    ///<dt><b>USE_PAUSED</b></dt> </dl> </td> <td width="60%"> Paused by a local workstation. </td> </tr> <tr> <td
    ///width="40%"><a id="USE_SESSLOST"></a><a id="use_sesslost"></a><dl> <dt><b>USE_SESSLOST</b></dt> </dl> </td> <td
    ///width="60%"> Disconnected. </td> </tr> <tr> <td width="40%"><a id="USE_DISCONN"></a><a id="use_disconn"></a><dl>
    ///<dt><b>USE_DISCONN</b></dt> </dl> </td> <td width="60%"> An error occurred. </td> </tr> <tr> <td width="40%"><a
    ///id="USE_NETERR"></a><a id="use_neterr"></a><dl> <dt><b>USE_NETERR</b></dt> </dl> </td> <td width="60%"> A network
    ///error occurred. </td> </tr> <tr> <td width="40%"><a id="USE_CONN"></a><a id="use_conn"></a><dl>
    ///<dt><b>USE_CONN</b></dt> </dl> </td> <td width="60%"> The connection is being made. </td> </tr> <tr> <td
    ///width="40%"><a id="USE_RECONN"></a><a id="use_reconn"></a><dl> <dt><b>USE_RECONN</b></dt> </dl> </td> <td
    ///width="60%"> Reconnecting. </td> </tr> </table>
    uint  ui2_status;
    ///Type: <b>DWORD</b> The type of remote resource being accessed. This member can be one of the following values.
    ///<table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="USE_WILDCARD"></a><a
    ///id="use_wildcard"></a><dl> <dt><b>USE_WILDCARD</b></dt> </dl> </td> <td width="60%"> Matches the type of the
    ///server's shared resources. Wildcards can be used only with the NetUseAdd function, and only when the
    ///<b>ui2_local</b> member is a <b>NULL</b> string. For more information, see the following Remarks section. </td>
    ///</tr> <tr> <td width="40%"><a id="USE_DISKDEV"></a><a id="use_diskdev"></a><dl> <dt><b>USE_DISKDEV</b></dt> </dl>
    ///</td> <td width="60%"> Disk device. </td> </tr> <tr> <td width="40%"><a id="USE_SPOOLDEV"></a><a
    ///id="use_spooldev"></a><dl> <dt><b>USE_SPOOLDEV</b></dt> </dl> </td> <td width="60%"> Spooled printer. </td> </tr>
    ///<tr> <td width="40%"><a id="USE_IPC"></a><a id="use_ipc"></a><dl> <dt><b>USE_IPC</b></dt> </dl> </td> <td
    ///width="60%"> Interprocess communication (IPC). </td> </tr> </table>
    uint  ui2_asg_type;
    ///Type: <b>DWORD</b> The number of files, directories, and other processes that are open on the remote resource.
    ///This element is not used by the <b>NetUseAdd</b> function.
    uint  ui2_refcount;
    ///Type: <b>DWORD</b> The number of explicit connections (redirection with a local device name) or implicit UNC
    ///connections (redirection without a local device name) that are established with the resource.
    uint  ui2_usecount;
    ///Type: <b>LPWSTR</b> A pointer to a string that contains the name of the user who initiated the connection. This
    ///string is Unicode if <b>_WIN32_WINNT</b> or <b>FORCE_UNICODE</b> are defined.
    PWSTR ui2_username;
    ///Type: <b>LMSTR</b> A pointer to a string that contains the domain name of the remote resource. This string is
    ///Unicode if <b>_WIN32_WINNT</b> or <b>FORCE_UNICODE</b> are defined.
    PWSTR ui2_domainname;
}

///The <b>USE_INFO_3</b> structure contains information about a connection between a local computer and a shared
///resource, including connection type, connection status, user name, domain name, and specific flags that describe
///connection behavior.
struct USE_INFO_3
{
    ///USE_INFO_2 structure that contains
    USE_INFO_2 ui3_ui2;
    ///A set of bit flags that describe connection behavior and credential handling. <table> <tr> <th>Value</th>
    ///<th>Meaning</th> </tr> <tr> <td width="40%"><a id="CREATE_NO_CONNECT"></a><a id="create_no_connect"></a><dl>
    ///<dt><b>CREATE_NO_CONNECT</b></dt> </dl> </td> <td width="60%"> Do not connect to the server. </td> </tr> <tr> <td
    ///width="40%"><a id="CREATE_BYPASS_CSC"></a><a id="create_bypass_csc"></a><dl> <dt><b>CREATE_BYPASS_CSC</b></dt>
    ///</dl> </td> <td width="60%"> Force a connection to the server, bypassing the CSC. </td> </tr> <tr> <td
    ///width="40%"><a id="USE_DEFAULT_CREDENTIALS"></a><a id="use_default_credentials"></a><dl>
    ///<dt><b>USE_DEFAULT_CREDENTIALS</b></dt> </dl> </td> <td width="60%"> No explicit credentials are supplied in the
    ///call to NetUseAdd. </td> </tr> </table>
    uint       ui3_flags;
}

struct USE_INFO_4
{
    USE_INFO_3 ui4_ui3;
    uint       ui4_auth_identity_length;
    ubyte*     ui4_auth_identity;
}

struct USE_INFO_5
{
    USE_INFO_3 ui4_ui3;
    uint       ui4_auth_identity_length;
    ubyte*     ui4_auth_identity;
    uint       ui5_security_descriptor_length;
    ubyte*     ui5_security_descriptor;
    uint       ui5_use_options_length;
    ubyte*     ui5_use_options;
}

struct USE_OPTION_GENERIC
{
    uint   Tag;
    ushort Length;
    ushort Reserved;
}

struct USE_OPTION_DEFERRED_CONNECTION_PARAMETERS
{
    uint   Tag;
    ushort Length;
    ushort Reserved;
}

struct TRANSPORT_INFO
{
    TRANSPORT_TYPE Type;
}

struct USE_OPTION_TRANSPORT_PARAMETERS
{
    uint   Tag;
    ushort Length;
    ushort Reserved;
}

///The <b>WKSTA_INFO_100</b> structure contains information about a workstation environment, including platform-specific
///information, the names of the domain and the local computer, and information concerning the operating system.
struct WKSTA_INFO_100
{
    ///Type: <b>DWORD</b> The information level to use to retrieve platform-specific information. Possible values for
    ///this member are listed in the <i>Lmcons.h</i> header file. <table> <tr> <th>Value</th> <th>Meaning</th> </tr>
    ///<tr> <td width="40%"><a id="PLATFORM_ID_DOS"></a><a id="platform_id_dos"></a><dl> <dt><b>PLATFORM_ID_DOS</b></dt>
    ///<dt>300</dt> </dl> </td> <td width="60%"> The MS-DOS platform. </td> </tr> <tr> <td width="40%"><a
    ///id="PLATFORM_ID_OS2"></a><a id="platform_id_os2"></a><dl> <dt><b>PLATFORM_ID_OS2</b></dt> <dt>400</dt> </dl>
    ///</td> <td width="60%"> The OS/2 platform. </td> </tr> <tr> <td width="40%"><a id="PLATFORM_ID_NT"></a><a
    ///id="platform_id_nt"></a><dl> <dt><b>PLATFORM_ID_NT</b></dt> <dt>500</dt> </dl> </td> <td width="60%"> The Windows
    ///NT platform. </td> </tr> <tr> <td width="40%"><a id="PLATFORM_ID_OSF"></a><a id="platform_id_osf"></a><dl>
    ///<dt><b>PLATFORM_ID_OSF</b></dt> <dt>600</dt> </dl> </td> <td width="60%"> The OSF platform. </td> </tr> <tr> <td
    ///width="40%"><a id="PLATFORM_ID_VMS"></a><a id="platform_id_vms"></a><dl> <dt><b>PLATFORM_ID_VMS</b></dt>
    ///<dt>700</dt> </dl> </td> <td width="60%"> The VMS platform. </td> </tr> </table>
    uint  wki100_platform_id;
    ///Type: <b>LMSTR</b> A pointer to a string specifying the name of the local computer. This string is Unicode if
    ///<b>_WIN32_WINNT</b> or <b>FORCE_UNICODE</b> are defined.
    PWSTR wki100_computername;
    ///Type: <b>LMSTR</b> A pointer to a string specifying the name of the domain to which the computer belongs. This
    ///string is Unicode if <b>_WIN32_WINNT</b> or <b>FORCE_UNICODE</b> are defined.
    PWSTR wki100_langroup;
    ///Type: <b>DWORD</b> The major version number of the operating system running on the computer.
    uint  wki100_ver_major;
    ///Type: <b>DWORD</b> The minor version number of the operating system running on the computer.
    uint  wki100_ver_minor;
}

///The <b>WKSTA_INFO_101</b> structure contains information about a workstation environment, including platform-specific
///information, the name of the domain and the local computer, and information concerning the operating system.
struct WKSTA_INFO_101
{
    ///Type: <b>DWORD</b> The information level to use to retrieve platform-specific information. Possible values for
    ///this member are listed in the <i>Lmcons.h</i> header file. <table> <tr> <th>Value</th> <th>Meaning</th> </tr>
    ///<tr> <td width="40%"><a id="PLATFORM_ID_DOS"></a><a id="platform_id_dos"></a><dl> <dt><b>PLATFORM_ID_DOS</b></dt>
    ///<dt>300</dt> </dl> </td> <td width="60%"> The MS-DOS platform. </td> </tr> <tr> <td width="40%"><a
    ///id="PLATFORM_ID_OS2"></a><a id="platform_id_os2"></a><dl> <dt><b>PLATFORM_ID_OS2</b></dt> <dt>400</dt> </dl>
    ///</td> <td width="60%"> The OS/2 platform. </td> </tr> <tr> <td width="40%"><a id="PLATFORM_ID_NT"></a><a
    ///id="platform_id_nt"></a><dl> <dt><b>PLATFORM_ID_NT</b></dt> <dt>500</dt> </dl> </td> <td width="60%"> The Windows
    ///NT platform. </td> </tr> <tr> <td width="40%"><a id="PLATFORM_ID_OSF"></a><a id="platform_id_osf"></a><dl>
    ///<dt><b>PLATFORM_ID_OSF</b></dt> <dt>600</dt> </dl> </td> <td width="60%"> The OSF platform. </td> </tr> <tr> <td
    ///width="40%"><a id="PLATFORM_ID_VMS"></a><a id="platform_id_vms"></a><dl> <dt><b>PLATFORM_ID_VMS</b></dt>
    ///<dt>700</dt> </dl> </td> <td width="60%"> The VMS platform. </td> </tr> </table>
    uint  wki101_platform_id;
    ///Type: <b>LMSTR</b> A pointer to a string specifying the name of the local computer. This string is Unicode if
    ///<b>_WIN32_WINNT</b> or <b>FORCE_UNICODE</b> are defined.
    PWSTR wki101_computername;
    ///Type: <b>LMSTR</b> A pointer to a string specifying the name of the domain to which the computer belongs. This
    ///string is Unicode if <b>_WIN32_WINNT</b> or <b>FORCE_UNICODE</b> are defined.
    PWSTR wki101_langroup;
    ///Type: <b>DWORD</b> The major version number of the operating system running on the computer.
    uint  wki101_ver_major;
    ///Type: <b>DWORD</b> The minor version number of the operating system running on the computer.
    uint  wki101_ver_minor;
    ///Type: <b>LMSTR</b> A pointer to a string that contains the path to the LANMAN directory. This string is Unicode
    ///if <b>_WIN32_WINNT</b> or <b>FORCE_UNICODE</b> are defined.
    PWSTR wki101_lanroot;
}

///The <b>WKSTA_INFO_102</b> structure contains information about a workstation environment, including platform-specific
///information, the name of the domain and the local computer, and information concerning the operating system.
struct WKSTA_INFO_102
{
    ///Type: <b>DWORD</b> The information level to use to retrieve platform-specific information. Possible values for
    ///this member are listed in the <i>Lmcons.h</i> header file. <table> <tr> <th>Value</th> <th>Meaning</th> </tr>
    ///<tr> <td width="40%"><a id="PLATFORM_ID_DOS"></a><a id="platform_id_dos"></a><dl> <dt><b>PLATFORM_ID_DOS</b></dt>
    ///<dt>300</dt> </dl> </td> <td width="60%"> The MS-DOS platform. </td> </tr> <tr> <td width="40%"><a
    ///id="PLATFORM_ID_OS2"></a><a id="platform_id_os2"></a><dl> <dt><b>PLATFORM_ID_OS2</b></dt> <dt>400</dt> </dl>
    ///</td> <td width="60%"> The OS/2 platform. </td> </tr> <tr> <td width="40%"><a id="PLATFORM_ID_NT"></a><a
    ///id="platform_id_nt"></a><dl> <dt><b>PLATFORM_ID_NT</b></dt> <dt>500</dt> </dl> </td> <td width="60%"> The Windows
    ///NT platform. </td> </tr> <tr> <td width="40%"><a id="PLATFORM_ID_OSF"></a><a id="platform_id_osf"></a><dl>
    ///<dt><b>PLATFORM_ID_OSF</b></dt> <dt>600</dt> </dl> </td> <td width="60%"> The OSF platform. </td> </tr> <tr> <td
    ///width="40%"><a id="PLATFORM_ID_VMS"></a><a id="platform_id_vms"></a><dl> <dt><b>PLATFORM_ID_VMS</b></dt>
    ///<dt>700</dt> </dl> </td> <td width="60%"> The VMS platform. </td> </tr> </table>
    uint  wki102_platform_id;
    ///Type: <b>LMSTR</b> A pointer to a string specifying the name of the local computer. This string is Unicode if
    ///<b>_WIN32_WINNT</b> or <b>FORCE_UNICODE</b> are defined.
    PWSTR wki102_computername;
    ///Type: <b>LMSTR</b> A pointer to a string specifying the name of the domain to which the computer belongs. This
    ///string is Unicode if <b>_WIN32_WINNT</b> or <b>FORCE_UNICODE</b> are defined.
    PWSTR wki102_langroup;
    ///Type: <b>DWORD</b> The major version number of the operating system running on the computer.
    uint  wki102_ver_major;
    ///Type: <b>DWORD</b> The minor version number of the operating system running on the computer.
    uint  wki102_ver_minor;
    ///Type: <b>LMSTR</b> A pointer to a string that contains the path to the LANMAN directory. This string is Unicode
    ///if <b>_WIN32_WINNT</b> or <b>FORCE_UNICODE</b> are defined.
    PWSTR wki102_lanroot;
    ///Type: <b>DWORD</b> The number of users who are logged on to the local computer.
    uint  wki102_logged_on_users;
}

struct WKSTA_INFO_302
{
    uint  wki302_char_wait;
    uint  wki302_collection_time;
    uint  wki302_maximum_collection_count;
    uint  wki302_keep_conn;
    uint  wki302_keep_search;
    uint  wki302_max_cmds;
    uint  wki302_num_work_buf;
    uint  wki302_siz_work_buf;
    uint  wki302_max_wrk_cache;
    uint  wki302_sess_timeout;
    uint  wki302_siz_error;
    uint  wki302_num_alerts;
    uint  wki302_num_services;
    uint  wki302_errlog_sz;
    uint  wki302_print_buf_time;
    uint  wki302_num_char_buf;
    uint  wki302_siz_char_buf;
    PWSTR wki302_wrk_heuristics;
    uint  wki302_mailslots;
    uint  wki302_num_dgram_buf;
}

struct WKSTA_INFO_402
{
    uint  wki402_char_wait;
    uint  wki402_collection_time;
    uint  wki402_maximum_collection_count;
    uint  wki402_keep_conn;
    uint  wki402_keep_search;
    uint  wki402_max_cmds;
    uint  wki402_num_work_buf;
    uint  wki402_siz_work_buf;
    uint  wki402_max_wrk_cache;
    uint  wki402_sess_timeout;
    uint  wki402_siz_error;
    uint  wki402_num_alerts;
    uint  wki402_num_services;
    uint  wki402_errlog_sz;
    uint  wki402_print_buf_time;
    uint  wki402_num_char_buf;
    uint  wki402_siz_char_buf;
    PWSTR wki402_wrk_heuristics;
    uint  wki402_mailslots;
    uint  wki402_num_dgram_buf;
    uint  wki402_max_threads;
}

///The <b>WKSTA_INFO_502</b> structure is obsolete. The structure contains information about a workstation environment.
struct WKSTA_INFO_502
{
    ///Type: <b>DWORD</b> The number of seconds the computer waits for a remote resource to become available.
    uint wki502_char_wait;
    ///Type: <b>DWORD</b> The number of milliseconds the computer collects data before sending the data to a character
    ///device resource. The workstation waits the specified time or collects the number of characters specified by the
    ///<b>wki502_maximum_collection_count</b> member, whichever comes first.
    uint wki502_collection_time;
    ///Type: <b>DWORD</b> The number of bytes of information the computer collects before sending the data to a
    ///character device resource. The workstation collects the specified number of bytes or waits the period of time
    ///specified by the <b>wki502_collection_time</b> member, whichever comes first.
    uint wki502_maximum_collection_count;
    ///Type: <b>DWORD</b> The number of seconds the server maintains an inactive connection to a server's resource.
    uint wki502_keep_conn;
    ///Type: <b>DWORD</b> The number of simultaneous network device driver commands that can be sent to the network.
    uint wki502_max_cmds;
    ///Type: <b>DWORD</b> The number of seconds the server waits before disconnecting an inactive session.
    uint wki502_sess_timeout;
    ///Type: <b>DWORD</b> The maximum size, in bytes, of a character pipe buffer and device buffer.
    uint wki502_siz_char_buf;
    ///Type: <b>DWORD</b> The number of threads the computer can dedicate to the network.
    uint wki502_max_threads;
    ///Type: <b>DWORD</b> Reserved.
    uint wki502_lock_quota;
    ///Type: <b>DWORD</b> Reserved.
    uint wki502_lock_increment;
    ///Type: <b>DWORD</b> Reserved.
    uint wki502_lock_maximum;
    ///Type: <b>DWORD</b> Reserved.
    uint wki502_pipe_increment;
    ///Type: <b>DWORD</b> Reserved.
    uint wki502_pipe_maximum;
    ///Type: <b>DWORD</b> Reserved.
    uint wki502_cache_file_timeout;
    ///Type: <b>DWORD</b> Reserved.
    uint wki502_dormant_file_limit;
    ///Type: <b>DWORD</b> Reserved.
    uint wki502_read_ahead_throughput;
    ///Type: <b>DWORD</b> Reserved.
    uint wki502_num_mailslot_buffers;
    ///Type: <b>DWORD</b> Reserved.
    uint wki502_num_srv_announce_buffers;
    ///Type: <b>DWORD</b> Reserved.
    uint wki502_max_illegal_datagram_events;
    ///Type: <b>DWORD</b> Reserved.
    uint wki502_illegal_datagram_event_reset_frequency;
    ///Type: <b>BOOL</b> Reserved.
    BOOL wki502_log_election_packets;
    ///Type: <b>BOOL</b> Reserved.
    BOOL wki502_use_opportunistic_locking;
    ///Type: <b>BOOL</b> Reserved.
    BOOL wki502_use_unlock_behind;
    ///Type: <b>BOOL</b> Reserved.
    BOOL wki502_use_close_behind;
    ///Type: <b>BOOL</b> Reserved.
    BOOL wki502_buf_named_pipes;
    ///Type: <b>BOOL</b> Reserved.
    BOOL wki502_use_lock_read_unlock;
    ///Type: <b>BOOL</b> Reserved.
    BOOL wki502_utilize_nt_caching;
    ///Type: <b>BOOL</b> Reserved.
    BOOL wki502_use_raw_read;
    ///Type: <b>BOOL</b> Reserved.
    BOOL wki502_use_raw_write;
    ///Type: <b>BOOL</b> Reserved.
    BOOL wki502_use_write_raw_data;
    ///Type: <b>BOOL</b> Reserved.
    BOOL wki502_use_encryption;
    ///Type: <b>BOOL</b> Reserved.
    BOOL wki502_buf_files_deny_write;
    ///Type: <b>BOOL</b> Reserved.
    BOOL wki502_buf_read_only_files;
    ///Type: <b>BOOL</b> Reserved.
    BOOL wki502_force_core_create_mode;
    ///Type: <b>BOOL</b> Reserved.
    BOOL wki502_use_512_byte_max_transfer;
}

struct WKSTA_INFO_1010
{
    uint wki1010_char_wait;
}

struct WKSTA_INFO_1011
{
    uint wki1011_collection_time;
}

struct WKSTA_INFO_1012
{
    uint wki1012_maximum_collection_count;
}

struct WKSTA_INFO_1027
{
    uint wki1027_errlog_sz;
}

struct WKSTA_INFO_1028
{
    uint wki1028_print_buf_time;
}

struct WKSTA_INFO_1032
{
    uint wki1032_wrk_heuristics;
}

struct WKSTA_INFO_1013
{
    uint wki1013_keep_conn;
}

struct WKSTA_INFO_1018
{
    uint wki1018_sess_timeout;
}

struct WKSTA_INFO_1023
{
    uint wki1023_siz_char_buf;
}

struct WKSTA_INFO_1033
{
    uint wki1033_max_threads;
}

struct WKSTA_INFO_1041
{
    uint wki1041_lock_quota;
}

struct WKSTA_INFO_1042
{
    uint wki1042_lock_increment;
}

struct WKSTA_INFO_1043
{
    uint wki1043_lock_maximum;
}

struct WKSTA_INFO_1044
{
    uint wki1044_pipe_increment;
}

struct WKSTA_INFO_1045
{
    uint wki1045_pipe_maximum;
}

struct WKSTA_INFO_1046
{
    uint wki1046_dormant_file_limit;
}

struct WKSTA_INFO_1047
{
    uint wki1047_cache_file_timeout;
}

struct WKSTA_INFO_1048
{
    BOOL wki1048_use_opportunistic_locking;
}

struct WKSTA_INFO_1049
{
    BOOL wki1049_use_unlock_behind;
}

struct WKSTA_INFO_1050
{
    BOOL wki1050_use_close_behind;
}

struct WKSTA_INFO_1051
{
    BOOL wki1051_buf_named_pipes;
}

struct WKSTA_INFO_1052
{
    BOOL wki1052_use_lock_read_unlock;
}

struct WKSTA_INFO_1053
{
    BOOL wki1053_utilize_nt_caching;
}

struct WKSTA_INFO_1054
{
    BOOL wki1054_use_raw_read;
}

struct WKSTA_INFO_1055
{
    BOOL wki1055_use_raw_write;
}

struct WKSTA_INFO_1056
{
    BOOL wki1056_use_write_raw_data;
}

struct WKSTA_INFO_1057
{
    BOOL wki1057_use_encryption;
}

struct WKSTA_INFO_1058
{
    BOOL wki1058_buf_files_deny_write;
}

struct WKSTA_INFO_1059
{
    BOOL wki1059_buf_read_only_files;
}

struct WKSTA_INFO_1060
{
    BOOL wki1060_force_core_create_mode;
}

struct WKSTA_INFO_1061
{
    BOOL wki1061_use_512_byte_max_transfer;
}

struct WKSTA_INFO_1062
{
    uint wki1062_read_ahead_throughput;
}

///The <b>WKSTA_USER_INFO_0</b> structure contains the name of the user on a specified workstation.
struct WKSTA_USER_INFO_0
{
    ///Specifies the name of the user currently logged on to the workstation. This string is Unicode if
    ///<b>_WIN32_WINNT</b> or <b>FORCE_UNICODE</b> are defined.
    PWSTR wkui0_username;
}

///The <b>WKSTA_USER_INFO_1</b> structure contains user information as it pertains to a specific workstation. The
///information includes the name of the current user and the domains accessed by the workstation.
struct WKSTA_USER_INFO_1
{
    ///Specifies the name of the user currently logged on to the workstation. This string is Unicode if
    ///<b>_WIN32_WINNT</b> or <b>FORCE_UNICODE</b> are defined.
    PWSTR wkui1_username;
    ///Specifies the name of the domain in which the user is currently logged on. This string is Unicode if
    ///<b>_WIN32_WINNT</b> or <b>FORCE_UNICODE</b> are defined.
    PWSTR wkui1_logon_domain;
    ///Specifies the list of operating system domains browsed by the workstation. The domain names are separated by
    ///blanks. This string is Unicode if <b>_WIN32_WINNT</b> or <b>FORCE_UNICODE</b> are defined.
    PWSTR wkui1_oth_domains;
    ///Specifies the name of the server that authenticated the user. This string is Unicode if <b>_WIN32_WINNT</b> or
    ///<b>FORCE_UNICODE</b> are defined.
    PWSTR wkui1_logon_server;
}

///The <b>WKSTA_USER_INFO_1101</b> structure contains information about the domains accessed by a workstation.
struct WKSTA_USER_INFO_1101
{
    ///Specifies the list of operating system domains browsed by the workstation. The domain names are separated by
    ///blanks. This string is Unicode if <b>_WIN32_WINNT</b> or <b>FORCE_UNICODE</b> are defined.
    PWSTR wkui1101_oth_domains;
}

///The <b>WKSTA_TRANSPORT_INFO_0</b> structure contains information about the workstation transport protocol, such as
///Wide Area Network (WAN) or NetBIOS.
struct WKSTA_TRANSPORT_INFO_0
{
    ///Specifies a value that determines the search order of the transport protocol with respect to other transport
    ///protocols. The highest value is searched first.
    uint  wkti0_quality_of_service;
    ///Specifies the number of clients communicating with the server using this transport protocol.
    uint  wkti0_number_of_vcs;
    ///Specifies the device name of the transport protocol.
    PWSTR wkti0_transport_name;
    ///Specifies the address of the server on this transport protocol. This string is Unicode if <b>_WIN32_WINNT</b> or
    ///<b>FORCE_UNICODE</b> are defined.
    PWSTR wkti0_transport_address;
    ///This member is ignored by the NetWkstaTransportAdd function. For the NetWkstaTransportEnum function, this member
    ///indicates whether the transport protocol is a WAN transport protocol. This member is set to <b>TRUE</b> for
    ///NetBIOS/TCIP; it is set to <b>FALSE</b> for NetBEUI and NetBIOS/IPX. Certain legacy networking protocols,
    ///including NetBEUI, will no longer be supported. For more information, see Network Protocol Support in Windows.
    BOOL  wkti0_wan_ish;
}

// Functions

///The <b>NetUserAdd</b> function adds a user account and assigns a password and privilege level.
///Params:
///    servername = Pointer to a constant string that specifies the DNS or NetBIOS name of the remote server on which the function is
///                 to execute. If this parameter is <b>NULL</b>, the local computer is used. This string is Unicode if
///                 <b>_WIN32_WINNT</b> or <b>FORCE_UNICODE</b> are defined.
///    level = Specifies the information level of the data. This parameter can be one of the following values. <table> <tr>
///            <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="1"></a><dl> <dt><b>1</b></dt> </dl> </td> <td
///            width="60%"> Specifies information about the user account. The <i>buf</i> parameter points to a USER_INFO_1
///            structure. When you specify this level, the call initializes certain attributes to their default values. For more
///            information, see the following Remarks section. </td> </tr> <tr> <td width="40%"><a id="2"></a><dl>
///            <dt><b>2</b></dt> </dl> </td> <td width="60%"> Specifies level one information and additional attributes about
///            the user account. The <i>buf</i> parameter points to a USER_INFO_2 structure. </td> </tr> <tr> <td width="40%"><a
///            id="3"></a><dl> <dt><b>3</b></dt> </dl> </td> <td width="60%"> Specifies level two information and additional
///            attributes about the user account. This level is valid only on servers. The <i>buf</i> parameter points to a
///            USER_INFO_3 structure. Note that it is recommended that you use USER_INFO_4 instead. </td> </tr> <tr> <td
///            width="40%"><a id="4"></a><dl> <dt><b>4</b></dt> </dl> </td> <td width="60%"> Specifies level two information and
///            additional attributes about the user account. This level is valid only on servers. The <i>buf</i> parameter
///            points to a USER_INFO_4 structure. <b>Windows 2000: </b>This level is not supported. </td> </tr> </table>
///    buf = Pointer to the buffer that specifies the data. The format of this data depends on the value of the <i>level</i>
///          parameter. For more information, see Network Management Function Buffers.
///    parm_err = Pointer to a value that receives the index of the first member of the user information structure that causes
///               ERROR_INVALID_PARAMETER. If this parameter is <b>NULL</b>, the index is not returned on error. For more
///               information, see the NetUserSetInfo function.
///Returns:
///    If the function succeeds, the return value is NERR_Success. If the function fails, the return value can be one of
///    the following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
///    <dl> <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> The user does not have access to the
///    requested information. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>NERR_InvalidComputer</b></dt> </dl> </td>
///    <td width="60%"> The computer name is invalid. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>NERR_NotPrimary</b></dt> </dl> </td> <td width="60%"> The operation is allowed only on the primary domain
///    controller of the domain. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>NERR_GroupExists</b></dt> </dl> </td> <td
///    width="60%"> The group already exists. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>NERR_UserExists</b></dt>
///    </dl> </td> <td width="60%"> The user account already exists. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>NERR_PasswordTooShort</b></dt> </dl> </td> <td width="60%"> The password is shorter than required. (The
///    password could also be too long, be too recent in its change history, not have enough unique characters, or not
///    meet another password policy requirement.) </td> </tr> </table>
///    
@DllImport("samcli")
uint NetUserAdd(const(PWSTR) servername, uint level, ubyte* buf, uint* parm_err);

///The <b>NetUserEnum</b> function retrieves information about all user accounts on a server.
///Params:
///    servername = A pointer to a constant string that specifies the DNS or NetBIOS name of the remote server on which the function
///                 is to execute. If this parameter is <b>NULL</b>, the local computer is used.
///    level = Specifies the information level of the data. This parameter can be one of the following values. <table> <tr>
///            <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="0"></a><dl> <dt><b>0</b></dt> </dl> </td> <td
///            width="60%"> Return user account names. The <i>bufptr</i> parameter points to an array of USER_INFO_0 structures.
///            </td> </tr> <tr> <td width="40%"><a id="1"></a><dl> <dt><b>1</b></dt> </dl> </td> <td width="60%"> Return
///            detailed information about user accounts. The <i>bufptr</i> parameter points to an array of USER_INFO_1
///            structures. </td> </tr> <tr> <td width="40%"><a id="2"></a><dl> <dt><b>2</b></dt> </dl> </td> <td width="60%">
///            Return detailed information about user accounts, including authorization levels and logon information. The
///            <i>bufptr</i> parameter points to an array of USER_INFO_2 structures. </td> </tr> <tr> <td width="40%"><a
///            id="3"></a><dl> <dt><b>3</b></dt> </dl> </td> <td width="60%"> Return detailed information about user accounts,
///            including authorization levels, logon information, RIDs for the user and the primary group, and profile
///            information. The <i>bufptr</i> parameter points to an array of USER_INFO_3 structures. </td> </tr> <tr> <td
///            width="40%"><a id="10"></a><dl> <dt><b>10</b></dt> </dl> </td> <td width="60%"> Return user and account names and
///            comments. The <i>bufptr</i> parameter points to an array of USER_INFO_10 structures. </td> </tr> <tr> <td
///            width="40%"><a id="11"></a><dl> <dt><b>11</b></dt> </dl> </td> <td width="60%"> Return detailed information about
///            user accounts. The <i>bufptr</i> parameter points to an array of USER_INFO_11 structures. </td> </tr> <tr> <td
///            width="40%"><a id="20"></a><dl> <dt><b>20</b></dt> </dl> </td> <td width="60%"> Return the user's name and
///            identifier and various account attributes. The <i>bufptr</i> parameter points to an array of USER_INFO_20
///            structures. Note that on Windows XP and later, it is recommended that you use USER_INFO_23 instead. </td> </tr>
///            </table>
///    filter = A value that specifies the user account types to be included in the enumeration. A value of zero indicates that
///             all normal user, trust data, and machine account data should be included. This parameter can also be a
///             combination of the following values. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
///             id="FILTER_TEMP_DUPLICATE_ACCOUNT"></a><a id="filter_temp_duplicate_account"></a><dl>
///             <dt><b>FILTER_TEMP_DUPLICATE_ACCOUNT</b></dt> </dl> </td> <td width="60%"> Enumerates account data for users
///             whose primary account is in another domain. This account type provides user access to this domain, but not to any
///             domain that trusts this domain. The User Manager refers to this account type as a local user account. </td> </tr>
///             <tr> <td width="40%"><a id="FILTER_NORMAL_ACCOUNT"></a><a id="filter_normal_account"></a><dl>
///             <dt><b>FILTER_NORMAL_ACCOUNT</b></dt> </dl> </td> <td width="60%"> Enumerates normal user account data. This
///             account type is associated with a typical user. </td> </tr> <tr> <td width="40%"><a
///             id="FILTER_INTERDOMAIN_TRUST_ACCOUNT"></a><a id="filter_interdomain_trust_account"></a><dl>
///             <dt><b>FILTER_INTERDOMAIN_TRUST_ACCOUNT</b></dt> </dl> </td> <td width="60%"> Enumerates interdomain trust
///             account data. This account type is associated with a trust account for a domain that trusts other domains. </td>
///             </tr> <tr> <td width="40%"><a id="FILTER_WORKSTATION_TRUST_ACCOUNT"></a><a
///             id="filter_workstation_trust_account"></a><dl> <dt><b>FILTER_WORKSTATION_TRUST_ACCOUNT</b></dt> </dl> </td> <td
///             width="60%"> Enumerates workstation or member server trust account data. This account type is associated with a
///             machine account for a computer that is a member of the domain. </td> </tr> <tr> <td width="40%"><a
///             id="FILTER_SERVER_TRUST_ACCOUNT"></a><a id="filter_server_trust_account"></a><dl>
///             <dt><b>FILTER_SERVER_TRUST_ACCOUNT</b></dt> </dl> </td> <td width="60%"> Enumerates member server machine account
///             data. This account type is associated with a computer account for a backup domain controller that is a member of
///             the domain. </td> </tr> </table>
///    bufptr = A pointer to the buffer that receives the data. The format of this data depends on the value of the <i>level</i>
///             parameter. The buffer for this data is allocated by the system and the application must call the NetApiBufferFree
///             function to free the allocated memory when the data returned is no longer needed. Note that you must free the
///             buffer even if the <b>NetUserEnum</b> function fails with ERROR_MORE_DATA.
///    prefmaxlen = The preferred maximum length, in bytes, of the returned data. If you specify MAX_PREFERRED_LENGTH, the
///                 <b>NetUserEnum</b> function allocates the amount of memory required for the data. If you specify another value in
///                 this parameter, it can restrict the number of bytes that the function returns. If the buffer size is insufficient
///                 to hold all entries, the function returns ERROR_MORE_DATA. For more information, see Network Management Function
///                 Buffers and Network Management Function Buffer Lengths.
///    entriesread = A pointer to a value that receives the count of elements actually enumerated.
///    totalentries = A pointer to a value that receives the total number of entries that could have been enumerated from the current
///                   resume position. Note that applications should consider this value only as a hint. If your application is
///                   communicating with a Windows 2000 or later domain controller, you should consider using the ADSI LDAP Provider to
///                   retrieve this type of data more efficiently. The ADSI LDAP Provider implements a set of ADSI objects that support
///                   various ADSI interfaces. For more information, see ADSI Service Providers. <b>LAN Manager: </b>If the call is to
///                   a computer that is running LAN Manager 2.<i>x</i>, the <i>totalentries</i> parameter will always reflect the
///                   total number of entries in the database no matter where it is in the resume sequence.
///    resume_handle = A pointer to a value that contains a resume handle which is used to continue an existing user search. The handle
///                    should be zero on the first call and left unchanged for subsequent calls. If this parameter is <b>NULL</b>, then
///                    no resume handle is stored.
///Returns:
///    If the function succeeds, the return value is NERR_Success. If the function fails, the return value can be one of
///    the following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
///    <dl> <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> The user does not have access to the
///    requested information. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_LEVEL</b></dt> </dl> </td> <td
///    width="60%"> The system call level is not correct. This error is returned if the <i>level</i> parameter is set to
///    a value not supported. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>NERR_BufTooSmall</b></dt> </dl> </td> <td
///    width="60%"> The buffer is too small to contain an entry. No information has been written to the buffer. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>NERR_InvalidComputer</b></dt> </dl> </td> <td width="60%"> The computer
///    name is invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_MORE_DATA</b></dt> </dl> </td> <td
///    width="60%"> More entries are available. Specify a large enough buffer to receive all entries. </td> </tr>
///    </table>
///    
@DllImport("samcli")
uint NetUserEnum(const(PWSTR) servername, uint level, uint filter, ubyte** bufptr, uint prefmaxlen, 
                 uint* entriesread, uint* totalentries, uint* resume_handle);

///The <b>NetUserGetInfo</b> function retrieves information about a particular user account on a server.
///Params:
///    servername = A pointer to a constant string that specifies the DNS or NetBIOS name of the remote server on which the function
///                 is to execute. If this parameter is <b>NULL</b>, the local computer is used.
///    username = A pointer to a constant string that specifies the name of the user account for which to return information. For
///               more information, see the following Remarks section.
///    level = The information level of the data. This parameter can be one of the following values. <table> <tr> <th>Value</th>
///            <th>Meaning</th> </tr> <tr> <td width="40%"><a id="0"></a><dl> <dt><b>0</b></dt> </dl> </td> <td width="60%">
///            Return the user account name. The <i>bufptr</i> parameter points to a USER_INFO_0 structure. </td> </tr> <tr> <td
///            width="40%"><a id="1"></a><dl> <dt><b>1</b></dt> </dl> </td> <td width="60%"> Return detailed information about
///            the user account. The <i>bufptr</i> parameter points to a USER_INFO_1 structure. </td> </tr> <tr> <td
///            width="40%"><a id="2"></a><dl> <dt><b>2</b></dt> </dl> </td> <td width="60%"> Return detailed information and
///            additional attributes about the user account. The <i>bufptr</i> parameter points to a USER_INFO_2 structure.
///            </td> </tr> <tr> <td width="40%"><a id="3"></a><dl> <dt><b>3</b></dt> </dl> </td> <td width="60%"> Return
///            detailed information and additional attributes about the user account. This level is valid only on servers. The
///            <i>bufptr</i> parameter points to a USER_INFO_3 structure. Note that it is recommended that you use USER_INFO_4
///            instead. </td> </tr> <tr> <td width="40%"><a id="4"></a><dl> <dt><b>4</b></dt> </dl> </td> <td width="60%">
///            Return detailed information and additional attributes about the user account. This level is valid only on
///            servers. The <i>bufptr</i> parameter points to a USER_INFO_4 structure. <div class="alert"><b>Note</b> This level
///            is supported on Windows XP and later.</div> <div> </div> </td> </tr> <tr> <td width="40%"><a id="10"></a><dl>
///            <dt><b>10</b></dt> </dl> </td> <td width="60%"> Return user and account names and comments. The <i>bufptr</i>
///            parameter points to a USER_INFO_10 structure. </td> </tr> <tr> <td width="40%"><a id="11"></a><dl>
///            <dt><b>11</b></dt> </dl> </td> <td width="60%"> Return detailed information about the user account. The
///            <i>bufptr</i> parameter points to a USER_INFO_11 structure. </td> </tr> <tr> <td width="40%"><a id="20"></a><dl>
///            <dt><b>20</b></dt> </dl> </td> <td width="60%"> Return the user's name and identifier and various account
///            attributes. The <i>bufptr</i> parameter points to a USER_INFO_20 structure. Note that on Windows XP and later, it
///            is recommended that you use USER_INFO_23 instead. </td> </tr> <tr> <td width="40%"><a id="23"></a><dl>
///            <dt><b>23</b></dt> </dl> </td> <td width="60%"> Return the user's name and identifier and various account
///            attributes. The <i>bufptr</i> parameter points to a USER_INFO_23 structure. <div class="alert"><b>Note</b> This
///            level is supported on Windows XP and later.</div> <div> </div> </td> </tr> <tr> <td width="40%"><a
///            id="24"></a><dl> <dt><b>24</b></dt> </dl> </td> <td width="60%"> Return user account information for accounts
///            which are connected to an Internet identity. The <i>bufptr</i> parameter points to a USER_INFO_24 structure. <div
///            class="alert"><b>Note</b> The level is supported on Windows 8 and Windows Server 2012.</div> <div> </div> </td>
///            </tr> </table>
///    bufptr = A pointer to the buffer that receives the data. The format of this data depends on the value of the <i>level</i>
///             parameter. This buffer is allocated by the system and must be freed using the NetApiBufferFree function. For more
///             information, see Network Management Function Buffers and Network Management Function Buffer Lengths.
///Returns:
///    If the function succeeds, the return value is NERR_Success. If the function fails, the return value can be one of
///    the following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
///    <dl> <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> The user does not have access to the
///    requested information. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_BAD_NETPATH</b></dt> </dl> </td> <td
///    width="60%"> The network path specified in the <i>servername</i> parameter was not found. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_INVALID_LEVEL</b></dt> </dl> </td> <td width="60%"> The value specified for the
///    <i>level</i> parameter is invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>NERR_InvalidComputer</b></dt>
///    </dl> </td> <td width="60%"> The computer name is invalid. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>NERR_UserNotFound</b></dt> </dl> </td> <td width="60%"> The user name could not be found. </td> </tr>
///    </table>
///    
@DllImport("samcli")
uint NetUserGetInfo(const(PWSTR) servername, const(PWSTR) username, uint level, ubyte** bufptr);

///The <b>NetUserSetInfo</b> function sets the parameters of a user account.
///Params:
///    servername = A pointer to a constant string that specifies the DNS or NetBIOS name of the remote server on which the function
///                 is to execute. If this parameter is <b>NULL</b>, the local computer is used.
///    username = A pointer to a constant string that specifies the name of the user account for which to set information. For more
///               information, see the following Remarks section.
///    level = The information level of the data. This parameter can be one of the following values. <table> <tr> <th>Value</th>
///            <th>Meaning</th> </tr> <tr> <td width="40%"><a id="0"></a><dl> <dt><b>0</b></dt> </dl> </td> <td width="60%">
///            Specifies the user account name. The <i>buf</i> parameter points to a USER_INFO_0 structure. Use this structure
///            to specify a new group name. For more information, see the following Remarks section. </td> </tr> <tr> <td
///            width="40%"><a id="1"></a><dl> <dt><b>1</b></dt> </dl> </td> <td width="60%"> Specifies detailed information
///            about the user account. The <i>buf</i> parameter points to a USER_INFO_1 structure. </td> </tr> <tr> <td
///            width="40%"><a id="2"></a><dl> <dt><b>2</b></dt> </dl> </td> <td width="60%"> Specifies level one information and
///            additional attributes about the user account. The <i>buf</i> parameter points to a USER_INFO_2 structure. </td>
///            </tr> <tr> <td width="40%"><a id="3"></a><dl> <dt><b>3</b></dt> </dl> </td> <td width="60%"> Specifies level two
///            information and additional attributes about the user account. This level is valid only on servers. The <i>buf</i>
///            parameter points to a USER_INFO_3 structure. Note that it is recommended that you use USER_INFO_4 instead. </td>
///            </tr> <tr> <td width="40%"><a id="4"></a><dl> <dt><b>4</b></dt> </dl> </td> <td width="60%"> Specifies level two
///            information and additional attributes about the user account. This level is valid only on servers. The <i>buf</i>
///            parameter points to a USER_INFO_4 structure. </td> </tr> <tr> <td width="40%"><a id="21"></a><dl>
///            <dt><b>21</b></dt> </dl> </td> <td width="60%"> Specifies a one-way encrypted LAN Manager 2.<i>x</i>-compatible
///            password. The <i>buf</i> parameter points to a USER_INFO_21 structure. </td> </tr> <tr> <td width="40%"><a
///            id="22"></a><dl> <dt><b>22</b></dt> </dl> </td> <td width="60%"> Specifies detailed information about the user
///            account. The <i>buf</i> parameter points to a USER_INFO_22 structure. </td> </tr> <tr> <td width="40%"><a
///            id="1003"></a><dl> <dt><b>1003</b></dt> </dl> </td> <td width="60%"> Specifies a user password. The <i>buf</i>
///            parameter points to a USER_INFO_1003 structure. </td> </tr> <tr> <td width="40%"><a id="1005"></a><dl>
///            <dt><b>1005</b></dt> </dl> </td> <td width="60%"> Specifies a user privilege level. The <i>buf</i> parameter
///            points to a USER_INFO_1005 structure. </td> </tr> <tr> <td width="40%"><a id="1006"></a><dl> <dt><b>1006</b></dt>
///            </dl> </td> <td width="60%"> Specifies the path of the home directory for the user. The <i>buf</i> parameter
///            points to a USER_INFO_1006 structure. </td> </tr> <tr> <td width="40%"><a id="1007"></a><dl> <dt><b>1007</b></dt>
///            </dl> </td> <td width="60%"> Specifies a comment to associate with the user account. The <i>buf</i> parameter
///            points to a USER_INFO_1007 structure. </td> </tr> <tr> <td width="40%"><a id="1008"></a><dl> <dt><b>1008</b></dt>
///            </dl> </td> <td width="60%"> Specifies user account attributes. The <i>buf</i> parameter points to a
///            USER_INFO_1008 structure. </td> </tr> <tr> <td width="40%"><a id="1009"></a><dl> <dt><b>1009</b></dt> </dl> </td>
///            <td width="60%"> Specifies the path for the user's logon script file. The <i>buf</i> parameter points to a
///            USER_INFO_1009 structure. </td> </tr> <tr> <td width="40%"><a id="1010"></a><dl> <dt><b>1010</b></dt> </dl> </td>
///            <td width="60%"> Specifies the user's operator privileges. The <i>buf</i> parameter points to a USER_INFO_1010
///            structure. </td> </tr> <tr> <td width="40%"><a id="1011"></a><dl> <dt><b>1011</b></dt> </dl> </td> <td
///            width="60%"> Specifies the full name of the user. The <i>buf</i> parameter points to a USER_INFO_1011 structure.
///            </td> </tr> <tr> <td width="40%"><a id="1012"></a><dl> <dt><b>1012</b></dt> </dl> </td> <td width="60%">
///            Specifies a comment to associate with the user. The <i>buf</i> parameter points to a USER_INFO_1012 structure.
///            </td> </tr> <tr> <td width="40%"><a id="1014"></a><dl> <dt><b>1014</b></dt> </dl> </td> <td width="60%">
///            Specifies the names of workstations from which the user can log on. The <i>buf</i> parameter points to a
///            USER_INFO_1014 structure. </td> </tr> <tr> <td width="40%"><a id="1017"></a><dl> <dt><b>1017</b></dt> </dl> </td>
///            <td width="60%"> Specifies when the user account expires. The <i>buf</i> parameter points to a USER_INFO_1017
///            structure. </td> </tr> <tr> <td width="40%"><a id="1020"></a><dl> <dt><b>1020</b></dt> </dl> </td> <td
///            width="60%"> Specifies the times during which the user can log on. The <i>buf</i> parameter points to a
///            USER_INFO_1020 structure. </td> </tr> <tr> <td width="40%"><a id="1024"></a><dl> <dt><b>1024</b></dt> </dl> </td>
///            <td width="60%"> Specifies the user's country/region code. The <i>buf</i> parameter points to a USER_INFO_1024
///            structure. </td> </tr> <tr> <td width="40%"><a id="1051"></a><dl> <dt><b>1051</b></dt> </dl> </td> <td
///            width="60%"> Specifies the relative identifier of a global group that represents the enrolled user. The
///            <i>buf</i> parameter points to a USER_INFO_1051 structure. </td> </tr> <tr> <td width="40%"><a id="1052"></a><dl>
///            <dt><b>1052</b></dt> </dl> </td> <td width="60%"> Specifies the path to a network user's profile. The <i>buf</i>
///            parameter points to a USER_INFO_1052 structure. </td> </tr> <tr> <td width="40%"><a id="1053"></a><dl>
///            <dt><b>1053</b></dt> </dl> </td> <td width="60%"> Specifies the drive letter assigned to the user's home
///            directory. The <i>buf</i> parameter points to a USER_INFO_1053 structure. </td> </tr> </table>
///    buf = A pointer to the buffer that specifies the data. The format of this data depends on the value of the <i>level</i>
///          parameter. For more information, see Network Management Function Buffers.
///    parm_err = A pointer to a value that receives the index of the first member of the user information structure that causes
///               ERROR_INVALID_PARAMETER. If this parameter is <b>NULL</b>, the index is not returned on error. For more
///               information, see the following Remarks section.
///Returns:
///    If the function succeeds, the return value is NERR_Success. If the function fails, the return value can be one of
///    the following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
///    <dl> <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> The user does not have access to the
///    requested information. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td>
///    <td width="60%"> One of the function parameters is invalid. For more information, see the following Remarks
///    section. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>NERR_InvalidComputer</b></dt> </dl> </td> <td width="60%">
///    The computer name is invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>NERR_NotPrimary</b></dt> </dl> </td>
///    <td width="60%"> The operation is allowed only on the primary domain controller of the domain. </td> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>NERR_SpeGroupOp</b></dt> </dl> </td> <td width="60%"> The operation is not allowed
///    on specified special groups, which are user groups, admin groups, local groups, or guest groups. </td> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>NERR_LastAdmin</b></dt> </dl> </td> <td width="60%"> The operation is not allowed on
///    the last administrative account. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>NERR_BadPassword</b></dt> </dl>
///    </td> <td width="60%"> The share name or password is invalid. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>NERR_PasswordTooShort</b></dt> </dl> </td> <td width="60%"> The password is shorter than required. (The
///    password could also be too long, be too recent in its change history, not have enough unique characters, or not
///    meet another password policy requirement.) </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>NERR_UserNotFound</b></dt> </dl> </td> <td width="60%"> The user name could not be found. </td> </tr>
///    </table>
///    
@DllImport("samcli")
uint NetUserSetInfo(const(PWSTR) servername, const(PWSTR) username, uint level, ubyte* buf, uint* parm_err);

///The <b>NetUserDel</b> function deletes a user account from a server.
///Params:
///    servername = Pointer to a constant string that specifies the DNS or NetBIOS name of the remote server on which the function is
///                 to execute. If this parameter is <b>NULL</b>, the local computer is used.
///    username = Pointer to a constant string that specifies the name of the user account to delete. For more information, see the
///               following Remarks section.
///Returns:
///    If the function succeeds, the return value is NERR_Success. If the function fails, the return value can be one of
///    the following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
///    <dl> <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> The user does not have access to the
///    requested information. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>NERR_InvalidComputer</b></dt> </dl> </td>
///    <td width="60%"> The computer name is invalid. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>NERR_NotPrimary</b></dt> </dl> </td> <td width="60%"> The operation is allowed only on the primary domain
///    controller of the domain. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>NERR_UserNotFound</b></dt> </dl> </td>
///    <td width="60%"> The user name could not be found. </td> </tr> </table>
///    
@DllImport("samcli")
uint NetUserDel(const(PWSTR) servername, const(PWSTR) username);

///The <b>NetUserGetGroups</b> function retrieves a list of global groups to which a specified user belongs.
///Params:
///    servername = A pointer to a constant string that specifies the DNS or NetBIOS name of the remote server on which the function
///                 is to execute. If this parameter is <b>NULL</b>, the local computer is used.
///    username = A pointer to a constant string that specifies the name of the user to search for in each group account. For more
///               information, see the following Remarks section.
///    level = The information level of the data requested. This parameter can be one of the following values. <table> <tr>
///            <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="0"></a><dl> <dt><b>0</b></dt> </dl> </td> <td
///            width="60%"> Return the names of the global groups to which the user belongs. The <i>bufptr</i> parameter points
///            to an array of GROUP_USERS_INFO_0 structures. </td> </tr> <tr> <td width="40%"><a id="1"></a><dl>
///            <dt><b>1</b></dt> </dl> </td> <td width="60%"> Return the names of the global groups to which the user belongs
///            with attributes. The <i>bufptr</i> parameter points to an array of GROUP_USERS_INFO_1 structures. </td> </tr>
///            </table>
///    bufptr = A pointer to the buffer that receives the data. This buffer is allocated by the system and must be freed using
///             the NetApiBufferFree function. Note that you must free the buffer even if the function fails with
///             ERROR_MORE_DATA.
///    prefmaxlen = The preferred maximum length, in bytes, of returned data. If MAX_PREFERRED_LENGTH is specified, the function
///                 allocates the amount of memory required for the data. If another value is specified in this parameter, it can
///                 restrict the number of bytes that the function returns. If the buffer size is insufficient to hold all entries,
///                 the function returns ERROR_MORE_DATA. For more information, see Network Management Function Buffers and Network
///                 Management Function Buffer Lengths.
///    entriesread = A pointer to a value that receives the count of elements actually retrieved.
///    totalentries = A pointer to a value that receives the total number of entries that could have been retrieved.
///Returns:
///    If the function succeeds, the return value is NERR_Success. If the function fails, the return value can be one of
///    the following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
///    <dl> <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> The user does not have access rights to the
///    requested information. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_BAD_NETPATH</b></dt> </dl> </td> <td
///    width="60%"> The network path was not found. This error is returned if the <i>servername</i> parameter could not
///    be found. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_LEVEL</b></dt> </dl> </td> <td width="60%">
///    The system call level is not correct. This error is returned if the <i>level</i> parameter was specified as a
///    value other than 0 or 1. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_NAME</b></dt> </dl> </td>
///    <td width="60%"> The name syntax is incorrect. This error is returned if the <i>servername</i> parameter has
///    leading or trailing blanks or contains an illegal character. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_MORE_DATA</b></dt> </dl> </td> <td width="60%"> More entries are available. Specify a large enough
///    buffer to receive all entries. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NOT_ENOUGH_MEMORY</b></dt>
///    </dl> </td> <td width="60%"> Insufficient memory was available to complete the operation. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>NERR_InternalError</b></dt> </dl> </td> <td width="60%"> An internal error occurred.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>NERR_UserNotFound</b></dt> </dl> </td> <td width="60%"> The user
///    could not be found. This error is returned if the <i>username</i> could not be found. </td> </tr> </table>
///    
@DllImport("samcli")
uint NetUserGetGroups(const(PWSTR) servername, const(PWSTR) username, uint level, ubyte** bufptr, uint prefmaxlen, 
                      uint* entriesread, uint* totalentries);

///The <b>NetUserSetGroups</b> function sets global group memberships for a specified user account.
///Params:
///    servername = A pointer to a constant string that specifies the DNS or NetBIOS name of the remote server on which the function
///                 is to execute. If this parameter is <b>NULL</b>, the local computer is used.
///    username = A pointer to a constant string that specifies the name of the user for which to set global group memberships. For
///               more information, see the Remarks section.
///    level = The information level of the data. This parameter can be one of the following values. <table> <tr> <th>Value</th>
///            <th>Meaning</th> </tr> <tr> <td width="40%"><a id="0"></a><dl> <dt><b>0</b></dt> </dl> </td> <td width="60%"> The
///            <i>buf</i> parameter points to an array of GROUP_USERS_INFO_0 structures that specifies global group names. </td>
///            </tr> <tr> <td width="40%"><a id="1"></a><dl> <dt><b>1</b></dt> </dl> </td> <td width="60%"> The <i>buf</i>
///            parameter points to an array of GROUP_USERS_INFO_1 structures that specifies global group names with attributes.
///            </td> </tr> </table>
///    buf = A pointer to the buffer that specifies the data. For more information, see Network Management Function Buffers.
///    num_entries = The number of entries contained in the array pointed to by the <i>buf</i> parameter.
///Returns:
///    If the function succeeds, the return value is NERR_Success. If the function fails, the return value can be one of
///    the following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
///    <dl> <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> The user does not have access to the
///    requested information. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_LEVEL</b></dt> </dl> </td> <td
///    width="60%"> The system call level is not correct. This error is returned if the <i>level</i> parameter was
///    specified as a value other than 0 or 1. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> A parameter passed was not valid. This error
///    is returned if the <i>num_entries</i> parameter was not valid. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_NOT_ENOUGH_MEMORY</b></dt> </dl> </td> <td width="60%"> Insufficient memory was available to
///    complete the operation. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>NERR_InvalidComputer</b></dt> </dl> </td>
///    <td width="60%"> The computer name is invalid. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>NERR_NotPrimary</b></dt> </dl> </td> <td width="60%"> The operation is allowed only on the primary domain
///    controller of the domain. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>NERR_GroupNotFound</b></dt> </dl> </td>
///    <td width="60%"> The group group name specified by the <b>grui0_name</b> in the GROUP_USERS_INFO_0 structure or
///    <b>grui1_name</b> member in the GROUP_USERS_INFO_1 structure pointed to by the <i>buf</i> parameter does not
///    exist. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>NERR_InternalError</b></dt> </dl> </td> <td width="60%"> An
///    internal error occurred. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>NERR_UserNotFound</b></dt> </dl> </td> <td
///    width="60%"> The user name could not be found. </td> </tr> </table>
///    
@DllImport("samcli")
uint NetUserSetGroups(const(PWSTR) servername, const(PWSTR) username, uint level, ubyte* buf, uint num_entries);

///The <b>NetUserGetLocalGroups</b> function retrieves a list of local groups to which a specified user belongs.
///Params:
///    servername = A pointer to a constant string that specifies the DNS or NetBIOS name of the remote server on which the function
///                 is to execute. If this parameter is <b>NULL</b>, the local computer is used.
///    username = A pointer to a constant string that specifies the name of the user for which to return local group membership
///               information. If the string is of the form <i>DomainName</i>&
///    level = The information level of the data. This parameter can be the following value. <table> <tr> <th>Value</th>
///            <th>Meaning</th> </tr> <tr> <td width="40%"><a id="0"></a><dl> <dt><b>0</b></dt> </dl> </td> <td width="60%">
///            Return the names of the local groups to which the user belongs. The <i>bufptr</i> parameter points to an array of
///            LOCALGROUP_USERS_INFO_0 structures. </td> </tr> </table>
///    flags = A bitmask of flags that affect the operation. Currently, only the value defined is <b>LG_INCLUDE_INDIRECT</b>. If
///            this bit is set, the function also returns the names of the local groups in which the user is indirectly a member
///            (that is, the user has membership in a global group that is itself a member of one or more local groups).
///    bufptr = A pointer to the buffer that receives the data. The format of this data depends on the value of the <i>level</i>
///             parameter. This buffer is allocated by the system and must be freed using the NetApiBufferFree function. Note
///             that you must free the buffer even if the function fails with <b>ERROR_MORE_DATA</b>.
///    prefmaxlen = The preferred maximum length, in bytes, of the returned data. If <b>MAX_PREFERRED_LENGTH</b> is specified in this
///                 parameter, the function allocates the amount of memory required for the data. If another value is specified in
///                 this parameter, it can restrict the number of bytes that the function returns. If the buffer size is insufficient
///                 to hold all entries, the function returns <b>ERROR_MORE_DATA</b>. For more information, see Network Management
///                 Function Buffers and Network Management Function Buffer Lengths.
///    entriesread = A pointer to a value that receives the count of elements actually enumerated.
///    totalentries = A pointer to a value that receives the total number of entries that could have been enumerated.
///Returns:
///    If the function succeeds, the return value is NERR_Success. If the function fails, the return value can be one of
///    the following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
///    <dl> <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> The user does not have access rights to the
///    requested information. This error is also returned if the <i>servername</i> parameter has a trailing blank. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_LEVEL</b></dt> </dl> </td> <td width="60%"> The system call
///    level is not correct. This error is returned if the <i>level</i> parameter was not specified as 0. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> A parameter is
///    incorrect. This error is returned if the <i>flags</i> parameter contains a value other than
///    <b>LG_INCLUDE_INDIRECT</b>. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_MORE_DATA</b></dt> </dl> </td>
///    <td width="60%"> More entries are available. Specify a large enough buffer to receive all entries. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>ERROR_NOT_ENOUGH_MEMORY</b></dt> </dl> </td> <td width="60%"> Insufficient
///    memory was available to complete the operation. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>NERR_DCNotFound</b></dt> </dl> </td> <td width="60%"> The domain controller could not be found. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>NERR_UserNotFound</b></dt> </dl> </td> <td width="60%"> The user could
///    not be found. This error is returned if the <i>username</i> could not be found. </td> </tr> <tr> <td width="40%">
///    <dl> <dt><b>RPC_S_SERVER_UNAVAILABLE</b></dt> </dl> </td> <td width="60%"> The RPC server is unavailable. This
///    error is returned if the <i>servername</i> parameter could not be found. </td> </tr> </table>
///    
@DllImport("samcli")
uint NetUserGetLocalGroups(const(PWSTR) servername, const(PWSTR) username, uint level, uint flags, ubyte** bufptr, 
                           uint prefmaxlen, uint* entriesread, uint* totalentries);

///The <b>NetUserModalsGet</b> function retrieves global information for all users and global groups in the security
///database, which is the security accounts manager (SAM) database or, in the case of domain controllers, the Active
///Directory.
///Params:
///    servername = A pointer to a constant string that specifies the DNS or NetBIOS name of the remote server on which the function
///                 is to execute. If this parameter is <b>NULL</b>, the local computer is used. For more information, see the
///                 following Remarks section.
///    level = The information level of the data requested. This parameter can be one of the following values. <table> <tr>
///            <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="0"></a><dl> <dt><b>0</b></dt> </dl> </td> <td
///            width="60%"> Return global password parameters. The <i>bufptr</i> parameter points to a USER_MODALS_INFO_0
///            structure. </td> </tr> <tr> <td width="40%"><a id="1"></a><dl> <dt><b>1</b></dt> </dl> </td> <td width="60%">
///            Return logon server and domain controller information. The <i>bufptr</i> parameter points to a USER_MODALS_INFO_1
///            structure. </td> </tr> <tr> <td width="40%"><a id="2"></a><dl> <dt><b>2</b></dt> </dl> </td> <td width="60%">
///            Return domain name and identifier. The <i>bufptr</i> parameter points to a USER_MODALS_INFO_2 structure. For more
///            information, see the following Remarks section. </td> </tr> <tr> <td width="40%"><a id="3"></a><dl>
///            <dt><b>3</b></dt> </dl> </td> <td width="60%"> Return lockout information. The <i>bufptr</i> parameter points to
///            a USER_MODALS_INFO_3 structure. </td> </tr> </table> A null session logon can call <b>NetUserModalsGet</b>
///            anonymously at information levels 0 and 3.
///    bufptr = A pointer to the buffer that receives the data. The format of this data depends on the value of the <i>level</i>
///             parameter. The buffer for this data is allocated by the system and the application must call the NetApiBufferFree
///             function to free the allocated memory when the data returned is no longer needed. For more information, see
///             Network Management Function Buffers and Network Management Function Buffer Lengths.
///Returns:
///    If the function succeeds, the return value is NERR_Success. If the function fails, the return value can be one of
///    the following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
///    <dl> <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> The user does not have access to the
///    requested information. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_BAD_NETPATH</b></dt> </dl> </td> <td
///    width="60%"> The network path was not found. This error is returned if the <i>servername</i> parameter could not
///    be found. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_LEVEL</b></dt> </dl> </td> <td width="60%">
///    The system call level is not correct. This error is returned if the <i>level </i> parameter is not one of the
///    supported values. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_NAME</b></dt> </dl> </td> <td
///    width="60%"> The file name, directory name, or volume label syntax is incorrect. This error is returned if the
///    <i>servername</i> parameter syntax is incorrect. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_WRONG_TARGET_NAME</b></dt> </dl> </td> <td width="60%"> The target account name is incorrect. This
///    error is returned for a logon failure to a remote <i>servername</i> parameter running on Windows Vista. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>NERR_InvalidComputer</b></dt> </dl> </td> <td width="60%"> The computer
///    name is invalid. </td> </tr> </table>
///    
@DllImport("samcli")
uint NetUserModalsGet(const(PWSTR) servername, uint level, ubyte** bufptr);

///The <b>NetUserModalsSet</b> function sets global information for all users and global groups in the security
///database, which is the security accounts manager (SAM) database or, in the case of domain controllers, the Active
///Directory.
///Params:
///    servername = Pointer to a constant string that specifies the DNS or NetBIOS name of the remote server on which the function is
///                 to execute. If this parameter is <b>NULL</b>, the local computer is used.
///    level = Specifies the information level of the data. This parameter can be one of the following values. <table> <tr>
///            <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="0"></a><dl> <dt><b>0</b></dt> </dl> </td> <td
///            width="60%"> Specifies global password parameters. The <i>buf</i> parameter points to a USER_MODALS_INFO_0
///            structure. </td> </tr> <tr> <td width="40%"><a id="1"></a><dl> <dt><b>1</b></dt> </dl> </td> <td width="60%">
///            Specifies logon server and domain controller information. The <i>buf</i> parameter points to a USER_MODALS_INFO_1
///            structure. </td> </tr> <tr> <td width="40%"><a id="2"></a><dl> <dt><b>2</b></dt> </dl> </td> <td width="60%">
///            Specifies the domain name and identifier. The <i>buf</i> parameter points to a USER_MODALS_INFO_2 structure.
///            </td> </tr> <tr> <td width="40%"><a id="3"></a><dl> <dt><b>3</b></dt> </dl> </td> <td width="60%"> Specifies
///            lockout information. The <i>buf</i> parameter points to a USER_MODALS_INFO_3 structure. </td> </tr> <tr> <td
///            width="40%"><a id="1001"></a><dl> <dt><b>1001</b></dt> </dl> </td> <td width="60%"> Specifies the minimum
///            allowable password length. The <i>buf</i> parameter points to a USER_MODALS_INFO_1001 structure. </td> </tr> <tr>
///            <td width="40%"><a id="1002"></a><dl> <dt><b>1002</b></dt> </dl> </td> <td width="60%"> Specifies the maximum
///            allowable password age. The <i>buf</i> parameter points to a USER_MODALS_INFO_1002 structure. </td> </tr> <tr>
///            <td width="40%"><a id="1003"></a><dl> <dt><b>1003</b></dt> </dl> </td> <td width="60%"> Specifies the minimum
///            allowable password age. The <i>buf</i> parameter points to a USER_MODALS_INFO_1003 structure. </td> </tr> <tr>
///            <td width="40%"><a id="1004"></a><dl> <dt><b>1004</b></dt> </dl> </td> <td width="60%"> Specifies forced logoff
///            information. The <i>buf</i> parameter points to a USER_MODALS_INFO_1004 structure. </td> </tr> <tr> <td
///            width="40%"><a id="1005"></a><dl> <dt><b>1005</b></dt> </dl> </td> <td width="60%"> Specifies the length of the
///            password history. The <i>buf</i> parameter points to a USER_MODALS_INFO_1005 structure. </td> </tr> <tr> <td
///            width="40%"><a id="1006"></a><dl> <dt><b>1006</b></dt> </dl> </td> <td width="60%"> Specifies the role of the
///            logon server. The <i>buf</i> parameter points to a USER_MODALS_INFO_1006 structure. </td> </tr> <tr> <td
///            width="40%"><a id="1007"></a><dl> <dt><b>1007</b></dt> </dl> </td> <td width="60%"> Specifies domain controller
///            information. The <i>buf</i> parameter points to a USER_MODALS_INFO_1007 structure. </td> </tr> </table>
///    buf = Pointer to the buffer that specifies the data. The format of this data depends on the value of the <i>level</i>
///          parameter. For more information, see Network Management Function Buffers.
///    parm_err = Pointer to a value that receives the index of the first member of the information structure that causes
///               ERROR_INVALID_PARAMETER. If this parameter is <b>NULL</b>, the index is not returned on error. For more
///               information, see the following Remarks section.
///Returns:
///    If the function succeeds, the return value is NERR_Success. If the function fails, the return value can be one of
///    the following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
///    <dl> <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> The user does not have access to the
///    requested information. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td>
///    <td width="60%"> The specified parameter is invalid. For more information, see the following Remarks section.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>NERR_InvalidComputer</b></dt> </dl> </td> <td width="60%"> The
///    computer name is invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>NERR_UserNotFound</b></dt> </dl> </td>
///    <td width="60%"> The user name could not be found. </td> </tr> </table>
///    
@DllImport("samcli")
uint NetUserModalsSet(const(PWSTR) servername, uint level, ubyte* buf, uint* parm_err);

///The <b>NetUserChangePassword</b> function changes a user's password for a specified network server or domain.
///Params:
///    domainname = A pointer to a constant string that specifies the DNS or NetBIOS name of a remote server or domain on which the
///                 function is to execute. If this parameter is <b>NULL</b>, the logon domain of the caller is used.
///    username = A pointer to a constant string that specifies a user name. The <b>NetUserChangePassword</b> function changes the
///               password for the specified user. If this parameter is <b>NULL</b>, the logon name of the caller is used. For more
///               information, see the following Remarks section.
///    oldpassword = A pointer to a constant string that specifies the user's old password.
///    newpassword = A pointer to a constant string that specifies the user's new password.
///Returns:
///    If the function succeeds, the return value is NERR_Success. If the function fails, the return value can be one of
///    the following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
///    <dl> <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> The user does not have access to the
///    requested information. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PASSWORD</b></dt> </dl> </td>
///    <td width="60%"> The user has entered an invalid password. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>NERR_InvalidComputer</b></dt> </dl> </td> <td width="60%"> The computer name is invalid. </td> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>NERR_NotPrimary</b></dt> </dl> </td> <td width="60%"> The operation is allowed only
///    on the primary domain controller of the domain. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>NERR_UserNotFound</b></dt> </dl> </td> <td width="60%"> The user name could not be found. </td> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>NERR_PasswordTooShort</b></dt> </dl> </td> <td width="60%"> The password is shorter
///    than required. (The password could also be too long, be too recent in its change history, not have enough unique
///    characters, or not meet another password policy requirement.) </td> </tr> </table>
///    
@DllImport("samcli")
uint NetUserChangePassword(const(PWSTR) domainname, const(PWSTR) username, const(PWSTR) oldpassword, 
                           const(PWSTR) newpassword);

///The <b>NetGroupAdd</b> function creates a global group in the security database, which is the security accounts
///manager (SAM) database or, in the case of domain controllers, the Active Directory.
///Params:
///    servername = Pointer to a constant string that specifies the DNS or NetBIOS name of the remote server on which the function is
///                 to execute. If this parameter is <b>NULL</b>, the local computer is used.
///    level = Specifies the information level of the data. This parameter can be one of the following values. <table> <tr>
///            <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="0"></a><dl> <dt><b>0</b></dt> </dl> </td> <td
///            width="60%"> Specifies a global group name. The <i>buf</i> parameter contains a pointer to a GROUP_INFO_0
///            structure. </td> </tr> <tr> <td width="40%"><a id="1"></a><dl> <dt><b>1</b></dt> </dl> </td> <td width="60%">
///            Specifies a global group name and a comment. The <i>buf</i> parameter contains a pointer to a GROUP_INFO_1
///            structure. </td> </tr> <tr> <td width="40%"><a id="2"></a><dl> <dt><b>2</b></dt> </dl> </td> <td width="60%">
///            Specifies detailed information about the global group. The <i>buf</i> parameter contains a pointer to a
///            GROUP_INFO_2 structure. Note that on Windows XP and later, it is recommended that you use GROUP_INFO_3 instead.
///            </td> </tr> <tr> <td width="40%"><a id="3"></a><dl> <dt><b>3</b></dt> </dl> </td> <td width="60%"> Specifies
///            detailed information about the global group. The <i>buf</i> parameter contains a pointer to a GROUP_INFO_3
///            structure. <b>Windows 2000: </b>This level is not supported. </td> </tr> </table>
///    buf = Pointer to a buffer that contains the data. The format of this data depends on the value of the <i>level</i>
///          parameter. For more information, see Network Management Function Buffers.
///    parm_err = Pointer to a value that receives the index of the first member of the global group information structure in error
///               when ERROR_INVALID_PARAMETER is returned. If this parameter is <b>NULL</b>, the index is not returned on error.
///               For more information, see the NetGroupSetInfo function.
///Returns:
///    If the function succeeds, the return value is NERR_Success. If the function fails, the return value can be one of
///    the following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
///    <dl> <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> The user does not have access to the
///    requested information. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>NERR_InvalidComputer</b></dt> </dl> </td>
///    <td width="60%"> The computer name is invalid. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>NERR_GroupExists</b></dt> </dl> </td> <td width="60%"> The global group already exists. </td> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>NERR_NotPrimary</b></dt> </dl> </td> <td width="60%"> The operation is allowed only
///    on the primary domain controller of the domain. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_LEVEL</b></dt> </dl> </td> <td width="60%"> The value specified for the <i>level</i>
///    parameter is invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>NERR_SpeGroupOp</b></dt> </dl> </td> <td
///    width="60%"> The operation is not allowed on certain special groups. These groups include user groups, admin
///    groups, local groups, and guest groups. </td> </tr> </table>
///    
@DllImport("samcli")
uint NetGroupAdd(const(PWSTR) servername, uint level, ubyte* buf, uint* parm_err);

///The <b>NetGroupAddUser</b> function gives an existing user account membership in an existing global group in the
///security database, which is the security accounts manager (SAM) database or, in the case of domain controllers, the
///Active Directory.
///Params:
///    servername = Pointer to a constant string that specifies the DNS or NetBIOS name of the remote server on which the function is
///                 to execute. If this parameter is <b>NULL</b>, the local computer is used.
///    GroupName = Pointer to a constant string that specifies the name of the global group in which the user is to be given
///                membership. For more information, see the following Remarks section.
///    username = Pointer to a constant string that specifies the name of the user to be given membership in the global group. For
///               more information, see the following Remarks section.
///Returns:
///    If the function succeeds, the return value is NERR_Success. If the function fails, the return value can be one of
///    the following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
///    <dl> <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> The user does not have access to the
///    requested information. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>NERR_InvalidComputer</b></dt> </dl> </td>
///    <td width="60%"> The computer name is invalid. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>NERR_NotPrimary</b></dt> </dl> </td> <td width="60%"> The operation is allowed only on the primary domain
///    controller of the domain. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>NERR_SpeGroupOp</b></dt> </dl> </td> <td
///    width="60%"> The operation is not allowed on certain special groups. These groups include user groups, admin
///    groups, local groups, and guest groups. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>NERR_UserNotFound</b></dt>
///    </dl> </td> <td width="60%"> The user name could not be found. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>NERR_GroupNotFound</b></dt> </dl> </td> <td width="60%"> The global group name could not be found. </td>
///    </tr> </table>
///    
@DllImport("samcli")
uint NetGroupAddUser(const(PWSTR) servername, const(PWSTR) GroupName, const(PWSTR) username);

///The <b>NetGroupEnum</b> function retrieves information about each global group in the security database, which is the
///security accounts manager (SAM) database or, in the case of domain controllers, the Active Directory. The
///NetQueryDisplayInformation function provides an efficient mechanism for enumerating global groups. When possible, it
///is recommended that you use <b>NetQueryDisplayInformation</b> instead of the <b>NetGroupEnum</b> function.
///Params:
///    servername = Pointer to a constant string that specifies the DNS or NetBIOS name of the remote server on which the function is
///                 to execute. If this parameter is <b>NULL</b>, the local computer is used.
///    level = Specifies the information level of the data. This parameter can be one of the following values. <table> <tr>
///            <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="0"></a><dl> <dt><b>0</b></dt> </dl> </td> <td
///            width="60%"> Return the global group name. The <i>bufptr</i> parameter points to an array of GROUP_INFO_0
///            structures. </td> </tr> <tr> <td width="40%"><a id="1"></a><dl> <dt><b>1</b></dt> </dl> </td> <td width="60%">
///            Return the global group name and a comment. The <i>bufptr</i> parameter points to an array of GROUP_INFO_1
///            structures. </td> </tr> <tr> <td width="40%"><a id="2"></a><dl> <dt><b>2</b></dt> </dl> </td> <td width="60%">
///            Return detailed information about the global group. The <i>bufptr</i> parameter points to an array of
///            GROUP_INFO_2 structures. Note that on Windows XP and later, it is recommended that you use GROUP_INFO_3 instead.
///            </td> </tr> <tr> <td width="40%"><a id="3"></a><dl> <dt><b>3</b></dt> </dl> </td> <td width="60%"> Return
///            detailed information about the global group. The <i>bufptr</i> parameter points to an array of GROUP_INFO_3
///            structures. <b>Windows 2000: </b>This level is not supported. </td> </tr> </table>
///    bufptr = Pointer to the buffer to receive the global group information structure. The format of this data depends on the
///             value of the <i>level</i> parameter. The system allocates the memory for this buffer. You must call the
///             NetApiBufferFree function to deallocate the memory. Note that you must free the buffer even if the function fails
///             with ERROR_MORE_DATA.
///    prefmaxlen = Specifies the preferred maximum length of the returned data, in bytes. If you specify MAX_PREFERRED_LENGTH, the
///                 function allocates the amount of memory required to hold the data. If you specify another value in this
///                 parameter, it can restrict the number of bytes that the function returns. If the buffer size is insufficient to
///                 hold all entries, the function returns ERROR_MORE_DATA. For more information, see Network Management Function
///                 Buffers and Network Management Function Buffer Lengths.
///    entriesread = Pointer to a value that receives the count of elements actually enumerated.
///    totalentries = Pointer to a value that receives the total number of entries that could have been enumerated from the current
///                   resume position. The total number of entries is only a hint. For more information about determining the exact
///                   number of entries, see the following Remarks section.
///    resume_handle = Pointer to a variable that contains a resume handle that is used to continue the global group enumeration. The
///                    handle should be zero on the first call and left unchanged for subsequent calls. If this parameter is
///                    <b>NULL</b>, no resume handle is stored.
///Returns:
///    If the function succeeds, the return value is NERR_Success. If the function fails, the return value can be one of
///    the following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
///    <dl> <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> The user does not have access to the
///    requested information. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>NERR_InvalidComputer</b></dt> </dl> </td>
///    <td width="60%"> The computer name is invalid. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_MORE_DATA</b></dt> </dl> </td> <td width="60%"> More entries are available. Specify a large enough
///    buffer to receive all entries. </td> </tr> </table>
///    
@DllImport("samcli")
uint NetGroupEnum(const(PWSTR) servername, uint level, ubyte** bufptr, uint prefmaxlen, uint* entriesread, 
                  uint* totalentries, size_t* resume_handle);

///The <b>NetGroupGetInfo</b> function retrieves information about a particular global group in the security database,
///which is the security accounts manager (SAM) database or, in the case of domain controllers, the Active Directory.
///Params:
///    servername = Pointer to a constant string that specifies the DNS or NetBIOS name of the remote server on which the function is
///                 to execute. If this parameter is <b>NULL</b>, the local computer is used.
///    groupname = Pointer to a constant string that specifies the name of the global group for which to retrieve information. For
///                more information, see the following Remarks section.
///    level = Specifies the information level of the data. This parameter can be one of the following values. <table> <tr>
///            <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="0"></a><dl> <dt><b>0</b></dt> </dl> </td> <td
///            width="60%"> Return the global group name. The <i>bufptr</i> parameter points to a GROUP_INFO_0 structure. </td>
///            </tr> <tr> <td width="40%"><a id="1"></a><dl> <dt><b>1</b></dt> </dl> </td> <td width="60%"> Return the global
///            group name and a comment. The <i>bufptr</i> parameter points to a GROUP_INFO_1 structure. </td> </tr> <tr> <td
///            width="40%"><a id="2"></a><dl> <dt><b>2</b></dt> </dl> </td> <td width="60%"> Return detailed information about
///            the global group. The <i>bufptr</i> parameter points to a GROUP_INFO_2 structure. Note that on Windows XP and
///            later, it is recommended that you use GROUP_INFO_3 instead. </td> </tr> <tr> <td width="40%"><a id="3"></a><dl>
///            <dt><b>3</b></dt> </dl> </td> <td width="60%"> Return detailed information about the global group. The
///            <i>bufptr</i> parameter points to a GROUP_INFO_3 structure. <b>Windows 2000: </b>This level is not supported.
///            </td> </tr> </table>
///    bufptr = Pointer to the address of the buffer that receives the global group information structure. The format of this
///             data depends on the value of the <i>level</i> parameter. The system allocates the memory for this buffer. You
///             must call the NetApiBufferFree function to deallocate the memory. For more information, see Network Management
///             Function Buffers and Network Management Function Buffer Lengths.
///Returns:
///    If the function succeeds, the return value is NERR_Success. If the function fails, the return value can be one of
///    the following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
///    <dl> <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> The user does not have access to the
///    requested information. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>NERR_InvalidComputer</b></dt> </dl> </td>
///    <td width="60%"> The computer name is invalid. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>NERR_GroupNotFound</b></dt> </dl> </td> <td width="60%"> The global group name could not be found. </td>
///    </tr> </table>
///    
@DllImport("samcli")
uint NetGroupGetInfo(const(PWSTR) servername, const(PWSTR) groupname, uint level, ubyte** bufptr);

///The <b>NetGroupSetInfo</b> function sets the parameters of a global group in the security database, which is the
///security accounts manager (SAM) database or, in the case of domain controllers, the Active Directory.
///Params:
///    servername = Pointer to a constant string that specifies the DNS or NetBIOS name of the remote server on which the function is
///                 to execute. If this parameter is <b>NULL</b>, the local computer is used.
///    groupname = Pointer to a constant string that specifies the name of the global group for which to set information. For more
///                information, see the following Remarks section.
///    level = Specifies the information level of the data. This parameter can be one of the following values. <table> <tr>
///            <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="0"></a><dl> <dt><b>0</b></dt> </dl> </td> <td
///            width="60%"> Specifies a global group name. The <i>buf</i> parameter points to a GROUP_INFO_0 structure. </td>
///            </tr> <tr> <td width="40%"><a id="1"></a><dl> <dt><b>1</b></dt> </dl> </td> <td width="60%"> Specifies a global
///            group name and a comment. The <i>buf</i> parameter points to a GROUP_INFO_1 structure. </td> </tr> <tr> <td
///            width="40%"><a id="2"></a><dl> <dt><b>2</b></dt> </dl> </td> <td width="60%"> Specifies detailed information
///            about the global group. The <i>buf</i> parameter points to a GROUP_INFO_2 structure. Note that on Windows XP and
///            later, it is recommended that you use GROUP_INFO_3 instead. </td> </tr> <tr> <td width="40%"><a id="3"></a><dl>
///            <dt><b>3</b></dt> </dl> </td> <td width="60%"> Specifies detailed information about the global group. The
///            <i>buf</i> parameter points to a GROUP_INFO_3 structure. <b>Windows 2000: </b>This level is not supported. </td>
///            </tr> <tr> <td width="40%"><a id="1002"></a><dl> <dt><b>1002</b></dt> </dl> </td> <td width="60%"> Specifies a
///            comment only about the global group. The <i>buf</i> parameter points to a GROUP_INFO_1002 structure. </td> </tr>
///            <tr> <td width="40%"><a id="1005"></a><dl> <dt><b>1005</b></dt> </dl> </td> <td width="60%"> Specifies global
///            group attributes. The <i>buf</i> parameter points to a GROUP_INFO_1005 structure. </td> </tr> </table> For more
///            information, see the following Remarks section.
///    buf = Pointer to a buffer that contains the data. The format of this data depends on the value of the <i>level</i>
///          parameter. For more information, see Network Management Function Buffers.
///    parm_err = Pointer to a value that receives the index of the first member of the group information structure in error
///               following an ERROR_INVALID_PARAMETER error code. If this parameter is <b>NULL</b>, the index is not returned on
///               error. For more information, see the following Remarks section.
///Returns:
///    If the function succeeds, the return value is NERR_Success. If the function fails, the return value can be one of
///    the following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
///    <dl> <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> The user does not have access to the
///    requested information. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td>
///    <td width="60%"> One of the function parameters is invalid. For more information, see the following Remarks
///    section. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>NERR_InvalidComputer</b></dt> </dl> </td> <td width="60%">
///    The computer name is invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>NERR_NotPrimary</b></dt> </dl> </td>
///    <td width="60%"> The operation is allowed only on the primary domain controller of the domain. </td> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>NERR_GroupNotFound</b></dt> </dl> </td> <td width="60%"> The global group name could
///    not be found. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>NERR_SpeGroupOp</b></dt> </dl> </td> <td width="60%">
///    The operation is not allowed on certain special groups. These groups include user groups, admin groups, local
///    groups, and guest groups. </td> </tr> </table>
///    
@DllImport("samcli")
uint NetGroupSetInfo(const(PWSTR) servername, const(PWSTR) groupname, uint level, ubyte* buf, uint* parm_err);

///The <b>NetGroupDel</b> function deletes a global group from the security database, which is the security accounts
///manager (SAM) database or, in the case of domain controllers, the Active Directory.
///Params:
///    servername = Pointer to a constant string that specifies the DNS or NetBIOS name of the remote server on which the function is
///                 to execute. If this parameter is <b>NULL</b>, the local computer is used.
///    groupname = Pointer to a constant string that specifies the name of the global group account to delete. For more information,
///                see the following Remarks section.
///Returns:
///    If the function succeeds, the return value is NERR_Success. If the function fails, the return value can be one of
///    the following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
///    <dl> <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> The user does not have access to the
///    requested information. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>NERR_InvalidComputer</b></dt> </dl> </td>
///    <td width="60%"> The computer name is invalid. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>NERR_NotPrimary</b></dt> </dl> </td> <td width="60%"> The operation is allowed only on the primary domain
///    controller of the domain. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>NERR_SpeGroupOp</b></dt> </dl> </td> <td
///    width="60%"> The operation is not allowed on certain special groups. These groups include user groups, admin
///    groups, local groups, and guest groups. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>NERR_GroupNotFound</b></dt>
///    </dl> </td> <td width="60%"> The global group name could not be found. </td> </tr> </table>
///    
@DllImport("samcli")
uint NetGroupDel(const(PWSTR) servername, const(PWSTR) groupname);

///The <b>NetGroupDelUser</b> function removes a user from a particular global group in the security database, which is
///the security accounts manager (SAM) database or, in the case of domain controllers, the Active Directory.
///Params:
///    servername = Pointer to a constant string that specifies the DNS or NetBIOS name of the remote server on which the function is
///                 to execute. If this parameter is <b>NULL</b>, the local computer is used.
///    GroupName = Pointer to a constant string that specifies the name of the global group from which the user's membership should
///                be removed. For more information, see the following Remarks section.
///    Username = Pointer to a constant string that specifies the name of the user to remove from the global group. For more
///               information, see the following Remarks section.
///Returns:
///    If the function succeeds, the return value is NERR_Success. If the function fails, the return value can be one of
///    the following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
///    <dl> <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> The user does not have access to the
///    requested information. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>NERR_InvalidComputer</b></dt> </dl> </td>
///    <td width="60%"> The computer name is invalid. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>NERR_NotPrimary</b></dt> </dl> </td> <td width="60%"> The operation is allowed only on the primary domain
///    controller of the domain. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>NERR_SpeGroupOp</b></dt> </dl> </td> <td
///    width="60%"> The operation is not allowed on certain special groups. These groups include user groups, admin
///    groups, local groups, and guest groups. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>NERR_UserNotFound</b></dt>
///    </dl> </td> <td width="60%"> The user name could not be found. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>NERR_GroupNotFound</b></dt> </dl> </td> <td width="60%"> The global group name could not be found. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>NERR_UserNotInGroup</b></dt> </dl> </td> <td width="60%"> The user does
///    not belong to this global group. </td> </tr> </table>
///    
@DllImport("samcli")
uint NetGroupDelUser(const(PWSTR) servername, const(PWSTR) GroupName, const(PWSTR) Username);

///The <b>NetGroupGetUsers</b> function retrieves a list of the members in a particular global group in the security
///database, which is the security accounts manager (SAM) database or, in the case of domain controllers, the Active
///Directory.
///Params:
///    servername = A pointer to a constant string that specifies the DNS or NetBIOS name of the remote server on which the function
///                 is to execute. If this parameter is <b>NULL</b>, the local computer is used.
///    groupname = A pointer to a constant string that specifies the name of the global group whose members are to be listed. For
///                more information, see the following Remarks section.
///    level = The information level of the data requested. This parameter can be one of the following values. <table> <tr>
///            <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="0"></a><dl> <dt><b>0</b></dt> </dl> </td> <td
///            width="60%"> Return the global group's member names. The <i>bufptr</i> parameter points to an array of
///            GROUP_USERS_INFO_0 structures. </td> </tr> <tr> <td width="40%"><a id="1"></a><dl> <dt><b>1</b></dt> </dl> </td>
///            <td width="60%"> Return the global group's member names and attributes. The <i>bufptr</i> parameter points to an
///            array of GROUP_USERS_INFO_1 structures. </td> </tr> </table>
///    bufptr = A pointer to the address of the buffer that receives the information structure. The system allocates the memory
///             for this buffer. You must call the NetApiBufferFree function to deallocate the memory. Note that you must free
///             the buffer even if the function fails with ERROR_MORE_DATA.
///    prefmaxlen = The preferred maximum length of the returned data, in bytes. If you specify MAX_PREFERRED_LENGTH, the function
///                 allocates the amount of memory required to hold the data. If you specify another value in this parameter, it can
///                 restrict the number of bytes that the function returns. If the buffer size is insufficient to hold all entries,
///                 the function returns ERROR_MORE_DATA. For more information, see Network Management Function Buffers and Network
///                 Management Function Buffer Lengths.
///    entriesread = A pointer to a value that receives the count of elements actually enumerated.
///    totalentries = A pointer to a value that receives the total number of entries that could have been enumerated from the current
///                   resume position.
///    ResumeHandle = A pointer to a variable that contains a resume handle that is used to continue an existing user enumeration. The
///                   handle should be zero on the first call and left unchanged for subsequent calls. If <i>ResumeHandle</i> parameter
///                   is <b>NULL</b>, no resume handle is stored.
///Returns:
///    If the function succeeds, the return value is NERR_Success. If the function fails, the return value can be one of
///    the following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
///    <dl> <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> The user does not have access to the
///    requested information. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_LEVEL</b></dt> </dl> </td> <td
///    width="60%"> The system call level is not correct. This error is returned if the <i>level</i> parameter was
///    specified as a value other than 0 or 1. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_MORE_DATA</b></dt>
///    </dl> </td> <td width="60%"> More entries are available. Specify a large enough buffer to receive all entries.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NOT_ENOUGH_MEMORY</b></dt> </dl> </td> <td width="60%">
///    Insufficient memory was available to complete the operation. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>NERR_InvalidComputer</b></dt> </dl> </td> <td width="60%"> The computer name is invalid. </td> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>NERR_GroupNotFound</b></dt> </dl> </td> <td width="60%"> The global group name in
///    the structure pointed to by <i>bufptr</i> parameter could not be found. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>NERR_InternalError</b></dt> </dl> </td> <td width="60%"> An internal error occurred. </td> </tr> </table>
///    
@DllImport("samcli")
uint NetGroupGetUsers(const(PWSTR) servername, const(PWSTR) groupname, uint level, ubyte** bufptr, uint prefmaxlen, 
                      uint* entriesread, uint* totalentries, size_t* ResumeHandle);

///The <b>NetGroupSetUsers</b> function sets the membership for the specified global group. Each user you specify is
///enrolled as a member of the global group. Users you do not specify, but who are currently members of the global
///group, will have their membership revoked.
///Params:
///    servername = A pointer to a constant string that specifies the DNS or NetBIOS name of the remote server on which the function
///                 is to execute. If this parameter is <b>NULL</b>, the local computer is used.
///    groupname = A pointer to a constant string that specifies the name of the global group of interest. For more information, see
///                the Remarks section.
///    level = The information level of the data. This parameter can be one of the following values. <table> <tr> <th>Value</th>
///            <th>Meaning</th> </tr> <tr> <td width="40%"><a id="0"></a><dl> <dt><b>0</b></dt> </dl> </td> <td width="60%"> The
///            <i>buf</i> parameter points to an array of GROUP_USERS_INFO_0 structures that specify user names. </td> </tr>
///            <tr> <td width="40%"><a id="1"></a><dl> <dt><b>1</b></dt> </dl> </td> <td width="60%"> The <i>buf</i> parameter
///            points to an array of GROUP_USERS_INFO_1 structures that specifies user names and the attributes of the group.
///            </td> </tr> </table>
///    buf = A pointer to the buffer that contains the data. For more information, see Network Management Function Buffers.
///    totalentries = The number of entries in the buffer pointed to by the <i>buf</i> parameter.
///Returns:
///    If the function succeeds, the return value is NERR_Success. If the function fails, the return value can be one of
///    the following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
///    <dl> <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> The user does not have access to the
///    requested information. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_LEVEL</b></dt> </dl> </td> <td
///    width="60%"> The system call level is not correct. This error is returned if the <i>level</i> parameter was
///    specified as a value other than 0 or 1. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> A parameter passed was not valid. This error
///    is returned if the <i>totalentries</i> parameter was not valid. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_NOT_ENOUGH_MEMORY</b></dt> </dl> </td> <td width="60%"> Insufficient memory was available to
///    complete the operation. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>NERR_InvalidComputer</b></dt> </dl> </td>
///    <td width="60%"> The computer name is invalid. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>NERR_NotPrimary</b></dt> </dl> </td> <td width="60%"> The operation is allowed only on the primary domain
///    controller of the domain. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>NERR_GroupNotFound</b></dt> </dl> </td>
///    <td width="60%"> The global group name could not be found. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>NERR_InternalError</b></dt> </dl> </td> <td width="60%"> An internal error occurred. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>NERR_SpeGroupOp</b></dt> </dl> </td> <td width="60%"> The operation is not allowed on
///    certain special groups. These groups include user groups, admin groups, local groups, and guest groups. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>NERR_UserNotFound</b></dt> </dl> </td> <td width="60%"> The user name
///    could not be found. </td> </tr> </table>
///    
@DllImport("samcli")
uint NetGroupSetUsers(const(PWSTR) servername, const(PWSTR) groupname, uint level, ubyte* buf, uint totalentries);

///The <b>NetLocalGroupAdd</b> function creates a local group in the security database, which is the security accounts
///manager (SAM) database or, in the case of domain controllers, the Active Directory.
///Params:
///    servername = A pointer to a string that specifies the DNS or NetBIOS name of the remote server on which the function is to
///                 execute. If this parameter is <b>NULL</b>, the local computer is used.
///    level = The information level of the data. This parameter can be one of the following values. <table> <tr> <th>Value</th>
///            <th>Meaning</th> </tr> <tr> <td width="40%"><a id="0"></a><dl> <dt><b>0</b></dt> </dl> </td> <td width="60%"> A
///            local group name. The <i>buf</i> parameter points to a LOCALGROUP_INFO_0 structure. </td> </tr> <tr> <td
///            width="40%"><a id="1"></a><dl> <dt><b>1</b></dt> </dl> </td> <td width="60%"> A local group name and a comment to
///            associate with the group. The <i>buf</i> parameter points to a LOCALGROUP_INFO_1 structure. </td> </tr> </table>
///    buf = A pointer to a buffer that contains the local group information structure. The format of this data depends on the
///          value of the <i>level</i> parameter. For more information, see Network Management Function Buffers.
///    parm_err = A pointer to a value that receives the index of the first member of the local group information structure to
///               cause the ERROR_INVALID_PARAMETER error. If this parameter is <b>NULL</b>, the index is not returned on error.
///               For more information, see the Remarks section in the NetLocalGroupSetInfo topic.
///Returns:
///    If the function succeeds, the return value is NERR_Success. If the function fails, the return value can be one of
///    the following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
///    <dl> <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> The caller does not have the appropriate
///    access to complete the operation. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_ALIAS_EXISTS</b></dt> </dl>
///    </td> <td width="60%"> The specified local group already exists. This error is returned if the group name member
///    in the structure pointed to by the <i>buf</i> parameter is already in use as an alias. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_INVALID_LEVEL</b></dt> </dl> </td> <td width="60%"> A <i>level</i> parameter is
///    invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td
///    width="60%"> A parameter is incorrect. This error is returned if one or more of the members in the structure
///    pointed to by the <i>buf</i> parameter is invalid. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>NERR_GroupExists</b></dt> </dl> </td> <td width="60%"> The group name exists. This error is returned if
///    the group name member in the structure pointed to by the <i>buf</i> parameter is already in use as a group name.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>NERR_InvalidComputer</b></dt> </dl> </td> <td width="60%"> The
///    computer name is invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>NERR_NotPrimary</b></dt> </dl> </td> <td
///    width="60%"> The operation is allowed only on the primary domain controller of the domain. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>NERR_UserExists</b></dt> </dl> </td> <td width="60%"> The user name exists. This error
///    is returned if the group name member in the structure pointed to by the <i>buf</i> parameter is already in use as
///    a user name. </td> </tr> </table>
///    
@DllImport("samcli")
uint NetLocalGroupAdd(const(PWSTR) servername, uint level, ubyte* buf, uint* parm_err);

///The <b>NetLocalGroupAddMember</b> function is obsolete. You should use the NetLocalGroupAddMembers function instead.
///Params:
///    servername = TBD
///    groupname = TBD
@DllImport("samcli")
uint NetLocalGroupAddMember(const(PWSTR) servername, const(PWSTR) groupname, void* membersid);

///The <b>NetLocalGroupEnum</b> function returns information about each local group account on the specified server.
///Params:
///    servername = Pointer to a constant string that specifies the DNS or NetBIOS name of the remote server on which the function is
///                 to execute. If this parameter is <b>NULL</b>, the local computer is used.
///    level = Specifies the information level of the data. This parameter can be one of the following values. <table> <tr>
///            <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="0"></a><dl> <dt><b>0</b></dt> </dl> </td> <td
///            width="60%"> Return local group names. The <i>bufptr</i> parameter points to an array of LOCALGROUP_INFO_0
///            structures. </td> </tr> <tr> <td width="40%"><a id="1"></a><dl> <dt><b>1</b></dt> </dl> </td> <td width="60%">
///            Return local group names and the comment associated with each group. The <i>bufptr</i> parameter points to an
///            array of LOCALGROUP_INFO_1 structures. </td> </tr> </table>
///    bufptr = Pointer to the address of the buffer that receives the information structure. The format of this data depends on
///             the value of the <i>level</i> parameter. This buffer is allocated by the system and must be freed using the
///             NetApiBufferFree function. Note that you must free the buffer even if the function fails with ERROR_MORE_DATA.
///    prefmaxlen = Specifies the preferred maximum length of returned data, in bytes. If you specify MAX_PREFERRED_LENGTH, the
///                 function allocates the amount of memory required for the data. If you specify another value in this parameter, it
///                 can restrict the number of bytes that the function returns. If the buffer size is insufficient to hold all
///                 entries, the function returns ERROR_MORE_DATA. For more information, see Network Management Function Buffers and
///                 Network Management Function Buffer Lengths.
///    entriesread = Pointer to a value that receives the count of elements actually enumerated.
///    totalentries = Pointer to a value that receives the approximate total number of entries that could have been enumerated from the
///                   current resume position. The total number of entries is only a hint. For more information about determining the
///                   exact number of entries, see the following Remarks section.
///    resumehandle = Pointer to a value that contains a resume handle that is used to continue an existing local group search. The
///                   handle should be zero on the first call and left unchanged for subsequent calls. If this parameter is
///                   <b>NULL</b>, then no resume handle is stored. For more information, see the following Remarks section.
///Returns:
///    If the function succeeds, the return value is NERR_Success. If the function fails, the return value can be one of
///    the following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
///    <dl> <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> The user does not have access to the
///    requested information. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_MORE_DATA</b></dt> </dl> </td> <td
///    width="60%"> More entries are available. Specify a large enough buffer to receive all entries. </td> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>NERR_InvalidComputer</b></dt> </dl> </td> <td width="60%"> The computer name is
///    invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>NERR_BufTooSmall</b></dt> </dl> </td> <td width="60%"> The
///    return buffer is too small. </td> </tr> </table>
///    
@DllImport("samcli")
uint NetLocalGroupEnum(const(PWSTR) servername, uint level, ubyte** bufptr, uint prefmaxlen, uint* entriesread, 
                       uint* totalentries, size_t* resumehandle);

///The <b>NetLocalGroupGetInfo</b> function retrieves information about a particular local group account on a server.
///Params:
///    servername = Pointer to a constant string that specifies the DNS or NetBIOS name of the remote server on which the function is
///                 to execute. If this parameter is <b>NULL</b>, the local computer is used.
///    groupname = Pointer to a constant string that specifies the name of the local group account for which the information will be
///                retrieved. For more information, see the following Remarks section.
///    level = Specifies the information level of the data. This parameter can be the following value. <table> <tr>
///            <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="1"></a><dl> <dt><b>1</b></dt> </dl> </td> <td
///            width="60%"> Return the comment associated with the local group. The <i>bufptr</i> parameter points to a
///            LOCALGROUP_INFO_1 structure. </td> </tr> </table>
///    bufptr = Pointer to the address of the buffer that receives the return information structure. This buffer is allocated by
///             the system and must be freed using the NetApiBufferFree function. For more information, see Network Management
///             Function Buffers and Network Management Function Buffer Lengths.
///Returns:
///    If the function succeeds, the return value is NERR_Success. If the function fails, the return value can be one of
///    the following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
///    <dl> <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> The user does not have access to the
///    requested information. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>NERR_InvalidComputer</b></dt> </dl> </td>
///    <td width="60%"> The computer name is invalid. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>NERR_GroupNotFound</b></dt> </dl> </td> <td width="60%"> The specified local group does not exist. </td>
///    </tr> </table>
///    
@DllImport("samcli")
uint NetLocalGroupGetInfo(const(PWSTR) servername, const(PWSTR) groupname, uint level, ubyte** bufptr);

///The <b>NetLocalGroupSetInfo</b> function changes the name of an existing local group. The function also associates a
///comment with a local group.
///Params:
///    servername = Pointer to a constant string that specifies the DNS or NetBIOS name of the remote server on which the function is
///                 to execute. If this parameter is <b>NULL</b>, the local computer is used.
///    groupname = Pointer to a constant string that specifies the name of the local group account to modify. For more information,
///                see the following Remarks section.
///    level = Specifies the information level of the data. This parameter can be one of the following values. <table> <tr>
///            <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="0"></a><dl> <dt><b>0</b></dt> </dl> </td> <td
///            width="60%"> Specifies the local group name. The <i>buf</i> parameter points to a LOCALGROUP_INFO_0 structure.
///            Use this level to change the name of an existing local group. </td> </tr> <tr> <td width="40%"><a id="1"></a><dl>
///            <dt><b>1</b></dt> </dl> </td> <td width="60%"> Specifies the local group name and a comment to associate with the
///            group. The <i>buf</i> parameter points to a LOCALGROUP_INFO_1 structure. </td> </tr> <tr> <td width="40%"><a
///            id="1002"></a><dl> <dt><b>1002</b></dt> </dl> </td> <td width="60%"> Specifies a comment to associate with the
///            local group. The <i>buf</i> parameter points to a LOCALGROUP_INFO_1002 structure. </td> </tr> </table>
///    buf = Pointer to a buffer that contains the local group information. The format of this data depends on the value of
///          the <i>level</i> parameter. For more information, see Network Management Function Buffers.
///    parm_err = Pointer to a value that receives the index of the first member of the local group information structure that
///               caused the ERROR_INVALID_PARAMETER error. If this parameter is <b>NULL</b>, the index is not returned on error.
///               For more information, see the following Remarks section.
///Returns:
///    If the function succeeds, the return value is NERR_Success. If the function fails, the return value can be one of
///    the following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
///    <dl> <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> The user does not have access to the
///    requested information. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td>
///    <td width="60%"> One of the function parameters is invalid. For more information, see the following Remarks
///    section. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NO_SUCH_ALIAS</b></dt> </dl> </td> <td width="60%">
///    The specified local group does not exist. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>NERR_NotPrimary</b></dt>
///    </dl> </td> <td width="60%"> The operation is allowed only on the primary domain controller of the domain. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>NERR_InvalidComputer</b></dt> </dl> </td> <td width="60%"> The computer
///    name is invalid. </td> </tr> </table>
///    
@DllImport("samcli")
uint NetLocalGroupSetInfo(const(PWSTR) servername, const(PWSTR) groupname, uint level, ubyte* buf, uint* parm_err);

///The <b>NetLocalGroupDel</b> function deletes a local group account and all its members from the security database,
///which is the security accounts manager (SAM) database or, in the case of domain controllers, the Active Directory.
///Params:
///    servername = Pointer to a constant string that specifies the DNS or NetBIOS name of the remote server on which the function is
///                 to execute. If this parameter is <b>NULL</b>, the local computer is used.
///    groupname = Pointer to a constant string that specifies the name of the local group account to delete. For more information,
///                see the following Remarks section.
///Returns:
///    If the function succeeds, the return value is NERR_Success. If the function fails, the return value can be one of
///    the following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
///    <dl> <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> The user does not have access to the
///    requested information. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>NERR_InvalidComputer</b></dt> </dl> </td>
///    <td width="60%"> The computer name is invalid. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>NERR_NotPrimary</b></dt> </dl> </td> <td width="60%"> The operation is allowed only on the primary domain
///    controller of the domain. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>NERR_GroupNotFound</b></dt> </dl> </td>
///    <td width="60%"> The local group specified by the <i>groupname</i> parameter does not exist. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_NO_SUCH_ALIAS</b></dt> </dl> </td> <td width="60%"> The specified local group does
///    not exist. </td> </tr> </table>
///    
@DllImport("samcli")
uint NetLocalGroupDel(const(PWSTR) servername, const(PWSTR) groupname);

///The <b>NetLocalGroupDelMember</b> function is obsolete. You should use the NetLocalGroupDelMembers function instead.
///Params:
///    servername = TBD
///    groupname = TBD
@DllImport("samcli")
uint NetLocalGroupDelMember(const(PWSTR) servername, const(PWSTR) groupname, void* membersid);

///The <b>NetLocalGroupGetMembers</b> function retrieves a list of the members of a particular local group in the
///security database, which is the security accounts manager (SAM) database or, in the case of domain controllers, the
///Active Directory. Local group members can be users or global groups.
///Params:
///    servername = Pointer to a constant string that specifies the DNS or NetBIOS name of the remote server on which the function is
///                 to execute. If this parameter is <b>NULL</b>, the local computer is used.
///    localgroupname = Pointer to a constant string that specifies the name of the local group whose members are to be listed. For more
///                     information, see the following Remarks section.
///    level = Specifies the information level of the data. This parameter can be one of the following values. <table> <tr>
///            <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="0"></a><dl> <dt><b>0</b></dt> </dl> </td> <td
///            width="60%"> Return the security identifier (SID) associated with the local group member. The <i>bufptr</i>
///            parameter points to an array of LOCALGROUP_MEMBERS_INFO_0 structures. </td> </tr> <tr> <td width="40%"><a
///            id="1"></a><dl> <dt><b>1</b></dt> </dl> </td> <td width="60%"> Return the SID and account information associated
///            with the local group member. The <i>bufptr</i> parameter points to an array of LOCALGROUP_MEMBERS_INFO_1
///            structures. </td> </tr> <tr> <td width="40%"><a id="2"></a><dl> <dt><b>2</b></dt> </dl> </td> <td width="60%">
///            Return the SID, account information, and the domain name associated with the local group member. The
///            <i>bufptr</i> parameter points to an array of LOCALGROUP_MEMBERS_INFO_2 structures. </td> </tr> <tr> <td
///            width="40%"><a id="3"></a><dl> <dt><b>3</b></dt> </dl> </td> <td width="60%"> Return the account and domain names
///            of the local group member. The <i>bufptr</i> parameter points to an array of LOCALGROUP_MEMBERS_INFO_3
///            structures. </td> </tr> </table>
///    bufptr = Pointer to the address that receives the return information structure. The format of this data depends on the
///             value of the <i>level</i> parameter. This buffer is allocated by the system and must be freed using the
///             NetApiBufferFree function. Note that you must free the buffer even if the function fails with ERROR_MORE_DATA.
///    prefmaxlen = Specifies the preferred maximum length of returned data, in bytes. If you specify MAX_PREFERRED_LENGTH, the
///                 function allocates the amount of memory required for the data. If you specify another value in this parameter, it
///                 can restrict the number of bytes that the function returns. If the buffer size is insufficient to hold all
///                 entries, the function returns ERROR_MORE_DATA. For more information, see Network Management Function Buffers and
///                 Network Management Function Buffer Lengths.
///    entriesread = Pointer to a value that receives the count of elements actually enumerated.
///    totalentries = Pointer to a value that receives the total number of entries that could have been enumerated from the current
///                   resume position.
///    resumehandle = Pointer to a value that contains a resume handle which is used to continue an existing group member search. The
///                   handle should be zero on the first call and left unchanged for subsequent calls. If this parameter is
///                   <b>NULL</b>, then no resume handle is stored.
///Returns:
///    If the function succeeds, the return value is NERR_Success. If the function fails, the return value can be one of
///    the following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
///    <dl> <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> The user does not have access to the
///    requested information. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>NERR_InvalidComputer</b></dt> </dl> </td>
///    <td width="60%"> The computer name is invalid. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_MORE_DATA</b></dt> </dl> </td> <td width="60%"> More entries are available. Specify a large enough
///    buffer to receive all entries. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NO_SUCH_ALIAS</b></dt> </dl>
///    </td> <td width="60%"> The specified local group does not exist. </td> </tr> </table>
///    
@DllImport("samcli")
uint NetLocalGroupGetMembers(const(PWSTR) servername, const(PWSTR) localgroupname, uint level, ubyte** bufptr, 
                             uint prefmaxlen, uint* entriesread, uint* totalentries, size_t* resumehandle);

///The <b>NetLocalGroupSetMembers</b> function sets the membership for the specified local group. Each user or global
///group specified is made a member of the local group. Users or global groups that are not specified but who are
///currently members of the local group will have their membership revoked.
///Params:
///    servername = Pointer to a constant string that specifies the DNS or NetBIOS name of the remote server on which the function is
///                 to execute. If this parameter is <b>NULL</b>, the local computer is used.
///    groupname = Pointer to a constant string that specifies the name of the local group in which the specified users or global
///                groups should be granted membership. For more information, see the following Remarks section.
///    level = Specifies the information level of the data. This parameter can be one of the following values. <table> <tr>
///            <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="0"></a><dl> <dt><b>0</b></dt> </dl> </td> <td
///            width="60%"> Specifies the security identifier (SID) associated with a local group member. The <i>buf</i>
///            parameter points to an array of LOCALGROUP_MEMBERS_INFO_0 structures. </td> </tr> <tr> <td width="40%"><a
///            id="3"></a><dl> <dt><b>3</b></dt> </dl> </td> <td width="60%"> Specifies the account and domain names of the
///            local group member. The <i>buf</i> parameter points to an array of LOCALGROUP_MEMBERS_INFO_3 structures. </td>
///            </tr> </table>
///    buf = Pointer to the buffer that contains the member information. The format of this data depends on the value of the
///          <i>level</i> parameter. For more information, see Network Management Function Buffers.
///    totalentries = Specifies a value that contains the total number of entries in the buffer pointed to by the <i>buf</i> parameter.
///Returns:
///    If the function succeeds, the return value is NERR_Success. If the function fails, the return value can be one of
///    the following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
///    <dl> <dt><b>NERR_GroupNotFound</b></dt> </dl> </td> <td width="60%"> The group specified by the <i>groupname</i>
///    parameter does not exist. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td>
///    <td width="60%"> The user does not have access to the requested information. </td> </tr> <tr> <td width="40%">
///    <dl> <dt><b>ERROR_NO_SUCH_MEMBER</b></dt> </dl> </td> <td width="60%"> One or more of the members doesn't exist.
///    The local group membership was not changed. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_MEMBER</b></dt> </dl> </td> <td width="60%"> One or more of the members cannot be added
///    because it has an invalid account type. The local group membership was not changed. </td> </tr> </table>
///    
@DllImport("samcli")
uint NetLocalGroupSetMembers(const(PWSTR) servername, const(PWSTR) groupname, uint level, ubyte* buf, 
                             uint totalentries);

///The <b>NetLocalGroupAddMembers</b> function adds membership of one or more existing user accounts or global group
///accounts to an existing local group. The function does not change the membership status of users or global groups
///that are currently members of the local group.
///Params:
///    servername = Pointer to a constant string that specifies the DNS or NetBIOS name of the remote server on which the function is
///                 to execute. If this parameter is <b>NULL</b>, the local computer is used.
///    groupname = Pointer to a constant string that specifies the name of the local group to which the specified users or global
///                groups will be added. For more information, see the following Remarks section.
///    level = Specifies the information level of the data. This parameter can be one of the following values. <table> <tr>
///            <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="0"></a><dl> <dt><b>0</b></dt> </dl> </td> <td
///            width="60%"> Specifies the security identifier (SID) of the new local group member. The <i>buf</i> parameter
///            points to an array of LOCALGROUP_MEMBERS_INFO_0 structures. </td> </tr> <tr> <td width="40%"><a id="3"></a><dl>
///            <dt><b>3</b></dt> </dl> </td> <td width="60%"> Specifies the domain and name of the new local group member. The
///            <i>buf</i> parameter points to an array of LOCALGROUP_MEMBERS_INFO_3 structures. </td> </tr> </table>
///    buf = Pointer to a buffer that contains the data for the new local group members. The format of this data depends on
///          the value of the <i>level</i> parameter. For more information, see Network Management Function Buffers.
///    totalentries = Specifies the number of entries in the buffer pointed to by the <i>buf</i> parameter.
///Returns:
///    If the function succeeds, the return value is NERR_Success. If the function fails, the return value can be one of
///    the following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
///    <dl> <dt><b>NERR_GroupNotFound</b></dt> </dl> </td> <td width="60%"> The local group specified by the
///    <i>groupname</i> parameter does not exist. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> The user does not have access to the requested
///    information. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NO_SUCH_MEMBER</b></dt> </dl> </td> <td
///    width="60%"> One or more of the members specified do not exist. Therefore, no new members were added. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>ERROR_MEMBER_IN_ALIAS</b></dt> </dl> </td> <td width="60%"> One or more of the
///    members specified were already members of the local group. No new members were added. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_INVALID_MEMBER</b></dt> </dl> </td> <td width="60%"> One or more of the members
///    cannot be added because their account type is invalid. No new members were added. </td> </tr> </table>
///    
@DllImport("samcli")
uint NetLocalGroupAddMembers(const(PWSTR) servername, const(PWSTR) groupname, uint level, ubyte* buf, 
                             uint totalentries);

///The <b>NetLocalGroupDelMembers</b> function removes one or more members from an existing local group. Local group
///members can be users or global groups.
///Params:
///    servername = Pointer to a constant string that specifies the DNS or NetBIOS name of the remote server on which the function is
///                 to execute. If this parameter is <b>NULL</b>, the local computer is used.
///    groupname = Pointer to a constant string that specifies the name of the local group from which the specified users or global
///                groups will be removed. For more information, see the following Remarks section.
///    level = Specifies the information level of the data. This parameter can be one of the following values. <table> <tr>
///            <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="0"></a><dl> <dt><b>0</b></dt> </dl> </td> <td
///            width="60%"> Specifies the security identifier (SID) of a local group member to remove. The <i>buf</i> parameter
///            points to an array of LOCALGROUP_MEMBERS_INFO_0 structures. </td> </tr> <tr> <td width="40%"><a id="3"></a><dl>
///            <dt><b>3</b></dt> </dl> </td> <td width="60%"> Specifies the domain and name of a local group member to remove.
///            The <i>buf</i> parameter points to an array of LOCALGROUP_MEMBERS_INFO_3 structures. </td> </tr> </table>
///    buf = Pointer to a buffer that specifies the members to be removed. The format of this data depends on the value of the
///          <i>level</i> parameter. For more information, see Network Management Function Buffers.
///    totalentries = Specifies the number of entries in the array pointed to by the <i>buf</i> parameter.
///Returns:
///    If the function succeeds, the return value is NERR_Success. If the function fails, the return value can be one of
///    the following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
///    <dl> <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> The user does not have access to the
///    requested information. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>NERR_GroupNotFound</b></dt> </dl> </td> <td
///    width="60%"> The local group specified by the <i>groupname</i> parameter does not exist. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_NO_SUCH_MEMBER</b></dt> </dl> </td> <td width="60%"> One or more of the specified
///    members do not exist. No members were deleted. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_MEMBER_NOT_IN_ALIAS</b></dt> </dl> </td> <td width="60%"> One or more of the members specified were
///    not members of the local group. No members were deleted. </td> </tr> </table>
///    
@DllImport("samcli")
uint NetLocalGroupDelMembers(const(PWSTR) servername, const(PWSTR) groupname, uint level, ubyte* buf, 
                             uint totalentries);

///The <b>NetQueryDisplayInformation</b> function returns user account, computer, or group account information. Call
///this function to quickly enumerate account information for display in user interfaces.
///Params:
///    ServerName = Pointer to a constant string that specifies the DNS or NetBIOS name of the remote server on which the function is
///                 to execute. If this parameter is <b>NULL</b>, the local computer is used.
///    Level = Specifies the information level of the data. This parameter can be one of the following values. <table> <tr>
///            <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="1"></a><dl> <dt><b>1</b></dt> </dl> </td> <td
///            width="60%"> Return user account information. The <i>SortedBuffer</i> parameter points to an array of
///            NET_DISPLAY_USER structures. </td> </tr> <tr> <td width="40%"><a id="2"></a><dl> <dt><b>2</b></dt> </dl> </td>
///            <td width="60%"> Return individual computer information. The <i>SortedBuffer</i> parameter points to an array of
///            NET_DISPLAY_MACHINE structures. </td> </tr> <tr> <td width="40%"><a id="3"></a><dl> <dt><b>3</b></dt> </dl> </td>
///            <td width="60%"> Return group account information. The <i>SortedBuffer</i> parameter points to an array of
///            NET_DISPLAY_GROUP structures. </td> </tr> </table>
///    Index = Specifies the index of the first entry for which to retrieve information. Specify zero to retrieve account
///            information beginning with the first display information entry. For more information, see the following Remarks
///            section.
///    EntriesRequested = Specifies the maximum number of entries for which to retrieve information. On Windows 2000 and later, each call
///                       to <b>NetQueryDisplayInformation</b> returns a maximum of 100 objects.
///    PreferredMaximumLength = Specifies the preferred maximum size, in bytes, of the system-allocated buffer returned in the
///                             <i>SortedBuffer</i> parameter. It is recommended that you set this parameter to MAX_PREFERRED_LENGTH.
///    ReturnedEntryCount = Pointer to a value that receives the number of entries in the buffer returned in the <i>SortedBuffer</i>
///                         parameter. If this parameter is zero, there are no entries with an index as large as that specified. Entries may
///                         be returned when the function's return value is either NERR_Success or ERROR_MORE_DATA.
///    SortedBuffer = Pointer to a buffer that receives a pointer to a system-allocated buffer that specifies a sorted list of the
///                   requested information. The format of this data depends on the value of the <i>Level</i> parameter. Because this
///                   buffer is allocated by the system, it must be freed using the NetApiBufferFree function. Note that you must free
///                   the buffer even if the function fails with ERROR_MORE_DATA. For more information, see the following Return Values
///                   section, and the topics Network Management Function Buffers and Network Management Function Buffer Lengths.
///Returns:
///    If the function succeeds, the return value is NERR_Success. If the function fails, the return value is one of the
///    following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> The user does not have access to the requested
///    information. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_LEVEL</b></dt> </dl> </td> <td
///    width="60%"> The <i>Level</i> parameter specifies an invalid value. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_MORE_DATA</b></dt> </dl> </td> <td width="60%"> More entries are available. That is, the last entry
///    returned in the <i>SortedBuffer</i> parameter is not the last entry available. To retrieve additional entries,
///    call <b>NetQueryDisplayInformation</b> again with the <i>Index</i> parameter set to the value returned in the
///    <b>next_index</b> member of the last entry in <i>SortedBuffer</i>. Note that you should not use the value of the
///    <b>next_index</b> member for any purpose except to retrieve more data with additional calls to
///    <b>NetQueryDisplayInformation</b>. </td> </tr> </table>
///    
@DllImport("samcli")
uint NetQueryDisplayInformation(const(PWSTR) ServerName, uint Level, uint Index, uint EntriesRequested, 
                                uint PreferredMaximumLength, uint* ReturnedEntryCount, void** SortedBuffer);

///The <b>NetGetDisplayInformationIndex</b> function returns the index of the first display information entry whose name
///begins with a specified string or whose name alphabetically follows the string. You can use this function to
///determine a starting index for subsequent calls to the NetQueryDisplayInformation function.
///Params:
///    ServerName = Pointer to a constant string that specifies the DNS or NetBIOS name of the remote server on which the function is
///                 to execute. If this parameter is <b>NULL</b>, the local computer is used.
///    Level = Specifies the level of accounts to query. This parameter can be one of the following values. <table> <tr>
///            <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="1"></a><dl> <dt><b>1</b></dt> </dl> </td> <td
///            width="60%"> Query all local and global (normal) user accounts. </td> </tr> <tr> <td width="40%"><a
///            id="2"></a><dl> <dt><b>2</b></dt> </dl> </td> <td width="60%"> Query all workstation and server user accounts.
///            </td> </tr> <tr> <td width="40%"><a id="3"></a><dl> <dt><b>3</b></dt> </dl> </td> <td width="60%"> Query all
///            global groups. </td> </tr> </table>
///    Prefix = Pointer to a string that specifies the prefix for which to search.
///    Index = Pointer to a value that receives the index of the requested entry.
///Returns:
///    If the function succeeds, the return value is NERR_Success. If the function fails, the return value can be one of
///    the following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
///    <dl> <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> The user does not have access to the
///    requested information. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_LEVEL</b></dt> </dl> </td> <td
///    width="60%"> The value specified for the <i>Level</i> parameter is invalid. </td> </tr> <tr> <td width="40%">
///    <dl> <dt><b>ERROR_NO_MORE_ITEMS</b></dt> </dl> </td> <td width="60%"> There were no more items on which to
///    operate. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>NERR_InvalidComputer</b></dt> </dl> </td> <td width="60%">
///    The computer name is invalid. </td> </tr> </table>
///    
@DllImport("samcli")
uint NetGetDisplayInformationIndex(const(PWSTR) ServerName, uint Level, const(PWSTR) Prefix, uint* Index);

///<p class="CCE_Message">[This function is obsolete. For a list of alternate functions, see Authorization Functions.]
///Not supported. The <b>NetAccessAdd</b> function creates a new access control list (ACL) for a resource.
///Params:
///    servername = Pointer to a string that specifies the DNS or NetBIOS name of the remote server on which the function is to
///                 execute. If this parameter is <b>NULL</b>, the local computer is used.
///    level = Specifies the information level of the data. This parameter can be the following value. <table> <tr>
///            <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="1"></a><dl> <dt><b>1</b></dt> </dl> </td> <td
///            width="60%"> The <i>pbBuffer</i> parameter points to an <b>access_info_1</b> structure. </td> </tr> </table>
///    buf = Pointer to the buffer that contains the access information structure.
///    parm_err = Specifies the size, in bytes, of the buffer pointed to by the <i>pbBuffer</i> parameter.
///Returns:
///    If the function succeeds, the return value is <b>NERR_Success</b>. If the function fails, the return value is a
///    system error code. For a list of error codes, see System Error Codes.
///    
@DllImport("NETAPI32")
uint NetAccessAdd(const(PWSTR) servername, uint level, ubyte* buf, uint* parm_err);

///<p class="CCE_Message">[This function is obsolete. For a list of alternate functions, see Authorization Functions.]
///Not supported. The <b>NetAccessEnum</b> function retrieves information about each access permission record.
///Params:
///    servername = Pointer to a string that specifies the DNS or NetBIOS name of the remote server on which the function is to
///                 execute. If this parameter is <b>NULL</b>, the local computer is used.
///    BasePath = Pointer to a string that contains a base pathname for the resource. A <b>NULL</b> pointer or <b>NULL</b> string
///               means no base path is to be used. The path can be specified as a universal naming convention (UNC) pathname.
///    Recursive = Specifies a flag that enables or disables recursive searching. If this parameter is equal to zero, the
///                <b>NetAccessEnum</b> function returns entries for the resource named as the base path by the <i>pszBasePath</i>
///                parameter, and for the resources directly below that base path. If this parameter is nonzero, the function
///                returns entries for all access control lists (ACLs) that have <i>pszBasePath</i> at the beginning of the resource
///                name.
///    level = Specifies the information level of the data. This parameter can be one of the following values. <table> <tr>
///            <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="0"></a><dl> <dt><b>0</b></dt> </dl> </td> <td
///            width="60%"> The <i>pbBuffer</i> parameter points to an <b>access_info_0</b> structure. </td> </tr> <tr> <td
///            width="40%"><a id="1"></a><dl> <dt><b>1</b></dt> </dl> </td> <td width="60%"> The <i>pbBuffer</i> parameter
///            points to an <b>access_info_1</b> structure. </td> </tr> </table>
///    bufptr = Pointer to the buffer that receives the access information structure. The format of this data depends on the
///             value of the <i>sLevel</i> parameter.
///    prefmaxlen = Specifies the size, in bytes, of the buffer pointed to by the <i>pbBuffer</i> parameter.
///    entriesread = Pointer to an unsigned short integer that receives the count of elements actually enumerated. The count is valid
///                  only if the <b>NetAccessEnum</b> function returns <b>NERR_Success</b> or <b>ERROR_MORE_DATA</b>.
///    totalentries = Pointer to an unsigned short integer that receives the total number of entries that could have been enumerated.
///                   The count is valid only if the <b>NetAccessEnum</b> function returns <b>NERR_Success</b> or
///                   <b>ERROR_MORE_DATA</b>.
///    resume_handle = TBD
///Returns:
///    If the function succeeds, the return value is <b>NERR_Success</b>. If the function fails, the return value is a
///    system error code. For a list of error codes, see System Error Codes.
///    
@DllImport("NETAPI32")
uint NetAccessEnum(const(PWSTR) servername, const(PWSTR) BasePath, uint Recursive, uint level, ubyte** bufptr, 
                   uint prefmaxlen, uint* entriesread, uint* totalentries, uint* resume_handle);

///<p class="CCE_Message">[This function is obsolete. For a list of alternate functions, see Authorization Functions.]
///Not supported. The <b>NetAccessGetInfo</b> function retrieves the access control list (ACL) for a specified resource.
///Params:
///    servername = Pointer to a string that specifies the DNS or NetBIOS name of the remote server on which the function is to
///                 execute. If this parameter is <b>NULL</b>, the local computer is used.
///    resource = Specifies the information level of the data. This parameter can be one of the following values. <table> <tr>
///               <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="0"></a><dl> <dt><b>0</b></dt> </dl> </td> <td
///               width="60%"> The p parameter points to an <b>access_info_0</b> structure. </td> </tr> <tr> <td width="40%"><a
///               id="1"></a><dl> <dt><b>1</b></dt> </dl> </td> <td width="60%"> The <i>pbBuffer</i> parameter points to an
///               <b>access_info_1</b> structure. </td> </tr> </table>
///    level = Pointer to the buffer that receives the access information structure. The format of this data depends on the
///            value of the <i>sLevel</i> parameter.
///    bufptr = Specifies the size, in bytes, of the buffer pointed to by the <i>pbBuffer</i> parameter.
///Returns:
///    If the function succeeds, the return value is <b>NERR_Success</b>. If the function fails, the return value is a
///    system error code. For a list of error codes, see System Error Codes.
///    
@DllImport("NETAPI32")
uint NetAccessGetInfo(const(PWSTR) servername, const(PWSTR) resource, uint level, ubyte** bufptr);

///<p class="CCE_Message">[This function is obsolete. For a list of alternate functions, see Authorization Functions.]
///Not supported. The <b>NetAccessSetInfo</b> function changes the access control list (ACL) for a resource.
///Params:
///    servername = Pointer to a string that specifies the DNS or NetBIOS name of the remote server on which the function is to
///                 execute. If this parameter is <b>NULL</b>, the local computer is used.
///    resource = Pointer to a string that contains the name of the network resource to modify.
///    level = Specifies the information level of the data. This parameter can be the following value. <table> <tr>
///            <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="1"></a><dl> <dt><b>1</b></dt> </dl> </td> <td
///            width="60%"> The <i>pbBuffer</i> parameter points to an <b>access_info_1</b> structure. </td> </tr> </table>
///    buf = Pointer to the buffer that contains the access information structure. The format of this data depends on the
///          value of the <i>sLevel</i> parameter.
///    parm_err = TBD
///Returns:
///    If the function succeeds, the return value is <b>NERR_Success</b>. If the function fails, the return value is a
///    system error code. For a list of error codes, see System Error Codes.
///    
@DllImport("NETAPI32")
uint NetAccessSetInfo(const(PWSTR) servername, const(PWSTR) resource, uint level, ubyte* buf, uint* parm_err);

///<p class="CCE_Message">[This function is obsolete. For a list of alternate functions, see Authorization Functions.]
///Not supported. The <b>NetAccessDel</b> function deletes the access control list (ACL) for a resource.
///Params:
///    servername = Pointer to a string that specifies the DNS or NetBIOS name of the remote server on which the function is to
///                 execute. If this parameter is <b>NULL</b>, the local computer is used.
///    resource = Pointer to a string that contains the name of the network resource for which to remove the access control list.
///Returns:
///    If the function succeeds, the return value is NERR_Success. If the function fails, the return value is a system
///    error code. For a list of error codes, see System Error Codes.
///    
@DllImport("NETAPI32")
uint NetAccessDel(const(PWSTR) servername, const(PWSTR) resource);

///<p class="CCE_Message">[This function is obsolete. For a list of alternate functions, see Authorization Functions.]
///Not supported. The <b>NetAccessGetUserPerms</b> function returns a specified user's or group's access permissions for
///a particular resource.
///Params:
///    servername = Pointer to a string that specifies the DNS or NetBIOS name of the remote server on which the function is to
///                 execute. If this parameter is <b>NULL</b>, the local computer is used.
///    UGname = Pointer to a string that specifies the name of the user or group to query.
///    resource = Pointer to a string that contains the name of the network resource to query.
///    Perms = Pointer to an unsigned short integer that receives the user permissions for the specified resource.
///Returns:
///    If the function succeeds, the return value is NERR_Success. If the function fails, the return value is a system
///    error code. For a list of error codes, see System Error Codes.
///    
@DllImport("NETAPI32")
uint NetAccessGetUserPerms(const(PWSTR) servername, const(PWSTR) UGname, const(PWSTR) resource, uint* Perms);

///The <b>NetValidatePasswordPolicy</b> function allows an application to check password compliance against an
///application-provided account database and verify that passwords meet the complexity, aging, minimum length, and
///history reuse requirements of a password policy.
///Params:
///    ServerName = A pointer to a constant Unicode string specifying the name of the remote server on which the function is to
///                 execute. This string must begin with \\ followed by the remote server name. If this parameter is <b>NULL</b>, the
///                 local computer is used.
///    Qualifier = Reserved for future use. This parameter must be <b>NULL</b>.
///    ValidationType = The type of password validation to perform. This parameter must be one of the following enumerated constant
///                     values. ```cpp typedef enum _NET_VALIDATE_PASSWORD_TYPE { NetValidateAuthentication = 1,
///                     NetValidatePasswordChange, NetValidatePasswordReset, } NET_VALIDATE_PASSWORD_TYPE, *PNET_VALIDATE_PASSWORD_TYPE;
///                     ``` These values have the following meanings. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td
///                     width="40%"><a id="NetValidateAuthentication"></a><a id="netvalidateauthentication"></a><a
///                     id="NETVALIDATEAUTHENTICATION"></a><dl> <dt><b>NetValidateAuthentication</b></dt> </dl> </td> <td width="60%">
///                     The application is requesting password validation during authentication. The <i>InputArg</i> parameter points to
///                     a NET_VALIDATE_AUTHENTICATION_INPUT_ARG structure. This type of validation enforces password expiration and
///                     account lockout policy. </td> </tr> <tr> <td width="40%"><a id="NetValidatePasswordChange"></a><a
///                     id="netvalidatepasswordchange"></a><a id="NETVALIDATEPASSWORDCHANGE"></a><dl>
///                     <dt><b>NetValidatePasswordChange</b></dt> </dl> </td> <td width="60%"> The application is requesting password
///                     validation during a password change operation. The <i>InputArg</i> parameter points to a
///                     NET_VALIDATE_PASSWORD_CHANGE_INPUT_ARG structure. </td> </tr> <tr> <td width="40%"><a
///                     id="NetValidatePasswordReset"></a><a id="netvalidatepasswordreset"></a><a id="NETVALIDATEPASSWORDRESET"></a><dl>
///                     <dt><b>NetValidatePasswordReset</b></dt> </dl> </td> <td width="60%"> The application is requesting password
///                     validation during a password reset operation. The <i>InputArg</i> parameter points to a
///                     NET_VALIDATE_PASSWORD_RESET_INPUT_ARG structure. You can also reset the "lockout state" of a user account by
///                     specifying this structure. </td> </tr> </table>
///    InputArg = A pointer to a structure that depends on the type of password validation to perform. The type of structure
///               depends on the value of the <i>ValidationType</i> parameter. For more information, see the description of the
///               <i>ValidationType</i> parameter.
///    OutputArg = If the <b>NetValidatePasswordPolicy</b> function succeeds (the return value is <b>Nerr_Success</b>), then the
///                function allocates an buffer that contains the results of the operation. The <i>OutputArg</i> parameter contains
///                a pointer to a NET_VALIDATE_OUTPUT_ARG structure. The application must examine <b>ValidationStatus</b> member in
///                the <b>NET_VALIDATE_OUTPUT_ARG</b> structure pointed to by the <i>OutputArg</i> parameter to determine the
///                results of the password policy validation check. The <b>NET_VALIDATE_OUTPUT_ARG</b> structure contains a
///                NET_VALIDATE_PERSISTED_FIELDS structure with changes to persistent password-related information, and the results
///                of the password validation. The application must plan to persist all persisted the fields in the
///                <b>NET_VALIDATE_PERSISTED_FIELDS</b> structure aside from the <b>ValidationStatus</b>member as information along
///                with the user object information and provide the required fields from the persisted information when calling this
///                function in the future on the same user object. If the <b>NetValidatePasswordPolicy</b> function fails (the
///                return value is nonzero), then <i>OutputArg</i> parameter is set to a <b>NULL</b> pointer and password policy
///                could not be examined. For more information, see the Return Values and Remarks sections.
///Returns:
///    If the function succeeds, and the password is authenticated, changed, or reset, the return value is NERR_Success
///    and the function allocates an <i>OutputArg</i> parameter. If the function fails, the <i>OutputArg</i> parameter
///    is <b>NULL</b> and the return value is a system error code that can be one of the following error codes. For a
///    list of all possible error codes, see System Error Codes. <table> <tr> <th>Return code</th> <th>Description</th>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> A parameter
///    is incorrect. This error is returned if the <i>InputArg</i> or <i>OutputArg</i> parameters are <b>NULL</b>. This
///    error is also returned if the <i>Qualifier</i> parameter is not <b>NULL</b> or if the <i>ValidationType</i>
///    parameter is not one of the allowed values. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_NOT_ENOUGH_MEMORY</b></dt> </dl> </td> <td width="60%"> Not enough memory is available to complete
///    the operation. </td> </tr> </table>
///    
@DllImport("samcli")
uint NetValidatePasswordPolicy(const(PWSTR) ServerName, void* Qualifier, NET_VALIDATE_PASSWORD_TYPE ValidationType, 
                               void* InputArg, void** OutputArg);

///The <b>NetValidatePasswordPolicyFree</b> function frees the memory that the NetValidatePasswordPolicy function
///allocates for the <i>OutputArg</i> parameter, which is a NET_VALIDATE_OUTPUT_ARG structure.
///Params:
///    OutputArg = Pointer to the memory allocated for the <i>OutputArg</i> parameter by a call to the
///                <b>NetValidatePasswordPolicy</b> function.
///Returns:
///    If the function frees the memory, or if there is no memory to free from a previous call to
///    <b>NetValidatePasswordPolicy</b>, the return value is NERR_Success. If the function fails, the return value is a
///    system error code. For a list of error codes, see System Error Codes.
///    
@DllImport("samcli")
uint NetValidatePasswordPolicyFree(void** OutputArg);

///The <b>NetGetDCName</b> function returns the name of the primary domain controller (PDC). It does not return the name
///of the backup domain controller (BDC) for the specified domain. Also, you cannot remote this function to a non-PDC
///server. Applications that support DNS-style names should call the DsGetDcName function. Domain controllers in this
///type of environment have a multi-master directory replication relationship. Therefore, it may be advantageous for
///your application to use a DC that is not the PDC. You can call the <b>DsGetDcName</b> function to locate any DC in
///the domain; <b>NetGetDCName</b> returns only the name of the PDC.
///Params:
///    servername = A pointer to a constant string that specifies the DNS or NetBIOS name of the remote server on which the function
///                 is to execute. If this parameter is <b>NULL</b>, the local computer is used.
///    domainname = A pointer to a constant string that specifies the name of the domain. The domain name must be a NetBIOS domain
///                 name (for example, microsoft). <b>NetGetDCName</b> does not support DNS-style names (for example, microsoft.com).
///                 If this parameter is <b>NULL</b>, the function returns the name of the domain controller for the primary domain.
///    bufptr = A pointer to an allocated buffer that receives a string that specifies the server name of the PDC of the domain.
///             The server name is returned as Unicode string prefixed by \\. This buffer is allocated by the system and must be
///             freed using the NetApiBufferFree function. For more information, see Network Management Function Buffers and
///             Network Management Function Buffer Lengths.
///Returns:
///    If the function succeeds, the return value is NERR_Success. If the function fails, the return value can be one of
///    the following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
///    <dl> <dt><b>NERR_DCNotFound</b></dt> </dl> </td> <td width="60%"> Could not find the domain controller for the
///    domain specified in the <i>domainname</i> parameter. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_BAD_NETPATH</b></dt> </dl> </td> <td width="60%"> The network path was not found. This error is
///    returned if the computer specified in the <i>servername</i> parameter could not be found. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_INVALID_NAME</b></dt> </dl> </td> <td width="60%"> The name syntax is incorrect.
///    This error is returned if the name specified in the <i>servername</i> parameter contains illegal characters.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NOT_SUPPORTED</b></dt> </dl> </td> <td width="60%"> The
///    request is not supported. </td> </tr> </table>
///    
@DllImport("logoncli")
uint NetGetDCName(const(PWSTR) ServerName, const(PWSTR) DomainName, ubyte** Buffer);

///The <b>NetGetAnyDCName</b> function returns the name of any domain controller (DC) for a domain that is directly
///trusted by the specified server. Applications that support DNS-style names should call the DsGetDcName function. This
///function can locate any DC in any domain, whether or not the domain is directly trusted by the specified server.
///Params:
///    servername = Pointer to a constant string that specifies the DNS or NetBIOS name of the remote server on which the function is
///                 to execute. If this parameter is <b>NULL</b>, the local computer is used. For more information, see the following
///                 Remarks section.
///    domainname = Pointer to a constant string that specifies the name of the domain. If this parameter is <b>NULL</b>, the name of
///                 the domain controller for the primary domain is used. For more information, see the following Remarks section.
///    bufptr = Pointer to an allocated buffer that receives a string that specifies the server name of a domain controller for
///             the domain. The server name is prefixed by \\. This buffer is allocated by the system and must be freed using the
///             NetApiBufferFree function. For more information, see Network Management Function Buffers and Network Management
///             Function Buffer Lengths.
///Returns:
///    If the function succeeds, the return value is NERR_Success. If the function fails, the return value can be one of
///    the following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
///    <dl> <dt><b>ERROR_NO_LOGON_SERVERS</b></dt> </dl> </td> <td width="60%"> No domain controllers could be found.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NO_SUCH_DOMAIN</b></dt> </dl> </td> <td width="60%"> The
///    specified domain is not a trusted domain. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_NO_TRUST_LSA_SECRET</b></dt> </dl> </td> <td width="60%"> The client side of the trust relationship
///    is broken. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NO_TRUST_SAM_ACCOUNT</b></dt> </dl> </td> <td
///    width="60%"> The server side of the trust relationship is broken or the password is broken. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_DOMAIN_TRUST_INCONSISTENT</b></dt> </dl> </td> <td width="60%"> The server that
///    responded is not a proper domain controller of the specified domain. </td> </tr> </table>
///    
@DllImport("logoncli")
uint NetGetAnyDCName(const(PWSTR) ServerName, const(PWSTR) DomainName, ubyte** Buffer);

///The <b>NetJoinDomain</b> function joins a computer to a workgroup or domain.
///Params:
///    lpServer = A pointer to a constant string that specifies the DNS or NetBIOS name of the computer on which to execute the
///               domain join operation. If this parameter is <b>NULL</b>, the local computer is used.
///    lpDomain = A pointer to a constant null-terminated character string that specifies the name of the domain or workgroup to
///               join. Optionally, you can specify the preferred domain controller to perform the join operation. In this
///               instance, the string must be of the form <i>DomainName\MachineName</i>, where <i>DomainName</i> is the name of
///               the domain to join, and <i>MachineName</i> is the name of the domain controller to perform the join.
///    lpMachineAccountOU = Optionally specifies the pointer to a constant null-terminated character string that contains the RFC 1779 format
///                         name of the organizational unit (OU) for the computer account. If you specify this parameter, the string must
///                         contain a full path, for example, OU=testOU,DC=domain,DC=Domain,DC=com. Otherwise, this parameter must be
///                         <b>NULL</b>.
///    lpAccount = A pointer to a constant null-terminated character string that specifies the account name to use when connecting
///                to the domain controller. The string must specify either a domain NetBIOS name and user account (for example,
///                <i>REDMOND\user</i>) or the user principal name (UPN) of the user in the form of an Internet-style login name
///                (for example, "someone@example.com"). If this parameter is <b>NULL</b>, the caller's context is used.
///    lpPassword = If the <i>lpAccount</i> parameter specifies an account name, this parameter must point to the password to use
///                 when connecting to the domain controller. Otherwise, this parameter must be <b>NULL</b>. You can specify a local
///                 machine account password rather than a user password for unsecured joins. For more information, see the
///                 description of the NETSETUP_MACHINE_PWD_PASSED flag described in the <i>fJoinOptions</i> parameter.
///    fJoinOptions = A set of bit flags defining the join options. This parameter can be one or more of the following values defined
///                   in the <i>Lmjoin.h</i> header file. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
///                   id="NETSETUP_JOIN_DOMAIN"></a><a id="netsetup_join_domain"></a><dl> <dt><b>NETSETUP_JOIN_DOMAIN</b></dt>
///                   <dt>0x00000001</dt> </dl> </td> <td width="60%"> Joins the computer to a domain. If this value is not specified,
///                   joins the computer to a workgroup. </td> </tr> <tr> <td width="40%"><a id="NETSETUP_ACCT_CREATE"></a><a
///                   id="netsetup_acct_create"></a><dl> <dt><b>NETSETUP_ACCT_CREATE</b></dt> <dt>0x00000002</dt> </dl> </td> <td
///                   width="60%"> Creates the account on the domain. </td> </tr> <tr> <td width="40%"><a
///                   id="NETSETUP_WIN9X_UPGRADE"></a><a id="netsetup_win9x_upgrade"></a><dl> <dt><b>NETSETUP_WIN9X_UPGRADE</b></dt>
///                   <dt>0x00000010</dt> </dl> </td> <td width="60%"> The join operation is occurring as part of an upgrade. </td>
///                   </tr> <tr> <td width="40%"><a id="NETSETUP_DOMAIN_JOIN_IF_JOINED"></a><a
///                   id="netsetup_domain_join_if_joined"></a><dl> <dt><b>NETSETUP_DOMAIN_JOIN_IF_JOINED</b></dt> <dt>0x00000020</dt>
///                   </dl> </td> <td width="60%"> Allows a join to a new domain even if the computer is already joined to a domain.
///                   </td> </tr> <tr> <td width="40%"><a id="NETSETUP_JOIN_UNSECURE"></a><a id="netsetup_join_unsecure"></a><dl>
///                   <dt><b>NETSETUP_JOIN_UNSECURE</b></dt> <dt>0x00000040</dt> </dl> </td> <td width="60%"> Performs an unsecured
///                   join. This option requests a domain join to a pre-created account without authenticating with domain user
///                   credentials. This option can be used in conjunction with <b>NETSETUP_MACHINE_PWD_PASSED</b> option. In this case,
///                   <i>lpPassword</i> is the password of the pre-created machine account. Prior to Windows Vista with SP1 and Windows
///                   Server 2008, an unsecure join did not authenticate to the domain controller. All communication was performed
///                   using a null (unauthenticated) session. Starting with Windows Vista with SP1 and Windows Server 2008, the machine
///                   account name and password are used to authenticate to the domain controller. </td> </tr> <tr> <td width="40%"><a
///                   id="NETSETUP_MACHINE_PWD_PASSED"></a><a id="netsetup_machine_pwd_passed"></a><dl>
///                   <dt><b>NETSETUP_MACHINE_PWD_PASSED</b></dt> <dt>0x00000080</dt> </dl> </td> <td width="60%"> Indicates that the
///                   <i>lpPassword</i> parameter specifies a local machine account password rather than a user password. This flag is
///                   valid only for unsecured joins, which you must indicate by also setting the NETSETUP_JOIN_UNSECURE flag. If you
///                   set this flag, then after the join operation succeeds, the machine password will be set to the value of
///                   <i>lpPassword</i>, if that value is a valid machine password. </td> </tr> <tr> <td width="40%"><a
///                   id="NETSETUP_DEFER_SPN_SET"></a><a id="netsetup_defer_spn_set"></a><dl> <dt><b>NETSETUP_DEFER_SPN_SET</b></dt>
///                   <dt>0x00000100</dt> </dl> </td> <td width="60%"> Indicates that the service principal name (SPN) and the
///                   DnsHostName properties on the computer object should not be updated at this time. Typically, these properties are
///                   updated during the join operation. Instead, these properties should be updated during a subsequent call to the
///                   NetRenameMachineInDomain function. These properties are always updated during the rename operation. For more
///                   information, see the following Remarks section. </td> </tr> <tr> <td width="40%"><a
///                   id="NETSETUP_JOIN_DC_ACCOUNT"></a><a id="netsetup_join_dc_account"></a><dl>
///                   <dt><b>NETSETUP_JOIN_DC_ACCOUNT</b></dt> <dt>0x00000200</dt> </dl> </td> <td width="60%"> Allow the domain join
///                   if existing account is a domain controller. <div class="alert"><b>Note</b> This flag is supported on Windows
///                   Vista and later.</div> <div> </div> </td> </tr> <tr> <td width="40%"><a id="NETSETUP_JOIN_WITH_NEW_NAME"></a><a
///                   id="netsetup_join_with_new_name"></a><dl> <dt><b>NETSETUP_JOIN_WITH_NEW_NAME</b></dt> <dt>0x00000400</dt> </dl>
///                   </td> <td width="60%"> Join the target machine specified in <i>lpServer</i> parameter with a new name queried
///                   from the registry on the machine specified in the <i>lpServer</i> parameter. This option is used if
///                   SetComputerNameEx has been called prior to rebooting the machine. The new computer name will not take effect
///                   until a reboot. With this option, the caller instructs the <b>NetJoinDomain</b> function to use the new name
///                   during the domain join operation. A reboot is required after calling <b>NetJoinDomain</b> successfully at which
///                   time both the computer name change and domain membership change will have taken affect. <div
///                   class="alert"><b>Note</b> This flag is supported on Windows Vista and later.</div> <div> </div> </td> </tr> <tr>
///                   <td width="40%"><a id="NETSETUP_JOIN_READONLY"></a><a id="netsetup_join_readonly"></a><dl>
///                   <dt><b>NETSETUP_JOIN_READONLY</b></dt> <dt>0x00000800</dt> </dl> </td> <td width="60%"> Join the target machine
///                   specified in <i>lpServer</i> parameter using a pre-created account without requiring a writable domain
///                   controller. This option provides the ability to join a machine to domain if an account has already been
///                   provisioned and replicated to a read-only domain controller. The target read-only domain controller is specified
///                   as part of the <i>lpDomain</i> parameter, after the domain name delimited by a ‘\’ character. This
///                   provisioning must include the machine secret. The machine account must be added via group membership into the
///                   allowed list for password replication policy, and the account password must be replicated to the read-only domain
///                   controller prior to the join operation. For more information, see the information on Password Replication Policy
///                   Administration. Starting with Windows 7, an alternate mechanism is to use the offline domain join mechanism. For
///                   more information, see the <b>NetProvisionComputerAccount</b> and <b>NetRequestOfflineDomainJoin</b> functions.
///                   <div class="alert"><b>Note</b> This flag is supported on Windows Vista and later.</div> <div> </div> </td> </tr>
///                   <tr> <td width="40%"><a id="NETSETUP_AMBIGUOUS_DC"></a><a id="netsetup_ambiguous_dc"></a><dl>
///                   <dt><b>NETSETUP_AMBIGUOUS_DC</b></dt> <dt>0x00001000</dt> </dl> </td> <td width="60%"> When joining the domain
///                   don't try to set the preferred domain controller in the registry. <div class="alert"><b>Note</b> This flag is
///                   supported on Windows 7, Windows Server 2008 R2, and later.</div> <div> </div> </td> </tr> <tr> <td width="40%"><a
///                   id="NETSETUP_NO_NETLOGON_CACHE"></a><a id="netsetup_no_netlogon_cache"></a><dl>
///                   <dt><b>NETSETUP_NO_NETLOGON_CACHE</b></dt> <dt>0x00002000</dt> </dl> </td> <td width="60%"> When joining the
///                   domain don't create the Netlogon cache. <div class="alert"><b>Note</b> This flag is supported on Windows 7,
///                   Windows Server 2008 R2, and later.</div> <div> </div> </td> </tr> <tr> <td width="40%"><a
///                   id="NETSETUP_DONT_CONTROL_SERVICES"></a><a id="netsetup_dont_control_services"></a><dl>
///                   <dt><b>NETSETUP_DONT_CONTROL_SERVICES</b></dt> <dt>0x00004000</dt> </dl> </td> <td width="60%"> When joining the
///                   domain don't force Netlogon service to start. <div class="alert"><b>Note</b> This flag is supported on Windows 7,
///                   Windows Server 2008 R2, and later.</div> <div> </div> </td> </tr> <tr> <td width="40%"><a
///                   id="NETSETUP_SET_MACHINE_NAME"></a><a id="netsetup_set_machine_name"></a><dl>
///                   <dt><b>NETSETUP_SET_MACHINE_NAME</b></dt> <dt>0x00008000</dt> </dl> </td> <td width="60%"> When joining the
///                   domain for offline join only, set target machine hostname and NetBIOS name. <div class="alert"><b>Note</b> This
///                   flag is supported on Windows 7, Windows Server 2008 R2, and later.</div> <div> </div> </td> </tr> <tr> <td
///                   width="40%"><a id="NETSETUP_FORCE_SPN_SET"></a><a id="netsetup_force_spn_set"></a><dl>
///                   <dt><b>NETSETUP_FORCE_SPN_SET</b></dt> <dt>0x00010000</dt> </dl> </td> <td width="60%"> When joining the domain,
///                   override other settings during domain join and set the service principal name (SPN). <div
///                   class="alert"><b>Note</b> This flag is supported on Windows 7, Windows Server 2008 R2, and later.</div> <div>
///                   </div> </td> </tr> <tr> <td width="40%"><a id="NETSETUP_NO_ACCT_REUSE"></a><a
///                   id="netsetup_no_acct_reuse"></a><dl> <dt><b>NETSETUP_NO_ACCT_REUSE</b></dt> <dt>0x00020000</dt> </dl> </td> <td
///                   width="60%"> When joining the domain, do not reuse an existing account. <div class="alert"><b>Note</b> This flag
///                   is supported on Windows 7, Windows Server 2008 R2, and later.</div> <div> </div> </td> </tr> <tr> <td
///                   width="40%"><a id="NETSETUP_IGNORE_UNSUPPORTED_FLAGS"></a><a id="netsetup_ignore_unsupported_flags"></a><dl>
///                   <dt><b>NETSETUP_IGNORE_UNSUPPORTED_FLAGS</b></dt> <dt>0x10000000</dt> </dl> </td> <td width="60%"> If this bit is
///                   set, unrecognized flags will be ignored by the <b>NetJoinDomain</b> function and <b>NetJoinDomain</b> will behave
///                   as if the flags were not set. </td> </tr> </table>
///Returns:
///    If the function succeeds, the return value is NERR_Success. If the function fails, the return value can be one of
///    the following error codes or one of the system error codes. <table> <tr> <th>Return code</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td
///    width="60%"> Access is denied. This error is returned if the caller was not a member of the Administrators local
///    group on the target computer. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt>
///    </dl> </td> <td width="60%"> A parameter is incorrect. This error is returned if the <i>lpDomain</i> parameter is
///    <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NO_SUCH_DOMAIN</b></dt> </dl> </td> <td
///    width="60%"> The specified domain did not exist. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_NOT_SUPPORTED</b></dt> </dl> </td> <td width="60%"> The request is not supported. This error is
///    returned if the computer specified in the <i>lpServer</i> parameter does not support some of the options passed
///    in the <i>fJoinOptions</i> parameter. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>NERR_InvalidWorkgroupName</b></dt> </dl> </td> <td width="60%"> The specified workgroup name is not valid.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>NERR_SetupAlreadyJoined</b></dt> </dl> </td> <td width="60%"> The
///    computer is already joined to a domain. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>NERR_WkstaNotStarted</b></dt> </dl> </td> <td width="60%"> The Workstation service has not been started.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_CALL_IN_PROGRESS</b></dt> </dl> </td> <td width="60%"> A
///    remote procedure call is already in progress for this thread. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>RPC_S_PROTSEQ_NOT_SUPPORTED</b></dt> </dl> </td> <td width="60%"> The remote procedure call protocol
///    sequence is not supported. </td> </tr> </table>
///    
@DllImport("wkscli")
uint NetJoinDomain(const(PWSTR) lpServer, const(PWSTR) lpDomain, const(PWSTR) lpMachineAccountOU, 
                   const(PWSTR) lpAccount, const(PWSTR) lpPassword, uint fJoinOptions);

///The <b>NetUnjoinDomain</b> function unjoins a computer from a workgroup or a domain.
///Params:
///    lpServer = A pointer to a constant string that specifies the DNS or NetBIOS name of the computer on which the function is to
///               execute. If this parameter is <b>NULL</b>, the local computer is used.
///    lpAccount = A pointer to a constant string that specifies the account name to use when connecting to the domain controller.
///                The string must specify either a domain NetBIOS name and user account (for example, <i>REDMOND\user</i>) or the
///                user principal name (UPN) of the user in the form of an Internet-style login name (for example,
///                "someone@example.com"). If this parameter is <b>NULL</b>, the caller's context is used.
///    lpPassword = If the <i>lpAccount</i> parameter specifies an account name, this parameter must point to the password to use
///                 when connecting to the domain controller. Otherwise, this parameter must be <b>NULL</b>.
///    fUnjoinOptions = Specifies the unjoin options. If this parameter is NETSETUP_ACCT_DELETE, the account is disabled when the unjoin
///                     occurs. Note that this option does not delete the account. Currently, there are no other unjoin options defined.
///Returns:
///    If the function succeeds, the return value is NERR_Success. If the function fails, the return value can be one of
///    the following error codes or one of the system error codes. <table> <tr> <th>Return code</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td
///    width="60%"> A parameter is incorrect. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>NERR_SetupNotJoined</b></dt>
///    </dl> </td> <td width="60%"> The computer is not currently joined to a domain. </td> </tr> <tr> <td width="40%">
///    <dl> <dt><b>NERR_SetupDomainController</b></dt> </dl> </td> <td width="60%"> This computer is a domain controller
///    and cannot be unjoined from a domain. </td> </tr> </table>
///    
@DllImport("wkscli")
uint NetUnjoinDomain(const(PWSTR) lpServer, const(PWSTR) lpAccount, const(PWSTR) lpPassword, uint fUnjoinOptions);

///The <b>NetRenameMachineInDomain</b> function changes the name of a computer in a domain.
///Params:
///    lpServer = A pointer to a constant string that specifies the DNS or NetBIOS name of the computer on which to call the
///               function. If this parameter is <b>NULL</b>, the local computer is used.
///    lpNewMachineName = A pointer to a constant string that specifies the new name of the computer. If specified, the local computer name
///                       is changed as well. If this parameter is <b>NULL</b>, the function assumes you have already called the
///                       SetComputerNameEx function.
///    lpAccount = A pointer to a constant string that specifies an account name to use when connecting to the domain controller. If
///                this parameter is <b>NULL</b>, the caller's context is used.
///    lpPassword = If the <i>lpAccount</i> parameter specifies an account name, this parameter must point to the password to use
///                 when connecting to the domain controller. Otherwise, this parameter must be <b>NULL</b>.
///    fRenameOptions = The rename options. If this parameter is NETSETUP_ACCT_CREATE, the function renames the account in the domain.
///Returns:
///    If the function succeeds, the return value is NERR_Success. If the function fails, the return value can be one of
///    the following error codes or one of the system error codes. <table> <tr> <th>Return code</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td
///    width="60%"> Access is denied. This error is returned if the account name passed in the <i>lpAccount</i>
///    parameter did not have sufficient access rights for the operation. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> A parameter is incorrect. </td> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>NERR_SetupNotJoined</b></dt> </dl> </td> <td width="60%"> The computer is not
///    currently joined to a domain. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>NERR_SetupDomainController</b></dt>
///    </dl> </td> <td width="60%"> This computer is a domain controller and cannot be unjoined from a domain. </td>
///    </tr> </table>
///    
@DllImport("wkscli")
uint NetRenameMachineInDomain(const(PWSTR) lpServer, const(PWSTR) lpNewMachineName, const(PWSTR) lpAccount, 
                              const(PWSTR) lpPassword, uint fRenameOptions);

///The <b>NetValidateName</b> function verifies that a name is valid for name type specified(computer name, workgroup
///name, domain name, or DNS computer name).
///Params:
///    lpServer = A pointer to a constant string that specifies the DNS or NetBIOS name of the computer on which to call the
///               function. If this parameter is <b>NULL</b>, the local computer is used.
///    lpName = A pointer to a constant string that specifies the name to validate. Depending on the value specified in the
///             <i>NameType</i> parameter, the <i>lpName</i> parameter can point to a computer name, workgroup name, domain name,
///             or DNS computer name.
///    lpAccount = If the <i>lpName</i> parameter is a domain name, this parameter points to an account name to use when connecting
///                to the domain controller. The string must specify either a domain NetBIOS name and user account (for example,
///                "REDMOND\user") or the user principal name (UPN) of the user in the form of an Internet-style login name (for
///                example, "someone@example.com"). If this parameter is <b>NULL</b>, the caller's context is used.
///    lpPassword = If the <i>lpAccount</i> parameter specifies an account name, this parameter must point to the password to use
///                 when connecting to the domain controller. Otherwise, this parameter must be <b>NULL</b>.
///    NameType = The type of the name passed in the <i>lpName</i> parameter to validate. This parameter can be one of the values
///               from the NETSETUP_NAME_TYPE enumeration type defined in the <i>Lmjoin.h</i> header file. Note that the
///               <i>Lmjoin.h</i> header is automatically included by the <i>Lm.h</i> header file. The <i>Lmjoin.h</i> header files
///               should not be used directly. The following list shows the possible values for this parameter. <table> <tr>
///               <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="NetSetupUnknown"></a><a
///               id="netsetupunknown"></a><a id="NETSETUPUNKNOWN"></a><dl> <dt><b>NetSetupUnknown</b></dt> <dt>0</dt> </dl> </td>
///               <td width="60%"> The nametype is unknown. If this value is used, the <b>NetValidateName</b> function fails with
///               <b>ERROR_INVALID_PARAMETER</b>. </td> </tr> <tr> <td width="40%"><a id="NetSetupMachine"></a><a
///               id="netsetupmachine"></a><a id="NETSETUPMACHINE"></a><dl> <dt><b>NetSetupMachine</b></dt> <dt>1</dt> </dl> </td>
///               <td width="60%"> Verify that the NetBIOS computer name is valid and that it is not in use. </td> </tr> <tr> <td
///               width="40%"><a id="NetSetupWorkgroup"></a><a id="netsetupworkgroup"></a><a id="NETSETUPWORKGROUP"></a><dl>
///               <dt><b>NetSetupWorkgroup</b></dt> <dt>2</dt> </dl> </td> <td width="60%"> Verify that the workgroup name is
///               valid. </td> </tr> <tr> <td width="40%"><a id="NetSetupDomain"></a><a id="netsetupdomain"></a><a
///               id="NETSETUPDOMAIN"></a><dl> <dt><b>NetSetupDomain</b></dt> <dt>3</dt> </dl> </td> <td width="60%"> Verify that
///               the domain name exists and that it is a domain. </td> </tr> <tr> <td width="40%"><a
///               id="NetSetupNonExistentDomain"></a><a id="netsetupnonexistentdomain"></a><a
///               id="NETSETUPNONEXISTENTDOMAIN"></a><dl> <dt><b>NetSetupNonExistentDomain</b></dt> <dt>4</dt> </dl> </td> <td
///               width="60%"> Verify that the domain name is not in use. </td> </tr> <tr> <td width="40%"><a
///               id="NetSetupDnsMachine"></a><a id="netsetupdnsmachine"></a><a id="NETSETUPDNSMACHINE"></a><dl>
///               <dt><b>NetSetupDnsMachine</b></dt> <dt>5</dt> </dl> </td> <td width="60%"> Verify that the DNS computer name is
///               valid. This value is supported on Windows 2000 and later. The application must be compiled with <b>_WIN32_WINNT
///               &gt;= 0x0500</b> to use this value. </td> </tr> </table>
///Returns:
///    If the function succeeds, the return value is NERR_Success. If the function fails, the return value can be one of
///    the following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
///    <dl> <dt><b>DNS_ERROR_INVALID_NAME_CHAR</b></dt> </dl> </td> <td width="60%"> The DNS name contains an invalid
///    character. This error is returned if the <i>NameType</i> parameter specified is <b>NetSetupDnsMachine</b> and the
///    DNS name in the <i>lpName</i> parameter contains an invalid character. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>DNS_ERROR_NON_RFC_NAME</b></dt> </dl> </td> <td width="60%"> The DNS name does not comply with RFC
///    specifications. This error is returned if the <i>NameType</i> parameter specified is <b>NetSetupDnsMachine</b>
///    and the DNS name in the <i>lpName</i> parameter does not comply with RFC specifications. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_DUP_NAME</b></dt> </dl> </td> <td width="60%"> A duplicate name already exists on
///    the network. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_COMPUTERNAME</b></dt> </dl> </td> <td
///    width="60%"> The format of the specified computer name is not valid. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> A parameter is incorrect. This error is
///    returned if the <i>lpName</i> parameter is <b>NULL</b> or the <i>NameType</i> parameter is specified as
///    <b>NetSetupUnknown</b> or an unknown nametype. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_NO_SUCH_DOMAIN</b></dt> </dl> </td> <td width="60%"> The specified domain does not exist. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NOT_SUPPORTED</b></dt> </dl> </td> <td width="60%"> The request is
///    not supported. This error is returned if a remote computer was specified in the <i>lpServer</i> parameter and
///    this call is not supported on the remote computer. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>NERR_InvalidComputer</b></dt> </dl> </td> <td width="60%"> The specified computer name is not valid. This
///    error is returned if the <i>NameType</i> parameter specified is <b>NetSetupDnsMachine</b> or
///    <b>NetSetupMachine</b> and the specified computer name is not valid. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>NERR_InvalidWorkgroupName</b></dt> </dl> </td> <td width="60%"> The specified workgroup name is not valid.
///    This error is returned if the <i>NameType</i> parameter specified is <b>NetSetupWorkgroup</b> and the specified
///    workgroup name is not valid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_SERVER_UNAVAILABLE</b></dt>
///    </dl> </td> <td width="60%"> The RPC server is not available. This error is returned if a remote computer was
///    specified in the <i>lpServer</i> parameter and the RPC server is not available. </td> </tr> <tr> <td width="40%">
///    <dl> <dt><b>RPC_E_REMOTE_DISABLED</b></dt> </dl> </td> <td width="60%"> Remote calls are not allowed for this
///    process. This error is returned if a remote computer was specified in the <i>lpServer</i> parameter and remote
///    calls are not allowed for this process. </td> </tr> </table>
///    
@DllImport("wkscli")
uint NetValidateName(const(PWSTR) lpServer, const(PWSTR) lpName, const(PWSTR) lpAccount, const(PWSTR) lpPassword, 
                     NETSETUP_NAME_TYPE NameType);

///The <b>NetGetJoinableOUs</b> function retrieves a list of organizational units (OUs) in which a computer account can
///be created.
///Params:
///    lpServer = Pointer to a constant string that specifies the DNS or NetBIOS name of the computer on which to call the
///               function. If this parameter is <b>NULL</b>, the local computer is used.
///    lpDomain = Pointer to a constant string that specifies the name of the domain for which to retrieve the list of OUs that can
///               be joined.
///    lpAccount = Pointer to a constant string that specifies the account name to use when connecting to the domain controller. The
///                string must specify either a domain NetBIOS name and user account (for example, "REDMOND\user") or the user
///                principal name (UPN) of the user in the form of an Internet-style login name (for example,
///                "someone@example.com"). If this parameter is <b>NULL</b>, the caller's context is used.
///    lpPassword = If the <i>lpAccount</i> parameter specifies an account name, this parameter must point to the password to use
///                 when connecting to the domain controller. Otherwise, this parameter must be <b>NULL</b>.
///    OUCount = Receives the count of OUs returned in the list of joinable OUs.
///    OUs = Pointer to an array that receives the list of joinable OUs. This array is allocated by the system and must be
///          freed using a single call to the NetApiBufferFree function. For more information, see Network Management Function
///          Buffers and Network Management Function Buffer Lengths.
///Returns:
///    If the function succeeds, the return value is NERR_Success. If the function fails, the return value can be one of
///    the following error codes or one of the system error codes. <table> <tr> <th>Return code</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NOT_ENOUGH_MEMORY</b></dt> </dl> </td> <td
///    width="60%"> Not enough storage is available to process this command. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>NERR_DefaultJoinRequired</b></dt> </dl> </td> <td width="60%"> The destination domain controller does not
///    support creating computer accounts in OUs. </td> </tr> </table>
///    
@DllImport("wkscli")
uint NetGetJoinableOUs(const(PWSTR) lpServer, const(PWSTR) lpDomain, const(PWSTR) lpAccount, 
                       const(PWSTR) lpPassword, uint* OUCount, PWSTR** OUs);

///The <b>NetAddAlternateComputerName</b> function adds an alternate name for the specified computer.
///Params:
///    Server = A pointer to a constant string that specifies the name of the computer on which to execute this function. If this
///             parameter is <b>NULL</b>, the local computer is used.
///    AlternateName = A pointer to a constant string that specifies the alternate name to add. This name must be in the form of a fully
///                    qualified DNS name.
///    DomainAccount = A pointer to a constant string that specifies the domain account to use for accessing the machine account object
///                    for the computer specified in the <i>Server</i> parameter in Active Directory. If this parameter is <b>NULL</b>,
///                    then the credentials of the user executing this routine are used. This parameter is not used if the server to
///                    execute this function is not joined to a domain.
///    DomainAccountPassword = A pointer to a constant string that specifies the password matching the domain account passed in the
///                            <i>DomainAccount</i> parameter. If this parameter is <b>NULL</b>, then the credentials of the user executing this
///                            routine are used. This parameter is ignored if the <i>DomainAccount</i> parameter is <b>NULL</b>. This parameter
///                            is not used if the server to execute this function is not joined to a domain.
///    Reserved = Reserved for future use. This parameter should be <b>NULL</b>.
///Returns:
///    If the function succeeds, the return value is NERR_Success. If the function fails, the return value can be one of
///    the following error codes or one of the system error codes. <table> <tr> <th>Return code</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td
///    width="60%"> Access is denied. This error is returned if the caller was not a member of the Administrators local
///    group on the target computer. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_NAME</b></dt> </dl>
///    </td> <td width="60%"> A name parameter is incorrect. This error is returned if the <i>AlternateName</i>
///    parameter does not contain valid name. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> A parameter is incorrect. This error is
///    returned if the <i>DomainAccount</i> parameter does not contain a valid domain. This error is also returned if
///    the <i>DomainAccount</i> parameter is not <b>NULL</b> and the <i>DomainAccountPassword</i> parameter is not
///    <b>NULL</b> but does not contain a Unicode string. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_NOT_ENOUGH_MEMORY</b></dt> </dl> </td> <td width="60%"> Not enough memory is available to process
///    this command. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NOT_SUPPORTED</b></dt> </dl> </td> <td
///    width="60%"> The request is not supported. This error is returned if the target computer specified in the
///    <i>Server</i> parameter on which this function executes is running on Windows 2000 and earlier. </td> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>NERR_WkstaNotStarted</b></dt> </dl> </td> <td width="60%"> The Workstation service
///    has not been started. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_CALL_IN_PROGRESS</b></dt> </dl> </td>
///    <td width="60%"> A remote procedure call is already in progress for this thread. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>RPC_S_PROTSEQ_NOT_SUPPORTED</b></dt> </dl> </td> <td width="60%"> The remote procedure
///    call protocol sequence is not supported. </td> </tr> </table>
///    
@DllImport("wkscli")
uint NetAddAlternateComputerName(const(PWSTR) Server, const(PWSTR) AlternateName, const(PWSTR) DomainAccount, 
                                 const(PWSTR) DomainAccountPassword, uint Reserved);

///The <b>NetRemoveAlternateComputerName</b> function removes an alternate name for the specified computer.
///Params:
///    Server = A pointer to a constant string that specifies the name of the computer on which to execute this function. If this
///             parameter is <b>NULL</b>, the local computer is used.
///    AlternateName = A pointer to a constant string that specifies the alternate name to remove. This name must be in the form of a
///                    fully qualified DNS name.
///    DomainAccount = A pointer to a constant string that specifies the domain account to use for accessing the machine account object
///                    for the computer specified in the <i>Server</i> parameter in Active Directory. If this parameter is <b>NULL</b>,
///                    then the credentials of the user executing this routine are used. This parameter is not used if the server to
///                    execute this function is not joined to a domain.
///    DomainAccountPassword = A pointer to a constant string that specifies the password matching the domain account passed in the
///                            <i>DomainAccount</i> parameter. If this parameter is <b>NULL</b>, then the credentials of the user executing this
///                            routine are used. This parameter is ignored if the <i>DomainAccount</i> parameter is <b>NULL</b>. This parameter
///                            is not used if the server to execute this function is not joined to a domain.
///    Reserved = Reserved for future use. This parameter should be <b>NULL</b>.
///Returns:
///    If the function succeeds, the return value is NERR_Success. If the function fails, the return value can be one of
///    the following error codes or one of the system error codes. <table> <tr> <th>Return code</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td
///    width="60%"> Access is denied. This error is returned if the caller was not a member of the Administrators local
///    group on the target computer. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_NAME</b></dt> </dl>
///    </td> <td width="60%"> A name parameter is incorrect. This error is returned if the <i>AlternateName</i>
///    parameter does not contain valid name. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> A parameter is incorrect. This error is
///    returned if the <i>DomainAccount</i> parameter does not contain a valid domain. This error is also returned if
///    the <i>DomainAccount</i> parameter is not <b>NULL</b> and the <i>DomainAccountPassword</i> parameter is not
///    <b>NULL</b> but does not contain a Unicode string. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_NOT_ENOUGH_MEMORY</b></dt> </dl> </td> <td width="60%"> Not enough memory is available to process
///    this command. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NOT_SUPPORTED</b></dt> </dl> </td> <td
///    width="60%"> The request is not supported. This error is returned if the target computer specified in the
///    <i>Server</i> parameter on which this function executes is running on Windows 2000 and earlier. </td> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>NERR_WkstaNotStarted</b></dt> </dl> </td> <td width="60%"> The Workstation service
///    has not been started. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_CALL_IN_PROGRESS</b></dt> </dl> </td>
///    <td width="60%"> A remote procedure call is already in progress for this thread. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>RPC_S_PROTSEQ_NOT_SUPPORTED</b></dt> </dl> </td> <td width="60%"> The remote procedure
///    call protocol sequence is not supported. </td> </tr> </table>
///    
@DllImport("wkscli")
uint NetRemoveAlternateComputerName(const(PWSTR) Server, const(PWSTR) AlternateName, const(PWSTR) DomainAccount, 
                                    const(PWSTR) DomainAccountPassword, uint Reserved);

///The <b>NetSetPrimaryComputerName</b> function sets the primary computer name for the specified computer.
///Params:
///    Server = A pointer to a constant string that specifies the name of the computer on which to execute this function. If this
///             parameter is <b>NULL</b>, the local computer is used.
///    PrimaryName = A pointer to a constant string that specifies the primary name to set. This name must be in the form of a fully
///                  qualified DNS name.
///    DomainAccount = A pointer to a constant string that specifies the domain account to use for accessing the machine account object
///                    for the computer specified in the <i>Server</i> parameter in Active Directory. If this parameter is <b>NULL</b>,
///                    then the credentials of the user executing this routine are used. This parameter is not used if the server to
///                    execute this function is not joined to a domain.
///    DomainAccountPassword = A pointer to a constant string that specifies the password matching the domain account passed in the
///                            <i>DomainAccount</i> parameter. If this parameter is <b>NULL</b>, then the credentials of the user executing this
///                            routine are used. This parameter is ignored if the <i>DomainAccount</i> parameter is <b>NULL</b>. This parameter
///                            is not used if the server to execute this function is not joined to a domain.
///    Reserved = Reserved for future use. This parameter should be <b>NULL</b>.
///Returns:
///    If the function succeeds, the return value is NERR_Success. If the function fails, the return value can be one of
///    the following error codes or one of the system error codes. <table> <tr> <th>Return code</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td
///    width="60%"> Access is denied. This error is returned if the caller was not a member of the Administrators local
///    group on the target computer. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_NAME</b></dt> </dl>
///    </td> <td width="60%"> A name parameter is incorrect. This error is returned if the <i>PrimaryName</i> parameter
///    does not contain valid name. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl>
///    </td> <td width="60%"> A parameter is incorrect. This error is returned if the <i>DomainAccount</i> parameter
///    does not contain a valid domain. This error is also returned if the <i>DomainAccount</i> parameter is not
///    <b>NULL</b> and the <i>DomainAccountPassword</i> parameter is not <b>NULL</b> but does not contain a Unicode
///    string. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NOT_ENOUGH_MEMORY</b></dt> </dl> </td> <td
///    width="60%"> Not enough memory is available to process this command. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_NOT_SUPPORTED</b></dt> </dl> </td> <td width="60%"> The request is not supported. This error is
///    returned if the target computer specified in the <i>Server</i> parameter on which this function executes is
///    running on Windows 2000 and earlier. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>NERR_WkstaNotStarted</b></dt>
///    </dl> </td> <td width="60%"> The Workstation service has not been started. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>RPC_S_CALL_IN_PROGRESS</b></dt> </dl> </td> <td width="60%"> A remote procedure call is already in
///    progress for this thread. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_PROTSEQ_NOT_SUPPORTED</b></dt>
///    </dl> </td> <td width="60%"> The remote procedure call protocol sequence is not supported. </td> </tr> </table>
///    
@DllImport("wkscli")
uint NetSetPrimaryComputerName(const(PWSTR) Server, const(PWSTR) PrimaryName, const(PWSTR) DomainAccount, 
                               const(PWSTR) DomainAccountPassword, uint Reserved);

///The <b>NetEnumerateComputerNames</b> function enumerates names for the specified computer.
///Params:
///    Server = A pointer to a constant string that specifies the name of the computer on which to execute this function. If this
///             parameter is <b>NULL</b>, the local computer is used.
///    NameType = The type of the name queried. This member can be one of the following values defined in the
///               <b>NET_COMPUTER_NAME_TYPE</b> enumeration defined in the <i>Lmjoin.h</i> header file. <table> <tr> <th>Value</th>
///               <th>Meaning</th> </tr> <tr> <td width="40%"><a id="NetPrimaryComputerName"></a><a
///               id="netprimarycomputername"></a><a id="NETPRIMARYCOMPUTERNAME"></a><dl> <dt><b>NetPrimaryComputerName</b></dt>
///               </dl> </td> <td width="60%"> The primary computer name. </td> </tr> <tr> <td width="40%"><a
///               id="NetAlternateComputerNames"></a><a id="netalternatecomputernames"></a><a
///               id="NETALTERNATECOMPUTERNAMES"></a><dl> <dt><b>NetAlternateComputerNames</b></dt> </dl> </td> <td width="60%">
///               Alternate computer names. </td> </tr> <tr> <td width="40%"><a id="NetAllComputerNames"></a><a
///               id="netallcomputernames"></a><a id="NETALLCOMPUTERNAMES"></a><dl> <dt><b>NetAllComputerNames</b></dt> </dl> </td>
///               <td width="60%"> All computer names. </td> </tr> <tr> <td width="40%"><a id="NetComputerNameTypeMax"></a><a
///               id="netcomputernametypemax"></a><a id="NETCOMPUTERNAMETYPEMAX"></a><dl> <dt><b>NetComputerNameTypeMax</b></dt>
///               </dl> </td> <td width="60%"> Indicates the end of the range that specifies the possible values for the type of
///               name to be queried. </td> </tr> </table>
///    Reserved = Reserved for future use. This parameter should be <b>NULL</b>.
///    EntryCount = A pointer to a DWORD value that returns the number of names returned in the buffer pointed to by the
///                 <i>ComputerNames</i> parameter if the function succeeds.
///    ComputerNames = A pointer to an array of pointers to names. If the function call is successful, this parameter will return the
///                    computer names that match the computer type name specified in the <i>NameType</i> parameter. When the application
///                    no longer needs this array, this buffer should be freed by calling NetApiBufferFree function.
///Returns:
///    If the function succeeds, the return value is NERR_Success. If the function fails, the return value can be one of
///    the following error codes or one of the system error codes. <table> <tr> <th>Return code</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td
///    width="60%"> Access is denied. This error is returned if the caller was not a member of the Administrators local
///    group on the target computer. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt>
///    </dl> </td> <td width="60%"> A parameter is incorrect. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_NOT_ENOUGH_MEMORY</b></dt> </dl> </td> <td width="60%"> Not enough memory is available to process
///    this command. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NOT_SUPPORTED</b></dt> </dl> </td> <td
///    width="60%"> The request is not supported. This error is returned if the target computer specified in the
///    <i>Server</i> parameter on which this function executes is running on Windows 2000 and earlier. </td> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>NERR_WkstaNotStarted</b></dt> </dl> </td> <td width="60%"> The Workstation service
///    has not been started. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_CALL_IN_PROGRESS</b></dt> </dl> </td>
///    <td width="60%"> A remote procedure call is already in progress for this thread. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>RPC_S_PROTSEQ_NOT_SUPPORTED</b></dt> </dl> </td> <td width="60%"> The remote procedure
///    call protocol sequence is not supported. </td> </tr> </table>
///    
@DllImport("wkscli")
uint NetEnumerateComputerNames(const(PWSTR) Server, NET_COMPUTER_NAME_TYPE NameType, uint Reserved, 
                               uint* EntryCount, PWSTR** ComputerNames);

///The <b>NetProvisionComputerAccount</b> function provisions a computer account for later use in an offline domain join
///operation.
///Params:
///    lpDomain = A pointer to a <b>NULL</b>-terminated character string that specifies the name of the domain where the computer
///               account is created.
///    lpMachineName = A pointer to a <b>NULL</b>-terminated character string that specifies the short name of the machine from which
///                    the computer account attribute sAMAccountName is derived by appending a '$'. This parameter must contain a valid
///                    DNS or NetBIOS machine name.
///    lpMachineAccountOU = An optional pointer to a <b>NULL</b>-terminated character string that contains the RFC 1779 format name of the
///                         organizational unit (OU) where the computer account will be created. If you specify this parameter, the string
///                         must contain a full path, for example, OU=testOU,DC=domain,DC=Domain,DC=com. Otherwise, this parameter must be
///                         <b>NULL</b>. If this parameter is <b>NULL</b>, the well known computer object container will be used as published
///                         in the domain.
///    lpDcName = An optional pointer to a <b>NULL</b>-terminated character string that contains the name of the domain controller
///               to target.
///    dwOptions = A set of bit flags that define provisioning options. This parameter can be one or more of the following values
///                defined in the <i>Lmjoin.h</i> header file. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td
///                width="40%"><a id="NETSETUP_PROVISION_DOWNLEVEL_PRIV_SUPPORT"></a><a
///                id="netsetup_provision_downlevel_priv_support"></a><dl> <dt><b>NETSETUP_PROVISION_DOWNLEVEL_PRIV_SUPPORT</b></dt>
///                <dt>0x00000001</dt> </dl> </td> <td width="60%"> If the caller requires account creation by privilege, this
///                option will cause a retry on failure using account creation functions enabling interoperability with domain
///                controllers running on earlier versions of Windows. The <i>lpMachineAccountOU</i> is not supported when using
///                downlevel privilege support. </td> </tr> <tr> <td width="40%"><a id="NETSETUP_PROVISION_REUSE_ACCOUNT"></a><a
///                id="netsetup_provision_reuse_account"></a><dl> <dt><b>NETSETUP_PROVISION_REUSE_ACCOUNT</b></dt>
///                <dt>0x00000002</dt> </dl> </td> <td width="60%"> If the named account already exists, an attempt will be made to
///                reuse the existing account. This option requires sufficient credentials for this operation (Domain Administrator
///                or the object owner). </td> </tr> <tr> <td width="40%"><a id="NETSETUP_PROVISION_USE_DEFAULT_PASSWORD"></a><a
///                id="netsetup_provision_use_default_password"></a><dl> <dt><b>NETSETUP_PROVISION_USE_DEFAULT_PASSWORD</b></dt>
///                <dt>0x00000004</dt> </dl> </td> <td width="60%"> Use the default machine account password which is the machine
///                name in lowercase. This is largely to support the older unsecure join model where the pre-created account
///                typically used this default password. <div class="alert"><b>Note</b> Applications should avoid using this option
///                if possible. This option as well as NetJoinDomain function with dwOptions set to NETSETUP_JOIN_UNSECURE for
///                unsecure join should only be used on earlier versions of Windows. </div> <div> </div> </td> </tr> <tr> <td
///                width="40%"><a id="NETSETUP_PROVISION_SKIP_ACCOUNT_SEARCH"></a><a
///                id="netsetup_provision_skip_account_search"></a><dl> <dt><b>NETSETUP_PROVISION_SKIP_ACCOUNT_SEARCH</b></dt>
///                <dt>0x00000008</dt> </dl> </td> <td width="60%"> Do not try to find the account on any domain controller in the
///                domain. This option makes the operation faster, but should only be used when the caller is certain that an
///                account by the same name hasn't recently been created. This option is only valid when the <i>lpDcName</i>
///                parameter is specified. When the prerequisites are met, this option allows for must faster provisioning useful
///                for scenarios such as batch processing. </td> </tr> <tr> <td width="40%"><a
///                id="NETSETUP_PROVISION_ROOT_CA_CERTS"></a><a id="netsetup_provision_root_ca_certs"></a><dl>
///                <dt><b>NETSETUP_PROVISION_ROOT_CA_CERTS</b></dt> <dt>0x00000010</dt> </dl> </td> <td width="60%"> This option
///                retrieves all of the root Certificate Authority certificates on the local machine and adds them to the
///                provisioning package when no certificate template names are provided as part of the provisioning package (the
///                <b>aCertTemplateNames</b> member of the NETSETUP_PROVISIONING_PARAMS struct passed in the
///                <i>pProvisioningParams</i> parameter to the NetCreateProvisioningPackage function is NULL). <div
///                class="alert"><b>Note</b> This flag is only supported by the NetCreateProvisioningPackage function on Windows 8,
///                Windows Server 2012, and later.</div> <div> </div> </td> </tr> </table>
///    pProvisionBinData = An optional pointer that will receive the opaque binary blob of serialized metadata required by
///                        NetRequestOfflineDomainJoin function to complete an offline domain join, if the
///                        <b>NetProvisionComputerAccount</b> function completes successfully. The data is returned as an opaque binary
///                        buffer which may be passed to <b>NetRequestOfflineDomainJoin</b> function. If this parameter is <b>NULL</b>, then
///                        <i>pProvisionTextData</i> parameter must not be <b>NULL</b>. If this parameter is not <b>NULL</b>, then the
///                        <i>pProvisionTextData</i> parameter must be <b>NULL</b>.
///    pdwProvisionBinDataSize = A pointer to a value that receives the size, in bytes, of the buffer returned in the <i>pProvisionBinData</i>
///                              parameter. This parameter must not be <b>NULL</b> if the <i>pProvisionBinData</i> parameter is not <b>NULL</b>.
///                              This parameter must be <b>NULL</b> when the <i>pProvisionBinData</i> parameter is <b>NULL</b>.
///    pProvisionTextData = An optional pointer that will receive the opaque binary blob of serialized metadata required by
///                         NetRequestOfflineDomainJoin function to complete an offline domain join, if the
///                         <b>NetProvisionComputerAccount</b> function completes successfully. The data is returned in string form for
///                         embedding in an unattended setup answer file. If this parameter is <b>NULL</b>, then the <i>pProvisionBinData</i>
///                         parameter must not be <b>NULL</b>. If this parameter is not <b>NULL</b>, then the the <i>pProvisionBinData</i>
///                         parameter must be <b>NULL</b>.
///Returns:
///    If the function succeeds, the return value is NERR_Success. If the function fails, the return value can be one of
///    the following error codes or one of the system error codes. <table> <tr> <th>Return code</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td
///    width="60%"> Access is denied. This error is returned if the caller does not have sufficient privileges to
///    complete the operation. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_DOMAIN_ROLE</b></dt> </dl>
///    </td> <td width="60%"> This operation is only allowed for the Primary Domain Controller of the domain. This error
///    is returned if a domain controller name was specified in the <i>lpDcName</i> parameter, but the computer
///    specified could not be validated as a domain controller for the target domain specified in the <i>lpDomain</i>
///    parameter. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td
///    width="60%"> A parameter is incorrect. This error is returned if the <i>lpDomain</i> or <i>lpMachineName</i>
///    parameter is <b>NULL</b>. This error is also returned if both the <i>pProvisionBinData</i> and
///    <i>pProvisionTextData</i> parameters are <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_NO_SUCH_DOMAIN</b></dt> </dl> </td> <td width="60%"> The specified domain did not exist. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>ERROR_NOT_SUPPORTED</b></dt> </dl> </td> <td width="60%"> The request is not
///    supported. This error is returned if the <i>lpMachineAccountOU</i> parameter was specified and the domain
///    controller is running on an earlier versions of Windows that does not support this parameter. </td> </tr> <tr>
///    <td width="40%"> <dl> <dt><b> NERR_DS8DCRequired</b></dt> </dl> </td> <td width="60%"> The specified domain
///    controller does not meet the version requirement for this operation. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b> NERR_LDAPCapableDCRequired</b></dt> </dl> </td> <td width="60%"> This operation requires a domain
///    controller which supports LDAP. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>NERR_UserExists</b></dt> </dl>
///    </td> <td width="60%"> The account already exists in the domain and the NETSETUP_PROVISION_REUSE_ACCOUNT bit was
///    not specified in the <i>dwOptions</i> parameter. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>NERR_WkstaNotStarted</b></dt> </dl> </td> <td width="60%"> The Workstation service has not been started.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_CALL_IN_PROGRESS</b></dt> </dl> </td> <td width="60%"> A
///    remote procedure call is already in progress for this thread. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>RPC_S_PROTSEQ_NOT_SUPPORTED</b></dt> </dl> </td> <td width="60%"> The remote procedure call protocol
///    sequence is not supported. </td> </tr> </table>
///    
@DllImport("NETAPI32")
uint NetProvisionComputerAccount(const(PWSTR) lpDomain, const(PWSTR) lpMachineName, 
                                 const(PWSTR) lpMachineAccountOU, const(PWSTR) lpDcName, uint dwOptions, 
                                 ubyte** pProvisionBinData, uint* pdwProvisionBinDataSize, PWSTR* pProvisionTextData);

///The <b>NetRequestOfflineDomainJoin</b> function executes locally on a machine to modify a Windows operating system
///image mounted on a volume. The registry is loaded from the image and provisioning blob data is written where it can
///be retrieved during the completion phase of an offline domain join operation.
///Params:
///    pProvisionBinData = A pointer to a buffer required to initialize the registry of a Windows operating system image to process the
///                        final local state change during the completion phase of the offline domain join operation. The opaque binary blob
///                        of serialized metadata passed in the <i>pProvisionBinData</i> parameter is returned by the
///                        NetProvisionComputerAccount function.
///    cbProvisionBinDataSize = The size, in bytes, of the buffer pointed to by the <i>pProvisionBinData</i> parameter. This parameter must not
///                             be <b>NULL</b>.
///    dwOptions = A set of bit flags that define options for this function. This parameter can be one or more of the following
///                values defined in the <i>Lmjoin.h</i> header file. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td
///                width="40%"><a id="NETSETUP_PROVISION_ONLINE_CALLER"></a><a id="netsetup_provision_online_caller"></a><dl>
///                <dt><b>NETSETUP_PROVISION_ONLINE_CALLER</b></dt> <dt>0x40000000</dt> </dl> </td> <td width="60%"> This flag is
///                required if the <i>lpWindowsPath</i> parameter references the currently running Windows operating system
///                directory rather than an offline Windows operating system image mounted on an accessible volume. If this flag is
///                specified, the <b>NetRequestOfflineDomainJoin</b> function must be invoked by a member of the local
///                Administrators group. </td> </tr> </table>
///    lpWindowsPath = A pointer to a constant null-terminated character string that specifies the path to a Windows operating system
///                    image under which the registry hives are located. This image must be offline and not currently booted unless the
///                    <i>dwOptions</i> parameter contains <b>NETSETUP_PROVISION_ONLINE_CALLER</b> in which case the locally running
///                    operating system directory is allowed. This path could be a UNC path on a remote server.
///Returns:
///    If the function succeeds, the return value is NERR_Success. If the function fails, the return value can be one of
///    the following error codes or one of the system error codes. <table> <tr> <th>Return code</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td
///    width="60%"> Access is denied. This error is returned if the caller does not have sufficient privileges to
///    complete the operation. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_ELEVATION_REQUIRED</b></dt> </dl>
///    </td> <td width="60%"> The requested operation requires elevation. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> A parameter is incorrect. This error is
///    returned if the <i>pProvisionBinData</i>, <i>cbProvisionBinDataSize</i>, or <i>lpWindowsPath</i> parameters are
///    <b>NULL</b>. This error is also returned if the buffer pointed to by the <i>pProvisionBinData</i> parameter does
///    not contain valid data in the blob for the domain, machine account name, or machine account password. This error
///    is also returned if the string pointed to <i>lpWindowsPath</i> parameter does not specific the path to a Windows
///    operating system image. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NOT_SUPPORTED</b></dt> </dl> </td>
///    <td width="60%"> The request is not supported. This error is returned if the specified server does not support
///    this operation. For example, if the <i>lpWindowsPath</i> parameter references a Windows installation configured
///    as a domain controller. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>NERR_WkstaNotStarted</b></dt> </dl> </td>
///    <td width="60%"> The Workstation service has not been started. </td> </tr> </table>
///    
@DllImport("NETAPI32")
uint NetRequestOfflineDomainJoin(ubyte* pProvisionBinData, uint cbProvisionBinDataSize, uint dwOptions, 
                                 const(PWSTR) lpWindowsPath);

///The NetCreateProvisioningPackage function creates a provisioning package that provisions a computer account for later
///use in an offline domain join operation. The package may also contain information about certificates and policies to
///add to the machine during provisioning.
///Params:
///    pProvisioningParams = A pointer to a NETSETUP_PROVISIONING_PARAMS structure that contains information about the provisioning package.
///                          The following values are defined for the members of this structure: <table> <tr> <th>Value</th> <th>Meaning</th>
///                          </tr> <tr> <td width="40%"><a id="dwVersion"></a><a id="dwversion"></a><a id="DWVERSION"></a><dl>
///                          <dt><b>dwVersion</b></dt> </dl> </td> <td width="60%"> The version of Windows in the provisioning package. This
///                          member should use the following value defined in the <i>Lmjoin.h</i> header file:
///                          NETSETUP_PROVISIONING_PARAMS_CURRENT_VERSION (0x00000001) </td> </tr> <tr> <td width="40%"><a
///                          id="lpDomain"></a><a id="lpdomain"></a><a id="LPDOMAIN"></a><dl> <dt><b>lpDomain</b></dt> </dl> </td> <td
///                          width="60%"> A pointer to a constant null-terminated character string that specifies the name of the domain where
///                          the computer account is created. </td> </tr> <tr> <td width="40%"><a id="lpMachineName"></a><a
///                          id="lpmachinename"></a><a id="LPMACHINENAME"></a><dl> <dt><b>lpMachineName</b></dt> </dl> </td> <td width="60%">
///                          A pointer to a constant null-terminated character string that specifies the short name of the machine from which
///                          the computer account attribute sAMAccountName is derived by appending a '$'. This parameter must contain a valid
///                          DNS or NetBIOS machine name. </td> </tr> <tr> <td width="40%"><a id="lpMachineAccountOU"></a><a
///                          id="lpmachineaccountou"></a><a id="LPMACHINEACCOUNTOU"></a><dl> <dt><b>lpMachineAccountOU</b></dt> </dl> </td>
///                          <td width="60%"> An optional pointer to a constant null-terminated character string that contains the RFC 1779
///                          format name of the organizational unit (OU) where the computer account will be created. If you specify this
///                          parameter, the string must contain a full path, for example, OU=testOU,DC=domain,DC=Domain,DC=com. Otherwise,
///                          this parameter must be <b>NULL</b>. If this parameter is <b>NULL</b>, the well known computer object container
///                          will be used as published in the domain. </td> </tr> <tr> <td width="40%"><a id="lpDcName"></a><a
///                          id="lpdcname"></a><a id="LPDCNAME"></a><dl> <dt><b>lpDcName</b></dt> </dl> </td> <td width="60%"> An optional
///                          pointer to a constant null-terminated character string that contains the name of the domain controller to target.
///                          </td> </tr> <tr> <td width="40%"><a id="dwProvisionOptions"></a><a id="dwprovisionoptions"></a><a
///                          id="DWPROVISIONOPTIONS"></a><dl> <dt><b>dwProvisionOptions</b></dt> </dl> </td> <td width="60%"> A set of bit
///                          flags that define provisioning options. This parameter can be one or more of the values specified for the
///                          <i>dwOptions</i> parameter passed to the NetProvisionComputerAccount function. These possible values are defined
///                          in the <i>Lmjoin.h</i> header file. The <b>NETSETUP_PROVISION_ROOT_CA_CERTS</b> option is only supported on
///                          Windows 8 and Windows Server 2012. </td> </tr> <tr> <td width="40%"><a id="aCertTemplateNames"></a><a
///                          id="acerttemplatenames"></a><a id="ACERTTEMPLATENAMES"></a><dl> <dt><b>aCertTemplateNames</b></dt> </dl> </td>
///                          <td width="60%"> A optional pointer to an array of <b>NULL</b>-terminated certificate template names. </td> </tr>
///                          <tr> <td width="40%"><a id="cCertTemplateNames"></a><a id="ccerttemplatenames"></a><a
///                          id="CCERTTEMPLATENAMES"></a><dl> <dt><b>cCertTemplateNames</b></dt> </dl> </td> <td width="60%"> When
///                          <b>aCertTemplateNames</b> is not NULL, this member provides an explicit count of the number of items in the
///                          array. </td> </tr> <tr> <td width="40%"><a id="aMachinePolicyNames"></a><a id="amachinepolicynames"></a><a
///                          id="AMACHINEPOLICYNAMES"></a><dl> <dt><b>aMachinePolicyNames</b></dt> </dl> </td> <td width="60%"> An optional
///                          pointer to an array of <b>NULL</b>-terminated machine policy names. </td> </tr> <tr> <td width="40%"><a
///                          id="cMachinePolicyNames"></a><a id="cmachinepolicynames"></a><a id="CMACHINEPOLICYNAMES"></a><dl>
///                          <dt><b>cMachinePolicyNames</b></dt> </dl> </td> <td width="60%"> When <b>aMachinePolicyNames</b> is not
///                          <b>NULL</b>, this member provides an explicit count of the number of items in the array. </td> </tr> <tr> <td
///                          width="40%"><a id="aMachinePolicyPaths"></a><a id="amachinepolicypaths"></a><a id="AMACHINEPOLICYPATHS"></a><dl>
///                          <dt><b>aMachinePolicyPaths</b></dt> </dl> </td> <td width="60%"> An optional pointer to an array of character
///                          strings. Each array element is a NULL-terminated character string which specifies the full or partial path to a
///                          file in the Registry Policy File format. For more information on the Registry Policy File Format , see Registry
///                          Policy File Format The path could be a UNC path on a remote server. </td> </tr> <tr> <td width="40%"><a
///                          id="cMachinePolicyPaths"></a><a id="cmachinepolicypaths"></a><a id="CMACHINEPOLICYPATHS"></a><dl>
///                          <dt><b>cMachinePolicyPaths</b></dt> </dl> </td> <td width="60%"> When <b>aMachinePolicyPaths</b> is not
///                          <b>NULL</b>, this member provides an explicit count of the number of items in the array. </td> </tr> </table>
///    ppPackageBinData = An optional pointer that will receive the package required by NetRequestOfflineDomainJoin function to complete an
///                       offline domain join, if the NetProvisionComputerAccount function completes successfully. The data is returned as
///                       an opaque binary buffer which may be passed to <b>NetRequestOfflineDomainJoin</b> function. If this parameter is
///                       <b>NULL</b>, then <i>pPackageTextData</i> parameter must not be <b>NULL</b>. If this parameter is not
///                       <b>NULL</b>, then the <i>pPackageTextData</i> parameter must be <b>NULL</b>.
///    pdwPackageBinDataSize = A pointer to a value that receives the size, in bytes, of the buffer returned in the <i>pProvisionBinData</i>
///                            parameter. This parameter must not be <b>NULL</b> if the <i>pPackageBinData</i> parameter is not <b>NULL</b>.
///                            This parameter must be <b>NULL</b> when the <i>pPackageBinData</i> parameter is <b>NULL</b>.
///    ppPackageTextData = An optional pointer that will receive the package required by NetRequestOfflineDomainJoin function to complete an
///                        offline domain join, if the NetProvisionComputerAccount function completes successfully. The data is returned in
///                        string form for embedding in an unattended setup answer file. If this parameter is <b>NULL</b>, then the
///                        <i>pPackageBinData</i> parameter must not be <b>NULL</b>. If this parameter is not <b>NULL</b>, then the the
///                        <i>pPackageBinData</i> parameter must be <b>NULL</b>.
///Returns:
///    If the function succeeds, the return value is NERR_Success. If the function fails, the return value can be one of
///    the following error codes or one of the system error codes. <table> <tr> <th>Return code</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td
///    width="60%"> Access is denied. This error is returned if the caller does not have sufficient privileges to
///    complete the operation. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_DOMAIN_ROLE</b></dt> </dl>
///    </td> <td width="60%"> This operation is only allowed for the Primary Domain Controller of the domain. This error
///    is returned if a domain controller name was specified in the <b>lpDcName </b> of the NETSETUP_PROVISIONING_PARAMS
///    struct pointed to by the <i>pProvisioningParams</i> parameter, but the computer specified could not be validated
///    as a domain controller for the target domain specified in the <b>lpDomain</b> of the
///    <b>NETSETUP_PROVISIONING_PARAMS</b>. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> A parameter is incorrect. This error is also
///    returned if both the <i>pProvisioningParams</i> parameter is <b>NULL</b>. This error is also returned if the
///    <b>lpDomain</b> or <b>lpMachineName</b> member of the NETSETUP_PROVISIONING_PARAMS struct pointed to by the
///    <i>pProvisioningParams</i> parameter is <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_NO_SUCH_DOMAIN</b></dt> </dl> </td> <td width="60%"> The specified domain did not exist. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>ERROR_NOT_SUPPORTED</b></dt> </dl> </td> <td width="60%"> The request is not
///    supported. This error is returned if the <b>lpMachineAccountOU</b> member was specified in the
///    NETSETUP_PROVISIONING_PARAMS struct pointed to by the <i>pProvisioningParams</i> parameter and the domain
///    controller is running on an earlier versions of Windows that does not support this parameter. </td> </tr> <tr>
///    <td width="40%"> <dl> <dt><b> NERR_DS8DCRequired</b></dt> </dl> </td> <td width="60%"> The specified domain
///    controller does not meet the version requirement for this operation. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b> NERR_LDAPCapableDCRequired</b></dt> </dl> </td> <td width="60%"> This operation requires a domain
///    controller which supports LDAP. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>NERR_UserExists</b></dt> </dl>
///    </td> <td width="60%"> The account already exists in the domain and the <b>NETSETUP_PROVISION_REUSE_ACCOUNT</b>
///    bit was not specified in the <b>dwProvisionOptions</b> member of the NETSETUP_PROVISIONING_PARAMS struct pointed
///    to by the <i>pProvisioningParams</i> parameter. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>NERR_WkstaNotStarted</b></dt> </dl> </td> <td width="60%"> The Workstation service has not been started.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_CALL_IN_PROGRESS</b></dt> </dl> </td> <td width="60%"> A
///    remote procedure call is already in progress for this thread. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>RPC_S_PROTSEQ_NOT_SUPPORTED</b></dt> </dl> </td> <td width="60%"> The remote procedure call protocol
///    sequence is not supported. </td> </tr> </table>
///    
@DllImport("NETAPI32")
uint NetCreateProvisioningPackage(NETSETUP_PROVISIONING_PARAMS* pProvisioningParams, ubyte** ppPackageBinData, 
                                  uint* pdwPackageBinDataSize, PWSTR* ppPackageTextData);

///The <b>NetRequestProvisioningPackageInstall</b> function executes locally on a machine to modify a Windows operating
///system image mounted on a volume. The registry is loaded from the image and provisioning package data is written
///where it can be retrieved during the completion phase of an offline domain join operation.
///Params:
///    pPackageBinData = A pointer to a buffer required to initialize the registry of a Windows operating system image to process the
///                      final local state change during the completion phase of the offline domain join operation. The opaque binary blob
///                      of serialized metadata passed in the <i>pPackageBinData</i> parameter is returned by the
///                      NetCreateProvisioningPackage function.
///    dwPackageBinDataSize = The size, in bytes, of the buffer pointed to by the <i>pPackageBinData</i> parameter. This parameter must not be
///                           <b>NULL</b>.
///    dwProvisionOptions = A set of bit flags that define options for this function. This parameter uses one or more of the following values
///                         defined in the <i>Lmjoin.h</i> header file. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td
///                         width="40%"><a id="NETSETUP_PROVISION_ONLINE_CALLER"></a><a id="netsetup_provision_online_caller"></a><dl>
///                         <dt><b>NETSETUP_PROVISION_ONLINE_CALLER</b></dt> <dt>0x40000000</dt> </dl> </td> <td width="60%"> This flag is
///                         required if the <i>lpWindowsPath</i> parameter references the currently running Windows operating system
///                         directory rather than an offline Windows operating system image mounted on an accessible volume. If this flag is
///                         specified, the <b>NetRequestProvisioningPackageInstall</b> function must be invoked by a member of the local
///                         Administrators group. </td> </tr> </table>
///    lpWindowsPath = A pointer to a <b>NULL</b>-terminated character string that specifies the path to a Windows operating system
///                    image under which the registry hives are located. This image must be offline and not currently booted unless the
///                    <i>dwProvisionOptions</i> parameter contains <b>NETSETUP_PROVISION_ONLINE_CALLER</b>, in which case, the locally
///                    running operating system directory is allowed. This path could be a UNC path on a remote server.
///    pvReserved = Reserved for future use.
///Returns:
///    If the function succeeds, the return value is NERR_Success. If the function fails, the return value can be one of
///    the following Network Management error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>NERR_NoOfflineJoinInfo </b></dt> </dl> </td> <td width="60%"> The offline join
///    completion information was not found. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>NERR_BadOfflineJoinInfo</b></dt> </dl> </td> <td width="60%"> The offline join completion information was
///    bad. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>NERR_CantCreateJoinInfo</b></dt> </dl> </td> <td width="60%">
///    Unable to create offline join information. Please ensure you have access to the specified path location and
///    permissions to modify its contents. Running as an elevated administrator may be required. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>NERR_BadDomainJoinInfo</b></dt> </dl> </td> <td width="60%"> The domain join info being
///    saved was incomplete or bad. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>NERR_JoinPerformedMustRestart</b></dt>
///    </dl> </td> <td width="60%"> Offline join operation successfully completed but a restart is needed. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>NERR_NoJoinPending</b></dt> </dl> </td> <td width="60%"> There was no offline
///    join operation pending. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>NERR_ValuesNotSet</b></dt> </dl> </td> <td
///    width="60%"> Unable to set one or more requested machine or domain name values on the local computer. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>NERR_CantVerifyHostname</b></dt> </dl> </td> <td width="60%"> Could not verify
///    the current machine's hostname against the saved value in the join completion information. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>NERR_CantLoadOfflineHive</b></dt> </dl> </td> <td width="60%"> Unable to load the
///    specified offline registry hive. Please ensure you have access to the specified path location and permissions to
///    modify its contents. Running as an elevated administrator may be required. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>NERR_ConnectionInsecure</b></dt> </dl> </td> <td width="60%"> The minimum session security requirements
///    for this operation were not met. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>NERR_ProvisioningBlobUnsupported</b></dt> </dl> </td> <td width="60%"> Computer account provisioning blob
///    version is not supported. </td> </tr> </table>
///    
@DllImport("NETAPI32")
uint NetRequestProvisioningPackageInstall(ubyte* pPackageBinData, uint dwPackageBinDataSize, 
                                          uint dwProvisionOptions, const(PWSTR) lpWindowsPath, void* pvReserved);

///Retrieves the join information for the specified tenant. This function examines the join information for Microsoft
///Azure Active Directory and the work account that the current user added.
///Params:
///    pcszTenantId = The tenant identifier for the joined account. If the device is not joined to Azure Active Directory (Azure AD),
///                   and the user currently logged into Windows added no Azure AD work accounts for the specified tenant, the buffer
///                   that the <i>ppJoinInfo</i> parameter points to is set to NULL. If the specified tenant ID is NULL or empty,
///                   <i>ppJoinInfo</i> is set to the default join account information, or NULL if the device is not joined to Azure AD
///                   and the current user added no Azure AD work accounts. The default join account is one of the following: <ul>
///                   <li>The Azure AD account, if the device is joined to Azure AD.</li> <li>The Azure AD work account that the
///                   current user added, if the device is not joined to Azure AD, but the current user added a single Azure AD work
///                   account.</li> <li>Any of the Azure AD work accounts that the current user added, if the device is not joined to
///                   Azure AD, but the current user added multiple Azure AD work accounts. The algorithm for selecting one of the work
///                   accounts is not specified.</li> </ul>
///    ppJoinInfo = The join information for the tenant that the <i>pcszTenantId</i> parameter specifies. If this parameter is NULL,
///                 the device is not joined to Azure AD and the current user added no Azure AD work accounts. You must call the
///                 NetFreeAadJoinInformation function to free the memory allocated for this structure.
///Returns:
///    If this function succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
///    
@DllImport("NETAPI32")
HRESULT NetGetAadJoinInformation(const(PWSTR) pcszTenantId, DSREG_JOIN_INFO** ppJoinInfo);

///Frees the memory allocated for the specified DSREG_JOIN_INFO structure, which contains join information for a tenant
///and which you retrieved by calling the NetGetAadJoinInformation function.
///Params:
///    pJoinInfo = Pointer to the DSREG_JOIN_INFO structure for which you want to free the memory.
///Returns:
///    This function does not return a value.
///    
@DllImport("NETAPI32")
void NetFreeAadJoinInformation(DSREG_JOIN_INFO* pJoinInfo);

///The <b>NetGetJoinInformation</b> function retrieves join status information for the specified computer.
///Params:
///    lpServer = Pointer to a constant string that specifies the DNS or NetBIOS name of the computer on which to call the
///               function. If this parameter is <b>NULL</b>, the local computer is used.
///    lpNameBuffer = Pointer to the buffer that receives the NetBIOS name of the domain or workgroup to which the computer is joined.
///                   This buffer is allocated by the system and must be freed using the NetApiBufferFree function. For more
///                   information, see Network Management Function Buffers and Network Management Function Buffer Lengths.
///    BufferType = Receives the join status of the specified computer. This parameter can have one of the following values. ```cpp
///                 typedef enum _NETSETUP_JOIN_STATUS { NetSetupUnknownStatus = 0, NetSetupUnjoined, NetSetupWorkgroupName,
///                 NetSetupDomainName } NETSETUP_JOIN_STATUS, *PNETSETUP_JOIN_STATUS; ``` These values have the following meanings.
///                 <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="NetSetupUnknownStatus"></a><a
///                 id="netsetupunknownstatus"></a><a id="NETSETUPUNKNOWNSTATUS"></a><dl> <dt><b>NetSetupUnknownStatus</b></dt> </dl>
///                 </td> <td width="60%"> The status is unknown. </td> </tr> <tr> <td width="40%"><a id="NetSetupUnjoined"></a><a
///                 id="netsetupunjoined"></a><a id="NETSETUPUNJOINED"></a><dl> <dt><b>NetSetupUnjoined</b></dt> </dl> </td> <td
///                 width="60%"> The computer is not joined. </td> </tr> <tr> <td width="40%"><a id="NetSetupWorkgroupName"></a><a
///                 id="netsetupworkgroupname"></a><a id="NETSETUPWORKGROUPNAME"></a><dl> <dt><b>NetSetupWorkgroupName</b></dt> </dl>
///                 </td> <td width="60%"> The computer is joined to a workgroup. </td> </tr> <tr> <td width="40%"><a
///                 id="NetSetupDomainName"></a><a id="netsetupdomainname"></a><a id="NETSETUPDOMAINNAME"></a><dl>
///                 <dt><b>NetSetupDomainName</b></dt> </dl> </td> <td width="60%"> The computer is joined to a domain. </td> </tr>
///                 </table>
///Returns:
///    If the function succeeds, the return value is NERR_Success. If the function fails, the return value can be the
///    following error code or one of the system error codes. <table> <tr> <th>Return code</th> <th>Description</th>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NOT_ENOUGH_MEMORY</b></dt> </dl> </td> <td width="60%"> Not enough
///    storage is available to process this command. </td> </tr> </table>
///    
@DllImport("wkscli")
uint NetGetJoinInformation(const(PWSTR) lpServer, PWSTR* lpNameBuffer, NETSETUP_JOIN_STATUS* BufferType);

///<p class="CCE_Message">[<b>GetNetScheduleAccountInformation</b> is no longer available for use as of Windows 8.
///Instead, use the Task Scheduler 2.0 Interfaces. ] The <b>GetNetScheduleAccountInformation</b> function retrieves the
///AT Service account name.
///Params:
///    pwszServerName = A NULL-terminated wide character string for the name of the computer whose account information is being
///                     retrieved.
///    ccAccount = The number of characters, including the NULL terminator, allocated for <i>wszAccount</i>. The maximum allowed
///                length for this value is the maximum domain name length plus the maximum user name length plus 2, expressed as
///                DNLEN + UNLEN + 2. (The last two characters are the "\" character and the NULL terminator.)
///    wszAccount = An array of wide characters, including the NULL terminator, that receives the account information.
///Returns:
///    The return value is an HRESULT. A value of S_OK indicates the function succeeded, and the account information is
///    returned in <i>wszAccount</i>. A value of S_FALSE indicates the function succeeded, and the account is the Local
///    System account (no information will be returned in <i>wszAccount</i>). Any other return values indicate an error
///    condition.
///    
@DllImport("mstask")
HRESULT GetNetScheduleAccountInformation(const(PWSTR) pwszServerName, uint ccAccount, ushort* wszAccount);

///<p class="CCE_Message">[<b>SetNetScheduleAccountInformation</b> is no longer available for use as of Windows 8.
///Instead, use the Task Scheduler 2.0 Interfaces. ] The <b>SetNetScheduleAccountInformation</b> function sets the AT
///Service account name and password. The AT Service account name and password are used as the credentials for scheduled
///jobs created with NetScheduleJobAdd.
///Params:
///    pwszServerName = A NULL-terminated wide character string for the name of the computer whose account information is being set.
///    pwszAccount = A pointer to a NULL-terminated wide character string for the account. To specify the local system account, set
///                  this parameter to <b>NULL</b>.
///    pwszPassword = A pointer to a NULL-terminated wide character string for the password. For information about securing password
///                   information, see Handling Passwords.
///Returns:
///    The return value is an HRESULT. A value of S_OK indicates the account name and password were successfully set.
///    Any other value indicates an error condition. If the function fails, some of the possible return values are
///    listed below. <table> <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>E_ACCESSDENIED</b></dt> <dt>0x080070005</dt> </dl> </td> <td width="60%"> Access was denied. This error is
///    returned if the caller was not a member of the Administrators group. This error is also returned if the
///    <i>pwszAccount</i> parameter was not <b>NULL</b> indicating a named account not the local system account and the
///    <i>pwszPassword</i> parameter was incorrect for the account specified in the <i>pwszAccount</i> parameter. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>HRESULT_FROM_WIN32(ERROR_INVALID_DATA)</b></dt> <dt>0x08007000d</dt>
///    </dl> </td> <td width="60%"> The data is invalid. This error is returned if the <i>pwszPassword</i> parameter was
///    <b>NULL</b> or the length of <i>pwszPassword</i> parameter string was too long. </td> </tr> <tr> <td width="40%">
///    <dl> <dt><b>SCHED_E_ACCOUNT_NAME_NOT_FOUND</b></dt> <dt>0x80041310</dt> </dl> </td> <td width="60%"> Unable to
///    establish existence of the account specified. This error is returned if the <i>pwszAccount</i> parameter was not
///    <b>NULL</b> indicating a named account not the local system account and the <i>pwszAccount</i> parameter could
///    not be found. </td> </tr> </table>
///    
@DllImport("mstask")
HRESULT SetNetScheduleAccountInformation(const(PWSTR) pwszServerName, const(PWSTR) pwszAccount, 
                                         const(PWSTR) pwszPassword);

///<p class="CCE_Message">[This function is not supported as of Windows Vista because the alerter service is not
///supported.] The <b>NetAlertRaise</b> function notifies all registered clients when a particular event occurs. To
///simplify sending an alert message, you can call the extended function NetAlertRaiseEx instead. <b>NetAlertRaiseEx</b>
///does not require that you specify a STD_ALERT structure.
///Params:
///    AlertType = A pointer to a constant string that specifies the alert class (type of alert) to raise. This parameter can be one
///                of the following predefined values, or a user-defined alert class for network applications. The event name for an
///                alert can be any text string. <table> <tr> <th>Name</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
///                id="ALERT_ADMIN_EVENT"></a><a id="alert_admin_event"></a><dl> <dt><b>ALERT_ADMIN_EVENT</b></dt> </dl> </td> <td
///                width="60%"> An administrator's intervention is required. </td> </tr> <tr> <td width="40%"><a
///                id="ALERT_ERRORLOG_EVENT"></a><a id="alert_errorlog_event"></a><dl> <dt><b>ALERT_ERRORLOG_EVENT</b></dt> </dl>
///                </td> <td width="60%"> An entry was added to the error log. </td> </tr> <tr> <td width="40%"><a
///                id="ALERT_MESSAGE_EVENT"></a><a id="alert_message_event"></a><dl> <dt><b>ALERT_MESSAGE_EVENT</b></dt> </dl> </td>
///                <td width="60%"> A user or application received a broadcast message. </td> </tr> <tr> <td width="40%"><a
///                id="ALERT_PRINT_EVENT"></a><a id="alert_print_event"></a><dl> <dt><b>ALERT_PRINT_EVENT</b></dt> </dl> </td> <td
///                width="60%"> A print job completed or a print error occurred. </td> </tr> <tr> <td width="40%"><a
///                id="ALERT_USER_EVENT"></a><a id="alert_user_event"></a><dl> <dt><b>ALERT_USER_EVENT</b></dt> </dl> </td> <td
///                width="60%"> An application or resource was used. </td> </tr> </table>
///    Buffer = A pointer to the data to send to the clients listening for the interrupting message. The data should begin with a
///             fixed-length STD_ALERT structure followed by additional message data in one ADMIN_OTHER_INFO, ERRLOG_OTHER_INFO,
///             PRINT_OTHER_INFO, or USER_OTHER_INFO structure. Finally, the buffer should include any required variable-length
///             information. For more information, see the code sample in the following Remarks section. The calling application
///             must allocate and free the memory for all structures and variable data. For more information, see Network
///             Management Function Buffers.
///    BufferSize = The size, in bytes, of the message buffer.
///Returns:
///    If the function succeeds, the return value is NERR_Success. If the function fails, the return value is a system
///    error code and a can be one of the following error codes. For a list of all possible error codes, see System
///    Error Codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> A parameter is incorrect. This error is
///    returned if the <i>AlertEventName</i> parameter is <b>NULL</b> or an empty string, the <i>Buffer</i> parameter is
///    <b>NULL</b>, or the <i>BufferSize</i> parameter is less than the size of the STD_ALERT structure plus the fixed
///    size for the additional message data structure. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_NOT_SUPPORTED</b></dt> </dl> </td> <td width="60%"> The request is not supported. This error is
///    returned on Windows Vista and later since the Alerter service is not supported. </td> </tr> </table>
///    
@DllImport("NETAPI32")
uint NetAlertRaise(const(PWSTR) AlertType, void* Buffer, uint BufferSize);

///<p class="CCE_Message">[This function is not supported as of Windows Vista because the alerter service is not
///supported.] The <b>NetAlertRaiseEx</b> function notifies all registered clients when a particular event occurs. You
///can call this extended function to simplify the sending of an alert message because <b>NetAlertRaiseEx</b> does not
///require that you specify a STD_ALERT structure.
///Params:
///    AlertType = A pointer to a constant string that specifies the alert class (type of alert) to raise. This parameter can be one
///                of the following predefined values, or a user-defined alert class for network applications. (The event name for
///                an alert can be any text string.) <table> <tr> <th>Name</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
///                id="ALERT_ADMIN_EVENT"></a><a id="alert_admin_event"></a><dl> <dt><b>ALERT_ADMIN_EVENT</b></dt> </dl> </td> <td
///                width="60%"> An administrator's intervention is required. </td> </tr> <tr> <td width="40%"><a
///                id="ALERT_ERRORLOG_EVENT"></a><a id="alert_errorlog_event"></a><dl> <dt><b>ALERT_ERRORLOG_EVENT</b></dt> </dl>
///                </td> <td width="60%"> An entry was added to the error log. </td> </tr> <tr> <td width="40%"><a
///                id="ALERT_MESSAGE_EVENT"></a><a id="alert_message_event"></a><dl> <dt><b>ALERT_MESSAGE_EVENT</b></dt> </dl> </td>
///                <td width="60%"> A user or application received a broadcast message. </td> </tr> <tr> <td width="40%"><a
///                id="ALERT_PRINT_EVENT"></a><a id="alert_print_event"></a><dl> <dt><b>ALERT_PRINT_EVENT</b></dt> </dl> </td> <td
///                width="60%"> A print job completed or a print error occurred. </td> </tr> <tr> <td width="40%"><a
///                id="ALERT_USER_EVENT"></a><a id="alert_user_event"></a><dl> <dt><b>ALERT_USER_EVENT</b></dt> </dl> </td> <td
///                width="60%"> An application or resource was used. </td> </tr> </table>
///    VariableInfo = A pointer to the data to send to the clients listening for the interrupting message. The data should consist of
///                   one ADMIN_OTHER_INFO, ERRLOG_OTHER_INFO, PRINT_OTHER_INFO, or USER_OTHER_INFO structure followed by any required
///                   variable-length information. For more information, see the code sample in the following Remarks section. The
///                   calling application must allocate and free the memory for all structures and variable data. For more information,
///                   see Network Management Function Buffers.
///    VariableInfoSize = The number of bytes of variable information in the buffer pointed to by the <i>VariableInfo</i> parameter.
///    ServiceName = A pointer to a constant string that specifies the name of the service raising the interrupting message.
///Returns:
///    If the function succeeds, the return value is NERR_Success. If the function fails, the return value is a system
///    error code and a can be one of the following error codes. For a list of all possible error codes, see System
///    Error Codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> A parameter is incorrect. This error is
///    returned if the <i>AlertEventName</i> parameter is <b>NULL</b> or an empty string, the <i>ServiceName</i>
///    parameter is <b>NULL</b> or an empty string, the <i>VariableInfo</i> parameter is <b>NULL</b>, or the
///    <i>VariableInfoSize</i> parameter is greater than 512 minus the size of the STD_ALERT structure. </td> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>ERROR_NOT_SUPPORTED</b></dt> </dl> </td> <td width="60%"> The request is not
///    supported. This error is returned on Windows Vista and later since the Alerter service is not supported. </td>
///    </tr> </table>
///    
@DllImport("NETAPI32")
uint NetAlertRaiseEx(const(PWSTR) AlertType, void* VariableInfo, uint VariableInfoSize, const(PWSTR) ServiceName);

///The <b>NetApiBufferAllocate</b> function allocates memory from the heap. Use this function only when compatibility
///with the NetApiBufferFree function is required. Otherwise, use the memory management functions.
///Params:
///    ByteCount = Number of bytes to be allocated.
///    Buffer = Receives a pointer to the allocated buffer.
///Returns:
///    If the function succeeds, the return value is NERR_Success. If the function fails, the return value is a system
///    error code. For a list of error codes, see System Error Codes.
///    
@DllImport("netutils")
uint NetApiBufferAllocate(uint ByteCount, void** Buffer);

///The <b>NetApiBufferFree</b> function frees the memory that the NetApiBufferAllocate function allocates. Applications
///should also call <b>NetApiBufferFree</b> to free the memory that other network management functions use internally to
///return information.
///Params:
///    Buffer = A pointer to a buffer returned previously by another network management function or memory allocated by calling
///             the NetApiBufferAllocate function.
///Returns:
///    If the function succeeds, the return value is NERR_Success. If the function fails, the return value is a system
///    error code. For a list of error codes, see System Error Codes.
///    
@DllImport("netutils")
uint NetApiBufferFree(void* Buffer);

///The <b>NetApiBufferReallocate</b> function changes the size of a buffer allocated by a previous call to the
///NetApiBufferAllocate function.
///Params:
///    OldBuffer = Pointer to the buffer returned by a call to the NetApiBufferAllocate function.
///    NewByteCount = Specifies the new size of the buffer, in bytes.
///    NewBuffer = Receives the pointer to the reallocated buffer.
///Returns:
///    If the function succeeds, the return value is NERR_Success. If the function fails, the return value is a system
///    error code. For a list of error codes, see System Error Codes.
///    
@DllImport("netutils")
uint NetApiBufferReallocate(void* OldBuffer, uint NewByteCount, void** NewBuffer);

///The <b>NetApiBufferSize</b> function returns the size, in bytes, of a buffer allocated by a call to the
///NetApiBufferAllocate function.
///Params:
///    Buffer = Pointer to a buffer returned by the NetApiBufferAllocate function.
///    ByteCount = Receives the size of the buffer, in bytes.
///Returns:
///    If the function succeeds, the return value is NERR_Success. If the function fails, the return value is a system
///    error code. For a list of error codes, see System Error Codes.
///    
@DllImport("netutils")
uint NetApiBufferSize(void* Buffer, uint* ByteCount);

///The <b>NetAuditClear</b> function is obsolete. It is included for compatibility with 16-bit versions of Windows.
///Other applications should use event logging.
///Params:
///    server = TBD
///    backupfile = TBD
@DllImport("NETAPI32")
uint NetAuditClear(const(PWSTR) server, const(PWSTR) backupfile, const(PWSTR) service);

///The <b>NetAuditRead</b> function is obsolete. It is included for compatibility with 16-bit versions of Windows. Other
///applications should use event logging.
///Params:
///    server = TBD
///    service = TBD
///    auditloghandle = TBD
///    offset = TBD
///    reserved1 = TBD
///    reserved2 = TBD
///    offsetflag = TBD
///    bufptr = TBD
///    prefmaxlen = TBD
///    bytesread = TBD
@DllImport("NETAPI32")
uint NetAuditRead(const(PWSTR) server, const(PWSTR) service, HLOG* auditloghandle, uint offset, uint* reserved1, 
                  uint reserved2, uint offsetflag, ubyte** bufptr, uint prefmaxlen, uint* bytesread, 
                  uint* totalavailable);

///The <b>NetAuditWrite</b> function is obsolete. It is included for compatibility with 16-bit versions of Windows.
///Other applications should use event logging.
///Params:
///    type = TBD
///    buf = TBD
///    numbytes = TBD
///    service = TBD
@DllImport("NETAPI32")
uint NetAuditWrite(uint type, ubyte* buf, uint numbytes, const(PWSTR) service, ubyte* reserved);

///The <b>NetConfigGet</b> function is obsolete. It is included for compatibility with 16-bit versions of Windows. Other
///applications should use the registry.
///Params:
///    server = TBD
///    component = TBD
///    bufptr = TBD
@DllImport("NETAPI32")
uint NetConfigGet(const(PWSTR) server, const(PWSTR) component, const(PWSTR) parameter, ubyte** bufptr);

///The <b>NetConfigGetAll</b> function is obsolete. It is included for compatibility with 16-bit versions of Windows.
///Other applications should use the registry.
///Params:
///    server = TBD
///    component = TBD
@DllImport("NETAPI32")
uint NetConfigGetAll(const(PWSTR) server, const(PWSTR) component, ubyte** bufptr);

///The <b>NetConfigSet</b> function is obsolete. It is included for compatibility with 16-bit versions of Windows. Other
///applications should use the registry.
///Params:
///    server = TBD
///    reserved1 = TBD
///    component = TBD
///    level = TBD
///    reserved2 = TBD
///    buf = TBD
@DllImport("NETAPI32")
uint NetConfigSet(const(PWSTR) server, const(PWSTR) reserved1, const(PWSTR) component, uint level, uint reserved2, 
                  ubyte* buf, uint reserved3);

///The <b>NetErrorLogClear</b> function is obsolete. It is included for compatibility with 16-bit versions of Windows.
///Other applications should use event logging.
///Params:
///    UncServerName = TBD
///    BackupFile = TBD
@DllImport("NETAPI32")
uint NetErrorLogClear(const(PWSTR) UncServerName, const(PWSTR) BackupFile, ubyte* Reserved);

///The <b>NetErrorLogRead</b> function is obsolete. It is included for compatibility with 16-bit versions of Windows.
///Other applications should use event logging.
///Params:
///    UncServerName = TBD
///    Reserved1 = TBD
///    ErrorLogHandle = TBD
///    Offset = TBD
///    Reserved2 = TBD
///    Reserved3 = TBD
///    OffsetFlag = TBD
///    BufPtr = TBD
///    PrefMaxSize = TBD
///    BytesRead = TBD
@DllImport("NETAPI32")
uint NetErrorLogRead(const(PWSTR) UncServerName, PWSTR Reserved1, HLOG* ErrorLogHandle, uint Offset, 
                     uint* Reserved2, uint Reserved3, uint OffsetFlag, ubyte** BufPtr, uint PrefMaxSize, 
                     uint* BytesRead, uint* TotalAvailable);

///The <b>NetErrorLogWrite</b> function is obsolete. It is included for compatibility with 16-bit versions of Windows.
///Other applications should use event logging.
///Params:
///    Reserved1 = TBD
///    Code = TBD
///    Component = TBD
///    Buffer = TBD
///    NumBytes = TBD
///    MsgBuf = TBD
///    StrCount = TBD
@DllImport("NETAPI32")
uint NetErrorLogWrite(ubyte* Reserved1, uint Code, const(PWSTR) Component, ubyte* Buffer, uint NumBytes, 
                      ubyte* MsgBuf, uint StrCount, ubyte* Reserved2);

///<p class="CCE_Message">[This function is not supported as of Windows Vista because the messenger service is not
///supported.] The <b>NetMessageNameAdd</b> function registers a message alias in the message name table. The function
///requires that the messenger service be started.
///Params:
///    servername = Pointer to a constant string that specifies the DNS or NetBIOS name of the remote server on which the function is
///                 to execute. If this parameter is <b>NULL</b>, the local computer is used.
///    msgname = Pointer to a constant string that specifies the message alias to add. The string cannot be more than 15
///              characters long.
///Returns:
///    If the function succeeds, the return value is NERR_Success. If the function fails, the return value can be one of
///    the following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
///    <dl> <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> The caller does not have the appropriate
///    access to complete the operation. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt>
///    </dl> </td> <td width="60%"> A parameter is incorrect. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_NOT_SUPPORTED</b></dt> </dl> </td> <td width="60%"> This request is not supported. This error is
///    returned on Windows Vista and later. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>NERR_AlreadyExists</b></dt>
///    </dl> </td> <td width="60%"> The message alias already exists on this computer. For more information, see the
///    following Remarks section. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>NERR_DuplicateName</b></dt> </dl> </td>
///    <td width="60%"> The name specified is already in use as a message alias on the network. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>NERR_NetworkError</b></dt> </dl> </td> <td width="60%"> A general failure occurred in
///    the network hardware. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>NERR_TooManyNames</b></dt> </dl> </td> <td
///    width="60%"> The maximum number of message aliases has been exceeded. </td> </tr> </table>
///    
@DllImport("NETAPI32")
uint NetMessageNameAdd(const(PWSTR) servername, const(PWSTR) msgname);

///<p class="CCE_Message">[This function is not supported as of Windows Vista because the messenger service is not
///supported.] The <b>NetMessageNameEnum</b> function lists the message aliases that receive messages on a specified
///computer. The function requires that the messenger service be started.
///Params:
///    servername = Pointer to a constant string that specifies the DNS or NetBIOS name of the remote server on which the function is
///                 to execute. If this parameter is <b>NULL</b>, the local computer is used.
///    level = Specifies the information level of the data. This parameter can be one of the following values. <table> <tr>
///            <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="0"></a><dl> <dt><b>0</b></dt> </dl> </td> <td
///            width="60%"> Return message aliases. The <i>bufptr</i> parameter points to an array of MSG_INFO_0 structures.
///            </td> </tr> <tr> <td width="40%"><a id="1"></a><dl> <dt><b>1</b></dt> </dl> </td> <td width="60%"> Return message
///            aliases. The <i>bufptr</i> parameter points to an array of MSG_INFO_1 structures. This level exists only for
///            compatibility. Message forwarding is not supported. </td> </tr> </table>
///    bufptr = Pointer to the buffer that receives the data. The format of this data depends on the value of the <i>level</i>
///             parameter. This buffer is allocated by the system and must be freed using the NetApiBufferFree function. Note
///             that you must free the buffer even if the function fails with ERROR_MORE_DATA.
///    prefmaxlen = Specifies the preferred maximum length of the returned data, in bytes. If you specify MAX_PREFERRED_LENGTH, the
///                 function allocates the amount of memory required for the data. If you specify another value in this parameter, it
///                 can restrict the number of bytes that the function returns. If the buffer size is insufficient to hold all
///                 entries, the function returns ERROR_MORE_DATA. For more information, see Network Management Function Buffers and
///                 Network Management Function Buffer Lengths.
///    entriesread = Pointer to a value that receives the count of elements actually enumerated.
///    totalentries = Pointer to a value that receives the total number of entries that could have been enumerated from the current
///                   resume position. Note that applications should consider this value only as a hint.
///    resume_handle = Pointer to a value that contains a resume handle which is used to continue an existing message alias search. The
///                    handle should be zero on the first call and left unchanged for subsequent calls. If <i>resume_handle</i> is
///                    <b>NULL</b>, no resume handle is stored.
///Returns:
///    If the function succeeds, the return value is NERR_Success. If the function fails, the return value can be one of
///    the following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
///    <dl> <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> The caller does not have the appropriate
///    access to complete the operation. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_LEVEL</b></dt>
///    </dl> </td> <td width="60%"> The value specified for the <i>level</i> parameter is invalid. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> A parameter is incorrect.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_MORE_DATA</b></dt> </dl> </td> <td width="60%"> More entries
///    are available. Specify a large enough buffer to receive all entries. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_NOT_ENOUGH_MEMORY</b></dt> </dl> </td> <td width="60%"> Insufficient memory is available. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NOT_SUPPORTED</b></dt> </dl> </td> <td width="60%"> This request is
///    not supported. This error is returned on Windows Vista and later. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>NERR_BufTooSmall</b></dt> </dl> </td> <td width="60%"> The supplied buffer is too small. </td> </tr>
///    </table>
///    
@DllImport("NETAPI32")
uint NetMessageNameEnum(const(PWSTR) servername, uint level, ubyte** bufptr, uint prefmaxlen, uint* entriesread, 
                        uint* totalentries, uint* resume_handle);

///<p class="CCE_Message">[This function is not supported as of Windows Vista because the messenger service is not
///supported.] The <b>NetMessageNameGetInfo</b> function retrieves information about a particular message alias in the
///message name table. The function requires that the messenger service be started.
///Params:
///    servername = Pointer to a constant string that specifies the DNS or NetBIOS name of the remote server on which the function is
///                 to execute. If this parameter is <b>NULL</b>, the local computer is used.
///    msgname = Pointer to a constant string that specifies the message alias for which to return information.
///    level = Specifies the information level of the data. This parameter can be one of the following values. <table> <tr>
///            <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="0"></a><dl> <dt><b>0</b></dt> </dl> </td> <td
///            width="60%"> Return the message alias. The <i>bufptr</i> parameter points to a MSG_INFO_0 structure. </td> </tr>
///            <tr> <td width="40%"><a id="1"></a><dl> <dt><b>1</b></dt> </dl> </td> <td width="60%"> Return the message alias.
///            The <i>bufptr</i> parameter points to a MSG_INFO_1 structure. This level exists only for compatibility. Message
///            forwarding is not supported. </td> </tr> </table>
///    bufptr = Pointer to the buffer that receives the data. The format of this data depends on the value of the <i>level</i>
///             parameter. This buffer is allocated by the system and must be freed using the NetApiBufferFree function. For more
///             information, see Network Management Function Buffers and Network Management Function Buffer Lengths.
///Returns:
///    If the function succeeds, the return value is NERR_Success. If the function fails, the return value can be one of
///    the following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
///    <dl> <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> The caller does not have the appropriate
///    access to complete the operation. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_LEVEL</b></dt>
///    </dl> </td> <td width="60%"> The value specified for the <i>level</i> parameter is invalid. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> A parameter is incorrect.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NOT_ENOUGH_MEMORY</b></dt> </dl> </td> <td width="60%">
///    Insufficient memory is available. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NOT_SUPPORTED</b></dt>
///    </dl> </td> <td width="60%"> This request is not supported. This error is returned on Windows Vista and later.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>NERR_NotLocalName</b></dt> </dl> </td> <td width="60%"> The message
///    alias is not on the local computer. </td> </tr> </table>
///    
@DllImport("NETAPI32")
uint NetMessageNameGetInfo(const(PWSTR) servername, const(PWSTR) msgname, uint level, ubyte** bufptr);

///<p class="CCE_Message">[This function is not supported as of Windows Vista because the messenger service is not
///supported.] The <b>NetMessageNameDel</b> function deletes a message alias in the message name table. The function
///requires that the messenger service be started.
///Params:
///    servername = Pointer to a constant string that specifies the DNS or NetBIOS name of the remote server on which the function is
///                 to execute. If this parameter is <b>NULL</b>, the local computer is used.
///    msgname = Pointer to a constant string that specifies the message alias to delete. The string cannot be more than 15
///              characters long.
///Returns:
///    If the function succeeds, the return value is NERR_Success. If the function fails, the return value can be one of
///    the following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
///    <dl> <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> The caller does not have the appropriate
///    access to complete the operation. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt>
///    </dl> </td> <td width="60%"> A parameter is incorrect. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_NOT_SUPPORTED</b></dt> </dl> </td> <td width="60%"> This request is not supported. This error is
///    returned on Windows Vista and later. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>NERR_DelComputerName</b></dt>
///    </dl> </td> <td width="60%"> A message alias that is also a computer name cannot be deleted. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>NERR_IncompleteDel</b></dt> </dl> </td> <td width="60%"> The message alias was not
///    successfully deleted from all networks. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>NERR_NameInUse</b></dt>
///    </dl> </td> <td width="60%"> The message alias is currently in use. Try again later. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>NERR_NotLocalName</b></dt> </dl> </td> <td width="60%"> The message alias is not on the
///    local computer. </td> </tr> </table>
///    
@DllImport("NETAPI32")
uint NetMessageNameDel(const(PWSTR) servername, const(PWSTR) msgname);

///<p class="CCE_Message">[This function is not supported as of Windows Vista because the messenger service is not
///supported.] The <b>NetMessageBufferSend</b> function sends a buffer of information to a registered message alias.
///Params:
///    servername = Pointer to a constant string that specifies the DNS or NetBIOS name of the remote server on which the function is
///                 to execute. If this parameter is <b>NULL</b>, the local computer is used.
///    msgname = Pointer to a constant string that specifies the message alias to which the message buffer should be sent.
///    fromname = Pointer to a constant string specifying who the message is from. If this parameter is <b>NULL</b>, the message is
///               sent from the local computer name.
///    buf = Pointer to a buffer that contains the message text. For more information, see Network Management Function
///          Buffers.
///    buflen = Specifies a value that contains the length, in bytes, of the message text pointed to by the <i>buf</i> parameter.
///Returns:
///    If the function succeeds, the return value is NERR_Success. If the function fails, the return value can be one of
///    the following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
///    <dl> <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> The caller does not have the appropriate
///    access to complete the operation. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt>
///    </dl> </td> <td width="60%"> A parameter is incorrect. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_NOT_SUPPORTED</b></dt> </dl> </td> <td width="60%"> This request is not supported. This error is
///    returned on Windows Vista and later. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>NERR_NameNotFound</b></dt>
///    </dl> </td> <td width="60%"> The user name could not be found. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>NERR_NetworkError</b></dt> </dl> </td> <td width="60%"> A general failure occurred in the network
///    hardware. </td> </tr> </table>
///    
@DllImport("NETAPI32")
uint NetMessageBufferSend(const(PWSTR) servername, const(PWSTR) msgname, const(PWSTR) fromname, ubyte* buf, 
                          uint buflen);

///The <b>NetRemoteTOD</b> function returns the time of day information from a specified server.
///Params:
///    UncServerName = Pointer to a constant string that specifies the DNS or NetBIOS name of the remote server on which the function is
///                    to execute. If this parameter is <b>NULL</b>, the local computer is used.
///    BufferPtr = Pointer to the address that receives the TIME_OF_DAY_INFO information structure. This buffer is allocated by the
///                system and must be freed using the NetApiBufferFree function.
///Returns:
///    If the function succeeds, the return value is NERR_Success. If the function fails, the return value is a system
///    error code. For a list of error codes, see System Error Codes.
///    
@DllImport("srvcli")
uint NetRemoteTOD(const(PWSTR) UncServerName, ubyte** BufferPtr);

///The <b>NetRemoteComputerSupports</b> function queries the redirector to retrieve the optional features the remote
///system supports. Features include Unicode, Remote Procedure Call (RPC), and Remote Administration Protocol support.
///The function establishes a network connection if one does not exist.
///Params:
///    UncServerName = Pointer to a constant string that specifies the name of the remote server to query. If this parameter is
///                    <b>NULL</b>, the local computer is used.
///    OptionsWanted = Specifies a value that contains a set of bit flags indicating the features of interest. This parameter must be at
///                    least one of the following values. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
///                    id="SUPPORTS_REMOTE_ADMIN_PROTOCOL"></a><a id="supports_remote_admin_protocol"></a><dl>
///                    <dt><b>SUPPORTS_REMOTE_ADMIN_PROTOCOL</b></dt> </dl> </td> <td width="60%"> Requests Remote Administration
///                    Protocol support. </td> </tr> <tr> <td width="40%"><a id="SUPPORTS_RPC"></a><a id="supports_rpc"></a><dl>
///                    <dt><b>SUPPORTS_RPC</b></dt> </dl> </td> <td width="60%"> Requests RPC support. </td> </tr> <tr> <td
///                    width="40%"><a id="SUPPORTS_SAM_PROTOCOL"></a><a id="supports_sam_protocol"></a><dl>
///                    <dt><b>SUPPORTS_SAM_PROTOCOL</b></dt> </dl> </td> <td width="60%"> Requests Security Account Manager (SAM)
///                    support. </td> </tr> <tr> <td width="40%"><a id="SUPPORTS_UNICODE"></a><a id="supports_unicode"></a><dl>
///                    <dt><b>SUPPORTS_UNICODE</b></dt> </dl> </td> <td width="60%"> Requests Unicode standard support. </td> </tr> <tr>
///                    <td width="40%"><a id="SUPPORTS_LOCAL"></a><a id="supports_local"></a><dl> <dt><b>SUPPORTS_LOCAL</b></dt> </dl>
///                    </td> <td width="60%"> Requests support for the first three values listed in this table. If UNICODE is defined by
///                    the calling application, requests the four features listed previously. </td> </tr> </table>
///    OptionsSupported = Pointer to a value that receives a set of bit flags. The flags indicate which features specified by the
///                       <i>OptionsWanted</i> parameter are implemented on the computer specified by the <i>UncServerName</i> parameter.
///                       (All other bits are set to zero.) The value of this parameter is valid only when the
///                       <b>NetRemoteComputerSupports</b> function returns NERR_Success.
///Returns:
///    If the function succeeds, the return value is NERR_Success. If the function fails, the return value can be one of
///    the following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
///    <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> Either the <i>OptionsWanted</i>
///    parameter or the <i>OptionsSupported</i> parameter is <b>NULL</b>; both parameters are required. </td> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>ERROR_NOT_ENOUGH_MEMORY</b></dt> </dl> </td> <td width="60%"> Insufficient memory is
///    available. </td> </tr> </table>
///    
@DllImport("netutils")
uint NetRemoteComputerSupports(const(PWSTR) UncServerName, uint OptionsWanted, uint* OptionsSupported);

///<p class="CCE_Message">[<b>NetScheduleJobAdd</b> is no longer available for use as of Windows 8. Instead, use the
///Task Scheduler 2.0 Interfaces. ] The <b>NetScheduleJobAdd</b> function submits a job to run at a specified future
///time and date. This function requires that the schedule service be started on the computer to which the job is
///submitted.
///Params:
///    Servername = A pointer to a constant string that specifies the DNS or NetBIOS name of the remote server on which the function
///                 is to execute. If this parameter is <b>NULL</b>, the local computer is used.
///    Buffer = A pointer to an AT_INFO structure describing the job to submit. For more information about scheduling jobs using
///             different job properties, see the following Remarks section and Network Management Function Buffers.
///    JobId = A pointer that receives a job identifier for the newly submitted job. This entry is valid only if the function
///            returns successfully.
///Returns:
///    If the function succeeds, the return value is NERR_Success. If the function fails, the return value is a system
///    error code. For a list of error codes, see System Error Codes.
///    
@DllImport("schedcli")
uint NetScheduleJobAdd(const(PWSTR) Servername, ubyte* Buffer, uint* JobId);

///<p class="CCE_Message">[<b>NetScheduleJobDel</b> is no longer available for use as of Windows 8. Instead, use the
///Task Scheduler 2.0 Interfaces. ] The <b>NetScheduleJobDel</b> function deletes a range of jobs queued to run at a
///computer. This function requires that the schedule service be started at the computer to which the job deletion
///request is being sent.
///Params:
///    Servername = A pointer to a constant string that specifies the DNS or NetBIOS name of the remote server on which the function
///                 is to execute. If this parameter is <b>NULL</b>, the local computer is used.
///    MinJobId = The minimum job identifier. Jobs with a job identifier smaller than <i>MinJobId</i> will not be deleted.
///    MaxJobId = The maximum job identifier. Jobs with a job identifier larger than <i>MaxJobId</i> will not be deleted.
///Returns:
///    If the function succeeds, the return value is NERR_Success. If the function fails, the return value is a system
///    error code. For a list of error codes, see System Error Codes.
///    
@DllImport("schedcli")
uint NetScheduleJobDel(const(PWSTR) Servername, uint MinJobId, uint MaxJobId);

///<p class="CCE_Message">[<b>NetScheduleJobEnum</b> is no longer available for use as of Windows 8. Instead, use the
///Task Scheduler 2.0 Interfaces. ] The <b>NetScheduleJobEnum</b> function lists the jobs queued on a specified
///computer. This function requires that the schedule service be started.
///Params:
///    Servername = A pointer to a constant string that specifies the DNS or NetBIOS name of the remote server on which the function
///                 is to execute. If this parameter is <b>NULL</b>, the local computer is used.
///    PointerToBuffer = A pointer to the buffer that receives the data. The return information is an array of AT_ENUM structures. The
///                      buffer is allocated by the system and must be freed using a single call to the NetApiBufferFree function. Note
///                      that you must free the buffer even if the function fails with ERROR_MORE_DATA.
///    PrefferedMaximumLength = A value that indicates the preferred maximum length of the returned data, in bytes. If you specify
///                             MAX_PREFERRED_LENGTH, the function allocates the amount of memory required for the data. If you specify another
///                             value in this parameter, it can restrict the number of bytes that the function returns. If the buffer size is
///                             insufficient to hold all entries, the function returns ERROR_MORE_DATA. For more information, see Network
///                             Management Function Buffers and Network Management Function Buffer Lengths.
///    EntriesRead = A pointer to a value that receives the count of elements actually enumerated.
///    TotalEntries = A pointer to a value that receives the total number of entries that could have been enumerated from the current
///                   resume position. Note that applications should consider this value only as a hint.
///    ResumeHandle = A pointer to a value that contains a resume handle which is used to continue a job enumeration. The handle should
///                   be zero on the first call and left unchanged for subsequent calls. If this parameter is <b>NULL</b>, then no
///                   resume handle is stored.
///Returns:
///    If the function succeeds, the return value is NERR_Success. If the function fails, the return value is a system
///    error code. For a list of error codes, see System Error Codes.
///    
@DllImport("schedcli")
uint NetScheduleJobEnum(const(PWSTR) Servername, ubyte** PointerToBuffer, uint PrefferedMaximumLength, 
                        uint* EntriesRead, uint* TotalEntries, uint* ResumeHandle);

///<p class="CCE_Message">[<b>NetScheduleJobGetInfo</b> is no longer available for use as of Windows 8. Instead, use the
///Task Scheduler 2.0 Interfaces. ] The <b>NetScheduleJobGetInfo</b> function retrieves information about a particular
///job queued on a specified computer. This function requires that the schedule service be started.
///Params:
///    Servername = A pointer to a constant string that specifies the DNS or NetBIOS name of the remote server on which the function
///                 is to execute. If this parameter is <b>NULL</b>, the local computer is used.
///    JobId = A value that indicates the identifier of the job for which to retrieve information.
///    PointerToBuffer = A pointer to the buffer that receives the AT_INFO structure describing the specified job. This buffer is
///                      allocated by the system and must be freed using the NetApiBufferFree function. For more information, see Network
///                      Management Function Buffers and Network Management Function Buffer Lengths.
///Returns:
///    If the function succeeds, the return value is NERR_Success. If the function fails, the return value is a system
///    error code. For a list of error codes, see System Error Codes.
///    
@DllImport("schedcli")
uint NetScheduleJobGetInfo(const(PWSTR) Servername, uint JobId, ubyte** PointerToBuffer);

///The <b>NetServerEnum</b> function lists all servers of the specified type that are visible in a domain.
///Params:
///    servername = Reserved; must be <b>NULL</b>.
///    level = The information level of the data requested. This parameter can be one of the following values. <table> <tr>
///            <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="100"></a><dl> <dt><b>100</b></dt> </dl> </td>
///            <td width="60%"> Return server names and platform information. The <i>bufptr</i> parameter points to an array of
///            SERVER_INFO_100 structures. </td> </tr> <tr> <td width="40%"><a id="101"></a><dl> <dt><b>101</b></dt> </dl> </td>
///            <td width="60%"> Return server names, types, and associated data. The <i>bufptr</i> parameter points to an array
///            of SERVER_INFO_101 structures. </td> </tr> </table>
///    bufptr = A pointer to the buffer that receives the data. The format of this data depends on the value of the <i>level</i>
///             parameter. This buffer is allocated by the system and must be freed using the NetApiBufferFree function. Note
///             that you must free the buffer even if the function fails with ERROR_MORE_DATA.
///    prefmaxlen = The preferred maximum length of returned data, in bytes. If you specify MAX_PREFERRED_LENGTH, the function
///                 allocates the amount of memory required for the data. If you specify another value in this parameter, it can
///                 restrict the number of bytes that the function returns. If the buffer size is insufficient to hold all entries,
///                 the function returns ERROR_MORE_DATA. For more information, see Network Management Function Buffers and Network
///                 Management Function Buffer Lengths.
///    entriesread = A pointer to a value that receives the count of elements actually enumerated.
///    totalentries = A pointer to a value that receives the total number of visible servers and workstations on the network. Note that
///                   applications should consider this value only as a hint.
///    servertype = A value that filters the server entries to return from the enumeration. This parameter can be a combination of
///                 the following values defined in the <i>Lmserver.h</i> header file. <table> <tr> <th>Value</th> <th>Meaning</th>
///                 </tr> <tr> <td width="40%"><a id="SV_TYPE_WORKSTATION"></a><a id="sv_type_workstation"></a><dl>
///                 <dt><b>SV_TYPE_WORKSTATION</b></dt> <dt>0x00000001</dt> </dl> </td> <td width="60%"> All workstations. </td>
///                 </tr> <tr> <td width="40%"><a id="SV_TYPE_SERVER"></a><a id="sv_type_server"></a><dl>
///                 <dt><b>SV_TYPE_SERVER</b></dt> <dt>0x00000002</dt> </dl> </td> <td width="60%"> All computers that run the Server
///                 service. </td> </tr> <tr> <td width="40%"><a id="SV_TYPE_SQLSERVER"></a><a id="sv_type_sqlserver"></a><dl>
///                 <dt><b>SV_TYPE_SQLSERVER</b></dt> <dt>0x00000004</dt> </dl> </td> <td width="60%"> Any server that runs an
///                 instance of Microsoft SQL Server. </td> </tr> <tr> <td width="40%"><a id="SV_TYPE_DOMAIN_CTRL"></a><a
///                 id="sv_type_domain_ctrl"></a><dl> <dt><b>SV_TYPE_DOMAIN_CTRL</b></dt> <dt>0x00000008</dt> </dl> </td> <td
///                 width="60%"> A server that is primary domain controller. </td> </tr> <tr> <td width="40%"><a
///                 id="SV_TYPE_DOMAIN_BAKCTRL"></a><a id="sv_type_domain_bakctrl"></a><dl> <dt><b>SV_TYPE_DOMAIN_BAKCTRL</b></dt>
///                 <dt>0x00000010</dt> </dl> </td> <td width="60%"> Any server that is a backup domain controller. </td> </tr> <tr>
///                 <td width="40%"><a id="SV_TYPE_TIME_SOURCE"></a><a id="sv_type_time_source"></a><dl>
///                 <dt><b>SV_TYPE_TIME_SOURCE</b></dt> <dt>0x00000020</dt> </dl> </td> <td width="60%"> Any server that runs the
///                 Timesource service. </td> </tr> <tr> <td width="40%"><a id="SV_TYPE_AFP"></a><a id="sv_type_afp"></a><dl>
///                 <dt><b>SV_TYPE_AFP</b></dt> <dt>0x00000040</dt> </dl> </td> <td width="60%"> Any server that runs the Apple
///                 Filing Protocol (AFP) file service. </td> </tr> <tr> <td width="40%"><a id="SV_TYPE_NOVELL"></a><a
///                 id="sv_type_novell"></a><dl> <dt><b>SV_TYPE_NOVELL</b></dt> <dt>0x00000080</dt> </dl> </td> <td width="60%"> Any
///                 server that is a Novell server. </td> </tr> <tr> <td width="40%"><a id="SV_TYPE_DOMAIN_MEMBER"></a><a
///                 id="sv_type_domain_member"></a><dl> <dt><b>SV_TYPE_DOMAIN_MEMBER</b></dt> <dt>0x00000100</dt> </dl> </td> <td
///                 width="60%"> Any computer that is LAN Manager 2.x domain member. </td> </tr> <tr> <td width="40%"><a
///                 id="SV_TYPE_PRINTQ_SERVER"></a><a id="sv_type_printq_server"></a><dl> <dt><b>SV_TYPE_PRINTQ_SERVER</b></dt>
///                 <dt>0x00000200</dt> </dl> </td> <td width="60%"> Any computer that shares a print queue. </td> </tr> <tr> <td
///                 width="40%"><a id="SV_TYPE_DIALIN_SERVER"></a><a id="sv_type_dialin_server"></a><dl>
///                 <dt><b>SV_TYPE_DIALIN_SERVER</b></dt> <dt>0x00000400</dt> </dl> </td> <td width="60%"> Any server that runs a
///                 dial-in service. </td> </tr> <tr> <td width="40%"><a id="SV_TYPE_XENIX_SERVER"></a><a
///                 id="sv_type_xenix_server"></a><dl> <dt><b>SV_TYPE_XENIX_SERVER</b></dt> <dt>0x00000800</dt> </dl> </td> <td
///                 width="60%"> Any server that is a Xenix server. </td> </tr> <tr> <td width="40%"><a
///                 id="SV_TYPE_SERVER_UNIX"></a><a id="sv_type_server_unix"></a><dl> <dt><b>SV_TYPE_SERVER_UNIX</b></dt>
///                 <dt>0x00000800</dt> </dl> </td> <td width="60%"> Any server that is a UNIX server. This is the same as the
///                 <b>SV_TYPE_XENIX_SERVER</b>. </td> </tr> <tr> <td width="40%"><a id="SV_TYPE_NT"></a><a id="sv_type_nt"></a><dl>
///                 <dt><b>SV_TYPE_NT</b></dt> <dt>0x00001000</dt> </dl> </td> <td width="60%"> A workstation or server. </td> </tr>
///                 <tr> <td width="40%"><a id="SV_TYPE_WFW"></a><a id="sv_type_wfw"></a><dl> <dt><b>SV_TYPE_WFW</b></dt>
///                 <dt>0x00002000</dt> </dl> </td> <td width="60%"> Any computer that runs Windows for Workgroups. </td> </tr> <tr>
///                 <td width="40%"><a id="SV_TYPE_SERVER_MFPN"></a><a id="sv_type_server_mfpn"></a><dl>
///                 <dt><b>SV_TYPE_SERVER_MFPN</b></dt> <dt>0x00004000</dt> </dl> </td> <td width="60%"> Any server that runs the
///                 Microsoft File and Print for NetWare service. </td> </tr> <tr> <td width="40%"><a id="SV_TYPE_SERVER_NT"></a><a
///                 id="sv_type_server_nt"></a><dl> <dt><b>SV_TYPE_SERVER_NT</b></dt> <dt>0x00008000</dt> </dl> </td> <td
///                 width="60%"> Any server that is not a domain controller. </td> </tr> <tr> <td width="40%"><a
///                 id="SV_TYPE_POTENTIAL_BROWSER"></a><a id="sv_type_potential_browser"></a><dl>
///                 <dt><b>SV_TYPE_POTENTIAL_BROWSER</b></dt> <dt>0x00010000</dt> </dl> </td> <td width="60%"> Any computer that can
///                 run the browser service. </td> </tr> <tr> <td width="40%"><a id="SV_TYPE_BACKUP_BROWSER"></a><a
///                 id="sv_type_backup_browser"></a><dl> <dt><b>SV_TYPE_BACKUP_BROWSER</b></dt> <dt>0x00020000</dt> </dl> </td> <td
///                 width="60%"> A computer that runs a browser service as backup. </td> </tr> <tr> <td width="40%"><a
///                 id="SV_TYPE_MASTER_BROWSER"></a><a id="sv_type_master_browser"></a><dl> <dt><b>SV_TYPE_MASTER_BROWSER</b></dt>
///                 <dt>0x00040000</dt> </dl> </td> <td width="60%"> A computer that runs the master browser service. </td> </tr>
///                 <tr> <td width="40%"><a id="SV_TYPE_DOMAIN_MASTER"></a><a id="sv_type_domain_master"></a><dl>
///                 <dt><b>SV_TYPE_DOMAIN_MASTER</b></dt> <dt>0x00080000</dt> </dl> </td> <td width="60%"> A computer that runs the
///                 domain master browser. </td> </tr> <tr> <td width="40%"><a id="SV_TYPE_SERVER_OSF"></a><a
///                 id="sv_type_server_osf"></a><dl> <dt><b>SV_TYPE_SERVER_OSF</b></dt> <dt>0x00100000</dt> </dl> </td> <td
///                 width="60%"> A computer that runs OSF/1. </td> </tr> <tr> <td width="40%"><a id="SV_TYPE_SERVER_VMS"></a><a
///                 id="sv_type_server_vms"></a><dl> <dt><b>SV_TYPE_SERVER_VMS</b></dt> <dt>0x00200000</dt> </dl> </td> <td
///                 width="60%"> A computer that runs Open Virtual Memory System (VMS). </td> </tr> <tr> <td width="40%"><a
///                 id="SV_TYPE_WINDOWS"></a><a id="sv_type_windows"></a><dl> <dt><b>SV_TYPE_WINDOWS</b></dt> <dt>0x00400000</dt>
///                 </dl> </td> <td width="60%"> A computer that runs Windows. </td> </tr> <tr> <td width="40%"><a
///                 id="SV_TYPE_DFS"></a><a id="sv_type_dfs"></a><dl> <dt><b>SV_TYPE_DFS</b></dt> <dt>0x00800000</dt> </dl> </td> <td
///                 width="60%"> A computer that is the root of Distributed File System (DFS) tree. </td> </tr> <tr> <td
///                 width="40%"><a id="SV_TYPE_CLUSTER_NT"></a><a id="sv_type_cluster_nt"></a><dl> <dt><b>SV_TYPE_CLUSTER_NT</b></dt>
///                 <dt>0x01000000</dt> </dl> </td> <td width="60%"> Server clusters available in the domain. </td> </tr> <tr> <td
///                 width="40%"><a id="SV_TYPE_TERMINALSERVER"></a><a id="sv_type_terminalserver"></a><dl>
///                 <dt><b>SV_TYPE_TERMINALSERVER</b></dt> <dt>0x02000000</dt> </dl> </td> <td width="60%"> A server running the
///                 Terminal Server service. </td> </tr> <tr> <td width="40%"><a id="SV_TYPE_CLUSTER_VS_NT"></a><a
///                 id="sv_type_cluster_vs_nt"></a><dl> <dt><b>SV_TYPE_CLUSTER_VS_NT</b></dt> <dt>0x04000000</dt> </dl> </td> <td
///                 width="60%"> Cluster virtual servers available in the domain. <b>Windows 2000: </b>This value is not supported.
///                 </td> </tr> <tr> <td width="40%"><a id="SV_TYPE_DCE"></a><a id="sv_type_dce"></a><dl> <dt><b>SV_TYPE_DCE</b></dt>
///                 <dt>0x10000000</dt> </dl> </td> <td width="60%"> A computer that runs IBM Directory and Security Services (DSS)
///                 or equivalent. </td> </tr> <tr> <td width="40%"><a id="SV_TYPE_ALTERNATE_XPORT"></a><a
///                 id="sv_type_alternate_xport"></a><dl> <dt><b>SV_TYPE_ALTERNATE_XPORT</b></dt> <dt>0x20000000</dt> </dl> </td> <td
///                 width="60%"> A computer that over an alternate transport. </td> </tr> <tr> <td width="40%"><a
///                 id="SV_TYPE_LOCAL_LIST_ONLY"></a><a id="sv_type_local_list_only"></a><dl> <dt><b>SV_TYPE_LOCAL_LIST_ONLY</b></dt>
///                 <dt>0x40000000</dt> </dl> </td> <td width="60%"> Any computer maintained in a list by the browser. See the
///                 following Remarks section. </td> </tr> <tr> <td width="40%"><a id="SV_TYPE_DOMAIN_ENUM"></a><a
///                 id="sv_type_domain_enum"></a><dl> <dt><b>SV_TYPE_DOMAIN_ENUM</b></dt> <dt>0x80000000</dt> </dl> </td> <td
///                 width="60%"> The primary domain. </td> </tr> <tr> <td width="40%"><a id="SV_TYPE_ALL"></a><a
///                 id="sv_type_all"></a><dl> <dt><b>SV_TYPE_ALL</b></dt> <dt>0xFFFFFFFF</dt> </dl> </td> <td width="60%"> All
///                 servers. This is a convenience that will return all possible servers. </td> </tr> </table>
///    domain = A pointer to a constant string that specifies the name of the domain for which a list of servers is to be
///             returned. The domain name must be a NetBIOS domain name (for example, microsoft). The <b>NetServerEnum</b>
///             function does not support DNS-style names (for example, microsoft.com). If this parameter is <b>NULL</b>, the
///             primary domain is implied.
///    resume_handle = Reserved; must be set to zero.
///Returns:
///    If the function succeeds, the return value is NERR_Success. If the function fails, the return value can be one of
///    the following error codes: <table> <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_ACCESS_DENIED</b></dt> <dt>5</dt> </dl> </td> <td width="60%"> Access was denied.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> <dt>87</dt> </dl> </td> <td
///    width="60%"> The parameter is incorrect. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_MORE_DATA</b></dt>
///    <dt>234</dt> </dl> </td> <td width="60%"> More entries are available. Specify a large enough buffer to receive
///    all entries. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NO_BROWSER_SERVERS_FOUND</b></dt> <dt>6118</dt>
///    </dl> </td> <td width="60%"> No browser servers found. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_NOT_SUPPORTED</b></dt> <dt>50</dt> </dl> </td> <td width="60%"> The request is not supported. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>NERR_RemoteErr</b></dt> <dt>2127</dt> </dl> </td> <td width="60%"> A
///    remote error occurred with no data returned by the server. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>NERR_ServerNotStarted</b></dt> <dt>2114</dt> </dl> </td> <td width="60%"> The server service is not
///    started. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>NERR_ServiceNotInstalled</b></dt> <dt>2184</dt> </dl>
///    </td> <td width="60%"> The service has not been started. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>NERR_WkstaNotStarted</b></dt> <dt>2138</dt> </dl> </td> <td width="60%"> The Workstation service has not
///    been started. The local workstation service is used to communicate with a downlevel remote server. </td> </tr>
///    </table>
///    
@DllImport("NETAPI32")
uint NetServerEnum(const(PWSTR) servername, uint level, ubyte** bufptr, uint prefmaxlen, uint* entriesread, 
                   uint* totalentries, uint servertype, const(PWSTR) domain, uint* resume_handle);

///The <b>NetServerGetInfo</b> function retrieves current configuration information for the specified server.
///Params:
///    servername = Pointer to a string that specifies the name of the remote server on which the function is to execute. If this
///                 parameter is <b>NULL</b>, the local computer is used.
///    level = Specifies the information level of the data. This parameter can be one of the following values. <table> <tr>
///            <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="100"></a><dl> <dt><b>100</b></dt> </dl> </td>
///            <td width="60%"> Return the server name and platform information. The <i>bufptr</i> parameter points to a
///            SERVER_INFO_100 structure. </td> </tr> <tr> <td width="40%"><a id="101"></a><dl> <dt><b>101</b></dt> </dl> </td>
///            <td width="60%"> Return the server name, type, and associated software. The <i>bufptr</i> parameter points to a
///            SERVER_INFO_101 structure. </td> </tr> <tr> <td width="40%"><a id="102"></a><dl> <dt><b>102</b></dt> </dl> </td>
///            <td width="60%"> Return the server name, type, associated software, and other attributes. The <i>bufptr</i>
///            parameter points to a SERVER_INFO_102 structure. </td> </tr> </table>
///    bufptr = Pointer to the buffer that receives the data. The format of this data depends on the value of the <i>level</i>
///             parameter. This buffer is allocated by the system and must be freed using the NetApiBufferFree function.
///Returns:
///    If the function succeeds, the return value is NERR_Success. If the function fails, the return value can be one of
///    the following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
///    <dl> <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> The user does not have access to the
///    requested information. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_LEVEL</b></dt> </dl> </td> <td
///    width="60%"> The value specified for the <i>level</i> parameter is invalid. </td> </tr> <tr> <td width="40%">
///    <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> The specified parameter is invalid.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NOT_ENOUGH_MEMORY</b></dt> </dl> </td> <td width="60%">
///    Insufficient memory is available. </td> </tr> </table>
///    
@DllImport("srvcli")
uint NetServerGetInfo(PWSTR servername, uint level, ubyte** bufptr);

///The <b>NetServerSetInfo</b> function sets a server's operating parameters; it can set them individually or
///collectively. The information is stored in a way that allows it to remain in effect after the system has been
///reinitialized.
///Params:
///    servername = Pointer to a string that specifies the name of the remote server on which the function is to execute. If this
///                 parameter is <b>NULL</b>, the local computer is used.
///    level = Specifies the information level of the data. This parameter can be one of the following values. <table> <tr>
///            <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="101"></a><dl> <dt><b>101</b></dt> </dl> </td>
///            <td width="60%"> Specifies the server name, type, and associated software. The <i>buf</i> parameter points to a
///            SERVER_INFO_101 structure. </td> </tr> <tr> <td width="40%"><a id="102"></a><dl> <dt><b>102</b></dt> </dl> </td>
///            <td width="60%"> Specifies the server name, type, associated software, and other attributes. The <i>buf</i>
///            parameter points to a SERVER_INFO_102 structure. </td> </tr> <tr> <td width="40%"><a id="402"></a><dl>
///            <dt><b>402</b></dt> </dl> </td> <td width="60%"> Specifies detailed information about the server. The <i>buf</i>
///            parameter points to a SERVER_INFO_402 structure. </td> </tr> <tr> <td width="40%"><a id="403"></a><dl>
///            <dt><b>403</b></dt> </dl> </td> <td width="60%"> Specifies detailed information about the server. The <i>buf</i>
///            parameter points to a SERVER_INFO_403 structure. </td> </tr> </table> In addition, levels 1001-1006, 1009-1011,
///            1016-1018, 1021, 1022, 1028, 1029, 1037, and 1043 are valid based on the restrictions for LAN Manager systems.
///    buf = Pointer to a buffer that receives the server information. The format of this data depends on the value of the
///          <i>level</i> parameter. For more information, see Network Management Function Buffers.
///    ParmError = Pointer to a value that receives the index of the first member of the server information structure that causes
///                the ERROR_INVALID_PARAMETER error. If this parameter is <b>NULL</b>, the index is not returned on error. For more
///                information, see the following Remarks section.
///Returns:
///    If the function succeeds, the return value is NERR_Success. If the function fails, the return value can be one of
///    the following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
///    <dl> <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> The user does not have access to the
///    requested information. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_LEVEL</b></dt> </dl> </td> <td
///    width="60%"> The value specified for the <i>level</i> parameter is invalid. </td> </tr> <tr> <td width="40%">
///    <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> The specified parameter is invalid. For
///    more information, see the following Remarks section. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_NOT_ENOUGH_MEMORY</b></dt> </dl> </td> <td width="60%"> Insufficient memory is available. </td>
///    </tr> </table>
///    
@DllImport("srvcli")
uint NetServerSetInfo(PWSTR servername, uint level, ubyte* buf, uint* ParmError);

///The <b>NetServerDiskEnum</b> function retrieves a list of disk drives on a server. The function returns an array of
///three-character strings (a drive letter, a colon, and a terminating null character).
///Params:
///    servername = A pointer to a string that specifies the DNS or NetBIOS name of the remote server on which the function is to
///                 execute. If this parameter is <b>NULL</b>, the local computer is used.
///    level = The level of information required. A value of zero is the only valid level.
///    bufptr = A pointer to the buffer that receives the data. The data is an array of three-character strings (a drive letter,
///             a colon, and a terminating null character). This buffer is allocated by the system and must be freed using the
///             NetApiBufferFree function. Note that you must free the buffer even if the function fails with ERROR_MORE_DATA.
///    prefmaxlen = The preferred maximum length of returned data, in bytes. If you specify MAX_PREFERRED_LENGTH, the function
///                 allocates the amount of memory required for the data. If you specify another value in this parameter, it can
///                 restrict the number of bytes that the function returns. If the buffer size is insufficient to hold all entries,
///                 the function returns ERROR_MORE_DATA. For more information, see Network Management Function Buffers and Network
///                 Management Function Buffer Lengths. <div class="alert"><b>Note</b> This parameter is currently ignored.</div>
///                 <div> </div>
///    entriesread = A pointer to a value that receives the count of elements actually enumerated.
///    totalentries = A pointer to a value that receives the total number of entries that could have been enumerated from the current
///                   resume position. Note that applications should consider this value only as a hint.
///    resume_handle = A pointer to a value that contains a resume handle which is used to continue an existing server disk search. The
///                    handle should be zero on the first call and left unchanged for subsequent calls. If the <i>resume_handle</i>
///                    parameter is a <b>NULL</b> pointer, then no resume handle is stored.
///Returns:
///    If the function succeeds, the return value is NERR_Success. If the function fails, the return value can be one of
///    the following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
///    <dl> <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> The user does not have access to the
///    requested information. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_LEVEL</b></dt> </dl> </td> <td
///    width="60%"> The value specified for the <i>level</i> parameter is invalid. </td> </tr> <tr> <td width="40%">
///    <dl> <dt><b>ERROR_MORE_DATA</b></dt> </dl> </td> <td width="60%"> More entries are available. Specify a large
///    enough buffer to receive all entries. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_NOT_ENOUGH_MEMORY</b></dt> </dl> </td> <td width="60%"> Insufficient memory is available. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NOT_SUPPORTED</b></dt> </dl> </td> <td width="60%"> The request is
///    not supported. This error is returned if a remote server was specified in <i>servername</i> parameter, the remote
///    server only supports remote RPC calls using the legacy Remote Access Protocol mechanism, and this request is not
///    supported. </td> </tr> </table>
///    
@DllImport("srvcli")
uint NetServerDiskEnum(PWSTR servername, uint level, ubyte** bufptr, uint prefmaxlen, uint* entriesread, 
                       uint* totalentries, uint* resume_handle);

///The <b>NetServerComputerNameAdd</b> function enumerates the transports on which the specified server is active, and
///binds the emulated server name to each of the transports. <b>NetServerComputerNameAdd</b> is a utility function that
///combines the functionality of the NetServerTransportEnum function and the NetServerTransportAddEx function.
///Params:
///    ServerName = Pointer to a string that specifies the name of the remote server on which the function is to execute. If this
///                 parameter is <b>NULL</b>, the local computer is used.
///    EmulatedDomainName = Pointer to a string that contains the domain name the specified server should use when announcing its presence
///                         using the <i>EmulatedServerName</i>. This parameter is optional.
///    EmulatedServerName = Pointer to a null-terminated character string that contains the emulated name the server should begin supporting
///                         in addition to the name specified by the <i>ServerName</i> parameter.
///Returns:
///    If the function succeeds, the return value is NERR_Success. Note that <b>NetServerComputerNameAdd</b> succeeds if
///    the emulated server name specified is added to at least one transport. If the function fails, the return value
///    can be one of the following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> The user does not have access
///    to the requested information. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_DUP_NAME</b></dt> </dl> </td>
///    <td width="60%"> A duplicate name exists on the network. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_DOMAINNAME</b></dt> </dl> </td> <td width="60%"> The domain name could not be found on the
///    network. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td
///    width="60%"> The specified parameter is invalid. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_NOT_ENOUGH_MEMORY</b></dt> </dl> </td> <td width="60%"> Insufficient memory is available. </td>
///    </tr> </table>
///    
@DllImport("srvcli")
uint NetServerComputerNameAdd(PWSTR ServerName, PWSTR EmulatedDomainName, PWSTR EmulatedServerName);

///The <b>NetServerComputerNameDel</b> function causes the specified server to cease supporting the emulated server name
///set by a previous call to the NetServerComputerNameAdd function. The function does this by unbinding network
///transports from the emulated name.
///Params:
///    ServerName = Pointer to a string that specifies the DNS or NetBIOS name of the remote server on which the function is to
///                 execute. If this parameter is <b>NULL</b>, the local computer is used.
///    EmulatedServerName = Pointer to a null-terminated character string that contains the emulated name the server should stop supporting.
///                         The server continues to support all other server names it was supporting.
///Returns:
///    If the function succeeds, the return value is NERR_Success. If the function fails, the return value can be one of
///    the following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
///    <dl> <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> The user does not have access to the
///    requested information. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td>
///    <td width="60%"> The specified parameter is invalid. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_NOT_ENOUGH_MEMORY</b></dt> </dl> </td> <td width="60%"> Insufficient memory is available. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>NERR_NetNameNotFound</b></dt> </dl> </td> <td width="60%"> The share name
///    does not exist. </td> </tr> </table>
///    
@DllImport("srvcli")
uint NetServerComputerNameDel(PWSTR ServerName, PWSTR EmulatedServerName);

///The <b>NetServerTransportAdd</b> function binds the server to the transport protocol. The extended function
///NetServerTransportAddEx allows the calling application to specify the SERVER_TRANSPORT_INFO_1,
///SERVER_TRANSPORT_INFO_2, and SERVER_TRANSPORT_INFO_3 information levels.
///Params:
///    servername = A pointer to a string that specifies the name of the remote server on which the function is to execute. If this
///                 parameter is <b>NULL</b>, the local computer is used.
///    level = Specifies the information level of the data. This parameter can be the following value. <table> <tr>
///            <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="0"></a><dl> <dt><b>0</b></dt> </dl> </td> <td
///            width="60%"> Specifies information about the transport protocol, including name, address, and location on the
///            network. The <i>bufptr</i> parameter points to a SERVER_TRANSPORT_INFO_0 structure. </td> </tr> </table>
///    bufptr = A pointer to the buffer that contains the data. For more information, see Network Management Function Buffers.
///Returns:
///    If the function succeeds, the return value is NERR_Success. If the function fails, the return value can be one of
///    the following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
///    <dl> <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> The user does not have access to the
///    requested information. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_DUP_NAME</b></dt> </dl> </td> <td
///    width="60%"> A duplicate name exists on the network. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_DOMAINNAME</b></dt> </dl> </td> <td width="60%"> The domain name could not be found on the
///    network. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_LEVEL</b></dt> </dl> </td> <td width="60%">
///    The value specified for the <i>level</i> parameter is invalid. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> A parameter is invalid. This error is
///    returned if the <b>svti0_transportname</b> or <b>svti0_transportaddress</b> member in the SERVER_TRANSPORT_INFO_0
///    structure pointed to by the <i>bufptr</i> parameter is <b>NULL</b>. This error is also returned if the
///    <b>svti0_transportaddresslength</b> member in the <b>SERVER_TRANSPORT_INFO_0</b> structure pointed to by the
///    <i>bufptr</i> parameter is zero or larger than MAX_PATH (defined in the Windef.h header file). This error is also
///    returned for other invalid parameters. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_NOT_ENOUGH_MEMORY</b></dt> </dl> </td> <td width="60%"> Insufficient memory is available. </td>
///    </tr> </table>
///    
@DllImport("srvcli")
uint NetServerTransportAdd(PWSTR servername, uint level, ubyte* bufptr);

///The <b>NetServerTransportAddEx</b> function binds the specified server to the transport protocol. This extended
///function allows the calling application to specify the SERVER_TRANSPORT_INFO_0, SERVER_TRANSPORT_INFO_1,
///SERVER_TRANSPORT_INFO_2, or SERVER_TRANSPORT_INFO_3 information levels.
///Params:
///    servername = A pointer to a string that specifies the name of the remote server on which the function is to execute. If this
///                 parameter is <b>NULL</b>, the local computer is used.
///    level = Specifies a value that indicates the information level of the data. This parameter can be one of the following
///            values. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="0"></a><dl>
///            <dt><b>0</b></dt> </dl> </td> <td width="60%"> Specifies information about the transport protocol, including
///            name, address, and location on the network. The <i>bufptr</i> parameter points to a SERVER_TRANSPORT_INFO_0
///            structure. </td> </tr> <tr> <td width="40%"><a id="1"></a><dl> <dt><b>1</b></dt> </dl> </td> <td width="60%">
///            Specifies information about the transport protocol, including name, address, network location, and domain. The
///            <i>bufptr</i> parameter points to a SERVER_TRANSPORT_INFO_1 structure. </td> </tr> <tr> <td width="40%"><a
///            id="2"></a><dl> <dt><b>2</b></dt> </dl> </td> <td width="60%"> Specifies the same information as level 1, with
///            the addition of an <b>svti2_flags</b> member. The <i>bufptr</i> parameter points to a SERVER_TRANSPORT_INFO_2
///            structure. </td> </tr> <tr> <td width="40%"><a id="3"></a><dl> <dt><b>3</b></dt> </dl> </td> <td width="60%">
///            Specifies the same information as level 2, with the addition of credential information. The <i>bufptr</i>
///            parameter points to a SERVER_TRANSPORT_INFO_3 structure. </td> </tr> </table>
///    bufptr = A pointer to the buffer that contains the data. The format of this data depends on the value of the <i>level</i>
///             parameter. For more information, see Network Management Function Buffers.
///Returns:
///    If the function succeeds, the return value is NERR_Success. If the function fails, the return value can be one of
///    the following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
///    <dl> <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> The user does not have access to the
///    requested information. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_DUP_NAME</b></dt> </dl> </td> <td
///    width="60%"> A duplicate name exists on the network. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_DOMAINNAME</b></dt> </dl> </td> <td width="60%"> The domain name could not be found on the
///    network. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_LEVEL</b></dt> </dl> </td> <td width="60%">
///    The value specified for the <i>level</i> parameter is invalid. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> A parameter is invalid. This error is
///    returned if the transport name or transport address member in the SERVER_TRANSPORT_INFO_0,
///    SERVER_TRANSPORT_INFO_1, SERVER_TRANSPORT_INFO_2, or SERVER_TRANSPORT_INFO_3 structure pointed to by the
///    <i>bufptr</i> parameter is <b>NULL</b>. This error is also returned if the transport address length member in the
///    <b>SERVER_TRANSPORT_INFO_0</b>, <b>SERVER_TRANSPORT_INFO_1</b>, <b>SERVER_TRANSPORT_INFO_2</b>, or
///    <b>SERVER_TRANSPORT_INFO_3</b> structure pointed to by the <i>bufptr</i> parameter is zero or larger than
///    MAX_PATH (defined in the <i>Windef.h</i> header file). This error is also returned if the flags member of the
///    <b>SERVER_TRANSPORT_INFO_2</b>, or <b>SERVER_TRANSPORT_INFO_3</b> structure pointed to by the <i>bufptr</i>
///    parameter contains an illegal value. This error is also returned for other invalid parameters. </td> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>ERROR_NOT_ENOUGH_MEMORY</b></dt> </dl> </td> <td width="60%"> Insufficient memory is
///    available. </td> </tr> </table>
///    
@DllImport("srvcli")
uint NetServerTransportAddEx(PWSTR servername, uint level, ubyte* bufptr);

///The <b>NetServerTransportDel</b> function unbinds (or disconnects) the transport protocol from the server.
///Effectively, the server can no longer communicate with clients using the specified transport protocol (such as TCP or
///XNS).
///Params:
///    servername = Pointer to a string that specifies the DNS or NetBIOS name of the remote server on which the function is to
///                 execute. If this parameter is <b>NULL</b>, the local computer is used.
///    level = Specifies the information level of the data. This parameter can be one of the following values. <table> <tr>
///            <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="0"></a><dl> <dt><b>0</b></dt> </dl> </td> <td
///            width="60%"> Specifies information about the transport protocol, including name, address, and location on the
///            network. The <i>bufptr</i> parameter points to a SERVER_TRANSPORT_INFO_0 structure. </td> </tr> <tr> <td
///            width="40%"><a id="1"></a><dl> <dt><b>1</b></dt> </dl> </td> <td width="60%"> Specifies information about the
///            transport protocol, including name, address, network location, and domain. The <i>bufptr</i> parameter points to
///            a SERVER_TRANSPORT_INFO_1 structure. </td> </tr> </table>
///    bufptr = Pointer to the buffer that specifies the data. The format of this data depends on the value of the <i>level</i>
///             parameter. For more information, see Network Management Function Buffers.
///Returns:
///    If the function succeeds, the return value is NERR_Success. If the function fails, the return value can be one of
///    the following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
///    <dl> <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> The user does not have access to the
///    requested information. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_LEVEL</b></dt> </dl> </td> <td
///    width="60%"> The value specified for the <i>level</i> parameter is invalid. </td> </tr> <tr> <td width="40%">
///    <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> The specified parameter is invalid.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NOT_ENOUGH_MEMORY</b></dt> </dl> </td> <td width="60%">
///    Insufficient memory is available. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>NERR_NetNameNotFound</b></dt>
///    </dl> </td> <td width="60%"> The share name does not exist. </td> </tr> </table>
///    
@DllImport("srvcli")
uint NetServerTransportDel(PWSTR servername, uint level, ubyte* bufptr);

///The <b>NetServerTransportEnum</b> function supplies information about transport protocols that are managed by the
///server.
///Params:
///    servername = Pointer to a string that specifies the DNS or NetBIOS name of the remote server on which the function is to
///                 execute. If this parameter is <b>NULL</b>, the local computer is used.
///    level = Specifies the information level of the data. This parameter can be one of the following values. <table> <tr>
///            <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="0"></a><dl> <dt><b>0</b></dt> </dl> </td> <td
///            width="60%"> Return information about the transport protocol, including name, address, and location on the
///            network. The <i>bufptr</i> parameter points to an array of SERVER_TRANSPORT_INFO_0 structures. </td> </tr> <tr>
///            <td width="40%"><a id="1"></a><dl> <dt><b>1</b></dt> </dl> </td> <td width="60%"> Return information about the
///            transport protocol, including name, address, network location, and domain. The <i>bufptr</i> parameter points to
///            an array of SERVER_TRANSPORT_INFO_1 structures. </td> </tr> </table>
///    bufptr = Pointer to the buffer that receives the data. The format of this data depends on the value of the <i>level</i>
///             parameter. This buffer is allocated by the system and must be freed using the NetApiBufferFree function. Note
///             that you must free the buffer even if the function fails with ERROR_MORE_DATA.
///    prefmaxlen = Specifies the preferred maximum length of returned data, in bytes. If you specify MAX_PREFERRED_LENGTH, the
///                 function allocates the amount of memory required for the data. If you specify another value in this parameter, it
///                 can restrict the number of bytes that the function returns. If the buffer size is insufficient to hold all
///                 entries, the function returns ERROR_MORE_DATA. For more information, see Network Management Function Buffers and
///                 Network Management Function Buffer Lengths.
///    entriesread = Pointer to a value that receives the count of elements actually enumerated.
///    totalentries = Pointer to a value that receives the total number of entries that could have been enumerated from the current
///                   resume position. Note that applications should consider this value only as a hint.
///    resume_handle = Pointer to a value that contains a resume handle which is used to continue an existing server transport search.
///                    The handle should be zero on the first call and left unchanged for subsequent calls. If this parameter is
///                    <b>NULL</b>, no resume handle is stored.
///Returns:
///    If the function succeeds, the return value is NERR_Success. If the function fails, the return value can be one of
///    the following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
///    <dl> <dt><b>ERROR_INVALID_LEVEL</b></dt> </dl> </td> <td width="60%"> The value specified for the <i>level</i>
///    parameter is invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_MORE_DATA</b></dt> </dl> </td> <td
///    width="60%"> More entries are available. Specify a large enough buffer to receive all entries. </td> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>ERROR_NOT_ENOUGH_MEMORY</b></dt> </dl> </td> <td width="60%"> Insufficient memory is
///    available. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>NERR_BufTooSmall</b></dt> </dl> </td> <td width="60%">
///    The supplied buffer is too small. </td> </tr> </table>
///    
@DllImport("srvcli")
uint NetServerTransportEnum(PWSTR servername, uint level, ubyte** bufptr, uint prefmaxlen, uint* entriesread, 
                            uint* totalentries, uint* resume_handle);

///The <b>NetServiceControl</b> function is obsolete. It is included for compatibility with 16-bit versions of Windows.
///Other applications should use the service functions.
///Params:
///    servername = TBD
///    service = TBD
///    opcode = TBD
///    arg = TBD
@DllImport("NETAPI32")
uint NetServiceControl(const(PWSTR) servername, const(PWSTR) service, uint opcode, uint arg, ubyte** bufptr);

///The <b>NetServiceEnum</b> function is obsolete. It is included for compatibility with 16-bit versions of Windows.
///Other applications should use the service functions.
///Params:
///    servername = TBD
///    level = TBD
///    bufptr = TBD
///    prefmaxlen = TBD
///    entriesread = TBD
///    totalentries = TBD
@DllImport("NETAPI32")
uint NetServiceEnum(const(PWSTR) servername, uint level, ubyte** bufptr, uint prefmaxlen, uint* entriesread, 
                    uint* totalentries, uint* resume_handle);

///The <b>NetServiceGetInfo</b> function is obsolete. It is included for compatibility with 16-bit versions of Windows.
///Other applications should use the service functions.
///Params:
///    servername = TBD
///    service = TBD
///    level = TBD
@DllImport("NETAPI32")
uint NetServiceGetInfo(const(PWSTR) servername, const(PWSTR) service, uint level, ubyte** bufptr);

///The <b>NetServiceInstall</b> function is obsolete. It is included for compatibility with 16-bit versions of Windows.
///Other applications should use the service functions.
///Params:
///    servername = TBD
///    service = TBD
///    argc = TBD
///    argv = TBD
@DllImport("NETAPI32")
uint NetServiceInstall(const(PWSTR) servername, const(PWSTR) service, uint argc, PWSTR** argv, ubyte** bufptr);

///The <b>NetUseAdd</b> function establishes a connection between the local computer and a remote server. You can
///specify a local drive letter or a printer device to connect. If you do not specify a local drive letter or printer
///device, the function authenticates the client with the server for future connections.
///Params:
///    servername = The UNC name of the computer on which to execute this function. If this parameter is <b>NULL</b>, then the local
///                 computer is used. If the <i>UncServerName</i> parameter specified is a remote computer, then the remote computer
///                 must support remote RPC calls using the legacy Remote Access Protocol mechanism. This string is Unicode if
///                 <b>_WIN32_WINNT</b> or <b>FORCE_UNICODE</b> are defined.
///    LevelFlags = A value that specifies the information level of the data. This parameter can be one of the following values.
///                 <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="1"></a><dl> <dt><b>1</b></dt>
///                 </dl> </td> <td width="60%"> Specifies information about the connection between a local device and a shared
///                 resource. Information includes the connection status and type. The <i>Buf</i> parameter is a pointer to a
///                 USE_INFO_1 structure. </td> </tr> <tr> <td width="40%"><a id="2"></a><dl> <dt><b>2</b></dt> </dl> </td> <td
///                 width="60%"> Specifies information about the connection between a local device and a shared resource. Information
///                 includes the connection status and type, and a user name and domain name. The <i>Buf</i> parameter is a pointer
///                 to a USE_INFO_2 structure. </td> </tr> </table>
///    buf = A pointer to the buffer that specifies the data. The format of this data depends on the value of the <i>Level</i>
///          parameter. For more information, see Network Management Function Buffers.
///    parm_err = A pointer to a value that receives the index of the first member of the information structure in error when the
///               ERROR_INVALID_PARAMETER error is returned. If this parameter is <b>NULL</b>, the index is not returned on error.
///               For more information, see the following Remarks section.
///Returns:
///    If the function succeeds, the return value is NERR_Success. If the function fails, the return value is a system
///    error code. For a list of error codes, see System Error Codes.
///    
@DllImport("wkscli")
uint NetUseAdd(byte* servername, uint LevelFlags, ubyte* buf, uint* parm_err);

///The <b>NetUseDel</b> function ends a connection to a shared resource. You can also use the WNetCancelConnection2
///function to terminate a network connection.
///Params:
///    UncServerName = The UNC name of the computer on which to execute this function. If this is parameter is <b>NULL</b>, then the
///                    local computer is used. If the <i>UncServerName</i> parameter specified is a remote computer, then the remote
///                    computer must support remote RPC calls using the legacy Remote Access Protocol mechanism. This string is Unicode
///                    if <b>_WIN32_WINNT</b> or <b>FORCE_UNICODE</b> are defined.
///    UseName = A pointer to a string that specifies the path of the connection to delete. This string is Unicode if
///              <b>_WIN32_WINNT</b> or <b>FORCE_UNICODE</b> are defined.
///    ForceLevelFlags = The level of force to use in deleting the connection. This parameter can be one of the following values defined
///                      in the <i>lmuseflg.h</i> header file. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
///                      id="USE_NOFORCE"></a><a id="use_noforce"></a><dl> <dt><b>USE_NOFORCE</b></dt> </dl> </td> <td width="60%"> Fail
///                      the disconnection if open files exist on the connection. </td> </tr> <tr> <td width="40%"><a
///                      id="USE_FORCE"></a><a id="use_force"></a><dl> <dt><b>USE_FORCE</b></dt> </dl> </td> <td width="60%"> Do not fail
///                      the disconnection if open files exist on the connection. </td> </tr> <tr> <td width="40%"><a
///                      id="USE_LOTS_OF_FORCE"></a><a id="use_lots_of_force"></a><dl> <dt><b>USE_LOTS_OF_FORCE</b></dt> </dl> </td> <td
///                      width="60%"> Close any open files and delete the connection. </td> </tr> </table>
///Returns:
///    If the function succeeds, the return value is NERR_Success. If the function fails, the return value is a system
///    error code. For a list of error codes, see System Error Codes.
///    
@DllImport("wkscli")
uint NetUseDel(PWSTR UncServerName, PWSTR UseName, uint ForceLevelFlags);

///The <b>NetUseEnum</b> function lists all current connections between the local computer and resources on remote
///servers. You can also use the WNetOpenEnum and the WNetEnumResource functions to enumerate network resources or
///connections.
///Params:
///    UncServerName = The UNC name of the computer on which to execute this function. If this is parameter is <b>NULL</b>, then the
///                    local computer is used. If the <i>UncServerName</i> parameter specified is a remote computer, then the remote
///                    computer must support remote RPC calls using the legacy Remote Access Protocol mechanism. This string is Unicode
///                    if <b>_WIN32_WINNT</b> or <b>FORCE_UNICODE</b> are defined.
///    LevelFlags = The information level of the data requested. This parameter can be one of the following values. <table> <tr>
///                 <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt>0</dt> </dl> </td> <td width="60%">
///                 Specifies a local device name and the share name of a remote resource. The <i>BufPtr</i> parameter points to an
///                 array of USE_INFO_0 structures. </td> </tr> <tr> <td width="40%"> <dl> <dt>1</dt> </dl> </td> <td width="60%">
///                 Specifies information about the connection between a local device and a shared resource, including connection
///                 status and type. The <i>BufPtr</i> parameter points to an array of USE_INFO_1 structures. </td> </tr> <tr> <td
///                 width="40%"> <dl> <dt>2</dt> </dl> </td> <td width="60%"> Specifies information about the connection between a
///                 local device and a shared resource. Information includes the connection status, connection type, user name, and
///                 domain name. The <i>BufPtr</i> parameter points to an array of USE_INFO_2 structures. </td> </tr> </table>
///    BufPtr = A pointer to the buffer that receives the information structures. The format of this data depends on the value of
///             the <i>Level</i> parameter. This buffer is allocated by the system and must be freed using the NetApiBufferFree
///             function when the information is no longer needed. Note that you must free the buffer even if the function fails
///             with <b>ERROR_MORE_DATA</b>.
///    PreferedMaximumSize = The preferred maximum length, in bytes, of the data to return. If <b>MAX_PREFERRED_LENGTH</b> is specified, the
///                          function allocates the amount of memory required for the data. If another value is specified in this parameter,
///                          it can restrict the number of bytes that the function returns. If the buffer size is insufficient to hold all
///                          entries, the function returns <b>ERROR_MORE_DATA</b>. For more information, see Network Management Function
///                          Buffers and Network Management Function Buffer Lengths.
///    EntriesRead = A pointer to a value that receives the count of elements actually enumerated.
///    TotalEntries = A pointer to a value that receives the total number of entries that could have been enumerated from the current
///                   resume position. Note that applications should consider this value only as a hint.
///    ResumeHandle = A pointer to a value that contains a resume handle which is used to continue the search. The handle should be
///                   zero on the first call and left unchanged for subsequent calls. If <i>ResumeHandle</i> is <b>NULL</b>, then no
///                   resume handle is stored.
///Returns:
///    If the function succeeds, the return value is NERR_Success. If the function fails, the return value is a system
///    error code. For a list of error codes, see System Error Codes. <table> <tr> <th>Return code</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td
///    width="60%"> An invalid parameter was passed to the function. This error is returned if a <b>NULL</b> pointer is
///    passed in the <i>BufPtr</i> or <i>entriesread</i> parameters. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_MORE_DATA</b></dt> </dl> </td> <td width="60%"> There is more data to return. This error is returned
///    if the buffer size is insufficient to hold all entries. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_NOT_SUPPORTED</b></dt> </dl> </td> <td width="60%"> The request is not supported. This error is
///    returned if the <i>UncServerName</i> parameter was not <b>NULL</b> and the remote server does not support remote
///    RPC calls using the legacy Remote Access Protocol mechanism. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>Other</b></dt> </dl> </td> <td width="60%"> Use FormatMessage to obtain the message string for the
///    returned error. </td> </tr> </table>
///    
@DllImport("wkscli")
uint NetUseEnum(PWSTR UncServerName, uint LevelFlags, ubyte** BufPtr, uint PreferedMaximumSize, uint* EntriesRead, 
                uint* TotalEntries, uint* ResumeHandle);

///The <b>NetUseGetInfo</b> function retrieves information about a connection to a shared resource. You can also use the
///WNetGetConnection function to retrieve the name of a network resource associated with a local device.
///Params:
///    UncServerName = The UNC name of computer on which to execute this function. If this is parameter is <b>NULL</b>, then the local
///                    computer is used. If the <i>UncServerName</i> parameter specified is a remote computer, then the remote computer
///                    must support remote RPC calls using the legacy Remote Access Protocol mechanism. This string is Unicode if
///                    <b>_WIN32_WINNT</b> or <b>FORCE_UNICODE</b> are defined.
///    UseName = A pointer to a string that specifies the name of the connection for which to return information. This string is
///              Unicode if <b>_WIN32_WINNT</b> or <b>FORCE_UNICODE</b> are defined.
///    LevelFlags = The information level of the data requested. This parameter can be one of the following values. <table> <tr>
///                 <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt>0</dt> </dl> </td> <td width="60%">
///                 Specifies a local device name and the share name of a remote resource. The <i>BufPtr</i> parameter is a pointer
///                 to a USE_INFO_0 structure. </td> </tr> <tr> <td width="40%"> <dl> <dt>1</dt> </dl> </td> <td width="60%">
///                 Specifies information about the connection between a local device and a shared resource, including connection
///                 status and type. The <i>BufPtr</i> parameter is a pointer to a USE_INFO_1 structure. </td> </tr> <tr> <td
///                 width="40%"> <dl> <dt>2</dt> </dl> </td> <td width="60%"> Specifies information about the connection between a
///                 local device and a shared resource. Information includes the connection status, connection type, user name, and
///                 domain name. The <i>BufPtr</i> parameter is a pointer to a USE_INFO_2 structure. </td> </tr> </table>
///    bufptr = A pointer to the buffer that receives the data. The format of this data depends on the value of the <i>Level</i>
///             parameter. This buffer is allocated by the system and must be freed using the NetApiBufferFree function. For more
///             information, see Network Management Function Buffers and Network Management Function Buffer Lengths.
///Returns:
///    If the function succeeds, the return value is NERR_Success. If the function fails, the return value is a system
///    error code. For a list of error codes, see System Error Codes.
///    
@DllImport("wkscli")
uint NetUseGetInfo(PWSTR UncServerName, PWSTR UseName, uint LevelFlags, ubyte** bufptr);

///The <b>NetWkstaGetInfo</b> function returns information about the configuration of a workstation.
///Params:
///    servername = Pointer to a string that specifies the DNS or NetBIOS name of the remote server on which the function is to
///                 execute. If this parameter is <b>NULL</b>, the local computer is used.
///    level = Specifies the information level of the data. This parameter can be one of the following values. <table> <tr>
///            <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="100"></a><dl> <dt><b>100</b></dt> </dl> </td>
///            <td width="60%"> Return information about the workstation environment, including platform-specific information,
///            the name of the domain and the local computer, and information concerning the operating system. The <i>bufptr</i>
///            parameter points to a WKSTA_INFO_100 structure. </td> </tr> <tr> <td width="40%"><a id="101"></a><dl>
///            <dt><b>101</b></dt> </dl> </td> <td width="60%"> In addition to level 100 information, return the path to the
///            LANMAN directory. The <i>bufptr</i> parameter points to a WKSTA_INFO_101 structure. </td> </tr> <tr> <td
///            width="40%"><a id="102"></a><dl> <dt><b>102</b></dt> </dl> </td> <td width="60%"> In addition to level 101
///            information, return the number of users who are logged on to the local computer. The <i>bufptr</i> parameter
///            points to a WKSTA_INFO_102 structure. </td> </tr> </table>
///    bufptr = Pointer to the buffer that receives the data. The format of this data depends on the value of the <i>level</i>
///             parameter. This buffer is allocated by the system and must be freed using the NetApiBufferFree function. For more
///             information, see Network Management Function Buffers and Network Management Function Buffer Lengths.
///Returns:
///    If the function succeeds, the return value is NERR_Success. If the function fails, the return value can be one of
///    the following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
///    <dl> <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> The user does not have access to the
///    requested information. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_LEVEL</b></dt> </dl> </td> <td
///    width="60%"> The <i>level</i> parameter is invalid. </td> </tr> </table>
///    
@DllImport("wkscli")
uint NetWkstaGetInfo(PWSTR servername, uint level, ubyte** bufptr);

///The <b>NetWkstaSetInfo</b> function configures a workstation with information that remains in effect after the system
///has been reinitialized.
///Params:
///    servername = A pointer to a string that specifies the DNS or NetBIOS name of the remote server on which the function is to
///                 execute. If this parameter is <b>NULL</b>, the local computer is used.
///    level = The information level of the data. This parameter can be one of the following values. <table> <tr> <th>Value</th>
///            <th>Meaning</th> </tr> <tr> <td width="40%"><a id="100"></a><dl> <dt><b>100</b></dt> </dl> </td> <td width="60%">
///            <b>Windows NT: </b>Specifies information about a workstation environment, including platform-specific
///            information, the names of the domain and the local computer, and information concerning the operating system. The
///            <i>buffer</i> parameter points to a WKSTA_INFO_100 structure. The <b>wk100_computername</b> and
///            <b>wk100_langroup</b> fields of this structure cannot be set by calling this function. To set these values, call
///            SetComputerName/SetComputerNameEx or NetJoinDomain, respectively. </td> </tr> <tr> <td width="40%"><a
///            id="101"></a><dl> <dt><b>101</b></dt> </dl> </td> <td width="60%"> <b>Windows NT: </b>In addition to level 100
///            information, specifies the path to the LANMAN directory. The <i>buffer</i> parameter points to a WKSTA_INFO_101
///            structure. The <b>wk101_computername</b> and <b>wk101_langroup</b> fields of this structure cannot be set by
///            calling this function. To set these values, call SetComputerName/SetComputerNameEx or <b>NetJoinDomain</b>,
///            respectively. </td> </tr> <tr> <td width="40%"><a id="102"></a><dl> <dt><b>102</b></dt> </dl> </td> <td
///            width="60%"> <b>Windows NT: </b>In addition to level 101 information, specifies the number of users who are
///            logged on to the local computer. The <i>buffer</i> parameter points to a WKSTA_INFO_102 structure. The
///            <b>wk102_computername</b> and <b>wk102_langroup</b> fields of this structure cannot be set by calling this
///            function. To set these values, call SetComputerName/SetComputerNameEx or <b>NetJoinDomain</b>, respectively.
///            </td> </tr> <tr> <td width="40%"><a id="502"></a><dl> <dt><b>502</b></dt> </dl> </td> <td width="60%"> <b>Windows
///            NT: </b>The <i>buffer</i> parameter points to a WKSTA_INFO_502 structure that contains information about the
///            workstation environment. </td> </tr> </table> Do not set levels 1010-1013, 1018, 1023, 1027, 1028, 1032, 1033,
///            1035, or 1041-1062.
///    buffer = A pointer to the buffer that specifies the data. The format of this data depends on the value of the <i>level</i>
///             parameter. For more information, see Network Management Function Buffers.
///    parm_err = A pointer to a value that receives the index of the first member of the workstation information structure that
///               causes the ERROR_INVALID_PARAMETER error. If this parameter is <b>NULL</b>, the index is not returned on error.
///               For more information, see the Remarks section.
///Returns:
///    If the function succeeds, the return value is NERR_Success. If the function fails, the return value can be one of
///    the following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
///    <dl> <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> The user does not have access to the
///    requested information. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td>
///    <td width="60%"> One of the function parameters is invalid. For more information, see the following Remarks
///    section. </td> </tr> </table>
///    
@DllImport("wkscli")
uint NetWkstaSetInfo(PWSTR servername, uint level, ubyte* buffer, uint* parm_err);

///The <b>NetWkstaUserGetInfo</b> function returns information about the currently logged-on user. This function must be
///called in the context of the logged-on user.
///Params:
///    reserved = This parameter must be set to <b>NULL</b>.
///    level = Specifies the information level of the data. This parameter can be one of the following values. <table> <tr>
///            <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="0"></a><dl> <dt><b>0</b></dt> </dl> </td> <td
///            width="60%"> Return the name of the user currently logged on to the workstation. The <i>bufptr</i> parameter
///            points to a WKSTA_USER_INFO_0 structure. </td> </tr> <tr> <td width="40%"><a id="1"></a><dl> <dt><b>1</b></dt>
///            </dl> </td> <td width="60%"> Return information about the workstation, including the name of the current user and
///            the domains accessed by the workstation. The <i>bufptr</i> parameter points to a WKSTA_USER_INFO_1 structure.
///            </td> </tr> <tr> <td width="40%"><a id="1101"></a><dl> <dt><b>1101</b></dt> </dl> </td> <td width="60%"> Return
///            domains browsed by the workstation. The <i>bufptr</i> parameter points to a WKSTA_USER_INFO_1101 structure. </td>
///            </tr> </table>
///    bufptr = Pointer to the buffer that receives the data. The format of this data depends on the value of the <i>bufptr</i>
///             parameter. This buffer is allocated by the system and must be freed using the NetApiBufferFree function. For more
///             information, see Network Management Function Buffers and Network Management Function Buffer Lengths.
///Returns:
///    If the function succeeds, the return value is NERR_Success. If the function fails, the return value can be one of
///    the following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
///    <dl> <dt><b>ERROR_NOT_ENOUGH_MEMORY</b></dt> </dl> </td> <td width="60%"> The system ran out of memory resources.
///    Either the network manager configuration is incorrect, or the program is running on a system with insufficient
///    memory. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_LEVEL</b></dt> </dl> </td> <td width="60%">
///    The <i>level</i> parameter is invalid. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> One of the function parameters is invalid.
///    </td> </tr> </table>
///    
@DllImport("wkscli")
uint NetWkstaUserGetInfo(PWSTR reserved, uint level, ubyte** bufptr);

///The <b>NetWkstaUserSetInfo</b> function sets the user-specific information about the configuration elements for a
///workstation.
///Params:
///    reserved = This parameter must be set to zero.
///    level = Specifies the information level of the data. This parameter can be one of the following values. <table> <tr>
///            <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="1"></a><dl> <dt><b>1</b></dt> </dl> </td> <td
///            width="60%"> Specifies information about the workstation, including the name of the current user and the domains
///            accessed by the workstation. The <i>buf</i> parameter points to a WKSTA_USER_INFO_1 structure. </td> </tr> <tr>
///            <td width="40%"><a id="1101"></a><dl> <dt><b>1101</b></dt> </dl> </td> <td width="60%"> Specifies domains browsed
///            by the workstation. The <i>buf</i> parameter points to a WKSTA_USER_INFO_1101 structure. </td> </tr> </table>
///    buf = Pointer to the buffer that specifies the data. The format of this data depends on the value of the <i>level</i>
///          parameter. For more information, see Network Management Function Buffers.
///    parm_err = Pointer to a value that receives the index of the first parameter that causes the ERROR_INVALID_PARAMETER error.
///               If this parameter is <b>NULL</b>, the index is not returned on error.
///Returns:
///    If the function succeeds, the return value is NERR_Success. If the function fails, the return value can be one of
///    the following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
///    <dl> <dt><b>ERROR_INVALID_LEVEL</b></dt> </dl> </td> <td width="60%"> The <i>level</i> parameter is invalid.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> One
///    of the function parameters is invalid. </td> </tr> </table>
///    
@DllImport("wkscli")
uint NetWkstaUserSetInfo(PWSTR reserved, uint level, ubyte* buf, uint* parm_err);

///The <b>NetWkstaUserEnum</b> function lists information about all users currently logged on to the workstation. This
///list includes interactive, service and batch logons.
///Params:
///    servername = Pointer to a string that specifies the DNS or NetBIOS name of the remote server on which the function is to
///                 execute. If this parameter is <b>NULL</b>, the local computer is used.
///    level = Specifies the information level of the data. This parameter can be one of the following values. <table> <tr>
///            <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="0"></a><dl> <dt><b>0</b></dt> </dl> </td> <td
///            width="60%"> Return the names of users currently logged on to the workstation. The <i>bufptr</i> parameter points
///            to an array of WKSTA_USER_INFO_0 structures. </td> </tr> <tr> <td width="40%"><a id="1"></a><dl>
///            <dt><b>1</b></dt> </dl> </td> <td width="60%"> Return the names of the current users and the domains accessed by
///            the workstation. The <i>bufptr</i> parameter points to an array of WKSTA_USER_INFO_1 structures. </td> </tr>
///            </table>
///    bufptr = Pointer to the buffer that receives the data. The format of this data depends on the value of the <i>level</i>
///             parameter. This buffer is allocated by the system and must be freed using the NetApiBufferFree function. Note
///             that you must free the buffer even if the function fails with ERROR_MORE_DATA.
///    prefmaxlen = Specifies the preferred maximum length of returned data, in bytes. If you specify MAX_PREFERRED_LENGTH, the
///                 function allocates the amount of memory required for the data. If you specify another value in this parameter, it
///                 can restrict the number of bytes that the function returns. If the buffer size is insufficient to hold all
///                 entries, the function returns ERROR_MORE_DATA. For more information, see Network Management Function Buffers and
///                 Network Management Function Buffer Lengths.
///    entriesread = Pointer to a value that receives the count of elements actually enumerated.
///    totalentries = Pointer to a value that receives the total number of entries that could have been enumerated from the current
///                   resume position. Note that applications should consider this value only as a hint.
///    resumehandle = Pointer to a value that contains a resume handle which is used to continue an existing search. The handle should
///                   be zero on the first call and left unchanged for subsequent calls. If this parameter is <b>NULL</b>, no resume
///                   handle is stored.
///Returns:
///    If the function succeeds, the return value is NERR_Success. If the function fails, the return value can be one of
///    the following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
///    <dl> <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> The user does not have access to the
///    requested information. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_MORE_DATA</b></dt> </dl> </td> <td
///    width="60%"> More entries are available. Specify a large enough buffer to receive all entries. </td> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>ERROR_INVALID_LEVEL</b></dt> </dl> </td> <td width="60%"> The <i>level</i> parameter
///    is invalid. </td> </tr> </table>
///    
@DllImport("wkscli")
uint NetWkstaUserEnum(PWSTR servername, uint level, ubyte** bufptr, uint prefmaxlen, uint* entriesread, 
                      uint* totalentries, uint* resumehandle);

///<p class="CCE_Message">[This function is obsolete. To change the default settings for transport protocols manually,
///use the <b>Local Area Connection Properties</b> dialog box in the <b>Network and Dial-Up Connections</b> folder.] Not
///supported. The <b>NetWkstaTransportAdd</b> function binds (or connects) the redirector to the transport. The
///redirector is the software on the client computer which generates file requests to the server computer.
///Params:
///    servername = Pointer to a string that specifies the DNS or NetBIOS name of the remote server on which the function is to
///                 execute. If this parameter is <b>NULL</b>, the local computer is used. This string must begin with \\.
///    level = Specifies the information level of the data. This parameter can be the following value. <table> <tr>
///            <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="0"></a><dl> <dt><b>0</b></dt> </dl> </td> <td
///            width="60%"> Specifies workstation transport protocol information. The <i>buf</i> parameter points to a
///            WKSTA_TRANSPORT_INFO_0 structure. </td> </tr> </table>
///    buf = Pointer to the buffer that specifies the data. The format of this data depends on the value of the <i>level</i>
///          parameter. For more information, see Network Management Function Buffers.
///    parm_err = Pointer to a value that receives the index of the first parameter that causes the ERROR_INVALID_PARAMETER error.
///               If this parameter is <b>NULL</b>, the index is not returned on error.
///Returns:
///    If the function succeeds, the return value is NERR_Success. If the function fails, the return value can be one of
///    the following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
///    <dl> <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> The user does not have access to the
///    requested information. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_LEVEL</b></dt> </dl> </td> <td
///    width="60%"> The level parameter, which indicates what level of data structure information is available, is
///    invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td
///    width="60%"> One of the function parameters is invalid. </td> </tr> </table>
///    
@DllImport("wkscli")
uint NetWkstaTransportAdd(byte* servername, uint level, ubyte* buf, uint* parm_err);

///<p class="CCE_Message">[This function is obsolete. To change the default settings for transport protocols manually,
///use the <b>Local Area Connection Properties</b> dialog box in the <b>Network and Dial-Up Connections</b> folder.] Not
///supported. The <b>NetWkstaTransportDel</b> function unbinds the transport protocol from the redirector. (The
///redirector is the software on the client computer that generates file requests to the server computer.)
///Params:
///    servername = Pointer to a string that specifies the DNS or NetBIOS name of the remote server on which the function is to
///                 execute. If this parameter is <b>NULL</b>, the local computer is used. This string must begin with \\.
///    transportname = Pointer to a string that specifies the name of the transport protocol to disconnect from the redirector.
///    ucond = Specifies the level of force to use when disconnecting the transport protocol from the redirector. This parameter
///            can be one of the following values. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
///            id="USE_NOFORCE"></a><a id="use_noforce"></a><dl> <dt><b>USE_NOFORCE</b></dt> </dl> </td> <td width="60%"> Fail
///            the disconnection if open files exist on the connection. </td> </tr> <tr> <td width="40%"><a
///            id="USE_FORCE"></a><a id="use_force"></a><dl> <dt><b>USE_FORCE</b></dt> </dl> </td> <td width="60%"> Fail the
///            disconnection if open files exist on the connection. </td> </tr> <tr> <td width="40%"><a
///            id="USE_LOTS_OF_FORCE"></a><a id="use_lots_of_force"></a><dl> <dt><b>USE_LOTS_OF_FORCE</b></dt> </dl> </td> <td
///            width="60%"> Close any open files and delete the connection. </td> </tr> </table>
///Returns:
///    If the function succeeds, the return value is NERR_Success. If the function fails, the return value can be one of
///    the following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
///    <dl> <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> The user does not have access to the
///    requested information. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td>
///    <td width="60%"> One of the function parameters is invalid. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>NERR_UseNotFound</b></dt> </dl> </td> <td width="60%"> The network connection does not exist. </td> </tr>
///    </table>
///    
@DllImport("wkscli")
uint NetWkstaTransportDel(PWSTR servername, PWSTR transportname, uint ucond);

///The <b>NetWkstaTransportEnum</b> function supplies information about transport protocols that are managed by the
///redirector, which is the software on the client computer that generates file requests to the server computer.
///Params:
///    servername = A pointer to a string that specifies the DNS or NetBIOS name of the remote server on which the function is to
///                 execute. If this parameter is <b>NULL</b>, the local computer is used.
///    level = The level of information requested for the data. This parameter can be the following value. <table> <tr>
///            <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="0"></a><dl> <dt><b>0</b></dt> </dl> </td> <td
///            width="60%"> Return workstation transport protocol information. The <i>bufptr</i> parameter points to an array of
///            WKSTA_TRANSPORT_INFO_0 structures. </td> </tr> </table>
///    bufptr = A pointer to the buffer that receives the data. The format of this data depends on the value of the <i>level</i>
///             parameter. This buffer is allocated by the system and must be freed using the NetApiBufferFree function. Note
///             that you must free the buffer even if the function fails with <b>ERROR_MORE_DATA</b> or <b>NERR_BufTooSmall</b>.
///    prefmaxlen = The preferred maximum length of returned data, in bytes. If you specify <b>MAX_PREFERRED_LENGTH</b>, the function
///                 allocates the amount of memory required for the data. If you specify another value in this parameter, it can
///                 restrict the number of bytes that the function returns. If the buffer size is insufficient to hold all entries,
///                 the function returns <b>ERROR_MORE_DATA</b> or <b>NERR_BufTooSmall</b>. For more information, see Network
///                 Management Function Buffers and Network Management Function Buffer Lengths.
///    entriesread = A pointer to a value that receives the count of elements actually enumerated.
///    totalentries = A pointer to a value that receives the total number of entries that could have been enumerated from the current
///                   resume position. Note that applications should consider this value only as a hint.
///    resume_handle = A pointer to a value that contains a resume handle which is used to continue an existing workstation transport
///                    search. The handle should be zero on the first call and left unchanged for subsequent calls. If the
///                    <i>resumehandle</i> parameter is a <b>NULL</b> pointer, no resume handle is stored.
///Returns:
///    If the function succeeds, the return value is NERR_Success. If the function fails, the return value can be one of
///    the following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
///    <dl> <dt><b>ERROR_MORE_DATA</b></dt> </dl> </td> <td width="60%"> More entries are available. Specify a large
///    enough buffer to receive all entries. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_LEVEL</b></dt>
///    </dl> </td> <td width="60%"> The level parameter, which indicates what level of data structure information is
///    available, is invalid. This error is returned if the <i>level</i> parameter is specified as a value other than
///    zero. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%">
///    One or more parameters was invalid. This error is returned if the <i>bufptr</i> or the <i>entriesread</i>
///    parameters are <b>NULL</b> pointers. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_NOT_ENOUGH_MEMORY</b></dt> </dl> </td> <td width="60%"> Insufficient memory was available to process
///    the request. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NOT_SUPPORTED</b></dt> </dl> </td> <td
///    width="60%"> The request is not supported. This error is returned if a remote server was specified in
///    <i>servername</i> parameter, and this request is not supported on the remote server. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>NERR_BufTooSmall</b></dt> </dl> </td> <td width="60%"> More entries are available.
///    Specify a large enough buffer to receive all entries. This error code is defined in the <i>Lmerr.h</i> header
///    file. </td> </tr> </table>
///    
@DllImport("wkscli")
uint NetWkstaTransportEnum(byte* servername, uint level, ubyte** bufptr, uint prefmaxlen, uint* entriesread, 
                           uint* totalentries, uint* resume_handle);


