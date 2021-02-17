// Written in the D programming language.

module windows.fileseverresourcemanager;

public import windows.core;
public import windows.automation : BSTR, IDispatch, SAFEARRAY, VARIANT;
public import windows.com : HRESULT, IUnknown;

extern(Windows):


// Enums


///Defines the options for failing IO operations that violate a quota, enabling or disabling quota tracking, and
///providing the status of the quota scan operation.
enum FsrmQuotaFlags : int
{
    ///If this flag is set, the server will fail an IO operation that causes the disk space usage to exceed the quota
    ///limit. If this flag is not set, the server will not fail violating IO operations but will still run any action
    ///associated with the quota thresholds.
    FsrmQuotaFlags_Enforce          = 0x00000100,
    ///The server will not track quota data for the quota and will not run any action associated with quota thresholds.
    FsrmQuotaFlags_Disable          = 0x00000200,
    ///The quota is defined on the server but the rebuilding procedure (see IFsrmQuotaManager::Scan) did not start or
    ///the scan failed.
    FsrmQuotaFlags_StatusIncomplete = 0x00010000,
    ///The quota is in the process of rebuilding its data from the disk.
    FsrmQuotaFlags_StatusRebuilding = 0x00020000,
}

///Defines the options for failing IO operations that violate a file screen.
enum FsrmFileScreenFlags : int
{
    ///If this flag is set, the server will fail any IO operation that violates the file screen. If this flag is not
    ///set, the server will not fail violating IO operations but will still run any action associated with the file
    ///screen.
    FsrmFileScreenFlags_Enforce = 0x00000001,
}

///Defines the possible states of a collection object.
enum FsrmCollectionState : int
{
    ///The collection object is fetching data.
    FsrmCollectionState_Fetching   = 0x00000001,
    ///The collection object is committing its data.
    FsrmCollectionState_Committing = 0x00000002,
    ///The collection object is complete (has stopped fetching or committing data).
    FsrmCollectionState_Complete   = 0x00000003,
    ///The collection operation (fetching or committing) was canceled.
    FsrmCollectionState_Cancelled  = 0x00000004,
}

///Defines the options for enumerating collections of objects.
enum FsrmEnumOptions : int
{
    ///Use no options and enumerate objects synchronously.
    FsrmEnumOptions_None                     = 0x00000000,
    ///Reserved. Do not use.
    FsrmEnumOptions_Asynchronous             = 0x00000001,
    ///Include items and paths that are in the system recycle bin when enumerating.
    FsrmEnumOptions_CheckRecycleBin          = 0x00000002,
    ///Include objects on all nodes in a Windows cluster when enumerating report jobs
    ///(IFsrmReportManager::EnumReportJobs).
    FsrmEnumOptions_IncludeClusterNodes      = 0x00000004,
    ///Include deprecated objects when enumerating. <b>Windows Server 2008 R2 and Windows Server 2008: </b>This
    ///enumeration value is not supported before Windows Server 2012.
    FsrmEnumOptions_IncludeDeprecatedObjects = 0x00000008,
}

///Defines the options for committing a collection of objects.
enum FsrmCommitOptions : int
{
    ///Use no options and commit the collection of objects synchronously.
    FsrmCommitOptions_None         = 0x00000000,
    ///Reserved. Do not use.
    FsrmCommitOptions_Asynchronous = 0x00000001,
}

///Defines the options for applying template changes to derived objects.
enum FsrmTemplateApplyOptions : int
{
    ///Apply template changes to derived objects only if the object's properties match the template's properties. Note
    ///that the comparison is made against the template as it exists in the database, not your local copy that has not
    ///been committed yet.
    FsrmTemplateApplyOptions_ApplyToDerivedMatching = 0x00000001,
    ///Apply template changes to all derived objects, whether their properties match the template's or not.
    FsrmTemplateApplyOptions_ApplyToDerivedAll      = 0x00000002,
}

///Defines the actions that can be triggered in response to a quota or file screen event (for example, a quota is
///exceeded or a file violates a file screen). A file management job can also trigger the action.
enum FsrmActionType : int
{
    ///The action is of an unknown type. Do not use this value to specify an action type.
    FsrmActionType_Unknown  = 0x00000000,
    ///Log an event to the Application event log.
    FsrmActionType_EventLog = 0x00000001,
    ///Send an email message.
    FsrmActionType_Email    = 0x00000002,
    ///Execute a command or script.
    FsrmActionType_Command  = 0x00000003,
    ///Generate a report.
    FsrmActionType_Report   = 0x00000004,
}

///Defines the event types that an event logging action (see FsrmActionType) can log.
enum FsrmEventType : int
{
    ///The event type is unknown. Do not use this flag.
    FsrmEventType_Unknown     = 0x00000000,
    ///The event is an information event.
    FsrmEventType_Information = 0x00000001,
    ///The event is a warning event.
    FsrmEventType_Warning     = 0x00000002,
    ///The event is an error event.
    FsrmEventType_Error       = 0x00000003,
}

///Defines the computer account types under which a command action (see FsrmActionType) can run.
enum FsrmAccountType : int
{
    ///The account type is unknown. Do not use this value to set the IFsrmActionCommand::Account property.
    FsrmAccountType_Unknown        = 0x00000000,
    ///Run the command or pipeline module under the "NetworkService" account.
    FsrmAccountType_NetworkService = 0x00000001,
    ///Run the command or pipeline module under the "LocalService" account.
    FsrmAccountType_LocalService   = 0x00000002,
    ///Run the command or pipeline module under the "LocalSystem" account.
    FsrmAccountType_LocalSystem    = 0x00000003,
    ///This value is reserved for internal use.
    FsrmAccountType_InProc         = 0x00000004,
    ///Run the classifier or storage module in a separate process from FSRM (FSRM uses <b>CLSCTX_LOCAL_SERVER</b> to
    ///instantiate the module). The module's COM registration specifies the account used to run the module. If the
    ///registration does not specify the account, the module is run using the user's account.
    FsrmAccountType_External       = 0x00000005,
    ///Run the command or pipeline module under the account that FSRM selects. This is the recommended value. <b>Windows
    ///Server 2008 R2 and Windows Server 2008: </b>This enumeration value is not supported before Windows Server 2012.
    FsrmAccountType_Automatic      = 0x000001f4,
}

///Defines the types of reports that you can generate.
enum FsrmReportType : int
{
    ///The report type is unknown. Do not use this flag.
    FsrmReportType_Unknown                 = 0x00000000,
    ///Lists files that are larger than a specified size. Set the filter value to the size, in bytes.
    FsrmReportType_LargeFiles              = 0x00000001,
    ///Lists groups of files. Create a file group and use file name patterns to specify the members of the group. Set
    ///the filter value to the name of the file group.
    FsrmReportType_FilesByType             = 0x00000002,
    ///Lists files that have not been accessed in the last <i>n</i> days. Specify the filter value in days.
    FsrmReportType_LeastRecentlyAccessed   = 0x00000003,
    ///Lists files that have been accessed in the last <i>n</i> days. Specify the filter value in days.
    FsrmReportType_MostRecentlyAccessed    = 0x00000004,
    ///Lists quotas that exceed the specified threshold. Set the filter value to the threshold.
    FsrmReportType_QuotaUsage              = 0x00000005,
    ///Lists files grouped by their owner. Set the filter value to the list of owners whose files you want included in
    ///the report.
    FsrmReportType_FilesByOwner            = 0x00000006,
    ///Lists all files in the scope of the report job; there is no filtering. You can specify the XML or CSV file
    ///formats only for this report type. This report cannot be sent through email. For an action report, the scope is
    ///based on the quota or file screen event that initiated the report.
    FsrmReportType_ExportReport            = 0x00000007,
    ///Lists duplicate files. All files with the same file name, file size, and last modify time under the scope of the
    ///report job are considered duplicates. For example, if the scope of the report is C:\ and D:\ and file file1.txt
    ///exists in C:&
    FsrmReportType_DuplicateFiles          = 0x00000008,
    ///Lists file screening events that have occurred.
    FsrmReportType_FileScreenAudit         = 0x00000009,
    ///Lists files, grouped by property value, that contain the specified property (you can specify only one property on
    ///which to report). <b>Windows Server 2008: </b>This report type is not supported before Windows Server 2008 R2.
    FsrmReportType_FilesByProperty         = 0x0000000a,
    ///For internal use only; do not specify. <b>Windows Server 2008: </b>This report type is not supported before
    ///Windows Server 2008 R2.
    FsrmReportType_AutomaticClassification = 0x0000000b,
    ///For internal use only; do not specify. <b>Windows Server 2008: </b>This report type is not supported before
    ///Windows Server 2008 R2.
    FsrmReportType_Expiration              = 0x0000000c,
    ///Lists folders, grouped by property value, that contain the specified property (you can specify only one property
    ///on which to report). <b>Windows Server 2008 R2 and Windows Server 2008: </b>This report type is not supported
    ///before Windows Server 2012.
    FsrmReportType_FoldersByProperty       = 0x0000000d,
}

///Defines the file formats that you can use when generating reports.
enum FsrmReportFormat : int
{
    ///The report format is unknown. Do not use this flag.
    FsrmReportFormat_Unknown = 0x00000000,
    ///The report is rendered in Dynamic HTML (DHTML).
    FsrmReportFormat_DHtml   = 0x00000001,
    ///The report is rendered in HTML.
    FsrmReportFormat_Html    = 0x00000002,
    ///The report is rendered as a text file.
    FsrmReportFormat_Txt     = 0x00000003,
    ///The report is rendered as a comma-separated value file.
    FsrmReportFormat_Csv     = 0x00000004,
    ///The report is rendered in XML.
    FsrmReportFormat_Xml     = 0x00000005,
}

///Defines the running states a for a report job.
enum FsrmReportRunningStatus : int
{
    ///The report job status in unknown.
    FsrmReportRunningStatus_Unknown    = 0x00000000,
    ///The report job is not running.
    FsrmReportRunningStatus_NotRunning = 0x00000001,
    ///The report job is queued to run but is not running.
    FsrmReportRunningStatus_Queued     = 0x00000002,
    ///The report job is running.
    FsrmReportRunningStatus_Running    = 0x00000003,
}

///Defines the context in which the report is initiated.
enum FsrmReportGenerationContext : int
{
    ///The context is unknown. Do not use this flag.
    FsrmReportGenerationContext_Undefined         = 0x00000001,
    ///The report will run as a scheduled report.
    FsrmReportGenerationContext_ScheduledReport   = 0x00000002,
    ///The report will run on demand.
    FsrmReportGenerationContext_InteractiveReport = 0x00000003,
    ///The report will run in response to a quota or file screen event.
    FsrmReportGenerationContext_IncidentReport    = 0x00000004,
}

///Defines the filters that you can use to limit the files that are included in a report.
enum FsrmReportFilter : int
{
    ///The report will show only files that meet a minimum size. Applies to the <b>FsrmReportType_LargeFiles</b> report
    ///type.
    FsrmReportFilter_MinSize       = 0x00000001,
    ///The report will show only files that were accessed more than a minimum number of days ago. Applies to the
    ///<b>FsrmReportType_LeastRecentlyAccessed</b> and <b>FsrmReportType_FileScreenAudit</b> report types.
    FsrmReportFilter_MinAgeDays    = 0x00000002,
    ///The report will show only files that were accessed prior to a maximum number of days ago. Applies to the
    ///<b>FsrmReportType_MostRecentlyAccessed</b> report type.
    FsrmReportFilter_MaxAgeDays    = 0x00000003,
    ///The report will show only quotas that meet a certain disk space usage level. Applies to the
    ///<b>FsrmReportType_QuotaUsage</b> report type.
    FsrmReportFilter_MinQuotaUsage = 0x00000004,
    ///The report will show only files from a specified set of file groups. Applies to the
    ///<b>FsrmReportType_FilesByType</b> report type.
    FsrmReportFilter_FileGroups    = 0x00000005,
    ///The report will show only files that belong to specified owners. The format of the owner string can be either the
    ///user principal name ("<i>UserName</i>@<i>Domain</i>" or "<i>Domain</i>&
    FsrmReportFilter_Owners        = 0x00000006,
    ///The report will show only files with names that match the specified pattern. Applies to the
    ///<b>FsrmReportType_LargeFiles</b>, <b>FsrmReportType_MostRecentlyAccessed</b>,
    ///<b>FsrmReportType_LeastRecentlyAccessed</b>, <b>FsrmReportType_FilesByOwner</b>, and
    ///<b>FsrmReportType_FilesByProperty</b> report types. For these report types, multiple filters could exist. For
    ///example, for the <b>FsrmReportType_LargeFiles</b> report type, both the <b>FsrmReportFilter_MinSize</b> and
    ///<b>FsrmReportFilter_NamePattern</b> filters could exist.
    FsrmReportFilter_NamePattern   = 0x00000007,
    ///The report will show only files that contain the specified property. Applies to the
    ///<b>FsrmReportType_FilesByProperty</b> and <b>FsrmReportType_FoldersByProperty</b> report types.
    FsrmReportFilter_Property      = 0x00000008,
}

///Defines the limit used to limit the files included in a report.
enum FsrmReportLimit : int
{
    ///The report will list up to a maximum number of files. Applies to all report types.
    FsrmReportLimit_MaxFiles                 = 0x00000001,
    ///A <b>FsrmReportType_FilesByType</b> report will list up to a maximum number of file groups.
    FsrmReportLimit_MaxFileGroups            = 0x00000002,
    ///A <b>FsrmReportType_FilesByOwner</b> report will list up to a maximum number of owners.
    FsrmReportLimit_MaxOwners                = 0x00000003,
    ///A <b>FsrmReportType_FilesByProperty</b> report will list up to a maximum number of files per file group.
    FsrmReportLimit_MaxFilesPerFileGroup     = 0x00000004,
    ///A <b>FsrmReportType_FilesByOwner</b> report will be limited to a maximum number of files per owner.
    FsrmReportLimit_MaxFilesPerOwner         = 0x00000005,
    ///A <b>FsrmReportType_DuplicateFiles</b> report will list up to a maximum number of files per duplicated file
    ///group.
    FsrmReportLimit_MaxFilesPerDuplGroup     = 0x00000006,
    ///A <b>FsrmReportType_DuplicateFiles</b> report will list up to a maximum number of duplicated file groups.
    FsrmReportLimit_MaxDuplicateGroups       = 0x00000007,
    ///A <b>FsrmReportType_QuotaUsage</b> report will list up to a maximum number of quotas.
    FsrmReportLimit_MaxQuotas                = 0x00000008,
    ///A <b>FsrmReportType_FileScreenAudit</b> report will list up to a maximum number of file screen events.
    FsrmReportLimit_MaxFileScreenEvents      = 0x00000009,
    ///A <b>FsrmReportType_FilesByProperty</b> report will list up to a maximum number of property values.
    FsrmReportLimit_MaxPropertyValues        = 0x0000000a,
    ///A <b>FsrmReportType_FilesByProperty</b> report will list up to a maximum number of files per property value.
    FsrmReportLimit_MaxFilesPerPropertyValue = 0x0000000b,
    ///A <b>FsrmReportType_FolderByProperty</b> report will list up to a maximum number of folders. <b>Windows Server
    ///2008 R2 and Windows Server 2008: </b>This report limit is not supported before Windows Server 2012.
    FsrmReportLimit_MaxFolders               = 0x0000000c,
}

///Defines the types of file classification properties that you can define.
enum FsrmPropertyDefinitionType : int
{
    ///The type is unknown. Do not use this value.
    FsrmPropertyDefinitionType_Unknown          = 0x00000000,
    ///A classification property that defines an ordered list of possible string values, one of which may be assigned to
    ///the property. The aggregation policy for this type is to use the order in which the items are added to the list
    ///to determine which value to use if the property exists and contains a value that is different from the rule's
    ///value. For example, if the list contains "HBI", "MBI", and "LBI", and one source specifies "MBI" and the other
    ///source specifies "HBI", the property value is set to "HBI" because it appears before "MBI" in the list. You can
    ///use the following comparison operators with this type (see FsrmPropertyConditionType): Equal, Not equal, Greater
    ///than, Less than, Exists, and Not exists.
    FsrmPropertyDefinitionType_OrderedList      = 0x00000001,
    ///A classification property that defines a list of possible string values, one or more of which may be assigned to
    ///the property. Use the vertical bar character (|) to delimit the strings. The aggregation policy for this type is
    ///to concatenate the values from each source, consolidating any duplicates. For example, if the list of possible
    ///values contains "Cat1", "Cat2", "Cat3", and "Cat4", and one source specifies "Cat3" and another source specifies
    ///"Cat1", the property value is set to "Cat1|Cat3". You can use the following comparison operators with this type
    ///(see FsrmPropertyConditionType): Equal, Not equal, Contains, Contained in, Exists, and Not exists.
    FsrmPropertyDefinitionType_MultiChoiceList  = 0x00000002,
    ///A classification property that defines a list of possible string values, only one of which may be assigned to the
    ///property. No aggregation is available for this type. You can use the following comparison operators with this
    ///type (see FsrmPropertyConditionType): Equal, Not equal, Exists, and Not exists. <b>Windows Server 2008 R2 and
    ///Windows Server 2008: </b>This file classification property type is not supported before Windows Server 2012.
    FsrmPropertyDefinitionType_SingleChoiceList = 0x00000003,
    ///A classification property that contains an arbitrary string value. The aggregation policy is to fail if two
    ///sources do not specify the same value. You can use the following comparison operators with this type (see
    ///FsrmPropertyConditionType): Equal, Not equal, Greater than, Less than, Contains, Contained in, Start with, End
    ///with, Prefix of, Suffix of, Exists, and Not exists.
    FsrmPropertyDefinitionType_String           = 0x00000004,
    ///A classification property that contains one or more arbitrary string values. Use the vertical bar character (|)
    ///to delimit the strings. The aggregation policy is to concatenate the values from each source, consolidating any
    ///duplicates. For example if one source specifies "String1|String2" and another source specifies "String1|String3",
    ///the property value is set to "String1|String2|String3". You can use the following comparison operators with this
    ///type (see FsrmPropertyConditionType): Equal, Not equal, Contains, Contained in, Exists, and Not exists.
    FsrmPropertyDefinitionType_MultiString      = 0x00000005,
    ///A classification property that contains a decimal integer value expressed as a string. The aggregation policy is
    ///to fail if two sources do not specify the same value. You can use the following comparison operators with this
    ///type (see FsrmPropertyConditionType): Equal, Not equal, Greater than, Less than, Exists, and Not exists.
    FsrmPropertyDefinitionType_Int              = 0x00000006,
    ///A classification property that contains a Boolean value expressed as a string. Use a string value of "0" for
    ///<b>False</b> or a string value of "1" for <b>True</b>. The aggregation policy is to perform a logical <b>OR</b>
    ///on the values from each source. For example, if one source specifies <b>True</b> and another source specifies
    ///<b>False</b>, the property value is set to <b>True</b>. If two sources both specify <b>False</b>, the property
    ///value is set to <b>False</b>. You can use the following comparison operators with this type (see
    ///FsrmPropertyConditionType): Equal, Not equal, Exists, and Not exists.
    FsrmPropertyDefinitionType_Bool             = 0x00000007,
    ///A classification property that contains a date value. The date value is a 64-bit decimal number (see FILETIME)
    ///expressed as a string. The aggregation policy is to fail if two sources do not specify the same value. You can
    ///use the following comparison operators with this type (see FsrmPropertyConditionType): Equal, Not equal, Greater
    ///than, Less than, Exists, and Not exists.
    FsrmPropertyDefinitionType_Date             = 0x00000008,
}

///Flags the describe the type of classification property.
enum FsrmPropertyDefinitionFlags : int
{
    ///The FSRM classification property definition is defined globally, using group policy.
    FsrmPropertyDefinitionFlags_Global     = 0x00000001,
    ///The FSRM classification property definition is deprecated.
    FsrmPropertyDefinitionFlags_Deprecated = 0x00000002,
    FsrmPropertyDefinitionFlags_Secure     = 0x00000004,
}

///Flags that indicate what a FSRM classification property can be applied to.
enum FsrmPropertyDefinitionAppliesTo : int
{
    ///Indicates if a classification property can be applied to a file.
    FsrmPropertyDefinitionAppliesTo_Files   = 0x00000001,
    FsrmPropertyDefinitionAppliesTo_Folders = 0x00000002,
}

///Defines the types of rules that you can define.
enum FsrmRuleType : int
{
    ///The rule is unknown. Do not use this type.
    FsrmRuleType_Unknown        = 0x00000000,
    ///The rule defines how a classification module affects a file.
    FsrmRuleType_Classification = 0x00000001,
    ///For internal use only.
    FsrmRuleType_Generic        = 0x00000002,
}

///Defines the possible states of a rule.
enum FsrmRuleFlags : int
{
    ///Disable the rule; do not use the rule to classify files.
    FsrmRuleFlags_Disabled                             = 0x00000100,
    ///Clear any automatically classified property referenced by this rule if the rule conditions are no longer met.
    ///This can be useful if the file contents or metadata changed and the property previously assigned by automatic
    ///classification no longer apply. <b>Windows Server 2012 and Windows Server 2008 R2: </b>This enumeration value is
    ///not supported before Windows Server 2012 R2.
    FsrmRuleFlags_ClearAutomaticallyClassifiedProperty = 0x00000400,
    ///Clear any manually classified property referenced by this rule if the rule conditions are no longer met. This can
    ///be useful if the file contents or metadata changed and the property previously assigned by manual classification
    ///no longer apply. <b>Windows Server 2012 and Windows Server 2008 R2: </b>This enumeration value is not supported
    ///before Windows Server 2012 R2.
    FsrmRuleFlags_ClearManuallyClassifiedProperty      = 0x00000800,
    ///Do not set this flag. FSRM sets this flag if the classifier that uses the rule is either disabled or not
    ///registered with FSRM. If this flag is set FSRM will not use the rule to classify files.
    FsrmRuleFlags_Invalid                              = 0x00001000,
}

///Defines the different options for logging information while running classification.
enum FsrmClassificationLoggingFlags : int
{
    ///No logging occurs.
    FsrmClassificationLoggingFlags_None                       = 0x00000000,
    ///Logs to a log file information about all the files and properties that were classified.
    FsrmClassificationLoggingFlags_ClassificationsInLogFile   = 0x00000001,
    ///Logs to a log file errors that occurred during classification.
    FsrmClassificationLoggingFlags_ErrorsInLogFile            = 0x00000002,
    ///Logs to the System event information about all the files and properties that were classified.
    FsrmClassificationLoggingFlags_ClassificationsInSystemLog = 0x00000004,
    ///Logs to the System event log errors that occurred during classification.
    FsrmClassificationLoggingFlags_ErrorsInSystemLog          = 0x00000008,
}

///Defines the options for how to apply the rule to the file.
enum FsrmExecutionOption : int
{
    ///The execution option is unknown. Do not use this value.
    FsrmExecutionOption_Unknown                          = 0x00000000,
    ///The rule is applied as a default value to the file if the property is not set on the file (if none of the storage
    ///modules returns the property).
    FsrmExecutionOption_EvaluateUnset                    = 0x00000001,
    ///The rule is applied to the file considering default and existing values using aggregation rules (for aggregation
    ///rules, see FsrmPropertyDefinitionType).
    FsrmExecutionOption_ReEvaluate_ConsiderExistingValue = 0x00000002,
    ///The rule is applied to the file but default and existing values are ignored.
    FsrmExecutionOption_ReEvaluate_IgnoreExistingValue   = 0x00000003,
}

///Flags that define the capabilities of the storage module.
enum FsrmStorageModuleCaps : int
{
    ///The storage module's capabilities are unknown. Do not use this value.
    FsrmStorageModuleCaps_Unknown              = 0x00000000,
    ///The storage module is allowed to retrieve classification properties.
    FsrmStorageModuleCaps_CanGet               = 0x00000001,
    ///The storage module is allowed to store classification properties.
    FsrmStorageModuleCaps_CanSet               = 0x00000002,
    ///The storage module is allowed to handle folders. Only secure properties
    ///(<b>FsrmPropertyDefinitionFlags_Secure</b> flags set on the PropertyDefinitionFlags property) can be stored
    ///unless <b>FsrmStorageModuleCaps_CanHandleFiles</b> is also specified. <b>Windows Server 2008 R2: </b>This storage
    ///module capability is not supported before Windows Server 2012.
    FsrmStorageModuleCaps_CanHandleDirectories = 0x00000004,
    ///The storage module is allowed to handle files. <b>Windows Server 2008 R2: </b>This storage module capability is
    ///not supported before Windows Server 2012.
    FsrmStorageModuleCaps_CanHandleFiles       = 0x00000008,
}

///Defines the possible storage module types.
enum FsrmStorageModuleType : int
{
    ///The module type is unknown. Do not use this value.
    FsrmStorageModuleType_Unknown  = 0x00000000,
    ///The storage module caches classification properties for quick access. This type is reserved for use by FSRM and
    ///should not be used by any third party providers.
    FsrmStorageModuleType_Cache    = 0x00000001,
    ///The storage module stores classification properties within the file itself.
    FsrmStorageModuleType_InFile   = 0x00000002,
    ///The storage module stores classification properties in a database.
    FsrmStorageModuleType_Database = 0x00000003,
    ///The storage module stores classification properties in system data store. This type is reserved for use by FSRM
    ///and should not be used by any third party providers. <b>Windows Server 2008 R2: </b>This storage module type is
    ///not supported before Windows Server 2012.
    FsrmStorageModuleType_System   = 0x00000064,
}

///Defines flag values that provide additional information about the property bag.
enum FsrmPropertyBagFlags : int
{
    ///The properties in the property bag were updated by a classifier.
    FsrmPropertyBagFlags_UpdatedByClassifier         = 0x00000001,
    ///The properties in the property bag may only be partially classified because a failure occurred while loading
    ///properties from storage.
    FsrmPropertyBagFlags_FailedLoadingProperties     = 0x00000002,
    ///The properties in the property bag failed to be saved by the storage module with the highest precedence.
    FsrmPropertyBagFlags_FailedSavingProperties      = 0x00000004,
    ///The properties in the property bag may only be partially classified because a failure occurred while classifying
    ///properties.
    FsrmPropertyBagFlags_FailedClassifyingProperties = 0x00000008,
}

///Describes the type of property bag.
enum FsrmPropertyBagField : int
{
    ///Indicates if the property bag should include the name of the volume being accessed, which may be a snapshot.
    FsrmPropertyBagField_AccessVolume   = 0x00000000,
    ///Indicates if the property bag should include the volume <b>GUID</b> name of the original volume.
    FsrmPropertyBagField_VolumeGuidName = 0x00000001,
}

///Defines flag values that provide additional information about a classification property.
enum FsrmPropertyFlags : int
{
    FsrmPropertyFlags_None                        = 0x00000000,
    ///The property does not have a corresponding property definition defined in FSRM.
    FsrmPropertyFlags_Orphaned                    = 0x00000001,
    ///The value of the property was retrieved from the cache during this classification session.
    FsrmPropertyFlags_RetrievedFromCache          = 0x00000002,
    ///The value of the property was retrieved from the file or database during this classification session.
    FsrmPropertyFlags_RetrievedFromStorage        = 0x00000004,
    ///The value of the property was set by a classification rule during the last classification run.
    FsrmPropertyFlags_SetByClassifier             = 0x00000008,
    ///The property was deleted by IFsrmClassificationManager::ClearFileProperty.
    FsrmPropertyFlags_Deleted                     = 0x00000010,
    ///The property value from storage was changed to a different value by a classifier.
    FsrmPropertyFlags_Reclassified                = 0x00000020,
    ///There are values from multiple sources that could not be aggregated together.
    FsrmPropertyFlags_AggregationFailed           = 0x00000040,
    ///The property already exists in storage.
    FsrmPropertyFlags_Existing                    = 0x00000080,
    ///The property may only be partially classified because a failure occurred while loading properties from storage.
    FsrmPropertyFlags_FailedLoadingProperties     = 0x00000100,
    ///The property may only be partially classified because a failure occurred while classifying properties.
    FsrmPropertyFlags_FailedClassifyingProperties = 0x00000200,
    ///The property failed to be saved by the storage module with the highest precedence. <b>Windows Server 2008 R2:
    ///</b>This enumeration value is not supported before Windows Server 2012.
    FsrmPropertyFlags_FailedSavingProperties      = 0x00000400,
    ///The property is defined to be used for security purposes or came from secure storage. <b>Windows Server 2008 R2:
    ///</b>This enumeration value is not supported before Windows Server 2012.
    FsrmPropertyFlags_Secure                      = 0x00000800,
    ///The property value originally came from a classification policy. <b>Windows Server 2008 R2: </b>This enumeration
    ///value is not supported before Windows Server 2012.
    FsrmPropertyFlags_PolicyDerived               = 0x00001000,
    ///The property value was inherited from the property value of the file's parent folder. <b>Windows Server 2008 R2:
    ///</b>This enumeration value is not supported before Windows Server 2012.
    FsrmPropertyFlags_Inherited                   = 0x00002000,
    ///The property value was set manually. <b>Windows Server 2008 R2: </b>This enumeration value is not supported
    ///before Windows Server 2012.
    FsrmPropertyFlags_Manual                      = 0x00004000,
    ///An explicit property value was deleted and replaced with an inherited value. <b>Windows Server 2008 R2: </b>This
    ///enumeration value is not supported before Windows Server 2012.
    FsrmPropertyFlags_ExplicitValueDeleted        = 0x00008000,
    ///The property has been deleted due to a rule marked with clear property. <b>Windows Server 2012 and Windows Server
    ///2008 R2: </b>This enumeration value is not supported before Windows Server 2012 R2.
    FsrmPropertyFlags_PropertyDeletedFromClear    = 0x00010000,
    ///This mask shows which flags are used to indicate the source of the property and is equivalent to the following
    ///flag combination: <code>(FsrmPropertyFlags_RetrievedFromCache | FsrmPropertyFlags_RetrievedFromStorage |
    ///FsrmPropertyFlags_SetByClassifier)</code>
    FsrmPropertyFlags_PropertySourceMask          = 0x0000000e,
    ///This mask shows which flags are persisted by the cache and secure storage modules and is equivalent to the
    ///following flag combination: <code>(FsrmPropertyFlags_PolicyDerived | FsrmPropertyFlags_Manual)</code> <b>Windows
    ///Server 2008 R2: </b>This enumeration value is not supported before Windows Server 2012.
    FsrmPropertyFlags_PersistentMask              = 0x00005000,
}

