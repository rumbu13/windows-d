module windows.sync;

public import windows.systemservices;

extern(Windows):

@DllImport("KERNEL32.dll")
void EnterCriticalSection(RTL_CRITICAL_SECTION* lpCriticalSection);

@DllImport("KERNEL32.dll")
NamespaceHandle CreatePrivateNamespaceA(SECURITY_ATTRIBUTES* lpPrivateNamespaceAttributes, void* lpBoundaryDescriptor, const(char)* lpAliasPrefix);

@DllImport("KERNEL32.dll")
NamespaceHandle OpenPrivateNamespaceA(void* lpBoundaryDescriptor, const(char)* lpAliasPrefix);

