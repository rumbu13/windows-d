module windows.windowscolorsystem;

public import windows.automation;
public import windows.com;
public import windows.gdi;
public import windows.kernel;
public import windows.systemservices;
public import windows.windowsandmessaging;

extern(Windows):

struct CIEXYZ
{
    int ciexyzX;
    int ciexyzY;
    int ciexyzZ;
}

struct CIEXYZTRIPLE
{
    CIEXYZ ciexyzRed;
    CIEXYZ ciexyzGreen;
    CIEXYZ ciexyzBlue;
}

struct LOGCOLORSPACEA
{
    uint lcsSignature;
    uint lcsVersion;
    uint lcsSize;
    int lcsCSType;
    int lcsIntent;
    CIEXYZTRIPLE lcsEndpoints;
    uint lcsGammaRed;
    uint lcsGammaGreen;
    uint lcsGammaBlue;
    byte lcsFilename;
}

struct LOGCOLORSPACEW
{
    uint lcsSignature;
    uint lcsVersion;
    uint lcsSize;
    int lcsCSType;
    int lcsIntent;
    CIEXYZTRIPLE lcsEndpoints;
    uint lcsGammaRed;
    uint lcsGammaGreen;
    uint lcsGammaBlue;
    ushort lcsFilename;
}

alias ICMENUMPROCA = extern(Windows) int function(const(char)* param0, LPARAM param1);
alias ICMENUMPROCW = extern(Windows) int function(const(wchar)* param0, LPARAM param1);
@DllImport("GDI32.dll")
int SetICMMode(HDC hdc, int mode);

@DllImport("GDI32.dll")
BOOL CheckColorsInGamut(HDC hdc, char* lpRGBTriple, char* dlpBuffer, uint nCount);

@DllImport("GDI32.dll")
HCOLORSPACE GetColorSpace(HDC hdc);

@DllImport("GDI32.dll")
BOOL GetLogColorSpaceA(HCOLORSPACE hColorSpace, char* lpBuffer, uint nSize);

@DllImport("GDI32.dll")
BOOL GetLogColorSpaceW(HCOLORSPACE hColorSpace, char* lpBuffer, uint nSize);

@DllImport("GDI32.dll")
HCOLORSPACE CreateColorSpaceA(LOGCOLORSPACEA* lplcs);

@DllImport("GDI32.dll")
HCOLORSPACE CreateColorSpaceW(LOGCOLORSPACEW* lplcs);

@DllImport("GDI32.dll")
HCOLORSPACE SetColorSpace(HDC hdc, HCOLORSPACE hcs);

@DllImport("GDI32.dll")
BOOL DeleteColorSpace(HCOLORSPACE hcs);

@DllImport("GDI32.dll")
BOOL GetICMProfileA(HDC hdc, uint* pBufSize, const(char)* pszFilename);

@DllImport("GDI32.dll")
BOOL GetICMProfileW(HDC hdc, uint* pBufSize, const(wchar)* pszFilename);

@DllImport("GDI32.dll")
BOOL SetICMProfileA(HDC hdc, const(char)* lpFileName);

@DllImport("GDI32.dll")
BOOL SetICMProfileW(HDC hdc, const(wchar)* lpFileName);

@DllImport("GDI32.dll")
BOOL GetDeviceGammaRamp(HDC hdc, char* lpRamp);

@DllImport("GDI32.dll")
BOOL SetDeviceGammaRamp(HDC hdc, char* lpRamp);

@DllImport("GDI32.dll")
BOOL ColorMatchToTarget(HDC hdc, HDC hdcTarget, uint action);

@DllImport("GDI32.dll")
int EnumICMProfilesA(HDC hdc, ICMENUMPROCA proc, LPARAM param2);

@DllImport("GDI32.dll")
int EnumICMProfilesW(HDC hdc, ICMENUMPROCW proc, LPARAM param2);

@DllImport("GDI32.dll")
BOOL UpdateICMRegKeyA(uint reserved, const(char)* lpszCMID, const(char)* lpszFileName, uint command);

@DllImport("GDI32.dll")
BOOL UpdateICMRegKeyW(uint reserved, const(wchar)* lpszCMID, const(wchar)* lpszFileName, uint command);

@DllImport("GDI32.dll")
BOOL ColorCorrectPalette(HDC hdc, HPALETTE hPal, uint deFirst, uint num);

@DllImport("mscms.dll")
int OpenColorProfileA(PROFILE* pProfile, uint dwDesiredAccess, uint dwShareMode, uint dwCreationMode);

@DllImport("mscms.dll")
int OpenColorProfileW(PROFILE* pProfile, uint dwDesiredAccess, uint dwShareMode, uint dwCreationMode);

@DllImport("mscms.dll")
BOOL CloseColorProfile(int hProfile);

