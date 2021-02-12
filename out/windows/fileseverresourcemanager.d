module windows.fileseverresourcemanager;

public import system;
public import windows.automation;
public import windows.com;

extern(Windows):

enum FsrmQuotaFlags
{
    FsrmQuotaFlags_Enforce = 256,
    FsrmQuotaFlags_Disable = 512,
    FsrmQuotaFlags_StatusIncomplete = 65536,
    FsrmQuotaFlags_StatusRebuilding = 131072,
}

enum FsrmFileScreenFlags
{
    FsrmFileScreenFlags_Enforce = 1,
}

enum FsrmCollectionState
{
    FsrmCollectionState_Fetching = 1,
    FsrmCollectionState_Committing = 2,
    FsrmCollectionState_Complete = 3,
    FsrmCollectionState_Cancelled = 4,
}

enum FsrmEnumOptions
{
    FsrmEnumOptions_None = 0,
    FsrmEnumOptions_Asynchronous = 1,
    FsrmEnumOptions_CheckRecycleBin = 2,
    FsrmEnumOptions_IncludeClusterNodes = 4,
    FsrmEnumOptions_IncludeDeprecatedObjects = 8,
}

enum FsrmCommitOptions
{
    FsrmCommitOptions_None = 0,
    FsrmCommitOptions_Asynchronous = 1,
}

enum FsrmTemplateApplyOptions
{
    FsrmTemplateApplyOptions_ApplyToDerivedMatching = 1,
    FsrmTemplateApplyOptions_ApplyToDerivedAll = 2,
}

enum FsrmActionType
{
    FsrmActionType_Unknown = 0,
    FsrmActionType_EventLog = 1,
    FsrmActionType_Email = 2,
    FsrmActionType_Command = 3,
    FsrmActionType_Report = 4,
}

enum FsrmEventType
{
    FsrmEventType_Unknown = 0,
    FsrmEventType_Information = 1,
    FsrmEventType_Warning = 2,
    FsrmEventType_Error = 3,
}

enum FsrmAccountType
{
    FsrmAccountType_Unknown = 0,
    FsrmAccountType_NetworkService = 1,
    FsrmAccountType_LocalService = 2,
    FsrmAccountType_LocalSystem = 3,
    FsrmAccountType_InProc = 4,
    FsrmAccountType_External = 5,
    FsrmAccountType_Automatic = 500,
}

enum FsrmReportType
{
    FsrmReportType_Unknown = 0,
    FsrmReportType_LargeFiles = 1,
    FsrmReportType_FilesByType = 2,
    FsrmReportType_LeastRecentlyAccessed = 3,
    FsrmReportType_MostRecentlyAccessed = 4,
    FsrmReportType_QuotaUsage = 5,
    FsrmReportType_FilesByOwner = 6,
    FsrmReportType_ExportReport = 7,
    FsrmReportType_DuplicateFiles = 8,
    FsrmReportType_FileScreenAudit = 9,
    FsrmReportType_FilesByProperty = 10,
    FsrmReportType_AutomaticClassification = 11,
    FsrmReportType_Expiration = 12,
    FsrmReportType_FoldersByProperty = 13,
}

enum FsrmReportFormat
{
    FsrmReportFormat_Unknown = 0,
    FsrmReportFormat_DHtml = 1,
    FsrmReportFormat_Html = 2,
    FsrmReportFormat_Txt = 3,
    FsrmReportFormat_Csv = 4,
    FsrmReportFormat_Xml = 5,
}

enum FsrmReportRunningStatus
{
    FsrmReportRunningStatus_Unknown = 0,
    FsrmReportRunningStatus_NotRunning = 1,
    FsrmReportRunningStatus_Queued = 2,
    FsrmReportRunningStatus_Running = 3,
}

enum FsrmReportGenerationContext
{
    FsrmReportGenerationContext_Undefined = 1,
    FsrmReportGenerationContext_ScheduledReport = 2,
    FsrmReportGenerationContext_InteractiveReport = 3,
    FsrmReportGenerationContext_IncidentReport = 4,
}

enum FsrmReportFilter
{
    FsrmReportFilter_MinSize = 1,
    FsrmReportFilter_MinAgeDays = 2,
    FsrmReportFilter_MaxAgeDays = 3,
    FsrmReportFilter_MinQuotaUsage = 4,
    FsrmReportFilter_FileGroups = 5,
    FsrmReportFilter_Owners = 6,
    FsrmReportFilter_NamePattern = 7,
    FsrmReportFilter_Property = 8,
}

enum FsrmReportLimit
{
    FsrmReportLimit_MaxFiles = 1,
    FsrmReportLimit_MaxFileGroups = 2,
    FsrmReportLimit_MaxOwners = 3,
    FsrmReportLimit_MaxFilesPerFileGroup = 4,
    FsrmReportLimit_MaxFilesPerOwner = 5,
    FsrmReportLimit_MaxFilesPerDuplGroup = 6,
    FsrmReportLimit_MaxDuplicateGroups = 7,
    FsrmReportLimit_MaxQuotas = 8,
    FsrmReportLimit_MaxFileScreenEvents = 9,
    FsrmReportLimit_MaxPropertyValues = 10,
    FsrmReportLimit_MaxFilesPerPropertyValue = 11,
    FsrmReportLimit_MaxFolders = 12,
}

enum FsrmPropertyDefinitionType
{
    FsrmPropertyDefinitionType_Unknown = 0,
    FsrmPropertyDefinitionType_OrderedList = 1,
    FsrmPropertyDefinitionType_MultiChoiceList = 2,
    FsrmPropertyDefinitionType_SingleChoiceList = 3,
    FsrmPropertyDefinitionType_String = 4,
    FsrmPropertyDefinitionType_MultiString = 5,
    FsrmPropertyDefinitionType_Int = 6,
    FsrmPropertyDefinitionType_Bool = 7,
    FsrmPropertyDefinitionType_Date = 8,
}

enum FsrmPropertyDefinitionFlags
{
    FsrmPropertyDefinitionFlags_Global = 1,
    FsrmPropertyDefinitionFlags_Deprecated = 2,
    FsrmPropertyDefinitionFlags_Secure = 4,
}

enum FsrmPropertyDefinitionAppliesTo
{
    FsrmPropertyDefinitionAppliesTo_Files = 1,
    FsrmPropertyDefinitionAppliesTo_Folders = 2,
}

enum FsrmRuleType
{
    FsrmRuleType_Unknown = 0,
    FsrmRuleType_Classification = 1,
    FsrmRuleType_Generic = 2,
}

enum FsrmRuleFlags
{
    FsrmRuleFlags_Disabled = 256,
    FsrmRuleFlags_ClearAutomaticallyClassifiedProperty = 1024,
    FsrmRuleFlags_ClearManuallyClassifiedProperty = 2048,
    FsrmRuleFlags_Invalid = 4096,
}

enum FsrmClassificationLoggingFlags
{
    FsrmClassificationLoggingFlags_None = 0,
    FsrmClassificationLoggingFlags_ClassificationsInLogFile = 1,
    FsrmClassificationLoggingFlags_ErrorsInLogFile = 2,
    FsrmClassificationLoggingFlags_ClassificationsInSystemLog = 4,
    FsrmClassificationLoggingFlags_ErrorsInSystemLog = 8,
}

enum FsrmExecutionOption
{
    FsrmExecutionOption_Unknown = 0,
    FsrmExecutionOption_EvaluateUnset = 1,
    FsrmExecutionOption_ReEvaluate_ConsiderExistingValue = 2,
    FsrmExecutionOption_ReEvaluate_IgnoreExistingValue = 3,
}

enum FsrmStorageModuleCaps
{
    FsrmStorageModuleCaps_Unknown = 0,
    FsrmStorageModuleCaps_CanGet = 1,
    FsrmStorageModuleCaps_CanSet = 2,
    FsrmStorageModuleCaps_CanHandleDirectories = 4,
    FsrmStorageModuleCaps_CanHandleFiles = 8,
}

enum FsrmStorageModuleType
{
    FsrmStorageModuleType_Unknown = 0,
    FsrmStorageModuleType_Cache = 1,
    FsrmStorageModuleType_InFile = 2,
    FsrmStorageModuleType_Database = 3,
    FsrmStorageModuleType_System = 100,
}

