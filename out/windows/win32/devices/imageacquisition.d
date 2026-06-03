// Written in the D programming language.

module windows.win32.devices.imageacquisition;

public import windows.core;
public import windows.win32.foundation : BOOL, BSTR, CHAR, FILETIME, HANDLE, HGLOBAL,
                                         HRESULT, HWND, PWSTR, RECT;
public import windows.win32.graphics.gdi : HBITMAP;
public import windows.win32.system.com : IStream, IUnknown, STGMEDIUM;
public import windows.win32.system.com.structuredstorage : IEnumSTATPROPSTG, PROPSPEC, PROPVARIANT,
                                                           STATPROPSETSTG;
public import windows.win32.system.variant : VARENUM;
public import windows.win32.ui.windowsandmessaging : HICON;

extern(Windows) @nogc nothrow:


// Enums


// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wiavideo/ne-wiavideo-wiavideo_state
alias WIAVIDEO_STATE = int;
enum : int
{
    WIAVIDEO_NO_VIDEO         = 0x00000001,
    WIAVIDEO_CREATING_VIDEO   = 0x00000002,
    WIAVIDEO_VIDEO_CREATED    = 0x00000003,
    WIAVIDEO_VIDEO_PLAYING    = 0x00000004,
    WIAVIDEO_VIDEO_PAUSED     = 0x00000005,
    WIAVIDEO_DESTROYING_VIDEO = 0x00000006,
}

// Constants


