module windows.monitor;

public import windows.core;
public import windows.com : HRESULT;
public import windows.direct2d : IDirect3DDevice9;
public import windows.systemservices : HANDLE;

extern(Windows):


// Enums


enum : int
{
    MC_MOMENTARY     = 0x00000000,
    MC_SET_PARAMETER = 0x00000001,
}
alias MC_VCP_CODE_TYPE = int;

enum : int
{
    MC_SHADOW_MASK_CATHODE_RAY_TUBE    = 0x00000000,
    MC_APERTURE_GRILL_CATHODE_RAY_TUBE = 0x00000001,
    MC_THIN_FILM_TRANSISTOR            = 0x00000002,
    MC_LIQUID_CRYSTAL_ON_SILICON       = 0x00000003,
    MC_PLASMA                          = 0x00000004,
    MC_ORGANIC_LIGHT_EMITTING_DIODE    = 0x00000005,
    MC_ELECTROLUMINESCENT              = 0x00000006,
    MC_MICROELECTROMECHANICAL          = 0x00000007,
    MC_FIELD_EMISSION_DEVICE           = 0x00000008,
}
alias MC_DISPLAY_TECHNOLOGY_TYPE = int;

enum : int
{
    MC_RED_DRIVE   = 0x00000000,
    MC_GREEN_DRIVE = 0x00000001,
    MC_BLUE_DRIVE  = 0x00000002,
}
alias MC_DRIVE_TYPE = int;

enum : int
{
    MC_RED_GAIN   = 0x00000000,
    MC_GREEN_GAIN = 0x00000001,
    MC_BLUE_GAIN  = 0x00000002,
}
alias MC_GAIN_TYPE = int;

enum : int
{
    MC_HORIZONTAL_POSITION = 0x00000000,
    MC_VERTICAL_POSITION   = 0x00000001,
}
alias MC_POSITION_TYPE = int;

enum : int
{
    MC_WIDTH  = 0x00000000,
    MC_HEIGHT = 0x00000001,
}
alias MC_SIZE_TYPE = int;

enum : int
{
    MC_COLOR_TEMPERATURE_UNKNOWN = 0x00000000,
    MC_COLOR_TEMPERATURE_4000K   = 0x00000001,
    MC_COLOR_TEMPERATURE_5000K   = 0x00000002,
    MC_COLOR_TEMPERATURE_6500K   = 0x00000003,
    MC_COLOR_TEMPERATURE_7500K   = 0x00000004,
    MC_COLOR_TEMPERATURE_8200K   = 0x00000005,
    MC_COLOR_TEMPERATURE_9300K   = 0x00000006,
    MC_COLOR_TEMPERATURE_10000K  = 0x00000007,
    MC_COLOR_TEMPERATURE_11500K  = 0x00000008,
}
alias MC_COLOR_TEMPERATURE = int;

// Structs


struct PHYSICAL_MONITOR
{
align (1):
    HANDLE      hPhysicalMonitor;
    ushort[128] szPhysicalMonitorDescription;
}

struct MC_TIMING_REPORT
{
align (1):
    uint  dwHorizontalFrequencyInHZ;
    uint  dwVerticalFrequencyInHZ;
    ubyte bTimingStatusByte;
}

// Functions

@DllImport("dxva2")
int GetNumberOfPhysicalMonitorsFromHMONITOR(ptrdiff_t hMonitor, uint* pdwNumberOfPhysicalMonitors);

@DllImport("dxva2")
HRESULT GetNumberOfPhysicalMonitorsFromIDirect3DDevice9(IDirect3DDevice9 pDirect3DDevice9, 
                                                        uint* pdwNumberOfPhysicalMonitors);

@DllImport("dxva2")
int GetPhysicalMonitorsFromHMONITOR(ptrdiff_t hMonitor, uint dwPhysicalMonitorArraySize, 
                                    char* pPhysicalMonitorArray);

@DllImport("dxva2")
HRESULT GetPhysicalMonitorsFromIDirect3DDevice9(IDirect3DDevice9 pDirect3DDevice9, uint dwPhysicalMonitorArraySize, 
                                                char* pPhysicalMonitorArray);

@DllImport("dxva2")
int DestroyPhysicalMonitor(HANDLE hMonitor);

@DllImport("dxva2")
int DestroyPhysicalMonitors(uint dwPhysicalMonitorArraySize, char* pPhysicalMonitorArray);

@DllImport("dxva2")
int GetVCPFeatureAndVCPFeatureReply(HANDLE hMonitor, ubyte bVCPCode, MC_VCP_CODE_TYPE* pvct, uint* pdwCurrentValue, 
                                    uint* pdwMaximumValue);

