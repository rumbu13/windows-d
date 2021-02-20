// Written in the D programming language.

module windows.titlecallableui;

public import windows.core;
public import windows.com : HRESULT;
public import windows.systemservices : BOOL;
public import windows.winrt : HSTRING, IInspectable;

extern(Windows) @nogc nothrow:


// Enums


///Do not use. This API is only supported for Xbox developers. To learn more about becoming a Xbox developer, see
///Developing Games for Xbox One and Windows 10.
enum KnownGamingPrivileges : int
{
    ///Do not use. This API is only supported for Xbox developers.
    XPRIVILEGE_BROADCAST                   = 0x000000be,
    ///Do not use. This API is only supported for Xbox developers.
    XPRIVILEGE_VIEW_FRIENDS_LIST           = 0x000000c5,
    ///Do not use. This API is only supported for Xbox developers.
    XPRIVILEGE_GAME_DVR                    = 0x000000c6,
    ///Do not use. This API is only supported for Xbox developers.
    XPRIVILEGE_SHARE_KINECT_CONTENT        = 0x000000c7,
    ///Do not use. This API is only supported for Xbox developers.
    XPRIVILEGE_MULTIPLAYER_PARTIES         = 0x000000cb,
    ///Do not use. This API is only supported for Xbox developers.
    XPRIVILEGE_COMMUNICATION_VOICE_INGAME  = 0x000000cd,
    ///Do not use. This API is only supported for Xbox developers.
    XPRIVILEGE_COMMUNICATION_VOICE_SKYPE   = 0x000000ce,
    ///Do not use. This API is only supported for Xbox developers.
    XPRIVILEGE_CLOUD_GAMING_MANAGE_SESSION = 0x000000cf,
    ///Do not use. This API is only supported for Xbox developers.
    XPRIVILEGE_CLOUD_GAMING_JOIN_SESSION   = 0x000000d0,
    ///Do not use. This API is only supported for Xbox developers.
    XPRIVILEGE_CLOUD_SAVED_GAMES           = 0x000000d1,
    ///Do not use. This API is only supported for Xbox developers.
    XPRIVILEGE_SHARE_CONTENT               = 0x000000d3,
    ///Do not use. This API is only supported for Xbox developers.
    XPRIVILEGE_PREMIUM_CONTENT             = 0x000000d6,
    ///Do not use. This API is only supported for Xbox developers.
    XPRIVILEGE_SUBSCRIPTION_CONTENT        = 0x000000db,
    ///Do not use. This API is only supported for Xbox developers.
    XPRIVILEGE_SOCIAL_NETWORK_SHARING      = 0x000000dc,
    ///Do not use. This API is only supported for Xbox developers.
    XPRIVILEGE_PREMIUM_VIDEO               = 0x000000e0,
    ///Do not use. This API is only supported for Xbox developers.
    XPRIVILEGE_VIDEO_COMMUNICATIONS        = 0x000000eb,
    ///Do not use. This API is only supported for Xbox developers.
    XPRIVILEGE_PURCHASE_CONTENT            = 0x000000f5,
    ///Do not use. This API is only supported for Xbox developers.
    XPRIVILEGE_USER_CREATED_CONTENT        = 0x000000f7,
    ///Do not use. This API is only supported for Xbox developers.
    XPRIVILEGE_PROFILE_VIEWING             = 0x000000f9,
    ///Do not use. This API is only supported for Xbox developers.
    XPRIVILEGE_COMMUNICATIONS              = 0x000000fc,
    ///Do not use. This API is only supported for Xbox developers.
    XPRIVILEGE_MULTIPLAYER_SESSIONS        = 0x000000fe,
    XPRIVILEGE_ADD_FRIEND                  = 0x000000ff,
}

// Callbacks

