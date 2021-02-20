// Written in the D programming language.

module windows.xaudio2;

public import windows.core;
public import windows.com : HRESULT, IUnknown;
public import windows.coreaudio : AUDIO_STREAM_CATEGORY;
public import windows.multimedia : WAVEFORMATEX;
public import windows.systemservices : BOOL, PWSTR;

extern(Windows) @nogc nothrow:


// Enums


///Describes the contents of a stream buffer.
alias XAPO_BUFFER_FLAGS = int;
enum : int
{
    ///Stream buffer contains only silent samples.
    XAPO_BUFFER_SILENT = 0x00000000,
    ///Stream buffer contains audio data to be processed.
    XAPO_BUFFER_VALID  = 0x00000001,
}

///Indicates the filter type.
alias XAUDIO2_FILTER_TYPE = int;
enum : int
{
    ///Attenuates (reduces) frequencies above the cutoff frequency.
    LowPassFilter         = 0x00000000,
    ///Attenuates frequencies outside a given range.
    BandPassFilter        = 0x00000001,
    ///Attenuates frequencies below the cutoff frequency.
    HighPassFilter        = 0x00000002,
    ///Attenuates frequencies inside a given range.
    NotchFilter           = 0x00000003,
    ///Attenuates frequencies above the cutoff frequency. This is a one-pole filter, and
    ///XAUDIO2_FILTER_PARAMETERS.<b>OneOverQ</b> has no effect.
    LowPassOnePoleFilter  = 0x00000004,
    ///Attenuates frequencies below the cutoff frequency. This is a one-pole filter, and
    ///XAUDIO2_FILTER_PARAMETERS.<b>OneOverQ</b> has no effect.
    HighPassOnePoleFilter = 0x00000005,
}

///Indicates one of several stock directivity patterns.
enum HrtfDirectivityType : int
{
    ///The sound emission is in all directions.
    OmniDirectional = 0x00000000,
    ///The sound emission is a cardioid shape.
    Cardioid        = 0x00000001,
    ///The sound emission is a cone.
    Cone            = 0x00000002,
}

///Indicates one of several stock environment types.
enum HrtfEnvironment : int
{
    ///A small room.
    Small    = 0x00000000,
    ///A medium-sized room.
    Medium   = 0x00000001,
    ///A large, enclosed space.
    Large    = 0x00000002,
    ///An outdoor space.
    Outdoors = 0x00000003,
}

///Indicates a distance-based decay type applied to a sound.
enum HrtfDistanceDecayType : int
{
    ///Simulates natural decay with distance, as constrained by minimum and maximum gain distance limits. Drops to
    ///silence at rolloff distance.
    NaturalDecay = 0x00000000,
    ///Used to set up a custom gain curve, within the maximum and minimum gain limit.
    CustomDecay  = 0x00000001,
}

// Structs


///Describes general characteristics of an XAPO. Used with IXAPO::GetRegistrationProperties,
///CXAPOParametersBase::CXAPOParametersBase, and CXAPOBase::CXAPOBase.
struct XAPO_REGISTRATION_PROPERTIES
{
align (1):
    ///COM class ID for use with the CoCreateInstance function.
    GUID        clsid;
    ///Friendly name, a unicode string.
    ushort[256] FriendlyName;
    ///Copyright information, a unicode string.
    ushort[256] CopyrightInfo;
    ///Major version number.
    uint        MajorVersion;
    ///Minor version number.
    uint        MinorVersion;
    ///XAPO property flags that describe the general characteristics of process behavior. These flags are described in
    ///the following table. <table> <tr> <th>Flag</th> <th>Description</th> </tr> <tr>
    ///<td>XAPO_FLAG_INPLACE_SUPPORTED</td> <td> XAPO supports in-place processing: the input stream buffer and output
    ///stream buffer can be the same buffer depending on the input. For example, consider an effect which may be ran in
    ///stereo to 5.1 mode or mono to mono mode. When set to stereo to 5.1, it will be run with separate input and output
    ///buffers as format conversion is not permitted in-place. However, if configured to run mono to mono, the same XAPO
    ///can be run in-place. Thus the same implementation may be conveniently reused for various input/output
    ///configurations, while taking advantage of in-place processing when possible. </td> </tr> <tr>
    ///<td>XAPO_FLAG_INPLACE_REQUIRED</td> <td>XAPO requires in-place processing: the input stream buffer and output
    ///stream buffer must be the same buffer. When the XAPO_FLAG_INPLACE_REQUIRED is used the XAPO cannot perform format
    ///conversions.</td> </tr> <tr> <td>XAPO_FLAG_CHANNELS_MUST_MATCH</td> <td>Channel count of the input and output
    ///streams must match.</td> </tr> <tr> <td>XAPO_FLAG_FRAMERATE_MUST_MATCH</td> <td>Framerate of input and output
    ///streams must match.</td> </tr> <tr> <td>XAPO_FLAG_BITSPERSAMPLE_MUST_MATCH</td> <td>Bit depth and container size
    ///of input and output streams must match.</td> </tr> <tr> <td>XAPO_FLAG_BUFFERCOUNT_MUST_MATCH</td> <td>Number of
    ///input and output buffers must match, applies to XAPO_LOCKFORPROCESS_BUFFER_PARAMETERS. When the
    ///XAPO_FLAG_BUFFERCOUNT_MUST_MATCH flag is set <b>XAPO_REGISTRATION_PROPERTIES</b>.<b>MinInputBufferCount</b> must
    ///equal <b>XAPO_REGISTRATION_PROPERTIES</b>.<b>MinOutputBufferCount</b> and
    ///<b>XAPO_REGISTRATION_PROPERTIES</b>.<b>MaxInputBufferCount</b> must equal
    ///<b>XAPO_REGISTRATION_PROPERTIES</b>.<b>MaxOutputBufferCount</b>. </td> </tr> <tr> <td>XAPOBASE_DEFAULT_FLAG</td>
    ///<td>XAPO_FLAG_CHANNELS_MUST_MATCH | XAPO_FLAG_FRAMERATE_MUST_MATCH | XAPO_FLAG_BITSPERSAMPLE_MUST_MATCH |
    ///XAPO_FLAG_BUFFERCOUNT_MUST_MATCH | XAPO_FLAG_INPLACE_SUPPORTED </td> </tr> </table>
    uint        Flags;
    ///Minimum number of input streams required for processing.
    uint        MinInputBufferCount;
    ///Maximum number of input streams required for processing. <div class="alert"><b>Note</b>
    ///<i>MaxInputBufferCount</i> is currently limited to a value of 1.</div> <div> </div>
    uint        MaxInputBufferCount;
    ///Minimum number of output streams required for processing.
    uint        MinOutputBufferCount;
    ///Maximum number of output streams required for processing. <div class="alert"><b>Note</b>
    ///<i>MaxOutputBufferCount</i> is currently limited to a value of 1.</div> <div> </div>
    uint        MaxOutputBufferCount;
}

///Defines stream buffer parameters that remain constant while an XAPO is locked. Used with the IXAPO::LockForProcess
///method.
struct XAPO_LOCKFORPROCESS_PARAMETERS
{
align (1):
    ///A WAVFORMATEX describing the format for the stream buffer.
    const(WAVEFORMATEX)* pFormat;
    ///Maximum number of frames in the stream buffer that IXAPO::Process would ever be required to handle, irrespective
    ///of dynamic parameter settings.
    uint                 MaxFrameCount;
}

///Defines stream buffer parameters that may change from one call to the next. Used with the Process method.
struct XAPO_PROCESS_BUFFER_PARAMETERS
{
align (1):
    ///Pointer to a stream buffer that contains audio data. The buffer must be 16-byte aligned, non-NULL, and must be at
    ///least XAPO_LOCKFORPROCESS_BUFFER_PARAMETERS.MaxFrameCount frames in size.
    void*             pBuffer;
    ///An XAPO_BUFFER_FLAGS enumeration describing the contents of the stream buffer.
    XAPO_BUFFER_FLAGS BufferFlags;
    ///Number of frames to process; this value must be within the range 0 to
    ///XAPO_LOCKFORPROCESS_BUFFER_PARAMETERS.MaxFrameCount.
    uint              ValidFrameCount;
}

///Parameters for use with the FXEQ XAPO.
struct FXEQ_PARAMETERS
{
align (1):
    ///Center frequency in Hz for band 0. Must be between FXEQ_MIN_FREQUENCY_CENTER and FXEQ_MAX_FREQUENCY_CENTER.
    float FrequencyCenter0;
    ///The boost or decrease to frequencies in band 0. Must be between FXEQ_MIN_GAIN and FXEQ_MAX_GAIN
    float Gain0;
    ///Width of band 0. Must be between FXEQ_MIN_BANDWIDTH and FXEQ_MAX_BANDWIDTH.
    float Bandwidth0;
    ///Center frequency in Hz for band 1. Must be between FXEQ_MIN_FREQUENCY_CENTER and FXEQ_MAX_FREQUENCY_CENTER.
    float FrequencyCenter1;
    ///The boost or decrease to frequencies in band 1. Must be between FXEQ_MIN_GAIN and FXEQ_MAX_GAIN
    float Gain1;
    ///Width of band 1. Must be between FXEQ_MIN_BANDWIDTH and FXEQ_MAX_BANDWIDTH.
    float Bandwidth1;
    ///Center frequency in Hz for band 2. Must be between FXEQ_MIN_FREQUENCY_CENTER and FXEQ_MAX_FREQUENCY_CENTER.
    float FrequencyCenter2;
    ///The boost or decrease to frequencies in band 2. Must be between FXEQ_MIN_GAIN and FXEQ_MAX_GAIN
    float Gain2;
    ///Width of band 2. Must be between FXEQ_MIN_BANDWIDTH and FXEQ_MAX_BANDWIDTH.
    float Bandwidth2;
    ///Center frequency in Hz for band 3. Must be between FXEQ_MIN_FREQUENCY_CENTER and FXEQ_MAX_FREQUENCY_CENTER.
    float FrequencyCenter3;
    ///The boost or decrease to frequencies in band 3. Must be between FXEQ_MIN_GAIN and FXEQ_MAX_GAIN
    float Gain3;
    ///Width of band 3. Must be between FXEQ_MIN_BANDWIDTH and FXEQ_MAX_BANDWIDTH.
    float Bandwidth3;
}

///Parameters for use with the FXMasteringLimiter XAPO.
struct FXMASTERINGLIMITER_PARAMETERS
{
align (1):
    ///Speed, in milliseconds, at which the limiter stops affecting audio after the audio drops below the limiter's
    ///threshold, which is specified by the <b>Loudness</b> member. This value must be between
    ///FXMASTERINGLIMITER_MIN_RELEASE (1) and FXMASTERINGLIMITER_MAX_RELEASE (20) and defaults to
    ///FXMASTERINGLIMITER_DEFAULT_RELEASE (6).
    uint Release;
    ///Loudness metric threshold of the limiter. This value must be between FXMASTERINGLIMITER_MIN_LOUDNESS (1) and
    ///FXMASTERINGLIMITER_MAX_LOUDNESS (1800) and defaults to FXMASTERINGLIMITER_DEFAULT_LOUDNESS (1000).
    uint Loudness;
}

///Parameters for use with the FXReverb XAPO.
struct FXREVERB_PARAMETERS
{
align (1):
    ///Controls the character of the individual wall reflections. Set to minimum value to simulate a hard flat surface
    ///and to maximum value to simulate a diffuse surface.Value must be between FXREVERB_MIN_DIFFUSION and
    ///FXREVERB_MAX_DIFFUSION.
    float Diffusion;
    ///Size of the room. Value must be between FXREVERB_MIN_ROOMSIZE and FXREVERB_MAX_ROOMSIZE. Note that physical
    ///meaning of RoomSize is subjective and not tied to any particular units. A smaller value will result in
    ///reflections reaching the listener more quickly while reflections will take longer with larger values for
    ///RoomSize.
    float RoomSize;
}

///Initialization parameters for use with the FXECHO XAPOFX.
struct FXECHO_INITDATA
{
align (1):
    ///Maximum delay (all channels) in milliseconds. This must be within <b>FXECHO_MIN_DELAY</b> and
    ///<b>FXECHO_MAX_DELAY</b>.
    float MaxDelay;
}

///Parameters for use with the FXECHO XAPOFX.
struct FXECHO_PARAMETERS
{
align (1):
    ///Ratio of wet (processed) signal to dry (original) signal.
    float WetDryMix;
    ///Amount of output to feed back into input.
    float Feedback;
    ///Delay to all channels in milliseconds. This value must be between <b>FXECHO_MIN_DELAY</b> and
    ///FXECHO_INITDATA.<b>MaxDelay</b>.
    float Delay;
}