@DllImport("dxva2")
int SetVCPFeature(HANDLE hMonitor, ubyte bVCPCode, uint dwNewValue);

@DllImport("dxva2")
int SaveCurrentSettings(HANDLE hMonitor);

@DllImport("dxva2")
int GetCapabilitiesStringLength(HANDLE hMonitor, uint* pdwCapabilitiesStringLengthInCharacters);

@DllImport("dxva2")
int CapabilitiesRequestAndCapabilitiesReply(HANDLE hMonitor, const(char)* pszASCIICapabilitiesString, 
                                            uint dwCapabilitiesStringLengthInCharacters);

@DllImport("dxva2")
int GetTimingReport(HANDLE hMonitor, MC_TIMING_REPORT* pmtrMonitorTimingReport);

@DllImport("dxva2")
int GetMonitorCapabilities(HANDLE hMonitor, uint* pdwMonitorCapabilities, uint* pdwSupportedColorTemperatures);

@DllImport("dxva2")
int SaveCurrentMonitorSettings(HANDLE hMonitor);

@DllImport("dxva2")
int GetMonitorTechnologyType(HANDLE hMonitor, MC_DISPLAY_TECHNOLOGY_TYPE* pdtyDisplayTechnologyType);

@DllImport("dxva2")
int GetMonitorBrightness(HANDLE hMonitor, uint* pdwMinimumBrightness, uint* pdwCurrentBrightness, 
                         uint* pdwMaximumBrightness);

@DllImport("dxva2")
int GetMonitorContrast(HANDLE hMonitor, uint* pdwMinimumContrast, uint* pdwCurrentContrast, 
                       uint* pdwMaximumContrast);

@DllImport("dxva2")
int GetMonitorColorTemperature(HANDLE hMonitor, MC_COLOR_TEMPERATURE* pctCurrentColorTemperature);

@DllImport("dxva2")
int GetMonitorRedGreenOrBlueDrive(HANDLE hMonitor, MC_DRIVE_TYPE dtDriveType, uint* pdwMinimumDrive, 
                                  uint* pdwCurrentDrive, uint* pdwMaximumDrive);

@DllImport("dxva2")
int GetMonitorRedGreenOrBlueGain(HANDLE hMonitor, MC_GAIN_TYPE gtGainType, uint* pdwMinimumGain, 
                                 uint* pdwCurrentGain, uint* pdwMaximumGain);

@DllImport("dxva2")
int SetMonitorBrightness(HANDLE hMonitor, uint dwNewBrightness);

@DllImport("dxva2")
int SetMonitorContrast(HANDLE hMonitor, uint dwNewContrast);

@DllImport("dxva2")
int SetMonitorColorTemperature(HANDLE hMonitor, MC_COLOR_TEMPERATURE ctCurrentColorTemperature);

@DllImport("dxva2")
int SetMonitorRedGreenOrBlueDrive(HANDLE hMonitor, MC_DRIVE_TYPE dtDriveType, uint dwNewDrive);

@DllImport("dxva2")
int SetMonitorRedGreenOrBlueGain(HANDLE hMonitor, MC_GAIN_TYPE gtGainType, uint dwNewGain);

@DllImport("dxva2")
int DegaussMonitor(HANDLE hMonitor);

@DllImport("dxva2")
int GetMonitorDisplayAreaSize(HANDLE hMonitor, MC_SIZE_TYPE stSizeType, uint* pdwMinimumWidthOrHeight, 
                              uint* pdwCurrentWidthOrHeight, uint* pdwMaximumWidthOrHeight);

@DllImport("dxva2")
int GetMonitorDisplayAreaPosition(HANDLE hMonitor, MC_POSITION_TYPE ptPositionType, uint* pdwMinimumPosition, 
                                  uint* pdwCurrentPosition, uint* pdwMaximumPosition);

@DllImport("dxva2")
int SetMonitorDisplayAreaSize(HANDLE hMonitor, MC_SIZE_TYPE stSizeType, uint dwNewDisplayAreaWidthOrHeight);

@DllImport("dxva2")
int SetMonitorDisplayAreaPosition(HANDLE hMonitor, MC_POSITION_TYPE ptPositionType, uint dwNewPosition);

@DllImport("dxva2")
int RestoreMonitorFactoryColorDefaults(HANDLE hMonitor);

@DllImport("dxva2")
int RestoreMonitorFactoryDefaults(HANDLE hMonitor);


