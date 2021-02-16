module windows.mapi;

public import windows.core;

extern(Windows):


// Callbacks

alias MAPILOGON = uint function(size_t ulUIParam, const(char)* lpszProfileName, const(char)* lpszPassword, 
                                uint flFlags, uint ulReserved, size_t* lplhSession);
alias MAPILOGOFF = uint function(size_t lhSession, size_t ulUIParam, uint flFlags, uint ulReserved);
alias MAPISENDMAIL = uint function(size_t lhSession, size_t ulUIParam, MapiMessage* lpMessage, uint flFlags, 
                                   uint ulReserved);
alias MAPISENDMAILW = uint function(size_t lhSession, size_t ulUIParam, MapiMessageW* lpMessage, uint flFlags, 
                                    uint ulReserved);
alias MAPISENDDOCUMENTS = uint function(size_t ulUIParam, const(char)* lpszDelimChar, const(char)* lpszFilePaths, 
                                        const(char)* lpszFileNames, uint ulReserved);
alias MAPIFINDNEXT = uint function(size_t lhSession, size_t ulUIParam, const(char)* lpszMessageType, 
                                   const(char)* lpszSeedMessageID, uint flFlags, uint ulReserved, 
                                   const(char)* lpszMessageID);
alias MAPIREADMAIL = uint function(size_t lhSession, size_t ulUIParam, const(char)* lpszMessageID, uint flFlags, 
                                   uint ulReserved, MapiMessage** lppMessage);
alias MAPISAVEMAIL = uint function(size_t lhSession, size_t ulUIParam, MapiMessage* lpMessage, uint flFlags, 
                                   uint ulReserved, const(char)* lpszMessageID);
alias MAPIDELETEMAIL = uint function(size_t lhSession, size_t ulUIParam, const(char)* lpszMessageID, uint flFlags, 
                                     uint ulReserved);
alias MAPIADDRESS = uint function(size_t lhSession, size_t ulUIParam, const(char)* lpszCaption, uint nEditFields, 
                                  const(char)* lpszLabels, uint nRecips, MapiRecipDesc* lpRecips, uint flFlags, 
                                  uint ulReserved, uint* lpnNewRecips, MapiRecipDesc** lppNewRecips);
alias MAPIDETAILS = uint function(size_t lhSession, size_t ulUIParam, MapiRecipDesc* lpRecip, uint flFlags, 
                                  uint ulReserved);
alias MAPIRESOLVENAME = uint function(size_t lhSession, size_t ulUIParam, const(char)* lpszName, uint flFlags, 
                                      uint ulReserved, MapiRecipDesc** lppRecip);

// Structs


struct MapiFileDesc
{
    uint         ulReserved;
    uint         flFlags;
    uint         nPosition;
    const(char)* lpszPathName;
    const(char)* lpszFileName;
    void*        lpFileType;
}

struct MapiFileDescW
{
    uint          ulReserved;
    uint          flFlags;
    uint          nPosition;
    const(wchar)* lpszPathName;
    const(wchar)* lpszFileName;
    void*         lpFileType;
}

struct MapiFileTagExt
{
    uint   ulReserved;
    uint   cbTag;
    ubyte* lpTag;
    uint   cbEncoding;
    ubyte* lpEncoding;
}

struct MapiRecipDesc
{
    uint         ulReserved;
    uint         ulRecipClass;
    const(char)* lpszName;
    const(char)* lpszAddress;
    uint         ulEIDSize;
    void*        lpEntryID;
}

struct MapiRecipDescW
{
    uint          ulReserved;
    uint          ulRecipClass;
    const(wchar)* lpszName;
    const(wchar)* lpszAddress;
    uint          ulEIDSize;
    void*         lpEntryID;
}

struct MapiMessage
{
    uint           ulReserved;
    const(char)*   lpszSubject;
    const(char)*   lpszNoteText;
    const(char)*   lpszMessageType;
    const(char)*   lpszDateReceived;
    const(char)*   lpszConversationID;
    uint           flFlags;
    MapiRecipDesc* lpOriginator;
    uint           nRecipCount;
    MapiRecipDesc* lpRecips;
    uint           nFileCount;
    MapiFileDesc*  lpFiles;
}

struct MapiMessageW
{
    uint            ulReserved;
    const(wchar)*   lpszSubject;
    const(wchar)*   lpszNoteText;
    const(wchar)*   lpszMessageType;
    const(wchar)*   lpszDateReceived;
    const(wchar)*   lpszConversationID;
    uint            flFlags;
    MapiRecipDescW* lpOriginator;
    uint            nRecipCount;
    MapiRecipDescW* lpRecips;
    uint            nFileCount;
    MapiFileDescW*  lpFiles;
}

// Functions

@DllImport("MAPI32")
uint MAPIFreeBuffer(void* pv);