enum FsrmPropertyBagFlags
{
    FsrmPropertyBagFlags_UpdatedByClassifier = 1,
    FsrmPropertyBagFlags_FailedLoadingProperties = 2,
    FsrmPropertyBagFlags_FailedSavingProperties = 4,
    FsrmPropertyBagFlags_FailedClassifyingProperties = 8,
}

enum FsrmPropertyBagField
{
    FsrmPropertyBagField_AccessVolume = 0,
    FsrmPropertyBagField_VolumeGuidName = 1,
}

enum FsrmPropertyFlags
{
    FsrmPropertyFlags_None = 0,
    FsrmPropertyFlags_Orphaned = 1,
    FsrmPropertyFlags_RetrievedFromCache = 2,
    FsrmPropertyFlags_RetrievedFromStorage = 4,
    FsrmPropertyFlags_SetByClassifier = 8,
    FsrmPropertyFlags_Deleted = 16,
    FsrmPropertyFlags_Reclassified = 32,
    FsrmPropertyFlags_AggregationFailed = 64,
    FsrmPropertyFlags_Existing = 128,
    FsrmPropertyFlags_FailedLoadingProperties = 256,
    FsrmPropertyFlags_FailedClassifyingProperties = 512,
    FsrmPropertyFlags_FailedSavingProperties = 1024,
    FsrmPropertyFlags_Secure = 2048,
    FsrmPropertyFlags_PolicyDerived = 4096,
    FsrmPropertyFlags_Inherited = 8192,
    FsrmPropertyFlags_Manual = 16384,
    FsrmPropertyFlags_ExplicitValueDeleted = 32768,
    FsrmPropertyFlags_PropertyDeletedFromClear = 65536,
    FsrmPropertyFlags_PropertySourceMask = 14,
    FsrmPropertyFlags_PersistentMask = 20480,
}

enum FsrmPipelineModuleType
{
    FsrmPipelineModuleType_Unknown = 0,
    FsrmPipelineModuleType_Storage = 1,
    FsrmPipelineModuleType_Classifier = 2,
}

enum FsrmGetFilePropertyOptions
{
    FsrmGetFilePropertyOptions_None = 0,
    FsrmGetFilePropertyOptions_NoRuleEvaluation = 1,
    FsrmGetFilePropertyOptions_Persistent = 2,
    FsrmGetFilePropertyOptions_FailOnPersistErrors = 4,
    FsrmGetFilePropertyOptions_SkipOrphaned = 8,
}

enum FsrmFileManagementType
{
    FsrmFileManagementType_Unknown = 0,
    FsrmFileManagementType_Expiration = 1,
    FsrmFileManagementType_Custom = 2,
    FsrmFileManagementType_Rms = 3,
}

enum FsrmFileManagementLoggingFlags
{
    FsrmFileManagementLoggingFlags_None = 0,
    FsrmFileManagementLoggingFlags_Error = 1,
    FsrmFileManagementLoggingFlags_Information = 2,
    FsrmFileManagementLoggingFlags_Audit = 4,
}

enum FsrmPropertyConditionType
{
    FsrmPropertyConditionType_Unknown = 0,
    FsrmPropertyConditionType_Equal = 1,
    FsrmPropertyConditionType_NotEqual = 2,
    FsrmPropertyConditionType_GreaterThan = 3,
    FsrmPropertyConditionType_LessThan = 4,
    FsrmPropertyConditionType_Contain = 5,
    FsrmPropertyConditionType_Exist = 6,
    FsrmPropertyConditionType_NotExist = 7,
    FsrmPropertyConditionType_StartWith = 8,
    FsrmPropertyConditionType_EndWith = 9,
    FsrmPropertyConditionType_ContainedIn = 10,
    FsrmPropertyConditionType_PrefixOf = 11,
    FsrmPropertyConditionType_SuffixOf = 12,
    FsrmPropertyConditionType_MatchesPattern = 13,
}

enum FsrmFileStreamingMode
{
    FsrmFileStreamingMode_Unknown = 0,
    FsrmFileStreamingMode_Read = 1,
    FsrmFileStreamingMode_Write = 2,
}

enum FsrmFileStreamingInterfaceType
{
    FsrmFileStreamingInterfaceType_Unknown = 0,
    FsrmFileStreamingInterfaceType_ILockBytes = 1,
    FsrmFileStreamingInterfaceType_IStream = 2,
}

enum FsrmFileConditionType
{
    FsrmFileConditionType_Unknown = 0,
    FsrmFileConditionType_Property = 1,
}

enum FsrmFileSystemPropertyId
{
    FsrmFileSystemPropertyId_Undefined = 0,
    FsrmFileSystemPropertyId_FileName = 1,
    FsrmFileSystemPropertyId_DateCreated = 2,
    FsrmFileSystemPropertyId_DateLastAccessed = 3,
    FsrmFileSystemPropertyId_DateLastModified = 4,
    FsrmFileSystemPropertyId_DateNow = 5,
}

enum FsrmPropertyValueType
{
    FsrmPropertyValueType_Undefined = 0,
    FsrmPropertyValueType_Literal = 1,
    FsrmPropertyValueType_DateOffset = 2,
}

enum AdrClientDisplayFlags
{
    AdrClientDisplayFlags_AllowEmailRequests = 1,
    AdrClientDisplayFlags_ShowDeviceTroubleshooting = 2,
}

enum AdrEmailFlags
{
    AdrEmailFlags_PutDataOwnerOnToLine = 1,
    AdrEmailFlags_PutAdminOnToLine = 2,
    AdrEmailFlags_IncludeDeviceClaims = 4,
    AdrEmailFlags_IncludeUserInfo = 8,
    AdrEmailFlags_GenerateEventLog = 16,
}

enum AdrClientErrorType
{
    AdrClientErrorType_Unknown = 0,
    AdrClientErrorType_AccessDenied = 1,
    AdrClientErrorType_FileNotFound = 2,
}

enum AdrClientFlags
{
    AdrClientFlags_None = 0,
    AdrClientFlags_FailForLocalPaths = 1,
    AdrClientFlags_FailIfNotSupportedByServer = 2,
    AdrClientFlags_FailIfNotDomainJoined = 4,
}

const GUID IID_IFsrmObject = {0x22BCEF93, 0x4A3F, 0x4183, [0x89, 0xF9, 0x2F, 0x8B, 0x8A, 0x62, 0x8A, 0xEE]};
@GUID(0x22BCEF93, 0x4A3F, 0x4183, [0x89, 0xF9, 0x2F, 0x8B, 0x8A, 0x62, 0x8A, 0xEE]);
interface IFsrmObject : IDispatch
{
    HRESULT get_Id(Guid* id);
    HRESULT get_Description(BSTR* description);
    HRESULT put_Description(BSTR description);
    HRESULT Delete();
    HRESULT Commit();
}

const GUID IID_IFsrmCollection = {0xF76FBF3B, 0x8DDD, 0x4B42, [0xB0, 0x5A, 0xCB, 0x1C, 0x3F, 0xF1, 0xFE, 0xE8]};
@GUID(0xF76FBF3B, 0x8DDD, 0x4B42, [0xB0, 0x5A, 0xCB, 0x1C, 0x3F, 0xF1, 0xFE, 0xE8]);
interface IFsrmCollection : IDispatch
{
    HRESULT get__NewEnum(IUnknown* unknown);
    HRESULT get_Item(int index, VARIANT* item);
    HRESULT get_Count(int* count);
    HRESULT get_State(FsrmCollectionState* state);
    HRESULT Cancel();
    HRESULT WaitForCompletion(int waitSeconds, short* completed);
    HRESULT GetById(Guid id, VARIANT* entry);
}

const GUID IID_IFsrmMutableCollection = {0x1BB617B8, 0x3886, 0x49DC, [0xAF, 0x82, 0xA6, 0xC9, 0x0F, 0xA3, 0x5D, 0xDA]};
@GUID(0x1BB617B8, 0x3886, 0x49DC, [0xAF, 0x82, 0xA6, 0xC9, 0x0F, 0xA3, 0x5D, 0xDA]);
interface IFsrmMutableCollection : IFsrmCollection
{
    HRESULT Add(VARIANT item);
    HRESULT Remove(int index);
    HRESULT RemoveById(Guid id);
    HRESULT Clone(IFsrmMutableCollection* collection);
}

