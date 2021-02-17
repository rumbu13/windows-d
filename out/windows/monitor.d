// Written in the D programming language.

module windows.monitor;

public import windows.core;
public import windows.com : HRESULT;
public import windows.direct2d : IDirect3DDevice9;
public import windows.systemservices : HANDLE;

extern(Windows):


// Enums


///Describes a Virtual Control Panel (VCP) code type.
alias MC_VCP_CODE_TYPE = int;
enum : int
{
    ///Momentary VCP code. Sending a command of this type causes the monitor to initiate a self-timed operation and then
    ///revert to its original state. Examples include display tests and degaussing.
    MC_MOMENTARY     = 0x00000000,
    ///Set Parameter VCP code. Sending a command of this type changes some aspect of the monitor's operation.
    MC_SET_PARAMETER = 0x00000001,
}

///Identifies monitor display technologies.
alias MC_DISPLAY_TECHNOLOGY_TYPE = int;
enum : int
{
    ///Shadow-mask cathode ray tube (CRT).
    MC_SHADOW_MASK_CATHODE_RAY_TUBE    = 0x00000000,
    ///Aperture-grill CRT.
    MC_APERTURE_GRILL_CATHODE_RAY_TUBE = 0x00000001,
    ///Thin-film transistor (TFT) display.
    MC_THIN_FILM_TRANSISTOR            = 0x00000002,
    ///Liquid crystal on silicon (LCOS) display.
    MC_LIQUID_CRYSTAL_ON_SILICON       = 0x00000003,
    ///Plasma display.
    MC_PLASMA                          = 0x00000004,
    ///Organic light emitting diode (LED) display.
    MC_ORGANIC_LIGHT_EMITTING_DIODE    = 0x00000005,
    ///Electroluminescent display.
    MC_ELECTROLUMINESCENT              = 0x00000006,
    ///Microelectromechanical display.
    MC_MICROELECTROMECHANICAL          = 0x00000007,
    ///Field emission device (FED) display.
    MC_FIELD_EMISSION_DEVICE           = 0x00000008,
}

///Specifies whether to set or get a monitor's red, green, or blue drive.
alias MC_DRIVE_TYPE = int;
enum : int
{
    ///Red drive.
    MC_RED_DRIVE   = 0x00000000,
    ///Green drive.
    MC_GREEN_DRIVE = 0x00000001,
    ///Blue drive.
    MC_BLUE_DRIVE  = 0x00000002,
}

///Specifies whether to get or set a monitor's red, green, or blue gain.
alias MC_GAIN_TYPE = int;
enum : int
{
    ///Red gain.
    MC_RED_GAIN   = 0x00000000,
    ///Green gain.
    MC_GREEN_GAIN = 0x00000001,
    ///Blue gain.
    MC_BLUE_GAIN  = 0x00000002,
}

///Specifies whether to get or set the vertical or horizontal position of a monitor's display area.
alias MC_POSITION_TYPE = int;
enum : int
{
    ///Horizontal position.
    MC_HORIZONTAL_POSITION = 0x00000000,
    ///Vertical position.
    MC_VERTICAL_POSITION   = 0x00000001,
}

///Specifies whether to get or set the width or height of a monitor's display area.
alias MC_SIZE_TYPE = int;
enum : int
{
    ///Width.
    MC_WIDTH  = 0x00000000,
    ///Height.
    MC_HEIGHT = 0x00000001,
}

///Describes a monitor's color temperature.
alias MC_COLOR_TEMPERATURE = int;
enum : int
{
    ///Unknown temperature.
    MC_COLOR_TEMPERATURE_UNKNOWN = 0x00000000,
    ///4,000 kelvins (K).
    MC_COLOR_TEMPERATURE_4000K   = 0x00000001,
    ///5,000 K.
    MC_COLOR_TEMPERATURE_5000K   = 0x00000002,
    ///6,500 K.
    MC_COLOR_TEMPERATURE_6500K   = 0x00000003,
    ///7,500 K.
    MC_COLOR_TEMPERATURE_7500K   = 0x00000004,
    ///8,200 K.
    MC_COLOR_TEMPERATURE_8200K   = 0x00000005,
    ///9,300 K
    MC_COLOR_TEMPERATURE_9300K   = 0x00000006,
    ///10,000 K.
    MC_COLOR_TEMPERATURE_10000K  = 0x00000007,
    ///11,500 K.
    MC_COLOR_TEMPERATURE_11500K  = 0x00000008,
}

