module windows.fileseverresourcemanager;

public import windows.core;
public import windows.automation : BSTR, IDispatch, SAFEARRAY, VARIANT;
public import windows.com : HRESULT, IUnknown;

extern(Windows):


// Enums


enum FsrmQuotaFlags : int
{
    FsrmQuotaFlags_Enforce          = 0x00000100,
    FsrmQuotaFlags_Disable          = 0x00000200,
    FsrmQuotaFlags_StatusIncomplete = 0x00010000,
    FsrmQuotaFlags_StatusRebuilding = 0x00020000,
}

enum FsrmFileScreenFlags : int
{
    FsrmFileScreenFlags_Enforce = 0x00000001,
}

enum FsrmCollectionState : int
{
    FsrmCollectionState_Fetching   = 0x00000001,
    FsrmCollectionState_Committing = 0x00000002,
    FsrmCollectionState_Complete   = 0x00000003,
    FsrmCollectionState_Cancelled  = 0x00000004,
}

enum FsrmEnumOptions : int
{
    FsrmEnumOptions_None                     = 0x00000000,
    FsrmEnumOptions_Asynchronous             = 0x00000001,
    FsrmEnumOptions_CheckRecycleBin          = 0x00000002,
    FsrmEnumOptions_IncludeClusterNodes      = 0x00000004,
    FsrmEnumOptions_IncludeDeprecatedObjects = 0x00000008,
}

enum FsrmCommitOptions : int
{
    FsrmCommitOptions_None         = 0x00000000,
    FsrmCommitOptions_Asynchronous = 0x00000001,
}

enum FsrmTemplateApplyOptions : int
{
    FsrmTemplateApplyOptions_ApplyToDerivedMatching = 0x00000001,
    FsrmTemplateApplyOptions_ApplyToDerivedAll      = 0x00000002,
}

enum FsrmActionType : int
{
    FsrmActionType_Unknown  = 0x00000000,
    FsrmActionType_EventLog = 0x00000001,
    FsrmActionType_Email    = 0x00000002,
    FsrmActionType_Command  = 0x00000003,
    FsrmActionType_Report   = 0x00000004,
}

enum FsrmEventType : int
{
    FsrmEventType_Unknown     = 0x00000000,
    FsrmEventType_Information = 0x00000001,
    FsrmEventType_Warning     = 0x00000002,
    FsrmEventType_Error       = 0x00000003,
}

enum FsrmAccountType : int
{
    FsrmAccountType_Unknown        = 0x00000000,
    FsrmAccountType_NetworkService = 0x00000001,
    FsrmAccountType_LocalService   = 0x00000002,
    FsrmAccountType_LocalSystem    = 0x00000003,
    FsrmAccountType_InProc         = 0x00000004,
    FsrmAccountType_External       = 0x00000005,
    FsrmAccountType_Automatic      = 0x000001f4,
}

enum FsrmReportType : int
{
    FsrmReportType_Unknown                 = 0x00000000,
    FsrmReportType_LargeFiles              = 0x00000001,
    FsrmReportType_FilesByType             = 0x00000002,
    FsrmReportType_LeastRecentlyAccessed   = 0x00000003,
    FsrmReportType_MostRecentlyAccessed    = 0x00000004,
    FsrmReportType_QuotaUsage              = 0x00000005,
    FsrmReportType_FilesByOwner            = 0x00000006,
    FsrmReportType_ExportReport            = 0x00000007,
    FsrmReportType_DuplicateFiles          = 0x00000008,
    FsrmReportType_FileScreenAudit         = 0x00000009,
    FsrmReportType_FilesByProperty         = 0x0000000a,
    FsrmReportType_AutomaticClassification = 0x0000000b,
    FsrmReportType_Expiration              = 0x0000000c,
    FsrmReportType_FoldersByProperty       = 0x0000000d,
}

enum FsrmReportFormat : int
{
    FsrmReportFormat_Unknown = 0x00000000,
    FsrmReportFormat_DHtml   = 0x00000001,
    FsrmReportFormat_Html    = 0x00000002,
    FsrmReportFormat_Txt     = 0x00000003,
    FsrmReportFormat_Csv     = 0x00000004,
    FsrmReportFormat_Xml     = 0x00000005,
}

enum FsrmReportRunningStatus : int
{
    FsrmReportRunningStatus_Unknown    = 0x00000000,
    FsrmReportRunningStatus_NotRunning = 0x00000001,
    FsrmReportRunningStatus_Queued     = 0x00000002,
    FsrmReportRunningStatus_Running    = 0x00000003,
}

enum FsrmReportGenerationContext : int
{
    FsrmReportGenerationContext_Undefined         = 0x00000001,
    FsrmReportGenerationContext_ScheduledReport   = 0x00000002,
    FsrmReportGenerationContext_InteractiveReport = 0x00000003,
    FsrmReportGenerationContext_IncidentReport    = 0x00000004,
}

enum FsrmReportFilter : int
{
    FsrmReportFilter_MinSize       = 0x00000001,
    FsrmReportFilter_MinAgeDays    = 0x00000002,
    FsrmReportFilter_MaxAgeDays    = 0x00000003,
    FsrmReportFilter_MinQuotaUsage = 0x00000004,
    FsrmReportFilter_FileGroups    = 0x00000005,
    FsrmReportFilter_Owners        = 0x00000006,
    FsrmReportFilter_NamePattern   = 0x00000007,
    FsrmReportFilter_Property      = 0x00000008,
}

enum FsrmReportLimit : int
{
    FsrmReportLimit_MaxFiles                 = 0x00000001,
    FsrmReportLimit_MaxFileGroups            = 0x00000002,
    FsrmReportLimit_MaxOwners                = 0x00000003,
    FsrmReportLimit_MaxFilesPerFileGroup     = 0x00000004,
    FsrmReportLimit_MaxFilesPerOwner         = 0x00000005,
    FsrmReportLimit_MaxFilesPerDuplGroup     = 0x00000006,
    FsrmReportLimit_MaxDuplicateGroups       = 0x00000007,
    FsrmReportLimit_MaxQuotas                = 0x00000008,
    FsrmReportLimit_MaxFileScreenEvents      = 0x00000009,
    FsrmReportLimit_MaxPropertyValues        = 0x0000000a,
    FsrmReportLimit_MaxFilesPerPropertyValue = 0x0000000b,
    FsrmReportLimit_MaxFolders               = 0x0000000c,
}

enum FsrmPropertyDefinitionType : int
{
    FsrmPropertyDefinitionType_Unknown          = 0x00000000,
    FsrmPropertyDefinitionType_OrderedList      = 0x00000001,
    FsrmPropertyDefinitionType_MultiChoiceList  = 0x00000002,
    FsrmPropertyDefinitionType_SingleChoiceList = 0x00000003,
    FsrmPropertyDefinitionType_String           = 0x00000004,
    FsrmPropertyDefinitionType_MultiString      = 0x00000005,
    FsrmPropertyDefinitionType_Int              = 0x00000006,
    FsrmPropertyDefinitionType_Bool             = 0x00000007,
    FsrmPropertyDefinitionType_Date             = 0x00000008,
}

enum FsrmPropertyDefinitionFlags : int
{
    FsrmPropertyDefinitionFlags_Global     = 0x00000001,
    FsrmPropertyDefinitionFlags_Deprecated = 0x00000002,
    FsrmPropertyDefinitionFlags_Secure     = 0x00000004,
}

enum FsrmPropertyDefinitionAppliesTo : int
{
    FsrmPropertyDefinitionAppliesTo_Files   = 0x00000001,
    FsrmPropertyDefinitionAppliesTo_Folders = 0x00000002,
}

enum FsrmRuleType : int
{
    FsrmRuleType_Unknown        = 0x00000000,
    FsrmRuleType_Classification = 0x00000001,
    FsrmRuleType_Generic        = 0x00000002,
}

enum FsrmRuleFlags : int
{
    FsrmRuleFlags_Disabled                             = 0x00000100,
    FsrmRuleFlags_ClearAutomaticallyClassifiedProperty = 0x00000400,
    FsrmRuleFlags_ClearManuallyClassifiedProperty      = 0x00000800,
    FsrmRuleFlags_Invalid                              = 0x00001000,
}

enum FsrmClassificationLoggingFlags : int
{
    FsrmClassificationLoggingFlags_None                       = 0x00000000,
    FsrmClassificationLoggingFlags_ClassificationsInLogFile   = 0x00000001,
    FsrmClassificationLoggingFlags_ErrorsInLogFile            = 0x00000002,
    FsrmClassificationLoggingFlags_ClassificationsInSystemLog = 0x00000004,
    FsrmClassificationLoggingFlags_ErrorsInSystemLog          = 0x00000008,
}

