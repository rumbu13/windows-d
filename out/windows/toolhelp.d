// Written in the D programming language.

module windows.toolhelp;

public import windows.core;
public import windows.systemservices : BOOL, HANDLE;

extern(Windows) @nogc nothrow:


// Structs


///Describes an entry from a list that enumerates the heaps used by a specified process.
struct HEAPLIST32
{
    ///The size of the structure, in bytes. Before calling the Heap32ListFirst function, set this member to
    ///<code>sizeof(HEAPLIST32)</code>. If you do not initialize <b>dwSize</b>, <b>Heap32ListFirst</b> will fail.
    size_t dwSize;
    ///The identifier of the process to be examined.
    uint   th32ProcessID;
    ///The heap identifier. This is not a handle, and has meaning only to the tool help functions.
    size_t th32HeapID;
    ///This member can be one of the following values. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td
    ///width="40%"><a id="HF32_DEFAULT"></a><a id="hf32_default"></a><dl> <dt><b>HF32_DEFAULT</b></dt> </dl> </td> <td
    ///width="60%"> Process's default heap </td> </tr> </table>
    uint   dwFlags;
}

///Describes one entry (block) of a heap that is being examined.
struct HEAPENTRY32
{
    ///The size of the structure, in bytes. Before calling the Heap32First function, set this member to
    ///<code>sizeof(HEAPENTRY32)</code>. If you do not initialize <b>dwSize</b>, <b>Heap32First</b> fails.
    size_t dwSize;
    ///A handle to the heap block.
    HANDLE hHandle;
    ///The linear address of the start of the block.
    size_t dwAddress;
    ///The size of the heap block, in bytes.
    size_t dwBlockSize;
    ///This member can be one of the following values. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td
    ///width="40%"><a id="LF32_FIXED"></a><a id="lf32_fixed"></a><dl> <dt><b>LF32_FIXED</b></dt> </dl> </td> <td
    ///width="60%"> The memory block has a fixed (unmovable) location. </td> </tr> <tr> <td width="40%"><a
    ///id="LF32_FREE"></a><a id="lf32_free"></a><dl> <dt><b>LF32_FREE</b></dt> </dl> </td> <td width="60%"> The memory
    ///block is not used. </td> </tr> <tr> <td width="40%"><a id="LF32_MOVEABLE"></a><a id="lf32_moveable"></a><dl>
    ///<dt><b>LF32_MOVEABLE</b></dt> </dl> </td> <td width="60%"> The memory block location can be moved. </td> </tr>
    ///</table>
    uint   dwFlags;
    ///This member is no longer used and is always set to zero.
    uint   dwLockCount;
    ///Reserved; do not use or alter.
    uint   dwResvd;
    ///The identifier of the process that uses the heap.
    uint   th32ProcessID;
    ///The heap identifier. This is not a handle, and has meaning only to the tool help functions.
    size_t th32HeapID;
}

///Describes an entry from a list of the processes residing in the system address space when a snapshot was taken.
struct PROCESSENTRY32W
{
    ///The size of the structure, in bytes. Before calling the Process32First function, set this member to
    ///<code>sizeof(PROCESSENTRY32)</code>. If you do not initialize <b>dwSize</b>, <b>Process32First</b> fails.
    uint        dwSize;
    ///This member is no longer used and is always set to zero.
    uint        cntUsage;
    ///The process identifier.
    uint        th32ProcessID;
    ///This member is no longer used and is always set to zero.
    size_t      th32DefaultHeapID;
    ///This member is no longer used and is always set to zero.
    uint        th32ModuleID;
    ///The number of execution threads started by the process.
    uint        cntThreads;
    ///The identifier of the process that created this process (its parent process).
    uint        th32ParentProcessID;
    ///The base priority of any threads created by this process.
    int         pcPriClassBase;
    ///This member is no longer used, and is always set to zero.
    uint        dwFlags;
    ///The name of the executable file for the process. To retrieve the full path to the executable file, call the
    ///Module32First function and check the <b>szExePath</b> member of the MODULEENTRY32 structure that is returned.
    ///However, if the calling process is a 32-bit process, you must call the QueryFullProcessImageName function to
    ///retrieve the full path of the executable file for a 64-bit process.
    ushort[260] szExeFile;
}

