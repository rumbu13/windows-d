// Written in the D programming language.

module windows.tpmbaseservices;

public import windows.core;
public import windows.com : HRESULT;

extern(Windows):


// Structs


///Specifies the version of the TBS context implementation. To connect to TBS, the client must run as administrator. TBS
///also limits access to locality ZERO.
struct TBS_CONTEXT_PARAMS
{
    uint version_;
}

///Specifies the version of the TBS context implementation. You must use this structure if your application works with
///both versions of TPM. Applications interacting with just TPM 2.0 should pass a pointer to a
///<b>TBS_CONTEXT_PARAMS2</b> structure, with <b>version</b> set to TPM_VERSION_20, and <b>includeTpm20</b> set to 1.
///Applications interacting with both TPM 1.2 and TPM 2.0 should pass a pointer to a <b>TBS_CONTEXT_PARAMS2</b>
///structure, with <b>version</b> set to TPM_VERSION_20, <b>includeTpm20</b> set to 1, and <b>includeTpm12</b> set to 1.
struct TBS_CONTEXT_PARAMS2
{
    ///The version of the TBS context implementation. This must be set to TPM_VERSION_20.
    uint version_;
    union
    {
        struct
        {
            uint _bitfield174;
        }
        uint asUINT32;
    }
}

struct tdTPM_WNF_PROVISIONING
{
    uint      status;
    ubyte[28] message;
}

///Provides information about the version of the TPM.
struct TPM_DEVICE_INFO
{
    ///The version of the TBS context implementation. This parameter must be set to TPM_VERSION_20.
    uint structVersion;
    ///TPM version. Will be set to TPM_VERSION_12 or TPM_VERSION_20.
    uint tpmVersion;
    ///Reserved
    uint tpmInterfaceType;
    uint tpmImpRevision;
}

// Functions

///Creates a context handle that can be used to pass commands to TBS.
///Params:
///    pContextParams = A parameter to a [TBS_CONTEXT_PARAMS](./ns-tbs-tbs_context_params.md) structure that contains the parameters
///                     associated with the context.
///    phContext = A pointer to a location to store the new context handle.
///Returns:
///    If the function succeeds, the function returns TBS_SUCCESS. If the function fails, it returns a TBS return code
///    that indicates the error. <table> <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>TBS_SUCCESS</b></dt> <dt>0 (0x0)</dt> </dl> </td> <td width="60%"> The function was
///    successful. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>TBS_E_BAD_PARAMETER</b></dt> <dt>2150121474
///    (0x80284002)</dt> </dl> </td> <td width="60%"> One or more parameter values are not valid. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>TBS_E_INTERNAL_ERROR</b></dt> <dt>2150121473 (0x80284001)</dt> </dl> </td> <td
///    width="60%"> An internal software error occurred. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>TBS_E_INVALID_CONTEXT_PARAM</b></dt> <dt>2150121479 (0x80284007)</dt> </dl> </td> <td width="60%"> A
///    context parameter that is not valid was passed when attempting to create a TBS context. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>TBS_E_INVALID_OUTPUT_POINTER</b></dt> <dt>2150121475 (0x80284003)</dt> </dl> </td> <td
///    width="60%"> A specified output pointer is not valid. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>TBS_E_SERVICE_DISABLED</b></dt> <dt>2150121488 (0x80284010)</dt> </dl> </td> <td width="60%"> The TBS
///    service has been disabled. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>TBS_E_SERVICE_NOT_RUNNING</b></dt>
///    <dt>2150121480 (0x80284008)</dt> </dl> </td> <td width="60%"> The TBS service is not running and could not be
///    started. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>TBS_E_SERVICE_START_PENDING</b></dt> <dt>2150121483
///    (0x8028400B)</dt> </dl> </td> <td width="60%"> The TBS service has been started but is not yet running. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>TBS_E_TOO_MANY_TBS_CONTEXTS</b></dt> <dt>2150121481 (0x80284009)</dt>
///    </dl> </td> <td width="60%"> A new context could not be created because there are too many open contexts. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>TBS_E_TPM_NOT_FOUND</b></dt> <dt>2150121487 (0x8028400F)</dt> </dl> </td>
///    <td width="60%"> A compatible Trusted Platform Module (TPM) Security Device cannot be found on this computer.
///    </td> </tr> </table>
///    
@DllImport("tbs")
uint Tbsi_Context_Create(TBS_CONTEXT_PARAMS* pContextParams, void** phContext);

