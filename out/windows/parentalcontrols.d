// Written in the D programming language.

module windows.parentalcontrols;

public import windows.core;
public import windows.automation : BSTR;
public import windows.com : HRESULT, IUnknown;
public import windows.systemservices : BOOL, PWSTR;
public import windows.windowsandmessaging : HWND;
public import windows.windowsprogramming : SYSTEMTIME;

extern(Windows) @nogc nothrow:


// Enums


///Indicates information about what events are blocked from use and what controls are in place.
alias WPCFLAG_ISBLOCKED = int;
enum : int
{
    ///No events are blocked from the user.
    WPCFLAG_ISBLOCKED_NOTBLOCKED            = 0x00000000,
    ///Instant messaging is blocked from the user.
    WPCFLAG_ISBLOCKED_IMBLOCKED             = 0x00000001,
    ///Email access is blocked from the user.
    WPCFLAG_ISBLOCKED_EMAILBLOCKED          = 0x00000002,
    ///Playing of media files is blocked from the user.
    WPCFLAG_ISBLOCKED_MEDIAPLAYBACKBLOCKED  = 0x00000004,
    ///Internet access is blocked from the user.
    WPCFLAG_ISBLOCKED_WEBBLOCKED            = 0x00000008,
    ///Games are blocked from the user.
    WPCFLAG_ISBLOCKED_GAMESBLOCKED          = 0x00000010,
    ///The contacts list is blocked from the user.
    WPCFLAG_ISBLOCKED_CONTACTBLOCKED        = 0x00000020,
    ///Features are blocked from the user.
    WPCFLAG_ISBLOCKED_FEATUREBLOCKED        = 0x00000040,
    ///The ability to download files is blocked from the user.
    WPCFLAG_ISBLOCKED_DOWNLOADBLOCKED       = 0x00000080,
    ///Content with a specified rating is blocked from the user.
    WPCFLAG_ISBLOCKED_RATINGBLOCKED         = 0x00000100,
    ///The description of the content is blocked from the user.
    WPCFLAG_ISBLOCKED_DESCRIPTORBLOCKED     = 0x00000200,
    ///Explicit content is blocked from the user.
    WPCFLAG_ISBLOCKED_EXPLICITBLOCK         = 0x00000400,
    ///The user has entered a password that is not valid.
    WPCFLAG_ISBLOCKED_BADPASS               = 0x00000800,
    ///The user has reached the maximum number of hours allowed for computer access.
    WPCFLAG_ISBLOCKED_MAXHOURS              = 0x00001000,
    ///The user is blocked from computer access because the time is outside of the specified hours allowed for this
    ///user.
    WPCFLAG_ISBLOCKED_SPECHOURS             = 0x00002000,
    ///The user is blocked from changing any computer settings.
    WPCFLAG_ISBLOCKED_SETTINGSCHANGEBLOCKED = 0x00004000,
    ///An attachment is blocked from the user.
    WPCFLAG_ISBLOCKED_ATTACHMENTBLOCKED     = 0x00008000,
    ///The user is blocked from sending any information to the specified account.
    WPCFLAG_ISBLOCKED_SENDERBLOCKED         = 0x00010000,
    ///The user is blocked from receiving any information from the specified account.
    WPCFLAG_ISBLOCKED_RECEIVERBLOCKED       = 0x00020000,
    ///The user is blocked because the feature is not explicitly allowed.
    WPCFLAG_ISBLOCKED_NOTEXPLICITLYALLOWED  = 0x00040000,
    ///The user is blocked because the feature is not listed as accessible.
    WPCFLAG_ISBLOCKED_NOTINLIST             = 0x00080000,
    ///The user is blocked from accessing the entire category of activity.
    WPCFLAG_ISBLOCKED_CATEGORYBLOCKED       = 0x00100000,
    ///The user is blocked because the category is not listed as accessible.
    WPCFLAG_ISBLOCKED_CATEGORYNOTINLIST     = 0x00200000,
    ///The user is blocked because the rating specifies that the content is not suitable for children.
    WPCFLAG_ISBLOCKED_NOTKIDS               = 0x00400000,
    ///The user is blocked because the content is not rated.
    WPCFLAG_ISBLOCKED_UNRATED               = 0x00800000,
    ///The user is blocked from any access.
    WPCFLAG_ISBLOCKED_NOACCESS              = 0x01000000,
    WPCFLAG_ISBLOCKED_INTERNALERROR         = 0xffffffff,
}

///Indicates information about the type of logoff method used.
alias WPCFLAG_LOGOFF_TYPE = int;
enum : int
{
    ///The user logged off by logging off the computer.
    WPCFLAG_LOGOFF_TYPE_LOGOUT    = 0x00000000,
    ///The user logged off by restarting the computer.
    WPCFLAG_LOGOFF_TYPE_RESTART   = 0x00000001,
    ///The user logged off by shutting down the computer.
    WPCFLAG_LOGOFF_TYPE_SHUTDOWN  = 0x00000002,
    ///The user logged off by using fast user switching.
    WPCFLAG_LOGOFF_TYPE_FUS       = 0x00000004,
    WPCFLAG_LOGOFF_TYPE_FORCEDFUS = 0x00000008,
}

///Indicates information about when a participant leaves the instant messaging interaction.
alias WPCFLAG_IM_LEAVE = int;
enum : int
{
    ///An instant message participant left the interaction.
    WPCFLAG_IM_LEAVE_NORMAL           = 0x00000000,
    ///An instant message participant was forced to leave the interaction.
    WPCFLAG_IM_LEAVE_FORCED           = 0x00000001,
    WPCFLAG_IM_LEAVE_CONVERSATION_END = 0x00000002,
}

///Indicates information about the changes to settings being made by a user.
alias WPC_ARGS_SETTINGSCHANGEEVENT = int;
enum : int
{
    ///The class of change made to the setting.
    WPC_ARGS_SETTINGSCHANGEEVENT_CLASS    = 0x00000000,
    ///The setting that was changed.
    WPC_ARGS_SETTINGSCHANGEEVENT_SETTING  = 0x00000001,
    ///The user who made the change.
    WPC_ARGS_SETTINGSCHANGEEVENT_OWNER    = 0x00000002,
    ///The previous value of the setting that was changed.
    WPC_ARGS_SETTINGSCHANGEEVENT_OLDVAL   = 0x00000003,
    ///The new value of the setting that was changed.
    WPC_ARGS_SETTINGSCHANGEEVENT_NEWVAL   = 0x00000004,
    ///The reason for the changed setting.
    WPC_ARGS_SETTINGSCHANGEEVENT_REASON   = 0x00000005,
    ///Optional information about the changed setting.
    WPC_ARGS_SETTINGSCHANGEEVENT_OPTIONAL = 0x00000006,
    WPC_ARGS_SETTINGSCHANGEEVENT_CARGS    = 0x00000007,
}

///Indicates information about a safer application that is being blocked.
alias WPC_ARGS_SAFERAPPBLOCKED = int;
enum : int
{
    ///The time stamp for the blocked application.
    WPC_ARGS_SAFERAPPBLOCKED_TIMESTAMP = 0x00000000,
    ///The user identifier of the blocked application.
    WPC_ARGS_SAFERAPPBLOCKED_USERID    = 0x00000001,
    ///The location of the blocked application.
    WPC_ARGS_SAFERAPPBLOCKED_PATH      = 0x00000002,
    ///The rule identifier of the blocked application.
    WPC_ARGS_SAFERAPPBLOCKED_RULEID    = 0x00000003,
    WPC_ARGS_SAFERAPPBLOCKED_CARGS     = 0x00000004,
}

