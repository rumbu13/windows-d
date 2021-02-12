module windows.automation;

public import system;
public import windows.com;
public import windows.systemservices;
public import windows.windowsandmessaging;
public import windows.windowsprogramming;

extern(Windows):

@DllImport("OLEAUT32.dll")
uint BSTR_UserSize(uint* param0, uint param1, BSTR* param2);

@DllImport("OLEAUT32.dll")
ubyte* BSTR_UserMarshal(uint* param0, ubyte* param1, BSTR* param2);

@DllImport("OLEAUT32.dll")
ubyte* BSTR_UserUnmarshal(uint* param0, char* param1, BSTR* param2);

@DllImport("OLEAUT32.dll")
void BSTR_UserFree(uint* param0, BSTR* param1);

@DllImport("OLEAUT32.dll")
uint LPSAFEARRAY_UserSize(uint* param0, uint param1, SAFEARRAY** param2);

@DllImport("OLEAUT32.dll")
ubyte* LPSAFEARRAY_UserMarshal(uint* param0, ubyte* param1, SAFEARRAY** param2);

@DllImport("OLEAUT32.dll")
ubyte* LPSAFEARRAY_UserUnmarshal(uint* param0, char* param1, SAFEARRAY** param2);

@DllImport("OLEAUT32.dll")
void LPSAFEARRAY_UserFree(uint* param0, SAFEARRAY** param1);

@DllImport("OLEAUT32.dll")
uint BSTR_UserSize64(uint* param0, uint param1, BSTR* param2);

@DllImport("OLEAUT32.dll")
ubyte* BSTR_UserMarshal64(uint* param0, ubyte* param1, BSTR* param2);

@DllImport("OLEAUT32.dll")
ubyte* BSTR_UserUnmarshal64(uint* param0, char* param1, BSTR* param2);

@DllImport("OLEAUT32.dll")
void BSTR_UserFree64(uint* param0, BSTR* param1);

@DllImport("OLEAUT32.dll")
uint LPSAFEARRAY_UserSize64(uint* param0, uint param1, SAFEARRAY** param2);

@DllImport("OLEAUT32.dll")
ubyte* LPSAFEARRAY_UserMarshal64(uint* param0, ubyte* param1, SAFEARRAY** param2);

@DllImport("OLEAUT32.dll")
ubyte* LPSAFEARRAY_UserUnmarshal64(uint* param0, char* param1, SAFEARRAY** param2);

@DllImport("OLEAUT32.dll")
void LPSAFEARRAY_UserFree64(uint* param0, SAFEARRAY** param1);

@DllImport("OLEAUT32.dll")
uint VARIANT_UserSize(uint* param0, uint param1, VARIANT* param2);

@DllImport("OLEAUT32.dll")
ubyte* VARIANT_UserMarshal(uint* param0, ubyte* param1, VARIANT* param2);

@DllImport("OLEAUT32.dll")
ubyte* VARIANT_UserUnmarshal(uint* param0, char* param1, VARIANT* param2);

@DllImport("OLEAUT32.dll")
void VARIANT_UserFree(uint* param0, VARIANT* param1);

@DllImport("OLEAUT32.dll")
uint VARIANT_UserSize64(uint* param0, uint param1, VARIANT* param2);

@DllImport("OLEAUT32.dll")
ubyte* VARIANT_UserMarshal64(uint* param0, ubyte* param1, VARIANT* param2);

@DllImport("OLEAUT32.dll")
ubyte* VARIANT_UserUnmarshal64(uint* param0, char* param1, VARIANT* param2);

@DllImport("OLEAUT32.dll")
void VARIANT_UserFree64(uint* param0, VARIANT* param1);

@DllImport("OLE32.dll")
uint HWND_UserSize(uint* param0, uint param1, HWND* param2);

@DllImport("OLE32.dll")
ubyte* HWND_UserMarshal(uint* param0, ubyte* param1, HWND* param2);

@DllImport("OLE32.dll")
ubyte* HWND_UserUnmarshal(uint* param0, char* param1, HWND* param2);

@DllImport("OLE32.dll")
void HWND_UserFree(uint* param0, HWND* param1);

@DllImport("OLE32.dll")
uint HWND_UserSize64(uint* param0, uint param1, HWND* param2);

@DllImport("OLE32.dll")
ubyte* HWND_UserMarshal64(uint* param0, ubyte* param1, HWND* param2);

@DllImport("OLE32.dll")
ubyte* HWND_UserUnmarshal64(uint* param0, char* param1, HWND* param2);

@DllImport("OLE32.dll")
void HWND_UserFree64(uint* param0, HWND* param1);

@DllImport("OLE32.dll")
uint STGMEDIUM_UserSize(uint* param0, uint param1, STGMEDIUM* param2);

@DllImport("OLE32.dll")
ubyte* STGMEDIUM_UserMarshal(uint* param0, ubyte* param1, STGMEDIUM* param2);

@DllImport("OLE32.dll")
ubyte* STGMEDIUM_UserUnmarshal(uint* param0, char* param1, STGMEDIUM* param2);

@DllImport("OLE32.dll")
void STGMEDIUM_UserFree(uint* param0, STGMEDIUM* param1);

@DllImport("OLE32.dll")
uint STGMEDIUM_UserSize64(uint* param0, uint param1, STGMEDIUM* param2);

@DllImport("OLE32.dll")
ubyte* STGMEDIUM_UserMarshal64(uint* param0, ubyte* param1, STGMEDIUM* param2);

@DllImport("OLE32.dll")
ubyte* STGMEDIUM_UserUnmarshal64(uint* param0, char* param1, STGMEDIUM* param2);

@DllImport("OLE32.dll")
void STGMEDIUM_UserFree64(uint* param0, STGMEDIUM* param1);

@DllImport("OLEAUT32.dll")
HRESULT OleLoadPictureFile(VARIANT varFileName, IDispatch* lplpdispPicture);

@DllImport("OLEAUT32.dll")
HRESULT OleLoadPictureFileEx(VARIANT varFileName, uint xSizeDesired, uint ySizeDesired, uint dwFlags, IDispatch* lplpdispPicture);

@DllImport("OLEAUT32.dll")
HRESULT OleSavePictureFile(IDispatch lpdispPicture, BSTR bstrFileName);

@DllImport("OLEAUT32.dll")
BSTR SysAllocString(const(ushort)* psz);

@DllImport("OLEAUT32.dll")
int SysReAllocString(char* pbstr, const(ushort)* psz);

@DllImport("OLEAUT32.dll")
BSTR SysAllocStringLen(char* strIn, uint ui);

@DllImport("OLEAUT32.dll")
int SysReAllocStringLen(char* pbstr, const(ushort)* psz, uint len);

@DllImport("OLEAUT32.dll")
HRESULT SysAddRefString(BSTR bstrString);

@DllImport("OLEAUT32.dll")
void SysReleaseString(BSTR bstrString);

@DllImport("OLEAUT32.dll")
void SysFreeString(BSTR bstrString);

@DllImport("OLEAUT32.dll")
uint SysStringLen(BSTR pbstr);

@DllImport("OLEAUT32.dll")
uint SysStringByteLen(BSTR bstr);

@DllImport("OLEAUT32.dll")
BSTR SysAllocStringByteLen(const(char)* psz, uint len);

@DllImport("OLEAUT32.dll")
int DosDateTimeToVariantTime(ushort wDosDate, ushort wDosTime, double* pvtime);

@DllImport("OLEAUT32.dll")
int VariantTimeToDosDateTime(double vtime, ushort* pwDosDate, ushort* pwDosTime);

@DllImport("OLEAUT32.dll")
int SystemTimeToVariantTime(SYSTEMTIME* lpSystemTime, double* pvtime);

@DllImport("OLEAUT32.dll")
int VariantTimeToSystemTime(double vtime, SYSTEMTIME* lpSystemTime);

@DllImport("OLEAUT32.dll")
HRESULT SafeArrayAllocDescriptor(uint cDims, SAFEARRAY** ppsaOut);

@DllImport("OLEAUT32.dll")
HRESULT SafeArrayAllocDescriptorEx(ushort vt, uint cDims, SAFEARRAY** ppsaOut);

@DllImport("OLEAUT32.dll")
HRESULT SafeArrayAllocData(SAFEARRAY* psa);

@DllImport("OLEAUT32.dll")
SAFEARRAY* SafeArrayCreate(ushort vt, uint cDims, SAFEARRAYBOUND* rgsabound);

@DllImport("OLEAUT32.dll")
SAFEARRAY* SafeArrayCreateEx(ushort vt, uint cDims, SAFEARRAYBOUND* rgsabound, void* pvExtra);

@DllImport("OLEAUT32.dll")
HRESULT SafeArrayCopyData(SAFEARRAY* psaSource, SAFEARRAY* psaTarget);

@DllImport("OLEAUT32.dll")
void SafeArrayReleaseDescriptor(SAFEARRAY* psa);

@DllImport("OLEAUT32.dll")
HRESULT SafeArrayDestroyDescriptor(SAFEARRAY* psa);

@DllImport("OLEAUT32.dll")
void SafeArrayReleaseData(void* pData);

@DllImport("OLEAUT32.dll")
HRESULT SafeArrayDestroyData(SAFEARRAY* psa);

@DllImport("OLEAUT32.dll")
HRESULT SafeArrayAddRef(SAFEARRAY* psa, void** ppDataToRelease);

@DllImport("OLEAUT32.dll")
HRESULT SafeArrayDestroy(SAFEARRAY* psa);

@DllImport("OLEAUT32.dll")
HRESULT SafeArrayRedim(SAFEARRAY* psa, SAFEARRAYBOUND* psaboundNew);

@DllImport("OLEAUT32.dll")
uint SafeArrayGetDim(SAFEARRAY* psa);

@DllImport("OLEAUT32.dll")
uint SafeArrayGetElemsize(SAFEARRAY* psa);

@DllImport("OLEAUT32.dll")
HRESULT SafeArrayGetUBound(SAFEARRAY* psa, uint nDim, int* plUbound);

@DllImport("OLEAUT32.dll")
HRESULT SafeArrayGetLBound(SAFEARRAY* psa, uint nDim, int* plLbound);

@DllImport("OLEAUT32.dll")
HRESULT SafeArrayLock(SAFEARRAY* psa);

@DllImport("OLEAUT32.dll")
HRESULT SafeArrayUnlock(SAFEARRAY* psa);

@DllImport("OLEAUT32.dll")
HRESULT SafeArrayAccessData(SAFEARRAY* psa, void** ppvData);

@DllImport("OLEAUT32.dll")
HRESULT SafeArrayUnaccessData(SAFEARRAY* psa);

@DllImport("OLEAUT32.dll")
HRESULT SafeArrayGetElement(SAFEARRAY* psa, char* rgIndices, void* pv);

@DllImport("OLEAUT32.dll")
HRESULT SafeArrayPutElement(SAFEARRAY* psa, char* rgIndices, void* pv);

@DllImport("OLEAUT32.dll")
HRESULT SafeArrayCopy(SAFEARRAY* psa, SAFEARRAY** ppsaOut);

@DllImport("OLEAUT32.dll")
HRESULT SafeArrayPtrOfIndex(SAFEARRAY* psa, char* rgIndices, void** ppvData);

@DllImport("OLEAUT32.dll")
HRESULT SafeArraySetRecordInfo(SAFEARRAY* psa, IRecordInfo prinfo);

@DllImport("OLEAUT32.dll")
HRESULT SafeArrayGetRecordInfo(SAFEARRAY* psa, IRecordInfo* prinfo);

@DllImport("OLEAUT32.dll")
HRESULT SafeArraySetIID(SAFEARRAY* psa, const(Guid)* guid);

@DllImport("OLEAUT32.dll")
HRESULT SafeArrayGetIID(SAFEARRAY* psa, Guid* pguid);

@DllImport("OLEAUT32.dll")
HRESULT SafeArrayGetVartype(SAFEARRAY* psa, ushort* pvt);

@DllImport("OLEAUT32.dll")
SAFEARRAY* SafeArrayCreateVector(ushort vt, int lLbound, uint cElements);

