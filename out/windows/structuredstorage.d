module windows.structuredstorage;

public import system;
public import windows.automation;
public import windows.com;
public import windows.shell;
public import windows.systemservices;
public import windows.windowsandmessaging;
public import windows.windowsprogramming;

extern(Windows):

const GUID IID_ISequentialStream = {0x0C733A30, 0x2A1C, 0x11CE, [0xAD, 0xE5, 0x00, 0xAA, 0x00, 0x44, 0x77, 0x3D]};
@GUID(0x0C733A30, 0x2A1C, 0x11CE, [0xAD, 0xE5, 0x00, 0xAA, 0x00, 0x44, 0x77, 0x3D]);
interface ISequentialStream : IUnknown
{
    HRESULT Read(char* pv, uint cb, uint* pcbRead);
    HRESULT Write(char* pv, uint cb, uint* pcbWritten);
}

struct STATSTG
{
    ushort* pwcsName;
    uint type;
    ULARGE_INTEGER cbSize;
    FILETIME mtime;
    FILETIME ctime;
    FILETIME atime;
    uint grfMode;
    uint grfLocksSupported;
    Guid clsid;
    uint grfStateBits;
    uint reserved;
}

enum STGTY
{
    STGTY_STORAGE = 1,
    STGTY_STREAM = 2,
    STGTY_LOCKBYTES = 3,
    STGTY_PROPERTY = 4,
}

enum STREAM_SEEK
{
    STREAM_SEEK_SET = 0,
    STREAM_SEEK_CUR = 1,
    STREAM_SEEK_END = 2,
}

enum LOCKTYPE
{
    LOCK_WRITE = 1,
    LOCK_EXCLUSIVE = 2,
    LOCK_ONLYONCE = 4,
}

const GUID IID_IStream = {0x0000000C, 0x0000, 0x0000, [0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x46]};
@GUID(0x0000000C, 0x0000, 0x0000, [0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x46]);
interface IStream : ISequentialStream
{
    HRESULT Seek(LARGE_INTEGER dlibMove, uint dwOrigin, ULARGE_INTEGER* plibNewPosition);
    HRESULT SetSize(ULARGE_INTEGER libNewSize);
    HRESULT CopyTo(IStream pstm, ULARGE_INTEGER cb, ULARGE_INTEGER* pcbRead, ULARGE_INTEGER* pcbWritten);
    HRESULT Commit(uint grfCommitFlags);
    HRESULT Revert();
    HRESULT LockRegion(ULARGE_INTEGER libOffset, ULARGE_INTEGER cb, uint dwLockType);
    HRESULT UnlockRegion(ULARGE_INTEGER libOffset, ULARGE_INTEGER cb, uint dwLockType);
    HRESULT Stat(STATSTG* pstatstg, uint grfStatFlag);
    HRESULT Clone(IStream* ppstm);
}

const GUID IID_IEnumSTATSTG = {0x0000000D, 0x0000, 0x0000, [0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x46]};
@GUID(0x0000000D, 0x0000, 0x0000, [0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x46]);
interface IEnumSTATSTG : IUnknown
{
    HRESULT Next(uint celt, char* rgelt, uint* pceltFetched);
    HRESULT Skip(uint celt);
    HRESULT Reset();
    HRESULT Clone(IEnumSTATSTG* ppenum);
}

struct RemSNB
{
    uint ulCntStr;
    uint ulCntChar;
    ushort rgString;
}

const GUID IID_IStorage = {0x0000000B, 0x0000, 0x0000, [0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x46]};
@GUID(0x0000000B, 0x0000, 0x0000, [0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x46]);
interface IStorage : IUnknown
{
    HRESULT CreateStream(const(ushort)* pwcsName, uint grfMode, uint reserved1, uint reserved2, IStream* ppstm);
    HRESULT OpenStream(const(ushort)* pwcsName, void* reserved1, uint grfMode, uint reserved2, IStream* ppstm);
    HRESULT CreateStorage(const(ushort)* pwcsName, uint grfMode, uint reserved1, uint reserved2, IStorage* ppstg);
    HRESULT OpenStorage(const(ushort)* pwcsName, IStorage pstgPriority, uint grfMode, ushort** snbExclude, uint reserved, IStorage* ppstg);
    HRESULT CopyTo(uint ciidExclude, char* rgiidExclude, ushort** snbExclude, IStorage pstgDest);
    HRESULT MoveElementTo(const(ushort)* pwcsName, IStorage pstgDest, const(ushort)* pwcsNewName, uint grfFlags);
    HRESULT Commit(uint grfCommitFlags);
    HRESULT Revert();
    HRESULT EnumElements(uint reserved1, void* reserved2, uint reserved3, IEnumSTATSTG* ppenum);
    HRESULT DestroyElement(const(ushort)* pwcsName);
    HRESULT RenameElement(const(ushort)* pwcsOldName, const(ushort)* pwcsNewName);
    HRESULT SetElementTimes(const(ushort)* pwcsName, const(FILETIME)* pctime, const(FILETIME)* patime, const(FILETIME)* pmtime);
    HRESULT SetClass(const(Guid)* clsid);
    HRESULT SetStateBits(uint grfStateBits, uint grfMask);
    HRESULT Stat(STATSTG* pstatstg, uint grfStatFlag);
}

const GUID IID_ILockBytes = {0x0000000A, 0x0000, 0x0000, [0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x46]};
@GUID(0x0000000A, 0x0000, 0x0000, [0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x46]);
interface ILockBytes : IUnknown
{
    HRESULT ReadAt(ULARGE_INTEGER ulOffset, char* pv, uint cb, uint* pcbRead);
    HRESULT WriteAt(ULARGE_INTEGER ulOffset, char* pv, uint cb, uint* pcbWritten);
    HRESULT Flush();
    HRESULT SetSize(ULARGE_INTEGER cb);
    HRESULT LockRegion(ULARGE_INTEGER libOffset, ULARGE_INTEGER cb, uint dwLockType);
    HRESULT UnlockRegion(ULARGE_INTEGER libOffset, ULARGE_INTEGER cb, uint dwLockType);
    HRESULT Stat(STATSTG* pstatstg, uint grfStatFlag);
}

const GUID IID_IRootStorage = {0x00000012, 0x0000, 0x0000, [0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x46]};
@GUID(0x00000012, 0x0000, 0x0000, [0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x46]);
interface IRootStorage : IUnknown
{
    HRESULT SwitchToFile(ushort* pszFile);
}

const GUID IID_IFillLockBytes = {0x99CAF010, 0x415E, 0x11CF, [0x88, 0x14, 0x00, 0xAA, 0x00, 0xB5, 0x69, 0xF5]};
@GUID(0x99CAF010, 0x415E, 0x11CF, [0x88, 0x14, 0x00, 0xAA, 0x00, 0xB5, 0x69, 0xF5]);
interface IFillLockBytes : IUnknown
{
    HRESULT FillAppend(char* pv, uint cb, uint* pcbWritten);
    HRESULT FillAt(ULARGE_INTEGER ulOffset, char* pv, uint cb, uint* pcbWritten);
    HRESULT SetFillSize(ULARGE_INTEGER ulSize);
    HRESULT Terminate(BOOL bCanceled);
}

struct StorageLayout
{
    uint LayoutType;
    ushort* pwcsElementName;
    LARGE_INTEGER cOffset;
    LARGE_INTEGER cBytes;
}

const GUID IID_ILayoutStorage = {0x0E6D4D90, 0x6738, 0x11CF, [0x96, 0x08, 0x00, 0xAA, 0x00, 0x68, 0x0D, 0xB4]};
@GUID(0x0E6D4D90, 0x6738, 0x11CF, [0x96, 0x08, 0x00, 0xAA, 0x00, 0x68, 0x0D, 0xB4]);
interface ILayoutStorage : IUnknown
{
    HRESULT LayoutScript(char* pStorageLayout, uint nEntries, uint glfInterleavedFlag);
    HRESULT BeginMonitor();
    HRESULT EndMonitor();
    HRESULT ReLayoutDocfile(ushort* pwcsNewDfName);
    HRESULT ReLayoutDocfileOnILockBytes(ILockBytes pILockBytes);
}

const GUID IID_IDirectWriterLock = {0x0E6D4D92, 0x6738, 0x11CF, [0x96, 0x08, 0x00, 0xAA, 0x00, 0x68, 0x0D, 0xB4]};
@GUID(0x0E6D4D92, 0x6738, 0x11CF, [0x96, 0x08, 0x00, 0xAA, 0x00, 0x68, 0x0D, 0xB4]);
interface IDirectWriterLock : IUnknown
{
    HRESULT WaitForWriteAccess(uint dwTimeout);
    HRESULT ReleaseWriteAccess();
    HRESULT HaveWriteAccess();
}

@DllImport("OLE32.dll")
HRESULT CreateStreamOnHGlobal(int hGlobal, BOOL fDeleteOnRelease, IStream* ppstm);

@DllImport("OLE32.dll")
HRESULT GetHGlobalFromStream(IStream pstm, int* phglobal);

@DllImport("OLE32.dll")
HRESULT PropVariantCopy(PROPVARIANT* pvarDest, const(PROPVARIANT)* pvarSrc);

@DllImport("OLE32.dll")
HRESULT PropVariantClear(PROPVARIANT* pvar);

@DllImport("OLE32.dll")
HRESULT FreePropVariantArray(uint cVariants, char* rgvars);

@DllImport("OLE32.dll")
HRESULT WriteFmtUserTypeStg(IStorage pstg, ushort cf, ushort* lpszUserType);

@DllImport("OLE32.dll")
HRESULT ReadFmtUserTypeStg(IStorage pstg, ushort* pcf, ushort** lplpszUserType);

@DllImport("ole32.dll")
HRESULT OleConvertOLESTREAMToIStorage(OLESTREAM* lpolestream, IStorage pstg, const(DVTARGETDEVICE)* ptd);

@DllImport("ole32.dll")
HRESULT OleConvertIStorageToOLESTREAM(IStorage pstg, OLESTREAM* lpolestream);

@DllImport("OLE32.dll")
HRESULT SetConvertStg(IStorage pStg, BOOL fConvert);

@DllImport("ole32.dll")
HRESULT OleConvertIStorageToOLESTREAMEx(IStorage pstg, ushort cfFormat, int lWidth, int lHeight, uint dwSize, STGMEDIUM* pmedium, OLESTREAM* polestm);

@DllImport("ole32.dll")
HRESULT OleConvertOLESTREAMToIStorageEx(OLESTREAM* polestm, IStorage pstg, ushort* pcfFormat, int* plwWidth, int* plHeight, uint* pdwSize, STGMEDIUM* pmedium);