///Indicates information about an email message that has been received.
alias WPC_ARGS_EMAILRECEIEVEDEVENT = int;
enum : int
{
    ///The sender who sent the email message.
    WPC_ARGS_EMAILRECEIEVEDEVENT_SENDER         = 0x00000000,
    ///The name of the application that sent the email message.
    WPC_ARGS_EMAILRECEIEVEDEVENT_APPNAME        = 0x00000001,
    ///The version of the application that sent the email message.
    WPC_ARGS_EMAILRECEIEVEDEVENT_APPVERSION     = 0x00000002,
    ///The subject line of the email message.
    WPC_ARGS_EMAILRECEIEVEDEVENT_SUBJECT        = 0x00000003,
    ///The reason given for the email message.
    WPC_ARGS_EMAILRECEIEVEDEVENT_REASON         = 0x00000004,
    ///The number of accounts that received the email message.
    WPC_ARGS_EMAILRECEIEVEDEVENT_RECIPCOUNT     = 0x00000005,
    ///The recipient account that received the email message.
    WPC_ARGS_EMAILRECEIEVEDEVENT_RECIPIENT      = 0x00000006,
    ///The number of attachments in the email message.
    WPC_ARGS_EMAILRECEIEVEDEVENT_ATTACHCOUNT    = 0x00000007,
    ///The name of the attachment in the email message.
    WPC_ARGS_EMAILRECEIEVEDEVENT_ATTACHMENTNAME = 0x00000008,
    ///The time that the email message was received.
    WPC_ARGS_EMAILRECEIEVEDEVENT_RECEIVEDTIME   = 0x00000009,
    ///The email account that sent the email message.
    WPC_ARGS_EMAILRECEIEVEDEVENT_EMAILACCOUNT   = 0x0000000a,
    WPC_ARGS_EMAILRECEIEVEDEVENT_CARGS          = 0x0000000b,
}

///Indicates information about an email message that has been sent.
alias WPC_ARGS_EMAILSENTEVENT = int;
enum : int
{
    ///The sender who sent the email message.
    WPC_ARGS_EMAILSENTEVENT_SENDER         = 0x00000000,
    ///The name of the application that sent the email message.
    WPC_ARGS_EMAILSENTEVENT_APPNAME        = 0x00000001,
    ///The version of the application that sent the email message.
    WPC_ARGS_EMAILSENTEVENT_APPVERSION     = 0x00000002,
    ///The subject of the email message.
    WPC_ARGS_EMAILSENTEVENT_SUBJECT        = 0x00000003,
    ///The reason for the email message.
    WPC_ARGS_EMAILSENTEVENT_REASON         = 0x00000004,
    ///The number of accounts that received the email message.
    WPC_ARGS_EMAILSENTEVENT_RECIPCOUNT     = 0x00000005,
    ///The recipient account that received the email message.
    WPC_ARGS_EMAILSENTEVENT_RECIPIENT      = 0x00000006,
    ///The number of attachments in the email message.
    WPC_ARGS_EMAILSENTEVENT_ATTACHCOUNT    = 0x00000007,
    ///The name of the attachment in the email message.
    WPC_ARGS_EMAILSENTEVENT_ATTACHMENTNAME = 0x00000008,
    ///The email account that sent the email message.
    WPC_ARGS_EMAILSENTEVENT_EMAILACCOUNT   = 0x00000009,
    WPC_ARGS_EMAILSENTEVENT_CARGS          = 0x0000000a,
}

///Indicates information about contacting someone by using email.
alias WPC_ARGS_EMAILCONTACTEVENT = int;
enum : int
{
    ///The name of the application used for the email contact.
    WPC_ARGS_EMAILCONTACTEVENT_APPNAME      = 0x00000000,
    ///The version of the application used for the email contact.
    WPC_ARGS_EMAILCONTACTEVENT_APPVERSION   = 0x00000001,
    ///The previous name of the email contact.
    WPC_ARGS_EMAILCONTACTEVENT_OLDNAME      = 0x00000002,
    ///The previous ID of the email contact.
    WPC_ARGS_EMAILCONTACTEVENT_OLDID        = 0x00000003,
    ///The new name of the email contact.
    WPC_ARGS_EMAILCONTACTEVENT_NEWNAME      = 0x00000004,
    ///The new ID of the email contact.
    WPC_ARGS_EMAILCONTACTEVENT_NEWID        = 0x00000005,
    ///The reason given for the email contact.
    WPC_ARGS_EMAILCONTACTEVENT_REASON       = 0x00000006,
    ///The email account used for the email contact.
    WPC_ARGS_EMAILCONTACTEVENT_EMAILACCOUNT = 0x00000007,
    WPC_ARGS_EMAILCONTACTEVENT_CARGS        = 0x00000008,
}

///Indicates information about the type of media file accessed.
alias WPC_MEDIA_TYPE = int;
enum : int
{
    ///The type of media file accessed is not one of the types available.
    WPC_MEDIA_TYPE_OTHER        = 0x00000000,
    ///The type of media file accessed is a DVD.
    WPC_MEDIA_TYPE_DVD          = 0x00000001,
    ///The type of media file accessed is recorded television.
    WPC_MEDIA_TYPE_RECORDED_TV  = 0x00000002,
    ///The type of media file accessed is an audio file other than a CD audio file.
    WPC_MEDIA_TYPE_AUDIO_FILE   = 0x00000003,
    ///The type of media file accessed is a CD audio file.
    WPC_MEDIA_TYPE_CD_AUDIO     = 0x00000004,
    ///The type of media file accessed is a video file.
    WPC_MEDIA_TYPE_VIDEO_FILE   = 0x00000005,
    ///The type of media file accessed is a picture file.
    WPC_MEDIA_TYPE_PICTURE_FILE = 0x00000006,
    WPC_MEDIA_TYPE_MAX          = 0x00000007,
}

///Indicates information about the explicit rating of the media file.
alias WPC_MEDIA_EXPLICIT = int;
enum : int
{
    ///The media file is not rated as explicit.
    WPC_MEDIA_EXPLICIT_FALSE   = 0x00000000,
    ///The media file is rated as explicit.
    WPC_MEDIA_EXPLICIT_TRUE    = 0x00000001,
    WPC_MEDIA_EXPLICIT_UNKNOWN = 0x00000002,
}

///Indicates information about the playback of a media file.
alias WPC_ARGS_MEDIAPLAYBACKEVENT = int;
enum : int
{
    ///The name of the application used to play back a media file.
    WPC_ARGS_MEDIAPLAYBACKEVENT_APPNAME    = 0x00000000,
    ///The version of the application used to play back a media file.
    WPC_ARGS_MEDIAPLAYBACKEVENT_APPVERSION = 0x00000001,
    ///The type of media file that was played.
    WPC_ARGS_MEDIAPLAYBACKEVENT_MEDIATYPE  = 0x00000002,
    ///The path used to play back a media file.
    WPC_ARGS_MEDIAPLAYBACKEVENT_PATH       = 0x00000003,
    ///The title of the media file that was played.
    WPC_ARGS_MEDIAPLAYBACKEVENT_TITLE      = 0x00000004,
    ///The parental managements level of the media file that was played.
    WPC_ARGS_MEDIAPLAYBACKEVENT_PML        = 0x00000005,
    ///The album of the media file that was played.
    WPC_ARGS_MEDIAPLAYBACKEVENT_ALBUM      = 0x00000006,
    ///The explicit rating of the media file that was played.
    WPC_ARGS_MEDIAPLAYBACKEVENT_EXPLICIT   = 0x00000007,
    ///The reason for playing a media file.
    WPC_ARGS_MEDIAPLAYBACKEVENT_REASON     = 0x00000008,
    WPC_ARGS_MEDIAPLAYBACKEVENT_CARGS      = 0x00000009,
}

