module windows.tilesbadgesnotifications;

public import windows.com;

extern(Windows):

struct NOTIFICATION_USER_INPUT_DATA
{
    const(wchar)* Key;
    const(wchar)* Value;
}

const GUID IID_INotificationActivationCallback = {0x53E31837, 0x6600, 0x4A81, [0x93, 0x95, 0x75, 0xCF, 0xFE, 0x74, 0x6F, 0x94]};
@GUID(0x53E31837, 0x6600, 0x4A81, [0x93, 0x95, 0x75, 0xCF, 0xFE, 0x74, 0x6F, 0x94]);
interface INotificationActivationCallback : IUnknown
{
    HRESULT Activate(const(wchar)* appUserModelId, const(wchar)* invokedArgs, char* data, uint count);
}