///Defines the types of modules that you can define.
enum FsrmPipelineModuleType : int
{
    ///The module type is unknown; do not use this value.
    FsrmPipelineModuleType_Unknown    = 0x00000000,
    ///The module is a storage module. A storage module persists property values for the files that it supports.
    FsrmPipelineModuleType_Storage    = 0x00000001,
    ///The module is a classifier module. A classifier module assigns property values to files based on classification
    ///rules.
    FsrmPipelineModuleType_Classifier = 0x00000002,
}

///Flags that defines how classification properties associated with a file are retrieved.
enum FsrmGetFilePropertyOptions : int
{
    ///Retrieve the most up-to-date classification properties. Using this value may require more time than the
    ///<b>FsrmGetFilePropertyOptions_NoRuleEvaluation</b> value.
    FsrmGetFilePropertyOptions_None                = 0x00000000,
    ///Retrieve classification properties from cache or storage without using any rule evaluation.
    FsrmGetFilePropertyOptions_NoRuleEvaluation    = 0x00000001,
    ///After retrieving the classification properties (and possibly reclassifying the file in the process), store the
    ///classification properties with the file. <b>Windows Server 2008 R2: </b>This enumeration value is not supported
    ///before Windows Server 2012.
    FsrmGetFilePropertyOptions_Persistent          = 0x00000002,
    ///If the <b>FsrmGetFilePropertyOptions_Persistent</b> flag is set but the properties were unable to be stored with
    ///the file, return a failure for the operation. If this flag is clear the operation will not fail even though the
    ///properties were not persisted with the file. <b>Windows Server 2008 R2: </b>This enumeration value is not
    ///supported before Windows Server 2012.
    FsrmGetFilePropertyOptions_FailOnPersistErrors = 0x00000004,
    ///If the <b>FsrmGetFilePropertyOptions_Persistent</b> flag is set, skip any properties stored with the file that
    ///are not also defined for the machine. <b>Windows Server 2008 R2: </b>This enumeration value is not supported
    ///before Windows Server 2012.
    FsrmGetFilePropertyOptions_SkipOrphaned        = 0x00000008,
}

///Defines the file management job types.
enum FsrmFileManagementType : int
{
    ///The file management type is unknown; do not use this value.
    FsrmFileManagementType_Unknown    = 0x00000000,
    ///The file management job expires files meeting the specified criteria.
    FsrmFileManagementType_Expiration = 0x00000001,
    ///This file management job runs a custom action on files meeting the specified criteria.
    FsrmFileManagementType_Custom     = 0x00000002,
    ///The file management jobs runs an RMS action on files meeting the specified criteria. <b>Windows Server 2008 R2:
    ///</b>This enumeration value is not supported before Windows Server 2012.
    FsrmFileManagementType_Rms        = 0x00000003,
}

///Defines the options for logging when running a file management job.
enum FsrmFileManagementLoggingFlags : int
{
    ///Do not log events.
    FsrmFileManagementLoggingFlags_None        = 0x00000000,
    ///Log errors that occur when running the file management job to a log file.
    FsrmFileManagementLoggingFlags_Error       = 0x00000001,
    ///Log information status messages that occur when running the file management job to a log file.
    FsrmFileManagementLoggingFlags_Information = 0x00000002,
    ///Log information about every file that met all of the file management job's conditions to the Security audit log.
    FsrmFileManagementLoggingFlags_Audit       = 0x00000004,
}

///Defines the possible comparison operations that can be used to determine whether a property value of a file meets a
///particular condition.
enum FsrmPropertyConditionType : int
{
    ///The operator is unknown; do not use this value.
    FsrmPropertyConditionType_Unknown        = 0x00000000,
    ///The property condition is met if the property value is equal to a specified value.
    FsrmPropertyConditionType_Equal          = 0x00000001,
    ///The property condition is met if the property value is not equal to a specified value.
    FsrmPropertyConditionType_NotEqual       = 0x00000002,
    ///The property condition is met if the property value is greater than a specified value.
    FsrmPropertyConditionType_GreaterThan    = 0x00000003,
    ///The property condition is met if the property value is less than a specified value.
    FsrmPropertyConditionType_LessThan       = 0x00000004,
    ///The property condition is met if the property value contains the specified value.
    FsrmPropertyConditionType_Contain        = 0x00000005,
    ///The property condition is met if the property value exists.
    FsrmPropertyConditionType_Exist          = 0x00000006,
    ///The property condition is met if the property value does not exist.
    FsrmPropertyConditionType_NotExist       = 0x00000007,
    ///The property condition is met if the property value starts with the specified value.
    FsrmPropertyConditionType_StartWith      = 0x00000008,
    ///The property condition is met if the property value ends with the specified value.
    FsrmPropertyConditionType_EndWith        = 0x00000009,
    ///The property condition is met if the property value is contained in the specified value.
    FsrmPropertyConditionType_ContainedIn    = 0x0000000a,
    ///The property condition is met if the property value is a prefix of the specified value.
    FsrmPropertyConditionType_PrefixOf       = 0x0000000b,
    ///The property condition is met if the property value is a suffix of the specified value.
    FsrmPropertyConditionType_SuffixOf       = 0x0000000c,
    ///The property condition is met if the property value matches the specified pattern. The pattern format is a
    ///semicolon-separated list of wildcard patterns. For example "*.exe;*.com" <b>Windows Server 2008 R2: </b>This
    ///enumeration value is not supported before Windows Server 2012.
    FsrmPropertyConditionType_MatchesPattern = 0x0000000d,
}

///Defines the streaming modes to use for the file stream.
enum FsrmFileStreamingMode : int
{
    ///The streaming mode is unknown; do not use this value.
    FsrmFileStreamingMode_Unknown = 0x00000000,
    ///Use the streaming interface for reading from the file.
    FsrmFileStreamingMode_Read    = 0x00000001,
    ///Use the streaming interface for writing to the file.
    FsrmFileStreamingMode_Write   = 0x00000002,
}

///Defines the possible streaming interface types.
enum FsrmFileStreamingInterfaceType : int
{
    ///The streaming interface type is unknown; do not use this value.
    FsrmFileStreamingInterfaceType_Unknown    = 0x00000000,
    ///Use an ILockBytes interface to stream the file.
    FsrmFileStreamingInterfaceType_ILockBytes = 0x00000001,
    ///Use an IStream interface to stream the file.
    FsrmFileStreamingInterfaceType_IStream    = 0x00000002,
}

enum FsrmFileConditionType : int
{
    FsrmFileConditionType_Unknown  = 0x00000000,
    FsrmFileConditionType_Property = 0x00000001,
}

///Defines the possible types of file system property ids.
enum FsrmFileSystemPropertyId : int
{
    ///The file system property id is not used. This is the default.
    FsrmFileSystemPropertyId_Undefined        = 0x00000000,
    ///The file system property id is the filename, including the extension.
    FsrmFileSystemPropertyId_FileName         = 0x00000001,
    ///The file system property id is the file's creation time.
    FsrmFileSystemPropertyId_DateCreated      = 0x00000002,
    ///The file system property id is the file's last accessed time.
    FsrmFileSystemPropertyId_DateLastAccessed = 0x00000003,
    ///The file system property id is the file's last modified time.
    FsrmFileSystemPropertyId_DateLastModified = 0x00000004,
    ///The file system property id is the current time.
    FsrmFileSystemPropertyId_DateNow          = 0x00000005,
}

///Enumerates the type of the value being assigned to an FSRM property in a property condition.
enum FsrmPropertyValueType : int
{
    ///The type assigned to the property value is not defined.
    FsrmPropertyValueType_Undefined  = 0x00000000,
    ///The type assigned to the property value is one or more literal values.
    FsrmPropertyValueType_Literal    = 0x00000001,
    ///The type assigned to the property value is a date expression containing a date variable and an optional date
    ///offset.
    FsrmPropertyValueType_DateOffset = 0x00000002,
}

///Describes the possible types of access denied remediation (ADR) client display flags.
enum AdrClientDisplayFlags : int
{
    ///Indicates whether to send the user an email after an ADR event.
    AdrClientDisplayFlags_AllowEmailRequests        = 0x00000001,
    ///Indicates whether to show the user the offending device claims.
    AdrClientDisplayFlags_ShowDeviceTroubleshooting = 0x00000002,
}

///Describes the options for access denied remediation (ADR) email.
enum AdrEmailFlags : int
{
    ///The ADR email will include the owner on the To: line.
    AdrEmailFlags_PutDataOwnerOnToLine = 0x00000001,
    ///The ADR email will include the administrator on the To: line.
    AdrEmailFlags_PutAdminOnToLine     = 0x00000002,
    ///The ADR email will include the device claims.
    AdrEmailFlags_IncludeDeviceClaims  = 0x00000004,
    ///The ADR email will include the user information.
    AdrEmailFlags_IncludeUserInfo      = 0x00000008,
    ///When the ADR email is sent, an entry will be added to the event log.
    AdrEmailFlags_GenerateEventLog     = 0x00000010,
}

///Describes the possible access denied remediation (ADR) client error types.
enum AdrClientErrorType : int
{
    ///The ADR client error type is unknown.
    AdrClientErrorType_Unknown      = 0x00000000,
    ///The ADR client error type is access denied.
    AdrClientErrorType_AccessDenied = 0x00000001,
    AdrClientErrorType_FileNotFound = 0x00000002,
}

