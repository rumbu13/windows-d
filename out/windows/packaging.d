module windows.packaging;

public import windows.com;
public import windows.security;
public import windows.structuredstorage;
public import windows.systemservices;

extern(Windows):

const GUID CLSID_OpcFactory = {0x6B2D6BA0, 0x9F3E, 0x4F27, [0x92, 0x0B, 0x31, 0x3C, 0xC4, 0x26, 0xA3, 0x9E]};
@GUID(0x6B2D6BA0, 0x9F3E, 0x4F27, [0x92, 0x0B, 0x31, 0x3C, 0xC4, 0x26, 0xA3, 0x9E]);
struct OpcFactory;

const GUID IID_IOpcUri = {0xBC9C1B9B, 0xD62C, 0x49EB, [0xAE, 0xF0, 0x3B, 0x4E, 0x0B, 0x28, 0xEB, 0xED]};
@GUID(0xBC9C1B9B, 0xD62C, 0x49EB, [0xAE, 0xF0, 0x3B, 0x4E, 0x0B, 0x28, 0xEB, 0xED]);
interface IOpcUri : IUri
{
    HRESULT GetRelationshipsPartUri(IOpcPartUri* relationshipPartUri);
    HRESULT GetRelativeUri(IOpcPartUri targetPartUri, IUri* relativeUri);
    HRESULT CombinePartUri(IUri relativeUri, IOpcPartUri* combinedUri);
}

const GUID IID_IOpcPartUri = {0x7D3BABE7, 0x88B2, 0x46BA, [0x85, 0xCB, 0x42, 0x03, 0xCB, 0x01, 0x6C, 0x87]};
@GUID(0x7D3BABE7, 0x88B2, 0x46BA, [0x85, 0xCB, 0x42, 0x03, 0xCB, 0x01, 0x6C, 0x87]);
interface IOpcPartUri : IOpcUri
{
    HRESULT ComparePartUri(IOpcPartUri partUri, int* comparisonResult);
    HRESULT GetSourceUri(IOpcUri* sourceUri);
    HRESULT IsRelationshipsPartUri(int* isRelationshipUri);
}

enum OPC_URI_TARGET_MODE
{
    OPC_URI_TARGET_MODE_INTERNAL = 0,
    OPC_URI_TARGET_MODE_EXTERNAL = 1,
}

enum OPC_COMPRESSION_OPTIONS
{
    OPC_COMPRESSION_NONE = -1,
    OPC_COMPRESSION_NORMAL = 0,
    OPC_COMPRESSION_MAXIMUM = 1,
    OPC_COMPRESSION_FAST = 2,
    OPC_COMPRESSION_SUPERFAST = 3,
}

enum OPC_STREAM_IO_MODE
{
    OPC_STREAM_IO_READ = 1,
    OPC_STREAM_IO_WRITE = 2,
}

enum OPC_READ_FLAGS
{
    OPC_READ_DEFAULT = 0,
    OPC_VALIDATE_ON_LOAD = 1,
    OPC_CACHE_ON_ACCESS = 2,
}

enum OPC_WRITE_FLAGS
{
    OPC_WRITE_DEFAULT = 0,
    OPC_WRITE_FORCE_ZIP32 = 1,
}

enum OPC_SIGNATURE_VALIDATION_RESULT
{
    OPC_SIGNATURE_VALID = 0,
    OPC_SIGNATURE_INVALID = -1,
}

enum OPC_CANONICALIZATION_METHOD
{
    OPC_CANONICALIZATION_NONE = 0,
    OPC_CANONICALIZATION_C14N = 1,
    OPC_CANONICALIZATION_C14N_WITH_COMMENTS = 2,
}

enum OPC_RELATIONSHIP_SELECTOR
{
    OPC_RELATIONSHIP_SELECT_BY_ID = 0,
    OPC_RELATIONSHIP_SELECT_BY_TYPE = 1,
}

enum OPC_RELATIONSHIPS_SIGNING_OPTION
{
    OPC_RELATIONSHIP_SIGN_USING_SELECTORS = 0,
    OPC_RELATIONSHIP_SIGN_PART = 1,
}