///Indicates information about the download of a media file.
alias WPC_ARGS_MEDIADOWNLOADEVENT = int;
enum : int
{
    ///The name of the application used to download the media file.
    WPC_ARGS_MEDIADOWNLOADEVENT_APPNAME    = 0x00000000,
    ///The version of the application used to download the media file.
    WPC_ARGS_MEDIADOWNLOADEVENT_APPVERSION = 0x00000001,
    ///The type of media file downloaded.
    WPC_ARGS_MEDIADOWNLOADEVENT_MEDIATYPE  = 0x00000002,
    ///The path used to download the media file.
    WPC_ARGS_MEDIADOWNLOADEVENT_PATH       = 0x00000003,
    ///The title of the downloaded media file.
    WPC_ARGS_MEDIADOWNLOADEVENT_TITLE      = 0x00000004,
    ///The parental management level (PML) of the downloaded media file.
    WPC_ARGS_MEDIADOWNLOADEVENT_PML        = 0x00000005,
    ///The album information of the downloaded media file.
    WPC_ARGS_MEDIADOWNLOADEVENT_ALBUM      = 0x00000006,
    ///The explicit rating of the downloaded media file.
    WPC_ARGS_MEDIADOWNLOADEVENT_EXPLICIT   = 0x00000007,
    ///The reason used to download the media file.
    WPC_ARGS_MEDIADOWNLOADEVENT_REASON     = 0x00000008,
    WPC_ARGS_MEDIADOWNLOADEVENT_CARGS      = 0x00000009,
}

///Indicates information about initiating a conversation.
alias WPC_ARGS_CONVERSATIONINITEVENT = int;
enum : int
{
    ///The name of the application used for starting the conversation.
    WPC_ARGS_CONVERSATIONINITEVENT_APPNAME      = 0x00000000,
    ///The version of the application used for starting the conversation.
    WPC_ARGS_CONVERSATIONINITEVENT_APPVERSION   = 0x00000001,
    ///The account name used for starting the conversation.
    WPC_ARGS_CONVERSATIONINITEVENT_ACCOUNTNAME  = 0x00000002,
    ///The conversation identifier used for starting the conversation.
    WPC_ARGS_CONVERSATIONINITEVENT_CONVID       = 0x00000003,
    ///The IP address of the computer starting the conversation.
    WPC_ARGS_CONVERSATIONINITEVENT_REQUESTINGIP = 0x00000004,
    ///The sender who is starting the conversation.
    WPC_ARGS_CONVERSATIONINITEVENT_SENDER       = 0x00000005,
    ///The reason given for starting the conversation.
    WPC_ARGS_CONVERSATIONINITEVENT_REASON       = 0x00000006,
    ///The number of recipients included in starting the conversation.
    WPC_ARGS_CONVERSATIONINITEVENT_RECIPCOUNT   = 0x00000007,
    ///The recipient of the started conversation.
    WPC_ARGS_CONVERSATIONINITEVENT_RECIPIENT    = 0x00000008,
    WPC_ARGS_CONVERSATIONINITEVENT_CARGS        = 0x00000009,
}

///Indicates information about joining an existing conversation.
alias WPC_ARGS_CONVERSATIONJOINEVENT = int;
enum : int
{
    ///The name of the application used for joining an existing conversation.
    WPC_ARGS_CONVERSATIONJOINEVENT_APPNAME     = 0x00000000,
    ///The version of the application used for joining an existing conversation.
    WPC_ARGS_CONVERSATIONJOINEVENT_APPVERSION  = 0x00000001,
    ///The account name used for joining an existing conversation.
    WPC_ARGS_CONVERSATIONJOINEVENT_ACCOUNTNAME = 0x00000002,
    ///The conversation identifier used for joining an existing conversation.
    WPC_ARGS_CONVERSATIONJOINEVENT_CONVID      = 0x00000003,
    ///The IP address of the computer joining an existing conversation.
    WPC_ARGS_CONVERSATIONJOINEVENT_JOININGIP   = 0x00000004,
    ///The user name for the user who joined an existing conversation.
    WPC_ARGS_CONVERSATIONJOINEVENT_JOININGUSER = 0x00000005,
    ///The reason given for joining an existing conversation.
    WPC_ARGS_CONVERSATIONJOINEVENT_REASON      = 0x00000006,
    ///The number of members in the existing conversation.
    WPC_ARGS_CONVERSATIONJOINEVENT_MEMBERCOUNT = 0x00000007,
    ///The member of the existing conversation.
    WPC_ARGS_CONVERSATIONJOINEVENT_MEMBER      = 0x00000008,
    ///The sender who invited others to join an existing conversation.
    WPC_ARGS_CONVERSATIONJOINEVENT_SENDER      = 0x00000009,
    WPC_ARGS_CONVERSATIONJOINEVENT_CARGS       = 0x0000000a,
}

///Indicates information about leaving a conversation.
alias WPC_ARGS_CONVERSATIONLEAVEEVENT = int;
enum : int
{
    ///The name of the application used for leaving the conversation.
    WPC_ARGS_CONVERSATIONLEAVEEVENT_APPNAME     = 0x00000000,
    ///The version of the application used for leaving the conversation.
    WPC_ARGS_CONVERSATIONLEAVEEVENT_APPVERSION  = 0x00000001,
    ///The account name used for leaving the conversation.
    WPC_ARGS_CONVERSATIONLEAVEEVENT_ACCOUNTNAME = 0x00000002,
    ///The conversation identifier used for leaving the conversation.
    WPC_ARGS_CONVERSATIONLEAVEEVENT_CONVID      = 0x00000003,
    ///The IP address of the computer leaving the conversation.
    WPC_ARGS_CONVERSATIONLEAVEEVENT_LEAVINGIP   = 0x00000004,
    ///The user who is leaving the conversation.
    WPC_ARGS_CONVERSATIONLEAVEEVENT_LEAVINGUSER = 0x00000005,
    ///The reason given for leaving the conversation.
    WPC_ARGS_CONVERSATIONLEAVEEVENT_REASON      = 0x00000006,
    ///The number of members left in the conversation.
    WPC_ARGS_CONVERSATIONLEAVEEVENT_MEMBERCOUNT = 0x00000007,
    ///The member who is leaving the conversation.
    WPC_ARGS_CONVERSATIONLEAVEEVENT_MEMBER      = 0x00000008,
    ///The flags used for leaving the conversation.
    WPC_ARGS_CONVERSATIONLEAVEEVENT_FLAGS       = 0x00000009,
    WPC_ARGS_CONVERSATIONLEAVEEVENT_CARGS       = 0x0000000a,
}