///Enumerates flags for indicating why an access denied remediation (ADR) client operation could not be performed.
enum AdrClientFlags : int
{
    ///No ADR client flags are specified.
    AdrClientFlags_None                       = 0x00000000,
    ///ADR client operations should fail when local paths are specified.
    AdrClientFlags_FailForLocalPaths          = 0x00000001,
    ///ADR client operations should fail if the operation is not supported by the server.
    AdrClientFlags_FailIfNotSupportedByServer = 0x00000002,
    ///ADR client operations should fail if the computer is not joined to a domain.
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

///Base class for all FSRM objects.
@GUID("22BCEF93-4A3F-4183-89F9-2F8B8A628AEE")
interface IFsrmObject : IDispatch
{
    ///Retrieves the identifier of the object. This property is read-only.
    HRESULT get_Id(GUID* id);
    ///Retrieves or sets the description of the object. This property is read/write.
    HRESULT get_Description(BSTR* description);
    ///Retrieves or sets the description of the object. This property is read/write.
    HRESULT put_Description(BSTR description);
    ///Removes the object from the server's list of objects.
    ///Returns:
    ///    The method returns the following return values.
    ///    
    HRESULT Delete();
    ///Saves the object in the server's list of objects.
    ///Returns:
    ///    The method returns the following return values as well as others depending of the object being committed.
    ///    
    HRESULT Commit();
}

///Defines a collection of FSRM objects. The following methods and properties return this collection: <ul> <li>
///IFsrmCommittableCollection::Commit </li> <li> IFsrmDerivedObjectsResult::DerivedObjects </li> <li>
///IFsrmDerivedObjectsResult::Results </li> <li> IFsrmFileScreenBase::EnumActions </li> <li>
///IFsrmPropertyDefinition2::ValueDefinitions </li> <li> IFsrmQuotaBase::EnumThresholdActions </li> <li>
///IFsrmReportJob::EnumReports </li> <li> IFsrmReportManager::EnumReportJobs </li> </ul>The collection is empty if the
///Count property is zero.
@GUID("F76FBF3B-8DDD-4B42-B05A-CB1C3FF1FEE8")
interface IFsrmCollection : IDispatch
{
    ///Retrieves the IUnknown pointer of a new IEnumVARIANT enumeration for the items in the collection. This property
    ///is read-only.
    HRESULT get__NewEnum(IUnknown* unknown);
    ///Retrieves the requested item from the collection. This property is read-only.
    HRESULT get_Item(int index, VARIANT* item);
    ///Retrieves the number of items in the collection. This property is read-only.
    HRESULT get_Count(int* count);
    ///Retrieves the state of the collection.<div class="alert"><b>Note</b> This method is not supported.</div> <div>
    ///</div> This property is read-only.
    HRESULT get_State(FsrmCollectionState* state);
    ///Cancels the collection of objects when the objects are collected asynchronously.<div class="alert"><b>Note</b>
    ///Asynchronous collections are not supported by FSRM, therefore this method is not implemented in the FSRM
    ///library.</div> <div> </div>
    ///Returns:
    ///    The method returns the following return values.
    ///    
    HRESULT Cancel();
    ///Limits the time that an asynchronous collection can take to collect the objects.<div class="alert"><b>Note</b>
    ///Asynchronous collections are not supported by FSRM, therefore this method always sets the <i>completed</i>
    ///parameter to <b>VARIANT_TRUE</b>.</div> <div> </div>
    ///Params:
    ///    waitSeconds = The number of seconds to wait for the collection to finish collecting objects. To wait indefinitely, set this
    ///                  parameter to –1.
    ///    completed = Is <b>VARIANT_TRUE</b> if the collection finished collecting objects in the time specified; otherwise,
    ///                <b>VARIANT_FALSE</b>.
    ///Returns:
    ///    This method is not supported and always returns <b>S_OK</b>.
    ///    
    HRESULT WaitForCompletion(int waitSeconds, short* completed);
    ///Retrieves the specified object from the collection.
    ///Params:
    ///    id = Identifies the object to retrieve from the collection.
    ///    entry = A <b>VARIANT</b> that contains the retrieved object. The variant type is <b>VT_DISPATCH</b>. Use the
    ///            <b>pdispVal</b> member to access the IDispatch interface of the object.
    ///Returns:
    ///    The method returns the following return values.
    ///    
    HRESULT GetById(GUID id, VARIANT* entry);
}

///Used to manage a collection of FSRM objects that can have objects added to or removed from the collection. The
///following properties return this interface: <ul> <li> IFsrmFileGroup::Members </li> <li> IFsrmFileGroup::NonMembers
///</li> <li> IFsrmFileScreenBase::BlockedFileGroups </li> <li> IFsrmFileScreenException::AllowedFileGroups </li> </ul>
@GUID("1BB617B8-3886-49DC-AF82-A6C90FA35DDA")
interface IFsrmMutableCollection : IFsrmCollection
{
    ///Adds an object to the collection.
    ///Params:
    ///    item = A <b>VARIANT</b> that contains the IDispatch interface of the object to add to the collection. Set the
    ///           variant type to <b>VT_DISPATCH</b> and the <b>pdispVal</b> member to the <b>IDispatch</b> interface of the
    ///           object.
    ///Returns:
    ///    The method returns the following return values.
    ///    
    HRESULT Add(VARIANT item);
    ///Removes the specified object from the collection using an index value.
    ///Params:
    ///    index = One-based index of the item to remove from the collection.
    ///Returns:
    ///    The method returns the following return values.
    ///    
    HRESULT Remove(int index);
    ///Removes the specified object from the collection using an object identifier.
    ///Params:
    ///    id = Identifies the object to remove from the collection.
    ///Returns:
    ///    The method returns the following return values.
    ///    
    HRESULT RemoveById(GUID id);
    ///Creates a duplicate IFsrmMutableCollection collection.<div class="alert"><b>Note</b> This method is not
    ///implemented in the FSRM library.</div> <div> </div>
    ///Params:
    ///    collection = An IFsrmMutableCollection interface to a collection that is a duplicate of this collection.
    ///Returns:
    ///    The method returns the following return values.
    ///    
    HRESULT Clone(IFsrmMutableCollection* collection);
}

///Defines a collection of FSRM objects that can have the same type of objects added to or removed from the collection.
///All objects in the collection can also be committed in a single batch operation. Committing objects in a batch
///operation provides better performance than committing each object in the collection individually. To create an empty
///collection, call the IFsrmQuotaManager::CreateQuotaCollection method. The following methods and properties return
///this collection: <ul> <li> IFsrmExportImport::ImportFileGroups </li> <li>
///IFsrmExportImport::ImportFileScreenTemplates </li> <li> IFsrmExportImport::ImportQuotaTemplates </li> <li>
///IFsrmFileGroupManager::EnumFileGroups </li> <li> IFsrmFileGroupManager::ImportFileGroups </li> <li>
///IFsrmFileScreenManager::CreateFileScreenCollection </li> <li> IFsrmFileScreenManager::EnumFileScreens </li> <li>
///IFsrmFileScreenManager::EnumFileScreenExceptions </li> <li> IFsrmFileScreenTemplateManager::EnumTemplates </li> <li>
///IFsrmFileScreenTemplateManager::ImportTemplates </li> <li> IFsrmQuotaManager::EnumAutoApplyQuotas </li> <li>
///IFsrmQuotaManager::EnumEffectiveQuotas </li> <li> IFsrmQuotaManager::EnumQuotas </li> <li>
///IFsrmQuotaTemplateManager::EnumTemplates </li> <li> IFsrmQuotaTemplateManager::ImportTemplates </li> </ul>The
///collection is empty if the IFsrmCollection::Count property is zero.
@GUID("96DEB3B5-8B91-4A2A-9D93-80A35D8AA847")
interface IFsrmCommittableCollection : IFsrmMutableCollection
{
    ///Commits all the objects of the collection and returns the commit results for each object.
    ///Params:
    ///    options = One or more options to use when committing the collection of objects. For possible values, see the
    ///              FsrmCommitOptions enumeration.
    ///    results = A collection of <b>HRESULT</b> values that correspond directly to the objects in the collection. The
    ///              <b>HRESULT</b> value indicates the success or failure of committing the object. If the method returns
    ///              <b>FSRM_S_PARTIAL_BATCH</b> or <b>FSRM_E_FAIL_BATCH</b>, check the results.
    ///Returns:
    ///    The method returns the following return values.
    ///    
    HRESULT Commit(FsrmCommitOptions options, IFsrmCollection* results);
}

///<p class="CCE_Message">[This interface is supported for compatibility but it's recommended to use the FSRM WMI
///Classes to manage FSRM. Please see the MSFT_FSRMAction, MSFT_FSRMFMJAction, and MSFT_FSRMFMJNotificationAction
///classes.] The base class for all FSRM action interfaces. To create an action, call one of the following methods: <ul>
///<li> IFsrmFileManagementJob::CreateNotificationAction </li> <li> IFsrmFileScreenBase::CreateAction </li> <li>
///IFsrmQuotaBase::CreateThresholdAction </li> </ul>Then, call the QueryInterface method of the returned interface for
///an interface of the specific action type. For an example, see Performing Actions Based on File Screen Violations. The
///following methods return a collection of actions: <ul> <li> IFsrmFileManagementJob::EnumNotificationActions </li>
///<li> IFsrmFileScreenBase::EnumActions </li> <li> IFsrmQuotaBase::EnumThresholdActions </li> </ul>To get this
///interface from an item of the collection, call the QueryInterface method on the IDispatch interface contained in the
///<b>pdispVal</b> member of the variant. Use the ActionType property to determine the type of action that this
///interface defines. You can then call the QueryInterface method on this interface to get an interface that defines the
///action type. The See Also section lists the possible interfaces.
@GUID("6CD6408A-AE60-463B-9EF1-E117534D69DC")
interface IFsrmAction : IDispatch
{
    ///<p class="CCE_Message">[This property is supported for compatibility but it's recommended to use the FSRM WMI
    ///Classes to manage FSRM. Please see the MSFT_FSRMAction, MSFT_FSRMFMJAction, and MSFT_FSRMFMJNotificationAction
    ///classes.] Retrieves the identifier of the action. This property is read-only.
    HRESULT get_Id(GUID* id);
    ///<p class="CCE_Message">[This property is supported for compatibility but it's recommended to use the FSRM WMI
    ///Classes to manage FSRM. Please see the MSFT_FSRMAction, MSFT_FSRMFMJAction, and MSFT_FSRMFMJNotificationAction
    ///classes.] Retrieves the action's type. This property is read-only.
    HRESULT get_ActionType(FsrmActionType* actionType);
    ///<p class="CCE_Message">[This property is supported for compatibility but it's recommended to use the FSRM WMI
    ///Classes to manage FSRM. Please see the MSFT_FSRMAction, MSFT_FSRMFMJAction, and MSFT_FSRMFMJNotificationAction
    ///classes.] Retrieves or sets the interval that must expire before the action is run again. This property is
    ///read/write.
    HRESULT get_RunLimitInterval(int* minutes);
    ///<p class="CCE_Message">[This property is supported for compatibility but it's recommended to use the FSRM WMI
    ///Classes to manage FSRM. Please see the MSFT_FSRMAction, MSFT_FSRMFMJAction, and MSFT_FSRMFMJNotificationAction
    ///classes.] Retrieves or sets the interval that must expire before the action is run again. This property is
    ///read/write.
    HRESULT put_RunLimitInterval(int minutes);
    ///<p class="CCE_Message">[This method is supported for compatibility but it's recommended to use the FSRM WMI
    ///Classes to manage FSRM. Please see the MSFT_FSRMAction, MSFT_FSRMFMJAction, and MSFT_FSRMFMJNotificationAction
    ///classes.] Removes the action from the quota or file screen's list of actions.
    ///Returns:
    ///    The method returns the following return values.
    ///    
    HRESULT Delete();
}

///<p class="CCE_Message">[This interface is supported for compatibility but it's recommended to use the FSRM WMI
///Classes to manage FSRM. Please see the MSFT_FSRMAction, MSFT_FSRMFMJAction, and MSFT_FSRMFMJNotificationAction
///classes.] Used to send an email message in response to a quota or file screen event. To create an email action, call
///one of the following methods and specify <b>FsrmActionType_Email</b> as the action type: <ul> <li>
///IFsrmFileScreenBase::CreateAction </li> <li> IFsrmQuotaBase::CreateThresholdAction </li> </ul>The create methods
///return an IFsrmAction interface. To get this interface, call the QueryInterface method and specify
///<b>IID_IFsrmActionEmail</b> as the interface identifier. For file management jobs, see the IFsrmActionEmail2
///interface.
@GUID("D646567D-26AE-4CAA-9F84-4E0AAD207FCA")
interface IFsrmActionEmail : IFsrmAction
{
    ///<p class="CCE_Message">[This property is supported for compatibility but it's recommended to use the FSRM WMI
    ///Classes to manage FSRM. Please see the MSFT_FSRMAction, MSFT_FSRMFMJAction, and MSFT_FSRMFMJNotificationAction
    ///classes.] Retrieves or sets the email address to use as the sender of the email when the action generates an
    ///email message. This property is read/write.
    HRESULT get_MailFrom(BSTR* mailFrom);
    ///<p class="CCE_Message">[This property is supported for compatibility but it's recommended to use the FSRM WMI
    ///Classes to manage FSRM. Please see the MSFT_FSRMAction, MSFT_FSRMFMJAction, and MSFT_FSRMFMJNotificationAction
    ///classes.] Retrieves or sets the email address to use as the sender of the email when the action generates an
    ///email message. This property is read/write.
    HRESULT put_MailFrom(BSTR mailFrom);
    ///<p class="CCE_Message">[This property is supported for compatibility but it's recommended to use the FSRM WMI
    ///Classes to manage FSRM. Please see the MSFT_FSRMAction, MSFT_FSRMFMJAction, and MSFT_FSRMFMJNotificationAction
    ///classes.] Retrieves or sets the email address to use as the reply-to address when the recipient of the email
    ///message replies. This property is read/write.
    HRESULT get_MailReplyTo(BSTR* mailReplyTo);
    ///<p class="CCE_Message">[This property is supported for compatibility but it's recommended to use the FSRM WMI
    ///Classes to manage FSRM. Please see the MSFT_FSRMAction, MSFT_FSRMFMJAction, and MSFT_FSRMFMJNotificationAction
    ///classes.] Retrieves or sets the email address to use as the reply-to address when the recipient of the email
    ///message replies. This property is read/write.
    HRESULT put_MailReplyTo(BSTR mailReplyTo);
    ///<p class="CCE_Message">[This property is supported for compatibility but it's recommended to use the FSRM WMI
    ///Classes to manage FSRM. Please see the MSFT_FSRMAction, MSFT_FSRMFMJAction, and MSFT_FSRMFMJNotificationAction
    ///classes.] Retrieves or sets the email address to which email is sent when this action generates email. This
    ///property is read/write.
    HRESULT get_MailTo(BSTR* mailTo);
    ///<p class="CCE_Message">[This property is supported for compatibility but it's recommended to use the FSRM WMI
    ///Classes to manage FSRM. Please see the MSFT_FSRMAction, MSFT_FSRMFMJAction, and MSFT_FSRMFMJNotificationAction
    ///classes.] Retrieves or sets the email address to which email is sent when this action generates email. This
    ///property is read/write.
    HRESULT put_MailTo(BSTR mailTo);
    ///<p class="CCE_Message">[This property is supported for compatibility but it's recommended to use the FSRM WMI
    ///Classes to manage FSRM. Please see the MSFT_FSRMAction, MSFT_FSRMFMJAction, and MSFT_FSRMFMJNotificationAction
    ///classes.] Retrieves or sets the carbon copy (Cc) email address to which email is sent when this action generates
    ///email. This property is read/write.
    HRESULT get_MailCc(BSTR* mailCc);
    ///<p class="CCE_Message">[This property is supported for compatibility but it's recommended to use the FSRM WMI
    ///Classes to manage FSRM. Please see the MSFT_FSRMAction, MSFT_FSRMFMJAction, and MSFT_FSRMFMJNotificationAction
    ///classes.] Retrieves or sets the carbon copy (Cc) email address to which email is sent when this action generates
    ///email. This property is read/write.
    HRESULT put_MailCc(BSTR mailCc);
    ///<p class="CCE_Message">[This property is supported for compatibility but it's recommended to use the FSRM WMI
    ///Classes to manage FSRM. Please see the MSFT_FSRMAction, MSFT_FSRMFMJAction, and MSFT_FSRMFMJNotificationAction
    ///classes.] Retrieves or sets the blind carbon copy (Bcc) email address to which email is sent when this action
    ///generates email. This property is read/write.
    HRESULT get_MailBcc(BSTR* mailBcc);
    ///<p class="CCE_Message">[This property is supported for compatibility but it's recommended to use the FSRM WMI
    ///Classes to manage FSRM. Please see the MSFT_FSRMAction, MSFT_FSRMFMJAction, and MSFT_FSRMFMJNotificationAction
    ///classes.] Retrieves or sets the blind carbon copy (Bcc) email address to which email is sent when this action
    ///generates email. This property is read/write.
    HRESULT put_MailBcc(BSTR mailBcc);
    ///<p class="CCE_Message">[This property is supported for compatibility but it's recommended to use the FSRM WMI
    ///Classes to manage FSRM. Please see the MSFT_FSRMAction, MSFT_FSRMFMJAction, and MSFT_FSRMFMJNotificationAction
    ///classes.] Retrieves or sets the subject of the email that is sent when this action generates email. This property
    ///is read/write.
    HRESULT get_MailSubject(BSTR* mailSubject);
    ///<p class="CCE_Message">[This property is supported for compatibility but it's recommended to use the FSRM WMI
    ///Classes to manage FSRM. Please see the MSFT_FSRMAction, MSFT_FSRMFMJAction, and MSFT_FSRMFMJNotificationAction
    ///classes.] Retrieves or sets the subject of the email that is sent when this action generates email. This property
    ///is read/write.
    HRESULT put_MailSubject(BSTR mailSubject);
    ///<p class="CCE_Message">[This property is supported for compatibility but it's recommended to use the FSRM WMI
    ///Classes to manage FSRM. Please see the MSFT_FSRMAction, MSFT_FSRMFMJAction, and MSFT_FSRMFMJNotificationAction
    ///classes.] Retrieves or sets the message text of the email that is sent when this action generates email. This
    ///property is read/write.
    HRESULT get_MessageText(BSTR* messageText);
    ///<p class="CCE_Message">[This property is supported for compatibility but it's recommended to use the FSRM WMI
    ///Classes to manage FSRM. Please see the MSFT_FSRMAction, MSFT_FSRMFMJAction, and MSFT_FSRMFMJNotificationAction
    ///classes.] Retrieves or sets the message text of the email that is sent when this action generates email. This
    ///property is read/write.
    HRESULT put_MessageText(BSTR messageText);
}

///<p class="CCE_Message">[This interface is supported for compatibility but it's recommended to use the FSRM WMI
///Classes to manage FSRM. Please see the MSFT_FSRMAction, MSFT_FSRMFMJAction, and MSFT_FSRMFMJNotificationAction
///classes.] Used to limit the number of expired files listed in the email notification. Use this version of the
///interface for file management notifications. To create an email action for file management notifications, call the
///IFsrmFileManagementJob::CreateNotificationAction method and specify <b>FsrmActionType_Email</b> as the action type.
///The CreateNotificationAction method returns an IFsrmAction interface. To get this interface, call the QueryInterface
///method and specify <b>IID_IFsrmActionEmail2</b> as the interface identifier.
@GUID("8276702F-2532-4839-89BF-4872609A2EA4")
interface IFsrmActionEmail2 : IFsrmActionEmail
{
    ///<p class="CCE_Message">[This property is supported for compatibility but it's recommended to use the FSRM WMI
    ///Classes to manage FSRM. Please see the MSFT_FSRMAction, MSFT_FSRMFMJAction, and MSFT_FSRMFMJNotificationAction
    ///classes.] The maximum number of files to include in the list. This property is read/write.
    HRESULT get_AttachmentFileListSize(int* attachmentFileListSize);
    ///<p class="CCE_Message">[This property is supported for compatibility but it's recommended to use the FSRM WMI
    ///Classes to manage FSRM. Please see the MSFT_FSRMAction, MSFT_FSRMFMJAction, and MSFT_FSRMFMJNotificationAction
    ///classes.] The maximum number of files to include in the list. This property is read/write.
    HRESULT put_AttachmentFileListSize(int attachmentFileListSize);
}

///<p class="CCE_Message">[This interface is supported for compatibility but it's recommended to use the FSRM WMI
///Classes to manage FSRM. Please see the MSFT_FSRMAction, MSFT_FSRMFMJAction, and MSFT_FSRMFMJNotificationAction
///classes.] Used to generate a report in response to a quota or file screen event. To create a report action, call one
///of the following methods and specify <b>FsrmActionType_Report</b> as the action type: <ul> <li>
///IFsrmFileScreenBase::CreateAction </li> <li> IFsrmQuotaBase::CreateThresholdAction </li> </ul>The create methods
///return an IFsrmAction interface. To get this interface, call the QueryInterface method and specify
///<b>IID_IFsrmActionReport</b> as the interface identifier.
@GUID("2DBE63C4-B340-48A0-A5B0-158E07FC567E")
interface IFsrmActionReport : IFsrmAction
{
    ///<p class="CCE_Message">[This property is supported for compatibility but it's recommended to use the FSRM WMI
    ///Classes to manage FSRM. Please see the MSFT_FSRMAction, MSFT_FSRMFMJAction, and MSFT_FSRMFMJNotificationAction
    ///classes.] Retrieves or sets the types of reports to generate. This property is read/write.
    HRESULT get_ReportTypes(SAFEARRAY** reportTypes);
    ///<p class="CCE_Message">[This property is supported for compatibility but it's recommended to use the FSRM WMI
    ///Classes to manage FSRM. Please see the MSFT_FSRMAction, MSFT_FSRMFMJAction, and MSFT_FSRMFMJNotificationAction
    ///classes.] Retrieves or sets the types of reports to generate. This property is read/write.
    HRESULT put_ReportTypes(SAFEARRAY* reportTypes);
    ///<p class="CCE_Message">[This property is supported for compatibility but it's recommended to use the FSRM WMI
    ///Classes to manage FSRM. Please see the MSFT_FSRMAction, MSFT_FSRMFMJAction, and MSFT_FSRMFMJNotificationAction
    ///classes.] Retrieves or sets the email address to which the reports are sent. This property is read/write.
    HRESULT get_MailTo(BSTR* mailTo);
    ///<p class="CCE_Message">[This property is supported for compatibility but it's recommended to use the FSRM WMI
    ///Classes to manage FSRM. Please see the MSFT_FSRMAction, MSFT_FSRMFMJAction, and MSFT_FSRMFMJNotificationAction
    ///classes.] Retrieves or sets the email address to which the reports are sent. This property is read/write.
    HRESULT put_MailTo(BSTR mailTo);
}

///<p class="CCE_Message">[This interface is supported for compatibility but it's recommended to use the FSRM WMI
///Classes to manage FSRM. Please see the MSFT_FSRMAction, MSFT_FSRMFMJAction, and MSFT_FSRMFMJNotificationAction
///classes.] Used to log an event to the Windows Application event log in response to a quota, file screen, or file
///management job event. To create an event log action, call one of the following methods and specify
///<b>FsrmActionType_EventLog</b> as the action type: <ul> <li> IFsrmFileManagementJob::CreateNotificationAction </li>
///<li> IFsrmFileScreenBase::CreateAction </li> <li> IFsrmQuotaBase::CreateThresholdAction </li> </ul>The create methods
///return an IFsrmAction interface. To get this interface, call the QueryInterface method and specify
///<b>IID_IFsrmActionEventLog</b> as the interface identifier.
@GUID("4C8F96C3-5D94-4F37-A4F4-F56AB463546F")
interface IFsrmActionEventLog : IFsrmAction
{
    ///<p class="CCE_Message">[This property is supported for compatibility but it's recommended to use the FSRM WMI
    ///Classes to manage FSRM. Please see the MSFT_FSRMAction, MSFT_FSRMFMJAction, and MSFT_FSRMFMJNotificationAction
    ///classes.] Retrieves or sets the type of event that the action logs when it runs. This property is read/write.
    HRESULT get_EventType(FsrmEventType* eventType);
    ///<p class="CCE_Message">[This property is supported for compatibility but it's recommended to use the FSRM WMI
    ///Classes to manage FSRM. Please see the MSFT_FSRMAction, MSFT_FSRMFMJAction, and MSFT_FSRMFMJNotificationAction
    ///classes.] Retrieves or sets the type of event that the action logs when it runs. This property is read/write.
    HRESULT put_EventType(FsrmEventType eventType);
    ///<p class="CCE_Message">[This property is supported for compatibility but it's recommended to use the FSRM WMI
    ///Classes to manage FSRM. Please see the MSFT_FSRMAction, MSFT_FSRMFMJAction, and MSFT_FSRMFMJNotificationAction
    ///classes.] Retrieves or sets the event text that is logged when the action runs. This property is read/write.
    HRESULT get_MessageText(BSTR* messageText);
    ///<p class="CCE_Message">[This property is supported for compatibility but it's recommended to use the FSRM WMI
    ///Classes to manage FSRM. Please see the MSFT_FSRMAction, MSFT_FSRMFMJAction, and MSFT_FSRMFMJNotificationAction
    ///classes.] Retrieves or sets the event text that is logged when the action runs. This property is read/write.
    HRESULT put_MessageText(BSTR messageText);
}

///<p class="CCE_Message">[This interface is supported for compatibility but it's recommended to use the FSRM WMI
///Classes to manage FSRM. Please see the MSFT_FSRMAction, MSFT_FSRMFMJAction, and MSFT_FSRMFMJNotificationAction
///classes.] Used to run a command or script in response to a quota, file screen, or file management job event. To
///create a command action, call one of the following methods and specify <b>FsrmActionType_Command</b> as the action
///type: <ul> <li> IFsrmFileManagementJob::CreateNotificationAction </li> <li> IFsrmFileScreenBase::CreateAction </li>
///<li> IFsrmQuotaBase::CreateThresholdAction </li> </ul>The create methods return an IFsrmAction interface. To get this
///interface, call the QueryInterface method and specify <b>IID_IFsrmActionCommand</b> as the interface identifier.
@GUID("12937789-E247-4917-9C20-F3EE9C7EE783")
interface IFsrmActionCommand : IFsrmAction
{
    ///<p class="CCE_Message">[This property is supported for compatibility but it's recommended to use the FSRM WMI
    ///Classes to manage FSRM. Please see the MSFT_FSRMAction, MSFT_FSRMFMJAction, and MSFT_FSRMFMJNotificationAction
    ///classes.] Retrieves or sets the full path to the executable program or script to run. This property is
    ///read/write.
    HRESULT get_ExecutablePath(BSTR* executablePath);
    ///<p class="CCE_Message">[This property is supported for compatibility but it's recommended to use the FSRM WMI
    ///Classes to manage FSRM. Please see the MSFT_FSRMAction, MSFT_FSRMFMJAction, and MSFT_FSRMFMJNotificationAction
    ///classes.] Retrieves or sets the full path to the executable program or script to run. This property is
    ///read/write.
    HRESULT put_ExecutablePath(BSTR executablePath);
    ///<p class="CCE_Message">[This property is supported for compatibility but it's recommended to use the FSRM WMI
    ///Classes to manage FSRM. Please see the MSFT_FSRMAction, MSFT_FSRMFMJAction, and MSFT_FSRMFMJNotificationAction
    ///classes.] Retrieves or sets the arguments to pass to the executable program specified in the ExecutablePath
    ///property. This property is read/write.
    HRESULT get_Arguments(BSTR* arguments);
    ///<p class="CCE_Message">[This property is supported for compatibility but it's recommended to use the FSRM WMI
    ///Classes to manage FSRM. Please see the MSFT_FSRMAction, MSFT_FSRMFMJAction, and MSFT_FSRMFMJNotificationAction
    ///classes.] Retrieves or sets the arguments to pass to the executable program specified in the ExecutablePath
    ///property. This property is read/write.
    HRESULT put_Arguments(BSTR arguments);
    ///<p class="CCE_Message">[This property is supported for compatibility but it's recommended to use the FSRM WMI
    ///Classes to manage FSRM. Please see the MSFT_FSRMAction, MSFT_FSRMFMJAction, and MSFT_FSRMFMJNotificationAction
    ///classes.] Retrieves or sets the system account that is used to run the executable program specified in the
    ///ExecutablePath property. This property is read/write.
    HRESULT get_Account(FsrmAccountType* account);
    ///<p class="CCE_Message">[This property is supported for compatibility but it's recommended to use the FSRM WMI
    ///Classes to manage FSRM. Please see the MSFT_FSRMAction, MSFT_FSRMFMJAction, and MSFT_FSRMFMJNotificationAction
    ///classes.] Retrieves or sets the system account that is used to run the executable program specified in the
    ///ExecutablePath property. This property is read/write.
    HRESULT put_Account(FsrmAccountType account);
    ///<p class="CCE_Message">[This property is supported for compatibility but it's recommended to use the FSRM WMI
    ///Classes to manage FSRM. Please see the MSFT_FSRMAction, MSFT_FSRMFMJAction, and MSFT_FSRMFMJNotificationAction
    ///classes.] Retrieves or sets the working directory in which the executable program will run. This property is
    ///read/write.
    HRESULT get_WorkingDirectory(BSTR* workingDirectory);
    ///<p class="CCE_Message">[This property is supported for compatibility but it's recommended to use the FSRM WMI
    ///Classes to manage FSRM. Please see the MSFT_FSRMAction, MSFT_FSRMFMJAction, and MSFT_FSRMFMJNotificationAction
    ///classes.] Retrieves or sets the working directory in which the executable program will run. This property is
    ///read/write.
    HRESULT put_WorkingDirectory(BSTR workingDirectory);
    ///<p class="CCE_Message">[This property is supported for compatibility but it's recommended to use the FSRM WMI
    ///Classes to manage FSRM. Please see the MSFT_FSRMAction, MSFT_FSRMFMJAction, and MSFT_FSRMFMJNotificationAction
    ///classes.] Retrieves or sets a value that determines whether FSRM will monitor the executable program specified in
    ///the ExecutablePath property. This property is read/write.
    HRESULT get_MonitorCommand(short* monitorCommand);
    ///<p class="CCE_Message">[This property is supported for compatibility but it's recommended to use the FSRM WMI
    ///Classes to manage FSRM. Please see the MSFT_FSRMAction, MSFT_FSRMFMJAction, and MSFT_FSRMFMJNotificationAction
    ///classes.] Retrieves or sets a value that determines whether FSRM will monitor the executable program specified in
    ///the ExecutablePath property. This property is read/write.
    HRESULT put_MonitorCommand(short monitorCommand);
    ///<p class="CCE_Message">[This property is supported for compatibility but it's recommended to use the FSRM WMI
    ///Classes to manage FSRM. Please see the MSFT_FSRMAction, MSFT_FSRMFMJAction, and MSFT_FSRMFMJNotificationAction
    ///classes.] Retrieves or sets the number of minutes the server waits before terminating the process that is running
    ///the executable program specified in the ExecutablePath property. This property is read/write.
    HRESULT get_KillTimeOut(int* minutes);
    ///<p class="CCE_Message">[This property is supported for compatibility but it's recommended to use the FSRM WMI
    ///Classes to manage FSRM. Please see the MSFT_FSRMAction, MSFT_FSRMFMJAction, and MSFT_FSRMFMJNotificationAction
    ///classes.] Retrieves or sets the number of minutes the server waits before terminating the process that is running
    ///the executable program specified in the ExecutablePath property. This property is read/write.
    HRESULT put_KillTimeOut(int minutes);
    ///<p class="CCE_Message">[This property is supported for compatibility but it's recommended to use the FSRM WMI
    ///Classes to manage FSRM. Please see the MSFT_FSRMAction, MSFT_FSRMFMJAction, and MSFT_FSRMFMJNotificationAction
    ///classes.] Retrieves or sets a value that determines whether FSRM logs an Application event that contains the
    ///return code of the executable program. This property is read/write.
    HRESULT get_LogResult(short* logResults);
    ///<p class="CCE_Message">[This property is supported for compatibility but it's recommended to use the FSRM WMI
    ///Classes to manage FSRM. Please see the MSFT_FSRMAction, MSFT_FSRMFMJAction, and MSFT_FSRMFMJNotificationAction
    ///classes.] Retrieves or sets a value that determines whether FSRM logs an Application event that contains the
    ///return code of the executable program. This property is read/write.
    HRESULT put_LogResult(short logResults);
}

///Used to configure FSRM. To get this interface, call the CoCreateInstanceEx function. Use <b>CLSID_FsrmSetting</b> as
///the class identifier and <code>__uuidof(IFsrmSetting)</code> as the interface identifier.
@GUID("F411D4FD-14BE-4260-8C40-03B7C95E608A")
interface IFsrmSetting : IDispatch
{
    ///Retrieves or sets the SMTP server that FSRM uses to send email. This property is read/write.
    HRESULT get_SmtpServer(BSTR* smtpServer);
    ///Retrieves or sets the SMTP server that FSRM uses to send email. This property is read/write.
    HRESULT put_SmtpServer(BSTR smtpServer);
    ///Retrieves or sets the default email address from which email messages are sent. This property is read/write.
    HRESULT get_MailFrom(BSTR* mailFrom);
    ///Retrieves or sets the default email address from which email messages are sent. This property is read/write.
    HRESULT put_MailFrom(BSTR mailFrom);
    ///Retrieves or sets the email address for the administrator. This property is read/write.
    HRESULT get_AdminEmail(BSTR* adminEmail);
    ///Retrieves or sets the email address for the administrator. This property is read/write.
    HRESULT put_AdminEmail(BSTR adminEmail);
    ///Retrieves or sets a value that determines whether FSRM prevents command line actions from running. This property
    ///is read/write.
    HRESULT get_DisableCommandLine(short* disableCommandLine);
    ///Retrieves or sets a value that determines whether FSRM prevents command line actions from running. This property
    ///is read/write.
    HRESULT put_DisableCommandLine(short disableCommandLine);
    ///Retrieves or sets a value that determines whether FSRM keeps audit records of the file screen violations. This
    ///property is read/write.
    HRESULT get_EnableScreeningAudit(short* enableScreeningAudit);
    ///Retrieves or sets a value that determines whether FSRM keeps audit records of the file screen violations. This
    ///property is read/write.
    HRESULT put_EnableScreeningAudit(short enableScreeningAudit);
    ///Send an email message to the specified email address.
    ///Params:
    ///    mailTo = The email address. The string is limited to 255 characters.
    ///Returns:
    ///    The method returns the following return codes:
    ///    
    HRESULT EmailTest(BSTR mailTo);
    ///Sets the time that an action that uses the global run limit interval must wait before the action is run again.
    ///Params:
    ///    actionType = The action type to limit. For possible values, see the FsrmActionType enumeration.
    ///    delayTimeMinutes = The run limit interval, in minutes, to use for the action. The default is 60 minutes.
    ///Returns:
    ///    The method returns the following return values.
    ///    
    HRESULT SetActionRunLimitInterval(FsrmActionType actionType, int delayTimeMinutes);
    ///Gets the time that an action that uses the global run limit interval must wait before the action is run again.
    ///Params:
    ///    actionType = The action type to limit. For possible values, see the FsrmActionType enumeration.
    ///    delayTimeMinutes = The run limit interval, in minutes, that is used for the action.
    ///Returns:
    ///    Returns the following return values:
    ///    
    HRESULT GetActionRunLimitInterval(FsrmActionType actionType, int* delayTimeMinutes);
}

///Used to retrieve the network share paths that are mapped to a local path. To get this interface, call the
///CoCreateInstanceEx function. Use <b>CLSID_FsrmPathMapper</b> as the class identifier and
///<code>__uuidof(IFsrmPathMapper)</code> as the interface identifier.
@GUID("6F4DBFFF-6920-4821-A6C3-B7E94C1FD60C")
interface IFsrmPathMapper : IDispatch
{
    ///Retrieves a list of network shares that point to the specified local path.
    ///Params:
    ///    localPath = The local path. The string is limited to 260 characters.
    ///    sharePaths = A <b>SAFEARRAY</b> of <b>VARIANT</b>s. Each <b>VARIANT</b> contains a network share path that points to the
    ///                 local path. The variant type is <b>VT_BSTR</b>. Use the <b>bstrVal</b> member to access the share path.
    ///Returns:
    ///    The method returns the following return values.
    ///    
    HRESULT GetSharePathsForLocalPath(BSTR localPath, SAFEARRAY** sharePaths);
}

///Used to export and import FSRM objects. <div class="alert"><b>Note</b> This interface supports local use only. Remote
///operations are not supported.</div><div> </div>To get this interface, call the CoCreateInstanceEx function. Use
///<b>CLSID_FsrmExportImport</b> as the class identifier and <code>__uuidof(IFsrmExportImport)</code> as the interface
///identifier. You must use the <b>CLSCTX_INPROC_SERVER</b> class context to create the object.
@GUID("EFCB0AB1-16C4-4A79-812C-725614C3306B")
interface IFsrmExportImport : IDispatch
{
    ///Exports one or more file groups to the specified file.
    ///Params:
    ///    filePath = The full path to the export file that will contain the file groups in XML format. The string is limited to
    ///               260 characters.
    ///    fileGroupNamesSafeArray = A variant that contains the names of the file groups to export. Set the variant to empty or <b>NULL</b> to
    ///                              export all file groups. Set the variant type to both <b>VT_ARRAY</b> and <b>VT_VARIANT</b> and the
    ///                              <b>parray</b> member to the <b>SAFEARRAY</b> of <b>BSTR</b>s.
    ///    remoteHost = The name of the remote server. To specify the local server, set to an empty string.
    ///Returns:
    ///    This method can return the following error codes.
    ///    
    HRESULT ExportFileGroups(BSTR filePath, VARIANT* fileGroupNamesSafeArray, BSTR remoteHost);
    ///Imports one or more file groups from the specified file.
    ///Params:
    ///    filePath = The full path to the file from which to import the file groups. The string is limited to 260 characters.
    ///    fileGroupNamesSafeArray = A variant that contains the names of the file groups to import. Set the variant to empty or <b>NULL</b> to
    ///                              import all file groups. Set the variant type to both <b>VT_ARRAY</b> and <b>VT_VARIANT</b> and the
    ///                              <b>parray</b> member to the <b>SAFEARRAY</b> of <b>BSTR</b>s.
    ///    remoteHost = The name of the remote server. To specify the local server, set to an empty string.
    ///    fileGroups = An IFsrmCommittableCollection interface that contains a collection of IFsrmFileGroupImported interfaces. To
    ///                 complete the import, you must call the IFsrmFileGroupImported::Commit method.
    ///Returns:
    ///    The method returns the following return values.
    ///    
    HRESULT ImportFileGroups(BSTR filePath, VARIANT* fileGroupNamesSafeArray, BSTR remoteHost, 
                             IFsrmCommittableCollection* fileGroups);
    ///Exports one or more file screen templates to the specified file.
    ///Params:
    ///    filePath = The full path to the export file that will contain the file screen templates in XML format. The string is
    ///               limited to 260 characters.
    ///    templateNamesSafeArray = A variant that contains the names of the file screen templates to export. Set the variant to empty or
    ///                             <b>NULL</b> to export all templates. Set the variant type to both <b>VT_ARRAY</b> and <b>VT_VARIANT</b> and
    ///                             the <b>parray</b> member to the <b>SAFEARRAY</b> of <b>BSTR</b>s.
    ///    remoteHost = The name of the remote server. To specify the local server, set to an empty string.
    ///Returns:
    ///    This method can return the following error codes.
    ///    
    HRESULT ExportFileScreenTemplates(BSTR filePath, VARIANT* templateNamesSafeArray, BSTR remoteHost);
    ///Imports one or more file screen templates from the specified file.
    ///Params:
    ///    filePath = The full path to the file from which to import the file screen templates. The string is limited to 260
    ///               characters.
    ///    templateNamesSafeArray = A variant that contains the names of the file screen templates to import. Set the variant to empty or
    ///                             <b>NULL</b> to import all templates. Set the variant type to both <b>VT_ARRAY</b> and <b>VT_VARIANT</b> and
    ///                             the <b>parray</b> member to the <b>SAFEARRAY</b> of <b>BSTR</b>s.
    ///    remoteHost = The name of the remote server. To specify the local server, set to an empty string.
    ///    templates = An IFsrmCommittableCollection interface that contains a collection of IFsrmFileScreenTemplateImported
    ///                interfaces. To complete the import, you must call the IFsrmFileScreenTemplateImported::Commit method.
    ///Returns:
    ///    The method returns the following return values.
    ///    
    HRESULT ImportFileScreenTemplates(BSTR filePath, VARIANT* templateNamesSafeArray, BSTR remoteHost, 
                                      IFsrmCommittableCollection* templates);
    ///Exports one or more quota templates to the specified file.
    ///Params:
    ///    filePath = The full path to the export file that will contain the quota templates in XML format. The string is limited
    ///               to 260 characters.
    ///    templateNamesSafeArray = A variant that contains the names of the quota templates to export. Set the variant to empty or <b>NULL</b>
    ///                             to export all templates. Set the variant type to both <b>VT_ARRAY</b> and <b>VT_VARIANT</b> and the
    ///                             <b>parray</b> member to the <b>SAFEARRAY</b> of <b>BSTR</b>s.
    ///    remoteHost = The name of the remote server. To specify the local server, set to an empty string.
    ///Returns:
    ///    This method can return the following error codes.
    ///    
    HRESULT ExportQuotaTemplates(BSTR filePath, VARIANT* templateNamesSafeArray, BSTR remoteHost);
    ///Imports one or more quota templates from the specified file.
    ///Params:
    ///    filePath = The full path to the file from which to import the quota templates. The string is limited to 260 characters.
    ///    templateNamesSafeArray = A variant that contains the names of the quota templates to import. Set the variant to empty or <b>NULL</b>
    ///                             to import all templates. Set the variant type to both <b>VT_ARRAY</b> and <b>VT_VARIANT</b> and the
    ///                             <b>parray</b> member to the <b>SAFEARRAY</b> of <b>BSTR</b>s.
    ///    remoteHost = The name of the remote server. To specify the local server, set to an empty string.
    ///    templates = An IFsrmCommittableCollection interface that contains a collection of IFsrmQuotaTemplateImported interfaces.
    ///                To complete the import, you must call the IFsrmQuotaTemplateImported::Commit method.
    ///Returns:
    ///    The method returns the following return values.
    ///    
    HRESULT ImportQuotaTemplates(BSTR filePath, VARIANT* templateNamesSafeArray, BSTR remoteHost, 
                                 IFsrmCommittableCollection* templates);
}

///Used to access the results when the source template calls the CommitAndUpdateDerived method.
@GUID("39322A2D-38EE-4D0D-8095-421A80849A82")
interface IFsrmDerivedObjectsResult : IDispatch
{
    ///Retrieves the collection of derived objects that were updated. This property is read-only.
    HRESULT get_DerivedObjects(IFsrmCollection* derivedObjects);
    ///Retrieves the <b>HRESULT</b> values that indicate the success or failure of the update for each derived object.
    ///This property is read-only.
    HRESULT get_Results(IFsrmCollection* results);
}

///<p class="CCE_Message">[This interface is supported for compatibility but it's recommended to use the FSRM WMI
///Classes to manage FSRM. Please see the MSFT_FSRMAdr and MSFT_FSRMADRSettings classes.] Used to show the Access Denied
///Remediation (ADR) client user interface. This interface was introduced for applications that are already using the
///FSRM interfaces. Where possible it is recommended to use the MSFT_FSRMAdr and MSFT_FSRMADRSettings WMI classes
///instead.
@GUID("40002314-590B-45A5-8E1B-8C05DA527E52")
interface IFsrmAccessDeniedRemediationClient : IDispatch
{
    ///<p class="CCE_Message">[This method is supported for compatibility but it's recommended to use the FSRM WMI
    ///Classes to manage FSRM. Please see the MSFT_FSRMAdr and MSFT_FSRMADRSettings classes.] Displays the Access Denied
    ///Remediation (ADR) client dialog. This method was introduced for applications that are already using the FSRM
    ///interfaces. Where possible it is recommended to use the MSFT_FSRMAdr and MSFT_FSRMADRSettings WMI classes
    ///instead.
    ///Params:
    ///    parentWnd = Handle to the window that will be the parent of the dialog that will be displayed.
    ///    accessPath = Path of the file being accessed.
    ///    errorType = The client error type as enumerated by the AdrClientErrorType enumeration.
    ///    flags = Reserved. Set to 0.
    ///    windowTitle = Optional text to display as the title of the dialog window that is opened.
    ///    windowMessage = Optional text to display above the instructions in the dialog window that is opened.
    ///    result = Address of a value that will receive a <b>HRESULT</b> containing the result of the operation.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT Show(size_t parentWnd, BSTR accessPath, AdrClientErrorType errorType, int flags, BSTR windowTitle, 
                 BSTR windowMessage, int* result);
}

///<p class="CCE_Message">[This interface is supported for compatibility but it's recommended to use the FSRM WMI
///Classes to manage FSRM. Please see the MSFT_FSRMQuota class.] Base interface for all quota interfaces.
@GUID("1568A795-3924-4118-B74B-68D8F0FA5DAF")
interface IFsrmQuotaBase : IFsrmObject
{
    ///<p class="CCE_Message">[This property is supported for compatibility but it's recommended to use the FSRM WMI
    ///Classes to manage FSRM. Please see the MSFT_FSRMQuota class.] Retrieves or sets the quota limit for the object.
    ///This property is read/write.
    HRESULT get_QuotaLimit(VARIANT* quotaLimit);
    ///<p class="CCE_Message">[This property is supported for compatibility but it's recommended to use the FSRM WMI
    ///Classes to manage FSRM. Please see the MSFT_FSRMQuota class.] Retrieves or sets the quota limit for the object.
    ///This property is read/write.
    HRESULT put_QuotaLimit(VARIANT quotaLimit);
    ///<p class="CCE_Message">[This property is supported for compatibility but it's recommended to use the FSRM WMI
    ///Classes to manage FSRM. Please see the MSFT_FSRMQuota class.] Retrieves or sets the quota flags for the object.
    ///This property is read/write.
    HRESULT get_QuotaFlags(int* quotaFlags);
    ///<p class="CCE_Message">[This property is supported for compatibility but it's recommended to use the FSRM WMI
    ///Classes to manage FSRM. Please see the MSFT_FSRMQuota class.] Retrieves or sets the quota flags for the object.
    ///This property is read/write.
    HRESULT put_QuotaFlags(int quotaFlags);
    ///<p class="CCE_Message">[This property is supported for compatibility but it's recommended to use the FSRM WMI
    ///Classes to manage FSRM. Please see the MSFT_FSRMQuota class.] Retrieves the thresholds for the quota object. This
    ///property is read-only.
    HRESULT get_Thresholds(SAFEARRAY** thresholds);
    ///<p class="CCE_Message">[This method is supported for compatibility but it's recommended to use the FSRM WMI
    ///Classes to manage FSRM. Please see the MSFT_FSRMQuota class.] Adds a threshold to the quota object.
    ///Params:
    ///    threshold = The threshold to add to the quota object. The threshold is expressed as a percentage of the quota limit. The
    ///                value must be from 1 through 250, inclusively.
    ///Returns:
    ///    The method returns the following return values.
    ///    
    HRESULT AddThreshold(int threshold);
    ///<p class="CCE_Message">[This method is supported for compatibility but it's recommended to use the FSRM WMI
    ///Classes to manage FSRM. Please see the MSFT_FSRMQuota class.] Deletes a threshold from the quota object.
    ///Params:
    ///    threshold = The threshold to delete.
    ///Returns:
    ///    The method returns the following return values.
    ///    
    HRESULT DeleteThreshold(int threshold);
    ///<p class="CCE_Message">[This method is supported for compatibility but it's recommended to use the FSRM WMI
    ///Classes to manage FSRM. Please see the MSFT_FSRMQuota class.] Changes the threshold value.
    ///Params:
    ///    threshold = The previous threshold value.
    ///    newThreshold = The new threshold value. The value must be from 1 through 250, inclusively.
    ///Returns:
    ///    The method returns the following return values.
    ///    
    HRESULT ModifyThreshold(int threshold, int newThreshold);
    ///<p class="CCE_Message">[This method is supported for compatibility but it's recommended to use the FSRM WMI
    ///Classes to manage FSRM. Please see the MSFT_FSRMQuota class.] Creates an action and associates it with the
    ///specified threshold.
    ///Params:
    ///    threshold = The threshold with which to associate the action. Specify the same value that you specified when calling the
    ///                IFsrmQuotaBase::AddThreshold method.
    ///    actionType = The action to perform when the threshold is reached or exceeded. For possible values, see the FsrmActionType
    ///                 enumeration.
    ///    action = An IFsrmAction interface of the newly created action. Query the interface for the action interface that you
    ///             specified in the <i>actionType</i> parameter. For example, if the action type is
    ///             <b>FsrmActionType_Command</b>, query the interface for the IFsrmActionCommand interface.
    ///Returns:
    ///    The method returns the following return values.
    ///    
    HRESULT CreateThresholdAction(int threshold, FsrmActionType actionType, IFsrmAction* action);
    ///<p class="CCE_Message">[This method is supported for compatibility but it's recommended to use the FSRM WMI
    ///Classes to manage FSRM. Please see the MSFT_FSRMQuota class.] Enumerates all the actions for the specified
    ///threshold.
    ///Params:
    ///    threshold = The threshold that contains the actions that you want to enumerate.
    ///    actions = An IFsrmCollection interface that contains a collection of actions. The variant type of each item in the
    ///              collection is <b>VT_DISPATCH</b>. Query the <b>pdispVal</b> member of the variant to get an IFsrmAction
    ///              interface. You can use the IFsrmAction::ActionType property to determine the actual action interface to
    ///              query.
    ///Returns:
    ///    The method returns the following return values.
    ///    
    HRESULT EnumThresholdActions(int threshold, IFsrmCollection* actions);
}