// Structs


///Contains a handle and text description corresponding to a physical monitor.
struct PHYSICAL_MONITOR
{
align (1):
    ///Handle to the physical monitor.
    HANDLE      hPhysicalMonitor;
    ///Text description of the physical monitor.
    ushort[128] szPhysicalMonitorDescription;
}

///Contains information from a monitor's timing report.
struct MC_TIMING_REPORT
{
align (1):
    ///The monitor's horizontal synchronization frequency in Hz.
    uint  dwHorizontalFrequencyInHZ;
    ///The monitor's vertical synchronization frequency in Hz.
    uint  dwVerticalFrequencyInHZ;
    ///Timing status byte. For more information about this value, see the Display Data Channel Command Interface
    ///(DDC/CI) standard.
    ubyte bTimingStatusByte;
}

// Functions

///Retrieves the number of physical monitors associated with an <b>HMONITOR</b> monitor handle. Call this function
///before calling GetPhysicalMonitorsFromHMONITOR.
///Params:
///    hMonitor = A monitor handle. Monitor handles are returned by several Multiple Display Monitor functions, including
///               EnumDisplayMonitors and MonitorFromWindow, which are part of the graphics device interface (GDI).
///    pdwNumberOfPhysicalMonitors = Receives the number of physical monitors associated with the monitor handle.
///Returns:
///    If the function succeeds, the return value is <b>TRUE</b>. If the function fails, the return value is
///    <b>FALSE</b>. To get extended error information, call GetLastError.
///    
@DllImport("dxva2")
int GetNumberOfPhysicalMonitorsFromHMONITOR(ptrdiff_t hMonitor, uint* pdwNumberOfPhysicalMonitors);

///Retrieves the number of physical monitors associated with a Direct3D device.
///Params:
///    pDirect3DDevice9 = Pointer to the IDirect3DDevice9 interface of the Direct3D device.
///    pdwNumberOfPhysicalMonitors = Receives the number of physical monitors associated with the Direct3D device.
///Returns:
///    If this function succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
///    
@DllImport("dxva2")
HRESULT GetNumberOfPhysicalMonitorsFromIDirect3DDevice9(IDirect3DDevice9 pDirect3DDevice9, 
                                                        uint* pdwNumberOfPhysicalMonitors);

///Retrieves the physical monitors associated with an <b>HMONITOR</b> monitor handle.
///Params:
///    hMonitor = A monitor handle. Monitor handles are returned by several Multiple Display Monitor functions, including
///               EnumDisplayMonitors and MonitorFromWindow, which are part of the graphics device interface (GDI).
///    dwPhysicalMonitorArraySize = Number of elements in <i>pPhysicalMonitorArray</i>. To get the required size of the array, call
///                                 GetNumberOfPhysicalMonitorsFromHMONITOR.
///    pPhysicalMonitorArray = Pointer to an array of PHYSICAL_MONITOR structures. The caller must allocate the array.
///Returns:
///    If the function succeeds, the return value is <b>TRUE</b>. If the function fails, the return value is
///    <b>FALSE</b>. To get extended error information, call GetLastError.
///    
@DllImport("dxva2")
int GetPhysicalMonitorsFromHMONITOR(ptrdiff_t hMonitor, uint dwPhysicalMonitorArraySize, 
                                    char* pPhysicalMonitorArray);