@DllImport("PROPSYS.dll")
HRESULT StgSerializePropVariant(const(PROPVARIANT)* ppropvar, SERIALIZEDPROPERTYVALUE** ppProp, uint* pcb);

@DllImport("PROPSYS.dll")
HRESULT StgDeserializePropVariant(const(SERIALIZEDPROPERTYVALUE)* pprop, uint cbMax, PROPVARIANT* ppropvar);

@DllImport("OLE32.dll")
HRESULT StgCreateDocfile(const(wchar)* pwcsName, uint grfMode, uint reserved, IStorage* ppstgOpen);

@DllImport("OLE32.dll")
HRESULT StgCreateDocfileOnILockBytes(ILockBytes plkbyt, uint grfMode, uint reserved, IStorage* ppstgOpen);

@DllImport("OLE32.dll")
HRESULT StgOpenStorage(const(wchar)* pwcsName, IStorage pstgPriority, uint grfMode, ushort** snbExclude, uint reserved, IStorage* ppstgOpen);

@DllImport("OLE32.dll")
HRESULT StgOpenStorageOnILockBytes(ILockBytes plkbyt, IStorage pstgPriority, uint grfMode, ushort** snbExclude, uint reserved, IStorage* ppstgOpen);

@DllImport("OLE32.dll")
HRESULT StgIsStorageFile(const(wchar)* pwcsName);

@DllImport("OLE32.dll")
HRESULT StgIsStorageILockBytes(ILockBytes plkbyt);

@DllImport("OLE32.dll")
HRESULT StgSetTimes(const(wchar)* lpszName, const(FILETIME)* pctime, const(FILETIME)* patime, const(FILETIME)* pmtime);

@DllImport("OLE32.dll")
HRESULT StgCreateStorageEx(const(wchar)* pwcsName, uint grfMode, uint stgfmt, uint grfAttrs, STGOPTIONS* pStgOptions, void* pSecurityDescriptor, const(Guid)* riid, void** ppObjectOpen);

@DllImport("OLE32.dll")
HRESULT StgOpenStorageEx(const(wchar)* pwcsName, uint grfMode, uint stgfmt, uint grfAttrs, STGOPTIONS* pStgOptions, void* pSecurityDescriptor, const(Guid)* riid, void** ppObjectOpen);

@DllImport("OLE32.dll")
HRESULT StgCreatePropStg(IUnknown pUnk, const(Guid)* fmtid, const(Guid)* pclsid, uint grfFlags, uint dwReserved, IPropertyStorage* ppPropStg);

@DllImport("OLE32.dll")
HRESULT StgOpenPropStg(IUnknown pUnk, const(Guid)* fmtid, uint grfFlags, uint dwReserved, IPropertyStorage* ppPropStg);

@DllImport("OLE32.dll")
HRESULT StgCreatePropSetStg(IStorage pStorage, uint dwReserved, IPropertySetStorage* ppPropSetStg);

@DllImport("OLE32.dll")
HRESULT FmtIdToPropStgName(const(Guid)* pfmtid, char* oszName);

@DllImport("OLE32.dll")
HRESULT PropStgNameToFmtId(const(ushort)* oszName, Guid* pfmtid);

@DllImport("OLE32.dll")
HRESULT ReadClassStg(IStorage pStg, Guid* pclsid);

@DllImport("OLE32.dll")
HRESULT WriteClassStg(IStorage pStg, const(Guid)* rclsid);

@DllImport("OLE32.dll")
HRESULT ReadClassStm(IStream pStm, Guid* pclsid);

@DllImport("OLE32.dll")
HRESULT WriteClassStm(IStream pStm, const(Guid)* rclsid);

@DllImport("OLE32.dll")
HRESULT GetHGlobalFromILockBytes(ILockBytes plkbyt, int* phglobal);

@DllImport("OLE32.dll")
HRESULT CreateILockBytesOnHGlobal(int hGlobal, BOOL fDeleteOnRelease, ILockBytes* pplkbyt);

@DllImport("OLE32.dll")
HRESULT GetConvertStg(IStorage pStg);

@DllImport("ole32.dll")
uint CoBuildVersion();

@DllImport("ole32.dll")
HRESULT DcomChannelSetHResult(void* pvReserved, uint* pulReserved, HRESULT appsHR);

@DllImport("ole32.dll")
HRESULT StgOpenAsyncDocfileOnIFillLockBytes(IFillLockBytes pflb, uint grfMode, uint asyncFlags, IStorage* ppstgOpen);

@DllImport("ole32.dll")
HRESULT StgGetIFillLockBytesOnILockBytes(ILockBytes pilb, IFillLockBytes* ppflb);

@DllImport("ole32.dll")
HRESULT StgGetIFillLockBytesOnFile(const(ushort)* pwcsName, IFillLockBytes* ppflb);

@DllImport("dflayout.dll")
HRESULT StgOpenLayoutDocfile(const(ushort)* pwcsDfName, uint grfMode, uint reserved, IStorage* ppstgOpen);

@DllImport("ole32.dll")
SERIALIZEDPROPERTYVALUE* StgConvertVariantToProperty(const(PROPVARIANT)* pvar, ushort CodePage, char* pprop, uint* pcb, uint pid, ubyte fReserved, uint* pcIndirect);

@DllImport("ole32.dll")
ubyte StgConvertPropertyToVariant(const(SERIALIZEDPROPERTYVALUE)* pprop, ushort CodePage, PROPVARIANT* pvar, PMemoryAllocator* pma);

@DllImport("ole32.dll")
HRESULT CreateStdProgressIndicator(HWND hwndParent, ushort* pszTitle, IBindStatusCallback pIbscCaller, IBindStatusCallback* ppIbsc);

@DllImport("ole32.dll")
uint StgPropertyLengthAsVariant(char* pProp, uint cbProp, ushort CodePage, ubyte bReserved);

@DllImport("ESENT.dll")
int JetInit(uint* pinstance);

@DllImport("ESENT.dll")
int JetInit2(uint* pinstance, uint grbit);

@DllImport("ESENT.dll")
int JetInit3A(uint* pinstance, JET_RSTINFO_A* prstInfo, uint grbit);

@DllImport("ESENT.dll")
int JetInit3W(uint* pinstance, JET_RSTINFO_W* prstInfo, uint grbit);

@DllImport("ESENT.dll")
int JetCreateInstanceA(uint* pinstance, byte* szInstanceName);

@DllImport("ESENT.dll")
int JetCreateInstanceW(uint* pinstance, ushort* szInstanceName);

@DllImport("ESENT.dll")
int JetCreateInstance2A(uint* pinstance, byte* szInstanceName, byte* szDisplayName, uint grbit);

@DllImport("ESENT.dll")
int JetCreateInstance2W(uint* pinstance, ushort* szInstanceName, ushort* szDisplayName, uint grbit);

@DllImport("ESENT.dll")
int JetGetInstanceMiscInfo(uint instance, char* pvResult, uint cbMax, uint InfoLevel);

@DllImport("ESENT.dll")
int JetTerm(uint instance);

@DllImport("ESENT.dll")
int JetTerm2(uint instance, uint grbit);

@DllImport("ESENT.dll")
int JetStopService();

@DllImport("ESENT.dll")
int JetStopServiceInstance(uint instance);

@DllImport("ESENT.dll")
int JetStopServiceInstance2(uint instance, const(uint) grbit);

@DllImport("ESENT.dll")
int JetStopBackup();

@DllImport("ESENT.dll")
int JetStopBackupInstance(uint instance);

@DllImport("ESENT.dll")
int JetSetSystemParameterA(uint* pinstance, uint sesid, uint paramid, uint lParam, byte* szParam);

@DllImport("ESENT.dll")
int JetSetSystemParameterW(uint* pinstance, uint sesid, uint paramid, uint lParam, ushort* szParam);

@DllImport("ESENT.dll")
int JetGetSystemParameterA(uint instance, uint sesid, uint paramid, uint* plParam, char* szParam, uint cbMax);

@DllImport("ESENT.dll")
int JetGetSystemParameterW(uint instance, uint sesid, uint paramid, uint* plParam, char* szParam, uint cbMax);

@DllImport("ESENT.dll")
int JetEnableMultiInstanceA(char* psetsysparam, uint csetsysparam, uint* pcsetsucceed);

@DllImport("ESENT.dll")
int JetEnableMultiInstanceW(char* psetsysparam, uint csetsysparam, uint* pcsetsucceed);

@DllImport("ESENT.dll")
int JetGetThreadStats(char* pvResult, uint cbMax);

@DllImport("ESENT.dll")
int JetBeginSessionA(uint instance, uint* psesid, byte* szUserName, byte* szPassword);

@DllImport("ESENT.dll")
int JetBeginSessionW(uint instance, uint* psesid, ushort* szUserName, ushort* szPassword);

@DllImport("ESENT.dll")
int JetDupSession(uint sesid, uint* psesid);

@DllImport("ESENT.dll")
int JetEndSession(uint sesid, uint grbit);

@DllImport("ESENT.dll")
int JetGetVersion(uint sesid, uint* pwVersion);

@DllImport("ESENT.dll")
int JetIdle(uint sesid, uint grbit);

@DllImport("ESENT.dll")
int JetCreateDatabaseA(uint sesid, byte* szFilename, byte* szConnect, uint* pdbid, uint grbit);

@DllImport("ESENT.dll")
int JetCreateDatabaseW(uint sesid, ushort* szFilename, ushort* szConnect, uint* pdbid, uint grbit);

@DllImport("ESENT.dll")
int JetCreateDatabase2A(uint sesid, byte* szFilename, const(uint) cpgDatabaseSizeMax, uint* pdbid, uint grbit);

@DllImport("ESENT.dll")
int JetCreateDatabase2W(uint sesid, ushort* szFilename, const(uint) cpgDatabaseSizeMax, uint* pdbid, uint grbit);

@DllImport("ESENT.dll")
int JetAttachDatabaseA(uint sesid, byte* szFilename, uint grbit);

@DllImport("ESENT.dll")
int JetAttachDatabaseW(uint sesid, ushort* szFilename, uint grbit);

@DllImport("ESENT.dll")
int JetAttachDatabase2A(uint sesid, byte* szFilename, const(uint) cpgDatabaseSizeMax, uint grbit);

@DllImport("ESENT.dll")
int JetAttachDatabase2W(uint sesid, ushort* szFilename, const(uint) cpgDatabaseSizeMax, uint grbit);

@DllImport("ESENT.dll")
int JetDetachDatabaseA(uint sesid, byte* szFilename);

@DllImport("ESENT.dll")
int JetDetachDatabaseW(uint sesid, ushort* szFilename);

@DllImport("ESENT.dll")
int JetDetachDatabase2A(uint sesid, byte* szFilename, uint grbit);

