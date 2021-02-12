module windows.tapi;

public import system;
public import windows.automation;
public import windows.com;
public import windows.directshow;
public import windows.systemservices;
public import windows.windowsandmessaging;
public import windows.windowsprogramming;

extern(Windows):

alias LINECALLBACK = extern(Windows) void function(uint hDevice, uint dwMessage, uint dwInstance, uint dwParam1, uint dwParam2, uint dwParam3);
alias PHONECALLBACK = extern(Windows) void function(uint hDevice, uint dwMessage, uint dwInstance, uint dwParam1, uint dwParam2, uint dwParam3);
struct LINEADDRESSCAPS
{
    uint dwTotalSize;
    uint dwNeededSize;
    uint dwUsedSize;
    uint dwLineDeviceID;
    uint dwAddressSize;
    uint dwAddressOffset;
    uint dwDevSpecificSize;
    uint dwDevSpecificOffset;
    uint dwAddressSharing;
    uint dwAddressStates;
    uint dwCallInfoStates;
    uint dwCallerIDFlags;
    uint dwCalledIDFlags;
    uint dwConnectedIDFlags;
    uint dwRedirectionIDFlags;
    uint dwRedirectingIDFlags;
    uint dwCallStates;
    uint dwDialToneModes;
    uint dwBusyModes;
    uint dwSpecialInfo;
    uint dwDisconnectModes;
    uint dwMaxNumActiveCalls;
    uint dwMaxNumOnHoldCalls;
    uint dwMaxNumOnHoldPendingCalls;
    uint dwMaxNumConference;
    uint dwMaxNumTransConf;
    uint dwAddrCapFlags;
    uint dwCallFeatures;
    uint dwRemoveFromConfCaps;
    uint dwRemoveFromConfState;
    uint dwTransferModes;
    uint dwParkModes;
    uint dwForwardModes;
    uint dwMaxForwardEntries;
    uint dwMaxSpecificEntries;
    uint dwMinFwdNumRings;
    uint dwMaxFwdNumRings;
    uint dwMaxCallCompletions;
    uint dwCallCompletionConds;
    uint dwCallCompletionModes;
    uint dwNumCompletionMessages;
    uint dwCompletionMsgTextEntrySize;
    uint dwCompletionMsgTextSize;
    uint dwCompletionMsgTextOffset;
    uint dwAddressFeatures;
    uint dwPredictiveAutoTransferStates;
    uint dwNumCallTreatments;
    uint dwCallTreatmentListSize;
    uint dwCallTreatmentListOffset;
    uint dwDeviceClassesSize;
    uint dwDeviceClassesOffset;
    uint dwMaxCallDataSize;
    uint dwCallFeatures2;
    uint dwMaxNoAnswerTimeout;
    uint dwConnectedModes;
    uint dwOfferingModes;
    uint dwAvailableMediaModes;
}

struct LINEADDRESSSTATUS
{
    uint dwTotalSize;
    uint dwNeededSize;
    uint dwUsedSize;
    uint dwNumInUse;
    uint dwNumActiveCalls;
    uint dwNumOnHoldCalls;
    uint dwNumOnHoldPendCalls;
    uint dwAddressFeatures;
    uint dwNumRingsNoAnswer;
    uint dwForwardNumEntries;
    uint dwForwardSize;
    uint dwForwardOffset;
    uint dwTerminalModesSize;
    uint dwTerminalModesOffset;
    uint dwDevSpecificSize;
    uint dwDevSpecificOffset;
}

struct LINEAGENTACTIVITYENTRY
{
    uint dwID;
    uint dwNameSize;
    uint dwNameOffset;
}

struct LINEAGENTACTIVITYLIST
{
    uint dwTotalSize;
    uint dwNeededSize;
    uint dwUsedSize;
    uint dwNumEntries;
    uint dwListSize;
    uint dwListOffset;
}

struct LINEAGENTCAPS
{
    uint dwTotalSize;
    uint dwNeededSize;
    uint dwUsedSize;
    uint dwAgentHandlerInfoSize;
    uint dwAgentHandlerInfoOffset;
    uint dwCapsVersion;
    uint dwFeatures;
    uint dwStates;
    uint dwNextStates;
    uint dwMaxNumGroupEntries;
    uint dwAgentStatusMessages;
    uint dwNumAgentExtensionIDs;
    uint dwAgentExtensionIDListSize;
    uint dwAgentExtensionIDListOffset;
    Guid ProxyGUID;
}

struct LINEAGENTGROUPENTRY
{
    _GroupID_e__Struct GroupID;
    uint dwNameSize;
    uint dwNameOffset;
}

struct LINEAGENTGROUPLIST
{
    uint dwTotalSize;
    uint dwNeededSize;
    uint dwUsedSize;
    uint dwNumEntries;
    uint dwListSize;
    uint dwListOffset;
}

struct LINEAGENTSTATUS
{
    uint dwTotalSize;
    uint dwNeededSize;
    uint dwUsedSize;
    uint dwNumEntries;
    uint dwGroupListSize;
    uint dwGroupListOffset;
    uint dwState;
    uint dwNextState;
    uint dwActivityID;
    uint dwActivitySize;
    uint dwActivityOffset;
    uint dwAgentFeatures;
    uint dwValidStates;
    uint dwValidNextStates;
}

struct LINEAPPINFO
{
    uint dwMachineNameSize;
    uint dwMachineNameOffset;
    uint dwUserNameSize;
    uint dwUserNameOffset;
    uint dwModuleFilenameSize;
    uint dwModuleFilenameOffset;
    uint dwFriendlyNameSize;
    uint dwFriendlyNameOffset;
    uint dwMediaModes;
    uint dwAddressID;
}

struct LINEAGENTENTRY
{
    uint hAgent;
    uint dwNameSize;
    uint dwNameOffset;
    uint dwIDSize;
    uint dwIDOffset;
    uint dwPINSize;
    uint dwPINOffset;
}

struct LINEAGENTLIST
{
    uint dwTotalSize;
    uint dwNeededSize;
    uint dwUsedSize;
    uint dwNumEntries;
    uint dwListSize;
    uint dwListOffset;
}

struct LINEAGENTINFO
{
    uint dwTotalSize;
    uint dwNeededSize;
    uint dwUsedSize;
    uint dwAgentState;
    uint dwNextAgentState;
    uint dwMeasurementPeriod;
    CY cyOverallCallRate;
    uint dwNumberOfACDCalls;
    uint dwNumberOfIncomingCalls;
    uint dwNumberOfOutgoingCalls;
    uint dwTotalACDTalkTime;
    uint dwTotalACDCallTime;
    uint dwTotalACDWrapUpTime;
}

struct LINEAGENTSESSIONENTRY
{
    uint hAgentSession;
    uint hAgent;
    Guid GroupID;
    uint dwWorkingAddressID;
}

struct LINEAGENTSESSIONLIST
{
    uint dwTotalSize;
    uint dwNeededSize;
    uint dwUsedSize;
    uint dwNumEntries;
    uint dwListSize;
    uint dwListOffset;
}

struct LINEAGENTSESSIONINFO
{
    uint dwTotalSize;
    uint dwNeededSize;
    uint dwUsedSize;
    uint dwAgentSessionState;
    uint dwNextAgentSessionState;
    double dateSessionStartTime;
    uint dwSessionDuration;
    uint dwNumberOfCalls;
    uint dwTotalTalkTime;
    uint dwAverageTalkTime;
    uint dwTotalCallTime;
    uint dwAverageCallTime;
    uint dwTotalWrapUpTime;
    uint dwAverageWrapUpTime;
    CY cyACDCallRate;
    uint dwLongestTimeToAnswer;
    uint dwAverageTimeToAnswer;
}

struct LINEQUEUEENTRY
{
    uint dwQueueID;
    uint dwNameSize;
    uint dwNameOffset;
}

struct LINEQUEUELIST
{
    uint dwTotalSize;
    uint dwNeededSize;
    uint dwUsedSize;
    uint dwNumEntries;
    uint dwListSize;
    uint dwListOffset;
}

struct LINEQUEUEINFO
{
    uint dwTotalSize;
    uint dwNeededSize;
    uint dwUsedSize;
    uint dwMeasurementPeriod;
    uint dwTotalCallsQueued;
    uint dwCurrentCallsQueued;
    uint dwTotalCallsAbandoned;
    uint dwTotalCallsFlowedIn;
    uint dwTotalCallsFlowedOut;
    uint dwLongestEverWaitTime;
    uint dwCurrentLongestWaitTime;
    uint dwAverageWaitTime;
    uint dwFinalDisposition;
}

struct LINEPROXYREQUESTLIST
{
    uint dwTotalSize;
    uint dwNeededSize;
    uint dwUsedSize;
    uint dwNumEntries;
    uint dwListSize;
    uint dwListOffset;
}

struct LINEDIALPARAMS
{
    uint dwDialPause;
    uint dwDialSpeed;
    uint dwDigitDuration;
    uint dwWaitForDialtone;
}

struct LINECALLINFO
{
    uint dwTotalSize;
    uint dwNeededSize;
    uint dwUsedSize;
    uint hLine;
    uint dwLineDeviceID;
    uint dwAddressID;
    uint dwBearerMode;
    uint dwRate;
    uint dwMediaMode;
    uint dwAppSpecific;
    uint dwCallID;
    uint dwRelatedCallID;
    uint dwCallParamFlags;
    uint dwCallStates;
    uint dwMonitorDigitModes;
    uint dwMonitorMediaModes;
    LINEDIALPARAMS DialParams;
    uint dwOrigin;
    uint dwReason;
    uint dwCompletionID;
    uint dwNumOwners;
    uint dwNumMonitors;
    uint dwCountryCode;
    uint dwTrunk;
    uint dwCallerIDFlags;
    uint dwCallerIDSize;
    uint dwCallerIDOffset;
    uint dwCallerIDNameSize;
    uint dwCallerIDNameOffset;
    uint dwCalledIDFlags;
    uint dwCalledIDSize;
    uint dwCalledIDOffset;
    uint dwCalledIDNameSize;
    uint dwCalledIDNameOffset;
    uint dwConnectedIDFlags;
    uint dwConnectedIDSize;
    uint dwConnectedIDOffset;
    uint dwConnectedIDNameSize;
    uint dwConnectedIDNameOffset;
    uint dwRedirectionIDFlags;
    uint dwRedirectionIDSize;
    uint dwRedirectionIDOffset;
    uint dwRedirectionIDNameSize;
    uint dwRedirectionIDNameOffset;
    uint dwRedirectingIDFlags;
    uint dwRedirectingIDSize;
    uint dwRedirectingIDOffset;
    uint dwRedirectingIDNameSize;
    uint dwRedirectingIDNameOffset;
    uint dwAppNameSize;
    uint dwAppNameOffset;
    uint dwDisplayableAddressSize;
    uint dwDisplayableAddressOffset;
    uint dwCalledPartySize;
    uint dwCalledPartyOffset;
    uint dwCommentSize;
    uint dwCommentOffset;
    uint dwDisplaySize;
    uint dwDisplayOffset;
    uint dwUserUserInfoSize;
    uint dwUserUserInfoOffset;
    uint dwHighLevelCompSize;
    uint dwHighLevelCompOffset;
    uint dwLowLevelCompSize;
    uint dwLowLevelCompOffset;
    uint dwChargingInfoSize;
    uint dwChargingInfoOffset;
    uint dwTerminalModesSize;
    uint dwTerminalModesOffset;
    uint dwDevSpecificSize;
    uint dwDevSpecificOffset;
    uint dwCallTreatment;
    uint dwCallDataSize;
    uint dwCallDataOffset;
    uint dwSendingFlowspecSize;
    uint dwSendingFlowspecOffset;
    uint dwReceivingFlowspecSize;
    uint dwReceivingFlowspecOffset;
}

struct LINECALLLIST
{
    uint dwTotalSize;
    uint dwNeededSize;
    uint dwUsedSize;
    uint dwCallsNumEntries;
    uint dwCallsSize;
    uint dwCallsOffset;
}

struct LINECALLPARAMS
{
    uint dwTotalSize;
    uint dwBearerMode;
    uint dwMinRate;
    uint dwMaxRate;
    uint dwMediaMode;
    uint dwCallParamFlags;
    uint dwAddressMode;
    uint dwAddressID;
    LINEDIALPARAMS DialParams;
    uint dwOrigAddressSize;
    uint dwOrigAddressOffset;
    uint dwDisplayableAddressSize;
    uint dwDisplayableAddressOffset;
    uint dwCalledPartySize;
    uint dwCalledPartyOffset;
    uint dwCommentSize;
    uint dwCommentOffset;
    uint dwUserUserInfoSize;
    uint dwUserUserInfoOffset;
    uint dwHighLevelCompSize;
    uint dwHighLevelCompOffset;
    uint dwLowLevelCompSize;
    uint dwLowLevelCompOffset;
    uint dwDevSpecificSize;
    uint dwDevSpecificOffset;
    uint dwPredictiveAutoTransferStates;
    uint dwTargetAddressSize;
    uint dwTargetAddressOffset;
    uint dwSendingFlowspecSize;
    uint dwSendingFlowspecOffset;
    uint dwReceivingFlowspecSize;
    uint dwReceivingFlowspecOffset;
    uint dwDeviceClassSize;
    uint dwDeviceClassOffset;
    uint dwDeviceConfigSize;
    uint dwDeviceConfigOffset;
    uint dwCallDataSize;
    uint dwCallDataOffset;
    uint dwNoAnswerTimeout;
    uint dwCallingPartyIDSize;
    uint dwCallingPartyIDOffset;
}

struct LINECALLSTATUS
{
    uint dwTotalSize;
    uint dwNeededSize;
    uint dwUsedSize;
    uint dwCallState;
    uint dwCallStateMode;
    uint dwCallPrivilege;
    uint dwCallFeatures;
    uint dwDevSpecificSize;
    uint dwDevSpecificOffset;
    uint dwCallFeatures2;
    SYSTEMTIME tStateEntryTime;
}

struct LINECALLTREATMENTENTRY
{
    uint dwCallTreatmentID;
    uint dwCallTreatmentNameSize;
    uint dwCallTreatmentNameOffset;
}

struct LINECARDENTRY
{
    uint dwPermanentCardID;
    uint dwCardNameSize;
    uint dwCardNameOffset;
    uint dwCardNumberDigits;
    uint dwSameAreaRuleSize;
    uint dwSameAreaRuleOffset;
    uint dwLongDistanceRuleSize;
    uint dwLongDistanceRuleOffset;
    uint dwInternationalRuleSize;
    uint dwInternationalRuleOffset;
    uint dwOptions;
}

struct LINECOUNTRYENTRY
{
    uint dwCountryID;
    uint dwCountryCode;
    uint dwNextCountryID;
    uint dwCountryNameSize;
    uint dwCountryNameOffset;
    uint dwSameAreaRuleSize;
    uint dwSameAreaRuleOffset;
    uint dwLongDistanceRuleSize;
    uint dwLongDistanceRuleOffset;
    uint dwInternationalRuleSize;
    uint dwInternationalRuleOffset;
}

struct LINECOUNTRYLIST
{
    uint dwTotalSize;
    uint dwNeededSize;
    uint dwUsedSize;
    uint dwNumCountries;
    uint dwCountryListSize;
    uint dwCountryListOffset;
}

struct LINEDEVCAPS
{
    uint dwTotalSize;
    uint dwNeededSize;
    uint dwUsedSize;
    uint dwProviderInfoSize;
    uint dwProviderInfoOffset;
    uint dwSwitchInfoSize;
    uint dwSwitchInfoOffset;
    uint dwPermanentLineID;
    uint dwLineNameSize;
    uint dwLineNameOffset;
    uint dwStringFormat;
    uint dwAddressModes;
    uint dwNumAddresses;
    uint dwBearerModes;
    uint dwMaxRate;
    uint dwMediaModes;
    uint dwGenerateToneModes;
    uint dwGenerateToneMaxNumFreq;
    uint dwGenerateDigitModes;
    uint dwMonitorToneMaxNumFreq;
    uint dwMonitorToneMaxNumEntries;
    uint dwMonitorDigitModes;
    uint dwGatherDigitsMinTimeout;
    uint dwGatherDigitsMaxTimeout;
    uint dwMedCtlDigitMaxListSize;
    uint dwMedCtlMediaMaxListSize;
    uint dwMedCtlToneMaxListSize;
    uint dwMedCtlCallStateMaxListSize;
    uint dwDevCapFlags;
    uint dwMaxNumActiveCalls;
    uint dwAnswerMode;
    uint dwRingModes;
    uint dwLineStates;
    uint dwUUIAcceptSize;
    uint dwUUIAnswerSize;
    uint dwUUIMakeCallSize;
    uint dwUUIDropSize;
    uint dwUUISendUserUserInfoSize;
    uint dwUUICallInfoSize;
    LINEDIALPARAMS MinDialParams;
    LINEDIALPARAMS MaxDialParams;
    LINEDIALPARAMS DefaultDialParams;
    uint dwNumTerminals;
    uint dwTerminalCapsSize;
    uint dwTerminalCapsOffset;
    uint dwTerminalTextEntrySize;
    uint dwTerminalTextSize;
    uint dwTerminalTextOffset;
    uint dwDevSpecificSize;
    uint dwDevSpecificOffset;
    uint dwLineFeatures;
    uint dwSettableDevStatus;
    uint dwDeviceClassesSize;
    uint dwDeviceClassesOffset;
    Guid PermanentLineGuid;
}

struct LINEDEVSTATUS
{
    uint dwTotalSize;
    uint dwNeededSize;
    uint dwUsedSize;
    uint dwNumOpens;
    uint dwOpenMediaModes;
    uint dwNumActiveCalls;
    uint dwNumOnHoldCalls;
    uint dwNumOnHoldPendCalls;
    uint dwLineFeatures;
    uint dwNumCallCompletions;
    uint dwRingMode;
    uint dwSignalLevel;
    uint dwBatteryLevel;
    uint dwRoamMode;
    uint dwDevStatusFlags;
    uint dwTerminalModesSize;
    uint dwTerminalModesOffset;
    uint dwDevSpecificSize;
    uint dwDevSpecificOffset;
    uint dwAvailableMediaModes;
    uint dwAppInfoSize;
    uint dwAppInfoOffset;
}

struct LINEEXTENSIONID
{
    uint dwExtensionID0;
    uint dwExtensionID1;
    uint dwExtensionID2;
    uint dwExtensionID3;
}

struct LINEFORWARD
{
    uint dwForwardMode;
    uint dwCallerAddressSize;
    uint dwCallerAddressOffset;
    uint dwDestCountryCode;
    uint dwDestAddressSize;
    uint dwDestAddressOffset;
}

struct LINEFORWARDLIST
{
    uint dwTotalSize;
    uint dwNumEntries;
    LINEFORWARD ForwardList;
}

struct LINEGENERATETONE
{
    uint dwFrequency;
    uint dwCadenceOn;
    uint dwCadenceOff;
    uint dwVolume;
}

struct LINEINITIALIZEEXPARAMS
{
    uint dwTotalSize;
    uint dwNeededSize;
    uint dwUsedSize;
    uint dwOptions;
    _Handles_e__Union Handles;
    uint dwCompletionKey;
}

struct LINELOCATIONENTRY
{
    uint dwPermanentLocationID;
    uint dwLocationNameSize;
    uint dwLocationNameOffset;
    uint dwCountryCode;
    uint dwCityCodeSize;
    uint dwCityCodeOffset;
    uint dwPreferredCardID;
    uint dwLocalAccessCodeSize;
    uint dwLocalAccessCodeOffset;
    uint dwLongDistanceAccessCodeSize;
    uint dwLongDistanceAccessCodeOffset;
    uint dwTollPrefixListSize;
    uint dwTollPrefixListOffset;
    uint dwCountryID;
    uint dwOptions;
    uint dwCancelCallWaitingSize;
    uint dwCancelCallWaitingOffset;
}

struct LINEMEDIACONTROLCALLSTATE
{
    uint dwCallStates;
    uint dwMediaControl;
}

struct LINEMEDIACONTROLDIGIT
{
    uint dwDigit;
    uint dwDigitModes;
    uint dwMediaControl;
}

struct LINEMEDIACONTROLMEDIA
{
    uint dwMediaModes;
    uint dwDuration;
    uint dwMediaControl;
}

struct LINEMEDIACONTROLTONE
{
    uint dwAppSpecific;
    uint dwDuration;
    uint dwFrequency1;
    uint dwFrequency2;
    uint dwFrequency3;
    uint dwMediaControl;
}

struct LINEMESSAGE
{
    uint hDevice;
    uint dwMessageID;
    uint dwCallbackInstance;
    uint dwParam1;
    uint dwParam2;
    uint dwParam3;
}

struct LINEMONITORTONE
{
    uint dwAppSpecific;
    uint dwDuration;
    uint dwFrequency1;
    uint dwFrequency2;
    uint dwFrequency3;
}

struct LINEPROVIDERENTRY
{
    uint dwPermanentProviderID;
    uint dwProviderFilenameSize;
    uint dwProviderFilenameOffset;
}

struct LINEPROVIDERLIST
{
    uint dwTotalSize;
    uint dwNeededSize;
    uint dwUsedSize;
    uint dwNumProviders;
    uint dwProviderListSize;
    uint dwProviderListOffset;
}

struct LINEPROXYREQUEST
{
    uint dwSize;
    uint dwClientMachineNameSize;
    uint dwClientMachineNameOffset;
    uint dwClientUserNameSize;
    uint dwClientUserNameOffset;
    uint dwClientAppAPIVersion;
    uint dwRequestType;
    _Anonymous_e__Union Anonymous;
}

struct LINEREQMAKECALL
{
    byte szDestAddress;
    byte szAppName;
    byte szCalledParty;
    byte szComment;
}

struct linereqmakecallW_tag
{
    ushort szDestAddress;
    ushort szAppName;
    ushort szCalledParty;
    ushort szComment;
}

struct LINEREQMEDIACALL
{
    HWND hWnd;
    WPARAM wRequestID;
    byte szDeviceClass;
    ubyte ucDeviceID;
    uint dwSize;
    uint dwSecure;
    byte szDestAddress;
    byte szAppName;
    byte szCalledParty;
    byte szComment;
}

struct linereqmediacallW_tag
{
    HWND hWnd;
    WPARAM wRequestID;
    ushort szDeviceClass;
    ubyte ucDeviceID;
    uint dwSize;
    uint dwSecure;
    ushort szDestAddress;
    ushort szAppName;
    ushort szCalledParty;
    ushort szComment;
}

struct LINETERMCAPS
{
    uint dwTermDev;
    uint dwTermModes;
    uint dwTermSharing;
}

struct LINETRANSLATECAPS
{
    uint dwTotalSize;
    uint dwNeededSize;
    uint dwUsedSize;
    uint dwNumLocations;
    uint dwLocationListSize;
    uint dwLocationListOffset;
    uint dwCurrentLocationID;
    uint dwNumCards;
    uint dwCardListSize;
    uint dwCardListOffset;
    uint dwCurrentPreferredCardID;
}

struct LINETRANSLATEOUTPUT
{
    uint dwTotalSize;
    uint dwNeededSize;
    uint dwUsedSize;
    uint dwDialableStringSize;
    uint dwDialableStringOffset;
    uint dwDisplayableStringSize;
    uint dwDisplayableStringOffset;
    uint dwCurrentCountry;
    uint dwDestCountry;
    uint dwTranslateResults;
}

struct PHONEBUTTONINFO
{
    uint dwTotalSize;
    uint dwNeededSize;
    uint dwUsedSize;
    uint dwButtonMode;
    uint dwButtonFunction;
    uint dwButtonTextSize;
    uint dwButtonTextOffset;
    uint dwDevSpecificSize;
    uint dwDevSpecificOffset;
    uint dwButtonState;
}

struct PHONECAPS
{
    uint dwTotalSize;
    uint dwNeededSize;
    uint dwUsedSize;
    uint dwProviderInfoSize;
    uint dwProviderInfoOffset;
    uint dwPhoneInfoSize;
    uint dwPhoneInfoOffset;
    uint dwPermanentPhoneID;
    uint dwPhoneNameSize;
    uint dwPhoneNameOffset;
    uint dwStringFormat;
    uint dwPhoneStates;
    uint dwHookSwitchDevs;
    uint dwHandsetHookSwitchModes;
    uint dwSpeakerHookSwitchModes;
    uint dwHeadsetHookSwitchModes;
    uint dwVolumeFlags;
    uint dwGainFlags;
    uint dwDisplayNumRows;
    uint dwDisplayNumColumns;
    uint dwNumRingModes;
    uint dwNumButtonLamps;
    uint dwButtonModesSize;
    uint dwButtonModesOffset;
    uint dwButtonFunctionsSize;
    uint dwButtonFunctionsOffset;
    uint dwLampModesSize;
    uint dwLampModesOffset;
    uint dwNumSetData;
    uint dwSetDataSize;
    uint dwSetDataOffset;
    uint dwNumGetData;
    uint dwGetDataSize;
    uint dwGetDataOffset;
    uint dwDevSpecificSize;
    uint dwDevSpecificOffset;
    uint dwDeviceClassesSize;
    uint dwDeviceClassesOffset;
    uint dwPhoneFeatures;
    uint dwSettableHandsetHookSwitchModes;
    uint dwSettableSpeakerHookSwitchModes;
    uint dwSettableHeadsetHookSwitchModes;
    uint dwMonitoredHandsetHookSwitchModes;
    uint dwMonitoredSpeakerHookSwitchModes;
    uint dwMonitoredHeadsetHookSwitchModes;
    Guid PermanentPhoneGuid;
}