///<p class="CCE_Message">[This interface is supported for compatibility but it's recommended to use the FSRM WMI
///Classes to manage FSRM. Please see the MSFT_FSRMQuota class.] Base class for the quota and automatic quota
///interfaces.
@GUID("42DC3511-61D5-48AE-B6DC-59FC00C0A8D6")
interface IFsrmQuotaObject : IFsrmQuotaBase
{
    ///<p class="CCE_Message">[This property is supported for compatibility but it's recommended to use the FSRM WMI
    ///Classes to manage FSRM. Please see the MSFT_FSRMQuota class.] Retrieves the path to which the quota applies. This
    ///property is read-only.
    HRESULT get_Path(BSTR* path);
    ///<p class="CCE_Message">[This property is supported for compatibility but it's recommended to use the FSRM WMI
    ///Classes to manage FSRM. Please see the MSFT_FSRMQuota class.] Retrieves the string form of the user's security
    ///identifier (SID) that is associated with the object. This property is read-only.
    HRESULT get_UserSid(BSTR* userSid);
    ///<p class="CCE_Message">[This property is supported for compatibility but it's recommended to use the FSRM WMI
    ///Classes to manage FSRM. Please see the MSFT_FSRMQuota class.] Retrieves the string form of the user account that
    ///is associated with the object. This property is read-only.
    HRESULT get_UserAccount(BSTR* userAccount);
    ///<p class="CCE_Message">[This property is supported for compatibility but it's recommended to use the FSRM WMI
    ///Classes to manage FSRM. Please see the MSFT_FSRMQuota class.] Retrieves the name of the template from which this
    ///quota was derived. This property is read-only.
    HRESULT get_SourceTemplateName(BSTR* quotaTemplateName);
    ///<p class="CCE_Message">[This property is supported for compatibility but it's recommended to use the FSRM WMI
    ///Classes to manage FSRM. Please see the MSFT_FSRMQuota class.] Retrieves a value that determines whether the
    ///property values of this quota object match those of the template from which it was derived. This property is
    ///read-only.
    HRESULT get_MatchesSourceTemplate(short* matches);
    ///<p class="CCE_Message">[This method is supported for compatibility but it's recommended to use the FSRM WMI
    ///Classes to manage FSRM. Please see the MSFT_FSRMQuota class.] Applies the property values of the specified quota
    ///template to this quota object.
    ///Params:
    ///    quotaTemplateName = The name of the quota template. The string is limited to 4,000 characters.
    ///Returns:
    ///    The method returns the following return values.
    ///    
    HRESULT ApplyTemplate(BSTR quotaTemplateName);
}

///<p class="CCE_Message">[This interface is supported for compatibility but it's recommended to use the FSRM WMI
///Classes to manage FSRM. Please see the MSFT_FSRMQuota class.] Used to define a quota for a specified directory and to
///retrieve use statistics. To create this interface, call the IFsrmQuotaManager::CreateQuota method. The following
///methods return this interface: <ul> <li> IFsrmQuotaManager::EnumEffectiveQuotas </li> <li>
///IFsrmQuotaManager::EnumQuotas </li> <li> IFsrmQuotaManager::GetQuota </li> <li>
///IFsrmQuotaManager::GetRestrictiveQuota </li> </ul>
@GUID("377F739D-9647-4B8E-97D2-5FFCE6D759CD")
interface IFsrmQuota : IFsrmQuotaObject
{
    ///<p class="CCE_Message">[This property is supported for compatibility but it's recommended to use the FSRM WMI
    ///Classes to manage FSRM. Please see the MSFT_FSRMQuota class.] Retrieves the current amount of disk space usage
    ///charged to this quota. This property is read-only.
    HRESULT get_QuotaUsed(VARIANT* used);
    ///<p class="CCE_Message">[This property is supported for compatibility but it's recommended to use the FSRM WMI
    ///Classes to manage FSRM. Please see the MSFT_FSRMQuota class.] Retrieves the highest amount of disk space usage
    ///charged to this quota. This property is read-only.
    HRESULT get_QuotaPeakUsage(VARIANT* peakUsage);
    ///<p class="CCE_Message">[This property is supported for compatibility but it's recommended to use the FSRM WMI
    ///Classes to manage FSRM. Please see the MSFT_FSRMQuota class.] Retrieves the date and time that the
    ///IFsrmQuota::QuotaPeakUsage property was set. This property is read-only.
    HRESULT get_QuotaPeakUsageTime(double* peakUsageDateTime);
    ///<p class="CCE_Message">[This method is supported for compatibility but it's recommended to use the FSRM WMI
    ///Classes to manage FSRM. Please see the MSFT_FSRMQuota class.] Resets the peak usage of this quota to the current
    ///usage.
    ///Returns:
    ///    The method returns the following return values.
    ///    
    HRESULT ResetPeakUsage();
    ///<p class="CCE_Message">[This method is supported for compatibility but it's recommended to use the FSRM WMI
    ///Classes to manage FSRM. Please see the MSFT_FSRMQuota class.] Refreshes this object's quota usage information
    ///from the current information in FSRM.
    ///Returns:
    ///    The method returns the following return values.
    ///    
    HRESULT RefreshUsageProperties();
}

///<p class="CCE_Message">[This interface is supported for compatibility but it's recommended to use the FSRM WMI
///Classes to manage FSRM. Please see the MSFT_FSRMAutoQuota class.] Used to automatically add the quota to new and
///existing subdirectories of the directory on which the automatic quota is applied. To create an automatic quota, call
///the IFsrmQuotaManager::CreateAutoApplyQuota method. To retrieve this interface to an existing automatic quota, call
///one of the following methods: <ul> <li> IFsrmQuotaManager::EnumAutoApplyQuotas </li> <li>
///IFsrmQuotaManager::GetAutoApplyQuota </li> </ul>
@GUID("F82E5729-6ABA-4740-BFC7-C7F58F75FB7B")
interface IFsrmAutoApplyQuota : IFsrmQuotaObject
{
    ///<p class="CCE_Message">[This property is supported for compatibility but it's recommended to use the FSRM WMI
    ///Classes to manage FSRM. Please see the MSFT_FSRMAutoQuota class.] Retrieves or sets an array of immediate
    ///subdirectories to exclude from the automatic quota. This property is read/write.
    HRESULT get_ExcludeFolders(SAFEARRAY** folders);
    ///<p class="CCE_Message">[This property is supported for compatibility but it's recommended to use the FSRM WMI
    ///Classes to manage FSRM. Please see the MSFT_FSRMAutoQuota class.] Retrieves or sets an array of immediate
    ///subdirectories to exclude from the automatic quota. This property is read/write.
    HRESULT put_ExcludeFolders(SAFEARRAY* folders);
    ///<p class="CCE_Message">[This method is supported for compatibility but it's recommended to use the FSRM WMI
    ///Classes to manage FSRM. Please see the MSFT_FSRMAutoQuota class.] Saves the quota and then applies any changes to
    ///the derived quotas.
    ///Params:
    ///    commitOptions = The options for saving the quota. For possible values, see the FsrmCommitOptions enumeration.
    ///    applyOptions = The options used to choose the derived quotas to which the changes are applied. For possible values, see the
    ///                   FsrmTemplateApplyOptions enumeration.
    ///    derivedObjectsResult = An IFsrmDerivedObjectsResult interface that you use to determine the list of derived objects that were
    ///                           updated and whether the update was successful.
    ///Returns:
    ///    The method returns the following return values.
    ///    
    HRESULT CommitAndUpdateDerived(FsrmCommitOptions commitOptions, FsrmTemplateApplyOptions applyOptions, 
                                   IFsrmDerivedObjectsResult* derivedObjectsResult);
}

///<p class="CCE_Message">[This interface is supported for compatibility but it's recommended to use the FSRM WMI
///Classes to manage FSRM. Please see the MSFT_FSRMQuota class.] Used to manage quotas. To get this interface, call the
///CoCreateInstanceEx function. Use <b>CLSID_FsrmQuotaManager</b> as the class identifier and
///<code>__uuidof(IFsrmQuotaManager)</code> as the interface identifier. For an example, see Defining a Quota.
@GUID("8BB68C7D-19D8-4FFB-809E-BE4FC1734014")
interface IFsrmQuotaManager : IDispatch
{
    ///<p class="CCE_Message">[This property is supported for compatibility but it's recommended to use the FSRM WMI
    ///Classes to manage FSRM. Please see the MSFT_FSRMQuota class.] Retrieves a list of macros that you can specify in
    ///action property values. This property is read-only.
    HRESULT get_ActionVariables(SAFEARRAY** variables);
    ///<p class="CCE_Message">[This property is supported for compatibility but it's recommended to use the FSRM WMI
    ///Classes to manage FSRM. Please see the MSFT_FSRMQuota class.] Retrieves the descriptions for the macros contained
    ///in the IFsrmQuotaManager::ActionVariables property. This property is read-only.
    HRESULT get_ActionVariableDescriptions(SAFEARRAY** descriptions);
    ///<p class="CCE_Message">[This method is supported for compatibility but it's recommended to use the FSRM WMI
    ///Classes to manage FSRM. Please see the MSFT_FSRMQuota class.] Creates a quota for the specified directory.
    ///Params:
    ///    path = The local directory path to which the quota applies. The string is limited to 260 characters.
    ///    quota = An IFsrmQuota interface to the newly created quota object. Use this interface to define the quota. To add the
    ///            quota to FSRM, call IFsrmQuota::Commit method.
    ///Returns:
    ///    The method returns the following return values.
    ///    
    HRESULT CreateQuota(BSTR path, IFsrmQuota* quota);
    ///<p class="CCE_Message">[This method is supported for compatibility but it's recommended to use the FSRM WMI
    ///Classes to manage FSRM. Please see the MSFT_FSRMQuota class.] Creates an automatic quota for the specified
    ///directory.
    ///Params:
    ///    quotaTemplateName = The name of a template from which to derive the quota; automatic quotas must derive from a template. The
    ///                        string is limited to 4,000 characters.
    ///    path = The local directory path to which the quota applies. The string is limited to 260 characters.
    ///    quota = An IFsrmAutoApplyQuota interface to the newly created quota object. The specified template is used to
    ///            initialize the quota. Use this interface to change the quota and to exclude specific subdirectories from the
    ///            quota. To add the quota to FSRM, call IFsrmAutoApplyQuota::Commit method.
    ///Returns:
    ///    The method returns the following return values.
    ///    
    HRESULT CreateAutoApplyQuota(BSTR quotaTemplateName, BSTR path, IFsrmAutoApplyQuota* quota);
    ///<p class="CCE_Message">[This method is supported for compatibility but it's recommended to use the FSRM WMI
    ///Classes to manage FSRM. Please see the MSFT_FSRMQuota class.] Retrieves the quota for the specified directory.
    ///Params:
    ///    path = The local directory path that contains the quota that you want to retrieve. The string is limited to 260
    ///           characters.
    ///    quota = An IFsrmQuota interface to the quota object.
    ///Returns:
    ///    The method returns the following return values.
    ///    
    HRESULT GetQuota(BSTR path, IFsrmQuota* quota);
    ///<p class="CCE_Message">[This method is supported for compatibility but it's recommended to use the FSRM WMI
    ///Classes to manage FSRM. Please see the MSFT_FSRMQuota class.] Retrieves the automatic quota for the specified
    ///directory.
    ///Params:
    ///    path = The local directory path that contains the quota that you want to retrieve. The string is limited to 260
    ///           characters.
    ///    quota = An IFsrmAutoApplyQuota interface to the quota object.
    ///Returns:
    ///    The method returns the following return values.
    ///    
    HRESULT GetAutoApplyQuota(BSTR path, IFsrmAutoApplyQuota* quota);
    ///<p class="CCE_Message">[This method is supported for compatibility but it's recommended to use the FSRM WMI
    ///Classes to manage FSRM. Please see the MSFT_FSRMQuota class.] Retrieves the most restrictive quota for the
    ///specified path.
    ///Params:
    ///    path = The local directory path. The string is limited to 260 characters.
    ///    quota = An IFsrmQuota interface to the quota object.
    ///Returns:
    ///    The method returns the following return values.
    ///    
    HRESULT GetRestrictiveQuota(BSTR path, IFsrmQuota* quota);
    ///<p class="CCE_Message">[This method is supported for compatibility but it's recommended to use the FSRM WMI
    ///Classes to manage FSRM. Please see the MSFT_FSRMQuota class.] Enumerates the quotas for the specified directory
    ///and any quotas associated with its subdirectories (recursively).
    ///Params:
    ///    path = The local directory path that is associated with the quota that you want to enumerate. The string is limited
    ///           to 260 characters. If the path ends with "\*", retrieve all quotas associated with the immediate
    ///           subdirectories of the path (does not include the quota associated with the path). If the path ends with
    ///           "\...", retrieve the quota for the path and all quotas associated with the immediate subdirectories of the
    ///           path (recursively). If the path does not end in "\*" or "\...", retrieve the quota for the path only. If path
    ///           is null or empty, the method returns all quotas.
    ///    options = Options to use when enumerating the quotas. For possible values, see the FsrmEnumOptions enumeration.
    ///    quotas = An IFsrmCommittableCollection interface that contains a collection of the quotas. Each item of the collection
    ///             is a <b>VARIANT</b> of type <b>VT_DISPATCH</b>. Query the <b>pdispVal</b> member of the variant for the
    ///             IFsrmQuota interface. The collection is empty if the path does not contain quotas.
    ///Returns:
    ///    The method returns the following return values.
    ///    
    HRESULT EnumQuotas(BSTR path, FsrmEnumOptions options, IFsrmCommittableCollection* quotas);
    ///<p class="CCE_Message">[This method is supported for compatibility but it's recommended to use the FSRM WMI
    ///Classes to manage FSRM. Please see the MSFT_FSRMQuota class.] Enumerates the automatic quotas that are associated
    ///with the specified directory. The enumeration can also include automatic quotas associated with subdirectories
    ///(recursively).
    ///Params:
    ///    path = The local directory path that is associated with the automatic quota that you want to enumerate. The string
    ///           is limited to 260 characters. If the path ends with "\*", retrieve all automatic quotas associated with the
    ///           immediate subdirectories of the path (does not include the quota associated with the path). If the path ends
    ///           with "\...", retrieve the automatic quota for the path and all automatic quotas associated with the immediate
    ///           subdirectories of the path (recursively). If the path does not end in "\*" or "\...", retrieve the automatic
    ///           quota for the path only. If path is null or empty, the method returns all quotas.
    ///    options = Options to use when enumerating the quotas. For possible values, see the FsrmEnumOptions enumeration.
    ///    quotas = An IFsrmCommittableCollection interface that contains a collection of the automatic quotas. Each item of the
    ///             collection is a <b>VARIANT</b> of type <b>VT_DISPATCH</b>. Query the <b>pdispVal</b> member of the variant
    ///             for the IFsrmAutoApplyQuota interface. The collection is empty if the path does not contain quotas.
    ///Returns:
    ///    The method returns the following return values.
    ///    
    HRESULT EnumAutoApplyQuotas(BSTR path, FsrmEnumOptions options, IFsrmCommittableCollection* quotas);
    ///<p class="CCE_Message">[This method is supported for compatibility but it's recommended to use the FSRM WMI
    ///Classes to manage FSRM. Please see the MSFT_FSRMQuota class.] Enumerates all the quotas that affect the specified
    ///path.
    ///Params:
    ///    path = A local directory path. The string is limited to 260 characters.
    ///    options = Options to use when enumerating the quotas. For possible values, see the FsrmEnumOptions enumeration.
    ///    quotas = An IFsrmCommittableCollection interface that contains a collection of the quotas configured at or above the
    ///             specified path. Each item of the collection is a <b>VARIANT</b> of type <b>VT_DISPATCH</b>. Query the
    ///             <b>pdispVal</b> member of the variant for the IFsrmQuota interface. The collection is empty if the path does
    ///             not contain quotas.
    ///Returns:
    ///    The method returns the following return values.
    ///    
    HRESULT EnumEffectiveQuotas(BSTR path, FsrmEnumOptions options, IFsrmCommittableCollection* quotas);
    ///<p class="CCE_Message">[This method is supported for compatibility but it's recommended to use the FSRM WMI
    ///Classes to manage FSRM. Please see the MSFT_FSRMQuota class.] Starts a quota scan on the specified path.
    ///Params:
    ///    strPath = The local directory path to scan.
    ///Returns:
    ///    The method returns the following return values.
    ///    
    HRESULT Scan(BSTR strPath);
    ///<p class="CCE_Message">[This method is supported for compatibility but it's recommended to use the FSRM WMI
    ///Classes to manage FSRM. Please see the MSFT_FSRMQuota class.] Creates an empty collection to which you can add
    ///quotas.
    ///Params:
    ///    collection = An IFsrmCommittableCollection interface to the newly created collection. To add an object to the collection,
    ///                 call the IFsrmMutableCollection::Add method.
    ///Returns:
    ///    The method returns the following return values.
    ///    
    HRESULT CreateQuotaCollection(IFsrmCommittableCollection* collection);
}

///<p class="CCE_Message">[This interface is supported for compatibility but it's recommended to use the FSRM WMI
///Classes to manage FSRM. Please see the MSFT_FSRMQuota class.] Used to manage quotas, extended version.
@GUID("4846CB01-D430-494F-ABB4-B1054999FB09")
interface IFsrmQuotaManagerEx : IFsrmQuotaManager
{
    ///<p class="CCE_Message">[This method is supported for compatibility but it's recommended to use the FSRM WMI
    ///Classes to manage FSRM. Please see the MSFT_FSRMQuota class.] Retrieves a value that determines whether a
    ///specified path is subject to a quota.
    ///Params:
    ///    path = The local directory path to determine whether a quota applies.
    ///    options = The options to use when checking for a quota. For possible values, see the FsrmEnumOptions enumeration.
    ///    affected = Is <b>VARIANT_TRUE</b> if the path referred to by the <i>path</i> parameter is subject to a quota, otherwise
    ///               it is <b>VARIANT_FALSE</b>.
    ///Returns:
    ///    The method returns the following return values.
    ///    
    HRESULT IsAffectedByQuota(BSTR path, FsrmEnumOptions options, short* affected);
}

///<p class="CCE_Message">[This interface is supported for compatibility but it's recommended to use the FSRM WMI
///Classes to manage FSRM. Please see the MSFT_FSRMQuota class.] Used to configure templates from which new quota
///objects can be derived. Templates are identified by a name and are used to simplify the configuration of directory
///quotas. To create this interface, call the IFsrmQuotaTemplateManager::CreateTemplate method. The following methods
///return this interface: <ul> <li> IFsrmQuotaTemplateManager::EnumTemplates </li> <li>
///IFsrmQuotaTemplateManager::GetTemplate </li> <li> IFsrmQuotaTemplateManager::ImportTemplates </li> </ul>
@GUID("A2EFAB31-295E-46BB-B976-E86D58B52E8B")
interface IFsrmQuotaTemplate : IFsrmQuotaBase
{
    ///<p class="CCE_Message">[This property is supported for compatibility but it's recommended to use the FSRM WMI
    ///Classes to manage FSRM. Please see the MSFT_FSRMQuota class.] Retrieves and sets the name of the quota template.
    ///This property is read/write.
    HRESULT get_Name(BSTR* name);
    ///<p class="CCE_Message">[This property is supported for compatibility but it's recommended to use the FSRM WMI
    ///Classes to manage FSRM. Please see the MSFT_FSRMQuota class.] Retrieves and sets the name of the quota template.
    ///This property is read/write.
    HRESULT put_Name(BSTR name);
    ///<p class="CCE_Message">[This method is supported for compatibility but it's recommended to use the FSRM WMI
    ///Classes to manage FSRM. Please see the MSFT_FSRMQuota class.] Copies the property values of the specified
    ///template to this template.
    ///Params:
    ///    quotaTemplateName = The name of the template from which to copy the property values. The string is limited to 4,000 characters.
    ///Returns:
    ///    The method returns the following return values.
    ///    
    HRESULT CopyTemplate(BSTR quotaTemplateName);
    ///<p class="CCE_Message">[This method is supported for compatibility but it's recommended to use the FSRM WMI
    ///Classes to manage FSRM. Please see the MSFT_FSRMQuota class.] Saves the quota template and then applies any
    ///changes to the derived quota objects.
    ///Params:
    ///    commitOptions = The options for saving the template. For possible values, see the FsrmCommitOptions enumeration.
    ///    applyOptions = The options used to choose the derived objects to which the changes are applied. For possible values, see the
    ///                   FsrmTemplateApplyOptions enumeration.
    ///    derivedObjectsResult = An IFsrmDerivedObjectsResult interface that you use to determine the list of derived objects that were
    ///                           updated and whether the update was successful.
    ///Returns:
    ///    The method returns the following return values.
    ///    
    HRESULT CommitAndUpdateDerived(FsrmCommitOptions commitOptions, FsrmTemplateApplyOptions applyOptions, 
                                   IFsrmDerivedObjectsResult* derivedObjectsResult);
}

///<p class="CCE_Message">[This interface is supported for compatibility but it's recommended to use the FSRM WMI
///Classes to manage FSRM. Please see the MSFT_FSRMQuota class.] Used to modify and save imported quota templates. The
///IFsrmExportImport::ImportQuotaTemplates method returns this interface.
@GUID("9A2BF113-A329-44CC-809A-5C00FCE8DA40")
interface IFsrmQuotaTemplateImported : IFsrmQuotaTemplate
{
    ///<p class="CCE_Message">[This property is supported for compatibility but it's recommended to use the FSRM WMI
    ///Classes to manage FSRM. Please see the MSFT_FSRMQuota class.] Retrieves or sets a value that determines whether a
    ///quota template is overwritten if it exists when the template is imported. This property is read/write.
    HRESULT get_OverwriteOnCommit(short* overwrite);
    ///<p class="CCE_Message">[This property is supported for compatibility but it's recommended to use the FSRM WMI
    ///Classes to manage FSRM. Please see the MSFT_FSRMQuota class.] Retrieves or sets a value that determines whether a
    ///quota template is overwritten if it exists when the template is imported. This property is read/write.
    HRESULT put_OverwriteOnCommit(short overwrite);
}

///<p class="CCE_Message">[This interface is supported for compatibility but it's recommended to use the FSRM WMI
///Classes to manage FSRM. Please see the MSFT_FSRMQuota class.] Used to manage quota templates. To get this interface,
///call the CoCreateInstanceEx function. Use <b>CLSID_FsrmQuotaTemplateManager</b> as the class identifier and
///<code>__uuidof(IFsrmQuotaTemplateManager)</code> as the interface identifier. For an example, see Using Templates to
///Define Quotas.
@GUID("4173AC41-172D-4D52-963C-FDC7E415F717")
interface IFsrmQuotaTemplateManager : IDispatch
{
    ///<p class="CCE_Message">[This method is supported for compatibility but it's recommended to use the FSRM WMI
    ///Classes to manage FSRM. Please see the MSFT_FSRMQuota class.] Creates a quota template object.
    ///Params:
    ///    quotaTemplate = An IFsrmQuotaTemplate interface to the newly create template. To add the template to FSRM, call
    ///                    IFsrmQuotaTemplate::Commit method.
    ///Returns:
    ///    The method returns the following return values.
    ///    
    HRESULT CreateTemplate(IFsrmQuotaTemplate* quotaTemplate);
    ///<p class="CCE_Message">[This method is supported for compatibility but it's recommended to use the FSRM WMI
    ///Classes to manage FSRM. Please see the MSFT_FSRMQuota class.] Retrieves the specified quota template.
    ///Params:
    ///    name = The name of the quota template to retrieve. The string is limited to 4,000 characters.
    ///    quotaTemplate = An IFsrmQuotaTemplate interface to the retrieved template object.
    ///Returns:
    ///    The method returns the following return values.
    ///    
    HRESULT GetTemplate(BSTR name, IFsrmQuotaTemplate* quotaTemplate);
    ///<p class="CCE_Message">[This method is supported for compatibility but it's recommended to use the FSRM WMI
    ///Classes to manage FSRM. Please see the MSFT_FSRMQuota class.] Enumerates the quota templates on the server.
    ///Params:
    ///    options = Options to use when enumerating the quota templates. For possible values, see the FsrmEnumOptions
    ///              enumeration.
    ///    quotaTemplates = An IFsrmCommittableCollection interface that contains a collection of quota templates. Each item of the
    ///                     collection is a <b>VARIANT</b> of type <b>VT_DISPATCH</b>. Query the <b>pdispVal</b> member of the variant
    ///                     for the IFsrmQuotaTemplate interface.
    ///Returns:
    ///    The method returns the following return values.
    ///    
    HRESULT EnumTemplates(FsrmEnumOptions options, IFsrmCommittableCollection* quotaTemplates);
    ///<p class="CCE_Message">[This method is supported for compatibility but it's recommended to use the FSRM WMI
    ///Classes to manage FSRM. Please see the MSFT_FSRMQuota class.] Exports the quota templates as an XML string.
    ///Params:
    ///    quotaTemplateNamesArray = A variant that contains the names of the quota templates to export. If <b>NULL</b>, the method exports all
    ///                              quotas.
    ///    serializedQuotaTemplates = The specified templates in XML format.
    ///Returns:
    ///    The method returns the following return values.
    ///    
    HRESULT ExportTemplates(VARIANT* quotaTemplateNamesArray, BSTR* serializedQuotaTemplates);
    ///<p class="CCE_Message">[This method is supported for compatibility but it's recommended to use the FSRM WMI
    ///Classes to manage FSRM. Please see the MSFT_FSRMQuota class.] Imports the specified quota templates from an XML
    ///string.
    ///Params:
    ///    serializedQuotaTemplates = An XML string that represents one or more quota templates.
    ///    quotaTemplateNamesArray = A variant that contains the names of the templates to import. If <b>NULL</b>, the method imports all
    ///                              templates.
    ///    quotaTemplates = An IFsrmCommittableCollection interface that contains a collection of quota templates. Each item of the
    ///                     collection is a <b>VARIANT</b> of type <b>VT_DISPATCH</b>. Query the <b>pdispVal</b> member of the variant
    ///                     for the IFsrmQuotaTemplateImported interface. To add the templates to FSRM, call the
    ///                     IFsrmCommittableCollection::Commit method. To add the templates to FSRM and propagate the changes to objects
    ///                     that were derived from the template, call the IFsrmFileScreenTemplateImported::CommitAndUpdateDerived method
    ///                     on each item in the collection.
    ///Returns:
    ///    The method returns the following return values.
    ///    
    HRESULT ImportTemplates(BSTR serializedQuotaTemplates, VARIANT* quotaTemplateNamesArray, 
                            IFsrmCommittableCollection* quotaTemplates);
}

///<p class="CCE_Message">[This interface is supported for compatibility but it's recommended to use the FSRM WMI
///Classes to manage FSRM. Please see the MSFT_FSRMFileGroup class.] Used to define a group of files based on one or
///more file name patterns. A file group is a logical collection of file name patterns identified by name that is used
///to define file screens and file screen exceptions. File group definitions may also be used for generating storage
///report jobs based on file type. To create a file group, call the IFsrmFileGroupManager::CreateFileGroup method. The
///following methods return this interface: <ul> <li> IFsrmFileGroupManager::EnumFileGroups </li> <li>
///IFsrmFileGroupManager::GetFileGroup </li> <li> IFsrmFileGroupManager::ImportFileGroups </li> </ul>
@GUID("8DD04909-0E34-4D55-AFAA-89E1F1A1BBB9")
interface IFsrmFileGroup : IFsrmObject
{
    ///<p class="CCE_Message">[This property is supported for compatibility but it's recommended to use the FSRM WMI
    ///Classes to manage FSRM. Please see the MSFT_FSRMFileGroup class.] Retrieves or sets the name of the file group.
    ///This property is read/write.
    HRESULT get_Name(BSTR* name);
    ///<p class="CCE_Message">[This property is supported for compatibility but it's recommended to use the FSRM WMI
    ///Classes to manage FSRM. Please see the MSFT_FSRMFileGroup class.] Retrieves or sets the name of the file group.
    ///This property is read/write.
    HRESULT put_Name(BSTR name);
    ///<p class="CCE_Message">[This method is supported for compatibility but it's recommended to use the FSRM WMI
    ///Classes to manage FSRM. Please see the MSFT_FSRMFileGroup class.] Retrieves or sets the filename patterns that
    ///determine the files that are included in the file group. This property is read/write.
    HRESULT get_Members(IFsrmMutableCollection* members);
    ///<p class="CCE_Message">[This method is supported for compatibility but it's recommended to use the FSRM WMI
    ///Classes to manage FSRM. Please see the MSFT_FSRMFileGroup class.] Retrieves or sets the filename patterns that
    ///determine the files that are included in the file group. This property is read/write.
    HRESULT put_Members(IFsrmMutableCollection members);
    ///<p class="CCE_Message">[This method is supported for compatibility but it's recommended to use the FSRM WMI
    ///Classes to manage FSRM. Please see the MSFT_FSRMFileGroup class.] Retrieves or sets the filename patterns that
    ///determine the files that are excluded from the file group. This property is read/write.
    HRESULT get_NonMembers(IFsrmMutableCollection* nonMembers);
    ///<p class="CCE_Message">[This method is supported for compatibility but it's recommended to use the FSRM WMI
    ///Classes to manage FSRM. Please see the MSFT_FSRMFileGroup class.] Retrieves or sets the filename patterns that
    ///determine the files that are excluded from the file group. This property is read/write.
    HRESULT put_NonMembers(IFsrmMutableCollection nonMembers);
}

