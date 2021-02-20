// Written in the D programming language.

module windows.passwordmanagement;

public import windows.core;
public import windows.systemservices : PWSTR;

extern(Windows) @nogc nothrow:


// Structs


///The <b>CYPHER_BLOCK</b> is the basic unit of storage for the one-way function (OWF) password hashes.
struct CYPHER_BLOCK
{
    ///An array of CHAR used to store the password hashes and cipher text passed by the MS-CHAP password management API.
    byte[8] data;
}

///The <b>LM_OWF_PASSWORD</b> stores the Lan Manage (LM) one-way function (OWF) of a user's password.
struct LM_OWF_PASSWORD
{
    ///An array of CYPHER_BLOCK structures that contain a LM OWF password hash. The contents of the array are calculated
    ///using the <b>LmEncryptedPasswordHash()</b> function as defined in RFC 2433, section A.8.
    CYPHER_BLOCK[2] data;
}

///The <b>SAMPR_ENCRYPTED_USER_PASSWORD</b> stores a user's encrypted password.
struct SAMPR_ENCRYPTED_USER_PASSWORD
{
    ///An array contains an encrypted password. The contents of the array are calculated using either the
    ///<b>NewPasswordEncryptedWithOldNtPasswordHash</b> or <b>NewPasswordEncryptedWithOldLmPasswordHash</b> functions as
    ///defined in RFC 2433, sections A.11 and A.15 respectively.
    ubyte[516] Buffer;
}

///The <b>ENCRYPTED_LM_OWF_PASSWORD</b> stores a user's encrypted Lan Manager (LM) one-way function (OWF) password hash.
struct ENCRYPTED_LM_OWF_PASSWORD
{
    ///An array of CYPHER_BLOCK structures that contain an encrypted LM OWF password hash. The contents of the array are
    ///calculated using the <b>OldLmPasswordHashEncryptedWithNewNtPasswordHash()</b> function as defined in RFC 2433,
    ///section A.16.
    CYPHER_BLOCK[2] data;
}

// Functions

///The <b>MSChapSrvChangePassword</b> function changes the password of a user account.
///Params:
///    ServerName = A pointer to a null-terminated Unicode string that specifies the Universal Naming Convention (UNC) name of the
///                 server on which to operate. If this parameter is <b>NULL</b>, the function operates on the local computer.
///    UserName = A pointer to a null-terminated Unicode string that specifies the name of the user whose password is being
///               changed.
///    LmOldPresent = A <b>BOOLEAN</b> that specifies whether the password designated by <i>LmOldOwfPassword</i> is valid.
///                   <i>LmOldPresent</i> is <b>FALSE</b> if the <i>LmOldOwfPassword</i> password is greater than 128-bits in length,
///                   and therefore cannot be represented by a Lan Manager (LM) one-way function (OWF) password. Otherwise, it is
///                   <b>TRUE</b>.
///    LmOldOwfPassword = A pointer to a LM_OWF_PASSWORD structure that contains the OWF of the user's current LM password. This parameter
///                       is ignored if <i>LmOldPresent</i> is <b>FALSE</b>.
///    LmNewOwfPassword = A pointer to a LM_OWF_PASSWORD structure that contains the OWF of the user's new LM password.
///    NtOldOwfPassword = A pointer to a NT_OWF_PASSWORD structure that contains the OWF of the user's current NT password.
///    NtNewOwfPassword = A pointer to a NT_OWF_PASSWORD structure that contains the OWF of the user's new NT password.
///Returns:
///    If the function succeeds, the return value is <b>STATUS_SUCCESS (0x00000000)</b>. If the function fails, the
///    return value is one of the following error codes from ntstatus.h. <table> <tr> <th>Return code/value</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>STATUS_ACCESS_DENIED</b></dt> <dt>0xC0000022</dt>
///    </dl> </td> <td width="60%"> The calling application does not have the appropriate privilege to complete the
///    operation. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>STATUS_INVALID_HANDLE</b></dt> <dt>0xC0000008</dt> </dl>
///    </td> <td width="60%"> The specified server or user name was not valid. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>STATUS_ILL_FORMED_PASSWORD</b></dt> <dt>0xC000006B</dt> </dl> </td> <td width="60%"> New password is
///    poorly formed, for example, it contains characters that cannot be entered from the keyboard. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>STATUS_PASSWORD_RESTRICTION</b></dt> <dt>0xC000006C</dt> </dl> </td> <td width="60%"> A
///    restriction prevents the password from being changed. Possible restrictions include time restrictions on how
///    often a password is allowed to be changed or length restrictions on the provided password. This error is also
///    returned if the new password matched a password in the recent history log for the account. Security
///    administrators specify how many of the most recently used passwords are not available for re-use. These are kept
///    in the password recent history log. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>STATUS_WRONG_PASSWORD</b></dt>
///    <dt>0xC000006A</dt> </dl> </td> <td width="60%"> The old password parameter does not match the user's current
///    password. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>STATUS_INVALID_DOMAIN_STATE</b></dt> <dt>0xC00000DD</dt>
///    </dl> </td> <td width="60%"> The domain controlelr is not in an enabled state. The domain controller must be
///    enabled for this operation. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>STATUS_INVALID_DOMAIN_ROLE</b></dt>
///    <dt>0xC00000DE</dt> </dl> </td> <td width="60%"> The domain controller is serving in the incorrect role to
///    perform the requested operation. The operation can only be performed by the primary domain controller. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>STATUS_INVALID_PARAMETER_MIX</b></dt> <dt>0xC0000030</dt> </dl> </td> <td
///    width="60%"> The value of the <i>LmOldPresent</i> parameter is not correct for the contents of the old and new
///    parameter pairs. </td> </tr> </table>
///    
@DllImport("ADVAPI32")
uint MSChapSrvChangePassword(PWSTR ServerName, PWSTR UserName, ubyte LmOldPresent, 
                             LM_OWF_PASSWORD* LmOldOwfPassword, LM_OWF_PASSWORD* LmNewOwfPassword, 
                             LM_OWF_PASSWORD* NtOldOwfPassword, LM_OWF_PASSWORD* NtNewOwfPassword);

