module windows.windowsbiometricframework;

public import windows.core;
public import windows.com : HRESULT;
public import windows.displaydevices : POINT, RECT;
public import windows.systemservices : BOOL, HANDLE, LARGE_INTEGER, OVERLAPPED;
public import windows.windowsandmessaging : HWND;

extern(Windows):


// Enums


enum : int
{
    WINBIO_ANTI_SPOOF_DISABLE = 0x00000000,
    WINBIO_ANTI_SPOOF_ENABLE  = 0x00000001,
    WINBIO_ANTI_SPOOF_REMOVE  = 0x00000002,
}
alias WINBIO_ANTI_SPOOF_POLICY_ACTION = int;

enum : int
{
    WINBIO_POLICY_UNKNOWN = 0x00000000,
    WINBIO_POLICY_DEFAULT = 0x00000001,
    WINBIO_POLICY_LOCAL   = 0x00000002,
    WINBIO_POLICY_ADMIN   = 0x00000003,
}
alias WINBIO_POLICY_SOURCE = int;

enum : int
{
    WINBIO_CREDENTIAL_PASSWORD = 0x00000001,
    WINBIO_CREDENTIAL_ALL      = 0xffffffff,
}
alias WINBIO_CREDENTIAL_TYPE = int;

enum : int
{
    WINBIO_PASSWORD_GENERIC   = 0x00000001,
    WINBIO_PASSWORD_PACKED    = 0x00000002,
    WINBIO_PASSWORD_PROTECTED = 0x00000003,
}
alias WINBIO_CREDENTIAL_FORMAT = int;

enum : int
{
    WINBIO_CREDENTIAL_NOT_SET = 0x00000001,
    WINBIO_CREDENTIAL_SET     = 0x00000002,
}
alias WINBIO_CREDENTIAL_STATE = int;

enum : int
{
    WINBIO_ASYNC_NOTIFY_NONE          = 0x00000000,
    WINBIO_ASYNC_NOTIFY_CALLBACK      = 0x00000001,
    WINBIO_ASYNC_NOTIFY_MESSAGE       = 0x00000002,
    WINBIO_ASYNC_NOTIFY_MAXIMUM_VALUE = 0x00000003,
}
alias WINBIO_ASYNC_NOTIFICATION_METHOD = int;

// Callbacks

alias PWINBIO_ASYNC_COMPLETION_CALLBACK = void function(WINBIO_ASYNC_RESULT* AsyncResult);
alias PWINBIO_VERIFY_CALLBACK = void function(void* VerifyCallbackContext, HRESULT OperationStatus, uint UnitId, 
                                              ubyte Match, uint RejectDetail);
alias PWINBIO_IDENTIFY_CALLBACK = void function(void* IdentifyCallbackContext, HRESULT OperationStatus, 
                                                uint UnitId, WINBIO_IDENTITY* Identity, ubyte SubFactor, 
                                                uint RejectDetail);
alias PWINBIO_LOCATE_SENSOR_CALLBACK = void function(void* LocateCallbackContext, HRESULT OperationStatus, 
                                                     uint UnitId);
alias PWINBIO_ENROLL_CAPTURE_CALLBACK = void function(void* EnrollCallbackContext, HRESULT OperationStatus, 
                                                      uint RejectDetail);
alias PWINBIO_EVENT_CALLBACK = void function(void* EventCallbackContext, HRESULT OperationStatus, 
                                             WINBIO_EVENT* Event);
alias PWINBIO_CAPTURE_CALLBACK = void function(void* CaptureCallbackContext, HRESULT OperationStatus, uint UnitId, 
                                               char* Sample, size_t SampleSize, uint RejectDetail);
alias PIBIO_SENSOR_ATTACH_FN = HRESULT function(WINBIO_PIPELINE* Pipeline);
alias PIBIO_SENSOR_DETACH_FN = HRESULT function(WINBIO_PIPELINE* Pipeline);
alias PIBIO_SENSOR_CLEAR_CONTEXT_FN = HRESULT function(WINBIO_PIPELINE* Pipeline);
alias PIBIO_SENSOR_QUERY_STATUS_FN = HRESULT function(WINBIO_PIPELINE* Pipeline, uint* Status);
alias PIBIO_SENSOR_RESET_FN = HRESULT function(WINBIO_PIPELINE* Pipeline);
alias PIBIO_SENSOR_SET_MODE_FN = HRESULT function(WINBIO_PIPELINE* Pipeline, uint Mode);
alias PIBIO_SENSOR_SET_INDICATOR_STATUS_FN = HRESULT function(WINBIO_PIPELINE* Pipeline, uint IndicatorStatus);
alias PIBIO_SENSOR_GET_INDICATOR_STATUS_FN = HRESULT function(WINBIO_PIPELINE* Pipeline, uint* IndicatorStatus);
alias PIBIO_SENSOR_START_CAPTURE_FN = HRESULT function(WINBIO_PIPELINE* Pipeline, ubyte Purpose, 
                                                       OVERLAPPED** Overlapped);
alias PIBIO_SENSOR_FINISH_CAPTURE_FN = HRESULT function(WINBIO_PIPELINE* Pipeline, uint* RejectDetail);
alias PIBIO_SENSOR_EXPORT_SENSOR_DATA_FN = HRESULT function(WINBIO_PIPELINE* Pipeline, WINBIO_BIR** SampleBuffer, 
                                                            size_t* SampleSize);
alias PIBIO_SENSOR_CANCEL_FN = HRESULT function(WINBIO_PIPELINE* Pipeline);
alias PIBIO_SENSOR_PUSH_DATA_TO_ENGINE_FN = HRESULT function(WINBIO_PIPELINE* Pipeline, ubyte Purpose, ubyte Flags, 
                                                             uint* RejectDetail);
alias PIBIO_SENSOR_CONTROL_UNIT_FN = HRESULT function(WINBIO_PIPELINE* Pipeline, uint ControlCode, 
                                                      char* SendBuffer, size_t SendBufferSize, char* ReceiveBuffer, 
                                                      size_t ReceiveBufferSize, size_t* ReceiveDataSize, 
                                                      uint* OperationStatus);
alias PIBIO_SENSOR_CONTROL_UNIT_PRIVILEGED_FN = HRESULT function(WINBIO_PIPELINE* Pipeline, uint ControlCode, 
                                                                 char* SendBuffer, size_t SendBufferSize, 
                                                                 char* ReceiveBuffer, size_t ReceiveBufferSize, 
                                                                 size_t* ReceiveDataSize, uint* OperationStatus);
