// Written in the D programming language.

module windows.streamingmedia;

public import windows.core;
public import windows.com : HRESULT, IUnknown;
public import windows.displaydevices : RECT;
public import windows.mediafoundation : DeviceStreamState, IMFAttributes, IMFMediaEvent,
                                        IMFMediaType, IMFSample, MFT_MESSAGE_TYPE,
                                        MFT_OUTPUT_DATA_BUFFER;

extern(Windows):


// Enums


///Flags to use when transferring a video frame from sink.
alias MF_TRANSFER_VIDEO_FRAME_FLAGS = int;
enum : int
{
    ///Use the default transfer behavior.
    MF_TRANSFER_VIDEO_FRAME_DEFAULT    = 0x00000000,
    ///Stretch the video frame.
    MF_TRANSFER_VIDEO_FRAME_STRETCH    = 0x00000001,
    MF_TRANSFER_VIDEO_FRAME_IGNORE_PAR = 0x00000002,
}

///Specifies the status of a media source.
alias MF_MEDIASOURCE_STATUS_INFO = int;
enum : int
{
    ///The media source is fully supported.
    MF_MEDIASOURCE_STATUS_INFO_FULLYSUPPORTED = 0x00000000,
    MF_MEDIASOURCE_STATUS_INFO_UNKNOWN        = 0x00000001,
}

// Structs


///The <b>FaceRectInfoBlobHeader</b> structure describes the size and count information of the blob format for the
///<b>MF_CAPTURE_METADATA_FACEROIS</b> attribute.
struct FaceRectInfoBlobHeader
{
    ///Size of this header + all following FaceRectInfo structures.
    uint Size;
    uint Count;
}

///The <b>FaceRectInfo</b> structure describes the blob format for the <b>MF_CAPTURE_METADATA_FACEROIS</b> attribute.
struct FaceRectInfo
{
    ///Relative coordinates on the frame that face detection is running (Q31 format).
    RECT Region;
    ///Confidence level of the region being a face (0 - 100).
    int  confidenceLevel;
}

///The <b>FaceCharacterizationBlobHeader</b> structure describes the size and count information of the blob format for
///the <b>MF_CAPTURE_METADATA_FACEROICHARACTERIZATIONS</b> attribute.
struct FaceCharacterizationBlobHeader
{
    ///Size of this header + all following FaceCharacterization structures.
    uint Size;
    uint Count;
}

///The <b>FaceCharacterization</b> structure describes the blob format for the
///<b>MF_CAPTURE_METADATA_FACEROICHARACTERIZATIONS</b> attribute.
struct FaceCharacterization
{
    ///0 indicates no blink for the left eye, 100 indicates definite blink for the left eye (0 - 100).
    uint BlinkScoreLeft;
    ///0 indicates no blink for the right eye, 100 indicates definite blink for the right eye (0 - 100).
    uint BlinkScoreRight;
    ///A defined facial expression value.
    uint FacialExpression;
    ///0 indicates no such facial expression as identified, 100 indicates definite such facial expression as defined (0
    ///- 100).
    uint FacialExpressionScore;
}

///This structure contains blob information for the EV compensation feedback for the photo captured.
struct CapturedMetadataExposureCompensation
{
    ///A KSCAMERA_EXTENDEDPROP_EVCOMP_XXX step flag.
    ulong Flags;
    int   Value;
}

///The CapturedMetadataISOGains structure describes the blob format for <b>MF_CAPTURE_METADATA_ISO_GAINS</b>.
struct CapturedMetadataISOGains
{
    float AnalogGain;
    float DigitalGain;
}

///This structure describes the blob format for the <b>MF_CAPTURE_METADATA_WHITEBALANCE_GAINS</b> attribute.
struct CapturedMetadataWhiteBalanceGains
{
    ///The <b>R</b> value of the blob.
    float R;
    ///The <b>G</b> value of the blob.
    float G;
    ///The <b>B</b> value of the blob.
    float B;
}

