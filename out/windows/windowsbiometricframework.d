module windows.windowsbiometricframework;

public import system;
public import windows.com;
public import windows.systemservices;
public import windows.windowsandmessaging;

extern(Windows):

struct WINBIO_VERSION
{
    uint MajorVersion;
    uint MinorVersion;
}

struct WINBIO_IDENTITY
{
    uint Type;
    _Value_e__Union Value;
}

struct WINBIO_SECURE_CONNECTION_PARAMS
{
    uint PayloadSize;
    ushort Version;
    ushort Flags;
}

struct WINBIO_SECURE_CONNECTION_DATA
{
    uint Size;
    ushort Version;
    ushort Flags;
    uint ModelCertificateSize;
    uint IntermediateCA1Size;
    uint IntermediateCA2Size;
}

struct WINBIO_BIR_DATA
{
    uint Size;
    uint Offset;
}

struct WINBIO_BIR
{
    WINBIO_BIR_DATA HeaderBlock;
    WINBIO_BIR_DATA StandardDataBlock;
    WINBIO_BIR_DATA VendorDataBlock;
    WINBIO_BIR_DATA SignatureBlock;
}

struct WINBIO_REGISTERED_FORMAT
{
    ushort Owner;
    ushort Type;
}

struct WINBIO_BIR_HEADER
{
    ushort ValidFields;
    ubyte HeaderVersion;
    ubyte PatronHeaderVersion;
    ubyte DataFlags;
    uint Type;
    ubyte Subtype;
    ubyte Purpose;
    byte DataQuality;
    LARGE_INTEGER CreationDate;
    _ValidityPeriod_e__Struct ValidityPeriod;
    WINBIO_REGISTERED_FORMAT BiometricDataFormat;
    WINBIO_REGISTERED_FORMAT ProductId;
}

struct WINBIO_BDB_ANSI_381_HEADER
{
    ulong RecordLength;
    uint FormatIdentifier;
    uint VersionNumber;
    WINBIO_REGISTERED_FORMAT ProductId;
    ushort CaptureDeviceId;
    ushort ImageAcquisitionLevel;
    ushort HorizontalScanResolution;
    ushort VerticalScanResolution;
    ushort HorizontalImageResolution;
    ushort VerticalImageResolution;
    ubyte ElementCount;
    ubyte ScaleUnits;
    ubyte PixelDepth;
    ubyte ImageCompressionAlg;
    ushort Reserved;
}

struct WINBIO_BDB_ANSI_381_RECORD
{
    uint BlockLength;
    ushort HorizontalLineLength;
    ushort VerticalLineLength;
    ubyte Position;
    ubyte CountOfViews;
    ubyte ViewNumber;
    ubyte ImageQuality;
    ubyte ImpressionType;
    ubyte Reserved;
}

struct WINBIO_SECURE_BUFFER_HEADER_V1
{
    uint Type;
    uint Size;
    uint Flags;
    ulong ValidationTag;
}

struct WINBIO_EVENT
{
    uint Type;
    _Parameters_e__Union Parameters;
}

struct WINBIO_PRESENCE_PROPERTIES
{
    _FacialFeatures_e__Struct FacialFeatures;
    _Iris_e__Struct Iris;
}

struct WINBIO_PRESENCE
{
    uint Factor;
    ubyte SubFactor;
    HRESULT Status;
    uint RejectDetail;
    WINBIO_IDENTITY Identity;
    ulong TrackingId;
    ulong Ticket;
    WINBIO_PRESENCE_PROPERTIES Properties;
    _Authorization_e__Struct Authorization;
}

struct WINBIO_BSP_SCHEMA
{
    uint BiometricFactor;
    Guid BspId;
    ushort Description;
    ushort Vendor;
    WINBIO_VERSION Version;
}

struct WINBIO_UNIT_SCHEMA
{
    uint UnitId;
    uint PoolType;
    uint BiometricFactor;
    uint SensorSubType;
    uint Capabilities;
    ushort DeviceInstanceId;
    ushort Description;
    ushort Manufacturer;
    ushort Model;
    ushort SerialNumber;
    WINBIO_VERSION FirmwareVersion;
}

struct WINBIO_STORAGE_SCHEMA
{
    uint BiometricFactor;
    Guid DatabaseId;
    Guid DataFormat;
    uint Attributes;
    ushort FilePath;
    ushort ConnectionString;
}

struct WINBIO_EXTENDED_SENSOR_INFO
{
    uint GenericSensorCapabilities;
    uint Factor;
    _Specific_e__Union Specific;
}

struct WINBIO_EXTENDED_ENGINE_INFO
{
    uint GenericEngineCapabilities;
    uint Factor;
    _Specific_e__Union Specific;
}

struct WINBIO_EXTENDED_STORAGE_INFO
{
    uint GenericStorageCapabilities;
    uint Factor;
    _Specific_e__Union Specific;
}

struct WINBIO_EXTENDED_ENROLLMENT_STATUS
{
    HRESULT TemplateStatus;
    uint RejectDetail;
    uint PercentComplete;
    uint Factor;
    ubyte SubFactor;
    _Specific_e__Union Specific;
}

struct WINBIO_EXTENDED_UNIT_STATUS
{
    uint Availability;
    uint ReasonCode;
}

struct WINBIO_FP_BU_STATE
{
    BOOL SensorAttached;
    HRESULT CreationResult;
}

enum WINBIO_ANTI_SPOOF_POLICY_ACTION
{
    WINBIO_ANTI_SPOOF_DISABLE = 0,
    WINBIO_ANTI_SPOOF_ENABLE = 1,
    WINBIO_ANTI_SPOOF_REMOVE = 2,
}

enum WINBIO_POLICY_SOURCE
{
    WINBIO_POLICY_UNKNOWN = 0,
    WINBIO_POLICY_DEFAULT = 1,
    WINBIO_POLICY_LOCAL = 2,
    WINBIO_POLICY_ADMIN = 3,
}

struct WINBIO_ANTI_SPOOF_POLICY
{
    WINBIO_ANTI_SPOOF_POLICY_ACTION Action;
    WINBIO_POLICY_SOURCE Source;
}

enum WINBIO_CREDENTIAL_TYPE
{
    WINBIO_CREDENTIAL_PASSWORD = 1,
    WINBIO_CREDENTIAL_ALL = -1,
}

enum WINBIO_CREDENTIAL_FORMAT
{
    WINBIO_PASSWORD_GENERIC = 1,
    WINBIO_PASSWORD_PACKED = 2,
    WINBIO_PASSWORD_PROTECTED = 3,
}

enum WINBIO_CREDENTIAL_STATE
{
    WINBIO_CREDENTIAL_NOT_SET = 1,
    WINBIO_CREDENTIAL_SET = 2,
}

struct WINBIO_EXTENDED_ENROLLMENT_PARAMETERS
{
    uint Size;
    ubyte SubFactor;
}

struct WINBIO_ACCOUNT_POLICY
{
    WINBIO_IDENTITY Identity;
    WINBIO_ANTI_SPOOF_POLICY_ACTION AntiSpoofBehavior;
}

struct WINBIO_PROTECTION_POLICY
{
    uint Version;
    WINBIO_IDENTITY Identity;
    Guid DatabaseId;
    ulong UserState;
    uint PolicySize;
    ubyte Policy;
}

struct WINBIO_GESTURE_METADATA
{
    uint Size;
    uint BiometricType;
    uint MatchType;
    uint ProtectionType;
}

enum WINBIO_ASYNC_NOTIFICATION_METHOD
{
    WINBIO_ASYNC_NOTIFY_NONE = 0,
    WINBIO_ASYNC_NOTIFY_CALLBACK = 1,
    WINBIO_ASYNC_NOTIFY_MESSAGE = 2,
    WINBIO_ASYNC_NOTIFY_MAXIMUM_VALUE = 3,
}