///Retrieves the physical monitors associated with a Direct3D device.
///Params:
///    pDirect3DDevice9 = Pointer to the IDirect3DDevice9 interface of the Direct3D device.
///    dwPhysicalMonitorArraySize = Number of elements in <i>pPhysicalMonitorArray</i>. To get the required size of the array, call
///                                 GetNumberOfPhysicalMonitorsFromIDirect3DDevice9.
///    pPhysicalMonitorArray = Pointer to an array of PHYSICAL_MONITOR structures. The caller must allocate the array.
///Returns:
///    If this function succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
///    
@DllImport("dxva2")
HRESULT GetPhysicalMonitorsFromIDirect3DDevice9(IDirect3DDevice9 pDirect3DDevice9, uint dwPhysicalMonitorArraySize, 
                                                char* pPhysicalMonitorArray);

///Closes a handle to a physical monitor. Call this function to close a monitor handle obtained from the
///GetPhysicalMonitorsFromHMONITOR or GetPhysicalMonitorsFromIDirect3DDevice9 function.
///Params:
///    hMonitor = Handle to a physical monitor.
///Returns:
///    If the function succeeds, the return value is <b>TRUE</b>. If the function fails, the return value is
///    <b>FALSE</b>. To get extended error information, call GetLastError.
///    
@DllImport("dxva2")
int DestroyPhysicalMonitor(HANDLE hMonitor);

///Closes an array of physical monitor handles. Call this function to close an array of monitor handles obtained from
///the GetPhysicalMonitorsFromHMONITOR or GetPhysicalMonitorsFromIDirect3DDevice9 function.
///Params:
///    dwPhysicalMonitorArraySize = Number of elements in the <i>pPhysicalMonitorArray</i> array.
///    pPhysicalMonitorArray = Pointer to an array of PHYSICAL_MONITOR structures.
///Returns:
///    If the function succeeds, the return value is <b>TRUE</b>. If the function fails, the return value is
///    <b>FALSE</b>. To get extended error information, call GetLastError.
///    
@DllImport("dxva2")
int DestroyPhysicalMonitors(uint dwPhysicalMonitorArraySize, char* pPhysicalMonitorArray);

///Retrieves the current value, maximum value, and code type of a Virtual Control Panel (VCP) code for a monitor.
///Params:
///    hMonitor = Handle to a physical monitor. To get the monitor handle, call GetPhysicalMonitorsFromHMONITOR or
///               GetPhysicalMonitorsFromIDirect3DDevice9.
///    bVCPCode = VCP code to query. The VCP codes are Include the VESA Monitor Control Command Set (MCCS) standard, versions 1.0
///               and 2.0. This parameter must specify a continuous or non-continuous VCP, or a vendor-specific code. It should not
///               be a table control code.
///    pvct = Receives the VCP code type, as a member of the MC_VCP_CODE_TYPE enumeration. This parameter can be <b>NULL</b>.
///    pdwCurrentValue = Receives the current value of the VCP code. This parameter can be <b>NULL</b>.
///    pdwMaximumValue = If <i>bVCPCode</i> specifies a continuous VCP code, this parameter receives the maximum value of the VCP code. If
///                      <i>bVCPCode</i> specifies a non-continuous VCP code, the value received in this parameter is undefined. This
///                      parameter can be <b>NULL</b>.
///Returns:
///    If the function succeeds, the return value is <b>TRUE</b>. If the function fails, the return value is
///    <b>FALSE</b>. To get extended error information, call GetLastError.
///    
@DllImport("dxva2")
int GetVCPFeatureAndVCPFeatureReply(HANDLE hMonitor, ubyte bVCPCode, MC_VCP_CODE_TYPE* pvct, uint* pdwCurrentValue, 
                                    uint* pdwMaximumValue);

///Sets the value of a Virtual Control Panel (VCP) code for a monitor.
///Params:
///    hMonitor = Handle to a physical monitor. To get the monitor handle, call GetPhysicalMonitorsFromHMONITOR or
///               GetPhysicalMonitorsFromIDirect3DDevice9.
///    bVCPCode = VCP code to set. The VCP codes are defined in the VESA Monitor Control Command Set (MCCS) standard, version 1.0
///               and 2.0. This parameter must specify a continuous or non-continuous VCP, or a vendor-specific code. It should not
///               be a table control code.
///    dwNewValue = Value of the VCP code.
///Returns:
///    If the function succeeds, the return value is <b>TRUE</b>. If the function fails, the return value is
///    <b>FALSE</b>. To get extended error information, call GetLastError.
///    
@DllImport("dxva2")
int SetVCPFeature(HANDLE hMonitor, ubyte bVCPCode, uint dwNewValue);