///The <b>MetadataTimeStamps</b> structure describes the blob format for the
///<b>MF_CAPTURE_METADATA_FACEROITIMESTAMPS</b> attribute.
struct MetadataTimeStamps
{
    ///Bitwise OR of the <b>MF_METADATATIMESTAMPS_*</b> flags.
    uint Flags;
    ///QPC time for the sample the face rectangle is derived from (in 100ns).
    long Device;
    ///PTS for the sample the face rectangle is derived from (in 100ns).
    long Presentation;
}

///The <b>HistogramGrid</b> structure describes the blob format for <b>MF_CAPTURE_METADATA_HISTOGRAM</b>.
struct HistogramGrid
{
    ///Width of the sensor output that histogram is collected from.
    uint Width;
    ///Height of the sensor output that histogram is collected from.
    uint Height;
    ///Absolute coordinates of the region on the sensor output that the histogram is collected for.
    RECT Region;
}

///The <b>HistogramBlobHeader</b> structure describes the blob size and the number of histograms in the blob for the
///<b>MF_CAPTURE_METADATA_HISTOGRAM</b> attribute.
struct HistogramBlobHeader
{
    ///Size of the entire histogram blob in bytes.
    uint Size;
    ///Number of histograms in the blob. Each histogram is identified by a HistogramHeader.
    uint Histograms;
}

///The <b>HistogramHeader</b> structure describes the blob format for <b>MF_CAPTURE_METADATA_HISTOGRAM</b>.
struct HistogramHeader
{
    ///Size of this header + (HistogramDataHeader + histogram data following) * number of channels available.
    uint          Size;
    ///Number of bins in the histogram.
    uint          Bins;
    ///Color space that the histogram is collected from
    uint          FourCC;
    ///Masks of the color channels that the histogram is collected for.
    uint          ChannelMasks;
    ///Grid that the histogram is collected from.
    HistogramGrid Grid;
}

///The <b>HistogramDataHeader</b> structure describes the blob format for the <b>MF_CAPTURE_METADATA_HISTOGRAM</b>
///attribute.
struct HistogramDataHeader
{
    ///Size in bytes of this header + all following histogram data.
    uint Size;
    ///Mask of the color channel for the histogram data.
    uint ChannelMask;
    ///1 if linear, 0 if nonlinear.
    uint Linear;
}

// Interfaces

