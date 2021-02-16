module windows.packaging;

public import windows.core;
public import windows.com : HRESULT, IUnknown, IUri;
public import windows.security : CERT_CONTEXT;
public import windows.structuredstorage : IStream;
public import windows.systemservices : SECURITY_ATTRIBUTES;

extern(Windows):


// Enums


enum : int
{
    OPC_URI_TARGET_MODE_INTERNAL = 0x00000000,
    OPC_URI_TARGET_MODE_EXTERNAL = 0x00000001,
}
alias OPC_URI_TARGET_MODE = int;

enum : int
{
    OPC_COMPRESSION_NONE      = 0xffffffff,
    OPC_COMPRESSION_NORMAL    = 0x00000000,
    OPC_COMPRESSION_MAXIMUM   = 0x00000001,
    OPC_COMPRESSION_FAST      = 0x00000002,
    OPC_COMPRESSION_SUPERFAST = 0x00000003,
}
alias OPC_COMPRESSION_OPTIONS = int;

enum : int
{
    OPC_STREAM_IO_READ  = 0x00000001,
    OPC_STREAM_IO_WRITE = 0x00000002,
}
alias OPC_STREAM_IO_MODE = int;

enum : int
{
    OPC_READ_DEFAULT     = 0x00000000,
    OPC_VALIDATE_ON_LOAD = 0x00000001,
    OPC_CACHE_ON_ACCESS  = 0x00000002,
}
alias OPC_READ_FLAGS = int;

enum : int
{
    OPC_WRITE_DEFAULT     = 0x00000000,
    OPC_WRITE_FORCE_ZIP32 = 0x00000001,
}
alias OPC_WRITE_FLAGS = int;

enum : int
{
    OPC_SIGNATURE_VALID   = 0x00000000,
    OPC_SIGNATURE_INVALID = 0xffffffff,
}
alias OPC_SIGNATURE_VALIDATION_RESULT = int;

enum : int
{
    OPC_CANONICALIZATION_NONE               = 0x00000000,
    OPC_CANONICALIZATION_C14N               = 0x00000001,
    OPC_CANONICALIZATION_C14N_WITH_COMMENTS = 0x00000002,
}
alias OPC_CANONICALIZATION_METHOD = int;

enum : int
{
    OPC_RELATIONSHIP_SELECT_BY_ID   = 0x00000000,
    OPC_RELATIONSHIP_SELECT_BY_TYPE = 0x00000001,
}
alias OPC_RELATIONSHIP_SELECTOR = int;

enum : int
{
    OPC_RELATIONSHIP_SIGN_USING_SELECTORS = 0x00000000,
    OPC_RELATIONSHIP_SIGN_PART            = 0x00000001,
}
alias OPC_RELATIONSHIPS_SIGNING_OPTION = int;

enum : int
{
    OPC_CERTIFICATE_IN_CERTIFICATE_PART = 0x00000000,
    OPC_CERTIFICATE_IN_SIGNATURE_PART   = 0x00000001,
    OPC_CERTIFICATE_NOT_EMBEDDED        = 0x00000002,
}
alias OPC_CERTIFICATE_EMBEDDING_OPTION = int;

enum : int
{
    OPC_SIGNATURE_TIME_FORMAT_MILLISECONDS = 0x00000000,
    OPC_SIGNATURE_TIME_FORMAT_SECONDS      = 0x00000001,
    OPC_SIGNATURE_TIME_FORMAT_MINUTES      = 0x00000002,
    OPC_SIGNATURE_TIME_FORMAT_DAYS         = 0x00000003,
    OPC_SIGNATURE_TIME_FORMAT_MONTHS       = 0x00000004,
    OPC_SIGNATURE_TIME_FORMAT_YEARS        = 0x00000005,
}
alias OPC_SIGNATURE_TIME_FORMAT = int;

// Interfaces

@GUID("6B2D6BA0-9F3E-4F27-920B-313CC426A39E")
struct OpcFactory;

@GUID("BC9C1B9B-D62C-49EB-AEF0-3B4E0B28EBED")
interface IOpcUri : IUri
{
    HRESULT GetRelationshipsPartUri(IOpcPartUri* relationshipPartUri);
    HRESULT GetRelativeUri(IOpcPartUri targetPartUri, IUri* relativeUri);
    HRESULT CombinePartUri(IUri relativeUri, IOpcPartUri* combinedUri);
}