@DllImport("mscms.dll")
BOOL GetColorProfileFromHandle(int hProfile, char* pProfile, uint* pcbProfile);

@DllImport("mscms.dll")
BOOL IsColorProfileValid(int hProfile, int* pbValid);

@DllImport("mscms.dll")
BOOL CreateProfileFromLogColorSpaceA(LOGCOLORSPACEA* pLogColorSpace, ubyte** pProfile);

@DllImport("mscms.dll")
BOOL CreateProfileFromLogColorSpaceW(LOGCOLORSPACEW* pLogColorSpace, ubyte** pProfile);

@DllImport("mscms.dll")
BOOL GetCountColorProfileElements(int hProfile, uint* pnElementCount);

@DllImport("mscms.dll")
BOOL GetColorProfileHeader(int hProfile, PROFILEHEADER* pHeader);

@DllImport("mscms.dll")
BOOL GetColorProfileElementTag(int hProfile, uint dwIndex, uint* pTag);

@DllImport("mscms.dll")
BOOL IsColorProfileTagPresent(int hProfile, uint tag, int* pbPresent);

@DllImport("mscms.dll")
BOOL GetColorProfileElement(int hProfile, uint tag, uint dwOffset, uint* pcbElement, char* pElement, int* pbReference);

@DllImport("mscms.dll")
BOOL SetColorProfileHeader(int hProfile, char* pHeader);

@DllImport("mscms.dll")
BOOL SetColorProfileElementSize(int hProfile, uint tagType, uint pcbElement);

@DllImport("mscms.dll")
BOOL SetColorProfileElement(int hProfile, uint tag, uint dwOffset, uint* pcbElement, char* pElement);

@DllImport("mscms.dll")
BOOL SetColorProfileElementReference(int hProfile, uint newTag, uint refTag);

@DllImport("mscms.dll")
BOOL GetPS2ColorSpaceArray(int hProfile, uint dwIntent, uint dwCSAType, char* pPS2ColorSpaceArray, uint* pcbPS2ColorSpaceArray, int* pbBinary);

@DllImport("mscms.dll")
BOOL GetPS2ColorRenderingIntent(int hProfile, uint dwIntent, char* pBuffer, uint* pcbPS2ColorRenderingIntent);

@DllImport("mscms.dll")
BOOL GetPS2ColorRenderingDictionary(int hProfile, uint dwIntent, char* pPS2ColorRenderingDictionary, uint* pcbPS2ColorRenderingDictionary, int* pbBinary);

@DllImport("mscms.dll")
BOOL GetNamedProfileInfo(int hProfile, char* pNamedProfileInfo);

@DllImport("mscms.dll")
BOOL ConvertColorNameToIndex(int hProfile, char* paColorName, char* paIndex, uint dwCount);

@DllImport("mscms.dll")
BOOL ConvertIndexToColorName(int hProfile, char* paIndex, char* paColorName, uint dwCount);

@DllImport("mscms.dll")
BOOL CreateDeviceLinkProfile(char* hProfile, uint nProfiles, char* padwIntent, uint nIntents, uint dwFlags, ubyte** pProfileData, uint indexPreferredCMM);

@DllImport("mscms.dll")
int CreateColorTransformA(LOGCOLORSPACEA* pLogColorSpace, int hDestProfile, int hTargetProfile, uint dwFlags);

@DllImport("mscms.dll")
int CreateColorTransformW(LOGCOLORSPACEW* pLogColorSpace, int hDestProfile, int hTargetProfile, uint dwFlags);

@DllImport("mscms.dll")
int CreateMultiProfileTransform(char* pahProfiles, uint nProfiles, char* padwIntent, uint nIntents, uint dwFlags, uint indexPreferredCMM);

@DllImport("mscms.dll")
BOOL DeleteColorTransform(int hxform);

@DllImport("mscms.dll")
BOOL TranslateBitmapBits(int hColorTransform, void* pSrcBits, BMFORMAT bmInput, uint dwWidth, uint dwHeight, uint dwInputStride, void* pDestBits, BMFORMAT bmOutput, uint dwOutputStride, PBMCALLBACKFN pfnCallBack, LPARAM ulCallbackData);

@DllImport("mscms.dll")
BOOL CheckBitmapBits(int hColorTransform, void* pSrcBits, BMFORMAT bmInput, uint dwWidth, uint dwHeight, uint dwStride, char* paResult, PBMCALLBACKFN pfnCallback, LPARAM lpCallbackData);

@DllImport("mscms.dll")
BOOL TranslateColors(int hColorTransform, char* paInputColors, uint nColors, COLORTYPE ctInput, char* paOutputColors, COLORTYPE ctOutput);

@DllImport("mscms.dll")
BOOL CheckColors(int hColorTransform, char* paInputColors, uint nColors, COLORTYPE ctInput, char* paResult);