enum FsrmExecutionOption : int
{
    FsrmExecutionOption_Unknown                          = 0x00000000,
    FsrmExecutionOption_EvaluateUnset                    = 0x00000001,
    FsrmExecutionOption_ReEvaluate_ConsiderExistingValue = 0x00000002,
    FsrmExecutionOption_ReEvaluate_IgnoreExistingValue   = 0x00000003,
}

enum FsrmStorageModuleCaps : int
{
    FsrmStorageModuleCaps_Unknown              = 0x00000000,
    FsrmStorageModuleCaps_CanGet               = 0x00000001,
    FsrmStorageModuleCaps_CanSet               = 0x00000002,
    FsrmStorageModuleCaps_CanHandleDirectories = 0x00000004,
    FsrmStorageModuleCaps_CanHandleFiles       = 0x00000008,
}

enum FsrmStorageModuleType : int
{
    FsrmStorageModuleType_Unknown  = 0x00000000,
    FsrmStorageModuleType_Cache    = 0x00000001,
    FsrmStorageModuleType_InFile   = 0x00000002,
    FsrmStorageModuleType_Database = 0x00000003,
    FsrmStorageModuleType_System   = 0x00000064,
}

enum FsrmPropertyBagFlags : int
{
    FsrmPropertyBagFlags_UpdatedByClassifier         = 0x00000001,
    FsrmPropertyBagFlags_FailedLoadingProperties     = 0x00000002,
    FsrmPropertyBagFlags_FailedSavingProperties      = 0x00000004,
    FsrmPropertyBagFlags_FailedClassifyingProperties = 0x00000008,
}

enum FsrmPropertyBagField : int
{
    FsrmPropertyBagField_AccessVolume   = 0x00000000,
    FsrmPropertyBagField_VolumeGuidName = 0x00000001,
}

enum FsrmPropertyFlags : int
{
    FsrmPropertyFlags_None                        = 0x00000000,
    FsrmPropertyFlags_Orphaned                    = 0x00000001,
    FsrmPropertyFlags_RetrievedFromCache          = 0x00000002,
    FsrmPropertyFlags_RetrievedFromStorage        = 0x00000004,
    FsrmPropertyFlags_SetByClassifier             = 0x00000008,
    FsrmPropertyFlags_Deleted                     = 0x00000010,
    FsrmPropertyFlags_Reclassified                = 0x00000020,
    FsrmPropertyFlags_AggregationFailed           = 0x00000040,
    FsrmPropertyFlags_Existing                    = 0x00000080,
    FsrmPropertyFlags_FailedLoadingProperties     = 0x00000100,
    FsrmPropertyFlags_FailedClassifyingProperties = 0x00000200,
    FsrmPropertyFlags_FailedSavingProperties      = 0x00000400,
    FsrmPropertyFlags_Secure                      = 0x00000800,
    FsrmPropertyFlags_PolicyDerived               = 0x00001000,
    FsrmPropertyFlags_Inherited                   = 0x00002000,
    FsrmPropertyFlags_Manual                      = 0x00004000,
    FsrmPropertyFlags_ExplicitValueDeleted        = 0x00008000,
    FsrmPropertyFlags_PropertyDeletedFromClear    = 0x00010000,
    FsrmPropertyFlags_PropertySourceMask          = 0x0000000e,
    FsrmPropertyFlags_PersistentMask              = 0x00005000,
}

enum FsrmPipelineModuleType : int
{
    FsrmPipelineModuleType_Unknown    = 0x00000000,
    FsrmPipelineModuleType_Storage    = 0x00000001,
    FsrmPipelineModuleType_Classifier = 0x00000002,
}

enum FsrmGetFilePropertyOptions : int
{
    FsrmGetFilePropertyOptions_None                = 0x00000000,
    FsrmGetFilePropertyOptions_NoRuleEvaluation    = 0x00000001,
    FsrmGetFilePropertyOptions_Persistent          = 0x00000002,
    FsrmGetFilePropertyOptions_FailOnPersistErrors = 0x00000004,
    FsrmGetFilePropertyOptions_SkipOrphaned        = 0x00000008,
}

enum FsrmFileManagementType : int
{
    FsrmFileManagementType_Unknown    = 0x00000000,
    FsrmFileManagementType_Expiration = 0x00000001,
    FsrmFileManagementType_Custom     = 0x00000002,
    FsrmFileManagementType_Rms        = 0x00000003,
}

enum FsrmFileManagementLoggingFlags : int
{
    FsrmFileManagementLoggingFlags_None        = 0x00000000,
    FsrmFileManagementLoggingFlags_Error       = 0x00000001,
    FsrmFileManagementLoggingFlags_Information = 0x00000002,
    FsrmFileManagementLoggingFlags_Audit       = 0x00000004,
}

enum FsrmPropertyConditionType : int
{
    FsrmPropertyConditionType_Unknown        = 0x00000000,
    FsrmPropertyConditionType_Equal          = 0x00000001,
    FsrmPropertyConditionType_NotEqual       = 0x00000002,
    FsrmPropertyConditionType_GreaterThan    = 0x00000003,
    FsrmPropertyConditionType_LessThan       = 0x00000004,
    FsrmPropertyConditionType_Contain        = 0x00000005,
    FsrmPropertyConditionType_Exist          = 0x00000006,
    FsrmPropertyConditionType_NotExist       = 0x00000007,
    FsrmPropertyConditionType_StartWith      = 0x00000008,
    FsrmPropertyConditionType_EndWith        = 0x00000009,
    FsrmPropertyConditionType_ContainedIn    = 0x0000000a,
    FsrmPropertyConditionType_PrefixOf       = 0x0000000b,
    FsrmPropertyConditionType_SuffixOf       = 0x0000000c,
    FsrmPropertyConditionType_MatchesPattern = 0x0000000d,
}

enum FsrmFileStreamingMode : int
{
    FsrmFileStreamingMode_Unknown = 0x00000000,
    FsrmFileStreamingMode_Read    = 0x00000001,
    FsrmFileStreamingMode_Write   = 0x00000002,
}

enum FsrmFileStreamingInterfaceType : int
{
    FsrmFileStreamingInterfaceType_Unknown    = 0x00000000,
    FsrmFileStreamingInterfaceType_ILockBytes = 0x00000001,
    FsrmFileStreamingInterfaceType_IStream    = 0x00000002,
}

enum FsrmFileConditionType : int
{
    FsrmFileConditionType_Unknown  = 0x00000000,
    FsrmFileConditionType_Property = 0x00000001,
}

enum FsrmFileSystemPropertyId : int
{
    FsrmFileSystemPropertyId_Undefined        = 0x00000000,
    FsrmFileSystemPropertyId_FileName         = 0x00000001,
    FsrmFileSystemPropertyId_DateCreated      = 0x00000002,
    FsrmFileSystemPropertyId_DateLastAccessed = 0x00000003,
    FsrmFileSystemPropertyId_DateLastModified = 0x00000004,
    FsrmFileSystemPropertyId_DateNow          = 0x00000005,
}

enum FsrmPropertyValueType : int
{
    FsrmPropertyValueType_Undefined  = 0x00000000,
    FsrmPropertyValueType_Literal    = 0x00000001,
    FsrmPropertyValueType_DateOffset = 0x00000002,
}

enum AdrClientDisplayFlags : int
{
    AdrClientDisplayFlags_AllowEmailRequests        = 0x00000001,
    AdrClientDisplayFlags_ShowDeviceTroubleshooting = 0x00000002,
}

enum AdrEmailFlags : int
{
    AdrEmailFlags_PutDataOwnerOnToLine = 0x00000001,
    AdrEmailFlags_PutAdminOnToLine     = 0x00000002,
    AdrEmailFlags_IncludeDeviceClaims  = 0x00000004,
    AdrEmailFlags_IncludeUserInfo      = 0x00000008,
    AdrEmailFlags_GenerateEventLog     = 0x00000010,
}

enum AdrClientErrorType : int
{
    AdrClientErrorType_Unknown      = 0x00000000,
    AdrClientErrorType_AccessDenied = 0x00000001,
    AdrClientErrorType_FileNotFound = 0x00000002,
}

enum AdrClientFlags : int
{
    AdrClientFlags_None                       = 0x00000000,
    AdrClientFlags_FailForLocalPaths          = 0x00000001,
    AdrClientFlags_FailIfNotSupportedByServer = 0x00000002,
    AdrClientFlags_FailIfNotDomainJoined      = 0x00000004,
}

// Interfaces

@GUID("F556D708-6D4D-4594-9C61-7DBB0DAE2A46")
struct FsrmSetting;