struct PHONEEXTENSIONID
{
    uint dwExtensionID0;
    uint dwExtensionID1;
    uint dwExtensionID2;
    uint dwExtensionID3;
}

struct PHONEINITIALIZEEXPARAMS
{
    uint dwTotalSize;
    uint dwNeededSize;
    uint dwUsedSize;
    uint dwOptions;
    _Handles_e__Union Handles;
    uint dwCompletionKey;
}

struct PHONEMESSAGE
{
    uint hDevice;
    uint dwMessageID;
    uint dwCallbackInstance;
    uint dwParam1;
    uint dwParam2;
    uint dwParam3;
}

struct PHONESTATUS
{
    uint dwTotalSize;
    uint dwNeededSize;
    uint dwUsedSize;
    uint dwStatusFlags;
    uint dwNumOwners;
    uint dwNumMonitors;
    uint dwRingMode;
    uint dwRingVolume;
    uint dwHandsetHookSwitchMode;
    uint dwHandsetVolume;
    uint dwHandsetGain;
    uint dwSpeakerHookSwitchMode;
    uint dwSpeakerVolume;
    uint dwSpeakerGain;
    uint dwHeadsetHookSwitchMode;
    uint dwHeadsetVolume;
    uint dwHeadsetGain;
    uint dwDisplaySize;
    uint dwDisplayOffset;
    uint dwLampModesSize;
    uint dwLampModesOffset;
    uint dwOwnerNameSize;
    uint dwOwnerNameOffset;
    uint dwDevSpecificSize;
    uint dwDevSpecificOffset;
    uint dwPhoneFeatures;
}

struct VARSTRING
{
    uint dwTotalSize;
    uint dwNeededSize;
    uint dwUsedSize;
    uint dwStringFormat;
    uint dwStringSize;
    uint dwStringOffset;
}

const GUID CLSID_TAPI = {0x21D6D48E, 0xA88B, 0x11D0, [0x83, 0xDD, 0x00, 0xAA, 0x00, 0x3C, 0xCA, 0xBD]};
@GUID(0x21D6D48E, 0xA88B, 0x11D0, [0x83, 0xDD, 0x00, 0xAA, 0x00, 0x3C, 0xCA, 0xBD]);
struct TAPI;

const GUID CLSID_DispatchMapper = {0xE9225296, 0xC759, 0x11D1, [0xA0, 0x2B, 0x00, 0xC0, 0x4F, 0xB6, 0x80, 0x9F]};
@GUID(0xE9225296, 0xC759, 0x11D1, [0xA0, 0x2B, 0x00, 0xC0, 0x4F, 0xB6, 0x80, 0x9F]);
struct DispatchMapper;

const GUID CLSID_RequestMakeCall = {0xAC48FFE0, 0xF8C4, 0x11D1, [0xA0, 0x30, 0x00, 0xC0, 0x4F, 0xB6, 0x80, 0x9F]};
@GUID(0xAC48FFE0, 0xF8C4, 0x11D1, [0xA0, 0x30, 0x00, 0xC0, 0x4F, 0xB6, 0x80, 0x9F]);
struct RequestMakeCall;

enum TAPI_TONEMODE
{
    TTM_RINGBACK = 2,
    TTM_BUSY = 4,
    TTM_BEEP = 8,
    TTM_BILLING = 16,
}

enum TAPI_GATHERTERM
{
    TGT_BUFFERFULL = 1,
    TGT_TERMDIGIT = 2,
    TGT_FIRSTTIMEOUT = 4,
    TGT_INTERTIMEOUT = 8,
    TGT_CANCEL = 16,
}

struct TAPI_CUSTOMTONE
{
    uint dwFrequency;
    uint dwCadenceOn;
    uint dwCadenceOff;
    uint dwVolume;
}

struct TAPI_DETECTTONE
{
    uint dwAppSpecific;
    uint dwDuration;
    uint dwFrequency1;
    uint dwFrequency2;
    uint dwFrequency3;
}

enum ADDRESS_EVENT
{
    AE_STATE = 0,
    AE_CAPSCHANGE = 1,
    AE_RINGING = 2,
    AE_CONFIGCHANGE = 3,
    AE_FORWARD = 4,
    AE_NEWTERMINAL = 5,
    AE_REMOVETERMINAL = 6,
    AE_MSGWAITON = 7,
    AE_MSGWAITOFF = 8,
    AE_LASTITEM = 8,
}

enum ADDRESS_STATE
{
    AS_INSERVICE = 0,
    AS_OUTOFSERVICE = 1,
}

enum CALL_STATE
{
    CS_IDLE = 0,
    CS_INPROGRESS = 1,
    CS_CONNECTED = 2,
    CS_DISCONNECTED = 3,
    CS_OFFERING = 4,
    CS_HOLD = 5,
    CS_QUEUED = 6,
    CS_LASTITEM = 6,
}

enum CALL_STATE_EVENT_CAUSE
{
    CEC_NONE = 0,
    CEC_DISCONNECT_NORMAL = 1,
    CEC_DISCONNECT_BUSY = 2,
    CEC_DISCONNECT_BADADDRESS = 3,
    CEC_DISCONNECT_NOANSWER = 4,
    CEC_DISCONNECT_CANCELLED = 5,
    CEC_DISCONNECT_REJECTED = 6,
    CEC_DISCONNECT_FAILED = 7,
    CEC_DISCONNECT_BLOCKED = 8,
}

enum CALL_MEDIA_EVENT
{
    CME_NEW_STREAM = 0,
    CME_STREAM_FAIL = 1,
    CME_TERMINAL_FAIL = 2,
    CME_STREAM_NOT_USED = 3,
    CME_STREAM_ACTIVE = 4,
    CME_STREAM_INACTIVE = 5,
    CME_LASTITEM = 5,
}

enum CALL_MEDIA_EVENT_CAUSE
{
    CMC_UNKNOWN = 0,
    CMC_BAD_DEVICE = 1,
    CMC_CONNECT_FAIL = 2,
    CMC_LOCAL_REQUEST = 3,
    CMC_REMOTE_REQUEST = 4,
    CMC_MEDIA_TIMEOUT = 5,
    CMC_MEDIA_RECOVERED = 6,
    CMC_QUALITY_OF_SERVICE = 7,
}

enum DISCONNECT_CODE
{
    DC_NORMAL = 0,
    DC_NOANSWER = 1,
    DC_REJECTED = 2,
}

enum TERMINAL_STATE
{
    TS_INUSE = 0,
    TS_NOTINUSE = 1,
}

enum TERMINAL_DIRECTION
{
    TD_CAPTURE = 0,
    TD_RENDER = 1,
    TD_BIDIRECTIONAL = 2,
    TD_MULTITRACK_MIXED = 3,
    TD_NONE = 4,
}

enum TERMINAL_TYPE
{
    TT_STATIC = 0,
    TT_DYNAMIC = 1,
}

enum CALL_PRIVILEGE
{
    CP_OWNER = 0,
    CP_MONITOR = 1,
}

enum TAPI_EVENT
{
    TE_TAPIOBJECT = 1,
    TE_ADDRESS = 2,
    TE_CALLNOTIFICATION = 4,
    TE_CALLSTATE = 8,
    TE_CALLMEDIA = 16,
    TE_CALLHUB = 32,
    TE_CALLINFOCHANGE = 64,
    TE_PRIVATE = 128,
    TE_REQUEST = 256,
    TE_AGENT = 512,
    TE_AGENTSESSION = 1024,
    TE_QOSEVENT = 2048,
    TE_AGENTHANDLER = 4096,
    TE_ACDGROUP = 8192,
    TE_QUEUE = 16384,
    TE_DIGITEVENT = 32768,
    TE_GENERATEEVENT = 65536,
    TE_ASRTERMINAL = 131072,
    TE_TTSTERMINAL = 262144,
    TE_FILETERMINAL = 524288,
    TE_TONETERMINAL = 1048576,
    TE_PHONEEVENT = 2097152,
    TE_TONEEVENT = 4194304,
    TE_GATHERDIGITS = 8388608,
    TE_ADDRESSDEVSPECIFIC = 16777216,
    TE_PHONEDEVSPECIFIC = 33554432,
}

enum CALL_NOTIFICATION_EVENT
{
    CNE_OWNER = 0,
    CNE_MONITOR = 1,
    CNE_LASTITEM = 1,
}

enum CALLHUB_EVENT
{
    CHE_CALLJOIN = 0,
    CHE_CALLLEAVE = 1,
    CHE_CALLHUBNEW = 2,
    CHE_CALLHUBIDLE = 3,
    CHE_LASTITEM = 3,
}

enum CALLHUB_STATE
{
    CHS_ACTIVE = 0,
    CHS_IDLE = 1,
}

enum TAPIOBJECT_EVENT
{
    TE_ADDRESSCREATE = 0,
    TE_ADDRESSREMOVE = 1,
    TE_REINIT = 2,
    TE_TRANSLATECHANGE = 3,
    TE_ADDRESSCLOSE = 4,
    TE_PHONECREATE = 5,
    TE_PHONEREMOVE = 6,
}

enum TAPI_OBJECT_TYPE
{
    TOT_NONE = 0,
    TOT_TAPI = 1,
    TOT_ADDRESS = 2,
    TOT_TERMINAL = 3,
    TOT_CALL = 4,
    TOT_CALLHUB = 5,
    TOT_PHONE = 6,
}

enum QOS_SERVICE_LEVEL
{
    QSL_NEEDED = 1,
    QSL_IF_AVAILABLE = 2,
    QSL_BEST_EFFORT = 3,
}

enum QOS_EVENT
{
    QE_NOQOS = 1,
    QE_ADMISSIONFAILURE = 2,
    QE_POLICYFAILURE = 3,
    QE_GENERICERROR = 4,
    QE_LASTITEM = 4,
}

enum CALLINFOCHANGE_CAUSE
{
    CIC_OTHER = 0,
    CIC_DEVSPECIFIC = 1,
    CIC_BEARERMODE = 2,
    CIC_RATE = 3,
    CIC_APPSPECIFIC = 4,
    CIC_CALLID = 5,
    CIC_RELATEDCALLID = 6,
    CIC_ORIGIN = 7,
    CIC_REASON = 8,
    CIC_COMPLETIONID = 9,
    CIC_NUMOWNERINCR = 10,
    CIC_NUMOWNERDECR = 11,
    CIC_NUMMONITORS = 12,
    CIC_TRUNK = 13,
    CIC_CALLERID = 14,
    CIC_CALLEDID = 15,
    CIC_CONNECTEDID = 16,
    CIC_REDIRECTIONID = 17,
    CIC_REDIRECTINGID = 18,
    CIC_USERUSERINFO = 19,
    CIC_HIGHLEVELCOMP = 20,
    CIC_LOWLEVELCOMP = 21,
    CIC_CHARGINGINFO = 22,
    CIC_TREATMENT = 23,
    CIC_CALLDATA = 24,
    CIC_PRIVILEGE = 25,
    CIC_MEDIATYPE = 26,
    CIC_LASTITEM = 26,
}

enum CALLINFO_LONG
{
    CIL_MEDIATYPESAVAILABLE = 0,
    CIL_BEARERMODE = 1,
    CIL_CALLERIDADDRESSTYPE = 2,
    CIL_CALLEDIDADDRESSTYPE = 3,
    CIL_CONNECTEDIDADDRESSTYPE = 4,
    CIL_REDIRECTIONIDADDRESSTYPE = 5,
    CIL_REDIRECTINGIDADDRESSTYPE = 6,
    CIL_ORIGIN = 7,
    CIL_REASON = 8,
    CIL_APPSPECIFIC = 9,
    CIL_CALLPARAMSFLAGS = 10,
    CIL_CALLTREATMENT = 11,
    CIL_MINRATE = 12,
    CIL_MAXRATE = 13,
    CIL_COUNTRYCODE = 14,
    CIL_CALLID = 15,
    CIL_RELATEDCALLID = 16,
    CIL_COMPLETIONID = 17,
    CIL_NUMBEROFOWNERS = 18,
    CIL_NUMBEROFMONITORS = 19,
    CIL_TRUNK = 20,
    CIL_RATE = 21,
    CIL_GENERATEDIGITDURATION = 22,
    CIL_MONITORDIGITMODES = 23,
    CIL_MONITORMEDIAMODES = 24,
}

enum CALLINFO_STRING
{
    CIS_CALLERIDNAME = 0,
    CIS_CALLERIDNUMBER = 1,
    CIS_CALLEDIDNAME = 2,
    CIS_CALLEDIDNUMBER = 3,
    CIS_CONNECTEDIDNAME = 4,
    CIS_CONNECTEDIDNUMBER = 5,
    CIS_REDIRECTIONIDNAME = 6,
    CIS_REDIRECTIONIDNUMBER = 7,
    CIS_REDIRECTINGIDNAME = 8,
    CIS_REDIRECTINGIDNUMBER = 9,
    CIS_CALLEDPARTYFRIENDLYNAME = 10,
    CIS_COMMENT = 11,
    CIS_DISPLAYABLEADDRESS = 12,
    CIS_CALLINGPARTYID = 13,
}

enum CALLINFO_BUFFER
{
    CIB_USERUSERINFO = 0,
    CIB_DEVSPECIFICBUFFER = 1,
    CIB_CALLDATABUFFER = 2,
    CIB_CHARGINGINFOBUFFER = 3,
    CIB_HIGHLEVELCOMPATIBILITYBUFFER = 4,
    CIB_LOWLEVELCOMPATIBILITYBUFFER = 5,
}

enum ADDRESS_CAPABILITY
{
    AC_ADDRESSTYPES = 0,
    AC_BEARERMODES = 1,
    AC_MAXACTIVECALLS = 2,
    AC_MAXONHOLDCALLS = 3,
    AC_MAXONHOLDPENDINGCALLS = 4,
    AC_MAXNUMCONFERENCE = 5,
    AC_MAXNUMTRANSCONF = 6,
    AC_MONITORDIGITSUPPORT = 7,
    AC_GENERATEDIGITSUPPORT = 8,
    AC_GENERATETONEMODES = 9,
    AC_GENERATETONEMAXNUMFREQ = 10,
    AC_MONITORTONEMAXNUMFREQ = 11,
    AC_MONITORTONEMAXNUMENTRIES = 12,
    AC_DEVCAPFLAGS = 13,
    AC_ANSWERMODES = 14,
    AC_LINEFEATURES = 15,
    AC_SETTABLEDEVSTATUS = 16,
    AC_PARKSUPPORT = 17,
    AC_CALLERIDSUPPORT = 18,
    AC_CALLEDIDSUPPORT = 19,
    AC_CONNECTEDIDSUPPORT = 20,
    AC_REDIRECTIONIDSUPPORT = 21,
    AC_REDIRECTINGIDSUPPORT = 22,
    AC_ADDRESSCAPFLAGS = 23,
    AC_CALLFEATURES1 = 24,
    AC_CALLFEATURES2 = 25,
    AC_REMOVEFROMCONFCAPS = 26,
    AC_REMOVEFROMCONFSTATE = 27,
    AC_TRANSFERMODES = 28,
    AC_ADDRESSFEATURES = 29,
    AC_PREDICTIVEAUTOTRANSFERSTATES = 30,
    AC_MAXCALLDATASIZE = 31,
    AC_LINEID = 32,
    AC_ADDRESSID = 33,
    AC_FORWARDMODES = 34,
    AC_MAXFORWARDENTRIES = 35,
    AC_MAXSPECIFICENTRIES = 36,
    AC_MINFWDNUMRINGS = 37,
    AC_MAXFWDNUMRINGS = 38,
    AC_MAXCALLCOMPLETIONS = 39,
    AC_CALLCOMPLETIONCONDITIONS = 40,
    AC_CALLCOMPLETIONMODES = 41,
    AC_PERMANENTDEVICEID = 42,
    AC_GATHERDIGITSMINTIMEOUT = 43,
    AC_GATHERDIGITSMAXTIMEOUT = 44,
    AC_GENERATEDIGITMINDURATION = 45,
    AC_GENERATEDIGITMAXDURATION = 46,
    AC_GENERATEDIGITDEFAULTDURATION = 47,
}

enum ADDRESS_CAPABILITY_STRING
{
    ACS_PROTOCOL = 0,
    ACS_ADDRESSDEVICESPECIFIC = 1,
    ACS_LINEDEVICESPECIFIC = 2,
    ACS_PROVIDERSPECIFIC = 3,
    ACS_SWITCHSPECIFIC = 4,
    ACS_PERMANENTDEVICEGUID = 5,
}

enum FULLDUPLEX_SUPPORT
{
    FDS_SUPPORTED = 0,
    FDS_NOTSUPPORTED = 1,
    FDS_UNKNOWN = 2,
}

enum FINISH_MODE
{
    FM_ASTRANSFER = 0,
    FM_ASCONFERENCE = 1,
}

enum PHONE_PRIVILEGE
{
    PP_OWNER = 0,
    PP_MONITOR = 1,
}

enum PHONE_HOOK_SWITCH_DEVICE
{
    PHSD_HANDSET = 1,
    PHSD_SPEAKERPHONE = 2,
    PHSD_HEADSET = 4,
}

enum PHONE_HOOK_SWITCH_STATE
{
    PHSS_ONHOOK = 1,
    PHSS_OFFHOOK_MIC_ONLY = 2,
    PHSS_OFFHOOK_SPEAKER_ONLY = 4,
    PHSS_OFFHOOK = 8,
}

enum PHONE_LAMP_MODE
{
    LM_DUMMY = 1,
    LM_OFF = 2,
    LM_STEADY = 4,
    LM_WINK = 8,
    LM_FLASH = 16,
    LM_FLUTTER = 32,
    LM_BROKENFLUTTER = 64,
    LM_UNKNOWN = 128,
}

enum PHONECAPS_LONG
{
    PCL_HOOKSWITCHES = 0,
    PCL_HANDSETHOOKSWITCHMODES = 1,
    PCL_HEADSETHOOKSWITCHMODES = 2,
    PCL_SPEAKERPHONEHOOKSWITCHMODES = 3,
    PCL_DISPLAYNUMROWS = 4,
    PCL_DISPLAYNUMCOLUMNS = 5,
    PCL_NUMRINGMODES = 6,
    PCL_NUMBUTTONLAMPS = 7,
    PCL_GENERICPHONE = 8,
}

enum PHONECAPS_STRING
{
    PCS_PHONENAME = 0,
    PCS_PHONEINFO = 1,
    PCS_PROVIDERINFO = 2,
}

enum PHONECAPS_BUFFER
{
    PCB_DEVSPECIFICBUFFER = 0,
}

enum PHONE_BUTTON_STATE
{
    PBS_UP = 1,
    PBS_DOWN = 2,
    PBS_UNKNOWN = 4,
    PBS_UNAVAIL = 8,
}

enum PHONE_BUTTON_MODE
{
    PBM_DUMMY = 0,
    PBM_CALL = 1,
    PBM_FEATURE = 2,
    PBM_KEYPAD = 3,
    PBM_LOCAL = 4,
    PBM_DISPLAY = 5,
}

enum PHONE_BUTTON_FUNCTION
{
    PBF_UNKNOWN = 0,
    PBF_CONFERENCE = 1,
    PBF_TRANSFER = 2,
    PBF_DROP = 3,
    PBF_HOLD = 4,
    PBF_RECALL = 5,
    PBF_DISCONNECT = 6,
    PBF_CONNECT = 7,
    PBF_MSGWAITON = 8,
    PBF_MSGWAITOFF = 9,
    PBF_SELECTRING = 10,
    PBF_ABBREVDIAL = 11,
    PBF_FORWARD = 12,
    PBF_PICKUP = 13,
    PBF_RINGAGAIN = 14,
    PBF_PARK = 15,
    PBF_REJECT = 16,
    PBF_REDIRECT = 17,
    PBF_MUTE = 18,
    PBF_VOLUMEUP = 19,
    PBF_VOLUMEDOWN = 20,
    PBF_SPEAKERON = 21,
    PBF_SPEAKEROFF = 22,
    PBF_FLASH = 23,
    PBF_DATAON = 24,
    PBF_DATAOFF = 25,
    PBF_DONOTDISTURB = 26,
    PBF_INTERCOM = 27,
    PBF_BRIDGEDAPP = 28,
    PBF_BUSY = 29,
    PBF_CALLAPP = 30,
    PBF_DATETIME = 31,
    PBF_DIRECTORY = 32,
    PBF_COVER = 33,
    PBF_CALLID = 34,
    PBF_LASTNUM = 35,
    PBF_NIGHTSRV = 36,
    PBF_SENDCALLS = 37,
    PBF_MSGINDICATOR = 38,
    PBF_REPDIAL = 39,
    PBF_SETREPDIAL = 40,
    PBF_SYSTEMSPEED = 41,
    PBF_STATIONSPEED = 42,
    PBF_CAMPON = 43,
    PBF_SAVEREPEAT = 44,
    PBF_QUEUECALL = 45,
    PBF_NONE = 46,
    PBF_SEND = 47,
}

enum PHONE_TONE
{
    PT_KEYPADZERO = 0,
    PT_KEYPADONE = 1,
    PT_KEYPADTWO = 2,
    PT_KEYPADTHREE = 3,
    PT_KEYPADFOUR = 4,
    PT_KEYPADFIVE = 5,
    PT_KEYPADSIX = 6,
    PT_KEYPADSEVEN = 7,
    PT_KEYPADEIGHT = 8,
    PT_KEYPADNINE = 9,
    PT_KEYPADSTAR = 10,
    PT_KEYPADPOUND = 11,
    PT_KEYPADA = 12,
    PT_KEYPADB = 13,
    PT_KEYPADC = 14,
    PT_KEYPADD = 15,
    PT_NORMALDIALTONE = 16,
    PT_EXTERNALDIALTONE = 17,
    PT_BUSY = 18,
    PT_RINGBACK = 19,
    PT_ERRORTONE = 20,
    PT_SILENCE = 21,
}

enum PHONE_EVENT
{
    PE_DISPLAY = 0,
    PE_LAMPMODE = 1,
    PE_RINGMODE = 2,
    PE_RINGVOLUME = 3,
    PE_HOOKSWITCH = 4,
    PE_CAPSCHANGE = 5,
    PE_BUTTON = 6,
    PE_CLOSE = 7,
    PE_NUMBERGATHERED = 8,
    PE_DIALING = 9,
    PE_ANSWER = 10,
    PE_DISCONNECT = 11,
    PE_LASTITEM = 11,
}

const GUID IID_ITTAPI = {0xB1EFC382, 0x9355, 0x11D0, [0x83, 0x5C, 0x00, 0xAA, 0x00, 0x3C, 0xCA, 0xBD]};
@GUID(0xB1EFC382, 0x9355, 0x11D0, [0x83, 0x5C, 0x00, 0xAA, 0x00, 0x3C, 0xCA, 0xBD]);
interface ITTAPI : IDispatch
{
    HRESULT Initialize();
    HRESULT Shutdown();
    HRESULT get_Addresses(VARIANT* pVariant);
    HRESULT EnumerateAddresses(IEnumAddress* ppEnumAddress);
    HRESULT RegisterCallNotifications(ITAddress pAddress, short fMonitor, short fOwner, int lMediaTypes, int lCallbackInstance, int* plRegister);
    HRESULT UnregisterNotifications(int lRegister);
    HRESULT get_CallHubs(VARIANT* pVariant);
    HRESULT EnumerateCallHubs(IEnumCallHub* ppEnumCallHub);
    HRESULT SetCallHubTracking(VARIANT pAddresses, short bTracking);
    HRESULT EnumeratePrivateTAPIObjects(IEnumUnknown* ppEnumUnknown);
    HRESULT get_PrivateTAPIObjects(VARIANT* pVariant);
    HRESULT RegisterRequestRecipient(int lRegistrationInstance, int lRequestMode, short fEnable);
    HRESULT SetAssistedTelephonyPriority(BSTR pAppFilename, short fPriority);
    HRESULT SetApplicationPriority(BSTR pAppFilename, int lMediaType, short fPriority);
    HRESULT put_EventFilter(int lFilterMask);
    HRESULT get_EventFilter(int* plFilterMask);
}