///Closes a context handle, which releases resources associated with the context in TBS and closes the binding handle
///used to communicate with TBS.
///Params:
///    hContext = A handle of the context to be closed.
///Returns:
///    If the function succeeds, the function returns TBS_SUCCESS. If the function fails, it returns a TBS return code
///    that indicates the error. <table> <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>TBS_SUCCESS</b></dt> <dt>0 (0x0)</dt> </dl> </td> <td width="60%"> The function was
///    successful. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>TBS_E_INTERNAL_ERROR</b></dt> <dt>2150121473
///    (0x80284001)</dt> </dl> </td> <td width="60%"> An internal software error occurred. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>TBS_E_INVALID_CONTEXT</b></dt> <dt>2150121476 (0x80284004)</dt> </dl> </td> <td
///    width="60%"> The specified context handle does not refer to a valid context. </td> </tr> </table>
///    
@DllImport("tbs")
uint Tbsip_Context_Close(void* hContext);

///Submits a Trusted Platform Module (TPM) command to TPM Base Services (TBS) for processing.
///Params:
///    hContext = The handle of the context that is submitting the command.
///    Locality = Used to set the locality for the TPM command. This must be one of the following values. <table> <tr>
///               <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="TBS_COMMAND_LOCALITY_ZERO"></a><a
///               id="tbs_command_locality_zero"></a><dl> <dt><b>TBS_COMMAND_LOCALITY_ZERO</b></dt> <dt>0 (0x0)</dt> </dl> </td>
///               <td width="60%"> Locality zero. This is the only locality currently supported. </td> </tr> <tr> <td
///               width="40%"><a id="TBS_COMMAND_LOCALITY_ONE"></a><a id="tbs_command_locality_one"></a><dl>
///               <dt><b>TBS_COMMAND_LOCALITY_ONE</b></dt> <dt>1 (0x1)</dt> </dl> </td> <td width="60%"> Locality one. </td> </tr>
///               <tr> <td width="40%"><a id="TBS_COMMAND_LOCALITY_TWO"></a><a id="tbs_command_locality_two"></a><dl>
///               <dt><b>TBS_COMMAND_LOCALITY_TWO</b></dt> <dt>2 (0x2)</dt> </dl> </td> <td width="60%"> Locality two. </td> </tr>
///               <tr> <td width="40%"><a id="TBS_COMMAND_LOCALITY_THREE"></a><a id="tbs_command_locality_three"></a><dl>
///               <dt><b>TBS_COMMAND_LOCALITY_THREE</b></dt> <dt>3 (0x3)</dt> </dl> </td> <td width="60%"> Locality three. </td>
///               </tr> <tr> <td width="40%"><a id="TBS_COMMAND_LOCALITY_FOUR"></a><a id="tbs_command_locality_four"></a><dl>
///               <dt><b>TBS_COMMAND_LOCALITY_FOUR</b></dt> <dt>4 (0x4)</dt> </dl> </td> <td width="60%"> Locality four. </td>
///               </tr> </table>
///    Priority = The priority level that the command should have. This parameter can be one of the following values. <table> <tr>
///               <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="TBS_COMMAND_PRIORITY_LOW"></a><a
///               id="tbs_command_priority_low"></a><dl> <dt><b>TBS_COMMAND_PRIORITY_LOW</b></dt> <dt>100 (0x64)</dt> </dl> </td>
///               <td width="60%"> Used for low priority application use. </td> </tr> <tr> <td width="40%"><a
///               id="TBS_COMMAND_PRIORITY_NORMAL"></a><a id="tbs_command_priority_normal"></a><dl>
///               <dt><b>TBS_COMMAND_PRIORITY_NORMAL</b></dt> <dt>200 (0xC8)</dt> </dl> </td> <td width="60%"> Used for normal
///               priority application use. </td> </tr> <tr> <td width="40%"><a id="TBS_COMMAND_PRIORITY_SYSTEM"></a><a
///               id="tbs_command_priority_system"></a><dl> <dt><b>TBS_COMMAND_PRIORITY_SYSTEM</b></dt> <dt>400 (0x190)</dt> </dl>
///               </td> <td width="60%"> Used for system tasks that access the TPM. </td> </tr> <tr> <td width="40%"><a
///               id="TBS_COMMAND_PRIORITY_HIGH"></a><a id="tbs_command_priority_high"></a><dl>
///               <dt><b>TBS_COMMAND_PRIORITY_HIGH</b></dt> <dt>300 (0x12C)</dt> </dl> </td> <td width="60%"> Used for high
///               priority application use. </td> </tr> <tr> <td width="40%"><a id="TBS_COMMAND_PRIORITY_MAX"></a><a
///               id="tbs_command_priority_max"></a><dl> <dt><b>TBS_COMMAND_PRIORITY_MAX</b></dt> <dt>2147483648 (0x80000000)</dt>
///               </dl> </td> <td width="60%"> Used for tasks that originate from the power management system. </td> </tr> </table>
///    pabCommand = A pointer to a buffer that contains the TPM command to process.
///    cbCommand = The length, in bytes, of the command.
///    pabResult = A pointer to a buffer to receive the result of the TPM command. This buffer can be the same as <i>pabCommand</i>.
///    pcbResult = An integer that, on input, specifies the size, in bytes, of the result buffer. This value is set when the submit
///                command returns. If the supplied buffer is too small, this parameter, on output, is set to the required size, in
///                bytes, for the result.
@DllImport("tbs")
uint Tbsip_Submit_Command(void* hContext, uint Locality, uint Priority, char* pabCommand, uint cbCommand, 
                          char* pabResult, uint* pcbResult);