@DllImport("mscms.dll")
uint GetCMMInfo(int hColorTransform, uint param1);

@DllImport("mscms.dll")
BOOL RegisterCMMA(const(char)* pMachineName, uint cmmID, const(char)* pCMMdll);

@DllImport("mscms.dll")
BOOL RegisterCMMW(const(wchar)* pMachineName, uint cmmID, const(wchar)* pCMMdll);

@DllImport("mscms.dll")
BOOL UnregisterCMMA(const(char)* pMachineName, uint cmmID);

@DllImport("mscms.dll")
BOOL UnregisterCMMW(const(wchar)* pMachineName, uint cmmID);

@DllImport("mscms.dll")
BOOL SelectCMM(uint dwCMMType);

@DllImport("mscms.dll")
BOOL GetColorDirectoryA(const(char)* pMachineName, const(char)* pBuffer, uint* pdwSize);

@DllImport("mscms.dll")
BOOL GetColorDirectoryW(const(wchar)* pMachineName, const(wchar)* pBuffer, uint* pdwSize);

@DllImport("mscms.dll")
BOOL InstallColorProfileA(const(char)* pMachineName, const(char)* pProfileName);

@DllImport("mscms.dll")
BOOL InstallColorProfileW(const(wchar)* pMachineName, const(wchar)* pProfileName);

@DllImport("mscms.dll")
BOOL UninstallColorProfileA(const(char)* pMachineName, const(char)* pProfileName, BOOL bDelete);

@DllImport("mscms.dll")
BOOL UninstallColorProfileW(const(wchar)* pMachineName, const(wchar)* pProfileName, BOOL bDelete);

@DllImport("mscms.dll")
BOOL EnumColorProfilesA(const(char)* pMachineName, ENUMTYPEA* pEnumRecord, char* pEnumerationBuffer, uint* pdwSizeOfEnumerationBuffer, uint* pnProfiles);

@DllImport("mscms.dll")
BOOL EnumColorProfilesW(const(wchar)* pMachineName, ENUMTYPEW* pEnumRecord, char* pEnumerationBuffer, uint* pdwSizeOfEnumerationBuffer, uint* pnProfiles);

@DllImport("mscms.dll")
BOOL SetStandardColorSpaceProfileA(const(char)* pMachineName, uint dwProfileID, const(char)* pProfilename);

@DllImport("mscms.dll")
BOOL SetStandardColorSpaceProfileW(const(wchar)* pMachineName, uint dwProfileID, const(wchar)* pProfileName);

@DllImport("mscms.dll")
BOOL GetStandardColorSpaceProfileA(const(char)* pMachineName, uint dwSCS, const(char)* pBuffer, uint* pcbSize);

@DllImport("mscms.dll")
BOOL GetStandardColorSpaceProfileW(const(wchar)* pMachineName, uint dwSCS, const(wchar)* pBuffer, uint* pcbSize);

@DllImport("mscms.dll")
BOOL AssociateColorProfileWithDeviceA(const(char)* pMachineName, const(char)* pProfileName, const(char)* pDeviceName);

@DllImport("mscms.dll")
BOOL AssociateColorProfileWithDeviceW(const(wchar)* pMachineName, const(wchar)* pProfileName, const(wchar)* pDeviceName);

@DllImport("mscms.dll")
BOOL DisassociateColorProfileFromDeviceA(const(char)* pMachineName, const(char)* pProfileName, const(char)* pDeviceName);

@DllImport("mscms.dll")
BOOL DisassociateColorProfileFromDeviceW(const(wchar)* pMachineName, const(wchar)* pProfileName, const(wchar)* pDeviceName);

@DllImport("ICMUI.dll")
BOOL SetupColorMatchingW(char* pcms);

@DllImport("ICMUI.dll")
BOOL SetupColorMatchingA(char* pcms);

@DllImport("mscms.dll")
BOOL WcsAssociateColorProfileWithDevice(WCS_PROFILE_MANAGEMENT_SCOPE scope, const(wchar)* pProfileName, const(wchar)* pDeviceName);

@DllImport("mscms.dll")
BOOL WcsDisassociateColorProfileFromDevice(WCS_PROFILE_MANAGEMENT_SCOPE scope, const(wchar)* pProfileName, const(wchar)* pDeviceName);

@DllImport("mscms.dll")
BOOL WcsEnumColorProfilesSize(WCS_PROFILE_MANAGEMENT_SCOPE scope, ENUMTYPEW* pEnumRecord, uint* pdwSize);

@DllImport("mscms.dll")
BOOL WcsEnumColorProfiles(WCS_PROFILE_MANAGEMENT_SCOPE scope, ENUMTYPEW* pEnumRecord, char* pBuffer, uint dwSize, uint* pnProfiles);

