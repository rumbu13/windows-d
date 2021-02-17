// Written in the D programming language.

module windows.usbdrivers;

public import windows.core;
public import windows.systemservices : BOOL, HANDLE, LARGE_INTEGER, OVERLAPPED;

extern(Windows):


// Enums


alias USB_DEVICE_SPEED = int;
enum : int
{
    UsbLowSpeed   = 0x00000000,
    UsbFullSpeed  = 0x00000001,
    UsbHighSpeed  = 0x00000002,
    UsbSuperSpeed = 0x00000003,
}

alias USB_DEVICE_TYPE = int;
enum : int
{
    Usb11Device = 0x00000000,
    Usb20Device = 0x00000001,
}

alias USB_CONTROLLER_FLAVOR = int;
enum : int
{
    USB_HcGeneric       = 0x00000000,
    OHCI_Generic        = 0x00000064,
    OHCI_Hydra          = 0x00000065,
    OHCI_NEC            = 0x00000066,
    UHCI_Generic        = 0x000000c8,
    UHCI_Piix4          = 0x000000c9,
    UHCI_Piix3          = 0x000000ca,
    UHCI_Ich2           = 0x000000cb,
    UHCI_Reserved204    = 0x000000cc,
    UHCI_Ich1           = 0x000000cd,
    UHCI_Ich3m          = 0x000000ce,
    UHCI_Ich4           = 0x000000cf,
    UHCI_Ich5           = 0x000000d0,
    UHCI_Ich6           = 0x000000d1,
    UHCI_Intel          = 0x000000f9,
    UHCI_VIA            = 0x000000fa,
    UHCI_VIA_x01        = 0x000000fb,
    UHCI_VIA_x02        = 0x000000fc,
    UHCI_VIA_x03        = 0x000000fd,
    UHCI_VIA_x04        = 0x000000fe,
    UHCI_VIA_x0E_FIFO   = 0x00000108,
    EHCI_Generic        = 0x000003e8,
    EHCI_NEC            = 0x000007d0,
    EHCI_Lucent         = 0x00000bb8,
    EHCI_NVIDIA_Tegra2  = 0x00000fa0,
    EHCI_NVIDIA_Tegra3  = 0x00000fa1,
    EHCI_Intel_Medfield = 0x00001389,
}

alias USBD_PIPE_TYPE = int;
enum : int
{
    UsbdPipeTypeControl     = 0x00000000,
    UsbdPipeTypeIsochronous = 0x00000001,
    UsbdPipeTypeBulk        = 0x00000002,
    UsbdPipeTypeInterrupt   = 0x00000003,
}

alias USBD_ENDPOINT_OFFLOAD_MODE = int;
enum : int
{
    UsbdEndpointOffloadModeNotSupported = 0x00000000,
    UsbdEndpointOffloadSoftwareAssisted = 0x00000001,
    UsbdEndpointOffloadHardwareAssisted = 0x00000002,
}

///The <b>USB_USER_ERROR_CODE</b> enumeration lists the error codes that a USB user-mode request reports when it fails.
alias USB_USER_ERROR_CODE = int;
enum : int
{
    ///The user request succeeded.
    UsbUserSuccess                = 0x00000000,
    ///The user request was not supported.
    UsbUserNotSupported           = 0x00000001,
    ///The user request code was invalid.
    UsbUserInvalidRequestCode     = 0x00000002,
    ///The feature that was specified by user request is disabled.
    UsbUserFeatureDisabled        = 0x00000003,
    ///The user request contains an invalid header parameter.
    UsbUserInvalidHeaderParameter = 0x00000004,
    ///The user request contains an invalid parameter.
    UsbUserInvalidParameter       = 0x00000005,
    ///The user request failed because of a miniport driver error.
    UsbUserMiniportError          = 0x00000006,
    ///The user request failed because the data buffer was too small.
    UsbUserBufferTooSmall         = 0x00000007,
    ///The USB stack could not map the error to one of the errors that are listed in this enumeration.
    UsbUserErrorNotMapped         = 0x00000008,
    ///The device was not started.
    UsbUserDeviceNotStarted       = 0x00000009,
    ///The device was not connected.
    UsbUserNoDeviceConnected      = 0x0000000a,
}

///The <b>WDMUSB_POWER_STATE</b> enumeration indicates the power state of a host controller or root hub.
alias WDMUSB_POWER_STATE = int;
enum : int
{
    ///Power state information is not mapped.
    WdmUsbPowerNotMapped         = 0x00000000,
    ///Power state information is not available.
    WdmUsbPowerSystemUnspecified = 0x00000064,
    ///The system is in the working state.
    WdmUsbPowerSystemWorking     = 0x00000065,
    ///The system is in the S1 power state.
    WdmUsbPowerSystemSleeping1   = 0x00000066,
    ///The system is in the S2 power state.
    WdmUsbPowerSystemSleeping2   = 0x00000067,
    ///The system is in the S3 power state.
    WdmUsbPowerSystemSleeping3   = 0x00000068,
    ///The system is hibernating.
    WdmUsbPowerSystemHibernate   = 0x00000069,
    ///The system is shutdown.
    WdmUsbPowerSystemShutdown    = 0x0000006a,
    ///A device is not specified.
    WdmUsbPowerDeviceUnspecified = 0x000000c8,
    ///The host controller is in the D0 power state.
    WdmUsbPowerDeviceD0          = 0x000000c9,
    ///The host controller is in the D1 power state.
    WdmUsbPowerDeviceD1          = 0x000000ca,
    ///The host controller is in the D2 power state.
    WdmUsbPowerDeviceD2          = 0x000000cb,
    ///The host controller is in the D3 power state.
    WdmUsbPowerDeviceD3          = 0x000000cc,
}

// Callbacks

alias USB_IDLE_CALLBACK = void function(void* Context);

// Structs


union BM_REQUEST_TYPE
{
    struct s
    {
        ubyte _bitfield175;
    }
    ubyte B;
}

struct USB_DEFAULT_PIPE_SETUP_PACKET
{
align (1):
    BM_REQUEST_TYPE bmRequestType;
    ubyte           bRequest;
    union wValue
    {
    align (1):
        struct
        {
            ubyte LowByte;
            ubyte HiByte;
        }
        ushort W;
    }
    union wIndex
    {
    align (1):
        struct
        {
            ubyte LowByte;
            ubyte HiByte;
        }
        ushort W;
    }
    ushort          wLength;
}

union USB_DEVICE_STATUS
{
align (1):
    ushort AsUshort16;
    struct
    {
    align (1):
        ushort _bitfield176;
    }
}

union USB_INTERFACE_STATUS
{
align (1):
    ushort AsUshort16;
    struct
    {
    align (1):
        ushort _bitfield177;
    }
}

union USB_ENDPOINT_STATUS
{
align (1):
    ushort AsUshort16;
    struct
    {
    align (1):
        ushort _bitfield178;
    }
}

struct USB_COMMON_DESCRIPTOR
{
    ubyte bLength;
    ubyte bDescriptorType;
}

struct USB_DEVICE_DESCRIPTOR
{
align (1):
    ubyte  bLength;
    ubyte  bDescriptorType;
    ushort bcdUSB;
    ubyte  bDeviceClass;
    ubyte  bDeviceSubClass;
    ubyte  bDeviceProtocol;
    ubyte  bMaxPacketSize0;
    ushort idVendor;
    ushort idProduct;
    ushort bcdDevice;
    ubyte  iManufacturer;
    ubyte  iProduct;
    ubyte  iSerialNumber;
    ubyte  bNumConfigurations;
}

struct USB_DEVICE_QUALIFIER_DESCRIPTOR
{
align (1):
    ubyte  bLength;
    ubyte  bDescriptorType;
    ushort bcdUSB;
    ubyte  bDeviceClass;
    ubyte  bDeviceSubClass;
    ubyte  bDeviceProtocol;
    ubyte  bMaxPacketSize0;
    ubyte  bNumConfigurations;
    ubyte  bReserved;
}

struct USB_BOS_DESCRIPTOR
{
align (1):
    ubyte  bLength;
    ubyte  bDescriptorType;
    ushort wTotalLength;
    ubyte  bNumDeviceCaps;
}

struct USB_DEVICE_CAPABILITY_USB20_EXTENSION_DESCRIPTOR
{
    ubyte bLength;
    ubyte bDescriptorType;
    ubyte bDevCapabilityType;
    union bmAttributes
    {
    align (1):
        uint AsUlong;
        struct
        {
        align (1):
            uint _bitfield179;
        }
    }
}

struct USB_DEVICE_CAPABILITY_POWER_DELIVERY_DESCRIPTOR
{
align (1):
    ubyte  bLength;
    ubyte  bDescriptorType;
    ubyte  bDevCapabilityType;
    ubyte  bReserved;
    union bmAttributes
    {
    align (1):
        uint AsUlong;
        struct
        {
        align (1):
            uint _bitfield180;
        }
    }
    ushort bmProviderPorts;
    ushort bmConsumerPorts;
    ushort bcdBCVersion;
    ushort bcdPDVersion;
    ushort bcdUSBTypeCVersion;
}

struct USB_DEVICE_CAPABILITY_PD_CONSUMER_PORT_DESCRIPTOR
{
align (1):
    ubyte  bLength;
    ubyte  bDescriptorType;
    ubyte  bDevCapabilityType;
    ubyte  bReserved;
    union bmCapabilities
    {
    align (1):
        ushort AsUshort;
        struct
        {
        align (1):
            ushort _bitfield181;
        }
    }
    ushort wMinVoltage;
    ushort wMaxVoltage;
    ushort wReserved;
    uint   dwMaxOperatingPower;
    uint   dwMaxPeakPower;
    uint   dwMaxPeakPowerTime;
}

struct USB_DEVICE_CAPABILITY_SUPERSPEED_USB_DESCRIPTOR
{
align (1):
    ubyte  bLength;
    ubyte  bDescriptorType;
    ubyte  bDevCapabilityType;
    ubyte  bmAttributes;
    ushort wSpeedsSupported;
    ubyte  bFunctionalitySupport;
    ubyte  bU1DevExitLat;
    ushort wU2DevExitLat;
}

union USB_DEVICE_CAPABILITY_SUPERSPEEDPLUS_SPEED
{
align (1):
    uint AsUlong32;
    struct
    {
    align (1):
        uint _bitfield182;
    }
}

struct USB_DEVICE_CAPABILITY_SUPERSPEEDPLUS_USB_DESCRIPTOR
{
align (1):
    ubyte  bLength;
    ubyte  bDescriptorType;
    ubyte  bDevCapabilityType;
    ubyte  bReserved;
    union bmAttributes
    {
    align (1):
        uint AsUlong;
        struct
        {
        align (1):
            uint _bitfield183;
        }
    }
    union wFunctionalitySupport
    {
    align (1):
        ushort AsUshort;
        struct
        {
        align (1):
            ushort _bitfield184;
        }
    }
    ushort wReserved;
    USB_DEVICE_CAPABILITY_SUPERSPEEDPLUS_SPEED[1] bmSublinkSpeedAttr;
}

struct USB_DEVICE_CAPABILITY_CONTAINER_ID_DESCRIPTOR
{
    ubyte     bLength;
    ubyte     bDescriptorType;
    ubyte     bDevCapabilityType;
    ubyte     bReserved;
    ubyte[16] ContainerID;
}

struct USB_DEVICE_CAPABILITY_PLATFORM_DESCRIPTOR
{
align (1):
    ubyte    bLength;
    ubyte    bDescriptorType;
    ubyte    bDevCapabilityType;
    ubyte    bReserved;
    GUID     PlatformCapabilityUuid;
    ubyte[1] CapabililityData;
}

struct USB_DEVICE_CAPABILITY_BILLBOARD_DESCRIPTOR
{
align (1):
    ubyte     bLength;
    ubyte     bDescriptorType;
    ubyte     bDevCapabilityType;
    ubyte     iAddtionalInfoURL;
    ubyte     bNumberOfAlternateModes;
    ubyte     bPreferredAlternateMode;
    union VconnPower
    {
    align (1):
        ushort AsUshort;
        struct
        {
        align (1):
            ushort _bitfield185;
        }
    }
    ubyte[32] bmConfigured;
    uint      bReserved;
    struct
    {
    align (1):
        ushort wSVID;
        ubyte  bAlternateMode;
        ubyte  iAlternateModeSetting;
    }
}

struct USB_DEVICE_CAPABILITY_FIRMWARE_STATUS_DESCRIPTOR
{
    ubyte bLength;
    ubyte bDescriptorType;
    ubyte bDevCapabilityType;
    ubyte bcdDescriptorVersion;
    union bmAttributes
    {
    align (1):
        uint AsUlong;
        struct
        {
        align (1):
            uint _bitfield186;
        }
    }
}

struct USB_DEVICE_CAPABILITY_DESCRIPTOR
{
    ubyte bLength;
    ubyte bDescriptorType;
    ubyte bDevCapabilityType;
}

struct USB_CONFIGURATION_DESCRIPTOR
{
align (1):
    ubyte  bLength;
    ubyte  bDescriptorType;
    ushort wTotalLength;
    ubyte  bNumInterfaces;
    ubyte  bConfigurationValue;
    ubyte  iConfiguration;
    ubyte  bmAttributes;
    ubyte  MaxPower;
}