const GUID IID_IFsrmCommittableCollection = {0x96DEB3B5, 0x8B91, 0x4A2A, [0x9D, 0x93, 0x80, 0xA3, 0x5D, 0x8A, 0xA8, 0x47]};
@GUID(0x96DEB3B5, 0x8B91, 0x4A2A, [0x9D, 0x93, 0x80, 0xA3, 0x5D, 0x8A, 0xA8, 0x47]);
interface IFsrmCommittableCollection : IFsrmMutableCollection
{
    HRESULT Commit(FsrmCommitOptions options, IFsrmCollection* results);
}

const GUID IID_IFsrmAction = {0x6CD6408A, 0xAE60, 0x463B, [0x9E, 0xF1, 0xE1, 0x17, 0x53, 0x4D, 0x69, 0xDC]};
@GUID(0x6CD6408A, 0xAE60, 0x463B, [0x9E, 0xF1, 0xE1, 0x17, 0x53, 0x4D, 0x69, 0xDC]);
interface IFsrmAction : IDispatch
{
    HRESULT get_Id(Guid* id);
    HRESULT get_ActionType(FsrmActionType* actionType);
    HRESULT get_RunLimitInterval(int* minutes);
    HRESULT put_RunLimitInterval(int minutes);
    HRESULT Delete();
}

const GUID IID_IFsrmActionEmail = {0xD646567D, 0x26AE, 0x4CAA, [0x9F, 0x84, 0x4E, 0x0A, 0xAD, 0x20, 0x7F, 0xCA]};
@GUID(0xD646567D, 0x26AE, 0x4CAA, [0x9F, 0x84, 0x4E, 0x0A, 0xAD, 0x20, 0x7F, 0xCA]);
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

const GUID IID_IFsrmActionEmail2 = {0x8276702F, 0x2532, 0x4839, [0x89, 0xBF, 0x48, 0x72, 0x60, 0x9A, 0x2E, 0xA4]};
@GUID(0x8276702F, 0x2532, 0x4839, [0x89, 0xBF, 0x48, 0x72, 0x60, 0x9A, 0x2E, 0xA4]);
interface IFsrmActionEmail2 : IFsrmActionEmail
{
    HRESULT get_AttachmentFileListSize(int* attachmentFileListSize);
    HRESULT put_AttachmentFileListSize(int attachmentFileListSize);
}

const GUID IID_IFsrmActionReport = {0x2DBE63C4, 0xB340, 0x48A0, [0xA5, 0xB0, 0x15, 0x8E, 0x07, 0xFC, 0x56, 0x7E]};
@GUID(0x2DBE63C4, 0xB340, 0x48A0, [0xA5, 0xB0, 0x15, 0x8E, 0x07, 0xFC, 0x56, 0x7E]);
interface IFsrmActionReport : IFsrmAction
{
    HRESULT get_ReportTypes(SAFEARRAY** reportTypes);
    HRESULT put_ReportTypes(SAFEARRAY* reportTypes);
    HRESULT get_MailTo(BSTR* mailTo);
    HRESULT put_MailTo(BSTR mailTo);
}

const GUID IID_IFsrmActionEventLog = {0x4C8F96C3, 0x5D94, 0x4F37, [0xA4, 0xF4, 0xF5, 0x6A, 0xB4, 0x63, 0x54, 0x6F]};
@GUID(0x4C8F96C3, 0x5D94, 0x4F37, [0xA4, 0xF4, 0xF5, 0x6A, 0xB4, 0x63, 0x54, 0x6F]);
interface IFsrmActionEventLog : IFsrmAction
{
    HRESULT get_EventType(FsrmEventType* eventType);
    HRESULT put_EventType(FsrmEventType eventType);
    HRESULT get_MessageText(BSTR* messageText);
    HRESULT put_MessageText(BSTR messageText);
}

const GUID IID_IFsrmActionCommand = {0x12937789, 0xE247, 0x4917, [0x9C, 0x20, 0xF3, 0xEE, 0x9C, 0x7E, 0xE7, 0x83]};
@GUID(0x12937789, 0xE247, 0x4917, [0x9C, 0x20, 0xF3, 0xEE, 0x9C, 0x7E, 0xE7, 0x83]);
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

const GUID IID_IFsrmSetting = {0xF411D4FD, 0x14BE, 0x4260, [0x8C, 0x40, 0x03, 0xB7, 0xC9, 0x5E, 0x60, 0x8A]};
@GUID(0xF411D4FD, 0x14BE, 0x4260, [0x8C, 0x40, 0x03, 0xB7, 0xC9, 0x5E, 0x60, 0x8A]);
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

const GUID IID_IFsrmPathMapper = {0x6F4DBFFF, 0x6920, 0x4821, [0xA6, 0xC3, 0xB7, 0xE9, 0x4C, 0x1F, 0xD6, 0x0C]};
@GUID(0x6F4DBFFF, 0x6920, 0x4821, [0xA6, 0xC3, 0xB7, 0xE9, 0x4C, 0x1F, 0xD6, 0x0C]);
interface IFsrmPathMapper : IDispatch
{
    HRESULT GetSharePathsForLocalPath(BSTR localPath, SAFEARRAY** sharePaths);
}

const GUID IID_IFsrmExportImport = {0xEFCB0AB1, 0x16C4, 0x4A79, [0x81, 0x2C, 0x72, 0x56, 0x14, 0xC3, 0x30, 0x6B]};
@GUID(0xEFCB0AB1, 0x16C4, 0x4A79, [0x81, 0x2C, 0x72, 0x56, 0x14, 0xC3, 0x30, 0x6B]);
interface IFsrmExportImport : IDispatch
{
    HRESULT ExportFileGroups(BSTR filePath, VARIANT* fileGroupNamesSafeArray, BSTR remoteHost);
    HRESULT ImportFileGroups(BSTR filePath, VARIANT* fileGroupNamesSafeArray, BSTR remoteHost, IFsrmCommittableCollection* fileGroups);
    HRESULT ExportFileScreenTemplates(BSTR filePath, VARIANT* templateNamesSafeArray, BSTR remoteHost);
    HRESULT ImportFileScreenTemplates(BSTR filePath, VARIANT* templateNamesSafeArray, BSTR remoteHost, IFsrmCommittableCollection* templates);
    HRESULT ExportQuotaTemplates(BSTR filePath, VARIANT* templateNamesSafeArray, BSTR remoteHost);
    HRESULT ImportQuotaTemplates(BSTR filePath, VARIANT* templateNamesSafeArray, BSTR remoteHost, IFsrmCommittableCollection* templates);
}

const GUID IID_IFsrmDerivedObjectsResult = {0x39322A2D, 0x38EE, 0x4D0D, [0x80, 0x95, 0x42, 0x1A, 0x80, 0x84, 0x9A, 0x82]};
@GUID(0x39322A2D, 0x38EE, 0x4D0D, [0x80, 0x95, 0x42, 0x1A, 0x80, 0x84, 0x9A, 0x82]);
interface IFsrmDerivedObjectsResult : IDispatch
{
    HRESULT get_DerivedObjects(IFsrmCollection* derivedObjects);
    HRESULT get_Results(IFsrmCollection* results);
}

const GUID IID_IFsrmAccessDeniedRemediationClient = {0x40002314, 0x590B, 0x45A5, [0x8E, 0x1B, 0x8C, 0x05, 0xDA, 0x52, 0x7E, 0x52]};
@GUID(0x40002314, 0x590B, 0x45A5, [0x8E, 0x1B, 0x8C, 0x05, 0xDA, 0x52, 0x7E, 0x52]);
interface IFsrmAccessDeniedRemediationClient : IDispatch
{
    HRESULT Show(uint parentWnd, BSTR accessPath, AdrClientErrorType errorType, int flags, BSTR windowTitle, BSTR windowMessage, int* result);
}

const GUID CLSID_FsrmSetting = {0xF556D708, 0x6D4D, 0x4594, [0x9C, 0x61, 0x7D, 0xBB, 0x0D, 0xAE, 0x2A, 0x46]};
@GUID(0xF556D708, 0x6D4D, 0x4594, [0x9C, 0x61, 0x7D, 0xBB, 0x0D, 0xAE, 0x2A, 0x46]);
struct FsrmSetting;