///Contains information about the creation flags, input channels, and sample rate of a voice.
struct XAUDIO2_VOICE_DETAILS
{
align (1):
    ///Flags used to create the voice; see the individual voice interfaces for more information.
    uint CreationFlags;
    ///Flags that are currently set on the voice.
    uint ActiveFlags;
    ///The number of input channels the voice expects.
    uint InputChannels;
    ///The input sample rate the voice expects.
    uint InputSampleRate;
}

///Defines a destination voice that is the target of a send from another voice and specifies whether a filter should be
///used.
struct XAUDIO2_SEND_DESCRIPTOR
{
align (1):
    ///Indicates whether a filter should be used on data sent to the voice pointed to by <b>pOutputVoice</b>. Flags can
    ///be 0 or XAUDIO2_SEND_USEFILTER.
    uint          Flags;
    ///A pointer to an IXAudio2Voice that will be the target of the send. The <b>pOutputVoice</b> member cannot be NULL.
    IXAudio2Voice pOutputVoice;
}

///Defines a set of voices to receive data from a single output voice.
struct XAUDIO2_VOICE_SENDS
{
align (1):
    ///Number of voices to receive the output of the voice. An <b>OutputCount</b> value of 0 indicates the voice should
    ///not send output to any voices.
    uint SendCount;
    ///Array of XAUDIO2_SEND_DESCRIPTOR structures describing destination voices and the filters that should be used
    ///when sending to the voices. This array should contain <b>SendCount</b> elements. If <b>SendCount</b> is 0
    ///<b>pSends</b> should be NULL. Note that <b>pSends</b> cannot contain the same voice more than once.
    XAUDIO2_SEND_DESCRIPTOR* pSends;
}

///Contains information about an XAPO for use in an effect chain.
struct XAUDIO2_EFFECT_DESCRIPTOR
{
align (1):
    ///Pointer to the <b>IUnknown</b> interface of the XAPO object.
    IUnknown pEffect;
    ///TRUE if the effect should begin in the enabled state. Otherwise, FALSE.
    BOOL     InitialState;
    ///Number of output channels the effect should produce.
    uint     OutputChannels;
}

///Defines an effect chain.
struct XAUDIO2_EFFECT_CHAIN
{
align (1):
    ///Number of effects in the effect chain for the voice.
    uint EffectCount;
    ///Array of XAUDIO2_EFFECT_DESCRIPTOR structures containing pointers to XAPO instances.
    XAUDIO2_EFFECT_DESCRIPTOR* pEffectDescriptors;
}

///Defines filter parameters for a source voice.
struct XAUDIO2_FILTER_PARAMETERS
{
align (1):
    ///The XAUDIO2_FILTER_TYPE.
    XAUDIO2_FILTER_TYPE Type;
    ///Filter radian frequency calculated as (2 * sin(pi * (desired filter cutoff frequency) / sampleRate)). The
    ///frequency must be greater than or equal to 0 and less than or equal to XAUDIO2_MAX_FILTER_FREQUENCY. The maximum
    ///frequency allowable is equal to the source sound's sample rate divided by six which corresponds to the maximum
    ///filter radian frequency of 1. For example, if a sound's sample rate is 48000 and the desired cutoff frequency is
    ///the maximum allowable value for that sample rate, 8000, the value for <b>Frequency</b> will be 1. If
    ///XAUDIO2_HELPER_FUNCTIONS is defined, XAudio2.h will include the XAudio2RadiansToCutoffFrequency and
    ///XAudio2CutoffFrequencyToRadians helper functions for converting between hertz and radian frequencies. Defining
    ///XAUDIO2_HELPER_FUNCTIONS will also include XAudio2CutoffFrequencyToOnePoleCoefficient for converting between
    ///hertz and a one-pole coefficient suitable for use with the LowPassOnePoleFilter and HighPassOnePoleFilter.
    float               Frequency;
    ///Reciprocal of Q factor. Controls how quickly frequencies beyond Frequency are dampened. Larger values result in
    ///quicker dampening while smaller values cause dampening to occur more gradually. Must be greater than 0 and less
    ///than or equal to XAUDIO2_MAX_FILTER_ONEOVERQ.
    float               OneOverQ;
}

///Represents an audio data buffer, used with IXAudio2SourceVoice::SubmitSourceBuffer.
struct XAUDIO2_BUFFER
{
align (1):
    ///Flags that provide additional information about the audio buffer. May be 0, or the following value. <table> <tr>
    ///<th>Value</th> <th>Description</th> </tr> <tr> <td>XAUDIO2_END_OF_STREAM</td> <td>Indicates that there cannot be
    ///any buffers in the queue after this buffer. The only effect of this flag is to suppress debug output warnings
    ///caused by starvation of the buffer queue. </td> </tr> </table>
    uint          Flags;
    ///Size of the audio data, in bytes. Must be no larger than XAUDIO2_MAX_BUFFER_BYTES (defined in xaudio2.h) for PCM
    ///data and no larger than XMA_READBUFFER_MAX_BYTES (defined in xma2defs.h) for XMA data. <div
    ///class="alert"><b>Note</b> XMA buffers submitted to an XAudio2 voice using IXAudio2SourceVoice::SubmitSourceBuffer
    ///must contain complete XMA blocks. A complete XMA block must be equal in size to the
    ///<b>XMA2WAVEFORMATEX.BytesPerBlock</b> value, except for the last XMA block in a file, which may be shorter but
    ///will still be considered complete.</div> <div> </div>
    uint          AudioBytes;
    ///Pointer to the audio data. <table> <tr> <th>Xbox 360</th> </tr> <tr> <td> The memory allocated for a buffer
    ///containing XMA data must have a block alignment of 2048. This is accomplished using <b>XPhysicalAlloc</b> with
    ///the <i>ulAlignment</i> argument set to 2048. </td> </tr> </table>
    const(ubyte)* pAudioData;
    ///First sample in the buffer that should be played. For XMA buffers this value must be a multiple of 128 samples.
    uint          PlayBegin;
    ///Length of the region to be played, in samples. A value of zero means to play the entire buffer, and, in this
    ///case, <i>PlayBegin</i> must be zero as well. For ADPCM data this value must be a multiple of
    ///<b>wSamplesPerBlock</b> in the <b>ADPCMWAVEFORMAT</b> structure that contains this <b>XAUDIO2_BUFFER</b>
    ///structure.
    uint          PlayLength;
    ///First sample of the region to be looped. The value of <i>LoopBegin</i> must be less than <i>PlayBegin</i> +
    ///<i>PlayLength</i>. <i>LoopBegin</i> can be less than <i>PlayBegin</i>. <i>LoopBegin</i> must be 0 if
    ///<i>LoopCount</i> is 0.
    uint          LoopBegin;
    ///Length of the loop region, in samples. The value of <i>LoopBegin</i>+<i>LoopLength</i> must be greater than
    ///<i>PlayBegin</i> and less than <i>PlayBegin</i> + <i>PlayLength</i>. <i>LoopLength</i> must be zero if LoopCount
    ///is 0. If <i>LoopCount</i> is not 0 then a loop length of zero indicates the entire sample should be looped. For
    ///ADPCM data this value must be a multiple of <b>wSamplesPerBlock</b> in the <b>ADPCMWAVEFORMAT</b> structure that
    ///contains this <b>XAUDIO2_BUFFER</b> structure.
    uint          LoopLength;
    ///Number of times to loop through the loop region. This value can be between 0 and XAUDIO2_MAX_LOOP_COUNT. If
    ///<i>LoopCount</i> is zero no looping is performed and <i>LoopBegin</i> and <i>LoopLength</i> must be 0. To loop
    ///forever, set <i>LoopCount</i> to XAUDIO2_LOOP_INFINITE.
    uint          LoopCount;
    ///Context value to be passed back in callbacks to the client. This may be NULL.
    void*         pContext;
}

///Used with IXAudio2SourceVoice::SubmitSourceBuffer when submitting xWMA data.
struct XAUDIO2_BUFFER_WMA
{
align (1):
    ///Decoded packet cumulative data size array, each element is the number of bytes accumulated after the
    ///corresponding xWMA packet is decoded in order, must have <b>PacketCount</b> elements.
    const(uint)* pDecodedPacketCumulativeBytes;
    ///Number of xWMA packets submitted, must be &gt;= 1 and divide evenly into the respective
    ///XAUDIO2_BUFFER.<b>AudioBytes</b> value passed to IXAudio2SourceVoice::SubmitSourceBuffer.
    uint         PacketCount;
}

///Returns the voice's current state and cursor position data.
struct XAUDIO2_VOICE_STATE
{
align (1):
    ///Pointer to a buffer context provided in the XAUDIO2_BUFFER that is processed currently, or, if the voice is
    ///stopped currently, to the next buffer due to be processed. <b>pCurrentBufferContext</b> is NULL if there are no
    ///buffers in the queue.
    void* pCurrentBufferContext;
    ///Number of audio buffers currently queued on the voice, including the one that is processed currently.
    uint  BuffersQueued;
    ///Total number of samples processed by this voice since it last started, or since the last audio stream ended (as
    ///marked with the XAUDIO2_END_OF_STREAM flag). This total includes samples played multiple times due to looping.
    ///Theoretically, if all audio emitted by the voice up to this time is captured, this parameter would be the length
    ///of the audio stream in samples. If you specify <b>XAUDIO2_VOICE_NOSAMPLESPLAYED</b> when you call
    ///IXAudio2SourceVoice::GetState, this member won't be calculated, and its value is unspecified on return from
    ///<b>IXAudio2SourceVoice::GetState</b>. <b>IXAudio2SourceVoice::GetState</b> takes about one-third as much time to
    ///complete when you specify <b>XAUDIO2_VOICE_NOSAMPLESPLAYED</b>.
    ulong SamplesPlayed;
}

///Contains performance information.
struct XAUDIO2_PERFORMANCE_DATA
{
align (1):
    ///CPU cycles spent on audio processing since the last call to the IXAudio2::StartEngine or
    ///IXAudio2::GetPerformanceData function.
    ulong AudioCyclesSinceLastQuery;
    ///Total CPU cycles elapsed since the last call. <div class="alert"><b>Note</b> This only counts cycles on the CPU
    ///on which XAudio2 is running.</div> <div> </div>
    ulong TotalCyclesSinceLastQuery;
    ///Fewest CPU cycles spent on processing any single audio quantum since the last call.
    uint  MinimumCyclesPerQuantum;
    ///Most CPU cycles spent on processing any single audio quantum since the last call.
    uint  MaximumCyclesPerQuantum;
    ///Total memory currently in use.
    uint  MemoryUsageInBytes;
    ///Minimum delay that occurs between the time a sample is read from a source buffer and the time it reaches the
    ///speakers. <table> <tr> <th>Windows</th> </tr> <tr> <td>The delay reported is a variable value equal to the rough
    ///distance between the last sample submitted to the driver by XAudio2 and the sample currently playing. The
    ///following factors can affect the delay: playing multichannel audio on a hardware-accelerated device; the type of
    ///audio device (WavePci, WaveCyclic, or WaveRT); and, to a lesser extent, audio hardware implementation. </td>
    ///</tr> </table> <table> <tr> <th>Xbox 360</th> </tr> <tr> <td>The delay reported is a fixed value, which is
    ///normally 1,024 samples (21.333 ms at 48 kHz). If <b>XOverrideSpeakerConfig</b> has been called using the
    ///<b>XAUDIOSPEAKERCONFIG_LOW_LATENCY</b> flag, the delay reported is 512 samples (10.667 ms at 48 kHz). </td> </tr>
    ///</table>
    uint  CurrentLatencyInSamples;
    ///Total audio dropouts since the engine started.
    uint  GlitchesSinceEngineStarted;
    ///Number of source voices currently playing.
    uint  ActiveSourceVoiceCount;
    ///Total number of source voices currently in existence.
    uint  TotalSourceVoiceCount;
    ///Number of submix voices currently playing.
    uint  ActiveSubmixVoiceCount;
    ///Number of resampler xAPOs currently active.
    uint  ActiveResamplerCount;
    ///Number of matrix mix xAPOs currently active.
    uint  ActiveMatrixMixCount;
    ///<table> <tr> <th>Windows</th> </tr> <tr> <td>Unsupported.</td> </tr> </table> <table> <tr> <th>Xbox 360</th>
    ///</tr> <tr> <td>Number of source voices decoding XMA data.</td> </tr> </table>
    uint  ActiveXmaSourceVoices;
    ///<table> <tr> <th>Windows</th> </tr> <tr> <td>Unsupported.</td> </tr> </table> <table> <tr> <th>Xbox 360</th>
    ///</tr> <tr> <td>A voice can use more than one XMA stream.</td> </tr> </table>
    uint  ActiveXmaStreams;
}