struct USB_INTERFACE_ASSOCIATION_DESCRIPTOR
{
    ubyte bLength;
    ubyte bDescriptorType;
    ubyte bFirstInterface;
    ubyte bInterfaceCount;
    ubyte bFunctionClass;
    ubyte bFunctionSubClass;
    ubyte bFunctionProtocol;
    ubyte iFunction;
}

struct USB_INTERFACE_DESCRIPTOR
{
    ubyte bLength;
    ubyte bDescriptorType;
    ubyte bInterfaceNumber;
    ubyte bAlternateSetting;
    ubyte bNumEndpoints;
    ubyte bInterfaceClass;
    ubyte bInterfaceSubClass;
    ubyte bInterfaceProtocol;
    ubyte iInterface;
}

struct USB_ENDPOINT_DESCRIPTOR
{
align (1):
    ubyte  bLength;
    ubyte  bDescriptorType;
    ubyte  bEndpointAddress;
    ubyte  bmAttributes;
    ushort wMaxPacketSize;
    ubyte  bInterval;
}

union USB_HIGH_SPEED_MAXPACKET
{
align (1):
    ushort us;
}

struct USB_STRING_DESCRIPTOR
{
align (1):
    ubyte     bLength;
    ubyte     bDescriptorType;
    ushort[1] bString;
}

struct USB_SUPERSPEED_ENDPOINT_COMPANION_DESCRIPTOR
{
align (1):
    ubyte  bLength;
    ubyte  bDescriptorType;
    ubyte  bMaxBurst;
    union bmAttributes
    {
        ubyte AsUchar;
        struct Bulk
        {
            ubyte _bitfield187;
        }
        struct Isochronous
        {
            ubyte _bitfield188;
        }
    }
    ushort wBytesPerInterval;
}

struct USB_SUPERSPEEDPLUS_ISOCH_ENDPOINT_COMPANION_DESCRIPTOR
{
align (1):
    ubyte  bLength;
    ubyte  bDescriptorType;
    ushort wReserved;
    uint   dwBytesPerInterval;
}

struct USB_HUB_DESCRIPTOR
{
align (1):
    ubyte     bDescriptorLength;
    ubyte     bDescriptorType;
    ubyte     bNumberOfPorts;
    ushort    wHubCharacteristics;
    ubyte     bPowerOnToPowerGood;
    ubyte     bHubControlCurrent;
    ubyte[64] bRemoveAndPowerMask;
}

struct USB_30_HUB_DESCRIPTOR
{
align (1):
    ubyte  bLength;
    ubyte  bDescriptorType;
    ubyte  bNumberOfPorts;
    ushort wHubCharacteristics;
    ubyte  bPowerOnToPowerGood;
    ubyte  bHubControlCurrent;
    ubyte  bHubHdrDecLat;
    ushort wHubDelay;
    ushort DeviceRemovable;
}

union USB_HUB_STATUS
{
align (1):
    ushort AsUshort16;
    struct
    {
    align (1):
        ushort _bitfield189;
    }
}

union USB_HUB_CHANGE
{
align (1):
    ushort AsUshort16;
    struct
    {
    align (1):
        ushort _bitfield190;
    }
}

union USB_HUB_STATUS_AND_CHANGE
{
align (1):
    uint AsUlong32;
    struct
    {
        USB_HUB_STATUS HubStatus;
        USB_HUB_CHANGE HubChange;
    }
}

union USB_20_PORT_STATUS
{
align (1):
    ushort AsUshort16;
    struct
    {
    align (1):
        ushort _bitfield191;
    }
}

union USB_20_PORT_CHANGE
{
align (1):
    ushort AsUshort16;
    struct
    {
    align (1):
        ushort _bitfield192;
    }
}

union USB_30_PORT_STATUS
{
align (1):
    ushort AsUshort16;
    struct
    {
    align (1):
        ushort _bitfield193;
    }
}

union USB_30_PORT_CHANGE
{
align (1):
    ushort AsUshort16;
    struct
    {
    align (1):
        ushort _bitfield194;
    }
}

union USB_PORT_STATUS
{
align (1):
    ushort             AsUshort16;
    USB_20_PORT_STATUS Usb20PortStatus;
    USB_30_PORT_STATUS Usb30PortStatus;
}

union USB_PORT_CHANGE
{
align (1):
    ushort             AsUshort16;
    USB_20_PORT_CHANGE Usb20PortChange;
    USB_30_PORT_CHANGE Usb30PortChange;
}

union USB_PORT_EXT_STATUS
{
align (1):
    uint AsUlong32;
    struct
    {
    align (1):
        uint _bitfield195;
    }
}

union USB_PORT_STATUS_AND_CHANGE
{
align (1):
    uint AsUlong32;
    struct
    {
        USB_PORT_STATUS PortStatus;
        USB_PORT_CHANGE PortChange;
    }
}

union USB_PORT_EXT_STATUS_AND_CHANGE
{
align (1):
    ulong AsUlong64;
    struct
    {
        USB_PORT_STATUS_AND_CHANGE PortStatusChange;
        USB_PORT_EXT_STATUS PortExtStatus;
    }
}

union USB_HUB_30_PORT_REMOTE_WAKE_MASK
{
    ubyte AsUchar8;
    struct
    {
        ubyte _bitfield196;
    }
}

union USB_FUNCTION_SUSPEND_OPTIONS
{
    ubyte AsUchar;
    struct
    {
        ubyte _bitfield197;
    }
}

struct USB_CONFIGURATION_POWER_DESCRIPTOR
{
align (1):
    ubyte    bLength;
    ubyte    bDescriptorType;
    ubyte[3] SelfPowerConsumedD0;
    ubyte    bPowerSummaryId;
    ubyte    bBusPowerSavingD1;
    ubyte    bSelfPowerSavingD1;
    ubyte    bBusPowerSavingD2;
    ubyte    bSelfPowerSavingD2;
    ubyte    bBusPowerSavingD3;
    ubyte    bSelfPowerSavingD3;
    ushort   TransitionTimeFromD1;
    ushort   TransitionTimeFromD2;
    ushort   TransitionTimeFromD3;
}

struct USB_INTERFACE_POWER_DESCRIPTOR
{
align (1):
    ubyte  bLength;
    ubyte  bDescriptorType;
    ubyte  bmCapabilitiesFlags;
    ubyte  bBusPowerSavingD1;
    ubyte  bSelfPowerSavingD1;
    ubyte  bBusPowerSavingD2;
    ubyte  bSelfPowerSavingD2;
    ubyte  bBusPowerSavingD3;
    ubyte  bSelfPowerSavingD3;
    ushort TransitionTimeFromD1;
    ushort TransitionTimeFromD2;
    ushort TransitionTimeFromD3;
}

struct USBD_VERSION_INFORMATION
{
    uint USBDI_Version;
    uint Supported_USB_Version;
}

struct USBD_DEVICE_INFORMATION
{
    uint  OffsetNext;
    void* UsbdDeviceHandle;
    USB_DEVICE_DESCRIPTOR DeviceDescriptor;
}

struct USBD_PIPE_INFORMATION
{
    ushort         MaximumPacketSize;
    ubyte          EndpointAddress;
    ubyte          Interval;
    USBD_PIPE_TYPE PipeType;
    void*          PipeHandle;
    uint           MaximumTransferSize;
    uint           PipeFlags;
}

struct USBD_ENDPOINT_OFFLOAD_INFORMATION
{
align (1):
    uint          Size;
    ushort        EndpointAddress;
    uint          ResourceId;
    USBD_ENDPOINT_OFFLOAD_MODE Mode;
    uint          _bitfield1;
    uint          _bitfield2;
    LARGE_INTEGER TransferSegmentLA;
    void*         TransferSegmentVA;
    size_t        TransferRingSize;
    uint          TransferRingInitialCycleBit;
    uint          MessageNumber;
    LARGE_INTEGER EventRingSegmentLA;
    void*         EventRingSegmentVA;
    size_t        EventRingSize;
    uint          EventRingInitialCycleBit;
}

struct USBD_INTERFACE_INFORMATION
{
    ushort Length;
    ubyte  InterfaceNumber;
    ubyte  AlternateSetting;
    ubyte  Class;
    ubyte  SubClass;
    ubyte  Protocol;
    ubyte  Reserved;
    void*  InterfaceHandle;
    uint   NumberOfPipes;
    USBD_PIPE_INFORMATION[1] Pipes;
}

struct _URB_HCD_AREA
{
    void[8]* Reserved8;
}

struct _URB_HEADER
{
    ushort Length;
    ushort Function;
    int    Status;
    void*  UsbdDeviceHandle;
    uint   UsbdFlags;
}

struct _URB_SELECT_INTERFACE
{
    _URB_HEADER Hdr;
    void*       ConfigurationHandle;
    USBD_INTERFACE_INFORMATION Interface;
}

struct _URB_SELECT_CONFIGURATION
{
    _URB_HEADER Hdr;
    USB_CONFIGURATION_DESCRIPTOR* ConfigurationDescriptor;
    void*       ConfigurationHandle;
    USBD_INTERFACE_INFORMATION Interface;
}

struct _URB_PIPE_REQUEST
{
    _URB_HEADER Hdr;
    void*       PipeHandle;
    uint        Reserved;
}

struct _URB_FRAME_LENGTH_CONTROL
{
    _URB_HEADER Hdr;
}

struct _URB_GET_FRAME_LENGTH
{
    _URB_HEADER Hdr;
    uint        FrameLength;
    uint        FrameNumber;
}

struct _URB_SET_FRAME_LENGTH
{
    _URB_HEADER Hdr;
    int         FrameLengthDelta;
}

struct _URB_GET_CURRENT_FRAME_NUMBER
{
    _URB_HEADER Hdr;
    uint        FrameNumber;
}

struct _URB_CONTROL_DESCRIPTOR_REQUEST
{
    _URB_HEADER   Hdr;
    void*         Reserved;
    uint          Reserved0;
    uint          TransferBufferLength;
    void*         TransferBuffer;
    void*         TransferBufferMDL;
    URB*          UrbLink;
    _URB_HCD_AREA hca;
    ushort        Reserved1;
    ubyte         Index;
    ubyte         DescriptorType;
    ushort        LanguageId;
    ushort        Reserved2;
}

struct _URB_CONTROL_GET_STATUS_REQUEST
{
    _URB_HEADER   Hdr;
    void*         Reserved;
    uint          Reserved0;
    uint          TransferBufferLength;
    void*         TransferBuffer;
    void*         TransferBufferMDL;
    URB*          UrbLink;
    _URB_HCD_AREA hca;
    ubyte[4]      Reserved1;
    ushort        Index;
    ushort        Reserved2;
}

struct _URB_CONTROL_FEATURE_REQUEST
{
    _URB_HEADER   Hdr;
    void*         Reserved;
    uint          Reserved2;
    uint          Reserved3;
    void*         Reserved4;
    void*         Reserved5;
    URB*          UrbLink;
    _URB_HCD_AREA hca;
    ushort        Reserved0;
    ushort        FeatureSelector;
    ushort        Index;
    ushort        Reserved1;
}

struct _URB_CONTROL_VENDOR_OR_CLASS_REQUEST
{
    _URB_HEADER   Hdr;
    void*         Reserved;
    uint          TransferFlags;
    uint          TransferBufferLength;
    void*         TransferBuffer;
    void*         TransferBufferMDL;
    URB*          UrbLink;
    _URB_HCD_AREA hca;
    ubyte         RequestTypeReservedBits;
    ubyte         Request;
    ushort        Value;
    ushort        Index;
    ushort        Reserved1;
}

struct _URB_CONTROL_GET_INTERFACE_REQUEST
{
    _URB_HEADER   Hdr;
    void*         Reserved;
    uint          Reserved0;
    uint          TransferBufferLength;
    void*         TransferBuffer;
    void*         TransferBufferMDL;
    URB*          UrbLink;
    _URB_HCD_AREA hca;
    ubyte[4]      Reserved1;
    ushort        Interface;
    ushort        Reserved2;
}

struct _URB_CONTROL_GET_CONFIGURATION_REQUEST
{
    _URB_HEADER   Hdr;
    void*         Reserved;
    uint          Reserved0;
    uint          TransferBufferLength;
    void*         TransferBuffer;
    void*         TransferBufferMDL;
    URB*          UrbLink;
    _URB_HCD_AREA hca;
    ubyte[8]      Reserved1;
}

struct OS_STRING
{
    ubyte     bLength;
    ubyte     bDescriptorType;
    ushort[7] MicrosoftString;
    ubyte     bVendorCode;
    union
    {
        ubyte bPad;
        ubyte bFlags;
    }
}

struct _URB_OS_FEATURE_DESCRIPTOR_REQUEST
{
    _URB_HEADER   Hdr;
    void*         Reserved;
    uint          Reserved0;
    uint          TransferBufferLength;
    void*         TransferBuffer;
    void*         TransferBufferMDL;
    URB*          UrbLink;
    _URB_HCD_AREA hca;
    ubyte         _bitfield198;
    ubyte         Reserved2;
    ubyte         InterfaceNumber;
    ubyte         MS_PageIndex;
    ushort        MS_FeatureDescriptorIndex;
    ushort        Reserved3;
}

struct _URB_CONTROL_TRANSFER
{
    _URB_HEADER   Hdr;
    void*         PipeHandle;
    uint          TransferFlags;
    uint          TransferBufferLength;
    void*         TransferBuffer;
    void*         TransferBufferMDL;
    URB*          UrbLink;
    _URB_HCD_AREA hca;
    ubyte[8]      SetupPacket;
}