@DllImport("ESENT.dll")
int JetDetachDatabase2W(uint sesid, ushort* szFilename, uint grbit);

@DllImport("ESENT.dll")
int JetGetObjectInfoA(uint sesid, uint dbid, uint objtyp, byte* szContainerName, byte* szObjectName, char* pvResult, uint cbMax, uint InfoLevel);

@DllImport("ESENT.dll")
int JetGetObjectInfoW(uint sesid, uint dbid, uint objtyp, ushort* szContainerName, ushort* szObjectName, char* pvResult, uint cbMax, uint InfoLevel);

@DllImport("ESENT.dll")
int JetGetTableInfoA(uint sesid, uint tableid, char* pvResult, uint cbMax, uint InfoLevel);

@DllImport("ESENT.dll")
int JetGetTableInfoW(uint sesid, uint tableid, char* pvResult, uint cbMax, uint InfoLevel);

@DllImport("ESENT.dll")
int JetCreateTableA(uint sesid, uint dbid, byte* szTableName, uint lPages, uint lDensity, uint* ptableid);

@DllImport("ESENT.dll")
int JetCreateTableW(uint sesid, uint dbid, ushort* szTableName, uint lPages, uint lDensity, uint* ptableid);

@DllImport("ESENT.dll")
int JetCreateTableColumnIndexA(uint sesid, uint dbid, JET_TABLECREATE_A* ptablecreate);

@DllImport("ESENT.dll")
int JetCreateTableColumnIndexW(uint sesid, uint dbid, JET_TABLECREATE_W* ptablecreate);

@DllImport("ESENT.dll")
int JetCreateTableColumnIndex2A(uint sesid, uint dbid, JET_TABLECREATE2_A* ptablecreate);

@DllImport("ESENT.dll")
int JetCreateTableColumnIndex2W(uint sesid, uint dbid, JET_TABLECREATE2_W* ptablecreate);

@DllImport("ESENT.dll")
int JetCreateTableColumnIndex3A(uint sesid, uint dbid, JET_TABLECREATE3_A* ptablecreate);

@DllImport("ESENT.dll")
int JetCreateTableColumnIndex3W(uint sesid, uint dbid, JET_TABLECREATE3_W* ptablecreate);

@DllImport("ESENT.dll")
int JetCreateTableColumnIndex4A(uint sesid, uint dbid, JET_TABLECREATE4_A* ptablecreate);

@DllImport("ESENT.dll")
int JetCreateTableColumnIndex4W(uint sesid, uint dbid, JET_TABLECREATE4_W* ptablecreate);

@DllImport("ESENT.dll")
int JetDeleteTableA(uint sesid, uint dbid, byte* szTableName);

@DllImport("ESENT.dll")
int JetDeleteTableW(uint sesid, uint dbid, ushort* szTableName);

@DllImport("ESENT.dll")
int JetRenameTableA(uint sesid, uint dbid, byte* szName, byte* szNameNew);

@DllImport("ESENT.dll")
int JetRenameTableW(uint sesid, uint dbid, ushort* szName, ushort* szNameNew);

@DllImport("ESENT.dll")
int JetGetTableColumnInfoA(uint sesid, uint tableid, byte* szColumnName, char* pvResult, uint cbMax, uint InfoLevel);

@DllImport("ESENT.dll")
int JetGetTableColumnInfoW(uint sesid, uint tableid, ushort* szColumnName, char* pvResult, uint cbMax, uint InfoLevel);

@DllImport("ESENT.dll")
int JetGetColumnInfoA(uint sesid, uint dbid, byte* szTableName, byte* pColumnNameOrId, char* pvResult, uint cbMax, uint InfoLevel);

@DllImport("ESENT.dll")
int JetGetColumnInfoW(uint sesid, uint dbid, ushort* szTableName, ushort* pwColumnNameOrId, char* pvResult, uint cbMax, uint InfoLevel);

@DllImport("ESENT.dll")
int JetAddColumnA(uint sesid, uint tableid, byte* szColumnName, const(JET_COLUMNDEF)* pcolumndef, char* pvDefault, uint cbDefault, uint* pcolumnid);

@DllImport("ESENT.dll")
int JetAddColumnW(uint sesid, uint tableid, ushort* szColumnName, const(JET_COLUMNDEF)* pcolumndef, char* pvDefault, uint cbDefault, uint* pcolumnid);

@DllImport("ESENT.dll")
int JetDeleteColumnA(uint sesid, uint tableid, byte* szColumnName);

@DllImport("ESENT.dll")
int JetDeleteColumnW(uint sesid, uint tableid, ushort* szColumnName);

@DllImport("ESENT.dll")
int JetDeleteColumn2A(uint sesid, uint tableid, byte* szColumnName, const(uint) grbit);

@DllImport("ESENT.dll")
int JetDeleteColumn2W(uint sesid, uint tableid, ushort* szColumnName, const(uint) grbit);

@DllImport("ESENT.dll")
int JetRenameColumnA(uint sesid, uint tableid, byte* szName, byte* szNameNew, uint grbit);

@DllImport("ESENT.dll")
int JetRenameColumnW(uint sesid, uint tableid, ushort* szName, ushort* szNameNew, uint grbit);

@DllImport("ESENT.dll")
int JetSetColumnDefaultValueA(uint sesid, uint dbid, byte* szTableName, byte* szColumnName, char* pvData, const(uint) cbData, const(uint) grbit);

@DllImport("ESENT.dll")
int JetSetColumnDefaultValueW(uint sesid, uint dbid, ushort* szTableName, ushort* szColumnName, char* pvData, const(uint) cbData, const(uint) grbit);

@DllImport("ESENT.dll")
int JetGetTableIndexInfoA(uint sesid, uint tableid, byte* szIndexName, char* pvResult, uint cbResult, uint InfoLevel);

@DllImport("ESENT.dll")
int JetGetTableIndexInfoW(uint sesid, uint tableid, ushort* szIndexName, char* pvResult, uint cbResult, uint InfoLevel);

@DllImport("ESENT.dll")
int JetGetIndexInfoA(uint sesid, uint dbid, byte* szTableName, byte* szIndexName, char* pvResult, uint cbResult, uint InfoLevel);

@DllImport("ESENT.dll")
int JetGetIndexInfoW(uint sesid, uint dbid, ushort* szTableName, ushort* szIndexName, char* pvResult, uint cbResult, uint InfoLevel);

@DllImport("ESENT.dll")
int JetCreateIndexA(uint sesid, uint tableid, byte* szIndexName, uint grbit, char* szKey, uint cbKey, uint lDensity);

@DllImport("ESENT.dll")
int JetCreateIndexW(uint sesid, uint tableid, ushort* szIndexName, uint grbit, const(wchar)* szKey, uint cbKey, uint lDensity);

@DllImport("ESENT.dll")
int JetCreateIndex2A(uint sesid, uint tableid, char* pindexcreate, uint cIndexCreate);

@DllImport("ESENT.dll")
int JetCreateIndex2W(uint sesid, uint tableid, char* pindexcreate, uint cIndexCreate);

@DllImport("ESENT.dll")
int JetCreateIndex3A(uint sesid, uint tableid, char* pindexcreate, uint cIndexCreate);

@DllImport("ESENT.dll")
int JetCreateIndex3W(uint sesid, uint tableid, char* pindexcreate, uint cIndexCreate);

@DllImport("ESENT.dll")
int JetCreateIndex4A(uint sesid, uint tableid, char* pindexcreate, uint cIndexCreate);

@DllImport("ESENT.dll")
int JetCreateIndex4W(uint sesid, uint tableid, char* pindexcreate, uint cIndexCreate);

@DllImport("ESENT.dll")
int JetDeleteIndexA(uint sesid, uint tableid, byte* szIndexName);

@DllImport("ESENT.dll")
int JetDeleteIndexW(uint sesid, uint tableid, ushort* szIndexName);

@DllImport("ESENT.dll")
int JetBeginTransaction(uint sesid);

@DllImport("ESENT.dll")
int JetBeginTransaction2(uint sesid, uint grbit);

@DllImport("ESENT.dll")
int JetBeginTransaction3(uint sesid, long trxid, uint grbit);

@DllImport("ESENT.dll")
int JetCommitTransaction(uint sesid, uint grbit);

@DllImport("ESENT.dll")
int JetCommitTransaction2(uint sesid, uint grbit, uint cmsecDurableCommit, JET_COMMIT_ID* pCommitId);

@DllImport("ESENT.dll")
int JetRollback(uint sesid, uint grbit);

@DllImport("ESENT.dll")
int JetGetDatabaseInfoA(uint sesid, uint dbid, char* pvResult, uint cbMax, uint InfoLevel);

@DllImport("ESENT.dll")
int JetGetDatabaseInfoW(uint sesid, uint dbid, char* pvResult, uint cbMax, uint InfoLevel);

@DllImport("ESENT.dll")
int JetGetDatabaseFileInfoA(byte* szDatabaseName, char* pvResult, uint cbMax, uint InfoLevel);

@DllImport("ESENT.dll")
int JetGetDatabaseFileInfoW(ushort* szDatabaseName, char* pvResult, uint cbMax, uint InfoLevel);

@DllImport("ESENT.dll")
int JetOpenDatabaseA(uint sesid, byte* szFilename, byte* szConnect, uint* pdbid, uint grbit);

@DllImport("ESENT.dll")
int JetOpenDatabaseW(uint sesid, ushort* szFilename, ushort* szConnect, uint* pdbid, uint grbit);

@DllImport("ESENT.dll")
int JetCloseDatabase(uint sesid, uint dbid, uint grbit);

@DllImport("ESENT.dll")
int JetOpenTableA(uint sesid, uint dbid, byte* szTableName, char* pvParameters, uint cbParameters, uint grbit, uint* ptableid);

@DllImport("ESENT.dll")
int JetOpenTableW(uint sesid, uint dbid, ushort* szTableName, char* pvParameters, uint cbParameters, uint grbit, uint* ptableid);

@DllImport("ESENT.dll")
int JetSetTableSequential(uint sesid, uint tableid, uint grbit);

@DllImport("ESENT.dll")
int JetResetTableSequential(uint sesid, uint tableid, uint grbit);

@DllImport("ESENT.dll")
int JetCloseTable(uint sesid, uint tableid);

@DllImport("ESENT.dll")
int JetDelete(uint sesid, uint tableid);

@DllImport("ESENT.dll")
int JetUpdate(uint sesid, uint tableid, char* pvBookmark, uint cbBookmark, uint* pcbActual);

@DllImport("ESENT.dll")
int JetUpdate2(uint sesid, uint tableid, char* pvBookmark, uint cbBookmark, uint* pcbActual, const(uint) grbit);