///Cancels all outstanding commands for the specified context.
///Params:
///    hContext = A TBS handle to the context whose commands are to be canceled and that was obtained from previous call to the
///               Tbsi_Context_Create function.
///Returns:
///    If the function succeeds, the function returns TBS_SUCCESS. If the function fails, it returns a TBS return code
///    that indicates the error. <table> <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>TBS_SUCCESS</b></dt> <dt>0 (0x0)</dt> </dl> </td> <td width="60%"> The function was
///    successful. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>TBS_E_INTERNAL_ERROR</b></dt> <dt>2150121473
///    (0x80284001)</dt> </dl> </td> <td width="60%"> An internal software error occurred. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>TBS_E_INVALID_CONTEXT</b></dt> <dt>2150121476 (0x80284004)</dt> </dl> </td> <td
///    width="60%"> The specified context handle does not refer to a valid context. </td> </tr> <tr> <td width="40%">
///    <dl> <dt><b>TBS_E_IOERROR</b></dt> <dt>2150121478 (0x80284006)</dt> </dl> </td> <td width="60%"> An error
///    occurred while communicating with the TPM. </td> </tr> </table>
///    
@DllImport("tbs")
uint Tbsip_Cancel_Commands(void* hContext);

///Passes a physical presence ACPI command through TBS to the driver.
///Params:
///    hContext = The context of the ACPI command.
///    pabInput = A pointer to a buffer that contains the input to the ACPI command. The input to the ACPI command is defined in
///               the TCG Physical Presence Interface Specification at https://www.trustedcomputinggroup.org/specs/PCClient. The
///               buffer should contain <i>Arg2</i> and <i>Arg3</i> values as defined in this document. The values for <i>Arg0</i>
///               and <i>Arg1</i> are static and automatically added. For example, if this method is used for Get Physical Presence
///               Interface Version, then <i>Arg2</i> is the integer value 1 and <i>Arg3</i> is empty, so the buffer should just
///               contain an integer value of 1. If this method is used for "Submit TPM Operation Request to Pre-OS Environment",
///               then <i>Arg2</i> is the integer value 2 and <i>Arg3</i> will be the integer for the specified operation, such as
///               1 for enable or 2 for disable.
///    cbInput = The length, in bytes, of the input buffer.
///    pabOutput = A pointer to a buffer to contain the output of the ACPI command. The buffer will contain the return value from
///                the command as defined in the TCG Physical Presence Interface Specification.
///    pcbOutput = A pointer to an unsigned long integer that, on input, specifies the size, in bytes, of the output buffer. If the
///                function succeeds, this parameter, on output, receives the size, in bytes, of the data pointed to by
///                <i>pabOutput</i>. If the function fails, this parameter does not receive a value.
///Returns:
///    If the function succeeds, the function returns TBS_SUCCESS. If the function fails, it returns a TBS return code
///    that indicates the error. <table> <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>TBS_SUCCESS</b></dt> <dt>0 (0x0)</dt> </dl> </td> <td width="60%"> The function was
///    successful. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>TBS_E_BAD_PARAMETER</b></dt> <dt>2150121474
///    (0x80284002)</dt> </dl> </td> <td width="60%"> One or more parameter values are not valid. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>TBS_E_INTERNAL_ERROR</b></dt> <dt>2150121473 (0x80284001)</dt> </dl> </td> <td
///    width="60%"> An internal software error occurred. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>TBS_E_INVALID_CONTEXT_PARAM</b></dt> <dt>2150121479 (0x80284007)</dt> </dl> </td> <td width="60%"> A
///    context parameter that is not valid was passed when attempting to create a TBS context. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>TBS_E_INVALID_OUTPUT_POINTER</b></dt> <dt>2150121475 (0x80284003)</dt> </dl> </td> <td
///    width="60%"> A specified output pointer is not valid. </td> </tr> </table>
///    
@DllImport("tbs")
uint Tbsi_Physical_Presence_Command(void* hContext, char* pabInput, uint cbInput, char* pabOutput, uint* pcbOutput);