enum uint WIA_DIP_DEV_ID = 0x00000002U;
enum const(wchar)* WIA_DIP_DEV_ID_STR = "Unique Device ID";
enum uint WIA_DIP_VEND_DESC = 0x00000003U;
enum const(wchar)* WIA_DIP_VEND_DESC_STR = "Manufacturer";
enum uint WIA_DIP_DEV_DESC = 0x00000004U;
enum const(wchar)* WIA_DIP_DEV_DESC_STR = "Description";
enum uint WIA_DIP_DEV_TYPE = 0x00000005U;
enum const(wchar)* WIA_DIP_DEV_TYPE_STR = "Type";
enum uint WIA_DIP_PORT_NAME = 0x00000006U;
enum const(wchar)* WIA_DIP_PORT_NAME_STR = "Port";
enum uint WIA_DIP_DEV_NAME = 0x00000007U;
enum const(wchar)* WIA_DIP_DEV_NAME_STR = "Name";
enum uint WIA_DIP_SERVER_NAME = 0x00000008U;
enum const(wchar)* WIA_DIP_SERVER_NAME_STR = "Server";
enum uint WIA_DIP_REMOTE_DEV_ID = 0x00000009U;
enum const(wchar)* WIA_DIP_REMOTE_DEV_ID_STR = "Remote Device ID";
enum uint WIA_DIP_UI_CLSID = 0x0000000aU;
enum const(wchar)* WIA_DIP_UI_CLSID_STR = "UI Class ID";
enum uint WIA_DIP_HW_CONFIG = 0x0000000bU;
enum const(wchar)* WIA_DIP_HW_CONFIG_STR = "Hardware Configuration";
enum uint WIA_DIP_BAUDRATE = 0x0000000cU;
enum const(wchar)* WIA_DIP_BAUDRATE_STR = "BaudRate";
enum uint WIA_DIP_STI_GEN_CAPABILITIES = 0x0000000dU;
enum const(wchar)* WIA_DIP_STI_GEN_CAPABILITIES_STR = "STI Generic Capabilities";
enum uint WIA_DIP_WIA_VERSION = 0x0000000eU;
enum const(wchar)* WIA_DIP_WIA_VERSION_STR = "WIA Version";
enum uint WIA_DIP_DRIVER_VERSION = 0x0000000fU;
enum const(wchar)* WIA_DIP_DRIVER_VERSION_STR = "Driver Version";
enum uint WIA_DIP_PNP_ID = 0x00000010U;
enum const(wchar)* WIA_DIP_PNP_ID_STR = "PnP ID String";
enum uint WIA_DIP_STI_DRIVER_VERSION = 0x00000011U;
enum const(wchar)* WIA_DIP_STI_DRIVER_VERSION_STR = "STI Driver Version";
enum uint WIA_DPA_FIRMWARE_VERSION = 0x00000402U;
enum const(wchar)* WIA_DPA_FIRMWARE_VERSION_STR = "Firmware Version";
enum uint WIA_DPA_CONNECT_STATUS = 0x00000403U;
enum const(wchar)* WIA_DPA_CONNECT_STATUS_STR = "Connect Status";
enum uint WIA_DPA_DEVICE_TIME = 0x00000404U;
enum const(wchar)* WIA_DPA_DEVICE_TIME_STR = "Device Time";
enum uint WIA_DPC_PICTURES_TAKEN = 0x00000802U;
enum const(wchar)* WIA_DPC_PICTURES_TAKEN_STR = "Pictures Taken";
enum uint WIA_DPC_PICTURES_REMAINING = 0x00000803U;
enum const(wchar)* WIA_DPC_PICTURES_REMAINING_STR = "Pictures Remaining";
enum uint WIA_DPC_EXPOSURE_MODE = 0x00000804U;
enum const(wchar)* WIA_DPC_EXPOSURE_MODE_STR = "Exposure Mode";
enum uint WIA_DPC_EXPOSURE_COMP = 0x00000805U;
enum const(wchar)* WIA_DPC_EXPOSURE_COMP_STR = "Exposure Compensation";
enum uint WIA_DPC_EXPOSURE_TIME = 0x00000806U;
enum const(wchar)* WIA_DPC_EXPOSURE_TIME_STR = "Exposure Time";
enum uint WIA_DPC_FNUMBER = 0x00000807U;
enum const(wchar)* WIA_DPC_FNUMBER_STR = "F Number";
enum uint WIA_DPC_FLASH_MODE = 0x00000808U;
enum const(wchar)* WIA_DPC_FLASH_MODE_STR = "Flash Mode";
enum uint WIA_DPC_FOCUS_MODE = 0x00000809U;
enum const(wchar)* WIA_DPC_FOCUS_MODE_STR = "Focus Mode";
enum uint WIA_DPC_FOCUS_MANUAL_DIST = 0x0000080aU;
enum const(wchar)* WIA_DPC_FOCUS_MANUAL_DIST_STR = "Focus Manual Dist";
enum uint WIA_DPC_ZOOM_POSITION = 0x0000080bU;
enum const(wchar)* WIA_DPC_ZOOM_POSITION_STR = "Zoom Position";
enum uint WIA_DPC_PAN_POSITION = 0x0000080cU;
enum const(wchar)* WIA_DPC_PAN_POSITION_STR = "Pan Position";
enum uint WIA_DPC_TILT_POSITION = 0x0000080dU;
enum const(wchar)* WIA_DPC_TILT_POSITION_STR = "Tilt Position";
enum uint WIA_DPC_TIMER_MODE = 0x0000080eU;
enum const(wchar)* WIA_DPC_TIMER_MODE_STR = "Timer Mode";
enum uint WIA_DPC_TIMER_VALUE = 0x0000080fU;
enum const(wchar)* WIA_DPC_TIMER_VALUE_STR = "Timer Value";
enum uint WIA_DPC_POWER_MODE = 0x00000810U;
enum const(wchar)* WIA_DPC_POWER_MODE_STR = "Power Mode";
enum uint WIA_DPC_BATTERY_STATUS = 0x00000811U;
enum const(wchar)* WIA_DPC_BATTERY_STATUS_STR = "Battery Status";
enum uint WIA_DPC_THUMB_WIDTH = 0x00000812U;
enum const(wchar)* WIA_DPC_THUMB_WIDTH_STR = "Thumbnail Width";
enum uint WIA_DPC_THUMB_HEIGHT = 0x00000813U;
enum const(wchar)* WIA_DPC_THUMB_HEIGHT_STR = "Thumbnail Height";
enum uint WIA_DPC_PICT_WIDTH = 0x00000814U;
enum const(wchar)* WIA_DPC_PICT_WIDTH_STR = "Picture Width";
enum uint WIA_DPC_PICT_HEIGHT = 0x00000815U;
enum const(wchar)* WIA_DPC_PICT_HEIGHT_STR = "Picture Height";
enum uint WIA_DPC_DIMENSION = 0x00000816U;
enum const(wchar)* WIA_DPC_DIMENSION_STR = "Dimension";
enum uint WIA_DPC_COMPRESSION_SETTING = 0x00000817U;
enum const(wchar)* WIA_DPC_COMPRESSION_SETTING_STR = "Compression Setting";
enum uint WIA_DPC_FOCUS_METERING = 0x00000818U;
enum const(wchar)* WIA_DPC_FOCUS_METERING_STR = "Focus Metering Mode";
enum uint WIA_DPC_TIMELAPSE_INTERVAL = 0x00000819U;
enum const(wchar)* WIA_DPC_TIMELAPSE_INTERVAL_STR = "Timelapse Interval";
enum uint WIA_DPC_TIMELAPSE_NUMBER = 0x0000081aU;
enum const(wchar)* WIA_DPC_TIMELAPSE_NUMBER_STR = "Timelapse Number";
enum uint WIA_DPC_BURST_INTERVAL = 0x0000081bU;
enum const(wchar)* WIA_DPC_BURST_INTERVAL_STR = "Burst Interval";
enum uint WIA_DPC_BURST_NUMBER = 0x0000081cU;
enum const(wchar)* WIA_DPC_BURST_NUMBER_STR = "Burst Number";
enum uint WIA_DPC_EFFECT_MODE = 0x0000081dU;
enum const(wchar)* WIA_DPC_EFFECT_MODE_STR = "Effect Mode";
enum uint WIA_DPC_DIGITAL_ZOOM = 0x0000081eU;
enum const(wchar)* WIA_DPC_DIGITAL_ZOOM_STR = "Digital Zoom";
enum uint WIA_DPC_SHARPNESS = 0x0000081fU;
enum const(wchar)* WIA_DPC_SHARPNESS_STR = "Sharpness";
enum uint WIA_DPC_CONTRAST = 0x00000820U;
enum const(wchar)* WIA_DPC_CONTRAST_STR = "Contrast";
enum uint WIA_DPC_CAPTURE_MODE = 0x00000821U;
enum const(wchar)* WIA_DPC_CAPTURE_MODE_STR = "Capture Mode";
enum uint WIA_DPC_CAPTURE_DELAY = 0x00000822U;
enum const(wchar)* WIA_DPC_CAPTURE_DELAY_STR = "Capture Delay";
enum uint WIA_DPC_EXPOSURE_INDEX = 0x00000823U;
enum const(wchar)* WIA_DPC_EXPOSURE_INDEX_STR = "Exposure Index";
enum uint WIA_DPC_EXPOSURE_METERING_MODE = 0x00000824U;
enum const(wchar)* WIA_DPC_EXPOSURE_METERING_MODE_STR = "Exposure Metering Mode";
enum uint WIA_DPC_FOCUS_METERING_MODE = 0x00000825U;
enum const(wchar)* WIA_DPC_FOCUS_METERING_MODE_STR = "Focus Metering Mode";
enum uint WIA_DPC_FOCUS_DISTANCE = 0x00000826U;
enum const(wchar)* WIA_DPC_FOCUS_DISTANCE_STR = "Focus Distance";
enum uint WIA_DPC_FOCAL_LENGTH = 0x00000827U;
enum const(wchar)* WIA_DPC_FOCAL_LENGTH_STR = "Focus Length";
enum uint WIA_DPC_RGB_GAIN = 0x00000828U;
enum const(wchar)* WIA_DPC_RGB_GAIN_STR = "RGB Gain";
enum uint WIA_DPC_WHITE_BALANCE = 0x00000829U;
enum const(wchar)* WIA_DPC_WHITE_BALANCE_STR = "White Balance";
enum uint WIA_DPC_UPLOAD_URL = 0x0000082aU;
enum const(wchar)* WIA_DPC_UPLOAD_URL_STR = "Upload URL";
enum uint WIA_DPC_ARTIST = 0x0000082bU;
enum const(wchar)* WIA_DPC_ARTIST_STR = "Artist";
enum uint WIA_DPC_COPYRIGHT_INFO = 0x0000082cU;
enum const(wchar)* WIA_DPC_COPYRIGHT_INFO_STR = "Copyright Info";
enum uint WIA_DPS_HORIZONTAL_BED_SIZE = 0x00000c02U;
enum const(wchar)* WIA_DPS_HORIZONTAL_BED_SIZE_STR = "Horizontal Bed Size";
enum uint WIA_DPS_VERTICAL_BED_SIZE = 0x00000c03U;
enum const(wchar)* WIA_DPS_VERTICAL_BED_SIZE_STR = "Vertical Bed Size";
enum uint WIA_DPS_HORIZONTAL_SHEET_FEED_SIZE = 0x00000c04U;
enum const(wchar)* WIA_DPS_HORIZONTAL_SHEET_FEED_SIZE_STR = "Horizontal Sheet Feed Size";
enum uint WIA_DPS_VERTICAL_SHEET_FEED_SIZE = 0x00000c05U;
enum const(wchar)* WIA_DPS_VERTICAL_SHEET_FEED_SIZE_STR = "Vertical Sheet Feed Size";
enum uint WIA_DPS_SHEET_FEEDER_REGISTRATION = 0x00000c06U;
enum const(wchar)* WIA_DPS_SHEET_FEEDER_REGISTRATION_STR = "Sheet Feeder Registration";
enum uint WIA_DPS_HORIZONTAL_BED_REGISTRATION = 0x00000c07U;
enum const(wchar)* WIA_DPS_HORIZONTAL_BED_REGISTRATION_STR = "Horizontal Bed Registration";
enum uint WIA_DPS_VERTICAL_BED_REGISTRATION = 0x00000c08U;
enum const(wchar)* WIA_DPS_VERTICAL_BED_REGISTRATION_STR = "Vertical Bed Registration";
enum uint WIA_DPS_PLATEN_COLOR = 0x00000c09U;
enum const(wchar)* WIA_DPS_PLATEN_COLOR_STR = "Platen Color";
enum uint WIA_DPS_PAD_COLOR = 0x00000c0aU;
enum const(wchar)* WIA_DPS_PAD_COLOR_STR = "Pad Color";
enum uint WIA_DPS_FILTER_SELECT = 0x00000c0bU;
enum const(wchar)* WIA_DPS_FILTER_SELECT_STR = "Filter Select";
enum uint WIA_DPS_DITHER_SELECT = 0x00000c0cU;
enum const(wchar)* WIA_DPS_DITHER_SELECT_STR = "Dither Select";
enum uint WIA_DPS_DITHER_PATTERN_DATA = 0x00000c0dU;
enum const(wchar)* WIA_DPS_DITHER_PATTERN_DATA_STR = "Dither Pattern Data";
enum uint WIA_DPS_DOCUMENT_HANDLING_CAPABILITIES = 0x00000c0eU;
enum const(wchar)* WIA_DPS_DOCUMENT_HANDLING_CAPABILITIES_STR = "Document Handling Capabilities";
enum uint WIA_DPS_DOCUMENT_HANDLING_STATUS = 0x00000c0fU;
enum const(wchar)* WIA_DPS_DOCUMENT_HANDLING_STATUS_STR = "Document Handling Status";
enum uint WIA_DPS_DOCUMENT_HANDLING_SELECT = 0x00000c10U;
enum const(wchar)* WIA_DPS_DOCUMENT_HANDLING_SELECT_STR = "Document Handling Select";
enum uint WIA_DPS_DOCUMENT_HANDLING_CAPACITY = 0x00000c11U;
enum const(wchar)* WIA_DPS_DOCUMENT_HANDLING_CAPACITY_STR = "Document Handling Capacity";
enum uint WIA_DPS_OPTICAL_XRES = 0x00000c12U;
enum const(wchar)* WIA_DPS_OPTICAL_XRES_STR = "Horizontal Optical Resolution";
enum uint WIA_DPS_OPTICAL_YRES = 0x00000c13U;
enum const(wchar)* WIA_DPS_OPTICAL_YRES_STR = "Vertical Optical Resolution";
enum uint WIA_DPS_ENDORSER_CHARACTERS = 0x00000c14U;
enum const(wchar)* WIA_DPS_ENDORSER_CHARACTERS_STR = "Endorser Characters";
enum uint WIA_DPS_ENDORSER_STRING = 0x00000c15U;
enum const(wchar)* WIA_DPS_ENDORSER_STRING_STR = "Endorser String";
enum uint WIA_DPS_SCAN_AHEAD_PAGES = 0x00000c16U;
enum const(wchar)* WIA_DPS_SCAN_AHEAD_PAGES_STR = "Scan Ahead Pages";
enum uint WIA_DPS_MAX_SCAN_TIME = 0x00000c17U;
enum const(wchar)* WIA_DPS_MAX_SCAN_TIME_STR = "Max Scan Time";
enum uint WIA_DPS_PAGES = 0x00000c18U;
enum const(wchar)* WIA_DPS_PAGES_STR = "Pages";
enum uint WIA_DPS_PAGE_SIZE = 0x00000c19U;
enum const(wchar)* WIA_DPS_PAGE_SIZE_STR = "Page Size";
enum uint WIA_DPS_PAGE_WIDTH = 0x00000c1aU;
enum const(wchar)* WIA_DPS_PAGE_WIDTH_STR = "Page Width";
enum uint WIA_DPS_PAGE_HEIGHT = 0x00000c1bU;
enum const(wchar)* WIA_DPS_PAGE_HEIGHT_STR = "Page Height";
enum uint WIA_DPS_PREVIEW = 0x00000c1cU;
enum const(wchar)* WIA_DPS_PREVIEW_STR = "Preview";
enum uint WIA_DPS_TRANSPARENCY = 0x00000c1dU;
enum const(wchar)* WIA_DPS_TRANSPARENCY_STR = "Transparency Adapter";
enum uint WIA_DPS_TRANSPARENCY_SELECT = 0x00000c1eU;
enum const(wchar)* WIA_DPS_TRANSPARENCY_SELECT_STR = "Transparency Adapter Select";
enum uint WIA_DPS_SHOW_PREVIEW_CONTROL = 0x00000c1fU;
enum const(wchar)* WIA_DPS_SHOW_PREVIEW_CONTROL_STR = "Show preview control";
enum uint WIA_DPS_MIN_HORIZONTAL_SHEET_FEED_SIZE = 0x00000c20U;
enum const(wchar)* WIA_DPS_MIN_HORIZONTAL_SHEET_FEED_SIZE_STR = "Minimum Horizontal Sheet Feed Size";
enum uint WIA_DPS_MIN_VERTICAL_SHEET_FEED_SIZE = 0x00000c21U;
enum const(wchar)* WIA_DPS_MIN_VERTICAL_SHEET_FEED_SIZE_STR = "Minimum Vertical Sheet Feed Size";
enum uint WIA_DPS_TRANSPARENCY_CAPABILITIES = 0x00000c22U;
enum const(wchar)* WIA_DPS_TRANSPARENCY_CAPABILITIES_STR = "Transparency Adapter Capabilities";
enum uint WIA_DPS_TRANSPARENCY_STATUS = 0x00000c23U;
enum const(wchar)* WIA_DPS_TRANSPARENCY_STATUS_STR = "Transparency Adapter Status";
enum uint WIA_DPF_MOUNT_POINT = 0x00000d02U;
enum const(wchar)* WIA_DPF_MOUNT_POINT_STR = "Directory mount point";
enum uint WIA_DPV_LAST_PICTURE_TAKEN = 0x00000e02U;
enum const(wchar)* WIA_DPV_LAST_PICTURE_TAKEN_STR = "Last Picture Taken";
enum uint WIA_DPV_IMAGES_DIRECTORY = 0x00000e03U;
enum const(wchar)* WIA_DPV_IMAGES_DIRECTORY_STR = "Images Directory";
enum uint WIA_DPV_DSHOW_DEVICE_PATH = 0x00000e04U;
enum const(wchar)* WIA_DPV_DSHOW_DEVICE_PATH_STR = "Directshow Device Path";
enum uint WIA_IPA_ITEM_NAME = 0x00001002U;
enum const(wchar)* WIA_IPA_ITEM_NAME_STR = "Item Name";
enum uint WIA_IPA_FULL_ITEM_NAME = 0x00001003U;
enum const(wchar)* WIA_IPA_FULL_ITEM_NAME_STR = "Full Item Name";
enum uint WIA_IPA_ITEM_TIME = 0x00001004U;
enum const(wchar)* WIA_IPA_ITEM_TIME_STR = "Item Time Stamp";
enum uint WIA_IPA_ITEM_FLAGS = 0x00001005U;
enum const(wchar)* WIA_IPA_ITEM_FLAGS_STR = "Item Flags";
enum uint WIA_IPA_ACCESS_RIGHTS = 0x00001006U;
enum const(wchar)* WIA_IPA_ACCESS_RIGHTS_STR = "Access Rights";
enum uint WIA_IPA_DATATYPE = 0x00001007U;
enum const(wchar)* WIA_IPA_DATATYPE_STR = "Data Type";
enum uint WIA_IPA_DEPTH = 0x00001008U;
enum const(wchar)* WIA_IPA_DEPTH_STR = "Bits Per Pixel";
enum uint WIA_IPA_PREFERRED_FORMAT = 0x00001009U;
enum const(wchar)* WIA_IPA_PREFERRED_FORMAT_STR = "Preferred Format";
enum uint WIA_IPA_FORMAT = 0x0000100aU;
enum const(wchar)* WIA_IPA_FORMAT_STR = "Format";
enum uint WIA_IPA_COMPRESSION = 0x0000100bU;
enum const(wchar)* WIA_IPA_COMPRESSION_STR = "Compression";
enum uint WIA_IPA_TYMED = 0x0000100cU;
enum const(wchar)* WIA_IPA_TYMED_STR = "Media Type";
enum uint WIA_IPA_CHANNELS_PER_PIXEL = 0x0000100dU;
enum const(wchar)* WIA_IPA_CHANNELS_PER_PIXEL_STR = "Channels Per Pixel";
enum uint WIA_IPA_BITS_PER_CHANNEL = 0x0000100eU;
enum const(wchar)* WIA_IPA_BITS_PER_CHANNEL_STR = "Bits Per Channel";
enum uint WIA_IPA_PLANAR = 0x0000100fU;
enum const(wchar)* WIA_IPA_PLANAR_STR = "Planar";
enum uint WIA_IPA_PIXELS_PER_LINE = 0x00001010U;
enum const(wchar)* WIA_IPA_PIXELS_PER_LINE_STR = "Pixels Per Line";
enum uint WIA_IPA_BYTES_PER_LINE = 0x00001011U;
enum const(wchar)* WIA_IPA_BYTES_PER_LINE_STR = "Bytes Per Line";
enum uint WIA_IPA_NUMBER_OF_LINES = 0x00001012U;
enum const(wchar)* WIA_IPA_NUMBER_OF_LINES_STR = "Number of Lines";
enum uint WIA_IPA_GAMMA_CURVES = 0x00001013U;
enum const(wchar)* WIA_IPA_GAMMA_CURVES_STR = "Gamma Curves";
enum uint WIA_IPA_ITEM_SIZE = 0x00001014U;
enum const(wchar)* WIA_IPA_ITEM_SIZE_STR = "Item Size";
enum uint WIA_IPA_COLOR_PROFILE = 0x00001015U;
enum const(wchar)* WIA_IPA_COLOR_PROFILE_STR = "Color Profiles";
enum uint WIA_IPA_MIN_BUFFER_SIZE = 0x00001016U;
enum const(wchar)* WIA_IPA_MIN_BUFFER_SIZE_STR = "Buffer Size";
enum uint WIA_IPA_BUFFER_SIZE = 0x00001016U;
enum const(wchar)* WIA_IPA_BUFFER_SIZE_STR = "Buffer Size";
enum uint WIA_IPA_REGION_TYPE = 0x00001017U;
enum const(wchar)* WIA_IPA_REGION_TYPE_STR = "Region Type";
enum uint WIA_IPA_ICM_PROFILE_NAME = 0x00001018U;
enum const(wchar)* WIA_IPA_ICM_PROFILE_NAME_STR = "Color Profile Name";
enum uint WIA_IPA_APP_COLOR_MAPPING = 0x00001019U;
enum const(wchar)* WIA_IPA_APP_COLOR_MAPPING_STR = "Application Applies Color Mapping";
enum uint WIA_IPA_PROP_STREAM_COMPAT_ID = 0x0000101aU;
enum const(wchar)* WIA_IPA_PROP_STREAM_COMPAT_ID_STR = "Stream Compatibility ID";
enum uint WIA_IPA_FILENAME_EXTENSION = 0x0000101bU;
enum const(wchar)* WIA_IPA_FILENAME_EXTENSION_STR = "Filename extension";
enum uint WIA_IPA_SUPPRESS_PROPERTY_PAGE = 0x0000101cU;
enum const(wchar)* WIA_IPA_SUPPRESS_PROPERTY_PAGE_STR = "Suppress a property page";
enum uint WIA_IPC_THUMBNAIL = 0x00001402U;
enum const(wchar)* WIA_IPC_THUMBNAIL_STR = "Thumbnail Data";
enum uint WIA_IPC_THUMB_WIDTH = 0x00001403U;
enum const(wchar)* WIA_IPC_THUMB_WIDTH_STR = "Thumbnail Width";
enum uint WIA_IPC_THUMB_HEIGHT = 0x00001404U;
enum const(wchar)* WIA_IPC_THUMB_HEIGHT_STR = "Thumbnail Height";
enum uint WIA_IPC_AUDIO_AVAILABLE = 0x00001405U;
enum const(wchar)* WIA_IPC_AUDIO_AVAILABLE_STR = "Audio Available";
enum uint WIA_IPC_AUDIO_DATA_FORMAT = 0x00001406U;
enum const(wchar)* WIA_IPC_AUDIO_DATA_FORMAT_STR = "Audio Format";
enum uint WIA_IPC_AUDIO_DATA = 0x00001407U;
enum const(wchar)* WIA_IPC_AUDIO_DATA_STR = "Audio Data";
enum uint WIA_IPC_NUM_PICT_PER_ROW = 0x00001408U;
enum const(wchar)* WIA_IPC_NUM_PICT_PER_ROW_STR = "Pictures per Row";
enum uint WIA_IPC_SEQUENCE = 0x00001409U;
enum const(wchar)* WIA_IPC_SEQUENCE_STR = "Sequence Number";
enum uint WIA_IPC_TIMEDELAY = 0x0000140aU;
enum const(wchar)* WIA_IPC_TIMEDELAY_STR = "Time Delay";
enum uint WIA_IPS_CUR_INTENT = 0x00001802U;
enum const(wchar)* WIA_IPS_CUR_INTENT_STR = "Current Intent";
enum uint WIA_IPS_XRES = 0x00001803U;
enum const(wchar)* WIA_IPS_XRES_STR = "Horizontal Resolution";
enum uint WIA_IPS_YRES = 0x00001804U;
enum const(wchar)* WIA_IPS_YRES_STR = "Vertical Resolution";
enum uint WIA_IPS_XPOS = 0x00001805U;
enum const(wchar)* WIA_IPS_XPOS_STR = "Horizontal Start Position";
enum uint WIA_IPS_YPOS = 0x00001806U;
enum const(wchar)* WIA_IPS_YPOS_STR = "Vertical Start Position";
enum uint WIA_IPS_XEXTENT = 0x00001807U;
enum const(wchar)* WIA_IPS_XEXTENT_STR = "Horizontal Extent";
enum uint WIA_IPS_YEXTENT = 0x00001808U;
enum const(wchar)* WIA_IPS_YEXTENT_STR = "Vertical Extent";
enum uint WIA_IPS_PHOTOMETRIC_INTERP = 0x00001809U;
enum const(wchar)* WIA_IPS_PHOTOMETRIC_INTERP_STR = "Photometric Interpretation";
enum uint WIA_IPS_BRIGHTNESS = 0x0000180aU;
enum const(wchar)* WIA_IPS_BRIGHTNESS_STR = "Brightness";
enum uint WIA_IPS_CONTRAST = 0x0000180bU;
enum const(wchar)* WIA_IPS_CONTRAST_STR = "Contrast";
enum uint WIA_IPS_ORIENTATION = 0x0000180cU;
enum const(wchar)* WIA_IPS_ORIENTATION_STR = "Orientation";
enum uint WIA_IPS_ROTATION = 0x0000180dU;
enum const(wchar)* WIA_IPS_ROTATION_STR = "Rotation";
enum uint WIA_IPS_MIRROR = 0x0000180eU;
enum const(wchar)* WIA_IPS_MIRROR_STR = "Mirror";
enum uint WIA_IPS_THRESHOLD = 0x0000180fU;
enum const(wchar)* WIA_IPS_THRESHOLD_STR = "Threshold";
enum uint WIA_IPS_INVERT = 0x00001810U;
enum const(wchar)* WIA_IPS_INVERT_STR = "Invert";
enum uint WIA_IPS_WARM_UP_TIME = 0x00001811U;
enum const(wchar)* WIA_IPS_WARM_UP_TIME_STR = "Lamp Warm up Time";
enum uint WIA_DPS_USER_NAME = 0x00000c28U;
enum const(wchar)* WIA_DPS_USER_NAME_STR = "User Name";
enum uint WIA_DPS_SERVICE_ID = 0x00000c29U;
enum const(wchar)* WIA_DPS_SERVICE_ID_STR = "Service ID";
enum uint WIA_DPS_DEVICE_ID = 0x00000c2aU;
enum const(wchar)* WIA_DPS_DEVICE_ID_STR = "Device ID";
enum uint WIA_DPS_GLOBAL_IDENTITY = 0x00000c2bU;
enum const(wchar)* WIA_DPS_GLOBAL_IDENTITY_STR = "Global Identity";
enum uint WIA_DPS_SCAN_AVAILABLE_ITEM = 0x00000c2cU;
enum const(wchar)* WIA_DPS_SCAN_AVAILABLE_ITEM_STR = "Scan Available Item";
enum uint WIA_IPS_DESKEW_X = 0x00001812U;
enum const(wchar)* WIA_IPS_DESKEW_X_STR = "DeskewX";
enum uint WIA_IPS_DESKEW_Y = 0x00001813U;
enum const(wchar)* WIA_IPS_DESKEW_Y_STR = "DeskewY";
enum uint WIA_IPS_SEGMENTATION = 0x00001814U;
enum const(wchar)* WIA_IPS_SEGMENTATION_STR = "Segmentation";
enum const(wchar)* WIA_SEGMENTATION_FILTER_STR = "SegmentationFilter";
enum const(wchar)* WIA_IMAGEPROC_FILTER_STR = "ImageProcessingFilter";
enum uint WIA_IPS_MAX_HORIZONTAL_SIZE = 0x00001815U;
enum const(wchar)* WIA_IPS_MAX_HORIZONTAL_SIZE_STR = "Maximum Horizontal Scan Size";
enum uint WIA_IPS_MAX_VERTICAL_SIZE = 0x00001816U;
enum const(wchar)* WIA_IPS_MAX_VERTICAL_SIZE_STR = "Maximum Vertical Scan Size";
enum uint WIA_IPS_MIN_HORIZONTAL_SIZE = 0x00001817U;
enum const(wchar)* WIA_IPS_MIN_HORIZONTAL_SIZE_STR = "Minimum Horizontal Scan Size";
enum uint WIA_IPS_MIN_VERTICAL_SIZE = 0x00001818U;
enum const(wchar)* WIA_IPS_MIN_VERTICAL_SIZE_STR = "Minimum Vertical Scan Size";
enum uint WIA_IPS_TRANSFER_CAPABILITIES = 0x00001819U;
enum const(wchar)* WIA_IPS_TRANSFER_CAPABILITIES_STR = "Transfer Capabilities";
enum uint WIA_IPS_SHEET_FEEDER_REGISTRATION = 0x00000c06U;
enum const(wchar)* WIA_IPS_SHEET_FEEDER_REGISTRATION_STR = "Sheet Feeder Registration";
enum uint WIA_IPS_DOCUMENT_HANDLING_SELECT = 0x00000c10U;
enum const(wchar)* WIA_IPS_DOCUMENT_HANDLING_SELECT_STR = "Document Handling Select";
enum uint WIA_IPS_OPTICAL_XRES = 0x00000c12U;
enum const(wchar)* WIA_IPS_OPTICAL_XRES_STR = "Horizontal Optical Resolution";
enum uint WIA_IPS_OPTICAL_YRES = 0x00000c13U;
enum const(wchar)* WIA_IPS_OPTICAL_YRES_STR = "Vertical Optical Resolution";
enum uint WIA_IPS_PAGES = 0x00000c18U;
enum const(wchar)* WIA_IPS_PAGES_STR = "Pages";
enum uint WIA_IPS_PAGE_SIZE = 0x00000c19U;
enum const(wchar)* WIA_IPS_PAGE_SIZE_STR = "Page Size";
enum uint WIA_IPS_PAGE_WIDTH = 0x00000c1aU;
enum const(wchar)* WIA_IPS_PAGE_WIDTH_STR = "Page Width";
enum uint WIA_IPS_PAGE_HEIGHT = 0x00000c1bU;
enum const(wchar)* WIA_IPS_PAGE_HEIGHT_STR = "Page Height";
enum uint WIA_IPS_PREVIEW = 0x00000c1cU;
enum const(wchar)* WIA_IPS_PREVIEW_STR = "Preview";
enum uint WIA_IPS_SHOW_PREVIEW_CONTROL = 0x00000c1fU;
enum const(wchar)* WIA_IPS_SHOW_PREVIEW_CONTROL_STR = "Show preview control";
enum uint WIA_IPS_FILM_SCAN_MODE = 0x00000c20U;
enum const(wchar)* WIA_IPS_FILM_SCAN_MODE_STR = "Film Scan Mode";
enum uint WIA_IPS_LAMP = 0x00000c21U;
enum const(wchar)* WIA_IPS_LAMP_STR = "Lamp";
enum uint WIA_IPS_LAMP_AUTO_OFF = 0x00000c22U;
enum const(wchar)* WIA_IPS_LAMP_AUTO_OFF_STR = "Lamp Auto Off";
enum uint WIA_IPS_AUTO_DESKEW = 0x00000c23U;
enum const(wchar)* WIA_IPS_AUTO_DESKEW_STR = "Automatic Deskew";
enum uint WIA_IPS_SUPPORTS_CHILD_ITEM_CREATION = 0x00000c24U;
enum const(wchar)* WIA_IPS_SUPPORTS_CHILD_ITEM_CREATION_STR = "Supports Child Item Creation";
enum uint WIA_IPS_XSCALING = 0x00000c25U;
enum const(wchar)* WIA_IPS_XSCALING_STR = "Horizontal Scaling";
enum uint WIA_IPS_YSCALING = 0x00000c26U;
enum const(wchar)* WIA_IPS_YSCALING_STR = "Vertical Scaling";
enum uint WIA_IPS_PREVIEW_TYPE = 0x00000c27U;
enum const(wchar)* WIA_IPS_PREVIEW_TYPE_STR = "Preview Type";
enum uint WIA_IPA_ITEM_CATEGORY = 0x0000101dU;
enum const(wchar)* WIA_IPA_ITEM_CATEGORY_STR = "Item Category";
enum uint WIA_IPA_UPLOAD_ITEM_SIZE = 0x0000101eU;
enum const(wchar)* WIA_IPA_UPLOAD_ITEM_SIZE_STR = "Upload Item Size";
enum uint WIA_IPA_ITEMS_STORED = 0x0000101fU;
enum const(wchar)* WIA_IPA_ITEMS_STORED_STR = "Items Stored";
enum uint WIA_IPA_RAW_BITS_PER_CHANNEL = 0x00001020U;
enum const(wchar)* WIA_IPA_RAW_BITS_PER_CHANNEL_STR = "Raw Bits Per Channel";
enum uint WIA_IPS_FILM_NODE_NAME = 0x00001021U;
enum const(wchar)* WIA_IPS_FILM_NODE_NAME_STR = "Film Node Name";
enum uint WIA_IPS_PRINTER_ENDORSER = 0x00001022U;
enum const(wchar)* WIA_IPS_PRINTER_ENDORSER_STR = "Printer/Endorser";
enum uint WIA_IPS_PRINTER_ENDORSER_ORDER = 0x00001023U;
enum const(wchar)* WIA_IPS_PRINTER_ENDORSER_ORDER_STR = "Printer/Endorser Order";
enum uint WIA_IPS_PRINTER_ENDORSER_COUNTER = 0x00001024U;
enum const(wchar)* WIA_IPS_PRINTER_ENDORSER_COUNTER_STR = "Printer/Endorser Counter";
enum uint WIA_IPS_PRINTER_ENDORSER_STEP = 0x00001025U;
enum const(wchar)* WIA_IPS_PRINTER_ENDORSER_STEP_STR = "Printer/Endorser Step";
enum uint WIA_IPS_PRINTER_ENDORSER_XOFFSET = 0x00001026U;
enum const(wchar)* WIA_IPS_PRINTER_ENDORSER_XOFFSET_STR = "Printer/Endorser Horizontal Offset";
enum uint WIA_IPS_PRINTER_ENDORSER_YOFFSET = 0x00001027U;
enum const(wchar)* WIA_IPS_PRINTER_ENDORSER_YOFFSET_STR = "Printer/Endorser Vertical Offset";
enum uint WIA_IPS_PRINTER_ENDORSER_NUM_LINES = 0x00001028U;
enum const(wchar)* WIA_IPS_PRINTER_ENDORSER_NUM_LINES_STR = "Printer/Endorser Lines";
enum uint WIA_IPS_PRINTER_ENDORSER_STRING = 0x00001029U;
enum const(wchar)* WIA_IPS_PRINTER_ENDORSER_STRING_STR = "Printer/Endorser String";
enum uint WIA_IPS_PRINTER_ENDORSER_VALID_CHARACTERS = 0x0000102aU;
enum const(wchar)* WIA_IPS_PRINTER_ENDORSER_VALID_CHARACTERS_STR = "Printer/Endorser Valid Characters";
enum uint WIA_IPS_PRINTER_ENDORSER_VALID_FORMAT_SPECIFIERS = 0x0000102bU;
enum const(wchar)* WIA_IPS_PRINTER_ENDORSER_VALID_FORMAT_SPECIFIERS_STR = "Printer/Endorser Valid Format Specifiers";
enum uint WIA_IPS_PRINTER_ENDORSER_TEXT_UPLOAD = 0x0000102cU;
enum const(wchar)* WIA_IPS_PRINTER_ENDORSER_TEXT_UPLOAD_STR = "Printer/Endorser Text Upload";
enum uint WIA_IPS_PRINTER_ENDORSER_TEXT_DOWNLOAD = 0x0000102dU;
enum const(wchar)* WIA_IPS_PRINTER_ENDORSER_TEXT_DOWNLOAD_STR = "Printer/Endorser Text Download";
enum uint WIA_IPS_PRINTER_ENDORSER_GRAPHICS = 0x0000102eU;
enum const(wchar)* WIA_IPS_PRINTER_ENDORSER_GRAPHICS_STR = "Printer/Endorser Graphics";
enum uint WIA_IPS_PRINTER_ENDORSER_GRAPHICS_POSITION = 0x0000102fU;
enum const(wchar)* WIA_IPS_PRINTER_ENDORSER_GRAPHICS_POSITION_STR = "Printer/Endorser Graphics Position";
enum uint WIA_IPS_PRINTER_ENDORSER_GRAPHICS_MIN_WIDTH = 0x00001030U;
enum const(wchar)* WIA_IPS_PRINTER_ENDORSER_GRAPHICS_MIN_WIDTH_STR = "Printer/Endorser Graphics Minimum Width";
enum uint WIA_IPS_PRINTER_ENDORSER_GRAPHICS_MAX_WIDTH = 0x00001031U;
enum const(wchar)* WIA_IPS_PRINTER_ENDORSER_GRAPHICS_MAX_WIDTH_STR = "Printer/Endorser Graphics Maximum Width";
enum uint WIA_IPS_PRINTER_ENDORSER_GRAPHICS_MIN_HEIGHT = 0x00001032U;
enum const(wchar)* WIA_IPS_PRINTER_ENDORSER_GRAPHICS_MIN_HEIGHT_STR = "Printer/Endorser Graphics Minimum Height";
enum uint WIA_IPS_PRINTER_ENDORSER_GRAPHICS_MAX_HEIGHT = 0x00001033U;
enum const(wchar)* WIA_IPS_PRINTER_ENDORSER_GRAPHICS_MAX_HEIGHT_STR = "Printer/Endorser Graphics Maximum Height";
enum uint WIA_IPS_PRINTER_ENDORSER_GRAPHICS_UPLOAD = 0x00001034U;
enum const(wchar)* WIA_IPS_PRINTER_ENDORSER_GRAPHICS_UPLOAD_STR = "Printer/Endorser Graphics Upload";
enum uint WIA_IPS_PRINTER_ENDORSER_GRAPHICS_DOWNLOAD = 0x00001035U;
enum const(wchar)* WIA_IPS_PRINTER_ENDORSER_GRAPHICS_DOWNLOAD_STR = "Printer/Endorser Graphics Download";
enum uint WIA_IPS_BARCODE_READER = 0x00001036U;
enum const(wchar)* WIA_IPS_BARCODE_READER_STR = "Barcode Reader";
enum uint WIA_IPS_MAXIMUM_BARCODES_PER_PAGE = 0x00001037U;
enum const(wchar)* WIA_IPS_MAXIMUM_BARCODES_PER_PAGE_STR = "Maximum Barcodes Per Page";
enum uint WIA_IPS_BARCODE_SEARCH_DIRECTION = 0x00001038U;
enum const(wchar)* WIA_IPS_BARCODE_SEARCH_DIRECTION_STR = "Barcode Search Direction";
enum uint WIA_IPS_MAXIMUM_BARCODE_SEARCH_RETRIES = 0x00001039U;
enum const(wchar)* WIA_IPS_MAXIMUM_BARCODE_SEARCH_RETRIES_STR = "Barcode Search Retries";
enum uint WIA_IPS_BARCODE_SEARCH_TIMEOUT = 0x0000103aU;
enum const(wchar)* WIA_IPS_BARCODE_SEARCH_TIMEOUT_STR = "Barcode Search Timeout";
enum uint WIA_IPS_SUPPORTED_BARCODE_TYPES = 0x0000103bU;
enum const(wchar)* WIA_IPS_SUPPORTED_BARCODE_TYPES_STR = "Supported Barcode Types";
enum uint WIA_IPS_ENABLED_BARCODE_TYPES = 0x0000103cU;
enum const(wchar)* WIA_IPS_ENABLED_BARCODE_TYPES_STR = "Enabled Barcode Types";
enum uint WIA_IPS_PATCH_CODE_READER = 0x0000103dU;
enum const(wchar)* WIA_IPS_PATCH_CODE_READER_STR = "Patch Code Reader";
enum uint WIA_IPS_SUPPORTED_PATCH_CODE_TYPES = 0x00001042U;
enum const(wchar)* WIA_IPS_SUPPORTED_PATCH_CODE_TYPES_STR = "Supported Patch Code Types";
enum uint WIA_IPS_ENABLED_PATCH_CODE_TYPES = 0x00001043U;
enum const(wchar)* WIA_IPS_ENABLED_PATCH_CODE_TYPES_STR = "Enabled Path Code Types";
enum uint WIA_IPS_MICR_READER = 0x00001044U;
enum const(wchar)* WIA_IPS_MICR_READER_STR = "MICR Reader";
enum uint WIA_IPS_JOB_SEPARATORS = 0x00001045U;
enum const(wchar)* WIA_IPS_JOB_SEPARATORS_STR = "Job Separators";
enum uint WIA_IPS_LONG_DOCUMENT = 0x00001046U;
enum const(wchar)* WIA_IPS_LONG_DOCUMENT_STR = "Long Document";
enum uint WIA_IPS_BLANK_PAGES = 0x00001047U;
enum const(wchar)* WIA_IPS_BLANK_PAGES_STR = "Blank Pages";
enum uint WIA_IPS_MULTI_FEED = 0x00001048U;
enum const(wchar)* WIA_IPS_MULTI_FEED_STR = "Multi-Feed";
enum uint WIA_IPS_MULTI_FEED_SENSITIVITY = 0x00001049U;
enum const(wchar)* WIA_IPS_MULTI_FEED_SENSITIVITY_STR = "Multi-Feed Sensitivity";
enum uint WIA_IPS_AUTO_CROP = 0x0000104aU;
enum const(wchar)* WIA_IPS_AUTO_CROP_STR = "Auto-Crop";
enum uint WIA_IPS_OVER_SCAN = 0x0000104bU;
enum const(wchar)* WIA_IPS_OVER_SCAN_STR = "Overscan";
enum uint WIA_IPS_OVER_SCAN_LEFT = 0x0000104cU;
enum const(wchar)* WIA_IPS_OVER_SCAN_LEFT_STR = "Overscan Left";
enum uint WIA_IPS_OVER_SCAN_RIGHT = 0x0000104dU;
enum const(wchar)* WIA_IPS_OVER_SCAN_RIGHT_STR = "Overscan Right";
enum uint WIA_IPS_OVER_SCAN_TOP = 0x0000104eU;
enum const(wchar)* WIA_IPS_OVER_SCAN_TOP_STR = "Overscan Top";
enum uint WIA_IPS_OVER_SCAN_BOTTOM = 0x0000104fU;
enum const(wchar)* WIA_IPS_OVER_SCAN_BOTTOM_STR = "Overscan Bottom";
enum uint WIA_IPS_COLOR_DROP = 0x00001050U;
enum const(wchar)* WIA_IPS_COLOR_DROP_STR = "Color Drop";
enum uint WIA_IPS_COLOR_DROP_RED = 0x00001051U;
enum const(wchar)* WIA_IPS_COLOR_DROP_RED_STR = "Color Drop Red";
enum uint WIA_IPS_COLOR_DROP_GREEN = 0x00001052U;
enum const(wchar)* WIA_IPS_COLOR_DROP_GREEN_STR = "Color Drop Green";
enum uint WIA_IPS_COLOR_DROP_BLUE = 0x00001053U;
enum const(wchar)* WIA_IPS_COLOR_DROP_BLUE_STR = "Color Drop Blue";
enum uint WIA_IPS_SCAN_AHEAD = 0x00001054U;
enum const(wchar)* WIA_IPS_SCAN_AHEAD_STR = "Scan Ahead";
enum uint WIA_IPS_SCAN_AHEAD_CAPACITY = 0x00001055U;
enum const(wchar)* WIA_IPS_SCAN_AHEAD_CAPACITY_STR = "Scan Ahead Capacity";
enum uint WIA_IPS_FEEDER_CONTROL = 0x00001056U;
enum const(wchar)* WIA_IPS_FEEDER_CONTROL_STR = "Feeder Control";
enum uint WIA_IPS_PRINTER_ENDORSER_PADDING = 0x00001057U;
enum const(wchar)* WIA_IPS_PRINTER_ENDORSER_PADDING_STR = "Printer/Endorser Padding";
enum uint WIA_IPS_PRINTER_ENDORSER_FONT_TYPE = 0x00001058U;
enum const(wchar)* WIA_IPS_PRINTER_ENDORSER_FONT_TYPE_STR = "Printer/Endorser Font Type";
enum uint WIA_IPS_ALARM = 0x00001059U;
enum const(wchar)* WIA_IPS_ALARM_STR = "Alarm";
enum uint WIA_IPS_PRINTER_ENDORSER_INK = 0x0000105aU;
enum const(wchar)* WIA_IPS_PRINTER_ENDORSER_INK_STR = "Printer/Endorser Ink";
enum uint WIA_IPS_PRINTER_ENDORSER_CHARACTER_ROTATION = 0x0000105bU;
enum const(wchar)* WIA_IPS_PRINTER_ENDORSER_CHARACTER_ROTATION_STR = "Printer/Endorser Character Rotation";
enum uint WIA_IPS_PRINTER_ENDORSER_MAX_CHARACTERS = 0x0000105cU;
enum const(wchar)* WIA_IPS_PRINTER_ENDORSER_MAX_CHARACTERS_STR = "Printer/Endorser Maximum Characters";
enum uint WIA_IPS_PRINTER_ENDORSER_MAX_GRAPHICS = 0x0000105dU;
enum const(wchar)* WIA_IPS_PRINTER_ENDORSER_MAX_GRAPHICS_STR = "Printer/Endorser Maximum Graphics";
enum uint WIA_IPS_PRINTER_ENDORSER_COUNTER_DIGITS = 0x0000105eU;
enum const(wchar)* WIA_IPS_PRINTER_ENDORSER_COUNTER_DIGITS_STR = "Printer/Endorser Counter Digits";
enum uint WIA_IPS_COLOR_DROP_MULTI = 0x0000105fU;
enum const(wchar)* WIA_IPS_COLOR_DROP_MULTI_STR = "Color Drop Multiple";
enum uint WIA_IPS_BLANK_PAGES_SENSITIVITY = 0x00001060U;
enum const(wchar)* WIA_IPS_BLANK_PAGES_SENSITIVITY_STR = "Blank Pages Sensitivity";
enum uint WIA_IPS_MULTI_FEED_DETECT_METHOD = 0x00001061U;
enum const(wchar)* WIA_IPS_MULTI_FEED_DETECT_METHOD_STR = "Multi-Feed Detection Method";

