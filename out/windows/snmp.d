// Written in the D programming language.

module windows.snmp;

public import windows.core;
public import windows.systemservices : BOOL, HANDLE, PSTR, ULARGE_INTEGER;
public import windows.windowsandmessaging : HWND, LPARAM, WPARAM;

extern(Windows) @nogc nothrow:


// Callbacks

alias PFNSNMPEXTENSIONINIT = BOOL function(uint dwUpTimeReference, HANDLE* phSubagentTrapEvent, 
                                           AsnObjectIdentifier* pFirstSupportedRegion);
alias PFNSNMPEXTENSIONINITEX = BOOL function(AsnObjectIdentifier* pNextSupportedRegion);
alias PFNSNMPEXTENSIONMONITOR = BOOL function(void* pAgentMgmtData);
alias PFNSNMPEXTENSIONQUERY = BOOL function(ubyte bPduType, SnmpVarBindList* pVarBindList, int* pErrorStatus, 
                                            int* pErrorIndex);
alias PFNSNMPEXTENSIONQUERYEX = BOOL function(uint nRequestType, uint nTransactionId, 
                                              SnmpVarBindList* pVarBindList, AsnOctetString* pContextInfo, 
                                              int* pErrorStatus, int* pErrorIndex);
alias PFNSNMPEXTENSIONTRAP = BOOL function(AsnObjectIdentifier* pEnterpriseOid, int* pGenericTrapId, 
                                           int* pSpecificTrapId, uint* pTimeStamp, SnmpVarBindList* pVarBindList);
alias PFNSNMPEXTENSIONCLOSE = void function();
///<p class="CCE_Message">[SNMP is available for use in the operating systems specified in the Requirements section. It
///may be altered or unavailable in subsequent versions. Instead, use Windows Remote Management, which is the Microsoft
///implementation of WS-Man.] The Microsoft WinSNMP implementation calls the <b>SNMPAPI_CALLBACK</b> function to notify
///a WinSNMP session that an SNMP message or asynchronous event is available. <b>SNMPAPI_CALLBACK</b> is a placeholder
///for an application- or library-defined callback function name.
///Params:
///    hSession = Handle to the WinSNMP session.
///    hWnd = Handle to a window of the WinSNMP application to notify when an asynchronous request completes, or when trap
///           notification occurs. This parameter does not have significance for the WinSNMP session, but the implementation
///           always passes the value to the callback function.
///    wMsg = Specifies an unsigned integer that identifies the notification message to send to the WinSNMP application window.
///           This parameter does not have significance for the WinSNMP session, but the implementation always passes the value
///           to the callback function.
///    wParam = Specifies an application-defined 32-bit value that identifies the type of notification. If this parameter is
///             equal to zero, an SNMP message is available for the session. The application should call the SnmpRecvMsg function
///             to retrieve the message. If this parameter is not equal to zero, it indicates an asynchronous event notification
///             for the session. For additional information, see the following Remarks section.
///    lParam = Specifies an application-defined 32-bit value that specifies the request identifier of the PDU being processed.
///    lpClientData = If the <i>lpClientData</i> parameter was not <b>NULL</b> on the call to the SnmpCreateSession function for this
///                   session, this parameter is a pointer to application-defined data.
///Returns:
///    The function must return SNMPAPI_SUCCESS to continue execution of the application. If the function returns any
///    other value, the implementation responds as if the application called the SnmpClose function for the indicated
///    session.
///    
alias SNMPAPI_CALLBACK = uint function(ptrdiff_t hSession, HWND hWnd, uint wMsg, WPARAM wParam, LPARAM lParam, 
                                       void* lpClientData);
alias PFNSNMPSTARTUPEX = uint function(uint* param0, uint* param1, uint* param2, uint* param3, uint* param4);
alias PFNSNMPCLEANUPEX = uint function();

// Structs


///<p class="CCE_Message">[SNMP is available for use in the operating systems specified in the Requirements section. It
///may be altered or unavailable in subsequent versions. Instead, use Windows Remote Management, which is the Microsoft
///implementation of WS-Man.] The <b>AsnOctetString</b> structure contains octet quantities, usually bytes. This
///structure is used by multiple SNMP functions. This structure is not used by the WinSNMP API functions.
struct AsnOctetString
{
    ///Pointer to the octet stream.
    ubyte* stream;
    ///The number of octets in the data stream.
    uint   length;
    ///Flag that specifies whether the data stream has been dynamically allocated with the SnmpUtilMemAlloc function.
    BOOL   dynamic;
}

///<p class="CCE_Message">[SNMP is available for use in the operating systems specified in the Requirements section. It
///may be altered or unavailable in subsequent versions. Instead, use Windows Remote Management, which is the Microsoft
///implementation of WS-Man.] The <b>AsnObjectIdentifier</b> structure represents object identifiers. This structure is
///used by multiple SNMP functions. This structure is not used by the WinSNMP API functions.
struct AsnObjectIdentifier
{
    ///Specifies the number of integers in the object identifier.
    uint  idLength;
    ///Pointer to an array of integers that represents the object identifier.
    uint* ids;
}

///<p class="CCE_Message">[SNMP is available for use in the operating systems specified in the Requirements section. It
///may be altered or unavailable in subsequent versions. Instead, use Windows Remote Management, which is the Microsoft
///implementation of WS-Man.] The <b>AsnAny</b> structure contains an SNMP variable type and value. This structure is a
///member of the SnmpVarBind structure that is used as a parameter in many of the SNMP functions. This structure is not
///used by the WinSNMP API functions.
struct AsnAny
{
    ///Type: <b>BYTE</b> Indicates the variable's type. This member must be only one of the following values. <table>
    ///<tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="ASN_INTEGER"></a><a
    ///id="asn_integer"></a><dl> <dt><b>ASN_INTEGER</b></dt> </dl> </td> <td width="60%"> Indicates a 32-bit signed
    ///integer variable. </td> </tr> <tr> <td width="40%"><a id="ASN_INTEGER32"></a><a id="asn_integer32"></a><dl>
    ///<dt><b>ASN_INTEGER32</b></dt> </dl> </td> <td width="60%"> Indicates a 32-bit signed integer variable. </td>
    ///</tr> <tr> <td width="40%"><a id="ASN_UNSIGNED32"></a><a id="asn_unsigned32"></a><dl>
    ///<dt><b>ASN_UNSIGNED32</b></dt> </dl> </td> <td width="60%"> Indicates a 32-bit unsigned integer variable. For
    ///more information, see the following Remarks section. </td> </tr> <tr> <td width="40%"><a
    ///id="ASN_COUNTER64"></a><a id="asn_counter64"></a><dl> <dt><b>ASN_COUNTER64</b></dt> </dl> </td> <td width="60%">
    ///Indicates a counter variable that increases until it reaches a maximum value of (2^64) – 1. </td> </tr> <tr>
    ///<td width="40%"><a id="ASN_OCTETSTRING"></a><a id="asn_octetstring"></a><dl> <dt><b>ASN_OCTETSTRING</b></dt>
    ///</dl> </td> <td width="60%"> Indicates an octet string variable. </td> </tr> <tr> <td width="40%"><a
    ///id="ASN_BITS"></a><a id="asn_bits"></a><dl> <dt><b>ASN_BITS</b></dt> </dl> </td> <td width="60%"> Indicates a
    ///variable that is an enumeration of named bits. </td> </tr> <tr> <td width="40%"><a
    ///id="ASN_OBJECTIDENTIFIER"></a><a id="asn_objectidentifier"></a><dl> <dt><b>ASN_OBJECTIDENTIFIER</b></dt> </dl>
    ///</td> <td width="60%"> Indicates an object identifier variable. </td> </tr> <tr> <td width="40%"><a
    ///id="ASN_SEQUENCE"></a><a id="asn_sequence"></a><dl> <dt><b>ASN_SEQUENCE</b></dt> </dl> </td> <td width="60%">
    ///Indicates an ASN sequence variable. </td> </tr> <tr> <td width="40%"><a id="ASN_IPADDRESS"></a><a
    ///id="asn_ipaddress"></a><dl> <dt><b>ASN_IPADDRESS</b></dt> </dl> </td> <td width="60%"> Indicates an IP address
    ///variable. </td> </tr> <tr> <td width="40%"><a id="ASN_COUNTER32"></a><a id="asn_counter32"></a><dl>
    ///<dt><b>ASN_COUNTER32</b></dt> </dl> </td> <td width="60%"> Indicates a counter variable. </td> </tr> <tr> <td
    ///width="40%"><a id="ASN_GAUGE32"></a><a id="asn_gauge32"></a><dl> <dt><b>ASN_GAUGE32</b></dt> </dl> </td> <td
    ///width="60%"> Indicates a gauge variable. For more information, see the following Remarks section. </td> </tr>
    ///<tr> <td width="40%"><a id="ASN_TIMETICKS"></a><a id="asn_timeticks"></a><dl> <dt><b>ASN_TIMETICKS</b></dt> </dl>
    ///</td> <td width="60%"> Indicates a timeticks variable. </td> </tr> <tr> <td width="40%"><a id="ASN_OPAQUE"></a><a
    ///id="asn_opaque"></a><dl> <dt><b>ASN_OPAQUE</b></dt> </dl> </td> <td width="60%"> Indicates an opaque variable.
    ///</td> </tr> <tr> <td width="40%"><a id="SNMP_EXCEPTION_NOSUCHOBJECT"></a><a
    ///id="snmp_exception_nosuchobject"></a><dl> <dt><b>SNMP_EXCEPTION_NOSUCHOBJECT</b></dt> </dl> </td> <td
    ///width="60%"> Indicates that the object provided is not available. </td> </tr> <tr> <td width="40%"><a
    ///id="SNMP_EXCEPTION_NOSUCHINSTANCE"></a><a id="snmp_exception_nosuchinstance"></a><dl>
    ///<dt><b>SNMP_EXCEPTION_NOSUCHINSTANCE</b></dt> </dl> </td> <td width="60%"> Indicates that the instance provided
    ///is not available. </td> </tr> <tr> <td width="40%"><a id="SNMP_EXCEPTION_ENDOFMIBVIEW"></a><a
    ///id="snmp_exception_endofmibview"></a><dl> <dt><b>SNMP_EXCEPTION_ENDOFMIBVIEW</b></dt> </dl> </td> <td
    ///width="60%"> Indicates that the end of the MIB view has been reached. </td> </tr> </table>
    ubyte asnType;
union asnValue
    {
    align (4):
        int                 number;
        uint                unsigned32;
        ULARGE_INTEGER      counter64;
        AsnOctetString      string;
        AsnOctetString      bits;
        AsnObjectIdentifier object;
        AsnOctetString      sequence;
        AsnOctetString      address;
        uint                counter;
        uint                gauge;
        uint                ticks;
        AsnOctetString      arbitrary;
    }
}

///<p class="CCE_Message">[SNMP is available for use in the operating systems specified in the Requirements section. It
///may be altered or unavailable in subsequent versions. Instead, use Windows Remote Management, which is the Microsoft
///implementation of WS-Man.] The <b>SnmpVarBind</b> structure represents an SNMP variable binding. This structure is
///used by multiple SNMP functions. This structure is not used by the WinSNMP API functions.
struct SnmpVarBind
{
    ///Indicates the variable's name, as an object identifier.
    AsnObjectIdentifier name;
    ///Contains the variable's value.
    AsnAny              value;
}

///<p class="CCE_Message">[SNMP is available for use in the operating systems specified in the Requirements section. It
///may be altered or unavailable in subsequent versions. Instead, use Windows Remote Management, which is the Microsoft
///implementation of WS-Man.] The <b>SnmpVarBindList</b> structure represents an SNMP variable bindings list. This
///structure is used by multiple SNMP functions. This structure is not used by the WinSNMP API functions.
struct SnmpVarBindList
{
    ///A pointer that references an array to access individual variable bindings.
    SnmpVarBind* list;
    ///Contains the number of variable bindings in the list.
    uint         len;
}

///<p class="CCE_Message">[SNMP is available for use in the operating systems specified in the Requirements section. It
///may be altered or unavailable in subsequent versions. Instead, use Windows Remote Management, which is the Microsoft
///implementation of WS-Man.] The WinSNMP <b>smiOCTETS</b> structure passes context strings to multiple WinSNMP
///functions. The structure also describes and receives encoded SNMP messages. The <b>smiOCTETS</b> structure contains a
///pointer to an SNMP octet string of variable length. The structure can be a member of the smiVALUE structure.
struct smiOCTETS
{
    ///Specifies an unsigned long integer value that indicates the number of bytes in the octet string array pointed to
    ///by the <b>ptr</b> member.
    uint   len;
    ///Pointer to a byte array that contains the octet string of interest. A <b>NULL</b>-terminating byte is not
    ///required.
    ubyte* ptr;
}

///<p class="CCE_Message">[SNMP is available for use in the operating systems specified in the Requirements section. It
///may be altered or unavailable in subsequent versions. Instead, use Windows Remote Management, which is the Microsoft
///implementation of WS-Man.] The WinSNMP <b>smiOID</b> structure passes object identifiers to multiple WinSNMP
///functions. The structure also receives the variable name of a variable binding entry in a call to the SnmpGetVb
///function. The <b>smiOID</b> structure contains a pointer to a variable length array of a named object's
///subidentifiers. The structure can be a member of the smiVALUE structure.
struct smiOID
{
    ///Specifies an unsigned long integer value that indicates the number of elements in the array pointed to by the
    ///<b>ptr</b> member.
    uint  len;
    ///Pointer to an array of unsigned long integers that represent the object identifier's subidentifiers.
    uint* ptr;
}

///<p class="CCE_Message">[SNMP is available for use in the operating systems specified in the Requirements section. It
///may be altered or unavailable in subsequent versions. Instead, use Windows Remote Management, which is the Microsoft
///implementation of WS-Man.] The WinSNMP <b>smiCNTR64</b> structure contains a 64-bit unsigned integer value. The
///structure represents a 64-bit counter.
struct smiCNTR64
{
    ///Specifies the high-order 32 bits of the counter.
    uint hipart;
    ///Specifies the low-order 32 bits of the counter.
    uint lopart;
}

///<p class="CCE_Message">[SNMP is available for use in the operating systems specified in the Requirements section. It
///may be altered or unavailable in subsequent versions. Instead, use Windows Remote Management, which is the Microsoft
///implementation of WS-Man.] The WinSNMP <b>smiVALUE</b> structure describes the value associated with a variable name
///in a variable binding entry. The <b>syntax</b> member of the <b>smiVALUE</b> structure contains a WinSNMP data type
///that indicates the type of data in the <b>value</b> member. The <b>value</b> member of the structure is the union of
///all possible WinSNMP data types.
struct smiVALUE
{
    ///Type: <b>smiUINT32</b> Specifies an unsigned long integer that indicates the syntax data type of the <b>value</b>
    ///member. This member can be only one of the types listed in the following table. For more information, see WinSNMP
    ///Data Types and RFC 1902, "Structure of Management Information for Version 2 of the Simple Network Management
    ///Protocol (SNMPv2)." <table> <tr> <th>Syntax data type</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
    ///id="SNMP_SYNTAX_INT"></a><a id="snmp_syntax_int"></a><dl> <dt><b><b>SNMP_SYNTAX_INT</b></b></dt> </dl> </td> <td
    ///width="60%"> Indicates a 32-bit signed integer variable. </td> </tr> <tr> <td width="40%"><a
    ///id="SNMP_SYNTAX_OCTETS"></a><a id="snmp_syntax_octets"></a><dl> <dt><b><b>SNMP_SYNTAX_OCTETS</b></b></dt> </dl>
    ///</td> <td width="60%"> Indicates an octet string variable that is binary or textual data. </td> </tr> <tr> <td
    ///width="40%"><a id="SNMP_SYNTAX_NULL"></a><a id="snmp_syntax_null"></a><dl>
    ///<dt><b><b>SNMP_SYNTAX_NULL</b></b></dt> </dl> </td> <td width="60%"> Indicates a <b>NULL</b> value. </td> </tr>
    ///<tr> <td width="40%"><a id="SNMP_SYNTAX_OID"></a><a id="snmp_syntax_oid"></a><dl>
    ///<dt><b><b>SNMP_SYNTAX_OID</b></b></dt> </dl> </td> <td width="60%"> Indicates an object identifier variable that
    ///is an assigned name with a maximum of 128 subidentifiers. </td> </tr> <tr> <td width="40%"><a
    ///id="SNMP_SYNTAX_INT32"></a><a id="snmp_syntax_int32"></a><dl> <dt><b><b>SNMP_SYNTAX_INT32</b></b></dt> </dl>
    ///</td> <td width="60%"> Indicates a 32-bit signed integer variable. </td> </tr> <tr> <td width="40%"><a
    ///id="SNMP_SYNTAX_IPADDR"></a><a id="snmp_syntax_ipaddr"></a><dl> <dt><b><b>SNMP_SYNTAX_IPADDR</b></b></dt> </dl>
    ///</td> <td width="60%"> Indicates a 32-bit Internet address variable. </td> </tr> <tr> <td width="40%"><a
    ///id="SNMP_SYNTAX_CNTR32"></a><a id="snmp_syntax_cntr32"></a><dl> <dt><b><b>SNMP_SYNTAX_CNTR32</b></b></dt> </dl>
    ///</td> <td width="60%"> Indicates a counter variable that increases until it reaches a maximum value of (2^32) –
    ///1. </td> </tr> <tr> <td width="40%"><a id="SNMP_SYNTAX_GAUGE32"></a><a id="snmp_syntax_gauge32"></a><dl>
    ///<dt><b><b>SNMP_SYNTAX_GAUGE32</b></b></dt> </dl> </td> <td width="60%"> Indicates a gauge variable that is a
    ///non-negative integer that can increase or decrease, but never exceed a maximum value. </td> </tr> <tr> <td
    ///width="40%"><a id="SNMP_SYNTAX_TIMETICKS"></a><a id="snmp_syntax_timeticks"></a><dl>
    ///<dt><b><b>SNMP_SYNTAX_TIMETICKS</b></b></dt> </dl> </td> <td width="60%"> Indicates a counter variable that
    ///measures the time in hundredths of a second, until it reaches a maximum value of (2^32) – 1. It is a
    ///non-negative integer that is relative to a specific timer event. </td> </tr> <tr> <td width="40%"><a
    ///id="SNMP_SYNTAX_OPAQUE"></a><a id="snmp_syntax_opaque"></a><dl> <dt><b><b>SNMP_SYNTAX_OPAQUE</b></b></dt> </dl>
    ///</td> <td width="60%"> This type provides backward compatibility, and should not be used for new object types. It
    ///supports the capability to pass arbitrary Abstract Syntax Notation One (ASN.1) syntax. </td> </tr> <tr> <td
    ///width="40%"><a id="SNMP_SYNTAX_CNTR64"></a><a id="snmp_syntax_cntr64"></a><dl>
    ///<dt><b><b>SNMP_SYNTAX_CNTR64</b></b></dt> </dl> </td> <td width="60%"> Indicates a counter variable that
    ///increases until it reaches a maximum value of (2^64) – 1. </td> </tr> <tr> <td width="40%"><a
    ///id="SNMP_SYNTAX_UINT32"></a><a id="snmp_syntax_uint32"></a><dl> <dt><b><b>SNMP_SYNTAX_UINT32</b></b></dt> </dl>
    ///</td> <td width="60%"> Indicates a 32-bit unsigned integer variable. </td> </tr> <tr> <td width="40%"><a
    ///id="SNMP_SYNTAX_NOSUCHOBJECT"></a><a id="snmp_syntax_nosuchobject"></a><dl>
    ///<dt><b><b>SNMP_SYNTAX_NOSUCHOBJECT</b></b></dt> </dl> </td> <td width="60%"> Indicates that the agent does not
    ///support the object type that corresponds to the variable. </td> </tr> <tr> <td width="40%"><a
    ///id="SNMP_SYNTAX_NOSUCHINSTANCE"></a><a id="snmp_syntax_nosuchinstance"></a><dl>
    ///<dt><b><b>SNMP_SYNTAX_NOSUCHINSTANCE</b></b></dt> </dl> </td> <td width="60%"> Indicates that the object instance
    ///does not exist for the operation. </td> </tr> <tr> <td width="40%"><a id="SNMP_SYNTAX_ENDOFMIBVIEW"></a><a
    ///id="snmp_syntax_endofmibview"></a><dl> <dt><b><b>SNMP_SYNTAX_ENDOFMIBVIEW</b></b></dt> </dl> </td> <td
    ///width="60%"> Indicates the WinSNMP application is attempting to reference an object identifier that is beyond the
    ///end of the MIB tree that the agent supports. </td> </tr> </table> The last three syntax types describe exception
    ///conditions under the SNMP version 2C (SNMPv2C) framework.
    uint syntax;
union value
    {
        int       sNumber;
        uint      uNumber;
        smiCNTR64 hNumber;
        smiOCTETS string;
        smiOID    oid;
        ubyte     empty;
    }
}

///<p class="CCE_Message">[SNMP is available for use in the operating systems specified in the Requirements section. It
///may be altered or unavailable in subsequent versions. Instead, use Windows Remote Management, which is the Microsoft
///implementation of WS-Man.] The <b>smiVENDORINFO</b> structure contains information about the Microsoft WinSNMP
///implementation. A WinSNMP application can call the SnmpGetVendorInfo function to retrieve this structure. The
///<b>smiVENDORINFO</b> structure is an element of the WinSNMP API, version 2.0.
struct smiVENDORINFO
{
    ///Contains the null-terminated string "Microsoft Corporation". The string is suitable for display to end users.
    byte[64] vendorName;
    ///Specifies a null-terminated character string that indicates how Microsoft can be contacted for WinSNMP-related
    ///information. For example, this member can contain a postal address, a telephone number or a fax number, a URL, or
    ///an e-mail address such as "snmpinfo@microsoft.com". The string is suitable for display.
    byte[64] vendorContact;
    ///Specifies a null-terminated character string that identifies the version number of the WinSNMP API the Microsoft
    ///WinSNMP implementation is currently supporting. The string is suitable for display.
    byte[32] vendorVersionId;
    ///Specifies a null-terminated character string that indicates the release date of the version of the WinSNMP API
    ///the Microsoft WinSNMP implementation is currently supporting. The string is suitable for display.
    byte[32] vendorVersionDate;
    ///Contains the value 311, Microsoft's enterprise number (permanent address) assigned by the Internet Assigned
    ///Numbers Authority (IANA).
    uint     vendorEnterprise;
}

// Functions

///<p class="CCE_Message">[SNMP is available for use in the operating systems specified in the Requirements section. It
///may be altered or unavailable in subsequent versions. Instead, use Windows Remote Management, which is the Microsoft
///implementation of WS-Man.] The <b>SnmpUtilOidCpy</b> function copies the variable pointed to by the <i>pOidSrc</i>
///parameter to the <i>pOidDst</i> parameter, allocating any necessary memory for the destination's copy. This function
///is an element of the SNMP Utility API.
///Params:
///    pOidDst = Pointer to an AsnObjectIdentifier structure to receive the copy.
///    pOidSrc = Pointer to an AsnObjectIdentifier structure to copy.
///Returns:
///    If the function succeeds, the return value is nonzero. If the function fails, the return value is zero.
///    
@DllImport("snmpapi")
int SnmpUtilOidCpy(AsnObjectIdentifier* pOidDst, AsnObjectIdentifier* pOidSrc);

///<p class="CCE_Message">[SNMP is available for use in the operating systems specified in the Requirements section. It
///may be altered or unavailable in subsequent versions. Instead, use Windows Remote Management, which is the Microsoft
///implementation of WS-Man.] The <b>SnmpUtilOidAppend</b> function appends the source object identifier to the
///destination object identifier. This function is an element of the SNMP Utility API.
///Params:
///    pOidDst = Pointer to an AsnObjectIdentifier structure to receive the source structure.
///    pOidSrc = Pointer to an <b>AsnObjectIdentifier</b> structure to append.
///Returns:
///    If the function succeeds, the return value is nonzero. If the function fails, the return value is zero. This
///    function does not generate Windows Sockets errors. The application should call the GetLastError function.
///    <b>GetLastError</b> may return the following error codes. <table> <tr> <th>Return code</th> <th>Description</th>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>SNMP_BERAPI_OVERFLOW</b></dt> </dl> </td> <td width="60%"> Indicates an
///    overflow condition </td> </tr> <tr> <td width="40%"> <dl> <dt><b>SNMP_MEM_ALLOC_ERROR</b></dt> </dl> </td> <td
///    width="60%"> Indicates a memory allocation error </td> </tr> </table>
///    
@DllImport("snmpapi")
int SnmpUtilOidAppend(AsnObjectIdentifier* pOidDst, AsnObjectIdentifier* pOidSrc);

///<p class="CCE_Message">[SNMP is available for use in the operating systems specified in the Requirements section. It
///may be altered or unavailable in subsequent versions. Instead, use Windows Remote Management, which is the Microsoft
///implementation of WS-Man.] The <b>SnmpUtilOidNCmp</b> function compares two object identifiers. The function compares
///the subidentifiers in the variables until it reaches the number of subidentifiers specified by the <i>nSubIds</i>
///parameter. <b>SnmpUtilOidNCmp</b> is an element of the SNMP Utility API.
///Params:
///    pOid1 = Pointer to an AsnObjectIdentifier structure to compare.
///    pOid2 = Pointer to a second AsnObjectIdentifier structure to compare.
///    nSubIds = Specifies the number of subidentifiers to compare.
///Returns:
///    The function returns a value greater than zero if <i>pOid1</i> is greater than <i>pOid2</i>, zero if <i>pOid1</i>
///    equals <i>pOid2</i>, and less than zero if <i>pOid1</i> is less than <i>pOid2</i>.
///    
@DllImport("snmpapi")
int SnmpUtilOidNCmp(AsnObjectIdentifier* pOid1, AsnObjectIdentifier* pOid2, uint nSubIds);

///<p class="CCE_Message">[SNMP is available for use in the operating systems specified in the Requirements section. It
///may be altered or unavailable in subsequent versions. Instead, use Windows Remote Management, which is the Microsoft
///implementation of WS-Man.] The <b>SnmpUtilOidCmp</b> function compares two object identifiers. This function is an
///element of the SNMP Utility API.
///Params:
///    pOid1 = Pointer to an AsnObjectIdentifier structure to compare.
///    pOid2 = Pointer to a second <b>AsnObjectIdentifier</b> structure to compare.
///Returns:
///    The function returns a value greater than zero if <i>pOid1</i> is greater than <i>pOid2</i>, zero if <i>pOid1</i>
///    equals <i>pOid2</i>, and less than zero if <i>pOid1</i> is less than <i>pOid2</i>.
///    
@DllImport("snmpapi")
int SnmpUtilOidCmp(AsnObjectIdentifier* pOid1, AsnObjectIdentifier* pOid2);