@DllImport("OLEAUT32.dll")
SAFEARRAY* SafeArrayCreateVectorEx(ushort vt, int lLbound, uint cElements, void* pvExtra);

@DllImport("OLEAUT32.dll")
void VariantInit(VARIANT* pvarg);

@DllImport("OLEAUT32.dll")
HRESULT VariantClear(VARIANT* pvarg);

@DllImport("OLEAUT32.dll")
HRESULT VariantCopy(VARIANT* pvargDest, const(VARIANT)* pvargSrc);

@DllImport("OLEAUT32.dll")
HRESULT VariantCopyInd(VARIANT* pvarDest, const(VARIANT)* pvargSrc);

@DllImport("OLEAUT32.dll")
HRESULT VariantChangeType(VARIANT* pvargDest, const(VARIANT)* pvarSrc, ushort wFlags, ushort vt);

@DllImport("OLEAUT32.dll")
HRESULT VariantChangeTypeEx(VARIANT* pvargDest, const(VARIANT)* pvarSrc, uint lcid, ushort wFlags, ushort vt);

@DllImport("OLEAUT32.dll")
HRESULT VectorFromBstr(BSTR bstr, SAFEARRAY** ppsa);

@DllImport("OLEAUT32.dll")
HRESULT BstrFromVector(SAFEARRAY* psa, BSTR* pbstr);

@DllImport("OLEAUT32.dll")
HRESULT VarUI1FromI2(short sIn, ubyte* pbOut);

@DllImport("OLEAUT32.dll")
HRESULT VarUI1FromI4(int lIn, ubyte* pbOut);

@DllImport("OLEAUT32.dll")
HRESULT VarUI1FromI8(long i64In, ubyte* pbOut);

@DllImport("OLEAUT32.dll")
HRESULT VarUI1FromR4(float fltIn, ubyte* pbOut);

@DllImport("OLEAUT32.dll")
HRESULT VarUI1FromR8(double dblIn, ubyte* pbOut);

@DllImport("OLEAUT32.dll")
HRESULT VarUI1FromCy(CY cyIn, ubyte* pbOut);

@DllImport("OLEAUT32.dll")
HRESULT VarUI1FromDate(double dateIn, ubyte* pbOut);

@DllImport("OLEAUT32.dll")
HRESULT VarUI1FromStr(ushort* strIn, uint lcid, uint dwFlags, ubyte* pbOut);

@DllImport("OLEAUT32.dll")
HRESULT VarUI1FromDisp(IDispatch pdispIn, uint lcid, ubyte* pbOut);

@DllImport("OLEAUT32.dll")
HRESULT VarUI1FromBool(short boolIn, ubyte* pbOut);

@DllImport("OLEAUT32.dll")
HRESULT VarUI1FromI1(byte cIn, ubyte* pbOut);

@DllImport("OLEAUT32.dll")
HRESULT VarUI1FromUI2(ushort uiIn, ubyte* pbOut);

@DllImport("OLEAUT32.dll")
HRESULT VarUI1FromUI4(uint ulIn, ubyte* pbOut);

@DllImport("OLEAUT32.dll")
HRESULT VarUI1FromUI8(ulong ui64In, ubyte* pbOut);

@DllImport("OLEAUT32.dll")
HRESULT VarUI1FromDec(const(DECIMAL)* pdecIn, ubyte* pbOut);

@DllImport("OLEAUT32.dll")
HRESULT VarI2FromUI1(ubyte bIn, short* psOut);

@DllImport("OLEAUT32.dll")
HRESULT VarI2FromI4(int lIn, short* psOut);

@DllImport("OLEAUT32.dll")
HRESULT VarI2FromI8(long i64In, short* psOut);

@DllImport("OLEAUT32.dll")
HRESULT VarI2FromR4(float fltIn, short* psOut);

@DllImport("OLEAUT32.dll")
HRESULT VarI2FromR8(double dblIn, short* psOut);

@DllImport("OLEAUT32.dll")
HRESULT VarI2FromCy(CY cyIn, short* psOut);

@DllImport("OLEAUT32.dll")
HRESULT VarI2FromDate(double dateIn, short* psOut);

@DllImport("OLEAUT32.dll")
HRESULT VarI2FromStr(ushort* strIn, uint lcid, uint dwFlags, short* psOut);

@DllImport("OLEAUT32.dll")
HRESULT VarI2FromDisp(IDispatch pdispIn, uint lcid, short* psOut);

@DllImport("OLEAUT32.dll")
HRESULT VarI2FromBool(short boolIn, short* psOut);

@DllImport("OLEAUT32.dll")
HRESULT VarI2FromI1(byte cIn, short* psOut);

@DllImport("OLEAUT32.dll")
HRESULT VarI2FromUI2(ushort uiIn, short* psOut);

@DllImport("OLEAUT32.dll")
HRESULT VarI2FromUI4(uint ulIn, short* psOut);

@DllImport("OLEAUT32.dll")
HRESULT VarI2FromUI8(ulong ui64In, short* psOut);

@DllImport("OLEAUT32.dll")
HRESULT VarI2FromDec(const(DECIMAL)* pdecIn, short* psOut);

@DllImport("OLEAUT32.dll")
HRESULT VarI4FromUI1(ubyte bIn, int* plOut);

@DllImport("OLEAUT32.dll")
HRESULT VarI4FromI2(short sIn, int* plOut);

@DllImport("OLEAUT32.dll")
HRESULT VarI4FromI8(long i64In, int* plOut);

@DllImport("OLEAUT32.dll")
HRESULT VarI4FromR4(float fltIn, int* plOut);

@DllImport("OLEAUT32.dll")
HRESULT VarI4FromR8(double dblIn, int* plOut);

@DllImport("OLEAUT32.dll")
HRESULT VarI4FromCy(CY cyIn, int* plOut);

@DllImport("OLEAUT32.dll")
HRESULT VarI4FromDate(double dateIn, int* plOut);

@DllImport("OLEAUT32.dll")
HRESULT VarI4FromStr(ushort* strIn, uint lcid, uint dwFlags, int* plOut);

@DllImport("OLEAUT32.dll")
HRESULT VarI4FromDisp(IDispatch pdispIn, uint lcid, int* plOut);

@DllImport("OLEAUT32.dll")
HRESULT VarI4FromBool(short boolIn, int* plOut);

@DllImport("OLEAUT32.dll")
HRESULT VarI4FromI1(byte cIn, int* plOut);

@DllImport("OLEAUT32.dll")
HRESULT VarI4FromUI2(ushort uiIn, int* plOut);

@DllImport("OLEAUT32.dll")
HRESULT VarI4FromUI4(uint ulIn, int* plOut);

@DllImport("OLEAUT32.dll")
HRESULT VarI4FromUI8(ulong ui64In, int* plOut);

@DllImport("OLEAUT32.dll")
HRESULT VarI4FromDec(const(DECIMAL)* pdecIn, int* plOut);

@DllImport("OLEAUT32.dll")
HRESULT VarI8FromUI1(ubyte bIn, long* pi64Out);

@DllImport("OLEAUT32.dll")
HRESULT VarI8FromI2(short sIn, long* pi64Out);

@DllImport("OLEAUT32.dll")
HRESULT VarI8FromR4(float fltIn, long* pi64Out);

@DllImport("OLEAUT32.dll")
HRESULT VarI8FromR8(double dblIn, long* pi64Out);

@DllImport("OLEAUT32.dll")
HRESULT VarI8FromCy(CY cyIn, long* pi64Out);

@DllImport("OLEAUT32.dll")
HRESULT VarI8FromDate(double dateIn, long* pi64Out);

@DllImport("OLEAUT32.dll")
HRESULT VarI8FromStr(ushort* strIn, uint lcid, uint dwFlags, long* pi64Out);

@DllImport("OLEAUT32.dll")
HRESULT VarI8FromDisp(IDispatch pdispIn, uint lcid, long* pi64Out);

@DllImport("OLEAUT32.dll")
HRESULT VarI8FromBool(short boolIn, long* pi64Out);

@DllImport("OLEAUT32.dll")
HRESULT VarI8FromI1(byte cIn, long* pi64Out);

@DllImport("OLEAUT32.dll")
HRESULT VarI8FromUI2(ushort uiIn, long* pi64Out);

@DllImport("OLEAUT32.dll")
HRESULT VarI8FromUI4(uint ulIn, long* pi64Out);

@DllImport("OLEAUT32.dll")
HRESULT VarI8FromUI8(ulong ui64In, long* pi64Out);

@DllImport("OLEAUT32.dll")
HRESULT VarI8FromDec(const(DECIMAL)* pdecIn, long* pi64Out);

@DllImport("OLEAUT32.dll")
HRESULT VarR4FromUI1(ubyte bIn, float* pfltOut);

@DllImport("OLEAUT32.dll")
HRESULT VarR4FromI2(short sIn, float* pfltOut);

@DllImport("OLEAUT32.dll")
HRESULT VarR4FromI4(int lIn, float* pfltOut);

@DllImport("OLEAUT32.dll")
HRESULT VarR4FromI8(long i64In, float* pfltOut);

@DllImport("OLEAUT32.dll")
HRESULT VarR4FromR8(double dblIn, float* pfltOut);

@DllImport("OLEAUT32.dll")
HRESULT VarR4FromCy(CY cyIn, float* pfltOut);

@DllImport("OLEAUT32.dll")
HRESULT VarR4FromDate(double dateIn, float* pfltOut);

@DllImport("OLEAUT32.dll")
HRESULT VarR4FromStr(ushort* strIn, uint lcid, uint dwFlags, float* pfltOut);

@DllImport("OLEAUT32.dll")
HRESULT VarR4FromDisp(IDispatch pdispIn, uint lcid, float* pfltOut);

@DllImport("OLEAUT32.dll")
HRESULT VarR4FromBool(short boolIn, float* pfltOut);

@DllImport("OLEAUT32.dll")
HRESULT VarR4FromI1(byte cIn, float* pfltOut);

@DllImport("OLEAUT32.dll")
HRESULT VarR4FromUI2(ushort uiIn, float* pfltOut);

@DllImport("OLEAUT32.dll")
HRESULT VarR4FromUI4(uint ulIn, float* pfltOut);

@DllImport("OLEAUT32.dll")
HRESULT VarR4FromUI8(ulong ui64In, float* pfltOut);

@DllImport("OLEAUT32.dll")
HRESULT VarR4FromDec(const(DECIMAL)* pdecIn, float* pfltOut);

@DllImport("OLEAUT32.dll")
HRESULT VarR8FromUI1(ubyte bIn, double* pdblOut);

@DllImport("OLEAUT32.dll")
HRESULT VarR8FromI2(short sIn, double* pdblOut);

@DllImport("OLEAUT32.dll")
HRESULT VarR8FromI4(int lIn, double* pdblOut);

@DllImport("OLEAUT32.dll")
HRESULT VarR8FromI8(long i64In, double* pdblOut);

@DllImport("OLEAUT32.dll")
HRESULT VarR8FromR4(float fltIn, double* pdblOut);

@DllImport("OLEAUT32.dll")
HRESULT VarR8FromCy(CY cyIn, double* pdblOut);

@DllImport("OLEAUT32.dll")
HRESULT VarR8FromDate(double dateIn, double* pdblOut);

@DllImport("OLEAUT32.dll")
HRESULT VarR8FromStr(ushort* strIn, uint lcid, uint dwFlags, double* pdblOut);

@DllImport("OLEAUT32.dll")
HRESULT VarR8FromDisp(IDispatch pdispIn, uint lcid, double* pdblOut);

@DllImport("OLEAUT32.dll")
HRESULT VarR8FromBool(short boolIn, double* pdblOut);

@DllImport("OLEAUT32.dll")
HRESULT VarR8FromI1(byte cIn, double* pdblOut);

@DllImport("OLEAUT32.dll")
HRESULT VarR8FromUI2(ushort uiIn, double* pdblOut);

@DllImport("OLEAUT32.dll")
HRESULT VarR8FromUI4(uint ulIn, double* pdblOut);

