// Written in the D programming language.

module windows.legacywindowsenvironmentfeatures;

public import windows.core;
public import windows.com : HRESULT, IMoniker, IOleObject, IUnknown;
public import windows.structuredstorage : IStorage;
public import windows.windowsandmessaging : HWND;
public import windows.windowsprogramming : HKEY;

extern(Windows):


// Enums


alias _reconcilef = int;
enum : int
{
    RECONCILEF_MAYBOTHERUSER        = 0x00000001,
    RECONCILEF_FEEDBACKWINDOWVALID  = 0x00000002,
    RECONCILEF_NORESIDUESOK         = 0x00000004,
    RECONCILEF_OMITSELFRESIDUE      = 0x00000008,
    RECONCILEF_RESUMERECONCILIATION = 0x00000010,
    RECONCILEF_YOUMAYDOTHEUPDATES   = 0x00000020,
    RECONCILEF_ONLYYOUWERECHANGED   = 0x00000040,
    ALL_RECONCILE_FLAGS             = 0x0000007f,
}

///<p class="CCE_Message">[Windows Search 2.x is available for use in the operating system specified in the Requirements
///section. It might be altered or unavailable in later versions. Use the Windows Search API instead.] Used by
///IResultsViewer::SortOrderProperty to indicate or set how a query is to be sorted.
alias _ColumnSortOrder = int;
enum : int
{
    ///Indicates that the sort order is ascending.
    SortOrder_Ascending  = 0x00000000,
    SortOrder_Descending = 0x00000001,
}

// Interfaces

///Exposes methods that are used by a disk cleanup handler to communicate with the disk cleanup manager.
@GUID("6E793361-73C6-11D0-8469-00AA00442901")
interface IEmptyVolumeCacheCallBack : IUnknown
{
    ///Called by a disk cleanup handler to update the disk cleanup manager on the progress of a scan for deletable
    ///files.
    ///Params:
    ///    dwlSpaceUsed = Type: <b>DWORDLONG</b> The amount of disk space that the handler can free at this point in the scan.
    ///    dwFlags = Type: <b>DWORD</b> A flag that can be sent to the disk cleanup manager. This flag can have the following
    ///              value.
    ///    pcwszStatus = Type: <b>LPCWSTR</b> Reserved.
    ///Returns:
    ///    Type: <b>HRESULT</b> This method can return one of these values. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The
    ///    handler should continue scanning for deletable files. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_ABORT</b></dt> </dl> </td> <td width="60%"> This value is returned when the user clicks the
    ///    <b>Cancel</b> button on the disk cleanup manager's dialog box while a scan is in progress. The handler should
    ///    stop scanning and shut down. </td> </tr> </table>
    ///    
    HRESULT ScanProgress(ulong dwlSpaceUsed, uint dwFlags, const(wchar)* pcwszStatus);
    ///Called periodically by a disk cleanup handler to update the disk cleanup manager on the progress of a purge of
    ///deletable files.
    ///Params:
    ///    dwlSpaceFreed = Type: <b>DWORDLONG</b> The amount of disk space, in bytes, that has been freed at this point in the purge.
    ///                    The disk cleanup manager uses this value to update its progress bar.
    ///    dwlSpaceToFree = Type: <b>DWORDLONG</b> The amount of disk space, in bytes, that remains to be freed at this point in the
    ///                     purge.
    ///    dwFlags = Type: <b>DWORD</b> A flag that can be sent to the disk cleanup manager. It can can have the following value:
    ///    pcwszStatus = Type: <b>LPCWSTR</b> Reserved.
    ///Returns:
    ///    Type: <b>HRESULT</b> This method can return one of these values. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The
    ///    handler should continue purging deletable files. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_ABORT</b></dt> </dl> </td> <td width="60%"> This value is returned when the user clicks the
    ///    <b>Cancel</b> button on the disk cleanup manager's dialog box while a scan is in progress. The handler should
    ///    stop purging files and shut down. </td> </tr> </table>
    ///    
    HRESULT PurgeProgress(ulong dwlSpaceFreed, ulong dwlSpaceToFree, uint dwFlags, const(wchar)* pcwszStatus);
}