///<p class="CCE_Message">[SNMP is available for use in the operating systems specified in the Requirements section. It
///may be altered or unavailable in subsequent versions. Instead, use Windows Remote Management, which is the Microsoft
///implementation of WS-Man.] The <b>SnmpUtilOidFree</b> function frees the memory allocated for the specified object
///identifier. This function is an element of the SNMP Utility API.
///Params:
///    pOid = Pointer to an AsnObjectIdentifier structure whose memory should be freed.
///Returns:
///    This function does not return a value.
///    
@DllImport("snmpapi")
void SnmpUtilOidFree(AsnObjectIdentifier* pOid);

///<p class="CCE_Message">[SNMP is available for use in the operating systems specified in the Requirements section. It
///may be altered or unavailable in subsequent versions. Instead, use Windows Remote Management, which is the Microsoft
///implementation of WS-Man.] The <b>SnmpUtilOctetsCmp</b> function compares two octet strings. This function is an
///element of the SNMP Utility API.
///Params:
///    pOctets1 = Pointer to an AsnOctetString structure to compare.
///    pOctets2 = Pointer to a second <b>AsnOctetString</b> structure to compare.
///Returns:
///    The function returns a value greater than zero if <i>pOctets1</i> is greater than <i>pOctets2</i>, zero if
///    <i>pOctets1</i> equals <i>pOctets2</i>, and less than zero if <i>pOctets1</i> is less than <i>pOctets2</i>.
///    
@DllImport("snmpapi")
int SnmpUtilOctetsCmp(AsnOctetString* pOctets1, AsnOctetString* pOctets2);

///<p class="CCE_Message">[SNMP is available for use in the operating systems specified in the Requirements section. It
///may be altered or unavailable in subsequent versions. Instead, use Windows Remote Management, which is the Microsoft
///implementation of WS-Man.] The <b>SnmpUtilOctetsNCmp</b> function compares two octet strings. The function compares
///the subidentifiers in the strings until it reaches the number of subidentifiers specified by the <i>nChars</i>
///parameter. <b>SnmpUtilOctetsNCmp</b> is an element of the SNMP Utility API.
///Params:
///    pOctets1 = Pointer to an AsnOctetString structure to compare.
///    pOctets2 = Pointer to a second <b>AsnOctetString</b> structure to compare.
///    nChars = Specifies the number of subidentifiers to compare.
///Returns:
///    The function returns a value greater than zero if <i>pOctets1</i> is greater than <i>pOctets2</i>, zero if
///    <i>pOctets1</i> equals <i>pOctets2</i>, and less than zero if <i>pOctets1</i> is less than <i>pOctets2</i>.
///    
@DllImport("snmpapi")
int SnmpUtilOctetsNCmp(AsnOctetString* pOctets1, AsnOctetString* pOctets2, uint nChars);

///<p class="CCE_Message">[SNMP is available for use in the operating systems specified in the Requirements section. It
///may be altered or unavailable in subsequent versions. Instead, use Windows Remote Management, which is the Microsoft
///implementation of WS-Man.] The <b>SnmpUtilOctetsCpy</b> function copies the variable pointed to by the
///<i>pOctetsSrc</i> parameter to the variable pointed to by the <i>pOctetsDst</i> parameter. The function allocates any
///necessary memory for the destination's copy. The <b>SnmpUtilOctetsCpy</b> function is an element of the SNMP Utility
///API.
///Params:
///    pOctetsDst = Pointer to an AsnOctetString structure to receive the copy.
///    pOctetsSrc = Pointer to an <b>AsnOctetString</b> structure to copy.
///Returns:
///    If the function succeeds, the return value is nonzero. If the function fails, the return value is zero.
///    
@DllImport("snmpapi")
int SnmpUtilOctetsCpy(AsnOctetString* pOctetsDst, AsnOctetString* pOctetsSrc);

///<p class="CCE_Message">[SNMP is available for use in the operating systems specified in the Requirements section. It
///may be altered or unavailable in subsequent versions. Instead, use Windows Remote Management, which is the Microsoft
///implementation of WS-Man.] The <b>SnmpUtilOctetsFree</b> function frees the memory allocated for the specified octet
///string. This function is an element of the SNMP Utility API.
///Params:
///    pOctets = Pointer to an AsnOctetString structure whose memory should be freed.
///Returns:
///    This function does not return a value.
///    
@DllImport("snmpapi")
void SnmpUtilOctetsFree(AsnOctetString* pOctets);

///<p class="CCE_Message">[SNMP is available for use in the operating systems specified in the Requirements section. It
///may be altered or unavailable in subsequent versions. Instead, use Windows Remote Management, which is the Microsoft
///implementation of WS-Man.] The <b>SnmpUtilAsnAnyCpy</b> function copies the variable pointed to by the <i>pAnySrc</i>
///parameter to the <i>pAnyDst</i> parameter. The function allocates any necessary memory for the destination's copy.
///The <b>SnmpUtilAsnAnyCpy</b> function is an element of the SNMP Utility API.
///Params:
///    pAnyDst = Pointer to an AsnAny structure to receive the copy.
///    pAnySrc = Pointer to an <b>AsnAny</b> structure to copy.
///Returns:
///    If the function succeeds, the return value is nonzero. If the function fails, the return value is zero.
///    
@DllImport("snmpapi")
int SnmpUtilAsnAnyCpy(AsnAny* pAnyDst, AsnAny* pAnySrc);

///<p class="CCE_Message">[SNMP is available for use in the operating systems specified in the Requirements section. It
///may be altered or unavailable in subsequent versions. Instead, use Windows Remote Management, which is the Microsoft
///implementation of WS-Man.] The <b>SnmpUtilAsnAnyFree</b> function frees the memory allocated for the specified AsnAny
///structure. This function is an element of the SNMP Utility API.
///Params:
///    pAny = Pointer to an AsnAny structure whose memory should be freed.
///Returns:
///    This function does not return a value.
///    
@DllImport("snmpapi")
void SnmpUtilAsnAnyFree(AsnAny* pAny);

///<p class="CCE_Message">[SNMP is available for use in the operating systems specified in the Requirements section. It
///may be altered or unavailable in subsequent versions. Instead, use Windows Remote Management, which is the Microsoft
///implementation of WS-Man.] The <b>SnmpUtilVarBindCpy</b> function copies the specified SnmpVarBind structure, and
///allocates any memory necessary for the destination structure. The <b>SnmpUtilVarBindCpy</b> function is an element of
///the SNMP Utility API.
///Params:
///    pVbDst = Pointer to an SnmpVarBind structure to receive the copy.
///    pVbSrc = Pointer to an SnmpVarBind structure to copy.
///Returns:
///    If the function succeeds, the return value is nonzero. If the function fails, the return value is zero.
///    
@DllImport("snmpapi")
int SnmpUtilVarBindCpy(SnmpVarBind* pVbDst, SnmpVarBind* pVbSrc);

///<p class="CCE_Message">[SNMP is available for use in the operating systems specified in the Requirements section. It
///may be altered or unavailable in subsequent versions. Instead, use Windows Remote Management, which is the Microsoft
///implementation of WS-Man.] The <b>SnmpUtilVarBindFree</b> function frees the memory allocated for an SnmpVarBind
///structure. This function is an element of the SNMP Utility API.
///Params:
///    pVb = Pointer to an SnmpVarBind structure whose memory should be freed.
///Returns:
///    This function does not return a value.
///    
@DllImport("snmpapi")
void SnmpUtilVarBindFree(SnmpVarBind* pVb);

///<p class="CCE_Message">[SNMP is available for use in the operating systems specified in the Requirements section. It
///may be altered or unavailable in subsequent versions. Instead, use Windows Remote Management, which is the Microsoft
///implementation of WS-Man.] The <b>SnmpUtilVarBindListCpy</b> function copies the specified SnmpVarBindList structure,
///and allocates any necessary memory for the destination's copy. This function is an element of the SNMP Utility API.
///Params:
///    pVblDst = Pointer to an SnmpVarBindList structure to receive the copy.
///    pVblSrc = Pointer to an SnmpVarBindList structure to copy.
///Returns:
///    If the function succeeds, the return value is nonzero. If the function fails, the return value is zero.
///    
@DllImport("snmpapi")
int SnmpUtilVarBindListCpy(SnmpVarBindList* pVblDst, SnmpVarBindList* pVblSrc);

///<p class="CCE_Message">[SNMP is available for use in the operating systems specified in the Requirements section. It
///may be altered or unavailable in subsequent versions. Instead, use Windows Remote Management, which is the Microsoft
///implementation of WS-Man.] The <b>SnmpUtilVarBindListFree</b> function frees the memory allocated for an
///SnmpVarBindList structure. This function is an element of the SNMP Utility API.
///Params:
///    pVbl = Pointer to an SnmpVarBindList structure whose allocated memory should be freed.
///Returns:
///    This function has no return values.
///    
@DllImport("snmpapi")
void SnmpUtilVarBindListFree(SnmpVarBindList* pVbl);

///<p class="CCE_Message">[SNMP is available for use in the operating systems specified in the Requirements section. It
///may be altered or unavailable in subsequent versions. Instead, use Windows Remote Management, which is the Microsoft
///implementation of WS-Man.] The <b>SnmpUtilMemFree</b> function frees the specified memory object. This function is an
///element of the SNMP Utility API.
///Params:
///    pMem = Pointer to the memory object to release.
///Returns:
///    This function does not return a value.
///    
@DllImport("snmpapi")
void SnmpUtilMemFree(void* pMem);

///<p class="CCE_Message">[SNMP is available for use in the operating systems specified in the Requirements section. It
///may be altered or unavailable in subsequent versions. Instead, use Windows Remote Management, which is the Microsoft
///implementation of WS-Man.] The <b>SnmpUtilMemAlloc</b> function allocates dynamic memory from the process heap. This
///function is an element of the SNMP Utility API.
///Params:
///    nBytes = Specifies the number of bytes to allocate for the memory object.
///Returns:
///    If the function succeeds, the return value is a pointer to the newly allocated memory object. If the function
///    fails, the return value is <b>NULL</b>.
///    
@DllImport("snmpapi")
void* SnmpUtilMemAlloc(uint nBytes);

///<p class="CCE_Message">[SNMP is available for use in the operating systems specified in the Requirements section. It
///may be altered or unavailable in subsequent versions. Instead, use Windows Remote Management, which is the Microsoft
///implementation of WS-Man.] The <b>SnmpUtilMemReAlloc</b> function changes the size of the specified memory object.
///This function is an element of the SNMP Utility API.
///Params:
///    pMem = Pointer to the memory object to resize.
///    nBytes = Specifies the number of bytes to allocate for the new memory object.
///Returns:
///    If the function succeeds, the return value is a pointer to the newly allocated memory object. If the function
///    fails, the return value is <b>NULL</b>.
///    
@DllImport("snmpapi")
void* SnmpUtilMemReAlloc(void* pMem, uint nBytes);

///<p class="CCE_Message">[SNMP is available for use in the operating systems specified in the Requirements section. It
///may be altered or unavailable in subsequent versions. Instead, use Windows Remote Management, which is the Microsoft
///implementation of WS-Man.] The <b>SnmpUtilOidToA</b> function converts an object identifier (OID) to a
///null-terminated string. This function is an element of the SNMP Utility API.
///Params:
///    Oid = Pointer to an AsnObjectIdentifier structure to convert.
///Returns:
///    The function returns a null-terminated string of characters that contains the string representation of the object
///    identifier pointed to by the <i>Oid</i> parameter.
///    
@DllImport("snmpapi")
PSTR SnmpUtilOidToA(AsnObjectIdentifier* Oid);

///<p class="CCE_Message">[SNMP is available for use in the operating systems specified in the Requirements section. It
///may be altered or unavailable in subsequent versions. Instead, use Windows Remote Management, which is the Microsoft
///implementation of WS-Man.] The <b>SnmpUtilIdsToA</b> function converts an object identifier (OID) to a
///null-terminated string. This function is an element of the SNMP Utility API.
///Params:
///    Ids = Pointer to an array of unsigned integers. The array contains the sequence of numbers that the OID contains. The
///          <i>IdLength</i> parameter specifies the array's length. For more information, see the following Return Values and
///          Remarks sections.
///    IdLength = Specifies the number of elements in the array pointed to by the <i>Ids</i> parameter.
///Returns:
///    The function returns a null-terminated string that contains the string representation of the array of numbers
///    pointed to by the <i>Ids</i> parameter. The string contains a sequence of numbers separated by periods ('.'); for
///    example, 1.3.6.1.4.1.311. If the <i>Ids</i> parameter is null, or if the <i>IdLength</i> parameter specifies
///    zero, the function returns the string "&lt;null oid&gt;". The maximum length of the returned string is 256
///    characters. If the string's length exceeds 256 characters, the string is truncated and terminated with a sequence
///    of three periods ('...').
///    
@DllImport("snmpapi")
PSTR SnmpUtilIdsToA(uint* Ids, uint IdLength);

///<p class="CCE_Message">[SNMP is available for use in the operating systems specified in the Requirements section. It
///may be altered or unavailable in subsequent versions. Instead, use Windows Remote Management, which is the Microsoft
///implementation of WS-Man.] The <b>SnmpUtilPrintOid</b> function formats the specified object identifier (OID) and
///prints the result to the standard output device. This function is an element of the SNMP Utility API.
///Params:
///    Oid = Pointer to an AsnObjectIdentifier structure to print.
///Returns:
///    This function does not return a value.
///    
@DllImport("snmpapi")
void SnmpUtilPrintOid(AsnObjectIdentifier* Oid);

///<p class="CCE_Message">[SNMP is available for use in the operating systems specified in the Requirements section. It
///may be altered or unavailable in subsequent versions. Instead, use Windows Remote Management, which is the Microsoft
///implementation of WS-Man.] The <b>SnmpUtilPrintAsnAny</b> function prints the value of the <i>Any</i> parameter to
///the standard output. This function is an element of the SNMP Utility API.
///Params:
///    pAny = Pointer to an AsnAny structure for a value to print.
///Returns:
///    This function does not return a value.
///    
@DllImport("snmpapi")
void SnmpUtilPrintAsnAny(AsnAny* pAny);

///<p class="CCE_Message">[SNMP is available for use in the operating systems specified in the Requirements section. It
///may be altered or unavailable in subsequent versions. Instead, use Windows Remote Management, which is the Microsoft
///implementation of WS-Man.] The <b>SnmpSvcGetUptime</b> function retrieves the number of centiseconds that the SNMP
///service has been running. This function is an element of the SNMP Utility API.
///Returns:
///    The function returns a <b>DWORD</b> value that is the number of centiseconds the SNMP service has been running.
///    
@DllImport("snmpapi")
uint SnmpSvcGetUptime();

///<p class="CCE_Message">[SNMP is available for use in the operating systems specified in the Requirements section. It
///may be altered or unavailable in subsequent versions. Instead, use Windows Remote Management, which is the Microsoft
///implementation of WS-Man.] The <b>SnmpSvcSetLogLevel</b> function adjusts the level of detail of the debug output
///from the SNMP service and from SNMP extension agents using the SnmpUtilDbgPrint function. This function is an element
///of the SNMP Utility API.
///Params:
///    nLogLevel = Specifies a signed integer variable that indicates the level of detail of the debug output from the
///                SnmpUtilDbgPrint function. This parameter can be one of the following values. <table> <tr> <th>Value</th>
///                <th>Meaning</th> </tr> <tr> <td width="40%"><a id="SNMP_LOG_SILENT"></a><a id="snmp_log_silent"></a><dl>
///                <dt><b>SNMP_LOG_SILENT</b></dt> </dl> </td> <td width="60%"> Disable all debugging output. </td> </tr> <tr> <td
///                width="40%"><a id="SNMP_LOG_FATAL"></a><a id="snmp_log_fatal"></a><dl> <dt><b>SNMP_LOG_FATAL</b></dt> </dl> </td>
///                <td width="60%"> Display fatal errors only. </td> </tr> <tr> <td width="40%"><a id="SNMP_LOG_ERROR"></a><a
///                id="snmp_log_error"></a><dl> <dt><b>SNMP_LOG_ERROR</b></dt> </dl> </td> <td width="60%"> Display recoverable
///                errors. </td> </tr> <tr> <td width="40%"><a id="SNMP_LOG_WARNING"></a><a id="snmp_log_warning"></a><dl>
///                <dt><b>SNMP_LOG_WARNING</b></dt> </dl> </td> <td width="60%"> Display warnings and recoverable errors. </td>
///                </tr> <tr> <td width="40%"><a id="SNMP_LOG_TRACE"></a><a id="snmp_log_trace"></a><dl>
///                <dt><b>SNMP_LOG_TRACE</b></dt> </dl> </td> <td width="60%"> Display trace information. </td> </tr> <tr> <td
///                width="40%"><a id="SNMP_LOG_VERBOSE"></a><a id="snmp_log_verbose"></a><dl> <dt><b>SNMP_LOG_VERBOSE</b></dt> </dl>
///                </td> <td width="60%"> Display verbose trace information. </td> </tr> </table>
///Returns:
///    This function does not return a value.
///    
@DllImport("snmpapi")
void SnmpSvcSetLogLevel(int nLogLevel);

///<p class="CCE_Message">[SNMP is available for use in the operating systems specified in the Requirements section. It
///may be altered or unavailable in subsequent versions. Instead, use Windows Remote Management, which is the Microsoft
///implementation of WS-Man.] The <b>SnmpSvcSetLogType</b> function adjusts the destination for the debug output from
///the SNMP service and from SNMP extension agents using the SnmpUtilDbgPrint function. This function is an element of
///the SNMP Utility API.
///Params:
///    nLogType = Specifies a signed integer variable that represents the destination for the debug output from the
///               SnmpUtilDbgPrint function. This parameter can be one of the following values. <table> <tr> <th>Value</th>
///               <th>Meaning</th> </tr> <tr> <td width="40%"><a id="SNMP_OUTPUT_TO_CONSOLE"></a><a
///               id="snmp_output_to_console"></a><dl> <dt><b>SNMP_OUTPUT_TO_CONSOLE</b></dt> </dl> </td> <td width="60%"> The
///               destination for the debug output is a console window. </td> </tr> <tr> <td width="40%"><a
///               id="SNMP_OUTPUT_TO_LOGFILE"></a><a id="snmp_output_to_logfile"></a><dl> <dt><b>SNMP_OUTPUT_TO_LOGFILE</b></dt>
///               </dl> </td> <td width="60%"> The destination for the debug output is the SNMPDBG.LOG file in the SYSTEM32
///               directory. </td> </tr> <tr> <td width="40%"><a id="SNMP_OUTPUT_TO_DEBUGGER"></a><a
///               id="snmp_output_to_debugger"></a><dl> <dt><b>SNMP_OUTPUT_TO_DEBUGGER</b></dt> </dl> </td> <td width="60%"> The
///               destination for the debug output is a debugger utility. </td> </tr> </table>
///Returns:
///    This function does not return a value.
///    
@DllImport("snmpapi")
void SnmpSvcSetLogType(int nLogType);

///<p class="CCE_Message">[SNMP is available for use in the operating systems specified in the Requirements section. It
///may be altered or unavailable in subsequent versions. Instead, use Windows Remote Management, which is the Microsoft
///implementation of WS-Man.] The <b>SnmpUtilDbgPrint</b> function enables debugging output from the SNMP service. This
///function is an element of the SNMP Utility API.
///Params:
///    nLogLevel = Specifies a signed integer variable that indicates the level of detail of the log event. This parameter can be
///                one of the following values. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
///                id="SNMP_LOG_SILENT"></a><a id="snmp_log_silent"></a><dl> <dt><b>SNMP_LOG_SILENT</b></dt> </dl> </td> <td
///                width="60%"> Disable all debugging output. </td> </tr> <tr> <td width="40%"><a id="SNMP_LOG_FATAL"></a><a
///                id="snmp_log_fatal"></a><dl> <dt><b>SNMP_LOG_FATAL</b></dt> </dl> </td> <td width="60%"> Display fatal errors
///                only. </td> </tr> <tr> <td width="40%"><a id="SNMP_LOG_ERROR"></a><a id="snmp_log_error"></a><dl>
///                <dt><b>SNMP_LOG_ERROR</b></dt> </dl> </td> <td width="60%"> Display recoverable errors. </td> </tr> <tr> <td
///                width="40%"><a id="SNMP_LOG_WARNING"></a><a id="snmp_log_warning"></a><dl> <dt><b>SNMP_LOG_WARNING</b></dt> </dl>
///                </td> <td width="60%"> Display warnings and recoverable errors. </td> </tr> <tr> <td width="40%"><a
///                id="SNMP_LOG_TRACE"></a><a id="snmp_log_trace"></a><dl> <dt><b>SNMP_LOG_TRACE</b></dt> </dl> </td> <td
///                width="60%"> Display trace information. </td> </tr> <tr> <td width="40%"><a id="SNMP_LOG_VERBOSE"></a><a
///                id="snmp_log_verbose"></a><dl> <dt><b>SNMP_LOG_VERBOSE</b></dt> </dl> </td> <td width="60%"> Display verbose
///                trace information. </td> </tr> </table>
///    szFormat = Pointer to a null-terminated format string that is similar to the standard C library function <b>printf</b>
///               style.
///     = Additional parameters.
///Returns:
///    This function does not return a value.
///    
@DllImport("snmpapi")
void SnmpUtilDbgPrint(int nLogLevel, PSTR szFormat);

///<p class="CCE_Message">[SNMP is available for use in the operating systems specified in the Requirements section. It
///may be altered or unavailable in subsequent versions. Instead, use Windows Remote Management, which is the Microsoft
///implementation of WS-Man.] The <b>SnmpMgrOpen</b> function initializes communications sockets and data structures,
///allowing communications with the specified SNMP agent. This function is an element of the SNMP Management API.
///Params:
///    lpAgentAddress = Pointer to a <b>null</b>-terminated string that specifies a host name or an IP address. The host name must
///                     resolve to an IP address, an IPX address (in 8.12 notation), or an ethernet address. See the Remarks section for
///                     the acceptable forms for host names and IP addresses.
///    lpAgentCommunity = Pointer to a <b>null</b>-terminated string that specifies the SNMP community name to use when communicating with
///                       the agent that is identified by the <i>lpAgentAddress</i> parameter.
///    nTimeOut = Specifies the communications time-out in milliseconds.
///    nRetries = Specifies the communications retry count. The time-out that is specified in the <i>nTimeOut</i> parameter is
///               doubled each time that a retry attempt is transmitted.
///Returns:
///    If the function succeeds, the return value is a pointer to an <b>LPSNMP_MGR_SESSION</b> structure. This structure
///    is used internally and the programmer should not alter it. For more information, see the following Remarks
///    section. If the function fails, the return value is <b>NULL</b>. To get extended error information, call
///    GetLastError. <b>GetLastError</b> may return the SNMP_MEM_ALLOC_ERROR error code, which indicates a memory
///    allocation error. This function may also return Windows Sockets error codes.
///    
@DllImport("mgmtapi")
void* SnmpMgrOpen(PSTR lpAgentAddress, PSTR lpAgentCommunity, int nTimeOut, int nRetries);

///<p class="CCE_Message">[SNMP is available for use in the operating systems specified in the Requirements section. It
///may be altered or unavailable in subsequent versions. Instead, use Windows Remote Management, which is the Microsoft
///implementation of WS-Man.] The <b>SnmpMgrCtl</b> function sets an operating parameter associated with an SNMP
///session. This function is an element of the SNMP Management API.
///Params:
///    session = Pointer to an internal structure that specifies the session to which the control code applies.
///    dwCtlCode = Specifies a value (a control code) that identifies the operation to perform. Currently, MGMCTL_SETAGENTPORT is
///                the only supported control code. Setting this code allows an SNMP management application to send requests to a
///                remote agent that is "listening" for SNMP manager requests on an arbitrary port. For more information, see the
///                <i>lpvInBuffer</i> and the <i>cbInBuffer</i> parameter descriptions.
///    lpvInBuffer = Pointer to the buffer that contains the input parameters required for the operation. When you specify the
///                  MGMCTL_SETAGENTPORT control code, this parameter must point to an unsigned integer that specifies the port number
///                  on which the remote agent will "listen" for SNMP manager requests. The port number must be in host-byte order.
///    cbInBuffer = Specifies the size, in bytes, of the buffer pointed to by the <i>lpvInBuffer</i> parameter. When you specify the
///                 MGMCTL_SETAGENTPORT control code, this parameter is equal to sizeof(UINT).
///    lpvOUTBuffer = Pointer to the buffer that receives the operation's output data.
///    cbOUTBuffer = Specifies the size, in bytes, of the buffer pointed to by the <i>lpvOutBuffer</i> parameter.
///    lpcbBytesReturned = Pointer to a variable that receives the actual size, in bytes, of the data stored in the buffer pointed to by the
///                        <i>lpvOutBuffer</i> parameter.
///Returns:
///    If the function succeeds, the return value is nonzero. If the function fails, the return value is zero. To get
///    extended error information, call GetLastError. <b>GetLastError</b> can also return one of the following error
///    codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>SNMP_MGMTAPI_INVALID_CTL</b></dt> </dl> </td> <td width="60%"> The <i>dwCtlCode</i> parameter does not
///    specify a valid control code. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>SNMP_MGMTAPI_INVALID_SESSION</b></dt>
///    </dl> </td> <td width="60%"> The <i>session</i> parameter does not specify a valid SNMP session. </td> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>SNMP_MGMTAPI_INVALID_BUFFER</b></dt> </dl> </td> <td width="60%"> One or more of the
///    <i>lpvInBuffer</i>, <i>lpvOutBuffer</i>, or <i>lpcbBytesRequired</i> parameters are invalid, or the
///    <i>cbInBuffer</i> or <i>cbOutBuffer</i> parameter is too small. </td> </tr> </table>
///    
@DllImport("mgmtapi")
BOOL SnmpMgrCtl(void* session, uint dwCtlCode, void* lpvInBuffer, uint cbInBuffer, void* lpvOUTBuffer, 
                uint cbOUTBuffer, uint* lpcbBytesReturned);

