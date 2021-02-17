// Written in the D programming language.

module windows.sync;

public import windows.core;
public import windows.systemservices : NamespaceHandle, RTL_CRITICAL_SECTION, SECURITY_ATTRIBUTES;

extern(Windows):


// Functions

///Waits for ownership of the specified critical section object. The function returns when the calling thread is granted
///ownership.
///Params:
///    lpCriticalSection = A pointer to the critical section object.
///Returns:
///    This function does not return a value. This function can raise <b>EXCEPTION_POSSIBLE_DEADLOCK</b> if a wait
///    operation on the critical section times out. The timeout interval is specified by the following registry value:
///    <b>HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager</b>&#92;<b>CriticalSectionTimeout</b>. Do
///    not handle a possible deadlock exception; instead, debug the application.
///    
@DllImport("KERNEL32")
void EnterCriticalSection(RTL_CRITICAL_SECTION* lpCriticalSection);

///Creates a private namespace.
///Params:
///    lpPrivateNamespaceAttributes = A pointer to a SECURITY_ATTRIBUTES structure that specifies the security attributes of the namespace object.
///    lpBoundaryDescriptor = A descriptor that defines how the namespace is to be isolated. The caller must be within this boundary. The
///                           CreateBoundaryDescriptor function creates a boundary descriptor.
///    lpAliasPrefix = The prefix for the namespace. To create an object in this namespace, specify the object name as <i>prefix</i>&
///Returns:
///    If the function succeeds, it returns a handle to the new namespace. If the function fails, the return value is
///    <b>NULL</b>. To get extended error information, call GetLastError.
///    
@DllImport("KERNEL32")
NamespaceHandle CreatePrivateNamespaceA(SECURITY_ATTRIBUTES* lpPrivateNamespaceAttributes, 
                                        void* lpBoundaryDescriptor, const(char)* lpAliasPrefix);

///Opens a private namespace.
///Params:
///    lpBoundaryDescriptor = A descriptor that defines how the namespace is to be isolated. The CreateBoundaryDescriptor function creates a
///                           boundary descriptor.
///    lpAliasPrefix = The prefix for the namespace. To create an object in this namespace, specify the object name as <i>prefix</i>&
///Returns:
///    The function returns the handle to the existing namespace.
///    
@DllImport("KERNEL32")
NamespaceHandle OpenPrivateNamespaceA(void* lpBoundaryDescriptor, const(char)* lpAliasPrefix);