///The <b>MSChapSrvChangePassword2</b> function changes the password of a user account while supporting mutual
///encryption.
///Params:
///    ServerName = A pointer to a null-terminated Unicode string that specifies the Universal Naming Convention (UNC) name of the
///                 server on which to operate. If this parameter is <b>NULL</b>, the function operates on the local computer.
///    UserName = A pointer to a null-terminated Unicode string that specifies the name of the user whose password is being
///               changed.
///    NewPasswordEncryptedWithOldNt = A pointer to a SAMPR_ENCRYPTED_USER_PASSWORD structure that contains the new clear text password encrypted using
///                                    the current NT one-way function (OWF) password hash as the encryption key. <div class="alert"><b>Note</b> Use the
///                                    <b>NewPasswordEncryptedWithOldNtPasswordHash()</b> function as defined in RFC 2433, section A.11 to calculate the
///                                    cipher for <i>NewPasswordEncryptedWithOldNt</i>.</div> <div> </div>
///    OldNtOwfPasswordEncryptedWithNewNt = A pointer to an ENCRYPTED_NT_OWF_PASSWORD structure that contains the old NT OWF password hash encrypted using
///                                         the new NT OWF password hash as the encryption key.
///    LmPresent = A <b>BOOLEAN</b> that specifies if the current Lan Manager (LM) or NT OWF password hashes are used as the
///                encryption keys to generate the <i>NewPasswordEncryptedWithOldNt</i> and
///                <i>OldNtOwfPasswordEncryptedWithNewNt</i> ciphers. If <b>TRUE</b>, the LM OWF password hashes are used rather
///                than the NT OWF password hashes.
///    NewPasswordEncryptedWithOldLm = A pointer to a SAMPR_ENCRYPTED_USER_PASSWORD structure that contains the new clear text password encrypted using
///                                    the current LM OWF password hash. <div class="alert"><b>Note</b> Use the
///                                    <b>NewPasswordEncryptedWithOldLmPasswordHash()</b> function as defined in RFC 2433, section A.15 to calculate the
///                                    cipher for <i>NewPasswordEncryptedWithOldLm</i>.</div> <div> </div>
///    OldLmOwfPasswordEncryptedWithNewLmOrNt = A pointer to a ENCRYPTED_LM_OWF_PASSWORD structure that contains the current LM OWF password hash encrypted using
///                                             the new LM OWF password hash.
///Returns:
///    If the function succeeds, the return value is <b>STATUS_SUCCESS (0x00000000)</b>. If the function fails, the
///    return value is one of the following error codes from ntstatus.h. <table> <tr> <th>Return code/value</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>STATUS_ACCESS_DENIED</b></dt> <dt>0xC0000022</dt>
///    </dl> </td> <td width="60%"> The calling application does not have the appropriate privilege to complete the
///    operation. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>STATUS_INVALID_HANDLE</b></dt> <dt>0xC0000008</dt> </dl>
///    </td> <td width="60%"> The specified server or user name was not valid. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>STATUS_ILL_FORMED_PASSWORD</b></dt> <dt>0xC000006B</dt> </dl> </td> <td width="60%"> New password is
///    poorly formed, for example, it contains characters that cannot be entered from the keyboard. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>STATUS_PASSWORD_RESTRICTION</b></dt> <dt>0xC000006C</dt> </dl> </td> <td width="60%"> A
///    restriction prevents the password from being changed. Possible restrictions include time restrictions on how
///    often a password is allowed to be changed or length restrictions on the provided password. This error is also
///    returned if the new password matched a password in the recent history log for the account. Security
///    administrators specify how many of the most recently used passwords are not available for re-use. These are kept
///    in the password recent history log. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>STATUS_WRONG_PASSWORD</b></dt>
///    <dt>0xC000006A</dt> </dl> </td> <td width="60%"> The old password parameter does not match the user's current
///    password. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>STATUS_INVALID_DOMAIN_STATE</b></dt> <dt>0xC00000DD</dt>
///    </dl> </td> <td width="60%"> The domain controller is not in an enabled state. The domain controller must be
///    enabled for this operation. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>STATUS_INVALID_DOMAIN_ROLE</b></dt>
///    <dt>0xC00000DE</dt> </dl> </td> <td width="60%"> The domain controller is serving in the incorrect role to
///    perform the requested operation. The operation can only be performed by the primary domain controller. </td>
///    </tr> </table>
///    
@DllImport("ADVAPI32")
uint MSChapSrvChangePassword2(PWSTR ServerName, PWSTR UserName, 
                              SAMPR_ENCRYPTED_USER_PASSWORD* NewPasswordEncryptedWithOldNt, 
                              ENCRYPTED_LM_OWF_PASSWORD* OldNtOwfPasswordEncryptedWithNewNt, ubyte LmPresent, 
                              SAMPR_ENCRYPTED_USER_PASSWORD* NewPasswordEncryptedWithOldLm, 
                              ENCRYPTED_LM_OWF_PASSWORD* OldLmOwfPasswordEncryptedWithNewLmOrNt);