///Saves the current monitor settings to the display's nonvolatile storage.
///Params:
///    hMonitor = Handle to a physical monitor. To get the monitor handle, call GetPhysicalMonitorsFromHMONITOR or
///               GetPhysicalMonitorsFromIDirect3DDevice9.
///Returns:
///    If the function succeeds, the return value is <b>TRUE</b>. If the function fails, the return value is
///    <b>FALSE</b>. To get extended error information, call GetLastError.
///    
@DllImport("dxva2")
int SaveCurrentSettings(HANDLE hMonitor);

///Retrieves the length of a monitor's capabilities string.
///Params:
///    hMonitor = Handle to a physical monitor. To get the monitor handle, call GetPhysicalMonitorsFromHMONITOR or
///               GetPhysicalMonitorsFromIDirect3DDevice9.
///    pdwCapabilitiesStringLengthInCharacters = Receives the length of the capabilities string, in characters, including the terminating null character.
///Returns:
///    If the function succeeds, the return value is <b>TRUE</b>. If the function fails, the return value is
///    <b>FALSE</b>. To get extended error information, call GetLastError.
///    
@DllImport("dxva2")
int GetCapabilitiesStringLength(HANDLE hMonitor, uint* pdwCapabilitiesStringLengthInCharacters);

///Retrieves a string describing a monitor's capabilities.
///Params:
///    hMonitor = Handle to a physical monitor. To get the monitor handle, call GetPhysicalMonitorsFromHMONITOR or
///               GetPhysicalMonitorsFromIDirect3DDevice9.
///    pszASCIICapabilitiesString = Pointer to a buffer that receives the monitor's capabilities string. The caller must allocate this buffer. To get
///                                 the size of the string, call GetCapabilitiesStringLength. The capabilities string is always an ASCII string. The
///                                 buffer must include space for the terminating null character.
///    dwCapabilitiesStringLengthInCharacters = Size of <i>pszASCIICapabilitiesString</i> in characters, including the terminating null character.
///Returns:
///    If the function succeeds, the return value is <b>TRUE</b>. If the function fails, the return value is
///    <b>FALSE</b>. To get extended error information, call GetLastError.
///    
@DllImport("dxva2")
int CapabilitiesRequestAndCapabilitiesReply(HANDLE hMonitor, const(char)* pszASCIICapabilitiesString, 
                                            uint dwCapabilitiesStringLengthInCharacters);

///Retrieves a monitor's horizontal and vertical synchronization frequencies.
///Params:
///    hMonitor = Handle to a physical monitor. To get the monitor handle, call GetPhysicalMonitorsFromHMONITOR or
///               GetPhysicalMonitorsFromIDirect3DDevice9.
///    pmtrMonitorTimingReport = Pointer to an MC_TIMING_REPORT structure that receives the timing information.
///Returns:
///    If the function succeeds, the return value is <b>TRUE</b>. If the function fails, the return value is
///    <b>FALSE</b>. To get extended error information, call GetLastError.
///    
@DllImport("dxva2")
int GetTimingReport(HANDLE hMonitor, MC_TIMING_REPORT* pmtrMonitorTimingReport);

///Retrieves the configuration capabilities of a monitor. Call this function to find out which high-level monitor
///configuration functions are supported by the monitor.
///Params:
///    hMonitor = Handle to a physical monitor. To get the monitor handle, call GetPhysicalMonitorsFromHMONITOR or
///               GetPhysicalMonitorsFromIDirect3DDevice9.
///    pdwMonitorCapabilities = Receives a bitwise <b>OR</b> of capabilities flags. See Remarks.
///    pdwSupportedColorTemperatures = Receives a bitwise <b>OR</b> of color temperature flags. See Remarks.
///Returns:
///    If the function succeeds, the return value is <b>TRUE</b>. If the function fails, the return value is
///    <b>FALSE</b>. To get extended error information, call <b>GetLastError</b>. The function fails if the monitor does
///    not support DDC/CI.
///    
@DllImport("dxva2")
int GetMonitorCapabilities(HANDLE hMonitor, uint* pdwMonitorCapabilities, uint* pdwSupportedColorTemperatures);

