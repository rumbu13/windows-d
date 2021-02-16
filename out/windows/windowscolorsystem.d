module windows.windowscolorsystem;

public import windows.core;
public import windows.automation : BSTR;
public import windows.com : HRESULT, IUnknown;
public import windows.gdi : HCOLORSPACE, HDC, HPALETTE, RGBTRIPLE;
public import windows.kernel : LUID;
public import windows.systemservices : BOOL, HANDLE;
public import windows.windowsandmessaging : DLGPROC, HWND, LPARAM;

extern(Windows):


// Enums


enum : int
{
    COLOR_GRAY      = 0x00000001,
    COLOR_RGB       = 0x00000002,
    COLOR_XYZ       = 0x00000003,
    COLOR_Yxy       = 0x00000004,
    COLOR_Lab       = 0x00000005,
    COLOR_3_CHANNEL = 0x00000006,
    COLOR_CMYK      = 0x00000007,
    COLOR_5_CHANNEL = 0x00000008,
    COLOR_6_CHANNEL = 0x00000009,
    COLOR_7_CHANNEL = 0x0000000a,
    COLOR_8_CHANNEL = 0x0000000b,
    COLOR_NAMED     = 0x0000000c,
}
alias COLORTYPE = int;

enum : int
{
    CPT_ICC  = 0x00000000,
    CPT_DMP  = 0x00000001,
    CPT_CAMP = 0x00000002,
    CPT_GMMP = 0x00000003,
}
alias COLORPROFILETYPE = int;

enum : int
{
    CPST_PERCEPTUAL                  = 0x00000000,
    CPST_RELATIVE_COLORIMETRIC       = 0x00000001,
    CPST_SATURATION                  = 0x00000002,
    CPST_ABSOLUTE_COLORIMETRIC       = 0x00000003,
    CPST_NONE                        = 0x00000004,
    CPST_RGB_WORKING_SPACE           = 0x00000005,
    CPST_CUSTOM_WORKING_SPACE        = 0x00000006,
    CPST_STANDARD_DISPLAY_COLOR_MODE = 0x00000007,
    CPST_EXTENDED_DISPLAY_COLOR_MODE = 0x00000008,
}
alias COLORPROFILESUBTYPE = int;

enum : int
{
    COLOR_BYTE               = 0x00000001,
    COLOR_WORD               = 0x00000002,
    COLOR_FLOAT              = 0x00000003,
    COLOR_S2DOT13FIXED       = 0x00000004,
    COLOR_10b_R10G10B10A2    = 0x00000005,
    COLOR_10b_R10G10B10A2_XR = 0x00000006,
    COLOR_FLOAT16            = 0x00000007,
}
alias COLORDATATYPE = int;

enum : int
{
    BM_x555RGB             = 0x00000000,
    BM_x555XYZ             = 0x00000101,
    BM_x555Yxy             = 0x00000102,
    BM_x555Lab             = 0x00000103,
    BM_x555G3CH            = 0x00000104,
    BM_RGBTRIPLETS         = 0x00000002,
    BM_BGRTRIPLETS         = 0x00000004,
    BM_XYZTRIPLETS         = 0x00000201,
    BM_YxyTRIPLETS         = 0x00000202,
    BM_LabTRIPLETS         = 0x00000203,
    BM_G3CHTRIPLETS        = 0x00000204,
    BM_5CHANNEL            = 0x00000205,
    BM_6CHANNEL            = 0x00000206,
    BM_7CHANNEL            = 0x00000207,
    BM_8CHANNEL            = 0x00000208,
    BM_GRAY                = 0x00000209,
    BM_xRGBQUADS           = 0x00000008,
    BM_xBGRQUADS           = 0x00000010,
    BM_xG3CHQUADS          = 0x00000304,
    BM_KYMCQUADS           = 0x00000305,
    BM_CMYKQUADS           = 0x00000020,
    BM_10b_RGB             = 0x00000009,
    BM_10b_XYZ             = 0x00000401,
    BM_10b_Yxy             = 0x00000402,
    BM_10b_Lab             = 0x00000403,
    BM_10b_G3CH            = 0x00000404,
    BM_NAMED_INDEX         = 0x00000405,
    BM_16b_RGB             = 0x0000000a,
    BM_16b_XYZ             = 0x00000501,
    BM_16b_Yxy             = 0x00000502,
    BM_16b_Lab             = 0x00000503,
    BM_16b_G3CH            = 0x00000504,
    BM_16b_GRAY            = 0x00000505,
    BM_565RGB              = 0x00000001,
    BM_32b_scRGB           = 0x00000601,
    BM_32b_scARGB          = 0x00000602,
    BM_S2DOT13FIXED_scRGB  = 0x00000603,
    BM_S2DOT13FIXED_scARGB = 0x00000604,
    BM_R10G10B10A2         = 0x00000701,
    BM_R10G10B10A2_XR      = 0x00000702,
    BM_R16G16B16A16_FLOAT  = 0x00000703,
}
alias BMFORMAT = int;

