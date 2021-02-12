module windows.hid;

public import system;
public import windows.com;
public import windows.displaydevices;
public import windows.multimedia;
public import windows.systemservices;
public import windows.windowsandmessaging;
public import windows.windowsprogramming;

extern(Windows):

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
    int lOffset;
    uint dwPhase;
    uint dwPeriod;
}

struct DICONDITION
{
    int lOffset;
    int lPositiveCoefficient;
    int lNegativeCoefficient;
    uint dwPositiveSaturation;
    uint dwNegativeSaturation;
    int lDeadBand;
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
    uint dwSize;
    uint dwFlags;
    uint dwDuration;
    uint dwSamplePeriod;
    uint dwGain;
    uint dwTriggerButton;
    uint dwTriggerRepeatInterval;
    uint cAxes;
    uint* rgdwAxes;
    int* rglDirection;
    DIENVELOPE* lpEnvelope;
    uint cbTypeSpecificParams;
    void* lpvTypeSpecificParams;
}

struct DIEFFECT
{
    uint dwSize;
    uint dwFlags;
    uint dwDuration;
    uint dwSamplePeriod;
    uint dwGain;
    uint dwTriggerButton;
    uint dwTriggerRepeatInterval;
    uint cAxes;
    uint* rgdwAxes;
    int* rglDirection;
    DIENVELOPE* lpEnvelope;
    uint cbTypeSpecificParams;
    void* lpvTypeSpecificParams;
    uint dwStartDelay;
}

struct DIFILEEFFECT
{
    uint dwSize;
    Guid GuidEffect;
    DIEFFECT* lpDiEffect;
    byte szFriendlyName;
}

alias LPDIENUMEFFECTSINFILECALLBACK = extern(Windows) BOOL function(DIFILEEFFECT* param0, void* param1);
struct DIEFFESCAPE
{
    uint dwSize;
    uint dwCommand;
    void* lpvInBuffer;
    uint cbInBuffer;
    void* lpvOutBuffer;
    uint cbOutBuffer;
}

interface IDirectInputEffect : IUnknown
{
    HRESULT Initialize(HINSTANCE param0, uint param1, const(Guid)* param2);
    HRESULT GetEffectGuid(Guid* param0);
    HRESULT GetParameters(DIEFFECT* param0, uint param1);
    HRESULT SetParameters(DIEFFECT* param0, uint param1);
    HRESULT Start(uint param0, uint param1);
    HRESULT Stop();
    HRESULT GetEffectStatus(uint* param0);
    HRESULT Download();
    HRESULT Unload();
    HRESULT Escape(DIEFFESCAPE* param0);
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
    const(Guid)* pguid;
    uint dwOfs;
    uint dwType;
    uint dwFlags;
}

struct DIDATAFORMAT
{
    uint dwSize;
    uint dwObjSize;
    uint dwFlags;
    uint dwDataSize;
    uint dwNumObjs;
    DIOBJECTDATAFORMAT* rgodf;
}

struct DIACTIONA
{
    uint uAppData;
    uint dwSemantic;
    uint dwFlags;
    _Anonymous_e__Union Anonymous;
    Guid guidInstance;
    uint dwObjID;
    uint dwHow;
}

struct DIACTIONW
{
    uint uAppData;
    uint dwSemantic;
    uint dwFlags;
    _Anonymous_e__Union Anonymous;
    Guid guidInstance;
    uint dwObjID;
    uint dwHow;
}

struct DIACTIONFORMATA
{
    uint dwSize;
    uint dwActionSize;
    uint dwDataSize;
    uint dwNumActions;
    DIACTIONA* rgoAction;
    Guid guidActionMap;
    uint dwGenre;
    uint dwBufferSize;
    int lAxisMin;
    int lAxisMax;
    HINSTANCE hInstString;
    FILETIME ftTimeStamp;
    uint dwCRC;
    byte tszActionMap;
}

struct DIACTIONFORMATW
{
    uint dwSize;
    uint dwActionSize;
    uint dwDataSize;
    uint dwNumActions;
    DIACTIONW* rgoAction;
    Guid guidActionMap;
    uint dwGenre;
    uint dwBufferSize;
    int lAxisMin;
    int lAxisMax;
    HINSTANCE hInstString;
    FILETIME ftTimeStamp;
    uint dwCRC;
    ushort tszActionMap;
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
    uint dwSize;
    uint dwcUsers;
    const(char)* lptszUserNames;
    uint dwcFormats;
    DIACTIONFORMATA* lprgFormats;
    HWND hwnd;
    DICOLORSET dics;
    IUnknown lpUnkDDSTarget;
}

struct DICONFIGUREDEVICESPARAMSW
{
    uint dwSize;
    uint dwcUsers;
    const(wchar)* lptszUserNames;
    uint dwcFormats;
    DIACTIONFORMATW* lprgFormats;
    HWND hwnd;
    DICOLORSET dics;
    IUnknown lpUnkDDSTarget;
}

