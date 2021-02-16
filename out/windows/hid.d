module windows.hid;

public import windows.core;
public import windows.com : HRESULT, IUnknown;
public import windows.displaydevices : POINT, RECT;
public import windows.multimedia : joyrange_tag, joyreghwconfig_tag, joyreghwsettings_tag, joyreguservalues_tag;
public import windows.systemservices : BOOL, HANDLE, HINSTANCE, NTSTATUS;
public import windows.windowsandmessaging : HWND;
public import windows.windowsprogramming : FILETIME, HKEY;

extern(Windows):


// Enums


enum : int
{
    HidP_Input   = 0x00000000,
    HidP_Output  = 0x00000001,
    HidP_Feature = 0x00000002,
}
alias HIDP_REPORT_TYPE = int;

enum : int
{
    HidP_Keyboard_Break = 0x00000000,
    HidP_Keyboard_Make  = 0x00000001,
}
alias HIDP_KEYBOARD_DIRECTION = int;

// Callbacks

alias LPDIENUMEFFECTSINFILECALLBACK = BOOL function(DIFILEEFFECT* param0, void* param1);
alias LPDIENUMDEVICEOBJECTSCALLBACKA = BOOL function(DIDEVICEOBJECTINSTANCEA* param0, void* param1);
alias LPDIENUMDEVICEOBJECTSCALLBACKW = BOOL function(DIDEVICEOBJECTINSTANCEW* param0, void* param1);
alias LPDIENUMEFFECTSCALLBACKA = BOOL function(DIEFFECTINFOA* param0, void* param1);
alias LPDIENUMEFFECTSCALLBACKW = BOOL function(DIEFFECTINFOW* param0, void* param1);
alias LPDIENUMCREATEDEFFECTOBJECTSCALLBACK = BOOL function(IDirectInputEffect param0, void* param1);
alias LPDIENUMDEVICESCALLBACKA = BOOL function(DIDEVICEINSTANCEA* param0, void* param1);
alias LPDIENUMDEVICESCALLBACKW = BOOL function(DIDEVICEINSTANCEW* param0, void* param1);
alias LPDICONFIGUREDEVICESCALLBACK = BOOL function(IUnknown param0, void* param1);
alias LPDIENUMDEVICESBYSEMANTICSCBA = BOOL function(DIDEVICEINSTANCEA* param0, IDirectInputDevice8A param1, 
                                                    uint param2, uint param3, void* param4);
alias LPDIENUMDEVICESBYSEMANTICSCBW = BOOL function(DIDEVICEINSTANCEW* param0, IDirectInputDevice8W param1, 
                                                    uint param2, uint param3, void* param4);
alias LPFNSHOWJOYCPL = void function(HWND hWnd);
alias LPDIJOYTYPECALLBACK = BOOL function(const(wchar)* param0, void* param1);
alias PHIDP_INSERT_SCANCODES = ubyte function(void* Context, const(char)* NewScanCodes, uint Length);

// Structs


struct DICONSTANTFORCE
{
    int lMagnitude;
}

struct DIRAMPFORCE
{
    int lStart;
    int lEnd;
}

struct DIPERIODIC
{
    uint dwMagnitude;
    int  lOffset;
    uint dwPhase;
    uint dwPeriod;
}

struct DICONDITION
{
    int  lOffset;
    int  lPositiveCoefficient;
    int  lNegativeCoefficient;
    uint dwPositiveSaturation;
    uint dwNegativeSaturation;
    int  lDeadBand;
}

struct DICUSTOMFORCE
{
    uint cChannels;
    uint dwSamplePeriod;
    uint cSamples;
    int* rglForceData;
}

struct DIENVELOPE
{
    uint dwSize;
    uint dwAttackLevel;
    uint dwAttackTime;
    uint dwFadeLevel;
    uint dwFadeTime;
}

struct DIEFFECT_DX5
{
    uint        dwSize;
    uint        dwFlags;
    uint        dwDuration;
    uint        dwSamplePeriod;
    uint        dwGain;
    uint        dwTriggerButton;
    uint        dwTriggerRepeatInterval;
    uint        cAxes;
    uint*       rgdwAxes;
    int*        rglDirection;
    DIENVELOPE* lpEnvelope;
    uint        cbTypeSpecificParams;
    void*       lpvTypeSpecificParams;
}

struct DIEFFECT
{
    uint        dwSize;
    uint        dwFlags;
    uint        dwDuration;
    uint        dwSamplePeriod;
    uint        dwGain;
    uint        dwTriggerButton;
    uint        dwTriggerRepeatInterval;
    uint        cAxes;
    uint*       rgdwAxes;
    int*        rglDirection;
    DIENVELOPE* lpEnvelope;
    uint        cbTypeSpecificParams;
    void*       lpvTypeSpecificParams;
    uint        dwStartDelay;
}

struct DIFILEEFFECT
{
    uint      dwSize;
    GUID      GuidEffect;
    DIEFFECT* lpDiEffect;
    byte[260] szFriendlyName;
}

struct DIEFFESCAPE
{
    uint  dwSize;
    uint  dwCommand;
    void* lpvInBuffer;
    uint  cbInBuffer;
    void* lpvOutBuffer;
    uint  cbOutBuffer;
}

struct DIDEVCAPS_DX3
{
    uint dwSize;
    uint dwFlags;
    uint dwDevType;
    uint dwAxes;
    uint dwButtons;
    uint dwPOVs;
}

struct DIDEVCAPS
{
    uint dwSize;
    uint dwFlags;
    uint dwDevType;
    uint dwAxes;
    uint dwButtons;
    uint dwPOVs;
    uint dwFFSamplePeriod;
    uint dwFFMinTimeResolution;
    uint dwFirmwareRevision;
    uint dwHardwareRevision;
    uint dwFFDriverVersion;
}

struct DIOBJECTDATAFORMAT
{
    const(GUID)* pguid;
    uint         dwOfs;
    uint         dwType;
    uint         dwFlags;
}

struct DIDATAFORMAT
{
    uint                dwSize;
    uint                dwObjSize;
    uint                dwFlags;
    uint                dwDataSize;
    uint                dwNumObjs;
    DIOBJECTDATAFORMAT* rgodf;
}

struct DIACTIONA
{
    size_t uAppData;
    uint   dwSemantic;
    uint   dwFlags;
    union
    {
        const(char)* lptszActionName;
        uint         uResIdString;
    }
    GUID   guidInstance;
    uint   dwObjID;
    uint   dwHow;
}

struct DIACTIONW
{
    size_t uAppData;
    uint   dwSemantic;
    uint   dwFlags;
    union
    {
        const(wchar)* lptszActionName;
        uint          uResIdString;
    }
    GUID   guidInstance;
    uint   dwObjID;
    uint   dwHow;
}