///<p class="CCE_Message">[SNMP is available for use in the operating systems specified in the Requirements section. It
///may be altered or unavailable in subsequent versions. Instead, use Windows Remote Management, which is the Microsoft
///implementation of WS-Man.] The <b>SnmpMgrClose</b> function closes the communications sockets and data structures
///that are associated with the specified session. This function is an element of the SNMP Management API.
///Params:
///    session = Pointer to an internal structure that specifies the session to close. For more information, see the following
///              Remarks section.
///Returns:
///    If the function succeeds, the return value is nonzero. If the function fails, the return value is zero. This
///    function may return Windows Sockets error codes.
///    
@DllImport("mgmtapi")
BOOL SnmpMgrClose(void* session);

///<p class="CCE_Message">[SNMP is available for use in the operating systems specified in the Requirements section. It
///may be altered or unavailable in subsequent versions. Instead, use Windows Remote Management, which is the Microsoft
///implementation of WS-Man.] The <b>SnmpMgrRequest</b> function requests the specified operation be performed with the
///specified agent. This function is an element of the SNMP Management API.
///Params:
///    session = Pointer to an internal structure that specifies the session that will perform the request. Applications should
///              not specify the <b>LPSNMP_MGR_SESSION</b> pointer returned by this function in a different thread. You can
///              specify a pointer returned by SnmpMgrOpen, but only if the calls to <b>SnmpMgrOpen</b> and <b>SnmpMgrRequest</b>
///              originate in the context of the same thread.
///    requestType = Specifies the SNMP request type. This parameter can be one of the following values defined by SNMPv1. <table>
///                  <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="SNMP_PDU_GET"></a><a
///                  id="snmp_pdu_get"></a><dl> <dt><b>SNMP_PDU_GET</b></dt> </dl> </td> <td width="60%"> Retrieve the value or values
///                  of the specified variables. </td> </tr> <tr> <td width="40%"><a id="SNMP_PDU_GETNEXT"></a><a
///                  id="snmp_pdu_getnext"></a><dl> <dt><b>SNMP_PDU_GETNEXT</b></dt> </dl> </td> <td width="60%"> Retrieve the value
///                  or values of the lexicographic successor of the specified variable. </td> </tr> <tr> <td width="40%"><a
///                  id="SNMP_PDU_SET"></a><a id="snmp_pdu_set"></a><dl> <dt><b>SNMP_PDU_SET</b></dt> </dl> </td> <td width="60%">
///                  Write a value within a specific variable. </td> </tr> </table> Note that PDU request types have been renamed. For
///                  additional information, see SNMP Variable Types and Request PDU Types.
///    variableBindings = Pointer to the variable bindings list. <div class="alert"><b>Note</b> The SnmpVarBind array pointed to by the
///                       SnmpVarBindList structure must be allocated using the SnmpUtilMemAlloc function.</div> <div> </div>
///    errorStatus = Pointer to a variable in which the error status result will be returned. This parameter can be one of the
///                  following values defined by SNMPv1. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
///                  id="SNMP_ERRORSTATUS_NOERROR"></a><a id="snmp_errorstatus_noerror"></a><dl>
///                  <dt><b>SNMP_ERRORSTATUS_NOERROR</b></dt> </dl> </td> <td width="60%"> The agent reports that no errors occurred
///                  during transmission. </td> </tr> <tr> <td width="40%"><a id="SNMP_ERRORSTATUS_TOOBIG"></a><a
///                  id="snmp_errorstatus_toobig"></a><dl> <dt><b>SNMP_ERRORSTATUS_TOOBIG</b></dt> </dl> </td> <td width="60%"> The
///                  agent could not place the results of the requested operation into a single SNMP message. </td> </tr> <tr> <td
///                  width="40%"><a id="SNMP_ERRORSTATUS_NOSUCHNAME"></a><a id="snmp_errorstatus_nosuchname"></a><dl>
///                  <dt><b>SNMP_ERRORSTATUS_NOSUCHNAME</b></dt> </dl> </td> <td width="60%"> The requested operation identified an
///                  unknown variable. </td> </tr> <tr> <td width="40%"><a id="SNMP_ERRORSTATUS_BADVALUE"></a><a
///                  id="snmp_errorstatus_badvalue"></a><dl> <dt><b>SNMP_ERRORSTATUS_BADVALUE</b></dt> </dl> </td> <td width="60%">
///                  The requested operation tried to change a variable but it specified either a syntax or value error. </td> </tr>
///                  <tr> <td width="40%"><a id="SNMP_ERRORSTATUS_READONLY"></a><a id="snmp_errorstatus_readonly"></a><dl>
///                  <dt><b>SNMP_ERRORSTATUS_READONLY</b></dt> </dl> </td> <td width="60%"> The requested operation tried to change a
///                  variable that was not allowed to change according to the community profile of the variable. </td> </tr> <tr> <td
///                  width="40%"><a id="SNMP_ERRORSTATUS_GENERR"></a><a id="snmp_errorstatus_generr"></a><dl>
///                  <dt><b>SNMP_ERRORSTATUS_GENERR</b></dt> </dl> </td> <td width="60%"> An error other than one of those listed here
///                  occurred during the requested operation. </td> </tr> </table>
///    errorIndex = Pointer to a variable in which the error index result will be returned.
///Returns:
///    If the function succeeds, the return value is nonzero. If the function fails, the return value is <b>NULL</b>. To
///    get extended error information, call GetLastError, which may return one of the following error codes. <table>
///    <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>SNMP_MGMTAPI_TIMEOUT</b></dt> </dl> </td> <td width="60%"> The request timed-out. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>SNMP_MGMTAPI_SELECT_FDERRORS</b></dt> </dl> </td> <td width="60%"> Unexpected error file
///    descriptors indicated by the Windows Sockets select function. </td> </tr> </table>
///    
@DllImport("mgmtapi")
int SnmpMgrRequest(void* session, ubyte requestType, SnmpVarBindList* variableBindings, int* errorStatus, 
                   int* errorIndex);

///<p class="CCE_Message">[SNMP is available for use in the operating systems specified in the Requirements section. It
///may be altered or unavailable in subsequent versions. Instead, use Windows Remote Management, which is the Microsoft
///implementation of WS-Man.] The <b>SnmpMgrStrToOid</b> function converts the string format of an object identifier to
///its internal object identifier structure. This function is an element of the SNMP Management API.
///Params:
///    string = Pointer to a null-terminated string to convert.
///    oid = Pointer to an object identifier variable to receive the converted value.
///Returns:
///    If the function succeeds, the return value is nonzero. If the function fails, the return value is zero.
///    
@DllImport("mgmtapi")
BOOL SnmpMgrStrToOid(PSTR string, AsnObjectIdentifier* oid);

///<p class="CCE_Message">[SNMP is available for use in the operating systems specified in the Requirements section. It
///may be altered or unavailable in subsequent versions. Instead, use Windows Remote Management, which is the Microsoft
///implementation of WS-Man.] The <b>SnmpMgrOidToStr</b> function converts an internal object identifier structure to
///its string representation. This function is an element of the SNMP Management API.
///Params:
///    oid = Pointer to an object identifier variable to convert.
///    string = Pointer to a null-terminated string to receive the converted value.
///Returns:
///    If the function succeeds, the return value is nonzero. If the function fails, the return value is zero.
///    
@DllImport("mgmtapi")
BOOL SnmpMgrOidToStr(AsnObjectIdentifier* oid, PSTR* string);

///<p class="CCE_Message">[SNMP is available for use in the operating systems specified in the Requirements section. It
///may be altered or unavailable in subsequent versions. Instead, use Windows Remote Management, which is the Microsoft
///implementation of WS-Man.] The <b>SnmpMgrTrapListen</b> function registers the ability of an SNMP manager application
///to receive SNMP traps from the SNMP Trap Service. This function is an element of the SNMP Management API.
///Params:
///    phTrapAvailable = Pointer to an event handle to receive an indication that there are traps available, and that the application
///                      should call the SnmpMgrGetTrap function.
///Returns:
///    If the function succeeds, the return value is nonzero. If the function fails, the return value is zero. To get
///    extended error information, call GetLastError, which may return any of the following error codes. <table> <tr>
///    <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>SNMP_MEM_ALLOC_ERROR</b></dt>
///    </dl> </td> <td width="60%"> Indicates a memory allocation error. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>SNMP_MGMTAPI_TRAP_DUPINIT</b></dt> </dl> </td> <td width="60%"> Indicates that this function has already
///    been called. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>SNMP_MGMTAPI_TRAP_ERRORS</b></dt> </dl> </td> <td
///    width="60%"> Indicates one or more errors occurred; traps are not accessible. The application can attempt to call
///    the function again. </td> </tr> </table> This function may return other system errors as well.
///    
@DllImport("mgmtapi")
BOOL SnmpMgrTrapListen(HANDLE* phTrapAvailable);

///<p class="CCE_Message">[SNMP is available for use in the operating systems specified in the Requirements section. It
///may be altered or unavailable in subsequent versions. Instead, use Windows Remote Management, which is the Microsoft
///implementation of WS-Man.] The <b>SnmpMgrGetTrap</b> function returns outstanding trap data that the caller has not
///received if trap reception is enabled. This function is an element of the SNMP Management API. In addition to the
///information returned by this function, the SnmpMgrGetTrapEx function returns the address of the transport source and
///the community string of the trap.
///Params:
///    enterprise = Pointer to an AsnObjectIdentifier structure to receive the enterprise that generated the SNMP trap.
///    IPAddress = Pointer to a variable to receive the address of the agent that generated the SNMP trap.
///    genericTrap = Pointer to a variable to receive an indicator of the generic trap. This parameter can be one of the following
///                  values. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
///                  id="SNMP_GENERICTRAP_COLDSTART"></a><a id="snmp_generictrap_coldstart"></a><dl>
///                  <dt><b>SNMP_GENERICTRAP_COLDSTART</b></dt> </dl> </td> <td width="60%"> The agent is initializing protocol
///                  entities on the managed mode. It may alter objects in its view. </td> </tr> <tr> <td width="40%"><a
///                  id="SNMP_GENERICTRAP_WARMSTART"></a><a id="snmp_generictrap_warmstart"></a><dl>
///                  <dt><b>SNMP_GENERICTRAP_WARMSTART</b></dt> </dl> </td> <td width="60%"> The agent is reinitializing itself but it
///                  will not alter objects in its view. </td> </tr> <tr> <td width="40%"><a id="SNMP_GENERICTRAP_LINKDOWN"></a><a
///                  id="snmp_generictrap_linkdown"></a><dl> <dt><b>SNMP_GENERICTRAP_LINKDOWN</b></dt> </dl> </td> <td width="60%"> An
///                  attached interface has changed from the "up" state to the "down" state. The first variable in the variable
///                  bindings list identifies the interface. </td> </tr> <tr> <td width="40%"><a id="SNMP_GENERICTRAP_LINKUP"></a><a
///                  id="snmp_generictrap_linkup"></a><dl> <dt><b>SNMP_GENERICTRAP_LINKUP</b></dt> </dl> </td> <td width="60%"> An
///                  attached interface has changed from the "down" state to the "up" state. The first variable in the variable
///                  bindings list identifies the interface. </td> </tr> <tr> <td width="40%"><a
///                  id="SNMP_GENERICTRAP_AUTHFAILURE"></a><a id="snmp_generictrap_authfailure"></a><dl>
///                  <dt><b>SNMP_GENERICTRAP_AUTHFAILURE</b></dt> </dl> </td> <td width="60%"> An SNMP entity has sent an SNMP
///                  message, but it has falsely claimed to belong to a known community. </td> </tr> <tr> <td width="40%"><a
///                  id="SNMP_GENERICTRAP_EGPNEIGHLOSS"></a><a id="snmp_generictrap_egpneighloss"></a><dl>
///                  <dt><b>SNMP_GENERICTRAP_EGPNEIGHLOSS</b></dt> </dl> </td> <td width="60%"> An EGP peer has changed to the "down"
///                  state. The first variable in the variable bindings list identifies the IP address of the EGP peer. </td> </tr>
///                  <tr> <td width="40%"><a id="SNMP_GENERICTRAP_ENTERSPECIFIC"></a><a id="snmp_generictrap_enterspecific"></a><dl>
///                  <dt><b>SNMP_GENERICTRAP_ENTERSPECIFIC</b></dt> </dl> </td> <td width="60%"> An extraordinary event has occurred
///                  and it is identified in the <i>specificTrap</i> parameter with an enterprise-specific value. </td> </tr> </table>
///    specificTrap = Pointer to a variable to receive an indication of the specific trap generated.
///    timeStamp = Pointer to a variable to receive the time stamp.
///    variableBindings = Pointer to an SnmpVarBindList structure to receive the variable bindings list.
///Returns:
///    If the function returns a trap, the return value is <b>TRUE</b>. The code for the error can be retrieved by
///    calling SnmpGetLastError immediately after the call. You should call the <b>SnmpMgrGetTrap</b> function
///    repeatedly until it returns <b>FALSE</b> (zero). The function may also return the following error codes. <table>
///    <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>SNMP_MGMTAPI_TRAP_ERRORS</b></dt> </dl> </td> <td width="60%"> Indicates errors were encountered; traps
///    are not accessible. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>SNMP_MGMTAPI_NOTRAPS</b></dt> </dl> </td> <td
///    width="60%"> Indicates no traps are available. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>SNMP_MEM_ALLOC_ERROR</b></dt> </dl> </td> <td width="60%"> Indicates a memory allocation error. </td>
///    </tr> </table>
///    
@DllImport("mgmtapi")
BOOL SnmpMgrGetTrap(AsnObjectIdentifier* enterprise, AsnOctetString* IPAddress, int* genericTrap, 
                    int* specificTrap, uint* timeStamp, SnmpVarBindList* variableBindings);

///<p class="CCE_Message">[SNMP is available for use in the operating systems specified in the Requirements section. It
///may be altered or unavailable in subsequent versions. Instead, use Windows Remote Management, which is the Microsoft
///implementation of WS-Man.] The <b>SnmpMgrGetTrapEx</b> function returns outstanding trap data that the caller has not
///received if trap reception is enabled. In addition to the information that is returned by the SnmpMgrGetTrap
///function, this extended function returns the address of the transport source and the community string of the trap.
///This function is an element of the SNMP Management API.
///Params:
///    enterprise = Pointer to an AsnObjectIdentifier structure to receive the enterprise that generated the SNMP trap.
///    agentAddress = Pointer to a variable to receive the address of the agent that generated the SNMP trap; this information is
///                   retrieved from the SNMP protocol data unit (PDU).
///    sourceAddress = Pointer to a variable to receive the address of the agent that generated the SNMP trap; this information is
///                    retrieved from the network transport.
///    genericTrap = Pointer to a variable to receive an indicator of the generic trap. This parameter can be one of the following
///                  values. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
///                  id="SNMP_GENERICTRAP_COLDSTART"></a><a id="snmp_generictrap_coldstart"></a><dl>
///                  <dt><b>SNMP_GENERICTRAP_COLDSTART</b></dt> </dl> </td> <td width="60%"> The agent is initializing protocol
///                  entities on the managed mode. It may alter objects in its view. </td> </tr> <tr> <td width="40%"><a
///                  id="SNMP_GENERICTRAP_WARMSTART"></a><a id="snmp_generictrap_warmstart"></a><dl>
///                  <dt><b>SNMP_GENERICTRAP_WARMSTART</b></dt> </dl> </td> <td width="60%"> The agent is reinitializing itself but it
///                  will not alter objects in its view. </td> </tr> <tr> <td width="40%"><a id="SNMP_GENERICTRAP_LINKDOWN"></a><a
///                  id="snmp_generictrap_linkdown"></a><dl> <dt><b>SNMP_GENERICTRAP_LINKDOWN</b></dt> </dl> </td> <td width="60%"> An
///                  attached interface has changed from the up state to the down state. The first variable in the variable bindings
///                  list identifies the interface. </td> </tr> <tr> <td width="40%"><a id="SNMP_GENERICTRAP_LINKUP"></a><a
///                  id="snmp_generictrap_linkup"></a><dl> <dt><b>SNMP_GENERICTRAP_LINKUP</b></dt> </dl> </td> <td width="60%"> An
///                  attached interface has changed from the down state to the up state. The first variable in the variable bindings
///                  list identifies the interface. </td> </tr> <tr> <td width="40%"><a id="SNMP_GENERICTRAP_AUTHFAILURE"></a><a
///                  id="snmp_generictrap_authfailure"></a><dl> <dt><b>SNMP_GENERICTRAP_AUTHFAILURE</b></dt> </dl> </td> <td
///                  width="60%"> An SNMP entity has sent an SNMP message, but it has falsely claimed to belong to a known community.
///                  </td> </tr> <tr> <td width="40%"><a id="SNMP_GENERICTRAP_EGPNEIGHLOSS"></a><a
///                  id="snmp_generictrap_egpneighloss"></a><dl> <dt><b>SNMP_GENERICTRAP_EGPNEIGHLOSS</b></dt> </dl> </td> <td
///                  width="60%"> An EGP peer has changed to the down state. The first variable in the variable bindings list
///                  identifies the IP address of the EGP peer. </td> </tr> <tr> <td width="40%"><a
///                  id="SNMP_GENERICTRAP_ENTERSPECIFIC"></a><a id="snmp_generictrap_enterspecific"></a><dl>
///                  <dt><b>SNMP_GENERICTRAP_ENTERSPECIFIC</b></dt> </dl> </td> <td width="60%"> An extraordinary event has occurred.
///                  It is identified in the <i>specificTrap</i> parameter with an enterprise-specific value. </td> </tr> </table>
///    specificTrap = Pointer to a variable to receive an indicator of the specific trap generated.
///    community = Pointer to an AsnOctetString structure to receive the community string of the generated SNMP trap.
///    timeStamp = Pointer to a variable to receive the time stamp.
///    variableBindings = Pointer to an SnmpVarBindList structure to receive the variable bindings list.
///Returns:
///    If the function returns a trap, the return value is nonzero. You should call the <b>SnmpMgrGetTrapEx</b> function
///    repeatedly until it returns zero. The function may also return the following error codes. <table> <tr> <th>Return
///    code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>SNMP_MGMTAPI_TRAP_ERRORS</b></dt> </dl>
///    </td> <td width="60%"> Indicates that errors were encountered; traps are not accessible. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>SNMP_MGMTAPI_NOTRAPS</b></dt> </dl> </td> <td width="60%"> Indicates that no traps are
///    available. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>SNMP_MEM_ALLOC_ERROR</b></dt> </dl> </td> <td
///    width="60%"> Indicates a memory allocation error. </td> </tr> </table>
///    
@DllImport("mgmtapi")
BOOL SnmpMgrGetTrapEx(AsnObjectIdentifier* enterprise, AsnOctetString* agentAddress, AsnOctetString* sourceAddress, 
                      int* genericTrap, int* specificTrap, AsnOctetString* community, uint* timeStamp, 
                      SnmpVarBindList* variableBindings);

///<p class="CCE_Message">[SNMP is available for use in the operating systems specified in the Requirements section. It
///may be altered or unavailable in subsequent versions. Instead, use Windows Remote Management, which is the Microsoft
///implementation of WS-Man.] The WinSNMP <b>SnmpGetTranslateMode</b> function returns the current setting of the entity
///and context translation mode to a WinSNMP application. The entity and context translation mode affects the
///interpretation and return of WinSNMP input and output string parameters.
///Params:
///    nTranslateMode = Pointer to an unsigned long integer variable to receive the entity and context translation mode in effect for the
///                     Microsoft WinSNMP implementation. This parameter can be one of the following values. <table> <tr> <th>Value</th>
///                     <th>Meaning</th> </tr> <tr> <td width="40%"><a id="SNMPAPI_TRANSLATED"></a><a id="snmpapi_translated"></a><dl>
///                     <dt><b>SNMPAPI_TRANSLATED</b></dt> </dl> </td> <td width="60%"> The implementation uses its database to translate
///                     user-friendly names for SNMP entities and managed objects. The implementation translates them into their SNMPv1
///                     or SNMPv2C components. </td> </tr> <tr> <td width="40%"><a id="SNMPAPI_UNTRANSLATED_V1"></a><a
///                     id="snmpapi_untranslated_v1"></a><dl> <dt><b>SNMPAPI_UNTRANSLATED_V1</b></dt> </dl> </td> <td width="60%"> The
///                     implementation interprets SNMP entity parameters as SNMP transport addresses, and context parameters as SNMP
///                     community strings. For SNMPv2 destination entities, the implementation creates outgoing SNMP messages that
///                     contain a value of zero in the version field. </td> </tr> <tr> <td width="40%"><a
///                     id="SNMPAPI_UNTRANSLATED_V2"></a><a id="snmpapi_untranslated_v2"></a><dl> <dt><b>SNMPAPI_UNTRANSLATED_V2</b></dt>
///                     </dl> </td> <td width="60%"> The implementation interprets SNMP entity parameters as SNMP transport addresses,
///                     and context parameters as SNMP community strings. For SNMPv2 destination entities, the implementation creates
///                     outgoing SNMP messages that contain a value of 1 in the version field. </td> </tr> </table>
///Returns:
///    If the function succeeds, the return value is SNMPAPI_SUCCESS. If the function fails, the return value is
///    SNMPAPI_FAILURE. If <b>SnmpGetTranslateMode</b> fails, the value of the <i>nTranslateMode</i> parameter has no
///    meaning for the application. To get extended error information, call SnmpGetLastError specifying a <b>NULL</b>
///    value in its <i>session</i> parameter. The <b>SnmpGetLastError</b> function can return one of the following
///    errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>SNMPAPI_NOT_INITIALIZED</b></dt> </dl> </td> <td width="60%"> The SnmpStartup function did not complete
///    successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>SNMPAPI_ALLOC_ERROR</b></dt> </dl> </td> <td
///    width="60%"> An error occurred during memory allocation. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>SNMPAPI_OTHER_ERROR</b></dt> </dl> </td> <td width="60%"> An unknown or undefined error occurred. </td>
///    </tr> </table>
///    
@DllImport("wsnmp32")
uint SnmpGetTranslateMode(uint* nTranslateMode);

///<p class="CCE_Message">[SNMP is available for use in the operating systems specified in the Requirements section. It
///may be altered or unavailable in subsequent versions. Instead, use Windows Remote Management, which is the Microsoft
///implementation of WS-Man.] The WinSNMP <b>SnmpSetTranslateMode</b> function enables a WinSNMP application to change
///the entity and context translation mode. The entity and context translation mode affects the interpretation and
///return of WinSNMP input and output string parameters.
///Params:
///    nTranslateMode = Specifies a value for the new entity and context translation mode. This parameter must be one of the following
///                     values. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="SNMPAPI_TRANSLATED"></a><a
///                     id="snmpapi_translated"></a><dl> <dt><b>SNMPAPI_TRANSLATED</b></dt> </dl> </td> <td width="60%"> The Microsoft
///                     WinSNMP implementation uses its database to translate user-friendly names for SNMP entities and managed objects.
///                     The implementation translates them into their SNMPv1 or SNMPv2C components. </td> </tr> <tr> <td width="40%"><a
///                     id="SNMPAPI_UNTRANSLATED_V1"></a><a id="snmpapi_untranslated_v1"></a><dl> <dt><b>SNMPAPI_UNTRANSLATED_V1</b></dt>
///                     </dl> </td> <td width="60%"> The implementation interprets SNMP entity parameters as SNMP transport addresses,
///                     and context parameters as SNMP community strings. For SNMPv2 destination entities, the implementation creates
///                     outgoing SNMP messages that contain a value of zero in the version field. </td> </tr> <tr> <td width="40%"><a
///                     id="SNMPAPI_UNTRANSLATED_V2"></a><a id="snmpapi_untranslated_v2"></a><dl> <dt><b>SNMPAPI_UNTRANSLATED_V2</b></dt>
///                     </dl> </td> <td width="60%"> The implementation interprets SNMP entity parameters as SNMP transport addresses,
///                     and context parameters as SNMP community strings. For SNMPv2 destination entities, the implementation creates
///                     outgoing SNMP messages that contain a value of 1 in the version field. </td> </tr> </table>
///Returns:
///    If the function succeeds, the return value is SNMPAPI_SUCCESS. If the function fails, the return value is
///    SNMPAPI_FAILURE. To get extended error information, call SnmpGetLastError specifying a <b>NULL</b> value in its
///    <i>session</i> parameter. The <b>SnmpGetLastError</b> function can return one of the following errors. <table>
///    <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>SNMPAPI_NOT_INITIALIZED</b></dt> </dl> </td> <td width="60%"> The SnmpStartup function did not complete
///    successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>SNMPAPI_ALLOC_ERROR</b></dt> </dl> </td> <td
///    width="60%"> An error occurred during memory allocation. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>SNMPAPI_MODE_INVALID</b></dt> </dl> </td> <td width="60%"> The implementation does not support the
///    requested translation mode. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>SNMPAPI_OTHER_ERROR</b></dt> </dl>
///    </td> <td width="60%"> An unknown or undefined error occurred. </td> </tr> </table>
///    
@DllImport("wsnmp32")
uint SnmpSetTranslateMode(uint nTranslateMode);

