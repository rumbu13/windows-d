// Written in the D programming language.

module windows.packaging;

public import windows.core;
public import windows.com : HRESULT, IUnknown, IUri;
public import windows.security : CERT_CONTEXT;
public import windows.structuredstorage : IStream;
public import windows.systemservices : SECURITY_ATTRIBUTES;

extern(Windows):


// Enums


///Indicates the target mode of a relationship.
alias OPC_URI_TARGET_MODE = int;
enum : int
{
    ///The target of the relationship is a part inside the package.
    OPC_URI_TARGET_MODE_INTERNAL = 0x00000000,
    ///The target of the relationship is a resource outside of the package.
    OPC_URI_TARGET_MODE_EXTERNAL = 0x00000001,
}

///Describes ways to compress part content.
alias OPC_COMPRESSION_OPTIONS = int;
enum : int
{
    ///Compression is turned off.
    OPC_COMPRESSION_NONE      = 0xffffffff,
    ///Compression is optimized for a balance between size and performance.
    OPC_COMPRESSION_NORMAL    = 0x00000000,
    ///Compression is optimized for size.
    OPC_COMPRESSION_MAXIMUM   = 0x00000001,
    ///Compression is optimized for performance.
    OPC_COMPRESSION_FAST      = 0x00000002,
    ///Compression is optimized for high performance.
    OPC_COMPRESSION_SUPERFAST = 0x00000003,
}

///Describes the read/write status of a stream.
alias OPC_STREAM_IO_MODE = int;
enum : int
{
    ///Creates a read-only stream for loading an existing package.
    OPC_STREAM_IO_READ  = 0x00000001,
    ///Creates a write-only stream for saving a new package.
    OPC_STREAM_IO_WRITE = 0x00000002,
}

///Describes the read settings for caching package components and validating them against <i>ECMA-376 OpenXML, 1st
///Edition, Part 2: Open Packaging Conventions (OPC)</i> conformance requirements.
alias OPC_READ_FLAGS = int;
enum : int
{
    ///Validate a package component against <i>OPC</i> conformance requirements when the component is accessed. For more
    ///information about <i>OPC</i> conformance validation, see Remarks. When validation is performed on access,
    ///<i>OPC</i> validation errors can be returned by any method.
    OPC_READ_DEFAULT     = 0x00000000,
    ///Validate all package components against <i>OPC</i> conformance requirements when a package is loaded. For more
    ///information about <i>OPC</i> conformance validation, see Remarks. If this setting is enabled, performance costs
    ///for loading and validating package components are paid when the package is first loaded.
    OPC_VALIDATE_ON_LOAD = 0x00000001,
    ///Cache decompressed package component data as a temp file when accessing the component for the first time. When a
    ///package component is accessed repeatedly, this caching reduces overhead because the component data is
    ///decompressed one time for the first read instead of once for every read operation.
    OPC_CACHE_ON_ACCESS  = 0x00000002,
}

///Describes the encoding method that is used by the serialization object to produce the package.
alias OPC_WRITE_FLAGS = int;
enum : int
{
    ///Use Zip64 encoding. The minimum software version for extracting a package with Zip64 encoding is 4.5.
    OPC_WRITE_DEFAULT     = 0x00000000,
    ///Force Zip32 encoding. The minimum software version for extracting a package with Zip32 encoding is 2.0. If one or
    ///more of the following Zip32 limitations are violated, the package write will fail:<ul> <li>The maximum size for a
    ///single, uncompressed file item is 4 gigabytes.</li> <li>The maximum number of file items is 65535
    ///(2¹⁶-1).</li> </ul>
    OPC_WRITE_FORCE_ZIP32 = 0x00000001,
}

///Indicates the status of the signature.
alias OPC_SIGNATURE_VALIDATION_RESULT = int;
enum : int
{
    ///The signature is valid. Signature validation using the provided certificate succeeded; signed package components
    ///have not been altered. <div class="alert"><b>Important</b> Signature trust decisions must be based on the
    ///validity of the signature as well as other format- and application-specific factors, including: validation of the
    ///identity of the package originator, signing policy, certificate quality, and possibly the existence of a valid
    ///time stamp.</div> <div> </div>
    OPC_SIGNATURE_VALID   = 0x00000000,
    ///The signature is not valid. Signature markup or signed package components might have been altered. Alternatively,
    ///the signature might not exist in the current package.
    OPC_SIGNATURE_INVALID = 0xffffffff,
}

///Describes the canonicalization method to be applied to XML markup.
alias OPC_CANONICALIZATION_METHOD = int;
enum : int
{
    ///No canonicalization method is applied.
    OPC_CANONICALIZATION_NONE               = 0x00000000,
    ///The C14N canonicalization method that removes comments is applied.
    OPC_CANONICALIZATION_C14N               = 0x00000001,
    ///The C14N canonicalization method that preserves comments is applied.
    OPC_CANONICALIZATION_C14N_WITH_COMMENTS = 0x00000002,
}

///Describes how to interpret the <i>selectionCriterion</i> parameter of the
///IOpcRelationshipSelector::GetSelectionCriterion method.
alias OPC_RELATIONSHIP_SELECTOR = int;
enum : int
{
    ///The <i>selectionCriterion</i> parameter is a relationship identifier.
    OPC_RELATIONSHIP_SELECT_BY_ID   = 0x00000000,
    ///The <i>selectionCriterion</i> parameter is a relationship type.
    OPC_RELATIONSHIP_SELECT_BY_TYPE = 0x00000001,
}

///Describes whether a reference represented by the IOpcSignatureRelationshipReference interface refers to all or a
///subset of relationships represented as relationship objects in a relationship set object.
alias OPC_RELATIONSHIPS_SIGNING_OPTION = int;
enum : int
{
    ///The reference refers to a subset of relationships represented as relationship objects and identified using the
    ///IOpcRelationshipSelectorSet interface.
    OPC_RELATIONSHIP_SIGN_USING_SELECTORS = 0x00000000,
    ///The reference refers to all of the relationships represented as relationship objects in the relationship set
    ///object.
    OPC_RELATIONSHIP_SIGN_PART            = 0x00000001,
}

///Describes the storage location of a certificate that is used in signing.
alias OPC_CERTIFICATE_EMBEDDING_OPTION = int;
enum : int
{
    ///The certificate is stored in a part specific to the certificate.
    OPC_CERTIFICATE_IN_CERTIFICATE_PART = 0x00000000,
    ///The certificate is encoded within the signature markup in the Signature part.
    OPC_CERTIFICATE_IN_SIGNATURE_PART   = 0x00000001,
    ///The certificate is not stored in the package. <div class="alert"><b>Important</b> The certificate is contextual
    ///and understood between the signer and the verifier.</div> <div> </div>
    OPC_CERTIFICATE_NOT_EMBEDDED        = 0x00000002,
}

///Describes how to interpret the <i>signingTime</i> parameter, which is a record of when a signature was created, of
///the IOpcDigitalSignature::GetSigningTime method.
alias OPC_SIGNATURE_TIME_FORMAT = int;
enum : int
{
    ///The format is the complete date with hours, minutes, and seconds expressed as a decimal fraction. Syntax:
    ///<i>YYYY</i>-<i>MM</i>-<i>DD</i>T<i>hh</i>:<i>mm</i>:<i>ss</i>.<i>s</i><i>TZD</i> A value of
    ///"2010-03-09T18:45:32.3-08:00" would represent 6:45:32.3 P.M. on March 9, 2010 Pacific Time.
    OPC_SIGNATURE_TIME_FORMAT_MILLISECONDS = 0x00000000,
    ///The format is the complete date with hours, minutes, and seconds. Syntax:
    ///<i>YYYY</i>-<i>MM</i>-<i>DD</i>T<i>hh</i>:<i>mm</i>:<i>ss</i><i>TZD</i> A value of "2010-03-09T18:45:32-08:00"
    ///would represent 6:45:32 P.M. on March 9, 2010 Pacific Time.
    OPC_SIGNATURE_TIME_FORMAT_SECONDS      = 0x00000001,
    ///The format is the complete date with hours and minutes. Syntax:
    ///<i>YYYY</i>-<i>MM</i>-<i>DD</i>T<i>hh</i>:<i>mm</i><i>TZD</i> A value of "2010-03-09T18:45-08:00" would represent
    ///6:45 P.M. on March 9, 2010 Pacific Time.
    OPC_SIGNATURE_TIME_FORMAT_MINUTES      = 0x00000002,
    ///The format is the complete date. Syntax: <i>YYYY</i>-<i>MM</i>-<i>DD</i> A value of "2010-03-09" would represent
    ///March 9, 2010.
    OPC_SIGNATURE_TIME_FORMAT_DAYS         = 0x00000003,
    ///The format is the year and month. Syntax: <i>YYYY</i>-<i>MM</i> A value of "2010-03" would represent March, 2010.
    OPC_SIGNATURE_TIME_FORMAT_MONTHS       = 0x00000004,
    ///The format is the year. Syntax: <i>YYYY</i> A value of "2010" would represent 2010.
    OPC_SIGNATURE_TIME_FORMAT_YEARS        = 0x00000005,
}

// Interfaces

@GUID("6B2D6BA0-9F3E-4F27-920B-313CC426A39E")
struct OpcFactory;

///Represents the URI of the package root or of a part that is relative to the package root.
@GUID("BC9C1B9B-D62C-49EB-AEF0-3B4E0B28EBED")
interface IOpcUri : IUri
{
    ///Gets the part name of the Relationships part that stores relationships that have the source URI represented by
    ///the current OPC URI object.
    ///Params:
    ///    relationshipPartUri = A pointer to the IOpcPartUri interface of the part URI object that represents the part name of the
    ///                          Relationships part. The source URI of the relationships stored in this Relationships part is represented by
    ///                          the current OPC URI object.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> The <i>relationshipPartUri</i> parameter is
    ///    <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>OPC_E_NONCONFORMING_URI</b></dt>
    ///    <dt>0x80510001</dt> </dl> </td> <td width="60%"> The current IOpcUri represents a Relationships part and
    ///    cannot be the source of any relationships. </td> </tr> <tr> <td width="40%"> <dl> <dt><b><b>CreateUri</b>
    ///    function error </b></dt> </dl> </td> <td width="60%"> An <b>HRESULT</b> error code from the CreateUri
    ///    function. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>WinINet error </b></dt> </dl> </td> <td width="60%">
    ///    An <b>HRESULT</b> error code from a WinINet API. </td> </tr> </table>
    ///    
    HRESULT GetRelationshipsPartUri(IOpcPartUri* relationshipPartUri);
    ///Forms a relative URI for a specified part, relative to the URI represented by the current OPC URI object.
    ///Params:
    ///    targetPartUri = A pointer to the IOpcPartUri interface of the part URI object that represents the part name from which the
    ///                    relative URI is formed.
    ///    relativeUri = A pointer to the IUri interface of the URI of the part, relative to the current OPC URI object.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> At least one of the <i>targetPartUri</i>, and
    ///    <i>relativePartUri</i> parameters is <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b><b>CreateUri</b> function error</b></dt> </dl> </td> <td width="60%"> An <b>HRESULT</b> error code
    ///    from the CreateUri function. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>WinINet error</b></dt> </dl> </td>
    ///    <td width="60%"> An <b>HRESULT</b> error code from a WinINet API. </td> </tr> </table>
    ///    
    HRESULT GetRelativeUri(IOpcPartUri targetPartUri, IUri* relativeUri);
    ///Forms the part name of the part that is referenced by the specified relative URI. The specified relative URI of
    ///the part is resolved against the URI represented as the current OPC URI object.
    ///Params:
    ///    relativeUri = A pointer to the IUri interface of the relative URI of the part. To form the part URI object that represents
    ///                  the part name, this input URI is resolved against the URI represented as the current OPC URI object.
    ///                  Therefore, the input URI must be relative to the URI represented by the current OPC URI object. This URI may
    ///                  include a fragment component; however, the fragment will be ignored and will not be included in the part name
    ///                  to be formed. A fragment component is preceded by a '
    ///    combinedUri = A pointer to the IOpcPartUri interface of the part URI object that represents the part name. The part URI
    ///                  object is formed by resolving the relative URI in <i>relativeUri</i> against the URI represented by the
    ///                  current OPC URI object.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> The CoInternetCombineUrl function returned an
    ///    invalid size. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%">
    ///    At least one of the <i>relativeUri</i>, and <i>combinedUri</i> parameters is <b>NULL</b>. </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>E_UNEXPECTED</b></dt> </dl> </td> <td width="60%"> The size of the buffer
    ///    required by the CoInternetCombineUrl function changed unexpectedly. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>OPC_E_NONCONFORMING_URI</b></dt> <dt>0x80510001</dt> </dl> </td> <td width="60%"> The part name does
    ///    not conform to the rules specified in the <i>OPC</i> standards. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>OPC_E_RELATIVE_URI_REQUIRED</b></dt> <dt>0x80510002</dt> </dl> </td> <td width="60%"> A part name
    ///    cannot be an absolute URI. An absolute URI begins with a schema component followed by a ":", as described in
    ///    RFC 3986: URI Generic Syntax. </td> </tr> <tr> <td width="40%"> <dl> <dt><b><b>CoInternetCombineUrl</b>
    ///    function error </b></dt> </dl> </td> <td width="60%"> An <b>HRESULT</b> error code from the
    ///    CoInternetCombineUrl function. </td> </tr> <tr> <td width="40%"> <dl> <dt><b><b>CreateUri</b> function error
    ///    </b></dt> </dl> </td> <td width="60%"> An <b>HRESULT</b> error code from the CreateUri function. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>WinINet error </b></dt> </dl> </td> <td width="60%"> An <b>HRESULT</b>
    ///    error code from a WinINet API. </td> </tr> </table>
    ///    
    HRESULT CombinePartUri(IUri relativeUri, IOpcPartUri* combinedUri);
}

///Represents the part name of a part. If the part is a Relationships part, it is represented by the IOpcRelationshipSet
///interface; otherwise, it is represented by the IOpcPart interface.
@GUID("7D3BABE7-88B2-46BA-85CB-4203CB016C87")
interface IOpcPartUri : IOpcUri
{
    ///Returns an integer that indicates whether the URIs represented by the current part URI object and a specified
    ///part URI object are equivalent.
    ///Params:
    ///    partUri = A pointer to the IOpcPartUri interface of the part URI object to compare with the current part URI object.
    ///    comparisonResult = Receives an integer that indicates whether the two part URI objects are equivalent. <table> <tr>
    ///                       <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt>&lt;0</dt> </dl> </td> <td width="60%">
    ///                       The current part URI object is less than the input part URI object that is passed in <i>partUri</i>. </td>
    ///                       </tr> <tr> <td width="40%"> <dl> <dt>0</dt> </dl> </td> <td width="60%"> The current part URI object is
    ///                       equivalent to the input part URI object that is passed in <i>partUri</i>. </td> </tr> <tr> <td width="40%">
    ///                       <dl> <dt>&gt;0</dt> </dl> </td> <td width="60%"> The current part URI object is greater than the input part
    ///                       URI object that is passed in <i>partUri</i>. </td> </tr> </table>
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> At least one of the <i>partUri</i>, and
    ///    <i>comparisonResult</i> parameters is <b>NULL</b>. </td> </tr> </table>
    ///    
    HRESULT ComparePartUri(IOpcPartUri partUri, int* comparisonResult);
    ///Gets the source URI of the relationships that are stored in a Relationships part. The current part URI object
    ///represents the part name of that Relationships part.
    ///Params:
    ///    sourceUri = A pointer to the IOpcUri interface of the OPC URI object that represents the URI of the source of the
    ///                relationships stored in the Relationships part.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> The <i>sourceUri</i> parameter is <b>NULL</b>.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>OPC_E_RELATIONSHIP_URI_REQUIRED</b></dt> <dt>0x80510003</dt>
    ///    </dl> </td> <td width="60%"> The part name of a Relationships part is required, but the part name is not that
    ///    of a Relationships part. For more information about the part names of Relationships parts, see the
    ///    <i>OPC</i>. </td> </tr> <tr> <td width="40%"> <dl> <dt><b><b>CreateUri</b> function error </b></dt> </dl>
    ///    </td> <td width="60%"> An <b>HRESULT</b> error code from the CreateUri function. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>WinINet error </b></dt> </dl> </td> <td width="60%"> An <b>HRESULT</b> error code
    ///    from a WinINet API. </td> </tr> </table>
    ///    
    HRESULT GetSourceUri(IOpcUri* sourceUri);
    ///Returns a value that indicates whether the current part URI object represents the part name of a Relationships
    ///part.
    ///Params:
    ///    isRelationshipUri = Receives a value that indicates whether the current part URI object represents the part name of a
    ///                        Relationships part. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl>
    ///                        <dt><b>TRUE</b></dt> </dl> </td> <td width="60%"> The current part URI object represents the part name of a
    ///                        Relationships part. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>FALSE</b></dt> </dl> </td> <td width="60%">
    ///                        The current part URI object does not represent the part name of a Relationships part. </td> </tr> </table>
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> The <i>isRelationshipUri</i> parameter is
    ///    <b>NULL</b>. </td> </tr> </table>
    ///    
    HRESULT IsRelationshipsPartUri(int* isRelationshipUri);
}

///Represents a package and provides methods to access the package's parts and relationships.
@GUID("42195949-3B79-4FC8-89C6-FC7FB979EE70")
interface IOpcPackage : IUnknown
{
    ///Gets a part set object that contains IOpcPart interface pointers.
    ///Params:
    ///    partSet = A pointer to the IOpcPartSet interface of the part set object that contains IOpcPart interface pointers to
    ///              part objects.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> The <i>partSet</i> parameter is <b>NULL</b>.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>Package Consumption error</b></dt> </dl> </td> <td width="60%">
    ///    An <b>HRESULT</b> error code from the Package Consumption Error Group. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>Part URI error</b></dt> </dl> </td> <td width="60%"> An <b>HRESULT</b> error code from the Part URI
    ///    Error Group. </td> </tr> </table>
    ///    
    HRESULT GetPartSet(IOpcPartSet* partSet);
    ///Gets a relationship set object that represents the Relationships part that stores package relationships.
    ///Params:
    ///    relationshipSet = A pointer to the IOpcRelationshipSet interface of the relationship set object. The set represents the
    ///                      Relationships part that stores package relationships.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> The <i>relationshipSet</i> parameter is
    ///    <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>Package Consumption error</b></dt> </dl> </td> <td
    ///    width="60%"> An <b>HRESULT</b> error code from the Package Consumption Error Group. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>Part URI error</b></dt> </dl> </td> <td width="60%"> An <b>HRESULT</b> error code
    ///    from the Part URI Error Group. </td> </tr> </table>
    ///    
    HRESULT GetRelationshipSet(IOpcRelationshipSet* relationshipSet);
}