///Used by the disk cleanup manager to communicate with a disk cleanup handler. Exposes methods that enable the manager
///to request information from a handler, and notify it of events such as the start of a scan or purge.
@GUID("8FCE5227-04DA-11D1-A004-00805F8ABE06")
interface IEmptyVolumeCache : IUnknown
{
    ///Initializes the disk cleanup handler, based on the information stored under the specified registry key.
    ///Params:
    ///    hkRegKey = Type: <b>HKEY</b> A handle to the registry key that holds the information about the handler object.
    ///    pcwszVolume = Type: <b>LPCWSTR</b> A pointer to a null-terminated Unicode string with the volume root—for example, "C:\".
    ///    ppwszDisplayName = Type: <b>LPWSTR*</b> A pointer to a null-terminated Unicode string with the name that will be displayed in
    ///                       the disk cleanup manager's list of handlers. If no value is assigned, the registry value will be used.
    ///    ppwszDescription = Type: <b>LPWSTR*</b> A pointer to a null-terminated Unicode string that will be displayed when this object is
    ///                       selected from the disk cleanup manager's list of available disk cleanup handlers. If no value is assigned,
    ///                       the registry value will be used.
    ///    pdwFlags = Type: <b>DWORD*</b> The flags that are used to pass information to the handler and back to the disk cleanup
    ///               manager.
    ///Returns:
    ///    Type: <b>HRESULT</b> This method can return one of these values. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%">
    ///    Success. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>S_FALSE</b></dt> </dl> </td> <td width="60%"> There
    ///    are no files to delete. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_ABORT</b></dt> </dl> </td> <td
    ///    width="60%"> The cleanup operation was ended prematurely. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> The cleanup operation failed. </td> </tr> </table>
    ///    
    HRESULT Initialize(HKEY hkRegKey, const(wchar)* pcwszVolume, ushort** ppwszDisplayName, 
                       ushort** ppwszDescription, uint* pdwFlags);
    ///Requests the amount of disk space that the disk cleanup handler can free.
    ///Params:
    ///    pdwlSpaceUsed = Type: <b>DWORDLONG*</b> The amount of disk space, in bytes, that the handler can free. This value will be
    ///                    displayed in the disk cleanup manager's list, to the right of the handler's check box. To indicate that you
    ///                    do not know how much disk space can be freed, set this parameter to -1, and "???MB" will be displayed. If you
    ///                    set the <b>EVCF_DONTSHOWIFZERO</b> flag when Initialize was called, setting <i>pdwSpaceUsed</i> to zero will
    ///                    notify the disk cleanup manager to omit the handler from its list.
    ///    picb = Type: <b>IEmptyVolumeCacheCallback*</b> A pointer to the disk cleanup manager's IEmptyVolumeCacheCallback
    ///           interface. This pointer can be used to call that interface's ScanProgress method to report on the progress of
    ///           the operation.
    ///Returns:
    ///    Type: <b>HRESULT</b> This method can return one of these values. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%">
    ///    Success. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>S_FALSE</b></dt> </dl> </td> <td width="60%"> An error
    ///    occurred when the handler tried to calculate the amount of disk space that could be freed. </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>E_ABORT</b></dt> </dl> </td> <td width="60%"> The scan operation was ended
    ///    prematurely. This value is usually returned when a call to ScanProgress returns E_ABORT. This return value
    ///    indicates that the user canceled the operation by clicking the disk cleanup manager's <b>Cancel</b> button.
    ///    </td> </tr> </table>
    ///    
    HRESULT GetSpaceUsed(ulong* pdwlSpaceUsed, IEmptyVolumeCacheCallBack picb);
    ///Notifies the handler to start deleting its unneeded files.
    ///Params:
    ///    dwlSpaceToFree = Type: <b>DWORDLONG</b> The amount of disk space that the handler should free. If this parameter is set to -1,
    ///                     the handler should delete all its files.
    ///    picb = Type: <b>IEmptyVolumeCacheCallback*</b> A pointer to the disk cleanup manager's IEmptyVolumeCacheCallBack
    ///           interface. This pointer can be used to call the interface's PurgeProgress method to report on the progress of
    ///           the operation.
    ///Returns:
    ///    Type: <b>HRESULT</b> This method can return one of these values. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%">
    ///    Success. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_ABORT</b></dt> </dl> </td> <td width="60%"> The
    ///    operation was ended prematurely. This value is usually returned when PurgeProgress returns E_ABORT. This
    ///    typically happens when the user cancels the operation by clicking the disk cleanup manager's <b>Cancel</b>
    ///    button. </td> </tr> </table>
    ///    
    HRESULT Purge(ulong dwlSpaceToFree, IEmptyVolumeCacheCallBack picb);
    ///Notifies the handler to display its UI.
    ///Params:
    ///    hwnd = Type: <b>HWND</b> The parent window to be used when displaying the UI.
    ///Returns:
    ///    Type: <b>HRESULT</b> This method can return one of these values. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The
    ///    user changed one or more settings. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>S_FALSE</b></dt> </dl> </td>
    ///    <td width="60%"> No settings were changed. </td> </tr> </table>
    ///    
    HRESULT ShowProperties(HWND hwnd);
    ///Notifies the handler that the disk cleanup manager is shutting down.
    ///Params:
    ///    pdwFlags = Type: <b>DWORD*</b> A flag that can be set to return information to the disk cleanup manager. It can have the
    ///               following value.
    ///Returns:
    ///    Type: <b>HRESULT</b> This method can return one of these values. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> This
    ///    value should always be returned. </td> </tr> </table>
    ///    
    HRESULT Deactivate(uint* pdwFlags);
}