alias PIBIO_SENSOR_NOTIFY_POWER_CHANGE_FN = HRESULT function(WINBIO_PIPELINE* Pipeline, uint PowerEventType);
alias PIBIO_SENSOR_PIPELINE_INIT_FN = HRESULT function(WINBIO_PIPELINE* Pipeline);
alias PIBIO_SENSOR_PIPELINE_CLEANUP_FN = HRESULT function(WINBIO_PIPELINE* Pipeline);
alias PIBIO_SENSOR_ACTIVATE_FN = HRESULT function(WINBIO_PIPELINE* Pipeline);
alias PIBIO_SENSOR_DEACTIVATE_FN = HRESULT function(WINBIO_PIPELINE* Pipeline);
alias PIBIO_SENSOR_QUERY_EXTENDED_INFO_FN = HRESULT function(WINBIO_PIPELINE* Pipeline, char* SensorInfo, 
                                                             size_t SensorInfoSize);
alias PIBIO_SENSOR_QUERY_CALIBRATION_FORMATS_FN = HRESULT function(WINBIO_PIPELINE* Pipeline, char* FormatArray, 
                                                                   size_t FormatArraySize, size_t* FormatCount);
alias PIBIO_SENSOR_SET_CALIBRATION_FORMAT_FN = HRESULT function(WINBIO_PIPELINE* Pipeline, GUID* Format);
alias PIBIO_SENSOR_ACCEPT_CALIBRATION_DATA_FN = HRESULT function(WINBIO_PIPELINE* Pipeline, 
                                                                 char* CalibrationBuffer, 
                                                                 size_t CalibrationBufferSize);
alias PIBIO_SENSOR_ASYNC_IMPORT_RAW_BUFFER_FN = HRESULT function(WINBIO_PIPELINE* Pipeline, char* RawBufferAddress, 
                                                                 size_t RawBufferSize, ubyte** ResultBufferAddress, 
                                                                 size_t* ResultBufferSize);
alias PIBIO_SENSOR_ASYNC_IMPORT_SECURE_BUFFER_FN = HRESULT function(WINBIO_PIPELINE* Pipeline, 
                                                                    GUID SecureBufferIdentifier, 
                                                                    char* MetadataBufferAddress, 
                                                                    size_t MetadataBufferSize, 
                                                                    ubyte** ResultBufferAddress, 
                                                                    size_t* ResultBufferSize);
alias PIBIO_SENSOR_QUERY_PRIVATE_SENSOR_TYPE_FN = HRESULT function(WINBIO_PIPELINE* Pipeline, 
                                                                   char* TypeInfoBufferAddress, 
                                                                   size_t TypeInfoBufferSize, 
                                                                   size_t* TypeInfoDataSize);
alias PIBIO_SENSOR_CONNECT_SECURE_FN = HRESULT function(WINBIO_PIPELINE* Pipeline, 
                                                        const(WINBIO_SECURE_CONNECTION_PARAMS)* ConnectionParams, 
                                                        WINBIO_SECURE_CONNECTION_DATA** ConnectionData);
alias PIBIO_SENSOR_START_CAPTURE_EX_FN = HRESULT function(WINBIO_PIPELINE* Pipeline, ubyte Purpose, char* Nonce, 
                                                          size_t NonceSize, ubyte Flags, OVERLAPPED** Overlapped);
alias PIBIO_SENSOR_START_NOTIFY_WAKE_FN = HRESULT function(WINBIO_PIPELINE* Pipeline, OVERLAPPED** Overlapped);
alias PIBIO_SENSOR_FINISH_NOTIFY_WAKE_FN = HRESULT function(WINBIO_PIPELINE* Pipeline, uint* Reason);
alias PWINBIO_QUERY_SENSOR_INTERFACE_FN = HRESULT function(WINBIO_SENSOR_INTERFACE** SensorInterface);
alias PIBIO_ENGINE_ATTACH_FN = HRESULT function(WINBIO_PIPELINE* Pipeline);
alias PIBIO_ENGINE_DETACH_FN = HRESULT function(WINBIO_PIPELINE* Pipeline);
alias PIBIO_ENGINE_CLEAR_CONTEXT_FN = HRESULT function(WINBIO_PIPELINE* Pipeline);
alias PIBIO_ENGINE_QUERY_PREFERRED_FORMAT_FN = HRESULT function(WINBIO_PIPELINE* Pipeline, 
                                                                WINBIO_REGISTERED_FORMAT* StandardFormat, 
                                                                GUID* VendorFormat);
alias PIBIO_ENGINE_QUERY_INDEX_VECTOR_SIZE_FN = HRESULT function(WINBIO_PIPELINE* Pipeline, 
                                                                 size_t* IndexElementCount);
alias PIBIO_ENGINE_QUERY_HASH_ALGORITHMS_FN = HRESULT function(WINBIO_PIPELINE* Pipeline, size_t* AlgorithmCount, 
                                                               size_t* AlgorithmBufferSize, char* AlgorithmBuffer);
alias PIBIO_ENGINE_SET_HASH_ALGORITHM_FN = HRESULT function(WINBIO_PIPELINE* Pipeline, size_t AlgorithmBufferSize, 
                                                            char* AlgorithmBuffer);
alias PIBIO_ENGINE_QUERY_SAMPLE_HINT_FN = HRESULT function(WINBIO_PIPELINE* Pipeline, size_t* SampleHint);
alias PIBIO_ENGINE_ACCEPT_SAMPLE_DATA_FN = HRESULT function(WINBIO_PIPELINE* Pipeline, char* SampleBuffer, 
                                                            size_t SampleSize, ubyte Purpose, uint* RejectDetail);
alias PIBIO_ENGINE_EXPORT_ENGINE_DATA_FN = HRESULT function(WINBIO_PIPELINE* Pipeline, ubyte Flags, 
                                                            char* SampleBuffer, size_t* SampleSize);
alias PIBIO_ENGINE_VERIFY_FEATURE_SET_FN = HRESULT function(WINBIO_PIPELINE* Pipeline, WINBIO_IDENTITY* Identity, 
                                                            ubyte SubFactor, ubyte* Match, char* PayloadBlob, 
                                                            size_t* PayloadBlobSize, char* HashValue, 
                                                            size_t* HashSize, uint* RejectDetail);
alias PIBIO_ENGINE_IDENTIFY_FEATURE_SET_FN = HRESULT function(WINBIO_PIPELINE* Pipeline, WINBIO_IDENTITY* Identity, 
                                                              ubyte* SubFactor, char* PayloadBlob, 
                                                              size_t* PayloadBlobSize, char* HashValue, 
                                                              size_t* HashSize, uint* RejectDetail);