///Represents a part that contains data and is not a Relationships part.
@GUID("42195949-3B79-4FC8-89C6-FC7FB979EE71")
interface IOpcPart : IUnknown
{
    ///Gets a relationship set object that represents the Relationships part that stores relationships that have the
    ///part as their source.
    ///Params:
    ///    relationshipSet = A pointer to a relationship set object that represents the Relationships part that stores all relationships
    ///                      that have the part as their source.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> The <i>relationshipSet</i> parameter is
    ///    <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>Package Consumption error</b></dt> </dl> </td> <td
    ///    width="60%"> An <b>HRESULT</b> error code from the Package Consumption Error Group. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>Part URI error</b></dt> </dl> </td> <td width="60%"> An <b>HRESULT</b> error code
    ///    from the Part URI Error Group. </td> </tr> </table>
    ///    
    HRESULT GetRelationshipSet(IOpcRelationshipSet* relationshipSet);
    ///Gets a stream that provides read/write access to part content.
    ///Params:
    ///    stream = A pointer to the IStream interface of a stream that provides read and write access to part content.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> The <i>stream</i> parameter is <b>NULL</b>. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b><b>CreateFile</b> function error</b></dt> </dl> </td> <td
    ///    width="60%"> An <b>HRESULT</b> error code from the CreateFile function, which is returned as a result of
    ///    attempting to allocate disk space for part data if the package was opened using the
    ///    <b>OPC_CACHE_ON_ACCESS</b> read flag. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>Package Consumption
    ///    error</b></dt> </dl> </td> <td width="60%"> An <b>HRESULT</b> error code from the Package Consumption Error
    ///    Group. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>Part URI error</b></dt> </dl> </td> <td width="60%"> An
    ///    <b>HRESULT</b> error code from the Part URI Error Group. </td> </tr> </table>
    ///    
    HRESULT GetContentStream(IStream* stream);
    ///Gets a part URI object that represents the part name.
    ///Params:
    ///    name = A pointer to the IOpcPartUri interface of the part URI object that represents the part name. Part names
    ///           conform to specific syntax specified in the <i>OPC</i>.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> The <i>name</i> parameter is <b>NULL</b>. </td>
    ///    </tr> </table>
    ///    
    HRESULT GetName(IOpcPartUri* name);
    ///Gets the media type of part content.
    ///Params:
    ///    contentType = The media type of part content, as specified by the package format designer and adhering to RFC 2616:
    ///                  HTTP/1.1.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> The <i>contentType</i> parameter is <b>NULL</b>.
    ///    </td> </tr> </table>
    ///    
    HRESULT GetContentType(ushort** contentType);
    ///Gets a value that describes the way part content is compressed.
    ///Params:
    ///    compressionOptions = A value that describes the way part content is compressed.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> The <i>compressionOptions</i> parameter is
    ///    <b>NULL</b>. </td> </tr> </table>
    ///    
    HRESULT GetCompressionOptions(OPC_COMPRESSION_OPTIONS* compressionOptions);
}

///Represents a relationship, which is a link between a source, which is a part or the package, and a target. The
///relationship's target can be a part or external resource.
@GUID("42195949-3B79-4FC8-89C6-FC7FB979EE72")
interface IOpcRelationship : IUnknown
{
    ///Gets the unique identifier of the relationship.
    ///Params:
    ///    relationshipIdentifier = The identifier of the relationship. The identifier of a relationship is arbitrary and local to the package,
    ///                             and, therefore, . Valid identifiers conform to the restrictions for <b>xsd:ID</b>, which are documented in
    ///                             section 3.3.8 ID of the <a href="https://www.w3.org/TR/xmlschema-2/
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> The <i>relationshipIdentifier</i> parameter is
    ///    <b>NULL</b>. </td> </tr> </table>
    ///    
    HRESULT GetId(ushort** relationshipIdentifier);
    ///Gets the relationship type.
    ///Params:
    ///    relationshipType = Receives the relationship type, which is the qualified name of the relationship, as defined by the package
    ///                       format designer or the <i>OPC</i>. For more information about relationship types see Remarks.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> The <i>relationshipType</i> parameter is
    ///    <b>NULL</b>. </td> </tr> </table>
    ///    
    HRESULT GetRelationshipType(ushort** relationshipType);
    ///Gets the URI of the relationship source.
    ///Params:
    ///    sourceUri = A pointer to the IOpcUri interface of the OPC URI object that represents the URI of the relationship source.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> The <i>sourceUri</i> parameter is <b>NULL</b>.
    ///    </td> </tr> </table>
    ///    
    HRESULT GetSourceUri(IOpcUri* sourceUri);
    ///Gets the URI of the relationship target.
    ///Params:
    ///    targetUri = A pointer to the IUri interface of the URI that represents the URI of the relationship's target. If the
    ///                relationship target is internal, the target is a part and the URI of the target is relative to the URI of the
    ///                source part.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> The <i>targetUri</i> parameter is <b>NULL</b>.
    ///    </td> </tr> </table>
    ///    
    HRESULT GetTargetUri(IUri* targetUri);
    ///Gets a value that describes whether the relationship's target is internal or external to the package.
    ///Params:
    ///    targetMode = A value that describes whether the relationship's target is internal or external to the package. If the
    ///                 target of the relationship is internal, the target is a part. If the target of the relationship is external,
    ///                 the target is a resource outside of the package.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> The <i>targetMode</i> parameter is <b>NULL</b>.
    ///    </td> </tr> </table>
    ///    
    HRESULT GetTargetMode(OPC_URI_TARGET_MODE* targetMode);
}

///An unordered set of IOpcPart interface pointers to part objects that represent the parts in a package that are not
///Relationships parts.
@GUID("42195949-3B79-4FC8-89C6-FC7FB979EE73")
interface IOpcPartSet : IUnknown
{
    ///Gets a part object, which represents a specified part, in the set.
    ///Params:
    ///    name = A pointer to the IOpcPartUri interface of the part URI object that represents the part name of a part.
    ///    part = A pointer to the IOpcPart of the part object that represents the part that has the specified part name.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> The <i>name</i> parameter is <b>NULL</b>. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>OPC_E_NO_SUCH_PART</b></dt> <dt>0x80510018</dt> </dl> </td> <td
    ///    width="60%"> The specified part does not exist. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>Package
    ///    Consumption error</b></dt> </dl> </td> <td width="60%"> An <b>HRESULT</b> error code from the Package
    ///    Consumption Error Group. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>Part URI error</b></dt> </dl> </td>
    ///    <td width="60%"> An <b>HRESULT</b> error code from the Part URI Error Group. </td> </tr> </table>
    ///    
    HRESULT GetPart(IOpcPartUri name, IOpcPart* part);
    ///Creates a part object that represents a part and adds a pointer to the object's IOpcPart interface to the set.
    ///Params:
    ///    name = A pointer to the IOpcPartUri interface of a part URI object that represents the part name of the part. To
    ///           create a part URI object (which implements the IOpcPartUri interface) to represent the part name of the part,
    ///           call the IOpcFactory::CreatePartUri method.
    ///    contentType = The media type of part content.
    ///    compressionOptions = A value that describes the way to compress the part content of the part.
    ///    part = A pointer to the new IOpcPart that represents the part. This parameter cannot be <b>NULL</b>.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> The <i>name</i> parameter is <b>NULL</b>. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The value passed
    ///    in the <i>compressionOptions</i> parameter is not a valid OPC_COMPRESSION_OPTIONS enumeration value. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>OPC_E_DUPLICATE_PART</b></dt> <dt>0x8051000B</dt> </dl> </td> <td
    ///    width="60%"> A part with the specified part name already exists in the current package. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>OPC_E_INVALID_CONTENT_TYPE</b></dt> <dt>0x80510044</dt> </dl> </td> <td width="60%">
    ///    A content type does not conform to the rules for a valid media type, specified in RFC 2616: HTTP/1.1
    ///    (http://www.w3.org/Protocols/rfc2616/rfc2616.html) and the <i>OPC</i>. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>OPC_E_UNEXPECTED_CONTENT_TYPE</b></dt> <dt>0x80510005</dt> </dl> </td> <td width="60%"> Either the
    ///    content type of a part differed from the expected content type (specified in the OPC, ECMA-376 Part 2), or
    ///    the part content did not match the part's content type. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>Package
    ///    Consumption error</b></dt> </dl> </td> <td width="60%"> An <b>HRESULT</b> error code from the Package
    ///    Consumption Error Group. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>Part URI error</b></dt> </dl> </td>
    ///    <td width="60%"> An <b>HRESULT</b> error code from the Part URI Error Group. </td> </tr> </table>
    ///    
    HRESULT CreatePart(IOpcPartUri name, const(wchar)* contentType, OPC_COMPRESSION_OPTIONS compressionOptions, 
                       IOpcPart* part);
    ///Deletes the IOpcPart interface pointer of a specified part object from the set.
    ///Params:
    ///    name = A pointer to the IOpcPartUri interface of the part URI object that represents the part name.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> The <i>name</i> parameter is <b>NULL</b>. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>OPC_E_NO_SUCH_PART</b></dt> <dt>0x80510018</dt> </dl> </td> <td
    ///    width="60%"> The specified part does not exist. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>Package
    ///    Consumption error</b></dt> </dl> </td> <td width="60%"> An <b>HRESULT</b> error code from the Package
    ///    Consumption Error Group. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>Part URI error</b></dt> </dl> </td>
    ///    <td width="60%"> An <b>HRESULT</b> error code from the Part URI Error Group. </td> </tr> </table>
    ///    
    HRESULT DeletePart(IOpcPartUri name);
    ///Gets a value that indicates whether a specified part is represented as a part object in the set.
    ///Params:
    ///    name = A pointer to an IOpcPartUri that represents the part name of the part.
    ///    partExists = One of the following values: <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl>
    ///                 <dt><b>TRUE</b></dt> </dl> </td> <td width="60%"> A part that has the specified part name is represented in
    ///                 the set. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>FALSE</b></dt> </dl> </td> <td width="60%"> A part
    ///                 that has the specified part name is not represented in the set. </td> </tr> </table>
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> The <i>partExists</i> parameter is <b>NULL</b>.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>Package Consumption error</b></dt> </dl> </td> <td width="60%">
    ///    An <b>HRESULT</b> error code from the Package Consumption Error Group. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>Part URI error</b></dt> </dl> </td> <td width="60%"> An <b>HRESULT</b> error code from the Part URI
    ///    Error Group. </td> </tr> </table>
    ///    
    HRESULT PartExists(IOpcPartUri name, int* partExists);
    ///Gets an enumerator of IOpcPart interface pointers in the set.
    ///Params:
    ///    partEnumerator = A pointer to the IOpcPartEnumerator interface of the enumerator of IOpcPart interface pointers in the set.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> The <i>partEnumerator</i> parameter is
    ///    <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>Package Consumption error</b></dt> </dl> </td> <td
    ///    width="60%"> An <b>HRESULT</b> error code from the Package Consumption Error Group. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>Part URI error</b></dt> </dl> </td> <td width="60%"> An <b>HRESULT</b> error code
    ///    from the Part URI Error Group. </td> </tr> </table>
    ///    
    HRESULT GetEnumerator(IOpcPartEnumerator* partEnumerator);
}

///Represents a Relationships part as an unordered set of IOpcRelationship interface pointers to relationship objects.
@GUID("42195949-3B79-4FC8-89C6-FC7FB979EE74")
interface IOpcRelationshipSet : IUnknown
{
    ///Gets a relationship object from the set that represents a specified relationship.
    ///Params:
    ///    relationshipIdentifier = The unique identifier of a relationship.
    ///    relationship = A pointer to the IOpcRelationship interface of the relationship object that represents the relationship that
    ///                   has the specified identifier.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> The <i>relationship</i> parameter is <b>NULL</b>.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>OPC_E_NO_SUCH_RELATIONSHIP</b></dt> <dt>0x80510048</dt> </dl>
    ///    </td> <td width="60%"> The specified relationship does not exist. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>Package Consumption error</b></dt> </dl> </td> <td width="60%"> An <b>HRESULT</b> error code from the
    ///    Package Consumption Error Group. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>Part URI error</b></dt> </dl>
    ///    </td> <td width="60%"> An <b>HRESULT</b> error code from the Part URI Error Group. </td> </tr> </table>
    ///    
    HRESULT GetRelationship(const(wchar)* relationshipIdentifier, IOpcRelationship* relationship);
    ///Creates a relationship object that represents a specified relationship, then adds to the set a pointer to the
    ///object's IOpcRelationship interface.
    ///Params:
    ///    relationshipIdentifier = A unique identifier of the relationship to be represented as the relationship object. To use a randomly
    ///                             generated identifier, pass <b>NULL</b> to this parameter. Valid identifiers conform to the restrictions for
    ///                             <b>xsd:ID</b>, which are documented in section 3.3.8 ID of the <a href="https://www.w3.org/TR/xmlschema-2/
    ///    relationshipType = The relationship type that defines the role of the relationship to be represented as the relationship object.
    ///    targetUri = A URI to the target of the relationship to be represented as the relationship object. If the value in
    ///                <i>targetMode</i> is <b>OPC_URI_TARGET_MODE_INTERNAL</b>, target is a part and the URI must be relative to
    ///                the source of the relationship. If the value in <i>targetMode</i> is <b>OPC_URI_TARGET_MODE_EXTERNAL</b>,
    ///                target is a resource outside of the package and the URI may be absolute or relative to the location of the
    ///                package. For more information about the URI of a relationship's target, see the <i>OPC</i>.
    ///    targetMode = A value that indicates whether the target of the relationship to be represented as the relationship object is
    ///                 internal or external to the package.
    ///    relationship = A pointer to the IOpcRelationship interface of the relationship object that represents the relationship. This
    ///                   parameter can be <b>NULL</b> if a pointer to the new object is not needed.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The value passed in the <i>targetMode</i>
    ///    parameter is not a valid OPC_URI_TARGET_MODE enumeration value. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> At least one of the <i>relationshipType</i> and
    ///    <i>targetUri</i> parameters is <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>OPC_E_DUPLICATE_RELATIONSHIP</b></dt> <dt>0x80510013</dt> </dl> </td> <td width="60%"> A relationship
    ///    with the same identifier already exists in the current package. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>OPC_E_INVALID_RELATIONSHIP_ID</b></dt> <dt>0x80510010</dt> </dl> </td> <td width="60%"> The <b>Id</b>
    ///    attribute of a relationship does not conform to the rules specified in the <i>OPC</i>. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>OPC_E_INVALID_RELATIONSHIP_TARGET</b></dt> <dt>0x80510012</dt> </dl> </td> <td
    ///    width="60%"> The URI in <i>targetUri</i> is absolute and the value in <i>targetMode</i> is
    ///    <b>OPC_URI_TARGET_MODE_INTERNAL</b>. The target's URI must be relative when this target mode is specified.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>OPC_E_INVALID_RELATIONSHIP_TARGET</b></dt> <dt>0x80510012</dt>
    ///    </dl> </td> <td width="60%"> The <b>Target</b> attribute of a relationship does not conform to the rules
    ///    specified in the <i>OPC</i>. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>OPC_E_INVALID_RELATIONSHIP_TYPE</b></dt> <dt>0x80510011</dt> </dl> </td> <td width="60%"> The
    ///    <b>Type</b> attribute of a relationship does not conform to the rules specified in the <i>OPC</i>. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>Package Consumption error</b></dt> </dl> </td> <td width="60%"> An
    ///    <b>HRESULT</b> error code from the Package Consumption Error Group. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>Part URI error</b></dt> </dl> </td> <td width="60%"> An <b>HRESULT</b> error code from the Part URI
    ///    Error Group. </td> </tr> </table>
    ///    
    HRESULT CreateRelationship(const(wchar)* relationshipIdentifier, const(wchar)* relationshipType, 
                               IUri targetUri, OPC_URI_TARGET_MODE targetMode, IOpcRelationship* relationship);
    ///Deletes a specified IOpcRelationship interface pointer from the set.
    ///Params:
    ///    relationshipIdentifier = The unique identifier of a relationship. The IOpcRelationship interface pointer to be deleted is the pointer
    ///                             to the relationship object that represents the relationship the specified identifier.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> The <i>relationshipIdentifier</i> parameter is
    ///    <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>OPC_E_NO_SUCH_RELATIONSHIP</b></dt>
    ///    <dt>0x80510048</dt> </dl> </td> <td width="60%"> The specified relationship does not exist. </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>Package Consumption error</b></dt> </dl> </td> <td width="60%"> An
    ///    <b>HRESULT</b> error code from the Package Consumption Error Group. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>Part URI error</b></dt> </dl> </td> <td width="60%"> An <b>HRESULT</b> error code from the Part URI
    ///    Error Group. </td> </tr> </table>
    ///    
    HRESULT DeleteRelationship(const(wchar)* relationshipIdentifier);
    ///Gets a value that indicates whether a specified relationship is represented as a relationship object in the set.
    ///Params:
    ///    relationshipIdentifier = The unique identifier of a relationship.
    ///    relationshipExists = One of the following values: <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl>
    ///                         <dt><b>TRUE</b></dt> </dl> </td> <td width="60%"> A relationship that has the identifier specified in
    ///                         <i>relationshipIdentifier</i> is represented in the set. </td> </tr> <tr> <td width="40%"> <dl>
    ///                         <dt><b>FALSE</b></dt> </dl> </td> <td width="60%"> A relationship that has the identifier specified in
    ///                         <i>relationshipIdentifier</i> is not represented in the set. </td> </tr> </table>
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> At least one of the <i>relationshipIdentifier</i>
    ///    and <i>relationshipExists</i> parameters is <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>Package Consumption error</b></dt> </dl> </td> <td width="60%"> An <b>HRESULT</b> error code from the
    ///    Package Consumption Error Group. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>Part URI error</b></dt> </dl>
    ///    </td> <td width="60%"> An <b>HRESULT</b> error code from the Part URI Error Group. </td> </tr> </table>
    ///    
    HRESULT RelationshipExists(const(wchar)* relationshipIdentifier, int* relationshipExists);
    ///Gets an enumerator of IOpcRelationship interface pointers in the set.
    ///Params:
    ///    relationshipEnumerator = A pointer to the IOpcRelationshipEnumerator interface of the enumerator of IOpcRelationship interface
    ///                             pointers in the set.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> The <i>relationshipEnumerator</i> parameter is
    ///    <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>Package Consumption error</b></dt> </dl> </td> <td
    ///    width="60%"> An <b>HRESULT</b> error code from the Package Consumption Error Group. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>Part URI error</b></dt> </dl> </td> <td width="60%"> An <b>HRESULT</b> error code
    ///    from the Part URI Error Group. </td> </tr> </table>
    ///    
    HRESULT GetEnumerator(IOpcRelationshipEnumerator* relationshipEnumerator);
    ///Gets an enumerator of the IOpcRelationship interface pointers in the set that point to representations of
    ///relationships that have a specified relationship type.
    ///Params:
    ///    relationshipType = The relationship type used to identify IOpcRelationship interface pointers to be enumerated.
    ///    relationshipEnumerator = A pointer to the IOpcRelationshipEnumerator interface of the enumerator of the IOpcRelationship interface
    ///                             pointers in the set that point to representations of relationships that have a specified relationship type.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> At least one of the <i>relationshipType</i> and
    ///    <i>relationshipEnumerator</i> parameters is <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>Package Consumption error</b></dt> </dl> </td> <td width="60%"> An <b>HRESULT</b> error code from the
    ///    Package Consumption Error Group. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>Part URI error</b></dt> </dl>
    ///    </td> <td width="60%"> An <b>HRESULT</b> error code from the Part URI Error Group. </td> </tr> </table>
    ///    
    HRESULT GetEnumeratorForType(const(wchar)* relationshipType, 
                                 IOpcRelationshipEnumerator* relationshipEnumerator);
    ///Gets a read-only stream that contains the part content of the Relationships part represented by the set.
    ///Params:
    ///    contents = A pointer to the IStream interface of the read-only stream that contains the part content of the
    ///               Relationships part represented by the set. If the relationships stored in the Relationships part have not
    ///               been modified, part content can include markup compatibility data that is not otherwise accessible through
    ///               the relationship objects in the set.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> The <i>contents</i> parameter is <b>NULL</b>.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>Package Consumption error</b></dt> </dl> </td> <td width="60%">
    ///    An <b>HRESULT</b> error code from the Package Consumption Error Group. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>Part URI error</b></dt> </dl> </td> <td width="60%"> An <b>HRESULT</b> error code from the Part URI
    ///    Error Group. </td> </tr> </table>
    ///    
    HRESULT GetRelationshipsContentStream(IStream* contents);
}