struct WINBIO_ASYNC_RESULT
{
    uint SessionHandle;
    uint Operation;
    ulong SequenceNumber;
    long TimeStamp;
    HRESULT ApiStatus;
    uint UnitId;
    void* UserData;
    _Parameters_e__Union Parameters;
}

alias PWINBIO_ASYNC_COMPLETION_CALLBACK = extern(Windows) void function(WINBIO_ASYNC_RESULT* AsyncResult);
alias PWINBIO_VERIFY_CALLBACK = extern(Windows) void function(void* VerifyCallbackContext, HRESULT OperationStatus, uint UnitId, ubyte Match, uint RejectDetail);
alias PWINBIO_IDENTIFY_CALLBACK = extern(Windows) void function(void* IdentifyCallbackContext, HRESULT OperationStatus, uint UnitId, WINBIO_IDENTITY* Identity, ubyte SubFactor, uint RejectDetail);
alias PWINBIO_LOCATE_SENSOR_CALLBACK = extern(Windows) void function(void* LocateCallbackContext, HRESULT OperationStatus, uint UnitId);
alias PWINBIO_ENROLL_CAPTURE_CALLBACK = extern(Windows) void function(void* EnrollCallbackContext, HRESULT OperationStatus, uint RejectDetail);
alias PWINBIO_EVENT_CALLBACK = extern(Windows) void function(void* EventCallbackContext, HRESULT OperationStatus, WINBIO_EVENT* Event);
alias PWINBIO_CAPTURE_CALLBACK = extern(Windows) void function(void* CaptureCallbackContext, HRESULT OperationStatus, uint UnitId, char* Sample, uint SampleSize, uint RejectDetail);
struct _WINIBIO_SENSOR_CONTEXT
{
}

struct _WINIBIO_ENGINE_CONTEXT
{
}

struct _WINIBIO_STORAGE_CONTEXT
{
}

struct WINBIO_STORAGE_RECORD
{
    WINBIO_IDENTITY* Identity;
    ubyte SubFactor;
    uint* IndexVector;
    uint IndexElementCount;
    ubyte* TemplateBlob;
    uint TemplateBlobSize;
    ubyte* PayloadBlob;
    uint PayloadBlobSize;
}

struct WINBIO_PIPELINE
{
    HANDLE SensorHandle;
    HANDLE EngineHandle;
    HANDLE StorageHandle;
    WINBIO_SENSOR_INTERFACE* SensorInterface;
    WINBIO_ENGINE_INTERFACE* EngineInterface;
    WINBIO_STORAGE_INTERFACE* StorageInterface;
    _WINIBIO_SENSOR_CONTEXT* SensorContext;
    _WINIBIO_ENGINE_CONTEXT* EngineContext;
    _WINIBIO_STORAGE_CONTEXT* StorageContext;
    WINBIO_FRAMEWORK_INTERFACE* FrameworkInterface;
}

struct WINBIO_ADAPTER_INTERFACE_VERSION
{
    ushort MajorVersion;
    ushort MinorVersion;
}

alias PIBIO_SENSOR_ATTACH_FN = extern(Windows) HRESULT function(WINBIO_PIPELINE* Pipeline);
alias PIBIO_SENSOR_DETACH_FN = extern(Windows) HRESULT function(WINBIO_PIPELINE* Pipeline);
alias PIBIO_SENSOR_CLEAR_CONTEXT_FN = extern(Windows) HRESULT function(WINBIO_PIPELINE* Pipeline);
alias PIBIO_SENSOR_QUERY_STATUS_FN = extern(Windows) HRESULT function(WINBIO_PIPELINE* Pipeline, uint* Status);
alias PIBIO_SENSOR_RESET_FN = extern(Windows) HRESULT function(WINBIO_PIPELINE* Pipeline);
alias PIBIO_SENSOR_SET_MODE_FN = extern(Windows) HRESULT function(WINBIO_PIPELINE* Pipeline, uint Mode);
alias PIBIO_SENSOR_SET_INDICATOR_STATUS_FN = extern(Windows) HRESULT function(WINBIO_PIPELINE* Pipeline, uint IndicatorStatus);
alias PIBIO_SENSOR_GET_INDICATOR_STATUS_FN = extern(Windows) HRESULT function(WINBIO_PIPELINE* Pipeline, uint* IndicatorStatus);
alias PIBIO_SENSOR_START_CAPTURE_FN = extern(Windows) HRESULT function(WINBIO_PIPELINE* Pipeline, ubyte Purpose, OVERLAPPED** Overlapped);
alias PIBIO_SENSOR_FINISH_CAPTURE_FN = extern(Windows) HRESULT function(WINBIO_PIPELINE* Pipeline, uint* RejectDetail);
alias PIBIO_SENSOR_EXPORT_SENSOR_DATA_FN = extern(Windows) HRESULT function(WINBIO_PIPELINE* Pipeline, WINBIO_BIR** SampleBuffer, uint* SampleSize);
alias PIBIO_SENSOR_CANCEL_FN = extern(Windows) HRESULT function(WINBIO_PIPELINE* Pipeline);
alias PIBIO_SENSOR_PUSH_DATA_TO_ENGINE_FN = extern(Windows) HRESULT function(WINBIO_PIPELINE* Pipeline, ubyte Purpose, ubyte Flags, uint* RejectDetail);
alias PIBIO_SENSOR_CONTROL_UNIT_FN = extern(Windows) HRESULT function(WINBIO_PIPELINE* Pipeline, uint ControlCode, char* SendBuffer, uint SendBufferSize, char* ReceiveBuffer, uint ReceiveBufferSize, uint* ReceiveDataSize, uint* OperationStatus);
alias PIBIO_SENSOR_CONTROL_UNIT_PRIVILEGED_FN = extern(Windows) HRESULT function(WINBIO_PIPELINE* Pipeline, uint ControlCode, char* SendBuffer, uint SendBufferSize, char* ReceiveBuffer, uint ReceiveBufferSize, uint* ReceiveDataSize, uint* OperationStatus);
alias PIBIO_SENSOR_NOTIFY_POWER_CHANGE_FN = extern(Windows) HRESULT function(WINBIO_PIPELINE* Pipeline, uint PowerEventType);
alias PIBIO_SENSOR_PIPELINE_INIT_FN = extern(Windows) HRESULT function(WINBIO_PIPELINE* Pipeline);
alias PIBIO_SENSOR_PIPELINE_CLEANUP_FN = extern(Windows) HRESULT function(WINBIO_PIPELINE* Pipeline);
alias PIBIO_SENSOR_ACTIVATE_FN = extern(Windows) HRESULT function(WINBIO_PIPELINE* Pipeline);
alias PIBIO_SENSOR_DEACTIVATE_FN = extern(Windows) HRESULT function(WINBIO_PIPELINE* Pipeline);
alias PIBIO_SENSOR_QUERY_EXTENDED_INFO_FN = extern(Windows) HRESULT function(WINBIO_PIPELINE* Pipeline, char* SensorInfo, uint SensorInfoSize);
alias PIBIO_SENSOR_QUERY_CALIBRATION_FORMATS_FN = extern(Windows) HRESULT function(WINBIO_PIPELINE* Pipeline, char* FormatArray, uint FormatArraySize, uint* FormatCount);
alias PIBIO_SENSOR_SET_CALIBRATION_FORMAT_FN = extern(Windows) HRESULT function(WINBIO_PIPELINE* Pipeline, Guid* Format);
alias PIBIO_SENSOR_ACCEPT_CALIBRATION_DATA_FN = extern(Windows) HRESULT function(WINBIO_PIPELINE* Pipeline, char* CalibrationBuffer, uint CalibrationBufferSize);
alias PIBIO_SENSOR_ASYNC_IMPORT_RAW_BUFFER_FN = extern(Windows) HRESULT function(WINBIO_PIPELINE* Pipeline, char* RawBufferAddress, uint RawBufferSize, ubyte** ResultBufferAddress, uint* ResultBufferSize);
alias PIBIO_SENSOR_ASYNC_IMPORT_SECURE_BUFFER_FN = extern(Windows) HRESULT function(WINBIO_PIPELINE* Pipeline, Guid SecureBufferIdentifier, char* MetadataBufferAddress, uint MetadataBufferSize, ubyte** ResultBufferAddress, uint* ResultBufferSize);
alias PIBIO_SENSOR_QUERY_PRIVATE_SENSOR_TYPE_FN = extern(Windows) HRESULT function(WINBIO_PIPELINE* Pipeline, char* TypeInfoBufferAddress, uint TypeInfoBufferSize, uint* TypeInfoDataSize);
alias PIBIO_SENSOR_CONNECT_SECURE_FN = extern(Windows) HRESULT function(WINBIO_PIPELINE* Pipeline, const(WINBIO_SECURE_CONNECTION_PARAMS)* ConnectionParams, WINBIO_SECURE_CONNECTION_DATA** ConnectionData);
alias PIBIO_SENSOR_START_CAPTURE_EX_FN = extern(Windows) HRESULT function(WINBIO_PIPELINE* Pipeline, ubyte Purpose, char* Nonce, uint NonceSize, ubyte Flags, OVERLAPPED** Overlapped);
alias PIBIO_SENSOR_START_NOTIFY_WAKE_FN = extern(Windows) HRESULT function(WINBIO_PIPELINE* Pipeline, OVERLAPPED** Overlapped);
alias PIBIO_SENSOR_FINISH_NOTIFY_WAKE_FN = extern(Windows) HRESULT function(WINBIO_PIPELINE* Pipeline, uint* Reason);
struct WINBIO_SENSOR_INTERFACE
{
    WINBIO_ADAPTER_INTERFACE_VERSION Version;
    uint Type;
    uint Size;
    Guid AdapterId;
    PIBIO_SENSOR_ATTACH_FN Attach;
    PIBIO_SENSOR_DETACH_FN Detach;
    PIBIO_SENSOR_CLEAR_CONTEXT_FN ClearContext;
    PIBIO_SENSOR_QUERY_STATUS_FN QueryStatus;
    PIBIO_SENSOR_RESET_FN Reset;
    PIBIO_SENSOR_SET_MODE_FN SetMode;
    PIBIO_SENSOR_SET_INDICATOR_STATUS_FN SetIndicatorStatus;
    PIBIO_SENSOR_GET_INDICATOR_STATUS_FN GetIndicatorStatus;
    PIBIO_SENSOR_START_CAPTURE_FN StartCapture;
    PIBIO_SENSOR_FINISH_CAPTURE_FN FinishCapture;
    PIBIO_SENSOR_EXPORT_SENSOR_DATA_FN ExportSensorData;
    PIBIO_SENSOR_CANCEL_FN Cancel;
    PIBIO_SENSOR_PUSH_DATA_TO_ENGINE_FN PushDataToEngine;
    PIBIO_SENSOR_CONTROL_UNIT_FN ControlUnit;
    PIBIO_SENSOR_CONTROL_UNIT_PRIVILEGED_FN ControlUnitPrivileged;
    PIBIO_SENSOR_NOTIFY_POWER_CHANGE_FN NotifyPowerChange;
    PIBIO_SENSOR_PIPELINE_INIT_FN PipelineInit;
    PIBIO_SENSOR_PIPELINE_CLEANUP_FN PipelineCleanup;
    PIBIO_SENSOR_ACTIVATE_FN Activate;
    PIBIO_SENSOR_DEACTIVATE_FN Deactivate;
    PIBIO_SENSOR_QUERY_EXTENDED_INFO_FN QueryExtendedInfo;
    PIBIO_SENSOR_QUERY_CALIBRATION_FORMATS_FN QueryCalibrationFormats;
    PIBIO_SENSOR_SET_CALIBRATION_FORMAT_FN SetCalibrationFormat;
    PIBIO_SENSOR_ACCEPT_CALIBRATION_DATA_FN AcceptCalibrationData;
    PIBIO_SENSOR_ASYNC_IMPORT_RAW_BUFFER_FN AsyncImportRawBuffer;
    PIBIO_SENSOR_ASYNC_IMPORT_SECURE_BUFFER_FN AsyncImportSecureBuffer;
    PIBIO_SENSOR_QUERY_PRIVATE_SENSOR_TYPE_FN QueryPrivateSensorType;
    PIBIO_SENSOR_CONNECT_SECURE_FN ConnectSecure;
    PIBIO_SENSOR_START_CAPTURE_EX_FN StartCaptureEx;
    PIBIO_SENSOR_START_NOTIFY_WAKE_FN StartNotifyWake;
    PIBIO_SENSOR_FINISH_NOTIFY_WAKE_FN FinishNotifyWake;
}