///Retrieves the most recent Windows Boot Configuration Log (WBCL), also referred to as a TCG log.
///Params:
///    hContext = The TBS handle of the context that is retrieving the log. You get this parameter from a previous call to the
///               Tbsi_Context_Create function.
///    pOutputBuf = A pointer to a buffer to receive and store the WBCL. This parameter may be NULL to estimate the required buffer
///                 when the location pointed to by <i>pcbOutput</i> is also 0 on input.
///    pOutputBufLen = A pointer to an unsigned long integer that, on input, specifies the size, in bytes, of the output buffer. If the
///                    function succeeds, this parameter, on output, receives the size, in bytes, of the data pointed to by
///                    <i>pOutputBuf</i>. If the function fails, this parameter does not receive a value. Calling the
///                    <b>Tbsi_Get_TCG_Log</b> function with a zero length buffer will return the size of the buffer required.
///                    <b>Windows Vista with SP1 and Windows Server 2008: </b>This functionality is not available.
///Returns:
///    <table> <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>TBS_SUCCESS</b></dt> <dt>0 (0x0)</dt> </dl> </td> <td width="60%"> The function succeeded. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>TBS_E_INTERNAL_ERROR</b></dt> <dt>2150121473 (0x80284001)</dt> </dl> </td> <td
///    width="60%"> An internal software error occurred. <div class="alert"><b>Note</b> If TBS_E_INTERNAL_ERROR is
///    returned, the system event log may contain event ID 16385 from the TBS event source with error code 0x80070032.
///    This may indicate that the hardware platform does not provide a TCG event log to the operating system. Sometimes
///    this can be resolved by installing a BIOS upgrade from the platform manufacturer.</div> <div> </div> </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>TBS_E_INVALID_OUTPUT_POINTER</b></dt> <dt>2150121475 (0x80284003)</dt> </dl>
///    </td> <td width="60%"> A specified output pointer is not valid. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>TBS_E_INVALID_CONTEXT</b></dt> <dt>2150121476 (0x80284004)</dt> </dl> </td> <td width="60%"> The specified
///    context handle does not refer to a valid context. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>TBS_E_INSUFFICIENT_BUFFER</b></dt> <dt>2150121477 (0x80284005)</dt> </dl> </td> <td width="60%"> The
///    output buffer is too small. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>TBS_E_BUFFER_TOO_LARGE</b></dt>
///    <dt>2150121486 (0x8028400E)</dt> </dl> </td> <td width="60%"> The output buffer is too large. </td> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>TBS_E_TPM_NOT_FOUND</b></dt> <dt>2150121487 (0x8028400F)</dt> </dl> </td> <td
///    width="60%"> A compatible Trusted Platform Module (TPM) Security Device cannot be found on this computer. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>TBS_E_DEACTIVATED</b></dt> <dt>2150121494 (0x80284016)</dt> </dl> </td>
///    <td width="60%"> The Trusted Platform Module (TPM) Security Device is deactivated. <b>Windows Vista with SP1 and
///    Windows Server 2008: </b>This return value is not available. </td> </tr> </table>
///    
@DllImport("tbs")
uint Tbsi_Get_TCG_Log(void* hContext, char* pOutputBuf, uint* pOutputBufLen);