enum OPC_CERTIFICATE_EMBEDDING_OPTION
{
    OPC_CERTIFICATE_IN_CERTIFICATE_PART = 0,
    OPC_CERTIFICATE_IN_SIGNATURE_PART = 1,
    OPC_CERTIFICATE_NOT_EMBEDDED = 2,
}

enum OPC_SIGNATURE_TIME_FORMAT
{
    OPC_SIGNATURE_TIME_FORMAT_MILLISECONDS = 0,
    OPC_SIGNATURE_TIME_FORMAT_SECONDS = 1,
    OPC_SIGNATURE_TIME_FORMAT_MINUTES = 2,
    OPC_SIGNATURE_TIME_FORMAT_DAYS = 3,
    OPC_SIGNATURE_TIME_FORMAT_MONTHS = 4,
    OPC_SIGNATURE_TIME_FORMAT_YEARS = 5,
}

const GUID IID_IOpcPackage = {0x42195949, 0x3B79, 0x4FC8, [0x89, 0xC6, 0xFC, 0x7F, 0xB9, 0x79, 0xEE, 0x70]};
@GUID(0x42195949, 0x3B79, 0x4FC8, [0x89, 0xC6, 0xFC, 0x7F, 0xB9, 0x79, 0xEE, 0x70]);
interface IOpcPackage : IUnknown
{
    HRESULT GetPartSet(IOpcPartSet* partSet);
    HRESULT GetRelationshipSet(IOpcRelationshipSet* relationshipSet);
}

const GUID IID_IOpcPart = {0x42195949, 0x3B79, 0x4FC8, [0x89, 0xC6, 0xFC, 0x7F, 0xB9, 0x79, 0xEE, 0x71]};
@GUID(0x42195949, 0x3B79, 0x4FC8, [0x89, 0xC6, 0xFC, 0x7F, 0xB9, 0x79, 0xEE, 0x71]);
interface IOpcPart : IUnknown
{
    HRESULT GetRelationshipSet(IOpcRelationshipSet* relationshipSet);
    HRESULT GetContentStream(IStream* stream);
    HRESULT GetName(IOpcPartUri* name);
    HRESULT GetContentType(ushort** contentType);
    HRESULT GetCompressionOptions(OPC_COMPRESSION_OPTIONS* compressionOptions);
}

const GUID IID_IOpcRelationship = {0x42195949, 0x3B79, 0x4FC8, [0x89, 0xC6, 0xFC, 0x7F, 0xB9, 0x79, 0xEE, 0x72]};
@GUID(0x42195949, 0x3B79, 0x4FC8, [0x89, 0xC6, 0xFC, 0x7F, 0xB9, 0x79, 0xEE, 0x72]);
interface IOpcRelationship : IUnknown
{
    HRESULT GetId(ushort** relationshipIdentifier);
    HRESULT GetRelationshipType(ushort** relationshipType);
    HRESULT GetSourceUri(IOpcUri* sourceUri);
    HRESULT GetTargetUri(IUri* targetUri);
    HRESULT GetTargetMode(OPC_URI_TARGET_MODE* targetMode);
}

const GUID IID_IOpcPartSet = {0x42195949, 0x3B79, 0x4FC8, [0x89, 0xC6, 0xFC, 0x7F, 0xB9, 0x79, 0xEE, 0x73]};
@GUID(0x42195949, 0x3B79, 0x4FC8, [0x89, 0xC6, 0xFC, 0x7F, 0xB9, 0x79, 0xEE, 0x73]);
interface IOpcPartSet : IUnknown
{
    HRESULT GetPart(IOpcPartUri name, IOpcPart* part);
    HRESULT CreatePart(IOpcPartUri name, const(wchar)* contentType, OPC_COMPRESSION_OPTIONS compressionOptions, IOpcPart* part);
    HRESULT DeletePart(IOpcPartUri name);
    HRESULT PartExists(IOpcPartUri name, int* partExists);
    HRESULT GetEnumerator(IOpcPartEnumerator* partEnumerator);
}