///Saves the current monitor settings to the display's nonvolatile storage.
///Params:
///    hMonitor = Handle to a physical monitor. To get the monitor handle, call GetPhysicalMonitorsFromHMONITOR or
///               GetPhysicalMonitorsFromIDirect3DDevice9.
///Returns:
///    If the function succeeds, the return value is <b>TRUE</b>. If the function fails, the return value is
///    <b>FALSE</b>. To get extended error information, call GetLastError.
///    
@DllImport("dxva2")
int SaveCurrentMonitorSettings(HANDLE hMonitor);

///Retrieves the type of technology used by a monitor.
///Params:
///    hMonitor = Handle to a physical monitor. To get the monitor handle, call GetPhysicalMonitorsFromHMONITOR or
///               GetPhysicalMonitorsFromIDirect3DDevice9.
///    pdtyDisplayTechnologyType = Receives the technology type, specified as a member of the MC_DISPLAY_TECHNOLOGY_TYPE enumeration.
///Returns:
///    If the function succeeds, the return value is <b>TRUE</b>. If the function fails, the return value is
///    <b>FALSE</b>. To get extended error information, call GetLastError.
///    
@DllImport("dxva2")
int GetMonitorTechnologyType(HANDLE hMonitor, MC_DISPLAY_TECHNOLOGY_TYPE* pdtyDisplayTechnologyType);

///Retrieves a monitor's minimum, maximum, and current brightness settings.
///Params:
///    hMonitor = Handle to a physical monitor. To get the monitor handle, call GetPhysicalMonitorsFromHMONITOR or
///               GetPhysicalMonitorsFromIDirect3DDevice9.
///    pdwMinimumBrightness = Receives the monitor's minimum brightness.
///    pdwCurrentBrightness = Receives the monitor's current brightness.
///    pdwMaximumBrightness = Receives the monitor's maximum brightness.
///Returns:
///    If the function succeeds, the return value is <b>TRUE</b>. If the function fails, the return value is
///    <b>FALSE</b>. To get extended error information, call GetLastError.
///    
@DllImport("dxva2")
int GetMonitorBrightness(HANDLE hMonitor, uint* pdwMinimumBrightness, uint* pdwCurrentBrightness, 
                         uint* pdwMaximumBrightness);

///Retrieves a monitor's minimum, maximum, and current contrast settings.
///Params:
///    hMonitor = Handle to a physical monitor. To get the monitor handle, call GetPhysicalMonitorsFromHMONITOR or
///               GetPhysicalMonitorsFromIDirect3DDevice9.
///    pdwMinimumContrast = Receives the monitor's minimum contrast.
///    pdwCurrentContrast = Receives the monitor's current contrast.
///    pdwMaximumContrast = Receives the monitor's maximum contrast.
///Returns:
///    If the function succeeds, the return value is <b>TRUE</b>. If the function fails, the return value is
///    <b>FALSE</b>. To get extended error information, call GetLastError.
///    
@DllImport("dxva2")
int GetMonitorContrast(HANDLE hMonitor, uint* pdwMinimumContrast, uint* pdwCurrentContrast, 
                       uint* pdwMaximumContrast);

///Retrieves a monitor's current color temperature.
///Params:
///    hMonitor = Handle to a physical monitor. To get the monitor handle, call GetPhysicalMonitorsFromHMONITOR or
///               GetPhysicalMonitorsFromIDirect3DDevice9.
///    pctCurrentColorTemperature = Receives the monitor's current color temperature, specified as a member of the MC_COLOR_TEMPERATURE enumeration.
///Returns:
///    If the function succeeds, the return value is <b>TRUE</b>. If the function fails, the return value is
///    <b>FALSE</b>. To get extended error information, call GetLastError.
///    
@DllImport("dxva2")
int GetMonitorColorTemperature(HANDLE hMonitor, MC_COLOR_TEMPERATURE* pctCurrentColorTemperature);