///Obtains the version of the TPM on the computer.
///Params:
///    Size = Size of the memory location.
///    Info = A pointer to a TPM_DEVICE_INFO structure is returned containing the version information about the TPM. The
///           location must be large enough to hold four 32-bit values.
@DllImport("tbs")
uint Tbsi_GetDeviceInfo(uint Size, char* Info);

///Retrieves the owner authorization of the TPM if the information is available in the local registry.
///Params:
///    hContext = TBS handle obtained from a previous call to the Tbsi_Context_Create function.
///    ownerauthType = Unsigned 32-bit integer indicating the type of owner authentication. <table> <tr> <th>Value</th> <th>Meaning</th>
///                    </tr> <tr> <td width="40%"><a id="TBS_OWNERAUTH_TYPE_FULL"></a><a id="tbs_ownerauth_type_full"></a><dl>
///                    <dt><b>TBS_OWNERAUTH_TYPE_FULL</b></dt> <dt>1</dt> </dl> </td> <td width="60%"> The owner authorization is full.
///                    </td> </tr> <tr> <td width="40%"><a id="TBS_OWNERAUTH_TYPE_ADMIN"></a><a id="tbs_ownerauth_type_admin"></a><dl>
///                    <dt><b>TBS_OWNERAUTH_TYPE_ADMIN</b></dt> <dt>2</dt> </dl> </td> <td width="60%"> <b>Note</b> TPM 1.2 only The
///                    owner authorization is an administrator. </td> </tr> <tr> <td width="40%"><a id="TBS_OWNERAUTH_TYPE_USER"></a><a
///                    id="tbs_ownerauth_type_user"></a><dl> <dt><b>TBS_OWNERAUTH_TYPE_USER</b></dt> <dt>3</dt> </dl> </td> <td
///                    width="60%"> <b>Note</b> TPM 1.2 only The owner authorization is a user. </td> </tr> <tr> <td width="40%"><a
///                    id="TBS_OWNERAUTH_TYPE_ENDORSEMENT"></a><a id="tbs_ownerauth_type_endorsement"></a><dl>
///                    <dt><b>TBS_OWNERAUTH_TYPE_ENDORSEMENT</b></dt> <dt>4</dt> </dl> </td> <td width="60%"> <b>Note</b> TPM 1.2 only
///                    The owner authorization is an endorsement authorization. </td> </tr> <tr> <td width="40%"><a
///                    id="TBS_OWNERAUTH_TYPE_ENDORSEMENT_20_"></a><a id="tbs_ownerauth_type_endorsement_20_"></a><dl>
///                    <dt><b>TBS_OWNERAUTH_TYPE_ENDORSEMENT_20 </b></dt> <dt>12</dt> </dl> </td> <td width="60%"> <b>Note</b> TPM 2.0
///                    and later The owner authorization is an endorsement authorization. </td> </tr> <tr> <td width="40%"><a
///                    id="TBS_OWNERAUTH_TYPE_STORAGE_20_"></a><a id="tbs_ownerauth_type_storage_20_"></a><dl>
///                    <dt><b>TBS_OWNERAUTH_TYPE_STORAGE_20 </b></dt> <dt>13</dt> </dl> </td> <td width="60%"> <b>Note</b> TPM 2.0 and
///                    later The owner authorization is an administrator. </td> </tr> </table>
///    pOutputBuf = A pointer to a buffer to receive the TPM owner authorization information.
///    pOutputBufLen = An integer that, on input, specifies the size, in bytes, of the output buffer. On successful return, this value
///                    is set to the actual size of the TPM ownerAuth, in bytes.
///Returns:
///    If the function succeeds, the function returns <b>TBS_SUCCESS</b>. If the function fails, it returns a TBS return
///    code that indicates the error. <table> <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>TBS_SUCCESS</b></dt> <dt>0 (0x0)</dt> </dl> </td> <td width="60%"> The function was
///    successful. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>TBS_E_OWNERAUTH_NOT_FOUND</b></dt> <dt>2150121493
///    (0x80284015)</dt> </dl> </td> <td width="60%"> The requested TPM ownerAuth value was not found. </td> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>TBS_E_BAD_PARAMETER</b></dt> <dt>2150121474 (0x80284002)</dt> </dl> </td> <td
///    width="60%"> The requested TPM ownerAuth value does not match the TPM version. </td> </tr> </table>
///    
@DllImport("tbs")
uint Tbsi_Get_OwnerAuth(void* hContext, uint ownerauthType, char* pOutputBuf, uint* pOutputBufLen);