///<p class="CCE_Message">[This interface is supported for compatibility but it's recommended to use the FSRM WMI
///Classes to manage FSRM. Please see the MSFT_FSRMFileGroup class.] Used to configure imported file group objects. The
///IFsrmExportImport::ImportFileGroups method returns this interface.
@GUID("AD55F10B-5F11-4BE7-94EF-D9EE2E470DED")
interface IFsrmFileGroupImported : IFsrmFileGroup
{
    ///<p class="CCE_Message">[This property is supported for compatibility but it's recommended to use the FSRM WMI
    ///Classes to manage FSRM. Please see the MSFT_FSRMFileGroup class.] Retrieves or sets a value that determines
    ///whether a file group is overwritten if it exists. This property is read/write.
    HRESULT get_OverwriteOnCommit(short* overwrite);
    ///<p class="CCE_Message">[This property is supported for compatibility but it's recommended to use the FSRM WMI
    ///Classes to manage FSRM. Please see the MSFT_FSRMFileGroup class.] Retrieves or sets a value that determines
    ///whether a file group is overwritten if it exists. This property is read/write.
    HRESULT put_OverwriteOnCommit(short overwrite);
}

///<p class="CCE_Message">[This interface is supported for compatibility but it's recommended to use the FSRM WMI
///Classes to manage FSRM. Please see the MSFT_FSRMFileGroup class.] Used to manage file group objects. To get this
///interface, call the CoCreateInstanceEx function. Use <b>CLSID_FsrmFileGroupManager</b> as the class identifier and
///<code>__uuidof(IFsrmFileGroupManager)</code> as the interface identifier. For an example, see Creating File Groups to
///Specify the Files to Restrict.
@GUID("426677D5-018C-485C-8A51-20B86D00BDC4")
interface IFsrmFileGroupManager : IDispatch
{
    ///<p class="CCE_Message">[This method is supported for compatibility but it's recommended to use the FSRM WMI
    ///Classes to manage FSRM. Please see the MSFT_FSRMFileGroup class.] Creates a file group object.
    ///Params:
    ///    fileGroup = An IFsrmFileGroup interface to the new file group. To add the file group to FSRM, call IFsrmFileGroup::Commit
    ///                method.
    ///Returns:
    ///    The method returns the following return values.
    ///    
    HRESULT CreateFileGroup(IFsrmFileGroup* fileGroup);
    ///<p class="CCE_Message">[This method is supported for compatibility but it's recommended to use the FSRM WMI
    ///Classes to manage FSRM. Please see the MSFT_FSRMFileGroup class.] Retrieves the specified file group from FSRM.
    ///Params:
    ///    name = The name of the file group to retrieve. The string is limited to 4,000 characters.
    ///    fileGroup = An IFsrmFileGroup interface to the retrieved file group.
    ///Returns:
    ///    The method returns the following return values.
    ///    
    HRESULT GetFileGroup(BSTR name, IFsrmFileGroup* fileGroup);
    ///<p class="CCE_Message">[This method is supported for compatibility but it's recommended to use the FSRM WMI
    ///Classes to manage FSRM. Please see the MSFT_FSRMFileGroup class.] Enumerates the file groups in FSRM.
    ///Params:
    ///    options = One or more options for enumerating the file groups. For possible values, see the FsrmEnumOptions
    ///              enumeration.
    ///    fileGroups = An IFsrmCommittableCollection interface that contains a collection of file groups. Each item of the
    ///                 collection is a <b>VARIANT</b> of type <b>VT_DISPATCH</b>. Query the <b>pdispVal</b> member of the variant
    ///                 for the IFsrmFileGroup interface. The collection contains only committed file groups; the collection will not
    ///                 contain newly created file groups that have not been committed.
    ///Returns:
    ///    The method returns the following return values.
    ///    
    HRESULT EnumFileGroups(FsrmEnumOptions options, IFsrmCommittableCollection* fileGroups);
    ///<p class="CCE_Message">[This method is supported for compatibility but it's recommended to use the FSRM WMI
    ///Classes to manage FSRM. Please see the MSFT_FSRMFileGroup class.] Exports the specified file groups as an XML
    ///string.
    ///Params:
    ///    fileGroupNamesArray = A <b>VARIANT</b> that contains a <b>SAFEARRAY</b> of the names of the file groups to export. If <b>NULL</b>,
    ///                          the method exports all file groups.
    ///    serializedFileGroups = The specified file groups in XML format.
    ///Returns:
    ///    The method returns the following return values.
    ///    
    HRESULT ExportFileGroups(VARIANT* fileGroupNamesArray, BSTR* serializedFileGroups);
    ///<p class="CCE_Message">[This method is supported for compatibility but it's recommended to use the FSRM WMI
    ///Classes to manage FSRM. Please see the MSFT_FSRMFileGroup class.] Imports the specified file groups from an XML
    ///string.
    ///Params:
    ///    serializedFileGroups = An XML string that represents one or more file groups.
    ///    fileGroupNamesArray = A <b>VARIANT</b> that contains a <b>SAFEARRAY</b> of the names of the file groups to import. If <b>NULL</b>,
    ///                          the method imports all file groups.
    ///    fileGroups = An IFsrmCommittableCollection interface that contains a collection of file groups. Each item of the
    ///                 collection is a <b>VARIANT</b> of type <b>VT_DISPATCH</b>. Query the <b>pdispVal</b> member of the variant
    ///                 for the IFsrmFileGroupImported interface. To add the file groups to FSRM, call the
    ///                 IFsrmCommittableCollection::Commit method.
    ///Returns:
    ///    The method returns the following return values.
    ///    
    HRESULT ImportFileGroups(BSTR serializedFileGroups, VARIANT* fileGroupNamesArray, 
                             IFsrmCommittableCollection* fileGroups);
}

///Base class for all file screen interfaces.
@GUID("F3637E80-5B22-4A2B-A637-BBB642B41CFC")
interface IFsrmFileScreenBase : IFsrmObject
{
    ///Retrieves or sets the names of the file groups that contain the file name patterns used to specify the files that
    ///are blocked by this screen. This property is read/write.
    HRESULT get_BlockedFileGroups(IFsrmMutableCollection* blockList);
    ///Retrieves or sets the names of the file groups that contain the file name patterns used to specify the files that
    ///are blocked by this screen. This property is read/write.
    HRESULT put_BlockedFileGroups(IFsrmMutableCollection blockList);
    ///Retrieves or sets the file screen flags. The flags determine if FSRM fails any IO operations that violate the
    ///file screen. This property is read/write.
    HRESULT get_FileScreenFlags(int* fileScreenFlags);
    ///Retrieves or sets the file screen flags. The flags determine if FSRM fails any IO operations that violate the
    ///file screen. This property is read/write.
    HRESULT put_FileScreenFlags(int fileScreenFlags);
    ///Creates an action for this file screen object. The action is triggered when a file violates the file screen.
    ///Params:
    ///    actionType = The type of action to create. For possible values, see the FsrmActionType enumeration.
    ///    action = An IFsrmAction interface to the newly created action. Query the interface for the specific action specified.
    ///             For example, if <i>actionType</i> is <b>FsrmActionType_Command</b>, query <i>action</i> for the
    ///             IFsrmActionCommand interface.
    ///Returns:
    ///    The method returns the following return values.
    ///    
    HRESULT CreateAction(FsrmActionType actionType, IFsrmAction* action);
    ///Enumerates all the actions for the file screen object.
    ///Params:
    ///    actions = An IFsrmCollection interface that contains a collection of actions that are defined for the object. Each item
    ///              of the collection is a <b>VARIANT</b> of type <b>VT_DISPATCH</b>. Query the <b>pdispVal</b> member for the
    ///              IFsrmAction interface. You can then use the IFsrmAction::ActionType property to determine the type of action.
    ///Returns:
    ///    The method returns the following return values.
    ///    
    HRESULT EnumActions(IFsrmCollection* actions);
}

///<p class="CCE_Message">[This interface is supported for compatibility but it's recommended to use the FSRM WMI
///Classes to manage FSRM. Please see the MSFT_FSRMFileScreen class.] Used to configure a file screen that blocks groups
///of files from being saved to the specified directory. To create this interface, call the
///IFsrmFileScreenManager::CreateFileScreen method. The following methods return this interface: <ul> <li>
///IFsrmFileScreenManager::EnumFileScreens </li> <li> IFsrmFileScreenManager::GetFileScreen </li> </ul>
@GUID("5F6325D3-CE88-4733-84C1-2D6AEFC5EA07")
interface IFsrmFileScreen : IFsrmFileScreenBase
{
    ///<p class="CCE_Message">[This property is supported for compatibility but it's recommended to use the FSRM WMI
    ///Classes to manage FSRM. Please see the MSFT_FSRMFileScreen class.] Retrieves the directory path associated with
    ///the file screen object. This property is read-only.
    HRESULT get_Path(BSTR* path);
    ///<p class="CCE_Message">[This property is supported for compatibility but it's recommended to use the FSRM WMI
    ///Classes to manage FSRM. Please see the MSFT_FSRMFileScreen class.] Retrieves the name of the template from which
    ///this file screen object was derived. This property is read-only.
    HRESULT get_SourceTemplateName(BSTR* fileScreenTemplateName);
    ///<p class="CCE_Message">[This property is supported for compatibility but it's recommended to use the FSRM WMI
    ///Classes to manage FSRM. Please see the MSFT_FSRMFileScreen class.] Retrieves a value that determines whether the
    ///property values of this file screen object match those values of the template from which the object was derived.
    ///This property is read-only.
    HRESULT get_MatchesSourceTemplate(short* matches);
    ///<p class="CCE_Message">[This property is supported for compatibility but it's recommended to use the FSRM WMI
    ///Classes to manage FSRM. Please see the MSFT_FSRMFileScreen class.] The SID of the user whose files will be
    ///screened. This property is read-only.
    HRESULT get_UserSid(BSTR* userSid);
    ///<p class="CCE_Message">[This property is supported for compatibility but it's recommended to use the FSRM WMI
    ///Classes to manage FSRM. Please see the MSFT_FSRMFileScreen class.] The account name of the user whose files will
    ///be screened. This property is read-only.
    HRESULT get_UserAccount(BSTR* userAccount);
    ///<p class="CCE_Message">[This method is supported for compatibility but it's recommended to use the FSRM WMI
    ///Classes to manage FSRM. Please see the MSFT_FSRMFileScreen class.] Applies the property values of the specified
    ///file screen template to this file screen object.
    ///Params:
    ///    fileScreenTemplateName = The name of the file screen template. The string is limited to 4,000 characters.
    ///Returns:
    ///    The method returns the following return values.
    ///    
    HRESULT ApplyTemplate(BSTR fileScreenTemplateName);
}

///<p class="CCE_Message">[This interface is supported for compatibility but it's recommended to use the FSRM WMI
///Classes to manage FSRM. Please see the MSFT_FSRMFileScreenException class.] Used to configure an exception that
///excludes the specified files from the file screening process. This allows the files of a file group to be saved in
///the directory when a file screen that applies to the directory would otherwise prevent the file from being saved in
///the directory. To create this interface, call the IFsrmFileScreenManager::CreateFileScreenException method. The
///following methods return this interface: <ul> <li> IFsrmFileScreenManager::EnumFileScreenExceptions </li> <li>
///IFsrmFileScreenManager::GetFileScreenException </li> </ul>
@GUID("BEE7CE02-DF77-4515-9389-78F01C5AFC1A")
interface IFsrmFileScreenException : IFsrmObject
{
    ///<p class="CCE_Message">[This property is supported for compatibility but it's recommended to use the FSRM WMI
    ///Classes to manage FSRM. Please see the MSFT_FSRMFileScreenException class.] Retrieves the path that is associated
    ///with this file screen exception. This property is read-only.
    HRESULT get_Path(BSTR* path);
    ///<p class="CCE_Message">[This property is supported for compatibility but it's recommended to use the FSRM WMI
    ///Classes to manage FSRM. Please see the MSFT_FSRMFileScreenException class.] Retrieves or sets the names of the
    ///file groups that contain the file name patterns of the files that are allowed in the directory. This property is
    ///read/write.
    HRESULT get_AllowedFileGroups(IFsrmMutableCollection* allowList);
    ///<p class="CCE_Message">[This property is supported for compatibility but it's recommended to use the FSRM WMI
    ///Classes to manage FSRM. Please see the MSFT_FSRMFileScreenException class.] Retrieves or sets the names of the
    ///file groups that contain the file name patterns of the files that are allowed in the directory. This property is
    ///read/write.
    HRESULT put_AllowedFileGroups(IFsrmMutableCollection allowList);
}

///Used to manage file screen objects. To get this interface, call the CoCreateInstanceEx function. Use
///<b>CLSID_FsrmFileScreenManager</b> as the class identifier and <code>__uuidof(IFsrmFileScreenManager)</code> as the
///interface identifier. For an example, see Defining a File Screen.
@GUID("FF4FA04E-5A94-4BDA-A3A0-D5B4D3C52EBA")
interface IFsrmFileScreenManager : IDispatch
{
    ///Retrieves a list of macros that you can specify in action property values. This property is read-only.
    HRESULT get_ActionVariables(SAFEARRAY** variables);
    ///Retrieves the descriptions for the macros contained in the IFsrmFileScreenManager::ActionVariables property. This
    ///property is read-only.
    HRESULT get_ActionVariableDescriptions(SAFEARRAY** descriptions);
    ///Creates a file screen object.
    ///Params:
    ///    path = The local directory path to which the file screen applies. The string is limited to 260 characters.
    ///    fileScreen = An IFsrmFileScreen interface of the newly created file screen. To add the file screen to FSRM, call the
    ///                 IFsrmFileScreen::Commit method.
    ///Returns:
    ///    The method returns the following return values.
    ///    
    HRESULT CreateFileScreen(BSTR path, IFsrmFileScreen* fileScreen);
    ///Retrieves the specified file screen.
    ///Params:
    ///    path = The local directory path associated with the file screen that you want to retrieve. The path is limited to
    ///           260 characters.
    ///    fileScreen = An IFsrmFileScreen interface to the file screen.
    ///Returns:
    ///    The method returns the following return values.
    ///    
    HRESULT GetFileScreen(BSTR path, IFsrmFileScreen* fileScreen);
    ///Enumerates the file screens for the specified directory and its subdirectories.
    ///Params:
    ///    path = The local directory path associated with the file screen that you want to retrieve. If the path ends with
    ///           "\*", retrieve all file screens associated with the immediate subdirectories of the path (does not include
    ///           the file screen associated with the path). If the path ends with "\...", retrieve the file screen for the
    ///           path and all file screens associated with the immediate subdirectories of the path (recursively). If the path
    ///           does not end in "\*" or "\...", retrieve the file screen for the path only. If path is null or empty, the
    ///           method returns all file screens.
    ///    options = The options to use when enumerating the file screens. For possible values, see the FsrmEnumOptions
    ///              enumeration.
    ///    fileScreens = An IFsrmCommittableCollection interface that contains a collection of file screens. Each item of the
    ///                  collection is a <b>VARIANT</b> of type <b>VT_DISPATCH</b>. Query the <b>pdispVal</b> member of the variant
    ///                  for the IFsrmFileScreen interface. The collection contains only committed file screens; the collection will
    ///                  not contain newly created file screens that have not been committed. The collection is empty if the path does
    ///                  not contain file screens.
    ///Returns:
    ///    The method returns the following return values.
    ///    
    HRESULT EnumFileScreens(BSTR path, FsrmEnumOptions options, IFsrmCommittableCollection* fileScreens);
    ///Creates a file screen exception object.
    ///Params:
    ///    path = The local directory path to which the file screen exception applies. The path is limited to 260 characters.
    ///    fileScreenException = An IFsrmFileScreenException interface of the newly created file screen exception. To add the exception to
    ///                          FSRM, call IFsrmFileScreenException::Commit method.
    ///Returns:
    ///    The method returns the following return values.
    ///    
    HRESULT CreateFileScreenException(BSTR path, IFsrmFileScreenException* fileScreenException);
    ///Retrieves the specified file screen exception.
    ///Params:
    ///    path = The local directory path associated with the file screen exception that you want to retrieve. The path is
    ///           limited to 260 characters.
    ///    fileScreenException = An IFsrmFileScreenException interface to the file screen exception.
    ///Returns:
    ///    The method returns the following return values.
    ///    
    HRESULT GetFileScreenException(BSTR path, IFsrmFileScreenException* fileScreenException);
    ///Enumerates the file screen exceptions for the specified directory and its subdirectories.
    ///Params:
    ///    path = The local directory path associated with the file screen exception that you want to retrieve. If the path
    ///           ends with "\*", retrieve all exceptions associated with the immediate subdirectories of the path (does not
    ///           include the exceptions associated with the path). If the path ends with "\...", retrieve the exception for
    ///           the path and all exceptions associated with the immediate subdirectories of the path (recursively). If the
    ///           path does not end in "\*" or "\...", retrieve the exception for the path only. If path is null or empty, the
    ///           method returns all file screen exceptions.
    ///    options = The options to use when enumerating the exceptions. For possible values, see the FsrmEnumOptions enumeration.
    ///    fileScreenExceptions = An IFsrmCommittableCollection interface that contains a collection of file screen exceptions. Each item of
    ///                           the collection is a <b>VARIANT</b> of type <b>VT_DISPATCH</b>. Query the <b>pdispVal</b> member of the
    ///                           variant for the IFsrmFileScreenException interface. The collection contains only committed exceptions; the
    ///                           collection will not contain newly created exceptions that have not been committed. The collection is empty if
    ///                           the path does not contain file screen exceptions.
    ///Returns:
    ///    The method returns the following return values.
    ///    
    HRESULT EnumFileScreenExceptions(BSTR path, FsrmEnumOptions options, 
                                     IFsrmCommittableCollection* fileScreenExceptions);
    ///Creates an empty collection to which you can add file screens.
    ///Params:
    ///    collection = An IFsrmCommittableCollection interface to the newly created collection. To add an object to the collection,
    ///                 call the IFsrmMutableCollection::Add method.
    ///Returns:
    ///    The method returns the following return values.
    ///    
    HRESULT CreateFileScreenCollection(IFsrmCommittableCollection* collection);
}

///<p class="CCE_Message">[This interface is supported for compatibility but it's recommended to use the FSRM WMI
///Classes to manage FSRM. Please see the MSFT_FSRMFileScreenTemplate class.] Used to configure templates from which new
///file screens can be derived. Templates are identified by a name and are used to simplify configuration of file
///screens. To create this interface, call the IFsrmFileScreenTemplate::CreateTemplate method. The following methods
///return this interface: <ul> <li> IFsrmFileScreenTemplate::EnumTemplates </li> <li>
///IFsrmFileScreenTemplate::GetTemplate </li> <li> IFsrmFileScreenTemplate::ImportTemplates </li> </ul>
@GUID("205BEBF8-DD93-452A-95A6-32B566B35828")
interface IFsrmFileScreenTemplate : IFsrmFileScreenBase
{
    ///<p class="CCE_Message">[This property is supported for compatibility but it's recommended to use the FSRM WMI
    ///Classes to manage FSRM. Please see the MSFT_FSRMFileScreenTemplate class.] Retrieves and sets the name of the
    ///file screen template. This property is read/write.
    HRESULT get_Name(BSTR* name);
    ///<p class="CCE_Message">[This property is supported for compatibility but it's recommended to use the FSRM WMI
    ///Classes to manage FSRM. Please see the MSFT_FSRMFileScreenTemplate class.] Retrieves and sets the name of the
    ///file screen template. This property is read/write.
    HRESULT put_Name(BSTR name);
    ///<p class="CCE_Message">[This method is supported for compatibility but it's recommended to use the FSRM WMI
    ///Classes to manage FSRM. Please see the MSFT_FSRMFileScreenTemplate class.] Copies the property values of the
    ///specified template to this template.
    ///Params:
    ///    fileScreenTemplateName = The name of another template from which to copy the property values. The name is limited to 4,000 characters.
    ///Returns:
    ///    The method returns the following return values.
    ///    
    HRESULT CopyTemplate(BSTR fileScreenTemplateName);
    ///<p class="CCE_Message">[This method is supported for compatibility but it's recommended to use the FSRM WMI
    ///Classes to manage FSRM. Please see the MSFT_FSRMFileScreenTemplate class.] Saves the file screen template and
    ///then applies any changes to the derived file screen objects.
    ///Params:
    ///    commitOptions = The options for saving the template. For possible values, see the FsrmCommitOptions enumeration.
    ///    applyOptions = The options used to choose the derived objects to which the changes are applied. For possible values, see the
    ///                   FsrmTemplateApplyOptions enumeration.
    ///    derivedObjectsResult = An IFsrmDerivedObjectsResult interface that you use to determine the list of derived objects that were
    ///                           updated and whether the update was successful.
    ///Returns:
    ///    The method returns the following return values.
    ///    
    HRESULT CommitAndUpdateDerived(FsrmCommitOptions commitOptions, FsrmTemplateApplyOptions applyOptions, 
                                   IFsrmDerivedObjectsResult* derivedObjectsResult);
}

///Used to save imported file screen templates. The IFsrmExportImport::ImportFileScreenTemplates method returns this
///interface.
@GUID("E1010359-3E5D-4ECD-9FE4-EF48622FDF30")
interface IFsrmFileScreenTemplateImported : IFsrmFileScreenTemplate
{
    ///Retrieves or sets a value that determines whether a file screen template is overwritten if it exists when the
    ///template is imported. This property is read/write.
    HRESULT get_OverwriteOnCommit(short* overwrite);
    ///Retrieves or sets a value that determines whether a file screen template is overwritten if it exists when the
    ///template is imported. This property is read/write.
    HRESULT put_OverwriteOnCommit(short overwrite);
}

///Used to manage file screen templates. To get this interface, call the CoCreateInstanceEx function. Use
///<b>CLSID_FsrmFileScreenTemplateManager</b> as the class identifier and
///<code>__uuidof(IFsrmFileScreenTemplateManager)</code> as the interface identifier. For an example, see Using
///Templates to Define File Screens.
@GUID("CFE36CBA-1949-4E74-A14F-F1D580CEAF13")
interface IFsrmFileScreenTemplateManager : IDispatch
{
    ///Creates a file screen template object.
    ///Params:
    ///    fileScreenTemplate = An IFsrmFileScreenTemplate interface to the newly create template. To add the template to FSRM, call the
    ///                         IFsrmFileScreenTemplate::Commit method.
    ///Returns:
    ///    The method returns the following return values.
    ///    
    HRESULT CreateTemplate(IFsrmFileScreenTemplate* fileScreenTemplate);
    ///Retrieves the specified file screen template.
    ///Params:
    ///    name = The name of the file screen template to retrieve. The name is limited to 4,000 characters.
    ///    fileScreenTemplate = An IFsrmFileScreenTemplate interface to the retrieved template.
    ///Returns:
    ///    The method returns the following return values.
    ///    
    HRESULT GetTemplate(BSTR name, IFsrmFileScreenTemplate* fileScreenTemplate);
    ///Enumerates the file screen templates on the server.
    ///Params:
    ///    options = The options to use when enumerating the file screen templates. For possible values, see the FsrmEnumOptions
    ///              enumeration.
    ///    fileScreenTemplates = An IFsrmCommittableCollection interface that contains a collection of file screen templates. Each item of the
    ///                          collection is a <b>VARIANT</b> of type <b>VT_DISPATCH</b>. Query the <b>pdispVal</b> member of the variant
    ///                          for the IFsrmFileScreenTemplate interface.
    ///Returns:
    ///    The method returns the following return values.
    ///    
    HRESULT EnumTemplates(FsrmEnumOptions options, IFsrmCommittableCollection* fileScreenTemplates);
    ///Exports the templates as an XML string.
    ///Params:
    ///    fileScreenTemplateNamesArray = A variant that contains the names of the file screen templates to export. If <b>NULL</b>, the method exports
    ///                                   all file screens.
    ///    serializedFileScreenTemplates = The specified templates in XML format.
    ///Returns:
    ///    The method returns the following return values.
    ///    
    HRESULT ExportTemplates(VARIANT* fileScreenTemplateNamesArray, BSTR* serializedFileScreenTemplates);
    ///Imports the specified file screen templates from an XML string.
    ///Params:
    ///    serializedFileScreenTemplates = An XML string that represents one or more file screen templates.
    ///    fileScreenTemplateNamesArray = A <b>VARIANT</b> that contains a <b>SAFEARRAY</b> of the names of the templates to import. If <b>NULL</b>,
    ///                                   the method imports all templates.
    ///    fileScreenTemplates = An IFsrmCommittableCollection interface that contains a collection of file screen templates. Each item of the
    ///                          collection is a <b>VARIANT</b> of type <b>VT_DISPATCH</b>. Query the <b>pdispVal</b> member of the variant
    ///                          for the IFsrmFileScreenTemplateImported interface. To add the templates to FSRM, call the
    ///                          IFsrmCommittableCollection::Commit method. To add the templates to FSRM and propagate the changes to objects
    ///                          that were derived from the template, call the IFsrmFileScreenTemplateImported::CommitAndUpdateDerived method
    ///                          on each item in the collection.
    ///Returns:
    ///    The method returns the following return values.
    ///    
    HRESULT ImportTemplates(BSTR serializedFileScreenTemplates, VARIANT* fileScreenTemplateNamesArray, 
                            IFsrmCommittableCollection* fileScreenTemplates);
}

///Used to manage report jobs. To get this interface, call the CoCreateInstanceEx function. Use
///<b>CLSID_FsrmReportManager</b> as the class identifier and <code>__uuidof(IFsrmReportManager)</code> as the interface
///identifier. For an example, see Defining a Report Job.
@GUID("27B899FE-6FFA-4481-A184-D3DAADE8A02B")
interface IFsrmReportManager : IDispatch
{
    ///Enumerates the report jobs.
    ///Params:
    ///    options = The options to use when enumerating the report jobs. For possible values, see the FsrmEnumOptions
    ///              enumeration. <div class="alert"><b>Note</b> The <b>FsrmEnumOptions_Asynchronous</b> option is not supported
    ///              for this method.</div> <div> </div>
    ///    reportJobs = An IFsrmCollection interface that contains a collection of the report jobs. The collection is empty if no
    ///                 report jobs. Each item of the collection is a <b>VARIANT</b> of type <b>VT_DISPATCH</b>. Query the
    ///                 <b>pdispVal</b> member to get the IFsrmReportJob interface. The collection can contain committed and
    ///                 uncommitted report jobs. For an uncommitted report job to be included in the collection, the running status
    ///                 of the job must be <b>FsrmReportRunningStatus_Queued</b> or <b>FsrmReportRunningStatus_Running</b>.
    ///Returns:
    ///    The method returns the following return values.
    ///    
    HRESULT EnumReportJobs(FsrmEnumOptions options, IFsrmCollection* reportJobs);
    ///Creates a report job.
    ///Params:
    ///    reportJob = An IFsrmReportJob interface of the newly created report job object. Use the interface to add reports to the
    ///                job and run the reports. To add the report job to FSRM, call IFsrmReportJob::Commit method.
    ///Returns:
    ///    The method returns the following return values.
    ///    
    HRESULT CreateReportJob(IFsrmReportJob* reportJob);
    ///Retrieves the specified report job.
    ///Params:
    ///    taskName = The task name that identifies the report job to retrieve. The string is limited to 230 characters.
    ///    reportJob = An IFsrmReportJob interface to the retrieved job.
    ///Returns:
    ///    The method returns the following return values.
    ///    
    HRESULT GetReportJob(BSTR taskName, IFsrmReportJob* reportJob);
    ///Retrieves the local directory path where the reports with the specified context are stored.
    ///Params:
    ///    context = The report context (for example, if the report is scheduled or run on demand). For possible values, see the
    ///              FsrmReportGenerationContext enumeration.
    ///    path = The local directory path where the reports are stored.
    ///Returns:
    ///    The method returns the following return values.
    ///    
    HRESULT GetOutputDirectory(FsrmReportGenerationContext context, BSTR* path);
    ///Sets the local directory path where reports are stored.
    ///Params:
    ///    context = The report context (for example, if the report is scheduled or runs on demand). For possible values, see the
    ///              FsrmReportGenerationContext enumeration.
    ///    path = The full path to the local directory where the reports are stored. The path can contain environment
    ///           variables. The path is limited to 150 characters.
    ///Returns:
    ///    The method returns the following return values.
    ///    
    HRESULT SetOutputDirectory(FsrmReportGenerationContext context, BSTR path);
    ///Retrieves a value that determines whether a specified report filter is configurable for the specified report
    ///type.
    ///Params:
    ///    reportType = Report type. For possible values, see the FsrmReportType enumeration.
    ///    filter = Report filter. For possible values, see the FsrmReportFilter enumeration.
    ///    valid = Is <b>VARIANT_TRUE</b> if the filter is configurable for the report type, otherwise it is
    ///            <b>VARIANT_FALSE</b>.
    ///Returns:
    ///    The method returns the following return values.
    ///    
    HRESULT IsFilterValidForReportType(FsrmReportType reportType, FsrmReportFilter filter, short* valid);
    ///Retrieves the default report filter value that is used with the specified report type.
    ///Params:
    ///    reportType = Report type. For possible values, see the FsrmReportType enumeration.
    ///    filter = Report filter. For possible values, see the FsrmReportFilter enumeration.
    ///    filterValue = The default report filter value.
    ///Returns:
    ///    The method returns the following return values.
    ///    
    HRESULT GetDefaultFilter(FsrmReportType reportType, FsrmReportFilter filter, VARIANT* filterValue);
    ///Sets the default report filter value to use with the specified report type.
    ///Params:
    ///    reportType = The report type. For possible values, see the FsrmReportType enumeration.
    ///    filter = The report filter. For possible values, see the FsrmReportFilter enumeration.
    ///    filterValue = The default report filter value.
    ///Returns:
    ///    The method returns the following return values.
    ///    
    HRESULT SetDefaultFilter(FsrmReportType reportType, FsrmReportFilter filter, VARIANT filterValue);
    ///Retrieves the current value of the specified report size limit.
    ///Params:
    ///    limit = The report size limit which is used to limit the files listed in a report. For possible values, see the
    ///            FsrmReportLimit enumeration.
    ///    limitValue = The limit. The variant type is <b>VT_I4</b>. Use the <b>lVal</b> member of the variant to access the limit
    ///                 value.
    ///Returns:
    ///    The method returns the following return values.
    ///    
    HRESULT GetReportSizeLimit(FsrmReportLimit limit, VARIANT* limitValue);
    ///Sets the current value of the specified report size limit.
    ///Params:
    ///    limit = Identifies the limit which is used to limit the files listed in a report. For possible values, see the
    ///            FsrmReportLimit enumeration.
    ///    limitValue = The limit. Must be greater than zero. You can specify the variant as a short, int, or long that is either
    ///                 signed or unsigned. The method will also accept a string value. The method must be able to convert the value
    ///                 to a positive, long number. For example, to pass the value as a long, set the variant type to <b>VT_I4</b>
    ///                 and then set the <b>lVal</b> member of the variant to the limit value.
    ///Returns:
    ///    The method returns the following return values.
    ///    
    HRESULT SetReportSizeLimit(FsrmReportLimit limit, VARIANT limitValue);
}