struct DIDEVICEIMAGEINFOA
{
    byte tszImagePath;
    uint dwFlags;
    uint dwViewID;
    RECT rcOverlay;
    uint dwObjID;
    uint dwcValidPts;
    POINT rgptCalloutLine;
    RECT rcCalloutRect;
    uint dwTextAlign;
}

struct DIDEVICEIMAGEINFOW
{
    ushort tszImagePath;
    uint dwFlags;
    uint dwViewID;
    RECT rcOverlay;
    uint dwObjID;
    uint dwcValidPts;
    POINT rgptCalloutLine;
    RECT rcCalloutRect;
    uint dwTextAlign;
}

struct DIDEVICEIMAGEINFOHEADERA
{
    uint dwSize;
    uint dwSizeImageInfo;
    uint dwcViews;
    uint dwcButtons;
    uint dwcAxes;
    uint dwcPOVs;
    uint dwBufferSize;
    uint dwBufferUsed;
    DIDEVICEIMAGEINFOA* lprgImageInfoArray;
}

struct DIDEVICEIMAGEINFOHEADERW
{
    uint dwSize;
    uint dwSizeImageInfo;
    uint dwcViews;
    uint dwcButtons;
    uint dwcAxes;
    uint dwcPOVs;
    uint dwBufferSize;
    uint dwBufferUsed;
    DIDEVICEIMAGEINFOW* lprgImageInfoArray;
}

struct DIDEVICEOBJECTINSTANCE_DX3A
{
    uint dwSize;
    Guid guidType;
    uint dwOfs;
    uint dwType;
    uint dwFlags;
    byte tszName;
}

struct DIDEVICEOBJECTINSTANCE_DX3W
{
    uint dwSize;
    Guid guidType;
    uint dwOfs;
    uint dwType;
    uint dwFlags;
    ushort tszName;
}

struct DIDEVICEOBJECTINSTANCEA
{
    uint dwSize;
    Guid guidType;
    uint dwOfs;
    uint dwType;
    uint dwFlags;
    byte tszName;
    uint dwFFMaxForce;
    uint dwFFForceResolution;
    ushort wCollectionNumber;
    ushort wDesignatorIndex;
    ushort wUsagePage;
    ushort wUsage;
    uint dwDimension;
    ushort wExponent;
    ushort wReportId;
}

struct DIDEVICEOBJECTINSTANCEW
{
    uint dwSize;
    Guid guidType;
    uint dwOfs;
    uint dwType;
    uint dwFlags;
    ushort tszName;
    uint dwFFMaxForce;
    uint dwFFForceResolution;
    ushort wCollectionNumber;
    ushort wDesignatorIndex;
    ushort wUsagePage;
    ushort wUsage;
    uint dwDimension;
    ushort wExponent;
    ushort wReportId;
}

alias LPDIENUMDEVICEOBJECTSCALLBACKA = extern(Windows) BOOL function(DIDEVICEOBJECTINSTANCEA* param0, void* param1);
alias LPDIENUMDEVICEOBJECTSCALLBACKW = extern(Windows) BOOL function(DIDEVICEOBJECTINSTANCEW* param0, void* param1);
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
    uint dwData;
}

struct DIPROPPOINTER
{
    DIPROPHEADER diph;
    uint uData;
}

struct DIPROPRANGE
{
    DIPROPHEADER diph;
    int lMin;
    int lMax;
}

struct DIPROPCAL
{
    DIPROPHEADER diph;
    int lMin;
    int lCenter;
    int lMax;
}

struct DIPROPCALPOV
{
    DIPROPHEADER diph;
    int lMin;
    int lMax;
}

struct DIPROPGUIDANDPATH
{
    DIPROPHEADER diph;
    Guid guidClass;
    ushort wszPath;
}

struct DIPROPSTRING
{
    DIPROPHEADER diph;
    ushort wsz;
}

struct CPOINT
{
    int lP;
    uint dwLog;
}

struct DIPROPCPOINTS
{
    DIPROPHEADER diph;
    uint dwCPointsNum;
    CPOINT cp;
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
    uint dwOfs;
    uint dwData;
    uint dwTimeStamp;
    uint dwSequence;
    uint uAppData;
}

struct DIDEVICEINSTANCE_DX3A
{
    uint dwSize;
    Guid guidInstance;
    Guid guidProduct;
    uint dwDevType;
    byte tszInstanceName;
    byte tszProductName;
}

struct DIDEVICEINSTANCE_DX3W
{
    uint dwSize;
    Guid guidInstance;
    Guid guidProduct;
    uint dwDevType;
    ushort tszInstanceName;
    ushort tszProductName;
}

