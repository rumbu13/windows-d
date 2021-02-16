module windows.ipc;

public import windows.core;
public import windows.systemservices : BOOL, HANDLE, SECURITY_ATTRIBUTES;

extern(Windows):


// Functions

@DllImport("KERNEL32")
HANDLE CreateNamedPipeA(const(char)* lpName, uint dwOpenMode, uint dwPipeMode, uint nMaxInstances, 
                        uint nOutBufferSize, uint nInBufferSize, uint nDefaultTimeOut, 
                        SECURITY_ATTRIBUTES* lpSecurityAttributes);

@DllImport("KERNEL32")
BOOL WaitNamedPipeA(const(char)* lpNamedPipeName, uint nTimeOut);