///Retrieves a monitor's red, green, or blue drive value.
///Params:
///    hMonitor = Handle to a physical monitor. To get the monitor handle, call GetPhysicalMonitorsFromHMONITOR or
///               GetPhysicalMonitorsFromIDirect3DDevice9.
///    dtDriveType = A member of the MC_DRIVE_TYPE enumeration, specifying whether to retrieve the red, green, or blue drive value.
///    pdwMinimumDrive = Receives the minimum red, green, or blue drive value.
///    pdwCurrentDrive = Receives the current red, green, or blue drive value.
///    pdwMaximumDrive = Receives the maximum red, green, or blue drive value.
///Returns:
///    If the function succeeds, the return value is <b>TRUE</b>. If the function fails, the return value is
///    <b>FALSE</b>. To get extended error information, call GetLastError.
///    
@DllImport("dxva2")
int GetMonitorRedGreenOrBlueDrive(HANDLE hMonitor, MC_DRIVE_TYPE dtDriveType, uint* pdwMinimumDrive, 
                                  uint* pdwCurrentDrive, uint* pdwMaximumDrive);

///Retrieves a monitor's red, green, or blue gain value.
///Params:
///    hMonitor = Handle to a physical monitor. To get the monitor handle, call GetPhysicalMonitorsFromHMONITOR or
///               GetPhysicalMonitorsFromIDirect3DDevice9.
///    gtGainType = A member of the MC_GAIN_TYPE enumeration, specifying whether to retrieve the red, green, or blue gain value.
///    pdwMinimumGain = Receives the minimum red, green, or blue gain value.
///    pdwCurrentGain = Receives the current red, green, or blue gain value.
///    pdwMaximumGain = Receives the maximum red, green, or blue gain value.
///Returns:
///    If the function succeeds, the return value is <b>TRUE</b>. If the function fails, the return value is
///    <b>FALSE</b>. To get extended error information, call GetLastError.
///    
@DllImport("dxva2")
int GetMonitorRedGreenOrBlueGain(HANDLE hMonitor, MC_GAIN_TYPE gtGainType, uint* pdwMinimumGain, 
                                 uint* pdwCurrentGain, uint* pdwMaximumGain);

///Sets a monitor's brightness value. Increasing the brightness value makes the display on the monitor brighter, and
///decreasing it makes the display dimmer.
///Params:
///    hMonitor = Handle to a physical monitor. To get the monitor handle, call GetPhysicalMonitorsFromHMONITOR or
///               GetPhysicalMonitorsFromIDirect3DDevice9.
///    dwNewBrightness = Brightness value. To get the monitor's minimum and maximum brightness values, call GetMonitorBrightness.
///Returns:
///    If the function succeeds, the return value is <b>TRUE</b>. If the function fails, the return value is
///    <b>FALSE</b>. To get extended error information, call GetLastError.
///    
@DllImport("dxva2")
int SetMonitorBrightness(HANDLE hMonitor, uint dwNewBrightness);

///Sets a monitor's contrast value.
///Params:
///    hMonitor = Handle to a physical monitor. To get the monitor handle, call GetPhysicalMonitorsFromHMONITOR or
///               GetPhysicalMonitorsFromIDirect3DDevice9.
///    dwNewContrast = Contrast value. To get the monitor's minimum and maximum contrast values, call, call GetMonitorContrast.
///Returns:
///    If the function succeeds, the return value is <b>TRUE</b>. If the function fails, the return value is
///    <b>FALSE</b>. To get extended error information, call GetLastError.
///    
@DllImport("dxva2")
int SetMonitorContrast(HANDLE hMonitor, uint dwNewContrast);