const GUID CLSID_FsrmPathMapper = {0xF3BE42BD, 0x8AC2, 0x409E, [0xBB, 0xD8, 0xFA, 0xF9, 0xB6, 0xB4, 0x1F, 0xEB]};
@GUID(0xF3BE42BD, 0x8AC2, 0x409E, [0xBB, 0xD8, 0xFA, 0xF9, 0xB6, 0xB4, 0x1F, 0xEB]);
struct FsrmPathMapper;

const GUID CLSID_FsrmExportImport = {0x1482DC37, 0xFAE9, 0x4787, [0x90, 0x25, 0x8C, 0xE4, 0xE0, 0x24, 0xAB, 0x56]};
@GUID(0x1482DC37, 0xFAE9, 0x4787, [0x90, 0x25, 0x8C, 0xE4, 0xE0, 0x24, 0xAB, 0x56]);
struct FsrmExportImport;

const GUID CLSID_FsrmQuotaManager = {0x90DCAB7F, 0x347C, 0x4BFC, [0xB5, 0x43, 0x54, 0x03, 0x26, 0x30, 0x5F, 0xBE]};
@GUID(0x90DCAB7F, 0x347C, 0x4BFC, [0xB5, 0x43, 0x54, 0x03, 0x26, 0x30, 0x5F, 0xBE]);
struct FsrmQuotaManager;

const GUID CLSID_FsrmQuotaTemplateManager = {0x97D3D443, 0x251C, 0x4337, [0x81, 0xE7, 0xB3, 0x2E, 0x8F, 0x4E, 0xE6, 0x5E]};
@GUID(0x97D3D443, 0x251C, 0x4337, [0x81, 0xE7, 0xB3, 0x2E, 0x8F, 0x4E, 0xE6, 0x5E]);
struct FsrmQuotaTemplateManager;

const GUID CLSID_FsrmFileGroupManager = {0x8F1363F6, 0x656F, 0x4496, [0x92, 0x26, 0x13, 0xAE, 0xCB, 0xD7, 0x71, 0x8F]};
@GUID(0x8F1363F6, 0x656F, 0x4496, [0x92, 0x26, 0x13, 0xAE, 0xCB, 0xD7, 0x71, 0x8F]);
struct FsrmFileGroupManager;

const GUID CLSID_FsrmFileScreenManager = {0x95941183, 0xDB53, 0x4C5F, [0xB3, 0x7B, 0x7D, 0x09, 0x21, 0xCF, 0x9D, 0xC7]};
@GUID(0x95941183, 0xDB53, 0x4C5F, [0xB3, 0x7B, 0x7D, 0x09, 0x21, 0xCF, 0x9D, 0xC7]);
struct FsrmFileScreenManager;

const GUID CLSID_FsrmFileScreenTemplateManager = {0x243111DF, 0xE474, 0x46AA, [0xA0, 0x54, 0xEA, 0xA3, 0x3E, 0xDC, 0x29, 0x2A]};
@GUID(0x243111DF, 0xE474, 0x46AA, [0xA0, 0x54, 0xEA, 0xA3, 0x3E, 0xDC, 0x29, 0x2A]);
struct FsrmFileScreenTemplateManager;

const GUID CLSID_FsrmReportManager = {0x0058EF37, 0xAA66, 0x4C48, [0xBD, 0x5B, 0x2F, 0xCE, 0x43, 0x2A, 0xB0, 0xC8]};
@GUID(0x0058EF37, 0xAA66, 0x4C48, [0xBD, 0x5B, 0x2F, 0xCE, 0x43, 0x2A, 0xB0, 0xC8]);
struct FsrmReportManager;

const GUID CLSID_FsrmReportScheduler = {0xEA25F1B8, 0x1B8D, 0x4290, [0x8E, 0xE8, 0xE1, 0x7C, 0x12, 0xC2, 0xFE, 0x20]};
@GUID(0xEA25F1B8, 0x1B8D, 0x4290, [0x8E, 0xE8, 0xE1, 0x7C, 0x12, 0xC2, 0xFE, 0x20]);
struct FsrmReportScheduler;

const GUID CLSID_FsrmFileManagementJobManager = {0xEB18F9B2, 0x4C3A, 0x4321, [0xB2, 0x03, 0x20, 0x51, 0x20, 0xCF, 0xF6, 0x14]};
@GUID(0xEB18F9B2, 0x4C3A, 0x4321, [0xB2, 0x03, 0x20, 0x51, 0x20, 0xCF, 0xF6, 0x14]);
struct FsrmFileManagementJobManager;

const GUID CLSID_FsrmClassificationManager = {0xB15C0E47, 0xC391, 0x45B9, [0x95, 0xC8, 0xEB, 0x59, 0x6C, 0x85, 0x3F, 0x3A]};
@GUID(0xB15C0E47, 0xC391, 0x45B9, [0x95, 0xC8, 0xEB, 0x59, 0x6C, 0x85, 0x3F, 0x3A]);
struct FsrmClassificationManager;

const GUID CLSID_FsrmPipelineModuleConnector = {0xC7643375, 0x1EB5, 0x44DE, [0xA0, 0x62, 0x62, 0x35, 0x47, 0xD9, 0x33, 0xBC]};
@GUID(0xC7643375, 0x1EB5, 0x44DE, [0xA0, 0x62, 0x62, 0x35, 0x47, 0xD9, 0x33, 0xBC]);
struct FsrmPipelineModuleConnector;

const GUID CLSID_AdSyncTask = {0x2AE64751, 0xB728, 0x4D6B, [0x97, 0xA0, 0xB2, 0xDA, 0x2E, 0x7D, 0x2A, 0x3B]};
@GUID(0x2AE64751, 0xB728, 0x4D6B, [0x97, 0xA0, 0xB2, 0xDA, 0x2E, 0x7D, 0x2A, 0x3B]);
struct AdSyncTask;

const GUID CLSID_FsrmAccessDeniedRemediationClient = {0x100B4FC8, 0x74C1, 0x470F, [0xB1, 0xB7, 0xDD, 0x7B, 0x6B, 0xAE, 0x79, 0xBD]};
@GUID(0x100B4FC8, 0x74C1, 0x470F, [0xB1, 0xB7, 0xDD, 0x7B, 0x6B, 0xAE, 0x79, 0xBD]);
struct FsrmAccessDeniedRemediationClient;

const GUID IID_IFsrmQuotaBase = {0x1568A795, 0x3924, 0x4118, [0xB7, 0x4B, 0x68, 0xD8, 0xF0, 0xFA, 0x5D, 0xAF]};
@GUID(0x1568A795, 0x3924, 0x4118, [0xB7, 0x4B, 0x68, 0xD8, 0xF0, 0xFA, 0x5D, 0xAF]);
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

const GUID IID_IFsrmQuotaObject = {0x42DC3511, 0x61D5, 0x48AE, [0xB6, 0xDC, 0x59, 0xFC, 0x00, 0xC0, 0xA8, 0xD6]};
@GUID(0x42DC3511, 0x61D5, 0x48AE, [0xB6, 0xDC, 0x59, 0xFC, 0x00, 0xC0, 0xA8, 0xD6]);
interface IFsrmQuotaObject : IFsrmQuotaBase
{
    HRESULT get_Path(BSTR* path);
    HRESULT get_UserSid(BSTR* userSid);
    HRESULT get_UserAccount(BSTR* userAccount);
    HRESULT get_SourceTemplateName(BSTR* quotaTemplateName);
    HRESULT get_MatchesSourceTemplate(short* matches);
    HRESULT ApplyTemplate(BSTR quotaTemplateName);
}

const GUID IID_IFsrmQuota = {0x377F739D, 0x9647, 0x4B8E, [0x97, 0xD2, 0x5F, 0xFC, 0xE6, 0xD7, 0x59, 0xCD]};
@GUID(0x377F739D, 0x9647, 0x4B8E, [0x97, 0xD2, 0x5F, 0xFC, 0xE6, 0xD7, 0x59, 0xCD]);
interface IFsrmQuota : IFsrmQuotaObject
{
    HRESULT get_QuotaUsed(VARIANT* used);
    HRESULT get_QuotaPeakUsage(VARIANT* peakUsage);
    HRESULT get_QuotaPeakUsageTime(double* peakUsageDateTime);
    HRESULT ResetPeakUsage();
    HRESULT RefreshUsageProperties();
}