@DllImport("OLEAUT32.dll")
HRESULT VarR8FromUI8(ulong ui64In, double* pdblOut);

@DllImport("OLEAUT32.dll")
HRESULT VarR8FromDec(const(DECIMAL)* pdecIn, double* pdblOut);

@DllImport("OLEAUT32.dll")
HRESULT VarDateFromUI1(ubyte bIn, double* pdateOut);

@DllImport("OLEAUT32.dll")
HRESULT VarDateFromI2(short sIn, double* pdateOut);

@DllImport("OLEAUT32.dll")
HRESULT VarDateFromI4(int lIn, double* pdateOut);

@DllImport("OLEAUT32.dll")
HRESULT VarDateFromI8(long i64In, double* pdateOut);

@DllImport("OLEAUT32.dll")
HRESULT VarDateFromR4(float fltIn, double* pdateOut);

@DllImport("OLEAUT32.dll")
HRESULT VarDateFromR8(double dblIn, double* pdateOut);

@DllImport("OLEAUT32.dll")
HRESULT VarDateFromCy(CY cyIn, double* pdateOut);

@DllImport("OLEAUT32.dll")
HRESULT VarDateFromStr(ushort* strIn, uint lcid, uint dwFlags, double* pdateOut);

@DllImport("OLEAUT32.dll")
HRESULT VarDateFromDisp(IDispatch pdispIn, uint lcid, double* pdateOut);

@DllImport("OLEAUT32.dll")
HRESULT VarDateFromBool(short boolIn, double* pdateOut);

@DllImport("OLEAUT32.dll")
HRESULT VarDateFromI1(byte cIn, double* pdateOut);

@DllImport("OLEAUT32.dll")
HRESULT VarDateFromUI2(ushort uiIn, double* pdateOut);

@DllImport("OLEAUT32.dll")
HRESULT VarDateFromUI4(uint ulIn, double* pdateOut);

@DllImport("OLEAUT32.dll")
HRESULT VarDateFromUI8(ulong ui64In, double* pdateOut);

@DllImport("OLEAUT32.dll")
HRESULT VarDateFromDec(const(DECIMAL)* pdecIn, double* pdateOut);

@DllImport("OLEAUT32.dll")
HRESULT VarCyFromUI1(ubyte bIn, CY* pcyOut);

@DllImport("OLEAUT32.dll")
HRESULT VarCyFromI2(short sIn, CY* pcyOut);

@DllImport("OLEAUT32.dll")
HRESULT VarCyFromI4(int lIn, CY* pcyOut);

@DllImport("OLEAUT32.dll")
HRESULT VarCyFromI8(long i64In, CY* pcyOut);

@DllImport("OLEAUT32.dll")
HRESULT VarCyFromR4(float fltIn, CY* pcyOut);

@DllImport("OLEAUT32.dll")
HRESULT VarCyFromR8(double dblIn, CY* pcyOut);

@DllImport("OLEAUT32.dll")
HRESULT VarCyFromDate(double dateIn, CY* pcyOut);

@DllImport("OLEAUT32.dll")
HRESULT VarCyFromStr(ushort* strIn, uint lcid, uint dwFlags, CY* pcyOut);

@DllImport("OLEAUT32.dll")
HRESULT VarCyFromDisp(IDispatch pdispIn, uint lcid, CY* pcyOut);

@DllImport("OLEAUT32.dll")
HRESULT VarCyFromBool(short boolIn, CY* pcyOut);

@DllImport("OLEAUT32.dll")
HRESULT VarCyFromI1(byte cIn, CY* pcyOut);

@DllImport("OLEAUT32.dll")
HRESULT VarCyFromUI2(ushort uiIn, CY* pcyOut);

@DllImport("OLEAUT32.dll")
HRESULT VarCyFromUI4(uint ulIn, CY* pcyOut);

@DllImport("OLEAUT32.dll")
HRESULT VarCyFromUI8(ulong ui64In, CY* pcyOut);

@DllImport("OLEAUT32.dll")
HRESULT VarCyFromDec(const(DECIMAL)* pdecIn, CY* pcyOut);

@DllImport("OLEAUT32.dll")
HRESULT VarBstrFromUI1(ubyte bVal, uint lcid, uint dwFlags, BSTR* pbstrOut);

@DllImport("OLEAUT32.dll")
HRESULT VarBstrFromI2(short iVal, uint lcid, uint dwFlags, BSTR* pbstrOut);

@DllImport("OLEAUT32.dll")
HRESULT VarBstrFromI4(int lIn, uint lcid, uint dwFlags, BSTR* pbstrOut);

@DllImport("OLEAUT32.dll")
HRESULT VarBstrFromI8(long i64In, uint lcid, uint dwFlags, BSTR* pbstrOut);

@DllImport("OLEAUT32.dll")
HRESULT VarBstrFromR4(float fltIn, uint lcid, uint dwFlags, BSTR* pbstrOut);

@DllImport("OLEAUT32.dll")
HRESULT VarBstrFromR8(double dblIn, uint lcid, uint dwFlags, BSTR* pbstrOut);

@DllImport("OLEAUT32.dll")
HRESULT VarBstrFromCy(CY cyIn, uint lcid, uint dwFlags, BSTR* pbstrOut);

@DllImport("OLEAUT32.dll")
HRESULT VarBstrFromDate(double dateIn, uint lcid, uint dwFlags, BSTR* pbstrOut);

@DllImport("OLEAUT32.dll")
HRESULT VarBstrFromDisp(IDispatch pdispIn, uint lcid, uint dwFlags, BSTR* pbstrOut);

@DllImport("OLEAUT32.dll")
HRESULT VarBstrFromBool(short boolIn, uint lcid, uint dwFlags, BSTR* pbstrOut);

@DllImport("OLEAUT32.dll")
HRESULT VarBstrFromI1(byte cIn, uint lcid, uint dwFlags, BSTR* pbstrOut);

@DllImport("OLEAUT32.dll")
HRESULT VarBstrFromUI2(ushort uiIn, uint lcid, uint dwFlags, BSTR* pbstrOut);

@DllImport("OLEAUT32.dll")
HRESULT VarBstrFromUI4(uint ulIn, uint lcid, uint dwFlags, BSTR* pbstrOut);

@DllImport("OLEAUT32.dll")
HRESULT VarBstrFromUI8(ulong ui64In, uint lcid, uint dwFlags, BSTR* pbstrOut);

@DllImport("OLEAUT32.dll")
HRESULT VarBstrFromDec(const(DECIMAL)* pdecIn, uint lcid, uint dwFlags, BSTR* pbstrOut);

@DllImport("OLEAUT32.dll")
HRESULT VarBoolFromUI1(ubyte bIn, short* pboolOut);

@DllImport("OLEAUT32.dll")
HRESULT VarBoolFromI2(short sIn, short* pboolOut);

@DllImport("OLEAUT32.dll")
HRESULT VarBoolFromI4(int lIn, short* pboolOut);

@DllImport("OLEAUT32.dll")
HRESULT VarBoolFromI8(long i64In, short* pboolOut);

@DllImport("OLEAUT32.dll")
HRESULT VarBoolFromR4(float fltIn, short* pboolOut);

@DllImport("OLEAUT32.dll")
HRESULT VarBoolFromR8(double dblIn, short* pboolOut);

@DllImport("OLEAUT32.dll")
HRESULT VarBoolFromDate(double dateIn, short* pboolOut);

@DllImport("OLEAUT32.dll")
HRESULT VarBoolFromCy(CY cyIn, short* pboolOut);

@DllImport("OLEAUT32.dll")
HRESULT VarBoolFromStr(ushort* strIn, uint lcid, uint dwFlags, short* pboolOut);

@DllImport("OLEAUT32.dll")
HRESULT VarBoolFromDisp(IDispatch pdispIn, uint lcid, short* pboolOut);

@DllImport("OLEAUT32.dll")
HRESULT VarBoolFromI1(byte cIn, short* pboolOut);

@DllImport("OLEAUT32.dll")
HRESULT VarBoolFromUI2(ushort uiIn, short* pboolOut);

@DllImport("OLEAUT32.dll")
HRESULT VarBoolFromUI4(uint ulIn, short* pboolOut);

@DllImport("OLEAUT32.dll")
HRESULT VarBoolFromUI8(ulong i64In, short* pboolOut);

@DllImport("OLEAUT32.dll")
HRESULT VarBoolFromDec(const(DECIMAL)* pdecIn, short* pboolOut);

@DllImport("OLEAUT32.dll")
HRESULT VarI1FromUI1(ubyte bIn, byte* pcOut);

@DllImport("OLEAUT32.dll")
HRESULT VarI1FromI2(short uiIn, byte* pcOut);

@DllImport("OLEAUT32.dll")
HRESULT VarI1FromI4(int lIn, byte* pcOut);

@DllImport("OLEAUT32.dll")
HRESULT VarI1FromI8(long i64In, byte* pcOut);

@DllImport("OLEAUT32.dll")
HRESULT VarI1FromR4(float fltIn, byte* pcOut);

@DllImport("OLEAUT32.dll")
HRESULT VarI1FromR8(double dblIn, byte* pcOut);

@DllImport("OLEAUT32.dll")
HRESULT VarI1FromDate(double dateIn, byte* pcOut);

@DllImport("OLEAUT32.dll")
HRESULT VarI1FromCy(CY cyIn, byte* pcOut);

@DllImport("OLEAUT32.dll")
HRESULT VarI1FromStr(ushort* strIn, uint lcid, uint dwFlags, byte* pcOut);

@DllImport("OLEAUT32.dll")
HRESULT VarI1FromDisp(IDispatch pdispIn, uint lcid, byte* pcOut);

@DllImport("OLEAUT32.dll")
HRESULT VarI1FromBool(short boolIn, byte* pcOut);

@DllImport("OLEAUT32.dll")
HRESULT VarI1FromUI2(ushort uiIn, byte* pcOut);

@DllImport("OLEAUT32.dll")
HRESULT VarI1FromUI4(uint ulIn, byte* pcOut);

@DllImport("OLEAUT32.dll")
HRESULT VarI1FromUI8(ulong i64In, byte* pcOut);

@DllImport("OLEAUT32.dll")
HRESULT VarI1FromDec(const(DECIMAL)* pdecIn, byte* pcOut);

@DllImport("OLEAUT32.dll")
HRESULT VarUI2FromUI1(ubyte bIn, ushort* puiOut);

@DllImport("OLEAUT32.dll")
HRESULT VarUI2FromI2(short uiIn, ushort* puiOut);

@DllImport("OLEAUT32.dll")
HRESULT VarUI2FromI4(int lIn, ushort* puiOut);

@DllImport("OLEAUT32.dll")
HRESULT VarUI2FromI8(long i64In, ushort* puiOut);

@DllImport("OLEAUT32.dll")
HRESULT VarUI2FromR4(float fltIn, ushort* puiOut);

@DllImport("OLEAUT32.dll")
HRESULT VarUI2FromR8(double dblIn, ushort* puiOut);

@DllImport("OLEAUT32.dll")
HRESULT VarUI2FromDate(double dateIn, ushort* puiOut);

@DllImport("OLEAUT32.dll")
HRESULT VarUI2FromCy(CY cyIn, ushort* puiOut);

@DllImport("OLEAUT32.dll")
HRESULT VarUI2FromStr(ushort* strIn, uint lcid, uint dwFlags, ushort* puiOut);

@DllImport("OLEAUT32.dll")
HRESULT VarUI2FromDisp(IDispatch pdispIn, uint lcid, ushort* puiOut);

@DllImport("OLEAUT32.dll")
HRESULT VarUI2FromBool(short boolIn, ushort* puiOut);

@DllImport("OLEAUT32.dll")
HRESULT VarUI2FromI1(byte cIn, ushort* puiOut);

@DllImport("OLEAUT32.dll")
HRESULT VarUI2FromUI4(uint ulIn, ushort* puiOut);

@DllImport("OLEAUT32.dll")
HRESULT VarUI2FromUI8(ulong i64In, ushort* puiOut);