enum : int
{
    WCS_PROFILE_MANAGEMENT_SCOPE_SYSTEM_WIDE  = 0x00000000,
    WCS_PROFILE_MANAGEMENT_SCOPE_CURRENT_USER = 0x00000001,
}
alias WCS_PROFILE_MANAGEMENT_SCOPE = int;

// Callbacks

alias ICMENUMPROCA = int function(const(char)* param0, LPARAM param1);
alias ICMENUMPROCW = int function(const(wchar)* param0, LPARAM param1);
alias PBMCALLBACKFN = BOOL function(uint param0, uint param1, LPARAM param2);
alias LPBMCALLBACKFN = BOOL function();
alias PCMSCALLBACKW = BOOL function(COLORMATCHSETUPW* param0, LPARAM param1);
alias PCMSCALLBACKA = BOOL function(COLORMATCHSETUPA* param0, LPARAM param1);

// Structs


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
    uint         lcsSignature;
    uint         lcsVersion;
    uint         lcsSize;
    int          lcsCSType;
    int          lcsIntent;
    CIEXYZTRIPLE lcsEndpoints;
    uint         lcsGammaRed;
    uint         lcsGammaGreen;
    uint         lcsGammaBlue;
    byte[260]    lcsFilename;
}

struct LOGCOLORSPACEW
{
    uint         lcsSignature;
    uint         lcsVersion;
    uint         lcsSize;
    int          lcsCSType;
    int          lcsIntent;
    CIEXYZTRIPLE lcsEndpoints;
    uint         lcsGammaRed;
    uint         lcsGammaGreen;
    uint         lcsGammaBlue;
    ushort[260]  lcsFilename;
}

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
    uint[3] aVertexIndex;
}

struct GamutShell
{
    float               JMin;
    float               JMax;
    uint                cVertices;
    uint                cTriangles;
    JabColorF*          pVertices;
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
    uint              cNeutralSamples;
    JabColorF*        pNeutralSamples;
    GamutShell*       pReferenceShell;
    GamutShell*       pPlausibleShell;
    GamutShell*       pPossibleShell;
}

struct BlackInformation
{
    BOOL  fBlackOnly;
    float blackWeight;
}

struct NAMED_PROFILE_INFO
{
    uint     dwFlags;
    uint     dwCount;
    uint     dwCountDevCoordinates;
    byte[32] szPrefix;
    byte[32] szSuffix;
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
    ubyte[8] channel;
}

union COLOR
{
    GRAYCOLOR       gray;
    RGBCOLOR        rgb;
    CMYKCOLOR       cmyk;
    XYZCOLOR        XYZ;
    YxyCOLOR        Yxy;
    LabCOLOR        Lab;
    GENERIC3CHANNEL gen3ch;
    NAMEDCOLOR      named;
    HiFiCOLOR       hifi;
    struct
    {
        uint  reserved1;
        void* reserved2;
    }
}

struct PROFILEHEADER
{
    uint      phSize;
    uint      phCMMType;
    uint      phVersion;
    uint      phClass;
    uint      phDataColorSpace;
    uint      phConnectionSpace;
    uint[3]   phDateTime;
    uint      phSignature;
    uint      phPlatform;
    uint      phProfileFlags;
    uint      phManufacturer;
    uint      phModel;
    uint[2]   phAttributes;
    uint      phRenderingIntent;
    CIEXYZ    phIlluminant;
    uint      phCreator;
    ubyte[44] phReserved;
}

struct PROFILE
{
    uint  dwType;
    void* pProfileData;
    uint  cbDataSize;
}

struct ENUMTYPEA
{
    uint         dwSize;
    uint         dwVersion;
    uint         dwFields;
    const(char)* pDeviceName;
    uint         dwMediaType;
    uint         dwDitheringMode;
    uint[2]      dwResolution;
    uint         dwCMMType;
    uint         dwClass;
    uint         dwDataColorSpace;
    uint         dwConnectionSpace;
    uint         dwSignature;
    uint         dwPlatform;
    uint         dwProfileFlags;
    uint         dwManufacturer;
    uint         dwModel;
    uint[2]      dwAttributes;
    uint         dwRenderingIntent;
    uint         dwCreator;
    uint         dwDeviceClass;
}