///Used to configure a report job. The job specifies a set of directories that will be scanned to generate one or more
///different type of reports. The reports help the administrator analyze how the storage is used. The job may also be
///associated with a scheduled task that will trigger report generation. To create this interface, call the
///IFsrmReportManager::CreateReportJob method. The following methods return this interface: <ul> <li>
///IFsrmReportManager::EnumReportJobs </li> <li> IFsrmReportManager::GetReportJob </li> </ul>
@GUID("38E87280-715C-4C7D-A280-EA1651A19FEF")
interface IFsrmReportJob : IFsrmObject
{
    ///Retrieves or sets the name of the report job. This property is read/write.
    HRESULT get_Task(BSTR* taskName);
    ///Retrieves or sets the name of the report job. This property is read/write.
    HRESULT put_Task(BSTR taskName);
    ///Retrieves or sets an array of local directory paths that will be scanned when the report job is run. This
    ///property is read/write.
    HRESULT get_NamespaceRoots(SAFEARRAY** namespaceRoots);
    ///Retrieves or sets an array of local directory paths that will be scanned when the report job is run. This
    ///property is read/write.
    HRESULT put_NamespaceRoots(SAFEARRAY* namespaceRoots);
    ///Retrieves or sets an array of formats that determine the content format of the reports. This property is
    ///read/write.
    HRESULT get_Formats(SAFEARRAY** formats);
    ///Retrieves or sets an array of formats that determine the content format of the reports. This property is
    ///read/write.
    HRESULT put_Formats(SAFEARRAY* formats);
    ///Retrieves or sets the email addresses of those that will receive the reports via email. This property is
    ///read/write.
    HRESULT get_MailTo(BSTR* mailTo);
    ///Retrieves or sets the email addresses of those that will receive the reports via email. This property is
    ///read/write.
    HRESULT put_MailTo(BSTR mailTo);
    ///Retrieves the running status of the report job. This property is read-only.
    HRESULT get_RunningStatus(FsrmReportRunningStatus* runningStatus);
    ///Retrieves the time stamp for when the reports were last run. This property is read-only.
    HRESULT get_LastRun(double* lastRun);
    ///Retrieves the error message from the last time the reports were run. This property is read-only.
    HRESULT get_LastError(BSTR* lastError);
    ///Retrieves the local directory path where the reports were stored the last time the reports were run. This
    ///property is read-only.
    HRESULT get_LastGeneratedInDirectory(BSTR* path);
    ///Enumerates all the reports configured for this report job.
    ///Params:
    ///    reports = An IFsrmCollection interface that contains a collection of reports. The collection is empty if no reports are
    ///              defined for the job. Each item of the collection is a <b>VARIANT</b> of type <b>VT_DISPATCH</b>. Query the
    ///              <b>pdispVal</b> member to get the IFsrmReport interface.
    ///Returns:
    ///    The method returns the following return values.
    ///    
    HRESULT EnumReports(IFsrmCollection* reports);
    ///Creates a new report object of the specified type.
    ///Params:
    ///    reportType = Type of report to generate. For possible values, see theFsrmReportType enumeration. Note that the job can
    ///                 contain only one report of each type.
    ///    report = An IFsrmReport interface to the newly created report. Use the interface to configure the report.
    ///Returns:
    ///    The method returns the following return values.
    ///    
    HRESULT CreateReport(FsrmReportType reportType, IFsrmReport* report);
    ///Runs all the reports in the job.
    ///Params:
    ///    context = Specifies to which subdirectory the reports are written. For possible values, see the
    ///              FsrmReportGenerationContext enumeration.
    ///Returns:
    ///    The method returns the following return values.
    ///    
    HRESULT Run(FsrmReportGenerationContext context);
    ///Waits for the reports in the job to complete.
    ///Params:
    ///    waitSeconds = The number of seconds to wait for the reports to complete. The method returns when the period expires or the
    ///                  reports complete. To wait indefinitely, set the value to –1.
    ///    completed = Is <b>VARIANT_TRUE</b> if the reports completed; otherwise, <b>VARIANT_FALSE</b>.
    ///Returns:
    ///    The method returns the following return values.
    ///    
    HRESULT WaitForCompletion(int waitSeconds, short* completed);
    ///Cancels the running reports for this report job.
    ///Returns:
    ///    The method returns the following return values.
    ///    
    HRESULT Cancel();
}

///Used to configure the description and filters for a single report. To create this interface, call the
///IFsrmReportJob::CreateReport method. The following methods return this interface: <ul> <li>
///IFsrmReportJob::EnumReports </li> </ul>
@GUID("D8CC81D9-46B8-4FA4-BFA5-4AA9DEC9B638")
interface IFsrmReport : IDispatch
{
    ///Retrieves the type of report to generate. This property is read-only.
    HRESULT get_Type(FsrmReportType* reportType);
    ///Retrieves or sets the name of the report. This property is read/write.
    HRESULT get_Name(BSTR* name);
    ///Retrieves or sets the name of the report. This property is read/write.
    HRESULT put_Name(BSTR name);
    ///Retrieves or sets the description of the report. This property is read/write.
    HRESULT get_Description(BSTR* description);
    ///Retrieves or sets the description of the report. This property is read/write.
    HRESULT put_Description(BSTR description);
    ///Retrieves the report's generated file name for the last time the report was run. The string is used to make the
    ///report name unique. This property is read-only.
    HRESULT get_LastGeneratedFileNamePrefix(BSTR* prefix);
    ///Retrieves the value of the specified report filter.
    ///Params:
    ///    filter = The filter used to limit the files listed in a report. For possible values, see the FsrmReportFilter
    ///             enumeration.
    ///    filterValue = The filter value for the specified report filter.
    ///Returns:
    ///    The method returns the following return values.
    ///    
    HRESULT GetFilter(FsrmReportFilter filter, VARIANT* filterValue);
    ///Sets the current value of the specified report filter.
    ///Params:
    ///    filter = The filter used to limit the files listed in a report. For possible values, see the FsrmReportFilter
    ///             enumeration.
    ///    filterValue = The filter value to use for the specified report filter. The filter value cannot contain the following: slash
    ///                  mark (/), backslash (\\), greater than sign (&gt;), less than sign (&lt;), vertical bar (|), double quote
    ///                  ("), or colon (:).
    ///Returns:
    ///    The method returns the following return values.
    ///    
    HRESULT SetFilter(FsrmReportFilter filter, VARIANT filterValue);
    ///Removes this report object from the report job object.
    ///Returns:
    ///    The method returns the following return values.
    ///    
    HRESULT Delete();
}

///<p class="CCE_Message">[Starting with Windows Server 2012 this interface is not supported; use the
///MSFT_FSRMScheduledTask WMI class to manage scheduled tasks.] Used to manage scheduled tasks for report jobs and file
///management jobs. To get this interface, call the CoCreateInstanceEx function. Use <b>CLSID_FsrmReportScheduler</b> as
///the class identifier and <code>__uuidof(IFsrmReportScheduler)</code> as the interface identifier. For an example, see
///Scheduling a Report Job.
@GUID("6879CAF9-6617-4484-8719-71C3D8645F94")
interface IFsrmReportScheduler : IDispatch
{
    ///<p class="CCE_Message">[Starting with Windows Server 2012 this method is not supported; use the
    ///MSFT_FSRMScheduledTask WMI class to manage scheduled tasks.] Verifies that the specified local directory paths
    ///that are used as the source for the reports are valid.
    ///Params:
    ///    namespacesSafeArray = A <b>VARIANT</b> that contains a <b>SAFEARRAY</b> of local directory paths. Each element of the array is a
    ///                          variant of type <b>VT_BSTR</b>. Use the <b>bstrVal</b> member of the variant to set the path.
    ///Returns:
    ///    The method returns the following return values.
    ///    
    HRESULT VerifyNamespaces(VARIANT* namespacesSafeArray);
    ///<p class="CCE_Message">[Starting with Windows Server 2012 this method is not supported; use the
    ///MSFT_FSRMScheduledTask WMI class to manage scheduled tasks.] Creates a scheduled task that is used to trigger a
    ///report job.
    ///Params:
    ///    taskName = The name of a Task Scheduler task to create. The string is limited to 230 characters.
    ///    namespacesSafeArray = A <b>VARIANT</b> that contains a <b>SAFEARRAY</b> of local directory paths to verify (see Remarks). Each
    ///                          element of the array is a variant of type <b>VT_BSTR</b>. Use the <b>bstrVal</b> member of the variant to set
    ///                          the path.
    ///    serializedTask = An XML string that defines the Task Scheduler job. For details, see Task Scheduler Schema.
    ///Returns:
    ///    The method returns the following return values.
    ///    
    HRESULT CreateScheduleTask(BSTR taskName, VARIANT* namespacesSafeArray, BSTR serializedTask);
    ///<p class="CCE_Message">[Starting with Windows Server 2012 this method is not supported; use the
    ///MSFT_FSRMScheduledTask WMI class to manage scheduled tasks.] Modifies a task that is used to trigger a report
    ///job.
    ///Params:
    ///    taskName = The name of a Task Scheduler task to modify. The string is limited to 230 characters.
    ///    namespacesSafeArray = A <b>VARIANT</b> that contains a <b>SAFEARRAY</b> of local directory paths to verify (see Remarks). Each
    ///                          element of the array is a variant of type <b>VT_BSTR</b>. Use the <b>bstrVal</b> member of the variant to set
    ///                          the path.
    ///    serializedTask = An XML string that defines the Task Scheduler job. For details, see Task Scheduler Schema.
    ///Returns:
    ///    The method returns the following return values.
    ///    
    HRESULT ModifyScheduleTask(BSTR taskName, VARIANT* namespacesSafeArray, BSTR serializedTask);
    ///<p class="CCE_Message">[Starting with Windows Server 2012 this method is not supported; use the
    ///MSFT_FSRMScheduledTask WMI class to manage scheduled tasks.] Deletes a task that is used to trigger a report job.
    ///Params:
    ///    taskName = The name of a Task Scheduler task to delete. The string is limited to 230 characters.
    ///Returns:
    ///    The method returns the following return values.
    ///    
    HRESULT DeleteScheduleTask(BSTR taskName);
}

///Used to manage file management jobs. To get this interface, call the CoCreateInstanceEx function. Use
///<b>CLSID_FsrmFileManagementJobManager</b> as the class identifier and
///<code>__uuidof(IFsrmFileManagementJobManager)</code> as the interface identifier.
@GUID("EE321ECB-D95E-48E9-907C-C7685A013235")
interface IFsrmFileManagementJobManager : IDispatch
{
    ///Retrieves a list of macros that you can specify in action property values. This property is read-only.
    HRESULT get_ActionVariables(SAFEARRAY** variables);
    ///Retrieves the descriptions for the macros contained in the IFsrmFileManagementJobManager::ActionVariables
    ///property. This property is read-only.
    HRESULT get_ActionVariableDescriptions(SAFEARRAY** descriptions);
    ///Enumerates the list of existing file management jobs.
    ///Params:
    ///    options = One or more options to use when enumerating the management jobs. For possible values, see the FsrmEnumOptions
    ///              enumeration. <div class="alert"><b>Note</b> This parameter must be set to either
    ///              <b>FsrmEnumOptions_IncludeClusterNodes</b> or <b>FsrmEnumOptions_None</b> for this method.</div> <div> </div>
    ///    fileManagementJobs = An IFsrmCollection interface that contains a collection of file management jobs. The variant type of each
    ///                         item in the collection is <b>VT_DISPATCH</b>. Query the <b>pdispVal</b> member of the variant to get an
    ///                         IFsrmFileManagementJob interface to the job.
    ///Returns:
    ///    The method returns the following return values.
    ///    
    HRESULT EnumFileManagementJobs(FsrmEnumOptions options, IFsrmCollection* fileManagementJobs);
    ///Creates a file management job.
    ///Params:
    ///    fileManagementJob = An IFsrmFileManagementJob interface that you use to define the new file management job.
    ///Returns:
    ///    The method returns the following return values.
    ///    
    HRESULT CreateFileManagementJob(IFsrmFileManagementJob* fileManagementJob);
    ///Gets the specified file management job.
    ///Params:
    ///    name = The name of the file management job to retrieve.
    ///    fileManagementJob = An IFsrmFileManagementJob interface to the specified file management job.
    ///Returns:
    ///    The method returns the following return values.
    ///    
    HRESULT GetFileManagementJob(BSTR name, IFsrmFileManagementJob* fileManagementJob);
}

///<p class="CCE_Message">[This interface is supported for compatibility but it's recommended to use the FSRM WMI
///Classes to manage FSRM. Please see the MSFT_FSRMFileManagementJob class.] Defines a file management job. The job
///specifies a schedule, conditions, a command or actions to execute if a file meets all the conditions, user
///notifications, and reporting. To create a file management job, call the
///IFsrmFileManagementJobManager::CreateFileManagementJob method. The following methods return this interface: <ul> <li>
///IFsrmFileManagementJobManager::EnumFileManagementJobs </li> <li> IFsrmFileManagementJobManager::GetFileManagementJob
///</li> </ul>If a file management job object is modified using MSFT_FSRMFileManagementJob or a related WMI class, then
///the methods and properties of the <b>IFsrmFileManagementJob</b> interface may no longer be usable and fail in
///unexpected ways when working with the same job.
@GUID("0770687E-9F36-4D6F-8778-599D188461C9")
interface IFsrmFileManagementJob : IFsrmObject
{
    ///<p class="CCE_Message">[This property is supported for compatibility but it's recommended to use the FSRM WMI
    ///Classes to manage FSRM. Please see the MSFT_FSRMFileManagementJob class.] The name of the file management job.
    ///This property is read/write.
    HRESULT get_Name(BSTR* name);
    ///<p class="CCE_Message">[This property is supported for compatibility but it's recommended to use the FSRM WMI
    ///Classes to manage FSRM. Please see the MSFT_FSRMFileManagementJob class.] The name of the file management job.
    ///This property is read/write.
    HRESULT put_Name(BSTR name);
    ///<p class="CCE_Message">[This property is supported for compatibility but it's recommended to use the FSRM WMI
    ///Classes to manage FSRM. Please see the MSFT_FSRMFileManagementJob class.] An array of local directory paths that
    ///will be scanned when the file management job is run. This property is read/write.
    HRESULT get_NamespaceRoots(SAFEARRAY** namespaceRoots);
    ///<p class="CCE_Message">[This property is supported for compatibility but it's recommended to use the FSRM WMI
    ///Classes to manage FSRM. Please see the MSFT_FSRMFileManagementJob class.] An array of local directory paths that
    ///will be scanned when the file management job is run. This property is read/write.
    HRESULT put_NamespaceRoots(SAFEARRAY* namespaceRoots);
    ///<p class="CCE_Message">[This property is supported for compatibility but it's recommended to use the FSRM WMI
    ///Classes to manage FSRM. Please see the MSFT_FSRMFileManagementJob class.] Indicates whether the job enabled (can
    ///run). This property is read/write.
    HRESULT get_Enabled(short* enabled);
    ///<p class="CCE_Message">[This property is supported for compatibility but it's recommended to use the FSRM WMI
    ///Classes to manage FSRM. Please see the MSFT_FSRMFileManagementJob class.] Indicates whether the job enabled (can
    ///run). This property is read/write.
    HRESULT put_Enabled(short enabled);
    ///<p class="CCE_Message">[This property is supported for compatibility but it's recommended to use the FSRM WMI
    ///Classes to manage FSRM. Please see the MSFT_FSRMFileManagementJob class.] The type of file management job. The
    ///type determines the operation to perform on a file when all conditions are met. This property is read/write.
    HRESULT get_OperationType(FsrmFileManagementType* operationType);
    ///<p class="CCE_Message">[This property is supported for compatibility but it's recommended to use the FSRM WMI
    ///Classes to manage FSRM. Please see the MSFT_FSRMFileManagementJob class.] The type of file management job. The
    ///type determines the operation to perform on a file when all conditions are met. This property is read/write.
    HRESULT put_OperationType(FsrmFileManagementType operationType);
    ///<p class="CCE_Message">[This property is supported for compatibility but it's recommended to use the FSRM WMI
    ///Classes to manage FSRM. Please see the MSFT_FSRMFileManagementJob class.] The root directory that will contain
    ///the expired files. This property is read/write.
    HRESULT get_ExpirationDirectory(BSTR* expirationDirectory);
    ///<p class="CCE_Message">[This property is supported for compatibility but it's recommended to use the FSRM WMI
    ///Classes to manage FSRM. Please see the MSFT_FSRMFileManagementJob class.] The root directory that will contain
    ///the expired files. This property is read/write.
    HRESULT put_ExpirationDirectory(BSTR expirationDirectory);
    ///<p class="CCE_Message">[This property is supported for compatibility but it's recommended to use the FSRM WMI
    ///Classes to manage FSRM. Please see the MSFT_FSRMFileManagementJob class.] The action to execute when all the
    ///conditions are met. This property is read-only.
    HRESULT get_CustomAction(IFsrmActionCommand* action);
    ///<p class="CCE_Message">[This method is supported for compatibility but it's recommended to use the FSRM WMI
    ///Classes to manage FSRM. Please see the MSFT_FSRMFMJNotification class.] The list of notification periods defined
    ///for the job. This property is read-only.
    HRESULT get_Notifications(SAFEARRAY** notifications);
    ///<p class="CCE_Message">[This property is supported for compatibility but it's recommended to use the FSRM WMI
    ///Classes to manage FSRM. Please see the MSFT_FSRMFileManagementJob class.] The types of logging to perform. This
    ///property is read/write.
    HRESULT get_Logging(int* loggingFlags);
    ///<p class="CCE_Message">[This property is supported for compatibility but it's recommended to use the FSRM WMI
    ///Classes to manage FSRM. Please see the MSFT_FSRMFileManagementJob class.] The types of logging to perform. This
    ///property is read/write.
    HRESULT put_Logging(int loggingFlags);
    ///<p class="CCE_Message">[This property is supported for compatibility but it's recommended to use the FSRM WMI
    ///Classes to manage FSRM. Please see the MSFT_FSRMFileManagementJob class.] Indicates whether the job will generate
    ///a report when it runs. This property is read/write.
    HRESULT get_ReportEnabled(short* reportEnabled);
    ///<p class="CCE_Message">[This property is supported for compatibility but it's recommended to use the FSRM WMI
    ///Classes to manage FSRM. Please see the MSFT_FSRMFileManagementJob class.] Indicates whether the job will generate
    ///a report when it runs. This property is read/write.
    HRESULT put_ReportEnabled(short reportEnabled);
    ///<p class="CCE_Message">[This property is supported for compatibility but it's recommended to use the FSRM WMI
    ///Classes to manage FSRM. Please see the MSFT_FSRMFileManagementJob class.] The formats of the report to generate
    ///when the job is run. This property is read/write.
    HRESULT get_Formats(SAFEARRAY** formats);
    ///<p class="CCE_Message">[This property is supported for compatibility but it's recommended to use the FSRM WMI
    ///Classes to manage FSRM. Please see the MSFT_FSRMFileManagementJob class.] The formats of the report to generate
    ///when the job is run. This property is read/write.
    HRESULT put_Formats(SAFEARRAY* formats);
    ///<p class="CCE_Message">[This property is supported for compatibility but it's recommended to use the FSRM WMI
    ///Classes to manage FSRM. Please see the MSFT_FSRMFileManagementJob class.] The email addresses to which to send
    ///the reports, if any. This property is read/write.
    HRESULT get_MailTo(BSTR* mailTo);
    ///<p class="CCE_Message">[This property is supported for compatibility but it's recommended to use the FSRM WMI
    ///Classes to manage FSRM. Please see the MSFT_FSRMFileManagementJob class.] The email addresses to which to send
    ///the reports, if any. This property is read/write.
    HRESULT put_MailTo(BSTR mailTo);
    ///<p class="CCE_Message">[This property is supported for compatibility but it's recommended to use the FSRM WMI
    ///Classes to manage FSRM. Please see the MSFT_FSRMFileManagementJob class.] The number of days that have elapsed
    ///since the file was created. This property is read/write.
    HRESULT get_DaysSinceFileCreated(int* daysSinceCreation);
    ///<p class="CCE_Message">[This property is supported for compatibility but it's recommended to use the FSRM WMI
    ///Classes to manage FSRM. Please see the MSFT_FSRMFileManagementJob class.] The number of days that have elapsed
    ///since the file was created. This property is read/write.
    HRESULT put_DaysSinceFileCreated(int daysSinceCreation);
    ///<p class="CCE_Message">[This property is supported for compatibility but it's recommended to use the FSRM WMI
    ///Classes to manage FSRM. Please see the MSFT_FSRMFileManagementJob class.] The number of days that have elapsed
    ///since the file was last accessed. This property is read/write.
    HRESULT get_DaysSinceFileLastAccessed(int* daysSinceAccess);
    ///<p class="CCE_Message">[This property is supported for compatibility but it's recommended to use the FSRM WMI
    ///Classes to manage FSRM. Please see the MSFT_FSRMFileManagementJob class.] The number of days that have elapsed
    ///since the file was last accessed. This property is read/write.
    HRESULT put_DaysSinceFileLastAccessed(int daysSinceAccess);
    ///<p class="CCE_Message">[This property is supported for compatibility but it's recommended to use the FSRM WMI
    ///Classes to manage FSRM. Please see the MSFT_FSRMFileManagementJob class.] The number of days that have elapsed
    ///since a file was last modified. This property is read/write.
    HRESULT get_DaysSinceFileLastModified(int* daysSinceModify);
    ///<p class="CCE_Message">[This property is supported for compatibility but it's recommended to use the FSRM WMI
    ///Classes to manage FSRM. Please see the MSFT_FSRMFileManagementJob class.] The number of days that have elapsed
    ///since a file was last modified. This property is read/write.
    HRESULT put_DaysSinceFileLastModified(int daysSinceModify);
    ///<p class="CCE_Message">[This property is supported for compatibility but it's recommended to use the FSRM WMI
    ///Classes to manage FSRM. Please see the MSFT_FSRMFileManagementJob class.] A list of property conditions specified
    ///for the job. This property is read-only.
    HRESULT get_PropertyConditions(IFsrmCollection* propertyConditions);
    ///<p class="CCE_Message">[This property is supported for compatibility but it's recommended to use the FSRM WMI
    ///Classes to manage FSRM. Please see the MSFT_FSRMFileManagementJob class.] The date from which you want the file
    ///management job to begin expiring files (moving files to the expired files directory). This property also applies
    ///to custom commands for the file management job. This property is read/write.
    HRESULT get_FromDate(double* fromDate);
    ///<p class="CCE_Message">[This property is supported for compatibility but it's recommended to use the FSRM WMI
    ///Classes to manage FSRM. Please see the MSFT_FSRMFileManagementJob class.] The date from which you want the file
    ///management job to begin expiring files (moving files to the expired files directory). This property also applies
    ///to custom commands for the file management job. This property is read/write.
    HRESULT put_FromDate(double fromDate);
    ///<p class="CCE_Message">[This property is supported for compatibility but it's recommended to use the FSRM WMI
    ///Classes to manage FSRM. Please see the MSFT_FSRMFileManagementJob class.] The name of the scheduled task to
    ///associate with the job. This property is read/write.
    HRESULT get_Task(BSTR* taskName);
    ///<p class="CCE_Message">[This property is supported for compatibility but it's recommended to use the FSRM WMI
    ///Classes to manage FSRM. Please see the MSFT_FSRMFileManagementJob class.] The name of the scheduled task to
    ///associate with the job. This property is read/write.
    HRESULT put_Task(BSTR taskName);
    ///<p class="CCE_Message">[This property is supported for compatibility but it's recommended to use the FSRM WMI
    ///Classes to manage FSRM. Please see the MSFT_FSRMFileManagementJob class.] The parameters for the file management
    ///job. This property is read/write.
    HRESULT get_Parameters(SAFEARRAY** parameters);
    ///<p class="CCE_Message">[This property is supported for compatibility but it's recommended to use the FSRM WMI
    ///Classes to manage FSRM. Please see the MSFT_FSRMFileManagementJob class.] The parameters for the file management
    ///job. This property is read/write.
    HRESULT put_Parameters(SAFEARRAY* parameters);
    ///<p class="CCE_Message">[This property is supported for compatibility but it's recommended to use the FSRM WMI
    ///Classes to manage FSRM. Please see the MSFT_FSRMFileManagementJob class.] The running status of the job. This
    ///property is read-only.
    HRESULT get_RunningStatus(FsrmReportRunningStatus* runningStatus);
    ///<p class="CCE_Message">[This property is supported for compatibility but it's recommended to use the FSRM WMI
    ///Classes to manage FSRM. Please see the MSFT_FSRMFileManagementJob class.] The error message from the last time
    ///the job was run. This property is read-only.
    HRESULT get_LastError(BSTR* lastError);
    ///<p class="CCE_Message">[This property is supported for compatibility but it's recommended to use the FSRM WMI
    ///Classes to manage FSRM. Please see the MSFT_FSRMFileManagementJob class.] The local directory path where the
    ///reports were stored the last time the job ran. This property is read-only.
    HRESULT get_LastReportPathWithoutExtension(BSTR* path);
    ///<p class="CCE_Message">[This property is supported for compatibility but it's recommended to use the FSRM WMI
    ///Classes to manage FSRM. Please see the MSFT_FSRMFileManagementJob class.] The last time the file management job
    ///was run. This property is read-only.
    HRESULT get_LastRun(double* lastRun);
    ///<p class="CCE_Message">[This property is supported for compatibility but it's recommended to use the FSRM WMI
    ///Classes to manage FSRM. Please see the MSFT_FSRMFileManagementJob class.] A condition property: wildcard filter
    ///for names. This property is read/write.
    HRESULT get_FileNamePattern(BSTR* fileNamePattern);
    ///<p class="CCE_Message">[This property is supported for compatibility but it's recommended to use the FSRM WMI
    ///Classes to manage FSRM. Please see the MSFT_FSRMFileManagementJob class.] A condition property: wildcard filter
    ///for names. This property is read/write.
    HRESULT put_FileNamePattern(BSTR fileNamePattern);
    ///<p class="CCE_Message">[This method is supported for compatibility but it's recommended to use the FSRM WMI
    ///Classes to manage FSRM. Please see the MSFT_FSRMFileManagementJob class.] Runs the job.
    ///Params:
    ///    context = Specifies to which subdirectory the reports or logging are written, if enabled. For possible values, see the
    ///              FsrmReportGenerationContext enumeration.
    ///Returns:
    ///    The method returns the following return values.
    ///    
    HRESULT Run(FsrmReportGenerationContext context);
    ///<p class="CCE_Message">[This property is supported for compatibility but it's recommended to use the FSRM WMI
    ///Classes to manage FSRM. Please see the MSFT_FSRMFileManagementJob class.] Waits for the specified period of time
    ///or until the job has finished running.
    ///Params:
    ///    waitSeconds = The number of seconds to wait for the job to complete. The method returns when the period expires or the job
    ///                  complete. To wait indefinitely, set the value to –1.
    ///    completed = Is <b>VARIANT_TRUE</b> if the job completed; otherwise, <b>VARIANT_FALSE</b>.
    ///Returns:
    ///    The method returns the following return values.
    ///    
    HRESULT WaitForCompletion(int waitSeconds, short* completed);
    ///<p class="CCE_Message">[This method is supported for compatibility but it's recommended to use the FSRM WMI
    ///Classes to manage FSRM. Please see the MSFT_FSRMFileManagementJob class.] Cancels the job if it is running.
    ///Returns:
    ///    The method returns the following return values.
    ///    
    HRESULT Cancel();
    ///<p class="CCE_Message">[This method is supported for compatibility but it's recommended to use the FSRM WMI
    ///Classes to manage FSRM. Please see the MSFT_FSRMFMJNotification::CreateFMJNotification method.] Adds a new
    ///notification value (period) to the file management job's list of notifications.
    ///Params:
    ///    days = A unique notification value to add. The value cannot be less than zero.
    ///Returns:
    ///    The method returns the following return values.
    ///    
    HRESULT AddNotification(int days);
    ///<p class="CCE_Message">[This method is supported for compatibility but it's recommended to use the FSRM WMI
    ///Classes to manage FSRM. Please see the MSFT_FSRMFileManagementJob class.] Deletes a notification value from the
    ///file management job's list of notifications.
    ///Params:
    ///    days = The notification value to delete.
    ///Returns:
    ///    The method returns the following return values.
    ///    
    HRESULT DeleteNotification(int days);
    ///<p class="CCE_Message">[This method is supported for compatibility but it's recommended to use the FSRM WMI
    ///Classes to manage FSRM. Please see the MSFT_FSRMFileManagementJob class.] Change a notification value in the file
    ///management job's list of notifications.
    ///Params:
    ///    days = The notification value to change.
    ///    newDays = The new notification value. The value must be unique and cannot be less than zero.
    ///Returns:
    ///    The method returns the following return values.
    ///    
    HRESULT ModifyNotification(int days, int newDays);
    ///<p class="CCE_Message">[This method is supported for compatibility but it's recommended to use the FSRM WMI
    ///Classes to manage FSRM. Please see the MSFT_FSRMFileManagementJob class.] Creates a notification action and
    ///associates it with the notification value.
    ///Params:
    ///    days = The notification value to associate with the action.
    ///    actionType = The action to perform when the notification period is reached, enumerated by the FsrmActionType enumeration.
    ///                 <div class="alert"><b>Note</b> The <b>FsrmActionType_Report</b> type is not valid for this method.</div>
    ///                 <div> </div>
    ///    action = An IFsrmAction interface of the newly created action. Query the interface for the action interface that you
    ///             specified in the <i>actionType</i> parameter. For example, if the action type is
    ///             <b>FsrmActionType_Command</b>, query the interface for the IFsrmActionCommand interface.
    ///Returns:
    ///    The method returns the following return values.
    ///    
    HRESULT CreateNotificationAction(int days, FsrmActionType actionType, IFsrmAction* action);
    ///<p class="CCE_Message">[This method is supported for compatibility but it's recommended to use the FSRM WMI
    ///Classes to manage FSRM. Please see the MSFT_FSRMFileManagementJob class.] Enumerates the actions associated with
    ///a notification value.
    ///Params:
    ///    days = The notification value that contains the actions that you want to enumerate.
    ///    actions = An IFsrmCollection interface that contains a collection of actions. The variant type of each item in the
    ///              collection is <b>VT_DISPATCH</b>. Query the <b>pdispVal</b> member of the variant to get an IFsrmAction
    ///              interface. You can use the IFsrmAction::ActionType property to determine the actual action interface to
    ///              query.
    ///Returns:
    ///    The method returns the following return values.
    ///    
    HRESULT EnumNotificationActions(int days, IFsrmCollection* actions);
    ///<p class="CCE_Message">[This method is supported for compatibility but it's recommended to use the FSRM WMI
    ///Classes to manage FSRM. Please see the MSFT_FSRMFileManagementJob class.] Creates a new property condition and
    ///adds it to the collection of property conditions.
    ///Params:
    ///    name = The name of the property definition that the condition applies to. To enumerate the defined property
    ///           definitions, call the IFsrmClassificationManager::EnumPropertyDefinitions method.
    ///    propertyCondition = An IFsrmPropertyCondition interface that you use to define the newly created property condition.
    ///Returns:
    ///    The method returns the following return values.
    ///    
    HRESULT CreatePropertyCondition(BSTR name, IFsrmPropertyCondition* propertyCondition);
    ///<p class="CCE_Message">[This method is supported for compatibility but it's recommended to use the FSRM WMI
    ///Classes to manage FSRM. Please see the MSFT_FSRMFileManagementJob class.] Creates a custom action object.
    ///Params:
    ///    customAction = An IFsrmActionCommand interface that you can use to specify a custom action to perform if the job's property
    ///                   conditions are met.
    ///Returns:
    ///    The method returns the following return values. Implementers should return an <b>HRESULT</b> error code for
    ///    any other errors.
    ///    
    HRESULT CreateCustomAction(IFsrmActionCommand* customAction);
}