alias PIBIO_ENGINE_CREATE_ENROLLMENT_FN = HRESULT function(WINBIO_PIPELINE* Pipeline);
alias PIBIO_ENGINE_UPDATE_ENROLLMENT_FN = HRESULT function(WINBIO_PIPELINE* Pipeline, uint* RejectDetail);
alias PIBIO_ENGINE_GET_ENROLLMENT_STATUS_FN = HRESULT function(WINBIO_PIPELINE* Pipeline, uint* RejectDetail);
alias PIBIO_ENGINE_GET_ENROLLMENT_HASH_FN = HRESULT function(WINBIO_PIPELINE* Pipeline, char* HashValue, 
                                                             size_t* HashSize);
alias PIBIO_ENGINE_CHECK_FOR_DUPLICATE_FN = HRESULT function(WINBIO_PIPELINE* Pipeline, WINBIO_IDENTITY* Identity, 
                                                             ubyte* SubFactor, ubyte* Duplicate);
alias PIBIO_ENGINE_COMMIT_ENROLLMENT_FN = HRESULT function(WINBIO_PIPELINE* Pipeline, WINBIO_IDENTITY* Identity, 
                                                           ubyte SubFactor, char* PayloadBlob, 
                                                           size_t PayloadBlobSize);
alias PIBIO_ENGINE_DISCARD_ENROLLMENT_FN = HRESULT function(WINBIO_PIPELINE* Pipeline);
alias PIBIO_ENGINE_CONTROL_UNIT_FN = HRESULT function(WINBIO_PIPELINE* Pipeline, uint ControlCode, 
                                                      char* SendBuffer, size_t SendBufferSize, char* ReceiveBuffer, 
                                                      size_t ReceiveBufferSize, size_t* ReceiveDataSize, 
                                                      uint* OperationStatus);
alias PIBIO_ENGINE_CONTROL_UNIT_PRIVILEGED_FN = HRESULT function(WINBIO_PIPELINE* Pipeline, uint ControlCode, 
                                                                 char* SendBuffer, size_t SendBufferSize, 
                                                                 char* ReceiveBuffer, size_t ReceiveBufferSize, 
                                                                 size_t* ReceiveDataSize, uint* OperationStatus);
alias PIBIO_ENGINE_NOTIFY_POWER_CHANGE_FN = HRESULT function(WINBIO_PIPELINE* Pipeline, uint PowerEventType);
alias PIBIO_ENGINE_RESERVED_1_FN = HRESULT function(WINBIO_PIPELINE* Pipeline, WINBIO_IDENTITY* Identity);
alias PIBIO_ENGINE_PIPELINE_INIT_FN = HRESULT function(WINBIO_PIPELINE* Pipeline);
alias PIBIO_ENGINE_PIPELINE_CLEANUP_FN = HRESULT function(WINBIO_PIPELINE* Pipeline);
alias PIBIO_ENGINE_ACTIVATE_FN = HRESULT function(WINBIO_PIPELINE* Pipeline);
alias PIBIO_ENGINE_DEACTIVATE_FN = HRESULT function(WINBIO_PIPELINE* Pipeline);
alias PIBIO_ENGINE_QUERY_EXTENDED_INFO_FN = HRESULT function(WINBIO_PIPELINE* Pipeline, char* EngineInfo, 
                                                             size_t EngineInfoSize);
alias PIBIO_ENGINE_IDENTIFY_ALL_FN = HRESULT function(WINBIO_PIPELINE* Pipeline, size_t* PresenceCount, 
                                                      WINBIO_PRESENCE** PresenceArray);
alias PIBIO_ENGINE_SET_ENROLLMENT_SELECTOR_FN = HRESULT function(WINBIO_PIPELINE* Pipeline, ulong SelectorValue);
alias PIBIO_ENGINE_SET_ENROLLMENT_PARAMETERS_FN = HRESULT function(WINBIO_PIPELINE* Pipeline, 
                                                                   WINBIO_EXTENDED_ENROLLMENT_PARAMETERS* Parameters);
alias PIBIO_ENGINE_QUERY_EXTENDED_ENROLLMENT_STATUS_FN = HRESULT function(WINBIO_PIPELINE* Pipeline, 
                                                                          char* EnrollmentStatus, 
                                                                          size_t EnrollmentStatusSize);
alias PIBIO_ENGINE_REFRESH_CACHE_FN = HRESULT function(WINBIO_PIPELINE* Pipeline);
alias PIBIO_ENGINE_SELECT_CALIBRATION_FORMAT_FN = HRESULT function(WINBIO_PIPELINE* Pipeline, char* FormatArray, 
                                                                   size_t FormatCount, GUID* SelectedFormat, 
                                                                   size_t* MaxBufferSize);
alias PIBIO_ENGINE_QUERY_CALIBRATION_DATA_FN = HRESULT function(WINBIO_PIPELINE* Pipeline, 
                                                                ubyte* DiscardAndRepeatCapture, 
                                                                char* CalibrationBuffer, 
                                                                size_t* CalibrationBufferSize, size_t MaxBufferSize);
alias PIBIO_ENGINE_SET_ACCOUNT_POLICY_FN = HRESULT function(WINBIO_PIPELINE* Pipeline, char* PolicyItemArray, 
                                                            size_t PolicyItemCount);
alias PIBIO_ENGINE_CREATE_KEY_FN = HRESULT function(WINBIO_PIPELINE* Pipeline, char* Key, size_t KeySize, 
                                                    char* KeyIdentifier, size_t KeyIdentifierSize, 
                                                    size_t* ResultSize);
alias PIBIO_ENGINE_IDENTIFY_FEATURE_SET_SECURE_FN = HRESULT function(WINBIO_PIPELINE* Pipeline, char* Nonce, 
                                                                     size_t NonceSize, char* KeyIdentifier, 
                                                                     size_t KeyIdentifierSize, 
                                                                     WINBIO_IDENTITY* Identity, ubyte* SubFactor, 
                                                                     uint* RejectDetail, ubyte** Authorization, 
                                                                     size_t* AuthorizationSize);
alias PIBIO_ENGINE_ACCEPT_PRIVATE_SENSOR_TYPE_INFO_FN = HRESULT function(WINBIO_PIPELINE* Pipeline, 
                                                                         char* TypeInfoBufferAddress, 
                                                                         size_t TypeInfoBufferSize);
alias PIBIO_ENGINE_CREATE_ENROLLMENT_AUTHENTICATED_FN = HRESULT function(WINBIO_PIPELINE* Pipeline, ubyte** Nonce, 
                                                                         size_t* NonceSize);
alias PIBIO_ENGINE_IDENTIFY_FEATURE_SET_AUTHENTICATED_FN = HRESULT function(WINBIO_PIPELINE* Pipeline, char* Nonce, 
                                                                            size_t NonceSize, 
                                                                            WINBIO_IDENTITY* Identity, 
                                                                            ubyte* SubFactor, uint* RejectDetail, 
                                                                            ubyte** Authentication, 
                                                                            size_t* AuthenticationSize);