///A read-only enumerator of IOpcPart interface pointers.
@GUID("42195949-3B79-4FC8-89C6-FC7FB979EE75")
interface IOpcPartEnumerator : IUnknown
{
    ///Moves the current position of the enumerator to the next IOpcPart interface pointer.
    ///Params:
    ///    hasNext = A Boolean value that indicates the status of the IOpcPart interface pointer at the current position. The
    ///              value of <i>hasNext</i> is only valid when the method succeeds. <table> <tr> <th>Value</th> <th>Meaning</th>
    ///              </tr> <tr> <td width="40%"> <dl> <dt>TRUE</dt> </dl> </td> <td width="60%"> The current position of the
    ///              enumerator has been advanced to the next pointer and that pointer is valid. </td> </tr> <tr> <td width="40%">
    ///              <dl> <dt>FALSE</dt> </dl> </td> <td width="60%"> The current position of the enumerator has been advanced
    ///              past the end of the collection and is no longer valid. </td> </tr> </table>
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> The <i>hasNext</i> parameter is <b>NULL</b>.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>OPC_E_ENUM_CANNOT_MOVE_NEXT</b></dt> <dt>0x80510051</dt> </dl>
    ///    </td> <td width="60%"> The current position is already past the last item of the enumerator. </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>OPC_E_ENUM_COLLECTION_CHANGED</b></dt> <dt>0x80510050</dt> </dl> </td> <td
    ///    width="60%"> The enumerator is invalid because the underlying set has changed. </td> </tr> </table>
    ///    
    HRESULT MoveNext(int* hasNext);
    ///Moves the current position of the enumerator to the previous IOpcPart interface pointer.
    ///Params:
    ///    hasPrevious = A Boolean value that indicates the status of the IOpcPart interface pointer at the current position. The
    ///                  value of <i>hasPrevious</i> is only valid when the method succeeds. <table> <tr> <th>Value</th>
    ///                  <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt>TRUE</dt> </dl> </td> <td width="60%"> The current
    ///                  position of the enumerator has been moved to the previous pointer in the collection, and that pointer is
    ///                  valid. </td> </tr> <tr> <td width="40%"> <dl> <dt>FALSE</dt> </dl> </td> <td width="60%"> The current
    ///                  position of the enumerator has been moved past the beginning of the collection and is no longer valid. </td>
    ///                  </tr> </table>
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> The <i>hasPrevious</i> parameter is <b>NULL</b>.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>OPC_E_ENUM_COLLECTION_CHANGED</b></dt> <dt>0x80510050</dt>
    ///    </dl> </td> <td width="60%"> The enumerator is invalid because the underlying set has changed. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>OPC_E_ENUM_CANNOT_MOVE_PREVIOUS</b></dt> <dt>0x80510052</dt> </dl> </td>
    ///    <td width="60%"> The current position already precedes the first item of the enumerator. </td> </tr> </table>
    ///    
    HRESULT MovePrevious(int* hasPrevious);
    ///Gets the IOpcPart interface pointer at the current position of the enumerator.
    ///Params:
    ///    part = An IOpcPart interface pointer.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> The <i>partReference</i> parameter is
    ///    <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>OPC_E_ENUM_COLLECTION_CHANGED</b></dt>
    ///    <dt>0x80510050</dt> </dl> </td> <td width="60%"> The enumerator is invalid because the underlying set has
    ///    changed. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>OPC_E_ENUM_INVALID_POSITION</b></dt>
    ///    <dt>0x80510053</dt> </dl> </td> <td width="60%"> The enumerator cannot perform this operation from its
    ///    current position. </td> </tr> </table>
    ///    
    HRESULT GetCurrent(IOpcPart* part);
    ///Creates a copy of the current enumerator and all its descendants.
    ///Params:
    ///    copy = A pointer to the IOpcPartEnumerator interface of the new enumerator.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> The <i>copy</i> parameter is <b>NULL</b>. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>OPC_E_ENUM_COLLECTION_CHANGED</b></dt> <dt>0x80510050</dt> </dl>
    ///    </td> <td width="60%"> The enumerator is invalid because the underlying set has changed. </td> </tr> </table>
    ///    
    HRESULT Clone(IOpcPartEnumerator* copy);
}

///A read-only enumerator of IOpcRelationship interface pointers.
@GUID("42195949-3B79-4FC8-89C6-FC7FB979EE76")
interface IOpcRelationshipEnumerator : IUnknown
{
    ///Moves the current position of the enumerator to the next IOpcRelationship interface pointer.
    ///Params:
    ///    hasNext = A Boolean value that indicates the status of the IOpcRelationship interface pointer at the current position.
    ///              The value of <i>hasNext</i> is only valid when the method succeeds. <table> <tr> <th>Value</th>
    ///              <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt>TRUE</dt> </dl> </td> <td width="60%"> The current
    ///              position of the enumerator has been advanced to the next pointer and that pointer is valid. </td> </tr> <tr>
    ///              <td width="40%"> <dl> <dt>FALSE</dt> </dl> </td> <td width="60%"> The current position of the enumerator has
    ///              been advanced past the end of the collection and is no longer valid. </td> </tr> </table>
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> The <i>hasNext</i> parameter is <b>NULL</b>.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>OPC_E_ENUM_CANNOT_MOVE_NEXT</b></dt> <dt>0x80510051</dt> </dl>
    ///    </td> <td width="60%"> The current position is already past the last item of the enumerator. </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>OPC_E_ENUM_COLLECTION_CHANGED</b></dt> <dt>0x80510050</dt> </dl> </td> <td
    ///    width="60%"> The enumerator is invalid because the underlying set has changed. </td> </tr> </table>
    ///    
    HRESULT MoveNext(int* hasNext);
    ///Moves the current position of the enumerator to the previous IOpcRelationship interface pointer.
    ///Params:
    ///    hasPrevious = A Boolean value that indicates the status of the IOpcRelationship interface pointer at the current position.
    ///                  The value of <i>hasPrevious</i> is only valid when the method succeeds. <table> <tr> <th>Value</th>
    ///                  <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt>TRUE</dt> </dl> </td> <td width="60%"> The current
    ///                  position of the enumerator has been moved to the previous pointer in the collection, and that pointer is
    ///                  valid. </td> </tr> <tr> <td width="40%"> <dl> <dt>FALSE</dt> </dl> </td> <td width="60%"> The current
    ///                  position of the enumerator has been moved past the beginning of the enumerator and is no longer valid. </td>
    ///                  </tr> </table>
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> The <i>hasPrevious</i> parameter is <b>NULL</b>.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>OPC_E_ENUM_COLLECTION_CHANGED</b></dt> <dt>0x80510050</dt>
    ///    </dl> </td> <td width="60%"> The enumerator is invalid because the underlying set has changed. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>OPC_E_ENUM_CANNOT_MOVE_PREVIOUS</b></dt> <dt>0x80510052</dt> </dl> </td>
    ///    <td width="60%"> The current position already precedes the first item of the enumerator. </td> </tr> </table>
    ///    
    HRESULT MovePrevious(int* hasPrevious);
    ///Gets the IOpcRelationship interface pointer at the current position of the enumerator.
    ///Params:
    ///    relationship = An IOpcRelationship interface pointer.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> The <i>partReference</i> parameter is
    ///    <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>OPC_E_ENUM_COLLECTION_CHANGED</b></dt>
    ///    <dt>0x80510050</dt> </dl> </td> <td width="60%"> The enumerator is invalid because the underlying set has
    ///    changed. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>OPC_E_ENUM_INVALID_POSITION</b></dt>
    ///    <dt>0x80510053</dt> </dl> </td> <td width="60%"> The enumerator cannot perform this operation from its
    ///    current position. </td> </tr> </table>
    ///    
    HRESULT GetCurrent(IOpcRelationship* relationship);
    ///Creates a copy of the current enumerator and all its descendants.
    ///Params:
    ///    copy = A pointer to the IOpcRelationshipEnumerator interface of the new enumerator.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> The <i>copy</i> parameter is <b>NULL</b>. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>OPC_E_ENUM_COLLECTION_CHANGED</b></dt> <dt>0x80510050</dt> </dl>
    ///    </td> <td width="60%"> The enumerator is invalid because the underlying set has changed. </td> </tr> </table>
    ///    
    HRESULT Clone(IOpcRelationshipEnumerator* copy);
}

///Represents a reference to a part that has been or will be signed.
@GUID("E24231CA-59F4-484E-B64B-36EEDA36072C")
interface IOpcSignaturePartReference : IUnknown
{
    ///Gets the part name of the referenced part.
    ///Params:
    ///    partName = A pointer to an IOpcPartUri interface that represents the part name.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> The <i>partName</i> parameter is <b>NULL</b>.
    ///    </td> </tr> </table>
    ///    
    HRESULT GetPartName(IOpcPartUri* partName);
    ///Gets the content type of the referenced part.
    ///Params:
    ///    contentType = The content type of the referenced part.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> The <i>contentType</i> parameter is <b>NULL</b>.
    ///    </td> </tr> </table>
    ///    
    HRESULT GetContentType(ushort** contentType);
    ///Gets the digest method to use on part content of the referenced part when the part is signed.
    ///Params:
    ///    digestMethod = The digest method to use on part content of the referenced part when the part is signed.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> The <i>digestMethod</i> parameter is <b>NULL</b>.
    ///    </td> </tr> </table>
    ///    
    HRESULT GetDigestMethod(ushort** digestMethod);
    ///Gets the digest value that is calculated for part content of the referenced part when the part is signed.
    ///Params:
    ///    digestValue = A pointer to a buffer that contains the digest value that is calculated using the specified digest method;
    ///                  the method is applied to part content of the referenced part when the part is signed.
    ///    count = The size of the <i>digestValue</i> buffer. If the referenced part has not been signed yet, <i>count</i> is 0.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> At least one of the <i>digestValue</i>, and
    ///    <i>count</i> parameters is <b>NULL</b>. </td> </tr> </table>
    ///    
    HRESULT GetDigestValue(char* digestValue, uint* count);
    ///Gets the canonicalization method to use on part content of a referenced part when the part is signed.
    ///Params:
    ///    transformMethod = The canonicalization method to use on part content of a referenced part when the part is signed.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> The <i>transformMethod</i> parameter is
    ///    <b>NULL</b>. </td> </tr> </table>
    ///    
    HRESULT GetTransformMethod(OPC_CANONICALIZATION_METHOD* transformMethod);
}

///Represents a reference to a Relationships part that contains relationships that have been or will be signed.
@GUID("57BABAC6-9D4A-4E50-8B86-E5D4051EAE7C")
interface IOpcSignatureRelationshipReference : IUnknown
{
    ///Gets the source URI of the relationships that are stored in the referenced Relationships part.
    ///Params:
    ///    sourceUri = A pointer to the source URI of the relationships that are stored in the referenced Relationships part.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> The <i>sourceUri</i> parameter is <b>NULL</b>.
    ///    </td> </tr> </table>
    ///    
    HRESULT GetSourceUri(IOpcUri* sourceUri);
    ///Gets the digest method to use on relationship markup of the selected relationships.
    ///Params:
    ///    digestMethod = The digest method to use on relationship markup of the selected relationships when they are signed.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> The <i>digestMethod</i> parameter is <b>NULL</b>.
    ///    </td> </tr> </table>
    ///    
    HRESULT GetDigestMethod(ushort** digestMethod);
    ///Gets the digest value calculated for the selected relationships when they are signed.
    ///Params:
    ///    digestValue = A pointer to a buffer that contains the digest value calculated using the specified digest method; the method
    ///                  is applied to the relationship markup of the selected relationships when they are signed.
    ///    count = The size of the <i>digestValue</i> buffer. If the selected relationships have not been signed yet,
    ///            <i>count</i> is 0.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> At least one of the <i>digestValue</i>, and
    ///    <i>count</i> parameters is <b>NULL</b>. </td> </tr> </table>
    ///    
    HRESULT GetDigestValue(char* digestValue, uint* count);
    ///Gets the canonicalization method to use on the relationship markup of the selected relationships when they are
    ///signed.
    ///Params:
    ///    transformMethod = The canonicalization method to use on the relationship markup of the selected relationships when they are
    ///                      signed.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> The <i>transformMethod</i> parameter is
    ///    <b>NULL</b>. </td> </tr> </table>
    ///    
    HRESULT GetTransformMethod(OPC_CANONICALIZATION_METHOD* transformMethod);
    ///Gets a value that describes whether all or a subset of relationships that are stored in the referenced
    ///Relationships part are selected.
    ///Params:
    ///    relationshipSigningOption = A value that describes whether all or a subset of relationships are selected.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> The <i>relationshipSigningOption</i> parameter is
    ///    <b>NULL</b>. </td> </tr> </table>
    ///    
    HRESULT GetRelationshipSigningOption(OPC_RELATIONSHIPS_SIGNING_OPTION* relationshipSigningOption);
    ///Gets an enumerator of IOpcRelationshipSelector interface pointers that represent the techniques used to select
    ///the subset of relationships in the referenced Relationships part.
    ///Params:
    ///    selectorEnumerator = A pointer to an enumerator of IOpcRelationshipSelector interface pointers.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> The <i>selectorEnumerator</i> parameter is
    ///    <b>NULL</b>. </td> </tr> </table>
    ///    
    HRESULT GetRelationshipSelectorEnumerator(IOpcRelationshipSelectorEnumerator* selectorEnumerator);
}

///Represents how to select, from a Relationships part, the relationships to be referenced for signing.
@GUID("F8F26C7F-B28F-4899-84C8-5D5639EDE75F")
interface IOpcRelationshipSelector : IUnknown
{
    ///Gets a value that describes how relationships are selected to be referenced for signing.
    ///Params:
    ///    selector = A value that describes which IOpcRelationship interface property will be compared to the string returned by
    ///               the GetSelectionCriterion method.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> The <i>selector</i> parameter is <b>NULL</b>.
    ///    </td> </tr> </table>
    ///    
    HRESULT GetSelectorType(OPC_RELATIONSHIP_SELECTOR* selector);
    ///Gets a string that is used to select relationships to be referenced for signing.
    ///Params:
    ///    selectionCriterion = A string used to select relationships to be referenced for signing.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> The <i>selectionCriterion</i> parameter is
    ///    <b>NULL</b>. </td> </tr> </table>
    ///    
    HRESULT GetSelectionCriterion(ushort** selectionCriterion);
}

///Represents a reference to XML markup that has been or will be signed. This referenced XML markup is serialized in the
///signature markup when a signature is generated.
@GUID("1B47005E-3011-4EDC-BE6F-0F65E5AB0342")
interface IOpcSignatureReference : IUnknown
{
    ///Gets the identifier for the reference.
    ///Params:
    ///    referenceId = An identifier for the reference. If the identifier is not set, <i>referenceId</i> will be the empty string,
    ///                  "".
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> The <i>referenceId</i> parameter is <b>NULL</b>.
    ///    </td> </tr> </table>
    ///    
    HRESULT GetId(ushort** referenceId);
    ///Gets the URI of the referenced XML element.
    ///Params:
    ///    referenceUri = A pointer to the URI of the referenced element. This URI represented by a string is "
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> The <i>referenceUri</i> parameter is <b>NULL</b>.
    ///    </td> </tr> </table>
    ///    
    HRESULT GetUri(IUri* referenceUri);
    ///Gets a string that indicates the type of the referenced XML element.
    ///Params:
    ///    type = A string that indicates the type of the referenced XML element. If the type is not set, the <i>type</i>
    ///           parameter will be the empty string "".
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> The <i>type</i> parameter is <b>NULL</b>. </td>
    ///    </tr> </table>
    ///    
    HRESULT GetType(ushort** type);
    ///Gets the canonicalization method to use on the referenced XML element, when the element is signed.
    ///Params:
    ///    transformMethod = The canonicalization method to use on the referenced XML element, when the element is signed.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> The <i>transformMethod</i> parameter is
    ///    <b>NULL</b>. </td> </tr> </table>
    ///    
    HRESULT GetTransformMethod(OPC_CANONICALIZATION_METHOD* transformMethod);
    ///Gets the digest method to use on the referenced XML element, when the element is signed.
    ///Params:
    ///    digestMethod = The digest method to use on the referenced XML element.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> The <i>digestMethod</i> parameter is <b>NULL</b>.
    ///    </td> </tr> </table>
    ///    
    HRESULT GetDigestMethod(ushort** digestMethod);
    ///Gets the digest value that is calculated for the referenced XML element when the element is signed.
    ///Params:
    ///    digestValue = A pointer to a buffer that contains the digest value calculated using the specified digest method when the
    ///                  referenced XML element is signed.
    ///    count = The size of the <i>digestValue</i> buffer. If the referenced XML element has not been signed yet,
    ///            <i>count</i> is 0.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> At least one of the <i>digestValue</i>, and
    ///    <i>count</i> parameters is <b>NULL</b>. </td> </tr> </table>
    ///    
    HRESULT GetDigestValue(char* digestValue, uint* count);
}