struct DIACTIONFORMATA
{
    uint       dwSize;
    uint       dwActionSize;
    uint       dwDataSize;
    uint       dwNumActions;
    DIACTIONA* rgoAction;
    GUID       guidActionMap;
    uint       dwGenre;
    uint       dwBufferSize;
    int        lAxisMin;
    int        lAxisMax;
    HINSTANCE  hInstString;
    FILETIME   ftTimeStamp;
    uint       dwCRC;
    byte[260]  tszActionMap;
}

struct DIACTIONFORMATW
{
    uint        dwSize;
    uint        dwActionSize;
    uint        dwDataSize;
    uint        dwNumActions;
    DIACTIONW*  rgoAction;
    GUID        guidActionMap;
    uint        dwGenre;
    uint        dwBufferSize;
    int         lAxisMin;
    int         lAxisMax;
    HINSTANCE   hInstString;
    FILETIME    ftTimeStamp;
    uint        dwCRC;
    ushort[260] tszActionMap;
}

struct DICOLORSET
{
    uint dwSize;
    uint cTextFore;
    uint cTextHighlight;
    uint cCalloutLine;
    uint cCalloutHighlight;
    uint cBorder;
    uint cControlFill;
    uint cHighlightFill;
    uint cAreaFill;
}

struct DICONFIGUREDEVICESPARAMSA
{
    uint             dwSize;
    uint             dwcUsers;
    const(char)*     lptszUserNames;
    uint             dwcFormats;
    DIACTIONFORMATA* lprgFormats;
    HWND             hwnd;
    DICOLORSET       dics;
    IUnknown         lpUnkDDSTarget;
}

struct DICONFIGUREDEVICESPARAMSW
{
    uint             dwSize;
    uint             dwcUsers;
    const(wchar)*    lptszUserNames;
    uint             dwcFormats;
    DIACTIONFORMATW* lprgFormats;
    HWND             hwnd;
    DICOLORSET       dics;
    IUnknown         lpUnkDDSTarget;
}

struct DIDEVICEIMAGEINFOA
{
    byte[260] tszImagePath;
    uint      dwFlags;
    uint      dwViewID;
    RECT      rcOverlay;
    uint      dwObjID;
    uint      dwcValidPts;
    POINT[5]  rgptCalloutLine;
    RECT      rcCalloutRect;
    uint      dwTextAlign;
}

struct DIDEVICEIMAGEINFOW
{
    ushort[260] tszImagePath;
    uint        dwFlags;
    uint        dwViewID;
    RECT        rcOverlay;
    uint        dwObjID;
    uint        dwcValidPts;
    POINT[5]    rgptCalloutLine;
    RECT        rcCalloutRect;
    uint        dwTextAlign;
}

struct DIDEVICEIMAGEINFOHEADERA
{
    uint                dwSize;
    uint                dwSizeImageInfo;
    uint                dwcViews;
    uint                dwcButtons;
    uint                dwcAxes;
    uint                dwcPOVs;
    uint                dwBufferSize;
    uint                dwBufferUsed;
    DIDEVICEIMAGEINFOA* lprgImageInfoArray;
}

struct DIDEVICEIMAGEINFOHEADERW
{
    uint                dwSize;
    uint                dwSizeImageInfo;
    uint                dwcViews;
    uint                dwcButtons;
    uint                dwcAxes;
    uint                dwcPOVs;
    uint                dwBufferSize;
    uint                dwBufferUsed;
    DIDEVICEIMAGEINFOW* lprgImageInfoArray;
}

struct DIDEVICEOBJECTINSTANCE_DX3A
{
    uint      dwSize;
    GUID      guidType;
    uint      dwOfs;
    uint      dwType;
    uint      dwFlags;
    byte[260] tszName;
}

struct DIDEVICEOBJECTINSTANCE_DX3W
{
    uint        dwSize;
    GUID        guidType;
    uint        dwOfs;
    uint        dwType;
    uint        dwFlags;
    ushort[260] tszName;
}

struct DIDEVICEOBJECTINSTANCEA
{
    uint      dwSize;
    GUID      guidType;
    uint      dwOfs;
    uint      dwType;
    uint      dwFlags;
    byte[260] tszName;
    uint      dwFFMaxForce;
    uint      dwFFForceResolution;
    ushort    wCollectionNumber;
    ushort    wDesignatorIndex;
    ushort    wUsagePage;
    ushort    wUsage;
    uint      dwDimension;
    ushort    wExponent;
    ushort    wReportId;
}

struct DIDEVICEOBJECTINSTANCEW
{
    uint        dwSize;
    GUID        guidType;
    uint        dwOfs;
    uint        dwType;
    uint        dwFlags;
    ushort[260] tszName;
    uint        dwFFMaxForce;
    uint        dwFFForceResolution;
    ushort      wCollectionNumber;
    ushort      wDesignatorIndex;
    ushort      wUsagePage;
    ushort      wUsage;
    uint        dwDimension;
    ushort      wExponent;
    ushort      wReportId;
}

struct DIPROPHEADER
{
    uint dwSize;
    uint dwHeaderSize;
    uint dwObj;
    uint dwHow;
}

struct DIPROPDWORD
{
    DIPROPHEADER diph;
    uint         dwData;
}

struct DIPROPPOINTER
{
    DIPROPHEADER diph;
    size_t       uData;
}

struct DIPROPRANGE
{
    DIPROPHEADER diph;
    int          lMin;
    int          lMax;
}

struct DIPROPCAL
{
    DIPROPHEADER diph;
    int          lMin;
    int          lCenter;
    int          lMax;
}

struct DIPROPCALPOV
{
    DIPROPHEADER diph;
    int[5]       lMin;
    int[5]       lMax;
}

struct DIPROPGUIDANDPATH
{
    DIPROPHEADER diph;
    GUID         guidClass;
    ushort[260]  wszPath;
}

struct DIPROPSTRING
{
    DIPROPHEADER diph;
    ushort[260]  wsz;
}

struct CPOINT
{
    int  lP;
    uint dwLog;
}

struct DIPROPCPOINTS
{
    DIPROPHEADER diph;
    uint         dwCPointsNum;
    CPOINT[8]    cp;
}

struct DIDEVICEOBJECTDATA_DX3
{
    uint dwOfs;
    uint dwData;
    uint dwTimeStamp;
    uint dwSequence;
}

struct DIDEVICEOBJECTDATA
{
    uint   dwOfs;
    uint   dwData;
    uint   dwTimeStamp;
    uint   dwSequence;
    size_t uAppData;
}

struct DIDEVICEINSTANCE_DX3A
{
    uint      dwSize;
    GUID      guidInstance;
    GUID      guidProduct;
    uint      dwDevType;
    byte[260] tszInstanceName;
    byte[260] tszProductName;
}