const GUID IID_ITTAPI2 = {0x54FBDC8C, 0xD90F, 0x4DAD, [0x96, 0x95, 0xB3, 0x73, 0x09, 0x7F, 0x09, 0x4B]};
@GUID(0x54FBDC8C, 0xD90F, 0x4DAD, [0x96, 0x95, 0xB3, 0x73, 0x09, 0x7F, 0x09, 0x4B]);
interface ITTAPI2 : ITTAPI
{
    HRESULT get_Phones(VARIANT* pPhones);
    HRESULT EnumeratePhones(IEnumPhone* ppEnumPhone);
    HRESULT CreateEmptyCollectionObject(ITCollection2* ppCollection);
}

const GUID IID_ITMediaSupport = {0xB1EFC384, 0x9355, 0x11D0, [0x83, 0x5C, 0x00, 0xAA, 0x00, 0x3C, 0xCA, 0xBD]};
@GUID(0xB1EFC384, 0x9355, 0x11D0, [0x83, 0x5C, 0x00, 0xAA, 0x00, 0x3C, 0xCA, 0xBD]);
interface ITMediaSupport : IDispatch
{
    HRESULT get_MediaTypes(int* plMediaTypes);
    HRESULT QueryMediaType(int lMediaType, short* pfSupport);
}

const GUID IID_ITPluggableTerminalClassInfo = {0x41757F4A, 0xCF09, 0x4B34, [0xBC, 0x96, 0x0A, 0x79, 0xD2, 0x39, 0x00, 0x76]};
@GUID(0x41757F4A, 0xCF09, 0x4B34, [0xBC, 0x96, 0x0A, 0x79, 0xD2, 0x39, 0x00, 0x76]);
interface ITPluggableTerminalClassInfo : IDispatch
{
    HRESULT get_Name(BSTR* pName);
    HRESULT get_Company(BSTR* pCompany);
    HRESULT get_Version(BSTR* pVersion);
    HRESULT get_TerminalClass(BSTR* pTerminalClass);
    HRESULT get_CLSID(BSTR* pCLSID);
    HRESULT get_Direction(TERMINAL_DIRECTION* pDirection);
    HRESULT get_MediaTypes(int* pMediaTypes);
}

const GUID IID_ITPluggableTerminalSuperclassInfo = {0x6D54E42C, 0x4625, 0x4359, [0xA6, 0xF7, 0x63, 0x19, 0x99, 0x10, 0x7E, 0x05]};
@GUID(0x6D54E42C, 0x4625, 0x4359, [0xA6, 0xF7, 0x63, 0x19, 0x99, 0x10, 0x7E, 0x05]);
interface ITPluggableTerminalSuperclassInfo : IDispatch
{
    HRESULT get_Name(BSTR* pName);
    HRESULT get_CLSID(BSTR* pCLSID);
}

const GUID IID_ITTerminalSupport = {0xB1EFC385, 0x9355, 0x11D0, [0x83, 0x5C, 0x00, 0xAA, 0x00, 0x3C, 0xCA, 0xBD]};
@GUID(0xB1EFC385, 0x9355, 0x11D0, [0x83, 0x5C, 0x00, 0xAA, 0x00, 0x3C, 0xCA, 0xBD]);
interface ITTerminalSupport : IDispatch
{
    HRESULT get_StaticTerminals(VARIANT* pVariant);
    HRESULT EnumerateStaticTerminals(IEnumTerminal* ppTerminalEnumerator);
    HRESULT get_DynamicTerminalClasses(VARIANT* pVariant);
    HRESULT EnumerateDynamicTerminalClasses(IEnumTerminalClass* ppTerminalClassEnumerator);
    HRESULT CreateTerminal(BSTR pTerminalClass, int lMediaType, TERMINAL_DIRECTION Direction, ITTerminal* ppTerminal);
    HRESULT GetDefaultStaticTerminal(int lMediaType, TERMINAL_DIRECTION Direction, ITTerminal* ppTerminal);
}

const GUID IID_ITTerminalSupport2 = {0xF3EB39BC, 0x1B1F, 0x4E99, [0xA0, 0xC0, 0x56, 0x30, 0x5C, 0x4D, 0xD5, 0x91]};
@GUID(0xF3EB39BC, 0x1B1F, 0x4E99, [0xA0, 0xC0, 0x56, 0x30, 0x5C, 0x4D, 0xD5, 0x91]);
interface ITTerminalSupport2 : ITTerminalSupport
{
    HRESULT get_PluggableSuperclasses(VARIANT* pVariant);
    HRESULT EnumeratePluggableSuperclasses(IEnumPluggableSuperclassInfo* ppSuperclassEnumerator);
    HRESULT get_PluggableTerminalClasses(BSTR bstrTerminalSuperclass, int lMediaType, VARIANT* pVariant);
    HRESULT EnumeratePluggableTerminalClasses(Guid iidTerminalSuperclass, int lMediaType, IEnumPluggableTerminalClassInfo* ppClassEnumerator);
}

const GUID IID_ITAddress = {0xB1EFC386, 0x9355, 0x11D0, [0x83, 0x5C, 0x00, 0xAA, 0x00, 0x3C, 0xCA, 0xBD]};
@GUID(0xB1EFC386, 0x9355, 0x11D0, [0x83, 0x5C, 0x00, 0xAA, 0x00, 0x3C, 0xCA, 0xBD]);
interface ITAddress : IDispatch
{
    HRESULT get_State(ADDRESS_STATE* pAddressState);
    HRESULT get_AddressName(BSTR* ppName);
    HRESULT get_ServiceProviderName(BSTR* ppName);
    HRESULT get_TAPIObject(ITTAPI* ppTapiObject);
    HRESULT CreateCall(BSTR pDestAddress, int lAddressType, int lMediaTypes, ITBasicCallControl* ppCall);
    HRESULT get_Calls(VARIANT* pVariant);
    HRESULT EnumerateCalls(IEnumCall* ppCallEnum);
    HRESULT get_DialableAddress(BSTR* pDialableAddress);
    HRESULT CreateForwardInfoObject(ITForwardInformation* ppForwardInfo);
    HRESULT Forward(ITForwardInformation pForwardInfo, ITBasicCallControl pCall);
    HRESULT get_CurrentForwardInfo(ITForwardInformation* ppForwardInfo);
    HRESULT put_MessageWaiting(short fMessageWaiting);
    HRESULT get_MessageWaiting(short* pfMessageWaiting);
    HRESULT put_DoNotDisturb(short fDoNotDisturb);
    HRESULT get_DoNotDisturb(short* pfDoNotDisturb);
}

const GUID IID_ITAddress2 = {0xB0AE5D9B, 0xBE51, 0x46C9, [0xB0, 0xF7, 0xDF, 0xA8, 0xA2, 0x2A, 0x8B, 0xC4]};
@GUID(0xB0AE5D9B, 0xBE51, 0x46C9, [0xB0, 0xF7, 0xDF, 0xA8, 0xA2, 0x2A, 0x8B, 0xC4]);
interface ITAddress2 : ITAddress
{
    HRESULT get_Phones(VARIANT* pPhones);
    HRESULT EnumeratePhones(IEnumPhone* ppEnumPhone);
    HRESULT GetPhoneFromTerminal(ITTerminal pTerminal, ITPhone* ppPhone);
    HRESULT get_PreferredPhones(VARIANT* pPhones);
    HRESULT EnumeratePreferredPhones(IEnumPhone* ppEnumPhone);
    HRESULT get_EventFilter(TAPI_EVENT TapiEvent, int lSubEvent, short* pEnable);
    HRESULT put_EventFilter(TAPI_EVENT TapiEvent, int lSubEvent, short bEnable);
    HRESULT DeviceSpecific(ITCallInfo pCall, ubyte* pParams, uint dwSize);
    HRESULT DeviceSpecificVariant(ITCallInfo pCall, VARIANT varDevSpecificByteArray);
    HRESULT NegotiateExtVersion(int lLowVersion, int lHighVersion, int* plExtVersion);
}

const GUID IID_ITAddressCapabilities = {0x8DF232F5, 0x821B, 0x11D1, [0xBB, 0x5C, 0x00, 0xC0, 0x4F, 0xB6, 0x80, 0x9F]};
@GUID(0x8DF232F5, 0x821B, 0x11D1, [0xBB, 0x5C, 0x00, 0xC0, 0x4F, 0xB6, 0x80, 0x9F]);
interface ITAddressCapabilities : IDispatch
{
    HRESULT get_AddressCapability(ADDRESS_CAPABILITY AddressCap, int* plCapability);
    HRESULT get_AddressCapabilityString(ADDRESS_CAPABILITY_STRING AddressCapString, BSTR* ppCapabilityString);
    HRESULT get_CallTreatments(VARIANT* pVariant);
    HRESULT EnumerateCallTreatments(IEnumBstr* ppEnumCallTreatment);
    HRESULT get_CompletionMessages(VARIANT* pVariant);
    HRESULT EnumerateCompletionMessages(IEnumBstr* ppEnumCompletionMessage);
    HRESULT get_DeviceClasses(VARIANT* pVariant);
    HRESULT EnumerateDeviceClasses(IEnumBstr* ppEnumDeviceClass);
}

const GUID IID_ITPhone = {0x09D48DB4, 0x10CC, 0x4388, [0x9D, 0xE7, 0xA8, 0x46, 0x56, 0x18, 0x97, 0x5A]};
@GUID(0x09D48DB4, 0x10CC, 0x4388, [0x9D, 0xE7, 0xA8, 0x46, 0x56, 0x18, 0x97, 0x5A]);
interface ITPhone : IDispatch
{
    HRESULT Open(PHONE_PRIVILEGE Privilege);
    HRESULT Close();
    HRESULT get_Addresses(VARIANT* pAddresses);
    HRESULT EnumerateAddresses(IEnumAddress* ppEnumAddress);
    HRESULT get_PhoneCapsLong(PHONECAPS_LONG pclCap, int* plCapability);
    HRESULT get_PhoneCapsString(PHONECAPS_STRING pcsCap, BSTR* ppCapability);
    HRESULT get_Terminals(ITAddress pAddress, VARIANT* pTerminals);
    HRESULT EnumerateTerminals(ITAddress pAddress, IEnumTerminal* ppEnumTerminal);
    HRESULT get_ButtonMode(int lButtonID, PHONE_BUTTON_MODE* pButtonMode);
    HRESULT put_ButtonMode(int lButtonID, PHONE_BUTTON_MODE ButtonMode);
    HRESULT get_ButtonFunction(int lButtonID, PHONE_BUTTON_FUNCTION* pButtonFunction);
    HRESULT put_ButtonFunction(int lButtonID, PHONE_BUTTON_FUNCTION ButtonFunction);
    HRESULT get_ButtonText(int lButtonID, BSTR* ppButtonText);
    HRESULT put_ButtonText(int lButtonID, BSTR bstrButtonText);
    HRESULT get_ButtonState(int lButtonID, PHONE_BUTTON_STATE* pButtonState);
    HRESULT get_HookSwitchState(PHONE_HOOK_SWITCH_DEVICE HookSwitchDevice, PHONE_HOOK_SWITCH_STATE* pHookSwitchState);
    HRESULT put_HookSwitchState(PHONE_HOOK_SWITCH_DEVICE HookSwitchDevice, PHONE_HOOK_SWITCH_STATE HookSwitchState);
    HRESULT put_RingMode(int lRingMode);
    HRESULT get_RingMode(int* plRingMode);
    HRESULT put_RingVolume(int lRingVolume);
    HRESULT get_RingVolume(int* plRingVolume);
    HRESULT get_Privilege(PHONE_PRIVILEGE* pPrivilege);
    HRESULT GetPhoneCapsBuffer(PHONECAPS_BUFFER pcbCaps, uint* pdwSize, ubyte** ppPhoneCapsBuffer);
    HRESULT get_PhoneCapsBuffer(PHONECAPS_BUFFER pcbCaps, VARIANT* pVarBuffer);
    HRESULT get_LampMode(int lLampID, PHONE_LAMP_MODE* pLampMode);
    HRESULT put_LampMode(int lLampID, PHONE_LAMP_MODE LampMode);
    HRESULT get_Display(BSTR* pbstrDisplay);
    HRESULT SetDisplay(int lRow, int lColumn, BSTR bstrDisplay);
    HRESULT get_PreferredAddresses(VARIANT* pAddresses);
    HRESULT EnumeratePreferredAddresses(IEnumAddress* ppEnumAddress);
    HRESULT DeviceSpecific(ubyte* pParams, uint dwSize);
    HRESULT DeviceSpecificVariant(VARIANT varDevSpecificByteArray);
    HRESULT NegotiateExtVersion(int lLowVersion, int lHighVersion, int* plExtVersion);
}

const GUID IID_ITAutomatedPhoneControl = {0x1EE1AF0E, 0x6159, 0x4A61, [0xB7, 0x9B, 0x6A, 0x4B, 0xA3, 0xFC, 0x9D, 0xFC]};
@GUID(0x1EE1AF0E, 0x6159, 0x4A61, [0xB7, 0x9B, 0x6A, 0x4B, 0xA3, 0xFC, 0x9D, 0xFC]);
interface ITAutomatedPhoneControl : IDispatch
{
    HRESULT StartTone(PHONE_TONE Tone, int lDuration);
    HRESULT StopTone();
    HRESULT get_Tone(PHONE_TONE* pTone);
    HRESULT StartRinger(int lRingMode, int lDuration);
    HRESULT StopRinger();
    HRESULT get_Ringer(short* pfRinging);
    HRESULT put_PhoneHandlingEnabled(short fEnabled);
    HRESULT get_PhoneHandlingEnabled(short* pfEnabled);
    HRESULT put_AutoEndOfNumberTimeout(int lTimeout);
    HRESULT get_AutoEndOfNumberTimeout(int* plTimeout);
    HRESULT put_AutoDialtone(short fEnabled);
    HRESULT get_AutoDialtone(short* pfEnabled);
    HRESULT put_AutoStopTonesOnOnHook(short fEnabled);
    HRESULT get_AutoStopTonesOnOnHook(short* pfEnabled);
    HRESULT put_AutoStopRingOnOffHook(short fEnabled);
    HRESULT get_AutoStopRingOnOffHook(short* pfEnabled);
    HRESULT put_AutoKeypadTones(short fEnabled);
    HRESULT get_AutoKeypadTones(short* pfEnabled);
    HRESULT put_AutoKeypadTonesMinimumDuration(int lDuration);
    HRESULT get_AutoKeypadTonesMinimumDuration(int* plDuration);
    HRESULT put_AutoVolumeControl(short fEnabled);
    HRESULT get_AutoVolumeControl(short* fEnabled);
    HRESULT put_AutoVolumeControlStep(int lStepSize);
    HRESULT get_AutoVolumeControlStep(int* plStepSize);
    HRESULT put_AutoVolumeControlRepeatDelay(int lDelay);
    HRESULT get_AutoVolumeControlRepeatDelay(int* plDelay);
    HRESULT put_AutoVolumeControlRepeatPeriod(int lPeriod);
    HRESULT get_AutoVolumeControlRepeatPeriod(int* plPeriod);
    HRESULT SelectCall(ITCallInfo pCall, short fSelectDefaultTerminals);
    HRESULT UnselectCall(ITCallInfo pCall);
    HRESULT EnumerateSelectedCalls(IEnumCall* ppCallEnum);
    HRESULT get_SelectedCalls(VARIANT* pVariant);
}

const GUID IID_ITBasicCallControl = {0xB1EFC389, 0x9355, 0x11D0, [0x83, 0x5C, 0x00, 0xAA, 0x00, 0x3C, 0xCA, 0xBD]};
@GUID(0xB1EFC389, 0x9355, 0x11D0, [0x83, 0x5C, 0x00, 0xAA, 0x00, 0x3C, 0xCA, 0xBD]);
interface ITBasicCallControl : IDispatch
{
    HRESULT Connect(short fSync);
    HRESULT Answer();
    HRESULT Disconnect(DISCONNECT_CODE code);
    HRESULT Hold(short fHold);
    HRESULT HandoffDirect(BSTR pApplicationName);
    HRESULT HandoffIndirect(int lMediaType);
    HRESULT Conference(ITBasicCallControl pCall, short fSync);
    HRESULT Transfer(ITBasicCallControl pCall, short fSync);
    HRESULT BlindTransfer(BSTR pDestAddress);
    HRESULT SwapHold(ITBasicCallControl pCall);
    HRESULT ParkDirect(BSTR pParkAddress);
    HRESULT ParkIndirect(BSTR* ppNonDirAddress);
    HRESULT Unpark();
    HRESULT SetQOS(int lMediaType, QOS_SERVICE_LEVEL ServiceLevel);
    HRESULT Pickup(BSTR pGroupID);
    HRESULT Dial(BSTR pDestAddress);
    HRESULT Finish(FINISH_MODE finishMode);
    HRESULT RemoveFromConference();
}

const GUID IID_ITCallInfo = {0x350F85D1, 0x1227, 0x11D3, [0x83, 0xD4, 0x00, 0xC0, 0x4F, 0xB6, 0x80, 0x9F]};
@GUID(0x350F85D1, 0x1227, 0x11D3, [0x83, 0xD4, 0x00, 0xC0, 0x4F, 0xB6, 0x80, 0x9F]);
interface ITCallInfo : IDispatch
{
    HRESULT get_Address(ITAddress* ppAddress);
    HRESULT get_CallState(CALL_STATE* pCallState);
    HRESULT get_Privilege(CALL_PRIVILEGE* pPrivilege);
    HRESULT get_CallHub(ITCallHub* ppCallHub);
    HRESULT get_CallInfoLong(CALLINFO_LONG CallInfoLong, int* plCallInfoLongVal);
    HRESULT put_CallInfoLong(CALLINFO_LONG CallInfoLong, int lCallInfoLongVal);
    HRESULT get_CallInfoString(CALLINFO_STRING CallInfoString, BSTR* ppCallInfoString);
    HRESULT put_CallInfoString(CALLINFO_STRING CallInfoString, BSTR pCallInfoString);
    HRESULT get_CallInfoBuffer(CALLINFO_BUFFER CallInfoBuffer, VARIANT* ppCallInfoBuffer);
    HRESULT put_CallInfoBuffer(CALLINFO_BUFFER CallInfoBuffer, VARIANT pCallInfoBuffer);
    HRESULT GetCallInfoBuffer(CALLINFO_BUFFER CallInfoBuffer, uint* pdwSize, char* ppCallInfoBuffer);
    HRESULT SetCallInfoBuffer(CALLINFO_BUFFER CallInfoBuffer, uint dwSize, char* pCallInfoBuffer);
    HRESULT ReleaseUserUserInfo();
}

const GUID IID_ITCallInfo2 = {0x94D70CA6, 0x7AB0, 0x4DAA, [0x81, 0xCA, 0xB8, 0xF8, 0x64, 0x3F, 0xAE, 0xC1]};
@GUID(0x94D70CA6, 0x7AB0, 0x4DAA, [0x81, 0xCA, 0xB8, 0xF8, 0x64, 0x3F, 0xAE, 0xC1]);
interface ITCallInfo2 : ITCallInfo
{
    HRESULT get_EventFilter(TAPI_EVENT TapiEvent, int lSubEvent, short* pEnable);
    HRESULT put_EventFilter(TAPI_EVENT TapiEvent, int lSubEvent, short bEnable);
}

const GUID IID_ITTerminal = {0xB1EFC38A, 0x9355, 0x11D0, [0x83, 0x5C, 0x00, 0xAA, 0x00, 0x3C, 0xCA, 0xBD]};
@GUID(0xB1EFC38A, 0x9355, 0x11D0, [0x83, 0x5C, 0x00, 0xAA, 0x00, 0x3C, 0xCA, 0xBD]);
interface ITTerminal : IDispatch
{
    HRESULT get_Name(BSTR* ppName);
    HRESULT get_State(TERMINAL_STATE* pTerminalState);
    HRESULT get_TerminalType(TERMINAL_TYPE* pType);
    HRESULT get_TerminalClass(BSTR* ppTerminalClass);
    HRESULT get_MediaType(int* plMediaType);
    HRESULT get_Direction(TERMINAL_DIRECTION* pDirection);
}

const GUID IID_ITMultiTrackTerminal = {0xFE040091, 0xADE8, 0x4072, [0x95, 0xC9, 0xBF, 0x7D, 0xE8, 0xC5, 0x4B, 0x44]};
@GUID(0xFE040091, 0xADE8, 0x4072, [0x95, 0xC9, 0xBF, 0x7D, 0xE8, 0xC5, 0x4B, 0x44]);
interface ITMultiTrackTerminal : IDispatch
{
    HRESULT get_TrackTerminals(VARIANT* pVariant);
    HRESULT EnumerateTrackTerminals(IEnumTerminal* ppEnumTerminal);
    HRESULT CreateTrackTerminal(int MediaType, TERMINAL_DIRECTION TerminalDirection, ITTerminal* ppTerminal);
    HRESULT get_MediaTypesInUse(int* plMediaTypesInUse);
    HRESULT get_DirectionsInUse(TERMINAL_DIRECTION* plDirectionsInUsed);
    HRESULT RemoveTrackTerminal(ITTerminal pTrackTerminalToRemove);
}

enum TERMINAL_MEDIA_STATE
{
    TMS_IDLE = 0,
    TMS_ACTIVE = 1,
    TMS_PAUSED = 2,
    TMS_LASTITEM = 2,
}

enum FT_STATE_EVENT_CAUSE
{
    FTEC_NORMAL = 0,
    FTEC_END_OF_FILE = 1,
    FTEC_READ_ERROR = 2,
    FTEC_WRITE_ERROR = 3,
}

const GUID IID_ITFileTrack = {0x31CA6EA9, 0xC08A, 0x4BEA, [0x88, 0x11, 0x8E, 0x9C, 0x1B, 0xA3, 0xEA, 0x3A]};
@GUID(0x31CA6EA9, 0xC08A, 0x4BEA, [0x88, 0x11, 0x8E, 0x9C, 0x1B, 0xA3, 0xEA, 0x3A]);
interface ITFileTrack : IDispatch
{
    HRESULT get_Format(AM_MEDIA_TYPE** ppmt);
    HRESULT put_Format(const(AM_MEDIA_TYPE)* pmt);
    HRESULT get_ControllingTerminal(ITTerminal* ppControllingTerminal);
    HRESULT get_AudioFormatForScripting(ITScriptableAudioFormat* ppAudioFormat);
    HRESULT put_AudioFormatForScripting(ITScriptableAudioFormat pAudioFormat);
    HRESULT get_EmptyAudioFormatForScripting(ITScriptableAudioFormat* ppAudioFormat);
}

const GUID IID_ITMediaPlayback = {0x627E8AE6, 0xAE4C, 0x4A69, [0xBB, 0x63, 0x2A, 0xD6, 0x25, 0x40, 0x4B, 0x77]};
@GUID(0x627E8AE6, 0xAE4C, 0x4A69, [0xBB, 0x63, 0x2A, 0xD6, 0x25, 0x40, 0x4B, 0x77]);
interface ITMediaPlayback : IDispatch
{
    HRESULT put_PlayList(VARIANT PlayListVariant);
    HRESULT get_PlayList(VARIANT* pPlayListVariant);
}

const GUID IID_ITMediaRecord = {0xF5DD4592, 0x5476, 0x4CC1, [0x9D, 0x4D, 0xFA, 0xD3, 0xEE, 0xFE, 0x7D, 0xB2]};
@GUID(0xF5DD4592, 0x5476, 0x4CC1, [0x9D, 0x4D, 0xFA, 0xD3, 0xEE, 0xFE, 0x7D, 0xB2]);
interface ITMediaRecord : IDispatch
{
    HRESULT put_FileName(BSTR bstrFileName);
    HRESULT get_FileName(BSTR* pbstrFileName);
}

const GUID IID_ITMediaControl = {0xC445DDE8, 0x5199, 0x4BC7, [0x98, 0x07, 0x5F, 0xFB, 0x92, 0xE4, 0x2E, 0x09]};
@GUID(0xC445DDE8, 0x5199, 0x4BC7, [0x98, 0x07, 0x5F, 0xFB, 0x92, 0xE4, 0x2E, 0x09]);
interface ITMediaControl : IDispatch
{
    HRESULT Start();
    HRESULT Stop();
    HRESULT Pause();
    HRESULT get_MediaState(TERMINAL_MEDIA_STATE* pTerminalMediaState);
}

const GUID IID_ITBasicAudioTerminal = {0xB1EFC38D, 0x9355, 0x11D0, [0x83, 0x5C, 0x00, 0xAA, 0x00, 0x3C, 0xCA, 0xBD]};
@GUID(0xB1EFC38D, 0x9355, 0x11D0, [0x83, 0x5C, 0x00, 0xAA, 0x00, 0x3C, 0xCA, 0xBD]);
interface ITBasicAudioTerminal : IDispatch
{
    HRESULT put_Volume(int lVolume);
    HRESULT get_Volume(int* plVolume);
    HRESULT put_Balance(int lBalance);
    HRESULT get_Balance(int* plBalance);
}