///Represents an application-specific <b>Object</b> element that has been or will be signed.
@GUID("5D77A19E-62C1-44E7-BECD-45DA5AE51A56")
interface IOpcSignatureCustomObject : IUnknown
{
    ///Gets the XML markup of an application-specific <b>Object</b> element.
    ///Params:
    ///    xmlMarkup = A pointer to a buffer that contains the XML markup of an <b>Object</b> element and includes the opening and
    ///                closing <b>Object</b> tags. In the buffer, XML markup is preceded by a byte order mark that corresponds to
    ///                the encoding of the markup. Supported encodings and byte order mark values.<table> <tr> <th>Encoding</th>
    ///                <th>Description</th> <th>Byte order mark</th> </tr> <tr> <td>UTF8</td> <td>UTF-8</td> <td>EF BB BF</td> </tr>
    ///                <tr> <td>UTF16LE</td> <td>UTF-16, little endian</td> <td>FF FE</td> </tr> <tr> <td>UTF16BE</td> <td>UTF-16,
    ///                big endian</td> <td>FE FF</td> </tr> </table> For an example of a buffer with a byte order mark, see the
    ///                Remarks section.
    ///    count = A pointer to the size of the <i>xmlMarkup</i> buffer.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> At least one of the <i>xmlMarkup</i>, and
    ///    <i>count</i> parameters is <b>NULL</b>. </td> </tr> </table>
    ///    
    HRESULT GetXml(char* xmlMarkup, uint* count);
}

///Represents a package digital signature.
@GUID("52AB21DD-1CD0-4949-BC80-0C1232D00CB4")
interface IOpcDigitalSignature : IUnknown
{
    ///Gets the prefix and namespace mapping of the <b>Signature</b> element of the signature markup.
    ///Params:
    ///    prefixes = A pointer to a buffer of XML prefix strings. If the method succeeds, call the CoTaskMemFree function to free
    ///               the memory of each string in the buffer and then to free the memory of the buffer itself.
    ///    namespaces = A pointer to a buffer of XML namespace strings. If the method succeeds, call the CoTaskMemFree function to
    ///                 free the memory of each string in the buffer and then to free the memory of the buffer itself.
    ///    count = The size of the <i>prefixes</i> and <i>namespaces</i> buffers.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> The <i>prefixes</i> parameter is <b>NULL</b>.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> The
    ///    <i>namespaces</i> parameter is <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt>
    ///    </dl> </td> <td width="60%"> The <i>count</i> parameter is <b>NULL</b>. </td> </tr> </table>
    ///    
    HRESULT GetNamespaces(char* prefixes, char* namespaces, uint* count);
    ///Gets the value of the <b>Id</b> attribute from the <b>Signature</b> element of the signature markup.
    ///Params:
    ///    signatureId = A pointer to the <b>Id</b> attribute value of the signature markup <b>Signature</b> element. If the
    ///                  <b>Signature</b> element does not have an <b>Id</b> attribute value, <i>signatureId</i> will be the empty
    ///                  string.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> The <i>signatureId</i> parameter is <b>NULL</b>.
    ///    </td> </tr> </table>
    ///    
    HRESULT GetSignatureId(ushort** signatureId);
    ///Gets the part name of the part that contains the signature markup.
    ///Params:
    ///    signaturePartName = An IOpcPartUri interface pointer that represents the part name of the signature part that contains the
    ///                        signature markup.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> The <i>signaturePartName</i> parameter is
    ///    <b>NULL</b>. </td> </tr> </table>
    ///    
    HRESULT GetSignaturePartName(IOpcPartUri* signaturePartName);
    ///Gets the signature method used to calculate the value in the <b>SignatureValue</b> element of the signature
    ///markup.
    ///Params:
    ///    signatureMethod = A pointer to the signature method.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> The <i>signatureMethod</i> parameter is
    ///    <b>NULL</b>. </td> </tr> </table>
    ///    
    HRESULT GetSignatureMethod(ushort** signatureMethod);
    ///Gets the canonicalization method that was applied to the <b>SignedInfo</b> element of the serialized signature.
    ///Params:
    ///    canonicalizationMethod = An OPC_CANONICALIZATION_METHOD value that specifies the canonicalization method that was applied to the
    ///                             <b>SignedInfo</b> element of the signature markup when the signature was generated.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> The <i>canonicalizationMethod</i> parameter is
    ///    <b>NULL</b>. </td> </tr> </table>
    ///    
    HRESULT GetCanonicalizationMethod(OPC_CANONICALIZATION_METHOD* canonicalizationMethod);
    ///Gets the decoded value in the <b>SignatureValue</b> element of the signature markup.
    ///Params:
    ///    signatureValue = A pointer to a buffer that contains the decoded value in the <b>SignatureValue</b> element of the signature
    ///                     markup.
    ///    count = The size of the <i>signatureHashValue</i> buffer.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> At least one of the <i>signatureValue</i>, and
    ///    <i>count</i> parameters is <b>NULL</b>. </td> </tr> </table>
    ///    
    HRESULT GetSignatureValue(char* signatureValue, uint* count);
    ///Gets an enumerator of IOpcSignaturePartReference interface pointers, which represent references to parts that
    ///have been signed.
    ///Params:
    ///    partReferenceEnumerator = A pointer to an enumerator of IOpcSignaturePartReference interface pointers, which represent references to
    ///                              parts that have been signed.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> The <i>partReferenceEnumerator</i> parameter is
    ///    <b>NULL</b>. </td> </tr> </table>
    ///    
    HRESULT GetSignaturePartReferenceEnumerator(IOpcSignaturePartReferenceEnumerator* partReferenceEnumerator);
    ///Gets an enumerator of IOpcSignatureRelationshipReference interface pointers, which represent references to
    ///relationships that have been signed.
    ///Params:
    ///    relationshipReferenceEnumerator = A pointer to an enumerator of IOpcSignatureRelationshipReference interface pointers, which represent
    ///                                      references to relationships that have been signed.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> The <i>relationshipReferenceEnumerator</i>
    ///    parameter is <b>NULL</b>. </td> </tr> </table>
    ///    
    HRESULT GetSignatureRelationshipReferenceEnumerator(IOpcSignatureRelationshipReferenceEnumerator* relationshipReferenceEnumerator);
    ///Gets a string that indicates the time at which the signature was generated.
    ///Params:
    ///    signingTime = A pointer to a string that indicates the time at which the signature was generated.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> The <i>signingTime</i> parameter is <b>NULL</b>.
    ///    </td> </tr> </table>
    ///    
    HRESULT GetSigningTime(ushort** signingTime);
    HRESULT GetTimeFormatA(OPC_SIGNATURE_TIME_FORMAT* timeFormat);
    ///Gets an IOpcSignatureReference interface pointer that represents the reference to the package-specific
    ///<b>Object</b> element that has been signed.
    ///Params:
    ///    packageObjectReference = An IOpcSignatureReference interface pointer that represents the reference to the package-specific
    ///                             <b>Object</b> element that has been signed.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> The <i>packageObjectReference</i> parameter is
    ///    <b>NULL</b>. </td> </tr> </table>
    ///    
    HRESULT GetPackageObjectReference(IOpcSignatureReference* packageObjectReference);
    ///Gets an enumerator of certificates that are used in the signature.
    ///Params:
    ///    certificateEnumerator = A pointer to an enumerator of pointers to CERT_CONTEXT structures that are used in the signature.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> The <i>certificateEnumerator</i> parameter is
    ///    <b>NULL</b>. </td> </tr> </table>
    ///    
    HRESULT GetCertificateEnumerator(IOpcCertificateEnumerator* certificateEnumerator);
    ///Gets an enumerator of the IOpcSignatureReference interface pointers that represent references to
    ///application-specific XML elements that have been signed.
    ///Params:
    ///    customReferenceEnumerator = A pointer to an enumerator of IOpcSignatureReference interface pointers. An <b>IOpcSignatureReference</b>
    ///                                interface pointer represents a reference to an application-specific XML element that has been signed.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> The <i>customReferenceEnumerator</i> parameter is
    ///    <b>NULL</b>. </td> </tr> </table>
    ///    
    HRESULT GetCustomReferenceEnumerator(IOpcSignatureReferenceEnumerator* customReferenceEnumerator);
    ///Gets an enumerator of IOpcSignatureCustomObject interface pointers that represent application-specific
    ///<b>Object</b> elements in the signature markup.
    ///Params:
    ///    customObjectEnumerator = A pointer to an enumerator of IOpcSignatureCustomObject interface pointers.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> The <i>customObjectEnumerator</i> parameter is
    ///    <b>NULL</b>. </td> </tr> </table>
    ///    
    HRESULT GetCustomObjectEnumerator(IOpcSignatureCustomObjectEnumerator* customObjectEnumerator);
    ///Gets the signature markup.
    ///Params:
    ///    signatureXml = A pointer to a buffer that contains the signature markup.
    ///    count = The size of the <i>signatureXml</i> buffer.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> At least one of the <i>digestValue</i>, and
    ///    <i>count</i> parameters is <b>NULL</b>. </td> </tr> </table>
    ///    
    HRESULT GetSignatureXml(ubyte** signatureXml, uint* count);
}

///Provides methods to set and access information required to generate a signature.
@GUID("50D2D6A5-7AEB-46C0-B241-43AB0E9B407E")
interface IOpcSigningOptions : IUnknown
{
    ///Gets the value of the <b>Id</b> attribute from the <b>Signature</b> element.
    ///Params:
    ///    signatureId = A pointer to the value of the <b>Id</b> attribute, or the empty string "" if there is no <b>Id</b>.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> The <i>signatureId</i> parameter is <b>NULL</b>.
    ///    </td> </tr> </table>
    ///    
    HRESULT GetSignatureId(ushort** signatureId);
    ///Sets the value of the <b>Id</b> attribute of the <b>Signature</b> element.
    ///Params:
    ///    signatureId = The value of the <b>Id</b> attribute.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> The <i>signatureId</i> parameter is <b>NULL</b>.
    ///    </td> </tr> </table>
    ///    
    HRESULT SetSignatureId(const(wchar)* signatureId);
    ///Gets the signature method to use to calculate and encrypt the hash value of the <b>SignedInfo</b> element, which
    ///will be serialized as the <b>SignatureValue</b> element of the signature.
    ///Params:
    ///    signatureMethod = A pointer to the signature method to use, or the empty string "" if no method has been set using the
    ///                      SetSignatureMethod method.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> The <i>signatureMethod</i> parameter is
    ///    <b>NULL</b>. </td> </tr> </table>
    ///    
    HRESULT GetSignatureMethod(ushort** signatureMethod);
    ///Sets the signature method to use to calculate and encrypt the hash value of the <b>SignedInfo</b> element, which
    ///will be contained in the <b>SignatureValue</b> element of the signature.
    ///Params:
    ///    signatureMethod = The signature method to use.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> The <i>signatureMethod</i> parameter is
    ///    <b>NULL</b>. </td> </tr> </table>
    ///    
    HRESULT SetSignatureMethod(const(wchar)* signatureMethod);
    ///Gets the default digest method that will be used to compute digest values for objects to be signed.
    ///Params:
    ///    digestMethod = A pointer to the default digest method, or the empty string "" if a default has not been set using the
    ///                   SetDefaultDigestMethod method.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> The <i>digestMethod</i> parameter is <b>NULL</b>.
    ///    </td> </tr> </table>
    ///    
    HRESULT GetDefaultDigestMethod(ushort** digestMethod);
    ///Sets the default digest method that will be used to compute digest values for objects to be signed.
    ///Params:
    ///    digestMethod = The default digest method.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> The <i>digestMethod</i> parameter is <b>NULL</b>.
    ///    </td> </tr> </table>
    ///    
    HRESULT SetDefaultDigestMethod(const(wchar)* digestMethod);
    ///Gets a value that specifies the storage location in the package of the certificate to be used for the signature.
    ///Params:
    ///    embeddingOption = A value that specifies the location of the certificate.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The <i>embeddingOption</i> parameter is not a
    ///    valid OPC_CERTIFICATE_EMBEDDING_OPTION enum value. </td> </tr> </table>
    ///    
    HRESULT GetCertificateEmbeddingOption(OPC_CERTIFICATE_EMBEDDING_OPTION* embeddingOption);
    ///Set the storage location of the certificate to be used for the signature.
    ///Params:
    ///    embeddingOption = The OPC_CERTIFICATE_EMBEDDING_OPTION value that describes the location of the certificate.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> The <i>embeddingOption</i> parameter is
    ///    <b>NULL</b>. </td> </tr> </table>
    ///    
    HRESULT SetCertificateEmbeddingOption(OPC_CERTIFICATE_EMBEDDING_OPTION embeddingOption);
    HRESULT GetTimeFormatA(OPC_SIGNATURE_TIME_FORMAT* timeFormat);
    ///Sets the format of the string retrieved by the IOpcDigitalSignature::GetSigningTime method.
    ///Params:
    ///    timeFormat = The value that describes the format of the string retrieved by the IOpcDigitalSignature::GetSigningTime
    ///                 method.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The value passed in the <i>timeFormat</i>
    ///    parameter is not a valid OPC_SIGNATURE_TIME_FORMAT enumeration value. </td> </tr> </table>
    ///    
    HRESULT SetTimeFormat(OPC_SIGNATURE_TIME_FORMAT timeFormat);
    ///Gets an IOpcSignaturePartReferenceSet interface.
    ///Params:
    ///    partReferenceSet = An IOpcSignaturePartReferenceSet interface pointers.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> The <i>partReferenceSet</i> parameter is
    ///    <b>NULL</b>. </td> </tr> </table>
    ///    
    HRESULT GetSignaturePartReferenceSet(IOpcSignaturePartReferenceSet* partReferenceSet);
    ///Gets an IOpcSignatureRelationshipReferenceSet interface pointer.
    ///Params:
    ///    relationshipReferenceSet = An IOpcSignatureRelationshipReferenceSet interface pointer.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> The <i>relationshipReferenceSet</i> parameter is
    ///    <b>NULL</b>. </td> </tr> </table>
    ///    
    HRESULT GetSignatureRelationshipReferenceSet(IOpcSignatureRelationshipReferenceSet* relationshipReferenceSet);
    ///Gets an IOpcSignatureCustomObjectSet interface.
    ///Params:
    ///    customObjectSet = A pointer to an IOpcSignatureCustomObjectSet.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> The <i>customObjectSet</i> parameter is
    ///    <b>NULL</b>. </td> </tr> </table>
    ///    
    HRESULT GetCustomObjectSet(IOpcSignatureCustomObjectSet* customObjectSet);
    ///Gets an IOpcSignatureReferenceSet interface pointer.
    ///Params:
    ///    customReferenceSet = A pointer to an IOpcSignatureReferenceSet.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> The <i>customReferenceSet</i> parameter is
    ///    <b>NULL</b>. </td> </tr> </table>
    ///    
    HRESULT GetCustomReferenceSet(IOpcSignatureReferenceSet* customReferenceSet);
    ///Gets an IOpcCertificateSet interface pointer.
    ///Params:
    ///    certificateSet = An IOpcCertificateSet interface pointer.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> The <i>certificateSet</i> parameter is
    ///    <b>NULL</b>. </td> </tr> </table>
    ///    
    HRESULT GetCertificateSet(IOpcCertificateSet* certificateSet);
    ///Gets the part name of the signature part where the signature markup will be stored.
    ///Params:
    ///    signaturePartName = An IOpcPartUri interface pointer that represents the part name of the part where the signature markup is
    ///                        stored, or <b>NULL</b> if the part name has not been set by a call to the SetSignaturePartName method.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> The <i>signaturePartName</i> parameter is
    ///    <b>NULL</b>. </td> </tr> </table>
    ///    
    HRESULT GetSignaturePartName(IOpcPartUri* signaturePartName);
    ///Sets the part name of the signature part where the signature markup will be stored.
    ///Params:
    ///    signaturePartName = An IOpcPartUri interface pointer that represents the part name of the part where the signature markup is
    ///                        stored, or <b>NULL</b> to generate a part name when the signature is created.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT SetSignaturePartName(IOpcPartUri signaturePartName);
}