struct _URB_CONTROL_TRANSFER_EX
{
    _URB_HEADER   Hdr;
    void*         PipeHandle;
    uint          TransferFlags;
    uint          TransferBufferLength;
    void*         TransferBuffer;
    void*         TransferBufferMDL;
    uint          Timeout;
    _URB_HCD_AREA hca;
    ubyte[8]      SetupPacket;
}

struct _URB_BULK_OR_INTERRUPT_TRANSFER
{
    _URB_HEADER   Hdr;
    void*         PipeHandle;
    uint          TransferFlags;
    uint          TransferBufferLength;
    void*         TransferBuffer;
    void*         TransferBufferMDL;
    URB*          UrbLink;
    _URB_HCD_AREA hca;
}

struct USBD_ISO_PACKET_DESCRIPTOR
{
    uint Offset;
    uint Length;
    int  Status;
}

struct _URB_ISOCH_TRANSFER
{
    _URB_HEADER   Hdr;
    void*         PipeHandle;
    uint          TransferFlags;
    uint          TransferBufferLength;
    void*         TransferBuffer;
    void*         TransferBufferMDL;
    URB*          UrbLink;
    _URB_HCD_AREA hca;
    uint          StartFrame;
    uint          NumberOfPackets;
    uint          ErrorCount;
    USBD_ISO_PACKET_DESCRIPTOR[1] IsoPacket;
}

struct USBD_STREAM_INFORMATION
{
    void* PipeHandle;
    uint  StreamID;
    uint  MaximumTransferSize;
    uint  PipeFlags;
}

struct _URB_OPEN_STATIC_STREAMS
{
    _URB_HEADER Hdr;
    void*       PipeHandle;
    uint        NumberOfStreams;
    ushort      StreamInfoVersion;
    ushort      StreamInfoSize;
    USBD_STREAM_INFORMATION* Streams;
}

struct _URB_GET_ISOCH_PIPE_TRANSFER_PATH_DELAYS
{
    _URB_HEADER Hdr;
    void*       PipeHandle;
    uint        MaximumSendPathDelayInMilliSeconds;
    uint        MaximumCompletionPathDelayInMilliSeconds;
}

struct URB
{
    union
    {
        _URB_HEADER         UrbHeader;
        _URB_SELECT_INTERFACE UrbSelectInterface;
        _URB_SELECT_CONFIGURATION UrbSelectConfiguration;
        _URB_PIPE_REQUEST   UrbPipeRequest;
        _URB_FRAME_LENGTH_CONTROL UrbFrameLengthControl;
        _URB_GET_FRAME_LENGTH UrbGetFrameLength;
        _URB_SET_FRAME_LENGTH UrbSetFrameLength;
        _URB_GET_CURRENT_FRAME_NUMBER UrbGetCurrentFrameNumber;
        _URB_CONTROL_TRANSFER UrbControlTransfer;
        _URB_CONTROL_TRANSFER_EX UrbControlTransferEx;
        _URB_BULK_OR_INTERRUPT_TRANSFER UrbBulkOrInterruptTransfer;
        _URB_ISOCH_TRANSFER UrbIsochronousTransfer;
        _URB_CONTROL_DESCRIPTOR_REQUEST UrbControlDescriptorRequest;
        _URB_CONTROL_GET_STATUS_REQUEST UrbControlGetStatusRequest;
        _URB_CONTROL_FEATURE_REQUEST UrbControlFeatureRequest;
        _URB_CONTROL_VENDOR_OR_CLASS_REQUEST UrbControlVendorClassRequest;
        _URB_CONTROL_GET_INTERFACE_REQUEST UrbControlGetInterfaceRequest;
        _URB_CONTROL_GET_CONFIGURATION_REQUEST UrbControlGetConfigurationRequest;
        _URB_OS_FEATURE_DESCRIPTOR_REQUEST UrbOSFeatureDescriptorRequest;
        _URB_OPEN_STATIC_STREAMS UrbOpenStaticStreams;
        _URB_GET_ISOCH_PIPE_TRANSFER_PATH_DELAYS UrbGetIsochPipeTransferPathDelays;
    }
}

struct USB_IDLE_CALLBACK_INFO
{
    USB_IDLE_CALLBACK IdleCallback;
    void*             IdleContext;
}

///The <b>USBUSER_REQUEST_HEADER</b> structure is used with the IOCTL_USB_USER_REQUEST I/O control request to send a
///user-mode request to the USB host controller driver.
struct USBUSER_REQUEST_HEADER
{
align (1):
    ///The user-mode request. For a list and description of possible values for this member, see IOCTL_USB_USER_REQUEST.
    uint                UsbUserRequest;
    ///The status code that is returned by port driver.
    USB_USER_ERROR_CODE UsbUserStatusCode;
    ///The size, in bytes, of the data buffer. The same buffer is used for both input and output.
    uint                RequestBufferLength;
    ///The size, in bytes, of the data that is retrieved by the request.
    uint                ActualBufferLength;
}

struct PACKET_PARAMETERS
{
align (1):
    ubyte    DeviceAddress;
    ubyte    EndpointAddress;
    ushort   MaximumPacketSize;
    uint     Timeout;
    uint     Flags;
    uint     DataLength;
    ushort   HubDeviceAddress;
    ushort   PortTTNumber;
    ubyte    ErrorCount;
    ubyte[3] Pad;
    int      UsbdStatusCode;
    ubyte[4] Data;
}

struct USBUSER_SEND_ONE_PACKET
{
    USBUSER_REQUEST_HEADER Header;
    PACKET_PARAMETERS PacketParameters;
}

struct RAW_RESET_PORT_PARAMETERS
{
align (1):
    ushort PortNumber;
    ushort PortStatus;
}

struct USBUSER_RAW_RESET_ROOT_PORT
{
    USBUSER_REQUEST_HEADER Header;
    RAW_RESET_PORT_PARAMETERS Parameters;
}

struct RAW_ROOTPORT_FEATURE
{
align (1):
    ushort PortNumber;
    ushort PortFeature;
    ushort PortStatus;
}

struct USBUSER_ROOTPORT_FEATURE_REQUEST
{
    USBUSER_REQUEST_HEADER Header;
    RAW_ROOTPORT_FEATURE Parameters;
}

struct RAW_ROOTPORT_PARAMETERS
{
align (1):
    ushort PortNumber;
    ushort PortStatus;
}

struct USBUSER_ROOTPORT_PARAMETERS
{
    USBUSER_REQUEST_HEADER Header;
    RAW_ROOTPORT_PARAMETERS Parameters;
}

///The <b>USB_CONTROLLER_INFO_0</b> structure is used with the IOCTL_USB_USER_REQUEST I/O control request to retrieve
///information about the USB host controller.
struct USB_CONTROLLER_INFO_0
{
align (1):
    ///The vendor identifier that is associated with the host controller device.
    uint PciVendorId;
    ///The device identifier that is associated with the host controller.
    uint PciDeviceId;
    ///The revision number of the host controller device.
    uint PciRevision;
    ///The number of root hub ports that the host controller has. <div class="alert"><b>Note</b> In Windows 8, the USB
    ///3.0 driver stack does not include the number of SuperSpeed hubs in the reported <b>NumberOfRootPorts</b>
    ///value.</div> <div> </div>
    uint NumberOfRootPorts;
    ///A USB_CONTROLLER_FLAVOR-typed enumerator that specifies the type of controller.
    USB_CONTROLLER_FLAVOR ControllerFlavor;
    ///A bitwise OR of some combination of the following host controller feature flags. <table> <tr> <th>Host controller
    ///feature</th> <th>Meaning</th> </tr> <tr> <td> USB_HC_FEATURE_FLAG_PORT_POWER_SWITCHING </td> <td> Power switching
    ///is enabled on the host controller. This flag allows powering of hot-plug devices. </td> </tr> <tr> <td>
    ///USB_HC_FEATURE_FLAG_SEL_SUSPEND </td> <td> Selective suspend is enabled on the host controller. </td> </tr> <tr>
    ///<td> USB_HC_FEATURE_LEGACY_BIOS </td> <td> The host controller has a legacy BIOS. </td> </tr> </table> <div
    ///class="alert"><b>Note</b> In Windows 8, the underlying USB 3.0 driver stack does not set any host controller
    ///feature flags in <b>HcFeatureFlags.</b></div> <div> </div>
    uint HcFeatureFlags;
}

struct USBUSER_CONTROLLER_INFO_0
{
    USBUSER_REQUEST_HEADER Header;
    USB_CONTROLLER_INFO_0 Info0;
}

///The <b>USB_UNICODE_NAME</b> structure contains a Unicode string that specifies a symbolic link name.
struct USB_UNICODE_NAME
{
align (1):
    ///The length, in bytes, of the string.
    uint      Length;
    ///A pointer to the string.
    ushort[1] String;
}

///The <b>USBUSER_CONTROLLER_UNICODE_NAME</b> structure is used in conjunction with the IOCTL_USB_USER_REQUEST I/O
///control request to retrieve the USB host controller driverkey name.
struct USBUSER_CONTROLLER_UNICODE_NAME
{
    ///Contains a structure of type USBUSER_REQUEST_HEADER that specifies the user-mode request on input to
    ///IOCTL_USB_USER_REQUEST, and provides buffer and status information on output.
    USBUSER_REQUEST_HEADER Header;
    ///Contains a Unicode string of type USB_UNICODE_NAME that reports the host controller's driverkey name.
    USB_UNICODE_NAME UnicodeName;
}

///The <b>USB_PASS_THRU_PARAMETERS</b> structure is used with the IOCTL_USB_USER_REQUEST I/O control request to pass a
///vendor-specific command to the host controller miniport driver.
struct USB_PASS_THRU_PARAMETERS
{
align (1):
    ///A GUID that identifies the operation for the host controller miniport driver.
    GUID     FunctionGUID;
    ///The size, in bytes, of the USB_PASS_THRU_PARAMETERS structure.
    uint     ParameterLength;
    ///A variable length array with the parameter data for the command.
    ubyte[4] Parameters;
}

///The <b>USBUSER_PASS_THRU_REQUEST</b> structure is used in conjunction with the IOCTL_USB_USER_REQUEST I/O control
///request to send a vendor-specific command to the host controller miniport driver.
struct USBUSER_PASS_THRU_REQUEST
{
    ///Contains a structure of type USBUSER_REQUEST_HEADER that specifies the user-mode request on input to
    ///IOCTL_USB_USER_REQUEST, and provides buffer and status information on output.
    USBUSER_REQUEST_HEADER Header;
    ///Contains a structure of type USB_PASS_THRU_PARAMETERS that specifies the parameters associated with this request.
    USB_PASS_THRU_PARAMETERS PassThru;
}

///The <b>USB_POWER_INFO</b> structure is used with the IOCTL_USB_USER_REQUEST I/O control request to retrieve device
///power state that the host controller power policy specifies for the indicated system power state.
struct USB_POWER_INFO
{
align (1):
    ///On input, a WDMUSB_POWER_STATE-type enumerator value that specifies the system power state.
    WDMUSB_POWER_STATE SystemState;
    ///On output, an WDMUSB_POWER_STATE-type enumerator value that specifies the device power state of the host
    ///controller.
    WDMUSB_POWER_STATE HcDevicePowerState;
    ///On output, a WDMUSB_POWER_STATE-type enumerator value that specifies whether the host controller is in a wake
    ///state.
    WDMUSB_POWER_STATE HcDeviceWake;
    ///On output, a WDMUSB_POWER_STATE-type enumerator value that specifies whether the host controller can wake the
    ///system.
    WDMUSB_POWER_STATE HcSystemWake;
    ///On output, a WDMUSB_POWER_STATE-type enumerator value that specifies the device power state of the root hub.
    WDMUSB_POWER_STATE RhDevicePowerState;
    ///On output, a WDMUSB_POWER_STATE-type enumerator value that specifies whether the root hub is in a wake state.
    WDMUSB_POWER_STATE RhDeviceWake;
    ///On output, a WDMUSB_POWER_STATE-type enumerator value that specifies whether the root hub can wake the system.
    WDMUSB_POWER_STATE RhSystemWake;
    ///On output, a WDMUSB_POWER_STATE-type enumerator value that specifies the last system sleep state.
    WDMUSB_POWER_STATE LastSystemSleepState;
    ///A Boolean value that indicates whether the host controller device can wake up the system from the specified
    ///system power state. If <b>TRUE</b>, the host controller device can wake up the system. If <b>FALSE</b>, the host
    ///controller cannot wake up the system.
    ubyte              CanWakeup;
    ///A Boolean value that indicates whether the host controller is powered when in the specified system power state.
    ///If <b>TRUE</b>, the host controller is powered. If <b>FALSE</b>, the host controller is not powered.
    ubyte              IsPowered;
}

///The <b>USBUSER_POWER_INFO_REQUEST</b> structure is used in conjunction with the IOCTL_USB_USER_REQUEST I/O control
///request to retrieve power policy information concerning the relationship of a specific system state to the power
///state of the host controller and the root hub.
struct USBUSER_POWER_INFO_REQUEST
{
    ///Contains a structure of type USBUSER_REQUEST_HEADER that specifies the user-mode request on input to
    ///IOCTL_USB_USER_REQUEST, and provides buffer and status information on output.
    USBUSER_REQUEST_HEADER Header;
    ///Contains a structure of type USB_POWER_INFO that specifies the parameters associated with this request.
    USB_POWER_INFO PowerInformation;
}