@GUID("7D3BABE7-88B2-46BA-85CB-4203CB016C87")
interface IOpcPartUri : IOpcUri
{
    HRESULT ComparePartUri(IOpcPartUri partUri, int* comparisonResult);
    HRESULT GetSourceUri(IOpcUri* sourceUri);
    HRESULT IsRelationshipsPartUri(int* isRelationshipUri);
}

@GUID("42195949-3B79-4FC8-89C6-FC7FB979EE70")
interface IOpcPackage : IUnknown
{
    HRESULT GetPartSet(IOpcPartSet* partSet);
    HRESULT GetRelationshipSet(IOpcRelationshipSet* relationshipSet);
}

@GUID("42195949-3B79-4FC8-89C6-FC7FB979EE71")
interface IOpcPart : IUnknown
{
    HRESULT GetRelationshipSet(IOpcRelationshipSet* relationshipSet);
    HRESULT GetContentStream(IStream* stream);
    HRESULT GetName(IOpcPartUri* name);
    HRESULT GetContentType(ushort** contentType);
    HRESULT GetCompressionOptions(OPC_COMPRESSION_OPTIONS* compressionOptions);
}

@GUID("42195949-3B79-4FC8-89C6-FC7FB979EE72")
interface IOpcRelationship : IUnknown
{
    HRESULT GetId(ushort** relationshipIdentifier);
    HRESULT GetRelationshipType(ushort** relationshipType);
    HRESULT GetSourceUri(IOpcUri* sourceUri);
    HRESULT GetTargetUri(IUri* targetUri);
    HRESULT GetTargetMode(OPC_URI_TARGET_MODE* targetMode);
}

@GUID("42195949-3B79-4FC8-89C6-FC7FB979EE73")
interface IOpcPartSet : IUnknown
{
    HRESULT GetPart(IOpcPartUri name, IOpcPart* part);
    HRESULT CreatePart(IOpcPartUri name, const(wchar)* contentType, OPC_COMPRESSION_OPTIONS compressionOptions, 
                       IOpcPart* part);
    HRESULT DeletePart(IOpcPartUri name);
    HRESULT PartExists(IOpcPartUri name, int* partExists);
    HRESULT GetEnumerator(IOpcPartEnumerator* partEnumerator);
}

@GUID("42195949-3B79-4FC8-89C6-FC7FB979EE74")
interface IOpcRelationshipSet : IUnknown
{
    HRESULT GetRelationship(const(wchar)* relationshipIdentifier, IOpcRelationship* relationship);
    HRESULT CreateRelationship(const(wchar)* relationshipIdentifier, const(wchar)* relationshipType, 
                               IUri targetUri, OPC_URI_TARGET_MODE targetMode, IOpcRelationship* relationship);
    HRESULT DeleteRelationship(const(wchar)* relationshipIdentifier);
    HRESULT RelationshipExists(const(wchar)* relationshipIdentifier, int* relationshipExists);
    HRESULT GetEnumerator(IOpcRelationshipEnumerator* relationshipEnumerator);
    HRESULT GetEnumeratorForType(const(wchar)* relationshipType, 
                                 IOpcRelationshipEnumerator* relationshipEnumerator);
    HRESULT GetRelationshipsContentStream(IStream* contents);
}

@GUID("42195949-3B79-4FC8-89C6-FC7FB979EE75")
interface IOpcPartEnumerator : IUnknown
{
    HRESULT MoveNext(int* hasNext);
    HRESULT MovePrevious(int* hasPrevious);
    HRESULT GetCurrent(IOpcPart* part);
    HRESULT Clone(IOpcPartEnumerator* copy);
}

@GUID("42195949-3B79-4FC8-89C6-FC7FB979EE76")
interface IOpcRelationshipEnumerator : IUnknown
{
    HRESULT MoveNext(int* hasNext);
    HRESULT MovePrevious(int* hasPrevious);
    HRESULT GetCurrent(IOpcRelationship* relationship);
    HRESULT Clone(IOpcRelationshipEnumerator* copy);
}

@GUID("E24231CA-59F4-484E-B64B-36EEDA36072C")
interface IOpcSignaturePartReference : IUnknown
{
    HRESULT GetPartName(IOpcPartUri* partName);
    HRESULT GetContentType(ushort** contentType);
    HRESULT GetDigestMethod(ushort** digestMethod);
    HRESULT GetDigestValue(char* digestValue, uint* count);
    HRESULT GetTransformMethod(OPC_CANONICALIZATION_METHOD* transformMethod);
}