enum : GUID
{
    WIA_CATEGORY_FINISHED_FILE     = GUID("ff2b77ca-cf84-432b-a735-3a130dde2a88"),
    WIA_CATEGORY_FLATBED           = GUID("fb607b1f-43f3-488b-855b-fb703ec342a6"),
    WIA_CATEGORY_FEEDER            = GUID("fe131934-f84c-42ad-8da4-6129cddd7288"),
    WIA_CATEGORY_FILM              = GUID("fcf65be7-3ce3-4473-af85-f5d37d21b68a"),
    WIA_CATEGORY_ROOT              = GUID("f193526f-59b8-4a26-9888-e16e4f97ce10"),
    WIA_CATEGORY_FOLDER            = GUID("c692a446-6f5a-481d-85bb-92e2e86fd30a"),
    WIA_CATEGORY_FEEDER_FRONT      = GUID("4823175c-3b28-487b-a7e6-eebc17614fd1"),
    WIA_CATEGORY_FEEDER_BACK       = GUID("61ca74d4-39db-42aa-89b1-8c19c9cd4c23"),
    WIA_CATEGORY_AUTO              = GUID("defe5fd8-6c97-4dde-b11e-cb509b270e11"),
    WIA_CATEGORY_IMPRINTER         = GUID("fc65016d-9202-43dd-91a7-64c2954cfb8b"),
    WIA_CATEGORY_ENDORSER          = GUID("47102cc3-127f-4771-adfc-991ab8ee1e97"),
    WIA_CATEGORY_BARCODE_READER    = GUID("36e178a0-473f-494b-af8f-6c3f6d7486fc"),
    WIA_CATEGORY_PATCH_CODE_READER = GUID("8faa1a6d-9c8a-42cd-98b3-ee9700cbc74f"),
    WIA_CATEGORY_MICR_READER       = GUID("3b86c1ec-71bc-4645-b4d5-1b19da2be978"),
}

enum GUID CLSID_WiaDefaultSegFilter = GUID("d4f4d30b-0b29-4508-8922-0c5797d42765");
enum uint WIA_TRANSFER_CHILDREN_SINGLE_SCAN = 0x00000001U;
enum uint WIA_USE_SEGMENTATION_FILTER = 0x00000000U;
enum uint WIA_DONT_USE_SEGMENTATION_FILTER = 0x00000001U;

enum : uint
{
    WIA_FILM_COLOR_SLIDE    = 0x00000000U,
    WIA_FILM_COLOR_NEGATIVE = 0x00000001U,
}

enum uint WIA_FILM_BW_NEGATIVE = 0x00000002U;

enum : uint
{
    WIA_LAMP_ON  = 0x00000000U,
    WIA_LAMP_OFF = 0x00000001U,
}

enum : uint
{
    WIA_AUTO_DESKEW_ON  = 0x00000000U,
    WIA_AUTO_DESKEW_OFF = 0x00000001U,
}

enum uint WIA_ADVANCED_PREVIEW = 0x00000000U;
enum uint WIA_BASIC_PREVIEW = 0x00000001U;

enum : uint
{
    WIA_PRINTER_ENDORSER_DISABLED      = 0x00000000U,
    WIA_PRINTER_ENDORSER_AUTO          = 0x00000001U,
    WIA_PRINTER_ENDORSER_FLATBED       = 0x00000002U,
    WIA_PRINTER_ENDORSER_FEEDER_FRONT  = 0x00000003U,
    WIA_PRINTER_ENDORSER_FEEDER_BACK   = 0x00000004U,
    WIA_PRINTER_ENDORSER_FEEDER_DUPLEX = 0x00000005U,
    WIA_PRINTER_ENDORSER_DIGITAL       = 0x00000006U,
    WIA_PRINTER_ENDORSER_BEFORE_SCAN   = 0x00000000U,
    WIA_PRINTER_ENDORSER_AFTER_SCAN    = 0x00000001U,
}

enum : uint
{
    WIA_PRINT_DATE           = 0x00000000U,
    WIA_PRINT_YEAR           = 0x00000001U,
    WIA_PRINT_MONTH          = 0x00000002U,
    WIA_PRINT_DAY            = 0x00000003U,
    WIA_PRINT_WEEK_DAY       = 0x00000004U,
    WIA_PRINT_TIME_24H       = 0x00000005U,
    WIA_PRINT_TIME_12H       = 0x00000006U,
    WIA_PRINT_HOUR_24H       = 0x00000007U,
    WIA_PRINT_HOUR_12H       = 0x00000008U,
    WIA_PRINT_AM_PM          = 0x00000009U,
    WIA_PRINT_MINUTE         = 0x0000000aU,
    WIA_PRINT_SECOND         = 0x0000000bU,
    WIA_PRINT_PAGE_COUNT     = 0x0000000cU,
    WIA_PRINT_IMAGE          = 0x0000000dU,
    WIA_PRINT_MILLISECOND    = 0x0000000eU,
    WIA_PRINT_MONTH_NAME     = 0x0000000fU,
    WIA_PRINT_MONTH_SHORT    = 0x00000010U,
    WIA_PRINT_WEEK_DAY_SHORT = 0x00000011U,
}

enum : uint
{
    WIA_PRINTER_ENDORSER_GRAPHICS_LEFT           = 0x00000000U,
    WIA_PRINTER_ENDORSER_GRAPHICS_RIGHT          = 0x00000001U,
    WIA_PRINTER_ENDORSER_GRAPHICS_TOP            = 0x00000002U,
    WIA_PRINTER_ENDORSER_GRAPHICS_BOTTOM         = 0x00000003U,
    WIA_PRINTER_ENDORSER_GRAPHICS_TOP_LEFT       = 0x00000004U,
    WIA_PRINTER_ENDORSER_GRAPHICS_TOP_RIGHT      = 0x00000005U,
    WIA_PRINTER_ENDORSER_GRAPHICS_BOTTOM_LEFT    = 0x00000006U,
    WIA_PRINTER_ENDORSER_GRAPHICS_BOTTOM_RIGHT   = 0x00000007U,
    WIA_PRINTER_ENDORSER_GRAPHICS_BACKGROUND     = 0x00000008U,
    WIA_PRINTER_ENDORSER_GRAPHICS_DEVICE_DEFAULT = 0x00000009U,
}

enum : uint
{
    WIA_BARCODE_READER_DISABLED      = 0x00000000U,
    WIA_BARCODE_READER_AUTO          = 0x00000001U,
    WIA_BARCODE_READER_FLATBED       = 0x00000002U,
    WIA_BARCODE_READER_FEEDER_FRONT  = 0x00000003U,
    WIA_BARCODE_READER_FEEDER_BACK   = 0x00000004U,
    WIA_BARCODE_READER_FEEDER_DUPLEX = 0x00000005U,
}

enum : uint
{
    WIA_BARCODE_HORIZONTAL_SEARCH          = 0x00000000U,
    WIA_BARCODE_VERTICAL_SEARCH            = 0x00000001U,
    WIA_BARCODE_HORIZONTAL_VERTICAL_SEARCH = 0x00000002U,
}

enum uint WIA_BARCODE_VERTICAL_HORIZONTAL_SEARCH = 0x00000003U;

enum : uint
{
    WIA_BARCODE_AUTO_SEARCH         = 0x00000004U,
    WIA_BARCODE_UPCA                = 0x00000000U,
    WIA_BARCODE_UPCE                = 0x00000001U,
    WIA_BARCODE_CODABAR             = 0x00000002U,
    WIA_BARCODE_NONINTERLEAVED_2OF5 = 0x00000003U,
}

enum : uint
{
    WIA_BARCODE_INTERLEAVED_2OF5    = 0x00000004U,
    WIA_BARCODE_CODE39              = 0x00000005U,
    WIA_BARCODE_CODE39_MOD43        = 0x00000006U,
    WIA_BARCODE_CODE39_FULLASCII    = 0x00000007U,
    WIA_BARCODE_CODE93              = 0x00000008U,
    WIA_BARCODE_CODE128             = 0x00000009U,
    WIA_BARCODE_CODE128A            = 0x0000000aU,
    WIA_BARCODE_CODE128B            = 0x0000000bU,
    WIA_BARCODE_CODE128C            = 0x0000000cU,
    WIA_BARCODE_GS1128              = 0x0000000dU,
    WIA_BARCODE_GS1DATABAR          = 0x0000000eU,
    WIA_BARCODE_ITF14               = 0x0000000fU,
    WIA_BARCODE_EAN8                = 0x00000010U,
    WIA_BARCODE_EAN13               = 0x00000011U,
    WIA_BARCODE_POSTNETA            = 0x00000012U,
    WIA_BARCODE_POSTNETB            = 0x00000013U,
    WIA_BARCODE_POSTNETC            = 0x00000014U,
    WIA_BARCODE_POSTNET_DPBC        = 0x00000015U,
    WIA_BARCODE_PLANET              = 0x00000016U,
    WIA_BARCODE_INTELLIGENT_MAIL    = 0x00000017U,
    WIA_BARCODE_POSTBAR             = 0x00000018U,
    WIA_BARCODE_RM4SCC              = 0x00000019U,
    WIA_BARCODE_HIGH_CAPACITY_COLOR = 0x0000001aU,
}

enum : uint
{
    WIA_BARCODE_MAXICODE   = 0x0000001bU,
    WIA_BARCODE_PDF417     = 0x0000001cU,
    WIA_BARCODE_CPCBINARY  = 0x0000001dU,
    WIA_BARCODE_FIM        = 0x0000001eU,
    WIA_BARCODE_PHARMACODE = 0x0000001fU,
    WIA_BARCODE_PLESSEY    = 0x00000020U,
    WIA_BARCODE_MSI        = 0x00000021U,
    WIA_BARCODE_JAN        = 0x00000022U,
    WIA_BARCODE_TELEPEN    = 0x00000023U,
    WIA_BARCODE_AZTEC      = 0x00000024U,
    WIA_BARCODE_SMALLAZTEC = 0x00000025U,
    WIA_BARCODE_DATAMATRIX = 0x00000026U,
    WIA_BARCODE_DATASTRIP  = 0x00000027U,
    WIA_BARCODE_EZCODE     = 0x00000028U,
    WIA_BARCODE_QRCODE     = 0x00000029U,
    WIA_BARCODE_SHOTCODE   = 0x0000002aU,
    WIA_BARCODE_SPARQCODE  = 0x0000002bU,
    WIA_BARCODE_CUSTOMBASE = 0x00008000U,
}