@GUID("F3BE42BD-8AC2-409E-BBD8-FAF9B6B41FEB")
struct FsrmPathMapper;

@GUID("1482DC37-FAE9-4787-9025-8CE4E024AB56")
struct FsrmExportImport;

@GUID("90DCAB7F-347C-4BFC-B543-540326305FBE")
struct FsrmQuotaManager;

@GUID("97D3D443-251C-4337-81E7-B32E8F4EE65E")
struct FsrmQuotaTemplateManager;

@GUID("8F1363F6-656F-4496-9226-13AECBD7718F")
struct FsrmFileGroupManager;

@GUID("95941183-DB53-4C5F-B37B-7D0921CF9DC7")
struct FsrmFileScreenManager;

@GUID("243111DF-E474-46AA-A054-EAA33EDC292A")
struct FsrmFileScreenTemplateManager;

@GUID("0058EF37-AA66-4C48-BD5B-2FCE432AB0C8")
struct FsrmReportManager;

@GUID("EA25F1B8-1B8D-4290-8EE8-E17C12C2FE20")
struct FsrmReportScheduler;

@GUID("EB18F9B2-4C3A-4321-B203-205120CFF614")
struct FsrmFileManagementJobManager;

@GUID("B15C0E47-C391-45B9-95C8-EB596C853F3A")
struct FsrmClassificationManager;

@GUID("C7643375-1EB5-44DE-A062-623547D933BC")
struct FsrmPipelineModuleConnector;

@GUID("2AE64751-B728-4D6B-97A0-B2DA2E7D2A3B")
struct AdSyncTask;

@GUID("100B4FC8-74C1-470F-B1B7-DD7B6BAE79BD")
struct FsrmAccessDeniedRemediationClient;

@GUID("22BCEF93-4A3F-4183-89F9-2F8B8A628AEE")
interface IFsrmObject : IDispatch
{
    HRESULT get_Id(GUID* id);
    HRESULT get_Description(BSTR* description);
    HRESULT put_Description(BSTR description);
    HRESULT Delete();
    HRESULT Commit();
}

@GUID("F76FBF3B-8DDD-4B42-B05A-CB1C3FF1FEE8")
interface IFsrmCollection : IDispatch
{
    HRESULT get__NewEnum(IUnknown* unknown);
    HRESULT get_Item(int index, VARIANT* item);
    HRESULT get_Count(int* count);
    HRESULT get_State(FsrmCollectionState* state);
    HRESULT Cancel();
    HRESULT WaitForCompletion(int waitSeconds, short* completed);
    HRESULT GetById(GUID id, VARIANT* entry);
}

@GUID("1BB617B8-3886-49DC-AF82-A6C90FA35DDA")
interface IFsrmMutableCollection : IFsrmCollection
{
    HRESULT Add(VARIANT item);
    HRESULT Remove(int index);
    HRESULT RemoveById(GUID id);
    HRESULT Clone(IFsrmMutableCollection* collection);
}

@GUID("96DEB3B5-8B91-4A2A-9D93-80A35D8AA847")
interface IFsrmCommittableCollection : IFsrmMutableCollection
{
    HRESULT Commit(FsrmCommitOptions options, IFsrmCollection* results);
}

@GUID("6CD6408A-AE60-463B-9EF1-E117534D69DC")
interface IFsrmAction : IDispatch
{
    HRESULT get_Id(GUID* id);
    HRESULT get_ActionType(FsrmActionType* actionType);
    HRESULT get_RunLimitInterval(int* minutes);
    HRESULT put_RunLimitInterval(int minutes);
    HRESULT Delete();
}

@GUID("D646567D-26AE-4CAA-9F84-4E0AAD207FCA")
interface IFsrmActionEmail : IFsrmAction
{
    HRESULT get_MailFrom(BSTR* mailFrom);
    HRESULT put_MailFrom(BSTR mailFrom);
    HRESULT get_MailReplyTo(BSTR* mailReplyTo);
    HRESULT put_MailReplyTo(BSTR mailReplyTo);
    HRESULT get_MailTo(BSTR* mailTo);
    HRESULT put_MailTo(BSTR mailTo);
    HRESULT get_MailCc(BSTR* mailCc);
    HRESULT put_MailCc(BSTR mailCc);
    HRESULT get_MailBcc(BSTR* mailBcc);
    HRESULT put_MailBcc(BSTR mailBcc);
    HRESULT get_MailSubject(BSTR* mailSubject);
    HRESULT put_MailSubject(BSTR mailSubject);
    HRESULT get_MessageText(BSTR* messageText);
    HRESULT put_MessageText(BSTR messageText);
}

@GUID("8276702F-2532-4839-89BF-4872609A2EA4")
interface IFsrmActionEmail2 : IFsrmActionEmail
{
    HRESULT get_AttachmentFileListSize(int* attachmentFileListSize);
    HRESULT put_AttachmentFileListSize(int attachmentFileListSize);
}

@GUID("2DBE63C4-B340-48A0-A5B0-158E07FC567E")
interface IFsrmActionReport : IFsrmAction
{
    HRESULT get_ReportTypes(SAFEARRAY** reportTypes);
    HRESULT put_ReportTypes(SAFEARRAY* reportTypes);
    HRESULT get_MailTo(BSTR* mailTo);
    HRESULT put_MailTo(BSTR mailTo);
}

@GUID("4C8F96C3-5D94-4F37-A4F4-F56AB463546F")
interface IFsrmActionEventLog : IFsrmAction
{
    HRESULT get_EventType(FsrmEventType* eventType);
    HRESULT put_EventType(FsrmEventType eventType);
    HRESULT get_MessageText(BSTR* messageText);
    HRESULT put_MessageText(BSTR messageText);
}

@GUID("12937789-E247-4917-9C20-F3EE9C7EE783")
interface IFsrmActionCommand : IFsrmAction
{
    HRESULT get_ExecutablePath(BSTR* executablePath);
    HRESULT put_ExecutablePath(BSTR executablePath);
    HRESULT get_Arguments(BSTR* arguments);
    HRESULT put_Arguments(BSTR arguments);
    HRESULT get_Account(FsrmAccountType* account);
    HRESULT put_Account(FsrmAccountType account);
    HRESULT get_WorkingDirectory(BSTR* workingDirectory);
    HRESULT put_WorkingDirectory(BSTR workingDirectory);
    HRESULT get_MonitorCommand(short* monitorCommand);
    HRESULT put_MonitorCommand(short monitorCommand);
    HRESULT get_KillTimeOut(int* minutes);
    HRESULT put_KillTimeOut(int minutes);
    HRESULT get_LogResult(short* logResults);
    HRESULT put_LogResult(short logResults);
}

@GUID("F411D4FD-14BE-4260-8C40-03B7C95E608A")
interface IFsrmSetting : IDispatch
{
    HRESULT get_SmtpServer(BSTR* smtpServer);
    HRESULT put_SmtpServer(BSTR smtpServer);
    HRESULT get_MailFrom(BSTR* mailFrom);
    HRESULT put_MailFrom(BSTR mailFrom);
    HRESULT get_AdminEmail(BSTR* adminEmail);
    HRESULT put_AdminEmail(BSTR adminEmail);
    HRESULT get_DisableCommandLine(short* disableCommandLine);
    HRESULT put_DisableCommandLine(short disableCommandLine);
    HRESULT get_EnableScreeningAudit(short* enableScreeningAudit);
    HRESULT put_EnableScreeningAudit(short enableScreeningAudit);
    HRESULT EmailTest(BSTR mailTo);
    HRESULT SetActionRunLimitInterval(FsrmActionType actionType, int delayTimeMinutes);
    HRESULT GetActionRunLimitInterval(FsrmActionType actionType, int* delayTimeMinutes);
}

@GUID("6F4DBFFF-6920-4821-A6C3-B7E94C1FD60C")
interface IFsrmPathMapper : IDispatch
{
    HRESULT GetSharePathsForLocalPath(BSTR localPath, SAFEARRAY** sharePaths);
}

@GUID("EFCB0AB1-16C4-4A79-812C-725614C3306B")
interface IFsrmExportImport : IDispatch
{
    HRESULT ExportFileGroups(BSTR filePath, VARIANT* fileGroupNamesSafeArray, BSTR remoteHost);
    HRESULT ImportFileGroups(BSTR filePath, VARIANT* fileGroupNamesSafeArray, BSTR remoteHost, 
                             IFsrmCommittableCollection* fileGroups);
    HRESULT ExportFileScreenTemplates(BSTR filePath, VARIANT* templateNamesSafeArray, BSTR remoteHost);
    HRESULT ImportFileScreenTemplates(BSTR filePath, VARIANT* templateNamesSafeArray, BSTR remoteHost, 
                                      IFsrmCommittableCollection* templates);
    HRESULT ExportQuotaTemplates(BSTR filePath, VARIANT* templateNamesSafeArray, BSTR remoteHost);
    HRESULT ImportQuotaTemplates(BSTR filePath, VARIANT* templateNamesSafeArray, BSTR remoteHost, 
                                 IFsrmCommittableCollection* templates);
}

