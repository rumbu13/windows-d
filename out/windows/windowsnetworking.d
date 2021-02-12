module windows.windowsnetworking;

public import windows.security;
public import windows.systemservices;
public import windows.windowsandmessaging;

extern(Windows):

alias NetEnumHandle = int;
struct CONNECTDLGSTRUCTA
{
    uint cbStructure;
    HWND hwndOwner;
    NETRESOURCEA* lpConnRes;
    uint dwFlags;
    uint dwDevNum;
}

struct CONNECTDLGSTRUCTW
{
    uint cbStructure;
    HWND hwndOwner;
    NETRESOURCEW* lpConnRes;
    uint dwFlags;
    uint dwDevNum;
}

struct DISCDLGSTRUCTA
{
    uint cbStructure;
    HWND hwndOwner;
    const(char)* lpLocalName;
    const(char)* lpRemoteName;
    uint dwFlags;
}

struct DISCDLGSTRUCTW
{
    uint cbStructure;
    HWND hwndOwner;
    const(wchar)* lpLocalName;
    const(wchar)* lpRemoteName;
    uint dwFlags;
}

struct NETINFOSTRUCT
{
    uint cbStructure;
    uint dwProviderVersion;
    uint dwStatus;
    uint dwCharacteristics;
    uint dwHandle;
    ushort wNetType;
    uint dwPrinters;
    uint dwDrives;
}

@DllImport("MPR.dll")
uint WNetAddConnectionA(const(char)* lpRemoteName, const(char)* lpPassword, const(char)* lpLocalName);

@DllImport("MPR.dll")
uint WNetAddConnectionW(const(wchar)* lpRemoteName, const(wchar)* lpPassword, const(wchar)* lpLocalName);

@DllImport("MPR.dll")
uint WNetAddConnection2A(NETRESOURCEA* lpNetResource, const(char)* lpPassword, const(char)* lpUserName, uint dwFlags);

@DllImport("MPR.dll")
uint WNetAddConnection2W(NETRESOURCEW* lpNetResource, const(wchar)* lpPassword, const(wchar)* lpUserName, uint dwFlags);

@DllImport("MPR.dll")
uint WNetAddConnection3A(HWND hwndOwner, NETRESOURCEA* lpNetResource, const(char)* lpPassword, const(char)* lpUserName, uint dwFlags);

@DllImport("MPR.dll")
uint WNetAddConnection3W(HWND hwndOwner, NETRESOURCEW* lpNetResource, const(wchar)* lpPassword, const(wchar)* lpUserName, uint dwFlags);

@DllImport("MPR.dll")
uint WNetAddConnection4A(HWND hwndOwner, NETRESOURCEA* lpNetResource, char* pAuthBuffer, uint cbAuthBuffer, uint dwFlags, char* lpUseOptions, uint cbUseOptions);

@DllImport("MPR.dll")
uint WNetAddConnection4W(HWND hwndOwner, NETRESOURCEW* lpNetResource, char* pAuthBuffer, uint cbAuthBuffer, uint dwFlags, char* lpUseOptions, uint cbUseOptions);

@DllImport("MPR.dll")
uint WNetCancelConnectionA(const(char)* lpName, BOOL fForce);

@DllImport("MPR.dll")
uint WNetCancelConnectionW(const(wchar)* lpName, BOOL fForce);

@DllImport("MPR.dll")
uint WNetCancelConnection2A(const(char)* lpName, uint dwFlags, BOOL fForce);

@DllImport("MPR.dll")
uint WNetCancelConnection2W(const(wchar)* lpName, uint dwFlags, BOOL fForce);

@DllImport("MPR.dll")
uint WNetGetConnectionA(const(char)* lpLocalName, const(char)* lpRemoteName, uint* lpnLength);

@DllImport("MPR.dll")
uint WNetGetConnectionW(const(wchar)* lpLocalName, const(wchar)* lpRemoteName, uint* lpnLength);

@DllImport("MPR.dll")
uint WNetUseConnectionA(HWND hwndOwner, NETRESOURCEA* lpNetResource, const(char)* lpPassword, const(char)* lpUserId, uint dwFlags, const(char)* lpAccessName, uint* lpBufferSize, uint* lpResult);

@DllImport("MPR.dll")
uint WNetUseConnectionW(HWND hwndOwner, NETRESOURCEW* lpNetResource, const(wchar)* lpPassword, const(wchar)* lpUserId, uint dwFlags, const(wchar)* lpAccessName, uint* lpBufferSize, uint* lpResult);

@DllImport("MPR.dll")
uint WNetUseConnection4A(HWND hwndOwner, NETRESOURCEA* lpNetResource, char* pAuthBuffer, uint cbAuthBuffer, uint dwFlags, char* lpUseOptions, uint cbUseOptions, const(char)* lpAccessName, uint* lpBufferSize, uint* lpResult);