struct ENUMTYPEW
{
    uint          dwSize;
    uint          dwVersion;
    uint          dwFields;
    const(wchar)* pDeviceName;
    uint          dwMediaType;
    uint          dwDitheringMode;
    uint[2]       dwResolution;
    uint          dwCMMType;
    uint          dwClass;
    uint          dwDataColorSpace;
    uint          dwConnectionSpace;
    uint          dwSignature;
    uint          dwPlatform;
    uint          dwProfileFlags;
    uint          dwManufacturer;
    uint          dwModel;
    uint[2]       dwAttributes;
    uint          dwRenderingIntent;
    uint          dwCreator;
    uint          dwDeviceClass;
}

struct COLORMATCHSETUPW
{
    uint          dwSize;
    uint          dwVersion;
    uint          dwFlags;
    HWND          hwndOwner;
    const(wchar)* pSourceName;
    const(wchar)* pDisplayName;
    const(wchar)* pPrinterName;
    uint          dwRenderIntent;
    uint          dwProofingIntent;
    const(wchar)* pMonitorProfile;
    uint          ccMonitorProfile;
    const(wchar)* pPrinterProfile;
    uint          ccPrinterProfile;
    const(wchar)* pTargetProfile;
    uint          ccTargetProfile;
    DLGPROC       lpfnHook;
    LPARAM        lParam;
    PCMSCALLBACKW lpfnApplyCallback;
    LPARAM        lParamApplyCallback;
}

struct COLORMATCHSETUPA
{
    uint          dwSize;
    uint          dwVersion;
    uint          dwFlags;
    HWND          hwndOwner;
    const(char)*  pSourceName;
    const(char)*  pDisplayName;
    const(char)*  pPrinterName;
    uint          dwRenderIntent;
    uint          dwProofingIntent;
    const(char)*  pMonitorProfile;
    uint          ccMonitorProfile;
    const(char)*  pPrinterProfile;
    uint          ccPrinterProfile;
    const(char)*  pTargetProfile;
    uint          ccTargetProfile;
    DLGPROC       lpfnHook;
    LPARAM        lParam;
    PCMSCALLBACKA lpfnApplyCallback;
    LPARAM        lParamApplyCallback;
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
    union
    {
        XYYPoint xyY;
        float    CCT;
    }
    int CHROMATICITY = 0x00000000;
    int TEMPERATURE  = 0x00000001;
    int D65          = 0x00000002;
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
    ushort[256] red;
    ushort[256] green;
    ushort[256] blue;
}

// Functions

@DllImport("GDI32")
int SetICMMode(HDC hdc, int mode);

@DllImport("GDI32")
BOOL CheckColorsInGamut(HDC hdc, char* lpRGBTriple, char* dlpBuffer, uint nCount);

@DllImport("GDI32")
HCOLORSPACE GetColorSpace(HDC hdc);

@DllImport("GDI32")
BOOL GetLogColorSpaceA(HCOLORSPACE hColorSpace, char* lpBuffer, uint nSize);

@DllImport("GDI32")
BOOL GetLogColorSpaceW(HCOLORSPACE hColorSpace, char* lpBuffer, uint nSize);

@DllImport("GDI32")
HCOLORSPACE CreateColorSpaceA(LOGCOLORSPACEA* lplcs);

@DllImport("GDI32")
HCOLORSPACE CreateColorSpaceW(LOGCOLORSPACEW* lplcs);

@DllImport("GDI32")
HCOLORSPACE SetColorSpace(HDC hdc, HCOLORSPACE hcs);

@DllImport("GDI32")
BOOL DeleteColorSpace(HCOLORSPACE hcs);

@DllImport("GDI32")
BOOL GetICMProfileA(HDC hdc, uint* pBufSize, const(char)* pszFilename);

@DllImport("GDI32")
BOOL GetICMProfileW(HDC hdc, uint* pBufSize, const(wchar)* pszFilename);

@DllImport("GDI32")
BOOL SetICMProfileA(HDC hdc, const(char)* lpFileName);

@DllImport("GDI32")
BOOL SetICMProfileW(HDC hdc, const(wchar)* lpFileName);

@DllImport("GDI32")
BOOL GetDeviceGammaRamp(HDC hdc, char* lpRamp);

@DllImport("GDI32")
BOOL SetDeviceGammaRamp(HDC hdc, char* lpRamp);

@DllImport("GDI32")
BOOL ColorMatchToTarget(HDC hdc, HDC hdcTarget, uint action);

@DllImport("GDI32")
int EnumICMProfilesA(HDC hdc, ICMENUMPROCA proc, LPARAM param2);

@DllImport("GDI32")
int EnumICMProfilesW(HDC hdc, ICMENUMPROCW proc, LPARAM param2);

@DllImport("GDI32")
BOOL UpdateICMRegKeyA(uint reserved, const(char)* lpszCMID, const(char)* lpszFileName, uint command);

@DllImport("GDI32")
BOOL UpdateICMRegKeyW(uint reserved, const(wchar)* lpszCMID, const(wchar)* lpszFileName, uint command);