@DllImport("mscms.dll")
BOOL WcsGetDefaultColorProfileSize(WCS_PROFILE_MANAGEMENT_SCOPE scope, const(wchar)* pDeviceName, COLORPROFILETYPE cptColorProfileType, COLORPROFILESUBTYPE cpstColorProfileSubType, uint dwProfileID, uint* pcbProfileName);

@DllImport("mscms.dll")
BOOL WcsGetDefaultColorProfile(WCS_PROFILE_MANAGEMENT_SCOPE scope, const(wchar)* pDeviceName, COLORPROFILETYPE cptColorProfileType, COLORPROFILESUBTYPE cpstColorProfileSubType, uint dwProfileID, uint cbProfileName, const(wchar)* pProfileName);

@DllImport("mscms.dll")
BOOL WcsSetDefaultColorProfile(WCS_PROFILE_MANAGEMENT_SCOPE scope, const(wchar)* pDeviceName, COLORPROFILETYPE cptColorProfileType, COLORPROFILESUBTYPE cpstColorProfileSubType, uint dwProfileID, const(wchar)* pProfileName);

@DllImport("mscms.dll")
BOOL WcsSetDefaultRenderingIntent(WCS_PROFILE_MANAGEMENT_SCOPE scope, uint dwRenderingIntent);

@DllImport("mscms.dll")
BOOL WcsGetDefaultRenderingIntent(WCS_PROFILE_MANAGEMENT_SCOPE scope, uint* pdwRenderingIntent);

@DllImport("mscms.dll")
BOOL WcsGetUsePerUserProfiles(const(wchar)* pDeviceName, uint dwDeviceClass, int* pUsePerUserProfiles);

@DllImport("mscms.dll")
BOOL WcsSetUsePerUserProfiles(const(wchar)* pDeviceName, uint dwDeviceClass, BOOL usePerUserProfiles);

@DllImport("mscms.dll")
BOOL WcsTranslateColors(int hColorTransform, uint nColors, uint nInputChannels, COLORDATATYPE cdtInput, uint cbInput, char* pInputData, uint nOutputChannels, COLORDATATYPE cdtOutput, uint cbOutput, char* pOutputData);

@DllImport("mscms.dll")
BOOL WcsCheckColors(int hColorTransform, uint nColors, uint nInputChannels, COLORDATATYPE cdtInput, uint cbInput, char* pInputData, char* paResult);

@DllImport("ICM32.dll")
BOOL CMCheckColors(int hcmTransform, char* lpaInputColors, uint nColors, COLORTYPE ctInput, char* lpaResult);

@DllImport("ICM32.dll")
BOOL CMCheckRGBs(int hcmTransform, void* lpSrcBits, BMFORMAT bmInput, uint dwWidth, uint dwHeight, uint dwStride, char* lpaResult, PBMCALLBACKFN pfnCallback, LPARAM ulCallbackData);

@DllImport("ICM32.dll")
BOOL CMConvertColorNameToIndex(int hProfile, char* paColorName, char* paIndex, uint dwCount);

@DllImport("ICM32.dll")
BOOL CMConvertIndexToColorName(int hProfile, char* paIndex, char* paColorName, uint dwCount);

@DllImport("ICM32.dll")
BOOL CMCreateDeviceLinkProfile(char* pahProfiles, uint nProfiles, char* padwIntents, uint nIntents, uint dwFlags, ubyte** lpProfileData);

@DllImport("ICM32.dll")
int CMCreateMultiProfileTransform(char* pahProfiles, uint nProfiles, char* padwIntents, uint nIntents, uint dwFlags);

@DllImport("ICM32.dll")
BOOL CMCreateProfileW(LOGCOLORSPACEW* lpColorSpace, void** lpProfileData);

@DllImport("ICM32.dll")
int CMCreateTransform(LOGCOLORSPACEA* lpColorSpace, void* lpDevCharacter, void* lpTargetDevCharacter);

@DllImport("ICM32.dll")
int CMCreateTransformW(LOGCOLORSPACEW* lpColorSpace, void* lpDevCharacter, void* lpTargetDevCharacter);

@DllImport("ICM32.dll")
int CMCreateTransformExt(LOGCOLORSPACEA* lpColorSpace, void* lpDevCharacter, void* lpTargetDevCharacter, uint dwFlags);

@DllImport("ICM32.dll")
BOOL CMCheckColorsInGamut(int hcmTransform, char* lpaRGBTriple, char* lpaResult, uint nCount);

@DllImport("ICM32.dll")
BOOL CMCreateProfile(LOGCOLORSPACEA* lpColorSpace, void** lpProfileData);

@DllImport("ICM32.dll")
BOOL CMTranslateRGB(int hcmTransform, uint ColorRef, uint* lpColorRef, uint dwFlags);