///Sets a monitor's color temperature.
///Params:
///    hMonitor = Handle to a physical monitor. To get the monitor handle, call GetPhysicalMonitorsFromHMONITOR or
///               GetPhysicalMonitorsFromIDirect3DDevice9.
///    ctCurrentColorTemperature = Color temperature, specified as a member of the MC_COLOR_TEMPERATURE enumeration.
///Returns:
///    If the function succeeds, the return value is <b>TRUE</b>. If the function fails, the return value is
///    <b>FALSE</b>. To get extended error information, call GetLastError.
///    
@DllImport("dxva2")
int SetMonitorColorTemperature(HANDLE hMonitor, MC_COLOR_TEMPERATURE ctCurrentColorTemperature);

///Sets a monitor's red, green, or blue drive value.
///Params:
///    hMonitor = Handle to a physical monitor. To get the monitor handle, call GetPhysicalMonitorsFromHMONITOR or
///               GetPhysicalMonitorsFromIDirect3DDevice9.
///    dtDriveType = A member of the MC_DRIVE_TYPE enumeration, specifying whether to set the red, green, or blue drive value.
///    dwNewDrive = Red, green, or blue drive value. To get the monitor's minimum and maximum drive values, call
///                 GetMonitorRedGreenOrBlueDrive.
///Returns:
///    If the function succeeds, the return value is <b>TRUE</b>. If the function fails, the return value is
///    <b>FALSE</b>. To get extended error information, call GetLastError.
///    
@DllImport("dxva2")
int SetMonitorRedGreenOrBlueDrive(HANDLE hMonitor, MC_DRIVE_TYPE dtDriveType, uint dwNewDrive);

///Sets a monitor's red, green, or blue gain value.
///Params:
///    hMonitor = Handle to a physical monitor. To get the monitor handle, call GetPhysicalMonitorsFromHMONITOR or
///               GetPhysicalMonitorsFromIDirect3DDevice9.
///    gtGainType = A member of the MC_GAIN_TYPE enumeration, specifying whether to set the red, green, or blue gain.
///    dwNewGain = Red, green, or blue gain value. To get the monitor's minimum and maximum gain values, call
///                GetMonitorRedGreenOrBlueGain.
///Returns:
///    If the function succeeds, the return value is <b>TRUE</b>. If the function fails, the return value is
///    <b>FALSE</b>. To get extended error information, call GetLastError.
///    
@DllImport("dxva2")
int SetMonitorRedGreenOrBlueGain(HANDLE hMonitor, MC_GAIN_TYPE gtGainType, uint dwNewGain);

///Degausses a monitor. Degaussing improves a monitor's image quality and color fidelity by demagnetizing the monitor.
///Params:
///    hMonitor = Handle to a physical monitor. To get the monitor handle, call GetPhysicalMonitorsFromHMONITOR or
///               GetPhysicalMonitorsFromIDirect3DDevice9.
///Returns:
///    If the function succeeds, the return value is <b>TRUE</b>. If the function fails, the return value is
///    <b>FALSE</b>. To get extended error information, call GetLastError.
///    
@DllImport("dxva2")
int DegaussMonitor(HANDLE hMonitor);

///Retrieves a monitor's minimum, maximum, and current width or height.
///Params:
///    hMonitor = Handle to a physical monitor. To get the monitor handle, call GetPhysicalMonitorsFromHMONITOR or
///               GetPhysicalMonitorsFromIDirect3DDevice9.
///    stSizeType = A member of the MC_SIZE_TYPE enumeration, specifying whether to retrieve the width or the height.
///    pdwMinimumWidthOrHeight = Receives the minimum width or height.
///    pdwCurrentWidthOrHeight = Receives the current width or height.
///    pdwMaximumWidthOrHeight = Receives the maximum width or height.
///Returns:
///    If the function succeeds, the return value is <b>TRUE</b>. If the function fails, the return value is
///    <b>FALSE</b>. To get extended error information, call GetLastError.
///    
@DllImport("dxva2")
int GetMonitorDisplayAreaSize(HANDLE hMonitor, MC_SIZE_TYPE stSizeType, uint* pdwMinimumWidthOrHeight, 
                              uint* pdwCurrentWidthOrHeight, uint* pdwMaximumWidthOrHeight);