const GUID IID_ITStaticAudioTerminal = {0xA86B7871, 0xD14C, 0x48E6, [0x92, 0x2E, 0xA8, 0xD1, 0x5F, 0x98, 0x48, 0x00]};
@GUID(0xA86B7871, 0xD14C, 0x48E6, [0x92, 0x2E, 0xA8, 0xD1, 0x5F, 0x98, 0x48, 0x00]);
interface ITStaticAudioTerminal : IDispatch
{
    HRESULT get_WaveId(int* plWaveId);
}

const GUID IID_ITCallHub = {0xA3C1544E, 0x5B92, 0x11D1, [0x8F, 0x4E, 0x00, 0xC0, 0x4F, 0xB6, 0x80, 0x9F]};
@GUID(0xA3C1544E, 0x5B92, 0x11D1, [0x8F, 0x4E, 0x00, 0xC0, 0x4F, 0xB6, 0x80, 0x9F]);
interface ITCallHub : IDispatch
{
    HRESULT Clear();
    HRESULT EnumerateCalls(IEnumCall* ppEnumCall);
    HRESULT get_Calls(VARIANT* pCalls);
    HRESULT get_NumCalls(int* plCalls);
    HRESULT get_State(CALLHUB_STATE* pState);
}

const GUID IID_ITLegacyAddressMediaControl = {0xAB493640, 0x4C0B, 0x11D2, [0xA0, 0x46, 0x00, 0xC0, 0x4F, 0xB6, 0x80, 0x9F]};
@GUID(0xAB493640, 0x4C0B, 0x11D2, [0xA0, 0x46, 0x00, 0xC0, 0x4F, 0xB6, 0x80, 0x9F]);
interface ITLegacyAddressMediaControl : IUnknown
{
    HRESULT GetID(BSTR pDeviceClass, uint* pdwSize, char* ppDeviceID);
    HRESULT GetDevConfig(BSTR pDeviceClass, uint* pdwSize, char* ppDeviceConfig);
    HRESULT SetDevConfig(BSTR pDeviceClass, uint dwSize, char* pDeviceConfig);
}

const GUID IID_ITPrivateEvent = {0x0E269CD0, 0x10D4, 0x4121, [0x9C, 0x22, 0x9C, 0x85, 0xD6, 0x25, 0x65, 0x0D]};
@GUID(0x0E269CD0, 0x10D4, 0x4121, [0x9C, 0x22, 0x9C, 0x85, 0xD6, 0x25, 0x65, 0x0D]);
interface ITPrivateEvent : IDispatch
{
    HRESULT get_Address(ITAddress* ppAddress);
    HRESULT get_Call(ITCallInfo* ppCallInfo);
    HRESULT get_CallHub(ITCallHub* ppCallHub);
    HRESULT get_EventCode(int* plEventCode);
    HRESULT get_EventInterface(IDispatch* pEventInterface);
}

const GUID IID_ITLegacyAddressMediaControl2 = {0xB0EE512B, 0xA531, 0x409E, [0x9D, 0xD9, 0x40, 0x99, 0xFE, 0x86, 0xC7, 0x38]};
@GUID(0xB0EE512B, 0xA531, 0x409E, [0x9D, 0xD9, 0x40, 0x99, 0xFE, 0x86, 0xC7, 0x38]);
interface ITLegacyAddressMediaControl2 : ITLegacyAddressMediaControl
{
    HRESULT ConfigDialog(HWND hwndOwner, BSTR pDeviceClass);
    HRESULT ConfigDialogEdit(HWND hwndOwner, BSTR pDeviceClass, uint dwSizeIn, char* pDeviceConfigIn, uint* pdwSizeOut, char* ppDeviceConfigOut);
}

const GUID IID_ITLegacyCallMediaControl = {0xD624582F, 0xCC23, 0x4436, [0xB8, 0xA5, 0x47, 0xC6, 0x25, 0xC8, 0x04, 0x5D]};
@GUID(0xD624582F, 0xCC23, 0x4436, [0xB8, 0xA5, 0x47, 0xC6, 0x25, 0xC8, 0x04, 0x5D]);
interface ITLegacyCallMediaControl : IDispatch
{
    HRESULT DetectDigits(int DigitMode);
    HRESULT GenerateDigits(BSTR pDigits, int DigitMode);
    HRESULT GetID(BSTR pDeviceClass, uint* pdwSize, char* ppDeviceID);
    HRESULT SetMediaType(int lMediaType);
    HRESULT MonitorMedia(int lMediaType);
}

const GUID IID_ITLegacyCallMediaControl2 = {0x57CA332D, 0x7BC2, 0x44F1, [0xA6, 0x0C, 0x93, 0x6F, 0xE8, 0xD7, 0xCE, 0x73]};
@GUID(0x57CA332D, 0x7BC2, 0x44F1, [0xA6, 0x0C, 0x93, 0x6F, 0xE8, 0xD7, 0xCE, 0x73]);
interface ITLegacyCallMediaControl2 : ITLegacyCallMediaControl
{
    HRESULT GenerateDigits2(BSTR pDigits, int DigitMode, int lDuration);
    HRESULT GatherDigits(int DigitMode, int lNumDigits, BSTR pTerminationDigits, int lFirstDigitTimeout, int lInterDigitTimeout);
    HRESULT DetectTones(TAPI_DETECTTONE* pToneList, int lNumTones);
    HRESULT DetectTonesByCollection(ITCollection2 pDetectToneCollection);
    HRESULT GenerateTone(TAPI_TONEMODE ToneMode, int lDuration);
    HRESULT GenerateCustomTones(TAPI_CUSTOMTONE* pToneList, int lNumTones, int lDuration);
    HRESULT GenerateCustomTonesByCollection(ITCollection2 pCustomToneCollection, int lDuration);
    HRESULT CreateDetectToneObject(ITDetectTone* ppDetectTone);
    HRESULT CreateCustomToneObject(ITCustomTone* ppCustomTone);
    HRESULT GetIDAsVariant(BSTR bstrDeviceClass, VARIANT* pVarDeviceID);
}

const GUID IID_ITDetectTone = {0x961F79BD, 0x3097, 0x49DF, [0xA1, 0xD6, 0x90, 0x9B, 0x77, 0xE8, 0x9C, 0xA0]};
@GUID(0x961F79BD, 0x3097, 0x49DF, [0xA1, 0xD6, 0x90, 0x9B, 0x77, 0xE8, 0x9C, 0xA0]);
interface ITDetectTone : IDispatch
{
    HRESULT get_AppSpecific(int* plAppSpecific);
    HRESULT put_AppSpecific(int lAppSpecific);
    HRESULT get_Duration(int* plDuration);
    HRESULT put_Duration(int lDuration);
    HRESULT get_Frequency(int Index, int* plFrequency);
    HRESULT put_Frequency(int Index, int lFrequency);
}

const GUID IID_ITCustomTone = {0x357AD764, 0xB3C6, 0x4B2A, [0x8F, 0xA5, 0x07, 0x22, 0x82, 0x7A, 0x92, 0x54]};
@GUID(0x357AD764, 0xB3C6, 0x4B2A, [0x8F, 0xA5, 0x07, 0x22, 0x82, 0x7A, 0x92, 0x54]);
interface ITCustomTone : IDispatch
{
    HRESULT get_Frequency(int* plFrequency);
    HRESULT put_Frequency(int lFrequency);
    HRESULT get_CadenceOn(int* plCadenceOn);
    HRESULT put_CadenceOn(int CadenceOn);
    HRESULT get_CadenceOff(int* plCadenceOff);
    HRESULT put_CadenceOff(int lCadenceOff);
    HRESULT get_Volume(int* plVolume);
    HRESULT put_Volume(int lVolume);
}

const GUID IID_IEnumPhone = {0xF15B7669, 0x4780, 0x4595, [0x8C, 0x89, 0xFB, 0x36, 0x9C, 0x8C, 0xF7, 0xAA]};
@GUID(0xF15B7669, 0x4780, 0x4595, [0x8C, 0x89, 0xFB, 0x36, 0x9C, 0x8C, 0xF7, 0xAA]);
interface IEnumPhone : IUnknown
{
    HRESULT Next(uint celt, char* ppElements, uint* pceltFetched);
    HRESULT Reset();
    HRESULT Skip(uint celt);
    HRESULT Clone(IEnumPhone* ppEnum);
}

const GUID IID_IEnumTerminal = {0xAE269CF4, 0x935E, 0x11D0, [0x83, 0x5C, 0x00, 0xAA, 0x00, 0x3C, 0xCA, 0xBD]};
@GUID(0xAE269CF4, 0x935E, 0x11D0, [0x83, 0x5C, 0x00, 0xAA, 0x00, 0x3C, 0xCA, 0xBD]);
interface IEnumTerminal : IUnknown
{
    HRESULT Next(uint celt, ITTerminal* ppElements, uint* pceltFetched);
    HRESULT Reset();
    HRESULT Skip(uint celt);
    HRESULT Clone(IEnumTerminal* ppEnum);
}

const GUID IID_IEnumTerminalClass = {0xAE269CF5, 0x935E, 0x11D0, [0x83, 0x5C, 0x00, 0xAA, 0x00, 0x3C, 0xCA, 0xBD]};
@GUID(0xAE269CF5, 0x935E, 0x11D0, [0x83, 0x5C, 0x00, 0xAA, 0x00, 0x3C, 0xCA, 0xBD]);
interface IEnumTerminalClass : IUnknown
{
    HRESULT Next(uint celt, char* pElements, uint* pceltFetched);
    HRESULT Reset();
    HRESULT Skip(uint celt);
    HRESULT Clone(IEnumTerminalClass* ppEnum);
}

const GUID IID_IEnumCall = {0xAE269CF6, 0x935E, 0x11D0, [0x83, 0x5C, 0x00, 0xAA, 0x00, 0x3C, 0xCA, 0xBD]};
@GUID(0xAE269CF6, 0x935E, 0x11D0, [0x83, 0x5C, 0x00, 0xAA, 0x00, 0x3C, 0xCA, 0xBD]);
interface IEnumCall : IUnknown
{
    HRESULT Next(uint celt, ITCallInfo* ppElements, uint* pceltFetched);
    HRESULT Reset();
    HRESULT Skip(uint celt);
    HRESULT Clone(IEnumCall* ppEnum);
}

const GUID IID_IEnumAddress = {0x1666FCA1, 0x9363, 0x11D0, [0x83, 0x5C, 0x00, 0xAA, 0x00, 0x3C, 0xCA, 0xBD]};
@GUID(0x1666FCA1, 0x9363, 0x11D0, [0x83, 0x5C, 0x00, 0xAA, 0x00, 0x3C, 0xCA, 0xBD]);
interface IEnumAddress : IUnknown
{
    HRESULT Next(uint celt, char* ppElements, uint* pceltFetched);
    HRESULT Reset();
    HRESULT Skip(uint celt);
    HRESULT Clone(IEnumAddress* ppEnum);
}

const GUID IID_IEnumCallHub = {0xA3C15450, 0x5B92, 0x11D1, [0x8F, 0x4E, 0x00, 0xC0, 0x4F, 0xB6, 0x80, 0x9F]};
@GUID(0xA3C15450, 0x5B92, 0x11D1, [0x8F, 0x4E, 0x00, 0xC0, 0x4F, 0xB6, 0x80, 0x9F]);
interface IEnumCallHub : IUnknown
{
    HRESULT Next(uint celt, char* ppElements, uint* pceltFetched);
    HRESULT Reset();
    HRESULT Skip(uint celt);
    HRESULT Clone(IEnumCallHub* ppEnum);
}

const GUID IID_IEnumBstr = {0x35372049, 0x0BC6, 0x11D2, [0xA0, 0x33, 0x00, 0xC0, 0x4F, 0xB6, 0x80, 0x9F]};
@GUID(0x35372049, 0x0BC6, 0x11D2, [0xA0, 0x33, 0x00, 0xC0, 0x4F, 0xB6, 0x80, 0x9F]);
interface IEnumBstr : IUnknown
{
    HRESULT Next(uint celt, char* ppStrings, uint* pceltFetched);
    HRESULT Reset();
    HRESULT Skip(uint celt);
    HRESULT Clone(IEnumBstr* ppEnum);
}

const GUID IID_IEnumPluggableTerminalClassInfo = {0x4567450C, 0xDBEE, 0x4E3F, [0xAA, 0xF5, 0x37, 0xBF, 0x9E, 0xBF, 0x5E, 0x29]};
@GUID(0x4567450C, 0xDBEE, 0x4E3F, [0xAA, 0xF5, 0x37, 0xBF, 0x9E, 0xBF, 0x5E, 0x29]);
interface IEnumPluggableTerminalClassInfo : IUnknown
{
    HRESULT Next(uint celt, char* ppElements, uint* pceltFetched);
    HRESULT Reset();
    HRESULT Skip(uint celt);
    HRESULT Clone(IEnumPluggableTerminalClassInfo* ppEnum);
}

const GUID IID_IEnumPluggableSuperclassInfo = {0xE9586A80, 0x89E6, 0x4CFF, [0x93, 0x1D, 0x47, 0x8D, 0x57, 0x51, 0xF4, 0xC0]};
@GUID(0xE9586A80, 0x89E6, 0x4CFF, [0x93, 0x1D, 0x47, 0x8D, 0x57, 0x51, 0xF4, 0xC0]);
interface IEnumPluggableSuperclassInfo : IUnknown
{
    HRESULT Next(uint celt, char* ppElements, uint* pceltFetched);
    HRESULT Reset();
    HRESULT Skip(uint celt);
    HRESULT Clone(IEnumPluggableSuperclassInfo* ppEnum);
}

const GUID IID_ITPhoneEvent = {0x8F942DD8, 0x64ED, 0x4AAF, [0xA7, 0x7D, 0xB2, 0x3D, 0xB0, 0x83, 0x7E, 0xAD]};
@GUID(0x8F942DD8, 0x64ED, 0x4AAF, [0xA7, 0x7D, 0xB2, 0x3D, 0xB0, 0x83, 0x7E, 0xAD]);
interface ITPhoneEvent : IDispatch
{
    HRESULT get_Phone(ITPhone* ppPhone);
    HRESULT get_Event(PHONE_EVENT* pEvent);
    HRESULT get_ButtonState(PHONE_BUTTON_STATE* pState);
    HRESULT get_HookSwitchState(PHONE_HOOK_SWITCH_STATE* pState);
    HRESULT get_HookSwitchDevice(PHONE_HOOK_SWITCH_DEVICE* pDevice);
    HRESULT get_RingMode(int* plRingMode);
    HRESULT get_ButtonLampId(int* plButtonLampId);
    HRESULT get_NumberGathered(BSTR* ppNumber);
    HRESULT get_Call(ITCallInfo* ppCallInfo);
}

const GUID IID_ITCallStateEvent = {0x62F47097, 0x95C9, 0x11D0, [0x83, 0x5D, 0x00, 0xAA, 0x00, 0x3C, 0xCA, 0xBD]};
@GUID(0x62F47097, 0x95C9, 0x11D0, [0x83, 0x5D, 0x00, 0xAA, 0x00, 0x3C, 0xCA, 0xBD]);
interface ITCallStateEvent : IDispatch
{
    HRESULT get_Call(ITCallInfo* ppCallInfo);
    HRESULT get_State(CALL_STATE* pCallState);
    HRESULT get_Cause(CALL_STATE_EVENT_CAUSE* pCEC);
    HRESULT get_CallbackInstance(int* plCallbackInstance);
}

const GUID IID_ITPhoneDeviceSpecificEvent = {0x63FFB2A6, 0x872B, 0x4CD3, [0xA5, 0x01, 0x32, 0x6E, 0x8F, 0xB4, 0x0A, 0xF7]};
@GUID(0x63FFB2A6, 0x872B, 0x4CD3, [0xA5, 0x01, 0x32, 0x6E, 0x8F, 0xB4, 0x0A, 0xF7]);
interface ITPhoneDeviceSpecificEvent : IDispatch
{
    HRESULT get_Phone(ITPhone* ppPhone);
    HRESULT get_lParam1(int* pParam1);
    HRESULT get_lParam2(int* pParam2);
    HRESULT get_lParam3(int* pParam3);
}

const GUID IID_ITCallMediaEvent = {0xFF36B87F, 0xEC3A, 0x11D0, [0x8E, 0xE4, 0x00, 0xC0, 0x4F, 0xB6, 0x80, 0x9F]};
@GUID(0xFF36B87F, 0xEC3A, 0x11D0, [0x8E, 0xE4, 0x00, 0xC0, 0x4F, 0xB6, 0x80, 0x9F]);
interface ITCallMediaEvent : IDispatch
{
    HRESULT get_Call(ITCallInfo* ppCallInfo);
    HRESULT get_Event(CALL_MEDIA_EVENT* pCallMediaEvent);
    HRESULT get_Error(int* phrError);
    HRESULT get_Terminal(ITTerminal* ppTerminal);
    HRESULT get_Stream(ITStream* ppStream);
    HRESULT get_Cause(CALL_MEDIA_EVENT_CAUSE* pCause);
}

const GUID IID_ITDigitDetectionEvent = {0x80D3BFAC, 0x57D9, 0x11D2, [0xA0, 0x4A, 0x00, 0xC0, 0x4F, 0xB6, 0x80, 0x9F]};
@GUID(0x80D3BFAC, 0x57D9, 0x11D2, [0xA0, 0x4A, 0x00, 0xC0, 0x4F, 0xB6, 0x80, 0x9F]);
interface ITDigitDetectionEvent : IDispatch
{
    HRESULT get_Call(ITCallInfo* ppCallInfo);
    HRESULT get_Digit(ubyte* pucDigit);
    HRESULT get_DigitMode(int* pDigitMode);
    HRESULT get_TickCount(int* plTickCount);
    HRESULT get_CallbackInstance(int* plCallbackInstance);
}

const GUID IID_ITDigitGenerationEvent = {0x80D3BFAD, 0x57D9, 0x11D2, [0xA0, 0x4A, 0x00, 0xC0, 0x4F, 0xB6, 0x80, 0x9F]};
@GUID(0x80D3BFAD, 0x57D9, 0x11D2, [0xA0, 0x4A, 0x00, 0xC0, 0x4F, 0xB6, 0x80, 0x9F]);
interface ITDigitGenerationEvent : IDispatch
{
    HRESULT get_Call(ITCallInfo* ppCallInfo);
    HRESULT get_GenerationTermination(int* plGenerationTermination);
    HRESULT get_TickCount(int* plTickCount);
    HRESULT get_CallbackInstance(int* plCallbackInstance);
}

const GUID IID_ITDigitsGatheredEvent = {0xE52EC4C1, 0xCBA3, 0x441A, [0x9E, 0x6A, 0x93, 0xCB, 0x90, 0x9E, 0x97, 0x24]};
@GUID(0xE52EC4C1, 0xCBA3, 0x441A, [0x9E, 0x6A, 0x93, 0xCB, 0x90, 0x9E, 0x97, 0x24]);
interface ITDigitsGatheredEvent : IDispatch
{
    HRESULT get_Call(ITCallInfo* ppCallInfo);
    HRESULT get_Digits(BSTR* ppDigits);
    HRESULT get_GatherTermination(TAPI_GATHERTERM* pGatherTermination);
    HRESULT get_TickCount(int* plTickCount);
    HRESULT get_CallbackInstance(int* plCallbackInstance);
}

const GUID IID_ITToneDetectionEvent = {0x407E0FAF, 0xD047, 0x4753, [0xB0, 0xC6, 0x8E, 0x06, 0x03, 0x73, 0xFE, 0xCD]};
@GUID(0x407E0FAF, 0xD047, 0x4753, [0xB0, 0xC6, 0x8E, 0x06, 0x03, 0x73, 0xFE, 0xCD]);
interface ITToneDetectionEvent : IDispatch
{
    HRESULT get_Call(ITCallInfo* ppCallInfo);
    HRESULT get_AppSpecific(int* plAppSpecific);
    HRESULT get_TickCount(int* plTickCount);
    HRESULT get_CallbackInstance(int* plCallbackInstance);
}

const GUID IID_ITTAPIObjectEvent = {0xF4854D48, 0x937A, 0x11D1, [0xBB, 0x58, 0x00, 0xC0, 0x4F, 0xB6, 0x80, 0x9F]};
@GUID(0xF4854D48, 0x937A, 0x11D1, [0xBB, 0x58, 0x00, 0xC0, 0x4F, 0xB6, 0x80, 0x9F]);
interface ITTAPIObjectEvent : IDispatch
{
    HRESULT get_TAPIObject(ITTAPI* ppTAPIObject);
    HRESULT get_Event(TAPIOBJECT_EVENT* pEvent);
    HRESULT get_Address(ITAddress* ppAddress);
    HRESULT get_CallbackInstance(int* plCallbackInstance);
}

const GUID IID_ITTAPIObjectEvent2 = {0x359DDA6E, 0x68CE, 0x4383, [0xBF, 0x0B, 0x16, 0x91, 0x33, 0xC4, 0x1B, 0x46]};
@GUID(0x359DDA6E, 0x68CE, 0x4383, [0xBF, 0x0B, 0x16, 0x91, 0x33, 0xC4, 0x1B, 0x46]);
interface ITTAPIObjectEvent2 : ITTAPIObjectEvent
{
    HRESULT get_Phone(ITPhone* ppPhone);
}

const GUID IID_ITTAPIEventNotification = {0xEDDB9426, 0x3B91, 0x11D1, [0x8F, 0x30, 0x00, 0xC0, 0x4F, 0xB6, 0x80, 0x9F]};
@GUID(0xEDDB9426, 0x3B91, 0x11D1, [0x8F, 0x30, 0x00, 0xC0, 0x4F, 0xB6, 0x80, 0x9F]);
interface ITTAPIEventNotification : IUnknown
{
    HRESULT Event(TAPI_EVENT TapiEvent, IDispatch pEvent);
}

const GUID IID_ITCallHubEvent = {0xA3C15451, 0x5B92, 0x11D1, [0x8F, 0x4E, 0x00, 0xC0, 0x4F, 0xB6, 0x80, 0x9F]};
@GUID(0xA3C15451, 0x5B92, 0x11D1, [0x8F, 0x4E, 0x00, 0xC0, 0x4F, 0xB6, 0x80, 0x9F]);
interface ITCallHubEvent : IDispatch
{
    HRESULT get_Event(CALLHUB_EVENT* pEvent);
    HRESULT get_CallHub(ITCallHub* ppCallHub);
    HRESULT get_Call(ITCallInfo* ppCall);
}

const GUID IID_ITAddressEvent = {0x831CE2D1, 0x83B5, 0x11D1, [0xBB, 0x5C, 0x00, 0xC0, 0x4F, 0xB6, 0x80, 0x9F]};
@GUID(0x831CE2D1, 0x83B5, 0x11D1, [0xBB, 0x5C, 0x00, 0xC0, 0x4F, 0xB6, 0x80, 0x9F]);
interface ITAddressEvent : IDispatch
{
    HRESULT get_Address(ITAddress* ppAddress);
    HRESULT get_Event(ADDRESS_EVENT* pEvent);
    HRESULT get_Terminal(ITTerminal* ppTerminal);
}

const GUID IID_ITAddressDeviceSpecificEvent = {0x3ACB216B, 0x40BD, 0x487A, [0x86, 0x72, 0x5C, 0xE7, 0x7B, 0xD7, 0xE3, 0xA3]};
@GUID(0x3ACB216B, 0x40BD, 0x487A, [0x86, 0x72, 0x5C, 0xE7, 0x7B, 0xD7, 0xE3, 0xA3]);
interface ITAddressDeviceSpecificEvent : IDispatch
{
    HRESULT get_Address(ITAddress* ppAddress);
    HRESULT get_Call(ITCallInfo* ppCall);
    HRESULT get_lParam1(int* pParam1);
    HRESULT get_lParam2(int* pParam2);
    HRESULT get_lParam3(int* pParam3);
}

const GUID IID_ITFileTerminalEvent = {0xE4A7FBAC, 0x8C17, 0x4427, [0x9F, 0x55, 0x9F, 0x58, 0x9A, 0xC8, 0xAF, 0x00]};
@GUID(0xE4A7FBAC, 0x8C17, 0x4427, [0x9F, 0x55, 0x9F, 0x58, 0x9A, 0xC8, 0xAF, 0x00]);
interface ITFileTerminalEvent : IDispatch
{
    HRESULT get_Terminal(ITTerminal* ppTerminal);
    HRESULT get_Track(ITFileTrack* ppTrackTerminal);
    HRESULT get_Call(ITCallInfo* ppCall);
    HRESULT get_State(TERMINAL_MEDIA_STATE* pState);
    HRESULT get_Cause(FT_STATE_EVENT_CAUSE* pCause);
    HRESULT get_Error(int* phrErrorCode);
}