///Provides access to Packaging Digital Signature Interfaces for a package that is represented by Packaging API objects.
///These interface methods are called to generate a signature, or to access and validate existing signatures in the
///package.
@GUID("D5E62A0B-696D-462F-94DF-72E33CEF2659")
interface IOpcDigitalSignatureManager : IUnknown
{
    ///Gets an IOpcPartUri interface pointer that represents the part name of the Digital Signature Origin part.
    ///Params:
    ///    signatureOriginPartName = An IOpcPartUri interface pointer, or <b>NULL</b> if the Digital Signature Origin part does not exist.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> The <i>signatureOriginPartName</i> parameter is
    ///    <b>NULL</b>. </td> </tr> </table>
    ///    
    HRESULT GetSignatureOriginPartName(IOpcPartUri* signatureOriginPartName);
    ///Sets the part name of the Digital Signature Origin part to the name represented by a specified IOpcPartUri
    ///interface pointer.
    ///Params:
    ///    signatureOriginPartName = A pointer to an IOpcPartUri interface pointer that represents the desired part name for the Digital Signature
    ///                              Origin part.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>OPC_E_DS_SIGNATURE_ORIGIN_EXISTS</b></dt> <dt>0x80510054</dt> </dl> </td> <td width="60%"> A
    ///    Digital Signature Origin part already exists in the package and cannot be renamed. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>OPC_E_DUPLICATE_PART</b></dt> <dt>0x8051000B</dt> </dl> </td> <td width="60%"> A
    ///    part with the specified part name already exists in the current package. </td> </tr> </table>
    ///    
    HRESULT SetSignatureOriginPartName(IOpcPartUri signatureOriginPartName);
    ///Gets an enumerator of IOpcDigitalSignature interface pointers, which represent package signatures.
    ///Params:
    ///    signatureEnumerator = A pointer to an enumerator of IOpcDigitalSignature interface pointers, which represent package signatures.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> The <i>signatureEnumerator</i> parameter is
    ///    <b>NULL</b>. </td> </tr> </table>
    ///    
    HRESULT GetSignatureEnumerator(IOpcDigitalSignatureEnumerator* signatureEnumerator);
    ///Removes from the package a specified signature part that stores signature markup.
    ///Params:
    ///    signaturePartName = An IOpcPartUri interface pointer that represents the part name of the signature part to be removed.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> The <i>signaturePartName</i> parameter is
    ///    <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>OPC_E_NO_SUCH_PART</b></dt> <dt>0x80510018</dt>
    ///    </dl> </td> <td width="60%"> The specified part does not exist. </td> </tr> </table>
    ///    
    HRESULT RemoveSignature(IOpcPartUri signaturePartName);
    ///Creates an IOpcSigningOptions interface pointer.
    ///Params:
    ///    signingOptions = A pointer to an IOpcSigningOptions interface pointer.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> The <i>signingOptions</i> parameter is
    ///    <b>NULL</b>. </td> </tr> </table>
    ///    
    HRESULT CreateSigningOptions(IOpcSigningOptions* signingOptions);
    ///Validates a specified package signature using a specified certificate.
    ///Params:
    ///    signature = An IOpcDigitalSignature interface pointer that represents the signature to be validated.
    ///    certificate = A pointer to a CERT_CONTEXT structure that contains a certificate that is used to validate the signature.
    ///    validationResult = A value that describes the result of the validation check.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> At least one of the <i>signature</i>,
    ///    <i>certificate</i>, and <i>validationResult</i> parameters is <b>NULL</b>. </td> </tr> </table>
    ///    
    HRESULT Validate(IOpcDigitalSignature signature, const(CERT_CONTEXT)* certificate, 
                     OPC_SIGNATURE_VALIDATION_RESULT* validationResult);
    ///Signs the package by generating a signature by using the specified certificate and IOpcSigningOptions interface
    ///pointer. The resultant signature is represented by an IOpcDigitalSignature interface pointer.
    ///Params:
    ///    certificate = A pointer to a CERT_CONTEXT structure that contains the certificate.
    ///    signingOptions = An IOpcSigningOptions interface pointer that is used to generate the signature.
    ///    digitalSignature = A new IOpcDigitalSignature interface pointer that represents the signature.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> At least one of the <i>certificate</i>,
    ///    <i>signingOptions</i>, and <i>digitalSignature</i> parameters is <b>NULL</b>. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>OPC_E_DS_DEFAULT_DIGEST_METHOD_NOT_SET</b></dt> <dt>0x80510047</dt> </dl> </td> <td
    ///    width="60%"> The default digest method has not been set; to set it, call
    ///    IOpcSigningOptions::SetDefaultDigestMethod. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>OPC_E_DS_DIGEST_VALUE_ERROR</b></dt> <dt>0x8051001A</dt> </dl> </td> <td width="60%"> Cannot get the
    ///    digest value of a package component or an element in the signature markup that was referenced for signing.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>OPC_E_DS_INVALID_OPC_SIGNATURE_TIME_FORMAT</b></dt>
    ///    <dt>0x80510024</dt> </dl> </td> <td width="60%"> The signature's time format is not a valid
    ///    OPC_SIGNATURE_TIME_FORMAT enumeration value. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>OPC_E_DS_INVALID_RELATIONSHIPS_SIGNING_OPTION</b></dt> <dt>0x80510023</dt> </dl> </td> <td
    ///    width="60%"> An indicated relationship signing option is not a valid OPC_RELATIONSHIPS_SIGNING_OPTION
    ///    enumeration value. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>OPC_E_DS_SIGNATURE_CORRUPT</b></dt>
    ///    <dt>0x80510019</dt> </dl> </td> <td width="60%"> A signature in the package is not properly formed. Cannot
    ///    get the signature value. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>OPC_E_DS_SIGNATURE_METHOD_NOT_SET</b></dt> <dt>0x80510046</dt> </dl> </td> <td width="60%"> The
    ///    signature method has not been set. Call IOpcSigningOptions::SetSignatureMethod to set the signature method.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>OPC_E_NO_SUCH_PART</b></dt> <dt>0x80510018</dt> </dl> </td> <td
    ///    width="60%"> The specified part does not exist. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>Cryptography
    ///    error</b></dt> </dl> </td> <td width="60%"> An <b>HRESULT</b> error code from a Cryptography API. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>Windows Web Services error</b></dt> </dl> </td> <td width="60%"> An
    ///    <b>HRESULT</b> error code from a Windows Web Services API. </td> </tr> </table>
    ///    
    HRESULT Sign(const(CERT_CONTEXT)* certificate, IOpcSigningOptions signingOptions, 
                 IOpcDigitalSignature* digitalSignature);
    ///Replaces the existing signature markup that is stored in a specified signature part.
    ///Params:
    ///    signaturePartName = An IOpcPartUri interface pointer that represents the part name of the signature part that stores the existing
    ///                        signature markup.
    ///    newSignatureXml = A buffer that contains the signature markup that will replace the existing markup.
    ///    count = The size of the <i>newSignatureXml</i> buffer.
    ///    digitalSignature = A pointer to a new IOpcDigitalSignature interface that represents the signature derived from the signature
    ///                       markup that is passed in <i>newSignatureXml</i>.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> At least one of the <i>signaturePartName</i>,
    ///    <i>newSignatureXml</i>, and <i>digitalSignature</i> parameters is <b>NULL</b>. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>OPC_E_DS_DUPLICATE_PACKAGE_OBJECT_REFERENCES</b></dt> <dt>0x8051002D</dt> </dl>
    ///    </td> <td width="60%"> The <i>newSignatureXml</i> buffer contains more than one <b>Reference</b> element that
    ///    refers to the package <b>Object</b> element, but only one such <b>Reference</b> is allowed. </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>OPC_E_DS_DUPLICATE_SIGNATURE_PROPERTY_ELEMENT</b></dt> <dt>0x80510028</dt> </dl>
    ///    </td> <td width="60%"> The <i>newSignatureXml</i> buffer contains more than one <b>SignatureProperty</b>
    ///    element that has the same <b>Id</b> attribute. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>OPC_E_DS_EXTERNAL_SIGNATURE_REFERENCE</b></dt> <dt>0x8051002F</dt> </dl> </td> <td width="60%"> In the
    ///    <i>newSignatureXml</i> buffer, a <b>Reference</b> element refers to an object that is external to the
    ///    package. <b>Reference</b> elements must point to parts or <b>Object</b> elements that are internal. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>OPC_E_DS_INVALID_CANONICALIZATION_METHOD</b></dt> <dt>0x80510022</dt>
    ///    </dl> </td> <td width="60%"> An unsupported canonicalization method was requested or used in the
    ///    <i>newSignatureXml</i> buffer. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>OPC_E_DS_INVALID_RELATIONSHIP_TRANSFORM_XML</b></dt> <dt>0x80510021</dt> </dl> </td> <td width="60%">
    ///    In the <i>newSignatureXml</i> buffer, a <b>Transform</b> element that indicates the use of the relationships
    ///    transform and the selection criteria for the transform does not conform to the schema specified in the
    ///    <i>OPC</i>. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>OPC_E_DS_INVALID_SIGNATURE_COUNT</b></dt>
    ///    <dt>0x8051002B</dt> </dl> </td> <td width="60%"> The <i>newSignatureXml</i> buffer does not contain the
    ///    signature markup for exactly one signature. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>OPC_E_DS_INVALID_SIGNATURE_XML</b></dt> <dt>0x8051002A</dt> </dl> </td> <td width="60%"> The size of
    ///    the <i>newSignatureXml</i> buffer is 0, but this buffer must have a size that is greater than 0. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>OPC_E_DS_MISSING_CANONICALIZATION_TRANSFORM</b></dt> <dt>0x80510032</dt>
    ///    </dl> </td> <td width="60%"> In the <i>newSignatureXml</i> buffer, a relationships transform is not followed
    ///    by a canonicalization method; the relationships transform must be followed by a canonicalization method.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>OPC_E_DS_MISSING_PACKAGE_OBJECT_REFERENCE</b></dt>
    ///    <dt>0x8051002E</dt> </dl> </td> <td width="60%"> In the <i>newSignatureXml</i> buffer, a <b>Reference</b> to
    ///    the package-specific <b>Object</b> element was not found. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>OPC_E_DS_MISSING_SIGNATURE_ALGORITHM</b></dt> <dt>0x8051002C</dt> </dl> </td> <td width="60%"> The
    ///    signature markup in the <i>newSignatureXml</i> buffer does not specify a signature method algorithm. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>OPC_E_DS_MISSING_SIGNATURE_PROPERTIES_ELEMENT</b></dt>
    ///    <dt>0x80510026</dt> </dl> </td> <td width="60%"> In the <i>newSignatureXml</i> buffer, the
    ///    <b>SignatureProperties </b> element was not found. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>OPC_E_DS_MISSING_SIGNATURE_PROPERTY_ELEMENT</b></dt> <dt>0x80510027</dt> </dl> </td> <td width="60%">
    ///    In the <i>newSignatureXml</i> buffer, the <b>SignatureProperty</b> child element of the
    ///    <b>SignatureProperties</b> element was not found. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>OPC_E_DS_MISSING_SIGNATURE_TIME_PROPERTY</b></dt> <dt>0x80510029</dt> </dl> </td> <td width="60%"> In
    ///    the <i>newSignatureXml</i> buffer, the <b>SignatureProperty</b> element with the <b>Id</b> attribute value of
    ///    "idSignatureTime" does not exist or is not correctly constructed. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>OPC_E_DS_MULTIPLE_RELATIONSHIP_TRANSFORMS</b></dt> <dt>0x80510031</dt> </dl> </td> <td width="60%"> In
    ///    the <i>newSignatureXml</i> buffer, more than one relationships transform is specified for a <b>Reference</b>
    ///    element, but only one relationships transform is allowed. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>OPC_E_DS_REFERENCE_MISSING_CONTENT_TYPE</b></dt> <dt>0x80510030</dt> </dl> </td> <td width="60%"> The
    ///    <b>URI</b> attribute value of a <b>Reference</b> element in the <i>newSignatureXml</i> buffer does not
    ///    include the content type of the referenced part. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>OPC_E_DS_SIGNATURE_PROPERTY_MISSING_TARGET</b></dt> <dt>0x80510045</dt> </dl> </td> <td width="60%">
    ///    In the <i>newSignatureXml</i> buffer, the <b>SignatureProperty</b> element is missing the required
    ///    <b>Target</b> attribute. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>OPC_E_DS_SIGNATURE_REFERENCE_MISSING_URI</b></dt> <dt>0x80510043</dt> </dl> </td> <td width="60%"> A
    ///    <b>Reference</b> element, which is in the <i>newSignatureXml</i> buffer, requires the <b>URI</b> attribute,
    ///    but the attribute is missing. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>OPC_E_DS_UNSIGNED_PACKAGE</b></dt> <dt>0x80510055</dt> </dl> </td> <td width="60%"> The package is not
    ///    signed; therefore, the signature markup cannot be replaced. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>OPC_E_NO_SUCH_PART</b></dt> <dt>0x80510018</dt> </dl> </td> <td width="60%"> The specified part does
    ///    not exist. </td> </tr> </table>
    ///    
    HRESULT ReplaceSignatureXml(IOpcPartUri signaturePartName, const(ubyte)* newSignatureXml, uint count, 
                                IOpcDigitalSignature* digitalSignature);
}

///A read-only enumerator of IOpcSignaturePartReference interface pointers.
@GUID("80EB1561-8C77-49CF-8266-459B356EE99A")
interface IOpcSignaturePartReferenceEnumerator : IUnknown
{
    ///Moves the current position of the enumerator to the next IOpcSignaturePartReference interface pointer.
    ///Params:
    ///    hasNext = A Boolean value that indicates the status of the IOpcSignaturePartReference interface pointer at the current
    ///              position. The value of <i>hasNext</i> is only valid when the method succeeds. <table> <tr> <th>Value</th>
    ///              <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt>TRUE</dt> </dl> </td> <td width="60%"> The current
    ///              position of the enumerator has been advanced to the next pointer and that pointer is valid. </td> </tr> <tr>
    ///              <td width="40%"> <dl> <dt>FALSE</dt> </dl> </td> <td width="60%"> The current position of the enumerator has
    ///              been advanced past the end of the collection and is no longer valid. </td> </tr> </table>
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> The <i>hasNext</i> parameter is <b>NULL</b>.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>OPC_E_ENUM_CANNOT_MOVE_NEXT</b></dt> <dt>0x80510051</dt> </dl>
    ///    </td> <td width="60%"> The current position is already past the last item of the enumerator. </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>OPC_E_ENUM_COLLECTION_CHANGED</b></dt> <dt>0x80510050</dt> </dl> </td> <td
    ///    width="60%"> The enumerator is invalid because the underlying set has changed. </td> </tr> </table>
    ///    
    HRESULT MoveNext(int* hasNext);
    ///Moves the current position of the enumerator to the previous IOpcSignaturePartReference interface pointer.
    ///Params:
    ///    hasPrevious = A Boolean value that indicates the status of the IOpcSignaturePartReference interface pointer at the current
    ///                  position. The value of <i>hasPrevious</i> is only valid when the method succeeds. <table> <tr> <th>Value</th>
    ///                  <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt>TRUE</dt> </dl> </td> <td width="60%"> The current
    ///                  position of the enumerator has been moved to the previous pointer in the collection, and that pointer is
    ///                  valid. </td> </tr> <tr> <td width="40%"> <dl> <dt>FALSE</dt> </dl> </td> <td width="60%"> The current
    ///                  position of the enumerator has been moved past the beginning of the collection and is no longer valid. </td>
    ///                  </tr> </table>
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> The <i>hasPrevious</i> parameter is <b>NULL</b>.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>OPC_E_ENUM_CANNOT_MOVE_PREVIOUS</b></dt> <dt>0x80510052</dt>
    ///    </dl> </td> <td width="60%"> The current position already precedes the first item of the enumerator. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>OPC_E_ENUM_COLLECTION_CHANGED</b></dt> <dt>0x80510050</dt> </dl>
    ///    </td> <td width="60%"> The enumerator is invalid because the underlying set has changed. </td> </tr> </table>
    ///    
    HRESULT MovePrevious(int* hasPrevious);
    ///Gets the IOpcSignaturePartReference interface pointer at the current position of the enumerator.
    ///Params:
    ///    partReference = An IOpcSignaturePartReference interface pointer.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> The <i>partReference</i> parameter is
    ///    <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>OPC_E_ENUM_COLLECTION_CHANGED</b></dt>
    ///    <dt>0x80510050</dt> </dl> </td> <td width="60%"> The enumerator is invalid because the underlying set has
    ///    changed. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>OPC_E_ENUM_INVALID_POSITION</b></dt>
    ///    <dt>0x80510053</dt> </dl> </td> <td width="60%"> The enumerator cannot perform this operation from its
    ///    current position. </td> </tr> </table>
    ///    
    HRESULT GetCurrent(IOpcSignaturePartReference* partReference);
    ///Creates a copy of the current IOpcSignaturePartReferenceEnumerator interface pointer and all its descendants.
    ///Params:
    ///    copy = A pointer to a copy of the IOpcSignaturePartReferenceEnumerator interface pointer.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> The <i>copy</i> parameter is <b>NULL</b>. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>OPC_E_ENUM_COLLECTION_CHANGED</b></dt> <dt>0x80510050</dt> </dl>
    ///    </td> <td width="60%"> The enumerator is invalid because the underlying set has changed. </td> </tr> </table>
    ///    
    HRESULT Clone(IOpcSignaturePartReferenceEnumerator* copy);
}

///A read-only enumerator of IOpcSignatureRelationshipReference interface pointers.
@GUID("773BA3E4-F021-48E4-AA04-9816DB5D3495")
interface IOpcSignatureRelationshipReferenceEnumerator : IUnknown
{
    ///Moves the current position of the enumerator to the next IOpcSignatureRelationshipReference interface pointer.
    ///Params:
    ///    hasNext = A Boolean value that indicates the status of the IOpcSignatureRelationshipReference interface pointer at the
    ///              current position. The value of <i>hasNext</i> is only valid when the method succeeds. <table> <tr>
    ///              <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt>TRUE</dt> </dl> </td> <td width="60%">
    ///              The current position of the enumerator has been advanced to the next pointer and that pointer is valid. </td>
    ///              </tr> <tr> <td width="40%"> <dl> <dt>FALSE</dt> </dl> </td> <td width="60%"> The current position of the
    ///              enumerator has been advanced past the end of the collection and is no longer valid. </td> </tr> </table>
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> The <i>hasNext</i> parameter is <b>NULL</b>.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>OPC_E_ENUM_CANNOT_MOVE_NEXT</b></dt> <dt>0x80510051</dt> </dl>
    ///    </td> <td width="60%"> The current position is already past the last item of the enumerator. </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>OPC_E_ENUM_COLLECTION_CHANGED</b></dt> <dt>0x80510050</dt> </dl> </td> <td
    ///    width="60%"> The enumerator is invalid because the underlying set has changed. </td> </tr> </table>
    ///    
    HRESULT MoveNext(int* hasNext);
    ///Moves the current position of the enumerator to the previous IOpcSignatureRelationshipReference interface
    ///pointer.
    ///Params:
    ///    hasPrevious = A Boolean value that indicates the status of the IOpcSignatureRelationshipReference interface pointer at the
    ///                  current position. The value of <i>hasPrevious</i> is only valid when the method succeeds. <table> <tr>
    ///                  <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt>TRUE</dt> </dl> </td> <td width="60%">
    ///                  The current position of the enumerator has been moved to the previous pointer in the collection, and that
    ///                  pointer is valid. </td> </tr> <tr> <td width="40%"> <dl> <dt>FALSE</dt> </dl> </td> <td width="60%"> The
    ///                  current position of the enumerator has been moved past the beginning of the collection and is no longer
    ///                  valid. </td> </tr> </table>
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> The <i>hasPrevious</i> parameter is <b>NULL</b>.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>OPC_E_ENUM_COLLECTION_CHANGED</b></dt> <dt>0x80510050</dt>
    ///    </dl> </td> <td width="60%"> The enumerator is invalid because the underlying set has changed. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>OPC_E_ENUM_CANNOT_MOVE_PREVIOUS</b></dt> <dt>0x80510052</dt> </dl> </td>
    ///    <td width="60%"> The current position already precedes the first item of the enumerator. </td> </tr> </table>
    ///    
    HRESULT MovePrevious(int* hasPrevious);
    ///Gets the IOpcSignatureRelationshipReference interface pointer at the current position of the enumerator.
    ///Params:
    ///    relationshipReference = An IOpcSignatureRelationshipReference interface pointer.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> The <i>partReference</i> parameter is
    ///    <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>OPC_E_ENUM_COLLECTION_CHANGED</b></dt>
    ///    <dt>0x80510050</dt> </dl> </td> <td width="60%"> The enumerator is invalid because the underlying set has
    ///    changed. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>OPC_E_ENUM_INVALID_POSITION</b></dt>
    ///    <dt>0x80510053</dt> </dl> </td> <td width="60%"> The enumerator cannot perform this operation from its
    ///    current position. </td> </tr> </table>
    ///    
    HRESULT GetCurrent(IOpcSignatureRelationshipReference* relationshipReference);
    ///Creates a copy of the current IOpcSignatureRelationshipReferenceEnumerator interface pointer and all its
    ///descendants.
    ///Params:
    ///    copy = A pointer to a copy of the IOpcSignatureRelationshipReferenceEnumerator interface pointer.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> The <i>copy</i> parameter is <b>NULL</b>. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>OPC_E_ENUM_COLLECTION_CHANGED</b></dt> <dt>0x80510050</dt> </dl>
    ///    </td> <td width="60%"> The enumerator is invalid because the underlying set has changed. </td> </tr> </table>
    ///    
    HRESULT Clone(IOpcSignatureRelationshipReferenceEnumerator* copy);
}

