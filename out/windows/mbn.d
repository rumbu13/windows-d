// Written in the D programming language.

module windows.mbn;

public import windows.core;
public import windows.automation : BSTR, IDispatch;
public import windows.com : HRESULT, IUnknown;
public import windows.mobilebroadband : MBN_BAND_CLASS, MBN_CONTEXT_CONSTANTS, MBN_CTRL_CAPS,
                                        MBN_DATA_CLASS, MBN_INTERFACE_CAPS_CONSTANTS,
                                        MBN_PIN_CONSTANTS, MBN_PROVIDER_CONSTANTS,
                                        MBN_PROVIDER_STATE, MBN_REGISTRATION_CONSTANTS,
                                        MBN_SIGNAL_CONSTANTS, MBN_SMS_CAPS,
                                        MBN_SMS_STATUS_FLAG, WWAEXT_SMS_CONSTANTS;

extern(Windows) @nogc nothrow:


// Enums


alias MBN_DEVICE_SERVICE_SESSIONS_STATE = int;
enum : int
{
    MBN_DEVICE_SERVICE_SESSIONS_RESTORED = 0x00000000,
}

// Structs


struct __mbnapi_ReferenceRemainingTypes__
{
    MBN_BAND_CLASS       bandClass;
    MBN_CONTEXT_CONSTANTS contextConstants;
    MBN_CTRL_CAPS        ctrlCaps;
    MBN_DATA_CLASS       dataClass;
    MBN_INTERFACE_CAPS_CONSTANTS interfaceCapsConstants;
    MBN_PIN_CONSTANTS    pinConstants;
    MBN_PROVIDER_CONSTANTS providerConstants;
    MBN_PROVIDER_STATE   providerState;
    MBN_REGISTRATION_CONSTANTS registrationConstants;
    MBN_SIGNAL_CONSTANTS signalConstants;
    MBN_SMS_CAPS         smsCaps;
    WWAEXT_SMS_CONSTANTS smsConstants;
    WWAEXT_SMS_CONSTANTS wwaextSmsConstants;
    MBN_SMS_STATUS_FLAG  smsStatusFlag;
}

struct __DummyPinType__
{
    uint pinType;
}

// Interfaces

@GUID("BDFEE05A-4418-11DD-90ED-001C257CCFF1")
struct MbnConnectionProfileManager;

@GUID("BDFEE05B-4418-11DD-90ED-001C257CCFF1")
struct MbnInterfaceManager;

@GUID("BDFEE05C-4418-11DD-90ED-001C257CCFF1")
struct MbnConnectionManager;

@GUID("2269DAA3-2A9F-4165-A501-CE00A6F7A75B")
struct MbnDeviceServicesManager;

@GUID("DCBBBAB6-FFFF-4BBB-AAEE-338E368AF6FA")
interface IDummyMBNUCMExt : IDispatch
{
}

@GUID("5D3FF196-89EE-49D8-8B60-33FFDDFFC58D")
interface IMbnDeviceServiceStateEvents : IUnknown
{
    HRESULT OnSessionsStateChange(BSTR interfaceID, MBN_DEVICE_SERVICE_SESSIONS_STATE stateChange);
}


// GUIDs

const GUID CLSID_MbnConnectionManager        = GUIDOF!MbnConnectionManager;
const GUID CLSID_MbnConnectionProfileManager = GUIDOF!MbnConnectionProfileManager;
const GUID CLSID_MbnDeviceServicesManager    = GUIDOF!MbnDeviceServicesManager;
const GUID CLSID_MbnInterfaceManager         = GUIDOF!MbnInterfaceManager;

const GUID IID_IDummyMBNUCMExt              = GUIDOF!IDummyMBNUCMExt;
const GUID IID_IMbnDeviceServiceStateEvents = GUIDOF!IMbnDeviceServiceStateEvents;
