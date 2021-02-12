module windows.usbdrivers;

public import system;
public import windows.systemservices;

extern(Windows):

enum USB_DEVICE_SPEED
{
    UsbLowSpeed = 0,
    UsbFullSpeed = 1,
    UsbHighSpeed = 2,
    UsbSuperSpeed = 3,
}

enum USB_DEVICE_TYPE
{
    Usb11Device = 0,
    Usb20Device = 1,
}

struct BM_REQUEST_TYPE
{
    _BM s;
    ubyte B;
}

struct USB_DEFAULT_PIPE_SETUP_PACKET
{
    BM_REQUEST_TYPE bmRequestType;
    ubyte bRequest;
    _wValue wValue;
    _wIndex wIndex;
    ushort wLength;
}

struct USB_DEVICE_STATUS
{
    ushort AsUshort16;
    _Anonymous_e__Struct Anonymous;
}

struct USB_INTERFACE_STATUS
{
    ushort AsUshort16;
    _Anonymous_e__Struct Anonymous;
}

struct USB_ENDPOINT_STATUS
{
    ushort AsUshort16;
    _Anonymous_e__Struct Anonymous;
}

struct USB_COMMON_DESCRIPTOR
{
    ubyte bLength;
    ubyte bDescriptorType;
}

struct USB_DEVICE_DESCRIPTOR
{
    ubyte bLength;
    ubyte bDescriptorType;
    ushort bcdUSB;
    ubyte bDeviceClass;
    ubyte bDeviceSubClass;
    ubyte bDeviceProtocol;
    ubyte bMaxPacketSize0;
    ushort idVendor;
    ushort idProduct;
    ushort bcdDevice;
    ubyte iManufacturer;
    ubyte iProduct;
    ubyte iSerialNumber;
    ubyte bNumConfigurations;
}

struct USB_DEVICE_QUALIFIER_DESCRIPTOR
{
    ubyte bLength;
    ubyte bDescriptorType;
    ushort bcdUSB;
    ubyte bDeviceClass;
    ubyte bDeviceSubClass;
    ubyte bDeviceProtocol;
    ubyte bMaxPacketSize0;
    ubyte bNumConfigurations;
    ubyte bReserved;
}

struct USB_BOS_DESCRIPTOR
{
    ubyte bLength;
    ubyte bDescriptorType;
    ushort wTotalLength;
    ubyte bNumDeviceCaps;
}

struct USB_DEVICE_CAPABILITY_USB20_EXTENSION_DESCRIPTOR
{
    ubyte bLength;
    ubyte bDescriptorType;
    ubyte bDevCapabilityType;
    _bmAttributes_e__Union bmAttributes;
}

struct USB_DEVICE_CAPABILITY_POWER_DELIVERY_DESCRIPTOR
{
    ubyte bLength;
    ubyte bDescriptorType;
    ubyte bDevCapabilityType;
    ubyte bReserved;
    _bmAttributes_e__Union bmAttributes;
    ushort bmProviderPorts;
    ushort bmConsumerPorts;
    ushort bcdBCVersion;
    ushort bcdPDVersion;
    ushort bcdUSBTypeCVersion;
}

struct USB_DEVICE_CAPABILITY_PD_CONSUMER_PORT_DESCRIPTOR
{
    ubyte bLength;
    ubyte bDescriptorType;
    ubyte bDevCapabilityType;
    ubyte bReserved;
    _bmCapabilities_e__Union bmCapabilities;
    ushort wMinVoltage;
    ushort wMaxVoltage;
    ushort wReserved;
    uint dwMaxOperatingPower;
    uint dwMaxPeakPower;
    uint dwMaxPeakPowerTime;
}

struct USB_DEVICE_CAPABILITY_SUPERSPEED_USB_DESCRIPTOR
{
    ubyte bLength;
    ubyte bDescriptorType;
    ubyte bDevCapabilityType;
    ubyte bmAttributes;
    ushort wSpeedsSupported;
    ubyte bFunctionalitySupport;
    ubyte bU1DevExitLat;
    ushort wU2DevExitLat;
}

struct USB_DEVICE_CAPABILITY_SUPERSPEEDPLUS_SPEED
{
    uint AsUlong32;
    _Anonymous_e__Struct Anonymous;
}

struct USB_DEVICE_CAPABILITY_SUPERSPEEDPLUS_USB_DESCRIPTOR
{
    ubyte bLength;
    ubyte bDescriptorType;
    ubyte bDevCapabilityType;
    ubyte bReserved;
    _bmAttributes_e__Union bmAttributes;
    _wFunctionalitySupport_e__Union wFunctionalitySupport;
    ushort wReserved;
    USB_DEVICE_CAPABILITY_SUPERSPEEDPLUS_SPEED bmSublinkSpeedAttr;
}