const GUID IID_IOpcRelationshipSet = {0x42195949, 0x3B79, 0x4FC8, [0x89, 0xC6, 0xFC, 0x7F, 0xB9, 0x79, 0xEE, 0x74]};
@GUID(0x42195949, 0x3B79, 0x4FC8, [0x89, 0xC6, 0xFC, 0x7F, 0xB9, 0x79, 0xEE, 0x74]);
interface IOpcRelationshipSet : IUnknown
{
    HRESULT GetRelationship(const(wchar)* relationshipIdentifier, IOpcRelationship* relationship);
    HRESULT CreateRelationship(const(wchar)* relationshipIdentifier, const(wchar)* relationshipType, IUri targetUri, OPC_URI_TARGET_MODE targetMode, IOpcRelationship* relationship);
    HRESULT DeleteRelationship(const(wchar)* relationshipIdentifier);
    HRESULT RelationshipExists(const(wchar)* relationshipIdentifier, int* relationshipExists);
    HRESULT GetEnumerator(IOpcRelationshipEnumerator* relationshipEnumerator);
    HRESULT GetEnumeratorForType(const(wchar)* relationshipType, IOpcRelationshipEnumerator* relationshipEnumerator);
    HRESULT GetRelationshipsContentStream(IStream* contents);
}

const GUID IID_IOpcPartEnumerator = {0x42195949, 0x3B79, 0x4FC8, [0x89, 0xC6, 0xFC, 0x7F, 0xB9, 0x79, 0xEE, 0x75]};
@GUID(0x42195949, 0x3B79, 0x4FC8, [0x89, 0xC6, 0xFC, 0x7F, 0xB9, 0x79, 0xEE, 0x75]);
interface IOpcPartEnumerator : IUnknown
{
    HRESULT MoveNext(int* hasNext);
    HRESULT MovePrevious(int* hasPrevious);
    HRESULT GetCurrent(IOpcPart* part);
    HRESULT Clone(IOpcPartEnumerator* copy);
}

const GUID IID_IOpcRelationshipEnumerator = {0x42195949, 0x3B79, 0x4FC8, [0x89, 0xC6, 0xFC, 0x7F, 0xB9, 0x79, 0xEE, 0x76]};
@GUID(0x42195949, 0x3B79, 0x4FC8, [0x89, 0xC6, 0xFC, 0x7F, 0xB9, 0x79, 0xEE, 0x76]);
interface IOpcRelationshipEnumerator : IUnknown
{
    HRESULT MoveNext(int* hasNext);
    HRESULT MovePrevious(int* hasPrevious);
    HRESULT GetCurrent(IOpcRelationship* relationship);
    HRESULT Clone(IOpcRelationshipEnumerator* copy);
}

const GUID IID_IOpcSignaturePartReference = {0xE24231CA, 0x59F4, 0x484E, [0xB6, 0x4B, 0x36, 0xEE, 0xDA, 0x36, 0x07, 0x2C]};
@GUID(0xE24231CA, 0x59F4, 0x484E, [0xB6, 0x4B, 0x36, 0xEE, 0xDA, 0x36, 0x07, 0x2C]);
interface IOpcSignaturePartReference : IUnknown
{
    HRESULT GetPartName(IOpcPartUri* partName);
    HRESULT GetContentType(ushort** contentType);
    HRESULT GetDigestMethod(ushort** digestMethod);
    HRESULT GetDigestValue(char* digestValue, uint* count);
    HRESULT GetTransformMethod(OPC_CANONICALIZATION_METHOD* transformMethod);
}

const GUID IID_IOpcSignatureRelationshipReference = {0x57BABAC6, 0x9D4A, 0x4E50, [0x8B, 0x86, 0xE5, 0xD4, 0x05, 0x1E, 0xAE, 0x7C]};
@GUID(0x57BABAC6, 0x9D4A, 0x4E50, [0x8B, 0x86, 0xE5, 0xD4, 0x05, 0x1E, 0xAE, 0x7C]);
interface IOpcSignatureRelationshipReference : IUnknown
{
    HRESULT GetSourceUri(IOpcUri* sourceUri);
    HRESULT GetDigestMethod(ushort** digestMethod);
    HRESULT GetDigestValue(char* digestValue, uint* count);
    HRESULT GetTransformMethod(OPC_CANONICALIZATION_METHOD* transformMethod);
    HRESULT GetRelationshipSigningOption(OPC_RELATIONSHIPS_SIGNING_OPTION* relationshipSigningOption);
    HRESULT GetRelationshipSelectorEnumerator(IOpcRelationshipSelectorEnumerator* selectorEnumerator);
}