enum : uint
{
    WIA_PATCH_CODE_READER_DISABLED      = 0x00000000U,
    WIA_PATCH_CODE_READER_AUTO          = 0x00000001U,
    WIA_PATCH_CODE_READER_FLATBED       = 0x00000002U,
    WIA_PATCH_CODE_READER_FEEDER_FRONT  = 0x00000003U,
    WIA_PATCH_CODE_READER_FEEDER_BACK   = 0x00000004U,
    WIA_PATCH_CODE_READER_FEEDER_DUPLEX = 0x00000005U,
    WIA_PATCH_CODE_UNKNOWN              = 0x00000000U,
    WIA_PATCH_CODE_1                    = 0x00000001U,
    WIA_PATCH_CODE_2                    = 0x00000002U,
    WIA_PATCH_CODE_3                    = 0x00000003U,
    WIA_PATCH_CODE_4                    = 0x00000004U,
    WIA_PATCH_CODE_T                    = 0x00000005U,
    WIA_PATCH_CODE_6                    = 0x00000006U,
    WIA_PATCH_CODE_7                    = 0x00000007U,
    WIA_PATCH_CODE_8                    = 0x00000008U,
    WIA_PATCH_CODE_9                    = 0x00000009U,
    WIA_PATCH_CODE_10                   = 0x0000000aU,
    WIA_PATCH_CODE_11                   = 0x0000000bU,
    WIA_PATCH_CODE_12                   = 0x0000000cU,
    WIA_PATCH_CODE_13                   = 0x0000000dU,
    WIA_PATCH_CODE_14                   = 0x0000000eU,
    WIA_PATCH_CODE_CUSTOM_BASE          = 0x00008000U,
}

enum : uint
{
    WIA_MICR_READER_DISABLED      = 0x00000000U,
    WIA_MICR_READER_AUTO          = 0x00000001U,
    WIA_MICR_READER_FLATBED       = 0x00000002U,
    WIA_MICR_READER_FEEDER_FRONT  = 0x00000003U,
    WIA_MICR_READER_FEEDER_BACK   = 0x00000004U,
    WIA_MICR_READER_FEEDER_DUPLEX = 0x00000005U,
}

enum : uint
{
    WIA_SEPARATOR_DISABLED               = 0x00000000U,
    WIA_SEPARATOR_DETECT_SCAN_CONTINUE   = 0x00000001U,
    WIA_SEPARATOR_DETECT_SCAN_STOP       = 0x00000002U,
    WIA_SEPARATOR_DETECT_NOSCAN_CONTINUE = 0x00000003U,
    WIA_SEPARATOR_DETECT_NOSCAN_STOP     = 0x00000004U,
}

enum : uint
{
    WIA_LONG_DOCUMENT_DISABLED = 0x00000000U,
    WIA_LONG_DOCUMENT_ENABLED  = 0x00000001U,
    WIA_LONG_DOCUMENT_SPLIT    = 0x00000002U,
}

enum : uint
{
    WIA_BLANK_PAGE_DETECTION_DISABLED = 0x00000000U,
    WIA_BLANK_PAGE_DISCARD            = 0x00000001U,
    WIA_BLANK_PAGE_JOB_SEPARATOR      = 0x00000002U,
}

enum : uint
{
    WIA_MULTI_FEED_DETECT_DISABLED       = 0x00000000U,
    WIA_MULTI_FEED_DETECT_STOP_ERROR     = 0x00000001U,
    WIA_MULTI_FEED_DETECT_STOP_SUCCESS   = 0x00000002U,
    WIA_MULTI_FEED_DETECT_CONTINUE       = 0x00000003U,
    WIA_MULTI_FEED_DETECT_METHOD_LENGTH  = 0x00000000U,
    WIA_MULTI_FEED_DETECT_METHOD_OVERLAP = 0x00000001U,
}

enum : uint
{
    WIA_AUTO_CROP_DISABLED = 0x00000000U,
    WIA_AUTO_CROP_SINGLE   = 0x00000001U,
    WIA_AUTO_CROP_MULTI    = 0x00000002U,
}

enum : uint
{
    WIA_OVER_SCAN_DISABLED   = 0x00000000U,
    WIA_OVER_SCAN_TOP_BOTTOM = 0x00000001U,
    WIA_OVER_SCAN_LEFT_RIGHT = 0x00000002U,
    WIA_OVER_SCAN_ALL        = 0x00000003U,
}

enum : uint
{
    WIA_COLOR_DROP_DISABLED = 0x00000000U,
    WIA_COLOR_DROP_RED      = 0x00000001U,
    WIA_COLOR_DROP_GREEN    = 0x00000002U,
    WIA_COLOR_DROP_BLUE     = 0x00000003U,
    WIA_COLOR_DROP_RGB      = 0x00000004U,
}

enum : uint
{
    WIA_SCAN_AHEAD_DISABLED = 0x00000000U,
    WIA_SCAN_AHEAD_ENABLED  = 0x00000001U,
}

enum : uint
{
    WIA_FEEDER_CONTROL_AUTO   = 0x00000000U,
    WIA_FEEDER_CONTROL_MANUAL = 0x00000001U,
}

enum : uint
{
    WIA_PRINT_PADDING_NONE                 = 0x00000000U,
    WIA_PRINT_PADDING_ZERO                 = 0x00000001U,
    WIA_PRINT_PADDING_BLANK                = 0x00000002U,
    WIA_PRINT_FONT_NORMAL                  = 0x00000000U,
    WIA_PRINT_FONT_BOLD                    = 0x00000001U,
    WIA_PRINT_FONT_EXTRA_BOLD              = 0x00000002U,
    WIA_PRINT_FONT_ITALIC_BOLD             = 0x00000003U,
    WIA_PRINT_FONT_ITALIC_EXTRA_BOLD       = 0x00000004U,
    WIA_PRINT_FONT_ITALIC                  = 0x00000005U,
    WIA_PRINT_FONT_SMALL                   = 0x00000006U,
    WIA_PRINT_FONT_SMALL_BOLD              = 0x00000007U,
    WIA_PRINT_FONT_SMALL_EXTRA_BOLD        = 0x00000008U,
    WIA_PRINT_FONT_SMALL_ITALIC_BOLD       = 0x00000009U,
    WIA_PRINT_FONT_SMALL_ITALIC_EXTRA_BOLD = 0x0000000aU,
    WIA_PRINT_FONT_SMALL_ITALIC            = 0x0000000bU,
    WIA_PRINT_FONT_LARGE                   = 0x0000000cU,
    WIA_PRINT_FONT_LARGE_BOLD              = 0x0000000dU,
    WIA_PRINT_FONT_LARGE_EXTRA_BOLD        = 0x0000000eU,
    WIA_PRINT_FONT_LARGE_ITALIC_BOLD       = 0x0000000fU,
    WIA_PRINT_FONT_LARGE_ITALIC_EXTRA_BOLD = 0x00000010U,
    WIA_PRINT_FONT_LARGE_ITALIC            = 0x00000011U,
}

enum : uint
{
    WIA_ALARM_NONE   = 0x00000000U,
    WIA_ALARM_BEEP1  = 0x00000001U,
    WIA_ALARM_BEEP2  = 0x00000002U,
    WIA_ALARM_BEEP3  = 0x00000003U,
    WIA_ALARM_BEEP4  = 0x00000004U,
    WIA_ALARM_BEEP5  = 0x00000005U,
    WIA_ALARM_BEEP6  = 0x00000006U,
    WIA_ALARM_BEEP7  = 0x00000007U,
    WIA_ALARM_BEEP8  = 0x00000008U,
    WIA_ALARM_BEEP9  = 0x00000009U,
    WIA_ALARM_BEEP10 = 0x0000000aU,
}

enum : uint
{
    WIA_PRIVATE_DEVPROP  = 0x00009802U,
    WIA_PRIVATE_ITEMPROP = 0x00011802U,
}

enum : GUID
{
    WiaImgFmt_UNDEFINED = GUID("b96b3ca9-0728-11d3-9d7b-0000f81ef32e"),
    WiaImgFmt_RAWRGB    = GUID("bca48b55-f272-4371-b0f1-4a150d057bb4"),
    WiaImgFmt_MEMORYBMP = GUID("b96b3caa-0728-11d3-9d7b-0000f81ef32e"),
    WiaImgFmt_BMP       = GUID("b96b3cab-0728-11d3-9d7b-0000f81ef32e"),
    WiaImgFmt_EMF       = GUID("b96b3cac-0728-11d3-9d7b-0000f81ef32e"),
    WiaImgFmt_WMF       = GUID("b96b3cad-0728-11d3-9d7b-0000f81ef32e"),
    WiaImgFmt_JPEG      = GUID("b96b3cae-0728-11d3-9d7b-0000f81ef32e"),
    WiaImgFmt_PNG       = GUID("b96b3caf-0728-11d3-9d7b-0000f81ef32e"),
    WiaImgFmt_GIF       = GUID("b96b3cb0-0728-11d3-9d7b-0000f81ef32e"),
    WiaImgFmt_TIFF      = GUID("b96b3cb1-0728-11d3-9d7b-0000f81ef32e"),
    WiaImgFmt_EXIF      = GUID("b96b3cb2-0728-11d3-9d7b-0000f81ef32e"),
    WiaImgFmt_PHOTOCD   = GUID("b96b3cb3-0728-11d3-9d7b-0000f81ef32e"),
    WiaImgFmt_FLASHPIX  = GUID("b96b3cb4-0728-11d3-9d7b-0000f81ef32e"),
    WiaImgFmt_ICO       = GUID("b96b3cb5-0728-11d3-9d7b-0000f81ef32e"),
    WiaImgFmt_CIFF      = GUID("9821a8ab-3a7e-4215-94e0-d27a460c03b2"),
    WiaImgFmt_PICT      = GUID("a6bc85d8-6b3e-40ee-a95c-25d482e41adc"),
    WiaImgFmt_JPEG2K    = GUID("344ee2b2-39db-4dde-8173-c4b75f8f1e49"),
    WiaImgFmt_JPEG2KX   = GUID("43e14614-c80a-4850-baf3-4b152dc8da27"),
    WiaImgFmt_RAW       = GUID("6f120719-f1a8-4e07-9ade-9b64c63a3dcc"),
    WiaImgFmt_JBIG      = GUID("41e8dd92-2f0a-43d4-8636-f1614ba11e46"),
    WiaImgFmt_JBIG2     = GUID("bb8e7e67-283c-4235-9e59-0b9bf94ca687"),
    WiaImgFmt_RTF       = GUID("573dd6a3-4834-432d-a9b5-e198dd9e890d"),
    WiaImgFmt_XML       = GUID("b9171457-dac8-4884-b393-15b471d5f07e"),
    WiaImgFmt_HTML      = GUID("c99a4e62-99de-4a94-acca-71956ac2977d"),
    WiaImgFmt_TXT       = GUID("fafd4d82-723f-421f-9318-30501ac44b59"),
    WiaImgFmt_PDFA      = GUID("9980bd5b-3463-43c7-bdca-3caa146f229f"),
    WiaImgFmt_XPS       = GUID("700b4a0f-2011-411c-b430-d1e0b2e10b28"),
    WiaImgFmt_OXPS      = GUID("2c7b1240-c14d-4109-9755-04b89025153a"),
    WiaImgFmt_CSV       = GUID("355bda24-5a9f-4494-80dc-be752cecbc8c"),
    WiaImgFmt_MPG       = GUID("ecd757e4-d2ec-4f57-955d-bcf8a97c4e52"),
    WiaImgFmt_AVI       = GUID("32f8ca14-087c-4908-b7c4-6757fe7e90ab"),
}

enum : GUID
{
    WiaAudFmt_WAV  = GUID("f818e146-07af-40ff-ae55-be8f2c065dbe"),
    WiaAudFmt_MP3  = GUID("0fbc71fb-43bf-49f2-9190-e6fecff37e54"),
    WiaAudFmt_AIFF = GUID("66e2bf4f-b6fc-443f-94c8-2f33c8a65aaf"),
    WiaAudFmt_WMA  = GUID("d61d6413-8bc2-438f-93ad-21bd484db6a1"),
}

enum : GUID
{
    WiaImgFmt_ASF       = GUID("8d948ee9-d0aa-4a12-9d9a-9cc5de36199b"),
    WiaImgFmt_SCRIPT    = GUID("fe7d6c53-2dac-446a-b0bd-d73e21e924c9"),
    WiaImgFmt_EXEC      = GUID("485da097-141e-4aa5-bb3b-a5618d95d02b"),
    WiaImgFmt_UNICODE16 = GUID("1b7639b6-6357-47d1-9a07-12452dc073e9"),
    WiaImgFmt_DPOF      = GUID("369eeeab-a0e8-45ca-86a6-a83ce5697e28"),
    WiaImgFmt_XMLBAR    = GUID("6235701c-3a98-484c-b2a8-fdffd87e6b16"),
    WiaImgFmt_RAWBAR    = GUID("da63f833-d26e-451e-90d2-ea55a1365d62"),
    WiaImgFmt_XMLPAT    = GUID("f8986f55-f052-460d-9523-3a7dfedbb33c"),
    WiaImgFmt_RAWPAT    = GUID("7760507c-5064-400c-9a17-575624d8824b"),
    WiaImgFmt_XMLMIC    = GUID("2d164c61-b9ae-4b23-8973-c7067e1fbd31"),
    WiaImgFmt_RAWMIC    = GUID("22c4f058-0d88-409c-ac1c-eec12b0ea680"),
}

enum : GUID
{
    WIA_EVENT_DEVICE_DISCONNECTED = GUID("143e4e83-6497-11d2-a231-00c04fa31809"),
    WIA_EVENT_DEVICE_CONNECTED    = GUID("a28bbade-64b6-11d2-a231-00c04fa31809"),
}

enum : GUID
{
    WIA_EVENT_ITEM_DELETED       = GUID("1d22a559-e14f-11d2-b326-00c04f68ce61"),
    WIA_EVENT_ITEM_CREATED       = GUID("4c8f4ef5-e14f-11d2-b326-00c04f68ce61"),
    WIA_EVENT_TREE_UPDATED       = GUID("c9859b91-4ab2-4cd6-a1fc-582eec55e585"),
    WIA_EVENT_VOLUME_INSERT      = GUID("9638bbfd-d1bd-11d2-b31f-00c04f68ce61"),
    WIA_EVENT_SCAN_IMAGE         = GUID("a6c5a715-8c6e-11d2-977a-0000f87a926f"),
    WIA_EVENT_SCAN_PRINT_IMAGE   = GUID("b441f425-8c6e-11d2-977a-0000f87a926f"),
    WIA_EVENT_SCAN_FAX_IMAGE     = GUID("c00eb793-8c6e-11d2-977a-0000f87a926f"),
    WIA_EVENT_SCAN_OCR_IMAGE     = GUID("9d095b89-37d6-4877-afed-62a297dc6dbe"),
    WIA_EVENT_SCAN_EMAIL_IMAGE   = GUID("c686dcee-54f2-419e-9a27-2fc7f2e98f9e"),
    WIA_EVENT_SCAN_FILM_IMAGE    = GUID("9b2b662c-6185-438c-b68b-e39ee25e71cb"),
    WIA_EVENT_SCAN_IMAGE2        = GUID("fc4767c1-c8b3-48a2-9cfa-2e90cb3d3590"),
    WIA_EVENT_SCAN_IMAGE3        = GUID("154e27be-b617-4653-acc5-0fd7bd4c65ce"),
    WIA_EVENT_SCAN_IMAGE4        = GUID("a65b704a-7f3c-4447-a75d-8a26dfca1fdf"),
    WIA_EVENT_STORAGE_CREATED    = GUID("353308b2-fe73-46c8-895e-fa4551ccc85a"),
    WIA_EVENT_STORAGE_DELETED    = GUID("5e41e75e-9390-44c5-9a51-e47019e390cf"),
    WIA_EVENT_STI_PROXY          = GUID("d711f81f-1f0d-422d-8641-927d1b93e5e5"),
    WIA_EVENT_CANCEL_IO          = GUID("c860f7b8-9ccd-41ea-bbbf-4dd09c5b1795"),
    WIA_EVENT_POWER_SUSPEND      = GUID("a0922ff9-c3b4-411c-9e29-03a66993d2be"),
    WIA_EVENT_POWER_RESUME       = GUID("618f153e-f686-4350-9634-4115a304830c"),
    WIA_EVENT_HANDLER_NO_ACTION  = GUID("e0372b7d-e115-4525-bc55-b629e68c745a"),
    WIA_EVENT_HANDLER_PROMPT     = GUID("5f4baad0-4d59-4fcd-b213-783ce7a92f22"),
    WIA_EVENT_DEVICE_NOT_READY   = GUID("d8962d7e-e4dc-4b4d-ba29-668a87f42e6f"),
    WIA_EVENT_DEVICE_READY       = GUID("7523ec6c-988b-419e-9a0a-425ac31b37dc"),
    WIA_EVENT_FLATBED_LID_OPEN   = GUID("ba0a0623-437d-4f03-a97d-7793b123113c"),
    WIA_EVENT_FLATBED_LID_CLOSED = GUID("f879af0f-9b29-4283-ad95-d412164d39a9"),
}

enum : GUID
{
    WIA_EVENT_FEEDER_LOADED  = GUID("cc8d701e-9aba-481d-bf74-78f763dc342a"),
    WIA_EVENT_FEEDER_EMPTIED = GUID("e70b4b82-6dda-46bb-8ff9-53ceb1a03e35"),
    WIA_EVENT_COVER_OPEN     = GUID("19a12136-fa1c-4f66-900f-8f914ec74ec9"),
    WIA_EVENT_COVER_CLOSED   = GUID("6714a1e6-e285-468c-9b8c-da7dc4cbaa05"),
}

enum : GUID
{
    WIA_CMD_SYNCHRONIZE  = GUID("9b26b7b2-acad-11d2-a093-00c04f72dc3c"),
    WIA_CMD_TAKE_PICTURE = GUID("af933cac-acad-11d2-a093-00c04f72dc3c"),
}

enum GUID WIA_CMD_DELETE_ALL_ITEMS = GUID("e208c170-acad-11d2-a093-00c04f72dc3c");
enum GUID WIA_CMD_CHANGE_DOCUMENT = GUID("04e725b0-acae-11d2-a093-00c04f72dc3c");
enum GUID WIA_CMD_UNLOAD_DOCUMENT = GUID("1f3b3d8e-acae-11d2-a093-00c04f72dc3c");

enum : GUID
{
    WIA_CMD_DIAGNOSTIC         = GUID("10ff52f5-de04-4cf0-a5ad-691f8dce0141"),
    WIA_CMD_FORMAT             = GUID("c3a693aa-f788-4d34-a5b0-be7190759a24"),
    WIA_CMD_DELETE_DEVICE_TREE = GUID("73815942-dbea-11d2-8416-00c04fa36145"),
}

enum GUID WIA_CMD_BUILD_DEVICE_TREE = GUID("9cba5ce0-dbea-11d2-8416-00c04fa36145");

enum : GUID
{
    WIA_CMD_START_FEEDER = GUID("5a9df6c9-5f2d-4a39-9d6c-00456d047f00"),
    WIA_CMD_STOP_FEEDER  = GUID("d847b06d-3905-459c-9509-9b29cdb691e7"),
    WIA_CMD_PAUSE_FEEDER = GUID("50985e4d-a5b2-4b71-9c95-6d7d7c469a43"),
}

enum : uint
{
    BASE_VAL_WIA_ERROR   = 0x00000000U,
    BASE_VAL_WIA_SUCCESS = 0x00000000U,
}

enum : HRESULT
{
    WIA_ERROR_GENERAL_ERROR     = HRESULT(0x80210001),
    WIA_ERROR_PAPER_JAM         = HRESULT(0x80210002),
    WIA_ERROR_PAPER_EMPTY       = HRESULT(0x80210003),
    WIA_ERROR_PAPER_PROBLEM     = HRESULT(0x80210004),
    WIA_ERROR_OFFLINE           = HRESULT(0x80210005),
    WIA_ERROR_BUSY              = HRESULT(0x80210006),
    WIA_ERROR_WARMING_UP        = HRESULT(0x80210007),
    WIA_ERROR_USER_INTERVENTION = HRESULT(0x80210008),
}