///Describes an entry from a list of the processes residing in the system address space when a snapshot was taken.
struct PROCESSENTRY32
{
    ///The size of the structure, in bytes. Before calling the Process32First function, set this member to
    ///<code>sizeof(PROCESSENTRY32)</code>. If you do not initialize <b>dwSize</b>, <b>Process32First</b> fails.
    uint      dwSize;
    ///This member is no longer used and is always set to zero.
    uint      cntUsage;
    ///The process identifier.
    uint      th32ProcessID;
    ///This member is no longer used and is always set to zero.
    size_t    th32DefaultHeapID;
    ///This member is no longer used and is always set to zero.
    uint      th32ModuleID;
    ///The number of execution threads started by the process.
    uint      cntThreads;
    ///The identifier of the process that created this process (its parent process).
    uint      th32ParentProcessID;
    ///The base priority of any threads created by this process.
    int       pcPriClassBase;
    ///This member is no longer used and is always set to zero.
    uint      dwFlags;
    ///The name of the executable file for the process. To retrieve the full path to the executable file, call the
    ///Module32First function and check the <b>szExePath</b> member of the MODULEENTRY32 structure that is returned.
    ///However, if the calling process is a 32-bit process, you must call the QueryFullProcessImageName function to
    ///retrieve the full path of the executable file for a 64-bit process.
    byte[260] szExeFile;
}

///Describes an entry from a list of the threads executing in the system when a snapshot was taken.
struct THREADENTRY32
{
    ///The size of the structure, in bytes. Before calling the Thread32First function, set this member to
    ///<code>sizeof(THREADENTRY32)</code>. If you do not initialize <b>dwSize</b>, <b>Thread32First</b> fails.
    uint dwSize;
    ///This member is no longer used and is always set to zero.
    uint cntUsage;
    ///The thread identifier, compatible with the thread identifier returned by the CreateProcess function.
    uint th32ThreadID;
    ///The identifier of the process that created the thread.
    uint th32OwnerProcessID;
    ///The kernel base priority level assigned to the thread. The priority is a number from 0 to 31, with 0 representing
    ///the lowest possible thread priority. For more information, see <b>KeQueryPriorityThread</b>.
    int  tpBasePri;
    ///This member is no longer used and is always set to zero.
    int  tpDeltaPri;
    ///This member is no longer used and is always set to zero.
    uint dwFlags;
}

///Describes an entry from a list of the modules belonging to the specified process.
struct MODULEENTRY32W
{
    ///The size of the structure, in bytes. Before calling the Module32First function, set this member to
    ///<code>sizeof(MODULEENTRY32)</code>. If you do not initialize <b>dwSize</b>, <b>Module32First</b> fails.
    uint        dwSize;
    ///This member is no longer used, and is always set to one.
    uint        th32ModuleID;
    ///The identifier of the process whose modules are to be examined.
    uint        th32ProcessID;
    ///The load count of the module, which is not generally meaningful, and usually equal to 0xFFFF.
    uint        GlblcntUsage;
    ///The load count of the module (same as <i>GlblcntUsage</i>), which is not generally meaningful, and usually equal
    ///to 0xFFFF.
    uint        ProccntUsage;
    ///The base address of the module in the context of the owning process.
    ubyte*      modBaseAddr;
    ///The size of the module, in bytes.
    uint        modBaseSize;
    ///A handle to the module in the context of the owning process.
    ptrdiff_t   hModule;
    ///The module name.
    ushort[256] szModule;
    ///The module path.
    ushort[260] szExePath;
}