///Retrieves a monitor's minimum, maximum, and current horizontal or vertical position.
///Params:
///    hMonitor = Handle to a physical monitor. To get the monitor handle, call GetPhysicalMonitorsFromHMONITOR or
///               GetPhysicalMonitorsFromIDirect3DDevice9.
///    ptPositionType = A member of the MC_POSITION_TYPE enumeration, specifying whether to retrieve the horizontal position or the
///                     vertical position.
///    pdwMinimumPosition = Receives the minimum horizontal or vertical position.
///    pdwCurrentPosition = Receives the current horizontal or vertical position.
///    pdwMaximumPosition = Receives the maximum horizontal or vertical position.
///Returns:
///    If the function succeeds, the return value is <b>TRUE</b>. If the function fails, the return value is
///    <b>FALSE</b>. To get extended error information, call GetLastError.
///    
@DllImport("dxva2")
int GetMonitorDisplayAreaPosition(HANDLE hMonitor, MC_POSITION_TYPE ptPositionType, uint* pdwMinimumPosition, 
                                  uint* pdwCurrentPosition, uint* pdwMaximumPosition);

///Sets the width or height of a monitor's display area.
///Params:
///    hMonitor = Handle to a physical monitor. To get the monitor handle, call GetPhysicalMonitorsFromHMONITOR or
///               GetPhysicalMonitorsFromIDirect3DDevice9.
///    stSizeType = A member of the MC_SIZE_TYPE enumeration, specifying whether to set the width or the height.
///    dwNewDisplayAreaWidthOrHeight = Display area width or height. To get the minimum and maximum width and height, call GetMonitorDisplayAreaSize.
///Returns:
///    If the function succeeds, the return value is <b>TRUE</b>. If the function fails, the return value is
///    <b>FALSE</b>. To get extended error information, call GetLastError.
///    
@DllImport("dxva2")
int SetMonitorDisplayAreaSize(HANDLE hMonitor, MC_SIZE_TYPE stSizeType, uint dwNewDisplayAreaWidthOrHeight);

///Sets the horizontal or vertical position of a monitor's display area. Increasing the horizontal position moves the
///display area toward the right side of the screen; decreasing it moves the display area toward the left. Increasing
///the vertical position moves the display area toward the top of the screen; decreasing it moves the display area
///toward the bottom.
///Params:
///    hMonitor = Handle to a physical monitor. To get the monitor handle, call GetPhysicalMonitorsFromHMONITOR or
///               GetPhysicalMonitorsFromIDirect3DDevice9.
///    ptPositionType = A member of the MC_POSITION_TYPE enumeration, specifying whether to set the horizontal position or the vertical
///                     position.
///    dwNewPosition = Horizontal or vertical position. To get the minimum and maximum position, call GetMonitorDisplayAreaPosition.
///Returns:
///    If the function succeeds, the return value is <b>TRUE</b>. If the function fails, the return value is
///    <b>FALSE</b>. To get extended error information, call GetLastError.
///    
@DllImport("dxva2")
int SetMonitorDisplayAreaPosition(HANDLE hMonitor, MC_POSITION_TYPE ptPositionType, uint dwNewPosition);

///Restores a monitor's color settings to their factory defaults.
///Params:
///    hMonitor = Handle to a physical monitor. To get the monitor handle, call GetPhysicalMonitorsFromHMONITOR or
///               GetPhysicalMonitorsFromIDirect3DDevice9.
///Returns:
///    If the function succeeds, the return value is <b>TRUE</b>. If the function fails, the return value is
///    <b>FALSE</b>. To get extended error information, call GetLastError.
///    
@DllImport("dxva2")
int RestoreMonitorFactoryColorDefaults(HANDLE hMonitor);

///Restores a monitor's settings to their factory defaults.
///Params:
///    hMonitor = Handle to a physical monitor. To get the monitor handle, call GetPhysicalMonitorsFromHMONITOR or
///               GetPhysicalMonitorsFromIDirect3DDevice9.
///Returns:
///    If the function succeeds, the return value is <b>TRUE</b>. If the function fails, the return value is
///    <b>FALSE</b>. To get extended error information, call GetLastError.
///    
@DllImport("dxva2")
int RestoreMonitorFactoryDefaults(HANDLE hMonitor);