struct DIDEVICEINSTANCE_DX3W
{
    uint        dwSize;
    GUID        guidInstance;
    GUID        guidProduct;
    uint        dwDevType;
    ushort[260] tszInstanceName;
    ushort[260] tszProductName;
}

struct DIDEVICEINSTANCEA
{
    uint      dwSize;
    GUID      guidInstance;
    GUID      guidProduct;
    uint      dwDevType;
    byte[260] tszInstanceName;
    byte[260] tszProductName;
    GUID      guidFFDriver;
    ushort    wUsagePage;
    ushort    wUsage;
}

struct DIDEVICEINSTANCEW
{
    uint        dwSize;
    GUID        guidInstance;
    GUID        guidProduct;
    uint        dwDevType;
    ushort[260] tszInstanceName;
    ushort[260] tszProductName;
    GUID        guidFFDriver;
    ushort      wUsagePage;
    ushort      wUsage;
}

struct DIEFFECTINFOA
{
    uint      dwSize;
    GUID      guid;
    uint      dwEffType;
    uint      dwStaticParams;
    uint      dwDynamicParams;
    byte[260] tszName;
}

struct DIEFFECTINFOW
{
    uint        dwSize;
    GUID        guid;
    uint        dwEffType;
    uint        dwStaticParams;
    uint        dwDynamicParams;
    ushort[260] tszName;
}

struct DIMOUSESTATE
{
    int      lX;
    int      lY;
    int      lZ;
    ubyte[4] rgbButtons;
}

struct DIMOUSESTATE2
{
    int      lX;
    int      lY;
    int      lZ;
    ubyte[8] rgbButtons;
}

struct DIJOYSTATE
{
    int       lX;
    int       lY;
    int       lZ;
    int       lRx;
    int       lRy;
    int       lRz;
    int[2]    rglSlider;
    uint[4]   rgdwPOV;
    ubyte[32] rgbButtons;
}

struct DIJOYSTATE2
{
    int        lX;
    int        lY;
    int        lZ;
    int        lRx;
    int        lRy;
    int        lRz;
    int[2]     rglSlider;
    uint[4]    rgdwPOV;
    ubyte[128] rgbButtons;
    int        lVX;
    int        lVY;
    int        lVZ;
    int        lVRx;
    int        lVRy;
    int        lVRz;
    int[2]     rglVSlider;
    int        lAX;
    int        lAY;
    int        lAZ;
    int        lARx;
    int        lARy;
    int        lARz;
    int[2]     rglASlider;
    int        lFX;
    int        lFY;
    int        lFZ;
    int        lFRx;
    int        lFRy;
    int        lFRz;
    int[2]     rglFSlider;
}

struct DIOBJECTATTRIBUTES
{
    uint   dwFlags;
    ushort wUsagePage;
    ushort wUsage;
}

struct DIFFOBJECTATTRIBUTES
{
    uint dwFFMaxForce;
    uint dwFFForceResolution;
}

struct DIOBJECTCALIBRATION
{
    int lMin;
    int lCenter;
    int lMax;
}

struct DIPOVCALIBRATION
{
    int[5] lMin;
    int[5] lMax;
}

struct DIEFFECTATTRIBUTES
{
    uint dwEffectId;
    uint dwEffType;
    uint dwStaticParams;
    uint dwDynamicParams;
    uint dwCoords;
}

struct DIFFDEVICEATTRIBUTES
{
    uint dwFlags;
    uint dwFFSamplePeriod;
    uint dwFFMinTimeResolution;
}

struct DIDRIVERVERSIONS
{
    uint dwSize;
    uint dwFirmwareRevision;
    uint dwHardwareRevision;
    uint dwFFDriverVersion;
}

struct DIDEVICESTATE
{
    uint dwSize;
    uint dwState;
    uint dwLoad;
}

struct DIHIDFFINITINFO
{
    uint          dwSize;
    const(wchar)* pwszDeviceInterface;
    GUID          GuidInstance;
}

struct DIJOYTYPEINFO_DX5
{
    uint                 dwSize;
    joyreghwsettings_tag hws;
    GUID                 clsidConfig;
    ushort[256]          wszDisplayName;
    ushort[260]          wszCallout;
}

struct DIJOYTYPEINFO_DX6
{
    uint                 dwSize;
    joyreghwsettings_tag hws;
    GUID                 clsidConfig;
    ushort[256]          wszDisplayName;
    ushort[260]          wszCallout;
    ushort[256]          wszHardwareId;
    uint                 dwFlags1;
}

struct DIJOYTYPEINFO
{
    uint                 dwSize;
    joyreghwsettings_tag hws;
    GUID                 clsidConfig;
    ushort[256]          wszDisplayName;
    ushort[260]          wszCallout;
    ushort[256]          wszHardwareId;
    uint                 dwFlags1;
    uint                 dwFlags2;
    ushort[256]          wszMapFile;
}

struct DIJOYCONFIG_DX5
{
    uint               dwSize;
    GUID               guidInstance;
    joyreghwconfig_tag hwc;
    uint               dwGain;
    ushort[256]        wszType;
    ushort[256]        wszCallout;
}

struct DIJOYCONFIG
{
    uint               dwSize;
    GUID               guidInstance;
    joyreghwconfig_tag hwc;
    uint               dwGain;
    ushort[256]        wszType;
    ushort[256]        wszCallout;
    GUID               guidGameport;
}

struct DIJOYUSERVALUES
{
    uint                 dwSize;
    joyreguservalues_tag ruv;
    ushort[256]          wszGlobalDriver;
    ushort[256]          wszGameportEmulator;
}

struct KEYBOARD_INPUT_DATA
{
    ushort UnitId;
    ushort MakeCode;
    ushort Flags;
    ushort Reserved;
    uint   ExtraInformation;
}

struct KEYBOARD_TYPEMATIC_PARAMETERS
{
    ushort UnitId;
    ushort Rate;
    ushort Delay;
}

struct KEYBOARD_ID
{
    ubyte Type;
    ubyte Subtype;
}

struct KEYBOARD_ATTRIBUTES
{
    KEYBOARD_ID KeyboardIdentifier;
    ushort      KeyboardMode;
    ushort      NumberOfFunctionKeys;
    ushort      NumberOfIndicators;
    ushort      NumberOfKeysTotal;
    uint        InputDataQueueLength;
    KEYBOARD_TYPEMATIC_PARAMETERS KeyRepeatMinimum;
    KEYBOARD_TYPEMATIC_PARAMETERS KeyRepeatMaximum;
}