alias PWINBIO_QUERY_ENGINE_INTERFACE_FN = HRESULT function(WINBIO_ENGINE_INTERFACE** EngineInterface);
alias PIBIO_STORAGE_ATTACH_FN = HRESULT function(WINBIO_PIPELINE* Pipeline);
alias PIBIO_STORAGE_DETACH_FN = HRESULT function(WINBIO_PIPELINE* Pipeline);
alias PIBIO_STORAGE_CLEAR_CONTEXT_FN = HRESULT function(WINBIO_PIPELINE* Pipeline);
alias PIBIO_STORAGE_CREATE_DATABASE_FN = HRESULT function(WINBIO_PIPELINE* Pipeline, GUID* DatabaseId, uint Factor, 
                                                          GUID* Format, const(wchar)* FilePath, 
                                                          const(wchar)* ConnectString, size_t IndexElementCount, 
                                                          size_t InitialSize);
alias PIBIO_STORAGE_ERASE_DATABASE_FN = HRESULT function(WINBIO_PIPELINE* Pipeline, GUID* DatabaseId, 
                                                         const(wchar)* FilePath, const(wchar)* ConnectString);
alias PIBIO_STORAGE_OPEN_DATABASE_FN = HRESULT function(WINBIO_PIPELINE* Pipeline, GUID* DatabaseId, 
                                                        const(wchar)* FilePath, const(wchar)* ConnectString);
alias PIBIO_STORAGE_CLOSE_DATABASE_FN = HRESULT function(WINBIO_PIPELINE* Pipeline);
alias PIBIO_STORAGE_GET_DATA_FORMAT_FN = HRESULT function(WINBIO_PIPELINE* Pipeline, GUID* Format, 
                                                          WINBIO_VERSION* Version);
alias PIBIO_STORAGE_GET_DATABASE_SIZE_FN = HRESULT function(WINBIO_PIPELINE* Pipeline, 
                                                            size_t* AvailableRecordCount, size_t* TotalRecordCount);
alias PIBIO_STORAGE_ADD_RECORD_FN = HRESULT function(WINBIO_PIPELINE* Pipeline, 
                                                     WINBIO_STORAGE_RECORD* RecordContents);
alias PIBIO_STORAGE_DELETE_RECORD_FN = HRESULT function(WINBIO_PIPELINE* Pipeline, WINBIO_IDENTITY* Identity, 
                                                        ubyte SubFactor);
alias PIBIO_STORAGE_QUERY_BY_SUBJECT_FN = HRESULT function(WINBIO_PIPELINE* Pipeline, WINBIO_IDENTITY* Identity, 
                                                           ubyte SubFactor);
alias PIBIO_STORAGE_QUERY_BY_CONTENT_FN = HRESULT function(WINBIO_PIPELINE* Pipeline, ubyte SubFactor, 
                                                           char* IndexVector, size_t IndexElementCount);
alias PIBIO_STORAGE_GET_RECORD_COUNT_FN = HRESULT function(WINBIO_PIPELINE* Pipeline, size_t* RecordCount);
alias PIBIO_STORAGE_FIRST_RECORD_FN = HRESULT function(WINBIO_PIPELINE* Pipeline);
alias PIBIO_STORAGE_NEXT_RECORD_FN = HRESULT function(WINBIO_PIPELINE* Pipeline);
alias PIBIO_STORAGE_GET_CURRENT_RECORD_FN = HRESULT function(WINBIO_PIPELINE* Pipeline, 
                                                             WINBIO_STORAGE_RECORD* RecordContents);
alias PIBIO_STORAGE_CONTROL_UNIT_FN = HRESULT function(WINBIO_PIPELINE* Pipeline, uint ControlCode, 
                                                       char* SendBuffer, size_t SendBufferSize, char* ReceiveBuffer, 
                                                       size_t ReceiveBufferSize, size_t* ReceiveDataSize, 
                                                       uint* OperationStatus);
alias PIBIO_STORAGE_CONTROL_UNIT_PRIVILEGED_FN = HRESULT function(WINBIO_PIPELINE* Pipeline, uint ControlCode, 
                                                                  char* SendBuffer, size_t SendBufferSize, 
                                                                  char* ReceiveBuffer, size_t ReceiveBufferSize, 
                                                                  size_t* ReceiveDataSize, uint* OperationStatus);
alias PIBIO_STORAGE_NOTIFY_POWER_CHANGE_FN = HRESULT function(WINBIO_PIPELINE* Pipeline, uint PowerEventType);
alias PIBIO_STORAGE_PIPELINE_INIT_FN = HRESULT function(WINBIO_PIPELINE* Pipeline);
alias PIBIO_STORAGE_PIPELINE_CLEANUP_FN = HRESULT function(WINBIO_PIPELINE* Pipeline);
alias PIBIO_STORAGE_ACTIVATE_FN = HRESULT function(WINBIO_PIPELINE* Pipeline);
alias PIBIO_STORAGE_DEACTIVATE_FN = HRESULT function(WINBIO_PIPELINE* Pipeline);
alias PIBIO_STORAGE_QUERY_EXTENDED_INFO_FN = HRESULT function(WINBIO_PIPELINE* Pipeline, char* StorageInfo, 
                                                              size_t StorageInfoSize);
alias PIBIO_STORAGE_NOTIFY_DATABASE_CHANGE_FN = HRESULT function(WINBIO_PIPELINE* Pipeline, ubyte RecordsAdded);
alias PIBIO_STORAGE_RESERVED_1_FN = HRESULT function(WINBIO_PIPELINE* Pipeline, WINBIO_IDENTITY* Identity, 
                                                     ulong* Reserved1, ulong* Reserved2);
alias PIBIO_STORAGE_RESERVED_2_FN = HRESULT function(WINBIO_PIPELINE* Pipeline, WINBIO_IDENTITY* Identity);
alias PIBIO_STORAGE_UPDATE_RECORD_BEGIN_FN = HRESULT function(WINBIO_PIPELINE* Pipeline, WINBIO_IDENTITY* Identity, 
                                                              ubyte SubFactor, WINBIO_STORAGE_RECORD* RecordContents);
alias PIBIO_STORAGE_UPDATE_RECORD_COMMIT_FN = HRESULT function(WINBIO_PIPELINE* Pipeline, 
                                                               WINBIO_STORAGE_RECORD* RecordContents);
alias PWINBIO_QUERY_STORAGE_INTERFACE_FN = HRESULT function(WINBIO_STORAGE_INTERFACE** StorageInterface);
alias PIBIO_FRAMEWORK_SET_UNIT_STATUS_FN = HRESULT function(WINBIO_PIPELINE* Pipeline, char* ExtendedStatus, 
                                                            size_t ExtendedStatusSize);