///<p class="CCE_Message">[SNMP is available for use in the operating systems specified in the Requirements section. It
///may be altered or unavailable in subsequent versions. Instead, use Windows Remote Management, which is the Microsoft
///implementation of WS-Man.] The WinSNMP <b>SnmpGetRetransmitMode</b> function returns the current setting of the
///retransmission mode to a WinSNMP application. The Microsoft WinSNMP implementation uses the retransmission mode to
///govern transmission time-outs and retransmission attempts on calls to the SnmpSendMsg function.
///Params:
///    nRetransmitMode = Pointer to an unsigned long integer variable to receive the current retransmission mode in effect for the
///                      implementation. This parameter can be one of the following values. <table> <tr> <th>Value</th> <th>Meaning</th>
///                      </tr> <tr> <td width="40%"><a id="SNMPAPI_ON"></a><a id="snmpapi_on"></a><dl> <dt><b>SNMPAPI_ON</b></dt> </dl>
///                      </td> <td width="60%"> The implementation is executing the WinSNMP application's retransmission policy. </td>
///                      </tr> <tr> <td width="40%"><a id="SNMPAPI_OFF"></a><a id="snmpapi_off"></a><dl> <dt><b>SNMPAPI_OFF</b></dt> </dl>
///                      </td> <td width="60%"> The implementation is not executing the WinSNMP application's retransmission policy. </td>
///                      </tr> </table>
///Returns:
///    If the function succeeds, the return value is SNMPAPI_SUCCESS. If the function fails, the return value is
///    SNMPAPI_FAILURE. If <b>SnmpGetRetransmitMode</b> fails, the value of the <i>nRetransmitMode</i> parameter has no
///    meaning for the application. To get extended error information, call SnmpGetLastError specifying a <b>NULL</b>
///    value in its <i>session</i> parameter. The <b>SnmpGetLastError</b> function can return one of the following
///    errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>SNMPAPI_NOT_INITIALIZED</b></dt> </dl> </td> <td width="60%"> The SnmpStartup function did not complete
///    successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>SNMPAPI_ALLOC_ERROR</b></dt> </dl> </td> <td
///    width="60%"> An error occurred during memory allocation. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>SNMPAPI_OTHER_ERROR</b></dt> </dl> </td> <td width="60%"> An unknown or undefined error occurred. </td>
///    </tr> </table>
///    
@DllImport("wsnmp32")
uint SnmpGetRetransmitMode(uint* nRetransmitMode);

///<p class="CCE_Message">[SNMP is available for use in the operating systems specified in the Requirements section. It
///may be altered or unavailable in subsequent versions. Instead, use Windows Remote Management, which is the Microsoft
///implementation of WS-Man.] The WinSNMP <b>SnmpSetRetransmitMode</b> function enables a WinSNMP application to set the
///retransmission mode. The Microsoft WinSNMP implementation uses the new retransmission mode to govern transmission
///time-outs and retransmission attempts on subsequent calls to the SnmpSendMsg function.
///Params:
///    nRetransmitMode = Specifies a value for the new retransmission mode. This parameter must be one of the following values. <table>
///                      <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="SNMPAPI_ON"></a><a
///                      id="snmpapi_on"></a><dl> <dt><b>SNMPAPI_ON</b></dt> </dl> </td> <td width="60%"> The implementation executes the
///                      WinSNMP application's retransmission policy. </td> </tr> <tr> <td width="40%"><a id="SNMPAPI_OFF"></a><a
///                      id="snmpapi_off"></a><dl> <dt><b>SNMPAPI_OFF</b></dt> </dl> </td> <td width="60%"> The implementation does not
///                      execute the WinSNMP application's retransmission policy. </td> </tr> </table>
///Returns:
///    If the function succeeds, the return value is SNMPAPI_SUCCESS. If the function fails, the return value is
///    SNMPAPI_FAILURE. To get extended error information, call SnmpGetLastError specifying a <b>NULL</b> value in its
///    <i>session</i> parameter. The <b>SnmpGetLastError</b> function can return one of the following errors. <table>
///    <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>SNMPAPI_NOT_INITIALIZED</b></dt> </dl> </td> <td width="60%"> The SnmpStartup function did not complete
///    successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>SNMPAPI_ALLOC_ERROR</b></dt> </dl> </td> <td
///    width="60%"> An error occurred during memory allocation. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>SNMPAPI_MODE_INVALID</b></dt> </dl> </td> <td width="60%"> The implementation does not support the
///    requested retransmission mode. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>SNMPAPI_OTHER_ERROR</b></dt> </dl>
///    </td> <td width="60%"> An unknown or undefined error occurred. </td> </tr> </table>
///    
@DllImport("wsnmp32")
uint SnmpSetRetransmitMode(uint nRetransmitMode);

///<p class="CCE_Message">[SNMP is available for use in the operating systems specified in the Requirements section. It
///may be altered or unavailable in subsequent versions. Instead, use Windows Remote Management, which is the Microsoft
///implementation of WS-Man.] The WinSNMP <b>SnmpGetTimeout</b> function returns the time-out value, in hundredths of a
///second, for the transmission of SNMP message requests. The time-out value applies to calls that a WinSNMP application
///makes to the SnmpSendMsg function for a specified management entity.
///Params:
///    hEntity = Handle to the destination management entity of interest.
///    nPolicyTimeout = Pointer to an integer variable to receive the time-out value, in hundredths of a second, for the specified
///                     management entity. This is a value that the Microsoft WinSNMP implementation stores in a database. If you do not
///                     need the information returned in this parameter, <i>nPolicyRetry</i> must be a <b>NULL</b> pointer.
///    nActualTimeout = Pointer to an integer variable to receive the last actual or estimated response interval for the destination
///                     entity, as reported by the implementation. If you do not need the information returned in this parameter,
///                     <i>nActualRetry</i> must be a <b>NULL</b> pointer. If this parameter is a valid pointer, the function returns 0.
///                     For additional information, see the following Remarks section.
///Returns:
///    If the function succeeds, the return value is SNMPAPI_SUCCESS. If the function fails, the return value is
///    SNMPAPI_FAILURE. To get extended error information, call SnmpGetLastError specifying a <b>NULL</b> value in its
///    <i>session</i> parameter. The <b>SnmpGetLastError</b> function can return one of the following errors. <table>
///    <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>SNMPAPI_NOT_INITIALIZED</b></dt> </dl> </td> <td width="60%"> The SnmpStartup function did not complete
///    successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>SNMPAPI_ALLOC_ERROR</b></dt> </dl> </td> <td
///    width="60%"> An error occurred during memory allocation. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>SNMPAPI_ENTITY_INVALID</b></dt> </dl> </td> <td width="60%"> The <i>hEntity</i> parameter is invalid.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>SNMPAPI_NOOP</b></dt> </dl> </td> <td width="60%"> The
///    <i>nPolicyRetry</i> and <i>nActualRetry</i> parameters are both <b>NULL</b>. The operation was not performed.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>SNMPAPI_OTHER_ERROR</b></dt> </dl> </td> <td width="60%"> An
///    unknown or undefined error occurred. </td> </tr> </table>
///    
@DllImport("wsnmp32")
uint SnmpGetTimeout(ptrdiff_t hEntity, uint* nPolicyTimeout, uint* nActualTimeout);

///<p class="CCE_Message">[SNMP is available for use in the operating systems specified in the Requirements section. It
///may be altered or unavailable in subsequent versions. Instead, use Windows Remote Management, which is the Microsoft
///implementation of WS-Man.] The WinSNMP <b>SnmpSetTimeout</b> function enables a WinSNMP application to change the
///time-out value for the transmission of SNMP message requests. The time-out value applies to calls that a WinSNMP
///application makes to the SnmpSendMsg function for a specified management entity. The Microsoft WinSNMP implementation
///stores the value in a database.
///Params:
///    hEntity = Handle to the destination management entity of interest.
///    nPolicyTimeout = Specifies a new time-out value, in hundredths of a second, for the management entity. This value replaces the
///                     value currently stored in the implementation's database. If this parameter is equal to zero, and the current
///                     retransmission mode is equal to SNMPAPI_ON, the implementation selects a time-out value. The implementation uses
///                     this time-out value when it executes the WinSNMP application's retransmission policy.
///Returns:
///    If the function succeeds, the return value is SNMPAPI_SUCCESS. If the function fails, the return value is
///    SNMPAPI_FAILURE. To get extended error information, call SnmpGetLastError specifying a <b>NULL</b> value in its
///    <i>session</i> parameter. The <b>SnmpGetLastError</b> function can return one of the following errors. <table>
///    <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>SNMPAPI_NOT_INITIALIZED</b></dt> </dl> </td> <td width="60%"> The SnmpStartup function did not complete
///    successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>SNMPAPI_ALLOC_ERROR</b></dt> </dl> </td> <td
///    width="60%"> An error occurred during memory allocation. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>SNMPAPI_ENTITY_INVALID</b></dt> </dl> </td> <td width="60%"> The <i>hEntity</i> parameter is invalid.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>SNMPAPI_OTHER_ERROR</b></dt> </dl> </td> <td width="60%"> An
///    unknown or undefined error occurred. </td> </tr> </table>
///    
@DllImport("wsnmp32")
uint SnmpSetTimeout(ptrdiff_t hEntity, uint nPolicyTimeout);

///<p class="CCE_Message">[SNMP is available for use in the operating systems specified in the Requirements section. It
///may be altered or unavailable in subsequent versions. Instead, use Windows Remote Management, which is the Microsoft
///implementation of WS-Man.] The WinSNMP <b>SnmpGetRetry</b> function returns the retry count value, in units, for the
///retransmission of SNMP message requests. The retry count applies to calls that a WinSNMP application makes to the
///SnmpSendMsg function for a specified management entity.
///Params:
///    hEntity = Handle to the destination management entity of interest.
///    nPolicyRetry = Pointer to an unsigned long integer variable to receive the retry count value for the specified management
///                   entity. This is a value that the Microsoft WinSNMP implementation stores in a database. If you do not need the
///                   information returned in this parameter, <i>nPolicyRetry</i> must be a <b>NULL</b> pointer.
///    nActualRetry = Pointer to an unsigned long integer variable to receive the last actual or estimated retry count for the
///                   destination entity, as reported by the implementation. If you do not need the information returned in this
///                   parameter, <i>nActualRetry</i> must be a <b>NULL</b> pointer. If this parameter is a valid pointer, the function
///                   returns 0. For additional information, see the following Remarks section.
///Returns:
///    If the function succeeds, the return value is SNMPAPI_SUCCESS. If the function fails, the return value is
///    SNMPAPI_FAILURE. To get extended error information, call SnmpGetLastError specifying a <b>NULL</b> value in its
///    <i>session</i> parameter. The <b>SnmpGetLastError</b> function can return one of the following errors. <table>
///    <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>SNMPAPI_NOT_INITIALIZED</b></dt> </dl> </td> <td width="60%"> The SnmpStartup function did not complete
///    successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>SNMPAPI_ALLOC_ERROR</b></dt> </dl> </td> <td
///    width="60%"> An error occurred during memory allocation. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>SNMPAPI_ENTITY_INVALID</b></dt> </dl> </td> <td width="60%"> The <i>hEntity</i> parameter is invalid.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>SNMPAPI_NOOP</b></dt> </dl> </td> <td width="60%"> The
///    <i>nPolicyRetry</i> and <i>nActualRetry</i> parameters are both <b>NULL</b>. The operation was not performed.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>SNMPAPI_OTHER_ERROR</b></dt> </dl> </td> <td width="60%"> An
///    unknown or undefined error occurred. </td> </tr> </table>
///    
@DllImport("wsnmp32")
uint SnmpGetRetry(ptrdiff_t hEntity, uint* nPolicyRetry, uint* nActualRetry);

///<p class="CCE_Message">[SNMP is available for use in the operating systems specified in the Requirements section. It
///may be altered or unavailable in subsequent versions. Instead, use Windows Remote Management, which is the Microsoft
///implementation of WS-Man.] The WinSNMP <b>SnmpSetRetry</b> function enables a WinSNMP application to change the retry
///count value for the retransmission of SNMP message requests. The retry count applies to calls that a WinSNMP
///application makes to the SnmpSendMsg function for a specified management entity. The Microsoft WinSNMP implementation
///stores the value in a database.
///Params:
///    hEntity = Handle to the destination management entity of interest.
///    nPolicyRetry = Specifies a new value for the retry count for the management entity. This value replaces the value currently
///                   stored in the implementation's database. If this parameter is equal to zero, and the current retransmission mode
///                   is equal to SNMPAPI_ON, the implementation selects a value for the retry count. The implementation uses this
///                   value when it executes the WinSNMP application's retransmission policy.
///Returns:
///    If the function succeeds, the return value is SNMPAPI_SUCCESS. If the function fails, the return value is
///    SNMPAPI_FAILURE. To get extended error information, call SnmpGetLastError specifying a <b>NULL</b> value in its
///    <i>session</i> parameter. The <b>SnmpGetLastError</b> function can return one of the following errors. <table>
///    <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>SNMPAPI_NOT_INITIALIZED</b></dt> </dl> </td> <td width="60%"> The SnmpStartup function did not complete
///    successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>SNMPAPI_ALLOC_ERROR</b></dt> </dl> </td> <td
///    width="60%"> An error occurred during memory allocation. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>SNMPAPI_ENTITY_INVALID</b></dt> </dl> </td> <td width="60%"> The <i>hEntity</i> parameter is invalid.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>SNMPAPI_OTHER_ERROR</b></dt> </dl> </td> <td width="60%"> An
///    unknown or undefined error occurred. </td> </tr> </table>
///    
@DllImport("wsnmp32")
uint SnmpSetRetry(ptrdiff_t hEntity, uint nPolicyRetry);

///<p class="CCE_Message">[SNMP is available for use in the operating systems specified in the Requirements section. It
///may be altered or unavailable in subsequent versions. Instead, use Windows Remote Management, which is the Microsoft
///implementation of WS-Man.] A WinSNMP application calls the <b>SnmpGetVendorInfo</b> function to retrieve information
///about the Microsoft WinSNMP implementation. The function returns the information in an smiVENDORINFO structure. The
///<b>SnmpGetVendorInfo</b> function is an element of the WinSNMP API, version 2.0.
///Params:
///    vendorInfo = Pointer to an smiVENDORINFO structure to receive information. The information includes a way to contact Microsoft
///                 and the enterprise number assigned to Microsoft by the Internet Assigned Numbers Authority (IANA).
///Returns:
///    If the function succeeds, the return value is SNMPAPI_SUCCESS. If the function fails, the return value is
///    SNMPAPI_FAILURE. To get extended error information, call SnmpGetLastError specifying a <b>NULL</b> value in its
///    <i>session</i> parameter. The <b>SnmpGetLastError</b> function can return one of the following errors. <table>
///    <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>SNMPAPI_NOT_INITIALIZED</b></dt> </dl> </td> <td width="60%"> The SnmpStartup function did not complete
///    successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>SNMPAPI_ALLOC_ERROR</b></dt> </dl> </td> <td
///    width="60%"> An error occurred during memory allocation. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>SNMPAPI_NOOP</b></dt> </dl> </td> <td width="60%"> The <i>vendorInfo</i> parameter is <b>NULL</b>. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>SNMPAPI_OTHER_ERROR</b></dt> </dl> </td> <td width="60%"> An unknown or
///    undefined error occurred. </td> </tr> </table>
///    
@DllImport("wsnmp32")
uint SnmpGetVendorInfo(smiVENDORINFO* vendorInfo);

///<p class="CCE_Message">[SNMP is available for use in the operating systems specified in the Requirements section. It
///may be altered or unavailable in subsequent versions. Instead, use Windows Remote Management, which is the Microsoft
///implementation of WS-Man.] The <b>SnmpStartup</b> function notifies the Microsoft WinSNMP implementation that the
///WinSNMP application requires the implementation's services. The WinSNMP <b>SnmpStartup</b> function enables the
///implementation to initialize and to return to the application the version of the Windows SNMP Application Programming
///Interface (WinSNMP API), the level of SNMP communications that the implementation supports, and the implementation's
///default translation and retransmission modes. <div class="alert"><b>Note</b> A WinSNMP application must call the
///<b>SnmpStartup</b> function successfully before it calls any other WinSNMP function.</div><div> </div>
///Params:
///    nMajorVersion = Pointer to an unsigned long integer variable to receive the major version number of the WinSNMP API that the
///                    implementation supports. For example, to indicate that the implementation supports WinSNMP version 2.0, the
///                    function returns a value of 2.
///    nMinorVersion = Pointer to an unsigned long integer variable to receive the minor version number of the WinSNMP API that the
///                    implementation supports. For example, to indicate that the implementation supports WinSNMP version 2.0, the
///                    function returns a value of 0.
///    nLevel = Pointer to an unsigned long integer variable to receive the highest level of SNMP communications the
///             implementation supports. Upon successful return, this parameter contains a value of 2. For a description of level
///             2 support, see Levels of SNMP Support.
///    nTranslateMode = Pointer to an unsigned long integer variable to receive the default translation mode in effect for the
///                     implementation. The translation mode applies to the implementation's interpretation of the <i>entity</i>
///                     parameter that the WinSNMP application passes to the SnmpStrToEntity function. The translation mode also applies
///                     to the <i>string</i> parameter that the WinSNMP application passes to the SnmpStrToContext function. This
///                     parameter can be one of the following values. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td
///                     width="40%"><a id="SNMPAPI_TRANSLATED"></a><a id="snmpapi_translated"></a><dl> <dt><b>SNMPAPI_TRANSLATED</b></dt>
///                     </dl> </td> <td width="60%"> The implementation uses its database to translate user-friendly names for SNMP
///                     entities and managed objects. The implementation translates them into their SNMPv1 or SNMPv2C components. </td>
///                     </tr> <tr> <td width="40%"><a id="SNMPAPI_UNTRANSLATED_V1"></a><a id="snmpapi_untranslated_v1"></a><dl>
///                     <dt><b>SNMPAPI_UNTRANSLATED_V1</b></dt> </dl> </td> <td width="60%"> The implementation interprets SNMP entity
///                     parameters as SNMP transport addresses, and context parameters as SNMP community strings. For SNMPv2 destination
///                     entities, the implementation creates outgoing SNMP messages that contain a value of zero in the version field.
///                     </td> </tr> <tr> <td width="40%"><a id="SNMPAPI_UNTRANSLATED_V2"></a><a id="snmpapi_untranslated_v2"></a><dl>
///                     <dt><b>SNMPAPI_UNTRANSLATED_V2</b></dt> </dl> </td> <td width="60%"> The implementation interprets SNMP entity
///                     parameters as SNMP transport addresses, and context parameters as SNMP community strings. For SNMPv2 destination
///                     entities, the implementation creates outgoing SNMP messages that contain a value of 1 in the version field. </td>
///                     </tr> </table> For additional information, see Setting the Entity and Context Translation Mode.
///    nRetransmitMode = Pointer to an unsigned long integer variable to receive the default retransmission mode in effect for the
///                      implementation. This parameter can be one of the following values. <table> <tr> <th>Value</th> <th>Meaning</th>
///                      </tr> <tr> <td width="40%"><a id="SNMPAPI_OFF"></a><a id="snmpapi_off"></a><dl> <dt><b>SNMPAPI_OFF</b></dt> </dl>
///                      </td> <td width="60%"> The implementation is not executing the retransmission policy of the WinSNMP application.
///                      </td> </tr> <tr> <td width="40%"><a id="SNMPAPI_ON"></a><a id="snmpapi_on"></a><dl> <dt><b>SNMPAPI_ON</b></dt>
///                      </dl> </td> <td width="60%"> The implementation is executing the retransmission policy of the WinSNMP
///                      application. </td> </tr> </table> For additional information, see About Retransmission.
///Returns:
///    If the function succeeds, the return value is SNMPAPI_SUCCESS, and the parameters contain appropriate values, as
///    indicated in the preceding parameter descriptions. If the function fails, the return value is SNMPAPI_FAILURE. To
///    get extended error information, call SnmpGetLastError specifying a <b>NULL</b> value in its <i>session</i>
///    parameter. The <b>SnmpGetLastError</b> function can return one of the following errors. For additional
///    information, see the Remarks section that follows. <table> <tr> <th>Return code</th> <th>Description</th> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>SNMPAPI_NOT_INITIALIZED</b></dt> </dl> </td> <td width="60%"> The
///    <b>SnmpStartup</b> function did not complete successfully. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>SNMPAPI_ALLOC_ERROR</b></dt> </dl> </td> <td width="60%"> An error occurred during memory allocation.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>SNMPAPI_OTHER_ERROR</b></dt> </dl> </td> <td width="60%"> An
///    unknown or undefined error occurred. </td> </tr> </table>
///    
@DllImport("wsnmp32")
uint SnmpStartup(uint* nMajorVersion, uint* nMinorVersion, uint* nLevel, uint* nTranslateMode, 
                 uint* nRetransmitMode);

///<p class="CCE_Message">[SNMP is available for use in the operating systems specified in the Requirements section. It
///may be altered or unavailable in subsequent versions. Instead, use Windows Remote Management, which is the Microsoft
///implementation of WS-Man.] The <b>SnmpCleanup</b> function informs the Microsoft WinSNMP implementation that the
///calling WinSNMP application no longer requires the implementation's services. <div class="alert"><b>Note</b> A
///WinSNMP application must call the <b>SnmpCleanup</b> function as the last WinSNMP function before it
///terminates.</div><div> </div>
///Returns:
///    If the function succeeds, the return value is SNMPAPI_SUCCESS. Until the WinSNMP application successfully recalls
///    the SnmpStartup function, any other call to a WinSNMP function returns SNMPAPI_FAILURE, with an extended error
///    code of SNMPAPI_NOT_INITIALIZED. If the function fails, the return value is SNMPAPI_FAILURE, but the WinSNMP
///    application does not need to retry the call to <b>SnmpCleanup</b>. To get extended error information, call
///    SnmpGetLastError specifying a <b>NULL</b> value in its<i> session</i> parameter. The <b>SnmpGetLastError</b>
///    function can return one of the following errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>SNMPAPI_NOT_INITIALIZED</b></dt> </dl> </td> <td width="60%"> The SnmpStartup
///    function did not complete successfully. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>SNMPAPI_ALLOC_ERROR</b></dt> </dl> </td> <td width="60%"> An error occurred during memory allocation.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>SNMPAPI_OTHER_ERROR</b></dt> </dl> </td> <td width="60%"> An
///    unknown or undefined error occurred. </td> </tr> </table>
///    
@DllImport("wsnmp32")
uint SnmpCleanup();

///<p class="CCE_Message">[SNMP is available for use in the operating systems specified in the Requirements section. It
///may be altered or unavailable in subsequent versions. Instead, use Windows Remote Management, which is the Microsoft
///implementation of WS-Man.] The <b>SnmpOpen</b> function requests the Microsoft WinSNMP implementation to open a
///session for the WinSNMP application. This WinSNMP function enables the implementation to allocate and initialize
///memory, resources, data structures, and communications mechanisms. The <b>SnmpOpen</b> function returns a handle to
///the new WinSNMP session. <div class="alert"><b>Note</b> When developing new WinSNMP applications, it is recommended
///that you call the SnmpCreateSession function to open a WinSNMP session instead of calling the <b>SnmpOpen</b>
///function.</div><div> </div>
///Params:
///    hWnd = Handle to a window of the WinSNMP application to notify when an asynchronous request completes, or when trap
///           notification occurs.
///    wMsg = Specifies an unsigned integer that identifies the notification message to send to the WinSNMP application window.
///Returns:
///    If the function succeeds, the return value is a handle that identifies the WinSNMP session that the
///    implementation opens for the calling application. If the function fails, the return value is SNMPAPI_FAILURE. To
///    get extended error information, call SnmpGetLastError specifying a <b>NULL</b> value in its <i>session</i>
///    parameter. The <b>SnmpGetLastError</b> function can return one of the following errors. <table> <tr> <th>Return
///    code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>SNMPAPI_NOT_INITIALIZED</b></dt> </dl>
///    </td> <td width="60%"> The SnmpStartup function did not complete successfully. </td> </tr> <tr> <td width="40%">
///    <dl> <dt><b>SNMPAPI_ALLOC_ERROR</b></dt> </dl> </td> <td width="60%"> An error occurred during memory allocation.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>SNMPAPI_HWND_INVALID</b></dt> </dl> </td> <td width="60%"> The
///    <i>hWnd</i> parameter is not a valid window handle. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>SNMPAPI_OTHER_ERROR</b></dt> </dl> </td> <td width="60%"> An unknown or undefined error occurred. </td>
///    </tr> </table>
///    
@DllImport("wsnmp32")
ptrdiff_t SnmpOpen(HWND hWnd, uint wMsg);

///<p class="CCE_Message">[SNMP is available for use in the operating systems specified in the Requirements section. It
///may be altered or unavailable in subsequent versions. Instead, use Windows Remote Management, which is the Microsoft
///implementation of WS-Man.] The <b>SnmpClose</b> function enables the Microsoft WinSNMP implementation to deallocate
///memory, resources, and data structures associated with a WinSNMP session. The WinSNMP <b>SnmpClose</b> function also
///closes communications mechanisms the implementation opened as a result of a call to the SnmpCreateSession function.
///Params:
///    session = Handle to the WinSNMP session to close.
///Returns:
///    If the function succeeds, the return value is SNMPAPI_SUCCESS. If the function fails, the return value is
///    SNMPAPI_FAILURE. To get extended error information, call SnmpGetLastError specifying a <b>NULL</b> value in its
///    <i>session</i> parameter. The <b>SnmpGetLastError</b> function can return one of the following errors. <table>
///    <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>SNMPAPI_NOT_INITIALIZED</b></dt> </dl> </td> <td width="60%"> The SnmpStartup function did not complete
///    successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>SNMPAPI_ALLOC_ERROR</b></dt> </dl> </td> <td
///    width="60%"> An error occurred during memory allocation. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>SNMPAPI_SESSION_INVALID</b></dt> </dl> </td> <td width="60%"> The <i>session</i> parameter is invalid.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>SNMPAPI_OTHER_ERROR</b></dt> </dl> </td> <td width="60%"> An
///    unknown or undefined error occurred. </td> </tr> </table>
///    
@DllImport("wsnmp32")
uint SnmpClose(ptrdiff_t session);