///Contains the new global debug configuration for XAudio2. Used with the SetDebugConfiguration function.
struct XAUDIO2_DEBUG_CONFIGURATION
{
align (1):
    ///Bitmask of enabled debug message types. Can be 0 or one or more of the following: <table> <tr> <th>Value</th>
    ///<th>Description</th> </tr> <tr> <td>XAUDIO2_LOG_ERRORS</td> <td>Log error messages. </td> </tr> <tr>
    ///<td>XAUDIO2_LOG_WARNINGS</td> <td>Log warning messages. <div class="alert"><b>Note</b> Enabling
    ///XAUDIO2_LOG_WARNINGS also enables XAUDIO2_LOG_ERRORS.</div> <div> </div> </td> </tr> <tr>
    ///<td>XAUDIO2_LOG_INFO</td> <td>Log informational messages. </td> </tr> <tr> <td>XAUDIO2_LOG_DETAIL</td> <td>Log
    ///detailed informational messages. <div class="alert"><b>Note</b> Enabling XAUDIO2_LOG_DETAIL also enables
    ///XAUDIO2_LOG_INFO.</div> <div> </div> </td> </tr> <tr> <td>XAUDIO2_LOG_API_CALLS</td> <td>Log public API function
    ///entries and exits. </td> </tr> <tr> <td>XAUDIO2_LOG_FUNC_CALLS</td> <td>Log internal function entries and exits.
    ///<div class="alert"><b>Note</b> Enabling XAUDIO2_LOG_FUNC_CALLS also enables XAUDIO2_LOG_API_CALLS.</div> <div>
    ///</div> </td> </tr> <tr> <td>XAUDIO2_LOG_TIMING</td> <td>Log delays detected and other timing data. </td> </tr>
    ///<tr> <td>XAUDIO2_LOG_LOCKS</td> <td>Log usage of critical sections and mutexes. </td> </tr> <tr>
    ///<td>XAUDIO2_LOG_MEMORY</td> <td>Log memory heap usage information. </td> </tr> <tr>
    ///<td>XAUDIO2_LOG_STREAMING</td> <td>Log audio streaming information. </td> </tr> </table>
    uint TraceMask;
    ///Message types that will cause an immediate break. Can be 0 or one of the following: <table> <tr> <th>Value</th>
    ///<th>Description</th> </tr> <tr> <td>XAUDIO2_LOG_ERRORS</td> <td>Break on error messages. </td> </tr> <tr>
    ///<td>XAUDIO2_LOG_WARNINGS</td> <td>Break on warning messages. <div class="alert"><b>Note</b> Enabling
    ///XAUDIO2_LOG_WARNINGS also enables XAUDIO2_LOG_ERRORS.</div> <div> </div> </td> </tr> </table>
    uint BreakMask;
    ///Indicates whether to log the thread ID with each message.
    BOOL LogThreadID;
    ///Indicates whether to log source files and line numbers.
    BOOL LogFileline;
    ///Indicates whether to log function names.
    BOOL LogFunctionName;
    ///Indicates whether to log message timestamps.
    BOOL LogTiming;
}

///Describes parameters for use with the volume meter APO.
struct XAUDIO2FX_VOLUMEMETER_LEVELS
{
align (1):
    ///Array that will be filled with the maximum absolute level for each channel during a processing pass. The array
    ///must be at least <i>ChannelCount</i> × sizeof(float) bytes. <i>pPeakLevels</i> may be NULL if <i>pRMSLevels</i>
    ///is not NULL.
    float* pPeakLevels;
    ///Array that will be filled with root mean square level for each channel during a processing pass. The array must
    ///be at least <i>ChannelCount</i> × sizeof(float) bytes. <i>pRMSLevels</i> may be NULL if <i>pPeakLevels</i> is
    ///not NULL.
    float* pRMSLevels;
    ///Number of channels being processed.
    uint   ChannelCount;
}

///Describes parameters for use in the reverb APO.
struct XAUDIO2FX_REVERB_PARAMETERS
{
align (1):
    ///Percentage of the output that will be reverb. Allowable values are from 0 to 100.
    float WetDryMix;
    ///The delay time of the first reflection relative to the direct path. Permitted range is from 0 to 300
    ///milliseconds. <div class="alert"><b>Note</b> All parameters related to sampling rate or time are relative to a
    ///48kHz sampling rate and must be scaled for use with other sampling rates. See remarks section below for
    ///additional information.</div> <div> </div>
    uint  ReflectionsDelay;
    ///Delay of reverb relative to the first reflection. Permitted range is from 0 to 85 milliseconds. <div
    ///class="alert"><b>Note</b> All parameters related to sampling rate or time are relative to a 48kHz sampling rate
    ///and must be scaled for use with other sampling rates. See remarks section below for additional information.</div>
    ///<div> </div>
    ubyte ReverbDelay;
    ///Delay for the left rear output and right rear output. Permitted range is from 0 to 5 milliseconds. <div
    ///class="alert"><b>Note</b> All parameters related to sampling rate or time are relative to a 48kHz sampling rate
    ///and must be scaled for use with other sampling rates. See remarks section below for additional information.</div>
    ///<div> </div>
    ubyte RearDelay;
    ///Delay for the left side output and right side output. Permitted range is from 0 to 5 milliseconds. <div
    ///class="alert"><b>Note</b> This value is supported beginning with Windows 10.</div> <div> </div> <div
    ///class="alert"><b>Note</b> All parameters related to sampling rate or time are relative to a 48kHz sampling rate
    ///and must be scaled for use with other sampling rates. See remarks section below for additional information.</div>
    ///<div> </div>
    ubyte SideDelay;
    ///Position of the left input within the simulated space relative to the listener. With <i>PositionLeft</i> set to
    ///the minimum value, the left input is placed close to the listener. In this position, early reflections are
    ///dominant, and the reverb decay is set back in the sound field and reduced in amplitude. With <i>PositionLeft</i>
    ///set to the maximum value, the left input is placed at a maximum distance from the listener within the simulated
    ///room. <i>PositionLeft</i> does not affect the reverb decay time (liveness of the room), only the apparent
    ///position of the source relative to the listener. Permitted range is from 0 to 30 (no units).
    ubyte PositionLeft;
    ///Same as <i>PositionLeft</i>, but affecting only the right input. Permitted range is from 0 to 30 (no units). <div
    ///class="alert"><b>Note</b> PositionRight is ignored in mono-in/mono-out mode.</div> <div> </div>
    ubyte PositionRight;
    ///Gives a greater or lesser impression of distance from the source to the listener. Permitted range is from 0 to 30
    ///(no units).
    ubyte PositionMatrixLeft;
    ///Gives a greater or lesser impression of distance from the source to the listener. Permitted range is from 0 to 30
    ///(no units). <div class="alert"><b>Note</b> <i>PositionMatrixRight</i> is ignored in mono-in/mono-out mode.</div>
    ///<div> </div>
    ubyte PositionMatrixRight;
    ///Controls the character of the individual wall reflections. Set to minimum value to simulate a hard flat surface
    ///and to maximum value to simulate a diffuse surface. Permitted range is from 0 to 15 (no units).
    ubyte EarlyDiffusion;
    ///Controls the character of the individual wall reverberations. Set to minimum value to simulate a hard flat
    ///surface and to maximum value to simulate a diffuse surface. Permitted range is from 0 to 15 (no units).
    ubyte LateDiffusion;
    ///Adjusts the decay time of low frequencies relative to the decay time at 1 kHz. The values correspond to dB of
    ///gain as follows: <table> <tr> <th>Value</th> <td>0</td> <td>1</td> <td>2</td> <td>3</td> <td>4</td> <td>5</td>
    ///<td>6</td> <td>7</td> <td>8</td> <td>9</td> <td>10</td> <td>11</td> <td>12</td> </tr> <tr> <th>Gain (dB)</th>
    ///<td>-8</td> <td>-7</td> <td>-6</td> <td>-5</td> <td>-4</td> <td>-3</td> <td>-2</td> <td>-1</td> <td>0</td>
    ///<td>+1</td> <td>+2</td> <td>+3</td> <td>+4</td> </tr> </table> <div class="alert"><b>Note</b> A <i>LowEQGain</i>
    ///value of 8 results in the decay time of low frequencies being equal to the decay time at 1 kHz.</div> <div>
    ///</div> Permitted range is from 0 to 12 (no units).
    ubyte LowEQGain;
    ///Sets the corner frequency of the low pass filter that is controlled by the <i>LowEQGain</i> parameter. The values
    ///correspond to frequency in Hz as follows: <table> <tr> <th>Value</th> <td>0</td> <td>1</td> <td>2</td> <td>3</td>
    ///<td>4</td> <td>5</td> <td>6</td> <td>7</td> <td>8</td> <td>9</td> </tr> <tr> <th>Frequency (Hz)</th> <td>50</td>
    ///<td>100</td> <td>150</td> <td>200</td> <td>250</td> <td>300</td> <td>350</td> <td>400</td> <td>450</td>
    ///<td>500</td> </tr> </table> Permitted range is from 0 to 9 (no units).
    ubyte LowEQCutoff;
    ///Adjusts the decay time of high frequencies relative to the decay time at 1 kHz. When set to zero, high
    ///frequencies decay at the same rate as 1 kHz. When set to maximum value, high frequencies decay at a much faster
    ///rate than 1 kHz. <table> <tr> <th>Value</th> <td>0</td> <td>1</td> <td>2</td> <td>3</td> <td>4</td> <td>5</td>
    ///<td>6</td> <td>7</td> <td>8</td> </tr> <tr> <th>Gain (dB)</th> <td>-8</td> <td>-7</td> <td>-6</td> <td>-5</td>
    ///<td>-4</td> <td>-3</td> <td>-2</td> <td>-1</td> <td>0</td> </tr> </table> Permitted range is from 0 to 8 (no
    ///units).
    ubyte HighEQGain;
    ///Sets the corner frequency of the high pass filter that is controlled by the <i>HighEQGain</i> parameter. The
    ///values correspond to frequency in kHz as follows: <table> <tr> <th>Value</th> <td>0</td> <td>1</td> <td>2</td>
    ///<td>3</td> <td>4</td> <td>5</td> <td>6</td> <td>7</td> <td>8</td> <td>9</td> <td>10</td> <td>11</td> <td>12</td>
    ///<td>13</td> <td>14</td> </tr> <tr> <th>Frequency (kHz)</th> <td>1</td> <td>1.5</td> <td>2</td> <td>2.5</td>
    ///<td>3</td> <td>3.5</td> <td>4</td> <td>4.5</td> <td>5</td> <td>5.5</td> <td>6</td> <td>6.5</td> <td>7</td>
    ///<td>7.5</td> <td>8</td> </tr> </table> Permitted range is from 0 to 14 (no units).
    ubyte HighEQCutoff;
    ///Sets the corner frequency of the low pass filter for the room effect. Permitted range is from 20 to 20,000 Hz.
    ///<div class="alert"><b>Note</b> All parameters related to sampling rate or time are relative to a 48kHz sampling
    ///rate and must be scaled for use with other sampling rates. See remarks section below for additional
    ///information.</div> <div> </div>
    float RoomFilterFreq;
    ///Sets the pass band intensity level of the low-pass filter for both the early reflections and the late field
    ///reverberation. Permitted range is from -100 to 0 dB.
    float RoomFilterMain;
    ///Sets the intensity of the low-pass filter for both the early reflections and the late field reverberation at the
    ///corner frequency (<i>RoomFilterFreq</i>). Permitted range is from -100 to 0 dB.
    float RoomFilterHF;
    ///Adjusts the intensity of the early reflections. Permitted range is from -100 to 20 dB.
    float ReflectionsGain;
    ///Adjusts the intensity of the reverberations. Permitted range is from -100 to 20 dB.
    float ReverbGain;
    ///Reverberation decay time at 1 kHz. This is the time that a full scale input signal decays by 60 dB. Permitted
    ///range is from 0.1 to infinity seconds.
    float DecayTime;
    ///Controls the modal density in the late field reverberation. For colorless spaces, <i>Density</i> should be set to
    ///the maximum value (100). As Density is decreased, the sound becomes hollow (comb filtered). This is an effect
    ///that can be useful if you are trying to model a silo. Permitted range as a percentage is from 0 to 100.
    float Density;
    ///The apparent size of the acoustic space. Permitted range is from 1 to 100 feet.
    float RoomSize;
    ///If set to TRUE, disables late field reflection calculations. Disabling late field reflection calculations results
    ///in a significant CPU time savings. <div class="alert"><b>Note</b> The DirectX SDK versions of XAUDIO2 don't
    ///support this member.</div> <div> </div>
    BOOL  DisableLateField;
}