///Defines a property condition that the file management job uses to determine if the file is expired. To create this
///interface, call the IFsrmFileManagementJob::CreatePropertyCondition method. The
///IFsrmFileManagementJob.PropertyConditions property contains a collection of these interfaces.
@GUID("326AF66F-2AC0-4F68-BF8C-4759F054FA29")
interface IFsrmPropertyCondition : IDispatch
{
    ///The name of the classification property whose value you want to compare to the property condition's value. This
    ///property is read/write.
    HRESULT get_Name(BSTR* name);
    ///The name of the classification property whose value you want to compare to the property condition's value. This
    ///property is read/write.
    HRESULT put_Name(BSTR name);
    ///The comparison operator used to determine whether the property condition is met. This property is read/write.
    HRESULT get_Type(FsrmPropertyConditionType* type);
    ///The comparison operator used to determine whether the property condition is met. This property is read/write.
    HRESULT put_Type(FsrmPropertyConditionType type);
    ///The property condition's value. This property is read/write.
    HRESULT get_Value(BSTR* value);
    ///The property condition's value. This property is read/write.
    HRESULT put_Value(BSTR value);
    ///Removes this property condition from the collection of property conditions specified for the file management job.
    ///Returns:
    ///    The method returns the following return values.
    ///    
    HRESULT Delete();
}

@GUID("70684FFC-691A-4A1A-B922-97752E138CC1")
interface IFsrmFileCondition : IDispatch
{
    HRESULT get_Type(FsrmFileConditionType* pVal);
    HRESULT Delete();
}

///<p class="CCE_Message">[This interface is supported for compatibility but it's recommended to use the FSRM WMI
///Classes to manage FSRM. Please see the MSFT_FSRMFMJCondition class.] Defines a file condition property.
@GUID("81926775-B981-4479-988F-DA171D627360")
interface IFsrmFileConditionProperty : IFsrmFileCondition
{
    ///<p class="CCE_Message">[This property is supported for compatibility but it's recommended to use the FSRM WMI
    ///Classes to manage FSRM. Please see the MSFT_FSRMFMJCondition class.] Specifies the name of the file condition
    ///property. This property is read/write.
    HRESULT get_PropertyName(BSTR* pVal);
    ///<p class="CCE_Message">[This property is supported for compatibility but it's recommended to use the FSRM WMI
    ///Classes to manage FSRM. Please see the MSFT_FSRMFMJCondition class.] Specifies the name of the file condition
    ///property. This property is read/write.
    HRESULT put_PropertyName(BSTR newVal);
    ///<p class="CCE_Message">[This property is supported for compatibility but it's recommended to use the FSRM WMI
    ///Classes to manage FSRM. Please see the MSFT_FSRMFMJCondition class.] Specifies the predefined file property, as
    ///enumerated by the FsrmFileSystemPropertyId enumeration. This property is read/write.
    HRESULT get_PropertyId(FsrmFileSystemPropertyId* pVal);
    ///<p class="CCE_Message">[This property is supported for compatibility but it's recommended to use the FSRM WMI
    ///Classes to manage FSRM. Please see the MSFT_FSRMFMJCondition class.] Specifies the predefined file property, as
    ///enumerated by the FsrmFileSystemPropertyId enumeration. This property is read/write.
    HRESULT put_PropertyId(FsrmFileSystemPropertyId newVal);
    ///<p class="CCE_Message">[This property is supported for compatibility but it's recommended to use the FSRM WMI
    ///Classes to manage FSRM. Please see the MSFT_FSRMFMJCondition class.] Specifies the comparison operator, as
    ///enumerated by the FsrmPropertyConditionType enumeration. This property is read/write.
    HRESULT get_Operator(FsrmPropertyConditionType* pVal);
    ///<p class="CCE_Message">[This property is supported for compatibility but it's recommended to use the FSRM WMI
    ///Classes to manage FSRM. Please see the MSFT_FSRMFMJCondition class.] Specifies the comparison operator, as
    ///enumerated by the FsrmPropertyConditionType enumeration. This property is read/write.
    HRESULT put_Operator(FsrmPropertyConditionType newVal);
    ///<p class="CCE_Message">[This property is supported for compatibility but it's recommended to use the FSRM WMI
    ///Classes to manage FSRM. Please see the MSFT_FSRMFMJCondition class.] Specifies the type of the file condition
    ///property value, as enumerated by the FsrmPropertyValueType enumeration. This property is read/write.
    HRESULT get_ValueType(FsrmPropertyValueType* pVal);
    ///<p class="CCE_Message">[This property is supported for compatibility but it's recommended to use the FSRM WMI
    ///Classes to manage FSRM. Please see the MSFT_FSRMFMJCondition class.] Specifies the type of the file condition
    ///property value, as enumerated by the FsrmPropertyValueType enumeration. This property is read/write.
    HRESULT put_ValueType(FsrmPropertyValueType newVal);
    ///<p class="CCE_Message">[This property is supported for compatibility but it's recommended to use the FSRM WMI
    ///Classes to manage FSRM. Please see the MSFT_FSRMFMJCondition class.] Specifies the file condition property value.
    ///This property is read/write.
    HRESULT get_Value(VARIANT* pVal);
    ///<p class="CCE_Message">[This property is supported for compatibility but it's recommended to use the FSRM WMI
    ///Classes to manage FSRM. Please see the MSFT_FSRMFMJCondition class.] Specifies the file condition property value.
    ///This property is read/write.
    HRESULT put_Value(VARIANT newVal);
}

///Defines a property that you want to use to classify files. To create this interface, call the
///IFsrmClassificationManager::CreatePropertyDefinition method. The following methods return this interface: <ul> <li>
///IFsrmClassificationManager::EnumPropertyDefinitions </li> <li> IFsrmClassificationManager::GetPropertyDefinition
///</li> </ul>
@GUID("EDE0150F-E9A3-419C-877C-01FE5D24C5D3")
interface IFsrmPropertyDefinition : IFsrmObject
{
    ///The name of the property. This property is read/write.
    HRESULT get_Name(BSTR* name);
    ///The name of the property. This property is read/write.
    HRESULT put_Name(BSTR name);
    ///The type of data that the property contains. This property is read/write.
    HRESULT get_Type(FsrmPropertyDefinitionType* type);
    ///The type of data that the property contains. This property is read/write.
    HRESULT put_Type(FsrmPropertyDefinitionType type);
    ///The possible values to which the property can be set. This property is read/write.
    HRESULT get_PossibleValues(SAFEARRAY** possibleValues);
    ///The possible values to which the property can be set. This property is read/write.
    HRESULT put_PossibleValues(SAFEARRAY* possibleValues);
    ///Descriptions for each of the possible values specified in the PossibleValues property. This property is
    ///read/write.
    HRESULT get_ValueDescriptions(SAFEARRAY** valueDescriptions);
    ///Descriptions for each of the possible values specified in the PossibleValues property. This property is
    ///read/write.
    HRESULT put_ValueDescriptions(SAFEARRAY* valueDescriptions);
    ///The parameters for the property definition. This property is read/write.
    HRESULT get_Parameters(SAFEARRAY** parameters);
    ///The parameters for the property definition. This property is read/write.
    HRESULT put_Parameters(SAFEARRAY* parameters);
}

///<p class="CCE_Message">[This interface is supported for compatibility but it's recommended to use the FSRM WMI
///Classes to manage FSRM. Please see the MSFT_FSRMClassificationPropertyDefinition class.] Defines a property that you
///want to use to classify files.
@GUID("47782152-D16C-4229-B4E1-0DDFE308B9F6")
interface IFsrmPropertyDefinition2 : IFsrmPropertyDefinition
{
    ///<p class="CCE_Message">[This property is supported for compatibility but it's recommended to use the FSRM WMI
    ///Classes to manage FSRM. Please see the MSFT_FSRMClassificationPropertyDefinition class.] This property contains
    ///the flags for the property definition as enumerated by the FsrmPropertyDefinitionFlags enumeration. This property
    ///is read-only.
    HRESULT get_PropertyDefinitionFlags(int* propertyDefinitionFlags);
    ///<p class="CCE_Message">[This property is supported for compatibility but it's recommended to use the FSRM WMI
    ///Classes to manage FSRM. Please see the MSFT_FSRMClassificationPropertyDefinition class.] This property is the
    ///display name of the property definition. This property is read/write.
    HRESULT get_DisplayName(BSTR* name);
    ///<p class="CCE_Message">[This property is supported for compatibility but it's recommended to use the FSRM WMI
    ///Classes to manage FSRM. Please see the MSFT_FSRMClassificationPropertyDefinition class.] This property is the
    ///display name of the property definition. This property is read/write.
    HRESULT put_DisplayName(BSTR name);
    ///<p class="CCE_Message">[This property is supported for compatibility but it's recommended to use the FSRM WMI
    ///Classes to manage FSRM. Please see the MSFT_FSRMClassificationPropertyDefinition class.] This property contains
    ///flags with values from the FsrmPropertyDefinitionAppliesTo enumeration that indicate what a FSRM property
    ///definition can be applied to. This property is read-only.
    HRESULT get_AppliesTo(int* appliesTo);
    ///<p class="CCE_Message">[This property is supported for compatibility but it's recommended to use the FSRM WMI
    ///Classes to manage FSRM. Please see the MSFT_FSRMClassificationPropertyDefinition class.] This property contains
    ///the possible value definitions of the property definition. This property is read-only.
    HRESULT get_ValueDefinitions(IFsrmCollection* valueDefinitions);
}

///<p class="CCE_Message">[This interface is supported for compatibility but it's recommended to use the FSRM WMI
///Classes to manage FSRM. Please see the MSFT_FSRMMgmtPropertyValue class.] Contains properties that describe a
///classification property definition value.
@GUID("E946D148-BD67-4178-8E22-1C44925ED710")
interface IFsrmPropertyDefinitionValue : IDispatch
{
    ///<p class="CCE_Message">[This interface is supported for compatibility but it's recommended to use the FSRM WMI
    ///Classes to manage FSRM. Please see the MSFT_FSRMMgmtPropertyValue class.] Name of the classification property
    ///definition value. This property is read-only.
    HRESULT get_Name(BSTR* name);
    ///<p class="CCE_Message">[This interface is supported for compatibility but it's recommended to use the FSRM WMI
    ///Classes to manage FSRM. Please see the MSFT_FSRMMgmtPropertyValue class.] Display name of the classification
    ///property definition value. This property is read-only.
    HRESULT get_DisplayName(BSTR* displayName);
    ///<p class="CCE_Message">[This interface is supported for compatibility but it's recommended to use the FSRM WMI
    ///Classes to manage FSRM. Please see the MSFT_FSRMMgmtPropertyValue class.] Description of the classification
    ///property definition value. This property is read-only.
    HRESULT get_Description(BSTR* description);
    ///<p class="CCE_Message">[This interface is supported for compatibility but it's recommended to use the FSRM WMI
    ///Classes to manage FSRM. Please see the MSFT_FSRMMgmtPropertyValue class.] Unique ID of the classification
    ///property definition value. This property is read-only.
    HRESULT get_UniqueID(BSTR* uniqueID);
}

///Defines an instance of a property.
@GUID("4A73FEE4-4102-4FCC-9FFB-38614F9EE768")
interface IFsrmProperty : IDispatch
{
    ///The name of the property. This property is read-only.
    HRESULT get_Name(BSTR* name);
    ///The value of the property. This property is read-only.
    HRESULT get_Value(BSTR* value);
    ///The modules and rules that have set the value. This property is read-only.
    HRESULT get_Sources(SAFEARRAY** sources);
    ///Flag values that provides additional information about a property. This property is read-only.
    HRESULT get_PropertyFlags(int* flags);
}

///Defines a rule. To create a rule, call the IFsrmClassificationManager::CreateRule method. The following methods
///return this interface: <ul> <li> IFsrmClassificationManager::EnumRules </li> <li> IFsrmClassificationManager::GetRule
///</li> </ul>This is the base class for rule interfaces. Query this interface to get the interface for the rule type
///specified in the RuleType property. For example, if <b>RuleType</b> is <b>FsrmRuleType_Classification</b>, query this
///interface for the IFsrmClassificationRule interface.
@GUID("CB0DF960-16F5-4495-9079-3F9360D831DF")
interface IFsrmRule : IFsrmObject
{
    ///The name of the rule. This property is read/write.
    HRESULT get_Name(BSTR* name);
    ///The name of the rule. This property is read/write.
    HRESULT put_Name(BSTR name);
    ///The type of the rule. This property is read-only.
    HRESULT get_RuleType(FsrmRuleType* ruleType);
    ///The name of the module definition that you want to run this rule. This property is read/write.
    HRESULT get_ModuleDefinitionName(BSTR* moduleDefinitionName);
    ///The name of the module definition that you want to run this rule. This property is read/write.
    HRESULT put_ModuleDefinitionName(BSTR moduleDefinitionName);
    ///An array of directory paths that the rule is applied to when classification is run. This property is read/write.
    HRESULT get_NamespaceRoots(SAFEARRAY** namespaceRoots);
    ///An array of directory paths that the rule is applied to when classification is run. This property is read/write.
    HRESULT put_NamespaceRoots(SAFEARRAY* namespaceRoots);
    ///The flags that define the state of the rule. This property is read/write.
    HRESULT get_RuleFlags(int* ruleFlags);
    ///The flags that define the state of the rule. This property is read/write.
    HRESULT put_RuleFlags(int ruleFlags);
    ///The parameters that are passed to the classifier. This property is read/write.
    HRESULT get_Parameters(SAFEARRAY** parameters);
    ///The parameters that are passed to the classifier. This property is read/write.
    HRESULT put_Parameters(SAFEARRAY* parameters);
    ///The date for the last time the rule was modified. This property is read-only.
    HRESULT get_LastModified(VARIANT* lastModified);
}

///<p class="CCE_Message">[This interface is supported for compatibility but it's recommended to use the FSRM WMI
///Classes to manage FSRM. Please see the MSFT_FSRMClassificationRule class.] Defines a classification rule. The rule
///defines the paths to which the rule applies, the classifier module to run on files in those paths, and the property
///and property value used to classify each file. To create a classification rule, call the
///IFsrmClassificationManager::CreateRule method. The following methods can return this interface: <ul> <li>
///IFsrmClassificationManager::EnumRules </li> <li> IFsrmClassificationManager::GetRule </li> </ul>
@GUID("AFC052C2-5315-45AB-841B-C6DB0E120148")
interface IFsrmClassificationRule : IFsrmRule
{
    ///<p class="CCE_Message">[This property is supported for compatibility but it's recommended to use the FSRM WMI
    ///Classes to manage FSRM. Please see the MSFT_FSRMClassificationRule class.] Determines how to apply the rule to
    ///the file. This property is read/write.
    HRESULT get_ExecutionOption(FsrmExecutionOption* executionOption);
    ///<p class="CCE_Message">[This property is supported for compatibility but it's recommended to use the FSRM WMI
    ///Classes to manage FSRM. Please see the MSFT_FSRMClassificationRule class.] Determines how to apply the rule to
    ///the file. This property is read/write.
    HRESULT put_ExecutionOption(FsrmExecutionOption executionOption);
    ///<p class="CCE_Message">[This property is supported for compatibility but it's recommended to use the FSRM WMI
    ///Classes to manage FSRM. Please see the MSFT_FSRMClassificationRule class.] The name of the property that this
    ///rule affects. This property is read/write.
    HRESULT get_PropertyAffected(BSTR* property);
    ///<p class="CCE_Message">[This property is supported for compatibility but it's recommended to use the FSRM WMI
    ///Classes to manage FSRM. Please see the MSFT_FSRMClassificationRule class.] The name of the property that this
    ///rule affects. This property is read/write.
    HRESULT put_PropertyAffected(BSTR property);
    ///<p class="CCE_Message">[This property is supported for compatibility but it's recommended to use the FSRM WMI
    ///Classes to manage FSRM. Please see the MSFT_FSRMClassificationRule class.] The value that this rule will set the
    ///property to. This property is read/write.
    HRESULT get_Value(BSTR* value);
    ///<p class="CCE_Message">[This property is supported for compatibility but it's recommended to use the FSRM WMI
    ///Classes to manage FSRM. Please see the MSFT_FSRMClassificationRule class.] The value that this rule will set the
    ///property to. This property is read/write.
    HRESULT put_Value(BSTR value);
}

///Defines a module that is used to classify files or store and retrieve properties from files. To create a module
///definition, call the IFsrmClassificationManager::CreateModuleDefinition method. The following methods return this
///interface: <ul> <li> IFsrmClassificationManager::EnumModuleDefinitions </li> <li>
///IFsrmClassificationManager::GetModuleDefinition </li> </ul>This is the base class for module definition interfaces.
///Query this interface to get the interface for the module type specified in the ModuleType property. For example, if
///<b>ModuleType</b> is <b>FsrmPipelineModuleType_Classifier</b>, query this interface for the
///IFsrmClassifierModuleDefinition interface.
@GUID("515C1277-2C81-440E-8FCF-367921ED4F59")
interface IFsrmPipelineModuleDefinition : IFsrmObject
{
    ///A string representation specifying the COM class identifier for the class that implements the module defined by
    ///this module definition. This property is read/write.
    HRESULT get_ModuleClsid(BSTR* moduleClsid);
    ///A string representation specifying the COM class identifier for the class that implements the module defined by
    ///this module definition. This property is read/write.
    HRESULT put_ModuleClsid(BSTR moduleClsid);
    ///The name of the module definition. This property is read/write.
    HRESULT get_Name(BSTR* name);
    ///The name of the module definition. This property is read/write.
    HRESULT put_Name(BSTR name);
    ///The name of the company that created the classification or storage module. This property is read/write.
    HRESULT get_Company(BSTR* company);
    ///The name of the company that created the classification or storage module. This property is read/write.
    HRESULT put_Company(BSTR company);
    ///The version of the module definition. This property is read/write.
    HRESULT get_Version(BSTR* version_);
    ///The version of the module definition. This property is read/write.
    HRESULT put_Version(BSTR version_);
    ///The type of module. This property is read-only.
    HRESULT get_ModuleType(FsrmPipelineModuleType* moduleType);
    ///Determines whether the module is enabled. This property is read/write.
    HRESULT get_Enabled(short* enabled);
    ///Determines whether the module is enabled. This property is read/write.
    HRESULT put_Enabled(short enabled);
    ///Determines whether the module needs to read the contents of the file. This property is read/write.
    HRESULT get_NeedsFileContent(short* needsFileContent);
    ///Determines whether the module needs to read the contents of the file. This property is read/write.
    HRESULT put_NeedsFileContent(short needsFileContent);
    ///The account to use when running the module. This property is read/write.
    HRESULT get_Account(FsrmAccountType* retrievalAccount);
    ///The account to use when running the module. This property is read/write.
    HRESULT put_Account(FsrmAccountType retrievalAccount);
    ///The list of file extensions supported by this module. This property is read/write.
    HRESULT get_SupportedExtensions(SAFEARRAY** supportedExtensions);
    ///The list of file extensions supported by this module. This property is read/write.
    HRESULT put_SupportedExtensions(SAFEARRAY* supportedExtensions);
    ///The optional parameters to pass to the module. This property is read/write.
    HRESULT get_Parameters(SAFEARRAY** parameters);
    ///The optional parameters to pass to the module. This property is read/write.
    HRESULT put_Parameters(SAFEARRAY* parameters);
}

///Defines a classifier module. To create a classifier module definition, call the
///IFsrmClassificationManager::CreateModuleDefinition method. The following methods can return this interface: <ul> <li>
///IFsrmClassificationManager::EnumModuleDefinitions </li> <li> IFsrmClassificationManager::GetModuleDefinition </li>
///</ul>
@GUID("BB36EA26-6318-4B8C-8592-F72DD602E7A5")
interface IFsrmClassifierModuleDefinition : IFsrmPipelineModuleDefinition
{
    ///The list of property names that the classifier can affect. This property is read/write.
    HRESULT get_PropertiesAffected(SAFEARRAY** propertiesAffected);
    ///The list of property names that the classifier can affect. This property is read/write.
    HRESULT put_PropertiesAffected(SAFEARRAY* propertiesAffected);
    ///The list of property names that the classifier inspects. This property is read/write.
    HRESULT get_PropertiesUsed(SAFEARRAY** propertiesUsed);
    ///The list of property names that the classifier inspects. This property is read/write.
    HRESULT put_PropertiesUsed(SAFEARRAY* propertiesUsed);
    ///Determines whether a rule that uses the classifier needs to provide the value for the classification property.
    ///This property is read/write.
    HRESULT get_NeedsExplicitValue(short* needsExplicitValue);
    ///Determines whether a rule that uses the classifier needs to provide the value for the classification property.
    ///This property is read/write.
    HRESULT put_NeedsExplicitValue(short needsExplicitValue);
}

///Defines a local storage module that is used to read and write property values.<div class="alert"><b>Note</b> This
///interface supports local use only. Remote operations are not supported.</div> <div> </div> To create a storage module
///definition, call the IFsrmClassificationManager::CreateModuleDefinition method. The following methods can return this
///interface: <ul> <li> IFsrmClassificationManager::EnumModuleDefinitions </li> <li>
///IFsrmClassificationManager::GetModuleDefinition </li> </ul>
@GUID("15A81350-497D-4ABA-80E9-D4DBCC5521FE")
interface IFsrmStorageModuleDefinition : IFsrmPipelineModuleDefinition
{
    ///Flags that specify capabilities of the storage module. This property is read/write.
    HRESULT get_Capabilities(FsrmStorageModuleCaps* capabilities);
    ///Flags that specify capabilities of the storage module. This property is read/write.
    HRESULT put_Capabilities(FsrmStorageModuleCaps capabilities);
    ///The type of storage that the storage module uses. This property is read/write.
    HRESULT get_StorageType(FsrmStorageModuleType* storageType);
    ///The type of storage that the storage module uses. This property is read/write.
    HRESULT put_StorageType(FsrmStorageModuleType storageType);
    ///Determines whether the module updates the contents of the file. This property is read/write.
    HRESULT get_UpdatesFileContent(short* updatesFileContent);
    ///Determines whether the module updates the contents of the file. This property is read/write.
    HRESULT put_UpdatesFileContent(short updatesFileContent);
}