const GUID IID_IOpcRelationshipSelector = {0xF8F26C7F, 0xB28F, 0x4899, [0x84, 0xC8, 0x5D, 0x56, 0x39, 0xED, 0xE7, 0x5F]};
@GUID(0xF8F26C7F, 0xB28F, 0x4899, [0x84, 0xC8, 0x5D, 0x56, 0x39, 0xED, 0xE7, 0x5F]);
interface IOpcRelationshipSelector : IUnknown
{
    HRESULT GetSelectorType(OPC_RELATIONSHIP_SELECTOR* selector);
    HRESULT GetSelectionCriterion(ushort** selectionCriterion);
}

const GUID IID_IOpcSignatureReference = {0x1B47005E, 0x3011, 0x4EDC, [0xBE, 0x6F, 0x0F, 0x65, 0xE5, 0xAB, 0x03, 0x42]};
@GUID(0x1B47005E, 0x3011, 0x4EDC, [0xBE, 0x6F, 0x0F, 0x65, 0xE5, 0xAB, 0x03, 0x42]);
interface IOpcSignatureReference : IUnknown
{
    HRESULT GetId(ushort** referenceId);
    HRESULT GetUri(IUri* referenceUri);
    HRESULT GetType(ushort** type);
    HRESULT GetTransformMethod(OPC_CANONICALIZATION_METHOD* transformMethod);
    HRESULT GetDigestMethod(ushort** digestMethod);
    HRESULT GetDigestValue(char* digestValue, uint* count);
}

const GUID IID_IOpcSignatureCustomObject = {0x5D77A19E, 0x62C1, 0x44E7, [0xBE, 0xCD, 0x45, 0xDA, 0x5A, 0xE5, 0x1A, 0x56]};
@GUID(0x5D77A19E, 0x62C1, 0x44E7, [0xBE, 0xCD, 0x45, 0xDA, 0x5A, 0xE5, 0x1A, 0x56]);
interface IOpcSignatureCustomObject : IUnknown
{
    HRESULT GetXml(char* xmlMarkup, uint* count);
}

const GUID IID_IOpcDigitalSignature = {0x52AB21DD, 0x1CD0, 0x4949, [0xBC, 0x80, 0x0C, 0x12, 0x32, 0xD0, 0x0C, 0xB4]};
@GUID(0x52AB21DD, 0x1CD0, 0x4949, [0xBC, 0x80, 0x0C, 0x12, 0x32, 0xD0, 0x0C, 0xB4]);
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

const GUID IID_IOpcSigningOptions = {0x50D2D6A5, 0x7AEB, 0x46C0, [0xB2, 0x41, 0x43, 0xAB, 0x0E, 0x9B, 0x40, 0x7E]};
@GUID(0x50D2D6A5, 0x7AEB, 0x46C0, [0xB2, 0x41, 0x43, 0xAB, 0x0E, 0x9B, 0x40, 0x7E]);
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

const GUID IID_IOpcDigitalSignatureManager = {0xD5E62A0B, 0x696D, 0x462F, [0x94, 0xDF, 0x72, 0xE3, 0x3C, 0xEF, 0x26, 0x59]};
@GUID(0xD5E62A0B, 0x696D, 0x462F, [0x94, 0xDF, 0x72, 0xE3, 0x3C, 0xEF, 0x26, 0x59]);
interface IOpcDigitalSignatureManager : IUnknown
{
    HRESULT GetSignatureOriginPartName(IOpcPartUri* signatureOriginPartName);
    HRESULT SetSignatureOriginPartName(IOpcPartUri signatureOriginPartName);
    HRESULT GetSignatureEnumerator(IOpcDigitalSignatureEnumerator* signatureEnumerator);
    HRESULT RemoveSignature(IOpcPartUri signaturePartName);
    HRESULT CreateSigningOptions(IOpcSigningOptions* signingOptions);
    HRESULT Validate(IOpcDigitalSignature signature, const(CERT_CONTEXT)* certificate, OPC_SIGNATURE_VALIDATION_RESULT* validationResult);
    HRESULT Sign(const(CERT_CONTEXT)* certificate, IOpcSigningOptions signingOptions, IOpcDigitalSignature* digitalSignature);
    HRESULT ReplaceSignatureXml(IOpcPartUri signaturePartName, const(ubyte)* newSignatureXml, uint count, IOpcDigitalSignature* digitalSignature);
}

