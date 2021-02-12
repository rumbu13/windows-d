module windows.passwordmanagement;


extern(Windows):

struct CYPHER_BLOCK
{
    byte data;
}

struct LM_OWF_PASSWORD
{
    CYPHER_BLOCK data;
}

struct SAMPR_ENCRYPTED_USER_PASSWORD
{
    ubyte Buffer;
}

struct ENCRYPTED_LM_OWF_PASSWORD
{
    CYPHER_BLOCK data;
}

@DllImport("ADVAPI32.dll")
uint MSChapSrvChangePassword(const(wchar)* ServerName, const(wchar)* UserName, ubyte LmOldPresent, LM_OWF_PASSWORD* LmOldOwfPassword, LM_OWF_PASSWORD* LmNewOwfPassword, LM_OWF_PASSWORD* NtOldOwfPassword, LM_OWF_PASSWORD* NtNewOwfPassword);

@DllImport("ADVAPI32.dll")
uint MSChapSrvChangePassword2(const(wchar)* ServerName, const(wchar)* UserName, SAMPR_ENCRYPTED_USER_PASSWORD* NewPasswordEncryptedWithOldNt, ENCRYPTED_LM_OWF_PASSWORD* OldNtOwfPasswordEncryptedWithNewNt, ubyte LmPresent, SAMPR_ENCRYPTED_USER_PASSWORD* NewPasswordEncryptedWithOldLm, ENCRYPTED_LM_OWF_PASSWORD* OldLmOwfPasswordEncryptedWithNewLmOrNt);