struct DIDEVICEINSTANCEA
{
    uint dwSize;
    Guid guidInstance;
    Guid guidProduct;
    uint dwDevType;
    byte tszInstanceName;
    byte tszProductName;
    Guid guidFFDriver;
    ushort wUsagePage;
    ushort wUsage;
}

struct DIDEVICEINSTANCEW
{
    uint dwSize;
    Guid guidInstance;
    Guid guidProduct;
    uint dwDevType;
    ushort tszInstanceName;
    ushort tszProductName;
    Guid guidFFDriver;
    ushort wUsagePage;
    ushort wUsage;
}

interface IDirectInputDeviceW : IUnknown
{
    HRESULT GetCapabilities(DIDEVCAPS* param0);
    HRESULT EnumObjects(LPDIENUMDEVICEOBJECTSCALLBACKW param0, void* param1, uint param2);
    HRESULT GetProperty(const(Guid)* param0, DIPROPHEADER* param1);
    HRESULT SetProperty(const(Guid)* param0, DIPROPHEADER* param1);
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
    HRESULT Initialize(HINSTANCE param0, uint param1, const(Guid)* param2);
}

interface IDirectInputDeviceA : IUnknown
{
    HRESULT GetCapabilities(DIDEVCAPS* param0);
    HRESULT EnumObjects(LPDIENUMDEVICEOBJECTSCALLBACKA param0, void* param1, uint param2);
    HRESULT GetProperty(const(Guid)* param0, DIPROPHEADER* param1);
    HRESULT SetProperty(const(Guid)* param0, DIPROPHEADER* param1);
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
    HRESULT Initialize(HINSTANCE param0, uint param1, const(Guid)* param2);
}

struct DIEFFECTINFOA
{
    uint dwSize;
    Guid guid;
    uint dwEffType;
    uint dwStaticParams;
    uint dwDynamicParams;
    byte tszName;
}

struct DIEFFECTINFOW
{
    uint dwSize;
    Guid guid;
    uint dwEffType;
    uint dwStaticParams;
    uint dwDynamicParams;
    ushort tszName;
}

alias LPDIENUMEFFECTSCALLBACKA = extern(Windows) BOOL function(DIEFFECTINFOA* param0, void* param1);
alias LPDIENUMEFFECTSCALLBACKW = extern(Windows) BOOL function(DIEFFECTINFOW* param0, void* param1);
alias LPDIENUMCREATEDEFFECTOBJECTSCALLBACK = extern(Windows) BOOL function(IDirectInputEffect param0, void* param1);
interface IDirectInputDevice2W : IDirectInputDeviceW
{
    HRESULT CreateEffect(const(Guid)* param0, DIEFFECT* param1, IDirectInputEffect* param2, IUnknown param3);
    HRESULT EnumEffects(LPDIENUMEFFECTSCALLBACKW param0, void* param1, uint param2);
    HRESULT GetEffectInfo(DIEFFECTINFOW* param0, const(Guid)* param1);
    HRESULT GetForceFeedbackState(uint* param0);
    HRESULT SendForceFeedbackCommand(uint param0);
    HRESULT EnumCreatedEffectObjects(LPDIENUMCREATEDEFFECTOBJECTSCALLBACK param0, void* param1, uint param2);
    HRESULT Escape(DIEFFESCAPE* param0);
    HRESULT Poll();
    HRESULT SendDeviceData(uint param0, DIDEVICEOBJECTDATA* param1, uint* param2, uint param3);
}

interface IDirectInputDevice2A : IDirectInputDeviceA
{
    HRESULT CreateEffect(const(Guid)* param0, DIEFFECT* param1, IDirectInputEffect* param2, IUnknown param3);
    HRESULT EnumEffects(LPDIENUMEFFECTSCALLBACKA param0, void* param1, uint param2);
    HRESULT GetEffectInfo(DIEFFECTINFOA* param0, const(Guid)* param1);
    HRESULT GetForceFeedbackState(uint* param0);
    HRESULT SendForceFeedbackCommand(uint param0);
    HRESULT EnumCreatedEffectObjects(LPDIENUMCREATEDEFFECTOBJECTSCALLBACK param0, void* param1, uint param2);
    HRESULT Escape(DIEFFESCAPE* param0);
    HRESULT Poll();
    HRESULT SendDeviceData(uint param0, DIDEVICEOBJECTDATA* param1, uint* param2, uint param3);
}