@GUID("57BABAC6-9D4A-4E50-8B86-E5D4051EAE7C")
interface IOpcSignatureRelationshipReference : IUnknown
{
    HRESULT GetSourceUri(IOpcUri* sourceUri);
    HRESULT GetDigestMethod(ushort** digestMethod);
    HRESULT GetDigestValue(char* digestValue, uint* count);
    HRESULT GetTransformMethod(OPC_CANONICALIZATION_METHOD* transformMethod);
    HRESULT GetRelationshipSigningOption(OPC_RELATIONSHIPS_SIGNING_OPTION* relationshipSigningOption);
    HRESULT GetRelationshipSelectorEnumerator(IOpcRelationshipSelectorEnumerator* selectorEnumerator);
}

@GUID("F8F26C7F-B28F-4899-84C8-5D5639EDE75F")
interface IOpcRelationshipSelector : IUnknown
{
    HRESULT GetSelectorType(OPC_RELATIONSHIP_SELECTOR* selector);
    HRESULT GetSelectionCriterion(ushort** selectionCriterion);
}

@GUID("1B47005E-3011-4EDC-BE6F-0F65E5AB0342")
interface IOpcSignatureReference : IUnknown
{
    HRESULT GetId(ushort** referenceId);
    HRESULT GetUri(IUri* referenceUri);
    HRESULT GetType(ushort** type);
    HRESULT GetTransformMethod(OPC_CANONICALIZATION_METHOD* transformMethod);
    HRESULT GetDigestMethod(ushort** digestMethod);
    HRESULT GetDigestValue(char* digestValue, uint* count);
}

@GUID("5D77A19E-62C1-44E7-BECD-45DA5AE51A56")
interface IOpcSignatureCustomObject : IUnknown
{
    HRESULT GetXml(char* xmlMarkup, uint* count);
}

@GUID("52AB21DD-1CD0-4949-BC80-0C1232D00CB4")
interface IOpcDigitalSignature : IUnknown
{
    HRESULT GetNamespaces(char* prefixes, char* namespaces, uint* count);
    HRESULT GetSignatureId(ushort** signatureId);
    HRESULT GetSignaturePartName(IOpcPartUri* signaturePartName);
    HRESULT GetSignatureMethod(ushort** signatureMethod);
    HRESULT GetCanonicalizationMethod(OPC_CANONICALIZATION_METHOD* canonicalizationMethod);
    HRESULT GetSignatureValue(char* signatureValue, uint* count);
    HRESULT GetSignaturePartReferenceEnumerator(IOpcSignaturePartReferenceEnumerator* partReferenceEnumerator);
    HRESULT GetSignatureRelationshipReferenceEnumerator(IOpcSignatureRelationshipReferenceEnumerator* relationshipReferenceEnumerator);
    HRESULT GetSigningTime(ushort** signingTime);
    HRESULT GetTimeFormatA(OPC_SIGNATURE_TIME_FORMAT* timeFormat);
    HRESULT GetPackageObjectReference(IOpcSignatureReference* packageObjectReference);
    HRESULT GetCertificateEnumerator(IOpcCertificateEnumerator* certificateEnumerator);
    HRESULT GetCustomReferenceEnumerator(IOpcSignatureReferenceEnumerator* customReferenceEnumerator);
    HRESULT GetCustomObjectEnumerator(IOpcSignatureCustomObjectEnumerator* customObjectEnumerator);
    HRESULT GetSignatureXml(ubyte** signatureXml, uint* count);
}