struct USB_DEVICE_CAPABILITY_CONTAINER_ID_DESCRIPTOR
{
    ubyte bLength;
    ubyte bDescriptorType;
    ubyte bDevCapabilityType;
    ubyte bReserved;
    ubyte ContainerID;
}

struct USB_DEVICE_CAPABILITY_PLATFORM_DESCRIPTOR
{
    ubyte bLength;
    ubyte bDescriptorType;
    ubyte bDevCapabilityType;
    ubyte bReserved;
    Guid PlatformCapabilityUuid;
    ubyte CapabililityData;
}

struct USB_DEVICE_CAPABILITY_BILLBOARD_DESCRIPTOR
{
    ubyte bLength;
    ubyte bDescriptorType;
    ubyte bDevCapabilityType;
    ubyte iAddtionalInfoURL;
    ubyte bNumberOfAlternateModes;
    ubyte bPreferredAlternateMode;
    _VconnPower_e__Union VconnPower;
    ubyte bmConfigured;
    uint bReserved;
    _Anonymous_e__Struct AlternateMode;
}

struct USB_DEVICE_CAPABILITY_FIRMWARE_STATUS_DESCRIPTOR
{
    ubyte bLength;
    ubyte bDescriptorType;
    ubyte bDevCapabilityType;
    ubyte bcdDescriptorVersion;
    _bmAttributes_e__Union bmAttributes;
}

struct USB_DEVICE_CAPABILITY_DESCRIPTOR
{
    ubyte bLength;
    ubyte bDescriptorType;
    ubyte bDevCapabilityType;
}

struct USB_CONFIGURATION_DESCRIPTOR
{
    ubyte bLength;
    ubyte bDescriptorType;
    ushort wTotalLength;
    ubyte bNumInterfaces;
    ubyte bConfigurationValue;
    ubyte iConfiguration;
    ubyte bmAttributes;
    ubyte MaxPower;
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
    ubyte bLength;
    ubyte bDescriptorType;
    ubyte bEndpointAddress;
    ubyte bmAttributes;
    ushort wMaxPacketSize;
    ubyte bInterval;
}

struct USB_HIGH_SPEED_MAXPACKET
{
    ushort us;
}

struct USB_STRING_DESCRIPTOR
{
    ubyte bLength;
    ubyte bDescriptorType;
    ushort bString;
}

struct USB_SUPERSPEED_ENDPOINT_COMPANION_DESCRIPTOR
{
    ubyte bLength;
    ubyte bDescriptorType;
    ubyte bMaxBurst;
    _bmAttributes_e__Union bmAttributes;
    ushort wBytesPerInterval;
}

struct USB_SUPERSPEEDPLUS_ISOCH_ENDPOINT_COMPANION_DESCRIPTOR
{
    ubyte bLength;
    ubyte bDescriptorType;
    ushort wReserved;
    uint dwBytesPerInterval;
}

struct USB_HUB_DESCRIPTOR
{
    ubyte bDescriptorLength;
    ubyte bDescriptorType;
    ubyte bNumberOfPorts;
    ushort wHubCharacteristics;
    ubyte bPowerOnToPowerGood;
    ubyte bHubControlCurrent;
    ubyte bRemoveAndPowerMask;
}

struct USB_30_HUB_DESCRIPTOR
{
    ubyte bLength;
    ubyte bDescriptorType;
    ubyte bNumberOfPorts;
    ushort wHubCharacteristics;
    ubyte bPowerOnToPowerGood;
    ubyte bHubControlCurrent;
    ubyte bHubHdrDecLat;
    ushort wHubDelay;
    ushort DeviceRemovable;
}

struct USB_HUB_STATUS
{
    ushort AsUshort16;
    _Anonymous_e__Struct Anonymous;
}

struct USB_HUB_CHANGE
{
    ushort AsUshort16;
    _Anonymous_e__Struct Anonymous;
}

struct USB_HUB_STATUS_AND_CHANGE
{
    uint AsUlong32;
    _Anonymous_e__Struct Anonymous;
}

struct USB_20_PORT_STATUS
{
    ushort AsUshort16;
    _Anonymous_e__Struct Anonymous;
}

struct USB_20_PORT_CHANGE
{
    ushort AsUshort16;
    _Anonymous_e__Struct Anonymous;
}

struct USB_30_PORT_STATUS
{
    ushort AsUshort16;
    _Anonymous_e__Struct Anonymous;
}