interface IDirectInputDevice7W : IDirectInputDevice2W
{
    HRESULT EnumEffectsInFile(const(wchar)* param0, LPDIENUMEFFECTSINFILECALLBACK param1, void* param2, uint param3);
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
    HRESULT GetProperty(const(Guid)* param0, DIPROPHEADER* param1);
    HRESULT SetProperty(const(Guid)* param0, DIPROPHEADER* param1);
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
    HRESULT Initialize(HINSTANCE param0, uint param1, const(Guid)* param2);
    HRESULT CreateEffect(const(Guid)* param0, DIEFFECT* param1, IDirectInputEffect* param2, IUnknown param3);
    HRESULT EnumEffects(LPDIENUMEFFECTSCALLBACKW param0, void* param1, uint param2);
    HRESULT GetEffectInfo(DIEFFECTINFOW* param0, const(Guid)* param1);
    HRESULT GetForceFeedbackState(uint* param0);
    HRESULT SendForceFeedbackCommand(uint param0);
    HRESULT EnumCreatedEffectObjects(LPDIENUMCREATEDEFFECTOBJECTSCALLBACK param0, void* param1, uint param2);
    HRESULT Escape(DIEFFESCAPE* param0);
    HRESULT Poll();
    HRESULT SendDeviceData(uint param0, DIDEVICEOBJECTDATA* param1, uint* param2, uint param3);
    HRESULT EnumEffectsInFile(const(wchar)* param0, LPDIENUMEFFECTSINFILECALLBACK param1, void* param2, uint param3);
    HRESULT WriteEffectToFile(const(wchar)* param0, uint param1, DIFILEEFFECT* param2, uint param3);
    HRESULT BuildActionMap(DIACTIONFORMATW* param0, const(wchar)* param1, uint param2);
    HRESULT SetActionMap(DIACTIONFORMATW* param0, const(wchar)* param1, uint param2);
    HRESULT GetImageInfo(DIDEVICEIMAGEINFOHEADERW* param0);
}