@DllImport("GDI32")
BOOL ColorCorrectPalette(HDC hdc, HPALETTE hPal, uint deFirst, uint num);

@DllImport("mscms")
ptrdiff_t OpenColorProfileA(PROFILE* pProfile, uint dwDesiredAccess, uint dwShareMode, uint dwCreationMode);

@DllImport("mscms")
ptrdiff_t OpenColorProfileW(PROFILE* pProfile, uint dwDesiredAccess, uint dwShareMode, uint dwCreationMode);

@DllImport("mscms")
BOOL CloseColorProfile(ptrdiff_t hProfile);

@DllImport("mscms")
BOOL GetColorProfileFromHandle(ptrdiff_t hProfile, char* pProfile, uint* pcbProfile);

@DllImport("mscms")
BOOL IsColorProfileValid(ptrdiff_t hProfile, int* pbValid);

@DllImport("mscms")
BOOL CreateProfileFromLogColorSpaceA(LOGCOLORSPACEA* pLogColorSpace, ubyte** pProfile);

@DllImport("mscms")
BOOL CreateProfileFromLogColorSpaceW(LOGCOLORSPACEW* pLogColorSpace, ubyte** pProfile);

@DllImport("mscms")
BOOL GetCountColorProfileElements(ptrdiff_t hProfile, uint* pnElementCount);

@DllImport("mscms")
BOOL GetColorProfileHeader(ptrdiff_t hProfile, PROFILEHEADER* pHeader);

@DllImport("mscms")
BOOL GetColorProfileElementTag(ptrdiff_t hProfile, uint dwIndex, uint* pTag);

@DllImport("mscms")
BOOL IsColorProfileTagPresent(ptrdiff_t hProfile, uint tag, int* pbPresent);

@DllImport("mscms")
BOOL GetColorProfileElement(ptrdiff_t hProfile, uint tag, uint dwOffset, uint* pcbElement, char* pElement, 
                            int* pbReference);

@DllImport("mscms")
BOOL SetColorProfileHeader(ptrdiff_t hProfile, char* pHeader);

@DllImport("mscms")
BOOL SetColorProfileElementSize(ptrdiff_t hProfile, uint tagType, uint pcbElement);

@DllImport("mscms")
BOOL SetColorProfileElement(ptrdiff_t hProfile, uint tag, uint dwOffset, uint* pcbElement, char* pElement);

@DllImport("mscms")
BOOL SetColorProfileElementReference(ptrdiff_t hProfile, uint newTag, uint refTag);

@DllImport("mscms")
BOOL GetPS2ColorSpaceArray(ptrdiff_t hProfile, uint dwIntent, uint dwCSAType, char* pPS2ColorSpaceArray, 
                           uint* pcbPS2ColorSpaceArray, int* pbBinary);

@DllImport("mscms")
BOOL GetPS2ColorRenderingIntent(ptrdiff_t hProfile, uint dwIntent, char* pBuffer, uint* pcbPS2ColorRenderingIntent);

@DllImport("mscms")
BOOL GetPS2ColorRenderingDictionary(ptrdiff_t hProfile, uint dwIntent, char* pPS2ColorRenderingDictionary, 
                                    uint* pcbPS2ColorRenderingDictionary, int* pbBinary);

@DllImport("mscms")
BOOL GetNamedProfileInfo(ptrdiff_t hProfile, char* pNamedProfileInfo);

@DllImport("mscms")
BOOL ConvertColorNameToIndex(ptrdiff_t hProfile, char* paColorName, char* paIndex, uint dwCount);

@DllImport("mscms")
BOOL ConvertIndexToColorName(ptrdiff_t hProfile, char* paIndex, char* paColorName, uint dwCount);

@DllImport("mscms")
BOOL CreateDeviceLinkProfile(char* hProfile, uint nProfiles, char* padwIntent, uint nIntents, uint dwFlags, 
                             ubyte** pProfileData, uint indexPreferredCMM);

@DllImport("mscms")
ptrdiff_t CreateColorTransformA(LOGCOLORSPACEA* pLogColorSpace, ptrdiff_t hDestProfile, ptrdiff_t hTargetProfile, 
                                uint dwFlags);

@DllImport("mscms")
ptrdiff_t CreateColorTransformW(LOGCOLORSPACEW* pLogColorSpace, ptrdiff_t hDestProfile, ptrdiff_t hTargetProfile, 
                                uint dwFlags);

@DllImport("mscms")
ptrdiff_t CreateMultiProfileTransform(char* pahProfiles, uint nProfiles, char* padwIntent, uint nIntents, 
                                      uint dwFlags, uint indexPreferredCMM);

@DllImport("mscms")
BOOL DeleteColorTransform(ptrdiff_t hxform);

