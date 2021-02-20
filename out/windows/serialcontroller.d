// Written in the D programming language.

module windows.serialcontroller;

public import windows.core;
public import windows.systemservices : BOOL;

extern(Windows) @nogc nothrow:


// Structs


struct HCOMDB__
{
    int unused;
}

// Functions

///<b>ComDBOpen</b> returns a handle to the COM port database.
///Params:
///    PHComDB = Pointer, if the routine succeeds, to a handle to the COM port database. Otherwise, the routine sets
///              <i>*PHComDB</i> to <b>HCOMDB_INVALID_HANDLE_VALUE</b>. <i>PHComDB</i> must be non-NULL.
///Returns:
///    <b>ComDBOpen</b> returns one of the following status values. <table> <tr> <th>Return code</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_SUCCESS</b></dt> </dl> </td> <td width="60%">
///    The COM port database was successfully opened. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> The routine could not open the database. To get
///    extended error information, call <b>GetLastError</b>. </td> </tr> </table>
///    
@DllImport("MSPORTS")
int ComDBOpen(HCOMDB__** PHComDB);

///<b>ComDBClose</b> closes a handle to the COM port database.
///Params:
///    HComDB = Handle to the COM port database that was returned by ComDBOpen.
///Returns:
///    <b>ComDBClose</b> returns one of the following status values. <table> <tr> <th>Return code</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_SUCCESS</b></dt> </dl> </td> <td width="60%">
///    The COM port database was closed. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt>
///    </dl> </td> <td width="60%"> The specified COM port database handle is not valid. </td> </tr> </table>
///    
@DllImport("MSPORTS")
int ComDBClose(HCOMDB__* HComDB);

///<b>ComDBGetCurrentPortUsage</b> returns information about the COM port numbers that are currently logged as "in use"
///in the COM port database.
///Params:
///    HComDB = Handle to the COM port database that was returned by ComDBOpen.
///    Buffer = Pointer to a caller-allocated buffer in which the routine returns information about COM port number. See the
///             Remarks section for more information.
///    BufferSize = Specifies the size, in bytes, of a caller-allocated buffer at <i>Buffer</i>.
///    ReportType = Specifies one of the following flags. <table> <tr> <th>Flag</th> <th>Meaning</th> </tr> <tr> <td> CDB_REPORT_BITS
///                 </td> <td> The routine returns a bit array at <i>Buffer</i> that specifies port number usage. </td> </tr> <tr>
///                 <td> CDB_REPORT_BYTES </td> <td> The routine returns a byte array at <i>Buffer</i> that specifies port number
///                 usage. </td> </tr> </table>
///    MaxPortsReported = Pointer to the value that the routine uses to return the number of ports for which the routine returns
///                       information at <i>Buffer</i>. See the Remarks section for more information.
///Returns:
///    <b>ComDBGetCurrentPortUsage</b> returns one of the following status values. <table> <tr> <th>Return code</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_SUCCESS</b></dt> </dl> </td> <td width="60%">
///    The routine successfully returned port number usage information. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> One of the following is true: The specified
///    handle to the COM port database is not valid. Both <i>Buffer</i> and <i>MaxPortsReports</i> are <b>NULL</b>.
///    <i>ReportType</i> is not valid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NOT_CONNECTED</b></dt> </dl>
///    </td> <td width="60%"> The routine could not access the database. To get extended error information, call
///    <b>GetLastError</b>. </td> </tr> </table>
///    
@DllImport("MSPORTS")
int ComDBGetCurrentPortUsage(HCOMDB__* HComDB, ubyte* Buffer, uint BufferSize, uint ReportType, 
                             uint* MaxPortsReported);

///<b>ComDBClaimNextFreePort</b> returns the lowest COM port number that is not already in use.
///Params:
///    HComDB = Handle to the COM port database that is returned by ComDBOpen.
///    ComNumber = Pointer to the COM port number that the routine returns to the caller. This pointer must be non-NULL. A port
///                number is an integer that ranges from 1 to COMDB_MAX_PORTS_ARBITRATED.
///Returns:
///    <b>ComDBClaimNextFreePort</b> returns one of the following status values. <table> <tr> <th>Return code</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_SUCCESS</b></dt> </dl> </td> <td width="60%">
///    The routine successfully returned a COM port number. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_CANTWRITE</b></dt> </dl> </td> <td width="60%"> The routine could not write to the database. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> The
///    specified COM port database handle is not valid. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_NO_LOG_SPACE</b></dt> </dl> </td> <td width="60%"> The database cannot arbitrate any more port
///    numbers. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NOT_CONNECTED</b></dt> </dl> </td> <td width="60%">
///    The routine could not access the database. To get extended error information, call <b>GetLastError</b>. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_Xxx</b></dt> </dl> </td> <td width="60%"> An internal error
///    occurred; call <b>GetLastError</b> to get extended error information. </td> </tr> </table>
///    
@DllImport("MSPORTS")
int ComDBClaimNextFreePort(HCOMDB__* HComDB, uint* ComNumber);