@DllImport("ICM32.dll")
BOOL CMTranslateRGBs(int hcmTransform, void* lpSrcBits, BMFORMAT bmInput, uint dwWidth, uint dwHeight, uint dwStride, void* lpDestBits, BMFORMAT bmOutput, uint dwTranslateDirection);

@DllImport("ICM32.dll")
int CMCreateTransformExtW(LOGCOLORSPACEW* lpColorSpace, void* lpDevCharacter, void* lpTargetDevCharacter, uint dwFlags);

@DllImport("ICM32.dll")
BOOL CMDeleteTransform(int hcmTransform);

@DllImport("ICM32.dll")
uint CMGetInfo(uint dwInfo);

@DllImport("ICM32.dll")
BOOL CMGetNamedProfileInfo(int hProfile, NAMED_PROFILE_INFO* pNamedProfileInfo);

@DllImport("ICM32.dll")
BOOL CMIsProfileValid(int hProfile, int* lpbValid);

@DllImport("ICM32.dll")
BOOL CMTranslateColors(int hcmTransform, char* lpaInputColors, uint nColors, COLORTYPE ctInput, char* lpaOutputColors, COLORTYPE ctOutput);

@DllImport("ICM32.dll")
BOOL CMTranslateRGBsExt(int hcmTransform, void* lpSrcBits, BMFORMAT bmInput, uint dwWidth, uint dwHeight, uint dwInputStride, void* lpDestBits, BMFORMAT bmOutput, uint dwOutputStride, LPBMCALLBACKFN lpfnCallback, LPARAM ulCallbackData);

@DllImport("mscms.dll")
int WcsOpenColorProfileA(PROFILE* pCDMPProfile, PROFILE* pCAMPProfile, PROFILE* pGMMPProfile, uint dwDesireAccess, uint dwShareMode, uint dwCreationMode, uint dwFlags);

@DllImport("mscms.dll")
int WcsOpenColorProfileW(PROFILE* pCDMPProfile, PROFILE* pCAMPProfile, PROFILE* pGMMPProfile, uint dwDesireAccess, uint dwShareMode, uint dwCreationMode, uint dwFlags);

@DllImport("mscms.dll")
int WcsCreateIccProfile(int hWcsProfile, uint dwOptions);

@DllImport("mscms.dll")
BOOL WcsGetCalibrationManagementState(int* pbIsEnabled);

@DllImport("mscms.dll")
BOOL WcsSetCalibrationManagementState(BOOL bIsEnabled);

@DllImport("mscms.dll")
HRESULT ColorAdapterGetSystemModifyWhitePointCaps(int* whitePointAdjCapable, int* isColorOverrideActive);

@DllImport("mscms.dll")
HRESULT ColorAdapterUpdateDisplayGamma(DisplayID displayID, DisplayTransformLut* displayTransform, BOOL internal);

@DllImport("mscms.dll")
HRESULT ColorAdapterUpdateDeviceProfile(DisplayID displayID, const(wchar)* profName);

@DllImport("mscms.dll")
HRESULT ColorAdapterGetDisplayCurrentStateID(DisplayID displayID, DisplayStateID* displayStateID);

@DllImport("mscms.dll")
HRESULT ColorAdapterGetDisplayTransformData(DisplayID displayID, DisplayTransformLut* displayTransformLut, uint* transformID);

@DllImport("mscms.dll")
HRESULT ColorAdapterGetDisplayTargetWhitePoint(DisplayID displayID, WhitePoint* wtpt, uint* transitionTime, uint* whitepointID);

@DllImport("mscms.dll")
HRESULT ColorAdapterGetDisplayProfile(DisplayID displayID, const(wchar)* displayProfile, uint* profileID, int* bUseAccurate);

@DllImport("mscms.dll")
HRESULT ColorAdapterGetCurrentProfileCalibration(DisplayID displayID, uint maxCalibrationBlobSize, uint* blobSize, char* calibrationBlob);

@DllImport("mscms.dll")
HRESULT ColorAdapterRegisterOEMColorService(HANDLE* registration);

@DllImport("mscms.dll")
HRESULT ColorAdapterUnregisterOEMColorService(HANDLE registration);

@DllImport("mscms.dll")
HRESULT ColorProfileAddDisplayAssociation(WCS_PROFILE_MANAGEMENT_SCOPE scope, const(wchar)* profileName, LUID targetAdapterID, uint sourceID, BOOL setAsDefault, BOOL associateAsAdvancedColor);

@DllImport("mscms.dll")
HRESULT ColorProfileRemoveDisplayAssociation(WCS_PROFILE_MANAGEMENT_SCOPE scope, const(wchar)* profileName, LUID targetAdapterID, uint sourceID, BOOL dissociateAdvancedColor);