const GUID IID_ITTTSTerminalEvent = {0xD964788F, 0x95A5, 0x461D, [0xAB, 0x0C, 0xB9, 0x90, 0x0A, 0x6C, 0x27, 0x13]};
@GUID(0xD964788F, 0x95A5, 0x461D, [0xAB, 0x0C, 0xB9, 0x90, 0x0A, 0x6C, 0x27, 0x13]);
interface ITTTSTerminalEvent : IDispatch
{
    HRESULT get_Terminal(ITTerminal* ppTerminal);
    HRESULT get_Call(ITCallInfo* ppCall);
    HRESULT get_Error(int* phrErrorCode);
}

const GUID IID_ITASRTerminalEvent = {0xEE016A02, 0x4FA9, 0x467C, [0x93, 0x3F, 0x5A, 0x15, 0xB1, 0x23, 0x77, 0xD7]};
@GUID(0xEE016A02, 0x4FA9, 0x467C, [0x93, 0x3F, 0x5A, 0x15, 0xB1, 0x23, 0x77, 0xD7]);
interface ITASRTerminalEvent : IDispatch
{
    HRESULT get_Terminal(ITTerminal* ppTerminal);
    HRESULT get_Call(ITCallInfo* ppCall);
    HRESULT get_Error(int* phrErrorCode);
}

const GUID IID_ITToneTerminalEvent = {0xE6F56009, 0x611F, 0x4945, [0xBB, 0xD2, 0x2D, 0x0C, 0xE5, 0x61, 0x20, 0x56]};
@GUID(0xE6F56009, 0x611F, 0x4945, [0xBB, 0xD2, 0x2D, 0x0C, 0xE5, 0x61, 0x20, 0x56]);
interface ITToneTerminalEvent : IDispatch
{
    HRESULT get_Terminal(ITTerminal* ppTerminal);
    HRESULT get_Call(ITCallInfo* ppCall);
    HRESULT get_Error(int* phrErrorCode);
}

const GUID IID_ITQOSEvent = {0xCFA3357C, 0xAD77, 0x11D1, [0xBB, 0x68, 0x00, 0xC0, 0x4F, 0xB6, 0x80, 0x9F]};
@GUID(0xCFA3357C, 0xAD77, 0x11D1, [0xBB, 0x68, 0x00, 0xC0, 0x4F, 0xB6, 0x80, 0x9F]);
interface ITQOSEvent : IDispatch
{
    HRESULT get_Call(ITCallInfo* ppCall);
    HRESULT get_Event(QOS_EVENT* pQosEvent);
    HRESULT get_MediaType(int* plMediaType);
}

const GUID IID_ITCallInfoChangeEvent = {0x5D4B65F9, 0xE51C, 0x11D1, [0xA0, 0x2F, 0x00, 0xC0, 0x4F, 0xB6, 0x80, 0x9F]};
@GUID(0x5D4B65F9, 0xE51C, 0x11D1, [0xA0, 0x2F, 0x00, 0xC0, 0x4F, 0xB6, 0x80, 0x9F]);
interface ITCallInfoChangeEvent : IDispatch
{
    HRESULT get_Call(ITCallInfo* ppCall);
    HRESULT get_Cause(CALLINFOCHANGE_CAUSE* pCIC);
    HRESULT get_CallbackInstance(int* plCallbackInstance);
}

const GUID IID_ITRequest = {0xAC48FFDF, 0xF8C4, 0x11D1, [0xA0, 0x30, 0x00, 0xC0, 0x4F, 0xB6, 0x80, 0x9F]};
@GUID(0xAC48FFDF, 0xF8C4, 0x11D1, [0xA0, 0x30, 0x00, 0xC0, 0x4F, 0xB6, 0x80, 0x9F]);
interface ITRequest : IDispatch
{
    HRESULT MakeCall(BSTR pDestAddress, BSTR pAppName, BSTR pCalledParty, BSTR pComment);
}

const GUID IID_ITRequestEvent = {0xAC48FFDE, 0xF8C4, 0x11D1, [0xA0, 0x30, 0x00, 0xC0, 0x4F, 0xB6, 0x80, 0x9F]};
@GUID(0xAC48FFDE, 0xF8C4, 0x11D1, [0xA0, 0x30, 0x00, 0xC0, 0x4F, 0xB6, 0x80, 0x9F]);
interface ITRequestEvent : IDispatch
{
    HRESULT get_RegistrationInstance(int* plRegistrationInstance);
    HRESULT get_RequestMode(int* plRequestMode);
    HRESULT get_DestAddress(BSTR* ppDestAddress);
    HRESULT get_AppName(BSTR* ppAppName);
    HRESULT get_CalledParty(BSTR* ppCalledParty);
    HRESULT get_Comment(BSTR* ppComment);
}

const GUID IID_ITCollection = {0x5EC5ACF2, 0x9C02, 0x11D0, [0x83, 0x62, 0x00, 0xAA, 0x00, 0x3C, 0xCA, 0xBD]};
@GUID(0x5EC5ACF2, 0x9C02, 0x11D0, [0x83, 0x62, 0x00, 0xAA, 0x00, 0x3C, 0xCA, 0xBD]);
interface ITCollection : IDispatch
{
    HRESULT get_Count(int* lCount);
    HRESULT get_Item(int Index, VARIANT* pVariant);
    HRESULT get__NewEnum(IUnknown* ppNewEnum);
}

const GUID IID_ITCollection2 = {0xE6DDDDA5, 0xA6D3, 0x48FF, [0x87, 0x37, 0xD3, 0x2F, 0xC4, 0xD9, 0x54, 0x77]};
@GUID(0xE6DDDDA5, 0xA6D3, 0x48FF, [0x87, 0x37, 0xD3, 0x2F, 0xC4, 0xD9, 0x54, 0x77]);
interface ITCollection2 : ITCollection
{
    HRESULT Add(int Index, VARIANT* pVariant);
    HRESULT Remove(int Index);
}

const GUID IID_ITForwardInformation = {0x449F659E, 0x88A3, 0x11D1, [0xBB, 0x5D, 0x00, 0xC0, 0x4F, 0xB6, 0x80, 0x9F]};
@GUID(0x449F659E, 0x88A3, 0x11D1, [0xBB, 0x5D, 0x00, 0xC0, 0x4F, 0xB6, 0x80, 0x9F]);
interface ITForwardInformation : IDispatch
{
    HRESULT put_NumRingsNoAnswer(int lNumRings);
    HRESULT get_NumRingsNoAnswer(int* plNumRings);
    HRESULT SetForwardType(int ForwardType, BSTR pDestAddress, BSTR pCallerAddress);
    HRESULT get_ForwardTypeDestination(int ForwardType, BSTR* ppDestAddress);
    HRESULT get_ForwardTypeCaller(int Forwardtype, BSTR* ppCallerAddress);
    HRESULT GetForwardType(int ForwardType, BSTR* ppDestinationAddress, BSTR* ppCallerAddress);
    HRESULT Clear();
}

const GUID IID_ITForwardInformation2 = {0x5229B4ED, 0xB260, 0x4382, [0x8E, 0x1A, 0x5D, 0xF3, 0xA8, 0xA4, 0xCC, 0xC0]};
@GUID(0x5229B4ED, 0xB260, 0x4382, [0x8E, 0x1A, 0x5D, 0xF3, 0xA8, 0xA4, 0xCC, 0xC0]);
interface ITForwardInformation2 : ITForwardInformation
{
    HRESULT SetForwardType2(int ForwardType, BSTR pDestAddress, int DestAddressType, BSTR pCallerAddress, int CallerAddressType);
    HRESULT GetForwardType2(int ForwardType, BSTR* ppDestinationAddress, int* pDestAddressType, BSTR* ppCallerAddress, int* pCallerAddressType);
    HRESULT get_ForwardTypeDestinationAddressType(int ForwardType, int* pDestAddressType);
    HRESULT get_ForwardTypeCallerAddressType(int Forwardtype, int* pCallerAddressType);
}

const GUID IID_ITAddressTranslation = {0x0C4D8F03, 0x8DDB, 0x11D1, [0xA0, 0x9E, 0x00, 0x80, 0x5F, 0xC1, 0x47, 0xD3]};
@GUID(0x0C4D8F03, 0x8DDB, 0x11D1, [0xA0, 0x9E, 0x00, 0x80, 0x5F, 0xC1, 0x47, 0xD3]);
interface ITAddressTranslation : IDispatch
{
    HRESULT TranslateAddress(BSTR pAddressToTranslate, int lCard, int lTranslateOptions, ITAddressTranslationInfo* ppTranslated);
    HRESULT TranslateDialog(int hwndOwner, BSTR pAddressIn);
    HRESULT EnumerateLocations(IEnumLocation* ppEnumLocation);
    HRESULT get_Locations(VARIANT* pVariant);
    HRESULT EnumerateCallingCards(IEnumCallingCard* ppEnumCallingCard);
    HRESULT get_CallingCards(VARIANT* pVariant);
}

const GUID IID_ITAddressTranslationInfo = {0xAFC15945, 0x8D40, 0x11D1, [0xA0, 0x9E, 0x00, 0x80, 0x5F, 0xC1, 0x47, 0xD3]};
@GUID(0xAFC15945, 0x8D40, 0x11D1, [0xA0, 0x9E, 0x00, 0x80, 0x5F, 0xC1, 0x47, 0xD3]);
interface ITAddressTranslationInfo : IDispatch
{
    HRESULT get_DialableString(BSTR* ppDialableString);
    HRESULT get_DisplayableString(BSTR* ppDisplayableString);
    HRESULT get_CurrentCountryCode(int* CountryCode);
    HRESULT get_DestinationCountryCode(int* CountryCode);
    HRESULT get_TranslationResults(int* plResults);
}

const GUID IID_ITLocationInfo = {0x0C4D8EFF, 0x8DDB, 0x11D1, [0xA0, 0x9E, 0x00, 0x80, 0x5F, 0xC1, 0x47, 0xD3]};
@GUID(0x0C4D8EFF, 0x8DDB, 0x11D1, [0xA0, 0x9E, 0x00, 0x80, 0x5F, 0xC1, 0x47, 0xD3]);
interface ITLocationInfo : IDispatch
{
    HRESULT get_PermanentLocationID(int* plLocationID);
    HRESULT get_CountryCode(int* plCountryCode);
    HRESULT get_CountryID(int* plCountryID);
    HRESULT get_Options(int* plOptions);
    HRESULT get_PreferredCardID(int* plCardID);
    HRESULT get_LocationName(BSTR* ppLocationName);
    HRESULT get_CityCode(BSTR* ppCode);
    HRESULT get_LocalAccessCode(BSTR* ppCode);
    HRESULT get_LongDistanceAccessCode(BSTR* ppCode);
    HRESULT get_TollPrefixList(BSTR* ppTollList);
    HRESULT get_CancelCallWaitingCode(BSTR* ppCode);
}

const GUID IID_IEnumLocation = {0x0C4D8F01, 0x8DDB, 0x11D1, [0xA0, 0x9E, 0x00, 0x80, 0x5F, 0xC1, 0x47, 0xD3]};
@GUID(0x0C4D8F01, 0x8DDB, 0x11D1, [0xA0, 0x9E, 0x00, 0x80, 0x5F, 0xC1, 0x47, 0xD3]);
interface IEnumLocation : IUnknown
{
    HRESULT Next(uint celt, ITLocationInfo* ppElements, uint* pceltFetched);
    HRESULT Reset();
    HRESULT Skip(uint celt);
    HRESULT Clone(IEnumLocation* ppEnum);
}

const GUID IID_ITCallingCard = {0x0C4D8F00, 0x8DDB, 0x11D1, [0xA0, 0x9E, 0x00, 0x80, 0x5F, 0xC1, 0x47, 0xD3]};
@GUID(0x0C4D8F00, 0x8DDB, 0x11D1, [0xA0, 0x9E, 0x00, 0x80, 0x5F, 0xC1, 0x47, 0xD3]);
interface ITCallingCard : IDispatch
{
    HRESULT get_PermanentCardID(int* plCardID);
    HRESULT get_NumberOfDigits(int* plDigits);
    HRESULT get_Options(int* plOptions);
    HRESULT get_CardName(BSTR* ppCardName);
    HRESULT get_SameAreaDialingRule(BSTR* ppRule);
    HRESULT get_LongDistanceDialingRule(BSTR* ppRule);
    HRESULT get_InternationalDialingRule(BSTR* ppRule);
}

const GUID IID_IEnumCallingCard = {0x0C4D8F02, 0x8DDB, 0x11D1, [0xA0, 0x9E, 0x00, 0x80, 0x5F, 0xC1, 0x47, 0xD3]};
@GUID(0x0C4D8F02, 0x8DDB, 0x11D1, [0xA0, 0x9E, 0x00, 0x80, 0x5F, 0xC1, 0x47, 0xD3]);
interface IEnumCallingCard : IUnknown
{
    HRESULT Next(uint celt, ITCallingCard* ppElements, uint* pceltFetched);
    HRESULT Reset();
    HRESULT Skip(uint celt);
    HRESULT Clone(IEnumCallingCard* ppEnum);
}

const GUID IID_ITCallNotificationEvent = {0x895801DF, 0x3DD6, 0x11D1, [0x8F, 0x30, 0x00, 0xC0, 0x4F, 0xB6, 0x80, 0x9F]};
@GUID(0x895801DF, 0x3DD6, 0x11D1, [0x8F, 0x30, 0x00, 0xC0, 0x4F, 0xB6, 0x80, 0x9F]);
interface ITCallNotificationEvent : IDispatch
{
    HRESULT get_Call(ITCallInfo* ppCall);
    HRESULT get_Event(CALL_NOTIFICATION_EVENT* pCallNotificationEvent);
    HRESULT get_CallbackInstance(int* plCallbackInstance);
}

const GUID IID_ITDispatchMapper = {0xE9225295, 0xC759, 0x11D1, [0xA0, 0x2B, 0x00, 0xC0, 0x4F, 0xB6, 0x80, 0x9F]};
@GUID(0xE9225295, 0xC759, 0x11D1, [0xA0, 0x2B, 0x00, 0xC0, 0x4F, 0xB6, 0x80, 0x9F]);
interface ITDispatchMapper : IDispatch
{
    HRESULT QueryDispatchInterface(BSTR pIID, IDispatch pInterfaceToMap, IDispatch* ppReturnedInterface);
}

const GUID IID_ITStreamControl = {0xEE3BD604, 0x3868, 0x11D2, [0xA0, 0x45, 0x00, 0xC0, 0x4F, 0xB6, 0x80, 0x9F]};
@GUID(0xEE3BD604, 0x3868, 0x11D2, [0xA0, 0x45, 0x00, 0xC0, 0x4F, 0xB6, 0x80, 0x9F]);
interface ITStreamControl : IDispatch
{
    HRESULT CreateStream(int lMediaType, TERMINAL_DIRECTION td, ITStream* ppStream);
    HRESULT RemoveStream(ITStream pStream);
    HRESULT EnumerateStreams(IEnumStream* ppEnumStream);
    HRESULT get_Streams(VARIANT* pVariant);
}

const GUID IID_ITStream = {0xEE3BD605, 0x3868, 0x11D2, [0xA0, 0x45, 0x00, 0xC0, 0x4F, 0xB6, 0x80, 0x9F]};
@GUID(0xEE3BD605, 0x3868, 0x11D2, [0xA0, 0x45, 0x00, 0xC0, 0x4F, 0xB6, 0x80, 0x9F]);
interface ITStream : IDispatch
{
    HRESULT get_MediaType(int* plMediaType);
    HRESULT get_Direction(TERMINAL_DIRECTION* pTD);
    HRESULT get_Name(BSTR* ppName);
    HRESULT StartStream();
    HRESULT PauseStream();
    HRESULT StopStream();
    HRESULT SelectTerminal(ITTerminal pTerminal);
    HRESULT UnselectTerminal(ITTerminal pTerminal);
    HRESULT EnumerateTerminals(IEnumTerminal* ppEnumTerminal);
    HRESULT get_Terminals(VARIANT* pTerminals);
}

const GUID IID_IEnumStream = {0xEE3BD606, 0x3868, 0x11D2, [0xA0, 0x45, 0x00, 0xC0, 0x4F, 0xB6, 0x80, 0x9F]};
@GUID(0xEE3BD606, 0x3868, 0x11D2, [0xA0, 0x45, 0x00, 0xC0, 0x4F, 0xB6, 0x80, 0x9F]);
interface IEnumStream : IUnknown
{
    HRESULT Next(uint celt, ITStream* ppElements, uint* pceltFetched);
    HRESULT Reset();
    HRESULT Skip(uint celt);
    HRESULT Clone(IEnumStream* ppEnum);
}

const GUID IID_ITSubStreamControl = {0xEE3BD607, 0x3868, 0x11D2, [0xA0, 0x45, 0x00, 0xC0, 0x4F, 0xB6, 0x80, 0x9F]};
@GUID(0xEE3BD607, 0x3868, 0x11D2, [0xA0, 0x45, 0x00, 0xC0, 0x4F, 0xB6, 0x80, 0x9F]);
interface ITSubStreamControl : IDispatch
{
    HRESULT CreateSubStream(ITSubStream* ppSubStream);
    HRESULT RemoveSubStream(ITSubStream pSubStream);
    HRESULT EnumerateSubStreams(IEnumSubStream* ppEnumSubStream);
    HRESULT get_SubStreams(VARIANT* pVariant);
}

const GUID IID_ITSubStream = {0xEE3BD608, 0x3868, 0x11D2, [0xA0, 0x45, 0x00, 0xC0, 0x4F, 0xB6, 0x80, 0x9F]};
@GUID(0xEE3BD608, 0x3868, 0x11D2, [0xA0, 0x45, 0x00, 0xC0, 0x4F, 0xB6, 0x80, 0x9F]);
interface ITSubStream : IDispatch
{
    HRESULT StartSubStream();
    HRESULT PauseSubStream();
    HRESULT StopSubStream();
    HRESULT SelectTerminal(ITTerminal pTerminal);
    HRESULT UnselectTerminal(ITTerminal pTerminal);
    HRESULT EnumerateTerminals(IEnumTerminal* ppEnumTerminal);
    HRESULT get_Terminals(VARIANT* pTerminals);
    HRESULT get_Stream(ITStream* ppITStream);
}

const GUID IID_IEnumSubStream = {0xEE3BD609, 0x3868, 0x11D2, [0xA0, 0x45, 0x00, 0xC0, 0x4F, 0xB6, 0x80, 0x9F]};
@GUID(0xEE3BD609, 0x3868, 0x11D2, [0xA0, 0x45, 0x00, 0xC0, 0x4F, 0xB6, 0x80, 0x9F]);
interface IEnumSubStream : IUnknown
{
    HRESULT Next(uint celt, ITSubStream* ppElements, uint* pceltFetched);
    HRESULT Reset();
    HRESULT Skip(uint celt);
    HRESULT Clone(IEnumSubStream* ppEnum);
}

const GUID IID_ITLegacyWaveSupport = {0x207823EA, 0xE252, 0x11D2, [0xB7, 0x7E, 0x00, 0x80, 0xC7, 0x13, 0x53, 0x81]};
@GUID(0x207823EA, 0xE252, 0x11D2, [0xB7, 0x7E, 0x00, 0x80, 0xC7, 0x13, 0x53, 0x81]);
interface ITLegacyWaveSupport : IDispatch
{
    HRESULT IsFullDuplex(FULLDUPLEX_SUPPORT* pSupport);
}

const GUID IID_ITBasicCallControl2 = {0x161A4A56, 0x1E99, 0x4B3F, [0xA4, 0x6A, 0x16, 0x8F, 0x38, 0xA5, 0xEE, 0x4C]};
@GUID(0x161A4A56, 0x1E99, 0x4B3F, [0xA4, 0x6A, 0x16, 0x8F, 0x38, 0xA5, 0xEE, 0x4C]);
interface ITBasicCallControl2 : ITBasicCallControl
{
    HRESULT RequestTerminal(BSTR bstrTerminalClassGUID, int lMediaType, TERMINAL_DIRECTION Direction, ITTerminal* ppTerminal);
    HRESULT SelectTerminalOnCall(ITTerminal pTerminal);
    HRESULT UnselectTerminalOnCall(ITTerminal pTerminal);
}

const GUID IID_ITScriptableAudioFormat = {0xB87658BD, 0x3C59, 0x4F64, [0xBE, 0x74, 0xAE, 0xDE, 0x3E, 0x86, 0xA8, 0x1E]};
@GUID(0xB87658BD, 0x3C59, 0x4F64, [0xBE, 0x74, 0xAE, 0xDE, 0x3E, 0x86, 0xA8, 0x1E]);
interface ITScriptableAudioFormat : IDispatch
{
    HRESULT get_Channels(int* pVal);
    HRESULT put_Channels(const(int) nNewVal);
    HRESULT get_SamplesPerSec(int* pVal);
    HRESULT put_SamplesPerSec(const(int) nNewVal);
    HRESULT get_AvgBytesPerSec(int* pVal);
    HRESULT put_AvgBytesPerSec(const(int) nNewVal);
    HRESULT get_BlockAlign(int* pVal);
    HRESULT put_BlockAlign(const(int) nNewVal);
    HRESULT get_BitsPerSample(int* pVal);
    HRESULT put_BitsPerSample(const(int) nNewVal);
    HRESULT get_FormatTag(int* pVal);
    HRESULT put_FormatTag(const(int) nNewVal);
}

enum AGENT_EVENT
{
    AE_NOT_READY = 0,
    AE_READY = 1,
    AE_BUSY_ACD = 2,
    AE_BUSY_INCOMING = 3,
    AE_BUSY_OUTGOING = 4,
    AE_UNKNOWN = 5,
}

enum AGENT_STATE
{
    AS_NOT_READY = 0,
    AS_READY = 1,
    AS_BUSY_ACD = 2,
    AS_BUSY_INCOMING = 3,
    AS_BUSY_OUTGOING = 4,
    AS_UNKNOWN = 5,
}

enum AGENT_SESSION_EVENT
{
    ASE_NEW_SESSION = 0,
    ASE_NOT_READY = 1,
    ASE_READY = 2,
    ASE_BUSY = 3,
    ASE_WRAPUP = 4,
    ASE_END = 5,
}

enum AGENT_SESSION_STATE
{
    ASST_NOT_READY = 0,
    ASST_READY = 1,
    ASST_BUSY_ON_CALL = 2,
    ASST_BUSY_WRAPUP = 3,
    ASST_SESSION_ENDED = 4,
}

enum AGENTHANDLER_EVENT
{
    AHE_NEW_AGENTHANDLER = 0,
    AHE_AGENTHANDLER_REMOVED = 1,
}

enum ACDGROUP_EVENT
{
    ACDGE_NEW_GROUP = 0,
    ACDGE_GROUP_REMOVED = 1,
}

enum ACDQUEUE_EVENT
{
    ACDQE_NEW_QUEUE = 0,
    ACDQE_QUEUE_REMOVED = 1,
}

const GUID IID_ITAgent = {0x5770ECE5, 0x4B27, 0x11D1, [0xBF, 0x80, 0x00, 0x80, 0x5F, 0xC1, 0x47, 0xD3]};
@GUID(0x5770ECE5, 0x4B27, 0x11D1, [0xBF, 0x80, 0x00, 0x80, 0x5F, 0xC1, 0x47, 0xD3]);
interface ITAgent : IDispatch
{
    HRESULT EnumerateAgentSessions(IEnumAgentSession* ppEnumAgentSession);
    HRESULT CreateSession(ITACDGroup pACDGroup, ITAddress pAddress, ITAgentSession* ppAgentSession);
    HRESULT CreateSessionWithPIN(ITACDGroup pACDGroup, ITAddress pAddress, BSTR pPIN, ITAgentSession* ppAgentSession);
    HRESULT get_ID(BSTR* ppID);
    HRESULT get_User(BSTR* ppUser);
    HRESULT put_State(AGENT_STATE AgentState);
    HRESULT get_State(AGENT_STATE* pAgentState);
    HRESULT put_MeasurementPeriod(int lPeriod);
    HRESULT get_MeasurementPeriod(int* plPeriod);
    HRESULT get_OverallCallRate(CY* pcyCallrate);
    HRESULT get_NumberOfACDCalls(int* plCalls);
    HRESULT get_NumberOfIncomingCalls(int* plCalls);
    HRESULT get_NumberOfOutgoingCalls(int* plCalls);
    HRESULT get_TotalACDTalkTime(int* plTalkTime);
    HRESULT get_TotalACDCallTime(int* plCallTime);
    HRESULT get_TotalWrapUpTime(int* plWrapUpTime);
    HRESULT get_AgentSessions(VARIANT* pVariant);
}