struct USB_30_PORT_CHANGE
{
    ushort AsUshort16;
    _Anonymous_e__Struct Anonymous;
}

struct USB_PORT_STATUS
{
    ushort AsUshort16;
    USB_20_PORT_STATUS Usb20PortStatus;
    USB_30_PORT_STATUS Usb30PortStatus;
}

struct USB_PORT_CHANGE
{
    ushort AsUshort16;
    USB_20_PORT_CHANGE Usb20PortChange;
    USB_30_PORT_CHANGE Usb30PortChange;
}

struct USB_PORT_EXT_STATUS
{
    uint AsUlong32;
    _Anonymous_e__Struct Anonymous;
}

struct USB_PORT_STATUS_AND_CHANGE
{
    uint AsUlong32;
    _Anonymous_e__Struct Anonymous;
}

struct USB_PORT_EXT_STATUS_AND_CHANGE
{
    ulong AsUlong64;
    _Anonymous_e__Struct Anonymous;
}

struct USB_HUB_30_PORT_REMOTE_WAKE_MASK
{
    ubyte AsUchar8;
    _Anonymous_e__Struct Anonymous;
}

struct USB_FUNCTION_SUSPEND_OPTIONS
{
    ubyte AsUchar;
    _Anonymous_e__Struct Anonymous;
}

struct USB_CONFIGURATION_POWER_DESCRIPTOR
{
    ubyte bLength;
    ubyte bDescriptorType;
    ubyte SelfPowerConsumedD0;
    ubyte bPowerSummaryId;
    ubyte bBusPowerSavingD1;
    ubyte bSelfPowerSavingD1;
    ubyte bBusPowerSavingD2;
    ubyte bSelfPowerSavingD2;
    ubyte bBusPowerSavingD3;
    ubyte bSelfPowerSavingD3;
    ushort TransitionTimeFromD1;
    ushort TransitionTimeFromD2;
    ushort TransitionTimeFromD3;
}

struct USB_INTERFACE_POWER_DESCRIPTOR
{
    ubyte bLength;
    ubyte bDescriptorType;
    ubyte bmCapabilitiesFlags;
    ubyte bBusPowerSavingD1;
    ubyte bSelfPowerSavingD1;
    ubyte bBusPowerSavingD2;
    ubyte bSelfPowerSavingD2;
    ubyte bBusPowerSavingD3;
    ubyte bSelfPowerSavingD3;
    ushort TransitionTimeFromD1;
    ushort TransitionTimeFromD2;
    ushort TransitionTimeFromD3;
}

enum USB_CONTROLLER_FLAVOR
{
    USB_HcGeneric = 0,
    OHCI_Generic = 100,
    OHCI_Hydra = 101,
    OHCI_NEC = 102,
    UHCI_Generic = 200,
    UHCI_Piix4 = 201,
    UHCI_Piix3 = 202,
    UHCI_Ich2 = 203,
    UHCI_Reserved204 = 204,
    UHCI_Ich1 = 205,
    UHCI_Ich3m = 206,
    UHCI_Ich4 = 207,
    UHCI_Ich5 = 208,
    UHCI_Ich6 = 209,
    UHCI_Intel = 249,
    UHCI_VIA = 250,
    UHCI_VIA_x01 = 251,
    UHCI_VIA_x02 = 252,
    UHCI_VIA_x03 = 253,
    UHCI_VIA_x04 = 254,
    UHCI_VIA_x0E_FIFO = 264,
    EHCI_Generic = 1000,
    EHCI_NEC = 2000,
    EHCI_Lucent = 3000,
    EHCI_NVIDIA_Tegra2 = 4000,
    EHCI_NVIDIA_Tegra3 = 4001,
    EHCI_Intel_Medfield = 5001,
}

struct USBD_VERSION_INFORMATION
{
    uint USBDI_Version;
    uint Supported_USB_Version;
}

enum USBD_PIPE_TYPE
{
    UsbdPipeTypeControl = 0,
    UsbdPipeTypeIsochronous = 1,
    UsbdPipeTypeBulk = 2,
    UsbdPipeTypeInterrupt = 3,
}

struct USBD_DEVICE_INFORMATION
{
    uint OffsetNext;
    void* UsbdDeviceHandle;
    USB_DEVICE_DESCRIPTOR DeviceDescriptor;
}

struct USBD_PIPE_INFORMATION
{
    ushort MaximumPacketSize;
    ubyte EndpointAddress;
    ubyte Interval;
    USBD_PIPE_TYPE PipeType;
    void* PipeHandle;
    uint MaximumTransferSize;
    uint PipeFlags;
}