struct KEYBOARD_EXTENDED_ATTRIBUTES
{
    ubyte Version;
    ubyte FormFactor;
    ubyte KeyType;
    ubyte PhysicalLayout;
    ubyte VendorSpecificPhysicalLayout;
    ubyte IETFLanguageTagIndex;
    ubyte ImplementedInputAssistControls;
}

struct KEYBOARD_INDICATOR_PARAMETERS
{
    ushort UnitId;
    ushort LedFlags;
}

struct INDICATOR_LIST
{
    ushort MakeCode;
    ushort IndicatorFlags;
}

struct KEYBOARD_INDICATOR_TRANSLATION
{
    ushort            NumberOfIndicatorKeys;
    INDICATOR_LIST[1] IndicatorList;
}

struct KEYBOARD_UNIT_ID_PARAMETER
{
    ushort UnitId;
}

struct KEYBOARD_IME_STATUS
{
    ushort UnitId;
    uint   ImeOpen;
    uint   ImeConvMode;
}

struct MOUSE_INPUT_DATA
{
    ushort UnitId;
    ushort Flags;
    union
    {
        uint Buttons;
        struct
        {
            ushort ButtonFlags;
            ushort ButtonData;
        }
    }
    uint   RawButtons;
    int    LastX;
    int    LastY;
    uint   ExtraInformation;
}

struct MOUSE_ATTRIBUTES
{
    ushort MouseIdentifier;
    ushort NumberOfButtons;
    ushort SampleRate;
    uint   InputDataQueueLength;
}

struct MOUSE_UNIT_ID_PARAMETER
{
    ushort UnitId;
}

struct USAGE_AND_PAGE
{
    ushort Usage;
    ushort UsagePage;
}

struct HIDP_BUTTON_CAPS
{
    ushort   UsagePage;
    ubyte    ReportID;
    ubyte    IsAlias;
    ushort   BitField;
    ushort   LinkCollection;
    ushort   LinkUsage;
    ushort   LinkUsagePage;
    ubyte    IsRange;
    ubyte    IsStringRange;
    ubyte    IsDesignatorRange;
    ubyte    IsAbsolute;
    uint[10] Reserved;
    union
    {
        struct Range
        {
            ushort UsageMin;
            ushort UsageMax;
            ushort StringMin;
            ushort StringMax;
            ushort DesignatorMin;
            ushort DesignatorMax;
            ushort DataIndexMin;
            ushort DataIndexMax;
        }
        struct NotRange
        {
            ushort Usage;
            ushort Reserved1;
            ushort StringIndex;
            ushort Reserved2;
            ushort DesignatorIndex;
            ushort Reserved3;
            ushort DataIndex;
            ushort Reserved4;
        }
    }
}

struct HIDP_VALUE_CAPS
{
    ushort    UsagePage;
    ubyte     ReportID;
    ubyte     IsAlias;
    ushort    BitField;
    ushort    LinkCollection;
    ushort    LinkUsage;
    ushort    LinkUsagePage;
    ubyte     IsRange;
    ubyte     IsStringRange;
    ubyte     IsDesignatorRange;
    ubyte     IsAbsolute;
    ubyte     HasNull;
    ubyte     Reserved;
    ushort    BitSize;
    ushort    ReportCount;
    ushort[5] Reserved2;
    uint      UnitsExp;
    uint      Units;
    int       LogicalMin;
    int       LogicalMax;
    int       PhysicalMin;
    int       PhysicalMax;
    union
    {
        struct Range
        {
            ushort UsageMin;
            ushort UsageMax;
            ushort StringMin;
            ushort StringMax;
            ushort DesignatorMin;
            ushort DesignatorMax;
            ushort DataIndexMin;
            ushort DataIndexMax;
        }
        struct NotRange
        {
            ushort Usage;
            ushort Reserved1;
            ushort StringIndex;
            ushort Reserved2;
            ushort DesignatorIndex;
            ushort Reserved3;
            ushort DataIndex;
            ushort Reserved4;
        }
    }
}

struct HIDP_LINK_COLLECTION_NODE
{
    ushort LinkUsage;
    ushort LinkUsagePage;
    ushort Parent;
    ushort NumberOfChildren;
    ushort NextSibling;
    ushort FirstChild;
    uint   _bitfield44;
    void*  UserContext;
}

struct _HIDP_PREPARSED_DATA
{
}

struct HIDP_CAPS
{
    ushort     Usage;
    ushort     UsagePage;
    ushort     InputReportByteLength;
    ushort     OutputReportByteLength;
    ushort     FeatureReportByteLength;
    ushort[17] Reserved;
    ushort     NumberLinkCollectionNodes;
    ushort     NumberInputButtonCaps;
    ushort     NumberInputValueCaps;
    ushort     NumberInputDataIndices;
    ushort     NumberOutputButtonCaps;
    ushort     NumberOutputValueCaps;
    ushort     NumberOutputDataIndices;
    ushort     NumberFeatureButtonCaps;
    ushort     NumberFeatureValueCaps;
    ushort     NumberFeatureDataIndices;
}

struct HIDP_DATA
{
    ushort DataIndex;
    ushort Reserved;
    union
    {
        uint  RawValue;
        ubyte On;
    }
}

struct HIDP_UNKNOWN_TOKEN
{
    ubyte    Token;
    ubyte[3] Reserved;
    uint     BitField;
}

struct HIDP_EXTENDED_ATTRIBUTES
{
    ubyte               NumGlobalUnknowns;
    ubyte[3]            Reserved;
    HIDP_UNKNOWN_TOKEN* GlobalUnknowns;
    uint[1]             Data;
}

struct HIDP_KEYBOARD_MODIFIER_STATE
{
    union
    {
        struct
        {
            uint _bitfield45;
        }
        uint ul;
    }
}

struct HIDD_CONFIGURATION
{
    void* cookie;
    uint  size;
    uint  RingBufferSize;
}

struct HIDD_ATTRIBUTES
{
    uint   Size;
    ushort VendorID;
    ushort ProductID;
    ushort VersionNumber;
}

struct JOYREGHWVALUES
{
align (1):
    joyrange_tag jrvHardware;
    uint[4]      dwPOVValues;
    uint         dwCalFlags;
}

// Functions

@DllImport("DINPUT8")
HRESULT DirectInput8Create(HINSTANCE hinst, uint dwVersion, const(GUID)* riidltf, void** ppvOut, 
                           IUnknown punkOuter);

@DllImport("HID")
NTSTATUS HidP_GetCaps(ptrdiff_t PreparsedData, HIDP_CAPS* Capabilities);

@DllImport("HID")
NTSTATUS HidP_GetLinkCollectionNodes(char* LinkCollectionNodes, uint* LinkCollectionNodesLength, 
                                     ptrdiff_t PreparsedData);