///A read-only enumerator of IOpcRelationshipSelector interface pointers.
@GUID("5E50A181-A91B-48AC-88D2-BCA3D8F8C0B1")
interface IOpcRelationshipSelectorEnumerator : IUnknown
{
    ///Moves the current position of the enumerator to the next IOpcRelationshipSelectorinterface pointer.
    ///Params:
    ///    hasNext = A Boolean value that indicates the status of the IOpcRelationshipSelector interface pointer at the current
    ///              position. The value of <i>hasNext</i> is only valid when the method succeeds. <table> <tr> <th>Value</th>
    ///              <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt>TRUE</dt> </dl> </td> <td width="60%"> The current
    ///              position of the enumerator has been advanced to the next pointer and that pointer is valid. </td> </tr> <tr>
    ///              <td width="40%"> <dl> <dt>FALSE</dt> </dl> </td> <td width="60%"> The current position of the enumerator has
    ///              been advanced past the end of the collection and is no longer valid. </td> </tr> </table>
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> The <i>hasNext</i> parameter is <b>NULL</b>.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>OPC_E_ENUM_CANNOT_MOVE_NEXT</b></dt> <dt>0x80510051</dt> </dl>
    ///    </td> <td width="60%"> The current position is already past the last item of the enumerator. </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>OPC_E_ENUM_COLLECTION_CHANGED</b></dt> <dt>0x80510050</dt> </dl> </td> <td
    ///    width="60%"> The enumerator is invalid because the underlying set has changed. </td> </tr> </table>
    ///    
    HRESULT MoveNext(int* hasNext);
    ///Moves the current position of the enumerator to the previous IOpcRelationshipSelectorinterface pointer.
    ///Params:
    ///    hasPrevious = A Boolean value that indicates the status of the IOpcRelationshipSelectorinterface pointer at the current
    ///                  position. The value of <i>hasPrevious</i> is only valid when the method succeeds. <table> <tr> <th>Value</th>
    ///                  <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt>TRUE</dt> </dl> </td> <td width="60%"> The current
    ///                  position of the enumerator has been moved to the previous pointer in the collection, and that pointer is
    ///                  valid. </td> </tr> <tr> <td width="40%"> <dl> <dt>FALSE</dt> </dl> </td> <td width="60%"> The current
    ///                  position of the enumerator has been moved past the beginning of the collection and is no longer valid. </td>
    ///                  </tr> </table>
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> The <i>hasPrevious</i> parameter is <b>NULL</b>.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>OPC_E_ENUM_CANNOT_MOVE_PREVIOUS</b></dt> <dt>0x80510052</dt>
    ///    </dl> </td> <td width="60%"> The current position already precedes the first item of the enumerator. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>OPC_E_ENUM_COLLECTION_CHANGED</b></dt> <dt>0x80510050</dt> </dl>
    ///    </td> <td width="60%"> The enumerator is invalid because the underlying set has changed. </td> </tr> </table>
    ///    
    HRESULT MovePrevious(int* hasPrevious);
    ///Gets the IOpcRelationshipSelector interface pointer at the current position of the enumerator.
    ///Params:
    ///    relationshipSelector = An IOpcRelationshipSelector interface pointer .
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> The <i>partReference</i> parameter is
    ///    <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>OPC_E_ENUM_COLLECTION_CHANGED</b></dt>
    ///    <dt>0x80510050</dt> </dl> </td> <td width="60%"> The enumerator is invalid because the underlying set has
    ///    changed. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>OPC_E_ENUM_INVALID_POSITION</b></dt>
    ///    <dt>0x80510053</dt> </dl> </td> <td width="60%"> The enumerator cannot perform this operation from its
    ///    current position. </td> </tr> </table>
    ///    
    HRESULT GetCurrent(IOpcRelationshipSelector* relationshipSelector);
    ///Creates a copy of the current IOpcRelationshipSelectorEnumeratorinterface pointer and all its descendants.
    ///Params:
    ///    copy = A pointer to a copy of the IOpcRelationshipSelectorEnumeratorinterface pointer.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> The <i>copy</i> parameter is <b>NULL</b>. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>OPC_E_ENUM_COLLECTION_CHANGED</b></dt> <dt>0x80510050</dt> </dl>
    ///    </td> <td width="60%"> The enumerator is invalid because the underlying set has changed. </td> </tr> </table>
    ///    
    HRESULT Clone(IOpcRelationshipSelectorEnumerator* copy);
}

///A read-only enumerator of IOpcSignatureReference interface pointers.
@GUID("CFA59A45-28B1-4868-969E-FA8097FDC12A")
interface IOpcSignatureReferenceEnumerator : IUnknown
{
    ///Moves the current position of the enumerator to the next IOpcSignatureReference interface pointer.
    ///Params:
    ///    hasNext = A Boolean value that indicates the status of the IOpcSignatureReference interface pointer at the current
    ///              position. The value of <i>hasNext</i> is only valid when the method succeeds. <table> <tr> <th>Value</th>
    ///              <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt>TRUE</dt> </dl> </td> <td width="60%"> The current
    ///              position of the enumerator has been advanced to the next pointer and that pointer is valid. </td> </tr> <tr>
    ///              <td width="40%"> <dl> <dt>FALSE</dt> </dl> </td> <td width="60%"> The current position of the enumerator has
    ///              been advanced past the end of the collection and is no longer valid. </td> </tr> </table>
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> The <i>hasNext</i> parameter is <b>NULL</b>.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>OPC_E_ENUM_CANNOT_MOVE_NEXT</b></dt> <dt>0x80510051</dt> </dl>
    ///    </td> <td width="60%"> The current position is already past the last item of the enumerator. </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>OPC_E_ENUM_COLLECTION_CHANGED</b></dt> <dt>0x80510050</dt> </dl> </td> <td
    ///    width="60%"> The enumerator is invalid because the underlying set has changed. </td> </tr> </table>
    ///    
    HRESULT MoveNext(int* hasNext);
    ///Moves the current position of the enumerator to the previous IOpcSignatureReferenceinterface pointer.
    ///Params:
    ///    hasPrevious = A Boolean value that indicates the status of the IOpcSignatureReference interface pointer at the current
    ///                  position. The value of <i>hasPrevious</i> is only valid when the method succeeds. <table> <tr> <th>Value</th>
    ///                  <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt>TRUE</dt> </dl> </td> <td width="60%"> The current
    ///                  position of the enumerator has been moved to the previous pointer in the collection, and that pointer is
    ///                  valid. </td> </tr> <tr> <td width="40%"> <dl> <dt>FALSE</dt> </dl> </td> <td width="60%"> The current
    ///                  position of the enumerator has been moved past the beginning of the collection and is no longer valid. </td>
    ///                  </tr> </table>
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> The <i>hasPrevious</i> parameter is <b>NULL</b>.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>OPC_E_ENUM_COLLECTION_CHANGED</b></dt> <dt>0x80510050</dt>
    ///    </dl> </td> <td width="60%"> The enumerator is invalid because the underlying set has changed. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>OPC_E_ENUM_CANNOT_MOVE_PREVIOUS</b></dt> <dt>0x80510052</dt> </dl> </td>
    ///    <td width="60%"> The current position already precedes the first item of the enumerator. </td> </tr> </table>
    ///    
    HRESULT MovePrevious(int* hasPrevious);
    ///Gets the IOpcSignatureReference interface pointer at the current position of the enumerator.
    ///Params:
    ///    reference = An IOpcSignatureReference interface pointer.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> The <i>partReference</i> parameter is
    ///    <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>OPC_E_ENUM_COLLECTION_CHANGED</b></dt>
    ///    <dt>0x80510050</dt> </dl> </td> <td width="60%"> The enumerator is invalid because the underlying set has
    ///    changed. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>OPC_E_ENUM_INVALID_POSITION</b></dt>
    ///    <dt>0x80510053</dt> </dl> </td> <td width="60%"> The enumerator cannot perform this operation from its
    ///    current position. </td> </tr> </table>
    ///    
    HRESULT GetCurrent(IOpcSignatureReference* reference);
    ///Creates a copy of the current IOpcSignatureReferenceEnumerator interface pointer and all its descendants.
    ///Params:
    ///    copy = A pointer to a copy of the IOpcSignatureReferenceEnumerator interface pointer.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> The <i>copy</i> parameter is <b>NULL</b>. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>OPC_E_ENUM_COLLECTION_CHANGED</b></dt> <dt>0x80510050</dt> </dl>
    ///    </td> <td width="60%"> The enumerator is invalid because the underlying set has changed. </td> </tr> </table>
    ///    
    HRESULT Clone(IOpcSignatureReferenceEnumerator* copy);
}

///A read-only enumerator of IOpcSignatureCustomObject interface pointers.
@GUID("5EE4FE1D-E1B0-4683-8079-7EA0FCF80B4C")
interface IOpcSignatureCustomObjectEnumerator : IUnknown
{
    ///Moves the current position of the enumerator to the next IOpcSignatureCustomObject interface pointer.
    ///Params:
    ///    hasNext = A Boolean value that indicates the status of the IOpcSignatureCustomObject interface pointer at the current
    ///              position. The value of <i>hasNext</i> is only valid when the method succeeds. <table> <tr> <th>Value</th>
    ///              <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt>TRUE</dt> </dl> </td> <td width="60%"> The current
    ///              position of the enumerator has been advanced to the next pointer and that pointer is valid. </td> </tr> <tr>
    ///              <td width="40%"> <dl> <dt>FALSE</dt> </dl> </td> <td width="60%"> The current position of the enumerator has
    ///              been advanced past the end of the collection and is no longer valid. </td> </tr> </table>
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> The <i>hasNext</i> parameter is <b>NULL</b>.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>OPC_E_ENUM_CANNOT_MOVE_NEXT</b></dt> <dt>0x80510051</dt> </dl>
    ///    </td> <td width="60%"> The current position is already past the last item of the enumerator. </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>OPC_E_ENUM_COLLECTION_CHANGED</b></dt> <dt>0x80510050</dt> </dl> </td> <td
    ///    width="60%"> The enumerator is invalid because the underlying set has changed. </td> </tr> </table>
    ///    
    HRESULT MoveNext(int* hasNext);
    ///Moves the current position of the enumerator to the previous IOpcSignatureCustomObjectinterface pointer.
    ///Params:
    ///    hasPrevious = A Boolean value that indicates the status of the IOpcSignatureCustomObjectinterface pointer at the current
    ///                  position. The value of <i>hasPrevious</i> is only valid when the method succeeds. <table> <tr> <th>Value</th>
    ///                  <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt>TRUE</dt> </dl> </td> <td width="60%"> The current
    ///                  position of the enumerator has been moved to the previous pointer in the collection, and that pointer is
    ///                  valid. </td> </tr> <tr> <td width="40%"> <dl> <dt>FALSE</dt> </dl> </td> <td width="60%"> The current
    ///                  position of the enumerator has been moved past the beginning of the collection and is no longer valid. </td>
    ///                  </tr> </table>
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> The <i>hasPrevious</i> parameter is <b>NULL</b>.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>OPC_E_ENUM_COLLECTION_CHANGED</b></dt> <dt>0x80510050</dt>
    ///    </dl> </td> <td width="60%"> The enumerator is invalid because the underlying set has changed. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>OPC_E_ENUM_CANNOT_MOVE_PREVIOUS</b></dt> <dt>0x80510052</dt> </dl> </td>
    ///    <td width="60%"> The current position already precedes the first item of the enumerator. </td> </tr> </table>
    ///    
    HRESULT MovePrevious(int* hasPrevious);
    ///Gets the IOpcSignatureCustomObject interface at the current position of the enumerator.
    ///Params:
    ///    customObject = An IOpcSignatureCustomObject interface pointer.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> The <i>partReference</i> parameter is
    ///    <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>OPC_E_ENUM_COLLECTION_CHANGED</b></dt>
    ///    <dt>0x80510050</dt> </dl> </td> <td width="60%"> The enumerator is invalid because the underlying set has
    ///    changed. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>OPC_E_ENUM_INVALID_POSITION</b></dt>
    ///    <dt>0x80510053</dt> </dl> </td> <td width="60%"> The enumerator cannot perform this operation from its
    ///    current position. </td> </tr> </table>
    ///    
    HRESULT GetCurrent(IOpcSignatureCustomObject* customObject);
    ///Creates a copy of the current IOpcSignatureCustomObjectEnumerator interface pointer and all its descendants.
    ///Params:
    ///    copy = A pointer to a copy of the IOpcSignatureCustomObjectEnumeratorinterface pointer.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> The <i>copy</i> parameter is <b>NULL</b>. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>OPC_E_ENUM_COLLECTION_CHANGED</b></dt> <dt>0x80510050</dt> </dl>
    ///    </td> <td width="60%"> The enumerator is invalid because the underlying set has changed. </td> </tr> </table>
    ///    
    HRESULT Clone(IOpcSignatureCustomObjectEnumerator* copy);
}

///A read-only enumerator of pointers to CERT_CONTEXT structures.
@GUID("85131937-8F24-421F-B439-59AB24D140B8")
interface IOpcCertificateEnumerator : IUnknown
{
    ///Moves the current position of the enumerator to the next CERT_CONTEXT structure.
    ///Params:
    ///    hasNext = A Boolean value that indicates the status of the CERT_CONTEXT structure at the current position. The value of
    ///              <i>hasNext</i> is only valid when the method succeeds. <table> <tr> <th>Value</th> <th>Meaning</th> </tr>
    ///              <tr> <td width="40%"> <dl> <dt>TRUE</dt> </dl> </td> <td width="60%"> The current position of the enumerator
    ///              has been advanced to the next pointer and that pointer is valid. </td> </tr> <tr> <td width="40%"> <dl>
    ///              <dt>FALSE</dt> </dl> </td> <td width="60%"> The current position of the enumerator has been advanced past the
    ///              end of the collection and is no longer valid. </td> </tr> </table>
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> The <i>hasNext</i> parameter is <b>NULL</b>.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>OPC_E_ENUM_CANNOT_MOVE_NEXT</b></dt> <dt>0x80510051</dt> </dl>
    ///    </td> <td width="60%"> The current position is already past the last item of the enumerator. </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>OPC_E_ENUM_COLLECTION_CHANGED</b></dt> <dt>0x80510050</dt> </dl> </td> <td
    ///    width="60%"> The enumerator is invalid because the underlying set has changed. </td> </tr> </table>
    ///    
    HRESULT MoveNext(int* hasNext);
    ///Moves the current position of the enumerator to the previous CERT_CONTEXT structure.
    ///Params:
    ///    hasPrevious = A Boolean value that indicates the status of the CERT_CONTEXT structure at the current position. The value of
    ///                  <i>hasPrevious</i> is only valid when the method succeeds. <table> <tr> <th>Value</th> <th>Meaning</th> </tr>
    ///                  <tr> <td width="40%"> <dl> <dt>TRUE</dt> </dl> </td> <td width="60%"> The current position of the enumerator
    ///                  has been moved to the previous pointer in the collection, and that pointer is valid. </td> </tr> <tr> <td
    ///                  width="40%"> <dl> <dt>FALSE</dt> </dl> </td> <td width="60%"> The current position of the enumerator has been
    ///                  moved past the beginning of the collection and is no longer valid. </td> </tr> </table>
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> The <i>hasPrevious</i> parameter is <b>NULL</b>.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>OPC_E_ENUM_COLLECTION_CHANGED</b></dt> <dt>0x80510050</dt>
    ///    </dl> </td> <td width="60%"> The enumerator is invalid because the underlying set has changed. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>OPC_E_ENUM_CANNOT_MOVE_PREVIOUS</b></dt> <dt>0x80510052</dt> </dl> </td>
    ///    <td width="60%"> The current position already precedes the first item of the enumerator. </td> </tr> </table>
    ///    
    HRESULT MovePrevious(int* hasPrevious);
    ///Gets the CERT_CONTEXT structure at the current position of the enumerator.
    ///Params:
    ///    certificate = A pointer to a CERT_CONTEXT structure. If the method succeeds, call the CertFreeCertificateContext function
    ///                  to free the memory of the structure.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> The <i>partReference</i> parameter is
    ///    <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>OPC_E_ENUM_COLLECTION_CHANGED</b></dt>
    ///    <dt>0x80510050</dt> </dl> </td> <td width="60%"> The enumerator is invalid because the underlying set has
    ///    changed. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>OPC_E_ENUM_INVALID_POSITION</b></dt>
    ///    <dt>0x80510053</dt> </dl> </td> <td width="60%"> The enumerator cannot perform this operation from its
    ///    current position. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>OPC_E_DS_EXTERNAL_SIGNATURE</b></dt>
    ///    <dt>0x8051001E</dt> </dl> </td> <td width="60%"> A relationship whose target is a Signature part has the
    ///    external target mode; Signature parts must be inside of the package. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>OPC_E_DS_INVALID_CERTIFICATE_RELATIONSHIP</b></dt> <dt>0x8051001D</dt> </dl> </td> <td width="60%"> A
    ///    relationship of type digital signature certificate has the external target mode. For more information about
    ///    this relationship type, see the <i>OPC</i>. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>OPC_E_DS_INVALID_RELATIONSHIP_TRANSFORM_XML</b></dt> <dt>0x80510021</dt> </dl> </td> <td width="60%">
    ///    A <b>Transform</b> element that indicates the use of the relationships transform and the selection criteria
    ///    for the transform does not conform to the schema specified in the <i>OPC</i>. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>OPC_E_DS_MISSING_CERTIFICATE_PART</b></dt> <dt>0x80510056</dt> </dl> </td> <td
    ///    width="60%"> The part that contains the certificate and is the target of a relationship of type digital
    ///    signature certificate does not exist. For more information about this relationship type, see the <i>OPC</i>.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>OPC_E_DS_SIGNATURE_PROPERTY_MISSING_TARGET</b></dt>
    ///    <dt>0x80510045</dt> </dl> </td> <td width="60%"> The <b>SignatureProperty</b> element is missing the required
    ///    <b>Target</b> attribute. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>OPC_E_UNEXPECTED_CONTENT_TYPE</b></dt>
    ///    <dt>0x80510005</dt> </dl> </td> <td width="60%"> Either the content type of a part differed from the expected
    ///    content type (specified in the OPC, ECMA-376 Part 2), or the part content did not match the part's content
    ///    type. </td> </tr> </table>
    ///    
    HRESULT GetCurrent(const(CERT_CONTEXT)** certificate);
    ///Creates a copy of the current IOpcCertificateEnumerator interface pointer and all its descendants.
    ///Params:
    ///    copy = A pointer to a copy of the IOpcCertificateEnumerator interface pointer.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> The <i>copy</i> parameter is <b>NULL</b>. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>OPC_E_ENUM_COLLECTION_CHANGED</b></dt> <dt>0x80510050</dt> </dl>
    ///    </td> <td width="60%"> The enumerator is invalid because the underlying set has changed. </td> </tr> </table>
    ///    
    HRESULT Clone(IOpcCertificateEnumerator* copy);
}