const GUID IID_ITAgentSession = {0x5AFC3147, 0x4BCC, 0x11D1, [0xBF, 0x80, 0x00, 0x80, 0x5F, 0xC1, 0x47, 0xD3]};
@GUID(0x5AFC3147, 0x4BCC, 0x11D1, [0xBF, 0x80, 0x00, 0x80, 0x5F, 0xC1, 0x47, 0xD3]);
interface ITAgentSession : IDispatch
{
    HRESULT get_Agent(ITAgent* ppAgent);
    HRESULT get_Address(ITAddress* ppAddress);
    HRESULT get_ACDGroup(ITACDGroup* ppACDGroup);
    HRESULT put_State(AGENT_SESSION_STATE SessionState);
    HRESULT get_State(AGENT_SESSION_STATE* pSessionState);
    HRESULT get_SessionStartTime(double* pdateSessionStart);
    HRESULT get_SessionDuration(int* plDuration);
    HRESULT get_NumberOfCalls(int* plCalls);
    HRESULT get_TotalTalkTime(int* plTalkTime);
    HRESULT get_AverageTalkTime(int* plTalkTime);
    HRESULT get_TotalCallTime(int* plCallTime);
    HRESULT get_AverageCallTime(int* plCallTime);
    HRESULT get_TotalWrapUpTime(int* plWrapUpTime);
    HRESULT get_AverageWrapUpTime(int* plWrapUpTime);
    HRESULT get_ACDCallRate(CY* pcyCallrate);
    HRESULT get_LongestTimeToAnswer(int* plAnswerTime);
    HRESULT get_AverageTimeToAnswer(int* plAnswerTime);
}

const GUID IID_ITACDGroup = {0x5AFC3148, 0x4BCC, 0x11D1, [0xBF, 0x80, 0x00, 0x80, 0x5F, 0xC1, 0x47, 0xD3]};
@GUID(0x5AFC3148, 0x4BCC, 0x11D1, [0xBF, 0x80, 0x00, 0x80, 0x5F, 0xC1, 0x47, 0xD3]);
interface ITACDGroup : IDispatch
{
    HRESULT get_Name(BSTR* ppName);
    HRESULT EnumerateQueues(IEnumQueue* ppEnumQueue);
    HRESULT get_Queues(VARIANT* pVariant);
}

const GUID IID_ITQueue = {0x5AFC3149, 0x4BCC, 0x11D1, [0xBF, 0x80, 0x00, 0x80, 0x5F, 0xC1, 0x47, 0xD3]};
@GUID(0x5AFC3149, 0x4BCC, 0x11D1, [0xBF, 0x80, 0x00, 0x80, 0x5F, 0xC1, 0x47, 0xD3]);
interface ITQueue : IDispatch
{
    HRESULT put_MeasurementPeriod(int lPeriod);
    HRESULT get_MeasurementPeriod(int* plPeriod);
    HRESULT get_TotalCallsQueued(int* plCalls);
    HRESULT get_CurrentCallsQueued(int* plCalls);
    HRESULT get_TotalCallsAbandoned(int* plCalls);
    HRESULT get_TotalCallsFlowedIn(int* plCalls);
    HRESULT get_TotalCallsFlowedOut(int* plCalls);
    HRESULT get_LongestEverWaitTime(int* plWaitTime);
    HRESULT get_CurrentLongestWaitTime(int* plWaitTime);
    HRESULT get_AverageWaitTime(int* plWaitTime);
    HRESULT get_FinalDisposition(int* plCalls);
    HRESULT get_Name(BSTR* ppName);
}

const GUID IID_ITAgentEvent = {0x5AFC314A, 0x4BCC, 0x11D1, [0xBF, 0x80, 0x00, 0x80, 0x5F, 0xC1, 0x47, 0xD3]};
@GUID(0x5AFC314A, 0x4BCC, 0x11D1, [0xBF, 0x80, 0x00, 0x80, 0x5F, 0xC1, 0x47, 0xD3]);
interface ITAgentEvent : IDispatch
{
    HRESULT get_Agent(ITAgent* ppAgent);
    HRESULT get_Event(AGENT_EVENT* pEvent);
}

const GUID IID_ITAgentSessionEvent = {0x5AFC314B, 0x4BCC, 0x11D1, [0xBF, 0x80, 0x00, 0x80, 0x5F, 0xC1, 0x47, 0xD3]};
@GUID(0x5AFC314B, 0x4BCC, 0x11D1, [0xBF, 0x80, 0x00, 0x80, 0x5F, 0xC1, 0x47, 0xD3]);
interface ITAgentSessionEvent : IDispatch
{
    HRESULT get_Session(ITAgentSession* ppSession);
    HRESULT get_Event(AGENT_SESSION_EVENT* pEvent);
}

const GUID IID_ITACDGroupEvent = {0x297F3032, 0xBD11, 0x11D1, [0xA0, 0xA7, 0x00, 0x80, 0x5F, 0xC1, 0x47, 0xD3]};
@GUID(0x297F3032, 0xBD11, 0x11D1, [0xA0, 0xA7, 0x00, 0x80, 0x5F, 0xC1, 0x47, 0xD3]);
interface ITACDGroupEvent : IDispatch
{
    HRESULT get_Group(ITACDGroup* ppGroup);
    HRESULT get_Event(ACDGROUP_EVENT* pEvent);
}

const GUID IID_ITQueueEvent = {0x297F3033, 0xBD11, 0x11D1, [0xA0, 0xA7, 0x00, 0x80, 0x5F, 0xC1, 0x47, 0xD3]};
@GUID(0x297F3033, 0xBD11, 0x11D1, [0xA0, 0xA7, 0x00, 0x80, 0x5F, 0xC1, 0x47, 0xD3]);
interface ITQueueEvent : IDispatch
{
    HRESULT get_Queue(ITQueue* ppQueue);
    HRESULT get_Event(ACDQUEUE_EVENT* pEvent);
}

const GUID IID_ITAgentHandlerEvent = {0x297F3034, 0xBD11, 0x11D1, [0xA0, 0xA7, 0x00, 0x80, 0x5F, 0xC1, 0x47, 0xD3]};
@GUID(0x297F3034, 0xBD11, 0x11D1, [0xA0, 0xA7, 0x00, 0x80, 0x5F, 0xC1, 0x47, 0xD3]);
interface ITAgentHandlerEvent : IDispatch
{
    HRESULT get_AgentHandler(ITAgentHandler* ppAgentHandler);
    HRESULT get_Event(AGENTHANDLER_EVENT* pEvent);
}

const GUID IID_ITTAPICallCenter = {0x5AFC3154, 0x4BCC, 0x11D1, [0xBF, 0x80, 0x00, 0x80, 0x5F, 0xC1, 0x47, 0xD3]};
@GUID(0x5AFC3154, 0x4BCC, 0x11D1, [0xBF, 0x80, 0x00, 0x80, 0x5F, 0xC1, 0x47, 0xD3]);
interface ITTAPICallCenter : IDispatch
{
    HRESULT EnumerateAgentHandlers(IEnumAgentHandler* ppEnumHandler);
    HRESULT get_AgentHandlers(VARIANT* pVariant);
}

const GUID IID_ITAgentHandler = {0x587E8C22, 0x9802, 0x11D1, [0xA0, 0xA4, 0x00, 0x80, 0x5F, 0xC1, 0x47, 0xD3]};
@GUID(0x587E8C22, 0x9802, 0x11D1, [0xA0, 0xA4, 0x00, 0x80, 0x5F, 0xC1, 0x47, 0xD3]);
interface ITAgentHandler : IDispatch
{
    HRESULT get_Name(BSTR* ppName);
    HRESULT CreateAgent(ITAgent* ppAgent);
    HRESULT CreateAgentWithID(BSTR pID, BSTR pPIN, ITAgent* ppAgent);
    HRESULT EnumerateACDGroups(IEnumACDGroup* ppEnumACDGroup);
    HRESULT EnumerateUsableAddresses(IEnumAddress* ppEnumAddress);
    HRESULT get_ACDGroups(VARIANT* pVariant);
    HRESULT get_UsableAddresses(VARIANT* pVariant);
}

const GUID IID_IEnumAgent = {0x5AFC314D, 0x4BCC, 0x11D1, [0xBF, 0x80, 0x00, 0x80, 0x5F, 0xC1, 0x47, 0xD3]};
@GUID(0x5AFC314D, 0x4BCC, 0x11D1, [0xBF, 0x80, 0x00, 0x80, 0x5F, 0xC1, 0x47, 0xD3]);
interface IEnumAgent : IUnknown
{
    HRESULT Next(uint celt, ITAgent* ppElements, uint* pceltFetched);
    HRESULT Reset();
    HRESULT Skip(uint celt);
    HRESULT Clone(IEnumAgent* ppEnum);
}

const GUID IID_IEnumAgentSession = {0x5AFC314E, 0x4BCC, 0x11D1, [0xBF, 0x80, 0x00, 0x80, 0x5F, 0xC1, 0x47, 0xD3]};
@GUID(0x5AFC314E, 0x4BCC, 0x11D1, [0xBF, 0x80, 0x00, 0x80, 0x5F, 0xC1, 0x47, 0xD3]);
interface IEnumAgentSession : IUnknown
{
    HRESULT Next(uint celt, ITAgentSession* ppElements, uint* pceltFetched);
    HRESULT Reset();
    HRESULT Skip(uint celt);
    HRESULT Clone(IEnumAgentSession* ppEnum);
}

const GUID IID_IEnumQueue = {0x5AFC3158, 0x4BCC, 0x11D1, [0xBF, 0x80, 0x00, 0x80, 0x5F, 0xC1, 0x47, 0xD3]};
@GUID(0x5AFC3158, 0x4BCC, 0x11D1, [0xBF, 0x80, 0x00, 0x80, 0x5F, 0xC1, 0x47, 0xD3]);
interface IEnumQueue : IUnknown
{
    HRESULT Next(uint celt, ITQueue* ppElements, uint* pceltFetched);
    HRESULT Reset();
    HRESULT Skip(uint celt);
    HRESULT Clone(IEnumQueue* ppEnum);
}

const GUID IID_IEnumACDGroup = {0x5AFC3157, 0x4BCC, 0x11D1, [0xBF, 0x80, 0x00, 0x80, 0x5F, 0xC1, 0x47, 0xD3]};
@GUID(0x5AFC3157, 0x4BCC, 0x11D1, [0xBF, 0x80, 0x00, 0x80, 0x5F, 0xC1, 0x47, 0xD3]);
interface IEnumACDGroup : IUnknown
{
    HRESULT Next(uint celt, ITACDGroup* ppElements, uint* pceltFetched);
    HRESULT Reset();
    HRESULT Skip(uint celt);
    HRESULT Clone(IEnumACDGroup* ppEnum);
}

const GUID IID_IEnumAgentHandler = {0x587E8C28, 0x9802, 0x11D1, [0xA0, 0xA4, 0x00, 0x80, 0x5F, 0xC1, 0x47, 0xD3]};
@GUID(0x587E8C28, 0x9802, 0x11D1, [0xA0, 0xA4, 0x00, 0x80, 0x5F, 0xC1, 0x47, 0xD3]);
interface IEnumAgentHandler : IUnknown
{
    HRESULT Next(uint celt, ITAgentHandler* ppElements, uint* pceltFetched);
    HRESULT Reset();
    HRESULT Skip(uint celt);
    HRESULT Clone(IEnumAgentHandler* ppEnum);
}

const GUID IID_ITAMMediaFormat = {0x0364EB00, 0x4A77, 0x11D1, [0xA6, 0x71, 0x00, 0x60, 0x97, 0xC9, 0xA2, 0xE8]};
@GUID(0x0364EB00, 0x4A77, 0x11D1, [0xA6, 0x71, 0x00, 0x60, 0x97, 0xC9, 0xA2, 0xE8]);
interface ITAMMediaFormat : IUnknown
{
    HRESULT get_MediaFormat(AM_MEDIA_TYPE** ppmt);
    HRESULT put_MediaFormat(const(AM_MEDIA_TYPE)* pmt);
}

const GUID IID_ITAllocatorProperties = {0xC1BC3C90, 0xBCFE, 0x11D1, [0x97, 0x45, 0x00, 0xC0, 0x4F, 0xD9, 0x1A, 0xC0]};
@GUID(0xC1BC3C90, 0xBCFE, 0x11D1, [0x97, 0x45, 0x00, 0xC0, 0x4F, 0xD9, 0x1A, 0xC0]);
interface ITAllocatorProperties : IUnknown
{
    HRESULT SetAllocatorProperties(ALLOCATOR_PROPERTIES* pAllocProperties);
    HRESULT GetAllocatorProperties(ALLOCATOR_PROPERTIES* pAllocProperties);
    HRESULT SetAllocateBuffers(BOOL bAllocBuffers);
    HRESULT GetAllocateBuffers(int* pbAllocBuffers);
    HRESULT SetBufferSize(uint BufferSize);
    HRESULT GetBufferSize(uint* pBufferSize);
}

enum MSP_ADDRESS_EVENT
{
    ADDRESS_TERMINAL_AVAILABLE = 0,
    ADDRESS_TERMINAL_UNAVAILABLE = 1,
}

enum MSP_CALL_EVENT
{
    CALL_NEW_STREAM = 0,
    CALL_STREAM_FAIL = 1,
    CALL_TERMINAL_FAIL = 2,
    CALL_STREAM_NOT_USED = 3,
    CALL_STREAM_ACTIVE = 4,
    CALL_STREAM_INACTIVE = 5,
}

enum MSP_CALL_EVENT_CAUSE
{
    CALL_CAUSE_UNKNOWN = 0,
    CALL_CAUSE_BAD_DEVICE = 1,
    CALL_CAUSE_CONNECT_FAIL = 2,
    CALL_CAUSE_LOCAL_REQUEST = 3,
    CALL_CAUSE_REMOTE_REQUEST = 4,
    CALL_CAUSE_MEDIA_TIMEOUT = 5,
    CALL_CAUSE_MEDIA_RECOVERED = 6,
    CALL_CAUSE_QUALITY_OF_SERVICE = 7,
}

enum MSP_EVENT
{
    ME_ADDRESS_EVENT = 0,
    ME_CALL_EVENT = 1,
    ME_TSP_DATA = 2,
    ME_PRIVATE_EVENT = 3,
    ME_ASR_TERMINAL_EVENT = 4,
    ME_TTS_TERMINAL_EVENT = 5,
    ME_FILE_TERMINAL_EVENT = 6,
    ME_TONE_TERMINAL_EVENT = 7,
}

struct MSP_EVENT_INFO
{
    uint dwSize;
    MSP_EVENT Event;
    int* hCall;
    _Anonymous_e__Union Anonymous;
}

const GUID IID_ITPluggableTerminalEventSink = {0x6E0887BE, 0xBA1A, 0x492E, [0xBD, 0x10, 0x40, 0x20, 0xEC, 0x5E, 0x33, 0xE0]};
@GUID(0x6E0887BE, 0xBA1A, 0x492E, [0xBD, 0x10, 0x40, 0x20, 0xEC, 0x5E, 0x33, 0xE0]);
interface ITPluggableTerminalEventSink : IUnknown
{
    HRESULT FireEvent(const(MSP_EVENT_INFO)* pMspEventInfo);
}

const GUID IID_ITPluggableTerminalEventSinkRegistration = {0xF7115709, 0xA216, 0x4957, [0xA7, 0x59, 0x06, 0x0A, 0xB3, 0x2A, 0x90, 0xD1]};
@GUID(0xF7115709, 0xA216, 0x4957, [0xA7, 0x59, 0x06, 0x0A, 0xB3, 0x2A, 0x90, 0xD1]);
interface ITPluggableTerminalEventSinkRegistration : IUnknown
{
    HRESULT RegisterSink(ITPluggableTerminalEventSink pEventSink);
    HRESULT UnregisterSink();
}

const GUID IID_ITMSPAddress = {0xEE3BD600, 0x3868, 0x11D2, [0xA0, 0x45, 0x00, 0xC0, 0x4F, 0xB6, 0x80, 0x9F]};
@GUID(0xEE3BD600, 0x3868, 0x11D2, [0xA0, 0x45, 0x00, 0xC0, 0x4F, 0xB6, 0x80, 0x9F]);
interface ITMSPAddress : IUnknown
{
    HRESULT Initialize(int* hEvent);
    HRESULT Shutdown();
    HRESULT CreateMSPCall(int* hCall, uint dwReserved, uint dwMediaType, IUnknown pOuterUnknown, IUnknown* ppStreamControl);
    HRESULT ShutdownMSPCall(IUnknown pStreamControl);
    HRESULT ReceiveTSPData(IUnknown pMSPCall, char* pBuffer, uint dwSize);
    HRESULT GetEvent(uint* pdwSize, char* pEventBuffer);
}

const GUID IID_ITTAPIDispatchEventNotification = {0x9F34325B, 0x7E62, 0x11D2, [0x94, 0x57, 0x00, 0xC0, 0x4F, 0x8E, 0xC8, 0x88]};
@GUID(0x9F34325B, 0x7E62, 0x11D2, [0x94, 0x57, 0x00, 0xC0, 0x4F, 0x8E, 0xC8, 0x88]);
interface ITTAPIDispatchEventNotification : IDispatch
{
}

const GUID CLSID_Rendezvous = {0xF1029E5B, 0xCB5B, 0x11D0, [0x8D, 0x59, 0x00, 0xC0, 0x4F, 0xD9, 0x1A, 0xC0]};
@GUID(0xF1029E5B, 0xCB5B, 0x11D0, [0x8D, 0x59, 0x00, 0xC0, 0x4F, 0xD9, 0x1A, 0xC0]);
struct Rendezvous;

enum DIRECTORY_TYPE
{
    DT_NTDS = 1,
    DT_ILS = 2,
}

enum DIRECTORY_OBJECT_TYPE
{
    OT_CONFERENCE = 1,
    OT_USER = 2,
}

enum RND_ADVERTISING_SCOPE
{
    RAS_LOCAL = 1,
    RAS_SITE = 2,
    RAS_REGION = 3,
    RAS_WORLD = 4,
}

const GUID IID_ITDirectoryObjectConference = {0xF1029E5D, 0xCB5B, 0x11D0, [0x8D, 0x59, 0x00, 0xC0, 0x4F, 0xD9, 0x1A, 0xC0]};
@GUID(0xF1029E5D, 0xCB5B, 0x11D0, [0x8D, 0x59, 0x00, 0xC0, 0x4F, 0xD9, 0x1A, 0xC0]);
interface ITDirectoryObjectConference : IDispatch
{
    HRESULT get_Protocol(BSTR* ppProtocol);
    HRESULT get_Originator(BSTR* ppOriginator);
    HRESULT put_Originator(BSTR pOriginator);
    HRESULT get_AdvertisingScope(RND_ADVERTISING_SCOPE* pAdvertisingScope);
    HRESULT put_AdvertisingScope(RND_ADVERTISING_SCOPE AdvertisingScope);
    HRESULT get_Url(BSTR* ppUrl);
    HRESULT put_Url(BSTR pUrl);
    HRESULT get_Description(BSTR* ppDescription);
    HRESULT put_Description(BSTR pDescription);
    HRESULT get_IsEncrypted(short* pfEncrypted);
    HRESULT put_IsEncrypted(short fEncrypted);
    HRESULT get_StartTime(double* pDate);
    HRESULT put_StartTime(double Date);
    HRESULT get_StopTime(double* pDate);
    HRESULT put_StopTime(double Date);
}

const GUID IID_ITDirectoryObjectUser = {0x34621D6F, 0x6CFF, 0x11D1, [0xAF, 0xF7, 0x00, 0xC0, 0x4F, 0xC3, 0x1F, 0xEE]};
@GUID(0x34621D6F, 0x6CFF, 0x11D1, [0xAF, 0xF7, 0x00, 0xC0, 0x4F, 0xC3, 0x1F, 0xEE]);
interface ITDirectoryObjectUser : IDispatch
{
    HRESULT get_IPPhonePrimary(BSTR* ppName);
    HRESULT put_IPPhonePrimary(BSTR pName);
}

const GUID IID_IEnumDialableAddrs = {0x34621D70, 0x6CFF, 0x11D1, [0xAF, 0xF7, 0x00, 0xC0, 0x4F, 0xC3, 0x1F, 0xEE]};
@GUID(0x34621D70, 0x6CFF, 0x11D1, [0xAF, 0xF7, 0x00, 0xC0, 0x4F, 0xC3, 0x1F, 0xEE]);
interface IEnumDialableAddrs : IUnknown
{
    HRESULT Next(uint celt, char* ppElements, uint* pcFetched);
    HRESULT Reset();
    HRESULT Skip(uint celt);
    HRESULT Clone(IEnumDialableAddrs* ppEnum);
}

const GUID IID_ITDirectoryObject = {0x34621D6E, 0x6CFF, 0x11D1, [0xAF, 0xF7, 0x00, 0xC0, 0x4F, 0xC3, 0x1F, 0xEE]};
@GUID(0x34621D6E, 0x6CFF, 0x11D1, [0xAF, 0xF7, 0x00, 0xC0, 0x4F, 0xC3, 0x1F, 0xEE]);
interface ITDirectoryObject : IDispatch
{
    HRESULT get_ObjectType(DIRECTORY_OBJECT_TYPE* pObjectType);
    HRESULT get_Name(BSTR* ppName);
    HRESULT put_Name(BSTR pName);
    HRESULT get_DialableAddrs(int dwAddressType, VARIANT* pVariant);
    HRESULT EnumerateDialableAddrs(uint dwAddressType, IEnumDialableAddrs* ppEnumDialableAddrs);
    HRESULT get_SecurityDescriptor(IDispatch* ppSecDes);
    HRESULT put_SecurityDescriptor(IDispatch pSecDes);
}

const GUID IID_IEnumDirectoryObject = {0x06C9B64A, 0x306D, 0x11D1, [0x97, 0x74, 0x00, 0xC0, 0x4F, 0xD9, 0x1A, 0xC0]};
@GUID(0x06C9B64A, 0x306D, 0x11D1, [0x97, 0x74, 0x00, 0xC0, 0x4F, 0xD9, 0x1A, 0xC0]);
interface IEnumDirectoryObject : IUnknown
{
    HRESULT Next(uint celt, char* pVal, uint* pcFetched);
    HRESULT Reset();
    HRESULT Skip(uint celt);
    HRESULT Clone(IEnumDirectoryObject* ppEnum);
}

const GUID IID_ITILSConfig = {0x34621D72, 0x6CFF, 0x11D1, [0xAF, 0xF7, 0x00, 0xC0, 0x4F, 0xC3, 0x1F, 0xEE]};
@GUID(0x34621D72, 0x6CFF, 0x11D1, [0xAF, 0xF7, 0x00, 0xC0, 0x4F, 0xC3, 0x1F, 0xEE]);
interface ITILSConfig : IDispatch
{
    HRESULT get_Port(int* pPort);
    HRESULT put_Port(int Port);
}

const GUID IID_ITDirectory = {0x34621D6C, 0x6CFF, 0x11D1, [0xAF, 0xF7, 0x00, 0xC0, 0x4F, 0xC3, 0x1F, 0xEE]};
@GUID(0x34621D6C, 0x6CFF, 0x11D1, [0xAF, 0xF7, 0x00, 0xC0, 0x4F, 0xC3, 0x1F, 0xEE]);
interface ITDirectory : IDispatch
{
    HRESULT get_DirectoryType(DIRECTORY_TYPE* pDirectoryType);
    HRESULT get_DisplayName(BSTR* pName);
    HRESULT get_IsDynamic(short* pfDynamic);
    HRESULT get_DefaultObjectTTL(int* pTTL);
    HRESULT put_DefaultObjectTTL(int TTL);
    HRESULT EnableAutoRefresh(short fEnable);
    HRESULT Connect(short fSecure);
    HRESULT Bind(BSTR pDomainName, BSTR pUserName, BSTR pPassword, int lFlags);
    HRESULT AddDirectoryObject(ITDirectoryObject pDirectoryObject);
    HRESULT ModifyDirectoryObject(ITDirectoryObject pDirectoryObject);
    HRESULT RefreshDirectoryObject(ITDirectoryObject pDirectoryObject);
    HRESULT DeleteDirectoryObject(ITDirectoryObject pDirectoryObject);
    HRESULT get_DirectoryObjects(DIRECTORY_OBJECT_TYPE DirectoryObjectType, BSTR pName, VARIANT* pVariant);
    HRESULT EnumerateDirectoryObjects(DIRECTORY_OBJECT_TYPE DirectoryObjectType, BSTR pName, IEnumDirectoryObject* ppEnumObject);
}