///Extends IEmptyVolumeCache. This interface defines one additional method, InitializeEx, that provides better
///localization support than IEmptyVolumeCache::Initialize.
@GUID("02B7E3BA-4DB3-11D2-B2D9-00C04F8EEC8C")
interface IEmptyVolumeCache2 : IEmptyVolumeCache
{
    ///Initializes the disk cleanup handler. It provides better support for localization than Initialize.
    ///Params:
    ///    hkRegKey = Type: <b>HKEY</b> A handle to the registry key that holds the information about the handler object.
    ///    pcwszVolume = Type: <b>LPCWSTR</b> A pointer to a null-terminated Unicode string with the volume root—for example, "C:\".
    ///    pcwszKeyName = Type: <b>LPCWSTR</b> A pointer to a null-terminated Unicode string with the name of the handler's registry
    ///                   key.
    ///    ppwszDisplayName = Type: <b>LPWSTR*</b> A pointer to a null-terminated Unicode string with the name that will be displayed in
    ///                       the disk cleanup manager's list of handlers. You must assign a value to this parameter.
    ///    ppwszDescription = Type: <b>LPWSTR*</b> A pointer to a null-terminated Unicode string that will be displayed when this object is
    ///                       selected from the disk cleanup manager's list of available disk cleaners. You must assign a value to this
    ///                       parameter.
    ///    ppwszBtnText = Type: <b>LPWSTR*</b> A pointer to a null-terminated Unicode string with the text that will be displayed on
    ///                   the disk cleanup manager's <b>Settings</b> button. If the <b>EVCF_HASSETTINGS</b> flag is set, you must
    ///                   assign a value to <i>ppwszBtnText</i>. Otherwise, you can set it to <b>NULL</b>.
    ///    pdwFlags = Type: <b>DWORD*</b> Flags that are used to pass information to the handler, and back to the disk cleanup
    ///               manager.
    ///Returns:
    ///    Type: <b>HRESULT</b> This method can return one of these values. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%">
    ///    Success. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>S_FALSE</b></dt> </dl> </td> <td width="60%"> There
    ///    are no files to delete. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_ABORT</b></dt> </dl> </td> <td
    ///    width="60%"> The cleanup operation was ended prematurely. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> The cleanup operation failed. </td> </tr> </table>
    ///    
    HRESULT InitializeEx(HKEY hkRegKey, const(wchar)* pcwszVolume, const(wchar)* pcwszKeyName, 
                         ushort** ppwszDisplayName, ushort** ppwszDescription, ushort** ppwszBtnText, uint* pdwFlags);
}