struct USB_OPEN_RAW_DEVICE_PARAMETERS
{
align (1):
    ushort PortStatus;
    ushort MaxPacketEp0;
}

struct USBUSER_OPEN_RAW_DEVICE
{
    USBUSER_REQUEST_HEADER Header;
    USB_OPEN_RAW_DEVICE_PARAMETERS Parameters;
}

///This structure is not supported. The <b>USB_CLOSE_RAW_DEVICE_PARAMETERS</b> structure is used with the
///IOCTL_USB_USER_REQUEST I/O control request to close raw access to devices on the bus.
struct USB_CLOSE_RAW_DEVICE_PARAMETERS
{
align (1):
    ///Reserved.
    uint xxx;
}

struct USBUSER_CLOSE_RAW_DEVICE
{
    USBUSER_REQUEST_HEADER Header;
    USB_CLOSE_RAW_DEVICE_PARAMETERS Parameters;
}

struct USB_SEND_RAW_COMMAND_PARAMETERS
{
align (1):
    ubyte    Usb_bmRequest;
    ubyte    Usb_bRequest;
    ushort   Usb_wVlaue;
    ushort   Usb_wIndex;
    ushort   Usb_wLength;
    ushort   DeviceAddress;
    ushort   MaximumPacketSize;
    uint     Timeout;
    uint     DataLength;
    int      UsbdStatusCode;
    ubyte[4] Data;
}

struct USBUSER_SEND_RAW_COMMAND
{
    USBUSER_REQUEST_HEADER Header;
    USB_SEND_RAW_COMMAND_PARAMETERS Parameters;
}

///The <b>USB_BANDWIDTH_INFO</b> structure is used with the IOCTL_USB_USER_REQUEST I/O control request to retrieve
///information about the allocated bandwidth.
struct USB_BANDWIDTH_INFO
{
align (1):
    ///The number of devices on the bus.
    uint DeviceCount;
    ///The amount of allocated bandwidth, in bits per millisecond.
    uint TotalBusBandwidth;
    ///The amount of allocated bandwidth bits in each 32-millisecond time slice.
    uint Total32secBandwidth;
    ///The amount of bandwidth, in bits per 32-millisecond, that is allocated for bulk and control transfers.
    uint AllocedBulkAndControl;
    ///The amount of bandwidth, in bits per 32-millisecond, that is allocated for isochronous transfers.
    uint AllocedIso;
    ///The amount of bandwidth, in bits per 32-millisecond, that is allocated for interrupt transactions when the period
    ///is 1 millisecond.
    uint AllocedInterrupt_1ms;
    ///The amount of bandwidth, in bits per 32-millisecond, that is allocated for interrupt transactions when the period
    ///is 2 milliseconds.
    uint AllocedInterrupt_2ms;
    ///The amount of bandwidth, in bits per 32-millisecond, that is allocated for interrupt transactions when the period
    ///is 4 milliseconds.
    uint AllocedInterrupt_4ms;
    ///The amount of bandwidth, in bits per 32-millisecond, that is allocated for interrupt transactions when the period
    ///is 8 milliseconds.
    uint AllocedInterrupt_8ms;
    ///The amount of bandwidth, in bits per 32-millisecond, that is allocated for interrupt transactions when the period
    ///is 16 milliseconds.
    uint AllocedInterrupt_16ms;
    ///The amount of bandwidth, in bits per 32-millisecond, that is allocated for interrupt transactions when the period
    ///is 32 milliseconds.
    uint AllocedInterrupt_32ms;
}

///The <b>USBUSER_BANDWIDTH_INFO_REQUEST</b> structure is used with the IOCTL_USB_USER_REQUEST I/O control request to
///retrieve information about the allocated bandwidth.
struct USBUSER_BANDWIDTH_INFO_REQUEST
{
    ///A USBUSER_REQUEST_HEADER structure that specifies the user-mode request on input to IOCTL_USB_USER_REQUEST and
    ///provides buffer and status information on output.
    USBUSER_REQUEST_HEADER Header;
    ///A USB_BANDWIDTH_INFO structure that reports bandwidth allocation information.
    USB_BANDWIDTH_INFO BandwidthInformation;
}

///The <b>USB_BUS_STATISTICS_0</b> structure is used with the IOCTL_USB_USER_REQUEST I/O control request to retrieve bus
///statistics.
struct USB_BUS_STATISTICS_0
{
align (1):
    ///The number of devices on the bus.
    uint          DeviceCount;
    ///The current system time.
    LARGE_INTEGER CurrentSystemTime;
    ///The number of the current USB frame.
    uint          CurrentUsbFrame;
    ///The amount, in bytes, of bulk transfer data.
    uint          BulkBytes;
    ///The amount, in bytes, of isochronous data.
    uint          IsoBytes;
    ///The amount, in bytes, of interrupt data.
    uint          InterruptBytes;
    ///The amount, in bytes, of control data.
    uint          ControlDataBytes;
    ///The amount, in bytes, of interrupt data.
    uint          PciInterruptCount;
    ///The number of hard bus resets that have occurred.
    uint          HardResetCount;
    ///The number of times that a worker thread has signaled completion of a task.
    uint          WorkerSignalCount;
    ///The number of bytes that are transferred by common buffer.
    uint          CommonBufferBytes;
    ///The amount of time, in milliseconds, that worker threads have been idle.
    uint          WorkerIdleTimeMs;
    ///A Boolean value that indicates whether the root hub is enabled. If <b>TRUE</b>, he root hub is enabled. If
    ///<b>FALSE</b>, the root hub is disabled.
    ubyte         RootHubEnabled;
    ///The power state of the root hub devices. This member can have any of the following values: <table> <tr>
    ///<th>Value</th> <th>Meaning</th> </tr> <tr> <td> 0 </td> <td> D0 power state </td> </tr> <tr> <td> 1 </td> <td> D1
    ///power state </td> </tr> <tr> <td> 2 </td> <td> D2 power state </td> </tr> <tr> <td> 3 </td> <td> D3 power state
    ///</td> </tr> </table>
    ubyte         RootHubDevicePowerState;
    ///If this member is 1, the bus is active. If 0, the bus is inactive.
    ubyte         Unused;
    ///The index that is used to generate a symbolic link name for the hub PDO. This format of the symbolic link is
    ///USBPDO-<i>n</i>, where <i>n</i> is the value in <b>NameIndex</b>.
    ubyte         NameIndex;
}

///The <b>USBUSER_BUS_STATISTICS_0_REQUEST</b> structure is used with the IOCTL_USB_USER_REQUEST I/O control request to
///retrieve bus statistics.
struct USBUSER_BUS_STATISTICS_0_REQUEST
{
    ///A USBUSER_REQUEST_HEADER structure that specifies the user-mode request on input to IOCTL_USB_USER_REQUEST and
    ///provides buffer and status information on output.
    USBUSER_REQUEST_HEADER Header;
    ///A USB_BUS_STATISTICS_0 structure that reports bus statistics.
    USB_BUS_STATISTICS_0 BusStatistics0;
}

///The <b>USB_DRIVER_VERSION_PARAMETERS</b> structure is used with the IOCTL_USB_USER_REQUEST I/O control request to
///retrieve version information.
struct USB_DRIVER_VERSION_PARAMETERS
{
align (1):
    ///A tracking code that identifies the revision of the USB stack.
    uint   DriverTrackingCode;
    ///The version of the USB driver interface that the USB stack supports.
    uint   USBDI_Version;
    ///The version of the USB user interface that the USB stack supports.
    uint   USBUSER_Version;
    ///A Boolean value that indicates whether the checked version of the host controller driver is loaded. If
    ///<b>TRUE</b>, the checked version of the host controller driver is loaded. If <b>FALSE</b>, the checked version is
    ///not loaded.
    ubyte  CheckedPortDriver;
    ///A Boolean value that indicates whether the checked version of the host controller miniport driver is loaded. If
    ///<b>TRUE</b>, the checked version of the host controller miniport driver is loaded. If <b>FALSE</b>, the checked
    ///version is not loaded.
    ubyte  CheckedMiniportDriver;
    ///The USB version that the USB stack supports. A value of 0x0110 indicates that the USB stack supports version 1.1.
    ///A value of 0x0200 indicates the USB stack supports version 2.0.
    ushort USB_Version;
}

///The <b>USBUSER_GET_DRIVER_VERSION</b> structure is used with the IOCTL_USB_USER_REQUEST I/O control request to read
///driver and interface version information.
struct USBUSER_GET_DRIVER_VERSION
{
    ///A USBUSER_REQUEST_HEADER structure that specifies the user-mode request on input to IOCTL_USB_USER_REQUEST and
    ///provides buffer and status information on output.
    USBUSER_REQUEST_HEADER Header;
    ///A USB_DRIVER_VERSION_PARAMETERS structure that specifies the parameters that are associated with this request.
    USB_DRIVER_VERSION_PARAMETERS Parameters;
}

struct USB_USB2HW_VERSION_PARAMETERS
{
    ubyte Usb2HwRevision;
}

struct USBUSER_GET_USB2HW_VERSION
{
    USBUSER_REQUEST_HEADER Header;
    USB_USB2HW_VERSION_PARAMETERS Parameters;
}

struct USBUSER_REFRESH_HCT_REG
{
align (1):
    USBUSER_REQUEST_HEADER Header;
    uint Flags;
}

///The <b>WINUSB_PIPE_INFORMATION</b> structure contains pipe information that the WinUsb_QueryPipe routine retrieves.
struct WINUSB_PIPE_INFORMATION
{
    ///A USBD_PIPE_TYPE-type enumeration value that specifies the pipe type.
    USBD_PIPE_TYPE PipeType;
    ///The pipe identifier (ID).
    ubyte          PipeId;
    ///The maximum size, in bytes, of the packets that are transmitted on the pipe.
    ushort         MaximumPacketSize;
    ///The pipe interval.
    ubyte          Interval;
}

///The <b>WINUSB_PIPE_INFORMATION_EX</b> structure contains pipe information that the WinUsb_QueryPipeEx routine
///retrieves.
struct WINUSB_PIPE_INFORMATION_EX
{
    ///A USBD_PIPE_TYPE-type enumeration value that specifies the pipe type.
    USBD_PIPE_TYPE PipeType;
    ///The pipe identifier (ID).
    ubyte          PipeId;
    ///The maximum size, in bytes, of the packets that are transmitted on the pipe.
    ushort         MaximumPacketSize;
    ///The pipe interval.
    ubyte          Interval;
    ///The maximum number of bytes that can be transmitted in single interval. This value may be a larger than the
    ///<b>MaximumPacketSize</b> value on high-bandwidth, high-speed periodic endpoints and SuperSpeed periodic
    ///endpoints, such as isochronous endpoints.
    uint           MaximumBytesPerInterval;
}

///The <b>WINUSB_SETUP_PACKE</b>T structure describes a USB setup packet.
struct WINUSB_SETUP_PACKET
{
align (1):
    ///The request type. The values that are assigned to this member are defined in Table 9.2 of section 9.3 of the
    ///Universal Serial Bus (USB) specification (www.usb.org).
    ubyte  RequestType;
    ///The device request. The values that are assigned to this member are defined in Table 9.3 of section 9.4 of the
    ///Universal Serial Bus (USB) specification.
    ubyte  Request;
    ///The meaning of this member varies according to the request. For an explanation of this member, see the Universal
    ///Serial Bus (USB) specification.
    ushort Value;
    ///The meaning of this member varies according to the request. For an explanation of this member, see the Universal
    ///Serial Bus (USB) specification.
    ushort Index;
    ///The number of bytes to transfer.
    ushort Length;
}

struct USB_START_TRACKING_FOR_TIME_SYNC_INFORMATION
{
align (1):
    HANDLE TimeTrackingHandle;
    ubyte  IsStartupDelayTolerable;
}

struct USB_STOP_TRACKING_FOR_TIME_SYNC_INFORMATION
{
align (1):
    HANDLE TimeTrackingHandle;
}

struct USB_FRAME_NUMBER_AND_QPC_FOR_TIME_SYNC_INFORMATION
{
align (1):
    HANDLE        TimeTrackingHandle;
    uint          InputFrameNumber;
    uint          InputMicroFrameNumber;
    LARGE_INTEGER QueryPerformanceCounterAtInputFrameOrMicroFrame;
    LARGE_INTEGER QueryPerformanceCounterFrequency;
    uint          PredictedAccuracyInMicroSeconds;
    uint          CurrentGenerationID;
    LARGE_INTEGER CurrentQueryPerformanceCounter;
    uint          CurrentHardwareFrameNumber;
    uint          CurrentHardwareMicroFrameNumber;
    uint          CurrentUSBFrameNumber;
}

// Functions