///Invalidates the PCRs if the ELAM driver detects a policy-violation (a rootkit, for example).
///Returns:
///    <table> <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>TBS_SUCCESS</b></dt> <dt>0 (0x0)</dt> </dl> </td> <td width="60%"> The function succeeded. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>TBS_E_INTERNAL_ERROR</b></dt> <dt>2150121473 (0x80284001)</dt> </dl> </td> <td
///    width="60%"> An internal software error occurred. <div class="alert"><b>Note</b> If TBS_E_INTERNAL_ERROR is
///    returned, the system event log may contain event ID 16385 from the TBS event source with error code 0x80070032.
///    This may indicate that the hardware platform does not provide a TCG event log to the operating system. Sometimes
///    this can be resolved by installing a BIOS upgrade from the platform manufacturer.</div> <div> </div> </td> </tr>
///    </table>
///    
@DllImport("tbs")
uint Tbsi_Revoke_Attestation();

@DllImport("DSOUND")
HRESULT GetDeviceID(char* pbWindowsAIK, uint cbWindowsAIK, uint* pcbResult, int* pfProtectedByTPM);

@DllImport("tbs")
HRESULT GetDeviceIDString(const(wchar)* pszWindowsAIK, uint cchWindowsAIK, uint* pcchResult, int* pfProtectedByTPM);

@DllImport("tbs")
uint Tbsi_Create_Windows_Key(uint keyHandle);

