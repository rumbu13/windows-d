module windows.titlecallableui;

public import windows.com;
public import windows.systemservices;
public import windows.winrt;

extern(Windows):

alias GameUICompletionRoutine = extern(Windows) void function(HRESULT returnCode, void* context);
alias PlayerPickerUICompletionRoutine = extern(Windows) void function(HRESULT returnCode, void* context, char* selectedXuids, uint selectedXuidsCount);
enum KnownGamingPrivileges
{
    XPRIVILEGE_BROADCAST = 190,
    XPRIVILEGE_VIEW_FRIENDS_LIST = 197,
    XPRIVILEGE_GAME_DVR = 198,
    XPRIVILEGE_SHARE_KINECT_CONTENT = 199,
    XPRIVILEGE_MULTIPLAYER_PARTIES = 203,
    XPRIVILEGE_COMMUNICATION_VOICE_INGAME = 205,
    XPRIVILEGE_COMMUNICATION_VOICE_SKYPE = 206,
    XPRIVILEGE_CLOUD_GAMING_MANAGE_SESSION = 207,
    XPRIVILEGE_CLOUD_GAMING_JOIN_SESSION = 208,
    XPRIVILEGE_CLOUD_SAVED_GAMES = 209,
    XPRIVILEGE_SHARE_CONTENT = 211,
    XPRIVILEGE_PREMIUM_CONTENT = 214,
    XPRIVILEGE_SUBSCRIPTION_CONTENT = 219,
    XPRIVILEGE_SOCIAL_NETWORK_SHARING = 220,
    XPRIVILEGE_PREMIUM_VIDEO = 224,
    XPRIVILEGE_VIDEO_COMMUNICATIONS = 235,
    XPRIVILEGE_PURCHASE_CONTENT = 245,
    XPRIVILEGE_USER_CREATED_CONTENT = 247,
    XPRIVILEGE_PROFILE_VIEWING = 249,
    XPRIVILEGE_COMMUNICATIONS = 252,
    XPRIVILEGE_MULTIPLAYER_SESSIONS = 254,
    XPRIVILEGE_ADD_FRIEND = 255,
}

@DllImport("api-ms-win-gaming-tcui-l1-1-0.dll")
HRESULT ShowGameInviteUI(int serviceConfigurationId, int sessionTemplateName, int sessionId, int invitationDisplayText, GameUICompletionRoutine completionRoutine, void* context);

@DllImport("api-ms-win-gaming-tcui-l1-1-0.dll")
HRESULT ShowPlayerPickerUI(int promptDisplayText, char* xuids, uint xuidsCount, char* preSelectedXuids, uint preSelectedXuidsCount, uint minSelectionCount, uint maxSelectionCount, PlayerPickerUICompletionRoutine completionRoutine, void* context);

@DllImport("api-ms-win-gaming-tcui-l1-1-0.dll")
HRESULT ShowProfileCardUI(int targetUserXuid, GameUICompletionRoutine completionRoutine, void* context);

@DllImport("api-ms-win-gaming-tcui-l1-1-0.dll")
HRESULT ShowChangeFriendRelationshipUI(int targetUserXuid, GameUICompletionRoutine completionRoutine, void* context);

@DllImport("api-ms-win-gaming-tcui-l1-1-0.dll")
HRESULT ShowTitleAchievementsUI(uint titleId, GameUICompletionRoutine completionRoutine, void* context);

@DllImport("api-ms-win-gaming-tcui-l1-1-0.dll")
HRESULT ProcessPendingGameUI(BOOL waitForCompletion);

@DllImport("api-ms-win-gaming-tcui-l1-1-0.dll")
BOOL TryCancelPendingGameUI();

@DllImport("api-ms-win-gaming-tcui-l1-1-1.dll")
HRESULT CheckGamingPrivilegeWithUI(uint privilegeId, int scope, int policy, int friendlyMessage, GameUICompletionRoutine completionRoutine, void* context);

@DllImport("api-ms-win-gaming-tcui-l1-1-1.dll")
HRESULT CheckGamingPrivilegeSilently(uint privilegeId, int scope, int policy, int* hasPrivilege);