///The <b>WinUsb_Initialize</b> function creates a WinUSB handle for the device specified by a file handle.
///Params:
///    DeviceHandle = The handle to the device that <b>CreateFile</b> returned. WinUSB uses overlapped I/O, so FILE_FLAG_OVERLAPPED
///                   must be specified in the <i>dwFlagsAndAttributes</i> parameter of <b>CreateFile</b> call for <i>DeviceHandle</i>
///                   to have the characteristics necessary for <b>WinUsb_Initialize</b> to function properly.
///    InterfaceHandle = Receives an opaque handle to the first (default) interface on the device. This handle is required by other WinUSB
///                      routines that perform operations on the default interface. To release the handle, call the WinUSB_Free function.
///Returns:
///    <b>WinUsb_Initialize</b> returns <b>TRUE</b> if the operation succeeds. Otherwise, this routine returns
///    <b>FALSE</b>, and the caller can retrieve the logged error by calling <b>GetLastError</b>. <b>GetLastError</b>
///    can return the following error code. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_INVALID_HANDLE</b></dt> </dl> </td> <td width="60%"> The caller passed <b>NULL</b>
///    or an invalid handle in the <i>DeviceHandle</i> parameter; FILE_FLAG_OVERLAPPED was not set in the file handle.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NOT_ENOUGH_MEMORY</b></dt> </dl> </td> <td width="60%">
///    Indicates that there is insufficient memory to perform the operation. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_BAD_DEVICE</b></dt> </dl> </td> <td width="60%"> Indicates that the default interface descriptor
///    could not be found for the device. </td> </tr> </table>
///    
@DllImport("WINUSB")
BOOL WinUsb_Initialize(HANDLE DeviceHandle, void** InterfaceHandle);

///The <b>WinUsb_Free</b> function releases all of the resources that WinUsb_Initialize allocated. This is a synchronous
///operation.
///Params:
///    InterfaceHandle = An opaque handle to an interface in the selected configuration. That handle must be created by a previous call to
///                      WinUsb_Initialize or WinUsb_GetAssociatedInterface.
///Returns:
///    <b>WinUsb_Free</b> returns <b>TRUE</b>.
///    
@DllImport("WINUSB")
BOOL WinUsb_Free(void* InterfaceHandle);

///The <b>WinUsb_GetAssociatedInterface</b> function retrieves a handle for an associated interface. This is a
///synchronous operation.
///Params:
///    InterfaceHandle = An opaque handle to the first (default) interface on the device, which is returned by WinUsb_Initialize.
///    AssociatedInterfaceIndex = An index that specifies the associated interface to retrieve. A value of 0 indicates the first associated
///                               interface, a value of 1 indicates the second associated interface, and so on.
///    AssociatedInterfaceHandle = A handle for the associated interface. Callers must pass this interface handle to WinUSB Functions exposed by
///                                Winusb.dll. To close this handle, call WinUsb_Free.
///Returns:
///    <b>WinUsb_GetAssociatedInterface</b> returns <b>TRUE</b> if the operation succeeds. Otherwise, this routine
///    returns <b>FALSE</b>, and the caller can retrieve the logged error by calling <b>GetLastError</b>. <table> <tr>
///    <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_ALREADY_EXISTS</b></dt>
///    </dl> </td> <td width="60%"> WinUsb_GetAssociatedInterface has already returned a handle for the interface that
///    <i>AssociatedInterfaceIndex</i> specifies. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_HANDLE</b></dt> </dl> </td> <td width="60%"> The caller passed <b>NULL</b> in the
///    <i>InterfaceHandle</i> parameter. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt>
///    </dl> </td> <td width="60%"> The passed <i>AssociatedInterfaceIndex</i> value failed an integer overflow check.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NO_MORE_ITEMS</b></dt> </dl> </td> <td width="60%"> An
///    interface does not exist for the specified <i>AssociatedInterfaceIndex</i> value<i>.</i> </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_NOT_ENOUGH_MEMORY</b></dt> </dl> </td> <td width="60%"> Indicates that there is
///    insufficient memory to perform the operation. </td> </tr> </table>
///    
@DllImport("WINUSB")
BOOL WinUsb_GetAssociatedInterface(void* InterfaceHandle, ubyte AssociatedInterfaceIndex, 
                                   void** AssociatedInterfaceHandle);

///The <b>WinUsb_GetDescriptor</b> function returns the requested descriptor. This is a synchronous operation.
///Params:
///    InterfaceHandle = An opaque handle to an interface in the selected configuration. To retrieve the device or configuration
///                      descriptor, use the handle returned by WinUsb_Initialize. To retrieve the interface descriptor of the first
///                      interface, use the handle returned by WinUsb_Initialize. To retrieve the endpoint descriptor of an endpoint in
///                      the first interface, use the handle returned by WinUsb_Initialize. To retrieve descriptors of all other
///                      interfaces and their related endpoints, use the handle to the target interface, retrieved by
///                      WinUsb_GetAssociatedInterface.
///    DescriptorType = A value that specifies the type of descriptor to return. This parameter corresponds to the <b>bDescriptorType</b>
///                     field of a standard device descriptor, whose values are described in the <i>Universal Serial Bus
///                     </i>specification. Some of these values are listed in the description of the <b>DescriptorType</b> member of the
///                     _URB_CONTROL_DESCRIPTOR_REQUEST structure.
///    Index = The descriptor index. For an explanation of the descriptor index, see the <i>Universal Serial Bus</i>
///            specification (www.usb.org).
///    LanguageID = A value that specifies the language identifier, if the requested descriptor is a string descriptor.
///    Buffer = A caller-allocated buffer that receives the requested descriptor.
///    BufferLength = The length, in bytes, of <i>Buffer</i>.
///    LengthTransferred = The number of bytes that were copied into <i>Buffer</i>.
///Returns:
///    <b>WinUsb_GetDescriptor</b> returns <b>TRUE</b> if the operation succeeds. Otherwise, this routine returns
///    <b>FALSE</b>, and the caller can retrieve the logged error by calling <b>GetLastError</b>. <b>GetLastError</b>
///    can return the following error code. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_INVALID_HANDLE</b></dt> </dl> </td> <td width="60%"> The caller passed <b>NULL</b>
///    in the <i>InterfaceHandle</i> parameter. </td> </tr> </table>
///    
@DllImport("WINUSB")
BOOL WinUsb_GetDescriptor(void* InterfaceHandle, ubyte DescriptorType, ubyte Index, ushort LanguageID, 
                          char* Buffer, uint BufferLength, uint* LengthTransferred);

///The <b>WinUsb_QueryInterfaceSettings</b> function retrieves the interface descriptor for the specified alternate
///interface settings for a particular interface handle.
///Params:
///    InterfaceHandle = An opaque handle to an interface in the selected configuration. To retrieve the settings of the first interface,
///                      use the handle returned by WinUsb_Initialize. For all other interfaces, use the handle to the target interface,
///                      retrieved by WinUsb_GetAssociatedInterface.
///    AlternateInterfaceNumber = A value that indicates which alternate settings to return. A value of 0 indicates the first alternate setting, a
///                               value of 1 indicates the second alternate setting, and so on.
///    UsbAltInterfaceDescriptor = A pointer to a caller-allocated USB_INTERFACE_DESCRIPTOR structure that contains information about the interface
///                                that <i>AlternateSettingNumber</i> specified.
///Returns:
///    <b>WinUsb_QueryInterfaceSettings</b> returns <b>TRUE</b> if the operation succeeds. Otherwise, it returns
///    <b>FALSE</b>, and the caller can retrieve the logged error by calling <b>GetLastError</b>. <b>GetLastError</b>
///    can return the following error code. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_INVALID_HANDLE</b></dt> </dl> </td> <td width="60%"> The caller passed <b>NULL</b>
///    in the <i>InterfaceHandle</i> parameter. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_NO_MORE_ITEMS</b></dt> </dl> </td> <td width="60%"> The specified alternate interface was not found.
///    </td> </tr> </table>
///    
@DllImport("WINUSB")
BOOL WinUsb_QueryInterfaceSettings(void* InterfaceHandle, ubyte AlternateInterfaceNumber, 
                                   USB_INTERFACE_DESCRIPTOR* UsbAltInterfaceDescriptor);

///The <b>WinUsb_QueryDeviceInformation</b> function gets information about the physical device that is associated with
///a WinUSB interface handle.
///Params:
///    InterfaceHandle = An opaque handle to the first interface on the device, which is returned by WinUsb_Initialize.
///    InformationType = A value that specifies which interface information value to retrieve. On input, <i>InformationType</i> must have
///                      the following value: DEVICE_SPEED (0x01).
///    BufferLength = The maximum number of bytes to read. This number must be less than or equal to the size, in bytes, of
///                   <i>Buffer</i>. On output, <i>BufferLength</i> is set to the actual number of bytes that were copied into
///                   <i>Buffer</i>.
///    Buffer = A caller-allocated buffer that receives the requested value. If <i>InformationType</i> is DEVICE_SPEED, on
///             successful return, <i>Buffer</i> indicates the operating speed of the device. 0x03 indicates high-speed or
///             higher; 0x01 indicates full-speed or lower.
///Returns:
///    <b>WinUsb_QueryDeviceInformation</b> returns <b>TRUE</b> if the operation succeeds. Otherwise, this routine
///    returns <b>FALSE</b>, and the caller can retrieve the logged error by calling <b>GetLastError</b>.
///    <b>GetLastError</b> can return the following error code. <table> <tr> <th>Return code</th> <th>Description</th>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_HANDLE</b></dt> </dl> </td> <td width="60%"> The caller
///    passed <b>NULL</b> in the <i>InterfaceHandle</i> parameter. </td> </tr> </table>
///    
@DllImport("WINUSB")
BOOL WinUsb_QueryDeviceInformation(void* InterfaceHandle, uint InformationType, uint* BufferLength, char* Buffer);

///The <b>WinUsb_SetCurrentAlternateSetting</b> function sets the alternate setting of an interface.
///Params:
///    InterfaceHandle = An opaque handle to an interface, which defines the alternate setting to set. To set an alternate setting in the
///                      first interface on the device, use the interface handle returned by WinUsb_Initialize. For all other interfaces,
///                      use the handle to the target interface, retrieved by WinUsb_GetAssociatedInterface.
///    SettingNumber = The value that is contained in the <b>bAlternateSetting</b> member of the USB_INTERFACE_DESCRIPTOR structure.
///                    This structure is populated by the WinUsb_QueryInterfaceSettings routine.
///Returns:
///    <b>WinUsb_SetCurrentAlternateSetting</b> returns <b>TRUE</b> if the operation succeeds. Otherwise, this function
///    returns <b>FALSE</b>, and the caller can retrieve the logged error by calling <b>GetLastError</b>.
///    <b>GetLastError</b> can return the following error code. <table> <tr> <th>Return code</th> <th>Description</th>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_HANDLE</b></dt> </dl> </td> <td width="60%"> The caller
///    passed <b>NULL</b> in the <i>InterfaceHandle</i> parameter. </td> </tr> </table>
///    
@DllImport("WINUSB")
BOOL WinUsb_SetCurrentAlternateSetting(void* InterfaceHandle, ubyte SettingNumber);

///The <b>WinUsb_GetCurrentAlternateSetting</b> function gets the current alternate interface setting for an interface.
///This is a synchronous operation.
///Params:
///    InterfaceHandle = An opaque handle to an interface in the selected configuration. To get the current alternate setting in the first
///                      (default) interface on the device, use the interface handle returned by WinUsb_Initialize. For all other
///                      interfaces, use the handle to the target interface, retrieved by WinUsb_GetAssociatedInterface.
///    SettingNumber = A pointer to an unsigned character that receives an integer that indicates the current alternate setting.
///Returns:
///    <b>WinUsb_GetCurrentAlternateSetting</b> returns <b>TRUE</b> if the operation succeeds. Otherwise, this routine
///    returns <b>FALSE</b>, and the caller can retrieve the logged error by calling <b>GetLastError</b>.
///    <b>GetLastError</b> can return the following error code. <table> <tr> <th>Return code</th> <th>Description</th>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_HANDLE</b></dt> </dl> </td> <td width="60%"> The caller
///    passed <b>NULL</b> in the <i>InterfaceHandle</i> parameter. </td> </tr> </table>
///    
@DllImport("WINUSB")
BOOL WinUsb_GetCurrentAlternateSetting(void* InterfaceHandle, ubyte* SettingNumber);

///The <b>WinUsb_QueryPipe</b> function retrieves information about the specified endpoint and the associated pipe for
///an interface.
///Params:
///    InterfaceHandle = An opaque handle to an interface that contains the endpoint with which the pipe is associated. To query the pipe
///                      associated with an endpoint in the first interface, use the handle returned by WinUsb_Initialize. For all other
///                      interfaces, use the handle to the target interface, retrieved by WinUsb_GetAssociatedInterface.
///    AlternateInterfaceNumber = A value that specifies the alternate interface to return the information for.
///    PipeIndex = A value that specifies the pipe to return information about. This value is not the same as the
///                <b>bEndpointAddress</b> field in the endpoint descriptor. A <i>PipeIndex </i>value of 0 signifies the first
///                endpoint that is associated with the interface, a value of 1 signifies the second endpoint, and so on.
///                <i>PipeIndex</i> must be less than the value in the <b>bNumEndpoints</b> field of the interface descriptor.
///    PipeInformation = A pointer, on output, to a caller-allocated WINUSB_PIPE_INFORMATION structure that contains pipe information.
///Returns:
///    <b>WinUsb_QueryPipe</b> returns <b>TRUE</b> if the operation succeeds. Otherwise, this function returns
///    <b>FALSE</b>, and the caller can retrieve the logged error by calling <b>GetLastError</b>. <b>GetLastError</b>
///    can return the following error code. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_INVALID_HANDLE</b></dt> </dl> </td> <td width="60%"> The caller passed <b>NULL</b>
///    in the <i>InterfaceHandle</i> parameter. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER
///    </b></dt> </dl> </td> <td width="60%"> The caller passed <b>NULL</b> in the <i>PipeInformation </i> parameter;
///    interface descriptor could not be found for the handle specified in <i>InterfaceHandle</i>. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_NO_MORE_ITEMS</b></dt> </dl> </td> <td width="60%"> The value passed in the
///    <i>PipeIndex</i> parameter is greater than the <b>bNumEndpoints</b> value of the interface descriptor; endpoint
///    descriptor could not be found for the specified interface. </td> </tr> </table>
///    
@DllImport("WINUSB")
BOOL WinUsb_QueryPipe(void* InterfaceHandle, ubyte AlternateInterfaceNumber, ubyte PipeIndex, 
                      WINUSB_PIPE_INFORMATION* PipeInformation);

