module windows.tilesbadgesnotifications;

public import windows.core;
public import windows.com : HRESULT, IUnknown;

extern(Windows):


// Structs


struct NOTIFICATION_USER_INPUT_DATA
{
    const(wchar)* Key;
    const(wchar)* Value;
}

// Interfaces

@GUID("53E31837-6600-4A81-9395-75CFFE746F94")
interface INotificationActivationCallback : IUnknown
{
    HRESULT Activate(const(wchar)* appUserModelId, const(wchar)* invokedArgs, char* data, uint count);
}


// GUIDs


const GUID IID_INotificationActivationCallback = GUIDOF!INotificationActivationCallback;