@DllImport("OLEAUT32.dll")
HRESULT VarUI2FromDec(const(DECIMAL)* pdecIn, ushort* puiOut);

@DllImport("OLEAUT32.dll")
HRESULT VarUI4FromUI1(ubyte bIn, uint* pulOut);

@DllImport("OLEAUT32.dll")
HRESULT VarUI4FromI2(short uiIn, uint* pulOut);

@DllImport("OLEAUT32.dll")
HRESULT VarUI4FromI4(int lIn, uint* pulOut);

@DllImport("OLEAUT32.dll")
HRESULT VarUI4FromI8(long i64In, uint* plOut);

@DllImport("OLEAUT32.dll")
HRESULT VarUI4FromR4(float fltIn, uint* pulOut);

@DllImport("OLEAUT32.dll")
HRESULT VarUI4FromR8(double dblIn, uint* pulOut);

@DllImport("OLEAUT32.dll")
HRESULT VarUI4FromDate(double dateIn, uint* pulOut);

@DllImport("OLEAUT32.dll")
HRESULT VarUI4FromCy(CY cyIn, uint* pulOut);

@DllImport("OLEAUT32.dll")
HRESULT VarUI4FromStr(ushort* strIn, uint lcid, uint dwFlags, uint* pulOut);

@DllImport("OLEAUT32.dll")
HRESULT VarUI4FromDisp(IDispatch pdispIn, uint lcid, uint* pulOut);

@DllImport("OLEAUT32.dll")
HRESULT VarUI4FromBool(short boolIn, uint* pulOut);

@DllImport("OLEAUT32.dll")
HRESULT VarUI4FromI1(byte cIn, uint* pulOut);

@DllImport("OLEAUT32.dll")
HRESULT VarUI4FromUI2(ushort uiIn, uint* pulOut);

@DllImport("OLEAUT32.dll")
HRESULT VarUI4FromUI8(ulong ui64In, uint* plOut);

@DllImport("OLEAUT32.dll")
HRESULT VarUI4FromDec(const(DECIMAL)* pdecIn, uint* pulOut);

@DllImport("OLEAUT32.dll")
HRESULT VarUI8FromUI1(ubyte bIn, ulong* pi64Out);

@DllImport("OLEAUT32.dll")
HRESULT VarUI8FromI2(short sIn, ulong* pi64Out);

@DllImport("OLEAUT32.dll")
HRESULT VarUI8FromI8(long ui64In, ulong* pi64Out);

@DllImport("OLEAUT32.dll")
HRESULT VarUI8FromR4(float fltIn, ulong* pi64Out);

@DllImport("OLEAUT32.dll")
HRESULT VarUI8FromR8(double dblIn, ulong* pi64Out);

@DllImport("OLEAUT32.dll")
HRESULT VarUI8FromCy(CY cyIn, ulong* pi64Out);

@DllImport("OLEAUT32.dll")
HRESULT VarUI8FromDate(double dateIn, ulong* pi64Out);

@DllImport("OLEAUT32.dll")
HRESULT VarUI8FromStr(ushort* strIn, uint lcid, uint dwFlags, ulong* pi64Out);

@DllImport("OLEAUT32.dll")
HRESULT VarUI8FromDisp(IDispatch pdispIn, uint lcid, ulong* pi64Out);

@DllImport("OLEAUT32.dll")
HRESULT VarUI8FromBool(short boolIn, ulong* pi64Out);

@DllImport("OLEAUT32.dll")
HRESULT VarUI8FromI1(byte cIn, ulong* pi64Out);

@DllImport("OLEAUT32.dll")
HRESULT VarUI8FromUI2(ushort uiIn, ulong* pi64Out);

@DllImport("OLEAUT32.dll")
HRESULT VarUI8FromUI4(uint ulIn, ulong* pi64Out);

@DllImport("OLEAUT32.dll")
HRESULT VarUI8FromDec(const(DECIMAL)* pdecIn, ulong* pi64Out);

@DllImport("OLEAUT32.dll")
HRESULT VarDecFromUI1(ubyte bIn, DECIMAL* pdecOut);

@DllImport("OLEAUT32.dll")
HRESULT VarDecFromI2(short uiIn, DECIMAL* pdecOut);

@DllImport("OLEAUT32.dll")
HRESULT VarDecFromI4(int lIn, DECIMAL* pdecOut);

@DllImport("OLEAUT32.dll")
HRESULT VarDecFromI8(long i64In, DECIMAL* pdecOut);

@DllImport("OLEAUT32.dll")
HRESULT VarDecFromR4(float fltIn, DECIMAL* pdecOut);

@DllImport("OLEAUT32.dll")
HRESULT VarDecFromR8(double dblIn, DECIMAL* pdecOut);

@DllImport("OLEAUT32.dll")
HRESULT VarDecFromDate(double dateIn, DECIMAL* pdecOut);

@DllImport("OLEAUT32.dll")
HRESULT VarDecFromCy(CY cyIn, DECIMAL* pdecOut);

@DllImport("OLEAUT32.dll")
HRESULT VarDecFromStr(ushort* strIn, uint lcid, uint dwFlags, DECIMAL* pdecOut);

@DllImport("OLEAUT32.dll")
HRESULT VarDecFromDisp(IDispatch pdispIn, uint lcid, DECIMAL* pdecOut);

@DllImport("OLEAUT32.dll")
HRESULT VarDecFromBool(short boolIn, DECIMAL* pdecOut);

@DllImport("OLEAUT32.dll")
HRESULT VarDecFromI1(byte cIn, DECIMAL* pdecOut);

@DllImport("OLEAUT32.dll")
HRESULT VarDecFromUI2(ushort uiIn, DECIMAL* pdecOut);

@DllImport("OLEAUT32.dll")
HRESULT VarDecFromUI4(uint ulIn, DECIMAL* pdecOut);

@DllImport("OLEAUT32.dll")
HRESULT VarDecFromUI8(ulong ui64In, DECIMAL* pdecOut);

@DllImport("OLEAUT32.dll")
HRESULT VarParseNumFromStr(ushort* strIn, uint lcid, uint dwFlags, NUMPARSE* pnumprs, char* rgbDig);

@DllImport("OLEAUT32.dll")
HRESULT VarNumFromParseNum(NUMPARSE* pnumprs, char* rgbDig, uint dwVtBits, VARIANT* pvar);

@DllImport("OLEAUT32.dll")
HRESULT VarAdd(VARIANT* pvarLeft, VARIANT* pvarRight, VARIANT* pvarResult);

@DllImport("OLEAUT32.dll")
HRESULT VarAnd(VARIANT* pvarLeft, VARIANT* pvarRight, VARIANT* pvarResult);

@DllImport("OLEAUT32.dll")
HRESULT VarCat(VARIANT* pvarLeft, VARIANT* pvarRight, VARIANT* pvarResult);

@DllImport("OLEAUT32.dll")
HRESULT VarDiv(VARIANT* pvarLeft, VARIANT* pvarRight, VARIANT* pvarResult);

@DllImport("OLEAUT32.dll")
HRESULT VarEqv(VARIANT* pvarLeft, VARIANT* pvarRight, VARIANT* pvarResult);

@DllImport("OLEAUT32.dll")
HRESULT VarIdiv(VARIANT* pvarLeft, VARIANT* pvarRight, VARIANT* pvarResult);

@DllImport("OLEAUT32.dll")
HRESULT VarImp(VARIANT* pvarLeft, VARIANT* pvarRight, VARIANT* pvarResult);

@DllImport("OLEAUT32.dll")
HRESULT VarMod(VARIANT* pvarLeft, VARIANT* pvarRight, VARIANT* pvarResult);

@DllImport("OLEAUT32.dll")
HRESULT VarMul(VARIANT* pvarLeft, VARIANT* pvarRight, VARIANT* pvarResult);

@DllImport("OLEAUT32.dll")
HRESULT VarOr(VARIANT* pvarLeft, VARIANT* pvarRight, VARIANT* pvarResult);

@DllImport("OLEAUT32.dll")
HRESULT VarPow(VARIANT* pvarLeft, VARIANT* pvarRight, VARIANT* pvarResult);

@DllImport("OLEAUT32.dll")
HRESULT VarSub(VARIANT* pvarLeft, VARIANT* pvarRight, VARIANT* pvarResult);

@DllImport("OLEAUT32.dll")
HRESULT VarXor(VARIANT* pvarLeft, VARIANT* pvarRight, VARIANT* pvarResult);

@DllImport("OLEAUT32.dll")
HRESULT VarAbs(VARIANT* pvarIn, VARIANT* pvarResult);

@DllImport("OLEAUT32.dll")
HRESULT VarFix(VARIANT* pvarIn, VARIANT* pvarResult);

@DllImport("OLEAUT32.dll")
HRESULT VarInt(VARIANT* pvarIn, VARIANT* pvarResult);

@DllImport("OLEAUT32.dll")
HRESULT VarNeg(VARIANT* pvarIn, VARIANT* pvarResult);

@DllImport("OLEAUT32.dll")
HRESULT VarNot(VARIANT* pvarIn, VARIANT* pvarResult);

@DllImport("OLEAUT32.dll")
HRESULT VarRound(VARIANT* pvarIn, int cDecimals, VARIANT* pvarResult);

@DllImport("OLEAUT32.dll")
HRESULT VarCmp(VARIANT* pvarLeft, VARIANT* pvarRight, uint lcid, uint dwFlags);

@DllImport("OLEAUT32.dll")
HRESULT VarDecAdd(DECIMAL* pdecLeft, DECIMAL* pdecRight, DECIMAL* pdecResult);

@DllImport("OLEAUT32.dll")
HRESULT VarDecDiv(DECIMAL* pdecLeft, DECIMAL* pdecRight, DECIMAL* pdecResult);

@DllImport("OLEAUT32.dll")
HRESULT VarDecMul(DECIMAL* pdecLeft, DECIMAL* pdecRight, DECIMAL* pdecResult);

@DllImport("OLEAUT32.dll")
HRESULT VarDecSub(DECIMAL* pdecLeft, DECIMAL* pdecRight, DECIMAL* pdecResult);

@DllImport("OLEAUT32.dll")
HRESULT VarDecAbs(DECIMAL* pdecIn, DECIMAL* pdecResult);

@DllImport("OLEAUT32.dll")
HRESULT VarDecFix(DECIMAL* pdecIn, DECIMAL* pdecResult);

@DllImport("OLEAUT32.dll")
HRESULT VarDecInt(DECIMAL* pdecIn, DECIMAL* pdecResult);

@DllImport("OLEAUT32.dll")
HRESULT VarDecNeg(DECIMAL* pdecIn, DECIMAL* pdecResult);

@DllImport("OLEAUT32.dll")
HRESULT VarDecRound(DECIMAL* pdecIn, int cDecimals, DECIMAL* pdecResult);

@DllImport("OLEAUT32.dll")
HRESULT VarDecCmp(DECIMAL* pdecLeft, DECIMAL* pdecRight);

@DllImport("OLEAUT32.dll")
HRESULT VarDecCmpR8(DECIMAL* pdecLeft, double dblRight);

@DllImport("OLEAUT32.dll")
HRESULT VarCyAdd(CY cyLeft, CY cyRight, CY* pcyResult);

@DllImport("OLEAUT32.dll")
HRESULT VarCyMul(CY cyLeft, CY cyRight, CY* pcyResult);

@DllImport("OLEAUT32.dll")
HRESULT VarCyMulI4(CY cyLeft, int lRight, CY* pcyResult);

@DllImport("OLEAUT32.dll")
HRESULT VarCyMulI8(CY cyLeft, long lRight, CY* pcyResult);

@DllImport("OLEAUT32.dll")
HRESULT VarCySub(CY cyLeft, CY cyRight, CY* pcyResult);

@DllImport("OLEAUT32.dll")
HRESULT VarCyAbs(CY cyIn, CY* pcyResult);

@DllImport("OLEAUT32.dll")
HRESULT VarCyFix(CY cyIn, CY* pcyResult);

