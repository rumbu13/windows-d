module windows.titlecallableui;

public import windows.core;
public import windows.com : HRESULT;
public import windows.systemservices : BOOL;
public import windows.winrt : IInspectable;

extern(Windows):


// Enums


enum KnownGamingPrivileges : int
{
    XPRIVILEGE_BROADCAST                   = 0x000000be,
    XPRIVILEGE_VIEW_FRIENDS_LIST           = 0x000000c5,
    XPRIVILEGE_GAME_DVR                    = 0x000000c6,
    XPRIVILEGE_SHARE_KINECT_CONTENT        = 0x000000c7,
    XPRIVILEGE_MULTIPLAYER_PARTIES         = 0x000000cb,
    XPRIVILEGE_COMMUNICATION_VOICE_INGAME  = 0x000000cd,
    XPRIVILEGE_COMMUNICATION_VOICE_SKYPE   = 0x000000ce,
    XPRIVILEGE_CLOUD_GAMING_MANAGE_SESSION = 0x000000cf,
    XPRIVILEGE_CLOUD_GAMING_JOIN_SESSION   = 0x000000d0,
    XPRIVILEGE_CLOUD_SAVED_GAMES           = 0x000000d1,
    XPRIVILEGE_SHARE_CONTENT               = 0x000000d3,
    XPRIVILEGE_PREMIUM_CONTENT             = 0x000000d6,
    XPRIVILEGE_SUBSCRIPTION_CONTENT        = 0x000000db,
    XPRIVILEGE_SOCIAL_NETWORK_SHARING      = 0x000000dc,
    XPRIVILEGE_PREMIUM_VIDEO               = 0x000000e0,
    XPRIVILEGE_VIDEO_COMMUNICATIONS        = 0x000000eb,
    XPRIVILEGE_PURCHASE_CONTENT            = 0x000000f5,
    XPRIVILEGE_USER_CREATED_CONTENT        = 0x000000f7,
    XPRIVILEGE_PROFILE_VIEWING             = 0x000000f9,
    XPRIVILEGE_COMMUNICATIONS              = 0x000000fc,
    XPRIVILEGE_MULTIPLAYER_SESSIONS        = 0x000000fe,
    XPRIVILEGE_ADD_FRIEND                  = 0x000000ff,
}

// Callbacks

alias GameUICompletionRoutine = void function(HRESULT returnCode, void* context);
alias PlayerPickerUICompletionRoutine = void function(HRESULT returnCode, void* context, char* selectedXuids, 
                                                      size_t selectedXuidsCount);

// Functions

@DllImport("api-ms-win-gaming-tcui-l1-1-0")
HRESULT ShowGameInviteUI(ptrdiff_t serviceConfigurationId, ptrdiff_t sessionTemplateName, ptrdiff_t sessionId, 
                         ptrdiff_t invitationDisplayText, GameUICompletionRoutine completionRoutine, void* context);

@DllImport("api-ms-win-gaming-tcui-l1-1-0")
HRESULT ShowPlayerPickerUI(ptrdiff_t promptDisplayText, char* xuids, size_t xuidsCount, char* preSelectedXuids, 
                           size_t preSelectedXuidsCount, size_t minSelectionCount, size_t maxSelectionCount, 
                           PlayerPickerUICompletionRoutine completionRoutine, void* context);

@DllImport("api-ms-win-gaming-tcui-l1-1-0")
HRESULT ShowProfileCardUI(ptrdiff_t targetUserXuid, GameUICompletionRoutine completionRoutine, void* context);

@DllImport("api-ms-win-gaming-tcui-l1-1-0")
HRESULT ShowChangeFriendRelationshipUI(ptrdiff_t targetUserXuid, GameUICompletionRoutine completionRoutine, 
                                       void* context);

@DllImport("api-ms-win-gaming-tcui-l1-1-0")
HRESULT ShowTitleAchievementsUI(uint titleId, GameUICompletionRoutine completionRoutine, void* context);