alias PWINBIO_QUERY_SENSOR_INTERFACE_FN = extern(Windows) HRESULT function(WINBIO_SENSOR_INTERFACE** SensorInterface);
alias PIBIO_ENGINE_ATTACH_FN = extern(Windows) HRESULT function(WINBIO_PIPELINE* Pipeline);
alias PIBIO_ENGINE_DETACH_FN = extern(Windows) HRESULT function(WINBIO_PIPELINE* Pipeline);
alias PIBIO_ENGINE_CLEAR_CONTEXT_FN = extern(Windows) HRESULT function(WINBIO_PIPELINE* Pipeline);
alias PIBIO_ENGINE_QUERY_PREFERRED_FORMAT_FN = extern(Windows) HRESULT function(WINBIO_PIPELINE* Pipeline, WINBIO_REGISTERED_FORMAT* StandardFormat, Guid* VendorFormat);
alias PIBIO_ENGINE_QUERY_INDEX_VECTOR_SIZE_FN = extern(Windows) HRESULT function(WINBIO_PIPELINE* Pipeline, uint* IndexElementCount);
alias PIBIO_ENGINE_QUERY_HASH_ALGORITHMS_FN = extern(Windows) HRESULT function(WINBIO_PIPELINE* Pipeline, uint* AlgorithmCount, uint* AlgorithmBufferSize, char* AlgorithmBuffer);
alias PIBIO_ENGINE_SET_HASH_ALGORITHM_FN = extern(Windows) HRESULT function(WINBIO_PIPELINE* Pipeline, uint AlgorithmBufferSize, char* AlgorithmBuffer);
alias PIBIO_ENGINE_QUERY_SAMPLE_HINT_FN = extern(Windows) HRESULT function(WINBIO_PIPELINE* Pipeline, uint* SampleHint);
alias PIBIO_ENGINE_ACCEPT_SAMPLE_DATA_FN = extern(Windows) HRESULT function(WINBIO_PIPELINE* Pipeline, char* SampleBuffer, uint SampleSize, ubyte Purpose, uint* RejectDetail);
alias PIBIO_ENGINE_EXPORT_ENGINE_DATA_FN = extern(Windows) HRESULT function(WINBIO_PIPELINE* Pipeline, ubyte Flags, char* SampleBuffer, uint* SampleSize);
alias PIBIO_ENGINE_VERIFY_FEATURE_SET_FN = extern(Windows) HRESULT function(WINBIO_PIPELINE* Pipeline, WINBIO_IDENTITY* Identity, ubyte SubFactor, ubyte* Match, char* PayloadBlob, uint* PayloadBlobSize, char* HashValue, uint* HashSize, uint* RejectDetail);
alias PIBIO_ENGINE_IDENTIFY_FEATURE_SET_FN = extern(Windows) HRESULT function(WINBIO_PIPELINE* Pipeline, WINBIO_IDENTITY* Identity, ubyte* SubFactor, char* PayloadBlob, uint* PayloadBlobSize, char* HashValue, uint* HashSize, uint* RejectDetail);
alias PIBIO_ENGINE_CREATE_ENROLLMENT_FN = extern(Windows) HRESULT function(WINBIO_PIPELINE* Pipeline);
alias PIBIO_ENGINE_UPDATE_ENROLLMENT_FN = extern(Windows) HRESULT function(WINBIO_PIPELINE* Pipeline, uint* RejectDetail);
alias PIBIO_ENGINE_GET_ENROLLMENT_STATUS_FN = extern(Windows) HRESULT function(WINBIO_PIPELINE* Pipeline, uint* RejectDetail);
alias PIBIO_ENGINE_GET_ENROLLMENT_HASH_FN = extern(Windows) HRESULT function(WINBIO_PIPELINE* Pipeline, char* HashValue, uint* HashSize);
alias PIBIO_ENGINE_CHECK_FOR_DUPLICATE_FN = extern(Windows) HRESULT function(WINBIO_PIPELINE* Pipeline, WINBIO_IDENTITY* Identity, ubyte* SubFactor, ubyte* Duplicate);
alias PIBIO_ENGINE_COMMIT_ENROLLMENT_FN = extern(Windows) HRESULT function(WINBIO_PIPELINE* Pipeline, WINBIO_IDENTITY* Identity, ubyte SubFactor, char* PayloadBlob, uint PayloadBlobSize);
alias PIBIO_ENGINE_DISCARD_ENROLLMENT_FN = extern(Windows) HRESULT function(WINBIO_PIPELINE* Pipeline);
alias PIBIO_ENGINE_CONTROL_UNIT_FN = extern(Windows) HRESULT function(WINBIO_PIPELINE* Pipeline, uint ControlCode, char* SendBuffer, uint SendBufferSize, char* ReceiveBuffer, uint ReceiveBufferSize, uint* ReceiveDataSize, uint* OperationStatus);
alias PIBIO_ENGINE_CONTROL_UNIT_PRIVILEGED_FN = extern(Windows) HRESULT function(WINBIO_PIPELINE* Pipeline, uint ControlCode, char* SendBuffer, uint SendBufferSize, char* ReceiveBuffer, uint ReceiveBufferSize, uint* ReceiveDataSize, uint* OperationStatus);
alias PIBIO_ENGINE_NOTIFY_POWER_CHANGE_FN = extern(Windows) HRESULT function(WINBIO_PIPELINE* Pipeline, uint PowerEventType);
alias PIBIO_ENGINE_RESERVED_1_FN = extern(Windows) HRESULT function(WINBIO_PIPELINE* Pipeline, WINBIO_IDENTITY* Identity);
alias PIBIO_ENGINE_PIPELINE_INIT_FN = extern(Windows) HRESULT function(WINBIO_PIPELINE* Pipeline);
alias PIBIO_ENGINE_PIPELINE_CLEANUP_FN = extern(Windows) HRESULT function(WINBIO_PIPELINE* Pipeline);
alias PIBIO_ENGINE_ACTIVATE_FN = extern(Windows) HRESULT function(WINBIO_PIPELINE* Pipeline);
alias PIBIO_ENGINE_DEACTIVATE_FN = extern(Windows) HRESULT function(WINBIO_PIPELINE* Pipeline);
alias PIBIO_ENGINE_QUERY_EXTENDED_INFO_FN = extern(Windows) HRESULT function(WINBIO_PIPELINE* Pipeline, char* EngineInfo, uint EngineInfoSize);
alias PIBIO_ENGINE_IDENTIFY_ALL_FN = extern(Windows) HRESULT function(WINBIO_PIPELINE* Pipeline, uint* PresenceCount, WINBIO_PRESENCE** PresenceArray);
alias PIBIO_ENGINE_SET_ENROLLMENT_SELECTOR_FN = extern(Windows) HRESULT function(WINBIO_PIPELINE* Pipeline, ulong SelectorValue);
alias PIBIO_ENGINE_SET_ENROLLMENT_PARAMETERS_FN = extern(Windows) HRESULT function(WINBIO_PIPELINE* Pipeline, WINBIO_EXTENDED_ENROLLMENT_PARAMETERS* Parameters);
alias PIBIO_ENGINE_QUERY_EXTENDED_ENROLLMENT_STATUS_FN = extern(Windows) HRESULT function(WINBIO_PIPELINE* Pipeline, char* EnrollmentStatus, uint EnrollmentStatusSize);
alias PIBIO_ENGINE_REFRESH_CACHE_FN = extern(Windows) HRESULT function(WINBIO_PIPELINE* Pipeline);
alias PIBIO_ENGINE_SELECT_CALIBRATION_FORMAT_FN = extern(Windows) HRESULT function(WINBIO_PIPELINE* Pipeline, char* FormatArray, uint FormatCount, Guid* SelectedFormat, uint* MaxBufferSize);
alias PIBIO_ENGINE_QUERY_CALIBRATION_DATA_FN = extern(Windows) HRESULT function(WINBIO_PIPELINE* Pipeline, ubyte* DiscardAndRepeatCapture, char* CalibrationBuffer, uint* CalibrationBufferSize, uint MaxBufferSize);
alias PIBIO_ENGINE_SET_ACCOUNT_POLICY_FN = extern(Windows) HRESULT function(WINBIO_PIPELINE* Pipeline, char* PolicyItemArray, uint PolicyItemCount);
alias PIBIO_ENGINE_CREATE_KEY_FN = extern(Windows) HRESULT function(WINBIO_PIPELINE* Pipeline, char* Key, uint KeySize, char* KeyIdentifier, uint KeyIdentifierSize, uint* ResultSize);
alias PIBIO_ENGINE_IDENTIFY_FEATURE_SET_SECURE_FN = extern(Windows) HRESULT function(WINBIO_PIPELINE* Pipeline, char* Nonce, uint NonceSize, char* KeyIdentifier, uint KeyIdentifierSize, WINBIO_IDENTITY* Identity, ubyte* SubFactor, uint* RejectDetail, ubyte** Authorization, uint* AuthorizationSize);
alias PIBIO_ENGINE_ACCEPT_PRIVATE_SENSOR_TYPE_INFO_FN = extern(Windows) HRESULT function(WINBIO_PIPELINE* Pipeline, char* TypeInfoBufferAddress, uint TypeInfoBufferSize);
alias PIBIO_ENGINE_CREATE_ENROLLMENT_AUTHENTICATED_FN = extern(Windows) HRESULT function(WINBIO_PIPELINE* Pipeline, ubyte** Nonce, uint* NonceSize);
alias PIBIO_ENGINE_IDENTIFY_FEATURE_SET_AUTHENTICATED_FN = extern(Windows) HRESULT function(WINBIO_PIPELINE* Pipeline, char* Nonce, uint NonceSize, WINBIO_IDENTITY* Identity, ubyte* SubFactor, uint* RejectDetail, ubyte** Authentication, uint* AuthenticationSize);
struct WINBIO_ENGINE_INTERFACE
{
    WINBIO_ADAPTER_INTERFACE_VERSION Version;
    uint Type;
    uint Size;
    Guid AdapterId;
    PIBIO_ENGINE_ATTACH_FN Attach;
    PIBIO_ENGINE_DETACH_FN Detach;
    PIBIO_ENGINE_CLEAR_CONTEXT_FN ClearContext;
    PIBIO_ENGINE_QUERY_PREFERRED_FORMAT_FN QueryPreferredFormat;
    PIBIO_ENGINE_QUERY_INDEX_VECTOR_SIZE_FN QueryIndexVectorSize;
    PIBIO_ENGINE_QUERY_HASH_ALGORITHMS_FN QueryHashAlgorithms;
    PIBIO_ENGINE_SET_HASH_ALGORITHM_FN SetHashAlgorithm;
    PIBIO_ENGINE_QUERY_SAMPLE_HINT_FN QuerySampleHint;
    PIBIO_ENGINE_ACCEPT_SAMPLE_DATA_FN AcceptSampleData;
    PIBIO_ENGINE_EXPORT_ENGINE_DATA_FN ExportEngineData;
    PIBIO_ENGINE_VERIFY_FEATURE_SET_FN VerifyFeatureSet;
    PIBIO_ENGINE_IDENTIFY_FEATURE_SET_FN IdentifyFeatureSet;
    PIBIO_ENGINE_CREATE_ENROLLMENT_FN CreateEnrollment;
    PIBIO_ENGINE_UPDATE_ENROLLMENT_FN UpdateEnrollment;
    PIBIO_ENGINE_GET_ENROLLMENT_STATUS_FN GetEnrollmentStatus;
    PIBIO_ENGINE_GET_ENROLLMENT_HASH_FN GetEnrollmentHash;
    PIBIO_ENGINE_CHECK_FOR_DUPLICATE_FN CheckForDuplicate;
    PIBIO_ENGINE_COMMIT_ENROLLMENT_FN CommitEnrollment;
    PIBIO_ENGINE_DISCARD_ENROLLMENT_FN DiscardEnrollment;
    PIBIO_ENGINE_CONTROL_UNIT_FN ControlUnit;
    PIBIO_ENGINE_CONTROL_UNIT_PRIVILEGED_FN ControlUnitPrivileged;
    PIBIO_ENGINE_NOTIFY_POWER_CHANGE_FN NotifyPowerChange;
    PIBIO_ENGINE_RESERVED_1_FN Reserved_1;
    PIBIO_ENGINE_PIPELINE_INIT_FN PipelineInit;
    PIBIO_ENGINE_PIPELINE_CLEANUP_FN PipelineCleanup;
    PIBIO_ENGINE_ACTIVATE_FN Activate;
    PIBIO_ENGINE_DEACTIVATE_FN Deactivate;
    PIBIO_ENGINE_QUERY_EXTENDED_INFO_FN QueryExtendedInfo;
    PIBIO_ENGINE_IDENTIFY_ALL_FN IdentifyAll;
    PIBIO_ENGINE_SET_ENROLLMENT_SELECTOR_FN SetEnrollmentSelector;
    PIBIO_ENGINE_SET_ENROLLMENT_PARAMETERS_FN SetEnrollmentParameters;
    PIBIO_ENGINE_QUERY_EXTENDED_ENROLLMENT_STATUS_FN QueryExtendedEnrollmentStatus;
    PIBIO_ENGINE_REFRESH_CACHE_FN RefreshCache;
    PIBIO_ENGINE_SELECT_CALIBRATION_FORMAT_FN SelectCalibrationFormat;
    PIBIO_ENGINE_QUERY_CALIBRATION_DATA_FN QueryCalibrationData;
    PIBIO_ENGINE_SET_ACCOUNT_POLICY_FN SetAccountPolicy;
    PIBIO_ENGINE_CREATE_KEY_FN CreateKey;
    PIBIO_ENGINE_IDENTIFY_FEATURE_SET_SECURE_FN IdentifyFeatureSetSecure;
    PIBIO_ENGINE_ACCEPT_PRIVATE_SENSOR_TYPE_INFO_FN AcceptPrivateSensorTypeInfo;
    PIBIO_ENGINE_CREATE_ENROLLMENT_AUTHENTICATED_FN CreateEnrollmentAuthenticated;
    PIBIO_ENGINE_IDENTIFY_FEATURE_SET_AUTHENTICATED_FN IdentifyFeatureSetAuthenticated;
}

