module windows.monitor;

public import windows.com;
public import windows.direct2d;
public import windows.systemservices;

extern(Windows):

struct PHYSICAL_MONITOR
{
    HANDLE hPhysicalMonitor;
    ushort szPhysicalMonitorDescription;
}

struct MC_TIMING_REPORT
{
    uint dwHorizontalFrequencyInHZ;
    uint dwVerticalFrequencyInHZ;
    ubyte bTimingStatusByte;
}

enum MC_VCP_CODE_TYPE
{
    MC_MOMENTARY = 0,
    MC_SET_PARAMETER = 1,
}

enum MC_DISPLAY_TECHNOLOGY_TYPE
{
    MC_SHADOW_MASK_CATHODE_RAY_TUBE = 0,
    MC_APERTURE_GRILL_CATHODE_RAY_TUBE = 1,
    MC_THIN_FILM_TRANSISTOR = 2,
    MC_LIQUID_CRYSTAL_ON_SILICON = 3,
    MC_PLASMA = 4,
    MC_ORGANIC_LIGHT_EMITTING_DIODE = 5,
    MC_ELECTROLUMINESCENT = 6,
    MC_MICROELECTROMECHANICAL = 7,
    MC_FIELD_EMISSION_DEVICE = 8,
}

enum MC_DRIVE_TYPE
{
    MC_RED_DRIVE = 0,
    MC_GREEN_DRIVE = 1,
    MC_BLUE_DRIVE = 2,
}

enum MC_GAIN_TYPE
{
    MC_RED_GAIN = 0,
    MC_GREEN_GAIN = 1,
    MC_BLUE_GAIN = 2,
}

enum MC_POSITION_TYPE
{
    MC_HORIZONTAL_POSITION = 0,
    MC_VERTICAL_POSITION = 1,
}

enum MC_SIZE_TYPE
{
    MC_WIDTH = 0,
    MC_HEIGHT = 1,
}

enum MC_COLOR_TEMPERATURE
{
    MC_COLOR_TEMPERATURE_UNKNOWN = 0,
    MC_COLOR_TEMPERATURE_4000K = 1,
    MC_COLOR_TEMPERATURE_5000K = 2,
    MC_COLOR_TEMPERATURE_6500K = 3,
    MC_COLOR_TEMPERATURE_7500K = 4,
    MC_COLOR_TEMPERATURE_8200K = 5,
    MC_COLOR_TEMPERATURE_9300K = 6,
    MC_COLOR_TEMPERATURE_10000K = 7,
    MC_COLOR_TEMPERATURE_11500K = 8,
}

@DllImport("dxva2.dll")
int GetNumberOfPhysicalMonitorsFromHMONITOR(int hMonitor, uint* pdwNumberOfPhysicalMonitors);

@DllImport("dxva2.dll")
HRESULT GetNumberOfPhysicalMonitorsFromIDirect3DDevice9(IDirect3DDevice9 pDirect3DDevice9, uint* pdwNumberOfPhysicalMonitors);

@DllImport("dxva2.dll")
int GetPhysicalMonitorsFromHMONITOR(int hMonitor, uint dwPhysicalMonitorArraySize, char* pPhysicalMonitorArray);

@DllImport("dxva2.dll")
HRESULT GetPhysicalMonitorsFromIDirect3DDevice9(IDirect3DDevice9 pDirect3DDevice9, uint dwPhysicalMonitorArraySize, char* pPhysicalMonitorArray);

@DllImport("dxva2.dll")
int DestroyPhysicalMonitor(HANDLE hMonitor);

@DllImport("dxva2.dll")
int DestroyPhysicalMonitors(uint dwPhysicalMonitorArraySize, char* pPhysicalMonitorArray);

@DllImport("dxva2.dll")
int GetVCPFeatureAndVCPFeatureReply(HANDLE hMonitor, ubyte bVCPCode, MC_VCP_CODE_TYPE* pvct, uint* pdwCurrentValue, uint* pdwMaximumValue);

@DllImport("dxva2.dll")
int SetVCPFeature(HANDLE hMonitor, ubyte bVCPCode, uint dwNewValue);

@DllImport("dxva2.dll")
int SaveCurrentSettings(HANDLE hMonitor);

