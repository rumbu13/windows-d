module windows.mapi;


extern(Windows):

struct MapiFileDesc
{
    uint ulReserved;
    uint flFlags;
    uint nPosition;
    const(char)* lpszPathName;
    const(char)* lpszFileName;
    void* lpFileType;
}

struct MapiFileDescW
{
    uint ulReserved;
    uint flFlags;
    uint nPosition;
    const(wchar)* lpszPathName;
    const(wchar)* lpszFileName;
    void* lpFileType;
}

struct MapiFileTagExt
{
    uint ulReserved;
    uint cbTag;
    ubyte* lpTag;
    uint cbEncoding;
    ubyte* lpEncoding;
}

struct MapiRecipDesc
{
    uint ulReserved;
    uint ulRecipClass;
    const(char)* lpszName;
    const(char)* lpszAddress;
    uint ulEIDSize;
    void* lpEntryID;
}

struct MapiRecipDescW
{
    uint ulReserved;
    uint ulRecipClass;
    const(wchar)* lpszName;
    const(wchar)* lpszAddress;
    uint ulEIDSize;
    void* lpEntryID;
}

struct MapiMessage
{
    uint ulReserved;
    const(char)* lpszSubject;
    const(char)* lpszNoteText;
    const(char)* lpszMessageType;
    const(char)* lpszDateReceived;
    const(char)* lpszConversationID;
    uint flFlags;
    MapiRecipDesc* lpOriginator;
    uint nRecipCount;
    MapiRecipDesc* lpRecips;
    uint nFileCount;
    MapiFileDesc* lpFiles;
}

struct MapiMessageW
{
    uint ulReserved;
    const(wchar)* lpszSubject;
    const(wchar)* lpszNoteText;
    const(wchar)* lpszMessageType;
    const(wchar)* lpszDateReceived;
    const(wchar)* lpszConversationID;
    uint flFlags;
    MapiRecipDescW* lpOriginator;
    uint nRecipCount;
    MapiRecipDescW* lpRecips;
    uint nFileCount;
    MapiFileDescW* lpFiles;
}

alias MAPILOGON = extern(Windows) uint function(uint ulUIParam, const(char)* lpszProfileName, const(char)* lpszPassword, uint flFlags, uint ulReserved, uint* lplhSession);
alias MAPILOGOFF = extern(Windows) uint function(uint lhSession, uint ulUIParam, uint flFlags, uint ulReserved);
alias MAPISENDMAIL = extern(Windows) uint function(uint lhSession, uint ulUIParam, MapiMessage* lpMessage, uint flFlags, uint ulReserved);
alias MAPISENDMAILW = extern(Windows) uint function(uint lhSession, uint ulUIParam, MapiMessageW* lpMessage, uint flFlags, uint ulReserved);
alias MAPISENDDOCUMENTS = extern(Windows) uint function(uint ulUIParam, const(char)* lpszDelimChar, const(char)* lpszFilePaths, const(char)* lpszFileNames, uint ulReserved);
alias MAPIFINDNEXT = extern(Windows) uint function(uint lhSession, uint ulUIParam, const(char)* lpszMessageType, const(char)* lpszSeedMessageID, uint flFlags, uint ulReserved, const(char)* lpszMessageID);
alias MAPIREADMAIL = extern(Windows) uint function(uint lhSession, uint ulUIParam, const(char)* lpszMessageID, uint flFlags, uint ulReserved, MapiMessage** lppMessage);
alias MAPISAVEMAIL = extern(Windows) uint function(uint lhSession, uint ulUIParam, MapiMessage* lpMessage, uint flFlags, uint ulReserved, const(char)* lpszMessageID);
alias MAPIDELETEMAIL = extern(Windows) uint function(uint lhSession, uint ulUIParam, const(char)* lpszMessageID, uint flFlags, uint ulReserved);
alias MAPIADDRESS = extern(Windows) uint function(uint lhSession, uint ulUIParam, const(char)* lpszCaption, uint nEditFields, const(char)* lpszLabels, uint nRecips, MapiRecipDesc* lpRecips, uint flFlags, uint ulReserved, uint* lpnNewRecips, MapiRecipDesc** lppNewRecips);
alias MAPIDETAILS = extern(Windows) uint function(uint lhSession, uint ulUIParam, MapiRecipDesc* lpRecip, uint flFlags, uint ulReserved);
alias MAPIRESOLVENAME = extern(Windows) uint function(uint lhSession, uint ulUIParam, const(char)* lpszName, uint flFlags, uint ulReserved, MapiRecipDesc** lppRecip);
@DllImport("MAPI32.dll")
uint MAPIFreeBuffer(void* pv);