alias PWINBIO_QUERY_ENGINE_INTERFACE_FN = extern(Windows) HRESULT function(WINBIO_ENGINE_INTERFACE** EngineInterface);
alias PIBIO_STORAGE_ATTACH_FN = extern(Windows) HRESULT function(WINBIO_PIPELINE* Pipeline);
alias PIBIO_STORAGE_DETACH_FN = extern(Windows) HRESULT function(WINBIO_PIPELINE* Pipeline);
alias PIBIO_STORAGE_CLEAR_CONTEXT_FN = extern(Windows) HRESULT function(WINBIO_PIPELINE* Pipeline);
alias PIBIO_STORAGE_CREATE_DATABASE_FN = extern(Windows) HRESULT function(WINBIO_PIPELINE* Pipeline, Guid* DatabaseId, uint Factor, Guid* Format, const(wchar)* FilePath, const(wchar)* ConnectString, uint IndexElementCount, uint InitialSize);
alias PIBIO_STORAGE_ERASE_DATABASE_FN = extern(Windows) HRESULT function(WINBIO_PIPELINE* Pipeline, Guid* DatabaseId, const(wchar)* FilePath, const(wchar)* ConnectString);
alias PIBIO_STORAGE_OPEN_DATABASE_FN = extern(Windows) HRESULT function(WINBIO_PIPELINE* Pipeline, Guid* DatabaseId, const(wchar)* FilePath, const(wchar)* ConnectString);
alias PIBIO_STORAGE_CLOSE_DATABASE_FN = extern(Windows) HRESULT function(WINBIO_PIPELINE* Pipeline);
alias PIBIO_STORAGE_GET_DATA_FORMAT_FN = extern(Windows) HRESULT function(WINBIO_PIPELINE* Pipeline, Guid* Format, WINBIO_VERSION* Version);
alias PIBIO_STORAGE_GET_DATABASE_SIZE_FN = extern(Windows) HRESULT function(WINBIO_PIPELINE* Pipeline, uint* AvailableRecordCount, uint* TotalRecordCount);
alias PIBIO_STORAGE_ADD_RECORD_FN = extern(Windows) HRESULT function(WINBIO_PIPELINE* Pipeline, WINBIO_STORAGE_RECORD* RecordContents);
alias PIBIO_STORAGE_DELETE_RECORD_FN = extern(Windows) HRESULT function(WINBIO_PIPELINE* Pipeline, WINBIO_IDENTITY* Identity, ubyte SubFactor);
alias PIBIO_STORAGE_QUERY_BY_SUBJECT_FN = extern(Windows) HRESULT function(WINBIO_PIPELINE* Pipeline, WINBIO_IDENTITY* Identity, ubyte SubFactor);
alias PIBIO_STORAGE_QUERY_BY_CONTENT_FN = extern(Windows) HRESULT function(WINBIO_PIPELINE* Pipeline, ubyte SubFactor, char* IndexVector, uint IndexElementCount);
alias PIBIO_STORAGE_GET_RECORD_COUNT_FN = extern(Windows) HRESULT function(WINBIO_PIPELINE* Pipeline, uint* RecordCount);
alias PIBIO_STORAGE_FIRST_RECORD_FN = extern(Windows) HRESULT function(WINBIO_PIPELINE* Pipeline);
alias PIBIO_STORAGE_NEXT_RECORD_FN = extern(Windows) HRESULT function(WINBIO_PIPELINE* Pipeline);
alias PIBIO_STORAGE_GET_CURRENT_RECORD_FN = extern(Windows) HRESULT function(WINBIO_PIPELINE* Pipeline, WINBIO_STORAGE_RECORD* RecordContents);
alias PIBIO_STORAGE_CONTROL_UNIT_FN = extern(Windows) HRESULT function(WINBIO_PIPELINE* Pipeline, uint ControlCode, char* SendBuffer, uint SendBufferSize, char* ReceiveBuffer, uint ReceiveBufferSize, uint* ReceiveDataSize, uint* OperationStatus);
alias PIBIO_STORAGE_CONTROL_UNIT_PRIVILEGED_FN = extern(Windows) HRESULT function(WINBIO_PIPELINE* Pipeline, uint ControlCode, char* SendBuffer, uint SendBufferSize, char* ReceiveBuffer, uint ReceiveBufferSize, uint* ReceiveDataSize, uint* OperationStatus);
alias PIBIO_STORAGE_NOTIFY_POWER_CHANGE_FN = extern(Windows) HRESULT function(WINBIO_PIPELINE* Pipeline, uint PowerEventType);
alias PIBIO_STORAGE_PIPELINE_INIT_FN = extern(Windows) HRESULT function(WINBIO_PIPELINE* Pipeline);
alias PIBIO_STORAGE_PIPELINE_CLEANUP_FN = extern(Windows) HRESULT function(WINBIO_PIPELINE* Pipeline);
alias PIBIO_STORAGE_ACTIVATE_FN = extern(Windows) HRESULT function(WINBIO_PIPELINE* Pipeline);
alias PIBIO_STORAGE_DEACTIVATE_FN = extern(Windows) HRESULT function(WINBIO_PIPELINE* Pipeline);
alias PIBIO_STORAGE_QUERY_EXTENDED_INFO_FN = extern(Windows) HRESULT function(WINBIO_PIPELINE* Pipeline, char* StorageInfo, uint StorageInfoSize);
alias PIBIO_STORAGE_NOTIFY_DATABASE_CHANGE_FN = extern(Windows) HRESULT function(WINBIO_PIPELINE* Pipeline, ubyte RecordsAdded);
alias PIBIO_STORAGE_RESERVED_1_FN = extern(Windows) HRESULT function(WINBIO_PIPELINE* Pipeline, WINBIO_IDENTITY* Identity, ulong* Reserved1, ulong* Reserved2);
alias PIBIO_STORAGE_RESERVED_2_FN = extern(Windows) HRESULT function(WINBIO_PIPELINE* Pipeline, WINBIO_IDENTITY* Identity);
alias PIBIO_STORAGE_UPDATE_RECORD_BEGIN_FN = extern(Windows) HRESULT function(WINBIO_PIPELINE* Pipeline, WINBIO_IDENTITY* Identity, ubyte SubFactor, WINBIO_STORAGE_RECORD* RecordContents);
alias PIBIO_STORAGE_UPDATE_RECORD_COMMIT_FN = extern(Windows) HRESULT function(WINBIO_PIPELINE* Pipeline, WINBIO_STORAGE_RECORD* RecordContents);
struct WINBIO_STORAGE_INTERFACE
{
    WINBIO_ADAPTER_INTERFACE_VERSION Version;
    uint Type;
    uint Size;
    Guid AdapterId;
    PIBIO_STORAGE_ATTACH_FN Attach;
    PIBIO_STORAGE_DETACH_FN Detach;
    PIBIO_STORAGE_CLEAR_CONTEXT_FN ClearContext;
    PIBIO_STORAGE_CREATE_DATABASE_FN CreateDatabase;
    PIBIO_STORAGE_ERASE_DATABASE_FN EraseDatabase;
    PIBIO_STORAGE_OPEN_DATABASE_FN OpenDatabase;
    PIBIO_STORAGE_CLOSE_DATABASE_FN CloseDatabase;
    PIBIO_STORAGE_GET_DATA_FORMAT_FN GetDataFormat;
    PIBIO_STORAGE_GET_DATABASE_SIZE_FN GetDatabaseSize;
    PIBIO_STORAGE_ADD_RECORD_FN AddRecord;
    PIBIO_STORAGE_DELETE_RECORD_FN DeleteRecord;
    PIBIO_STORAGE_QUERY_BY_SUBJECT_FN QueryBySubject;
    PIBIO_STORAGE_QUERY_BY_CONTENT_FN QueryByContent;
    PIBIO_STORAGE_GET_RECORD_COUNT_FN GetRecordCount;
    PIBIO_STORAGE_FIRST_RECORD_FN FirstRecord;
    PIBIO_STORAGE_NEXT_RECORD_FN NextRecord;
    PIBIO_STORAGE_GET_CURRENT_RECORD_FN GetCurrentRecord;
    PIBIO_STORAGE_CONTROL_UNIT_FN ControlUnit;
    PIBIO_STORAGE_CONTROL_UNIT_PRIVILEGED_FN ControlUnitPrivileged;
    PIBIO_STORAGE_NOTIFY_POWER_CHANGE_FN NotifyPowerChange;
    PIBIO_STORAGE_PIPELINE_INIT_FN PipelineInit;
    PIBIO_STORAGE_PIPELINE_CLEANUP_FN PipelineCleanup;
    PIBIO_STORAGE_ACTIVATE_FN Activate;
    PIBIO_STORAGE_DEACTIVATE_FN Deactivate;
    PIBIO_STORAGE_QUERY_EXTENDED_INFO_FN QueryExtendedInfo;
    PIBIO_STORAGE_NOTIFY_DATABASE_CHANGE_FN NotifyDatabaseChange;
    PIBIO_STORAGE_RESERVED_1_FN Reserved1;
    PIBIO_STORAGE_RESERVED_2_FN Reserved2;
    PIBIO_STORAGE_UPDATE_RECORD_BEGIN_FN UpdateRecordBegin;
    PIBIO_STORAGE_UPDATE_RECORD_COMMIT_FN UpdateRecordCommit;
}