///Indicates information about the features accessed during an instant messaging interaction.
alias WPCFLAG_IM_FEATURE = int;
enum : int
{
    ///No instant messaging features were used.
    WPCFLAG_IM_FEATURE_NONE     = 0x00000000,
    ///The video feature was used during the instant messaging session.
    WPCFLAG_IM_FEATURE_VIDEO    = 0x00000001,
    ///The audio feature was used during the instant messaging session.
    WPCFLAG_IM_FEATURE_AUDIO    = 0x00000002,
    ///The game feature was used during the instant messaging session.
    WPCFLAG_IM_FEATURE_GAME     = 0x00000004,
    ///The short message service feature was used during the instant messaging session.
    WPCFLAG_IM_FEATURE_SMS      = 0x00000008,
    ///Files were swapped during the instant messaging session.
    WPCFLAG_IM_FEATURE_FILESWAP = 0x00000010,
    ///URL or website locations were swapped during the instant messaging session.
    WPCFLAG_IM_FEATURE_URLSWAP  = 0x00000020,
    ///The top bit means sending or receiving.
    WPCFLAG_IM_FEATURE_SENDING  = 0x80000000,
    WPCFLAG_IM_FEATURE_ALL      = 0xffffffff,
}

///Indicates information about the features of the instant messaging interaction.
alias WPC_ARGS_IMFEATUREEVENT = int;
enum : int
{
    ///The name of the application used for the instant messaging interaction.
    WPC_ARGS_IMFEATUREEVENT_APPNAME     = 0x00000000,
    ///The version of the application used for the instant messaging interaction.
    WPC_ARGS_IMFEATUREEVENT_APPVERSION  = 0x00000001,
    ///The account name used for the instant messaging interaction.
    WPC_ARGS_IMFEATUREEVENT_ACCOUNTNAME = 0x00000002,
    ///The conversation ID used for the instant messaging interaction.
    WPC_ARGS_IMFEATUREEVENT_CONVID      = 0x00000003,
    ///The media type used for the instant messaging interaction.
    WPC_ARGS_IMFEATUREEVENT_MEDIATYPE   = 0x00000004,
    ///The reason used for the instant messaging interaction.
    WPC_ARGS_IMFEATUREEVENT_REASON      = 0x00000005,
    ///The number of recipients in the instant messaging interaction.
    WPC_ARGS_IMFEATUREEVENT_RECIPCOUNT  = 0x00000006,
    ///The recipient of the instant messaging interaction.
    WPC_ARGS_IMFEATUREEVENT_RECIPIENT   = 0x00000007,
    ///The sender of the instant messaging interaction.
    WPC_ARGS_IMFEATUREEVENT_SENDER      = 0x00000008,
    ///The IP address of the sender of the instant messaging interaction.
    WPC_ARGS_IMFEATUREEVENT_SENDERIP    = 0x00000009,
    ///The data used for the instant messaging interaction.
    WPC_ARGS_IMFEATUREEVENT_DATA        = 0x0000000a,
    WPC_ARGS_IMFEATUREEVENT_CARGS       = 0x0000000b,
}

///Indicates information about contacting someone by using an instant messaging application.
alias WPC_ARGS_IMCONTACTEVENT = int;
enum : int
{
    ///The name of the application used for the instant message.
    WPC_ARGS_IMCONTACTEVENT_APPNAME     = 0x00000000,
    ///The version of the application used for the instant message.
    WPC_ARGS_IMCONTACTEVENT_APPVERSION  = 0x00000001,
    ///The account name used for the instant message.
    WPC_ARGS_IMCONTACTEVENT_ACCOUNTNAME = 0x00000002,
    ///The previous name of the contact used for the instant message.
    WPC_ARGS_IMCONTACTEVENT_OLDNAME     = 0x00000003,
    ///The previous ID of the contact used for the instant message.
    WPC_ARGS_IMCONTACTEVENT_OLDID       = 0x00000004,
    ///The new name of the contact used for the instant message.
    WPC_ARGS_IMCONTACTEVENT_NEWNAME     = 0x00000005,
    ///The new ID of the contact used for the instant message.
    WPC_ARGS_IMCONTACTEVENT_NEWID       = 0x00000006,
    ///The reason used for the instant message.
    WPC_ARGS_IMCONTACTEVENT_REASON      = 0x00000007,
    WPC_ARGS_IMCONTACTEVENT_CARGS       = 0x00000008,
}

///Indicates information about the start of a computer game.
alias WPC_ARGS_GAMESTARTEVENT = int;
enum : int
{
    ///The application identifier of the computer game.
    WPC_ARGS_GAMESTARTEVENT_APPID        = 0x00000000,
    ///The instance identifier of the computer game.
    WPC_ARGS_GAMESTARTEVENT_INSTANCEID   = 0x00000001,
    ///The version of the computer game.
    WPC_ARGS_GAMESTARTEVENT_APPVERSION   = 0x00000002,
    ///The path of the computer game.
    WPC_ARGS_GAMESTARTEVENT_PATH         = 0x00000003,
    ///The rating of the computer game.
    WPC_ARGS_GAMESTARTEVENT_RATING       = 0x00000004,
    ///The rating system used to rate the computer game.
    WPC_ARGS_GAMESTARTEVENT_RATINGSYSTEM = 0x00000005,
    ///The reason for starting the computer game.
    WPC_ARGS_GAMESTARTEVENT_REASON       = 0x00000006,
    ///The number of descriptors of the computer game.
    WPC_ARGS_GAMESTARTEVENT_DESCCOUNT    = 0x00000007,
    ///The descriptor of the computer game.
    WPC_ARGS_GAMESTARTEVENT_DESCRIPTOR   = 0x00000008,
    ///The product identifier of the computer game.
    WPC_ARGS_GAMESTARTEVENT_PID          = 0x00000009,
    WPC_ARGS_GAMESTARTEVENT_CARGS        = 0x0000000a,
}

///Indicates information about a file that has been downloaded.
alias WPC_ARGS_FILEDOWNLOADEVENT = int;
enum : int
{
    ///The URL or web address of the downloaded file.
    WPC_ARGS_FILEDOWNLOADEVENT_URL     = 0x00000000,
    ///The name of the application used to download the file.
    WPC_ARGS_FILEDOWNLOADEVENT_APPNAME = 0x00000001,
    ///The version of the application used to download the file.
    WPC_ARGS_FILEDOWNLOADEVENT_VERSION = 0x00000002,
    ///The file download was blocked.
    WPC_ARGS_FILEDOWNLOADEVENT_BLOCKED = 0x00000003,
    ///The path location of the downloaded file.
    WPC_ARGS_FILEDOWNLOADEVENT_PATH    = 0x00000004,
    WPC_ARGS_FILEDOWNLOADEVENT_CARGS   = 0x00000005,
}

///Indicates information about the address URL of a website viewed.
alias WPC_ARGS_URLVISITEVENT = int;
enum : int
{
    ///The address URL of a website viewed.
    WPC_ARGS_URLVISITEVENT_URL            = 0x00000000,
    ///The name of the application used to view the website.
    WPC_ARGS_URLVISITEVENT_APPNAME        = 0x00000001,
    ///The version of the application used to view the website.
    WPC_ARGS_URLVISITEVENT_VERSION        = 0x00000002,
    ///The reason for viewing the website.
    WPC_ARGS_URLVISITEVENT_REASON         = 0x00000003,
    ///The identifier of the rating system used to view the website.
    WPC_ARGS_URLVISITEVENT_RATINGSYSTEMID = 0x00000004,
    ///The number of categories viewed on the website.
    WPC_ARGS_URLVISITEVENT_CATCOUNT       = 0x00000005,
    ///The category of the website.
    WPC_ARGS_URLVISITEVENT_CATEGORY       = 0x00000006,
    WPC_ARGS_URLVISITEVENT_CARGS          = 0x00000007,
}