@DllImport("HID")
NTSTATUS HidP_GetSpecificButtonCaps(HIDP_REPORT_TYPE ReportType, ushort UsagePage, ushort LinkCollection, 
                                    ushort Usage, char* ButtonCaps, ushort* ButtonCapsLength, 
                                    ptrdiff_t PreparsedData);

@DllImport("HID")
NTSTATUS HidP_GetButtonCaps(HIDP_REPORT_TYPE ReportType, char* ButtonCaps, ushort* ButtonCapsLength, 
                            ptrdiff_t PreparsedData);

@DllImport("HID")
NTSTATUS HidP_GetSpecificValueCaps(HIDP_REPORT_TYPE ReportType, ushort UsagePage, ushort LinkCollection, 
                                   ushort Usage, char* ValueCaps, ushort* ValueCapsLength, ptrdiff_t PreparsedData);

@DllImport("HID")
NTSTATUS HidP_GetValueCaps(HIDP_REPORT_TYPE ReportType, char* ValueCaps, ushort* ValueCapsLength, 
                           ptrdiff_t PreparsedData);

@DllImport("HID")
NTSTATUS HidP_GetExtendedAttributes(HIDP_REPORT_TYPE ReportType, ushort DataIndex, ptrdiff_t PreparsedData, 
                                    char* Attributes, uint* LengthAttributes);

@DllImport("HID")
NTSTATUS HidP_InitializeReportForID(HIDP_REPORT_TYPE ReportType, ubyte ReportID, ptrdiff_t PreparsedData, 
                                    const(char)* Report, uint ReportLength);

@DllImport("HID")
NTSTATUS HidP_SetData(HIDP_REPORT_TYPE ReportType, char* DataList, uint* DataLength, ptrdiff_t PreparsedData, 
                      const(char)* Report, uint ReportLength);

@DllImport("HID")
NTSTATUS HidP_GetData(HIDP_REPORT_TYPE ReportType, char* DataList, uint* DataLength, ptrdiff_t PreparsedData, 
                      const(char)* Report, uint ReportLength);

@DllImport("HID")
uint HidP_MaxDataListLength(HIDP_REPORT_TYPE ReportType, ptrdiff_t PreparsedData);

@DllImport("HID")
NTSTATUS HidP_SetUsages(HIDP_REPORT_TYPE ReportType, ushort UsagePage, ushort LinkCollection, char* UsageList, 
                        uint* UsageLength, ptrdiff_t PreparsedData, const(char)* Report, uint ReportLength);

@DllImport("HID")
NTSTATUS HidP_UnsetUsages(HIDP_REPORT_TYPE ReportType, ushort UsagePage, ushort LinkCollection, char* UsageList, 
                          uint* UsageLength, ptrdiff_t PreparsedData, const(char)* Report, uint ReportLength);

@DllImport("HID")
NTSTATUS HidP_GetUsages(HIDP_REPORT_TYPE ReportType, ushort UsagePage, ushort LinkCollection, char* UsageList, 
                        uint* UsageLength, ptrdiff_t PreparsedData, const(char)* Report, uint ReportLength);

@DllImport("HID")
NTSTATUS HidP_GetUsagesEx(HIDP_REPORT_TYPE ReportType, ushort LinkCollection, char* ButtonList, uint* UsageLength, 
                          ptrdiff_t PreparsedData, const(char)* Report, uint ReportLength);

@DllImport("HID")
uint HidP_MaxUsageListLength(HIDP_REPORT_TYPE ReportType, ushort UsagePage, ptrdiff_t PreparsedData);

@DllImport("HID")
NTSTATUS HidP_SetUsageValue(HIDP_REPORT_TYPE ReportType, ushort UsagePage, ushort LinkCollection, ushort Usage, 
                            uint UsageValue, ptrdiff_t PreparsedData, const(char)* Report, uint ReportLength);

@DllImport("HID")
NTSTATUS HidP_SetScaledUsageValue(HIDP_REPORT_TYPE ReportType, ushort UsagePage, ushort LinkCollection, 
                                  ushort Usage, int UsageValue, ptrdiff_t PreparsedData, const(char)* Report, 
                                  uint ReportLength);

@DllImport("HID")
NTSTATUS HidP_SetUsageValueArray(HIDP_REPORT_TYPE ReportType, ushort UsagePage, ushort LinkCollection, 
                                 ushort Usage, const(char)* UsageValue, ushort UsageValueByteLength, 
                                 ptrdiff_t PreparsedData, const(char)* Report, uint ReportLength);

@DllImport("HID")
NTSTATUS HidP_GetUsageValue(HIDP_REPORT_TYPE ReportType, ushort UsagePage, ushort LinkCollection, ushort Usage, 
                            uint* UsageValue, ptrdiff_t PreparsedData, const(char)* Report, uint ReportLength);

@DllImport("HID")
NTSTATUS HidP_GetScaledUsageValue(HIDP_REPORT_TYPE ReportType, ushort UsagePage, ushort LinkCollection, 
                                  ushort Usage, int* UsageValue, ptrdiff_t PreparsedData, const(char)* Report, 
                                  uint ReportLength);

@DllImport("HID")
NTSTATUS HidP_GetUsageValueArray(HIDP_REPORT_TYPE ReportType, ushort UsagePage, ushort LinkCollection, 
                                 ushort Usage, const(char)* UsageValue, ushort UsageValueByteLength, 
                                 ptrdiff_t PreparsedData, const(char)* Report, uint ReportLength);

@DllImport("HID")
NTSTATUS HidP_UsageListDifference(char* PreviousUsageList, char* CurrentUsageList, char* BreakUsageList, 
                                  char* MakeUsageList, uint UsageListLength);

@DllImport("HID")
NTSTATUS HidP_TranslateUsagesToI8042ScanCodes(char* ChangedUsageList, uint UsageListLength, 
                                              HIDP_KEYBOARD_DIRECTION KeyAction, 
                                              HIDP_KEYBOARD_MODIFIER_STATE* ModifierState, 
                                              PHIDP_INSERT_SCANCODES InsertCodesProcedure, void* InsertCodesContext);

@DllImport("HID")
ubyte HidD_GetAttributes(HANDLE HidDeviceObject, HIDD_ATTRIBUTES* Attributes);

@DllImport("HID")
void HidD_GetHidGuid(GUID* HidGuid);

@DllImport("HID")
ubyte HidD_GetPreparsedData(HANDLE HidDeviceObject, ptrdiff_t* PreparsedData);

@DllImport("HID")
ubyte HidD_FreePreparsedData(ptrdiff_t PreparsedData);

@DllImport("HID")
ubyte HidD_FlushQueue(HANDLE HidDeviceObject);

@DllImport("HID")
ubyte HidD_GetConfiguration(HANDLE HidDeviceObject, char* Configuration, uint ConfigurationLength);