///The <b>WinUsb_QueryPipeEx</b> function retrieves extended information about the specified endpoint and the associated
///pipe for an interface.
///Params:
///    InterfaceHandle = An opaque handle to an interface that contains the endpoint with which the pipe is associated. To query the pipe
///                      associated with an endpoint in the first interface, use the handle returned by WinUsb_Initialize. For all other
///                      interfaces, use the handle to the target interface, retrieved by WinUsb_GetAssociatedInterface.
///    AlternateSettingNumber = A value that specifies the alternate interface to return the information for.
///    PipeIndex = A value that specifies the pipe to return information about. This value is not the same as the
///                <b>bEndpointAddress</b> field in the endpoint descriptor. A <i>PipeIndex </i>value of 0 signifies the first
///                endpoint that is associated with the interface, a value of 1 signifies the second endpoint, and so on.
///                <i>PipeIndex</i> must be less than the value in the <b>bNumEndpoints</b> field of the interface descriptor.
///    PipeInformationEx = A pointer, on output, to a caller-allocated WINUSB_PIPE_INFORMATION_EX structure that contains pipe information.
///Returns:
///    <b>WinUsb_QueryPipeEx</b> returns <b>TRUE</b> if the operation succeeds. Otherwise, this function returns
///    <b>FALSE</b>, and the caller can retrieve the logged error by calling <b>GetLastError</b>. <b>GetLastError</b>
///    can return the following error code. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_INVALID_HANDLE</b></dt> </dl> </td> <td width="60%"> The caller passed <b>NULL</b>
///    in the <i>InterfaceHandle</i> parameter. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER
///    </b></dt> </dl> </td> <td width="60%"> The caller passed <b>NULL</b> in the <i>PipeInformation </i> parameter;
///    interface descriptor could not be found for the handle specified in <i>InterfaceHandle</i>. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_NO_MORE_ITEMS</b></dt> </dl> </td> <td width="60%"> The value passed in the
///    <i>PipeIndex</i> parameter is greater than the <b>bNumEndpoints</b> value of the interface descriptor; endpoint
///    descriptor could not be found for the specified interface. </td> </tr> </table>
///    
@DllImport("WINUSB")
BOOL WinUsb_QueryPipeEx(void* InterfaceHandle, ubyte AlternateSettingNumber, ubyte PipeIndex, 
                        WINUSB_PIPE_INFORMATION_EX* PipeInformationEx);

///The <b>WinUsb_SetPipePolicy</b> function sets the policy for a specific pipe associated with an endpoint on the
///device. This is a synchronous operation.
///Params:
///    InterfaceHandle = An opaque handle to an interface that contains the endpoint with which the pipe is associated. To set policy for
///                      the pipe associated with the endpoint in the first interface, use the handle returned by WinUsb_Initialize. For
///                      all other interfaces, use the handle to the target interface, retrieved by WinUsb_GetAssociatedInterface.
///    PipeID = An 8-bit value that consists of a 7-bit address and a direction bit. This parameter corresponds to the
///             <b>bEndpointAddress</b> field in the endpoint descriptor.
///    PolicyType = A <b>ULONG</b> variable that specifies the policy parameter to change. The <i>Value</i> parameter contains the
///                 new value for the policy parameter, defined in <i>winusbio.h</i>. For information about how to use each of the
///                 pipe policies and the resulting behavior, see WinUSB Functions for Pipe Policy Modification.
///    ValueLength = The size, in bytes, of the buffer at <i>Value</i>.
///    Value = The new value for the policy parameter that <i>PolicyType</i> specifies. The size of this input parameter depends
///            on the policy to change. For information about the size of this parameter, see the description of the
///            <i>PolicyType</i> parameter.
///Returns:
///    <b>WinUsb_SetPipePolicy</b> returns <b>TRUE</b> if the operation succeeds. Otherwise, this function returns
///    <b>FALSE</b>, and the caller can retrieve the logged error by calling <b>GetLastError</b>. <b>GetLastError</b>
///    can return the following error code. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_INVALID_HANDLE</b></dt> </dl> </td> <td width="60%"> The caller passed <b>NULL</b>
///    in the <i>InterfaceHandle</i> parameter. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER
///    </b></dt> </dl> </td> <td width="60%"> The caller passed an invalid size for the policy parameter buffer in the
///    <i>ValueLength</i> parameter. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NOT_ENOUGH_MEMORY</b></dt>
///    </dl> </td> <td width="60%"> Indicates that there is insufficient memory to perform the operation. </td> </tr>
///    </table>
///    
@DllImport("WINUSB")
BOOL WinUsb_SetPipePolicy(void* InterfaceHandle, ubyte PipeID, uint PolicyType, uint ValueLength, char* Value);

///The <b>WinUsb_GetPipePolicy</b> function retrieves the policy for a specific pipe associated with an endpoint on the
///device. This is a synchronous operation.
///Params:
///    InterfaceHandle = An opaque handle to an interface that contains the endpoint with which the pipe is associated. To query the pipe
///                      associated with the endpoint in the first interface, use the handle returned by WinUsb_Initialize. For all other
///                      interfaces, use the handle to the target interface, retrieved by WinUsb_GetAssociatedInterface.
///    PipeID = An 8-bit value that consists of a 7-bit address and a direction bit. This parameter corresponds to the
///             <b>bEndpointAddress</b> field in the endpoint descriptor.
///    PolicyType = A <b>ULONG</b> variable that specifies the policy parameter to retrieve. The current value for the policy
///                 parameter is retrieved the <i>Value</i> parameter. For information about the behavior of the pipe policies, see
///                 WinUSB Functions for Pipe Policy Modification.
///    ValueLength = A pointer to the size, in bytes, of the buffer that <i>Value</i> points to. On output, <i>ValueLength</i>
///                  receives the size, in bytes, of the data that was copied into the <i>Value </i>buffer.
///    Value = A pointer to a buffer that receives the specified pipe policy value.
///Returns:
///    <b>WinUsb_GetPipePolicy</b> returns <b>TRUE</b> if the operation succeeds. Otherwise, this routine returns
///    <b>FALSE</b>, and the caller can retrieve the logged error by calling <b>GetLastError</b>. <b>GetLastError</b>
///    can return the following error code. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_INVALID_HANDLE</b></dt> </dl> </td> <td width="60%"> The caller passed <b>NULL</b>
///    in the <i>InterfaceHandle</i> parameter. </td> </tr> </table>
///    
@DllImport("WINUSB")
BOOL WinUsb_GetPipePolicy(void* InterfaceHandle, ubyte PipeID, uint PolicyType, uint* ValueLength, char* Value);

///The <b>WinUsb_ReadPipe</b> function reads data from the specified pipe.
///Params:
///    InterfaceHandle = An opaque handle to the interface that contains the endpoint with which the pipe is associated. To read data from
///                      the pipe associated with an endpoint in the first interface, use the handle returned by WinUsb_Initialize. For
///                      all other interfaces, use the handle to the target interface, retrieved by WinUsb_GetAssociatedInterface.
///    PipeID = <i>PipeID</i> corresponds to the <b>bEndpointAddress</b> field in the endpoint descriptor. For information about
///             the layout of this field, see <b>Table 9-13</b> in "Universal Serial Bus Specification Revision 2.0" at USB
///             Technology. In the <b>bEndpointAddress</b> field, Bit 7 indicates the direction of the endpoint: 0 for OUT; 1 for
///             IN.
///    Buffer = A caller-allocated buffer that receives the data that is read.
///    BufferLength = The maximum number of bytes to read. This number must be less than or equal to the size, in bytes, of
///                   <i>Buffer</i>.
///    LengthTransferred = A pointer to a ULONG variable that receives the actual number of bytes that were copied into <i>Buffer</i>. For
///                        more information, see Remarks.
///    Overlapped = An optional pointer to an OVERLAPPED structure that is used for asynchronous operations. If this parameter is
///                 specified, <b>WinUsb_ReadPipe</b> returns immediately rather than waiting synchronously for the operation to
///                 complete before returning. An event is signaled when the operation is complete.
///Returns:
///    <b>WinUsb_ReadPipe</b> returns <b>TRUE</b> if the operation succeeds. Otherwise, this function returns
///    <b>FALSE</b>, and the caller can retrieve the logged error by calling <b>GetLastError</b>. <b>GetLastError</b>
///    can return the following error code. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_INVALID_HANDLE</b></dt> </dl> </td> <td width="60%"> The caller passed <b>NULL</b>
///    in the <i>InterfaceHandle</i> parameter. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_IO_PENDING</b></dt>
///    </dl> </td> <td width="60%"> An overlapped I/O operation is in progress but has not completed. If the overlapped
///    operation cannot be completed immediately, the function returns <b>FALSE</b> and the <b>GetLastError</b> function
///    returns ERROR_IO_PENDING, indicating that the operation is executing in the background. Call
///    WinUsb_GetOverlappedResult to check the success or failure of the operation. </td> </tr> <tr> <td width="40%">
///    <dl> <dt><b>ERROR_NOT_ENOUGH_MEMORY</b></dt> </dl> </td> <td width="60%"> There is insufficient memory to perform
///    the operation. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_SEM_TIMEOUT</b></dt> </dl> </td> <td
///    width="60%"> The read operation initiated by WinUsb_ReadPipe in the USB stack timed out before the operation
///    could be completed. </td> </tr> </table>
///    
@DllImport("WINUSB")
BOOL WinUsb_ReadPipe(void* InterfaceHandle, ubyte PipeID, char* Buffer, uint BufferLength, uint* LengthTransferred, 
                     OVERLAPPED* Overlapped);

///The <b>WinUsb_WritePipe</b> function writes data to a pipe.
///Params:
///    InterfaceHandle = An opaque handle to the interface that contains the endpoint with which the pipe is associated. To write to a
///                      pipe that is associated with an endpoint in the first interface, use the handle returned by WinUsb_Initialize.
///                      For all other interfaces, use the handle to the target interface, retrieved by WinUsb_GetAssociatedInterface.
///    PipeID = <i>PipeID</i> corresponds to the <b>bEndpointAddress</b> field in the endpoint descriptor. For information about
///             the layout of this field, see <b>Table 9-13</b> in "Universal Serial Bus Specification Revision 2.0" at USB
///             Technology. In the <b>bEndpointAddress</b> field, Bit 7 indicates the direction of the endpoint: 0 for OUT; 1 for
///             IN.
///    Buffer = A caller-allocated buffer that contains the data to write.
///    BufferLength = The number of bytes to write. This number must be less than or equal to the size, in bytes, of <i>Buffer</i>.
///    LengthTransferred = A pointer to a ULONG variable that receives the actual number of bytes that were written to the pipe. For more
///                        information, see Remarks.
///    Overlapped = An optional pointer to an OVERLAPPED structure, which is used for asynchronous operations. If this parameter is
///                 specified, <b>WinUsb_WritePipe</b> immediately returns, and the event is signaled when the operation is complete.
///Returns:
///    <b>WinUsb_WritePipe</b> returns <b>TRUE</b> if the operation succeeds. Otherwise, this function returns
///    <b>FALSE</b>, and the caller can retrieve the logged error by calling <b>GetLastError</b>. <b>GetLastError</b>
///    can return the following error code. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_INVALID_HANDLE</b></dt> </dl> </td> <td width="60%"> The caller passed <b>NULL</b>
///    in the <i>InterfaceHandle</i> parameter. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_IO_PENDING</b></dt>
///    </dl> </td> <td width="60%"> Indicates that an overlapped I/O operation is in progress but has not completed. If
///    the overlapped operation cannot be completed immediately, the function returns <b>FALSE</b> and the
///    <b>GetLastError</b> function returns ERROR_IO_PENDING, indicating that the operation is executing in the
///    background. Call WinUsb_GetOverlappedResult to check the success or failure of the operation. </td> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>ERROR_NOT_ENOUGH_MEMORY</b></dt> </dl> </td> <td width="60%"> Indicates that there
///    is insufficient memory to perform the operation. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_SEM_TIMEOUT</b></dt> </dl> </td> <td width="60%"> The write operation initiated by WinUsb_WritePipe
///    in the USB stack timed out before the operation could be completed. </td> </tr> </table>
///    
@DllImport("WINUSB")
BOOL WinUsb_WritePipe(void* InterfaceHandle, ubyte PipeID, char* Buffer, uint BufferLength, 
                      uint* LengthTransferred, OVERLAPPED* Overlapped);