///Gets the Windows Boot Configuration Log (WBCL), also referred to as the TCG log, of the specified type.
///Params:
///    logType = The type of log to retrieve. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
///              id="TBS_TCGLOG_SRTM_CURRENT"></a><a id="tbs_tcglog_srtm_current"></a><dl> <dt><b>TBS_TCGLOG_SRTM_CURRENT</b></dt>
///              <dt>0</dt> </dl> </td> <td width="60%"> The log associated with PCRs 0-15 for the current session (boot or
///              resume). </td> </tr> <tr> <td width="40%"><a id="TBS_TCGLOG_DRTM_CURRENT"></a><a
///              id="tbs_tcglog_drtm_current"></a><dl> <dt><b>TBS_TCGLOG_DRTM_CURRENT</b></dt> <dt>1</dt> </dl> </td> <td
///              width="60%"> The log associated with PCRs 17-22 for the current session (boot or resume). </td> </tr> <tr> <td
///              width="40%"><a id="TBS_TCGLOG_SRTM_BOOT"></a><a id="tbs_tcglog_srtm_boot"></a><dl>
///              <dt><b>TBS_TCGLOG_SRTM_BOOT</b></dt> <dt>2</dt> </dl> </td> <td width="60%"> The log associated with PCRs 0-15
///              for the most recent clean boot session. </td> </tr> <tr> <td width="40%"><a id="TBS_TCGLOG_SRTM_RESUME"></a><a
///              id="tbs_tcglog_srtm_resume"></a><dl> <dt><b>TBS_TCGLOG_SRTM_RESUME</b></dt> <dt>3</dt> </dl> </td> <td
///              width="60%"> The log associated with PCRs 0-15 for the most recent resume from hibernation. </td> </tr> </table>
///    pbOutput = Pointer to a buffer that receives and stores the WBCL. Set to <b>NULL</b> to estimate the required buffer when
///               the location pointed to by <i>pcbOutput</i> is also 0 on input.
///    pcbOutput = Pointer to an unsigned long integer that specifies the size, in bytes, of the output buffer. On success, contains
///                the size, in bytes, of the data pointed to by <i>pOutput</i>. On failure, does not contain a value. <b>Note</b>
///                If <i>pbOutput</i> is <b>NULL</b> and the location pointed to by <i>pcbOutput</i> is 0, the function returns
///                <b>TBS_E_BUFFER_TOO_SMALL</b>. In that case, <i>pcbOutput</i> will point to the required size of <i>pbOutput</i>.
///Returns:
///    <table> <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>TBS_SUCCESS</b></dt> <dt>0 (0x0)</dt> </dl> </td> <td width="60%"> The function succeeded. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>TBS_E_NO_EVENT_LOG</b></dt> <dt>1 (0x1)</dt> </dl> </td> <td width="60%">
///    <b>TBS_TCGLOG_DRTM_CURRENT</b> was requested but DRTM was not enabled on the system when the system booted. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>TBS_E_INTERNAL_ERROR</b></dt> <dt>2150121473 (0x80284001)</dt> </dl>
///    </td> <td width="60%"> An internal software error occurred. <div class="alert"><b>Note</b> If
///    <b>TBS_E_INTERNAL_ERROR</b> is returned, the system event log may contain event ID 16385 from the TBS event
///    source with error code 0x80070032. This may indicate that the hardware platform does not provide a TCG event log
///    to the operating system. Sometimes this can be resolved by installing a BIOS upgrade from the platform
///    manufacturer.</div> <div> </div> </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>TBS_E_INVALID_OUTPUT_POINTER</b></dt> <dt>2150121475 (0x80284003)</dt> </dl> </td> <td width="60%"> A
///    specified output pointer is not valid. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>TBS_E_INSUFFICIENT_BUFFER</b></dt> <dt>2150121477 (0x80284005)</dt> </dl> </td> <td width="60%"> The
///    output buffer is too small. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>TBS_E_BUFFER_TOO_LARGE</b></dt>
///    <dt>2150121486 (0x8028400E)</dt> </dl> </td> <td width="60%"> The output buffer is too large. </td> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>TBS_E_TPM_NOT_FOUND</b></dt> <dt>2150121487 (0x8028400F)</dt> </dl> </td> <td
///    width="60%"> A compatible Trusted Platform Module (TPM) Security Device cannot be found on this computer. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>TBS_E_DEACTIVATED</b></dt> <dt>2150121494 (0x80284016)</dt> </dl> </td>
///    <td width="60%"> The Trusted Platform Module (TPM) Security Device is deactivated. </td> </tr> </table>
///    
@DllImport("tbs")
uint Tbsi_Get_TCG_Log_Ex(uint logType, char* pbOutput, uint* pcbOutput);