///<p class="CCE_Message">[SNMP is available for use in the operating systems specified in the Requirements section. It
///may be altered or unavailable in subsequent versions. Instead, use Windows Remote Management, which is the Microsoft
///implementation of WS-Man.] A WinSNMP application calls the <b>SnmpSendMsg</b> function to request that the Microsoft
///WinSNMP implementation transmit an SNMP protocol data unit (PDU), in the form of an SNMP message. The WinSNMP
///application specifies a source entity, a destination entity, and a context for the request. If a WinSNMP application
///expects a PDU in response to a <b>SnmpSendMsg</b> request, it must retrieve the PDU. To do this, the application must
///call the SnmpRecvMsg function using the session handle returned by SnmpCreateSession.
///Params:
///    session = Handle to the WinSNMP session.
///    srcEntity = Handle to the management entity that initiates the request to send the SNMP message.
///    dstEntity = Handle to the target entity that will respond to the SNMP request.
///    context = Handle to the context, (a set of managed object resources), that the target management entity controls.
///    PDU = Handle to the protocol data unit that contains the SNMP operation request.
///Returns:
///    If the function succeeds, the return value is SNMPAPI_SUCCESS. If the function fails, the return value is
///    SNMPAPI_FAILURE. To get extended error information, call SnmpGetLastError. The <b>SnmpGetLastError</b> function
///    may return one of the following WinSNMP or network transport layer errors. <table> <tr> <th>Return code</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>SNMPAPI_NOT_INITIALIZED</b></dt> </dl> </td> <td
///    width="60%"> The SnmpStartup function did not complete successfully. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>SNMPAPI_ALLOC_ERROR</b></dt> </dl> </td> <td width="60%"> An error occurred during memory allocation.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>SNMPAPI_SESSION_INVALID</b></dt> </dl> </td> <td width="60%"> The
///    <i>session</i> parameter is invalid. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>SNMPAPI_ENTITY_INVALID</b></dt> </dl> </td> <td width="60%"> One or both of the entity parameters is
///    invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>SNMPAPI_CONTEXT_INVALID</b></dt> </dl> </td> <td
///    width="60%"> The <i>context</i> parameter is invalid. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>SNMPAPI_PDU_INVALID</b></dt> </dl> </td> <td width="60%"> The <i>PDU</i> parameter is invalid. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>SNMPAPI_OPERATION_INVALID</b></dt> </dl> </td> <td width="60%"> The operation
///    specified in the <b>PDU_type</b> field of the PDU is inappropriate for the destination entity. For more
///    information, see the following Remarks section. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>SNMPAPI_TL_NOT_INITIALIZED</b></dt> </dl> </td> <td width="60%"> The network transport layer was not
///    initialized. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>SNMPAPI_TL_NOT_SUPPORTED</b></dt> </dl> </td> <td
///    width="60%"> The network transport layer does not support the SNMP protocol. </td> </tr> <tr> <td width="40%">
///    <dl> <dt><b>SNMPAPI_TL_NOT_AVAILABLE</b></dt> </dl> </td> <td width="60%"> The network subsystem failed. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>SNMPAPI_TL_RESOURCE_ERROR</b></dt> </dl> </td> <td width="60%"> A
///    resource error occurred in the network transport layer. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>SNMPAPI_TL_SRC_INVALID</b></dt> </dl> </td> <td width="60%"> The entity specified by the <i>srcEntity</i>
///    parameter was not initialized. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>SNMPAPI_TL_INVALID_PARAM</b></dt>
///    </dl> </td> <td width="60%"> A network transport layer function call received an invalid input parameter. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>SNMPAPI_TL_PDU_TOO_BIG</b></dt> </dl> </td> <td width="60%"> The PDU is
///    too large for the network transport layer to send or receive. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>SNMPAPI_TL_OTHER</b></dt> </dl> </td> <td width="60%"> An undefined network transport layer error
///    occurred. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>SNMPAPI_OTHER_ERROR</b></dt> </dl> </td> <td width="60%">
///    An unknown or undefined error occurred. </td> </tr> </table> For additional information, see Network Transport
///    Errors.
///    
@DllImport("wsnmp32")
uint SnmpSendMsg(ptrdiff_t session, ptrdiff_t srcEntity, ptrdiff_t dstEntity, ptrdiff_t context, ptrdiff_t PDU);

///<p class="CCE_Message">[SNMP is available for use in the operating systems specified in the Requirements section. It
///may be altered or unavailable in subsequent versions. Instead, use Windows Remote Management, which is the Microsoft
///implementation of WS-Man.] The WinSNMP <b>SnmpRecvMsg</b> function retrieves the results of a completed asynchronous
///request submitted by a call to the SnmpSendMsg function, in the form of an SNMP message. The <b>SnmpRecvMsg</b>
///function also returns outstanding trap data and notifications registered for a WinSNMP session.
///Params:
///    session = Handle to the WinSNMP session.
///    srcEntity = Pointer to a variable that receives a handle to the entity that sends the message. Note that the <i>srcEntity</i>
///                parameter to the SnmpRegister function specifies a handle to the management entity that registers for trap
///                notification.
///    dstEntity = Pointer to a variable that receives a handle to the entity that receives the message. Note that the
///                <i>dstEntity</i> parameter to the SnmpRegister function specifies a handle to the management entity that sends
///                traps.
///    context = Pointer to a variable that receives a handle to the context, which is a set of managed object resources. The
///              entity specified by the <i>srcEntity</i> parameter issues the message from this context.
///    PDU = Pointer to a variable that receives a handle to the protocol data unit (PDU) component of the message.
///Returns:
///    If the function succeeds, the return value is SNMPAPI_SUCCESS, and the output parameters contain the values
///    indicated in the preceding parameter descriptions. If the function fails, the return value is SNMPAPI_FAILURE. If
///    the function fails with an extended error code that indicates a network transport layer error, that is, one that
///    begins with SNMPAPI_TL_, the output parameters also contain the values indicated preceding to enable the WinSNMP
///    application to recover gracefully. To get extended error information, call SnmpGetLastError. The
///    <b>SnmpGetLastError</b> function may return one of the following WinSNMP or network transport layer errors.
///    <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>SNMPAPI_NOT_INITIALIZED</b></dt> </dl> </td> <td width="60%"> The SnmpStartup function did not complete
///    successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>SNMPAPI_ALLOC_ERROR</b></dt> </dl> </td> <td
///    width="60%"> An error occurred during memory allocation. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>SNMPAPI_SESSION_INVALID</b></dt> </dl> </td> <td width="60%"> The <i>session</i> parameter is invalid.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>SNMPAPI_NOOP</b></dt> </dl> </td> <td width="60%"> The specified
///    session has no messages in its queue at this time. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>SNMPAPI_TL_NOT_INITIALIZED</b></dt> </dl> </td> <td width="60%"> The network transport layer was not
///    initialized. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>SNMPAPI_TL_NOT_SUPPORTED</b></dt> </dl> </td> <td
///    width="60%"> The network transport layer does not support the SNMP protocol. </td> </tr> <tr> <td width="40%">
///    <dl> <dt><b>SNMPAPI_TL_NOT_AVAILABLE</b></dt> </dl> </td> <td width="60%"> The network subsystem failed. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>SNMPAPI_TL_RESOURCE_ERROR</b></dt> </dl> </td> <td width="60%"> A
///    resource error occurred in the network transport layer. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>SNMPAPI_TL_UNDELIVERABLE</b></dt> </dl> </td> <td width="60%"> The entity specified by the
///    <i>dstEntity</i> parameter is unavailable. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>SNMPAPI_TL_SRC_INVALID</b></dt> </dl> </td> <td width="60%"> The entity specified by the <i>srcEntity</i>
///    parameter was not initialized. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>SNMPAPI_TL_INVALID_PARAM</b></dt>
///    </dl> </td> <td width="60%"> A network transport layer function call received an invalid input parameter. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>SNMPAPI_TL_PDU_TOO_BIG</b></dt> </dl> </td> <td width="60%"> The PDU is
///    too large for the network transport layer to send or receive. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>SNMPAPI_TL_OTHER</b></dt> </dl> </td> <td width="60%"> An undefined network transport layer error
///    occurred. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>SNMPAPI_OTHER_ERROR</b></dt> </dl> </td> <td width="60%">
///    An unknown or undefined error occurred. </td> </tr> </table> For additional information, see Network Transport
///    Errors.
///    
@DllImport("wsnmp32")
uint SnmpRecvMsg(ptrdiff_t session, ptrdiff_t* srcEntity, ptrdiff_t* dstEntity, ptrdiff_t* context, ptrdiff_t* PDU);

///<p class="CCE_Message">[SNMP is available for use in the operating systems specified in the Requirements section. It
///may be altered or unavailable in subsequent versions. Instead, use Windows Remote Management, which is the Microsoft
///implementation of WS-Man.] The WinSNMP <b>SnmpRegister</b> function registers or unregisters a WinSNMP application
///for trap and notification reception. The application can register and receive traps and notifications, or unregister
///and disable traps and notifications. A WinSNMP application can register or unregister for one type of trap or
///notification, or for all traps and notifications, depending on the value of the <i>notification</i> parameter.
///Params:
///    session = Handle to the WinSNMP session that is registering or unregistering for traps and notifications.
///    srcEntity = Handle to the management entity that is the source of the registration request. This entity, acting in an SNMP
///                manager role, will receive the trap or notification. Because the implementation does not use this parameter to
///                filter traps and notifications from reaching the WinSNMP application, a WinSNMP manager application typically
///                passes <b>NULL</b> in this parameter. If this parameter is <b>NULL</b>, the Microsoft WinSNMP implementation
///                registers or unregisters all sources of trap and notification requests. Note that the <i>srcEntity</i> parameter
///                to the SnmpRecvMsg function has a different role. In that function, <i>srcEntity</i> receives a handle to the
///                entity that sent the trap.
///    dstEntity = Handle to the management entity that is the recipient of the registration request. This entity, acting in an SNMP
///                agent role, will send the trap or notification. If this parameter is <b>NULL</b>, the implementation registers or
///                unregisters the WinSNMP application for traps and notifications from all management entities. Note that the
///                <i>dstEntity</i> parameter to the SnmpRecvMsg function receives a handle to the management entity that registers
///                for trap notification.
///    context = Handle to the context, which is a set of managed object resources. If this parameter is <b>NULL</b>, the
///              implementation registers or unregisters the WinSNMP application for traps and notifications for every context.
///    notification = Pointer to an smiOID structure that contains the pattern-matching sequence for one type of trap or notification.
///                   The implementation uses this sequence to identify the type of trap or notification for which the WinSNMP
///                   application is registering or unregistering. For additional information, see the following Remarks section. If
///                   this parameter is <b>NULL</b>, the implementation registers or unregisters the WinSNMP application for all traps
///                   and notifications from the management entity or entities specified by the <i>dstEntity</i> parameter.
///    state = Specifies an unsigned long integer variable that indicates whether the WinSNMP application is registering to
///            receive traps and notifications, or if it is unregistering. This parameter should be equal to one of the
///            following values, but if it contains a different value, the implementation registers the application. <table>
///            <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="SNMPAPI_OFF"></a><a
///            id="snmpapi_off"></a><dl> <dt><b>SNMPAPI_OFF</b></dt> </dl> </td> <td width="60%"> Disable traps and
///            notifications. </td> </tr> <tr> <td width="40%"><a id="SNMPAPI_ON"></a><a id="snmpapi_on"></a><dl>
///            <dt><b>SNMPAPI_ON</b></dt> </dl> </td> <td width="60%"> Register to receive traps and notifications. </td> </tr>
///            </table>
///Returns:
///    If the function succeeds, the return value is SNMPAPI_SUCCESS. If the function fails, the return value is
///    SNMPAPI_FAILURE. To get extended error information, call SnmpGetLastError. The <b>SnmpGetLastError</b> function
///    may return one of the following WinSNMP or network transport layer errors. <table> <tr> <th>Return code</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>SNMPAPI_NOT_INITIALIZED</b></dt> </dl> </td> <td
///    width="60%"> The SnmpStartup function did not complete successfully. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>SNMPAPI_ALLOC_ERROR</b></dt> </dl> </td> <td width="60%"> An error occurred during memory allocation.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>SNMPAPI_SESSION_INVALID</b></dt> </dl> </td> <td width="60%"> The
///    <i>session</i> parameter is invalid. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>SNMPAPI_ENTITY_INVALID</b></dt> </dl> </td> <td width="60%"> One or both of the entity parameters is
///    invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>SNMPAPI_CONTEXT_INVALID</b></dt> </dl> </td> <td
///    width="60%"> The <i>context</i> parameter is invalid. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>SNMPAPI_OID_INVALID</b></dt> </dl> </td> <td width="60%"> The <i>notification</i> parameter is invalid.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>SNMPAPI_TL_NOT_INITIALIZED</b></dt> </dl> </td> <td width="60%">
///    The network transport layer was not initialized, or the SNMPTRAP.EXE service could not be started. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>SNMPAPI_TL_IN_USE</b></dt> </dl> </td> <td width="60%"> The trap port is not
///    available. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>SNMPAPI_TL_NOT_AVAILABLE</b></dt> </dl> </td> <td
///    width="60%"> The network subsystem failed. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>SNMPAPI_OTHER_ERROR</b></dt> </dl> </td> <td width="60%"> An unknown or undefined error occurred. </td>
///    </tr> </table> For additional information, see Network Transport Errors.
///    
@DllImport("wsnmp32")
uint SnmpRegister(ptrdiff_t session, ptrdiff_t srcEntity, ptrdiff_t dstEntity, ptrdiff_t context, 
                  smiOID* notification, uint state);

///<p class="CCE_Message">[SNMP is available for use in the operating systems specified in the Requirements section. It
///may be altered or unavailable in subsequent versions. Instead, use Windows Remote Management, which is the Microsoft
///implementation of WS-Man.] The <b>SnmpCreateSession</b> function requests the Microsoft WinSNMP implementation to
///open a session for the WinSNMP application. The application can specify how the implementation should inform the
///WinSNMP session of available SNMP messages and asynchronous events. The application can specify a window notification
///message or an SNMPAPI_CALLBACK function to notify the session. The <b>SnmpCreateSession</b> function is an element of
///the WinSNMP API, version 2.0. When developing new WinSNMP applications, it is recommended that you call
///<b>SnmpCreateSession</b> to open a WinSNMP session instead of calling the SnmpOpen function.
///Params:
///    hWnd = Handle to a window of the WinSNMP application to notify when an asynchronous request completes, or when trap
///           notification occurs. This parameter is required for window notification messages for the session.
///    wMsg = Specifies an unsigned integer that identifies the notification message to send to the WinSNMP application window.
///           This parameter is required for window notification messages for the session.
///    fCallBack = Specifies the address of an application-defined, session-specific SNMPAPI_CALLBACK function. The implementation
///                will call this function to inform the WinSNMP session when notifications are available. This parameter is
///                required to specify callback notifications for the session. This parameter must be <b>NULL</b> to specify window
///                notification messages for the session. For additional information, see the following Remarks section.
///    lpClientData = Pointer to application-defined data to pass to the callback function specified by the <i>fCallback</i> parameter.
///                   This parameter is optional and can be <b>NULL</b>. If the <i>fCallback</i> parameter is <b>NULL</b>, the
///                   implementation ignores this parameter.
///Returns:
///    If the function succeeds, the return value is a handle that identifies the WinSNMP session that the
///    implementation opens for the calling application. If the function fails, the return value is SNMPAPI_FAILURE. To
///    get extended error information, call SnmpGetLastError. The <b>SnmpGetLastError</b> function can return one of the
///    following errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>SNMPAPI_NOT_INITIALIZED</b></dt> </dl> </td> <td width="60%"> The SnmpStartup function did not complete
///    successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>SNMPAPI_ALLOC_ERROR</b></dt> </dl> </td> <td
///    width="60%"> An error occurred during memory allocation. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>SNMPAPI_HWND_INVALID</b></dt> </dl> </td> <td width="60%"> The <i>fCallback</i> parameter is <b>NULL</b>,
///    but the <i>hWnd</i> parameter is not a valid window handle. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>SNMPAPI_MESSAGE_INVALID</b></dt> </dl> </td> <td width="60%"> The <i>fCallback</i> parameter is
///    <b>NULL</b>, but the <i>wMsg</i> parameter is not a valid message value. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>SNMPAPI_MODE_INVALID</b></dt> </dl> </td> <td width="60%"> The <i>fCallback</i> parameter is <b>NULL</b>
///    and the <i>hWnd</i> and <i>wMsg</i> parameters are valid individually. However, the values are mutually
///    incompatible on the Windows platform. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>SNMPAPI_OPERATION_INVALID</b></dt> </dl> </td> <td width="60%"> The combination of parameter values does
///    not specify callback notifications or window notification messages. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>SNMPAPI_OTHER_ERROR</b></dt> </dl> </td> <td width="60%"> An unknown or undefined error occurred. </td>
///    </tr> </table>
///    
@DllImport("wsnmp32")
ptrdiff_t SnmpCreateSession(HWND hWnd, uint wMsg, SNMPAPI_CALLBACK fCallBack, void* lpClientData);

///<p class="CCE_Message">[SNMP is available for use in the operating systems specified in the Requirements section. It
///may be altered or unavailable in subsequent versions. Instead, use Windows Remote Management, which is the Microsoft
///implementation of WS-Man.] The WinSNMP <b>SnmpListen</b> function registers a WinSNMP application as an SNMP agent.
///An agent application calls this function to inform the Microsoft WinSNMP implementation that an entity will be acting
///in the role of an SNMP agent. An application also calls this function to inform the implementation when an entity
///will no longer be acting in this role. The <b>SnmpListen</b> function is an element of the WinSNMP API, version 2.0.
///Params:
///    hEntity = Handle to the WinSNMP entity to notify when the Microsoft WinSNMP implementation receives an incoming SNMP
///              request message (PDU). This parameter identifies the agent application. For more information, see the following
///              Remarks and Return Values sections. When you call the SnmpCreateSession function, you can specify whether the
///              implementation should use a window notification message or an SNMPAPI_CALLBACK function to notify the application
///              when an SNMP message or asynchronous event is available.
///    lStatus = Specifies an unsigned long integer variable that indicates whether the WinSNMP entity identified by the
///              <i>hEntity</i> parameter is acting in an SNMP agent role, or if it is no longer acting in this role. This
///              parameter can be one of the following values. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td
///              width="40%"><a id="SNMPAPI_ON"></a><a id="snmpapi_on"></a><dl> <dt><b>SNMPAPI_ON</b></dt> </dl> </td> <td
///              width="60%"> The specified WinSNMP entity is functioning in an agent role. </td> </tr> <tr> <td width="40%"><a
///              id="SNMPAPI_OFF"></a><a id="snmpapi_off"></a><dl> <dt><b>SNMPAPI_OFF</b></dt> </dl> </td> <td width="60%"> The
///              specified WinSNMP entity is not functioning in an agent role. </td> </tr> </table> Passing a value of SNMPAPI_OFF
///              releases both the resources allocated to the entity and the port assigned it. For more information, see the
///              following Remarks section.
///Returns:
///    If the function succeeds, the return value is SNMPAPI_SUCCESS. If the function fails, the return value is
///    SNMPAPI_FAILURE. To get extended error information, call SnmpGetLastError. The <b>SnmpGetLastError</b> function
///    can return one of the following errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>SNMPAPI_NOT_INITIALIZED</b></dt> </dl> </td> <td width="60%"> The SnmpStartup function
///    did not complete successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>SNMPAPI_ALLOC_ERROR</b></dt> </dl>
///    </td> <td width="60%"> An error occurred during memory allocation. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>SNMPAPI_ENTITY_INVALID</b></dt> </dl> </td> <td width="60%"> The <i>hEntity</i> parameter is invalid. This
///    parameter must be a handle returned by a previous call to the SnmpStrToEntity function. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>SNMPAPI_MODE_INVALID</b></dt> </dl> </td> <td width="60%"> The <i>lStatus</i> parameter
///    is invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>SNMPAPI_NOOP</b></dt> </dl> </td> <td width="60%"> The
///    entity specified by the <i>hEntity</i> parameter is already functioning in the role of an SNMP agent. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>SNMPAPI_TL_RESOURCE_ERROR</b></dt> </dl> </td> <td width="60%"> There is a
///    network transport layer error. A socket could not be created for the entity specified by the <i>hEntity</i>
///    parameter. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>SNMPAPI_TL_OTHER</b></dt> </dl> </td> <td width="60%">
///    An error occurred in the network transport layer while trying to bind a socket for the entity specified by the
///    <i>hEntity</i> parameter. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>SNMPAPI_OTHER_ERROR</b></dt> </dl> </td>
///    <td width="60%"> An unknown or undefined error occurred. </td> </tr> </table>
///    
@DllImport("wsnmp32")
uint SnmpListen(ptrdiff_t hEntity, uint lStatus);

@DllImport("wsnmp32")
uint SnmpListenEx(ptrdiff_t hEntity, uint lStatus, uint nUseEntityAddr);

///<p class="CCE_Message">[SNMP is available for use in the operating systems specified in the Requirements section. It
///may be altered or unavailable in subsequent versions. Instead, use Windows Remote Management, which is the Microsoft
///implementation of WS-Man.] A WinSNMP application calls the <b>SnmpCancelMsg</b> function to request that the
///Microsoft WinSNMP implementation cancel retransmission attempts and time-out notifications for an SNMP request
///message. The <b>SnmpCancelMsg</b> function is an element of the WinSNMP API, version 2.0.
///Params:
///    session = Handle to the WinSNMP session that submitted the SNMP request message (PDU) to be canceled.
///    reqId = Specifies a unique numeric value that identifies the PDU of interest. This parameter must match the request
///            identifier (<b>request_id</b>) of the <i>PDU</i> parameter specified in the application's initial call to the
///            SnmpSendMsg function.
///Returns:
///    If the function succeeds, the return value is SNMPAPI_SUCCESS. If the function fails, the return value is
///    SNMPAPI_FAILURE. To get extended error information, call SnmpGetLastError. The <b>SnmpGetLastError</b> function
///    can return one of the following errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>SNMPAPI_SESSION_INVALID</b></dt> </dl> </td> <td width="60%"> The <i>session</i>
///    parameter is invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>SNMPAPI_PDU_INVALID</b></dt> </dl> </td> <td
///    width="60%"> The <i>reqId</i> parameter does not identify an outstanding message for the specified session. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>SNMPAPI_NOT_INITIALIZED</b></dt> </dl> </td> <td width="60%"> The
///    SnmpStartup function did not complete successfully. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>SNMPAPI_ALLOC_ERROR</b></dt> </dl> </td> <td width="60%"> An error occurred during memory allocation.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>SNMPAPI_OTHER_ERROR</b></dt> </dl> </td> <td width="60%"> An
///    unknown or undefined error occurred. </td> </tr> </table>
///    
@DllImport("wsnmp32")
uint SnmpCancelMsg(ptrdiff_t session, int reqId);

///<p class="CCE_Message">[SNMP is available for use in the operating systems specified in the Requirements section. It
///may be altered or unavailable in subsequent versions. Instead, use Windows Remote Management, which is the Microsoft
///implementation of WS-Man.] The <b>SnmpStartupEx</b> function notifies the Microsoft WinSNMP implementation that the
///WinSNMP application requires the implementation's services. The WinSNMP <b>SnmpStartupEx</b> function enables the
///implementation to initialize and to return to the application the version of the Windows SNMP Application Programming
///Interface (WinSNMP API), the level of SNMP communications that the implementation supports, and the implementation's
///default translation and retransmission modes. This function should be used instead of SnmpStartup if Windows Server
///2003 with Service Pack 1 (SP1) or later is installed. <b>SnmpStartupEx</b> enables support for multiple independent
///software modules that use WinSNMP within the same application. <div class="alert"><b>Note</b> A WinSNMP application
///must call the <b>SnmpStartupEx</b> function successfully before it calls any other WinSNMP function.</div><div>
///</div>
///Params:
///    nMajorVersion = Pointer to an unsigned long integer variable to receive the major version number of the WinSNMP API that the
///                    implementation supports. For example, to indicate that the implementation supports WinSNMP version 2.0, the
///                    function returns a value of 2.
///    nMinorVersion = Pointer to an unsigned long integer variable to receive the minor version number of the WinSNMP API that the
///                    implementation supports. For example, to indicate that the implementation supports WinSNMP version 2.0, the
///                    function returns a value of 0.
///    nLevel = Pointer to an unsigned long integer variable to receive the highest level of SNMP communications the
///             implementation supports. Upon successful return, this parameter contains a value of 2. For a description of level
///             2 support, see Levels of SNMP Support.
///    nTranslateMode = Pointer to an unsigned long integer variable to receive the default translation mode in effect for the
///                     implementation. The translation mode applies to how the implementation interprets the <i>entity</i> parameter,
///                     that the WinSNMP application passes to the SnmpStrToEntity function. The translation mode also applies to the
///                     <i>string</i> parameter that the WinSNMP application passes to the SnmpStrToContext function. This parameter can
///                     be one of the following values. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
///                     id="SNMPAPI_TRANSLATED"></a><a id="snmpapi_translated"></a><dl> <dt><b>SNMPAPI_TRANSLATED</b></dt> </dl> </td>
///                     <td width="60%"> The implementation uses its database to translate user-friendly names for SNMP entities and
///                     managed objects. The implementation translates them into their SNMPv1 or SNMPv2C components. </td> </tr> <tr> <td
///                     width="40%"><a id="SNMPAPI_UNTRANSLATED_V1"></a><a id="snmpapi_untranslated_v1"></a><dl>
///                     <dt><b>SNMPAPI_UNTRANSLATED_V1</b></dt> </dl> </td> <td width="60%"> The implementation interprets SNMP entity
///                     parameters as SNMP transport addresses, and context parameters as SNMP community strings. For SNMPv2 destination
///                     entities, the implementation creates outgoing SNMP messages that contain a value of zero in the version field.
///                     </td> </tr> <tr> <td width="40%"><a id="SNMPAPI_UNTRANSLATED_V2"></a><a id="snmpapi_untranslated_v2"></a><dl>
///                     <dt><b>SNMPAPI_UNTRANSLATED_V2</b></dt> </dl> </td> <td width="60%"> The implementation interprets SNMP entity
///                     parameters as SNMP transport addresses, and context parameters as SNMP community strings. For SNMPv2 destination
///                     entities, the implementation creates outgoing SNMP messages that contain a value of 1 in the version field. </td>
///                     </tr> </table> For additional information, see Setting the Entity and Context Translation Mode.
///    nRetransmitMode = Pointer to an unsigned long integer variable to receive the default retransmission mode in effect for the
///                      implementation. This parameter can be one of the following values. <table> <tr> <th>Value</th> <th>Meaning</th>
///                      </tr> <tr> <td width="40%"><a id="SNMPAPI_OFF"></a><a id="snmpapi_off"></a><dl> <dt><b>SNMPAPI_OFF</b></dt> </dl>
///                      </td> <td width="60%"> The implementation is not executing the retransmission policy of the WinSNMP application.
///                      </td> </tr> <tr> <td width="40%"><a id="SNMPAPI_ON"></a><a id="snmpapi_on"></a><dl> <dt><b>SNMPAPI_ON</b></dt>
///                      </dl> </td> <td width="60%"> The implementation is executing the retransmission policy of the WinSNMP
///                      application. </td> </tr> </table> For additional information, see About Retransmission.
///Returns:
///    If the function succeeds, the return value is SNMPAPI_SUCCESS, and the parameters contain appropriate values, as
///    indicated in the preceding parameter descriptions. If the function fails, the return value is SNMPAPI_FAILURE. To
///    get extended error information, call SnmpGetLastError specifying a <b>NULL</b> value in its <i>session</i>
///    parameter. The <b>SnmpGetLastError</b> function can return one of the following errors. For additional
///    information, see the "Remarks" section later in this document. <table> <tr> <th>Return code</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>SNMPAPI_TL_RESOURCE_ERROR</b></dt> </dl> </td> <td
///    width="60%"> A resource allocation error occurred during startup. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>SNMPAPI_TL_NOT_INITIALIZED</b></dt> </dl> </td> <td width="60%"> The SnmpStartupEx function did not
///    initialize correctly. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>SNMPAPI_ALLOC_ERROR</b></dt> </dl> </td> <td
///    width="60%"> An error occurred during memory allocation. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>SNMPAPI_OTHER_ERROR</b></dt> </dl> </td> <td width="60%"> An unknown or undefined error occurred. </td>
///    </tr> </table>
///    
@DllImport("wsnmp32")
uint SnmpStartupEx(uint* nMajorVersion, uint* nMinorVersion, uint* nLevel, uint* nTranslateMode, 
                   uint* nRetransmitMode);