@DllImport("mscms")
BOOL TranslateBitmapBits(ptrdiff_t hColorTransform, void* pSrcBits, BMFORMAT bmInput, uint dwWidth, uint dwHeight, 
                         uint dwInputStride, void* pDestBits, BMFORMAT bmOutput, uint dwOutputStride, 
                         PBMCALLBACKFN pfnCallBack, LPARAM ulCallbackData);

@DllImport("mscms")
BOOL CheckBitmapBits(ptrdiff_t hColorTransform, void* pSrcBits, BMFORMAT bmInput, uint dwWidth, uint dwHeight, 
                     uint dwStride, char* paResult, PBMCALLBACKFN pfnCallback, LPARAM lpCallbackData);

@DllImport("mscms")
BOOL TranslateColors(ptrdiff_t hColorTransform, char* paInputColors, uint nColors, COLORTYPE ctInput, 
                     char* paOutputColors, COLORTYPE ctOutput);

@DllImport("mscms")
BOOL CheckColors(ptrdiff_t hColorTransform, char* paInputColors, uint nColors, COLORTYPE ctInput, char* paResult);

@DllImport("mscms")
uint GetCMMInfo(ptrdiff_t hColorTransform, uint param1);

@DllImport("mscms")
BOOL RegisterCMMA(const(char)* pMachineName, uint cmmID, const(char)* pCMMdll);

@DllImport("mscms")
BOOL RegisterCMMW(const(wchar)* pMachineName, uint cmmID, const(wchar)* pCMMdll);

@DllImport("mscms")
BOOL UnregisterCMMA(const(char)* pMachineName, uint cmmID);

@DllImport("mscms")
BOOL UnregisterCMMW(const(wchar)* pMachineName, uint cmmID);

@DllImport("mscms")
BOOL SelectCMM(uint dwCMMType);

@DllImport("mscms")
BOOL GetColorDirectoryA(const(char)* pMachineName, const(char)* pBuffer, uint* pdwSize);

@DllImport("mscms")
BOOL GetColorDirectoryW(const(wchar)* pMachineName, const(wchar)* pBuffer, uint* pdwSize);

@DllImport("mscms")
BOOL InstallColorProfileA(const(char)* pMachineName, const(char)* pProfileName);

@DllImport("mscms")
BOOL InstallColorProfileW(const(wchar)* pMachineName, const(wchar)* pProfileName);

@DllImport("mscms")
BOOL UninstallColorProfileA(const(char)* pMachineName, const(char)* pProfileName, BOOL bDelete);

@DllImport("mscms")
BOOL UninstallColorProfileW(const(wchar)* pMachineName, const(wchar)* pProfileName, BOOL bDelete);

@DllImport("mscms")
BOOL EnumColorProfilesA(const(char)* pMachineName, ENUMTYPEA* pEnumRecord, char* pEnumerationBuffer, 
                        uint* pdwSizeOfEnumerationBuffer, uint* pnProfiles);

@DllImport("mscms")
BOOL EnumColorProfilesW(const(wchar)* pMachineName, ENUMTYPEW* pEnumRecord, char* pEnumerationBuffer, 
                        uint* pdwSizeOfEnumerationBuffer, uint* pnProfiles);

@DllImport("mscms")
BOOL SetStandardColorSpaceProfileA(const(char)* pMachineName, uint dwProfileID, const(char)* pProfilename);

@DllImport("mscms")
BOOL SetStandardColorSpaceProfileW(const(wchar)* pMachineName, uint dwProfileID, const(wchar)* pProfileName);

@DllImport("mscms")
BOOL GetStandardColorSpaceProfileA(const(char)* pMachineName, uint dwSCS, const(char)* pBuffer, uint* pcbSize);

@DllImport("mscms")
BOOL GetStandardColorSpaceProfileW(const(wchar)* pMachineName, uint dwSCS, const(wchar)* pBuffer, uint* pcbSize);

@DllImport("mscms")
BOOL AssociateColorProfileWithDeviceA(const(char)* pMachineName, const(char)* pProfileName, 
                                      const(char)* pDeviceName);

@DllImport("mscms")
BOOL AssociateColorProfileWithDeviceW(const(wchar)* pMachineName, const(wchar)* pProfileName, 
                                      const(wchar)* pDeviceName);

@DllImport("mscms")
BOOL DisassociateColorProfileFromDeviceA(const(char)* pMachineName, const(char)* pProfileName, 
                                         const(char)* pDeviceName);

@DllImport("mscms")
BOOL DisassociateColorProfileFromDeviceW(const(wchar)* pMachineName, const(wchar)* pProfileName, 
                                         const(wchar)* pDeviceName);

@DllImport("ICMUI")
BOOL SetupColorMatchingW(char* pcms);