@DllImport("ESENT.dll")
int JetEscrowUpdate(uint sesid, uint tableid, uint columnid, char* pv, uint cbMax, char* pvOld, uint cbOldMax, uint* pcbOldActual, uint grbit);

@DllImport("ESENT.dll")
int JetRetrieveColumn(uint sesid, uint tableid, uint columnid, char* pvData, uint cbData, uint* pcbActual, uint grbit, JET_RETINFO* pretinfo);

@DllImport("ESENT.dll")
int JetRetrieveColumns(uint sesid, uint tableid, char* pretrievecolumn, uint cretrievecolumn);

@DllImport("ESENT.dll")
int JetEnumerateColumns(uint sesid, uint tableid, uint cEnumColumnId, char* rgEnumColumnId, uint* pcEnumColumn, JET_ENUMCOLUMN** prgEnumColumn, JET_PFNREALLOC pfnRealloc, void* pvReallocContext, uint cbDataMost, uint grbit);

@DllImport("ESENT.dll")
int JetGetRecordSize(uint sesid, uint tableid, JET_RECSIZE* precsize, const(uint) grbit);

@DllImport("ESENT.dll")
int JetGetRecordSize2(uint sesid, uint tableid, JET_RECSIZE2* precsize, const(uint) grbit);

@DllImport("ESENT.dll")
int JetSetColumn(uint sesid, uint tableid, uint columnid, char* pvData, uint cbData, uint grbit, JET_SETINFO* psetinfo);

@DllImport("ESENT.dll")
int JetSetColumns(uint sesid, uint tableid, char* psetcolumn, uint csetcolumn);

@DllImport("ESENT.dll")
int JetPrepareUpdate(uint sesid, uint tableid, uint prep);

@DllImport("ESENT.dll")
int JetGetRecordPosition(uint sesid, uint tableid, char* precpos, uint cbRecpos);

@DllImport("ESENT.dll")
int JetGotoPosition(uint sesid, uint tableid, JET_RECPOS* precpos);

@DllImport("ESENT.dll")
int JetGetCursorInfo(uint sesid, uint tableid, char* pvResult, uint cbMax, uint InfoLevel);

@DllImport("ESENT.dll")
int JetDupCursor(uint sesid, uint tableid, uint* ptableid, uint grbit);

@DllImport("ESENT.dll")
int JetGetCurrentIndexA(uint sesid, uint tableid, char* szIndexName, uint cbIndexName);

@DllImport("ESENT.dll")
int JetGetCurrentIndexW(uint sesid, uint tableid, char* szIndexName, uint cbIndexName);

@DllImport("ESENT.dll")
int JetSetCurrentIndexA(uint sesid, uint tableid, byte* szIndexName);

@DllImport("ESENT.dll")
int JetSetCurrentIndexW(uint sesid, uint tableid, ushort* szIndexName);

@DllImport("ESENT.dll")
int JetSetCurrentIndex2A(uint sesid, uint tableid, byte* szIndexName, uint grbit);

@DllImport("ESENT.dll")
int JetSetCurrentIndex2W(uint sesid, uint tableid, ushort* szIndexName, uint grbit);

@DllImport("ESENT.dll")
int JetSetCurrentIndex3A(uint sesid, uint tableid, byte* szIndexName, uint grbit, uint itagSequence);

@DllImport("ESENT.dll")
int JetSetCurrentIndex3W(uint sesid, uint tableid, ushort* szIndexName, uint grbit, uint itagSequence);

@DllImport("ESENT.dll")
int JetSetCurrentIndex4A(uint sesid, uint tableid, byte* szIndexName, JET_INDEXID* pindexid, uint grbit, uint itagSequence);

@DllImport("ESENT.dll")
int JetSetCurrentIndex4W(uint sesid, uint tableid, ushort* szIndexName, JET_INDEXID* pindexid, uint grbit, uint itagSequence);

@DllImport("ESENT.dll")
int JetMove(uint sesid, uint tableid, int cRow, uint grbit);

@DllImport("ESENT.dll")
int JetSetCursorFilter(uint sesid, uint tableid, char* rgColumnFilters, uint cColumnFilters, uint grbit);

@DllImport("ESENT.dll")
int JetGetLock(uint sesid, uint tableid, uint grbit);

@DllImport("ESENT.dll")
int JetMakeKey(uint sesid, uint tableid, char* pvData, uint cbData, uint grbit);

@DllImport("ESENT.dll")
int JetSeek(uint sesid, uint tableid, uint grbit);

@DllImport("ESENT.dll")
int JetPrereadKeys(uint sesid, uint tableid, char* rgpvKeys, char* rgcbKeys, int ckeys, int* pckeysPreread, uint grbit);

@DllImport("ESENT.dll")
int JetPrereadIndexRanges(uint sesid, uint tableid, char* rgIndexRanges, const(uint) cIndexRanges, uint* pcRangesPreread, char* rgcolumnidPreread, const(uint) ccolumnidPreread, uint grbit);

@DllImport("ESENT.dll")
int JetGetBookmark(uint sesid, uint tableid, char* pvBookmark, uint cbMax, uint* pcbActual);

@DllImport("ESENT.dll")
int JetGetSecondaryIndexBookmark(uint sesid, uint tableid, char* pvSecondaryKey, uint cbSecondaryKeyMax, uint* pcbSecondaryKeyActual, char* pvPrimaryBookmark, uint cbPrimaryBookmarkMax, uint* pcbPrimaryBookmarkActual, const(uint) grbit);

@DllImport("ESENT.dll")
int JetCompactA(uint sesid, byte* szDatabaseSrc, byte* szDatabaseDest, JET_PFNSTATUS pfnStatus, tagCONVERT_A* pconvert, uint grbit);

@DllImport("ESENT.dll")
int JetCompactW(uint sesid, ushort* szDatabaseSrc, ushort* szDatabaseDest, JET_PFNSTATUS pfnStatus, tagCONVERT_W* pconvert, uint grbit);

@DllImport("ESENT.dll")
int JetDefragmentA(uint sesid, uint dbid, byte* szTableName, uint* pcPasses, uint* pcSeconds, uint grbit);

@DllImport("ESENT.dll")
int JetDefragmentW(uint sesid, uint dbid, ushort* szTableName, uint* pcPasses, uint* pcSeconds, uint grbit);

@DllImport("ESENT.dll")
int JetDefragment2A(uint sesid, uint dbid, byte* szTableName, uint* pcPasses, uint* pcSeconds, JET_CALLBACK callback, uint grbit);

@DllImport("ESENT.dll")
int JetDefragment2W(uint sesid, uint dbid, ushort* szTableName, uint* pcPasses, uint* pcSeconds, JET_CALLBACK callback, uint grbit);

@DllImport("ESENT.dll")
int JetDefragment3A(uint sesid, byte* szDatabaseName, byte* szTableName, uint* pcPasses, uint* pcSeconds, JET_CALLBACK callback, void* pvContext, uint grbit);

@DllImport("ESENT.dll")
int JetDefragment3W(uint sesid, ushort* szDatabaseName, ushort* szTableName, uint* pcPasses, uint* pcSeconds, JET_CALLBACK callback, void* pvContext, uint grbit);

@DllImport("ESENT.dll")
int JetSetDatabaseSizeA(uint sesid, byte* szDatabaseName, uint cpg, uint* pcpgReal);

@DllImport("ESENT.dll")
int JetSetDatabaseSizeW(uint sesid, ushort* szDatabaseName, uint cpg, uint* pcpgReal);

@DllImport("ESENT.dll")
int JetGrowDatabase(uint sesid, uint dbid, uint cpg, uint* pcpgReal);

@DllImport("ESENT.dll")
int JetResizeDatabase(uint sesid, uint dbid, uint cpgTarget, uint* pcpgActual, const(uint) grbit);

@DllImport("ESENT.dll")
int JetSetSessionContext(uint sesid, uint ulContext);

@DllImport("ESENT.dll")
int JetResetSessionContext(uint sesid);

@DllImport("ESENT.dll")
int JetGotoBookmark(uint sesid, uint tableid, char* pvBookmark, uint cbBookmark);

@DllImport("ESENT.dll")
int JetGotoSecondaryIndexBookmark(uint sesid, uint tableid, char* pvSecondaryKey, uint cbSecondaryKey, char* pvPrimaryBookmark, uint cbPrimaryBookmark, const(uint) grbit);

@DllImport("ESENT.dll")
int JetIntersectIndexes(uint sesid, char* rgindexrange, uint cindexrange, JET_RECORDLIST* precordlist, uint grbit);

@DllImport("ESENT.dll")
int JetComputeStats(uint sesid, uint tableid);

@DllImport("ESENT.dll")
int JetOpenTempTable(uint sesid, char* prgcolumndef, uint ccolumn, uint grbit, uint* ptableid, char* prgcolumnid);

@DllImport("ESENT.dll")
int JetOpenTempTable2(uint sesid, char* prgcolumndef, uint ccolumn, uint lcid, uint grbit, uint* ptableid, char* prgcolumnid);

@DllImport("ESENT.dll")
int JetOpenTempTable3(uint sesid, char* prgcolumndef, uint ccolumn, JET_UNICODEINDEX* pidxunicode, uint grbit, uint* ptableid, char* prgcolumnid);

@DllImport("ESENT.dll")
int JetOpenTemporaryTable(uint sesid, JET_OPENTEMPORARYTABLE* popentemporarytable);

@DllImport("ESENT.dll")
int JetOpenTemporaryTable2(uint sesid, JET_OPENTEMPORARYTABLE2* popentemporarytable);

@DllImport("ESENT.dll")
int JetBackupA(byte* szBackupPath, uint grbit, JET_PFNSTATUS pfnStatus);

@DllImport("ESENT.dll")
int JetBackupW(ushort* szBackupPath, uint grbit, JET_PFNSTATUS pfnStatus);

@DllImport("ESENT.dll")
int JetBackupInstanceA(uint instance, byte* szBackupPath, uint grbit, JET_PFNSTATUS pfnStatus);

@DllImport("ESENT.dll")
int JetBackupInstanceW(uint instance, ushort* szBackupPath, uint grbit, JET_PFNSTATUS pfnStatus);

@DllImport("ESENT.dll")
int JetRestoreA(byte* szSource, JET_PFNSTATUS pfn);

@DllImport("ESENT.dll")
int JetRestoreW(ushort* szSource, JET_PFNSTATUS pfn);

@DllImport("ESENT.dll")
int JetRestore2A(byte* sz, byte* szDest, JET_PFNSTATUS pfn);

@DllImport("ESENT.dll")
int JetRestore2W(ushort* sz, ushort* szDest, JET_PFNSTATUS pfn);