const GUID IID_IOpcSignaturePartReferenceEnumerator = {0x80EB1561, 0x8C77, 0x49CF, [0x82, 0x66, 0x45, 0x9B, 0x35, 0x6E, 0xE9, 0x9A]};
@GUID(0x80EB1561, 0x8C77, 0x49CF, [0x82, 0x66, 0x45, 0x9B, 0x35, 0x6E, 0xE9, 0x9A]);
interface IOpcSignaturePartReferenceEnumerator : IUnknown
{
    HRESULT MoveNext(int* hasNext);
    HRESULT MovePrevious(int* hasPrevious);
    HRESULT GetCurrent(IOpcSignaturePartReference* partReference);
    HRESULT Clone(IOpcSignaturePartReferenceEnumerator* copy);
}

const GUID IID_IOpcSignatureRelationshipReferenceEnumerator = {0x773BA3E4, 0xF021, 0x48E4, [0xAA, 0x04, 0x98, 0x16, 0xDB, 0x5D, 0x34, 0x95]};
@GUID(0x773BA3E4, 0xF021, 0x48E4, [0xAA, 0x04, 0x98, 0x16, 0xDB, 0x5D, 0x34, 0x95]);
interface IOpcSignatureRelationshipReferenceEnumerator : IUnknown
{
    HRESULT MoveNext(int* hasNext);
    HRESULT MovePrevious(int* hasPrevious);
    HRESULT GetCurrent(IOpcSignatureRelationshipReference* relationshipReference);
    HRESULT Clone(IOpcSignatureRelationshipReferenceEnumerator* copy);
}

const GUID IID_IOpcRelationshipSelectorEnumerator = {0x5E50A181, 0xA91B, 0x48AC, [0x88, 0xD2, 0xBC, 0xA3, 0xD8, 0xF8, 0xC0, 0xB1]};
@GUID(0x5E50A181, 0xA91B, 0x48AC, [0x88, 0xD2, 0xBC, 0xA3, 0xD8, 0xF8, 0xC0, 0xB1]);
interface IOpcRelationshipSelectorEnumerator : IUnknown
{
    HRESULT MoveNext(int* hasNext);
    HRESULT MovePrevious(int* hasPrevious);
    HRESULT GetCurrent(IOpcRelationshipSelector* relationshipSelector);
    HRESULT Clone(IOpcRelationshipSelectorEnumerator* copy);
}

const GUID IID_IOpcSignatureReferenceEnumerator = {0xCFA59A45, 0x28B1, 0x4868, [0x96, 0x9E, 0xFA, 0x80, 0x97, 0xFD, 0xC1, 0x2A]};
@GUID(0xCFA59A45, 0x28B1, 0x4868, [0x96, 0x9E, 0xFA, 0x80, 0x97, 0xFD, 0xC1, 0x2A]);
interface IOpcSignatureReferenceEnumerator : IUnknown
{
    HRESULT MoveNext(int* hasNext);
    HRESULT MovePrevious(int* hasPrevious);
    HRESULT GetCurrent(IOpcSignatureReference* reference);
    HRESULT Clone(IOpcSignatureReferenceEnumerator* copy);
}

const GUID IID_IOpcSignatureCustomObjectEnumerator = {0x5EE4FE1D, 0xE1B0, 0x4683, [0x80, 0x79, 0x7E, 0xA0, 0xFC, 0xF8, 0x0B, 0x4C]};
@GUID(0x5EE4FE1D, 0xE1B0, 0x4683, [0x80, 0x79, 0x7E, 0xA0, 0xFC, 0xF8, 0x0B, 0x4C]);
interface IOpcSignatureCustomObjectEnumerator : IUnknown
{
    HRESULT MoveNext(int* hasNext);
    HRESULT MovePrevious(int* hasPrevious);
    HRESULT GetCurrent(IOpcSignatureCustomObject* customObject);
    HRESULT Clone(IOpcSignatureCustomObjectEnumerator* copy);
}