alias PWINBIO_QUERY_STORAGE_INTERFACE_FN = extern(Windows) HRESULT function(WINBIO_STORAGE_INTERFACE** StorageInterface);
alias PIBIO_FRAMEWORK_SET_UNIT_STATUS_FN = extern(Windows) HRESULT function(WINBIO_PIPELINE* Pipeline, char* ExtendedStatus, uint ExtendedStatusSize);
alias PIBIO_FRAMEWORK_VSM_CACHE_CLEAR_FN = extern(Windows) HRESULT function(WINBIO_PIPELINE* Pipeline);
alias PIBIO_FRAMEWORK_VSM_CACHE_IMPORT_BEGIN_FN = extern(Windows) HRESULT function(WINBIO_PIPELINE* Pipeline, uint RequiredCapacity, uint* MaxBufferSize);
alias PIBIO_FRAMEWORK_VSM_CACHE_IMPORT_NEXT_FN = extern(Windows) HRESULT function(WINBIO_PIPELINE* Pipeline, char* BufferAddress, uint BufferSize);
alias PIBIO_FRAMEWORK_VSM_CACHE_IMPORT_END_FN = extern(Windows) HRESULT function(WINBIO_PIPELINE* Pipeline);
alias PIBIO_FRAMEWORK_VSM_CACHE_EXPORT_BEGIN_FN = extern(Windows) HRESULT function(WINBIO_PIPELINE* Pipeline, uint* RequiredCapacity, uint* MaxBufferSize);
alias PIBIO_FRAMEWORK_VSM_CACHE_EXPORT_NEXT_FN = extern(Windows) HRESULT function(WINBIO_PIPELINE* Pipeline, char* BufferAddress, uint BufferSize, uint* ReturnedDataSize);
alias PIBIO_FRAMEWORK_VSM_CACHE_EXPORT_END_FN = extern(Windows) HRESULT function(WINBIO_PIPELINE* Pipeline);
alias PIBIO_FRAMEWORK_VSM_STORAGE_RESERVED_1_FN = extern(Windows) HRESULT function(WINBIO_PIPELINE* Pipeline, uint Reserved1, uint* Reserved2);
alias PIBIO_FRAMEWORK_VSM_STORAGE_RESERVED_2_FN = extern(Windows) HRESULT function(WINBIO_PIPELINE* Pipeline, ubyte* Reserved1, uint Reserved2);
alias PIBIO_FRAMEWORK_VSM_STORAGE_RESERVED_3_FN = extern(Windows) HRESULT function(WINBIO_PIPELINE* Pipeline);
alias PIBIO_FRAMEWORK_ALLOCATE_MEMORY_FN = extern(Windows) HRESULT function(WINBIO_PIPELINE* Pipeline, uint AllocationSize, void** Address);
alias PIBIO_FRAMEWORK_FREE_MEMORY_FN = extern(Windows) HRESULT function(WINBIO_PIPELINE* Pipeline, void* Address);
alias PIBIO_FRAMEWORK_GET_PROPERTY_FN = extern(Windows) HRESULT function(WINBIO_PIPELINE* Pipeline, uint PropertyType, uint PropertyId, WINBIO_IDENTITY* Identity, ubyte SubFactor, void** PropertyBuffer, uint* PropertyBufferSize);
alias PIBIO_FRAMEWORK_LOCK_AND_VALIDATE_SECURE_BUFFER_FN = extern(Windows) HRESULT function(WINBIO_PIPELINE* Pipeline, Guid SecureBufferIdentifier, void** SecureBufferAddress, uint* SecureBufferSize);
alias PIBIO_FRAMEWORK_RELEASE_SECURE_BUFFER_FN = extern(Windows) HRESULT function(WINBIO_PIPELINE* Pipeline, Guid SecureBufferIdentifier);
alias PIBIO_FRAMEWORK_VSM_QUERY_AUTHORIZED_ENROLLMENTS_FN = extern(Windows) HRESULT function(WINBIO_PIPELINE* Pipeline, WINBIO_IDENTITY* Identity, uint* SecureIdentityCount, WINBIO_IDENTITY** SecureIdentities);
alias PIBIO_FRAMEWORK_VSM_DECRYPT_SAMPLE_FN = extern(Windows) HRESULT function(WINBIO_PIPELINE* Pipeline, char* Authentication, uint AuthenticationSize, char* Iv, uint IvSize, char* EncryptedData, uint EncryptedDataSize);
struct WINBIO_FRAMEWORK_INTERFACE
{
    WINBIO_ADAPTER_INTERFACE_VERSION Version;
    uint Type;
    uint Size;
    Guid AdapterId;
    PIBIO_FRAMEWORK_SET_UNIT_STATUS_FN SetUnitStatus;
    PIBIO_STORAGE_ATTACH_FN VsmStorageAttach;
    PIBIO_STORAGE_DETACH_FN VsmStorageDetach;
    PIBIO_STORAGE_CLEAR_CONTEXT_FN VsmStorageClearContext;
    PIBIO_STORAGE_CREATE_DATABASE_FN VsmStorageCreateDatabase;
    PIBIO_STORAGE_OPEN_DATABASE_FN VsmStorageOpenDatabase;
    PIBIO_STORAGE_CLOSE_DATABASE_FN VsmStorageCloseDatabase;
    PIBIO_STORAGE_DELETE_RECORD_FN VsmStorageDeleteRecord;
    PIBIO_STORAGE_NOTIFY_POWER_CHANGE_FN VsmStorageNotifyPowerChange;
    PIBIO_STORAGE_PIPELINE_INIT_FN VsmStoragePipelineInit;
    PIBIO_STORAGE_PIPELINE_CLEANUP_FN VsmStoragePipelineCleanup;
    PIBIO_STORAGE_ACTIVATE_FN VsmStorageActivate;
    PIBIO_STORAGE_DEACTIVATE_FN VsmStorageDeactivate;
    PIBIO_STORAGE_QUERY_EXTENDED_INFO_FN VsmStorageQueryExtendedInfo;
    PIBIO_FRAMEWORK_VSM_CACHE_CLEAR_FN VsmStorageCacheClear;
    PIBIO_FRAMEWORK_VSM_CACHE_IMPORT_BEGIN_FN VsmStorageCacheImportBegin;
    PIBIO_FRAMEWORK_VSM_CACHE_IMPORT_NEXT_FN VsmStorageCacheImportNext;
    PIBIO_FRAMEWORK_VSM_CACHE_IMPORT_END_FN VsmStorageCacheImportEnd;
    PIBIO_FRAMEWORK_VSM_CACHE_EXPORT_BEGIN_FN VsmStorageCacheExportBegin;
    PIBIO_FRAMEWORK_VSM_CACHE_EXPORT_NEXT_FN VsmStorageCacheExportNext;
    PIBIO_FRAMEWORK_VSM_CACHE_EXPORT_END_FN VsmStorageCacheExportEnd;
    PIBIO_SENSOR_ATTACH_FN VsmSensorAttach;
    PIBIO_SENSOR_DETACH_FN VsmSensorDetach;
    PIBIO_SENSOR_CLEAR_CONTEXT_FN VsmSensorClearContext;
    PIBIO_SENSOR_PUSH_DATA_TO_ENGINE_FN VsmSensorPushDataToEngine;
    PIBIO_SENSOR_NOTIFY_POWER_CHANGE_FN VsmSensorNotifyPowerChange;
    PIBIO_SENSOR_PIPELINE_INIT_FN VsmSensorPipelineInit;
    PIBIO_SENSOR_PIPELINE_CLEANUP_FN VsmSensorPipelineCleanup;
    PIBIO_SENSOR_ACTIVATE_FN VsmSensorActivate;
    PIBIO_SENSOR_DEACTIVATE_FN VsmSensorDeactivate;
    PIBIO_SENSOR_ASYNC_IMPORT_RAW_BUFFER_FN VsmSensorAsyncImportRawBuffer;
    PIBIO_SENSOR_ASYNC_IMPORT_SECURE_BUFFER_FN VsmSensorAsyncImportSecureBuffer;
    PIBIO_FRAMEWORK_VSM_STORAGE_RESERVED_1_FN Reserved1;
    PIBIO_FRAMEWORK_VSM_STORAGE_RESERVED_2_FN Reserved2;
    PIBIO_FRAMEWORK_VSM_STORAGE_RESERVED_3_FN Reserved3;
    PIBIO_STORAGE_RESERVED_1_FN Reserved4;
    PIBIO_STORAGE_RESERVED_2_FN Reserved5;
    PIBIO_FRAMEWORK_ALLOCATE_MEMORY_FN AllocateMemory;
    PIBIO_FRAMEWORK_FREE_MEMORY_FN FreeMemory;
    PIBIO_FRAMEWORK_GET_PROPERTY_FN GetProperty;
    PIBIO_FRAMEWORK_LOCK_AND_VALIDATE_SECURE_BUFFER_FN LockAndValidateSecureBuffer;
    PIBIO_FRAMEWORK_RELEASE_SECURE_BUFFER_FN ReleaseSecureBuffer;
    PIBIO_FRAMEWORK_VSM_QUERY_AUTHORIZED_ENROLLMENTS_FN QueryAuthorizedEnrollments;
    PIBIO_FRAMEWORK_VSM_DECRYPT_SAMPLE_FN DecryptSample;
}

