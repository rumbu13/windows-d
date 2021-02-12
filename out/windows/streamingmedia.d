module windows.streamingmedia;

public import windows.com;
public import windows.displaydevices;
public import windows.mediafoundation;

extern(Windows):

const GUID IID_IMFDeviceTransform = {0xD818FBD8, 0xFC46, 0x42F2, [0x87, 0xAC, 0x1E, 0xA2, 0xD1, 0xF9, 0xBF, 0x32]};
@GUID(0xD818FBD8, 0xFC46, 0x42F2, [0x87, 0xAC, 0x1E, 0xA2, 0xD1, 0xF9, 0xBF, 0x32]);
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
    HRESULT GetStreamIDs(uint dwInputIDArraySize, uint* pdwInputStreamIds, uint dwOutputIDArraySize, uint* pdwOutputStreamIds);
    HRESULT ProcessEvent(uint dwInputStreamID, IMFMediaEvent pEvent);
    HRESULT ProcessInput(uint dwInputStreamID, IMFSample pSample, uint dwFlags);
    HRESULT ProcessMessage(MFT_MESSAGE_TYPE eMessage, uint ulParam);
    HRESULT ProcessOutput(uint dwFlags, uint cOutputBufferCount, MFT_OUTPUT_DATA_BUFFER* pOutputSample, uint* pdwStatus);
    HRESULT SetInputStreamState(uint dwStreamID, IMFMediaType pMediaType, DeviceStreamState value, uint dwFlags);
    HRESULT GetInputStreamState(uint dwStreamID, DeviceStreamState* value);
    HRESULT SetOutputStreamState(uint dwStreamID, IMFMediaType pMediaType, DeviceStreamState value, uint dwFlags);
    HRESULT GetOutputStreamState(uint dwStreamID, DeviceStreamState* value);
    HRESULT GetInputStreamPreferredState(uint dwStreamID, DeviceStreamState* value, IMFMediaType* ppMediaType);
    HRESULT FlushInputStream(uint dwStreamIndex, uint dwFlags);
    HRESULT FlushOutputStream(uint dwStreamIndex, uint dwFlags);
}

const GUID IID_IMFDeviceTransformCallback = {0x6D5CB646, 0x29EC, 0x41FB, [0x81, 0x79, 0x8C, 0x4C, 0x6D, 0x75, 0x08, 0x11]};
@GUID(0x6D5CB646, 0x29EC, 0x41FB, [0x81, 0x79, 0x8C, 0x4C, 0x6D, 0x75, 0x08, 0x11]);
interface IMFDeviceTransformCallback : IUnknown
{
    HRESULT OnBufferSent(IMFAttributes pCallbackAttributes, uint pinId);
}

enum MF_TRANSFER_VIDEO_FRAME_FLAGS
{
    MF_TRANSFER_VIDEO_FRAME_DEFAULT = 0,
    MF_TRANSFER_VIDEO_FRAME_STRETCH = 1,
    MF_TRANSFER_VIDEO_FRAME_IGNORE_PAR = 2,
}

enum MF_MEDIASOURCE_STATUS_INFO
{
    MF_MEDIASOURCE_STATUS_INFO_FULLYSUPPORTED = 0,
    MF_MEDIASOURCE_STATUS_INFO_UNKNOWN = 1,
}

struct FaceRectInfoBlobHeader
{
    uint Size;
    uint Count;
}

struct FaceRectInfo
{
    RECT Region;
    int confidenceLevel;
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
    int Value;
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
    uint Size;
    uint Bins;
    uint FourCC;
    uint ChannelMasks;
    HistogramGrid Grid;
}

struct HistogramDataHeader
{
    uint Size;
    uint ChannelMask;
    uint Linear;
}