enum USBD_ENDPOINT_OFFLOAD_MODE
{
    UsbdEndpointOffloadModeNotSupported = 0,
    UsbdEndpointOffloadSoftwareAssisted = 1,
    UsbdEndpointOffloadHardwareAssisted = 2,
}

struct USBD_ENDPOINT_OFFLOAD_INFORMATION
{
    uint Size;
    ushort EndpointAddress;
    uint ResourceId;
    USBD_ENDPOINT_OFFLOAD_MODE Mode;
    uint _bitfield1;
    uint _bitfield2;
    LARGE_INTEGER TransferSegmentLA;
    void* TransferSegmentVA;
    uint TransferRingSize;
    uint TransferRingInitialCycleBit;
    uint MessageNumber;
    LARGE_INTEGER EventRingSegmentLA;
    void* EventRingSegmentVA;
    uint EventRingSize;
    uint EventRingInitialCycleBit;
}

struct USBD_INTERFACE_INFORMATION
{
    ushort Length;
    ubyte InterfaceNumber;
    ubyte AlternateSetting;
    ubyte Class;
    ubyte SubClass;
    ubyte Protocol;
    ubyte Reserved;
    void* InterfaceHandle;
    uint NumberOfPipes;
    USBD_PIPE_INFORMATION Pipes;
}

struct _URB_HCD_AREA
{
    void* Reserved8;
}

struct _URB_HEADER
{
    ushort Length;
    ushort Function;
    int Status;
    void* UsbdDeviceHandle;
    uint UsbdFlags;
}

struct _URB_SELECT_INTERFACE
{
    _URB_HEADER Hdr;
    void* ConfigurationHandle;
    USBD_INTERFACE_INFORMATION Interface;
}

struct _URB_SELECT_CONFIGURATION
{
    _URB_HEADER Hdr;
    USB_CONFIGURATION_DESCRIPTOR* ConfigurationDescriptor;
    void* ConfigurationHandle;
    USBD_INTERFACE_INFORMATION Interface;
}

struct _URB_PIPE_REQUEST
{
    _URB_HEADER Hdr;
    void* PipeHandle;
    uint Reserved;
}

struct _URB_FRAME_LENGTH_CONTROL
{
    _URB_HEADER Hdr;
}

struct _URB_GET_FRAME_LENGTH
{
    _URB_HEADER Hdr;
    uint FrameLength;
    uint FrameNumber;
}

struct _URB_SET_FRAME_LENGTH
{
    _URB_HEADER Hdr;
    int FrameLengthDelta;
}

struct _URB_GET_CURRENT_FRAME_NUMBER
{
    _URB_HEADER Hdr;
    uint FrameNumber;
}

struct _URB_CONTROL_DESCRIPTOR_REQUEST
{
    _URB_HEADER Hdr;
    void* Reserved;
    uint Reserved0;
    uint TransferBufferLength;
    void* TransferBuffer;
    void* TransferBufferMDL;
    URB* UrbLink;
    _URB_HCD_AREA hca;
    ushort Reserved1;
    ubyte Index;
    ubyte DescriptorType;
    ushort LanguageId;
    ushort Reserved2;
}

struct _URB_CONTROL_GET_STATUS_REQUEST
{
    _URB_HEADER Hdr;
    void* Reserved;
    uint Reserved0;
    uint TransferBufferLength;
    void* TransferBuffer;
    void* TransferBufferMDL;
    URB* UrbLink;
    _URB_HCD_AREA hca;
    ubyte Reserved1;
    ushort Index;
    ushort Reserved2;
}

struct _URB_CONTROL_FEATURE_REQUEST
{
    _URB_HEADER Hdr;
    void* Reserved;
    uint Reserved2;
    uint Reserved3;
    void* Reserved4;
    void* Reserved5;
    URB* UrbLink;
    _URB_HCD_AREA hca;
    ushort Reserved0;
    ushort FeatureSelector;
    ushort Index;
    ushort Reserved1;
}

struct _URB_CONTROL_VENDOR_OR_CLASS_REQUEST
{
    _URB_HEADER Hdr;
    void* Reserved;
    uint TransferFlags;
    uint TransferBufferLength;
    void* TransferBuffer;
    void* TransferBufferMDL;
    URB* UrbLink;
    _URB_HCD_AREA hca;
    ubyte RequestTypeReservedBits;
    ubyte Request;
    ushort Value;
    ushort Index;
    ushort Reserved1;
}

struct _URB_CONTROL_GET_INTERFACE_REQUEST
{
    _URB_HEADER Hdr;
    void* Reserved;
    uint Reserved0;
    uint TransferBufferLength;
    void* TransferBuffer;
    void* TransferBufferMDL;
    URB* UrbLink;
    _URB_HCD_AREA hca;
    ubyte Reserved1;
    ushort Interface;
    ushort Reserved2;
}