@DllImport("winbio.dll")
HRESULT WinBioEnumServiceProviders(uint Factor, WINBIO_BSP_SCHEMA** BspSchemaArray, uint* BspCount);

@DllImport("winbio.dll")
HRESULT WinBioEnumBiometricUnits(uint Factor, WINBIO_UNIT_SCHEMA** UnitSchemaArray, uint* UnitCount);

@DllImport("winbio.dll")
HRESULT WinBioEnumDatabases(uint Factor, WINBIO_STORAGE_SCHEMA** StorageSchemaArray, uint* StorageCount);

@DllImport("winbio.dll")
HRESULT WinBioAsyncOpenFramework(WINBIO_ASYNC_NOTIFICATION_METHOD NotificationMethod, HWND TargetWindow, uint MessageCode, PWINBIO_ASYNC_COMPLETION_CALLBACK CallbackRoutine, void* UserData, BOOL AsynchronousOpen, uint* FrameworkHandle);

@DllImport("winbio.dll")
HRESULT WinBioCloseFramework(uint FrameworkHandle);

@DllImport("winbio.dll")
HRESULT WinBioAsyncEnumServiceProviders(uint FrameworkHandle, uint Factor);

@DllImport("winbio.dll")
HRESULT WinBioAsyncEnumBiometricUnits(uint FrameworkHandle, uint Factor);