const GUID IID_IFsrmAutoApplyQuota = {0xF82E5729, 0x6ABA, 0x4740, [0xBF, 0xC7, 0xC7, 0xF5, 0x8F, 0x75, 0xFB, 0x7B]};
@GUID(0xF82E5729, 0x6ABA, 0x4740, [0xBF, 0xC7, 0xC7, 0xF5, 0x8F, 0x75, 0xFB, 0x7B]);
interface IFsrmAutoApplyQuota : IFsrmQuotaObject
{
    HRESULT get_ExcludeFolders(SAFEARRAY** folders);
    HRESULT put_ExcludeFolders(SAFEARRAY* folders);
    HRESULT CommitAndUpdateDerived(FsrmCommitOptions commitOptions, FsrmTemplateApplyOptions applyOptions, IFsrmDerivedObjectsResult* derivedObjectsResult);
}

const GUID IID_IFsrmQuotaManager = {0x8BB68C7D, 0x19D8, 0x4FFB, [0x80, 0x9E, 0xBE, 0x4F, 0xC1, 0x73, 0x40, 0x14]};
@GUID(0x8BB68C7D, 0x19D8, 0x4FFB, [0x80, 0x9E, 0xBE, 0x4F, 0xC1, 0x73, 0x40, 0x14]);
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

const GUID IID_IFsrmQuotaManagerEx = {0x4846CB01, 0xD430, 0x494F, [0xAB, 0xB4, 0xB1, 0x05, 0x49, 0x99, 0xFB, 0x09]};
@GUID(0x4846CB01, 0xD430, 0x494F, [0xAB, 0xB4, 0xB1, 0x05, 0x49, 0x99, 0xFB, 0x09]);
interface IFsrmQuotaManagerEx : IFsrmQuotaManager
{
    HRESULT IsAffectedByQuota(BSTR path, FsrmEnumOptions options, short* affected);
}

const GUID IID_IFsrmQuotaTemplate = {0xA2EFAB31, 0x295E, 0x46BB, [0xB9, 0x76, 0xE8, 0x6D, 0x58, 0xB5, 0x2E, 0x8B]};
@GUID(0xA2EFAB31, 0x295E, 0x46BB, [0xB9, 0x76, 0xE8, 0x6D, 0x58, 0xB5, 0x2E, 0x8B]);
interface IFsrmQuotaTemplate : IFsrmQuotaBase
{
    HRESULT get_Name(BSTR* name);
    HRESULT put_Name(BSTR name);
    HRESULT CopyTemplate(BSTR quotaTemplateName);
    HRESULT CommitAndUpdateDerived(FsrmCommitOptions commitOptions, FsrmTemplateApplyOptions applyOptions, IFsrmDerivedObjectsResult* derivedObjectsResult);
}

const GUID IID_IFsrmQuotaTemplateImported = {0x9A2BF113, 0xA329, 0x44CC, [0x80, 0x9A, 0x5C, 0x00, 0xFC, 0xE8, 0xDA, 0x40]};
@GUID(0x9A2BF113, 0xA329, 0x44CC, [0x80, 0x9A, 0x5C, 0x00, 0xFC, 0xE8, 0xDA, 0x40]);
interface IFsrmQuotaTemplateImported : IFsrmQuotaTemplate
{
    HRESULT get_OverwriteOnCommit(short* overwrite);
    HRESULT put_OverwriteOnCommit(short overwrite);
}

const GUID IID_IFsrmQuotaTemplateManager = {0x4173AC41, 0x172D, 0x4D52, [0x96, 0x3C, 0xFD, 0xC7, 0xE4, 0x15, 0xF7, 0x17]};
@GUID(0x4173AC41, 0x172D, 0x4D52, [0x96, 0x3C, 0xFD, 0xC7, 0xE4, 0x15, 0xF7, 0x17]);
interface IFsrmQuotaTemplateManager : IDispatch
{
    HRESULT CreateTemplate(IFsrmQuotaTemplate* quotaTemplate);
    HRESULT GetTemplate(BSTR name, IFsrmQuotaTemplate* quotaTemplate);
    HRESULT EnumTemplates(FsrmEnumOptions options, IFsrmCommittableCollection* quotaTemplates);
    HRESULT ExportTemplates(VARIANT* quotaTemplateNamesArray, BSTR* serializedQuotaTemplates);
    HRESULT ImportTemplates(BSTR serializedQuotaTemplates, VARIANT* quotaTemplateNamesArray, IFsrmCommittableCollection* quotaTemplates);
}

const GUID IID_IFsrmFileGroup = {0x8DD04909, 0x0E34, 0x4D55, [0xAF, 0xAA, 0x89, 0xE1, 0xF1, 0xA1, 0xBB, 0xB9]};
@GUID(0x8DD04909, 0x0E34, 0x4D55, [0xAF, 0xAA, 0x89, 0xE1, 0xF1, 0xA1, 0xBB, 0xB9]);
interface IFsrmFileGroup : IFsrmObject
{
    HRESULT get_Name(BSTR* name);
    HRESULT put_Name(BSTR name);
    HRESULT get_Members(IFsrmMutableCollection* members);
    HRESULT put_Members(IFsrmMutableCollection members);
    HRESULT get_NonMembers(IFsrmMutableCollection* nonMembers);
    HRESULT put_NonMembers(IFsrmMutableCollection nonMembers);
}

const GUID IID_IFsrmFileGroupImported = {0xAD55F10B, 0x5F11, 0x4BE7, [0x94, 0xEF, 0xD9, 0xEE, 0x2E, 0x47, 0x0D, 0xED]};
@GUID(0xAD55F10B, 0x5F11, 0x4BE7, [0x94, 0xEF, 0xD9, 0xEE, 0x2E, 0x47, 0x0D, 0xED]);
interface IFsrmFileGroupImported : IFsrmFileGroup
{
    HRESULT get_OverwriteOnCommit(short* overwrite);
    HRESULT put_OverwriteOnCommit(short overwrite);
}

const GUID IID_IFsrmFileGroupManager = {0x426677D5, 0x018C, 0x485C, [0x8A, 0x51, 0x20, 0xB8, 0x6D, 0x00, 0xBD, 0xC4]};
@GUID(0x426677D5, 0x018C, 0x485C, [0x8A, 0x51, 0x20, 0xB8, 0x6D, 0x00, 0xBD, 0xC4]);
interface IFsrmFileGroupManager : IDispatch
{
    HRESULT CreateFileGroup(IFsrmFileGroup* fileGroup);
    HRESULT GetFileGroup(BSTR name, IFsrmFileGroup* fileGroup);
    HRESULT EnumFileGroups(FsrmEnumOptions options, IFsrmCommittableCollection* fileGroups);
    HRESULT ExportFileGroups(VARIANT* fileGroupNamesArray, BSTR* serializedFileGroups);
    HRESULT ImportFileGroups(BSTR serializedFileGroups, VARIANT* fileGroupNamesArray, IFsrmCommittableCollection* fileGroups);
}

const GUID IID_IFsrmFileScreenBase = {0xF3637E80, 0x5B22, 0x4A2B, [0xA6, 0x37, 0xBB, 0xB6, 0x42, 0xB4, 0x1C, 0xFC]};
@GUID(0xF3637E80, 0x5B22, 0x4A2B, [0xA6, 0x37, 0xBB, 0xB6, 0x42, 0xB4, 0x1C, 0xFC]);
interface IFsrmFileScreenBase : IFsrmObject
{
    HRESULT get_BlockedFileGroups(IFsrmMutableCollection* blockList);
    HRESULT put_BlockedFileGroups(IFsrmMutableCollection blockList);
    HRESULT get_FileScreenFlags(int* fileScreenFlags);
    HRESULT put_FileScreenFlags(int fileScreenFlags);
    HRESULT CreateAction(FsrmActionType actionType, IFsrmAction* action);
    HRESULT EnumActions(IFsrmCollection* actions);
}