struct _URB_CONTROL_GET_CONFIGURATION_REQUEST
{
    _URB_HEADER Hdr;
    void* Reserved;
    uint Reserved0;
    uint TransferBufferLength;
    void* TransferBuffer;
    void* TransferBufferMDL;
    URB* UrbLink;
    _URB_HCD_AREA hca;
    ubyte Reserved1;
}

struct OS_STRING
{
    ubyte bLength;
    ubyte bDescriptorType;
    ushort MicrosoftString;
    ubyte bVendorCode;
    _Anonymous_e__Union Anonymous;
}

struct _URB_OS_FEATURE_DESCRIPTOR_REQUEST
{
    _URB_HEADER Hdr;
    void* Reserved;
    uint Reserved0;
    uint TransferBufferLength;
    void* TransferBuffer;
    void* TransferBufferMDL;
    URB* UrbLink;
    _URB_HCD_AREA hca;
    ubyte _bitfield;
    ubyte Reserved2;
    ubyte InterfaceNumber;
    ubyte MS_PageIndex;
    ushort MS_FeatureDescriptorIndex;
    ushort Reserved3;
}

struct _URB_CONTROL_TRANSFER
{
    _URB_HEADER Hdr;
    void* PipeHandle;
    uint TransferFlags;
    uint TransferBufferLength;
    void* TransferBuffer;
    void* TransferBufferMDL;
    URB* UrbLink;
    _URB_HCD_AREA hca;
    ubyte SetupPacket;
}

struct _URB_CONTROL_TRANSFER_EX
{
    _URB_HEADER Hdr;
    void* PipeHandle;
    uint TransferFlags;
    uint TransferBufferLength;
    void* TransferBuffer;
    void* TransferBufferMDL;
    uint Timeout;
    _URB_HCD_AREA hca;
    ubyte SetupPacket;
}

struct _URB_BULK_OR_INTERRUPT_TRANSFER
{
    _URB_HEADER Hdr;
    void* PipeHandle;
    uint TransferFlags;
    uint TransferBufferLength;
    void* TransferBuffer;
    void* TransferBufferMDL;
    URB* UrbLink;
    _URB_HCD_AREA hca;
}

struct USBD_ISO_PACKET_DESCRIPTOR
{
    uint Offset;
    uint Length;
    int Status;
}

struct _URB_ISOCH_TRANSFER
{
    _URB_HEADER Hdr;
    void* PipeHandle;
    uint TransferFlags;
    uint TransferBufferLength;
    void* TransferBuffer;
    void* TransferBufferMDL;
    URB* UrbLink;
    _URB_HCD_AREA hca;
    uint StartFrame;
    uint NumberOfPackets;
    uint ErrorCount;
    USBD_ISO_PACKET_DESCRIPTOR IsoPacket;
}

struct USBD_STREAM_INFORMATION
{
    void* PipeHandle;
    uint StreamID;
    uint MaximumTransferSize;
    uint PipeFlags;
}

struct _URB_OPEN_STATIC_STREAMS
{
    _URB_HEADER Hdr;
    void* PipeHandle;
    uint NumberOfStreams;
    ushort StreamInfoVersion;
    ushort StreamInfoSize;
    USBD_STREAM_INFORMATION* Streams;
}

struct _URB_GET_ISOCH_PIPE_TRANSFER_PATH_DELAYS
{
    _URB_HEADER Hdr;
    void* PipeHandle;
    uint MaximumSendPathDelayInMilliSeconds;
    uint MaximumCompletionPathDelayInMilliSeconds;
}

struct URB
{
    _Anonymous_e__Union Anonymous;
}

alias USB_IDLE_CALLBACK = extern(Windows) void function(void* Context);
struct USB_IDLE_CALLBACK_INFO
{
    USB_IDLE_CALLBACK IdleCallback;
    void* IdleContext;
}

enum USB_USER_ERROR_CODE
{
    UsbUserSuccess = 0,
    UsbUserNotSupported = 1,
    UsbUserInvalidRequestCode = 2,
    UsbUserFeatureDisabled = 3,
    UsbUserInvalidHeaderParameter = 4,
    UsbUserInvalidParameter = 5,
    UsbUserMiniportError = 6,
    UsbUserBufferTooSmall = 7,
    UsbUserErrorNotMapped = 8,
    UsbUserDeviceNotStarted = 9,
    UsbUserNoDeviceConnected = 10,
}