@GUID("39322A2D-38EE-4D0D-8095-421A80849A82")
interface IFsrmDerivedObjectsResult : IDispatch
{
    HRESULT get_DerivedObjects(IFsrmCollection* derivedObjects);
    HRESULT get_Results(IFsrmCollection* results);
}

@GUID("40002314-590B-45A5-8E1B-8C05DA527E52")
interface IFsrmAccessDeniedRemediationClient : IDispatch
{
    HRESULT Show(size_t parentWnd, BSTR accessPath, AdrClientErrorType errorType, int flags, BSTR windowTitle, 
                 BSTR windowMessage, int* result);
}

@GUID("1568A795-3924-4118-B74B-68D8F0FA5DAF")
interface IFsrmQuotaBase : IFsrmObject
{
    HRESULT get_QuotaLimit(VARIANT* quotaLimit);
    HRESULT put_QuotaLimit(VARIANT quotaLimit);
    HRESULT get_QuotaFlags(int* quotaFlags);
    HRESULT put_QuotaFlags(int quotaFlags);
    HRESULT get_Thresholds(SAFEARRAY** thresholds);
    HRESULT AddThreshold(int threshold);
    HRESULT DeleteThreshold(int threshold);
    HRESULT ModifyThreshold(int threshold, int newThreshold);
    HRESULT CreateThresholdAction(int threshold, FsrmActionType actionType, IFsrmAction* action);
    HRESULT EnumThresholdActions(int threshold, IFsrmCollection* actions);
}

@GUID("42DC3511-61D5-48AE-B6DC-59FC00C0A8D6")
interface IFsrmQuotaObject : IFsrmQuotaBase
{
    HRESULT get_Path(BSTR* path);
    HRESULT get_UserSid(BSTR* userSid);
    HRESULT get_UserAccount(BSTR* userAccount);
    HRESULT get_SourceTemplateName(BSTR* quotaTemplateName);
    HRESULT get_MatchesSourceTemplate(short* matches);
    HRESULT ApplyTemplate(BSTR quotaTemplateName);
}

@GUID("377F739D-9647-4B8E-97D2-5FFCE6D759CD")
interface IFsrmQuota : IFsrmQuotaObject
{
    HRESULT get_QuotaUsed(VARIANT* used);
    HRESULT get_QuotaPeakUsage(VARIANT* peakUsage);
    HRESULT get_QuotaPeakUsageTime(double* peakUsageDateTime);
    HRESULT ResetPeakUsage();
    HRESULT RefreshUsageProperties();
}

@GUID("F82E5729-6ABA-4740-BFC7-C7F58F75FB7B")
interface IFsrmAutoApplyQuota : IFsrmQuotaObject
{
    HRESULT get_ExcludeFolders(SAFEARRAY** folders);
    HRESULT put_ExcludeFolders(SAFEARRAY* folders);
    HRESULT CommitAndUpdateDerived(FsrmCommitOptions commitOptions, FsrmTemplateApplyOptions applyOptions, 
                                   IFsrmDerivedObjectsResult* derivedObjectsResult);
}

@GUID("8BB68C7D-19D8-4FFB-809E-BE4FC1734014")
interface IFsrmQuotaManager : IDispatch
{
    HRESULT get_ActionVariables(SAFEARRAY** variables);
    HRESULT get_ActionVariableDescriptions(SAFEARRAY** descriptions);
    HRESULT CreateQuota(BSTR path, IFsrmQuota* quota);
    HRESULT CreateAutoApplyQuota(BSTR quotaTemplateName, BSTR path, IFsrmAutoApplyQuota* quota);
    HRESULT GetQuota(BSTR path, IFsrmQuota* quota);
    HRESULT GetAutoApplyQuota(BSTR path, IFsrmAutoApplyQuota* quota);
    HRESULT GetRestrictiveQuota(BSTR path, IFsrmQuota* quota);
    HRESULT EnumQuotas(BSTR path, FsrmEnumOptions options, IFsrmCommittableCollection* quotas);
    HRESULT EnumAutoApplyQuotas(BSTR path, FsrmEnumOptions options, IFsrmCommittableCollection* quotas);
    HRESULT EnumEffectiveQuotas(BSTR path, FsrmEnumOptions options, IFsrmCommittableCollection* quotas);
    HRESULT Scan(BSTR strPath);
    HRESULT CreateQuotaCollection(IFsrmCommittableCollection* collection);
}

@GUID("4846CB01-D430-494F-ABB4-B1054999FB09")
interface IFsrmQuotaManagerEx : IFsrmQuotaManager
{
    HRESULT IsAffectedByQuota(BSTR path, FsrmEnumOptions options, short* affected);
}

@GUID("A2EFAB31-295E-46BB-B976-E86D58B52E8B")
interface IFsrmQuotaTemplate : IFsrmQuotaBase
{
    HRESULT get_Name(BSTR* name);
    HRESULT put_Name(BSTR name);
    HRESULT CopyTemplate(BSTR quotaTemplateName);
    HRESULT CommitAndUpdateDerived(FsrmCommitOptions commitOptions, FsrmTemplateApplyOptions applyOptions, 
                                   IFsrmDerivedObjectsResult* derivedObjectsResult);
}

@GUID("9A2BF113-A329-44CC-809A-5C00FCE8DA40")
interface IFsrmQuotaTemplateImported : IFsrmQuotaTemplate
{
    HRESULT get_OverwriteOnCommit(short* overwrite);
    HRESULT put_OverwriteOnCommit(short overwrite);
}

@GUID("4173AC41-172D-4D52-963C-FDC7E415F717")
interface IFsrmQuotaTemplateManager : IDispatch
{
    HRESULT CreateTemplate(IFsrmQuotaTemplate* quotaTemplate);
    HRESULT GetTemplate(BSTR name, IFsrmQuotaTemplate* quotaTemplate);
    HRESULT EnumTemplates(FsrmEnumOptions options, IFsrmCommittableCollection* quotaTemplates);
    HRESULT ExportTemplates(VARIANT* quotaTemplateNamesArray, BSTR* serializedQuotaTemplates);
    HRESULT ImportTemplates(BSTR serializedQuotaTemplates, VARIANT* quotaTemplateNamesArray, 
                            IFsrmCommittableCollection* quotaTemplates);
}

@GUID("8DD04909-0E34-4D55-AFAA-89E1F1A1BBB9")
interface IFsrmFileGroup : IFsrmObject
{
    HRESULT get_Name(BSTR* name);
    HRESULT put_Name(BSTR name);
    HRESULT get_Members(IFsrmMutableCollection* members);
    HRESULT put_Members(IFsrmMutableCollection members);
    HRESULT get_NonMembers(IFsrmMutableCollection* nonMembers);
    HRESULT put_NonMembers(IFsrmMutableCollection nonMembers);
}

@GUID("AD55F10B-5F11-4BE7-94EF-D9EE2E470DED")
interface IFsrmFileGroupImported : IFsrmFileGroup
{
    HRESULT get_OverwriteOnCommit(short* overwrite);
    HRESULT put_OverwriteOnCommit(short overwrite);
}

@GUID("426677D5-018C-485C-8A51-20B86D00BDC4")
interface IFsrmFileGroupManager : IDispatch
{
    HRESULT CreateFileGroup(IFsrmFileGroup* fileGroup);
    HRESULT GetFileGroup(BSTR name, IFsrmFileGroup* fileGroup);
    HRESULT EnumFileGroups(FsrmEnumOptions options, IFsrmCommittableCollection* fileGroups);
    HRESULT ExportFileGroups(VARIANT* fileGroupNamesArray, BSTR* serializedFileGroups);
    HRESULT ImportFileGroups(BSTR serializedFileGroups, VARIANT* fileGroupNamesArray, 
                             IFsrmCommittableCollection* fileGroups);
}

@GUID("F3637E80-5B22-4A2B-A637-BBB642B41CFC")
interface IFsrmFileScreenBase : IFsrmObject
{
    HRESULT get_BlockedFileGroups(IFsrmMutableCollection* blockList);
    HRESULT put_BlockedFileGroups(IFsrmMutableCollection blockList);
    HRESULT get_FileScreenFlags(int* fileScreenFlags);
    HRESULT put_FileScreenFlags(int fileScreenFlags);
    HRESULT CreateAction(FsrmActionType actionType, IFsrmAction* action);
    HRESULT EnumActions(IFsrmCollection* actions);
}