alias WPC_ARGS_WEBSITEVISITEVENT = int;
enum : int
{
    WPC_ARGS_WEBSITEVISITEVENT_URL                   = 0x00000000,
    WPC_ARGS_WEBSITEVISITEVENT_DECISION              = 0x00000001,
    WPC_ARGS_WEBSITEVISITEVENT_CATEGORIES            = 0x00000002,
    WPC_ARGS_WEBSITEVISITEVENT_BLOCKEDCATEGORIES     = 0x00000003,
    WPC_ARGS_WEBSITEVISITEVENT_SERIALIZEDAPPLICATION = 0x00000004,
    WPC_ARGS_WEBSITEVISITEVENT_TITLE                 = 0x00000005,
    WPC_ARGS_WEBSITEVISITEVENT_CONTENTTYPE           = 0x00000006,
    WPC_ARGS_WEBSITEVISITEVENT_REFERRER              = 0x00000007,
    WPC_ARGS_WEBSITEVISITEVENT_TELEMETRY             = 0x00000008,
    WPC_ARGS_WEBSITEVISITEVENT_CARGS                 = 0x00000009,
}

alias WPC_ARGS_APPLICATIONEVENT = int;
enum : int
{
    WPC_ARGS_APPLICATIONEVENT_SERIALIZEDAPPLICATION = 0x00000000,
    WPC_ARGS_APPLICATIONEVENT_DECISION              = 0x00000001,
    WPC_ARGS_APPLICATIONEVENT_PROCESSID             = 0x00000002,
    WPC_ARGS_APPLICATIONEVENT_CREATIONTIME          = 0x00000003,
    WPC_ARGS_APPLICATIONEVENT_TIMEUSED              = 0x00000004,
    WPC_ARGS_APPLICATIONEVENT_CARGS                 = 0x00000005,
}

alias WPC_ARGS_COMPUTERUSAGEEVENT = int;
enum : int
{
    WPC_ARGS_COMPUTERUSAGEEVENT_ID       = 0x00000000,
    WPC_ARGS_COMPUTERUSAGEEVENT_TIMEUSED = 0x00000001,
    WPC_ARGS_COMPUTERUSAGEEVENT_CARGS    = 0x00000002,
}

alias WPC_ARGS_CONTENTUSAGEEVENT = int;
enum : int
{
    WPC_ARGS_CONTENTUSAGEEVENT_CONTENTPROVIDERID    = 0x00000000,
    WPC_ARGS_CONTENTUSAGEEVENT_CONTENTPROVIDERTITLE = 0x00000001,
    WPC_ARGS_CONTENTUSAGEEVENT_ID                   = 0x00000002,
    WPC_ARGS_CONTENTUSAGEEVENT_TITLE                = 0x00000003,
    WPC_ARGS_CONTENTUSAGEEVENT_CATEGORY             = 0x00000004,
    WPC_ARGS_CONTENTUSAGEEVENT_RATINGS              = 0x00000005,
    WPC_ARGS_CONTENTUSAGEEVENT_DECISION             = 0x00000006,
    WPC_ARGS_CONTENTUSAGEEVENT_CARGS                = 0x00000007,
}

///Indicates information about a user-defined event that is not covered by the general events.
alias WPC_ARGS_CUSTOMEVENT = int;
enum : int
{
    ///The publisher of the custom event.
    WPC_ARGS_CUSTOMEVENT_PUBLISHER  = 0x00000000,
    ///The application name of the custom event.
    WPC_ARGS_CUSTOMEVENT_APPNAME    = 0x00000001,
    ///The application version number of the custom event.
    WPC_ARGS_CUSTOMEVENT_APPVERSION = 0x00000002,
    ///The type of event.
    WPC_ARGS_CUSTOMEVENT_EVENT      = 0x00000003,
    ///The first value defined for the custom event.
    WPC_ARGS_CUSTOMEVENT_VALUE1     = 0x00000004,
    ///The second value defined for the custom event.
    WPC_ARGS_CUSTOMEVENT_VALUE2     = 0x00000005,
    ///The third value defined for the custom event.
    WPC_ARGS_CUSTOMEVENT_VALUE3     = 0x00000006,
    ///The custom event is blocked.
    WPC_ARGS_CUSTOMEVENT_BLOCKED    = 0x00000007,
    ///The reason for the custom event.
    WPC_ARGS_CUSTOMEVENT_REASON     = 0x00000008,
    WPC_ARGS_CUSTOMEVENT_CARGS      = 0x00000009,
}

alias WPC_ARGS_WEBOVERRIDEEVENT = int;
enum : int
{
    WPC_ARGS_WEBOVERRIDEEVENT_USERID = 0x00000000,
    WPC_ARGS_WEBOVERRIDEEVENT_URL    = 0x00000001,
    WPC_ARGS_WEBOVERRIDEEVENT_REASON = 0x00000002,
    WPC_ARGS_WEBOVERRIDEEVENT_CARGS  = 0x00000003,
}

alias WPC_ARGS_APPOVERRIDEEVENT = int;
enum : int
{
    WPC_ARGS_APPOVERRIDEEVENT_USERID = 0x00000000,
    WPC_ARGS_APPOVERRIDEEVENT_PATH   = 0x00000001,
    WPC_ARGS_APPOVERRIDEEVENT_REASON = 0x00000002,
    WPC_ARGS_APPOVERRIDEEVENT_CARGS  = 0x00000003,
}

alias WPC_SETTINGS = int;
enum : int
{
    WPC_SETTINGS_WPC_EXTENSION_PATH                = 0x00000000,
    WPC_SETTINGS_WPC_EXTENSION_SILO                = 0x00000001,
    WPC_SETTINGS_WPC_EXTENSION_IMAGE_PATH          = 0x00000002,
    WPC_SETTINGS_WPC_EXTENSION_DISABLEDIMAGE_PATH  = 0x00000003,
    WPC_SETTINGS_WPC_EXTENSION_NAME                = 0x00000004,
    WPC_SETTINGS_WPC_EXTENSION_SUB_TITLE           = 0x00000005,
    WPC_SETTINGS_SYSTEM_CURRENT_RATING_SYSTEM      = 0x00000006,
    WPC_SETTINGS_SYSTEM_LAST_LOG_VIEW              = 0x00000007,
    WPC_SETTINGS_SYSTEM_LOG_VIEW_REMINDER_INTERVAL = 0x00000008,
    WPC_SETTINGS_SYSTEM_HTTP_EXEMPTION_LIST        = 0x00000009,
    WPC_SETTINGS_SYSTEM_URL_EXEMPTION_LIST         = 0x0000000a,
    WPC_SETTINGS_SYSTEM_FILTER_ID                  = 0x0000000b,
    WPC_SETTINGS_SYSTEM_FILTER_NAME                = 0x0000000c,
    WPC_SETTINGS_SYSTEM_LOCALE                     = 0x0000000d,
    WPC_SETTINGS_ALLOW_BLOCK                       = 0x0000000e,
    WPC_SETTINGS_GAME_BLOCKED                      = 0x0000000f,
    WPC_SETTINGS_GAME_ALLOW_UNRATED                = 0x00000010,
    WPC_SETTINGS_GAME_MAX_ALLOWED                  = 0x00000011,
    WPC_SETTINGS_GAME_DENIED_DESCRIPTORS           = 0x00000012,
    WPC_SETTINGS_USER_WPC_ENABLED                  = 0x00000013,
    WPC_SETTINGS_USER_LOGGING_REQUIRED             = 0x00000014,
    WPC_SETTINGS_USER_HOURLY_RESTRICTIONS          = 0x00000015,
    WPC_SETTINGS_USER_OVERRRIDE_REQUESTS           = 0x00000016,
    WPC_SETTINGS_USER_LOGON_HOURS                  = 0x00000017,
    WPC_SETTINGS_USER_APP_RESTRICTIONS             = 0x00000018,
    WPC_SETTINGS_WEB_FILTER_ON                     = 0x00000019,
    WPC_SETTINGS_WEB_DOWNLOAD_BLOCKED              = 0x0000001a,
    WPC_SETTINGS_WEB_FILTER_LEVEL                  = 0x0000001b,
    WPC_SETTINGS_WEB_BLOCKED_CATEGORY_LIST         = 0x0000001c,
    WPC_SETTINGS_WEB_BLOCK_UNRATED                 = 0x0000001d,
    WPC_SETTINGS_WPC_ENABLED                       = 0x0000001e,
    WPC_SETTINGS_WPC_LOGGING_REQUIRED              = 0x0000001f,
    WPC_SETTINGS_RATING_SYSTEM_PATH                = 0x00000020,
    WPC_SETTINGS_WPC_PROVIDER_CURRENT              = 0x00000021,
    WPC_SETTINGS_USER_TIME_ALLOWANCE               = 0x00000022,
    WPC_SETTINGS_USER_TIME_ALLOWANCE_RESTRICTIONS  = 0x00000023,
    WPC_SETTINGS_GAME_RESTRICTED                   = 0x00000024,
    WPC_SETTING_COUNT                              = 0x00000025,
}