///Describes an entry from a list of the modules belonging to the specified process.
struct MODULEENTRY32
{
    ///The size of the structure, in bytes. Before calling the Module32First function, set this member to
    ///<code>sizeof(MODULEENTRY32)</code>. If you do not initialize <b>dwSize</b>, <b>Module32First</b> fails.
    uint      dwSize;
    ///This member is no longer used, and is always set to one.
    uint      th32ModuleID;
    ///The identifier of the process whose modules are to be examined.
    uint      th32ProcessID;
    ///The load count of the module, which is not generally meaningful, and usually equal to 0xFFFF.
    uint      GlblcntUsage;
    ///The load count of the module (same as <i>GlblcntUsage</i>), which is not generally meaningful, and usually equal
    ///to 0xFFFF.
    uint      ProccntUsage;
    ///The base address of the module in the context of the owning process.
    ubyte*    modBaseAddr;
    ///The size of the module, in bytes.
    uint      modBaseSize;
    ///A handle to the module in the context of the owning process.
    ptrdiff_t hModule;
    ///The module name.
    byte[256] szModule;
    ///The module path.
    byte[260] szExePath;
}

// Functions

///Takes a snapshot of the specified processes, as well as the heaps, modules, and threads used by these processes.
///Params:
///    dwFlags = The portions of the system to be included in the snapshot. This parameter can be one or more of the following
///              values. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="TH32CS_INHERIT"></a><a
///              id="th32cs_inherit"></a><dl> <dt><b>TH32CS_INHERIT</b></dt> <dt>0x80000000</dt> </dl> </td> <td width="60%">
///              Indicates that the snapshot handle is to be inheritable. </td> </tr> <tr> <td width="40%"><a
///              id="TH32CS_SNAPALL"></a><a id="th32cs_snapall"></a><dl> <dt><b>TH32CS_SNAPALL</b></dt> </dl> </td> <td
///              width="60%"> Includes all processes and threads in the system, plus the heaps and modules of the process
///              specified in <i>th32ProcessID</i>. Equivalent to specifying the <b>TH32CS_SNAPHEAPLIST</b>,
///              <b>TH32CS_SNAPMODULE</b>, <b>TH32CS_SNAPPROCESS</b>, and <b>TH32CS_SNAPTHREAD</b> values combined using an OR
///              operation ('|'). </td> </tr> <tr> <td width="40%"><a id="TH32CS_SNAPHEAPLIST"></a><a
///              id="th32cs_snapheaplist"></a><dl> <dt><b>TH32CS_SNAPHEAPLIST</b></dt> <dt>0x00000001</dt> </dl> </td> <td
///              width="60%"> Includes all heaps of the process specified in <i>th32ProcessID</i> in the snapshot. To enumerate
///              the heaps, see Heap32ListFirst. </td> </tr> <tr> <td width="40%"><a id="TH32CS_SNAPMODULE"></a><a
///              id="th32cs_snapmodule"></a><dl> <dt><b>TH32CS_SNAPMODULE</b></dt> <dt>0x00000008</dt> </dl> </td> <td
///              width="60%"> Includes all modules of the process specified in <i>th32ProcessID</i> in the snapshot. To enumerate
///              the modules, see Module32First. If the function fails with <b>ERROR_BAD_LENGTH</b>, retry the function until it
///              succeeds. <b>64-bit Windows: </b>Using this flag in a 32-bit process includes the 32-bit modules of the process
///              specified in <i>th32ProcessID</i>, while using it in a 64-bit process includes the 64-bit modules. To include the
///              32-bit modules of the process specified in <i>th32ProcessID</i> from a 64-bit process, use the
///              <b>TH32CS_SNAPMODULE32</b> flag. </td> </tr> <tr> <td width="40%"><a id="TH32CS_SNAPMODULE32"></a><a
///              id="th32cs_snapmodule32"></a><dl> <dt><b>TH32CS_SNAPMODULE32</b></dt> <dt>0x00000010</dt> </dl> </td> <td
///              width="60%"> Includes all 32-bit modules of the process specified in <i>th32ProcessID</i> in the snapshot when
///              called from a 64-bit process. This flag can be combined with <b>TH32CS_SNAPMODULE</b> or <b>TH32CS_SNAPALL</b>.
///              If the function fails with <b>ERROR_BAD_LENGTH</b>, retry the function until it succeeds. </td> </tr> <tr> <td
///              width="40%"><a id="TH32CS_SNAPPROCESS"></a><a id="th32cs_snapprocess"></a><dl> <dt><b>TH32CS_SNAPPROCESS</b></dt>
///              <dt>0x00000002</dt> </dl> </td> <td width="60%"> Includes all processes in the system in the snapshot. To
///              enumerate the processes, see Process32First. </td> </tr> <tr> <td width="40%"><a id="TH32CS_SNAPTHREAD"></a><a
///              id="th32cs_snapthread"></a><dl> <dt><b>TH32CS_SNAPTHREAD</b></dt> <dt>0x00000004</dt> </dl> </td> <td
///              width="60%"> Includes all threads in the system in the snapshot. To enumerate the threads, see Thread32First. To
///              identify the threads that belong to a specific process, compare its process identifier to the
///              <b>th32OwnerProcessID</b> member of the THREADENTRY32 structure when enumerating the threads. </td> </tr>
///              </table>
///    th32ProcessID = The process identifier of the process to be included in the snapshot. This parameter can be zero to indicate the
///                    current process. This parameter is used when the <b>TH32CS_SNAPHEAPLIST</b>, <b>TH32CS_SNAPMODULE</b>,
///                    <b>TH32CS_SNAPMODULE32</b>, or <b>TH32CS_SNAPALL</b> value is specified. Otherwise, it is ignored and all
///                    processes are included in the snapshot. If the specified process is the Idle process or one of the CSRSS
///                    processes, this function fails and the last error code is <b>ERROR_ACCESS_DENIED</b> because their access
///                    restrictions prevent user-level code from opening them. If the specified process is a 64-bit process and the
///                    caller is a 32-bit process, this function fails and the last error code is <b>ERROR_PARTIAL_COPY</b> (299).
///Returns:
///    If the function succeeds, it returns an open handle to the specified snapshot. If the function fails, it returns
///    <b>INVALID_HANDLE_VALUE</b>. To get extended error information, call GetLastError. Possible error codes include
///    <b>ERROR_BAD_LENGTH</b>.
///    
@DllImport("KERNEL32")
HANDLE CreateToolhelp32Snapshot(uint dwFlags, uint th32ProcessID);

