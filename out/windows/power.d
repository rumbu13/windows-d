module windows.power;

public import system;
public import windows.windowsprogramming;

extern(Windows):

@DllImport("api-ms-win-power-setting-l1-1-0.dll")
uint PowerWriteACValueIndex(HKEY RootPowerKey, const(Guid)* SchemeGuid, const(Guid)* SubGroupOfPowerSettingsGuid, const(Guid)* PowerSettingGuid, uint AcValueIndex);

@DllImport("api-ms-win-power-setting-l1-1-0.dll")
uint PowerWriteDCValueIndex(HKEY RootPowerKey, const(Guid)* SchemeGuid, const(Guid)* SubGroupOfPowerSettingsGuid, const(Guid)* PowerSettingGuid, uint DcValueIndex);

@DllImport("POWRPROF.dll")
uint PowerReadACValueIndex(HKEY RootPowerKey, const(Guid)* SchemeGuid, const(Guid)* SubGroupOfPowerSettingsGuid, const(Guid)* PowerSettingGuid, uint* AcValueIndex);

@DllImport("POWRPROF.dll")
uint PowerReadDCValueIndex(HKEY RootPowerKey, const(Guid)* SchemeGuid, const(Guid)* SubGroupOfPowerSettingsGuid, const(Guid)* PowerSettingGuid, uint* DcValueIndex);

@DllImport("POWRPROF.dll")
uint PowerReadACDefaultIndex(HKEY RootPowerKey, const(Guid)* SchemePersonalityGuid, const(Guid)* SubGroupOfPowerSettingsGuid, const(Guid)* PowerSettingGuid, uint* AcDefaultIndex);

@DllImport("POWRPROF.dll")
uint PowerReadDCDefaultIndex(HKEY RootPowerKey, const(Guid)* SchemePersonalityGuid, const(Guid)* SubGroupOfPowerSettingsGuid, const(Guid)* PowerSettingGuid, uint* DcDefaultIndex);

@DllImport("POWRPROF.dll")
uint PowerWriteACDefaultIndex(HKEY RootSystemPowerKey, const(Guid)* SchemePersonalityGuid, const(Guid)* SubGroupOfPowerSettingsGuid, const(Guid)* PowerSettingGuid, uint DefaultAcIndex);

@DllImport("POWRPROF.dll")
uint PowerWriteDCDefaultIndex(HKEY RootSystemPowerKey, const(Guid)* SchemePersonalityGuid, const(Guid)* SubGroupOfPowerSettingsGuid, const(Guid)* PowerSettingGuid, uint DefaultDcIndex);