struct USBUSER_REQUEST_HEADER
{
    uint UsbUserRequest;
    USB_USER_ERROR_CODE UsbUserStatusCode;
    uint RequestBufferLength;
    uint ActualBufferLength;
}

struct PACKET_PARAMETERS
{
    ubyte DeviceAddress;
    ubyte EndpointAddress;
    ushort MaximumPacketSize;
    uint Timeout;
    uint Flags;
    uint DataLength;
    ushort HubDeviceAddress;
    ushort PortTTNumber;
    ubyte ErrorCount;
    ubyte Pad;
    int UsbdStatusCode;
    ubyte Data;
}

struct USBUSER_SEND_ONE_PACKET
{
    USBUSER_REQUEST_HEADER Header;
    PACKET_PARAMETERS PacketParameters;
}

struct RAW_RESET_PORT_PARAMETERS
{
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
    uint Length;
    ushort String;
}

struct USBUSER_CONTROLLER_UNICODE_NAME
{
    USBUSER_REQUEST_HEADER Header;
    USB_UNICODE_NAME UnicodeName;
}

struct USB_PASS_THRU_PARAMETERS
{
    Guid FunctionGUID;
    uint ParameterLength;
    ubyte Parameters;
}

struct USBUSER_PASS_THRU_REQUEST
{
    USBUSER_REQUEST_HEADER Header;
    USB_PASS_THRU_PARAMETERS PassThru;
}

enum WDMUSB_POWER_STATE
{
    WdmUsbPowerNotMapped = 0,
    WdmUsbPowerSystemUnspecified = 100,
    WdmUsbPowerSystemWorking = 101,
    WdmUsbPowerSystemSleeping1 = 102,
    WdmUsbPowerSystemSleeping2 = 103,
    WdmUsbPowerSystemSleeping3 = 104,
    WdmUsbPowerSystemHibernate = 105,
    WdmUsbPowerSystemShutdown = 106,
    WdmUsbPowerDeviceUnspecified = 200,
    WdmUsbPowerDeviceD0 = 201,
    WdmUsbPowerDeviceD1 = 202,
    WdmUsbPowerDeviceD2 = 203,
    WdmUsbPowerDeviceD3 = 204,
}

struct USB_POWER_INFO
{
    WDMUSB_POWER_STATE SystemState;
    WDMUSB_POWER_STATE HcDevicePowerState;
    WDMUSB_POWER_STATE HcDeviceWake;
    WDMUSB_POWER_STATE HcSystemWake;
    WDMUSB_POWER_STATE RhDevicePowerState;
    WDMUSB_POWER_STATE RhDeviceWake;
    WDMUSB_POWER_STATE RhSystemWake;
    WDMUSB_POWER_STATE LastSystemSleepState;
    ubyte CanWakeup;
    ubyte IsPowered;
}

struct USBUSER_POWER_INFO_REQUEST
{
    USBUSER_REQUEST_HEADER Header;
    USB_POWER_INFO PowerInformation;
}

struct USB_OPEN_RAW_DEVICE_PARAMETERS
{
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
    uint xxx;
}

struct USBUSER_CLOSE_RAW_DEVICE
{
    USBUSER_REQUEST_HEADER Header;
    USB_CLOSE_RAW_DEVICE_PARAMETERS Parameters;
}

struct USB_SEND_RAW_COMMAND_PARAMETERS
{
    ubyte Usb_bmRequest;
    ubyte Usb_bRequest;
    ushort Usb_wVlaue;
    ushort Usb_wIndex;
    ushort Usb_wLength;
    ushort DeviceAddress;
    ushort MaximumPacketSize;
    uint Timeout;
    uint DataLength;
    int UsbdStatusCode;
    ubyte Data;
}

struct USBUSER_SEND_RAW_COMMAND
{
    USBUSER_REQUEST_HEADER Header;
    USB_SEND_RAW_COMMAND_PARAMETERS Parameters;
}

struct USB_BANDWIDTH_INFO
{
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
    uint DeviceCount;
    LARGE_INTEGER CurrentSystemTime;
    uint CurrentUsbFrame;
    uint BulkBytes;
    uint IsoBytes;
    uint InterruptBytes;
    uint ControlDataBytes;
    uint PciInterruptCount;
    uint HardResetCount;
    uint WorkerSignalCount;
    uint CommonBufferBytes;
    uint WorkerIdleTimeMs;
    ubyte RootHubEnabled;
    ubyte RootHubDevicePowerState;
    ubyte Unused;
    ubyte NameIndex;
}

struct USBUSER_BUS_STATISTICS_0_REQUEST
{
    USBUSER_REQUEST_HEADER Header;
    USB_BUS_STATISTICS_0 BusStatistics0;
}