@GUID("5F6325D3-CE88-4733-84C1-2D6AEFC5EA07")
interface IFsrmFileScreen : IFsrmFileScreenBase
{
    HRESULT get_Path(BSTR* path);
    HRESULT get_SourceTemplateName(BSTR* fileScreenTemplateName);
    HRESULT get_MatchesSourceTemplate(short* matches);
    HRESULT get_UserSid(BSTR* userSid);
    HRESULT get_UserAccount(BSTR* userAccount);
    HRESULT ApplyTemplate(BSTR fileScreenTemplateName);
}

@GUID("BEE7CE02-DF77-4515-9389-78F01C5AFC1A")
interface IFsrmFileScreenException : IFsrmObject
{
    HRESULT get_Path(BSTR* path);
    HRESULT get_AllowedFileGroups(IFsrmMutableCollection* allowList);
    HRESULT put_AllowedFileGroups(IFsrmMutableCollection allowList);
}

@GUID("FF4FA04E-5A94-4BDA-A3A0-D5B4D3C52EBA")
interface IFsrmFileScreenManager : IDispatch
{
    HRESULT get_ActionVariables(SAFEARRAY** variables);
    HRESULT get_ActionVariableDescriptions(SAFEARRAY** descriptions);
    HRESULT CreateFileScreen(BSTR path, IFsrmFileScreen* fileScreen);
    HRESULT GetFileScreen(BSTR path, IFsrmFileScreen* fileScreen);
    HRESULT EnumFileScreens(BSTR path, FsrmEnumOptions options, IFsrmCommittableCollection* fileScreens);
    HRESULT CreateFileScreenException(BSTR path, IFsrmFileScreenException* fileScreenException);
    HRESULT GetFileScreenException(BSTR path, IFsrmFileScreenException* fileScreenException);
    HRESULT EnumFileScreenExceptions(BSTR path, FsrmEnumOptions options, 
                                     IFsrmCommittableCollection* fileScreenExceptions);
    HRESULT CreateFileScreenCollection(IFsrmCommittableCollection* collection);
}

@GUID("205BEBF8-DD93-452A-95A6-32B566B35828")
interface IFsrmFileScreenTemplate : IFsrmFileScreenBase
{
    HRESULT get_Name(BSTR* name);
    HRESULT put_Name(BSTR name);
    HRESULT CopyTemplate(BSTR fileScreenTemplateName);
    HRESULT CommitAndUpdateDerived(FsrmCommitOptions commitOptions, FsrmTemplateApplyOptions applyOptions, 
                                   IFsrmDerivedObjectsResult* derivedObjectsResult);
}

@GUID("E1010359-3E5D-4ECD-9FE4-EF48622FDF30")
interface IFsrmFileScreenTemplateImported : IFsrmFileScreenTemplate
{
    HRESULT get_OverwriteOnCommit(short* overwrite);
    HRESULT put_OverwriteOnCommit(short overwrite);
}

@GUID("CFE36CBA-1949-4E74-A14F-F1D580CEAF13")
interface IFsrmFileScreenTemplateManager : IDispatch
{
    HRESULT CreateTemplate(IFsrmFileScreenTemplate* fileScreenTemplate);
    HRESULT GetTemplate(BSTR name, IFsrmFileScreenTemplate* fileScreenTemplate);
    HRESULT EnumTemplates(FsrmEnumOptions options, IFsrmCommittableCollection* fileScreenTemplates);
    HRESULT ExportTemplates(VARIANT* fileScreenTemplateNamesArray, BSTR* serializedFileScreenTemplates);
    HRESULT ImportTemplates(BSTR serializedFileScreenTemplates, VARIANT* fileScreenTemplateNamesArray, 
                            IFsrmCommittableCollection* fileScreenTemplates);
}

@GUID("27B899FE-6FFA-4481-A184-D3DAADE8A02B")
interface IFsrmReportManager : IDispatch
{
    HRESULT EnumReportJobs(FsrmEnumOptions options, IFsrmCollection* reportJobs);
    HRESULT CreateReportJob(IFsrmReportJob* reportJob);
    HRESULT GetReportJob(BSTR taskName, IFsrmReportJob* reportJob);
    HRESULT GetOutputDirectory(FsrmReportGenerationContext context, BSTR* path);
    HRESULT SetOutputDirectory(FsrmReportGenerationContext context, BSTR path);
    HRESULT IsFilterValidForReportType(FsrmReportType reportType, FsrmReportFilter filter, short* valid);
    HRESULT GetDefaultFilter(FsrmReportType reportType, FsrmReportFilter filter, VARIANT* filterValue);
    HRESULT SetDefaultFilter(FsrmReportType reportType, FsrmReportFilter filter, VARIANT filterValue);
    HRESULT GetReportSizeLimit(FsrmReportLimit limit, VARIANT* limitValue);
    HRESULT SetReportSizeLimit(FsrmReportLimit limit, VARIANT limitValue);
}

@GUID("38E87280-715C-4C7D-A280-EA1651A19FEF")
interface IFsrmReportJob : IFsrmObject
{
    HRESULT get_Task(BSTR* taskName);
    HRESULT put_Task(BSTR taskName);
    HRESULT get_NamespaceRoots(SAFEARRAY** namespaceRoots);
    HRESULT put_NamespaceRoots(SAFEARRAY* namespaceRoots);
    HRESULT get_Formats(SAFEARRAY** formats);
    HRESULT put_Formats(SAFEARRAY* formats);
    HRESULT get_MailTo(BSTR* mailTo);
    HRESULT put_MailTo(BSTR mailTo);
    HRESULT get_RunningStatus(FsrmReportRunningStatus* runningStatus);
    HRESULT get_LastRun(double* lastRun);
    HRESULT get_LastError(BSTR* lastError);
    HRESULT get_LastGeneratedInDirectory(BSTR* path);
    HRESULT EnumReports(IFsrmCollection* reports);
    HRESULT CreateReport(FsrmReportType reportType, IFsrmReport* report);
    HRESULT Run(FsrmReportGenerationContext context);
    HRESULT WaitForCompletion(int waitSeconds, short* completed);
    HRESULT Cancel();
}

@GUID("D8CC81D9-46B8-4FA4-BFA5-4AA9DEC9B638")
interface IFsrmReport : IDispatch
{
    HRESULT get_Type(FsrmReportType* reportType);
    HRESULT get_Name(BSTR* name);
    HRESULT put_Name(BSTR name);
    HRESULT get_Description(BSTR* description);
    HRESULT put_Description(BSTR description);
    HRESULT get_LastGeneratedFileNamePrefix(BSTR* prefix);
    HRESULT GetFilter(FsrmReportFilter filter, VARIANT* filterValue);
    HRESULT SetFilter(FsrmReportFilter filter, VARIANT filterValue);
    HRESULT Delete();
}

@GUID("6879CAF9-6617-4484-8719-71C3D8645F94")
interface IFsrmReportScheduler : IDispatch
{
    HRESULT VerifyNamespaces(VARIANT* namespacesSafeArray);
    HRESULT CreateScheduleTask(BSTR taskName, VARIANT* namespacesSafeArray, BSTR serializedTask);
    HRESULT ModifyScheduleTask(BSTR taskName, VARIANT* namespacesSafeArray, BSTR serializedTask);
    HRESULT DeleteScheduleTask(BSTR taskName);
}

@GUID("EE321ECB-D95E-48E9-907C-C7685A013235")
interface IFsrmFileManagementJobManager : IDispatch
{
    HRESULT get_ActionVariables(SAFEARRAY** variables);
    HRESULT get_ActionVariableDescriptions(SAFEARRAY** descriptions);
    HRESULT EnumFileManagementJobs(FsrmEnumOptions options, IFsrmCollection* fileManagementJobs);
    HRESULT CreateFileManagementJob(IFsrmFileManagementJob* fileManagementJob);
    HRESULT GetFileManagementJob(BSTR name, IFsrmFileManagementJob* fileManagementJob);
}