@DllImport("winbio.dll")
HRESULT WinBioAsyncEnumDatabases(uint FrameworkHandle, uint Factor);

@DllImport("winbio.dll")
HRESULT WinBioAsyncMonitorFrameworkChanges(uint FrameworkHandle, uint ChangeTypes);

@DllImport("winbio.dll")
HRESULT WinBioOpenSession(uint Factor, uint PoolType, uint Flags, char* UnitArray, uint UnitCount, Guid* DatabaseId, uint* SessionHandle);

@DllImport("winbio.dll")
HRESULT WinBioAsyncOpenSession(uint Factor, uint PoolType, uint Flags, char* UnitArray, uint UnitCount, Guid* DatabaseId, WINBIO_ASYNC_NOTIFICATION_METHOD NotificationMethod, HWND TargetWindow, uint MessageCode, PWINBIO_ASYNC_COMPLETION_CALLBACK CallbackRoutine, void* UserData, BOOL AsynchronousOpen, uint* SessionHandle);

@DllImport("winbio.dll")
HRESULT WinBioCloseSession(uint SessionHandle);

@DllImport("winbio.dll")
HRESULT WinBioVerify(uint SessionHandle, WINBIO_IDENTITY* Identity, ubyte SubFactor, uint* UnitId, ubyte* Match, uint* RejectDetail);