@DllImport("ESENT.dll")
int JetRestoreInstanceA(uint instance, byte* sz, byte* szDest, JET_PFNSTATUS pfn);

@DllImport("ESENT.dll")
int JetRestoreInstanceW(uint instance, ushort* sz, ushort* szDest, JET_PFNSTATUS pfn);

@DllImport("ESENT.dll")
int JetSetIndexRange(uint sesid, uint tableidSrc, uint grbit);

@DllImport("ESENT.dll")
int JetIndexRecordCount(uint sesid, uint tableid, uint* pcrec, uint crecMax);

@DllImport("ESENT.dll")
int JetRetrieveKey(uint sesid, uint tableid, char* pvKey, uint cbMax, uint* pcbActual, uint grbit);

@DllImport("ESENT.dll")
int JetBeginExternalBackup(uint grbit);

@DllImport("ESENT.dll")
int JetBeginExternalBackupInstance(uint instance, uint grbit);

@DllImport("ESENT.dll")
int JetGetAttachInfoA(char* szzDatabases, uint cbMax, uint* pcbActual);

@DllImport("ESENT.dll")
int JetGetAttachInfoW(char* wszzDatabases, uint cbMax, uint* pcbActual);

@DllImport("ESENT.dll")
int JetGetAttachInfoInstanceA(uint instance, char* szzDatabases, uint cbMax, uint* pcbActual);

@DllImport("ESENT.dll")
int JetGetAttachInfoInstanceW(uint instance, char* szzDatabases, uint cbMax, uint* pcbActual);

@DllImport("ESENT.dll")
int JetOpenFileA(byte* szFileName, uint* phfFile, uint* pulFileSizeLow, uint* pulFileSizeHigh);

@DllImport("ESENT.dll")
int JetOpenFileW(ushort* szFileName, uint* phfFile, uint* pulFileSizeLow, uint* pulFileSizeHigh);

@DllImport("ESENT.dll")
int JetOpenFileInstanceA(uint instance, byte* szFileName, uint* phfFile, uint* pulFileSizeLow, uint* pulFileSizeHigh);

@DllImport("ESENT.dll")
int JetOpenFileInstanceW(uint instance, ushort* szFileName, uint* phfFile, uint* pulFileSizeLow, uint* pulFileSizeHigh);

@DllImport("ESENT.dll")
int JetReadFile(uint hfFile, char* pv, uint cb, uint* pcbActual);

@DllImport("ESENT.dll")
int JetReadFileInstance(uint instance, uint hfFile, char* pv, uint cb, uint* pcbActual);

@DllImport("ESENT.dll")
int JetCloseFile(uint hfFile);

@DllImport("ESENT.dll")
int JetCloseFileInstance(uint instance, uint hfFile);

@DllImport("ESENT.dll")
int JetGetLogInfoA(char* szzLogs, uint cbMax, uint* pcbActual);

@DllImport("ESENT.dll")
int JetGetLogInfoW(char* szzLogs, uint cbMax, uint* pcbActual);

@DllImport("ESENT.dll")
int JetGetLogInfoInstanceA(uint instance, char* szzLogs, uint cbMax, uint* pcbActual);

@DllImport("ESENT.dll")
int JetGetLogInfoInstanceW(uint instance, char* wszzLogs, uint cbMax, uint* pcbActual);

@DllImport("ESENT.dll")
int JetGetLogInfoInstance2A(uint instance, char* szzLogs, uint cbMax, uint* pcbActual, JET_LOGINFO_A* pLogInfo);

@DllImport("ESENT.dll")
int JetGetLogInfoInstance2W(uint instance, char* wszzLogs, uint cbMax, uint* pcbActual, JET_LOGINFO_W* pLogInfo);

@DllImport("ESENT.dll")
int JetGetTruncateLogInfoInstanceA(uint instance, char* szzLogs, uint cbMax, uint* pcbActual);

@DllImport("ESENT.dll")
int JetGetTruncateLogInfoInstanceW(uint instance, char* wszzLogs, uint cbMax, uint* pcbActual);

@DllImport("ESENT.dll")
int JetTruncateLog();

@DllImport("ESENT.dll")
int JetTruncateLogInstance(uint instance);

@DllImport("ESENT.dll")
int JetEndExternalBackup();

@DllImport("ESENT.dll")
int JetEndExternalBackupInstance(uint instance);

@DllImport("ESENT.dll")
int JetEndExternalBackupInstance2(uint instance, uint grbit);

@DllImport("ESENT.dll")
int JetExternalRestoreA(byte* szCheckpointFilePath, byte* szLogPath, char* rgrstmap, int crstfilemap, byte* szBackupLogPath, int genLow, int genHigh, JET_PFNSTATUS pfn);

@DllImport("ESENT.dll")
int JetExternalRestoreW(ushort* szCheckpointFilePath, ushort* szLogPath, char* rgrstmap, int crstfilemap, ushort* szBackupLogPath, int genLow, int genHigh, JET_PFNSTATUS pfn);

@DllImport("ESENT.dll")
int JetExternalRestore2A(byte* szCheckpointFilePath, byte* szLogPath, char* rgrstmap, int crstfilemap, byte* szBackupLogPath, JET_LOGINFO_A* pLogInfo, byte* szTargetInstanceName, byte* szTargetInstanceLogPath, byte* szTargetInstanceCheckpointPath, JET_PFNSTATUS pfn);

@DllImport("ESENT.dll")
int JetExternalRestore2W(ushort* szCheckpointFilePath, ushort* szLogPath, char* rgrstmap, int crstfilemap, ushort* szBackupLogPath, JET_LOGINFO_W* pLogInfo, ushort* szTargetInstanceName, ushort* szTargetInstanceLogPath, ushort* szTargetInstanceCheckpointPath, JET_PFNSTATUS pfn);

@DllImport("ESENT.dll")
int JetRegisterCallback(uint sesid, uint tableid, uint cbtyp, JET_CALLBACK pCallback, void* pvContext, uint* phCallbackId);

@DllImport("ESENT.dll")
int JetUnregisterCallback(uint sesid, uint tableid, uint cbtyp, uint hCallbackId);

@DllImport("ESENT.dll")
int JetGetInstanceInfoA(uint* pcInstanceInfo, JET_INSTANCE_INFO_A** paInstanceInfo);

@DllImport("ESENT.dll")
int JetGetInstanceInfoW(uint* pcInstanceInfo, JET_INSTANCE_INFO_W** paInstanceInfo);

@DllImport("ESENT.dll")
int JetFreeBuffer(byte* pbBuf);

@DllImport("ESENT.dll")
int JetSetLS(uint sesid, uint tableid, uint ls, uint grbit);

@DllImport("ESENT.dll")
int JetGetLS(uint sesid, uint tableid, uint* pls, uint grbit);

@DllImport("ESENT.dll")
int JetOSSnapshotPrepare(uint* psnapId, const(uint) grbit);

@DllImport("ESENT.dll")
int JetOSSnapshotPrepareInstance(uint snapId, uint instance, const(uint) grbit);

@DllImport("ESENT.dll")
int JetOSSnapshotFreezeA(const(uint) snapId, uint* pcInstanceInfo, JET_INSTANCE_INFO_A** paInstanceInfo, const(uint) grbit);

@DllImport("ESENT.dll")
int JetOSSnapshotFreezeW(const(uint) snapId, uint* pcInstanceInfo, JET_INSTANCE_INFO_W** paInstanceInfo, const(uint) grbit);

@DllImport("ESENT.dll")
int JetOSSnapshotThaw(const(uint) snapId, const(uint) grbit);

@DllImport("ESENT.dll")
int JetOSSnapshotAbort(const(uint) snapId, const(uint) grbit);

@DllImport("ESENT.dll")
int JetOSSnapshotTruncateLog(const(uint) snapId, const(uint) grbit);

@DllImport("ESENT.dll")
int JetOSSnapshotTruncateLogInstance(const(uint) snapId, uint instance, const(uint) grbit);

@DllImport("ESENT.dll")
int JetOSSnapshotGetFreezeInfoA(const(uint) snapId, uint* pcInstanceInfo, JET_INSTANCE_INFO_A** paInstanceInfo, const(uint) grbit);

@DllImport("ESENT.dll")
int JetOSSnapshotGetFreezeInfoW(const(uint) snapId, uint* pcInstanceInfo, JET_INSTANCE_INFO_W** paInstanceInfo, const(uint) grbit);

@DllImport("ESENT.dll")
int JetOSSnapshotEnd(const(uint) snapId, const(uint) grbit);

@DllImport("ESENT.dll")
int JetConfigureProcessForCrashDump(const(uint) grbit);

@DllImport("ESENT.dll")
int JetGetErrorInfoW(void* pvContext, char* pvResult, uint cbMax, uint InfoLevel, uint grbit);

@DllImport("ESENT.dll")
int JetSetSessionParameter(uint sesid, uint sesparamid, char* pvParam, uint cbParam);

@DllImport("ESENT.dll")
int JetGetSessionParameter(uint sesid, uint sesparamid, char* pvParam, uint cbParamMax, uint* pcbParamActual);

enum STGC
{
    STGC_DEFAULT = 0,
    STGC_OVERWRITE = 1,
    STGC_ONLYIFCURRENT = 2,
    STGC_DANGEROUSLYCOMMITMERELYTODISKCACHE = 4,
    STGC_CONSOLIDATE = 8,
}

enum STGMOVE
{
    STGMOVE_MOVE = 0,
    STGMOVE_COPY = 1,
    STGMOVE_SHALLOWCOPY = 2,
}

enum STATFLAG
{
    STATFLAG_DEFAULT = 0,
    STATFLAG_NONAME = 1,
    STATFLAG_NOOPEN = 2,
}

struct VERSIONEDSTREAM
{
    Guid guidVersion;
    IStream pStream;
}

struct CAC
{
    uint cElems;
    byte* pElems;
}

struct CAUB
{
    uint cElems;
    ubyte* pElems;
}

struct CAI
{
    uint cElems;
    short* pElems;
}

struct CAUI
{
    uint cElems;
    ushort* pElems;
}

struct CAL
{
    uint cElems;
    int* pElems;
}

struct CAUL
{
    uint cElems;
    uint* pElems;
}

struct CAFLT
{
    uint cElems;
    float* pElems;
}

struct CADBL
{
    uint cElems;
    double* pElems;
}

struct CACY
{
    uint cElems;
    CY* pElems;
}

struct CADATE
{
    uint cElems;
    double* pElems;
}

struct CABSTR
{
    uint cElems;
    BSTR* pElems;
}

struct CABSTRBLOB
{
    uint cElems;
    BSTRBLOB* pElems;
}