///<p class="CCE_Message">[SNMP is available for use in the operating systems specified in the Requirements section. It
///may be altered or unavailable in subsequent versions. Instead, use Windows Remote Management, which is the Microsoft
///implementation of WS-Man.] The <b>SnmpCleanupEx</b> function performs cleanup when there are no outstanding
///successful calls to SnmpStartup or SnmpStartupEx within a Windows SNMP (WinSNMP) application. Otherwise, an internal
///reference count indicating the current number of outstanding successful calls to <b>SnmpStartupEx</b> is decremented.
///This function should be used instead of SnmpCleanup if Windows Server 2003 with Service Pack 1 (SP1) or later is
///installed. <b>SnmpCleanupEx</b> enables support for multiple independent software modules that use WinSNMP within the
///same application. <div class="alert"><b>Note</b> A WinSNMP application must call the <b>SnmpCleanupEx</b> function
///for each successful call to SnmpStartupEx before the application terminates.</div><div> </div>
///Returns:
///    If the function succeeds, the return value is SNMPAPI_SUCCESS. Until the WinSNMP application successfully recalls
///    the corresponding SnmpStartupEx function and there are no additional outstanding successful calls to either
///    SnmpStartup or <b>SnmpStartupEx</b>, any other call to a WinSNMP function within the same application returns
///    SNMPAPI_FAILURE, with an extended error code of SNMPAPI_NOT_INITIALIZED. If the function fails, the return value
///    is SNMPAPI_FAILURE, but the WinSNMP application does not need to retry the call to <b>SnmpCleanupEx</b>. To get
///    extended error information, call SnmpGetLastError specifying a <b>NULL</b> value in its <i>session</i> parameter.
///    The <b>SnmpGetLastError</b> function can return one of the following errors. <table> <tr> <th>Return code</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>SNMPAPI_ALLOC_ERROR</b></dt> </dl> </td> <td
///    width="60%"> An error occurred during memory allocation. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>SNMPAPI_OTHER_ERROR</b></dt> </dl> </td> <td width="60%"> The SnmpStartupEx function did not complete
///    successfully, or an unknown or undefined error occurred. </td> </tr> </table>
///    
@DllImport("wsnmp32")
uint SnmpCleanupEx();

///<p class="CCE_Message">[SNMP is available for use in the operating systems specified in the Requirements section. It
///may be altered or unavailable in subsequent versions. Instead, use Windows Remote Management, which is the Microsoft
///implementation of WS-Man.] The WinSNMP <b>SnmpStrToEntity</b> function returns a handle to information about an SNMP
///management entity that is specific to the Microsoft WinSNMP implementation.
///Params:
///    session = Handle to the WinSNMP session.
///    string = Pointer to a null-terminated string that identifies the SNMP management entity of interest. The current setting
///             of the entity and context translation mode determines the manner in which <b>SnmpStrToEntity</b> interprets the
///             input string as follows. <table> <tr> <th>Entity/Context Translation Mode</th> <th>Meaning</th> </tr> <tr> <td
///             width="40%"><a id="SNMPAPI_TRANSLATED"></a><a id="snmpapi_translated"></a><dl> <dt><b>SNMPAPI_TRANSLATED</b></dt>
///             </dl> </td> <td width="60%"> The implementation interprets the <i>string</i> parameter as a user-friendly name.
///             The implementation translates the name into its SNMPv1 or SNMPv2C components using the implementation's database.
///             </td> </tr> <tr> <td width="40%"><a id="SNMPAPI_UNTRANSLATED_V1"></a><a id="snmpapi_untranslated_v1"></a><dl>
///             <dt><b>SNMPAPI_UNTRANSLATED_V1</b></dt> </dl> </td> <td width="60%"> The implementation interprets the
///             <i>string</i> parameter as a literal SNMP transport address. </td> </tr> <tr> <td width="40%"><a
///             id="SNMPAPI_UNTRANSLATED_V2"></a><a id="snmpapi_untranslated_v2"></a><dl> <dt><b>SNMPAPI_UNTRANSLATED_V2</b></dt>
///             </dl> </td> <td width="60%"> The implementation interprets the <i>string</i> parameter as a literal SNMP
///             transport address. </td> </tr> </table>
///Returns:
///    If the function succeeds, the return value is a handle to the SNMP management entity of interest. If the function
///    fails, the return value is SNMPAPI_FAILURE. To get extended error information, call SnmpGetLastError. The
///    <b>SnmpGetLastError</b> function can return one of the following errors. <table> <tr> <th>Return code</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>SNMPAPI_NOT_INITIALIZED</b></dt> </dl> </td> <td
///    width="60%"> The SnmpStartup function did not complete successfully. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>SNMPAPI_ALLOC_ERROR</b></dt> </dl> </td> <td width="60%"> An error occurred during memory allocation.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>SNMPAPI_SESSION_INVALID</b></dt> </dl> </td> <td width="60%"> The
///    <i>session</i> parameter is invalid. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>SNMPAPI_ENTITY_UNKNOWN</b></dt> </dl> </td> <td width="60%"> The entity string is invalid. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>SNMPAPI_OTHER_ERROR</b></dt> </dl> </td> <td width="60%"> An unknown or
///    undefined error occurred. </td> </tr> </table>
///    
@DllImport("wsnmp32")
ptrdiff_t SnmpStrToEntity(ptrdiff_t session, const(PSTR) string);

///<p class="CCE_Message">[SNMP is available for use in the operating systems specified in the Requirements section. It
///may be altered or unavailable in subsequent versions. Instead, use Windows Remote Management, which is the Microsoft
///implementation of WS-Man.] The WinSNMP <b>SnmpEntityToStr</b> function returns a string that identifies an SNMP
///management entity.
///Params:
///    entity = Handle to the SNMP management entity of interest.
///    size = Specifies the size, in bytes, of the buffer pointed to by the <i>string</i> parameter. The WinSNMP application
///           must allocate a buffer that is large enough to contain the output string.
///    string = Pointer to a buffer to receive the null-terminated string that identifies the SNMP management entity of interest.
///Returns:
///    If the function succeeds, the return value is the number of bytes, including a terminating null byte, that
///    <b>SnmpEntityToStr</b> returns in the <i>string</i> buffer. This value can be less than or equal to the value of
///    the <i>size</i> parameter, but it cannot be greater. If the function fails, the return value is SNMPAPI_FAILURE.
///    To get extended error information, call SnmpGetLastError. The <b>SnmpGetLastError</b> function can return one of
///    the following errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>SNMPAPI_NOT_INITIALIZED</b></dt> </dl> </td> <td width="60%"> The SnmpStartup function did not complete
///    successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>SNMPAPI_ALLOC_ERROR</b></dt> </dl> </td> <td
///    width="60%"> An error occurred during memory allocation. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>SNMPAPI_ENTITY_INVALID</b></dt> </dl> </td> <td width="60%"> The <i>entity</i> parameter is invalid. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>SNMPAPI_OUTPUT_TRUNCATED</b></dt> </dl> </td> <td width="60%"> The output
///    buffer length is insufficient. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>SNMPAPI_OTHER_ERROR</b></dt> </dl>
///    </td> <td width="60%"> An unknown or undefined error occurred. </td> </tr> </table>
///    
@DllImport("wsnmp32")
uint SnmpEntityToStr(ptrdiff_t entity, uint size, PSTR string);

///<p class="CCE_Message">[SNMP is available for use in the operating systems specified in the Requirements section. It
///may be altered or unavailable in subsequent versions. Instead, use Windows Remote Management, which is the Microsoft
///implementation of WS-Man.] The WinSNMP <b>SnmpFreeEntity</b> function releases resources associated with an SNMP
///management entity.
///Params:
///    entity = Handle to the SNMP management entity that will have its resources released.
///Returns:
///    If the function succeeds, the return value is SNMPAPI_SUCCESS. If the function fails, the return value is
///    SNMPAPI_FAILURE. To get extended error information, call SnmpGetLastError specifying a <b>NULL</b> value in its
///    <i>session</i> parameter. The <b>SnmpGetLastError</b> function can return one of the following errors. <table>
///    <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>SNMPAPI_NOT_INITIALIZED</b></dt> </dl> </td> <td width="60%"> The SnmpStartup function did not complete
///    successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>SNMPAPI_ALLOC_ERROR</b></dt> </dl> </td> <td
///    width="60%"> An error occurred during memory allocation. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>SNMPAPI_ENTITY_INVALID</b></dt> </dl> </td> <td width="60%"> The <i>entity</i> parameter is invalid. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>SNMPAPI_OTHER_ERROR</b></dt> </dl> </td> <td width="60%"> An unknown or
///    undefined error occurred. </td> </tr> </table>
///    
@DllImport("wsnmp32")
uint SnmpFreeEntity(ptrdiff_t entity);

///<p class="CCE_Message">[SNMP is available for use in the operating systems specified in the Requirements section. It
///may be altered or unavailable in subsequent versions. Instead, use Windows Remote Management, which is the Microsoft
///implementation of WS-Man.] The WinSNMP <b>SnmpStrToContext</b> function returns a handle to SNMP context information
///that is specific to the Microsoft WinSNMP implementation. The handle is a valid value that a WinSNMP application can
///use as the <i>context</i> parameter in a call to the SnmpSendMsg and SnmpRegister functions.
///Params:
///    session = Handle to the WinSNMP session.
///    string = Pointer to an smiOCTETS structure that contains a string to interpret. The string can identify a collection of
///             managed objects, or it can be a community string. The current setting of the entity and context translation mode
///             determines the way <b>SnmpStrToContext</b> interprets the input string structure as shown in the following table.
///             <table> <tr> <th>Entity/Context Translation Mode</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
///             id="SNMPAPI_TRANSLATED"></a><a id="snmpapi_translated"></a><dl> <dt><b>SNMPAPI_TRANSLATED</b></dt> </dl> </td>
///             <td width="60%"> The implementation interprets the <i>string</i> parameter as a user-friendly name for a
///             collection of managed objects. The implementation translates the name into its SNMPv1 or SNMPv2C components using
///             the implementation's database. </td> </tr> <tr> <td width="40%"><a id="SNMPAPI_UNTRANSLATED_V1"></a><a
///             id="snmpapi_untranslated_v1"></a><dl> <dt><b>SNMPAPI_UNTRANSLATED_V1</b></dt> </dl> </td> <td width="60%"> The
///             implementation interprets the <i>string</i> parameter as a literal SNMP community string. </td> </tr> <tr> <td
///             width="40%"><a id="SNMPAPI_UNTRANSLATED_V2"></a><a id="snmpapi_untranslated_v2"></a><dl>
///             <dt><b>SNMPAPI_UNTRANSLATED_V2</b></dt> </dl> </td> <td width="60%"> The implementation interprets the
///             <i>string</i> parameter as a literal SNMP community string. </td> </tr> </table>
///Returns:
///    If the function succeeds, the return value is a handle to the context of interest. If the function fails, the
///    return value is SNMPAPI_FAILURE. To get extended error information, call SnmpGetLastError. The
///    <b>SnmpGetLastError</b> function can return one of the following errors. <table> <tr> <th>Return code</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>SNMPAPI_NOT_INITIALIZED</b></dt> </dl> </td> <td
///    width="60%"> The SnmpStartup function did not complete successfully. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>SNMPAPI_ALLOC_ERROR</b></dt> </dl> </td> <td width="60%"> An error occurred during memory allocation.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>SNMPAPI_SESSION_INVALID</b></dt> </dl> </td> <td width="60%"> The
///    <i>session</i> parameter is invalid. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>SNMPAPI_CONTEXT_INVALID</b></dt> </dl> </td> <td width="60%"> The <i>string</i> parameter format is
///    invalid. For example, the <b>len</b> member or the <b>ptr</b> member of the smiOCTETS structure pointed to by the
///    <i>string</i> parameter is <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>SNMPAPI_CONTEXT_UNKNOWN</b></dt> </dl> </td> <td width="60%"> The value referenced in the <i>string</i>
///    parameter does not exist. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>SNMPAPI_OTHER_ERROR</b></dt> </dl> </td>
///    <td width="60%"> An unknown or undefined error occurred. </td> </tr> </table>
///    
@DllImport("wsnmp32")
ptrdiff_t SnmpStrToContext(ptrdiff_t session, smiOCTETS* string);

///<p class="CCE_Message">[SNMP is available for use in the operating systems specified in the Requirements section. It
///may be altered or unavailable in subsequent versions. Instead, use Windows Remote Management, which is the Microsoft
///implementation of WS-Man.] The WinSNMP <b>SnmpContextToStr</b> function returns a string that identifies an SNMP
///context, which is a set of managed object resources. The function returns the string in an smiOCTETS structure.
///Params:
///    context = Handle to the SNMP context of interest.
///    string = Pointer to an smiOCTETS structure to receive the string that identifies the context of interest. The string can
///             have a null-terminating byte.
///Returns:
///    If the function succeeds, the return value is SNMPAPI_SUCCESS. If the function fails, the return value is
///    SNMPAPI_FAILURE. To get extended error information, call SnmpGetLastError. The <b>SnmpGetLastError</b> function
///    can return one of the following errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>SNMPAPI_NOT_INITIALIZED</b></dt> </dl> </td> <td width="60%"> The SnmpStartup function
///    did not complete successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>SNMPAPI_ALLOC_ERROR</b></dt> </dl>
///    </td> <td width="60%"> An error occurred during memory allocation. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>SNMPAPI_CONTEXT_INVALID</b></dt> </dl> </td> <td width="60%"> The <i>context</i> parameter is invalid.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>SNMPAPI_OTHER_ERROR</b></dt> </dl> </td> <td width="60%"> An
///    unknown or undefined error occurred. </td> </tr> </table>
///    
@DllImport("wsnmp32")
uint SnmpContextToStr(ptrdiff_t context, smiOCTETS* string);

///<p class="CCE_Message">[SNMP is available for use in the operating systems specified in the Requirements section. It
///may be altered or unavailable in subsequent versions. Instead, use Windows Remote Management, which is the Microsoft
///implementation of WS-Man.] The WinSNMP <b>SnmpFreeContext</b> function releases resources associated with an SNMP
///context, which is a set of managed object resources.
///Params:
///    context = Handle to the SNMP context that will have its resources released.
///Returns:
///    If the function succeeds, the return value is SNMPAPI_SUCCESS. If the function fails, the return value is
///    SNMPAPI_FAILURE. To get extended error information, call SnmpGetLastError specifying a <b>NULL</b> value in its
///    <i>session</i> parameter. The <b>SnmpGetLastError</b> function can return one of the following errors. <table>
///    <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>SNMPAPI_NOT_INITIALIZED</b></dt> </dl> </td> <td width="60%"> The SnmpStartup function did not complete
///    successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>SNMPAPI_ALLOC_ERROR</b></dt> </dl> </td> <td
///    width="60%"> An error occurred during memory allocation. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>SNMPAPI_CONTEXT_INVALID</b></dt> </dl> </td> <td width="60%"> The <i>context</i> parameter is invalid.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>SNMPAPI_OTHER_ERROR</b></dt> </dl> </td> <td width="60%"> An
///    unknown or undefined error occurred. </td> </tr> </table>
///    
@DllImport("wsnmp32")
uint SnmpFreeContext(ptrdiff_t context);

///<p class="CCE_Message">[SNMP is available for use in the operating systems specified in the Requirements section. It
///may be altered or unavailable in subsequent versions. Instead, use Windows Remote Management, which is the Microsoft
///implementation of WS-Man.] A WinSNMP application calls the <b>SnmpSetPort</b> function to change the port assigned to
///a destination entity. The <b>SnmpSetPort</b> function is an element of the WinSNMP API, version 2.0.
///Params:
///    hEntity = Handle to a WinSNMP destination entity. This parameter can specify the handle to an entity acting in the role of
///              an SNMP agent application as a result of a call to the SnmpListen function. For more information, see the
///              following Remarks section.
///    nPort = Specifies an unsigned integer that identifies the new port assignment for the destination entity. If you specify
///            a local address that is busy, or if you specify a remote address that is unavailable, a call to the
///            <b>SnmpSetPort</b> function fails.
///Returns:
///    If the function succeeds, the return value is SNMPAPI_SUCCESS. If the function fails, the return value is
///    SNMPAPI_FAILURE. To get extended error information, call SnmpGetLastError specifying a <b>NULL</b> value in its
///    <i>session</i> parameter. The <b>SnmpGetLastError</b> function can return one of the following errors. <table>
///    <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>SNMPAPI_NOT_INITIALIZED</b></dt> </dl> </td> <td width="60%"> The SnmpStartup function did not complete
///    successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>SNMPAPI_OPERATION_INVALID</b></dt> </dl> </td> <td
///    width="60%"> The entity specified by the <i>hEntity</i> parameter is already functioning in an agent role as the
///    result of a call to the SnmpListen function. For more information, see the following Remarks section. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>SNMPAPI_ENTITY_INVALID</b></dt> </dl> </td> <td width="60%"> The <i>hEntity</i>
///    parameter is invalid. This parameter must be a handle returned by a previous call to the SnmpStrToEntity
///    function. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>SNMPAPI_OTHER_ERROR</b></dt> </dl> </td> <td width="60%">
///    An unknown or undefined error occurred. </td> </tr> </table>
///    
@DllImport("wsnmp32")
uint SnmpSetPort(ptrdiff_t hEntity, uint nPort);

///<p class="CCE_Message">[SNMP is available for use in the operating systems specified in the Requirements section. It
///may be altered or unavailable in subsequent versions. Instead, use Windows Remote Management, which is the Microsoft
///implementation of WS-Man.] The WinSNMP <b>SnmpCreatePdu</b> function creates and initializes an SNMP protocol data
///unit (PDU).
///Params:
///    session = Handle to the WinSNMP session.
///    PDU_type = Specifies a PDU type that identifies the SNMP operation. This parameter can be <b>NULL</b>, or it can be one of
///               the following values. If this parameter is <b>NULL</b>, the Microsoft WinSNMP implementation supplies the default
///               PDU type SNMP_PDU_GETNEXT. The only type of trap PDU you can create with a call to the <b>SnmpCreatePdu</b>
///               function is an SNMPv2C trap PDU. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
///               id="SNMP_PDU_GET"></a><a id="snmp_pdu_get"></a><dl> <dt><b>SNMP_PDU_GET</b></dt> </dl> </td> <td width="60%">
///               Search and retrieve a value from a specified SNMP variable. </td> </tr> <tr> <td width="40%"><a
///               id="SNMP_PDU_GETNEXT"></a><a id="snmp_pdu_getnext"></a><dl> <dt><b>SNMP_PDU_GETNEXT</b></dt> </dl> </td> <td
///               width="60%"> Search and retrieve the value of an SNMP variable without knowing the exact name of the variable.
///               </td> </tr> <tr> <td width="40%"><a id="SNMP_PDU_RESPONSE"></a><a id="snmp_pdu_response"></a><dl>
///               <dt><b>SNMP_PDU_RESPONSE</b></dt> </dl> </td> <td width="60%"> Reply to an SNMP_PDU_GET or an SNMP_PDU_GETNEXT
///               request. </td> </tr> <tr> <td width="40%"><a id="SNMP_PDU_SET"></a><a id="snmp_pdu_set"></a><dl>
///               <dt><b>SNMP_PDU_SET</b></dt> </dl> </td> <td width="60%"> Store a value in a specified SNMP variable. </td> </tr>
///               <tr> <td width="40%"><a id="SNMP_PDU_GETBULK"></a><a id="snmp_pdu_getbulk"></a><dl>
///               <dt><b>SNMP_PDU_GETBULK</b></dt> </dl> </td> <td width="60%"> Search and retrieve multiple values with a single
///               request. </td> </tr> <tr> <td width="40%"><a id="SNMP_PDU_TRAP"></a><a id="snmp_pdu_trap"></a><dl>
///               <dt><b>SNMP_PDU_TRAP</b></dt> </dl> </td> <td width="60%"> Alerts the management system to an event under
///               SNMPv2C. </td> </tr> </table>
///    request_id = Specifies a unique numeric value that the WinSNMP application supplies to identify the PDU. If this parameter is
///                 <b>NULL</b>, the implementation assigns a value.
///    error_status = If the <i>PDU_type</i> parameter is equal to <b>SNMP_PDU_GETBULK</b>, this parameter specifies a value for the
///                   <b>non_repeaters</b> field of the PDU. For other PDU types, this parameter specifies a value for the
///                   <b>error_status</b> field of the PDU. This parameter can be <b>NULL</b>.
///    error_index = If the <i>PDU_type</i> parameter is equal to <b>SNMP_PDU_GETBULK</b>, this parameter specifies a value for the
///                  <b>max_repetitions</b> field of the PDU. For other PDU types, this parameter specifies a value for the
///                  <b>error_index</b> field of the PDU. This parameter can be <b>NULL</b>.
///    varbindlist = Handle to a structure that represents an SNMP variable bindings list. This parameter can be <b>NULL</b>.
///Returns:
///    If the function succeeds, the return value is the handle to a new SNMP PDU. If the function fails, the return
///    value is SNMPAPI_FAILURE. To get extended error information, call SnmpGetLastError. The <b>SnmpGetLastError</b>
///    function can return one of the following errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>SNMPAPI_NOT_INITIALIZED</b></dt> </dl> </td> <td width="60%"> The SnmpStartup
///    function did not complete successfully. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>SNMPAPI_ALLOC_ERROR</b></dt> </dl> </td> <td width="60%"> An error occurred during memory allocation.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>SNMPAPI_SESSION_INVALID</b></dt> </dl> </td> <td width="60%"> The
///    session handle is invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>SNMPAPI_PDU_INVALID</b></dt> </dl> </td>
///    <td width="60%"> The PDU type is invalid. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>SNMPAPI_VBL_INVALID</b></dt> </dl> </td> <td width="60%"> The variable bindings list is invalid. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>SNMPAPI_OTHER_ERROR</b></dt> </dl> </td> <td width="60%"> An unknown or
///    undefined error occurred. </td> </tr> </table>
///    
@DllImport("wsnmp32")
ptrdiff_t SnmpCreatePdu(ptrdiff_t session, int PDU_type, int request_id, int error_status, int error_index, 
                        ptrdiff_t varbindlist);