@GUID("50D2D6A5-7AEB-46C0-B241-43AB0E9B407E")
interface IOpcSigningOptions : IUnknown
{
    HRESULT GetSignatureId(ushort** signatureId);
    HRESULT SetSignatureId(const(wchar)* signatureId);
    HRESULT GetSignatureMethod(ushort** signatureMethod);
    HRESULT SetSignatureMethod(const(wchar)* signatureMethod);
    HRESULT GetDefaultDigestMethod(ushort** digestMethod);
    HRESULT SetDefaultDigestMethod(const(wchar)* digestMethod);
    HRESULT GetCertificateEmbeddingOption(OPC_CERTIFICATE_EMBEDDING_OPTION* embeddingOption);
    HRESULT SetCertificateEmbeddingOption(OPC_CERTIFICATE_EMBEDDING_OPTION embeddingOption);
    HRESULT GetTimeFormatA(OPC_SIGNATURE_TIME_FORMAT* timeFormat);
    HRESULT SetTimeFormat(OPC_SIGNATURE_TIME_FORMAT timeFormat);
    HRESULT GetSignaturePartReferenceSet(IOpcSignaturePartReferenceSet* partReferenceSet);
    HRESULT GetSignatureRelationshipReferenceSet(IOpcSignatureRelationshipReferenceSet* relationshipReferenceSet);
    HRESULT GetCustomObjectSet(IOpcSignatureCustomObjectSet* customObjectSet);
    HRESULT GetCustomReferenceSet(IOpcSignatureReferenceSet* customReferenceSet);
    HRESULT GetCertificateSet(IOpcCertificateSet* certificateSet);
    HRESULT GetSignaturePartName(IOpcPartUri* signaturePartName);
    HRESULT SetSignaturePartName(IOpcPartUri signaturePartName);
}

@GUID("D5E62A0B-696D-462F-94DF-72E33CEF2659")
interface IOpcDigitalSignatureManager : IUnknown
{
    HRESULT GetSignatureOriginPartName(IOpcPartUri* signatureOriginPartName);
    HRESULT SetSignatureOriginPartName(IOpcPartUri signatureOriginPartName);
    HRESULT GetSignatureEnumerator(IOpcDigitalSignatureEnumerator* signatureEnumerator);
    HRESULT RemoveSignature(IOpcPartUri signaturePartName);
    HRESULT CreateSigningOptions(IOpcSigningOptions* signingOptions);
    HRESULT Validate(IOpcDigitalSignature signature, const(CERT_CONTEXT)* certificate, 
                     OPC_SIGNATURE_VALIDATION_RESULT* validationResult);
    HRESULT Sign(const(CERT_CONTEXT)* certificate, IOpcSigningOptions signingOptions, 
                 IOpcDigitalSignature* digitalSignature);
    HRESULT ReplaceSignatureXml(IOpcPartUri signaturePartName, const(ubyte)* newSignatureXml, uint count, 
                                IOpcDigitalSignature* digitalSignature);
}

@GUID("80EB1561-8C77-49CF-8266-459B356EE99A")
interface IOpcSignaturePartReferenceEnumerator : IUnknown
{
    HRESULT MoveNext(int* hasNext);
    HRESULT MovePrevious(int* hasPrevious);
    HRESULT GetCurrent(IOpcSignaturePartReference* partReference);
    HRESULT Clone(IOpcSignaturePartReferenceEnumerator* copy);
}

@GUID("773BA3E4-F021-48E4-AA04-9816DB5D3495")
interface IOpcSignatureRelationshipReferenceEnumerator : IUnknown
{
    HRESULT MoveNext(int* hasNext);
    HRESULT MovePrevious(int* hasPrevious);
    HRESULT GetCurrent(IOpcSignatureRelationshipReference* relationshipReference);
    HRESULT Clone(IOpcSignatureRelationshipReferenceEnumerator* copy);
}

@GUID("5E50A181-A91B-48AC-88D2-BCA3D8F8C0B1")
interface IOpcRelationshipSelectorEnumerator : IUnknown
{
    HRESULT MoveNext(int* hasNext);
    HRESULT MovePrevious(int* hasPrevious);
    HRESULT GetCurrent(IOpcRelationshipSelector* relationshipSelector);
    HRESULT Clone(IOpcRelationshipSelectorEnumerator* copy);
}

@GUID("CFA59A45-28B1-4868-969E-FA8097FDC12A")
interface IOpcSignatureReferenceEnumerator : IUnknown
{
    HRESULT MoveNext(int* hasNext);
    HRESULT MovePrevious(int* hasPrevious);
    HRESULT GetCurrent(IOpcSignatureReference* reference);
    HRESULT Clone(IOpcSignatureReferenceEnumerator* copy);
}

@GUID("5EE4FE1D-E1B0-4683-8079-7EA0FCF80B4C")
interface IOpcSignatureCustomObjectEnumerator : IUnknown
{
    HRESULT MoveNext(int* hasNext);
    HRESULT MovePrevious(int* hasPrevious);
    HRESULT GetCurrent(IOpcSignatureCustomObject* customObject);
    HRESULT Clone(IOpcSignatureCustomObjectEnumerator* copy);
}