@DllImport("MPR.dll")
uint WNetUseConnection4W(HWND hwndOwner, NETRESOURCEW* lpNetResource, char* pAuthBuffer, uint cbAuthBuffer, uint dwFlags, char* lpUseOptions, uint cbUseOptions, const(wchar)* lpAccessName, uint* lpBufferSize, uint* lpResult);

@DllImport("MPR.dll")
uint WNetConnectionDialog(HWND hwnd, uint dwType);

@DllImport("MPR.dll")
uint WNetDisconnectDialog(HWND hwnd, uint dwType);

@DllImport("MPR.dll")
uint WNetConnectionDialog1A(CONNECTDLGSTRUCTA* lpConnDlgStruct);

@DllImport("MPR.dll")
uint WNetConnectionDialog1W(CONNECTDLGSTRUCTW* lpConnDlgStruct);

@DllImport("MPR.dll")
uint WNetDisconnectDialog1A(DISCDLGSTRUCTA* lpConnDlgStruct);

@DllImport("MPR.dll")
uint WNetDisconnectDialog1W(DISCDLGSTRUCTW* lpConnDlgStruct);

@DllImport("MPR.dll")
uint WNetOpenEnumA(uint dwScope, uint dwType, uint dwUsage, NETRESOURCEA* lpNetResource, NetEnumHandle* lphEnum);

@DllImport("MPR.dll")
uint WNetOpenEnumW(uint dwScope, uint dwType, uint dwUsage, NETRESOURCEW* lpNetResource, NetEnumHandle* lphEnum);

@DllImport("MPR.dll")
uint WNetEnumResourceA(HANDLE hEnum, uint* lpcCount, char* lpBuffer, uint* lpBufferSize);

@DllImport("MPR.dll")
uint WNetEnumResourceW(HANDLE hEnum, uint* lpcCount, char* lpBuffer, uint* lpBufferSize);

@DllImport("MPR.dll")
uint WNetCloseEnum(HANDLE hEnum);

@DllImport("MPR.dll")
uint WNetGetResourceParentA(NETRESOURCEA* lpNetResource, char* lpBuffer, uint* lpcbBuffer);

@DllImport("MPR.dll")
uint WNetGetResourceParentW(NETRESOURCEW* lpNetResource, char* lpBuffer, uint* lpcbBuffer);

@DllImport("MPR.dll")
uint WNetGetResourceInformationA(NETRESOURCEA* lpNetResource, char* lpBuffer, uint* lpcbBuffer, byte** lplpSystem);

@DllImport("MPR.dll")
uint WNetGetResourceInformationW(NETRESOURCEW* lpNetResource, char* lpBuffer, uint* lpcbBuffer, ushort** lplpSystem);

@DllImport("MPR.dll")
uint WNetGetUniversalNameA(const(char)* lpLocalPath, uint dwInfoLevel, char* lpBuffer, uint* lpBufferSize);

@DllImport("MPR.dll")
uint WNetGetUniversalNameW(const(wchar)* lpLocalPath, uint dwInfoLevel, char* lpBuffer, uint* lpBufferSize);

@DllImport("MPR.dll")
uint WNetGetUserA(const(char)* lpName, const(char)* lpUserName, uint* lpnLength);

@DllImport("MPR.dll")
uint WNetGetUserW(const(wchar)* lpName, const(wchar)* lpUserName, uint* lpnLength);

@DllImport("MPR.dll")
uint WNetGetProviderNameA(uint dwNetType, const(char)* lpProviderName, uint* lpBufferSize);

@DllImport("MPR.dll")
uint WNetGetProviderNameW(uint dwNetType, const(wchar)* lpProviderName, uint* lpBufferSize);

@DllImport("MPR.dll")
uint WNetGetNetworkInformationA(const(char)* lpProvider, NETINFOSTRUCT* lpNetInfoStruct);

@DllImport("MPR.dll")
uint WNetGetNetworkInformationW(const(wchar)* lpProvider, NETINFOSTRUCT* lpNetInfoStruct);

@DllImport("MPR.dll")
uint WNetGetLastErrorA(uint* lpError, const(char)* lpErrorBuf, uint nErrorBufSize, const(char)* lpNameBuf, uint nNameBufSize);

@DllImport("MPR.dll")
uint WNetGetLastErrorW(uint* lpError, const(wchar)* lpErrorBuf, uint nErrorBufSize, const(wchar)* lpNameBuf, uint nNameBufSize);

@DllImport("MPR.dll")
uint MultinetGetConnectionPerformanceA(NETRESOURCEA* lpNetResource, NETCONNECTINFOSTRUCT* lpNetConnectInfoStruct);

@DllImport("MPR.dll")
uint MultinetGetConnectionPerformanceW(NETRESOURCEW* lpNetResource, NETCONNECTINFOSTRUCT* lpNetConnectInfoStruct);

