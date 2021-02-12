module windows.intl;

public import system;
public import windows.automation;
public import windows.com;
public import windows.displaydevices;
public import windows.gdi;
public import windows.shell;
public import windows.systemservices;
public import windows.windowsandmessaging;
public import windows.windowsprogramming;

extern(Windows):

struct FONTSIGNATURE
{
    uint fsUsb;
    uint fsCsb;
}

struct CHARSETINFO
{
    uint ciCharset;
    uint ciACP;
    FONTSIGNATURE fs;
}

struct LOCALESIGNATURE
{
    uint lsUsb;
    uint lsCsbDefault;
    uint lsCsbSupported;
}

@DllImport("GDI32.dll")
int GetTextCharset(HDC hdc);

@DllImport("GDI32.dll")
int GetTextCharsetInfo(HDC hdc, FONTSIGNATURE* lpSig, uint dwFlags);

@DllImport("GDI32.dll")
BOOL TranslateCharsetInfo(uint* lpSrc, CHARSETINFO* lpCs, uint dwFlags);

@DllImport("KERNEL32.dll")
int GetDateFormatA(uint Locale, uint dwFlags, const(SYSTEMTIME)* lpDate, const(char)* lpFormat, const(char)* lpDateStr, int cchDate);

@DllImport("KERNEL32.dll")
int GetDateFormatW(uint Locale, uint dwFlags, const(SYSTEMTIME)* lpDate, const(wchar)* lpFormat, const(wchar)* lpDateStr, int cchDate);

@DllImport("KERNEL32.dll")
int GetTimeFormatA(uint Locale, uint dwFlags, const(SYSTEMTIME)* lpTime, const(char)* lpFormat, const(char)* lpTimeStr, int cchTime);

@DllImport("KERNEL32.dll")
int GetTimeFormatW(uint Locale, uint dwFlags, const(SYSTEMTIME)* lpTime, const(wchar)* lpFormat, const(wchar)* lpTimeStr, int cchTime);

@DllImport("KERNEL32.dll")
int GetTimeFormatEx(const(wchar)* lpLocaleName, uint dwFlags, const(SYSTEMTIME)* lpTime, const(wchar)* lpFormat, const(wchar)* lpTimeStr, int cchTime);

@DllImport("KERNEL32.dll")
int GetDateFormatEx(const(wchar)* lpLocaleName, uint dwFlags, const(SYSTEMTIME)* lpDate, const(wchar)* lpFormat, const(wchar)* lpDateStr, int cchDate, const(wchar)* lpCalendar);

@DllImport("KERNEL32.dll")
int GetDurationFormatEx(const(wchar)* lpLocaleName, uint dwFlags, const(SYSTEMTIME)* lpDuration, ulong ullDuration, const(wchar)* lpFormat, const(wchar)* lpDurationStr, int cchDuration);

@DllImport("KERNEL32.dll")
int CompareStringEx(const(wchar)* lpLocaleName, uint dwCmpFlags, const(wchar)* lpString1, int cchCount1, const(wchar)* lpString2, int cchCount2, NLSVERSIONINFO* lpVersionInformation, void* lpReserved, LPARAM lParam);

@DllImport("KERNEL32.dll")
int CompareStringOrdinal(const(wchar)* lpString1, int cchCount1, const(wchar)* lpString2, int cchCount2, BOOL bIgnoreCase);

@DllImport("KERNEL32.dll")
int CompareStringW(uint Locale, uint dwCmpFlags, char* lpString1, int cchCount1, char* lpString2, int cchCount2);

@DllImport("KERNEL32.dll")
int FoldStringW(uint dwMapFlags, const(wchar)* lpSrcStr, int cchSrc, const(wchar)* lpDestStr, int cchDest);

@DllImport("KERNEL32.dll")
BOOL GetStringTypeExW(uint Locale, uint dwInfoType, const(wchar)* lpSrcStr, int cchSrc, char* lpCharType);

@DllImport("KERNEL32.dll")
BOOL GetStringTypeW(uint dwInfoType, const(wchar)* lpSrcStr, int cchSrc, ushort* lpCharType);

@DllImport("KERNEL32.dll")
int MultiByteToWideChar(uint CodePage, uint dwFlags, const(char)* lpMultiByteStr, int cbMultiByte, const(wchar)* lpWideCharStr, int cchWideChar);

@DllImport("KERNEL32.dll")
int WideCharToMultiByte(uint CodePage, uint dwFlags, const(wchar)* lpWideCharStr, int cchWideChar, const(char)* lpMultiByteStr, int cbMultiByte, const(char)* lpDefaultChar, int* lpUsedDefaultChar);

@DllImport("KERNEL32.dll")
BOOL IsValidCodePage(uint CodePage);

@DllImport("KERNEL32.dll")
uint GetACP();

@DllImport("KERNEL32.dll")
uint GetOEMCP();

@DllImport("KERNEL32.dll")
BOOL GetCPInfo(uint CodePage, CPINFO* lpCPInfo);

@DllImport("KERNEL32.dll")
BOOL GetCPInfoExA(uint CodePage, uint dwFlags, CPINFOEXA* lpCPInfoEx);

@DllImport("KERNEL32.dll")
BOOL GetCPInfoExW(uint CodePage, uint dwFlags, CPINFOEXW* lpCPInfoEx);

@DllImport("KERNEL32.dll")
int CompareStringA(uint Locale, uint dwCmpFlags, char* lpString1, int cchCount1, char* lpString2, int cchCount2);

@DllImport("KERNEL32.dll")
int FindNLSString(uint Locale, uint dwFindNLSStringFlags, const(wchar)* lpStringSource, int cchSource, const(wchar)* lpStringValue, int cchValue, int* pcchFound);

@DllImport("KERNEL32.dll")
int LCMapStringW(uint Locale, uint dwMapFlags, const(wchar)* lpSrcStr, int cchSrc, const(wchar)* lpDestStr, int cchDest);

@DllImport("KERNEL32.dll")
int LCMapStringA(uint Locale, uint dwMapFlags, const(char)* lpSrcStr, int cchSrc, const(char)* lpDestStr, int cchDest);

@DllImport("KERNEL32.dll")
int GetLocaleInfoW(uint Locale, uint LCType, const(wchar)* lpLCData, int cchData);

@DllImport("KERNEL32.dll")
int GetLocaleInfoA(uint Locale, uint LCType, const(char)* lpLCData, int cchData);

@DllImport("KERNEL32.dll")
BOOL SetLocaleInfoA(uint Locale, uint LCType, const(char)* lpLCData);

@DllImport("KERNEL32.dll")
BOOL SetLocaleInfoW(uint Locale, uint LCType, const(wchar)* lpLCData);

@DllImport("KERNEL32.dll")
int GetCalendarInfoA(uint Locale, uint Calendar, uint CalType, const(char)* lpCalData, int cchData, uint* lpValue);

@DllImport("KERNEL32.dll")
int GetCalendarInfoW(uint Locale, uint Calendar, uint CalType, const(wchar)* lpCalData, int cchData, uint* lpValue);

@DllImport("KERNEL32.dll")
BOOL SetCalendarInfoA(uint Locale, uint Calendar, uint CalType, const(char)* lpCalData);

@DllImport("KERNEL32.dll")
BOOL SetCalendarInfoW(uint Locale, uint Calendar, uint CalType, const(wchar)* lpCalData);

@DllImport("KERNEL32.dll")
BOOL IsDBCSLeadByte(ubyte TestChar);

@DllImport("KERNEL32.dll")
BOOL IsDBCSLeadByteEx(uint CodePage, ubyte TestChar);

@DllImport("KERNEL32.dll")
uint LocaleNameToLCID(const(wchar)* lpName, uint dwFlags);

@DllImport("KERNEL32.dll")
int LCIDToLocaleName(uint Locale, const(wchar)* lpName, int cchName, uint dwFlags);

@DllImport("KERNEL32.dll")
int GetDurationFormat(uint Locale, uint dwFlags, const(SYSTEMTIME)* lpDuration, ulong ullDuration, const(wchar)* lpFormat, const(wchar)* lpDurationStr, int cchDuration);

@DllImport("KERNEL32.dll")
int GetNumberFormatA(uint Locale, uint dwFlags, const(char)* lpValue, const(NUMBERFMTA)* lpFormat, const(char)* lpNumberStr, int cchNumber);

@DllImport("KERNEL32.dll")
int GetNumberFormatW(uint Locale, uint dwFlags, const(wchar)* lpValue, const(NUMBERFMTW)* lpFormat, const(wchar)* lpNumberStr, int cchNumber);

@DllImport("KERNEL32.dll")
int GetCurrencyFormatA(uint Locale, uint dwFlags, const(char)* lpValue, const(CURRENCYFMTA)* lpFormat, const(char)* lpCurrencyStr, int cchCurrency);

@DllImport("KERNEL32.dll")
int GetCurrencyFormatW(uint Locale, uint dwFlags, const(wchar)* lpValue, const(CURRENCYFMTW)* lpFormat, const(wchar)* lpCurrencyStr, int cchCurrency);

@DllImport("KERNEL32.dll")
BOOL EnumCalendarInfoA(CALINFO_ENUMPROCA lpCalInfoEnumProc, uint Locale, uint Calendar, uint CalType);

@DllImport("KERNEL32.dll")
BOOL EnumCalendarInfoW(CALINFO_ENUMPROCW lpCalInfoEnumProc, uint Locale, uint Calendar, uint CalType);

@DllImport("KERNEL32.dll")
BOOL EnumCalendarInfoExA(CALINFO_ENUMPROCEXA lpCalInfoEnumProcEx, uint Locale, uint Calendar, uint CalType);

@DllImport("KERNEL32.dll")
BOOL EnumCalendarInfoExW(CALINFO_ENUMPROCEXW lpCalInfoEnumProcEx, uint Locale, uint Calendar, uint CalType);

@DllImport("KERNEL32.dll")
BOOL EnumTimeFormatsA(TIMEFMT_ENUMPROCA lpTimeFmtEnumProc, uint Locale, uint dwFlags);

@DllImport("KERNEL32.dll")
BOOL EnumTimeFormatsW(TIMEFMT_ENUMPROCW lpTimeFmtEnumProc, uint Locale, uint dwFlags);

@DllImport("KERNEL32.dll")
BOOL EnumDateFormatsA(DATEFMT_ENUMPROCA lpDateFmtEnumProc, uint Locale, uint dwFlags);

@DllImport("KERNEL32.dll")
BOOL EnumDateFormatsW(DATEFMT_ENUMPROCW lpDateFmtEnumProc, uint Locale, uint dwFlags);

@DllImport("KERNEL32.dll")
BOOL EnumDateFormatsExA(DATEFMT_ENUMPROCEXA lpDateFmtEnumProcEx, uint Locale, uint dwFlags);

@DllImport("KERNEL32.dll")
BOOL EnumDateFormatsExW(DATEFMT_ENUMPROCEXW lpDateFmtEnumProcEx, uint Locale, uint dwFlags);

@DllImport("KERNEL32.dll")
BOOL IsValidLanguageGroup(uint LanguageGroup, uint dwFlags);

@DllImport("KERNEL32.dll")
BOOL GetNLSVersion(uint Function, uint Locale, NLSVERSIONINFO* lpVersionInformation);

@DllImport("KERNEL32.dll")
BOOL IsValidLocale(uint Locale, uint dwFlags);

@DllImport("KERNEL32.dll")
int GetGeoInfoA(int Location, uint GeoType, const(char)* lpGeoData, int cchData, ushort LangId);

@DllImport("KERNEL32.dll")
int GetGeoInfoW(int Location, uint GeoType, const(wchar)* lpGeoData, int cchData, ushort LangId);

@DllImport("KERNEL32.dll")
int GetGeoInfoEx(const(wchar)* location, uint geoType, const(wchar)* geoData, int geoDataCount);

@DllImport("KERNEL32.dll")
BOOL EnumSystemGeoID(uint GeoClass, int ParentGeoId, GEO_ENUMPROC lpGeoEnumProc);

@DllImport("KERNEL32.dll")
BOOL EnumSystemGeoNames(uint geoClass, GEO_ENUMNAMEPROC geoEnumProc, LPARAM data);

@DllImport("KERNEL32.dll")
int GetUserGeoID(uint GeoClass);

@DllImport("KERNEL32.dll")
int GetUserDefaultGeoName(const(wchar)* geoName, int geoNameCount);

@DllImport("KERNEL32.dll")
BOOL SetUserGeoID(int GeoId);

@DllImport("KERNEL32.dll")
BOOL SetUserGeoName(const(wchar)* geoName);

@DllImport("KERNEL32.dll")
uint ConvertDefaultLocale(uint Locale);

@DllImport("KERNEL32.dll")
ushort GetSystemDefaultUILanguage();

@DllImport("KERNEL32.dll")
uint GetThreadLocale();

@DllImport("KERNEL32.dll")
BOOL SetThreadLocale(uint Locale);

@DllImport("KERNEL32.dll")
ushort GetUserDefaultUILanguage();

@DllImport("KERNEL32.dll")
ushort GetUserDefaultLangID();

@DllImport("KERNEL32.dll")
ushort GetSystemDefaultLangID();

@DllImport("KERNEL32.dll")
uint GetSystemDefaultLCID();

@DllImport("KERNEL32.dll")
uint GetUserDefaultLCID();

@DllImport("KERNEL32.dll")
ushort SetThreadUILanguage(ushort LangId);

@DllImport("KERNEL32.dll")
ushort GetThreadUILanguage();

@DllImport("KERNEL32.dll")
BOOL GetProcessPreferredUILanguages(uint dwFlags, uint* pulNumLanguages, const(wchar)* pwszLanguagesBuffer, uint* pcchLanguagesBuffer);

@DllImport("KERNEL32.dll")
BOOL SetProcessPreferredUILanguages(uint dwFlags, const(wchar)* pwszLanguagesBuffer, uint* pulNumLanguages);

@DllImport("KERNEL32.dll")
BOOL GetUserPreferredUILanguages(uint dwFlags, uint* pulNumLanguages, const(wchar)* pwszLanguagesBuffer, uint* pcchLanguagesBuffer);

@DllImport("KERNEL32.dll")
BOOL GetSystemPreferredUILanguages(uint dwFlags, uint* pulNumLanguages, const(wchar)* pwszLanguagesBuffer, uint* pcchLanguagesBuffer);

@DllImport("KERNEL32.dll")
BOOL GetThreadPreferredUILanguages(uint dwFlags, uint* pulNumLanguages, const(wchar)* pwszLanguagesBuffer, uint* pcchLanguagesBuffer);

@DllImport("KERNEL32.dll")
BOOL SetThreadPreferredUILanguages(uint dwFlags, const(wchar)* pwszLanguagesBuffer, uint* pulNumLanguages);

@DllImport("KERNEL32.dll")
BOOL GetFileMUIInfo(uint dwFlags, const(wchar)* pcwszFilePath, char* pFileMUIInfo, uint* pcbFileMUIInfo);

@DllImport("KERNEL32.dll")
BOOL GetFileMUIPath(uint dwFlags, const(wchar)* pcwszFilePath, const(wchar)* pwszLanguage, uint* pcchLanguage, const(wchar)* pwszFileMUIPath, uint* pcchFileMUIPath, ulong* pululEnumerator);

@DllImport("KERNEL32.dll")
BOOL GetUILanguageInfo(uint dwFlags, const(wchar)* pwmszLanguage, const(wchar)* pwszFallbackLanguages, uint* pcchFallbackLanguages, uint* pAttributes);

@DllImport("KERNEL32.dll")
BOOL SetThreadPreferredUILanguages2(uint flags, const(wchar)* languages, uint* numLanguagesSet, HSAVEDUILANGUAGES__** snapshot);

@DllImport("KERNEL32.dll")
void RestoreThreadPreferredUILanguages(const(HSAVEDUILANGUAGES__)* snapshot);

@DllImport("KERNEL32.dll")
BOOL NotifyUILanguageChange(uint dwFlags, const(wchar)* pcwstrNewLanguage, const(wchar)* pcwstrPreviousLanguage, uint dwReserved, uint* pdwStatusRtrn);

@DllImport("KERNEL32.dll")
BOOL GetStringTypeExA(uint Locale, uint dwInfoType, const(char)* lpSrcStr, int cchSrc, char* lpCharType);

@DllImport("KERNEL32.dll")
BOOL GetStringTypeA(uint Locale, uint dwInfoType, const(char)* lpSrcStr, int cchSrc, ushort* lpCharType);

@DllImport("KERNEL32.dll")
int FoldStringA(uint dwMapFlags, const(char)* lpSrcStr, int cchSrc, const(char)* lpDestStr, int cchDest);

@DllImport("KERNEL32.dll")
BOOL EnumSystemLocalesA(LOCALE_ENUMPROCA lpLocaleEnumProc, uint dwFlags);

@DllImport("KERNEL32.dll")
BOOL EnumSystemLocalesW(LOCALE_ENUMPROCW lpLocaleEnumProc, uint dwFlags);

@DllImport("KERNEL32.dll")
BOOL EnumSystemLanguageGroupsA(LANGUAGEGROUP_ENUMPROCA lpLanguageGroupEnumProc, uint dwFlags, int lParam);

@DllImport("KERNEL32.dll")
BOOL EnumSystemLanguageGroupsW(LANGUAGEGROUP_ENUMPROCW lpLanguageGroupEnumProc, uint dwFlags, int lParam);

@DllImport("KERNEL32.dll")
BOOL EnumLanguageGroupLocalesA(LANGGROUPLOCALE_ENUMPROCA lpLangGroupLocaleEnumProc, uint LanguageGroup, uint dwFlags, int lParam);

@DllImport("KERNEL32.dll")
BOOL EnumLanguageGroupLocalesW(LANGGROUPLOCALE_ENUMPROCW lpLangGroupLocaleEnumProc, uint LanguageGroup, uint dwFlags, int lParam);

@DllImport("KERNEL32.dll")
BOOL EnumUILanguagesA(UILANGUAGE_ENUMPROCA lpUILanguageEnumProc, uint dwFlags, int lParam);

@DllImport("KERNEL32.dll")
BOOL EnumUILanguagesW(UILANGUAGE_ENUMPROCW lpUILanguageEnumProc, uint dwFlags, int lParam);

@DllImport("KERNEL32.dll")
BOOL EnumSystemCodePagesA(CODEPAGE_ENUMPROCA lpCodePageEnumProc, uint dwFlags);

@DllImport("KERNEL32.dll")
BOOL EnumSystemCodePagesW(CODEPAGE_ENUMPROCW lpCodePageEnumProc, uint dwFlags);

@DllImport("NORMALIZ.dll")
int IdnToAscii(uint dwFlags, const(wchar)* lpUnicodeCharStr, int cchUnicodeChar, const(wchar)* lpASCIICharStr, int cchASCIIChar);

@DllImport("NORMALIZ.dll")
int IdnToUnicode(uint dwFlags, const(wchar)* lpASCIICharStr, int cchASCIIChar, const(wchar)* lpUnicodeCharStr, int cchUnicodeChar);

@DllImport("KERNEL32.dll")
int IdnToNameprepUnicode(uint dwFlags, const(wchar)* lpUnicodeCharStr, int cchUnicodeChar, const(wchar)* lpNameprepCharStr, int cchNameprepChar);

@DllImport("KERNEL32.dll")
int NormalizeString(NORM_FORM NormForm, const(wchar)* lpSrcString, int cwSrcLength, const(wchar)* lpDstString, int cwDstLength);

@DllImport("KERNEL32.dll")
BOOL IsNormalizedString(NORM_FORM NormForm, const(wchar)* lpString, int cwLength);

@DllImport("KERNEL32.dll")
BOOL VerifyScripts(uint dwFlags, const(wchar)* lpLocaleScripts, int cchLocaleScripts, const(wchar)* lpTestScripts, int cchTestScripts);

@DllImport("KERNEL32.dll")
int GetStringScripts(uint dwFlags, const(wchar)* lpString, int cchString, const(wchar)* lpScripts, int cchScripts);

@DllImport("KERNEL32.dll")
int GetLocaleInfoEx(const(wchar)* lpLocaleName, uint LCType, const(wchar)* lpLCData, int cchData);

@DllImport("KERNEL32.dll")
int GetCalendarInfoEx(const(wchar)* lpLocaleName, uint Calendar, const(wchar)* lpReserved, uint CalType, const(wchar)* lpCalData, int cchData, uint* lpValue);

@DllImport("KERNEL32.dll")
int GetNumberFormatEx(const(wchar)* lpLocaleName, uint dwFlags, const(wchar)* lpValue, const(NUMBERFMTW)* lpFormat, const(wchar)* lpNumberStr, int cchNumber);

@DllImport("KERNEL32.dll")
int GetCurrencyFormatEx(const(wchar)* lpLocaleName, uint dwFlags, const(wchar)* lpValue, const(CURRENCYFMTW)* lpFormat, const(wchar)* lpCurrencyStr, int cchCurrency);

@DllImport("KERNEL32.dll")
int GetUserDefaultLocaleName(const(wchar)* lpLocaleName, int cchLocaleName);

@DllImport("KERNEL32.dll")
int GetSystemDefaultLocaleName(const(wchar)* lpLocaleName, int cchLocaleName);

@DllImport("KERNEL32.dll")
BOOL IsNLSDefinedString(uint Function, uint dwFlags, NLSVERSIONINFO* lpVersionInformation, const(wchar)* lpString, int cchStr);

@DllImport("KERNEL32.dll")
BOOL GetNLSVersionEx(uint function, const(wchar)* lpLocaleName, NLSVERSIONINFOEX* lpVersionInformation);

@DllImport("KERNEL32.dll")
uint IsValidNLSVersion(uint function, const(wchar)* lpLocaleName, NLSVERSIONINFOEX* lpVersionInformation);

@DllImport("KERNEL32.dll")
int FindNLSStringEx(const(wchar)* lpLocaleName, uint dwFindNLSStringFlags, const(wchar)* lpStringSource, int cchSource, const(wchar)* lpStringValue, int cchValue, int* pcchFound, NLSVERSIONINFO* lpVersionInformation, void* lpReserved, LPARAM sortHandle);

@DllImport("KERNEL32.dll")
int LCMapStringEx(const(wchar)* lpLocaleName, uint dwMapFlags, const(wchar)* lpSrcStr, int cchSrc, const(wchar)* lpDestStr, int cchDest, NLSVERSIONINFO* lpVersionInformation, void* lpReserved, LPARAM sortHandle);

@DllImport("KERNEL32.dll")
BOOL IsValidLocaleName(const(wchar)* lpLocaleName);

@DllImport("KERNEL32.dll")
BOOL EnumCalendarInfoExEx(CALINFO_ENUMPROCEXEX pCalInfoEnumProcExEx, const(wchar)* lpLocaleName, uint Calendar, const(wchar)* lpReserved, uint CalType, LPARAM lParam);

@DllImport("KERNEL32.dll")
BOOL EnumDateFormatsExEx(DATEFMT_ENUMPROCEXEX lpDateFmtEnumProcExEx, const(wchar)* lpLocaleName, uint dwFlags, LPARAM lParam);

@DllImport("KERNEL32.dll")
BOOL EnumTimeFormatsEx(TIMEFMT_ENUMPROCEX lpTimeFmtEnumProcEx, const(wchar)* lpLocaleName, uint dwFlags, LPARAM lParam);

@DllImport("KERNEL32.dll")
BOOL EnumSystemLocalesEx(LOCALE_ENUMPROCEX lpLocaleEnumProcEx, uint dwFlags, LPARAM lParam, void* lpReserved);

@DllImport("KERNEL32.dll")
int ResolveLocaleName(const(wchar)* lpNameToResolve, const(wchar)* lpLocaleName, int cchLocaleName);

@DllImport("IMM32.dll")
int ImmInstallIMEA(const(char)* lpszIMEFileName, const(char)* lpszLayoutText);

@DllImport("IMM32.dll")
int ImmInstallIMEW(const(wchar)* lpszIMEFileName, const(wchar)* lpszLayoutText);

@DllImport("IMM32.dll")
HWND ImmGetDefaultIMEWnd(HWND param0);

@DllImport("IMM32.dll")
uint ImmGetDescriptionA(int param0, const(char)* lpszDescription, uint uBufLen);

@DllImport("IMM32.dll")
uint ImmGetDescriptionW(int param0, const(wchar)* lpszDescription, uint uBufLen);

@DllImport("IMM32.dll")
uint ImmGetIMEFileNameA(int param0, const(char)* lpszFileName, uint uBufLen);

@DllImport("IMM32.dll")
uint ImmGetIMEFileNameW(int param0, const(wchar)* lpszFileName, uint uBufLen);

@DllImport("IMM32.dll")
uint ImmGetProperty(int param0, uint param1);

@DllImport("IMM32.dll")
BOOL ImmIsIME(int param0);

@DllImport("IMM32.dll")
BOOL ImmSimulateHotKey(HWND param0, uint param1);

@DllImport("IMM32.dll")
HIMC__* ImmCreateContext();

@DllImport("IMM32.dll")
BOOL ImmDestroyContext(HIMC__* param0);

@DllImport("IMM32.dll")
HIMC__* ImmGetContext(HWND param0);

@DllImport("IMM32.dll")
BOOL ImmReleaseContext(HWND param0, HIMC__* param1);

@DllImport("IMM32.dll")
HIMC__* ImmAssociateContext(HWND param0, HIMC__* param1);

@DllImport("IMM32.dll")
BOOL ImmAssociateContextEx(HWND param0, HIMC__* param1, uint param2);

@DllImport("IMM32.dll")
int ImmGetCompositionStringA(HIMC__* param0, uint param1, char* lpBuf, uint dwBufLen);

@DllImport("IMM32.dll")
int ImmGetCompositionStringW(HIMC__* param0, uint param1, char* lpBuf, uint dwBufLen);

@DllImport("IMM32.dll")
BOOL ImmSetCompositionStringA(HIMC__* param0, uint dwIndex, char* lpComp, uint dwCompLen, char* lpRead, uint dwReadLen);

@DllImport("IMM32.dll")
BOOL ImmSetCompositionStringW(HIMC__* param0, uint dwIndex, char* lpComp, uint dwCompLen, char* lpRead, uint dwReadLen);

@DllImport("IMM32.dll")
uint ImmGetCandidateListCountA(HIMC__* param0, uint* lpdwListCount);

@DllImport("IMM32.dll")
uint ImmGetCandidateListCountW(HIMC__* param0, uint* lpdwListCount);

@DllImport("IMM32.dll")
uint ImmGetCandidateListA(HIMC__* param0, uint deIndex, char* lpCandList, uint dwBufLen);

@DllImport("IMM32.dll")
uint ImmGetCandidateListW(HIMC__* param0, uint deIndex, char* lpCandList, uint dwBufLen);

@DllImport("IMM32.dll")
uint ImmGetGuideLineA(HIMC__* param0, uint dwIndex, const(char)* lpBuf, uint dwBufLen);

@DllImport("IMM32.dll")
uint ImmGetGuideLineW(HIMC__* param0, uint dwIndex, const(wchar)* lpBuf, uint dwBufLen);

@DllImport("IMM32.dll")
BOOL ImmGetConversionStatus(HIMC__* param0, uint* lpfdwConversion, uint* lpfdwSentence);

@DllImport("IMM32.dll")
BOOL ImmSetConversionStatus(HIMC__* param0, uint param1, uint param2);

@DllImport("IMM32.dll")
BOOL ImmGetOpenStatus(HIMC__* param0);

@DllImport("IMM32.dll")
BOOL ImmSetOpenStatus(HIMC__* param0, BOOL param1);

@DllImport("IMM32.dll")
BOOL ImmGetCompositionFontA(HIMC__* param0, LOGFONTA* lplf);

@DllImport("IMM32.dll")
BOOL ImmGetCompositionFontW(HIMC__* param0, LOGFONTW* lplf);

@DllImport("IMM32.dll")
BOOL ImmSetCompositionFontA(HIMC__* param0, LOGFONTA* lplf);

@DllImport("IMM32.dll")
BOOL ImmSetCompositionFontW(HIMC__* param0, LOGFONTW* lplf);

@DllImport("IMM32.dll")
BOOL ImmConfigureIMEA(int param0, HWND param1, uint param2, void* param3);

@DllImport("IMM32.dll")
BOOL ImmConfigureIMEW(int param0, HWND param1, uint param2, void* param3);

@DllImport("IMM32.dll")
LRESULT ImmEscapeA(int param0, HIMC__* param1, uint param2, void* param3);

@DllImport("IMM32.dll")
LRESULT ImmEscapeW(int param0, HIMC__* param1, uint param2, void* param3);

@DllImport("IMM32.dll")
uint ImmGetConversionListA(int param0, HIMC__* param1, const(char)* lpSrc, char* lpDst, uint dwBufLen, uint uFlag);

@DllImport("IMM32.dll")
uint ImmGetConversionListW(int param0, HIMC__* param1, const(wchar)* lpSrc, char* lpDst, uint dwBufLen, uint uFlag);

@DllImport("IMM32.dll")
BOOL ImmNotifyIME(HIMC__* param0, uint dwAction, uint dwIndex, uint dwValue);

@DllImport("IMM32.dll")
BOOL ImmGetStatusWindowPos(HIMC__* param0, POINT* lpptPos);

@DllImport("IMM32.dll")
BOOL ImmSetStatusWindowPos(HIMC__* param0, POINT* lpptPos);

@DllImport("IMM32.dll")
BOOL ImmGetCompositionWindow(HIMC__* param0, COMPOSITIONFORM* lpCompForm);

@DllImport("IMM32.dll")
BOOL ImmSetCompositionWindow(HIMC__* param0, COMPOSITIONFORM* lpCompForm);

@DllImport("IMM32.dll")
BOOL ImmGetCandidateWindow(HIMC__* param0, uint param1, CANDIDATEFORM* lpCandidate);

@DllImport("IMM32.dll")
BOOL ImmSetCandidateWindow(HIMC__* param0, CANDIDATEFORM* lpCandidate);

@DllImport("IMM32.dll")
BOOL ImmIsUIMessageA(HWND param0, uint param1, WPARAM param2, LPARAM param3);

@DllImport("IMM32.dll")
BOOL ImmIsUIMessageW(HWND param0, uint param1, WPARAM param2, LPARAM param3);

@DllImport("IMM32.dll")
uint ImmGetVirtualKey(HWND param0);

@DllImport("IMM32.dll")
BOOL ImmRegisterWordA(int param0, const(char)* lpszReading, uint param2, const(char)* lpszRegister);

@DllImport("IMM32.dll")
BOOL ImmRegisterWordW(int param0, const(wchar)* lpszReading, uint param2, const(wchar)* lpszRegister);

@DllImport("IMM32.dll")
BOOL ImmUnregisterWordA(int param0, const(char)* lpszReading, uint param2, const(char)* lpszUnregister);

@DllImport("IMM32.dll")
BOOL ImmUnregisterWordW(int param0, const(wchar)* lpszReading, uint param2, const(wchar)* lpszUnregister);

@DllImport("IMM32.dll")
uint ImmGetRegisterWordStyleA(int param0, uint nItem, char* lpStyleBuf);

@DllImport("IMM32.dll")
uint ImmGetRegisterWordStyleW(int param0, uint nItem, char* lpStyleBuf);

@DllImport("IMM32.dll")
uint ImmEnumRegisterWordA(int param0, REGISTERWORDENUMPROCA param1, const(char)* lpszReading, uint param3, const(char)* lpszRegister, void* param5);

@DllImport("IMM32.dll")
uint ImmEnumRegisterWordW(int param0, REGISTERWORDENUMPROCW param1, const(wchar)* lpszReading, uint param3, const(wchar)* lpszRegister, void* param5);

@DllImport("IMM32.dll")
BOOL ImmDisableIME(uint param0);

@DllImport("IMM32.dll")
BOOL ImmEnumInputContext(uint idThread, IMCENUMPROC lpfn, LPARAM lParam);

@DllImport("IMM32.dll")
uint ImmGetImeMenuItemsA(HIMC__* param0, uint param1, uint param2, IMEMENUITEMINFOA* lpImeParentMenu, char* lpImeMenu, uint dwSize);

@DllImport("IMM32.dll")
uint ImmGetImeMenuItemsW(HIMC__* param0, uint param1, uint param2, IMEMENUITEMINFOW* lpImeParentMenu, char* lpImeMenu, uint dwSize);

@DllImport("IMM32.dll")
BOOL ImmDisableTextFrameService(uint idThread);

@DllImport("IMM32.dll")
BOOL ImmDisableLegacyIME();

@DllImport("elscore.dll")
HRESULT MappingGetServices(MAPPING_ENUM_OPTIONS* pOptions, MAPPING_SERVICE_INFO** prgServices, uint* pdwServicesCount);

@DllImport("elscore.dll")
HRESULT MappingFreeServices(MAPPING_SERVICE_INFO* pServiceInfo);

@DllImport("elscore.dll")
HRESULT MappingRecognizeText(MAPPING_SERVICE_INFO* pServiceInfo, const(wchar)* pszText, uint dwLength, uint dwIndex, MAPPING_OPTIONS* pOptions, MAPPING_PROPERTY_BAG* pbag);

@DllImport("elscore.dll")
HRESULT MappingDoAction(MAPPING_PROPERTY_BAG* pBag, uint dwRangeIndex, const(wchar)* pszActionId);

@DllImport("elscore.dll")
HRESULT MappingFreePropertyBag(MAPPING_PROPERTY_BAG* pBag);

@DllImport("IMM32.dll")
BOOL ImmGetHotKey(uint param0, uint* lpuModifiers, uint* lpuVKey, int* phKL);

@DllImport("IMM32.dll")
BOOL ImmSetHotKey(uint param0, uint param1, uint param2, int param3);

@DllImport("IMM32.dll")
BOOL ImmGenerateMessage(HIMC__* param0);

@DllImport("IMM32.dll")
LRESULT ImmRequestMessageA(HIMC__* param0, WPARAM param1, LPARAM param2);

@DllImport("IMM32.dll")
LRESULT ImmRequestMessageW(HIMC__* param0, WPARAM param1, LPARAM param2);

@DllImport("IMM32.dll")
HWND ImmCreateSoftKeyboard(uint param0, HWND param1, int param2, int param3);

@DllImport("IMM32.dll")
BOOL ImmDestroySoftKeyboard(HWND param0);

@DllImport("IMM32.dll")
BOOL ImmShowSoftKeyboard(HWND param0, int param1);

@DllImport("IMM32.dll")
INPUTCONTEXT* ImmLockIMC(HIMC__* param0);

@DllImport("IMM32.dll")
BOOL ImmUnlockIMC(HIMC__* param0);

@DllImport("IMM32.dll")
uint ImmGetIMCLockCount(HIMC__* param0);

@DllImport("IMM32.dll")
HIMCC__* ImmCreateIMCC(uint param0);

@DllImport("IMM32.dll")
HIMCC__* ImmDestroyIMCC(HIMCC__* param0);

@DllImport("IMM32.dll")
void* ImmLockIMCC(HIMCC__* param0);

@DllImport("IMM32.dll")
BOOL ImmUnlockIMCC(HIMCC__* param0);

@DllImport("IMM32.dll")
uint ImmGetIMCCLockCount(HIMCC__* param0);

@DllImport("IMM32.dll")
HIMCC__* ImmReSizeIMCC(HIMCC__* param0, uint param1);

@DllImport("IMM32.dll")
uint ImmGetIMCCSize(HIMCC__* param0);

@DllImport("USP10.dll")
HRESULT ScriptFreeCache(void** psc);

@DllImport("USP10.dll")
HRESULT ScriptItemize(const(wchar)* pwcInChars, int cInChars, int cMaxItems, const(SCRIPT_CONTROL)* psControl, const(SCRIPT_STATE)* psState, char* pItems, int* pcItems);

@DllImport("USP10.dll")
HRESULT ScriptLayout(int cRuns, char* pbLevel, char* piVisualToLogical, char* piLogicalToVisual);

@DllImport("USP10.dll")
HRESULT ScriptShape(HDC hdc, void** psc, const(wchar)* pwcChars, int cChars, int cMaxGlyphs, SCRIPT_ANALYSIS* psa, char* pwOutGlyphs, char* pwLogClust, char* psva, int* pcGlyphs);

@DllImport("USP10.dll")
HRESULT ScriptPlace(HDC hdc, void** psc, char* pwGlyphs, int cGlyphs, char* psva, SCRIPT_ANALYSIS* psa, char* piAdvance, char* pGoffset, ABC* pABC);

@DllImport("USP10.dll")
HRESULT ScriptTextOut(const(int) hdc, void** psc, int x, int y, uint fuOptions, const(RECT)* lprc, const(SCRIPT_ANALYSIS)* psa, const(wchar)* pwcReserved, int iReserved, char* pwGlyphs, int cGlyphs, char* piAdvance, char* piJustify, char* pGoffset);

@DllImport("USP10.dll")
HRESULT ScriptJustify(char* psva, char* piAdvance, int cGlyphs, int iDx, int iMinKashida, char* piJustify);

@DllImport("USP10.dll")
HRESULT ScriptBreak(const(wchar)* pwcChars, int cChars, const(SCRIPT_ANALYSIS)* psa, char* psla);

@DllImport("USP10.dll")
HRESULT ScriptCPtoX(int iCP, BOOL fTrailing, int cChars, int cGlyphs, char* pwLogClust, char* psva, char* piAdvance, const(SCRIPT_ANALYSIS)* psa, int* piX);

@DllImport("USP10.dll")
HRESULT ScriptXtoCP(int iX, int cChars, int cGlyphs, char* pwLogClust, char* psva, char* piAdvance, const(SCRIPT_ANALYSIS)* psa, int* piCP, int* piTrailing);

@DllImport("USP10.dll")
HRESULT ScriptGetLogicalWidths(const(SCRIPT_ANALYSIS)* psa, int cChars, int cGlyphs, char* piGlyphWidth, char* pwLogClust, char* psva, char* piDx);

@DllImport("USP10.dll")
HRESULT ScriptApplyLogicalWidth(char* piDx, int cChars, int cGlyphs, char* pwLogClust, char* psva, char* piAdvance, const(SCRIPT_ANALYSIS)* psa, ABC* pABC, char* piJustify);

@DllImport("USP10.dll")
HRESULT ScriptGetCMap(HDC hdc, void** psc, const(wchar)* pwcInChars, int cChars, uint dwFlags, char* pwOutGlyphs);

@DllImport("USP10.dll")
HRESULT ScriptGetGlyphABCWidth(HDC hdc, void** psc, ushort wGlyph, ABC* pABC);

@DllImport("USP10.dll")
HRESULT ScriptGetProperties(const(SCRIPT_PROPERTIES)*** ppSp, int* piNumScripts);

@DllImport("USP10.dll")
HRESULT ScriptGetFontProperties(HDC hdc, void** psc, SCRIPT_FONTPROPERTIES* sfp);

@DllImport("USP10.dll")
HRESULT ScriptCacheGetHeight(HDC hdc, void** psc, int* tmHeight);

@DllImport("USP10.dll")
HRESULT ScriptStringAnalyse(HDC hdc, const(void)* pString, int cString, int cGlyphs, int iCharset, uint dwFlags, int iReqWidth, SCRIPT_CONTROL* psControl, SCRIPT_STATE* psState, char* piDx, SCRIPT_TABDEF* pTabdef, const(ubyte)* pbInClass, void** pssa);

@DllImport("USP10.dll")
HRESULT ScriptStringFree(void** pssa);

@DllImport("USP10.dll")
SIZE* ScriptString_pSize(void* ssa);

@DllImport("USP10.dll")
int* ScriptString_pcOutChars(void* ssa);

@DllImport("USP10.dll")
SCRIPT_LOGATTR* ScriptString_pLogAttr(void* ssa);

@DllImport("USP10.dll")
HRESULT ScriptStringGetOrder(void* ssa, uint* puOrder);

@DllImport("USP10.dll")
HRESULT ScriptStringCPtoX(void* ssa, int icp, BOOL fTrailing, int* pX);

@DllImport("USP10.dll")
HRESULT ScriptStringXtoCP(void* ssa, int iX, int* piCh, int* piTrailing);

@DllImport("USP10.dll")
HRESULT ScriptStringGetLogicalWidths(void* ssa, int* piDx);

@DllImport("USP10.dll")
HRESULT ScriptStringValidate(void* ssa);

@DllImport("USP10.dll")
HRESULT ScriptStringOut(void* ssa, int iX, int iY, uint uOptions, const(RECT)* prc, int iMinSel, int iMaxSel, BOOL fDisabled);

@DllImport("USP10.dll")
HRESULT ScriptIsComplex(const(wchar)* pwcInChars, int cInChars, uint dwFlags);

@DllImport("USP10.dll")
HRESULT ScriptRecordDigitSubstitution(uint Locale, SCRIPT_DIGITSUBSTITUTE* psds);

@DllImport("USP10.dll")
HRESULT ScriptApplyDigitSubstitution(const(SCRIPT_DIGITSUBSTITUTE)* psds, SCRIPT_CONTROL* psc, SCRIPT_STATE* pss);

@DllImport("USP10.dll")
HRESULT ScriptShapeOpenType(HDC hdc, void** psc, SCRIPT_ANALYSIS* psa, uint tagScript, uint tagLangSys, char* rcRangeChars, char* rpRangeProperties, int cRanges, const(wchar)* pwcChars, int cChars, int cMaxGlyphs, char* pwLogClust, char* pCharProps, char* pwOutGlyphs, char* pOutGlyphProps, int* pcGlyphs);

@DllImport("USP10.dll")
HRESULT ScriptPlaceOpenType(HDC hdc, void** psc, SCRIPT_ANALYSIS* psa, uint tagScript, uint tagLangSys, char* rcRangeChars, char* rpRangeProperties, int cRanges, const(wchar)* pwcChars, char* pwLogClust, char* pCharProps, int cChars, char* pwGlyphs, char* pGlyphProps, int cGlyphs, char* piAdvance, char* pGoffset, ABC* pABC);

@DllImport("USP10.dll")
HRESULT ScriptItemizeOpenType(const(wchar)* pwcInChars, int cInChars, int cMaxItems, const(SCRIPT_CONTROL)* psControl, const(SCRIPT_STATE)* psState, char* pItems, char* pScriptTags, int* pcItems);

@DllImport("USP10.dll")
HRESULT ScriptGetFontScriptTags(HDC hdc, void** psc, SCRIPT_ANALYSIS* psa, int cMaxTags, char* pScriptTags, int* pcTags);

@DllImport("USP10.dll")
HRESULT ScriptGetFontLanguageTags(HDC hdc, void** psc, SCRIPT_ANALYSIS* psa, uint tagScript, int cMaxTags, char* pLangsysTags, int* pcTags);

@DllImport("USP10.dll")
HRESULT ScriptGetFontFeatureTags(HDC hdc, void** psc, SCRIPT_ANALYSIS* psa, uint tagScript, uint tagLangSys, int cMaxTags, char* pFeatureTags, int* pcTags);

@DllImport("USP10.dll")
HRESULT ScriptGetFontAlternateGlyphs(HDC hdc, void** psc, SCRIPT_ANALYSIS* psa, uint tagScript, uint tagLangSys, uint tagFeature, ushort wGlyphId, int cMaxAlternates, char* pAlternateGlyphs, int* pcAlternates);

@DllImport("USP10.dll")
HRESULT ScriptSubstituteSingleGlyph(HDC hdc, void** psc, SCRIPT_ANALYSIS* psa, uint tagScript, uint tagLangSys, uint tagFeature, int lParameter, ushort wGlyphId, ushort* pwOutGlyphId);

@DllImport("USP10.dll")
HRESULT ScriptPositionSingleGlyph(HDC hdc, void** psc, SCRIPT_ANALYSIS* psa, uint tagScript, uint tagLangSys, uint tagFeature, int lParameter, ushort wGlyphId, int iAdvance, GOFFSET GOffset, int* piOutAdvance, GOFFSET* pOutGoffset);

@DllImport("icu.dll")
int utf8_nextCharSafeBody(const(ubyte)* s, int* pi, int length, int c, byte strict);

@DllImport("icu.dll")
int utf8_appendCharSafeBody(ubyte* s, int i, int length, int c, byte* pIsError);

@DllImport("icu.dll")
int utf8_prevCharSafeBody(const(ubyte)* s, int start, int* pi, int c, byte strict);

@DllImport("icu.dll")
int utf8_back1SafeBody(const(ubyte)* s, int start, int i);

@DllImport("icu.dll")
void u_versionFromString(ubyte* versionArray, const(byte)* versionString);

@DllImport("icu.dll")
void u_versionFromUString(ubyte* versionArray, const(ushort)* versionString);

@DllImport("icu.dll")
void u_versionToString(const(ubyte)* versionArray, byte* versionString);

@DllImport("icu.dll")
void u_getVersion(ubyte* versionArray);

@DllImport("icu.dll")
byte* u_errorName(UErrorCode code);

@DllImport("icu.dll")
void utrace_setLevel(int traceLevel);

@DllImport("icu.dll")
int utrace_getLevel();

@DllImport("icu.dll")
void utrace_setFunctions(const(void)* context, UTraceEntry* e, UTraceExit* x, UTraceData* d);

@DllImport("icu.dll")
void utrace_getFunctions(const(void)** context, UTraceEntry** e, UTraceExit** x, UTraceData** d);

@DllImport("icu.dll")
int utrace_vformat(byte* outBuf, int capacity, int indent, const(byte)* fmt, byte* args);

@DllImport("icu.dll")
int utrace_format(byte* outBuf, int capacity, int indent, const(byte)* fmt);

@DllImport("icu.dll")
byte* utrace_functionName(int fnNumber);

@DllImport("icu.dll")
int u_shapeArabic(const(ushort)* source, int sourceLength, ushort* dest, int destSize, uint options, UErrorCode* pErrorCode);

@DllImport("icu.dll")
int uscript_getCode(const(byte)* nameOrAbbrOrLocale, UScriptCode* fillIn, int capacity, UErrorCode* err);

@DllImport("icu.dll")
byte* uscript_getName(UScriptCode scriptCode);

@DllImport("icu.dll")
byte* uscript_getShortName(UScriptCode scriptCode);

@DllImport("icu.dll")
UScriptCode uscript_getScript(int codepoint, UErrorCode* err);

@DllImport("icu.dll")
byte uscript_hasScript(int c, UScriptCode sc);

@DllImport("icu.dll")
int uscript_getScriptExtensions(int c, UScriptCode* scripts, int capacity, UErrorCode* errorCode);

@DllImport("icu.dll")
int uscript_getSampleString(UScriptCode script, ushort* dest, int capacity, UErrorCode* pErrorCode);

@DllImport("icu.dll")
UScriptUsage uscript_getUsage(UScriptCode script);

@DllImport("icu.dll")
byte uscript_isRightToLeft(UScriptCode script);

@DllImport("icu.dll")
byte uscript_breaksBetweenLetters(UScriptCode script);

@DllImport("icu.dll")
byte uscript_isCased(UScriptCode script);

@DllImport("icu.dll")
int uiter_current32(UCharIterator* iter);

@DllImport("icu.dll")
int uiter_next32(UCharIterator* iter);

@DllImport("icu.dll")
int uiter_previous32(UCharIterator* iter);

@DllImport("icu.dll")
uint uiter_getState(const(UCharIterator)* iter);

@DllImport("icu.dll")
void uiter_setState(UCharIterator* iter, uint state, UErrorCode* pErrorCode);

@DllImport("icu.dll")
void uiter_setString(UCharIterator* iter, const(ushort)* s, int length);

@DllImport("icu.dll")
void uiter_setUTF16BE(UCharIterator* iter, const(byte)* s, int length);

@DllImport("icu.dll")
void uiter_setUTF8(UCharIterator* iter, const(byte)* s, int length);

@DllImport("icu.dll")
void uenum_close(UEnumeration* en);

@DllImport("icu.dll")
int uenum_count(UEnumeration* en, UErrorCode* status);

@DllImport("icu.dll")
ushort* uenum_unext(UEnumeration* en, int* resultLength, UErrorCode* status);

@DllImport("icu.dll")
byte* uenum_next(UEnumeration* en, int* resultLength, UErrorCode* status);

@DllImport("icu.dll")
void uenum_reset(UEnumeration* en, UErrorCode* status);

@DllImport("icu.dll")
UEnumeration* uenum_openUCharStringsEnumeration(const(ushort)** strings, int count, UErrorCode* ec);

@DllImport("icu.dll")
UEnumeration* uenum_openCharStringsEnumeration(const(byte)** strings, int count, UErrorCode* ec);

@DllImport("icu.dll")
byte* uloc_getDefault();

@DllImport("icu.dll")
void uloc_setDefault(const(byte)* localeID, UErrorCode* status);

@DllImport("icu.dll")
int uloc_getLanguage(const(byte)* localeID, byte* language, int languageCapacity, UErrorCode* err);

@DllImport("icu.dll")
int uloc_getScript(const(byte)* localeID, byte* script, int scriptCapacity, UErrorCode* err);

@DllImport("icu.dll")
int uloc_getCountry(const(byte)* localeID, byte* country, int countryCapacity, UErrorCode* err);

@DllImport("icu.dll")
int uloc_getVariant(const(byte)* localeID, byte* variant, int variantCapacity, UErrorCode* err);

@DllImport("icu.dll")
int uloc_getName(const(byte)* localeID, byte* name, int nameCapacity, UErrorCode* err);

@DllImport("icu.dll")
int uloc_canonicalize(const(byte)* localeID, byte* name, int nameCapacity, UErrorCode* err);

@DllImport("icu.dll")
byte* uloc_getISO3Language(const(byte)* localeID);

@DllImport("icu.dll")
byte* uloc_getISO3Country(const(byte)* localeID);

@DllImport("icu.dll")
uint uloc_getLCID(const(byte)* localeID);

@DllImport("icu.dll")
int uloc_getDisplayLanguage(const(byte)* locale, const(byte)* displayLocale, ushort* language, int languageCapacity, UErrorCode* status);

@DllImport("icu.dll")
int uloc_getDisplayScript(const(byte)* locale, const(byte)* displayLocale, ushort* script, int scriptCapacity, UErrorCode* status);

@DllImport("icu.dll")
int uloc_getDisplayCountry(const(byte)* locale, const(byte)* displayLocale, ushort* country, int countryCapacity, UErrorCode* status);

@DllImport("icu.dll")
int uloc_getDisplayVariant(const(byte)* locale, const(byte)* displayLocale, ushort* variant, int variantCapacity, UErrorCode* status);

@DllImport("icu.dll")
int uloc_getDisplayKeyword(const(byte)* keyword, const(byte)* displayLocale, ushort* dest, int destCapacity, UErrorCode* status);

@DllImport("icu.dll")
int uloc_getDisplayKeywordValue(const(byte)* locale, const(byte)* keyword, const(byte)* displayLocale, ushort* dest, int destCapacity, UErrorCode* status);

@DllImport("icu.dll")
int uloc_getDisplayName(const(byte)* localeID, const(byte)* inLocaleID, ushort* result, int maxResultSize, UErrorCode* err);

@DllImport("icu.dll")
byte* uloc_getAvailable(int n);

@DllImport("icu.dll")
int uloc_countAvailable();

@DllImport("icu.dll")
byte** uloc_getISOLanguages();

@DllImport("icu.dll")
byte** uloc_getISOCountries();

@DllImport("icu.dll")
int uloc_getParent(const(byte)* localeID, byte* parent, int parentCapacity, UErrorCode* err);

@DllImport("icu.dll")
int uloc_getBaseName(const(byte)* localeID, byte* name, int nameCapacity, UErrorCode* err);

@DllImport("icu.dll")
UEnumeration* uloc_openKeywords(const(byte)* localeID, UErrorCode* status);

@DllImport("icu.dll")
int uloc_getKeywordValue(const(byte)* localeID, const(byte)* keywordName, byte* buffer, int bufferCapacity, UErrorCode* status);

@DllImport("icu.dll")
int uloc_setKeywordValue(const(byte)* keywordName, const(byte)* keywordValue, byte* buffer, int bufferCapacity, UErrorCode* status);

@DllImport("icu.dll")
byte uloc_isRightToLeft(const(byte)* locale);

@DllImport("icu.dll")
ULayoutType uloc_getCharacterOrientation(const(byte)* localeId, UErrorCode* status);

@DllImport("icu.dll")
ULayoutType uloc_getLineOrientation(const(byte)* localeId, UErrorCode* status);

@DllImport("icu.dll")
int uloc_acceptLanguageFromHTTP(byte* result, int resultAvailable, UAcceptResult* outResult, const(byte)* httpAcceptLanguage, UEnumeration* availableLocales, UErrorCode* status);

@DllImport("icu.dll")
int uloc_acceptLanguage(byte* result, int resultAvailable, UAcceptResult* outResult, const(byte)** acceptList, int acceptListCount, UEnumeration* availableLocales, UErrorCode* status);

@DllImport("icu.dll")
int uloc_getLocaleForLCID(uint hostID, byte* locale, int localeCapacity, UErrorCode* status);

@DllImport("icu.dll")
int uloc_addLikelySubtags(const(byte)* localeID, byte* maximizedLocaleID, int maximizedLocaleIDCapacity, UErrorCode* err);

@DllImport("icu.dll")
int uloc_minimizeSubtags(const(byte)* localeID, byte* minimizedLocaleID, int minimizedLocaleIDCapacity, UErrorCode* err);

@DllImport("icu.dll")
int uloc_forLanguageTag(const(byte)* langtag, byte* localeID, int localeIDCapacity, int* parsedLength, UErrorCode* err);

@DllImport("icu.dll")
int uloc_toLanguageTag(const(byte)* localeID, byte* langtag, int langtagCapacity, byte strict, UErrorCode* err);

@DllImport("icu.dll")
byte* uloc_toUnicodeLocaleKey(const(byte)* keyword);

@DllImport("icu.dll")
byte* uloc_toUnicodeLocaleType(const(byte)* keyword, const(byte)* value);

@DllImport("icu.dll")
byte* uloc_toLegacyKey(const(byte)* keyword);

@DllImport("icu.dll")
byte* uloc_toLegacyType(const(byte)* keyword, const(byte)* value);

@DllImport("icu.dll")
UResourceBundle* ures_open(const(byte)* packageName, const(byte)* locale, UErrorCode* status);

@DllImport("icu.dll")
UResourceBundle* ures_openDirect(const(byte)* packageName, const(byte)* locale, UErrorCode* status);

@DllImport("icu.dll")
UResourceBundle* ures_openU(const(ushort)* packageName, const(byte)* locale, UErrorCode* status);

@DllImport("icu.dll")
void ures_close(UResourceBundle* resourceBundle);

@DllImport("icu.dll")
void ures_getVersion(const(UResourceBundle)* resB, ubyte* versionInfo);

@DllImport("icu.dll")
byte* ures_getLocaleByType(const(UResourceBundle)* resourceBundle, ULocDataLocaleType type, UErrorCode* status);

@DllImport("icu.dll")
ushort* ures_getString(const(UResourceBundle)* resourceBundle, int* len, UErrorCode* status);

@DllImport("icu.dll")
byte* ures_getUTF8String(const(UResourceBundle)* resB, byte* dest, int* length, byte forceCopy, UErrorCode* status);

@DllImport("icu.dll")
ubyte* ures_getBinary(const(UResourceBundle)* resourceBundle, int* len, UErrorCode* status);

@DllImport("icu.dll")
int* ures_getIntVector(const(UResourceBundle)* resourceBundle, int* len, UErrorCode* status);

@DllImport("icu.dll")
uint ures_getUInt(const(UResourceBundle)* resourceBundle, UErrorCode* status);

@DllImport("icu.dll")
int ures_getInt(const(UResourceBundle)* resourceBundle, UErrorCode* status);

@DllImport("icu.dll")
int ures_getSize(const(UResourceBundle)* resourceBundle);

@DllImport("icu.dll")
UResType ures_getType(const(UResourceBundle)* resourceBundle);

@DllImport("icu.dll")
byte* ures_getKey(const(UResourceBundle)* resourceBundle);

@DllImport("icu.dll")
void ures_resetIterator(UResourceBundle* resourceBundle);

@DllImport("icu.dll")
byte ures_hasNext(const(UResourceBundle)* resourceBundle);

@DllImport("icu.dll")
UResourceBundle* ures_getNextResource(UResourceBundle* resourceBundle, UResourceBundle* fillIn, UErrorCode* status);

@DllImport("icu.dll")
ushort* ures_getNextString(UResourceBundle* resourceBundle, int* len, const(byte)** key, UErrorCode* status);

@DllImport("icu.dll")
UResourceBundle* ures_getByIndex(const(UResourceBundle)* resourceBundle, int indexR, UResourceBundle* fillIn, UErrorCode* status);

@DllImport("icu.dll")
ushort* ures_getStringByIndex(const(UResourceBundle)* resourceBundle, int indexS, int* len, UErrorCode* status);

@DllImport("icu.dll")
byte* ures_getUTF8StringByIndex(const(UResourceBundle)* resB, int stringIndex, byte* dest, int* pLength, byte forceCopy, UErrorCode* status);

@DllImport("icu.dll")
UResourceBundle* ures_getByKey(const(UResourceBundle)* resourceBundle, const(byte)* key, UResourceBundle* fillIn, UErrorCode* status);

@DllImport("icu.dll")
ushort* ures_getStringByKey(const(UResourceBundle)* resB, const(byte)* key, int* len, UErrorCode* status);

@DllImport("icu.dll")
byte* ures_getUTF8StringByKey(const(UResourceBundle)* resB, const(byte)* key, byte* dest, int* pLength, byte forceCopy, UErrorCode* status);

@DllImport("icu.dll")
UEnumeration* ures_openAvailableLocales(const(byte)* packageName, UErrorCode* status);

@DllImport("icu.dll")
ULocaleDisplayNames* uldn_open(const(byte)* locale, UDialectHandling dialectHandling, UErrorCode* pErrorCode);

@DllImport("icu.dll")
void uldn_close(ULocaleDisplayNames* ldn);

@DllImport("icu.dll")
byte* uldn_getLocale(const(ULocaleDisplayNames)* ldn);

@DllImport("icu.dll")
UDialectHandling uldn_getDialectHandling(const(ULocaleDisplayNames)* ldn);

@DllImport("icu.dll")
int uldn_localeDisplayName(const(ULocaleDisplayNames)* ldn, const(byte)* locale, ushort* result, int maxResultSize, UErrorCode* pErrorCode);

@DllImport("icu.dll")
int uldn_languageDisplayName(const(ULocaleDisplayNames)* ldn, const(byte)* lang, ushort* result, int maxResultSize, UErrorCode* pErrorCode);

@DllImport("icu.dll")
int uldn_scriptDisplayName(const(ULocaleDisplayNames)* ldn, const(byte)* script, ushort* result, int maxResultSize, UErrorCode* pErrorCode);

@DllImport("icu.dll")
int uldn_scriptCodeDisplayName(const(ULocaleDisplayNames)* ldn, UScriptCode scriptCode, ushort* result, int maxResultSize, UErrorCode* pErrorCode);

@DllImport("icu.dll")
int uldn_regionDisplayName(const(ULocaleDisplayNames)* ldn, const(byte)* region, ushort* result, int maxResultSize, UErrorCode* pErrorCode);

@DllImport("icu.dll")
int uldn_variantDisplayName(const(ULocaleDisplayNames)* ldn, const(byte)* variant, ushort* result, int maxResultSize, UErrorCode* pErrorCode);

@DllImport("icu.dll")
int uldn_keyDisplayName(const(ULocaleDisplayNames)* ldn, const(byte)* key, ushort* result, int maxResultSize, UErrorCode* pErrorCode);

@DllImport("icu.dll")
int uldn_keyValueDisplayName(const(ULocaleDisplayNames)* ldn, const(byte)* key, const(byte)* value, ushort* result, int maxResultSize, UErrorCode* pErrorCode);

@DllImport("icu.dll")
ULocaleDisplayNames* uldn_openForContext(const(byte)* locale, UDisplayContext* contexts, int length, UErrorCode* pErrorCode);

@DllImport("icu.dll")
UDisplayContext uldn_getContext(const(ULocaleDisplayNames)* ldn, UDisplayContextType type, UErrorCode* pErrorCode);

@DllImport("icu.dll")
int ucurr_forLocale(const(byte)* locale, ushort* buff, int buffCapacity, UErrorCode* ec);

@DllImport("icu.dll")
void* ucurr_register(const(ushort)* isoCode, const(byte)* locale, UErrorCode* status);

@DllImport("icu.dll")
byte ucurr_unregister(void* key, UErrorCode* status);

@DllImport("icu.dll")
ushort* ucurr_getName(const(ushort)* currency, const(byte)* locale, UCurrNameStyle nameStyle, byte* isChoiceFormat, int* len, UErrorCode* ec);

@DllImport("icu.dll")
ushort* ucurr_getPluralName(const(ushort)* currency, const(byte)* locale, byte* isChoiceFormat, const(byte)* pluralCount, int* len, UErrorCode* ec);

@DllImport("icu.dll")
int ucurr_getDefaultFractionDigits(const(ushort)* currency, UErrorCode* ec);

@DllImport("icu.dll")
int ucurr_getDefaultFractionDigitsForUsage(const(ushort)* currency, const(UCurrencyUsage) usage, UErrorCode* ec);

@DllImport("icu.dll")
double ucurr_getRoundingIncrement(const(ushort)* currency, UErrorCode* ec);

@DllImport("icu.dll")
double ucurr_getRoundingIncrementForUsage(const(ushort)* currency, const(UCurrencyUsage) usage, UErrorCode* ec);

@DllImport("icu.dll")
UEnumeration* ucurr_openISOCurrencies(uint currType, UErrorCode* pErrorCode);

@DllImport("icu.dll")
byte ucurr_isAvailable(const(ushort)* isoCode, double from, double to, UErrorCode* errorCode);

@DllImport("icu.dll")
int ucurr_countCurrencies(const(byte)* locale, double date, UErrorCode* ec);

@DllImport("icu.dll")
int ucurr_forLocaleAndDate(const(byte)* locale, double date, int index, ushort* buff, int buffCapacity, UErrorCode* ec);

@DllImport("icu.dll")
UEnumeration* ucurr_getKeywordValuesForLocale(const(byte)* key, const(byte)* locale, byte commonlyUsed, UErrorCode* status);

@DllImport("icu.dll")
int ucurr_getNumericCode(const(ushort)* currency);

@DllImport("icu.dll")
void UCNV_FROM_U_CALLBACK_STOP(const(void)* context, UConverterFromUnicodeArgs* fromUArgs, const(ushort)* codeUnits, int length, int codePoint, UConverterCallbackReason reason, UErrorCode* err);

@DllImport("icu.dll")
void UCNV_TO_U_CALLBACK_STOP(const(void)* context, UConverterToUnicodeArgs* toUArgs, const(byte)* codeUnits, int length, UConverterCallbackReason reason, UErrorCode* err);

@DllImport("icu.dll")
void UCNV_FROM_U_CALLBACK_SKIP(const(void)* context, UConverterFromUnicodeArgs* fromUArgs, const(ushort)* codeUnits, int length, int codePoint, UConverterCallbackReason reason, UErrorCode* err);

@DllImport("icu.dll")
void UCNV_FROM_U_CALLBACK_SUBSTITUTE(const(void)* context, UConverterFromUnicodeArgs* fromUArgs, const(ushort)* codeUnits, int length, int codePoint, UConverterCallbackReason reason, UErrorCode* err);

@DllImport("icu.dll")
void UCNV_FROM_U_CALLBACK_ESCAPE(const(void)* context, UConverterFromUnicodeArgs* fromUArgs, const(ushort)* codeUnits, int length, int codePoint, UConverterCallbackReason reason, UErrorCode* err);

@DllImport("icu.dll")
void UCNV_TO_U_CALLBACK_SKIP(const(void)* context, UConverterToUnicodeArgs* toUArgs, const(byte)* codeUnits, int length, UConverterCallbackReason reason, UErrorCode* err);

@DllImport("icu.dll")
void UCNV_TO_U_CALLBACK_SUBSTITUTE(const(void)* context, UConverterToUnicodeArgs* toUArgs, const(byte)* codeUnits, int length, UConverterCallbackReason reason, UErrorCode* err);

@DllImport("icu.dll")
void UCNV_TO_U_CALLBACK_ESCAPE(const(void)* context, UConverterToUnicodeArgs* toUArgs, const(byte)* codeUnits, int length, UConverterCallbackReason reason, UErrorCode* err);

@DllImport("icu.dll")
int ucnv_compareNames(const(byte)* name1, const(byte)* name2);

@DllImport("icu.dll")
UConverter* ucnv_open(const(byte)* converterName, UErrorCode* err);

@DllImport("icu.dll")
UConverter* ucnv_openU(const(ushort)* name, UErrorCode* err);

@DllImport("icu.dll")
UConverter* ucnv_openCCSID(int codepage, UConverterPlatform platform, UErrorCode* err);

@DllImport("icu.dll")
UConverter* ucnv_openPackage(const(byte)* packageName, const(byte)* converterName, UErrorCode* err);

@DllImport("icu.dll")
UConverter* ucnv_safeClone(const(UConverter)* cnv, void* stackBuffer, int* pBufferSize, UErrorCode* status);

@DllImport("icu.dll")
void ucnv_close(UConverter* converter);

@DllImport("icu.dll")
void ucnv_getSubstChars(const(UConverter)* converter, byte* subChars, byte* len, UErrorCode* err);

@DllImport("icu.dll")
void ucnv_setSubstChars(UConverter* converter, const(byte)* subChars, byte len, UErrorCode* err);

@DllImport("icu.dll")
void ucnv_setSubstString(UConverter* cnv, const(ushort)* s, int length, UErrorCode* err);

@DllImport("icu.dll")
void ucnv_getInvalidChars(const(UConverter)* converter, byte* errBytes, byte* len, UErrorCode* err);

@DllImport("icu.dll")
void ucnv_getInvalidUChars(const(UConverter)* converter, ushort* errUChars, byte* len, UErrorCode* err);

@DllImport("icu.dll")
void ucnv_reset(UConverter* converter);

@DllImport("icu.dll")
void ucnv_resetToUnicode(UConverter* converter);

@DllImport("icu.dll")
void ucnv_resetFromUnicode(UConverter* converter);

@DllImport("icu.dll")
byte ucnv_getMaxCharSize(const(UConverter)* converter);

@DllImport("icu.dll")
byte ucnv_getMinCharSize(const(UConverter)* converter);

@DllImport("icu.dll")
int ucnv_getDisplayName(const(UConverter)* converter, const(byte)* displayLocale, ushort* displayName, int displayNameCapacity, UErrorCode* err);

@DllImport("icu.dll")
byte* ucnv_getName(const(UConverter)* converter, UErrorCode* err);

@DllImport("icu.dll")
int ucnv_getCCSID(const(UConverter)* converter, UErrorCode* err);

@DllImport("icu.dll")
UConverterPlatform ucnv_getPlatform(const(UConverter)* converter, UErrorCode* err);

@DllImport("icu.dll")
UConverterType ucnv_getType(const(UConverter)* converter);

@DllImport("icu.dll")
void ucnv_getStarters(const(UConverter)* converter, byte* starters, UErrorCode* err);

@DllImport("icu.dll")
void ucnv_getUnicodeSet(const(UConverter)* cnv, USet* setFillIn, UConverterUnicodeSet whichSet, UErrorCode* pErrorCode);

@DllImport("icu.dll")
void ucnv_getToUCallBack(const(UConverter)* converter, UConverterToUCallback* action, const(void)** context);

@DllImport("icu.dll")
void ucnv_getFromUCallBack(const(UConverter)* converter, UConverterFromUCallback* action, const(void)** context);

@DllImport("icu.dll")
void ucnv_setToUCallBack(UConverter* converter, UConverterToUCallback newAction, const(void)* newContext, UConverterToUCallback* oldAction, const(void)** oldContext, UErrorCode* err);

@DllImport("icu.dll")
void ucnv_setFromUCallBack(UConverter* converter, UConverterFromUCallback newAction, const(void)* newContext, UConverterFromUCallback* oldAction, const(void)** oldContext, UErrorCode* err);

@DllImport("icu.dll")
void ucnv_fromUnicode(UConverter* converter, byte** target, const(byte)* targetLimit, const(ushort)** source, const(ushort)* sourceLimit, int* offsets, byte flush, UErrorCode* err);

@DllImport("icu.dll")
void ucnv_toUnicode(UConverter* converter, ushort** target, const(ushort)* targetLimit, const(byte)** source, const(byte)* sourceLimit, int* offsets, byte flush, UErrorCode* err);

@DllImport("icu.dll")
int ucnv_fromUChars(UConverter* cnv, byte* dest, int destCapacity, const(ushort)* src, int srcLength, UErrorCode* pErrorCode);

@DllImport("icu.dll")
int ucnv_toUChars(UConverter* cnv, ushort* dest, int destCapacity, const(byte)* src, int srcLength, UErrorCode* pErrorCode);

@DllImport("icu.dll")
int ucnv_getNextUChar(UConverter* converter, const(byte)** source, const(byte)* sourceLimit, UErrorCode* err);

@DllImport("icu.dll")
void ucnv_convertEx(UConverter* targetCnv, UConverter* sourceCnv, byte** target, const(byte)* targetLimit, const(byte)** source, const(byte)* sourceLimit, ushort* pivotStart, ushort** pivotSource, ushort** pivotTarget, const(ushort)* pivotLimit, byte reset, byte flush, UErrorCode* pErrorCode);

@DllImport("icu.dll")
int ucnv_convert(const(byte)* toConverterName, const(byte)* fromConverterName, byte* target, int targetCapacity, const(byte)* source, int sourceLength, UErrorCode* pErrorCode);

@DllImport("icu.dll")
int ucnv_toAlgorithmic(UConverterType algorithmicType, UConverter* cnv, byte* target, int targetCapacity, const(byte)* source, int sourceLength, UErrorCode* pErrorCode);

@DllImport("icu.dll")
int ucnv_fromAlgorithmic(UConverter* cnv, UConverterType algorithmicType, byte* target, int targetCapacity, const(byte)* source, int sourceLength, UErrorCode* pErrorCode);

@DllImport("icu.dll")
int ucnv_flushCache();

@DllImport("icu.dll")
int ucnv_countAvailable();

@DllImport("icu.dll")
byte* ucnv_getAvailableName(int n);

@DllImport("icu.dll")
UEnumeration* ucnv_openAllNames(UErrorCode* pErrorCode);

@DllImport("icu.dll")
ushort ucnv_countAliases(const(byte)* alias, UErrorCode* pErrorCode);

@DllImport("icu.dll")
byte* ucnv_getAlias(const(byte)* alias, ushort n, UErrorCode* pErrorCode);

@DllImport("icu.dll")
void ucnv_getAliases(const(byte)* alias, const(byte)** aliases, UErrorCode* pErrorCode);

@DllImport("icu.dll")
UEnumeration* ucnv_openStandardNames(const(byte)* convName, const(byte)* standard, UErrorCode* pErrorCode);

@DllImport("icu.dll")
ushort ucnv_countStandards();

@DllImport("icu.dll")
byte* ucnv_getStandard(ushort n, UErrorCode* pErrorCode);

@DllImport("icu.dll")
byte* ucnv_getStandardName(const(byte)* name, const(byte)* standard, UErrorCode* pErrorCode);

@DllImport("icu.dll")
byte* ucnv_getCanonicalName(const(byte)* alias, const(byte)* standard, UErrorCode* pErrorCode);

@DllImport("icu.dll")
byte* ucnv_getDefaultName();

@DllImport("icu.dll")
void ucnv_setDefaultName(const(byte)* name);

@DllImport("icu.dll")
void ucnv_fixFileSeparator(const(UConverter)* cnv, ushort* source, int sourceLen);

@DllImport("icu.dll")
byte ucnv_isAmbiguous(const(UConverter)* cnv);

@DllImport("icu.dll")
void ucnv_setFallback(UConverter* cnv, byte usesFallback);

@DllImport("icu.dll")
byte ucnv_usesFallback(const(UConverter)* cnv);

@DllImport("icu.dll")
byte* ucnv_detectUnicodeSignature(const(byte)* source, int sourceLength, int* signatureLength, UErrorCode* pErrorCode);

@DllImport("icu.dll")
int ucnv_fromUCountPending(const(UConverter)* cnv, UErrorCode* status);

@DllImport("icu.dll")
int ucnv_toUCountPending(const(UConverter)* cnv, UErrorCode* status);

@DllImport("icu.dll")
byte ucnv_isFixedWidth(UConverter* cnv, UErrorCode* status);

@DllImport("icu.dll")
void ucnv_cbFromUWriteBytes(UConverterFromUnicodeArgs* args, const(byte)* source, int length, int offsetIndex, UErrorCode* err);

@DllImport("icu.dll")
void ucnv_cbFromUWriteSub(UConverterFromUnicodeArgs* args, int offsetIndex, UErrorCode* err);

@DllImport("icu.dll")
void ucnv_cbFromUWriteUChars(UConverterFromUnicodeArgs* args, const(ushort)** source, const(ushort)* sourceLimit, int offsetIndex, UErrorCode* err);

@DllImport("icu.dll")
void ucnv_cbToUWriteUChars(UConverterToUnicodeArgs* args, const(ushort)* source, int length, int offsetIndex, UErrorCode* err);

@DllImport("icu.dll")
void ucnv_cbToUWriteSub(UConverterToUnicodeArgs* args, int offsetIndex, UErrorCode* err);

@DllImport("icu.dll")
void u_init(UErrorCode* status);

@DllImport("icu.dll")
void u_cleanup();

@DllImport("icu.dll")
void u_setMemoryFunctions(const(void)* context, UMemAllocFn* a, UMemReallocFn* r, UMemFreeFn* f, UErrorCode* status);

@DllImport("icu.dll")
UResourceBundle* u_catopen(const(byte)* name, const(byte)* locale, UErrorCode* ec);

@DllImport("icu.dll")
void u_catclose(UResourceBundle* catd);

@DllImport("icu.dll")
ushort* u_catgets(UResourceBundle* catd, int set_num, int msg_num, const(ushort)* s, int* len, UErrorCode* ec);

@DllImport("icu.dll")
byte u_hasBinaryProperty(int c, UProperty which);

@DllImport("icu.dll")
byte u_isUAlphabetic(int c);

@DllImport("icu.dll")
byte u_isULowercase(int c);

@DllImport("icu.dll")
byte u_isUUppercase(int c);

@DllImport("icu.dll")
byte u_isUWhiteSpace(int c);

@DllImport("icu.dll")
int u_getIntPropertyValue(int c, UProperty which);

@DllImport("icu.dll")
int u_getIntPropertyMinValue(UProperty which);

@DllImport("icu.dll")
int u_getIntPropertyMaxValue(UProperty which);

@DllImport("icu.dll")
double u_getNumericValue(int c);

@DllImport("icu.dll")
byte u_islower(int c);

@DllImport("icu.dll")
byte u_isupper(int c);

@DllImport("icu.dll")
byte u_istitle(int c);

@DllImport("icu.dll")
byte u_isdigit(int c);

@DllImport("icu.dll")
byte u_isalpha(int c);

@DllImport("icu.dll")
byte u_isalnum(int c);

@DllImport("icu.dll")
byte u_isxdigit(int c);

@DllImport("icu.dll")
byte u_ispunct(int c);

@DllImport("icu.dll")
byte u_isgraph(int c);

@DllImport("icu.dll")
byte u_isblank(int c);

@DllImport("icu.dll")
byte u_isdefined(int c);

@DllImport("icu.dll")
byte u_isspace(int c);

@DllImport("icu.dll")
byte u_isJavaSpaceChar(int c);

@DllImport("icu.dll")
byte u_isWhitespace(int c);

@DllImport("icu.dll")
byte u_iscntrl(int c);

@DllImport("icu.dll")
byte u_isISOControl(int c);

@DllImport("icu.dll")
byte u_isprint(int c);

@DllImport("icu.dll")
byte u_isbase(int c);

@DllImport("icu.dll")
UCharDirection u_charDirection(int c);

@DllImport("icu.dll")
byte u_isMirrored(int c);

@DllImport("icu.dll")
int u_charMirror(int c);

@DllImport("icu.dll")
int u_getBidiPairedBracket(int c);

@DllImport("icu.dll")
byte u_charType(int c);

@DllImport("icu.dll")
void u_enumCharTypes(UCharEnumTypeRange* enumRange, const(void)* context);

@DllImport("icu.dll")
ubyte u_getCombiningClass(int c);

@DllImport("icu.dll")
int u_charDigitValue(int c);

@DllImport("icu.dll")
UBlockCode ublock_getCode(int c);

@DllImport("icu.dll")
int u_charName(int code, UCharNameChoice nameChoice, byte* buffer, int bufferLength, UErrorCode* pErrorCode);

@DllImport("icu.dll")
int u_charFromName(UCharNameChoice nameChoice, const(byte)* name, UErrorCode* pErrorCode);

@DllImport("icu.dll")
void u_enumCharNames(int start, int limit, UEnumCharNamesFn* fn, void* context, UCharNameChoice nameChoice, UErrorCode* pErrorCode);

@DllImport("icu.dll")
byte* u_getPropertyName(UProperty property, UPropertyNameChoice nameChoice);

@DllImport("icu.dll")
UProperty u_getPropertyEnum(const(byte)* alias);

@DllImport("icu.dll")
byte* u_getPropertyValueName(UProperty property, int value, UPropertyNameChoice nameChoice);

@DllImport("icu.dll")
int u_getPropertyValueEnum(UProperty property, const(byte)* alias);

@DllImport("icu.dll")
byte u_isIDStart(int c);

@DllImport("icu.dll")
byte u_isIDPart(int c);

@DllImport("icu.dll")
byte u_isIDIgnorable(int c);

@DllImport("icu.dll")
byte u_isJavaIDStart(int c);

@DllImport("icu.dll")
byte u_isJavaIDPart(int c);

@DllImport("icu.dll")
int u_tolower(int c);

@DllImport("icu.dll")
int u_toupper(int c);

@DllImport("icu.dll")
int u_totitle(int c);

@DllImport("icu.dll")
int u_foldCase(int c, uint options);

@DllImport("icu.dll")
int u_digit(int ch, byte radix);

@DllImport("icu.dll")
int u_forDigit(int digit, byte radix);

@DllImport("icu.dll")
void u_charAge(int c, ubyte* versionArray);

@DllImport("icu.dll")
void u_getUnicodeVersion(ubyte* versionArray);

@DllImport("icu.dll")
int u_getFC_NFKC_Closure(int c, ushort* dest, int destCapacity, UErrorCode* pErrorCode);

@DllImport("icu.dll")
UBiDi* ubidi_open();

@DllImport("icu.dll")
UBiDi* ubidi_openSized(int maxLength, int maxRunCount, UErrorCode* pErrorCode);

@DllImport("icu.dll")
void ubidi_close(UBiDi* pBiDi);

@DllImport("icu.dll")
void ubidi_setInverse(UBiDi* pBiDi, byte isInverse);

@DllImport("icu.dll")
byte ubidi_isInverse(UBiDi* pBiDi);

@DllImport("icu.dll")
void ubidi_orderParagraphsLTR(UBiDi* pBiDi, byte orderParagraphsLTR);

@DllImport("icu.dll")
byte ubidi_isOrderParagraphsLTR(UBiDi* pBiDi);

@DllImport("icu.dll")
void ubidi_setReorderingMode(UBiDi* pBiDi, UBiDiReorderingMode reorderingMode);

@DllImport("icu.dll")
UBiDiReorderingMode ubidi_getReorderingMode(UBiDi* pBiDi);

@DllImport("icu.dll")
void ubidi_setReorderingOptions(UBiDi* pBiDi, uint reorderingOptions);

@DllImport("icu.dll")
uint ubidi_getReorderingOptions(UBiDi* pBiDi);

@DllImport("icu.dll")
void ubidi_setContext(UBiDi* pBiDi, const(ushort)* prologue, int proLength, const(ushort)* epilogue, int epiLength, UErrorCode* pErrorCode);

@DllImport("icu.dll")
void ubidi_setPara(UBiDi* pBiDi, const(ushort)* text, int length, ubyte paraLevel, ubyte* embeddingLevels, UErrorCode* pErrorCode);

@DllImport("icu.dll")
void ubidi_setLine(const(UBiDi)* pParaBiDi, int start, int limit, UBiDi* pLineBiDi, UErrorCode* pErrorCode);

@DllImport("icu.dll")
UBiDiDirection ubidi_getDirection(const(UBiDi)* pBiDi);

@DllImport("icu.dll")
UBiDiDirection ubidi_getBaseDirection(const(ushort)* text, int length);

@DllImport("icu.dll")
ushort* ubidi_getText(const(UBiDi)* pBiDi);

@DllImport("icu.dll")
int ubidi_getLength(const(UBiDi)* pBiDi);

@DllImport("icu.dll")
ubyte ubidi_getParaLevel(const(UBiDi)* pBiDi);

@DllImport("icu.dll")
int ubidi_countParagraphs(UBiDi* pBiDi);

@DllImport("icu.dll")
int ubidi_getParagraph(const(UBiDi)* pBiDi, int charIndex, int* pParaStart, int* pParaLimit, ubyte* pParaLevel, UErrorCode* pErrorCode);

@DllImport("icu.dll")
void ubidi_getParagraphByIndex(const(UBiDi)* pBiDi, int paraIndex, int* pParaStart, int* pParaLimit, ubyte* pParaLevel, UErrorCode* pErrorCode);

@DllImport("icu.dll")
ubyte ubidi_getLevelAt(const(UBiDi)* pBiDi, int charIndex);

@DllImport("icu.dll")
ubyte* ubidi_getLevels(UBiDi* pBiDi, UErrorCode* pErrorCode);

@DllImport("icu.dll")
void ubidi_getLogicalRun(const(UBiDi)* pBiDi, int logicalPosition, int* pLogicalLimit, ubyte* pLevel);

@DllImport("icu.dll")
int ubidi_countRuns(UBiDi* pBiDi, UErrorCode* pErrorCode);

@DllImport("icu.dll")
UBiDiDirection ubidi_getVisualRun(UBiDi* pBiDi, int runIndex, int* pLogicalStart, int* pLength);

@DllImport("icu.dll")
int ubidi_getVisualIndex(UBiDi* pBiDi, int logicalIndex, UErrorCode* pErrorCode);

@DllImport("icu.dll")
int ubidi_getLogicalIndex(UBiDi* pBiDi, int visualIndex, UErrorCode* pErrorCode);

@DllImport("icu.dll")
void ubidi_getLogicalMap(UBiDi* pBiDi, int* indexMap, UErrorCode* pErrorCode);

@DllImport("icu.dll")
void ubidi_getVisualMap(UBiDi* pBiDi, int* indexMap, UErrorCode* pErrorCode);

@DllImport("icu.dll")
void ubidi_reorderLogical(const(ubyte)* levels, int length, int* indexMap);

@DllImport("icu.dll")
void ubidi_reorderVisual(const(ubyte)* levels, int length, int* indexMap);

@DllImport("icu.dll")
void ubidi_invertMap(const(int)* srcMap, int* destMap, int length);

@DllImport("icu.dll")
int ubidi_getProcessedLength(const(UBiDi)* pBiDi);

@DllImport("icu.dll")
int ubidi_getResultLength(const(UBiDi)* pBiDi);

@DllImport("icu.dll")
UCharDirection ubidi_getCustomizedClass(UBiDi* pBiDi, int c);

@DllImport("icu.dll")
void ubidi_setClassCallback(UBiDi* pBiDi, UBiDiClassCallback* newFn, const(void)* newContext, UBiDiClassCallback** oldFn, const(void)** oldContext, UErrorCode* pErrorCode);

@DllImport("icu.dll")
void ubidi_getClassCallback(UBiDi* pBiDi, UBiDiClassCallback** fn, const(void)** context);

@DllImport("icu.dll")
int ubidi_writeReordered(UBiDi* pBiDi, ushort* dest, int destSize, ushort options, UErrorCode* pErrorCode);

@DllImport("icu.dll")
int ubidi_writeReverse(const(ushort)* src, int srcLength, ushort* dest, int destSize, ushort options, UErrorCode* pErrorCode);

@DllImport("icu.dll")
uint ubiditransform_transform(UBiDiTransform* pBiDiTransform, const(ushort)* src, int srcLength, ushort* dest, int destSize, ubyte inParaLevel, UBiDiOrder inOrder, ubyte outParaLevel, UBiDiOrder outOrder, UBiDiMirroring doMirroring, uint shapingOptions, UErrorCode* pErrorCode);

@DllImport("icu.dll")
UBiDiTransform* ubiditransform_open(UErrorCode* pErrorCode);

@DllImport("icu.dll")
void ubiditransform_close(UBiDiTransform* pBidiTransform);

@DllImport("icu.dll")
UText* utext_close(UText* ut);

@DllImport("icu.dll")
UText* utext_openUTF8(UText* ut, const(byte)* s, long length, UErrorCode* status);

@DllImport("icu.dll")
UText* utext_openUChars(UText* ut, const(ushort)* s, long length, UErrorCode* status);

@DllImport("icu.dll")
UText* utext_clone(UText* dest, const(UText)* src, byte deep, byte readOnly, UErrorCode* status);

@DllImport("icu.dll")
byte utext_equals(const(UText)* a, const(UText)* b);

@DllImport("icu.dll")
long utext_nativeLength(UText* ut);

@DllImport("icu.dll")
byte utext_isLengthExpensive(const(UText)* ut);

@DllImport("icu.dll")
int utext_char32At(UText* ut, long nativeIndex);

@DllImport("icu.dll")
int utext_current32(UText* ut);

@DllImport("icu.dll")
int utext_next32(UText* ut);

@DllImport("icu.dll")
int utext_previous32(UText* ut);

@DllImport("icu.dll")
int utext_next32From(UText* ut, long nativeIndex);

@DllImport("icu.dll")
int utext_previous32From(UText* ut, long nativeIndex);

@DllImport("icu.dll")
long utext_getNativeIndex(const(UText)* ut);

@DllImport("icu.dll")
void utext_setNativeIndex(UText* ut, long nativeIndex);

@DllImport("icu.dll")
byte utext_moveIndex32(UText* ut, int delta);

@DllImport("icu.dll")
long utext_getPreviousNativeIndex(UText* ut);

@DllImport("icu.dll")
int utext_extract(UText* ut, long nativeStart, long nativeLimit, ushort* dest, int destCapacity, UErrorCode* status);

@DllImport("icu.dll")
byte utext_isWritable(const(UText)* ut);

@DllImport("icu.dll")
byte utext_hasMetaData(const(UText)* ut);

@DllImport("icu.dll")
int utext_replace(UText* ut, long nativeStart, long nativeLimit, const(ushort)* replacementText, int replacementLength, UErrorCode* status);

@DllImport("icu.dll")
void utext_copy(UText* ut, long nativeStart, long nativeLimit, long destIndex, byte move, UErrorCode* status);

@DllImport("icu.dll")
void utext_freeze(UText* ut);

@DllImport("icu.dll")
UText* utext_setup(UText* ut, int extraSpace, UErrorCode* status);

@DllImport("icu.dll")
USet* uset_openEmpty();

@DllImport("icu.dll")
USet* uset_open(int start, int end);

@DllImport("icu.dll")
USet* uset_openPattern(const(ushort)* pattern, int patternLength, UErrorCode* ec);

@DllImport("icu.dll")
USet* uset_openPatternOptions(const(ushort)* pattern, int patternLength, uint options, UErrorCode* ec);

@DllImport("icu.dll")
void uset_close(USet* set);

@DllImport("icu.dll")
USet* uset_clone(const(USet)* set);

@DllImport("icu.dll")
byte uset_isFrozen(const(USet)* set);

@DllImport("icu.dll")
void uset_freeze(USet* set);

@DllImport("icu.dll")
USet* uset_cloneAsThawed(const(USet)* set);

@DllImport("icu.dll")
void uset_set(USet* set, int start, int end);

@DllImport("icu.dll")
int uset_applyPattern(USet* set, const(ushort)* pattern, int patternLength, uint options, UErrorCode* status);

@DllImport("icu.dll")
void uset_applyIntPropertyValue(USet* set, UProperty prop, int value, UErrorCode* ec);

@DllImport("icu.dll")
void uset_applyPropertyAlias(USet* set, const(ushort)* prop, int propLength, const(ushort)* value, int valueLength, UErrorCode* ec);

@DllImport("icu.dll")
byte uset_resemblesPattern(const(ushort)* pattern, int patternLength, int pos);

@DllImport("icu.dll")
int uset_toPattern(const(USet)* set, ushort* result, int resultCapacity, byte escapeUnprintable, UErrorCode* ec);

@DllImport("icu.dll")
void uset_add(USet* set, int c);

@DllImport("icu.dll")
void uset_addAll(USet* set, const(USet)* additionalSet);

@DllImport("icu.dll")
void uset_addRange(USet* set, int start, int end);

@DllImport("icu.dll")
void uset_addString(USet* set, const(ushort)* str, int strLen);

@DllImport("icu.dll")
void uset_addAllCodePoints(USet* set, const(ushort)* str, int strLen);

@DllImport("icu.dll")
void uset_remove(USet* set, int c);

@DllImport("icu.dll")
void uset_removeRange(USet* set, int start, int end);

@DllImport("icu.dll")
void uset_removeString(USet* set, const(ushort)* str, int strLen);

@DllImport("icu.dll")
void uset_removeAll(USet* set, const(USet)* removeSet);

@DllImport("icu.dll")
void uset_retain(USet* set, int start, int end);

@DllImport("icu.dll")
void uset_retainAll(USet* set, const(USet)* retain);

@DllImport("icu.dll")
void uset_compact(USet* set);

@DllImport("icu.dll")
void uset_complement(USet* set);

@DllImport("icu.dll")
void uset_complementAll(USet* set, const(USet)* complement);

@DllImport("icu.dll")
void uset_clear(USet* set);

@DllImport("icu.dll")
void uset_closeOver(USet* set, int attributes);

@DllImport("icu.dll")
void uset_removeAllStrings(USet* set);

@DllImport("icu.dll")
byte uset_isEmpty(const(USet)* set);

@DllImport("icu.dll")
byte uset_contains(const(USet)* set, int c);

@DllImport("icu.dll")
byte uset_containsRange(const(USet)* set, int start, int end);

@DllImport("icu.dll")
byte uset_containsString(const(USet)* set, const(ushort)* str, int strLen);

@DllImport("icu.dll")
int uset_indexOf(const(USet)* set, int c);

@DllImport("icu.dll")
int uset_charAt(const(USet)* set, int charIndex);

@DllImport("icu.dll")
int uset_size(const(USet)* set);

@DllImport("icu.dll")
int uset_getItemCount(const(USet)* set);

@DllImport("icu.dll")
int uset_getItem(const(USet)* set, int itemIndex, int* start, int* end, ushort* str, int strCapacity, UErrorCode* ec);

@DllImport("icu.dll")
byte uset_containsAll(const(USet)* set1, const(USet)* set2);

@DllImport("icu.dll")
byte uset_containsAllCodePoints(const(USet)* set, const(ushort)* str, int strLen);

@DllImport("icu.dll")
byte uset_containsNone(const(USet)* set1, const(USet)* set2);

@DllImport("icu.dll")
byte uset_containsSome(const(USet)* set1, const(USet)* set2);

@DllImport("icu.dll")
int uset_span(const(USet)* set, const(ushort)* s, int length, USetSpanCondition spanCondition);

@DllImport("icu.dll")
int uset_spanBack(const(USet)* set, const(ushort)* s, int length, USetSpanCondition spanCondition);

@DllImport("icu.dll")
int uset_spanUTF8(const(USet)* set, const(byte)* s, int length, USetSpanCondition spanCondition);

@DllImport("icu.dll")
int uset_spanBackUTF8(const(USet)* set, const(byte)* s, int length, USetSpanCondition spanCondition);

@DllImport("icu.dll")
byte uset_equals(const(USet)* set1, const(USet)* set2);

@DllImport("icu.dll")
int uset_serialize(const(USet)* set, ushort* dest, int destCapacity, UErrorCode* pErrorCode);

@DllImport("icu.dll")
byte uset_getSerializedSet(USerializedSet* fillSet, const(ushort)* src, int srcLength);

@DllImport("icu.dll")
void uset_setSerializedToOne(USerializedSet* fillSet, int c);

@DllImport("icu.dll")
byte uset_serializedContains(const(USerializedSet)* set, int c);

@DllImport("icu.dll")
int uset_getSerializedRangeCount(const(USerializedSet)* set);

@DllImport("icu.dll")
byte uset_getSerializedRange(const(USerializedSet)* set, int rangeIndex, int* pStart, int* pEnd);

@DllImport("icu.dll")
UNormalizer2* unorm2_getNFCInstance(UErrorCode* pErrorCode);

@DllImport("icu.dll")
UNormalizer2* unorm2_getNFDInstance(UErrorCode* pErrorCode);

@DllImport("icu.dll")
UNormalizer2* unorm2_getNFKCInstance(UErrorCode* pErrorCode);

@DllImport("icu.dll")
UNormalizer2* unorm2_getNFKDInstance(UErrorCode* pErrorCode);

@DllImport("icu.dll")
UNormalizer2* unorm2_getNFKCCasefoldInstance(UErrorCode* pErrorCode);

@DllImport("icu.dll")
UNormalizer2* unorm2_getInstance(const(byte)* packageName, const(byte)* name, UNormalization2Mode mode, UErrorCode* pErrorCode);

@DllImport("icu.dll")
UNormalizer2* unorm2_openFiltered(const(UNormalizer2)* norm2, const(USet)* filterSet, UErrorCode* pErrorCode);

@DllImport("icu.dll")
void unorm2_close(UNormalizer2* norm2);

@DllImport("icu.dll")
int unorm2_normalize(const(UNormalizer2)* norm2, const(ushort)* src, int length, ushort* dest, int capacity, UErrorCode* pErrorCode);

@DllImport("icu.dll")
int unorm2_normalizeSecondAndAppend(const(UNormalizer2)* norm2, ushort* first, int firstLength, int firstCapacity, const(ushort)* second, int secondLength, UErrorCode* pErrorCode);

@DllImport("icu.dll")
int unorm2_append(const(UNormalizer2)* norm2, ushort* first, int firstLength, int firstCapacity, const(ushort)* second, int secondLength, UErrorCode* pErrorCode);

@DllImport("icu.dll")
int unorm2_getDecomposition(const(UNormalizer2)* norm2, int c, ushort* decomposition, int capacity, UErrorCode* pErrorCode);

@DllImport("icu.dll")
int unorm2_getRawDecomposition(const(UNormalizer2)* norm2, int c, ushort* decomposition, int capacity, UErrorCode* pErrorCode);

@DllImport("icu.dll")
int unorm2_composePair(const(UNormalizer2)* norm2, int a, int b);

@DllImport("icu.dll")
ubyte unorm2_getCombiningClass(const(UNormalizer2)* norm2, int c);

@DllImport("icu.dll")
byte unorm2_isNormalized(const(UNormalizer2)* norm2, const(ushort)* s, int length, UErrorCode* pErrorCode);

@DllImport("icu.dll")
UNormalizationCheckResult unorm2_quickCheck(const(UNormalizer2)* norm2, const(ushort)* s, int length, UErrorCode* pErrorCode);

@DllImport("icu.dll")
int unorm2_spanQuickCheckYes(const(UNormalizer2)* norm2, const(ushort)* s, int length, UErrorCode* pErrorCode);

@DllImport("icu.dll")
byte unorm2_hasBoundaryBefore(const(UNormalizer2)* norm2, int c);

@DllImport("icu.dll")
byte unorm2_hasBoundaryAfter(const(UNormalizer2)* norm2, int c);

@DllImport("icu.dll")
byte unorm2_isInert(const(UNormalizer2)* norm2, int c);

@DllImport("icu.dll")
int unorm_compare(const(ushort)* s1, int length1, const(ushort)* s2, int length2, uint options, UErrorCode* pErrorCode);

@DllImport("icu.dll")
UConverterSelector* ucnvsel_open(const(byte)** converterList, int converterListSize, const(USet)* excludedCodePoints, const(UConverterUnicodeSet) whichSet, UErrorCode* status);

@DllImport("icu.dll")
void ucnvsel_close(UConverterSelector* sel);

@DllImport("icu.dll")
UConverterSelector* ucnvsel_openFromSerialized(const(void)* buffer, int length, UErrorCode* status);

@DllImport("icu.dll")
int ucnvsel_serialize(const(UConverterSelector)* sel, void* buffer, int bufferCapacity, UErrorCode* status);

@DllImport("icu.dll")
UEnumeration* ucnvsel_selectForString(const(UConverterSelector)* sel, const(ushort)* s, int length, UErrorCode* status);

@DllImport("icu.dll")
UEnumeration* ucnvsel_selectForUTF8(const(UConverterSelector)* sel, const(byte)* s, int length, UErrorCode* status);

@DllImport("icu.dll")
void u_charsToUChars(const(byte)* cs, ushort* us, int length);

@DllImport("icu.dll")
void u_UCharsToChars(const(ushort)* us, byte* cs, int length);

@DllImport("icu.dll")
int u_strlen(const(ushort)* s);

@DllImport("icu.dll")
int u_countChar32(const(ushort)* s, int length);

@DllImport("icu.dll")
byte u_strHasMoreChar32Than(const(ushort)* s, int length, int number);

@DllImport("icu.dll")
ushort* u_strcat(ushort* dst, const(ushort)* src);

@DllImport("icu.dll")
ushort* u_strncat(ushort* dst, const(ushort)* src, int n);

@DllImport("icu.dll")
ushort* u_strstr(const(ushort)* s, const(ushort)* substring);

@DllImport("icu.dll")
ushort* u_strFindFirst(const(ushort)* s, int length, const(ushort)* substring, int subLength);

@DllImport("icu.dll")
ushort* u_strchr(const(ushort)* s, ushort c);

@DllImport("icu.dll")
ushort* u_strchr32(const(ushort)* s, int c);

@DllImport("icu.dll")
ushort* u_strrstr(const(ushort)* s, const(ushort)* substring);

@DllImport("icu.dll")
ushort* u_strFindLast(const(ushort)* s, int length, const(ushort)* substring, int subLength);

@DllImport("icu.dll")
ushort* u_strrchr(const(ushort)* s, ushort c);

@DllImport("icu.dll")
ushort* u_strrchr32(const(ushort)* s, int c);

@DllImport("icu.dll")
ushort* u_strpbrk(const(ushort)* string, const(ushort)* matchSet);

@DllImport("icu.dll")
int u_strcspn(const(ushort)* string, const(ushort)* matchSet);

@DllImport("icu.dll")
int u_strspn(const(ushort)* string, const(ushort)* matchSet);

@DllImport("icu.dll")
ushort* u_strtok_r(ushort* src, const(ushort)* delim, ushort** saveState);

@DllImport("icu.dll")
int u_strcmp(const(ushort)* s1, const(ushort)* s2);

@DllImport("icu.dll")
int u_strcmpCodePointOrder(const(ushort)* s1, const(ushort)* s2);

@DllImport("icu.dll")
int u_strCompare(const(ushort)* s1, int length1, const(ushort)* s2, int length2, byte codePointOrder);

@DllImport("icu.dll")
int u_strCompareIter(UCharIterator* iter1, UCharIterator* iter2, byte codePointOrder);

@DllImport("icu.dll")
int u_strCaseCompare(const(ushort)* s1, int length1, const(ushort)* s2, int length2, uint options, UErrorCode* pErrorCode);

@DllImport("icu.dll")
int u_strncmp(const(ushort)* ucs1, const(ushort)* ucs2, int n);

@DllImport("icu.dll")
int u_strncmpCodePointOrder(const(ushort)* s1, const(ushort)* s2, int n);

@DllImport("icu.dll")
int u_strcasecmp(const(ushort)* s1, const(ushort)* s2, uint options);

@DllImport("icu.dll")
int u_strncasecmp(const(ushort)* s1, const(ushort)* s2, int n, uint options);

@DllImport("icu.dll")
int u_memcasecmp(const(ushort)* s1, const(ushort)* s2, int length, uint options);

@DllImport("icu.dll")
ushort* u_strcpy(ushort* dst, const(ushort)* src);

@DllImport("icu.dll")
ushort* u_strncpy(ushort* dst, const(ushort)* src, int n);

@DllImport("icu.dll")
ushort* u_uastrcpy(ushort* dst, const(byte)* src);

@DllImport("icu.dll")
ushort* u_uastrncpy(ushort* dst, const(byte)* src, int n);

@DllImport("icu.dll")
byte* u_austrcpy(byte* dst, const(ushort)* src);

@DllImport("icu.dll")
byte* u_austrncpy(byte* dst, const(ushort)* src, int n);

@DllImport("icu.dll")
ushort* u_memcpy(ushort* dest, const(ushort)* src, int count);

@DllImport("icu.dll")
ushort* u_memmove(ushort* dest, const(ushort)* src, int count);

@DllImport("icu.dll")
ushort* u_memset(ushort* dest, ushort c, int count);

@DllImport("icu.dll")
int u_memcmp(const(ushort)* buf1, const(ushort)* buf2, int count);

@DllImport("icu.dll")
int u_memcmpCodePointOrder(const(ushort)* s1, const(ushort)* s2, int count);

@DllImport("icu.dll")
ushort* u_memchr(const(ushort)* s, ushort c, int count);

@DllImport("icu.dll")
ushort* u_memchr32(const(ushort)* s, int c, int count);

@DllImport("icu.dll")
ushort* u_memrchr(const(ushort)* s, ushort c, int count);

@DllImport("icu.dll")
ushort* u_memrchr32(const(ushort)* s, int c, int count);

@DllImport("icu.dll")
int u_unescape(const(byte)* src, ushort* dest, int destCapacity);

@DllImport("icu.dll")
int u_unescapeAt(UNESCAPE_CHAR_AT charAt, int* offset, int length, void* context);

@DllImport("icu.dll")
int u_strToUpper(ushort* dest, int destCapacity, const(ushort)* src, int srcLength, const(byte)* locale, UErrorCode* pErrorCode);

@DllImport("icu.dll")
int u_strToLower(ushort* dest, int destCapacity, const(ushort)* src, int srcLength, const(byte)* locale, UErrorCode* pErrorCode);

@DllImport("icu.dll")
int u_strToTitle(ushort* dest, int destCapacity, const(ushort)* src, int srcLength, UBreakIterator* titleIter, const(byte)* locale, UErrorCode* pErrorCode);

@DllImport("icu.dll")
int u_strFoldCase(ushort* dest, int destCapacity, const(ushort)* src, int srcLength, uint options, UErrorCode* pErrorCode);

@DllImport("icu.dll")
ushort* u_strToWCS(ushort* dest, int destCapacity, int* pDestLength, const(ushort)* src, int srcLength, UErrorCode* pErrorCode);

@DllImport("icu.dll")
ushort* u_strFromWCS(ushort* dest, int destCapacity, int* pDestLength, const(ushort)* src, int srcLength, UErrorCode* pErrorCode);

@DllImport("icu.dll")
byte* u_strToUTF8(byte* dest, int destCapacity, int* pDestLength, const(ushort)* src, int srcLength, UErrorCode* pErrorCode);

@DllImport("icu.dll")
ushort* u_strFromUTF8(ushort* dest, int destCapacity, int* pDestLength, const(byte)* src, int srcLength, UErrorCode* pErrorCode);

@DllImport("icu.dll")
byte* u_strToUTF8WithSub(byte* dest, int destCapacity, int* pDestLength, const(ushort)* src, int srcLength, int subchar, int* pNumSubstitutions, UErrorCode* pErrorCode);

@DllImport("icu.dll")
ushort* u_strFromUTF8WithSub(ushort* dest, int destCapacity, int* pDestLength, const(byte)* src, int srcLength, int subchar, int* pNumSubstitutions, UErrorCode* pErrorCode);

@DllImport("icu.dll")
ushort* u_strFromUTF8Lenient(ushort* dest, int destCapacity, int* pDestLength, const(byte)* src, int srcLength, UErrorCode* pErrorCode);

@DllImport("icu.dll")
int* u_strToUTF32(int* dest, int destCapacity, int* pDestLength, const(ushort)* src, int srcLength, UErrorCode* pErrorCode);

@DllImport("icu.dll")
ushort* u_strFromUTF32(ushort* dest, int destCapacity, int* pDestLength, const(int)* src, int srcLength, UErrorCode* pErrorCode);

@DllImport("icu.dll")
int* u_strToUTF32WithSub(int* dest, int destCapacity, int* pDestLength, const(ushort)* src, int srcLength, int subchar, int* pNumSubstitutions, UErrorCode* pErrorCode);

@DllImport("icu.dll")
ushort* u_strFromUTF32WithSub(ushort* dest, int destCapacity, int* pDestLength, const(int)* src, int srcLength, int subchar, int* pNumSubstitutions, UErrorCode* pErrorCode);

@DllImport("icu.dll")
byte* u_strToJavaModifiedUTF8(byte* dest, int destCapacity, int* pDestLength, const(ushort)* src, int srcLength, UErrorCode* pErrorCode);

@DllImport("icu.dll")
ushort* u_strFromJavaModifiedUTF8WithSub(ushort* dest, int destCapacity, int* pDestLength, const(byte)* src, int srcLength, int subchar, int* pNumSubstitutions, UErrorCode* pErrorCode);

@DllImport("icu.dll")
UCaseMap* ucasemap_open(const(byte)* locale, uint options, UErrorCode* pErrorCode);

@DllImport("icu.dll")
void ucasemap_close(UCaseMap* csm);

@DllImport("icu.dll")
byte* ucasemap_getLocale(const(UCaseMap)* csm);

@DllImport("icu.dll")
uint ucasemap_getOptions(const(UCaseMap)* csm);

@DllImport("icu.dll")
void ucasemap_setLocale(UCaseMap* csm, const(byte)* locale, UErrorCode* pErrorCode);

@DllImport("icu.dll")
void ucasemap_setOptions(UCaseMap* csm, uint options, UErrorCode* pErrorCode);

@DllImport("icu.dll")
UBreakIterator* ucasemap_getBreakIterator(const(UCaseMap)* csm);

@DllImport("icu.dll")
void ucasemap_setBreakIterator(UCaseMap* csm, UBreakIterator* iterToAdopt, UErrorCode* pErrorCode);

@DllImport("icu.dll")
int ucasemap_toTitle(UCaseMap* csm, ushort* dest, int destCapacity, const(ushort)* src, int srcLength, UErrorCode* pErrorCode);

@DllImport("icu.dll")
int ucasemap_utf8ToLower(const(UCaseMap)* csm, byte* dest, int destCapacity, const(byte)* src, int srcLength, UErrorCode* pErrorCode);

@DllImport("icu.dll")
int ucasemap_utf8ToUpper(const(UCaseMap)* csm, byte* dest, int destCapacity, const(byte)* src, int srcLength, UErrorCode* pErrorCode);

@DllImport("icu.dll")
int ucasemap_utf8ToTitle(UCaseMap* csm, byte* dest, int destCapacity, const(byte)* src, int srcLength, UErrorCode* pErrorCode);

@DllImport("icu.dll")
int ucasemap_utf8FoldCase(const(UCaseMap)* csm, byte* dest, int destCapacity, const(byte)* src, int srcLength, UErrorCode* pErrorCode);

@DllImport("icu.dll")
UStringPrepProfile* usprep_open(const(byte)* path, const(byte)* fileName, UErrorCode* status);

@DllImport("icu.dll")
UStringPrepProfile* usprep_openByType(UStringPrepProfileType type, UErrorCode* status);

@DllImport("icu.dll")
void usprep_close(UStringPrepProfile* profile);

@DllImport("icu.dll")
int usprep_prepare(const(UStringPrepProfile)* prep, const(ushort)* src, int srcLength, ushort* dest, int destCapacity, int options, UParseError* parseError, UErrorCode* status);

@DllImport("icu.dll")
UIDNA* uidna_openUTS46(uint options, UErrorCode* pErrorCode);

@DllImport("icu.dll")
void uidna_close(UIDNA* idna);

@DllImport("icu.dll")
int uidna_labelToASCII(const(UIDNA)* idna, const(ushort)* label, int length, ushort* dest, int capacity, UIDNAInfo* pInfo, UErrorCode* pErrorCode);

@DllImport("icu.dll")
int uidna_labelToUnicode(const(UIDNA)* idna, const(ushort)* label, int length, ushort* dest, int capacity, UIDNAInfo* pInfo, UErrorCode* pErrorCode);

@DllImport("icu.dll")
int uidna_nameToASCII(const(UIDNA)* idna, const(ushort)* name, int length, ushort* dest, int capacity, UIDNAInfo* pInfo, UErrorCode* pErrorCode);

@DllImport("icu.dll")
int uidna_nameToUnicode(const(UIDNA)* idna, const(ushort)* name, int length, ushort* dest, int capacity, UIDNAInfo* pInfo, UErrorCode* pErrorCode);

@DllImport("icu.dll")
int uidna_labelToASCII_UTF8(const(UIDNA)* idna, const(byte)* label, int length, byte* dest, int capacity, UIDNAInfo* pInfo, UErrorCode* pErrorCode);

@DllImport("icu.dll")
int uidna_labelToUnicodeUTF8(const(UIDNA)* idna, const(byte)* label, int length, byte* dest, int capacity, UIDNAInfo* pInfo, UErrorCode* pErrorCode);

@DllImport("icu.dll")
int uidna_nameToASCII_UTF8(const(UIDNA)* idna, const(byte)* name, int length, byte* dest, int capacity, UIDNAInfo* pInfo, UErrorCode* pErrorCode);

@DllImport("icu.dll")
int uidna_nameToUnicodeUTF8(const(UIDNA)* idna, const(byte)* name, int length, byte* dest, int capacity, UIDNAInfo* pInfo, UErrorCode* pErrorCode);

@DllImport("icu.dll")
UBreakIterator* ubrk_open(UBreakIteratorType type, const(byte)* locale, const(ushort)* text, int textLength, UErrorCode* status);

@DllImport("icu.dll")
UBreakIterator* ubrk_openRules(const(ushort)* rules, int rulesLength, const(ushort)* text, int textLength, UParseError* parseErr, UErrorCode* status);

@DllImport("icu.dll")
UBreakIterator* ubrk_openBinaryRules(const(ubyte)* binaryRules, int rulesLength, const(ushort)* text, int textLength, UErrorCode* status);

@DllImport("icu.dll")
UBreakIterator* ubrk_safeClone(const(UBreakIterator)* bi, void* stackBuffer, int* pBufferSize, UErrorCode* status);

@DllImport("icu.dll")
void ubrk_close(UBreakIterator* bi);

@DllImport("icu.dll")
void ubrk_setText(UBreakIterator* bi, const(ushort)* text, int textLength, UErrorCode* status);

@DllImport("icu.dll")
void ubrk_setUText(UBreakIterator* bi, UText* text, UErrorCode* status);

@DllImport("icu.dll")
int ubrk_current(const(UBreakIterator)* bi);

@DllImport("icu.dll")
int ubrk_next(UBreakIterator* bi);

@DllImport("icu.dll")
int ubrk_previous(UBreakIterator* bi);

@DllImport("icu.dll")
int ubrk_first(UBreakIterator* bi);

@DllImport("icu.dll")
int ubrk_last(UBreakIterator* bi);

@DllImport("icu.dll")
int ubrk_preceding(UBreakIterator* bi, int offset);

@DllImport("icu.dll")
int ubrk_following(UBreakIterator* bi, int offset);

@DllImport("icu.dll")
byte* ubrk_getAvailable(int index);

@DllImport("icu.dll")
int ubrk_countAvailable();

@DllImport("icu.dll")
byte ubrk_isBoundary(UBreakIterator* bi, int offset);

@DllImport("icu.dll")
int ubrk_getRuleStatus(UBreakIterator* bi);

@DllImport("icu.dll")
int ubrk_getRuleStatusVec(UBreakIterator* bi, int* fillInVec, int capacity, UErrorCode* status);

@DllImport("icu.dll")
byte* ubrk_getLocaleByType(const(UBreakIterator)* bi, ULocDataLocaleType type, UErrorCode* status);

@DllImport("icu.dll")
void ubrk_refreshUText(UBreakIterator* bi, UText* text, UErrorCode* status);

@DllImport("icu.dll")
int ubrk_getBinaryRules(UBreakIterator* bi, ubyte* binaryRules, int rulesCapacity, UErrorCode* status);

@DllImport("icu.dll")
void u_getDataVersion(ubyte* dataVersionFillin, UErrorCode* status);

@DllImport("icu.dll")
UEnumeration* ucal_openTimeZoneIDEnumeration(USystemTimeZoneType zoneType, const(byte)* region, const(int)* rawOffset, UErrorCode* ec);

@DllImport("icu.dll")
UEnumeration* ucal_openTimeZones(UErrorCode* ec);

@DllImport("icu.dll")
UEnumeration* ucal_openCountryTimeZones(const(byte)* country, UErrorCode* ec);

@DllImport("icu.dll")
int ucal_getDefaultTimeZone(ushort* result, int resultCapacity, UErrorCode* ec);

@DllImport("icu.dll")
void ucal_setDefaultTimeZone(const(ushort)* zoneID, UErrorCode* ec);

@DllImport("icu.dll")
int ucal_getDSTSavings(const(ushort)* zoneID, UErrorCode* ec);

@DllImport("icu.dll")
double ucal_getNow();

@DllImport("icu.dll")
void** ucal_open(const(ushort)* zoneID, int len, const(byte)* locale, UCalendarType type, UErrorCode* status);

@DllImport("icu.dll")
void ucal_close(void** cal);

@DllImport("icu.dll")
void** ucal_clone(const(void)** cal, UErrorCode* status);

@DllImport("icu.dll")
void ucal_setTimeZone(void** cal, const(ushort)* zoneID, int len, UErrorCode* status);

@DllImport("icu.dll")
int ucal_getTimeZoneID(const(void)** cal, ushort* result, int resultLength, UErrorCode* status);

@DllImport("icu.dll")
int ucal_getTimeZoneDisplayName(const(void)** cal, UCalendarDisplayNameType type, const(byte)* locale, ushort* result, int resultLength, UErrorCode* status);

@DllImport("icu.dll")
byte ucal_inDaylightTime(const(void)** cal, UErrorCode* status);

@DllImport("icu.dll")
void ucal_setGregorianChange(void** cal, double date, UErrorCode* pErrorCode);

@DllImport("icu.dll")
double ucal_getGregorianChange(const(void)** cal, UErrorCode* pErrorCode);

@DllImport("icu.dll")
int ucal_getAttribute(const(void)** cal, UCalendarAttribute attr);

@DllImport("icu.dll")
void ucal_setAttribute(void** cal, UCalendarAttribute attr, int newValue);

@DllImport("icu.dll")
byte* ucal_getAvailable(int localeIndex);

@DllImport("icu.dll")
int ucal_countAvailable();

@DllImport("icu.dll")
double ucal_getMillis(const(void)** cal, UErrorCode* status);

@DllImport("icu.dll")
void ucal_setMillis(void** cal, double dateTime, UErrorCode* status);

@DllImport("icu.dll")
void ucal_setDate(void** cal, int year, int month, int date, UErrorCode* status);

@DllImport("icu.dll")
void ucal_setDateTime(void** cal, int year, int month, int date, int hour, int minute, int second, UErrorCode* status);

@DllImport("icu.dll")
byte ucal_equivalentTo(const(void)** cal1, const(void)** cal2);

@DllImport("icu.dll")
void ucal_add(void** cal, UCalendarDateFields field, int amount, UErrorCode* status);

@DllImport("icu.dll")
void ucal_roll(void** cal, UCalendarDateFields field, int amount, UErrorCode* status);

@DllImport("icu.dll")
int ucal_get(const(void)** cal, UCalendarDateFields field, UErrorCode* status);

@DllImport("icu.dll")
void ucal_set(void** cal, UCalendarDateFields field, int value);

@DllImport("icu.dll")
byte ucal_isSet(const(void)** cal, UCalendarDateFields field);

@DllImport("icu.dll")
void ucal_clearField(void** cal, UCalendarDateFields field);

@DllImport("icu.dll")
void ucal_clear(void** calendar);

@DllImport("icu.dll")
int ucal_getLimit(const(void)** cal, UCalendarDateFields field, UCalendarLimitType type, UErrorCode* status);

@DllImport("icu.dll")
byte* ucal_getLocaleByType(const(void)** cal, ULocDataLocaleType type, UErrorCode* status);

@DllImport("icu.dll")
byte* ucal_getTZDataVersion(UErrorCode* status);

@DllImport("icu.dll")
int ucal_getCanonicalTimeZoneID(const(ushort)* id, int len, ushort* result, int resultCapacity, byte* isSystemID, UErrorCode* status);

@DllImport("icu.dll")
byte* ucal_getType(const(void)** cal, UErrorCode* status);

@DllImport("icu.dll")
UEnumeration* ucal_getKeywordValuesForLocale(const(byte)* key, const(byte)* locale, byte commonlyUsed, UErrorCode* status);

@DllImport("icu.dll")
UCalendarWeekdayType ucal_getDayOfWeekType(const(void)** cal, UCalendarDaysOfWeek dayOfWeek, UErrorCode* status);

@DllImport("icu.dll")
int ucal_getWeekendTransition(const(void)** cal, UCalendarDaysOfWeek dayOfWeek, UErrorCode* status);

@DllImport("icu.dll")
byte ucal_isWeekend(const(void)** cal, double date, UErrorCode* status);

@DllImport("icu.dll")
int ucal_getFieldDifference(void** cal, double target, UCalendarDateFields field, UErrorCode* status);

@DllImport("icu.dll")
byte ucal_getTimeZoneTransitionDate(const(void)** cal, UTimeZoneTransitionType type, double* transition, UErrorCode* status);

@DllImport("icu.dll")
int ucal_getWindowsTimeZoneID(const(ushort)* id, int len, ushort* winid, int winidCapacity, UErrorCode* status);

@DllImport("icu.dll")
int ucal_getTimeZoneIDForWindowsID(const(ushort)* winid, int len, const(byte)* region, ushort* id, int idCapacity, UErrorCode* status);

@DllImport("icu.dll")
UCollator* ucol_open(const(byte)* loc, UErrorCode* status);

@DllImport("icu.dll")
UCollator* ucol_openRules(const(ushort)* rules, int rulesLength, UColAttributeValue normalizationMode, UColAttributeValue strength, UParseError* parseError, UErrorCode* status);

@DllImport("icu.dll")
void ucol_getContractionsAndExpansions(const(UCollator)* coll, USet* contractions, USet* expansions, byte addPrefixes, UErrorCode* status);

@DllImport("icu.dll")
void ucol_close(UCollator* coll);

@DllImport("icu.dll")
UCollationResult ucol_strcoll(const(UCollator)* coll, const(ushort)* source, int sourceLength, const(ushort)* target, int targetLength);

@DllImport("icu.dll")
UCollationResult ucol_strcollUTF8(const(UCollator)* coll, const(byte)* source, int sourceLength, const(byte)* target, int targetLength, UErrorCode* status);

@DllImport("icu.dll")
byte ucol_greater(const(UCollator)* coll, const(ushort)* source, int sourceLength, const(ushort)* target, int targetLength);

@DllImport("icu.dll")
byte ucol_greaterOrEqual(const(UCollator)* coll, const(ushort)* source, int sourceLength, const(ushort)* target, int targetLength);

@DllImport("icu.dll")
byte ucol_equal(const(UCollator)* coll, const(ushort)* source, int sourceLength, const(ushort)* target, int targetLength);

@DllImport("icu.dll")
UCollationResult ucol_strcollIter(const(UCollator)* coll, UCharIterator* sIter, UCharIterator* tIter, UErrorCode* status);

@DllImport("icu.dll")
UColAttributeValue ucol_getStrength(const(UCollator)* coll);

@DllImport("icu.dll")
void ucol_setStrength(UCollator* coll, UColAttributeValue strength);

@DllImport("icu.dll")
int ucol_getReorderCodes(const(UCollator)* coll, int* dest, int destCapacity, UErrorCode* pErrorCode);

@DllImport("icu.dll")
void ucol_setReorderCodes(UCollator* coll, const(int)* reorderCodes, int reorderCodesLength, UErrorCode* pErrorCode);

@DllImport("icu.dll")
int ucol_getEquivalentReorderCodes(int reorderCode, int* dest, int destCapacity, UErrorCode* pErrorCode);

@DllImport("icu.dll")
int ucol_getDisplayName(const(byte)* objLoc, const(byte)* dispLoc, ushort* result, int resultLength, UErrorCode* status);

@DllImport("icu.dll")
byte* ucol_getAvailable(int localeIndex);

@DllImport("icu.dll")
int ucol_countAvailable();

@DllImport("icu.dll")
UEnumeration* ucol_openAvailableLocales(UErrorCode* status);

@DllImport("icu.dll")
UEnumeration* ucol_getKeywords(UErrorCode* status);

@DllImport("icu.dll")
UEnumeration* ucol_getKeywordValues(const(byte)* keyword, UErrorCode* status);

@DllImport("icu.dll")
UEnumeration* ucol_getKeywordValuesForLocale(const(byte)* key, const(byte)* locale, byte commonlyUsed, UErrorCode* status);

@DllImport("icu.dll")
int ucol_getFunctionalEquivalent(byte* result, int resultCapacity, const(byte)* keyword, const(byte)* locale, byte* isAvailable, UErrorCode* status);

@DllImport("icu.dll")
ushort* ucol_getRules(const(UCollator)* coll, int* length);

@DllImport("icu.dll")
int ucol_getSortKey(const(UCollator)* coll, const(ushort)* source, int sourceLength, ubyte* result, int resultLength);

@DllImport("icu.dll")
int ucol_nextSortKeyPart(const(UCollator)* coll, UCharIterator* iter, uint* state, ubyte* dest, int count, UErrorCode* status);

@DllImport("icu.dll")
int ucol_getBound(const(ubyte)* source, int sourceLength, UColBoundMode boundType, uint noOfLevels, ubyte* result, int resultLength, UErrorCode* status);

@DllImport("icu.dll")
void ucol_getVersion(const(UCollator)* coll, ubyte* info);

@DllImport("icu.dll")
void ucol_getUCAVersion(const(UCollator)* coll, ubyte* info);

@DllImport("icu.dll")
int ucol_mergeSortkeys(const(ubyte)* src1, int src1Length, const(ubyte)* src2, int src2Length, ubyte* dest, int destCapacity);

@DllImport("icu.dll")
void ucol_setAttribute(UCollator* coll, UColAttribute attr, UColAttributeValue value, UErrorCode* status);

@DllImport("icu.dll")
UColAttributeValue ucol_getAttribute(const(UCollator)* coll, UColAttribute attr, UErrorCode* status);

@DllImport("icu.dll")
void ucol_setMaxVariable(UCollator* coll, UColReorderCode group, UErrorCode* pErrorCode);

@DllImport("icu.dll")
UColReorderCode ucol_getMaxVariable(const(UCollator)* coll);

@DllImport("icu.dll")
uint ucol_getVariableTop(const(UCollator)* coll, UErrorCode* status);

@DllImport("icu.dll")
UCollator* ucol_safeClone(const(UCollator)* coll, void* stackBuffer, int* pBufferSize, UErrorCode* status);

@DllImport("icu.dll")
int ucol_getRulesEx(const(UCollator)* coll, UColRuleOption delta, ushort* buffer, int bufferLen);

@DllImport("icu.dll")
byte* ucol_getLocaleByType(const(UCollator)* coll, ULocDataLocaleType type, UErrorCode* status);

@DllImport("icu.dll")
USet* ucol_getTailoredSet(const(UCollator)* coll, UErrorCode* status);

@DllImport("icu.dll")
int ucol_cloneBinary(const(UCollator)* coll, ubyte* buffer, int capacity, UErrorCode* status);

@DllImport("icu.dll")
UCollator* ucol_openBinary(const(ubyte)* bin, int length, const(UCollator)* base, UErrorCode* status);

@DllImport("icu.dll")
UCollationElements* ucol_openElements(const(UCollator)* coll, const(ushort)* text, int textLength, UErrorCode* status);

@DllImport("icu.dll")
int ucol_keyHashCode(const(ubyte)* key, int length);

@DllImport("icu.dll")
void ucol_closeElements(UCollationElements* elems);

@DllImport("icu.dll")
void ucol_reset(UCollationElements* elems);

@DllImport("icu.dll")
int ucol_next(UCollationElements* elems, UErrorCode* status);

@DllImport("icu.dll")
int ucol_previous(UCollationElements* elems, UErrorCode* status);

@DllImport("icu.dll")
int ucol_getMaxExpansion(const(UCollationElements)* elems, int order);

@DllImport("icu.dll")
void ucol_setText(UCollationElements* elems, const(ushort)* text, int textLength, UErrorCode* status);

@DllImport("icu.dll")
int ucol_getOffset(const(UCollationElements)* elems);

@DllImport("icu.dll")
void ucol_setOffset(UCollationElements* elems, int offset, UErrorCode* status);

@DllImport("icu.dll")
int ucol_primaryOrder(int order);

@DllImport("icu.dll")
int ucol_secondaryOrder(int order);

@DllImport("icu.dll")
int ucol_tertiaryOrder(int order);

@DllImport("icu.dll")
UCharsetDetector* ucsdet_open(UErrorCode* status);

@DllImport("icu.dll")
void ucsdet_close(UCharsetDetector* ucsd);

@DllImport("icu.dll")
void ucsdet_setText(UCharsetDetector* ucsd, const(byte)* textIn, int len, UErrorCode* status);

@DllImport("icu.dll")
void ucsdet_setDeclaredEncoding(UCharsetDetector* ucsd, const(byte)* encoding, int length, UErrorCode* status);

@DllImport("icu.dll")
UCharsetMatch* ucsdet_detect(UCharsetDetector* ucsd, UErrorCode* status);

@DllImport("icu.dll")
UCharsetMatch** ucsdet_detectAll(UCharsetDetector* ucsd, int* matchesFound, UErrorCode* status);

@DllImport("icu.dll")
byte* ucsdet_getName(const(UCharsetMatch)* ucsm, UErrorCode* status);

@DllImport("icu.dll")
int ucsdet_getConfidence(const(UCharsetMatch)* ucsm, UErrorCode* status);

@DllImport("icu.dll")
byte* ucsdet_getLanguage(const(UCharsetMatch)* ucsm, UErrorCode* status);

@DllImport("icu.dll")
int ucsdet_getUChars(const(UCharsetMatch)* ucsm, ushort* buf, int cap, UErrorCode* status);

@DllImport("icu.dll")
UEnumeration* ucsdet_getAllDetectableCharsets(const(UCharsetDetector)* ucsd, UErrorCode* status);

@DllImport("icu.dll")
byte ucsdet_isInputFilterEnabled(const(UCharsetDetector)* ucsd);

@DllImport("icu.dll")
byte ucsdet_enableInputFilter(UCharsetDetector* ucsd, byte filter);

@DllImport("icu.dll")
void** udatpg_open(const(byte)* locale, UErrorCode* pErrorCode);

@DllImport("icu.dll")
void** udatpg_openEmpty(UErrorCode* pErrorCode);

@DllImport("icu.dll")
void udatpg_close(void** dtpg);

@DllImport("icu.dll")
void** udatpg_clone(const(void)** dtpg, UErrorCode* pErrorCode);

@DllImport("icu.dll")
int udatpg_getBestPattern(void** dtpg, const(ushort)* skeleton, int length, ushort* bestPattern, int capacity, UErrorCode* pErrorCode);

@DllImport("icu.dll")
int udatpg_getBestPatternWithOptions(void** dtpg, const(ushort)* skeleton, int length, UDateTimePatternMatchOptions options, ushort* bestPattern, int capacity, UErrorCode* pErrorCode);

@DllImport("icu.dll")
int udatpg_getSkeleton(void** unusedDtpg, const(ushort)* pattern, int length, ushort* skeleton, int capacity, UErrorCode* pErrorCode);

@DllImport("icu.dll")
int udatpg_getBaseSkeleton(void** unusedDtpg, const(ushort)* pattern, int length, ushort* baseSkeleton, int capacity, UErrorCode* pErrorCode);

@DllImport("icu.dll")
UDateTimePatternConflict udatpg_addPattern(void** dtpg, const(ushort)* pattern, int patternLength, byte override, ushort* conflictingPattern, int capacity, int* pLength, UErrorCode* pErrorCode);

@DllImport("icu.dll")
void udatpg_setAppendItemFormat(void** dtpg, UDateTimePatternField field, const(ushort)* value, int length);

@DllImport("icu.dll")
ushort* udatpg_getAppendItemFormat(const(void)** dtpg, UDateTimePatternField field, int* pLength);

@DllImport("icu.dll")
void udatpg_setAppendItemName(void** dtpg, UDateTimePatternField field, const(ushort)* value, int length);

@DllImport("icu.dll")
ushort* udatpg_getAppendItemName(const(void)** dtpg, UDateTimePatternField field, int* pLength);

@DllImport("icu.dll")
int udatpg_getFieldDisplayName(const(void)** dtpg, UDateTimePatternField field, UDateTimePGDisplayWidth width, ushort* fieldName, int capacity, UErrorCode* pErrorCode);

@DllImport("icu.dll")
void udatpg_setDateTimeFormat(const(void)** dtpg, const(ushort)* dtFormat, int length);

@DllImport("icu.dll")
ushort* udatpg_getDateTimeFormat(const(void)** dtpg, int* pLength);

@DllImport("icu.dll")
void udatpg_setDecimal(void** dtpg, const(ushort)* decimal, int length);

@DllImport("icu.dll")
ushort* udatpg_getDecimal(const(void)** dtpg, int* pLength);

@DllImport("icu.dll")
int udatpg_replaceFieldTypes(void** dtpg, const(ushort)* pattern, int patternLength, const(ushort)* skeleton, int skeletonLength, ushort* dest, int destCapacity, UErrorCode* pErrorCode);

@DllImport("icu.dll")
int udatpg_replaceFieldTypesWithOptions(void** dtpg, const(ushort)* pattern, int patternLength, const(ushort)* skeleton, int skeletonLength, UDateTimePatternMatchOptions options, ushort* dest, int destCapacity, UErrorCode* pErrorCode);

@DllImport("icu.dll")
UEnumeration* udatpg_openSkeletons(const(void)** dtpg, UErrorCode* pErrorCode);

@DllImport("icu.dll")
UEnumeration* udatpg_openBaseSkeletons(const(void)** dtpg, UErrorCode* pErrorCode);

@DllImport("icu.dll")
ushort* udatpg_getPatternForSkeleton(const(void)** dtpg, const(ushort)* skeleton, int skeletonLength, int* pLength);

@DllImport("icu.dll")
UFieldPositionIterator* ufieldpositer_open(UErrorCode* status);

@DllImport("icu.dll")
void ufieldpositer_close(UFieldPositionIterator* fpositer);

@DllImport("icu.dll")
int ufieldpositer_next(UFieldPositionIterator* fpositer, int* beginIndex, int* endIndex);

@DllImport("icu.dll")
void** ufmt_open(UErrorCode* status);

@DllImport("icu.dll")
void ufmt_close(void** fmt);

@DllImport("icu.dll")
UFormattableType ufmt_getType(const(void)** fmt, UErrorCode* status);

@DllImport("icu.dll")
byte ufmt_isNumeric(const(void)** fmt);

@DllImport("icu.dll")
double ufmt_getDate(const(void)** fmt, UErrorCode* status);

@DllImport("icu.dll")
double ufmt_getDouble(void** fmt, UErrorCode* status);

@DllImport("icu.dll")
int ufmt_getLong(void** fmt, UErrorCode* status);

@DllImport("icu.dll")
long ufmt_getInt64(void** fmt, UErrorCode* status);

@DllImport("icu.dll")
void* ufmt_getObject(const(void)** fmt, UErrorCode* status);

@DllImport("icu.dll")
ushort* ufmt_getUChars(void** fmt, int* len, UErrorCode* status);

@DllImport("icu.dll")
int ufmt_getArrayLength(const(void)** fmt, UErrorCode* status);

@DllImport("icu.dll")
void** ufmt_getArrayItemByIndex(void** fmt, int n, UErrorCode* status);

@DllImport("icu.dll")
byte* ufmt_getDecNumChars(void** fmt, int* len, UErrorCode* status);

@DllImport("icu.dll")
UDateIntervalFormat* udtitvfmt_open(const(byte)* locale, const(ushort)* skeleton, int skeletonLength, const(ushort)* tzID, int tzIDLength, UErrorCode* status);

@DllImport("icu.dll")
void udtitvfmt_close(UDateIntervalFormat* formatter);

@DllImport("icu.dll")
int udtitvfmt_format(const(UDateIntervalFormat)* formatter, double fromDate, double toDate, ushort* result, int resultCapacity, UFieldPosition* position, UErrorCode* status);

@DllImport("icu.dll")
UGenderInfo* ugender_getInstance(const(byte)* locale, UErrorCode* status);

@DllImport("icu.dll")
UGender ugender_getListGender(const(UGenderInfo)* genderInfo, const(UGender)* genders, int size, UErrorCode* status);

@DllImport("icu.dll")
UListFormatter* ulistfmt_open(const(byte)* locale, UErrorCode* status);

@DllImport("icu.dll")
void ulistfmt_close(UListFormatter* listfmt);

@DllImport("icu.dll")
int ulistfmt_format(const(UListFormatter)* listfmt, const(ushort)** strings, const(int)* stringLengths, int stringCount, ushort* result, int resultCapacity, UErrorCode* status);

@DllImport("icu.dll")
ULocaleData* ulocdata_open(const(byte)* localeID, UErrorCode* status);

@DllImport("icu.dll")
void ulocdata_close(ULocaleData* uld);

@DllImport("icu.dll")
void ulocdata_setNoSubstitute(ULocaleData* uld, byte setting);

@DllImport("icu.dll")
byte ulocdata_getNoSubstitute(ULocaleData* uld);

@DllImport("icu.dll")
USet* ulocdata_getExemplarSet(ULocaleData* uld, USet* fillIn, uint options, ULocaleDataExemplarSetType extype, UErrorCode* status);

@DllImport("icu.dll")
int ulocdata_getDelimiter(ULocaleData* uld, ULocaleDataDelimiterType type, ushort* result, int resultLength, UErrorCode* status);

@DllImport("icu.dll")
UMeasurementSystem ulocdata_getMeasurementSystem(const(byte)* localeID, UErrorCode* status);

@DllImport("icu.dll")
void ulocdata_getPaperSize(const(byte)* localeID, int* height, int* width, UErrorCode* status);

@DllImport("icu.dll")
void ulocdata_getCLDRVersion(ubyte* versionArray, UErrorCode* status);

@DllImport("icu.dll")
int ulocdata_getLocaleDisplayPattern(ULocaleData* uld, ushort* pattern, int patternCapacity, UErrorCode* status);

@DllImport("icu.dll")
int ulocdata_getLocaleSeparator(ULocaleData* uld, ushort* separator, int separatorCapacity, UErrorCode* status);

@DllImport("icu.dll")
int u_formatMessage(const(byte)* locale, const(ushort)* pattern, int patternLength, ushort* result, int resultLength, UErrorCode* status);

@DllImport("icu.dll")
int u_vformatMessage(const(byte)* locale, const(ushort)* pattern, int patternLength, ushort* result, int resultLength, byte* ap, UErrorCode* status);

@DllImport("icu.dll")
void u_parseMessage(const(byte)* locale, const(ushort)* pattern, int patternLength, const(ushort)* source, int sourceLength, UErrorCode* status);

@DllImport("icu.dll")
void u_vparseMessage(const(byte)* locale, const(ushort)* pattern, int patternLength, const(ushort)* source, int sourceLength, byte* ap, UErrorCode* status);

@DllImport("icu.dll")
int u_formatMessageWithError(const(byte)* locale, const(ushort)* pattern, int patternLength, ushort* result, int resultLength, UParseError* parseError, UErrorCode* status);

@DllImport("icu.dll")
int u_vformatMessageWithError(const(byte)* locale, const(ushort)* pattern, int patternLength, ushort* result, int resultLength, UParseError* parseError, byte* ap, UErrorCode* status);

@DllImport("icu.dll")
void u_parseMessageWithError(const(byte)* locale, const(ushort)* pattern, int patternLength, const(ushort)* source, int sourceLength, UParseError* parseError, UErrorCode* status);

@DllImport("icu.dll")
void u_vparseMessageWithError(const(byte)* locale, const(ushort)* pattern, int patternLength, const(ushort)* source, int sourceLength, byte* ap, UParseError* parseError, UErrorCode* status);

@DllImport("icu.dll")
void** umsg_open(const(ushort)* pattern, int patternLength, const(byte)* locale, UParseError* parseError, UErrorCode* status);

@DllImport("icu.dll")
void umsg_close(void** format);

@DllImport("icu.dll")
void* umsg_clone(const(void)** fmt, UErrorCode* status);

@DllImport("icu.dll")
void umsg_setLocale(void** fmt, const(byte)* locale);

@DllImport("icu.dll")
byte* umsg_getLocale(const(void)** fmt);

@DllImport("icu.dll")
void umsg_applyPattern(void** fmt, const(ushort)* pattern, int patternLength, UParseError* parseError, UErrorCode* status);

@DllImport("icu.dll")
int umsg_toPattern(const(void)** fmt, ushort* result, int resultLength, UErrorCode* status);

@DllImport("icu.dll")
int umsg_format(const(void)** fmt, ushort* result, int resultLength, UErrorCode* status);

@DllImport("icu.dll")
int umsg_vformat(const(void)** fmt, ushort* result, int resultLength, byte* ap, UErrorCode* status);

@DllImport("icu.dll")
void umsg_parse(const(void)** fmt, const(ushort)* source, int sourceLength, int* count, UErrorCode* status);

@DllImport("icu.dll")
void umsg_vparse(const(void)** fmt, const(ushort)* source, int sourceLength, int* count, byte* ap, UErrorCode* status);

@DllImport("icu.dll")
int umsg_autoQuoteApostrophe(const(ushort)* pattern, int patternLength, ushort* dest, int destCapacity, UErrorCode* ec);

@DllImport("icu.dll")
void** unum_open(UNumberFormatStyle style, const(ushort)* pattern, int patternLength, const(byte)* locale, UParseError* parseErr, UErrorCode* status);

@DllImport("icu.dll")
void unum_close(void** fmt);

@DllImport("icu.dll")
void** unum_clone(const(void)** fmt, UErrorCode* status);

@DllImport("icu.dll")
int unum_format(const(void)** fmt, int number, ushort* result, int resultLength, UFieldPosition* pos, UErrorCode* status);

@DllImport("icu.dll")
int unum_formatInt64(const(void)** fmt, long number, ushort* result, int resultLength, UFieldPosition* pos, UErrorCode* status);

@DllImport("icu.dll")
int unum_formatDouble(const(void)** fmt, double number, ushort* result, int resultLength, UFieldPosition* pos, UErrorCode* status);

@DllImport("icu.dll")
int unum_formatDoubleForFields(const(void)** format, double number, ushort* result, int resultLength, UFieldPositionIterator* fpositer, UErrorCode* status);

@DllImport("icu.dll")
int unum_formatDecimal(const(void)** fmt, const(byte)* number, int length, ushort* result, int resultLength, UFieldPosition* pos, UErrorCode* status);

@DllImport("icu.dll")
int unum_formatDoubleCurrency(const(void)** fmt, double number, ushort* currency, ushort* result, int resultLength, UFieldPosition* pos, UErrorCode* status);

@DllImport("icu.dll")
int unum_formatUFormattable(const(void)** fmt, const(void)** number, ushort* result, int resultLength, UFieldPosition* pos, UErrorCode* status);

@DllImport("icu.dll")
int unum_parse(const(void)** fmt, const(ushort)* text, int textLength, int* parsePos, UErrorCode* status);

@DllImport("icu.dll")
long unum_parseInt64(const(void)** fmt, const(ushort)* text, int textLength, int* parsePos, UErrorCode* status);

@DllImport("icu.dll")
double unum_parseDouble(const(void)** fmt, const(ushort)* text, int textLength, int* parsePos, UErrorCode* status);

@DllImport("icu.dll")
int unum_parseDecimal(const(void)** fmt, const(ushort)* text, int textLength, int* parsePos, byte* outBuf, int outBufLength, UErrorCode* status);

@DllImport("icu.dll")
double unum_parseDoubleCurrency(const(void)** fmt, const(ushort)* text, int textLength, int* parsePos, ushort* currency, UErrorCode* status);

@DllImport("icu.dll")
void** unum_parseToUFormattable(const(void)** fmt, void** result, const(ushort)* text, int textLength, int* parsePos, UErrorCode* status);

@DllImport("icu.dll")
void unum_applyPattern(void** format, byte localized, const(ushort)* pattern, int patternLength, UParseError* parseError, UErrorCode* status);

@DllImport("icu.dll")
byte* unum_getAvailable(int localeIndex);

@DllImport("icu.dll")
int unum_countAvailable();

@DllImport("icu.dll")
int unum_getAttribute(const(void)** fmt, UNumberFormatAttribute attr);

@DllImport("icu.dll")
void unum_setAttribute(void** fmt, UNumberFormatAttribute attr, int newValue);

@DllImport("icu.dll")
double unum_getDoubleAttribute(const(void)** fmt, UNumberFormatAttribute attr);

@DllImport("icu.dll")
void unum_setDoubleAttribute(void** fmt, UNumberFormatAttribute attr, double newValue);

@DllImport("icu.dll")
int unum_getTextAttribute(const(void)** fmt, UNumberFormatTextAttribute tag, ushort* result, int resultLength, UErrorCode* status);

@DllImport("icu.dll")
void unum_setTextAttribute(void** fmt, UNumberFormatTextAttribute tag, const(ushort)* newValue, int newValueLength, UErrorCode* status);

@DllImport("icu.dll")
int unum_toPattern(const(void)** fmt, byte isPatternLocalized, ushort* result, int resultLength, UErrorCode* status);

@DllImport("icu.dll")
int unum_getSymbol(const(void)** fmt, UNumberFormatSymbol symbol, ushort* buffer, int size, UErrorCode* status);

@DllImport("icu.dll")
void unum_setSymbol(void** fmt, UNumberFormatSymbol symbol, const(ushort)* value, int length, UErrorCode* status);

@DllImport("icu.dll")
byte* unum_getLocaleByType(const(void)** fmt, ULocDataLocaleType type, UErrorCode* status);

@DllImport("icu.dll")
void unum_setContext(void** fmt, UDisplayContext value, UErrorCode* status);

@DllImport("icu.dll")
UDisplayContext unum_getContext(const(void)** fmt, UDisplayContextType type, UErrorCode* status);

@DllImport("icu.dll")
UCalendarDateFields udat_toCalendarDateField(UDateFormatField field);

@DllImport("icu.dll")
void** udat_open(UDateFormatStyle timeStyle, UDateFormatStyle dateStyle, const(byte)* locale, const(ushort)* tzID, int tzIDLength, const(ushort)* pattern, int patternLength, UErrorCode* status);

@DllImport("icu.dll")
void udat_close(void** format);

@DllImport("icu.dll")
byte udat_getBooleanAttribute(const(void)** fmt, UDateFormatBooleanAttribute attr, UErrorCode* status);

@DllImport("icu.dll")
void udat_setBooleanAttribute(void** fmt, UDateFormatBooleanAttribute attr, byte newValue, UErrorCode* status);

@DllImport("icu.dll")
void** udat_clone(const(void)** fmt, UErrorCode* status);

@DllImport("icu.dll")
int udat_format(const(void)** format, double dateToFormat, ushort* result, int resultLength, UFieldPosition* position, UErrorCode* status);

@DllImport("icu.dll")
int udat_formatCalendar(const(void)** format, void** calendar, ushort* result, int capacity, UFieldPosition* position, UErrorCode* status);

@DllImport("icu.dll")
int udat_formatForFields(const(void)** format, double dateToFormat, ushort* result, int resultLength, UFieldPositionIterator* fpositer, UErrorCode* status);

@DllImport("icu.dll")
int udat_formatCalendarForFields(const(void)** format, void** calendar, ushort* result, int capacity, UFieldPositionIterator* fpositer, UErrorCode* status);

@DllImport("icu.dll")
double udat_parse(const(void)** format, const(ushort)* text, int textLength, int* parsePos, UErrorCode* status);

@DllImport("icu.dll")
void udat_parseCalendar(const(void)** format, void** calendar, const(ushort)* text, int textLength, int* parsePos, UErrorCode* status);

@DllImport("icu.dll")
byte udat_isLenient(const(void)** fmt);

@DllImport("icu.dll")
void udat_setLenient(void** fmt, byte isLenient);

@DllImport("icu.dll")
void** udat_getCalendar(const(void)** fmt);

@DllImport("icu.dll")
void udat_setCalendar(void** fmt, const(void)** calendarToSet);

@DllImport("icu.dll")
void** udat_getNumberFormat(const(void)** fmt);

@DllImport("icu.dll")
void** udat_getNumberFormatForField(const(void)** fmt, ushort field);

@DllImport("icu.dll")
void udat_adoptNumberFormatForFields(void** fmt, const(ushort)* fields, void** numberFormatToSet, UErrorCode* status);

@DllImport("icu.dll")
void udat_setNumberFormat(void** fmt, const(void)** numberFormatToSet);

@DllImport("icu.dll")
void udat_adoptNumberFormat(void** fmt, void** numberFormatToAdopt);

@DllImport("icu.dll")
byte* udat_getAvailable(int localeIndex);

@DllImport("icu.dll")
int udat_countAvailable();

@DllImport("icu.dll")
double udat_get2DigitYearStart(const(void)** fmt, UErrorCode* status);

@DllImport("icu.dll")
void udat_set2DigitYearStart(void** fmt, double d, UErrorCode* status);

@DllImport("icu.dll")
int udat_toPattern(const(void)** fmt, byte localized, ushort* result, int resultLength, UErrorCode* status);

@DllImport("icu.dll")
void udat_applyPattern(void** format, byte localized, const(ushort)* pattern, int patternLength);

@DllImport("icu.dll")
int udat_getSymbols(const(void)** fmt, UDateFormatSymbolType type, int symbolIndex, ushort* result, int resultLength, UErrorCode* status);

@DllImport("icu.dll")
int udat_countSymbols(const(void)** fmt, UDateFormatSymbolType type);

@DllImport("icu.dll")
void udat_setSymbols(void** format, UDateFormatSymbolType type, int symbolIndex, ushort* value, int valueLength, UErrorCode* status);

@DllImport("icu.dll")
byte* udat_getLocaleByType(const(void)** fmt, ULocDataLocaleType type, UErrorCode* status);

@DllImport("icu.dll")
void udat_setContext(void** fmt, UDisplayContext value, UErrorCode* status);

@DllImport("icu.dll")
UDisplayContext udat_getContext(const(void)** fmt, UDisplayContextType type, UErrorCode* status);

@DllImport("icu.dll")
UNumberFormatter* unumf_openForSkeletonAndLocale(const(ushort)* skeleton, int skeletonLen, const(byte)* locale, UErrorCode* ec);

@DllImport("icu.dll")
UFormattedNumber* unumf_openResult(UErrorCode* ec);

@DllImport("icu.dll")
void unumf_formatInt(const(UNumberFormatter)* uformatter, long value, UFormattedNumber* uresult, UErrorCode* ec);

@DllImport("icu.dll")
void unumf_formatDouble(const(UNumberFormatter)* uformatter, double value, UFormattedNumber* uresult, UErrorCode* ec);

@DllImport("icu.dll")
void unumf_formatDecimal(const(UNumberFormatter)* uformatter, const(byte)* value, int valueLen, UFormattedNumber* uresult, UErrorCode* ec);

@DllImport("icu.dll")
int unumf_resultToString(const(UFormattedNumber)* uresult, ushort* buffer, int bufferCapacity, UErrorCode* ec);

@DllImport("icu.dll")
byte unumf_resultNextFieldPosition(const(UFormattedNumber)* uresult, UFieldPosition* ufpos, UErrorCode* ec);

@DllImport("icu.dll")
void unumf_resultGetAllFieldPositions(const(UFormattedNumber)* uresult, UFieldPositionIterator* ufpositer, UErrorCode* ec);

@DllImport("icu.dll")
void unumf_close(UNumberFormatter* uformatter);

@DllImport("icu.dll")
void unumf_closeResult(UFormattedNumber* uresult);

@DllImport("icu.dll")
UNumberingSystem* unumsys_open(const(byte)* locale, UErrorCode* status);

@DllImport("icu.dll")
UNumberingSystem* unumsys_openByName(const(byte)* name, UErrorCode* status);

@DllImport("icu.dll")
void unumsys_close(UNumberingSystem* unumsys);

@DllImport("icu.dll")
UEnumeration* unumsys_openAvailableNames(UErrorCode* status);

@DllImport("icu.dll")
byte* unumsys_getName(const(UNumberingSystem)* unumsys);

@DllImport("icu.dll")
byte unumsys_isAlgorithmic(const(UNumberingSystem)* unumsys);

@DllImport("icu.dll")
int unumsys_getRadix(const(UNumberingSystem)* unumsys);

@DllImport("icu.dll")
int unumsys_getDescription(const(UNumberingSystem)* unumsys, ushort* result, int resultLength, UErrorCode* status);

@DllImport("icu.dll")
UPluralRules* uplrules_open(const(byte)* locale, UErrorCode* status);

@DllImport("icu.dll")
UPluralRules* uplrules_openForType(const(byte)* locale, UPluralType type, UErrorCode* status);

@DllImport("icu.dll")
void uplrules_close(UPluralRules* uplrules);

@DllImport("icu.dll")
int uplrules_select(const(UPluralRules)* uplrules, double number, ushort* keyword, int capacity, UErrorCode* status);

@DllImport("icu.dll")
UEnumeration* uplrules_getKeywords(const(UPluralRules)* uplrules, UErrorCode* status);

@DllImport("icu.dll")
URegularExpression* uregex_open(const(ushort)* pattern, int patternLength, uint flags, UParseError* pe, UErrorCode* status);

@DllImport("icu.dll")
URegularExpression* uregex_openUText(UText* pattern, uint flags, UParseError* pe, UErrorCode* status);

@DllImport("icu.dll")
URegularExpression* uregex_openC(const(byte)* pattern, uint flags, UParseError* pe, UErrorCode* status);

@DllImport("icu.dll")
void uregex_close(URegularExpression* regexp);

@DllImport("icu.dll")
URegularExpression* uregex_clone(const(URegularExpression)* regexp, UErrorCode* status);

@DllImport("icu.dll")
ushort* uregex_pattern(const(URegularExpression)* regexp, int* patLength, UErrorCode* status);

@DllImport("icu.dll")
UText* uregex_patternUText(const(URegularExpression)* regexp, UErrorCode* status);

@DllImport("icu.dll")
int uregex_flags(const(URegularExpression)* regexp, UErrorCode* status);

@DllImport("icu.dll")
void uregex_setText(URegularExpression* regexp, const(ushort)* text, int textLength, UErrorCode* status);

@DllImport("icu.dll")
void uregex_setUText(URegularExpression* regexp, UText* text, UErrorCode* status);

@DllImport("icu.dll")
ushort* uregex_getText(URegularExpression* regexp, int* textLength, UErrorCode* status);

@DllImport("icu.dll")
UText* uregex_getUText(URegularExpression* regexp, UText* dest, UErrorCode* status);

@DllImport("icu.dll")
void uregex_refreshUText(URegularExpression* regexp, UText* text, UErrorCode* status);

@DllImport("icu.dll")
byte uregex_matches(URegularExpression* regexp, int startIndex, UErrorCode* status);

@DllImport("icu.dll")
byte uregex_matches64(URegularExpression* regexp, long startIndex, UErrorCode* status);

@DllImport("icu.dll")
byte uregex_lookingAt(URegularExpression* regexp, int startIndex, UErrorCode* status);

@DllImport("icu.dll")
byte uregex_lookingAt64(URegularExpression* regexp, long startIndex, UErrorCode* status);

@DllImport("icu.dll")
byte uregex_find(URegularExpression* regexp, int startIndex, UErrorCode* status);

@DllImport("icu.dll")
byte uregex_find64(URegularExpression* regexp, long startIndex, UErrorCode* status);

@DllImport("icu.dll")
byte uregex_findNext(URegularExpression* regexp, UErrorCode* status);

@DllImport("icu.dll")
int uregex_groupCount(URegularExpression* regexp, UErrorCode* status);

@DllImport("icu.dll")
int uregex_groupNumberFromName(URegularExpression* regexp, const(ushort)* groupName, int nameLength, UErrorCode* status);

@DllImport("icu.dll")
int uregex_groupNumberFromCName(URegularExpression* regexp, const(byte)* groupName, int nameLength, UErrorCode* status);

@DllImport("icu.dll")
int uregex_group(URegularExpression* regexp, int groupNum, ushort* dest, int destCapacity, UErrorCode* status);

@DllImport("icu.dll")
UText* uregex_groupUText(URegularExpression* regexp, int groupNum, UText* dest, long* groupLength, UErrorCode* status);

@DllImport("icu.dll")
int uregex_start(URegularExpression* regexp, int groupNum, UErrorCode* status);

@DllImport("icu.dll")
long uregex_start64(URegularExpression* regexp, int groupNum, UErrorCode* status);

@DllImport("icu.dll")
int uregex_end(URegularExpression* regexp, int groupNum, UErrorCode* status);

@DllImport("icu.dll")
long uregex_end64(URegularExpression* regexp, int groupNum, UErrorCode* status);

@DllImport("icu.dll")
void uregex_reset(URegularExpression* regexp, int index, UErrorCode* status);

@DllImport("icu.dll")
void uregex_reset64(URegularExpression* regexp, long index, UErrorCode* status);

@DllImport("icu.dll")
void uregex_setRegion(URegularExpression* regexp, int regionStart, int regionLimit, UErrorCode* status);

@DllImport("icu.dll")
void uregex_setRegion64(URegularExpression* regexp, long regionStart, long regionLimit, UErrorCode* status);

@DllImport("icu.dll")
void uregex_setRegionAndStart(URegularExpression* regexp, long regionStart, long regionLimit, long startIndex, UErrorCode* status);

@DllImport("icu.dll")
int uregex_regionStart(const(URegularExpression)* regexp, UErrorCode* status);

@DllImport("icu.dll")
long uregex_regionStart64(const(URegularExpression)* regexp, UErrorCode* status);

@DllImport("icu.dll")
int uregex_regionEnd(const(URegularExpression)* regexp, UErrorCode* status);

@DllImport("icu.dll")
long uregex_regionEnd64(const(URegularExpression)* regexp, UErrorCode* status);

@DllImport("icu.dll")
byte uregex_hasTransparentBounds(const(URegularExpression)* regexp, UErrorCode* status);

@DllImport("icu.dll")
void uregex_useTransparentBounds(URegularExpression* regexp, byte b, UErrorCode* status);

@DllImport("icu.dll")
byte uregex_hasAnchoringBounds(const(URegularExpression)* regexp, UErrorCode* status);

@DllImport("icu.dll")
void uregex_useAnchoringBounds(URegularExpression* regexp, byte b, UErrorCode* status);

@DllImport("icu.dll")
byte uregex_hitEnd(const(URegularExpression)* regexp, UErrorCode* status);

@DllImport("icu.dll")
byte uregex_requireEnd(const(URegularExpression)* regexp, UErrorCode* status);

@DllImport("icu.dll")
int uregex_replaceAll(URegularExpression* regexp, const(ushort)* replacementText, int replacementLength, ushort* destBuf, int destCapacity, UErrorCode* status);

@DllImport("icu.dll")
UText* uregex_replaceAllUText(URegularExpression* regexp, UText* replacement, UText* dest, UErrorCode* status);

@DllImport("icu.dll")
int uregex_replaceFirst(URegularExpression* regexp, const(ushort)* replacementText, int replacementLength, ushort* destBuf, int destCapacity, UErrorCode* status);

@DllImport("icu.dll")
UText* uregex_replaceFirstUText(URegularExpression* regexp, UText* replacement, UText* dest, UErrorCode* status);

@DllImport("icu.dll")
int uregex_appendReplacement(URegularExpression* regexp, const(ushort)* replacementText, int replacementLength, ushort** destBuf, int* destCapacity, UErrorCode* status);

@DllImport("icu.dll")
void uregex_appendReplacementUText(URegularExpression* regexp, UText* replacementText, UText* dest, UErrorCode* status);

@DllImport("icu.dll")
int uregex_appendTail(URegularExpression* regexp, ushort** destBuf, int* destCapacity, UErrorCode* status);

@DllImport("icu.dll")
UText* uregex_appendTailUText(URegularExpression* regexp, UText* dest, UErrorCode* status);

@DllImport("icu.dll")
int uregex_split(URegularExpression* regexp, ushort* destBuf, int destCapacity, int* requiredCapacity, ushort** destFields, int destFieldsCapacity, UErrorCode* status);

@DllImport("icu.dll")
int uregex_splitUText(URegularExpression* regexp, UText** destFields, int destFieldsCapacity, UErrorCode* status);

@DllImport("icu.dll")
void uregex_setTimeLimit(URegularExpression* regexp, int limit, UErrorCode* status);

@DllImport("icu.dll")
int uregex_getTimeLimit(const(URegularExpression)* regexp, UErrorCode* status);

@DllImport("icu.dll")
void uregex_setStackLimit(URegularExpression* regexp, int limit, UErrorCode* status);

@DllImport("icu.dll")
int uregex_getStackLimit(const(URegularExpression)* regexp, UErrorCode* status);

@DllImport("icu.dll")
void uregex_setMatchCallback(URegularExpression* regexp, URegexMatchCallback* callback, const(void)* context, UErrorCode* status);

@DllImport("icu.dll")
void uregex_getMatchCallback(const(URegularExpression)* regexp, URegexMatchCallback** callback, const(void)** context, UErrorCode* status);

@DllImport("icu.dll")
void uregex_setFindProgressCallback(URegularExpression* regexp, URegexFindProgressCallback* callback, const(void)* context, UErrorCode* status);

@DllImport("icu.dll")
void uregex_getFindProgressCallback(const(URegularExpression)* regexp, URegexFindProgressCallback** callback, const(void)** context, UErrorCode* status);

@DllImport("icu.dll")
URegion* uregion_getRegionFromCode(const(byte)* regionCode, UErrorCode* status);

@DllImport("icu.dll")
URegion* uregion_getRegionFromNumericCode(int code, UErrorCode* status);

@DllImport("icu.dll")
UEnumeration* uregion_getAvailable(URegionType type, UErrorCode* status);

@DllImport("icu.dll")
byte uregion_areEqual(const(URegion)* uregion, const(URegion)* otherRegion);

@DllImport("icu.dll")
URegion* uregion_getContainingRegion(const(URegion)* uregion);

@DllImport("icu.dll")
URegion* uregion_getContainingRegionOfType(const(URegion)* uregion, URegionType type);

@DllImport("icu.dll")
UEnumeration* uregion_getContainedRegions(const(URegion)* uregion, UErrorCode* status);

@DllImport("icu.dll")
UEnumeration* uregion_getContainedRegionsOfType(const(URegion)* uregion, URegionType type, UErrorCode* status);

@DllImport("icu.dll")
byte uregion_contains(const(URegion)* uregion, const(URegion)* otherRegion);

@DllImport("icu.dll")
UEnumeration* uregion_getPreferredValues(const(URegion)* uregion, UErrorCode* status);

@DllImport("icu.dll")
byte* uregion_getRegionCode(const(URegion)* uregion);

@DllImport("icu.dll")
int uregion_getNumericCode(const(URegion)* uregion);

@DllImport("icu.dll")
URegionType uregion_getType(const(URegion)* uregion);

@DllImport("icu.dll")
URelativeDateTimeFormatter* ureldatefmt_open(const(byte)* locale, void** nfToAdopt, UDateRelativeDateTimeFormatterStyle width, UDisplayContext capitalizationContext, UErrorCode* status);

@DllImport("icu.dll")
void ureldatefmt_close(URelativeDateTimeFormatter* reldatefmt);

@DllImport("icu.dll")
int ureldatefmt_formatNumeric(const(URelativeDateTimeFormatter)* reldatefmt, double offset, URelativeDateTimeUnit unit, ushort* result, int resultCapacity, UErrorCode* status);

@DllImport("icu.dll")
int ureldatefmt_format(const(URelativeDateTimeFormatter)* reldatefmt, double offset, URelativeDateTimeUnit unit, ushort* result, int resultCapacity, UErrorCode* status);

@DllImport("icu.dll")
int ureldatefmt_combineDateAndTime(const(URelativeDateTimeFormatter)* reldatefmt, const(ushort)* relativeDateString, int relativeDateStringLen, const(ushort)* timeString, int timeStringLen, ushort* result, int resultCapacity, UErrorCode* status);

@DllImport("icu.dll")
UStringSearch* usearch_open(const(ushort)* pattern, int patternlength, const(ushort)* text, int textlength, const(byte)* locale, UBreakIterator* breakiter, UErrorCode* status);

@DllImport("icu.dll")
UStringSearch* usearch_openFromCollator(const(ushort)* pattern, int patternlength, const(ushort)* text, int textlength, const(UCollator)* collator, UBreakIterator* breakiter, UErrorCode* status);

@DllImport("icu.dll")
void usearch_close(UStringSearch* searchiter);

@DllImport("icu.dll")
void usearch_setOffset(UStringSearch* strsrch, int position, UErrorCode* status);

@DllImport("icu.dll")
int usearch_getOffset(const(UStringSearch)* strsrch);

@DllImport("icu.dll")
void usearch_setAttribute(UStringSearch* strsrch, USearchAttribute attribute, USearchAttributeValue value, UErrorCode* status);

@DllImport("icu.dll")
USearchAttributeValue usearch_getAttribute(const(UStringSearch)* strsrch, USearchAttribute attribute);

@DllImport("icu.dll")
int usearch_getMatchedStart(const(UStringSearch)* strsrch);

@DllImport("icu.dll")
int usearch_getMatchedLength(const(UStringSearch)* strsrch);

@DllImport("icu.dll")
int usearch_getMatchedText(const(UStringSearch)* strsrch, ushort* result, int resultCapacity, UErrorCode* status);

@DllImport("icu.dll")
void usearch_setBreakIterator(UStringSearch* strsrch, UBreakIterator* breakiter, UErrorCode* status);

@DllImport("icu.dll")
UBreakIterator* usearch_getBreakIterator(const(UStringSearch)* strsrch);

@DllImport("icu.dll")
void usearch_setText(UStringSearch* strsrch, const(ushort)* text, int textlength, UErrorCode* status);

@DllImport("icu.dll")
ushort* usearch_getText(const(UStringSearch)* strsrch, int* length);

@DllImport("icu.dll")
UCollator* usearch_getCollator(const(UStringSearch)* strsrch);

@DllImport("icu.dll")
void usearch_setCollator(UStringSearch* strsrch, const(UCollator)* collator, UErrorCode* status);

@DllImport("icu.dll")
void usearch_setPattern(UStringSearch* strsrch, const(ushort)* pattern, int patternlength, UErrorCode* status);

@DllImport("icu.dll")
ushort* usearch_getPattern(const(UStringSearch)* strsrch, int* length);

@DllImport("icu.dll")
int usearch_first(UStringSearch* strsrch, UErrorCode* status);

@DllImport("icu.dll")
int usearch_following(UStringSearch* strsrch, int position, UErrorCode* status);

@DllImport("icu.dll")
int usearch_last(UStringSearch* strsrch, UErrorCode* status);

@DllImport("icu.dll")
int usearch_preceding(UStringSearch* strsrch, int position, UErrorCode* status);

@DllImport("icu.dll")
int usearch_next(UStringSearch* strsrch, UErrorCode* status);

@DllImport("icu.dll")
int usearch_previous(UStringSearch* strsrch, UErrorCode* status);

@DllImport("icu.dll")
void usearch_reset(UStringSearch* strsrch);

@DllImport("icu.dll")
USpoofChecker* uspoof_open(UErrorCode* status);

@DllImport("icu.dll")
USpoofChecker* uspoof_openFromSerialized(const(void)* data, int length, int* pActualLength, UErrorCode* pErrorCode);

@DllImport("icu.dll")
USpoofChecker* uspoof_openFromSource(const(byte)* confusables, int confusablesLen, const(byte)* confusablesWholeScript, int confusablesWholeScriptLen, int* errType, UParseError* pe, UErrorCode* status);

@DllImport("icu.dll")
void uspoof_close(USpoofChecker* sc);

@DllImport("icu.dll")
USpoofChecker* uspoof_clone(const(USpoofChecker)* sc, UErrorCode* status);

@DllImport("icu.dll")
void uspoof_setChecks(USpoofChecker* sc, int checks, UErrorCode* status);

@DllImport("icu.dll")
int uspoof_getChecks(const(USpoofChecker)* sc, UErrorCode* status);

@DllImport("icu.dll")
void uspoof_setRestrictionLevel(USpoofChecker* sc, URestrictionLevel restrictionLevel);

@DllImport("icu.dll")
URestrictionLevel uspoof_getRestrictionLevel(const(USpoofChecker)* sc);

@DllImport("icu.dll")
void uspoof_setAllowedLocales(USpoofChecker* sc, const(byte)* localesList, UErrorCode* status);

@DllImport("icu.dll")
byte* uspoof_getAllowedLocales(USpoofChecker* sc, UErrorCode* status);

@DllImport("icu.dll")
void uspoof_setAllowedChars(USpoofChecker* sc, const(USet)* chars, UErrorCode* status);

@DllImport("icu.dll")
USet* uspoof_getAllowedChars(const(USpoofChecker)* sc, UErrorCode* status);

@DllImport("icu.dll")
int uspoof_check(const(USpoofChecker)* sc, const(ushort)* id, int length, int* position, UErrorCode* status);

@DllImport("icu.dll")
int uspoof_checkUTF8(const(USpoofChecker)* sc, const(byte)* id, int length, int* position, UErrorCode* status);

@DllImport("icu.dll")
int uspoof_check2(const(USpoofChecker)* sc, const(ushort)* id, int length, USpoofCheckResult* checkResult, UErrorCode* status);

@DllImport("icu.dll")
int uspoof_check2UTF8(const(USpoofChecker)* sc, const(byte)* id, int length, USpoofCheckResult* checkResult, UErrorCode* status);

@DllImport("icu.dll")
USpoofCheckResult* uspoof_openCheckResult(UErrorCode* status);

@DllImport("icu.dll")
void uspoof_closeCheckResult(USpoofCheckResult* checkResult);

@DllImport("icu.dll")
int uspoof_getCheckResultChecks(const(USpoofCheckResult)* checkResult, UErrorCode* status);

@DllImport("icu.dll")
URestrictionLevel uspoof_getCheckResultRestrictionLevel(const(USpoofCheckResult)* checkResult, UErrorCode* status);

@DllImport("icu.dll")
USet* uspoof_getCheckResultNumerics(const(USpoofCheckResult)* checkResult, UErrorCode* status);

@DllImport("icu.dll")
int uspoof_areConfusable(const(USpoofChecker)* sc, const(ushort)* id1, int length1, const(ushort)* id2, int length2, UErrorCode* status);

@DllImport("icu.dll")
int uspoof_areConfusableUTF8(const(USpoofChecker)* sc, const(byte)* id1, int length1, const(byte)* id2, int length2, UErrorCode* status);

@DllImport("icu.dll")
int uspoof_getSkeleton(const(USpoofChecker)* sc, uint type, const(ushort)* id, int length, ushort* dest, int destCapacity, UErrorCode* status);

@DllImport("icu.dll")
int uspoof_getSkeletonUTF8(const(USpoofChecker)* sc, uint type, const(byte)* id, int length, byte* dest, int destCapacity, UErrorCode* status);

@DllImport("icu.dll")
USet* uspoof_getInclusionSet(UErrorCode* status);

@DllImport("icu.dll")
USet* uspoof_getRecommendedSet(UErrorCode* status);

@DllImport("icu.dll")
int uspoof_serialize(USpoofChecker* sc, void* data, int capacity, UErrorCode* status);

@DllImport("icu.dll")
long utmscale_getTimeScaleValue(UDateTimeScale timeScale, UTimeScaleValue value, UErrorCode* status);

@DllImport("icu.dll")
long utmscale_fromInt64(long otherTime, UDateTimeScale timeScale, UErrorCode* status);

@DllImport("icu.dll")
long utmscale_toInt64(long universalTime, UDateTimeScale timeScale, UErrorCode* status);

@DllImport("icu.dll")
void** utrans_openU(const(ushort)* id, int idLength, UTransDirection dir, const(ushort)* rules, int rulesLength, UParseError* parseError, UErrorCode* pErrorCode);

@DllImport("icu.dll")
void** utrans_openInverse(const(void)** trans, UErrorCode* status);

@DllImport("icu.dll")
void** utrans_clone(const(void)** trans, UErrorCode* status);

@DllImport("icu.dll")
void utrans_close(void** trans);

@DllImport("icu.dll")
ushort* utrans_getUnicodeID(const(void)** trans, int* resultLength);

@DllImport("icu.dll")
void utrans_register(void** adoptedTrans, UErrorCode* status);

@DllImport("icu.dll")
void utrans_unregisterID(const(ushort)* id, int idLength);

@DllImport("icu.dll")
void utrans_setFilter(void** trans, const(ushort)* filterPattern, int filterPatternLen, UErrorCode* status);

@DllImport("icu.dll")
int utrans_countAvailableIDs();

@DllImport("icu.dll")
UEnumeration* utrans_openIDs(UErrorCode* pErrorCode);

@DllImport("icu.dll")
void utrans_trans(const(void)** trans, void** rep, const(UReplaceableCallbacks)* repFunc, int start, int* limit, UErrorCode* status);

@DllImport("icu.dll")
void utrans_transIncremental(const(void)** trans, void** rep, const(UReplaceableCallbacks)* repFunc, UTransPosition* pos, UErrorCode* status);

@DllImport("icu.dll")
void utrans_transUChars(const(void)** trans, ushort* text, int* textLength, int textCapacity, int start, int* limit, UErrorCode* status);

@DllImport("icu.dll")
void utrans_transIncrementalUChars(const(void)** trans, ushort* text, int* textLength, int textCapacity, UTransPosition* pos, UErrorCode* status);

@DllImport("icu.dll")
int utrans_toRules(const(void)** trans, byte escapeUnprintable, ushort* result, int resultLength, UErrorCode* status);

@DllImport("icu.dll")
USet* utrans_getSourceSet(const(void)** trans, byte ignoreFilter, USet* fillIn, UErrorCode* status);

@DllImport("KERNEL32.dll")
int FindStringOrdinal(uint dwFindStringOrdinalFlags, const(wchar)* lpStringSource, int cchSource, const(wchar)* lpStringValue, int cchValue, BOOL bIgnoreCase);

@DllImport("ADVAPI32.dll")
BOOL IsTextUnicode(char* lpv, int iSize, int* lpiResult);

struct CPINFO
{
    uint MaxCharSize;
    ubyte DefaultChar;
    ubyte LeadByte;
}

struct CPINFOEXA
{
    uint MaxCharSize;
    ubyte DefaultChar;
    ubyte LeadByte;
    ushort UnicodeDefaultChar;
    uint CodePage;
    byte CodePageName;
}

struct CPINFOEXW
{
    uint MaxCharSize;
    ubyte DefaultChar;
    ubyte LeadByte;
    ushort UnicodeDefaultChar;
    uint CodePage;
    ushort CodePageName;
}

struct NUMBERFMTA
{
    uint NumDigits;
    uint LeadingZero;
    uint Grouping;
    const(char)* lpDecimalSep;
    const(char)* lpThousandSep;
    uint NegativeOrder;
}

struct NUMBERFMTW
{
    uint NumDigits;
    uint LeadingZero;
    uint Grouping;
    const(wchar)* lpDecimalSep;
    const(wchar)* lpThousandSep;
    uint NegativeOrder;
}

struct CURRENCYFMTA
{
    uint NumDigits;
    uint LeadingZero;
    uint Grouping;
    const(char)* lpDecimalSep;
    const(char)* lpThousandSep;
    uint NegativeOrder;
    uint PositiveOrder;
    const(char)* lpCurrencySymbol;
}

struct CURRENCYFMTW
{
    uint NumDigits;
    uint LeadingZero;
    uint Grouping;
    const(wchar)* lpDecimalSep;
    const(wchar)* lpThousandSep;
    uint NegativeOrder;
    uint PositiveOrder;
    const(wchar)* lpCurrencySymbol;
}

enum SYSNLS_FUNCTION
{
    COMPARE_STRING = 1,
}

struct NLSVERSIONINFO
{
    uint dwNLSVersionInfoSize;
    uint dwNLSVersion;
    uint dwDefinedVersion;
    uint dwEffectiveId;
    Guid guidCustomVersion;
}

struct NLSVERSIONINFOEX
{
    uint dwNLSVersionInfoSize;
    uint dwNLSVersion;
    uint dwDefinedVersion;
    uint dwEffectiveId;
    Guid guidCustomVersion;
}

enum SYSGEOTYPE
{
    GEO_NATION = 1,
    GEO_LATITUDE = 2,
    GEO_LONGITUDE = 3,
    GEO_ISO2 = 4,
    GEO_ISO3 = 5,
    GEO_RFC1766 = 6,
    GEO_LCID = 7,
    GEO_FRIENDLYNAME = 8,
    GEO_OFFICIALNAME = 9,
    GEO_TIMEZONES = 10,
    GEO_OFFICIALLANGUAGES = 11,
    GEO_ISO_UN_NUMBER = 12,
    GEO_PARENT = 13,
    GEO_DIALINGCODE = 14,
    GEO_CURRENCYCODE = 15,
    GEO_CURRENCYSYMBOL = 16,
    GEO_NAME = 17,
    GEO_ID = 18,
}

enum SYSGEOCLASS
{
    GEOCLASS_NATION = 16,
    GEOCLASS_REGION = 14,
    GEOCLASS_ALL = 0,
}

alias LOCALE_ENUMPROCA = extern(Windows) BOOL function(const(char)* param0);
alias LOCALE_ENUMPROCW = extern(Windows) BOOL function(const(wchar)* param0);
enum NORM_FORM
{
    NormalizationOther = 0,
    NormalizationC = 1,
    NormalizationD = 2,
    NormalizationKC = 5,
    NormalizationKD = 6,
}

alias LANGUAGEGROUP_ENUMPROCA = extern(Windows) BOOL function(uint param0, const(char)* param1, const(char)* param2, uint param3, int param4);
alias LANGGROUPLOCALE_ENUMPROCA = extern(Windows) BOOL function(uint param0, uint param1, const(char)* param2, int param3);
alias UILANGUAGE_ENUMPROCA = extern(Windows) BOOL function(const(char)* param0, int param1);
alias CODEPAGE_ENUMPROCA = extern(Windows) BOOL function(const(char)* param0);
alias DATEFMT_ENUMPROCA = extern(Windows) BOOL function(const(char)* param0);
alias DATEFMT_ENUMPROCEXA = extern(Windows) BOOL function(const(char)* param0, uint param1);
alias TIMEFMT_ENUMPROCA = extern(Windows) BOOL function(const(char)* param0);
alias CALINFO_ENUMPROCA = extern(Windows) BOOL function(const(char)* param0);
alias CALINFO_ENUMPROCEXA = extern(Windows) BOOL function(const(char)* param0, uint param1);
alias LANGUAGEGROUP_ENUMPROCW = extern(Windows) BOOL function(uint param0, const(wchar)* param1, const(wchar)* param2, uint param3, int param4);
alias LANGGROUPLOCALE_ENUMPROCW = extern(Windows) BOOL function(uint param0, uint param1, const(wchar)* param2, int param3);
alias UILANGUAGE_ENUMPROCW = extern(Windows) BOOL function(const(wchar)* param0, int param1);
alias CODEPAGE_ENUMPROCW = extern(Windows) BOOL function(const(wchar)* param0);
alias DATEFMT_ENUMPROCW = extern(Windows) BOOL function(const(wchar)* param0);
alias DATEFMT_ENUMPROCEXW = extern(Windows) BOOL function(const(wchar)* param0, uint param1);
alias TIMEFMT_ENUMPROCW = extern(Windows) BOOL function(const(wchar)* param0);
alias CALINFO_ENUMPROCW = extern(Windows) BOOL function(const(wchar)* param0);
alias CALINFO_ENUMPROCEXW = extern(Windows) BOOL function(const(wchar)* param0, uint param1);
alias GEO_ENUMPROC = extern(Windows) BOOL function(int param0);
alias GEO_ENUMNAMEPROC = extern(Windows) BOOL function(const(wchar)* param0, LPARAM param1);
struct FILEMUIINFO
{
    uint dwSize;
    uint dwVersion;
    uint dwFileType;
    ubyte pChecksum;
    ubyte pServiceChecksum;
    uint dwLanguageNameOffset;
    uint dwTypeIDMainSize;
    uint dwTypeIDMainOffset;
    uint dwTypeNameMainOffset;
    uint dwTypeIDMUISize;
    uint dwTypeIDMUIOffset;
    uint dwTypeNameMUIOffset;
    ubyte abBuffer;
}

struct HSAVEDUILANGUAGES__
{
    int unused;
}

alias CALINFO_ENUMPROCEXEX = extern(Windows) BOOL function(const(wchar)* param0, uint param1, const(wchar)* param2, LPARAM param3);
alias DATEFMT_ENUMPROCEXEX = extern(Windows) BOOL function(const(wchar)* param0, uint param1, LPARAM param2);
alias TIMEFMT_ENUMPROCEX = extern(Windows) BOOL function(const(wchar)* param0, LPARAM param1);
alias LOCALE_ENUMPROCEX = extern(Windows) BOOL function(const(wchar)* param0, uint param1, LPARAM param2);
struct HIMC__
{
    int unused;
}

struct HIMCC__
{
    int unused;
}

struct COMPOSITIONFORM
{
    uint dwStyle;
    POINT ptCurrentPos;
    RECT rcArea;
}

struct CANDIDATEFORM
{
    uint dwIndex;
    uint dwStyle;
    POINT ptCurrentPos;
    RECT rcArea;
}

struct CANDIDATELIST
{
    uint dwSize;
    uint dwStyle;
    uint dwCount;
    uint dwSelection;
    uint dwPageStart;
    uint dwPageSize;
    uint dwOffset;
}

struct REGISTERWORDA
{
    const(char)* lpReading;
    const(char)* lpWord;
}

struct REGISTERWORDW
{
    const(wchar)* lpReading;
    const(wchar)* lpWord;
}

struct RECONVERTSTRING
{
    uint dwSize;
    uint dwVersion;
    uint dwStrLen;
    uint dwStrOffset;
    uint dwCompStrLen;
    uint dwCompStrOffset;
    uint dwTargetStrLen;
    uint dwTargetStrOffset;
}

struct STYLEBUFA
{
    uint dwStyle;
    byte szDescription;
}

struct STYLEBUFW
{
    uint dwStyle;
    ushort szDescription;
}

struct IMEMENUITEMINFOA
{
    uint cbSize;
    uint fType;
    uint fState;
    uint wID;
    HBITMAP hbmpChecked;
    HBITMAP hbmpUnchecked;
    uint dwItemData;
    byte szString;
    HBITMAP hbmpItem;
}

struct IMEMENUITEMINFOW
{
    uint cbSize;
    uint fType;
    uint fState;
    uint wID;
    HBITMAP hbmpChecked;
    HBITMAP hbmpUnchecked;
    uint dwItemData;
    ushort szString;
    HBITMAP hbmpItem;
}

struct IMECHARPOSITION
{
    uint dwSize;
    uint dwCharPos;
    POINT pt;
    uint cLineHeight;
    RECT rcDocument;
}

alias IMCENUMPROC = extern(Windows) BOOL function(HIMC__* param0, LPARAM param1);
alias REGISTERWORDENUMPROCA = extern(Windows) int function(const(char)* lpszReading, uint param1, const(char)* lpszString, void* param3);
alias REGISTERWORDENUMPROCW = extern(Windows) int function(const(wchar)* lpszReading, uint param1, const(wchar)* lpszString, void* param3);
alias PFN_MAPPINGCALLBACKPROC = extern(Windows) void function(MAPPING_PROPERTY_BAG* pBag, void* data, uint dwDataSize, HRESULT Result);
struct MAPPING_SERVICE_INFO
{
    uint Size;
    const(wchar)* pszCopyright;
    ushort wMajorVersion;
    ushort wMinorVersion;
    ushort wBuildVersion;
    ushort wStepVersion;
    uint dwInputContentTypesCount;
    ushort** prgInputContentTypes;
    uint dwOutputContentTypesCount;
    ushort** prgOutputContentTypes;
    uint dwInputLanguagesCount;
    ushort** prgInputLanguages;
    uint dwOutputLanguagesCount;
    ushort** prgOutputLanguages;
    uint dwInputScriptsCount;
    ushort** prgInputScripts;
    uint dwOutputScriptsCount;
    ushort** prgOutputScripts;
    Guid guid;
    const(wchar)* pszCategory;
    const(wchar)* pszDescription;
    uint dwPrivateDataSize;
    void* pPrivateData;
    void* pContext;
    uint _bitfield;
}

struct MAPPING_ENUM_OPTIONS
{
    uint Size;
    const(wchar)* pszCategory;
    const(wchar)* pszInputLanguage;
    const(wchar)* pszOutputLanguage;
    const(wchar)* pszInputScript;
    const(wchar)* pszOutputScript;
    const(wchar)* pszInputContentType;
    const(wchar)* pszOutputContentType;
    Guid* pGuid;
    uint _bitfield;
}

struct MAPPING_OPTIONS
{
    uint Size;
    const(wchar)* pszInputLanguage;
    const(wchar)* pszOutputLanguage;
    const(wchar)* pszInputScript;
    const(wchar)* pszOutputScript;
    const(wchar)* pszInputContentType;
    const(wchar)* pszOutputContentType;
    const(wchar)* pszUILanguage;
    PFN_MAPPINGCALLBACKPROC pfnRecognizeCallback;
    void* pRecognizeCallerData;
    uint dwRecognizeCallerDataSize;
    PFN_MAPPINGCALLBACKPROC pfnActionCallback;
    void* pActionCallerData;
    uint dwActionCallerDataSize;
    uint dwServiceFlag;
    uint _bitfield;
}

struct MAPPING_DATA_RANGE
{
    uint dwStartIndex;
    uint dwEndIndex;
    const(wchar)* pszDescription;
    uint dwDescriptionLength;
    void* pData;
    uint dwDataSize;
    const(wchar)* pszContentType;
    ushort** prgActionIds;
    uint dwActionsCount;
    ushort** prgActionDisplayNames;
}

struct MAPPING_PROPERTY_BAG
{
    uint Size;
    MAPPING_DATA_RANGE* prgResultRanges;
    uint dwRangesCount;
    void* pServiceData;
    uint dwServiceDataSize;
    void* pCallerData;
    uint dwCallerDataSize;
    void* pContext;
}

const GUID CLSID_SpellCheckerFactory = {0x7AB36653, 0x1796, 0x484B, [0xBD, 0xFA, 0xE7, 0x4F, 0x1D, 0xB7, 0xC1, 0xDC]};
@GUID(0x7AB36653, 0x1796, 0x484B, [0xBD, 0xFA, 0xE7, 0x4F, 0x1D, 0xB7, 0xC1, 0xDC]);
struct SpellCheckerFactory;

enum WORDLIST_TYPE
{
    WORDLIST_TYPE_IGNORE = 0,
    WORDLIST_TYPE_ADD = 1,
    WORDLIST_TYPE_EXCLUDE = 2,
    WORDLIST_TYPE_AUTOCORRECT = 3,
}

enum CORRECTIVE_ACTION
{
    CORRECTIVE_ACTION_NONE = 0,
    CORRECTIVE_ACTION_GET_SUGGESTIONS = 1,
    CORRECTIVE_ACTION_REPLACE = 2,
    CORRECTIVE_ACTION_DELETE = 3,
}

const GUID IID_ISpellingError = {0xB7C82D61, 0xFBE8, 0x4B47, [0x9B, 0x27, 0x6C, 0x0D, 0x2E, 0x0D, 0xE0, 0xA3]};
@GUID(0xB7C82D61, 0xFBE8, 0x4B47, [0x9B, 0x27, 0x6C, 0x0D, 0x2E, 0x0D, 0xE0, 0xA3]);
interface ISpellingError : IUnknown
{
    HRESULT get_StartIndex(uint* value);
    HRESULT get_Length(uint* value);
    HRESULT get_CorrectiveAction(CORRECTIVE_ACTION* value);
    HRESULT get_Replacement(ushort** value);
}

const GUID IID_IEnumSpellingError = {0x803E3BD4, 0x2828, 0x4410, [0x82, 0x90, 0x41, 0x8D, 0x1D, 0x73, 0xC7, 0x62]};
@GUID(0x803E3BD4, 0x2828, 0x4410, [0x82, 0x90, 0x41, 0x8D, 0x1D, 0x73, 0xC7, 0x62]);
interface IEnumSpellingError : IUnknown
{
    HRESULT Next(ISpellingError* value);
}

const GUID IID_IOptionDescription = {0x432E5F85, 0x35CF, 0x4606, [0xA8, 0x01, 0x6F, 0x70, 0x27, 0x7E, 0x1D, 0x7A]};
@GUID(0x432E5F85, 0x35CF, 0x4606, [0xA8, 0x01, 0x6F, 0x70, 0x27, 0x7E, 0x1D, 0x7A]);
interface IOptionDescription : IUnknown
{
    HRESULT get_Id(ushort** value);
    HRESULT get_Heading(ushort** value);
    HRESULT get_Description(ushort** value);
    HRESULT get_Labels(IEnumString* value);
}

const GUID IID_ISpellCheckerChangedEventHandler = {0x0B83A5B0, 0x792F, 0x4EAB, [0x97, 0x99, 0xAC, 0xF5, 0x2C, 0x5E, 0xD0, 0x8A]};
@GUID(0x0B83A5B0, 0x792F, 0x4EAB, [0x97, 0x99, 0xAC, 0xF5, 0x2C, 0x5E, 0xD0, 0x8A]);
interface ISpellCheckerChangedEventHandler : IUnknown
{
    HRESULT Invoke(ISpellChecker sender);
}

const GUID IID_ISpellChecker = {0xB6FD0B71, 0xE2BC, 0x4653, [0x8D, 0x05, 0xF1, 0x97, 0xE4, 0x12, 0x77, 0x0B]};
@GUID(0xB6FD0B71, 0xE2BC, 0x4653, [0x8D, 0x05, 0xF1, 0x97, 0xE4, 0x12, 0x77, 0x0B]);
interface ISpellChecker : IUnknown
{
    HRESULT get_LanguageTag(ushort** value);
    HRESULT Check(const(wchar)* text, IEnumSpellingError* value);
    HRESULT Suggest(const(wchar)* word, IEnumString* value);
    HRESULT Add(const(wchar)* word);
    HRESULT Ignore(const(wchar)* word);
    HRESULT AutoCorrect(const(wchar)* from, const(wchar)* to);
    HRESULT GetOptionValue(const(wchar)* optionId, ubyte* value);
    HRESULT get_OptionIds(IEnumString* value);
    HRESULT get_Id(ushort** value);
    HRESULT get_LocalizedName(ushort** value);
    HRESULT add_SpellCheckerChanged(ISpellCheckerChangedEventHandler handler, uint* eventCookie);
    HRESULT remove_SpellCheckerChanged(uint eventCookie);
    HRESULT GetOptionDescription(const(wchar)* optionId, IOptionDescription* value);
    HRESULT ComprehensiveCheck(const(wchar)* text, IEnumSpellingError* value);
}

const GUID IID_ISpellChecker2 = {0xE7ED1C71, 0x87F7, 0x4378, [0xA8, 0x40, 0xC9, 0x20, 0x0D, 0xAC, 0xEE, 0x47]};
@GUID(0xE7ED1C71, 0x87F7, 0x4378, [0xA8, 0x40, 0xC9, 0x20, 0x0D, 0xAC, 0xEE, 0x47]);
interface ISpellChecker2 : ISpellChecker
{
    HRESULT Remove(const(wchar)* word);
}

const GUID IID_ISpellCheckerFactory = {0x8E018A9D, 0x2415, 0x4677, [0xBF, 0x08, 0x79, 0x4E, 0xA6, 0x1F, 0x94, 0xBB]};
@GUID(0x8E018A9D, 0x2415, 0x4677, [0xBF, 0x08, 0x79, 0x4E, 0xA6, 0x1F, 0x94, 0xBB]);
interface ISpellCheckerFactory : IUnknown
{
    HRESULT get_SupportedLanguages(IEnumString* value);
    HRESULT IsSupported(const(wchar)* languageTag, int* value);
    HRESULT CreateSpellChecker(const(wchar)* languageTag, ISpellChecker* value);
}

const GUID IID_IUserDictionariesRegistrar = {0xAA176B85, 0x0E12, 0x4844, [0x8E, 0x1A, 0xEE, 0xF1, 0xDA, 0x77, 0xF5, 0x86]};
@GUID(0xAA176B85, 0x0E12, 0x4844, [0x8E, 0x1A, 0xEE, 0xF1, 0xDA, 0x77, 0xF5, 0x86]);
interface IUserDictionariesRegistrar : IUnknown
{
    HRESULT RegisterUserDictionary(const(wchar)* dictionaryPath, const(wchar)* languageTag);
    HRESULT UnregisterUserDictionary(const(wchar)* dictionaryPath, const(wchar)* languageTag);
}

const GUID IID_ISpellCheckProvider = {0x73E976E0, 0x8ED4, 0x4EB1, [0x80, 0xD7, 0x1B, 0xE0, 0xA1, 0x6B, 0x0C, 0x38]};
@GUID(0x73E976E0, 0x8ED4, 0x4EB1, [0x80, 0xD7, 0x1B, 0xE0, 0xA1, 0x6B, 0x0C, 0x38]);
interface ISpellCheckProvider : IUnknown
{
    HRESULT get_LanguageTag(ushort** value);
    HRESULT Check(const(wchar)* text, IEnumSpellingError* value);
    HRESULT Suggest(const(wchar)* word, IEnumString* value);
    HRESULT GetOptionValue(const(wchar)* optionId, ubyte* value);
    HRESULT SetOptionValue(const(wchar)* optionId, ubyte value);
    HRESULT get_OptionIds(IEnumString* value);
    HRESULT get_Id(ushort** value);
    HRESULT get_LocalizedName(ushort** value);
    HRESULT GetOptionDescription(const(wchar)* optionId, IOptionDescription* value);
    HRESULT InitializeWordlist(WORDLIST_TYPE wordlistType, IEnumString words);
}

const GUID IID_IComprehensiveSpellCheckProvider = {0x0C58F8DE, 0x8E94, 0x479E, [0x97, 0x17, 0x70, 0xC4, 0x2C, 0x4A, 0xD2, 0xC3]};
@GUID(0x0C58F8DE, 0x8E94, 0x479E, [0x97, 0x17, 0x70, 0xC4, 0x2C, 0x4A, 0xD2, 0xC3]);
interface IComprehensiveSpellCheckProvider : IUnknown
{
    HRESULT ComprehensiveCheck(const(wchar)* text, IEnumSpellingError* value);
}

const GUID IID_ISpellCheckProviderFactory = {0x9F671E11, 0x77D6, 0x4C92, [0xAE, 0xFB, 0x61, 0x52, 0x15, 0xE3, 0xA4, 0xBE]};
@GUID(0x9F671E11, 0x77D6, 0x4C92, [0xAE, 0xFB, 0x61, 0x52, 0x15, 0xE3, 0xA4, 0xBE]);
interface ISpellCheckProviderFactory : IUnknown
{
    HRESULT get_SupportedLanguages(IEnumString* value);
    HRESULT IsSupported(const(wchar)* languageTag, int* value);
    HRESULT CreateSpellCheckProvider(const(wchar)* languageTag, ISpellCheckProvider* value);
}

interface IFEClassFactory : IClassFactory
{
}

struct IMEDLG
{
    int cbIMEDLG;
    HWND hwnd;
    const(wchar)* lpwstrWord;
    int nTabId;
}

interface IFECommon : IUnknown
{
    HRESULT IsDefaultIME(char* szName, int cszName);
    HRESULT SetDefaultIME();
    HRESULT InvokeWordRegDialog(IMEDLG* pimedlg);
    HRESULT InvokeDictToolDialog(IMEDLG* pimedlg);
}

struct WDD
{
    ushort wDispPos;
    _Anonymous1_e__Union Anonymous1;
    ushort cchDisp;
    _Anonymous2_e__Union Anonymous2;
    uint WDD_nReserve1;
    ushort nPos;
    ushort _bitfield;
    void* pReserved;
}

struct MORRSLT
{
    uint dwSize;
    ushort* pwchOutput;
    ushort cchOutput;
    _Anonymous1_e__Union Anonymous1;
    _Anonymous2_e__Union Anonymous2;
    ushort* pchInputPos;
    ushort* pchOutputIdxWDD;
    _Anonymous3_e__Union Anonymous3;
    ushort* paMonoRubyPos;
    WDD* pWDD;
    int cWDD;
    void* pPrivate;
    ushort BLKBuff;
}

interface IFELanguage : IUnknown
{
    HRESULT Open();
    HRESULT Close();
    HRESULT GetJMorphResult(uint dwRequest, uint dwCMode, int cwchInput, const(wchar)* pwchInput, uint* pfCInfo, MORRSLT** ppResult);
    HRESULT GetConversionModeCaps(uint* pdwCaps);
    HRESULT GetPhonetic(BSTR string, int start, int length, BSTR* phonetic);
    HRESULT GetConversion(BSTR string, int start, int length, BSTR* result);
}

enum IMEREG
{
    IFED_REG_HEAD = 0,
    IFED_REG_TAIL = 1,
    IFED_REG_DEL = 2,
}

enum IMEFMT
{
    IFED_UNKNOWN = 0,
    IFED_MSIME2_BIN_SYSTEM = 1,
    IFED_MSIME2_BIN_USER = 2,
    IFED_MSIME2_TEXT_USER = 3,
    IFED_MSIME95_BIN_SYSTEM = 4,
    IFED_MSIME95_BIN_USER = 5,
    IFED_MSIME95_TEXT_USER = 6,
    IFED_MSIME97_BIN_SYSTEM = 7,
    IFED_MSIME97_BIN_USER = 8,
    IFED_MSIME97_TEXT_USER = 9,
    IFED_MSIME98_BIN_SYSTEM = 10,
    IFED_MSIME98_BIN_USER = 11,
    IFED_MSIME98_TEXT_USER = 12,
    IFED_ACTIVE_DICT = 13,
    IFED_ATOK9 = 14,
    IFED_ATOK10 = 15,
    IFED_NEC_AI_ = 16,
    IFED_WX_II = 17,
    IFED_WX_III = 18,
    IFED_VJE_20 = 19,
    IFED_MSIME98_SYSTEM_CE = 20,
    IFED_MSIME_BIN_SYSTEM = 21,
    IFED_MSIME_BIN_USER = 22,
    IFED_MSIME_TEXT_USER = 23,
    IFED_PIME2_BIN_USER = 24,
    IFED_PIME2_BIN_SYSTEM = 25,
    IFED_PIME2_BIN_STANDARD_SYSTEM = 26,
}

enum IMEUCT
{
    IFED_UCT_NONE = 0,
    IFED_UCT_STRING_SJIS = 1,
    IFED_UCT_STRING_UNICODE = 2,
    IFED_UCT_USER_DEFINED = 3,
    IFED_UCT_MAX = 4,
}

struct IMEWRD
{
    ushort* pwchReading;
    ushort* pwchDisplay;
    _Anonymous_e__Union Anonymous;
    uint rgulAttrs;
    int cbComment;
    IMEUCT uct;
    void* pvComment;
}

struct IMESHF
{
    ushort cbShf;
    ushort verDic;
    byte szTitle;
    byte szDescription;
    byte szCopyright;
}

struct POSTBL
{
    ushort nPos;
    ubyte* szName;
}

enum IMEREL
{
    IFED_REL_NONE = 0,
    IFED_REL_NO = 1,
    IFED_REL_GA = 2,
    IFED_REL_WO = 3,
    IFED_REL_NI = 4,
    IFED_REL_DE = 5,
    IFED_REL_YORI = 6,
    IFED_REL_KARA = 7,
    IFED_REL_MADE = 8,
    IFED_REL_HE = 9,
    IFED_REL_TO = 10,
    IFED_REL_IDEOM = 11,
    IFED_REL_FUKU_YOUGEN = 12,
    IFED_REL_KEIYOU_YOUGEN = 13,
    IFED_REL_KEIDOU1_YOUGEN = 14,
    IFED_REL_KEIDOU2_YOUGEN = 15,
    IFED_REL_TAIGEN = 16,
    IFED_REL_YOUGEN = 17,
    IFED_REL_RENTAI_MEI = 18,
    IFED_REL_RENSOU = 19,
    IFED_REL_KEIYOU_TO_YOUGEN = 20,
    IFED_REL_KEIYOU_TARU_YOUGEN = 21,
    IFED_REL_UNKNOWN1 = 22,
    IFED_REL_UNKNOWN2 = 23,
    IFED_REL_ALL = 24,
}

struct IMEDP
{
    IMEWRD wrdModifier;
    IMEWRD wrdModifiee;
    IMEREL relID;
}

alias PFNLOG = extern(Windows) BOOL function(IMEDP* param0, HRESULT param1);
interface IFEDictionary : IUnknown
{
    HRESULT Open(char* pchDictPath, IMESHF* pshf);
    HRESULT Close();
    HRESULT GetHeader(char* pchDictPath, IMESHF* pshf, IMEFMT* pjfmt, uint* pulType);
    HRESULT DisplayProperty(HWND hwnd);
    HRESULT GetPosTable(POSTBL** prgPosTbl, int* pcPosTbl);
    HRESULT GetWords(const(wchar)* pwchFirst, const(wchar)* pwchLast, const(wchar)* pwchDisplay, uint ulPos, uint ulSelect, uint ulWordSrc, ubyte* pchBuffer, uint cbBuffer, uint* pcWrd);
    HRESULT NextWords(ubyte* pchBuffer, uint cbBuffer, uint* pcWrd);
    HRESULT Create(const(byte)* pchDictPath, IMESHF* pshf);
    HRESULT SetHeader(IMESHF* pshf);
    HRESULT ExistWord(IMEWRD* pwrd);
    HRESULT ExistDependency(IMEDP* pdp);
    HRESULT RegisterWord(IMEREG reg, IMEWRD* pwrd);
    HRESULT RegisterDependency(IMEREG reg, IMEDP* pdp);
    HRESULT GetDependencies(const(wchar)* pwchKakariReading, const(wchar)* pwchKakariDisplay, uint ulKakariPos, const(wchar)* pwchUkeReading, const(wchar)* pwchUkeDisplay, uint ulUkePos, IMEREL jrel, uint ulWordSrc, ubyte* pchBuffer, uint cbBuffer, uint* pcdp);
    HRESULT NextDependencies(ubyte* pchBuffer, uint cbBuffer, uint* pcDp);
    HRESULT ConvertFromOldMSIME(const(byte)* pchDic, PFNLOG pfnLog, IMEREG reg);
    HRESULT ConvertFromUserToSys();
}

struct IMEKMSINIT
{
    int cbSize;
    HWND hWnd;
}

struct IMEKMSKEY
{
    uint dwStatus;
    uint dwCompStatus;
    uint dwVKEY;
    _Anonymous1_e__Union Anonymous1;
    _Anonymous2_e__Union Anonymous2;
}

struct IMEKMS
{
    int cbSize;
    HIMC__* hIMC;
    uint cKeyList;
    IMEKMSKEY* pKeyList;
}

struct IMEKMSNTFY
{
    int cbSize;
    HIMC__* hIMC;
    BOOL fSelect;
}

struct IMEKMSKMP
{
    int cbSize;
    HIMC__* hIMC;
    ushort idLang;
    ushort wVKStart;
    ushort wVKEnd;
    int cKeyList;
    IMEKMSKEY* pKeyList;
}

struct IMEKMSINVK
{
    int cbSize;
    HIMC__* hIMC;
    uint dwControl;
}

struct IMEKMSFUNCDESC
{
    int cbSize;
    ushort idLang;
    uint dwControl;
    ushort pwszDescription;
}

alias fpCreateIFECommonInstanceType = extern(Windows) HRESULT function(void** ppvObj);
alias fpCreateIFELanguageInstanceType = extern(Windows) HRESULT function(const(Guid)* clsid, void** ppvObj);
alias fpCreateIFEDictionaryInstanceType = extern(Windows) HRESULT function(void** ppvObj);
struct COMPOSITIONSTRING
{
    uint dwSize;
    uint dwCompReadAttrLen;
    uint dwCompReadAttrOffset;
    uint dwCompReadClauseLen;
    uint dwCompReadClauseOffset;
    uint dwCompReadStrLen;
    uint dwCompReadStrOffset;
    uint dwCompAttrLen;
    uint dwCompAttrOffset;
    uint dwCompClauseLen;
    uint dwCompClauseOffset;
    uint dwCompStrLen;
    uint dwCompStrOffset;
    uint dwCursorPos;
    uint dwDeltaStart;
    uint dwResultReadClauseLen;
    uint dwResultReadClauseOffset;
    uint dwResultReadStrLen;
    uint dwResultReadStrOffset;
    uint dwResultClauseLen;
    uint dwResultClauseOffset;
    uint dwResultStrLen;
    uint dwResultStrOffset;
    uint dwPrivateSize;
    uint dwPrivateOffset;
}

struct GUIDELINE
{
    uint dwSize;
    uint dwLevel;
    uint dwIndex;
    uint dwStrLen;
    uint dwStrOffset;
    uint dwPrivateSize;
    uint dwPrivateOffset;
}

struct TRANSMSG
{
    uint message;
    WPARAM wParam;
    LPARAM lParam;
}

struct TRANSMSGLIST
{
    uint uMsgCount;
    TRANSMSG TransMsg;
}

struct CANDIDATEINFO
{
    uint dwSize;
    uint dwCount;
    uint dwOffset;
    uint dwPrivateSize;
    uint dwPrivateOffset;
}

struct INPUTCONTEXT
{
    HWND hWnd;
    BOOL fOpen;
    POINT ptStatusWndPos;
    POINT ptSoftKbdPos;
    uint fdwConversion;
    uint fdwSentence;
    _lfFont_e__Union lfFont;
    COMPOSITIONFORM cfCompForm;
    CANDIDATEFORM cfCandForm;
    HIMCC__* hCompStr;
    HIMCC__* hCandInfo;
    HIMCC__* hGuideLine;
    HIMCC__* hPrivate;
    uint dwNumMsgBuf;
    HIMCC__* hMsgBuf;
    uint fdwInit;
    uint dwReserve;
}

struct IMEINFO
{
    uint dwPrivateDataSize;
    uint fdwProperty;
    uint fdwConversionCaps;
    uint fdwSentenceCaps;
    uint fdwUICaps;
    uint fdwSCSCaps;
    uint fdwSelectCaps;
}

struct SOFTKBDDATA
{
    uint uCount;
    ushort wCode;
}

struct APPLETIDLIST
{
    int count;
    Guid* pIIDList;
}

struct IMESTRINGCANDIDATE
{
    uint uCount;
    ushort* lpwstr;
}

struct IMEITEM
{
    int cbSize;
    int iType;
    void* lpItemData;
}

struct IMEITEMCANDIDATE
{
    uint uCount;
    IMEITEM imeItem;
}

struct tabIMESTRINGINFO
{
    uint dwFarEastId;
    const(wchar)* lpwstr;
}

struct tabIMEFAREASTINFO
{
    uint dwSize;
    uint dwType;
    uint dwData;
}

struct IMESTRINGCANDIDATEINFO
{
    uint dwFarEastId;
    tabIMEFAREASTINFO* lpFarEastInfo;
    uint fInfoMask;
    int iSelIndex;
    uint uCount;
    ushort* lpwstr;
}

struct IMECOMPOSITIONSTRINGINFO
{
    int iCompStrLen;
    int iCaretPos;
    int iEditStart;
    int iEditLen;
    int iTargetStart;
    int iTargetLen;
}

struct IMECHARINFO
{
    ushort wch;
    uint dwCharInfo;
}

struct IMEAPPLETCFG
{
    uint dwConfig;
    ushort wchTitle;
    ushort wchTitleFontFace;
    uint dwCharSet;
    int iCategory;
    HICON hIcon;
    ushort langID;
    ushort dummy;
    LPARAM lReserved1;
}

struct IMEAPPLETUI
{
    HWND hwnd;
    uint dwStyle;
    int width;
    int height;
    int minWidth;
    int minHeight;
    int maxWidth;
    int maxHeight;
    LPARAM lReserved1;
    LPARAM lReserved2;
}

struct APPLYCANDEXPARAM
{
    uint dwSize;
    const(wchar)* lpwstrDisplay;
    const(wchar)* lpwstrReading;
    uint dwReserved;
}

interface IImeSpecifyApplets : IUnknown
{
    HRESULT GetAppletIIDList(const(Guid)* refiid, APPLETIDLIST* lpIIDList);
}

interface IImePadApplet : IUnknown
{
    HRESULT Initialize(IUnknown lpIImePad);
    HRESULT Terminate();
    HRESULT GetAppletConfig(IMEAPPLETCFG* lpAppletCfg);
    HRESULT CreateUI(HWND hwndParent, IMEAPPLETUI* lpImeAppletUI);
    HRESULT Notify(IUnknown lpImePad, int notify, WPARAM wParam, LPARAM lParam);
}

interface IImePad : IUnknown
{
    HRESULT Request(IImePadApplet pIImePadApplet, int reqId, WPARAM wParam, LPARAM lParam);
}

const GUID IID_IImePlugInDictDictionaryList = {0x98752974, 0xB0A6, 0x489B, [0x8F, 0x6F, 0xBF, 0xF3, 0x76, 0x9C, 0x8E, 0xEB]};
@GUID(0x98752974, 0xB0A6, 0x489B, [0x8F, 0x6F, 0xBF, 0xF3, 0x76, 0x9C, 0x8E, 0xEB]);
interface IImePlugInDictDictionaryList : IUnknown
{
    HRESULT GetDictionariesInUse(SAFEARRAY** prgDictionaryGUID, SAFEARRAY** prgDateCreated, SAFEARRAY** prgfEncrypted);
    HRESULT DeleteDictionary(BSTR bstrDictionaryGUID);
}

struct SCRIPT_CONTROL
{
    uint _bitfield;
}

struct SCRIPT_STATE
{
    ushort _bitfield;
}

struct SCRIPT_ANALYSIS
{
    ushort _bitfield;
    SCRIPT_STATE s;
}

struct SCRIPT_ITEM
{
    int iCharPos;
    SCRIPT_ANALYSIS a;
}

enum SCRIPT_JUSTIFY
{
    SCRIPT_JUSTIFY_NONE = 0,
    SCRIPT_JUSTIFY_ARABIC_BLANK = 1,
    SCRIPT_JUSTIFY_CHARACTER = 2,
    SCRIPT_JUSTIFY_RESERVED1 = 3,
    SCRIPT_JUSTIFY_BLANK = 4,
    SCRIPT_JUSTIFY_RESERVED2 = 5,
    SCRIPT_JUSTIFY_RESERVED3 = 6,
    SCRIPT_JUSTIFY_ARABIC_NORMAL = 7,
    SCRIPT_JUSTIFY_ARABIC_KASHIDA = 8,
    SCRIPT_JUSTIFY_ARABIC_ALEF = 9,
    SCRIPT_JUSTIFY_ARABIC_HA = 10,
    SCRIPT_JUSTIFY_ARABIC_RA = 11,
    SCRIPT_JUSTIFY_ARABIC_BA = 12,
    SCRIPT_JUSTIFY_ARABIC_BARA = 13,
    SCRIPT_JUSTIFY_ARABIC_SEEN = 14,
    SCRIPT_JUSTIFY_ARABIC_SEEN_M = 15,
}

struct SCRIPT_VISATTR
{
    ushort _bitfield;
}

struct GOFFSET
{
    int du;
    int dv;
}

struct SCRIPT_LOGATTR
{
    ubyte _bitfield;
}

struct SCRIPT_PROPERTIES
{
    uint _bitfield1;
    uint _bitfield2;
}

struct SCRIPT_FONTPROPERTIES
{
    int cBytes;
    ushort wgBlank;
    ushort wgDefault;
    ushort wgInvalid;
    ushort wgKashida;
    int iKashidaWidth;
}

struct SCRIPT_TABDEF
{
    int cTabStops;
    int iScale;
    int* pTabStops;
    int iTabOrigin;
}

struct SCRIPT_DIGITSUBSTITUTE
{
    uint _bitfield1;
    uint _bitfield2;
    uint dwReserved;
}

struct opentype_feature_record
{
    uint tagFeature;
    int lParameter;
}

struct textrange_properties
{
    opentype_feature_record* potfRecords;
    int cotfRecords;
}

struct script_charprop
{
    ushort _bitfield;
}

struct script_glyphprop
{
    SCRIPT_VISATTR sva;
    ushort reserved;
}

enum UErrorCode
{
    U_USING_FALLBACK_WARNING = -128,
    U_ERROR_WARNING_START = -128,
    U_USING_DEFAULT_WARNING = -127,
    U_SAFECLONE_ALLOCATED_WARNING = -126,
    U_STATE_OLD_WARNING = -125,
    U_STRING_NOT_TERMINATED_WARNING = -124,
    U_SORT_KEY_TOO_SHORT_WARNING = -123,
    U_AMBIGUOUS_ALIAS_WARNING = -122,
    U_DIFFERENT_UCA_VERSION = -121,
    U_PLUGIN_CHANGED_LEVEL_WARNING = -120,
    U_ZERO_ERROR = 0,
    U_ILLEGAL_ARGUMENT_ERROR = 1,
    U_MISSING_RESOURCE_ERROR = 2,
    U_INVALID_FORMAT_ERROR = 3,
    U_FILE_ACCESS_ERROR = 4,
    U_INTERNAL_PROGRAM_ERROR = 5,
    U_MESSAGE_PARSE_ERROR = 6,
    U_MEMORY_ALLOCATION_ERROR = 7,
    U_INDEX_OUTOFBOUNDS_ERROR = 8,
    U_PARSE_ERROR = 9,
    U_INVALID_CHAR_FOUND = 10,
    U_TRUNCATED_CHAR_FOUND = 11,
    U_ILLEGAL_CHAR_FOUND = 12,
    U_INVALID_TABLE_FORMAT = 13,
    U_INVALID_TABLE_FILE = 14,
    U_BUFFER_OVERFLOW_ERROR = 15,
    U_UNSUPPORTED_ERROR = 16,
    U_RESOURCE_TYPE_MISMATCH = 17,
    U_ILLEGAL_ESCAPE_SEQUENCE = 18,
    U_UNSUPPORTED_ESCAPE_SEQUENCE = 19,
    U_NO_SPACE_AVAILABLE = 20,
    U_CE_NOT_FOUND_ERROR = 21,
    U_PRIMARY_TOO_LONG_ERROR = 22,
    U_STATE_TOO_OLD_ERROR = 23,
    U_TOO_MANY_ALIASES_ERROR = 24,
    U_ENUM_OUT_OF_SYNC_ERROR = 25,
    U_INVARIANT_CONVERSION_ERROR = 26,
    U_INVALID_STATE_ERROR = 27,
    U_COLLATOR_VERSION_MISMATCH = 28,
    U_USELESS_COLLATOR_ERROR = 29,
    U_NO_WRITE_PERMISSION = 30,
    U_BAD_VARIABLE_DEFINITION = 65536,
    U_PARSE_ERROR_START = 65536,
    U_MALFORMED_RULE = 65537,
    U_MALFORMED_SET = 65538,
    U_MALFORMED_SYMBOL_REFERENCE = 65539,
    U_MALFORMED_UNICODE_ESCAPE = 65540,
    U_MALFORMED_VARIABLE_DEFINITION = 65541,
    U_MALFORMED_VARIABLE_REFERENCE = 65542,
    U_MISMATCHED_SEGMENT_DELIMITERS = 65543,
    U_MISPLACED_ANCHOR_START = 65544,
    U_MISPLACED_CURSOR_OFFSET = 65545,
    U_MISPLACED_QUANTIFIER = 65546,
    U_MISSING_OPERATOR = 65547,
    U_MISSING_SEGMENT_CLOSE = 65548,
    U_MULTIPLE_ANTE_CONTEXTS = 65549,
    U_MULTIPLE_CURSORS = 65550,
    U_MULTIPLE_POST_CONTEXTS = 65551,
    U_TRAILING_BACKSLASH = 65552,
    U_UNDEFINED_SEGMENT_REFERENCE = 65553,
    U_UNDEFINED_VARIABLE = 65554,
    U_UNQUOTED_SPECIAL = 65555,
    U_UNTERMINATED_QUOTE = 65556,
    U_RULE_MASK_ERROR = 65557,
    U_MISPLACED_COMPOUND_FILTER = 65558,
    U_MULTIPLE_COMPOUND_FILTERS = 65559,
    U_INVALID_RBT_SYNTAX = 65560,
    U_INVALID_PROPERTY_PATTERN = 65561,
    U_MALFORMED_PRAGMA = 65562,
    U_UNCLOSED_SEGMENT = 65563,
    U_ILLEGAL_CHAR_IN_SEGMENT = 65564,
    U_VARIABLE_RANGE_EXHAUSTED = 65565,
    U_VARIABLE_RANGE_OVERLAP = 65566,
    U_ILLEGAL_CHARACTER = 65567,
    U_INTERNAL_TRANSLITERATOR_ERROR = 65568,
    U_INVALID_ID = 65569,
    U_INVALID_FUNCTION = 65570,
    U_UNEXPECTED_TOKEN = 65792,
    U_FMT_PARSE_ERROR_START = 65792,
    U_MULTIPLE_DECIMAL_SEPARATORS = 65793,
    U_MULTIPLE_DECIMAL_SEPERATORS = 65793,
    U_MULTIPLE_EXPONENTIAL_SYMBOLS = 65794,
    U_MALFORMED_EXPONENTIAL_PATTERN = 65795,
    U_MULTIPLE_PERCENT_SYMBOLS = 65796,
    U_MULTIPLE_PERMILL_SYMBOLS = 65797,
    U_MULTIPLE_PAD_SPECIFIERS = 65798,
    U_PATTERN_SYNTAX_ERROR = 65799,
    U_ILLEGAL_PAD_POSITION = 65800,
    U_UNMATCHED_BRACES = 65801,
    U_UNSUPPORTED_PROPERTY = 65802,
    U_UNSUPPORTED_ATTRIBUTE = 65803,
    U_ARGUMENT_TYPE_MISMATCH = 65804,
    U_DUPLICATE_KEYWORD = 65805,
    U_UNDEFINED_KEYWORD = 65806,
    U_DEFAULT_KEYWORD_MISSING = 65807,
    U_DECIMAL_NUMBER_SYNTAX_ERROR = 65808,
    U_FORMAT_INEXACT_ERROR = 65809,
    U_NUMBER_ARG_OUTOFBOUNDS_ERROR = 65810,
    U_NUMBER_SKELETON_SYNTAX_ERROR = 65811,
    U_BRK_INTERNAL_ERROR = 66048,
    U_BRK_ERROR_START = 66048,
    U_BRK_HEX_DIGITS_EXPECTED = 66049,
    U_BRK_SEMICOLON_EXPECTED = 66050,
    U_BRK_RULE_SYNTAX = 66051,
    U_BRK_UNCLOSED_SET = 66052,
    U_BRK_ASSIGN_ERROR = 66053,
    U_BRK_VARIABLE_REDFINITION = 66054,
    U_BRK_MISMATCHED_PAREN = 66055,
    U_BRK_NEW_LINE_IN_QUOTED_STRING = 66056,
    U_BRK_UNDEFINED_VARIABLE = 66057,
    U_BRK_INIT_ERROR = 66058,
    U_BRK_RULE_EMPTY_SET = 66059,
    U_BRK_UNRECOGNIZED_OPTION = 66060,
    U_BRK_MALFORMED_RULE_TAG = 66061,
    U_REGEX_INTERNAL_ERROR = 66304,
    U_REGEX_ERROR_START = 66304,
    U_REGEX_RULE_SYNTAX = 66305,
    U_REGEX_INVALID_STATE = 66306,
    U_REGEX_BAD_ESCAPE_SEQUENCE = 66307,
    U_REGEX_PROPERTY_SYNTAX = 66308,
    U_REGEX_UNIMPLEMENTED = 66309,
    U_REGEX_MISMATCHED_PAREN = 66310,
    U_REGEX_NUMBER_TOO_BIG = 66311,
    U_REGEX_BAD_INTERVAL = 66312,
    U_REGEX_MAX_LT_MIN = 66313,
    U_REGEX_INVALID_BACK_REF = 66314,
    U_REGEX_INVALID_FLAG = 66315,
    U_REGEX_LOOK_BEHIND_LIMIT = 66316,
    U_REGEX_SET_CONTAINS_STRING = 66317,
    U_REGEX_MISSING_CLOSE_BRACKET = 66319,
    U_REGEX_INVALID_RANGE = 66320,
    U_REGEX_STACK_OVERFLOW = 66321,
    U_REGEX_TIME_OUT = 66322,
    U_REGEX_STOPPED_BY_CALLER = 66323,
    U_REGEX_PATTERN_TOO_BIG = 66324,
    U_REGEX_INVALID_CAPTURE_GROUP_NAME = 66325,
    U_IDNA_PROHIBITED_ERROR = 66560,
    U_IDNA_ERROR_START = 66560,
    U_IDNA_UNASSIGNED_ERROR = 66561,
    U_IDNA_CHECK_BIDI_ERROR = 66562,
    U_IDNA_STD3_ASCII_RULES_ERROR = 66563,
    U_IDNA_ACE_PREFIX_ERROR = 66564,
    U_IDNA_VERIFICATION_ERROR = 66565,
    U_IDNA_LABEL_TOO_LONG_ERROR = 66566,
    U_IDNA_ZERO_LENGTH_LABEL_ERROR = 66567,
    U_IDNA_DOMAIN_NAME_TOO_LONG_ERROR = 66568,
    U_STRINGPREP_PROHIBITED_ERROR = 66560,
    U_STRINGPREP_UNASSIGNED_ERROR = 66561,
    U_STRINGPREP_CHECK_BIDI_ERROR = 66562,
    U_PLUGIN_ERROR_START = 66816,
    U_PLUGIN_TOO_HIGH = 66816,
    U_PLUGIN_DIDNT_SET_LEVEL = 66817,
}

enum UTraceLevel
{
    UTRACE_OFF = -1,
    UTRACE_ERROR = 0,
    UTRACE_WARNING = 3,
    UTRACE_OPEN_CLOSE = 5,
    UTRACE_INFO = 7,
    UTRACE_VERBOSE = 9,
}

enum UTraceFunctionNumber
{
    UTRACE_FUNCTION_START = 0,
    UTRACE_U_INIT = 0,
    UTRACE_U_CLEANUP = 1,
    UTRACE_CONVERSION_START = 4096,
    UTRACE_UCNV_OPEN = 4096,
    UTRACE_UCNV_OPEN_PACKAGE = 4097,
    UTRACE_UCNV_OPEN_ALGORITHMIC = 4098,
    UTRACE_UCNV_CLONE = 4099,
    UTRACE_UCNV_CLOSE = 4100,
    UTRACE_UCNV_FLUSH_CACHE = 4101,
    UTRACE_UCNV_LOAD = 4102,
    UTRACE_UCNV_UNLOAD = 4103,
    UTRACE_COLLATION_START = 8192,
    UTRACE_UCOL_OPEN = 8192,
    UTRACE_UCOL_CLOSE = 8193,
    UTRACE_UCOL_STRCOLL = 8194,
    UTRACE_UCOL_GET_SORTKEY = 8195,
    UTRACE_UCOL_GETLOCALE = 8196,
    UTRACE_UCOL_NEXTSORTKEYPART = 8197,
    UTRACE_UCOL_STRCOLLITER = 8198,
    UTRACE_UCOL_OPEN_FROM_SHORT_STRING = 8199,
    UTRACE_UCOL_STRCOLLUTF8 = 8200,
}

alias UTraceEntry = extern(Windows) void function(const(void)* context, int fnNumber);
alias UTraceExit = extern(Windows) void function(const(void)* context, int fnNumber, const(byte)* fmt, byte* args);
alias UTraceData = extern(Windows) void function(const(void)* context, int fnNumber, int level, const(byte)* fmt, byte* args);
enum UStringTrieResult
{
    USTRINGTRIE_NO_MATCH = 0,
    USTRINGTRIE_NO_VALUE = 1,
    USTRINGTRIE_FINAL_VALUE = 2,
    USTRINGTRIE_INTERMEDIATE_VALUE = 3,
}

enum UScriptCode
{
    USCRIPT_INVALID_CODE = -1,
    USCRIPT_COMMON = 0,
    USCRIPT_INHERITED = 1,
    USCRIPT_ARABIC = 2,
    USCRIPT_ARMENIAN = 3,
    USCRIPT_BENGALI = 4,
    USCRIPT_BOPOMOFO = 5,
    USCRIPT_CHEROKEE = 6,
    USCRIPT_COPTIC = 7,
    USCRIPT_CYRILLIC = 8,
    USCRIPT_DESERET = 9,
    USCRIPT_DEVANAGARI = 10,
    USCRIPT_ETHIOPIC = 11,
    USCRIPT_GEORGIAN = 12,
    USCRIPT_GOTHIC = 13,
    USCRIPT_GREEK = 14,
    USCRIPT_GUJARATI = 15,
    USCRIPT_GURMUKHI = 16,
    USCRIPT_HAN = 17,
    USCRIPT_HANGUL = 18,
    USCRIPT_HEBREW = 19,
    USCRIPT_HIRAGANA = 20,
    USCRIPT_KANNADA = 21,
    USCRIPT_KATAKANA = 22,
    USCRIPT_KHMER = 23,
    USCRIPT_LAO = 24,
    USCRIPT_LATIN = 25,
    USCRIPT_MALAYALAM = 26,
    USCRIPT_MONGOLIAN = 27,
    USCRIPT_MYANMAR = 28,
    USCRIPT_OGHAM = 29,
    USCRIPT_OLD_ITALIC = 30,
    USCRIPT_ORIYA = 31,
    USCRIPT_RUNIC = 32,
    USCRIPT_SINHALA = 33,
    USCRIPT_SYRIAC = 34,
    USCRIPT_TAMIL = 35,
    USCRIPT_TELUGU = 36,
    USCRIPT_THAANA = 37,
    USCRIPT_THAI = 38,
    USCRIPT_TIBETAN = 39,
    USCRIPT_CANADIAN_ABORIGINAL = 40,
    USCRIPT_UCAS = 40,
    USCRIPT_YI = 41,
    USCRIPT_TAGALOG = 42,
    USCRIPT_HANUNOO = 43,
    USCRIPT_BUHID = 44,
    USCRIPT_TAGBANWA = 45,
    USCRIPT_BRAILLE = 46,
    USCRIPT_CYPRIOT = 47,
    USCRIPT_LIMBU = 48,
    USCRIPT_LINEAR_B = 49,
    USCRIPT_OSMANYA = 50,
    USCRIPT_SHAVIAN = 51,
    USCRIPT_TAI_LE = 52,
    USCRIPT_UGARITIC = 53,
    USCRIPT_KATAKANA_OR_HIRAGANA = 54,
    USCRIPT_BUGINESE = 55,
    USCRIPT_GLAGOLITIC = 56,
    USCRIPT_KHAROSHTHI = 57,
    USCRIPT_SYLOTI_NAGRI = 58,
    USCRIPT_NEW_TAI_LUE = 59,
    USCRIPT_TIFINAGH = 60,
    USCRIPT_OLD_PERSIAN = 61,
    USCRIPT_BALINESE = 62,
    USCRIPT_BATAK = 63,
    USCRIPT_BLISSYMBOLS = 64,
    USCRIPT_BRAHMI = 65,
    USCRIPT_CHAM = 66,
    USCRIPT_CIRTH = 67,
    USCRIPT_OLD_CHURCH_SLAVONIC_CYRILLIC = 68,
    USCRIPT_DEMOTIC_EGYPTIAN = 69,
    USCRIPT_HIERATIC_EGYPTIAN = 70,
    USCRIPT_EGYPTIAN_HIEROGLYPHS = 71,
    USCRIPT_KHUTSURI = 72,
    USCRIPT_SIMPLIFIED_HAN = 73,
    USCRIPT_TRADITIONAL_HAN = 74,
    USCRIPT_PAHAWH_HMONG = 75,
    USCRIPT_OLD_HUNGARIAN = 76,
    USCRIPT_HARAPPAN_INDUS = 77,
    USCRIPT_JAVANESE = 78,
    USCRIPT_KAYAH_LI = 79,
    USCRIPT_LATIN_FRAKTUR = 80,
    USCRIPT_LATIN_GAELIC = 81,
    USCRIPT_LEPCHA = 82,
    USCRIPT_LINEAR_A = 83,
    USCRIPT_MANDAIC = 84,
    USCRIPT_MANDAEAN = 84,
    USCRIPT_MAYAN_HIEROGLYPHS = 85,
    USCRIPT_MEROITIC_HIEROGLYPHS = 86,
    USCRIPT_MEROITIC = 86,
    USCRIPT_NKO = 87,
    USCRIPT_ORKHON = 88,
    USCRIPT_OLD_PERMIC = 89,
    USCRIPT_PHAGS_PA = 90,
    USCRIPT_PHOENICIAN = 91,
    USCRIPT_MIAO = 92,
    USCRIPT_PHONETIC_POLLARD = 92,
    USCRIPT_RONGORONGO = 93,
    USCRIPT_SARATI = 94,
    USCRIPT_ESTRANGELO_SYRIAC = 95,
    USCRIPT_WESTERN_SYRIAC = 96,
    USCRIPT_EASTERN_SYRIAC = 97,
    USCRIPT_TENGWAR = 98,
    USCRIPT_VAI = 99,
    USCRIPT_VISIBLE_SPEECH = 100,
    USCRIPT_CUNEIFORM = 101,
    USCRIPT_UNWRITTEN_LANGUAGES = 102,
    USCRIPT_UNKNOWN = 103,
    USCRIPT_CARIAN = 104,
    USCRIPT_JAPANESE = 105,
    USCRIPT_LANNA = 106,
    USCRIPT_LYCIAN = 107,
    USCRIPT_LYDIAN = 108,
    USCRIPT_OL_CHIKI = 109,
    USCRIPT_REJANG = 110,
    USCRIPT_SAURASHTRA = 111,
    USCRIPT_SIGN_WRITING = 112,
    USCRIPT_SUNDANESE = 113,
    USCRIPT_MOON = 114,
    USCRIPT_MEITEI_MAYEK = 115,
    USCRIPT_IMPERIAL_ARAMAIC = 116,
    USCRIPT_AVESTAN = 117,
    USCRIPT_CHAKMA = 118,
    USCRIPT_KOREAN = 119,
    USCRIPT_KAITHI = 120,
    USCRIPT_MANICHAEAN = 121,
    USCRIPT_INSCRIPTIONAL_PAHLAVI = 122,
    USCRIPT_PSALTER_PAHLAVI = 123,
    USCRIPT_BOOK_PAHLAVI = 124,
    USCRIPT_INSCRIPTIONAL_PARTHIAN = 125,
    USCRIPT_SAMARITAN = 126,
    USCRIPT_TAI_VIET = 127,
    USCRIPT_MATHEMATICAL_NOTATION = 128,
    USCRIPT_SYMBOLS = 129,
    USCRIPT_BAMUM = 130,
    USCRIPT_LISU = 131,
    USCRIPT_NAKHI_GEBA = 132,
    USCRIPT_OLD_SOUTH_ARABIAN = 133,
    USCRIPT_BASSA_VAH = 134,
    USCRIPT_DUPLOYAN = 135,
    USCRIPT_ELBASAN = 136,
    USCRIPT_GRANTHA = 137,
    USCRIPT_KPELLE = 138,
    USCRIPT_LOMA = 139,
    USCRIPT_MENDE = 140,
    USCRIPT_MEROITIC_CURSIVE = 141,
    USCRIPT_OLD_NORTH_ARABIAN = 142,
    USCRIPT_NABATAEAN = 143,
    USCRIPT_PALMYRENE = 144,
    USCRIPT_KHUDAWADI = 145,
    USCRIPT_SINDHI = 145,
    USCRIPT_WARANG_CITI = 146,
    USCRIPT_AFAKA = 147,
    USCRIPT_JURCHEN = 148,
    USCRIPT_MRO = 149,
    USCRIPT_NUSHU = 150,
    USCRIPT_SHARADA = 151,
    USCRIPT_SORA_SOMPENG = 152,
    USCRIPT_TAKRI = 153,
    USCRIPT_TANGUT = 154,
    USCRIPT_WOLEAI = 155,
    USCRIPT_ANATOLIAN_HIEROGLYPHS = 156,
    USCRIPT_KHOJKI = 157,
    USCRIPT_TIRHUTA = 158,
    USCRIPT_CAUCASIAN_ALBANIAN = 159,
    USCRIPT_MAHAJANI = 160,
    USCRIPT_AHOM = 161,
    USCRIPT_HATRAN = 162,
    USCRIPT_MODI = 163,
    USCRIPT_MULTANI = 164,
    USCRIPT_PAU_CIN_HAU = 165,
    USCRIPT_SIDDHAM = 166,
    USCRIPT_ADLAM = 167,
    USCRIPT_BHAIKSUKI = 168,
    USCRIPT_MARCHEN = 169,
    USCRIPT_NEWA = 170,
    USCRIPT_OSAGE = 171,
    USCRIPT_HAN_WITH_BOPOMOFO = 172,
    USCRIPT_JAMO = 173,
    USCRIPT_SYMBOLS_EMOJI = 174,
    USCRIPT_MASARAM_GONDI = 175,
    USCRIPT_SOYOMBO = 176,
    USCRIPT_ZANABAZAR_SQUARE = 177,
    USCRIPT_DOGRA = 178,
    USCRIPT_GUNJALA_GONDI = 179,
    USCRIPT_MAKASAR = 180,
    USCRIPT_MEDEFAIDRIN = 181,
    USCRIPT_HANIFI_ROHINGYA = 182,
    USCRIPT_SOGDIAN = 183,
    USCRIPT_OLD_SOGDIAN = 184,
    USCRIPT_ELYMAIC = 185,
    USCRIPT_NYIAKENG_PUACHUE_HMONG = 186,
    USCRIPT_NANDINAGARI = 187,
    USCRIPT_WANCHO = 188,
}

enum UScriptUsage
{
    USCRIPT_USAGE_NOT_ENCODED = 0,
    USCRIPT_USAGE_UNKNOWN = 1,
    USCRIPT_USAGE_EXCLUDED = 2,
    USCRIPT_USAGE_LIMITED_USE = 3,
    USCRIPT_USAGE_ASPIRATIONAL = 4,
    USCRIPT_USAGE_RECOMMENDED = 5,
}

struct UReplaceableCallbacks
{
    int length;
    int charAt;
    int char32At;
    int replace;
    int extract;
    int copy;
}

struct UFieldPosition
{
    int field;
    int beginIndex;
    int endIndex;
}

enum UCharIteratorOrigin
{
    UITER_START = 0,
    UITER_CURRENT = 1,
    UITER_LIMIT = 2,
    UITER_ZERO = 3,
    UITER_LENGTH = 4,
}

alias UCharIteratorGetIndex = extern(Windows) int function(UCharIterator* iter, UCharIteratorOrigin origin);
alias UCharIteratorMove = extern(Windows) int function(UCharIterator* iter, int delta, UCharIteratorOrigin origin);
alias UCharIteratorHasNext = extern(Windows) byte function(UCharIterator* iter);
alias UCharIteratorHasPrevious = extern(Windows) byte function(UCharIterator* iter);
alias UCharIteratorCurrent = extern(Windows) int function(UCharIterator* iter);
alias UCharIteratorNext = extern(Windows) int function(UCharIterator* iter);
alias UCharIteratorPrevious = extern(Windows) int function(UCharIterator* iter);
alias UCharIteratorReserved = extern(Windows) int function(UCharIterator* iter, int something);
alias UCharIteratorGetState = extern(Windows) uint function(const(UCharIterator)* iter);
alias UCharIteratorSetState = extern(Windows) void function(UCharIterator* iter, uint state, UErrorCode* pErrorCode);
struct UCharIterator
{
    const(void)* context;
    int length;
    int start;
    int index;
    int limit;
    int reservedField;
    UCharIteratorGetIndex* getIndex;
    UCharIteratorMove* move;
    UCharIteratorHasNext* hasNext;
    UCharIteratorHasPrevious* hasPrevious;
    UCharIteratorCurrent* current;
    UCharIteratorNext* next;
    UCharIteratorPrevious* previous;
    UCharIteratorReserved* reservedFn;
    UCharIteratorGetState* getState;
    UCharIteratorSetState* setState;
}

struct UEnumeration
{
}

enum ULocDataLocaleType
{
    ULOC_ACTUAL_LOCALE = 0,
    ULOC_VALID_LOCALE = 1,
}

enum ULayoutType
{
    ULOC_LAYOUT_LTR = 0,
    ULOC_LAYOUT_RTL = 1,
    ULOC_LAYOUT_TTB = 2,
    ULOC_LAYOUT_BTT = 3,
    ULOC_LAYOUT_UNKNOWN = 4,
}

enum UAcceptResult
{
    ULOC_ACCEPT_FAILED = 0,
    ULOC_ACCEPT_VALID = 1,
    ULOC_ACCEPT_FALLBACK = 2,
}

struct UResourceBundle
{
}

enum UResType
{
    URES_NONE = -1,
    URES_STRING = 0,
    URES_BINARY = 1,
    URES_TABLE = 2,
    URES_ALIAS = 3,
    URES_INT = 7,
    URES_ARRAY = 8,
    URES_INT_VECTOR = 14,
}

enum UDisplayContextType
{
    UDISPCTX_TYPE_DIALECT_HANDLING = 0,
    UDISPCTX_TYPE_CAPITALIZATION = 1,
    UDISPCTX_TYPE_DISPLAY_LENGTH = 2,
    UDISPCTX_TYPE_SUBSTITUTE_HANDLING = 3,
}

enum UDisplayContext
{
    UDISPCTX_STANDARD_NAMES = 0,
    UDISPCTX_DIALECT_NAMES = 1,
    UDISPCTX_CAPITALIZATION_NONE = 256,
    UDISPCTX_CAPITALIZATION_FOR_MIDDLE_OF_SENTENCE = 257,
    UDISPCTX_CAPITALIZATION_FOR_BEGINNING_OF_SENTENCE = 258,
    UDISPCTX_CAPITALIZATION_FOR_UI_LIST_OR_MENU = 259,
    UDISPCTX_CAPITALIZATION_FOR_STANDALONE = 260,
    UDISPCTX_LENGTH_FULL = 512,
    UDISPCTX_LENGTH_SHORT = 513,
    UDISPCTX_SUBSTITUTE = 768,
    UDISPCTX_NO_SUBSTITUTE = 769,
}

enum UDialectHandling
{
    ULDN_STANDARD_NAMES = 0,
    ULDN_DIALECT_NAMES = 1,
}

struct ULocaleDisplayNames
{
}

enum UCurrencyUsage
{
    UCURR_USAGE_STANDARD = 0,
    UCURR_USAGE_CASH = 1,
}

enum UCurrNameStyle
{
    UCURR_SYMBOL_NAME = 0,
    UCURR_LONG_NAME = 1,
    UCURR_NARROW_SYMBOL_NAME = 2,
}

enum UCurrCurrencyType
{
    UCURR_ALL = 2147483647,
    UCURR_COMMON = 1,
    UCURR_UNCOMMON = 2,
    UCURR_DEPRECATED = 4,
    UCURR_NON_DEPRECATED = 8,
}

struct UConverter
{
}

enum UConverterCallbackReason
{
    UCNV_UNASSIGNED = 0,
    UCNV_ILLEGAL = 1,
    UCNV_IRREGULAR = 2,
    UCNV_RESET = 3,
    UCNV_CLOSE = 4,
    UCNV_CLONE = 5,
}

struct UConverterFromUnicodeArgs
{
    ushort size;
    byte flush;
    UConverter* converter;
    const(ushort)* source;
    const(ushort)* sourceLimit;
    byte* target;
    const(byte)* targetLimit;
    int* offsets;
}

struct UConverterToUnicodeArgs
{
    ushort size;
    byte flush;
    UConverter* converter;
    const(byte)* source;
    const(byte)* sourceLimit;
    ushort* target;
    const(ushort)* targetLimit;
    int* offsets;
}

struct USet
{
}

enum UConverterType
{
    UCNV_UNSUPPORTED_CONVERTER = -1,
    UCNV_SBCS = 0,
    UCNV_DBCS = 1,
    UCNV_MBCS = 2,
    UCNV_LATIN_1 = 3,
    UCNV_UTF8 = 4,
    UCNV_UTF16_BigEndian = 5,
    UCNV_UTF16_LittleEndian = 6,
    UCNV_UTF32_BigEndian = 7,
    UCNV_UTF32_LittleEndian = 8,
    UCNV_EBCDIC_STATEFUL = 9,
    UCNV_ISO_2022 = 10,
    UCNV_LMBCS_1 = 11,
    UCNV_LMBCS_2 = 12,
    UCNV_LMBCS_3 = 13,
    UCNV_LMBCS_4 = 14,
    UCNV_LMBCS_5 = 15,
    UCNV_LMBCS_6 = 16,
    UCNV_LMBCS_8 = 17,
    UCNV_LMBCS_11 = 18,
    UCNV_LMBCS_16 = 19,
    UCNV_LMBCS_17 = 20,
    UCNV_LMBCS_18 = 21,
    UCNV_LMBCS_19 = 22,
    UCNV_LMBCS_LAST = 22,
    UCNV_HZ = 23,
    UCNV_SCSU = 24,
    UCNV_ISCII = 25,
    UCNV_US_ASCII = 26,
    UCNV_UTF7 = 27,
    UCNV_BOCU1 = 28,
    UCNV_UTF16 = 29,
    UCNV_UTF32 = 30,
    UCNV_CESU8 = 31,
    UCNV_IMAP_MAILBOX = 32,
    UCNV_COMPOUND_TEXT = 33,
    UCNV_NUMBER_OF_SUPPORTED_CONVERTER_TYPES = 34,
}

enum UConverterPlatform
{
    UCNV_UNKNOWN = -1,
    UCNV_IBM = 0,
}

alias UConverterToUCallback = extern(Windows) void function(const(void)* context, UConverterToUnicodeArgs* args, const(byte)* codeUnits, int length, UConverterCallbackReason reason, UErrorCode* pErrorCode);
alias UConverterFromUCallback = extern(Windows) void function(const(void)* context, UConverterFromUnicodeArgs* args, const(ushort)* codeUnits, int length, int codePoint, UConverterCallbackReason reason, UErrorCode* pErrorCode);
enum UConverterUnicodeSet
{
    UCNV_ROUNDTRIP_SET = 0,
    UCNV_ROUNDTRIP_AND_FALLBACK_SET = 1,
}

alias UMemAllocFn = extern(Windows) void* function(const(void)* context, uint size);
alias UMemReallocFn = extern(Windows) void* function(const(void)* context, void* mem, uint size);
alias UMemFreeFn = extern(Windows) void function(const(void)* context, void* mem);
enum UProperty
{
    UCHAR_ALPHABETIC = 0,
    UCHAR_BINARY_START = 0,
    UCHAR_ASCII_HEX_DIGIT = 1,
    UCHAR_BIDI_CONTROL = 2,
    UCHAR_BIDI_MIRRORED = 3,
    UCHAR_DASH = 4,
    UCHAR_DEFAULT_IGNORABLE_CODE_POINT = 5,
    UCHAR_DEPRECATED = 6,
    UCHAR_DIACRITIC = 7,
    UCHAR_EXTENDER = 8,
    UCHAR_FULL_COMPOSITION_EXCLUSION = 9,
    UCHAR_GRAPHEME_BASE = 10,
    UCHAR_GRAPHEME_EXTEND = 11,
    UCHAR_GRAPHEME_LINK = 12,
    UCHAR_HEX_DIGIT = 13,
    UCHAR_HYPHEN = 14,
    UCHAR_ID_CONTINUE = 15,
    UCHAR_ID_START = 16,
    UCHAR_IDEOGRAPHIC = 17,
    UCHAR_IDS_BINARY_OPERATOR = 18,
    UCHAR_IDS_TRINARY_OPERATOR = 19,
    UCHAR_JOIN_CONTROL = 20,
    UCHAR_LOGICAL_ORDER_EXCEPTION = 21,
    UCHAR_LOWERCASE = 22,
    UCHAR_MATH = 23,
    UCHAR_NONCHARACTER_CODE_POINT = 24,
    UCHAR_QUOTATION_MARK = 25,
    UCHAR_RADICAL = 26,
    UCHAR_SOFT_DOTTED = 27,
    UCHAR_TERMINAL_PUNCTUATION = 28,
    UCHAR_UNIFIED_IDEOGRAPH = 29,
    UCHAR_UPPERCASE = 30,
    UCHAR_WHITE_SPACE = 31,
    UCHAR_XID_CONTINUE = 32,
    UCHAR_XID_START = 33,
    UCHAR_CASE_SENSITIVE = 34,
    UCHAR_S_TERM = 35,
    UCHAR_VARIATION_SELECTOR = 36,
    UCHAR_NFD_INERT = 37,
    UCHAR_NFKD_INERT = 38,
    UCHAR_NFC_INERT = 39,
    UCHAR_NFKC_INERT = 40,
    UCHAR_SEGMENT_STARTER = 41,
    UCHAR_PATTERN_SYNTAX = 42,
    UCHAR_PATTERN_WHITE_SPACE = 43,
    UCHAR_POSIX_ALNUM = 44,
    UCHAR_POSIX_BLANK = 45,
    UCHAR_POSIX_GRAPH = 46,
    UCHAR_POSIX_PRINT = 47,
    UCHAR_POSIX_XDIGIT = 48,
    UCHAR_CASED = 49,
    UCHAR_CASE_IGNORABLE = 50,
    UCHAR_CHANGES_WHEN_LOWERCASED = 51,
    UCHAR_CHANGES_WHEN_UPPERCASED = 52,
    UCHAR_CHANGES_WHEN_TITLECASED = 53,
    UCHAR_CHANGES_WHEN_CASEFOLDED = 54,
    UCHAR_CHANGES_WHEN_CASEMAPPED = 55,
    UCHAR_CHANGES_WHEN_NFKC_CASEFOLDED = 56,
    UCHAR_EMOJI = 57,
    UCHAR_EMOJI_PRESENTATION = 58,
    UCHAR_EMOJI_MODIFIER = 59,
    UCHAR_EMOJI_MODIFIER_BASE = 60,
    UCHAR_EMOJI_COMPONENT = 61,
    UCHAR_REGIONAL_INDICATOR = 62,
    UCHAR_PREPENDED_CONCATENATION_MARK = 63,
    UCHAR_EXTENDED_PICTOGRAPHIC = 64,
    UCHAR_BIDI_CLASS = 4096,
    UCHAR_INT_START = 4096,
    UCHAR_BLOCK = 4097,
    UCHAR_CANONICAL_COMBINING_CLASS = 4098,
    UCHAR_DECOMPOSITION_TYPE = 4099,
    UCHAR_EAST_ASIAN_WIDTH = 4100,
    UCHAR_GENERAL_CATEGORY = 4101,
    UCHAR_JOINING_GROUP = 4102,
    UCHAR_JOINING_TYPE = 4103,
    UCHAR_LINE_BREAK = 4104,
    UCHAR_NUMERIC_TYPE = 4105,
    UCHAR_SCRIPT = 4106,
    UCHAR_HANGUL_SYLLABLE_TYPE = 4107,
    UCHAR_NFD_QUICK_CHECK = 4108,
    UCHAR_NFKD_QUICK_CHECK = 4109,
    UCHAR_NFC_QUICK_CHECK = 4110,
    UCHAR_NFKC_QUICK_CHECK = 4111,
    UCHAR_LEAD_CANONICAL_COMBINING_CLASS = 4112,
    UCHAR_TRAIL_CANONICAL_COMBINING_CLASS = 4113,
    UCHAR_GRAPHEME_CLUSTER_BREAK = 4114,
    UCHAR_SENTENCE_BREAK = 4115,
    UCHAR_WORD_BREAK = 4116,
    UCHAR_BIDI_PAIRED_BRACKET_TYPE = 4117,
    UCHAR_INDIC_POSITIONAL_CATEGORY = 4118,
    UCHAR_INDIC_SYLLABIC_CATEGORY = 4119,
    UCHAR_VERTICAL_ORIENTATION = 4120,
    UCHAR_GENERAL_CATEGORY_MASK = 8192,
    UCHAR_MASK_START = 8192,
    UCHAR_NUMERIC_VALUE = 12288,
    UCHAR_DOUBLE_START = 12288,
    UCHAR_AGE = 16384,
    UCHAR_STRING_START = 16384,
    UCHAR_BIDI_MIRRORING_GLYPH = 16385,
    UCHAR_CASE_FOLDING = 16386,
    UCHAR_LOWERCASE_MAPPING = 16388,
    UCHAR_NAME = 16389,
    UCHAR_SIMPLE_CASE_FOLDING = 16390,
    UCHAR_SIMPLE_LOWERCASE_MAPPING = 16391,
    UCHAR_SIMPLE_TITLECASE_MAPPING = 16392,
    UCHAR_SIMPLE_UPPERCASE_MAPPING = 16393,
    UCHAR_TITLECASE_MAPPING = 16394,
    UCHAR_UPPERCASE_MAPPING = 16396,
    UCHAR_BIDI_PAIRED_BRACKET = 16397,
    UCHAR_SCRIPT_EXTENSIONS = 28672,
    UCHAR_OTHER_PROPERTY_START = 28672,
    UCHAR_INVALID_CODE = -1,
}

enum UCharCategory
{
    U_UNASSIGNED = 0,
    U_GENERAL_OTHER_TYPES = 0,
    U_UPPERCASE_LETTER = 1,
    U_LOWERCASE_LETTER = 2,
    U_TITLECASE_LETTER = 3,
    U_MODIFIER_LETTER = 4,
    U_OTHER_LETTER = 5,
    U_NON_SPACING_MARK = 6,
    U_ENCLOSING_MARK = 7,
    U_COMBINING_SPACING_MARK = 8,
    U_DECIMAL_DIGIT_NUMBER = 9,
    U_LETTER_NUMBER = 10,
    U_OTHER_NUMBER = 11,
    U_SPACE_SEPARATOR = 12,
    U_LINE_SEPARATOR = 13,
    U_PARAGRAPH_SEPARATOR = 14,
    U_CONTROL_CHAR = 15,
    U_FORMAT_CHAR = 16,
    U_PRIVATE_USE_CHAR = 17,
    U_SURROGATE = 18,
    U_DASH_PUNCTUATION = 19,
    U_START_PUNCTUATION = 20,
    U_END_PUNCTUATION = 21,
    U_CONNECTOR_PUNCTUATION = 22,
    U_OTHER_PUNCTUATION = 23,
    U_MATH_SYMBOL = 24,
    U_CURRENCY_SYMBOL = 25,
    U_MODIFIER_SYMBOL = 26,
    U_OTHER_SYMBOL = 27,
    U_INITIAL_PUNCTUATION = 28,
    U_FINAL_PUNCTUATION = 29,
    U_CHAR_CATEGORY_COUNT = 30,
}

enum UCharDirection
{
    U_LEFT_TO_RIGHT = 0,
    U_RIGHT_TO_LEFT = 1,
    U_EUROPEAN_NUMBER = 2,
    U_EUROPEAN_NUMBER_SEPARATOR = 3,
    U_EUROPEAN_NUMBER_TERMINATOR = 4,
    U_ARABIC_NUMBER = 5,
    U_COMMON_NUMBER_SEPARATOR = 6,
    U_BLOCK_SEPARATOR = 7,
    U_SEGMENT_SEPARATOR = 8,
    U_WHITE_SPACE_NEUTRAL = 9,
    U_OTHER_NEUTRAL = 10,
    U_LEFT_TO_RIGHT_EMBEDDING = 11,
    U_LEFT_TO_RIGHT_OVERRIDE = 12,
    U_RIGHT_TO_LEFT_ARABIC = 13,
    U_RIGHT_TO_LEFT_EMBEDDING = 14,
    U_RIGHT_TO_LEFT_OVERRIDE = 15,
    U_POP_DIRECTIONAL_FORMAT = 16,
    U_DIR_NON_SPACING_MARK = 17,
    U_BOUNDARY_NEUTRAL = 18,
    U_FIRST_STRONG_ISOLATE = 19,
    U_LEFT_TO_RIGHT_ISOLATE = 20,
    U_RIGHT_TO_LEFT_ISOLATE = 21,
    U_POP_DIRECTIONAL_ISOLATE = 22,
}

enum UBidiPairedBracketType
{
    U_BPT_NONE = 0,
    U_BPT_OPEN = 1,
    U_BPT_CLOSE = 2,
}

enum UBlockCode
{
    UBLOCK_NO_BLOCK = 0,
    UBLOCK_BASIC_LATIN = 1,
    UBLOCK_LATIN_1_SUPPLEMENT = 2,
    UBLOCK_LATIN_EXTENDED_A = 3,
    UBLOCK_LATIN_EXTENDED_B = 4,
    UBLOCK_IPA_EXTENSIONS = 5,
    UBLOCK_SPACING_MODIFIER_LETTERS = 6,
    UBLOCK_COMBINING_DIACRITICAL_MARKS = 7,
    UBLOCK_GREEK = 8,
    UBLOCK_CYRILLIC = 9,
    UBLOCK_ARMENIAN = 10,
    UBLOCK_HEBREW = 11,
    UBLOCK_ARABIC = 12,
    UBLOCK_SYRIAC = 13,
    UBLOCK_THAANA = 14,
    UBLOCK_DEVANAGARI = 15,
    UBLOCK_BENGALI = 16,
    UBLOCK_GURMUKHI = 17,
    UBLOCK_GUJARATI = 18,
    UBLOCK_ORIYA = 19,
    UBLOCK_TAMIL = 20,
    UBLOCK_TELUGU = 21,
    UBLOCK_KANNADA = 22,
    UBLOCK_MALAYALAM = 23,
    UBLOCK_SINHALA = 24,
    UBLOCK_THAI = 25,
    UBLOCK_LAO = 26,
    UBLOCK_TIBETAN = 27,
    UBLOCK_MYANMAR = 28,
    UBLOCK_GEORGIAN = 29,
    UBLOCK_HANGUL_JAMO = 30,
    UBLOCK_ETHIOPIC = 31,
    UBLOCK_CHEROKEE = 32,
    UBLOCK_UNIFIED_CANADIAN_ABORIGINAL_SYLLABICS = 33,
    UBLOCK_OGHAM = 34,
    UBLOCK_RUNIC = 35,
    UBLOCK_KHMER = 36,
    UBLOCK_MONGOLIAN = 37,
    UBLOCK_LATIN_EXTENDED_ADDITIONAL = 38,
    UBLOCK_GREEK_EXTENDED = 39,
    UBLOCK_GENERAL_PUNCTUATION = 40,
    UBLOCK_SUPERSCRIPTS_AND_SUBSCRIPTS = 41,
    UBLOCK_CURRENCY_SYMBOLS = 42,
    UBLOCK_COMBINING_MARKS_FOR_SYMBOLS = 43,
    UBLOCK_LETTERLIKE_SYMBOLS = 44,
    UBLOCK_NUMBER_FORMS = 45,
    UBLOCK_ARROWS = 46,
    UBLOCK_MATHEMATICAL_OPERATORS = 47,
    UBLOCK_MISCELLANEOUS_TECHNICAL = 48,
    UBLOCK_CONTROL_PICTURES = 49,
    UBLOCK_OPTICAL_CHARACTER_RECOGNITION = 50,
    UBLOCK_ENCLOSED_ALPHANUMERICS = 51,
    UBLOCK_BOX_DRAWING = 52,
    UBLOCK_BLOCK_ELEMENTS = 53,
    UBLOCK_GEOMETRIC_SHAPES = 54,
    UBLOCK_MISCELLANEOUS_SYMBOLS = 55,
    UBLOCK_DINGBATS = 56,
    UBLOCK_BRAILLE_PATTERNS = 57,
    UBLOCK_CJK_RADICALS_SUPPLEMENT = 58,
    UBLOCK_KANGXI_RADICALS = 59,
    UBLOCK_IDEOGRAPHIC_DESCRIPTION_CHARACTERS = 60,
    UBLOCK_CJK_SYMBOLS_AND_PUNCTUATION = 61,
    UBLOCK_HIRAGANA = 62,
    UBLOCK_KATAKANA = 63,
    UBLOCK_BOPOMOFO = 64,
    UBLOCK_HANGUL_COMPATIBILITY_JAMO = 65,
    UBLOCK_KANBUN = 66,
    UBLOCK_BOPOMOFO_EXTENDED = 67,
    UBLOCK_ENCLOSED_CJK_LETTERS_AND_MONTHS = 68,
    UBLOCK_CJK_COMPATIBILITY = 69,
    UBLOCK_CJK_UNIFIED_IDEOGRAPHS_EXTENSION_A = 70,
    UBLOCK_CJK_UNIFIED_IDEOGRAPHS = 71,
    UBLOCK_YI_SYLLABLES = 72,
    UBLOCK_YI_RADICALS = 73,
    UBLOCK_HANGUL_SYLLABLES = 74,
    UBLOCK_HIGH_SURROGATES = 75,
    UBLOCK_HIGH_PRIVATE_USE_SURROGATES = 76,
    UBLOCK_LOW_SURROGATES = 77,
    UBLOCK_PRIVATE_USE_AREA = 78,
    UBLOCK_PRIVATE_USE = 78,
    UBLOCK_CJK_COMPATIBILITY_IDEOGRAPHS = 79,
    UBLOCK_ALPHABETIC_PRESENTATION_FORMS = 80,
    UBLOCK_ARABIC_PRESENTATION_FORMS_A = 81,
    UBLOCK_COMBINING_HALF_MARKS = 82,
    UBLOCK_CJK_COMPATIBILITY_FORMS = 83,
    UBLOCK_SMALL_FORM_VARIANTS = 84,
    UBLOCK_ARABIC_PRESENTATION_FORMS_B = 85,
    UBLOCK_SPECIALS = 86,
    UBLOCK_HALFWIDTH_AND_FULLWIDTH_FORMS = 87,
    UBLOCK_OLD_ITALIC = 88,
    UBLOCK_GOTHIC = 89,
    UBLOCK_DESERET = 90,
    UBLOCK_BYZANTINE_MUSICAL_SYMBOLS = 91,
    UBLOCK_MUSICAL_SYMBOLS = 92,
    UBLOCK_MATHEMATICAL_ALPHANUMERIC_SYMBOLS = 93,
    UBLOCK_CJK_UNIFIED_IDEOGRAPHS_EXTENSION_B = 94,
    UBLOCK_CJK_COMPATIBILITY_IDEOGRAPHS_SUPPLEMENT = 95,
    UBLOCK_TAGS = 96,
    UBLOCK_CYRILLIC_SUPPLEMENT = 97,
    UBLOCK_CYRILLIC_SUPPLEMENTARY = 97,
    UBLOCK_TAGALOG = 98,
    UBLOCK_HANUNOO = 99,
    UBLOCK_BUHID = 100,
    UBLOCK_TAGBANWA = 101,
    UBLOCK_MISCELLANEOUS_MATHEMATICAL_SYMBOLS_A = 102,
    UBLOCK_SUPPLEMENTAL_ARROWS_A = 103,
    UBLOCK_SUPPLEMENTAL_ARROWS_B = 104,
    UBLOCK_MISCELLANEOUS_MATHEMATICAL_SYMBOLS_B = 105,
    UBLOCK_SUPPLEMENTAL_MATHEMATICAL_OPERATORS = 106,
    UBLOCK_KATAKANA_PHONETIC_EXTENSIONS = 107,
    UBLOCK_VARIATION_SELECTORS = 108,
    UBLOCK_SUPPLEMENTARY_PRIVATE_USE_AREA_A = 109,
    UBLOCK_SUPPLEMENTARY_PRIVATE_USE_AREA_B = 110,
    UBLOCK_LIMBU = 111,
    UBLOCK_TAI_LE = 112,
    UBLOCK_KHMER_SYMBOLS = 113,
    UBLOCK_PHONETIC_EXTENSIONS = 114,
    UBLOCK_MISCELLANEOUS_SYMBOLS_AND_ARROWS = 115,
    UBLOCK_YIJING_HEXAGRAM_SYMBOLS = 116,
    UBLOCK_LINEAR_B_SYLLABARY = 117,
    UBLOCK_LINEAR_B_IDEOGRAMS = 118,
    UBLOCK_AEGEAN_NUMBERS = 119,
    UBLOCK_UGARITIC = 120,
    UBLOCK_SHAVIAN = 121,
    UBLOCK_OSMANYA = 122,
    UBLOCK_CYPRIOT_SYLLABARY = 123,
    UBLOCK_TAI_XUAN_JING_SYMBOLS = 124,
    UBLOCK_VARIATION_SELECTORS_SUPPLEMENT = 125,
    UBLOCK_ANCIENT_GREEK_MUSICAL_NOTATION = 126,
    UBLOCK_ANCIENT_GREEK_NUMBERS = 127,
    UBLOCK_ARABIC_SUPPLEMENT = 128,
    UBLOCK_BUGINESE = 129,
    UBLOCK_CJK_STROKES = 130,
    UBLOCK_COMBINING_DIACRITICAL_MARKS_SUPPLEMENT = 131,
    UBLOCK_COPTIC = 132,
    UBLOCK_ETHIOPIC_EXTENDED = 133,
    UBLOCK_ETHIOPIC_SUPPLEMENT = 134,
    UBLOCK_GEORGIAN_SUPPLEMENT = 135,
    UBLOCK_GLAGOLITIC = 136,
    UBLOCK_KHAROSHTHI = 137,
    UBLOCK_MODIFIER_TONE_LETTERS = 138,
    UBLOCK_NEW_TAI_LUE = 139,
    UBLOCK_OLD_PERSIAN = 140,
    UBLOCK_PHONETIC_EXTENSIONS_SUPPLEMENT = 141,
    UBLOCK_SUPPLEMENTAL_PUNCTUATION = 142,
    UBLOCK_SYLOTI_NAGRI = 143,
    UBLOCK_TIFINAGH = 144,
    UBLOCK_VERTICAL_FORMS = 145,
    UBLOCK_NKO = 146,
    UBLOCK_BALINESE = 147,
    UBLOCK_LATIN_EXTENDED_C = 148,
    UBLOCK_LATIN_EXTENDED_D = 149,
    UBLOCK_PHAGS_PA = 150,
    UBLOCK_PHOENICIAN = 151,
    UBLOCK_CUNEIFORM = 152,
    UBLOCK_CUNEIFORM_NUMBERS_AND_PUNCTUATION = 153,
    UBLOCK_COUNTING_ROD_NUMERALS = 154,
    UBLOCK_SUNDANESE = 155,
    UBLOCK_LEPCHA = 156,
    UBLOCK_OL_CHIKI = 157,
    UBLOCK_CYRILLIC_EXTENDED_A = 158,
    UBLOCK_VAI = 159,
    UBLOCK_CYRILLIC_EXTENDED_B = 160,
    UBLOCK_SAURASHTRA = 161,
    UBLOCK_KAYAH_LI = 162,
    UBLOCK_REJANG = 163,
    UBLOCK_CHAM = 164,
    UBLOCK_ANCIENT_SYMBOLS = 165,
    UBLOCK_PHAISTOS_DISC = 166,
    UBLOCK_LYCIAN = 167,
    UBLOCK_CARIAN = 168,
    UBLOCK_LYDIAN = 169,
    UBLOCK_MAHJONG_TILES = 170,
    UBLOCK_DOMINO_TILES = 171,
    UBLOCK_SAMARITAN = 172,
    UBLOCK_UNIFIED_CANADIAN_ABORIGINAL_SYLLABICS_EXTENDED = 173,
    UBLOCK_TAI_THAM = 174,
    UBLOCK_VEDIC_EXTENSIONS = 175,
    UBLOCK_LISU = 176,
    UBLOCK_BAMUM = 177,
    UBLOCK_COMMON_INDIC_NUMBER_FORMS = 178,
    UBLOCK_DEVANAGARI_EXTENDED = 179,
    UBLOCK_HANGUL_JAMO_EXTENDED_A = 180,
    UBLOCK_JAVANESE = 181,
    UBLOCK_MYANMAR_EXTENDED_A = 182,
    UBLOCK_TAI_VIET = 183,
    UBLOCK_MEETEI_MAYEK = 184,
    UBLOCK_HANGUL_JAMO_EXTENDED_B = 185,
    UBLOCK_IMPERIAL_ARAMAIC = 186,
    UBLOCK_OLD_SOUTH_ARABIAN = 187,
    UBLOCK_AVESTAN = 188,
    UBLOCK_INSCRIPTIONAL_PARTHIAN = 189,
    UBLOCK_INSCRIPTIONAL_PAHLAVI = 190,
    UBLOCK_OLD_TURKIC = 191,
    UBLOCK_RUMI_NUMERAL_SYMBOLS = 192,
    UBLOCK_KAITHI = 193,
    UBLOCK_EGYPTIAN_HIEROGLYPHS = 194,
    UBLOCK_ENCLOSED_ALPHANUMERIC_SUPPLEMENT = 195,
    UBLOCK_ENCLOSED_IDEOGRAPHIC_SUPPLEMENT = 196,
    UBLOCK_CJK_UNIFIED_IDEOGRAPHS_EXTENSION_C = 197,
    UBLOCK_MANDAIC = 198,
    UBLOCK_BATAK = 199,
    UBLOCK_ETHIOPIC_EXTENDED_A = 200,
    UBLOCK_BRAHMI = 201,
    UBLOCK_BAMUM_SUPPLEMENT = 202,
    UBLOCK_KANA_SUPPLEMENT = 203,
    UBLOCK_PLAYING_CARDS = 204,
    UBLOCK_MISCELLANEOUS_SYMBOLS_AND_PICTOGRAPHS = 205,
    UBLOCK_EMOTICONS = 206,
    UBLOCK_TRANSPORT_AND_MAP_SYMBOLS = 207,
    UBLOCK_ALCHEMICAL_SYMBOLS = 208,
    UBLOCK_CJK_UNIFIED_IDEOGRAPHS_EXTENSION_D = 209,
    UBLOCK_ARABIC_EXTENDED_A = 210,
    UBLOCK_ARABIC_MATHEMATICAL_ALPHABETIC_SYMBOLS = 211,
    UBLOCK_CHAKMA = 212,
    UBLOCK_MEETEI_MAYEK_EXTENSIONS = 213,
    UBLOCK_MEROITIC_CURSIVE = 214,
    UBLOCK_MEROITIC_HIEROGLYPHS = 215,
    UBLOCK_MIAO = 216,
    UBLOCK_SHARADA = 217,
    UBLOCK_SORA_SOMPENG = 218,
    UBLOCK_SUNDANESE_SUPPLEMENT = 219,
    UBLOCK_TAKRI = 220,
    UBLOCK_BASSA_VAH = 221,
    UBLOCK_CAUCASIAN_ALBANIAN = 222,
    UBLOCK_COPTIC_EPACT_NUMBERS = 223,
    UBLOCK_COMBINING_DIACRITICAL_MARKS_EXTENDED = 224,
    UBLOCK_DUPLOYAN = 225,
    UBLOCK_ELBASAN = 226,
    UBLOCK_GEOMETRIC_SHAPES_EXTENDED = 227,
    UBLOCK_GRANTHA = 228,
    UBLOCK_KHOJKI = 229,
    UBLOCK_KHUDAWADI = 230,
    UBLOCK_LATIN_EXTENDED_E = 231,
    UBLOCK_LINEAR_A = 232,
    UBLOCK_MAHAJANI = 233,
    UBLOCK_MANICHAEAN = 234,
    UBLOCK_MENDE_KIKAKUI = 235,
    UBLOCK_MODI = 236,
    UBLOCK_MRO = 237,
    UBLOCK_MYANMAR_EXTENDED_B = 238,
    UBLOCK_NABATAEAN = 239,
    UBLOCK_OLD_NORTH_ARABIAN = 240,
    UBLOCK_OLD_PERMIC = 241,
    UBLOCK_ORNAMENTAL_DINGBATS = 242,
    UBLOCK_PAHAWH_HMONG = 243,
    UBLOCK_PALMYRENE = 244,
    UBLOCK_PAU_CIN_HAU = 245,
    UBLOCK_PSALTER_PAHLAVI = 246,
    UBLOCK_SHORTHAND_FORMAT_CONTROLS = 247,
    UBLOCK_SIDDHAM = 248,
    UBLOCK_SINHALA_ARCHAIC_NUMBERS = 249,
    UBLOCK_SUPPLEMENTAL_ARROWS_C = 250,
    UBLOCK_TIRHUTA = 251,
    UBLOCK_WARANG_CITI = 252,
    UBLOCK_AHOM = 253,
    UBLOCK_ANATOLIAN_HIEROGLYPHS = 254,
    UBLOCK_CHEROKEE_SUPPLEMENT = 255,
    UBLOCK_CJK_UNIFIED_IDEOGRAPHS_EXTENSION_E = 256,
    UBLOCK_EARLY_DYNASTIC_CUNEIFORM = 257,
    UBLOCK_HATRAN = 258,
    UBLOCK_MULTANI = 259,
    UBLOCK_OLD_HUNGARIAN = 260,
    UBLOCK_SUPPLEMENTAL_SYMBOLS_AND_PICTOGRAPHS = 261,
    UBLOCK_SUTTON_SIGNWRITING = 262,
    UBLOCK_ADLAM = 263,
    UBLOCK_BHAIKSUKI = 264,
    UBLOCK_CYRILLIC_EXTENDED_C = 265,
    UBLOCK_GLAGOLITIC_SUPPLEMENT = 266,
    UBLOCK_IDEOGRAPHIC_SYMBOLS_AND_PUNCTUATION = 267,
    UBLOCK_MARCHEN = 268,
    UBLOCK_MONGOLIAN_SUPPLEMENT = 269,
    UBLOCK_NEWA = 270,
    UBLOCK_OSAGE = 271,
    UBLOCK_TANGUT = 272,
    UBLOCK_TANGUT_COMPONENTS = 273,
    UBLOCK_CJK_UNIFIED_IDEOGRAPHS_EXTENSION_F = 274,
    UBLOCK_KANA_EXTENDED_A = 275,
    UBLOCK_MASARAM_GONDI = 276,
    UBLOCK_NUSHU = 277,
    UBLOCK_SOYOMBO = 278,
    UBLOCK_SYRIAC_SUPPLEMENT = 279,
    UBLOCK_ZANABAZAR_SQUARE = 280,
    UBLOCK_CHESS_SYMBOLS = 281,
    UBLOCK_DOGRA = 282,
    UBLOCK_GEORGIAN_EXTENDED = 283,
    UBLOCK_GUNJALA_GONDI = 284,
    UBLOCK_HANIFI_ROHINGYA = 285,
    UBLOCK_INDIC_SIYAQ_NUMBERS = 286,
    UBLOCK_MAKASAR = 287,
    UBLOCK_MAYAN_NUMERALS = 288,
    UBLOCK_MEDEFAIDRIN = 289,
    UBLOCK_OLD_SOGDIAN = 290,
    UBLOCK_SOGDIAN = 291,
    UBLOCK_EGYPTIAN_HIEROGLYPH_FORMAT_CONTROLS = 292,
    UBLOCK_ELYMAIC = 293,
    UBLOCK_NANDINAGARI = 294,
    UBLOCK_NYIAKENG_PUACHUE_HMONG = 295,
    UBLOCK_OTTOMAN_SIYAQ_NUMBERS = 296,
    UBLOCK_SMALL_KANA_EXTENSION = 297,
    UBLOCK_SYMBOLS_AND_PICTOGRAPHS_EXTENDED_A = 298,
    UBLOCK_TAMIL_SUPPLEMENT = 299,
    UBLOCK_WANCHO = 300,
    UBLOCK_INVALID_CODE = -1,
}

enum UEastAsianWidth
{
    U_EA_NEUTRAL = 0,
    U_EA_AMBIGUOUS = 1,
    U_EA_HALFWIDTH = 2,
    U_EA_FULLWIDTH = 3,
    U_EA_NARROW = 4,
    U_EA_WIDE = 5,
}

enum UCharNameChoice
{
    U_UNICODE_CHAR_NAME = 0,
    U_EXTENDED_CHAR_NAME = 2,
    U_CHAR_NAME_ALIAS = 3,
}

enum UPropertyNameChoice
{
    U_SHORT_PROPERTY_NAME = 0,
    U_LONG_PROPERTY_NAME = 1,
}

enum UDecompositionType
{
    U_DT_NONE = 0,
    U_DT_CANONICAL = 1,
    U_DT_COMPAT = 2,
    U_DT_CIRCLE = 3,
    U_DT_FINAL = 4,
    U_DT_FONT = 5,
    U_DT_FRACTION = 6,
    U_DT_INITIAL = 7,
    U_DT_ISOLATED = 8,
    U_DT_MEDIAL = 9,
    U_DT_NARROW = 10,
    U_DT_NOBREAK = 11,
    U_DT_SMALL = 12,
    U_DT_SQUARE = 13,
    U_DT_SUB = 14,
    U_DT_SUPER = 15,
    U_DT_VERTICAL = 16,
    U_DT_WIDE = 17,
}

enum UJoiningType
{
    U_JT_NON_JOINING = 0,
    U_JT_JOIN_CAUSING = 1,
    U_JT_DUAL_JOINING = 2,
    U_JT_LEFT_JOINING = 3,
    U_JT_RIGHT_JOINING = 4,
    U_JT_TRANSPARENT = 5,
}

enum UJoiningGroup
{
    U_JG_NO_JOINING_GROUP = 0,
    U_JG_AIN = 1,
    U_JG_ALAPH = 2,
    U_JG_ALEF = 3,
    U_JG_BEH = 4,
    U_JG_BETH = 5,
    U_JG_DAL = 6,
    U_JG_DALATH_RISH = 7,
    U_JG_E = 8,
    U_JG_FEH = 9,
    U_JG_FINAL_SEMKATH = 10,
    U_JG_GAF = 11,
    U_JG_GAMAL = 12,
    U_JG_HAH = 13,
    U_JG_TEH_MARBUTA_GOAL = 14,
    U_JG_HAMZA_ON_HEH_GOAL = 14,
    U_JG_HE = 15,
    U_JG_HEH = 16,
    U_JG_HEH_GOAL = 17,
    U_JG_HETH = 18,
    U_JG_KAF = 19,
    U_JG_KAPH = 20,
    U_JG_KNOTTED_HEH = 21,
    U_JG_LAM = 22,
    U_JG_LAMADH = 23,
    U_JG_MEEM = 24,
    U_JG_MIM = 25,
    U_JG_NOON = 26,
    U_JG_NUN = 27,
    U_JG_PE = 28,
    U_JG_QAF = 29,
    U_JG_QAPH = 30,
    U_JG_REH = 31,
    U_JG_REVERSED_PE = 32,
    U_JG_SAD = 33,
    U_JG_SADHE = 34,
    U_JG_SEEN = 35,
    U_JG_SEMKATH = 36,
    U_JG_SHIN = 37,
    U_JG_SWASH_KAF = 38,
    U_JG_SYRIAC_WAW = 39,
    U_JG_TAH = 40,
    U_JG_TAW = 41,
    U_JG_TEH_MARBUTA = 42,
    U_JG_TETH = 43,
    U_JG_WAW = 44,
    U_JG_YEH = 45,
    U_JG_YEH_BARREE = 46,
    U_JG_YEH_WITH_TAIL = 47,
    U_JG_YUDH = 48,
    U_JG_YUDH_HE = 49,
    U_JG_ZAIN = 50,
    U_JG_FE = 51,
    U_JG_KHAPH = 52,
    U_JG_ZHAIN = 53,
    U_JG_BURUSHASKI_YEH_BARREE = 54,
    U_JG_FARSI_YEH = 55,
    U_JG_NYA = 56,
    U_JG_ROHINGYA_YEH = 57,
    U_JG_MANICHAEAN_ALEPH = 58,
    U_JG_MANICHAEAN_AYIN = 59,
    U_JG_MANICHAEAN_BETH = 60,
    U_JG_MANICHAEAN_DALETH = 61,
    U_JG_MANICHAEAN_DHAMEDH = 62,
    U_JG_MANICHAEAN_FIVE = 63,
    U_JG_MANICHAEAN_GIMEL = 64,
    U_JG_MANICHAEAN_HETH = 65,
    U_JG_MANICHAEAN_HUNDRED = 66,
    U_JG_MANICHAEAN_KAPH = 67,
    U_JG_MANICHAEAN_LAMEDH = 68,
    U_JG_MANICHAEAN_MEM = 69,
    U_JG_MANICHAEAN_NUN = 70,
    U_JG_MANICHAEAN_ONE = 71,
    U_JG_MANICHAEAN_PE = 72,
    U_JG_MANICHAEAN_QOPH = 73,
    U_JG_MANICHAEAN_RESH = 74,
    U_JG_MANICHAEAN_SADHE = 75,
    U_JG_MANICHAEAN_SAMEKH = 76,
    U_JG_MANICHAEAN_TAW = 77,
    U_JG_MANICHAEAN_TEN = 78,
    U_JG_MANICHAEAN_TETH = 79,
    U_JG_MANICHAEAN_THAMEDH = 80,
    U_JG_MANICHAEAN_TWENTY = 81,
    U_JG_MANICHAEAN_WAW = 82,
    U_JG_MANICHAEAN_YODH = 83,
    U_JG_MANICHAEAN_ZAYIN = 84,
    U_JG_STRAIGHT_WAW = 85,
    U_JG_AFRICAN_FEH = 86,
    U_JG_AFRICAN_NOON = 87,
    U_JG_AFRICAN_QAF = 88,
    U_JG_MALAYALAM_BHA = 89,
    U_JG_MALAYALAM_JA = 90,
    U_JG_MALAYALAM_LLA = 91,
    U_JG_MALAYALAM_LLLA = 92,
    U_JG_MALAYALAM_NGA = 93,
    U_JG_MALAYALAM_NNA = 94,
    U_JG_MALAYALAM_NNNA = 95,
    U_JG_MALAYALAM_NYA = 96,
    U_JG_MALAYALAM_RA = 97,
    U_JG_MALAYALAM_SSA = 98,
    U_JG_MALAYALAM_TTA = 99,
    U_JG_HANIFI_ROHINGYA_KINNA_YA = 100,
    U_JG_HANIFI_ROHINGYA_PA = 101,
}

enum UGraphemeClusterBreak
{
    U_GCB_OTHER = 0,
    U_GCB_CONTROL = 1,
    U_GCB_CR = 2,
    U_GCB_EXTEND = 3,
    U_GCB_L = 4,
    U_GCB_LF = 5,
    U_GCB_LV = 6,
    U_GCB_LVT = 7,
    U_GCB_T = 8,
    U_GCB_V = 9,
    U_GCB_SPACING_MARK = 10,
    U_GCB_PREPEND = 11,
    U_GCB_REGIONAL_INDICATOR = 12,
    U_GCB_E_BASE = 13,
    U_GCB_E_BASE_GAZ = 14,
    U_GCB_E_MODIFIER = 15,
    U_GCB_GLUE_AFTER_ZWJ = 16,
    U_GCB_ZWJ = 17,
}

enum UWordBreakValues
{
    U_WB_OTHER = 0,
    U_WB_ALETTER = 1,
    U_WB_FORMAT = 2,
    U_WB_KATAKANA = 3,
    U_WB_MIDLETTER = 4,
    U_WB_MIDNUM = 5,
    U_WB_NUMERIC = 6,
    U_WB_EXTENDNUMLET = 7,
    U_WB_CR = 8,
    U_WB_EXTEND = 9,
    U_WB_LF = 10,
    U_WB_MIDNUMLET = 11,
    U_WB_NEWLINE = 12,
    U_WB_REGIONAL_INDICATOR = 13,
    U_WB_HEBREW_LETTER = 14,
    U_WB_SINGLE_QUOTE = 15,
    U_WB_DOUBLE_QUOTE = 16,
    U_WB_E_BASE = 17,
    U_WB_E_BASE_GAZ = 18,
    U_WB_E_MODIFIER = 19,
    U_WB_GLUE_AFTER_ZWJ = 20,
    U_WB_ZWJ = 21,
    U_WB_WSEGSPACE = 22,
}

enum USentenceBreak
{
    U_SB_OTHER = 0,
    U_SB_ATERM = 1,
    U_SB_CLOSE = 2,
    U_SB_FORMAT = 3,
    U_SB_LOWER = 4,
    U_SB_NUMERIC = 5,
    U_SB_OLETTER = 6,
    U_SB_SEP = 7,
    U_SB_SP = 8,
    U_SB_STERM = 9,
    U_SB_UPPER = 10,
    U_SB_CR = 11,
    U_SB_EXTEND = 12,
    U_SB_LF = 13,
    U_SB_SCONTINUE = 14,
}

enum ULineBreak
{
    U_LB_UNKNOWN = 0,
    U_LB_AMBIGUOUS = 1,
    U_LB_ALPHABETIC = 2,
    U_LB_BREAK_BOTH = 3,
    U_LB_BREAK_AFTER = 4,
    U_LB_BREAK_BEFORE = 5,
    U_LB_MANDATORY_BREAK = 6,
    U_LB_CONTINGENT_BREAK = 7,
    U_LB_CLOSE_PUNCTUATION = 8,
    U_LB_COMBINING_MARK = 9,
    U_LB_CARRIAGE_RETURN = 10,
    U_LB_EXCLAMATION = 11,
    U_LB_GLUE = 12,
    U_LB_HYPHEN = 13,
    U_LB_IDEOGRAPHIC = 14,
    U_LB_INSEPARABLE = 15,
    U_LB_INSEPERABLE = 15,
    U_LB_INFIX_NUMERIC = 16,
    U_LB_LINE_FEED = 17,
    U_LB_NONSTARTER = 18,
    U_LB_NUMERIC = 19,
    U_LB_OPEN_PUNCTUATION = 20,
    U_LB_POSTFIX_NUMERIC = 21,
    U_LB_PREFIX_NUMERIC = 22,
    U_LB_QUOTATION = 23,
    U_LB_COMPLEX_CONTEXT = 24,
    U_LB_SURROGATE = 25,
    U_LB_SPACE = 26,
    U_LB_BREAK_SYMBOLS = 27,
    U_LB_ZWSPACE = 28,
    U_LB_NEXT_LINE = 29,
    U_LB_WORD_JOINER = 30,
    U_LB_H2 = 31,
    U_LB_H3 = 32,
    U_LB_JL = 33,
    U_LB_JT = 34,
    U_LB_JV = 35,
    U_LB_CLOSE_PARENTHESIS = 36,
    U_LB_CONDITIONAL_JAPANESE_STARTER = 37,
    U_LB_HEBREW_LETTER = 38,
    U_LB_REGIONAL_INDICATOR = 39,
    U_LB_E_BASE = 40,
    U_LB_E_MODIFIER = 41,
    U_LB_ZWJ = 42,
}

enum UNumericType
{
    U_NT_NONE = 0,
    U_NT_DECIMAL = 1,
    U_NT_DIGIT = 2,
    U_NT_NUMERIC = 3,
}

enum UHangulSyllableType
{
    U_HST_NOT_APPLICABLE = 0,
    U_HST_LEADING_JAMO = 1,
    U_HST_VOWEL_JAMO = 2,
    U_HST_TRAILING_JAMO = 3,
    U_HST_LV_SYLLABLE = 4,
    U_HST_LVT_SYLLABLE = 5,
}

enum UIndicPositionalCategory
{
    U_INPC_NA = 0,
    U_INPC_BOTTOM = 1,
    U_INPC_BOTTOM_AND_LEFT = 2,
    U_INPC_BOTTOM_AND_RIGHT = 3,
    U_INPC_LEFT = 4,
    U_INPC_LEFT_AND_RIGHT = 5,
    U_INPC_OVERSTRUCK = 6,
    U_INPC_RIGHT = 7,
    U_INPC_TOP = 8,
    U_INPC_TOP_AND_BOTTOM = 9,
    U_INPC_TOP_AND_BOTTOM_AND_RIGHT = 10,
    U_INPC_TOP_AND_LEFT = 11,
    U_INPC_TOP_AND_LEFT_AND_RIGHT = 12,
    U_INPC_TOP_AND_RIGHT = 13,
    U_INPC_VISUAL_ORDER_LEFT = 14,
}

enum UIndicSyllabicCategory
{
    U_INSC_OTHER = 0,
    U_INSC_AVAGRAHA = 1,
    U_INSC_BINDU = 2,
    U_INSC_BRAHMI_JOINING_NUMBER = 3,
    U_INSC_CANTILLATION_MARK = 4,
    U_INSC_CONSONANT = 5,
    U_INSC_CONSONANT_DEAD = 6,
    U_INSC_CONSONANT_FINAL = 7,
    U_INSC_CONSONANT_HEAD_LETTER = 8,
    U_INSC_CONSONANT_INITIAL_POSTFIXED = 9,
    U_INSC_CONSONANT_KILLER = 10,
    U_INSC_CONSONANT_MEDIAL = 11,
    U_INSC_CONSONANT_PLACEHOLDER = 12,
    U_INSC_CONSONANT_PRECEDING_REPHA = 13,
    U_INSC_CONSONANT_PREFIXED = 14,
    U_INSC_CONSONANT_SUBJOINED = 15,
    U_INSC_CONSONANT_SUCCEEDING_REPHA = 16,
    U_INSC_CONSONANT_WITH_STACKER = 17,
    U_INSC_GEMINATION_MARK = 18,
    U_INSC_INVISIBLE_STACKER = 19,
    U_INSC_JOINER = 20,
    U_INSC_MODIFYING_LETTER = 21,
    U_INSC_NON_JOINER = 22,
    U_INSC_NUKTA = 23,
    U_INSC_NUMBER = 24,
    U_INSC_NUMBER_JOINER = 25,
    U_INSC_PURE_KILLER = 26,
    U_INSC_REGISTER_SHIFTER = 27,
    U_INSC_SYLLABLE_MODIFIER = 28,
    U_INSC_TONE_LETTER = 29,
    U_INSC_TONE_MARK = 30,
    U_INSC_VIRAMA = 31,
    U_INSC_VISARGA = 32,
    U_INSC_VOWEL = 33,
    U_INSC_VOWEL_DEPENDENT = 34,
    U_INSC_VOWEL_INDEPENDENT = 35,
}

enum UVerticalOrientation
{
    U_VO_ROTATED = 0,
    U_VO_TRANSFORMED_ROTATED = 1,
    U_VO_TRANSFORMED_UPRIGHT = 2,
    U_VO_UPRIGHT = 3,
}

alias UCharEnumTypeRange = extern(Windows) byte function(const(void)* context, int start, int limit, UCharCategory type);
alias UEnumCharNamesFn = extern(Windows) byte function(void* context, int code, UCharNameChoice nameChoice, const(byte)* name, int length);
enum UBiDiDirection
{
    UBIDI_LTR = 0,
    UBIDI_RTL = 1,
    UBIDI_MIXED = 2,
    UBIDI_NEUTRAL = 3,
}

struct UBiDi
{
}

enum UBiDiReorderingMode
{
    UBIDI_REORDER_DEFAULT = 0,
    UBIDI_REORDER_NUMBERS_SPECIAL = 1,
    UBIDI_REORDER_GROUP_NUMBERS_WITH_R = 2,
    UBIDI_REORDER_RUNS_ONLY = 3,
    UBIDI_REORDER_INVERSE_NUMBERS_AS_L = 4,
    UBIDI_REORDER_INVERSE_LIKE_DIRECT = 5,
    UBIDI_REORDER_INVERSE_FOR_NUMBERS_SPECIAL = 6,
}

enum UBiDiReorderingOption
{
    UBIDI_OPTION_DEFAULT = 0,
    UBIDI_OPTION_INSERT_MARKS = 1,
    UBIDI_OPTION_REMOVE_CONTROLS = 2,
    UBIDI_OPTION_STREAMING = 4,
}

alias UBiDiClassCallback = extern(Windows) UCharDirection function(const(void)* context, int c);
enum UBiDiOrder
{
    UBIDI_LOGICAL = 0,
    UBIDI_VISUAL = 1,
}

enum UBiDiMirroring
{
    UBIDI_MIRRORING_OFF = 0,
    UBIDI_MIRRORING_ON = 1,
}

struct UBiDiTransform
{
}

alias UTextClone = extern(Windows) UText* function(UText* dest, const(UText)* src, byte deep, UErrorCode* status);
alias UTextNativeLength = extern(Windows) long function(UText* ut);
alias UTextAccess = extern(Windows) byte function(UText* ut, long nativeIndex, byte forward);
alias UTextExtract = extern(Windows) int function(UText* ut, long nativeStart, long nativeLimit, ushort* dest, int destCapacity, UErrorCode* status);
alias UTextReplace = extern(Windows) int function(UText* ut, long nativeStart, long nativeLimit, const(ushort)* replacementText, int replacmentLength, UErrorCode* status);
alias UTextCopy = extern(Windows) void function(UText* ut, long nativeStart, long nativeLimit, long nativeDest, byte move, UErrorCode* status);
alias UTextMapOffsetToNative = extern(Windows) long function(const(UText)* ut);
alias UTextMapNativeIndexToUTF16 = extern(Windows) int function(const(UText)* ut, long nativeIndex);
alias UTextClose = extern(Windows) void function(UText* ut);
struct UTextFuncs
{
    int tableSize;
    int reserved1;
    int reserved2;
    int reserved3;
    UTextClone* clone;
    UTextNativeLength* nativeLength;
    UTextAccess* access;
    UTextExtract* extract;
    UTextReplace* replace;
    UTextCopy* copy;
    UTextMapOffsetToNative* mapOffsetToNative;
    UTextMapNativeIndexToUTF16* mapNativeIndexToUTF16;
    UTextClose* close;
    UTextClose* spare1;
    UTextClose* spare2;
    UTextClose* spare3;
}

struct UText
{
    uint magic;
    int flags;
    int providerProperties;
    int sizeOfStruct;
    long chunkNativeLimit;
    int extraSize;
    int nativeIndexingLimit;
    long chunkNativeStart;
    int chunkOffset;
    int chunkLength;
    const(ushort)* chunkContents;
    const(UTextFuncs)* pFuncs;
    void* pExtra;
    const(void)* context;
    const(void)* p;
    const(void)* q;
    const(void)* r;
    void* privP;
    long a;
    int b;
    int c;
    long privA;
    int privB;
    int privC;
}

enum USetSpanCondition
{
    USET_SPAN_NOT_CONTAINED = 0,
    USET_SPAN_CONTAINED = 1,
    USET_SPAN_SIMPLE = 2,
}

struct USerializedSet
{
    const(ushort)* array;
    int bmpLength;
    int length;
    ushort staticArray;
}

enum UNormalization2Mode
{
    UNORM2_COMPOSE = 0,
    UNORM2_DECOMPOSE = 1,
    UNORM2_FCD = 2,
    UNORM2_COMPOSE_CONTIGUOUS = 3,
}

enum UNormalizationCheckResult
{
    UNORM_NO = 0,
    UNORM_YES = 1,
    UNORM_MAYBE = 2,
}

struct UNormalizer2
{
}

enum UNormalizationMode
{
    UNORM_NONE = 1,
    UNORM_NFD = 2,
    UNORM_NFKD = 3,
    UNORM_NFC = 4,
    UNORM_DEFAULT = 4,
    UNORM_NFKC = 5,
    UNORM_FCD = 6,
    UNORM_MODE_COUNT = 7,
}

struct UConverterSelector
{
}

struct UBreakIterator
{
}

alias UNESCAPE_CHAR_AT = extern(Windows) ushort function(int offset, void* context);
struct UCaseMap
{
}

struct UParseError
{
    int line;
    int offset;
    ushort preContext;
    ushort postContext;
}

struct UStringPrepProfile
{
}

enum UStringPrepProfileType
{
    USPREP_RFC3491_NAMEPREP = 0,
    USPREP_RFC3530_NFS4_CS_PREP = 1,
    USPREP_RFC3530_NFS4_CS_PREP_CI = 2,
    USPREP_RFC3530_NFS4_CIS_PREP = 3,
    USPREP_RFC3530_NFS4_MIXED_PREP_PREFIX = 4,
    USPREP_RFC3530_NFS4_MIXED_PREP_SUFFIX = 5,
    USPREP_RFC3722_ISCSI = 6,
    USPREP_RFC3920_NODEPREP = 7,
    USPREP_RFC3920_RESOURCEPREP = 8,
    USPREP_RFC4011_MIB = 9,
    USPREP_RFC4013_SASLPREP = 10,
    USPREP_RFC4505_TRACE = 11,
    USPREP_RFC4518_LDAP = 12,
    USPREP_RFC4518_LDAP_CI = 13,
}

struct UIDNA
{
}

struct UIDNAInfo
{
    short size;
    byte isTransitionalDifferent;
    byte reservedB3;
    uint errors;
    int reservedI2;
    int reservedI3;
}

enum UBreakIteratorType
{
    UBRK_CHARACTER = 0,
    UBRK_WORD = 1,
    UBRK_LINE = 2,
    UBRK_SENTENCE = 3,
}

enum UWordBreak
{
    UBRK_WORD_NONE = 0,
    UBRK_WORD_NONE_LIMIT = 100,
    UBRK_WORD_NUMBER = 100,
    UBRK_WORD_NUMBER_LIMIT = 200,
    UBRK_WORD_LETTER = 200,
    UBRK_WORD_LETTER_LIMIT = 300,
    UBRK_WORD_KANA = 300,
    UBRK_WORD_KANA_LIMIT = 400,
    UBRK_WORD_IDEO = 400,
    UBRK_WORD_IDEO_LIMIT = 500,
}

enum ULineBreakTag
{
    UBRK_LINE_SOFT = 0,
    UBRK_LINE_SOFT_LIMIT = 100,
    UBRK_LINE_HARD = 100,
    UBRK_LINE_HARD_LIMIT = 200,
}

enum USentenceBreakTag
{
    UBRK_SENTENCE_TERM = 0,
    UBRK_SENTENCE_TERM_LIMIT = 100,
    UBRK_SENTENCE_SEP = 100,
    UBRK_SENTENCE_SEP_LIMIT = 200,
}

enum UCalendarType
{
    UCAL_TRADITIONAL = 0,
    UCAL_DEFAULT = 0,
    UCAL_GREGORIAN = 1,
}

enum UCalendarDateFields
{
    UCAL_ERA = 0,
    UCAL_YEAR = 1,
    UCAL_MONTH = 2,
    UCAL_WEEK_OF_YEAR = 3,
    UCAL_WEEK_OF_MONTH = 4,
    UCAL_DATE = 5,
    UCAL_DAY_OF_YEAR = 6,
    UCAL_DAY_OF_WEEK = 7,
    UCAL_DAY_OF_WEEK_IN_MONTH = 8,
    UCAL_AM_PM = 9,
    UCAL_HOUR = 10,
    UCAL_HOUR_OF_DAY = 11,
    UCAL_MINUTE = 12,
    UCAL_SECOND = 13,
    UCAL_MILLISECOND = 14,
    UCAL_ZONE_OFFSET = 15,
    UCAL_DST_OFFSET = 16,
    UCAL_YEAR_WOY = 17,
    UCAL_DOW_LOCAL = 18,
    UCAL_EXTENDED_YEAR = 19,
    UCAL_JULIAN_DAY = 20,
    UCAL_MILLISECONDS_IN_DAY = 21,
    UCAL_IS_LEAP_MONTH = 22,
    UCAL_FIELD_COUNT = 23,
    UCAL_DAY_OF_MONTH = 5,
}

enum UCalendarDaysOfWeek
{
    UCAL_SUNDAY = 1,
    UCAL_MONDAY = 2,
    UCAL_TUESDAY = 3,
    UCAL_WEDNESDAY = 4,
    UCAL_THURSDAY = 5,
    UCAL_FRIDAY = 6,
    UCAL_SATURDAY = 7,
}

enum UCalendarMonths
{
    UCAL_JANUARY = 0,
    UCAL_FEBRUARY = 1,
    UCAL_MARCH = 2,
    UCAL_APRIL = 3,
    UCAL_MAY = 4,
    UCAL_JUNE = 5,
    UCAL_JULY = 6,
    UCAL_AUGUST = 7,
    UCAL_SEPTEMBER = 8,
    UCAL_OCTOBER = 9,
    UCAL_NOVEMBER = 10,
    UCAL_DECEMBER = 11,
    UCAL_UNDECIMBER = 12,
}

enum UCalendarAMPMs
{
    UCAL_AM = 0,
    UCAL_PM = 1,
}

enum USystemTimeZoneType
{
    UCAL_ZONE_TYPE_ANY = 0,
    UCAL_ZONE_TYPE_CANONICAL = 1,
    UCAL_ZONE_TYPE_CANONICAL_LOCATION = 2,
}

enum UCalendarDisplayNameType
{
    UCAL_STANDARD = 0,
    UCAL_SHORT_STANDARD = 1,
    UCAL_DST = 2,
    UCAL_SHORT_DST = 3,
}

enum UCalendarAttribute
{
    UCAL_LENIENT = 0,
    UCAL_FIRST_DAY_OF_WEEK = 1,
    UCAL_MINIMAL_DAYS_IN_FIRST_WEEK = 2,
    UCAL_REPEATED_WALL_TIME = 3,
    UCAL_SKIPPED_WALL_TIME = 4,
}

enum UCalendarWallTimeOption
{
    UCAL_WALLTIME_LAST = 0,
    UCAL_WALLTIME_FIRST = 1,
    UCAL_WALLTIME_NEXT_VALID = 2,
}

enum UCalendarLimitType
{
    UCAL_MINIMUM = 0,
    UCAL_MAXIMUM = 1,
    UCAL_GREATEST_MINIMUM = 2,
    UCAL_LEAST_MAXIMUM = 3,
    UCAL_ACTUAL_MINIMUM = 4,
    UCAL_ACTUAL_MAXIMUM = 5,
}

enum UCalendarWeekdayType
{
    UCAL_WEEKDAY = 0,
    UCAL_WEEKEND = 1,
    UCAL_WEEKEND_ONSET = 2,
    UCAL_WEEKEND_CEASE = 3,
}

enum UTimeZoneTransitionType
{
    UCAL_TZ_TRANSITION_NEXT = 0,
    UCAL_TZ_TRANSITION_NEXT_INCLUSIVE = 1,
    UCAL_TZ_TRANSITION_PREVIOUS = 2,
    UCAL_TZ_TRANSITION_PREVIOUS_INCLUSIVE = 3,
}

struct UCollator
{
}

enum UCollationResult
{
    UCOL_EQUAL = 0,
    UCOL_GREATER = 1,
    UCOL_LESS = -1,
}

enum UColAttributeValue
{
    UCOL_DEFAULT = -1,
    UCOL_PRIMARY = 0,
    UCOL_SECONDARY = 1,
    UCOL_TERTIARY = 2,
    UCOL_DEFAULT_STRENGTH = 2,
    UCOL_CE_STRENGTH_LIMIT = 3,
    UCOL_QUATERNARY = 3,
    UCOL_IDENTICAL = 15,
    UCOL_STRENGTH_LIMIT = 16,
    UCOL_OFF = 16,
    UCOL_ON = 17,
    UCOL_SHIFTED = 20,
    UCOL_NON_IGNORABLE = 21,
    UCOL_LOWER_FIRST = 24,
    UCOL_UPPER_FIRST = 25,
}

enum UColReorderCode
{
    UCOL_REORDER_CODE_DEFAULT = -1,
    UCOL_REORDER_CODE_NONE = 103,
    UCOL_REORDER_CODE_OTHERS = 103,
    UCOL_REORDER_CODE_SPACE = 4096,
    UCOL_REORDER_CODE_FIRST = 4096,
    UCOL_REORDER_CODE_PUNCTUATION = 4097,
    UCOL_REORDER_CODE_SYMBOL = 4098,
    UCOL_REORDER_CODE_CURRENCY = 4099,
    UCOL_REORDER_CODE_DIGIT = 4100,
}

enum UColAttribute
{
    UCOL_FRENCH_COLLATION = 0,
    UCOL_ALTERNATE_HANDLING = 1,
    UCOL_CASE_FIRST = 2,
    UCOL_CASE_LEVEL = 3,
    UCOL_NORMALIZATION_MODE = 4,
    UCOL_DECOMPOSITION_MODE = 4,
    UCOL_STRENGTH = 5,
    UCOL_NUMERIC_COLLATION = 7,
    UCOL_ATTRIBUTE_COUNT = 8,
}

enum UColRuleOption
{
    UCOL_TAILORING_ONLY = 0,
    UCOL_FULL_RULES = 1,
}

enum UColBoundMode
{
    UCOL_BOUND_LOWER = 0,
    UCOL_BOUND_UPPER = 1,
    UCOL_BOUND_UPPER_LONG = 2,
}

struct UCollationElements
{
}

struct UCharsetDetector
{
}

struct UCharsetMatch
{
}

enum UDateTimePatternField
{
    UDATPG_ERA_FIELD = 0,
    UDATPG_YEAR_FIELD = 1,
    UDATPG_QUARTER_FIELD = 2,
    UDATPG_MONTH_FIELD = 3,
    UDATPG_WEEK_OF_YEAR_FIELD = 4,
    UDATPG_WEEK_OF_MONTH_FIELD = 5,
    UDATPG_WEEKDAY_FIELD = 6,
    UDATPG_DAY_OF_YEAR_FIELD = 7,
    UDATPG_DAY_OF_WEEK_IN_MONTH_FIELD = 8,
    UDATPG_DAY_FIELD = 9,
    UDATPG_DAYPERIOD_FIELD = 10,
    UDATPG_HOUR_FIELD = 11,
    UDATPG_MINUTE_FIELD = 12,
    UDATPG_SECOND_FIELD = 13,
    UDATPG_FRACTIONAL_SECOND_FIELD = 14,
    UDATPG_ZONE_FIELD = 15,
    UDATPG_FIELD_COUNT = 16,
}

enum UDateTimePGDisplayWidth
{
    UDATPG_WIDE = 0,
    UDATPG_ABBREVIATED = 1,
    UDATPG_NARROW = 2,
}

enum UDateTimePatternMatchOptions
{
    UDATPG_MATCH_NO_OPTIONS = 0,
    UDATPG_MATCH_HOUR_FIELD_LENGTH = 2048,
    UDATPG_MATCH_ALL_FIELDS_LENGTH = 65535,
}

enum UDateTimePatternConflict
{
    UDATPG_NO_CONFLICT = 0,
    UDATPG_BASE_CONFLICT = 1,
    UDATPG_CONFLICT = 2,
}

struct UFieldPositionIterator
{
}

enum UFormattableType
{
    UFMT_DATE = 0,
    UFMT_DOUBLE = 1,
    UFMT_LONG = 2,
    UFMT_STRING = 3,
    UFMT_ARRAY = 4,
    UFMT_INT64 = 5,
    UFMT_OBJECT = 6,
}

struct UDateIntervalFormat
{
}

enum UGender
{
    UGENDER_MALE = 0,
    UGENDER_FEMALE = 1,
    UGENDER_OTHER = 2,
}

struct UGenderInfo
{
}

struct UListFormatter
{
}

struct ULocaleData
{
}

enum ULocaleDataExemplarSetType
{
    ULOCDATA_ES_STANDARD = 0,
    ULOCDATA_ES_AUXILIARY = 1,
    ULOCDATA_ES_INDEX = 2,
    ULOCDATA_ES_PUNCTUATION = 3,
}

enum ULocaleDataDelimiterType
{
    ULOCDATA_QUOTATION_START = 0,
    ULOCDATA_QUOTATION_END = 1,
    ULOCDATA_ALT_QUOTATION_START = 2,
    ULOCDATA_ALT_QUOTATION_END = 3,
}

enum UMeasurementSystem
{
    UMS_SI = 0,
    UMS_US = 1,
    UMS_UK = 2,
}

enum UNumberFormatStyle
{
    UNUM_PATTERN_DECIMAL = 0,
    UNUM_DECIMAL = 1,
    UNUM_CURRENCY = 2,
    UNUM_PERCENT = 3,
    UNUM_SCIENTIFIC = 4,
    UNUM_SPELLOUT = 5,
    UNUM_ORDINAL = 6,
    UNUM_DURATION = 7,
    UNUM_NUMBERING_SYSTEM = 8,
    UNUM_PATTERN_RULEBASED = 9,
    UNUM_CURRENCY_ISO = 10,
    UNUM_CURRENCY_PLURAL = 11,
    UNUM_CURRENCY_ACCOUNTING = 12,
    UNUM_CASH_CURRENCY = 13,
    UNUM_DECIMAL_COMPACT_SHORT = 14,
    UNUM_DECIMAL_COMPACT_LONG = 15,
    UNUM_CURRENCY_STANDARD = 16,
    UNUM_DEFAULT = 1,
    UNUM_IGNORE = 0,
}

enum UNumberFormatRoundingMode
{
    UNUM_ROUND_CEILING = 0,
    UNUM_ROUND_FLOOR = 1,
    UNUM_ROUND_DOWN = 2,
    UNUM_ROUND_UP = 3,
    UNUM_ROUND_HALFEVEN = 4,
    UNUM_ROUND_HALFDOWN = 5,
    UNUM_ROUND_HALFUP = 6,
    UNUM_ROUND_UNNECESSARY = 7,
}

enum UNumberFormatPadPosition
{
    UNUM_PAD_BEFORE_PREFIX = 0,
    UNUM_PAD_AFTER_PREFIX = 1,
    UNUM_PAD_BEFORE_SUFFIX = 2,
    UNUM_PAD_AFTER_SUFFIX = 3,
}

enum UNumberCompactStyle
{
    UNUM_SHORT = 0,
    UNUM_LONG = 1,
}

enum UCurrencySpacing
{
    UNUM_CURRENCY_MATCH = 0,
    UNUM_CURRENCY_SURROUNDING_MATCH = 1,
    UNUM_CURRENCY_INSERT = 2,
    UNUM_CURRENCY_SPACING_COUNT = 3,
}

enum UNumberFormatFields
{
    UNUM_INTEGER_FIELD = 0,
    UNUM_FRACTION_FIELD = 1,
    UNUM_DECIMAL_SEPARATOR_FIELD = 2,
    UNUM_EXPONENT_SYMBOL_FIELD = 3,
    UNUM_EXPONENT_SIGN_FIELD = 4,
    UNUM_EXPONENT_FIELD = 5,
    UNUM_GROUPING_SEPARATOR_FIELD = 6,
    UNUM_CURRENCY_FIELD = 7,
    UNUM_PERCENT_FIELD = 8,
    UNUM_PERMILL_FIELD = 9,
    UNUM_SIGN_FIELD = 10,
}

enum UNumberFormatAttributeValue
{
    UNUM_FORMAT_ATTRIBUTE_VALUE_HIDDEN = 0,
}

enum UNumberFormatAttribute
{
    UNUM_PARSE_INT_ONLY = 0,
    UNUM_GROUPING_USED = 1,
    UNUM_DECIMAL_ALWAYS_SHOWN = 2,
    UNUM_MAX_INTEGER_DIGITS = 3,
    UNUM_MIN_INTEGER_DIGITS = 4,
    UNUM_INTEGER_DIGITS = 5,
    UNUM_MAX_FRACTION_DIGITS = 6,
    UNUM_MIN_FRACTION_DIGITS = 7,
    UNUM_FRACTION_DIGITS = 8,
    UNUM_MULTIPLIER = 9,
    UNUM_GROUPING_SIZE = 10,
    UNUM_ROUNDING_MODE = 11,
    UNUM_ROUNDING_INCREMENT = 12,
    UNUM_FORMAT_WIDTH = 13,
    UNUM_PADDING_POSITION = 14,
    UNUM_SECONDARY_GROUPING_SIZE = 15,
    UNUM_SIGNIFICANT_DIGITS_USED = 16,
    UNUM_MIN_SIGNIFICANT_DIGITS = 17,
    UNUM_MAX_SIGNIFICANT_DIGITS = 18,
    UNUM_LENIENT_PARSE = 19,
    UNUM_PARSE_ALL_INPUT = 20,
    UNUM_SCALE = 21,
    UNUM_CURRENCY_USAGE = 23,
    UNUM_FORMAT_FAIL_IF_MORE_THAN_MAX_DIGITS = 4096,
    UNUM_PARSE_NO_EXPONENT = 4097,
    UNUM_PARSE_DECIMAL_MARK_REQUIRED = 4098,
}

enum UNumberFormatTextAttribute
{
    UNUM_POSITIVE_PREFIX = 0,
    UNUM_POSITIVE_SUFFIX = 1,
    UNUM_NEGATIVE_PREFIX = 2,
    UNUM_NEGATIVE_SUFFIX = 3,
    UNUM_PADDING_CHARACTER = 4,
    UNUM_CURRENCY_CODE = 5,
    UNUM_DEFAULT_RULESET = 6,
    UNUM_PUBLIC_RULESETS = 7,
}

enum UNumberFormatSymbol
{
    UNUM_DECIMAL_SEPARATOR_SYMBOL = 0,
    UNUM_GROUPING_SEPARATOR_SYMBOL = 1,
    UNUM_PATTERN_SEPARATOR_SYMBOL = 2,
    UNUM_PERCENT_SYMBOL = 3,
    UNUM_ZERO_DIGIT_SYMBOL = 4,
    UNUM_DIGIT_SYMBOL = 5,
    UNUM_MINUS_SIGN_SYMBOL = 6,
    UNUM_PLUS_SIGN_SYMBOL = 7,
    UNUM_CURRENCY_SYMBOL = 8,
    UNUM_INTL_CURRENCY_SYMBOL = 9,
    UNUM_MONETARY_SEPARATOR_SYMBOL = 10,
    UNUM_EXPONENTIAL_SYMBOL = 11,
    UNUM_PERMILL_SYMBOL = 12,
    UNUM_PAD_ESCAPE_SYMBOL = 13,
    UNUM_INFINITY_SYMBOL = 14,
    UNUM_NAN_SYMBOL = 15,
    UNUM_SIGNIFICANT_DIGIT_SYMBOL = 16,
    UNUM_MONETARY_GROUPING_SEPARATOR_SYMBOL = 17,
    UNUM_ONE_DIGIT_SYMBOL = 18,
    UNUM_TWO_DIGIT_SYMBOL = 19,
    UNUM_THREE_DIGIT_SYMBOL = 20,
    UNUM_FOUR_DIGIT_SYMBOL = 21,
    UNUM_FIVE_DIGIT_SYMBOL = 22,
    UNUM_SIX_DIGIT_SYMBOL = 23,
    UNUM_SEVEN_DIGIT_SYMBOL = 24,
    UNUM_EIGHT_DIGIT_SYMBOL = 25,
    UNUM_NINE_DIGIT_SYMBOL = 26,
    UNUM_EXPONENT_MULTIPLICATION_SYMBOL = 27,
}

enum UDateFormatStyle
{
    UDAT_FULL = 0,
    UDAT_LONG = 1,
    UDAT_MEDIUM = 2,
    UDAT_SHORT = 3,
    UDAT_DEFAULT = 2,
    UDAT_RELATIVE = 128,
    UDAT_FULL_RELATIVE = 128,
    UDAT_LONG_RELATIVE = 129,
    UDAT_MEDIUM_RELATIVE = 130,
    UDAT_SHORT_RELATIVE = 131,
    UDAT_NONE = -1,
    UDAT_PATTERN = -2,
}

enum UDateFormatField
{
    UDAT_ERA_FIELD = 0,
    UDAT_YEAR_FIELD = 1,
    UDAT_MONTH_FIELD = 2,
    UDAT_DATE_FIELD = 3,
    UDAT_HOUR_OF_DAY1_FIELD = 4,
    UDAT_HOUR_OF_DAY0_FIELD = 5,
    UDAT_MINUTE_FIELD = 6,
    UDAT_SECOND_FIELD = 7,
    UDAT_FRACTIONAL_SECOND_FIELD = 8,
    UDAT_DAY_OF_WEEK_FIELD = 9,
    UDAT_DAY_OF_YEAR_FIELD = 10,
    UDAT_DAY_OF_WEEK_IN_MONTH_FIELD = 11,
    UDAT_WEEK_OF_YEAR_FIELD = 12,
    UDAT_WEEK_OF_MONTH_FIELD = 13,
    UDAT_AM_PM_FIELD = 14,
    UDAT_HOUR1_FIELD = 15,
    UDAT_HOUR0_FIELD = 16,
    UDAT_TIMEZONE_FIELD = 17,
    UDAT_YEAR_WOY_FIELD = 18,
    UDAT_DOW_LOCAL_FIELD = 19,
    UDAT_EXTENDED_YEAR_FIELD = 20,
    UDAT_JULIAN_DAY_FIELD = 21,
    UDAT_MILLISECONDS_IN_DAY_FIELD = 22,
    UDAT_TIMEZONE_RFC_FIELD = 23,
    UDAT_TIMEZONE_GENERIC_FIELD = 24,
    UDAT_STANDALONE_DAY_FIELD = 25,
    UDAT_STANDALONE_MONTH_FIELD = 26,
    UDAT_QUARTER_FIELD = 27,
    UDAT_STANDALONE_QUARTER_FIELD = 28,
    UDAT_TIMEZONE_SPECIAL_FIELD = 29,
    UDAT_YEAR_NAME_FIELD = 30,
    UDAT_TIMEZONE_LOCALIZED_GMT_OFFSET_FIELD = 31,
    UDAT_TIMEZONE_ISO_FIELD = 32,
    UDAT_TIMEZONE_ISO_LOCAL_FIELD = 33,
    UDAT_AM_PM_MIDNIGHT_NOON_FIELD = 35,
    UDAT_FLEXIBLE_DAY_PERIOD_FIELD = 36,
}

enum UDateFormatBooleanAttribute
{
    UDAT_PARSE_ALLOW_WHITESPACE = 0,
    UDAT_PARSE_ALLOW_NUMERIC = 1,
    UDAT_PARSE_PARTIAL_LITERAL_MATCH = 2,
    UDAT_PARSE_MULTIPLE_PATTERNS_FOR_MATCH = 3,
    UDAT_BOOLEAN_ATTRIBUTE_COUNT = 4,
}

enum UDateFormatSymbolType
{
    UDAT_ERAS = 0,
    UDAT_MONTHS = 1,
    UDAT_SHORT_MONTHS = 2,
    UDAT_WEEKDAYS = 3,
    UDAT_SHORT_WEEKDAYS = 4,
    UDAT_AM_PMS = 5,
    UDAT_LOCALIZED_CHARS = 6,
    UDAT_ERA_NAMES = 7,
    UDAT_NARROW_MONTHS = 8,
    UDAT_NARROW_WEEKDAYS = 9,
    UDAT_STANDALONE_MONTHS = 10,
    UDAT_STANDALONE_SHORT_MONTHS = 11,
    UDAT_STANDALONE_NARROW_MONTHS = 12,
    UDAT_STANDALONE_WEEKDAYS = 13,
    UDAT_STANDALONE_SHORT_WEEKDAYS = 14,
    UDAT_STANDALONE_NARROW_WEEKDAYS = 15,
    UDAT_QUARTERS = 16,
    UDAT_SHORT_QUARTERS = 17,
    UDAT_STANDALONE_QUARTERS = 18,
    UDAT_STANDALONE_SHORT_QUARTERS = 19,
    UDAT_SHORTER_WEEKDAYS = 20,
    UDAT_STANDALONE_SHORTER_WEEKDAYS = 21,
    UDAT_CYCLIC_YEARS_WIDE = 22,
    UDAT_CYCLIC_YEARS_ABBREVIATED = 23,
    UDAT_CYCLIC_YEARS_NARROW = 24,
    UDAT_ZODIAC_NAMES_WIDE = 25,
    UDAT_ZODIAC_NAMES_ABBREVIATED = 26,
    UDAT_ZODIAC_NAMES_NARROW = 27,
}

struct UDateFormatSymbols
{
}

struct UNumberFormatter
{
}

struct UFormattedNumber
{
}

struct UNumberingSystem
{
}

enum UPluralType
{
    UPLURAL_TYPE_CARDINAL = 0,
    UPLURAL_TYPE_ORDINAL = 1,
}

struct UPluralRules
{
}

struct URegularExpression
{
}

enum URegexpFlag
{
    UREGEX_CASE_INSENSITIVE = 2,
    UREGEX_COMMENTS = 4,
    UREGEX_DOTALL = 32,
    UREGEX_LITERAL = 16,
    UREGEX_MULTILINE = 8,
    UREGEX_UNIX_LINES = 1,
    UREGEX_UWORD = 256,
    UREGEX_ERROR_ON_UNKNOWN_ESCAPES = 512,
}

alias URegexMatchCallback = extern(Windows) byte function(const(void)* context, int steps);
alias URegexFindProgressCallback = extern(Windows) byte function(const(void)* context, long matchIndex);
enum URegionType
{
    URGN_UNKNOWN = 0,
    URGN_TERRITORY = 1,
    URGN_WORLD = 2,
    URGN_CONTINENT = 3,
    URGN_SUBCONTINENT = 4,
    URGN_GROUPING = 5,
    URGN_DEPRECATED = 6,
}

struct URegion
{
}

enum UDateRelativeDateTimeFormatterStyle
{
    UDAT_STYLE_LONG = 0,
    UDAT_STYLE_SHORT = 1,
    UDAT_STYLE_NARROW = 2,
}

enum URelativeDateTimeUnit
{
    UDAT_REL_UNIT_YEAR = 0,
    UDAT_REL_UNIT_QUARTER = 1,
    UDAT_REL_UNIT_MONTH = 2,
    UDAT_REL_UNIT_WEEK = 3,
    UDAT_REL_UNIT_DAY = 4,
    UDAT_REL_UNIT_HOUR = 5,
    UDAT_REL_UNIT_MINUTE = 6,
    UDAT_REL_UNIT_SECOND = 7,
    UDAT_REL_UNIT_SUNDAY = 8,
    UDAT_REL_UNIT_MONDAY = 9,
    UDAT_REL_UNIT_TUESDAY = 10,
    UDAT_REL_UNIT_WEDNESDAY = 11,
    UDAT_REL_UNIT_THURSDAY = 12,
    UDAT_REL_UNIT_FRIDAY = 13,
    UDAT_REL_UNIT_SATURDAY = 14,
}

struct URelativeDateTimeFormatter
{
}

struct UStringSearch
{
}

enum USearchAttribute
{
    USEARCH_OVERLAP = 0,
    USEARCH_ELEMENT_COMPARISON = 2,
}

enum USearchAttributeValue
{
    USEARCH_DEFAULT = -1,
    USEARCH_OFF = 0,
    USEARCH_ON = 1,
    USEARCH_STANDARD_ELEMENT_COMPARISON = 2,
    USEARCH_PATTERN_BASE_WEIGHT_IS_WILDCARD = 3,
    USEARCH_ANY_BASE_WEIGHT_IS_WILDCARD = 4,
}

struct USpoofChecker
{
}

struct USpoofCheckResult
{
}

enum USpoofChecks
{
    USPOOF_SINGLE_SCRIPT_CONFUSABLE = 1,
    USPOOF_MIXED_SCRIPT_CONFUSABLE = 2,
    USPOOF_WHOLE_SCRIPT_CONFUSABLE = 4,
    USPOOF_CONFUSABLE = 7,
    USPOOF_RESTRICTION_LEVEL = 16,
    USPOOF_INVISIBLE = 32,
    USPOOF_CHAR_LIMIT = 64,
    USPOOF_MIXED_NUMBERS = 128,
    USPOOF_ALL_CHECKS = 65535,
    USPOOF_AUX_INFO = 1073741824,
}

enum URestrictionLevel
{
    USPOOF_ASCII = 268435456,
    USPOOF_SINGLE_SCRIPT_RESTRICTIVE = 536870912,
    USPOOF_HIGHLY_RESTRICTIVE = 805306368,
    USPOOF_MODERATELY_RESTRICTIVE = 1073741824,
    USPOOF_MINIMALLY_RESTRICTIVE = 1342177280,
    USPOOF_UNRESTRICTIVE = 1610612736,
    USPOOF_RESTRICTION_LEVEL_MASK = 2130706432,
}

enum UDateTimeScale
{
    UDTS_JAVA_TIME = 0,
    UDTS_UNIX_TIME = 1,
    UDTS_ICU4C_TIME = 2,
    UDTS_WINDOWS_FILE_TIME = 3,
    UDTS_DOTNET_DATE_TIME = 4,
    UDTS_MAC_OLD_TIME = 5,
    UDTS_MAC_TIME = 6,
    UDTS_EXCEL_TIME = 7,
    UDTS_DB2_TIME = 8,
    UDTS_UNIX_MICROSECONDS_TIME = 9,
}

enum UTimeScaleValue
{
    UTSV_UNITS_VALUE = 0,
    UTSV_EPOCH_OFFSET_VALUE = 1,
    UTSV_FROM_MIN_VALUE = 2,
    UTSV_FROM_MAX_VALUE = 3,
    UTSV_TO_MIN_VALUE = 4,
    UTSV_TO_MAX_VALUE = 5,
}

enum UTransDirection
{
    UTRANS_FORWARD = 0,
    UTRANS_REVERSE = 1,
}

struct UTransPosition
{
    int contextStart;
    int contextLimit;
    int start;
    int limit;
}