///<b>ComDBClaimPort</b> logs an unused COM port number as "in use" in the COM port database.
///Params:
///    HComDB = Handle to the COM port database that is returned by ComDBOpen.
///    ComNumber = Specifies which COM port number the caller attempts to claim. A port number is an integer that can range from 1
///                to COMDB_MAX_PORTS_ARBITRATED.
///    ForceClaim = Reserved for internal use only.
///    Forced = Reserved for internal use only.
///Returns:
///    <b>ComDBClaimPort</b> returns one of the following status values. <table> <tr> <th>Return code</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_SUCCESS</b></dt> </dl> </td> <td width="60%">
///    The COM port number was not in use and is now logged as "in use". </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_CANTWRITE</b></dt> </dl> </td> <td width="60%"> The routine could not write to the database. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> One of the
///    following is true: The specified handle to the COM port database is not valid. The specified port number is
///    greater than COMDB_MAX_PORTS_ARBITRATED. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_NOT_CONNECTED</b></dt> </dl> </td> <td width="60%"> The routine could not access the database. To
///    get extended error information, call <b>GetLastError</b>. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_SHARING_VIOLATION</b></dt> </dl> </td> <td width="60%"> The specified port number is already in use.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_Xxx</b></dt> </dl> </td> <td width="60%"> An internal error
///    occurred; call <b>GetLastError</b> to get extended error information. </td> </tr> </table>
///    
@DllImport("MSPORTS")
int ComDBClaimPort(HCOMDB__* HComDB, uint ComNumber, BOOL ForceClaim, BOOL* Forced);

///<b>ComDBReleasePort</b> releases a COM port number in the COM port database.
///Params:
///    HComDB = Handle to the COM port database that was returned by ComDBOpen.
///    ComNumber = Specifies the COM port number to release. A port number is an integer that ranges from one to
///                COMDB_MAX_PORTS_ARBITRATED.
///Returns:
///    <b>ComDBReleasePort</b> returns one of the following status values. <table> <tr> <th>Return code</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_SUCCESS</b></dt> </dl> </td> <td width="60%">
///    The COM port number was released. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_CANTWRITE</b></dt> </dl>
///    </td> <td width="60%"> The routine could not write to the database. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> One of the following is true: The specified
///    handle to the COM port database is not valid. The specified port number is not in the COM port database. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NOT_CONNECTED</b></dt> </dl> </td> <td width="60%"> The routine
///    could not access the database. To get extended error information, call <b>GetLastError</b>. </td> </tr> </table>
///    
@DllImport("MSPORTS")
int ComDBReleasePort(HCOMDB__* HComDB, uint ComNumber);

///<b>ComDBResizeDatabase</b> resizes the COM port database.
///Params:
///    HComDB = Handle to the COM port database that was returned by ComDBOpen.
///    NewSize = Specifies a new size for the COM port database, where the database size is the number of port numbers currently
///              arbitrated in the database. This value must be an integer multiple of 1024, must be greater than the current
///              size, and must be less than or equal to COMDB_MAX_PORTS_ARBITRATED.
///Returns:
///    <b>ComDBResizeDatabase</b> returns one of the following status values. <table> <tr> <th>Return code</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_SUCCESS</b></dt> </dl> </td> <td width="60%">
///    The database was successfully resized. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_BAD_LENGTH</b></dt>
///    </dl> </td> <td width="60%"> <i>NewSize</i> is less than or equal to the current database size, or it is greater
///    than COMDB_MAX_PORTS_ARBITRATED. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_CANTWRITE</b></dt> </dl>
///    </td> <td width="60%"> The routine could not write to the database. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> One of the following is true: The specified
///    handle to the COM port database is not valid. <i>NewSize</i> is not a multiple of 1024. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_NOT_CONNECTED</b></dt> </dl> </td> <td width="60%"> The routine could not access
///    the database. To get extended error information, call <b>GetLastError</b>. </td> </tr> </table>
///    
@DllImport("MSPORTS")
int ComDBResizeDatabase(HCOMDB__* HComDB, uint NewSize);