enum : HRESULT
{
    WIA_ERROR_ITEM_DELETED         = HRESULT(0x80210009),
    WIA_ERROR_DEVICE_COMMUNICATION = HRESULT(0x8021000a),
}

enum : HRESULT
{
    WIA_ERROR_INVALID_COMMAND            = HRESULT(0x8021000b),
    WIA_ERROR_INCORRECT_HARDWARE_SETTING = HRESULT(0x8021000c),
}

enum : HRESULT
{
    WIA_ERROR_DEVICE_LOCKED       = HRESULT(0x8021000d),
    WIA_ERROR_EXCEPTION_IN_DRIVER = HRESULT(0x8021000e),
}

enum HRESULT WIA_ERROR_INVALID_DRIVER_RESPONSE = HRESULT(0x8021000f);

enum : HRESULT
{
    WIA_ERROR_COVER_OPEN                 = HRESULT(0x80210010),
    WIA_ERROR_LAMP_OFF                   = HRESULT(0x80210011),
    WIA_ERROR_DESTINATION                = HRESULT(0x80210012),
    WIA_ERROR_NETWORK_RESERVATION_FAILED = HRESULT(0x80210013),
}

enum : HRESULT
{
    WIA_ERROR_MULTI_FEED                       = HRESULT(0x80210014),
    WIA_ERROR_MAXIMUM_PRINTER_ENDORSER_COUNTER = HRESULT(0x80210015),
}

enum : HRESULT
{
    WIA_STATUS_END_OF_MEDIA             = HRESULT(0x00210001),
    WIA_STATUS_WARMING_UP               = HRESULT(0x00210002),
    WIA_STATUS_CALIBRATING              = HRESULT(0x00210003),
    WIA_STATUS_RESERVING_NETWORK_DEVICE = HRESULT(0x00210006),
}

enum HRESULT WIA_STATUS_NETWORK_DEVICE_RESERVED = HRESULT(0x00210007);

enum : HRESULT
{
    WIA_STATUS_CLEAR       = HRESULT(0x00210008),
    WIA_STATUS_SKIP_ITEM   = HRESULT(0x00210009),
    WIA_STATUS_NOT_HANDLED = HRESULT(0x0021000a),
}

enum HRESULT WIA_S_CHANGE_DEVICE = HRESULT(0x0021000b);
enum HRESULT WIA_S_NO_DEVICE_AVAILABLE = HRESULT(0x80210015);
enum uint WIA_SELECT_DEVICE_NODEFAULT = 0x00000001U;

enum : uint
{
    WIA_DEVICE_DIALOG_SINGLE_IMAGE  = 0x00000002U,
    WIA_DEVICE_DIALOG_USE_COMMON_UI = 0x00000004U,
}

enum uint WIA_REGISTER_EVENT_CALLBACK = 0x00000001U;
enum uint WIA_UNREGISTER_EVENT_CALLBACK = 0x00000002U;
enum uint WIA_SET_DEFAULT_HANDLER = 0x00000004U;
enum uint WIA_NOTIFICATION_EVENT = 0x00000001U;
enum uint WIA_ACTION_EVENT = 0x00000002U;

enum : uint
{
    WIA_LINE_ORDER_TOP_TO_BOTTOM = 0x00000001U,
    WIA_LINE_ORDER_BOTTOM_TO_TOP = 0x00000002U,
}

enum uint WIA_IS_DEFAULT_HANDLER = 0x00000001U;

enum : const(wchar)*
{
    WIA_EVENT_DEVICE_DISCONNECTED_STR = "Device Disconnected",
    WIA_EVENT_DEVICE_CONNECTED_STR    = "Device Connected",
}

enum : uint
{
    TYMED_CALLBACK           = 0x00000080U,
    TYMED_MULTIPAGE_FILE     = 0x00000100U,
    TYMED_MULTIPAGE_CALLBACK = 0x00000200U,
}

enum : uint
{
    IT_MSG_DATA_HEADER = 0x00000001U,
    IT_MSG_DATA        = 0x00000002U,
    IT_MSG_STATUS      = 0x00000003U,
    IT_MSG_TERMINATION = 0x00000004U,
}

enum : uint
{
    IT_MSG_NEW_PAGE                 = 0x00000005U,
    IT_MSG_FILE_PREVIEW_DATA        = 0x00000006U,
    IT_MSG_FILE_PREVIEW_DATA_HEADER = 0x00000007U,
}

enum uint IT_STATUS_TRANSFER_FROM_DEVICE = 0x00000001U;
enum uint IT_STATUS_PROCESSING_DATA = 0x00000002U;
enum uint IT_STATUS_TRANSFER_TO_CLIENT = 0x00000004U;
enum uint IT_STATUS_MASK = 0x00000007U;

enum : uint
{
    WIA_TRANSFER_ACQUIRE_CHILDREN    = 0x00000001U,
    WIA_TRANSFER_MSG_STATUS          = 0x00000001U,
    WIA_TRANSFER_MSG_END_OF_STREAM   = 0x00000002U,
    WIA_TRANSFER_MSG_END_OF_TRANSFER = 0x00000003U,
    WIA_TRANSFER_MSG_DEVICE_STATUS   = 0x00000005U,
    WIA_TRANSFER_MSG_NEW_PAGE        = 0x00000006U,
}

enum : uint
{
    WIA_MAJOR_EVENT_DEVICE_CONNECT    = 0x00000001U,
    WIA_MAJOR_EVENT_DEVICE_DISCONNECT = 0x00000002U,
    WIA_MAJOR_EVENT_PICTURE_TAKEN     = 0x00000003U,
    WIA_MAJOR_EVENT_PICTURE_DELETED   = 0x00000004U,
}

enum : uint
{
    WIA_DEVICE_NOT_CONNECTED = 0x00000000U,
    WIA_DEVICE_CONNECTED     = 0x00000001U,
    WIA_DEVICE_COMMANDS      = 0x00000001U,
    WIA_DEVICE_EVENTS        = 0x00000002U,
    WIA_DEVINFO_ENUM_ALL     = 0x0000000fU,
    WIA_DEVINFO_ENUM_LOCAL   = 0x00000010U,
}

enum : uint
{
    WiaItemTypeFree                   = 0x00000000U,
    WiaItemTypeImage                  = 0x00000001U,
    WiaItemTypeFile                   = 0x00000002U,
    WiaItemTypeFolder                 = 0x00000004U,
    WiaItemTypeRoot                   = 0x00000008U,
    WiaItemTypeAnalyze                = 0x00000010U,
    WiaItemTypeAudio                  = 0x00000020U,
    WiaItemTypeDevice                 = 0x00000040U,
    WiaItemTypeDeleted                = 0x00000080U,
    WiaItemTypeDisconnected           = 0x00000100U,
    WiaItemTypeHPanorama              = 0x00000200U,
    WiaItemTypeVPanorama              = 0x00000400U,
    WiaItemTypeBurst                  = 0x00000800U,
    WiaItemTypeStorage                = 0x00001000U,
    WiaItemTypeTransfer               = 0x00002000U,
    WiaItemTypeGenerated              = 0x00004000U,
    WiaItemTypeHasAttachments         = 0x00008000U,
    WiaItemTypeVideo                  = 0x00010000U,
    WiaItemTypeRemoved                = 0x80000000U,
    WiaItemTypeDocument               = 0x00040000U,
    WiaItemTypeProgrammableDataSource = 0x00080000U,
}

enum uint WiaItemTypeMask = 0x800fffffU;
enum uint WIA_MAX_CTX_SIZE = 0x01000000U;

enum : uint
{
    WIA_PROP_READ          = 0x00000001U,
    WIA_PROP_WRITE         = 0x00000002U,
    WIA_PROP_SYNC_REQUIRED = 0x00000004U,
    WIA_PROP_NONE          = 0x00000008U,
    WIA_PROP_RANGE         = 0x00000010U,
    WIA_PROP_LIST          = 0x00000020U,
    WIA_PROP_FLAG          = 0x00000040U,
    WIA_PROP_CACHEABLE     = 0x00010000U,
}

enum uint COPY_PARENT_PROPERTY_VALUES = 0x40000000U;
enum uint WIA_ITEM_CAN_BE_DELETED = 0x00000080U;

enum : uint
{
    WIA_ITEM_READ  = 0x00000001U,
    WIA_ITEM_WRITE = 0x00000002U,
}

enum : uint
{
    WIA_RANGE_MIN       = 0x00000000U,
    WIA_RANGE_NOM       = 0x00000001U,
    WIA_RANGE_MAX       = 0x00000002U,
    WIA_RANGE_STEP      = 0x00000003U,
    WIA_RANGE_NUM_ELEMS = 0x00000004U,
}

enum : uint
{
    WIA_LIST_COUNT     = 0x00000000U,
    WIA_LIST_NOM       = 0x00000001U,
    WIA_LIST_VALUES    = 0x00000002U,
    WIA_LIST_NUM_ELEMS = 0x00000002U,
}

enum : uint
{
    WIA_FLAG_NOM       = 0x00000000U,
    WIA_FLAG_VALUES    = 0x00000001U,
    WIA_FLAG_NUM_ELEMS = 0x00000002U,
}

enum uint WIA_DIP_FIRST = 0x00000002U;
enum uint WIA_IPA_FIRST = 0x00001002U;
enum uint WIA_DPF_FIRST = 0x00000d02U;
enum uint WIA_IPS_FIRST = 0x00001802U;
enum uint WIA_DPS_FIRST = 0x00000c02U;
enum uint WIA_IPC_FIRST = 0x00001402U;
enum uint WIA_NUM_IPC = 0x00000009U;
enum uint WIA_RESERVED_FOR_NEW_PROPS = 0x00000400U;

enum : uint
{
    WHITEBALANCE_MANUAL       = 0x00000001U,
    WHITEBALANCE_AUTO         = 0x00000002U,
    WHITEBALANCE_ONEPUSH_AUTO = 0x00000003U,
    WHITEBALANCE_DAYLIGHT     = 0x00000004U,
    WHITEBALANCE_FLORESCENT   = 0x00000005U,
    WHITEBALANCE_TUNGSTEN     = 0x00000006U,
    WHITEBALANCE_FLASH        = 0x00000007U,
}

enum : uint
{
    FOCUSMODE_MANUAL    = 0x00000001U,
    FOCUSMODE_AUTO      = 0x00000002U,
    FOCUSMODE_MACROAUTO = 0x00000003U,
}

enum : uint
{
    EXPOSUREMETERING_AVERAGE      = 0x00000001U,
    EXPOSUREMETERING_CENTERWEIGHT = 0x00000002U,
    EXPOSUREMETERING_MULTISPOT    = 0x00000003U,
    EXPOSUREMETERING_CENTERSPOT   = 0x00000004U,
}

enum : uint
{
    FLASHMODE_AUTO         = 0x00000001U,
    FLASHMODE_OFF          = 0x00000002U,
    FLASHMODE_FILL         = 0x00000003U,
    FLASHMODE_REDEYE_AUTO  = 0x00000004U,
    FLASHMODE_REDEYE_FILL  = 0x00000005U,
    FLASHMODE_EXTERNALSYNC = 0x00000006U,
}

enum : uint
{
    EXPOSUREMODE_MANUAL            = 0x00000001U,
    EXPOSUREMODE_AUTO              = 0x00000002U,
    EXPOSUREMODE_APERTURE_PRIORITY = 0x00000003U,
    EXPOSUREMODE_SHUTTER_PRIORITY  = 0x00000004U,
    EXPOSUREMODE_PROGRAM_CREATIVE  = 0x00000005U,
    EXPOSUREMODE_PROGRAM_ACTION    = 0x00000006U,
    EXPOSUREMODE_PORTRAIT          = 0x00000007U,
}

enum : uint
{
    CAPTUREMODE_NORMAL    = 0x00000001U,
    CAPTUREMODE_BURST     = 0x00000002U,
    CAPTUREMODE_TIMELAPSE = 0x00000003U,
}

enum : uint
{
    EFFECTMODE_STANDARD = 0x00000001U,
    EFFECTMODE_BW       = 0x00000002U,
    EFFECTMODE_SEPIA    = 0x00000003U,
}

enum : uint
{
    FOCUSMETERING_CENTERSPOT = 0x00000001U,
    FOCUSMETERING_MULTISPOT  = 0x00000002U,
}

enum : uint
{
    POWERMODE_LINE    = 0x00000001U,
    POWERMODE_BATTERY = 0x00000002U,
}

enum uint LEFT_JUSTIFIED = 0x00000000U;
enum uint CENTERED = 0x00000001U;
enum uint RIGHT_JUSTIFIED = 0x00000002U;
enum uint TOP_JUSTIFIED = 0x00000000U;
enum uint BOTTOM_JUSTIFIED = 0x00000002U;
enum uint PORTRAIT = 0x00000000U;
enum uint LANSCAPE = 0x00000001U;
enum uint LANDSCAPE = 0x00000001U;

enum : uint
{
    ROT180 = 0x00000002U,
    ROT270 = 0x00000003U,
}

enum uint MIRRORED = 0x00000001U;
enum uint FEED = 0x00000001U;
enum uint FLAT = 0x00000002U;
enum uint DUP = 0x00000004U;

enum : uint
{
    DETECT_FLAT       = 0x00000008U,
    DETECT_SCAN       = 0x00000010U,
    DETECT_FEED       = 0x00000020U,
    DETECT_DUP        = 0x00000040U,
    DETECT_FEED_AVAIL = 0x00000080U,
    DETECT_DUP_AVAIL  = 0x00000100U,
}

enum uint FILM_TPA = 0x00000200U;
enum uint DETECT_FILM_TPA = 0x00000400U;
enum uint STOR = 0x00000800U;
enum uint DETECT_STOR = 0x00001000U;
enum uint ADVANCED_DUP = 0x00002000U;
enum uint AUTO_SOURCE = 0x00008000U;
enum uint IMPRINTER = 0x00010000U;
enum uint ENDORSER = 0x00020000U;
enum uint BARCODE_READER = 0x00040000U;
enum uint PATCH_CODE_READER = 0x00080000U;
enum uint MICR_READER = 0x00100000U;
enum uint FEED_READY = 0x00000001U;
enum uint FLAT_READY = 0x00000002U;
enum uint DUP_READY = 0x00000004U;
enum uint FLAT_COVER_UP = 0x00000008U;
enum uint PATH_COVER_UP = 0x00000010U;
enum uint PAPER_JAM = 0x00000020U;
enum uint FILM_TPA_READY = 0x00000040U;

enum : uint
{
    STORAGE_READY = 0x00000080U,
    STORAGE_FULL  = 0x00000100U,
}

enum uint MULTIPLE_FEED = 0x00000200U;
enum uint DEVICE_ATTENTION = 0x00000400U;
enum uint LAMP_ERR = 0x00000800U;
enum uint IMPRINTER_READY = 0x00001000U;
enum uint ENDORSER_READY = 0x00002000U;
enum uint BARCODE_READER_READY = 0x00004000U;
enum uint PATCH_CODE_READER_READY = 0x00008000U;
enum uint MICR_READER_READY = 0x00010000U;
enum uint FEEDER = 0x00000001U;
enum uint FLATBED = 0x00000002U;
enum uint DUPLEX = 0x00000004U;
enum uint FRONT_FIRST = 0x00000008U;
enum uint BACK_FIRST = 0x00000010U;
enum uint FRONT_ONLY = 0x00000020U;
enum uint BACK_ONLY = 0x00000040U;
enum uint NEXT_PAGE = 0x00000080U;
enum uint PREFEED = 0x00000100U;
enum uint AUTO_ADVANCE = 0x00000200U;
enum uint ADVANCED_DUPLEX = 0x00000400U;

enum : uint
{
    LIGHT_SOURCE_PRESENT_DETECT = 0x00000001U,
    LIGHT_SOURCE_PRESENT        = 0x00000002U,
    LIGHT_SOURCE_DETECT_READY   = 0x00000004U,
    LIGHT_SOURCE_READY          = 0x00000008U,
}

enum uint TRANSPARENCY_DYNAMIC_FRAME_SUPPORT = 0x00000001U;
enum uint TRANSPARENCY_STATIC_FRAME_SUPPORT = 0x00000002U;

enum : uint
{
    LIGHT_SOURCE_SELECT   = 0x00000001U,
    LIGHT_SOURCE_POSITIVE = 0x00000002U,
    LIGHT_SOURCE_NEGATIVE = 0x00000004U,
}

enum uint WIA_SCAN_AHEAD_ALL = 0x00000000U;
enum uint ALL_PAGES = 0x00000000U;
enum uint WIA_FINAL_SCAN = 0x00000000U;
enum uint WIA_PREVIEW_SCAN = 0x00000001U;
enum uint WIA_SHOW_PREVIEW_CONTROL = 0x00000000U;
enum uint WIA_DONT_SHOW_PREVIEW_CONTROL = 0x00000001U;

enum : const(wchar)*
{
    WIA_ENDORSER_TOK_DATE       = "$DATE$",
    WIA_ENDORSER_TOK_TIME       = "$TIME$",
    WIA_ENDORSER_TOK_PAGE_COUNT = "$PAGE_COUNT$",
    WIA_ENDORSER_TOK_DAY        = "$DAY$",
    WIA_ENDORSER_TOK_MONTH      = "$MONTH$",
    WIA_ENDORSER_TOK_YEAR       = "$YEAR$",
}

enum : uint
{
    WIA_PAGE_A4           = 0x00000000U,
    WIA_PAGE_LETTER       = 0x00000001U,
    WIA_PAGE_CUSTOM       = 0x00000002U,
    WIA_PAGE_USLEGAL      = 0x00000003U,
    WIA_PAGE_USLETTER     = 0x00000001U,
    WIA_PAGE_USLEDGER     = 0x00000004U,
    WIA_PAGE_USSTATEMENT  = 0x00000005U,
    WIA_PAGE_BUSINESSCARD = 0x00000006U,
    WIA_PAGE_ISO_A0       = 0x00000007U,
    WIA_PAGE_ISO_A1       = 0x00000008U,
    WIA_PAGE_ISO_A2       = 0x00000009U,
    WIA_PAGE_ISO_A3       = 0x0000000aU,
    WIA_PAGE_ISO_A4       = 0x00000000U,
    WIA_PAGE_ISO_A5       = 0x0000000bU,
    WIA_PAGE_ISO_A6       = 0x0000000cU,
    WIA_PAGE_ISO_A7       = 0x0000000dU,
    WIA_PAGE_ISO_A8       = 0x0000000eU,
    WIA_PAGE_ISO_A9       = 0x0000000fU,
    WIA_PAGE_ISO_A10      = 0x00000010U,
    WIA_PAGE_ISO_B0       = 0x00000011U,
    WIA_PAGE_ISO_B1       = 0x00000012U,
    WIA_PAGE_ISO_B2       = 0x00000013U,
    WIA_PAGE_ISO_B3       = 0x00000014U,
    WIA_PAGE_ISO_B4       = 0x00000015U,
    WIA_PAGE_ISO_B5       = 0x00000016U,
    WIA_PAGE_ISO_B6       = 0x00000017U,
    WIA_PAGE_ISO_B7       = 0x00000018U,
    WIA_PAGE_ISO_B8       = 0x00000019U,
    WIA_PAGE_ISO_B9       = 0x0000001aU,
    WIA_PAGE_ISO_B10      = 0x0000001bU,
    WIA_PAGE_ISO_C0       = 0x0000001cU,
    WIA_PAGE_ISO_C1       = 0x0000001dU,
    WIA_PAGE_ISO_C2       = 0x0000001eU,
    WIA_PAGE_ISO_C3       = 0x0000001fU,
    WIA_PAGE_ISO_C4       = 0x00000020U,
    WIA_PAGE_ISO_C5       = 0x00000021U,
    WIA_PAGE_ISO_C6       = 0x00000022U,
    WIA_PAGE_ISO_C7       = 0x00000023U,
    WIA_PAGE_ISO_C8       = 0x00000024U,
    WIA_PAGE_ISO_C9       = 0x00000025U,
    WIA_PAGE_ISO_C10      = 0x00000026U,
    WIA_PAGE_JIS_B0       = 0x00000027U,
    WIA_PAGE_JIS_B1       = 0x00000028U,
    WIA_PAGE_JIS_B2       = 0x00000029U,
    WIA_PAGE_JIS_B3       = 0x0000002aU,
    WIA_PAGE_JIS_B4       = 0x0000002bU,
    WIA_PAGE_JIS_B5       = 0x0000002cU,
    WIA_PAGE_JIS_B6       = 0x0000002dU,
    WIA_PAGE_JIS_B7       = 0x0000002eU,
    WIA_PAGE_JIS_B8       = 0x0000002fU,
    WIA_PAGE_JIS_B9       = 0x00000030U,
    WIA_PAGE_JIS_B10      = 0x00000031U,
    WIA_PAGE_JIS_2A       = 0x00000032U,
    WIA_PAGE_JIS_4A       = 0x00000033U,
    WIA_PAGE_DIN_2B       = 0x00000034U,
    WIA_PAGE_DIN_4B       = 0x00000035U,
    WIA_PAGE_AUTO         = 0x00000064U,
    WIA_PAGE_CUSTOM_BASE  = 0x00008000U,
}

