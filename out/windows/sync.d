module windows.sync;

public import windows.core;
public import windows.systemservices : NamespaceHandle, RTL_CRITICAL_SECTION, SECURITY_ATTRIBUTES;

extern(Windows):


// Functions

@DllImport("KERNEL32")
void EnterCriticalSection(RTL_CRITICAL_SECTION* lpCriticalSection);

@DllImport("KERNEL32")
NamespaceHandle CreatePrivateNamespaceA(SECURITY_ATTRIBUTES* lpPrivateNamespaceAttributes, 
                                        void* lpBoundaryDescriptor, const(char)* lpAliasPrefix);

@DllImport("KERNEL32")
NamespaceHandle OpenPrivateNamespaceA(void* lpBoundaryDescriptor, const(char)* lpAliasPrefix);