@DllImport("mscms.dll")
HRESULT ColorProfileSetDisplayDefaultAssociation(WCS_PROFILE_MANAGEMENT_SCOPE scope, const(wchar)* profileName, COLORPROFILETYPE profileType, COLORPROFILESUBTYPE profileSubType, LUID targetAdapterID, uint sourceID);

@DllImport("mscms.dll")
HRESULT ColorProfileGetDisplayList(WCS_PROFILE_MANAGEMENT_SCOPE scope, LUID targetAdapterID, uint sourceID, ushort*** profileList, uint* profileCount);

@DllImport("mscms.dll")
HRESULT ColorProfileGetDisplayDefault(WCS_PROFILE_MANAGEMENT_SCOPE scope, LUID targetAdapterID, uint sourceID, COLORPROFILETYPE profileType, COLORPROFILESUBTYPE profileSubType, ushort** profileName);

@DllImport("mscms.dll")
HRESULT ColorProfileGetDisplayUserScope(LUID targetAdapterID, uint sourceID, WCS_PROFILE_MANAGEMENT_SCOPE* scope);

struct XYZColorF
{
    float X;
    float Y;
    float Z;
}

struct JChColorF
{
    float J;
    float C;
    float h;
}

struct JabColorF
{
    float J;
    float a;
    float b;
}

struct GamutShellTriangle
{
    uint aVertexIndex;
}

struct GamutShell
{
    float JMin;
    float JMax;
    uint cVertices;
    uint cTriangles;
    JabColorF* pVertices;
    GamutShellTriangle* pTriangles;
}

struct PrimaryJabColors
{
    JabColorF red;
    JabColorF yellow;
    JabColorF green;
    JabColorF cyan;
    JabColorF blue;
    JabColorF magenta;
    JabColorF black;
    JabColorF white;
}

struct PrimaryXYZColors
{
    XYZColorF red;
    XYZColorF yellow;
    XYZColorF green;
    XYZColorF cyan;
    XYZColorF blue;
    XYZColorF magenta;
    XYZColorF black;
    XYZColorF white;
}

struct GamutBoundaryDescription
{
    PrimaryJabColors* pPrimaries;
    uint cNeutralSamples;
    JabColorF* pNeutralSamples;
    GamutShell* pReferenceShell;
    GamutShell* pPlausibleShell;
    GamutShell* pPossibleShell;
}

struct BlackInformation
{
    BOOL fBlackOnly;
    float blackWeight;
}

const GUID IID_IDeviceModelPlugIn = {0x1CD63475, 0x07C4, 0x46FE, [0xA9, 0x03, 0xD6, 0x55, 0x31, 0x6D, 0x11, 0xFD]};
@GUID(0x1CD63475, 0x07C4, 0x46FE, [0xA9, 0x03, 0xD6, 0x55, 0x31, 0x6D, 0x11, 0xFD]);
interface IDeviceModelPlugIn : IUnknown
{
    HRESULT Initialize(BSTR bstrXml, uint cNumModels, uint iModelPosition);
    HRESULT GetNumChannels(uint* pNumChannels);
    HRESULT DeviceToColorimetricColors(uint cColors, uint cChannels, char* pDeviceValues, char* pXYZColors);
    HRESULT ColorimetricToDeviceColors(uint cColors, uint cChannels, char* pXYZColors, char* pDeviceValues);
    HRESULT ColorimetricToDeviceColorsWithBlack(uint cColors, uint cChannels, char* pXYZColors, char* pBlackInformation, char* pDeviceValues);
    HRESULT SetTransformDeviceModelInfo(uint iModelPosition, IDeviceModelPlugIn pIDeviceModelOther);
    HRESULT GetPrimarySamples(PrimaryXYZColors* pPrimaryColor);
    HRESULT GetGamutBoundaryMeshSize(uint* pNumVertices, uint* pNumTriangles);
    HRESULT GetGamutBoundaryMesh(uint cChannels, uint cVertices, uint cTriangles, char* pVertices, char* pTriangles);
    HRESULT GetNeutralAxisSize(uint* pcColors);
    HRESULT GetNeutralAxis(uint cColors, char* pXYZColors);
}

const GUID IID_IGamutMapModelPlugIn = {0x2DD80115, 0xAD1E, 0x41F6, [0xA2, 0x19, 0xA4, 0xF4, 0xB5, 0x83, 0xD1, 0xF9]};
@GUID(0x2DD80115, 0xAD1E, 0x41F6, [0xA2, 0x19, 0xA4, 0xF4, 0xB5, 0x83, 0xD1, 0xF9]);
interface IGamutMapModelPlugIn : IUnknown
{
    HRESULT Initialize(BSTR bstrXml, IDeviceModelPlugIn pSrcPlugIn, IDeviceModelPlugIn pDestPlugIn, GamutBoundaryDescription* pSrcGBD, GamutBoundaryDescription* pDestGBD);
    HRESULT SourceToDestinationAppearanceColors(uint cColors, char* pInputColors, char* pOutputColors);
}