///The <b>WinUsb_ControlTransfer</b> function transmits control data over a default control endpoint.
///Params:
///    InterfaceHandle = An opaque handle to an interface in the selected configuration. To specify the recipient of a control request as
///                      the entire device or the first interface, use the handle returned by WinUsb_Initialize. For all other interfaces,
///                      obtain the handle to the target interface by calling WinUsb_GetAssociatedInterface, and then call
///                      <b>WinUsb_ControlTransfer</b> by specifying the obtained interface handle.
///    SetupPacket = The 8-byte setup packet of type WINUSB_SETUP_PACKET.
///    Buffer = A caller-allocated buffer that contains the data to transfer. The length of this buffer must not exceed 4KB.
///    BufferLength = The number of bytes to transfer, not including the setup packet. This number must be less than or equal to the
///                   size, in bytes, of <i>Buffer</i>.
///    LengthTransferred = A pointer to a ULONG variable that receives the actual number of transferred bytes. If the application does not
///                        expect any data to be transferred during the data phase (<i>BufferLength</i> is zero), <i>LengthTransferred</i>
///                        can be <b>NULL</b>.
///    Overlapped = An optional pointer to an OVERLAPPED structure, which is used for asynchronous operations. If this parameter is
///                 specified, <b>WinUsb_ControlTransfer</b> immediately returns, and the event is signaled when the operation is
///                 complete. If <i>Overlapped</i> is not supplied, the <b>WinUsb_ControlTransfer</b> function transfers data
///                 synchronously.
///Returns:
///    <b>WinUsb_ControlTransfer</b> returns <b>TRUE</b> if the operation succeeds. Otherwise, this routine returns
///    <b>FALSE</b>, and the caller can retrieve the logged error by calling <b>GetLastError</b>. <b>GetLastError</b>
///    can return one of the following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>ERROR_INVALID_HANDLE</b></dt> </dl> </td> <td width="60%"> The caller passed
///    <b>NULL</b> in the <i>InterfaceHandle</i> parameter. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_NOT_ENOUGH_MEMORY</b></dt> </dl> </td> <td width="60%"> Indicates that there is insufficient memory
///    to perform the operation. </td> </tr> </table>
///    
@DllImport("WINUSB")
BOOL WinUsb_ControlTransfer(void* InterfaceHandle, WINUSB_SETUP_PACKET SetupPacket, char* Buffer, 
                            uint BufferLength, uint* LengthTransferred, OVERLAPPED* Overlapped);

///The <b>WinUsb_ResetPipe</b> function resets the data toggle and clears the stall condition on a pipe.
///Params:
///    InterfaceHandle = An opaque handle to the interface that contains the endpoint with which the pipe is associated. To reset a pipe
///                      associated with an endpoint in the first interface, use the handle returned by WinUsb_Initialize. For all other
///                      interfaces, use the handle to the target interface, retrieved by WinUsb_GetAssociatedInterface.
///    PipeID = The identifier (ID) of the control pipe. The <i>PipeID</i> parameter is an 8-bit value that consists in a 7-bit
///             address and a direction bit. This parameter corresponds to the <b>bEndpointAddress</b> field in the endpoint
///             descriptor.
///Returns:
///    <b>WinUsb_ResetPipe</b> returns <b>TRUE</b> if the operation succeeds. Otherwise, this function returns
///    <b>FALSE</b>, and the caller can retrieve the logged error by calling <b>GetLastError</b>. <b>GetLastError</b>
///    can return the following error code. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_INVALID_HANDLE</b></dt> </dl> </td> <td width="60%"> The caller passed <b>NULL</b>
///    in the <i>InterfaceHandle</i> parameter. </td> </tr> </table>
///    
@DllImport("WINUSB")
BOOL WinUsb_ResetPipe(void* InterfaceHandle, ubyte PipeID);

///The <b>WinUsb_AbortPipe</b> function aborts all of the pending transfers for a pipe. This is a synchronous operation.
///Params:
///    InterfaceHandle = An opaque handle to an interface that contains the endpoint with which the pipe is associated. To abort transfers
///                      on the pipe associated with the endpoint in the first interface, use the handle returned by WinUsb_Initialize.
///                      For all other interfaces, use the handle to the target interface, retrieved by WinUsb_GetAssociatedInterface.
///    PipeID = The identifier (ID) of the control pipe. The <i>PipeID</i> parameter is an 8-bit value that consists of a 7-bit
///             address and a direction bit. This parameter corresponds to the <b>bEndpointAddress</b> field in the endpoint
///             descriptor.
///Returns:
///    <b>WinUsb_AbortPipe</b> returns <b>TRUE</b> if the operation succeeds. Otherwise, this routine returns
///    <b>FALSE</b>, and the caller can retrieve the logged error by calling <b>GetLastError</b>. <b>GetLastError</b>
///    can return the following error code. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_INVALID_HANDLE</b></dt> </dl> </td> <td width="60%"> The caller passed <b>NULL</b>
///    in the <i>InterfaceHandle</i> parameter. </td> </tr> </table>
///    
@DllImport("WINUSB")
BOOL WinUsb_AbortPipe(void* InterfaceHandle, ubyte PipeID);

///The <b>WinUsb_FlushPipe</b> function discards any data that is cached in a pipe. This is a synchronous operation.
///Params:
///    InterfaceHandle = An opaque handle to the interface with which the specified pipe's endpoint is associated. To clear data in a pipe
///                      that is associated with the endpoint on the first (default) interface, use the handle returned by
///                      WinUsb_Initialize. For all other interfaces, use the handle to the target interface, retrieved by
///                      WinUsb_GetAssociatedInterface.
///    PipeID = The identifier (ID) of the control pipe. The <i>PipeID</i> parameter is an 8-bit value that consists of a 7-bit
///             address and a direction bit. This parameter corresponds to the <b>bEndpointAddress</b> field in the endpoint
///             descriptor.
///Returns:
///    <b>WinUsb_FlushPipe</b> returns <b>TRUE</b> if the operation succeeds. Otherwise, this routine returns
///    <b>FALSE</b>, and the caller can retrieve the logged error by calling <b>GetLastError</b>. <b>GetLastError</b>
///    can return the following error code. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_INVALID_HANDLE</b></dt> </dl> </td> <td width="60%"> The caller passed <b>NULL</b>
///    in the <i>InterfaceHandle</i> parameter. </td> </tr> </table>
///    
@DllImport("WINUSB")
BOOL WinUsb_FlushPipe(void* InterfaceHandle, ubyte PipeID);

///The <b>WinUsb_SetPowerPolicy</b> function sets the power policy for a device.
///Params:
///    InterfaceHandle = An opaque handle to the first (default) interface on the device, which is returned by WinUsb_Initialize.
///    PolicyType = A value that specifies the power policy to set. The following table describes symbolic constants that are defined
///                 in winusbio.h. <table> <tr> <th>Policy parameter</th> <th>Description</th> </tr> <tr> <td> AUTO_SUSPEND (0x81)
///                 </td> <td> Specifies the auto-suspend policy type; the power policy parameter must be specified by the caller in
///                 the <i>Value</i> parameter. For auto-suspend, the <i>Value</i> parameter must point to a UCHAR variable. If
///                 <i>Value</i> is <b>TRUE</b> (nonzero), the USB stack suspends the device if the device is idle. A device is idle
///                 if there are no transfers pending, or if the only pending transfers are IN transfers to interrupt or bulk
///                 endpoints. The default value is determined by the value set in the <b>DefaultIdleState</b> registry setting. By
///                 default, this value is <b>TRUE</b>. </td> </tr> <tr> <td> SUSPEND_DELAY (0x83) </td> <td> Specifies the
///                 suspend-delay policy type; the power policy parameter must be specified by the caller in the <i>Value</i>
///                 parameter. For suspend-delay, <i>Value</i> must point to a ULONG variable. <i>Value</i> specifies the minimum
///                 amount of time, in milliseconds, that the WinUSB driver must wait post transfer before it can suspend the device.
///                 The default value is determined by the value set in the <b>DefaultIdleTimeout</b> registry setting. By default,
///                 this value is five seconds. </td> </tr> </table>
///    ValueLength = The size, in bytes, of the buffer at <i>Value</i>.
///    Value = The new value for the power policy parameter. Datatype and value for <i>Value</i> depends on the type of power
///            policy passed in <i>PolicyType</i>. For more information, see <i>PolicyType</i>.
///Returns:
///    <b>WinUsb_SetPowerPolicy</b> returns <b>TRUE</b> if the operation succeeds. Otherwise, this function returns
///    <b>FALSE</b>, and the caller can retrieve the logged error by calling <b>GetLastError</b>. <b>GetLastError</b>
///    can return the following error code. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_INVALID_HANDLE</b></dt> </dl> </td> <td width="60%"> The caller passed <b>NULL</b>
///    in the <i>InterfaceHandle</i> parameter. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER
///    </b></dt> </dl> </td> <td width="60%"> The caller passed an invalid size for the policy parameter buffer in the
///    <i>ValueLength</i> parameter. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NOT_ENOUGH_MEMORY</b></dt>
///    </dl> </td> <td width="60%"> Indicates that there is insufficient memory to perform the operation. </td> </tr>
///    </table>
///    
@DllImport("WINUSB")
BOOL WinUsb_SetPowerPolicy(void* InterfaceHandle, uint PolicyType, uint ValueLength, char* Value);

///The <b>WinUsb_GetPowerPolicy</b> function retrieves the power policy for a device. This is a synchronous operation.
///Params:
///    InterfaceHandle = An opaque handle to the first interface on the device, which is returned by WinUsb_Initialize.
///    PolicyType = A value that specifies the power policy parameter to retrieve in <i>Value</i>. The following table describes
///                 symbolic constants that are defined in <i>Winusbio.h</i>. <table> <tr> <th>Policy type</th> <th>Description</th>
///                 </tr> <tr> <td> AUTO_SUSPEND (0x81) </td> <td> If the caller specifies a power policy of AUTO_SUSPEND,
///                 <b>WinUsb_GetPowerPolicy</b> returns the value of the auto suspend policy parameter in the <i>Value</i>
///                 parameter. If <i>Value</i> is <b>TRUE</b> (that is, nonzero), the USB stack suspends the device when no transfers
///                 are pending or the only transfers pending are IN transfers on an interrupt or bulk endpoint. The value of the
///                 <b>DefaultIdleState</b> registry value determines the default value of the auto suspend policy parameter. The
///                 <i>Value</i> parameter must point to a UCHAR variable. </td> </tr> <tr> <td> SUSPEND_DELAY (0x83) </td> <td> If
///                 the caller specifies a power policy of SUSPEND_DELAY, <b>WinUsb_GetPowerPolicy</b> returns the value of the
///                 suspend delay policy parameter in <i>Value</i>. The suspend delay policy parameter specifies the minimum amount
///                 of time, in milliseconds, that the WinUSB driver must wait after any transfer before it can suspend the device.
///                 <i>Value</i> must point to a ULONG variable. </td> </tr> </table>
///    ValueLength = A pointer to the size of the buffer that <i>Value</i>. On output, <i>ValueLength</i> receives the size of the
///                  data that was copied into the <i>Value </i>buffer.
///    Value = A buffer that receives the specified power policy parameter. For more information, see <i>PolicyType</i>.
///Returns:
///    <b>WinUsb_GetPowerPolicy</b> returns <b>TRUE</b> if the operation succeeds. Otherwise, this routine returns
///    <b>FALSE</b>, and the caller can retrieve the logged error by calling <b>GetLastError</b>. <b>GetLastError</b>
///    can return the following error code. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_INVALID_HANDLE</b></dt> </dl> </td> <td width="60%"> The caller passed <b>NULL</b>
///    in the <i>InterfaceHandle</i> parameter. </td> </tr> </table>
///    
@DllImport("WINUSB")
BOOL WinUsb_GetPowerPolicy(void* InterfaceHandle, uint PolicyType, uint* ValueLength, char* Value);

///The <b>WinUsb_GetOverlappedResult</b> function retrieves the results of an overlapped operation on the specified
///file.
///Params:
///    InterfaceHandle = An opaque handle to the first interface on the device, which is returned by WinUsb_Initialize.
///    lpOverlapped = A pointer to an <b>OVERLAPPED</b> structure that was specified when the overlapped operation was started.
///    lpNumberOfBytesTransferred = A pointer to a variable that receives the number of bytes that were actually transferred by a read or write
///                                 operation.
///    bWait = If this parameter is <b>TRUE</b>, the function does not return until the operation has been completed. If this
///            parameter is <b>FALSE</b> and the operation is still pending, the function returns <b>FALSE</b> and the
///            <b>GetLastError</b> function returns ERROR_IO_INCOMPLETE.
///Returns:
///    If the function succeeds, the return value is any number other than zero. If the function fails, the return value
///    is zero. To get extended error information, call <b>GetLastError</b>.
///    
@DllImport("WINUSB")
BOOL WinUsb_GetOverlappedResult(void* InterfaceHandle, OVERLAPPED* lpOverlapped, uint* lpNumberOfBytesTransferred, 
                                BOOL bWait);

@DllImport("WINUSB")
USB_INTERFACE_DESCRIPTOR* WinUsb_ParseConfigurationDescriptor(USB_CONFIGURATION_DESCRIPTOR* ConfigurationDescriptor, 
                                                              void* StartPosition, int InterfaceNumber, 
                                                              int AlternateSetting, int InterfaceClass, 
                                                              int InterfaceSubClass, int InterfaceProtocol);

@DllImport("WINUSB")
USB_COMMON_DESCRIPTOR* WinUsb_ParseDescriptors(char* DescriptorBuffer, uint TotalLength, void* StartPosition, 
                                               int DescriptorType);