@DllImport("ICMUI")
BOOL SetupColorMatchingA(char* pcms);

@DllImport("mscms")
BOOL WcsAssociateColorProfileWithDevice(WCS_PROFILE_MANAGEMENT_SCOPE scope_, const(wchar)* pProfileName, 
                                        const(wchar)* pDeviceName);

@DllImport("mscms")
BOOL WcsDisassociateColorProfileFromDevice(WCS_PROFILE_MANAGEMENT_SCOPE scope_, const(wchar)* pProfileName, 
                                           const(wchar)* pDeviceName);

@DllImport("mscms")
BOOL WcsEnumColorProfilesSize(WCS_PROFILE_MANAGEMENT_SCOPE scope_, ENUMTYPEW* pEnumRecord, uint* pdwSize);

@DllImport("mscms")
BOOL WcsEnumColorProfiles(WCS_PROFILE_MANAGEMENT_SCOPE scope_, ENUMTYPEW* pEnumRecord, char* pBuffer, uint dwSize, 
                          uint* pnProfiles);

@DllImport("mscms")
BOOL WcsGetDefaultColorProfileSize(WCS_PROFILE_MANAGEMENT_SCOPE scope_, const(wchar)* pDeviceName, 
                                   COLORPROFILETYPE cptColorProfileType, COLORPROFILESUBTYPE cpstColorProfileSubType, 
                                   uint dwProfileID, uint* pcbProfileName);

@DllImport("mscms")
BOOL WcsGetDefaultColorProfile(WCS_PROFILE_MANAGEMENT_SCOPE scope_, const(wchar)* pDeviceName, 
                               COLORPROFILETYPE cptColorProfileType, COLORPROFILESUBTYPE cpstColorProfileSubType, 
                               uint dwProfileID, uint cbProfileName, const(wchar)* pProfileName);

@DllImport("mscms")
BOOL WcsSetDefaultColorProfile(WCS_PROFILE_MANAGEMENT_SCOPE scope_, const(wchar)* pDeviceName, 
                               COLORPROFILETYPE cptColorProfileType, COLORPROFILESUBTYPE cpstColorProfileSubType, 
                               uint dwProfileID, const(wchar)* pProfileName);

@DllImport("mscms")
BOOL WcsSetDefaultRenderingIntent(WCS_PROFILE_MANAGEMENT_SCOPE scope_, uint dwRenderingIntent);

@DllImport("mscms")
BOOL WcsGetDefaultRenderingIntent(WCS_PROFILE_MANAGEMENT_SCOPE scope_, uint* pdwRenderingIntent);

@DllImport("mscms")
BOOL WcsGetUsePerUserProfiles(const(wchar)* pDeviceName, uint dwDeviceClass, int* pUsePerUserProfiles);

@DllImport("mscms")
BOOL WcsSetUsePerUserProfiles(const(wchar)* pDeviceName, uint dwDeviceClass, BOOL usePerUserProfiles);

@DllImport("mscms")
BOOL WcsTranslateColors(ptrdiff_t hColorTransform, uint nColors, uint nInputChannels, COLORDATATYPE cdtInput, 
                        uint cbInput, char* pInputData, uint nOutputChannels, COLORDATATYPE cdtOutput, uint cbOutput, 
                        char* pOutputData);

@DllImport("mscms")
BOOL WcsCheckColors(ptrdiff_t hColorTransform, uint nColors, uint nInputChannels, COLORDATATYPE cdtInput, 
                    uint cbInput, char* pInputData, char* paResult);

@DllImport("ICM32")
BOOL CMCheckColors(ptrdiff_t hcmTransform, char* lpaInputColors, uint nColors, COLORTYPE ctInput, char* lpaResult);

@DllImport("ICM32")
BOOL CMCheckRGBs(ptrdiff_t hcmTransform, void* lpSrcBits, BMFORMAT bmInput, uint dwWidth, uint dwHeight, 
                 uint dwStride, char* lpaResult, PBMCALLBACKFN pfnCallback, LPARAM ulCallbackData);

@DllImport("ICM32")
BOOL CMConvertColorNameToIndex(ptrdiff_t hProfile, char* paColorName, char* paIndex, uint dwCount);

@DllImport("ICM32")
BOOL CMConvertIndexToColorName(ptrdiff_t hProfile, char* paIndex, char* paColorName, uint dwCount);

@DllImport("ICM32")
BOOL CMCreateDeviceLinkProfile(char* pahProfiles, uint nProfiles, char* padwIntents, uint nIntents, uint dwFlags, 
                               ubyte** lpProfileData);

@DllImport("ICM32")
ptrdiff_t CMCreateMultiProfileTransform(char* pahProfiles, uint nProfiles, char* padwIntents, uint nIntents, 
                                        uint dwFlags);