@DllImport("OLEAUT32.dll")
HRESULT VarCyInt(CY cyIn, CY* pcyResult);

@DllImport("OLEAUT32.dll")
HRESULT VarCyNeg(CY cyIn, CY* pcyResult);

@DllImport("OLEAUT32.dll")
HRESULT VarCyRound(CY cyIn, int cDecimals, CY* pcyResult);

@DllImport("OLEAUT32.dll")
HRESULT VarCyCmp(CY cyLeft, CY cyRight);

@DllImport("OLEAUT32.dll")
HRESULT VarCyCmpR8(CY cyLeft, double dblRight);

@DllImport("OLEAUT32.dll")
HRESULT VarBstrCat(BSTR bstrLeft, BSTR bstrRight, ushort** pbstrResult);

@DllImport("OLEAUT32.dll")
HRESULT VarBstrCmp(BSTR bstrLeft, BSTR bstrRight, uint lcid, uint dwFlags);

@DllImport("OLEAUT32.dll")
HRESULT VarR8Pow(double dblLeft, double dblRight, double* pdblResult);

@DllImport("OLEAUT32.dll")
HRESULT VarR4CmpR8(float fltLeft, double dblRight);

@DllImport("OLEAUT32.dll")
HRESULT VarR8Round(double dblIn, int cDecimals, double* pdblResult);

@DllImport("OLEAUT32.dll")
HRESULT VarDateFromUdate(UDATE* pudateIn, uint dwFlags, double* pdateOut);

@DllImport("OLEAUT32.dll")
HRESULT VarDateFromUdateEx(UDATE* pudateIn, uint lcid, uint dwFlags, double* pdateOut);

@DllImport("OLEAUT32.dll")
HRESULT VarUdateFromDate(double dateIn, uint dwFlags, UDATE* pudateOut);

@DllImport("OLEAUT32.dll")
HRESULT GetAltMonthNames(uint lcid, ushort*** prgp);

@DllImport("OLEAUT32.dll")
HRESULT VarFormat(VARIANT* pvarIn, ushort* pstrFormat, int iFirstDay, int iFirstWeek, uint dwFlags, BSTR* pbstrOut);

@DllImport("OLEAUT32.dll")
HRESULT VarFormatDateTime(VARIANT* pvarIn, int iNamedFormat, uint dwFlags, BSTR* pbstrOut);

@DllImport("OLEAUT32.dll")
HRESULT VarFormatNumber(VARIANT* pvarIn, int iNumDig, int iIncLead, int iUseParens, int iGroup, uint dwFlags, BSTR* pbstrOut);

@DllImport("OLEAUT32.dll")
HRESULT VarFormatPercent(VARIANT* pvarIn, int iNumDig, int iIncLead, int iUseParens, int iGroup, uint dwFlags, BSTR* pbstrOut);

@DllImport("OLEAUT32.dll")
HRESULT VarFormatCurrency(VARIANT* pvarIn, int iNumDig, int iIncLead, int iUseParens, int iGroup, uint dwFlags, BSTR* pbstrOut);

@DllImport("OLEAUT32.dll")
HRESULT VarWeekdayName(int iWeekday, int fAbbrev, int iFirstDay, uint dwFlags, BSTR* pbstrOut);

@DllImport("OLEAUT32.dll")
HRESULT VarMonthName(int iMonth, int fAbbrev, uint dwFlags, BSTR* pbstrOut);

@DllImport("OLEAUT32.dll")
HRESULT VarFormatFromTokens(VARIANT* pvarIn, ushort* pstrFormat, char* pbTokCur, uint dwFlags, BSTR* pbstrOut, uint lcid);

@DllImport("OLEAUT32.dll")
HRESULT VarTokenizeFormatString(ushort* pstrFormat, char* rgbTok, int cbTok, int iFirstDay, int iFirstWeek, uint lcid, int* pcbActual);

@DllImport("OLEAUT32.dll")
uint LHashValOfNameSysA(SYSKIND syskind, uint lcid, const(char)* szName);

@DllImport("OLEAUT32.dll")
uint LHashValOfNameSys(SYSKIND syskind, uint lcid, const(ushort)* szName);

@DllImport("OLEAUT32.dll")
HRESULT LoadTypeLib(ushort* szFile, ITypeLib* pptlib);

@DllImport("OLEAUT32.dll")
HRESULT LoadTypeLibEx(ushort* szFile, REGKIND regkind, ITypeLib* pptlib);

@DllImport("OLEAUT32.dll")
HRESULT LoadRegTypeLib(const(Guid)* rguid, ushort wVerMajor, ushort wVerMinor, uint lcid, ITypeLib* pptlib);

@DllImport("OLEAUT32.dll")
HRESULT QueryPathOfRegTypeLib(const(Guid)* guid, ushort wMaj, ushort wMin, uint lcid, ushort** lpbstrPathName);

@DllImport("OLEAUT32.dll")
HRESULT RegisterTypeLib(ITypeLib ptlib, ushort* szFullPath, ushort* szHelpDir);

@DllImport("OLEAUT32.dll")
HRESULT UnRegisterTypeLib(const(Guid)* libID, ushort wVerMajor, ushort wVerMinor, uint lcid, SYSKIND syskind);

@DllImport("OLEAUT32.dll")
HRESULT RegisterTypeLibForUser(ITypeLib ptlib, ushort* szFullPath, ushort* szHelpDir);

@DllImport("OLEAUT32.dll")
HRESULT UnRegisterTypeLibForUser(const(Guid)* libID, ushort wMajorVerNum, ushort wMinorVerNum, uint lcid, SYSKIND syskind);

@DllImport("OLEAUT32.dll")
HRESULT CreateTypeLib(SYSKIND syskind, ushort* szFile, ICreateTypeLib* ppctlib);

@DllImport("OLEAUT32.dll")
HRESULT CreateTypeLib2(SYSKIND syskind, ushort* szFile, ICreateTypeLib2* ppctlib);

@DllImport("OLEAUT32.dll")
HRESULT DispGetParam(DISPPARAMS* pdispparams, uint position, ushort vtTarg, VARIANT* pvarResult, uint* puArgErr);

@DllImport("OLEAUT32.dll")
HRESULT DispGetIDsOfNames(ITypeInfo ptinfo, char* rgszNames, uint cNames, char* rgdispid);

@DllImport("OLEAUT32.dll")
HRESULT DispInvoke(void* _this, ITypeInfo ptinfo, int dispidMember, ushort wFlags, DISPPARAMS* pparams, VARIANT* pvarResult, EXCEPINFO* pexcepinfo, uint* puArgErr);

@DllImport("OLEAUT32.dll")
HRESULT CreateDispTypeInfo(INTERFACEDATA* pidata, uint lcid, ITypeInfo* pptinfo);

@DllImport("OLEAUT32.dll")
HRESULT CreateStdDispatch(IUnknown punkOuter, void* pvThis, ITypeInfo ptinfo, IUnknown* ppunkStdDisp);

@DllImport("OLEAUT32.dll")
HRESULT DispCallFunc(void* pvInstance, uint oVft, CALLCONV cc, ushort vtReturn, uint cActuals, char* prgvt, char* prgpvarg, VARIANT* pvargResult);

@DllImport("OLEAUT32.dll")
HRESULT RegisterActiveObject(IUnknown punk, const(Guid)* rclsid, uint dwFlags, uint* pdwRegister);

@DllImport("OLEAUT32.dll")
HRESULT RevokeActiveObject(uint dwRegister, void* pvReserved);

@DllImport("OLEAUT32.dll")
HRESULT GetActiveObject(const(Guid)* rclsid, void* pvReserved, IUnknown* ppunk);

@DllImport("OLEAUT32.dll")
HRESULT SetErrorInfo(uint dwReserved, IErrorInfo perrinfo);

@DllImport("OLEAUT32.dll")
HRESULT GetErrorInfo(uint dwReserved, IErrorInfo* pperrinfo);

@DllImport("OLEAUT32.dll")
HRESULT CreateErrorInfo(ICreateErrorInfo* pperrinfo);

@DllImport("OLEAUT32.dll")
HRESULT GetRecordInfoFromTypeInfo(ITypeInfo pTypeInfo, IRecordInfo* ppRecInfo);

@DllImport("OLEAUT32.dll")
HRESULT GetRecordInfoFromGuids(const(Guid)* rGuidTypeLib, uint uVerMajor, uint uVerMinor, uint lcid, const(Guid)* rGuidTypeInfo, IRecordInfo* ppRecInfo);

@DllImport("OLEAUT32.dll")
uint OaBuildVersion();

@DllImport("OLEAUT32.dll")
void ClearCustData(CUSTDATA* pCustData);

@DllImport("OLEAUT32.dll")
void OaEnablePerUserTLibRegistration();

struct SAFEARRAYBOUND
{
    uint cElements;
    int lLbound;
}

struct _wireSAFEARR_BSTR
{
    uint Size;
    FLAGGED_WORD_BLOB** aBstr;
}

struct _wireSAFEARR_UNKNOWN
{
    uint Size;
    IUnknown* apUnknown;
}

struct _wireSAFEARR_DISPATCH
{
    uint Size;
    IDispatch* apDispatch;
}

struct _wireSAFEARR_VARIANT
{
    uint Size;
    _wireVARIANT** aVariant;
}

struct _wireSAFEARR_BRECORD
{
    uint Size;
    _wireBRECORD** aRecord;
}

struct _wireSAFEARR_HAVEIID
{
    uint Size;
    IUnknown* apUnknown;
    Guid iid;
}

enum SF_TYPE
{
    SF_ERROR = 10,
    SF_I1 = 16,
    SF_I2 = 2,
    SF_I4 = 3,
    SF_I8 = 20,
    SF_BSTR = 8,
    SF_UNKNOWN = 13,
    SF_DISPATCH = 9,
    SF_VARIANT = 12,
    SF_RECORD = 36,
    SF_HAVEIID = 32781,
}

struct _wireSAFEARRAY_UNION
{
    uint sfType;
    _u_e__Struct u;
}

struct _wireSAFEARRAY
{
    ushort cDims;
    ushort fFeatures;
    uint cbElements;
    uint cLocks;
    _wireSAFEARRAY_UNION uArrayStructs;
    SAFEARRAYBOUND rgsabound;
}

struct SAFEARRAY
{
    ushort cDims;
    ushort fFeatures;
    uint cbElements;
    uint cLocks;
    void* pvData;
    SAFEARRAYBOUND rgsabound;
}

struct VARIANT
{
    _Anonymous_e__Union Anonymous;
}

struct _wireBRECORD
{
    uint fFlags;
    uint clSize;
    IRecordInfo pRecInfo;
    ubyte* pRecord;
}

struct _wireVARIANT
{
    uint clSize;
    uint rpcReserved;
    ushort vt;
    ushort wReserved1;
    ushort wReserved2;
    ushort wReserved3;
    _Anonymous_e__Union Anonymous;
}

enum TYPEKIND
{
    TKIND_ENUM = 0,
    TKIND_RECORD = 1,
    TKIND_MODULE = 2,
    TKIND_INTERFACE = 3,
    TKIND_DISPATCH = 4,
    TKIND_COCLASS = 5,
    TKIND_ALIAS = 6,
    TKIND_UNION = 7,
    TKIND_MAX = 8,
}

struct TYPEDESC
{
    _Anonymous_e__Union Anonymous;
    ushort vt;
}

struct ARRAYDESC
{
    TYPEDESC tdescElem;
    ushort cDims;
    SAFEARRAYBOUND rgbounds;
}

struct PARAMDESCEX
{
    uint cBytes;
    VARIANT varDefaultValue;
}

struct PARAMDESC
{
    PARAMDESCEX* pparamdescex;
    ushort wParamFlags;
}

struct IDLDESC
{
    uint dwReserved;
    ushort wIDLFlags;
}

struct ELEMDESC
{
    TYPEDESC tdesc;
    _Anonymous_e__Union Anonymous;
}