@DllImport("dxva2.dll")
int GetCapabilitiesStringLength(HANDLE hMonitor, uint* pdwCapabilitiesStringLengthInCharacters);

@DllImport("dxva2.dll")
int CapabilitiesRequestAndCapabilitiesReply(HANDLE hMonitor, const(char)* pszASCIICapabilitiesString, uint dwCapabilitiesStringLengthInCharacters);

@DllImport("dxva2.dll")
int GetTimingReport(HANDLE hMonitor, MC_TIMING_REPORT* pmtrMonitorTimingReport);

@DllImport("dxva2.dll")
int GetMonitorCapabilities(HANDLE hMonitor, uint* pdwMonitorCapabilities, uint* pdwSupportedColorTemperatures);

@DllImport("dxva2.dll")
int SaveCurrentMonitorSettings(HANDLE hMonitor);

@DllImport("dxva2.dll")
int GetMonitorTechnologyType(HANDLE hMonitor, MC_DISPLAY_TECHNOLOGY_TYPE* pdtyDisplayTechnologyType);

@DllImport("dxva2.dll")
int GetMonitorBrightness(HANDLE hMonitor, uint* pdwMinimumBrightness, uint* pdwCurrentBrightness, uint* pdwMaximumBrightness);

@DllImport("dxva2.dll")
int GetMonitorContrast(HANDLE hMonitor, uint* pdwMinimumContrast, uint* pdwCurrentContrast, uint* pdwMaximumContrast);

@DllImport("dxva2.dll")
int GetMonitorColorTemperature(HANDLE hMonitor, MC_COLOR_TEMPERATURE* pctCurrentColorTemperature);

@DllImport("dxva2.dll")
int GetMonitorRedGreenOrBlueDrive(HANDLE hMonitor, MC_DRIVE_TYPE dtDriveType, uint* pdwMinimumDrive, uint* pdwCurrentDrive, uint* pdwMaximumDrive);

@DllImport("dxva2.dll")
int GetMonitorRedGreenOrBlueGain(HANDLE hMonitor, MC_GAIN_TYPE gtGainType, uint* pdwMinimumGain, uint* pdwCurrentGain, uint* pdwMaximumGain);

@DllImport("dxva2.dll")
int SetMonitorBrightness(HANDLE hMonitor, uint dwNewBrightness);

@DllImport("dxva2.dll")
int SetMonitorContrast(HANDLE hMonitor, uint dwNewContrast);

@DllImport("dxva2.dll")
int SetMonitorColorTemperature(HANDLE hMonitor, MC_COLOR_TEMPERATURE ctCurrentColorTemperature);

@DllImport("dxva2.dll")
int SetMonitorRedGreenOrBlueDrive(HANDLE hMonitor, MC_DRIVE_TYPE dtDriveType, uint dwNewDrive);

@DllImport("dxva2.dll")
int SetMonitorRedGreenOrBlueGain(HANDLE hMonitor, MC_GAIN_TYPE gtGainType, uint dwNewGain);

@DllImport("dxva2.dll")
int DegaussMonitor(HANDLE hMonitor);

@DllImport("dxva2.dll")
int GetMonitorDisplayAreaSize(HANDLE hMonitor, MC_SIZE_TYPE stSizeType, uint* pdwMinimumWidthOrHeight, uint* pdwCurrentWidthOrHeight, uint* pdwMaximumWidthOrHeight);

@DllImport("dxva2.dll")
int GetMonitorDisplayAreaPosition(HANDLE hMonitor, MC_POSITION_TYPE ptPositionType, uint* pdwMinimumPosition, uint* pdwCurrentPosition, uint* pdwMaximumPosition);

@DllImport("dxva2.dll")
int SetMonitorDisplayAreaSize(HANDLE hMonitor, MC_SIZE_TYPE stSizeType, uint dwNewDisplayAreaWidthOrHeight);

@DllImport("dxva2.dll")
int SetMonitorDisplayAreaPosition(HANDLE hMonitor, MC_POSITION_TYPE ptPositionType, uint dwNewPosition);

@DllImport("dxva2.dll")
int RestoreMonitorFactoryColorDefaults(HANDLE hMonitor);

@DllImport("dxva2.dll")
int RestoreMonitorFactoryDefaults(HANDLE hMonitor);