@DllImport("ICM32")
BOOL CMCreateProfileW(LOGCOLORSPACEW* lpColorSpace, void** lpProfileData);

@DllImport("ICM32")
ptrdiff_t CMCreateTransform(LOGCOLORSPACEA* lpColorSpace, void* lpDevCharacter, void* lpTargetDevCharacter);

@DllImport("ICM32")
ptrdiff_t CMCreateTransformW(LOGCOLORSPACEW* lpColorSpace, void* lpDevCharacter, void* lpTargetDevCharacter);

@DllImport("ICM32")
ptrdiff_t CMCreateTransformExt(LOGCOLORSPACEA* lpColorSpace, void* lpDevCharacter, void* lpTargetDevCharacter, 
                               uint dwFlags);

@DllImport("ICM32")
BOOL CMCheckColorsInGamut(ptrdiff_t hcmTransform, char* lpaRGBTriple, char* lpaResult, uint nCount);

@DllImport("ICM32")
BOOL CMCreateProfile(LOGCOLORSPACEA* lpColorSpace, void** lpProfileData);

@DllImport("ICM32")
BOOL CMTranslateRGB(ptrdiff_t hcmTransform, uint ColorRef, uint* lpColorRef, uint dwFlags);

@DllImport("ICM32")
BOOL CMTranslateRGBs(ptrdiff_t hcmTransform, void* lpSrcBits, BMFORMAT bmInput, uint dwWidth, uint dwHeight, 
                     uint dwStride, void* lpDestBits, BMFORMAT bmOutput, uint dwTranslateDirection);

@DllImport("ICM32")
ptrdiff_t CMCreateTransformExtW(LOGCOLORSPACEW* lpColorSpace, void* lpDevCharacter, void* lpTargetDevCharacter, 
                                uint dwFlags);

@DllImport("ICM32")
BOOL CMDeleteTransform(ptrdiff_t hcmTransform);

@DllImport("ICM32")
uint CMGetInfo(uint dwInfo);

@DllImport("ICM32")
BOOL CMGetNamedProfileInfo(ptrdiff_t hProfile, NAMED_PROFILE_INFO* pNamedProfileInfo);

@DllImport("ICM32")
BOOL CMIsProfileValid(ptrdiff_t hProfile, int* lpbValid);

@DllImport("ICM32")
BOOL CMTranslateColors(ptrdiff_t hcmTransform, char* lpaInputColors, uint nColors, COLORTYPE ctInput, 
                       char* lpaOutputColors, COLORTYPE ctOutput);

@DllImport("ICM32")
BOOL CMTranslateRGBsExt(ptrdiff_t hcmTransform, void* lpSrcBits, BMFORMAT bmInput, uint dwWidth, uint dwHeight, 
                        uint dwInputStride, void* lpDestBits, BMFORMAT bmOutput, uint dwOutputStride, 
                        LPBMCALLBACKFN lpfnCallback, LPARAM ulCallbackData);

@DllImport("mscms")
ptrdiff_t WcsOpenColorProfileA(PROFILE* pCDMPProfile, PROFILE* pCAMPProfile, PROFILE* pGMMPProfile, 
                               uint dwDesireAccess, uint dwShareMode, uint dwCreationMode, uint dwFlags);

@DllImport("mscms")
ptrdiff_t WcsOpenColorProfileW(PROFILE* pCDMPProfile, PROFILE* pCAMPProfile, PROFILE* pGMMPProfile, 
                               uint dwDesireAccess, uint dwShareMode, uint dwCreationMode, uint dwFlags);

@DllImport("mscms")
ptrdiff_t WcsCreateIccProfile(ptrdiff_t hWcsProfile, uint dwOptions);

@DllImport("mscms")
BOOL WcsGetCalibrationManagementState(int* pbIsEnabled);

@DllImport("mscms")
BOOL WcsSetCalibrationManagementState(BOOL bIsEnabled);

@DllImport("mscms")
HRESULT ColorAdapterGetSystemModifyWhitePointCaps(int* whitePointAdjCapable, int* isColorOverrideActive);

@DllImport("mscms")
HRESULT ColorAdapterUpdateDisplayGamma(DisplayID displayID, DisplayTransformLut* displayTransform, BOOL internal);

@DllImport("mscms")
HRESULT ColorAdapterUpdateDeviceProfile(DisplayID displayID, const(wchar)* profName);

@DllImport("mscms")
HRESULT ColorAdapterGetDisplayCurrentStateID(DisplayID displayID, DisplayStateID* displayStateID);

@DllImport("mscms")
HRESULT ColorAdapterGetDisplayTransformData(DisplayID displayID, DisplayTransformLut* displayTransformLut, 
                                            uint* transformID);