struct TYPEATTR
{
    Guid guid;
    uint lcid;
    uint dwReserved;
    int memidConstructor;
    int memidDestructor;
    ushort* lpstrSchema;
    uint cbSizeInstance;
    TYPEKIND typekind;
    ushort cFuncs;
    ushort cVars;
    ushort cImplTypes;
    ushort cbSizeVft;
    ushort cbAlignment;
    ushort wTypeFlags;
    ushort wMajorVerNum;
    ushort wMinorVerNum;
    TYPEDESC tdescAlias;
    IDLDESC idldescType;
}

struct DISPPARAMS
{
    VARIANT* rgvarg;
    int* rgdispidNamedArgs;
    uint cArgs;
    uint cNamedArgs;
}

struct EXCEPINFO
{
    ushort wCode;
    ushort wReserved;
    BSTR bstrSource;
    BSTR bstrDescription;
    BSTR bstrHelpFile;
    uint dwHelpContext;
    void* pvReserved;
    HRESULT********** pfnDeferredFillIn;
    int scode;
}

enum CALLCONV
{
    CC_FASTCALL = 0,
    CC_CDECL = 1,
    CC_MSCPASCAL = 2,
    CC_PASCAL = 2,
    CC_MACPASCAL = 3,
    CC_STDCALL = 4,
    CC_FPFASTCALL = 5,
    CC_SYSCALL = 6,
    CC_MPWCDECL = 7,
    CC_MPWPASCAL = 8,
    CC_MAX = 9,
}

enum FUNCKIND
{
    FUNC_VIRTUAL = 0,
    FUNC_PUREVIRTUAL = 1,
    FUNC_NONVIRTUAL = 2,
    FUNC_STATIC = 3,
    FUNC_DISPATCH = 4,
}

enum INVOKEKIND
{
    INVOKE_FUNC = 1,
    INVOKE_PROPERTYGET = 2,
    INVOKE_PROPERTYPUT = 4,
    INVOKE_PROPERTYPUTREF = 8,
}

struct FUNCDESC
{
    int memid;
    int* lprgscode;
    ELEMDESC* lprgelemdescParam;
    FUNCKIND funckind;
    INVOKEKIND invkind;
    CALLCONV callconv;
    short cParams;
    short cParamsOpt;
    short oVft;
    short cScodes;
    ELEMDESC elemdescFunc;
    ushort wFuncFlags;
}

enum VARKIND
{
    VAR_PERINSTANCE = 0,
    VAR_STATIC = 1,
    VAR_CONST = 2,
    VAR_DISPATCH = 3,
}

struct VARDESC
{
    int memid;
    ushort* lpstrSchema;
    _Anonymous_e__Union Anonymous;
    ELEMDESC elemdescVar;
    ushort wVarFlags;
    VARKIND varkind;
}

enum TYPEFLAGS
{
    TYPEFLAG_FAPPOBJECT = 1,
    TYPEFLAG_FCANCREATE = 2,
    TYPEFLAG_FLICENSED = 4,
    TYPEFLAG_FPREDECLID = 8,
    TYPEFLAG_FHIDDEN = 16,
    TYPEFLAG_FCONTROL = 32,
    TYPEFLAG_FDUAL = 64,
    TYPEFLAG_FNONEXTENSIBLE = 128,
    TYPEFLAG_FOLEAUTOMATION = 256,
    TYPEFLAG_FRESTRICTED = 512,
    TYPEFLAG_FAGGREGATABLE = 1024,
    TYPEFLAG_FREPLACEABLE = 2048,
    TYPEFLAG_FDISPATCHABLE = 4096,
    TYPEFLAG_FREVERSEBIND = 8192,
    TYPEFLAG_FPROXY = 16384,
}

enum FUNCFLAGS
{
    FUNCFLAG_FRESTRICTED = 1,
    FUNCFLAG_FSOURCE = 2,
    FUNCFLAG_FBINDABLE = 4,
    FUNCFLAG_FREQUESTEDIT = 8,
    FUNCFLAG_FDISPLAYBIND = 16,
    FUNCFLAG_FDEFAULTBIND = 32,
    FUNCFLAG_FHIDDEN = 64,
    FUNCFLAG_FUSESGETLASTERROR = 128,
    FUNCFLAG_FDEFAULTCOLLELEM = 256,
    FUNCFLAG_FUIDEFAULT = 512,
    FUNCFLAG_FNONBROWSABLE = 1024,
    FUNCFLAG_FREPLACEABLE = 2048,
    FUNCFLAG_FIMMEDIATEBIND = 4096,
}

enum VARFLAGS
{
    VARFLAG_FREADONLY = 1,
    VARFLAG_FSOURCE = 2,
    VARFLAG_FBINDABLE = 4,
    VARFLAG_FREQUESTEDIT = 8,
    VARFLAG_FDISPLAYBIND = 16,
    VARFLAG_FDEFAULTBIND = 32,
    VARFLAG_FHIDDEN = 64,
    VARFLAG_FRESTRICTED = 128,
    VARFLAG_FDEFAULTCOLLELEM = 256,
    VARFLAG_FUIDEFAULT = 512,
    VARFLAG_FNONBROWSABLE = 1024,
    VARFLAG_FREPLACEABLE = 2048,
    VARFLAG_FIMMEDIATEBIND = 4096,
}

struct CLEANLOCALSTORAGE
{
    IUnknown pInterface;
    void* pStorage;
    uint flags;
}

struct CUSTDATAITEM
{
    Guid guid;
    VARIANT varValue;
}

struct CUSTDATA
{
    uint cCustData;
    CUSTDATAITEM* prgCustData;
}

const GUID IID_ICreateTypeInfo = {0x00020405, 0x0000, 0x0000, [0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x46]};
@GUID(0x00020405, 0x0000, 0x0000, [0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x46]);
interface ICreateTypeInfo : IUnknown
{
    HRESULT SetGuid(const(Guid)* guid);
    HRESULT SetTypeFlags(uint uTypeFlags);
    HRESULT SetDocString(ushort* pStrDoc);
    HRESULT SetHelpContext(uint dwHelpContext);
    HRESULT SetVersion(ushort wMajorVerNum, ushort wMinorVerNum);
    HRESULT AddRefTypeInfo(ITypeInfo pTInfo, uint* phRefType);
    HRESULT AddFuncDesc(uint index, FUNCDESC* pFuncDesc);
    HRESULT AddImplType(uint index, uint hRefType);
    HRESULT SetImplTypeFlags(uint index, int implTypeFlags);
    HRESULT SetAlignment(ushort cbAlignment);
    HRESULT SetSchema(ushort* pStrSchema);
    HRESULT AddVarDesc(uint index, VARDESC* pVarDesc);
    HRESULT SetFuncAndParamNames(uint index, char* rgszNames, uint cNames);
    HRESULT SetVarName(uint index, ushort* szName);
    HRESULT SetTypeDescAlias(TYPEDESC* pTDescAlias);
    HRESULT DefineFuncAsDllEntry(uint index, ushort* szDllName, ushort* szProcName);
    HRESULT SetFuncDocString(uint index, ushort* szDocString);
    HRESULT SetVarDocString(uint index, ushort* szDocString);
    HRESULT SetFuncHelpContext(uint index, uint dwHelpContext);
    HRESULT SetVarHelpContext(uint index, uint dwHelpContext);
    HRESULT SetMops(uint index, BSTR bstrMops);
    HRESULT SetTypeIdldesc(IDLDESC* pIdlDesc);
    HRESULT LayOut();
}

const GUID IID_ICreateTypeInfo2 = {0x0002040E, 0x0000, 0x0000, [0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x46]};
@GUID(0x0002040E, 0x0000, 0x0000, [0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x46]);
interface ICreateTypeInfo2 : ICreateTypeInfo
{
    HRESULT DeleteFuncDesc(uint index);
    HRESULT DeleteFuncDescByMemId(int memid, INVOKEKIND invKind);
    HRESULT DeleteVarDesc(uint index);
    HRESULT DeleteVarDescByMemId(int memid);
    HRESULT DeleteImplType(uint index);
    HRESULT SetCustData(const(Guid)* guid, VARIANT* pVarVal);
    HRESULT SetFuncCustData(uint index, const(Guid)* guid, VARIANT* pVarVal);
    HRESULT SetParamCustData(uint indexFunc, uint indexParam, const(Guid)* guid, VARIANT* pVarVal);
    HRESULT SetVarCustData(uint index, const(Guid)* guid, VARIANT* pVarVal);
    HRESULT SetImplTypeCustData(uint index, const(Guid)* guid, VARIANT* pVarVal);
    HRESULT SetHelpStringContext(uint dwHelpStringContext);
    HRESULT SetFuncHelpStringContext(uint index, uint dwHelpStringContext);
    HRESULT SetVarHelpStringContext(uint index, uint dwHelpStringContext);
    HRESULT Invalidate();
    HRESULT SetName(ushort* szName);
}

const GUID IID_ICreateTypeLib = {0x00020406, 0x0000, 0x0000, [0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x46]};
@GUID(0x00020406, 0x0000, 0x0000, [0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x46]);
interface ICreateTypeLib : IUnknown
{
    HRESULT CreateTypeInfo(ushort* szName, TYPEKIND tkind, ICreateTypeInfo* ppCTInfo);
    HRESULT SetName(ushort* szName);
    HRESULT SetVersion(ushort wMajorVerNum, ushort wMinorVerNum);
    HRESULT SetGuid(const(Guid)* guid);
    HRESULT SetDocString(ushort* szDoc);
    HRESULT SetHelpFileName(ushort* szHelpFileName);
    HRESULT SetHelpContext(uint dwHelpContext);
    HRESULT SetLcid(uint lcid);
    HRESULT SetLibFlags(uint uLibFlags);
    HRESULT SaveAllChanges();
}

const GUID IID_ICreateTypeLib2 = {0x0002040F, 0x0000, 0x0000, [0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x46]};
@GUID(0x0002040F, 0x0000, 0x0000, [0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x46]);
interface ICreateTypeLib2 : ICreateTypeLib
{
    HRESULT DeleteTypeInfo(ushort* szName);
    HRESULT SetCustData(const(Guid)* guid, VARIANT* pVarVal);
    HRESULT SetHelpStringContext(uint dwHelpStringContext);
    HRESULT SetHelpStringDll(ushort* szFileName);
}

const GUID IID_IDispatch = {0x00020400, 0x0000, 0x0000, [0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x46]};
@GUID(0x00020400, 0x0000, 0x0000, [0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x46]);
interface IDispatch : IUnknown
{
    HRESULT GetTypeInfoCount(uint* pctinfo);
    HRESULT GetTypeInfo(uint iTInfo, uint lcid, ITypeInfo* ppTInfo);
    HRESULT GetIDsOfNames(const(Guid)* riid, char* rgszNames, uint cNames, uint lcid, char* rgDispId);
    HRESULT Invoke(int dispIdMember, const(Guid)* riid, uint lcid, ushort wFlags, DISPPARAMS* pDispParams, VARIANT* pVarResult, EXCEPINFO* pExcepInfo, uint* puArgErr);
}

const GUID IID_IEnumVARIANT = {0x00020404, 0x0000, 0x0000, [0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x46]};
@GUID(0x00020404, 0x0000, 0x0000, [0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x46]);
interface IEnumVARIANT : IUnknown
{
    HRESULT Next(uint celt, VARIANT* rgVar, uint* pCeltFetched);
    HRESULT Skip(uint celt);
    HRESULT Reset();
    HRESULT Clone(IEnumVARIANT* ppEnum);
}

enum DESCKIND
{
    DESCKIND_NONE = 0,
    DESCKIND_FUNCDESC = 1,
    DESCKIND_VARDESC = 2,
    DESCKIND_TYPECOMP = 3,
    DESCKIND_IMPLICITAPPOBJ = 4,
    DESCKIND_MAX = 5,
}

struct BINDPTR
{
    FUNCDESC* lpfuncdesc;
    VARDESC* lpvardesc;
    ITypeComp lptcomp;
}