struct CABOOL
{
    uint cElems;
    short* pElems;
}

struct CASCODE
{
    uint cElems;
    int* pElems;
}

struct CAPROPVARIANT
{
    uint cElems;
    PROPVARIANT* pElems;
}

struct CAH
{
    uint cElems;
    LARGE_INTEGER* pElems;
}

struct CAUH
{
    uint cElems;
    ULARGE_INTEGER* pElems;
}

struct CALPSTR
{
    uint cElems;
    byte** pElems;
}

struct CALPWSTR
{
    uint cElems;
    ushort** pElems;
}

struct CAFILETIME
{
    uint cElems;
    FILETIME* pElems;
}

struct CACLIPDATA
{
    uint cElems;
    CLIPDATA* pElems;
}

struct CACLSID
{
    uint cElems;
    Guid* pElems;
}

struct PROPVARIANT
{
    _Anonymous_e__Union Anonymous;
}

struct PROPSPEC
{
    uint ulKind;
    _Anonymous_e__Union Anonymous;
}

struct STATPROPSTG
{
    ushort* lpwstrName;
    uint propid;
    ushort vt;
}

struct STATPROPSETSTG
{
    Guid fmtid;
    Guid clsid;
    uint grfFlags;
    FILETIME mtime;
    FILETIME ctime;
    FILETIME atime;
    uint dwOSVersion;
}

const GUID IID_IPropertyStorage = {0x00000138, 0x0000, 0x0000, [0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x46]};
@GUID(0x00000138, 0x0000, 0x0000, [0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x46]);
interface IPropertyStorage : IUnknown
{
    HRESULT ReadMultiple(uint cpspec, char* rgpspec, char* rgpropvar);
    HRESULT WriteMultiple(uint cpspec, char* rgpspec, char* rgpropvar, uint propidNameFirst);
    HRESULT DeleteMultiple(uint cpspec, char* rgpspec);
    HRESULT ReadPropertyNames(uint cpropid, char* rgpropid, char* rglpwstrName);
    HRESULT WritePropertyNames(uint cpropid, char* rgpropid, char* rglpwstrName);
    HRESULT DeletePropertyNames(uint cpropid, char* rgpropid);
    HRESULT Commit(uint grfCommitFlags);
    HRESULT Revert();
    HRESULT Enum(IEnumSTATPROPSTG* ppenum);
    HRESULT SetTimes(const(FILETIME)* pctime, const(FILETIME)* patime, const(FILETIME)* pmtime);
    HRESULT SetClass(const(Guid)* clsid);
    HRESULT Stat(STATPROPSETSTG* pstatpsstg);
}

const GUID IID_IPropertySetStorage = {0x0000013A, 0x0000, 0x0000, [0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x46]};
@GUID(0x0000013A, 0x0000, 0x0000, [0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x46]);
interface IPropertySetStorage : IUnknown
{
    HRESULT Create(const(Guid)* rfmtid, const(Guid)* pclsid, uint grfFlags, uint grfMode, IPropertyStorage* ppprstg);
    HRESULT Open(const(Guid)* rfmtid, uint grfMode, IPropertyStorage* ppprstg);
    HRESULT Delete(const(Guid)* rfmtid);
    HRESULT Enum(IEnumSTATPROPSETSTG* ppenum);
}

const GUID IID_IEnumSTATPROPSTG = {0x00000139, 0x0000, 0x0000, [0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x46]};
@GUID(0x00000139, 0x0000, 0x0000, [0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x46]);
interface IEnumSTATPROPSTG : IUnknown
{
    HRESULT Next(uint celt, char* rgelt, uint* pceltFetched);
    HRESULT Skip(uint celt);
    HRESULT Reset();
    HRESULT Clone(IEnumSTATPROPSTG* ppenum);
}

const GUID IID_IEnumSTATPROPSETSTG = {0x0000013B, 0x0000, 0x0000, [0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x46]};
@GUID(0x0000013B, 0x0000, 0x0000, [0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x46]);
interface IEnumSTATPROPSETSTG : IUnknown
{
    HRESULT Next(uint celt, char* rgelt, uint* pceltFetched);
    HRESULT Skip(uint celt);
    HRESULT Reset();
    HRESULT Clone(IEnumSTATPROPSETSTG* ppenum);
}

struct STGOPTIONS
{
    ushort usVersion;
    ushort reserved;
    uint ulSectorSize;
    const(wchar)* pwcsTemplateFile;
}

enum PIDMSI_STATUS_VALUE
{
    PIDMSI_STATUS_NORMAL = 0,
    PIDMSI_STATUS_NEW = 1,
    PIDMSI_STATUS_PRELIM = 2,
    PIDMSI_STATUS_DRAFT = 3,
    PIDMSI_STATUS_INPROGRESS = 4,
    PIDMSI_STATUS_EDIT = 5,
    PIDMSI_STATUS_REVIEW = 6,
    PIDMSI_STATUS_PROOF = 7,
    PIDMSI_STATUS_FINAL = 8,
    PIDMSI_STATUS_OTHER = 32767,
}

struct PMemoryAllocator
{
}

struct JET_INDEXID
{
    uint cbStruct;
    ubyte rgbIndexId;
}

alias JET_PFNSTATUS = extern(Windows) int function(uint sesid, uint snp, uint snt, void* pv);
struct JET_RSTMAP_A
{
    byte* szDatabaseName;
    byte* szNewDatabaseName;
}

struct JET_RSTMAP_W
{
    ushort* szDatabaseName;
    ushort* szNewDatabaseName;
}

struct tagCONVERT_A
{
    byte* szOldDll;
    _Anonymous_e__Union Anonymous;
}

struct tagCONVERT_W
{
    ushort* szOldDll;
    _Anonymous_e__Union Anonymous;
}

alias JET_CALLBACK = extern(Windows) int function(uint sesid, uint dbid, uint tableid, uint cbtyp, void* pvArg1, void* pvArg2, void* pvContext, uint ulUnused);
struct JET_SNPROG
{
    uint cbStruct;
    uint cunitDone;
    uint cunitTotal;
}

struct JET_DBINFOUPGRADE
{
    uint cbStruct;
    uint cbFilesizeLow;
    uint cbFilesizeHigh;
    uint cbFreeSpaceRequiredLow;
    uint cbFreeSpaceRequiredHigh;
    uint csecToUpgrade;
    _Anonymous_e__Union Anonymous;
}

struct JET_OBJECTINFO
{
    uint cbStruct;
    uint objtyp;
    double dtCreate;
    double dtUpdate;
    uint grbit;
    uint flags;
    uint cRecord;
    uint cPage;
}

struct JET_OBJECTLIST
{
    uint cbStruct;
    uint tableid;
    uint cRecord;
    uint columnidcontainername;
    uint columnidobjectname;
    uint columnidobjtyp;
    uint columniddtCreate;
    uint columniddtUpdate;
    uint columnidgrbit;
    uint columnidflags;
    uint columnidcRecord;
    uint columnidcPage;
}

struct JET_COLUMNLIST
{
    uint cbStruct;
    uint tableid;
    uint cRecord;
    uint columnidPresentationOrder;
    uint columnidcolumnname;
    uint columnidcolumnid;
    uint columnidcoltyp;
    uint columnidCountry;
    uint columnidLangid;
    uint columnidCp;
    uint columnidCollate;
    uint columnidcbMax;
    uint columnidgrbit;
    uint columnidDefault;
    uint columnidBaseTableName;
    uint columnidBaseColumnName;
    uint columnidDefinitionName;
}

struct JET_COLUMNDEF
{
    uint cbStruct;
    uint columnid;
    uint coltyp;
    ushort wCountry;
    ushort langid;
    ushort cp;
    ushort wCollate;
    uint cbMax;
    uint grbit;
}

struct JET_COLUMNBASE_A
{
    uint cbStruct;
    uint columnid;
    uint coltyp;
    ushort wCountry;
    ushort langid;
    ushort cp;
    ushort wFiller;
    uint cbMax;
    uint grbit;
    byte szBaseTableName;
    byte szBaseColumnName;
}

struct JET_COLUMNBASE_W
{
    uint cbStruct;
    uint columnid;
    uint coltyp;
    ushort wCountry;
    ushort langid;
    ushort cp;
    ushort wFiller;
    uint cbMax;
    uint grbit;
    ushort szBaseTableName;
    ushort szBaseColumnName;
}

struct JET_INDEXLIST
{
    uint cbStruct;
    uint tableid;
    uint cRecord;
    uint columnidindexname;
    uint columnidgrbitIndex;
    uint columnidcKey;
    uint columnidcEntry;
    uint columnidcPage;
    uint columnidcColumn;
    uint columnidiColumn;
    uint columnidcolumnid;
    uint columnidcoltyp;
    uint columnidCountry;
    uint columnidLangid;
    uint columnidCp;
    uint columnidCollate;
    uint columnidgrbitColumn;
    uint columnidcolumnname;
    uint columnidLCMapFlags;
}

struct tag_JET_COLUMNCREATE_A
{
    uint cbStruct;
    byte* szColumnName;
    uint coltyp;
    uint cbMax;
    uint grbit;
    void* pvDefault;
    uint cbDefault;
    uint cp;
    uint columnid;
    int err;
}

struct tag_JET_COLUMNCREATE_W
{
    uint cbStruct;
    ushort* szColumnName;
    uint coltyp;
    uint cbMax;
    uint grbit;
    void* pvDefault;
    uint cbDefault;
    uint cp;
    uint columnid;
    int err;
}

struct tag_JET_USERDEFINEDDEFAULT_A
{
    byte* szCallback;
    ubyte* pbUserData;
    uint cbUserData;
    byte* szDependantColumns;
}

struct tag_JET_USERDEFINEDDEFAULT_W
{
    ushort* szCallback;
    ubyte* pbUserData;
    uint cbUserData;
    ushort* szDependantColumns;
}

struct JET_CONDITIONALCOLUMN_A
{
    uint cbStruct;
    byte* szColumnName;
    uint grbit;
}

struct JET_CONDITIONALCOLUMN_W
{
    uint cbStruct;
    ushort* szColumnName;
    uint grbit;
}

struct JET_UNICODEINDEX
{
    uint lcid;
    uint dwMapFlags;
}

struct JET_UNICODEINDEX2
{
    ushort* szLocaleName;
    uint dwMapFlags;
}

struct JET_TUPLELIMITS
{
    uint chLengthMin;
    uint chLengthMax;
    uint chToIndexMax;
    uint cchIncrement;
    uint ichStart;
}

struct JET_SPACEHINTS
{
    uint cbStruct;
    uint ulInitialDensity;
    uint cbInitial;
    uint grbit;
    uint ulMaintDensity;
    uint ulGrowth;
    uint cbMinExtent;
    uint cbMaxExtent;
}