///A read-only enumerator of IOpcDigitalSignature interface pointers.
@GUID("967B6882-0BA3-4358-B9E7-B64C75063C5E")
interface IOpcDigitalSignatureEnumerator : IUnknown
{
    ///Moves the current position of the enumerator to the next IOpcDigitalSignature interface pointer.
    ///Params:
    ///    hasNext = A Boolean value that indicates the status of the IOpcDigitalSignature interface pointer at the current
    ///              position. The value of <i>hasNext</i> is only valid when the method succeeds. <table> <tr> <th>Value</th>
    ///              <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt>TRUE</dt> </dl> </td> <td width="60%"> The current
    ///              position of the enumerator has been advanced to the next pointer and that pointer is valid. </td> </tr> <tr>
    ///              <td width="40%"> <dl> <dt>FALSE</dt> </dl> </td> <td width="60%"> The current position of the enumerator has
    ///              been advanced past the end of the collection and is no longer valid. </td> </tr> </table>
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> The <i>hasNext</i> parameter is <b>NULL</b>.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>OPC_E_ENUM_CANNOT_MOVE_NEXT</b></dt> <dt>0x80510051</dt> </dl>
    ///    </td> <td width="60%"> The current position is already past the last item of the enumerator. </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>OPC_E_ENUM_COLLECTION_CHANGED</b></dt> <dt>0x80510050</dt> </dl> </td> <td
    ///    width="60%"> The enumerator is invalid because the underlying set has changed. </td> </tr> </table>
    ///    
    HRESULT MoveNext(int* hasNext);
    ///Moves the current position of the enumerator to the previous IOpcDigitalSignature interface pointer.
    ///Params:
    ///    hasPrevious = A Boolean value that indicates the status of the IOpcDigitalSignature interface pointer at the current
    ///                  position. The value of <i>hasPrevious</i> is only valid when the method succeeds. <table> <tr> <th>Value</th>
    ///                  <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt>TRUE</dt> </dl> </td> <td width="60%"> The current
    ///                  position of the enumerator has been moved to the previous pointer in the collection, and that pointer is
    ///                  valid. </td> </tr> <tr> <td width="40%"> <dl> <dt>FALSE</dt> </dl> </td> <td width="60%"> The current
    ///                  position of the enumerator has been moved past the beginning of the collection and is no longer valid. </td>
    ///                  </tr> </table>
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> The <i>hasPrevious</i> parameter is <b>NULL</b>.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>OPC_E_ENUM_COLLECTION_CHANGED</b></dt> <dt>0x80510050</dt>
    ///    </dl> </td> <td width="60%"> The enumerator is invalid because the underlying set has changed. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>OPC_E_ENUM_CANNOT_MOVE_PREVIOUS</b></dt> <dt>0x80510052</dt> </dl> </td>
    ///    <td width="60%"> The current position already precedes the first item of the enumerator. </td> </tr> </table>
    ///    
    HRESULT MovePrevious(int* hasPrevious);
    ///Gets the IOpcDigitalSignature interface pointer at the current position of the enumerator.
    ///Params:
    ///    digitalSignature = An IOpcDigitalSignature interface pointer.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> The <i>partReference</i> parameter is
    ///    <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>OPC_E_ENUM_COLLECTION_CHANGED</b></dt>
    ///    <dt>0x80510050</dt> </dl> </td> <td width="60%"> The enumerator is invalid because the underlying set has
    ///    changed. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>OPC_E_ENUM_INVALID_POSITION</b></dt>
    ///    <dt>0x80510053</dt> </dl> </td> <td width="60%"> The enumerator cannot perform this operation from its
    ///    current position. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>OPC_E_DS_DUPLICATE_PACKAGE_OBJECT_REFERENCES</b></dt> <dt>0x8051002D</dt> </dl> </td> <td width="60%">
    ///    The signature markup contains more than one <b>Reference</b> element that refers to the package <b>Object</b>
    ///    element, but only one such <b>Reference</b> is allowed. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>OPC_E_DS_DUPLICATE_SIGNATURE_PROPERTY_ELEMENT</b></dt> <dt>0x80510028</dt> </dl> </td> <td
    ///    width="60%"> The signature markup contains more than one <b>SignatureProperty</b> element that has the same
    ///    <b>Id</b> attribute. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>OPC_E_DS_EXTERNAL_SIGNATURE_REFERENCE</b></dt> <dt>0x8051002F</dt> </dl> </td> <td width="60%"> A
    ///    <b>Reference</b> element in the signature markup indicates an object that is external to the package.
    ///    <b>Reference</b> elements must point to parts or <b>Object</b> elements that are internal. </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>OPC_E_DS_INVALID_CANONICALIZATION_METHOD</b></dt> <dt>0x80510022</dt> </dl>
    ///    </td> <td width="60%"> An unsupported canonicalization method was requested or used in a signature. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>OPC_E_DS_INVALID_SIGNATURE_COUNT</b></dt> <dt>0x8051002B</dt> </dl>
    ///    </td> <td width="60%"> A Signature part does not contain the signature markup for exactly one signature.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>OPC_E_DS_INVALID_SIGNATURE_XML</b></dt> <dt>0x8051002A</dt>
    ///    </dl> </td> <td width="60%"> The signature markup in a Signature part does not conform to the schema
    ///    specified in the <i>OPC</i> or XML-Signature Syntax and Processing (http://www.w3.org/TR/xmldsig-core/).
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>OPC_E_DS_MISSING_CANONICALIZATION_TRANSFORM</b></dt>
    ///    <dt>0x80510032</dt> </dl> </td> <td width="60%"> A relationships transform must be followed by a
    ///    canonicalization method. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>OPC_E_DS_MISSING_PACKAGE_OBJECT_REFERENCE</b></dt> <dt>0x8051002E</dt> </dl> </td> <td width="60%">
    ///    The signature markup is missing a <b>Reference</b> to the package-specific <b>Object</b> element. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>OPC_E_DS_MISSING_SIGNATURE_ALGORITHM</b></dt> <dt>0x8051002C</dt> </dl>
    ///    </td> <td width="60%"> The signature markup does not specify signature method algorithm. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>OPC_E_DS_MISSING_SIGNATURE_PART</b></dt> <dt>0x80510020</dt> </dl> </td> <td
    ///    width="60%"> The specified Signature part does not exist in the package. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>OPC_E_DS_MISSING_SIGNATURE_PROPERTIES_ELEMENT</b></dt> <dt>0x80510026</dt> </dl> </td> <td
    ///    width="60%"> The <b>SignatureProperties </b> element was not found in the signature markup. </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>OPC_E_DS_MISSING_SIGNATURE_PROPERTY_ELEMENT</b></dt> <dt>0x80510027</dt> </dl>
    ///    </td> <td width="60%"> The <b>SignatureProperty</b> child element of the <b>SignatureProperties</b> element
    ///    was not found. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>OPC_E_DS_MISSING_SIGNATURE_TIME_PROPERTY</b></dt> <dt>0x80510029</dt> </dl> </td> <td width="60%"> The
    ///    <b>SignatureProperty</b> element with the <b>Id</b> attribute value of "idSignatureTime" does not exist or is
    ///    not correctly constructed. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>OPC_E_DS_MULTIPLE_RELATIONSHIP_TRANSFORMS</b></dt> <dt>0x80510031</dt> </dl> </td> <td width="60%">
    ///    More than one relationships transform is specified for a <b>Reference</b> element, but only one relationships
    ///    transform is allowed. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>OPC_E_DS_REFERENCE_MISSING_CONTENT_TYPE</b></dt> <dt>0x80510030</dt> </dl> </td> <td width="60%"> The
    ///    <b>URI</b> attribute value of a <b>Reference</b> element in the signature markup does not include the content
    ///    type of the referenced part. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>OPC_E_DS_SIGNATURE_REFERENCE_MISSING_URI</b></dt> <dt>0x80510043</dt> </dl> </td> <td width="60%"> The
    ///    <b>URI</b> attribute is required for a <b>Reference</b> element but is missing. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>OPC_E_UNEXPECTED_CONTENT_TYPE</b></dt> <dt>0x80510005</dt> </dl> </td> <td
    ///    width="60%"> Either the content type of a part differed from the expected content type (specified in the OPC,
    ///    ECMA-376 Part 2), or the part content did not match the part's content type. </td> </tr> </table>
    ///    
    HRESULT GetCurrent(IOpcDigitalSignature* digitalSignature);
    ///Creates a copy of the current IOpcDigitalSignatureEnumerator interface pointer and all its descendants.
    ///Params:
    ///    copy = A pointer to a copy of the IOpcDigitalSignatureEnumerator interface pointer.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> The <i>copy</i> parameter is <b>NULL</b>. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>OPC_E_ENUM_COLLECTION_CHANGED</b></dt> <dt>0x80510050</dt> </dl>
    ///    </td> <td width="60%"> The enumerator is invalid because the underlying set has changed. </td> </tr> </table>
    ///    
    HRESULT Clone(IOpcDigitalSignatureEnumerator* copy);
}

///An unordered set of IOpcSignaturePartReference interface pointers that represent references to parts to be signed.
@GUID("6C9FE28C-ECD9-4B22-9D36-7FDDE670FEC0")
interface IOpcSignaturePartReferenceSet : IUnknown
{
    ///Creates an IOpcSignaturePartReference interface pointer that represents a reference to a part to be signed, and
    ///adds the new interface to the set.
    ///Params:
    ///    partUri = An IOpcPartUri that represents the part name of the part to be referenced.
    ///    digestMethod = The digest method to be used for part content of the part to be referenced. To use the default digest method,
    ///                   pass <b>NULL</b> to this parameter. <div class="alert"><b>Important</b> The default digest method must be set
    ///                   by calling the IOpcSigningOptions::SetDefaultDigestMethod method before IOpcDigitalSignatureManager::Sign is
    ///                   called.</div> <div> </div>
    ///    transformMethod = The canonicalization method used for part content of the part to be referenced.
    ///    partReference = A new IOpcSignaturePartReference interface pointer that represents the reference to the part to be signed.
    ///                    This parameter can be <b>NULL</b> if a pointer to the new interface is not needed.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The value passed in the <i>transformMethod</i>
    ///    parameter is not a valid OPC_CANONICALIZATION_METHOD enumeration value. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> The <i>partUri</i> parameter is <b>NULL</b>.
    ///    </td> </tr> </table>
    ///    
    HRESULT Create(IOpcPartUri partUri, const(wchar)* digestMethod, OPC_CANONICALIZATION_METHOD transformMethod, 
                   IOpcSignaturePartReference* partReference);
    ///Deletes a specified IOpcSignaturePartReference interface pointer from the set.
    ///Params:
    ///    partReference = An IOpcSignaturePartReference interface pointer to be deleted.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> The <i>partReference</i> parameter is
    ///    <b>NULL</b>. </td> </tr> </table>
    ///    
    HRESULT Delete(IOpcSignaturePartReference partReference);
    ///Gets an enumerator of IOpcSignaturePartReference interface pointers in the set.
    ///Params:
    ///    partReferenceEnumerator = A pointer to an enumerator of IOpcSignaturePartReference interface pointers in the set.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> The <i>partReferenceEnumerator</i> parameter is
    ///    <b>NULL</b>. </td> </tr> </table>
    ///    
    HRESULT GetEnumerator(IOpcSignaturePartReferenceEnumerator* partReferenceEnumerator);
}

///An unordered set of IOpcSignatureRelationshipReference interface pointers that represent references to Relationships
///parts that contain relationships to be signed.
@GUID("9F863CA5-3631-404C-828D-807E0715069B")
interface IOpcSignatureRelationshipReferenceSet : IUnknown
{
    ///Creates an IOpcSignatureRelationshipReference interface pointer that represents a reference to a Relationships
    ///part, and adds the new interface pointer to the set. All or a subset of the relationships stored in the
    ///Relationships part to be referenced are selected for signing.
    ///Params:
    ///    sourceUri = An IOpcUri interface pointer that represents the source URI of the relationships to be selected for signing.
    ///    digestMethod = The digest method to be used for the relationships to be selected. To use the default digest method, pass
    ///                   <b>NULL</b> in this parameter. <div class="alert"><b>Important</b> The default digest method must be set by
    ///                   calling the IOpcSigningOptions::SetDefaultDigestMethod method before IOpcDigitalSignatureManager::Sign is
    ///                   called.</div> <div> </div>
    ///    relationshipSigningOption = A value that indicates whether the relationships selected for signing include all or a subset of the
    ///                                relationships in the Relationships part to be referenced. For information about the effect of
    ///                                <i>relationshipSigningOption</i> values on other parameters, see Remarks.
    ///    selectorSet = An IOpcRelationshipSelectorSet interface pointer that can be used to identify a subset of relationships in
    ///                  the Relationships part to be selected for signing. If <i>relationshipSigningOption</i> is set to
    ///                  <b>OPC_RELATIONSHIP_SIGN_PART</b>, <i>selectorSet</i> is <b>NULL</b>. For information about
    ///                  <i>selectorSet</i> values, see Remarks.
    ///    transformMethod = A value that describes the canonicalization method to be applied to the relationship markup of the selected
    ///                      relationships. If <i>relationshipSigningOption</i> is set <b>OPC_RELATIONSHIP_SIGN_USING_SELECTORS</b>, the
    ///                      value of <i>transformMethod</i> is ignored. For more information about the transform methods to be applied
    ///                      when <i>relationshipSigningOption</i> is set to <b>OPC_RELATIONSHIP_SIGN_USING_SELECTORS</b>, see Remarks.
    ///    relationshipReference = A new IOpcSignatureRelationshipReference interface pointer that represents the referenced Relationships part.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The value passed in the
    ///    <i>relationshipSigningOption</i> parameter is not a valid OPC_RELATIONSHIPS_SIGNING_OPTION enumeration value.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The value
    ///    passed in the <i>transformMethod</i> parameter is not a valid OPC_CANONICALIZATION_METHOD enumeration value.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> The
    ///    <i>sourceUri</i> parameter is <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_UNEXPECTED</b></dt> </dl> </td> <td width="60%"> The <i>selectorSet</i> parameter is not being
    ///    passed <b>NULL</b> while the <i>relationshipSigningOption</i> parameter is passed a value of
    ///    <b>OPC_RELATIONSHIP_SIGN_PART</b>. </td> </tr> </table>
    ///    
    HRESULT Create(IOpcUri sourceUri, const(wchar)* digestMethod, 
                   OPC_RELATIONSHIPS_SIGNING_OPTION relationshipSigningOption, 
                   IOpcRelationshipSelectorSet selectorSet, OPC_CANONICALIZATION_METHOD transformMethod, 
                   IOpcSignatureRelationshipReference* relationshipReference);
    ///Creates an IOpcRelationshipSelectorSet interface pointer that is used as the <i>selectorSet</i> parameter value
    ///of the Create method.
    ///Params:
    ///    selectorSet = A new IOpcRelationshipSelectorSet interface pointer.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> The <i>selectorSet</i> parameter is <b>NULL</b>.
    ///    </td> </tr> </table>
    ///    
    HRESULT CreateRelationshipSelectorSet(IOpcRelationshipSelectorSet* selectorSet);
    ///Deletes a specified IOpcSignatureRelationshipReference interface pointer from the set.
    ///Params:
    ///    relationshipReference = An IOpcSignatureRelationshipReference interface pointer to be deleted.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> The <i>relationshipReference</i> parameter is
    ///    <b>NULL</b>. </td> </tr> </table>
    ///    
    HRESULT Delete(IOpcSignatureRelationshipReference relationshipReference);
    ///Gets an enumerator of IOpcSignatureRelationshipReference interface pointers in the set.
    ///Params:
    ///    relationshipReferenceEnumerator = A pointer to an enumerator of IOpcSignatureRelationshipReference interface pointers in the set.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> The <i>relationshipReferenceEnumerator</i>
    ///    parameter is <b>NULL</b>. </td> </tr> </table>
    ///    
    HRESULT GetEnumerator(IOpcSignatureRelationshipReferenceEnumerator* relationshipReferenceEnumerator);
}