alias WPCFLAG_OVERRIDE = int;
enum : int
{
    WPCFLAG_APPLICATION = 0x00000001,
}

alias WPCFLAG_RESTRICTION = int;
enum : int
{
    WPCFLAG_NO_RESTRICTION            = 0x00000000,
    WPCFLAG_LOGGING_REQUIRED          = 0x00000001,
    WPCFLAG_WEB_FILTERED              = 0x00000002,
    WPCFLAG_HOURS_RESTRICTED          = 0x00000004,
    WPCFLAG_GAMES_BLOCKED             = 0x00000008,
    WPCFLAG_APPS_RESTRICTED           = 0x00000010,
    WPCFLAG_TIME_ALLOWANCE_RESTRICTED = 0x00000020,
    WPCFLAG_GAMES_RESTRICTED          = 0x00000040,
}

alias WPCFLAG_WEB_SETTING = int;
enum : int
{
    WPCFLAG_WEB_SETTING_NOTBLOCKED       = 0x00000000,
    WPCFLAG_WEB_SETTING_DOWNLOADSBLOCKED = 0x00000001,
}

alias WPCFLAG_VISIBILITY = int;
enum : int
{
    WPCFLAG_WPC_VISIBLE = 0x00000000,
    WPCFLAG_WPC_HIDDEN  = 0x00000001,
}

// Constants


enum GUID WPCPROV = GUID("01090065-b467-4503-9b28-533766761087");

// Interfaces

@GUID("355DFFAA-3B9F-435C-B428-5D44290BC5F2")
struct WpcSettingsProvider;

@GUID("BB18C7A0-2186-4BE0-97D8-04847B628E02")
struct WpcProviderSupport;

@GUID("E77CC89B-7401-4C04-8CED-149DB35ADD04")
struct WindowsParentalControls;

///Exposes provider state methods that are implemented by third parties.
@GUID("50B6A267-C4BD-450B-ADB5-759073837C9E")
interface IWPCProviderState : IUnknown
{
    ///Notifies the third-party application that it has been selected as the new current provider.
    ///Returns:
    ///    If the method succeeds, the function returns <b>S_OK</b>. If the method fails, it returns an <b>HRESULT</b>
    ///    value that indicates the error. For a list of common error codes, see Common HRESULT Values.
    ///    
    HRESULT Enable();
    ///Notifies the third-party application that it is not the current provider.
    ///Returns:
    ///    If the method succeeds, the function returns <b>S_OK</b>. If the method fails, it returns an <b>HRESULT</b>
    ///    value that indicates the error. For a list of common error codes, see Common HRESULT Values.
    ///    
    HRESULT Disable();
}

///Exposes configuration methods that are implemented by third parties. Parental Controls uses the CLSID from the
///provider's ConfigCLSID registry details to call CoCreateInstanceEx. The <b>CLSCTX_LOCAL_SERVER</b> flag is used when
///creating an instance of the class.
@GUID("BEF54196-2D02-4A26-B6E5-D65AF295D0F1")
interface IWPCProviderConfig : IUnknown
{
    ///Retrieves the information for each user by using the Parental Controls Control Panel. This interface is
    ///implemented by third parties.
    ///Params:
    ///    bstrSID = A string that contains the security identifier (SID) of the user whose settings you want to obtain.
    ///    pbstrUserSummary = A pointer to a string that contains the summary details for the user specified in the <i>bstrSID</i>
    ///                       parameter.
    ///Returns:
    ///    If the method succeeds, the function returns <b>S_OK</b>. If the method fails, it returns an <b>HRESULT</b>
    ///    value that indicates the error. For a list of common error codes, see Common HRESULT Values.
    ///    
    HRESULT GetUserSummary(BSTR bstrSID, BSTR* pbstrUserSummary);
    ///Called for the current provider when you click a user tile in the Parental Controls Control Panel. This method
    ///allows for changes to the configuration.
    ///Params:
    ///    hWnd = A handle to the parent window.
    ///    bstrSID = A string that contains the security identifier (SID) of the user to configure.
    ///Returns:
    ///    If the method succeeds, the method returns <b>S_OK</b>. If the method fails, it returns an <b>HRESULT</b>
    ///    value that indicates the error. Possible values include, but are not limited to, those in the following
    ///    table. For a list of common error codes, see Common HRESULT Values. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>E_NOTIMPL</b></dt> </dl> </td> <td width="60%">
    ///    Allows the provider to not handle the configuration user interface and instead to rely on the in-box Parental
    ///    Controls configuration user interface. </td> </tr> </table>
    ///    
    HRESULT Configure(HWND hWnd, BSTR bstrSID);
    ///Called for the current provider to enable configuration override.
    ///Params:
    ///    hWnd = A handle to the parent window.
    ///    bstrPath = Pointer to a string that contains the path.
    ///    dwFlags = Flags that specify the restriction. This can be one of more of the following values. <table> <tr>
    ///              <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="WPCFLAG_NO_RESTRICTION"></a><a
    ///              id="wpcflag_no_restriction"></a><dl> <dt><b>WPCFLAG_NO_RESTRICTION</b></dt> <dt>0</dt> </dl> </td> <td
    ///              width="60%"> There are no restrictions. </td> </tr> <tr> <td width="40%"><a
    ///              id="WPCFLAG_LOGGING_REQUIRED"></a><a id="wpcflag_logging_required"></a><dl>
    ///              <dt><b>WPCFLAG_LOGGING_REQUIRED</b></dt> <dt>0x1</dt> </dl> </td> <td width="60%"> Activity logging is on.
    ///              </td> </tr> <tr> <td width="40%"><a id="WPCFLAG_WEB_FILTERED"></a><a id="wpcflag_web_filtered"></a><dl>
    ///              <dt><b>WPCFLAG_WEB_FILTERED</b></dt> <dt>0x2</dt> </dl> </td> <td width="60%"> A Web Content Filter is
    ///              active. </td> </tr> <tr> <td width="40%"><a id="WPCFLAG_HOURS_RESTRICTED"></a><a
    ///              id="wpcflag_hours_restricted"></a><dl> <dt><b>WPCFLAG_HOURS_RESTRICTED</b></dt> <dt>0x4</dt> </dl> </td> <td
    ///              width="60%"> Hours are restricted. </td> </tr> <tr> <td width="40%"><a id="WPCFLAG_GAMES_BLOCKED"></a><a
    ///              id="wpcflag_games_blocked"></a><dl> <dt><b>WPCFLAG_GAMES_BLOCKED</b></dt> <dt>0x8</dt> </dl> </td> <td
    ///              width="60%"> Games are blocked. </td> </tr> <tr> <td width="40%"><a id="WPCFLAG_APPS_RESTRICTED"></a><a
    ///              id="wpcflag_apps_restricted"></a><dl> <dt><b>WPCFLAG_APPS_RESTRICTED</b></dt> <dt>0x10</dt> </dl> </td> <td
    ///              width="60%"> Applications are restricted. </td> </tr> </table>
    ///Returns:
    ///    If the method succeeds, the method returns <b>S_OK</b>. If the method fails, it returns an <b>HRESULT</b>
    ///    value that indicates the error. For a list of common error codes, see Common HRESULT Values.
    ///    
    HRESULT RequestOverride(HWND hWnd, BSTR bstrPath, uint dwFlags);
}