@DllImport("HID")
ubyte HidD_SetConfiguration(HANDLE HidDeviceObject, char* Configuration, uint ConfigurationLength);

@DllImport("HID")
ubyte HidD_GetFeature(HANDLE HidDeviceObject, char* ReportBuffer, uint ReportBufferLength);

@DllImport("HID")
ubyte HidD_SetFeature(HANDLE HidDeviceObject, char* ReportBuffer, uint ReportBufferLength);

@DllImport("HID")
ubyte HidD_GetInputReport(HANDLE HidDeviceObject, char* ReportBuffer, uint ReportBufferLength);

@DllImport("HID")
ubyte HidD_SetOutputReport(HANDLE HidDeviceObject, char* ReportBuffer, uint ReportBufferLength);

@DllImport("HID")
ubyte HidD_GetNumInputBuffers(HANDLE HidDeviceObject, uint* NumberBuffers);

@DllImport("HID")
ubyte HidD_SetNumInputBuffers(HANDLE HidDeviceObject, uint NumberBuffers);

@DllImport("HID")
ubyte HidD_GetPhysicalDescriptor(HANDLE HidDeviceObject, char* Buffer, uint BufferLength);

@DllImport("HID")
ubyte HidD_GetManufacturerString(HANDLE HidDeviceObject, char* Buffer, uint BufferLength);

@DllImport("HID")
ubyte HidD_GetProductString(HANDLE HidDeviceObject, char* Buffer, uint BufferLength);

@DllImport("HID")
ubyte HidD_GetIndexedString(HANDLE HidDeviceObject, uint StringIndex, char* Buffer, uint BufferLength);

@DllImport("HID")
ubyte HidD_GetSerialNumberString(HANDLE HidDeviceObject, char* Buffer, uint BufferLength);

@DllImport("HID")
ubyte HidD_GetMsGenreDescriptor(HANDLE HidDeviceObject, char* Buffer, uint BufferLength);


// Interfaces

interface IDirectInputEffect : IUnknown
{
    HRESULT Initialize(HINSTANCE param0, uint param1, const(GUID)* param2);
    HRESULT GetEffectGuid(GUID* param0);
    HRESULT GetParameters(DIEFFECT* param0, uint param1);
    HRESULT SetParameters(DIEFFECT* param0, uint param1);
    HRESULT Start(uint param0, uint param1);
    HRESULT Stop();
    HRESULT GetEffectStatus(uint* param0);
    HRESULT Download();
    HRESULT Unload();
    HRESULT Escape(DIEFFESCAPE* param0);
}

interface IDirectInputDeviceW : IUnknown
{
    HRESULT GetCapabilities(DIDEVCAPS* param0);
    HRESULT EnumObjects(LPDIENUMDEVICEOBJECTSCALLBACKW param0, void* param1, uint param2);
    HRESULT GetProperty(const(GUID)* param0, DIPROPHEADER* param1);
    HRESULT SetProperty(const(GUID)* param0, DIPROPHEADER* param1);
    HRESULT Acquire();
    HRESULT Unacquire();
    HRESULT GetDeviceState(uint param0, void* param1);
    HRESULT GetDeviceData(uint param0, DIDEVICEOBJECTDATA* param1, uint* param2, uint param3);
    HRESULT SetDataFormat(DIDATAFORMAT* param0);
    HRESULT SetEventNotification(HANDLE param0);
    HRESULT SetCooperativeLevel(HWND param0, uint param1);
    HRESULT GetObjectInfo(DIDEVICEOBJECTINSTANCEW* param0, uint param1, uint param2);
    HRESULT GetDeviceInfo(DIDEVICEINSTANCEW* param0);
    HRESULT RunControlPanel(HWND param0, uint param1);
    HRESULT Initialize(HINSTANCE param0, uint param1, const(GUID)* param2);
}

interface IDirectInputDeviceA : IUnknown
{
    HRESULT GetCapabilities(DIDEVCAPS* param0);
    HRESULT EnumObjects(LPDIENUMDEVICEOBJECTSCALLBACKA param0, void* param1, uint param2);
    HRESULT GetProperty(const(GUID)* param0, DIPROPHEADER* param1);
    HRESULT SetProperty(const(GUID)* param0, DIPROPHEADER* param1);
    HRESULT Acquire();
    HRESULT Unacquire();
    HRESULT GetDeviceState(uint param0, void* param1);
    HRESULT GetDeviceData(uint param0, DIDEVICEOBJECTDATA* param1, uint* param2, uint param3);
    HRESULT SetDataFormat(DIDATAFORMAT* param0);
    HRESULT SetEventNotification(HANDLE param0);
    HRESULT SetCooperativeLevel(HWND param0, uint param1);
    HRESULT GetObjectInfo(DIDEVICEOBJECTINSTANCEA* param0, uint param1, uint param2);
    HRESULT GetDeviceInfo(DIDEVICEINSTANCEA* param0);
    HRESULT RunControlPanel(HWND param0, uint param1);
    HRESULT Initialize(HINSTANCE param0, uint param1, const(GUID)* param2);
}

interface IDirectInputDevice2W : IDirectInputDeviceW
{
    HRESULT CreateEffect(const(GUID)* param0, DIEFFECT* param1, IDirectInputEffect* param2, IUnknown param3);
    HRESULT EnumEffects(LPDIENUMEFFECTSCALLBACKW param0, void* param1, uint param2);
    HRESULT GetEffectInfo(DIEFFECTINFOW* param0, const(GUID)* param1);
    HRESULT GetForceFeedbackState(uint* param0);
    HRESULT SendForceFeedbackCommand(uint param0);
    HRESULT EnumCreatedEffectObjects(LPDIENUMCREATEDEFFECTOBJECTSCALLBACK param0, void* param1, uint param2);
    HRESULT Escape(DIEFFESCAPE* param0);
    HRESULT Poll();
    HRESULT SendDeviceData(uint param0, DIDEVICEOBJECTDATA* param1, uint* param2, uint param3);
}

interface IDirectInputDevice2A : IDirectInputDeviceA
{
    HRESULT CreateEffect(const(GUID)* param0, DIEFFECT* param1, IDirectInputEffect* param2, IUnknown param3);
    HRESULT EnumEffects(LPDIENUMEFFECTSCALLBACKA param0, void* param1, uint param2);
    HRESULT GetEffectInfo(DIEFFECTINFOA* param0, const(GUID)* param1);
    HRESULT GetForceFeedbackState(uint* param0);
    HRESULT SendForceFeedbackCommand(uint param0);
    HRESULT EnumCreatedEffectObjects(LPDIENUMCREATEDEFFECTOBJECTSCALLBACK param0, void* param1, uint param2);
    HRESULT Escape(DIEFFESCAPE* param0);
    HRESULT Poll();
    HRESULT SendDeviceData(uint param0, DIDEVICEOBJECTDATA* param1, uint* param2, uint param3);
}