///Describes I3DL2 (Interactive 3D Audio Rendering Guidelines Level 2.0) parameters for use in the
///ReverbConvertI3DL2ToNative function.
struct XAUDIO2FX_REVERB_I3DL2_PARAMETERS
{
align (1):
    ///Percentage of the output that will be reverb. Allowable values are from 0 to 100.
    float WetDryMix;
    ///Attenuation of the room effect. Allowable values in hundredths of a decibel are from -10000 to 0.
    int   Room;
    ///Attenuation of the room high-frequency effect. Allowable values in hundredths of a decibel are from -10000 to 0.
    int   RoomHF;
    ///Rolloff factor for the reflected signals. Allowable values are from 0.0 to 10.0. Rolloff factor is ignored for
    ///built-in reverb effects.
    float RoomRolloffFactor;
    ///Reverberation decay time at low frequencies. Allowable values in seconds are from 0.1 to 20.0.
    float DecayTime;
    ///Ratio of the decay time at high frequencies to the decay time at low frequencies. Allowable values are from 0.1
    ///to 2.0.
    float DecayHFRatio;
    ///Attenuation of early reflections relative to <b>Room</b>. Allowable values in hundredths of a decibel are from
    ///-10000 to 1000.
    int   Reflections;
    ///Delay time of the first reflection relative to the direct path. Allowable values in seconds are from 0.0 to 0.3.
    float ReflectionsDelay;
    ///Attenuation of late reverberation relative to <b>Room</b>. Allowable values in hundredths of a decibel are from
    ///-10000 to 2000.
    int   Reverb;
    ///Time limit between the early reflections and the late reverberation relative to the time of the first reflection.
    ///Allowable values in seconds are from 0.0 to 0.1.
    float ReverbDelay;
    ///Echo density in the late reverberation decay. Allowable values as a percentage are from 0 to 100.
    float Diffusion;
    ///Modal density in the late reverberation decay. Allowable values as a percentage are from 0 to 100.
    float Density;
    ///Reference high frequency. Allowable values in Hz are from 20.0 to 20000.0.
    float HFReference;
}

///Represents a position in 3D space, using a right-handed coordinate system.
struct HrtfPosition
{
    float x;
    float y;
    float z;
}

///Indicates the orientation of an HRTF directivity object.
struct HrtfOrientation
{
    ///The orientation. This is a row-major 3x3 rotation matrix.
    float[9] element;
}

///Base directivity pattern descriptor. Describes the type of directivity applied to a sound.
struct HrtfDirectivity
{
    ///Indicates the type of directivity.
    HrtfDirectivityType type;
    ///A normalized value between zero and one. Specifies the amount of linear interpolation between omnidirectional
    ///sound and the full directivity pattern, where 0 is fully omnidirectional and 1 is fully directional.
    float               scaling;
}

///Describes a cardioid directivity pattern.
struct HrtfDirectivityCardioid
{
    ///Descriptor for the cardioid pattern. The type parameter must be set to HrtfDirectivityType.Cardioid.
    HrtfDirectivity directivity;
    ///Controls the shape of the cardioid. The higher order the shape, the narrower it is. Must be greater than 0 and
    ///less than or equal to 32.
    float           order;
}

///Describes a cone directivity.
struct HrtfDirectivityCone
{
    ///Descriptor for the cone pattern. The type parameter must be set to HrtfDirectivityType.Cone.
    HrtfDirectivity directivity;
    ///Angle, in radians, that defines the inner cone. Must be between 0 and 2 * pi.
    float           innerAngle;
    ///Angle, in radians, that defines the outer cone. Must be between 0 and 2 * pi.
    float           outerAngle;
}

///Describes a distance-based decay behavior.
struct HrtfDistanceDecay
{
    ///The type of decay behavior, natural or custom.
    HrtfDistanceDecayType type;
    ///The maximum gain limit applied at any distance. Applies to both natural and custom decay. This value is specified
    ///in dB, with a range from -96 to 12 inclusive. The default value is 12 dB.
    float maxGain;
    ///The minimum gain limit applied at any distance. Applies to both natural and custom decay. This value is specified
    ///in dB, with a range from -96 to 12 inclusive. The default value is -96 dB.
    float minGain;
    ///The distance at which the gain is 0dB. Applies to natural decay only. This value is specified in meters, with a
    ///range from 0.05 to infinity (FLT_MAX). The default value is 1 meter.
    float unityGainDistance;
    ///The distance at which output is silent. Applies to natural decay only. This value is specified in meters, with a
    ///range from zero (non-inclusive) to infinity (FLT_MAX). The default value is infinity.
    float cutoffDistance;
}

///Specifies parameters used to initialize HRTF spatial audio.
struct HrtfApoInit
{
    ///The decay type. If you pass in nullptr, the default value is used. The default is natural decay.
    HrtfDistanceDecay* distanceDecay;
    ///The directivity type. If you pass in nullptr, the default value is used. The default directivity is
    ///omni-directional.
    HrtfDirectivity*   directivity;
}

// Functions

///Creates an instance of the requested XAPOFX effect.
///Params:
///    clsid = ID of the effect to create. Use the <b>__uuidof</b> on the effect class name to get the CLSID for an effect. For
///            example, <b>__uuidof</b>(FXReverb) would provide the CLSID for the FXReverb effect. For a list of effects
///            provided by XAPOFX, see XAPOFX Overview. For an example of retrieving the CLSID for an effect, see How to: Use
///            XAPOFX in XAudio2.
///    pEffect = Receives a pointer to the created XAPO instance. If <b>CreateFX</b> fails, <i>pEffect </i> is untouched.
///    pInitData = Effect-specific initialization parameters. This is <b>NULL</b> if <i>InitDataByteSize</i> is zero.
///    InitDataByteSize = Size of <i>pInitData</i> in bytes. This is zero if <i>pInitData</i> is <b>NULL</b>.
///Returns:
///    If this function succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
///    
@DllImport("XAudio2_9")
HRESULT CreateFX(const(GUID)* clsid, IUnknown* pEffect, const(void)* pInitDat, uint InitDataByteSize);

@DllImport("XAudio2_9")
HRESULT XAudio2CreateWithVersionInfo(IXAudio2* ppXAudio2, uint Flags, uint XAudio2Processor, uint ntddiVersion);

@DllImport("XAudio2_9")
HRESULT CreateAudioVolumeMeter(IUnknown* ppApo);

@DllImport("XAudio2_9")
HRESULT CreateAudioReverb(IUnknown* ppApo);

///Creates an instance of the IXAPO interface for head-related transfer function (HRTF) processing.
///Params:
///    init = Pointer to an HrtfApoInit struct. Specifies parameters for XAPO interface initialization.
///    xApo = The new instance of the IXAPO interface.
///Returns:
///    This function can return the following values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> An instance of the XAPO object was
///    created successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_NOTIMPL</b></dt> </dl> </td> <td
///    width="60%"> HRTF is not supported on the current platform. </td> </tr> </table>
///    
@DllImport("HrtfApo")
HRESULT CreateHrtfApo(const(HrtfApoInit)* init, IXAPO* xApo);


// Interfaces

@GUID("F5E01117-D6C4-485A-A3F5-695196F3DBFA")
struct FXEQ;

@GUID("C4137916-2BE1-46FD-8599-441536F49856")
struct FXMasteringLimiter;

@GUID("7D9ACA56-CB68-4807-B632-B137352E8596")
struct FXReverb;

@GUID("5039D740-F736-449A-84D3-A56202557B87")
struct FXEcho;

@GUID("4FC3B166-972A-40CF-BC37-7DB03DB2FBA3")
struct AudioVolumeMeter;

@GUID("C2633B16-471B-4498-B8C5-4F0959E2EC09")
struct AudioReverb;

///The interface for an Audio Processing Object which be used in an XAudio2 effect chain.
@GUID("A410B984-9839-4819-A0BE-2856AE6B3ADB")
interface IXAPO : IUnknown
{
    ///Returns the registration properties of an XAPO.
    ///Params:
    ///    ppRegistrationProperties = Receives a pointer to a XAPO_REGISTRATION_PROPERTIES structure containing the registration properties the
    ///                               XAPO was created with; use XAPOFree to free the structure.
    ///Returns:
    ///    Returns S_OK if successful; returns an error code otherwise.
    ///    
    HRESULT GetRegistrationProperties(XAPO_REGISTRATION_PROPERTIES** ppRegistrationProperties);
    ///Queries if a specific input format is supported for a given output format.
    ///Params:
    ///    pOutputFormat = Output format.
    ///    pRequestedInputFormat = Input format to check for being supported.
    ///    ppSupportedInputFormat = If not NULL, and the input format is not supported for the given output format, <i>ppSupportedInputFormat</i>
    ///                             returns a pointer to the closest input format that is supported. Use XAPOFree to free the returned structure.
    ///Returns:
    ///    Returns S_OK if the format pair is supported. Returns XAPO_E_FORMAT_UNSUPPORTED if the format pair is not
    ///    supported.
    ///    
    HRESULT IsInputFormatSupported(const(WAVEFORMATEX)* pOutputFormat, const(WAVEFORMATEX)* pRequestedInputFormat, 
                                   WAVEFORMATEX** ppSupportedInputFormat);
    ///Queries if a specific output format is supported for a given input format.
    ///Params:
    ///    pInputFormat = Input format.
    ///    pRequestedOutputFormat = Output format to check for being supported.
    ///    ppSupportedOutputFormat = If not NULL and the output format is not supported for the given input format, <i>ppSupportedOutputFormat</i>
    ///                              returns a pointer to the closest output format that is supported. Use XAPOFree to free the returned
    ///                              structure.
    ///Returns:
    ///    Returns S_OK if the format pair is supported. Returns XAPO_E_FORMAT_UNSUPPORTED if the format pair is not
    ///    supported.
    ///    
    HRESULT IsOutputFormatSupported(const(WAVEFORMATEX)* pInputFormat, const(WAVEFORMATEX)* pRequestedOutputFormat, 
                                    WAVEFORMATEX** ppSupportedOutputFormat);
    ///Performs any effect-specific initialization.
    ///Params:
    ///    pData = Effect-specific initialization parameters, may be NULL if <i>DataByteSize</i> is 0.
    ///    DataByteSize = Size of <i>pData</i> in bytes, may be 0 if <i>pData</i> is NULL.
    ///Returns:
    ///    Returns S_OK if successful, an error code otherwise.
    ///    
    HRESULT Initialize(const(void)* pData, uint DataByteSize);
    ///Resets variables dependent on frame history.
    void    Reset();
    ///Called by XAudio2 to lock the input and output configurations of an XAPO allowing it to do any final
    ///initialization before Process is called on the realtime thread.
    ///Params:
    ///    InputLockedParameterCount = Number of elements in <i>ppInputLockedParameters</i>. Must be within the
    ///                                XAPO_REGISTRATION_PROPERTIES.MinInputBufferCount and <b>XAPO_REGISTRATION_PROPERTIES</b>.MaxInputBufferCount
    ///                                values passed to CXAPOBase::CXAPOBase.
    ///    pInputLockedParameters = Array of input XAPO_LOCKFORPROCESS_BUFFER_PARAMETERS structures. <i>pInputLockedParameters</i> may be NULL if
    ///                             <i>InputLockedParameterCount</i> is 0, otherwise it must have <i>InputLockedParameterCount</i> elements.
    ///    OutputLockedParameterCount = Number of elements in ppOutputLockedParameters. Must be within the
    ///                                 XAPO_REGISTRATION_PROPERTIES.MinOutputBufferCount and
    ///                                 <b>XAPO_REGISTRATION_PROPERTIES</b>.MaxOutputBufferCount values passed to CXAPOBase::CXAPOBase. If the
    ///                                 XAPO_FLAG_BUFFERCOUNT_MUST_MATCH flag was specified in <b>XAPO_REGISTRATION_PROPERTIES</b>.Flags then
    ///                                 <i>OutputLockedParameterCount</i> must equal <i>InputLockedParameterCount</i>.
    ///    pOutputLockedParameters = Array of output XAPO_LOCKFORPROCESS_BUFFER_PARAMETERS structures. <i>pOutputLockedParameters</i> may be NULL
    ///                              if <i>OutputLockedParameterCount</i> is 0, otherwise it must have <i>OutputLockedParameterCount</i> elements.
    ///Returns:
    ///    Returns S_OK if successful, an error code otherwise.
    ///    
    HRESULT LockForProcess(uint InputLockedParameterCount, 
                           const(XAPO_LOCKFORPROCESS_PARAMETERS)* pInputLockedParameters, 
                           uint OutputLockedParameterCount, 
                           const(XAPO_LOCKFORPROCESS_PARAMETERS)* pOutputLockedParameters);
    ///Deallocates variables that were allocated with the LockForProcess method.
    void    UnlockForProcess();
    ///Runs the XAPO's digital signal processing (DSP) code on the given input and output buffers.
    ///Params:
    ///    InputProcessParameterCount = Number of elements in pInputProcessParameters. <div class="alert"><b>Note</b> XAudio2 currently supports only
    ///                                 one input stream and one output stream.</div> <div> </div>
    ///    pInputProcessParameters = Input array of XAPO_PROCESS_BUFFER_PARAMETERS structures.
    ///    OutputProcessParameterCount = Number of elements in <i>pOutputProcessParameters</i>. <div class="alert"><b>Note</b> XAudio2 currently
    ///                                  supports only one input stream and one output stream.</div> <div> </div>
    ///    pOutputProcessParameters = Output array of XAPO_PROCESS_BUFFER_PARAMETERS structures. On input, the value of
    ///                               <b>XAPO_PROCESS_BUFFER_PARAMETERS</b>. <b>ValidFrameCount</b> indicates the number of frames that the XAPO
    ///                               should write to the output buffer. On output, the value of <b>XAPO_PROCESS_BUFFER_PARAMETERS</b>.
    ///                               <b>ValidFrameCount</b> indicates the actual number of frames written.
    ///    IsEnabled = TRUE to process normally; FALSE to process thru. See Remarks for additional information.
    void    Process(uint InputProcessParameterCount, 
                    const(XAPO_PROCESS_BUFFER_PARAMETERS)* pInputProcessParameters, uint OutputProcessParameterCount, 
                    XAPO_PROCESS_BUFFER_PARAMETERS* pOutputProcessParameters, BOOL IsEnabled);
    ///Returns the number of input frames required to generate the given number of output frames.
    ///Params:
    ///    OutputFrameCount = The number of output frames desired.
    ///Returns:
    ///    Returns the number of input frames required.
    ///    
    uint    CalcInputFrames(uint OutputFrameCount);
    ///Returns the number of output frames that will be generated from a given number of input frames.
    ///Params:
    ///    InputFrameCount = The number of input frames.
    ///Returns:
    ///    Returns the number of output frames that will be produced.
    ///    
    uint    CalcOutputFrames(uint InputFrameCount);
}

