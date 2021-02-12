module windows.windowscontacts;

public import windows.com;
public import windows.structuredstorage;
public import windows.systemservices;
public import windows.windowsprogramming;

extern(Windows):

const GUID CLSID_Contact = {0x61B68808, 0x8EEE, 0x4FD1, [0xAC, 0xB8, 0x3D, 0x80, 0x4C, 0x8D, 0xB0, 0x56]};
@GUID(0x61B68808, 0x8EEE, 0x4FD1, [0xAC, 0xB8, 0x3D, 0x80, 0x4C, 0x8D, 0xB0, 0x56]);
struct Contact;

const GUID CLSID_ContactManager = {0x7165C8AB, 0xAF88, 0x42BD, [0x86, 0xFD, 0x53, 0x10, 0xB4, 0x28, 0x5A, 0x02]};
@GUID(0x7165C8AB, 0xAF88, 0x42BD, [0x86, 0xFD, 0x53, 0x10, 0xB4, 0x28, 0x5A, 0x02]);
struct ContactManager;

const GUID IID_IContactManager = {0xAD553D98, 0xDEB1, 0x474A, [0x8E, 0x17, 0xFC, 0x0C, 0x20, 0x75, 0xB7, 0x38]};
@GUID(0xAD553D98, 0xDEB1, 0x474A, [0x8E, 0x17, 0xFC, 0x0C, 0x20, 0x75, 0xB7, 0x38]);
interface IContactManager : IUnknown
{
    HRESULT Initialize(const(wchar)* pszAppName, const(wchar)* pszAppVersion);
    HRESULT Load(const(wchar)* pszContactID, IContact* ppContact);
    HRESULT MergeContactIDs(const(wchar)* pszNewContactID, const(wchar)* pszOldContactID);
    HRESULT GetMeContact(IContact* ppMeContact);
    HRESULT SetMeContact(IContact pMeContact);
    HRESULT GetContactCollection(IContactCollection* ppContactCollection);
}

const GUID IID_IContactCollection = {0xB6AFA338, 0xD779, 0x11D9, [0x8B, 0xDE, 0xF6, 0x6B, 0xAD, 0x1E, 0x3F, 0x3A]};
@GUID(0xB6AFA338, 0xD779, 0x11D9, [0x8B, 0xDE, 0xF6, 0x6B, 0xAD, 0x1E, 0x3F, 0x3A]);
interface IContactCollection : IUnknown
{
    HRESULT Reset();
    HRESULT Next();
    HRESULT GetCurrent(IContact* ppContact);
}

const GUID IID_IContactProperties = {0x70DD27DD, 0x5CBD, 0x46E8, [0xBE, 0xF0, 0x23, 0xB6, 0xB3, 0x46, 0x28, 0x8F]};
@GUID(0x70DD27DD, 0x5CBD, 0x46E8, [0xBE, 0xF0, 0x23, 0xB6, 0xB3, 0x46, 0x28, 0x8F]);
interface IContactProperties : IUnknown
{
    HRESULT GetString(const(wchar)* pszPropertyName, uint dwFlags, const(wchar)* pszValue, uint cchValue, uint* pdwcchPropertyValueRequired);
    HRESULT GetDate(const(wchar)* pszPropertyName, uint dwFlags, FILETIME* pftDateTime);
    HRESULT GetBinary(const(wchar)* pszPropertyName, uint dwFlags, const(wchar)* pszContentType, uint cchContentType, uint* pdwcchContentTypeRequired, IStream* ppStream);
    HRESULT GetLabels(const(wchar)* pszArrayElementName, uint dwFlags, const(wchar)* pszLabels, uint cchLabels, uint* pdwcchLabelsRequired);
    HRESULT SetString(const(wchar)* pszPropertyName, uint dwFlags, const(wchar)* pszValue);
    HRESULT SetDate(const(wchar)* pszPropertyName, uint dwFlags, FILETIME ftDateTime);
    HRESULT SetBinary(const(wchar)* pszPropertyName, uint dwFlags, const(wchar)* pszContentType, IStream pStream);
    HRESULT SetLabels(const(wchar)* pszArrayElementName, uint dwFlags, uint dwLabelCount, char* ppszLabels);
    HRESULT CreateArrayNode(const(wchar)* pszArrayName, uint dwFlags, BOOL fAppend, const(wchar)* pszNewArrayElementName, uint cchNewArrayElementName, uint* pdwcchNewArrayElementNameRequired);
    HRESULT DeleteProperty(const(wchar)* pszPropertyName, uint dwFlags);
    HRESULT DeleteArrayNode(const(wchar)* pszArrayElementName, uint dwFlags);
    HRESULT DeleteLabels(const(wchar)* pszArrayElementName, uint dwFlags);
    HRESULT GetPropertyCollection(IContactPropertyCollection* ppPropertyCollection, uint dwFlags, const(wchar)* pszMultiValueName, uint dwLabelCount, char* ppszLabels, BOOL fAnyLabelMatches);
}

const GUID IID_IContact = {0xF941B671, 0xBDA7, 0x4F77, [0x88, 0x4A, 0xF4, 0x64, 0x62, 0xF2, 0x26, 0xA7]};
@GUID(0xF941B671, 0xBDA7, 0x4F77, [0x88, 0x4A, 0xF4, 0x64, 0x62, 0xF2, 0x26, 0xA7]);
interface IContact : IUnknown
{
    HRESULT GetContactID(const(wchar)* pszContactID, uint cchContactID, uint* pdwcchContactIDRequired);
    HRESULT GetPath(const(wchar)* pszPath, uint cchPath, uint* pdwcchPathRequired);
    HRESULT CommitChanges(uint dwCommitFlags);
}

const GUID IID_IContactPropertyCollection = {0xFFD3ADF8, 0xFA64, 0x4328, [0xB1, 0xB6, 0x2E, 0x0D, 0xB5, 0x09, 0xCB, 0x3C]};
@GUID(0xFFD3ADF8, 0xFA64, 0x4328, [0xB1, 0xB6, 0x2E, 0x0D, 0xB5, 0x09, 0xCB, 0x3C]);
interface IContactPropertyCollection : IUnknown
{
    HRESULT Reset();
    HRESULT Next();
    HRESULT GetPropertyName(const(wchar)* pszPropertyName, uint cchPropertyName, uint* pdwcchPropertyNameRequired);
    HRESULT GetPropertyType(uint* pdwType);
    HRESULT GetPropertyVersion(uint* pdwVersion);
    HRESULT GetPropertyModificationDate(FILETIME* pftModificationDate);
    HRESULT GetPropertyArrayElementID(const(wchar)* pszArrayElementID, uint cchArrayElementID, uint* pdwcchArrayElementIDRequired);
}