struct NAMED_PROFILE_INFO
{
    uint dwFlags;
    uint dwCount;
    uint dwCountDevCoordinates;
    byte szPrefix;
    byte szSuffix;
}

struct GRAYCOLOR
{
    ushort gray;
}

struct RGBCOLOR
{
    ushort red;
    ushort green;
    ushort blue;
}

struct CMYKCOLOR
{
    ushort cyan;
    ushort magenta;
    ushort yellow;
    ushort black;
}

struct XYZCOLOR
{
    ushort X;
    ushort Y;
    ushort Z;
}

struct YxyCOLOR
{
    ushort Y;
    ushort x;
    ushort y;
}

struct LabCOLOR
{
    ushort L;
    ushort a;
    ushort b;
}

struct GENERIC3CHANNEL
{
    ushort ch1;
    ushort ch2;
    ushort ch3;
}

struct NAMEDCOLOR
{
    uint dwIndex;
}

struct HiFiCOLOR
{
    ubyte channel;
}

struct COLOR
{
    GRAYCOLOR gray;
    RGBCOLOR rgb;
    CMYKCOLOR cmyk;
    XYZCOLOR XYZ;
    YxyCOLOR Yxy;
    LabCOLOR Lab;
    GENERIC3CHANNEL gen3ch;
    NAMEDCOLOR named;
    HiFiCOLOR hifi;
    _Anonymous_e__Struct Anonymous;
}

enum COLORTYPE
{
    COLOR_GRAY = 1,
    COLOR_RGB = 2,
    COLOR_XYZ = 3,
    COLOR_Yxy = 4,
    COLOR_Lab = 5,
    COLOR_3_CHANNEL = 6,
    COLOR_CMYK = 7,
    COLOR_5_CHANNEL = 8,
    COLOR_6_CHANNEL = 9,
    COLOR_7_CHANNEL = 10,
    COLOR_8_CHANNEL = 11,
    COLOR_NAMED = 12,
}

enum COLORPROFILETYPE
{
    CPT_ICC = 0,
    CPT_DMP = 1,
    CPT_CAMP = 2,
    CPT_GMMP = 3,
}

enum COLORPROFILESUBTYPE
{
    CPST_PERCEPTUAL = 0,
    CPST_RELATIVE_COLORIMETRIC = 1,
    CPST_SATURATION = 2,
    CPST_ABSOLUTE_COLORIMETRIC = 3,
    CPST_NONE = 4,
    CPST_RGB_WORKING_SPACE = 5,
    CPST_CUSTOM_WORKING_SPACE = 6,
    CPST_STANDARD_DISPLAY_COLOR_MODE = 7,
    CPST_EXTENDED_DISPLAY_COLOR_MODE = 8,
}

enum COLORDATATYPE
{
    COLOR_BYTE = 1,
    COLOR_WORD = 2,
    COLOR_FLOAT = 3,
    COLOR_S2DOT13FIXED = 4,
    COLOR_10b_R10G10B10A2 = 5,
    COLOR_10b_R10G10B10A2_XR = 6,
    COLOR_FLOAT16 = 7,
}

enum BMFORMAT
{
    BM_x555RGB = 0,
    BM_x555XYZ = 257,
    BM_x555Yxy = 258,
    BM_x555Lab = 259,
    BM_x555G3CH = 260,
    BM_RGBTRIPLETS = 2,
    BM_BGRTRIPLETS = 4,
    BM_XYZTRIPLETS = 513,
    BM_YxyTRIPLETS = 514,
    BM_LabTRIPLETS = 515,
    BM_G3CHTRIPLETS = 516,
    BM_5CHANNEL = 517,
    BM_6CHANNEL = 518,
    BM_7CHANNEL = 519,
    BM_8CHANNEL = 520,
    BM_GRAY = 521,
    BM_xRGBQUADS = 8,
    BM_xBGRQUADS = 16,
    BM_xG3CHQUADS = 772,
    BM_KYMCQUADS = 773,
    BM_CMYKQUADS = 32,
    BM_10b_RGB = 9,
    BM_10b_XYZ = 1025,
    BM_10b_Yxy = 1026,
    BM_10b_Lab = 1027,
    BM_10b_G3CH = 1028,
    BM_NAMED_INDEX = 1029,
    BM_16b_RGB = 10,
    BM_16b_XYZ = 1281,
    BM_16b_Yxy = 1282,
    BM_16b_Lab = 1283,
    BM_16b_G3CH = 1284,
    BM_16b_GRAY = 1285,
    BM_565RGB = 1,
    BM_32b_scRGB = 1537,
    BM_32b_scARGB = 1538,
    BM_S2DOT13FIXED_scRGB = 1539,
    BM_S2DOT13FIXED_scARGB = 1540,
    BM_R10G10B10A2 = 1793,
    BM_R10G10B10A2_XR = 1794,
    BM_R16G16B16A16_FLOAT = 1795,
}