///Retrieves information about the first heap that has been allocated by a specified process.
///Params:
///    hSnapshot = A handle to the snapshot returned from a previous call to the CreateToolhelp32Snapshot function.
///    lphl = A pointer to a HEAPLIST32 structure.
///Returns:
///    Returns <b>TRUE</b> if the first entry of the heap list has been copied to the buffer or <b>FALSE</b> otherwise.
///    The <b>ERROR_NO_MORE_FILES</b> error value is returned by the GetLastError function when no heap list exists or
///    the snapshot does not contain heap list information.
///    
@DllImport("KERNEL32")
BOOL Heap32ListFirst(HANDLE hSnapshot, HEAPLIST32* lphl);

///Retrieves information about the next heap that has been allocated by a process.
///Params:
///    hSnapshot = A handle to the snapshot returned from a previous call to the CreateToolhelp32Snapshot function.
///    lphl = A pointer to a HEAPLIST32 structure.
///Returns:
///    Returns <b>TRUE</b> if the next entry of the heap list has been copied to the buffer or <b>FALSE</b> otherwise.
///    The <b>ERROR_NO_MORE_FILES</b> error value is returned by the GetLastError function when no more entries in the
///    heap list exist.
///    
@DllImport("KERNEL32")
BOOL Heap32ListNext(HANDLE hSnapshot, HEAPLIST32* lphl);

///Retrieves information about the first block of a heap that has been allocated by a process.
///Params:
///    lphe = A pointer to a HEAPENTRY32 structure.
///    th32ProcessID = The identifier of the process context that owns the heap.
///    th32HeapID = The identifier of the heap to be enumerated.
///Returns:
///    Returns <b>TRUE</b> if information for the first heap block has been copied to the buffer or <b>FALSE</b>
///    otherwise. The <b>ERROR_NO_MORE_FILES</b> error value is returned by the GetLastError function if the heap is
///    invalid or empty.
///    
@DllImport("KERNEL32")
BOOL Heap32First(HEAPENTRY32* lphe, uint th32ProcessID, size_t th32HeapID);