interface IDirectInputDevice7W : IDirectInputDevice2W
{
    HRESULT EnumEffectsInFile(const(wchar)* param0, LPDIENUMEFFECTSINFILECALLBACK param1, void* param2, 
                              uint param3);
    HRESULT WriteEffectToFile(const(wchar)* param0, uint param1, DIFILEEFFECT* param2, uint param3);
}

interface IDirectInputDevice7A : IDirectInputDevice2A
{
    HRESULT EnumEffectsInFile(const(char)* param0, LPDIENUMEFFECTSINFILECALLBACK param1, void* param2, uint param3);
    HRESULT WriteEffectToFile(const(char)* param0, uint param1, DIFILEEFFECT* param2, uint param3);
}

interface IDirectInputDevice8W : IUnknown
{
    HRESULT GetCapabilities(DIDEVCAPS* param0);
    HRESULT EnumObjects(LPDIENUMDEVICEOBJECTSCALLBACKW param0, void* param1, uint param2);
    HRESULT GetProperty(const(GUID)* param0, DIPROPHEADER* param1);
    HRESULT SetProperty(const(GUID)* param0, DIPROPHEADER* param1);
    HRESULT Acquire();
    HRESULT Unacquire();
    HRESULT GetDeviceState(uint param0, void* param1);
    HRESULT GetDeviceData(uint param0, DIDEVICEOBJECTDATA* param1, uint* param2, uint param3);
    HRESULT SetDataFormat(DIDATAFORMAT* param0);
    HRESULT SetEventNotification(HANDLE param0);
    HRESULT SetCooperativeLevel(HWND param0, uint param1);
    HRESULT GetObjectInfo(DIDEVICEOBJECTINSTANCEW* param0, uint param1, uint param2);
    HRESULT GetDeviceInfo(DIDEVICEINSTANCEW* param0);
    HRESULT RunControlPanel(HWND param0, uint param1);
    HRESULT Initialize(HINSTANCE param0, uint param1, const(GUID)* param2);
    HRESULT CreateEffect(const(GUID)* param0, DIEFFECT* param1, IDirectInputEffect* param2, IUnknown param3);
    HRESULT EnumEffects(LPDIENUMEFFECTSCALLBACKW param0, void* param1, uint param2);
    HRESULT GetEffectInfo(DIEFFECTINFOW* param0, const(GUID)* param1);
    HRESULT GetForceFeedbackState(uint* param0);
    HRESULT SendForceFeedbackCommand(uint param0);
    HRESULT EnumCreatedEffectObjects(LPDIENUMCREATEDEFFECTOBJECTSCALLBACK param0, void* param1, uint param2);
    HRESULT Escape(DIEFFESCAPE* param0);
    HRESULT Poll();
    HRESULT SendDeviceData(uint param0, DIDEVICEOBJECTDATA* param1, uint* param2, uint param3);
    HRESULT EnumEffectsInFile(const(wchar)* param0, LPDIENUMEFFECTSINFILECALLBACK param1, void* param2, 
                              uint param3);
    HRESULT WriteEffectToFile(const(wchar)* param0, uint param1, DIFILEEFFECT* param2, uint param3);
    HRESULT BuildActionMap(DIACTIONFORMATW* param0, const(wchar)* param1, uint param2);
    HRESULT SetActionMap(DIACTIONFORMATW* param0, const(wchar)* param1, uint param2);
    HRESULT GetImageInfo(DIDEVICEIMAGEINFOHEADERW* param0);
}

interface IDirectInputDevice8A : IUnknown
{
    HRESULT GetCapabilities(DIDEVCAPS* param0);
    HRESULT EnumObjects(LPDIENUMDEVICEOBJECTSCALLBACKA param0, void* param1, uint param2);
    HRESULT GetProperty(const(GUID)* param0, DIPROPHEADER* param1);
    HRESULT SetProperty(const(GUID)* param0, DIPROPHEADER* param1);
    HRESULT Acquire();
    HRESULT Unacquire();
    HRESULT GetDeviceState(uint param0, void* param1);
    HRESULT GetDeviceData(uint param0, DIDEVICEOBJECTDATA* param1, uint* param2, uint param3);
    HRESULT SetDataFormat(DIDATAFORMAT* param0);
    HRESULT SetEventNotification(HANDLE param0);
    HRESULT SetCooperativeLevel(HWND param0, uint param1);
    HRESULT GetObjectInfo(DIDEVICEOBJECTINSTANCEA* param0, uint param1, uint param2);
    HRESULT GetDeviceInfo(DIDEVICEINSTANCEA* param0);
    HRESULT RunControlPanel(HWND param0, uint param1);
    HRESULT Initialize(HINSTANCE param0, uint param1, const(GUID)* param2);
    HRESULT CreateEffect(const(GUID)* param0, DIEFFECT* param1, IDirectInputEffect* param2, IUnknown param3);
    HRESULT EnumEffects(LPDIENUMEFFECTSCALLBACKA param0, void* param1, uint param2);
    HRESULT GetEffectInfo(DIEFFECTINFOA* param0, const(GUID)* param1);
    HRESULT GetForceFeedbackState(uint* param0);
    HRESULT SendForceFeedbackCommand(uint param0);
    HRESULT EnumCreatedEffectObjects(LPDIENUMCREATEDEFFECTOBJECTSCALLBACK param0, void* param1, uint param2);
    HRESULT Escape(DIEFFESCAPE* param0);
    HRESULT Poll();
    HRESULT SendDeviceData(uint param0, DIDEVICEOBJECTDATA* param1, uint* param2, uint param3);
    HRESULT EnumEffectsInFile(const(char)* param0, LPDIENUMEFFECTSINFILECALLBACK param1, void* param2, uint param3);
    HRESULT WriteEffectToFile(const(char)* param0, uint param1, DIFILEEFFECT* param2, uint param3);
    HRESULT BuildActionMap(DIACTIONFORMATA* param0, const(char)* param1, uint param2);
    HRESULT SetActionMap(DIACTIONFORMATA* param0, const(char)* param1, uint param2);
    HRESULT GetImageInfo(DIDEVICEIMAGEINFOHEADERA* param0);
}

interface IDirectInputW : IUnknown
{
    HRESULT CreateDevice(const(GUID)* param0, IDirectInputDeviceW* param1, IUnknown param2);
    HRESULT EnumDevices(uint param0, LPDIENUMDEVICESCALLBACKW param1, void* param2, uint param3);
    HRESULT GetDeviceStatus(const(GUID)* param0);
    HRESULT RunControlPanel(HWND param0, uint param1);
    HRESULT Initialize(HINSTANCE param0, uint param1);
}