///An optional interface that allows an XAPO to use effect-specific parameters.
@GUID("26D95C66-80F2-499A-AD54-5AE7F01C6D98")
interface IXAPOParameters : IUnknown
{
    ///Sets effect-specific parameters.
    ///Params:
    ///    pParameters = Effect-specific parameter block.
    ///    ParameterByteSize = Size of pParameters, in bytes.
    void SetParameters(const(void)* pParameters, uint ParameterByteSize);
    ///Gets the current values for any effect-specific parameters.
    ///Params:
    ///    pParameters = Receives an effect-specific parameter block.
    ///    ParameterByteSize = Size of pParameters, in bytes.
    void GetParameters(void* pParameters, uint ParameterByteSize);
}

///IXAudio2 is the interface for the XAudio2 object that manages all audio engine states, the audio processing thread,
///the voice graph, and so forth. This is the only XAudio2 interface that is derived from the COM <b>IUnknown</b>
///interface. It controls the lifetime of the XAudio2 object using two methods derived from <b>IUnknown</b>:
///IXAudio2::AddRef and IXAudio2::Release. No other XAudio2 objects are reference-counted; their lifetimes are
///explicitly controlled using <i>create</i> and <i>destroy</i> calls, and are bounded by the lifetime of the XAudio2
///object that owns them.
@GUID("2B02E3CF-2E0B-4EC3-BE45-1B2A3FE7210D")
interface IXAudio2 : IUnknown
{
    ///Adds an IXAudio2EngineCallback pointer to the XAudio2 engine callback list.
    ///Params:
    ///    pCallback = IXAudio2EngineCallback pointer to add to the XAudio2 engine callback list.
    ///Returns:
    ///    Returns S_OK if successful, an error code otherwise. See XAudio2 Error Codes for descriptions of XAudio2
    ///    specific error codes.
    ///    
    HRESULT RegisterForCallbacks(IXAudio2EngineCallback pCallback);
    ///Removes an IXAudio2EngineCallback pointer from the XAudio2 engine callback list.
    ///Params:
    ///    pCallback = IXAudio2EngineCallback pointer to remove from the XAudio2 engine callback list. If the given pointer is
    ///                present more than once in the list, only the first instance in the list will be removed.
    void    UnregisterForCallbacks(IXAudio2EngineCallback pCallback);
    ///Creates and configures a source voice.
    ///Params:
    ///    ppSourceVoice = If successful, returns a pointer to the new IXAudio2SourceVoice object.
    ///    pSourceFormat = Pointer to a one of the structures in the table below. This structure contains the expected format for all
    ///                    audio buffers submitted to the source voice. XAudio2 supports PCM and ADPCM voice types. <table> <tr>
    ///                    <th>Format tag</th> <th>Wave format structure</th> <th>Size (in bytes)</th> </tr> <tr> <td>WAVE_FORMAT_PCM
    ///                    (0x0001) </td> <td> PCMWAVEFORMAT </td> <td>16</td> </tr> <tr> <td>-or-</td> <td> WAVEFORMATEX </td>
    ///                    <td>18</td> </tr> <tr> <td>WAVE_FORMAT_IEEE_FLOAT (0x0003) [32-bit]</td> <td> PCMWAVEFORMAT </td> <td>18</td>
    ///                    </tr> <tr> <td>WAVE_FORMAT_ADPCM (0x0002) [MS-ADPCM]</td> <td> ADPCMWAVEFORMAT </td> <td>50</td> </tr> <tr>
    ///                    <td>WAVE_FORMAT_EXTENSIBLE (0xFFFE)</td> <td> WAVEFORMATEXTENSIBLE </td> <td>40</td> </tr> </table> XAudio2
    ///                    supports the following PCM formats. <ul> <li>8-bit (unsigned) integer PCM </li> <li>16-bit integer PCM
    ///                    (optimal format for XAudio2) </li> <li>20-bit integer PCM (either in 24 or 32 bit containers) </li>
    ///                    <li>24-bit integer PCM (either in 24 or 32 bit containers) </li> <li>32-bit integer PCM </li> <li>32-bit
    ///                    float PCM (preferred format after 16-bit integer) </li> </ul> The number of channels in a source voice must
    ///                    be less than or equal to XAUDIO2_MAX_AUDIO_CHANNELS. The sample rate of a source voice must be between
    ///                    XAUDIO2_MIN_SAMPLE_RATE and XAUDIO2_MAX_SAMPLE_RATE. <div class="alert"><b>Note</b> PCM data formats such as
    ///                    PCMWAVEFORMAT and <b>ADPCMWAVEFORMAT</b> that require more information than provided by <b>WAVEFORMATEX</b>
    ///                    have a <b>WAVEFORMATEX</b> structure as the first member in their format structures. When you create a source
    ///                    voice with one of those formats, cast the format's structure as a <b>WAVEFORMATEX</b> structure and use it as
    ///                    the value for <i>pSourceFormat</i>.</div> <div> </div>
    ///    X2DEFAULT = TBD
    ///    Flags = Flags that specify the behavior of the source voice. A flag can be 0 or a combination of one or more of the
    ///            following: <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td>XAUDIO2_VOICE_NOPITCH</td> <td>No
    ///            pitch control is available on the voice. </td> </tr> <tr> <td>XAUDIO2_VOICE_NOSRC</td> <td>No sample rate
    ///            conversion is available on the voice. The voice's outputs must have the same sample rate.<div
    ///            class="alert"><b>Note</b> The XAUDIO2_VOICE_NOSRC flag causes the voice to behave as though the
    ///            XAUDIO2_VOICE_NOPITCH flag also is specified.</div> <div> </div> </td> </tr> <tr>
    ///            <td>XAUDIO2_VOICE_USEFILTER</td> <td>The filter effect should be available on this voice. </td> </tr>
    ///            </table> <div class="alert"><b>Note</b> The XAUDIO2_VOICE_MUSIC flag is not supported on Windows.</div> <div>
    ///            </div>
    ///    MaxFrequencyRatio = Highest allowable frequency ratio that can be set on this voice. The value for this argument must be between
    ///                        XAUDIO2_MIN_FREQ_RATIO and XAUDIO2_MAX_FREQ_RATIO. Subsequent calls to IXAudio2SourceVoice::SetFrequencyRatio
    ///                        are clamped between XAUDIO2_MIN_FREQ_RATIO and <b>MaxFrequencyRatio</b>. The maximum value for this argument
    ///                        is defined as XAUDIO2_MAX_FREQ_RATIO, which allows pitch to be raised by up to 10 octaves. If
    ///                        <i>MaxFrequencyRatio</i> is less than 1.0, the voice will use that ratio immediately after being created
    ///                        (rather than the default of 1.0). <table> <tr> <th>Xbox 360</th> </tr> <tr> <td>For XMA voices, there is one
    ///                        more restriction on the <i>MaxFrequencyRatio</i> argument and the voice's sample rate. The product of these
    ///                        two numbers cannot exceed XAUDIO2_MAX_RATIO_TIMES_RATE_XMA_MONO for one-channel voices or
    ///                        XAUDIO2_MAX_RATIO_TIMES_RATE_XMA_MULTICHANNEL for voices with any other number of channels. If the value
    ///                        specified for <i>MaxFrequencyRatio</i> is too high for the specified format, the call to
    ///                        <b>CreateSourceVoice</b> fails and produces a debug message. </td> </tr> </table> <div
    ///                        class="alert"><b>Note</b> You can use the lowest possible <i>MaxFrequencyRatio</i> value to reduce XAudio2's
    ///                        memory usage.</div> <div> </div>
    ///    pCallback = Pointer to a client-provided callback interface, IXAudio2VoiceCallback.
    ///    pEffectChain = Pointer to a list of XAUDIO2_EFFECT_CHAIN structures that describe an effect chain to use in the source
    ///                   voice.
    ///    pSendList = Pointer to a list of XAUDIO2_VOICE_SENDS structures that describe the set of destination voices for the
    ///                source voice. If pSendList is NULL, the send list defaults to a single output to the first mastering voice
    ///                created.
    ///Returns:
    ///    Returns S_OK if successful; otherwise, an error code. See XAudio2 Error Codes for descriptions of
    ///    XAudio2-specific error codes.
    ///    
    HRESULT CreateSourceVoice(IXAudio2SourceVoice* ppSourceVoice, const(WAVEFORMATEX)* pSourceFormat, uint Flags, 
                              float MaxFrequencyRatio, IXAudio2VoiceCallback pCallback, 
                              const(XAUDIO2_VOICE_SENDS)* pSendList, const(XAUDIO2_EFFECT_CHAIN)* pEffectChain);
    ///Creates and configures a submix voice.
    ///Params:
    ///    ppSubmixVoice = On success, returns a pointer to the new IXAudio2SubmixVoice object.
    ///    InputChannels = Number of channels in the input audio data of the submix voice. <i>InputChannels</i> must be less than or
    ///                    equal to XAUDIO2_MAX_AUDIO_CHANNELS.
    ///    InputSampleRate = Sample rate of the input audio data of submix voice. This rate must be a multiple of
    ///                      XAUDIO2_QUANTUM_DENOMINATOR. <i>InputSampleRate</i> must be between XAUDIO2_MIN_SAMPLE_RATE and
    ///                      XAUDIO2_MAX_SAMPLE_RATE.
    ///    X2DEFAULT = TBD
    ///    Flags = Flags that specify the behavior of the submix voice. It can be 0 or the following: <table> <tr>
    ///            <th>Value</th> <th>Description</th> </tr> <tr> <td>XAUDIO2_VOICE_USEFILTER</td> <td>The filter effect should
    ///            be available on this voice.</td> </tr> </table>
    ///    ProcessingStage = An arbitrary number that specifies when this voice is processed with respect to other submix voices, if the
    ///                      XAudio2 engine is running other submix voices. The voice is processed after all other voices that include a
    ///                      smaller <i>ProcessingStage</i> value and before all other voices that include a larger <i>ProcessingStage</i>
    ///                      value. Voices that include the same <i>ProcessingStage</i> value are processed in any order. A submix voice
    ///                      cannot send to another submix voice with a lower or equal <i>ProcessingStage</i> value. This prevents audio
    ///                      being lost due to a submix cycle.
    ///    pEffectChain = Pointer to a list of XAUDIO2_EFFECT_CHAIN structures that describe an effect chain to use in the submix
    ///                   voice.
    ///    pSendList = Pointer to a list of XAUDIO2_VOICE_SENDS structures that describe the set of destination voices for the
    ///                submix voice. If <i>pSendList</i> is NULL, the send list will default to a single output to the first
    ///                mastering voice created.
    ///Returns:
    ///    Returns S_OK if successful; otherwise, an error code. See XAudio2 Error Codes for descriptions of XAudio2
    ///    specific error codes.
    ///    
    HRESULT CreateSubmixVoice(IXAudio2SubmixVoice* ppSubmixVoice, uint InputChannels, uint InputSampleRate, 
                              uint Flags, uint ProcessingStage, const(XAUDIO2_VOICE_SENDS)* pSendList, 
                              const(XAUDIO2_EFFECT_CHAIN)* pEffectChain);
    ///Creates and configures a mastering voice.
    ///Params:
    ///    ppMasteringVoice = If successful, returns a pointer to the new IXAudio2MasteringVoice object.
    ///    X2DEFAULT = TBD
    ///    Flags = Flags that specify the behavior of the mastering voice. Must be 0.
    ///    InputChannels = Number of channels the mastering voice expects in its input audio. <i>InputChannels</i> must be less than or
    ///                    equal to XAUDIO2_MAX_AUDIO_CHANNELS. You can set <i>InputChannels</i> to XAUDIO2_DEFAULT_CHANNELS, which
    ///                    causes XAudio2 to try to detect the system speaker configuration setup.
    ///    InputSampleRate = Sample rate of the input audio data of the mastering voice. This rate must be a multiple of
    ///                      XAUDIO2_QUANTUM_DENOMINATOR. <i>InputSampleRate</i> must be between XAUDIO2_MIN_SAMPLE_RATE and
    ///                      XAUDIO2_MAX_SAMPLE_RATE. You can set <i>InputSampleRate</i> to XAUDIO2_DEFAULT_SAMPLERATE, with the default
    ///                      being determined by the current platform. Windows XP defaults to 44100. Windows Vista and Windows 7 default
    ///                      to the setting specified in the Sound Control Panel. The default for this setting is 44100 (or 48000 if
    ///                      required by the driver). Flags
    ///    StreamCategory = The audio stream category to use for this mastering voice.
    ///    pEffectChain = Pointer to an XAUDIO2_EFFECT_CHAIN structure that describes an effect chain to use in the mastering voice, or
    ///                   NULL to use no effects.
    ///    szDeviceId = Identifier of the device to receive the output audio. Specifying the default value of NULL causes XAudio2 to
    ///                 select the global default audio device.
    ///Returns:
    ///    Returns S_OK if successful; otherwise, an error code. Returns ERROR_NOT_FOUND if no default audio device
    ///    exists and NULL is passed in as the szDeviceId parameter. See XAudio2 Error Codes for descriptions of XAudio2
    ///    specific error codes.
    ///    
    HRESULT CreateMasteringVoice(IXAudio2MasteringVoice* ppMasteringVoice, uint InputChannels, 
                                 uint InputSampleRate, uint Flags, const(PWSTR) szDeviceId, 
                                 const(XAUDIO2_EFFECT_CHAIN)* pEffectChain, AUDIO_STREAM_CATEGORY StreamCategory);
    ///Starts the audio processing thread.
    ///Returns:
    ///    Returns S_OK if successful, an error code otherwise. See XAudio2 Error Codes for descriptions of XAudio2
    ///    specific error codes.
    ///    
    HRESULT StartEngine();
    ///Stops the audio processing thread.
    void    StopEngine();
    ///Atomically applies a set of operations that are tagged with a given identifier.
    ///Params:
    ///    OperationSet = Identifier of the set of operations to be applied. To commit all pending operations, pass
    ///                   <b>XAUDIO2_COMMIT_ALL</b>.
    ///Returns:
    ///    Returns S_OK if successful; returns an error code otherwise. See XAudio2 Error Codes for descriptions of
    ///    XAudio2 specific error codes.
    ///    
    HRESULT CommitChanges(uint OperationSet);
    ///Returns current resource usage details, such as available memory or CPU usage.
    ///Params:
    ///    pPerfData = On success, pointer to an XAUDIO2_PERFORMANCE_DATA structure that is returned.
    void    GetPerformanceData(XAUDIO2_PERFORMANCE_DATA* pPerfData);
    ///Changes global debug logging options for XAudio2.
    ///Params:
    ///    pDebugConfiguration = Pointer to a XAUDIO2_DEBUG_CONFIGURATION structure that contains the new debug configuration.
    ///    X2DEFAULT = This parameter is reserved and must be NULL.
    void    SetDebugConfiguration(const(XAUDIO2_DEBUG_CONFIGURATION)* pDebugConfiguration, void* pReserved);
}