const GUID IID_IEnumDirectory = {0x34621D6D, 0x6CFF, 0x11D1, [0xAF, 0xF7, 0x00, 0xC0, 0x4F, 0xC3, 0x1F, 0xEE]};
@GUID(0x34621D6D, 0x6CFF, 0x11D1, [0xAF, 0xF7, 0x00, 0xC0, 0x4F, 0xC3, 0x1F, 0xEE]);
interface IEnumDirectory : IUnknown
{
    HRESULT Next(uint celt, char* ppElements, uint* pcFetched);
    HRESULT Reset();
    HRESULT Skip(uint celt);
    HRESULT Clone(IEnumDirectory* ppEnum);
}

const GUID IID_ITRendezvous = {0x34621D6B, 0x6CFF, 0x11D1, [0xAF, 0xF7, 0x00, 0xC0, 0x4F, 0xC3, 0x1F, 0xEE]};
@GUID(0x34621D6B, 0x6CFF, 0x11D1, [0xAF, 0xF7, 0x00, 0xC0, 0x4F, 0xC3, 0x1F, 0xEE]);
interface ITRendezvous : IDispatch
{
    HRESULT get_DefaultDirectories(VARIANT* pVariant);
    HRESULT EnumerateDefaultDirectories(IEnumDirectory* ppEnumDirectory);
    HRESULT CreateDirectoryA(DIRECTORY_TYPE DirectoryType, BSTR pName, ITDirectory* ppDir);
    HRESULT CreateDirectoryObject(DIRECTORY_OBJECT_TYPE DirectoryObjectType, BSTR pName, ITDirectoryObject* ppDirectoryObject);
}

const GUID CLSID_McastAddressAllocation = {0xDF0DAEF2, 0xA289, 0x11D1, [0x86, 0x97, 0x00, 0x60, 0x08, 0xB0, 0xE5, 0xD2]};
@GUID(0xDF0DAEF2, 0xA289, 0x11D1, [0x86, 0x97, 0x00, 0x60, 0x08, 0xB0, 0xE5, 0xD2]);
struct McastAddressAllocation;

const GUID IID_IMcastScope = {0xDF0DAEF4, 0xA289, 0x11D1, [0x86, 0x97, 0x00, 0x60, 0x08, 0xB0, 0xE5, 0xD2]};
@GUID(0xDF0DAEF4, 0xA289, 0x11D1, [0x86, 0x97, 0x00, 0x60, 0x08, 0xB0, 0xE5, 0xD2]);
interface IMcastScope : IDispatch
{
    HRESULT get_ScopeID(int* pID);
    HRESULT get_ServerID(int* pID);
    HRESULT get_InterfaceID(int* pID);
    HRESULT get_ScopeDescription(BSTR* ppDescription);
    HRESULT get_TTL(int* pTTL);
}

const GUID IID_IMcastLeaseInfo = {0xDF0DAEFD, 0xA289, 0x11D1, [0x86, 0x97, 0x00, 0x60, 0x08, 0xB0, 0xE5, 0xD2]};
@GUID(0xDF0DAEFD, 0xA289, 0x11D1, [0x86, 0x97, 0x00, 0x60, 0x08, 0xB0, 0xE5, 0xD2]);
interface IMcastLeaseInfo : IDispatch
{
    HRESULT get_RequestID(BSTR* ppRequestID);
    HRESULT get_LeaseStartTime(double* pTime);
    HRESULT put_LeaseStartTime(double time);
    HRESULT get_LeaseStopTime(double* pTime);
    HRESULT put_LeaseStopTime(double time);
    HRESULT get_AddressCount(int* pCount);
    HRESULT get_ServerAddress(BSTR* ppAddress);
    HRESULT get_TTL(int* pTTL);
    HRESULT get_Addresses(VARIANT* pVariant);
    HRESULT EnumerateAddresses(IEnumBstr* ppEnumAddresses);
}

const GUID IID_IEnumMcastScope = {0xDF0DAF09, 0xA289, 0x11D1, [0x86, 0x97, 0x00, 0x60, 0x08, 0xB0, 0xE5, 0xD2]};
@GUID(0xDF0DAF09, 0xA289, 0x11D1, [0x86, 0x97, 0x00, 0x60, 0x08, 0xB0, 0xE5, 0xD2]);
interface IEnumMcastScope : IUnknown
{
    HRESULT Next(uint celt, IMcastScope* ppScopes, uint* pceltFetched);
    HRESULT Reset();
    HRESULT Skip(uint celt);
    HRESULT Clone(IEnumMcastScope* ppEnum);
}

const GUID IID_IMcastAddressAllocation = {0xDF0DAEF1, 0xA289, 0x11D1, [0x86, 0x97, 0x00, 0x60, 0x08, 0xB0, 0xE5, 0xD2]};
@GUID(0xDF0DAEF1, 0xA289, 0x11D1, [0x86, 0x97, 0x00, 0x60, 0x08, 0xB0, 0xE5, 0xD2]);
interface IMcastAddressAllocation : IDispatch
{
    HRESULT get_Scopes(VARIANT* pVariant);
    HRESULT EnumerateScopes(IEnumMcastScope* ppEnumMcastScope);
    HRESULT RequestAddress(IMcastScope pScope, double LeaseStartTime, double LeaseStopTime, int NumAddresses, IMcastLeaseInfo* ppLeaseResponse);
    HRESULT RenewAddress(int lReserved, IMcastLeaseInfo pRenewRequest, IMcastLeaseInfo* ppRenewResponse);
    HRESULT ReleaseAddress(IMcastLeaseInfo pReleaseRequest);
    HRESULT CreateLeaseInfo(double LeaseStartTime, double LeaseStopTime, uint dwNumAddresses, ushort** ppAddresses, const(wchar)* pRequestID, const(wchar)* pServerAddress, IMcastLeaseInfo* ppReleaseRequest);
    HRESULT CreateLeaseInfoFromVariant(double LeaseStartTime, double LeaseStopTime, VARIANT vAddresses, BSTR pRequestID, BSTR pServerAddress, IMcastLeaseInfo* ppReleaseRequest);
}

@DllImport("TAPI32.dll")
int lineAccept(uint hCall, const(char)* lpsUserUserInfo, uint dwSize);

@DllImport("TAPI32.dll")
int lineAddProvider(const(char)* lpszProviderFilename, HWND hwndOwner, uint* lpdwPermanentProviderID);

@DllImport("TAPI32.dll")
int lineAddProviderA(const(char)* lpszProviderFilename, HWND hwndOwner, uint* lpdwPermanentProviderID);

@DllImport("TAPI32.dll")
int lineAddProviderW(const(wchar)* lpszProviderFilename, HWND hwndOwner, uint* lpdwPermanentProviderID);

@DllImport("TAPI32.dll")
int lineAddToConference(uint hConfCall, uint hConsultCall);

@DllImport("TAPI32.dll")
int lineAgentSpecific(uint hLine, uint dwAddressID, uint dwAgentExtensionIDIndex, void* lpParams, uint dwSize);

@DllImport("TAPI32.dll")
int lineAnswer(uint hCall, const(char)* lpsUserUserInfo, uint dwSize);

@DllImport("TAPI32.dll")
int lineBlindTransfer(uint hCall, const(char)* lpszDestAddress, uint dwCountryCode);

@DllImport("TAPI32.dll")
int lineBlindTransferA(uint hCall, const(char)* lpszDestAddress, uint dwCountryCode);

@DllImport("TAPI32.dll")
int lineBlindTransferW(uint hCall, const(wchar)* lpszDestAddressW, uint dwCountryCode);

@DllImport("TAPI32.dll")
int lineClose(uint hLine);

@DllImport("TAPI32.dll")
int lineCompleteCall(uint hCall, uint* lpdwCompletionID, uint dwCompletionMode, uint dwMessageID);

@DllImport("TAPI32.dll")
int lineCompleteTransfer(uint hCall, uint hConsultCall, uint* lphConfCall, uint dwTransferMode);

@DllImport("TAPI32.dll")
int lineConfigDialog(uint dwDeviceID, HWND hwndOwner, const(char)* lpszDeviceClass);

@DllImport("TAPI32.dll")
int lineConfigDialogA(uint dwDeviceID, HWND hwndOwner, const(char)* lpszDeviceClass);

@DllImport("TAPI32.dll")
int lineConfigDialogW(uint dwDeviceID, HWND hwndOwner, const(wchar)* lpszDeviceClass);

@DllImport("TAPI32.dll")
int lineConfigDialogEdit(uint dwDeviceID, HWND hwndOwner, const(char)* lpszDeviceClass, const(void)* lpDeviceConfigIn, uint dwSize, VARSTRING* lpDeviceConfigOut);

@DllImport("TAPI32.dll")
int lineConfigDialogEditA(uint dwDeviceID, HWND hwndOwner, const(char)* lpszDeviceClass, const(void)* lpDeviceConfigIn, uint dwSize, VARSTRING* lpDeviceConfigOut);

@DllImport("TAPI32.dll")
int lineConfigDialogEditW(uint dwDeviceID, HWND hwndOwner, const(wchar)* lpszDeviceClass, const(void)* lpDeviceConfigIn, uint dwSize, VARSTRING* lpDeviceConfigOut);

@DllImport("TAPI32.dll")
int lineConfigProvider(HWND hwndOwner, uint dwPermanentProviderID);

@DllImport("TAPI32.dll")
int lineCreateAgentW(uint hLine, const(wchar)* lpszAgentID, const(wchar)* lpszAgentPIN, uint* lphAgent);

@DllImport("TAPI32.dll")
int lineCreateAgentA(uint hLine, const(char)* lpszAgentID, const(char)* lpszAgentPIN, uint* lphAgent);

@DllImport("TAPI32.dll")
int lineCreateAgentSessionW(uint hLine, uint hAgent, const(wchar)* lpszAgentPIN, uint dwWorkingAddressID, Guid* lpGroupID, uint* lphAgentSession);

@DllImport("TAPI32.dll")
int lineCreateAgentSessionA(uint hLine, uint hAgent, const(char)* lpszAgentPIN, uint dwWorkingAddressID, Guid* lpGroupID, uint* lphAgentSession);

@DllImport("TAPI32.dll")
int lineDeallocateCall(uint hCall);

@DllImport("TAPI32.dll")
int lineDevSpecific(uint hLine, uint dwAddressID, uint hCall, void* lpParams, uint dwSize);

@DllImport("TAPI32.dll")
int lineDevSpecificFeature(uint hLine, uint dwFeature, void* lpParams, uint dwSize);

@DllImport("TAPI32.dll")
int lineDial(uint hCall, const(char)* lpszDestAddress, uint dwCountryCode);

@DllImport("TAPI32.dll")
int lineDialA(uint hCall, const(char)* lpszDestAddress, uint dwCountryCode);

@DllImport("TAPI32.dll")
int lineDialW(uint hCall, const(wchar)* lpszDestAddress, uint dwCountryCode);

@DllImport("TAPI32.dll")
int lineDrop(uint hCall, const(char)* lpsUserUserInfo, uint dwSize);

@DllImport("TAPI32.dll")
int lineForward(uint hLine, uint bAllAddresses, uint dwAddressID, const(LINEFORWARDLIST)* lpForwardList, uint dwNumRingsNoAnswer, uint* lphConsultCall, const(LINECALLPARAMS)* lpCallParams);

@DllImport("TAPI32.dll")
int lineForwardA(uint hLine, uint bAllAddresses, uint dwAddressID, const(LINEFORWARDLIST)* lpForwardList, uint dwNumRingsNoAnswer, uint* lphConsultCall, const(LINECALLPARAMS)* lpCallParams);

@DllImport("TAPI32.dll")
int lineForwardW(uint hLine, uint bAllAddresses, uint dwAddressID, const(LINEFORWARDLIST)* lpForwardList, uint dwNumRingsNoAnswer, uint* lphConsultCall, const(LINECALLPARAMS)* lpCallParams);

@DllImport("TAPI32.dll")
int lineGatherDigits(uint hCall, uint dwDigitModes, const(char)* lpsDigits, uint dwNumDigits, const(char)* lpszTerminationDigits, uint dwFirstDigitTimeout, uint dwInterDigitTimeout);

@DllImport("TAPI32.dll")
int lineGatherDigitsA(uint hCall, uint dwDigitModes, const(char)* lpsDigits, uint dwNumDigits, const(char)* lpszTerminationDigits, uint dwFirstDigitTimeout, uint dwInterDigitTimeout);

@DllImport("TAPI32.dll")
int lineGatherDigitsW(uint hCall, uint dwDigitModes, const(wchar)* lpsDigits, uint dwNumDigits, const(wchar)* lpszTerminationDigits, uint dwFirstDigitTimeout, uint dwInterDigitTimeout);

@DllImport("TAPI32.dll")
int lineGenerateDigits(uint hCall, uint dwDigitMode, const(char)* lpszDigits, uint dwDuration);

@DllImport("TAPI32.dll")
int lineGenerateDigitsA(uint hCall, uint dwDigitMode, const(char)* lpszDigits, uint dwDuration);

@DllImport("TAPI32.dll")
int lineGenerateDigitsW(uint hCall, uint dwDigitMode, const(wchar)* lpszDigits, uint dwDuration);

@DllImport("TAPI32.dll")
int lineGenerateTone(uint hCall, uint dwToneMode, uint dwDuration, uint dwNumTones, const(LINEGENERATETONE)* lpTones);

@DllImport("TAPI32.dll")
int lineGetAddressCaps(uint hLineApp, uint dwDeviceID, uint dwAddressID, uint dwAPIVersion, uint dwExtVersion, LINEADDRESSCAPS* lpAddressCaps);

@DllImport("TAPI32.dll")
int lineGetAddressCapsA(uint hLineApp, uint dwDeviceID, uint dwAddressID, uint dwAPIVersion, uint dwExtVersion, LINEADDRESSCAPS* lpAddressCaps);

@DllImport("TAPI32.dll")
int lineGetAddressCapsW(uint hLineApp, uint dwDeviceID, uint dwAddressID, uint dwAPIVersion, uint dwExtVersion, LINEADDRESSCAPS* lpAddressCaps);

@DllImport("TAPI32.dll")
int lineGetAddressID(uint hLine, uint* lpdwAddressID, uint dwAddressMode, const(char)* lpsAddress, uint dwSize);

@DllImport("TAPI32.dll")
int lineGetAddressIDA(uint hLine, uint* lpdwAddressID, uint dwAddressMode, const(char)* lpsAddress, uint dwSize);

@DllImport("TAPI32.dll")
int lineGetAddressIDW(uint hLine, uint* lpdwAddressID, uint dwAddressMode, const(wchar)* lpsAddress, uint dwSize);

@DllImport("TAPI32.dll")
int lineGetAddressStatus(uint hLine, uint dwAddressID, LINEADDRESSSTATUS* lpAddressStatus);

@DllImport("TAPI32.dll")
int lineGetAddressStatusA(uint hLine, uint dwAddressID, LINEADDRESSSTATUS* lpAddressStatus);

@DllImport("TAPI32.dll")
int lineGetAddressStatusW(uint hLine, uint dwAddressID, LINEADDRESSSTATUS* lpAddressStatus);

@DllImport("TAPI32.dll")
int lineGetAgentActivityListA(uint hLine, uint dwAddressID, LINEAGENTACTIVITYLIST* lpAgentActivityList);

@DllImport("TAPI32.dll")
int lineGetAgentActivityListW(uint hLine, uint dwAddressID, LINEAGENTACTIVITYLIST* lpAgentActivityList);

@DllImport("TAPI32.dll")
int lineGetAgentCapsA(uint hLineApp, uint dwDeviceID, uint dwAddressID, uint dwAppAPIVersion, LINEAGENTCAPS* lpAgentCaps);

@DllImport("TAPI32.dll")
int lineGetAgentCapsW(uint hLineApp, uint dwDeviceID, uint dwAddressID, uint dwAppAPIVersion, LINEAGENTCAPS* lpAgentCaps);

@DllImport("TAPI32.dll")
int lineGetAgentGroupListA(uint hLine, uint dwAddressID, LINEAGENTGROUPLIST* lpAgentGroupList);

@DllImport("TAPI32.dll")
int lineGetAgentGroupListW(uint hLine, uint dwAddressID, LINEAGENTGROUPLIST* lpAgentGroupList);

@DllImport("TAPI32.dll")
int lineGetAgentInfo(uint hLine, uint hAgent, LINEAGENTINFO* lpAgentInfo);

@DllImport("TAPI32.dll")
int lineGetAgentSessionInfo(uint hLine, uint hAgentSession, LINEAGENTSESSIONINFO* lpAgentSessionInfo);

@DllImport("TAPI32.dll")
int lineGetAgentSessionList(uint hLine, uint hAgent, LINEAGENTSESSIONLIST* lpAgentSessionList);

@DllImport("TAPI32.dll")
int lineGetAgentStatusA(uint hLine, uint dwAddressID, LINEAGENTSTATUS* lpAgentStatus);

@DllImport("TAPI32.dll")
int lineGetAgentStatusW(uint hLine, uint dwAddressID, LINEAGENTSTATUS* lpAgentStatus);

@DllImport("TAPI32.dll")
int lineGetAppPriority(const(char)* lpszAppFilename, uint dwMediaMode, LINEEXTENSIONID* lpExtensionID, uint dwRequestMode, VARSTRING* lpExtensionName, uint* lpdwPriority);

@DllImport("TAPI32.dll")
int lineGetAppPriorityA(const(char)* lpszAppFilename, uint dwMediaMode, LINEEXTENSIONID* lpExtensionID, uint dwRequestMode, VARSTRING* lpExtensionName, uint* lpdwPriority);

@DllImport("TAPI32.dll")
int lineGetAppPriorityW(const(wchar)* lpszAppFilename, uint dwMediaMode, LINEEXTENSIONID* lpExtensionID, uint dwRequestMode, VARSTRING* lpExtensionName, uint* lpdwPriority);

@DllImport("TAPI32.dll")
int lineGetCallInfo(uint hCall, LINECALLINFO* lpCallInfo);

@DllImport("TAPI32.dll")
int lineGetCallInfoA(uint hCall, LINECALLINFO* lpCallInfo);

@DllImport("TAPI32.dll")
int lineGetCallInfoW(uint hCall, LINECALLINFO* lpCallInfo);

@DllImport("TAPI32.dll")
int lineGetCallStatus(uint hCall, LINECALLSTATUS* lpCallStatus);

@DllImport("TAPI32.dll")
int lineGetConfRelatedCalls(uint hCall, LINECALLLIST* lpCallList);

@DllImport("TAPI32.dll")
int lineGetCountry(uint dwCountryID, uint dwAPIVersion, LINECOUNTRYLIST* lpLineCountryList);

@DllImport("TAPI32.dll")
int lineGetCountryA(uint dwCountryID, uint dwAPIVersion, LINECOUNTRYLIST* lpLineCountryList);

@DllImport("TAPI32.dll")
int lineGetCountryW(uint dwCountryID, uint dwAPIVersion, LINECOUNTRYLIST* lpLineCountryList);

@DllImport("TAPI32.dll")
int lineGetDevCaps(uint hLineApp, uint dwDeviceID, uint dwAPIVersion, uint dwExtVersion, LINEDEVCAPS* lpLineDevCaps);

@DllImport("TAPI32.dll")
int lineGetDevCapsA(uint hLineApp, uint dwDeviceID, uint dwAPIVersion, uint dwExtVersion, LINEDEVCAPS* lpLineDevCaps);

@DllImport("TAPI32.dll")
int lineGetDevCapsW(uint hLineApp, uint dwDeviceID, uint dwAPIVersion, uint dwExtVersion, LINEDEVCAPS* lpLineDevCaps);

@DllImport("TAPI32.dll")
int lineGetDevConfig(uint dwDeviceID, VARSTRING* lpDeviceConfig, const(char)* lpszDeviceClass);

@DllImport("TAPI32.dll")
int lineGetDevConfigA(uint dwDeviceID, VARSTRING* lpDeviceConfig, const(char)* lpszDeviceClass);

@DllImport("TAPI32.dll")
int lineGetDevConfigW(uint dwDeviceID, VARSTRING* lpDeviceConfig, const(wchar)* lpszDeviceClass);

@DllImport("TAPI32.dll")
int lineGetGroupListA(uint hLine, LINEAGENTGROUPLIST* lpGroupList);

@DllImport("TAPI32.dll")
int lineGetGroupListW(uint hLine, LINEAGENTGROUPLIST* lpGroupList);

@DllImport("TAPI32.dll")
int lineGetIcon(uint dwDeviceID, const(char)* lpszDeviceClass, int* lphIcon);

@DllImport("TAPI32.dll")
int lineGetIconA(uint dwDeviceID, const(char)* lpszDeviceClass, int* lphIcon);

@DllImport("TAPI32.dll")
int lineGetIconW(uint dwDeviceID, const(wchar)* lpszDeviceClass, int* lphIcon);

@DllImport("TAPI32.dll")
int lineGetID(uint hLine, uint dwAddressID, uint hCall, uint dwSelect, VARSTRING* lpDeviceID, const(char)* lpszDeviceClass);

@DllImport("TAPI32.dll")
int lineGetIDA(uint hLine, uint dwAddressID, uint hCall, uint dwSelect, VARSTRING* lpDeviceID, const(char)* lpszDeviceClass);

@DllImport("TAPI32.dll")
int lineGetIDW(uint hLine, uint dwAddressID, uint hCall, uint dwSelect, VARSTRING* lpDeviceID, const(wchar)* lpszDeviceClass);

@DllImport("TAPI32.dll")
int lineGetLineDevStatus(uint hLine, LINEDEVSTATUS* lpLineDevStatus);

@DllImport("TAPI32.dll")
int lineGetLineDevStatusA(uint hLine, LINEDEVSTATUS* lpLineDevStatus);

@DllImport("TAPI32.dll")
int lineGetLineDevStatusW(uint hLine, LINEDEVSTATUS* lpLineDevStatus);

@DllImport("TAPI32.dll")
int lineGetMessage(uint hLineApp, LINEMESSAGE* lpMessage, uint dwTimeout);

@DllImport("TAPI32.dll")
int lineGetNewCalls(uint hLine, uint dwAddressID, uint dwSelect, LINECALLLIST* lpCallList);

@DllImport("TAPI32.dll")
int lineGetNumRings(uint hLine, uint dwAddressID, uint* lpdwNumRings);

@DllImport("TAPI32.dll")
int lineGetProviderList(uint dwAPIVersion, LINEPROVIDERLIST* lpProviderList);

@DllImport("TAPI32.dll")
int lineGetProviderListA(uint dwAPIVersion, LINEPROVIDERLIST* lpProviderList);

@DllImport("TAPI32.dll")
int lineGetProviderListW(uint dwAPIVersion, LINEPROVIDERLIST* lpProviderList);

@DllImport("TAPI32.dll")
int lineGetProxyStatus(uint hLineApp, uint dwDeviceID, uint dwAppAPIVersion, LINEPROXYREQUESTLIST* lpLineProxyReqestList);

@DllImport("TAPI32.dll")
int lineGetQueueInfo(uint hLine, uint dwQueueID, LINEQUEUEINFO* lpLineQueueInfo);

@DllImport("TAPI32.dll")
int lineGetQueueListA(uint hLine, Guid* lpGroupID, LINEQUEUELIST* lpQueueList);

@DllImport("TAPI32.dll")
int lineGetQueueListW(uint hLine, Guid* lpGroupID, LINEQUEUELIST* lpQueueList);

@DllImport("TAPI32.dll")
int lineGetRequest(uint hLineApp, uint dwRequestMode, void* lpRequestBuffer);

@DllImport("TAPI32.dll")
int lineGetRequestA(uint hLineApp, uint dwRequestMode, void* lpRequestBuffer);

@DllImport("TAPI32.dll")
int lineGetRequestW(uint hLineApp, uint dwRequestMode, void* lpRequestBuffer);

@DllImport("TAPI32.dll")
int lineGetStatusMessages(uint hLine, uint* lpdwLineStates, uint* lpdwAddressStates);

@DllImport("TAPI32.dll")
int lineGetTranslateCaps(uint hLineApp, uint dwAPIVersion, LINETRANSLATECAPS* lpTranslateCaps);

@DllImport("TAPI32.dll")
int lineGetTranslateCapsA(uint hLineApp, uint dwAPIVersion, LINETRANSLATECAPS* lpTranslateCaps);

@DllImport("TAPI32.dll")
int lineGetTranslateCapsW(uint hLineApp, uint dwAPIVersion, LINETRANSLATECAPS* lpTranslateCaps);

@DllImport("TAPI32.dll")
int lineHandoff(uint hCall, const(char)* lpszFileName, uint dwMediaMode);

@DllImport("TAPI32.dll")
int lineHandoffA(uint hCall, const(char)* lpszFileName, uint dwMediaMode);

@DllImport("TAPI32.dll")
int lineHandoffW(uint hCall, const(wchar)* lpszFileName, uint dwMediaMode);

@DllImport("TAPI32.dll")
int lineHold(uint hCall);

@DllImport("TAPI32.dll")
int lineInitialize(uint* lphLineApp, HINSTANCE hInstance, LINECALLBACK lpfnCallback, const(char)* lpszAppName, uint* lpdwNumDevs);

