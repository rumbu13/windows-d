module windows.streamingmedia;

public import windows.core;
public import windows.com : HRESULT, IUnknown;
public import windows.displaydevices : RECT;
public import windows.mediafoundation : DeviceStreamState, IMFAttributes, IMFMediaEvent, IMFMediaType, IMFSample,
                                        MFT_MESSAGE_TYPE, MFT_OUTPUT_DATA_BUFFER;

extern(Windows):


// Enums


enum : int
{
    MF_TRANSFER_VIDEO_FRAME_DEFAULT    = 0x00000000,
    MF_TRANSFER_VIDEO_FRAME_STRETCH    = 0x00000001,
    MF_TRANSFER_VIDEO_FRAME_IGNORE_PAR = 0x00000002,
}
alias MF_TRANSFER_VIDEO_FRAME_FLAGS = int;

enum : int
{
    MF_MEDIASOURCE_STATUS_INFO_FULLYSUPPORTED = 0x00000000,
    MF_MEDIASOURCE_STATUS_INFO_UNKNOWN        = 0x00000001,
}
alias MF_MEDIASOURCE_STATUS_INFO = int;

// Structs


struct FaceRectInfoBlobHeader
{
    uint Size;
    uint Count;
}

struct FaceRectInfo
{
    RECT Region;
    int  confidenceLevel;
}

struct FaceCharacterizationBlobHeader
{
    uint Size;
    uint Count;
}

struct FaceCharacterization
{
    uint BlinkScoreLeft;
    uint BlinkScoreRight;
    uint FacialExpression;
    uint FacialExpressionScore;
}

struct CapturedMetadataExposureCompensation
{
    ulong Flags;
    int   Value;
}

struct CapturedMetadataISOGains
{
    float AnalogGain;
    float DigitalGain;
}

struct CapturedMetadataWhiteBalanceGains
{
    float R;
    float G;
    float B;
}

struct MetadataTimeStamps
{
    uint Flags;
    long Device;
    long Presentation;
}

struct HistogramGrid
{
    uint Width;
    uint Height;
    RECT Region;
}

struct HistogramBlobHeader
{
    uint Size;
    uint Histograms;
}

struct HistogramHeader
{
    uint          Size;
    uint          Bins;
    uint          FourCC;
    uint          ChannelMasks;
    HistogramGrid Grid;
}

struct HistogramDataHeader
{
    uint Size;
    uint ChannelMask;
    uint Linear;
}

// Interfaces

@GUID("D818FBD8-FC46-42F2-87AC-1EA2D1F9BF32")
interface IMFDeviceTransform : IUnknown
{
    HRESULT InitializeTransform(IMFAttributes pAttributes);
    HRESULT GetInputAvailableType(uint dwInputStreamID, uint dwTypeIndex, IMFMediaType* pMediaType);
    HRESULT GetInputCurrentType(uint dwInputStreamID, IMFMediaType* pMediaType);
    HRESULT GetInputStreamAttributes(uint dwInputStreamID, IMFAttributes* ppAttributes);
    HRESULT GetOutputAvailableType(uint dwOutputStreamID, uint dwTypeIndex, IMFMediaType* pMediaType);
    HRESULT GetOutputCurrentType(uint dwOutputStreamID, IMFMediaType* pMediaType);
    HRESULT GetOutputStreamAttributes(uint dwOutputStreamID, IMFAttributes* ppAttributes);
    HRESULT GetStreamCount(uint* pcInputStreams, uint* pcOutputStreams);
    HRESULT GetStreamIDs(uint dwInputIDArraySize, uint* pdwInputStreamIds, uint dwOutputIDArraySize, 
                         uint* pdwOutputStreamIds);
    HRESULT ProcessEvent(uint dwInputStreamID, IMFMediaEvent pEvent);
    HRESULT ProcessInput(uint dwInputStreamID, IMFSample pSample, uint dwFlags);
    HRESULT ProcessMessage(MFT_MESSAGE_TYPE eMessage, size_t ulParam);
    HRESULT ProcessOutput(uint dwFlags, uint cOutputBufferCount, MFT_OUTPUT_DATA_BUFFER* pOutputSample, 
                          uint* pdwStatus);
    HRESULT SetInputStreamState(uint dwStreamID, IMFMediaType pMediaType, DeviceStreamState value, uint dwFlags);
    HRESULT GetInputStreamState(uint dwStreamID, DeviceStreamState* value);
    HRESULT SetOutputStreamState(uint dwStreamID, IMFMediaType pMediaType, DeviceStreamState value, uint dwFlags);
    HRESULT GetOutputStreamState(uint dwStreamID, DeviceStreamState* value);
    HRESULT GetInputStreamPreferredState(uint dwStreamID, DeviceStreamState* value, IMFMediaType* ppMediaType);
    HRESULT FlushInputStream(uint dwStreamIndex, uint dwFlags);
    HRESULT FlushOutputStream(uint dwStreamIndex, uint dwFlags);
}

@GUID("6D5CB646-29EC-41FB-8179-8C4C6D750811")
interface IMFDeviceTransformCallback : IUnknown
{
    HRESULT OnBufferSent(IMFAttributes pCallbackAttributes, uint pinId);
}


// GUIDs


const GUID IID_IMFDeviceTransform         = GUIDOF!IMFDeviceTransform;
const GUID IID_IMFDeviceTransformCallback = GUIDOF!IMFDeviceTransformCallback;