struct USB_DRIVER_VERSION_PARAMETERS
{
    uint DriverTrackingCode;
    uint USBDI_Version;
    uint USBUSER_Version;
    ubyte CheckedPortDriver;
    ubyte CheckedMiniportDriver;
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
    USBUSER_REQUEST_HEADER Header;
    uint Flags;
}

struct WINUSB_PIPE_INFORMATION
{
    USBD_PIPE_TYPE PipeType;
    ubyte PipeId;
    ushort MaximumPacketSize;
    ubyte Interval;
}

struct WINUSB_PIPE_INFORMATION_EX
{
    USBD_PIPE_TYPE PipeType;
    ubyte PipeId;
    ushort MaximumPacketSize;
    ubyte Interval;
    uint MaximumBytesPerInterval;
}

struct WINUSB_SETUP_PACKET
{
    ubyte RequestType;
    ubyte Request;
    ushort Value;
    ushort Index;
    ushort Length;
}

struct USB_START_TRACKING_FOR_TIME_SYNC_INFORMATION
{
    HANDLE TimeTrackingHandle;
    ubyte IsStartupDelayTolerable;
}

struct USB_STOP_TRACKING_FOR_TIME_SYNC_INFORMATION
{
    HANDLE TimeTrackingHandle;
}

struct USB_FRAME_NUMBER_AND_QPC_FOR_TIME_SYNC_INFORMATION
{
    HANDLE TimeTrackingHandle;
    uint InputFrameNumber;
    uint InputMicroFrameNumber;
    LARGE_INTEGER QueryPerformanceCounterAtInputFrameOrMicroFrame;
    LARGE_INTEGER QueryPerformanceCounterFrequency;
    uint PredictedAccuracyInMicroSeconds;
    uint CurrentGenerationID;
    LARGE_INTEGER CurrentQueryPerformanceCounter;
    uint CurrentHardwareFrameNumber;
    uint CurrentHardwareMicroFrameNumber;
    uint CurrentUSBFrameNumber;
}

@DllImport("WINUSB.dll")
BOOL WinUsb_Initialize(HANDLE DeviceHandle, void** InterfaceHandle);

@DllImport("WINUSB.dll")
BOOL WinUsb_Free(void* InterfaceHandle);

@DllImport("WINUSB.dll")
BOOL WinUsb_GetAssociatedInterface(void* InterfaceHandle, ubyte AssociatedInterfaceIndex, void** AssociatedInterfaceHandle);

@DllImport("WINUSB.dll")
BOOL WinUsb_GetDescriptor(void* InterfaceHandle, ubyte DescriptorType, ubyte Index, ushort LanguageID, char* Buffer, uint BufferLength, uint* LengthTransferred);

@DllImport("WINUSB.dll")
BOOL WinUsb_QueryInterfaceSettings(void* InterfaceHandle, ubyte AlternateInterfaceNumber, USB_INTERFACE_DESCRIPTOR* UsbAltInterfaceDescriptor);

@DllImport("WINUSB.dll")
BOOL WinUsb_QueryDeviceInformation(void* InterfaceHandle, uint InformationType, uint* BufferLength, char* Buffer);

@DllImport("WINUSB.dll")
BOOL WinUsb_SetCurrentAlternateSetting(void* InterfaceHandle, ubyte SettingNumber);

@DllImport("WINUSB.dll")
BOOL WinUsb_GetCurrentAlternateSetting(void* InterfaceHandle, ubyte* SettingNumber);

@DllImport("WINUSB.dll")
BOOL WinUsb_QueryPipe(void* InterfaceHandle, ubyte AlternateInterfaceNumber, ubyte PipeIndex, WINUSB_PIPE_INFORMATION* PipeInformation);

@DllImport("WINUSB.dll")
BOOL WinUsb_QueryPipeEx(void* InterfaceHandle, ubyte AlternateSettingNumber, ubyte PipeIndex, WINUSB_PIPE_INFORMATION_EX* PipeInformationEx);

@DllImport("WINUSB.dll")
BOOL WinUsb_SetPipePolicy(void* InterfaceHandle, ubyte PipeID, uint PolicyType, uint ValueLength, char* Value);

@DllImport("WINUSB.dll")
BOOL WinUsb_GetPipePolicy(void* InterfaceHandle, ubyte PipeID, uint PolicyType, uint* ValueLength, char* Value);

@DllImport("WINUSB.dll")
BOOL WinUsb_ReadPipe(void* InterfaceHandle, ubyte PipeID, char* Buffer, uint BufferLength, uint* LengthTransferred, OVERLAPPED* Overlapped);