const GUID IID_IFsrmFileScreen = {0x5F6325D3, 0xCE88, 0x4733, [0x84, 0xC1, 0x2D, 0x6A, 0xEF, 0xC5, 0xEA, 0x07]};
@GUID(0x5F6325D3, 0xCE88, 0x4733, [0x84, 0xC1, 0x2D, 0x6A, 0xEF, 0xC5, 0xEA, 0x07]);
interface IFsrmFileScreen : IFsrmFileScreenBase
{
    HRESULT get_Path(BSTR* path);
    HRESULT get_SourceTemplateName(BSTR* fileScreenTemplateName);
    HRESULT get_MatchesSourceTemplate(short* matches);
    HRESULT get_UserSid(BSTR* userSid);
    HRESULT get_UserAccount(BSTR* userAccount);
    HRESULT ApplyTemplate(BSTR fileScreenTemplateName);
}

const GUID IID_IFsrmFileScreenException = {0xBEE7CE02, 0xDF77, 0x4515, [0x93, 0x89, 0x78, 0xF0, 0x1C, 0x5A, 0xFC, 0x1A]};
@GUID(0xBEE7CE02, 0xDF77, 0x4515, [0x93, 0x89, 0x78, 0xF0, 0x1C, 0x5A, 0xFC, 0x1A]);
interface IFsrmFileScreenException : IFsrmObject
{
    HRESULT get_Path(BSTR* path);
    HRESULT get_AllowedFileGroups(IFsrmMutableCollection* allowList);
    HRESULT put_AllowedFileGroups(IFsrmMutableCollection allowList);
}

const GUID IID_IFsrmFileScreenManager = {0xFF4FA04E, 0x5A94, 0x4BDA, [0xA3, 0xA0, 0xD5, 0xB4, 0xD3, 0xC5, 0x2E, 0xBA]};
@GUID(0xFF4FA04E, 0x5A94, 0x4BDA, [0xA3, 0xA0, 0xD5, 0xB4, 0xD3, 0xC5, 0x2E, 0xBA]);
interface IFsrmFileScreenManager : IDispatch
{
    HRESULT get_ActionVariables(SAFEARRAY** variables);
    HRESULT get_ActionVariableDescriptions(SAFEARRAY** descriptions);
    HRESULT CreateFileScreen(BSTR path, IFsrmFileScreen* fileScreen);
    HRESULT GetFileScreen(BSTR path, IFsrmFileScreen* fileScreen);
    HRESULT EnumFileScreens(BSTR path, FsrmEnumOptions options, IFsrmCommittableCollection* fileScreens);
    HRESULT CreateFileScreenException(BSTR path, IFsrmFileScreenException* fileScreenException);
    HRESULT GetFileScreenException(BSTR path, IFsrmFileScreenException* fileScreenException);
    HRESULT EnumFileScreenExceptions(BSTR path, FsrmEnumOptions options, IFsrmCommittableCollection* fileScreenExceptions);
    HRESULT CreateFileScreenCollection(IFsrmCommittableCollection* collection);
}

const GUID IID_IFsrmFileScreenTemplate = {0x205BEBF8, 0xDD93, 0x452A, [0x95, 0xA6, 0x32, 0xB5, 0x66, 0xB3, 0x58, 0x28]};
@GUID(0x205BEBF8, 0xDD93, 0x452A, [0x95, 0xA6, 0x32, 0xB5, 0x66, 0xB3, 0x58, 0x28]);
interface IFsrmFileScreenTemplate : IFsrmFileScreenBase
{
    HRESULT get_Name(BSTR* name);
    HRESULT put_Name(BSTR name);
    HRESULT CopyTemplate(BSTR fileScreenTemplateName);
    HRESULT CommitAndUpdateDerived(FsrmCommitOptions commitOptions, FsrmTemplateApplyOptions applyOptions, IFsrmDerivedObjectsResult* derivedObjectsResult);
}

const GUID IID_IFsrmFileScreenTemplateImported = {0xE1010359, 0x3E5D, 0x4ECD, [0x9F, 0xE4, 0xEF, 0x48, 0x62, 0x2F, 0xDF, 0x30]};
@GUID(0xE1010359, 0x3E5D, 0x4ECD, [0x9F, 0xE4, 0xEF, 0x48, 0x62, 0x2F, 0xDF, 0x30]);
interface IFsrmFileScreenTemplateImported : IFsrmFileScreenTemplate
{
    HRESULT get_OverwriteOnCommit(short* overwrite);
    HRESULT put_OverwriteOnCommit(short overwrite);
}

const GUID IID_IFsrmFileScreenTemplateManager = {0xCFE36CBA, 0x1949, 0x4E74, [0xA1, 0x4F, 0xF1, 0xD5, 0x80, 0xCE, 0xAF, 0x13]};
@GUID(0xCFE36CBA, 0x1949, 0x4E74, [0xA1, 0x4F, 0xF1, 0xD5, 0x80, 0xCE, 0xAF, 0x13]);
interface IFsrmFileScreenTemplateManager : IDispatch
{
    HRESULT CreateTemplate(IFsrmFileScreenTemplate* fileScreenTemplate);
    HRESULT GetTemplate(BSTR name, IFsrmFileScreenTemplate* fileScreenTemplate);
    HRESULT EnumTemplates(FsrmEnumOptions options, IFsrmCommittableCollection* fileScreenTemplates);
    HRESULT ExportTemplates(VARIANT* fileScreenTemplateNamesArray, BSTR* serializedFileScreenTemplates);
    HRESULT ImportTemplates(BSTR serializedFileScreenTemplates, VARIANT* fileScreenTemplateNamesArray, IFsrmCommittableCollection* fileScreenTemplates);
}

const GUID IID_IFsrmReportManager = {0x27B899FE, 0x6FFA, 0x4481, [0xA1, 0x84, 0xD3, 0xDA, 0xAD, 0xE8, 0xA0, 0x2B]};
@GUID(0x27B899FE, 0x6FFA, 0x4481, [0xA1, 0x84, 0xD3, 0xDA, 0xAD, 0xE8, 0xA0, 0x2B]);
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

const GUID IID_IFsrmReportJob = {0x38E87280, 0x715C, 0x4C7D, [0xA2, 0x80, 0xEA, 0x16, 0x51, 0xA1, 0x9F, 0xEF]};
@GUID(0x38E87280, 0x715C, 0x4C7D, [0xA2, 0x80, 0xEA, 0x16, 0x51, 0xA1, 0x9F, 0xEF]);
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

const GUID IID_IFsrmReport = {0xD8CC81D9, 0x46B8, 0x4FA4, [0xBF, 0xA5, 0x4A, 0xA9, 0xDE, 0xC9, 0xB6, 0x38]};
@GUID(0xD8CC81D9, 0x46B8, 0x4FA4, [0xBF, 0xA5, 0x4A, 0xA9, 0xDE, 0xC9, 0xB6, 0x38]);
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

const GUID IID_IFsrmReportScheduler = {0x6879CAF9, 0x6617, 0x4484, [0x87, 0x19, 0x71, 0xC3, 0xD8, 0x64, 0x5F, 0x94]};
@GUID(0x6879CAF9, 0x6617, 0x4484, [0x87, 0x19, 0x71, 0xC3, 0xD8, 0x64, 0x5F, 0x94]);
interface IFsrmReportScheduler : IDispatch
{
    HRESULT VerifyNamespaces(VARIANT* namespacesSafeArray);
    HRESULT CreateScheduleTask(BSTR taskName, VARIANT* namespacesSafeArray, BSTR serializedTask);
    HRESULT ModifyScheduleTask(BSTR taskName, VARIANT* namespacesSafeArray, BSTR serializedTask);
    HRESULT DeleteScheduleTask(BSTR taskName);
}