struct JET_INDEXCREATE_A
{
    uint cbStruct;
    byte* szIndexName;
    byte* szKey;
    uint cbKey;
    uint grbit;
    uint ulDensity;
    _Anonymous1_e__Union Anonymous1;
    _Anonymous2_e__Union Anonymous2;
    JET_CONDITIONALCOLUMN_A* rgconditionalcolumn;
    uint cConditionalColumn;
    int err;
    uint cbKeyMost;
}

struct JET_INDEXCREATE_W
{
    uint cbStruct;
    ushort* szIndexName;
    ushort* szKey;
    uint cbKey;
    uint grbit;
    uint ulDensity;
    _Anonymous1_e__Union Anonymous1;
    _Anonymous2_e__Union Anonymous2;
    JET_CONDITIONALCOLUMN_W* rgconditionalcolumn;
    uint cConditionalColumn;
    int err;
    uint cbKeyMost;
}

struct JET_INDEXCREATE2_A
{
    uint cbStruct;
    byte* szIndexName;
    byte* szKey;
    uint cbKey;
    uint grbit;
    uint ulDensity;
    _Anonymous1_e__Union Anonymous1;
    _Anonymous2_e__Union Anonymous2;
    JET_CONDITIONALCOLUMN_A* rgconditionalcolumn;
    uint cConditionalColumn;
    int err;
    uint cbKeyMost;
    JET_SPACEHINTS* pSpacehints;
}

struct JET_INDEXCREATE2_W
{
    uint cbStruct;
    ushort* szIndexName;
    ushort* szKey;
    uint cbKey;
    uint grbit;
    uint ulDensity;
    _Anonymous1_e__Union Anonymous1;
    _Anonymous2_e__Union Anonymous2;
    JET_CONDITIONALCOLUMN_W* rgconditionalcolumn;
    uint cConditionalColumn;
    int err;
    uint cbKeyMost;
    JET_SPACEHINTS* pSpacehints;
}

struct JET_INDEXCREATE3_A
{
    uint cbStruct;
    byte* szIndexName;
    byte* szKey;
    uint cbKey;
    uint grbit;
    uint ulDensity;
    JET_UNICODEINDEX2* pidxunicode;
    _Anonymous_e__Union Anonymous;
    JET_CONDITIONALCOLUMN_A* rgconditionalcolumn;
    uint cConditionalColumn;
    int err;
    uint cbKeyMost;
    JET_SPACEHINTS* pSpacehints;
}

struct JET_INDEXCREATE3_W
{
    uint cbStruct;
    ushort* szIndexName;
    ushort* szKey;
    uint cbKey;
    uint grbit;
    uint ulDensity;
    JET_UNICODEINDEX2* pidxunicode;
    _Anonymous_e__Union Anonymous;
    JET_CONDITIONALCOLUMN_W* rgconditionalcolumn;
    uint cConditionalColumn;
    int err;
    uint cbKeyMost;
    JET_SPACEHINTS* pSpacehints;
}

struct JET_TABLECREATE_A
{
    uint cbStruct;
    byte* szTableName;
    byte* szTemplateTableName;
    uint ulPages;
    uint ulDensity;
    tag_JET_COLUMNCREATE_A* rgcolumncreate;
    uint cColumns;
    JET_INDEXCREATE_A* rgindexcreate;
    uint cIndexes;
    uint grbit;
    uint tableid;
    uint cCreated;
}

struct JET_TABLECREATE_W
{
    uint cbStruct;
    ushort* szTableName;
    ushort* szTemplateTableName;
    uint ulPages;
    uint ulDensity;
    tag_JET_COLUMNCREATE_W* rgcolumncreate;
    uint cColumns;
    JET_INDEXCREATE_W* rgindexcreate;
    uint cIndexes;
    uint grbit;
    uint tableid;
    uint cCreated;
}

struct JET_TABLECREATE2_A
{
    uint cbStruct;
    byte* szTableName;
    byte* szTemplateTableName;
    uint ulPages;
    uint ulDensity;
    tag_JET_COLUMNCREATE_A* rgcolumncreate;
    uint cColumns;
    JET_INDEXCREATE_A* rgindexcreate;
    uint cIndexes;
    byte* szCallback;
    uint cbtyp;
    uint grbit;
    uint tableid;
    uint cCreated;
}

struct JET_TABLECREATE2_W
{
    uint cbStruct;
    ushort* szTableName;
    ushort* szTemplateTableName;
    uint ulPages;
    uint ulDensity;
    tag_JET_COLUMNCREATE_W* rgcolumncreate;
    uint cColumns;
    JET_INDEXCREATE_W* rgindexcreate;
    uint cIndexes;
    ushort* szCallback;
    uint cbtyp;
    uint grbit;
    uint tableid;
    uint cCreated;
}

struct JET_TABLECREATE3_A
{
    uint cbStruct;
    byte* szTableName;
    byte* szTemplateTableName;
    uint ulPages;
    uint ulDensity;
    tag_JET_COLUMNCREATE_A* rgcolumncreate;
    uint cColumns;
    JET_INDEXCREATE2_A* rgindexcreate;
    uint cIndexes;
    byte* szCallback;
    uint cbtyp;
    uint grbit;
    JET_SPACEHINTS* pSeqSpacehints;
    JET_SPACEHINTS* pLVSpacehints;
    uint cbSeparateLV;
    uint tableid;
    uint cCreated;
}

struct JET_TABLECREATE3_W
{
    uint cbStruct;
    ushort* szTableName;
    ushort* szTemplateTableName;
    uint ulPages;
    uint ulDensity;
    tag_JET_COLUMNCREATE_W* rgcolumncreate;
    uint cColumns;
    JET_INDEXCREATE2_W* rgindexcreate;
    uint cIndexes;
    ushort* szCallback;
    uint cbtyp;
    uint grbit;
    JET_SPACEHINTS* pSeqSpacehints;
    JET_SPACEHINTS* pLVSpacehints;
    uint cbSeparateLV;
    uint tableid;
    uint cCreated;
}

struct JET_TABLECREATE4_A
{
    uint cbStruct;
    byte* szTableName;
    byte* szTemplateTableName;
    uint ulPages;
    uint ulDensity;
    tag_JET_COLUMNCREATE_A* rgcolumncreate;
    uint cColumns;
    JET_INDEXCREATE3_A* rgindexcreate;
    uint cIndexes;
    byte* szCallback;
    uint cbtyp;
    uint grbit;
    JET_SPACEHINTS* pSeqSpacehints;
    JET_SPACEHINTS* pLVSpacehints;
    uint cbSeparateLV;
    uint tableid;
    uint cCreated;
}

struct JET_TABLECREATE4_W
{
    uint cbStruct;
    ushort* szTableName;
    ushort* szTemplateTableName;
    uint ulPages;
    uint ulDensity;
    tag_JET_COLUMNCREATE_W* rgcolumncreate;
    uint cColumns;
    JET_INDEXCREATE3_W* rgindexcreate;
    uint cIndexes;
    ushort* szCallback;
    uint cbtyp;
    uint grbit;
    JET_SPACEHINTS* pSeqSpacehints;
    JET_SPACEHINTS* pLVSpacehints;
    uint cbSeparateLV;
    uint tableid;
    uint cCreated;
}

struct JET_OPENTEMPORARYTABLE
{
    uint cbStruct;
    const(JET_COLUMNDEF)* prgcolumndef;
    uint ccolumn;
    JET_UNICODEINDEX* pidxunicode;
    uint grbit;
    uint* prgcolumnid;
    uint cbKeyMost;
    uint cbVarSegMac;
    uint tableid;
}

struct JET_OPENTEMPORARYTABLE2
{
    uint cbStruct;
    const(JET_COLUMNDEF)* prgcolumndef;
    uint ccolumn;
    JET_UNICODEINDEX2* pidxunicode;
    uint grbit;
    uint* prgcolumnid;
    uint cbKeyMost;
    uint cbVarSegMac;
    uint tableid;
}

struct JET_RETINFO
{
    uint cbStruct;
    uint ibLongValue;
    uint itagSequence;
    uint columnidNextTagged;
}

struct JET_SETINFO
{
    uint cbStruct;
    uint ibLongValue;
    uint itagSequence;
}

struct JET_RECPOS
{
    uint cbStruct;
    uint centriesLT;
    uint centriesInRange;
    uint centriesTotal;
}

struct JET_RECORDLIST
{
    uint cbStruct;
    uint tableid;
    uint cRecord;
    uint columnidBookmark;
}

struct JET_INDEXRANGE
{
    uint cbStruct;
    uint tableid;
    uint grbit;
}

enum JET_RELOP
{
    JET_relopEquals = 0,
    JET_relopPrefixEquals = 1,
    JET_relopNotEquals = 2,
    JET_relopLessThanOrEqual = 3,
    JET_relopLessThan = 4,
    JET_relopGreaterThanOrEqual = 5,
    JET_relopGreaterThan = 6,
    JET_relopBitmaskEqualsZero = 7,
    JET_relopBitmaskNotEqualsZero = 8,
}

struct JET_INDEX_COLUMN
{
    uint columnid;
    JET_RELOP relop;
    void* pv;
    uint cb;
    uint grbit;
}

struct JET_INDEX_RANGE
{
    JET_INDEX_COLUMN* rgStartColumns;
    uint cStartColumns;
    JET_INDEX_COLUMN* rgEndColumns;
    uint cEndColumns;
}

struct JET_LOGTIME
{
    byte bSeconds;
    byte bMinutes;
    byte bHours;
    byte bDay;
    byte bMonth;
    byte bYear;
    _Anonymous1_e__Union Anonymous1;
    _Anonymous2_e__Union Anonymous2;
}

struct JET_BKLOGTIME
{
    byte bSeconds;
    byte bMinutes;
    byte bHours;
    byte bDay;
    byte bMonth;
    byte bYear;
    _Anonymous1_e__Union Anonymous1;
    _Anonymous2_e__Union Anonymous2;
}

struct JET_LGPOS
{
    ushort ib;
    ushort isec;
    int lGeneration;
}

struct JET_SIGNATURE
{
    uint ulRandom;
    JET_LOGTIME logtimeCreate;
    byte szComputerName;
}

struct JET_BKINFO
{
    JET_LGPOS lgposMark;
    _Anonymous_e__Union Anonymous;
    uint genLow;
    uint genHigh;
}