@DllImport("api-ms-win-gaming-tcui-l1-1-0")
HRESULT ProcessPendingGameUI(BOOL waitForCompletion);

@DllImport("api-ms-win-gaming-tcui-l1-1-0")
BOOL TryCancelPendingGameUI();

@DllImport("api-ms-win-gaming-tcui-l1-1-1")
HRESULT CheckGamingPrivilegeWithUI(uint privilegeId, ptrdiff_t scope_, ptrdiff_t policy, ptrdiff_t friendlyMessage, 
                                   GameUICompletionRoutine completionRoutine, void* context);

@DllImport("api-ms-win-gaming-tcui-l1-1-1")
HRESULT CheckGamingPrivilegeSilently(uint privilegeId, ptrdiff_t scope_, ptrdiff_t policy, int* hasPrivilege);

@DllImport("api-ms-win-gaming-tcui-l1-1-2")
HRESULT ShowGameInviteUIForUser(IInspectable user, ptrdiff_t serviceConfigurationId, ptrdiff_t sessionTemplateName, 
                                ptrdiff_t sessionId, ptrdiff_t invitationDisplayText, 
                                GameUICompletionRoutine completionRoutine, void* context);

@DllImport("api-ms-win-gaming-tcui-l1-1-2")
HRESULT ShowPlayerPickerUIForUser(IInspectable user, ptrdiff_t promptDisplayText, char* xuids, size_t xuidsCount, 
                                  char* preSelectedXuids, size_t preSelectedXuidsCount, size_t minSelectionCount, 
                                  size_t maxSelectionCount, PlayerPickerUICompletionRoutine completionRoutine, 
                                  void* context);

@DllImport("api-ms-win-gaming-tcui-l1-1-2")
HRESULT ShowProfileCardUIForUser(IInspectable user, ptrdiff_t targetUserXuid, 
                                 GameUICompletionRoutine completionRoutine, void* context);

@DllImport("api-ms-win-gaming-tcui-l1-1-2")
HRESULT ShowChangeFriendRelationshipUIForUser(IInspectable user, ptrdiff_t targetUserXuid, 
                                              GameUICompletionRoutine completionRoutine, void* context);

@DllImport("api-ms-win-gaming-tcui-l1-1-2")
HRESULT ShowTitleAchievementsUIForUser(IInspectable user, uint titleId, GameUICompletionRoutine completionRoutine, 
                                       void* context);

@DllImport("api-ms-win-gaming-tcui-l1-1-2")
HRESULT CheckGamingPrivilegeWithUIForUser(IInspectable user, uint privilegeId, ptrdiff_t scope_, ptrdiff_t policy, 
                                          ptrdiff_t friendlyMessage, GameUICompletionRoutine completionRoutine, 
                                          void* context);

@DllImport("api-ms-win-gaming-tcui-l1-1-2")
HRESULT CheckGamingPrivilegeSilentlyForUser(IInspectable user, uint privilegeId, ptrdiff_t scope_, 
                                            ptrdiff_t policy, int* hasPrivilege);

@DllImport("api-ms-win-gaming-tcui-l1-1-3")
HRESULT ShowGameInviteUIWithContext(ptrdiff_t serviceConfigurationId, ptrdiff_t sessionTemplateName, 
                                    ptrdiff_t sessionId, ptrdiff_t invitationDisplayText, 
                                    ptrdiff_t customActivationContext, GameUICompletionRoutine completionRoutine, 
                                    void* context);

@DllImport("api-ms-win-gaming-tcui-l1-1-3")
HRESULT ShowGameInviteUIWithContextForUser(IInspectable user, ptrdiff_t serviceConfigurationId, 
                                           ptrdiff_t sessionTemplateName, ptrdiff_t sessionId, 
                                           ptrdiff_t invitationDisplayText, ptrdiff_t customActivationContext, 
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


