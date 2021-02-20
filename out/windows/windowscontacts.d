// Written in the D programming language.

module windows.windowscontacts;

public import windows.core;
public import windows.com : HRESULT, IUnknown;
public import windows.structuredstorage : IStream;
public import windows.systemservices : BOOL, PWSTR;
public import windows.windowsprogramming : FILETIME;

extern(Windows) @nogc nothrow:


// Interfaces

@GUID("61B68808-8EEE-4FD1-ACB8-3D804C8DB056")
struct Contact;

@GUID("7165C8AB-AF88-42BD-86FD-5310B4285A02")
struct ContactManager;

///Do not use. Used for retrieving a contact, based on a contact ID string.
@GUID("AD553D98-DEB1-474A-8E17-FC0C2075B738")
interface IContactManager : IUnknown
{
    ///Initializes the contact manager with the unique application name and application version being used to manipulate
    ///contacts.
    ///Params:
    ///    pszAppName = Type: <b>LPWSTR</b> Specifies the application name.
    ///    pszAppVersion = Type: <b>LPCWSTR</b> Specifies the application version.
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns one of the following values: <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%">
    ///    IContactManager is initialized. </td> </tr> </table>
    ///    
    HRESULT Initialize(const(PWSTR) pszAppName, const(PWSTR) pszAppVersion);
    ///Loads an IContact object with the data from the contact referenced by the computer-local contact ID.
    ///Params:
    ///    pszContactID = Type: <b>LPCWSTR</b> Specifies the contact ID to load.
    ///    ppContact = Type: <b>IContact**</b> Specifies the destination IContact object.
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns one of the following values: <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%">
    ///    Contact was found and loaded. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NO_MATCH</b></dt> </dl>
    ///    </td> <td width="60%"> Could not find this contact ID. </td> </tr> </table>
    ///    
    HRESULT Load(const(PWSTR) pszContactID, IContact* ppContact);
    ///Makes an old Contact ID resolve to the same value as a new Contact ID. Subsequent calls to IContactManager::Load
    ///with the old contact ID now loads the new contact ID contact.
    ///Params:
    ///    pszNewContactID = Type: <b>LPWSTR</b> Specifies the ID of the new contact, representing both the old and new contacts.
    ///    pszOldContactID = Type: <b>LPCWSTR</b> Specifies the ID representing the old contact.
    HRESULT MergeContactIDs(const(PWSTR) pszNewContactID, const(PWSTR) pszOldContactID);
    ///Retrieves the local user account concept of 'me'.
    ///Params:
    ///    ppMeContact = Type: <b>IContact**</b> Specifies where to store a pointer to the 'me' contact.
    HRESULT GetMeContact(IContact* ppMeContact);
    ///Sets the local user account concept of 'me' to specified user.
    ///Params:
    ///    pMeContact = Type: <b>IContact*</b> Specifies the contact to treat as 'me' for the current user.
    HRESULT SetMeContact(IContact pMeContact);
    ///Returns an IContactCollection object that contains all known contacts.
    ///Params:
    ///    ppContactCollection = Type: <b>IContactCollection**</b> On success, contains an enumeration of the contact collection.
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns one of the following values: <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%">
    ///    Success. <i>ppContactCollection</i> contains the collection. </td> </tr> </table>
    ///    
    HRESULT GetContactCollection(IContactCollection* ppContactCollection);
}

///Do not use. Enumerates the contacts known by the IContactManager.
@GUID("B6AFA338-D779-11D9-8BDE-F66BAD1E3F3A")
interface IContactCollection : IUnknown
{
    ///Resets the enumerator to before the logical first element.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT Reset();
    ///Moves to the next contact.
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns one of the following values: <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Move
    ///    is successful. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>S_FALSE</b></dt> </dl> </td> <td width="60%">
    ///    Could not move, positioned at the end of the collection. </td> </tr> </table>
    ///    
    HRESULT Next();
    ///Retrieves the current contact in the enumeration.
    ///Params:
    ///    ppContact = Type: <b>IContact**</b> If successful, contains the current contact.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetCurrent(IContact* ppContact);
}