alias PIBIO_FRAMEWORK_VSM_CACHE_CLEAR_FN = HRESULT function(WINBIO_PIPELINE* Pipeline);
alias PIBIO_FRAMEWORK_VSM_CACHE_IMPORT_BEGIN_FN = HRESULT function(WINBIO_PIPELINE* Pipeline, 
                                                                   size_t RequiredCapacity, size_t* MaxBufferSize);
alias PIBIO_FRAMEWORK_VSM_CACHE_IMPORT_NEXT_FN = HRESULT function(WINBIO_PIPELINE* Pipeline, char* BufferAddress, 
                                                                  size_t BufferSize);
alias PIBIO_FRAMEWORK_VSM_CACHE_IMPORT_END_FN = HRESULT function(WINBIO_PIPELINE* Pipeline);
alias PIBIO_FRAMEWORK_VSM_CACHE_EXPORT_BEGIN_FN = HRESULT function(WINBIO_PIPELINE* Pipeline, 
                                                                   size_t* RequiredCapacity, size_t* MaxBufferSize);
alias PIBIO_FRAMEWORK_VSM_CACHE_EXPORT_NEXT_FN = HRESULT function(WINBIO_PIPELINE* Pipeline, char* BufferAddress, 
                                                                  size_t BufferSize, size_t* ReturnedDataSize);
alias PIBIO_FRAMEWORK_VSM_CACHE_EXPORT_END_FN = HRESULT function(WINBIO_PIPELINE* Pipeline);
alias PIBIO_FRAMEWORK_VSM_STORAGE_RESERVED_1_FN = HRESULT function(WINBIO_PIPELINE* Pipeline, size_t Reserved1, 
                                                                   size_t* Reserved2);
alias PIBIO_FRAMEWORK_VSM_STORAGE_RESERVED_2_FN = HRESULT function(WINBIO_PIPELINE* Pipeline, ubyte* Reserved1, 
                                                                   size_t Reserved2);
alias PIBIO_FRAMEWORK_VSM_STORAGE_RESERVED_3_FN = HRESULT function(WINBIO_PIPELINE* Pipeline);
alias PIBIO_FRAMEWORK_ALLOCATE_MEMORY_FN = HRESULT function(WINBIO_PIPELINE* Pipeline, size_t AllocationSize, 
                                                            void** Address);
alias PIBIO_FRAMEWORK_FREE_MEMORY_FN = HRESULT function(WINBIO_PIPELINE* Pipeline, void* Address);
alias PIBIO_FRAMEWORK_GET_PROPERTY_FN = HRESULT function(WINBIO_PIPELINE* Pipeline, uint PropertyType, 
                                                         uint PropertyId, WINBIO_IDENTITY* Identity, ubyte SubFactor, 
                                                         void** PropertyBuffer, size_t* PropertyBufferSize);
alias PIBIO_FRAMEWORK_LOCK_AND_VALIDATE_SECURE_BUFFER_FN = HRESULT function(WINBIO_PIPELINE* Pipeline, 
                                                                            GUID SecureBufferIdentifier, 
                                                                            void** SecureBufferAddress, 
                                                                            size_t* SecureBufferSize);
alias PIBIO_FRAMEWORK_RELEASE_SECURE_BUFFER_FN = HRESULT function(WINBIO_PIPELINE* Pipeline, 
                                                                  GUID SecureBufferIdentifier);
alias PIBIO_FRAMEWORK_VSM_QUERY_AUTHORIZED_ENROLLMENTS_FN = HRESULT function(WINBIO_PIPELINE* Pipeline, 
                                                                             WINBIO_IDENTITY* Identity, 
                                                                             size_t* SecureIdentityCount, 
                                                                             WINBIO_IDENTITY** SecureIdentities);
alias PIBIO_FRAMEWORK_VSM_DECRYPT_SAMPLE_FN = HRESULT function(WINBIO_PIPELINE* Pipeline, char* Authentication, 
                                                               size_t AuthenticationSize, char* Iv, size_t IvSize, 
                                                               char* EncryptedData, size_t EncryptedDataSize);

// Structs


struct WINBIO_VERSION
{
    uint MajorVersion;
    uint MinorVersion;
}

struct WINBIO_IDENTITY
{
    uint Type;
    union Value
    {
        uint      Null;
        uint      Wildcard;
        GUID      TemplateGuid;
        struct AccountSid
        {
            uint      Size;
            ubyte[68] Data;
        }
        ubyte[32] SecureId;
    }
}

struct WINBIO_SECURE_CONNECTION_PARAMS
{
    uint   PayloadSize;
    ushort Version;
    ushort Flags;
}

struct WINBIO_SECURE_CONNECTION_DATA
{
    uint   Size;
    ushort Version;
    ushort Flags;
    uint   ModelCertificateSize;
    uint   IntermediateCA1Size;
    uint   IntermediateCA2Size;
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
    ushort        ValidFields;
    ubyte         HeaderVersion;
    ubyte         PatronHeaderVersion;
    ubyte         DataFlags;
    uint          Type;
    ubyte         Subtype;
    ubyte         Purpose;
    byte          DataQuality;
    LARGE_INTEGER CreationDate;
    struct ValidityPeriod
    {
        LARGE_INTEGER BeginDate;
        LARGE_INTEGER EndDate;
    }
    WINBIO_REGISTERED_FORMAT BiometricDataFormat;
    WINBIO_REGISTERED_FORMAT ProductId;
}

struct WINBIO_BDB_ANSI_381_HEADER
{
    ulong  RecordLength;
    uint   FormatIdentifier;
    uint   VersionNumber;
    WINBIO_REGISTERED_FORMAT ProductId;
    ushort CaptureDeviceId;
    ushort ImageAcquisitionLevel;
    ushort HorizontalScanResolution;
    ushort VerticalScanResolution;
    ushort HorizontalImageResolution;
    ushort VerticalImageResolution;
    ubyte  ElementCount;
    ubyte  ScaleUnits;
    ubyte  PixelDepth;
    ubyte  ImageCompressionAlg;
    ushort Reserved;
}

struct WINBIO_BDB_ANSI_381_RECORD
{
    uint   BlockLength;
    ushort HorizontalLineLength;
    ushort VerticalLineLength;
    ubyte  Position;
    ubyte  CountOfViews;
    ubyte  ViewNumber;
    ubyte  ImageQuality;
    ubyte  ImpressionType;
    ubyte  Reserved;
}

struct WINBIO_SECURE_BUFFER_HEADER_V1
{
    uint  Type;
    uint  Size;
    uint  Flags;
    ulong ValidationTag;
}