///Retrieves information about the next block of a heap that has been allocated by a process.
///Params:
///    lphe = A pointer to a HEAPENTRY32 structure.
///Returns:
///    Returns <b>TRUE</b> if information about the next block in the heap has been copied to the buffer or <b>FALSE</b>
///    otherwise. The GetLastError function returns <b>ERROR_NO_MORE_FILES</b> when no more objects in the heap exist
///    and <b>ERROR_INVALID_DATA</b> if the heap appears to be corrupt or is modified during the walk in such a way that
///    <b>Heap32Next</b> cannot continue.
///    
@DllImport("KERNEL32")
BOOL Heap32Next(HEAPENTRY32* lphe);

///Copies memory allocated to another process into an application-supplied buffer.
///Params:
///    th32ProcessID = The identifier of the process whose memory is being copied. This parameter can be zero to copy the memory of the
///                    current process.
///    lpBaseAddress = The base address in the specified process to read. Before transferring any data, the system verifies that all
///                    data in the base address and memory of the specified size is accessible for read access. If this is the case, the
///                    function proceeds. Otherwise, the function fails.
///    lpBuffer = A pointer to a buffer that receives the contents of the address space of the specified process.
///    cbRead = The number of bytes to read from the specified process.
///    lpNumberOfBytesRead = The number of bytes copied to the specified buffer. If this parameter is <b>NULL</b>, it is ignored.
///Returns:
///    Returns <b>TRUE</b> if successful.
///    
@DllImport("KERNEL32")
BOOL Toolhelp32ReadProcessMemory(uint th32ProcessID, const(void)* lpBaseAddress, void* lpBuffer, size_t cbRead, 
                                 size_t* lpNumberOfBytesRead);

///Retrieves information about the first process encountered in a system snapshot.
///Params:
///    hSnapshot = A handle to the snapshot returned from a previous call to the CreateToolhelp32Snapshot function.
///    lppe = A pointer to a PROCESSENTRY32W structure. It contains process information such as the name of the executable
///           file, the process identifier, and the process identifier of the parent process.
///Returns:
///    Returns <b>TRUE</b> if the first entry of the process list has been copied to the buffer or <b>FALSE</b>
///    otherwise. The <b>ERROR_NO_MORE_FILES</b> error value is returned by the GetLastError function if no processes
///    exist or the snapshot does not contain process information.
///    
@DllImport("KERNEL32")
BOOL Process32FirstW(HANDLE hSnapshot, PROCESSENTRY32W* lppe);

///Retrieves information about the next process recorded in a system snapshot.
///Params:
///    hSnapshot = A handle to the snapshot returned from a previous call to the CreateToolhelp32Snapshot function.
///    lppe = A pointer to a PROCESSENTRY32W structure.
///Returns:
///    Returns <b>TRUE</b> if the next entry of the process list has been copied to the buffer or <b>FALSE</b>
///    otherwise. The <b>ERROR_NO_MORE_FILES</b> error value is returned by the GetLastError function if no processes
///    exist or the snapshot does not contain process information.
///    
@DllImport("KERNEL32")
BOOL Process32NextW(HANDLE hSnapshot, PROCESSENTRY32W* lppe);

///Retrieves information about the first process encountered in a system snapshot.
///Params:
///    hSnapshot = A handle to the snapshot returned from a previous call to the CreateToolhelp32Snapshot function.
///    lppe = A pointer to a PROCESSENTRY32 structure. It contains process information such as the name of the executable file,
///           the process identifier, and the process identifier of the parent process.
///Returns:
///    Returns <b>TRUE</b> if the first entry of the process list has been copied to the buffer or <b>FALSE</b>
///    otherwise. The <b>ERROR_NO_MORE_FILES</b> error value is returned by the GetLastError function if no processes
///    exist or the snapshot does not contain process information.
///    
@DllImport("KERNEL32")
BOOL Process32First(HANDLE hSnapshot, PROCESSENTRY32* lppe);

///Retrieves information about the next process recorded in a system snapshot.
///Params:
///    hSnapshot = A handle to the snapshot returned from a previous call to the CreateToolhelp32Snapshot function.
///    lppe = A pointer to a PROCESSENTRY32 structure.
///Returns:
///    Returns <b>TRUE</b> if the next entry of the process list has been copied to the buffer or <b>FALSE</b>
///    otherwise. The <b>ERROR_NO_MORE_FILES</b> error value is returned by the GetLastError function if no processes
///    exist or the snapshot does not contain process information.
///    
@DllImport("KERNEL32")
BOOL Process32Next(HANDLE hSnapshot, PROCESSENTRY32* lppe);