@GUID("84AC29BB-D619-44D2-B197-E4ACF7DF3ED6")
interface IXAudio2Extension : IUnknown
{
    void GetProcessingQuantum(uint* quantumNumerator, uint* quantumDenominator);
    void GetProcessor(uint* processor);
}

///<b>IXAudio2Voice</b> represents the base interface from which IXAudio2SourceVoice, IXAudio2SubmixVoice and
///IXAudio2MasteringVoice are derived. The methods listed below are common to all voice subclasses. <ul>
///<li>Methods</li> </ul><h3><a id="methods"></a>Methods</h3>The <b>IXAudio2Voice Interface</b> interface has these
///methods. <table class="members" id="memberListMethods"> <tr> <th align="left" width="37%">Method</th> <th
///align="left" width="63%">Description</th> </tr> <tr data="declared;"> <td align="left" width="37%"> DestroyVoice
///</td> <td align="left" width="63%"> Destroys the voice. If necessary, stops the voice and removes it from the XAudio2
///graph. </td> </tr> <tr data="declared;"> <td align="left" width="37%"> DisableEffect </td> <td align="left"
///width="63%"> Disables the effect at a given position in the effect chain of the voice. </td> </tr> <tr
///data="declared;"> <td align="left" width="37%"> EnableEffect </td> <td align="left" width="63%"> Enables the effect
///at a given position in the effect chain of the voice. </td> </tr> <tr data="declared;"> <td align="left" width="37%">
///GetChannelVolumes </td> <td align="left" width="63%"> Returns the volume levels for the voice, per channel. </td>
///</tr> <tr data="declared;"> <td align="left" width="37%"> GetEffectParameters </td> <td align="left" width="63%">
///Returns the current effect-specific parameters of a given effect in the voice's effect chain. </td> </tr> <tr
///data="declared;"> <td align="left" width="37%"> GetEffectState </td> <td align="left" width="63%"> Returns the
///running state of the effect at a specified position in the effect chain of the voice. </td> </tr> <tr
///data="declared;"> <td align="left" width="37%"> GetFilterParameters </td> <td align="left" width="63%"> Gets the
///voice's filter parameters. </td> </tr> <tr data="declared;"> <td align="left" width="37%"> GetOutputFilterParameters
///</td> <td align="left" width="63%"> Returns the filter parameters from one of this voice's sends. </td> </tr> <tr
///data="declared;"> <td align="left" width="37%"> GetOutputMatrix </td> <td align="left" width="63%"> Gets the volume
///level of each channel of the final output for the voice. These channels are mapped to the input channels of a
///specified destination voice. </td> </tr> <tr data="declared;"> <td align="left" width="37%"> GetVoiceDetails </td>
///<td align="left" width="63%"> Returns information about the creation flags, input channels, and sample rate of a
///voice. </td> </tr> <tr data="declared;"> <td align="left" width="37%"> GetVolume </td> <td align="left" width="63%">
///Gets the current overall volume level of the voice. </td> </tr> <tr data="declared;"> <td align="left" width="37%">
///SetChannelVolumes </td> <td align="left" width="63%"> Sets the volume levels for the voice, per channel. </td> </tr>
///<tr data="declared;"> <td align="left" width="37%"> SetEffectChain </td> <td align="left" width="63%"> Replaces the
///effect chain of the voice. </td> </tr> <tr data="declared;"> <td align="left" width="37%"> SetEffectParameters </td>
///<td align="left" width="63%"> Sets parameters for a given effect in the voice's effect chain. </td> </tr> <tr
///data="declared;"> <td align="left" width="37%"> SetFilterParameters </td> <td align="left" width="63%"> Sets the
///voice's filter parameters. </td> </tr> <tr data="declared;"> <td align="left" width="37%"> SetOutputFilterParameters
///</td> <td align="left" width="63%"> Sets the filter parameters on one of this voice's sends. </td> </tr> <tr
///data="declared;"> <td align="left" width="37%"> SetOutputMatrix </td> <td align="left" width="63%"> Sets the volume
///level of each channel of the final output for the voice. These channels are mapped to the input channels of a
///specified destination voice. </td> </tr> <tr data="declared;"> <td align="left" width="37%"> SetOutputVoices </td>
///<td align="left" width="63%"> Designates a new set of submix or mastering voices to receive the output of the voice.
///</td> </tr> <tr data="declared;"> <td align="left" width="37%"> SetVolume </td> <td align="left" width="63%"> Sets
///the overall volume level for the voice. </td> </tr> </table>
interface IXAudio2Voice
{
    ///Returns information about the creation flags, input channels, and sample rate of a voice.
    ///Params:
    ///    pVoiceDetails = XAUDIO2_VOICE_DETAILS structure containing information about the voice.
    ///Returns:
    ///    This method does not return a value.
    ///    
    void    GetVoiceDetails(XAUDIO2_VOICE_DETAILS* pVoiceDetails);
    ///Designates a new set of submix or mastering voices to receive the output of the voice.
    ///Params:
    ///    pSendList = Array of XAUDIO2_VOICE_SENDS structure pointers to destination voices. If <i>pSendList</i> is NULL, the voice
    ///                will send its output to the current mastering voice. To set the voice to not send its output anywhere set the
    ///                <b>OutputCount</b> member of <b>XAUDIO2_VOICE_SENDS</b> to 0. All of the voices in a send list must have the
    ///                same input sample rate, see XAudio2 Sample Rate Conversions for additional information.
    ///Returns:
    ///    Returns S_OK if successful, an error code otherwise. See XAudio2 Error Codes for descriptions of XAudio2
    ///    specific error codes.
    ///    
    HRESULT SetOutputVoices(const(XAUDIO2_VOICE_SENDS)* pSendList);
    ///Replaces the effect chain of the voice.
    ///Params:
    ///    pEffectChain = Pointer to an XAUDIO2_EFFECT_CHAIN structure that describes the new effect chain to use. If NULL is passed,
    ///                   the current effect chain is removed. <div class="alert"><b>Note</b> If <i>pEffectChain</i> is non-NULL, the
    ///                   XAUDIO2_EFFECT_CHAIN structure that it points to must specify at least one effect.</div> <div> </div>
    ///Returns:
    ///    Returns S_OK if successful; otherwise, an error code. See XAudio2 Error Codes for descriptions of XAudio2
    ///    specific error codes.
    ///    
    HRESULT SetEffectChain(const(XAUDIO2_EFFECT_CHAIN)* pEffectChain);
    ///Enables the effect at a given position in the effect chain of the voice.
    ///Params:
    ///    EffectIndex = Zero-based index of an effect in the effect chain of the voice.
    ///    X2DEFAULT = TBD
    ///    OperationSet = Identifies this call as part of a deferred batch. See the XAudio2 Operation Sets overview for more
    ///                   information.
    ///Returns:
    ///    Returns S_OK if successful; otherwise, an error code. See XAudio2 Error Codes for descriptions of error
    ///    codes.
    ///    
    HRESULT EnableEffect(uint EffectIndex, uint OperationSet);
    ///Disables the effect at a given position in the effect chain of the voice.
    ///Params:
    ///    EffectIndex = Zero-based index of an effect in the effect chain of the voice.
    ///    X2DEFAULT = TBD
    ///    OperationSet = Identifies this call as part of a deferred batch. See the XAudio2 Operation Sets overview for more
    ///                   information.
    ///Returns:
    ///    Returns S_OK if successful; otherwise, an error code. See XAudio2 Error Codes for descriptions of valid error
    ///    codes.
    ///    
    HRESULT DisableEffect(uint EffectIndex, uint OperationSet);
    ///Returns the running state of the effect at a specified position in the effect chain of the voice.
    ///Params:
    ///    EffectIndex = Zero-based index of an effect in the effect chain of the voice.
    ///    pEnabled = Returns TRUE If the effect is enabled. If the effect is disabled, returns FALSE.
    ///Returns:
    ///    This method does not return a value.
    ///    
    void    GetEffectState(uint EffectIndex, BOOL* pEnabled);
    ///Sets parameters for a given effect in the voice's effect chain.
    ///Params:
    ///    EffectIndex = Zero-based index of an effect within the voice's effect chain.
    ///    pParameters = Returns the current values of the effect-specific parameters.
    ///    ParametersByteSize = Size of the <b>pParameters</b> array in bytes.
    ///    X2DEFAULT = TBD
    ///    OperationSet = Identifies this call as part of a deferred batch. See the XAudio2 Operation Sets overview for more
    ///                   information.
    ///Returns:
    ///    Returns S_OK if successful; otherwise, an error code. See XAudio2 Error Codes for descriptions of error
    ///    codes. Fails with E_NOTIMPL if the effect does not support a generic parameter control interface.
    ///    
    HRESULT SetEffectParameters(uint EffectIndex, const(void)* pParameters, uint ParametersByteSize, 
                                uint OperationSet);
    ///Returns the current effect-specific parameters of a given effect in the voice's effect chain.
    ///Params:
    ///    EffectIndex = Zero-based index of an effect within the voice's effect chain.
    ///    pParameters = Returns the current values of the effect-specific parameters.
    ///    ParametersByteSize = Size, in bytes, of the pParameters array.
    ///Returns:
    ///    Returns S_OK if successful, an error code otherwise. See XAudio2 Error Codes for descriptions of error codes.
    ///    Fails with E_NOTIMPL if the effect does not support a generic parameter control interface.
    ///    
    HRESULT GetEffectParameters(uint EffectIndex, void* pParameters, uint ParametersByteSize);
    ///Sets the voice's filter parameters.
    ///Params:
    ///    pParameters = Pointer to an XAUDIO2_FILTER_PARAMETERS structure containing the filter information.
    ///    X2DEFAULT = TBD
    ///    OperationSet = Identifies this call as part of a deferred batch. See the XAudio2 Operation Sets overview for more
    ///                   information.
    ///Returns:
    ///    Returns S_OK if successful, an error code otherwise. See XAudio2 Error Codes for descriptions of error codes.
    ///    
    HRESULT SetFilterParameters(const(XAUDIO2_FILTER_PARAMETERS)* pParameters, uint OperationSet);
    ///Gets the voice's filter parameters.
    ///Params:
    ///    pParameters = Pointer to an XAUDIO2_FILTER_PARAMETERS structure containing the filter information.
    ///Returns:
    ///    This method does not return a value.
    ///    
    void    GetFilterParameters(XAUDIO2_FILTER_PARAMETERS* pParameters);
    ///Sets the filter parameters on one of this voice's sends.
    ///Params:
    ///    pDestinationVoice = IXAudio2Voice pointer to the destination voice of the send whose filter parameters will be set.
    ///    pParameters = Pointer to an XAUDIO2_FILTER_PARAMETERS structure containing the filter information.
    ///    X2DEFAULT = TBD
    ///    OperationSet = Identifies this call as part of a deferred batch. See the XAudio2 Operation Sets overview for more
    ///                   information.
    ///Returns:
    ///    Returns S_OK if successful, an error code otherwise. See XAudio2 Error Codes for descriptions of error codes.
    ///    
    HRESULT SetOutputFilterParameters(IXAudio2Voice pDestinationVoice, 
                                      const(XAUDIO2_FILTER_PARAMETERS)* pParameters, uint OperationSet);
    ///Returns the filter parameters from one of this voice's sends.
    ///Params:
    ///    pDestinationVoice = IXAudio2Voice pointer to the destination voice of the send whose filter parameters will be read.
    ///    pParameters = Pointer to an XAUDIO2_FILTER_PARAMETERS structure containing the filter information.
    ///Returns:
    ///    This method does not return a value.
    ///    
    void    GetOutputFilterParameters(IXAudio2Voice pDestinationVoice, XAUDIO2_FILTER_PARAMETERS* pParameters);
    ///Sets the overall volume level for the voice.
    ///Params:
    ///    Volume = Overall volume level to use. See Remarks for more information on volume levels.
    ///    X2DEFAULT = TBD
    ///    OperationSet = Identifies this call as part of a deferred batch. See the XAudio2 Operation Sets overview for more
    ///                   information.
    ///Returns:
    ///    Returns S_OK if successful, an error code otherwise. See XAudio2 Error Codes for descriptions of error codes.
    ///    
    HRESULT SetVolume(float Volume, uint OperationSet);
    ///Gets the current overall volume level of the voice.
    ///Params:
    ///    pVolume = Returns the current overall volume level of the voice. See Remarks for more information on volume levels.
    ///Returns:
    ///    This method does not return a value.
    ///    
    void    GetVolume(float* pVolume);
    ///Sets the volume levels for the voice, per channel.
    ///Params:
    ///    Channels = Number of channels in the voice.
    ///    pVolumes = Array containing the new volumes of each channel in the voice. The array must have <i>Channels</i> elements.
    ///               See Remarks for more information on volume levels.
    ///    X2DEFAULT = TBD
    ///    OperationSet = Identifies this call as part of a deferred batch. See the XAudio2 Operation Sets overview for more
    ///                   information.
    ///Returns:
    ///    Returns S_OK if successful, an error code otherwise. See XAudio2 Error Codes for descriptions of XAudio2
    ///    specific error codes.
    ///    
    HRESULT SetChannelVolumes(uint Channels, const(float)* pVolumes, uint OperationSet);
    ///Returns the volume levels for the voice, per channel.
    ///Params:
    ///    Channels = Confirms the channel count of the voice.
    ///    pVolumes = Returns the current volume level of each channel in the voice. The array must have at least <i>Channels</i>
    ///               elements. See Remarks for more information on volume levels.
    ///Returns:
    ///    This method does not return a value.
    ///    
    void    GetChannelVolumes(uint Channels, float* pVolumes);
    ///Sets the volume level of each channel of the final output for the voice. These channels are mapped to the input
    ///channels of a specified destination voice.
    ///Params:
    ///    pDestinationVoice = Pointer to a destination IXAudio2Voice for which to set volume levels. <div class="alert"><b>Note</b> If the
    ///                        voice sends to a single target voice then specifying NULL will cause <b>SetOutputMatrix</b> to operate on
    ///                        that target voice.</div> <div> </div>
    ///    SourceChannels = Confirms the output channel count of the voice. This is the number of channels that are produced by the last
    ///                     effect in the chain.
    ///    DestinationChannels = Confirms the input channel count of the destination voice.
    ///    pLevelMatrix = Array of [<i>SourceChannels</i> × <i>DestinationChannels</i>] volume levels sent to the destination voice.
    ///                   The level sent from source channel <i>S</i> to destination channel <i>D</i> is specified in the form
    ///                   <i>pLevelMatrix</i>[<i>SourceChannels</i> × <i>D</i> + <i>S</i>]. For example, when rendering two-channel
    ///                   stereo input into 5.1 output that is weighted toward the front channels—but is absent from the center and
    ///                   low-frequency channels—the matrix might have the values shown in the following table. <table> <tr>
    ///                   <th>Output</th> <th>Left Input [Array Index]</th> <th>Right Input [Array Index]</th> </tr> <tr> <td>Left</td>
    ///                   <td>1.0 [0]</td> <td>0.0 [1]</td> </tr> <tr> <td>Right</td> <td>0.0 [2]</td> <td>1.0 [3]</td> </tr> <tr>
    ///                   <td>Front Center</td> <td>0.0 [4]</td> <td>0.0 [5]</td> </tr> <tr> <td>LFE</td> <td>0.0 [6]</td> <td>0.0
    ///                   [7]</td> </tr> <tr> <td>Rear Left</td> <td>0.8 [8]</td> <td>0.0 [9]</td> </tr> <tr> <td>Rear Right</td>
    ///                   <td>0.0 [10]</td> <td>0.8 [11]</td> </tr> </table> <div class="alert"><b>Note</b> The left and right input
    ///                   are fully mapped to the output left and right channels; 80 percent of the left and right input is mapped to
    ///                   the rear left and right channels.</div> <div> </div> See Remarks for more information on volume levels.
    ///    X2DEFAULT = TBD
    ///    OperationSet = Identifies this call as part of a deferred batch. See the XAudio2 Operation Sets overview for more
    ///                   information.
    ///Returns:
    ///    Returns S_OK if successful, an error code otherwise. See XAudio2 Error Codes for descriptions of error codes.
    ///    
    HRESULT SetOutputMatrix(IXAudio2Voice pDestinationVoice, uint SourceChannels, uint DestinationChannels, 
                            const(float)* pLevelMatrix, uint OperationSet);
    ///Gets the volume level of each channel of the final output for the voice. These channels are mapped to the input
    ///channels of a specified destination voice.
    ///Params:
    ///    pDestinationVoice = Pointer specifying the destination IXAudio2Voice to retrieve the output matrix for. <div
    ///                        class="alert"><b>Note</b> If the voice sends to a single target voice then specifying NULL will cause
    ///                        <b>GetOutputMatrix</b> to operate on that target voice.</div> <div> </div>
    ///    SourceChannels = Confirms the output channel count of the voice. This is the number of channels that are produced by the last
    ///                     effect in the chain.
    ///    DestinationChannels = Confirms the input channel count of the destination voice.
    ///    pLevelMatrix = Array of [<i>SourceChannels</i> * <i>DestinationChannels</i>] volume levels sent to the destination voice.
    ///                   The level sent from source channel S to destination channel D is returned in the form
    ///                   <i>pLevelMatrix</i>[<i>DestinationChannels</i> × S + D]. See Remarks for more information on volume levels.
    ///Returns:
    ///    This method does not return a value.
    ///    
    void    GetOutputMatrix(IXAudio2Voice pDestinationVoice, uint SourceChannels, uint DestinationChannels, 
                            float* pLevelMatrix);
    ///Destroys the voice. If necessary, stops the voice and removes it from the XAudio2 graph.
    ///Returns:
    ///    This method does not return a value.
    ///    
    void    DestroyVoice();
}