///Do not use. Used to retrieve, set, create, and remove properties on an IContact. Property names and extension
///mechanisms are described in icontactproperties.h.
@GUID("70DD27DD-5CBD-46E8-BEF0-23B6B346288F")
interface IContactProperties : IUnknown
{
    ///Retrieves the string value at a specified property into a caller-allocated buffer.
    ///Params:
    ///    pszPropertyName = Type: <b>LPCWSTR</b> Specifies the property to retrieve.
    ///    dwFlags = Type: <b>DWORD</b> Must be CGD_DEFAULT.
    ///    pszValue = Type: <b>LPWSTR</b> Specifies user-allocated buffer to store the property.
    ///    cchValue = Type: <b>DWORD*</b> Specifies allocated buffer size in characters.
    ///    pdwcchPropertyValueRequired = Type: <b>DWORD*</b> On failure, contains the required size for <i>pszValue</i>.
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns one of the following values: <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%">
    ///    <i>pszValue</i> contains the null-terminated value. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_FALSE</b></dt> </dl> </td> <td width="60%"> No data for this value. Either the property has been
    ///    present in the past but its value has been removed or the property is a container of other properties
    ///    (toplevel/secondlevel[3]). The buffer at <i>pszValue</i> has been zero'ed. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>ERROR_PATH_NOT_FOUND</b></dt> </dl> </td> <td width="60%"> No data found for this property name.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INSUFFICIENT_BUFFER</b></dt> </dl> </td> <td width="60%">
    ///    <i>pszValue</i> was not large enough to store the value. The required buffer size is stored in
    ///    *<i>pdwcchPropertyValueRequired</i>. </td> </tr> </table>
    ///    
    HRESULT GetString(const(PWSTR) pszPropertyName, uint dwFlags, PWSTR pszValue, uint cchValue, 
                      uint* pdwcchPropertyValueRequired);
    ///Retrieves the date and time value at a specified property into a caller's FILETIME structure. All times are
    ///stored and returned as Coordinated Universal Time (UTC).
    ///Params:
    ///    pszPropertyName = Type: <b>LPCWSTR</b> Specifies the property to retrieve.
    ///    dwFlags = Type: <b>DWORD</b> Must be CGD_DEFAULT.
    ///    pftDateTime = Type: <b>FILETIME*</b> Specifies caller-allocated FILETIME structure.
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns one of the following values: <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%">
    ///    <i>pftDateTime</i> contains a valid FILETIME. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>S_FALSE</b></dt>
    ///    </dl> </td> <td width="60%"> The property has been present in the past but its value has been removed. The
    ///    FILETIME has been zero'ed. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_PATH_NOT_FOUND</b></dt> </dl>
    ///    </td> <td width="60%"> No data found for this property name. </td> </tr> </table>
    ///    
    HRESULT GetDate(const(PWSTR) pszPropertyName, uint dwFlags, FILETIME* pftDateTime);
    ///Retrieves the binary data of a property using an IStream interface [Structured Storage].
    ///Params:
    ///    pszPropertyName = Type: <b>LPCWSTR</b> Specifies the property to retrieve.
    ///    dwFlags = Type: <b>DWORD</b> Must be CGD_DEFAULT.
    ///    pszContentType = Type: <b>LPWSTR</b> Specifies user-allocated buffer to store the MIME content type.
    ///    cchContentType = Type: <b>DWORD</b> Specifies the allocated buffer size in characters.
    ///    pdwcchContentTypeRequired = Type: <b>DWORD*</b> On failure, contains the required size for <i>pszContentType</i>.
    ///    ppStream = Type: <b>IStream**</b> On success, contains a new IStream interface [Structured Storage]. Use this to
    ///               retrieve the binary data.
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns one of the following values: <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%">
    ///    <i>ppStream</i> contains an IStream interface [Structured Storage]. Caller must release the reference. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>S_FALSE</b></dt> </dl> </td> <td width="60%"> No data for this value.
    ///    Either the property has been present in the past but its value has been removed or the property is a
    ///    container of other properties (toplevel/secondlevel[3]). The buffer at <i>pszContentType</i> has been
    ///    zero'ed. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_PATH_NOT_FOUND</b></dt> </dl> </td> <td
    ///    width="60%"> No data found for this property name. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>ERROR_INVALID_DATATYPE</b></dt> </dl> </td> <td width="60%"> Unable to get value for this property due
    ///    to schema. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INSUFFICIENT_BUFFER</b></dt> </dl> </td> <td
    ///    width="60%"> <i>pszContentType</i> was not large enough to store the value. The required buffer size is
    ///    stored in <i>pdwcchContentTypeRequired</i>. </td> </tr> </table>
    ///    
    HRESULT GetBinary(const(PWSTR) pszPropertyName, uint dwFlags, PWSTR pszContentType, uint cchContentType, 
                      uint* pdwcchContentTypeRequired, IStream* ppStream);
    ///Retrieves the labels for a specified array element name.
    ///Params:
    ///    pszArrayElementName = Type: <b>LPCWSTR</b> Specifies the array element name.
    ///    dwFlags = Type: <b>DWORD</b> Must be CGD_DEFAULT.
    ///    pszLabels = Type: <b>LPWSTR</b> Specifies user-allocated buffer to store the labels.
    ///    cchLabels = Type: <b>DWORD</b> Specifies allocated buffer size in characters.
    ///    pdwcchLabelsRequired = Type: <b>DWORD*</b> On failure, contains the required size for <i>pszLabels</i>.
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns one of the following values: <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%">
    ///    Retrieval successful. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_PATH_NOT_FOUND</b></dt> </dl> </td>
    ///    <td width="60%"> No data found for this property name. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>ERROR_INVALID_DATATYPE</b></dt> </dl> </td> <td width="60%"> Unable to get value for this property due
    ///    to schema. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INSUFFICIENT_BUFFER</b></dt> </dl> </td> <td
    ///    width="60%"> <i>pszLabels</i> was not large enough to store the value. The required buffer size is stored in
    ///    *<i>pdwcchLabelsRequired</i>. </td> </tr> </table>
    ///    
    HRESULT GetLabels(const(PWSTR) pszArrayElementName, uint dwFlags, PWSTR pszLabels, uint cchLabels, 
                      uint* pdwcchLabelsRequired);
    ///Sets the string value of a specified property to that of a specified null-terminated string.
    ///Params:
    ///    pszPropertyName = Type: <b>LPCWSTR</b> Specifies the property to set.
    ///    dwFlags = Type: <b>DWORD</b> CGD_DEFAULT can be used to create or overwrite value at <i>pszPropertyName</i>.
    ///    pszValue = Type: <b>LPWSTR</b> Specifies null-terminated string to store.
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns one of the following values: <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Value
    ///    is set at this property. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_PATH_NOT_FOUND</b></dt> </dl>
    ///    </td> <td width="60%"> Property name invalid for set. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>ERROR_INVALID_DATATYPE</b></dt> </dl> </td> <td width="60%"> Unable to set value for this property due
    ///    to schema. </td> </tr> </table>
    ///    
    HRESULT SetString(const(PWSTR) pszPropertyName, uint dwFlags, const(PWSTR) pszValue);
    ///Sets the date and time value at a specified property to a given FILETIME. All times are stored and returned as
    ///Coordinated Universal Time (UTC).
    ///Params:
    ///    pszPropertyName = Type: <b>LPCWSTR</b> Specifies the property to set.
    ///    dwFlags = Type: <b>DWORD</b> CGD_DEFAULT can be used to create or overwrite value at <i>pszPropertyName</i>.
    ///    ftDateTime = Type: <b>FILETIME</b> FILETIME structure to use for date.
    HRESULT SetDate(const(PWSTR) pszPropertyName, uint dwFlags, FILETIME ftDateTime);
    ///Sets the binary data at a specified property to the contents of a specified IStream interface [Structured
    ///Storage], which contains a null-terminated string (as MIME type) data.
    ///Params:
    ///    pszPropertyName = Type: <b>LPCWSTR</b> Specifies the property to set.
    ///    dwFlags = Type: <b>DWORD</b> CGD_DEFAULT can be used to create or overwrite the value at <i>pszPropertyName</i>.
    ///    pszContentType = Type: <b>LPWSTR</b> Specifies null-terminated string representing MIME type to store when CGD_DEFAULT.
    ///    pStream = Type: <b>IStream*</b> Pointer to IStream interface [Structured Storage] object containing data to place at
    ///              this node. NOTE: IStream::Read is called for the data until it succeeds with a zero-length read. Any other
    ///              return value results in a failure and no change.
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns one of the following values: <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Value
    ///    is set successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_PATH_NOT_FOUND</b></dt> </dl> </td>
    ///    <td width="60%"> Property name is invalid for set, or property name doesn't exist for delete. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_DATATYPE</b></dt> </dl> </td> <td width="60%"> Unable to set
    ///    the value for this property due to schema. </td> </tr> </table>
    ///    
    HRESULT SetBinary(const(PWSTR) pszPropertyName, uint dwFlags, const(PWSTR) pszContentType, IStream pStream);
    ///Appends the set of labels passed in to the specified property's label set. Note: This method does not check for
    ///duplicate labels.
    ///Params:
    ///    pszArrayElementName = Type: <b>LPCWSTR</b> Specifies the property to label.
    ///    dwFlags = Type: <b>DWORD</b> Must be CGD_DEFAULT.
    ///    dwLabelCount = Type: <b>DWORD</b> Specifies the count of labels in array.
    ///    ppszLabels = Type: <b>LPCWSTR</b> Specifies an array of LPCWSTR labels.
    HRESULT SetLabels(const(PWSTR) pszArrayElementName, uint dwFlags, uint dwLabelCount, PWSTR** ppszLabels);
    ///Creates a new array node in a multi-value property.
    ///Params:
    ///    pszArrayName = Type: <b>LPCWSTR</b> Specifies the top-level property for which to create a new node.
    ///    dwFlags = Type: <b>DWORD</b> Must be CGD_DEFAULT.
    ///    fAppend = Type: <b>BOOL</b> TRUE for insert after, <b>FALSE</b> for insert before.
    ///    pszNewArrayElementName = Type: <b>LPWSTR</b> Specifies a user-allocated buffer to store the new array element name.
    ///    cchNewArrayElementName = Type: <b>DWORD</b> Specifies an allocated buffer size in characters.
    ///    pdwcchNewArrayElementNameRequired = Type: <b>DWORD*</b> On failure, contains the required size for <i>pszNewArrayElementName</i>.
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns one of the following values: <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> New
    ///    node is created and name is in <i>pszNewArrayElementName</i>. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>ERROR_PATH_NOT_FOUND</b></dt> </dl> </td> <td width="60%"> Macro
    ///    HRESULT_FROM_WIN32(ERROR_PATH_NOT_FOUND) returned when array name is invalid. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>ERROR_INSUFFICIENT_BUFFER</b></dt> </dl> </td> <td width="60%"> Macro
    ///    HRESULT_FROM_WIN32(ERROR_INSUFFICIENT_BUFFER) returned when <i>pszNewArrayElementName</i> is not large enough
    ///    to store the value. The required buffer size is stored in <i>pdwcchNewArrayElementNameRequired</i>. </td>
    ///    </tr> </table>
    ///    
    HRESULT CreateArrayNode(const(PWSTR) pszArrayName, uint dwFlags, BOOL fAppend, PWSTR pszNewArrayElementName, 
                            uint cchNewArrayElementName, uint* pdwcchNewArrayElementNameRequired);
    ///Deletes the value at a specified property. Property modification and version data can still be enumerated with
    ///IContactPropertyCollection.
    ///Params:
    ///    pszPropertyName = Type: <b>LPCWSTR</b> Specifies the property to delete the value for.
    ///    dwFlags = Type: <b>DWORD</b> Must be CGD_DEFAULT.
    HRESULT DeleteProperty(const(PWSTR) pszPropertyName, uint dwFlags);
    ///Deletes the data at a specified array entry.
    ///Params:
    ///    pszArrayElementName = Type: <b>LPCWSTR</b> Specifies array entry from which to remove all data.
    ///    dwFlags = Type: <b>DWORD</b> Must be CGD_DEFAULT.
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns one of the following values: <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Node
    ///    is deleted. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_PATH_NOT_FOUND</b></dt> </dl> </td> <td
    ///    width="60%"> Property name doesn't exist for delete. </td> </tr> </table>
    ///    
    HRESULT DeleteArrayNode(const(PWSTR) pszArrayElementName, uint dwFlags);
    ///Deletes the labels at a specified array entry.
    ///Params:
    ///    pszArrayElementName = Type: <b>LPCWSTR</b> Specifies the property to delete labels on.
    ///    dwFlags = Type: <b>DWORD</b> Must be CGD_DEFAULT.
    HRESULT DeleteLabels(const(PWSTR) pszArrayElementName, uint dwFlags);
    ///Returns an IContactPropertyCollection for the current contact. Optionally, filters the
    ///<b>IContactPropertyCollection</b> to enumerate only some values.
    ///Params:
    ///    ppPropertyCollection = Type: <b>IContactPropertyCollection**</b> On success, points to the new IContactPropertyCollection.
    ///    dwFlags = Type: <b>DWORD</b> Must be CGD_DEFAULT.
    ///    pszMultiValueName = Type: <b>LPCWSTR</b> Specifies the name of the collection (for example: emailAddresses or
    ///                        [namespace]arrayNode). If <b>NULL</b>, all collections are searched for <i>ppszLabels</i>.
    ///    dwLabelCount = Type: <b>DWORD</b> Specifies the number of labels in <i>ppszLabels</i>. If zero, all subproperties with
    ///                   labels are returned.
    ///    ppszLabels = Type: <b>LPCWSTR</b> Specifies an array of string labels to test for. All labels in the array must be set to
    ///                 a valid string (not <b>NULL</b>).
    ///    fAnyLabelMatches = Type: <b>BOOL</b> TRUE if the presence of any label on a given property matches the property. FALSE if all
    ///                       labels must be present to match the property.
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns one of the following values: <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%">
    ///    Always returns success. </td> </tr> </table>
    ///    
    HRESULT GetPropertyCollection(IContactPropertyCollection* ppPropertyCollection, uint dwFlags, 
                                  const(PWSTR) pszMultiValueName, uint dwLabelCount, PWSTR** ppszLabels, 
                                  BOOL fAnyLabelMatches);
}