const GUID IID_ITypeComp = {0x00020403, 0x0000, 0x0000, [0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x46]};
@GUID(0x00020403, 0x0000, 0x0000, [0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x46]);
interface ITypeComp : IUnknown
{
    HRESULT Bind(ushort* szName, uint lHashVal, ushort wFlags, ITypeInfo* ppTInfo, DESCKIND* pDescKind, BINDPTR* pBindPtr);
    HRESULT BindType(ushort* szName, uint lHashVal, ITypeInfo* ppTInfo, ITypeComp* ppTComp);
}

const GUID IID_ITypeInfo = {0x00020401, 0x0000, 0x0000, [0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x46]};
@GUID(0x00020401, 0x0000, 0x0000, [0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x46]);
interface ITypeInfo : IUnknown
{
    HRESULT GetTypeAttr(TYPEATTR** ppTypeAttr);
    HRESULT GetTypeComp(ITypeComp* ppTComp);
    HRESULT GetFuncDesc(uint index, FUNCDESC** ppFuncDesc);
    HRESULT GetVarDesc(uint index, VARDESC** ppVarDesc);
    HRESULT GetNames(int memid, char* rgBstrNames, uint cMaxNames, uint* pcNames);
    HRESULT GetRefTypeOfImplType(uint index, uint* pRefType);
    HRESULT GetImplTypeFlags(uint index, int* pImplTypeFlags);
    HRESULT GetIDsOfNames(char* rgszNames, uint cNames, int* pMemId);
    HRESULT Invoke(void* pvInstance, int memid, ushort wFlags, DISPPARAMS* pDispParams, VARIANT* pVarResult, EXCEPINFO* pExcepInfo, uint* puArgErr);
    HRESULT GetDocumentation(int memid, BSTR* pBstrName, BSTR* pBstrDocString, uint* pdwHelpContext, BSTR* pBstrHelpFile);
    HRESULT GetDllEntry(int memid, INVOKEKIND invKind, BSTR* pBstrDllName, BSTR* pBstrName, ushort* pwOrdinal);
    HRESULT GetRefTypeInfo(uint hRefType, ITypeInfo* ppTInfo);
    HRESULT AddressOfMember(int memid, INVOKEKIND invKind, void** ppv);
    HRESULT CreateInstance(IUnknown pUnkOuter, const(Guid)* riid, void** ppvObj);
    HRESULT GetMops(int memid, BSTR* pBstrMops);
    HRESULT GetContainingTypeLib(ITypeLib* ppTLib, uint* pIndex);
    void ReleaseTypeAttr(TYPEATTR* pTypeAttr);
    void ReleaseFuncDesc(FUNCDESC* pFuncDesc);
    void ReleaseVarDesc(VARDESC* pVarDesc);
}

const GUID IID_ITypeInfo2 = {0x00020412, 0x0000, 0x0000, [0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x46]};
@GUID(0x00020412, 0x0000, 0x0000, [0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x46]);
interface ITypeInfo2 : ITypeInfo
{
    HRESULT GetTypeKind(TYPEKIND* pTypeKind);
    HRESULT GetTypeFlags(uint* pTypeFlags);
    HRESULT GetFuncIndexOfMemId(int memid, INVOKEKIND invKind, uint* pFuncIndex);
    HRESULT GetVarIndexOfMemId(int memid, uint* pVarIndex);
    HRESULT GetCustData(const(Guid)* guid, VARIANT* pVarVal);
    HRESULT GetFuncCustData(uint index, const(Guid)* guid, VARIANT* pVarVal);
    HRESULT GetParamCustData(uint indexFunc, uint indexParam, const(Guid)* guid, VARIANT* pVarVal);
    HRESULT GetVarCustData(uint index, const(Guid)* guid, VARIANT* pVarVal);
    HRESULT GetImplTypeCustData(uint index, const(Guid)* guid, VARIANT* pVarVal);
    HRESULT GetDocumentation2(int memid, uint lcid, BSTR* pbstrHelpString, uint* pdwHelpStringContext, BSTR* pbstrHelpStringDll);
    HRESULT GetAllCustData(CUSTDATA* pCustData);
    HRESULT GetAllFuncCustData(uint index, CUSTDATA* pCustData);
    HRESULT GetAllParamCustData(uint indexFunc, uint indexParam, CUSTDATA* pCustData);
    HRESULT GetAllVarCustData(uint index, CUSTDATA* pCustData);
    HRESULT GetAllImplTypeCustData(uint index, CUSTDATA* pCustData);
}

enum SYSKIND
{
    SYS_WIN16 = 0,
    SYS_WIN32 = 1,
    SYS_MAC = 2,
    SYS_WIN64 = 3,
}

enum LIBFLAGS
{
    LIBFLAG_FRESTRICTED = 1,
    LIBFLAG_FCONTROL = 2,
    LIBFLAG_FHIDDEN = 4,
    LIBFLAG_FHASDISKIMAGE = 8,
}

struct TLIBATTR
{
    Guid guid;
    uint lcid;
    SYSKIND syskind;
    ushort wMajorVerNum;
    ushort wMinorVerNum;
    ushort wLibFlags;
}

const GUID IID_ITypeLib = {0x00020402, 0x0000, 0x0000, [0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x46]};
@GUID(0x00020402, 0x0000, 0x0000, [0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x46]);
interface ITypeLib : IUnknown
{
    uint GetTypeInfoCount();
    HRESULT GetTypeInfo(uint index, ITypeInfo* ppTInfo);
    HRESULT GetTypeInfoType(uint index, TYPEKIND* pTKind);
    HRESULT GetTypeInfoOfGuid(const(Guid)* guid, ITypeInfo* ppTinfo);
    HRESULT GetLibAttr(TLIBATTR** ppTLibAttr);
    HRESULT GetTypeComp(ITypeComp* ppTComp);
    HRESULT GetDocumentation(int index, BSTR* pBstrName, BSTR* pBstrDocString, uint* pdwHelpContext, BSTR* pBstrHelpFile);
    HRESULT IsName(ushort* szNameBuf, uint lHashVal, int* pfName);
    HRESULT FindName(ushort* szNameBuf, uint lHashVal, ITypeInfo* ppTInfo, int* rgMemId, ushort* pcFound);
    void ReleaseTLibAttr(TLIBATTR* pTLibAttr);
}

const GUID IID_ITypeLib2 = {0x00020411, 0x0000, 0x0000, [0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x46]};
@GUID(0x00020411, 0x0000, 0x0000, [0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x46]);
interface ITypeLib2 : ITypeLib
{
    HRESULT GetCustData(const(Guid)* guid, VARIANT* pVarVal);
    HRESULT GetLibStatistics(uint* pcUniqueNames, uint* pcchUniqueNames);
    HRESULT GetDocumentation2(int index, uint lcid, BSTR* pbstrHelpString, uint* pdwHelpStringContext, BSTR* pbstrHelpStringDll);
    HRESULT GetAllCustData(CUSTDATA* pCustData);
}

enum CHANGEKIND
{
    CHANGEKIND_ADDMEMBER = 0,
    CHANGEKIND_DELETEMEMBER = 1,
    CHANGEKIND_SETNAMES = 2,
    CHANGEKIND_SETDOCUMENTATION = 3,
    CHANGEKIND_GENERAL = 4,
    CHANGEKIND_INVALIDATE = 5,
    CHANGEKIND_CHANGEFAILED = 6,
    CHANGEKIND_MAX = 7,
}

const GUID IID_ITypeChangeEvents = {0x00020410, 0x0000, 0x0000, [0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x46]};
@GUID(0x00020410, 0x0000, 0x0000, [0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x46]);
interface ITypeChangeEvents : IUnknown
{
    HRESULT RequestTypeChange(CHANGEKIND changeKind, ITypeInfo pTInfoBefore, ushort* pStrName, int* pfCancel);
    HRESULT AfterTypeChange(CHANGEKIND changeKind, ITypeInfo pTInfoAfter, ushort* pStrName);
}

const GUID IID_IErrorInfo = {0x1CF2B120, 0x547D, 0x101B, [0x8E, 0x65, 0x08, 0x00, 0x2B, 0x2B, 0xD1, 0x19]};
@GUID(0x1CF2B120, 0x547D, 0x101B, [0x8E, 0x65, 0x08, 0x00, 0x2B, 0x2B, 0xD1, 0x19]);
interface IErrorInfo : IUnknown
{
    HRESULT GetGUID(Guid* pGUID);
    HRESULT GetSource(BSTR* pBstrSource);
    HRESULT GetDescription(BSTR* pBstrDescription);
    HRESULT GetHelpFile(BSTR* pBstrHelpFile);
    HRESULT GetHelpContext(uint* pdwHelpContext);
}

const GUID IID_ICreateErrorInfo = {0x22F03340, 0x547D, 0x101B, [0x8E, 0x65, 0x08, 0x00, 0x2B, 0x2B, 0xD1, 0x19]};
@GUID(0x22F03340, 0x547D, 0x101B, [0x8E, 0x65, 0x08, 0x00, 0x2B, 0x2B, 0xD1, 0x19]);
interface ICreateErrorInfo : IUnknown
{
    HRESULT SetGUID(const(Guid)* rguid);
    HRESULT SetSource(ushort* szSource);
    HRESULT SetDescription(ushort* szDescription);
    HRESULT SetHelpFile(ushort* szHelpFile);
    HRESULT SetHelpContext(uint dwHelpContext);
}

const GUID IID_ISupportErrorInfo = {0xDF0B3D60, 0x548F, 0x101B, [0x8E, 0x65, 0x08, 0x00, 0x2B, 0x2B, 0xD1, 0x19]};
@GUID(0xDF0B3D60, 0x548F, 0x101B, [0x8E, 0x65, 0x08, 0x00, 0x2B, 0x2B, 0xD1, 0x19]);
interface ISupportErrorInfo : IUnknown
{
    HRESULT InterfaceSupportsErrorInfo(const(Guid)* riid);
}

const GUID IID_ITypeFactory = {0x0000002E, 0x0000, 0x0000, [0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x46]};
@GUID(0x0000002E, 0x0000, 0x0000, [0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x46]);
interface ITypeFactory : IUnknown
{
    HRESULT CreateFromTypeInfo(ITypeInfo pTypeInfo, const(Guid)* riid, IUnknown* ppv);
}

const GUID IID_ITypeMarshal = {0x0000002D, 0x0000, 0x0000, [0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x46]};
@GUID(0x0000002D, 0x0000, 0x0000, [0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x46]);
interface ITypeMarshal : IUnknown
{
    HRESULT Size(void* pvType, uint dwDestContext, void* pvDestContext, uint* pSize);
    HRESULT Marshal(void* pvType, uint dwDestContext, void* pvDestContext, uint cbBufferLength, char* pBuffer, uint* pcbWritten);
    HRESULT Unmarshal(void* pvType, uint dwFlags, uint cbBufferLength, char* pBuffer, uint* pcbRead);
    HRESULT Free(void* pvType);
}

const GUID IID_IRecordInfo = {0x0000002F, 0x0000, 0x0000, [0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x46]};
@GUID(0x0000002F, 0x0000, 0x0000, [0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x46]);
interface IRecordInfo : IUnknown
{
    HRESULT RecordInit(void* pvNew);
    HRESULT RecordClear(void* pvExisting);
    HRESULT RecordCopy(void* pvExisting, void* pvNew);
    HRESULT GetGuid(Guid* pguid);
    HRESULT GetName(BSTR* pbstrName);
    HRESULT GetSize(uint* pcbSize);
    HRESULT GetTypeInfo(ITypeInfo* ppTypeInfo);
    HRESULT GetField(void* pvData, ushort* szFieldName, VARIANT* pvarField);
    HRESULT GetFieldNoCopy(void* pvData, ushort* szFieldName, VARIANT* pvarField, void** ppvDataCArray);
    HRESULT PutField(uint wFlags, void* pvData, ushort* szFieldName, VARIANT* pvarField);
    HRESULT PutFieldNoCopy(uint wFlags, void* pvData, ushort* szFieldName, VARIANT* pvarField);
    HRESULT GetFieldNames(uint* pcNames, char* rgBstrNames);
    BOOL IsMatchingType(IRecordInfo pRecordInfo);
    void* RecordCreate();
    HRESULT RecordCreateCopy(void* pvSource, void** ppvDest);
    HRESULT RecordDestroy(void* pvRecord);
}