///An unordered set of IOpcRelationshipSelector interface pointers that represent the selection criteria that is used to
///identify relationships for signing. The subset is selected from the relationships stored in a Relationships part.
@GUID("6E34C269-A4D3-47C0-B5C4-87FF2B3B6136")
interface IOpcRelationshipSelectorSet : IUnknown
{
    ///Creates an IOpcRelationshipSelector interface pointer to represent how a subset of relationships are selected to
    ///be signed, and adds the new pointer to the set.
    ///Params:
    ///    selector = A value that describes how to interpret the string that is passed in <i>selectionCriterion</i>.
    ///    selectionCriterion = A string that is interpreted to yield a criterion.
    ///    relationshipSelector = A new IOpcRelationshipSelector interface pointer that represents how relationships are selected from a
    ///                           Relationships part. This parameter can be <b>NULL</b> if a pointer to the new interface is not needed.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The value passed in the <i>selector</i>
    ///    parameter is not a valid OPC_RELATIONSHIP_SELECTOR enumeration value. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> The <i>partUri</i> parameter is <b>NULL</b>. </td>
    ///    </tr> </table>
    ///    
    HRESULT Create(OPC_RELATIONSHIP_SELECTOR selector, const(wchar)* selectionCriterion, 
                   IOpcRelationshipSelector* relationshipSelector);
    ///Deletes a specified IOpcRelationshipSelector interface pointer from the set.
    ///Params:
    ///    relationshipSelector = An IOpcRelationshipSelector interface pointer to be deleted.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> The <i>relationshipSelector</i> parameter is
    ///    <b>NULL</b>. </td> </tr> </table>
    ///    
    HRESULT Delete(IOpcRelationshipSelector relationshipSelector);
    ///Gets an enumerator of IOpcRelationshipSelector interface pointers in the set.
    ///Params:
    ///    relationshipSelectorEnumerator = A pointer to an enumerator of the IOpcRelationshipSelector interface pointers in the set.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> The <i>relationshipSelectorEnumerator</i>
    ///    parameter is <b>NULL</b>. </td> </tr> </table>
    ///    
    HRESULT GetEnumerator(IOpcRelationshipSelectorEnumerator* relationshipSelectorEnumerator);
}

///An unordered set of IOpcSignatureReference interface pointers that represent references to XML elements to be signed.
///An XML element to be signed can be either an application-specific <b>Object</b> element or a child element.
@GUID("F3B02D31-AB12-42DD-9E2F-2B16761C3C1E")
interface IOpcSignatureReferenceSet : IUnknown
{
    ///Creates an IOpcSignatureReference interface pointer that represents a reference to an XML element to be signed.
    ///Params:
    ///    referenceUri = The URI of the referenced XML element. Set the value of this parameter to a URI that represents "
    ///    referenceId = The <b>Id</b> attribute of the <b>Reference</b> element that represents the reference in signature markup. To
    ///                  omit the <b>Id</b> attribute, set this parameter value to <b>NULL</b>.
    ///    type = The <b>Type</b> attribute of the <b>Reference</b> element that represents the reference in signature markup.
    ///           To omit the <b>Type</b> attribute, set this parameter value to <b>NULL</b>.
    ///    digestMethod = The digest method to be used for the XML markup to be referenced. To use the default digest method, set this
    ///                   parameter value to <b>NULL</b>. <div class="alert"><b>Important</b> The default digest method must be set by
    ///                   calling the IOpcSigningOptions::SetDefaultDigestMethod method before IOpcDigitalSignatureManager::Sign is
    ///                   called.</div> <div> </div>
    ///    transformMethod = The canonicalization method to be used for the XML markup to be referenced.
    ///    reference = A new IOpcSignatureReference interface pointer that represents the reference to the XML element to be signed.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The value passed in the <i>transformMethod</i>
    ///    parameter is not a valid OPC_CANONICALIZATION_METHOD enumeration value. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> The <i>referenceUri</i> parameter is <b>NULL</b>.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>OPC_E_DS_PACKAGE_REFERENCE_URI_RESERVED</b></dt>
    ///    <dt>0x80510025</dt> </dl> </td> <td width="60%"> The reserved <b>URI</b> attribute value of the signature's
    ///    <b>Reference</b> element to the package <b>Object</b> is being used as the <b>URI</b> attribute value of a
    ///    <b>Reference</b> to a custom <b>Object</b> element. </td> </tr> </table>
    ///    
    HRESULT Create(IUri referenceUri, const(wchar)* referenceId, const(wchar)* type, const(wchar)* digestMethod, 
                   OPC_CANONICALIZATION_METHOD transformMethod, IOpcSignatureReference* reference);
    ///Deletes a specified IOpcSignatureReference interface pointer from the set.
    ///Params:
    ///    reference = An IOpcSignatureReference interface pointer to be deleted.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> The <i>reference</i> parameter is <b>NULL</b>.
    ///    </td> </tr> </table>
    ///    
    HRESULT Delete(IOpcSignatureReference reference);
    ///Gets an enumerator of IOpcSignatureReference interface pointers in the set.
    ///Params:
    ///    referenceEnumerator = A pointer to an enumerator of IOpcSignatureReference interface pointers in the set.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> The <i>referenceEnumerator</i> parameter is
    ///    <b>NULL</b>. </td> </tr> </table>
    ///    
    HRESULT GetEnumerator(IOpcSignatureReferenceEnumerator* referenceEnumerator);
}

///An unordered set of IOpcSignatureCustomObject interface pointers that contain the XML markup of application-specific
///<b>Object</b> elements.
@GUID("8F792AC5-7947-4E11-BC3D-2659FF046AE1")
interface IOpcSignatureCustomObjectSet : IUnknown
{
    ///Creates an IOpcSignatureCustomObject interface pointer to represent an application-specific <b>Object</b> element
    ///in the signature, and adds the new interface to the set.
    ///Params:
    ///    xmlMarkup = A buffer that contains the XML markup for the <b>Object</b> element to be represented. This XML markup must
    ///                include the opening <b>Object</b> and closing <b>/Object</b> tags. The encoding of the markup contained in
    ///                <i>xmlMarkup</i> will be inferred. Inclusion of a byte order mark at the beginning of the buffer passed in
    ///                <i>xmlMarkup</i> is optional. The following encodings and byte order mark values are supported:<table> <tr>
    ///                <th>Encoding</th> <th>Description</th> <th>Byte order mark</th> </tr> <tr> <td>UTF8</td> <td>UTF-8</td>
    ///                <td>EF BB BF</td> </tr> <tr> <td>UTF16LE</td> <td>UTF-16, little endian</td> <td>FF FE</td> </tr> <tr>
    ///                <td>UTF16BE</td> <td>UTF-16, big endian</td> <td>FE FF</td> </tr> </table>
    ///    count = The size of the <i>xmlMarkup</i> buffer.
    ///    customObject = A new IOpcSignatureCustomObject interface pointer that represents the application-specific <b>Object</b>
    ///                   element. This parameter can be <b>NULL</b> if a pointer to the new interface is not needed.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The <i>count</i> parameter is 0. The
    ///    <i>xmlMarkup</i> parameter must be passed valid XML markup. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> The <i>xmlMarkup</i> parameter is <b>NULL</b>. </td>
    ///    </tr> </table>
    ///    
    HRESULT Create(char* xmlMarkup, uint count, IOpcSignatureCustomObject* customObject);
    ///Deletes a specified IOpcSignatureCustomObject interface pointer from the set.
    ///Params:
    ///    customObject = An IOpcSignatureCustomObject interface pointer to be deleted.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> The <i>customObject</i> parameter is <b>NULL</b>.
    ///    </td> </tr> </table>
    ///    
    HRESULT Delete(IOpcSignatureCustomObject customObject);
    ///Gets an enumerator of IOpcSignatureCustomObject interface pointers in the set.
    ///Params:
    ///    customObjectEnumerator = A pointer to an enumerator of IOpcSignatureCustomObject interface pointers in the set.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> The <i>customObjectEnumerator</i> parameter is
    ///    <b>NULL</b>. </td> </tr> </table>
    ///    
    HRESULT GetEnumerator(IOpcSignatureCustomObjectEnumerator* customObjectEnumerator);
}

///An unordered set of certificates to be used with a signature.
@GUID("56EA4325-8E2D-4167-B1A4-E486D24C8FA7")
interface IOpcCertificateSet : IUnknown
{
    ///Adds a certificate to the set.
    ///Params:
    ///    certificate = A CERT_CONTEXT structure that contains the certificate to be added.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> The <i>certificate</i> parameter is <b>NULL</b>.
    ///    </td> </tr> </table>
    ///    
    HRESULT Add(const(CERT_CONTEXT)* certificate);
    ///Removes a specified certificate from the set.
    ///Params:
    ///    certificate = A CERT_CONTEXT structure that contains the certificate to be removed.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> The <i>certificate</i> parameter is <b>NULL</b>.
    ///    </td> </tr> </table>
    ///    
    HRESULT Remove(const(CERT_CONTEXT)* certificate);
    ///Gets an enumerator of certificates in the set.
    ///Params:
    ///    certificateEnumerator = A pointer to an IOpcCertificateEnumerator interface of certificates in the set.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> The <i>certificateEnumerator</i> parameter is
    ///    <b>NULL</b>. </td> </tr> </table>
    ///    
    HRESULT GetEnumerator(IOpcCertificateEnumerator* certificateEnumerator);
}

///Creates Packaging API objects and provides support for saving and loading packages. Objects that are created by
///<b>IOpcFactory</b> interface methods provide support for creating, populating, modifying, and digitally signing
///packages.
@GUID("6D0B4446-CD73-4AB3-94F4-8CCDF6116154")
interface IOpcFactory : IUnknown
{
    ///Creates an OPC URI object that represents the root of a package.
    ///Params:
    ///    rootUri = A pointer to the IOpcUri interface of the OPC URI object that represents the URI of the root of a package.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> The <i>rootUri</i> parameter is <b>NULL</b>.
    ///    </td> </tr> </table>
    ///    
    HRESULT CreatePackageRootUri(IOpcUri* rootUri);
    ///Creates a part URI object that represents a part name.
    ///Params:
    ///    pwzUri = A URI that represents the location of a part relative to the root of the package that contains it.
    ///    partUri = A pointer to the IOpcPartUri interface of the part URI object. This object represents the part name derived
    ///              from the URI passed in <i>pwzUri</i>. Part names must conform to the syntax specified in the <i>OPC</i>.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> At least one of the <i>pwzUri</i> and
    ///    <i>partUri</i> parameters is <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>OPC_E_NONCONFORMING_URI</b></dt> <dt>0x80510001</dt> </dl> </td> <td width="60%"> A part name cannot
    ///    be the empty string "". </td> </tr> <tr> <td width="40%"> <dl> <dt><b>OPC_E_NONCONFORMING_URI</b></dt>
    ///    <dt>0x80510001</dt> </dl> </td> <td width="60%"> A part name cannot be a '/'. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>OPC_E_NONCONFORMING_URI</b></dt> <dt>0x80510001</dt> </dl> </td> <td width="60%"> A
    ///    part name cannot begin with "//". </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>OPC_E_NONCONFORMING_URI</b></dt> <dt>0x80510001</dt> </dl> </td> <td width="60%"> A part name cannot
    ///    end with a '/'. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>OPC_E_NONCONFORMING_URI</b></dt>
    ///    <dt>0x80510001</dt> </dl> </td> <td width="60%"> A part name cannot end with a '.'. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>OPC_E_NONCONFORMING_URI</b></dt> <dt>0x80510001</dt> </dl> </td> <td width="60%"> A
    ///    part name cannot have any segments that end with a '.'. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>OPC_E_NONCONFORMING_URI</b></dt> <dt>0x80510001</dt> </dl> </td> <td width="60%"> A part name cannot
    ///    have fragment component. A fragment component is preceded by a '#' character, as described in RFC 3986: URI
    ///    Generic Syntax. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>OPC_E_NONCONFORMING_URI</b></dt>
    ///    <dt>0x80510001</dt> </dl> </td> <td width="60%"> A part name cannot be the name of a Relationships part that
    ///    indicates another Relationships part as the source of the relationships contained therein. </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>OPC_E_RELATIVE_URI_REQUIRED</b></dt> <dt>0x80510002</dt> </dl> </td> <td
    ///    width="60%"> A part name cannot be an absolute URI. An absolute URI begins with a schema component followed
    ///    by a ":", as described in RFC 3986: URI Generic Syntax. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b><b>CreateUri</b> function error</b></dt> </dl> </td> <td width="60%"> An <b>HRESULT</b> error code
    ///    from the CreateUri function. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>WinINet error</b></dt> </dl> </td>
    ///    <td width="60%"> An <b>HRESULT</b> error code from a WinINet API. </td> </tr> </table>
    ///    
    HRESULT CreatePartUri(const(wchar)* pwzUri, IOpcPartUri* partUri);
    ///Creates a stream over a file. This method is a simplified wrapper for a call to the CreateFile function.
    ///<b>CreateFile</b> parameters that are not exposed through this method use their default values. For more
    ///information, see <b>CreateFile</b>.
    ///Params:
    ///    filename = The name of the file over which the stream is created.
    ///    ioMode = The value that describes the read/write status of the stream to be created.
    ///    securityAttributes = For information about the SECURITY_ATTRIBUTES structure in this parameter, see the CreateFile function.
    ///    dwFlagsAndAttributes = The settings and attributes of the file. For most files, <b>FILE_ATTRIBUTE_NORMAL</b> can be used. For more
    ///                           information about this parameter, see CreateFile.
    ///    stream = A pointer to the IStream interface of the stream.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The value passed in the <i>ioMode</i>
    ///    parameter is not a valid OPC_STREAM_IO_MODE enumeration value. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> At least one of the <i>filename</i> and <i>stream</i>
    ///    parameters is <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl> <dt><b><b>CreateFile</b> function
    ///    error</b></dt> </dl> </td> <td width="60%"> An <b>HRESULT</b> error code from the CreateFile function. </td>
    ///    </tr> </table>
    ///    
    HRESULT CreateStreamOnFile(const(wchar)* filename, OPC_STREAM_IO_MODE ioMode, 
                               SECURITY_ATTRIBUTES* securityAttributes, uint dwFlagsAndAttributes, IStream* stream);
    ///Creates a package object that represents an empty package.
    ///Params:
    ///    package = A pointer to the IOpcPackage interface of the package object that represents an empty package.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_NOTIMPL</b></dt> </dl> </td> <td width="60%"> This method is not implemented for this version
    ///    of Windows. </td> </tr> </table>
    ///    
    HRESULT CreatePackage(IOpcPackage* package_);
    ///Deserializes package data from a stream and creates a package object to represent the package being read. While a
    ///Packaging API object obtained from the package object, or the package object itself, is still in use, the stream
    ///may be used to access package data.
    ///Params:
    ///    stream = A pointer to the IStream interface of the stream. The stream must be readable, seekable, have size, and must
    ///             contain package data. Additionally, if the stream is not clonable, it will be buffered and read sequentially,
    ///             incurring overhead.
    ///    flags = The value that specifies the read settings for caching package components and validating them against
    ///            <i>OPC</i> conformance requirements.
    ///    package = A pointer to the IOpcPackage interface of the package object that represents the package being read through
    ///              the stream.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The value passed in the <i>flags</i> parameter
    ///    is not a valid OPC_READ_FLAGS enumeration value. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_NOTIMPL</b></dt> </dl> </td> <td width="60%"> This method is not implemented for this version of
    ///    Windows. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> At
    ///    least one of the <i>stream</i> and <i>package</i> parameters is <b>NULL</b>. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b><b>IStream</b> interface error</b></dt> </dl> </td> <td width="60%"> An
    ///    <b>HRESULT</b> error code from the IStream interface. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>Package
    ///    Consumption error</b></dt> </dl> </td> <td width="60%"> An <b>HRESULT</b> error code from the Package
    ///    Consumption Error Group. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>Part URI error</b></dt> </dl> </td>
    ///    <td width="60%"> An <b>HRESULT</b> error code from the Part URI Error Group. </td> </tr> </table>
    ///    
    HRESULT ReadPackageFromStream(IStream stream, OPC_READ_FLAGS flags, IOpcPackage* package_);
    ///Serializes a package that is represented by a package object.
    ///Params:
    ///    package = A pointer to the IOpcPackage interface of the package object that contains data to be serialized.
    ///    flags = The value that describes the encoding method used in serialization.
    ///    stream = A pointer to the IStream interface of the stream where the package object data will be written.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The value passed in the <i>flags</i> parameter
    ///    is not a valid OPC_WRITE_FLAGS enumeration value. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_NOTIMPL</b></dt> </dl> </td> <td width="60%"> This method is not implemented for this version of
    ///    Windows. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> At
    ///    least one of the <i>stream</i> and <i>package</i> parameters is <b>NULL</b>. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b><b>IStream</b> interface error</b></dt> </dl> </td> <td width="60%"> An
    ///    <b>HRESULT</b> error code from the IStream interface. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>Package
    ///    Consumption error</b></dt> </dl> </td> <td width="60%"> An <b>HRESULT</b> error code from the Package
    ///    Consumption Error Group. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>Part URI error</b></dt> </dl> </td>
    ///    <td width="60%"> An <b>HRESULT</b> error code from the Part URI Error Group. </td> </tr> </table>
    ///    
    HRESULT WritePackageToStream(IOpcPackage package_, OPC_WRITE_FLAGS flags, IStream stream);
    ///Creates a digital signature manager object for a package object.
    ///Params:
    ///    package = A pointer to the IOpcPackage interface of the package object to associate with the digital signature manager
    ///              object.
    ///    signatureManager = A pointer to the IOpcDigitalSignatureManager interface of the digital signature manager object that is
    ///                       created for use with the package object. A digital signature manager object provides access to the Packaging
    ///                       API's digital signature interfaces and methods. These can be used to sign the package represented by the
    ///                       package object or to validate the signatures in a package that has already been signed.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_NOTIMPL</b></dt> </dl> </td> <td width="60%"> This method is not implemented for this version
    ///    of Windows. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>OPC_E_DS_DUPLICATE_SIGNATURE_ORIGIN_RELATIONSHIP</b></dt> <dt>0x8051001B</dt> </dl> </td> <td
    ///    width="60%"> More than one relationship of the digital signature origin relationship type exists, but only
    ///    one such relationship is allowed. For more information about this relationship type, see the <i>OPC</i>.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>OPC_E_DS_INVALID_SIGNATURE_ORIGIN_RELATIONSHIP</b></dt>
    ///    <dt>0x8051001C</dt> </dl> </td> <td width="60%"> A package relationship of type digital signature origin is
    ///    targeting a location that is external to the package. Digital Signature Origin parts must be located
    ///    internally. For more information about this relationship type, see the <i>OPC</i>. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>OPC_E_DS_MISSING_SIGNATURE_ORIGIN_PART</b></dt> <dt>0x8051001F</dt> </dl> </td> <td
    ///    width="60%"> A relationship of type digital signature origin was found, but the Digital Signature Origin part
    ///    itself was not. For more information about this relationship type, see the <i>OPC</i>. </td> </tr> </table>
    ///    
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