///This section contains reference information for the <b>IMFDeviceTransform</b> interface.
@GUID("D818FBD8-FC46-42F2-87AC-1EA2D1F9BF32")
interface IMFDeviceTransform : IUnknown
{
    ///<b>InitializeTransform</b> is called to initialize the Device MFT.
    ///Params:
    ///    pAttributes = Optionally contains a pointer to an attribute, passed in by the capture pipeline that contains initialization
    ///                  parameters. Currently none defined.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include but not limited to values given in the
    ///    following table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Initialization succeeded </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>MF_E_INVALIDREQUEST</b></dt> </dl> </td> <td width="60%"> Device MFT could not support the
    ///    request at this time. </td> </tr> </table>
    ///    
    HRESULT InitializeTransform(IMFAttributes pAttributes);
    ///The <b>GetInputAvailableType</b> method gets an available media type for an input stream on this Media Foundation
    ///transform (MFT).
    ///Params:
    ///    dwInputStreamID = Input stream identifier. To get the list of stream identifiers, call IMFDeviceTransform::GetStreamID.
    ///    dwTypeIndex = Index of the media type to retrieve. Media types are indexed from zero and returned in approximate order of
    ///                  preference.
    ///    pMediaType = Receives a pointer to the IMFMediaType interface.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include but not limited to values given in the
    ///    following table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Initialization succeeded </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>MF_E_INVALIDREQUEST</b></dt> </dl> </td> <td width="60%"> Device MFT could not support the
    ///    request at this time. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>MF_E_INVALIDSTREAMNUMBER</b></dt> </dl>
    ///    </td> <td width="60%"> The stream ID is not valid. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>MF_E_NO_MORE_TYPES</b></dt> </dl> </td> <td width="60%"> There is no media type available with the
    ///    specified index. </td> </tr> </table>
    ///    
    HRESULT GetInputAvailableType(uint dwInputStreamID, uint dwTypeIndex, IMFMediaType* pMediaType);
    ///The <b>GetInputCurrentType</b> method gets the current media type for an input stream on this Media Foundation
    ///transform (MFT).
    ///Params:
    ///    dwInputStreamID = Input stream identifier. To get the list of stream identifiers, call IMFDeviceTransform::GetStreamIDs.
    ///    pMediaType = Receives a pointer to the IMFMediaType interface that represents the current type used by that stream.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include but not limited to values given in the
    ///    following table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Initialization succeeded </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>MF_E_INVALIDREQUEST</b></dt> </dl> </td> <td width="60%"> Device MFT could not support the
    ///    request at this time. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>MF_E_INVALIDSTREAMNUMBER</b></dt> </dl>
    ///    </td> <td width="60%"> The stream ID is not valid. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>MF_E_NO_MORE_TYPES</b></dt> </dl> </td> <td width="60%"> There is no media type available with the
    ///    specified index. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>MF_E_TRANSFORM_TYPE_NOT_SET</b></dt> </dl>
    ///    </td> <td width="60%"> No media type has been set yet. </td> </tr> </table>
    ///    
    HRESULT GetInputCurrentType(uint dwInputStreamID, IMFMediaType* pMediaType);
    ///The <b>GetInputStreamAttributes</b> method gets the attribute store for an input stream on this Media Foundation
    ///transform (MFT).
    ///Params:
    ///    dwInputStreamID = Stream ID of the input stream whose state needs to be retrieved.
    ///    ppAttributes = Receives a pointer to the IMFAttributes interface. The caller must release the interface.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include but not limited to values given in the
    ///    following table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Transitioning the stream state succeeded. </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>MF_E_INVALIDREQUEST</b></dt> </dl> </td> <td width="60%"> Device MFT could not
    ///    support the request at this time. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>MF_E_INVALIDSTREAMNUMBER</b></dt> </dl> </td> <td width="60%"> The stream ID is not valid. </td> </tr>
    ///    </table>
    ///    
    HRESULT GetInputStreamAttributes(uint dwInputStreamID, IMFAttributes* ppAttributes);
    ///The <b>GetOutputAvailableType</b> method gets an available media type for an output stream on this Media
    ///Foundation transform (MFT).
    ///Params:
    ///    dwOutputStreamID = Output stream identifier. To get the list of stream identifiers, call IMFDeviceTransform::GetStreamIDs.
    ///    dwTypeIndex = Index of the media type to retrieve. Media types are indexed from zero and returned in approximate order of
    ///                  preference.
    ///    pMediaType = Receives a pointer to the IMFMediaType interface.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include but not limited to values given in the
    ///    following table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Initialization succeeded </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>MF_E_INVALIDREQUEST</b></dt> </dl> </td> <td width="60%"> Device MFT could not support the
    ///    request at this time. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>MF_E_INVALIDSTREAMNUMBER</b></dt> </dl>
    ///    </td> <td width="60%"> The stream ID is not valid. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>MF_E_NO_MORE_TYPES</b></dt> </dl> </td> <td width="60%"> There is no media type available with the
    ///    specified index. </td> </tr> </table>
    ///    
    HRESULT GetOutputAvailableType(uint dwOutputStreamID, uint dwTypeIndex, IMFMediaType* pMediaType);
    ///The <b>GetOutputCurrentType</b> method gets the current media type for an output stream on this Media Foundation
    ///transform (MFT).
    ///Params:
    ///    dwOutputStreamID = Output stream identifier. To get the list of stream identifiers, call IMFDeviceTransform::GetStreamIDs.
    ///    pMediaType = Receives a pointer to the IMFMediaType interface that represents the current type used by that stream.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include but not limited to values given in the
    ///    following table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Initialization succeeded </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>MF_E_INVALIDREQUEST</b></dt> </dl> </td> <td width="60%"> Device MFT could not support the
    ///    request at this time. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>MF_E_INVALIDSTREAMNUMBER</b></dt> </dl>
    ///    </td> <td width="60%"> The stream ID is not valid. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>MF_E_NO_MORE_TYPES</b></dt> </dl> </td> <td width="60%"> There is no media type available with the
    ///    specified index. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>MF_E_TRANSFORM_TYPE_NOT_SET</b></dt> </dl>
    ///    </td> <td width="60%"> No media type has been set yet. </td> </tr> </table>
    ///    
    HRESULT GetOutputCurrentType(uint dwOutputStreamID, IMFMediaType* pMediaType);
    ///The <b>GetOutputStreamAttributes</b> method gets the attribute store for an output stream on this Media
    ///Foundation transform (MFT).
    ///Params:
    ///    dwOutputStreamID = The Stream ID of the output stream whose state needs to be retrieved.
    ///    ppAttributes = Receives a pointer to the IMFAttributes interface. The caller must release the interface.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include but not limited to values given in the
    ///    following table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Initialization succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>MF_E_INVALIDREQUEST</b></dt> </dl> </td> <td width="60%"> Device MFT could not support the
    ///    request at this time. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>MF_E_INVALIDSTREAMNUMBER</b></dt> </dl>
    ///    </td> <td width="60%"> Returned when an invalid stream ID is passed. </td> </tr> </table>
    ///    
    HRESULT GetOutputStreamAttributes(uint dwOutputStreamID, IMFAttributes* ppAttributes);
    ///The <b>GetStreamCount</b> method gets the current number of input and output streams on this Media Foundation
    ///transform (MFT).
    ///Params:
    ///    pcInputStreams = Receives the number of input streams.
    ///    pcOutputStreams = Receives the number of output streams.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to the values given in the
    ///    following table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Transitioning the stream state succeeded. </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> Invalid pointer passed. </td>
    ///    </tr> </table>
    ///    
    HRESULT GetStreamCount(uint* pcInputStreams, uint* pcOutputStreams);
    ///The <b>GetStreamIDs</b> method gets the stream identifiers for the input and output streams on this Media
    ///Foundation transform (MFT).
    ///Params:
    ///    dwInputIDArraySize = The number of elements in <i>pdwInputStreamIDs</i>
    ///    pdwInputStreamIds = A pointer to an array allocated by the caller. The method fills the array with the input stream identifiers.
    ///                        The array size must be at least equal to the number of input streams. To get the number of input streams,
    ///                        call IMFDeviceTransform::GetStreamCount. If the caller passes an array that is larger than the number of
    ///                        input streams, the MFT must not write values into the extra array entries.
    ///    dwOutputIDArraySize = The number of elements in <i>pdwOutputStreamIDs</i>.
    ///    pdwOutputStreamIds = A pointer to an array allocated by the caller. The method fills the array with the output stream identifiers.
    ///                         The array size must be at least equal to the number of output streams. To get the number of output streams,
    ///                         call IMFDeviceTransform::GetStreamCount.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include but not limited to values given in the
    ///    following table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Transitioning the stream state succeeded. </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> Invalid pointer passed. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>MF_E_BUFFERTOOSMALL</b></dt> </dl> </td> <td width="60%"> The buffer
    ///    coming in does not have enough space to fill in the stream IDs. </td> </tr> </table>
    ///    
    HRESULT GetStreamIDs(uint dwInputIDArraySize, uint* pdwInputStreamIds, uint dwOutputIDArraySize, 
                         uint* pdwOutputStreamIds);
    ///The <b>ProcessEvent</b> method sends an event to an input stream on this Media Foundation transform (MFT).
    ///Params:
    ///    dwInputStreamID = Stream identifier. To get the list of stream identifiers, call IMFDeviceTransform::GetStreamIDs.
    ///    pEvent = Pointer to the IMFMediaEvent interface of an event object.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include but not limited to values given in the
    ///    following table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The event processed successfully. The event will be
    ///    propagated down stream. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>MF_E_INVALIDSTREAMNUMBER</b></dt> </dl>
    ///    </td> <td width="60%"> An invalid stream ID was passed. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>MF_S_TRANSFORM_DO_NO_PROPOGATE_EVENT</b></dt> </dl> </td> <td width="60%"> Indicates that the Device
    ///    MFT does not want the event to be propagated further. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_NOTIMPL</b></dt> </dl> </td> <td width="60%"> The function is not implemented. </td> </tr> </table>
    ///    
    HRESULT ProcessEvent(uint dwInputStreamID, IMFMediaEvent pEvent);
    ///The <b>ProcessInput</b> method delivers data to an input stream on this Media Foundation transform (MFT).
    ///Params:
    ///    dwInputStreamID = Input stream identifier.
    ///    pSample = Pointer to the IMFSample interface of the input sample. The sample must contain at least one media buffer
    ///              that contains valid input data.
    ///    dwFlags = Must be zero.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include but not limited to values given in the
    ///    following table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Method succeeded. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> Invalid argument passed. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>MF_E_INVALIDREQUEST</b></dt> </dl> </td> <td width="60%"> Device MFT could not
    ///    support the request at this time. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>MF_E_INVAILIDSTREAMNUMBER</b></dt> </dl> </td> <td width="60%"> An invalid stream ID was passed. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>MF_E_INVALID_STREAM_STATE</b></dt> </dl> </td> <td width="60%"> The
    ///    requested stream transition is not possible. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>MF_E_TRANSFORM_TYPE_NOT_SET</b></dt> </dl> </td> <td width="60%"> Input media type has not been set.
    ///    </td> </tr> </table>
    ///    
    HRESULT ProcessInput(uint dwInputStreamID, IMFSample pSample, uint dwFlags);
    ///The <b>ProcessMessage</b> method sends a message to the Device Media Foundation transform (MFT).
    ///Params:
    ///    eMessage = The message to send, specified as a member of the MFT_MESSAGE_TYPE enumeration.
    ///    ulParam = Message parameter. The meaning of this parameter depends on the message type.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include but not limited to values given in the
    ///    following table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Method succeeded. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> Invalid argument passed. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>MF_E_INVALIDREQUEST</b></dt> </dl> </td> <td width="60%"> Device MFT could not
    ///    support the request at this time. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>MF_E_INVAILIDSTREAMNUMBER</b></dt> </dl> </td> <td width="60%"> An invalid stream ID was passed. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>MF_E_INVALID_STREAM_STATE</b></dt> </dl> </td> <td width="60%"> The
    ///    requested stream transition is not possible. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>MF_E_TRANSFORM_TYPE_NOT_SET</b></dt> </dl> </td> <td width="60%"> Input media type has not been set.
    ///    </td> </tr> </table>
    ///    
    HRESULT ProcessMessage(MFT_MESSAGE_TYPE eMessage, size_t ulParam);
    ///The <b>ProcessOutput</b> method gets the processed output from the Device MFT output streams.
    ///Params:
    ///    dwFlags = Bitwise OR of zero or more flags from the _MFT_PROCESS_OUTPUT_FLAGS enumeration.
    ///    cOutputBufferCount = Number of elements in the <i>pOutputSamples</i> array. The value must be at least 1.
    ///    pOutputSample = Pointer to an array of MFT_OUTPUT_DATA_BUFFER structures, allocated by the caller. The MFT uses this array to
    ///                    return output data to the caller.
    ///    pdwStatus = Receives a bitwise OR of zero or more flags from the _MFT_PROCESS_OUTPUT_STATUS enumeration.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include but not limited to values given in the
    ///    following table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Method succeeded. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> Invalid argument passed. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>MF_E_INVALIDREQUEST</b></dt> </dl> </td> <td width="60%"> Device MFT could not
    ///    support the request at this time. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>MF_E_INVAILIDSTREAMNUMBER</b></dt> </dl> </td> <td width="60%"> An invalid stream ID was passed. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>MF_E_INVALID_STREAM_STATE</b></dt> </dl> </td> <td width="60%"> The
    ///    requested stream transition is not possible. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>MF_E_TRANSFORM_TYPE_NOT_SET</b></dt> </dl> </td> <td width="60%"> Input media type has not been set.
    ///    </td> </tr> </table>
    ///    
    HRESULT ProcessOutput(uint dwFlags, uint cOutputBufferCount, MFT_OUTPUT_DATA_BUFFER* pOutputSample, 
                          uint* pdwStatus);
    ///The <b>SetInputStreamState</b> method sets the Device MFT input stream state and media type.
    ///Params:
    ///    dwStreamID = Stream ID of the input stream where the state and media type needs to be changed.
    ///    pMediaType = Preferred media type for the input stream is passed in through this parameter. Device MFT should change the
    ///                 media type only if the incoming media type is different from the current media type.
    ///    value = Specifies the <b>DeviceStreamState</b> which the input stream should transition to.
    ///    dwFlags = When <b>S_OK</b> is returned, perform the state change operation. Otherwise, this contains an error that
    ///              occurred while setting the media type on the devproxy output pin. In this case, propagate the error
    ///              appropriately.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include but not limited to values given in the
    ///    following table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Initialization succeeded </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>MF_E_INVALIDREQUEST</b></dt> </dl> </td> <td width="60%"> Device MFT could not support the
    ///    request at this time. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>MF_E_INVAILIDSTREAMNUMBER</b></dt> </dl>
    ///    </td> <td width="60%"> An invalid stream ID was passed. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>MF_E_INVALID_STREAM_STATE</b></dt> </dl> </td> <td width="60%"> The requested stream transition is not
    ///    possible. </td> </tr> </table>
    ///    
    HRESULT SetInputStreamState(uint dwStreamID, IMFMediaType pMediaType, DeviceStreamState value, uint dwFlags);
    ///The <b>GetInputStreamState</b> method gets the Device MFT’s input stream state.
    ///Params:
    ///    dwStreamID = Stream ID of the input stream whose state needs to be retrieved.
    ///    value = Specifies the current <b>DeviceStreamState</b> of the specified input Device MFT stream.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include but not limited to values given in the
    ///    following table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Transitioning the stream state succeeded. </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>MF_E_INVALIDREQUEST</b></dt> </dl> </td> <td width="60%"> Device MFT could not
    ///    support the request at this time. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>MF_E_INVAILIDSTREAMNUMBER</b></dt> </dl> </td> <td width="60%"> An invalid stream ID was passed. </td>
    ///    </tr> </table>
    ///    
    HRESULT GetInputStreamState(uint dwStreamID, DeviceStreamState* value);
    ///The <b>SetOutputStreamState</b> method sets the Device MFT output stream state and media type.
    ///Params:
    ///    dwStreamID = Stream ID of the input stream where the state and media type needs to be changed.
    ///    pMediaType = Preferred media type for the input stream is passed in through this parameter. Device MFT should change the
    ///                 media type only if the incoming media type is different from the current media type.
    ///    value = Specifies the <b>DeviceStreamState</b> which the input stream should transition to.
    ///    dwFlags = Must be zero.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include but not limited to values given in the
    ///    following table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Transitioning the stream state succeeded. </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>MF_E_INVALIDREQUEST</b></dt> </dl> </td> <td width="60%"> Device MFT could not
    ///    support the request at this time. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>MF_E_INVAILIDSTREAMNUMBER</b></dt> </dl> </td> <td width="60%"> An invalid stream ID was passed. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>MF_E_INVALID_STREAM_STATE</b></dt> </dl> </td> <td width="60%"> The
    ///    requested stream transition is not possible. </td> </tr> </table>
    ///    
    HRESULT SetOutputStreamState(uint dwStreamID, IMFMediaType pMediaType, DeviceStreamState value, uint dwFlags);
    ///The <b>GetOutputStreamState</b> method gets the Device MFT’s output stream state.
    ///Params:
    ///    dwStreamID = Stream ID of the output stream whose state needs to be retrieved.
    ///    value = Specifies the current <b>DeviceStreamState</b> of the specified output Device MFT stream.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include but not limited to values given in the
    ///    following table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Transitioning the stream state succeeded. </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>MF_E_INVALIDREQUEST</b></dt> </dl> </td> <td width="60%"> Device MFT could not
    ///    support the request at this time. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>MF_E_INVAILIDSTREAMNUMBER</b></dt> </dl> </td> <td width="60%"> An invalid stream ID was passed. </td>
    ///    </tr> </table>
    ///    
    HRESULT GetOutputStreamState(uint dwStreamID, DeviceStreamState* value);
    ///The <b>GetInputStreamPreferredState</b> method gets a Device MFT input stream’s preferred state and media type.
    ///Params:
    ///    dwStreamID = Stream ID of the input stream whose state needs to be retrieved.
    ///    value = Specifies the current <b>DeviceStreamState</b> of the specified input Device MFT stream.
    ///    ppMediaType = Preferred media type for the input stream is passed in through this parameter.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include but not limited to values given in the
    ///    following table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Transitioning the stream state succeeded. </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>MF_E_INVALIDREQUEST</b></dt> </dl> </td> <td width="60%"> Device MFT could not
    ///    support the request at this time. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>MF_E_INVAILIDSTREAMNUMBER</b></dt> </dl> </td> <td width="60%"> An invalid stream ID was passed. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>MF_E_INVALID_STREAM_STATE</b></dt> </dl> </td> <td width="60%"> The
    ///    requested stream transition is not possible. </td> </tr> </table>
    ///    
    HRESULT GetInputStreamPreferredState(uint dwStreamID, DeviceStreamState* value, IMFMediaType* ppMediaType);
    ///The <b>FlushInputStream</b> method flushes a Device MFT’s input stream.
    ///Params:
    ///    dwStreamIndex = Stream ID of the input stream which needs to be flushed.
    ///    dwFlags = Contains the <b>HRESULT</b> of flushing the corresponding devproxy output stream.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include but not limited to values given in the
    ///    following table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Transitioning the stream state succeeded. </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>MF_E_INVALIDREQUEST</b></dt> </dl> </td> <td width="60%"> Device MFT could not
    ///    support the request at this time. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>MF_E_INVAILIDSTREAMNUMBER</b></dt> </dl> </td> <td width="60%"> An invalid stream ID was passed. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>MF_E_INVALID_STREAM_STATE</b></dt> </dl> </td> <td width="60%"> The
    ///    requested stream transition is not possible. </td> </tr> </table>
    ///    
    HRESULT FlushInputStream(uint dwStreamIndex, uint dwFlags);
    ///The <b>FlushOutputStream</b> method flushes a Device MFT’s output stream.
    ///Params:
    ///    dwStreamIndex = Stream ID of the output stream which needs to be flushed.
    ///    dwFlags = Must be zero.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include but not limited to values given in the
    ///    following table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Transitioning the stream state succeeded. </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>MF_E_INVALIDREQUEST</b></dt> </dl> </td> <td width="60%"> Device MFT could not
    ///    support the request at this time. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>MF_E_INVAILIDSTREAMNUMBER</b></dt> </dl> </td> <td width="60%"> An invalid stream ID was passed. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>MF_E_INVALID_STREAM_STATE</b></dt> </dl> </td> <td width="60%"> The
    ///    requested stream transition is not possible. </td> </tr> </table>
    ///    
    HRESULT FlushOutputStream(uint dwStreamIndex, uint dwFlags);
}

///<p class="CCE_Message">[Some information relates to pre-released product which may be substantially modified before
///it's commercially released. Microsoft makes no warranties, express or implied, with respect to the information
///provided here.] Implement this callback to receive notifications when system-allocated frame buffers are sent to the
///device driver.
@GUID("6D5CB646-29EC-41FB-8179-8C4C6D750811")
interface IMFDeviceTransformCallback : IUnknown
{
    ///<p class="CCE_Message">[Some information relates to pre-released product which may be substantially modified
    ///before it's commercially released. Microsoft makes no warranties, express or implied, with respect to the
    ///information provided here.] Called when system-allocated frame buffers are sent to the device driver.
    ///Params:
    ///    pCallbackAttributes = The attributes containing the callback data. The System-allocated frame buffer information is stored in the
    ///                          attribute with the MF_DMFT_FRAME_BUFFER_INFO key.
    ///    pinId = The identifier of the device pin to which the frame buffers are sent.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT OnBufferSent(IMFAttributes pCallbackAttributes, uint pinId);
}


// GUIDs


const GUID IID_IMFDeviceTransform         = GUIDOF!IMFDeviceTransform;
const GUID IID_IMFDeviceTransformCallback = GUIDOF!IMFDeviceTransformCallback;
