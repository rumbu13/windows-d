module windows.power;

public import windows.core;
public import windows.windowsprogramming : HKEY;

extern(Windows):


// Functions

@DllImport("api-ms-win-power-setting-l1-1-0")
uint PowerWriteACValueIndex(HKEY RootPowerKey, const(GUID)* SchemeGuid, const(GUID)* SubGroupOfPowerSettingsGuid, 
                            const(GUID)* PowerSettingGuid, uint AcValueIndex);

@DllImport("api-ms-win-power-setting-l1-1-0")
uint PowerWriteDCValueIndex(HKEY RootPowerKey, const(GUID)* SchemeGuid, const(GUID)* SubGroupOfPowerSettingsGuid, 
                            const(GUID)* PowerSettingGuid, uint DcValueIndex);

@DllImport("POWRPROF")
uint PowerReadACValueIndex(HKEY RootPowerKey, const(GUID)* SchemeGuid, const(GUID)* SubGroupOfPowerSettingsGuid, 
                           const(GUID)* PowerSettingGuid, uint* AcValueIndex);

@DllImport("POWRPROF")
uint PowerReadDCValueIndex(HKEY RootPowerKey, const(GUID)* SchemeGuid, const(GUID)* SubGroupOfPowerSettingsGuid, 
                           const(GUID)* PowerSettingGuid, uint* DcValueIndex);

@DllImport("POWRPROF")
uint PowerReadACDefaultIndex(HKEY RootPowerKey, const(GUID)* SchemePersonalityGuid, 
                             const(GUID)* SubGroupOfPowerSettingsGuid, const(GUID)* PowerSettingGuid, 
                             uint* AcDefaultIndex);

@DllImport("POWRPROF")
uint PowerReadDCDefaultIndex(HKEY RootPowerKey, const(GUID)* SchemePersonalityGuid, 
                             const(GUID)* SubGroupOfPowerSettingsGuid, const(GUID)* PowerSettingGuid, 
                             uint* DcDefaultIndex);

@DllImport("POWRPROF")
uint PowerWriteACDefaultIndex(HKEY RootSystemPowerKey, const(GUID)* SchemePersonalityGuid, 
                              const(GUID)* SubGroupOfPowerSettingsGuid, const(GUID)* PowerSettingGuid, 
                              uint DefaultAcIndex);

@DllImport("POWRPROF")
uint PowerWriteDCDefaultIndex(HKEY RootSystemPowerKey, const(GUID)* SchemePersonalityGuid, 
                              const(GUID)* SubGroupOfPowerSettingsGuid, const(GUID)* PowerSettingGuid, 
                              uint DefaultDcIndex);