struct WINBIO_EVENT
{
    uint Type;
    union Parameters
    {
        struct Unclaimed
        {
            uint UnitId;
            uint RejectDetail;
        }
        struct UnclaimedIdentify
        {
            uint            UnitId;
            WINBIO_IDENTITY Identity;
            ubyte           SubFactor;
            uint            RejectDetail;
        }
        struct Error
        {
            HRESULT ErrorCode;
        }
    }
}

union WINBIO_PRESENCE_PROPERTIES
{
    struct FacialFeatures
    {
        RECT BoundingBox;
        int  Distance;
        struct OpaqueEngineData
        {
            GUID     AdapterId;
            uint[77] Data;
        }
    }
    struct Iris
    {
        RECT  EyeBoundingBox_1;
        RECT  EyeBoundingBox_2;
        POINT PupilCenter_1;
        POINT PupilCenter_2;
        int   Distance;
    }
}

struct WINBIO_PRESENCE
{
    uint            Factor;
    ubyte           SubFactor;
    HRESULT         Status;
    uint            RejectDetail;
    WINBIO_IDENTITY Identity;
    ulong           TrackingId;
    ulong           Ticket;
    WINBIO_PRESENCE_PROPERTIES Properties;
    struct Authorization
    {
        uint      Size;
        ubyte[32] Data;
    }
}

struct WINBIO_BSP_SCHEMA
{
    uint           BiometricFactor;
    GUID           BspId;
    ushort[256]    Description;
    ushort[256]    Vendor;
    WINBIO_VERSION Version;
}

struct WINBIO_UNIT_SCHEMA
{
    uint           UnitId;
    uint           PoolType;
    uint           BiometricFactor;
    uint           SensorSubType;
    uint           Capabilities;
    ushort[256]    DeviceInstanceId;
    ushort[256]    Description;
    ushort[256]    Manufacturer;
    ushort[256]    Model;
    ushort[256]    SerialNumber;
    WINBIO_VERSION FirmwareVersion;
}

struct WINBIO_STORAGE_SCHEMA
{
    uint        BiometricFactor;
    GUID        DatabaseId;
    GUID        DataFormat;
    uint        Attributes;
    ushort[256] FilePath;
    ushort[256] ConnectionString;
}

struct WINBIO_EXTENDED_SENSOR_INFO
{
    uint GenericSensorCapabilities;
    uint Factor;
    union Specific
    {
        uint Null;
        struct FacialFeatures
        {
            RECT  FrameSize;
            POINT FrameOffset;
            uint  MandatoryOrientation;
            struct HardwareInfo
            {
                ushort[260] ColorSensorId;
                ushort[260] InfraredSensorId;
                uint        InfraredSensorRotationAngle;
            }
        }
        struct Fingerprint
        {
            uint Reserved;
        }
        struct Iris
        {
            RECT  FrameSize;
            POINT FrameOffset;
            uint  MandatoryOrientation;
        }
        struct Voice
        {
            uint Reserved;
        }
    }
}

struct WINBIO_EXTENDED_ENGINE_INFO
{
    uint GenericEngineCapabilities;
    uint Factor;
    union Specific
    {
        uint Null;
        struct FacialFeatures
        {
            uint Capabilities;
            struct EnrollmentRequirements
            {
                uint Null;
            }
        }
        struct Fingerprint
        {
            uint Capabilities;
            struct EnrollmentRequirements
            {
                uint GeneralSamples;
                uint Center;
                uint TopEdge;
                uint BottomEdge;
                uint LeftEdge;
                uint RightEdge;
            }
        }
        struct Iris
        {
            uint Capabilities;
            struct EnrollmentRequirements
            {
                uint Null;
            }
        }
        struct Voice
        {
            uint Capabilities;
            struct EnrollmentRequirements
            {
                uint Null;
            }
        }
    }
}

struct WINBIO_EXTENDED_STORAGE_INFO
{
    uint GenericStorageCapabilities;
    uint Factor;
    union Specific
    {
        uint Null;
        struct FacialFeatures
        {
            uint Capabilities;
        }
        struct Fingerprint
        {
            uint Capabilities;
        }
        struct Iris
        {
            uint Capabilities;
        }
        struct Voice
        {
            uint Capabilities;
        }
    }
}

struct WINBIO_EXTENDED_ENROLLMENT_STATUS
{
    HRESULT TemplateStatus;
    uint    RejectDetail;
    uint    PercentComplete;
    uint    Factor;
    ubyte   SubFactor;
    union Specific
    {
        uint Null;
        struct FacialFeatures
        {
            RECT BoundingBox;
            int  Distance;
            struct OpaqueEngineData
            {
                GUID     AdapterId;
                uint[77] Data;
            }
        }
        struct Fingerprint
        {
            uint GeneralSamples;
            uint Center;
            uint TopEdge;
            uint BottomEdge;
            uint LeftEdge;
            uint RightEdge;
        }
        struct Iris
        {
            RECT   EyeBoundingBox_1;
            RECT   EyeBoundingBox_2;
            POINT  PupilCenter_1;
            POINT  PupilCenter_2;
            int    Distance;
            uint   GridPointCompletionPercent;
            ushort GridPointIndex;
            struct Point3D
            {
                double X;
                double Y;
                double Z;
            }
            BOOL   StopCaptureAndShowCriticalFeedback;
        }
        struct Voice
        {
            uint Reserved;
        }
    }
}

struct WINBIO_EXTENDED_UNIT_STATUS
{
    uint Availability;
    uint ReasonCode;
}

struct WINBIO_FP_BU_STATE
{
    BOOL    SensorAttached;
    HRESULT CreationResult;
}

struct WINBIO_ANTI_SPOOF_POLICY
{
    WINBIO_ANTI_SPOOF_POLICY_ACTION Action;
    WINBIO_POLICY_SOURCE Source;
}

struct WINBIO_EXTENDED_ENROLLMENT_PARAMETERS
{
    size_t Size;
    ubyte  SubFactor;
}

struct WINBIO_ACCOUNT_POLICY
{
    WINBIO_IDENTITY Identity;
    WINBIO_ANTI_SPOOF_POLICY_ACTION AntiSpoofBehavior;
}

struct WINBIO_PROTECTION_POLICY
{
    uint            Version;
    WINBIO_IDENTITY Identity;
    GUID            DatabaseId;
    ulong           UserState;
    size_t          PolicySize;
    ubyte[128]      Policy;
}

struct WINBIO_GESTURE_METADATA
{
    size_t Size;
    uint   BiometricType;
    uint   MatchType;
    uint   ProtectionType;
}