@DllImport("mscms")
HRESULT ColorAdapterGetDisplayTargetWhitePoint(DisplayID displayID, WhitePoint* wtpt, uint* transitionTime, 
                                               uint* whitepointID);

@DllImport("mscms")
HRESULT ColorAdapterGetDisplayProfile(DisplayID displayID, const(wchar)* displayProfile, uint* profileID, 
                                      int* bUseAccurate);

@DllImport("mscms")
HRESULT ColorAdapterGetCurrentProfileCalibration(DisplayID displayID, uint maxCalibrationBlobSize, uint* blobSize, 
                                                 char* calibrationBlob);

@DllImport("mscms")
HRESULT ColorAdapterRegisterOEMColorService(HANDLE* registration);

@DllImport("mscms")
HRESULT ColorAdapterUnregisterOEMColorService(HANDLE registration);

@DllImport("mscms")
HRESULT ColorProfileAddDisplayAssociation(WCS_PROFILE_MANAGEMENT_SCOPE scope_, const(wchar)* profileName, 
                                          LUID targetAdapterID, uint sourceID, BOOL setAsDefault, 
                                          BOOL associateAsAdvancedColor);

@DllImport("mscms")
HRESULT ColorProfileRemoveDisplayAssociation(WCS_PROFILE_MANAGEMENT_SCOPE scope_, const(wchar)* profileName, 
                                             LUID targetAdapterID, uint sourceID, BOOL dissociateAdvancedColor);

@DllImport("mscms")
HRESULT ColorProfileSetDisplayDefaultAssociation(WCS_PROFILE_MANAGEMENT_SCOPE scope_, const(wchar)* profileName, 
                                                 COLORPROFILETYPE profileType, COLORPROFILESUBTYPE profileSubType, 
                                                 LUID targetAdapterID, uint sourceID);

@DllImport("mscms")
HRESULT ColorProfileGetDisplayList(WCS_PROFILE_MANAGEMENT_SCOPE scope_, LUID targetAdapterID, uint sourceID, 
                                   ushort*** profileList, uint* profileCount);

@DllImport("mscms")
HRESULT ColorProfileGetDisplayDefault(WCS_PROFILE_MANAGEMENT_SCOPE scope_, LUID targetAdapterID, uint sourceID, 
                                      COLORPROFILETYPE profileType, COLORPROFILESUBTYPE profileSubType, 
                                      ushort** profileName);

@DllImport("mscms")
HRESULT ColorProfileGetDisplayUserScope(LUID targetAdapterID, uint sourceID, WCS_PROFILE_MANAGEMENT_SCOPE* scope_);


// Interfaces

@GUID("1CD63475-07C4-46FE-A903-D655316D11FD")
interface IDeviceModelPlugIn : IUnknown
{
    HRESULT Initialize(BSTR bstrXml, uint cNumModels, uint iModelPosition);
    HRESULT GetNumChannels(uint* pNumChannels);
    HRESULT DeviceToColorimetricColors(uint cColors, uint cChannels, char* pDeviceValues, char* pXYZColors);
    HRESULT ColorimetricToDeviceColors(uint cColors, uint cChannels, char* pXYZColors, char* pDeviceValues);
    HRESULT ColorimetricToDeviceColorsWithBlack(uint cColors, uint cChannels, char* pXYZColors, 
                                                char* pBlackInformation, char* pDeviceValues);
    HRESULT SetTransformDeviceModelInfo(uint iModelPosition, IDeviceModelPlugIn pIDeviceModelOther);
    HRESULT GetPrimarySamples(PrimaryXYZColors* pPrimaryColor);
    HRESULT GetGamutBoundaryMeshSize(uint* pNumVertices, uint* pNumTriangles);
    HRESULT GetGamutBoundaryMesh(uint cChannels, uint cVertices, uint cTriangles, char* pVertices, 
                                 char* pTriangles);
    HRESULT GetNeutralAxisSize(uint* pcColors);
    HRESULT GetNeutralAxis(uint cColors, char* pXYZColors);
}

@GUID("2DD80115-AD1E-41F6-A219-A4F4B583D1F9")
interface IGamutMapModelPlugIn : IUnknown
{
    HRESULT Initialize(BSTR bstrXml, IDeviceModelPlugIn pSrcPlugIn, IDeviceModelPlugIn pDestPlugIn, 
                       GamutBoundaryDescription* pSrcGBD, GamutBoundaryDescription* pDestGBD);
    HRESULT SourceToDestinationAppearanceColors(uint cColors, char* pInputColors, char* pOutputColors);
}


// GUIDs


const GUID IID_IDeviceModelPlugIn   = GUIDOF!IDeviceModelPlugIn;
const GUID IID_IGamutMapModelPlugIn = GUIDOF!IGamutMapModelPlugIn;
