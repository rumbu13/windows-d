module windows.ipc;

public import windows.systemservices;

extern(Windows):

@DllImport("KERNEL32.dll")
HANDLE CreateNamedPipeA(const(char)* lpName, uint dwOpenMode, uint dwPipeMode, uint nMaxInstances, uint nOutBufferSize, uint nInBufferSize, uint nDefaultTimeOut, SECURITY_ATTRIBUTES* lpSecurityAttributes);

@DllImport("KERNEL32.dll")
BOOL WaitNamedPipeA(const(char)* lpNamedPipeName, uint nTimeOut);