struct WINBIO_ASYNC_RESULT
{
    uint    SessionHandle;
    uint    Operation;
    ulong   SequenceNumber;
    long    TimeStamp;
    HRESULT ApiStatus;
    uint    UnitId;
    void*   UserData;
    union Parameters
    {
        struct Verify
        {
            ubyte Match;
            uint  RejectDetail;
        }
        struct Identify
        {
            WINBIO_IDENTITY Identity;
            ubyte           SubFactor;
            uint            RejectDetail;
        }
        struct EnrollBegin
        {
            ubyte SubFactor;
        }
        struct EnrollCapture
        {
            uint RejectDetail;
        }
        struct EnrollCommit
        {
            WINBIO_IDENTITY Identity;
            ubyte           IsNewTemplate;
        }
        struct EnumEnrollments
        {
            WINBIO_IDENTITY Identity;
            size_t          SubFactorCount;
            ubyte*          SubFactorArray;
        }
        struct CaptureSample
        {
            WINBIO_BIR* Sample;
            size_t      SampleSize;
            uint        RejectDetail;
        }
        struct DeleteTemplate
        {
            WINBIO_IDENTITY Identity;
            ubyte           SubFactor;
        }
        struct GetProperty
        {
            uint            PropertyType;
            uint            PropertyId;
            WINBIO_IDENTITY Identity;
            ubyte           SubFactor;
            size_t          PropertyBufferSize;
            void*           PropertyBuffer;
        }
        struct SetProperty
        {
            uint            PropertyType;
            uint            PropertyId;
            WINBIO_IDENTITY Identity;
            ubyte           SubFactor;
            size_t          PropertyBufferSize;
            void*           PropertyBuffer;
        }
        struct GetEvent
        {
            WINBIO_EVENT Event;
        }
        struct ControlUnit
        {
            uint   Component;
            uint   ControlCode;
            uint   OperationStatus;
            ubyte* SendBuffer;
            size_t SendBufferSize;
            ubyte* ReceiveBuffer;
            size_t ReceiveBufferSize;
            size_t ReceiveDataSize;
        }
        struct EnumServiceProviders
        {
            size_t             BspCount;
            WINBIO_BSP_SCHEMA* BspSchemaArray;
        }
        struct EnumBiometricUnits
        {
            size_t              UnitCount;
            WINBIO_UNIT_SCHEMA* UnitSchemaArray;
        }
        struct EnumDatabases
        {
            size_t StorageCount;
            WINBIO_STORAGE_SCHEMA* StorageSchemaArray;
        }
        struct VerifyAndReleaseTicket
        {
            ubyte Match;
            uint  RejectDetail;
            ulong Ticket;
        }
        struct IdentifyAndReleaseTicket
        {
            WINBIO_IDENTITY Identity;
            ubyte           SubFactor;
            uint            RejectDetail;
            ulong           Ticket;
        }
        struct EnrollSelect
        {
            ulong SelectorValue;
        }
        struct MonitorPresence
        {
            uint             ChangeType;
            size_t           PresenceCount;
            WINBIO_PRESENCE* PresenceArray;
        }
        struct GetProtectionPolicy
        {
            WINBIO_IDENTITY Identity;
            WINBIO_PROTECTION_POLICY Policy;
        }
        struct NotifyUnitStatusChange
        {
            WINBIO_EXTENDED_UNIT_STATUS ExtendedStatus;
        }
    }
}

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
    ubyte            SubFactor;
    uint*            IndexVector;
    size_t           IndexElementCount;
    ubyte*           TemplateBlob;
    size_t           TemplateBlobSize;
    ubyte*           PayloadBlob;
    size_t           PayloadBlobSize;
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