///Do not use. This API is only supported for Xbox developers. To learn more about becoming a Xbox developer, see
///Developing Games for Xbox One and Windows 10.
///Params:
///    returnCode = Type: <b>HRESULT</b> Do not use. This API is only supported for Xbox developers.
alias GameUICompletionRoutine = void function(HRESULT returnCode, void* context);
///Do not use. This API is only supported for Xbox developers. To learn more about becoming a Xbox developer, see
///Developing Games for Xbox One and Windows 10.
///Params:
///    returnCode = Type: <b>HRESULT</b> Do not use. This API is only supported for Xbox developers.
///    context = Type: <b>VOID*</b> Do not use. This API is only supported for Xbox developers.
///    selectedXuids = Type: <b>const HSTRING*</b> Do not use. This API is only supported for Xbox developers.
alias PlayerPickerUICompletionRoutine = void function(HRESULT returnCode, void* context, 
                                                      const(HSTRING)* selectedXuids, size_t selectedXuidsCount);

// Functions

///Do not use. This API is only supported for Xbox developers. To learn more about becoming a Xbox developer, see
///Developing Games for Xbox One and Windows 10.
///Params:
///    serviceConfigurationId = Type: <b>HSTRING</b> Do not use. This API is only supported for Xbox developers.
///    sessionTemplateName = Type: <b>HSTRING</b> Do not use. This API is only supported for Xbox developers.
///    sessionId = Type: <b>HSTRING</b> Do not use. This API is only supported for Xbox developers.
///    invitationDisplayText = Type: <b>HSTRING</b> Do not use. This API is only supported for Xbox developers.
///    completionRoutine = Type: <b>GameUICompletionRoutine</b> Do not use. This API is only supported for Xbox developers.
///    context = Type: <b>void*</b> Do not use. This API is only supported for Xbox developers.
@DllImport("api-ms-win-gaming-tcui-l1-1-0")
HRESULT ShowGameInviteUI(HSTRING serviceConfigurationId, HSTRING sessionTemplateName, HSTRING sessionId, 
                         HSTRING invitationDisplayText, GameUICompletionRoutine completionRoutine, void* context);

///Do not use. This API is only supported for Xbox developers. To learn more about becoming a Xbox developer, see
///Developing Games for Xbox One and Windows 10.
///Params:
///    promptDisplayText = Type: <b>HSTRING</b> Do not use. This API is only supported for Xbox developers.
///    xuids = Type: <b>const HSTRING*</b> Do not use. This API is only supported for Xbox developers.
///    xuidsCount = Type: <b>size_t</b> Do not use. This API is only supported for Xbox developers.
///    preSelectedXuids = Type: <b>const HSTRING*</b> Do not use. This API is only supported for Xbox developers.
///    preSelectedXuidsCount = Type: <b>size_t</b> Do not use. This API is only supported for Xbox developers.
///    minSelectionCount = Type: <b>size_t</b> Do not use. This API is only supported for Xbox developers.
///    maxSelectionCount = Type: <b>size_t</b> Do not use. This API is only supported for Xbox developers.
///    completionRoutine = Type: <b>PlayerPickerUICompletionRoutine</b> Do not use. This API is only supported for Xbox developers.
///    context = Type: <b>void*</b> Do not use. This API is only supported for Xbox developers.
@DllImport("api-ms-win-gaming-tcui-l1-1-0")
HRESULT ShowPlayerPickerUI(HSTRING promptDisplayText, const(HSTRING)* xuids, size_t xuidsCount, 
                           const(HSTRING)* preSelectedXuids, size_t preSelectedXuidsCount, size_t minSelectionCount, 
                           size_t maxSelectionCount, PlayerPickerUICompletionRoutine completionRoutine, 
                           void* context);

///Do not use. This API is only supported for Xbox developers. To learn more about becoming a Xbox developer, see
///Developing Games for Xbox One and Windows 10.
///Params:
///    targetUserXuid = Type: <b>HSTRING</b> Do not use. This API is only supported for Xbox developers.
///    completionRoutine = Type: <b>GameUICompletionRoutine</b> Do not use. This API is only supported for Xbox developers.
///    context = Type: <b>void*</b> Do not use. This API is only supported for Xbox developers.
@DllImport("api-ms-win-gaming-tcui-l1-1-0")
HRESULT ShowProfileCardUI(HSTRING targetUserXuid, GameUICompletionRoutine completionRoutine, void* context);