///Use a source voice to submit audio data to the XAudio2 processing pipeline.You must send voice data to a mastering
///voice to be heard, either directly or through intermediate submix voices.
interface IXAudio2SourceVoice : IXAudio2Voice
{
    ///Starts consumption and processing of audio by the voice. Delivers the result to any connected submix or mastering
    ///voices, or to the output device.
    ///Params:
    ///    X2DEFAULT = TBD
    ///    Flags = Flags that control how the voice is started. Must be 0.
    ///    OperationSet = Identifies this call as part of a deferred batch. See the XAudio2 Operation Sets overview for more
    ///                   information.
    ///Returns:
    ///    Returns S_OK if successful, an error code otherwise. See XAudio2 Error Codes for descriptions of XAudio2
    ///    specific error codes.
    ///    
    HRESULT Start(uint Flags, uint OperationSet);
    ///Stops consumption of audio by the current voice.
    ///Params:
    ///    X2DEFAULT = TBD
    ///    Flags = Flags that control how the voice is stopped. Can be 0 or the following: <table> <tr> <th>Value</th>
    ///            <th>Description</th> </tr> <tr> <td>XAUDIO2_PLAY_TAILS</td> <td>Continue emitting effect output after the
    ///            voice is stopped. </td> </tr> </table>
    ///    OperationSet = Identifies this call as part of a deferred batch. See the XAudio2 Operation Sets overview for more
    ///                   information.
    ///Returns:
    ///    Returns S_OK if successful, an error code otherwise. See XAudio2 Error Codes for descriptions of XAudio2
    ///    specific error codes.
    ///    
    HRESULT Stop(uint Flags, uint OperationSet);
    ///Adds a new audio buffer to the voice queue.
    ///Params:
    ///    pBuffer = Pointer to an XAUDIO2_BUFFER structure to queue.
    ///    X2DEFAULT = TBD
    ///    pBufferWMA = Pointer to an additional XAUDIO2_BUFFER_WMA structure used when submitting WMA data.
    ///Returns:
    ///    Returns S_OK if successful, an error code otherwise. See XAudio2 Error Codes for descriptions of XAudio2
    ///    specific error codes.
    ///    
    HRESULT SubmitSourceBuffer(const(XAUDIO2_BUFFER)* pBuffer, const(XAUDIO2_BUFFER_WMA)* pBufferWMA);
    ///Removes all pending audio buffers from the voice queue.
    ///Returns:
    ///    Returns S_OK if successful, an error code otherwise.
    ///    
    HRESULT FlushSourceBuffers();
    ///Notifies an XAudio2 voice that no more buffers are coming after the last one that is currently in its queue.
    ///Returns:
    ///    Returns S_OK if successful, an error code otherwise.
    ///    
    HRESULT Discontinuity();
    ///Stops looping the voice when it reaches the end of the current loop region.
    ///Params:
    ///    X2DEFAULT = Identifies this call as part of a deferred batch. See the XAudio2 Operation Sets overview for more
    ///                information.
    ///Returns:
    ///    Returns S_OK if successful, an error code otherwise. See XAudio2 Error Codes for descriptions of XAudio2
    ///    specific error codes.
    ///    
    HRESULT ExitLoop(uint OperationSet);
    ///Returns the voice's current cursor position data.
    ///Params:
    ///    pVoiceState = Pointer to an XAUDIO2_VOICE_STATE structure containing the state of the voice.
    ///    X2DEFAULT = TBD
    ///    Flags = Flags controlling which voice state data should be returned. Valid values are 0 or
    ///            <b>XAUDIO2_VOICE_NOSAMPLESPLAYED</b>. The default value is 0. If you specify
    ///            <b>XAUDIO2_VOICE_NOSAMPLESPLAYED</b>, <b>GetState</b> returns only the buffer state, not the sampler state.
    ///            <b>GetState</b> takes roughly one-third as much time to complete when you specify
    ///            <b>XAUDIO2_VOICE_NOSAMPLESPLAYED</b>.
    void    GetState(XAUDIO2_VOICE_STATE* pVoiceState, uint Flags);
    ///Sets the frequency adjustment ratio of the voice.
    ///Params:
    ///    Ratio = Frequency adjustment ratio. This value must be between XAUDIO2_MIN_FREQ_RATIO and the
    ///            <i>MaxFrequencyRatio</i> parameter specified when the voice was created (see IXAudio2::CreateSourceVoice).
    ///            XAUDIO2_MIN_FREQ_RATIO currently is 0.0005, which allows pitch to be lowered by up to 11 octaves.
    ///    X2DEFAULT = TBD
    ///    OperationSet = Identifies this call as part of a deferred batch. See the XAudio2 Operation Sets overview for more
    ///                   information.
    ///Returns:
    ///    Returns S_OK if successful, an error code otherwise. See XAudio2 Error Codes for descriptions of error codes.
    ///    
    HRESULT SetFrequencyRatio(float Ratio, uint OperationSet);
    ///Returns the frequency adjustment ratio of the voice.
    ///Params:
    ///    pRatio = Returns the current frequency adjustment ratio if successful.
    void    GetFrequencyRatio(float* pRatio);
    ///Reconfigures the voice to consume source data at a different sample rate than the rate specified when the voice
    ///was created.
    ///Params:
    ///    NewSourceSampleRate = The new sample rate the voice should process submitted data at. Valid sample rates are 1kHz to 200kHz.
    ///Returns:
    ///    Returns S_OK if successful, an error code otherwise. See XAudio2 Error Codes for descriptions of error codes.
    ///    
    HRESULT SetSourceSampleRate(uint NewSourceSampleRate);
}