@DllImport("api-ms-win-gaming-tcui-l1-1-2.dll")
HRESULT ShowGameInviteUIForUser(IInspectable user, int serviceConfigurationId, int sessionTemplateName, int sessionId, int invitationDisplayText, GameUICompletionRoutine completionRoutine, void* context);

@DllImport("api-ms-win-gaming-tcui-l1-1-2.dll")
HRESULT ShowPlayerPickerUIForUser(IInspectable user, int promptDisplayText, char* xuids, uint xuidsCount, char* preSelectedXuids, uint preSelectedXuidsCount, uint minSelectionCount, uint maxSelectionCount, PlayerPickerUICompletionRoutine completionRoutine, void* context);

@DllImport("api-ms-win-gaming-tcui-l1-1-2.dll")
HRESULT ShowProfileCardUIForUser(IInspectable user, int targetUserXuid, GameUICompletionRoutine completionRoutine, void* context);

@DllImport("api-ms-win-gaming-tcui-l1-1-2.dll")
HRESULT ShowChangeFriendRelationshipUIForUser(IInspectable user, int targetUserXuid, GameUICompletionRoutine completionRoutine, void* context);

@DllImport("api-ms-win-gaming-tcui-l1-1-2.dll")
HRESULT ShowTitleAchievementsUIForUser(IInspectable user, uint titleId, GameUICompletionRoutine completionRoutine, void* context);

@DllImport("api-ms-win-gaming-tcui-l1-1-2.dll")
HRESULT CheckGamingPrivilegeWithUIForUser(IInspectable user, uint privilegeId, int scope, int policy, int friendlyMessage, GameUICompletionRoutine completionRoutine, void* context);

@DllImport("api-ms-win-gaming-tcui-l1-1-2.dll")
HRESULT CheckGamingPrivilegeSilentlyForUser(IInspectable user, uint privilegeId, int scope, int policy, int* hasPrivilege);

@DllImport("api-ms-win-gaming-tcui-l1-1-3.dll")
HRESULT ShowGameInviteUIWithContext(int serviceConfigurationId, int sessionTemplateName, int sessionId, int invitationDisplayText, int customActivationContext, GameUICompletionRoutine completionRoutine, void* context);

@DllImport("api-ms-win-gaming-tcui-l1-1-3.dll")
HRESULT ShowGameInviteUIWithContextForUser(IInspectable user, int serviceConfigurationId, int sessionTemplateName, int sessionId, int invitationDisplayText, int customActivationContext, GameUICompletionRoutine completionRoutine, void* context);

@DllImport("api-ms-win-gaming-tcui-l1-1-4.dll")
HRESULT ShowGameInfoUI(uint titleId, GameUICompletionRoutine completionRoutine, void* context);

@DllImport("api-ms-win-gaming-tcui-l1-1-4.dll")
HRESULT ShowGameInfoUIForUser(IInspectable user, uint titleId, GameUICompletionRoutine completionRoutine, void* context);

@DllImport("api-ms-win-gaming-tcui-l1-1-4.dll")
HRESULT ShowFindFriendsUI(GameUICompletionRoutine completionRoutine, void* context);

@DllImport("api-ms-win-gaming-tcui-l1-1-4.dll")
HRESULT ShowFindFriendsUIForUser(IInspectable user, GameUICompletionRoutine completionRoutine, void* context);

@DllImport("api-ms-win-gaming-tcui-l1-1-4.dll")
HRESULT ShowCustomizeUserProfileUI(GameUICompletionRoutine completionRoutine, void* context);

@DllImport("api-ms-win-gaming-tcui-l1-1-4.dll")
HRESULT ShowCustomizeUserProfileUIForUser(IInspectable user, GameUICompletionRoutine completionRoutine, void* context);

@DllImport("api-ms-win-gaming-tcui-l1-1-4.dll")
HRESULT ShowUserSettingsUI(GameUICompletionRoutine completionRoutine, void* context);

@DllImport("api-ms-win-gaming-tcui-l1-1-4.dll")
HRESULT ShowUserSettingsUIForUser(IInspectable user, GameUICompletionRoutine completionRoutine, void* context);