///Exposes methods that provide the briefcase reconciler with the means to notify the initiator of its progress, to set
///a termination object, and to request a given version of a document. The initiator is responsible for implementing
///this interface.
@GUID("99180161-DA16-101A-935C-444553540000")
interface IReconcileInitiator : IUnknown
{
    ///Sets the object through which the initiator can asynchronously terminate a reconciliation. A briefcase reconciler
    ///typically sets this object for reconciliations that are lengthy or involve user interaction.
    ///Params:
    ///    punkForAbort = Type: <b>IUnknown*</b> The address of the IUnknown interface for the object. The initiator signals a request
    ///                   to terminate the reconciliation by using the IUnknown::Release method to release the object. This parameter
    ///                   may be <b>NULL</b> to direct the initiator to remove the previously specified object.
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns the S_OK value if successful, or one of the following error values otherwise.
    ///    <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>REC_E_NOCALLBACK</b></dt> </dl> </td> <td width="60%"> The initiator does not support termination of
    ///    reconciliation operations and does not hold the specified object. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_UNEXPECTED</b></dt> </dl> </td> <td width="60%"> Unspecified error. </td> </tr> </table>
    ///    
    HRESULT SetAbortCallback(IUnknown punkForAbort);
    ///Indicates the amount of progress the briefcase reconciler has made toward completing the reconciliation. The
    ///amount is a fraction and is computed as the quotient of the <i>ulProgress</i> and <i>ulProgressMax</i>
    ///parameters. Reconcilers should call this method periodically during their reconciliation process.
    ///Params:
    ///    ulProgress = Type: <b>ULONG</b> The numerator of the progress fraction.
    ///    ulProgressMax = Type: <b>ULONG</b> The denominator of the progress fraction.
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns the S_OK value if successful, or the E_UNEXPECTED value if an unspecified error
    ///    occurred.
    ///    
    HRESULT SetProgressFeedback(uint ulProgress, uint ulProgressMax);
}