///<p class="CCE_Message">[SNMP is available for use in the operating systems specified in the Requirements section. It
///may be altered or unavailable in subsequent versions. Instead, use Windows Remote Management, which is the Microsoft
///implementation of WS-Man.] The WinSNMP <b>SnmpGetPduData</b> function returns selected data fields from a specified
///SNMP protocol data unit (PDU).
///Params:
///    PDU = Handle to the SNMP PDU.
///    PDU_type = Pointer to a variable that receives the <b>PDU_type</b> field of the specified PDU. This parameter can be
///               <b>NULL</b>, or one of the following values. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td
///               width="40%"><a id="SNMP_PDU_GET_"></a><a id="snmp_pdu_get_"></a><dl> <dt><b>SNMP_PDU_GET </b></dt> </dl> </td>
///               <td width="60%"> Search and retrieve a value from a specified SNMP variable. </td> </tr> <tr> <td width="40%"><a
///               id="SNMP_PDU_GETNEXT_"></a><a id="snmp_pdu_getnext_"></a><dl> <dt><b>SNMP_PDU_GETNEXT </b></dt> </dl> </td> <td
///               width="60%"> Search and retrieve the value of an SNMP variable without knowing the exact name of the variable.
///               </td> </tr> <tr> <td width="40%"><a id="SNMP_PDU_RESPONSE_"></a><a id="snmp_pdu_response_"></a><dl>
///               <dt><b>SNMP_PDU_RESPONSE </b></dt> </dl> </td> <td width="60%"> Reply to an <b>SNMP_PDU_GET</b> or an
///               <b>SNMP_PDU_GETNEXT</b> request. </td> </tr> <tr> <td width="40%"><a id="SNMP_PDU_SET_"></a><a
///               id="snmp_pdu_set_"></a><dl> <dt><b>SNMP_PDU_SET </b></dt> </dl> </td> <td width="60%"> Store a value in a
///               specified SNMP variable. </td> </tr> <tr> <td width="40%"><a id="SNMP_PDU_GETBULK_"></a><a
///               id="snmp_pdu_getbulk_"></a><dl> <dt><b>SNMP_PDU_GETBULK </b></dt> </dl> </td> <td width="60%"> Search and
///               retrieve multiple values with a single request. </td> </tr> <tr> <td width="40%"><a id="SNMP_PDU_TRAP_"></a><a
///               id="snmp_pdu_trap_"></a><dl> <dt><b>SNMP_PDU_TRAP </b></dt> </dl> </td> <td width="60%"> Alerts the management
///               system to an extraordinary event under SNMPv2C. </td> </tr> </table>
///    request_id = Pointer to a variable that receives the <b>request_id</b> field of the specified PDU. This parameter can be
///                 <b>NULL</b>.
///    error_status = Pointer to a variable that receives the <b>error_status</b> field of the specified PDU. If the <i>PDU_type</i>
///                   parameter is equal to <b>SNMP_PDU_GETBULK</b>, this parameter receives the value of the <b>non_repeaters</b>
///                   field of the PDU. This parameter can be <b>NULL</b>, or one of the following values. The first six errors are
///                   common to the SNMP version 1 (SNMPv1) and SNMP version 2C frameworks (SNMPv2C). The remaining errors are
///                   available under SNMPv2C only. <table> <tr> <th>Error code</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
///                   id="SNMP_ERROR_NOERROR"></a><a id="snmp_error_noerror"></a><dl> <dt><b>SNMP_ERROR_NOERROR</b></dt> </dl> </td>
///                   <td width="60%"> The agent reports that no errors occurred during transmission. </td> </tr> <tr> <td
///                   width="40%"><a id="SNMP_ERROR_TOOBIG"></a><a id="snmp_error_toobig"></a><dl> <dt><b>SNMP_ERROR_TOOBIG</b></dt>
///                   </dl> </td> <td width="60%"> The agent could not place the results of the requested SNMP operation into a single
///                   SNMP message. </td> </tr> <tr> <td width="40%"><a id="SNMP_ERROR_NOSUCHNAME"></a><a
///                   id="snmp_error_nosuchname"></a><dl> <dt><b>SNMP_ERROR_NOSUCHNAME</b></dt> </dl> </td> <td width="60%"> The
///                   requested SNMP operation identified an unknown variable. </td> </tr> <tr> <td width="40%"><a
///                   id="SNMP_ERROR_BADVALUE"></a><a id="snmp_error_badvalue"></a><dl> <dt><b>SNMP_ERROR_BADVALUE</b></dt> </dl> </td>
///                   <td width="60%"> The requested SNMP operation tried to change a variable but it specified either a syntax or
///                   value error. </td> </tr> <tr> <td width="40%"><a id="SNMP_ERROR_READONLY"></a><a
///                   id="snmp_error_readonly"></a><dl> <dt><b>SNMP_ERROR_READONLY</b></dt> </dl> </td> <td width="60%"> The requested
///                   SNMP operation tried to change a variable that was not allowed to change, according to the community profile of
///                   the variable. </td> </tr> <tr> <td width="40%"><a id="SNMP_ERROR_GENERR"></a><a id="snmp_error_generr"></a><dl>
///                   <dt><b>SNMP_ERROR_GENERR</b></dt> </dl> </td> <td width="60%"> An error other than one of those listed here
///                   occurred during the requested SNMP operation. </td> </tr> <tr> <td width="40%"><a id="SNMP_ERROR_NOACCESS"></a><a
///                   id="snmp_error_noaccess"></a><dl> <dt><b>SNMP_ERROR_NOACCESS</b></dt> </dl> </td> <td width="60%"> The specified
///                   SNMP variable is not accessible. </td> </tr> <tr> <td width="40%"><a id="SNMP_ERROR_WRONGTYPE"></a><a
///                   id="snmp_error_wrongtype"></a><dl> <dt><b>SNMP_ERROR_WRONGTYPE</b></dt> </dl> </td> <td width="60%"> The value
///                   specifies a type that is inconsistent with the type required for the variable. </td> </tr> <tr> <td
///                   width="40%"><a id="SNMP_ERROR_WRONGLENGTH"></a><a id="snmp_error_wronglength"></a><dl>
///                   <dt><b>SNMP_ERROR_WRONGLENGTH</b></dt> </dl> </td> <td width="60%"> The value specifies a length that is
///                   inconsistent with the length required for the variable. </td> </tr> <tr> <td width="40%"><a
///                   id="SNMP_ERROR_WRONGENCODING"></a><a id="snmp_error_wrongencoding"></a><dl>
///                   <dt><b>SNMP_ERROR_WRONGENCODING</b></dt> </dl> </td> <td width="60%"> The value contains an Abstract Syntax
///                   Notation One (ASN.1) encoding that is inconsistent with the ASN.1 tag of the field. </td> </tr> <tr> <td
///                   width="40%"><a id="SNMP_ERROR_WRONGVALUE"></a><a id="snmp_error_wrongvalue"></a><dl>
///                   <dt><b>SNMP_ERROR_WRONGVALUE</b></dt> </dl> </td> <td width="60%"> The value cannot be assigned to the variable.
///                   </td> </tr> <tr> <td width="40%"><a id="SNMP_ERROR_NOCREATION"></a><a id="snmp_error_nocreation"></a><dl>
///                   <dt><b>SNMP_ERROR_NOCREATION</b></dt> </dl> </td> <td width="60%"> The variable does not exist, and the agent
///                   cannot create it. </td> </tr> <tr> <td width="40%"><a id="SNMP_ERROR_INCONSISTENTVALUE"></a><a
///                   id="snmp_error_inconsistentvalue"></a><dl> <dt><b>SNMP_ERROR_INCONSISTENTVALUE</b></dt> </dl> </td> <td
///                   width="60%"> The value is inconsistent with values of other managed objects. </td> </tr> <tr> <td width="40%"><a
///                   id="SNMP_ERROR_RESOURCEUNAVAILABLE"></a><a id="snmp_error_resourceunavailable"></a><dl>
///                   <dt><b>SNMP_ERROR_RESOURCEUNAVAILABLE</b></dt> </dl> </td> <td width="60%"> Assigning the value to the variable
///                   requires allocation of resources that are currently unavailable. </td> </tr> <tr> <td width="40%"><a
///                   id="SNMP_ERROR_COMMITFAILED"></a><a id="snmp_error_commitfailed"></a><dl> <dt><b>SNMP_ERROR_COMMITFAILED</b></dt>
///                   </dl> </td> <td width="60%"> No validation errors occurred, but no variables were updated. </td> </tr> <tr> <td
///                   width="40%"><a id="SNMP_ERROR_UNDOFAILED"></a><a id="snmp_error_undofailed"></a><dl>
///                   <dt><b>SNMP_ERROR_UNDOFAILED</b></dt> </dl> </td> <td width="60%"> No validation errors occurred. Some variables
///                   were updated because it was not possible to undo their assignment. </td> </tr> <tr> <td width="40%"><a
///                   id="SNMP_ERROR_AUTHORIZATIONERROR"></a><a id="snmp_error_authorizationerror"></a><dl>
///                   <dt><b>SNMP_ERROR_AUTHORIZATIONERROR</b></dt> </dl> </td> <td width="60%"> An authorization error occurred. </td>
///                   </tr> <tr> <td width="40%"><a id="SNMP_ERROR_NOTWRITABLE"></a><a id="snmp_error_notwritable"></a><dl>
///                   <dt><b>SNMP_ERROR_NOTWRITABLE</b></dt> </dl> </td> <td width="60%"> The variable exists but the agent cannot
///                   modify it. </td> </tr> <tr> <td width="40%"><a id="SNMP_ERROR_INCONSISTENTNAME"></a><a
///                   id="snmp_error_inconsistentname"></a><dl> <dt><b>SNMP_ERROR_INCONSISTENTNAME</b></dt> </dl> </td> <td
///                   width="60%"> The variable does not exist; the agent cannot create it because the named object instance is
///                   inconsistent with the values of other managed objects. </td> </tr> </table>
///    error_index = Pointer to a variable that receives the <b>error_index</b> field of the specified PDU. If the <i>PDU_type</i>
///                  parameter is equal to <b>SNMP_PDU_GETBULK</b>, this parameter receives the value of the <b>max_repetitions</b>
///                  field of the specified PDU. This parameter can be <b>NULL</b>.
///    varbindlist = Pointer to a variable that receives a handle to the variable bindings list field of the specified PDU. This
///                  parameter can be <b>NULL</b>. For additional information, see the following Remarks section.
///Returns:
///    If the function succeeds, the return value is SNMPAPI_SUCCESS. If the function fails, the return value is
///    SNMPAPI_FAILURE. To get extended error information, call SnmpGetLastError. The <b>SnmpGetLastError</b> function
///    can return one of the following errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>SNMPAPI_NOT_INITIALIZED</b></dt> </dl> </td> <td width="60%"> The SnmpStartup function
///    did not complete successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>SNMPAPI_ALLOC_ERROR</b></dt> </dl>
///    </td> <td width="60%"> An error occurred during memory allocation. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>SNMPAPI_NOOP</b></dt> </dl> </td> <td width="60%"> All output parameters are <b>NULL</b>. The SNMP
///    operation was not performed. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>SNMPAPI_PDU_INVALID</b></dt> </dl>
///    </td> <td width="60%"> The PDU type is invalid. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>SNMPAPI_OTHER_ERROR</b></dt> </dl> </td> <td width="60%"> An unknown or undefined error occurred. </td>
///    </tr> </table>
///    
@DllImport("wsnmp32")
uint SnmpGetPduData(ptrdiff_t PDU, int* PDU_type, int* request_id, int* error_status, int* error_index, 
                    ptrdiff_t* varbindlist);

///<p class="CCE_Message">[SNMP is available for use in the operating systems specified in the Requirements section. It
///may be altered or unavailable in subsequent versions. Instead, use Windows Remote Management, which is the Microsoft
///implementation of WS-Man.] The WinSNMP <b>SnmpSetPduData</b> function updates selected data fields in the specified
///SNMP protocol data unit (PDU).
///Params:
///    PDU = Handle to an SNMP PDU.
///    PDU_type = Pointer to a variable with a value to update the <b>PDU_type</b> field of the specified PDU. This parameter can
///               also be <b>NULL</b>.
///    request_id = Pointer to a variable with a value to update the <b>request_id</b> field of the specified PDU. This parameter can
///                 also be <b>NULL</b>.
///    non_repeaters = If the <i>PDU_type</i> parameter is equal to SNMP_PDU_GETBULK, this parameter points to a variable with a value
///                    to update the <b>non_repeaters</b> field of the specified PDU. The Microsoft WinSNMP implementation ignores this
///                    parameter for other PDU types. This parameter can also be <b>NULL</b>.
///    max_repetitions = If the <i>PDU_type</i> parameter is equal to SNMP_PDU_GETBULK, this parameter points to a variable with a value
///                      to update the <b>max_repetitions</b> field of the specified PDU. The implementation ignores this parameter for
///                      other PDU types. This parameter can also be <b>NULL</b>.
///    varbindlist = Pointer to a variable with a value that updates the handle to the variable bindings list field of the specified
///                  PDU. This parameter can also be <b>NULL</b>.
///Returns:
///    If the function succeeds, the return value is SNMPAPI_SUCCESS. If the function fails, the return value is
///    SNMPAPI_FAILURE. To get extended error information, call SnmpGetLastError. The <b>SnmpGetLastError</b> function
///    can return one of the following errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>SNMPAPI_NOT_INITIALIZED</b></dt> </dl> </td> <td width="60%"> The SnmpStartup function
///    did not complete successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>SNMPAPI_ALLOC_ERROR</b></dt> </dl>
///    </td> <td width="60%"> An error occurred during memory allocation. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>SNMPAPI_PDU_INVALID</b></dt> </dl> </td> <td width="60%"> The PDU type is invalid. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>SNMPAPI_VBL_INVALID</b></dt> </dl> </td> <td width="60%"> The variable bindings list is
///    invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>SNMPAPI_NOOP</b></dt> </dl> </td> <td width="60%"> All
///    input parameters are <b>NULL</b>. The SNMP operation was not performed. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>SNMPAPI_OTHER_ERROR</b></dt> </dl> </td> <td width="60%"> An unknown or undefined error occurred. </td>
///    </tr> </table>
///    
@DllImport("wsnmp32")
uint SnmpSetPduData(ptrdiff_t PDU, const(int)* PDU_type, const(int)* request_id, const(int)* non_repeaters, 
                    const(int)* max_repetitions, const(ptrdiff_t)* varbindlist);

///<p class="CCE_Message">[SNMP is available for use in the operating systems specified in the Requirements section. It
///may be altered or unavailable in subsequent versions. Instead, use Windows Remote Management, which is the Microsoft
///implementation of WS-Man.] The WinSNMP <b>SnmpDuplicatePdu</b> function duplicates the SNMP protocol data unit (PDU)
///that the <i>PDU</i> parameter identifies, allocating any necessary memory for the duplicate PDU.
///Params:
///    session = Handle to the WinSNMP session.
///    PDU = Handle to the PDU to duplicate. The <b>SnmpDuplicatePdu</b> function provides a unique handle to each PDU within
///          the calling application.
///Returns:
///    If the function succeeds, the return value is a handle that identifies the new duplicate PDU. If the function
///    fails, the return value is SNMPAPI_FAILURE. To get extended error information, call SnmpGetLastError. The
///    <b>SnmpGetLastError</b> function can return one of the following errors. <table> <tr> <th>Return code</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>SNMPAPI_NOT_INITIALIZED</b></dt> </dl> </td> <td
///    width="60%"> The SnmpStartup function did not complete successfully. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>SNMPAPI_ALLOC_ERROR</b></dt> </dl> </td> <td width="60%"> An error occurred during memory allocation.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>SNMPAPI_SESSION_INVALID</b></dt> </dl> </td> <td width="60%"> The
///    session handle is invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>SNMPAPI_PDU_INVALID</b></dt> </dl> </td>
///    <td width="60%"> The PDU handle is invalid. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>SNMPAPI_OTHER_ERROR</b></dt> </dl> </td> <td width="60%"> An unknown or undefined error occurred. </td>
///    </tr> </table>
///    
@DllImport("wsnmp32")
ptrdiff_t SnmpDuplicatePdu(ptrdiff_t session, ptrdiff_t PDU);

///<p class="CCE_Message">[SNMP is available for use in the operating systems specified in the Requirements section. It
///may be altered or unavailable in subsequent versions. Instead, use Windows Remote Management, which is the Microsoft
///implementation of WS-Man.] The WinSNMP <b>SnmpFreePdu</b> function releases resources associated with an SNMP
///protocol data unit (PDU) created by the SnmpCreatePdu or the SnmpDuplicatePdu function.
///Params:
///    PDU = Handle to the SNMP PDU to free.
///Returns:
///    If the function succeeds, the return value is SNMPAPI_SUCCESS. If the function fails, the return value is
///    SNMPAPI_FAILURE. To get extended error information, call SnmpGetLastError specifying a <b>NULL</b> value in its
///    <i>session</i> parameter. The <b>SnmpGetLastError</b> function can return one of the following errors. <table>
///    <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>SNMPAPI_NOT_INITIALIZED</b></dt> </dl> </td> <td width="60%"> The SnmpStartup function did not complete
///    successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>SNMPAPI_ALLOC_ERROR</b></dt> </dl> </td> <td
///    width="60%"> An error occurred during memory allocation. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>SNMPAPI_PDU_INVALID</b></dt> </dl> </td> <td width="60%"> The PDU handle is invalid. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>SNMPAPI_OTHER_ERROR</b></dt> </dl> </td> <td width="60%"> An unknown or undefined error
///    occurred. </td> </tr> </table>
///    
@DllImport("wsnmp32")
uint SnmpFreePdu(ptrdiff_t PDU);

///<p class="CCE_Message">[SNMP is available for use in the operating systems specified in the Requirements section. It
///may be altered or unavailable in subsequent versions. Instead, use Windows Remote Management, which is the Microsoft
///implementation of WS-Man.] The WinSNMP <b>SnmpCreateVbl</b> function creates a new variable bindings list for the
///calling WinSNMP application. If the <i>name</i> and <i>value</i> parameters are not <b>NULL</b>, <b>SnmpCreateVbl</b>
///uses their values to create the first variable binding entry for the new variable bindings list. The
///<b>SnmpCreateVbl</b> function returns a handle to the new variable bindings list and allocates any necessary memory
///for it.
///Params:
///    session = Handle to the WinSNMP session.
///    name = Pointer to an smiOID structure that contains the variable name for the first variable binding entry. This
///           parameter can be <b>NULL</b>. For additional information, see the following Remarks section.
///    value = Pointer to an smiVALUE structure that contains a value to associate with the variable in the first variable
///            binding entry. This parameter can be <b>NULL</b>. For additional information, see the following Remarks section.
///Returns:
///    If the function succeeds, the return value is a handle to a new variable bindings list. If the function fails,
///    the return value is SNMPAPI_FAILURE. To get extended error information, call SnmpGetLastError. The
///    <b>SnmpGetLastError</b> function can return one of the following errors. <table> <tr> <th>Return code</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>SNMPAPI_NOT_INITIALIZED</b></dt> </dl> </td> <td
///    width="60%"> The SnmpStartup function did not complete successfully. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>SNMPAPI_ALLOC_ERROR</b></dt> </dl> </td> <td width="60%"> An error occurred during memory allocation.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>SNMPAPI_SESSION_INVALID</b></dt> </dl> </td> <td width="60%"> The
///    session handle is invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>SNMPAPI_OID_INVALID</b></dt> </dl> </td>
///    <td width="60%"> The <i>name</i> parameter references an invalid smiOID structure. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>SNMPAPI_SYNTAX_INVALID</b></dt> </dl> </td> <td width="60%"> The <b>syntax</b> member of
///    the structure pointed to by the <i>value</i> parameter is invalid. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>SNMPAPI_OTHER_ERROR</b></dt> </dl> </td> <td width="60%"> An unknown or undefined error occurred. </td>
///    </tr> </table>
///    
@DllImport("wsnmp32")
ptrdiff_t SnmpCreateVbl(ptrdiff_t session, smiOID* name, smiVALUE* value);

///<p class="CCE_Message">[SNMP is available for use in the operating systems specified in the Requirements section. It
///may be altered or unavailable in subsequent versions. Instead, use Windows Remote Management, which is the Microsoft
///implementation of WS-Man.] The WinSNMP <b>SnmpDuplicateVbl</b> function copies a variable bindings list for the
///specified WinSNMP session. This function returns a handle to the copied variable bindings list and allocates any
///necessary memory for it.
///Params:
///    session = Handle to the WinSNMP session.
///    vbl = Handle to the variable bindings list to copy. The source variable bindings list can be empty.
///Returns:
///    If the function succeeds, the return value is a handle to a new variable bindings list. If the function fails,
///    the return value is SNMPAPI_FAILURE. To get extended error information, call SnmpGetLastError. The
///    <b>SnmpGetLastError</b> function can return one of the following errors. <table> <tr> <th>Return code</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>SNMPAPI_NOT_INITIALIZED</b></dt> </dl> </td> <td
///    width="60%"> The SnmpStartup function did not complete successfully. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>SNMPAPI_ALLOC_ERROR</b></dt> </dl> </td> <td width="60%"> An error occurred during memory allocation.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>SNMPAPI_SESSION_INVALID</b></dt> </dl> </td> <td width="60%"> The
///    session handle is invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>SNMPAPI_VBL_INVALID</b></dt> </dl> </td>
///    <td width="60%"> The <i>vbl</i> parameter is invalid. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>SNMPAPI_OTHER_ERROR</b></dt> </dl> </td> <td width="60%"> An unknown or undefined error occurred. </td>
///    </tr> </table>
///    
@DllImport("wsnmp32")
ptrdiff_t SnmpDuplicateVbl(ptrdiff_t session, ptrdiff_t vbl);

///<p class="CCE_Message">[SNMP is available for use in the operating systems specified in the Requirements section. It
///may be altered or unavailable in subsequent versions. Instead, use Windows Remote Management, which is the Microsoft
///implementation of WS-Man.] The WinSNMP <b>SnmpFreeVbl</b> function releases resources associated with a variable
///bindings list. These are resources allocated previously by a call to the SnmpCreateVbl function or the
///SnmpDuplicateVbl function in a WinSNMP application.
///Params:
///    vbl = Handle to the variable bindings list to release.
///Returns:
///    If the function succeeds, the return value is SNMPAPI_SUCCESS. If the function fails, the return value is
///    SNMPAPI_FAILURE. To get extended error information, call SnmpGetLastError specifying a <b>NULL</b> value in its
///    <i>session</i> parameter. The <b>SnmpGetLastError</b> function can return one of the following errors. <table>
///    <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>SNMPAPI_NOT_INITIALIZED</b></dt> </dl> </td> <td width="60%"> The SnmpStartup function did not complete
///    successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>SNMPAPI_ALLOC_ERROR</b></dt> </dl> </td> <td
///    width="60%"> An error occurred during memory allocation. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>SNMPAPI_VBL_INVALID</b></dt> </dl> </td> <td width="60%"> The <i>vbl</i> parameter is invalid. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>SNMPAPI_OTHER_ERROR</b></dt> </dl> </td> <td width="60%"> An unknown or
///    undefined error occurred. </td> </tr> </table>
///    
@DllImport("wsnmp32")
uint SnmpFreeVbl(ptrdiff_t vbl);

///<p class="CCE_Message">[SNMP is available for use in the operating systems specified in the Requirements section. It
///may be altered or unavailable in subsequent versions. Instead, use Windows Remote Management, which is the Microsoft
///implementation of WS-Man.] A WinSNMP application calls the WinSNMP <b>SnmpCountVbl</b> function to enumerate the
///variable binding entries in the specified variable bindings list.
///Params:
///    vbl = Handle to the variable bindings list to enumerate.
///Returns:
///    If the function succeeds, the return value is the count of variable binding entries in the variable bindings
///    list. If the function fails, the return value is SNMPAPI_FAILURE. To get extended error information, call
///    SnmpGetLastError specifying a <b>NULL</b> value in its <i>session</i> parameter. The <b>SnmpGetLastError</b>
///    function can return one of the following errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>SNMPAPI_NOT_INITIALIZED</b></dt> </dl> </td> <td width="60%"> The SnmpStartup
///    function did not complete successfully. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>SNMPAPI_ALLOC_ERROR</b></dt> </dl> </td> <td width="60%"> An error occurred during memory allocation.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>SNMPAPI_NOOP</b></dt> </dl> </td> <td width="60%"> The variable
///    bindings list does not contain any variable binding entries at this time. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>SNMPAPI_VBL_INVALID</b></dt> </dl> </td> <td width="60%"> The <i>vbl</i> parameter is invalid. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>SNMPAPI_OTHER_ERROR</b></dt> </dl> </td> <td width="60%"> An unknown or
///    undefined error occurred. </td> </tr> </table>
///    
@DllImport("wsnmp32")
uint SnmpCountVbl(ptrdiff_t vbl);

///<p class="CCE_Message">[SNMP is available for use in the operating systems specified in the Requirements section. It
///may be altered or unavailable in subsequent versions. Instead, use Windows Remote Management, which is the Microsoft
///implementation of WS-Man.] A WinSNMP application calls the <b>SnmpGetVb</b> function to retrieve information from a
///variable bindings list. This WinSNMP function retrieves a variable name and its associated value from the variable
///binding entry specified by the <i>index</i> parameter.
///Params:
///    vbl = Handle to the variable bindings list to retrieve.
///    index = Specifies an unsigned long integer variable that identifies the variable binding entry to retrieve. This variable
///            contains the position of the variable binding entry, within the variable bindings list. Valid values for this
///            parameter are in the range from 1 to n, where 1 indicates the first variable binding entry in the variable
///            bindings list, and n is the total number of entries in the list. For additional information, see the following
///            Remarks section.
///    name = Pointer to an smiOID structure to receive the variable name of the variable binding entry.
///    value = Pointer to an smiVALUE structure to receive the value associated with the variable identified by the <i>name</i>
///            parameter. If the function succeeds, the <b>syntax</b> member of the structure pointed to by the <i>value</i>
///            parameter can be one of the following syntax data types. For additional information, see RFC 1902, "Structure of
///            Management Information for Version 2 of the Simple Network Management Protocol (SNMPv2)." <table> <tr> <th>Syntax
///            data type</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="SNMP_SYNTAX_INT"></a><a
///            id="snmp_syntax_int"></a><dl> <dt><b><b>SNMP_SYNTAX_INT</b></b></dt> </dl> </td> <td width="60%"> Indicates a
///            32-bit signed integer variable. </td> </tr> <tr> <td width="40%"><a id="SNMP_SYNTAX_OCTETS"></a><a
///            id="snmp_syntax_octets"></a><dl> <dt><b><b>SNMP_SYNTAX_OCTETS</b></b></dt> </dl> </td> <td width="60%"> Indicates
///            an octet string variable that is binary or textual data. </td> </tr> <tr> <td width="40%"><a
///            id="SNMP_SYNTAX_NULL"></a><a id="snmp_syntax_null"></a><dl> <dt><b><b>SNMP_SYNTAX_NULL</b></b></dt> </dl> </td>
///            <td width="60%"> Indicates a <b>NULL</b> value. </td> </tr> <tr> <td width="40%"><a id="SNMP_SYNTAX_OID"></a><a
///            id="snmp_syntax_oid"></a><dl> <dt><b><b>SNMP_SYNTAX_OID</b></b></dt> </dl> </td> <td width="60%"> Indicates an
///            object identifier variable that is an assigned name with a maximum of 128 subidentifiers. </td> </tr> <tr> <td
///            width="40%"><a id="SNMP_SYNTAX_INT32"></a><a id="snmp_syntax_int32"></a><dl>
///            <dt><b><b>SNMP_SYNTAX_INT32</b></b></dt> </dl> </td> <td width="60%"> Indicates a 32-bit signed integer variable.
///            </td> </tr> <tr> <td width="40%"><a id="SNMP_SYNTAX_IPADDR"></a><a id="snmp_syntax_ipaddr"></a><dl>
///            <dt><b><b>SNMP_SYNTAX_IPADDR</b></b></dt> </dl> </td> <td width="60%"> Indicates a 32-bit Internet address
///            variable. If SNMPv1 PDU trap format is used to represent an IPv6 address, this value is 0.0.0.0. </td> </tr> <tr>
///            <td width="40%"><a id="SNMP_SYNTAX_CNTR32"></a><a id="snmp_syntax_cntr32"></a><dl>
///            <dt><b><b>SNMP_SYNTAX_CNTR32</b></b></dt> </dl> </td> <td width="60%"> Indicates a counter variable that
///            increases until it reaches a maximum value of (2^32) – 1. </td> </tr> <tr> <td width="40%"><a
///            id="SNMP_SYNTAX_GAUGE32"></a><a id="snmp_syntax_gauge32"></a><dl> <dt><b><b>SNMP_SYNTAX_GAUGE32</b></b></dt>
///            </dl> </td> <td width="60%"> Indicates a gauge variable that is a non-negative integer that can increase or
///            decrease, but never exceed a maximum value. </td> </tr> <tr> <td width="40%"><a id="SNMP_SYNTAX_TIMETICKS"></a><a
///            id="snmp_syntax_timeticks"></a><dl> <dt><b><b>SNMP_SYNTAX_TIMETICKS</b></b></dt> </dl> </td> <td width="60%">
///            Indicates a counter variable that measures the time in hundredths of a second, until it reaches a maximum value
///            of (2^32) – 1. It is a non-negative integer that is relative to a specific timer event. </td> </tr> <tr> <td
///            width="40%"><a id="SNMP_SYNTAX_OPAQUE"></a><a id="snmp_syntax_opaque"></a><dl>
///            <dt><b><b>SNMP_SYNTAX_OPAQUE</b></b></dt> </dl> </td> <td width="60%"> This type provides backward compatibility,
///            and should not be used for new object types. It supports the capability to pass arbitrary Abstract Syntax
///            Notation One (ASN.1) syntax. </td> </tr> <tr> <td width="40%"><a id="SNMP_SYNTAX_CNTR64"></a><a
///            id="snmp_syntax_cntr64"></a><dl> <dt><b><b>SNMP_SYNTAX_CNTR64</b></b></dt> </dl> </td> <td width="60%"> Indicates
///            a counter variable that increases until it reaches a maximum value of (2^64) – 1. </td> </tr> <tr> <td
///            width="40%"><a id="SNMP_SYNTAX_UINT32"></a><a id="snmp_syntax_uint32"></a><dl>
///            <dt><b><b>SNMP_SYNTAX_UINT32</b></b></dt> </dl> </td> <td width="60%"> Indicates a 32-bit unsigned integer
///            variable. </td> </tr> <tr> <td width="40%"><a id="SNMP_SYNTAX_NOSUCHOBJECT"></a><a
///            id="snmp_syntax_nosuchobject"></a><dl> <dt><b><b>SNMP_SYNTAX_NOSUCHOBJECT</b></b></dt> </dl> </td> <td
///            width="60%"> Indicates that the agent does not support the object type that corresponds to the variable. </td>
///            </tr> <tr> <td width="40%"><a id="SNMP_SYNTAX_NOSUCHINSTANCE"></a><a id="snmp_syntax_nosuchinstance"></a><dl>
///            <dt><b><b>SNMP_SYNTAX_NOSUCHINSTANCE</b></b></dt> </dl> </td> <td width="60%"> Indicates that the object instance
///            does not exist for the operation. </td> </tr> <tr> <td width="40%"><a id="SNMP_SYNTAX_ENDOFMIBVIEW"></a><a
///            id="snmp_syntax_endofmibview"></a><dl> <dt><b><b>SNMP_SYNTAX_ENDOFMIBVIEW</b></b></dt> </dl> </td> <td
///            width="60%"> Indicates the WinSNMP application is attempting to reference an object identifier that is beyond the
///            end of the MIB tree that the agent supports. </td> </tr> </table>
///Returns:
///    If the function succeeds, the return value is SNMPAPI_SUCCESS. If the function fails, the return value is
///    SNMPAPI_FAILURE. To get extended error information, call SnmpGetLastError. The <b>SnmpGetLastError</b> function
///    can return one of the following errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>SNMPAPI_NOT_INITIALIZED</b></dt> </dl> </td> <td width="60%"> The SnmpStartup function
///    did not complete successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>SNMPAPI_ALLOC_ERROR</b></dt> </dl>
///    </td> <td width="60%"> An error occurred during memory allocation. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>SNMPAPI_INDEX_INVALID</b></dt> </dl> </td> <td width="60%"> The <i>index</i> parameter is invalid. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>SNMPAPI_VBL_INVALID</b></dt> </dl> </td> <td width="60%"> The <i>vbl</i>
///    parameter is invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>SNMPAPI_OTHER_ERROR</b></dt> </dl> </td> <td
///    width="60%"> An unknown or undefined error occurred. </td> </tr> </table>
///    
@DllImport("wsnmp32")
uint SnmpGetVb(ptrdiff_t vbl, uint index, smiOID* name, smiVALUE* value);