@GUID("85131937-8F24-421F-B439-59AB24D140B8")
interface IOpcCertificateEnumerator : IUnknown
{
    HRESULT MoveNext(int* hasNext);
    HRESULT MovePrevious(int* hasPrevious);
    HRESULT GetCurrent(const(CERT_CONTEXT)** certificate);
    HRESULT Clone(IOpcCertificateEnumerator* copy);
}

@GUID("967B6882-0BA3-4358-B9E7-B64C75063C5E")
interface IOpcDigitalSignatureEnumerator : IUnknown
{
    HRESULT MoveNext(int* hasNext);
    HRESULT MovePrevious(int* hasPrevious);
    HRESULT GetCurrent(IOpcDigitalSignature* digitalSignature);
    HRESULT Clone(IOpcDigitalSignatureEnumerator* copy);
}

@GUID("6C9FE28C-ECD9-4B22-9D36-7FDDE670FEC0")
interface IOpcSignaturePartReferenceSet : IUnknown
{
    HRESULT Create(IOpcPartUri partUri, const(wchar)* digestMethod, OPC_CANONICALIZATION_METHOD transformMethod, 
                   IOpcSignaturePartReference* partReference);
    HRESULT Delete(IOpcSignaturePartReference partReference);
    HRESULT GetEnumerator(IOpcSignaturePartReferenceEnumerator* partReferenceEnumerator);
}

@GUID("9F863CA5-3631-404C-828D-807E0715069B")
interface IOpcSignatureRelationshipReferenceSet : IUnknown
{
    HRESULT Create(IOpcUri sourceUri, const(wchar)* digestMethod, 
                   OPC_RELATIONSHIPS_SIGNING_OPTION relationshipSigningOption, 
                   IOpcRelationshipSelectorSet selectorSet, OPC_CANONICALIZATION_METHOD transformMethod, 
                   IOpcSignatureRelationshipReference* relationshipReference);
    HRESULT CreateRelationshipSelectorSet(IOpcRelationshipSelectorSet* selectorSet);
    HRESULT Delete(IOpcSignatureRelationshipReference relationshipReference);
    HRESULT GetEnumerator(IOpcSignatureRelationshipReferenceEnumerator* relationshipReferenceEnumerator);
}

@GUID("6E34C269-A4D3-47C0-B5C4-87FF2B3B6136")
interface IOpcRelationshipSelectorSet : IUnknown
{
    HRESULT Create(OPC_RELATIONSHIP_SELECTOR selector, const(wchar)* selectionCriterion, 
                   IOpcRelationshipSelector* relationshipSelector);
    HRESULT Delete(IOpcRelationshipSelector relationshipSelector);
    HRESULT GetEnumerator(IOpcRelationshipSelectorEnumerator* relationshipSelectorEnumerator);
}

@GUID("F3B02D31-AB12-42DD-9E2F-2B16761C3C1E")
interface IOpcSignatureReferenceSet : IUnknown
{
    HRESULT Create(IUri referenceUri, const(wchar)* referenceId, const(wchar)* type, const(wchar)* digestMethod, 
                   OPC_CANONICALIZATION_METHOD transformMethod, IOpcSignatureReference* reference);
    HRESULT Delete(IOpcSignatureReference reference);
    HRESULT GetEnumerator(IOpcSignatureReferenceEnumerator* referenceEnumerator);
}

@GUID("8F792AC5-7947-4E11-BC3D-2659FF046AE1")
interface IOpcSignatureCustomObjectSet : IUnknown
{
    HRESULT Create(char* xmlMarkup, uint count, IOpcSignatureCustomObject* customObject);
    HRESULT Delete(IOpcSignatureCustomObject customObject);
    HRESULT GetEnumerator(IOpcSignatureCustomObjectEnumerator* customObjectEnumerator);
}

@GUID("56EA4325-8E2D-4167-B1A4-E486D24C8FA7")
interface IOpcCertificateSet : IUnknown
{
    HRESULT Add(const(CERT_CONTEXT)* certificate);
    HRESULT Remove(const(CERT_CONTEXT)* certificate);
    HRESULT GetEnumerator(IOpcCertificateEnumerator* certificateEnumerator);
}