enum : uint
{
    WIA_COMPRESSION_NONE    = 0x00000000U,
    WIA_COMPRESSION_BI_RLE4 = 0x00000001U,
    WIA_COMPRESSION_BI_RLE8 = 0x00000002U,
    WIA_COMPRESSION_G3      = 0x00000003U,
    WIA_COMPRESSION_G4      = 0x00000004U,
    WIA_COMPRESSION_JPEG    = 0x00000005U,
    WIA_COMPRESSION_JBIG    = 0x00000006U,
    WIA_COMPRESSION_JPEG2K  = 0x00000007U,
    WIA_COMPRESSION_PNG     = 0x00000008U,
    WIA_COMPRESSION_AUTO    = 0x00000064U,
}

enum uint WIA_PACKED_PIXEL = 0x00000000U;
enum uint WIA_PLANAR = 0x00000001U;

enum : uint
{
    WIA_DATA_THRESHOLD       = 0x00000000U,
    WIA_DATA_DITHER          = 0x00000001U,
    WIA_DATA_GRAYSCALE       = 0x00000002U,
    WIA_DATA_COLOR           = 0x00000003U,
    WIA_DATA_COLOR_THRESHOLD = 0x00000004U,
    WIA_DATA_COLOR_DITHER    = 0x00000005U,
    WIA_DATA_RAW_RGB         = 0x00000006U,
    WIA_DATA_RAW_BGR         = 0x00000007U,
    WIA_DATA_RAW_YUV         = 0x00000008U,
    WIA_DATA_RAW_YUVK        = 0x00000009U,
    WIA_DATA_RAW_CMY         = 0x0000000aU,
    WIA_DATA_RAW_CMYK        = 0x0000000bU,
    WIA_DATA_AUTO            = 0x00000064U,
}

enum uint WIA_DEPTH_AUTO = 0x00000000U;

enum : uint
{
    WIA_PHOTO_WHITE_1 = 0x00000000U,
    WIA_PHOTO_WHITE_0 = 0x00000001U,
}

enum uint WIA_PROPPAGE_SCANNER_ITEM_GENERAL = 0x00000001U;

enum : uint
{
    WIA_PROPPAGE_CAMERA_ITEM_GENERAL = 0x00000002U,
    WIA_PROPPAGE_DEVICE_GENERAL      = 0x00000004U,
}

enum : uint
{
    WIA_INTENT_NONE                 = 0x00000000U,
    WIA_INTENT_IMAGE_TYPE_COLOR     = 0x00000001U,
    WIA_INTENT_IMAGE_TYPE_GRAYSCALE = 0x00000002U,
    WIA_INTENT_IMAGE_TYPE_TEXT      = 0x00000004U,
    WIA_INTENT_IMAGE_TYPE_MASK      = 0x0000000fU,
    WIA_INTENT_MINIMIZE_SIZE        = 0x00010000U,
    WIA_INTENT_MAXIMIZE_QUALITY     = 0x00020000U,
    WIA_INTENT_BEST_PREVIEW         = 0x00040000U,
    WIA_INTENT_SIZE_MASK            = 0x000f0000U,
}

enum uint WIA_NUM_DIP = 0x00000010U;
enum const(wchar)* SHELLEX_WIAUIEXTENSION_NAME = "WiaDialogExtensionHandlers";

enum : const(wchar)*
{
    CFSTR_WIAITEMNAMES = "WIAItemNames",
    CFSTR_WIAITEMPTR   = "WIAItemPointer",
}

enum GUID GUID_DEVINTERFACE_IMAGE = GUID("6bdd1fc6-810f-11d0-bec7-08002be2092f");
enum uint MAX_IO_HANDLES = 0x00000010U;
enum uint MAX_RESERVED = 0x00000004U;
enum uint MAX_ANSI_CHAR = 0x000000ffU;

enum : uint
{
    BUS_TYPE_SCSI     = 0x000000c8U,
    BUS_TYPE_USB      = 0x000000c9U,
    BUS_TYPE_PARALLEL = 0x000000caU,
    BUS_TYPE_FIREWIRE = 0x000000cbU,
}

enum : uint
{
    SCAN_FIRST    = 0x0000000aU,
    SCAN_NEXT     = 0x00000014U,
    SCAN_FINISHED = 0x0000001eU,
}

enum : uint
{
    SCANMODE_FINALSCAN   = 0x00000000U,
    SCANMODE_PREVIEWSCAN = 0x00000001U,
}

enum uint CMD_INITIALIZE = 0x00000064U;
enum uint CMD_UNINITIALIZE = 0x00000065U;
enum uint CMD_SETXRESOLUTION = 0x00000066U;
enum uint CMD_SETYRESOLUTION = 0x00000067U;

enum : uint
{
    CMD_SETCONTRAST    = 0x00000068U,
    CMD_SETINTENSITY   = 0x00000069U,
    CMD_SETDATATYPE    = 0x0000006aU,
    CMD_SETDITHER      = 0x0000006bU,
    CMD_SETMIRROR      = 0x0000006cU,
    CMD_SETNEGATIVE    = 0x0000006dU,
    CMD_SETTONEMAP     = 0x0000006eU,
    CMD_SETCOLORDITHER = 0x0000006fU,
}

enum : uint
{
    CMD_SETMATRIX = 0x00000070U,
    CMD_SETSPEED  = 0x00000071U,
    CMD_SETFILTER = 0x00000072U,
}

enum uint CMD_LOAD_ADF = 0x00000073U;
enum uint CMD_UNLOAD_ADF = 0x00000074U;

enum : uint
{
    CMD_GETADFAVAILABLE   = 0x00000075U,
    CMD_GETADFOPEN        = 0x00000076U,
    CMD_GETADFREADY       = 0x00000077U,
    CMD_GETADFHASPAPER    = 0x00000078U,
    CMD_GETADFSTATUS      = 0x00000079U,
    CMD_GETADFUNLOADREADY = 0x0000007aU,
}

enum : uint
{
    CMD_GETTPAAVAILABLE = 0x0000007bU,
    CMD_GETTPAOPENED    = 0x0000007cU,
}

enum uint CMD_TPAREADY = 0x0000007dU;

enum : uint
{
    CMD_SETLAMP         = 0x0000007eU,
    CMD_SENDSCSICOMMAND = 0x0000007fU,
}

enum : uint
{
    CMD_STI_DEVICERESET = 0x00000080U,
    CMD_STI_GETSTATUS   = 0x00000081U,
    CMD_STI_DIAGNOSTIC  = 0x00000082U,
}

enum uint CMD_RESETSCANNER = 0x00000083U;
enum uint CMD_GETCAPABILITIES = 0x00000084U;
enum uint CMD_GET_INTERRUPT_EVENT = 0x00000085U;

enum : uint
{
    CMD_SETGSDNAME       = 0x00000086U,
    CMD_SETSCANMODE      = 0x00000087U,
    CMD_SETSTIDEVICEHKEY = 0x00000088U,
}

enum : uint
{
    CMD_GETSUPPORTEDFILEFORMATS   = 0x0000008aU,
    CMD_GETSUPPORTEDMEMORYFORMATS = 0x0000008bU,
}

enum uint CMD_SETFORMAT = 0x0000008cU;

enum : uint
{
    SUPPORT_COLOR     = 0x00000001U,
    SUPPORT_BW        = 0x00000002U,
    SUPPORT_GRAYSCALE = 0x00000004U,
}

enum uint MCRO_ERROR_GENERAL_ERROR = 0x00000000U;
enum uint MCRO_STATUS_OK = 0x00000001U;

enum : uint
{
    MCRO_ERROR_PAPER_JAM         = 0x00000002U,
    MCRO_ERROR_PAPER_PROBLEM     = 0x00000003U,
    MCRO_ERROR_PAPER_EMPTY       = 0x00000004U,
    MCRO_ERROR_OFFLINE           = 0x00000005U,
    MCRO_ERROR_USER_INTERVENTION = 0x00000006U,
}

enum : uint
{
    WIA_ORDER_RGB = 0x00000000U,
    WIA_ORDER_BGR = 0x00000001U,
}

enum uint WiaItemTypeTwainCapabilityPassThrough = 0x00020000U;

enum : uint
{
    ESC_TWAIN_CAPABILITY             = 0x000007d1U,
    ESC_TWAIN_PRIVATE_SUPPORTED_CAPS = 0x000007d2U,
}

// Native encoding: ansi
enum const(wchar)* WIAU_DEBUG_TSTR = "S";
enum uint g_dwDebugFlags = 0x00000000U;
enum uint WIA_WSD_MANUFACTURER = 0x00009802U;
enum const(wchar)* WIA_WSD_MANUFACTURER_STR = "Device manufacturer";
enum uint WIA_WSD_MANUFACTURER_URL = 0x00009803U;
enum const(wchar)* WIA_WSD_MANUFACTURER_URL_STR = "Manufacurer URL";
enum uint WIA_WSD_MODEL_NAME = 0x00009804U;
enum const(wchar)* WIA_WSD_MODEL_NAME_STR = "Model name";
enum uint WIA_WSD_MODEL_NUMBER = 0x00009805U;
enum const(wchar)* WIA_WSD_MODEL_NUMBER_STR = "Model number";
enum uint WIA_WSD_MODEL_URL = 0x00009806U;
enum const(wchar)* WIA_WSD_MODEL_URL_STR = "Model URL";
enum uint WIA_WSD_PRESENTATION_URL = 0x00009807U;
enum const(wchar)* WIA_WSD_PRESENTATION_URL_STR = "Presentation URL";
enum uint WIA_WSD_FRIENDLY_NAME = 0x00009808U;
enum const(wchar)* WIA_WSD_FRIENDLY_NAME_STR = "Friendly name";
enum uint WIA_WSD_SERIAL_NUMBER = 0x00009809U;
enum const(wchar)* WIA_WSD_SERIAL_NUMBER_STR = "Serial number";
enum uint WIA_WSD_SCAN_AVAILABLE_ITEM = 0x0000980aU;
enum const(wchar)* WIA_WSD_SCAN_AVAILABLE_ITEM_STR = "Scan Available Item";

// Callbacks

alias DeviceDialogFunction = HRESULT function(DEVICEDIALOGDATA* param0);

// Structs


// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wia_xp/ns-wia_xp-wia_dither_pattern_data
struct WIA_DITHER_PATTERN_DATA
{
    int    lSize;
    BSTR   bstrPatternName;
    int    lPatternWidth;
    int    lPatternLength;
    int    cbPattern;
    ubyte* pbPattern;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wia_xp/ns-wia_xp-wia_propid_to_name
struct WIA_PROPID_TO_NAME
{
    uint  propid;
    PWSTR pszName;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wia_xp/ns-wia_xp-wia_format_info
struct WIA_FORMAT_INFO
{
    GUID guidFormatID;
    int  lTymed;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/wia/-wia-wia-raw-header
struct WIA_RAW_HEADER
{
    uint     Tag;
    uint     Version;
    uint     HeaderSize;
    uint     XRes;
    uint     YRes;
    uint     XExtent;
    uint     YExtent;
    uint     BytesPerLine;
    uint     BitsPerPixel;
    uint     ChannelsPerPixel;
    uint     DataType;
    ubyte[8] BitsPerChannel;
    uint     Compression;
    uint     PhotometricInterp;
    uint     LineOrder;
    uint     RawDataOffset;
    uint     RawDataSize;
    uint     PaletteOffset;
    uint     PaletteSize;
}

struct WIA_BARCODE_INFO
{
    uint     Size;
    uint     Type;
    uint     Page;
    uint     Confidence;
    uint     XOffset;
    uint     YOffset;
    uint     Rotation;
    uint     Length;
    wchar[1] Text; // Flexible array
}

struct WIA_BARCODES
{
    uint                Tag;
    uint                Version;
    uint                Size;
    uint                Count;
    WIA_BARCODE_INFO[1] Barcodes; // Flexible array
}

struct WIA_PATCH_CODE_INFO
{
    uint Type;
}

struct WIA_PATCH_CODES
{
    uint Tag;
    uint Version;
    uint Size;
    uint Count;
    WIA_PATCH_CODE_INFO[1] PatchCodes; // Flexible array
}

struct WIA_MICR_INFO
{
    uint     Size;
    uint     Page;
    uint     Length;
    wchar[1] Text; // Flexible array
}

struct WIA_MICR
{
    uint             Tag;
    uint             Version;
    uint             Size;
    wchar            Placeholder;
    ushort           Reserved;
    uint             Count;
    WIA_MICR_INFO[1] Micr; // Flexible array
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wia_xp/ns-wia_xp-wia_data_callback_header
struct WIA_DATA_CALLBACK_HEADER
{
    int  lSize;
    GUID guidFormatID;
    int  lBufferSize;
    int  lPageCount;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wia_xp/ns-wia_xp-wia_data_transfer_info
struct WIA_DATA_TRANSFER_INFO
{
    uint ulSize;
    uint ulSection;
    uint ulBufferSize;
    BOOL bDoubleBuffer;
    uint ulReserved1;
    uint ulReserved2;
    uint ulReserved3;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wia_xp/ns-wia_xp-wia_extended_transfer_info
struct WIA_EXTENDED_TRANSFER_INFO
{
    uint ulSize;
    uint ulMinBufferSize;
    uint ulOptimalBufferSize;
    uint ulMaxBufferSize;
    uint ulNumBuffers;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wia_xp/ns-wia_xp-wia_dev_cap
struct WIA_DEV_CAP
{
    GUID guid;
    uint ulFlags;
    BSTR bstrName;
    BSTR bstrDescription;
    BSTR bstrIcon;
    BSTR bstrCommandline;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/wia/-wia-wiatransferparams
struct WiaTransferParams
{
    int     lMessage;
    int     lPercentComplete;
    ulong   ulTransferredBytes;
    HRESULT hrErrorStatus;
}

struct MINIDRV_TRANSFER_CONTEXT
{
    int                 lSize;
    int                 lWidthInPixels;
    int                 lLines;
    int                 lDepth;
    int                 lXRes;
    int                 lYRes;
    int                 lCompression;
    GUID                guidFormatID;
    int                 tymed;
    ptrdiff_t           hFile;
    int                 cbOffset;
    int                 lBufferSize;
    int                 lActiveBuffer;
    int                 lNumBuffers;
    ubyte*              pBaseBuffer;
    ubyte*              pTransferBuffer;
    BOOL                bTransferDataCB;
    BOOL                bClassDrvAllocBuf;
    ptrdiff_t           lClientAddress;
    IWiaMiniDrvCallBack pIWiaMiniDrvCallBack;
    int                 lImageSize;
    int                 lHeaderSize;
    int                 lItemSize;
    int                 cbWidthInBytes;
    int                 lPage;
    int                 lCurIfdOffset;
    int                 lPrevIfdOffset;
}

struct WIA_DEV_CAP_DRV
{
    GUID* guid;
    uint  ulFlags;
    PWSTR wszName;
    PWSTR wszDescription;
    PWSTR wszIcon;
}

struct WIA_PROPERTY_INFO
{
    uint    lAccessFlags;
    VARENUM vt;
    union ValidVal
    {
        struct Range
        {
            int Min;
            int Nom;
            int Max;
            int Inc;
        }
        struct RangeFloat
        {
            double Min;
            double Nom;
            double Max;
            double Inc;
        }
        struct List
        {
            int    cNumList;
            int    Nom;
            ubyte* pList;
        }
        struct ListFloat
        {
            int    cNumList;
            double Nom;
            ubyte* pList;
        }
        struct ListGuid
        {
            int   cNumList;
            GUID  Nom;
            GUID* pList;
        }
        struct ListBStr
        {
            int   cNumList;
            BSTR  Nom;
            BSTR* pList;
        }
        struct Flag
        {
            int Nom;
            int ValidBits;
        }
        struct None
        {
            int Dummy;
        }
    }
}

struct WIA_PROPERTY_CONTEXT
{
    uint  cProps;
    uint* pProps;
    BOOL* pChanged;
}

struct WIAS_CHANGED_VALUE_INFO
{
    BOOL bChanged;
    int  vt;
    union Old
    {
        int   lVal;
        float fltVal;
        BSTR  bstrVal;
        GUID  guidVal;
    }
    union Current
    {
        int   lVal;
        float fltVal;
        BSTR  bstrVal;
        GUID  guidVal;
    }
}

struct WIAS_DOWN_SAMPLE_INFO
{
    uint   ulOriginalWidth;
    uint   ulOriginalHeight;
    uint   ulBitsPerPixel;
    uint   ulXRes;
    uint   ulYRes;
    uint   ulDownSampledWidth;
    uint   ulDownSampledHeight;
    uint   ulActualSize;
    uint   ulDestBufSize;
    uint   ulSrcBufSize;
    ubyte* pSrcBuffer;
    ubyte* pDestBuffer;
}

struct WIAS_ENDORSER_VALUE
{
    PWSTR wszTokenName;
    PWSTR wszValue;
}

struct WIAS_ENDORSER_INFO
{
    uint                 ulPageCount;
    uint                 ulNumEndorserValues;
    WIAS_ENDORSER_VALUE* pEndorserValues;
}

//STRUCT ATTR: StructSizeFieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(cbSize))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/wia/-wia-devicedialogdata2
struct DEVICEDIALOGDATA2
{
    uint      cbSize;
    IWiaItem2 pIWiaItemRoot;
    uint      dwFlags;
    HWND      hwndParent;
    BSTR      bstrFolderName;
    BSTR      bstrFilename;
    int       lNumFiles;
    BSTR*     pbstrFilePaths;
    IWiaItem2 pWiaItem;
}

//STRUCT ATTR: StructSizeFieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(cbSize))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/wia/-wia-devicedialogdata
struct DEVICEDIALOGDATA
{
    uint      cbSize;
    HWND      hwndParent;
    IWiaItem  pIWiaItemRoot;
    uint      dwFlags;
    int       lIntent;
    int       lItemCount;
    IWiaItem* ppWiaItems;
}

struct RANGEVALUE
{
    int lMin;
    int lMax;
    int lStep;
}

struct SCANWINDOW
{
    int xPos;
    int yPos;
    int xExtent;
    int yExtent;
}

struct SCANINFO
{
    int        ADF;
    int        TPA;
    int        Endorser;
    int        OpticalXResolution;
    int        OpticalYResolution;
    int        BedWidth;
    int        BedHeight;
    RANGEVALUE IntensityRange;
    RANGEVALUE ContrastRange;
    int        SupportedCompressionType;
    int        SupportedDataTypes;
    int        WidthPixels;
    int        WidthBytes;
    int        Lines;
    int        DataType;
    int        PixelBits;
    int        Intensity;
    int        Contrast;
    int        Xresolution;
    int        Yresolution;
    SCANWINDOW Window;
    int        DitherPattern;
    int        Negative;
    int        Mirror;
    int        AutoBack;
    int        ColorDitherPattern;
    int        ToneMap;
    int        Compression;
    int        RawDataFormat;
    int        RawPixelOrder;
    int        bNeedDataAlignment;
    int        DelayBetweenRead;
    int        MaxBufferSize;
    HANDLE[16] DeviceIOHandles;
    int[4]     lReserved;
    void*      pMicroDriverContext;
}

struct VAL
{
    int       lVal;
    double    dblVal;
    GUID*     pGuid;
    SCANINFO* pScanInfo;
    HGLOBAL   handle;
    ushort**  ppButtonNames;
    HANDLE*   pHandle;
    int       lReserved;
    CHAR[255] szVal;
}

struct TWAIN_CAPABILITY
{
    int      lSize;
    int      lMSG;
    int      lCapID;
    int      lConType;
    int      lRC;
    int      lCC;
    int      lDataSize;
    ubyte[1] Data; // Flexible array
}

// Interfaces

@GUID("a1f4e726-8cf1-11d1-bf92-0060081ed811")
struct WiaDevMgr;

@GUID("b6c292bc-7c88-41ee-8b54-8ec92617e599")
struct WiaDevMgr2;

@GUID("a1e75357-881a-419e-83e2-bb16db197c68")
struct WiaLog;

@GUID("3908c3cd-4478-4536-af2f-10c25d4ef89a")
struct WiaVideo;

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wia_xp/nn-wia_xp-iwiadevmgr
@GUID("5eb2502a-8cf1-11d1-bf92-0060081ed811")
interface IWiaDevMgr : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wia_xp/nf-wia_xp-iwiadevmgr-enumdeviceinfo
    HRESULT EnumDeviceInfo(int lFlag, IEnumWIA_DEV_INFO* ppIEnum);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wia_xp/nf-wia_xp-iwiadevmgr-createdevice
    HRESULT CreateDevice(BSTR bstrDeviceID, IWiaItem* ppWiaItemRoot);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wia_xp/nf-wia_xp-iwiadevmgr-selectdevicedlg
    HRESULT SelectDeviceDlg(HWND hwndParent, int lDeviceType, int lFlags, BSTR* pbstrDeviceID, 
                            IWiaItem* ppItemRoot);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wia_xp/nf-wia_xp-iwiadevmgr-selectdevicedlgid
    HRESULT SelectDeviceDlgID(HWND hwndParent, int lDeviceType, int lFlags, BSTR* pbstrDeviceID);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wia_xp/nf-wia_xp-iwiadevmgr-getimagedlg
    HRESULT GetImageDlg(HWND hwndParent, int lDeviceType, int lFlags, int lIntent, IWiaItem pItemRoot, 
                        BSTR bstrFilename, GUID* pguidFormat);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wia_xp/nf-wia_xp-iwiadevmgr-registereventcallbackprogram
    HRESULT RegisterEventCallbackProgram(int lFlags, BSTR bstrDeviceID, const(GUID)* pEventGUID, 
                                         BSTR bstrCommandline, BSTR bstrName, BSTR bstrDescription, BSTR bstrIcon);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wia_xp/nf-wia_xp-iwiadevmgr-registereventcallbackinterface
    HRESULT RegisterEventCallbackInterface(int lFlags, BSTR bstrDeviceID, const(GUID)* pEventGUID, 
                                           IWiaEventCallback pIWiaEventCallback, IUnknown* pEventObject);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wia_xp/nf-wia_xp-iwiadevmgr-registereventcallbackclsid
    HRESULT RegisterEventCallbackCLSID(int lFlags, BSTR bstrDeviceID, const(GUID)* pEventGUID, const(GUID)* pClsID, 
                                       BSTR bstrName, BSTR bstrDescription, BSTR bstrIcon);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wia_xp/nf-wia_xp-iwiadevmgr-adddevicedlg
    HRESULT AddDeviceDlg(HWND hwndParent, int lFlags);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wia_xp/nn-wia_xp-ienumwia_dev_info
@GUID("5e38b83c-8cf1-11d1-bf92-0060081ed811")
interface IEnumWIA_DEV_INFO : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wia_xp/nf-wia_xp-ienumwia_dev_info-next
    HRESULT Next(uint celt, IWiaPropertyStorage* rgelt, uint* pceltFetched);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wia_xp/nf-wia_xp-ienumwia_dev_info-skip
    HRESULT Skip(uint celt);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wia_xp/nf-wia_xp-ienumwia_dev_info-reset
    HRESULT Reset();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wia_xp/nf-wia_xp-ienumwia_dev_info-clone
    HRESULT Clone(IEnumWIA_DEV_INFO* ppIEnum);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wia_xp/nf-wia_xp-ienumwia_dev_info-getcount
    HRESULT GetCount(uint* celt);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wia_xp/nn-wia_xp-iwiaeventcallback
@GUID("ae6287b0-0084-11d2-973b-00a0c9068f2e")
interface IWiaEventCallback : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wia_xp/nf-wia_xp-iwiaeventcallback-imageeventcallback
    HRESULT ImageEventCallback(const(GUID)* pEventGUID, BSTR bstrEventDescription, BSTR bstrDeviceID, 
                               BSTR bstrDeviceDescription, uint dwDeviceType, BSTR bstrFullItemName, 
                               uint* pulEventType, uint ulReserved);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wia_xp/nn-wia_xp-iwiadatacallback
@GUID("a558a866-a5b0-11d2-a08f-00c04f72dc3c")
interface IWiaDataCallback : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wia_xp/nf-wia_xp-iwiadatacallback-bandeddatacallback
    HRESULT BandedDataCallback(int lMessage, int lStatus, int lPercentComplete, int lOffset, int lLength, 
                               int lReserved, int lResLength, ubyte* pbBuffer);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wia_xp/nn-wia_xp-iwiadatatransfer
@GUID("a6cef998-a5b0-11d2-a08f-00c04f72dc3c")
interface IWiaDataTransfer : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wia_xp/nf-wia_xp-iwiadatatransfer-idtgetdata
    HRESULT idtGetData(STGMEDIUM* pMedium, IWiaDataCallback pIWiaDataCallback);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wia_xp/nf-wia_xp-iwiadatatransfer-idtgetbandeddata
    HRESULT idtGetBandedData(WIA_DATA_TRANSFER_INFO* pWiaDataTransInfo, IWiaDataCallback pIWiaDataCallback);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wia_xp/nf-wia_xp-iwiadatatransfer-idtquerygetdata
    HRESULT idtQueryGetData(WIA_FORMAT_INFO* pfe);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wia_xp/nf-wia_xp-iwiadatatransfer-idtenumwia_format_info
    HRESULT idtEnumWIA_FORMAT_INFO(IEnumWIA_FORMAT_INFO* ppEnum);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wia_xp/nf-wia_xp-iwiadatatransfer-idtgetextendedtransferinfo
    HRESULT idtGetExtendedTransferInfo(WIA_EXTENDED_TRANSFER_INFO* pExtendedTransferInfo);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wia_xp/nn-wia_xp-iwiaitem
@GUID("4db1ad10-3391-11d2-9a33-00c04fa36145")
interface IWiaItem : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wia_xp/nf-wia_xp-iwiaitem-getitemtype
    HRESULT GetItemType(int* pItemType);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wia_xp/nf-wia_xp-iwiaitem-analyzeitem
    HRESULT AnalyzeItem(int lFlags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wia_xp/nf-wia_xp-iwiaitem-enumchilditems
    HRESULT EnumChildItems(IEnumWiaItem* ppIEnumWiaItem);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wia_xp/nf-wia_xp-iwiaitem-deleteitem
    HRESULT DeleteItem(int lFlags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wia_xp/nf-wia_xp-iwiaitem-createchilditem
    HRESULT CreateChildItem(int lFlags, BSTR bstrItemName, BSTR bstrFullItemName, IWiaItem* ppIWiaItem);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wia_xp/nf-wia_xp-iwiaitem-enumregistereventinfo
    HRESULT EnumRegisterEventInfo(int lFlags, const(GUID)* pEventGUID, IEnumWIA_DEV_CAPS* ppIEnum);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wia_xp/nf-wia_xp-iwiaitem-finditembyname
    HRESULT FindItemByName(int lFlags, BSTR bstrFullItemName, IWiaItem* ppIWiaItem);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wia_xp/nf-wia_xp-iwiaitem-devicedlg
    HRESULT DeviceDlg(HWND hwndParent, int lFlags, int lIntent, int* plItemCount, IWiaItem** ppIWiaItem);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wia_xp/nf-wia_xp-iwiaitem-devicecommand
    HRESULT DeviceCommand(int lFlags, const(GUID)* pCmdGUID, IWiaItem* pIWiaItem);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wia_xp/nf-wia_xp-iwiaitem-getrootitem
    HRESULT GetRootItem(IWiaItem* ppIWiaItem);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wia_xp/nf-wia_xp-iwiaitem-enumdevicecapabilities
    HRESULT EnumDeviceCapabilities(int lFlags, IEnumWIA_DEV_CAPS* ppIEnumWIA_DEV_CAPS);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wia_xp/nf-wia_xp-iwiaitem-dumpitemdata
    HRESULT DumpItemData(BSTR* bstrData);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wia_xp/nf-wia_xp-iwiaitem-dumpdrvitemdata
    HRESULT DumpDrvItemData(BSTR* bstrData);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wia_xp/nf-wia_xp-iwiaitem-dumptreeitemdata
    HRESULT DumpTreeItemData(BSTR* bstrData);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wia_xp/nf-wia_xp-iwiaitem-diagnostic
    HRESULT Diagnostic(uint ulSize, ubyte* pBuffer);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wia_xp/nn-wia_xp-iwiapropertystorage
@GUID("98b5e8a0-29cc-491a-aac0-e6db4fdcceb6")
interface IWiaPropertyStorage : IUnknown
{
    HRESULT ReadMultiple(uint cpspec, const(PROPSPEC)* rgpspec, PROPVARIANT* rgpropvar);
    HRESULT WriteMultiple(uint cpspec, const(PROPSPEC)* rgpspec, const(PROPVARIANT)* rgpropvar, 
                          uint propidNameFirst);
    HRESULT DeleteMultiple(uint cpspec, const(PROPSPEC)* rgpspec);
    HRESULT ReadPropertyNames(uint cpropid, const(uint)* rgpropid, PWSTR* rglpwstrName);
    HRESULT WritePropertyNames(uint cpropid, const(uint)* rgpropid, const(PWSTR)* rglpwstrName);
    HRESULT DeletePropertyNames(uint cpropid, const(uint)* rgpropid);
    HRESULT Commit(uint grfCommitFlags);
    HRESULT Revert();
    HRESULT Enum(IEnumSTATPROPSTG* ppenum);
    HRESULT SetTimes(const(FILETIME)* pctime, const(FILETIME)* patime, const(FILETIME)* pmtime);
    HRESULT SetClass(const(GUID)* clsid);
    HRESULT Stat(STATPROPSETSTG* pstatpsstg);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wia_xp/nf-wia_xp-iwiapropertystorage-getpropertyattributes
    HRESULT GetPropertyAttributes(uint cpspec, PROPSPEC* rgpspec, uint* rgflags, PROPVARIANT* rgpropvar);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wia_xp/nf-wia_xp-iwiapropertystorage-getcount
    HRESULT GetCount(uint* pulNumProps);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wia_xp/nf-wia_xp-iwiapropertystorage-getpropertystream
    HRESULT GetPropertyStream(GUID* pCompatibilityId, IStream* ppIStream);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wia_xp/nf-wia_xp-iwiapropertystorage-setpropertystream
    HRESULT SetPropertyStream(GUID* pCompatibilityId, IStream pIStream);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wia_xp/nn-wia_xp-ienumwiaitem
@GUID("5e8383fc-3391-11d2-9a33-00c04fa36145")
interface IEnumWiaItem : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wia_xp/nf-wia_xp-ienumwiaitem-next
    HRESULT Next(uint celt, IWiaItem* ppIWiaItem, uint* pceltFetched);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wia_xp/nf-wia_xp-ienumwiaitem-skip
    HRESULT Skip(uint celt);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wia_xp/nf-wia_xp-ienumwiaitem-reset
    HRESULT Reset();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wia_xp/nf-wia_xp-ienumwiaitem-clone
    HRESULT Clone(IEnumWiaItem* ppIEnum);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wia_xp/nf-wia_xp-ienumwiaitem-getcount
    HRESULT GetCount(uint* celt);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wia_xp/nn-wia_xp-ienumwia_dev_caps
@GUID("1fcc4287-aca6-11d2-a093-00c04f72dc3c")
interface IEnumWIA_DEV_CAPS : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wia_xp/nf-wia_xp-ienumwia_dev_caps-next
    HRESULT Next(uint celt, WIA_DEV_CAP* rgelt, uint* pceltFetched);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wia_xp/nf-wia_xp-ienumwia_dev_caps-skip
    HRESULT Skip(uint celt);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wia_xp/nf-wia_xp-ienumwia_dev_caps-reset
    HRESULT Reset();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wia_xp/nf-wia_xp-ienumwia_dev_caps-clone
    HRESULT Clone(IEnumWIA_DEV_CAPS* ppIEnum);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wia_xp/nf-wia_xp-ienumwia_dev_caps-getcount
    HRESULT GetCount(uint* pcelt);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wia_xp/nn-wia_xp-ienumwia_format_info
@GUID("81befc5b-656d-44f1-b24c-d41d51b4dc81")
interface IEnumWIA_FORMAT_INFO : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wia_xp/nf-wia_xp-ienumwia_format_info-next
    HRESULT Next(uint celt, WIA_FORMAT_INFO* rgelt, uint* pceltFetched);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wia_xp/nf-wia_xp-ienumwia_format_info-skip
    HRESULT Skip(uint celt);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wia_xp/nf-wia_xp-ienumwia_format_info-reset
    HRESULT Reset();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wia_xp/nf-wia_xp-ienumwia_format_info-clone
    HRESULT Clone(IEnumWIA_FORMAT_INFO* ppIEnum);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wia_xp/nf-wia_xp-ienumwia_format_info-getcount
    HRESULT GetCount(uint* pcelt);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wia_xp/nn-wia_xp-iwialog
@GUID("a00c10b6-82a1-452f-8b6c-86062aad6890")
interface IWiaLog : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wia_xp/nf-wia_xp-iwialog-initializelog
    HRESULT InitializeLog(int hInstance);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wia_xp/nf-wia_xp-iwialog-hresult
    HRESULT hResult(HRESULT hResult);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wia_xp/nf-wia_xp-iwialog-log
    HRESULT Log(int lFlags, int lResID, int lDetail, BSTR bstrText);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wia_xp/nn-wia_xp-iwialogex
@GUID("af1f22ac-7a40-4787-b421-aeb47a1fbd0b")
interface IWiaLogEx : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wia_xp/nf-wia_xp-iwialogex-initializelogex
    HRESULT InitializeLogEx(ubyte* hInstance);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wia_xp/nf-wia_xp-iwialogex-hresult
    HRESULT hResult(HRESULT hResult);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wia_xp/nf-wia_xp-iwialogex-log
    HRESULT Log(int lFlags, int lResID, int lDetail, BSTR bstrText);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wia_xp/nf-wia_xp-iwialogex-hresultex
    HRESULT hResultEx(int lMethodId, HRESULT hResult);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wia_xp/nf-wia_xp-iwialogex-logex
    HRESULT LogEx(int lMethodId, int lFlags, int lResID, int lDetail, BSTR bstrText);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wia_xp/nn-wia_xp-iwianotifydevmgr
@GUID("70681ea0-e7bf-4291-9fb1-4e8813a3f78e")
interface IWiaNotifyDevMgr : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wia_xp/nf-wia_xp-iwianotifydevmgr-newdevicearrival
    HRESULT NewDeviceArrival();
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wia_xp/nn-wia_xp-iwiaitemextras
@GUID("6291ef2c-36ef-4532-876a-8e132593778d")
interface IWiaItemExtras : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wia_xp/nf-wia_xp-iwiaitemextras-getextendederrorinfo
    HRESULT GetExtendedErrorInfo(BSTR* bstrErrorText);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wia_xp/nf-wia_xp-iwiaitemextras-escape
    HRESULT Escape(uint dwEscapeCode, ubyte* lpInData, uint cbInDataSize, ubyte* pOutData, uint dwOutDataSize, 
                   uint* pdwActualDataSize);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wia_xp/nf-wia_xp-iwiaitemextras-cancelpendingio
    HRESULT CancelPendingIO();
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/wia/-wia-iwiaapperrorhandler
@GUID("6c16186c-d0a6-400c-80f4-d26986a0e734")
interface IWiaAppErrorHandler : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/wia/-wia-iwiaapperrorhandler-getwindow
    HRESULT GetWindow(HWND* phwnd);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/wia/-wia-iwiaapperrorhandler-reportstatus
    HRESULT ReportStatus(int lFlags, IWiaItem2 pWiaItem2, HRESULT hrStatus, int lPercentComplete);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/wia/-wia-iwiaerrorhandler
@GUID("0e4a51b1-bc1f-443d-a835-72e890759ef3")
interface IWiaErrorHandler : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/wia/-wia-iwiaerrorhandler-reportstatus
    HRESULT ReportStatus(int lFlags, HWND hwndParent, IWiaItem2 pWiaItem2, HRESULT hrStatus, int lPercentComplete);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/wia/-wia-iwiaerrorhandler-getstatusdescription
    HRESULT GetStatusDescription(int lFlags, IWiaItem2 pWiaItem2, HRESULT hrStatus, BSTR* pbstrDescription);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/wia/-wia-iwiatransfer
@GUID("c39d6942-2f4e-4d04-92fe-4ef4d3a1de5a")
interface IWiaTransfer : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/wia/-wia-iwiatransfer-download
    HRESULT Download(int lFlags, IWiaTransferCallback pIWiaTransferCallback);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/wia/-wia-iwiatransfer-upload
    HRESULT Upload(int lFlags, IStream pSource, IWiaTransferCallback pIWiaTransferCallback);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/wia/-wia-iwiatransfer-cancel
    HRESULT Cancel();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/wia/-wia-iwiatransfer-enumwia-format-info
    HRESULT EnumWIA_FORMAT_INFO(IEnumWIA_FORMAT_INFO* ppEnum);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/wia/-wia-iwiatransfercallback
@GUID("27d4eaaf-28a6-4ca5-9aab-e678168b9527")
interface IWiaTransferCallback : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/wia/-wia-iwiatransfercallback-transfercallback
    HRESULT TransferCallback(int lFlags, WiaTransferParams* pWiaTransferParams);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/wia/-wia-iwiatransfercallback-getnextstream
    HRESULT GetNextStream(int lFlags, BSTR bstrItemName, BSTR bstrFullItemName, IStream* ppDestination);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/wia/-wia-iwiasegmentationfilter
@GUID("ec46a697-ac04-4447-8f65-ff63d5154b21")
interface IWiaSegmentationFilter : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/wia/-wia-iwiasegmentationfilter-detectregions
    HRESULT DetectRegions(int lFlags, IStream pInputStream, IWiaItem2 pWiaItem2);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/wia/-wia-iwiaimagefilter
@GUID("a8a79ffa-450b-41f1-8f87-849ccd94ebf6")
interface IWiaImageFilter : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/wia/-wia-iwiaimagefilter-initializefilter
    HRESULT InitializeFilter(IWiaItem2 pWiaItem2, IWiaTransferCallback pWiaTransferCallback);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/wia/-wia-iwiaimagefilter-setnewcallback
    HRESULT SetNewCallback(IWiaTransferCallback pWiaTransferCallback);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/wia/-wia-iwiaimagefilter-filterpreviewimage
    HRESULT FilterPreviewImage(int lFlags, IWiaItem2 pWiaChildItem2, RECT InputImageExtents, IStream pInputStream);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/wia/-wia-iwiaimagefilter-applyproperties
    HRESULT ApplyProperties(IWiaPropertyStorage pWiaPropertyStorage);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/wia/-wia-iwiapreview
@GUID("95c2b4fd-33f2-4d86-ad40-9431f0df08f7")
interface IWiaPreview : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/wia/-wia-iwiapreview-getnewpreview
    HRESULT GetNewPreview(int lFlags, IWiaItem2 pWiaItem2, IWiaTransferCallback pWiaTransferCallback);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/wia/-wia-iwiapreview-updatepreview
    HRESULT UpdatePreview(int lFlags, IWiaItem2 pChildWiaItem2, IWiaTransferCallback pWiaTransferCallback);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/wia/-wia-iwiapreview-detectregions
    HRESULT DetectRegions(int lFlags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/wia/-wia-iwiapreview-clear
    HRESULT Clear();
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/wia/-wia-ienumwiaitem2
@GUID("59970af4-cd0d-44d9-ab24-52295630e582")
interface IEnumWiaItem2 : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/wia/-wia-ienumwiaitem2-next
    HRESULT Next(uint cElt, IWiaItem2* ppIWiaItem2, uint* pcEltFetched);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/wia/-wia-ienumwiaitem2-skip
    HRESULT Skip(uint cElt);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/wia/-wia-ienumwiaitem2-reset
    HRESULT Reset();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/wia/-wia-ienumwiaitem2-clone
    HRESULT Clone(IEnumWiaItem2* ppIEnum);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/wia/-wia-ienumwiaitem2-getcount
    HRESULT GetCount(uint* cElt);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/wia/-wia-iwiaitem2
@GUID("6cba0075-1287-407d-9b77-cf0e030435cc")
interface IWiaItem2 : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/wia/-wia-iwiaitem2-createchilditem
    HRESULT CreateChildItem(int lItemFlags, int lCreationFlags, BSTR bstrItemName, IWiaItem2* ppIWiaItem2);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/wia/-wia-iwiaitem2-deleteitem
    HRESULT DeleteItem(int lFlags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/wia/-wia-iwiaitem2-enumchilditems
    HRESULT EnumChildItems(const(GUID)* pCategoryGUID, IEnumWiaItem2* ppIEnumWiaItem2);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/wia/-wia-iwiaitem2-finditembyname
    HRESULT FindItemByName(int lFlags, BSTR bstrFullItemName, IWiaItem2* ppIWiaItem2);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/wia/-wia-iwiaitem2-getitemcategory
    HRESULT GetItemCategory(GUID* pItemCategoryGUID);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/wia/-wia-iwiaitem2-getitemtype
    HRESULT GetItemType(int* pItemType);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/wia/-wia-iwiaitem2-devicedlg
    HRESULT DeviceDlg(int lFlags, HWND hwndParent, BSTR bstrFolderName, BSTR bstrFilename, int* plNumFiles, 
                      BSTR** ppbstrFilePaths, IWiaItem2* ppItem);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/wia/-wia-iwiaitem2-devicecommand
    HRESULT DeviceCommand(int lFlags, const(GUID)* pCmdGUID, IWiaItem2* ppIWiaItem2);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/wia/-wia-iwiaitem2-enumdevicecapabilities
    HRESULT EnumDeviceCapabilities(int lFlags, IEnumWIA_DEV_CAPS* ppIEnumWIA_DEV_CAPS);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/wia/-wia-iwiaitem2-checkextension
    HRESULT CheckExtension(int lFlags, BSTR bstrName, const(GUID)* riidExtensionInterface, BOOL* pbExtensionExists);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/wia/-wia-iwiaitem2-getextension
    HRESULT GetExtension(int lFlags, BSTR bstrName, const(GUID)* riidExtensionInterface, void** ppOut);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/wia/-wia-iwiaitem2-getparentitem
    HRESULT GetParentItem(IWiaItem2* ppIWiaItem2);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/wia/-wia-iwiaitem2-getrootitem
    HRESULT GetRootItem(IWiaItem2* ppIWiaItem2);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/wia/-wia-iwiaitem2-getpreviewcomponent
    HRESULT GetPreviewComponent(int lFlags, IWiaPreview* ppWiaPreview);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/wia/-wia-iwiaitem2-enumregistereventinfo
    HRESULT EnumRegisterEventInfo(int lFlags, const(GUID)* pEventGUID, IEnumWIA_DEV_CAPS* ppIEnum);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/wia/-wia-iwiaitem2-diagnostic
    HRESULT Diagnostic(uint ulSize, ubyte* pBuffer);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/wia/-wia-iwiadevmgr2
@GUID("79c07cf1-cbdd-41ee-8ec3-f00080cada7a")
interface IWiaDevMgr2 : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/wia/-wia-iwiadevmgr2-enumdeviceinfo
    HRESULT EnumDeviceInfo(int lFlags, IEnumWIA_DEV_INFO* ppIEnum);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/wia/-wia-iwiadevmgr2-createdevice
    HRESULT CreateDevice(int lFlags, BSTR bstrDeviceID, IWiaItem2* ppWiaItem2Root);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/wia/-wia-iwiadevmgr2-selectdevicedlg
    HRESULT SelectDeviceDlg(HWND hwndParent, int lDeviceType, int lFlags, BSTR* pbstrDeviceID, 
                            IWiaItem2* ppItemRoot);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/wia/-wia-iwiadevmgr2-selectdevicedlgid
    HRESULT SelectDeviceDlgID(HWND hwndParent, int lDeviceType, int lFlags, BSTR* pbstrDeviceID);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/wia/-wia-iwiadevmgr2-registereventcallbackinterface
    HRESULT RegisterEventCallbackInterface(int lFlags, BSTR bstrDeviceID, const(GUID)* pEventGUID, 
                                           IWiaEventCallback pIWiaEventCallback, IUnknown* pEventObject);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/wia/-wia-iwiadevmgr2-registereventcallbackprogram
    HRESULT RegisterEventCallbackProgram(int lFlags, BSTR bstrDeviceID, const(GUID)* pEventGUID, 
                                         BSTR bstrFullAppName, BSTR bstrCommandLineArg, BSTR bstrName, 
                                         BSTR bstrDescription, BSTR bstrIcon);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/wia/-wia-iwiadevmgr2-registereventcallbackclsid
    HRESULT RegisterEventCallbackCLSID(int lFlags, BSTR bstrDeviceID, const(GUID)* pEventGUID, const(GUID)* pClsID, 
                                       BSTR bstrName, BSTR bstrDescription, BSTR bstrIcon);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/wia/-wia-iwiadevmgr2-getimagedlg
    HRESULT GetImageDlg(int lFlags, BSTR bstrDeviceID, HWND hwndParent, BSTR bstrFolderName, BSTR bstrFilename, 
                        int* plNumFiles, BSTR** ppbstrFilePaths, IWiaItem2* ppItem);
}

@GUID("d8cdee14-3c6c-11d2-9a35-00c04fa36145")
interface IWiaMiniDrv : IUnknown
{
    HRESULT drvInitializeWia(ubyte* __MIDL__IWiaMiniDrv0000, int __MIDL__IWiaMiniDrv0001, 
                             BSTR __MIDL__IWiaMiniDrv0002, BSTR __MIDL__IWiaMiniDrv0003, 
                             IUnknown __MIDL__IWiaMiniDrv0004, IUnknown __MIDL__IWiaMiniDrv0005, 
                             IWiaDrvItem* __MIDL__IWiaMiniDrv0006, IUnknown* __MIDL__IWiaMiniDrv0007, 
                             int* __MIDL__IWiaMiniDrv0008);
    HRESULT drvAcquireItemData(ubyte* __MIDL__IWiaMiniDrv0009, int __MIDL__IWiaMiniDrv0010, 
                               MINIDRV_TRANSFER_CONTEXT* __MIDL__IWiaMiniDrv0011, int* __MIDL__IWiaMiniDrv0012);
    HRESULT drvInitItemProperties(ubyte* __MIDL__IWiaMiniDrv0013, int __MIDL__IWiaMiniDrv0014, 
                                  int* __MIDL__IWiaMiniDrv0015);
    HRESULT drvValidateItemProperties(ubyte* __MIDL__IWiaMiniDrv0016, int __MIDL__IWiaMiniDrv0017, 
                                      uint __MIDL__IWiaMiniDrv0018, const(PROPSPEC)* __MIDL__IWiaMiniDrv0019, 
                                      int* __MIDL__IWiaMiniDrv0020);
    HRESULT drvWriteItemProperties(ubyte* __MIDL__IWiaMiniDrv0021, int __MIDL__IWiaMiniDrv0022, 
                                   MINIDRV_TRANSFER_CONTEXT* __MIDL__IWiaMiniDrv0023, int* __MIDL__IWiaMiniDrv0024);
    HRESULT drvReadItemProperties(ubyte* __MIDL__IWiaMiniDrv0025, int __MIDL__IWiaMiniDrv0026, 
                                  uint __MIDL__IWiaMiniDrv0027, const(PROPSPEC)* __MIDL__IWiaMiniDrv0028, 
                                  int* __MIDL__IWiaMiniDrv0029);
    HRESULT drvLockWiaDevice(ubyte* __MIDL__IWiaMiniDrv0030, int __MIDL__IWiaMiniDrv0031, 
                             int* __MIDL__IWiaMiniDrv0032);
    HRESULT drvUnLockWiaDevice(ubyte* __MIDL__IWiaMiniDrv0033, int __MIDL__IWiaMiniDrv0034, 
                               int* __MIDL__IWiaMiniDrv0035);
    HRESULT drvAnalyzeItem(ubyte* __MIDL__IWiaMiniDrv0036, int __MIDL__IWiaMiniDrv0037, 
                           int* __MIDL__IWiaMiniDrv0038);
    HRESULT drvGetDeviceErrorStr(int __MIDL__IWiaMiniDrv0039, int __MIDL__IWiaMiniDrv0040, 
                                 PWSTR* __MIDL__IWiaMiniDrv0041, int* __MIDL__IWiaMiniDrv0042);
    HRESULT drvDeviceCommand(ubyte* __MIDL__IWiaMiniDrv0043, int __MIDL__IWiaMiniDrv0044, 
                             const(GUID)* __MIDL__IWiaMiniDrv0045, IWiaDrvItem* __MIDL__IWiaMiniDrv0046, 
                             int* __MIDL__IWiaMiniDrv0047);
    HRESULT drvGetCapabilities(ubyte* __MIDL__IWiaMiniDrv0048, int __MIDL__IWiaMiniDrv0049, 
                               int* __MIDL__IWiaMiniDrv0050, WIA_DEV_CAP_DRV** __MIDL__IWiaMiniDrv0051, 
                               int* __MIDL__IWiaMiniDrv0052);
    HRESULT drvDeleteItem(ubyte* __MIDL__IWiaMiniDrv0053, int __MIDL__IWiaMiniDrv0054, 
                          int* __MIDL__IWiaMiniDrv0055);
    HRESULT drvFreeDrvItemContext(int __MIDL__IWiaMiniDrv0056, ubyte* __MIDL__IWiaMiniDrv0057, 
                                  int* __MIDL__IWiaMiniDrv0058);
    HRESULT drvGetWiaFormatInfo(ubyte* __MIDL__IWiaMiniDrv0059, int __MIDL__IWiaMiniDrv0060, 
                                int* __MIDL__IWiaMiniDrv0061, WIA_FORMAT_INFO** __MIDL__IWiaMiniDrv0062, 
                                int* __MIDL__IWiaMiniDrv0063);
    HRESULT drvNotifyPnpEvent(const(GUID)* pEventGUID, BSTR bstrDeviceID, uint ulReserved);
    HRESULT drvUnInitializeWia(ubyte* __MIDL__IWiaMiniDrv0064);
}

@GUID("33a57d5a-3de8-11d2-9a36-00c04fa36145")
interface IWiaMiniDrvCallBack : IUnknown
{
    HRESULT MiniDrvCallback(int lReason, int lStatus, int lPercentComplete, int lOffset, int lLength, 
                            MINIDRV_TRANSFER_CONTEXT* pTranCtx, int lReserved);
}

@GUID("a9d2ee89-2ce5-4ff0-8adb-c961d1d774ca")
interface IWiaMiniDrvTransferCallback : IUnknown
{
    HRESULT GetNextStream(int lFlags, BSTR bstrItemName, BSTR bstrFullItemName, IStream* ppIStream);
    HRESULT SendMessage(int lFlags, WiaTransferParams* pWiaTransferParams);
}

@GUID("1f02b5c5-b00c-11d2-a094-00c04f72dc3c")
interface IWiaDrvItem : IUnknown
{
    HRESULT GetItemFlags(int* __MIDL__IWiaDrvItem0000);
    HRESULT GetDeviceSpecContext(ubyte** __MIDL__IWiaDrvItem0001);
    HRESULT GetFullItemName(BSTR* __MIDL__IWiaDrvItem0002);
    HRESULT GetItemName(BSTR* __MIDL__IWiaDrvItem0003);
    HRESULT AddItemToFolder(IWiaDrvItem __MIDL__IWiaDrvItem0004);
    HRESULT UnlinkItemTree(int __MIDL__IWiaDrvItem0005);
    HRESULT RemoveItemFromFolder(int __MIDL__IWiaDrvItem0006);
    HRESULT FindItemByName(int __MIDL__IWiaDrvItem0007, BSTR __MIDL__IWiaDrvItem0008, 
                           IWiaDrvItem* __MIDL__IWiaDrvItem0009);
    HRESULT FindChildItemByName(BSTR __MIDL__IWiaDrvItem0010, IWiaDrvItem* __MIDL__IWiaDrvItem0011);
    HRESULT GetParentItem(IWiaDrvItem* __MIDL__IWiaDrvItem0012);
    HRESULT GetFirstChildItem(IWiaDrvItem* __MIDL__IWiaDrvItem0013);
    HRESULT GetNextSiblingItem(IWiaDrvItem* __MIDL__IWiaDrvItem0014);
    HRESULT DumpItemData(BSTR* __MIDL__IWiaDrvItem0015);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wiavideo/nn-wiavideo-iwiavideo
@GUID("d52920aa-db88-41f0-946c-e00dc0a19cfa")
interface IWiaVideo : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wiavideo/nf-wiavideo-iwiavideo-get_previewvisible
    HRESULT get_PreviewVisible(BOOL* pbPreviewVisible);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wiavideo/nf-wiavideo-iwiavideo-put_previewvisible
    HRESULT put_PreviewVisible(BOOL bPreviewVisible);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wiavideo/nf-wiavideo-iwiavideo-get_imagesdirectory
    HRESULT get_ImagesDirectory(BSTR* pbstrImageDirectory);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wiavideo/nf-wiavideo-iwiavideo-put_imagesdirectory
    HRESULT put_ImagesDirectory(BSTR bstrImageDirectory);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wiavideo/nf-wiavideo-iwiavideo-createvideobywiadevid
    HRESULT CreateVideoByWiaDevID(BSTR bstrWiaDeviceID, HWND hwndParent, BOOL bStretchToFitParent, 
                                  BOOL bAutoBeginPlayback);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wiavideo/nf-wiavideo-iwiavideo-createvideobydevnum
    HRESULT CreateVideoByDevNum(uint uiDeviceNumber, HWND hwndParent, BOOL bStretchToFitParent, 
                                BOOL bAutoBeginPlayback);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wiavideo/nf-wiavideo-iwiavideo-createvideobyname
    HRESULT CreateVideoByName(BSTR bstrFriendlyName, HWND hwndParent, BOOL bStretchToFitParent, 
                              BOOL bAutoBeginPlayback);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wiavideo/nf-wiavideo-iwiavideo-destroyvideo
    HRESULT DestroyVideo();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wiavideo/nf-wiavideo-iwiavideo-play
    HRESULT Play();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wiavideo/nf-wiavideo-iwiavideo-pause
    HRESULT Pause();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wiavideo/nf-wiavideo-iwiavideo-takepicture
    HRESULT TakePicture(BSTR* pbstrNewImageFilename);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wiavideo/nf-wiavideo-iwiavideo-resizevideo
    HRESULT ResizeVideo(BOOL bStretchToFitParent);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wiavideo/nf-wiavideo-iwiavideo-getcurrentstate
    HRESULT GetCurrentState(WIAVIDEO_STATE* pState);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/wia/-wia-iwiauiextension2
@GUID("305600d7-5088-46d7-9a15-b77b09cdba7a")
interface IWiaUIExtension2 : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/wia/-wia-iwiauiextension2-devicedialog
    HRESULT DeviceDialog(DEVICEDIALOGDATA2* pDeviceDialogData);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/wia/-wia-iwiauiextension2-getdeviceicon
    HRESULT GetDeviceIcon(BSTR bstrDeviceId, HICON* phIcon, uint nSize);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/wia/-wia-iwiauiextension
@GUID("da319113-50ee-4c80-b460-57d005d44a2c")
interface IWiaUIExtension : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/wia/-wia-iwiauiextension-devicedialog
    HRESULT DeviceDialog(DEVICEDIALOGDATA* pDeviceDialogData);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/wia/-wia-iwiauiextension-getdeviceicon
    HRESULT GetDeviceIcon(BSTR bstrDeviceId, HICON* phIcon, uint nSize);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/wia/-wia-iwiauiextension-getdevicebitmaplogo
    HRESULT GetDeviceBitmapLogo(BSTR bstrDeviceId, HBITMAP* phBitmap, uint nMaxWidth, uint nMaxHeight);
}


// GUIDs

const GUID CLSID_WiaDevMgr  = GUIDOF!WiaDevMgr;
const GUID CLSID_WiaDevMgr2 = GUIDOF!WiaDevMgr2;
const GUID CLSID_WiaLog     = GUIDOF!WiaLog;
const GUID CLSID_WiaVideo   = GUIDOF!WiaVideo;

const GUID IID_IEnumWIA_DEV_CAPS           = GUIDOF!IEnumWIA_DEV_CAPS;
const GUID IID_IEnumWIA_DEV_INFO           = GUIDOF!IEnumWIA_DEV_INFO;
const GUID IID_IEnumWIA_FORMAT_INFO        = GUIDOF!IEnumWIA_FORMAT_INFO;
const GUID IID_IEnumWiaItem                = GUIDOF!IEnumWiaItem;
const GUID IID_IEnumWiaItem2               = GUIDOF!IEnumWiaItem2;
const GUID IID_IWiaAppErrorHandler         = GUIDOF!IWiaAppErrorHandler;
const GUID IID_IWiaDataCallback            = GUIDOF!IWiaDataCallback;
const GUID IID_IWiaDataTransfer            = GUIDOF!IWiaDataTransfer;
const GUID IID_IWiaDevMgr                  = GUIDOF!IWiaDevMgr;
const GUID IID_IWiaDevMgr2                 = GUIDOF!IWiaDevMgr2;
const GUID IID_IWiaDrvItem                 = GUIDOF!IWiaDrvItem;
const GUID IID_IWiaErrorHandler            = GUIDOF!IWiaErrorHandler;
const GUID IID_IWiaEventCallback           = GUIDOF!IWiaEventCallback;
const GUID IID_IWiaImageFilter             = GUIDOF!IWiaImageFilter;
const GUID IID_IWiaItem                    = GUIDOF!IWiaItem;
const GUID IID_IWiaItem2                   = GUIDOF!IWiaItem2;
const GUID IID_IWiaItemExtras              = GUIDOF!IWiaItemExtras;
const GUID IID_IWiaLog                     = GUIDOF!IWiaLog;
const GUID IID_IWiaLogEx                   = GUIDOF!IWiaLogEx;
const GUID IID_IWiaMiniDrv                 = GUIDOF!IWiaMiniDrv;
const GUID IID_IWiaMiniDrvCallBack         = GUIDOF!IWiaMiniDrvCallBack;
const GUID IID_IWiaMiniDrvTransferCallback = GUIDOF!IWiaMiniDrvTransferCallback;
const GUID IID_IWiaNotifyDevMgr            = GUIDOF!IWiaNotifyDevMgr;
const GUID IID_IWiaPreview                 = GUIDOF!IWiaPreview;
const GUID IID_IWiaPropertyStorage         = GUIDOF!IWiaPropertyStorage;
const GUID IID_IWiaSegmentationFilter      = GUIDOF!IWiaSegmentationFilter;
const GUID IID_IWiaTransfer                = GUIDOF!IWiaTransfer;
const GUID IID_IWiaTransferCallback        = GUIDOF!IWiaTransferCallback;
const GUID IID_IWiaUIExtension             = GUIDOF!IWiaUIExtension;
const GUID IID_IWiaUIExtension2            = GUIDOF!IWiaUIExtension2;
const GUID IID_IWiaVideo                   = GUIDOF!IWiaVideo;