///Retrieves information about the first thread of any process encountered in a system snapshot.
///Params:
///    hSnapshot = A handle to the snapshot returned from a previous call to the CreateToolhelp32Snapshot function.
///    lpte = A pointer to a THREADENTRY32 structure.
///Returns:
///    Returns <b>TRUE</b> if the first entry of the thread list has been copied to the buffer or <b>FALSE</b>
///    otherwise. The <b>ERROR_NO_MORE_FILES</b> error value is returned by the GetLastError function if no threads
///    exist or the snapshot does not contain thread information.
///    
@DllImport("KERNEL32")
BOOL Thread32First(HANDLE hSnapshot, THREADENTRY32* lpte);

///Retrieves information about the next thread of any process encountered in the system memory snapshot.
///Params:
///    hSnapshot = A handle to the snapshot returned from a previous call to the CreateToolhelp32Snapshot function.
///    lpte = A pointer to a THREADENTRY32 structure.
///Returns:
///    Returns <b>TRUE</b> if the next entry of the thread list has been copied to the buffer or <b>FALSE</b> otherwise.
///    The <b>ERROR_NO_MORE_FILES</b> error value is returned by the GetLastError function if no threads exist or the
///    snapshot does not contain thread information.
///    
@DllImport("KERNEL32")
BOOL Thread32Next(HANDLE hSnapshot, THREADENTRY32* lpte);

///Retrieves information about the first module associated with a process.
///Params:
///    hSnapshot = A handle to the snapshot returned from a previous call to the CreateToolhelp32Snapshot function.
///    lpme = A pointer to a MODULEENTRY32W structure.
///Returns:
///    Returns <b>TRUE</b> if the first entry of the module list has been copied to the buffer or <b>FALSE</b>
///    otherwise. The <b>ERROR_NO_MORE_FILES</b> error value is returned by the GetLastError function if no modules
///    exist or the snapshot does not contain module information.
///    
@DllImport("KERNEL32")
BOOL Module32FirstW(HANDLE hSnapshot, MODULEENTRY32W* lpme);

///Retrieves information about the next module associated with a process or thread.
///Params:
///    hSnapshot = A handle to the snapshot returned from a previous call to the CreateToolhelp32Snapshot function.
///    lpme = A pointer to a MODULEENTRY32W structure.
///Returns:
///    Returns <b>TRUE</b> if the next entry of the module list has been copied to the buffer or <b>FALSE</b> otherwise.
///    The <b>ERROR_NO_MORE_FILES</b> error value is returned by the GetLastError function if no more modules exist.
///    
@DllImport("KERNEL32")
BOOL Module32NextW(HANDLE hSnapshot, MODULEENTRY32W* lpme);

///Retrieves information about the first module associated with a process.
///Params:
///    hSnapshot = A handle to the snapshot returned from a previous call to the CreateToolhelp32Snapshot function.
///    lpme = A pointer to a MODULEENTRY32 structure.
///Returns:
///    Returns <b>TRUE</b> if the first entry of the module list has been copied to the buffer or <b>FALSE</b>
///    otherwise. The <b>ERROR_NO_MORE_FILES</b> error value is returned by the GetLastError function if no modules
///    exist or the snapshot does not contain module information.
///    
@DllImport("KERNEL32")
BOOL Module32First(HANDLE hSnapshot, MODULEENTRY32* lpme);

///Retrieves information about the next module associated with a process or thread.
///Params:
///    hSnapshot = A handle to the snapshot returned from a previous call to the CreateToolhelp32Snapshot function.
///    lpme = A pointer to a MODULEENTRY32 structure.
///Returns:
///    Returns <b>TRUE</b> if the next entry of the module list has been copied to the buffer or <b>FALSE</b> otherwise.
///    The <b>ERROR_NO_MORE_FILES</b> error value is returned by the GetLastError function if no more modules exist.
///    
@DllImport("KERNEL32")
BOOL Module32Next(HANDLE hSnapshot, MODULEENTRY32* lpme);


