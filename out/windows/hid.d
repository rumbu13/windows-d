// Written in the D programming language.

module windows.hid;

public import windows.core;
public import windows.com : HRESULT, IUnknown;
public import windows.displaydevices : POINT, RECT;
public import windows.multimedia : joyrange_tag, joyreghwconfig_tag, joyreghwsettings_tag,
                                   joyreguservalues_tag;
public import windows.systemservices : BOOL, HANDLE, HINSTANCE, NTSTATUS;
public import windows.windowsandmessaging : HWND;
public import windows.windowsprogramming : FILETIME, HKEY;

extern(Windows):


// Enums


alias HIDP_REPORT_TYPE = int;
enum : int
{
    HidP_Input   = 0x00000000,
    HidP_Output  = 0x00000001,
    HidP_Feature = 0x00000002,
}

alias HIDP_KEYBOARD_DIRECTION = int;
enum : int
{
    HidP_Keyboard_Break = 0x00000000,
    HidP_Keyboard_Make  = 0x00000001,
}

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

///The <b>DIEFFESCAPE</b> structure passes hardware-specific data directly to the device driver.
struct DIEFFESCAPE
{
    ///Specifies the size of the structure in bytes. This member must be initialized before the structure is used.
    uint  dwSize;
    ///Specifies a driver-specific command number. Contact the hardware vendor for a list of valid commands and their
    ///parameters.
    uint  dwCommand;
    ///Points to the buffer containing the data required to perform the operation.
    void* lpvInBuffer;
    ///Specifies the size, in bytes, of the <b>lpvInBuffer</b> buffer.
    uint  cbInBuffer;
    ///Points to the buffer in which the operation's output data is returned.
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

///The DIOBJECTATTRIBUTES structure describes the information contained in the "Attributes" value of the registry key
///for each "object" on a device. If the "Attributes" value is absent, then default attributes are used.
struct DIOBJECTATTRIBUTES
{
    ///There may be zero, one, or more of the following flags:
    uint   dwFlags;
    ///Specifies the HID usage page to associate with the object.
    ushort wUsagePage;
    ushort wUsage;
}

///The DIFFOBJECTATTRIBUTES structure describes the information contained in the "FFAttributes" value of the registry
///key for each "object" on a force-feedback device. If the "FFAttributes" value is absent, then the object is assumed
///not to support force feedback.
struct DIFFOBJECTATTRIBUTES
{
    ///Specifies the magnitude of the maximum force that can be created by the actuator associated with this object.
    ///Force is expressed in Newtons and measured in relation to where the hand would be during <b>Normal</b> operation
    ///of the device. If this member is zero, the object is assumed not to support force feedback.
    uint dwFFMaxForce;
    uint dwFFForceResolution;
}

///The DIOBJECTCALIBRATION structure describes the information contained in the "Calibration" value of the registry key
///for each axis on a device.
struct DIOBJECTCALIBRATION
{
    ///Specifies the logical value for the axis minimum position.
    int lMin;
    ///Specifies the logical value for the axis center position.
    int lCenter;
    ///Specifies the logical value for the axis maximum position.
    int lMax;
}

struct DIPOVCALIBRATION
{
    int[5] lMin;
    int[5] lMax;
}

///The <b>DIEFFECTATTRIBUTES</b> structure describes the information contained in the "Attributes" value of the registry
///key for each effect that is supported by a force-feedback device.
struct DIEFFECTATTRIBUTES
{
    ///Specifies an arbitrary 32-bit value that is passed to the driver to identify the effect. The driver receives this
    ///value as the <i>dwEffectID</i> parameter to the IDirectInputEffectDriver::DownloadEffect method.
    uint dwEffectId;
    ///Describes the category and capabilities of the effect. This member must consist of one of the following values:
    uint dwEffType;
    ///Describes the parameters supported by the effect. For example, if DIEP_ENVELOPE is set, then the effect supports
    ///an envelope. All effects should support at least DIEP_DURATION, DIEP_AXES, and DIEP_TYPESPECIFICPARAMS. It is not
    ///an error for an application to attempt to use effect parameters that are not supported by the device. The
    ///unsupported parameters are merely ignored. This value can be zero, one, or more of the following flags:
    uint dwStaticParams;
    ///Describes the parameters of the effect that can be modified while the effect is playing. If an application
    ///attempts to change a parameter while the effect is playing, and the driver does not support modifying that effect
    ///dynamically, then the driver will return DIERR_EFFECTPLAYING. This member uses the same flags as the
    ///<b>dwStaticParams</b> member, except that the flags are interpreted as describing whether the driver can modify
    ///the parameters of an effect while the effect is playing, rather than while it is not playing.
    uint dwDynamicParams;
    ///One or more coordinate system flags (DIEFF_CARTESIAN, DIEFF_POLAR, DIEFF_SPHERICAL) indicating which coordinate
    ///systems are supported by the effect. At least one coordinate system must be supported. If an application attempts
    ///to set a direction in an unsupported coordinate system, DirectInput automatically converts it to a coordinate
    ///system that the device does support.
    uint dwCoords;
}

///The DIFFDEVICEATTRIBUTES structure describes the information contained in the "Attributes" value of the
///<b>OEMForceFeedback</b> registry key.
struct DIFFDEVICEATTRIBUTES
{
    ///Reserved for future use. This member must be set to zero.
    uint dwFlags;
    ///Specifies the minimum time between playback of force commands, in microseconds.
    uint dwFFSamplePeriod;
    uint dwFFMinTimeResolution;
}

///The <b>DIDRIVERVERSIONS</b> structure is used by the DirectInput effect driver to report version information back to
///DirectInput. The semantics of the version numbers are left to the discretion of the device driver. The only
///requirement is that later versions have higher version numbers than earlier versions.
struct DIDRIVERVERSIONS
{
    ///Specifies the size of the structure in bytes. This member must be initialized before the structure is used.
    uint dwSize;
    ///Specifies the firmware revision of the device.
    uint dwFirmwareRevision;
    ///Specifies the hardware revision of the device.
    uint dwHardwareRevision;
    uint dwFFDriverVersion;
}

///The <b>DIDEVICESTATE</b> structure returns information about the state of a force feedback device.
struct DIDEVICESTATE
{
    ///Specifies the size of the structure in bytes. This member must be initialized before the structure is used.
    uint dwSize;
    ///Indicates various aspects of the device state. Can indicate zero, one, or more of the following:
    uint dwState;
    uint dwLoad;
}

///The <b>DIHIDFFINITINFO</b> structure is used by DirectInput to provide information to a HID force-feedback driver
///about the device it is being asked to control.
struct DIHIDFFINITINFO
{
    ///Specifies the size of the structure in bytes. This member must be initialized before the structure is used.
    uint          dwSize;
    ///Points to a null-terminated Unicode string that identifies the device interface for the device. The driver can
    ///pass the device interface to the CreateFile function to obtain access to the device.
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

///The <b>DIJOYTYPEINFO</b> structure contains information about a joystick type.
struct DIJOYTYPEINFO
{
    ///Specifies the size of the structure in bytes. This member must be initialized before the structure is used.
    uint                 dwSize;
    ///Joystick hardware settings.
    joyreghwsettings_tag hws;
    ///Specifies a CLSID for the joystick type configuration object. Pass this CLSID to CoCreateInstance to create a
    ///configuration object. This field is zero if the type does not have custom configuration.
    GUID                 clsidConfig;
    ///The display name for the joystick type. The display name is the name that should be used to display the name of
    ///the joystick type to the end user.
    ushort[256]          wszDisplayName;
    ///The device responsible for handling polling for devices of this type. This is a null string if the global polling
    ///callout is to be used.
    ushort[260]          wszCallout;
    ///The hardware ID for the joystick type. The hardware ID is used by Plug and Play on Windows 2000 and Windows 98
    ///(DirectX 7.0 only) to find the drivers for the joystick.
    ushort[256]          wszHardwareId;
    ///Joystick type flags. This member can be set to a combination of the following flags.
    uint                 dwFlags1;
    ///Combination of device filtering and device type/subtype override flags. Device-filtering flags should be placed
    ///in the high WORD of <b>dwFlags2</b>. Device type and subtype should be placed in the low and high WORDs of the
    ///member, respectively.
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

///The DIJOYCONFIG structure contains information about a joystick's configuration.
struct DIJOYCONFIG
{
    ///Specifies the size of the structure in bytes. This member must be initialized before the structure is used.
    uint               dwSize;
    ///Specifies the instance GUID for the joystick.
    GUID               guidInstance;
    ///Joystick hardware configuration.
    joyreghwconfig_tag hwc;
    ///Specifies the global gain setting. This value is applied to all force feedback effects as a "master volume
    ///control".
    uint               dwGain;
    ///The joystick type for the joystick. It must be one of the values enumerated by IDirectInputJoyConfig8::EnumTypes.
    ushort[256]        wszType;
    ///The callout driver for the joystick.
    ushort[256]        wszCallout;
    ///Specifies a GUID that identifies the gameport being used for this joystick.
    GUID               guidGameport;
}

///The <b>DIJOYUSERVALUES</b> structure contains information about the user's joystick settings.
struct DIJOYUSERVALUES
{
    ///Specifies the size of the structure in bytes. This member must be initialized before the structure is used.
    uint                 dwSize;
    ///Joystick user configuration. In addition to the fields contained in the mmddk.h header file, the previously
    ///unused <b>jrvRanges.jpCenter</b> field contains the user saturation levels for each axis. A control panel
    ///application sets the dead zone and saturation values based on the values set by the end-user during calibration
    ///or fine-tuning. Dead zone can be interpreted as "sensitivity in the center" and saturation can be interpreted as
    ///"sensitivity along the edges".
    joyreguservalues_tag ruv;
    ///The global port driver.
    ushort[256]          wszGlobalDriver;
    ushort[256]          wszGameportEmulator;
}

///KEYBOARD_INPUT_DATA contains one packet of keyboard input data.
struct KEYBOARD_INPUT_DATA
{
    ///Specifies the unit number of a keyboard device. A keyboard device name has the format
    ///\Device\KeyboardPort<i>N</i>, where the suffix <i>N </i>is the unit number of the device. For example, a device,
    ///whose name is \Device\KeyboardPort0, has a unit number of zero, and a device, whose name is
    ///\Device\KeyboardPort1, has a unit number of one.
    ushort UnitId;
    ///Specifies the scan code associated with a key press.
    ushort MakeCode;
    ///Specifies a bitwise OR of one or more of the following flags that indicate whether a key was pressed or released,
    ///and other miscellaneous information. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td> KEY_MAKE </td>
    ///<td> The key was pressed. </td> </tr> <tr> <td> KEY_BREAK </td> <td> The key was released. </td> </tr> <tr> <td>
    ///KEY_E0 </td> <td> Extended scan code used to indicate special keyboard functions. </td> </tr> <tr> <td> KEY_E1
    ///</td> <td> Extended scan code used to indicate special keyboard functions. </td> </tr> </table>
    ushort Flags;
    ///Reserved for operating system use.
    ushort Reserved;
    ///Specifies device-specific information associated with a keyboard event.
    uint   ExtraInformation;
}

///KEYBOARD_TYPEMATIC_PARAMETERS specifies a keyboard's typematic settings.
struct KEYBOARD_TYPEMATIC_PARAMETERS
{
    ///Specifies the unit number of a keyboard device. A keyboard device name has the format
    ///\Device\KeyboardPort<i>N</i>, where the suffix <i>N </i>is the unit number of the device. For example, a device,
    ///whose name is \Device\KeyboardPort0, has a unit number of zero, and a device, whose name is
    ///\Device\KeyboardPort1, has a unit number of one.
    ushort UnitId;
    ///Specifies the rate at which character output from a keyboard repeats, in characters per second, after a key is
    ///pressed and continuously held down. The minimum possible value is KEYBOARD_TYPEMATIC_RATE_MINIMUM and the maximum
    ///possible value is KEYBOARD_TYPEMATIC_RATE_MAXIMUM. The default value is KEYBOARD_TYPEMATIC_RATE_DEFAULT.
    ushort Rate;
    ///Specifies the amount of time that must elapse, in milliseconds, after a key is pressed and continuously held
    ///down, before the character output from a keyboard begins to repeat. The minimum possible delay is
    ///KEYBOARD_TYPEMATIC_DELAY_MINIMUM and the maximum possible delay is KEYBOARD_TYPEMATIC_DELAY_MAXIMUM. The default
    ///value is KEYBOARD_TYPEMATIC_DELAY_DEFAULT.
    ushort Delay;
}

struct KEYBOARD_ID
{
    ubyte Type;
    ubyte Subtype;
}

///KEYBOARD_ATTRIBUTES specifies the attributes of a keyboard.
struct KEYBOARD_ATTRIBUTES
{
    ///Specifies the keyboard type and subtype in a KEYBOARD_ID structure: ```cpp typedef struct _KEYBOARD_ID { UCHAR
    ///Type; UCHAR Subtype; } KEYBOARD_ID, *PKEYBOARD_ID; ```
    KEYBOARD_ID KeyboardIdentifier;
    ///Specifies the scan code mode. See the [Remarks](
    ushort      KeyboardMode;
    ///Specifies the number of function keys that a keyboard supports.
    ushort      NumberOfFunctionKeys;
    ///Specifies the number of LED indicators that a keyboard supports.
    ushort      NumberOfIndicators;
    ///Specifies the number of keys that a keyboard supports.
    ushort      NumberOfKeysTotal;
    ///Specifies the size, in bytes, of the input data queue used by the keyboard port driver.
    uint        InputDataQueueLength;
    ///Specifies the minimum possible value for the keyboard typematic rate and delay in a
    ///[KEYBOARD_TYPEMATIC_PARAMETERS](ns-ntddkbd-keyboard_typematic_parameters.md) structure.
    KEYBOARD_TYPEMATIC_PARAMETERS KeyRepeatMinimum;
    ///Specifies the maximum possible value for the keyboard typematic rate and delay in a
    ///[KEYBOARD_TYPEMATIC_PARAMETERS](ns-ntddkbd-keyboard_typematic_parameters.md) structure.
    KEYBOARD_TYPEMATIC_PARAMETERS KeyRepeatMaximum;
}

///KEYBOARD_EXTENDED_ATTRIBUTES specifies the extended attributes of a keyboard.
struct KEYBOARD_EXTENDED_ATTRIBUTES
{
    ///Type: **UCHAR** The version of this structure. Only **KEYBOARD_EXTENDED_ATTRIBUTES_STRUCT_VERSION_1** supported.
    ubyte Version;
    ///Type: **UCHAR** Keyboard Form Factor (Usage ID: *0x2C1*). | Value | Description |
    ///|-------|----------------------------------------------------------| | 0x00 | Unknown Form Factor. | | 0x01 |
    ///Full‐Size keyboard. | | 0x02 | Compact keyboard. Such keyboards are less than 13” wide. |
    ubyte FormFactor;
    ///Type: **UCHAR** Keyboard Key Type (Usage ID: *0x2C2*). | Value | Description |
    ///|-------|----------------------------------------------------| | 0x00 | Unknown Key Type. | | 0x01 |
    ///Full‐travel keys. | | 0x02 | Low‐travel keys such as those on laptop keyboards. | | 0x03 | Zero‐travel or
    ///virtual keys. |
    ubyte KeyType;
    ///Type: **UCHAR** Keyboard Physical Layout (Usage ID: *0x2C3*). | Value | Description |
    ///|-------|------------------------------------------------------------------------------------------| | 0x00 |
    ///Unknown Layout | | 0x01 | 101 (e.g., US) | | 0x02 | 103 (Korea) | | 0x03 | 102 (e.g., German) | | 0x04 | 104
    ///(e.g., ABNT Brazil) | | 0x05 | 106 (DOS/V Japan) | | 0x06 | Vendor‐specific – If specified,
    ///**VendorSpecificPhysicalLayout** must also be specified. | This value does not refer to the legend set printed on
    ///the keys, but only to the physical keyset layout, defined by the relative location and shape of the textual keys
    ///in relation to each other. This value indicates which of the de facto standard physical layouts to which the
    ///keyboard conforms. These layouts are commonly understood.
    ubyte PhysicalLayout;
    ///Type: **UCHAR** A numeric identifier of the particular Vendor‐specific Keyboard Physical Layout (Usage ID:
    ///*0x2C4*). Values for this field are defined by the hardware vendor but 0x00 is defined to not specify a
    ///Vendor‐specific Keyboard Physical Layout. If non‐zero, **PhysicalLayout** must have value *0x06*. If this
    ///identifier is *0x00*, **PhysicalLayout** must not have the value 0x06.
    ubyte VendorSpecificPhysicalLayout;
    ///Type: **UCHAR** String index of a String Descriptor having an IETF Language Tag (Usage ID: 0x2C5). Actual string
    ///can be obtained via
    ///[IOCTL_HID_GET_INDEXED_STRING](/windows-hardware/drivers/ddi/hidclass/ni-hidclass-ioctl_hid_get_indexed_string)
    ///IOCTL in kernel-mode drivers or
    ///[HidD_GetIndexedString](/windows-hardware/drivers/ddi/hidsdi/nf-hidsdi-hidd_getindexedstring) call in user-mode
    ///applications. This Language Tag specifies the intended primary locale of the keyboard legend set, conformant to
    ///[IETF BCP 47](https://www.rfc-editor.org/rfc/bcp/bcp47.txt) or its successor. If an appropriate IETF Language Tag
    ///is not available, such as for custom, adaptive or new layouts, the value is set to 0x00.
    ubyte IETFLanguageTagIndex;
    ///Type: **UCHAR** Bitmap for physically implemented input assist controls. (Usage ID: *0x2C6*). | Bit | Description
    ///| |-------|----------------------------------------------------| | All 0 | No Keyboard Input Assist controls are
    ///implemented. | | Bit 0 | Previous Suggestion | | Bit 1 | Next Suggestion | | Bit 2 | Previous Suggestion Group |
    ///| Bit 3 | Next Suggestion Group | | Bit 4 | Accept Suggestion | | Bit 5 | Cancel Suggestion | | | All other bits
    ///reserved. |
    ubyte ImplementedInputAssistControls;
}

///KEYBOARD_INDICATOR_PARAMETERS specifies the state of a keyboard's indicator LEDs.
struct KEYBOARD_INDICATOR_PARAMETERS
{
    ///Specifies the unit number of a keyboard device. A keyboard device name has the format
    ///\Device\KeyboardPort<i>N</i>, where the suffix <i>N </i>is the unit number of the device. For example, a device,
    ///whose name is \Device\KeyboardPort0, has a unit number of zero, and a device, whose name is
    ///\Device\KeyboardPort1, has a unit number of one.
    ushort UnitId;
    ///Specifies a bitwise OR of zero or more of the following LED flags: <table> <tr> <th>LED Flag</th>
    ///<th>Meaning</th> </tr> <tr> <td> KEYBOARD_CAPS_LOCK_ON </td> <td> CAPS LOCK LED is on. </td> </tr> <tr> <td>
    ///KEYBOARD_LED_INJECTED </td> <td> Used by a Terminal Server. </td> </tr> <tr> <td> KEYBOARD_NUM_LOCK_ON </td> <td>
    ///NUM LOCK LED is on. </td> </tr> <tr> <td> KEYBOARD_SCROLL_LOCK_ON </td> <td> SCROLL LOCK LED is on. </td> </tr>
    ///<tr> <td> KEYBOARD_SHADOW </td> <td> Used by a Terminal Server. </td> </tr> </table>
    ushort LedFlags;
}

struct INDICATOR_LIST
{
    ushort MakeCode;
    ushort IndicatorFlags;
}

///KEYBOARD_INDICATOR_TRANSLATION specifies a device-specific, variable length array of mappings between keyboard scan
///codes and LED indicators.
struct KEYBOARD_INDICATOR_TRANSLATION
{
    ///Specifies the number of elements in the <b>IndicatorList</b> array.
    ushort            NumberOfIndicatorKeys;
    ///Specifies a device-specific, variable-length array of INDICATOR_LIST structures. ``` typedef struct
    ///_INDICATOR_LIST { USHORT MakeCode; USHORT IndicatorFlags; } INDICATOR_LIST, *PINDICATOR_LIST; ```
    INDICATOR_LIST[1] IndicatorList;
}

///KEYBOARD_UNIT_ID_PARAMETER specifies the unit ID that Kbdclass assigns to a keyboard.
struct KEYBOARD_UNIT_ID_PARAMETER
{
    ///Specifies the unit number of a keyboard device. A keyboard device name has the format
    ///\Device\KeyboardPort<i>N</i>, where the suffix <i>N </i>is the unit number of the device. For example, a device,
    ///whose name is \Device\KeyboardPort0, has a unit number of zero, and a device, whose name is
    ///\Device\KeyboardPort1, has a unit number of one.
    ushort UnitId;
}

struct KEYBOARD_IME_STATUS
{
    ushort UnitId;
    uint   ImeOpen;
    uint   ImeConvMode;
}

///MOUSE_INPUT_DATA contains one packet of mouse input data.
struct MOUSE_INPUT_DATA
{
    ///Specifies the unit number of the mouse device. A mouse device name has the format \Device\PointerPort<i>N</i>,
    ///where the suffix <i>N </i>is the unit number of the device. For example, a device, whose name is
    ///\Device\PointerPort0, has a unit number of zero, and a device, whose name is \Device\PointerPort1, has a unit
    ///number of one.
    ushort UnitId;
    ///Specifies a bitwise OR of one or more of the following mouse indicator flags. <table> <tr> <th>Value</th>
    ///<th>Meaning</th> </tr> <tr> <td> MOUSE_MOVE_RELATIVE </td> <td> The <b>LastX</b> and <b>LastY</b> are set
    ///relative to the previous location. </td> </tr> <tr> <td> MOUSE_MOVE_ABSOLUTE </td> <td> The <b>LastX</b> and
    ///<b>LastY</b> values are set to absolute values. </td> </tr> <tr> <td> MOUSE_VIRTUAL_DESKTOP </td> <td> The mouse
    ///coordinates are mapped to the virtual desktop. </td> </tr> <tr> <td> MOUSE_ATTRIBUTES_CHANGED </td> <td> The
    ///mouse attributes have changed. The other data in the structure is not used. </td> </tr> <tr> <td>
    ///MOUSE_MOVE_NOCOALESCE </td> <td> (Windows Vista and later) WM_MOUSEMOVE notification messages will not be
    ///coalesced. By default, these messages are coalesced. For more information about WM_MOUSEMOVE notification
    ///messages, see the Microsoft Software Development Kit (SDK) documentation </td> </tr> </table>
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
    ///Specifies the raw state of the mouse buttons. The Win32 subsystem does not use this member.
    uint   RawButtons;
    ///Specifies the signed relative or absolute motion in the x direction.
    int    LastX;
    ///Specifies the signed relative or absolute motion in the y direction.
    int    LastY;
    ///Specifies device-specific information.
    uint   ExtraInformation;
}

///MOUSE_ATTRIBUTES specifies the attributes of a mouse device.
struct MOUSE_ATTRIBUTES
{
    ///Specifies one of the following types of mouse devices. <table> <tr> <th>Mouse type</th> <th>Meaning</th> </tr>
    ///<tr> <td> BALLPOINT_I8042_HARDWARE </td> <td> i8042 port ballpoint mouse </td> </tr> <tr> <td>
    ///BALLPOINT_SERIAL_HARDWARE </td> <td> Serial port ballpoint mouse </td> </tr> <tr> <td> MOUSE_HID_HARDWARE </td>
    ///<td> HIDClass mouse </td> </tr> <tr> <td> MOUSE_I8042_HARDWARE </td> <td> i8042 port mouse </td> </tr> <tr> <td>
    ///MOUSE_INPORT_HARDWARE </td> <td> Inport (bus) mouse </td> </tr> <tr> <td> MOUSE_SERIAL_HARDWARE </td> <td> Serial
    ///port mouse </td> </tr> <tr> <td> WHEELMOUSE_HID_HARDWARE </td> <td> HIDClass wheel mouse </td> </tr> <tr> <td>
    ///WHEELMOUSE_I8042_HARDWARE </td> <td> i8042 port wheel mouse </td> </tr> <tr> <td> WHEELMOUSE_SERIAL_HARDWARE
    ///</td> <td> Serial port wheel mouse </td> </tr> </table>
    ushort MouseIdentifier;
    ///Specifies the number of buttons supported by a mouse. A mouse can have from two to five buttons. The default
    ///value is MOUSE_NUMBER_OF_BUTTONS.
    ushort NumberOfButtons;
    ///Specifies the rate, in reports per second, at which input from a PS/2 mouse is sampled. The default value is
    ///MOUSE_SAMPLE_RATE. This value is not used for USB devices.
    ushort SampleRate;
    ///Specifies the size, in bytes, of the input data queue used by the port driver for a mouse device.
    uint   InputDataQueueLength;
}

///MOUSE_UNIT_ID_PARAMETER specifies a unit ID that Mouclass assigns to a mouse.
struct MOUSE_UNIT_ID_PARAMETER
{
    ///Specifies the unit number of the mouse device. A mouse device name has the format \Device\PointerPort<i>N</i>,
    ///where the suffix <i>N </i>is the unit number of the device. For example, a device, whose name is
    ///\Device\PointerPort0, has a unit number of zero, and a device, whose name is \Device\PointerPort1, has a unit
    ///number of one.
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

///The <b>JOYREGHWVALUES</b> structure contains the range of values returned by the hardware (filled in by calibration).
struct JOYREGHWVALUES
{
align (1):
    ///The values returned by the hardware.
    joyrange_tag jrvHardware;
    ///The point-of-view (POV) values returned by the hardware.
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

///These three methods allow additional interfaces to be added to the DirectInputEffectDriver object without affecting
///the functionality of the original interface.
interface IDirectInputEffectDriver : IUnknown
{
    ///The <b>IDirectInputEffectDriver::DeviceID </b>method sends the driver the identity of the device.
    ///Params:
    ///    arg1 = Specifies the version number of DirectInput that loaded the effect driver. For example, with DirectInput 5.0,
    ///           the value of this parameter is 0x00000500.
    ///    arg2 = Specifies the joystick ID number. The Microsoft Windows joystick subsystem allocates external IDs.
    ///    arg3 = Specifies the availability of the device. This value is nonzero if access to the device is beginning, and
    ///           zero if access to the device is ending.
    ///    arg4 = Specifies the ID of the internal joystick. The device driver manages internal IDs.
    ///    arg5 = Points to a DIHIDFFINITINFO structure that contains initialization information for the force feedback driver.
    ///           The driver uses this information to distinguish between multiple devices and to query DirectInput for any
    ///           other device attributes.
    ///Returns:
    ///    Returns S_OK if successful; otherwise, returns an error code.
    ///    
    HRESULT DeviceID(uint param0, uint param1, uint param2, uint param3, void* param4);
    ///The <b>IDirectInputEffectDriver::GetVersions </b>method obtains version information about the force-feedback
    ///hardware and driver.
    ///Params:
    ///    arg1 = Points to a DIDRIVERVERSIONS structure that should be filled in with version information describing the
    ///           hardware, firmware, and driver. DirectInput sets the <b>dwSize</b> member of the DIDRIVERVERSIONS structure
    ///           to <b>sizeof</b>(DIDRIVERVERSIONS) before calling this method.
    HRESULT GetVersions(DIDRIVERVERSIONS* param0);
    ///The <b>IDirectInputEffectDriver::Escape </b>method escapes to the driver. This method is called in response to an
    ///application invoking the <b>IDirectInputEffect::Escape</b> or <b>IDirectInputDevice::Escape</b> methods.
    ///Params:
    ///    arg1 = Indicates the joystick ID number being used.
    ///    arg2 = Specifies the effect at which the command is directed, or zero if the command is directed at the device
    ///           itself and not any particular effect.
    ///    arg3 = Points to a DIEFFESCAPE structure that describes the command to be sent. On success, the <b>cbOutBuffer</b>
    ///           member contains the number of output buffer bytes actually used.
    HRESULT Escape(uint param0, uint param1, DIEFFESCAPE* param2);
    ///The <b>IDirectInputEffectDriver::SetGain </b>method sets the overall device gain.
    ///Params:
    ///    arg1 = Indicates the joystick ID number being used.
    ///    arg2 = Specifies the new gain value (1 to 10,000).
    HRESULT SetGain(uint param0, uint param1);
    ///The <b>IDirectInputEffectDriver::SendForceFeedbackCommand </b>method changes the force-feedback state for the
    ///device.
    ///Params:
    ///    arg1 = Indicates the external joystick number being addressed.
    ///    arg2 = Indicates which of the following commands is being sent:
    HRESULT SendForceFeedbackCommand(uint param0, uint param1);
    ///The <b>IDirectInputEffectDriver::GetForceFeedbackState </b>method retrieves the force-feedback state for the
    ///device.
    ///Params:
    ///    arg1 = Indicates the external joystick number being addressed.
    ///    arg2 = Points to a DIDEVICESTATE structure that receives the device state. DirectInput sets the <b>dwSize</b> member
    ///           of the DIDEVICESTATE structure to <b>sizeof</b>(DIDEVICESTATE) before calling this method.
    HRESULT GetForceFeedbackState(uint param0, DIDEVICESTATE* param1);
    ///The <b>IDirectInputEffectDriver::DownloadEffect</b> method sends an effect to the device.
    ///Params:
    ///    arg1 = Specifies the external joystick number being addressed.
    ///    arg2 = Specifies the <b>dwEffectId</b> member of the DIEFFECTATTRIBUTES structure associated with the effect the
    ///           application is attempting to create. The DIEFFECTATTRIBUTES structure is stored in the registry under the
    ///           corresponding effect registry key and can be any 32-bit value. DirectInput passes the 32-bit value to the
    ///           driver with no interpretation.
    ///    arg3 = On entry, this parameter is a pointer to the handle of the effect being downloaded. If this parameter points
    ///           to a zero, then a new effect is downloaded. On exit, this parameter is a pointer to a <b>DWORD </b>that
    ///           contains the new effect handle. On failure, the <b>DWORD</b> pointed to by this parameter is set to zero if
    ///           the effect is lost, or left alone if the effect is still valid with its old parameters. Note that zero is
    ///           never a valid effect handle.
    ///    arg4 = Points to a DIEFFECT structure that describes the new effect. The axis and button values have been converted
    ///           to object identifiers, which consist of the following:
    ///    arg5 = Specifies which portions of the effect information have changed from the effect already applied to the
    ///           device. This information is passed to drivers to allow for the optimization of effect modification. If an
    ///           effect is being modified, a driver may be able to update the effect in its original position and transmit to
    ///           the device only the information that has changed. Drivers are not, however, required to implement this
    ///           optimization. All members in the DIEFFECT structure pointed to by the <i>peff</i> parameter are valid, and a
    ///           driver may choose simply to update all parameters of the effect at each download. (For information about the
    ///           DIEFFECT structure, see the DirectInput section of the stand alone DirectX SDK.) This parameter can be zero,
    ///           one, or more of the following:
    HRESULT DownloadEffect(uint param0, uint param1, uint* param2, DIEFFECT* param3, uint param4);
    ///The <b>IDirectInputEffectDriver::DestroyEffect </b>method removes an effect from the device. If the effect is
    ///playing, the driver should stop it before unloading it.
    ///Params:
    ///    arg1 = Specifies the external joystick number being addressed.
    ///    arg2 = Specifies the effect to be destroyed.
    HRESULT DestroyEffect(uint param0, uint param1);
    ///The <b>IDirectInputEffectDriver::StartEffect</b> method begins the playback of an effect. If the effect is
    ///already playing, it is restarted from the beginning.
    ///Params:
    ///    arg1 = Identifies the external joystick number being addressed
    ///    arg2 = Specifies the effect to be played.
    ///    arg3 = Specifies how the effect is to affect other effects. Only the mode listed below can be used; all other modes
    ///           are reserved. For example, the driver never receives the DIES_NODOWNLOAD flag because it is managed by
    ///           DirectInput and not the driver. This parameter can be zero, one, or more of the following flags:
    ///    arg4 = Specifies the number of times to perform the effect. If the value is INFINITE, then the effect should be
    ///           repeated until explicitly stopped or paused.
    HRESULT StartEffect(uint param0, uint param1, uint param2, uint param3);
    ///The <b>IDirectInputEffectDriver::StopEffect </b>method halts the playback of an effect.
    ///Params:
    ///    arg1 = Indicates the external joystick number being addressed.
    ///    arg2 = Specifies the effect to be stopped.
    HRESULT StopEffect(uint param0, uint param1);
    ///The <b>IDirectInputEffectDriver::GetEffectStatus </b>method obtains information about the status of an effect.
    ///Params:
    ///    arg1 = Indicates the external joystick number being addressed.
    ///    arg2 = Specifies the effect to be queried.
    ///    arg3 = Points to a <b>DWORD </b>that receives the effect status. The <b>DWORD</b> should be filled in with one of
    ///           the following values:
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
    ///The <b>IDirectInputJoyConfig8::OpenConfigKey </b>method opens IDirectInputJoyConfigthe registry key associated
    ///with a joystick configuration. Control panel applications can use this key to store per-joystick persistent
    ///information, such as button mappings. Such private information should be kept in a subkey named <b>OEM</b>; do
    ///not store private information in the main configuration key. The application should use <b>RegCloseKey</b> to
    ///close the registry key.
    ///Params:
    ///    arg1 = Indicates a zero-based joystick identification number.
    ///    arg2 = Specifies a registry security access mask. This can be any of the values permitted by the <b>RegOpenKeyEx</b>
    ///           function. If write access is requested, then joystick configuration must first be acquired. If only read
    ///           access is requested, then acquisition is not required. At least one access mask must be specified.
    ///    arg3 = Points to the opened registry key on success.
    HRESULT OpenConfigKey(uint param0, uint param1, HKEY* param2);
}

///<b>IDirectInputJoyConfig8</b> interface contains methods that allow hardware developers who are writing property
///sheets to write and read information to and from the registry. If you need to open registry keys, you should use the
///IDirectInputJoyConfig8::OpenConfigKey and IDirectInputJoyConfig8::OpenTypeKey methods rather than opening registry
///keys directly. Using either of these methods ensures that the correct registry branch is opened. In addition, the
///<b>IDirectInputJoyConfig8</b> interface will be supported in future versions of DirectInput when the underlying
///registry data may be structured differently.
interface IDirectInputJoyConfig8 : IUnknown
{
    ///The <b>IDirectInputJoyConfig8::Acquire </b>method acquires "joystick configuration mode." Only one application
    ///can be in joystick configuration mode at a time; subsequent attempts by other applications to acquire this mode
    ///should receive the error DIERR_OTHERAPPHASPRIO. After entering configuration mode, the application can make
    ///alterations to the global joystick configuration settings. The application should check the existing settings
    ///before installing the new ones in case another application changed the settings in the interim.
    HRESULT Acquire();
    ///The <b>IDirectInputJoyConfig8::Unacquire </b>method unacquires "joystick configuration mode".
    ///Returns:
    ///    Returns DI_OK if successful; otherwise, returns a COM error code.
    ///    
    HRESULT Unacquire();
    ///The <b>IDirectInputJoyConfig8::SetCooperativeLevel </b>method establishes the cooperation level for the instance
    ///of the device. The only cooperative levels supported for the <b>IDirectInputJoyConfig8</b> interface are
    ///DISCL_EXCLUSIVE and DISCL_BACKGROUND.
    ///Params:
    ///    arg1 = Handle to the window associated with the interface. This parameter must be non-NULL and must be a top-level
    ///           window. It is an error to destroy the window while it is still associated with an
    ///           <b>IDirectInputJoyConfig8</b> interface.
    ///    arg2 = Specifies one of a set of flags that describe the level of cooperation associated with the device. The value
    ///           must be DISCL_EXCLUSIVE | DISCL_BACKGROUND.
    HRESULT SetCooperativeLevel(HWND param0, uint param1);
    ///The <b>IDirectInputJoyConfig8::SendNotify </b>method notifies device drivers and applications that changes to the
    ///device configuration have been made. An application that changes device configurations must invoke this method
    ///after the changes have been made (and before unacquiring the device).
    HRESULT SendNotify();
    ///The <b>IDirectInputJoyConfig8::EnumTypes </b>method enumerates the joystick types currently supported by
    ///DirectInput. A joystick type describes how DirectInput should communicate with a joystick device. It includes
    ///information such as the presence and location of each of the axes and the number of buttons supported by the
    ///device.
    ///Params:
    ///    arg1 = Points to an application-defined callback function that receives the DirectInput joystick types. See the
    ///           Remarks section for the function prototype.
    ///    arg2 = Specifies a 32-bit application-defined value to be passed to the callback function. This value can be any
    ///           32-bit value; it is prototyped as an LPVOID for convenience.
    ///Returns:
    ///    Returns DI_OK if successful; otherwise, returns one of the following COM error values: <table> <tr>
    ///    <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>DIERR_INVALIDPARAM
    ///    </b></dt> </dl> </td> <td width="60%"> One or more parameters was invalid. </td> </tr> </table>
    ///    
    HRESULT EnumTypes(LPDIJOYTYPECALLBACK param0, void* param1);
    ///The <b>IDirectInputJoyConfig8::GetTypeInfo </b>method obtains information about a joystick type.
    ///Params:
    ///    arg1 = Points to the name of the type, previously obtained from a call to IDirectInputJoyConfig8::EnumTypes.
    ///    arg2 = Points to a structure that receives information about the joystick type. The caller must initialize the
    ///           <b>dwSize</b> member of the DIJOYTYPEINFO structure before calling this method.
    ///    arg3 = Specifies the parts of the DIJOYTYPEINFO structure pointed to by <i>pjti</i> that are to be filled. There may
    ///           be zero, one, or more of the following:
    HRESULT GetTypeInfo(const(wchar)* param0, DIJOYTYPEINFO* param1, uint param2);
    ///The <b>IDirectInputJoyConfig8::SetTypeInfo </b>method creates a new joystick type or redefines information about
    ///an existing joystick type.
    ///Params:
    ///    arg1 = Points to the name of the type. The name of the type cannot exceed MAX_JOYSTRING characters, including the
    ///           terminating null character. If the type name does not already exist, then it is created. You cannot change
    ///           the type information for a predefined type. The name cannot begin with a "
    ///    arg2 = Points to a structure that receives information about the joystick type.
    ///    arg3 = Specifies the parts of the DIJOYTYPEINFO structure pointed to by <i>pjti</i> that contain values to be set.
    ///    arg4 = If the type name is an OEM type not in VID_xxxx&PID_yyyy format, this parameter will return the name in
    ///           VID_xxxx&PID_yyyy format that is assigned by Dinput. This VID_xxxx&PID_yyyy name should be used in
    ///           DIJOYCONFIG.wszType field when calling SetConfig.
    HRESULT SetTypeInfo(const(wchar)* param0, DIJOYTYPEINFO* param1, uint param2, const(wchar)* param3);
    ///The <b>IDirectInputJoyConfig8::DeleteType </b>method removes information about a joystick type. Use this method
    ///with caution; it is the caller's responsibility to ensure that no joystick refers to the deleted type.
    ///Params:
    ///    arg1 = Points to the name of the type. The name of the type cannot exceed MAX_PATH characters, including the
    ///           terminating null character. Also, the name cannot begin with a "
    HRESULT DeleteType(const(wchar)* param0);
    ///The <b>IDirectInputJoyConfig8::GetConfig </b>method obtains information about a joystick's configuration.
    ///Params:
    ///    arg1 = Indicates a joystick identification number. This is a nonnegative integer. To enumerate joysticks, begin with
    ///           joystick zero and increment the joystick number by one until the function returns DIERR_NOMOREITEMS.
    ///    arg2 = Points to a structure that receives information about the joystick configuration. The caller "must"
    ///           initialize the <b>dwSize</b> member of the DIJOYCONFIG structure before calling this method.
    ///    arg3 = Specifies the members of the structure pointed to by <i>pjc</i> that are to be filled in. This parameter can
    ///           be zero, one, or more of the following:
    HRESULT GetConfig(uint param0, DIJOYCONFIG* param1, uint param2);
    ///The <b>IDirectInputJoyConfig8::SetConfig </b>method creates or redefines configuration information about a
    ///joystick.
    ///Params:
    ///    arg1 = Indicates a zero-based joystick identification number.
    ///    arg2 = Contains information about the joystick.
    ///    arg3 = Specifies the parts of the DIJOYCONFIG structure pointed to by <i>pcfg</i> that contain information to be
    ///           set. There may be zero, one, or more of the following:
    HRESULT SetConfig(uint param0, DIJOYCONFIG* param1, uint param2);
    ///The <b>IDirectInputJoyConfig8::DeleteConfig </b>method deletes configuration information about a joystick.
    ///Params:
    ///    arg1 = Indicates a zero-based joystick identification number.
    HRESULT DeleteConfig(uint param0);
    ///The <b>IDirectInputJoyConfig8::GetUserValues </b>method obtains information about user settings for the joystick.
    ///Params:
    ///    arg1 = Points to a structure that receives information about the user joystick configuration. The caller must
    ///           initialize the <b>dwSize</b> member of the DIJOYUSERVALUES structure before calling this method.
    ///    arg2 = Specifies which members of the DIJOYUSERVALUES structure contain values to be retrieved. There may be zero,
    ///           one, or more of the following:
    HRESULT GetUserValues(DIJOYUSERVALUES* param0, uint param1);
    ///The <b>IDirectInputJoyConfig8::SetUserValues </b>method sets the user settings for the joystick.
    ///Params:
    ///    arg1 = Points to a structure that receives information about the new user joystick settings.
    ///    arg2 = Specifies the parts of the DIJOYUSERVALUES structure that contain values to be set. There may be zero, one,
    ///           or more of the following:
    HRESULT SetUserValues(DIJOYUSERVALUES* param0, uint param1);
    ///The <b>IDirectInputJoyConfig8::AddNewHardware </b>method displays the <b>Add New Hardware</b> dialog box which
    ///guides the user through installing a new input device.
    ///Params:
    ///    arg1 = Handle to the window that functions as the owner window for the user interface.
    ///    arg2 = GUID that specifies the class of the hardware device to be added. DirectInput comes with the following class
    ///           GUIDs already defined:
    HRESULT AddNewHardware(HWND param0, const(GUID)* param1);
    ///The <b>IDirectInputJoyConfig8::OpenTypeKey </b>method opens the registry key associated with a joystick type.
    ///Params:
    ///    arg1 = Points to the name of the type. The name of the type cannot exceed MAX_PATH characters, including the
    ///           terminating null character. The name cannot begin with a "
    ///    arg2 = Specifies a registry security access mask. This can be any of the values permitted by the <b>RegOpenKeyEx</b>
    ///           function. If write access is requested, then joystick configuration must first have been acquired. If only
    ///           read access is requested, then acquisition is not required.
    ///    arg3 = Points to the opened registry key, on success.
    ///Returns:
    ///    Returns DI_OK if successful; otherwise, returns one of the following COM error values: <table> <tr>
    ///    <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>DIERR_NOTACQUIRED </b></dt>
    ///    </dl> </td> <td width="60%"> Joystick configuration has not been acquired. You must call
    ///    IDirectInputJoyConfig8::Acquire before you can open a joystick type configuration key for writing. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>DIERR_INVALIDPARAM </b></dt> </dl> </td> <td width="60%"> One or more
    ///    parameters was invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>MAKE_HRESULT(SEVERITY_ERROR,
    ///    FACILITY_WIN32, ErrorCode) </b></dt> </dl> </td> <td width="60%"> A Win32 error code if access to the key is
    ///    denied by registry permissions or some other external factor. </td> </tr> </table>
    ///    
    HRESULT OpenTypeKey(const(wchar)* param0, uint param1, HKEY* param2);
    ///The <b>IDirectInputJoyConfig8::OpenAppStatusKey </b>method opens the root key of the application status registry
    ///keys, and obtains a handle to the key as a return parameter.
    ///Params:
    ///    arg1 = Points to the address of a variable (of type HKEY) that will contain a registry key handle if the method
    ///           succeeds. See Remarks for additional usage details.
    ///Returns:
    ///    Returns DI_OK if successful; otherwise, returns one of the following COM error values. The following error
    ///    codes are intended to be illustrative and not necessarily comprehensive. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>DIERR_INVALIDPARAM</b></dt> </dl> </td> <td
    ///    width="60%"> One or more parameters was invalid. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>DIERR_NOTFOUND</b></dt> </dl> </td> <td width="60%"> The key is missing on this system. Applications
    ///    should proceed as if the key were empty. </td> </tr> </table>
    ///    
    HRESULT OpenAppStatusKey(HKEY* param0);
}