///<p class="CCE_Message">[This interface is supported for compatibility but it's recommended to use the FSRM WMI
///Classes to manage FSRM. Please see the MSFT_FSRMClassification class.] Manages file classification. Use this
///interface to define properties to use in classification, add classification rules for classifying files, define
///classification and storage modules, and enable classification reporting. To get this interface, call the
///CoCreateInstanceEx function. Use <b>CLSID_FsrmClassificationManager</b> as the class identifier and
///<code>__uuidof(IFsrmClassificationManager)</code> as the interface identifier.
@GUID("D2DC89DA-EE91-48A0-85D8-CC72A56F7D04")
interface IFsrmClassificationManager : IDispatch
{
    ///<p class="CCE_Message">[This property is supported for compatibility but it's recommended to use the FSRM WMI
    ///Classes to manage FSRM. Please see the MSFT_FSRMClassification class.] The list of formats in which to generate
    ///the classification reports. This property is read/write.
    HRESULT get_ClassificationReportFormats(SAFEARRAY** formats);
    ///<p class="CCE_Message">[This property is supported for compatibility but it's recommended to use the FSRM WMI
    ///Classes to manage FSRM. Please see the MSFT_FSRMClassification class.] The list of formats in which to generate
    ///the classification reports. This property is read/write.
    HRESULT put_ClassificationReportFormats(SAFEARRAY* formats);
    ///<p class="CCE_Message">[This property is supported for compatibility but it's recommended to use the FSRM WMI
    ///Classes to manage FSRM. Please see the MSFT_FSRMClassification class.] The types of logging to perform when
    ///running the classification rules. This property is read/write.
    HRESULT get_Logging(int* logging);
    ///<p class="CCE_Message">[This property is supported for compatibility but it's recommended to use the FSRM WMI
    ///Classes to manage FSRM. Please see the MSFT_FSRMClassification class.] The types of logging to perform when
    ///running the classification rules. This property is read/write.
    HRESULT put_Logging(int logging);
    ///<p class="CCE_Message">[This property is supported for compatibility but it's recommended to use the FSRM WMI
    ///Classes to manage FSRM. Please see the MSFT_FSRMClassification class.] The email address to which to send the
    ///classification reports, if any. This property is read/write.
    HRESULT get_ClassificationReportMailTo(BSTR* mailTo);
    ///<p class="CCE_Message">[This property is supported for compatibility but it's recommended to use the FSRM WMI
    ///Classes to manage FSRM. Please see the MSFT_FSRMClassification class.] The email address to which to send the
    ///classification reports, if any. This property is read/write.
    HRESULT put_ClassificationReportMailTo(BSTR mailTo);
    ///<p class="CCE_Message">[This property is supported for compatibility but it's recommended to use the FSRM WMI
    ///Classes to manage FSRM. Please see the MSFT_FSRMClassification class.] Determines whether classification
    ///reporting is enabled or not. This property is read/write.
    HRESULT get_ClassificationReportEnabled(short* reportEnabled);
    ///<p class="CCE_Message">[This property is supported for compatibility but it's recommended to use the FSRM WMI
    ///Classes to manage FSRM. Please see the MSFT_FSRMClassification class.] Determines whether classification
    ///reporting is enabled or not. This property is read/write.
    HRESULT put_ClassificationReportEnabled(short reportEnabled);
    ///<p class="CCE_Message">[This property is supported for compatibility but it's recommended to use the FSRM WMI
    ///Classes to manage FSRM. Please see the MSFT_FSRMClassification class.] The local directory path where the reports
    ///were stored the last time that classification ran. This property is read-only.
    HRESULT get_ClassificationLastReportPathWithoutExtension(BSTR* lastReportPath);
    ///<p class="CCE_Message">[This property is supported for compatibility but it's recommended to use the FSRM WMI
    ///Classes to manage FSRM. Please see the MSFT_FSRMClassification class.] The error message from the last time that
    ///classification was run. This property is read-only.
    HRESULT get_ClassificationLastError(BSTR* lastError);
    ///<p class="CCE_Message">[This property is supported for compatibility but it's recommended to use the FSRM WMI
    ///Classes to manage FSRM. Please see the MSFT_FSRMClassification class.] The running status of the classification.
    ///This property is read-only.
    HRESULT get_ClassificationRunningStatus(FsrmReportRunningStatus* runningStatus);
    ///<p class="CCE_Message">[This method is supported for compatibility but it's recommended to use the FSRM WMI
    ///Classes to manage FSRM. Please see the MSFT_FSRMClassification class.] Enumerates the property definitions.
    ///Params:
    ///    options = One or more options for enumerating the property definitions. For possible values, see the FsrmEnumOptions
    ///              enumeration.
    ///    propertyDefinitions = An IFsrmCollection interface that contains a collection of property definitions. Each item in the collection
    ///                          is a <b>VARIANT</b> of type <b>VT_DISPATCH</b>. Query the <b>pdispVal</b> member of the variant for the
    ///                          IFsrmPropertyDefinition interface. The collection contains only committed property definitions; the
    ///                          collection will not contain newly created property definitions that have not been committed.
    ///Returns:
    ///    The method returns the following return values.
    ///    
    HRESULT EnumPropertyDefinitions(FsrmEnumOptions options, IFsrmCollection* propertyDefinitions);
    ///<p class="CCE_Message">[This method is supported for compatibility but it's recommended to use the FSRM WMI
    ///Classes to manage FSRM. Please see the MSFT_FSRMClassification class.] Creates a property definition.
    ///Params:
    ///    propertyDefinition = An IFsrmPropertyDefinition interface to the new property definition. To save the property definition, call
    ///                         IFsrmPropertyDefinition::Commit method.
    ///Returns:
    ///    The method returns the following return values.
    ///    
    HRESULT CreatePropertyDefinition(IFsrmPropertyDefinition* propertyDefinition);
    ///<p class="CCE_Message">[This method is supported for compatibility but it's recommended to use the FSRM WMI
    ///Classes to manage FSRM. Please see the MSFT_FSRMClassification class.] Retrieves the specified property
    ///definition.
    ///Params:
    ///    propertyName = The name of the property definition to retrieve.
    ///    propertyDefinition = An IFsrmPropertyDefinition interface to the retrieved property definition.
    ///Returns:
    ///    The method returns the following return values.
    ///    
    HRESULT GetPropertyDefinition(BSTR propertyName, IFsrmPropertyDefinition* propertyDefinition);
    ///<p class="CCE_Message">[This method is supported for compatibility but it's recommended to use the FSRM WMI
    ///Classes to manage FSRM. Please see the MSFT_FSRMClassification class.] Enumerates the rules of the specified
    ///type.
    ///Params:
    ///    ruleType = The type of rules to enumerate. For possible values, see the FsrmRuleType enumeration. <div
    ///               class="alert"><b>Note</b> The <b>FsrmRuleType_Generic</b> type is not a valid type for this method.</div>
    ///               <div> </div>
    ///    options = One or more options for enumerating the property definitions. For possible values, see the FsrmEnumOptions
    ///              enumeration. <div class="alert"><b>Note</b> The <b>FsrmEnumOptions_Asynchronous</b> option is not supported
    ///              for this method.</div> <div> </div>
    ///    Rules = An IFsrmCollection interface that contains a collection of classification rules. Each item in the collection
    ///            is a <b>VARIANT</b> of type <b>VT_DISPATCH</b>. Query the <b>pdispVal</b> member of the variant for the
    ///            IFsrmRule interface. You can then use the IFsrmRule.RuleType property to determine the rule's type. Query the
    ///            <b>IFsrmRule</b> interface for the rule interface to use. For example, if <b>RuleType</b> is
    ///            <b>FsrmRuleType_Classification</b>, query the <b>IFsrmRule</b> interface for the IFsrmClassificationRule
    ///            interface. The collection contains only committed rules; the collection will not contain newly created rules
    ///            that have not been committed.
    ///Returns:
    ///    The method returns the following return values.
    ///    
    HRESULT EnumRules(FsrmRuleType ruleType, FsrmEnumOptions options, IFsrmCollection* Rules);
    ///<p class="CCE_Message">[This method is supported for compatibility but it's recommended to use the FSRM WMI
    ///Classes to manage FSRM. Please see the MSFT_FSRMClassification class.] Creates a rule of the specified type.
    ///Params:
    ///    ruleType = The type of rule to create, set this parameter to <b>FsrmRuleType_Classification</b>. For more information,
    ///               see FsrmRuleType.
    ///    Rule = An IFsrmRule interface to the new rule. Query the <b>IFsrmRule</b> interface to get the interface to get the
    ///           IFsrmClassificationRule interface. To save the rule, call IFsrmRule::Commit method.
    ///Returns:
    ///    The method returns the following return values.
    ///    
    HRESULT CreateRule(FsrmRuleType ruleType, IFsrmRule* Rule);
    ///<p class="CCE_Message">[This method is supported for compatibility but it's recommended to use the FSRM WMI
    ///Classes to manage FSRM. Please see the MSFT_FSRMClassification class.] Retrieves the specified rule.
    ///Params:
    ///    ruleName = The name of the rule to retrieve. Must not exceed 100 characters in length.
    ///    ruleType = The type of the rule to retrieve. For possible types, see the FsrmRuleType enumeration. <div
    ///               class="alert"><b>Note</b> The <b>FsrmRuleType_Generic</b> type is not supported by this method.</div> <div>
    ///               </div>
    ///    Rule = An IFsrmRule interface to the retrieved rule. Query the <b>IFsrmRule</b> interface to get the interface for
    ///           the specified type. For example, if <i>ruleType</i> is <b>FsrmRuleType_Classification</b>, query the
    ///           <b>IFsrmRule</b> interface for the IFsrmClassificationRule interface.
    ///Returns:
    ///    The method returns the following return values.
    ///    
    HRESULT GetRule(BSTR ruleName, FsrmRuleType ruleType, IFsrmRule* Rule);
    ///<p class="CCE_Message">[This method is supported for compatibility but it's recommended to use the FSRM WMI
    ///Classes to manage FSRM. Please see the MSFT_FSRMClassification class.] Enumerates the module definitions of the
    ///specified type.
    ///Params:
    ///    moduleType = Type of module to enumerate. For possible values, see the FsrmPipelineModuleType enumeration.
    ///    options = One or more options for enumerating the modules. For possible values, see the FsrmEnumOptions enumeration.
    ///              <div class="alert"><b>Note</b> The <b>FsrmEnumOptions_Asynchronous</b> option is not supported by this
    ///              method.</div> <div> </div>
    ///    moduleDefinitions = An IFsrmCollection interface that contains a collection of module definitions. Each item in the collection is
    ///                        a <b>VARIANT</b> of type <b>VT_DISPATCH</b>. Query the <b>pdispVal</b> member of the variant for the
    ///                        IFsrmPipelineModuleDefinition interface. You can then use the IFsrmPipelineModuleDefinition.ModuleType
    ///                        property to determine the module's type. Query the <b>IFsrmPipelineModuleDefinition</b> interface for the
    ///                        module interface to use. For example, if <b>ModuleType</b> is <b>FsrmPipelineModuleType_Classifier</b>, query
    ///                        the <b>IFsrmPipelineModuleDefinition</b> interface for the IFsrmClassifierModuleDefinition interface. The
    ///                        collection contains only committed module definitions; the collection will not contain newly created module
    ///                        definitions that have not been committed.
    ///Returns:
    ///    The method returns the following return values.
    ///    
    HRESULT EnumModuleDefinitions(FsrmPipelineModuleType moduleType, FsrmEnumOptions options, 
                                  IFsrmCollection* moduleDefinitions);
    ///<p class="CCE_Message">[This method is supported for compatibility but it's recommended to use the FSRM WMI
    ///Classes to manage FSRM. Please see the MSFT_FSRMClassification class.] Creates a module definition of the
    ///specified type.
    ///Params:
    ///    moduleType = The type of module to create (for example, a classifier or storage module). For possible types, see the
    ///                 FsrmPipelineModuleType enumeration.
    ///    moduleDefinition = An IFsrmPipelineModuleDefinition interface to the new module definition. Query the
    ///                       <b>IFsrmPipelineModuleDefinition</b> interface to get the interface for the specified module. For example, if
    ///                       <i>moduleType</i> is <b>FsrmPipelineModuleType_Classifier</b>, query the <b>IFsrmPipelineModuleDefinition</b>
    ///                       interface for the IFsrmClassifierModuleDefinition interface. To save the module definition, call
    ///                       IFsrmPipelineModuleDefinition::Commit method.
    ///Returns:
    ///    The method returns the following return values.
    ///    
    HRESULT CreateModuleDefinition(FsrmPipelineModuleType moduleType, 
                                   IFsrmPipelineModuleDefinition* moduleDefinition);
    ///<p class="CCE_Message">[This method is supported for compatibility but it's recommended to use the FSRM WMI
    ///Classes to manage FSRM. Please see the MSFT_FSRMClassification class.] Retrieves the specified module definition.
    ///Params:
    ///    moduleName = The name of the module to retrieve. Must not exceed 100 characters in length.
    ///    moduleType = The type of the module to retrieve. For possible types, see the FsrmPipelineModuleType enumeration.
    ///    moduleDefinition = An IFsrmPipelineModuleDefinition interface to the retrieved module definition. Query the
    ///                       <b>IFsrmPipelineModuleDefinition</b> interface to get the interface for the specified module. For example, if
    ///                       <i>moduleType</i> is <b>FsrmPipelineModuleType_Classifier</b>, query the <b>IFsrmPipelineModuleDefinition</b>
    ///                       interface for the IFsrmClassifierModuleDefinition interface.
    ///Returns:
    ///    The method returns the following return values.
    ///    
    HRESULT GetModuleDefinition(BSTR moduleName, FsrmPipelineModuleType moduleType, 
                                IFsrmPipelineModuleDefinition* moduleDefinition);
    ///<p class="CCE_Message">[This method is supported for compatibility but it's recommended to use the FSRM WMI
    ///Classes to manage FSRM. Please see the MSFT_FSRMClassification class.] Runs classification rules and generates
    ///the classification report.
    ///Params:
    ///    context = Specifies the report subdirectory to which the classification report is written. For possible values, see the
    ///              FsrmReportGenerationContext enumeration. To set the report directory, call the
    ///              IFsrmReportManager::SetOutputDirectory method.
    ///    reserved = Must be <b>NULL</b>.
    ///Returns:
    ///    The method returns the following return values.
    ///    
    HRESULT RunClassification(FsrmReportGenerationContext context, BSTR reserved);
    ///<p class="CCE_Message">[This method is supported for compatibility but it's recommended to use the FSRM WMI
    ///Classes to manage FSRM. Please see the MSFT_FSRMClassification class.] Waits for the specified period of time or
    ///until classification has finished running.
    ///Params:
    ///    waitSeconds = The number of seconds to wait for classification and the reports to complete. The method returns when the
    ///                  period expires or classification and the reports complete. To wait indefinitely, set the value to –1. The
    ///                  value must be in the range from –1 through 2,147,483.
    ///    completed = Is <b>VARIANT_TRUE</b> if the reports completed; otherwise, <b>VARIANT_FALSE</b>.
    ///Returns:
    ///    The method returns the following return values.
    ///    
    HRESULT WaitForClassificationCompletion(int waitSeconds, short* completed);
    ///<p class="CCE_Message">[This method is supported for compatibility but it's recommended to use the FSRM WMI
    ///Classes to manage FSRM. Please see the MSFT_FSRMClassification class.] Cancels classification if it is running.
    ///Returns:
    ///    The method returns the following return values.
    ///    
    HRESULT CancelClassification();
    ///Enumerates the properties of the specified file.
    ///Params:
    ///    filePath = The file that contains the properties that you want to enumerate. You must specify an absolute path to the
    ///               file. You cannot specify a file share.
    ///    options = The option to use for enumerating the file's properties. For possible values, see the
    ///              FsrmGetFilePropertyOptions enumeration.
    ///    fileProperties = An IFsrmCollection interface that contains a collection of file properties. Each item in the collection is a
    ///                     <b>VARIANT</b> of type <b>VT_DISPATCH</b>. Query the <b>pdispVal</b> member of the variant for the
    ///                     IFsrmProperty interface.
    ///Returns:
    ///    The method returns the following return values.
    ///    
    HRESULT EnumFileProperties(BSTR filePath, FsrmGetFilePropertyOptions options, IFsrmCollection* fileProperties);
    ///Retrieves the specified property from the file or folder. <b>Windows Server 2008 R2: </b>Only files are supported
    ///until Windows Server 2012.
    ///Params:
    ///    filePath = The file that contains the property that you want to retrieve. You must specify an absolute path to the file.
    ///               You cannot specify a file share.
    ///    propertyName = The name of the property to retrieve. Must not exceed 100 characters in length.
    ///    options = The option to use for retrieving the file's property. For possible values, see the FsrmGetFilePropertyOptions
    ///              enumeration.
    ///    property = An IFsrmProperty interface to the retrieved property.
    ///Returns:
    ///    The method returns the following return values.
    ///    
    HRESULT GetFileProperty(BSTR filePath, BSTR propertyName, FsrmGetFilePropertyOptions options, 
                            IFsrmProperty* property);
    ///Sets the value of the specified property in the file or folder. <b>Windows Server 2008 R2: </b>Only files are
    ///supported until Windows Server 2012.
    ///Params:
    ///    filePath = The file that contains the property that you want to set. You must specify an absolute path to the file. You
    ///               cannot specify a file share.
    ///    propertyName = The name of the property whose value you want to set.
    ///    propertyValue = The value to set the specified property to.
    ///Returns:
    ///    The method returns the following return values.
    ///    
    HRESULT SetFileProperty(BSTR filePath, BSTR propertyName, BSTR propertyValue);
    ///Attempts to remove the specified property from the file or folder. <b>Windows Server 2008 R2: </b>Only files are
    ///supported until Windows Server 2012.
    ///Params:
    ///    filePath = The file that contains the property that you want to remove. You must specify an absolute path to the file.
    ///               You cannot specify a file share.
    ///    property = The name of the property to remove from the file.
    ///Returns:
    ///    The method returns the following return values.
    ///    
    HRESULT ClearFileProperty(BSTR filePath, BSTR property);
}

///<p class="CCE_Message">[This interface is supported for compatibility but it's recommended to use the FSRM WMI
///Classes to manage FSRM. Please see the MSFT_FSRMClassification class.] Manages file classification. Use this
///interface to define properties to use in classification, add classification rules for classifying files, define
///classification and storage modules, and enable classification reporting. To get this interface, call the
///CoCreateInstanceEx function. Use <b>CLSID_FsrmClassificationManager</b> as the class identifier and
///<code>__uuidof(IFsrmClassificationManager2)</code> as the interface identifier or use the use the
///"Fsrm.FsrmClassificationManager" program identifier.
@GUID("0004C1C9-127E-4765-BA07-6A3147BCA112")
interface IFsrmClassificationManager2 : IFsrmClassificationManager
{
    ///This method is used to perform bulk enumeration, setting, and clearing of file properties.
    ///Params:
    ///    filePaths = A list of the file paths. The <b>SAFEARRAY</b> contains variants of type <b>VT_BSTR</b>. For each item in the
    ///                array, use the <b>bstrVal</b> member to access the property name.
    ///    propertyNames = A list of the property names. The <b>SAFEARRAY</b> contains variants of type <b>VT_BSTR</b>. For each item in
    ///                    the array, use the <b>bstrVal</b> member to access the property name.
    ///    propertyValues = A list of the property values.
    ///    options = Options for the operation as enumerated by the FsrmGetFilePropertyOptions enumeration. The default value is
    ///              <b>FsrmGetFilePropertyOptions_None</b>.
    ///Returns:
    ///    The method returns the following return values.
    ///    
    HRESULT ClassifyFiles(SAFEARRAY* filePaths, SAFEARRAY* propertyNames, SAFEARRAY* propertyValues, 
                          FsrmGetFilePropertyOptions options);
}

///Contains the classification properties for a file. FSRM passes this interface to your
///IFsrmPipelineModuleImplementation implementation. For more information, see the Remarks section.
@GUID("774589D1-D300-4F7A-9A24-F7B766800250")
interface IFsrmPropertyBag : IDispatch
{
    ///The name of the file that contains the properties in the bag. This property is read-only.
    HRESULT get_Name(BSTR* name);
    ///The relative path to the file. This property is read-only.
    HRESULT get_RelativePath(BSTR* path);
    ///The name of the volume on which the file exists. This property is read-only.
    HRESULT get_VolumeName(BSTR* volumeName);
    ///The relative path of the namespace root under which the file is being evaluated. This property is read-only.
    HRESULT get_RelativeNamespaceRoot(BSTR* relativeNamespaceRoot);
    ///The index that the scanner uses to refer to the volume on which the file exists. This property is read-only.
    HRESULT get_VolumeIndex(uint* volumeId);
    ///The NTFS file identifier of the file. This property is read-only.
    HRESULT get_FileId(VARIANT* fileId);
    ///The NTFS identifier of the file's parent directory. This property is read-only.
    HRESULT get_ParentDirectoryId(VARIANT* parentDirectoryId);
    ///The size of the file. This property is read-only.
    HRESULT get_Size(VARIANT* size);
    ///The allocation size of the file. This property is read-only.
    HRESULT get_SizeAllocated(VARIANT* sizeAllocated);
    ///The date and time that the file was created. This property is read-only.
    HRESULT get_CreationTime(VARIANT* creationTime);
    ///The date and time of when the file was last accessed. This property is read-only.
    HRESULT get_LastAccessTime(VARIANT* lastAccessTime);
    ///The date and time of when the file was last modified. This property is read-only.
    HRESULT get_LastModificationTime(VARIANT* lastModificationTime);
    ///The attributes of the file. This property is read-only.
    HRESULT get_Attributes(uint* attributes);
    ///The SID of the owner of the file. This property is read-only.
    HRESULT get_OwnerSid(BSTR* ownerSid);
    ///A list of the names of the properties that the bag contains. This property is read-only.
    HRESULT get_FilePropertyNames(SAFEARRAY** filePropertyNames);
    ///A list of the error messages that have been added to the bag. This property is read-only.
    HRESULT get_Messages(SAFEARRAY** messages);
    ///A set of flags that provide additional information about the property bag. This property is read-only.
    HRESULT get_PropertyBagFlags(uint* flags);
    ///Retrieves the specified property from the property bag.
    ///Params:
    ///    name = The name of the property to retrieve.
    ///    fileProperty = An IFsrmProperty interface to the retrieved property.
    ///Returns:
    ///    The method returns the following return values.
    ///    
    HRESULT GetFileProperty(BSTR name, IFsrmProperty* fileProperty);
    ///Sets the specified property in the property bag.
    ///Params:
    ///    name = The name of the property to set.
    ///    value = The value to set the property to.
    ///Returns:
    ///    The method returns the following return values.
    ///    
    HRESULT SetFileProperty(BSTR name, BSTR value);
    ///Adds an error message to the bag.
    ///Params:
    ///    message = The error message to add to the bag. The message is limited to 4096 characters (the message is truncated if
    ///              longer than 4096 characters).
    ///Returns:
    ///    The method returns the following return values.
    ///    
    HRESULT AddMessage(BSTR message);
    ///Retrieves a file stream interface that you can use to access the contents of the file.
    ///Params:
    ///    accessMode = One or more access modes. For possible values, see the FsrmFileStreamingMode enumeration.
    ///    interfaceType = The type of streaming interface to use. For possible interface types, see the FsrmFileStreamingInterfaceType
    ///                    enumeration.
    ///    pStreamInterface = A <b>VARIANT</b> that contains the streaming interface that you can use to access the contents of the file.
    ///                       The variant is of type <b>VT_DISPATCH</b>. Query the <b>dispval</b> member of the variant to get the
    ///                       specified streaming interface.
    ///Returns:
    ///    The method returns the following return values.
    ///    
    HRESULT GetFileStreamInterface(FsrmFileStreamingMode accessMode, FsrmFileStreamingInterfaceType interfaceType, 
                                   VARIANT* pStreamInterface);
}

///IFsrmPropertyBag2 Interface
@GUID("0E46BDBD-2402-4FED-9C30-9266E6EB2CC9")
interface IFsrmPropertyBag2 : IFsrmPropertyBag
{
    ///Gets the value of the specified field from the property bag.
    ///Params:
    ///    field = Type: <b>FsrmPropertyBagField</b> Indicates whether the volume name returned is the name of the volume being
    ///            accessed, which may be a snapshot, or the volume where the property bag lives.
    ///    value = Type: <b>VARIANT*</b> Returns the specified value.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetFieldValue(FsrmPropertyBagField field, VARIANT* value);
    HRESULT GetUntrustedInFileProperties(IFsrmCollection* props);
}

///Abstract interface for IFsrmClassifierModuleImplementation and IFsrmStorageModuleImplementation. Classifiers and
///storage modules should not implement this interface. For more information, see IFsrmClassifierModuleImplementation or
///IFsrmStorageModuleImplementation.
@GUID("B7907906-2B02-4CB5-84A9-FDF54613D6CD")
interface IFsrmPipelineModuleImplementation : IDispatch
{
    ///Initializes the pipeline module.
    ///Params:
    ///    moduleDefinition = Type: <b>IFsrmPipelineModuleDefinition*</b> An IFsrmPipelineModuleDefinition instance representing the
    ///                       pipeline module definition to use.
    ///    moduleConnector = Type: <b>IFsrmPipelineModuleConnector**</b> An IFsrmPipelineModuleConnector instance representing the
    ///                      pipeline module connector to use.
    ///Returns:
    ///    Type: <b>HRESULT</b> The method returns the following return values. Other values will result in the client
    ///    application receiving a <b>FSRM_E_UNEXPECTED</b><b>FSRM_E_MODULE_SESSION_INITIALIZATION</b> error. <b>Windows
    ///    Server 2008 R2: </b>The client application will receive a <b>FSRM_E_UNEXPECTED</b> error.
    ///    
    HRESULT OnLoad(IFsrmPipelineModuleDefinition moduleDefinition, IFsrmPipelineModuleConnector* moduleConnector);
    ///Notifies the module to perform any cleanup tasks.
    ///Returns:
    ///    The method returns the following return values.
    ///    
    HRESULT OnUnload();
}

///Classifier modules implement this interface. FSRM calls the module's implementation when it runs classification.
@GUID("4C968FC6-6EDB-4051-9C18-73B7291AE106")
interface IFsrmClassifierModuleImplementation : IFsrmPipelineModuleImplementation
{
    ///The last time the classifier's internal rules were modified as a 64-bit FILETIME value. This property is
    ///read-only.
    HRESULT get_LastModified(VARIANT* lastModified);
    ///Specifies the collection of rules and relevant property definitions the classifier should expect to process.
    ///Params:
    ///    rules = Type: <b>IFsrmCollection*</b> An IFsrmCollection instance representing a collection of rules that will be
    ///            used during the current classification session.
    ///    propertyDefinitions = Type: <b>IFsrmCollection*</b> An IFsrmCollection instance representing a collection of property definitions
    ///                          that are referenced by the specified collection of rules.
    ///Returns:
    ///    Type: <b>HRESULT</b> The method returns the following return values. Other values will result in the client
    ///    application receiving a <b>FSRM_E_MODULE_SESSION_INITIALIZATION</b> error. <b>Windows Server 2008 R2: </b>The
    ///    client application will receive a <b>FSRM_E_UNEXPECTED</b> error.
    ///    
    HRESULT UseRulesAndDefinitions(IFsrmCollection rules, IFsrmCollection propertyDefinitions);
    ///Instructs the classifier to prepare for processing a file with the specified property bag.
    ///Params:
    ///    propertyBag = The property bag that corresponds to the file to be processed.
    ///    arrayRuleIds = A <b>SAFEARRAY</b> of variants that contains one or more strings listing the identifiers of rules that will
    ///                   be processed. Each identifier corresponds to a rule object that is in the rule collection passed in by a
    ///                   previous call to the IFsrmClassifierModuleImplementation::UseRulesAndDefinitions method. The rule object can
    ///                   also be obtained by using this identifier in a call to the IFsrmCollection::GetById method on this
    ///                   collection.
    ///Returns:
    ///    The method returns the following return values. Implementers should return an <b>HRESULT</b> error code for
    ///    any other errors.
    ///    
    HRESULT OnBeginFile(IFsrmPropertyBag propertyBag, SAFEARRAY* arrayRuleIds);
    ///Queries the classifier to find out whether the specified property value applies to the file most recently
    ///specified by the IFsrmClassifierModuleImplementation::OnBeginFile method.
    ///Params:
    ///    property = Name of the property to query.
    ///    value = Value of the property to check in the query.
    ///    applyValue = Is <b>VARIANT_TRUE</b> if the property applies; otherwise, <b>VARIANT_FALSE</b>.
    ///    idRule = The identifier of the rule object associated with the property value being queried. This rule object is in
    ///             the rule collection passed in by a previous call to the
    ///             IFsrmClassifierModuleImplementation::UseRulesAndDefinitions method. The rule object can also be obtained by
    ///             using this identifier in a call to the IFsrmCollection::GetById method on this collection.
    ///    idPropDef = The identifier of the property definition object that corresponds to the property being queried. This
    ///                property definition object is in the property definition collection passed in by a previous call to the
    ///                IFsrmClassifierModuleImplementation::UseRulesAndDefinitions method. The property definition object can also
    ///                be obtained by using this identifier in a call to the IFsrmCollection::GetById method on this collection.
    ///Returns:
    ///    The method returns the following return values. Implementers should return an <b>HRESULT</b> error code for
    ///    any other errors.
    ///    
    HRESULT DoesPropertyValueApply(BSTR property, BSTR value, short* applyValue, GUID idRule, GUID idPropDef);
    ///Retrieves the value from the classifier that should be applied for the specified property of the file most
    ///recently specified by the IFsrmClassifierModuleImplementation::OnBeginFile method.
    ///Params:
    ///    property = Name of the property.
    ///    value = Value of the property.
    ///    idRule = The identifier of the rule object associated with the property value being queried. This rule object should
    ///             be in the rule collection passed in by a previous call to the
    ///             IFsrmClassifierModuleImplementation::UseRulesAndDefinitions method. The rule object can also be obtained by
    ///             using this identifier in a call to the IFsrmCollection::GetById method on this collection.
    ///    idPropDef = The identifier of the property definition object that corresponds to the property being queried. This
    ///                property definition object is in the property definition collection passed in by a previous call to the
    ///                IFsrmClassifierModuleImplementation::UseRulesAndDefinitions method. The property definition object can also
    ///                be obtained by using this identifier in a call to the IFsrmCollection::GetById method on this collection.
    ///Returns:
    ///    The method returns the following return values. Implementers should return an HRESULT error code for any
    ///    other errors.
    ///    
    HRESULT GetPropertyValueToApply(BSTR property, BSTR* value, GUID idRule, GUID idPropDef);
    ///Instructs the classifier to perform any cleanup after processing a file.
    ///Returns:
    ///    The method returns the following return values.
    ///    
    HRESULT OnEndFile();
}

///Storage modules implement this interface.
@GUID("0AF4A0DA-895A-4E50-8712-A96724BCEC64")
interface IFsrmStorageModuleImplementation : IFsrmPipelineModuleImplementation
{
    ///Specifies the property definitions FSRM recognizes.
    ///Params:
    ///    propertyDefinitions = Collection of property definitions that are currently defined by FSRM.
    ///Returns:
    ///    The method returns the following return values. Other values will result in the client application receiving
    ///    a <b>FSRM_E_MODULE_SESSION_INITIALIZATION</b> error. <b>Windows Server 2008 R2: </b>The client application
    ///    will receive a <b>FSRM_E_UNEXPECTED</b> error.
    ///    
    HRESULT UseDefinitions(IFsrmCollection propertyDefinitions);
    ///Instructs the storage module to load all properties.
    ///Params:
    ///    propertyBag = Specifies the properties to load.
    ///Returns:
    ///    The method returns the following return values. Implementers should return an HRESULT error code for any
    ///    other errors.
    ///    
    HRESULT LoadProperties(IFsrmPropertyBag propertyBag);
    ///Instructs the storage module to save properties associated with a file.
    ///Params:
    ///    propertyBag = Specifies the location to save properties.
    ///Returns:
    ///    The method returns the following return values. Implementers should return an HRESULT error code for any
    ///    other errors.
    ///    
    HRESULT SaveProperties(IFsrmPropertyBag propertyBag);
}

///Creates the communication channel between FSRM and your pipeline module implementation. Your pipeline module
///implementation must create this interface and To create this interface, call the CoCreateInstanceEx function. Use
///<b>CLSID_FsrmFileManagementJobManager</b> as the class identifier and
///<code>__uuidof(IFsrmFileManagementJobManager)</code> as the interface identifier.
@GUID("C16014F3-9AA1-46B3-B0A7-AB146EB205F2")
interface IFsrmPipelineModuleConnector : IDispatch
{
    ///The interface that implements the pipeline module. This property supports the infrastructure and is not intended
    ///to be used directly from your code. This property is read-only.
    HRESULT get_ModuleImplementation(IFsrmPipelineModuleImplementation* pipelineModuleImplementation);
    ///The name of the module. This property supports the infrastructure and is not intended to be used directly from
    ///your code. This property is read-only.
    HRESULT get_ModuleName(BSTR* userName);
    ///The user account under which the module runs. This property supports the infrastructure and is not intended to be
    ///used directly from your code. This property is read-only.
    HRESULT get_HostingUserAccount(BSTR* userAccount);
    ///The process identifier of the module. This property supports the infrastructure and is not intended to be used
    ///directly from your code. This property is read-only.
    HRESULT get_HostingProcessPid(int* pid);
    ///Binds the pipeline module implementation to the FSRM communication channel.
    ///Params:
    ///    moduleDefinition = An IFsrmPipelineModuleDefinition interface that contains the definition of the module.
    ///    moduleImplementation = An IFsrmPipelineModuleImplementation interface to the module's implementation.
    ///Returns:
    ///    The method returns the following return values.
    ///    
    HRESULT Bind(IFsrmPipelineModuleDefinition moduleDefinition, 
                 IFsrmPipelineModuleImplementation moduleImplementation);
}

///Handles events that are received while processing a ClassifyFiles call.
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
