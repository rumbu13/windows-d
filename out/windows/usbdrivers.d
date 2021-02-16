module windows.usbdrivers;

public import windows.core;
public import windows.systemservices : BOOL, HANDLE, LARGE_INTEGER, OVERLAPPED;

extern(Windows):


// Enums


enum : int
{
    UsbLowSpeed   = 0x00000000,
    UsbFullSpeed  = 0x00000001,
    UsbHighSpeed  = 0x00000002,
    UsbSuperSpeed = 0x00000003,
}
alias USB_DEVICE_SPEED = int;

enum : int
{
    Usb11Device = 0x00000000,
    Usb20Device = 0x00000001,
}
alias USB_DEVICE_TYPE = int;

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
alias USB_CONTROLLER_FLAVOR = int;

enum : int
{
    UsbdPipeTypeControl     = 0x00000000,
    UsbdPipeTypeIsochronous = 0x00000001,
    UsbdPipeTypeBulk        = 0x00000002,
    UsbdPipeTypeInterrupt   = 0x00000003,
}
alias USBD_PIPE_TYPE = int;

enum : int
{
    UsbdEndpointOffloadModeNotSupported = 0x00000000,
    UsbdEndpointOffloadSoftwareAssisted = 0x00000001,
    UsbdEndpointOffloadHardwareAssisted = 0x00000002,
}
alias USBD_ENDPOINT_OFFLOAD_MODE = int;

enum : int
{
    UsbUserSuccess                = 0x00000000,
    UsbUserNotSupported           = 0x00000001,
    UsbUserInvalidRequestCode     = 0x00000002,
    UsbUserFeatureDisabled        = 0x00000003,
    UsbUserInvalidHeaderParameter = 0x00000004,
    UsbUserInvalidParameter       = 0x00000005,
    UsbUserMiniportError          = 0x00000006,
    UsbUserBufferTooSmall         = 0x00000007,
    UsbUserErrorNotMapped         = 0x00000008,
    UsbUserDeviceNotStarted       = 0x00000009,
    UsbUserNoDeviceConnected      = 0x0000000a,
}
alias USB_USER_ERROR_CODE = int;

enum : int
{
    WdmUsbPowerNotMapped         = 0x00000000,
    WdmUsbPowerSystemUnspecified = 0x00000064,
    WdmUsbPowerSystemWorking     = 0x00000065,
    WdmUsbPowerSystemSleeping1   = 0x00000066,
    WdmUsbPowerSystemSleeping2   = 0x00000067,
    WdmUsbPowerSystemSleeping3   = 0x00000068,
    WdmUsbPowerSystemHibernate   = 0x00000069,
    WdmUsbPowerSystemShutdown    = 0x0000006a,
    WdmUsbPowerDeviceUnspecified = 0x000000c8,
    WdmUsbPowerDeviceD0          = 0x000000c9,
    WdmUsbPowerDeviceD1          = 0x000000ca,
    WdmUsbPowerDeviceD2          = 0x000000cb,
    WdmUsbPowerDeviceD3          = 0x000000cc,
}
alias WDMUSB_POWER_STATE = int;

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