const GUID IID_IErrorLog = {0x3127CA40, 0x446E, 0x11CE, [0x81, 0x35, 0x00, 0xAA, 0x00, 0x4B, 0xB8, 0x51]};
@GUID(0x3127CA40, 0x446E, 0x11CE, [0x81, 0x35, 0x00, 0xAA, 0x00, 0x4B, 0xB8, 0x51]);
interface IErrorLog : IUnknown
{
    HRESULT AddError(ushort* pszPropName, EXCEPINFO* pExcepInfo);
}

const GUID IID_IPropertyBag = {0x55272A00, 0x42CB, 0x11CE, [0x81, 0x35, 0x00, 0xAA, 0x00, 0x4B, 0xB8, 0x51]};
@GUID(0x55272A00, 0x42CB, 0x11CE, [0x81, 0x35, 0x00, 0xAA, 0x00, 0x4B, 0xB8, 0x51]);
interface IPropertyBag : IUnknown
{
    HRESULT Read(ushort* pszPropName, VARIANT* pVar, IErrorLog pErrorLog);
    HRESULT Write(ushort* pszPropName, VARIANT* pVar);
}

const GUID IID_ITypeLibRegistrationReader = {0xED6A8A2A, 0xB160, 0x4E77, [0x8F, 0x73, 0xAA, 0x74, 0x35, 0xCD, 0x5C, 0x27]};
@GUID(0xED6A8A2A, 0xB160, 0x4E77, [0x8F, 0x73, 0xAA, 0x74, 0x35, 0xCD, 0x5C, 0x27]);
interface ITypeLibRegistrationReader : IUnknown
{
    HRESULT EnumTypeLibRegistrations(IEnumUnknown* ppEnumUnknown);
}

const GUID IID_ITypeLibRegistration = {0x76A3E735, 0x02DF, 0x4A12, [0x98, 0xEB, 0x04, 0x3A, 0xD3, 0x60, 0x0A, 0xF3]};
@GUID(0x76A3E735, 0x02DF, 0x4A12, [0x98, 0xEB, 0x04, 0x3A, 0xD3, 0x60, 0x0A, 0xF3]);
interface ITypeLibRegistration : IUnknown
{
    HRESULT GetGuid(Guid* pGuid);
    HRESULT GetVersion(BSTR* pVersion);
    HRESULT GetLcid(uint* pLcid);
    HRESULT GetWin32Path(BSTR* pWin32Path);
    HRESULT GetWin64Path(BSTR* pWin64Path);
    HRESULT GetDisplayName(BSTR* pDisplayName);
    HRESULT GetFlags(uint* pFlags);
    HRESULT GetHelpDir(BSTR* pHelpDir);
}

struct NUMPARSE
{
    int cDig;
    uint dwInFlags;
    uint dwOutFlags;
    int cchUsed;
    int nBaseShift;
    int nPwr10;
}

struct UDATE
{
    SYSTEMTIME st;
    ushort wDayOfYear;
}

enum REGKIND
{
    REGKIND_DEFAULT = 0,
    REGKIND_REGISTER = 1,
    REGKIND_NONE = 2,
}

struct PARAMDATA
{
    ushort* szName;
    ushort vt;
}

struct METHODDATA
{
    ushort* szName;
    PARAMDATA* ppdata;
    int dispid;
    uint iMeth;
    CALLCONV cc;
    uint cArgs;
    ushort wFlags;
    ushort vtReturn;
}

struct INTERFACEDATA
{
    METHODDATA* pmethdata;
    uint cMembers;
}

const GUID CLSID_WiaDevMgr = {0xA1F4E726, 0x8CF1, 0x11D1, [0xBF, 0x92, 0x00, 0x60, 0x08, 0x1E, 0xD8, 0x11]};
@GUID(0xA1F4E726, 0x8CF1, 0x11D1, [0xBF, 0x92, 0x00, 0x60, 0x08, 0x1E, 0xD8, 0x11]);
struct WiaDevMgr;

const GUID CLSID_WiaLog = {0xA1E75357, 0x881A, 0x419E, [0x83, 0xE2, 0xBB, 0x16, 0xDB, 0x19, 0x7C, 0x68]};
@GUID(0xA1E75357, 0x881A, 0x419E, [0x83, 0xE2, 0xBB, 0x16, 0xDB, 0x19, 0x7C, 0x68]);
struct WiaLog;

struct WIA_RAW_HEADER
{
    uint Tag;
    uint Version;
    uint HeaderSize;
    uint XRes;
    uint YRes;
    uint XExtent;
    uint YExtent;
    uint BytesPerLine;
    uint BitsPerPixel;
    uint ChannelsPerPixel;
    uint DataType;
    ubyte BitsPerChannel;
    uint Compression;
    uint PhotometricInterp;
    uint LineOrder;
    uint RawDataOffset;
    uint RawDataSize;
    uint PaletteOffset;
    uint PaletteSize;
}

struct WIA_BARCODE_INFO
{
    uint Size;
    uint Type;
    uint Page;
    uint Confidence;
    uint XOffset;
    uint YOffset;
    uint Rotation;
    uint Length;
    ushort Text;
}

struct WIA_BARCODES
{
    uint Tag;
    uint Version;
    uint Size;
    uint Count;
    WIA_BARCODE_INFO Barcodes;
}

struct WIA_PATCH_CODE_INFO
{
    uint Type;
}

struct WIA_PATCH_CODES
{
    uint Tag;
    uint Version;
    uint Size;
    uint Count;
    WIA_PATCH_CODE_INFO PatchCodes;
}

struct WIA_MICR_INFO
{
    uint Size;
    uint Page;
    uint Length;
    ushort Text;
}

struct WIA_MICR
{
    uint Tag;
    uint Version;
    uint Size;
    ushort Placeholder;
    ushort Reserved;
    uint Count;
    WIA_MICR_INFO Micr;
}

const GUID IID_IDispatchEx = {0xA6EF9860, 0xC720, 0x11D0, [0x93, 0x37, 0x00, 0xA0, 0xC9, 0x0D, 0xCA, 0xA9]};
@GUID(0xA6EF9860, 0xC720, 0x11D0, [0x93, 0x37, 0x00, 0xA0, 0xC9, 0x0D, 0xCA, 0xA9]);
interface IDispatchEx : IDispatch
{
    HRESULT GetDispID(BSTR bstrName, uint grfdex, int* pid);
    HRESULT InvokeEx(int id, uint lcid, ushort wFlags, DISPPARAMS* pdp, VARIANT* pvarRes, EXCEPINFO* pei, IServiceProvider pspCaller);
    HRESULT DeleteMemberByName(BSTR bstrName, uint grfdex);
    HRESULT DeleteMemberByDispID(int id);
    HRESULT GetMemberProperties(int id, uint grfdexFetch, uint* pgrfdex);
    HRESULT GetMemberName(int id, BSTR* pbstrName);
    HRESULT GetNextDispID(uint grfdex, int id, int* pid);
    HRESULT GetNameSpaceParent(IUnknown* ppunk);
}

const GUID IID_IDispError = {0xA6EF9861, 0xC720, 0x11D0, [0x93, 0x37, 0x00, 0xA0, 0xC9, 0x0D, 0xCA, 0xA9]};
@GUID(0xA6EF9861, 0xC720, 0x11D0, [0x93, 0x37, 0x00, 0xA0, 0xC9, 0x0D, 0xCA, 0xA9]);
interface IDispError : IUnknown
{
    HRESULT QueryErrorInfo(Guid guidErrorType, IDispError* ppde);
    HRESULT GetNext(IDispError* ppde);
    HRESULT GetHresult(int* phr);
    HRESULT GetSource(BSTR* pbstrSource);
    HRESULT GetHelpInfo(BSTR* pbstrFileName, uint* pdwContext);
    HRESULT GetDescription(BSTR* pbstrDescription);
}

const GUID IID_IVariantChangeType = {0xA6EF9862, 0xC720, 0x11D0, [0x93, 0x37, 0x00, 0xA0, 0xC9, 0x0D, 0xCA, 0xA9]};
@GUID(0xA6EF9862, 0xC720, 0x11D0, [0x93, 0x37, 0x00, 0xA0, 0xC9, 0x0D, 0xCA, 0xA9]);
interface IVariantChangeType : IUnknown
{
    HRESULT ChangeType(VARIANT* pvarDst, VARIANT* pvarSrc, uint lcid, ushort vtNew);
}

const GUID IID_IObjectIdentity = {0xCA04B7E6, 0x0D21, 0x11D1, [0x8C, 0xC5, 0x00, 0xC0, 0x4F, 0xC2, 0xB0, 0x85]};
@GUID(0xCA04B7E6, 0x0D21, 0x11D1, [0x8C, 0xC5, 0x00, 0xC0, 0x4F, 0xC2, 0xB0, 0x85]);
interface IObjectIdentity : IUnknown
{
    HRESULT IsEqualObject(IUnknown punk);
}

const GUID IID_ICanHandleException = {0xC5598E60, 0xB307, 0x11D1, [0xB2, 0x7D, 0x00, 0x60, 0x08, 0xC3, 0xFB, 0xFB]};
@GUID(0xC5598E60, 0xB307, 0x11D1, [0xB2, 0x7D, 0x00, 0x60, 0x08, 0xC3, 0xFB, 0xFB]);
interface ICanHandleException : IUnknown
{
    HRESULT CanHandleException(EXCEPINFO* pExcepInfo, VARIANT* pvar);
}

const GUID IID_IProvideRuntimeContext = {0x10E2414A, 0xEC59, 0x49D2, [0xBC, 0x51, 0x5A, 0xDD, 0x2C, 0x36, 0xFE, 0xBC]};
@GUID(0x10E2414A, 0xEC59, 0x49D2, [0xBC, 0x51, 0x5A, 0xDD, 0x2C, 0x36, 0xFE, 0xBC]);
interface IProvideRuntimeContext : IUnknown
{
    HRESULT GetCurrentSourceContext(uint* pdwContext, short* pfExecutingGlobalCode);
}

alias BSTR = int;
enum VARENUM
{
    VT_EMPTY = 0,
    VT_NULL = 1,
    VT_I2 = 2,
    VT_I4 = 3,
    VT_R4 = 4,
    VT_R8 = 5,
    VT_CY = 6,
    VT_DATE = 7,
    VT_BSTR = 8,
    VT_DISPATCH = 9,
    VT_ERROR = 10,
    VT_BOOL = 11,
    VT_VARIANT = 12,
    VT_UNKNOWN = 13,
    VT_DECIMAL = 14,
    VT_I1 = 16,
    VT_UI1 = 17,
    VT_UI2 = 18,
    VT_UI4 = 19,
    VT_I8 = 20,
    VT_UI8 = 21,
    VT_INT = 22,
    VT_UINT = 23,
    VT_VOID = 24,
    VT_HRESULT = 25,
    VT_PTR = 26,
    VT_SAFEARRAY = 27,
    VT_CARRAY = 28,
    VT_USERDEFINED = 29,
    VT_LPSTR = 30,
    VT_LPWSTR = 31,
    VT_RECORD = 36,
    VT_INT_PTR = 37,
    VT_UINT_PTR = 38,
    VT_FILETIME = 64,
    VT_BLOB = 65,
    VT_STREAM = 66,
    VT_STORAGE = 67,
    VT_STREAMED_OBJECT = 68,
    VT_STORED_OBJECT = 69,
    VT_BLOB_OBJECT = 70,
    VT_CF = 71,
    VT_CLSID = 72,
    VT_VERSIONED_STREAM = 73,
    VT_BSTR_BLOB = 4095,
    VT_VECTOR = 4096,
    VT_ARRAY = 8192,
    VT_BYREF = 16384,
    VT_RESERVED = 32768,
    VT_ILLEGAL = 65535,
    VT_ILLEGALMASKED = 4095,
    VT_TYPEMASK = 4095,
}