@GUID("0770687E-9F36-4D6F-8778-599D188461C9")
interface IFsrmFileManagementJob : IFsrmObject
{
    HRESULT get_Name(BSTR* name);
    HRESULT put_Name(BSTR name);
    HRESULT get_NamespaceRoots(SAFEARRAY** namespaceRoots);
    HRESULT put_NamespaceRoots(SAFEARRAY* namespaceRoots);
    HRESULT get_Enabled(short* enabled);
    HRESULT put_Enabled(short enabled);
    HRESULT get_OperationType(FsrmFileManagementType* operationType);
    HRESULT put_OperationType(FsrmFileManagementType operationType);
    HRESULT get_ExpirationDirectory(BSTR* expirationDirectory);
    HRESULT put_ExpirationDirectory(BSTR expirationDirectory);
    HRESULT get_CustomAction(IFsrmActionCommand* action);
    HRESULT get_Notifications(SAFEARRAY** notifications);
    HRESULT get_Logging(int* loggingFlags);
    HRESULT put_Logging(int loggingFlags);
    HRESULT get_ReportEnabled(short* reportEnabled);
    HRESULT put_ReportEnabled(short reportEnabled);
    HRESULT get_Formats(SAFEARRAY** formats);
    HRESULT put_Formats(SAFEARRAY* formats);
    HRESULT get_MailTo(BSTR* mailTo);
    HRESULT put_MailTo(BSTR mailTo);
    HRESULT get_DaysSinceFileCreated(int* daysSinceCreation);
    HRESULT put_DaysSinceFileCreated(int daysSinceCreation);
    HRESULT get_DaysSinceFileLastAccessed(int* daysSinceAccess);
    HRESULT put_DaysSinceFileLastAccessed(int daysSinceAccess);
    HRESULT get_DaysSinceFileLastModified(int* daysSinceModify);
    HRESULT put_DaysSinceFileLastModified(int daysSinceModify);
    HRESULT get_PropertyConditions(IFsrmCollection* propertyConditions);
    HRESULT get_FromDate(double* fromDate);
    HRESULT put_FromDate(double fromDate);
    HRESULT get_Task(BSTR* taskName);
    HRESULT put_Task(BSTR taskName);
    HRESULT get_Parameters(SAFEARRAY** parameters);
    HRESULT put_Parameters(SAFEARRAY* parameters);
    HRESULT get_RunningStatus(FsrmReportRunningStatus* runningStatus);
    HRESULT get_LastError(BSTR* lastError);
    HRESULT get_LastReportPathWithoutExtension(BSTR* path);
    HRESULT get_LastRun(double* lastRun);
    HRESULT get_FileNamePattern(BSTR* fileNamePattern);
    HRESULT put_FileNamePattern(BSTR fileNamePattern);
    HRESULT Run(FsrmReportGenerationContext context);
    HRESULT WaitForCompletion(int waitSeconds, short* completed);
    HRESULT Cancel();
    HRESULT AddNotification(int days);
    HRESULT DeleteNotification(int days);
    HRESULT ModifyNotification(int days, int newDays);
    HRESULT CreateNotificationAction(int days, FsrmActionType actionType, IFsrmAction* action);
    HRESULT EnumNotificationActions(int days, IFsrmCollection* actions);
    HRESULT CreatePropertyCondition(BSTR name, IFsrmPropertyCondition* propertyCondition);
    HRESULT CreateCustomAction(IFsrmActionCommand* customAction);
}

@GUID("326AF66F-2AC0-4F68-BF8C-4759F054FA29")
interface IFsrmPropertyCondition : IDispatch
{
    HRESULT get_Name(BSTR* name);
    HRESULT put_Name(BSTR name);
    HRESULT get_Type(FsrmPropertyConditionType* type);
    HRESULT put_Type(FsrmPropertyConditionType type);
    HRESULT get_Value(BSTR* value);
    HRESULT put_Value(BSTR value);
    HRESULT Delete();
}

@GUID("70684FFC-691A-4A1A-B922-97752E138CC1")
interface IFsrmFileCondition : IDispatch
{
    HRESULT get_Type(FsrmFileConditionType* pVal);
    HRESULT Delete();
}

@GUID("81926775-B981-4479-988F-DA171D627360")
interface IFsrmFileConditionProperty : IFsrmFileCondition
{
    HRESULT get_PropertyName(BSTR* pVal);
    HRESULT put_PropertyName(BSTR newVal);
    HRESULT get_PropertyId(FsrmFileSystemPropertyId* pVal);
    HRESULT put_PropertyId(FsrmFileSystemPropertyId newVal);
    HRESULT get_Operator(FsrmPropertyConditionType* pVal);
    HRESULT put_Operator(FsrmPropertyConditionType newVal);
    HRESULT get_ValueType(FsrmPropertyValueType* pVal);
    HRESULT put_ValueType(FsrmPropertyValueType newVal);
    HRESULT get_Value(VARIANT* pVal);
    HRESULT put_Value(VARIANT newVal);
}

@GUID("EDE0150F-E9A3-419C-877C-01FE5D24C5D3")
interface IFsrmPropertyDefinition : IFsrmObject
{
    HRESULT get_Name(BSTR* name);
    HRESULT put_Name(BSTR name);
    HRESULT get_Type(FsrmPropertyDefinitionType* type);
    HRESULT put_Type(FsrmPropertyDefinitionType type);
    HRESULT get_PossibleValues(SAFEARRAY** possibleValues);
    HRESULT put_PossibleValues(SAFEARRAY* possibleValues);
    HRESULT get_ValueDescriptions(SAFEARRAY** valueDescriptions);
    HRESULT put_ValueDescriptions(SAFEARRAY* valueDescriptions);
    HRESULT get_Parameters(SAFEARRAY** parameters);
    HRESULT put_Parameters(SAFEARRAY* parameters);
}

@GUID("47782152-D16C-4229-B4E1-0DDFE308B9F6")
interface IFsrmPropertyDefinition2 : IFsrmPropertyDefinition
{
    HRESULT get_PropertyDefinitionFlags(int* propertyDefinitionFlags);
    HRESULT get_DisplayName(BSTR* name);
    HRESULT put_DisplayName(BSTR name);
    HRESULT get_AppliesTo(int* appliesTo);
    HRESULT get_ValueDefinitions(IFsrmCollection* valueDefinitions);
}

@GUID("E946D148-BD67-4178-8E22-1C44925ED710")
interface IFsrmPropertyDefinitionValue : IDispatch
{
    HRESULT get_Name(BSTR* name);
    HRESULT get_DisplayName(BSTR* displayName);
    HRESULT get_Description(BSTR* description);
    HRESULT get_UniqueID(BSTR* uniqueID);
}

@GUID("4A73FEE4-4102-4FCC-9FFB-38614F9EE768")
interface IFsrmProperty : IDispatch
{
    HRESULT get_Name(BSTR* name);
    HRESULT get_Value(BSTR* value);
    HRESULT get_Sources(SAFEARRAY** sources);
    HRESULT get_PropertyFlags(int* flags);
}

@GUID("CB0DF960-16F5-4495-9079-3F9360D831DF")
interface IFsrmRule : IFsrmObject
{
    HRESULT get_Name(BSTR* name);
    HRESULT put_Name(BSTR name);
    HRESULT get_RuleType(FsrmRuleType* ruleType);
    HRESULT get_ModuleDefinitionName(BSTR* moduleDefinitionName);
    HRESULT put_ModuleDefinitionName(BSTR moduleDefinitionName);
    HRESULT get_NamespaceRoots(SAFEARRAY** namespaceRoots);
    HRESULT put_NamespaceRoots(SAFEARRAY* namespaceRoots);
    HRESULT get_RuleFlags(int* ruleFlags);
    HRESULT put_RuleFlags(int ruleFlags);
    HRESULT get_Parameters(SAFEARRAY** parameters);
    HRESULT put_Parameters(SAFEARRAY* parameters);
    HRESULT get_LastModified(VARIANT* lastModified);
}

@GUID("AFC052C2-5315-45AB-841B-C6DB0E120148")
interface IFsrmClassificationRule : IFsrmRule
{
    HRESULT get_ExecutionOption(FsrmExecutionOption* executionOption);
    HRESULT put_ExecutionOption(FsrmExecutionOption executionOption);
    HRESULT get_PropertyAffected(BSTR* property);
    HRESULT put_PropertyAffected(BSTR property);
    HRESULT get_Value(BSTR* value);
    HRESULT put_Value(BSTR value);
}

@GUID("515C1277-2C81-440E-8FCF-367921ED4F59")
interface IFsrmPipelineModuleDefinition : IFsrmObject
{
    HRESULT get_ModuleClsid(BSTR* moduleClsid);
    HRESULT put_ModuleClsid(BSTR moduleClsid);
    HRESULT get_Name(BSTR* name);
    HRESULT put_Name(BSTR name);
    HRESULT get_Company(BSTR* company);
    HRESULT put_Company(BSTR company);
    HRESULT get_Version(BSTR* version_);
    HRESULT put_Version(BSTR version_);
    HRESULT get_ModuleType(FsrmPipelineModuleType* moduleType);
    HRESULT get_Enabled(short* enabled);
    HRESULT put_Enabled(short enabled);
    HRESULT get_NeedsFileContent(short* needsFileContent);
    HRESULT put_NeedsFileContent(short needsFileContent);
    HRESULT get_Account(FsrmAccountType* retrievalAccount);
    HRESULT put_Account(FsrmAccountType retrievalAccount);
    HRESULT get_SupportedExtensions(SAFEARRAY** supportedExtensions);
    HRESULT put_SupportedExtensions(SAFEARRAY* supportedExtensions);
    HRESULT get_Parameters(SAFEARRAY** parameters);
    HRESULT put_Parameters(SAFEARRAY* parameters);
}