@DllImport("winbio.dll")
HRESULT WinBioVerifyWithCallback(uint SessionHandle, WINBIO_IDENTITY* Identity, ubyte SubFactor, PWINBIO_VERIFY_CALLBACK VerifyCallback, void* VerifyCallbackContext);

@DllImport("winbio.dll")
HRESULT WinBioIdentify(uint SessionHandle, uint* UnitId, WINBIO_IDENTITY* Identity, ubyte* SubFactor, uint* RejectDetail);

@DllImport("winbio.dll")
HRESULT WinBioIdentifyWithCallback(uint SessionHandle, PWINBIO_IDENTIFY_CALLBACK IdentifyCallback, void* IdentifyCallbackContext);

@DllImport("winbio.dll")
HRESULT WinBioWait(uint SessionHandle);

@DllImport("winbio.dll")
HRESULT WinBioCancel(uint SessionHandle);

@DllImport("winbio.dll")
HRESULT WinBioLocateSensor(uint SessionHandle, uint* UnitId);

@DllImport("winbio.dll")
HRESULT WinBioLocateSensorWithCallback(uint SessionHandle, PWINBIO_LOCATE_SENSOR_CALLBACK LocateCallback, void* LocateCallbackContext);

@DllImport("winbio.dll")
HRESULT WinBioEnrollBegin(uint SessionHandle, ubyte SubFactor, uint UnitId);

@DllImport("winbio.dll")
HRESULT WinBioEnrollSelect(uint SessionHandle, ulong SelectorValue);

@DllImport("winbio.dll")
HRESULT WinBioEnrollCapture(uint SessionHandle, uint* RejectDetail);

@DllImport("winbio.dll")
HRESULT WinBioEnrollCaptureWithCallback(uint SessionHandle, PWINBIO_ENROLL_CAPTURE_CALLBACK EnrollCallback, void* EnrollCallbackContext);

@DllImport("winbio.dll")
HRESULT WinBioEnrollCommit(uint SessionHandle, WINBIO_IDENTITY* Identity, ubyte* IsNewTemplate);

@DllImport("winbio.dll")
HRESULT WinBioEnrollDiscard(uint SessionHandle);

@DllImport("winbio.dll")
HRESULT WinBioEnumEnrollments(uint SessionHandle, uint UnitId, WINBIO_IDENTITY* Identity, ubyte** SubFactorArray, uint* SubFactorCount);

@DllImport("winbio.dll")
HRESULT WinBioRegisterEventMonitor(uint SessionHandle, uint EventMask, PWINBIO_EVENT_CALLBACK EventCallback, void* EventCallbackContext);

@DllImport("winbio.dll")
HRESULT WinBioUnregisterEventMonitor(uint SessionHandle);

@DllImport("winbio.dll")
HRESULT WinBioMonitorPresence(uint SessionHandle, uint UnitId);

@DllImport("winbio.dll")
HRESULT WinBioCaptureSample(uint SessionHandle, ubyte Purpose, ubyte Flags, uint* UnitId, WINBIO_BIR** Sample, uint* SampleSize, uint* RejectDetail);

@DllImport("winbio.dll")
HRESULT WinBioCaptureSampleWithCallback(uint SessionHandle, ubyte Purpose, ubyte Flags, PWINBIO_CAPTURE_CALLBACK CaptureCallback, void* CaptureCallbackContext);

@DllImport("winbio.dll")
HRESULT WinBioDeleteTemplate(uint SessionHandle, uint UnitId, WINBIO_IDENTITY* Identity, ubyte SubFactor);

@DllImport("winbio.dll")
HRESULT WinBioLockUnit(uint SessionHandle, uint UnitId);

@DllImport("winbio.dll")
HRESULT WinBioUnlockUnit(uint SessionHandle, uint UnitId);

@DllImport("winbio.dll")
HRESULT WinBioControlUnit(uint SessionHandle, uint UnitId, uint Component, uint ControlCode, char* SendBuffer, uint SendBufferSize, char* ReceiveBuffer, uint ReceiveBufferSize, uint* ReceiveDataSize, uint* OperationStatus);

@DllImport("winbio.dll")
HRESULT WinBioControlUnitPrivileged(uint SessionHandle, uint UnitId, uint Component, uint ControlCode, char* SendBuffer, uint SendBufferSize, char* ReceiveBuffer, uint ReceiveBufferSize, uint* ReceiveDataSize, uint* OperationStatus);

@DllImport("winbio.dll")
HRESULT WinBioGetProperty(uint SessionHandle, uint PropertyType, uint PropertyId, uint UnitId, WINBIO_IDENTITY* Identity, ubyte SubFactor, void** PropertyBuffer, uint* PropertyBufferSize);

@DllImport("winbio.dll")
HRESULT WinBioSetProperty(uint SessionHandle, uint PropertyType, uint PropertyId, uint UnitId, WINBIO_IDENTITY* Identity, ubyte SubFactor, char* PropertyBuffer, uint PropertyBufferSize);

@DllImport("winbio.dll")
HRESULT WinBioFree(void* Address);

@DllImport("winbio.dll")
HRESULT WinBioSetCredential(WINBIO_CREDENTIAL_TYPE Type, char* Credential, uint CredentialSize, WINBIO_CREDENTIAL_FORMAT Format);

@DllImport("winbio.dll")
HRESULT WinBioRemoveCredential(WINBIO_IDENTITY Identity, WINBIO_CREDENTIAL_TYPE Type);

@DllImport("winbio.dll")
HRESULT WinBioRemoveAllCredentials();

@DllImport("winbio.dll")
HRESULT WinBioRemoveAllDomainCredentials();

@DllImport("winbio.dll")
HRESULT WinBioGetCredentialState(WINBIO_IDENTITY Identity, WINBIO_CREDENTIAL_TYPE Type, WINBIO_CREDENTIAL_STATE* CredentialState);

@DllImport("winbio.dll")
HRESULT WinBioLogonIdentifiedUser(uint SessionHandle);

@DllImport("winbio.dll")
HRESULT WinBioGetEnrolledFactors(WINBIO_IDENTITY* AccountOwner, uint* EnrolledFactors);

@DllImport("winbio.dll")
void WinBioGetEnabledSetting(ubyte* Value, uint* Source);

@DllImport("winbio.dll")
void WinBioGetLogonSetting(ubyte* Value, uint* Source);

@DllImport("winbio.dll")
void WinBioGetDomainLogonSetting(ubyte* Value, uint* Source);

@DllImport("winbio.dll")
HRESULT WinBioAcquireFocus();

@DllImport("winbio.dll")
HRESULT WinBioReleaseFocus();