@DllImport("TAPI32.dll")
int lineInitializeExA(uint* lphLineApp, HINSTANCE hInstance, LINECALLBACK lpfnCallback, const(char)* lpszFriendlyAppName, uint* lpdwNumDevs, uint* lpdwAPIVersion, LINEINITIALIZEEXPARAMS* lpLineInitializeExParams);

@DllImport("TAPI32.dll")
int lineInitializeExW(uint* lphLineApp, HINSTANCE hInstance, LINECALLBACK lpfnCallback, const(wchar)* lpszFriendlyAppName, uint* lpdwNumDevs, uint* lpdwAPIVersion, LINEINITIALIZEEXPARAMS* lpLineInitializeExParams);

@DllImport("TAPI32.dll")
int lineMakeCall(uint hLine, uint* lphCall, const(char)* lpszDestAddress, uint dwCountryCode, const(LINECALLPARAMS)* lpCallParams);

@DllImport("TAPI32.dll")
int lineMakeCallA(uint hLine, uint* lphCall, const(char)* lpszDestAddress, uint dwCountryCode, const(LINECALLPARAMS)* lpCallParams);

@DllImport("TAPI32.dll")
int lineMakeCallW(uint hLine, uint* lphCall, const(wchar)* lpszDestAddress, uint dwCountryCode, const(LINECALLPARAMS)* lpCallParams);

@DllImport("TAPI32.dll")
int lineMonitorDigits(uint hCall, uint dwDigitModes);

@DllImport("TAPI32.dll")
int lineMonitorMedia(uint hCall, uint dwMediaModes);

@DllImport("TAPI32.dll")
int lineMonitorTones(uint hCall, const(LINEMONITORTONE)* lpToneList, uint dwNumEntries);

@DllImport("TAPI32.dll")
int lineNegotiateAPIVersion(uint hLineApp, uint dwDeviceID, uint dwAPILowVersion, uint dwAPIHighVersion, uint* lpdwAPIVersion, LINEEXTENSIONID* lpExtensionID);

@DllImport("TAPI32.dll")
int lineNegotiateExtVersion(uint hLineApp, uint dwDeviceID, uint dwAPIVersion, uint dwExtLowVersion, uint dwExtHighVersion, uint* lpdwExtVersion);

@DllImport("TAPI32.dll")
int lineOpen(uint hLineApp, uint dwDeviceID, uint* lphLine, uint dwAPIVersion, uint dwExtVersion, uint dwCallbackInstance, uint dwPrivileges, uint dwMediaModes, const(LINECALLPARAMS)* lpCallParams);

@DllImport("TAPI32.dll")
int lineOpenA(uint hLineApp, uint dwDeviceID, uint* lphLine, uint dwAPIVersion, uint dwExtVersion, uint dwCallbackInstance, uint dwPrivileges, uint dwMediaModes, const(LINECALLPARAMS)* lpCallParams);

@DllImport("TAPI32.dll")
int lineOpenW(uint hLineApp, uint dwDeviceID, uint* lphLine, uint dwAPIVersion, uint dwExtVersion, uint dwCallbackInstance, uint dwPrivileges, uint dwMediaModes, const(LINECALLPARAMS)* lpCallParams);

@DllImport("TAPI32.dll")
int linePark(uint hCall, uint dwParkMode, const(char)* lpszDirAddress, VARSTRING* lpNonDirAddress);

@DllImport("TAPI32.dll")
int lineParkA(uint hCall, uint dwParkMode, const(char)* lpszDirAddress, VARSTRING* lpNonDirAddress);

@DllImport("TAPI32.dll")
int lineParkW(uint hCall, uint dwParkMode, const(wchar)* lpszDirAddress, VARSTRING* lpNonDirAddress);

@DllImport("TAPI32.dll")
int linePickup(uint hLine, uint dwAddressID, uint* lphCall, const(char)* lpszDestAddress, const(char)* lpszGroupID);

@DllImport("TAPI32.dll")
int linePickupA(uint hLine, uint dwAddressID, uint* lphCall, const(char)* lpszDestAddress, const(char)* lpszGroupID);

@DllImport("TAPI32.dll")
int linePickupW(uint hLine, uint dwAddressID, uint* lphCall, const(wchar)* lpszDestAddress, const(wchar)* lpszGroupID);

@DllImport("TAPI32.dll")
int linePrepareAddToConference(uint hConfCall, uint* lphConsultCall, const(LINECALLPARAMS)* lpCallParams);

@DllImport("TAPI32.dll")
int linePrepareAddToConferenceA(uint hConfCall, uint* lphConsultCall, const(LINECALLPARAMS)* lpCallParams);

@DllImport("TAPI32.dll")
int linePrepareAddToConferenceW(uint hConfCall, uint* lphConsultCall, const(LINECALLPARAMS)* lpCallParams);

@DllImport("TAPI32.dll")
int lineProxyMessage(uint hLine, uint hCall, uint dwMsg, uint dwParam1, uint dwParam2, uint dwParam3);

@DllImport("TAPI32.dll")
int lineProxyResponse(uint hLine, LINEPROXYREQUEST* lpProxyRequest, uint dwResult);

@DllImport("TAPI32.dll")
int lineRedirect(uint hCall, const(char)* lpszDestAddress, uint dwCountryCode);

@DllImport("TAPI32.dll")
int lineRedirectA(uint hCall, const(char)* lpszDestAddress, uint dwCountryCode);

@DllImport("TAPI32.dll")
int lineRedirectW(uint hCall, const(wchar)* lpszDestAddress, uint dwCountryCode);

@DllImport("TAPI32.dll")
int lineRegisterRequestRecipient(uint hLineApp, uint dwRegistrationInstance, uint dwRequestMode, uint bEnable);

@DllImport("TAPI32.dll")
int lineReleaseUserUserInfo(uint hCall);

@DllImport("TAPI32.dll")
int lineRemoveFromConference(uint hCall);

@DllImport("TAPI32.dll")
int lineRemoveProvider(uint dwPermanentProviderID, HWND hwndOwner);

@DllImport("TAPI32.dll")
int lineSecureCall(uint hCall);

@DllImport("TAPI32.dll")
int lineSendUserUserInfo(uint hCall, const(char)* lpsUserUserInfo, uint dwSize);

@DllImport("TAPI32.dll")
int lineSetAgentActivity(uint hLine, uint dwAddressID, uint dwActivityID);

@DllImport("TAPI32.dll")
int lineSetAgentGroup(uint hLine, uint dwAddressID, LINEAGENTGROUPLIST* lpAgentGroupList);

@DllImport("TAPI32.dll")
int lineSetAgentMeasurementPeriod(uint hLine, uint hAgent, uint dwMeasurementPeriod);

@DllImport("TAPI32.dll")
int lineSetAgentSessionState(uint hLine, uint hAgentSession, uint dwAgentSessionState, uint dwNextAgentSessionState);

@DllImport("TAPI32.dll")
int lineSetAgentStateEx(uint hLine, uint hAgent, uint dwAgentState, uint dwNextAgentState);

@DllImport("TAPI32.dll")
int lineSetAgentState(uint hLine, uint dwAddressID, uint dwAgentState, uint dwNextAgentState);

@DllImport("TAPI32.dll")
int lineSetAppPriority(const(char)* lpszAppFilename, uint dwMediaMode, LINEEXTENSIONID* lpExtensionID, uint dwRequestMode, const(char)* lpszExtensionName, uint dwPriority);

@DllImport("TAPI32.dll")
int lineSetAppPriorityA(const(char)* lpszAppFilename, uint dwMediaMode, LINEEXTENSIONID* lpExtensionID, uint dwRequestMode, const(char)* lpszExtensionName, uint dwPriority);

@DllImport("TAPI32.dll")
int lineSetAppPriorityW(const(wchar)* lpszAppFilename, uint dwMediaMode, LINEEXTENSIONID* lpExtensionID, uint dwRequestMode, const(wchar)* lpszExtensionName, uint dwPriority);

@DllImport("TAPI32.dll")
int lineSetAppSpecific(uint hCall, uint dwAppSpecific);

@DllImport("TAPI32.dll")
int lineSetCallData(uint hCall, void* lpCallData, uint dwSize);

@DllImport("TAPI32.dll")
int lineSetCallParams(uint hCall, uint dwBearerMode, uint dwMinRate, uint dwMaxRate, const(LINEDIALPARAMS)* lpDialParams);

@DllImport("TAPI32.dll")
int lineSetCallPrivilege(uint hCall, uint dwCallPrivilege);

@DllImport("TAPI32.dll")
int lineSetCallQualityOfService(uint hCall, void* lpSendingFlowspec, uint dwSendingFlowspecSize, void* lpReceivingFlowspec, uint dwReceivingFlowspecSize);

@DllImport("TAPI32.dll")
int lineSetCallTreatment(uint hCall, uint dwTreatment);

@DllImport("TAPI32.dll")
int lineSetCurrentLocation(uint hLineApp, uint dwLocation);

@DllImport("TAPI32.dll")
int lineSetDevConfig(uint dwDeviceID, const(void)* lpDeviceConfig, uint dwSize, const(char)* lpszDeviceClass);

@DllImport("TAPI32.dll")
int lineSetDevConfigA(uint dwDeviceID, const(void)* lpDeviceConfig, uint dwSize, const(char)* lpszDeviceClass);

@DllImport("TAPI32.dll")
int lineSetDevConfigW(uint dwDeviceID, const(void)* lpDeviceConfig, uint dwSize, const(wchar)* lpszDeviceClass);

@DllImport("TAPI32.dll")
int lineSetLineDevStatus(uint hLine, uint dwStatusToChange, uint fStatus);

@DllImport("TAPI32.dll")
int lineSetMediaControl(uint hLine, uint dwAddressID, uint hCall, uint dwSelect, const(LINEMEDIACONTROLDIGIT)* lpDigitList, uint dwDigitNumEntries, const(LINEMEDIACONTROLMEDIA)* lpMediaList, uint dwMediaNumEntries, const(LINEMEDIACONTROLTONE)* lpToneList, uint dwToneNumEntries, const(LINEMEDIACONTROLCALLSTATE)* lpCallStateList, uint dwCallStateNumEntries);

@DllImport("TAPI32.dll")
int lineSetMediaMode(uint hCall, uint dwMediaModes);

@DllImport("TAPI32.dll")
int lineSetQueueMeasurementPeriod(uint hLine, uint dwQueueID, uint dwMeasurementPeriod);

@DllImport("TAPI32.dll")
int lineSetNumRings(uint hLine, uint dwAddressID, uint dwNumRings);

@DllImport("TAPI32.dll")
int lineSetStatusMessages(uint hLine, uint dwLineStates, uint dwAddressStates);

@DllImport("TAPI32.dll")
int lineSetTerminal(uint hLine, uint dwAddressID, uint hCall, uint dwSelect, uint dwTerminalModes, uint dwTerminalID, uint bEnable);

@DllImport("TAPI32.dll")
int lineSetTollList(uint hLineApp, uint dwDeviceID, const(char)* lpszAddressIn, uint dwTollListOption);

@DllImport("TAPI32.dll")
int lineSetTollListA(uint hLineApp, uint dwDeviceID, const(char)* lpszAddressIn, uint dwTollListOption);

@DllImport("TAPI32.dll")
int lineSetTollListW(uint hLineApp, uint dwDeviceID, const(wchar)* lpszAddressInW, uint dwTollListOption);

@DllImport("TAPI32.dll")
int lineSetupConference(uint hCall, uint hLine, uint* lphConfCall, uint* lphConsultCall, uint dwNumParties, const(LINECALLPARAMS)* lpCallParams);

@DllImport("TAPI32.dll")
int lineSetupConferenceA(uint hCall, uint hLine, uint* lphConfCall, uint* lphConsultCall, uint dwNumParties, const(LINECALLPARAMS)* lpCallParams);

@DllImport("TAPI32.dll")
int lineSetupConferenceW(uint hCall, uint hLine, uint* lphConfCall, uint* lphConsultCall, uint dwNumParties, const(LINECALLPARAMS)* lpCallParams);

@DllImport("TAPI32.dll")
int lineSetupTransfer(uint hCall, uint* lphConsultCall, const(LINECALLPARAMS)* lpCallParams);

@DllImport("TAPI32.dll")
int lineSetupTransferA(uint hCall, uint* lphConsultCall, const(LINECALLPARAMS)* lpCallParams);

@DllImport("TAPI32.dll")
int lineSetupTransferW(uint hCall, uint* lphConsultCall, const(LINECALLPARAMS)* lpCallParams);

@DllImport("TAPI32.dll")
int lineShutdown(uint hLineApp);

@DllImport("TAPI32.dll")
int lineSwapHold(uint hActiveCall, uint hHeldCall);

@DllImport("TAPI32.dll")
int lineTranslateAddress(uint hLineApp, uint dwDeviceID, uint dwAPIVersion, const(char)* lpszAddressIn, uint dwCard, uint dwTranslateOptions, LINETRANSLATEOUTPUT* lpTranslateOutput);

@DllImport("TAPI32.dll")
int lineTranslateAddressA(uint hLineApp, uint dwDeviceID, uint dwAPIVersion, const(char)* lpszAddressIn, uint dwCard, uint dwTranslateOptions, LINETRANSLATEOUTPUT* lpTranslateOutput);

@DllImport("TAPI32.dll")
int lineTranslateAddressW(uint hLineApp, uint dwDeviceID, uint dwAPIVersion, const(wchar)* lpszAddressIn, uint dwCard, uint dwTranslateOptions, LINETRANSLATEOUTPUT* lpTranslateOutput);

@DllImport("TAPI32.dll")
int lineTranslateDialog(uint hLineApp, uint dwDeviceID, uint dwAPIVersion, HWND hwndOwner, const(char)* lpszAddressIn);

@DllImport("TAPI32.dll")
int lineTranslateDialogA(uint hLineApp, uint dwDeviceID, uint dwAPIVersion, HWND hwndOwner, const(char)* lpszAddressIn);

@DllImport("TAPI32.dll")
int lineTranslateDialogW(uint hLineApp, uint dwDeviceID, uint dwAPIVersion, HWND hwndOwner, const(wchar)* lpszAddressIn);

@DllImport("TAPI32.dll")
int lineUncompleteCall(uint hLine, uint dwCompletionID);

@DllImport("TAPI32.dll")
int lineUnhold(uint hCall);

@DllImport("TAPI32.dll")
int lineUnpark(uint hLine, uint dwAddressID, uint* lphCall, const(char)* lpszDestAddress);

@DllImport("TAPI32.dll")
int lineUnparkA(uint hLine, uint dwAddressID, uint* lphCall, const(char)* lpszDestAddress);

@DllImport("TAPI32.dll")
int lineUnparkW(uint hLine, uint dwAddressID, uint* lphCall, const(wchar)* lpszDestAddress);

@DllImport("TAPI32.dll")
int phoneClose(uint hPhone);

@DllImport("TAPI32.dll")
int phoneConfigDialog(uint dwDeviceID, HWND hwndOwner, const(char)* lpszDeviceClass);

@DllImport("TAPI32.dll")
int phoneConfigDialogA(uint dwDeviceID, HWND hwndOwner, const(char)* lpszDeviceClass);

@DllImport("TAPI32.dll")
int phoneConfigDialogW(uint dwDeviceID, HWND hwndOwner, const(wchar)* lpszDeviceClass);

@DllImport("TAPI32.dll")
int phoneDevSpecific(uint hPhone, void* lpParams, uint dwSize);

@DllImport("TAPI32.dll")
int phoneGetButtonInfo(uint hPhone, uint dwButtonLampID, PHONEBUTTONINFO* lpButtonInfo);

@DllImport("TAPI32.dll")
int phoneGetButtonInfoA(uint hPhone, uint dwButtonLampID, PHONEBUTTONINFO* lpButtonInfo);

@DllImport("TAPI32.dll")
int phoneGetButtonInfoW(uint hPhone, uint dwButtonLampID, PHONEBUTTONINFO* lpButtonInfo);

@DllImport("TAPI32.dll")
int phoneGetData(uint hPhone, uint dwDataID, void* lpData, uint dwSize);

@DllImport("TAPI32.dll")
int phoneGetDevCaps(uint hPhoneApp, uint dwDeviceID, uint dwAPIVersion, uint dwExtVersion, PHONECAPS* lpPhoneCaps);

@DllImport("TAPI32.dll")
int phoneGetDevCapsA(uint hPhoneApp, uint dwDeviceID, uint dwAPIVersion, uint dwExtVersion, PHONECAPS* lpPhoneCaps);

@DllImport("TAPI32.dll")
int phoneGetDevCapsW(uint hPhoneApp, uint dwDeviceID, uint dwAPIVersion, uint dwExtVersion, PHONECAPS* lpPhoneCaps);

@DllImport("TAPI32.dll")
int phoneGetDisplay(uint hPhone, VARSTRING* lpDisplay);

@DllImport("TAPI32.dll")
int phoneGetGain(uint hPhone, uint dwHookSwitchDev, uint* lpdwGain);

@DllImport("TAPI32.dll")
int phoneGetHookSwitch(uint hPhone, uint* lpdwHookSwitchDevs);

@DllImport("TAPI32.dll")
int phoneGetIcon(uint dwDeviceID, const(char)* lpszDeviceClass, int* lphIcon);

@DllImport("TAPI32.dll")
int phoneGetIconA(uint dwDeviceID, const(char)* lpszDeviceClass, int* lphIcon);

@DllImport("TAPI32.dll")
int phoneGetIconW(uint dwDeviceID, const(wchar)* lpszDeviceClass, int* lphIcon);

@DllImport("TAPI32.dll")
int phoneGetID(uint hPhone, VARSTRING* lpDeviceID, const(char)* lpszDeviceClass);

@DllImport("TAPI32.dll")
int phoneGetIDA(uint hPhone, VARSTRING* lpDeviceID, const(char)* lpszDeviceClass);

@DllImport("TAPI32.dll")
int phoneGetIDW(uint hPhone, VARSTRING* lpDeviceID, const(wchar)* lpszDeviceClass);

@DllImport("TAPI32.dll")
int phoneGetLamp(uint hPhone, uint dwButtonLampID, uint* lpdwLampMode);

@DllImport("TAPI32.dll")
int phoneGetMessage(uint hPhoneApp, PHONEMESSAGE* lpMessage, uint dwTimeout);

@DllImport("TAPI32.dll")
int phoneGetRing(uint hPhone, uint* lpdwRingMode, uint* lpdwVolume);

@DllImport("TAPI32.dll")
int phoneGetStatus(uint hPhone, PHONESTATUS* lpPhoneStatus);

@DllImport("TAPI32.dll")
int phoneGetStatusA(uint hPhone, PHONESTATUS* lpPhoneStatus);

@DllImport("TAPI32.dll")
int phoneGetStatusW(uint hPhone, PHONESTATUS* lpPhoneStatus);

@DllImport("TAPI32.dll")
int phoneGetStatusMessages(uint hPhone, uint* lpdwPhoneStates, uint* lpdwButtonModes, uint* lpdwButtonStates);

@DllImport("TAPI32.dll")
int phoneGetVolume(uint hPhone, uint dwHookSwitchDev, uint* lpdwVolume);

@DllImport("TAPI32.dll")
int phoneInitialize(uint* lphPhoneApp, HINSTANCE hInstance, PHONECALLBACK lpfnCallback, const(char)* lpszAppName, uint* lpdwNumDevs);

@DllImport("TAPI32.dll")
int phoneInitializeExA(uint* lphPhoneApp, HINSTANCE hInstance, PHONECALLBACK lpfnCallback, const(char)* lpszFriendlyAppName, uint* lpdwNumDevs, uint* lpdwAPIVersion, PHONEINITIALIZEEXPARAMS* lpPhoneInitializeExParams);

@DllImport("TAPI32.dll")
int phoneInitializeExW(uint* lphPhoneApp, HINSTANCE hInstance, PHONECALLBACK lpfnCallback, const(wchar)* lpszFriendlyAppName, uint* lpdwNumDevs, uint* lpdwAPIVersion, PHONEINITIALIZEEXPARAMS* lpPhoneInitializeExParams);

@DllImport("TAPI32.dll")
int phoneNegotiateAPIVersion(uint hPhoneApp, uint dwDeviceID, uint dwAPILowVersion, uint dwAPIHighVersion, uint* lpdwAPIVersion, PHONEEXTENSIONID* lpExtensionID);

@DllImport("TAPI32.dll")
int phoneNegotiateExtVersion(uint hPhoneApp, uint dwDeviceID, uint dwAPIVersion, uint dwExtLowVersion, uint dwExtHighVersion, uint* lpdwExtVersion);

@DllImport("TAPI32.dll")
int phoneOpen(uint hPhoneApp, uint dwDeviceID, uint* lphPhone, uint dwAPIVersion, uint dwExtVersion, uint dwCallbackInstance, uint dwPrivilege);

@DllImport("TAPI32.dll")
int phoneSetButtonInfo(uint hPhone, uint dwButtonLampID, const(PHONEBUTTONINFO)* lpButtonInfo);

@DllImport("TAPI32.dll")
int phoneSetButtonInfoA(uint hPhone, uint dwButtonLampID, const(PHONEBUTTONINFO)* lpButtonInfo);

@DllImport("TAPI32.dll")
int phoneSetButtonInfoW(uint hPhone, uint dwButtonLampID, const(PHONEBUTTONINFO)* lpButtonInfo);

@DllImport("TAPI32.dll")
int phoneSetData(uint hPhone, uint dwDataID, const(void)* lpData, uint dwSize);

@DllImport("TAPI32.dll")
int phoneSetDisplay(uint hPhone, uint dwRow, uint dwColumn, const(char)* lpsDisplay, uint dwSize);

@DllImport("TAPI32.dll")
int phoneSetGain(uint hPhone, uint dwHookSwitchDev, uint dwGain);

@DllImport("TAPI32.dll")
int phoneSetHookSwitch(uint hPhone, uint dwHookSwitchDevs, uint dwHookSwitchMode);

@DllImport("TAPI32.dll")
int phoneSetLamp(uint hPhone, uint dwButtonLampID, uint dwLampMode);

@DllImport("TAPI32.dll")
int phoneSetRing(uint hPhone, uint dwRingMode, uint dwVolume);

@DllImport("TAPI32.dll")
int phoneSetStatusMessages(uint hPhone, uint dwPhoneStates, uint dwButtonModes, uint dwButtonStates);

@DllImport("TAPI32.dll")
int phoneSetVolume(uint hPhone, uint dwHookSwitchDev, uint dwVolume);

@DllImport("TAPI32.dll")
int phoneShutdown(uint hPhoneApp);

@DllImport("TAPI32.dll")
int tapiGetLocationInfo(const(char)* lpszCountryCode, const(char)* lpszCityCode);

@DllImport("TAPI32.dll")
int tapiGetLocationInfoA(const(char)* lpszCountryCode, const(char)* lpszCityCode);

@DllImport("TAPI32.dll")
int tapiGetLocationInfoW(const(wchar)* lpszCountryCodeW, const(wchar)* lpszCityCodeW);

@DllImport("TAPI32.dll")
int tapiRequestDrop(HWND hwnd, WPARAM wRequestID);

@DllImport("TAPI32.dll")
int tapiRequestMakeCall(const(char)* lpszDestAddress, const(char)* lpszAppName, const(char)* lpszCalledParty, const(char)* lpszComment);

@DllImport("TAPI32.dll")
int tapiRequestMakeCallA(const(char)* lpszDestAddress, const(char)* lpszAppName, const(char)* lpszCalledParty, const(char)* lpszComment);

@DllImport("TAPI32.dll")
int tapiRequestMakeCallW(const(wchar)* lpszDestAddress, const(wchar)* lpszAppName, const(wchar)* lpszCalledParty, const(wchar)* lpszComment);

@DllImport("TAPI32.dll")
int tapiRequestMediaCall(HWND hwnd, WPARAM wRequestID, const(char)* lpszDeviceClass, const(char)* lpDeviceID, uint dwSize, uint dwSecure, const(char)* lpszDestAddress, const(char)* lpszAppName, const(char)* lpszCalledParty, const(char)* lpszComment);

@DllImport("TAPI32.dll")
int tapiRequestMediaCallA(HWND hwnd, WPARAM wRequestID, const(char)* lpszDeviceClass, const(char)* lpDeviceID, uint dwSize, uint dwSecure, const(char)* lpszDestAddress, const(char)* lpszAppName, const(char)* lpszCalledParty, const(char)* lpszComment);

@DllImport("TAPI32.dll")
int tapiRequestMediaCallW(HWND hwnd, WPARAM wRequestID, const(wchar)* lpszDeviceClass, const(wchar)* lpDeviceID, uint dwSize, uint dwSecure, const(wchar)* lpszDestAddress, const(wchar)* lpszAppName, const(wchar)* lpszCalledParty, const(wchar)* lpszComment);

