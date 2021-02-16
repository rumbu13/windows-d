module windows.windowscontacts;

public import windows.core;
public import windows.com : HRESULT, IUnknown;
public import windows.structuredstorage : IStream;
public import windows.systemservices : BOOL;
public import windows.windowsprogramming : FILETIME;

extern(Windows):


// Interfaces

@GUID("61B68808-8EEE-4FD1-ACB8-3D804C8DB056")
struct Contact;

@GUID("7165C8AB-AF88-42BD-86FD-5310B4285A02")
struct ContactManager;

@GUID("AD553D98-DEB1-474A-8E17-FC0C2075B738")
interface IContactManager : IUnknown
{
    HRESULT Initialize(const(wchar)* pszAppName, const(wchar)* pszAppVersion);
    HRESULT Load(const(wchar)* pszContactID, IContact* ppContact);
    HRESULT MergeContactIDs(const(wchar)* pszNewContactID, const(wchar)* pszOldContactID);
    HRESULT GetMeContact(IContact* ppMeContact);
    HRESULT SetMeContact(IContact pMeContact);
    HRESULT GetContactCollection(IContactCollection* ppContactCollection);
}

@GUID("B6AFA338-D779-11D9-8BDE-F66BAD1E3F3A")
interface IContactCollection : IUnknown
{
    HRESULT Reset();
    HRESULT Next();
    HRESULT GetCurrent(IContact* ppContact);
}

@GUID("70DD27DD-5CBD-46E8-BEF0-23B6B346288F")
interface IContactProperties : IUnknown
{
    HRESULT GetString(const(wchar)* pszPropertyName, uint dwFlags, const(wchar)* pszValue, uint cchValue, 
                      uint* pdwcchPropertyValueRequired);
    HRESULT GetDate(const(wchar)* pszPropertyName, uint dwFlags, FILETIME* pftDateTime);
    HRESULT GetBinary(const(wchar)* pszPropertyName, uint dwFlags, const(wchar)* pszContentType, 
                      uint cchContentType, uint* pdwcchContentTypeRequired, IStream* ppStream);
    HRESULT GetLabels(const(wchar)* pszArrayElementName, uint dwFlags, const(wchar)* pszLabels, uint cchLabels, 
                      uint* pdwcchLabelsRequired);
    HRESULT SetString(const(wchar)* pszPropertyName, uint dwFlags, const(wchar)* pszValue);
    HRESULT SetDate(const(wchar)* pszPropertyName, uint dwFlags, FILETIME ftDateTime);
    HRESULT SetBinary(const(wchar)* pszPropertyName, uint dwFlags, const(wchar)* pszContentType, IStream pStream);
    HRESULT SetLabels(const(wchar)* pszArrayElementName, uint dwFlags, uint dwLabelCount, char* ppszLabels);
    HRESULT CreateArrayNode(const(wchar)* pszArrayName, uint dwFlags, BOOL fAppend, 
                            const(wchar)* pszNewArrayElementName, uint cchNewArrayElementName, 
                            uint* pdwcchNewArrayElementNameRequired);
    HRESULT DeleteProperty(const(wchar)* pszPropertyName, uint dwFlags);
    HRESULT DeleteArrayNode(const(wchar)* pszArrayElementName, uint dwFlags);
    HRESULT DeleteLabels(const(wchar)* pszArrayElementName, uint dwFlags);
    HRESULT GetPropertyCollection(IContactPropertyCollection* ppPropertyCollection, uint dwFlags, 
                                  const(wchar)* pszMultiValueName, uint dwLabelCount, char* ppszLabels, 
                                  BOOL fAnyLabelMatches);
}

@GUID("F941B671-BDA7-4F77-884A-F46462F226A7")
interface IContact : IUnknown
{
    HRESULT GetContactID(const(wchar)* pszContactID, uint cchContactID, uint* pdwcchContactIDRequired);
    HRESULT GetPath(const(wchar)* pszPath, uint cchPath, uint* pdwcchPathRequired);
    HRESULT CommitChanges(uint dwCommitFlags);
}

@GUID("FFD3ADF8-FA64-4328-B1B6-2E0DB509CB3C")
interface IContactPropertyCollection : IUnknown
{
    HRESULT Reset();
    HRESULT Next();
    HRESULT GetPropertyName(const(wchar)* pszPropertyName, uint cchPropertyName, uint* pdwcchPropertyNameRequired);
    HRESULT GetPropertyType(uint* pdwType);
    HRESULT GetPropertyVersion(uint* pdwVersion);
    HRESULT GetPropertyModificationDate(FILETIME* pftModificationDate);
    HRESULT GetPropertyArrayElementID(const(wchar)* pszArrayElementID, uint cchArrayElementID, 
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