@DllImport("WINUSB.dll")
BOOL WinUsb_WritePipe(void* InterfaceHandle, ubyte PipeID, char* Buffer, uint BufferLength, uint* LengthTransferred, OVERLAPPED* Overlapped);

@DllImport("WINUSB.dll")
BOOL WinUsb_ControlTransfer(void* InterfaceHandle, WINUSB_SETUP_PACKET SetupPacket, char* Buffer, uint BufferLength, uint* LengthTransferred, OVERLAPPED* Overlapped);

@DllImport("WINUSB.dll")
BOOL WinUsb_ResetPipe(void* InterfaceHandle, ubyte PipeID);

@DllImport("WINUSB.dll")
BOOL WinUsb_AbortPipe(void* InterfaceHandle, ubyte PipeID);

@DllImport("WINUSB.dll")
BOOL WinUsb_FlushPipe(void* InterfaceHandle, ubyte PipeID);

@DllImport("WINUSB.dll")
BOOL WinUsb_SetPowerPolicy(void* InterfaceHandle, uint PolicyType, uint ValueLength, char* Value);

@DllImport("WINUSB.dll")
BOOL WinUsb_GetPowerPolicy(void* InterfaceHandle, uint PolicyType, uint* ValueLength, char* Value);

@DllImport("WINUSB.dll")
BOOL WinUsb_GetOverlappedResult(void* InterfaceHandle, OVERLAPPED* lpOverlapped, uint* lpNumberOfBytesTransferred, BOOL bWait);

@DllImport("WINUSB.dll")
USB_INTERFACE_DESCRIPTOR* WinUsb_ParseConfigurationDescriptor(USB_CONFIGURATION_DESCRIPTOR* ConfigurationDescriptor, void* StartPosition, int InterfaceNumber, int AlternateSetting, int InterfaceClass, int InterfaceSubClass, int InterfaceProtocol);

@DllImport("WINUSB.dll")
USB_COMMON_DESCRIPTOR* WinUsb_ParseDescriptors(char* DescriptorBuffer, uint TotalLength, void* StartPosition, int DescriptorType);

@DllImport("WINUSB.dll")
BOOL WinUsb_GetCurrentFrameNumber(void* InterfaceHandle, uint* CurrentFrameNumber, LARGE_INTEGER* TimeStamp);

@DllImport("WINUSB.dll")
BOOL WinUsb_GetAdjustedFrameNumber(uint* CurrentFrameNumber, LARGE_INTEGER TimeStamp);

@DllImport("WINUSB.dll")
BOOL WinUsb_RegisterIsochBuffer(void* InterfaceHandle, ubyte PipeID, char* Buffer, uint BufferLength, void** IsochBufferHandle);

@DllImport("WINUSB.dll")
BOOL WinUsb_UnregisterIsochBuffer(void* IsochBufferHandle);

@DllImport("WINUSB.dll")
BOOL WinUsb_WriteIsochPipe(void* BufferHandle, uint Offset, uint Length, uint* FrameNumber, OVERLAPPED* Overlapped);

@DllImport("WINUSB.dll")
BOOL WinUsb_ReadIsochPipe(void* BufferHandle, uint Offset, uint Length, uint* FrameNumber, uint NumberOfPackets, char* IsoPacketDescriptors, OVERLAPPED* Overlapped);

@DllImport("WINUSB.dll")
BOOL WinUsb_WriteIsochPipeAsap(void* BufferHandle, uint Offset, uint Length, BOOL ContinueStream, OVERLAPPED* Overlapped);

@DllImport("WINUSB.dll")
BOOL WinUsb_ReadIsochPipeAsap(void* BufferHandle, uint Offset, uint Length, BOOL ContinueStream, uint NumberOfPackets, char* IsoPacketDescriptors, OVERLAPPED* Overlapped);

@DllImport("WINUSB.dll")
BOOL WinUsb_StartTrackingForTimeSync(void* InterfaceHandle, USB_START_TRACKING_FOR_TIME_SYNC_INFORMATION* StartTrackingInfo);

@DllImport("WINUSB.dll")
BOOL WinUsb_GetCurrentFrameNumberAndQpc(void* InterfaceHandle, USB_FRAME_NUMBER_AND_QPC_FOR_TIME_SYNC_INFORMATION* FrameQpcInfo);

@DllImport("WINUSB.dll")
BOOL WinUsb_StopTrackingForTimeSync(void* InterfaceHandle, USB_STOP_TRACKING_FOR_TIME_SYNC_INFORMATION* StopTrackingInfo);