alias PBMCALLBACKFN = extern(Windows) BOOL function(uint param0, uint param1, LPARAM param2);
alias LPBMCALLBACKFN = extern(Windows) BOOL function();
struct PROFILEHEADER
{
    uint phSize;
    uint phCMMType;
    uint phVersion;
    uint phClass;
    uint phDataColorSpace;
    uint phConnectionSpace;
    uint phDateTime;
    uint phSignature;
    uint phPlatform;
    uint phProfileFlags;
    uint phManufacturer;
    uint phModel;
    uint phAttributes;
    uint phRenderingIntent;
    CIEXYZ phIlluminant;
    uint phCreator;
    ubyte phReserved;
}

struct PROFILE
{
    uint dwType;
    void* pProfileData;
    uint cbDataSize;
}

struct ENUMTYPEA
{
    uint dwSize;
    uint dwVersion;
    uint dwFields;
    const(char)* pDeviceName;
    uint dwMediaType;
    uint dwDitheringMode;
    uint dwResolution;
    uint dwCMMType;
    uint dwClass;
    uint dwDataColorSpace;
    uint dwConnectionSpace;
    uint dwSignature;
    uint dwPlatform;
    uint dwProfileFlags;
    uint dwManufacturer;
    uint dwModel;
    uint dwAttributes;
    uint dwRenderingIntent;
    uint dwCreator;
    uint dwDeviceClass;
}

struct ENUMTYPEW
{
    uint dwSize;
    uint dwVersion;
    uint dwFields;
    const(wchar)* pDeviceName;
    uint dwMediaType;
    uint dwDitheringMode;
    uint dwResolution;
    uint dwCMMType;
    uint dwClass;
    uint dwDataColorSpace;
    uint dwConnectionSpace;
    uint dwSignature;
    uint dwPlatform;
    uint dwProfileFlags;
    uint dwManufacturer;
    uint dwModel;
    uint dwAttributes;
    uint dwRenderingIntent;
    uint dwCreator;
    uint dwDeviceClass;
}

enum WCS_PROFILE_MANAGEMENT_SCOPE
{
    WCS_PROFILE_MANAGEMENT_SCOPE_SYSTEM_WIDE = 0,
    WCS_PROFILE_MANAGEMENT_SCOPE_CURRENT_USER = 1,
}

alias PCMSCALLBACKW = extern(Windows) BOOL function(COLORMATCHSETUPW* param0, LPARAM param1);
alias PCMSCALLBACKA = extern(Windows) BOOL function(COLORMATCHSETUPA* param0, LPARAM param1);
struct COLORMATCHSETUPW
{
    uint dwSize;
    uint dwVersion;
    uint dwFlags;
    HWND hwndOwner;
    const(wchar)* pSourceName;
    const(wchar)* pDisplayName;
    const(wchar)* pPrinterName;
    uint dwRenderIntent;
    uint dwProofingIntent;
    const(wchar)* pMonitorProfile;
    uint ccMonitorProfile;
    const(wchar)* pPrinterProfile;
    uint ccPrinterProfile;
    const(wchar)* pTargetProfile;
    uint ccTargetProfile;
    DLGPROC lpfnHook;
    LPARAM lParam;
    PCMSCALLBACKW lpfnApplyCallback;
    LPARAM lParamApplyCallback;
}

struct COLORMATCHSETUPA
{
    uint dwSize;
    uint dwVersion;
    uint dwFlags;
    HWND hwndOwner;
    const(char)* pSourceName;
    const(char)* pDisplayName;
    const(char)* pPrinterName;
    uint dwRenderIntent;
    uint dwProofingIntent;
    const(char)* pMonitorProfile;
    uint ccMonitorProfile;
    const(char)* pPrinterProfile;
    uint ccPrinterProfile;
    const(char)* pTargetProfile;
    uint ccTargetProfile;
    DLGPROC lpfnHook;
    LPARAM lParam;
    PCMSCALLBACKA lpfnApplyCallback;
    LPARAM lParamApplyCallback;
}

struct XYYPoint
{
    float x;
    float y;
    float Y;
}

struct WhitePoint
{
    int type;
    _Anonymous_e__Union Anonymous;
    enum int CHROMATICITY = 0;
    enum int TEMPERATURE = 1;
    enum int D65 = 2;
}

struct DisplayID
{
    LUID targetAdapterID;
    uint sourceInfoID;
}

struct DisplayStateID
{
    uint profileID;
    uint transformID;
    uint whitepointID;
}

struct DisplayTransformLut
{
    ushort red;
    ushort green;
    ushort blue;
}