interface IDirectInputDevice8A : IUnknown
{
    HRESULT GetCapabilities(DIDEVCAPS* param0);
    HRESULT EnumObjects(LPDIENUMDEVICEOBJECTSCALLBACKA param0, void* param1, uint param2);
    HRESULT GetProperty(const(Guid)* param0, DIPROPHEADER* param1);
    HRESULT SetProperty(const(Guid)* param0, DIPROPHEADER* param1);
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
    HRESULT Initialize(HINSTANCE param0, uint param1, const(Guid)* param2);
    HRESULT CreateEffect(const(Guid)* param0, DIEFFECT* param1, IDirectInputEffect* param2, IUnknown param3);
    HRESULT EnumEffects(LPDIENUMEFFECTSCALLBACKA param0, void* param1, uint param2);
    HRESULT GetEffectInfo(DIEFFECTINFOA* param0, const(Guid)* param1);
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

struct DIMOUSESTATE
{
    int lX;
    int lY;
    int lZ;
    ubyte rgbButtons;
}

struct DIMOUSESTATE2
{
    int lX;
    int lY;
    int lZ;
    ubyte rgbButtons;
}

struct DIJOYSTATE
{
    int lX;
    int lY;
    int lZ;
    int lRx;
    int lRy;
    int lRz;
    int rglSlider;
    uint rgdwPOV;
    ubyte rgbButtons;
}

struct DIJOYSTATE2
{
    int lX;
    int lY;
    int lZ;
    int lRx;
    int lRy;
    int lRz;
    int rglSlider;
    uint rgdwPOV;
    ubyte rgbButtons;
    int lVX;
    int lVY;
    int lVZ;
    int lVRx;
    int lVRy;
    int lVRz;
    int rglVSlider;
    int lAX;
    int lAY;
    int lAZ;
    int lARx;
    int lARy;
    int lARz;
    int rglASlider;
    int lFX;
    int lFY;
    int lFZ;
    int lFRx;
    int lFRy;
    int lFRz;
    int rglFSlider;
}

alias LPDIENUMDEVICESCALLBACKA = extern(Windows) BOOL function(DIDEVICEINSTANCEA* param0, void* param1);
alias LPDIENUMDEVICESCALLBACKW = extern(Windows) BOOL function(DIDEVICEINSTANCEW* param0, void* param1);
alias LPDICONFIGUREDEVICESCALLBACK = extern(Windows) BOOL function(IUnknown param0, void* param1);
alias LPDIENUMDEVICESBYSEMANTICSCBA = extern(Windows) BOOL function(DIDEVICEINSTANCEA* param0, IDirectInputDevice8A param1, uint param2, uint param3, void* param4);
alias LPDIENUMDEVICESBYSEMANTICSCBW = extern(Windows) BOOL function(DIDEVICEINSTANCEW* param0, IDirectInputDevice8W param1, uint param2, uint param3, void* param4);
interface IDirectInputW : IUnknown
{
    HRESULT CreateDevice(const(Guid)* param0, IDirectInputDeviceW* param1, IUnknown param2);
    HRESULT EnumDevices(uint param0, LPDIENUMDEVICESCALLBACKW param1, void* param2, uint param3);
    HRESULT GetDeviceStatus(const(Guid)* param0);
    HRESULT RunControlPanel(HWND param0, uint param1);
    HRESULT Initialize(HINSTANCE param0, uint param1);
}

interface IDirectInputA : IUnknown
{
    HRESULT CreateDevice(const(Guid)* param0, IDirectInputDeviceA* param1, IUnknown param2);
    HRESULT EnumDevices(uint param0, LPDIENUMDEVICESCALLBACKA param1, void* param2, uint param3);
    HRESULT GetDeviceStatus(const(Guid)* param0);
    HRESULT RunControlPanel(HWND param0, uint param1);
    HRESULT Initialize(HINSTANCE param0, uint param1);
}

interface IDirectInput2W : IDirectInputW
{
    HRESULT FindDevice(const(Guid)* param0, const(wchar)* param1, Guid* param2);
}

interface IDirectInput2A : IDirectInputA
{
    HRESULT FindDevice(const(Guid)* param0, const(char)* param1, Guid* param2);
}

interface IDirectInput7W : IDirectInput2W
{
    HRESULT CreateDeviceEx(const(Guid)* param0, const(Guid)* param1, void** param2, IUnknown param3);
}

interface IDirectInput7A : IDirectInput2A
{
    HRESULT CreateDeviceEx(const(Guid)* param0, const(Guid)* param1, void** param2, IUnknown param3);
}

interface IDirectInput8W : IUnknown
{
    HRESULT CreateDevice(const(Guid)* param0, IDirectInputDevice8W* param1, IUnknown param2);
    HRESULT EnumDevices(uint param0, LPDIENUMDEVICESCALLBACKW param1, void* param2, uint param3);
    HRESULT GetDeviceStatus(const(Guid)* param0);
    HRESULT RunControlPanel(HWND param0, uint param1);
    HRESULT Initialize(HINSTANCE param0, uint param1);
    HRESULT FindDevice(const(Guid)* param0, const(wchar)* param1, Guid* param2);
    HRESULT EnumDevicesBySemantics(const(wchar)* param0, DIACTIONFORMATW* param1, LPDIENUMDEVICESBYSEMANTICSCBW param2, void* param3, uint param4);
    HRESULT ConfigureDevices(LPDICONFIGUREDEVICESCALLBACK param0, DICONFIGUREDEVICESPARAMSW* param1, uint param2, void* param3);
}

interface IDirectInput8A : IUnknown
{
    HRESULT CreateDevice(const(Guid)* param0, IDirectInputDevice8A* param1, IUnknown param2);
    HRESULT EnumDevices(uint param0, LPDIENUMDEVICESCALLBACKA param1, void* param2, uint param3);
    HRESULT GetDeviceStatus(const(Guid)* param0);
    HRESULT RunControlPanel(HWND param0, uint param1);
    HRESULT Initialize(HINSTANCE param0, uint param1);
    HRESULT FindDevice(const(Guid)* param0, const(char)* param1, Guid* param2);
    HRESULT EnumDevicesBySemantics(const(char)* param0, DIACTIONFORMATA* param1, LPDIENUMDEVICESBYSEMANTICSCBA param2, void* param3, uint param4);
    HRESULT ConfigureDevices(LPDICONFIGUREDEVICESCALLBACK param0, DICONFIGUREDEVICESPARAMSA* param1, uint param2, void* param3);
}

alias LPFNSHOWJOYCPL = extern(Windows) void function(HWND hWnd);
struct DIOBJECTATTRIBUTES
{
    uint dwFlags;
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
    int lMin;
    int lMax;
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
    uint dwSize;
    const(wchar)* pwszDeviceInterface;
    Guid GuidInstance;
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

alias LPDIJOYTYPECALLBACK = extern(Windows) BOOL function(const(wchar)* param0, void* param1);
struct DIJOYTYPEINFO_DX5
{
    uint dwSize;
    joyreghwsettings_tag hws;
    Guid clsidConfig;
    ushort wszDisplayName;
    ushort wszCallout;
}

struct DIJOYTYPEINFO_DX6
{
    uint dwSize;
    joyreghwsettings_tag hws;
    Guid clsidConfig;
    ushort wszDisplayName;
    ushort wszCallout;
    ushort wszHardwareId;
    uint dwFlags1;
}

struct DIJOYTYPEINFO
{
    uint dwSize;
    joyreghwsettings_tag hws;
    Guid clsidConfig;
    ushort wszDisplayName;
    ushort wszCallout;
    ushort wszHardwareId;
    uint dwFlags1;
    uint dwFlags2;
    ushort wszMapFile;
}

struct DIJOYCONFIG_DX5
{
    uint dwSize;
    Guid guidInstance;
    joyreghwconfig_tag hwc;
    uint dwGain;
    ushort wszType;
    ushort wszCallout;
}

struct DIJOYCONFIG
{
    uint dwSize;
    Guid guidInstance;
    joyreghwconfig_tag hwc;
    uint dwGain;
    ushort wszType;
    ushort wszCallout;
    Guid guidGameport;
}

struct DIJOYUSERVALUES
{
    uint dwSize;
    joyreguservalues_tag ruv;
    ushort wszGlobalDriver;
    ushort wszGameportEmulator;
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
    HRESULT AddNewHardware(HWND param0, const(Guid)* param1);
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
    HRESULT AddNewHardware(HWND param0, const(Guid)* param1);
    HRESULT OpenTypeKey(const(wchar)* param0, uint param1, HKEY* param2);
    HRESULT OpenAppStatusKey(HKEY* param0);
}

struct KEYBOARD_INPUT_DATA
{
    ushort UnitId;
    ushort MakeCode;
    ushort Flags;
    ushort Reserved;
    uint ExtraInformation;
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
    ushort KeyboardMode;
    ushort NumberOfFunctionKeys;
    ushort NumberOfIndicators;
    ushort NumberOfKeysTotal;
    uint InputDataQueueLength;
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
    ushort NumberOfIndicatorKeys;
    INDICATOR_LIST IndicatorList;
}

struct KEYBOARD_UNIT_ID_PARAMETER
{
    ushort UnitId;
}

struct KEYBOARD_IME_STATUS
{
    ushort UnitId;
    uint ImeOpen;
    uint ImeConvMode;
}

struct MOUSE_INPUT_DATA
{
    ushort UnitId;
    ushort Flags;
    _Anonymous_e__Union Anonymous;
    uint RawButtons;
    int LastX;
    int LastY;
    uint ExtraInformation;
}

struct MOUSE_ATTRIBUTES
{
    ushort MouseIdentifier;
    ushort NumberOfButtons;
    ushort SampleRate;
    uint InputDataQueueLength;
}

struct MOUSE_UNIT_ID_PARAMETER
{
    ushort UnitId;
}

enum HIDP_REPORT_TYPE
{
    HidP_Input = 0,
    HidP_Output = 1,
    HidP_Feature = 2,
}

struct USAGE_AND_PAGE
{
    ushort Usage;
    ushort UsagePage;
}

struct HIDP_BUTTON_CAPS
{
    ushort UsagePage;
    ubyte ReportID;
    ubyte IsAlias;
    ushort BitField;
    ushort LinkCollection;
    ushort LinkUsage;
    ushort LinkUsagePage;
    ubyte IsRange;
    ubyte IsStringRange;
    ubyte IsDesignatorRange;
    ubyte IsAbsolute;
    uint Reserved;
    _Anonymous_e__Union Anonymous;
}

struct HIDP_VALUE_CAPS
{
    ushort UsagePage;
    ubyte ReportID;
    ubyte IsAlias;
    ushort BitField;
    ushort LinkCollection;
    ushort LinkUsage;
    ushort LinkUsagePage;
    ubyte IsRange;
    ubyte IsStringRange;
    ubyte IsDesignatorRange;
    ubyte IsAbsolute;
    ubyte HasNull;
    ubyte Reserved;
    ushort BitSize;
    ushort ReportCount;
    ushort Reserved2;
    uint UnitsExp;
    uint Units;
    int LogicalMin;
    int LogicalMax;
    int PhysicalMin;
    int PhysicalMax;
    _Anonymous_e__Union Anonymous;
}

struct HIDP_LINK_COLLECTION_NODE
{
    ushort LinkUsage;
    ushort LinkUsagePage;
    ushort Parent;
    ushort NumberOfChildren;
    ushort NextSibling;
    ushort FirstChild;
    uint _bitfield;
    void* UserContext;
}

struct _HIDP_PREPARSED_DATA
{
}

struct HIDP_CAPS
{
    ushort Usage;
    ushort UsagePage;
    ushort InputReportByteLength;
    ushort OutputReportByteLength;
    ushort FeatureReportByteLength;
    ushort Reserved;
    ushort NumberLinkCollectionNodes;
    ushort NumberInputButtonCaps;
    ushort NumberInputValueCaps;
    ushort NumberInputDataIndices;
    ushort NumberOutputButtonCaps;
    ushort NumberOutputValueCaps;
    ushort NumberOutputDataIndices;
    ushort NumberFeatureButtonCaps;
    ushort NumberFeatureValueCaps;
    ushort NumberFeatureDataIndices;
}

struct HIDP_DATA
{
    ushort DataIndex;
    ushort Reserved;
    _Anonymous_e__Union Anonymous;
}

struct HIDP_UNKNOWN_TOKEN
{
    ubyte Token;
    ubyte Reserved;
    uint BitField;
}

struct HIDP_EXTENDED_ATTRIBUTES
{
    ubyte NumGlobalUnknowns;
    ubyte Reserved;
    HIDP_UNKNOWN_TOKEN* GlobalUnknowns;
    uint Data;
}

enum HIDP_KEYBOARD_DIRECTION
{
    HidP_Keyboard_Break = 0,
    HidP_Keyboard_Make = 1,
}

struct HIDP_KEYBOARD_MODIFIER_STATE
{
    _Anonymous_e__Union Anonymous;
}

alias PHIDP_INSERT_SCANCODES = extern(Windows) ubyte function(void* Context, const(char)* NewScanCodes, uint Length);
struct HIDD_CONFIGURATION
{
    void* cookie;
    uint size;
    uint RingBufferSize;
}

struct HIDD_ATTRIBUTES
{
    uint Size;
    ushort VendorID;
    ushort ProductID;
    ushort VersionNumber;
}

@DllImport("DINPUT8.dll")
HRESULT DirectInput8Create(HINSTANCE hinst, uint dwVersion, const(Guid)* riidltf, void** ppvOut, IUnknown punkOuter);

@DllImport("HID.dll")
NTSTATUS HidP_GetCaps(int PreparsedData, HIDP_CAPS* Capabilities);

@DllImport("HID.dll")
NTSTATUS HidP_GetLinkCollectionNodes(char* LinkCollectionNodes, uint* LinkCollectionNodesLength, int PreparsedData);

@DllImport("HID.dll")
NTSTATUS HidP_GetSpecificButtonCaps(HIDP_REPORT_TYPE ReportType, ushort UsagePage, ushort LinkCollection, ushort Usage, char* ButtonCaps, ushort* ButtonCapsLength, int PreparsedData);

@DllImport("HID.dll")
NTSTATUS HidP_GetButtonCaps(HIDP_REPORT_TYPE ReportType, char* ButtonCaps, ushort* ButtonCapsLength, int PreparsedData);

@DllImport("HID.dll")
NTSTATUS HidP_GetSpecificValueCaps(HIDP_REPORT_TYPE ReportType, ushort UsagePage, ushort LinkCollection, ushort Usage, char* ValueCaps, ushort* ValueCapsLength, int PreparsedData);

@DllImport("HID.dll")
NTSTATUS HidP_GetValueCaps(HIDP_REPORT_TYPE ReportType, char* ValueCaps, ushort* ValueCapsLength, int PreparsedData);

@DllImport("HID.dll")
NTSTATUS HidP_GetExtendedAttributes(HIDP_REPORT_TYPE ReportType, ushort DataIndex, int PreparsedData, char* Attributes, uint* LengthAttributes);

@DllImport("HID.dll")
NTSTATUS HidP_InitializeReportForID(HIDP_REPORT_TYPE ReportType, ubyte ReportID, int PreparsedData, const(char)* Report, uint ReportLength);

@DllImport("HID.dll")
NTSTATUS HidP_SetData(HIDP_REPORT_TYPE ReportType, char* DataList, uint* DataLength, int PreparsedData, const(char)* Report, uint ReportLength);

@DllImport("HID.dll")
NTSTATUS HidP_GetData(HIDP_REPORT_TYPE ReportType, char* DataList, uint* DataLength, int PreparsedData, const(char)* Report, uint ReportLength);

@DllImport("HID.dll")
uint HidP_MaxDataListLength(HIDP_REPORT_TYPE ReportType, int PreparsedData);

@DllImport("HID.dll")
NTSTATUS HidP_SetUsages(HIDP_REPORT_TYPE ReportType, ushort UsagePage, ushort LinkCollection, char* UsageList, uint* UsageLength, int PreparsedData, const(char)* Report, uint ReportLength);

@DllImport("HID.dll")
NTSTATUS HidP_UnsetUsages(HIDP_REPORT_TYPE ReportType, ushort UsagePage, ushort LinkCollection, char* UsageList, uint* UsageLength, int PreparsedData, const(char)* Report, uint ReportLength);

@DllImport("HID.dll")
NTSTATUS HidP_GetUsages(HIDP_REPORT_TYPE ReportType, ushort UsagePage, ushort LinkCollection, char* UsageList, uint* UsageLength, int PreparsedData, const(char)* Report, uint ReportLength);

@DllImport("HID.dll")
NTSTATUS HidP_GetUsagesEx(HIDP_REPORT_TYPE ReportType, ushort LinkCollection, char* ButtonList, uint* UsageLength, int PreparsedData, const(char)* Report, uint ReportLength);

@DllImport("HID.dll")
uint HidP_MaxUsageListLength(HIDP_REPORT_TYPE ReportType, ushort UsagePage, int PreparsedData);

@DllImport("HID.dll")
NTSTATUS HidP_SetUsageValue(HIDP_REPORT_TYPE ReportType, ushort UsagePage, ushort LinkCollection, ushort Usage, uint UsageValue, int PreparsedData, const(char)* Report, uint ReportLength);

@DllImport("HID.dll")
NTSTATUS HidP_SetScaledUsageValue(HIDP_REPORT_TYPE ReportType, ushort UsagePage, ushort LinkCollection, ushort Usage, int UsageValue, int PreparsedData, const(char)* Report, uint ReportLength);

@DllImport("HID.dll")
NTSTATUS HidP_SetUsageValueArray(HIDP_REPORT_TYPE ReportType, ushort UsagePage, ushort LinkCollection, ushort Usage, const(char)* UsageValue, ushort UsageValueByteLength, int PreparsedData, const(char)* Report, uint ReportLength);

@DllImport("HID.dll")
NTSTATUS HidP_GetUsageValue(HIDP_REPORT_TYPE ReportType, ushort UsagePage, ushort LinkCollection, ushort Usage, uint* UsageValue, int PreparsedData, const(char)* Report, uint ReportLength);

@DllImport("HID.dll")
NTSTATUS HidP_GetScaledUsageValue(HIDP_REPORT_TYPE ReportType, ushort UsagePage, ushort LinkCollection, ushort Usage, int* UsageValue, int PreparsedData, const(char)* Report, uint ReportLength);

@DllImport("HID.dll")
NTSTATUS HidP_GetUsageValueArray(HIDP_REPORT_TYPE ReportType, ushort UsagePage, ushort LinkCollection, ushort Usage, const(char)* UsageValue, ushort UsageValueByteLength, int PreparsedData, const(char)* Report, uint ReportLength);

@DllImport("HID.dll")
NTSTATUS HidP_UsageListDifference(char* PreviousUsageList, char* CurrentUsageList, char* BreakUsageList, char* MakeUsageList, uint UsageListLength);

@DllImport("HID.dll")
NTSTATUS HidP_TranslateUsagesToI8042ScanCodes(char* ChangedUsageList, uint UsageListLength, HIDP_KEYBOARD_DIRECTION KeyAction, HIDP_KEYBOARD_MODIFIER_STATE* ModifierState, PHIDP_INSERT_SCANCODES InsertCodesProcedure, void* InsertCodesContext);

@DllImport("HID.dll")
ubyte HidD_GetAttributes(HANDLE HidDeviceObject, HIDD_ATTRIBUTES* Attributes);

@DllImport("HID.dll")
void HidD_GetHidGuid(Guid* HidGuid);

@DllImport("HID.dll")
ubyte HidD_GetPreparsedData(HANDLE HidDeviceObject, int* PreparsedData);

@DllImport("HID.dll")
ubyte HidD_FreePreparsedData(int PreparsedData);

@DllImport("HID.dll")
ubyte HidD_FlushQueue(HANDLE HidDeviceObject);

@DllImport("HID.dll")
ubyte HidD_GetConfiguration(HANDLE HidDeviceObject, char* Configuration, uint ConfigurationLength);

@DllImport("HID.dll")
ubyte HidD_SetConfiguration(HANDLE HidDeviceObject, char* Configuration, uint ConfigurationLength);

@DllImport("HID.dll")
ubyte HidD_GetFeature(HANDLE HidDeviceObject, char* ReportBuffer, uint ReportBufferLength);

@DllImport("HID.dll")
ubyte HidD_SetFeature(HANDLE HidDeviceObject, char* ReportBuffer, uint ReportBufferLength);

@DllImport("HID.dll")
ubyte HidD_GetInputReport(HANDLE HidDeviceObject, char* ReportBuffer, uint ReportBufferLength);

@DllImport("HID.dll")
ubyte HidD_SetOutputReport(HANDLE HidDeviceObject, char* ReportBuffer, uint ReportBufferLength);

@DllImport("HID.dll")
ubyte HidD_GetNumInputBuffers(HANDLE HidDeviceObject, uint* NumberBuffers);

@DllImport("HID.dll")
ubyte HidD_SetNumInputBuffers(HANDLE HidDeviceObject, uint NumberBuffers);

@DllImport("HID.dll")
ubyte HidD_GetPhysicalDescriptor(HANDLE HidDeviceObject, char* Buffer, uint BufferLength);

@DllImport("HID.dll")
ubyte HidD_GetManufacturerString(HANDLE HidDeviceObject, char* Buffer, uint BufferLength);

@DllImport("HID.dll")
ubyte HidD_GetProductString(HANDLE HidDeviceObject, char* Buffer, uint BufferLength);

@DllImport("HID.dll")
ubyte HidD_GetIndexedString(HANDLE HidDeviceObject, uint StringIndex, char* Buffer, uint BufferLength);

@DllImport("HID.dll")
ubyte HidD_GetSerialNumberString(HANDLE HidDeviceObject, char* Buffer, uint BufferLength);

@DllImport("HID.dll")
ubyte HidD_GetMsGenreDescriptor(HANDLE HidDeviceObject, char* Buffer, uint BufferLength);

struct JOYREGHWVALUES
{
    joyrange_tag jrvHardware;
    uint dwPOVValues;
    uint dwCalFlags;
}