///Do not use. Defines methods for reading and writing properties for a single contact.
@GUID("F941B671-BDA7-4F77-884A-F46462F226A7")
interface IContact : IUnknown
{
    ///Retrieves the local computer unique contact ID.
    ///Params:
    ///    pszContactID = Type: <b>LPWSTR</b> User allocated buffer to store the contact ID.
    ///    cchContactID = Type: <b>DWORD</b> Specifies allocated buffer size.
    ///    pdwcchContactIDRequired = Type: <b>DWORD*</b> Upon failure due to insufficient buffer, contains the required size for
    ///                              <i>pszContactID</i>. May be <b>NULL</b>.
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns one of the following values: <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%">
    ///    Success. <i>pszContactID</i> contains a null-terminated ContactID. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>ERROR_INSUFFICIENT_BUFFER</b></dt> </dl> </td> <td width="60%"> Macro
    ///    HRESULT_FROM_WIN32(ERROR_INSUFFICIENT_BUFFER) returned when <i>pszContactID</i> was not large enough to store
    ///    the value. The required buffer size is stored in <i>pdwcchContactIDRequired</i>. </td> </tr> </table>
    ///    
    HRESULT GetContactID(PWSTR pszContactID, uint cchContactID, uint* pdwcchContactIDRequired);
    ///Retrieves the file system path used to load this contact.
    ///Params:
    ///    pszPath = Type: <b>LPWSTR</b> User-allocated buffer to store the contact ID.
    ///    cchPath = Type: <b>DWORD</b> Specifies the allocated buffer size in characters.
    ///    pdwcchPathRequired = Type: <b>DWORD*</b> Upon failure due to insufficient buffer, contains the required size for <i>pszPath</i>.
    HRESULT GetPath(PWSTR pszPath, uint cchPath, uint* pdwcchPathRequired);
    ///Saves changes made to this contact to the contact file.
    ///Params:
    ///    dwCommitFlags = Type: <b>DWORD</b> Reserved parameter. Must be 0.
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns one of the following values: <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%">
    ///    Changes written to disk successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_UNEXPECTED</b></dt>
    ///    </dl> </td> <td width="60%"> Contact not loaded from a file path. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>ERROR_SHARING_VIOLATION</b></dt> </dl> </td> <td width="60%"> Another process modified the file in a
    ///    way incompatible with changes to this contact. </td> </tr> </table>
    ///    
    HRESULT CommitChanges(uint dwCommitFlags);
}