const GUID IID_IOpcCertificateEnumerator = {0x85131937, 0x8F24, 0x421F, [0xB4, 0x39, 0x59, 0xAB, 0x24, 0xD1, 0x40, 0xB8]};
@GUID(0x85131937, 0x8F24, 0x421F, [0xB4, 0x39, 0x59, 0xAB, 0x24, 0xD1, 0x40, 0xB8]);
interface IOpcCertificateEnumerator : IUnknown
{
    HRESULT MoveNext(int* hasNext);
    HRESULT MovePrevious(int* hasPrevious);
    HRESULT GetCurrent(const(CERT_CONTEXT)** certificate);
    HRESULT Clone(IOpcCertificateEnumerator* copy);
}

const GUID IID_IOpcDigitalSignatureEnumerator = {0x967B6882, 0x0BA3, 0x4358, [0xB9, 0xE7, 0xB6, 0x4C, 0x75, 0x06, 0x3C, 0x5E]};
@GUID(0x967B6882, 0x0BA3, 0x4358, [0xB9, 0xE7, 0xB6, 0x4C, 0x75, 0x06, 0x3C, 0x5E]);
interface IOpcDigitalSignatureEnumerator : IUnknown
{
    HRESULT MoveNext(int* hasNext);
    HRESULT MovePrevious(int* hasPrevious);
    HRESULT GetCurrent(IOpcDigitalSignature* digitalSignature);
    HRESULT Clone(IOpcDigitalSignatureEnumerator* copy);
}

const GUID IID_IOpcSignaturePartReferenceSet = {0x6C9FE28C, 0xECD9, 0x4B22, [0x9D, 0x36, 0x7F, 0xDD, 0xE6, 0x70, 0xFE, 0xC0]};
@GUID(0x6C9FE28C, 0xECD9, 0x4B22, [0x9D, 0x36, 0x7F, 0xDD, 0xE6, 0x70, 0xFE, 0xC0]);
interface IOpcSignaturePartReferenceSet : IUnknown
{
    HRESULT Create(IOpcPartUri partUri, const(wchar)* digestMethod, OPC_CANONICALIZATION_METHOD transformMethod, IOpcSignaturePartReference* partReference);
    HRESULT Delete(IOpcSignaturePartReference partReference);
    HRESULT GetEnumerator(IOpcSignaturePartReferenceEnumerator* partReferenceEnumerator);
}

const GUID IID_IOpcSignatureRelationshipReferenceSet = {0x9F863CA5, 0x3631, 0x404C, [0x82, 0x8D, 0x80, 0x7E, 0x07, 0x15, 0x06, 0x9B]};
@GUID(0x9F863CA5, 0x3631, 0x404C, [0x82, 0x8D, 0x80, 0x7E, 0x07, 0x15, 0x06, 0x9B]);
interface IOpcSignatureRelationshipReferenceSet : IUnknown
{
    HRESULT Create(IOpcUri sourceUri, const(wchar)* digestMethod, OPC_RELATIONSHIPS_SIGNING_OPTION relationshipSigningOption, IOpcRelationshipSelectorSet selectorSet, OPC_CANONICALIZATION_METHOD transformMethod, IOpcSignatureRelationshipReference* relationshipReference);
    HRESULT CreateRelationshipSelectorSet(IOpcRelationshipSelectorSet* selectorSet);
    HRESULT Delete(IOpcSignatureRelationshipReference relationshipReference);
    HRESULT GetEnumerator(IOpcSignatureRelationshipReferenceEnumerator* relationshipReferenceEnumerator);
}