@GUID("BB36EA26-6318-4B8C-8592-F72DD602E7A5")
interface IFsrmClassifierModuleDefinition : IFsrmPipelineModuleDefinition
{
    HRESULT get_PropertiesAffected(SAFEARRAY** propertiesAffected);
    HRESULT put_PropertiesAffected(SAFEARRAY* propertiesAffected);
    HRESULT get_PropertiesUsed(SAFEARRAY** propertiesUsed);
    HRESULT put_PropertiesUsed(SAFEARRAY* propertiesUsed);
    HRESULT get_NeedsExplicitValue(short* needsExplicitValue);
    HRESULT put_NeedsExplicitValue(short needsExplicitValue);
}

@GUID("15A81350-497D-4ABA-80E9-D4DBCC5521FE")
interface IFsrmStorageModuleDefinition : IFsrmPipelineModuleDefinition
{
    HRESULT get_Capabilities(FsrmStorageModuleCaps* capabilities);
    HRESULT put_Capabilities(FsrmStorageModuleCaps capabilities);
    HRESULT get_StorageType(FsrmStorageModuleType* storageType);
    HRESULT put_StorageType(FsrmStorageModuleType storageType);
    HRESULT get_UpdatesFileContent(short* updatesFileContent);
    HRESULT put_UpdatesFileContent(short updatesFileContent);
}

@GUID("D2DC89DA-EE91-48A0-85D8-CC72A56F7D04")
interface IFsrmClassificationManager : IDispatch
{
    HRESULT get_ClassificationReportFormats(SAFEARRAY** formats);
    HRESULT put_ClassificationReportFormats(SAFEARRAY* formats);
    HRESULT get_Logging(int* logging);
    HRESULT put_Logging(int logging);
    HRESULT get_ClassificationReportMailTo(BSTR* mailTo);
    HRESULT put_ClassificationReportMailTo(BSTR mailTo);
    HRESULT get_ClassificationReportEnabled(short* reportEnabled);
    HRESULT put_ClassificationReportEnabled(short reportEnabled);
    HRESULT get_ClassificationLastReportPathWithoutExtension(BSTR* lastReportPath);
    HRESULT get_ClassificationLastError(BSTR* lastError);
    HRESULT get_ClassificationRunningStatus(FsrmReportRunningStatus* runningStatus);
    HRESULT EnumPropertyDefinitions(FsrmEnumOptions options, IFsrmCollection* propertyDefinitions);
    HRESULT CreatePropertyDefinition(IFsrmPropertyDefinition* propertyDefinition);
    HRESULT GetPropertyDefinition(BSTR propertyName, IFsrmPropertyDefinition* propertyDefinition);
    HRESULT EnumRules(FsrmRuleType ruleType, FsrmEnumOptions options, IFsrmCollection* Rules);
    HRESULT CreateRule(FsrmRuleType ruleType, IFsrmRule* Rule);
    HRESULT GetRule(BSTR ruleName, FsrmRuleType ruleType, IFsrmRule* Rule);
    HRESULT EnumModuleDefinitions(FsrmPipelineModuleType moduleType, FsrmEnumOptions options, 
                                  IFsrmCollection* moduleDefinitions);
    HRESULT CreateModuleDefinition(FsrmPipelineModuleType moduleType, 
                                   IFsrmPipelineModuleDefinition* moduleDefinition);
    HRESULT GetModuleDefinition(BSTR moduleName, FsrmPipelineModuleType moduleType, 
                                IFsrmPipelineModuleDefinition* moduleDefinition);
    HRESULT RunClassification(FsrmReportGenerationContext context, BSTR reserved);
    HRESULT WaitForClassificationCompletion(int waitSeconds, short* completed);
    HRESULT CancelClassification();
    HRESULT EnumFileProperties(BSTR filePath, FsrmGetFilePropertyOptions options, IFsrmCollection* fileProperties);
    HRESULT GetFileProperty(BSTR filePath, BSTR propertyName, FsrmGetFilePropertyOptions options, 
                            IFsrmProperty* property);
    HRESULT SetFileProperty(BSTR filePath, BSTR propertyName, BSTR propertyValue);
    HRESULT ClearFileProperty(BSTR filePath, BSTR property);
}

@GUID("0004C1C9-127E-4765-BA07-6A3147BCA112")
interface IFsrmClassificationManager2 : IFsrmClassificationManager
{
    HRESULT ClassifyFiles(SAFEARRAY* filePaths, SAFEARRAY* propertyNames, SAFEARRAY* propertyValues, 
                          FsrmGetFilePropertyOptions options);
}

@GUID("774589D1-D300-4F7A-9A24-F7B766800250")
interface IFsrmPropertyBag : IDispatch
{
    HRESULT get_Name(BSTR* name);
    HRESULT get_RelativePath(BSTR* path);
    HRESULT get_VolumeName(BSTR* volumeName);
    HRESULT get_RelativeNamespaceRoot(BSTR* relativeNamespaceRoot);
    HRESULT get_VolumeIndex(uint* volumeId);
    HRESULT get_FileId(VARIANT* fileId);
    HRESULT get_ParentDirectoryId(VARIANT* parentDirectoryId);
    HRESULT get_Size(VARIANT* size);
    HRESULT get_SizeAllocated(VARIANT* sizeAllocated);
    HRESULT get_CreationTime(VARIANT* creationTime);
    HRESULT get_LastAccessTime(VARIANT* lastAccessTime);
    HRESULT get_LastModificationTime(VARIANT* lastModificationTime);
    HRESULT get_Attributes(uint* attributes);
    HRESULT get_OwnerSid(BSTR* ownerSid);
    HRESULT get_FilePropertyNames(SAFEARRAY** filePropertyNames);
    HRESULT get_Messages(SAFEARRAY** messages);
    HRESULT get_PropertyBagFlags(uint* flags);
    HRESULT GetFileProperty(BSTR name, IFsrmProperty* fileProperty);
    HRESULT SetFileProperty(BSTR name, BSTR value);
    HRESULT AddMessage(BSTR message);
    HRESULT GetFileStreamInterface(FsrmFileStreamingMode accessMode, FsrmFileStreamingInterfaceType interfaceType, 
                                   VARIANT* pStreamInterface);
}

@GUID("0E46BDBD-2402-4FED-9C30-9266E6EB2CC9")
interface IFsrmPropertyBag2 : IFsrmPropertyBag
{
    HRESULT GetFieldValue(FsrmPropertyBagField field, VARIANT* value);
    HRESULT GetUntrustedInFileProperties(IFsrmCollection* props);
}

@GUID("B7907906-2B02-4CB5-84A9-FDF54613D6CD")
interface IFsrmPipelineModuleImplementation : IDispatch
{
    HRESULT OnLoad(IFsrmPipelineModuleDefinition moduleDefinition, IFsrmPipelineModuleConnector* moduleConnector);
    HRESULT OnUnload();
}

@GUID("4C968FC6-6EDB-4051-9C18-73B7291AE106")
interface IFsrmClassifierModuleImplementation : IFsrmPipelineModuleImplementation
{
    HRESULT get_LastModified(VARIANT* lastModified);
    HRESULT UseRulesAndDefinitions(IFsrmCollection rules, IFsrmCollection propertyDefinitions);
    HRESULT OnBeginFile(IFsrmPropertyBag propertyBag, SAFEARRAY* arrayRuleIds);
    HRESULT DoesPropertyValueApply(BSTR property, BSTR value, short* applyValue, GUID idRule, GUID idPropDef);
    HRESULT GetPropertyValueToApply(BSTR property, BSTR* value, GUID idRule, GUID idPropDef);
    HRESULT OnEndFile();
}

@GUID("0AF4A0DA-895A-4E50-8712-A96724BCEC64")
interface IFsrmStorageModuleImplementation : IFsrmPipelineModuleImplementation
{
    HRESULT UseDefinitions(IFsrmCollection propertyDefinitions);
    HRESULT LoadProperties(IFsrmPropertyBag propertyBag);
    HRESULT SaveProperties(IFsrmPropertyBag propertyBag);
}