///Exposes methods that reconcile a given document. The briefcase reconciler is responsible for implementing this
///interface.
@GUID("99180162-DA16-101A-935C-444553540000")
interface IReconcilableObject : IUnknown
{
    ///Reconciles the state of an object with one or more other objects. The reconciliation updates the internal state
    ///of the object by merging the states of all objects to form a combined state.
    ///Params:
    ///    pInitiator = Type: <b>IReconcileInitiator*</b> The address of the IReconcileInitiator interface for the initiator of the
    ///                 reconciliation process. This parameter must not be <b>NULL</b>.
    ///    dwFlags = Type: <b>DWORD</b> The control flags for the reconciliation. This parameter may be zero or a combination of
    ///              these values:
    ///    hwndOwner = Type: <b>HWND</b> A handle to the window to be used as the parent for any child windows that the briefcase
    ///                reconciler creates. This parameter is valid only if RECONCILEF_MAYBOTHERUSER is specified in <i>dwFlags</i>.
    ///    hwndProgressFeedback = Type: <b>HWND</b> A handle to the progress feedback window to be displayed by the initiator. This parameter
    ///                           is valid only if RECONCILEF_FEEDBACKWINDOWVALID is specified in <i>dwFlags</i>. The briefcase reconciler may
    ///                           call the <b>SetWindowText</b> function using this window handle to display additional reconciliation status
    ///                           information to the user.
    ///    ulcInput = Type: <b>ULONG</b> The number of versions or partial residues specified in <i>dwFlags</i>. This parameter
    ///               must not be zero.
    ///    rgpmkOtherInput = Type: <b>IMoniker**</b> The address of an array that contains the addresses of the monikers to use to access
    ///                      the versions or partial residues to be reconciled.
    ///    plOutIndex = Type: <b>LONG*</b> The address of the variable that receives an index value indicating whether the result of
    ///                 the reconciliation is identical to one of the initial versions. The variable is set to -1L if the
    ///                 reconciliation result is a combination of two or more versions. Otherwise, it is a zero-based index, with 0
    ///                 indicating this object, 1 indicating the first version, 2 indicating the second version, and so on.
    ///    pstgNewResidues = Type: <b>IStorage*</b> The address of the <b>IStorage</b> interface used to store the new residues. This
    ///                      parameter can be <b>NULL</b> to indicate that residues should not be saved.
    ///    pvReserved = Type: <b>void*</b> Reserved; must be <b>NULL</b>.
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns one of the following values. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%">
    ///    Reconciliation completed successfully, and the changes must be propagated to the other objects. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>S_FALSE</b></dt> </dl> </td> <td width="60%"> No reconciliation actions
    ///    were performed. The briefcase reconciler wishes to fall back to the initiator's bit copy implementation. This
    ///    value may only be returned if RECONCILEF_ONLYYOUWERECHANGED is set in <i>dwFlags</i>. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>REC_S_IDIDTHEUPDATES</b></dt> </dl> </td> <td width="60%"> Reconciliation was
    ///    completed successfully, and all the objects involved (the object implementing the Reconcile method and all
    ///    the other objects described by <i>rgpmkOtherInput</i>) have been updated appropriately. The initiator does
    ///    not need, therefore, to do anything further to propagate the changes. The variable pointed to by
    ///    <i>plOutIndex</i> should be set to -1L if <b>Reconcile</b> returns this value. The initiator will not save
    ///    the source object's storage if <b>Reconcile</b> returns this value. This value may only be returned if
    ///    RECONCILEF_YOUMAYDOTHEUPDATES was set in <i>dwFlags</i>. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>REC_S_NOTCOMPLETE</b></dt> </dl> </td> <td width="60%"> The briefcase reconciler completed some, but
    ///    not all, of the reconciliation. It may need user interaction. The changes will not be propagated to other
    ///    objects. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>REC_S_NOTCOMPLETEBUTPROPAGATE</b></dt> </dl> </td> <td
    ///    width="60%"> The briefcase reconciler completed some, but not all, of the reconciliation. It may need user
    ///    interaction. The changes will be propagated to the other objects. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>REC_E_NORESIDUES</b></dt> </dl> </td> <td width="60%"> The briefcase reconciler does not support the
    ///    generation of residues, so the request for residues is denied. The state of the object is unchanged. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>REC_E_ABORTED</b></dt> </dl> </td> <td width="60%"> The briefcase
    ///    reconciler stopped reconciliation in response to a termination request from the initiator (see
    ///    SetAbortCallback for more information). The state of the object is unspecified. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>REC_E_TOODIFFERENT</b></dt> </dl> </td> <td width="60%"> Reconciliation cannot be
    ///    carried out because the provided document versions are too dissimilar. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>REC_E_INEEDTODOTHEUPDATES</b></dt> </dl> </td> <td width="60%"> The RECONCILEF_YOUMAYDOTHEUPDATES flag
    ///    was not set when the object's Reconcile implementation was called; this implementation requires that this
    ///    value be set in the <i>dwFlags</i> parameter. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>OLE_E_NOTRUNNING</b></dt> </dl> </td> <td width="60%"> The object is an OLE embedded object that must
    ///    be run before this operation can be carried out. The state of the object is unchanged. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_UNEXPECTED</b></dt> </dl> </td> <td width="60%"> Unspecified error. </td> </tr>
    ///    </table>
    ///    
    HRESULT Reconcile(IReconcileInitiator pInitiator, uint dwFlags, HWND hwndOwner, HWND hwndProgressFeedback, 
                      uint ulcInput, char* rgpmkOtherInput, int* plOutIndex, IStorage pstgNewResidues, 
                      void* pvReserved);
    ///Retrieves an estimated measurement of the amount of work required to complete a reconciliation. Reconcilers
    ///typically use this method to estimate the work needed to reconcile an embedded document. This value corresponds
    ///to a similar value that is passed with the SetProgressFeedback method during reconciliation.
    ///Params:
    ///    pulProgressMax = Type: <b>ULONG*</b> The address of the variable to receive the work estimate value.
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns S_OK if successful, or one of the following error values otherwise. <table> <tr>
    ///    <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>OLE_E_NOTRUNNING</b></dt>
    ///    </dl> </td> <td width="60%"> The object is an OLE embedded document that must be run before this operation
    ///    can be carried out. The object state is unchanged as a result of the call. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_UNEXPECTED</b></dt> </dl> </td> <td width="60%"> Unspecified error. </td> </tr> </table>
    ///    
    HRESULT GetProgressFeedbackMaxEstimate(uint* pulProgressMax);
}