///The <b>WinUsb_GetCurrentFrameNumber</b> function gets the current frame number for the bus.
///Params:
///    InterfaceHandle = The handle to the device that <b>CreateFile</b> returned.
///    CurrentFrameNumber = The current frame number value.
///    TimeStamp = The time stamp value when the current frame was read.
///Returns:
///    <b>WinUsb_GetCurrentFrameNumber</b> returns TRUE if the operation succeeds. Otherwise this function returns
///    FALSE, and the caller can retrieve the logged error by calling <b>GetLastError</b>.
///    
@DllImport("WINUSB")
BOOL WinUsb_GetCurrentFrameNumber(void* InterfaceHandle, uint* CurrentFrameNumber, LARGE_INTEGER* TimeStamp);

///The <b>WinUsb_GetAdjustedFrameNumber</b> function computes what the current USB frame number should be based on the
///frame number value and timestamp.
///Params:
///    CurrentFrameNumber = The frame number to be adjusted.
///    TimeStamp = The timestamp recorded at the time the frame number was returned.
///Returns:
///    <b>WinUsb_GetAdjustedFrameNumber</b> returns TRUE if the operation succeeds. Otherwise this function returns
///    FALSE, and the caller can retrieve the logged error by calling <b>GetLastError</b>.
///    
@DllImport("WINUSB")
BOOL WinUsb_GetAdjustedFrameNumber(uint* CurrentFrameNumber, LARGE_INTEGER TimeStamp);

///The <b>WinUsb_RegisterIsochBuffer</b> function registers a buffer to be used for isochronous transfers.
///Params:
///    InterfaceHandle = An opaque handle to an interface in the selected configuration. That handle must be created by a previous call to
///                      WinUsb_Initialize or WinUsb_GetAssociatedInterface.
///    PipeID = Derived from Bit 3...0 of the <b>bEndpointAddress</b> field in the endpoint descriptor.
///    Buffer = Pointer to the transfer buffer to be registered.
///    BufferLength = Length, in bytes, of the transfer buffer pointed to by <i>Buffer</i>.
///    IsochBufferHandle = Receives an opaque handle to the registered buffer. This handle is required by other WinUSB functions that
///                        perform isochronous transfers. To release the handle, call the WinUsb_UnregisterIsochBuffer function.
///Returns:
///    <b>WinUsb_RegisterIsochBuffer</b> returns TRUE if the operation succeeds. Otherwise this function returns FALSE,
///    and the caller can retrieve the logged error by calling <b>GetLastError</b>. If the caller sets
///    <i>ContinueStream</i> to TRUE, The transfer fails if Winusb.sys is unable to schedule the transfer to continue
///    the stream without dropping one or more frames.
///    
@DllImport("WINUSB")
BOOL WinUsb_RegisterIsochBuffer(void* InterfaceHandle, ubyte PipeID, char* Buffer, uint BufferLength, 
                                void** IsochBufferHandle);

///The <b>WinUsb_UnregisterIsochBuffer</b> function releases all of the resources that WinUsb_RegisterIsochBuffer
///allocated for isochronous transfers. This is a synchronous operation.
///Params:
///    IsochBufferHandle = An opaque handle to the transfer buffer that was registered by a previous call to WinUsb_RegisterIsochBuffer.
///Returns:
///    <b>WinUsb_UnregisterIsochBuffer</b> returns TRUE if the operation succeeds. Otherwise this function returns
///    FALSE, and the caller can retrieve the logged error by calling <b>GetLastError</b>.
///    
@DllImport("WINUSB")
BOOL WinUsb_UnregisterIsochBuffer(void* IsochBufferHandle);

///The <b>WinUsb_WriteIsochPipe</b> function writes the contents of a caller-supplied buffer to an isochronous OUT
///endpoint, starting on a specified frame number.
///Params:
///    BufferHandle = An opaque handle to the transfer buffer that was registered by a previous call to WinUsb_RegisterIsochBuffer.
///    Offset = Offset into the buffer relative to the start the transfer.
///    Length = Length in bytes of the transfer buffer.
///    FrameNumber = On input, indicates the starting frame number for the transfer. On output, contains the frame number of the frame
///                  that follows the last frame used in the transfer.
///    Overlapped = Pointer to an OVERLAPPED structure used for asynchronous operations.
///Returns:
///    <b>WinUsb_WriteIsochPipe</b> returns TRUE if the operation succeeds. Otherwise this function returns FALSE, and
///    the caller can retrieve the logged error by calling <b>GetLastError</b>.
///    
@DllImport("WINUSB")
BOOL WinUsb_WriteIsochPipe(void* BufferHandle, uint Offset, uint Length, uint* FrameNumber, OVERLAPPED* Overlapped);

///The <b>WinUsb_ReadIsochPipe</b> function reads data from an isochronous OUT endpoint.
///Params:
///    BufferHandle = An opaque handle to the transfer buffer that was registered by a previous call to WinUsb_RegisterIsochBuffer.
///    Offset = Offset into the buffer relative to the start the transfer.
///    Length = Length in bytes of the transfer buffer.
///    FrameNumber = On input, indicates the starting frame number for the transfer. On output, contains the frame number of the frame
///                  that follows the last frame used in the transfer.
///    NumberOfPackets = Total number of isochronous packets required to hold the transfer buffer. Also indicates the number of elements
///                      in the array pointed to by <i>IsoPacketDescriptors</i>.
///    IsoPacketDescriptors = An array of USBD_ISO_PACKET_DESCRIPTOR structures. After the transfer completes, each element contains the status
///                           and size of the isochronous packet.
///    Overlapped = Pointer to an OVERLAPPED structure used for asynchronous operations.
///Returns:
///    <b>WinUsb_ReadIsochPipe</b> returns TRUE if the operation succeeds. Otherwise this function returns FALSE, and
///    the caller can retrieve the logged error by calling <b>GetLastError</b>.
///    
@DllImport("WINUSB")
BOOL WinUsb_ReadIsochPipe(void* BufferHandle, uint Offset, uint Length, uint* FrameNumber, uint NumberOfPackets, 
                          char* IsoPacketDescriptors, OVERLAPPED* Overlapped);

///The <b>WinUsb_WriteIsochPipeAsap</b> submits a request for writing the contents of a buffer to an isochronous OUT
///endpoint.
///Params:
///    BufferHandle = An opaque handle to the transfer buffer that was registered by a previous call to WinUsb_RegisterIsochBuffer.
///    Offset = Offset into the buffer relative to the start the transfer.
///    Length = Length in bytes of the transfer buffer.
///    ContinueStream = Indicates that the transfer should only be submitted if it can be scheduled in the first frame after the last
///                     pending transfer.
///    Overlapped = Pointer to an OVERLAPPED structure used for asynchronous operations.
///Returns:
///    <b>WinUsb_WriteIsochPipeAsap</b> returns TRUE if the operation succeeds. Otherwise this function returns FALSE,
///    and the caller can retrieve the logged error by calling <b>GetLastError</b>. If the caller sets
///    <i>ContinueStream</i> to TRUE, The transfer fails if Winusb.sys is unable to schedule the transfer to continue
///    the stream without dropping one or more frames.
///    
@DllImport("WINUSB")
BOOL WinUsb_WriteIsochPipeAsap(void* BufferHandle, uint Offset, uint Length, BOOL ContinueStream, 
                               OVERLAPPED* Overlapped);

///The <b>WinUsb_ReadIsochPipeAsap</b> function submits a request that reads data from an isochronous OUT endpoint.
///Params:
///    BufferHandle = An opaque handle to the transfer buffer that was registered by a previous call to WinUsb_RegisterIsochBuffer.
///    Offset = Offset into the buffer relative to the start the transfer.
///    Length = Length in bytes of the transfer buffer.
///    ContinueStream = Indicates that the transfer should only be submitted if it can be scheduled in the first frame after the last
///                     pending transfer.
///    NumberOfPackets = Total number of isochronous packets required to hold the transfer buffer. Also indicates the number of elements
///                      in the array pointed to by <i>IsoPacketDescriptors</i>.
///    IsoPacketDescriptors = An array of USBD_ISO_PACKET_DESCRIPTOR that receives the details of each isochronous packet in the transfer.
///    Overlapped = Pointer to an OVERLAPPED structure used for asynchronous operations.
///Returns:
///    <b>WinUsb_ReadIsochPipeAsap</b> returns TRUE if the operation succeeds. Otherwise this function returns FALSE,
///    and the caller can retrieve the logged error by calling <b>GetLastError</b>. If the caller sets
///    <i>ContinueStream</i> to TRUE, The transfer fails if Winusb.sys is unable to schedule the transfer to continue
///    the stream without dropping one or more frames.
///    
@DllImport("WINUSB")
BOOL WinUsb_ReadIsochPipeAsap(void* BufferHandle, uint Offset, uint Length, BOOL ContinueStream, 
                              uint NumberOfPackets, char* IsoPacketDescriptors, OVERLAPPED* Overlapped);

///The <b>WinUsb_StartTrackingForTimeSync</b> function starts the time synchronization feature in the USB driver stack
///that gets the associated system QPC time for USB bus frames and microframes.
///Params:
///    InterfaceHandle = An opaque handle retrieved in the previous call to WinUsb_Initialize.
///    StartTrackingInfo = A pointer to a USB_START_TRACKING_FOR_TIME_SYNC_INFORMATION structure. Set <b>TimeTrackingHandle</b> to
///                        INAVLID_HANDLE. Set <b>IsStartupDelayTolerable</b> to TRUE if the initial startup latency of up to 2.048 seconds
///                        is tolerable. FALSE, the registration is delayed until the USB driver stack is able to detect a valid frame or
///                        microframe boundary.
///Returns:
///    <b>WinUsb_StartTrackingForTimeSync</b> returns <b>TRUE</b> if the operation succeeds. Otherwise, this routine
///    returns <b>FALSE</b>, and the caller can retrieve the logged error by calling <b>GetLastError</b>.
///    <b>GetLastError</b> can return one of the following error codes. <table> <tr> <th>Return code</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_HANDLE</b></dt> </dl> </td> <td
///    width="60%"> The caller passed <b>NULL</b> in the <i>InterfaceHandle</i> or <i>StartTrackingInfo</i> parameter.
///    </td> </tr> </table>
///    
@DllImport("WINUSB")
BOOL WinUsb_StartTrackingForTimeSync(void* InterfaceHandle, 
                                     USB_START_TRACKING_FOR_TIME_SYNC_INFORMATION* StartTrackingInfo);

///The <b>WinUsb_GetCurrentFrameNumberAndQpc</b> function retrieves the system query performance counter (QPC) value
///synchronized with the frame and microframe.
///Params:
///    InterfaceHandle = An opaque handle retrieved in the previous call to WinUsb_Initialize.
///    FrameQpcInfo = A pointer to a USB_FRAME_NUMBER_AND_QPC_FOR_TIME_SYNC_INFORMATION structure. On output,
///                   <b>CurrentQueryPerformanceCounter</b> set to the system QPC value (in microseconds) predicted by the USB driver
///                   stack. Optionally, on input, the caller can specify a frame and microframe number for which to retrieve the QPC
///                   value. On output, the <b>QueryPerformanceCounterAtInputFrameOrMicroFrame</b> member is set to the QPC value for
///                   that frame or microframe.
///Returns:
///    <b>WinUsb_GetCurrentFrameNumberAndQpc</b> returns <b>TRUE</b> if the operation succeeds. Otherwise, this routine
///    returns <b>FALSE</b>, and the caller can retrieve the logged error by calling <b>GetLastError</b>.
///    <b>GetLastError</b> can return one of the following error codes. <table> <tr> <th>Return code</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_HANDLE</b></dt> </dl> </td> <td
///    width="60%"> The caller passed <b>NULL</b> in the <i>InterfaceHandle</i> or <i>FrameQpcInfo</i> parameter. </td>
///    </tr> </table>
///    
@DllImport("WINUSB")
BOOL WinUsb_GetCurrentFrameNumberAndQpc(void* InterfaceHandle, 
                                        USB_FRAME_NUMBER_AND_QPC_FOR_TIME_SYNC_INFORMATION* FrameQpcInfo);

///The <b>WinUsb_StopTrackingForTimeSync</b> function tops the time synchronization feature in the USB driver stack that
///gets the associated system QPC time for USB bus frames and microframes.
///Params:
///    InterfaceHandle = An opaque handle retrieved in the previous call to WinUsb_Initialize.
///    StopTrackingInfo = A pointer to a USB_STOP_TRACKING_FOR_TIME_SYNC_INFORMATION structure. Set <b>TimeTrackingHandle</b> to the handle
///                       received in the previous call to WinUsb_StartTrackingForTimeSync.
///Returns:
///    <b>WinUsb_StopTrackingForTimeSync</b> returns <b>TRUE</b> if the operation succeeds. Otherwise, this routine
///    returns <b>FALSE</b>, and the caller can retrieve the logged error by calling <b>GetLastError</b>.
///    <b>GetLastError</b> can return one of the following error codes. <table> <tr> <th>Return code</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_HANDLE</b></dt> </dl> </td> <td
///    width="60%"> The caller passed <b>NULL</b> in the <i>InterfaceHandle</i> or <i>StopTrackingInfo</i> parameter.
///    </td> </tr> </table>
///    
@DllImport("WINUSB")
BOOL WinUsb_StopTrackingForTimeSync(void* InterfaceHandle, 
                                    USB_STOP_TRACKING_FOR_TIME_SYNC_INFORMATION* StopTrackingInfo);