///Do not use. Used to filter contact data, based on a label or property set. Enumerates contact properties exposed with
///an IContactProperties object. For each property, the name, type, version, and modification date can be retrieved.
@GUID("FFD3ADF8-FA64-4328-B1B6-2E0DB509CB3C")
interface IContactPropertyCollection : IUnknown
{
    ///Resets enumeration of properties.
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns one of the following values: <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Reset
    ///    is successful. </td> </tr> </table>
    ///    
    HRESULT Reset();
    ///Moves to the next property.
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns one of the following values: <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Move
    ///    is successful. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>S_FALSE</b></dt> </dl> </td> <td width="60%">
    ///    Could not move, positioned at the end of the collection. </td> </tr> </table>
    ///    
    HRESULT Next();
    ///Retrieves the name for the current property in the enumeration.
    ///Params:
    ///    pszPropertyName = Type: <b>LPWSTR</b> On success, contains the name to use for querying on IContactProperties. EX: toplevel
    ///                      -or- toplevel/secondlevel[4]/thirdlevel.
    ///    cchPropertyName = Type: <b>DWORD</b> Specifies caller-allocated buffer size in characters.
    ///    pdwcchPropertyNameRequired = Type: <b>DWORD*</b> On failure, contains the required size for <i>pszPropertyName</i>.
    HRESULT GetPropertyName(PWSTR pszPropertyName, uint cchPropertyName, uint* pdwcchPropertyNameRequired);
    ///Retrieves the type for the current property in the enumeration.
    ///Params:
    ///    pdwType = Type: <b>DWORD*</b> Specifies the type of property. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr>
    ///              <td width="40%"><a id="CGD_UNKNOWN_PROPERTY"></a><a id="cgd_unknown_property"></a><dl>
    ///              <dt><b>CGD_UNKNOWN_PROPERTY</b></dt> <dt>0x00000000</dt> </dl> </td> <td width="60%"></td> </tr> <tr> <td
    ///              width="40%"><a id="CGD_STRING_PROPERTY"></a><a id="cgd_string_property"></a><dl>
    ///              <dt><b>CGD_STRING_PROPERTY</b></dt> <dt>0x00000001</dt> </dl> </td> <td width="60%"></td> </tr> <tr> <td
    ///              width="40%"><a id="CGD_DATE_PROPERTY"></a><a id="cgd_date_property"></a><dl>
    ///              <dt><b>CGD_DATE_PROPERTY</b></dt> <dt>0x00000002</dt> </dl> </td> <td width="60%"></td> </tr> <tr> <td
    ///              width="40%"><a id="CGD_BINARY_PROPERTY"></a><a id="cgd_binary_property"></a><dl>
    ///              <dt><b>CGD_BINARY_PROPERTY</b></dt> <dt>0x00000004</dt> </dl> </td> <td width="60%"></td> </tr> <tr> <td
    ///              width="40%"><a id="CGD_ARRAY_NODE"></a><a id="cgd_array_node"></a><dl> <dt><b>CGD_ARRAY_NODE</b></dt>
    ///              <dt>0x00000008</dt> </dl> </td> <td width="60%"></td> </tr> </table>
    HRESULT GetPropertyType(uint* pdwType);
    ///Retrieves the version number for the current property in the enumeration.
    ///Params:
    ///    pdwVersion = Type: <b>DWORD*</b> Specifies the version of the property.
    HRESULT GetPropertyVersion(uint* pdwVersion);
    ///Retrieves the last modification date for the current property in the enumeration. If not modified, contact
    ///creation date is returned.
    ///Params:
    ///    pftModificationDate = Type: <b>FILETIME*</b> Specifies the last modified date as a UTC FILETIME.
    HRESULT GetPropertyModificationDate(FILETIME* pftModificationDate);
    ///Retrieves the unique ID for a given element in a property array.
    ///Params:
    ///    pszArrayElementID = Type: <b>LPWSTR</b> On success, contains the unique ID for the element.
    ///    cchArrayElementID = Type: <b>DWORD</b> Specifies caller-allocated buffer size in characters.
    ///    pdwcchArrayElementIDRequired = Type: <b>DWORD*</b> On failure, contains the required size for <i>pszArrayElementID</i>.
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns one of the following values. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Query
    ///    is successful. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>S_FALSE</b></dt> </dl> </td> <td width="60%">
    ///    Array node does not have a unique array element ID. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>ERROR_INSUFFICIENT_BUFFER</b></dt> </dl> </td> <td width="60%"> <i>pszArrayElementID</i> was not large
    ///    enough to store the value. The required buffer size is stored in *<i>pdwcchArrayElementIDRequired</i>. </td>
    ///    </tr> </table>
    ///    
    HRESULT GetPropertyArrayElementID(PWSTR pszArrayElementID, uint cchArrayElementID, 
                                      uint* pdwcchArrayElementIDRequired);
}


// GUIDs

const GUID CLSID_Contact        = GUIDOF!Contact;
const GUID CLSID_ContactManager = GUIDOF!ContactManager;

const GUID IID_IContact                   = GUIDOF!IContact;
const GUID IID_IContactCollection         = GUIDOF!IContactCollection;
const GUID IID_IContactManager            = GUIDOF!IContactManager;
const GUID IID_IContactProperties         = GUIDOF!IContactProperties;
const GUID IID_IContactPropertyCollection = GUIDOF!IContactPropertyCollection;