///A submix voice is used primarily for performance improvements and effects processing.
interface IXAudio2SubmixVoice : IXAudio2Voice
{
}

///A mastering voice is used to represent the audio output device. Data buffers cannot be submitted directly to
///mastering voices, but data submitted to other types of voices must be directed to a mastering voice to be heard.
///<b>IXAudio2MasteringVoice</b> inherits directly from IXAudio2Voice, but does not implement methods specific to
///mastering voices. The interface type exists solely because some of the base class methods are implemented differently
///for mastering voices. Having a separate type for these voices helps client code to distinguish the different voice
///types and to benefit from C++ type safety.
interface IXAudio2MasteringVoice : IXAudio2Voice
{
    ///Returns the channel mask for this voice.
    ///Params:
    ///    pChannelmask = Returns the channel mask for this voice. This corresponds to the <b>dwChannelMask</b> member of the
    ///                   WAVEFORMATEXTENSIBLE structure.
    ///Returns:
    ///    This method does not return a value.
    ///    
    HRESULT GetChannelMask(uint* pChannelmask);
}

///The IXAudio2EngineCallback interface contains methods that notify the client when certain events happen in the
///IXAudio2 engine. This interface should be implemented by the XAudio2 client. XAudio2 calls these methods via an
///interface pointer provided by the client, using the XAudio2Create method. Methods in this interface return
///<b>void</b>, rather than an HRESULT. See XAudio2 Callbacks for restrictions on callback implementation. <ul>
///<li>Methods</li> </ul><h3><a id="methods"></a>Methods</h3>The <b>IXAudio2EngineCallback</b> interface has these
///methods. <table class="members" id="memberListMethods"> <tr> <th align="left" width="37%">Method</th> <th
///align="left" width="63%">Description</th> </tr> <tr data="declared;"> <td align="left" width="37%"> OnCriticalError
///</td> <td align="left" width="63%"> Called if a critical system error occurs that requires XAudio2 to be closed down
///and restarted. </td> </tr> <tr data="declared;"> <td align="left" width="37%"> OnProcessingPassEnd </td> <td
///align="left" width="63%"> Called by XAudio2 just after an audio processing pass ends. </td> </tr> <tr
///data="declared;"> <td align="left" width="37%"> OnProcessingPassStart </td> <td align="left" width="63%"> Called by
///XAudio2 just before an audio processing pass begins. </td> </tr> </table>
interface IXAudio2EngineCallback
{
    ///Called by XAudio2 just before an audio processing pass begins.
    void OnProcessingPassStart();
    ///Called by XAudio2 just after an audio processing pass ends.
    void OnProcessingPassEnd();
    ///Called if a critical system error occurs that requires XAudio2 to be closed down and restarted.
    ///Params:
    ///    Error = Error code returned by XAudio2.
    void OnCriticalError(HRESULT Error);
}

///The <b>IXAudio2VoiceCallback</b> interface contains methods that notify the client when certain events happen in a
///given IXAudio2SourceVoice. This interface should be implemented by the XAudio2 client. XAudio2 calls these methods
///through an interface pointer provided by the client in the IXAudio2::CreateSourceVoice method. Methods in this
///interface return void, rather than an HRESULT. See the XAudio2 Callbacks topic for restrictions on callback
///implementation. <ul> <li>Methods</li> </ul><h3><a id="methods"></a>Methods</h3>The <b>IXAudio2VoiceCallback</b>
///interface has these methods. <table class="members" id="memberListMethods"> <tr> <th align="left"
///width="37%">Method</th> <th align="left" width="63%">Description</th> </tr> <tr data="declared;"> <td align="left"
///width="37%"> OnBufferEnd </td> <td align="left" width="63%"> Called when the voice finishes processing a buffer.
///</td> </tr> <tr data="declared;"> <td align="left" width="37%"> OnBufferStart </td> <td align="left" width="63%">
///Called when the voice is about to start processing a new audio buffer. </td> </tr> <tr data="declared;"> <td
///align="left" width="37%"> OnLoopEnd </td> <td align="left" width="63%"> Called when the voice reaches the end
///position of a loop. </td> </tr> <tr data="declared;"> <td align="left" width="37%"> OnStreamEnd </td> <td
///align="left" width="63%"> Called when the voice has just finished playing a contiguous audio stream. </td> </tr> <tr
///data="declared;"> <td align="left" width="37%"> OnVoiceError </td> <td align="left" width="63%"> Called when a
///critical error occurs during voice processing. </td> </tr> <tr data="declared;"> <td align="left" width="37%">
///OnVoiceProcessingPassEnd </td> <td align="left" width="63%"> Called just after the processing pass for the voice
///ends. </td> </tr> <tr data="declared;"> <td align="left" width="37%"> OnVoiceProcessingPassStart </td> <td
///align="left" width="63%"> Called during each processing pass for each voice, just before XAudio2 reads data from the
///voice's buffer queue. </td> </tr> </table>
interface IXAudio2VoiceCallback
{
    ///Called during each processing pass for each voice, just before XAudio2 reads data from the voice's buffer queue.
    ///Params:
    ///    BytesRequired = The number of bytes that must be submitted immediately to avoid starvation. This allows the implementation of
    ///                    just-in-time streaming scenarios; the client can keep the absolute minimum data queued on the voice at all
    ///                    times, and pass it fresh data just before the data is required. This model provides the lowest possible
    ///                    latency attainable with XAudio2. For xWMA and XMA data <i>BytesRequired</i> will always be zero, since the
    ///                    concept of a frame of xWMA or XMA data is meaningless. <div class="alert"><b>Note</b> In a situation where
    ///                    there is always plenty of data available on the source voice, <i>BytesRequired</i> should always report zero,
    ///                    because it doesn't need any samples immediately to avoid glitching.</div> <div> </div>
    void OnVoiceProcessingPassStart(uint BytesRequired);
    ///Called just after the processing pass for the voice ends.
    void OnVoiceProcessingPassEnd();
    ///Called when the voice has just finished playing a contiguous audio stream.
    void OnStreamEnd();
    ///Called when the voice is about to start processing a new audio buffer.
    ///Params:
    ///    pBufferContext = Context pointer that was assigned to the pContext member of the XAUDIO2_BUFFER structure when the buffer was
    ///                     submitted.
    void OnBufferStart(void* pBufferContext);
    ///Called when the voice finishes processing a buffer.
    ///Params:
    ///    pBufferContext = Context pointer assigned to the <b>pContext</b> member of the XAUDIO2_BUFFER structure when the buffer was
    ///                     submitted.
    void OnBufferEnd(void* pBufferContext);
    ///Called when the voice reaches the end position of a loop.
    ///Params:
    ///    pBufferContext = Context pointer that was assigned to the <b>pContext</b> member of the XAUDIO2_BUFFER structure when the
    ///                     buffer was submitted.
    void OnLoopEnd(void* pBufferContext);
    ///Called when a critical error occurs during voice processing.
    ///Params:
    ///    pBufferContext = Context pointer that was assigned to the <b>pContext</b> member of the XAUDIO2_BUFFER structure when the
    ///                     buffer was submitted.
    ///    Error = The HRESULT code of the error encountered.
    void OnVoiceError(void* pBufferContext, HRESULT Error);
}

///The interface used to set parameters that control how head-related transfer function (HRTF) is applied to a sound.
@GUID("15B3CD66-E9DE-4464-B6E6-2BC3CF63D455")
interface IXAPOHrtfParameters : IUnknown
{
    ///Sets the position of the sound relative to the listener.
    ///Params:
    ///    position = The position of the sound relative to the listener.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT SetSourcePosition(const(HrtfPosition)* position);
    ///Set the rotation matrix for the source orientation, with respect to the listener's coordinate system.
    ///Params:
    ///    orientation = The rotation matrix for the source orientation, with respect to the listener's frame of reference.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT SetSourceOrientation(const(HrtfOrientation)* orientation);
    ///Sets the custom direct-path gain value for the current source position in dB. Valid only for sounds played with
    ///the HrtfDistanceDecayType custom decay type.
    ///Params:
    ///    gain = The custom direct-path gain value for the current source position in dB. Valid only for sounds played with
    ///           the HrtfDistanceDecayType custom decay type.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT SetSourceGain(float gain);
    ///Selects the acoustic environment to simulate.
    ///Params:
    ///    environment = The acoustic environment to simulate.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT SetEnvironment(HrtfEnvironment environment);
}


// GUIDs

const GUID CLSID_AudioReverb        = GUIDOF!AudioReverb;
const GUID CLSID_AudioVolumeMeter   = GUIDOF!AudioVolumeMeter;
const GUID CLSID_FXEQ               = GUIDOF!FXEQ;
const GUID CLSID_FXEcho             = GUIDOF!FXEcho;
const GUID CLSID_FXMasteringLimiter = GUIDOF!FXMasteringLimiter;
const GUID CLSID_FXReverb           = GUIDOF!FXReverb;

const GUID IID_IXAPO               = GUIDOF!IXAPO;
const GUID IID_IXAPOHrtfParameters = GUIDOF!IXAPOHrtfParameters;
const GUID IID_IXAPOParameters     = GUIDOF!IXAPOParameters;
const GUID IID_IXAudio2            = GUIDOF!IXAudio2;
const GUID IID_IXAudio2Extension   = GUIDOF!IXAudio2Extension;