struct JET_DBINFOMISC
{
    uint ulVersion;
    uint ulUpdate;
    JET_SIGNATURE signDb;
    uint dbstate;
    JET_LGPOS lgposConsistent;
    JET_LOGTIME logtimeConsistent;
    JET_LOGTIME logtimeAttach;
    JET_LGPOS lgposAttach;
    JET_LOGTIME logtimeDetach;
    JET_LGPOS lgposDetach;
    JET_SIGNATURE signLog;
    JET_BKINFO bkinfoFullPrev;
    JET_BKINFO bkinfoIncPrev;
    JET_BKINFO bkinfoFullCur;
    uint fShadowingDisabled;
    uint fUpgradeDb;
    uint dwMajorVersion;
    uint dwMinorVersion;
    uint dwBuildNumber;
    int lSPNumber;
    uint cbPageSize;
}

struct JET_DBINFOMISC2
{
    uint ulVersion;
    uint ulUpdate;
    JET_SIGNATURE signDb;
    uint dbstate;
    JET_LGPOS lgposConsistent;
    JET_LOGTIME logtimeConsistent;
    JET_LOGTIME logtimeAttach;
    JET_LGPOS lgposAttach;
    JET_LOGTIME logtimeDetach;
    JET_LGPOS lgposDetach;
    JET_SIGNATURE signLog;
    JET_BKINFO bkinfoFullPrev;
    JET_BKINFO bkinfoIncPrev;
    JET_BKINFO bkinfoFullCur;
    uint fShadowingDisabled;
    uint fUpgradeDb;
    uint dwMajorVersion;
    uint dwMinorVersion;
    uint dwBuildNumber;
    int lSPNumber;
    uint cbPageSize;
    uint genMinRequired;
    uint genMaxRequired;
    JET_LOGTIME logtimeGenMaxCreate;
    uint ulRepairCount;
    JET_LOGTIME logtimeRepair;
    uint ulRepairCountOld;
    uint ulECCFixSuccess;
    JET_LOGTIME logtimeECCFixSuccess;
    uint ulECCFixSuccessOld;
    uint ulECCFixFail;
    JET_LOGTIME logtimeECCFixFail;
    uint ulECCFixFailOld;
    uint ulBadChecksum;
    JET_LOGTIME logtimeBadChecksum;
    uint ulBadChecksumOld;
}

struct JET_DBINFOMISC3
{
    uint ulVersion;
    uint ulUpdate;
    JET_SIGNATURE signDb;
    uint dbstate;
    JET_LGPOS lgposConsistent;
    JET_LOGTIME logtimeConsistent;
    JET_LOGTIME logtimeAttach;
    JET_LGPOS lgposAttach;
    JET_LOGTIME logtimeDetach;
    JET_LGPOS lgposDetach;
    JET_SIGNATURE signLog;
    JET_BKINFO bkinfoFullPrev;
    JET_BKINFO bkinfoIncPrev;
    JET_BKINFO bkinfoFullCur;
    uint fShadowingDisabled;
    uint fUpgradeDb;
    uint dwMajorVersion;
    uint dwMinorVersion;
    uint dwBuildNumber;
    int lSPNumber;
    uint cbPageSize;
    uint genMinRequired;
    uint genMaxRequired;
    JET_LOGTIME logtimeGenMaxCreate;
    uint ulRepairCount;
    JET_LOGTIME logtimeRepair;
    uint ulRepairCountOld;
    uint ulECCFixSuccess;
    JET_LOGTIME logtimeECCFixSuccess;
    uint ulECCFixSuccessOld;
    uint ulECCFixFail;
    JET_LOGTIME logtimeECCFixFail;
    uint ulECCFixFailOld;
    uint ulBadChecksum;
    JET_LOGTIME logtimeBadChecksum;
    uint ulBadChecksumOld;
    uint genCommitted;
}

struct JET_DBINFOMISC4
{
    uint ulVersion;
    uint ulUpdate;
    JET_SIGNATURE signDb;
    uint dbstate;
    JET_LGPOS lgposConsistent;
    JET_LOGTIME logtimeConsistent;
    JET_LOGTIME logtimeAttach;
    JET_LGPOS lgposAttach;
    JET_LOGTIME logtimeDetach;
    JET_LGPOS lgposDetach;
    JET_SIGNATURE signLog;
    JET_BKINFO bkinfoFullPrev;
    JET_BKINFO bkinfoIncPrev;
    JET_BKINFO bkinfoFullCur;
    uint fShadowingDisabled;
    uint fUpgradeDb;
    uint dwMajorVersion;
    uint dwMinorVersion;
    uint dwBuildNumber;
    int lSPNumber;
    uint cbPageSize;
    uint genMinRequired;
    uint genMaxRequired;
    JET_LOGTIME logtimeGenMaxCreate;
    uint ulRepairCount;
    JET_LOGTIME logtimeRepair;
    uint ulRepairCountOld;
    uint ulECCFixSuccess;
    JET_LOGTIME logtimeECCFixSuccess;
    uint ulECCFixSuccessOld;
    uint ulECCFixFail;
    JET_LOGTIME logtimeECCFixFail;
    uint ulECCFixFailOld;
    uint ulBadChecksum;
    JET_LOGTIME logtimeBadChecksum;
    uint ulBadChecksumOld;
    uint genCommitted;
    JET_BKINFO bkinfoCopyPrev;
    JET_BKINFO bkinfoDiffPrev;
}

struct JET_THREADSTATS
{
    uint cbStruct;
    uint cPageReferenced;
    uint cPageRead;
    uint cPagePreread;
    uint cPageDirtied;
    uint cPageRedirtied;
    uint cLogRecord;
    uint cbLogRecord;
}

struct JET_THREADSTATS2
{
    uint cbStruct;
    uint cPageReferenced;
    uint cPageRead;
    uint cPagePreread;
    uint cPageDirtied;
    uint cPageRedirtied;
    uint cLogRecord;
    uint cbLogRecord;
    ulong cusecPageCacheMiss;
    uint cPageCacheMiss;
}

struct JET_RSTINFO_A
{
    uint cbStruct;
    JET_RSTMAP_A* rgrstmap;
    int crstmap;
    JET_LGPOS lgposStop;
    JET_LOGTIME logtimeStop;
    JET_PFNSTATUS pfnStatus;
}

struct JET_RSTINFO_W
{
    uint cbStruct;
    JET_RSTMAP_W* rgrstmap;
    int crstmap;
    JET_LGPOS lgposStop;
    JET_LOGTIME logtimeStop;
    JET_PFNSTATUS pfnStatus;
}

enum JET_ERRCAT
{
    JET_errcatUnknown = 0,
    JET_errcatError = 1,
    JET_errcatOperation = 2,
    JET_errcatFatal = 3,
    JET_errcatIO = 4,
    JET_errcatResource = 5,
    JET_errcatMemory = 6,
    JET_errcatQuota = 7,
    JET_errcatDisk = 8,
    JET_errcatData = 9,
    JET_errcatCorruption = 10,
    JET_errcatInconsistent = 11,
    JET_errcatFragmentation = 12,
    JET_errcatApi = 13,
    JET_errcatUsage = 14,
    JET_errcatState = 15,
    JET_errcatObsolete = 16,
    JET_errcatMax = 17,
}

struct JET_ERRINFOBASIC_W
{
    uint cbStruct;
    int errValue;
    JET_ERRCAT errcatMostSpecific;
    ubyte rgCategoricalHierarchy;
    uint lSourceLine;
    ushort rgszSourceFile;
}

struct JET_COMMIT_ID
{
    JET_SIGNATURE signLog;
    int reserved;
    long commitId;
}

alias JET_PFNDURABLECOMMITCALLBACK = extern(Windows) int function(uint instance, JET_COMMIT_ID* pCommitIdSeen, uint grbit);
enum JET_INDEXCHECKING
{
    JET_IndexCheckingOff = 0,
    JET_IndexCheckingOn = 1,
    JET_IndexCheckingDeferToOpenTable = 2,
    JET_IndexCheckingMax = 3,
}

struct JET_OPERATIONCONTEXT
{
    uint ulUserID;
    ubyte nOperationID;
    ubyte nOperationType;
    ubyte nClientType;
    ubyte fFlags;
}

struct JET_SETCOLUMN
{
    uint columnid;
    const(void)* pvData;
    uint cbData;
    uint grbit;
    uint ibLongValue;
    uint itagSequence;
    int err;
}

struct JET_SETSYSPARAM_A
{
    uint paramid;
    uint lParam;
    const(byte)* sz;
    int err;
}

struct JET_SETSYSPARAM_W
{
    uint paramid;
    uint lParam;
    const(wchar)* sz;
    int err;
}

struct JET_RETRIEVECOLUMN
{
    uint columnid;
    void* pvData;
    uint cbData;
    uint cbActual;
    uint grbit;
    uint ibLongValue;
    uint itagSequence;
    uint columnidNextTagged;
    int err;
}

struct JET_ENUMCOLUMNID
{
    uint columnid;
    uint ctagSequence;
    uint* rgtagSequence;
}

struct JET_ENUMCOLUMNVALUE
{
    uint itagSequence;
    int err;
    uint cbData;
    void* pvData;
}

struct JET_ENUMCOLUMN
{
    uint columnid;
    int err;
    _Anonymous_e__Union Anonymous;
}

alias JET_PFNREALLOC = extern(Windows) void* function(void* pvContext, void* pv, uint cb);
struct JET_RECSIZE
{
    ulong cbData;
    ulong cbLongValueData;
    ulong cbOverhead;
    ulong cbLongValueOverhead;
    ulong cNonTaggedColumns;
    ulong cTaggedColumns;
    ulong cLongValues;
    ulong cMultiValues;
}

struct JET_RECSIZE2
{
    ulong cbData;
    ulong cbLongValueData;
    ulong cbOverhead;
    ulong cbLongValueOverhead;
    ulong cNonTaggedColumns;
    ulong cTaggedColumns;
    ulong cLongValues;
    ulong cMultiValues;
    ulong cCompressedColumns;
    ulong cbDataCompressed;
    ulong cbLongValueDataCompressed;
}

struct JET_LOGINFO_A
{
    uint cbSize;
    uint ulGenLow;
    uint ulGenHigh;
    byte szBaseName;
}

struct JET_LOGINFO_W
{
    uint cbSize;
    uint ulGenLow;
    uint ulGenHigh;
    ushort szBaseName;
}

struct JET_INSTANCE_INFO_A
{
    uint hInstanceId;
    byte* szInstanceName;
    uint cDatabases;
    byte** szDatabaseFileName;
    byte** szDatabaseDisplayName;
    byte** szDatabaseSLVFileName_Obsolete;
}

struct JET_INSTANCE_INFO_W
{
    uint hInstanceId;
    ushort* szInstanceName;
    uint cDatabases;
    ushort** szDatabaseFileName;
    ushort** szDatabaseDisplayName;
    ushort** szDatabaseSLVFileName_Obsolete;
}