struct USBUSER_REQUEST_HEADER
{
align (1):
    uint                UsbUserRequest;
    USB_USER_ERROR_CODE UsbUserStatusCode;
    uint                RequestBufferLength;
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

struct USB_CONTROLLER_INFO_0
{
align (1):
    uint PciVendorId;
    uint PciDeviceId;
    uint PciRevision;
    uint NumberOfRootPorts;
    USB_CONTROLLER_FLAVOR ControllerFlavor;
    uint HcFeatureFlags;
}

struct USBUSER_CONTROLLER_INFO_0
{
    USBUSER_REQUEST_HEADER Header;
    USB_CONTROLLER_INFO_0 Info0;
}

struct USB_UNICODE_NAME
{
align (1):
    uint      Length;
    ushort[1] String;
}

struct USBUSER_CONTROLLER_UNICODE_NAME
{
    USBUSER_REQUEST_HEADER Header;
    USB_UNICODE_NAME UnicodeName;
}

struct USB_PASS_THRU_PARAMETERS
{
align (1):
    GUID     FunctionGUID;
    uint     ParameterLength;
    ubyte[4] Parameters;
}

struct USBUSER_PASS_THRU_REQUEST
{
    USBUSER_REQUEST_HEADER Header;
    USB_PASS_THRU_PARAMETERS PassThru;
}

struct USB_POWER_INFO
{
align (1):
    WDMUSB_POWER_STATE SystemState;
    WDMUSB_POWER_STATE HcDevicePowerState;
    WDMUSB_POWER_STATE HcDeviceWake;
    WDMUSB_POWER_STATE HcSystemWake;
    WDMUSB_POWER_STATE RhDevicePowerState;
    WDMUSB_POWER_STATE RhDeviceWake;
    WDMUSB_POWER_STATE RhSystemWake;
    WDMUSB_POWER_STATE LastSystemSleepState;
    ubyte              CanWakeup;
    ubyte              IsPowered;
}

struct USBUSER_POWER_INFO_REQUEST
{
    USBUSER_REQUEST_HEADER Header;
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

struct USB_CLOSE_RAW_DEVICE_PARAMETERS
{
align (1):
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

struct USB_BANDWIDTH_INFO
{
align (1):
    uint DeviceCount;
    uint TotalBusBandwidth;
    uint Total32secBandwidth;
    uint AllocedBulkAndControl;
    uint AllocedIso;
    uint AllocedInterrupt_1ms;
    uint AllocedInterrupt_2ms;
    uint AllocedInterrupt_4ms;
    uint AllocedInterrupt_8ms;
    uint AllocedInterrupt_16ms;
    uint AllocedInterrupt_32ms;
}

struct USBUSER_BANDWIDTH_INFO_REQUEST
{
    USBUSER_REQUEST_HEADER Header;
    USB_BANDWIDTH_INFO BandwidthInformation;
}

struct USB_BUS_STATISTICS_0
{
align (1):
    uint          DeviceCount;
    LARGE_INTEGER CurrentSystemTime;
    uint          CurrentUsbFrame;
    uint          BulkBytes;
    uint          IsoBytes;
    uint          InterruptBytes;
    uint          ControlDataBytes;
    uint          PciInterruptCount;
    uint          HardResetCount;
    uint          WorkerSignalCount;
    uint          CommonBufferBytes;
    uint          WorkerIdleTimeMs;
    ubyte         RootHubEnabled;
    ubyte         RootHubDevicePowerState;
    ubyte         Unused;
    ubyte         NameIndex;
}

struct USBUSER_BUS_STATISTICS_0_REQUEST
{
    USBUSER_REQUEST_HEADER Header;
    USB_BUS_STATISTICS_0 BusStatistics0;
}

struct USB_DRIVER_VERSION_PARAMETERS
{
align (1):
    uint   DriverTrackingCode;
    uint   USBDI_Version;
    uint   USBUSER_Version;
    ubyte  CheckedPortDriver;
    ubyte  CheckedMiniportDriver;
    ushort USB_Version;
}

struct USBUSER_GET_DRIVER_VERSION
{
    USBUSER_REQUEST_HEADER Header;
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

struct WINUSB_PIPE_INFORMATION
{
    USBD_PIPE_TYPE PipeType;
    ubyte          PipeId;
    ushort         MaximumPacketSize;
    ubyte          Interval;
}

struct WINUSB_PIPE_INFORMATION_EX
{
    USBD_PIPE_TYPE PipeType;
    ubyte          PipeId;
    ushort         MaximumPacketSize;
    ubyte          Interval;
    uint           MaximumBytesPerInterval;
}

struct WINUSB_SETUP_PACKET
{
align (1):
    ubyte  RequestType;
    ubyte  Request;
    ushort Value;
    ushort Index;
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

@DllImport("WINUSB")
BOOL WinUsb_Initialize(HANDLE DeviceHandle, void** InterfaceHandle);

@DllImport("WINUSB")
BOOL WinUsb_Free(void* InterfaceHandle);

@DllImport("WINUSB")
BOOL WinUsb_GetAssociatedInterface(void* InterfaceHandle, ubyte AssociatedInterfaceIndex, 
                                   void** AssociatedInterfaceHandle);

@DllImport("WINUSB")
BOOL WinUsb_GetDescriptor(void* InterfaceHandle, ubyte DescriptorType, ubyte Index, ushort LanguageID, 
                          char* Buffer, uint BufferLength, uint* LengthTransferred);

@DllImport("WINUSB")
BOOL WinUsb_QueryInterfaceSettings(void* InterfaceHandle, ubyte AlternateInterfaceNumber, 
                                   USB_INTERFACE_DESCRIPTOR* UsbAltInterfaceDescriptor);

@DllImport("WINUSB")
BOOL WinUsb_QueryDeviceInformation(void* InterfaceHandle, uint InformationType, uint* BufferLength, char* Buffer);

@DllImport("WINUSB")
BOOL WinUsb_SetCurrentAlternateSetting(void* InterfaceHandle, ubyte SettingNumber);

@DllImport("WINUSB")
BOOL WinUsb_GetCurrentAlternateSetting(void* InterfaceHandle, ubyte* SettingNumber);

@DllImport("WINUSB")
BOOL WinUsb_QueryPipe(void* InterfaceHandle, ubyte AlternateInterfaceNumber, ubyte PipeIndex, 
                      WINUSB_PIPE_INFORMATION* PipeInformation);

@DllImport("WINUSB")
BOOL WinUsb_QueryPipeEx(void* InterfaceHandle, ubyte AlternateSettingNumber, ubyte PipeIndex, 
                        WINUSB_PIPE_INFORMATION_EX* PipeInformationEx);

@DllImport("WINUSB")
BOOL WinUsb_SetPipePolicy(void* InterfaceHandle, ubyte PipeID, uint PolicyType, uint ValueLength, char* Value);

@DllImport("WINUSB")
BOOL WinUsb_GetPipePolicy(void* InterfaceHandle, ubyte PipeID, uint PolicyType, uint* ValueLength, char* Value);

@DllImport("WINUSB")
BOOL WinUsb_ReadPipe(void* InterfaceHandle, ubyte PipeID, char* Buffer, uint BufferLength, uint* LengthTransferred, 
                     OVERLAPPED* Overlapped);

@DllImport("WINUSB")
BOOL WinUsb_WritePipe(void* InterfaceHandle, ubyte PipeID, char* Buffer, uint BufferLength, 
                      uint* LengthTransferred, OVERLAPPED* Overlapped);

@DllImport("WINUSB")
BOOL WinUsb_ControlTransfer(void* InterfaceHandle, WINUSB_SETUP_PACKET SetupPacket, char* Buffer, 
                            uint BufferLength, uint* LengthTransferred, OVERLAPPED* Overlapped);

@DllImport("WINUSB")
BOOL WinUsb_ResetPipe(void* InterfaceHandle, ubyte PipeID);

@DllImport("WINUSB")
BOOL WinUsb_AbortPipe(void* InterfaceHandle, ubyte PipeID);

@DllImport("WINUSB")
BOOL WinUsb_FlushPipe(void* InterfaceHandle, ubyte PipeID);

@DllImport("WINUSB")
BOOL WinUsb_SetPowerPolicy(void* InterfaceHandle, uint PolicyType, uint ValueLength, char* Value);

@DllImport("WINUSB")
BOOL WinUsb_GetPowerPolicy(void* InterfaceHandle, uint PolicyType, uint* ValueLength, char* Value);

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

@DllImport("WINUSB")
BOOL WinUsb_GetCurrentFrameNumber(void* InterfaceHandle, uint* CurrentFrameNumber, LARGE_INTEGER* TimeStamp);

@DllImport("WINUSB")
BOOL WinUsb_GetAdjustedFrameNumber(uint* CurrentFrameNumber, LARGE_INTEGER TimeStamp);

@DllImport("WINUSB")
BOOL WinUsb_RegisterIsochBuffer(void* InterfaceHandle, ubyte PipeID, char* Buffer, uint BufferLength, 
                                void** IsochBufferHandle);

@DllImport("WINUSB")
BOOL WinUsb_UnregisterIsochBuffer(void* IsochBufferHandle);

@DllImport("WINUSB")
BOOL WinUsb_WriteIsochPipe(void* BufferHandle, uint Offset, uint Length, uint* FrameNumber, OVERLAPPED* Overlapped);

@DllImport("WINUSB")
BOOL WinUsb_ReadIsochPipe(void* BufferHandle, uint Offset, uint Length, uint* FrameNumber, uint NumberOfPackets, 
                          char* IsoPacketDescriptors, OVERLAPPED* Overlapped);

@DllImport("WINUSB")
BOOL WinUsb_WriteIsochPipeAsap(void* BufferHandle, uint Offset, uint Length, BOOL ContinueStream, 
                               OVERLAPPED* Overlapped);

@DllImport("WINUSB")
BOOL WinUsb_ReadIsochPipeAsap(void* BufferHandle, uint Offset, uint Length, BOOL ContinueStream, 
                              uint NumberOfPackets, char* IsoPacketDescriptors, OVERLAPPED* Overlapped);

@DllImport("WINUSB")
BOOL WinUsb_StartTrackingForTimeSync(void* InterfaceHandle, 
                                     USB_START_TRACKING_FOR_TIME_SYNC_INFORMATION* StartTrackingInfo);

@DllImport("WINUSB")
BOOL WinUsb_GetCurrentFrameNumberAndQpc(void* InterfaceHandle, 
                                        USB_FRAME_NUMBER_AND_QPC_FOR_TIME_SYNC_INFORMATION* FrameQpcInfo);

@DllImport("WINUSB")
BOOL WinUsb_StopTrackingForTimeSync(void* InterfaceHandle, 
                                    USB_STOP_TRACKING_FOR_TIME_SYNC_INFORMATION* StopTrackingInfo);