///Accesses general settings for the user.
@GUID("8FDF6CA1-0189-47E4-B670-1A8A4636E340")
interface IWPCSettings : IUnknown
{
    ///Determines whether activity logging should be performed when obtaining the IWPCSettings interface.
    ///Params:
    ///    pfRequired = Indicates whether logging is required.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method completed successfully.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> The
    ///    calling process has insufficient privileges. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_FILE_NOT_FOUND</b></dt> </dl> </td> <td width="60%"> The user settings were not found. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> The method failed. </td> </tr>
    ///    </table>
    ///    
    HRESULT IsLoggingRequired(BOOL* pfRequired);
    ///Retrieves the time at which the configuration settings were last updated.
    ///Params:
    ///    pTime = A pointer to a SYSTEMTIME structure that receives the time at which the settings were last updated.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method completed successfully.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_FILE_NOT_FOUND</b></dt> </dl> </td> <td width="60%"> The user
    ///    settings were not found. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td
    ///    width="60%"> The method failed. </td> </tr> </table>
    ///    
    HRESULT GetLastSettingsChangeTime(SYSTEMTIME* pTime);
    ///Determines whether web restrictions, time limits, or game restrictions are on.
    ///Params:
    ///    pdwRestrictions = Indicates the current restrictions. This parameter can be one of more of the following values. <table> <tr>
    ///                      <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="WPCFLAG_NO_RESTRICTION"></a><a
    ///                      id="wpcflag_no_restriction"></a><dl> <dt><b>WPCFLAG_NO_RESTRICTION</b></dt> <dt>0</dt> </dl> </td> <td
    ///                      width="60%"> There are no restrictions. </td> </tr> <tr> <td width="40%"><a
    ///                      id="WPCFLAG_LOGGING_REQUIRED"></a><a id="wpcflag_logging_required"></a><dl>
    ///                      <dt><b>WPCFLAG_LOGGING_REQUIRED</b></dt> <dt>0x1</dt> </dl> </td> <td width="60%"> Activity logged is on.
    ///                      </td> </tr> <tr> <td width="40%"><a id="WPCFLAG_WEB_FILTERED"></a><a id="wpcflag_web_filtered"></a><dl>
    ///                      <dt><b>WPCFLAG_WEB_FILTERED</b></dt> <dt>0x2</dt> </dl> </td> <td width="60%"> A Web Content Filter is
    ///                      active. </td> </tr> <tr> <td width="40%"><a id="WPCFLAG_HOURS_RESTRICTED"></a><a
    ///                      id="wpcflag_hours_restricted"></a><dl> <dt><b>WPCFLAG_HOURS_RESTRICTED</b></dt> <dt>0x4</dt> </dl> </td> <td
    ///                      width="60%"> Hours are restricted. </td> </tr> <tr> <td width="40%"><a id="WPCFLAG_GAMES_BLOCKED"></a><a
    ///                      id="wpcflag_games_blocked"></a><dl> <dt><b>WPCFLAG_GAMES_BLOCKED</b></dt> <dt>0x8</dt> </dl> </td> <td
    ///                      width="60%"> Games are blocked. </td> </tr> <tr> <td width="40%"><a id="WPCFLAG_APPS_RESTRICTED"></a><a
    ///                      id="wpcflag_apps_restricted"></a><dl> <dt><b>WPCFLAG_APPS_RESTRICTED</b></dt> <dt>0x10</dt> </dl> </td> <td
    ///                      width="60%"> Applications are restricted. </td> </tr> </table>
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method completed successfully.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> The
    ///    calling process has insufficient privileges. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_FILE_NOT_FOUND</b></dt> </dl> </td> <td width="60%"> The user settings were not found. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> The method failed. </td> </tr>
    ///    </table>
    ///    
    HRESULT GetRestrictions(uint* pdwRestrictions);
}

///Accesses games settings for the user.
@GUID("95E87780-E158-489E-B452-BBB850790715")
interface IWPCGamesSettings : IWPCSettings
{
    ///Determines whether the specified game is blocked from execution.
    ///Params:
    ///    guidAppID = The GUID associated with the game during install or game scan detection.
    ///    pdwReasons = The reason code. For a list of values, see the WPCFLAG_ISBLOCKED enumeration.
    ///Returns:
    ///    If the method succeeds, the return value is S_OK. Otherwise, it is E_FAIL.
    ///    
    HRESULT IsBlocked(GUID guidAppID, uint* pdwReasons);
}

///Accesses web restrictions settings for the user.
@GUID("FFCCBDB8-0992-4C30-B0F1-1CBB09C240AA")
interface IWPCWebSettings : IWPCSettings
{
    ///Retrieves the web restrictions settings.
    ///Params:
    ///    pdwSettings = The settings. This parameter can be one or more of the following values. <table> <tr> <th>Value</th>
    ///                  <th>Meaning</th> </tr> <tr> <td width="40%"><a id="WPCFLAG_WEB_SETTING_NOTBLOCKED"></a><a
    ///                  id="wpcflag_web_setting_notblocked"></a><dl> <dt><b>WPCFLAG_WEB_SETTING_NOTBLOCKED</b></dt> <dt>0</dt> </dl>
    ///                  </td> <td width="60%"> There are no restrictions. </td> </tr> <tr> <td width="40%"><a
    ///                  id="WPCFLAG_WEB_SETTING_DOWNLOADSBLOCKED"></a><a id="wpcflag_web_setting_downloadsblocked"></a><dl>
    ///                  <dt><b>WPCFLAG_WEB_SETTING_DOWNLOADSBLOCKED</b></dt> <dt>0x1</dt> </dl> </td> <td width="60%"> Downloads are
    ///                  blocked. </td> </tr> </table>
    ///Returns:
    ///    If the method succeeds, the return value is S_OK. Otherwise, it is E_FAIL.
    ///    
    HRESULT GetSettings(uint* pdwSettings);
    ///Requests that the Parental Controls web restrictions subsystem set the specified primary and sub URLs to the
    ///allowed state.
    ///Params:
    ///    hWnd = A handle to the parent window. This is needed for proper User Account Control (UAC) dialog box behavior.
    ///    pcszURL = A pointer to primary URL for override.
    ///    cURLs = The number of entries in <i>ppcszSubURLs</i>.
    ///    ppcszSubURLs = Pointers to URLs that include pages with the primary URL.
    ///    pfChanged = Pointer to flag notifying completion of override changed status. This parameter is 1 if the status is
    ///                changed, and 0 otherwise.
    ///Returns:
    ///    If the method succeeds, the return value is S_OK. Otherwise, it is E_FAIL.
    ///    
    HRESULT RequestURLOverride(HWND hWnd, const(PWSTR) pcszURL, uint cURLs, PWSTR* ppcszSubURLs, BOOL* pfChanged);
}