@GUID("99180164-DA16-101A-935C-444553540000")
interface IBriefcaseInitiator : IUnknown
{
    HRESULT IsMonikerInBriefcase(IMoniker pmk);
}

///<p class="CCE_Message">[<b>IActiveDesktopP</b> is available for use in the operating systems specified in the
///Requirements section. It may be altered or unavailable in subsequent versions.] Exposes methods that manage the
///Windows Desktop.
@GUID("52502EE0-EC80-11D0-89AB-00C04FC2972D")
interface IActiveDesktopP : IUnknown
{
    ///Sets or updates the Microsoft Active Desktop to safe mode.
    ///Params:
    ///    dwFlags = Type: <b>DWORD</b> One of the following flags.
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns S_OK if successful, or an error code otherwise.
    ///    
    HRESULT SetSafeMode(uint dwFlags);
    HRESULT EnsureUpdateHTML();
    HRESULT SetScheme(const(wchar)* pwszSchemeName, uint dwFlags);
    HRESULT GetScheme(const(wchar)* pwszSchemeName, uint* pdwcchBuffer, uint dwFlags);
}

///Provides methods to manage the Windows Desktop.
@GUID("B22754E2-4574-11D1-9888-006097DEACF9")
interface IADesktopP2 : IUnknown
{
    HRESULT ReReadWallpaper();
    HRESULT GetADObjectFlags(uint* pdwFlags, uint dwMask);
    ///Calls the UpdateAllDesktopSubscriptions function to update desktop subscriptions.
    HRESULT UpdateAllDesktopSubscriptions();
    HRESULT MakeDynamicChanges(IOleObject pOleObj);
}


// GUIDs


const GUID IID_IADesktopP2               = GUIDOF!IADesktopP2;
const GUID IID_IActiveDesktopP           = GUIDOF!IActiveDesktopP;
const GUID IID_IBriefcaseInitiator       = GUIDOF!IBriefcaseInitiator;
const GUID IID_IEmptyVolumeCache         = GUIDOF!IEmptyVolumeCache;
const GUID IID_IEmptyVolumeCache2        = GUIDOF!IEmptyVolumeCache2;
const GUID IID_IEmptyVolumeCacheCallBack = GUIDOF!IEmptyVolumeCacheCallBack;
const GUID IID_IReconcilableObject       = GUIDOF!IReconcilableObject;
const GUID IID_IReconcileInitiator       = GUIDOF!IReconcileInitiator;