const GUID IID_IOpcRelationshipSelectorSet = {0x6E34C269, 0xA4D3, 0x47C0, [0xB5, 0xC4, 0x87, 0xFF, 0x2B, 0x3B, 0x61, 0x36]};
@GUID(0x6E34C269, 0xA4D3, 0x47C0, [0xB5, 0xC4, 0x87, 0xFF, 0x2B, 0x3B, 0x61, 0x36]);
interface IOpcRelationshipSelectorSet : IUnknown
{
    HRESULT Create(OPC_RELATIONSHIP_SELECTOR selector, const(wchar)* selectionCriterion, IOpcRelationshipSelector* relationshipSelector);
    HRESULT Delete(IOpcRelationshipSelector relationshipSelector);
    HRESULT GetEnumerator(IOpcRelationshipSelectorEnumerator* relationshipSelectorEnumerator);
}

const GUID IID_IOpcSignatureReferenceSet = {0xF3B02D31, 0xAB12, 0x42DD, [0x9E, 0x2F, 0x2B, 0x16, 0x76, 0x1C, 0x3C, 0x1E]};
@GUID(0xF3B02D31, 0xAB12, 0x42DD, [0x9E, 0x2F, 0x2B, 0x16, 0x76, 0x1C, 0x3C, 0x1E]);
interface IOpcSignatureReferenceSet : IUnknown
{
    HRESULT Create(IUri referenceUri, const(wchar)* referenceId, const(wchar)* type, const(wchar)* digestMethod, OPC_CANONICALIZATION_METHOD transformMethod, IOpcSignatureReference* reference);
    HRESULT Delete(IOpcSignatureReference reference);
    HRESULT GetEnumerator(IOpcSignatureReferenceEnumerator* referenceEnumerator);
}

const GUID IID_IOpcSignatureCustomObjectSet = {0x8F792AC5, 0x7947, 0x4E11, [0xBC, 0x3D, 0x26, 0x59, 0xFF, 0x04, 0x6A, 0xE1]};
@GUID(0x8F792AC5, 0x7947, 0x4E11, [0xBC, 0x3D, 0x26, 0x59, 0xFF, 0x04, 0x6A, 0xE1]);
interface IOpcSignatureCustomObjectSet : IUnknown
{
    HRESULT Create(char* xmlMarkup, uint count, IOpcSignatureCustomObject* customObject);
    HRESULT Delete(IOpcSignatureCustomObject customObject);
    HRESULT GetEnumerator(IOpcSignatureCustomObjectEnumerator* customObjectEnumerator);
}

const GUID IID_IOpcCertificateSet = {0x56EA4325, 0x8E2D, 0x4167, [0xB1, 0xA4, 0xE4, 0x86, 0xD2, 0x4C, 0x8F, 0xA7]};
@GUID(0x56EA4325, 0x8E2D, 0x4167, [0xB1, 0xA4, 0xE4, 0x86, 0xD2, 0x4C, 0x8F, 0xA7]);
interface IOpcCertificateSet : IUnknown
{
    HRESULT Add(const(CERT_CONTEXT)* certificate);
    HRESULT Remove(const(CERT_CONTEXT)* certificate);
    HRESULT GetEnumerator(IOpcCertificateEnumerator* certificateEnumerator);
}

const GUID IID_IOpcFactory = {0x6D0B4446, 0xCD73, 0x4AB3, [0x94, 0xF4, 0x8C, 0xCD, 0xF6, 0x11, 0x61, 0x54]};
@GUID(0x6D0B4446, 0xCD73, 0x4AB3, [0x94, 0xF4, 0x8C, 0xCD, 0xF6, 0x11, 0x61, 0x54]);
interface IOpcFactory : IUnknown
{
    HRESULT CreatePackageRootUri(IOpcUri* rootUri);
    HRESULT CreatePartUri(const(wchar)* pwzUri, IOpcPartUri* partUri);
    HRESULT CreateStreamOnFile(const(wchar)* filename, OPC_STREAM_IO_MODE ioMode, SECURITY_ATTRIBUTES* securityAttributes, uint dwFlagsAndAttributes, IStream* stream);
    HRESULT CreatePackage(IOpcPackage* package);
    HRESULT ReadPackageFromStream(IStream stream, OPC_READ_FLAGS flags, IOpcPackage* package);
    HRESULT WritePackageToStream(IOpcPackage package, OPC_WRITE_FLAGS flags, IStream stream);
    HRESULT CreateDigitalSignatureManager(IOpcPackage package, IOpcDigitalSignatureManager* signatureManager);
}