///<p class="CCE_Message">[SNMP is available for use in the operating systems specified in the Requirements section. It
///may be altered or unavailable in subsequent versions. Instead, use Windows Remote Management, which is the Microsoft
///implementation of WS-Man.] The WinSNMP <b>SnmpSetVb</b> function changes variable binding entries in a variable
///bindings list. This function also appends new variable binding entries to an existing variable bindings list.
///Params:
///    vbl = Handle to the variable bindings list to update.
///    index = Specifies an unsigned long integer variable that contains the position of the variable binding entry, within the
///            variable bindings list, if this is an update operation. If this is an append operation, this parameter must be
///            equal to zero. For more information, see the following Remarks section.
///    name = Pointer to an smiOID structure that represents the name of the variable to append or change. For more
///           information, see the following Remarks section.
///    value = Pointer to an smiVALUE structure. The structure contains the value associated with the variable specified by the
///            <i>name</i> parameter.
///Returns:
///    If the function succeeds, the return value is the position of the updated or appended variable binding entry in
///    the variable bindings list. For additional information, see the following Remarks section. If the function fails,
///    the return value is SNMPAPI_FAILURE. To get extended error information, call SnmpGetLastError. The
///    <b>SnmpGetLastError</b> function can return one of the following errors. <table> <tr> <th>Return code</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>SNMPAPI_NOT_INITIALIZED</b></dt> </dl> </td> <td
///    width="60%"> The SnmpStartup function did not complete successfully. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>SNMPAPI_ALLOC_ERROR</b></dt> </dl> </td> <td width="60%"> An error occurred during memory allocation.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>SNMPAPI_VBL_INVALID</b></dt> </dl> </td> <td width="60%"> The
///    <i>vbl</i> parameter is invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>SNMPAPI_INDEX_INVALID</b></dt>
///    </dl> </td> <td width="60%"> The <i>index</i> parameter is invalid. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>SNMPAPI_OID_INVALID</b></dt> </dl> </td> <td width="60%"> The <i>name</i> parameter is invalid. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>SNMPAPI_SYNTAX_INVALID</b></dt> </dl> </td> <td width="60%"> The
///    <b>syntax</b> member of the structure pointed to by the <i>value</i> parameter is invalid. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>SNMPAPI_OTHER_ERROR</b></dt> </dl> </td> <td width="60%"> An unknown or undefined error
///    occurred. </td> </tr> </table>
///    
@DllImport("wsnmp32")
uint SnmpSetVb(ptrdiff_t vbl, uint index, smiOID* name, smiVALUE* value);

///<p class="CCE_Message">[SNMP is available for use in the operating systems specified in the Requirements section. It
///may be altered or unavailable in subsequent versions. Instead, use Windows Remote Management, which is the Microsoft
///implementation of WS-Man.] The WinSNMP <b>SnmpDeleteVb</b> function removes a variable binding entry from a variable
///bindings list.
///Params:
///    vbl = Handle to the variable bindings list to update.
///    index = Specifies an unsigned long integer variable that identifies the variable binding entry to remove. This variable
///            contains the position of the variable binding entry, within the variable bindings list. Valid values for this
///            parameter are in the range from 1 to n, where 1 indicates the first variable binding entry in the variable
///            bindings list, and n is the total number of entries in the variable bindings list. For additional information,
///            see the following Remarks section.
///Returns:
///    If the function succeeds, the return value is SNMPAPI_SUCCESS. If the function fails, the return value is
///    SNMPAPI_FAILURE. To get extended error information, call SnmpGetLastError. The <b>SnmpGetLastError</b> function
///    can return one of the following errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>SNMPAPI_NOT_INITIALIZED</b></dt> </dl> </td> <td width="60%"> The SnmpStartup function
///    did not complete successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>SNMPAPI_ALLOC_ERROR</b></dt> </dl>
///    </td> <td width="60%"> An error occurred during memory allocation. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>SNMPAPI_INDEX_INVALID</b></dt> </dl> </td> <td width="60%"> The <i>index</i> parameter is invalid. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>SNMPAPI_VBL_INVALID</b></dt> </dl> </td> <td width="60%"> The <i>vbl</i>
///    parameter is invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>SNMPAPI_OTHER_ERROR</b></dt> </dl> </td> <td
///    width="60%"> An unknown or undefined error occurred. </td> </tr> </table>
///    
@DllImport("wsnmp32")
uint SnmpDeleteVb(ptrdiff_t vbl, uint index);

///<p class="CCE_Message">[SNMP is available for use in the operating systems specified in the Requirements section. It
///may be altered or unavailable in subsequent versions. Instead, use Windows Remote Management, which is the Microsoft
///implementation of WS-Man.] The WinSNMP <b>SnmpGetLastError</b> function returns the calling application's last-error
///code value. The value indicates the reason why the last function call executed by the WinSNMP application failed.
///Params:
///    session = Handle to the WinSNMP session. This parameter can also be <b>NULL</b>. In certain cases, when a function call
///              fails you can pass a <b>NULL</b><i>session</i> value to the <b>SnmpGetLastError</b> function to retrieve the
///              last-error code value. This is true for function calls that do not involve a <i>session</i> parameter, and cases
///              in which the <i>session</i> parameter value is invalid. These cases are noted in the Return Values section on the
///              function's reference page. A single-thread application can pass a <b>NULL</b><i>session</i> value to
///              <b>SnmpGetLastError</b> to retrieve last-error information for the entire application. For more information, see
///              the following Remarks and Return Values sections.
///Returns:
///    If the <i>session</i> parameter is a valid WinSNMP session handle, the <b>SnmpGetLastError</b> function returns
///    the last WinSNMP error that occurred for the indicated session. If the <i>session</i> parameter is <b>NULL</b>
///    — for example, if the SnmpStartup function fails, <b>SnmpGetLastError</b> returns the last WinSNMP error that
///    occurred.
///    
@DllImport("wsnmp32")
uint SnmpGetLastError(ptrdiff_t session);

///<p class="CCE_Message">[SNMP is available for use in the operating systems specified in the Requirements section. It
///may be altered or unavailable in subsequent versions. Instead, use Windows Remote Management, which is the Microsoft
///implementation of WS-Man.] The WinSNMP <b>SnmpStrToOid</b> function converts the dotted numeric string format of an
///SNMP object identifier, for example, "1.2.3.4.5.6", to its internal binary representation.
///Params:
///    string = Pointer to a <b>null</b>-terminated object identifier string to convert.
///    dstOID = Pointer to an smiOID structure that receives the converted value.
///Returns:
///    If the function succeeds, the return value is the number of subidentifiers in the converted object identifier.
///    This number is also the value of the <b>len</b> member of the smiOID structure pointed to by the <i>dstOID</i>
///    parameter. If the function fails, the return value is SNMPAPI_FAILURE. To get extended error information, call
///    SnmpGetLastError specifying a <b>NULL</b> value in its <i>session</i> parameter. The <b>SnmpGetLastError</b>
///    function can return one of the following errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>SNMPAPI_NOT_INITIALIZED</b></dt> </dl> </td> <td width="60%"> The SnmpStartup
///    function did not complete successfully. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>SNMPAPI_ALLOC_ERROR</b></dt> </dl> </td> <td width="60%"> An error occurred during memory allocation.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>SNMPAPI_OID_INVALID</b></dt> </dl> </td> <td width="60%"> The
///    <i>string</i> parameter is invalid. For additional information, see the following Remarks section. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>SNMPAPI_OTHER_ERROR</b></dt> </dl> </td> <td width="60%"> An unknown or
///    undefined error occurred. </td> </tr> </table>
///    
@DllImport("wsnmp32")
uint SnmpStrToOid(const(PSTR) string, smiOID* dstOID);

///<p class="CCE_Message">[SNMP is available for use in the operating systems specified in the Requirements section. It
///may be altered or unavailable in subsequent versions. Instead, use Windows Remote Management, which is the Microsoft
///implementation of WS-Man.] The WinSNMP <b>SnmpOidToStr</b> function converts the internal binary representation of an
///SNMP object identifier to its dotted numeric string format, for example, to "1.2.3.4.5.6".
///Params:
///    srcOID = Pointer to an smiOID structure with an object identifier to convert.
///    size = Specifies the size, in bytes, of the buffer indicated by the <i>string</i> parameter. For more information, see
///           the following Remarks section.
///    string = Pointer to a buffer to receive the converted string object identifier that specifies the SNMP management entity.
///Returns:
///    If the function succeeds, the return value is the length, in bytes, of the string that the WinSNMP application
///    writes to the <i>string</i> parameter. The return value includes a <b>null</b>-terminating byte. This value may
///    be less than or equal to the value of the <i>size</i> parameter, but it may not be greater. If the function
///    fails, the return value is SNMPAPI_FAILURE. To get extended error information, call SnmpGetLastError specifying a
///    <b>NULL</b> value in its <i>session</i> parameter. The <b>SnmpGetLastError</b> function can return one of the
///    following errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>SNMPAPI_NOT_INITIALIZED</b></dt> </dl> </td> <td width="60%"> The SnmpStartup function did not complete
///    successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>SNMPAPI_ALLOC_ERROR</b></dt> </dl> </td> <td
///    width="60%"> An error occurred during memory allocation. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>SNMPAPI_SIZE_INVALID</b></dt> </dl> </td> <td width="60%"> The <i>size</i> parameter is invalid. This
///    parameter cannot be equal to zero; it must indicate the size of the buffer pointed to by the <i>string</i>
///    parameter. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>SNMPAPI_OID_INVALID</b></dt> </dl> </td> <td
///    width="60%"> The <i>srcOID</i> parameter is invalid. For additional information, see the following Remarks
///    section. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>SNMPAPI_OUTPUT_TRUNCATED</b></dt> </dl> </td> <td
///    width="60%"> The output buffer length is insufficient. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>SNMPAPI_OTHER_ERROR</b></dt> </dl> </td> <td width="60%"> An unknown or undefined error occurred. </td>
///    </tr> </table>
///    
@DllImport("wsnmp32")
uint SnmpOidToStr(smiOID* srcOID, uint size, PSTR string);

///<p class="CCE_Message">[SNMP is available for use in the operating systems specified in the Requirements section. It
///may be altered or unavailable in subsequent versions. Instead, use Windows Remote Management, which is the Microsoft
///implementation of WS-Man.] The WinSNMP <b>SnmpOidCopy</b> function copies an SNMP object identifier, allocating any
///necessary memory for the copy.
///Params:
///    srcOID = Pointer to an smiOID structure to copy.
///    dstOID = Pointer to an smiOID structure to receive a copy of the object identifier specified by the <i>srcOID</i>
///             parameter.
///Returns:
///    If the function succeeds, the return value is the number of subidentifiers in the copied object identifier. This
///    number is also the value of the <b>len</b> member of the smiOID structure pointed to by the <i>dstOID</i>
///    parameter. If the function fails, the return value is SNMPAPI_FAILURE. To get extended error information, call
///    SnmpGetLastError specifying a <b>NULL</b> value in its <i>session</i> parameter. The <b>SnmpGetLastError</b>
///    function can return one of the following errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>SNMPAPI_NOT_INITIALIZED</b></dt> </dl> </td> <td width="60%"> The SnmpStartup
///    function did not complete successfully. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>SNMPAPI_ALLOC_ERROR</b></dt> </dl> </td> <td width="60%"> An error occurred during memory allocation.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>SNMPAPI_OID_INVALID</b></dt> </dl> </td> <td width="60%"> The
///    <i>srcOID</i> parameter is invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>SNMPAPI_OTHER_ERROR</b></dt>
///    </dl> </td> <td width="60%"> An unknown or undefined error occurred. </td> </tr> </table>
///    
@DllImport("wsnmp32")
uint SnmpOidCopy(smiOID* srcOID, smiOID* dstOID);

///<p class="CCE_Message">[SNMP is available for use in the operating systems specified in the Requirements section. It
///may be altered or unavailable in subsequent versions. Instead, use Windows Remote Management, which is the Microsoft
///implementation of WS-Man.] The WinSNMP <b>SnmpOidCompare</b> function lexicographically compares two SNMP object
///identifiers, up to the length specified by the <i>maxlen</i> parameter.
///Params:
///    xOID = Pointer to the first smiOID object identifier to compare. The length of the object identifier can be zero.
///    yOID = Pointer to the second smiOID object identifier to compare. The length of the object identifier can be zero.
///    maxlen = If not equal to zero, specifies the number of subidentifiers to compare. This parameter must be less than
///             MAXOBJIDSIZE: 128 subidentifiers, the maximum number of components in an object identifier. For additional
///             information, see the following Remarks section.
///    result = Pointer to an integer variable to receive the result of the comparison. The variable can receive one of the
///             following results. <table> <tr> <th>Result</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
///             id="Greater_than_0"></a><a id="greater_than_0"></a><a id="GREATER_THAN_0"></a><dl> <dt><b>Greater than 0</b></dt>
///             </dl> </td> <td width="60%"> <i>xOID</i> is greater than <i>yOID</i> </td> </tr> <tr> <td width="40%"><a
///             id="Equal_to_0"></a><a id="equal_to_0"></a><a id="EQUAL_TO_0"></a><dl> <dt><b>Equal to 0</b></dt> </dl> </td> <td
///             width="60%"> <i>xOID</i> equals <i>yOID</i> </td> </tr> <tr> <td width="40%"><a id="Less_than_0"></a><a
///             id="less_than_0"></a><a id="LESS_THAN_0"></a><dl> <dt><b>Less than 0</b></dt> </dl> </td> <td width="60%">
///             <i>xOID</i> is less than <i>yOID</i> </td> </tr> </table> For additional comparison conditions, see the following
///             Remarks section.
///Returns:
///    If the function succeeds, the return value is SNMPAPI_SUCCESS. If the function fails, the return value is
///    SNMPAPI_FAILURE. To get extended error information, call SnmpGetLastError specifying a <b>NULL</b> value in its
///    <i>session</i> parameter. The <b>SnmpGetLastError</b> function can return one of the following errors. <table>
///    <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>SNMPAPI_NOT_INITIALIZED</b></dt> </dl> </td> <td width="60%"> The SnmpStartup function did not complete
///    successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>SNMPAPI_ALLOC_ERROR</b></dt> </dl> </td> <td
///    width="60%"> An error occurred during memory allocation. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>SNMPAPI_OID_INVALID</b></dt> </dl> </td> <td width="60%"> One or both of the <i>xOID</i> and <i>yOID</i>
///    parameters is invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>SNMPAPI_SIZE_INVALID</b></dt> </dl> </td>
///    <td width="60%"> The <i>maxlen</i> parameter is invalid. The parameter size is greater than MAXOBJIDSIZE. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>SNMPAPI_OTHER_ERROR</b></dt> </dl> </td> <td width="60%"> An unknown or
///    undefined error occurred. </td> </tr> </table>
///    
@DllImport("wsnmp32")
uint SnmpOidCompare(smiOID* xOID, smiOID* yOID, uint maxlen, int* result);

///<p class="CCE_Message">[SNMP is available for use in the operating systems specified in the Requirements section. It
///may be altered or unavailable in subsequent versions. Instead, use Windows Remote Management, which is the Microsoft
///implementation of WS-Man.] The Microsoft WinSNMP implementation uses the parameters passed in the WinSNMP
///<b>SnmpEncodeMsg</b> function to encode an SNMP message. The implementation returns the encoded SNMP message to the
///WinSNMP application in the buffer specified by the <i>msgBufDesc</i> parameter.
///Params:
///    session = Handle to the WinSNMP session.
///    srcEntity = Handle to the management entity that initiates the request to encode the SNMP message.
///    dstEntity = Handle to the target management entity.
///    context = Handle to the context (a set of managed object resources) that the target management entity controls.
///    pdu = Handle to the PDU that contains the SNMP operation request.
///    msgBufDesc = Pointer to an smiOCTETS structure that receives the encoded SNMP message.
///Returns:
///    If the function succeeds, the return value is the length, in bytes, of the encoded SNMP message. This number is
///    also the value of the <b>len</b> member of the smiOCTETS structure pointed to by the <i>msgBufDesc</i> parameter.
///    If the function fails, the return value is SNMPAPI_FAILURE. For additional information, see the following Remarks
///    section. To get extended error information, call SnmpGetLastError. The <b>SnmpGetLastError</b> function can
///    return one of the following errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>SNMPAPI_NOT_INITIALIZED</b></dt> </dl> </td> <td width="60%"> The SnmpStartup function
///    did not complete successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>SNMPAPI_ALLOC_ERROR</b></dt> </dl>
///    </td> <td width="60%"> An error occurred during memory allocation. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>SNMPAPI_SESSION_INVALID</b></dt> </dl> </td> <td width="60%"> The <i>session</i> parameter is invalid.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>SNMPAPI_ENTITY_INVALID</b></dt> </dl> </td> <td width="60%"> One or
///    both of the entity parameters is invalid. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>SNMPAPI_CONTEXT_INVALID</b></dt> </dl> </td> <td width="60%"> The <i>context</i> parameter is invalid.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>SNMPAPI_PDU_INVALID</b></dt> </dl> </td> <td width="60%"> The
///    <i>pdu</i> parameter is invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>SNMPAPI_OTHER_ERROR</b></dt> </dl>
///    </td> <td width="60%"> An unknown or undefined error occurred. </td> </tr> </table>
///    
@DllImport("wsnmp32")
uint SnmpEncodeMsg(ptrdiff_t session, ptrdiff_t srcEntity, ptrdiff_t dstEntity, ptrdiff_t context, ptrdiff_t pdu, 
                   smiOCTETS* msgBufDesc);

///<p class="CCE_Message">[SNMP is available for use in the operating systems specified in the Requirements section. It
///may be altered or unavailable in subsequent versions. Instead, use Windows Remote Management, which is the Microsoft
///implementation of WS-Man.] The WinSNMP <b>SnmpDecodeMsg</b> function decodes an encoded SNMP message into its
///components. This function performs the opposite action of the WinSNMP SnmpEncodeMsg function.
///Params:
///    session = Handle to the WinSNMP session. This parameter is required. For additional information, see the following Remarks
///              section.
///    srcEntity = Pointer to a variable that receives a handle to the source management entity. For more information, see the
///                following Remarks section.
///    dstEntity = Pointer to a variable that receives a handle to the target management entity. For more information, see the
///                following Remarks section.
///    context = Pointer to a variable that receives a handle to the context (a set of managed object resources) that the target
///              management entity controls.
///    pdu = Pointer to a variable that receives a handle to the SNMP protocol data unit (PDU).
///    msgBufDesc = Pointer to an smiOCTETS structure that contains the SNMP message to decode into its components. The <b>len</b>
///                 member of the structure specifies the maximum number of bytes to process; the <b>ptr</b> member points to the
///                 encoded SNMP message.
///Returns:
///    If the function succeeds, the return value is the number of decoded bytes. This value can be equal to, or less
///    than, the <b>len</b> member of the smiOCTETS structure pointed to by the <i>msgBufDesc</i> parameter. If the
///    function fails, the return value is SNMPAPI_FAILURE. To get extended error information, call SnmpGetLastError.
///    The <b>SnmpGetLastError</b> function can return one of the following errors. <table> <tr> <th>Return code</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>SNMPAPI_NOT_INITIALIZED</b></dt> </dl> </td> <td
///    width="60%"> The SnmpStartup function did not complete successfully. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>SNMPAPI_ALLOC_ERROR</b></dt> </dl> </td> <td width="60%"> An error occurred during memory allocation.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>SNMPAPI_SESSION_INVALID</b></dt> </dl> </td> <td width="60%"> The
///    <i>session</i> parameter is invalid. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>SNMPAPI_ENTITY_INVALID</b></dt> </dl> </td> <td width="60%"> One or both of the entity parameters is
///    invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>SNMPAPI_CONTEXT_INVALID</b></dt> </dl> </td> <td
///    width="60%"> The <i>context</i> parameter is invalid. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>SNMPAPI_PDU_INVALID</b></dt> </dl> </td> <td width="60%"> The <i>pdu</i> parameter is invalid. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>SNMPAPI_OUTPUT_TRUNCATED</b></dt> </dl> </td> <td width="60%"> The output
///    buffer length is insufficient. No output parameters were created. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>SNMPAPI_MESSAGE_INVALID</b></dt> </dl> </td> <td width="60%"> The SNMP message format in the buffer
///    indicated by the <i>msgBufDesc</i> parameter is invalid. No output parameters were created. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>SNMPAPI_OTHER_ERROR</b></dt> </dl> </td> <td width="60%"> An unknown or undefined error
///    occurred. </td> </tr> </table>
///    
@DllImport("wsnmp32")
uint SnmpDecodeMsg(ptrdiff_t session, ptrdiff_t* srcEntity, ptrdiff_t* dstEntity, ptrdiff_t* context, 
                   ptrdiff_t* pdu, smiOCTETS* msgBufDesc);

///<p class="CCE_Message">[SNMP is available for use in the operating systems specified in the Requirements section. It
///may be altered or unavailable in subsequent versions. Instead, use Windows Remote Management, which is the Microsoft
///implementation of WS-Man.] A WinSNMP application uses the <b>SnmpFreeDescriptor</b> function to inform the Microsoft
///WinSNMP implementation that it no longer requires access to a descriptor object. This WinSNMP function signals the
///implementation to free the memory it allocated for the descriptor object.
///Params:
///    syntax = Specifies the syntax data type of the target descriptor object.
///    descriptor = Pointer to an <b>smiOPAQUE</b> structure that contains the target descriptor object to release.
///Returns:
///    If the function succeeds, the return value is SNMPAPI_SUCCESS. If the function fails, the return value is
///    SNMPAPI_FAILURE. To get extended error information, call SnmpGetLastError specifying a <b>NULL</b> value in its
///    <i>session</i> parameter. The <b>SnmpGetLastError</b> function can return one of the following errors. <table>
///    <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>SNMPAPI_NOT_INITIALIZED</b></dt> </dl> </td> <td width="60%"> The SnmpStartup function did not complete
///    successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>SNMPAPI_ALLOC_ERROR</b></dt> </dl> </td> <td
///    width="60%"> An error occurred during memory allocation. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>SNMPAPI_SYNTAX_INVALID</b></dt> </dl> </td> <td width="60%"> The <i>syntax</i> parameter is invalid. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>SNMPAPI_OPERATION_INVALID</b></dt> </dl> </td> <td width="60%"> The
///    <i>descriptor</i> parameter is invalid. For additional information, see the following Remarks section. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>SNMPAPI_OTHER_ERROR</b></dt> </dl> </td> <td width="60%"> An unknown or
///    undefined error occurred. </td> </tr> </table>
///    
@DllImport("wsnmp32")
uint SnmpFreeDescriptor(uint syntax, smiOCTETS* descriptor);