@GUID("6D0B4446-CD73-4AB3-94F4-8CCDF6116154")
interface IOpcFactory : IUnknown
{
    HRESULT CreatePackageRootUri(IOpcUri* rootUri);
    HRESULT CreatePartUri(const(wchar)* pwzUri, IOpcPartUri* partUri);
    HRESULT CreateStreamOnFile(const(wchar)* filename, OPC_STREAM_IO_MODE ioMode, 
                               SECURITY_ATTRIBUTES* securityAttributes, uint dwFlagsAndAttributes, IStream* stream);
    HRESULT CreatePackage(IOpcPackage* package_);
    HRESULT ReadPackageFromStream(IStream stream, OPC_READ_FLAGS flags, IOpcPackage* package_);
    HRESULT WritePackageToStream(IOpcPackage package_, OPC_WRITE_FLAGS flags, IStream stream);
    HRESULT CreateDigitalSignatureManager(IOpcPackage package_, IOpcDigitalSignatureManager* signatureManager);
}


// GUIDs

const GUID CLSID_OpcFactory = GUIDOF!OpcFactory;

const GUID IID_IOpcCertificateEnumerator                    = GUIDOF!IOpcCertificateEnumerator;
const GUID IID_IOpcCertificateSet                           = GUIDOF!IOpcCertificateSet;
const GUID IID_IOpcDigitalSignature                         = GUIDOF!IOpcDigitalSignature;
const GUID IID_IOpcDigitalSignatureEnumerator               = GUIDOF!IOpcDigitalSignatureEnumerator;
const GUID IID_IOpcDigitalSignatureManager                  = GUIDOF!IOpcDigitalSignatureManager;
const GUID IID_IOpcFactory                                  = GUIDOF!IOpcFactory;
const GUID IID_IOpcPackage                                  = GUIDOF!IOpcPackage;
const GUID IID_IOpcPart                                     = GUIDOF!IOpcPart;
const GUID IID_IOpcPartEnumerator                           = GUIDOF!IOpcPartEnumerator;
const GUID IID_IOpcPartSet                                  = GUIDOF!IOpcPartSet;
const GUID IID_IOpcPartUri                                  = GUIDOF!IOpcPartUri;
const GUID IID_IOpcRelationship                             = GUIDOF!IOpcRelationship;
const GUID IID_IOpcRelationshipEnumerator                   = GUIDOF!IOpcRelationshipEnumerator;
const GUID IID_IOpcRelationshipSelector                     = GUIDOF!IOpcRelationshipSelector;
const GUID IID_IOpcRelationshipSelectorEnumerator           = GUIDOF!IOpcRelationshipSelectorEnumerator;
const GUID IID_IOpcRelationshipSelectorSet                  = GUIDOF!IOpcRelationshipSelectorSet;
const GUID IID_IOpcRelationshipSet                          = GUIDOF!IOpcRelationshipSet;
const GUID IID_IOpcSignatureCustomObject                    = GUIDOF!IOpcSignatureCustomObject;
const GUID IID_IOpcSignatureCustomObjectEnumerator          = GUIDOF!IOpcSignatureCustomObjectEnumerator;
const GUID IID_IOpcSignatureCustomObjectSet                 = GUIDOF!IOpcSignatureCustomObjectSet;
const GUID IID_IOpcSignaturePartReference                   = GUIDOF!IOpcSignaturePartReference;
const GUID IID_IOpcSignaturePartReferenceEnumerator         = GUIDOF!IOpcSignaturePartReferenceEnumerator;
const GUID IID_IOpcSignaturePartReferenceSet                = GUIDOF!IOpcSignaturePartReferenceSet;
const GUID IID_IOpcSignatureReference                       = GUIDOF!IOpcSignatureReference;
const GUID IID_IOpcSignatureReferenceEnumerator             = GUIDOF!IOpcSignatureReferenceEnumerator;
const GUID IID_IOpcSignatureReferenceSet                    = GUIDOF!IOpcSignatureReferenceSet;
const GUID IID_IOpcSignatureRelationshipReference           = GUIDOF!IOpcSignatureRelationshipReference;
const GUID IID_IOpcSignatureRelationshipReferenceEnumerator = GUIDOF!IOpcSignatureRelationshipReferenceEnumerator;
const GUID IID_IOpcSignatureRelationshipReferenceSet        = GUIDOF!IOpcSignatureRelationshipReferenceSet;
const GUID IID_IOpcSigningOptions                           = GUIDOF!IOpcSigningOptions;
const GUID IID_IOpcUri                                      = GUIDOF!IOpcUri;