const GUID IID_IFsrmFileManagementJobManager = {0xEE321ECB, 0xD95E, 0x48E9, [0x90, 0x7C, 0xC7, 0x68, 0x5A, 0x01, 0x32, 0x35]};
@GUID(0xEE321ECB, 0xD95E, 0x48E9, [0x90, 0x7C, 0xC7, 0x68, 0x5A, 0x01, 0x32, 0x35]);
interface IFsrmFileManagementJobManager : IDispatch
{
    HRESULT get_ActionVariables(SAFEARRAY** variables);
    HRESULT get_ActionVariableDescriptions(SAFEARRAY** descriptions);
    HRESULT EnumFileManagementJobs(FsrmEnumOptions options, IFsrmCollection* fileManagementJobs);
    HRESULT CreateFileManagementJob(IFsrmFileManagementJob* fileManagementJob);
    HRESULT GetFileManagementJob(BSTR name, IFsrmFileManagementJob* fileManagementJob);
}

const GUID IID_IFsrmFileManagementJob = {0x0770687E, 0x9F36, 0x4D6F, [0x87, 0x78, 0x59, 0x9D, 0x18, 0x84, 0x61, 0xC9]};
@GUID(0x0770687E, 0x9F36, 0x4D6F, [0x87, 0x78, 0x59, 0x9D, 0x18, 0x84, 0x61, 0xC9]);
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

const GUID IID_IFsrmPropertyCondition = {0x326AF66F, 0x2AC0, 0x4F68, [0xBF, 0x8C, 0x47, 0x59, 0xF0, 0x54, 0xFA, 0x29]};
@GUID(0x326AF66F, 0x2AC0, 0x4F68, [0xBF, 0x8C, 0x47, 0x59, 0xF0, 0x54, 0xFA, 0x29]);
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

const GUID IID_IFsrmFileCondition = {0x70684FFC, 0x691A, 0x4A1A, [0xB9, 0x22, 0x97, 0x75, 0x2E, 0x13, 0x8C, 0xC1]};
@GUID(0x70684FFC, 0x691A, 0x4A1A, [0xB9, 0x22, 0x97, 0x75, 0x2E, 0x13, 0x8C, 0xC1]);
interface IFsrmFileCondition : IDispatch
{
    HRESULT get_Type(FsrmFileConditionType* pVal);
    HRESULT Delete();
}

const GUID IID_IFsrmFileConditionProperty = {0x81926775, 0xB981, 0x4479, [0x98, 0x8F, 0xDA, 0x17, 0x1D, 0x62, 0x73, 0x60]};
@GUID(0x81926775, 0xB981, 0x4479, [0x98, 0x8F, 0xDA, 0x17, 0x1D, 0x62, 0x73, 0x60]);
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

const GUID IID_IFsrmPropertyDefinition = {0xEDE0150F, 0xE9A3, 0x419C, [0x87, 0x7C, 0x01, 0xFE, 0x5D, 0x24, 0xC5, 0xD3]};
@GUID(0xEDE0150F, 0xE9A3, 0x419C, [0x87, 0x7C, 0x01, 0xFE, 0x5D, 0x24, 0xC5, 0xD3]);
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

const GUID IID_IFsrmPropertyDefinition2 = {0x47782152, 0xD16C, 0x4229, [0xB4, 0xE1, 0x0D, 0xDF, 0xE3, 0x08, 0xB9, 0xF6]};
@GUID(0x47782152, 0xD16C, 0x4229, [0xB4, 0xE1, 0x0D, 0xDF, 0xE3, 0x08, 0xB9, 0xF6]);
interface IFsrmPropertyDefinition2 : IFsrmPropertyDefinition
{
    HRESULT get_PropertyDefinitionFlags(int* propertyDefinitionFlags);
    HRESULT get_DisplayName(BSTR* name);
    HRESULT put_DisplayName(BSTR name);
    HRESULT get_AppliesTo(int* appliesTo);
    HRESULT get_ValueDefinitions(IFsrmCollection* valueDefinitions);
}

const GUID IID_IFsrmPropertyDefinitionValue = {0xE946D148, 0xBD67, 0x4178, [0x8E, 0x22, 0x1C, 0x44, 0x92, 0x5E, 0xD7, 0x10]};
@GUID(0xE946D148, 0xBD67, 0x4178, [0x8E, 0x22, 0x1C, 0x44, 0x92, 0x5E, 0xD7, 0x10]);
interface IFsrmPropertyDefinitionValue : IDispatch
{
    HRESULT get_Name(BSTR* name);
    HRESULT get_DisplayName(BSTR* displayName);
    HRESULT get_Description(BSTR* description);
    HRESULT get_UniqueID(BSTR* uniqueID);
}

const GUID IID_IFsrmProperty = {0x4A73FEE4, 0x4102, 0x4FCC, [0x9F, 0xFB, 0x38, 0x61, 0x4F, 0x9E, 0xE7, 0x68]};
@GUID(0x4A73FEE4, 0x4102, 0x4FCC, [0x9F, 0xFB, 0x38, 0x61, 0x4F, 0x9E, 0xE7, 0x68]);
interface IFsrmProperty : IDispatch
{
    HRESULT get_Name(BSTR* name);
    HRESULT get_Value(BSTR* value);
    HRESULT get_Sources(SAFEARRAY** sources);
    HRESULT get_PropertyFlags(int* flags);
}

const GUID IID_IFsrmRule = {0xCB0DF960, 0x16F5, 0x4495, [0x90, 0x79, 0x3F, 0x93, 0x60, 0xD8, 0x31, 0xDF]};
@GUID(0xCB0DF960, 0x16F5, 0x4495, [0x90, 0x79, 0x3F, 0x93, 0x60, 0xD8, 0x31, 0xDF]);
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

const GUID IID_IFsrmClassificationRule = {0xAFC052C2, 0x5315, 0x45AB, [0x84, 0x1B, 0xC6, 0xDB, 0x0E, 0x12, 0x01, 0x48]};
@GUID(0xAFC052C2, 0x5315, 0x45AB, [0x84, 0x1B, 0xC6, 0xDB, 0x0E, 0x12, 0x01, 0x48]);
interface IFsrmClassificationRule : IFsrmRule
{
    HRESULT get_ExecutionOption(FsrmExecutionOption* executionOption);
    HRESULT put_ExecutionOption(FsrmExecutionOption executionOption);
    HRESULT get_PropertyAffected(BSTR* property);
    HRESULT put_PropertyAffected(BSTR property);
    HRESULT get_Value(BSTR* value);
    HRESULT put_Value(BSTR value);
}

