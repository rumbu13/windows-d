// Written in the D programming language.

module windows.tilesbadgesnotifications;

public import windows.core;
public import windows.com : HRESULT, IUnknown;
public import windows.systemservices : PWSTR;

extern(Windows) @nogc nothrow:


// Structs


///<p class="CCE_Message">[Some information relates to pre-released product which may be substantially modified before
///it's commercially released. Microsoft makes no warranties, express or implied, with respect to the information
///provided here.] Contains information about how a user interacted with a notification toast in the action center. This
///structure is used by Activate.
struct NOTIFICATION_USER_INPUT_DATA
{
    ///The ID of the user input field in the XML payload.
    const(PWSTR) Key;
    ///The input value selected by the user for a given input field.
    const(PWSTR) Value;
}

// Interfaces

///<p class="CCE_Message">[Some information relates to pre-released product which may be substantially modified before
///it's commercially released. Microsoft makes no warranties, express or implied, with respect to the information
///provided here.] Receives notification messages when an app is triggered through a toast from the action center.
@GUID("53E31837-6600-4A81-9395-75CFFE746F94")
interface INotificationActivationCallback : IUnknown
{
    ///<p class="CCE_Message">[Some information relates to pre-released product which may be substantially modified
    ///before it's commercially released. Microsoft makes no warranties, express or implied, with respect to the
    ///information provided here.] Called when a user interacts with a toast in the action center.
    ///Params:
    ///    appUserModelId = The unique identifier representing your app to the notification platform.
    ///    invokedArgs = Arguments from the invoked button. <b>NULL</b> if the toast indicates the default activation and no launch
    ///                  arguments were specified in the XML payload.
    ///    data = The data from the input elements available on the notification toast.
    ///    count = The number of <i>data</i> elements.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT Activate(const(PWSTR) appUserModelId, const(PWSTR) invokedArgs, 
                     const(NOTIFICATION_USER_INPUT_DATA)* data, uint count);
}


// GUIDs


const GUID IID_INotificationActivationCallback = GUIDOF!INotificationActivationCallback;