struct WINBIO_SENSOR_INTERFACE
{
    WINBIO_ADAPTER_INTERFACE_VERSION Version;
    uint   Type;
    size_t Size;
    GUID   AdapterId;
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

struct WINBIO_ENGINE_INTERFACE
{
    WINBIO_ADAPTER_INTERFACE_VERSION Version;
    uint   Type;
    size_t Size;
    GUID   AdapterId;
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

struct WINBIO_STORAGE_INTERFACE
{
    WINBIO_ADAPTER_INTERFACE_VERSION Version;
    uint   Type;
    size_t Size;
    GUID   AdapterId;
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

struct WINBIO_FRAMEWORK_INTERFACE
{
    WINBIO_ADAPTER_INTERFACE_VERSION Version;
    uint   Type;
    size_t Size;
    GUID   AdapterId;
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

// Functions

@DllImport("winbio")
HRESULT WinBioEnumServiceProviders(uint Factor, WINBIO_BSP_SCHEMA** BspSchemaArray, size_t* BspCount);

@DllImport("winbio")
HRESULT WinBioEnumBiometricUnits(uint Factor, WINBIO_UNIT_SCHEMA** UnitSchemaArray, size_t* UnitCount);

@DllImport("winbio")
HRESULT WinBioEnumDatabases(uint Factor, WINBIO_STORAGE_SCHEMA** StorageSchemaArray, size_t* StorageCount);

@DllImport("winbio")
HRESULT WinBioAsyncOpenFramework(WINBIO_ASYNC_NOTIFICATION_METHOD NotificationMethod, HWND TargetWindow, 
                                 uint MessageCode, PWINBIO_ASYNC_COMPLETION_CALLBACK CallbackRoutine, void* UserData, 
                                 BOOL AsynchronousOpen, uint* FrameworkHandle);

@DllImport("winbio")
HRESULT WinBioCloseFramework(uint FrameworkHandle);

@DllImport("winbio")
HRESULT WinBioAsyncEnumServiceProviders(uint FrameworkHandle, uint Factor);

@DllImport("winbio")
HRESULT WinBioAsyncEnumBiometricUnits(uint FrameworkHandle, uint Factor);

@DllImport("winbio")
HRESULT WinBioAsyncEnumDatabases(uint FrameworkHandle, uint Factor);

@DllImport("winbio")
HRESULT WinBioAsyncMonitorFrameworkChanges(uint FrameworkHandle, uint ChangeTypes);

@DllImport("winbio")
HRESULT WinBioOpenSession(uint Factor, uint PoolType, uint Flags, char* UnitArray, size_t UnitCount, 
                          GUID* DatabaseId, uint* SessionHandle);

@DllImport("winbio")
HRESULT WinBioAsyncOpenSession(uint Factor, uint PoolType, uint Flags, char* UnitArray, size_t UnitCount, 
                               GUID* DatabaseId, WINBIO_ASYNC_NOTIFICATION_METHOD NotificationMethod, 
                               HWND TargetWindow, uint MessageCode, 
                               PWINBIO_ASYNC_COMPLETION_CALLBACK CallbackRoutine, void* UserData, 
                               BOOL AsynchronousOpen, uint* SessionHandle);

@DllImport("winbio")
HRESULT WinBioCloseSession(uint SessionHandle);

@DllImport("winbio")
HRESULT WinBioVerify(uint SessionHandle, WINBIO_IDENTITY* Identity, ubyte SubFactor, uint* UnitId, ubyte* Match, 
                     uint* RejectDetail);

@DllImport("winbio")
HRESULT WinBioVerifyWithCallback(uint SessionHandle, WINBIO_IDENTITY* Identity, ubyte SubFactor, 
                                 PWINBIO_VERIFY_CALLBACK VerifyCallback, void* VerifyCallbackContext);

@DllImport("winbio")
HRESULT WinBioIdentify(uint SessionHandle, uint* UnitId, WINBIO_IDENTITY* Identity, ubyte* SubFactor, 
                       uint* RejectDetail);

@DllImport("winbio")
HRESULT WinBioIdentifyWithCallback(uint SessionHandle, PWINBIO_IDENTIFY_CALLBACK IdentifyCallback, 
                                   void* IdentifyCallbackContext);

@DllImport("winbio")
HRESULT WinBioWait(uint SessionHandle);

@DllImport("winbio")
HRESULT WinBioCancel(uint SessionHandle);

@DllImport("winbio")
HRESULT WinBioLocateSensor(uint SessionHandle, uint* UnitId);

@DllImport("winbio")
HRESULT WinBioLocateSensorWithCallback(uint SessionHandle, PWINBIO_LOCATE_SENSOR_CALLBACK LocateCallback, 
                                       void* LocateCallbackContext);

@DllImport("winbio")
HRESULT WinBioEnrollBegin(uint SessionHandle, ubyte SubFactor, uint UnitId);

@DllImport("winbio")
HRESULT WinBioEnrollSelect(uint SessionHandle, ulong SelectorValue);

@DllImport("winbio")
HRESULT WinBioEnrollCapture(uint SessionHandle, uint* RejectDetail);

@DllImport("winbio")
HRESULT WinBioEnrollCaptureWithCallback(uint SessionHandle, PWINBIO_ENROLL_CAPTURE_CALLBACK EnrollCallback, 
                                        void* EnrollCallbackContext);

@DllImport("winbio")
HRESULT WinBioEnrollCommit(uint SessionHandle, WINBIO_IDENTITY* Identity, ubyte* IsNewTemplate);

@DllImport("winbio")
HRESULT WinBioEnrollDiscard(uint SessionHandle);

@DllImport("winbio")
HRESULT WinBioEnumEnrollments(uint SessionHandle, uint UnitId, WINBIO_IDENTITY* Identity, ubyte** SubFactorArray, 
                              size_t* SubFactorCount);

@DllImport("winbio")
HRESULT WinBioRegisterEventMonitor(uint SessionHandle, uint EventMask, PWINBIO_EVENT_CALLBACK EventCallback, 
                                   void* EventCallbackContext);

@DllImport("winbio")
HRESULT WinBioUnregisterEventMonitor(uint SessionHandle);

@DllImport("winbio")
HRESULT WinBioMonitorPresence(uint SessionHandle, uint UnitId);

@DllImport("winbio")
HRESULT WinBioCaptureSample(uint SessionHandle, ubyte Purpose, ubyte Flags, uint* UnitId, WINBIO_BIR** Sample, 
                            size_t* SampleSize, uint* RejectDetail);

@DllImport("winbio")
HRESULT WinBioCaptureSampleWithCallback(uint SessionHandle, ubyte Purpose, ubyte Flags, 
                                        PWINBIO_CAPTURE_CALLBACK CaptureCallback, void* CaptureCallbackContext);

@DllImport("winbio")
HRESULT WinBioDeleteTemplate(uint SessionHandle, uint UnitId, WINBIO_IDENTITY* Identity, ubyte SubFactor);

@DllImport("winbio")
HRESULT WinBioLockUnit(uint SessionHandle, uint UnitId);

@DllImport("winbio")
HRESULT WinBioUnlockUnit(uint SessionHandle, uint UnitId);

@DllImport("winbio")
HRESULT WinBioControlUnit(uint SessionHandle, uint UnitId, uint Component, uint ControlCode, char* SendBuffer, 
                          size_t SendBufferSize, char* ReceiveBuffer, size_t ReceiveBufferSize, 
                          size_t* ReceiveDataSize, uint* OperationStatus);

@DllImport("winbio")
HRESULT WinBioControlUnitPrivileged(uint SessionHandle, uint UnitId, uint Component, uint ControlCode, 
                                    char* SendBuffer, size_t SendBufferSize, char* ReceiveBuffer, 
                                    size_t ReceiveBufferSize, size_t* ReceiveDataSize, uint* OperationStatus);

@DllImport("winbio")
HRESULT WinBioGetProperty(uint SessionHandle, uint PropertyType, uint PropertyId, uint UnitId, 
                          WINBIO_IDENTITY* Identity, ubyte SubFactor, void** PropertyBuffer, 
                          size_t* PropertyBufferSize);

@DllImport("winbio")
HRESULT WinBioSetProperty(uint SessionHandle, uint PropertyType, uint PropertyId, uint UnitId, 
                          WINBIO_IDENTITY* Identity, ubyte SubFactor, char* PropertyBuffer, 
                          size_t PropertyBufferSize);

@DllImport("winbio")
HRESULT WinBioFree(void* Address);

@DllImport("winbio")
HRESULT WinBioSetCredential(WINBIO_CREDENTIAL_TYPE Type, char* Credential, size_t CredentialSize, 
                            WINBIO_CREDENTIAL_FORMAT Format);

@DllImport("winbio")
HRESULT WinBioRemoveCredential(WINBIO_IDENTITY Identity, WINBIO_CREDENTIAL_TYPE Type);

@DllImport("winbio")
HRESULT WinBioRemoveAllCredentials();

@DllImport("winbio")
HRESULT WinBioRemoveAllDomainCredentials();

@DllImport("winbio")
HRESULT WinBioGetCredentialState(WINBIO_IDENTITY Identity, WINBIO_CREDENTIAL_TYPE Type, 
                                 WINBIO_CREDENTIAL_STATE* CredentialState);

@DllImport("winbio")
HRESULT WinBioLogonIdentifiedUser(uint SessionHandle);

@DllImport("winbio")
HRESULT WinBioGetEnrolledFactors(WINBIO_IDENTITY* AccountOwner, uint* EnrolledFactors);

@DllImport("winbio")
void WinBioGetEnabledSetting(ubyte* Value, uint* Source);

@DllImport("winbio")
void WinBioGetLogonSetting(ubyte* Value, uint* Source);

@DllImport("winbio")
void WinBioGetDomainLogonSetting(ubyte* Value, uint* Source);

@DllImport("winbio")
HRESULT WinBioAcquireFocus();

@DllImport("winbio")
HRESULT WinBioReleaseFocus();