const GUID IID_IFsrmPipelineModuleDefinition = {0x515C1277, 0x2C81, 0x440E, [0x8F, 0xCF, 0x36, 0x79, 0x21, 0xED, 0x4F, 0x59]};
@GUID(0x515C1277, 0x2C81, 0x440E, [0x8F, 0xCF, 0x36, 0x79, 0x21, 0xED, 0x4F, 0x59]);
interface IFsrmPipelineModuleDefinition : IFsrmObject
{
    HRESULT get_ModuleClsid(BSTR* moduleClsid);
    HRESULT put_ModuleClsid(BSTR moduleClsid);
    HRESULT get_Name(BSTR* name);
    HRESULT put_Name(BSTR name);
    HRESULT get_Company(BSTR* company);
    HRESULT put_Company(BSTR company);
    HRESULT get_Version(BSTR* version);
    HRESULT put_Version(BSTR version);
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

const GUID IID_IFsrmClassifierModuleDefinition = {0xBB36EA26, 0x6318, 0x4B8C, [0x85, 0x92, 0xF7, 0x2D, 0xD6, 0x02, 0xE7, 0xA5]};
@GUID(0xBB36EA26, 0x6318, 0x4B8C, [0x85, 0x92, 0xF7, 0x2D, 0xD6, 0x02, 0xE7, 0xA5]);
interface IFsrmClassifierModuleDefinition : IFsrmPipelineModuleDefinition
{
    HRESULT get_PropertiesAffected(SAFEARRAY** propertiesAffected);
    HRESULT put_PropertiesAffected(SAFEARRAY* propertiesAffected);
    HRESULT get_PropertiesUsed(SAFEARRAY** propertiesUsed);
    HRESULT put_PropertiesUsed(SAFEARRAY* propertiesUsed);
    HRESULT get_NeedsExplicitValue(short* needsExplicitValue);
    HRESULT put_NeedsExplicitValue(short needsExplicitValue);
}

const GUID IID_IFsrmStorageModuleDefinition = {0x15A81350, 0x497D, 0x4ABA, [0x80, 0xE9, 0xD4, 0xDB, 0xCC, 0x55, 0x21, 0xFE]};
@GUID(0x15A81350, 0x497D, 0x4ABA, [0x80, 0xE9, 0xD4, 0xDB, 0xCC, 0x55, 0x21, 0xFE]);
interface IFsrmStorageModuleDefinition : IFsrmPipelineModuleDefinition
{
    HRESULT get_Capabilities(FsrmStorageModuleCaps* capabilities);
    HRESULT put_Capabilities(FsrmStorageModuleCaps capabilities);
    HRESULT get_StorageType(FsrmStorageModuleType* storageType);
    HRESULT put_StorageType(FsrmStorageModuleType storageType);
    HRESULT get_UpdatesFileContent(short* updatesFileContent);
    HRESULT put_UpdatesFileContent(short updatesFileContent);
}

const GUID IID_IFsrmClassificationManager = {0xD2DC89DA, 0xEE91, 0x48A0, [0x85, 0xD8, 0xCC, 0x72, 0xA5, 0x6F, 0x7D, 0x04]};
@GUID(0xD2DC89DA, 0xEE91, 0x48A0, [0x85, 0xD8, 0xCC, 0x72, 0xA5, 0x6F, 0x7D, 0x04]);
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
    HRESULT EnumModuleDefinitions(FsrmPipelineModuleType moduleType, FsrmEnumOptions options, IFsrmCollection* moduleDefinitions);
    HRESULT CreateModuleDefinition(FsrmPipelineModuleType moduleType, IFsrmPipelineModuleDefinition* moduleDefinition);
    HRESULT GetModuleDefinition(BSTR moduleName, FsrmPipelineModuleType moduleType, IFsrmPipelineModuleDefinition* moduleDefinition);
    HRESULT RunClassification(FsrmReportGenerationContext context, BSTR reserved);
    HRESULT WaitForClassificationCompletion(int waitSeconds, short* completed);
    HRESULT CancelClassification();
    HRESULT EnumFileProperties(BSTR filePath, FsrmGetFilePropertyOptions options, IFsrmCollection* fileProperties);
    HRESULT GetFileProperty(BSTR filePath, BSTR propertyName, FsrmGetFilePropertyOptions options, IFsrmProperty* property);
    HRESULT SetFileProperty(BSTR filePath, BSTR propertyName, BSTR propertyValue);
    HRESULT ClearFileProperty(BSTR filePath, BSTR property);
}

const GUID IID_IFsrmClassificationManager2 = {0x0004C1C9, 0x127E, 0x4765, [0xBA, 0x07, 0x6A, 0x31, 0x47, 0xBC, 0xA1, 0x12]};
@GUID(0x0004C1C9, 0x127E, 0x4765, [0xBA, 0x07, 0x6A, 0x31, 0x47, 0xBC, 0xA1, 0x12]);
interface IFsrmClassificationManager2 : IFsrmClassificationManager
{
    HRESULT ClassifyFiles(SAFEARRAY* filePaths, SAFEARRAY* propertyNames, SAFEARRAY* propertyValues, FsrmGetFilePropertyOptions options);
}

const GUID IID_IFsrmPropertyBag = {0x774589D1, 0xD300, 0x4F7A, [0x9A, 0x24, 0xF7, 0xB7, 0x66, 0x80, 0x02, 0x50]};
@GUID(0x774589D1, 0xD300, 0x4F7A, [0x9A, 0x24, 0xF7, 0xB7, 0x66, 0x80, 0x02, 0x50]);
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
    HRESULT GetFileStreamInterface(FsrmFileStreamingMode accessMode, FsrmFileStreamingInterfaceType interfaceType, VARIANT* pStreamInterface);
}

const GUID IID_IFsrmPropertyBag2 = {0x0E46BDBD, 0x2402, 0x4FED, [0x9C, 0x30, 0x92, 0x66, 0xE6, 0xEB, 0x2C, 0xC9]};
@GUID(0x0E46BDBD, 0x2402, 0x4FED, [0x9C, 0x30, 0x92, 0x66, 0xE6, 0xEB, 0x2C, 0xC9]);
interface IFsrmPropertyBag2 : IFsrmPropertyBag
{
    HRESULT GetFieldValue(FsrmPropertyBagField field, VARIANT* value);
    HRESULT GetUntrustedInFileProperties(IFsrmCollection* props);
}

const GUID IID_IFsrmPipelineModuleImplementation = {0xB7907906, 0x2B02, 0x4CB5, [0x84, 0xA9, 0xFD, 0xF5, 0x46, 0x13, 0xD6, 0xCD]};
@GUID(0xB7907906, 0x2B02, 0x4CB5, [0x84, 0xA9, 0xFD, 0xF5, 0x46, 0x13, 0xD6, 0xCD]);
interface IFsrmPipelineModuleImplementation : IDispatch
{
    HRESULT OnLoad(IFsrmPipelineModuleDefinition moduleDefinition, IFsrmPipelineModuleConnector* moduleConnector);
    HRESULT OnUnload();
}

const GUID IID_IFsrmClassifierModuleImplementation = {0x4C968FC6, 0x6EDB, 0x4051, [0x9C, 0x18, 0x73, 0xB7, 0x29, 0x1A, 0xE1, 0x06]};
@GUID(0x4C968FC6, 0x6EDB, 0x4051, [0x9C, 0x18, 0x73, 0xB7, 0x29, 0x1A, 0xE1, 0x06]);
interface IFsrmClassifierModuleImplementation : IFsrmPipelineModuleImplementation
{
    HRESULT get_LastModified(VARIANT* lastModified);
    HRESULT UseRulesAndDefinitions(IFsrmCollection rules, IFsrmCollection propertyDefinitions);
    HRESULT OnBeginFile(IFsrmPropertyBag propertyBag, SAFEARRAY* arrayRuleIds);
    HRESULT DoesPropertyValueApply(BSTR property, BSTR value, short* applyValue, Guid idRule, Guid idPropDef);
    HRESULT GetPropertyValueToApply(BSTR property, BSTR* value, Guid idRule, Guid idPropDef);
    HRESULT OnEndFile();
}

const GUID IID_IFsrmStorageModuleImplementation = {0x0AF4A0DA, 0x895A, 0x4E50, [0x87, 0x12, 0xA9, 0x67, 0x24, 0xBC, 0xEC, 0x64]};
@GUID(0x0AF4A0DA, 0x895A, 0x4E50, [0x87, 0x12, 0xA9, 0x67, 0x24, 0xBC, 0xEC, 0x64]);
interface IFsrmStorageModuleImplementation : IFsrmPipelineModuleImplementation
{
    HRESULT UseDefinitions(IFsrmCollection propertyDefinitions);
    HRESULT LoadProperties(IFsrmPropertyBag propertyBag);
    HRESULT SaveProperties(IFsrmPropertyBag propertyBag);
}

const GUID IID_IFsrmPipelineModuleConnector = {0xC16014F3, 0x9AA1, 0x46B3, [0xB0, 0xA7, 0xAB, 0x14, 0x6E, 0xB2, 0x05, 0xF2]};
@GUID(0xC16014F3, 0x9AA1, 0x46B3, [0xB0, 0xA7, 0xAB, 0x14, 0x6E, 0xB2, 0x05, 0xF2]);
interface IFsrmPipelineModuleConnector : IDispatch
{
    HRESULT get_ModuleImplementation(IFsrmPipelineModuleImplementation* pipelineModuleImplementation);
    HRESULT get_ModuleName(BSTR* userName);
    HRESULT get_HostingUserAccount(BSTR* userAccount);
    HRESULT get_HostingProcessPid(int* pid);
    HRESULT Bind(IFsrmPipelineModuleDefinition moduleDefinition, IFsrmPipelineModuleImplementation moduleImplementation);
}

const GUID IID_DIFsrmClassificationEvents = {0x26942DB0, 0xDABF, 0x41D8, [0xBB, 0xDD, 0xB1, 0x29, 0xA9, 0xF7, 0x04, 0x24]};
@GUID(0x26942DB0, 0xDABF, 0x41D8, [0xBB, 0xDD, 0xB1, 0x29, 0xA9, 0xF7, 0x04, 0x24]);
interface DIFsrmClassificationEvents : IDispatch
{
}