@GUID("C16014F3-9AA1-46B3-B0A7-AB146EB205F2")
interface IFsrmPipelineModuleConnector : IDispatch
{
    HRESULT get_ModuleImplementation(IFsrmPipelineModuleImplementation* pipelineModuleImplementation);
    HRESULT get_ModuleName(BSTR* userName);
    HRESULT get_HostingUserAccount(BSTR* userAccount);
    HRESULT get_HostingProcessPid(int* pid);
    HRESULT Bind(IFsrmPipelineModuleDefinition moduleDefinition, 
                 IFsrmPipelineModuleImplementation moduleImplementation);
}

@GUID("26942DB0-DABF-41D8-BBDD-B129A9F70424")
interface DIFsrmClassificationEvents : IDispatch
{
}


// GUIDs

const GUID CLSID_AdSyncTask                        = GUIDOF!AdSyncTask;
const GUID CLSID_FsrmAccessDeniedRemediationClient = GUIDOF!FsrmAccessDeniedRemediationClient;
const GUID CLSID_FsrmClassificationManager         = GUIDOF!FsrmClassificationManager;
const GUID CLSID_FsrmExportImport                  = GUIDOF!FsrmExportImport;
const GUID CLSID_FsrmFileGroupManager              = GUIDOF!FsrmFileGroupManager;
const GUID CLSID_FsrmFileManagementJobManager      = GUIDOF!FsrmFileManagementJobManager;
const GUID CLSID_FsrmFileScreenManager             = GUIDOF!FsrmFileScreenManager;
const GUID CLSID_FsrmFileScreenTemplateManager     = GUIDOF!FsrmFileScreenTemplateManager;
const GUID CLSID_FsrmPathMapper                    = GUIDOF!FsrmPathMapper;
const GUID CLSID_FsrmPipelineModuleConnector       = GUIDOF!FsrmPipelineModuleConnector;
const GUID CLSID_FsrmQuotaManager                  = GUIDOF!FsrmQuotaManager;
const GUID CLSID_FsrmQuotaTemplateManager          = GUIDOF!FsrmQuotaTemplateManager;
const GUID CLSID_FsrmReportManager                 = GUIDOF!FsrmReportManager;
const GUID CLSID_FsrmReportScheduler               = GUIDOF!FsrmReportScheduler;
const GUID CLSID_FsrmSetting                       = GUIDOF!FsrmSetting;

const GUID IID_DIFsrmClassificationEvents          = GUIDOF!DIFsrmClassificationEvents;
const GUID IID_IFsrmAccessDeniedRemediationClient  = GUIDOF!IFsrmAccessDeniedRemediationClient;
const GUID IID_IFsrmAction                         = GUIDOF!IFsrmAction;
const GUID IID_IFsrmActionCommand                  = GUIDOF!IFsrmActionCommand;
const GUID IID_IFsrmActionEmail                    = GUIDOF!IFsrmActionEmail;
const GUID IID_IFsrmActionEmail2                   = GUIDOF!IFsrmActionEmail2;
const GUID IID_IFsrmActionEventLog                 = GUIDOF!IFsrmActionEventLog;
const GUID IID_IFsrmActionReport                   = GUIDOF!IFsrmActionReport;
const GUID IID_IFsrmAutoApplyQuota                 = GUIDOF!IFsrmAutoApplyQuota;
const GUID IID_IFsrmClassificationManager          = GUIDOF!IFsrmClassificationManager;
const GUID IID_IFsrmClassificationManager2         = GUIDOF!IFsrmClassificationManager2;
const GUID IID_IFsrmClassificationRule             = GUIDOF!IFsrmClassificationRule;
const GUID IID_IFsrmClassifierModuleDefinition     = GUIDOF!IFsrmClassifierModuleDefinition;
const GUID IID_IFsrmClassifierModuleImplementation = GUIDOF!IFsrmClassifierModuleImplementation;
const GUID IID_IFsrmCollection                     = GUIDOF!IFsrmCollection;
const GUID IID_IFsrmCommittableCollection          = GUIDOF!IFsrmCommittableCollection;
const GUID IID_IFsrmDerivedObjectsResult           = GUIDOF!IFsrmDerivedObjectsResult;
const GUID IID_IFsrmExportImport                   = GUIDOF!IFsrmExportImport;
const GUID IID_IFsrmFileCondition                  = GUIDOF!IFsrmFileCondition;
const GUID IID_IFsrmFileConditionProperty          = GUIDOF!IFsrmFileConditionProperty;
const GUID IID_IFsrmFileGroup                      = GUIDOF!IFsrmFileGroup;
const GUID IID_IFsrmFileGroupImported              = GUIDOF!IFsrmFileGroupImported;
const GUID IID_IFsrmFileGroupManager               = GUIDOF!IFsrmFileGroupManager;
const GUID IID_IFsrmFileManagementJob              = GUIDOF!IFsrmFileManagementJob;
const GUID IID_IFsrmFileManagementJobManager       = GUIDOF!IFsrmFileManagementJobManager;
const GUID IID_IFsrmFileScreen                     = GUIDOF!IFsrmFileScreen;
const GUID IID_IFsrmFileScreenBase                 = GUIDOF!IFsrmFileScreenBase;
const GUID IID_IFsrmFileScreenException            = GUIDOF!IFsrmFileScreenException;
const GUID IID_IFsrmFileScreenManager              = GUIDOF!IFsrmFileScreenManager;
const GUID IID_IFsrmFileScreenTemplate             = GUIDOF!IFsrmFileScreenTemplate;
const GUID IID_IFsrmFileScreenTemplateImported     = GUIDOF!IFsrmFileScreenTemplateImported;
const GUID IID_IFsrmFileScreenTemplateManager      = GUIDOF!IFsrmFileScreenTemplateManager;
const GUID IID_IFsrmMutableCollection              = GUIDOF!IFsrmMutableCollection;
const GUID IID_IFsrmObject                         = GUIDOF!IFsrmObject;
const GUID IID_IFsrmPathMapper                     = GUIDOF!IFsrmPathMapper;
const GUID IID_IFsrmPipelineModuleConnector        = GUIDOF!IFsrmPipelineModuleConnector;
const GUID IID_IFsrmPipelineModuleDefinition       = GUIDOF!IFsrmPipelineModuleDefinition;
const GUID IID_IFsrmPipelineModuleImplementation   = GUIDOF!IFsrmPipelineModuleImplementation;
const GUID IID_IFsrmProperty                       = GUIDOF!IFsrmProperty;
const GUID IID_IFsrmPropertyBag                    = GUIDOF!IFsrmPropertyBag;
const GUID IID_IFsrmPropertyBag2                   = GUIDOF!IFsrmPropertyBag2;
const GUID IID_IFsrmPropertyCondition              = GUIDOF!IFsrmPropertyCondition;
const GUID IID_IFsrmPropertyDefinition             = GUIDOF!IFsrmPropertyDefinition;
const GUID IID_IFsrmPropertyDefinition2            = GUIDOF!IFsrmPropertyDefinition2;
const GUID IID_IFsrmPropertyDefinitionValue        = GUIDOF!IFsrmPropertyDefinitionValue;
const GUID IID_IFsrmQuota                          = GUIDOF!IFsrmQuota;
const GUID IID_IFsrmQuotaBase                      = GUIDOF!IFsrmQuotaBase;
const GUID IID_IFsrmQuotaManager                   = GUIDOF!IFsrmQuotaManager;
const GUID IID_IFsrmQuotaManagerEx                 = GUIDOF!IFsrmQuotaManagerEx;
const GUID IID_IFsrmQuotaObject                    = GUIDOF!IFsrmQuotaObject;
const GUID IID_IFsrmQuotaTemplate                  = GUIDOF!IFsrmQuotaTemplate;
const GUID IID_IFsrmQuotaTemplateImported          = GUIDOF!IFsrmQuotaTemplateImported;
const GUID IID_IFsrmQuotaTemplateManager           = GUIDOF!IFsrmQuotaTemplateManager;
const GUID IID_IFsrmReport                         = GUIDOF!IFsrmReport;
const GUID IID_IFsrmReportJob                      = GUIDOF!IFsrmReportJob;
const GUID IID_IFsrmReportManager                  = GUIDOF!IFsrmReportManager;
const GUID IID_IFsrmReportScheduler                = GUIDOF!IFsrmReportScheduler;
const GUID IID_IFsrmRule                           = GUIDOF!IFsrmRule;
const GUID IID_IFsrmSetting                        = GUIDOF!IFsrmSetting;
const GUID IID_IFsrmStorageModuleDefinition        = GUIDOF!IFsrmStorageModuleDefinition;
const GUID IID_IFsrmStorageModuleImplementation    = GUIDOF!IFsrmStorageModuleImplementation;