///The **IWindowsParentalControlsCore** interface is used to retrieve pointers for general and web restriction settings
///as well as identifiers for active Web Content Filters.
@GUID("4FF40A0F-3F3B-4D7C-A41B-4F39D7B44D05")
interface IWindowsParentalControlsCore : IUnknown
{
    ///Indicates the visibility of the Parental Controls user interface.
    ///Params:
    ///    peVisibility = Indicates whether the user interface is hidden. This parameter can be one of the following values. <table>
    ///                   <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="WPCFLAG_WPC_VISIBLE"></a><a
    ///                   id="wpcflag_wpc_visible"></a><dl> <dt><b>WPCFLAG_WPC_VISIBLE</b></dt> <dt>0</dt> </dl> </td> <td width="60%">
    ///                   The user interface is visible. </td> </tr> <tr> <td width="40%"><a id="WPCFLAG_WPC_HIDDEN"></a><a
    ///                   id="wpcflag_wpc_hidden"></a><dl> <dt><b>WPCFLAG_WPC_HIDDEN</b></dt> <dt>0x1</dt> </dl> </td> <td width="60%">
    ///                   The user interface is hidden. </td> </tr> </table>
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method completed successfully.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> A pointer
    ///    argument is <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUT_OF_MEMORY</b></dt> </dl> </td>
    ///    <td width="60%"> There is insufficient memory to complete the operation. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> The method failed. </td> </tr> </table>
    ///    
    HRESULT GetVisibility(WPCFLAG_VISIBILITY* peVisibility);
    ///Retrieves a pointer to an interface for general settings for the specified user.
    ///Params:
    ///    pcszSID = The SID string of the user. If this parameter is <b>NULL</b>, retrieve settings for the current user.
    ///    ppSettings = A pointer to an IWPCSettings interface pointer.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method completed successfully.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> A pointer
    ///    argument is <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_FILE_NOT_FOUND</b></dt> </dl> </td>
    ///    <td width="60%"> The user settings were not found. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_OUT_OF_MEMORY</b></dt> </dl> </td> <td width="60%"> There is insufficient memory to complete the
    ///    operation. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> The
    ///    method failed. </td> </tr> </table>
    ///    
    HRESULT GetUserSettings(const(PWSTR) pcszSID, IWPCSettings* ppSettings);
    ///Retrieves a pointer to an interface for web restrictions settings for the specified user.
    ///Params:
    ///    pcszSID = The SID string of the user. If this parameter is <b>NULL</b>, retrieve settings for the current user.
    ///    ppSettings = A pointer to an IWPCWebSettings interface pointer.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method completed successfully.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> A pointer
    ///    argument is <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_FILE_NOT_FOUND</b></dt> </dl> </td>
    ///    <td width="60%"> The user settings were not found. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_OUT_OF_MEMORY</b></dt> </dl> </td> <td width="60%"> There is insufficient memory to complete the
    ///    operation. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> The
    ///    method failed. </td> </tr> </table>
    ///    
    HRESULT GetWebSettings(const(PWSTR) pcszSID, IWPCWebSettings* ppSettings);
    ///Retrieves the name and identifier of the currently active Web Content Filter.
    ///Params:
    ///    pguidID = The GUID of the currently active Web Content Filter.
    ///    ppszName = The name of the currently active Web Content Filter.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method completed successfully.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> A pointer
    ///    argument is <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUT_OF_MEMORY</b></dt> </dl> </td>
    ///    <td width="60%"> There is insufficient memory to complete the operation. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> The method failed. </td> </tr> </table>
    ///    
    HRESULT GetWebFilterInfo(GUID* pguidID, PWSTR* ppszName);
}

///Enables access to all settings interfaces of the Minimum Compliance API.
@GUID("28B4D88B-E072-49E6-804D-26EDBE21A7B9")
interface IWindowsParentalControls : IWindowsParentalControlsCore
{
    ///Retrieves a pointer to an interface for games restrictions settings for the specified user.
    ///Params:
    ///    pcszSID = The SID string of the user. If this parameter is <b>NULL</b>, retrieve settings for the current user.
    ///    ppSettings = A pointer to an IWPCGamesSettings interface pointer.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method completed successfully.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> A pointer
    ///    argument is <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_FILE_NOT_FOUND</b></dt> </dl> </td>
    ///    <td width="60%"> The user settings were not found. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_OUT_OF_MEMORY</b></dt> </dl> </td> <td width="60%"> There is insufficient memory to complete the
    ///    operation. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> The
    ///    method failed. </td> </tr> </table>
    ///    
    HRESULT GetGamesSettings(const(PWSTR) pcszSID, IWPCGamesSettings* ppSettings);
}

///Exposes methods that allow third-party providers to query the currently enabled provider.
@GUID("41EBA572-23ED-4779-BEC1-8DF96206C44C")
interface IWPCProviderSupport : IUnknown
{
    ///Retrieves the GUID of the current provider.
    ///Params:
    ///    pguidProvider = The GUID of the current provider.
    ///Returns:
    ///    If the method succeeds, the method returns <b>S_OK</b>. If the method fails, it returns an <b>HRESULT</b>
    ///    value that indicates the error. Possible values include, but are not limited to, those in the following
    ///    table. For a list of common error codes, see Common HRESULT Values. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td
    ///    width="60%"> The <i>pguidProvider</i> parameter is not valid. </td> </tr> </table>
    ///    
    HRESULT GetCurrent(GUID* pguidProvider);
}


// GUIDs

const GUID CLSID_WindowsParentalControls = GUIDOF!WindowsParentalControls;
const GUID CLSID_WpcProviderSupport      = GUIDOF!WpcProviderSupport;
const GUID CLSID_WpcSettingsProvider     = GUIDOF!WpcSettingsProvider;

const GUID IID_IWPCGamesSettings            = GUIDOF!IWPCGamesSettings;
const GUID IID_IWPCProviderConfig           = GUIDOF!IWPCProviderConfig;
const GUID IID_IWPCProviderState            = GUIDOF!IWPCProviderState;
const GUID IID_IWPCProviderSupport          = GUIDOF!IWPCProviderSupport;
const GUID IID_IWPCSettings                 = GUIDOF!IWPCSettings;
const GUID IID_IWPCWebSettings              = GUIDOF!IWPCWebSettings;
const GUID IID_IWindowsParentalControls     = GUIDOF!IWindowsParentalControls;
const GUID IID_IWindowsParentalControlsCore = GUIDOF!IWindowsParentalControlsCore;