interface IDirectInputA : IUnknown
{
    HRESULT CreateDevice(const(GUID)* param0, IDirectInputDeviceA* param1, IUnknown param2);
    HRESULT EnumDevices(uint param0, LPDIENUMDEVICESCALLBACKA param1, void* param2, uint param3);
    HRESULT GetDeviceStatus(const(GUID)* param0);
    HRESULT RunControlPanel(HWND param0, uint param1);
    HRESULT Initialize(HINSTANCE param0, uint param1);
}

interface IDirectInput2W : IDirectInputW
{
    HRESULT FindDevice(const(GUID)* param0, const(wchar)* param1, GUID* param2);
}

interface IDirectInput2A : IDirectInputA
{
    HRESULT FindDevice(const(GUID)* param0, const(char)* param1, GUID* param2);
}

interface IDirectInput7W : IDirectInput2W
{
    HRESULT CreateDeviceEx(const(GUID)* param0, const(GUID)* param1, void** param2, IUnknown param3);
}

interface IDirectInput7A : IDirectInput2A
{
    HRESULT CreateDeviceEx(const(GUID)* param0, const(GUID)* param1, void** param2, IUnknown param3);
}

interface IDirectInput8W : IUnknown
{
    HRESULT CreateDevice(const(GUID)* param0, IDirectInputDevice8W* param1, IUnknown param2);
    HRESULT EnumDevices(uint param0, LPDIENUMDEVICESCALLBACKW param1, void* param2, uint param3);
    HRESULT GetDeviceStatus(const(GUID)* param0);
    HRESULT RunControlPanel(HWND param0, uint param1);
    HRESULT Initialize(HINSTANCE param0, uint param1);
    HRESULT FindDevice(const(GUID)* param0, const(wchar)* param1, GUID* param2);
    HRESULT EnumDevicesBySemantics(const(wchar)* param0, DIACTIONFORMATW* param1, 
                                   LPDIENUMDEVICESBYSEMANTICSCBW param2, void* param3, uint param4);
    HRESULT ConfigureDevices(LPDICONFIGUREDEVICESCALLBACK param0, DICONFIGUREDEVICESPARAMSW* param1, uint param2, 
                             void* param3);
}

interface IDirectInput8A : IUnknown
{
    HRESULT CreateDevice(const(GUID)* param0, IDirectInputDevice8A* param1, IUnknown param2);
    HRESULT EnumDevices(uint param0, LPDIENUMDEVICESCALLBACKA param1, void* param2, uint param3);
    HRESULT GetDeviceStatus(const(GUID)* param0);
    HRESULT RunControlPanel(HWND param0, uint param1);
    HRESULT Initialize(HINSTANCE param0, uint param1);
    HRESULT FindDevice(const(GUID)* param0, const(char)* param1, GUID* param2);
    HRESULT EnumDevicesBySemantics(const(char)* param0, DIACTIONFORMATA* param1, 
                                   LPDIENUMDEVICESBYSEMANTICSCBA param2, void* param3, uint param4);
    HRESULT ConfigureDevices(LPDICONFIGUREDEVICESCALLBACK param0, DICONFIGUREDEVICESPARAMSA* param1, uint param2, 
                             void* param3);
}

interface IDirectInputEffectDriver : IUnknown
{
    HRESULT DeviceID(uint param0, uint param1, uint param2, uint param3, void* param4);
    HRESULT GetVersions(DIDRIVERVERSIONS* param0);
    HRESULT Escape(uint param0, uint param1, DIEFFESCAPE* param2);
    HRESULT SetGain(uint param0, uint param1);
    HRESULT SendForceFeedbackCommand(uint param0, uint param1);
    HRESULT GetForceFeedbackState(uint param0, DIDEVICESTATE* param1);
    HRESULT DownloadEffect(uint param0, uint param1, uint* param2, DIEFFECT* param3, uint param4);
    HRESULT DestroyEffect(uint param0, uint param1);
    HRESULT StartEffect(uint param0, uint param1, uint param2, uint param3);
    HRESULT StopEffect(uint param0, uint param1);
    HRESULT GetEffectStatus(uint param0, uint param1, uint* param2);
}

interface IDirectInputJoyConfig : IUnknown
{
    HRESULT Acquire();
    HRESULT Unacquire();
    HRESULT SetCooperativeLevel(HWND param0, uint param1);
    HRESULT SendNotify();
    HRESULT EnumTypes(LPDIJOYTYPECALLBACK param0, void* param1);
    HRESULT GetTypeInfo(const(wchar)* param0, DIJOYTYPEINFO* param1, uint param2);
    HRESULT SetTypeInfo(const(wchar)* param0, DIJOYTYPEINFO* param1, uint param2);
    HRESULT DeleteType(const(wchar)* param0);
    HRESULT GetConfig(uint param0, DIJOYCONFIG* param1, uint param2);
    HRESULT SetConfig(uint param0, DIJOYCONFIG* param1, uint param2);
    HRESULT DeleteConfig(uint param0);
    HRESULT GetUserValues(DIJOYUSERVALUES* param0, uint param1);
    HRESULT SetUserValues(DIJOYUSERVALUES* param0, uint param1);
    HRESULT AddNewHardware(HWND param0, const(GUID)* param1);
    HRESULT OpenTypeKey(const(wchar)* param0, uint param1, HKEY* param2);
    HRESULT OpenConfigKey(uint param0, uint param1, HKEY* param2);
}

interface IDirectInputJoyConfig8 : IUnknown
{
    HRESULT Acquire();
    HRESULT Unacquire();
    HRESULT SetCooperativeLevel(HWND param0, uint param1);
    HRESULT SendNotify();
    HRESULT EnumTypes(LPDIJOYTYPECALLBACK param0, void* param1);
    HRESULT GetTypeInfo(const(wchar)* param0, DIJOYTYPEINFO* param1, uint param2);
    HRESULT SetTypeInfo(const(wchar)* param0, DIJOYTYPEINFO* param1, uint param2, const(wchar)* param3);
    HRESULT DeleteType(const(wchar)* param0);
    HRESULT GetConfig(uint param0, DIJOYCONFIG* param1, uint param2);
    HRESULT SetConfig(uint param0, DIJOYCONFIG* param1, uint param2);
    HRESULT DeleteConfig(uint param0);
    HRESULT GetUserValues(DIJOYUSERVALUES* param0, uint param1);
    HRESULT SetUserValues(DIJOYUSERVALUES* param0, uint param1);
    HRESULT AddNewHardware(HWND param0, const(GUID)* param1);
    HRESULT OpenTypeKey(const(wchar)* param0, uint param1, HKEY* param2);
    HRESULT OpenAppStatusKey(HKEY* param0);
}