///Do not use. This API is only supported for Xbox developers. To learn more about becoming a Xbox developer, see
///Developing Games for Xbox One and Windows 10.
///Params:
///    targetUserXuid = Type: <b>HSTRING</b> Do not use. This API is only supported for Xbox developers.
///    completionRoutine = Type: <b>GameUICompletionRoutine</b> Do not use. This API is only supported for Xbox developers.
///    context = Type: <b>void*</b> Do not use. This API is only supported for Xbox developers.
@DllImport("api-ms-win-gaming-tcui-l1-1-0")
HRESULT ShowChangeFriendRelationshipUI(HSTRING targetUserXuid, GameUICompletionRoutine completionRoutine, 
                                       void* context);

///Do not use. This API is only supported for Xbox developers. To learn more about becoming a Xbox developer, see
///Developing Games for Xbox One and Windows 10.
///Params:
///    titleId = Type: <b>UINT32</b> Do not use. This API is only supported for Xbox developers.
///    completionRoutine = Type: <b>GameUICompletionRoutine</b> Do not use. This API is only supported for Xbox developers.
///    context = Type: <b>void*</b> Do not use. This API is only supported for Xbox developers.
@DllImport("api-ms-win-gaming-tcui-l1-1-0")
HRESULT ShowTitleAchievementsUI(uint titleId, GameUICompletionRoutine completionRoutine, void* context);

///Do not use. This API is only supported for Xbox developers. To learn more about becoming a Xbox developer, see
///Developing Games for Xbox One and Windows 10.
///Params:
///    waitForCompletion = Type: <b>BOOL</b> Do not use. This API is only supported for Xbox developers.
@DllImport("api-ms-win-gaming-tcui-l1-1-0")
HRESULT ProcessPendingGameUI(BOOL waitForCompletion);

///Do not use. This API is only supported for Xbox developers. To learn more about becoming a Xbox developer, see
///Developing Games for Xbox One and Windows 10.
@DllImport("api-ms-win-gaming-tcui-l1-1-0")
BOOL TryCancelPendingGameUI();

///Do not use. This API is only supported for Xbox developers. To learn more about becoming a Xbox developer, see
///Developing Games for Xbox One and Windows 10.
///Params:
///    privilegeId = Type: <b>UINT32</b> Do not use. This API is only supported for Xbox developers.
///    scope = Type: <b>HSTRING</b> Do not use. This API is only supported for Xbox developers.
///    policy = Type: <b>HSTRING</b> Do not use. This API is only supported for Xbox developers.
///    friendlyMessage = Type: <b>HSTRING</b> Do not use. This API is only supported for Xbox developers.
///    completionRoutine = Type: <b>GameUICompletionRoutine</b> Do not use. This API is only supported for Xbox developers.
///    context = Type: <b>void*</b> Do not use. This API is only supported for Xbox developers.
@DllImport("api-ms-win-gaming-tcui-l1-1-1")
HRESULT CheckGamingPrivilegeWithUI(uint privilegeId, HSTRING scope_, HSTRING policy, HSTRING friendlyMessage, 
                                   GameUICompletionRoutine completionRoutine, void* context);

///Do not use. This API is only supported for Xbox developers. To learn more about becoming a Xbox developer, see
///Developing Games for Xbox One and Windows 10.
///Params:
///    privilegeId = Type: <b>UINT32</b> Do not use. This API is only supported for Xbox developers.
///    scope = Type: <b>HSTRING</b> Do not use. This API is only supported for Xbox developers.
///    policy = Type: <b>HSTRING</b> Specifies a HSTRING that ... TBD
///    hasPrivilege = Type: <b>BOOL*</b> Do not use. This API is only supported for Xbox developers.
@DllImport("api-ms-win-gaming-tcui-l1-1-1")
HRESULT CheckGamingPrivilegeSilently(uint privilegeId, HSTRING scope_, HSTRING policy, BOOL* hasPrivilege);

@DllImport("api-ms-win-gaming-tcui-l1-1-2")
HRESULT ShowGameInviteUIForUser(IInspectable user, HSTRING serviceConfigurationId, HSTRING sessionTemplateName, 
                                HSTRING sessionId, HSTRING invitationDisplayText, 
                                GameUICompletionRoutine completionRoutine, void* context);

