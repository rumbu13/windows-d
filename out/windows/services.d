module windows.services;

public import windows.core;
public import windows.security : SC_HANDLE__;
public import windows.systemservices : BOOL;

extern(Windows):


// Functions

@DllImport("ADVAPI32")
BOOL ChangeServiceConfigA(SC_HANDLE__* hService, uint dwServiceType, uint dwStartType, uint dwErrorControl, 
                          const(char)* lpBinaryPathName, const(char)* lpLoadOrderGroup, uint* lpdwTagId, 
                          const(char)* lpDependencies, const(char)* lpServiceStartName, const(char)* lpPassword, 
                          const(char)* lpDisplayName);

@DllImport("ADVAPI32")
BOOL ChangeServiceConfigW(SC_HANDLE__* hService, uint dwServiceType, uint dwStartType, uint dwErrorControl, 
                          const(wchar)* lpBinaryPathName, const(wchar)* lpLoadOrderGroup, uint* lpdwTagId, 
                          const(wchar)* lpDependencies, const(wchar)* lpServiceStartName, const(wchar)* lpPassword, 
                          const(wchar)* lpDisplayName);

@DllImport("ADVAPI32")
SC_HANDLE__* CreateServiceA(SC_HANDLE__* hSCManager, const(char)* lpServiceName, const(char)* lpDisplayName, 
                            uint dwDesiredAccess, uint dwServiceType, uint dwStartType, uint dwErrorControl, 
                            const(char)* lpBinaryPathName, const(char)* lpLoadOrderGroup, uint* lpdwTagId, 
                            const(char)* lpDependencies, const(char)* lpServiceStartName, const(char)* lpPassword);

@DllImport("ADVAPI32")
SC_HANDLE__* CreateServiceW(SC_HANDLE__* hSCManager, const(wchar)* lpServiceName, const(wchar)* lpDisplayName, 
                            uint dwDesiredAccess, uint dwServiceType, uint dwStartType, uint dwErrorControl, 
                            const(wchar)* lpBinaryPathName, const(wchar)* lpLoadOrderGroup, uint* lpdwTagId, 
                            const(wchar)* lpDependencies, const(wchar)* lpServiceStartName, const(wchar)* lpPassword);