@DllImport("api-ms-win-gaming-tcui-l1-1-2")
HRESULT ShowPlayerPickerUIForUser(IInspectable user, HSTRING promptDisplayText, const(HSTRING)* xuids, 
                                  size_t xuidsCount, const(HSTRING)* preSelectedXuids, size_t preSelectedXuidsCount, 
                                  size_t minSelectionCount, size_t maxSelectionCount, 
                                  PlayerPickerUICompletionRoutine completionRoutine, void* context);

@DllImport("api-ms-win-gaming-tcui-l1-1-2")
HRESULT ShowProfileCardUIForUser(IInspectable user, HSTRING targetUserXuid, 
                                 GameUICompletionRoutine completionRoutine, void* context);

@DllImport("api-ms-win-gaming-tcui-l1-1-2")
HRESULT ShowChangeFriendRelationshipUIForUser(IInspectable user, HSTRING targetUserXuid, 
                                              GameUICompletionRoutine completionRoutine, void* context);

@DllImport("api-ms-win-gaming-tcui-l1-1-2")
HRESULT ShowTitleAchievementsUIForUser(IInspectable user, uint titleId, GameUICompletionRoutine completionRoutine, 
                                       void* context);

@DllImport("api-ms-win-gaming-tcui-l1-1-2")
HRESULT CheckGamingPrivilegeWithUIForUser(IInspectable user, uint privilegeId, HSTRING scope_, HSTRING policy, 
                                          HSTRING friendlyMessage, GameUICompletionRoutine completionRoutine, 
                                          void* context);

@DllImport("api-ms-win-gaming-tcui-l1-1-2")
HRESULT CheckGamingPrivilegeSilentlyForUser(IInspectable user, uint privilegeId, HSTRING scope_, HSTRING policy, 
                                            BOOL* hasPrivilege);

@DllImport("api-ms-win-gaming-tcui-l1-1-3")
HRESULT ShowGameInviteUIWithContext(HSTRING serviceConfigurationId, HSTRING sessionTemplateName, HSTRING sessionId, 
                                    HSTRING invitationDisplayText, HSTRING customActivationContext, 
                                    GameUICompletionRoutine completionRoutine, void* context);

@DllImport("api-ms-win-gaming-tcui-l1-1-3")
HRESULT ShowGameInviteUIWithContextForUser(IInspectable user, HSTRING serviceConfigurationId, 
                                           HSTRING sessionTemplateName, HSTRING sessionId, 
                                           HSTRING invitationDisplayText, HSTRING customActivationContext, 
                                           GameUICompletionRoutine completionRoutine, void* context);

@DllImport("api-ms-win-gaming-tcui-l1-1-4")
HRESULT ShowGameInfoUI(uint titleId, GameUICompletionRoutine completionRoutine, void* context);

@DllImport("api-ms-win-gaming-tcui-l1-1-4")
HRESULT ShowGameInfoUIForUser(IInspectable user, uint titleId, GameUICompletionRoutine completionRoutine, 
                              void* context);

@DllImport("api-ms-win-gaming-tcui-l1-1-4")
HRESULT ShowFindFriendsUI(GameUICompletionRoutine completionRoutine, void* context);

@DllImport("api-ms-win-gaming-tcui-l1-1-4")
HRESULT ShowFindFriendsUIForUser(IInspectable user, GameUICompletionRoutine completionRoutine, void* context);

@DllImport("api-ms-win-gaming-tcui-l1-1-4")
HRESULT ShowCustomizeUserProfileUI(GameUICompletionRoutine completionRoutine, void* context);

@DllImport("api-ms-win-gaming-tcui-l1-1-4")
HRESULT ShowCustomizeUserProfileUIForUser(IInspectable user, GameUICompletionRoutine completionRoutine, 
                                          void* context);

@DllImport("api-ms-win-gaming-tcui-l1-1-4")
HRESULT ShowUserSettingsUI(GameUICompletionRoutine completionRoutine, void* context);

@DllImport("api-ms-win-gaming-tcui-l1-1-4")
HRESULT ShowUserSettingsUIForUser(IInspectable user, GameUICompletionRoutine completionRoutine, void* context);


